Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E873DCF6499
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 02:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 473B288E6F;
	Mon, 30 Sep 2024 04:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iAARronR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4065788EE3; Mon, 30 Sep 2024 03:51:02 +0200 (CEST)
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com
 [IPv6:2607:f8b0:4864:20::142])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3902788EB9
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x142.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso12626825ab.3
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661045; x=1728265845; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1wLRIt8OWjngOdusPvBX24//p0dMmopdY9DyIK7Cj0c=;
 b=iAARronRtVlmPEUupgdN/yphFZ4SKWysGSw/Yll4PnWJAe8wOORIP8jlb8pySKUsaV
 1UaXUvBcJFFxM8O9bGn62kLHkR10gjefGDITqI2QUhk92NHthnLMcbnQkKikneUJ2e0l
 J1kfwh/mhEEZWpQJgfg0T29G3Z/YEyBOmYpVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661045; x=1728265845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1wLRIt8OWjngOdusPvBX24//p0dMmopdY9DyIK7Cj0c=;
 b=qSS1AqyqD7HMO97YkkG1KtrRFwwOfR32vt0XUTFbFnRogjeVc/DyWI9fvf5X0ZVSzO
 DBHnA6B6cEiGIyregRNGk50xdaWIDRYMLYsccMUXiLVISJgtmQi5XFxHUuq/hXfB+O3N
 feBCTdvsb9s4O4/XS9aCp/WFOHCGW3p6Xs3zefoDBfUzHmFC5qdjPIIWOLC/fckudvp0
 1XlHja14OX0bql5R5QvwWo8ptAIOI7KvEY+TC2h4iF1FLz2+OA6KuujFsW7dNfzu2SLK
 2NED2DXSxmttnsts+zTdZwWNQ2zOUVE5sWyorIhIfGY/NVDOBAjrzapfGMIrqBJ7JsMD
 lXYw==
X-Gm-Message-State: AOJu0YwCF09caD/FAWxRCS+kVKlIU7NvhwgC5QCWlcA06y8TDijpSVIO
 xijqjvFWkGxklbiJk2Q4z5PnhoTeQU4laSWFT4gRH4OHHZ2L7uxCs0I72PTjUzEB/k5vPp+26Rd
 kdjZV
X-Google-Smtp-Source: AGHT+IHyDyFVri5ZjiwIClpb+AXKk4kG5bnOSA3xGUpf0eCbC5alNfcTjwQ++cmXGKv7M1eESkJQGw==
X-Received: by 2002:a05:6e02:1c25:b0:3a3:44e6:fe66 with SMTP id
 e9e14a558f8ab-3a34515d324mr93402305ab.10.1727661044489; 
 Sun, 29 Sep 2024 18:50:44 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Bryan Brattlof <bb@ti.com>, Devarsh Thakkar <devarsht@ti.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hanyuan Zhao <hanyuan-z@qq.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Stefan Roese <sr@denx.de>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>
Subject: [PATCH v3 27/33] global: Use CONFIG_XPL_BUILD instead of
 CONFIG_SPL_BUILD
Date: Sun, 29 Sep 2024 19:49:50 -0600
Message-Id: <20240930014956.1434060-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 30 Sep 2024 04:11:30 +0200
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

Complete this rename for all directories outside arch/ board/ drivers/
and include/

Use the new symbol to refer to any 'SPL' build, including TPL and VPL

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Drop the change in Makefile.xpl since XPL is already defined

 README                                 |  4 ++--
 boot/Makefile                          |  2 +-
 boot/image-android-dt.c                |  2 +-
 boot/image-android.c                   |  2 +-
 boot/image-fit-sig.c                   |  2 +-
 cmd/Makefile                           |  4 ++--
 cmd/nvedit.c                           | 12 ++++++------
 common/Makefile                        |  8 ++++----
 common/cli_readline.c                  |  2 +-
 common/console.c                       |  2 +-
 common/hash.c                          |  2 +-
 common/spl/Makefile                    |  2 +-
 common/splash_source.c                 |  2 +-
 config.mk                              |  2 +-
 disk/part.c                            |  2 +-
 disk/part_dos.c                        |  2 +-
 doc/develop/distro.rst                 |  4 ++--
 doc/develop/qconfig.rst                |  2 +-
 doc/develop/tests_sandbox.rst          |  2 +-
 dts/Makefile                           |  2 +-
 env/Makefile                           |  2 +-
 env/common.c                           |  4 ++--
 env/fat.c                              |  4 ++--
 env/flash.c                            |  6 +++---
 env/mmc.c                              |  6 +++---
 env/nand.c                             |  8 ++++----
 env/nowhere.c                          |  2 +-
 env/sf.c                               |  2 +-
 fs/Makefile                            |  2 +-
 fs/fs.c                                |  6 +++---
 lib/Makefile                           |  6 +++---
 lib/crypto/Makefile                    |  4 ++--
 lib/display_options.c                  |  2 +-
 lib/fdtdec.c                           |  4 ++--
 lib/hang.c                             |  2 +-
 lib/hashtable.c                        |  4 ++--
 lib/hexdump.c                          |  2 +-
 lib/uuid.c                             |  2 +-
 net/bootp.c                            |  2 +-
 net/net.c                              |  8 ++++----
 scripts/Kbuild.include                 |  2 +-
 scripts/Makefile.xpl                   |  2 +-
 test/Makefile                          |  2 +-
 test/cmd_ut.c                          |  2 +-
 test/dm/Makefile                       |  2 +-
 test/lib/Makefile                      |  2 +-
 test/test-main.c                       |  2 +-
 tools/binman/test/generated/autoconf.h |  2 +-
 48 files changed, 78 insertions(+), 78 deletions(-)

