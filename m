Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD244CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 20:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1E58394E;
	Mon, 11 May 2026 22:58:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gU1qbhXF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2500883C2B; Mon, 11 May 2026 22:58:38 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3693080086
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 22:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7dcd9061b1aso4225369a34.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 13:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778533114; x=1779137914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OG8gZIEVNQcv4tbWnXo75xRzwv2HvFSnWipzyltpVM4=;
 b=gU1qbhXFkiahO2YlyVU1RvQHkv5qkeAQ1ak1BFWze47/655f/CWvQZ9WCdV7RjcR6q
 CiPhvkcAmSKZtnrjbmxDjcC2QQBHMgIZPW5XAhAu5bRQitLHomfpVJmCFjBl/T/GjZR+
 2rydBB+5QdVj+xCSu2lBVrm1x9jAyNY5lIfyqKKLZt9jQ0HixIRISDi6cYSHrEktaHKd
 Rj/GVyQiHcRtYpm/aAhzW3v5Mme2eVZH5uedZ7ERLcv/G13AGTa0lPlVZkcDniCWZDCF
 cHx68xDlHI5J/RtPbnEksnEhZOSEqZJp6ZSz8HiCgSr9oWAPjbedESpzNjTk/xpWCfDw
 FNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778533114; x=1779137914;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OG8gZIEVNQcv4tbWnXo75xRzwv2HvFSnWipzyltpVM4=;
 b=Y2NcqOWq7td4mc6wzahsmZLre00dAmWCWqEHgRhCrpZL65oTFJUK+8jHogeTtgbemU
 vHyk0z61D09t0eqo52BdmW2f7g+uOKNwK6UA6u+SRBWIbxBtCA0vHn0NS9snoEj0CDZl
 8zy7zxJKffOc5n+9ksfkahTslpkqwNG86fgr+bLyyRd0IPb2BkS+MNRSeqYpBS3Frk/t
 HHDRZQ9Q42tFOj0Gf9ErmNI5n3wGZTM8nq3P8r7c9VaD9ZJEwvW32C8Ic4Sn7rZdTTEk
 oNEA4di62Vz/D8DZVMjcX/1cIHECYBNMqoW/2WczTiHhJgVdOTvhHCwdM+a6vUKTq8lD
 kdOg==
X-Gm-Message-State: AOJu0YxrBryvMYoj9ttlp3UVHRkPW/7otdSOtLIjly4yg9jqFUZyMlyP
 cBGN6uFAWYf2aXivuuA0jCw9l10ipRKovtH52PZPKiaDouEKE36dJ77XrLIX8LY5
X-Gm-Gg: Acq92OEVYa24mP/lfbz/YstXiP9pXEUdfHu+KqrmjM4Rg1ruu0l+NMqkeHJUKUo4a8D
 vmizl/ykltaAmDbszhBeEcZdEYEHBleBqMYZI+omx1ET3USrtThEopWSPofsElyeeZIJ1HCNk6H
 ZVYhwMLcfvL92sTviccv37WasEJxce7o2VLYZXbBkB9484R21AxcqajNXD3lC5ZbaJenGp+NlE/
 La09y5aNWfEJFb6Kdi2AZpUiHRtZPEv8UOri6L7XTpI2kh8j6R+aE+VU5fth/j0S6fORWekBHGX
 usRp+V22YAvADhGzazF3xHNI2hedSdKtgMfU3zIdlwJZhRD8Fnu22RryxCWPpQFWH1T4+DLz7tQ
 JZIo+RyjnoZFKy8N/5InWI8xifx15Mcywa87DPZl8/U2Xt15kcDzUy3f4/8Kk0wFJXJrBrQrLmp
 pevojqnzZpYWhra3qDPKQDsXB/6ohX82Bx+HCyAwAJquwuT9f2XCod1E6KIs/TVVe0M4ZG44ZM4
 ucmBffBHgCXKk86DEgL6I/K8Gl19qyfflU2EGNDQ8kq1FIzzS8D6LcOAp04wbn/E43KJw==
X-Received: by 2002:a05:6830:6d13:b0:7de:298:5332 with SMTP id
 46e09a7af769-7e1df24ed2bmr16391777a34.27.1778533113492; 
 Mon, 11 May 2026 13:58:33 -0700 (PDT)
