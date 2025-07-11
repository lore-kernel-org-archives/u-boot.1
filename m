Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F29AC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 14:53:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7F188313B;
	Fri, 11 Jul 2025 16:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08848312A; Fri, 11 Jul 2025 16:50:18 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 72EA18311B
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 16:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=abdellatif.elkhlifi@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D3532681;
 Fri, 11 Jul 2025 07:50:05 -0700 (PDT)
Received: from e130802.cambridge.arm.com (e130802.arm.com [10.1.35.55])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB9CE3F738;
 Fri, 11 Jul 2025 07:50:14 -0700 (PDT)
From: abdellatif.elkhlifi@arm.com
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
Subject: [PATCH v2 22/25] fwu_arm_psa: corstone1000: Perform bank logic when
 reading boot index
Date: Fri, 11 Jul 2025 15:49:14 +0100
Message-Id: <20250711144917.1876948-23-abdellatif.elkhlifi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
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

From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>

Move bank logic from board_late_init to fwu_plat_get_bootidx

board_late_init is called very early before the FWU subsystem is setup.
So, the metadata is still not initialized at that level. Reading the boot
index at that level returns an invalid value.
Moving the bank logic to fwu_plat_get_bootidx guarantees the returned
boot index is reflecting the value read from the metadata.

Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Hugues Kamba Mpiana <hugues.kambampiana@arm.com>
---
 board/armltd/corstone1000/corstone1000.c | 63 +++++++++++-------------
 configs/corstone1000_defconfig           |  1 -
 2 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/board/armltd/corstone1000/corstone1000.c b/board/armltd/corstone1000/corstone1000.c
index d2176b9174d..2ccf851e6c5 100644
--- a/board/armltd/corstone1000/corstone1000.c
+++ b/board/armltd/corstone1000/corstone1000.c
@@ -151,8 +151,6 @@ struct efi_capsule_update_info update_info = {
 
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-static int corstone1000_boot_idx;
-
 static struct mm_region corstone1000_mem_map[] = {
 	{
 		/* CVM */
@@ -234,45 +232,37 @@ int dram_init_banksize(void)
 }
 
 void fwu_plat_get_bootidx(uint *boot_idx)
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
 {
 	struct disk_partition part_info;
 	struct udevice *dev, *bdev;
 	struct nvmxip_plat *plat;
 	struct blk_desc *desc;
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
+	ret = fwu_get_active_index(boot_idx);
 	if (ret < 0) {
+		*boot_idx = CONFIG_FWU_NUM_BANKS;
 		log_err("corstone1000: failed to read boot index\n");
-		return ret;
+		return;
 	}
 
-	if (!corstone1000_boot_idx)
+	kernel_addr_set = env_get_hex("kernel_addr", 0) ? true : false;
+	kernel_size_set = env_get_hex("kernel_size", 0) ? true : false;
+
+	if (kernel_addr_set && kernel_size_set)
+		return;
+
+	if (!(*boot_idx))
 		ret = part_get_info_by_name(desc, CORSTONE1000_KERNEL_PRIMARY,
 					    &part_info);
 	else
@@ -281,18 +271,23 @@ int board_late_init(void)
 
 	if (ret < 0) {
 		log_err("failed to fetch kernel partition index: %d\n",
-			corstone1000_boot_idx);
-		return ret;
+			*boot_idx);
+		return;
 	}
 
-	ret = 0;
-
-	ret |= env_set_hex("kernel_addr", plat->phys_base +
-			   (part_info.start * part_info.blksz));
-	ret |= env_set_hex("kernel_size", part_info.size * part_info.blksz);
-
-	if (ret < 0)
-		log_err("failed to setup kernel addr and size\n");
+	if (!kernel_addr_set) {
+		ret = env_set_hex("kernel_addr", plat->phys_base +
+				(part_info.start * part_info.blksz));
+		if (ret)
+			log_err("cannot set kernel_addr variable, err (%d)\n",
+				ret);
+	}
 
-	return ret;
+	if (!kernel_size_set) {
+		ret = env_set_hex("kernel_size",
+				  part_info.size * part_info.blksz);
+		if (ret)
+			log_err("cannot set kernel_size variable, err (%d)\n",
+				ret);
+	}
 }
diff --git a/configs/corstone1000_defconfig b/configs/corstone1000_defconfig
index 5b10e3f7484..d52d39a0b36 100644
--- a/configs/corstone1000_defconfig
+++ b/configs/corstone1000_defconfig
@@ -31,7 +31,6 @@ CONFIG_SYS_CBSIZE=512
 CONFIG_LOGLEVEL=7
 # CONFIG_DISPLAY_CPUINFO is not set
 # CONFIG_DISPLAY_BOARDINFO is not set
-CONFIG_BOARD_LATE_INIT=y
 CONFIG_SYS_PROMPT="corstone1000# "
 # CONFIG_CMD_CONSOLE is not set
 CONFIG_CMD_FWU_METADATA=y
-- 
2.25.1