diff --git a/README b/README
index 54e723162fd..c27c386e968 100644
--- a/README
+++ b/README
@@ -1418,13 +1418,13 @@ Low Level (hardware related) configuration options:
 		This only takes effect if the memory commands are activated
 		globally (CONFIG_CMD_MEMORY).
 
-- CONFIG_SPL_BUILD
+- CONFIG_XPL_BUILD
 		Set when the currently running compilation is for an artifact
 		that will end up in one of the 'xPL' builds, i.e. SPL, TPL or
 		VPL. Code that needs phase-specific behaviour can check this,
 		or (where possible) use xpl_phase() instead.
 
-		Note that CONFIG_SPL_BUILD *is* always defined when either
+		Note that CONFIG_XPL_BUILD *is* always defined when either
 		of CONFIG_TPL_BUILD / CONFIG_VPL_BUILD is defined. This can be
 		counter-intuitive and should perhaps be changed.
 
diff --git a/boot/Makefile b/boot/Makefile
index 40e2337de0f..5bf07e83388 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2004-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_BOOT_RETRY) += bootretry.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o bootm_os.o
diff --git a/boot/image-android-dt.c b/boot/image-android-dt.c
index 3b25018c2e7..653835cea76 100644
--- a/boot/image-android-dt.c
+++ b/boot/image-android-dt.c
@@ -72,7 +72,7 @@ bool android_dt_get_fdt_by_index(ulong hdr_addr, u32 index, ulong *addr,
 	return true;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 static void android_dt_print_fdt_info(const struct fdt_header *fdt)
 {
 	u32 fdt_size;
diff --git a/boot/image-android.c b/boot/image-android.c
index 774565fd1fe..fdfff58a2a7 100644
--- a/boot/image-android.c
+++ b/boot/image-android.c
@@ -652,7 +652,7 @@ bool android_image_get_dtb_by_index(ulong hdr_addr, ulong vendor_boot_img,
 	return false;
 }
 
-#if !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_XPL_BUILD)
 /**
  * android_print_contents - prints out the contents of the Android format image
  * @hdr: pointer to the Android format image header
diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index fe328df4a85..35873b1fb0e 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -48,7 +48,7 @@ struct image_region *fit_region_make_list(const void *fit,
 	 * Use malloc() except in SPL (to save code size). In SPL the caller
 	 * must allocate the array.
 	 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD) && !region)
+	if (!IS_ENABLED(CONFIG_XPL_BUILD) && !region)
 		region = calloc(sizeof(*region), count);
 	if (!region)
 		return NULL;
diff --git a/cmd/Makefile b/cmd/Makefile
index 91227f1249c..ed62e1c45f8 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2004-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 # core command
 obj-y += boot.o
 obj-$(CONFIG_CMD_BOOTM) += bootm.o
@@ -247,7 +247,7 @@ obj-$(CONFIG_ARCH_MVEBU) += mvebu/
 obj-$(CONFIG_ARCH_KEYSTONE) += ti/
 obj-$(CONFIG_ARCH_K3) += ti/
 obj-$(CONFIG_ARCH_OMAP2PLUS) += ti/
-endif # !CONFIG_SPL_BUILD
+endif # !CONFIG_XPL_BUILD
 
 obj-$(CONFIG_$(SPL_)CMD_TLV_EEPROM) += tlv_eeprom.o
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 98a687bcabb..74ff5c6fc11 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -49,7 +49,7 @@ DECLARE_GLOBAL_DATA_PTR;
  */
 #define	MAX_ENV_SIZE	(1 << 20)	/* 1 MiB */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 /*
  * Command interface: print one or all environment variables
  *
@@ -182,9 +182,9 @@ DONE:
 	return 0;
 }
 #endif
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_env_set(struct cmd_tbl *cmdtp, int flag, int argc,
 		      char *const argv[])
 {
@@ -503,9 +503,9 @@ static int do_env_select(struct cmd_tbl *cmdtp, int flag, int argc,
 }
 #endif
 
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 static int do_env_default(struct cmd_tbl *cmdtp, int flag,
 			  int argc, char *const argv[])
 {
@@ -1289,4 +1289,4 @@ U_BOOT_CMD_COMPLETE(
 	var_complete
 );
 #endif
-#endif /* CONFIG_SPL_BUILD */
+#endif /* CONFIG_XPL_BUILD */
diff --git a/common/Makefile b/common/Makefile
index c52d4c39f6b..ae8984659c0 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 # core
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
@@ -42,12 +42,12 @@ obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
 
-endif # !CONFIG_SPL_BUILD
+endif # !CONFIG_XPL_BUILD
 
 obj-$(CONFIG_$(SPL_TPL_)BOOTSTAGE) += bootstage.o
 obj-$(CONFIG_$(SPL_TPL_)BLOBLIST) += bloblist.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_SPL_DFU
 obj-$(CONFIG_DFU_OVER_USB) += dfu.o
 endif
@@ -58,7 +58,7 @@ obj-$(CONFIG_SPL_USB_STORAGE) += usb_storage.o
 obj-$(CONFIG_SPL_MUSB_NEW) += usb.o
 obj-$(CONFIG_SPL_SPLASH_SCREEN) += splash.o
 obj-$(CONFIG_SPL_SPLASH_SOURCE) += splash_source.o
-endif # CONFIG_SPL_BUILD
+endif # CONFIG_XPL_BUILD
 
 #others
 obj-$(CONFIG_DDR_SPD) += ddr_spd.o
diff --git a/common/cli_readline.c b/common/cli_readline.c
index 4cb82b40149..4e6797a1944 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -73,7 +73,7 @@ static char *delete_char (char *buffer, char *p, int *colp, int *np, int plen)
 #define getcmd_getch()		getchar()
 #define getcmd_cbeep()		getcmd_putch('\a')
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 #define HIST_MAX		3
 #define HIST_SIZE		32
 #else
diff --git a/common/console.c b/common/console.c
index c9e206aec41..22224701e45 100644
--- a/common/console.c
+++ b/common/console.c
@@ -191,7 +191,7 @@ static int console_setfile(int file, struct stdio_dev * dev)
 		/* Assign the new device (leaving the existing one started) */
 		stdio_devices[file] = dev;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 		/*
 		 * Update monitor functions
 		 * (to use the console stuff by other applications)
diff --git a/common/hash.c b/common/hash.c
index ac63803fed9..db6925d6782 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -403,7 +403,7 @@ int hash_block(const char *algo_name, const void *data, unsigned int len,
 	return 0;
 }
 
-#if !defined(CONFIG_SPL_BUILD) && (defined(CONFIG_CMD_HASH) || \
+#if !defined(CONFIG_XPL_BUILD) && (defined(CONFIG_CMD_HASH) || \
 	defined(CONFIG_CMD_SHA1SUM) || defined(CONFIG_CMD_CRC32)) || \
 	defined(CONFIG_CMD_MD5SUM)
 /**
diff --git a/common/spl/Makefile b/common/spl/Makefile
index 137b18428bd..10528b31a7c 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -6,7 +6,7 @@
 # Based on common/Makefile.
 #
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_$(SPL_TPL_)FRAMEWORK) += spl.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTROM_SUPPORT) += spl_bootrom.o
 obj-$(CONFIG_$(SPL_TPL_)LOAD_FIT) += spl_fit.o
diff --git a/common/splash_source.c b/common/splash_source.c
index 5b271160449..f43e7cc1be7 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -215,7 +215,7 @@ static int splash_init_virtio(void)
 	}
 }
 
-#if defined(CONFIG_CMD_UBIFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_UBIFS) && !defined(CONFIG_XPL_BUILD)
 static int splash_mount_ubifs(struct splash_location *location)
 {
 	int res;
diff --git a/config.mk b/config.mk
index b915c29b3f3..e294be2a4c4 100644
--- a/config.mk
+++ b/config.mk
@@ -21,7 +21,7 @@ VENDOR :=
 
 ARCH := $(CONFIG_SYS_ARCH:"%"=%)
 CPU := $(CONFIG_SYS_CPU:"%"=%)
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 ifdef CONFIG_ARCH_TEGRA
 CPU := arm720t
 endif
diff --git a/disk/part.c b/disk/part.c
index 706d77b3194..303178161c0 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -482,7 +482,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	}
 #endif
 
-#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_CMD_UBIFS) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	/*
 	 * Special-case ubi, ubi goes through a mtd, rather than through
 	 * a regular block device.
diff --git a/disk/part_dos.c b/disk/part_dos.c
index 09af2aeeb99..96f748702fd 100644
--- a/disk/part_dos.c
+++ b/disk/part_dos.c
@@ -100,7 +100,7 @@ static int test_block_type(unsigned char *buffer)
 
 static int part_test_dos(struct blk_desc *desc)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	ALLOC_CACHE_ALIGN_BUFFER(legacy_mbr, mbr,
 			DIV_ROUND_UP(desc->blksz, sizeof(legacy_mbr)));
 
diff --git a/doc/develop/distro.rst b/doc/develop/distro.rst
index 9e715b23ebb..637bc27fc2d 100644
--- a/doc/develop/distro.rst
+++ b/doc/develop/distro.rst
@@ -189,7 +189,7 @@ TO BE UPDATED:
 
 In your board configuration file, include the following::
 
-    #ifndef CONFIG_SPL_BUILD
+    #ifndef CONFIG_XPL_BUILD
     #include <config_distro_bootcmd.h>
     #endif
 
@@ -316,7 +316,7 @@ that it supports the correct set of possible boot device types. To provide this
 configuration, simply define macro BOOT_TARGET_DEVICES prior to including
 <config_distro_bootcmd.h>. For example::
 
-    #ifndef CONFIG_SPL_BUILD
+    #ifndef CONFIG_XPL_BUILD
     #define BOOT_TARGET_DEVICES(func) \
             func(MMC, mmc, 1) \
             func(MMC, mmc, 0) \
diff --git a/doc/develop/qconfig.rst b/doc/develop/qconfig.rst
index 123779eab17..a18f32470ca 100644
--- a/doc/develop/qconfig.rst
+++ b/doc/develop/qconfig.rst
@@ -226,7 +226,7 @@ Available options
    Look for moved config options in spl/include/autoconf.mk instead of
    include/autoconf.mk.  This is useful for moving options for SPL build
    because SPL related options (mostly prefixed with CONFIG_SPL\_) are
-   sometimes blocked by CONFIG_SPL_BUILD ifdef conditionals.
+   sometimes blocked by CONFIG_XPL_BUILD ifdef conditionals.
 
  -j, --jobs
    Specify the number of threads to run simultaneously.  If not specified,
diff --git a/doc/develop/tests_sandbox.rst b/doc/develop/tests_sandbox.rst
index 72923070150..0630180bc55 100644
--- a/doc/develop/tests_sandbox.rst
+++ b/doc/develop/tests_sandbox.rst
@@ -278,7 +278,7 @@ Whatever sandbox build is used, which tests are present is determined by which
 source files are built. For sandbox_spl, the of_platdata tests are built
 because of the build rule in test/dm/Makefile::
 
-   ifeq ($(CONFIG_SPL_BUILD),y)
+   ifeq ($(CONFIG_XPL_BUILD),y)
    obj-$(CONFIG_SPL_OF_PLATDATA) += of_platdata.o
    else
    ...other tests for non-spl
diff --git a/dts/Makefile b/dts/Makefile
index d6c2c9daf31..62a65688cf5 100644
--- a/dts/Makefile
+++ b/dts/Makefile
@@ -53,7 +53,7 @@ PHONY += arch-dtbs
 arch-dtbs:
 	$(Q)$(MAKE) $(build)=$(dt_dir) dtbs
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_OF_EMBED) := dt-spl.dtb.o
 # support "out-of-tree" build for dtb-spl
 $(obj)/dt-spl.dtb.o: $(obj)/dt-spl.dtb.S FORCE
diff --git a/env/Makefile b/env/Makefile
index 673b979fdfa..c5145c1735f 100644
--- a/env/Makefile
+++ b/env/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += env.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += attr.o
 obj-$(CONFIG_$(SPL_TPL_)ENV_SUPPORT) += flags.o
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 obj-y += callback.o
 obj-$(CONFIG_ENV_IS_IN_EEPROM) += eeprom.o
 obj-$(CONFIG_ENV_IS_IN_EEPROM) += embedded.o
diff --git a/env/common.c b/env/common.c
index 6cba7f1c187..a58955a4f42 100644
--- a/env/common.c
+++ b/env/common.c
@@ -61,7 +61,7 @@ int env_do_env_set(int flag, int argc, char *const argv[], int env_flag)
 
 	debug("Initial value for argc=%d\n", argc);
 
-#if !IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)
+#if !IS_ENABLED(CONFIG_XPL_BUILD) && IS_ENABLED(CONFIG_CMD_NVEDIT_EFI)
 	if (argc > 1 && argv[1][0] == '-' && argv[1][1] == 'e')
 		return do_env_set_efi(NULL, flag, --argc, ++argv);
 #endif
@@ -551,7 +551,7 @@ int env_export(env_t *env_out)
 void env_relocate(void)
 {
 	if (gd->env_valid == ENV_INVALID) {
-#if defined(CONFIG_ENV_IS_NOWHERE) || defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_ENV_IS_NOWHERE) || defined(CONFIG_XPL_BUILD)
 		/* Environment not changable */
 		env_set_default(NULL, 0);
 #else
diff --git a/env/fat.c b/env/fat.c
index f3f8b7301ee..b04b1d9c315 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -22,7 +22,7 @@
 #include <asm/global_data.h>
 #include <linux/stddef.h>
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 /* TODO(sjg@chromium.org): Figure out why this is needed */
 # if !defined(CONFIG_TARGET_AM335X_EVM) || defined(CONFIG_SPL_OS_BOOT)
 #  define LOADENV
@@ -129,7 +129,7 @@ static int env_fat_load(void)
 	if (!strcmp(ifname, "mmc"))
 		mmc_initialize(NULL);
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #if defined(CONFIG_AHCI) || defined(CONFIG_SCSI)
 	if (!strcmp(CONFIG_ENV_FAT_INTERFACE, "scsi"))
 		scsi_scan(true);
diff --git a/env/flash.c b/env/flash.c
index 1bd6e7003d6..0f7393d830c 100644
--- a/env/flash.c
+++ b/env/flash.c
@@ -22,7 +22,7 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 # if defined(CONFIG_CMD_SAVEENV) && defined(CONFIG_CMD_FLASH)
 #  include <flash.h>
 #  define CMD_SAVEENV
@@ -35,11 +35,11 @@ DECLARE_GLOBAL_DATA_PTR;
 #if (!defined(CONFIG_MICROBLAZE) && !defined(CONFIG_ARCH_ZYNQ) && \
 	!defined(CONFIG_TARGET_MCCMON6) && !defined(CONFIG_TARGET_X600) && \
 	!defined(CONFIG_TARGET_EDMINIV2)) || \
-	!defined(CONFIG_SPL_BUILD)
+	!defined(CONFIG_XPL_BUILD)
 #define LOADENV
 #endif
 
-#if !defined(CONFIG_TARGET_X600) || !defined(CONFIG_SPL_BUILD)
+#if !defined(CONFIG_TARGET_X600) || !defined(CONFIG_XPL_BUILD)
 #define INITENV
 #endif
 
diff --git a/env/mmc.c b/env/mmc.c
index 0338aa6c56a..5fc0dae23a8 100644
--- a/env/mmc.c
+++ b/env/mmc.c
@@ -239,7 +239,7 @@ static void fini_mmc_for_env(struct mmc *mmc)
 	mmc_set_env_part_restore(mmc);
 }
 
-#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
 static inline int write_env(struct mmc *mmc, unsigned long size,
 			    unsigned long offset, const void *buffer)
 {
@@ -368,7 +368,7 @@ fini:
 	fini_mmc_for_env(mmc);
 	return ret;
 }
-#endif /* CONFIG_CMD_SAVEENV && !CONFIG_SPL_BUILD */
+#endif /* CONFIG_CMD_SAVEENV && !CONFIG_XPL_BUILD */
 
 static inline int read_env(struct mmc *mmc, unsigned long size,
 			   unsigned long offset, const void *buffer)
@@ -498,7 +498,7 @@ U_BOOT_ENV_LOCATION(mmc) = {
 	.location	= ENVL_MMC,
 	ENV_NAME("MMC")
 	.load		= env_mmc_load,
-#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_SAVEENV) && !defined(CONFIG_XPL_BUILD)
 	.save		= env_save_ptr(env_mmc_save),
 	.erase		= ENV_ERASE_PTR(env_mmc_erase)
 #endif
diff --git a/env/nand.c b/env/nand.c
index fef5697ec39..fdaa903cd61 100644
--- a/env/nand.c
+++ b/env/nand.c
@@ -26,9 +26,9 @@
 #include <u-boot/crc.h>
 
 #if defined(CONFIG_CMD_SAVEENV) && defined(CONFIG_CMD_NAND) && \
-		!defined(CONFIG_SPL_BUILD)
+		!defined(CONFIG_XPL_BUILD)
 #define CMD_SAVEENV
-#elif defined(CONFIG_ENV_OFFSET_REDUND) && !defined(CONFIG_SPL_BUILD)
+#elif defined(CONFIG_ENV_OFFSET_REDUND) && !defined(CONFIG_XPL_BUILD)
 #error CONFIG_ENV_OFFSET_REDUND must have CONFIG_CMD_SAVEENV & CONFIG_CMD_NAND
 #endif
 
@@ -224,7 +224,7 @@ static int env_nand_save(void)
 }
 #endif /* CMD_SAVEENV */
 
-#if defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static int readenv(size_t offset, u_char *buf)
 {
 	return nand_spl_load_image(offset, CONFIG_ENV_SIZE, buf);
@@ -265,7 +265,7 @@ static int readenv(size_t offset, u_char *buf)
 
 	return 0;
 }
-#endif /* #if defined(CONFIG_SPL_BUILD) */
+#endif /* #if defined(CONFIG_XPL_BUILD) */
 
 #ifdef CONFIG_ENV_OFFSET_OOB
 int get_nand_env_oob(struct mtd_info *mtd, unsigned long *result)
diff --git a/env/nowhere.c b/env/nowhere.c
index 326f27db2e9..6b9b6e2fe0b 100644
--- a/env/nowhere.c
+++ b/env/nowhere.c
@@ -33,7 +33,7 @@ static int env_nowhere_load(void)
 	 * searches default_environment array in that case.
 	 * For U-Boot proper, import the default environment to allow reload.
 	 */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD))
