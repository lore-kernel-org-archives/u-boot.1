Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C96DEE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 11:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BFCF864F8;
	Tue, 22 Aug 2023 13:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fb+HcfUE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2A268649F; Tue, 22 Aug 2023 13:22:58 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB121864C3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 13:22:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so11117941a12.1
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 04:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692703375; x=1693308175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VbzBZZOv27G0xrUBBm9zpxlMpDtslDW/hwhUbkq6lCE=;
 b=Fb+HcfUEd0ueLYd/5hsUeJOvD1tt6p/0IR4U3RTZyv5Xxpt/9fHDO925RThy+oS3hg
 +5I1Z7pdrKjpextkWOf8/NPLW1YHy7M073GiBrkDZOw/lnEQYJ5M/2MeM0+1JvmkL72Z
 BfpULPOCaz0vdTVJGBao6lxe6EsAmGBJBu4zKkpQ1fWVhDEj8wTSc7qjVBAgjt1DrTj4
 rTMYTX1UdkZ28yKYKoic1H5JDObcjvFItQbw6tFYIc1GUq5CgTRe09cqonQUVHJZVObt
 5xLxGW7xmn8DgyN7VHN/ZBbKJ+kNGG8Mu/OIKbFrZ1MUAzb6Y2s64skj9k2/7IvNHA1N
 X55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692703375; x=1693308175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbzBZZOv27G0xrUBBm9zpxlMpDtslDW/hwhUbkq6lCE=;
 b=axRLlNvLfilSZZ/3qV7YTKn4TJdLFG5ltjDxQbvM9s52NPvKe2Z1CgJtSVyOaOkbhc
 EPQSKQO2+rffs+5oh+ehstYWds0ug7kLADkL8d7Ohq+ZdaoEcqBjDNFNL2r4ABtdidmg
 cocKcMIP+dCMZQ2YYXCdVioXbIkDeecbT/MP2pjBaW2XTKH3iVeZ/Lik8j7YCot5GADn
 PMZT0cpQfUwO3OHTdsuvFuB5GxtAKc1a6nLqfxR9gLkltZCroAKSKGMhxjocBiiJlfwV
 RvZgaawGuM21HKU3U3o351RmVCTO2YVuzJDv7RzkUhUfDOgX7AJJjcle1QkTSh0wU+0K
 Rl2A==
X-Gm-Message-State: AOJu0Yyj0QtPHKfqCGrgvagN9f3xzc1dFrMIfiFT/Zew6mNgXH5hHSfs
 HjKAYHmWaJz4op79bZ0skM9FgFkH7z9FgA==
X-Google-Smtp-Source: AGHT+IHgzC+WLdGNYgKHhjCMOLB4Bt1z4ti2KHgbNHsnaPN0yJ1HlpXuyewtzTyeSQqunMWDq7+Fwg==
X-Received: by 2002:a17:907:763a:b0:9a1:b144:30f4 with SMTP id
 jy26-20020a170907763a00b009a1b14430f4mr2975952ejc.14.1692703375270; 
 Tue, 22 Aug 2023 04:22:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.52]) by smtp.gmail.com with ESMTPSA id
 mh9-20020a170906eb8900b009934855d8f1sm8041456ejb.34.2023.08.22.04.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 04:22:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 18/19] board: tegra30: switch to config version of TZ remove
Date: Tue, 22 Aug 2023 14:22:16 +0300
Message-Id: <20230822112217.4646-19-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822112217.4646-1-clamor95@gmail.com>
References: <20230822112217.4646-1-clamor95@gmail.com>
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

Switch to defconfig version of TrustZone nodes remove.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/grouper/grouper.c                 | 12 ------------
 board/asus/transformer-t30/transformer-t30.c | 12 ------------
 board/htc/endeavoru/endeavoru.c              | 12 ------------
 board/lg/x3-t30/x3-t30.c                     |  4 ----
 configs/endeavoru_defconfig                  |  2 +-
 configs/grouper_common_defconfig             |  2 +-
 configs/transformer_t30_defconfig            |  2 +-
 configs/x3_t30_defconfig                     |  1 +
 8 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/board/asus/grouper/grouper.c b/board/asus/grouper/grouper.c
index 5398ec8b9f..3d5d175233 100644
--- a/board/asus/grouper/grouper.c
+++ b/board/asus/grouper/grouper.c
@@ -9,7 +9,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
@@ -177,14 +176,3 @@ void pin_mux_mmc(void)
 #endif
 }
 #endif	/* MMC */
