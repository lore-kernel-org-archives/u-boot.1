Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21A9C982D6
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 17:20:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 888B681140;
	Thu, 17 Sep 2026 17:20:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0oBoOgNcEzM; Thu, 17 Sep 2026 17:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7BA6C81136
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789665617;
	b=bghMgLNJcQs0ELO/CxruKnfoqFuhoxhe7RobWsN5nw/4OgZuv4N0M6nVSyM/XkgIck1j
	 0dqq08VTLnJq6pYWWSC6ZKq2rmKzEKvfCxnbZkCPH5fgYBNIPj25nKyY6je1lSfwvpqZg
	 i+Njjua76OWchC8mXqeYn3S+GzaZXJXfv53SUDfI6x9toO/8y90V/NWBfyAIYhVWgpiG0
	 hVFgUczf7cFckWofkZ5bBExcT7kyICcmbsq5QmItKs2PhO1M3cYugkLS28SO5Zeb2/HBR
	 8eAw1PRu+7YFYHx7T04qPn08olHIQx9XH4/DG+QmtHHKFClf+fvsILyRMUC1jTbDcDg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789665617;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=f6xq3Rf6LWiX8vmYKcGs0ejNuFrvtiWY9u/cO3Dd/Mo=;
	b=PaUwopYpwRJqLVRMAAr1uYdw7yP9qQkJ0uleP2fvuVqpZNUmtoLA2g2n2jpQnQjyJCwP
	 2nfZJtxxudS60oa2oQ0i1MBwkFWhgivITr/Mzq3dRz4FHPbZ5cppsjQDC/MvdUkoirQfd
	 LsIwuXtXl8D6E+Hp31AjRV+BxXwjponmt3jLEEBqWOOkQrbp49vhWoWHpCZTt/O79hrvf
	 erL7E+E8ycf9214Qky6cSeNMH/CcbazQYiEuAIrR4R8YlsaCCYS9M89vis1/Y69t9tgM7
	 xd/83ymskiPY5zU+/8tA4tplrZdp3iBQrC6VIuk8LltQY/reQr8AYJX0rn9PYM9khhQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789665617;
	bh=f6xq3Rf6LWiX8vmYKcGs0ejNuFrvtiWY9u/cO3Dd/Mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gCKUTxDOkGhPEZjwN2EXf5TjZsFtcvV3GKXi8Bl+nGSoBeGsoKubPSEmWJR/sTFCL
	 nBrquYwbwAweGzt1de13i7b79bg6lsidETnofF6aEJh2EX+3yjYDSscgZuPHU0gr7x
	 QbfpKNAkRnIFIxPmYouSUuAiHeVjvyC4SnxxyjQz5kgxc7U6lt1e7t+sp987yXWwlU
	 xksONZmFKSitLuX7Tkb8lF6x6gj3vab+OcufZQOvDE017Pgg6wOMCpwUZ7kLGMB1A4
	 m7kA3m6RlxQIpikeRjO4PedKAr4Z/AE3kW3faknCQ85/eTovswxentM3Ysxi/j9Yvw
	 OGygX4AsKUl+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7BA6C81136;
	Thu, 17 Sep 2026 17:20:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A1A2413D
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93B6D40378
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H5ga0TIhTLIk for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 17:19:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 93B0C40427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789665554;
 b=bIuOeLxtXiu3edheV68eWFopWrJd/scdEPO2BsVZ9QRu/Y8xasAFzDmXQaPgsHzxD+58
 dUkEKCd46oAzAuY6nfriLYip0e1Xb71pcwDpGtan8Du3Ba29uhoSBrk3koIWSsG+2Jo2t
 QXlk1n6lP0H1GDLBFWR8AUr11F/4nMB0May7S2dnj64vfQeRSQIynFW/4vvNknypRmK4P
 kIZQogMyj7ayYrolCnDjqCVPY/0he23stFl35CK7aa1E6Jg3+pZPyejT4Bw4jJvra0h6a
 9Pa4bbOVfDEuM6ebkwKOoUmdydvFmuXeCDCggw96CC2ksBA346vqtwoIpijvZWhRjDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789665554;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=f6xq3Rf6LWiX8vmYKcGs0ejNuFrvtiWY9u/cO3Dd/Mo=;
 b=Tn6/DzkDsy71QlLyqvA4gnCVnik/DDdHrkx/aUldWnI/jrRPe0XzKPQ/IaoiJdqmGIOZ
 +Ym9gGKjGBms1+llZ75LsGHU5mXipzpuokDV92ImPKGo3ZoWLa2Hvj0vd0JoFbdlCvgCC
 mUiz9gUDq/OeAzWCI2Sn2dMK8Su0wgxILbT8egSy9Tae9k786AeNigA3JVUElNPrs4cs0
 fBEXntQCdH74+NR/+BBObCUSjdZw0HYBvuyCCJvPSttbjtp4z5zAT2G5q5PBkSFdWDqwd
 IsuQYgXkn0jxcw2eT1oS+2m5bucE8E7QmfuLO/UO0rpOWQfY/PGLpuxE06hVdoAxVfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=oR5Fd5Jb; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=oR5Fd5Jb
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 93B0C40427
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 17:19:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35B3D1596;
 Thu, 17 Sep 2026 10:19:10 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDE423F7B4;
 Thu, 17 Sep 2026 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789665553; bh=P6zUb/B4SMH5E2jHjhPHlV0tEKsi8AaRLu1Qdj85C5U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oR5Fd5JbjKhiynIJ5kKKgo4iIGYZtV/+mhjn/VT2Kb/lrV9/nXtX1hXLnj0bupmjH
 NVdOvolcqXNjzAju+XEhJVSA1tZKBdA6LBJbUTEZq843darFTPMxFQU9eP8a82Z3HE
 yoduLNAgtXZl2DU13vr3BS4MIiHKl4GhvDPqn5As=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alex Chapman <alex.chapman@arm.com>, Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v6 21/24] fwu_arm_psa: corstone1000: Read active index for
 kernel setup
