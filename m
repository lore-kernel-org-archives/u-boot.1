Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4714FEB1056
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF4D9840A9;
	Tue, 10 Mar 2026 15:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Ul4gRK+1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D64F18409A; Tue, 10 Mar 2026 15:13:41 +0100 (CET)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 143D683FE9
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [213.36.7.12])
 (Authenticated sender: vjardin@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id DE10060136;
 Tue, 10 Mar 2026 15:13:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1773152018;
 bh=3EAWHP+4QokW0RzAnBSjstiwQEXB/89w6/6Knjv1Qiw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ul4gRK+1fXe29FlEUFbGfqhxC7dxlfPNFlan1UmB2ku7QvdUrjOfLoTBtAyA1L3k+
 kemJByk6ptIAyMaVRhFwoM3iB6Q/SuUIQ29pRH4YYcRV24BRGu+cLl+3KhDhBfBK7I
 NXHAiqjmFXuNP+ooqVHkLmR5ctmBQggJjf2MXW/3QWQLd9XVWGw9pxdfEpKvxyWujK
 ik4s0TklKfxjoFs2KuvLT21wTRHhporHsvC3YZue+4+jLvCzFcXlQPtiEGA0wRKnTx
 WsFhl7lKJk7UzHVKDiwb1wolr27ZwpgdKtDTXn8Nze9/OPVvMXgRKQlMQeuVB+r1Xz
 hba4xrTiKDAtA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 vjardin@free.fr
Subject: [PATCH v1 4/5] cmd: mvebu: add emmcboot for Nodebox image format
Date: Tue, 10 Mar 2026 15:12:51 +0100
Message-ID: <5e77a02d26f8abf694eeb70dc5904c00dfca7df8.1773151972.git.vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773151972.git.vjardin@free.fr>
References: <cover.1773151972.git.vjardin@free.fr>
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

The Nodebox 10G stores firmware in a board-specific format
(mvebu_image_tag) at fixed offsets in eMMC. Each image bundles a
kernel and device tree under a CRC32-validated tag header.

Include a board-specific rollback support based on a reboot counter
in order to track consecutive boot failures and then to boot from
the fallback image.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
 cmd/mvebu/Kconfig                   |  53 +++++
 cmd/mvebu/Makefile                  |   1 +
 cmd/mvebu/mvebu_emmcboot.c          | 340 ++++++++++++++++++++++++++++
 configs/mvebu_nbx_88f8040_defconfig |   1 +
 include/mvebu_imagetag.h            |  82 +++++++
 include/mvebu_nrboot.h              |  51 +++++
 6 files changed, 528 insertions(+)
 create mode 100644 cmd/mvebu/mvebu_emmcboot.c
 create mode 100644 include/mvebu_imagetag.h
 create mode 100644 include/mvebu_nrboot.h

diff --git a/cmd/mvebu/Kconfig b/cmd/mvebu/Kconfig
index e83a9829491..ea03f581280 100644
--- a/cmd/mvebu/Kconfig
+++ b/cmd/mvebu/Kconfig
@@ -79,4 +79,57 @@ config CMD_MVEBU_COMPHY_RX_TRAINING
 	help
 	  Perform COMPHY RX training sequence
 
+config CMD_NBX_EMMCBOOT
+	bool "Nodebox emmcboot command"
+	depends on ARMADA_8K && MMC_SDHCI_XENON
+	help
+	  Enable the emmcboot command for Nodebox 10G boards. The command
+	  loads and boots firmware stored in the board-specific image format
+	  (mvebu_image_tag) at fixed eMMC offsets. Each image bundles a
+	  kernel and device tree under a CRC32-validated tag header.
+
+	  Two image banks are supported (Bank0 stable, Bank1 newer) with
+	  automatic fallback based on a reboot tracking counter (nrboot).
+
+	  Requires image_addr and fdt_addr environment variables to be set.
+
+if CMD_NBX_EMMCBOOT
+
+config MVEBU_MMC_PART_NRBOOT_OFFSET
+	hex "NRBoot counter offset in eMMC"
+	default 0x802000
+	help
+	  Byte offset in eMMC where the reboot tracking counter is stored.
+	  Default: 0x802000 (8MB + 8KB)
+
+config MVEBU_MMC_PART_BANK0_OFFSET
+	hex "Bank0 image offset in eMMC"
+	default 0x804000
+	help
+	  Byte offset in eMMC where the stable (Bank0) boot image starts.
+	  Default: 0x804000 (8MB + 16KB)
+
+config MVEBU_MMC_PART_BANK0_SIZE
+	hex "Bank0 image maximum size"
+	default 0x10000000
+	help
+	  Maximum size of the Bank0 boot image.
+	  Default: 0x10000000 (256MB)
+
+config MVEBU_MMC_PART_BANK1_OFFSET
+	hex "Bank1 image offset in eMMC"
+	default 0x10804000
+	help
+	  Byte offset in eMMC where the newer (Bank1) boot image starts.
+	  Default: 0x10804000 (264MB + 16KB)
+
+config MVEBU_MMC_PART_BANK1_SIZE
+	hex "Bank1 image maximum size"
+	default 0x10000000
+	help
+	  Maximum size of the Bank1 boot image.
+	  Default: 0x10000000 (256MB)
+
+endif
+
 endmenu
diff --git a/cmd/mvebu/Makefile b/cmd/mvebu/Makefile
index ca96ad01d91..c096f507e26 100644
--- a/cmd/mvebu/Makefile
+++ b/cmd/mvebu/Makefile
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_CMD_MVEBU_BUBT) += bubt.o
 obj-$(CONFIG_CMD_MVEBU_COMPHY_RX_TRAINING) += comphy_rx_training.o
