Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502EFC54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:58:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E91A880AA;
	Sat, 16 Mar 2024 23:57:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mzGh6+Do";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A63A08809F; Sat, 16 Mar 2024 23:57:40 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACFEC88065
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629842; bh=3JVhjyQc7IrFGo6B2ZSXqC5wbgJrxALQaNpLJ8DDuZ8=;
 b=mzGh6+Do2da21S0EqRRrWAjQyPRHxUh4xUNtFUWEi5mX3qWZ4lWJpCcDiyRACU88cvzFe0GOY
 GObUvgu74mODKJ/ClLPTa4lTYWNcO0DTaiJjSO9Tsq8aQewy2hpTnoMaIvF7/2VDmHKz8pj+RFA
 nWgOQp2Ik5ZkvHEhYkCLu8HIv2ytKdAg637nbQlxopeCnwmCkjkwRdWFoPideRw1CpEvEhLNG2m
 /9QBdSeHUFgv3Pidh8FOcGY8G2b0xZS5J/Ms+EnEdKtrVmnRjxowuci5kaXMrzYQzV7v+Rn+v5U
 m8pI4atRiIDyTICOs+xPlkBET3xfkLNFOUs/j5R44DsA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 06/13] rockchip: rk3308: Fix loading FIT from SD-card when
 booting from eMMC
Date: Sat, 16 Mar 2024 22:56:32 +0000
Message-ID: <20240316225655.3244348-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316225655.3244348-1-jonas@kwiboo.se>
References: <20240316225655.3244348-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65f623d10957eaab7babfce7
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

When RK3308 boards run SPL from eMMC and fail to load FIT from eMMC due
to it being missing or checksum validation fails there can be a fallback
to read FIT from SD-card. However, without proper pinctrl configuration
reading FIT from SD-card may fail:

  U-Boot SPL 2024.04-rc4 (Mar 16 2024 - 12:36:12 +0000)
  Trying to boot from MMC2
  mmc_load_image_raw_sector: mmc block read error
  Trying to boot from MMC1
  Card did not respond to voltage select! : -110
  mmc_init: -95, time 12
  spl: mmc init failed with error: -95
  Trying to boot from MMC2
  mmc_load_image_raw_sector: mmc block read error
  SPL: failed to boot from all boot devices (err=-6)
  ### ERROR ### Please RESET the board ###

Fix this by tagging related emmc and sdmmc pinctrl nodes with bootph
props. Also sort and move common nodes shared by all boards to the SoC
u-boot.dtsi.

Imply SPL_PINCTRL and SPL_DM_SEQ_ALIAS to apply correct pinconf before
trying to load FIT from a device.

Move u-boot,spl-boot-order to soc u-boot.dtsi and define both sdmmc and
emmc nodes as fallback.

Also fix boot from eMMC (SD NAND) on ROCK Pi S by using correct pinctrl.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-evb-u-boot.dtsi       | 11 ++--
 arch/arm/dts/rk3308-roc-cc-u-boot.dtsi    | 15 +++--
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi | 36 ++++-------
 arch/arm/dts/rk3308-u-boot.dtsi           | 74 +++++++++++++++++++++--
 arch/arm/mach-rockchip/Kconfig            |  2 +
 configs/evb-rk3308_defconfig              |  2 +-
 configs/roc-cc-rk3308_defconfig           |  4 +-
 configs/rock-pi-s-rk3308_defconfig        |  2 +-
 8 files changed, 103 insertions(+), 43 deletions(-)

diff --git a/arch/arm/dts/rk3308-evb-u-boot.dtsi b/arch/arm/dts/rk3308-evb-u-boot.dtsi
index d15ba94d37b6..007a69f9a60e 100644
--- a/arch/arm/dts/rk3308-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-evb-u-boot.dtsi
@@ -4,14 +4,11 @@
  */
 #include "rk3308-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &emmc;
-	};
-};
-
 &uart4 {
 	bootph-all;
 	clock-frequency = <24000000>;
-	status = "okay";
+};
+
+&uart4_xfer {
+	bootph-all;
 };
diff --git a/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi b/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
index 97d922c435d4..d823ac00c771 100644
--- a/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-roc-cc-u-boot.dtsi
@@ -4,14 +4,19 @@
  */
 #include "rk3308-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &emmc;