+	if (!IS_ENABLED(CONFIG_XPL_BUILD))
 		env_set_default(NULL, 0);
 
 	gd->env_valid = ENV_INVALID;
diff --git a/env/sf.c b/env/sf.c
index 21ac0c202e7..eb4c8d5ec95 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -329,7 +329,7 @@ done:
 
 __weak void *env_sf_get_env_addr(void)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	return (void *)CONFIG_ENV_ADDR;
 #else
 	return NULL;
diff --git a/fs/Makefile b/fs/Makefile
index 7b05c79e0cc..ec3e31c7c75 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -4,7 +4,7 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 # Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_FS_LOADER) += fs.o
 obj-$(CONFIG_SPL_FS_FAT) += fat/
 obj-$(CONFIG_SPL_FS_EXT4) += ext4/
diff --git a/fs/fs.c b/fs/fs.c
index 4bc28d1dffb..e2915e7cf79 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -237,7 +237,7 @@ static struct fstype_info fstypes[] = {
 		.mkdir = fs_mkdir_unsupported,
 	},
 #endif
-#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_SPL_BUILD)
+#if IS_ENABLED(CONFIG_SANDBOX) && !IS_ENABLED(CONFIG_XPL_BUILD)
 	{
 		.fstype = FS_TYPE_SANDBOX,
 		.name = "sandbox",
@@ -275,7 +275,7 @@ static struct fstype_info fstypes[] = {
 		.ln = fs_ln_unsupported,
 	},
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_CMD_UBIFS
 	{
 		.fstype = FS_TYPE_UBIFS,
@@ -296,7 +296,7 @@ static struct fstype_info fstypes[] = {
 	},
 #endif
 #endif
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 #ifdef CONFIG_FS_BTRFS
 	{
 		.fstype = FS_TYPE_BTRFS,
diff --git a/lib/Makefile b/lib/Makefile
index d300249f57c..66f84408aae 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -3,7 +3,7 @@
 # (C) Copyright 2000-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ifndef CONFIG_SPL_BUILD
+ifndef CONFIG_XPL_BUILD
 
 obj-$(CONFIG_EFI) += efi/
 obj-$(CONFIG_EFI_LOADER) += efi_driver/
@@ -96,7 +96,7 @@ obj-$(CONFIG_LIBAVB) += libavb/
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += libfdt/
 obj-$(CONFIG_$(SPL_TPL_)OF_REAL) += fdtdec_common.o fdtdec.o
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 obj-$(CONFIG_SPL_YMODEM_SUPPORT) += crc16-ccitt.o
 obj-$(CONFIG_$(SPL_TPL_)HASH) += crc16-ccitt.o
 obj-$(CONFIG_MMC_SPI_CRC_ON) += crc16-ccitt.o
@@ -131,7 +131,7 @@ obj-$(CONFIG_LIB_UUID) += uuid.o
 obj-$(CONFIG_LIB_RAND) += rand.o
 obj-y += panic.o
 
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 # SPL U-Boot may use full-printf, tiny-printf or none at all
 ifdef CONFIG_$(SPL_TPL_)USE_TINY_PRINTF
 obj-$(CONFIG_$(SPL_TPL_)SPRINTF) += tiny-printf.o
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bec1bc95a65..3259c951241 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -18,12 +18,12 @@ rsa_public_key-y := \
 	rsa_helper.o
 
 $(obj)/rsapubkey.asn1.o: $(obj)/rsapubkey.asn1.c $(obj)/rsapubkey.asn1.h
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 CFLAGS_rsapubkey.asn1.o += -I$(obj)
 endif
 
 $(obj)/rsa_helper.o: $(obj)/rsapubkey.asn1.h
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 CFLAGS_rsa_helper.o += -I$(obj)
 endif
 
diff --git a/lib/display_options.c b/lib/display_options.c
index d5df53ab15f..2c15cc5b5c4 100644
--- a/lib/display_options.c
+++ b/lib/display_options.c
@@ -236,7 +236,7 @@ int print_buffer(ulong addr, const void *data, uint width, uint count,
 		addr += thislinelen * width;
 		count -= thislinelen;
 
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc())
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && ctrlc())
 			return -EINTR;
 	}
 
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index 6276b27af33..b2d38795a48 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1230,7 +1230,7 @@ static void *fdt_find_separate(void)
 	if (IS_ENABLED(CONFIG_SANDBOX))
 		return NULL;
 
-#ifdef CONFIG_SPL_BUILD
+#ifdef CONFIG_XPL_BUILD
 	/* FDT is at end of BSS unless it is in a different memory region */
 	if (IS_ENABLED(CONFIG_SPL_SEPARATE_BSS))
 		fdt_blob = (ulong *)_image_binary_end;
@@ -1714,7 +1714,7 @@ int fdtdec_setup(void)
 	}
 
 	/* Allow the early environment to override the fdt address */