Received: from james-x399.tailafd1a.ts.net (71-218-106-55.hlrn.qwest.net.
 [71.218.106.55]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367be1168sm7597584a34.5.2026.05.11.13.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:58:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
To: u-boot@lists.denx.de
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Tom Rini <trini@konsulko.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Bohdan Chubuk <chbgdn@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH] sunxi: add raw NAND secure storage support
Date: Mon, 11 May 2026 14:58:08 -0600
Message-ID: <20260511205813.86932-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Some sunxi boards boot from raw NAND using an Allwinner flash layout.
Factory data is stored in redundant secure-storage blocks after the
U-Boot proper area.

Mainline U-Boot needs to preserve this area when generating NAND
partition tables. It may also need to read factory data, such as the
Ethernet MAC address.

Add helpers to locate secure-storage marker blocks, read checksummed
store_object items through the MTD ECC path, set ethaddr from a
configurable key, and generate runtime mtdparts that place UBI after
the last secure-storage marker.

Secure-storage block discovery intentionally mirrors the existing NAND
layout: use marker-only discovery from the computed U-Boot proper end
to block 50. Item data remains checksum and CRC validated before use.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 board/sunxi/Kconfig               |  39 +++
 board/sunxi/Makefile              |   3 +
 board/sunxi/board.c               | 119 +++++++
 board/sunxi/nand_secure_storage.c | 521 ++++++++++++++++++++++++++++++
 board/sunxi/nand_secure_storage.h |  42 +++
 5 files changed, 724 insertions(+)
 create mode 100644 board/sunxi/nand_secure_storage.c
 create mode 100644 board/sunxi/nand_secure_storage.h

diff --git a/board/sunxi/Kconfig b/board/sunxi/Kconfig
index 084a8b0c6ca..c3826f0ade9 100644
--- a/board/sunxi/Kconfig
+++ b/board/sunxi/Kconfig
@@ -22,3 +22,42 @@ config SPL_IMAGE_TYPE
 	string
 	default "sunxi_egon" if SPL_IMAGE_TYPE_SUNXI_EGON
 	default "sunxi_toc0" if SPL_IMAGE_TYPE_SUNXI_TOC0
+
+config SUNXI_NAND_SECURE_STORAGE
+	bool "Allwinner NAND secure storage support"
+	depends on NAND_SUNXI && MTD_RAW_NAND
+	help
+	  Enable support for reading the Allwinner raw NAND secure-storage
+	  area from U-Boot proper. This is used by some sunxi boards to
+	  preserve factory data, such as MAC addresses, when booting a
+	  mainline NAND layout.
+
+config SUNXI_NAND_SECURE_STORAGE_ETHADDR
+	bool "Read ethaddr from Allwinner NAND secure storage"
+	depends on SUNXI_NAND_SECURE_STORAGE && NET
+	select CRC32
+	help
+	  Read the configured secure-storage key and use it as the primary
+	  Ethernet MAC address before the normal sunxi fallback environment
+	  value is generated.
+
+config SUNXI_NAND_SECURE_STORAGE_ETHADDR_KEY
+	string "NAND secure-storage key name for ethaddr"
+	depends on SUNXI_NAND_SECURE_STORAGE_ETHADDR
+	default "mac"
+	help
+	  Name of the secure-storage item containing the primary Ethernet MAC
+	  address. The store_object payload is parsed like a U-Boot
+	  Ethernet environment variable.
+
+config SUNXI_NAND_SECURE_STORAGE_MTD_PARTS
+	bool "Generate NAND mtdparts around secure storage"
+	depends on SUNXI_NAND_SECURE_STORAGE && SYS_MTDPARTS_RUNTIME
+	help
+	  Generate the default NAND mtdparts at runtime by locating
+	  secure-storage marker blocks and placing the UBI partition immediately
+	  after the last marker. This avoids hard-coding the secure-storage
+	  offset, which may shift when bad blocks are present before or inside
+	  the secure-storage window. Only SLC raw NAND is supported; MLC/TLC
+	  parts need Allwinner's LSB-block-size mapping, which is not available
+	  here.
diff --git a/board/sunxi/Makefile b/board/sunxi/Makefile
index ee82493117a..fda2a0bfe76 100644
--- a/board/sunxi/Makefile
+++ b/board/sunxi/Makefile
@@ -8,6 +8,9 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 obj-y	+= board.o
 obj-$(CONFIG_SUN7I_GMAC)	+= gmac.o
