Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15AF9C83F17
	for <u-boot@archiver.kernel.org>; Sun, 13 Jul 2025 23:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F6782F8F;
	Mon, 14 Jul 2025 01:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iWVDY3LD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AFA883087; Mon, 14 Jul 2025 01:35:20 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D469A82F8F
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 01:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=afea=Z3=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1752449713; bh=VhOk0U/rH68GsIMf54ZzaPX6UKPi0s8aTvqeT5wzBzA=;
 b=iWVDY3LD46DB2nqKvwVXVbWJ/PUi1PKEjWHBIiwSRwnpwkm5OXvaMl1WpYAH8muIINPNaSydS
 VvpQLPsblRYQMy9LFnZGseS817+1jkbARiJkhUXGhZM6zyAIY2i11fgvX/ec7vcmJnd2GdFrhVM
 KFNihgjIiPk8yZUDNqLk5A5I1pLefnpUl5KJAnZWjB7RZFBNYCVa6BlmKPgUqzkZlsOPWGOQLW1
 gb9y4fujRrq9Bn9unwf5A7r/jsGY0cq/wLGg3iwjEEvxwor3cn4olfZo9VJAQ8JvFlRrGgn/fs/
 QEeqsqoiF1WiFTVgVVCUErpW5X7MtVr+Xqmu1HlQocwg==
X-Forward-Email-ID: 687442ad5c59ddd2f404feeb
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 09/17] rockchip: odroid-go2: Use power off at power plug-in
 event
Date: Sun, 13 Jul 2025 23:33:57 +0000
Message-ID: <20250713233429.1376172-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250713233429.1376172-1-jonas@kwiboo.se>
References: <20250713233429.1376172-1-jonas@kwiboo.se>
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

Include the RK817 PMIC in SPL and enable Kconfig options to power off
the handheld gaming device when it was powered on due to a power cable
plug-in event:

  DDR3, 333MHz
  BW=32 Col=10 Bk=8 CS0 Row=15 CS=1 Die BW=16 Size=1024MB
  out
  Power Off due to plug-in event

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi | 18 ++++++++++++++++++
 configs/odroid-go2_defconfig               |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
index 6f40654d5e84..6c6efa964d80 100644
--- a/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
+++ b/arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi
@@ -5,8 +5,26 @@
 
 #include "rk3326-u-boot.dtsi"
 
+&i2c0_xfer {
+	bootph-pre-ram;
+};
+
+&i2s1_2ch_mclk {
+	bootph-pre-ram;
+};
+
+&pcfg_pull_none_smt {
+	bootph-pre-ram;
+};
+
+&pmic_int {
+	bootph-pre-ram;
+};
+
 &rk817 {
 	regulators {
+		bootph-pre-ram;
+
 		vcc_cam: LDO_REG9 {
 			regulator-name = "vcc_cam";
 			regulator-min-microvolt = <3000000>;
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index b0947fe2c8b2..a6d02baa520f 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -8,6 +8,7 @@ CONFIG_ENV_OFFSET=0x4000
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3326-odroid-go2"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_PX30=y
+CONFIG_ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON=y
 CONFIG_TARGET_ODROID_GO2=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_SYS_LOAD_ADDR=0x800800
@@ -42,6 +43,7 @@ CONFIG_CMD_GPT=y
 # CONFIG_CMD_LOADB is not set
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_POWEROFF=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 # CONFIG_CMD_ITEST is not set
@@ -73,6 +75,7 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_SPL_PMIC_RK8XX=y
+CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
-- 
2.49.0

