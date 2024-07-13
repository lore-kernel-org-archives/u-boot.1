Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648D5C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 07:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48E0788829;
	Sat, 13 Jul 2024 09:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LlS+eEDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0052A88835; Sat, 13 Jul 2024 09:03:54 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E025688829
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4265c2b602aso17682365e9.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720854231; x=1721459031; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OSvNIFQLJeHVe1173Tm/D3mbiX1uxH1DbZpQNh+NTVo=;
 b=LlS+eEDzyIYrYFBlPtYVzaN9nKGokpLKBuP/Ga6jXfmoQXdK3C05DvPAmxJKcBf/fb
 YgzeTxwW5/YM7MEUUOEdtkElRbhqvhx2pRZxlxn0DsPOY8kEwvd5UiVh8jEqlTCSlfru
 ZF+wih8qWDVLqSc30FIuZyIl/3k/xI7xAP8fA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720854231; x=1721459031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OSvNIFQLJeHVe1173Tm/D3mbiX1uxH1DbZpQNh+NTVo=;
 b=OhqjoeGPMGRvkKJlZoALmn+tKrsuPn8bbyFQ344V82S45TgcWt6FawT4QH+Z5gzaEg
 Lw5JTpsZHjQU8qS5HYhZbIhI0TPakQDR+j1rc+588W+rqmCwC1V7WYo2ek8arZd0awyo
 4GYxKLlpP/1TIz68vJZMO3aztvfeTOLFTslbIP5gH4pyNatxaqwRSUDAyDj1Wnid6pHV
 bJVJjkoxYmWQSxAvSxwMmt1asRQ7eHrmKhgkXhMsuBxL2lGHb6jlDE3UcRoCH6XHjGwn
 dUnOfKJoj5/65VSpEoJ0iBxnKGJj3p8kvZkakd74dY5oUt2zhPfz9rZBbblm7tyn3n5r
 54Pg==
X-Gm-Message-State: AOJu0YwNyfrdNhALsvfwnKjdE41kcmBU6VhO8T3C71ssMmsJFjNtSoTE
 XSE1vHAQmQJtoT23Co8QpjZrjDo3QW3GPh5WGAT3lj8yRTyuJxdMB7+E9Dkvqq5HKx6yqpphLw0
 =
X-Google-Smtp-Source: AGHT+IElAa51msL1Cge9v4/840AYrzrw8Dsz7xCiczqKyyEE6X26NmxdP+7AQACl+1C2wZ0XHQVsiQ==
X-Received: by 2002:a05:600c:63c7:b0:426:5f0b:a49b with SMTP id
 5b1f17b1804b1-426707e360fmr86212105e9.23.1720854231102; 
 Sat, 13 Jul 2024 00:03:51 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5ef550asm9973165e9.46.2024.07.13.00.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 00:03:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Lean Sheng Tan <sheng.tan@9elements.com>, Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/21] upl: Add support for writing a upl handoff
Date: Sat, 13 Jul 2024 08:00:45 +0100
Message-Id: <20240713070055.2172883-12-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240713070055.2172883-1-sjg@chromium.org>
References: <20240713070055.2172883-1-sjg@chromium.org>
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

(no changes since v1)

 boot/Kconfig     |   8 +
 boot/Makefile    |   1 +
 boot/upl_write.c | 622 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 631 insertions(+)
 create mode 100644 boot/upl_write.c

diff --git a/boot/Kconfig b/boot/Kconfig
index f371772acb9..04088ca10c0 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -722,6 +722,7 @@ config BOOTMETH_SCRIPT
 config UPL
 	bool "upl - Universal Payload Specification"
 	imply UPL_READ
+	imply UPL_WRITE
 	help
 	  Provides support for UPL payloads and handoff information. U-Boot
 	  supports generating and accepting handoff information. The mkimage
@@ -736,6 +737,13 @@ config UPL_READ
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
 
 endif # BOOTSTD
diff --git a/boot/Makefile b/boot/Makefile
index c4720d93ca3..2c4ea085015 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_$(SPL_TPL_)FDT_SIMPLEFB) += fdt_simplefb.o
 
 obj-$(CONFIG_$(SPL_TPL_)UPL) += upl_common.o
 obj-$(CONFIG_$(SPL_TPL_)UPL_READ) += upl_read.o
+obj-$(CONFIG_$(SPL_TPL_)UPL_WRITE) += upl_write.o
 
 obj-$(CONFIG_$(SPL_TPL_)OF_LIBFDT) += image-fdt.o
 obj-$(CONFIG_$(SPL_TPL_)FIT_SIGNATURE) += fdt_region.o
