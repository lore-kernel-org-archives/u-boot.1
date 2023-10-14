Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB57CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:07:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159B086F09;
	Sun, 15 Oct 2023 08:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLMih0wc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19E086AB9; Sun, 15 Oct 2023 07:59:15 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B8F2867EF
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 07:56:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-66d122f6294so23018416d6.0
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 22:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697349405; x=1697954205; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oleBa1JsX+TKQ1Udug310WTxFGU6dlYz8kv8GD1aASk=;
 b=NLMih0wci24KzERE0htkh/d0iqs4PVBVe6f4Vzize9TutThcpsVRt0TnWN7YgObTxY
 Fak6qPk3RJAve/chb3yO6zAzXC4g2IhIkGw6EJZ34kX0ovtH3ugCeQ+ImB07xDIW2LvP
 zIo5uewWx3SQNb/52r9G90YPSTefeC5XtxsZ9fS2One4pfPVqGOjwqUROUC6WfQUa0qY
 dhAdEUATuP5HlwLdb7V+cvsG4xx791WB90dnPSAyBwgH2s/gaazOmbvMjNiHpDGwVLNG
 jmabE/GHUvrScjUCKOdSb8gCLB4VSwrl82CYaZ5FbvqA5otjCqXHQtdfPvwSCRACNPiG
 R/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697349405; x=1697954205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oleBa1JsX+TKQ1Udug310WTxFGU6dlYz8kv8GD1aASk=;
 b=Ek2xb94zAM9uWG7lBxLSuQb7z2Jlz1qW5gbwUL53nRNYFYnYW4vGjsprFN8hUPs2Ps
 XPU2UfCSdcHox83MTD1qRM6cBNPs3sCF3emVtSOULM/EOl0IYTSFV13JObOFDzf+0TLV
 PFXe5Bgyz02EAhCro/Lq22SJjs3QEXIvCRFT+Z2eihGB0jMQ9ZxjA+1P74quQ4K1uFOM
 UE381IUNUkIvVv8NvoRoRtzwv2h9+tHGvZ6UIsQp/rIbx0H5ucrpAWi/sVrmQqbDf64s
 BAEtbqFpAyCbi09DGZRjf067LkUb1wLSX2lEbmgj/ycD45Tcl9PxwpUUKwoxyW0k4tVy
 RVNg==
X-Gm-Message-State: AOJu0YyqDogDEo1Vu82pNSpMYHksWlbVCIAAcSpPulQRjiOQcNnluaKQ
 m0jYqKTA/XO8MLZOre0py/Cuiz9H1mN/Og==
X-Google-Smtp-Source: AGHT+IEqd1MX2dBfU9sS6IehPIa1cJh4XIlWu9p2ePi6wl4wEm5RSd9q8IoekMLqqNwrVyWThGULMg==
X-Received: by 2002:a0c:bf4b:0:b0:656:3612:7954 with SMTP id
 b11-20020a0cbf4b000000b0065636127954mr30408517qvj.1.1697316515710; 
 Sat, 14 Oct 2023 13:48:35 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 b16-20020a05620a127000b00767dc4c539bsm1720816qkl.44.2023.10.14.13.48.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:35 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>
Subject: [PATCH v2 25/29] test: spl: Add a test for spl_blk_load_image
Date: Sat, 14 Oct 2023 16:48:01 -0400
Message-Id: <20231014204805.439009-26-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

Add a test for spl_blk_load_image, currently used only by NVMe. Because
there is no sandbox NVMe driver, just use MMC instead. Avoid falling back
to raw images to make failures more obvious.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Explicitly invalidate FAT block device cache before testing

 configs/sandbox_noinst_defconfig |  2 +
 test/image/Kconfig               |  3 +-
 test/image/spl_load_fs.c         | 63 ++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 0a542cfb6aa..11be2dccf7d 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -34,6 +34,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_BOARD_INIT=y
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
 CONFIG_SPL_LOAD_IMX_CONTAINER=y
 CONFIG_SPL_SYS_MALLOC=y
