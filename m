Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2738CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:41:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D54C286DBC;
	Sun, 15 Oct 2023 09:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NyjF0kIv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82A7986D2D; Sun, 15 Oct 2023 09:07:00 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6992286F85
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:05:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7757523362fso240211285a.0
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697353549; x=1697958349; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJHtiJYAU6j5hGrxQNpk2VkTTXRkRRf+EjWPrOdw6ZY=;
 b=NyjF0kIvop0uKJFSEl1ehQb/SNJdcnDj7AXQWwunt/B9sLyC5T6HidF6a9xe9I23iI
 +sTHXQIEfzgG/WAff5Tp44NeiqzhC1f9G/DdRAEsaDqTjWyMgJzQkPYr/ywBmopg+6nj
 76etqUaHKM2q7NcOKzMsKhqvTYcyDixYuO4J9nmz3HUfdC3hJmkEzzzol/eMdyEWrkke
 Tn6phQUkeJ2+qUTNkd27xY5qgBtTueFSbJGWAu5dIZ9mhUWNOP7//mYfhrxBcJEgWTRB
 AT6yh9hWWGwqUFr33KmHITaXoJrpjFqofSRr1Py5WNB3tlpQIdMtcDHOeNdILjD7HfxN
 eRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697353549; x=1697958349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJHtiJYAU6j5hGrxQNpk2VkTTXRkRRf+EjWPrOdw6ZY=;
 b=PCdI2ueqG4iJXx0MiF0sGbSPIVUWWBT6fqP++3IU0AXwrPqVsYODAwYEG3yOgZn8oo
 pHO97XKezfyVdgX9Hr5h2E4gaLF9ZSeBBitbVFKoTMNtc5XskvFyliABqypqGXTwVZKR
 j9N9JYkz8Bvjctvt7xJA5IwSTt5fZa0Z992jxHh25mi/e2kKUAJDQulOE43YSeqOWFAv
 rSNK+zZBgcrZ1EU1wu7DBn7mUftHUqNdfqnJ4N07CmbQDIjLWgRZ/Moc9UoxSQGF3g01
 vbLqwjiUIG6F02DN2G8whnJraOVBjz93l3LiOLF63arLjTbJm/RPWc8DOIQK7KYMDmve
 u1Sg==
X-Gm-Message-State: AOJu0YytXF6jrprwZIkuxkB3W+xXgV2nwDS/qyiPQoBPm86VX8WHcq5t
 nWkMQvUgf0BOVLmt/SmLnm2v6dXrSOQKVQ==
X-Google-Smtp-Source: AGHT+IEAiKDB7oZrbaENDGTiKZQZ0z4uviDEFoJRV+Ic4rogclAXoCVAZ1TzXHrmbbhail2SLUQPUA==
X-Received: by 2002:a05:620a:1aa5:b0:76f:9e:4f0 with SMTP id
 bl37-20020a05620a1aa500b0076f009e04f0mr34936808qkb.58.1697316513574; 
 Sat, 14 Oct 2023 13:48:33 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 u15-20020a05620a120f00b007677347e20asm1709191qkj.129.2023.10.14.13.48.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:33 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 23/29] test: spl: Add functions to create images
Date: Sat, 14 Oct 2023 16:47:59 -0400
Message-Id: <20231014204805.439009-24-seanga2@gmail.com>
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

This add some basic functions to create images, and a test for said
functions. This is not intended to be a test of the image parsing
functions, but rather a framework for creating minimal images for testing
load methods. That said, it does do an OK job at finding bugs in the image
parsing directly.

Since we have two methods for loading/parsing FIT images, add LOAD_FIT_FULL
as a separate CI run.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Fix size not being updated in board_spl_fit_buffer_addr
- Fix return value documentation for check_image_info

 .azure-pipelines.yml             |   4 +
 .gitlab-ci.yml                   |   7 +
 arch/sandbox/cpu/u-boot-spl.lds  |   2 +
 configs/sandbox_noinst_defconfig |   6 +
 configs/sandbox_spl_defconfig    |   6 +
 include/test/spl.h               | 117 +++++++++++
 test/image/spl_load.c            | 350 +++++++++++++++++++++++++++++++
 test/image/spl_load_os.c         |   4 +-
 8 files changed, 493 insertions(+), 3 deletions(-)
 create mode 100644 include/test/spl.h

diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
index 7985ff5523c..6f91553e861 100644
--- a/.azure-pipelines.yml
+++ b/.azure-pipelines.yml
@@ -299,6 +299,10 @@ stages:
         sandbox_noinst:
           TEST_PY_BD: "sandbox_noinst"
           TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
+        sandbox_noinst_load_fit_full:
+          TEST_PY_BD: "sandbox_noinst"
+          TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
+          OVERRIDE: "-a CONFIG_SPL_LOAD_FIT_FULL=y"
         sandbox_flattree:
           TEST_PY_BD: "sandbox_flattree"
         sandbox_trace:
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 129234ba3db..6decdfdee33 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -293,6 +293,13 @@ sandbox_noinst_test.py:
     TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
   <<: *buildman_and_testpy_dfn
 
+sandbox_noinst with LOAD_FIT_FULL test.py:
+  variables:
+    TEST_PY_BD: "sandbox_noinst"
+    TEST_PY_TEST_SPEC: "test_ofplatdata or test_handoff or test_spl"
+    OVERRIDE: "-a CONFIG_SPL_LOAD_FIT_FULL=y"
+  <<: *buildman_and_testpy_dfn
+
 sandbox_vpl test.py:
   variables:
     TEST_PY_BD: "sandbox_vpl"
diff --git a/arch/sandbox/cpu/u-boot-spl.lds b/arch/sandbox/cpu/u-boot-spl.lds
index ef885fd0cb0..a81d66a6f2e 100644
--- a/arch/sandbox/cpu/u-boot-spl.lds
+++ b/arch/sandbox/cpu/u-boot-spl.lds
@@ -26,6 +26,8 @@ SECTIONS
 		KEEP(*(_u_boot_sandbox_getopt))
 		*(_u_boot_sandbox_getopt_end)
 	}
+
+	_image_binary_end = .;
 }
 
 INSERT AFTER .data;
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index d39e54f98d2..908155be8a3 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -32,6 +32,12 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_RTC=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 4a67af2f088..b578cc8e443 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -32,6 +32,12 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_HANDOFF=y
 CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LEGACY_IMAGE_FORMAT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0xa000000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x4000000
 CONFIG_SPL_ENV_SUPPORT=y
 CONFIG_SPL_FPGA=y
 CONFIG_SPL_I2C=y
