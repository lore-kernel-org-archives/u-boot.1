Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8824CC71134
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 02:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFADD86532;
	Thu, 24 Aug 2023 04:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDH9/o0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D326A8651B; Thu, 24 Aug 2023 04:30:58 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAB348651B
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 04:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-76ce59842c1so372983985a.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692844254; x=1693449054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dNtNtAg5sOu2yTXG7NYDd7WQU5t4wP5NXGSNZeTn0ws=;
 b=iDH9/o0HwuR2FpLbNuxqHLG+kZ7i6ZWuk37qdt+O61GOIMBYNflWx480wgVD8ENjkc
 2a8VlmAG7yMxSkBtXHRxXFaFAEEWutYXFCS5o/nBKEJ3f68iB+pJ8PSgq//uGFqz0k3V
 BE2Tr6KYm0GdyrhHOff9TaVqRQLzANSxNHmJyiRT3UVCsqmo16hluPqIIf9g+NiycovB
 4Y+QKImwzl/XAt9fJNVQSk4U/90vupQWcOknd+SGKcJ6UJvqODVNX/LIqtRS6HQDMHud
 hcu+TGyk/j+aeS/kAUOe6OThZDh68MCBmwS/Ue85JZE5wrAtDj9faYmJ5pTBmnvsLGiY
 SjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692844254; x=1693449054;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dNtNtAg5sOu2yTXG7NYDd7WQU5t4wP5NXGSNZeTn0ws=;
 b=N74iQdrDpnRRnV6SOColUeEMwXrPsidW+EGC0y008PTvk2GjNOq+k+1hczXthSbaKO
 UM7oNxQXo230R6Gf7fvMHwqdLWFgJjYTbeYZDdDCHDvSlZ2IyrKa1/20KygsjW73gVwD
 K2jIR+APGf5GGIASw71psO3Mx9s1ZJjy+lRbc59LzZi39/lYjExIykHCNhSwQ+tbA0zv
 upf3mC6s6/5LIiaHRwclTFvkVsHFryHm561rYj0Otp84GHhXtbki5Df/eAgav3uSpQkC
 N8Ok6xiy6iZx3t42zQ3paY+YUzup5IInmb6PnxbA8XIXkymnmirHyYwakbqn7Ezaq2Du
 xtNw==
X-Gm-Message-State: AOJu0Yw9RvsX8/WCc+jMg4ZiHvWkQeN60qq83SJ7VolzhRrlDJCvI9l3
 P+lEw3muw685pcwsROeA7OD1A9pwuWw=
X-Google-Smtp-Source: AGHT+IEojaDe7JkKjx7aUFZV9jm6Z9DKLmOfox2srpKbhCHGCcjvz/MwC7X9KHuublKQfrheXE0LIA==
X-Received: by 2002:a05:620a:44c1:b0:76d:b6ef:941a with SMTP id
 y1-20020a05620a44c100b0076db6ef941amr6332995qkp.13.1692844254106; 
 Wed, 23 Aug 2023 19:30:54 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab
 ([2600:4040:57a3:100:88f2:4286:b3e9:c854])
 by smtp.gmail.com with ESMTPSA id
 o13-20020ae9f50d000000b00767da10efb6sm4312756qkg.97.2023.08.23.19.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 19:30:53 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Stefan Roese <sr@denx.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Mingming lee <mingming.lee@mediatek.com>,
 Mauro Condarelli <mc5686@mclink.it>, Simon Glass <sjg@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Nikhil M Jain <n-jain1@ti.com>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Marek Vasut <marex@denx.de>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Roger Quadros <rogerq@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] Convert CFG_SYS_UBOOT_START to Kconfig
Date: Wed, 23 Aug 2023 22:30:52 -0400
Message-Id: <20230824023052.655362-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.40.0
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

Commit 65cc0e2a65d2 ("global: Move remaining CONFIG_SYS_* to CFG_SYS_*")
renamed CONFIG_SYS_UBOOT_START to CFG_SYS_UBOOT_START. Unfortunately,
this meant that the value was no longer available to the Makefile. This
caused imxrt to fail to boot. All the other boards that used this
variable were unaffected because they were using the default value
which is CONFIG_TEXT_BASE.

This commit converts CFG_SYS_UBOOT_START to Kconfig and sets the default
value to CONFIG_TEXT_BASE.

