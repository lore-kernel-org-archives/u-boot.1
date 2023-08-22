Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E5BEE49AE
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 049578648E;
	Tue, 22 Aug 2023 20:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03137864A8; Tue, 22 Aug 2023 20:10:44 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 926CC86478
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.01,193,1684767600"; d="scan'208";a="173605714"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 23 Aug 2023 03:10:37 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.37])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id B4F93406ED4D;
 Wed, 23 Aug 2023 03:10:35 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/2] serial: sh: Fix compile error when lacking HSCIF support
Date: Tue, 22 Aug 2023 19:10:23 +0100
Message-Id: <20230822181025.339748-2-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
References: <20230822181025.339748-1-paul.barker.ct@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

If we attempt to compile serial_sh.c for a system which lacks HSCIF
support (e.g. R8A7740), we see the following compilation error:

    In file included from drivers/serial/serial_sh.c:20:
    drivers/serial/serial_sh.c: In function ‘sh_serial_init_generic’:
    drivers/serial/serial_sh.h:429:35: warning: implicit declaration of function ‘sci_HSSRR_out’; did you mean ‘sci_SCSCR_out’? [-Wimplicit-function-declaration]
      429 | #define sci_out(port, reg, value) sci_##reg##_out(port, value)
          |                                   ^~~~
    drivers/serial/serial_sh.c:62:17: note: in expansion of macro ‘sci_out’
       62 |                 sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
          |                 ^~~~~~~

To fix this, only try to support access to the HSSRR register for SoCs
where it actually exists.

Fixes: bbe36e29ca2c ('serial: sh: Add HSCIF support for R-Car SoC')
Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Simon Glass <sjg@chromium.org>
---
 drivers/serial/serial_sh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 20cda5dbe272..cd9bcf4f0a25 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -58,8 +58,10 @@ static void sh_serial_init_generic(struct uart_port *port)
 	sci_out(port, SCSPTR, 0x0003);
 #endif
 
+#if defined(CONFIG_RCAR_GEN2) || defined(CONFIG_RCAR_GEN3) || defined(CONFIG_RCAR_GEN4)
 	if (port->type == PORT_HSCIF)
 		sci_out(port, HSSRR, HSSRR_SRE | HSSRR_SRCYC8);
+#endif
 }
 
 static void
-- 
2.34.1

