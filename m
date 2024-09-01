Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D719CA101E
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C8688D06;
	Mon,  2 Sep 2024 00:27:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gzx9Efjv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C066888D06; Mon,  2 Sep 2024 00:27:54 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5275387CF8
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-829e86cb467so152110039f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229671; x=1725834471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWIYN0SIxUBteWgMFcb5Ppoh3L79pBuGU3qqquNTE00=;
 b=gzx9EfjvxmthatQ8Q7CIh/Fdq9sEuqUW9VbPoHHDloYv4akr32KJhENPMTOimuriMo
 RCjwjL4KPQKUep1bSnbNeNuXf3ycqEhCocX8qK41hR63MAP2tBRsTFlNl1ZZ5MkkQMcf
 41nXx7phxWsVFjXgR1pXAtWBPjpJVJYPDKZ9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229671; x=1725834471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWIYN0SIxUBteWgMFcb5Ppoh3L79pBuGU3qqquNTE00=;
 b=lBWa8ElO0lDVMPhGExYuuL97H8asVqRg0DNhlPduJQFp7l6hgjYzlbQMw+Ll0gtCl9
 V9VCEXXJtPqtje+WasyNHUL+r8vwyKZna/fiH65TsPdGwkMwDLiZCiffvRkn2TXrDbVO
 8O9Hw7x+XgGHEL4gwtQ9JWrlL1WzOstuSPMZ9xExuR93gQj7ncZwTzEIf/pMTxa8cDJx
 jLIUlNRip+KaAOcYlI1VYZzAUjh+EJevAsf8C9qGasMohy8bgh1y9Yy53jhDkv8QhKmm
 8RA/+q4lzoiYQZeiLnvHLcH3HzrCHx96459bZSbOS64k/HFrE+uCF1y1QNnc0qyLva/N
 77aw==
X-Gm-Message-State: AOJu0Ywg6BdQyVXidLuCQjtoISlz/O5LFYKHFCmm+gPjaqQiUThqg7Sd
 aquewX42v0T/VG3n4LFQP3g0CIink8TWxgMzurZIFvQ+ILmKlE9A8EMVXMlDAT2Vg+BxAtnBngg
 =
X-Google-Smtp-Source: AGHT+IGSjuICKvBwKBQ1eLsgtOOJceR0oSih4s/3NsAs1PuSwDvg0O79WFc60M3hmx7D6wiNYTpMcw==
X-Received: by 2002:a05:6602:13c1:b0:82a:2e24:7456 with SMTP id
 ca18e2360f4ac-82a36ee91camr664396439f.8.1725229670657; 
 Sun, 01 Sep 2024 15:27:50 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ced2e17bb4sm1866981173.82.2024.09.01.15.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:27:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 8/8] sunxi: Move to text environment
Date: Sun,  1 Sep 2024 16:27:34 -0600
Message-Id: <20240901222734.462334-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222734.462334-1-sjg@chromium.org>
References: <20240901222734.462334-1-sjg@chromium.org>
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

Convert these boards to use a text environment.

For the boards check, the only differences are extra spaces after the
semicolons in 'dfu_alt_info_ram' and 'partitions', both of which are
permitted.

Add in the special boot command for old kernels, dropping the
unnecessary and confusing hex prefixes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Keep bootcmd_sunxi_compat if OLD_SUNXI_KERNEL_COMPAT is enabled

 board/sunxi/sunxi.env          | 152 ++++++++++++++++++++++++++++++
 include/configs/sunxi-common.h | 165 ---------------------------------
 2 files changed, 152 insertions(+), 165 deletions(-)
 create mode 100644 board/sunxi/sunxi.env