Suggested-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 Makefile                                       | 16 ++++------------
 arch/arm/mach-k3/config_secure.mk              |  2 +-
 arch/arm/mach-omap2/config_secure.mk           |  2 +-
 boot/Kconfig                                   | 16 ++++++++++++++++
 common/spl/spl.c                               |  6 +-----
 common/spl/spl_fit.c                           |  2 +-
 configs/imxrt1020-evk_defconfig                |  2 ++
 configs/imxrt1050-evk_defconfig                |  2 ++
 configs/imxrt1170-evk_defconfig                |  2 ++
 include/configs/gardena-smart-gateway-mt7688.h |  4 ----
 include/configs/imxrt1020-evk.h                |  6 ------
 include/configs/imxrt1050-evk.h                |  6 ------
 include/configs/imxrt1170-evk.h                |  3 ---
 include/configs/linkit-smart-7688.h            |  4 ----
 include/configs/mt7620.h                       |  3 ---
 include/configs/mt7628.h                       |  3 ---
 include/configs/mt8512.h                       |  2 --
 include/configs/vocore2.h                      |  4 ----
 include/spl.h                                  |  2 +-
 19 files changed, 31 insertions(+), 56 deletions(-)

diff --git a/Makefile b/Makefile
index 9b90204bfe..13d4c63439 100644
--- a/Makefile
+++ b/Makefile
@@ -1364,14 +1364,6 @@ OBJCOPYFLAGS_u-boot.ldr.srec := -I binary -O srec
 u-boot.ldr.hex u-boot.ldr.srec: u-boot.ldr FORCE
 	$(call if_changed,objcopy)
 
-#
-# U-Boot entry point, needed for booting of full-blown U-Boot
-# from the SPL U-Boot version.
-#
-ifndef CFG_SYS_UBOOT_START
-CFG_SYS_UBOOT_START := $(CONFIG_TEXT_BASE)
-endif
-
 # Boards with more complex image requirements can provide an .its source file
 # or a generator script
 # NOTE: Please do not use this. We are migrating away from Makefile rules to use
@@ -1391,7 +1383,7 @@ endif
 
 ifdef CONFIG_SPL_LOAD_FIT
 MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