-	if (!IS_ENABLED(CONFIG_SPL_BUILD)) {
+	if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
 		ulong addr;
 
 		addr = env_get_hex("fdtcontroladdr", 0);
diff --git a/lib/hang.c b/lib/hang.c
index 3cfb06e9ca8..f3c3c896f0a 100644
--- a/lib/hang.c
+++ b/lib/hang.c
@@ -22,7 +22,7 @@
  */
 void hang(void)
 {
-#if !defined(CONFIG_SPL_BUILD) || \
+#if !defined(CONFIG_XPL_BUILD) || \
 		(CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) && \
 		 CONFIG_IS_ENABLED(SERIAL))
 	puts("### ERROR ### Please RESET the board ###\n");
diff --git a/lib/hashtable.c b/lib/hashtable.c
index 9613adc5540..e8a59e2dcac 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -221,7 +221,7 @@ static int
 do_callback(const struct env_entry *e, const char *name, const char *value,
 	    enum env_op op, int flags)
 {
-#ifndef CONFIG_SPL_BUILD
+#ifndef CONFIG_XPL_BUILD
 	if (e->callback)
 		return e->callback(name, value, op, flags);
 #endif
@@ -487,7 +487,7 @@ int hdelete_r(const char *key, struct hsearch_data *htab, int flag)
 	return 0;
 }
 
-#if !(defined(CONFIG_SPL_BUILD) && !defined(CONFIG_SPL_SAVEENV))
+#if !(defined(CONFIG_XPL_BUILD) && !defined(CONFIG_SPL_SAVEENV))
 /*
  * hexport()
  */
diff --git a/lib/hexdump.c b/lib/hexdump.c
index 2bc508ff504..29feccd60fc 100644
--- a/lib/hexdump.c
+++ b/lib/hexdump.c
@@ -157,7 +157,7 @@ int print_hex_dump(const char *prefix_str, int prefix_type, int rowsize,
 			printf("%s%s\n", prefix_str, linebuf);
 			break;
 		}
-		if (!IS_ENABLED(CONFIG_SPL_BUILD) && ctrlc())
+		if (!IS_ENABLED(CONFIG_XPL_BUILD) && ctrlc())
 			return -EINTR;
 	}
 