diff --git a/board/sunxi/sunxi.env b/board/sunxi/sunxi.env
new file mode 100644
index 00000000000..6f28e720081
--- /dev/null
+++ b/board/sunxi/sunxi.env
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Common sunxi environment
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ /
+
+/****************************************************************************
+ *           environment variables holding default load addresses           *
+ ****************************************************************************/
+/*
+ * We cannot use expressions here, because expressions won't be evaluated in
+ * autoconf.mk.
+ */
+#ifdef CONFIG_ARM64
+/*
+ * Boards seem to come with at least 512MB of DRAM.
+ * The kernel should go at 512K, which is the default text offset (that will
+ * be adjusted at runtime if needed).
+ * There is no compression for arm64 kernels (yet), so leave some space
+ * for really big kernels, say 256MB for now.
+ * Scripts, PXE and DTBs should go afterwards, leaving the rest for the initrd.
+ */
+#define BOOTM_SIZE        0xa000000
+#define KERNEL_ADDR_R     SDRAM_OFFSET(0080000)
+#define KERNEL_COMP_ADDR_R SDRAM_OFFSET(4000000)
+#define KERNEL_COMP_SIZE  0xb000000
+#define FDT_ADDR_R        SDRAM_OFFSET(FA00000)
+#define SCRIPT_ADDR_R     SDRAM_OFFSET(FC00000)
+#define PXEFILE_ADDR_R    SDRAM_OFFSET(FD00000)
+#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(FE00000)
+#define RAMDISK_ADDR_R    SDRAM_OFFSET(FF00000)
+
+#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 256)
+/*
+ * 160M RAM (256M minimum minus 64MB heap + 32MB for u-boot, stack, fb, etc.
+ * 32M uncompressed kernel, 16M compressed kernel, 1M fdt,
+ * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
+ */
+#define BOOTM_SIZE        0xa000000
+#define KERNEL_ADDR_R     SDRAM_OFFSET(2000000)
+#define FDT_ADDR_R        SDRAM_OFFSET(3000000)
+#define SCRIPT_ADDR_R     SDRAM_OFFSET(3100000)
+#define PXEFILE_ADDR_R    SDRAM_OFFSET(3200000)
+#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(3300000)
+#define RAMDISK_ADDR_R    SDRAM_OFFSET(3400000)
+
+#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 64)
+/*
+ * 64M RAM minus 2MB heap + 16MB for u-boot, stack, fb, etc.
+ * 16M uncompressed kernel, 8M compressed kernel, 1M fdt,
+ * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
+ */
+#define BOOTM_SIZE        0x2e00000
+#define KERNEL_ADDR_R     SDRAM_OFFSET(1000000)
+#define FDT_ADDR_R        SDRAM_OFFSET(1800000)
+#define SCRIPT_ADDR_R     SDRAM_OFFSET(1900000)
+#define PXEFILE_ADDR_R    SDRAM_OFFSET(1A00000)
+#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(1B00000)
+#define RAMDISK_ADDR_R    SDRAM_OFFSET(1C00000)
+
+#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 32)
+/*
+ * 32M RAM minus 2.5MB for u-boot, heap, stack, etc.
+ * 16M uncompressed kernel, 7M compressed kernel, 128K fdt, 64K script,
+ * 128K DT overlay, 128K PXE and the ramdisk in the rest (max. 5MB)
+ */
+#define BOOTM_SIZE        0x1700000
+#define KERNEL_ADDR_R     SDRAM_OFFSET(1000000)
+#define FDT_ADDR_R        SDRAM_OFFSET(1d50000)
+#define SCRIPT_ADDR_R     SDRAM_OFFSET(1d40000)
+#define PXEFILE_ADDR_R    SDRAM_OFFSET(1d00000)
+#define FDTOVERLAY_ADDR_R SDRAM_OFFSET(1d20000)
+#define RAMDISK_ADDR_R    SDRAM_OFFSET(1800000)
+
+#else
+#error Need at least 32MB of DRAM. Please adjust load addresses.
+#endif
+
+#define UUID_GPT_ESP ""
+
+#ifdef CONFIG_ARM64
+#define UUID_GPT_SYSTEM b921b045-1df0-41c3-af44-4c6f280d3fae
+#else
+#define UUID_GPT_SYSTEM 69dad710-2ce4-4e3c-b16c-21a1d49abed3
+#endif
+
+stdin=serial
+#ifdef CONFIG_USB_KEYBOARD
+stdin+=,usbkbd
+#endif
+
+stdout=serial
+stderr=serial
+#ifdef CONFIG_VIDEO
+stdout+=,vidconsole
+stderr+=,vidconsole
+#endif
+
+bootm_size=BOOTM_SIZE
+kernel_addr_r=KERNEL_ADDR_R
+fdt_addr_r=FDT_ADDR_R
+scriptaddr=SCRIPT_ADDR_R
+pxefile_addr_r=PXEFILE_ADDR_R
+fdtoverlay_addr_r=FDTOVERLAY_ADDR_R
+ramdisk_addr_r=RAMDISK_ADDR_R
+
+#ifdef CONFIG_ARM64
+kernel_comp_addr_r=KERNEL_COMP_ADDR_R
+kernel_comp_size=KERNEL_COMP_SIZE
+#endif
+
+dfu_alt_info_ram=
+  kernel ram KERNEL_ADDR_R 0x1000000;
+  fdt ram FDT_ADDR_R 0x100000;
+  ramdisk ram RAMDISK_ADDR_R 0x4000000
+
+#ifdef CONFIG_ARM64
+fdtfile=allwinner/DEFAULT_DEVICE_TREE.dtb
+#else
+fdtfile=DEFAULT_DEVICE_TREE.dtb
+#endif
+
+console=ttyS0,115200
+
+uuid_gpt_esp=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
+#ifdef CONFIG_ARM64
+uuid_gpt_system=b921b045-1df0-41c3-af44-4c6f280d3fae
+#else
+uuid_gpt_system=69dad710-2ce4-4e3c-b16c-21a1d49abed3
+#endif
+
+partitions=
+  name=loader1,start=8k,size=32k,uuid=${uuid_gpt_loader1};
+  name=loader2,size=984k,uuid=${uuid_gpt_loader2};
+  name=esp,size=128M,bootable,uuid=${uuid_gpt_esp};
+  name=system,size=-,uuid=${uuid_gpt_system};
+
+/* support booting a very old kernel */
+#ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
+bootcmd_sunxi_compat=
+  setenv root /dev/mmcblk0p3 rootwait;
+  if ext2load mmc 0 44000000 uEnv.txt; then
+          "echo Loaded environment from uEnv.txt;
+          "env import -t 44000000 ${filesize};
+  fi;
+  setenv bootargs console=${console} root=${root} ${extraargs};
+  ext2load mmc 0 43000000 script.bin &&
+  ext2load mmc 0 48000000 uImage &&
+  bootm 48000000
+#endif
diff --git a/include/configs/sunxi-common.h b/include/configs/sunxi-common.h
index 666553ccadb..ceea26494ad 100644
--- a/include/configs/sunxi-common.h
+++ b/include/configs/sunxi-common.h
@@ -61,169 +61,4 @@
 #define PHYS_SDRAM_0			CFG_SYS_SDRAM_BASE
 #define PHYS_SDRAM_0_SIZE		0x80000000 /* 2 GiB */
 