-	};
+&gpio4 {
+	bootph-pre-ram;
 };
 
 &uart2 {
 	bootph-all;
 	clock-frequency = <24000000>;
-	status = "okay";
+};
+
+&uart2m0_xfer {
+	bootph-all;
+};
+
+&vcc_sd {
+	bootph-pre-ram;
 };
diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
index d88dee80573e..c92e1fbf1f53 100644
--- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
@@ -4,39 +4,29 @@
  */
 #include "rk3308-u-boot.dtsi"
 
-/ {
-	chosen {
-		u-boot,spl-boot-order = "same-as-spl", &emmc, &sdmmc;
-	};
+&emmc {
+	cap-sd-highspeed;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus4>;
 };
 
-&uart0 {
-	bootph-all;
-};
-
-&pinctrl {
-	bootph-some-ram;
-
-	uart0 {
-		bootph-some-ram;
-	};
-	rtc {
-		bootph-some-ram;
-	};
+&emmc_bus4 {
+	bootph-pre-ram;
 };
 
-&uart0_xfer {
-	bootph-some-ram;
+&uart0 {
+	bootph-all;
+	clock-frequency = <24000000>;
 };
 
 &uart0_cts {
-	bootph-some-ram;
+	bootph-all;
 };
 
 &uart0_rts {
-	bootph-some-ram;
+	bootph-all;
 };
 
-&rtc_32k {
-	bootph-some-ram;
+&uart0_xfer {
+	bootph-all;
 };
diff --git a/arch/arm/dts/rk3308-u-boot.dtsi b/arch/arm/dts/rk3308-u-boot.dtsi
index d6c71f62bc93..ede07e1783ff 100644
--- a/arch/arm/dts/rk3308-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-u-boot.dtsi
@@ -11,6 +11,10 @@
 		mmc1 = &sdmmc;
 	};
 
+	chosen {
+		u-boot,spl-boot-order = "same-as-spl", &sdmmc, &emmc;
+	};
+
 	otp: nvmem@ff210000 {
 		compatible = "rockchip,rk3308-otp";
 		reg = <0x0 0xff210000 0x0 0x4000>;
@@ -37,21 +41,81 @@
 };
 
 &emmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+
 	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
 	u-boot,spl-fifo-mode;
+};
+
+&emmc_bus8 {
+	bootph-pre-ram;
+};
+
+&emmc_clk {
+	bootph-pre-ram;
+};
+
+&emmc_cmd {
+	bootph-pre-ram;
+};
+
+&grf {
 	bootph-all;
 };
 
-&sdmmc {
+&pcfg_pull_none {
 	bootph-all;
-	u-boot,spl-fifo-mode;
 };
 
-&grf {
+&pcfg_pull_none_4ma {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_none_8ma {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_up {
+	bootph-all;
+};
+
+&pcfg_pull_up_4ma {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_up_8ma {
+	bootph-pre-ram;
+};
+
+&pinctrl {
 	bootph-all;
 };
 
-&saradc {
+&rtc_32k {
 	bootph-all;
-	status = "okay";
+};
+
+&sdmmc {
+	bootph-pre-ram;
+	bootph-some-ram;
+
+	/* mmc to sram can't do dma, prevent aborts transferring TF-A parts */
+	u-boot,spl-fifo-mode;
+};
+
+&sdmmc_bus4 {
+	bootph-pre-ram;
+};
+
+&sdmmc_clk {
+	bootph-pre-ram;
+};
+
+&sdmmc_cmd {
+	bootph-pre-ram;
+};
+
+&sdmmc_det {
+	bootph-pre-ram;
 };
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fa5917236a43..3d6a76a793e7 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -170,7 +170,9 @@ config ROCKCHIP_RK3308
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
+	imply SPL_DM_SEQ_ALIAS
 	imply SPL_FIT_SIGNATURE
+	imply SPL_PINCTRL
 	imply SPL_RAM
 	imply SPL_REGMAP
 	imply SPL_ROCKCHIP_COMMON_BOARD
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index 6a6d2540317d..9dc7d9c0caea 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -40,7 +40,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 2f4a160acc24..041fa75b9659 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="rk3308-roc-cc"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
@@ -40,7 +41,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
@@ -57,6 +58,7 @@ CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_BAUDRATE=1500000
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index b0ad4d6ce354..27ee24a62290 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -41,7 +41,7 @@ CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
-- 
2.43.2

