Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29DFCD610D
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 16:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E36286E05;
	Mon,  9 Oct 2023 18:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CD786DE6; Mon,  9 Oct 2023 18:47:38 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id E0A3186DAF
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 18:47:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,210,1694703600"; d="scan'208";a="178655046"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 10 Oct 2023 01:47:34 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.229])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6C989402A8DA;
 Tue, 10 Oct 2023 01:47:32 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Subject: [PATCH v2 11/19] serial: sh: Fix error handling
Date: Mon,  9 Oct 2023 17:46:37 +0100
Message-Id: <20231009164645.164464-12-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
References: <20231009164645.164464-1-paul.barker.ct@bp.renesas.com>
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
To clear framing errors, the invalid data also needs to be read out of
the receive FIFO.

After reviewing datasheets for RZ/G2{H,M,N,E}, R-Car Gen4, R-Car Gen3
and even SH7751 SoCs, it's clear that this is the way to clear errors
for all of these SoCs.

While we're here, annotate the handle_error() function with a couple of
comments as the reads and writes themselves don't immediately make it
clear what we're doing.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
v1->v2:
  * New patch after discussion with Marek & further investigation.

I'm not going to put a `Fixes` tag on this, the error handling has been
writing ones to clear errors since at least 2007 so maybe it was
originally right for some board. It doesn't seem to apply to any of the
current users of the SCIF driver though.

 drivers/serial/serial_sh.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 5e543dbf3d58..2b650d458e71 100644
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
+	sci_out(port, SCxSR, status & ~SCIF_ERRORS);
 	sci_in(port, SCLSR);
 	sci_out(port, SCLSR, 0x00);
+
+	/*
+	 * To clear framing errors, we also need to read and discard a
+	 * character.
+	 */
+	if (status & SCIF_FER)
+		sci_in(port, SCxRDR);
 }
 
 static int serial_raw_putc(struct uart_port *port, const char c)
-- 
2.39.2

