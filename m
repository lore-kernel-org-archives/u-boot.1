Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53CCCDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9BF86E9F;
	Thu, 12 Oct 2023 04:02:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IHWucnu2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 973E586EFA; Thu, 12 Oct 2023 04:00:23 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CA7D86EA2
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4194c3cf04aso3309761cf.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075815; x=1697680615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EiNnh3JVndSY28cUw9+iYbTdUkF2uS2mxl1wTpXMbVQ=;
 b=IHWucnu2WMzTJzm2kaOwXmnS+8+784N2TrSwbn1uYCn3/4lDYX+P7dtSR2txpqvCac
 G6SpCy1R+/XepEDpfaApYYCkOrXn7dqsv8+cJ+Srvy9QnpnxaFHCTfby1WqTdyK5oOi0
 pVf5V6IcS19fip/HpOU4zmHYX1LAmZFbYeCXE8xYuIgr6BW1pr0DeD/WXwh4mcTlSoPS
 VJbqpmtV4LbfYUQxWUwBVUNaiDShdI7DKhb0WSYfc6z2N1esZtaZ/G8TspIJXcD/Arlj
 QIRMVPpXHksPzsGWCGn/5CLWR/ZI1FeYPnGGfB+lNXIxTzvavBbZpSkXiXyxFteOr+Xi
 BPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075815; x=1697680615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EiNnh3JVndSY28cUw9+iYbTdUkF2uS2mxl1wTpXMbVQ=;
 b=GxGgVeYWcMNN5Vr9q3kXL6EkHuXgw+71GhFKSQQ1TioUan5+TOvAOIsXgqhASvaCwq
 gTknP7Z3H3cysTo7lLQ1A5Ac7sGlZqnVQvjr+gJb43ktCBbYUAyLAlwuLsL0EwIoxysv
 XV8DNAkls2FTk6ZB1C+t4IommJuGzlmDfFqjyNRN13UiaaHHM0P2IEGbqJZR5qMtyguf
 bmEZxnmT5K0u4jFSCkqBhPj2yQxpuuGgHG3VDQW7HtLvupgBYCBFuTTz2dQc8sLtO0bq
 6eoqa3/h38LZbG8JpI53hviFtQmR2nFBhEWV8/HgPfmtWSWO776mjljhSVuTZdQ1QSja
 oLPQ==
X-Gm-Message-State: AOJu0YwIzJo6HgOU+ui5aPXRR6Fbve0nF4t93sqlDsRLi9QLGPI5IUaB
 o0Tb6Tb9GOBtUHVs3JpzcA2GB6Gqf26R5A==
X-Google-Smtp-Source: AGHT+IGp7UaCSngmGefuExMl52pOBmJs+IrHhWys7We5QNg5ifdZcjjvyx7vEaXBhrkbrGJ6P2uWjA==
X-Received: by 2002:ac8:7dd5:0:b0:418:1194:42f3 with SMTP id
 c21-20020ac87dd5000000b00418119442f3mr31296157qte.56.1697075815336; 
 Wed, 11 Oct 2023 18:56:55 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 g8-20020ac81248000000b00417fa7d33dbsm5750809qtj.93.2023.10.11.18.56.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:55 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 23/26] test: spl: Add a test for the MMC load method
Date: Wed, 11 Oct 2023 21:56:23 -0400
Message-Id: <20231012015626.3487451-24-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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
---

 configs/sandbox_noinst_defconfig |  2 +
 include/spl.h                    |  4 ++
 include/test/spl.h               | 30 +++++++++++++++
 test/image/Kconfig               |  1 +
 test/image/spl_load.c            | 36 +++++++++++++++++
 test/image/spl_load_fs.c         | 66 +++++++++++++++++++++++++++++---
 6 files changed, 134 insertions(+), 5 deletions(-)

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
index 7d30fb57dac..8229d40adab 100644
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
 int spl_load_image_fat(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev,
diff --git a/include/test/spl.h b/include/test/spl.h
index 7ae32a1020b..cfb52c90855 100644
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
+ * Return: 0 on success or -1 on failure
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
+ * Return: 0 on success or -1 on failure
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
index 4338da417ce..06249044f9b 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -368,3 +368,39 @@ SPL_IMG_TEST(spl_test_image, LEGACY, 0);
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
index 45059f91999..77a6956fb95 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -305,8 +305,16 @@ static int spl_test_fat(struct unit_test_state *uts)
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
@@ -320,7 +328,11 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
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
 
@@ -345,7 +357,12 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
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
@@ -357,11 +374,50 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 static int spl_test_blk(struct unit_test_state *uts, const char *test_name,
 			enum spl_test_image type)
 {
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

