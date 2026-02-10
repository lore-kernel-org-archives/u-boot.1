Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865C3EA8126
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFB7C83CF3;
	Tue, 10 Feb 2026 16:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WCzR8mKV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC1883CF3; Tue, 10 Feb 2026 16:15:13 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 105F483CEE
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-501469b598fso32181151cf.3
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736510; x=1771341310; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+gFPd9XePOCHqWZBon5+QcYtCX1WNShR0/IqBZqXJ0=;
 b=WCzR8mKVfEn0MYRcxZ6wvqGKbQemKooiZbgwK5Yl/gdwEXd1iXBmqKAz8cOCJZpms8
 ZsN7t4bq17W4UKgz59ajnz6/Q8y7zDY2MmJfY5Ip/gnvgC511EIkkNdIcjm4U1wD/utT
 i0l25N/nvQcsEEIZz/7SVHzSoRpSeHTUWUcOs50k14HHqvg/GIOKT78M5rmoT8pnUnJ0
 0T0rX86JRdQpVSD9+0azHNCu4Yy5V1z0dBpJBJXKVOwTld+syzTtS2fTVRn1I55yZ5kG
 w0HZ/gvoOPgH1zqsk2NnpMPK45SK7vS3I6qYvf8W8BIX+jaGoZCLQmDtH7SLcpSnJWah
 8rQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736510; x=1771341310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L+gFPd9XePOCHqWZBon5+QcYtCX1WNShR0/IqBZqXJ0=;
 b=jibkgLQ4lwrfC9Dn3Dy1K8Ro8zR+cbDvtgdCLfCDrjjsqUN0Bu6xBmzf5D+YQfXhWf
 oM6vfTgrzZndFg3/9fsVQBINmUYNEEkvusPl8S+GKr/SyH6LxtP8KT8zBIFQPnaTEvsO
 K3Cx7l3shooq/ip+a+ITLJxBlxXitkgEwvc54S4bCuT0+tunMJvjMV/BJ4RQ90jMe1GB
 u5NChuR11wNQY/mZVzl2oNEJiqOLrCfHU7YMBI3GGVSML4u+97+x0gazVLDro6z67Yvy
 2L6WlM+KQbJxX4c3AyD6N3wFKyA945WZ6tB6gi9AaZqERNKt+vRTqzAWKj+ar/fcTgrd
 mDuA==
X-Gm-Message-State: AOJu0YxPjMdoD534r2d71gOmsl7T79u8rWPzlAajLmMEOmdYZFY2Bj6x
 Fn6ibbA/FBtyNDZ+LW8VPy2Ey6ipz6muPL9kSvFW3nBOHN+bfZbLp4ceW9zPXw==
X-Gm-Gg: AZuq6aL8fsQKHrq3ylmMU1q2UZUEfyR7PeTOi1QAl5yAOZkbd2WgyiI/SyKEAl5T35M
 dlNpVVwpQbZ1NDMYeUQ6QXejHPvdFwmkAB2ycd2+gAuvgzUS8ykwqRzpYm3T3xK4jHZc02d5Pv8
 CqNH1pvwYW1d81Z/PU9RUmCP8vD7lFeTIZOmW80481DQb0hPdAknppuXEuLqRJKgrFZNuQ7XsG2
 Yhb4IvZApbcQMXSxecUzUoKyJN4Tt8ka0hZ5kzdtmlwI9pc8GWee6QYNMUv3KakOaNtb82DSXnH
 AvhJX4UMV9AKBA10aEJiUiRNUnzJdBEVO9vHTQHHuW3Yi1U1mkEZ3gz5dh6tmOih/0JnSy0Za/x
 ZwpYEDjsaFuzwcpx4GTM/OLslSpb510rlII/+mkrsO47lf7Ixh74suqiaGc+SqKeGYW1+6GYcOH
 /G3+nLU6/0MGRPI6sijCYkAE8+RnKoU6fz3O2Ia/2KJiunOsvo6MbwBgZywbahGxk7M+h3MB/Ky
 lwpEZxvDRs=
X-Received: by 2002:a05:622a:e:b0:4ff:c8ae:efe4 with SMTP id
 d75a77b69052e-50639924705mr195246131cf.30.1770736509263; 
 Tue, 10 Feb 2026 07:15:09 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:08 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v2 01/16] spacemit: k1: support multi-board infrastructure
Date: Tue, 10 Feb 2026 10:14:44 -0500
Message-Id: <20260210151459.2348758-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Restructure K1 SoC support to handle multiple boards through a single
configuration:

1. Rename bananapi-f3_defconfig to k1_defconfig.
2. Move all K1 board files to k1 directory.

