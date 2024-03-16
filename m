Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6523DC54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14394880D5;
	Sat, 16 Mar 2024 23:57:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="xU047OHa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C15C880AC; Sat, 16 Mar 2024 23:57:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E532880A6
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629865; bh=7tqnfCywaeROTSE0y2wp6tIugDiZimrL3vTSLclDwWg=;
 b=xU047OHaNZO/szaBp2+zjimUm3LUPTRioCC68GxsAbYMMiM1VDCJK34SancQSg1IvqlH8HAcM
 jRhnPwp7DvQNSqKZHL+7bP9RXaAV+QtRVsLlsDLEYDQMXxl5GkzJaQdXqEi7a0WjVviauBtOfop
 v7R+WkD+vkhQMpwQvPl7RsXKfVX6I6aJpYEtrCaQAv35CenwV2FyOkkk+Cd0LDktmc3XMpRNZhD
 HYpM18RFjMUfjHuEZKJvmIUGBb/Ohd8hWwGfzljlT8ciGIxsrF7efLTwaLXmkQ54V+7acsOz6o4
 Fy8tm3MSXEnt8rhvxquXSuhOXIe49fPT9VSz0Txv5sNg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Akash Gajjar <gajjar04akash@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Andy Yan <andy.yan@rock-chips.com>, u-boot@lists.denx.de
Subject: [PATCH 13/13] rockchip: rk3308-rock-pi-s: Update defconfig
Date: Sat, 16 Mar 2024 22:56:39 +0000
Message-ID: <20240316225655.3244348-14-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 65f623e80957eaab7babfd65
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

Update defconfig for rk3308-rock-pi-s with new defaults.

Add OF_LIBFDT_OVERLAY=y to support device tree overlays.

Remove the SPL_DRIVERS_MISC=y option, no misc driver is used in SPL.

Remove BOOTDELAY=0, SYS_CONSOLE_INFO_QUIET=y and enable more CMD to
allow use of U-Boot cmdline.

Add DM_ETH_PHY=y and PHY_REALTEK=y to support onboard ethernet PHY.

Add PHY_ROCKCHIP_INNO_USB2=y, DM_USB_GADGET=y and remove USB_DWC2=y to
allow full use of USB 2.0 host and otg ports.

Enable EFI_LOADER to allow EFI boot.

Also fix use of USB 2.0 otg port by removing improper use of phy-supply
and regulator-always-on props.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi |  8 ++++++
 configs/rock-pi-s-rk3308_defconfig        | 33 +++++++++--------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
index 45ab5c7781e5..474c81334a14 100644
--- a/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-pi-s-u-boot.dtsi
@@ -14,6 +14,10 @@
 	bootph-pre-ram;
 };
 
+&u2phy_otg {
+	/delete-property/ phy-supply;
+};
+
 &uart0 {
 	bootph-all;
 	clock-frequency = <24000000>;
@@ -31,6 +35,10 @@
 	bootph-all;
 };
 
+&vcc5v0_otg {
+	/delete-property/ regulator-always-on;
+};
+
 &vdd_core {
 	regulator-init-microvolt = <1015000>;
 };
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 27ee24a62290..9142671a4c0b 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -6,39 +6,28 @@ CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
-CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3308=y
 CONFIG_DEBUG_UART_BASE=0xFF0A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
-# CONFIG_DEBUG_UART_BOARD_INIT is not set
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART=y
 CONFIG_ANDROID_BOOT_IMAGE=y
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3308-rock-pi-s.dtb"
-CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
-# CONFIG_CMD_BDI is not set
-# CONFIG_CMD_CONSOLE is not set
-# CONFIG_CMD_ELF is not set
-# CONFIG_CMD_IMI is not set
-# CONFIG_CMD_XIMG is not set
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
-# CONFIG_CMD_LOADB is not set
-# CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_ITEST is not set
-# CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_SLEEP is not set
-# CONFIG_SPL_DOS_PARTITION is not set
-# CONFIG_ISO_PARTITION is not set
-CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
+CONFIG_CMD_RNG=y
+CONFIG_CMD_KASLRSEED=y
+CONFIG_CMD_REGULATOR=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
@@ -52,9 +41,11 @@ CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_SUPPORT_EMMC_RPMB=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
-CONFIG_PHY=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
@@ -63,15 +54,15 @@ CONFIG_RAM=y
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSINFO=y
 CONFIG_SYSRESET=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_GENERIC=y
-CONFIG_USB_DWC2=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DWC2_OTG=y
 CONFIG_USB_GADGET_DOWNLOAD=y
-CONFIG_SPL_TINY_MEMSET=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
 CONFIG_LZO=y
 CONFIG_ERRNO_STR=y
-# CONFIG_EFI_LOADER is not set
-- 
2.43.2

