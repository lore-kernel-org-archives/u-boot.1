Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4379BC369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 08:29:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23E2820EB;
	Thu, 24 Apr 2025 10:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IeTi9kat";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040B481FC0; Thu, 24 Apr 2025 10:29:22 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4FE5815D1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:29:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-317f68d0dffso3597131fa.2
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745483359; x=1746088159; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9DqdhD0wKa4ddNgOzE5HBu2F1GYL/WxfaWgoWU8W4No=;
 b=IeTi9kat5OpEuNwkD7SIGludfgu5nMm5PQ1bYaltUXMItbUdOk9AmJRGgg57Vf7THn
 z++4s6eEpj0diXJd6W7vX3UEWI7flkUd8M1FST/upvl41TAKdjdwawARThJfw+ynZJ/U
 mfKSLU3KqxQqGxDYJ6+Ovrl3yWlb29lo9HlBveYe8kwZ/QP8IW+4cyl+HFTFQ2HVFAQb
 FLGLH+subvCYiLyZ/dFDZ/8IDNsGKMxLiQ6nX79di5TmIXp2jfflnAMIUfpw3PNvESMM
 1CCZV6bYwxTbc8R0huyEJ4lB2uVYmo7ZKecnKpEwWWbRTckOYRD9NUSRCXSlX3sE94fe
 0NOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745483359; x=1746088159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9DqdhD0wKa4ddNgOzE5HBu2F1GYL/WxfaWgoWU8W4No=;
 b=QdvvkKNKvrr+UmZ8gQAX1Yi34gq06VmByR2Sk83EjlgJPW9pHSaSfwTiFrYJTDdovR
 kdx9Y8SIgFkLjlefQz0AnmHPnLSJHnShzVgig2fT/G3Nt62FeGy70BUbY8N7wxC6o7yX
 nKdBBxOqMxhrGd9NFNOrXgah2tUXzpltpZ+rKVFaHg5TAm+BCIHTceiYa5aKRzui++m7
 4ZoyaaI+WwnGQNKosIySDPvR+2pdQydTqm3Y6/KyklAjlt5xkFpWHnl2auPUv5kGvE4r
 5yc26fg5FByAIVsTwZKRAq0Od4xNe8Jz2KhQQHINsrWbzr2G9GCXhRtQayTS9gl308qJ
 lJig==
X-Gm-Message-State: AOJu0YwM2Mf4rUVowklqBqWyYQ2hjhOsPb2NbFWAGmH81NcXKtLqaE3U
 c5neh3wJLUyko3aN/LXnQezORM/nXBsMzYbtYTnZ6XVTDmibjV/E
X-Gm-Gg: ASbGncu1V9VN+q3JPk7C9loKLgL7ngkuxNmMQDxWXknVK+pPWGPsduPp9GCi0HZnSIM
 SQ8UcQupQpT/hAvyNgNOVCOWFhz3Oc5/ll6H9xmhu/JlzzkVEt2/mEzpk0T8fisDEiF2buN2p3O
 C87Uq2HiD02FB9d9nCEIq6to1NZNr3wZveWZdKonm9gWaydzfL1nLc5mUEAxWB4U2xYq2oKqIh9
 HhETz1qRdoWnnnc5AZ9hz76wEWdRzBzmmD2wC0zKdDbDSb2ibloolNRG4VRw51VQwejpt0lgJ8J
 0RhTXU6ezBv+AHEeDwaRFTe1x9rFh3lT
X-Google-Smtp-Source: AGHT+IEPs2H1bRifIea88eq6vdedNyQNb/DQBLQcMZI/FsVlQtEl5FvTbmq27Lp45V1pmSLVWua/AQ==
X-Received: by 2002:a05:651c:1143:b0:30b:b7c3:949a with SMTP id
 38308e7fff4ca-3179e9e90a7mr5928951fa.18.1745483358851; 
 Thu, 24 Apr 2025 01:29:18 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-317d16a832csm1627581fa.67.2025.04.24.01.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 01:29:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Allen Martin <amartin@nvidia.com>, Peter Geis <pgwipeout@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 2/4] ARM: tegra: convert boards to use TEGRA_PRAM
Date: Thu, 24 Apr 2025 11:28:31 +0300
Message-ID: <20250424082834.17538-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424082834.17538-1-clamor95@gmail.com>
References: <20250424082834.17538-1-clamor95@gmail.com>
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

Switch boards that use CFG_PRAM to TEGRA_PRAM.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 board/asus/transformer-t114/Kconfig |  6 +++++-
 board/nvidia/tegratab/Kconfig       |  6 +++++-
 board/xiaomi/mocha/Kconfig          |  6 +++++-
 doc/board/asus/transformer_t114.rst |  2 +-
 doc/board/nvidia/tegratab.rst       |  2 +-
 doc/board/xiaomi/mocha.rst          |  2 +-
 include/configs/mocha.h             | 19 -------------------
 include/configs/tegratab.h          | 19 -------------------
 include/configs/transformer-t114.h  | 19 -------------------
 9 files changed, 18 insertions(+), 63 deletions(-)
 delete mode 100644 include/configs/mocha.h
 delete mode 100644 include/configs/tegratab.h
 delete mode 100644 include/configs/transformer-t114.h

diff --git a/board/asus/transformer-t114/Kconfig b/board/asus/transformer-t114/Kconfig
index 2560c35846e..2d7630422de 100644
--- a/board/asus/transformer-t114/Kconfig
+++ b/board/asus/transformer-t114/Kconfig
@@ -7,10 +7,14 @@ config SYS_VENDOR
 	default "asus"
 
 config SYS_CONFIG_NAME
