Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD53E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:12:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5758383C23;
	Mon,  9 Feb 2026 18:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BKXs6OE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D2E480325; Mon,  9 Feb 2026 17:40:27 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20B698341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 17:40:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f18e8f2f5so2971743b6e.3
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 08:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770655224; x=1771260024;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=geKBYFQJwOJyYq27ywssVhSYHix5iEQ+yGdJgZ/QGP0=;
 b=BKXs6OE/pqyy6tN1Tn6a3ymLoyZfMHe5qA4dBepMFShKXErl3zScVbPc9wex6MYhJ6
 7NMcNk04+xgihRQzBC9QKntKULyPhOJ6ea4bDway9VHtb3y2QnaEVOiyJKPJW7mNPo3w
 Cj/HXkzk9xwQDhzXzckzGpHlbyIs1s3B80BFAoV6FRwxgPq4SIEg+KettI4rYA6Puo1v
 eIQDcWfvd/AOc2H4ji9AFz4ENmIaTlfICelKnY5nczgzOQeNxutdPGBl5rvg2ILLoH2k
 hPE779vK8rcqu4W10KZFXqg9ObUXL/iqLi7vNHTR15cGGw20gVjL0+Tk05KMbN9iw/fl
 8dFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770655224; x=1771260024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=geKBYFQJwOJyYq27ywssVhSYHix5iEQ+yGdJgZ/QGP0=;
 b=PRW1zd++R26M6ZWHt9efN2D+/gBT0kF6Es57aq9HiC9IBOd682fjMZZeiJmxYUupas
 mqkwf0Ommc3+84z6R33HLw7zKjmV5eDwkhYjqqK1hiZQKvxCcsIEciIs6e4TNJ3GICHi
 8CJU/DNBg8r72PBsbnTYMxjXAv4tAm8+5HL0RpvmYKBheROvNY852bbQyw0FeQ20yTYb
 a43LpyUxIzPv4ZWOcSDJALeOGY0MgXK7QWi6hNaFdM0C5bDO/2TFn6jc5INpw4crs9Dw
 3qw7q/heLJUbERefvgBj8HlhL/liQl3YQtIdXKNR6g+/IzGvHp3GzdBuYh+kU7iB4fin
 uN+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ5R+CQDzkvsmUVw0zK98jj69nQtHosKsGSEy3j9HgL/nweB4+0QGFSlvQ7vvcpJcqK3O3ff4=@lists.denx.de
X-Gm-Message-State: AOJu0YxcW69l8+eaiiAznvOJvTO52i884SgWn+ivklLO2fCclYFo9gNX
 7vtX4/P5AOv67Ho0PiFOrZWOBAWv3wnHTAVOUAJc4Z0gmJL5DXOSBNHpkCS9q0YiQsM=
X-Gm-Gg: AZuq6aI2LY/S9PwKcrro9mEry+YL27vmzIPX2zOQfVddvNtIBCWxCTegnhHp1LPGMDF
 ErcAojCJWKrruEuHM9WABs6TBIwxw0FFuyLuqEqQnRVLu1bhalKLfNbRtD6pfcTV+dkn4tk8h4n
 MeHcFWlo32Iw0j7q++7f/6CerAcLOGca3IDBQDB1mQAAEWic0IuGAR9hJL8d1G5TnYzJT90i0zk
 1Uq1evIz0nXS3X9Ot/KgUkw5ltYUWPVGD0m7usiWA/VBTHbeg5QzA9TIW/k3QYJqn+7hH8xFawq
 gwY1J7vZRXD9U3WwjAtl4BSw5oRXBkBRVN9VvLB4rkkS0oHFqr7DxfE0MRVgThu28OD11PzF9AS
 SsZ7G6mEt6D3Z05QfjEnZTv0gBTifsQzHoQIzZKigFfEdxKb8b8lcJHcGRKNhSSN4bNG3a3gd0d
 E+mxh/EOlIaJFAQfo=
X-Received: by 2002:a05:6808:1507:b0:45c:9a6e:1ea1 with SMTP id
 5614622812f47-462fccaced4mr5169150b6e.66.1770655223823; 
 Mon, 09 Feb 2026 08:40:23 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785d7esm7731139a34.15.2026.02.09.08.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:40:23 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 10:39:26 -0600
Subject: [PATCH v2 1/7] arm: mediatek: use default weak
 mtk_soc_early_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mach-clean-up-duplicates-v2-1-e3b22282c74d@baylibre.com>
