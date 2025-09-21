Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E173CAC59A
	for <u-boot@archiver.kernel.org>; Sun, 21 Sep 2025 17:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46D8B8340C;
	Sun, 21 Sep 2025 19:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eIxFZ0P5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED3D28317B; Sun, 21 Sep 2025 19:43:37 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3820D832DA
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 19:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-57d5ccd73dfso598986e87.0
 for <u-boot@lists.denx.de>; Sun, 21 Sep 2025 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758476614; x=1759081414; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tK2l88iZH0OAC5xd+W43AGEV+RpdNVvWysqDOi8slo=;
 b=eIxFZ0P5kKhjOgnNr5mFdWoloA2nBJel4O3S2X6nDzQI1CnUKrQEWtuc7/Jejb5fhk
 cBkOsKgMa46QBcGVgsgQl30Z61SgHZCMNOixaviqLkrQshFTsvwVeRJrDZyQ0QmyOYPX
 P1tYvQuYOJjOSoheIcqm0EWH7o46DceenO/QJYqmninWXB6vfBW7/iIbc/De0ogs0w+a
 Abm+TMG391sYA8O/qYz9stMs6YrenWsSxALwIefQwPXKT5FE9NUA46Ch4ka7EIdt4Mvs
 q23YSiHYkqTk4N6yl//qakoUMgQYwCTF/jsmj90jljRK9arYdsNZ+hfCuLnVynHhNPam
 NdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758476614; x=1759081414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tK2l88iZH0OAC5xd+W43AGEV+RpdNVvWysqDOi8slo=;
 b=C91xe1xhyESlFwRnbvR0/9Pr+6KzC2V+V22Ljsvst6jEQmcN5bd5atRIOpGArTeIyE
 Fbp6BaEnynUFL7541VFLIoziHo/7HlC97aFmLbh9EBAsNtUicK9SpBP5S2Kz6kJc5aS7
 ZrQKTgk7Zgck/nUlW4KGTdHsuWqCvXSVI9krHBYCiRgNfEop6Hqs1pKQaxwDYFHvo3Zt
 jDCNgx7X0gNh/WSyqaYRe9+UPCd4hx90O9AIln46lRlx2dfReprF9mRH1YQDMglpwRwh
 JlOVrwTGPoLs0UzQzsjmIqIwMRYfCTlHiuL2ZwjKmzQmZqg8Ym/j603ypLMhrVgOXVqt
 mzZw==
X-Gm-Message-State: AOJu0YwAdsOclkcCWPAylfCBlfXIYmvXovY15j0DkmD5Jqlp+fO+O4GN
 sycyVoPSLq+jBxXbuCpjrV4D8IHhYmESM2rjfeqX1hIO3KGjZRhWjhZc
X-Gm-Gg: ASbGncvDRn+whPZ1t4r+2C0sHE9EKEw8NMebPsbXxkWUXlv/6ghNZf7btUrGPhdyxCz
 N/tmazsYuAGHKt9ZGRWYQDpwgiMW+ZBzwqpsLcPqyEuiKqTm9sXLspfDxX7kr4/94A4CmTwvotn
 hh0zRZNWiwt06vLo+tGlygy0cV7qxcP57eXiUhrPxB97ib9aWDxgrT0rd/NygnIozW9mkzLZ5Hf
 5NPtoDpwW0EOd/QWzeX3JVgnDoyiEEaAwCPIss050NymPUDfs2zQRPv/A0GJmTrqMj9RYpAC/Fo
 y5tif7WvUN0ZFdo+z03yARlXcIzxJnEmcGtdA6dQhWSE1mnQFl2pwksKh9Bm/yI+8qFsJEo1wch
 cfsi4GQivHyKCovvE6j+25loy
X-Google-Smtp-Source: AGHT+IFo5+9LiMZwKbScqgjXu0QWQvI89KotrysYihh7T5qXPqY+ihU1bmLo9MUw3tS2BunP3uugRA==
X-Received: by 2002:a05:651c:3254:20b0:336:c310:6ff9 with SMTP id
 38308e7fff4ca-36417e1f8b9mr25716971fa.19.1758476614118; 
 Sun, 21 Sep 2025 10:43:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.70]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-36815abf943sm8473761fa.61.2025.09.21.10.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Sep 2025 10:43:33 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] configs: tegra: remove ATAGS support
Date: Sun, 21 Sep 2025 20:43:12 +0300
Message-ID: <20250921174312.154990-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250921174312.154990-1-clamor95@gmail.com>
References: <20250921174312.154990-1-clamor95@gmail.com>
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

Remove support for ATAGS-based OS booting. ATAGS are used for booting
older Linux kernel versions and we are moving away from using those.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 configs/chagall_defconfig         | 3 ---
 configs/endeavoru_defconfig       | 3 ---
 configs/grouper_defconfig         | 3 ---
 configs/ideapad-yoga-11_defconfig | 3 ---
 configs/mocha_defconfig           | 3 ---
 configs/mot_defconfig             | 3 ---
 configs/n1_defconfig              | 3 ---
 configs/ouya_defconfig            | 3 ---
 configs/picasso_defconfig         | 3 ---
 configs/qc750_defconfig           | 3 ---
 configs/star_defconfig            | 3 ---
 configs/surface-2_defconfig       | 3 ---
 configs/surface-rt_defconfig      | 3 ---
 configs/tegratab_defconfig        | 3 ---
 configs/tf701t_defconfig          | 3 ---
 configs/transformer_t20_defconfig | 3 ---
 configs/transformer_t30_defconfig | 3 ---
 configs/x3_t30_defconfig          | 3 ---
 18 files changed, 54 deletions(-)

