Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53767C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0FE87527;
	Wed,  8 Nov 2023 17:49:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F6RlnaLT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B124287725; Wed,  8 Nov 2023 17:49:34 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582728771B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ce2c71c61fso3747353a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462159; x=1700066959; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JWTuI0gh1iIFFh4Vk9Vtj/V6O0RVT3ioWKE0tYndafM=;
 b=F6RlnaLT37XLH6EUSiXqCzN2X946f6HSV/MmJYxm9deXfqpuR3h4lW0T7HpuCa3Hnz
 HY7kQAPuquZm6megWAxfL7dLeaPon6resh7nseU+S42vpDbjl1ZxAOcijgf575+2/sP+
 Wd+C4RrZGFGkxwffYieDBYdWKH/WIWWx+2dgnFjPHR1ECnxm4oQSqOfmIpaQSj1wnZrT
 pTkCP634trOB5kbJK+6E+p0KqLVREStPJhtYSq4i37iIsxji1YZ5R8/OvzCWoovNsQ6O
 hyvG9GJX7YoemqGzqdJdTFr9v2E0nfwg+wZkM3SwQfQ4a2On4vlUTMjRf1+b57qGxNvX
 4BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462159; x=1700066959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWTuI0gh1iIFFh4Vk9Vtj/V6O0RVT3ioWKE0tYndafM=;
 b=Wm3BnAsKzIeLK6lnnrx4zdEjG8R0K+OthgJPKF0lXH5Kxj4rR3PFwVPy2RP4TIsmpj
 HAyd5L78FC17DECDzFOQV69Jsb5Pn/KAi46dbPM6u7lLKRlglGSdMZQpNyPchN+8fFvd
 ybmEkNaKCXhFM3THwBD7oO29WqwjW2X9H6mja4obWWE92Bl6GZoGRJZsclJy2tXiFmAG
 xtj2IsU37ibtrqAuc5hf2nU4bCyl4uikit07socNN+HmucwD/o3LUN/YDLlPR7jcuyDV
 +cuGz+N0QM+JgUAOM9i0EHjux/+wNhhYUVwnlBxpjAxlZO2WAl0aOb6KxoZ9ymotMiRW
 hkJQ==
X-Gm-Message-State: AOJu0YzHIuHOI2/wZWanKKHI0hMitzFg9xf99D05lSMBBfSBDYQZ9vk0
 +SMKy/nNHDl++DXhmPqUnjc=
X-Google-Smtp-Source: AGHT+IGwJAlFeX2ZzGdwVPxdlQzni6PWQ+ZydXqiIPF9vSQax1stEVnJwqX3+o6OO5xjy1ysr2yqCg==
X-Received: by 2002:a9d:65ca:0:b0:6d4:6ca8:5794 with SMTP id
 z10-20020a9d65ca000000b006d46ca85794mr2258899oth.35.1699462159509; 
 Wed, 08 Nov 2023 08:49:19 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 jt56-20020a05622aa03800b0041cb8732d57sm1071861qtb.38.2023.11.08.08.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:18 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 14/26] test: spl: Support testing LEGACY_LZMA filesystem
 images
Date: Wed,  8 Nov 2023 11:48:46 -0500
Message-Id: <20231108164858.3497420-15-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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

These will soon be supported, so we need to be able to test it. Export the
lzma data and generally use the same process in spl_test_mmc_fs as
do_spl_test_load.  If we end up needing this in third place in the future,
it would probably be good to refactor things out.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

Changes in v6:
- New

 include/test/spl.h       |  4 ++++
 test/image/spl_load.c    |  4 +++-
 test/image/spl_load_fs.c | 23 ++++++++++++++++++-----
 3 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/test/spl.h b/include/test/spl.h
index c1f64658502..a2a5f33e328 100644
--- a/include/test/spl.h
+++ b/include/test/spl.h
@@ -81,6 +81,10 @@ size_t create_image(void *dst, enum spl_test_image type,
 int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
 		     struct spl_image_info *info2);
 