-
-#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	/* Remove TrustZone nodes */
-	fdt_del_node_and_alias(blob, "/firmware");
-	fdt_del_node_and_alias(blob, "/reserved-memory/trustzone@bfe00000");
-
-	return 0;
-}
-#endif
diff --git a/board/asus/transformer-t30/transformer-t30.c b/board/asus/transformer-t30/transformer-t30.c
index ba795a802e..6e5f24418d 100644
--- a/board/asus/transformer-t30/transformer-t30.c
+++ b/board/asus/transformer-t30/transformer-t30.c
@@ -11,7 +11,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
@@ -151,14 +150,3 @@ void pin_mux_mmc(void)
 	tps65911_voltage_init();
 }
 #endif	/* MMC */
-
-#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	/* Remove TrustZone nodes */
-	fdt_del_node_and_alias(blob, "/firmware");
-	fdt_del_node_and_alias(blob, "/reserved-memory/trustzone@bfe00000");
-
-	return 0;
-}
-#endif
diff --git a/board/htc/endeavoru/endeavoru.c b/board/htc/endeavoru/endeavoru.c
index e1a0b242e2..e55f4107c8 100644
--- a/board/htc/endeavoru/endeavoru.c
+++ b/board/htc/endeavoru/endeavoru.c
@@ -9,7 +9,6 @@
 
 #include <common.h>
 #include <dm.h>
-#include <fdt_support.h>
 #include <i2c.h>
 #include <log.h>
 #include <asm/arch/pinmux.h>
@@ -91,14 +90,3 @@ void pin_mux_mmc(void)
 	tps80032_voltage_init();
 }
 #endif	/* MMC */
-
-#if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
-int ft_board_setup(void *blob, struct bd_info *bd)
-{
-	/* Remove TrustZone nodes */
-	fdt_del_node_and_alias(blob, "/firmware");
-	fdt_del_node_and_alias(blob, "/reserved-memory/trustzone@bfe00000");
-
-	return 0;
-}
-#endif
diff --git a/board/lg/x3-t30/x3-t30.c b/board/lg/x3-t30/x3-t30.c
index a08e00dd87..6578567f06 100644
--- a/board/lg/x3-t30/x3-t30.c
+++ b/board/lg/x3-t30/x3-t30.c
@@ -156,10 +156,6 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 	fdt_find_and_setprop(blob, "/serial@70006200/bluetooth",
 			     "local-bd-address", btmacaddr, 6, 1);
 
-	/* Remove TrustZone nodes */
-	fdt_del_node_and_alias(blob, "/firmware");
-	fdt_del_node_and_alias(blob, "/reserved-memory/trustzone@bfe00000");
-
 	return 0;
 }
 #endif
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index feb481170a..cd6ec9ddca 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -13,10 +13,10 @@ CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_PROMPT="Tegra30 (Endeavoru) # "
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_TEGRA30=y
+CONFIG_TEGRA_REMOVE_TZ_NODES=y
 CONFIG_TARGET_ENDEAVORU=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
diff --git a/configs/grouper_common_defconfig b/configs/grouper_common_defconfig
index 36ad0980e7..42f7a11ee3 100644
--- a/configs/grouper_common_defconfig
+++ b/configs/grouper_common_defconfig
@@ -13,10 +13,10 @@ CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_PROMPT="Tegra30 (Grouper) # "
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_TEGRA30=y
+CONFIG_TEGRA_REMOVE_TZ_NODES=y
 CONFIG_TARGET_GROUPER=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index eaff0697bb..094b358822 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -13,10 +13,10 @@ CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_PROMPT="Tegra30 (Transformer) # "
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_TEGRA30=y
+CONFIG_TEGRA_REMOVE_TZ_NODES=y
 CONFIG_TARGET_TRANSFORMER_T30=y
 CONFIG_CMD_EBTUPDATE=y
 CONFIG_SYS_LOAD_ADDR=0x82000000
-CONFIG_OF_BOARD_SETUP=y
 CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_BOOTDELAY=0
 CONFIG_AUTOBOOT_KEYED=y
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 98744ec89d..bb6fbb4041 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -13,6 +13,7 @@ CONFIG_SPL_TEXT_BASE=0x80108000
 CONFIG_SYS_PROMPT="Tegra30 (x3) # "
 CONFIG_SPL_STACK=0x800ffffc
 CONFIG_TEGRA30=y
+CONFIG_TEGRA_REMOVE_TZ_NODES=y
 CONFIG_TARGET_X3_T30=y
 CONFIG_TEGRA_ENABLE_UARTD=y
 CONFIG_CMD_EBTUPDATE=y
-- 
2.39.2

