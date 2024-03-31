Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69813CD128A
	for <u-boot@archiver.kernel.org>; Sun, 31 Mar 2024 20:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C98388320;
	Sun, 31 Mar 2024 22:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VmiQFk3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998E687FE3; Sun, 31 Mar 2024 22:32:13 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42FC088305
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 22:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=3892=LG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1711917110; bh=8CZzwwQow4zMzWaJ84q3mm3aVUq5QLX/kRw0XnFfuoU=;
 b=VmiQFk3qqS0JZ7QiFIjT0aQQi7Z0SdnkvX3nfzOn7kjIbMvRApkd+Bki/jL5yubHOtWWwODHp
 N8GvQPb85PZul+0TIf6fLSDtajcxRXgVEeSZv++ZP72tZs6ezquwcqp1LrQaz431K2hp/PZU5xV
 agyjEKr53OPzADLgf3u4XgxGNBMfZElcx9eIhqZnvRcvhrG5pgY7YGN6EuMg5xN1A9jM9T5n7Kr
 QUN08Jc6W1y8iiD85Aj9GYx08lyETLBQen3FGVwuD+kAPq9Zf4F0xMaWDmG6LbmLnwQJwqdjbQq
 +32xauxImu73AqqjaBod57RZPCvExuQyalDeYUjpcmKw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 30/31] rockchip: rk3399-pinebook-pro: Sync device tree from
 linux v6.8
Date: Sun, 31 Mar 2024 20:28:36 +0000
Message-ID: <20240331202921.262323-31-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6609c8348fc6b45ed44f74a0
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

Sync rk3399-pinebook-pro device tree from linux v6.8.

Add SF_DEFAULT_SPEED=10000000 and SPI_FLASH_SFDP_SUPPORT=y to improve
support for booting from SPI flash.

Add CMD_POWEROFF=y to support poweroff using cmdline and power on using
the pwr button on the board.

Remove SPL_TINY_MEMSET=y to use full memset in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-pinebook-pro.dts  | 24 +++++++-----------------
 configs/pinebook-pro-rk3399_defconfig |  6 ++++--
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/dts/rk3399-pinebook-pro.dts b/arch/arm/dts/rk3399-pinebook-pro.dts
index d6b68d77d63a..054c6a4d1a45 100644
--- a/arch/arm/dts/rk3399-pinebook-pro.dts
+++ b/arch/arm/dts/rk3399-pinebook-pro.dts
@@ -50,19 +50,9 @@
 		pinctrl-0 = <&panel_en_pin>;
 		power-supply = <&vcc3v3_panel>;
 
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				panel_in_edp: endpoint@0 {
-					reg = <0>;
-					remote-endpoint = <&edp_out_panel>;
-				};
+		port {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&edp_out_panel>;
 			};
 		};
 	};
@@ -76,7 +66,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&lidbtn_pin>;
 
-		lid {
+		switch-lid {
 			debounce-interval = <20>;
 			gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_LOW>;
 			label = "Lid";
@@ -92,7 +82,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwrbtn_pin>;
 
-		power {
+		key-power {
 			debounce-interval = <20>;
 			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
 			label = "Power";
@@ -675,7 +665,7 @@
 	i2c-scl-rising-time-ns = <168>;
 	status = "okay";
 
-	es8316: es8316@11 {
+	es8316: audio-codec@11 {
 		compatible = "everest,es8316";
 		reg = <0x11>;
 		clocks = <&cru SCLK_I2S_8CH_OUT>;
@@ -943,7 +933,7 @@
 	disable-wp;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_bus4>;
-	sd-uhs-sdr104;
+	sd-uhs-sdr50;
 	vmmc-supply = <&vcc3v0_sd>;
 	vqmmc-supply = <&vcc_sdio>;
 	status = "okay";
diff --git a/configs/pinebook-pro-rk3399_defconfig b/configs/pinebook-pro-rk3399_defconfig
index dd8bc2b72cc3..8ac6ddd49dea 100644
--- a/configs/pinebook-pro-rk3399_defconfig
+++ b/configs/pinebook-pro-rk3399_defconfig
@@ -4,7 +4,7 @@ CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_SF_DEFAULT_SPEED=20000000
+CONFIG_SF_DEFAULT_SPEED=10000000
 CONFIG_ENV_SIZE=0x8000
 CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3399-pinebook-pro"
@@ -36,6 +36,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
@@ -64,7 +65,9 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_SDMA=y
 CONFIG_MMC_SDHCI_ROCKCHIP=y
 CONFIG_SF_DEFAULT_BUS=1
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_GIGADEVICE=y
+CONFIG_SPI_FLASH_SILICONKAISER=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_NVME_PCI=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
@@ -98,5 +101,4 @@ CONFIG_VIDEO=y
 CONFIG_DISPLAY=y
 CONFIG_VIDEO_ROCKCHIP=y
 CONFIG_DISPLAY_ROCKCHIP_EDP=y
-CONFIG_SPL_TINY_MEMSET=y
 CONFIG_ERRNO_STR=y
-- 
2.43.2

