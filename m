Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC66C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 18:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C13768007D;
	Thu, 20 Feb 2025 19:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZvOH6oad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6FC1806FE; Thu, 20 Feb 2025 19:31:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.59])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 178F280077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1740076300;
 bh=LsGRR+zyX9TuMnDp9hsJBlofDNodzRV1bbhatXtd7d8=;
 b=ZvOH6oadbUhQCs7p4iUqgMALsXiaqlWbIl1E8qkBjFNfXujDXH0QxVnNtH7tJ04lHIqXBlw5f
 eqyCIRFyg/GhrgImU1kTgXqPtRFueJLG7r3sF3DP5/lo4eiNdpswlhx7yUro03FgPsGPhkUMkIo
 I7chNLkfXakM67FNZbP/cZdCoGIBv7433MswX46lk8AjKkAmld1FIBpe4ds9GAQnCIThOJ6l20d
 RBxbe8pF93F7fZsfw9gz39j2wFhDgzTM3C+h546Zoeojv7suBybRQIktPX9xwkJyp41YfTXS6sM
 plBe4FNmH0HfapK068+5vUbwN24VnqtCZpfsEhRPl71g==
X-Forward-Email-ID: 67b77508fa03db81fa2f6d2b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.59
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
	u-boot@lists.denx.de
Subject: [PATCH v4] rockchip: rk3308-rock-s0: Fix SD-card boot on v1.1 hw
 revision
Date: Thu, 20 Feb 2025 18:31:28 +0000
Message-ID: <20250220183131.355031-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
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

BootROM leave GPIO4_D6 configured as SDMMC_PWREN function and DW MMC
driver set PWREN high in dwmci_init().

However, HW revision prior to v1.2 must pull GPIO4_D6 low to access
sdmmc. For HW revision v1.2 the state of GPIO4_D6 has no impact.

Upstream Linux commit 26c100232b09 "arm64: dts: rockchip: Fix sdmmc
access on rk3308-rock-s0 v1.1 boards" fixed this issue by adding a
vcc_sd regulator.

Include the new vcc_sd regulator in SPL and enable required Kconfig
options to set GPIO4_D6 low to fix reading sdmmc on v1.1 hw revision.

Fixes: 25438c40a007 ("board: rockchip: Add Radxa ROCK S0")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v4:
- Rebase on master, drop the applied dts/upstream patch
v3:
- Drop sdmmc_2030 and vcc_sd nodes now added to board DT in dts/upstream
v2:
- Rebased to fix clean apply on master
- Collect r-b tags
---
 arch/arm/dts/rk3308-rock-s0-u-boot.dtsi | 12 ++++++++++++
 configs/rock-s0-rk3308_defconfig        |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
index 84ca2ee0d5fb..c8c56b17a154 100644
--- a/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
+++ b/arch/arm/dts/rk3308-rock-s0-u-boot.dtsi
@@ -7,6 +7,14 @@
 	bootph-some-ram;
 };
 
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&sdmmc_2030 {
+	bootph-pre-ram;
+};
+
 &uart0 {
 	bootph-all;
 	clock-frequency = <24000000>;
@@ -16,6 +24,10 @@
 	bootph-all;
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
2.48.1

