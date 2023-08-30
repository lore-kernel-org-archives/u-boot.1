Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2599CC83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9948E86562;
	Thu, 31 Aug 2023 01:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="epdHjk+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B578655E; Thu, 31 Aug 2023 01:30:06 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BD58652B
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7928ba24936so12215639f.0
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438201; x=1694043001; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUTT/xxxvSbKOHtyv8Pzbor4MySaZ9sOW7DuC/jsTN4=;
 b=epdHjk+zJVi5bkFeCAWxiBBccSLQEQUjGxGTlETFUl4Y+FpwjXTudig4OETG7iJVAa
 r3a1f9dyq+JAN2fFWyJr2OOomJRFgsRU78yzRSlyOvNHALUgxjRW6Oq9+2ir/8/RZSw/
 ISp2mMqXwoPW5Gjs0noxBCCaZwpjLK3BZftlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438201; x=1694043001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUTT/xxxvSbKOHtyv8Pzbor4MySaZ9sOW7DuC/jsTN4=;
 b=LyEK4QealptCLESxeTMva8blBpVMLA0erL4Tgd/SC+DaGliD3l0oFlSTLj/tvQbdIS
 htKTZn9lphV4nvp2bPuHR8eeq/Ys/rT/nuPr+CzRposGhBF4IhG68SlWTIQWdRhj+2w2
 K2YqZBN9Jbv1bSbyDmoii/8m3dFCHXmtZ+DL3lu3pxH7BcLfOqSd8IByNfkvSE/9qsBQ
 ISJIQ+WC+5dAqGQ16BMh2letEU8ihjMn/LA+P02xk/6cI90wLI5r380sXSXh6AkU9INP
 bV6mXwGdO4nwk8M+p5TLUvp0EoQfzNI7W5pYz+GGZaE/r8s88snsYWgqAjCAVqBA0cUR
 BKuw==
X-Gm-Message-State: AOJu0YzlPbFJK94KegR+PAmsegdpkdv2OzxVL3cI9STbPfRU8Kbp6Oxs
 zFmbmhVxswKiWB2PCPOJjqEgNncKhZbaN4/ankY=
X-Google-Smtp-Source: AGHT+IHcwJDtBCTlIMHGQss5MvDV+9NbHReFrZtH1QHZnEtaaXefdJ3cu2/b6ZtnDBo5HxEiha3XZQ==
X-Received: by 2002:a6b:d80c:0:b0:795:13ea:477a with SMTP id
 y12-20020a6bd80c000000b0079513ea477amr4250763iob.8.1693438201211; 
 Wed, 30 Aug 2023 16:30:01 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH 1/9] upl: Add support for reading a upl handoff
Date: Wed, 30 Aug 2023 17:29:15 -0600
Message-ID: <20230830232928.2590178-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830232928.2590178-1-sjg@chromium.org>
References: <20230830232928.2590178-1-sjg@chromium.org>
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

Universal Payload provides a standard way of handing off control between
two firmware phases. Add support for reading the handoff information into
a structure.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig              |  21 +-
 boot/Makefile             |   3 +
 boot/upl_common.c         |  51 ++++
 boot/upl_common.h         |  24 ++
 boot/upl_read.c           | 607 ++++++++++++++++++++++++++++++++++++++
 configs/sandbox_defconfig |   6 +-
 include/upl.h             | 361 +++++++++++++++++++++++
 7 files changed, 1069 insertions(+), 4 deletions(-)
 create mode 100644 boot/upl_common.c
 create mode 100644 boot/upl_common.h
 create mode 100644 boot/upl_read.c
 create mode 100644 include/upl.h

diff --git a/boot/Kconfig b/boot/Kconfig
index 86ccfd78031..e4625cc5fcb 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -676,7 +676,26 @@ config BOOTMETH_SCRIPT
 	  This provides a way to try out standard boot on an existing boot flow.
 	  It is not enabled by default to save space.
 
-endif
+config UPL
+	bool "upl - Universal Payload Specification"
+	imply UPL_READ
+	help
+	  Provides support for UPL payloads and handoff information. U-Boot
+	  supports generating and accepting handoff information. The mkimage
+	  tool will eventually support creating payloads.
+
+if UPL
+
+config UPL_READ
+	bool "upl - Support reading a Universal Payload handoff"
+	help
+	  Provides support for decoding a UPL-format payload into a C structure
+	  which can be used elsewhere in U-Boot. This is just the reading
+	  implementation, useful for trying it out.
+
+endif  # UPL
+
+endif  # BOOTSTD
 
 config LEGACY_IMAGE_FORMAT
 	bool "Enable support for the legacy image format"
diff --git a/boot/Makefile b/boot/Makefile
index 10f01572237..e50f3f91430 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -37,6 +37,9 @@ obj-$(CONFIG_$(SPL_TPL_)BOOTSTD) += bootflow_menu.o
 obj-$(CONFIG_$(SPL_TPL_)CEDIT) += cedit.o
 endif
 
+obj-$(CONFIG_$(SPL_TPL_)UPL) += upl_common.o
+obj-$(CONFIG_$(SPL_TPL_)UPL_READ) += upl_read.o
+
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
 obj-$(CONFIG_$(SPL_TPL_)FIT) += image-fit.o
