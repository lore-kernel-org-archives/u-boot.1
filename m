Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F20C5478C
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 09:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A62A87D8D;
	Fri, 23 Feb 2024 10:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="0bJnwzw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 228C3807EC; Fri, 23 Feb 2024 10:13:46 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B77E087D0A
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 10:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 7F39921B11;
 Fri, 23 Feb 2024 10:12:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708679520;
 bh=sX34ByKWoarvIz2ZI3ToQLuZSVADpXnRwt4XO8o51EA=; h=From:To:Subject;
 b=0bJnwzw+PnJKOY2yBecKGmJxmNJBla/obMsFxu8Pq99n5HXfFPWt8drwl1AZmzmh1
 Na0wDGAM9QAzQx2Ri64J94qwHJH5BGtbxTMbp6BpIbohWOVbk1UKETah28leJQEM+g
 7yMBDfLBN4D64Tlbk9v09Cr1+STzlNr7ZpzQdYuulv/WZhJ3Xwgcm2rNh095AcPvXq
 +c8+cEsL31LwDOD+/1nBwi5H7q8rad3TpIfV6it0Hh4iA5XcDZtT26QSlJzZ8i302l
 gjureiFqMJAKvjmaoz3c4XWdvZXxGXGGp12TGLdfY0PrQ975UomJsgI9yvfwOGqgZQ
 StHA5657DX5kQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 7/7] toradex: imx6*: fix reset using wdt-reboot driver
Date: Fri, 23 Feb 2024 10:11:43 +0100
Message-Id: <20240223091143.9561-8-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223091143.9561-1-francesco@dolcini.it>
References: <20240223091143.9561-1-francesco@dolcini.it>
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

From: Parth Pancholi <parth.pancholi@toradex.com>

commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()")
introduced a regression that 'reset' command unable to reset
imx6 and imx6ull based Toradex's modules in the u-boot.

This change enables a watchdog-based sysreset driver for
Toradex's colibri-imx6, colibri-imx6ull (with nand and emmc)
and apalis-imx6 which solves the reset command regression on
these modules.

Acked-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Fixes: 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()")
Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi  |  6 ++++++
 arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi       |  6 ++++++
 arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi | 10 ++++++++++
 configs/apalis_imx6_defconfig                    |  3 +++
 configs/colibri-imx6ull-emmc_defconfig           |  3 +++
 configs/colibri-imx6ull_defconfig                |  3 +++
 configs/colibri_imx6_defconfig                   |  3 +++
 7 files changed, 34 insertions(+)

diff --git a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
index 5a91d0aca204..44baaa803243 100644
--- a/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx6dl-colibri-eval-v3-u-boot.dtsi
@@ -20,6 +20,12 @@
 	sysinfo {
 		compatible = "toradex,sysinfo";
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
index 59412635420a..103605ac930d 100644
--- a/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
+++ b/arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi
@@ -23,6 +23,12 @@
 	sysinfo {
 		compatible = "toradex,sysinfo";
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
index 731814216e1f..8494b1a2c603 100644
--- a/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx6ull-colibri-eval-v3-u-boot.dtsi
@@ -13,6 +13,12 @@
 	sysinfo {
 		compatible = "toradex,sysinfo";
 	};
+
+	wdt-reboot {
+		compatible = "wdt-reboot";
+		wdt = <&wdog1>;
+		bootph-pre-ram;
+	};
 };
 
 &pinctrl_uart1 {
@@ -58,3 +64,7 @@
 		};
 	};
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/apalis_imx6_defconfig b/configs/apalis_imx6_defconfig
index 492550607035..fae3dc322471 100644
--- a/configs/apalis_imx6_defconfig
+++ b/configs/apalis_imx6_defconfig
@@ -96,6 +96,8 @@ CONFIG_DM_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SYS_MXC_I2C3_SPEED=400000
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -113,6 +115,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SCSI=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_MAX_CONTROLLER_COUNT=2
diff --git a/configs/colibri-imx6ull-emmc_defconfig b/configs/colibri-imx6ull-emmc_defconfig
index 2b04855770ab..c4ecdc03e2a8 100644
--- a/configs/colibri-imx6ull-emmc_defconfig
+++ b/configs/colibri-imx6ull-emmc_defconfig
@@ -69,6 +69,8 @@ CONFIG_FASTBOOT_BUF_ADDR=0x81100000
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
 CONFIG_PHYLIB=y
@@ -83,6 +85,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
diff --git a/configs/colibri-imx6ull_defconfig b/configs/colibri-imx6ull_defconfig
index 959930cf2e31..9c68d96b2fd7 100644
--- a/configs/colibri-imx6ull_defconfig
+++ b/configs/colibri-imx6ull_defconfig
@@ -80,6 +80,8 @@ CONFIG_FASTBOOT_BUF_ADDR=0x81100000
 CONFIG_FASTBOOT_UUU_SUPPORT=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_FSL_USDHC=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
@@ -100,6 +102,7 @@ CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
diff --git a/configs/colibri_imx6_defconfig b/configs/colibri_imx6_defconfig
index 55c71a000d00..74c54011989c 100644
--- a/configs/colibri_imx6_defconfig
+++ b/configs/colibri_imx6_defconfig
@@ -22,6 +22,8 @@ CONFIG_SYS_MONITOR_LEN=409600
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_CMD_HDMIDETECT=y
 CONFIG_SYS_LOAD_ADDR=0x14200000
 CONFIG_SYS_MEMTEST_START=0x10000000
@@ -109,6 +111,7 @@ CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_USB_MAX_CONTROLLER_COUNT=2
-- 
2.39.2