diff --git a/lib/uuid.c b/lib/uuid.c
index 11b86ffb02e..c6a27b7d044 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -477,7 +477,7 @@ void gen_rand_uuid_str(char *uuid_str, int str_format)
 	uuid_bin_to_str(uuid_bin, uuid_str, str_format);
 }
 
-#if !defined(CONFIG_SPL_BUILD) && defined(CONFIG_CMD_UUID)
+#if !defined(CONFIG_XPL_BUILD) && defined(CONFIG_CMD_UUID)
 int do_uuid(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	char uuid[UUID_STR_LEN + 1];
diff --git a/net/bootp.c b/net/bootp.c
index 512ab2ed7c8..afd5b48094a 100644
--- a/net/bootp.c
+++ b/net/bootp.c
@@ -434,7 +434,7 @@ static u8 *add_vci(u8 *e)
 	char *vci = NULL;
 	char *env_vci = env_get("bootp_vci");
 
-#if defined(CONFIG_SPL_BUILD) && defined(CONFIG_SPL_NET_VCI_STRING)
+#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_NET_VCI_STRING)
 	vci = CONFIG_SPL_NET_VCI_STRING;
 #elif defined(CONFIG_BOOTP_VCI_STRING)
 	vci = CONFIG_BOOTP_VCI_STRING;
diff --git a/net/net.c b/net/net.c
index 1e0b7c85624..fd7d413e488 100644
--- a/net/net.c
+++ b/net/net.c
@@ -305,7 +305,7 @@ U_BOOT_ENV_CALLBACK(dnsip, on_dnsip);
  */
 void net_auto_load(void)
 {
-#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_XPL_BUILD)
 	const char *s = env_get("autoload");
 
 	if (s != NULL && strcmp(s, "NFS") == 0) {
@@ -559,7 +559,7 @@ restart:
 			ping6_start();
 			break;
 #endif
-#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_CMD_NFS) && !defined(CONFIG_XPL_BUILD)
 		case NFS:
 			nfs_start();
 			break;
@@ -574,7 +574,7 @@ restart:
 			cdp_start();
 			break;
 #endif
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 		case NETCONS:
 			nc_start();
 			break;
@@ -1439,7 +1439,7 @@ void net_process_received_packet(uchar *in_packet, int len)
 			}
 		}
 
-#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_SPL_BUILD)
+#if defined(CONFIG_NETCONSOLE) && !defined(CONFIG_XPL_BUILD)
 		nc_input_packet((uchar *)ip + IP_UDP_HDR_SIZE,
 				src_ip,
 				ntohs(ip->udp_dst),
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 5daceb26061..b70b75ee68d 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -324,7 +324,7 @@ endif
 # do not delete intermediate files automatically
 .SECONDARY:
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 SPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
 SPL_TPL_ := VPL_
diff --git a/scripts/Makefile.xpl b/scripts/Makefile.xpl
index ad21d451a30..08453f0b415 100644
--- a/scripts/Makefile.xpl
+++ b/scripts/Makefile.xpl
@@ -55,7 +55,7 @@ endif
 
 export SPL_NAME
 
-ifdef CONFIG_SPL_BUILD
+ifdef CONFIG_XPL_BUILD
 SPL_ := SPL_
 ifeq ($(CONFIG_VPL_BUILD),y)
 SPL_TPL_ := VPL_
diff --git a/test/Makefile b/test/Makefile
index ed312cd0a48..f801d87e385 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_$(SPL_)CMDLINE) += str_ut.o
 obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index 38ba89ee33e..53fddebd49d 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -256,7 +256,7 @@ U_BOOT_LONGHELP(ut,
 	"\ntime - very basic test of time functions"
 #endif
 #if defined(CONFIG_UT_UNICODE) && \
-	!defined(CONFIG_SPL_BUILD) && !defined(API_BUILD)
+	!defined(CONFIG_XPL_BUILD) && !defined(API_BUILD)
 	"\nunicode - Unicode functions"
 #endif
 	);
diff --git a/test/dm/Makefile b/test/dm/Makefile
index c12589d487c..c6c63051e0b 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_UT_DM) += test-dm.o
 
 # Tests for particular subsystems - when enabling driver model for a new
 # subsystem you must add sandbox tests here.
