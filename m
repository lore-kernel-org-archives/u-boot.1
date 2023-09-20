Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D436CE79D0
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 12:44:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9612867D6;
	Wed, 20 Sep 2023 14:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 306D986BE6; Wed, 20 Sep 2023 14:43:12 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 496FE86BE7
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 14:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,162,1694703600"; d="scan'208";a="180389794"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 20 Sep 2023 21:43:03 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.92.83])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id F2486433CFB9;
 Wed, 20 Sep 2023 21:43:00 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 10/16] serial: sh: Add RZ/G2L SCIF support
Date: Wed, 20 Sep 2023 13:42:06 +0100
Message-Id: <20230920124212.63535-11-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
References: <20230920124212.63535-1-paul.barker.ct@bp.renesas.com>
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

Extend the existing driver to support the SCIF serial ports on the
Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that the
relevant reset signal is de-asserted before we try to talk to the SCIF
module.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-rmobile/Kconfig |  1 +
 drivers/serial/serial_sh.c    | 32 ++++++++++++++++++++++++++++++--
 drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 973e84fcf7ba..0ab22356aee5 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -77,6 +77,7 @@ config RZG2L
 	imply RENESAS_SDHI
 	imply CLK_RZG2L
 	imply PINCTRL_RZG2L
+	imply SCIF_CONSOLE
 	help
 	  Enable support for the Renesas RZ/G2L family of SoCs, including the
 	  the RZ/G2L itself (based on the R9A07G044 SoC).
diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 5e543dbf3d58..a2e9a57137a6 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -17,6 +17,8 @@
 #include <linux/compiler.h>
 #include <dm/platform_data/serial_sh.h>
 #include <linux/delay.h>
+#include <dm/device_compat.h>
+#include <reset.h>
 #include "serial_sh.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -79,8 +81,16 @@ sh_serial_setbrg_generic(struct uart_port *port, int clk, int baudrate)
 
 static void handle_error(struct uart_port *port)
 {
-	sci_in(port, SCxSR);
-	sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
+	/* The RZ/G2L datasheet says that error conditions are cleared by
+	 * resetting the error bits in the FSR register to zero.
+	 */
+	if (IS_ENABLED(CONFIG_RZG2L)) {
+		unsigned short status = sci_in(port, SCxSR);
+		sci_out(port, SCxSR, status & ~SCIF_ERRORS);
+	} else {
+		sci_in(port, SCxSR);
+		sci_out(port, SCxSR, SCxSR_ERROR_CLEAR(port));
+	}
 	sci_in(port, SCLSR);
 	sci_out(port, SCLSR, 0x00);
 }
@@ -193,6 +203,23 @@ static int sh_serial_probe(struct udevice *dev)
 	priv->type	= plat->type;
 	priv->clk_mode	= plat->clk_mode;
 
+	if (IS_ENABLED(CONFIG_RZG2L)) {
+		struct reset_ctl rst;
+		int ret;
+
+		ret = reset_get_by_index(dev, 0, &rst);
+		if (ret < 0) {
+			dev_err(dev, "failed to get reset line\n");
+			return ret;
+		}
+
+		ret = reset_deassert(&rst);
+		if (ret < 0) {
+			dev_err(dev, "failed to de-assert reset line\n");
+			return ret;
+		}
+	}
+
 	sh_serial_init_generic(priv);
 
 	return 0;
@@ -211,6 +238,7 @@ static const struct udevice_id sh_serial_id[] ={
 	{.compatible = "renesas,scif", .data = PORT_SCIF},
 	{.compatible = "renesas,scifa", .data = PORT_SCIFA},
 	{.compatible = "renesas,hscif", .data = PORT_HSCIF},
+	{.compatible = "renesas,scif-r9a07g044", .data = PORT_SCIFA},
 	{}
 };
 
diff --git a/drivers/serial/serial_sh.h b/drivers/serial/serial_sh.h
index 149ec1fe7397..58c2d22bc757 100644
--- a/drivers/serial/serial_sh.h
+++ b/drivers/serial/serial_sh.h
@@ -90,7 +90,7 @@ struct uart_port {
 # define SCSCR_INIT(port)	0x38 /* TIE=0,RIE=0,TE=1,RE=1,REIE=1 */
 # define SCIF_ORER 0x0001  /* overrun error bit */
 #elif defined(CONFIG_RCAR_GEN2) || defined(CONFIG_RCAR_64) || \
-      defined(CONFIG_R7S72100)
+      defined(CONFIG_R7S72100) || defined(CONFIG_RZG2L)
 # if defined(CFG_SCIF_A)
 #  define SCIF_ORER	0x0200
 # else
@@ -312,6 +312,9 @@ static inline void sci_##name##_out(struct uart_port *port,\
 					sh4_scif_offset, sh4_scif_size)
 		#define SCIF_FNS(name, sh4_scif_offset, sh4_scif_size) \
 			CPU_SCIF_FNS(name, sh4_scif_offset, sh4_scif_size)
+#elif defined(CONFIG_RZG2L)
+#define SCIF_FNS(reg_name, reg_offset, reg_size) \
+	CPU_SCIF_FNS(reg_name, reg_offset, reg_size)
 #else
 #define SCIx_FNS(name, sh3_sci_offset, sh3_sci_size,\
 				sh4_sci_offset, sh4_sci_size, \
@@ -387,6 +390,20 @@ SCIF_FNS(SCLSR,  0,  0, 0x14, 16)
 #else
 SCIF_FNS(SCLSR,  0,  0, 0x24, 16)
 #endif
+#elif defined(CONFIG_RZG2L)
+SCIF_FNS(SCSMR,  0x00, 16)
+SCIF_FNS(SCBRR,  0x02,  8)
+SCIF_FNS(SCSCR,  0x04, 16)
+SCIF_FNS(SCxTDR, 0x06,  8)
+SCIF_FNS(SCxSR,  0x08, 16)
+SCIF_FNS(SCxRDR, 0x0A,  8)
+SCIF_FNS(SCFCR,  0x0C, 16)
+SCIF_FNS(SCFDR,  0x0E, 16)
+SCIF_FNS(SCSPTR, 0x10, 16)
+SCIF_FNS(SCLSR,  0x12, 16)
+SCIF_FNS(SCSEMR, 0x14,  8)
+SCIF_FNS(SCxTCR, 0x16, 16)
+SCIF_FNS(DL,     0x00,  0)
 #else
 /*      reg      SCI/SH3   SCI/SH4  SCIF/SH3   SCIF/SH4  SCI/H8*/
 /*      name     off  sz   off  sz   off  sz   off  sz   off  sz*/
-- 
2.34.1

