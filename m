Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3066CDB484
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB5587250;
	Thu, 19 Oct 2023 16:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DE2C85423; Thu, 19 Oct 2023 16:31:07 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 1B6B6803AC
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.03,237,1694703600"; d="scan'208";a="179875874"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 19 Oct 2023 23:31:00 +0900
Received: from GBR-5CG2373LKG.adwin.renesas.com (unknown [10.226.93.46])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 137194005B25;
 Thu, 19 Oct 2023 23:30:57 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Hai Pham <hai.pham.ud@renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 2/2] serial: sh: Add RZ/G2L SCIF support
Date: Thu, 19 Oct 2023 15:30:44 +0100
Message-Id: <20231019143044.1363-3-paul.barker.ct@bp.renesas.com>
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

Extend the existing driver to support the SCIF serial ports on the
Renesas RZ/G2L (R9A07G044) SoC. This also requires us to ensure that if
there is a reset signal defined in the device tree, it is de-asserted
before we try to talk to the SCIF module.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
	# R-Car H3 Salvator-XS

v3->v4:
  * Fix support for devices that don't define a SCI/SCIF module reset in
    the device tree.
v2->v3:
  * Fixed sorting in the include list and sh_serial_id[].
  * Added Marek's Tested-by & Reviewed-by.
v1->v2:
  * Moved handle_error() changes out to a separate patch earlier in the
    series.
  * Unconditionally de-assert the module reset during probe.
---
 arch/arm/mach-rmobile/Kconfig |  1 +
 drivers/serial/serial_sh.c    | 15 +++++++++++++++
 drivers/serial/serial_sh.h    | 19 ++++++++++++++++++-
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rmobile/Kconfig b/arch/arm/mach-rmobile/Kconfig
index 714eb4405bcf..2bb96749fc0d 100644
--- a/arch/arm/mach-rmobile/Kconfig
+++ b/arch/arm/mach-rmobile/Kconfig
@@ -77,6 +77,7 @@ config RZG2L
 	imply PINCTRL_RZG2L
 	imply RENESAS_SDHI
 	imply RZG2L_GPIO
+	imply SCIF_CONSOLE
 	imply SYS_MALLOC_F
 	help
 	  Enable support for the Renesas RZ/G2L family of SoCs. Currently
diff --git a/drivers/serial/serial_sh.c b/drivers/serial/serial_sh.c
index 9a698b19ccde..c034ab54e152 100644
--- a/drivers/serial/serial_sh.c
+++ b/drivers/serial/serial_sh.c
@@ -12,10 +12,12 @@
 #include <asm/processor.h>
 #include <clk.h>
 #include <dm.h>
+#include <dm/device_compat.h>
 #include <dm/platform_data/serial_sh.h>
 #include <errno.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <reset.h>
 #include <serial.h>
 #include "serial_sh.h"
 
@@ -199,12 +201,24 @@ static int sh_serial_probe(struct udevice *dev)
 {
 	struct sh_serial_plat *plat = dev_get_plat(dev);
 	struct uart_port *priv = dev_get_priv(dev);
+	struct reset_ctl rst;
+	int ret;
 
 	priv->membase	= (unsigned char *)plat->base;
 	priv->mapbase	= plat->base;
 	priv->type	= plat->type;
 	priv->clk_mode	= plat->clk_mode;
 
+	/* De-assert the module reset if it is defined. */
+	ret = reset_get_by_index(dev, 0, &rst);
+	if (!ret) {
+		ret = reset_deassert(&rst);
+		if (ret < 0) {
+			dev_err(dev, "failed to de-assert reset line\n");
+			return ret;
+		}
+	}
+
 	sh_serial_init_generic(priv);
 
 	return 0;
@@ -221,6 +235,7 @@ static const struct dm_serial_ops sh_serial_ops = {
 static const struct udevice_id sh_serial_id[] ={
 	{.compatible = "renesas,sci", .data = PORT_SCI},
 	{.compatible = "renesas,scif", .data = PORT_SCIF},
+	{.compatible = "renesas,scif-r9a07g044", .data = PORT_SCIFA},
 	{.compatible = "renesas,scifa", .data = PORT_SCIFA},
 	{.compatible = "renesas,hscif", .data = PORT_HSCIF},
 	{}
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
2.39.2

