Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66CBCDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 06:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2361686529;
	Sun, 15 Oct 2023 08:25:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cuv5bpVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E5C867D6; Sun, 15 Oct 2023 08:10:22 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F146E86BCD
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 08:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-27d129e2e7cso2598724a91.3
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 23:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697350064; x=1697954864; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BJ5e7IKwEAKkXWVFFI8NTffUpT2A+VAQXOE1ihzZbNs=;
 b=Cuv5bpVqbDGRYi52XSZ1HpL9MdOiKIE8lbanvGUPmw8/m1TEjtSHSrNGqub20FQlB/
 ORZDYDAAQye2JxMiwadiVw/F3vNBYniG2XIO5Xi8JYefoWz+6ApOFj3vnm0GAMePnv72
 ZX+qfLYdTii0TN6Teumq378urYI4xGDdBkzbPs7xd9yOD919rbZ1ffc3yD8wapQh0CYb
 0HTVoWoZyoVFUVJfwvj3y/2GNdq5Kh9HqzlmR4vT/mzzAlmbXeauojHaW34OqUBRbwlS
 G+LKqXZFZKJY5AYS7pwnjVx+zZ5U9U99tMcOEmZ3P7b0j3AoB3sfBGovTxirm2G4+ToH
 qj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697350064; x=1697954864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BJ5e7IKwEAKkXWVFFI8NTffUpT2A+VAQXOE1ihzZbNs=;
 b=G4a3xexxLxfc1Nu0bzgMRzCWE78y1oBFHX0WbseXTLR/vboTLyaCSgiU0O1PV1RhsJ
 r5ZEXdjgEBY++3+L2RySpvUenrkr02UOQJatB4CBOGG0bjZSGFCJqmnz1G2L3pg4LFV1
 OncwD10X/YMtuJhu+QZwcb9UqU5ni1AKyWYNudsrtJVcA0WV/4iUMvaLw+t7SYKgAiku
 ut3tUwAN5oYh3f/3P/0QIC5vjMoYOJG7MwN9w8Ko632O5E47v7qR+6QuMCPmSUf4tTEA
 3PiFYOpr9iQoYV+0JpxEXz8gNQdKpBybr/GC3wBL3n5lN7xPX6KTELrlDhf/V3QgmMqS
 SSSw==
X-Gm-Message-State: AOJu0YzVVXwKlXJXJ0nAeeCVCpUGKBI+5r02oahMTANH/84eZ7UiRUWc
 k/qJuegY3o6y7Sf+jm8mjoM+M6vbp7FccA==
X-Google-Smtp-Source: AGHT+IGwzlxyCg1QC7XVPusH19LyaPxcyKzNLAuSHDAI2pIGM8ffhYgOJio/O67ZuXkA/xv3gUiOMg==
X-Received: by 2002:ad4:5aac:0:b0:66d:42d9:fc83 with SMTP id
 u12-20020ad45aac000000b0066d42d9fc83mr1556771qvg.10.1697316516745; 
 Sat, 14 Oct 2023 13:48:36 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 bo1-20020a05621414a100b0066d15724feesm1925252qvb.68.2023.10.14.13.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:36 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 26/29] test: spl: Add a test for the MMC load method
Date: Sat, 14 Oct 2023 16:48:02 -0400
Message-Id: <20231014204805.439009-27-seanga2@gmail.com>
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

Add a test for the MMC load method. This shows the general shape of tests
to come: The main test function calls do_spl_test_load with an appropriate
callback to write the image to the medium.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Correct return value documentation for do_spl_test_load
- Explicitly invalidate FAT and MMC caches before testing

 configs/sandbox_noinst_defconfig |  2 +
 include/spl.h                    |  4 ++
 include/test/spl.h               | 30 ++++++++++++++
 test/image/Kconfig               |  1 +
 test/image/spl_load.c            | 36 +++++++++++++++++
 test/image/spl_load_fs.c         | 69 +++++++++++++++++++++++++++++---
 6 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 11be2dccf7d..4f16d9860d2 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -41,6 +41,8 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x0
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FS_EXT4=y
 CONFIG_SPL_I2C=y
