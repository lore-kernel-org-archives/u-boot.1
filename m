Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A802AC369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:31:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BEA682998;
	Fri, 25 Apr 2025 19:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hiO6eWyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB19829F9; Fri, 25 Apr 2025 19:31:32 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF60082991
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHVO7E2848245
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 12:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745602284;
 bh=SAPl+jGwv10EDs1uGzD9hvBlXZL27rXLgyplucbXHuM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hiO6eWyMdbXRInll6HJpmKFQrDP8jsk7g3+pwzNUdRbRrtJwefUIYmkgo8HTMUP9L
 227HgEvXVU2rFRvXi09GhcQjs/+yZAv83nLI1DFRGemME7f+ahNEOYPvJLzmyeA8Kl
 6lZ8acWsruYpvG6yyTOvkvL0jP6re5ZvHZQ00lT0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHVOWV079507
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 12:31:24 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 12:31:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 12:31:22 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PHVNaF110074;
 Fri, 25 Apr 2025 12:31:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 8/9] configs: am67a_beagley_ai_a53: Enable additional features
Date: Fri, 25 Apr 2025 12:31:18 -0500
Message-ID: <20250425173120.141503-9-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250425173120.141503-1-nm@ti.com>
References: <20250425173120.141503-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Enable basic EFI debug features, switch over to stdboot, enable GPIO,
LED and PMIC used on this platform. And enable UHS mode support for SD
cards in U-Boot.

Unlike other BeagleBoard products, BeagleY-AI does not have
alternative onboard non-volatile memories, so capsule support does not
make sense.

Acked-by: Andrew Davis <afd@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v2:
- None

V2: https://lore.kernel.org/r/20250418193943.953952-9-nm@ti.com

 configs/am67a_beagley_ai_a53_defconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/configs/am67a_beagley_ai_a53_defconfig b/configs/am67a_beagley_ai_a53_defconfig
index cbf19a03b136..9a5172cda1f3 100644
--- a/configs/am67a_beagley_ai_a53_defconfig
+++ b/configs/am67a_beagley_ai_a53_defconfig
@@ -32,7 +32,7 @@ CONFIG_AUTOBOOT_KEYED=y
 CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
 CONFIG_AUTOBOOT_DELAY_STR="d"
 CONFIG_AUTOBOOT_STOP_STR=" "
-CONFIG_BOOTCOMMAND="run findfdt; run envboot; run distro_bootcmd"
+CONFIG_BOOTCOMMAND="run set_led_state_start_load; run envboot; bootflow scan -lb; run set_led_state_fail_load"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
@@ -49,7 +49,9 @@ CONFIG_SPL_RAM_DEVICE=y
 CONFIG_SPL_THERMAL=y
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_CLK=y
+CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_UPSTREAM=y
@@ -81,6 +83,10 @@ CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_DA8XX_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_LED=y
+CONFIG_SPL_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SPL_LED_GPIO=y
 CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_I2C_EEPROM=y
@@ -88,6 +94,7 @@ CONFIG_SPL_I2C_EEPROM=y
 CONFIG_FS_LOADER=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_SPL_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
@@ -99,12 +106,15 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65219=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_SPL_DM_REGULATOR_GPIO=y
+CONFIG_DM_REGULATOR_TPS65219=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_RESET_TI_SCI=y
 CONFIG_DM_SERIAL=y
-- 
2.47.0

