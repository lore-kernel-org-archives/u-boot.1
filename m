Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBFACD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A44882F2;
	Sun, 31 Mar 2024 22:31:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="h/vawmav";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF63C882F2; Sun, 31 Mar 2024 22:31:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7146882DC
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:31:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917066; bh=9l88ZdP6unqYgu4C8ri/LtgRMSNN/mQ626Zqu474Gr8=;
 b=h/vawmavshd3haAqfs6dvEN/P+1Ef2vvnOUAf/A0hYLkI7ZwtZ19ybKp2KAxn375S4CZ1JeQI
 XMoM4mEqXSpSAxZhJf7PbawPsLK8UZ10rEfVhdytPX31QJkXNCxyXfj2n4uTmdpgUbVa3E4Ywa+
 41UiisZvyCuGKl7NxxBTqPfN9EhvKINRcXjS9B+WXcswtJwOrNs4Ya74iaIFoPk3Q1dXT6fMOF2
 9hawqN2cJLfh9PISO1N2u57/8S2SJ9sgvMfsT2JLPMr3UOsaFw2ZHhUExBZH7Oj0w6p3Dofjyzm
 UfVYQcTtUtsYa2TvgeeKD1jci6puSCgrm6ujdNGucUiA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 21/31] rockchip: rk3399-evb: Sync device tree from linux v6.8
Date: Sun, 31 Mar 2024 20:28:27 +0000
Message-ID: <20240331202921.262323-22-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240331202921.262323-1-jonas@kwiboo.se>
References: <20240331202921.262323-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6609c8088fc6b45ed44f73e7
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

Sync rk3399-evb device tree from linux v6.8.

Change to SPL_MAX_SIZE=0x40000, SPL can be up to 256 KiB.

Remove CONFIG_NET_RANDOM_ETHADDR=y, ethaddr and eth1addr is set based on
cpuid read from eFUSE.

Add PHY_REALTEK=y and DM_ETH_PHY=y to support ethernet PHY.

Remove SPL_TINY_MEMSET=y to use full memset in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-evb-u-boot.dtsi | 11 +----------
 arch/arm/dts/rk3399-evb.dts         |  3 ++-
 configs/evb-rk3399_defconfig        |  6 +++---
 3 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/arm/dts/rk3399-evb-u-boot.dtsi b/arch/arm/dts/rk3399-evb-u-boot.dtsi
index 9df4a02c3e74..68d86194cc4c 100644
--- a/arch/arm/dts/rk3399-evb-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-evb-u-boot.dtsi
@@ -12,14 +12,6 @@
 	};
 };
 
-&i2c0 {
-	bootph-all;
-};
-
-&rk808 {
-	bootph-all;
-};
-
 &tcphy1 {
 	status = "okay";
 };
@@ -41,10 +33,9 @@
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	cd-gpios = <&gpio0 7 GPIO_ACTIVE_LOW>;
 	disable-wp;
 	max-frequency = <150000000>;
 	pinctrl-names = "default";
-	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
 };
diff --git a/arch/arm/dts/rk3399-evb.dts b/arch/arm/dts/rk3399-evb.dts
index 7b717ebec8ff..55eca7a50a1f 100644
--- a/arch/arm/dts/rk3399-evb.dts
+++ b/arch/arm/dts/rk3399-evb.dts
@@ -12,6 +12,7 @@
 	compatible = "rockchip,rk3399-evb", "rockchip,rk3399";
 
 	aliases {
+		ethernet0 = &gmac;
 		mmc0 = &sdhci;
 	};
 
@@ -55,7 +56,7 @@
 	};
 
 	edp_panel: edp-panel {
-		compatible ="lg,lp079qx1-sp0v";
+		compatible = "lg,lp079qx1-sp0v";
 		backlight = <&backlight>;
 		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
 		power-supply = <&vcc3v3_s0>;
diff --git a/configs/evb-rk3399_defconfig b/configs/evb-rk3399_defconfig
index afb79987464f..334259f73eb2 100644
--- a/configs/evb-rk3399_defconfig
+++ b/configs/evb-rk3399_defconfig
@@ -15,7 +15,7 @@ CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART=y
 CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-evb.dtb"
 CONFIG_DISPLAY_BOARDINFO_LATE=y
-CONFIG_SPL_MAX_SIZE=0x2e000
+CONFIG_SPL_MAX_SIZE=0x40000
 CONFIG_SPL_PAD_TO=0x7f8000
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
@@ -30,7 +30,6 @@ CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
-CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_ROCKCHIP_GPIO=y
 CONFIG_SYS_I2C_ROCKCHIP=y
 CONFIG_MMC_HS400_SUPPORT=y
@@ -39,6 +38,8 @@ CONFIG_MMC_DW_ROCKCHIP=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_ETH_PHY=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -69,5 +70,4 @@ CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_VIDEO_ROCKCHIP_MAX_YRES=1200
 CONFIG_DISPLAY_ROCKCHIP_MIPI=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

