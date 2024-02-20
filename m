Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2AFC48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:31:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C80D87FFE;
	Tue, 20 Feb 2024 19:29:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="jmXzf2iG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49BD088012; Tue, 20 Feb 2024 19:29:45 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D595587FE7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 1222222719;
 Tue, 20 Feb 2024 19:29:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708453773;
 bh=8DA6CehWMTyGenofc2BIa6PcILKS3e3SOYt82yXYo0A=; h=From:To:Subject;
 b=jmXzf2iGrMOSHsswVhgbr62qN0T67DUEAJZqj7gxBPSGMT8YiEj6T4x/xMD1Lk9Rt
 cO0pszXbhubRresARYETT3+84dGOUoudTzcJ/mBRppyiW3u3yy57uqHEEF4cSi2V7s
 yTBGl03YfTEfqGH8B3J68zqKsMs+ih9/cPn+Qerp1ZiD/y045EpddHMxMLmuIIdSKG
 CxGCHEIACgF8naRb2mC1DoJLrb9Kc33YcRuZ9FygjRkW8gJQdVxRKJwJNj14TeNcq+
 hydls8DxpHR9Dvwx1zUBfUMazKFR2d65QW9gOnUHRPesr+ce6mBTAl0AP2Vgx1An/d
 qxow3KHKohbJg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 5/7] toradex: common: Add sysinfo driver
Date: Tue, 20 Feb 2024 19:29:24 +0100
Message-Id: <20240220182926.101161-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220182926.101161-1-francesco@dolcini.it>
References: <20240220182926.101161-1-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

This commit introduces support for the Toradex sysinfo driver in U-Boot,
which uses information from Toradex config block to print correct
board model.
In case the Toradex config block is not present sysinfo prints the model
of the board provided by device tree removing per board specific prints.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi    |  6 +++
 arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi  |  6 +++
 .../dts/imx6dl-colibri-eval-v3-u-boot.dtsi    |  4 ++
 arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi    |  4 ++
 .../dts/imx6ull-colibri-eval-v3-u-boot.dtsi   |  4 ++
 .../arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |  4 ++
 .../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi    |  4 ++
 .../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi    |  4 ++
 .../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi  |  4 ++
 arch/arm/dts/tegra124-apalis-u-boot.dtsi      | 12 +++++
 arch/arm/dts/tegra20-colibri-u-boot.dtsi      | 12 +++++
 arch/arm/dts/tegra30-apalis-u-boot.dtsi       | 12 +++++
 arch/arm/dts/tegra30-colibri-u-boot.dtsi      | 12 +++++
 .../arm/dts/vf610-colibri-eval-v3-u-boot.dtsi |  4 ++
 board/toradex/common/Kconfig                  |  1 +
 board/toradex/common/tdx-common.c             | 50 ++++++++++++++++---
 16 files changed, 136 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/dts/tegra124-apalis-u-boot.dtsi
 create mode 100644 arch/arm/dts/tegra20-colibri-u-boot.dtsi
 create mode 100644 arch/arm/dts/tegra30-apalis-u-boot.dtsi
 create mode 100644 arch/arm/dts/tegra30-colibri-u-boot.dtsi

diff --git a/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi b/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
index c54a59e89c5d..d73be74d2112 100644
--- a/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
+++ b/arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi
@@ -3,6 +3,12 @@
  * Copyright 2019 Toradex AG
  */
 
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
+
 &mu {
 	bootph-some-ram;
 };
