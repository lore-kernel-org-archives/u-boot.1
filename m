Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867E4EE49AB
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 18:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDC88648F;
	Tue, 22 Aug 2023 20:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aq3XySCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D44685CB5; Tue, 22 Aug 2023 20:41:49 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B903386489
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 20:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfeTY050144;
 Tue, 22 Aug 2023 13:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692729700;
 bh=+ZPBU1kPk39LDFGAEGhd8emc8mLiIiYny+twWf/UHuc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aq3XySCSrIM+K7lSjPm0CfapIbK9w96wvsxEPMxOirslASjsaSVYYP2lJBUx0TG1a
 Rk3mcofkBOVMbwUDYFdfwue24zrEhDswm2OY54EC1t+H40W3ulxp7Ypo050YEPEw2m
 vjiFikd4jtDSi3qkRnkL2sjNVf0n8f89BNiKknJQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MIfetY059784
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 13:41:40 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 13:41:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 13:41:40 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MIfefn004227;
 Tue, 22 Aug 2023 13:41:40 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
CC: Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>, Robert
 Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 <u-boot@lists.denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH V4 1/8] env_default: Allow CONFIG_EXTRA_ENV_TEXT to override
 CFG_EXTRA_ENV_SETTINGS
Date: Tue, 22 Aug 2023 13:41:28 -0500
Message-ID: <20230822184135.2328409-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230822184135.2328409-1-nm@ti.com>
References: <20230822184135.2328409-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

CFG_EXTRA_ENV_SETTINGS is set in common board config files, This allows
for majority of the settings to be set in a common manner. However, the
minor variations between various board can be addressed by the board.env
files. The board.env files are converted into CONFIG_EXTRA_ENV_TEXT.

However, this creates a minor problem. For example:
distro_bootcmd.h and used by ti_armv7_common.h uses it as:
 #define BOOT_TARGET_DEVICES(func) \
	func(MMC, mmc, 0) \
	func(MMC, mmc, 1)

Which in turn generates:
boot_targets=mmc0 mmc1

And this probably works fine for most boards, However when the
boot_targets need to be reversed, the preferred behavior would have been
to define it in board.env file as:
boot_targets=mmc1 mmc0

By changing the order of the inclusion, we allow for the
CONFIG_EXTRA_ENV_TEXT to have a higher priority in the definition.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Cc: Simon Glass <sjg@chromium.org>

New patch

 include/env_default.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/env_default.h b/include/env_default.h
index b16c22d5a28c..714dfa9e845e 100644
--- a/include/env_default.h
+++ b/include/env_default.h
@@ -112,12 +112,12 @@ const char default_environment[] = {
 #ifdef CONFIG_MTDPARTS_DEFAULT
 	"mtdparts="	CONFIG_MTDPARTS_DEFAULT		"\0"
 #endif
+#ifdef	CFG_EXTRA_ENV_SETTINGS
+	CFG_EXTRA_ENV_SETTINGS
+#endif
 #ifdef CONFIG_EXTRA_ENV_TEXT
 	/* This is created in the Makefile */
 	CONFIG_EXTRA_ENV_TEXT
-#endif
-#ifdef	CFG_EXTRA_ENV_SETTINGS
-	CFG_EXTRA_ENV_SETTINGS
 #endif
 	"\0"
 #else /* CONFIG_USE_DEFAULT_ENV_FILE */
-- 
2.40.0