+	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-p $(CONFIG_FIT_EXTERNAL_OFFSET) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
 	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb,$(subst ",,$(DEVICE_TREE))) \
@@ -1399,10 +1391,10 @@ MKIMAGEFLAGS_u-boot.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
 	$(patsubst %,-b arch/$(ARCH)/dts/%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 else
 MKIMAGEFLAGS_u-boot.img = -A $(ARCH) -T firmware -C none -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
+	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
 MKIMAGEFLAGS_u-boot-ivt.img = -A $(ARCH) -T firmware_ivt -C none -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
+	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
 u-boot-ivt.img: MKIMAGEOUTPUT = u-boot-ivt.img.log
 endif
@@ -1433,7 +1425,7 @@ MKIMAGEFLAGS_u-boot.pbl = -n $(srctree)/$(CONFIG_SYS_FSL_PBL_RCW:"%"=%) \
 UBOOT_BIN := u-boot.bin
 
 MKIMAGEFLAGS_u-boot-lzma.img = -A $(ARCH) -T standalone -C lzma -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
+	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board"
 
 u-boot.bin.lzma: u-boot.bin FORCE
diff --git a/arch/arm/mach-k3/config_secure.mk b/arch/arm/mach-k3/config_secure.mk
index 7bc8af813a..9cc1f9eb24 100644
--- a/arch/arm/mach-k3/config_secure.mk
+++ b/arch/arm/mach-k3/config_secure.mk
@@ -30,7 +30,7 @@ tispl.bin_HS: $(obj)/u-boot-spl-nodtb.bin_HS $(patsubst %,$(obj)/dts/%.dtb_HS,$(
 	$(call if_changed,mkfitimage)
 
 MKIMAGEFLAGS_u-boot.img_HS = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
+	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
 	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
 
diff --git a/arch/arm/mach-omap2/config_secure.mk b/arch/arm/mach-omap2/config_secure.mk
index 24ddcdb961..f76262bb0c 100644
--- a/arch/arm/mach-omap2/config_secure.mk
+++ b/arch/arm/mach-omap2/config_secure.mk
@@ -102,7 +102,7 @@ u-boot_HS_XIP_X-LOADER: $(obj)/u-boot.bin FORCE
 ifdef CONFIG_SPL_LOAD_FIT
 
 MKIMAGEFLAGS_u-boot_HS.img = -f auto -A $(ARCH) -T firmware -C none -O u-boot \
-	-a $(CONFIG_TEXT_BASE) -e $(CFG_SYS_UBOOT_START) \
+	-a $(CONFIG_TEXT_BASE) -e $(CONFIG_SYS_UBOOT_START) \
 	-n "U-Boot $(UBOOTRELEASE) for $(BOARD) board" -E \
 	$(patsubst %,-b arch/$(ARCH)/dts/%.dtb_HS,$(subst ",,$(CONFIG_OF_LIST)))
 
diff --git a/boot/Kconfig b/boot/Kconfig
index 5e2d4286ae..f2f7821cc1 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -737,6 +737,22 @@ config TEXT_BASE
 	default 0x4a000000 if SUNXI_MINIMUM_DRAM_MB >= 256
 	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
 	hex "Text Base"
+	help
+	  The address in memory that U-Boot will be copied from, initially.
+
+config HAVE_SYS_UBOOT_START
+	bool
+	depends on HAVE_TEXT_BASE
+	prompt "Use custom U-Boot Start"
+	help
+	  By default, the address in memory that U-Boot will be copied from(TEXT_BASE) and the
+	  entry point are the same. Select this to set a different U-Boot start address.
+
+config SYS_UBOOT_START
+	hex
+	depends on HAVE_TEXT_BASE
+	default TEXT_BASE
+	prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
 	help
 	  The address in memory that U-Boot will be running from, initially.
 
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 0062f3f45d..f4b30b3cf3 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -45,10 +45,6 @@
 DECLARE_GLOBAL_DATA_PTR;
 DECLARE_BINMAN_MAGIC_SYM;
 
-#ifndef CFG_SYS_UBOOT_START
-#define CFG_SYS_UBOOT_START	CONFIG_TEXT_BASE
-#endif
-
 u32 *boot_params_ptr = NULL;
 
 #if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
@@ -252,7 +248,7 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 		spl_image->entry_point = u_boot_pos;
 		spl_image->load_addr = u_boot_pos;
 	} else {
-		spl_image->entry_point = CFG_SYS_UBOOT_START;
+		spl_image->entry_point = CONFIG_SYS_UBOOT_START;
 		spl_image->load_addr = CONFIG_TEXT_BASE;
 	}
 	spl_image->os = IH_OS_U_BOOT;
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 730639f756..3d39e70e65 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -816,7 +816,7 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 	}
 
 	/*
-	 * If a platform does not provide CFG_SYS_UBOOT_START, U-Boot's
+	 * If a platform does not provide CONFIG_SYS_UBOOT_START, U-Boot's
 	 * Makefile will set it to 0 and it will end up as the entry point
 	 * here. What it actually means is: use the load address.
 	 */
diff --git a/configs/imxrt1020-evk_defconfig b/configs/imxrt1020-evk_defconfig
index 40210a5f0b..6b63b80895 100644
--- a/configs/imxrt1020-evk_defconfig
+++ b/configs/imxrt1020-evk_defconfig
@@ -19,6 +19,8 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x20209000
+CONFIG_HAVE_SYS_UBOOT_START=y
+CONFIG_SYS_UBOOT_START=0x800023FD
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index 8f7a36fea7..cbf9469b24 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -21,6 +21,8 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x20209000
+CONFIG_HAVE_SYS_UBOOT_START=y
+CONFIG_SYS_UBOOT_START=0x800023FD
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/configs/imxrt1170-evk_defconfig b/configs/imxrt1170-evk_defconfig
index 8320c091d2..83825da6de 100644
--- a/configs/imxrt1170-evk_defconfig
+++ b/configs/imxrt1170-evk_defconfig
@@ -21,6 +21,8 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_SYS_LOAD_ADDR=0x202C0000
+CONFIG_HAVE_SYS_UBOOT_START=y
+CONFIG_SYS_UBOOT_START=0x202403FD
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SD_BOOT=y
 # CONFIG_USE_BOOTCOMMAND is not set
diff --git a/include/configs/gardena-smart-gateway-mt7688.h b/include/configs/gardena-smart-gateway-mt7688.h
index 0ba4efe67a..1b97ae22fc 100644
--- a/include/configs/gardena-smart-gateway-mt7688.h
+++ b/include/configs/gardena-smart-gateway-mt7688.h
@@ -11,10 +11,6 @@
 
 #define CFG_SYS_INIT_SP_OFFSET	0x400000
 
-/* SPL */
-
-#define CFG_SYS_UBOOT_START		CONFIG_TEXT_BASE
-
 /* Dummy value */
 #define CFG_SYS_UBOOT_BASE		0
 
diff --git a/include/configs/imxrt1020-evk.h b/include/configs/imxrt1020-evk.h
index e180387c68..cd6af93454 100644
--- a/include/configs/imxrt1020-evk.h
+++ b/include/configs/imxrt1020-evk.h
@@ -18,10 +18,4 @@
 #define DMAMEM_BASE			(PHYS_SDRAM + PHYS_SDRAM_SIZE - \
 					 DMAMEM_SZ_ALL)
 
-/*
- * Configuration of the external SDRAM memory
- */
-
-#define CFG_SYS_UBOOT_START		0x800023FD
-
 #endif /* __IMXRT1020_EVK_H */
diff --git a/include/configs/imxrt1050-evk.h b/include/configs/imxrt1050-evk.h
index 7688464841..2af2dde2ae 100644
--- a/include/configs/imxrt1050-evk.h
+++ b/include/configs/imxrt1050-evk.h
@@ -25,10 +25,4 @@
 		"stderr=serial,vidconsole\0"
 #endif
 
-/*
- * Configuration of the external SDRAM memory
- */
-
-#define CFG_SYS_UBOOT_START		0x800023FD
-
 #endif /* __IMXRT1050_EVK_H */
diff --git a/include/configs/imxrt1170-evk.h b/include/configs/imxrt1170-evk.h
index f83429082a..1ccaa15bc1 100644
--- a/include/configs/imxrt1170-evk.h
+++ b/include/configs/imxrt1170-evk.h
@@ -22,8 +22,5 @@
 #define DMAMEM_SZ_ALL			(1 * 1024 * 1024)
 #define DMAMEM_BASE			(PHYS_SDRAM + PHYS_SDRAM_SIZE - \
 					 DMAMEM_SZ_ALL)
-/* For SPL */
-#define CFG_SYS_UBOOT_START		0x202403FD
-/* For SPL ends */
 
 #endif /* __IMXRT1170_EVK_H */
diff --git a/include/configs/linkit-smart-7688.h b/include/configs/linkit-smart-7688.h
index f16c7e9122..e8f7a59c40 100644
--- a/include/configs/linkit-smart-7688.h
+++ b/include/configs/linkit-smart-7688.h
@@ -11,10 +11,6 @@
 
 #define CFG_SYS_INIT_SP_OFFSET	0x400000
 
-/* SPL */
-
-#define CFG_SYS_UBOOT_START		CONFIG_TEXT_BASE
-
 /* Dummy value */
 #define CFG_SYS_UBOOT_BASE		0
 
diff --git a/include/configs/mt7620.h b/include/configs/mt7620.h
index d69d35fa96..3bc0c18a1e 100644
--- a/include/configs/mt7620.h
+++ b/include/configs/mt7620.h
@@ -12,9 +12,6 @@
 
 #define CFG_SYS_INIT_SP_OFFSET		0x400000
 
-/* SPL */
-#define CFG_SYS_UBOOT_START		CONFIG_TEXT_BASE
-
 /* Dummy value */
 #define CFG_SYS_UBOOT_BASE		0
 
diff --git a/include/configs/mt7628.h b/include/configs/mt7628.h
index 0ac376d33c..1df06811d6 100644
--- a/include/configs/mt7628.h
+++ b/include/configs/mt7628.h
@@ -22,9 +22,6 @@
 #define CFG_SYS_BAUDRATE_TABLE		{ 9600, 19200, 38400, 57600, 115200, \
 					  230400, 460800, 921600 }
 
-/* SPL */
-#define CFG_SYS_UBOOT_START		CONFIG_TEXT_BASE
-
 /* Dummy value */
 #define CFG_SYS_UBOOT_BASE		0
 
diff --git a/include/configs/mt8512.h b/include/configs/mt8512.h
index c0fc8688ca..4e70291e94 100644
--- a/include/configs/mt8512.h
+++ b/include/configs/mt8512.h
@@ -10,8 +10,6 @@
 #define __MT8512_H
 
 /* Uboot definition */
-#define CFG_SYS_UBOOT_START			CONFIG_TEXT_BASE
-
 #define ENV_BOOT_READ_IMAGE \
 	"boot_rd_img=mmc dev 0" \
 	";mmc read ${loadaddr} 0x27000 0x8000" \
diff --git a/include/configs/vocore2.h b/include/configs/vocore2.h
index 43050d61c3..eb87633661 100644
--- a/include/configs/vocore2.h
+++ b/include/configs/vocore2.h
@@ -11,10 +11,6 @@
 
 #define CFG_SYS_INIT_SP_OFFSET	0x400000
 
-/* SPL */
-
-#define CFG_SYS_UBOOT_START		CONFIG_TEXT_BASE
-
 /* Dummy value */
 #define CFG_SYS_UBOOT_BASE		0
 
diff --git a/include/spl.h b/include/spl.h
index 92bcaa90a4..57da1484f0 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -484,7 +484,7 @@ unsigned long spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
  * spl_set_header_raw_uboot() - Set up a standard SPL image structure
  *
  * This sets up the given spl_image which the standard values obtained from
- * config options: CONFIG_SYS_MONITOR_LEN, CFG_SYS_UBOOT_START,
+ * config options: CONFIG_SYS_MONITOR_LEN, CONFIG_SYS_UBOOT_START,
  * CONFIG_TEXT_BASE.
  *
  * @spl_image: Image description to set up
-- 
2.40.0