References: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
In-Reply-To: <20260209-mtk-mach-clean-up-duplicates-v2-0-e3b22282c74d@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=9oayJVjxx4HdXQIHQGtfAK1QA1MSrKmbWARaN818r2c=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpig3I1TRbU7/pf1j7/6eNI3ifYzbkuXucxfzQc
 UOFeRU0OCWJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYoNyBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AP24H/RJp+rSYFl2SMMLe1O0GZGRg4BxvxbxmrqklPoT
 fRjqrG33pEFQFD4IIXXrbtm+ez064f42r8caRJGzvT0iS7NCB1wRtP4kBBmQnUlvRFlFvrNlxO+
 DQMgMbPCU4ZjQv1vxxFE+kJhFNYnrM9T8j39DH/kTimKwjq5bTTEFRBlVkRu1I3HJmWLSjV+rpf
 V7a32IH84+nec0P4MGNNiL4AoQQ+8ogRP3UctEPSv/pgOWOXFrbXfGJG7kviX9VnwCtiCqNwJlz
 sLV/9FI+/HvVKQQJSvCzYoO2wmUfgFQqiorNPD7bKTP8McmsquRFD1UCklSu20S5KlU+EGNVLQy
 23zc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 18:12:16 +0100
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

Add a weak default implementation of mtk_soc_early_init() in spl.c to
avoid having to define it in every SoC init.c file that does not need
any additional early initialization.

The init.h header file is no longer needed in this case and is removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
- Also remove header file.
---
 arch/arm/mach-mediatek/init.h        | 11 -----------
 arch/arm/mach-mediatek/mt7623/init.c |  5 -----
 arch/arm/mach-mediatek/mt8183/init.c |  5 -----
 arch/arm/mach-mediatek/mt8188/init.c |  5 -----
 arch/arm/mach-mediatek/mt8365/init.c |  5 -----
 arch/arm/mach-mediatek/spl.c         |  5 ++++-
 6 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-mediatek/init.h b/arch/arm/mach-mediatek/init.h
deleted file mode 100644
index 1d896fbbf7e..00000000000
--- a/arch/arm/mach-mediatek/init.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 MediaTek Inc.
- */
-
-#ifndef __MEDIATEK_INIT_H_
-#define __MEDIATEK_INIT_H_
-
-extern int mtk_soc_early_init(void);
-
-#endif /* __MEDIATEK_INIT_H_ */
diff --git a/arch/arm/mach-mediatek/mt7623/init.c b/arch/arm/mach-mediatek/mt7623/init.c
index 3d6ba3f383c..8713889b92d 100644
--- a/arch/arm/mach-mediatek/mt7623/init.c
+++ b/arch/arm/mach-mediatek/mt7623/init.c
@@ -16,11 +16,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct boot_argument *preloader_param;
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 int dram_init(void)
 {
 	u32 i;
diff --git a/arch/arm/mach-mediatek/mt8183/init.c b/arch/arm/mach-mediatek/mt8183/init.c
index 37243547da8..39072622788 100644
--- a/arch/arm/mach-mediatek/mt8183/init.c
+++ b/arch/arm/mach-mediatek/mt8183/init.c
@@ -42,11 +42,6 @@ int mtk_pll_early_init(void)
 	return 0;
 }
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	psci_system_reset();
diff --git a/arch/arm/mach-mediatek/mt8188/init.c b/arch/arm/mach-mediatek/mt8188/init.c
index ed67150e611..9743e39d582 100644
--- a/arch/arm/mach-mediatek/mt8188/init.c
+++ b/arch/arm/mach-mediatek/mt8188/init.c
@@ -45,11 +45,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	struct udevice *wdt;
diff --git a/arch/arm/mach-mediatek/mt8365/init.c b/arch/arm/mach-mediatek/mt8365/init.c
index 8f03ed28763..fb14a5a1902 100644
--- a/arch/arm/mach-mediatek/mt8365/init.c
+++ b/arch/arm/mach-mediatek/mt8365/init.c
@@ -26,11 +26,6 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-int mtk_soc_early_init(void)
-{
-	return 0;
-}
-
 void reset_cpu(void)
 {
 	struct udevice *wdt;
diff --git a/arch/arm/mach-mediatek/spl.c b/arch/arm/mach-mediatek/spl.c
index 247d7ee6f1d..6f1ec052b95 100644
--- a/arch/arm/mach-mediatek/spl.c
+++ b/arch/arm/mach-mediatek/spl.c
@@ -9,7 +9,10 @@
 #include <init.h>
 #include <spl.h>
 
-#include "init.h"
+__weak int mtk_soc_early_init(void)
+{
+	return 0;
+}
 
 void board_init_f(ulong dummy)
 {

-- 
2.43.0

