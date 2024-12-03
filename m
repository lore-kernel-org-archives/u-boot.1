Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 051E8E74ADD
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 21:47:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B97D8958D;
	Tue,  3 Dec 2024 22:47:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="fn7dM5Y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27E128964B; Tue,  3 Dec 2024 22:47:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AA4288EAB
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 22:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=218d=S5=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1733262443;
 bh=7nbAGwKNR8oggvGm/m28E9FMouPUuYm1eGJcj5QtrIw=;
 b=fn7dM5Y0DirbPWTeK+ZVOLGyPqrWdIWz3gP1PC7/gcfeqjdX0BP5K0vEtdQyMmd/UIo1hnp+a
 uiyLBDAxtR95K2MfGg4vrJD9mcSLrWcsKb9SOYC/JQMr2vM6xqDzbPV53EcE0j/FDbivxazQ1si
 tWbVKPPq0BFxd69M+H1F3jKi343e0+duipENrpDGJHaI+iUfkhEkaf6Ug9QsVKEE9OsEK5t6/Ua
 nhwaerjbenRWBPtVsWhcASkbs222SnK6Ev8Q6HiTA3LToEKkpimEJWLc2hqdTZw6Y3lIaq6ySFs
 sFqogCVneH80Oe+32fTKXtNnZKMmBZx2GGjczEJYuaRQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw revision
Date: Tue,  3 Dec 2024 21:47:08 +0000
Message-ID: <20241203214711.1011176-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 674f7c691d07da1904df6d9c
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

BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MMC
driver set PWREN high in dwmci_init().

However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.

Upstream linux-rockchip maintainer tree has merged a patch "arm64: dts:
rockchip: Fix sdmmc access on rk3308-rock-s0 v1.1 boards" for v6.14 to
fix this issue.

Add the upstream vmmc-supply regulator in board u-boot.dtsi and enable
required Kconfig options to set GPIO4_D6 low to fix reading sdmmc on
v1.1 hw revision.

The regulator-3v3-vcc-sd and sdmmc-2030 nodes along with the vmmc-supply
prop can be dropped once dts/upstream sync v6.14 DTs.

Fixes: 25438c40a007 ("board: rockchip: Add Radxa ROCK S0")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi | 43 +++++++++++++++++++++++++
 configs/rock-s0-rk3308_defconfig        |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
index dd4cb8660b8d..3b849280c4ad 100644
--- a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
@@ -2,11 +2,50 @@
 
 #include "rk3308-u-boot.dtsi"
 
+/ {
+	/*
+	 * HW revision prior to v1.2 must pull GPIO4_D6 low to access sdmmc.
+	 * This is modeled as an always-on active low fixed regulator.
+	 */
+	vcc_sd: regulator-3v3-vcc-sd {
+		compatible = "regulator-fixed";
+		gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc_2030>;
+		regulator-name = "vcc_sd";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_io>;
+	};
+};
+
 &emmc_pwren {
 	bootph-pre-ram;
 	bootph-some-ram;
 };
 
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&pinctrl {
+	sdmmc {
+		sdmmc_2030: sdmmc-2030 {
+			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&sdmmc {
+	vmmc-supply = <&vcc_sd>;
+};
+
+&sdmmc_2030 {
+	bootph-pre-ram;
+};
+
 &uart0 {
 	bootph-all;
 	clock-frequency = <24000000>;
@@ -17,6 +56,10 @@
 	bootph-pre-ram;
 };
 
+&vcc_sd {
+	bootph-pre-ram;
+};
+
 &vdd_core {
 	regulator-init-microvolt = <1015000>;
 };
diff --git a/configs/rock-s0-rk3308_defconfig b/configs/rock-s0-rk3308_defconfig
index 0a46e7bb1871..063e0b921d73 100644
--- a/configs/rock-s0-rk3308_defconfig
+++ b/configs/rock-s0-rk3308_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
+CONFIG_SPL_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3308-rock-s0"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
@@ -53,6 +54,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PINCTRL=y
 CONFIG_REGULATOR_PWM=y
 CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
 CONFIG_BAUDRATE=1500000
-- 
2.47.1