@@ -123,6 +124,7 @@ CONFIG_ADC=y
 CONFIG_ADC_SANDBOX=y
 CONFIG_AXI=y
 CONFIG_AXI_SANDBOX=y
+CONFIG_SPL_BLK_FS=y
 CONFIG_SYS_IDE_MAXBUS=1
 CONFIG_SYS_ATA_BASE_ADDR=0x100
 CONFIG_SYS_ATA_STRIDE=4
diff --git a/test/image/Kconfig b/test/image/Kconfig
index 963c86cc290..a52766b77d4 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -14,12 +14,13 @@ config SPL_UT_LOAD_FS
 	bool "Unit tests for filesystems"
 	depends on SANDBOX && SPL_OF_REAL
 	depends on FS_LOADER
+	depends on SPL_BLK_FS
 	depends on SPL_FS_FAT
 	depends on SPL_FS_EXT4
 	depends on SPL_MMC_WRITE
 	default y
 	help
-	  Test filesystems in SPL.
+	  Test filesystems and the various load methods which use them.
 
 config SPL_UT_LOAD_OS
 	bool "Test loading from the host OS"
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 0ee1ede134a..a8b45bdbc49 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -10,6 +10,7 @@
 #include <fat.h>
 #include <fs.h>
 #include <memalign.h>
+#include <spl.h>
 #include <asm/io.h>
 #include <linux/stat.h>
 #include <test/spl.h>
@@ -304,3 +305,65 @@ static int spl_test_fat(struct unit_test_state *uts)
 	return spl_test_fs(uts, __func__, create_fat);
 }
 SPL_TEST(spl_test_fat, DM_FLAGS);
+
+static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
+			   enum spl_test_image type, create_fs_t create_fs)
+{
+	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
+	struct blk_desc *dev_desc;
+	size_t fs_size, fs_data, img_size, img_data,
+	       data_size = SPL_TEST_DATA_SIZE;
+	struct spl_image_info info_write = {
+		.name = test_name,
+		.size = data_size,
+	}, info_read = { };
+	struct disk_partition part = {
+		.start = 1,
+		.sys_ind = 0x83,
+	};
+	struct spl_boot_device bootdev = { };
+	void *fs;
+	char *data;
+
+	img_size = create_image(NULL, type, &info_write, &img_data);
+	ut_assert(img_size);
+	fs_size = create_fs(NULL, img_size, filename, &fs_data);
+	ut_assert(fs_size);
+	fs = calloc(fs_size, 1);
+	ut_assertnonnull(fs);
+
+	data = fs + fs_data + img_data;
+	generate_data(data, data_size, test_name);
+	ut_asserteq(img_size, create_image(fs + fs_data, type, &info_write,
+					   NULL));
+	ut_asserteq(fs_size, create_fs(fs, img_size, filename, NULL));
+
+	dev_desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	ut_assertnonnull(dev_desc);
+
+	ut_asserteq(512, dev_desc->blksz);
+	part.size = fs_size / dev_desc->blksz;
+	ut_assertok(write_mbr_partitions(dev_desc, &part, 1, 0));
+	ut_asserteq(part.size, blk_dwrite(dev_desc, part.start, part.size, fs));
+
+	ut_assertok(spl_blk_load_image(&info_read, &bootdev, UCLASS_MMC, 0, 1));
+	if (check_image_info(uts, &info_write, &info_read))
+		return CMD_RET_FAILURE;
+	ut_asserteq_mem(data, phys_to_virt(info_write.load_addr), data_size);
+
+	free(fs);
+	return 0;
+}
+
+static int spl_test_blk(struct unit_test_state *uts, const char *test_name,
+			enum spl_test_image type)
+{
+	spl_fat_force_reregister();
+	if (spl_test_mmc_fs(uts, test_name, type, create_fat))
+		return CMD_RET_FAILURE;
+
+	return spl_test_mmc_fs(uts, test_name, type, create_ext2);
+}
+SPL_IMG_TEST(spl_test_blk, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_blk, FIT_EXTERNAL, DM_FLAGS);
+SPL_IMG_TEST(spl_test_blk, FIT_INTERNAL, DM_FLAGS);
-- 
2.37.1

