Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE46109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:32:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D35083E7A;
	Wed, 25 Mar 2026 23:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YR8BwBQD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF3B883E7A; Wed, 25 Mar 2026 23:32:51 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A924C83A1B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-8d006a80ccbso56835785a.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774477968; x=1775082768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+LdkrqBud90z1UgbpE3tS1fiuiUej20l+wG630hjx8=;
 b=YR8BwBQDddVI7EyoZkudB4ybHcQLIqRdqWyRcZx8/Et3yhLmWnQd4LEb+piDdWITMW
 QGYKR36zHygEUg1bcHqtqysoQ6Hn/9r9nSA6u9ln3u2TIy8+5dYwGkJ4oYzMRd8JGl6W
 hFBSyGSBUvFWhy0q2lGG8VB6eZ8lLW++GAB2wPep20wvQp53lwXx3eE2Z6pmPprNKkkX
 hVp4MNcHxcxkjy+kPz1T8JaPP+T6TdCDaXLz8UZK5+Jpl3FWRYVo2UUy16i81epEy00w
 3LSdSyo4t4I26u7iDxRbyjbPUuyT+gZ7CNNbXSeqgpfZ/Py8IYlpWCZd6zueqUOVP3hN
 DUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774477968; x=1775082768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v+LdkrqBud90z1UgbpE3tS1fiuiUej20l+wG630hjx8=;
 b=LnTNxumSpCBBcfBCwbgYx5pTTkZZcMcUePvy3Q3zouG6lfIPaZa12KDT5vR0jtsAUt
 f3RlXstJI5CXu2nXGUVrRgxv/akQyQDvV9zQHkowaVExixIL7D/JcDPzR3BJjcj6Cjsk
 M44dp97bZvH1G3Menlcc5HnITay9g9uaOX9ZNllUoAzmzavAPeRZqQNjE5FewWbE4fdB
 Xxj38/ugsfHeTfT1MDdzIRzInLy6/AlxBfrI0GhG5zZtBCTST0HHkGBfJKL25Iog2K0W
 /MTX2uO8pLnWNnZ8pAs7+PP7LuAWqqCKuryeNytzB2pzoKoZDSAd57n7CFB0XwTeh7dM
 Ktog==
X-Gm-Message-State: AOJu0Yys8qBop8dHRII11e6p6LQdxKQfXlBtRpxJG+aetZfmE5LmGWDG
 x3VqdfNt+TGLKBRpVPnXXE+dqczz3L0SSdtNvbuMxWo4KmJV3o5PyUxv0rFRJHZp
X-Gm-Gg: ATEYQzyOucSymPnznQFfinIrqafvZA1zkeGVjTBmVOe6cAGVgE1j5X1fX+aKbOhjgpg
 o71kbm0Y9iO4yNtiM+2d1Fhn76E6sl2IyPGDp/jS5HA0EigeGEj5QieiucQ7PIZ8At5qI3wV5MZ
 e99EgMSPA/C/O3iXoXhZ5VXGZR2BIGiTNoh+8Bwn2a5zSx2dRFNjagqIvhPWF//YC8c7bQFRnqX
 +UAJhL5SEjVmCmfCZ6RKapceKMUE02D9cRhweBrYj31oHo1OpnS+1kr4Z4zMB6SONTD8pnOw3kQ
 oPDIdUKmLA6HnhbbXFp0/FDdBBOxd9F1JvfRMvxtmX1xCKLkLB4N+8LCTQmwwX/VyQY+SGs61jY
 bdZKiedExCEwfXDkm/P+l+3HrK0mVNsrJjbv9JjHMIleBEixSQP0Y6JTY13JfaLolJ04xDatOuh
 uup6XF6f8SnU7PCxsfssWRiJMSRNMqt3a4MwbXhKfh6LCDGJ0jMjhHCCT7L1kl/dkTWS2LTKCRj
 rJz5SR9RxsnrVSCLLQTww==
X-Received: by 2002:a05:620a:410c:b0:8cf:eb1c:5567 with SMTP id
 af79cd13be357-8d000fc4bebmr716932385a.34.1774477968318; 
 Wed, 25 Mar 2026 15:32:48 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:32:47 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com
Subject: [PATCH v3 01/16] spacemit: k1: support multi-board infrastructure
Date: Wed, 25 Mar 2026 18:32:17 -0400
Message-Id: <20260325223232.1553212-2-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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
3. Rename TARGET_BANANAPI_F3 to TARGET_SPACEMIT_K1.

