Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA2C7C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 23:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E120D86550;
	Thu, 31 Aug 2023 01:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N6AAoa7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E65AF8652B; Thu, 31 Aug 2023 01:30:06 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A762486550
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 01:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79277cfc73bso11387639f.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 16:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693438202; x=1694043002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bF0gmZ+Q8Qx9MzT+KSn3mkoKQCJEGnQiLgB7qb4oVw=;
 b=N6AAoa7JaoW6YPL15DFZsQVP53r9TQdBnp53LTcMa13+1mC0f9UfBgQZ5XwVnAdJ8g
 WpNdz8l8Qx20/epcs7SxP2ozj6YNhFvLrcD2PfmbU8QjFG1RvHgPQmWxiR2GEeXE/7vX
 x2jtNLKPEV3sZ5YtRdaTr0jIlTa2peKkeetPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693438202; x=1694043002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bF0gmZ+Q8Qx9MzT+KSn3mkoKQCJEGnQiLgB7qb4oVw=;
 b=RwiMonEl1jTjR1nx856RIANkwYLZn58ylU+ZDI+sdkRjd6Ceu2hGcLZ2GKF+6Y3JB8
 nP0O6gWyz8LHvlLoiy0yWBr9Y3cFs75fSuZkjmwmytMq0NTueI+kXqdW1k8fl5q1s0DE
 uY0c49r9r09gHTxNRlmiegooGG4lJLN1rU8m4wU4JGC8QrBQ+2+VyfyQdD0plOzRptWD
 9kqCLf/OkZow85vvCqzBT9YVMRXyt6khlZYnQXVXsY/UoEw6IwreLbXqBUfKl24eFizr
 SvEH3efssbcLQryQLnrxnHak+KhJottPWm3uMlj9WDhqeOy39G6wcTbr1euJWjp6gPDi
 +Wxg==
X-Gm-Message-State: AOJu0YzWvByIp6dTMVWTfA5CCjmoNfEDgVJx19E5q32C9fxFu7ZkfdSB
 Nm8pCfFikcXzb3vpPhrMiszGw+olCINXEKz7UTE=
X-Google-Smtp-Source: AGHT+IHsYkEyKsL1Iza8H+O/z0R4xKndnBXNm0cUOYAw3/34PkBfO3aHxcoXIX2vT78qV8Ci3Htzyw==
X-Received: by 2002:a5e:9202:0:b0:791:1e87:b47e with SMTP id
 y2-20020a5e9202000000b007911e87b47emr4173712iop.15.1693438202045; 
 Wed, 30 Aug 2023 16:30:02 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dj14-20020a056602256e00b0077e35ffac2fsm78512iob.32.2023.08.30.16.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 16:30:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH 2/9] upl: Add support for writing a upl handoff
Date: Wed, 30 Aug 2023 17:29:16 -0600
Message-ID: <20230830232928.2590178-3-sjg@chromium.org>
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
two firmware phases. Add support for writing the handoff information from
a structure.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Kconfig     |   8 +
 boot/Makefile    |   1 +
 boot/upl_write.c | 623 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 632 insertions(+)
 create mode 100644 boot/upl_write.c

diff --git a/boot/Kconfig b/boot/Kconfig
index e4625cc5fcb..d44684aaa04 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -679,6 +679,7 @@ config BOOTMETH_SCRIPT
 config UPL
 	bool "upl - Universal Payload Specification"
 	imply UPL_READ
+	imply UPL_WRITE
 	help
 	  Provides support for UPL payloads and handoff information. U-Boot
 	  supports generating and accepting handoff information. The mkimage
@@ -693,6 +694,13 @@ config UPL_READ
 	  which can be used elsewhere in U-Boot. This is just the reading
 	  implementation, useful for trying it out.
 
+config UPL_WRITE
+	bool "upl - Support writing a Universal Payload handoff"
+	help
+	  Provides support for encoding a UPL-format payload from a C structure
+	  so it can be passed to another program. This is just the writing
+	  implementation, useful for trying it out.
+
 endif  # UPL
 
 endif  # BOOTSTD
