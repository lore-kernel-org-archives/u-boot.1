Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFBED2B944
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB28C891B8;
	Tue,  5 Nov 2024 17:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="suA9g9nX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 004928900E; Tue,  5 Nov 2024 17:01:26 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98550891B8
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822477; bh=YP2NRGoH0Pgu/TKAeJ+3Wqs7aYivqY1uVSoqLa2wBaM=;
 b=suA9g9nXqhonrnUZ07fmavsulun8kR6KMixDntK684IIzgvgA8y7oKslhJSwPAO2+oEIpAcoX
 Gxgh3NfSNY5kLL9UK/xYj6UURHwg3W7TtX+BGjq1MeZyiUMtAftZPDToEgzhYv5VioZW6NOBmoO
 /te8nQgApK/ZGhx61F3hBrqFMPvQpwGjEvKTK4oE0Np5OdKp2VnVz6xNMoJtsy2VV/VxN6OL333
 iOke224IiOtnagH0J2cLlgKjlvFvPv7SBS9KN6Bg6yuzBHwvC5+rP9xGfGMBtEDFUTkccGLiBqV
 XlUmrJSBWGgmDmPjqntFbJkbLs9uwrnxSwhiV+/GBX6A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 04/13] rockchip: rk3288-tinker: Drop unused vcc_sd regulator
 from SPL
Date: Tue,  5 Nov 2024 16:00:27 +0000
Message-ID: <20241105160054.1373319-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a414cff3e144e4725e0d8
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

The sdmmc power come from vcc33_sd pmic regulator and not from the
vcc_sd fixed regulator, as currently defined in the in-tree DT.

Drop vcc_sd and the related gpio7 and sdmmc_pwr nodes from being
included in SPL along with any related Kconfig option. Also enable
SPL_DM_SEQ_ALIAS to ensure aliases is handled correctly in SPL.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-tinker-u-boot.dtsi | 9 ---------
 configs/tinker-rk3288_defconfig        | 7 +------
 configs/tinker-s-rk3288_defconfig      | 7 +------
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/dts/rk3288-tinker-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
index 1665e4f5d10f..4f230739f1c3 100644
--- a/arch/arm/dts/rk3288-tinker-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-u-boot.dtsi
@@ -18,7 +18,6 @@
 
 &gpio7 {
 	/delete-property/ bootph-all;
-	bootph-pre-ram;
 };
 
 &i2c2 {
@@ -64,10 +63,6 @@
 	bootph-pre-ram;
 };
 
-&sdmmc_pwr {
-	bootph-pre-ram;
-};
-
 &uart2 {
 	bootph-all;
 };
@@ -76,7 +71,3 @@
 	bootph-pre-sram;
 	bootph-pre-ram;
 };
-
-&vcc_sd {
-	bootph-pre-ram;
-};
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 42dbef9c2c30..aff820ebfdda 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -4,7 +4,6 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
-CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
@@ -33,8 +32,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_I2C=y
-CONFIG_SPL_POWER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -54,6 +51,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -74,10 +72,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_SPL_PMIC_RK8XX=y
-CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index e62a03e066cc..6aef775a5717 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -5,7 +5,6 @@ CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_SYS_MALLOC_F_LEN=0x4000
-CONFIG_SPL_GPIO=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
@@ -33,8 +32,6 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
 CONFIG_SPL_NO_BSS_LIMIT=y
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_I2C=y
-CONFIG_SPL_POWER=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
@@ -55,6 +52,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigne
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_REGMAP=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SYSCON=y
@@ -75,10 +73,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_RK8XX=y
-CONFIG_SPL_PMIC_RK8XX=y
-CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
-CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_REGULATOR_RK8XX=y
 CONFIG_PWM_ROCKCHIP=y
 CONFIG_RAM=y
-- 
2.46.2