-	default "transformer-t114"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "ASUS Transformer T114"
 
+config TEGRA_PRAM_SIZE
+	depends on TEGRA_PRAM
+	default 0x20000
+
 endif
diff --git a/board/nvidia/tegratab/Kconfig b/board/nvidia/tegratab/Kconfig
index 8bd7cfd87b8..25468bb57f5 100644
--- a/board/nvidia/tegratab/Kconfig
+++ b/board/nvidia/tegratab/Kconfig
@@ -7,10 +7,14 @@ config SYS_VENDOR
 	default "nvidia"
 
 config SYS_CONFIG_NAME
-	default "tegratab"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "NVIDIA TegraTab"
 
+config TEGRA_PRAM_SIZE
+	depends on TEGRA_PRAM
+	default 0x21c00
+
 endif
diff --git a/board/xiaomi/mocha/Kconfig b/board/xiaomi/mocha/Kconfig
index bb53cc56161..3e1e076986c 100644
--- a/board/xiaomi/mocha/Kconfig
+++ b/board/xiaomi/mocha/Kconfig
@@ -7,10 +7,14 @@ config SYS_VENDOR
 	default "xiaomi"
 
 config SYS_CONFIG_NAME
-	default "mocha"
+	default "tegra"
 
 config TEGRA_BOARD_STRING
 	string "Default Tegra board name"
 	default "Xiaomi Mocha"
 
+config TEGRA_PRAM_SIZE
+	depends on TEGRA_PRAM
+	default 0x38400
+
 endif
diff --git a/doc/board/asus/transformer_t114.rst b/doc/board/asus/transformer_t114.rst
index 3e42b5dd9a3..29094eeeaf4 100644
--- a/doc/board/asus/transformer_t114.rst
+++ b/doc/board/asus/transformer_t114.rst
@@ -36,7 +36,7 @@ To build U-Boot without SPL adjust tf701t_defconfig:
   CONFIG_TEXT_BASE=0x80A00000
   CONFIG_SKIP_LOWLEVEL_INIT=y
   # CONFIG_OF_BOARD_SETUP is not set
-  CONFIG_TEGRA_SUPPORT_NON_SECURE=y
+  CONFIG_TEGRA_PRAM=y
 
 After the build succeeds, you will obtain the final ``u-boot-dtb.bin`` file,
 ready for booting with fastboot boot or which can be further processed into
diff --git a/doc/board/nvidia/tegratab.rst b/doc/board/nvidia/tegratab.rst
index c6d97ce3828..65150fc7fbf 100644
--- a/doc/board/nvidia/tegratab.rst
+++ b/doc/board/nvidia/tegratab.rst
@@ -36,7 +36,7 @@ To build U-Boot without SPL adjust tegratab_defconfig:
   CONFIG_TEXT_BASE=0x80A00000
   CONFIG_SKIP_LOWLEVEL_INIT=y
   # CONFIG_OF_BOARD_SETUP is not set
-  CONFIG_TEGRA_SUPPORT_NON_SECURE=y
+  CONFIG_TEGRA_PRAM=y
 
 After the build succeeds, you will obtain the final ``u-boot-dtb.bin`` file,
 ready for booting with fastboot boot or which can be further processed into
diff --git a/doc/board/xiaomi/mocha.rst b/doc/board/xiaomi/mocha.rst
index be3e333127b..230081e3287 100644
--- a/doc/board/xiaomi/mocha.rst
+++ b/doc/board/xiaomi/mocha.rst
@@ -105,7 +105,7 @@ To build U-Boot without SPL suitable for chainloading adjust mocha_defconfig:
   CONFIG_TEXT_BASE=0x80A00000
   CONFIG_SKIP_LOWLEVEL_INIT=y
   # CONFIG_OF_BOARD_SETUP is not set
-  CONFIG_TEGRA_SUPPORT_NON_SECURE=y
+  CONFIG_TEGRA_PRAM=y
 
 After the build succeeds, you will obtain the final ``u-boot-dtb.bin``
 file, ready for booting using vendor bootloader's fastboot or which can be
diff --git a/include/configs/mocha.h b/include/configs/mocha.h
deleted file mode 100644
index 7255f31baec..00000000000
--- a/include/configs/mocha.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2024, Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra124-common.h"
-
-#ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
-  #define CFG_PRAM                     0x38400 /* 225 MB */
-#endif
-
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/tegratab.h b/include/configs/tegratab.h
deleted file mode 100644
index afab01ec09c..00000000000
--- a/include/configs/tegratab.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2023, Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra114-common.h"
-
-#ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
-  #define CFG_PRAM			0x21c00	/* 135 MB */
-#endif
-
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
diff --git a/include/configs/transformer-t114.h b/include/configs/transformer-t114.h
deleted file mode 100644
index 2fbf3417691..00000000000
--- a/include/configs/transformer-t114.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (c) 2010-2013, NVIDIA CORPORATION.  All rights reserved.
- *
- * Copyright (c) 2023, Svyatoslav Ryhel <clamor95@gmail.com>
- */
-
-#ifndef __CONFIG_H
-#define __CONFIG_H
-
-#include "tegra114-common.h"
-
-#ifdef CONFIG_TEGRA_SUPPORT_NON_SECURE
-  #define CFG_PRAM			0x20000	/* 128 MB */
-#endif
-
-#include "tegra-common-post.h"
-
-#endif /* __CONFIG_H */
-- 
2.43.0