diff --git a/boot/upl_common.c b/boot/upl_common.c
new file mode 100644
index 00000000000..a541d14b387
--- /dev/null
+++ b/boot/upl_common.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff command functions
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <common.h>
+#include <upl.h>
+
+/* Names of bootmodes */
+const char *const bootmode_names[UPLBM_COUNT] = {
+	[UPLBM_FULL]	= "full",
+	[UPLBM_MINIMAL]	= "minimal",
+	[UPLBM_FAST]	= "fast",
+	[UPLBM_DIAG]	= "diag",
+	[UPLBM_DEFAULT]	= "default",
+	[UPLBM_S2]	= "s2",
+	[UPLBM_S3]	= "s3",
+	[UPLBM_S4]	= "s4",
+	[UPLBM_S5]	= "s5",
+	[UPLBM_FACTORY]	= "factory",
+	[UPLBM_FLASH]	= "flash",
+	[UPLBM_RECOVERY] = "recovery",
+};
+
+/* Names of memory usages */
+const char *const usage_names[UPLUS_COUNT] = {
+	[UPLUS_ACPI_RECLAIM]	= "acpi-reclaim",
+	[UPLUS_ACPI_NVS]	= "acpi-nvs",
+	[UPLUS_BOOT_CODE]	= "boot-code",
+	[UPLUS_BOOT_DATA]	= "boot-data",
+	[UPLUS_RUNTIME_CODE]	= "runtime-code",
+	[UPLUS_RUNTIME_DATA]	= "runtime-data",
+};
+
+/* Names of access types */
+const char *const access_types[UPLUS_COUNT] = {
+	[UPLAT_MMIO]	= "mmio",
+	[UPLAT_IO]	= "io",
+};
+
+/* Names of graphics formats */
+const char *const graphics_formats[UPLUS_COUNT] = {
+	[UPLGF_ARGB32]	= "a8r8g8b8",
+	[UPLGF_ABGR32]	= "a8b8g8r8",
+	[UPLGF_ABGR64]	= "a16b16g16r16",
+};
diff --git a/boot/upl_common.h b/boot/upl_common.h
new file mode 100644
index 00000000000..0f134c0393f
--- /dev/null
+++ b/boot/upl_common.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * UPL handoff command functions
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __UPL_COMMON_H
+#define __UPL_COMMON_H
+
+/* Names of bootmodes */
+extern const char *const bootmode_names[UPLBM_COUNT];
+
+/* Names of memory usages */
+extern const char *const usage_names[UPLUS_COUNT];
+
+/* Names of access types */
+extern const char *const access_types[UPLUS_COUNT];
+
+/* Names of graphics formats */
+extern const char *const graphics_formats[UPLUS_COUNT];
+
+#endif /* __UPL_COMMON_H */
diff --git a/boot/upl_read.c b/boot/upl_read.c
new file mode 100644
index 00000000000..4d7c9602fcf
--- /dev/null
+++ b/boot/upl_read.c
@@ -0,0 +1,607 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff parsing
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <common.h>
+#include <log.h>
+#include <upl.h>
+#include <dm/ofnode.h>
+#include "upl_common.h"
+
+/**
+ * read_addr() - Read an address
+ *
+ * Reads an address in the correct format, either 32- or 64-bit
+ *
+ * @upl: UPL state
+ * @node: Node to read from
+ * @prop: Property name to read
+ * @addr: Place to put the address
+ * Return: 0 if OK, -ve on error
+ */
+static int read_addr(const struct upl *upl, ofnode node, const char *prop,
+		     ulong *addrp)
+{
+	int ret;
+
+	if (upl->addr_cells == 1) {
+		u32 val;
+
+		ret = ofnode_read_u32(node, prop, &val);
+		if (!ret)
+			*addrp = val;
+	} else {
+		u64 val;
+
+		ret = ofnode_read_u64(node, prop, &val);
+		if (!ret)
+			*addrp = val;
+	}
+
+	return ret;
+}
+
+/**
+ * read_size() - Read a size
+ *
+ * Reads a size in the correct format, either 32- or 64-bit
+ *
+ * @upl: UPL state
+ * @node: Node to read from
+ * @prop: Property name to read
+ * @addr: Place to put the size
+ * Return: 0 if OK, -ve on error
+ */
+static int read_size(const struct upl *upl, ofnode node, const char *prop,
+		     ulong *sizep)
+{
+	int ret;
+
+	if (upl->size_cells == 1) {
+		u32 val;
+
+		ret = ofnode_read_u32(node, prop, &val);
+		if (!ret)
+			*sizep = val;
+	} else {
+		u64 val;
+
+		ret = ofnode_read_u64(node, prop, &val);
+		if (!ret)
+			*sizep = val;
+	}
+
+	return ret;
+}
+
+/**
+ * ofnode_read_bitmask() - Read a bit mask from a string list
+ *
+ * @node: Node to read from
+ * @prop: Property name to read
+ * @names: Array of names for each bit
+ * @count: Number of array entries
+ * @value: Returns resulting bit-mask value on success
+ * Return: 0 if OK, -EINVAL if a bit number is not defined, -ENOSPC if the
+ * string is too long for the (internal) buffer, -EINVAL if no such property
+ */
+static int ofnode_read_bitmask(ofnode node, const char *prop,
+			       const char *const names[], uint count,
+			       uint *valuep)
+{
+	const char **list;
+	const char **strp;
+	uint val;
+	uint bit;
+	int ret;
+
+	ret = ofnode_read_string_list(node, prop, &list);
+	if (ret < 0)
+		return log_msg_ret("rea", ret);
+
+	val = 0;
+	for (strp = list; *strp; strp++) {
+		const char *str = *strp;
+		bool found = false;
+
+		for (bit = 0; bit < count; bit++) {
+			if (!strcmp(str, names[bit])) {
+				found = true;
+				break;
+			}
+		}
+		if (found)
+			val |= BIT(bit);
+		else
+			log_warning("%s/%s: Invalid value '%s'\n",
+				    ofnode_get_name(node), prop, str);
+	}
+	*valuep = val;
+
+	return 0;
+}
+
+/**
+ * ofnode_read_value() - Read a string value as an int using a lookup
+ *
+ * @node: Node to read from
+ * @prop: Property name to read
+ * @names: Array of names for each int value
+ * @count: Number of array entries
+ * @valuep: Returns int value read
+ * Return: 0 if OK, -EINVAL if a bit number is not defined, -ENOENT if the
+ * property does not exist
+ */
+static int ofnode_read_value(ofnode node, const char *prop,
+			     const char *const names[], uint count,
+			     uint *valuep)
+{
+	const char *str;
+	int i;
+
+	str = ofnode_read_string(node, prop);
+	if (!str)
+		return log_msg_ret("rd", -ENOENT);
+
+	for (i = 0; i < count; i++) {
+		if (!strcmp(names[i], str)) {
+			*valuep = i;
+			return 0;
+		}
+	}
+
+	log_debug("Unnamed value '%s'\n", str);
+	return log_msg_ret("val", -EINVAL);
+}
+
+static int read_uint(ofnode node, const char *prop, uint *valp)
+{
+	u32 val;
+	int ret;
+
+	ret = ofnode_read_u32(node, prop, &val);
+	if (ret)
+		return ret;
+	*valp = val;
+
+	return 0;
+}
+
+/**
+ * decode_root_props() - Decode root properties from the tree
+ *
+ * @upl: UPL state
+ * @node: Node to decode
+ * Return 0 if OK, -ve on error
+ */
+static int decode_root_props(struct upl *upl, ofnode node)
+{
+	int ret;
+
+	ret = read_uint(node, UPLP_ADDRESS_CELLS, &upl->addr_cells);
+	if (!ret)
+		ret = read_uint(node, UPLP_SIZE_CELLS, &upl->size_cells);
+	if (ret)
+		return log_msg_ret("cel", ret);
+
+	return 0;
+}
+
+/**
+ * decode_root_props() - Decode UPL parameters from the tree
+ *
+ * @upl: UPL state
+ * @node: Node to decode
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_params(struct upl *upl, ofnode options)
+{
+	ofnode node;
+	int ret;
+
+	node = ofnode_find_subnode(options, UPLN_UPL_PARAMS);
+	if (!ofnode_valid(node))
+		return log_msg_ret("par", -EINVAL);
+	log_debug("decoding '%s'\n", ofnode_get_name(node));
+
+	ret = read_addr(upl, node, UPLP_SMBIOS, &upl->smbios);
+	if (!ret)
+		ret = read_addr(upl, node, UPLP_ACPI, &upl->acpi);
+	if (!ret)
+		ret = ofnode_read_bitmask(node, UPLP_BOOTMODE, bootmode_names,
+					  UPLBM_COUNT, &upl->bootmode);
+	if (!ret)
+		ret = read_uint(node, UPLP_ADDR_WIDTH, &upl->addr_width);
+	if (!ret)
+		ret = read_uint(node, UPLP_ACPI_NVS_SIZE, &upl->acpi_nvs_size);
+	if (ret)
+		return log_msg_ret("cnf", ret);
+
+	return 0;
+}
+
+/**
+ * decode_upl_images() - Decode /options/upl-image nodes
+ *
+ * @node: /options node in which to look for the node
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_images(struct upl *upl, ofnode options)
+{
+	ofnode node, images;
+	int ret;
+
+	images = ofnode_find_subnode(options, UPLN_UPL_IMAGE);
+	if (!ofnode_valid(images))
+		return log_msg_ret("img", -EINVAL);
+	log_debug("decoding '%s'\n", ofnode_get_name(images));
+
+	ret = read_addr(upl, images, UPLP_FIT, &upl->fit);
+	if (!ret)
+		ret = read_uint(images, UPLP_CONF_OFFSET, &upl->conf_offset);
+	if (ret)
+		return log_msg_ret("cnf", ret);
+
+	upl->num_images = 0;
+	ofnode_for_each_subnode(node, images) {
+		struct upl_image *img = &upl->image[upl->num_images];
+
+		if (upl->num_images == UPL_MAX_IMAGES) {
+			log_warning("Too many '%s' nodes (limit %d)\n",
+				    UPLN_UPL_IMAGE, UPL_MAX_IMAGES);
+			return log_msg_ret("ima", -E2BIG);
+		}
+		ret = read_addr(upl, node, UPLP_LOAD, &img->load);
+		if (!ret)
+			ret = read_size(upl, node, UPLP_SIZE, &img->size);
+		if (!ret)
+			ret = read_uint(node, UPLP_OFFSET, &img->offset);
+		img->description = ofnode_read_string(node, UPLP_DESCRIPTION);
+		if (!img->description)
+			return log_msg_ret("sim", ret);
+		upl->num_images++;
+	}
+
+	return 0;
+}
+
+/**
+ * decode_addr_size() - Decide a set of addr/size pairs
+ *
+ * Each base/size value from the devicetree is written to the region list
+ *
+ * @upl: UPL state
+ * @buf: Bytes to decode
+ * @size: Number of bytes to decode
+ * @max_regions: Maximum number of regions permitted
+ * @regions: List of regions to process
+ * @num_regionsp: Returns number of regions found
+ * Returns: number of regions found, if OK, else -ve on error
+ */
+static int decode_addr_size(const struct upl *upl, const char *buf, int size,
+			    uint max_regions, struct memregion *regions)
+{
+	const char *ptr, *end = buf + size;
+	int i;
+
+	ptr = buf;
+	for (i = 0; ptr < end; i++) {
+		struct memregion *reg = &regions[i];
+
+		if (i == max_regions)
+			return log_msg_ret("reg", -ERANGE);
+		if (upl->addr_cells == 1)
+			reg->base = fdt32_to_cpu(*(u32 *)ptr);
+		else
+			reg->base = fdt64_to_cpu(*(u64 *)ptr);
+		ptr += upl->addr_cells * sizeof(u32);
+
+		if (upl->size_cells == 1)
+			reg->size = fdt32_to_cpu(*(u32 *)ptr);
+		else
+			reg->size = fdt64_to_cpu(*(u64 *)ptr);
+		ptr += upl->size_cells * sizeof(u32);
+		if (ptr > end)
+			return -ENOSPC;
+	}
+
+	return i;
+}
+
+/**
+ * node_matches_at() - Check if a node name matches "base@..."
+ *
+ * Return: true if the node name matches the base string followed by an @ sign;
+ * false otherwise
+ */
+static bool node_matches_at(ofnode node, const char *base)
+{
+	const char *name = ofnode_get_name(node);
+	int len = strlen(base);
+
+	return !strncmp(base, name, len) && name[len] == '@';
+}
+
+/**
+ * decode_upl_memory_node() - Decode a /memory node from the tree
+ *
+ * @upl: UPL state
+ * @node: Node to decode
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_memory_node(struct upl *upl, ofnode node)
+{
+	struct upl_mem *mem = &upl->mem[upl->num_mems];
+	const char *buf;
+	int size, len;
+
+	buf = ofnode_read_prop(node, UPLP_REG, &size);
+	if (!buf) {
+		log_warning("Node '%s': Missing '%s' property\n",
+			    ofnode_get_name(node), UPLP_REG);
+		return log_msg_ret("reg", -EINVAL);
+	}
+	if (upl->num_mems == UPL_MAX_MEMS) {
+		log_warning("Too many '%s' nodes (limit %d)\n",
+			    UPLN_MEMORY, UPL_MAX_MEMS);
+		return log_msg_ret("mem", -E2BIG);
+	}
+	len = decode_addr_size(upl, buf, size, UPL_MAX_MEMREGIONS,
+			       mem->region);
+	if (len < 0)
+		return log_msg_ret("buf", len);
+	mem->num_regions = len;
+	mem->hotpluggable = ofnode_read_bool(node, UPLP_HOTPLUGGABLE);
+	upl->num_mems++;
+
+	return 0;
+}
+
+/**
+ * decode_upl_memmap() - Decode memory-map nodes from the tree
+ *
+ * @upl: UPL state
+ * @root: Parent node containing the /memory-map nodes
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_memmap(struct upl *upl, ofnode root)
+{
+	ofnode node;
+
+	upl->num_memmaps = 0;
+	ofnode_for_each_subnode(node, root) {
+		struct upl_memmap *memmap = &upl->memmap[upl->num_memmaps];
+		int size, len, ret;
+		const char *buf;
+
+		memmap->name = ofnode_get_name(node);
+
+		buf = ofnode_read_prop(node, UPLP_REG, &size);
+		if (!buf) {
+			log_warning("Node '%s': Missing '%s' property\n",
+				    ofnode_get_name(node), UPLP_REG);
+			continue;
+		}
+
+		if (upl->num_memmaps == UPL_MAX_MEMMAPS) {
+			log_warning("Too many '%s' nodes (limit %d)\n",
+				    UPLN_MEMORY, UPL_MAX_MEMMAPS);
+			return log_msg_ret("mem", -E2BIG);
+		}
+		len = decode_addr_size(upl, buf, size, UPL_MAX_MEMREGIONS,
+				       memmap->region);
+		if (len < 0)
+			return log_msg_ret("buf", len);
+		memmap->num_regions = len;
+		ret = ofnode_read_bitmask(node, UPLP_USAGE, usage_names,
+					  UPLUS_COUNT, &memmap->usage);
+		if (ret && ret != -EINVAL)	/* optional property */
+			return log_msg_ret("bit", ret);
+
+		upl->num_memmaps++;
+	}
+
+	return 0;
+}
+
+/**
+ * decode_upl_memres() - Decode reserved-memory nodes from the tree
+ *
+ * @upl: UPL state
+ * @root: Parent node containing the reserved-memory nodes
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_memres(struct upl *upl, ofnode root)
+{
+	ofnode node;
+
+	upl->num_memres = 0;
+	ofnode_for_each_subnode(node, root) {
+		struct upl_memres *memres = &upl->memres[upl->num_memres];
+		const char *buf;
+		int size, len;
+
+		log_debug("decoding '%s'\n", ofnode_get_name(node));
+		memres->name = ofnode_get_name(node);
+
+		buf = ofnode_read_prop(node, UPLP_REG, &size);
+		if (!buf) {
+			log_warning("Node '%s': Missing 'reg' property\n",
+				    ofnode_get_name(node));
+			continue;
+		}
+
+		if (upl->num_memres == UPL_MAX_MEMRESERVED) {
+			log_warning("Too many '%s' nodes (limit %d)\n",
+				    UPLN_MEMORY, UPL_MAX_MEMRESERVED);
+			return log_msg_ret("mem", -E2BIG);
+		}
+		len = decode_addr_size(upl, buf, size, UPL_MAX_MEMREGIONS,
+				       memres->region);
+		if (len < 0)
+			return log_msg_ret("buf", len);
+		memres->num_regions = len;
+		memres->no_map = ofnode_read_bool(node, UPLP_NO_MAP);
+		upl->num_memres++;
+	}
+
+	return 0;
+}
+
+/**
+ * decode_upl_serial() - Decode the serial node
+ *
+ * @upl: UPL state
+ * @root: Parent node contain node
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_serial(struct upl *upl, ofnode node)
+{
+	struct upl_serial *ser = &upl->serial;
+	const char *buf;
+	int len, size;
+	int ret;
+
+	ser->compatible = ofnode_read_string(node, UPLP_COMPATIBLE);
+	if (!ser->compatible) {
+		log_warning("Node '%s': Missing compatible string\n",
+			    ofnode_get_name(node));
+		return log_msg_ret("com", -EINVAL);
+	}
+	ret = read_uint(node, UPLP_CLOCK_FREQUENCY, &ser->clock_frequency);
+	if (!ret)
+		ret = read_uint(node, UPLP_CURRENT_SPEED, &ser->current_speed);
+	if (ret)
+		return log_msg_ret("spe", ret);
+
+	buf = ofnode_read_prop(node, UPLP_REG, &size);
+	if (!buf) {
+		log_warning("Node '%s': Missing 'reg' property\n",
+			    ofnode_get_name(node));
+		return log_msg_ret("reg", -EINVAL);
+	}
+
+	len = decode_addr_size(upl, buf, sizeof(buf), 1, &ser->reg);
+	if (len < 0)
+		return log_msg_ret("buf", len);
+
+	/* set defaults */
+	ser->reg_io_shift = UPLD_REG_IO_SHIFT;
+	ser->reg_offset = UPLD_REG_OFFSET;
+	ser->reg_io_width = UPLD_REG_IO_WIDTH;
+	read_uint(node, UPLP_REG_IO_SHIFT, &ser->reg_io_shift);
+	read_uint(node, UPLP_REG_OFFSET, &ser->reg_offset);
+	read_uint(node, UPLP_REG_IO_WIDTH, &ser->reg_io_width);
+	read_addr(upl, node, UPLP_VIRTUAL_REG, &ser->virtual_reg);
+	ret = ofnode_read_value(node, UPLP_ACCESS_TYPE, access_types,
+				ARRAY_SIZE(access_types), &ser->access_type);
+	if (ret && ret != -ENOENT)
+		return log_msg_ret("ser", ret);
+
+	return 0;
+}
+/**
+ * decode_upl_graphics() - Decode graphics node
+ *
+ * @upl: UPL state
+ * @root: Node to decode
+ * Return 0 if OK, -ve on error
+ */
+static int decode_upl_graphics(struct upl *upl, ofnode node)
+{
+	struct upl_graphics *gra = &upl->graphics;
+	const char *buf, *compat;
+	int len, size;
+	int ret;
+
+	compat = ofnode_read_string(node, UPLP_COMPATIBLE);
+	if (!compat) {
+		log_warning("Node '%s': Missing compatible string\n",
+			    ofnode_get_name(node));
+		return log_msg_ret("com", -EINVAL);
+	}
+	if (strcmp(UPLC_GRAPHICS, compat)) {
+		log_warning("Node '%s': Ignoring compatible '%s'\n",
+			    ofnode_get_name(node), compat);
+		return 0;
+	}
+
+	buf = ofnode_read_prop(node, UPLP_REG, &size);
+	if (!buf) {
+		log_warning("Node '%s': Missing 'reg' property\n",
+			    ofnode_get_name(node));
+		return log_msg_ret("reg", -EINVAL);
+	}
+
+	len = decode_addr_size(upl, buf, sizeof(buf), 1, &gra->reg);
+	if (len < 0)
+		return log_msg_ret("buf", len);
+
+	ret = read_uint(node, UPLP_WIDTH, &gra->width);
+	if (!ret)
+		ret = read_uint(node, UPLP_HEIGHT, &gra->height);
+	if (!ret)
+		ret = read_uint(node, UPLP_STRIDE, &gra->stride);
+	if (!ret) {
+		ret = ofnode_read_value(node, UPLP_GRAPHICS_FORMAT,
+					graphics_formats,
+					ARRAY_SIZE(graphics_formats),
+					&gra->format);
+	}
+	if (ret)
+		return log_msg_ret("pro", ret);
+
+	return 0;
+}
+
+int upl_read_handoff(struct upl *upl, oftree tree)
+{
+	ofnode root, node;
+	int ret;
+
+	if (!oftree_valid(tree))
+		return log_msg_ret("tre", -EINVAL);
+
+	root = oftree_root(tree);
+
+	memset(upl, '\0', sizeof(struct upl));
+	ret = decode_root_props(upl, root);
+	if (ret)
+		return log_msg_ret("ad1", ret);
+
+	ofnode_for_each_subnode(node, root) {
+		const char *name = ofnode_get_name(node);
+
+		log_debug("decoding '%s'\n", name);
+		if (!strcmp(UPLN_OPTIONS, name)) {
+			ret = decode_upl_params(upl, node);
+			if (ret)
+				return log_msg_ret("ad2", ret);
+
+			ret = decode_upl_images(upl, node);
+		} else if (node_matches_at(node, UPLN_MEMORY)) {
+			ret = decode_upl_memory_node(upl, node);
+		} else if (!strcmp(UPLN_MEMORY_MAP, name)) {
+			ret = decode_upl_memmap(upl, node);
+		} else if (!strcmp(UPLN_MEMORY_RESERVED, name)) {
+			ret = decode_upl_memres(upl, node);
+		} else if (node_matches_at(node, UPLN_SERIAL)) {
+			ret = decode_upl_serial(upl, node);
+		} else if (node_matches_at(node, UPLN_GRAPHICS)) {
+			ret = decode_upl_graphics(upl, node);
+		} else {
+			log_debug("Unknown node '%s'\n", name);
+			ret = 0;
+		}
+		if (ret)
+			return log_msg_ret("ad2", ret);
+	}
+
+	return 0;
+}
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 0f01471367d..a51d2275ab5 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -13,6 +13,7 @@ CONFIG_FIT=y
 CONFIG_FIT_RSASSA_PSS=y
 CONFIG_FIT_CIPHER=y
 CONFIG_FIT_VERBOSE=y