Eliminates the need for board-specific defconfigs while maintaining
hardware compatibility.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
---
Changes in v3:
- Use flat TARGET_SPACEMIT_K1 to avoid Kconfig recursive dependency
  caused by merge conflict with b51e59c8b34 ("riscv: Add support
  for BeagleV-Fire")

 arch/riscv/Kconfig                                       | 8 ++++----
 arch/riscv/cpu/k1/Kconfig                                | 4 ++++
 arch/riscv/dts/Makefile                                  | 2 +-
 board/spacemit/{bananapi-f3 => k1}/Kconfig               | 6 +++---
 board/spacemit/{bananapi-f3 => k1}/MAINTAINERS           | 4 ++--
 board/spacemit/{bananapi-f3 => k1}/Makefile              | 0
 board/spacemit/{bananapi-f3 => k1}/board.c               | 0
 configs/{bananapi-f3_defconfig => spacemit_k1_defconfig} | 2 +-
 doc/board/spacemit/bananapi-f3.rst                       | 2 +-
 include/configs/{bananapi-f3.h => k1.h}                  | 0
 10 files changed, 16 insertions(+), 12 deletions(-)
 rename board/spacemit/{bananapi-f3 => k1}/Kconfig (79%)
 rename board/spacemit/{bananapi-f3 => k1}/MAINTAINERS (61%)
 rename board/spacemit/{bananapi-f3 => k1}/Makefile (100%)
 rename board/spacemit/{bananapi-f3 => k1}/board.c (100%)
 rename configs/{bananapi-f3_defconfig => spacemit_k1_defconfig} (95%)
 rename include/configs/{bananapi-f3.h => k1.h} (100%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ad7589123c6..485067ed266 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,9 +14,6 @@ config TARGET_ANDES_AE350
 config TARGET_ANDES_VOYAGER
 	bool "Support Andes Voyager Board"
 
-config TARGET_BANANAPI_F3
-	bool "Support BananaPi F3 Board"
-
 config TARGET_BEAGLEBOARD_BEAGLEVFIRE
 	bool "Support BeagleBoard BeagleV-Fire Board (based on Microchip MPFS)"
 
@@ -50,6 +47,9 @@ config TARGET_SIPEED_MAIX
 	bool "Support Sipeed Maix Board"
 	select SYS_CACHE_SHIFT_6
 
+config TARGET_SPACEMIT_K1
+	bool "Support Spacemit K1 SoC"
+
 config TARGET_STARFIVE_VISIONFIVE2
 	bool "Support StarFive VisionFive2 Board"
 	select BOARD_LATE_INIT
@@ -119,7 +119,7 @@ source "board/sifive/unmatched/Kconfig"
 source "board/sipeed/maix/Kconfig"
 source "board/sophgo/milkv_duo/Kconfig"
 source "board/sophgo/licheerv_nano/Kconfig"
-source "board/spacemit/bananapi-f3/Kconfig"
+source "board/spacemit/k1/Kconfig"
 source "board/starfive/visionfive2/Kconfig"
 source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
diff --git a/arch/riscv/cpu/k1/Kconfig b/arch/riscv/cpu/k1/Kconfig
index 14201df80f2..3701bf2b5da 100644
--- a/arch/riscv/cpu/k1/Kconfig
+++ b/arch/riscv/cpu/k1/Kconfig
@@ -2,6 +2,8 @@
 #
 # Copyright (C) 2024, Kongyang Liu <seashell11234455@gmail.com>
 
+if TARGET_SPACEMIT_K1
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
diff --git a/arch/riscv/dts/Makefile b/arch/riscv/dts/Makefile
index 8e591cb7aa9..bfb18341c61 100644
--- a/arch/riscv/dts/Makefile
+++ b/arch/riscv/dts/Makefile
@@ -2,7 +2,6 @@
 
 dtb-$(CONFIG_TARGET_ANDES_AE350) += ae350_32.dtb ae350_64.dtb
 dtb-$(CONFIG_TARGET_ANDES_VOYAGER) += qilai-voyager.dtb
-dtb-$(CONFIG_TARGET_BANANAPI_F3) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_K230_CANMV) += k230-canmv.dtb
 dtb-$(CONFIG_TARGET_MICROCHIP_ICICLE) += mpfs-icicle-kit.dtb
 dtb-$(CONFIG_TARGET_MILKV_DUO) += cv1800b-milkv-duo.dtb
@@ -10,6 +9,7 @@ dtb-$(CONFIG_TARGET_LICHEERV_NANO) += sg2002-licheerv-nano-b.dtb
 dtb-$(CONFIG_TARGET_QEMU_VIRT) += qemu-virt32.dtb qemu-virt64.dtb
 dtb-$(CONFIG_TARGET_OPENPITON_RISCV64) += openpiton-riscv64.dtb
 dtb-$(CONFIG_TARGET_SIPEED_MAIX) += k210-maix-bit.dtb
+dtb-$(CONFIG_TARGET_SPACEMIT_K1) += k1-bananapi-f3.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv32.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-mbv64.dtb
 dtb-$(CONFIG_TARGET_XILINX_MBV) += xilinx-binman.dtb
diff --git a/board/spacemit/bananapi-f3/Kconfig b/board/spacemit/k1/Kconfig
similarity index 79%
rename from board/spacemit/bananapi-f3/Kconfig
rename to board/spacemit/k1/Kconfig
index f89fa9af2c7..1c615f89b64 100644
--- a/board/spacemit/bananapi-f3/Kconfig
+++ b/board/spacemit/k1/Kconfig
@@ -1,7 +1,7 @@
-if TARGET_BANANAPI_F3
+if TARGET_SPACEMIT_K1
 
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
similarity index 95%
rename from configs/bananapi-f3_defconfig
rename to configs/spacemit_k1_defconfig
index a726ce84775..09928046012 100644
--- a/configs/bananapi-f3_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -6,9 +6,9 @@ CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x1000000
 CONFIG_DEFAULT_DEVICE_TREE="k1-bananapi-f3"
 CONFIG_SYS_BOOTM_LEN=0xa000000
 CONFIG_SYS_LOAD_ADDR=0x200000
-CONFIG_TARGET_BANANAPI_F3=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
+CONFIG_TARGET_SPACEMIT_K1=y
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

