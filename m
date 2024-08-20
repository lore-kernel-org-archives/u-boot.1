Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D943AC3DA4A
	for <u-boot@archiver.kernel.org>; Tue, 20 Aug 2024 04:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D953788D45;
	Tue, 20 Aug 2024 06:48:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gnu.org header.i=@gnu.org header.b="hb0syRHY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B98E88D38; Tue, 20 Aug 2024 06:48:17 +0200 (CEST)
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DE1388D45
 for <u-boot@lists.denx.de>; Tue, 20 Aug 2024 06:48:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=othacehe@gnu.org
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <othacehe@gnu.org>)
 id 1sgGmx-0004fD-22; Tue, 20 Aug 2024 00:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
 references; bh=hG/b6J9c7Pdn20D/5t/nzYkeRhXzTs3Uqr9bI8Lj7D4=; b=hb0syRHYSBsFp+
 WyLrEWYZf/rEyCAubNNWw6sOmfp+TX19Atdatav4bI2nX2Jo/GpkfZKKSFTF/U06Y31A3Y5uBM26u
 4+P3Y4TLYpd8foRelJ9zOQHXdvkdVTW0MdctaFxc/ni6MeqilKRrmc81Rdkicf2NnCnph2Wv7QC7V
 tCinEW5Cr76vP9KjK+p0/6efBlLH1GKZJKM/gPfiWW0vQx8oB4Mb43a6ai5I8x/XVzSQonfOC35t1
 jyqF16aWfVQJ4hUpAw/nzKcktgcnhEhXKWKXEN4rn+B33NMhlopT8bAA7e4wmrj2JtvIQnM/5KW2j
 qsw/2Oc/nda7HQWYjnFg==;
From: Mathieu Othacehe <othacehe@gnu.org>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Cc: "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Mathieu Othacehe <othacehe@gnu.org>
Subject: [PATCH v2] imx: ele_ahab: Add HUK derivation support
Date: Tue, 20 Aug 2024 06:48:02 +0200
Message-ID: <20240820044802.12401-1-othacehe@gnu.org>
X-Mailer: git-send-email 2.45.2
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

Add a new ahab_derive command that derives the hardware unique key (HUK)
into a 16 or 32 bytes key and stores it at the given address.

Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
---
 arch/arm/include/asm/mach-imx/ele_api.h |  2 +
 arch/arm/mach-imx/ele_ahab.c            | 31 ++++++++++
 drivers/misc/imx_ele/ele_api.c          | 77 +++++++++++++++++++++++++
 3 files changed, 110 insertions(+)

diff --git a/arch/arm/include/asm/mach-imx/ele_api.h b/arch/arm/include/asm/mach-imx/ele_api.h
index a29b849d903..d4ac567e7ed 100644
--- a/arch/arm/include/asm/mach-imx/ele_api.h
+++ b/arch/arm/include/asm/mach-imx/ele_api.h
@@ -26,6 +26,7 @@
 #define ELE_GET_EVENTS_REQ (0xA2)
 #define ELE_COMMIT_REQ (0xA8)
 #define ELE_START_RNG (0xA3)
+#define ELE_CMD_DERIVE_KEY (0xA9)
 #define ELE_GENERATE_DEK_BLOB (0xAF)
 #define ELE_ENABLE_PATCH_REQ (0xC3)
 #define ELE_RELEASE_RDC_REQ (0xC4)