Date: Thu, 17 Sep 2026 18:18:07 +0100
Message-ID: <20260917171810.4122899-22-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
References: <20260917171810.4122899-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 17 Sep 2026 17:19:43 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Read the active bank index directly from FWU metadata when setting the
kernel address and size during board_late_init().

Arm PSA FWU does not enable the multi-bank FWU implementation, so its
cached metadata and fwu_plat_get_bootidx() hook are unavailable. Read
and validate the metadata header and CRC through the FWU metadata uclass,
falling back from the primary copy to the secondary, then use the active
index to select the kernel partition.

This keeps Corstone-1000 kernel selection working with the Arm PSA FWU
configuration.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Alex Chapman <alex.chapman@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.c | 209 +++++++++++++++++++----
 include/fwu_arm_psa.h                    |  12 ++
 lib/efi_loader/Kconfig                   |   2 +
 3 files changed, 189 insertions(+), 34 deletions(-)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index b255a0d78ad..084c9bfff63 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -11,14 +11,16 @@
 #include <generated/dt.h>
 #include <env.h>
 #include <efi_loader.h>
-#include <fwu.h>
 #include <fwu_arm_psa.h>
+#include <fwu_mdata.h>
+#include <u-boot/crc.h>
 #include <netdev.h>
 #include <nvmxip.h>
 #include <part.h>
 #include <dm/platform_data/serial_pl01x.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
+#include <stdlib.h>
 
 #define CORSTONE1000_KERNEL_PARTS 2
 #define CORSTONE1000_KERNEL_PRIMARY "kernel_primary"
@@ -29,6 +31,9 @@
 /* The total number of upgradable images including the start and end dummy payloads */
 #define CAPSULE_PAYLOADS_MAX_COUNT (CONFIG_FWU_NUM_IMAGES_PER_BANK + 2)
 
+#define FWU_MDATA_VERSION	0x2U
+#define FWU_MDATA_MAX_SIZE	720
+
 /*
  * GUIDs for capsule updatable firmware images
  *
@@ -151,8 +156,6 @@ struct efi_capsule_update_info update_info = {
 
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-static int corstone1000_boot_idx;
-
 static struct mm_region corstone1000_mem_map[] = {
 	{
 		/* CVM */
@@ -232,46 +235,38 @@ int dram_init_banksize(void)
 	return 0;
 }
 