diff --git a/include/test/spl.h b/include/test/spl.h
new file mode 100644
index 00000000000..4c6b789e478
--- /dev/null
+++ b/include/test/spl.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023 Sean Anderson <seanga2@gmail.com>
+ */
+
+#ifndef TEST_SPL_H
+#define TEST_SPL_H
+
+struct unit_test_state;
+struct spl_image_info;
+
+/* Declare a new SPL test */
+#define SPL_TEST(_name, _flags)		UNIT_TEST(_name, _flags, spl_test)
+
+/**
+ * generate_data() - Generate some test payload data
+ * @data: The location to fill
+ * @size: The size of @data
+ * @test_name: The seed for the data
+ *
+ * Fill @data with data. The upper nibbles will be an incrementing counter
+ * (0x00, 0x10, 0x20...) to make the data identifiable in a hex dump. The lower
+ * nibbles are random bits seeded with @test_name.
+ */
+void generate_data(char *data, size_t size, const char *test_name);
+
+/**
+ * enum spl_test_image - Image types for testing
+ * @LEGACY: "Legacy" uImages
+ * @IMX8: i.MX8 Container images
+ * @FIT_INTERNAL: FITs with internal data
+ * @FIT_EXTERNAL: FITs with external data
+ */
+enum spl_test_image {
+	LEGACY,
+	IMX8,
+	FIT_INTERNAL,
+	FIT_EXTERNAL,
+};
+
+/**
+ * create_image() - Create an image for testing
+ * @dst: The location to create the image at
+ * @type: The type of image to create
+ * @info: Image parameters
+ * @data_offset: Offset of payload data within the image
+ *
+ * Create a new image at @dst. @dst must be initialized to all zeros. @info
+ * should already have name and size filled in. All other parameters will be
+ * filled in by this function. @info can later be passed to check_image_info().
+ *
+ * If @dst is %NULL, then no data is written. Otherwise, @dst must be
+ * initialized to zeros, except payload data which must already be present at
+ * @data_offset. @data_offset may be %NULL if unnecessary.
+ *
+ * Typically, this function will be called as follows:
+ *
+ *     size = create_image(NULL, type, &info, &off);
+ *     img = calloc(size, 1);
+ *     generate_data(img + off, ...);
+ *     create_image(img, type, &info, NULL);
+ *
+ * Return: The size of the image, or 0 on error
+ */
+size_t create_image(void *dst, enum spl_test_image type,
+		    struct spl_image_info *info, size_t *data_offset);
+
+/**
+ * check_image_info() - Check image info after loading
+ * @uts: Current unit test state
+ * @info1: The base, known good info
+ * @info2: The info to check
+ *
+ * Check @info2 against @info1. This function is typically called after calling
+ * a function to load/parse an image. Image data is not checked.
+ *
+ * Return: 0 on success, or 1 on failure
+ */
+int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
+		     struct spl_image_info *info2);
+
+/**
+ * image_supported() - Determine whether an image type is supported
+ * @type: The image type to check
+ *
+ * Return: %true if supported and %false otherwise
+ */
+static inline bool image_supported(enum spl_test_image type)
+{
+	switch (type) {
+	case LEGACY:
+		return IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT);
+	case IMX8:
+		return IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER);
+	case FIT_INTERNAL:
+	case FIT_EXTERNAL:
+		return IS_ENABLED(CONFIG_SPL_LOAD_FIT) ||
+		       IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL);
+	}
+
+	return false;
+}
+
+/* Declare an image test (skipped if the image type is unsupported) */
+#define SPL_IMG_TEST(func, type, flags) \
+static int func##_##type(struct unit_test_state *uts) \
+{ \
+	if (!image_supported(type)) \
+		return -EAGAIN; \
+	return func(uts, __func__, type); \
+} \
+SPL_TEST(func##_##type, flags)
+
+/* More than a couple blocks, and will not be aligned to anything */
+#define SPL_TEST_DATA_SIZE	4099
+
+#endif /* TEST_SPL_H */
diff --git a/test/image/spl_load.c b/test/image/spl_load.c
index 1a57bf846d2..de2fddae359 100644
--- a/test/image/spl_load.c
+++ b/test/image/spl_load.c
@@ -4,7 +4,15 @@
  */
 
 #include <common.h>
+#include <image.h>
+#include <imx_container.h>
 #include <mapmem.h>
+#include <memalign.h>
+#include <rand.h>
+#include <spl.h>
+#include <test/spl.h>
+#include <test/ut.h>
+#include <u-boot/crc.h>
 
 int board_fit_config_name_match(const char *name)
 {
@@ -15,3 +23,345 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
 {
 	return map_sysmem(0x100000, 0);
 }
+
+/* Try to reuse the load buffer to conserve memory */
+void *board_spl_fit_buffer_addr(ulong fit_size, int sectors, int bl_len)
+{
+	static void *buf;
+	static size_t size;
+
+	if (size < sectors * bl_len) {
+		free(buf);
+		size = sectors * bl_len;
+		buf = malloc_cache_aligned(size);
+	}
+	return buf;
+}
+
+/* Local flags for spl_image; start from the "top" to avoid conflicts */
+#define SPL_IMX_CONTAINER	0x80000000
+
+void generate_data(char *data, size_t size, const char *test_name)
+{
+	int i;
+	unsigned int seed = 1;
+
+	while (*test_name) {
+		seed += *test_name++;
+		rand_r(&seed);
+	}
+
+	for (i = 0; i < size; i++)
+		data[i] = (i & 0xf) << 4 | (rand_r(&seed) & 0xf);
+}
+
+static size_t create_legacy(void *dst, struct spl_image_info *spl_image,
+			    size_t *data_offset)
+{
+	struct legacy_img_hdr *hdr = dst;
+	void *data = dst + sizeof(*hdr);
+
+	if (data_offset)
+		*data_offset = data - dst;
+
+	if (!dst)
+		goto out;
+
+	image_set_magic(hdr, IH_MAGIC);
+	image_set_time(hdr, 0);
+	image_set_size(hdr, spl_image->size);
+	image_set_load(hdr, spl_image->load_addr);
+	image_set_ep(hdr, spl_image->entry_point);
+	image_set_dcrc(hdr, crc32(0, data, spl_image->size));
+	image_set_os(hdr, spl_image->os);
+	image_set_arch(hdr, IH_ARCH_DEFAULT);
+	image_set_type(hdr, IH_TYPE_FIRMWARE);
+	image_set_comp(hdr, IH_COMP_NONE);
+	image_set_name(hdr, spl_image->name);
+	image_set_hcrc(hdr, crc32(0, (void *)hdr, sizeof(*hdr)));
+
+out:
+	return sizeof(*hdr) + spl_image->size;
+}
+
+static size_t create_imx8(void *dst, struct spl_image_info *spl_image,
+			  size_t *data_offset)
+{
+	struct container_hdr *hdr = dst;
+	struct boot_img_t *img = dst + sizeof(*hdr);
+	size_t length = sizeof(*hdr) + sizeof(*img);
+	/* Align to MMC block size for now */
+	void *data = dst + 512;
+
+	if (data_offset)
+		*data_offset = data - dst;
+
+	if (!dst)
+		goto out;
+
+	hdr->version = CONTAINER_HDR_VERSION;
+	hdr->length_lsb = length & 0xff;
+	hdr->length_msb = length >> 8;
+	hdr->tag = CONTAINER_HDR_TAG;
+	hdr->num_images = 1;
+
+	/* spl_load_imx_container doesn't handle endianness; whoops! */
+	img->offset = data - dst;
+	img->size = spl_image->size;
+	img->dst = spl_image->load_addr;
+	img->entry = spl_image->entry_point;
+
+out:
+	return data - dst + spl_image->size;
+}
+
+#define ADDRESS_CELLS (sizeof(uintptr_t) / sizeof(u32))
+
+static inline int fdt_property_addr(void *fdt, const char *name, uintptr_t val)
+{
+	if (sizeof(uintptr_t) == sizeof(u32))
+		return fdt_property_u32(fdt, name, val);
+	return fdt_property_u64(fdt, name, val);
+}
+
+static size_t start_fit(void *dst, size_t fit_size, size_t data_size,
+			bool external)
+{
+	void *data;
+
+	if (fdt_create(dst, fit_size))
+		return 0;
+	if (fdt_finish_reservemap(dst))
+		return 0;
+	if (fdt_begin_node(dst, ""))
+		return 0;
+	if (fdt_property_u32(dst, FIT_TIMESTAMP_PROP, 0))
+		return 0;
+	if (fdt_property_u32(dst, "#address-cells", ADDRESS_CELLS))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, ""))
+		return 0;
+
+	if (fdt_begin_node(dst, "images"))
+		return 0;
+	if (fdt_begin_node(dst, "u-boot"))
+		return 0;
+
+	if (external) {
+		if (fdt_property_u32(dst, FIT_DATA_OFFSET_PROP, 0))
+			return 0;
+		return fit_size;
+	}
+
+	if (fdt_property_placeholder(dst, FIT_DATA_PROP, data_size, &data))
+		return 0;
+	return data - dst;
+}
+
+static size_t create_fit(void *dst, struct spl_image_info *spl_image,
+			 size_t *data_offset, bool external)
+{
+	size_t prop_size = 596, total_size = prop_size + spl_image->size;
+	size_t off, size;
+
+	if (external) {
+		size = prop_size;
+		off = size;
+	} else {
+		char tmp[256];
+
+		size = total_size;
+		off = start_fit(tmp, sizeof(tmp), 0, false);
+		if (!off)
+			return 0;
+	}
+
+	if (data_offset)
+		*data_offset = off;
+
+	if (!dst)
+		goto out;
+
+	if (start_fit(dst, size, spl_image->size, external) != off)
+		return 0;
+
+	if (fdt_property_string(dst, FIT_DESC_PROP, spl_image->name))
+		return 0;
+	if (fdt_property_string(dst, FIT_TYPE_PROP, "firmware"))
+		return 0;
+	if (fdt_property_string(dst, FIT_COMP_PROP, "none"))
+		return 0;
+	if (fdt_property_u32(dst, FIT_DATA_SIZE_PROP, spl_image->size))
+		return 0;
+	if (fdt_property_string(dst, FIT_OS_PROP,
+				genimg_get_os_short_name(spl_image->os)))
+		return 0;
+	if (fdt_property_string(dst, FIT_ARCH_PROP,
+				genimg_get_arch_short_name(IH_ARCH_DEFAULT)))
+		return 0;
+	if (fdt_property_addr(dst, FIT_ENTRY_PROP, spl_image->entry_point))
+		return 0;
+	if (fdt_property_addr(dst, FIT_LOAD_PROP, spl_image->load_addr))
+		return 0;
+	if (fdt_end_node(dst)) /* u-boot */
+		return 0;
+	if (fdt_end_node(dst)) /* images */
+		return 0;
+
+	if (fdt_begin_node(dst, "configurations"))
+		return 0;
+	if (fdt_property_string(dst, FIT_DEFAULT_PROP, "config-1"))
+		return 0;
+	if (fdt_begin_node(dst, "config-1"))
+		return 0;
+	if (fdt_property_string(dst, FIT_DESC_PROP, spl_image->name))
+		return 0;
+	if (fdt_property_string(dst, FIT_FIRMWARE_PROP, "u-boot"))
+		return 0;
+	if (fdt_end_node(dst)) /* configurations */
+		return 0;
+	if (fdt_end_node(dst)) /* config-1 */
+		return 0;
+
+	if (fdt_end_node(dst)) /* root */
+		return 0;
+	if (fdt_finish(dst))
+		return 0;
+
+	if (external) {
+		if (fdt_totalsize(dst) > size)
+			return 0;
+		fdt_set_totalsize(dst, size);
+	}
+
+out:
+	return total_size;
+}
+
+size_t create_image(void *dst, enum spl_test_image type,
+		    struct spl_image_info *info, size_t *data_offset)
+{
+	bool external = false;
+
+	info->os = IH_OS_U_BOOT;
+	info->load_addr = CONFIG_TEXT_BASE;
+	info->entry_point = CONFIG_TEXT_BASE + 0x100;
+	info->flags = 0;
+
+	switch (type) {
+	case LEGACY:
+		return create_legacy(dst, info, data_offset);
+	case IMX8:
+		info->flags = SPL_IMX_CONTAINER;
+		return create_imx8(dst, info, data_offset);
+	case FIT_EXTERNAL:
+		/*
+		 * spl_fit_append_fdt will clobber external images with U-Boot's
+		 * FDT if the image doesn't have one. Just set the OS to
+		 * something which doesn't take a devicetree.
+		 */
+		if (!IS_ENABLED(CONFIG_LOAD_FIT_FULL))
+			info->os = IH_OS_TEE;
+		external = true;
+	case FIT_INTERNAL:
+		info->flags = SPL_FIT_FOUND;
+		return create_fit(dst, info, data_offset, external);
+	}
+
+	return 0;
+}
+
+int check_image_info(struct unit_test_state *uts, struct spl_image_info *info1,
+		     struct spl_image_info *info2)
+{
+	if (info2->name) {
+		if (info1->flags & SPL_FIT_FOUND)
+			ut_asserteq_str(genimg_get_os_name(info1->os),
+					info2->name);
+		else
+			ut_asserteq_str(info1->name, info2->name);
+	}
+
+	if (info1->flags & SPL_IMX_CONTAINER)
+		ut_asserteq(IH_OS_INVALID, info2->os);
+	else
+		ut_asserteq(info1->os, info2->os);
+
+	ut_asserteq(info1->entry_point, info2->entry_point);
+	if (info1->flags & (SPL_FIT_FOUND | SPL_IMX_CONTAINER) ||
+	    info2->flags & SPL_COPY_PAYLOAD_ONLY) {
+		ut_asserteq(info1->load_addr, info2->load_addr);
+		if (info1->flags & SPL_IMX_CONTAINER)
+			ut_asserteq(0, info2->size);
+		else
+			ut_asserteq(info1->size, info2->size);
+	} else {
+		ut_asserteq(info1->load_addr - sizeof(struct legacy_img_hdr),
+			    info2->load_addr);
+		ut_asserteq(info1->size + sizeof(struct legacy_img_hdr),
+			    info2->size);
+	}
+
+	return 0;
+}
+
+static ulong spl_test_read(struct spl_load_info *load, ulong sector,
+			   ulong count, void *buf)
+{
+	memcpy(buf, load->priv + sector, count);
+	return count;
+}
+
+static int spl_test_image(struct unit_test_state *uts, const char *test_name,
+			  enum spl_test_image type)
+{
+	size_t img_size, img_data, data_size = SPL_TEST_DATA_SIZE;
+	struct spl_image_info info_write = {
+		.name = test_name,
+		.size = data_size,
+	}, info_read = { };
+	char *data;
+	void *img;
+
+	img_size = create_image(NULL, type, &info_write, &img_data);
+	ut_assert(img_size);
+	img = calloc(img_size, 1);
+	ut_assertnonnull(img);
+
+	data = img + img_data;
+	generate_data(data, data_size, test_name);
+	ut_asserteq(img_size, create_image(img, type, &info_write, NULL));
+
+	if (type == LEGACY) {
+		ut_assertok(spl_parse_image_header(&info_read, NULL, img));
+		if (check_image_info(uts, &info_write, &info_read))
+			return CMD_RET_FAILURE;
+	} else {
+		struct spl_load_info load = {
+			.bl_len = 1,
+			.priv = img,
+			.read = spl_test_read,
+		};
+
+		if (type == IMX8)
+			ut_assertok(spl_load_imx_container(&info_read, &load,
+							   0));
+		else if (IS_ENABLED(CONFIG_SPL_FIT_FULL))
+			ut_assertok(spl_parse_image_header(&info_read, NULL,
+							   img));
+		else
+			ut_assertok(spl_load_simple_fit(&info_read, &load, 0,
+							img));
+		if (check_image_info(uts, &info_write, &info_read))
+			return CMD_RET_FAILURE;
+		ut_asserteq_mem(data, phys_to_virt(info_write.load_addr),
+				data_size);
+	}
+
+	free(img);
+	return 0;
+}
+SPL_IMG_TEST(spl_test_image, LEGACY, 0);
+SPL_IMG_TEST(spl_test_image, IMX8, 0);
+SPL_IMG_TEST(spl_test_image, FIT_INTERNAL, 0);
+SPL_IMG_TEST(spl_test_image, FIT_EXTERNAL, 0);
diff --git a/test/image/spl_load_os.c b/test/image/spl_load_os.c
index 3b2967d017a..49edf152d78 100644
--- a/test/image/spl_load_os.c
+++ b/test/image/spl_load_os.c
@@ -8,11 +8,9 @@
 #include <image.h>
 #include <os.h>
 #include <spl.h>
+#include <test/spl.h>
 #include <test/ut.h>
 
-/* Declare a new SPL test */
-#define SPL_TEST(_name, _flags)		UNIT_TEST(_name, _flags, spl_test)
-
 /* Context used for this test */
 struct text_ctx {
 	int fd;
-- 
2.37.1