diff --git a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
index 6ab6b1f9ee69..60c4cd6fc01f 100644
--- a/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
+++ b/arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi
@@ -3,6 +3,12 @@
  * Copyright 2019 Toradex AG
  */
 
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
+
 &{/imx8qx-pm} {
 
 	bootph-some-ram;
diff --git a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
index 0eea4d1862ae..5a91d0aca204 100644
--- a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
@@ -16,6 +16,10 @@
 		mmc0 = &usdhc3;
 		mmc1 = &usdhc1;
 	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
index 3c6e503d043b..59412635420a 100644
--- a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
+++ b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
@@ -19,6 +19,10 @@
 		mmc1 = &usdhc1;
 		mmc2 = &usdhc2;
 	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
index 6823b42d4514..731814216e1f 100644
--- a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
@@ -9,6 +9,10 @@
 		usb0 = &usbotg1; /* required for ums */
 		display0 = &lcdif;
 	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
 };
 
 &pinctrl_uart1 {
diff --git a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
index b2c12a413daf..68142769d360 100644
--- a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
@@ -11,6 +11,10 @@
 		mmc0 = &usdhc3;
 		mmc1 = &usdhc1;
 	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
 };
 
 &lcdif {
diff --git a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
index 515f195ab759..38db56059d69 100644
--- a/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mm-verdin-wifi-dev-u-boot.dtsi
@@ -12,6 +12,10 @@
 		eeprom2 = &eeprom_display_adapter;
 	};
 
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
index 67f1d45ce269..03f211d5f7d3 100644
--- a/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/imx8mp-verdin-wifi-dev-u-boot.dtsi
@@ -12,6 +12,10 @@
 		eeprom2 = &eeprom_display_adapter;
 	};
 
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+
 	wdt-reboot {
 		compatible = "wdt-reboot";
 		bootph-pre-ram;
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
index 02f34c90c6d7..28b697b67ae0 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-u-boot.dtsi
@@ -19,6 +19,10 @@
 	memory@80000000 {
 		bootph-all;
 	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
 };
 
 &main_timer0 {
diff --git a/arch/arm/dts/tegra124-apalis-u-boot.dtsi b/arch/arm/dts/tegra124-apalis-u-boot.dtsi
new file mode 100644
index 000000000000..a3614d279439
--- /dev/null
+++ b/arch/arm/dts/tegra124-apalis-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+#include "tegra124-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
diff --git a/arch/arm/dts/tegra20-colibri-u-boot.dtsi b/arch/arm/dts/tegra20-colibri-u-boot.dtsi
new file mode 100644
index 000000000000..d4a669a288d8
--- /dev/null
+++ b/arch/arm/dts/tegra20-colibri-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+#include "tegra20-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
diff --git a/arch/arm/dts/tegra30-apalis-u-boot.dtsi b/arch/arm/dts/tegra30-apalis-u-boot.dtsi
new file mode 100644
index 000000000000..37cbfbcc3506
--- /dev/null
+++ b/arch/arm/dts/tegra30-apalis-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+#include "tegra30-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
diff --git a/arch/arm/dts/tegra30-colibri-u-boot.dtsi b/arch/arm/dts/tegra30-colibri-u-boot.dtsi
new file mode 100644
index 000000000000..37cbfbcc3506
--- /dev/null
+++ b/arch/arm/dts/tegra30-colibri-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright 2023 Toradex
+ */
+
+#include "tegra30-u-boot.dtsi"
+
+/ {
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
+};
diff --git a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
index 572d40877ef9..8c3b86c201fa 100644
--- a/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/vf610-colibri-eval-v3-u-boot.dtsi
@@ -7,6 +7,10 @@
 	soc {
 		bootph-all;
 	};
+
+	sysinfo {
+		compatible = "toradex,sysinfo";
+	};
 };
 
 &aips0 {
diff --git a/board/toradex/common/Kconfig b/board/toradex/common/Kconfig
index 1f6a5e4db561..b85893ab44e4 100644
--- a/board/toradex/common/Kconfig
+++ b/board/toradex/common/Kconfig
@@ -4,6 +4,7 @@
 menuconfig TDX_CFG_BLOCK
 	bool "Enable Toradex config block support"
 	select OF_BOARD_SETUP
+	select SYSINFO
 	help
 	  The Toradex config block stored production data on the on-module
 	  flash device (NAND, NOR or eMMC). The area is normally preserved by
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index 6084436b48b4..1f3253f4222e 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -3,15 +3,16 @@
  * Copyright (c) 2016 Toradex, Inc.
  */
 
+#include <dm.h>
 #include <common.h>
 #include <env.h>
 #include <g_dnl.h>
 #include <init.h>
 #include <linux/libfdt.h>
+#include <sysinfo.h>
 
 #ifdef CONFIG_VIDEO
 #include <bmp_logo.h>
-#include <dm.h>
 #include <splash.h>
 #include <video.h>
 #endif
@@ -103,13 +104,8 @@ __weak int print_bootinfo(void)
 
 int checkboard(void)
 {
-	if (valid_cfgblock) {
-		printf("Model: Toradex %04d %s %s\n",
-		       tdx_hw_tag.prodid,
-		       toradex_modules[tdx_hw_tag.prodid].name,
-		       tdx_board_rev_str);
+	if (valid_cfgblock)
 		printf("Serial#: %s\n", tdx_serial_str);
-	}
 
 #ifdef CONFIG_TDX_CFG_BLOCK_EXTRA
 	if (tdx_carrier_board_name)
@@ -188,6 +184,46 @@ static int settings_r(void)
 }
 EVENT_SPY_SIMPLE(EVT_SETTINGS_R, settings_r);
 
+static int tdx_detect(struct udevice *dev)
+{
+	return valid_cfgblock ? 0 : -EINVAL;
+}
+
+static int tdx_get_str(struct udevice *dev, int id, size_t size, char *val)
+{
+	int ret = -ENOTSUPP;
+
+	switch (id) {
+	case SYSINFO_ID_BOARD_MODEL:
+		snprintf(val, size,
+			 "Toradex %04d %s %s",
+			 tdx_hw_tag.prodid,
+			 toradex_modules[tdx_hw_tag.prodid].name,
+			 tdx_board_rev_str);
+
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static const struct udevice_id sysinfo_tdx_ids[] = {
+	{ .compatible = "toradex,sysinfo" },
+	{ /* sentinel */ }
+};
+
+static const struct sysinfo_ops sysinfo_tdx_ops = {
+	.detect		= tdx_detect,
+	.get_str	= tdx_get_str,
+};
+
+U_BOOT_DRIVER(sysinfo_toradex) = {
+	.name		= "sysinfo_toradex",
+	.id		= UCLASS_SYSINFO,
+	.of_match	= sysinfo_tdx_ids,
+	.ops		= &sysinfo_tdx_ops,
+};
+
 #ifdef CONFIG_TDX_CFG_BLOCK_USB_GADGET_PID
 int g_dnl_bind_fixup(struct usb_device_descriptor *dev, const char *name)
 {
-- 
2.39.2