Eliminates the need for board-specific defconfigs while maintaining
hardware compatibility.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
 arch/riscv/Kconfig                                    | 10 ++++++----
 arch/riscv/cpu/k1/Kconfig                             |  4 ++++
 board/spacemit/{bananapi-f3 => k1}/Kconfig            | 11 ++++++++---
 board/spacemit/{bananapi-f3 => k1}/MAINTAINERS        |  4 ++--
 board/spacemit/{bananapi-f3 => k1}/Makefile           |  0
 board/spacemit/{bananapi-f3 => k1}/board.c            |  0
 .../{bananapi-f3_defconfig => spacemit_k1_defconfig}  |  3 ++-
 doc/board/spacemit/bananapi-f3.rst                    |  2 +-
 include/configs/{bananapi-f3.h => k1.h}               |  0
 9 files changed, 23 insertions(+), 11 deletions(-)
 rename board/spacemit/{bananapi-f3 => k1}/Kconfig (63%)
 rename board/spacemit/{bananapi-f3 => k1}/MAINTAINERS (61%)
 rename board/spacemit/{bananapi-f3 => k1}/Makefile (100%)
 rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
 rename configs/{bananapi-f3_defconfig => spacemit_k1_defconfig} (97%)
 rename include/configs/{bananapi-f3.h => k1.h} (100%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 79867656b15..ac50c1d7234 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -8,15 +8,17 @@ choice
 	prompt "Target select"
 	optional
 
+config ARCH_K1
+	bool "Spacemit K1 Architecture"
+	help
+	  This enables support for Spacemit K1 SoC family.
+
 config TARGET_ANDES_AE350
 	bool "Support Andes ae350"
 
 config TARGET_ANDES_VOYAGER
 	bool "Support Andes Voyager Board"
 
-config TARGET_BANANAPI_F3
-	bool "Support BananaPi F3 Board"
-
 config TARGET_K230_CANMV
 	bool "Support K230 CanMV Board"
 
@@ -115,7 +117,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
-source "board/spacemit/bananapi-f3/Kconfig"
+source "board/spacemit/k1/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 14201df80f2..4b621158334 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
+if ARCH_K1
+
 config SPACEMIT_K1
 	bool
 	select BINMAN
@@ -17,3 +19,5 @@ config SPACEMIT_K1
 	imply SPL_CPU
 	imply SPL_OPENSBI
 	imply SPL_LOAD_FIT
+
+endif
diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/k1/Kconfig
similarity index 63%
rename from board/spacemit/bananapi-f3/Kconfig
rename to board/spacemit/k1/Kconfig
index f89fa9af2c7..9f9c806d00d 100644
--- a/board/spacemit/bananapi-f3/Kconfig
+++ b/board/spacemit/k1/Kconfig
@@ -1,7 +1,7 @@
-if TARGET_BANANAPI_F3
+if ARCH_K1
 
 config SYS_BOARD
-	default "bananapi-f3"
+	default "k1"
 
 config SYS_VENDOR
 	default "spacemit"
@@ -10,7 +10,7 @@ config SYS_CPU
 	default "k1"
 
 config SYS_CONFIG_NAME
-	default "bananapi-f3"
+	default "k1"
 
 config TEXT_BASE
 	default 0x00200000
@@ -22,4 +22,9 @@ config BOARD_SPECIFIC_OPTIONS
 	def_bool y
 	select SPACEMIT_K1
 
+config TARGET_BANANAPI_F3
+	bool "Support BananaPi F3 Board"
+	help
+	  BananaPi F3 board contains Spacemit K1 SoC.
+
 endif
diff --git a/board/spacemit/bananapi-f3/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
similarity index 61%
rename from board/spacemit/bananapi-f3/MAINTAINERS
rename to board/spacemit/k1/MAINTAINERS
index 131bad03181..bd476c32719 100644
--- a/board/spacemit/bananapi-f3/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,6 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@@gmail.com>
 S:	Maintained
-F:	board/spacemit/bananapi-f3/
-F:	configs/bananapi-f3_defconfig
+F:	board/spacemit/k1/
+F:	configs/k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
diff --git a/board/spacemit/bananapi-f3/Makefile b/board/spacemit/k1/Makefile
similarity index 100%
rename from board/spacemit/bananapi-f3/Makefile
rename to board/spacemit/k1/Makefile
diff --git a/board/spacemit/bananapi-f3/board.c b/board/spacemit/k1/board.c
similarity index 100%
rename from board/spacemit/bananapi-f3/board.c
rename to board/spacemit/k1/board.c
diff --git a/configs/bananapi-f3_defconfig b/configs/spacemit_k1_defconfig
similarity index 97%
rename from configs/bananapi-f3_defconfig
rename to configs/spacemit_k1_defconfig
index a726ce84775..0bdc3c800f0 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -6,9 +6,10 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
-CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_ARCH_K1=y
+CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_FIT=y
 CONFIG_SUPPORT_RAW_INITRD=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/doc/board/spacemit/bananapi-f3.rst b/doc/board/spacemit/bananapi-f3.rst
index f2220950a3a..1ece2ce9d02 100644
--- a/doc/board/spacemit/bananapi-f3.rst
+++ b/doc/board/spacemit/bananapi-f3.rst
@@ -29,7 +29,7 @@ built for SpacemiT K1 SoC as below:
 .. code-block:: console
 
    cd <U-Boot-dir>
-   make bananapi-f3_defconfig
+   make spacemit_k1_defconfig
    make OPENSBI=<OpenSBI-dir>/build/platform/generic/firmware/fw_dynamic.bin
 
 This will generate u-boot.itb
diff --git a/include/configs/bananapi-f3.h b/include/configs/k1.h
similarity index 100%
rename from include/configs/bananapi-f3.h
rename to include/configs/k1.h
-- 
2.25.1