+CONFIG_UPL=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTSTAGE=y
@@ -144,7 +145,6 @@ CONFIG_IP_DEFRAG=y
 CONFIG_BOOTP_SERVERIP=y
 CONFIG_IPV6=y
 CONFIG_DM_DMA=y
-CONFIG_DEVRES=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_SIMPLE_PM_BUS=y
 CONFIG_ADC=y
@@ -183,6 +183,7 @@ CONFIG_DMA_CHANNELS=y
 CONFIG_SANDBOX_DMA=y
 CONFIG_FASTBOOT_FLASH=y
 CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_ARM_FFA_TRANSPORT=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_GPIO_LOOKUP_LABEL=y
 CONFIG_QCOM_PMIC_GPIO=y
@@ -230,8 +231,8 @@ CONFIG_MULTIPLEXER=y
 CONFIG_MUX_MMIO=y
 CONFIG_NVME_PCI=y
 CONFIG_PCI_REGION_MULTI_ENTRY=y
-CONFIG_PCI_SANDBOX=y
 CONFIG_PCI_FTPCI100=y
+CONFIG_PCI_SANDBOX=y
 CONFIG_PHY=y
 CONFIG_PHY_SANDBOX=y
 CONFIG_PINCTRL=y
@@ -346,4 +347,3 @@ CONFIG_TEST_FDTDEC=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
-CONFIG_ARM_FFA_TRANSPORT=y
diff --git a/include/upl.h b/include/upl.h
new file mode 100644
index 00000000000..906fc0a235c
--- /dev/null
+++ b/include/upl.h
@@ -0,0 +1,361 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * UPL handoff generation
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#ifndef __UPL_WRITE_H
+#define __UPL_WRITE_H
+
+#include <dm/ofnode_decl.h>
+
+/**
+ * Constans to control the UPL-implementation limits
+ *
+ * @UPL_MAX_IMAGES: Maximum number of images allowed
+ * @UPL_MAX_MEMS: Maximum number of /memory-xxx entries
+ * @UPL_MAX_MEMREGIONS: Maximum number of memory regions in each /menory entry
+ */
+enum {
+	UPL_MAX_IMAGES		= 8,
+	UPL_MAX_MEMS		= 8,
+	UPL_MAX_MEMREGIONS	= 8,
+	UPL_MAX_MEMMAPS		= 32,
+	UPL_MAX_MEMRESERVED	= 8,
+};
+
+#define UPLP_ADDRESS_CELLS	"#address-cells"
+#define UPLP_SIZE_CELLS		"#size-cells"
+
+#define UPLN_OPTIONS		"options"
+#define UPLN_UPL_PARAMS		"upl-params"
+#define UPLP_SMBIOS		"smbios"
+#define UPLP_ACPI		"acpi"
+#define UPLP_BOOTMODE		"bootmode"
+#define UPLP_ADDR_WIDTH		"addr-width"
+#define UPLP_ACPI_NVS_SIZE	"acpi-nvs-size"
+
+#define UPLPATH_UPL_IMAGE	"/options/upl-image"
+#define UPLN_UPL_IMAGE		"upl-image"
+#define UPLN_IMAGE		"image"
+#define UPLP_FIT		"fit"
+#define UPLP_CONF_OFFSET	"conf-offset"
+#define UPLP_LOAD		"load"
+#define UPLP_SIZE		"size"
+#define UPLP_OFFSET		"offset"
+#define UPLP_DESCRIPTION	"description"
+
+#define UPLN_MEMORY		"memory"
+#define UPLP_HOTPLUGGABLE	"hotpluggable"
+
+#define UPLPATH_MEMORY_MAP	"/memory-map"
+#define UPLN_MEMORY_MAP		"memory-map"
+#define UPLP_USAGE		"usage"
+
+#define UPLN_MEMORY_RESERVED	"reserved-memory"
+#define UPLPATH_MEMORY_RESERVED	"/reserved-memory"
+#define UPLP_NO_MAP		"no-map"
+
+#define UPLN_SERIAL		"serial"
+#define UPLP_REG		"reg"
+#define UPLP_COMPATIBLE		"compatible"
+#define UPLP_CLOCK_FREQUENCY	"clock-frequency"
+#define UPLP_CURRENT_SPEED	"current-speed"
+#define UPLP_REG_IO_SHIFT	"reg-io-shift"
+#define UPLP_REG_OFFSET		"reg-offset"
+#define UPLP_REG_IO_WIDTH	"reg-io-width"
+#define UPLP_VIRTUAL_REG	"virtual-reg"
+#define UPLP_ACCESS_TYPE	"access-type"
+
+#define UPLN_GRAPHICS		"framebuffer"
+#define UPLC_GRAPHICS		"simple-framebuffer"
+#define UPLP_WIDTH		"width"
+#define UPLP_HEIGHT		"height"
+#define UPLP_STRIDE		"stride"
+#define UPLP_GRAPHICS_FORMAT	"format"
+
+/**
+ * enum upl_boot_mode - Encodes the boot mode
+ *
+ * Each is a bit number from the boot_mode mask
+ */
+enum upl_boot_mode {
+	UPLBM_FULL,
+	UPLBM_MINIMAL,
+	UPLBM_FAST,
+	UPLBM_DIAG,
+	UPLBM_DEFAULT,
+	UPLBM_S2,
+	UPLBM_S3,
+	UPLBM_S4,
+	UPLBM_S5,
+	UPLBM_FACTORY,
+	UPLBM_FLASH,
+	UPLBM_RECOVERY,
+
+	UPLBM_COUNT,
+};
+
+/**
+ * struct upl_image - UPL image informaiton
+ *
+ * @load: Address image was loaded to
+ * @size: Size of image in bytes
+ * @offset: Offset of the image in the FIT (0=none)
+ * @desc: Description of the iamge (taken from the FIT)
+ */
+struct upl_image {
+	ulong load;
+	ulong size;
+	uint offset;
+	const char *description;
+};
+
+/**
+ * struct memregion - Information about a region of memory
+ *
+ * @base: Base address
+ * @size: Size in bytes
+ */
+struct memregion {
+	ulong base;
+	ulong size;
+};
+
+/**
+ * struct upl_mem - Information about physical-memory layout
+ *
+ * TODO: Figure out initial-mapped-area
+ *
+ * @num_regions: Number of regions
+ * @region: Memory region list
+ * @hotpluggable: true if hotpluggable
+ */
+struct upl_mem {
+	uint num_regions;
+	struct memregion region[UPL_MAX_MEMREGIONS];
+	bool hotpluggable;
+};
+
+/**
+ * enum upl_usage - Encodes the usage
+ *
+ * Each is a bit number from the usage mask
+ */
+enum upl_usage {
+	UPLUS_ACPI_RECLAIM,
+	UPLUS_ACPI_NVS,
+	UPLUS_BOOT_CODE,
+	UPLUS_BOOT_DATA,
+	UPLUS_RUNTIME_CODE,
+	UPLUS_RUNTIME_DATA,
+	UPLUS_COUNT
+};
+
+/**
+ * struct upl_memmap - Information about logical-memory layout
+ *
+ * @name: Node name to use
+ * @num_regions: Number of regions
+ * @region: Memory region list
+ * @usage: Memory-usage mask (enum upl_usage)
+ */
+struct upl_memmap {
+	const char *name;
+	uint num_regions;
+	struct memregion region[UPL_MAX_MEMREGIONS];
+	uint usage;
+};
+
+/**
+ * struct upl_memres - Reserved memory
+ *
+ * @name: Node name to use
+ * @num_regions: Number of regions
+ * @region: Reserved memory region list
+ * @no_map: true to indicate that a virtual mapping must not be created
+ */
+struct upl_memres {
+	const char *name;
+	uint num_regions;
+	struct memregion region[UPL_MAX_MEMREGIONS];
+	bool no_map;
+};
+
+enum upl_serial_access_type {
+	UPLSAT_MMIO,
+	UPLSAT_IO,
+};
+
+/* serial defaults */
+enum {
+	UPLD_REG_IO_SHIFT	= 0,
+	UPLD_REG_OFFSET		= 0,
+	UPLD_REG_IO_WIDTH	= 1,
+};
+
+/**
+ * enum upl_access_type - Access types
+ *
+ * @UPLAT_MMIO: Memory-mapped I/O
+ * @UPLAT_IO: Separate I/O
+ */
+enum upl_access_type {
+	UPLAT_MMIO,
+	UPLAT_IO,
+};
+
+/**
+ * struct upl_serial - Serial console
+ *
+ * @compatible: Compatible string (NULL if there is no serial console)
+ * @clock_frequency: Input clock frequency of UART
+ * @current_speed: Current baud rate of UART
+ * @reg: Base address and size of registers (only one range supported)
+ * @reg_shift_log2: log2 of distance between each register
+ * @reg_offset: Offset of registers from the base address
+ * @reg_width: Register width in bytes
+ * @virtual_reg: Virtual register access (0 for none)
+ * @access_type: Register access type to use
+ */
+struct upl_serial {
+	const char *compatible;
+	uint clock_frequency;
+	uint current_speed;
+	struct memregion reg;
+	uint reg_io_shift;
+	uint reg_offset;
+	uint reg_io_width;
+	ulong virtual_reg;
+	enum upl_serial_access_type access_type;
+};
+
+/**
+ * enum upl_graphics_format - Graphics formats
+ *
+ * @UPLGF_ARGB32: 32bpp format using 0xaarrggbb
+ * @UPLGF_ABGR32: 32bpp format using 0xaabbggrr
+ * @UPLGF_ARGB64: 64bpp format using 0xaaaabbbbggggrrrr
+ */
+enum upl_graphics_format {
+	UPLGF_ARGB32,
+	UPLGF_ABGR32,
+	UPLGF_ABGR64,
+};
+
+struct upl_graphics {
+	struct memregion reg;
+	uint width;
+	uint height;
+	uint stride;
+	enum upl_graphics_format format;
+};
+
+/*
+ * Information about the UPL state
+ *
+ * @addr_cells: Number of address cells used in the handoff
+ * @size_cells: Number of size cells used in the handoff
+ * @bootmode: Boot-mode mask (enum upl_boot_mode)
+ * @fit: Address of FIT image that was loaded
+ * @conf_offset: Offset in FIT of the configuration that was selected
+ * @addr_width: Adress-bus width of machine, e.g. 46 for 46 bits
+ * @acpi_nvs_size: Size of the ACPI non-volatile-storage area in bytes
+ * @num_images: Number of images
+ * @image: Information about each image
+ * @num_mems: Number of physical-memory regions
+ * @memory: Information about physical-memory regions
+ * num_memmaps: Number of logical-memory regions
+ * @nennap: Information about logical-memory regions
+ */
+struct upl {
+	int addr_cells;
+	int size_cells;
+
+	ulong smbios;
+	ulong acpi;
+	uint bootmode;
+	ulong fit;
+	uint conf_offset;
+	uint addr_width;
+	uint acpi_nvs_size;
+
+	uint num_images;
+	struct upl_image image[UPL_MAX_IMAGES];
+	uint num_mems;
+	struct upl_mem mem[UPL_MAX_MEMS];
+	uint num_memmaps;
+	struct upl_memmap memmap[UPL_MAX_MEMMAPS];
+	uint num_memres;
+	struct upl_memres memres[UPL_MAX_MEMRESERVED];
+	struct upl_serial serial;
+	struct upl_graphics graphics;
+};
+
+/**
+ * upl_write_handoff() - Write a Unversal Payload handoff structure
+ *
+ * upl: UPL state to write
+ * @root: root node to write it to
+ * @skip_existing: Avoid recreating any nodes which already exist in the
+ * devicetree. For example, if there is a serial node, just leave it alone,
+ * since don't need to create a new one
+ * Return: 0 on success, -ve on error
+ */
+int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing);
+
+/**
+ * upl_create_handoff_tree() - Write a Unversal Payload handoff structure
+ *
+ * upl: UPL state to write
+ * @treep: Returns a new tree containing the handoff
+ * Return: 0 on success, -ve on error
+ */
+int upl_create_handoff_tree(const struct upl *upl, oftree *treep);
+
+/**
+ * upl_read_handoff() - Read a Unversal Payload handoff structure
+ *
+ * upl: UPL state to read into
+ * @tree: Devicetree containing the data to read
+ * Return: 0 on success, -ve on error
+ */
+int upl_read_handoff(struct upl *upl, oftree tree);
+
+/* Fill a UPL with some test data */
+void upl_get_test_data(struct upl *upl);
+
+#if CONFIG_IS_ENABLED(UPL)
+
+/**
+ * upl_set_fit_info() - Set up basic info about the FIT
+ *
+ * @fit: Address of FIT
+ * @conf_offset: Configuration node being used
+ * @entry_addr: Entry address for next phase
+ */
+void upl_set_fit_info(ulong fit, int conf_offset, ulong entry_addr);
+
+/**
+ * upl_add_image() - Add a new image to the UPL
+ *
+ * @node: Image node offset in FIT
+ * @load_addr: Address to which images was loaded
+ * @size: Image size in bytes
+ * @desc: Description of image
+ */
+int upl_add_image(int node, ulong load_addr, ulong size, const char *desc);
+
+#else
+static inline void upl_set_fit_info(ulong fit, int conf_offset,
+				    ulong entry_addr) {}
+static inline int upl_add_image(int node, ulong load_addr, ulong size,
+				const char *desc)
+{
+	return 0;
+}
+#endif /* UPL */
+
+#endif /* __UPL_WRITE_H */
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