-ifeq ($(CONFIG_SPL_BUILD),y)
+ifeq ($(CONFIG_XPL_BUILD),y)
 obj-$(CONFIG_SPL_OF_PLATDATA) += of_platdata.o
 else
 obj-$(CONFIG_UT_DM) += bus.o
diff --git a/test/lib/Makefile b/test/lib/Makefile
index 70f14c46b1e..a54387a058e 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -2,7 +2,7 @@
 #
 # (C) Copyright 2018
 # Mario Six, Guntermann & Drunck GmbH, mario.six@gdsys.cc
-ifeq ($(CONFIG_SPL_BUILD),)
+ifeq ($(CONFIG_XPL_BUILD),)
 obj-y += cmd_ut_lib.o
 obj-y += abuf.o
 obj-y += alist.o
diff --git a/test/test-main.c b/test/test-main.c
index b3d3e24cdce..479dbb33b72 100644
--- a/test/test-main.c
+++ b/test/test-main.c
@@ -47,7 +47,7 @@ enum fdtchk_t {
 static enum fdtchk_t fdt_action(void)
 {
 	/* For sandbox SPL builds, do nothing */
-	if (IS_ENABLED(CONFIG_SANDBOX) && IS_ENABLED(CONFIG_SPL_BUILD))
+	if (IS_ENABLED(CONFIG_SANDBOX) && IS_ENABLED(CONFIG_XPL_BUILD))
 		return FDTCHK_NONE;
 
 	/* Do a copy for sandbox (but only the U-Boot build, not SPL) */
diff --git a/tools/binman/test/generated/autoconf.h b/tools/binman/test/generated/autoconf.h
index 6a23039f469..75af48f9116 100644
--- a/tools/binman/test/generated/autoconf.h
+++ b/tools/binman/test/generated/autoconf.h
@@ -1,3 +1,3 @@
 #define CONFIG_BINMAN 1
-#define CONFIG_SPL_BUILD 1
+#define CONFIG_XPL_BUILD 1
 #define CONFIG_SPL_BINMAN_SYMBOLS 1
-- 
2.34.1

