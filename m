Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EED9E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:59:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A63E80304;
	Fri, 13 Dec 2024 00:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LUjb25yd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2994680304; Fri, 13 Dec 2024 00:58:36 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A60EC80296
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047910; bh=IFBtJujf3/hgG/m1mGO2VOtbFzYm9CSxKdodJmdqdUQ=;
 b=LUjb25ydh9ogIjVwMth66GWzYOxffzZfBgCSX41xYCtSARsJ6+/UhzwSdjakz+wg3QRqO/o/f
 0HJP8VUHQk/fHhaptn5m0GtFSnsgJ2jNlBE5Qg9aSAd1iJ3ib3MWh2XLRfWIvIHXyZP/MFXxr+a
 kKeCzjA8rXZ0BR2W/2S/7rCCtdiJ887o0j1shu9OTk6sD+gJmEnfv1tJGVvkTn+N/hQxKhQR18k
 LkHJXeHRKLcrxT9tl30jfTnkbbmie2+fKnBvghWiVVYtR4KaSGf6mPMhfo7d7tO5xwnS6TbVUOx
 uTOa567LILbQSCkSyX0s3hqjBaMimNfxqqln4cE1pJWA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/12] rockchip: rk3399-gru: Include pinctrl and regulators in
 SPL
Date: Thu, 12 Dec 2024 23:57:18 +0000
Message-ID: <20241212235735.164272-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b78a4a511ed8f0b3fe37f
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

Add bootph props and enable related Kconfig options to include vital
regulators in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3399-gru-u-boot.dtsi | 19 +++++++++++++++++++
 configs/chromebook_bob_defconfig    |  3 ++-
 configs/chromebook_kevin_defconfig  |  3 ++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index 5f44327736df..5517176aa4a0 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -33,12 +33,31 @@
 	/delete-property/ bootph-pre-ram;
 };
 
+&gpio0 {
+	bootph-pre-ram;
+};
+
+&pp1500_ap_io {
+	bootph-pre-ram;
+};
 
 &pp1800_audio {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
 };
 
+&pp1500_en {
+	bootph-pre-ram;
+};
+
+&pp3000 {
+	bootph-pre-ram;
+};
+
+&pp3000_en {
+	bootph-pre-ram;
+};
+
 &ppvar_bigcpu_pwm {
 	regulator-init-microvolt = <900000>;
 };
diff --git a/configs/chromebook_bob_defconfig b/configs/chromebook_bob_defconfig
index af9df4700e35..8cdfb64462f1 100644
--- a/configs/chromebook_bob_defconfig
+++ b/configs/chromebook_bob_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
@@ -73,6 +73,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_CROS_EC=y
diff --git a/configs/chromebook_kevin_defconfig b/configs/chromebook_kevin_defconfig
index cc51722b521b..3992b3da092f 100644
--- a/configs/chromebook_kevin_defconfig
+++ b/configs/chromebook_kevin_defconfig
@@ -48,7 +48,7 @@ CONFIG_CMD_PMIC=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_SPL_OF_CONTROL=y
-CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ROCKCHIP_GPIO=y
@@ -74,6 +74,7 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_REGULATOR_PWM=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_CROS_EC=y
-- 
2.47.1