diff --git a/include/spl.h b/include/spl.h
index 5b051ef2aae..708b15a0c7f 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -673,6 +673,10 @@ static inline const char *spl_loader_name(const struct spl_image_loader *loader)
 	}
 #endif
 
+#define SPL_LOAD_IMAGE_GET(_priority, _boot_device, _method) \
+	ll_entry_get(struct spl_image_loader, \
+		     _boot_device ## _priority ## _method, spl_image_loader)
+
 /* SPL FAT image functions */
 
 /**
diff --git a/include/test/spl.h b/include/test/spl.h
index 7dba3f03d07..009c6b35462 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -79,6 +79,36 @@ size_t create_image(void *dst, enum spl_test_image type,
 int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		     struct spl_image_info *info2);
 
+/**
+ * typedef write_image_t - Callback for writing an image
+ * @uts: Current unit test state
+ * @img: Image to write
+ * @size: Size of @img
+ *
+ * Write @img to a location which will be read by a &struct spl_image_loader.
+ *
+ * Return: 0 on success or 1 on failure
+ */
+typedef int write_image_t(struct unit_test_state *its, void *img, size_t size);
+
+/**
+ * do_spl_test_load() - Test loading with an SPL image loader
+ * @uts: Current unit test state
+ * @test_name: Name of the current test
+ * @type: Type of image to try loading
+ * @loader: The loader to test
+ * @write_image: Callback to write the image to the backing storage
+ *
+ * Test @loader, performing the common tasks of setting up the image and
+ * checking it was loaded correctly. The caller must supply a @write_image
+ * callback to write the image to a location which will be read by @loader.
+ *
+ * Return: 0 on success or 1 on failure
+ */
+int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
+		     enum spl_test_image type, struct spl_image_loader *loader,
+		     write_image_t write_image);
+
 /**
  * image_supported() - Determine whether an image type is supported
  * @type: The image type to check
diff --git a/test/image/Kconfig b/test/image/Kconfig
index a52766b77d4..e6be1b829f3 100644
--- a/test/image/Kconfig
+++ b/test/image/Kconfig
@@ -18,6 +18,7 @@ config SPL_UT_LOAD_FS
 	depends on SPL_FS_FAT
 	depends on SPL_FS_EXT4
 	depends on SPL_MMC_WRITE
+	depends on SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
 	default y
 	help
 	  Test filesystems and the various load methods which use them.
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index de2fddae359..d2ce66071bc 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -365,3 +365,39 @@ SPL_IMG_TEST(spl_test_image, LEGACY, 0);
 SPL_IMG_TEST(spl_test_image, IMX8, 0);
 SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
 SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
+
+int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
+		     enum spl_test_image type, struct spl_image_loader *loader,
+		     int (*write_image)(struct unit_test_state *, void *, size_t))
+{
+	size_t img_size, img_data, plain_size = SPL_TEST_DATA_SIZE;
+	struct spl_image_info info_write = {
+		.name = test_name,
+		.size = plain_size,
+	}, info_read = { };
+	struct spl_boot_device bootdev = {
+		.boot_device = loader->boot_device,
+	};
+	char *plain;
+	void *img;
+
+	img_size = create_image(NULL, type, &info_write, &img_data);
+	ut_assert(img_size);
+	img = calloc(img_size, 1);
+	ut_assertnonnull(img);
+
+	plain = img + img_data;
+	generate_data(plain, plain_size, test_name);
+	ut_asserteq(img_size, create_image(img, type, &info_write, NULL));
+
+	if (write_image(uts, img, img_size))
+		return CMD_RET_FAILURE;
+
+	ut_assertok(loader->load_image(&info_read, &bootdev));
+	if (check_image_info(uts, &info_write, &info_read))
+		return CMD_RET_FAILURE;
+	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
+
+	free(img);
+	return 0;
+}
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index a8b45bdbc49..297ab08a820 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -306,8 +306,16 @@ static int spl_test_fat(struct unit_test_state *uts)
 }
 SPL_TEST(spl_test_fat, DM_FLAGS);
 
+static bool spl_mmc_raw;
+
+u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
+{
+	return spl_mmc_raw ? MMCSD_MODE_RAW : MMCSD_MODE_FS;
+}
+
 static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
-			   enum spl_test_image type, create_fs_t create_fs)
+			   enum spl_test_image type, create_fs_t create_fs,
+			   bool blk_mode)
 {
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	struct blk_desc *dev_desc;
@@ -321,7 +329,11 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 		.start = 1,
 		.sys_ind = 0x83,
 	};
-	struct spl_boot_device bootdev = { };
+	struct spl_image_loader *loader =
+		SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_MMC1, spl_mmc_load_image);
+	struct spl_boot_device bootdev = {
+		.boot_device = loader->boot_device,
+	};
 	void *fs;
 	char *data;
 
@@ -346,7 +358,12 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 	ut_assertok(write_mbr_partitions(dev_desc, &part, 1, 0));
 	ut_asserteq(part.size, blk_dwrite(dev_desc, part.start, part.size, fs));
 
-	ut_assertok(spl_blk_load_image(&info_read, &bootdev, UCLASS_MMC, 0, 1));
+	spl_mmc_raw = false;
+	if (blk_mode)
+		ut_assertok(spl_blk_load_image(&info_read, &bootdev, UCLASS_MMC,
+					       0, 1));
+	else
+		ut_assertok(loader->load_image(&info_read, &bootdev));
 	if (check_image_info(uts, &info_write, &info_read))
 		return CMD_RET_FAILURE;
 	ut_asserteq_mem(data, phys_to_virt(info_write.load_addr), data_size);
@@ -359,11 +376,53 @@ static int spl_test_blk(struct unit_test_state *uts, const char *test_name,
 			enum spl_test_image type)
 {
 	spl_fat_force_reregister();
-	if (spl_test_mmc_fs(uts, test_name, type, create_fat))
+	if (spl_test_mmc_fs(uts, test_name, type, create_fat, true))
 		return CMD_RET_FAILURE;
 
-	return spl_test_mmc_fs(uts, test_name, type, create_ext2);
+	return spl_test_mmc_fs(uts, test_name, type, create_ext2, true);
 }
 SPL_IMG_TEST(spl_test_blk, LEGACY, DM_FLAGS);
 SPL_IMG_TEST(spl_test_blk, FIT_EXTERNAL, DM_FLAGS);
 SPL_IMG_TEST(spl_test_blk, FIT_INTERNAL, DM_FLAGS);
+
+static int spl_test_mmc_write_image(struct unit_test_state *uts, void *img,
+				    size_t img_size)
+{
+	struct blk_desc *dev_desc;
+	size_t img_blocks;
+
+	dev_desc = blk_get_devnum_by_uclass_id(UCLASS_MMC, 0);
+	ut_assertnonnull(dev_desc);
+
+	img_blocks = DIV_ROUND_UP(img_size, dev_desc->blksz);
+	ut_asserteq(img_blocks, blk_dwrite(dev_desc,
+					   CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR,
+					   img_blocks, img));
+
+	spl_mmc_raw = true;
+	return 0;
+}
+
+static int spl_test_mmc(struct unit_test_state *uts, const char *test_name,
+			enum spl_test_image type)
+{
+	spl_mmc_clear_cache();
+	spl_fat_force_reregister();
+
+	if (type == LEGACY &&
+	    spl_test_mmc_fs(uts, test_name, type, create_ext2, false))
+		return CMD_RET_FAILURE;
+
+	if (type != IMX8 &&
+	    spl_test_mmc_fs(uts, test_name, type, create_fat, false))
+		return CMD_RET_FAILURE;
+
+	return do_spl_test_load(uts, test_name, type,
+				SPL_LOAD_IMAGE_GET(0, BOOT_DEVICE_MMC1,
+						   spl_mmc_load_image),
+				spl_test_mmc_write_image);
+}
+SPL_IMG_TEST(spl_test_mmc, LEGACY, DM_FLAGS);
+SPL_IMG_TEST(spl_test_mmc, IMX8, DM_FLAGS);
+SPL_IMG_TEST(spl_test_mmc, FIT_EXTERNAL, DM_FLAGS);
+SPL_IMG_TEST(spl_test_mmc, FIT_INTERNAL, DM_FLAGS);
-- 
2.37.1