diff --git a/boot/upl_write.c b/boot/upl_write.c
new file mode 100644
index 00000000000..7d637c15ba0
--- /dev/null
+++ b/boot/upl_write.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * UPL handoff generation
+ *
+ * Copyright 2024 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
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
+	for (i = 0; i < upl->image.count; i++) {
+		const struct upl_image *img = alist_get(&upl->image, i,
+							struct upl_image);
+		ofnode subnode;
+		char name[10];
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
+ * @region: List of regions to process (struct memregion)
+ * Returns: Number of bytes written, or -ENOSPC if the buffer is too small
+ */
+static int buffer_addr_size(const struct upl *upl, char *buf, int size,
+			    uint num_regions, const struct alist *region)
+{
+	char *ptr, *end = buf + size;
+	int i;
+
+	ptr = buf;
+	for (i = 0; i < num_regions; i++) {
+		const struct memregion *reg = alist_get(region, i,
+							struct memregion);
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
+	for (i = 0; i < upl->mem.count; i++) {
+		const struct upl_mem *mem = alist_get(&upl->mem, i,
+						      struct upl_mem);
+		char buf[mem->region.count * sizeof(64) * 2];
+		const struct memregion *first;
+		char name[26];
+		int ret, len;
+		ofnode node;
+
+		if (!mem->region.count) {
+			log_debug("Memory %d has no regions\n", i);
+			return log_msg_ret("reg", -EINVAL);
+		}
+		first = alist_get(&mem->region, 0, struct memregion);
+		sprintf(name, UPLN_MEMORY "@0x%lx", first->base);
+		ret = ofnode_add_subnode(root, name, &node);
+		if (ret)
+			return log_msg_ret("mem", ret);
+
+		len = buffer_addr_size(upl, buf, sizeof(buf), mem->region.count,
+				       &mem->region);
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
+	if (!upl->memmap.count)
+		return 0;
+	ret = ofnode_add_subnode(root, UPLN_MEMORY_MAP, &mem_node);
+	if (ret)
+		return log_msg_ret("img", ret);
+
+	for (i = 0; i < upl->memmap.count; i++) {
+		const struct upl_memmap *memmap = alist_get(&upl->memmap, i,
+							struct upl_memmap);
+		char buf[memmap->region.count * sizeof(64) * 2];
+		const struct memregion *first;
+		char name[26];
+		int ret, len;
+		ofnode node;
+
+		if (!memmap->region.count) {
+			log_debug("Memory %d has no regions\n", i);
+			return log_msg_ret("reg", -EINVAL);
+		}
+		first = alist_get(&memmap->region, 0, struct memregion);
+		sprintf(name, "%s@0x%lx", memmap->name, first->base);
+		ret = ofnode_add_subnode(mem_node, name, &node);
+		if (ret)
+			return log_msg_ret("memmap", ret);
+
+		len = buffer_addr_size(upl, buf, sizeof(buf),
+				       memmap->region.count, &memmap->region);
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
+	if (!upl->memmap.count)
+		return 0;
+	ret = ofnode_add_subnode(root, UPLN_MEMORY_RESERVED, &mem_node);
+	if (ret) {
+		if (skip_existing && ret == -EEXIST)
+			return 0;
+		return log_msg_ret("img", ret);
+	}
+
+	for (i = 0; i < upl->memres.count; i++) {
+		const struct upl_memres *memres = alist_get(&upl->memres, i,
+							struct upl_memres);
+		char buf[memres->region.count * sizeof(64) * 2];
+		const struct memregion *first;
+		char name[26];
+		int ret, len;
+		ofnode node;
+
+		if (!memres->region.count) {
+			log_debug("Memory %d has no regions\n", i);
+			return log_msg_ret("reg", -EINVAL);
+		}
+		first = alist_get(&memres->region, 0, struct memregion);
+		sprintf(name, "%s@0x%lx", memres->name, first->base);
+		ret = ofnode_add_subnode(mem_node, name, &node);
+		if (ret)
+			return log_msg_ret("memres", ret);
+
+		len = buffer_addr_size(upl, buf, sizeof(buf),
+				       memres->region.count, &memres->region);
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
+	const struct memregion *first;
+	char name[26];
+	ofnode node;
+	int ret;
+
+	if (!ser->compatible || skip_existing)
+		return 0;
+	if (!ser->reg.count)
+		return log_msg_ret("ser", -EINVAL);
+	first = alist_get(&ser->reg, 0, struct memregion);
+	sprintf(name, UPLN_SERIAL "@0x%lx", first->base);
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
+	const struct memregion *first;
+	char name[36];
+	ofnode node;
+	int ret;
+
+	if (!gra->reg.count)
+		return log_msg_ret("gra", -ENOENT);
+	first = alist_get(&gra->reg, 0, struct memregion);
+	sprintf(name, UPLN_GRAPHICS "@0x%lx", first->base);
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
+	if (ret && ret != -ENOENT)
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
2.34.1