diff --git a/boot/Makefile b/boot/Makefile
index e50f3f91430..45f06b43c30 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -39,6 +39,7 @@ endif
 
 obj-$(CONFIG_$(SPL_TPL_)UPL) += upl_common.o
 obj-$(CONFIG_$(SPL_TPL_)UPL_READ) += upl_read.o
+obj-$(CONFIG_$(SPL_TPL_)UPL_WRITE) += upl_write.o
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
diff --git a/boot/upl_write.c b/boot/upl_write.c
new file mode 100644
index 00000000000..74219da6f41
--- /dev/null
+++ b/boot/upl_write.c
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff generation
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
+ * write_addr() - Write an address
+ *
+ * Writes an address in the correct format, either 32- or 64-bit
+ *
+ * @upl: UPL state
+ * @node: Node to write to
+ * @prop: Property name to write
+ * @addr: Address to write
+ * Return: 0 if OK, -ve on error
+ */
+static int write_addr(const struct upl *upl, ofnode node, const char *prop,
+		      ulong addr)
+{
+	int ret;
+
+	if (upl->addr_cells == 1)
+		ret = ofnode_write_u32(node, prop, addr);
+	else
+		ret = ofnode_write_u64(node, prop, addr);
+
+	return ret;
+}
+
+/**
+ * write_size() - Write a size
+ *
+ * Writes a size in the correct format, either 32- or 64-bit
+ *
+ * @upl: UPL state
+ * @node: Node to write to
+ * @prop: Property name to write
+ * @size: Size to write
+ * Return: 0 if OK, -ve on error
+ */
+static int write_size(const struct upl *upl, ofnode node, const char *prop,
+		      ulong size)
+{
+	int ret;
+
+	if (upl->size_cells == 1)
+		ret = ofnode_write_u32(node, prop, size);
+	else
+		ret = ofnode_write_u64(node, prop, size);
+
+	return ret;
+}
+
+/**
+ * ofnode_write_bitmask() - Write a bit mask as a string list
+ *
+ * @node: Node to write to
+ * @prop: Property name to write
+ * @names: Array of names for each bit
+ * @count: Number of array entries
+ * @value: Bit-mask value to write
+ * Return: 0 if OK, -EINVAL if a bit number is not defined, -ENOSPC if the
+ * string is too long for the (internal) buffer
+ */
+static int ofnode_write_bitmask(ofnode node, const char *prop,
+				const char *const names[], uint count,
+				uint value)
+{
+	char buf[128];
+	char *ptr, *end = buf + sizeof(buf);
+	uint bit;
+	int ret;
+
+	ptr = buf;
+	for (bit = 0; bit < count; bit++) {
+		if (value & BIT(bit)) {
+			const char *str = names[bit];
+			uint len;
+
+			if (!str) {
+				log_debug("Unnamed bit number %d\n", bit);
+				return log_msg_ret("bit", -EINVAL);
+			}
+			len = strlen(str) + 1;
+			if (ptr + len > end) {
+				log_debug("String array too long\n");
+				return log_msg_ret("bit", -ENOSPC);
+			}
+
+			memcpy(ptr, str, len);
+			ptr += len;
+		}
+	}
+
+	ret = ofnode_write_prop(node, prop, buf, ptr - buf, true);
+	if (ret)
+		return log_msg_ret("wri", ret);
+
+	return 0;
+}
+
+/**
+ * ofnode_write_value() - Write an int as a string value using a lookup
+ *
+ * @node: Node to write to
+ * @prop: Property name to write
+ * @names: Array of names for each int value
+ * @count: Number of array entries
+ * @value: Int value to write
+ * Return: 0 if OK, -EINVAL if a bit number is not defined, -ENOSPC if the
+ * string is too long for the (internal) buffer
+ */
+static int ofnode_write_value(ofnode node, const char *prop,
+			      const char *const names[], uint count,
+			      uint value)
+{
+	const char *str;
+	int ret;
+
+	if (value >= count) {
+		log_debug("Value of range %d\n", value);
+		return log_msg_ret("val", -ERANGE);
+	}
+	str = names[value];
+	if (!str) {
+		log_debug("Unnamed value %d\n", value);
+		return log_msg_ret("val", -EINVAL);
+	}
+	ret = ofnode_write_string(node, prop, str);
+	if (ret)
+		return log_msg_ret("wri", ret);
+
+	return 0;
+}
+
+/**
+ * add_root_props() - Add root properties to the tree
+ *
+ * @node: Node to add to
+ * Return 0 if OK, -ve on error
+ */
+static int add_root_props(const struct upl *upl, ofnode node)
+{
+	int ret;
+
+	ret = ofnode_write_u32(node, UPLP_ADDRESS_CELLS, upl->addr_cells);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_SIZE_CELLS, upl->size_cells);
+	if (ret)
+		return log_msg_ret("cel", ret);
+
+	return 0;
+}
+
+/**
+ * add_upl_params() - Add UPL parameters node
+ *
+ * @upl: UPL state
+ * @options: /options node to add to
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_params(const struct upl *upl, ofnode options)
+{
+	ofnode node;
+	int ret;
+
+	ret = ofnode_add_subnode(options, UPLN_UPL_PARAMS, &node);
+	if (ret)
+		return log_msg_ret("img", ret);
+
+	ret = write_addr(upl, node, UPLP_SMBIOS, upl->smbios);
+	if (!ret)
+		ret = write_addr(upl, node, UPLP_ACPI, upl->acpi);
+	if (!ret && upl->bootmode)
+		ret = ofnode_write_bitmask(node, UPLP_BOOTMODE, bootmode_names,
+					   UPLBM_COUNT, upl->bootmode);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_ADDR_WIDTH, upl->addr_width);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_ACPI_NVS_SIZE,
+				       upl->acpi_nvs_size);
+	if (ret)
+		return log_msg_ret("cnf", ret);
+
+	return 0;
+}
+
+/**
+ * add_upl_image() - Add /options/upl-image nodes and properties to the tree
+ *
+ * @upl: UPL state
+ * @node: /options node to add to
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_image(const struct upl *upl, ofnode options)
+{
+	ofnode node;
+	int ret, i;
+
+	ret = ofnode_add_subnode(options, UPLN_UPL_IMAGE, &node);
+	if (ret)
+		return log_msg_ret("img", ret);
+
+	if (upl->fit)
+		ret = ofnode_write_u32(node, UPLP_FIT, upl->fit);
+	if (!ret && upl->conf_offset)
+		ret = ofnode_write_u32(node, UPLP_CONF_OFFSET,
+				       upl->conf_offset);
+	if (ret)
+		return log_msg_ret("cnf", ret);
+
+	if (upl->num_images >= UPL_MAX_IMAGES) {
+		log_debug("Exceeded image limit %d\n", UPL_MAX_IMAGES);
+		return log_msg_ret("img", -E2BIG);
+	}
+	for (i = 0; i < upl->num_images; i++) {
+		const struct upl_image *img = &upl->image[i];
+		char name[10];
+		ofnode subnode;
+
+		snprintf(name, sizeof(name), UPLN_IMAGE "-%d", i + 1);
+		ret = ofnode_add_subnode(node, name, &subnode);
+		if (ret)
+			return log_msg_ret("sub", ret);
+
+		ret = write_addr(upl, subnode, UPLP_LOAD, img->load);
+		if (!ret)
+			ret = write_size(upl, subnode, UPLP_SIZE, img->size);
+		if (!ret && img->offset)
+			ret = ofnode_write_u32(subnode, UPLP_OFFSET,
+					       img->offset);
+		ret = ofnode_write_string(subnode, UPLP_DESCRIPTION,
+					  img->description);
+		if (ret)
+			return log_msg_ret("sim", ret);
+	}
+
+	return 0;
+}
+
+/**
+ * buffer_addr_size() - Generate a set of addr/size pairs
+ *
+ * Each base/size value from each region is written to the buffer in a suitable
+ * format to be written to the devicetree
+ *
+ * @upl: UPL state
+ * @buf: Buffer to write to
+ * @size: Buffer size
+ * @num_regions: Number of regions to process
+ * @regions: List of regions to process
+ * Returns: Number of bytes written, or -ENOSPC if the buffer is too small
+ */
+static int buffer_addr_size(const struct upl *upl, char *buf, int size,
+			    uint num_regions, const struct memregion *regions)
+{
+	char *ptr, *end = buf + size;
+	int i;
+
+	ptr = buf;
+	for (i = 0; i < num_regions; i++) {
+		const struct memregion *reg = &regions[i];
+
+		if (upl->addr_cells == 1)
+			*(u32 *)ptr = cpu_to_fdt32(reg->base);
+		else
+			*(u64 *)ptr = cpu_to_fdt64(reg->base);
+		ptr += upl->addr_cells * sizeof(u32);
+
+		if (upl->size_cells == 1)
+			*(u32 *)ptr = cpu_to_fdt32(reg->size);
+		else
+			*(u64 *)ptr = cpu_to_fdt64(reg->size);
+		ptr += upl->size_cells * sizeof(u32);
+		if (ptr > end)
+			return -ENOSPC;
+	}
+
+	return ptr - buf;
+}
+
+/**
+ * add_upl_memory() - Add /memory nodes to the tree
+ *
+ * @upl: UPL state
+ * @root: Parent node to contain the new /memory nodes
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_memory(const struct upl *upl, ofnode root)
+{
+	int i;
+
+	if (upl->num_mems >= UPL_MAX_MEMS) {
+		log_debug("Exceeded mems limit %d\n", UPL_MAX_IMAGES);
+		return log_msg_ret("img", -E2BIG);
+	}
+
+	for (i = 0; i < upl->num_mems; i++) {
+		const struct upl_mem *mem = &upl->mem[i];
+		char buf[UPL_MAX_MEMREGIONS * sizeof(64) * 2];
+		char name[26];
+		int ret, len;
+		ofnode node;
+
+		if (!mem->num_regions) {
+			log_debug("Memory %d has no regions\n", i);
+			return log_msg_ret("reg", -EINVAL);
+		}
+		sprintf(name, UPLN_MEMORY "@0x%lx", mem->region[0].base);
+		ret = ofnode_add_subnode(root, name, &node);
+		if (ret)
+			return log_msg_ret("mem", ret);
+
+		len = buffer_addr_size(upl, buf, sizeof(buf), mem->num_regions,
+				       mem->region);
+		if (len < 0)
+			return log_msg_ret("buf", len);
+
+		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
+		if (!ret && mem->hotpluggable)
+			ret = ofnode_write_bool(node, UPLP_HOTPLUGGABLE,
+						mem->hotpluggable);
+		if (ret)
+			return log_msg_ret("lst", ret);
+	}
+
+	return 0;
+}
+
+/**
+ * add_upl_memmap() - Add memory-map nodes to the tree
+ *
+ * @upl: UPL state
+ * @root: Parent node to contain the new /memory-map node and its subnodes
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_memmap(const struct upl *upl, ofnode root)
+{
+	ofnode mem_node;
+	int i, ret;
+
+	if (!upl->num_memmaps)
+		return 0;
+	ret = ofnode_add_subnode(root, UPLN_MEMORY_MAP, &mem_node);
+	if (ret)
+		return log_msg_ret("img", ret);
+
+	if (upl->num_memmaps >= UPL_MAX_MEMMAPS) {
+		log_debug("Exceeded memmap limit %d\n", UPL_MAX_IMAGES);
+		return log_msg_ret("img", -E2BIG);
+	}
+
+	for (i = 0; i < upl->num_memmaps; i++) {
+		const struct upl_memmap *memmap = &upl->memmap[i];
+		char buf[UPL_MAX_MEMREGIONS * sizeof(64) * 2];
+		char name[26];
+		int ret, len;
+		ofnode node;
+
+		if (!memmap->num_regions) {
+			log_debug("Memory %d has no regions\n", i);
+			return log_msg_ret("reg", -EINVAL);
+		}
+		sprintf(name, "%s@0x%lx", memmap->name, memmap->region[0].base);
+		ret = ofnode_add_subnode(mem_node, name, &node);
+		if (ret)
+			return log_msg_ret("memmap", ret);
+
+		len = buffer_addr_size(upl, buf, sizeof(buf),
+				       memmap->num_regions, memmap->region);
+		if (len < 0)
+			return log_msg_ret("buf", len);
+		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
+		if (!ret && memmap->usage)
+			ret = ofnode_write_bitmask(node, UPLP_USAGE,
+						   usage_names,
+						   UPLUS_COUNT, memmap->usage);
+		if (ret)
+			return log_msg_ret("lst", ret);
+	}
+
+	return 0;
+}
+
+/**
+ * add_upl_memres() - Add /memory-reserved nodes to the tree
+ *
+ * @upl: UPL state
+ * @root: Parent node to contain the new node
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_memres(const struct upl *upl, ofnode root,
+			  bool skip_existing)
+{
+	ofnode mem_node;
+	int i, ret;
+
+	if (!upl->num_memmaps)
+		return 0;
+	ret = ofnode_add_subnode(root, UPLN_MEMORY_RESERVED, &mem_node);
+	if (ret) {
+		if (skip_existing && ret == -EEXIST)
+			return 0;
+		return log_msg_ret("img", ret);
+	}
+
+	if (upl->num_memres >= UPL_MAX_MEMRESERVED) {
+		log_debug("Exceeded memres limit %d\n", UPL_MAX_IMAGES);
+		return log_msg_ret("img", -E2BIG);
+	}
+
+	for (i = 0; i < upl->num_memres; i++) {
+		const struct upl_memres *memres = &upl->memres[i];
+		char buf[UPL_MAX_MEMREGIONS * sizeof(64) * 2];
+		char name[26];
+		int ret, len;
+		ofnode node;
+
+		if (!memres->num_regions) {
+			log_debug("Memory %d has no regions\n", i);
+			return log_msg_ret("reg", -EINVAL);
+		}
+		sprintf(name, "%s@0x%lx", memres->name, memres->region[0].base);
+		ret = ofnode_add_subnode(mem_node, name, &node);
+		if (ret)
+			return log_msg_ret("memres", ret);
+
+		len = buffer_addr_size(upl, buf, sizeof(buf),
+				       memres->num_regions, memres->region);
+		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
+		if (!ret && memres->no_map)
+			ret = ofnode_write_bool(node, UPLP_NO_MAP,
+						memres->no_map);
+		if (ret)
+			return log_msg_ret("lst", ret);
+	}
+
+	return 0;
+}
+
+/**
+ * add_upl_serial() - Add serial node
+ *
+ * @upl: UPL state
+ * @root: Parent node to contain the new node
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_serial(const struct upl *upl, ofnode root,
+			  bool skip_existing)
+{
+	const struct upl_serial *ser = &upl->serial;
+	char name[26];
+	ofnode node;
+	int ret;
+
+	if (!ser->compatible || skip_existing)
+		return 0;
+	sprintf(name, UPLN_SERIAL "@0x%lx", ser->reg.base);
+	ret = ofnode_add_subnode(root, name, &node);
+	if (ret)
+		return log_msg_ret("img", ret);
+	ret = ofnode_write_string(node, UPLP_COMPATIBLE, ser->compatible);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_CLOCK_FREQUENCY,
+				       ser->clock_frequency);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_CURRENT_SPEED,
+				       ser->current_speed);
+	if (!ret) {
+		char buf[16];
+		int len;
+
+		len = buffer_addr_size(upl, buf, sizeof(buf), 1, &ser->reg);
+		if (len < 0)
+			return log_msg_ret("buf", len);
+
+		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
+	}
+	if (!ret && ser->reg_io_shift != UPLD_REG_IO_SHIFT)
+		ret = ofnode_write_u32(node, UPLP_REG_IO_SHIFT,
+				       ser->reg_io_shift);
+	if (!ret && ser->reg_offset != UPLD_REG_OFFSET)
+		ret = ofnode_write_u32(node, UPLP_REG_OFFSET, ser->reg_offset);
+	if (!ret && ser->reg_io_width != UPLD_REG_IO_WIDTH)
+		ret = ofnode_write_u32(node, UPLP_REG_IO_WIDTH,
+				       ser->reg_io_width);
+	if (!ret && ser->virtual_reg)
+		ret = write_addr(upl, node, UPLP_VIRTUAL_REG, ser->virtual_reg);
+	if (!ret) {
+		ret = ofnode_write_value(node, UPLP_ACCESS_TYPE, access_types,
+					 ARRAY_SIZE(access_types),
+					 ser->access_type);
+	}
+	if (ret)
+		return log_msg_ret("ser", ret);
+
+	return 0;
+}
+
+/**
+ * add_upl_graphics() - Add graphics node
+ *
+ * @upl: UPL state
+ * @root: Parent node to contain the new node
+ * Return 0 if OK, -ve on error
+ */
+static int add_upl_graphics(const struct upl *upl, ofnode root)
+{
+	const struct upl_graphics *gra = &upl->graphics;
+	char name[36];
+	ofnode node;
+	int ret;
+
+	sprintf(name, UPLN_GRAPHICS "@0x%lx", gra->reg.base);
+	ret = ofnode_add_subnode(root, name, &node);
+	if (ret)
+		return log_msg_ret("gra", ret);
+
+	ret = ofnode_write_string(node, UPLP_COMPATIBLE, UPLC_GRAPHICS);
+	if (!ret) {
+		char buf[16];
+		int len;
+
+		len = buffer_addr_size(upl, buf, sizeof(buf), 1, &gra->reg);
+		if (len < 0)
+			return log_msg_ret("buf", len);
+
+		ret = ofnode_write_prop(node, UPLP_REG, buf, len, true);
+	}
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_WIDTH, gra->width);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_HEIGHT, gra->height);
+	if (!ret)
+		ret = ofnode_write_u32(node, UPLP_STRIDE, gra->stride);
+	if (!ret) {
+		ret = ofnode_write_value(node, UPLP_GRAPHICS_FORMAT,
+					 graphics_formats,
+					 ARRAY_SIZE(graphics_formats),
+					 gra->format);
+	}
+	if (ret)
+		return log_msg_ret("pro", ret);
+
+	return 0;
+}
+
+int upl_write_handoff(const struct upl *upl, ofnode root, bool skip_existing)
+{
+	ofnode options;
+	int ret;
+
+	ret = add_root_props(upl, root);
+	if (ret)
+		return log_msg_ret("ad1", ret);
+	ret = ofnode_add_subnode(root, UPLN_OPTIONS, &options);
+	if (ret && ret != -EEXIST)
+		return log_msg_ret("opt", -EINVAL);
+
+	ret = add_upl_params(upl, options);
+	if (ret)
+		return log_msg_ret("ad1", ret);
+
+	ret = add_upl_image(upl, options);
+	if (ret)
+		return log_msg_ret("ad2", ret);
+
+	ret = add_upl_memory(upl, root);
+	if (ret)
+		return log_msg_ret("ad3", ret);
+
+	ret = add_upl_memmap(upl, root);
+	if (ret)
+		return log_msg_ret("ad4", ret);
+
+	ret = add_upl_memres(upl, root, skip_existing);
+	if (ret)
+		return log_msg_ret("ad5", ret);
+
+	ret = add_upl_serial(upl, root, skip_existing);
+	if (ret)
+		return log_msg_ret("ad6", ret);
+
+	ret = add_upl_graphics(upl, root);
+	if (ret)
+		return log_msg_ret("ad6", ret);
+
+	return 0;
+}
+
+int upl_create_handoff_tree(const struct upl *upl, oftree *treep)
+{
+	ofnode root;
+	oftree tree;
+	int ret;
+
+	ret = oftree_new(&tree);
+	if (ret)
+		return log_msg_ret("new", ret);
+
+	root = oftree_root(tree);
+	if (!ofnode_valid(root))
+		return log_msg_ret("roo", -EINVAL);
+
+	ret = upl_write_handoff(upl, root, false);
+	if (ret)
+		return log_msg_ret("wr", ret);
+
+	*treep = tree;
+
+	return 0;
+}
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