-void fwu_plat_get_bootidx(uint *boot_idx)
-{
-	int ret;
-
-	/*
-	 * in our platform, the Secure Enclave is the one who controls
-	 * all the boot tries and status, so, every time we get here
-	 * we know that the we are booting from the active index
-	 */
-	ret = fwu_get_active_index(boot_idx);
-	if (ret < 0) {
-		*boot_idx = CONFIG_FWU_NUM_BANKS;
-		log_err("corstone1000: failed to read active index\n");
-	}
-}
-
-int board_late_init(void)
+static void corstone1000_setup_kernel_env(void)
 {
 	struct disk_partition part_info;
 	struct udevice *dev, *bdev;
 	struct nvmxip_plat *plat;
 	struct blk_desc *desc;
+	u32 active_idx;
 	int ret;
+	bool kernel_addr_set, kernel_size_set;
 
 	ret = uclass_first_device_err(UCLASS_NVMXIP, &dev);
 	if (ret < 0) {
-		log_err("Cannot find kernel device\n");
-		return ret;
+		log_err("Cannot find kernel device, err (%d)\n", ret);
+		return;
 	}
 
 	plat = dev_get_plat(dev);
 	device_find_first_child(dev, &bdev);
 	desc = dev_get_uclass_plat(bdev);
-	ret = fwu_get_active_index(&corstone1000_boot_idx);
+	ret = fwu_plat_get_active_index(&active_idx);
 	if (ret < 0) {
-		log_err("corstone1000: failed to read boot index\n");
-		return ret;
+		log_err("corstone1000: failed to read boot index, err (%d)\n", ret);
+		return;
 	}
 
-	if (!corstone1000_boot_idx)
+	kernel_addr_set = env_get_hex("kernel_addr", 0) ? true : false;
+	kernel_size_set = env_get_hex("kernel_size", 0) ? true : false;
+
+	if (kernel_addr_set && kernel_size_set)
+		return;
+
+	if (!active_idx)
 		ret = part_get_info_by_name(desc, CORSTONE1000_KERNEL_PRIMARY,
 					    &part_info);
 	else
@@ -280,18 +275,164 @@ int board_late_init(void)
 
 	if (ret < 0) {
 		log_err("failed to fetch kernel partition index: %d\n",
-			corstone1000_boot_idx);
-		return ret;
+			active_idx);
+		return;
+	}
+
+	if (!kernel_addr_set) {
+		ret = env_set_hex("kernel_addr", plat->phys_base +
+				(part_info.start * part_info.blksz));
+		if (ret)
+			log_err("cannot set kernel_addr variable, err (%d)\n",
+				ret);
+	}
+
+	if (!kernel_size_set) {
+		ret = env_set_hex("kernel_size",
+				  part_info.size * part_info.blksz);
+		if (ret)
+			log_err("cannot set kernel_size variable, err (%d)\n",
+				ret);
+	}
+}
+
+/**
+ * fwu_read_mdata() - Wrapper around fwu_mdata_ops.read_mdata()
+ *
+ * @dev: FWU metadata device
+ * @mdata: Output FWU mdata read
+ * @primary: If primary or secondary copy of metadata is to be read
+ * @size: Size in bytes of the metadata to be read
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int fwu_read_mdata(struct udevice *dev, struct fwu_mdata *mdata,
+		   bool primary, uint32_t size);
+
+/**
+ * corstone1000_mdata_crc_check() - Verify CRC32 of FWU metadata
+ *
+ * @mdata: FWU metadata information
+ *
+ * Calculate the crc32 of the metadata and compare it to the FWU
+ * metadata crc32 field.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure.
+ */
+static int corstone1000_mdata_crc_check(struct fwu_mdata *mdata)
+{
+	u32 calc_crc32;
+	void *buf = &mdata->version;
+	u32 mdata_size = mdata->metadata_size;
+
+	calc_crc32 = crc32(0, buf, mdata_size - sizeof(u32));
+
+	return calc_crc32 == mdata->crc32 ? EFI_SUCCESS : -EINVAL;
+}
+
+/**
+ * corstone1000_read_active_index() - Read active index from metadata storage media
+ *
+ * @primary:	Primary or secondary metadata partition
+ * @active_idx:	Active index value
+ *
+ * Read the selected metadata partition, perform basic verification, and return
+ * the active index.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure.
+ */
+static int corstone1000_read_active_index(bool primary,
+						   uint *active_idx)
+{
+	struct fwu_mdata *mdata_full = NULL;
+	struct fwu_mdata mdata;
+	struct udevice *dev;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_FWU_MDATA, &dev);
+	if (ret)
+		goto fail;
+
+	// Read metadata header, get length
+	ret = fwu_read_mdata(dev, &mdata, primary, sizeof(struct fwu_mdata));
+	if (ret)
+		goto fail;
+
+	if (mdata.version != FWU_MDATA_VERSION) {
+		log_err("FWU partition %s has metadata version %u. Expected value of %u\n",
+			primary ? "Primary" : "Secondary", mdata.version, FWU_MDATA_VERSION);
+		ret = -EINVAL;
+		goto fail;
 	}
 
