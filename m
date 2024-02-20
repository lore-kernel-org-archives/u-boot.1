Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BA3C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:31:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD27588007;
	Tue, 20 Feb 2024 19:29:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="UObmwuww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDAD88022; Tue, 20 Feb 2024 19:29:46 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DC288007
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id 1776F2266C;
 Tue, 20 Feb 2024 19:29:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708453774;
 bh=JcCZcTF1IjvsVCRimSRj9x9Wmh/eEMOudRDWQ4IGxWg=; h=From:To:Subject;
 b=UObmwuwwsbRaiZkYkhOXVApm5VvhijIs5Qip20glaQPU+tL0XIenBkIDd6KDchpyw
 Y+5jsLITxkjh3FA5B1DOEuBeHTTUil0/M/PC4E2ZKTy1c7CGpdzX048746pgxiLK02
 2ndH51RhuWM1TgYa7+P21oOX852Ynig4J7OXSqcKst7BuyyO0RyXPEqzKAOuU7ZEIl
 A4pzELwZ1LI+66JAbrLk1cWEHj1WUqjRYtu1ZOS12JF7pG9nIfjhi65L+/YBbFlav+
 Ra6BUgCr0mXo3SxI8oChfacFzzoSJzcelB2TUfp7QFrsGRyAHHU7ppc1ljHGx5mT5L
 mo/Cp3+oyGajQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 7/7] toradex: imx6*: fix reset using wdt-reboot driver
Date: Tue, 20 Feb 2024 19:29:26 +0100
Message-Id: <20240220182926.101161-8-francesco@dolcini.it>
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

From: Parth Pancholi <parth.pancholi@toradex.com>

commit 68dcbdd594d4 ("ARM: imx: Add weak default reset_cpu()")
introduced a regression that 'reset' command unable to reset
imx6 and imx6ull based Toradex's modules in the u-boot.

This change enables a watchdog-based sysreset driver for
Toradex's colibri-imx6, colibri-imx6ull (with nand and emmc)
and apalis-imx6 which solves the reset command regression on
these modules.

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