diff --git a/configs/chagall_defconfig b/configs/chagall_defconfig
index 3acb7d53727..1688b4c4d07 100644
--- a/configs/chagall_defconfig
+++ b/configs/chagall_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="chagall"
diff --git a/configs/endeavoru_defconfig b/configs/endeavoru_defconfig
index 804b00697a1..165c0996038 100644
--- a/configs/endeavoru_defconfig
+++ b/configs/endeavoru_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="endeavoru"
diff --git a/configs/grouper_defconfig b/configs/grouper_defconfig
index b9068e18b03..b6c9550bbbc 100644
--- a/configs/grouper_defconfig
+++ b/configs/grouper_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="grouper"
diff --git a/configs/ideapad-yoga-11_defconfig b/configs/ideapad-yoga-11_defconfig
index d5befae419d..68ca8333019 100644
--- a/configs/ideapad-yoga-11_defconfig
+++ b/configs/ideapad-yoga-11_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="ideapad-yoga-11"
diff --git a/configs/mocha_defconfig b/configs/mocha_defconfig
index ab8cea69a02..ded43ccea58 100644
--- a/configs/mocha_defconfig
+++ b/configs/mocha_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_LEN=0x2500000
 CONFIG_NR_DRAM_BANKS=2
diff --git a/configs/mot_defconfig b/configs/mot_defconfig
index dc6549cba76..f6066b9e149 100644
--- a/configs/mot_defconfig
+++ b/configs/mot_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="mot"
diff --git a/configs/n1_defconfig b/configs/n1_defconfig
index 9bba6db99b5..1940a2208a9 100644
--- a/configs/n1_defconfig
+++ b/configs/n1_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="n1"
diff --git a/configs/ouya_defconfig b/configs/ouya_defconfig
index 60cc3796c5e..e82f65a9a86 100644
--- a/configs/ouya_defconfig
+++ b/configs/ouya_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="ouya"
diff --git a/configs/picasso_defconfig b/configs/picasso_defconfig
index f5c6619a271..9d153694245 100644
--- a/configs/picasso_defconfig
+++ b/configs/picasso_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="picasso"
diff --git a/configs/qc750_defconfig b/configs/qc750_defconfig
index 3f85890bdbd..2be3838ae60 100644
--- a/configs/qc750_defconfig
+++ b/configs/qc750_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="qc750"
diff --git a/configs/star_defconfig b/configs/star_defconfig
index 38cbdec1c3a..59eabdcb2b4 100644
--- a/configs/star_defconfig
+++ b/configs/star_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="star"
diff --git a/configs/surface-2_defconfig b/configs/surface-2_defconfig
index 6e287539f53..d3e6166cf89 100644
--- a/configs/surface-2_defconfig
+++ b/configs/surface-2_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_LEN=0x2500000
 CONFIG_NR_DRAM_BANKS=2
diff --git a/configs/surface-rt_defconfig b/configs/surface-rt_defconfig
index 4cd543ccb9c..88b67749095 100644
--- a/configs/surface-rt_defconfig
+++ b/configs/surface-rt_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="surface-rt"
diff --git a/configs/tegratab_defconfig b/configs/tegratab_defconfig
index 00a0843d4d0..27cb75c92b5 100644
--- a/configs/tegratab_defconfig
+++ b/configs/tegratab_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_LEN=0x2500000
 CONFIG_NR_DRAM_BANKS=2
diff --git a/configs/tf701t_defconfig b/configs/tf701t_defconfig
index a9976bf0388..e8f920587c3 100644
--- a/configs/tf701t_defconfig
+++ b/configs/tf701t_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_SYS_MALLOC_LEN=0x2500000
 CONFIG_NR_DRAM_BANKS=2
diff --git a/configs/transformer_t20_defconfig b/configs/transformer_t20_defconfig
index c0a5a2fd02c..61eab59fa3b 100644
--- a/configs/transformer_t20_defconfig
+++ b/configs/transformer_t20_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x00110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="transformer-t20"
diff --git a/configs/transformer_t30_defconfig b/configs/transformer_t30_defconfig
index eb3e41e68c5..6f8953aa103 100644
--- a/configs/transformer_t30_defconfig
+++ b/configs/transformer_t30_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SOURCE_FILE="transformer-t30"
diff --git a/configs/x3_t30_defconfig b/configs/x3_t30_defconfig
index 3081d1203cf..82fff349210 100644
--- a/configs/x3_t30_defconfig
+++ b/configs/x3_t30_defconfig
@@ -1,8 +1,5 @@
 CONFIG_ARM=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_SUPPORT_PASSING_ATAGS=y
-CONFIG_CMDLINE_TAG=y
-CONFIG_INITRD_TAG=y
 CONFIG_TEXT_BASE=0x80110000
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_ENV_SIZE=0x3000
-- 
2.48.1

