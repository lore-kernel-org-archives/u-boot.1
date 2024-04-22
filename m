Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8791C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 06:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B07388370;
	Mon, 22 Apr 2024 08:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="FEBgAZE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0A1E88353; Mon, 22 Apr 2024 08:30:36 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB86388354
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 08:30:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8fac=L3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1713767412; bh=Of/qtbjG8faipQXJ0RQlWqPeHT2WafkUKeAxbXmrkiU=;
 b=FEBgAZE4psVeITP3N8WiItNkbpGG6lAvrBt0demtBu90sefLYmELA5Gh1iFW0QZeHJoP3JxFP
 uRax1LbT4UuwYl8gjqjqWLHb2cVgf2JVhc78wBou0QXQIEqvc1Ss2uWa0wtFPw+/d0FYOpj5WDc
 VuLbevLedGNGGB3t14zGTaw844QhwDklGnOsgddBn5QWkEvvAaHV+pujBcxHVrS755NtV5Wvgjr
 LxhMp3rBcsnLF9uaRP5c+wtx1GTyJmVBYWP0ldJ9Y7Fomz0rY1kjU7p/c5zhrkA8maZrbamSCa6
 4GoeQy74KKIkI9vHwgLGZH+gl31VrBQ+K4S2TI4QzQdQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Chris Morgan <macromorgan@hotmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Dragan Simic
 <dsimic@manjaro.org>, u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 08/28] rockchip: rk35xx: Enable random generator
Date: Mon, 22 Apr 2024 06:28:45 +0000
Message-ID: <20240422062936.681359-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240422062936.681359-1-jonas@kwiboo.se>
References: <20240422062936.681359-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 662603f334ba165ad447430b
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

The RK35xx SoCs contain a crypto engine block that can generate random
numbers.

Enable rng node in soc u-boot.dtsi and enable Kconfig options to take
advantage of the random generator.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
v3: Collect r-b tag
v2: No change
---
 arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi | 6 ------
 arch/arm/dts/rk356x-u-boot.dtsi                | 5 +++++
 arch/arm/dts/rk3588s-u-boot.dtsi               | 1 -
 arch/arm/mach-rockchip/Kconfig                 | 4 ++++
 configs/anbernic-rgxx3-rk3566_defconfig        | 2 --
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
index 791f16b206f2..793ed4ae8ae0 100644
--- a/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
+++ b/arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
@@ -6,12 +6,6 @@
 	chosen {
 		u-boot,spl-boot-order = "same-as-spl", &sdmmc1, &sdmmc0;
 	};
-
-	rng: rng@fe388000 {
-		compatible = "rockchip,cryptov2-rng";
-		reg = <0x0 0xfe388000 0x0 0x2000>;
-		status = "okay";
-	};
 };
 
 &dsi_dphy0 {
diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
index d347080577d9..05367216e118 100644
--- a/arch/arm/dts/rk356x-u-boot.dtsi
+++ b/arch/arm/dts/rk356x-u-boot.dtsi
@@ -21,6 +21,11 @@
 		bootph-all;
 	};
 
+	rng: rng@fe388000 {
+		compatible = "rockchip,cryptov2-rng";
+		reg = <0x0 0xfe388000 0x0 0x2000>;
+	};
+
 	otp: nvmem@fe38c000 {
 		compatible = "rockchip,rk3568-otp";
 		reg = <0x0 0xfe38c000 0x0 0x4000>;
diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
index ac67c777adea..233eb79d9ba2 100644
--- a/arch/arm/dts/rk3588s-u-boot.dtsi
+++ b/arch/arm/dts/rk3588s-u-boot.dtsi
@@ -91,7 +91,6 @@
 	rng: rng@fe378000 {
 		compatible = "rockchip,trngv1";
 		reg = <0x0 0xfe378000 0x0 0x200>;
-		status = "disabled";
 	};
 
 	usbdp_phy0: phy@fed80000 {
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 1cc9f7c4bb50..7b54a6f7dddc 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -306,9 +306,11 @@ config ROCKCHIP_RK3568
 	select BOARD_LATE_INIT
 	select DM_REGULATOR_FIXED
 	select DM_RESET
+	imply DM_RNG
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
@@ -335,9 +337,11 @@ config ROCKCHIP_RK3588
 	select DM_RESET
 	imply BOOTSTD_FULL
 	imply CLK_SCMI
+	imply DM_RNG
 	imply MISC_INIT_R
 	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
 	imply OF_LIBFDT_OVERLAY
+	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
index 24b050c59b53..110237e798f9 100644
--- a/configs/anbernic-rgxx3-rk3566_defconfig
+++ b/configs/anbernic-rgxx3-rk3566_defconfig
@@ -68,8 +68,6 @@ CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_SPL_RAM=y
 # CONFIG_RAM_ROCKCHIP_DEBUG is not set
-CONFIG_DM_RNG=y
-CONFIG_RNG_ROCKCHIP=y
 # CONFIG_RNG_SMCCC_TRNG is not set
 CONFIG_BAUDRATE=1500000
 CONFIG_DEBUG_UART_SHIFT=2
-- 
2.43.2

