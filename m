Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA6EC88CB9
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 01:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B234F869FB;
	Fri, 25 Aug 2023 03:59:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BjW3bGXT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 035EF869F9; Fri, 25 Aug 2023 03:59:55 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F8B86A1C
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 03:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-410af8f75d9so2672571cf.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 18:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692928790; x=1693533590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jydz6zMIGYGNeQbvrqXP7t1SEu4XrrYKy6CtAAoBDZw=;
 b=BjW3bGXTHiicyftwV6ZsQCVY3MclCSCdnilbZPfJ0SztC0qN2uuQW1ZfEZebz4NHOn
 RiigyVANMYB69dkmKHgYjA1ivK0bDfadj6Pd+IXP7d9vsJn+jzmUJYvdxymPDpCpU7DV
 xUyA51VbD/e7xmC5Y2zFy6dS9PnGCtYmc2RyQGo3U4v4lwdfN/a7u+bJNNdpB17jov0D
 DZpKlGMzn7uFrX3NYkmE5Pk5/TeQG6lRC0M/PQeKNzHUyQuYaX4mhItoEvtBylILVlCg
 JzIBwg50MmBJOiff4Xew1sr8Y8r1tA/XkRLsRabGwuevm4gkHx5VxvS8KIV4PxK9o9Hn
 dHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692928790; x=1693533590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jydz6zMIGYGNeQbvrqXP7t1SEu4XrrYKy6CtAAoBDZw=;
 b=FNEMH9CU0bCLTdO16NBdkgt2ueVpwSF4L3ZLQp3HL/wXlm9uitiWk6SFD6P9Od3sZY
 FOosakCv8ggz+1QdaA9N2Ol/gor618RrBvnJUAvr6J6hEIb4j/raNe8Bay5pTw5NJPbi
 K6RnjwROmwagnma1QZ3A1RuVHKRQx3DzuQzd8gM/SaasWm4DobQG+e9XzFXTrn7CWcM5
 /MeKjo8jtnfaM4D5wvk7jHlumU0bv13JaHYPVQmR/ge+/+Hk0v4Obn67xYZD7uVmPcY+
 3sBZGxY0FuT3ZC2g2PXyig04XevkWo3mUkNkX7dDrBbRPAcHdmdKE2MLE/uWipNkHgPk
 HEnA==
X-Gm-Message-State: AOJu0Yxi3GB6dl6E5hiFzshYNWFd506PqLVZAv+vbO8uGHw/ZdrD3LQk
 4Tpa16RsrT76ZxSpjDTYSLVNCMFxvzM=
X-Google-Smtp-Source: AGHT+IGR2wIX16+InEMLxcPv9SesUY1Ig/KC7K2jSdPODziJaiFxknuRJSodyozEMKG+5l3k3369vA==
X-Received: by 2002:ac8:5c42:0:b0:410:8b14:a324 with SMTP id
 j2-20020ac85c42000000b004108b14a324mr21412599qtj.10.1692928789800; 
 Thu, 24 Aug 2023 18:59:49 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab
 ([2600:4040:57a3:100:25bf:14a7:5c8a:970])
 by smtp.gmail.com with ESMTPSA id
 g12-20020ac8468c000000b0040ff387de83sm234812qto.45.2023.08.24.18.59.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 18:59:49 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: "Andrew F . Davis" <afd@ti.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Stefan Roese <sr@denx.de>,
 Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
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
Subject: [PATCH v2] Convert CFG_SYS_UBOOT_START to Kconfig
Date: Thu, 24 Aug 2023 21:59:48 -0400
Message-Id: <20230825015948.780662-1-Mr.Bossman075@gmail.com>
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
V1->V2:
 - Add "and executed" to TEXT_BASE
 - Reword SYS_UBOOT_START
 - Reword HAVE_SYS_UBOOT_START
 - Use bool as prompt
---
 Makefile                                      | 16 ++++------------
 arch/arm/mach-k3/config_secure.mk             |  2 +-
 arch/arm/mach-omap2/config_secure.mk          |  2 +-
 boot/Kconfig                                  | 19 ++++++++++++++++++-
 common/spl/spl.c                              |  6 +-----
 common/spl/spl_fit.c                          |  2 +-
 configs/imxrt1020-evk_defconfig               |  2 ++
 configs/imxrt1050-evk_defconfig               |  2 ++
 configs/imxrt1170-evk_defconfig               |  2 ++
 .../configs/gardena-smart-gateway-mt7688.h    |  4 ----
 include/configs/imxrt1020-evk.h               |  6 ------
 include/configs/imxrt1050-evk.h               |  6 ------
 include/configs/imxrt1170-evk.h               |  3 ---
 include/configs/linkit-smart-7688.h           |  4 ----
 include/configs/mt7620.h                      |  3 ---
 include/configs/mt7628.h                      |  3 ---
 include/configs/mt8512.h                      |  2 --
 include/configs/vocore2.h                     |  4 ----
 include/spl.h                                 |  2 +-
 19 files changed, 33 insertions(+), 57 deletions(-)

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
index 5e2d4286ae..3883cae2ba 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -738,7 +738,24 @@ config TEXT_BASE
 	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
 	hex "Text Base"
 	help
-	  The address in memory that U-Boot will be running from, initially.
+	  The address in memory that U-Boot will be copied and executed from initially.
+
+config HAVE_SYS_UBOOT_START
+	bool "Use custom U-Boot Start"
+	depends on HAVE_TEXT_BASE
+	help
+	  By default, the address in memory that U-Boot will be copied from (TEXT_BASE) and the
+	  entry point are the same. Select this to start the execution of U-Boot from a different address.
+	  This may be required if a header or vector table needs to be copied but not executed.
+
+config SYS_UBOOT_START
+	hex
+	depends on HAVE_TEXT_BASE
+	default TEXT_BASE
+	prompt "U-Boot entry" if HAVE_SYS_UBOOT_START
+	help
+	  If TEXT_BASE differs from the start of execution, this sets the address in memory that
+	  U-Boot will start execution from initially.
 
 config HAVE_SYS_MONITOR_BASE
 	bool
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