-/****************************************************************************
- *           environment variables holding default load addresses           *
- ****************************************************************************/
-/*
- * We cannot use expressions here, because expressions won't be evaluated in
- * autoconf.mk.
- */
-#ifdef CONFIG_ARM64
-/*
- * Boards seem to come with at least 512MB of DRAM.
- * The kernel should go at 512K, which is the default text offset (that will
- * be adjusted at runtime if needed).
- * There is no compression for arm64 kernels (yet), so leave some space
- * for really big kernels, say 256MB for now.
- * Scripts, PXE and DTBs should go afterwards, leaving the rest for the initrd.
- */
-#define BOOTM_SIZE        __stringify(0xa000000)
-#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(0080000))
-#define KERNEL_COMP_ADDR_R __stringify(SDRAM_OFFSET(4000000))
-#define KERNEL_COMP_SIZE  __stringify(0xb000000)
-#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(FA00000))
-#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(FC00000))
-#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(FD00000))
-#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(FE00000))
-#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(FF00000))
-
-#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 256)
-/*
- * 160M RAM (256M minimum minus 64MB heap + 32MB for u-boot, stack, fb, etc.
- * 32M uncompressed kernel, 16M compressed kernel, 1M fdt,
- * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
- */
-#define BOOTM_SIZE        __stringify(0xa000000)
-#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(2000000))
-#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(3000000))
-#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(3100000))
-#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(3200000))
-#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(3300000))
-#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(3400000))
-
-#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 64)
-/*
- * 64M RAM minus 2MB heap + 16MB for u-boot, stack, fb, etc.
- * 16M uncompressed kernel, 8M compressed kernel, 1M fdt,
- * 1M script, 1M pxe, 1M dt overlay and the ramdisk at the end.
- */
-#define BOOTM_SIZE        __stringify(0x2e00000)
-#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(1000000))
-#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(1800000))
-#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(1900000))
-#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(1A00000))
-#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(1B00000))
-#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(1C00000))
-
-#elif (CONFIG_SUNXI_MINIMUM_DRAM_MB >= 32)
-/*
- * 32M RAM minus 2.5MB for u-boot, heap, stack, etc.
- * 16M uncompressed kernel, 7M compressed kernel, 128K fdt, 64K script,
- * 128K DT overlay, 128K PXE and the ramdisk in the rest (max. 5MB)
- */
-#define BOOTM_SIZE        __stringify(0x1700000)
-#define KERNEL_ADDR_R     __stringify(SDRAM_OFFSET(1000000))
-#define FDT_ADDR_R        __stringify(SDRAM_OFFSET(1d50000))
-#define SCRIPT_ADDR_R     __stringify(SDRAM_OFFSET(1d40000))
-#define PXEFILE_ADDR_R    __stringify(SDRAM_OFFSET(1d00000))
-#define FDTOVERLAY_ADDR_R __stringify(SDRAM_OFFSET(1d20000))
-#define RAMDISK_ADDR_R    __stringify(SDRAM_OFFSET(1800000))
-
-#else
-#error Need at least 32MB of DRAM. Please adjust load addresses.
-#endif
-
-#define MEM_LAYOUT_ENV_SETTINGS \
-	"bootm_size=" BOOTM_SIZE "\0" \
-	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
-	"fdt_addr_r=" FDT_ADDR_R "\0" \
-	"scriptaddr=" SCRIPT_ADDR_R "\0" \
-	"pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
-	"fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
-	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0"
-
-#ifdef CONFIG_ARM64
-#define MEM_LAYOUT_ENV_EXTRA_SETTINGS \
-	"kernel_comp_addr_r=" KERNEL_COMP_ADDR_R "\0" \
-	"kernel_comp_size=" KERNEL_COMP_SIZE "\0"
-#else
-#define MEM_LAYOUT_ENV_EXTRA_SETTINGS ""
-#endif
-
-#define DFU_ALT_INFO_RAM \
-	"dfu_alt_info_ram=" \
-	"kernel ram " KERNEL_ADDR_R " 0x1000000;" \
-	"fdt ram " FDT_ADDR_R " 0x100000;" \
-	"ramdisk ram " RAMDISK_ADDR_R " 0x4000000\0"
-
-#ifdef CONFIG_OLD_SUNXI_KERNEL_COMPAT
-#define BOOTCMD_SUNXI_COMPAT \
-	"bootcmd_sunxi_compat=" \
-		"setenv root /dev/mmcblk0p3 rootwait; " \
-		"if ext2load mmc 0 0x44000000 uEnv.txt; then " \
-			"echo Loaded environment from uEnv.txt; " \
-			"env import -t 0x44000000 ${filesize}; " \
-		"fi; " \
-		"setenv bootargs console=${console} root=${root} ${extraargs}; " \
-		"ext2load mmc 0 0x43000000 script.bin && " \
-		"ext2load mmc 0 0x48000000 uImage && " \
-		"bootm 0x48000000\0"
-#else
-#define BOOTCMD_SUNXI_COMPAT
-#endif
-
-#ifdef CONFIG_USB_KEYBOARD
-#define CONSOLE_STDIN_SETTINGS \
-	"stdin=serial,usbkbd\0"
-#else
-#define CONSOLE_STDIN_SETTINGS \
-	"stdin=serial\0"
-#endif
-
-#ifdef CONFIG_VIDEO
-#define CONSOLE_STDOUT_SETTINGS \
-	"stdout=serial,vidconsole\0" \
-	"stderr=serial,vidconsole\0"
-#else
-#define CONSOLE_STDOUT_SETTINGS \
-	"stdout=serial\0" \
-	"stderr=serial\0"
-#endif
-
-#define PARTS_DEFAULT \
-	"name=loader1,start=8k,size=32k,uuid=${uuid_gpt_loader1};" \
-	"name=loader2,size=984k,uuid=${uuid_gpt_loader2};" \
-	"name=esp,size=128M,bootable,uuid=${uuid_gpt_esp};" \
-	"name=system,size=-,uuid=${uuid_gpt_system};"
-
-#define UUID_GPT_ESP "c12a7328-f81f-11d2-ba4b-00a0c93ec93b"
-
-#ifdef CONFIG_ARM64
-#define UUID_GPT_SYSTEM "b921b045-1df0-41c3-af44-4c6f280d3fae"
-#else
-#define UUID_GPT_SYSTEM "69dad710-2ce4-4e3c-b16c-21a1d49abed3"
-#endif
-
-#define CONSOLE_ENV_SETTINGS \
-	CONSOLE_STDIN_SETTINGS \
-	CONSOLE_STDOUT_SETTINGS
-
-#ifdef CONFIG_ARM64
-#define FDTFILE "allwinner/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
-#else
-#define FDTFILE CONFIG_DEFAULT_DEVICE_TREE ".dtb"
-#endif
-
-#define CFG_EXTRA_ENV_SETTINGS \
-	CONSOLE_ENV_SETTINGS \
-	MEM_LAYOUT_ENV_SETTINGS \
-	MEM_LAYOUT_ENV_EXTRA_SETTINGS \
-	DFU_ALT_INFO_RAM \
-	"fdtfile=" FDTFILE "\0" \
-	"console=ttyS0,115200\0" \
-	"uuid_gpt_esp=" UUID_GPT_ESP "\0" \
-	"uuid_gpt_system=" UUID_GPT_SYSTEM "\0" \
-	"partitions=" PARTS_DEFAULT "\0" \
-	BOOTCMD_SUNXI_COMPAT
-
 #endif /* _SUNXI_COMMON_CONFIG_H */
-- 
2.34.1

