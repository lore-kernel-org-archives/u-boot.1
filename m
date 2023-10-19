Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DA2CDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5317787225;
	Thu, 19 Oct 2023 16:31:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F56F871E8; Thu, 19 Oct 2023 16:31:03 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 70A3C85423
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,237,1694703600"; d="scan'208";a="183671898"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 19 Oct 2023 23:30:57 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.46])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2C59E4005B25;
 Thu, 19 Oct 2023 23:30:54 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>
Subject: [PATCH v4 1/2] serial: sh: Fix error handling
Date: Thu, 19 Oct 2023 15:30:43 +0100
Message-Id: <20231019143044.1363-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231019143044.1363-1-paul.barker.ct@bp.renesas.com>
References: <20231019143044.1363-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The current SCIF error handling is broken for the RZ/G2L. After a break
condition has been triggered, the current code is unable to clear the
error and serial port output never resumes.

The RZ/G2L datasheet says that most error conditions are cleared by
resetting the relevant error bits in the FSR & LSR registers to zero.
To clear framing errors on SCIF ports, the invalid data also needs to be
read out of the receive FIFO.

After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3
and even SH7751 SoCs, it's clear that this is the way to clear errors
for all of these SoCs.

While we're here, annotate the handle_error() function with a couple of
comments as the reads and writes themselves don't immediately make it
clear what we're doing.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Tested-by: Chris Paterson <chris.paterson2@renesas.com>
	# HiHope RZ/G2M board
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
	# R-Car H3 Salvator-XS

v3->v4:
  * Don't assume that all the world is a SCIF - handle SCI ports
    correctly as well.
v2->v3:
  * Added Chris' and Marek's Tested-by.
v1->v2:
  * New patch after discussion with Marek & further investigation.
---
 drivers/serial/serial_sh.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 36263109e6b8..9a698b19ccde 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -79,10 +79,22 @@ sh_serial_setbrg_generic(struct uart_port *port, int clk, int baudrate)
 
 static void handle_error(struct uart_port *port)
 {
-	sci_in(port, SCxSR);
-	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
+	/*
+	 * Most errors are cleared by resetting the relevant error bits to zero
+	 * in the FSR & LSR registers. For each register, a read followed by a
+	 * write is needed according to the relevant datasheets.
+	 */
+	unsigned short status = sci_in(port, SCxSR);
+	sci_out(port, SCxSR, status & ~SCxSR_ERRORS(port));
 	sci_in(port, SCLSR);
 	sci_out(port, SCLSR, 0x00);
+
+	/*
+	 * To clear framing errors, we also need to read and discard a
+	 * character.
+	 */
+	if ((port->type != PORT_SCI) && (status & SCIF_FER))
+		sci_in(port, SCxRDR);
 }
 
 static int serial_raw_putc(struct uart_port *port, const char c)
-- 
2.39.2

