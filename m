Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2308109C059
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7FD58413A;
	Wed, 25 Mar 2026 20:00:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lMJQs/HA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9564684137; Wed, 25 Mar 2026 20:00:52 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E345A84132
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:00:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-46808125c65so53754b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774465248; x=1775070048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk5EkhXR2cl4+zOsKwBGCy4YOcynAFNgBDiyUu9jzYE=;
 b=lMJQs/HA+UEWD8/F01Dc+K0wGeHP+Ja306+FeZJWinPfKeYp9TA1HSuXezOQsog9Bq
 ftwg4pscHHcgT9NAKlXXTpwX0NSAzZzFtjzR07N3y7jrMKp6q2iMpun6GUysFryGG6eb
 Sl2FsKP08YcH+xkIbLPVuq8+e8d9CVhKxALnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774465248; x=1775070048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk5EkhXR2cl4+zOsKwBGCy4YOcynAFNgBDiyUu9jzYE=;
 b=OBIAXR2WXaT7S7dWkOCS9anlOPvvLDI5rCPEzKMv2mQPTQ5mGqQDNfANwOWhhe/Fxf
 oA40VXeiCSNAoLaaidYFPhfi/oCW8KWE6M2fwdsS1fPvWcifkqVDGx2mQmzXZm1pmoCt
 ZJqxylCjN1sI7Dk38/39N1G9L/m7R8RzSEQqkKVtwbXMflh+Pbl06CBn5n4qiHQQLdQR
 5dIWiYximiEXbvKas6jmC583Wz5gtuzf4z+Qk5zuAhbfInNndBdFEvXfdC/jrHWC9mHs
 GmDV+eWdDFq6zMMXjnbzYhxgJnfGPPK8ZQnuHq5OAvIsbsp4Ut4EayOLZzh9ihrklLE8
 mTjw==
X-Gm-Message-State: AOJu0Yyrdd5YCRItJnIRZISlLtCG0+z7oZPiE6Ptz5QNAHF/Jbbl5h2i
 HvRPCjmeWNUXEuu9KB6Mg5eBER4kRMqhlupzl4hTuoyU+J5pRmCijf3Hi3bDd6G20JxQgQz6G9l
 qA3IvGPI=
X-Gm-Gg: ATEYQzySlr0tK54MQlxmeouZosrOLRw9AogAuD8IiVQNUWDx+b5d1H45PUhtxjzZZrQ
 ECjDETc/0dLHNYR4n4wMzoPjJWtGR9FwQWnAGk+n6NJX+qHd+sPX9VXSh0kAyABaUiCMgn7Tvsc
 zgQq/WnbJNUYKVpxf0rXv4OYqB4KktTDWqRHzlS/zUcd7CdFU/pNRowt26MkLtz+dq29zSFEFVD
 SzjOGAnsFVrlB8PlPgEXJ2tkBQMtt2sTalBIWfNGum2GV7H1dc2c48olxa6ckvdhGabNNTM80Az
 WQbi019WdwyUgmQjdBERm+tEql2XDsXMS9SL8egES6/wb5Cakyx6H7rDuO+f3KCokt/3JCv0IBR
 qMYmYPVol+e7qoIsSw0EQXkrM9uZ6UHomI6FRNiqqU1XLCqxI+y2P6IyQ5al/xtYmvqCFXQpeFU
 cl/q0bjZMV5slht6XAzuUlNM2KQbbRgVSPIR820G7f6I8T7Rlt2P/XXcwCT7opNokPEpTobOh69
 gAnCMAcIuZexUQ4L74K1+20OgsRylzgeD3v1B5knS40lmbvsl4=
X-Received: by 2002:a05:6808:1582:b0:467:14c7:a8ba with SMTP id
 5614622812f47-46a5c6e70d1mr2414354b6e.32.1774465248498; 
 Wed, 25 Mar 2026 12:00:48 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d9e71f6815sm407607a34.15.2026.03.25.12.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 12:00:48 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Angus Ainslie <angus@akkea.ca>,
	kernel@puri.sm
Subject: [PATCH] librem5: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 25 Mar 2026 13:00:47 -0600
Message-ID: <20260325190047.3428806-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
do-nothing board_early_init_f function. Change to not enabling the
option and so not needing an empty function.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: kernel@puri.sm
---
 board/purism/librem5/librem5.c | 5 -----
 board/purism/librem5/spl.c     | 2 --
 configs/librem5_defconfig      | 1 -
 3 files changed, 8 deletions(-)

diff --git a/board/purism/librem5/librem5.c b/board/purism/librem5/librem5.c
index a2bc0c08f0b5..3640ef232c8c 100644
--- a/board/purism/librem5/librem5.c
+++ b/board/purism/librem5/librem5.c
@@ -31,11 +31,6 @@
 #include <usb/xhci.h>
 #include "librem5.h"
 
-int board_early_init_f(void)
-{
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_LOAD_ENV_FROM_MMC_BOOT_PARTITION)
 uint board_mmc_get_env_part(struct mmc *mmc)
 {
diff --git a/board/purism/librem5/spl.c b/board/purism/librem5/spl.c
index 568224f97324..a104ee5c2aab 100644
--- a/board/purism/librem5/spl.c
+++ b/board/purism/librem5/spl.c
@@ -547,8 +547,6 @@ void board_init_f(ulong dummy)
 	gpio_direction_output(WIFI_EN, 1);
 #endif
 
-	board_early_init_f();
-
 	timer_init();
 
 	preloader_console_init();
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index e6ad27ed1bf8..d9d32bf5a50a 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -36,7 +36,6 @@ CONFIG_OF_SYSTEM_SETUP=y
 CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_CONSOLE_IS_IN_ENV=y
 # CONFIG_SYS_DEVICE_NULLDEV is not set
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_BOARD_INIT=y
-- 
2.43.0