-	ret = 0;
+	if (mdata.metadata_size > FWU_MDATA_MAX_SIZE) {
+		log_err("FWU partition %s has metadata size too large %u. Max size %u\n",
+			primary ? "Primary" : "Secondary", mdata.metadata_size, FWU_MDATA_MAX_SIZE);
+		ret = -EINVAL;
+		goto fail;
+	}
 
-	ret |= env_set_hex("kernel_addr", plat->phys_base +
-			   (part_info.start * part_info.blksz));
-	ret |= env_set_hex("kernel_size", part_info.size * part_info.blksz);
+	// Read full metadata
+	mdata_full = calloc(1, mdata.metadata_size);
+	if (!mdata_full) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	ret = fwu_read_mdata(dev, mdata_full, primary, mdata.metadata_size);
+	if (ret)
+		goto fail;
+
+	ret = corstone1000_mdata_crc_check(mdata_full);
+	if (ret)
+		goto fail;
+
+	if (mdata_full->active_index >= CONFIG_FWU_NUM_BANKS) {
+		log_err("Active Index(%u) in the FWU partition %s is larger than the number of configured banks\n",
+			mdata_full->active_index,
+			primary ? "Primary" : "Secondary");
+		ret = -EINVAL;
+		goto fail;
+	}
+
+	*active_idx = mdata_full->active_index;
+	ret = EFI_SUCCESS;
 
-	if (ret < 0)
-		log_err("failed to setup kernel addr and size\n");
+fail:
+	if (mdata_full)
+		free(mdata_full);
 
 	return ret;
 }
+
+/**
+ * fwu_plat_get_active_index() - Get the value of the active index
+ *
+ * @active_idx:	Active index value
+ *
+ * Read the active index from the primary metadata copy, falling back to the
+ * secondary on read failure.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure.
+ */
+int fwu_plat_get_active_index(uint *active_idx)
+{
+	int ret;
+
+	if (!active_idx) {
+		log_err("!active_idx\n");
+		return -EINVAL;
+	}
+
+	ret = corstone1000_read_active_index(true, active_idx);
+	if (ret != EFI_SUCCESS)
+		ret = corstone1000_read_active_index(false, active_idx);
+
+	return ret;
+}
+
+int board_late_init(void)
+{
+	corstone1000_setup_kernel_env();
+	return 0;
+}
diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
index 9fb5f87ac6c..2b0501f39fe 100644
--- a/include/fwu_arm_psa.h
+++ b/include/fwu_arm_psa.h
@@ -397,6 +397,18 @@ int fwu_agent_init(void);
  */
 int fwu_update_image(const void *image, u8 image_index, u32 image_size);
 
+/**
+ * fwu_plat_get_active_index() - Get the value of the active index
+ *
+ * @active_idx:	Active index value
+ *
+ * Read the active index from the primary metadata copy, falling back to the
+ * secondary on read failure.
+ *
+ * Return: EFI_SUCCESS on success. Otherwise, failure.
+ */
+int fwu_plat_get_active_index(u32 *active_idx);
+
 /**
  * fwu_get_payload_type() - Identifies the payload type
  * @image_index:	The payload index
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index f01889fd6d3..273b135553e 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -376,6 +376,8 @@ config FWU_ARM_PSA
 		!FWU_MULTI_BANK_UPDATE
 	select EFI_CAPSULE_FIRMWARE
 	select EFI_PARTITION
+	select FWU_MDATA
+	select PARTITION_TYPE_GUID
 	imply EFI_CAPSULE_ON_DISK_EARLY
 	help
 	  Select this option if you want to enable firmware management protocol
-- 
2.43.0