+/* Some compressed data and it size */
+extern const char lzma_compressed[];
+extern const size_t lzma_compressed_size;
+
 /**
  * typedef write_image_t - Callback for writing an image
  * @uts: Current unit test state
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 35ceed67756..e1036eff28c 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -374,7 +374,7 @@ SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
  * LZMA is too complex to generate on the fly, so let's use some data I put in
  * the oven^H^H^H^H compressed earlier
  */
-static const char lzma_compressed[] = {
+const char lzma_compressed[] = {
 	0x5d, 0x00, 0x00, 0x80, 0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
 	0xff, 0x00, 0x02, 0x05, 0x55, 0x4e, 0x82, 0xbc, 0xc2, 0x42, 0xf6, 0x88,
 	0x6c, 0x99, 0xd6, 0x82, 0x48, 0xa6, 0x06, 0x67, 0xf8, 0x46, 0x7c, 0xe9,
@@ -610,6 +610,8 @@ static const char lzma_compressed[] = {
 	0x1e, 0xff, 0xff, 0x80, 0x8e, 0x00, 0x00
 };
 
+const size_t lzma_compressed_size = sizeof(lzma_compressed);
+
 int do_spl_test_load(struct unit_test_state *uts, const char *test_name,
 		     enum spl_test_image type, struct spl_image_loader *loader,
 		     int (*write_image)(struct unit_test_state *, void *, size_t))
diff --git a/test/image/spl_load_fs.c b/test/image/spl_load_fs.c
index 297ab08a820..59d0244d44b 100644
--- a/test/image/spl_load_fs.c
+++ b/test/image/spl_load_fs.c
@@ -320,10 +320,11 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
 	struct blk_desc *dev_desc;
 	size_t fs_size, fs_data, img_size, img_data,
-	       data_size = SPL_TEST_DATA_SIZE;
+	       plain_size = SPL_TEST_DATA_SIZE;
 	struct spl_image_info info_write = {
 		.name = test_name,
-		.size = data_size,
+		.size = type == LEGACY_LZMA ? lzma_compressed_size :
+					      plain_size,
 	}, info_read = { };
 	struct disk_partition part = {
 		.start = 1,
@@ -335,7 +336,7 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 		.boot_device = loader->boot_device,
 	};
 	void *fs;
-	char *data;
+	char *data, *plain;
 
 	img_size = create_image(NULL, type, &info_write, &img_data);
 	ut_assert(img_size);
@@ -345,7 +346,15 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 	ut_assertnonnull(fs);
 
 	data = fs + fs_data + img_data;
-	generate_data(data, data_size, test_name);
+	if (type == LEGACY_LZMA) {
+		plain = malloc(plain_size);
+		ut_assertnonnull(plain);
+		generate_data(plain, plain_size, "lzma");
+		memcpy(data, lzma_compressed, lzma_compressed_size);
+	} else {
+		plain = data;
+		generate_data(plain, plain_size, test_name);
+	}
 	ut_asserteq(img_size, create_image(fs + fs_data, type, &info_write,
 					   NULL));
 	ut_asserteq(fs_size, create_fs(fs, img_size, filename, NULL));
@@ -366,8 +375,12 @@ static int spl_test_mmc_fs(struct unit_test_state *uts, const char *test_name,
 		ut_assertok(loader->load_image(&info_read, &bootdev));
 	if (check_image_info(uts, &info_write, &info_read))
 		return CMD_RET_FAILURE;
-	ut_asserteq_mem(data, phys_to_virt(info_write.load_addr), data_size);
+	if (type == LEGACY_LZMA)
+		ut_asserteq(plain_size, info_read.size);
+	ut_asserteq_mem(plain, phys_to_virt(info_write.load_addr), plain_size);
 
+	if (type == LEGACY_LZMA)
+		free(plain);
 	free(fs);
 	return 0;
 }
-- 
2.37.1