+obj-$(CONFIG_CMD_NBX_EMMCBOOT) += mvebu_emmcboot.o
diff --git a/cmd/mvebu/mvebu_emmcboot.c b/cmd/mvebu/mvebu_emmcboot.c
new file mode 100644
index 00000000000..3d85f82670a
--- /dev/null
+++ b/cmd/mvebu/mvebu_emmcboot.c
@@ -0,0 +1,340 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * MVEBU eMMC boot command for Nodebox 10G boot image format
+ *
+ * Copyright (C) 2026 Free Mobile, Freebox
+ *
+ * The Nodebox 10G stores firmware images in a board-specific format
+ * (mvebu_image_tag) at fixed offsets in eMMC. Each image bundles a
+ * kernel, device tree, and optional rootfs under a CRC32-validated
+ * tag header.
+ *
+ * Two image banks are laid out in eMMC (Bank0 stable, Bank1 newer).
+ * A reboot counter (nrboot) selects which bank to try first.
+ */
+
+#include <command.h>
+#include <env.h>
+#include <mmc.h>
+#include <malloc.h>
+#include <memalign.h>
+#include <vsprintf.h>
+#include <u-boot/crc.h>
+#include <u-boot/schedule.h>
+#include <asm/byteorder.h>
+#include <linux/bitops.h>
+#include <mvebu_imagetag.h>
+#include <mvebu_nrboot.h>
+
+/* Image Tag Functions */
+
+static int mvebu_imagetag_check(struct mvebu_image_tag *tag,
+				unsigned long maxsize, const char *name)
+{
+	if (be32_to_cpu(tag->magic) != MVEBU_IMAGE_TAG_MAGIC) {
+		if (name)
+			printf("%s: invalid TAG magic: %.8x\n", name,
+			       be32_to_cpu(tag->magic));
+		return -1;
+	}
+
+	if (be32_to_cpu(tag->version) != MVEBU_IMAGE_TAG_VERSION) {
+		if (name)
+			printf("%s: invalid TAG version: %.8x\n", name,
+			       be32_to_cpu(tag->version));
+		return -1;
+	}
+
+	if (be32_to_cpu(tag->total_size) < sizeof(*tag)) {
+		if (name)
+			printf("%s: tag size is too small!\n", name);
+		return -1;
+	}
+
+	if (be32_to_cpu(tag->total_size) > maxsize) {
+		if (name)
+			printf("%s: tag size is too big!\n", name);
+		return -1;
+	}
+
+	if (be32_to_cpu(tag->device_tree_offset) < sizeof(*tag) ||
+	    be32_to_cpu(tag->device_tree_offset) +
+	    be32_to_cpu(tag->device_tree_size) > maxsize) {
+		if (name)
+			printf("%s: bogus device tree offset/size!\n", name);
+		return -1;
+	}
+
+	if (be32_to_cpu(tag->kernel_offset) < sizeof(*tag) ||
+	    be32_to_cpu(tag->kernel_offset) +
+	    be32_to_cpu(tag->kernel_size) > maxsize) {
+		if (name)
+			printf("%s: bogus kernel offset/size!\n", name);
+		return -1;
+	}
+
+	if (be32_to_cpu(tag->rootfs_offset) < sizeof(*tag) ||
+	    be32_to_cpu(tag->rootfs_offset) +
+	    be32_to_cpu(tag->rootfs_size) > maxsize) {
+		if (name)
+			printf("%s: bogus rootfs offset/size!\n", name);
+		return -1;
+	}
+
+	if (name) {
+		/*
+		 * Ensure null-termination within the 32-byte fields
+		 * before printing to avoid displaying garbage.
+		 */
+		tag->image_name[sizeof(tag->image_name) - 1] = '\0';
+		tag->build_date[sizeof(tag->build_date) - 1] = '\0';
+		tag->build_user[sizeof(tag->build_user) - 1] = '\0';
+
+		printf("%s: Found valid tag: %s / %s / %s\n", name,
+		       tag->image_name, tag->build_date, tag->build_user);
+	}
+
+	return 0;
+}
+
+static int mvebu_imagetag_crc(struct mvebu_image_tag *tag, const char *name)
+{
+	u32 crc = ~0;
+
+	crc = crc32(crc, ((unsigned char *)tag) + 4,
+		    be32_to_cpu(tag->total_size) - 4);
+
+	if (be32_to_cpu(tag->crc) != crc) {
+		if (name)
+			printf("%s: invalid tag CRC!\n", name);
+		return -1;
+	}
+
+	return 0;
+}
+
+/* NRBoot (Reboot Tracking) Functions */
+
+int mvebu_check_nrboot(struct mmc *mmc, unsigned long offset)
+{
+	struct blk_desc *bd = mmc_get_blk_desc(mmc);
+	struct mvebu_nrboot *nr;
+	uint blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
+	uint blk_cnt = ALIGN(sizeof(*nr), bd->blksz) / bd->blksz;
+	uint n;
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, buf, blk_cnt * bd->blksz);
+	nr = (void *)buf;
+
+	n = blk_dread(bd, blk_start, blk_cnt, buf);
+	if (n != blk_cnt)
+		return 0;
+
+	printf(" - nr.nrboot = %04x\n", nr->nrboot);
+	printf(" - nr.nrsuccess = %04x\n", nr->nrsuccess);
+
+	/* Sanity check: values must be valid bit-field counters */
+	if (generic_hweight16(~nr->nrboot + 1) <= 1 &&
+	    generic_hweight16(~nr->nrsuccess + 1) <= 1) {
+		int boot, success;
+
+		boot = 16 - generic_hweight16(nr->nrboot);
+		success = 16 - generic_hweight16(nr->nrsuccess);
+
+		printf(" - Nrboot: %d / Nrsuccess: %d\n", boot, success);
+
+		if (boot == 16 || boot < success ||
+		    boot - success >= MVEBU_MAX_FAILURE) {
+			printf(" - Nrboot exceeded\n");
+			return 0;
+		}
+
+		/* Increment boot attempt counter */
+		boot++;
+		nr->nrboot = ~((1 << boot) - 1);
+
+		printf(" - Setting Nrboot to %d\n", boot);
+
+		n = blk_dwrite(bd, blk_start, blk_cnt, buf);
+		if (n != blk_cnt)
+			return 0;
+
+		return 1;
+	}
+
+	printf(" - Invalid NR values\n");
+
+	return 0;
+}
+
+/* emmcboot Command */
+
+static int mvebu_load_image(struct blk_desc *bd, unsigned long offset,
+			    unsigned long maxsize, ulong tag_addr,
+			    const char *bank)
+{
+	struct mvebu_image_tag *tag;
+	uint blk_start = ALIGN(offset, bd->blksz) / bd->blksz;
+	uint blk_cnt;
+	uint n;
+
+	ALLOC_CACHE_ALIGN_BUFFER(char, tag_buf,
+				 ALIGN(sizeof(*tag), bd->blksz));
+	tag = (void *)tag_buf;
+
+	/* Load and validate tag header */
+	blk_cnt = ALIGN(sizeof(*tag), bd->blksz) / bd->blksz;
+	n = blk_dread(bd, blk_start, blk_cnt, tag_buf);
+	if (n != blk_cnt) {
+		printf("%s: failed to read tag header\n", bank);
+		return -1;
+	}
+
+	if (mvebu_imagetag_check(tag, maxsize, bank) != 0)
+		return -1;
+
+	if (tag->rootfs_size != 0) {
+		printf("%s: rootfs in tag not supported\n", bank);
+		return -1;
+	}
+
+	/* Load full image to tag_addr */
+	blk_cnt = ALIGN(mvebu_imagetag_total_size(tag), bd->blksz) / bd->blksz;
+	n = blk_dread(bd, blk_start, blk_cnt, (void *)tag_addr);
+	if (n != blk_cnt) {
+		printf("%s: failed to read full image\n", bank);
+		return -1;
+	}
+
+	if (mvebu_imagetag_crc((void *)tag_addr, bank) != 0)
+		return -1;
+
+	return 0;
+}
+
+static void mvebu_relocate_and_boot(ulong image_addr, ulong fdt_addr,
+				    const char *bank)
+{
+	struct mvebu_image_tag *tag = (void *)image_addr;
+	char bootargs[256];
+	char cmd[128];
+	char *console_env;
+
+	/* Copy DTB and kernel to their final addresses */
+	memcpy((void *)fdt_addr,
+	       ((void *)image_addr) + mvebu_imagetag_device_tree_offset(tag),
+	       mvebu_imagetag_device_tree_size(tag));
+	memmove((void *)image_addr,
+		((void *)image_addr) + mvebu_imagetag_kernel_offset(tag),
+		mvebu_imagetag_kernel_size(tag));
+
+	schedule();
+
+	/* Set bootargs */
+	console_env = env_get("console");
+	if (console_env)
+		snprintf(bootargs, sizeof(bootargs),
+			 "console=%s bank=%s", console_env, bank);
+	else
+		snprintf(bootargs, sizeof(bootargs), "bank=%s", bank);
+
+	env_set("bootargs", bootargs);
+
+	printf("## Booting kernel from %s...\n", bank);
+	printf("   Image addr: 0x%lx\n", image_addr);
+	printf("   FDT addr:   0x%lx\n", fdt_addr);
+
+	snprintf(cmd, sizeof(cmd), "booti 0x%lx - 0x%lx",
+		 image_addr, fdt_addr);
+	run_command(cmd, 0);
+}
+
+static void mvebu_try_emmcboot(struct mmc *mmc, unsigned long offset,
+			       unsigned long maxsize, const char *bank)
+{
+	struct blk_desc *bd = mmc_get_blk_desc(mmc);
+	ulong image_addr;
+	ulong fdt_addr;
+
+	schedule();
+
+	printf("## Trying %s boot...\n", bank);
+
+	/* Get load addresses from environment */
+	image_addr = env_get_ulong("image_addr", 16, 0);
+	if (!image_addr) {
+		puts("emmcboot needs image_addr\n");
+		return;
+	}
+
+	fdt_addr = env_get_ulong("fdt_addr", 16, 0);
+	if (!fdt_addr) {
+		puts("emmcboot needs fdt_addr\n");
+		return;
+	}
+
+	if (mvebu_load_image(bd, offset, maxsize, image_addr, bank) != 0)
+		return;
+
+	schedule();
+
+	mvebu_relocate_and_boot(image_addr, fdt_addr, bank);
+
+	printf("## %s boot failed\n", bank);
+}
+
+static int do_emmcboot(struct cmd_tbl *cmdtp, int flag, int argc,
+		       char *const argv[])
+{
+	int dev;
+	struct mmc *mmc;
+
+	dev = 0;
+	if (argc >= 2)
+		dev = dectoul(argv[1], NULL);
+
+	mmc = find_mmc_device(dev);
+	if (!mmc) {
+		printf("No MMC device %d found\n", dev);
+		return CMD_RET_FAILURE;
+	}
+
+	if (mmc_init(mmc)) {
+		puts("MMC init failed\n");
+		return CMD_RET_FAILURE;
+	}
+
+	/* Switch to partition 0 (user data area) */
+	if (blk_select_hwpart_devnum(UCLASS_MMC, dev, 0)) {
+		puts("MMC partition switch failed\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (mvebu_check_nrboot(mmc, CONFIG_MVEBU_MMC_PART_NRBOOT_OFFSET)) {
+		/* System is healthy: try newer bank first */
+		mvebu_try_emmcboot(mmc, CONFIG_MVEBU_MMC_PART_BANK1_OFFSET,
+				   CONFIG_MVEBU_MMC_PART_BANK1_SIZE, "bank1");
+		mvebu_try_emmcboot(mmc, CONFIG_MVEBU_MMC_PART_BANK0_OFFSET,
+				   CONFIG_MVEBU_MMC_PART_BANK0_SIZE, "bank0");
+	} else {
+		/* System is degraded: use stable bank first */
+		mvebu_try_emmcboot(mmc, CONFIG_MVEBU_MMC_PART_BANK0_OFFSET,
+				   CONFIG_MVEBU_MMC_PART_BANK0_SIZE, "bank0");
+		mvebu_try_emmcboot(mmc, CONFIG_MVEBU_MMC_PART_BANK1_OFFSET,
+				   CONFIG_MVEBU_MMC_PART_BANK1_SIZE, "bank1");
+	}
+
+	puts("emmcboot: all boot attempts failed\n");
+
+	return CMD_RET_FAILURE;
+}
+
+U_BOOT_CMD(
+	emmcboot, 2, 0, do_emmcboot,
+	"boot from Nodebox eMMC image banks",
+	"[dev]\n"
+	"    - Load and boot a Nodebox image from eMMC device <dev> (default 0)\n"
+	"    - Requires image_addr and fdt_addr environment variables\n"
+	"    - Two banks: Bank0 (stable) and Bank1 (newer)\n"
+	"    - Bank order selected by reboot tracking counter (nrboot)"
+);
diff --git a/configs/mvebu_nbx_88f8040_defconfig b/configs/mvebu_nbx_88f8040_defconfig
index 975c53e9a92..2fd58e4ad64 100644
--- a/configs/mvebu_nbx_88f8040_defconfig
+++ b/configs/mvebu_nbx_88f8040_defconfig
@@ -40,6 +40,7 @@ CONFIG_CMD_PING=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_TIMER=y
+CONFIG_CMD_NBX_EMMCBOOT=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
diff --git a/include/mvebu_imagetag.h b/include/mvebu_imagetag.h
new file mode 100644
index 00000000000..d513038aaf6
--- /dev/null
+++ b/include/mvebu_imagetag.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Nodebox 10G boot image tag format
+ *
+ * Copyright (C) 2026 Free Mobile, Freebox
+ *
+ * Defines the on-eMMC image layout used by Nodebox 10G boards.
+ * Each image carries a CRC32-validated tag header that describes
+ * the kernel, device tree, and rootfs components.
+ */
+
+#ifndef __MVEBU_IMAGETAG_H
+#define __MVEBU_IMAGETAG_H
+
+#include <linux/types.h>
+
+#define MVEBU_IMAGE_TAG_MAGIC	0x8d7c90bc
+#define MVEBU_IMAGE_TAG_VERSION	1
+
+/**
+ * struct mvebu_image_tag - Nodebox boot image tag stored in eMMC
+ *
+ * All multi-byte fields are stored in big-endian format.
+ */
+struct mvebu_image_tag {
+	u32 crc;			/* CRC32-LE checksum (from offset 4) */
+	u32 magic;			/* Magic: 0x8d7c90bc */
+	u32 version;			/* Version: 1 */
+	u32 total_size;			/* Total image size including tag */
+	u32 flags;			/* Feature flags (reserved) */
+
+	u32 device_tree_offset;		/* Offset from tag start to DTB */
+	u32 device_tree_size;		/* DTB size in bytes */
+
+	u32 kernel_offset;		/* Offset from tag start to kernel */
+	u32 kernel_size;		/* Kernel size in bytes */
+
+	u32 rootfs_offset;		/* Offset from tag start to rootfs */
+	u32 rootfs_size;		/* Rootfs size (must be 0) */
+
+	char image_name[32];		/* Image name (null-terminated) */
+	char build_user[32];		/* Build user info */
+	char build_date[32];		/* Build date info */
+};
+
+/* Accessor functions for big-endian fields */
+static inline u32 mvebu_imagetag_device_tree_offset(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->device_tree_offset);
+}
+
+static inline u32 mvebu_imagetag_device_tree_size(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->device_tree_size);
+}
+
+static inline u32 mvebu_imagetag_kernel_offset(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->kernel_offset);
+}
+
+static inline u32 mvebu_imagetag_kernel_size(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->kernel_size);
+}
+
+static inline u32 mvebu_imagetag_rootfs_offset(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->rootfs_offset);
+}
+
+static inline u32 mvebu_imagetag_rootfs_size(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->rootfs_size);
+}
+
+static inline u32 mvebu_imagetag_total_size(struct mvebu_image_tag *tag)
+{
+	return be32_to_cpu(tag->total_size);
+}
+
+#endif /* __MVEBU_IMAGETAG_H */
diff --git a/include/mvebu_nrboot.h b/include/mvebu_nrboot.h
new file mode 100644
index 00000000000..11d59d7680f
--- /dev/null
+++ b/include/mvebu_nrboot.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Nodebox 10G reboot tracking counter (NRBoot)
+ *
+ * Copyright (C) 2026 Free Mobile, Freebox
+ *
+ * Part of the Nodebox eMMC image format: a small bit-field counter
+ * stored between the serial info and the image banks that tracks
+ * consecutive boot failures to select the right bank.
+ */
+
+#ifndef __MVEBU_NRBOOT_H
+#define __MVEBU_NRBOOT_H
+
+#include <linux/types.h>
+#include <mmc.h>
+
+#define MVEBU_MAX_FAILURE	4
+
+/**
+ * struct mvebu_nrboot - Reboot tracking counter stored in eMMC
+ * @nrboot: Bit-field counter of boot attempts (0-bits = attempt count)
+ * @nrsuccess: Bit-field counter of successful boots
+ */
+struct mvebu_nrboot {
+	u16 nrboot;
+	u16 nrsuccess;
+};
+
+/**
+ * mvebu_check_nrboot() - Check and update reboot tracking counter
+ * @mmc: MMC device
+ * @offset: Byte offset in MMC where nrboot data is stored
+ *
+ * Reads the reboot tracking counter, checks if the maximum number of
+ * failed boots (4) has been exceeded, and updates the counter for the
+ * current boot attempt.
+ *
+ * The counter uses a bit-field encoding for wear leveling:
+ * - nrboot: Running count of boot attempts (counted as cleared bits)
+ * - nrsuccess: Count of successful boots (counted as cleared bits)
+ *
+ * If boot - success >= MAX_FAILURE (4), the system is considered
+ * degraded and should use the fallback boot bank.
+ *
+ * Return: 1 if system is healthy (try newer bank first),
+ *         0 if system is degraded (use stable bank first)
+ */
+int mvebu_check_nrboot(struct mmc *mmc, unsigned long offset);
+
+#endif /* __MVEBU_NRBOOT_H */
-- 
2.43.0