@@ -143,6 +144,7 @@ int ele_read_common_fuse(u16 fuse_id, u32 *fuse_words, u32 fuse_num, u32 *respon
 int ele_release_caam(u32 core_did, u32 *response);
 int ele_get_fw_version(u32 *fw_version, u32 *sha1, u32 *response);
 int ele_get_events(u32 *events, u32 *events_cnt, u32 *response);
+int ele_derive_huk(u8 *key, size_t key_size, u8 *ctx, size_t seed_size);
 int ele_commit(u16 fuse_id, u32 *response, u32 *info_type);
 int ele_generate_dek_blob(u32 key_id, u32 src_paddr, u32 dst_paddr, u32 max_output_size);
 int ele_dump_buffer(u32 *buffer, u32 buffer_length);
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index d02316ed6cb..7f6cfdadf77 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -625,6 +625,31 @@ static int do_ahab_return_lifecycle(struct cmd_tbl *cmdtp, int flag, int argc, c
 	return CMD_RET_SUCCESS;
 }
 
+static int do_ahab_derive(struct cmd_tbl *cmdtp, int flag, int argc,
+			  char *const argv[])
+{
+	ulong key;
+	size_t key_size;
+	char *seed = "_ELE_AHAB_SEED_";
+
+	if (argc != 3)
+		return CMD_RET_USAGE;
+
+	key = hextoul(argv[1], NULL);
+	key_size = simple_strtoul(argv[2], NULL, 10);
+	if (key_size != 16 && key_size != 32) {
+		printf("key size can only be 16 or 32\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (ele_derive_huk((u8 *)key, key_size, seed, sizeof(seed))) {
+		printf("Error in AHAB derive\n");
+		return CMD_RET_FAILURE;
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
 static int do_ahab_commit(struct cmd_tbl *cmdtp, int flag, int argc,
 			  char *const argv[])
 {
@@ -681,6 +706,12 @@ U_BOOT_CMD(ahab_return_lifecycle, CONFIG_SYS_MAXARGS, 1, do_ahab_return_lifecycl
 	   "addr - Return lifecycle message block signed by OEM SRK\n"
 );
 
+U_BOOT_CMD(ahab_derive, CONFIG_SYS_MAXARGS, 3, do_ahab_derive,
+	   "Derive the hardware unique key",
+	   "addr [16|32]\n"
+	   "Store at addr the derivation of the HUK on 16 or 32 bytes.\n"
+);
+
 U_BOOT_CMD(ahab_commit, CONFIG_SYS_MAXARGS, 1, do_ahab_commit,
 	   "commit into the fuses any new SRK revocation and FW version information\n"
 	   "that have been found into the NXP (ELE FW) and OEM containers",
diff --git a/drivers/misc/imx_ele/ele_api.c b/drivers/misc/imx_ele/ele_api.c
index e0ec22c7abf..723580d91bf 100644
--- a/drivers/misc/imx_ele/ele_api.c
+++ b/drivers/misc/imx_ele/ele_api.c
@@ -1,12 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2020, 2023 NXP
+ * Copyright 2024 Mathieu Othacehe <othacehe@gnu.org>
  *
  */
 
 #include <common.h>
 #include <hang.h>
 #include <malloc.h>
+#include <memalign.h>
 #include <asm/io.h>
 #include <dm.h>
 #include <asm/mach-imx/ele_api.h>
@@ -528,6 +530,81 @@ int ele_start_rng(void)
 	return ret;
 }
 
+int ele_derive_huk(u8 *key, size_t key_size, u8 *seed, size_t seed_size)
+{
+	struct udevice *dev = gd->arch.ele_dev;
+	struct ele_msg msg;
+	int msg_size = sizeof(struct ele_msg);
+	u8 *seed_aligned, *key_aligned;
+	int ret, size;
+
+	if (!dev) {
+		printf("ele dev is not initialized\n");
+		return -ENODEV;
+	}
+
+	if (key_size != 16 && key_size != 32) {
+		printf("key size can only be 16 or 32\n");
+		return -EINVAL;
+	}
+
+	if (seed_size >= (1U << 16) - 1) {
+		printf("seed size is too large\n");
+		return -EINVAL;
+	}
+
+	seed_aligned = memalign(ARCH_DMA_MINALIGN, seed_size);
+	if (!seed_aligned) {
+		printf("failed to alloc memory\n");
+		return -EINVAL;
+	}
+	memcpy(seed_aligned, seed, seed_size);
+
+	key_aligned = memalign(ARCH_DMA_MINALIGN, key_size);
+	if (!key_aligned) {
+		printf("failed to alloc memory\n");
+		ret = -EINVAL;
+		goto ret_seed;
+	}
+
+	size = ALIGN(seed_size, ARCH_DMA_MINALIGN);
+	flush_dcache_range((ulong)seed_aligned,
+			   (ulong)seed_aligned + size);
+
+	size = ALIGN(key_size, ARCH_DMA_MINALIGN);
+	invalidate_dcache_range((ulong)key_aligned,
+				(ulong)key_aligned + size);
+
+	msg.version = ELE_VERSION;
+	msg.tag = ELE_CMD_TAG;
+	msg.size = 7;
+	msg.command = ELE_CMD_DERIVE_KEY;
+	msg.data[0] = upper_32_bits((ulong)key_aligned);
+	msg.data[1] = lower_32_bits((ulong)key_aligned);
+	msg.data[2] = upper_32_bits((ulong)seed_aligned);
+	msg.data[3] = lower_32_bits((ulong)seed_aligned);
+	msg.data[4] = seed_size << 16 | key_size;
+	msg.data[5] = compute_crc(&msg);
+
+	ret = misc_call(dev, false, &msg, msg_size, &msg, msg_size);
+	if (ret) {
+		printf("Error: %s: ret %d, response 0x%x\n",
+		       __func__, ret, msg.data[0]);
+		goto ret_key;
+	}
+
+	invalidate_dcache_range((ulong)key_aligned,
+				(ulong)key_aligned + size);
+	memcpy(key, key_aligned, key_size);
+
+ret_key:
+	free(key_aligned);
+ret_seed:
+	free(seed_aligned);
+
+	return ret;
+}
+
 int ele_commit(u16 fuse_id, u32 *response, u32 *info_type)
 {
 	struct udevice *dev = gd->arch.ele_dev;
-- 
2.45.2