+ifndef CONFIG_XPL_BUILD
+obj-$(CONFIG_SUNXI_NAND_SECURE_STORAGE)	+= nand_secure_storage.o
+endif
 obj-$(CONFIG_MACH_SUN4I)	+= dram_sun4i_auto.o
 obj-$(CONFIG_MACH_SUN5I)	+= dram_sun5i_auto.o
 obj-$(CONFIG_MACH_SUN7I)	+= dram_sun5i_auto.o
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index 3d1afec7c66..19a0402eb03 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -50,9 +50,126 @@
 #include <spl.h>
 #include <sy8106a.h>
 #include <asm/setup.h>
+#include <vsprintf.h>
+
+#include "nand_secure_storage.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_SYS_MTDPARTS_RUNTIME) && !defined(CONFIG_XPL_BUILD)
+#define SUNXI_NAND_MTDIDS_MAXLEN	128
+#define SUNXI_NAND_MTDPARTS_MAXLEN	512
+
+static int sunxi_mtdparts_append(char *buf, size_t size, int *len,
+				 const char *fmt, ...)
+{
+	size_t avail;
+	va_list args;
+	int ret;
+
+	if (*len < 0 || (size_t)*len >= size)
+		return -ENOSPC;
+
+	avail = size - (size_t)*len;
+	va_start(args, fmt);
+	ret = vsnprintf(buf + *len, avail, fmt, args);
+	va_end(args);
+	if (ret < 0 || (size_t)ret >= avail)
+		return -ENOSPC;
+
+	*len += ret;
+	return 0;
+}
+
+static int sunxi_mtdparts_add(char *buf, size_t size, int *len,
+			      const char *name, u64 part_size, u64 offset,
+			      bool ro)
+{
+	return sunxi_mtdparts_append(buf, size, len, "0x%llx@0x%llx(%s)%s,",
+				    (unsigned long long)part_size,
+				    (unsigned long long)offset, name,
+				    ro ? "ro" : "");
+}
+
+void board_mtdparts_default(const char **mtdids, const char **mtdparts)
+{
+	static char ids[SUNXI_NAND_MTDIDS_MAXLEN];
+	static char parts[SUNXI_NAND_MTDPARTS_MAXLEN];
+	static bool generated;
+	struct sunxi_nand_secure_storage_info ss;
+	u32 i;
+	int len, ret;
+
+	*mtdids = NULL;
+	*mtdparts = NULL;
+
+	if (!IS_ENABLED(CONFIG_SUNXI_NAND_SECURE_STORAGE_MTD_PARTS))
+		return;
+
+	if (generated) {
+		*mtdids = ids;
+		*mtdparts = parts;
+		return;
+	}
+
+	ret = sunxi_nand_secure_storage_locate(&ss);
+	if (ret) {
+		debug("sunxi secure storage: no dynamic mtdparts: %d\n", ret);
+		return;
+	}
+
+	if (!ss.mtd_name || !ss.mtd_size || !ss.spl_copy_size ||
+	    !ss.spl_copy_count || !ss.uboot_size || !ss.secure_size) {
+		debug("sunxi secure storage: invalid dynamic mtdparts geometry\n");
+		return;
+	}
+
+	if (ss.uboot_offset + ss.uboot_size > ss.secure_offset ||
+	    ss.secure_end >= ss.mtd_size) {
+		debug("sunxi secure storage: dynamic mtdparts would overlap\n");
+		return;
+	}
+
+	len = snprintf(ids, sizeof(ids), "nand0=%s", ss.mtd_name);
+	if (len < 0 || len >= sizeof(ids))
+		return;
+
+	len = snprintf(parts, sizeof(parts), "%s:", ss.mtd_name);
+	if (len < 0 || len >= sizeof(parts))
+		goto err;
+
+	for (i = 0; i < ss.spl_copy_count; i++) {
+		char name[16];
+
+		ret = snprintf(name, sizeof(name), "spl-%u", i);
+		if (ret < 0 || (size_t)ret >= sizeof(name))
+			goto err;
+		if (sunxi_mtdparts_add(parts, sizeof(parts), &len, name,
+				       ss.spl_copy_size,
+				       ss.spl_copy_size * i, false))
+			goto err;
+	}
+
+	if (sunxi_mtdparts_add(parts, sizeof(parts), &len, "uboot",
+			       ss.uboot_size, ss.uboot_offset, false))
+		goto err;
+	if (sunxi_mtdparts_add(parts, sizeof(parts), &len, "securestorage",
+			       ss.secure_size, ss.secure_offset, true))
+		goto err;
+	if (sunxi_mtdparts_append(parts, sizeof(parts), &len, "-@0x%llx(UBI)",
+				  (unsigned long long)ss.secure_end))
+		goto err;
+
+	generated = true;
+	*mtdids = ids;
+	*mtdparts = parts;
+	return;
+
+err:
+	ids[0] = '\0';
+}
+#endif
+
 void i2c_init_board(void)
 {
 #ifdef CONFIG_I2C0_ENABLE
@@ -792,6 +909,8 @@ static void setup_environment(const void *fdt)
 	char ethaddr[16];
 	int i;
 
+	sunxi_nand_secure_storage_setup_ethaddr();
+
 	if (!get_unique_sid(sid))
 		return;
 
diff --git a/board/sunxi/nand_secure_storage.c b/board/sunxi/nand_secure_storage.c
new file mode 100644
index 00000000000..f786a47430a
--- /dev/null
+++ b/board/sunxi/nand_secure_storage.c
@@ -0,0 +1,521 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Allwinner raw NAND secure-storage support.
+ *
+ * The Allwinner NAND layout stores redundant secure-storage blocks
+ * immediately after the U-Boot proper area. The blocks are identified by an
+ * OOB marker and their pages are read through the normal NAND ECC/randomizer
+ * path.
+ */
+
+#ifdef CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR
+#include <env.h>
+#include <net.h>
+#include <u-boot/crc.h>
+#endif
+#include <asm/unaligned.h>
+#include <memalign.h>
+#include <nand.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/rawnand.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+#include "nand_secure_storage.h"
+
+/*
+ * The Allwinner NAND layout scans up to block 50 and starts scanning at
+ * uboot_next_block. The U-Boot range below follows the geometry-dependent
+ * defaults used when no stored NAND partition table is present.
+ */
+#define SS_SCAN_END_BLOCK		50
+
+#define SS_SMALL_NAND_MAX_BLOCK_SIZE	SZ_1M
+#define SS_SMALL_NAND_MIN_BLOCK_SIZE	SZ_128K
+#define SS_SMALL_NAND_ALWAYS_BLOCK_SIZE	SZ_512K
+#define SS_SMALL_NAND_UBOOT_START	8
+#define SS_SMALL_NAND_UBOOT_SIZE	SZ_4M
+#define SS_MEDIUM_NAND_MAX_BLOCK_SIZE	SZ_2M
+#define SS_BIG_NAND_UBOOT_START		4
+#define SS_BIG_NAND_1M_UBOOT_BLOCKS	20
+#define SS_BIG_NAND_2M_UBOOT_BLOCKS	10
+#define SS_BIG_NAND_MIN_UBOOT_BLOCKS	8
+
+/*
+ * The H616/sun50iw9 NAND layout uses the 128-page SPL-copy geometry.
+ * Only unrelated SUN8IW18 and SUN50IW11 SoC families use the 256-page
+ * variant.
+ */
+#define SS_SPL_PAGE_CNT_PER_COPY	128
+
+#define SS_OOB_MAGIC_OFF		1
+#define SS_OOB_CHECKSUM_OFF		3
+#define SS_OOB_MAGIC			0xaa5c
+#define SS_OOB_MAGIC_SIZE		(SS_OOB_MAGIC_OFF + sizeof(u16))
+#define SS_OOB_CHECKSUM_SIZE		(SS_OOB_CHECKSUM_OFF + sizeof(u32))
+
+#ifdef CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR
+#define SS_ITEM_SIZE			SZ_4K
+#define SS_EMPTY_SUM			0x1234
+#define SS_ITEMS_PER_BLOCK		32
+#define SS_MAP_MAX_ENTRIES		(SS_ITEMS_PER_BLOCK - 1)
+#define SS_NAME_LEN			64
+
+#define SS_STORE_MAGIC			0x17253948
+#define SS_STORE_MAX_LEN		0xc00
+#endif
+
+struct ss_info {
+	struct mtd_info *mtd;
+	u32 first_block;
+	u32 last_block;
+	u32 marker_count;
+	u32 page_size;
+	u32 oob_size;
+	u32 erase_size;
+	u32 pages_per_block;
+	u32 spl_copy_blocks;
+	u32 spl_copy_count;
+	u32 uboot_start_block;
+	u32 uboot_next_block;
+};
+
+#ifdef CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR
+struct ss_object {
+	u32 magic;
+	u32 id;
+	char name[SS_NAME_LEN];
+	u32 re_encrypt;
+	u32 version;
+	u32 write_protect;
+	u32 reserved[3];
+	u32 actual_len;
+	u8 data[SS_STORE_MAX_LEN];
+	u32 crc;
+} __packed;
+
+static u32 ss_get_le32(const void *buf, size_t offset)
+{
+	return get_unaligned_le32((const u8 *)buf + offset);
+}
+#endif
+
+static bool ss_oob_has_magic(const u8 *oob)
+{
+	return get_unaligned_be16(oob + SS_OOB_MAGIC_OFF) == SS_OOB_MAGIC;
+}
+
+static int ss_read_ecc_page(struct ss_info *ss, u32 block, u32 page, void *buf,
+			    u8 *oob)
+{
+	struct mtd_oob_ops ops = {};
+	loff_t offs = (loff_t)block * ss->erase_size +
+		      (loff_t)page * ss->page_size;
+	int ret;
+
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.len = ss->page_size;
+	ops.ooblen = ss->oob_size;
+	ops.datbuf = buf;
+	ops.oobbuf = oob;
+
+	ret = mtd_read_oob(ss->mtd, offs, &ops);
+	if (ret && !mtd_is_bitflip(ret))
+		return ret;
+
+	if (ops.retlen != ss->page_size || ops.oobretlen != ss->oob_size)
+		return -EIO;
+
+	return 0;
+}
+
+#ifdef CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR
+static u32 ss_page_sum(const void *buf, size_t len)
+{
+	const u8 *bytes = buf;
+	u32 sum = SS_EMPTY_SUM;
+	size_t i;
+
+	for (i = 0; i < len / sizeof(u32); i++)
+		sum += get_unaligned_le32(bytes + i * sizeof(u32));
+
+	return sum;
+}
+
+static int ss_read_page(struct ss_info *ss, u32 block, u32 page, void *buf,
+			u8 *oob, u32 len)
+{
+	u32 sum;
+	int ret;
+
+	ret = ss_read_ecc_page(ss, block, page, buf, oob);
+	if (ret)
+		return ret;
+
+	if (!ss_oob_has_magic(oob))
+		return -ENOENT;
+
+	sum = ss_page_sum(buf, len);
+	if (sum != get_unaligned_be32(oob + SS_OOB_CHECKSUM_OFF))
+		return -EBADMSG;
+	if (sum == SS_EMPTY_SUM)
+		return -ENODATA;
+
+	return 0;
+}
+
+static int ss_read_replicated_page(struct ss_info *ss, u32 block, u32 page,
+				   void *buf, u8 *oob, u32 len)
+{
+	int ret = -ENOENT;
+
+	for (; page < ss->pages_per_block; page += SS_ITEMS_PER_BLOCK) {
+		ret = ss_read_page(ss, block, page, buf, oob, len);
+		if (!ret)
+			return 0;
+	}
+
+	return ret;
+}
+#endif
+
+static bool ss_is_secure_block(struct ss_info *ss, u32 block, void *pagebuf,
+			       u8 *oob)
+{
+	if (ss_read_ecc_page(ss, block, 0, pagebuf, oob))
+		return false;
+
+	return ss_oob_has_magic(oob);
+}
+
+static void ss_default_uboot_range(struct ss_info *ss)
+{
+	u32 block_size = ss->erase_size;
+	u32 uboot_blocks;
+
+	if (ss->erase_size <= SS_SMALL_NAND_ALWAYS_BLOCK_SIZE ||
+	    (ss->erase_size <= SS_SMALL_NAND_MAX_BLOCK_SIZE &&
+	     ss->pages_per_block <= 128)) {
+		if (block_size < SS_SMALL_NAND_MIN_BLOCK_SIZE)
+			block_size = SS_SMALL_NAND_MIN_BLOCK_SIZE;
+		block_size = roundup_pow_of_two(block_size);
+
+		ss->uboot_start_block = SS_SMALL_NAND_UBOOT_START;
+		uboot_blocks = SS_SMALL_NAND_UBOOT_SIZE / block_size;
+	} else if (ss->erase_size <= SS_SMALL_NAND_MAX_BLOCK_SIZE) {
+		ss->uboot_start_block = SS_BIG_NAND_UBOOT_START;
+		uboot_blocks = SS_BIG_NAND_1M_UBOOT_BLOCKS;
+	} else if (ss->erase_size <= SS_MEDIUM_NAND_MAX_BLOCK_SIZE) {
+		ss->uboot_start_block = SS_BIG_NAND_UBOOT_START;
+		uboot_blocks = SS_BIG_NAND_2M_UBOOT_BLOCKS;
+	} else {
+		ss->uboot_start_block = SS_BIG_NAND_UBOOT_START;
+		uboot_blocks = SS_BIG_NAND_MIN_UBOOT_BLOCKS;
+	}
+
+	ss->uboot_next_block = ss->uboot_start_block + uboot_blocks;
+}
+
+static void ss_default_spl_layout(struct ss_info *ss)
+{
+	ss->spl_copy_blocks =
+		DIV_ROUND_UP(SS_SPL_PAGE_CNT_PER_COPY, ss->pages_per_block);
+
+	/*
+	 * The SPL-copy writer silently stops once the next SPL copy would
+	 * overlap U-Boot proper. Keep the same floor division here.
+	 */
+	if (ss->spl_copy_blocks)
+		ss->spl_copy_count =
+			ss->uboot_start_block / ss->spl_copy_blocks;
+}
+
+static int ss_scan_blocks(struct ss_info *ss)
+{
+	struct mtd_info *mtd;
+	u64 total_blocks;
+	u32 block, end_block;
+	int ret;
+
+	nand_init();
+
+	mtd = get_nand_dev_by_index(0);
+	if (!mtd)
+		return -ENODEV;
+	if (!mtd->writesize || !mtd->erasesize || !mtd->oobsize)
+		return -EINVAL;
+	if (mtd_mod_by_ws(mtd->erasesize, mtd))
+		return -EINVAL;
+	if (mtd->oobsize < SS_OOB_MAGIC_SIZE)
+		return -EINVAL;
+	if (IS_ENABLED(CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR) &&
+	    mtd->oobsize < SS_OOB_CHECKSUM_SIZE)
+		return -EINVAL;
+	if (!nand_is_slc(mtd_to_nand(mtd)))
+		return -EOPNOTSUPP;
+
+	memset(ss, 0, sizeof(*ss));
+	ss->mtd = mtd;
+	ss->page_size = mtd->writesize;
+	ss->oob_size = mtd->oobsize;
+	ss->erase_size = mtd->erasesize;
+	ss->pages_per_block = mtd_div_by_ws(mtd->erasesize, mtd);
+	ss_default_uboot_range(ss);
+	ss_default_spl_layout(ss);
+
+	ALLOC_CACHE_ALIGN_BUFFER(u8, pagebuf, ss->page_size);
+	ALLOC_CACHE_ALIGN_BUFFER(u8, oob, ss->oob_size);
+
+	total_blocks = mtd_div_by_eb(mtd->size, mtd);
+	end_block = min_t(u64, total_blocks, SS_SCAN_END_BLOCK);
+
+	if (ss->uboot_next_block >= end_block)
+		return -ENOENT;
+
+	for (block = ss->uboot_next_block; block < end_block; block++) {
+		ret = mtd_block_isbad(mtd, (loff_t)block * ss->erase_size);
+		if (ret > 0)
+			continue;
+		if (ret < 0)
+			return ret;
+		if (!ss_is_secure_block(ss, block, pagebuf, oob))
+			continue;
+
+		if (!ss->marker_count)
+			ss->first_block = block;
+		ss->last_block = block;
+		ss->marker_count++;
+	}
+
+	if (!ss->marker_count)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int ss_find_blocks(struct ss_info *ss)
+{
+	static struct ss_info cached_ss;
+	static bool cached;
+	int ret;
+
+	if (cached) {
+		*ss = cached_ss;
+		return 0;
+	}
+
+	ret = ss_scan_blocks(ss);
+	if (ret)
+		return ret;
+
+	cached_ss = *ss;
+	cached = true;
+
+	return 0;
+}
+
+int sunxi_nand_secure_storage_locate(struct sunxi_nand_secure_storage_info *info)
+{
+	struct ss_info ss;
+	int ret;
+
+	if (!info)
+		return -EINVAL;
+
+	ret = ss_find_blocks(&ss);
+	if (ret)
+		return ret;
+
+	memset(info, 0, sizeof(*info));
+	info->mtd_name = ss.mtd->name;
+	info->mtd_size = ss.mtd->size;
+	info->spl_copy_size = (u64)ss.spl_copy_blocks * ss.erase_size;
+	info->spl_copy_count = ss.spl_copy_count;
+	info->uboot_offset = (u64)ss.uboot_start_block * ss.erase_size;
+	info->uboot_size = (u64)(ss.uboot_next_block - ss.uboot_start_block) *
+			   ss.erase_size;
+	info->secure_offset = (u64)ss.first_block * ss.erase_size;
+	info->secure_size = (u64)(ss.last_block - ss.first_block + 1) *
+			    ss.erase_size;
+	info->secure_end = (u64)(ss.last_block + 1) * ss.erase_size;
+
+	return 0;
+}
+
+#ifdef CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR
+static int ss_read_item(struct ss_info *ss, u32 item, void *buf)
+{
+	u32 pages_per_item = SS_ITEM_SIZE / ss->page_size;
+	u32 page_len = pages_per_item == 1 ? SS_ITEM_SIZE : ss->page_size;
+	u32 page;
+	int ret;
+
+	if (ss->page_size > SS_ITEM_SIZE || SS_ITEM_SIZE % ss->page_size)
+		return -EINVAL;
+	if ((item + 1) * pages_per_item > ss->pages_per_block)
+		return -EINVAL;
+
+	ALLOC_CACHE_ALIGN_BUFFER(u8, oob, ss->oob_size);
+
+	for (page = 0; page < pages_per_item; page++) {
+		u8 *dst = (u8 *)buf + page * ss->page_size;
+		u32 raw_page = item * pages_per_item + page;
+
+		ret = ss_read_replicated_page(ss, ss->first_block, raw_page,
+					      dst, oob, page_len);
+		if (ret && ss->last_block != ss->first_block)
+			ret = ss_read_replicated_page(ss, ss->last_block,
+						      raw_page, dst, oob,
+						      page_len);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static bool ss_object_name_matches(const struct ss_object *object,
+				   const char *key)
+{
+	size_t key_len = strlen(key);
+	size_t name_len = strnlen(object->name, SS_NAME_LEN);
+
+	return name_len == key_len && !memcmp(object->name, key, key_len);
+}
+
+static int ss_find_item(const char *map, const char *key, u32 *item)
+{
+	size_t key_len = strlen(key);
+	u32 pos = 0;
+	u32 nr = 1;
+
+	if (key_len >= SS_NAME_LEN)
+		return -ENAMETOOLONG;
+
+	while (pos < SS_ITEM_SIZE && map[pos]) {
+		const char *entry = map + pos;
+		const char *colon;
+		size_t entry_len = strnlen(entry, SS_ITEM_SIZE - pos);
+
+		if (entry_len == SS_ITEM_SIZE - pos)
+			return -EINVAL;
+		if (nr > SS_MAP_MAX_ENTRIES)
+			return -ENOSPC;
+
+		colon = memchr(entry, ':', entry_len);
+		if (!colon || colon == entry || colon + 1 == entry + entry_len)
+			return -EINVAL;
+
+		if (colon - entry == key_len && !memcmp(entry, key, key_len)) {
+			*item = nr;
+			return 0;
+		}
+
+		pos += entry_len + 1;
+		nr++;
+	}
+
+	return -ENOENT;
+}
+
+static int ss_get_payload(const void *item, const char *key, const u8 **payload,
+			  u32 *len)
+{
+	const struct ss_object *object = item;
+	u32 actual_len, stored_crc, crc;
+
+	if (ss_get_le32(item, offsetof(struct ss_object, magic)) !=
+	    SS_STORE_MAGIC)
+		return -EINVAL;
+
+	stored_crc = ss_get_le32(item, offsetof(struct ss_object, crc));
+	crc = crc32(0, item, offsetof(struct ss_object, crc));
+	if (crc != stored_crc)
+		return -EBADMSG;
+	if (!ss_object_name_matches(object, key))
+		return -ENOENT;
+
+	actual_len = ss_get_le32(item, offsetof(struct ss_object, actual_len));
+	if (actual_len > SS_STORE_MAX_LEN)
+		return -EINVAL;
+
+	*payload = ((const struct ss_object *)item)->data;
+	*len = actual_len;
+
+	return 0;
+}
+
+static bool ss_parse_mac(const u8 *buf, u32 len, u8 *mac)
+{
+	char text[ARP_HLEN_ASCII + 1];
+	size_t text_len;
+
+	text_len = strnlen((const char *)buf, len);
+	if (!text_len || text_len > ARP_HLEN_ASCII)
+		return false;
+
+	memcpy(text, buf, text_len);
+	text[text_len] = '\0';
+	string_to_enetaddr(text, mac);
+
+	return is_valid_ethaddr(mac);
+}
+
+static int ss_read_mac(const char *key, u8 *mac)
+{
+	struct ss_info ss;
+	const u8 *payload;
+	u32 item, len;
+	int ret;
+
+	ret = ss_find_blocks(&ss);
+	if (ret)
+		return ret;
+
+	ALLOC_CACHE_ALIGN_BUFFER(u8, itembuf, SS_ITEM_SIZE);
+
+	ret = ss_read_item(&ss, 0, itembuf);
+	if (ret)
+		return ret;
+
+	ret = ss_find_item((const char *)itembuf, key, &item);
+	if (ret)
+		return ret;
+
+	ret = ss_read_item(&ss, item, itembuf);
+	if (ret)
+		return ret;
+
+	ret = ss_get_payload(itembuf, key, &payload, &len);
+	if (ret)
+		return ret;
+
+	return ss_parse_mac(payload, len, mac) ? 0 : -EINVAL;
+}
+
+void sunxi_nand_secure_storage_setup_ethaddr(void)
+{
+	const char *key = CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR_KEY;
+	static bool attempted;
+	u8 mac[ARP_HLEN];
+	int ret;
+
+	if (attempted || !key[0] || eth_env_get_enetaddr("ethaddr", mac))
+		return;
+
+	attempted = true;
+
+	ret = ss_read_mac(key, mac);
+	if (ret) {
+		printf("Secure storage: failed to read key '%s' (%d)\n",
+		       key, ret);
+		return;
+	}
+
+	eth_env_set_enetaddr("ethaddr", mac);
+	printf("Secure storage mac: %pM\n", mac);
+}
+#endif
diff --git a/board/sunxi/nand_secure_storage.h b/board/sunxi/nand_secure_storage.h
new file mode 100644
index 00000000000..45b20659c0b
--- /dev/null
+++ b/board/sunxi/nand_secure_storage.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Allwinner NAND secure storage helpers.
+ */
+
+#ifndef SUNXI_NAND_SECURE_STORAGE_H
+#define SUNXI_NAND_SECURE_STORAGE_H
+
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/types.h>
+
+struct sunxi_nand_secure_storage_info {
+	const char *mtd_name;
+	u64 mtd_size;
+	u64 spl_copy_size;
+	u32 spl_copy_count;
+	u64 uboot_offset;
+	u64 uboot_size;
+	u64 secure_offset;
+	u64 secure_size;
+	u64 secure_end;
+};
+
+#if IS_ENABLED(CONFIG_SUNXI_NAND_SECURE_STORAGE) && !defined(CONFIG_XPL_BUILD)
+int sunxi_nand_secure_storage_locate(struct sunxi_nand_secure_storage_info *info);
+#else
+static inline int
+sunxi_nand_secure_storage_locate(struct sunxi_nand_secure_storage_info *info)
+{
+	return -ENODEV;
+}
+#endif
+
+#if IS_ENABLED(CONFIG_SUNXI_NAND_SECURE_STORAGE_ETHADDR) && \
+	!defined(CONFIG_XPL_BUILD)
+void sunxi_nand_secure_storage_setup_ethaddr(void);
+#else
+static inline void sunxi_nand_secure_storage_setup_ethaddr(void) {}
+#endif
+
+#endif
-- 
2.53.0

