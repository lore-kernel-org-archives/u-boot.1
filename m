Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782A0D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 19:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7EE783C2B;
	Mon,  1 Dec 2025 20:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FDfjDUY8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D94083D39; Mon,  1 Dec 2025 20:49:12 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CDA583C01
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 20:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so2281886f8f.3
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 11:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1764618548; x=1765223348; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wviNbVxIsMdxAKAl2Pqlm2UGGQ3V/eAIf/ewkacilik=;
 b=FDfjDUY8rr6usOb8OQEzbhJbsCF287lwYF0wka0W1tHQMMqcG676Nt7lzahW2jfdqo
 5O4sGw7YN+mo+k/nlQTUzYieLoAiu97OhQl0gWTTK0dxGXltP2tgFesJDwDslyWq8UUd
 1lyBEZs9ZbL6niAvp/ZMLsUDUj8pUHttRRLyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764618548; x=1765223348;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wviNbVxIsMdxAKAl2Pqlm2UGGQ3V/eAIf/ewkacilik=;
 b=LQ82I+Fe9GQ83CbixbVbXLoOb93HXrbdafFqOGO1B4fCTk7AcmPhQM/+ucD31o65nd
 yqI9+07p2c0Qrdt2iBWyNyjKtgpMBIrdV+9Vlw0U2BOybNs7iU5B405a74wjw1eN8hDD
 3MK1G78O8jem5PnTbsP2af8LTlPg7URxiP2mRAjcGdh+sjeUSw1p/jmSYfrkfSZuR3IR
 m0Klqwm4u/guXMLXg9RkIBj8NQcpMwL3JCVycTSVThm9Ggk0RBh3TtSQkSolh6LxSvFA
 T2IDVfAzGAzBwO9GEzkVEbz+kzaHCPJg2OjjZkSOsZk6w3q10Y/90gvQbNsFN+5Z27Im
 PYkw==
X-Gm-Message-State: AOJu0YzJxZrQ8RK/H6RPXXe288L8YH3vvVE4xiajr90V+8k0mkJIbuVT
 b14NEA6h5KX981Dpejn4uPIUooXyauyXheSGdMXJ1iDXZjjLVQ/MKQ+ptwEl/bvn/KjeGEiLCSe
 Sg9a1dg==
X-Gm-Gg: ASbGncuBuE5HZd1is8YDNvE/fFby458bVqrQoC2XJYiFRM5TI+q7GQgnljKUE/07ECq
 +w2cUqz3BUw55IV6eMEtPqb6DEuZ+MtYMNo5VAzjzkNglo0YZ2WFuJVqRt7cJC7f4Iecev7FHxK
 XmgyDXY5egFgkhq8sVDRHCFwc2nxu2406G2OM2XW7azqBA+ObCtvHKixj1Sxt9Pycz4Wn0M1Gek
 RiLcEeZBJCm62d34YsI51HO/EP3AHHZTmyQkfzDT1ePtjYXDM4Gnx1C2m1Xuw2JMLLjndWKK3GY
 Y7TGWralfMq2qEUfCWmN/09d6Ld0KkqTob59Ky0q0v/sqFZ301XiXOox8kD78RdVtB+KuCY91Ng
 MjwltQ1WTEWYEiMIBAY6IDirQta4tMs5hsHl9LOOOLlENN6U1/JSbO9i/TGuOvij6fI7dhg1von
 AcjSj1h5a6WRG8SNGtNUUz6o304CuPLBL8mgmRUiuqU0qr9qCjKQ==
X-Google-Smtp-Source: AGHT+IHTNo/pZ978sQVaLEWbihGBEQvkTabtlYPpMnCRjYSQb1NsCJQG0aJfSKy+Jff8VtV7yxMtxA==
X-Received: by 2002:a05:6000:601:b0:426:d5ac:8660 with SMTP id
 ffacd0b85a97d-42cc1d198a8mr43380238f8f.58.1764618547988; 
 Mon, 01 Dec 2025 11:49:07 -0800 (PST)
Received: from chromium.org (82-132-233-99.dab.02.net. [82.132.233.99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a310sm29261904f8f.26.2025.12.01.11.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 11:49:06 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
X-Google-Original-From: Simon Glass <simon.glass@canonical.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Claude <noreply@anthropic.com>, Anurag Dutta <a-dutta@ti.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Pavel Herrmann <morpheus.ibis@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH] dm: core: Create ofnode stubs when OF_REAL is disabled
Date: Mon,  1 Dec 2025 19:48:51 +0000
Message-ID: <20251201194857.2371332-1-simon.glass@canonical.com>
X-Mailer: git-send-email 2.43.0
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

When there is no device tree there is not point in trying to find nodes,
etc. since they will all be null.

Add static inlines to skip the code in that case.

Unfortunately this makes the file a little convoluted and there are
two inlines for ofnode_is_enabled() and ofnode_first/next_subnode(). But
it seems better than the alternative.

We could also consider splitting up the header file.

Also add a rule in drivers/Makefile to compile ofnode.o when OF_REAL is
enabled but DM is not (for kontron-sl-mx6ul) and move the
ofnode_for_each_compatible_node/prop() macros outside the OF_REAL
condition, since they only use functions that have stubs.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 drivers/Makefile      |   4 +
 drivers/core/Makefile |   3 +-
 include/dm/ofnode.h   | 714 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 641 insertions(+), 80 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index de993ae42ac..a440b3a18a7 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -8,6 +8,10 @@ obj-$(CONFIG_$(PHASE_)BUTTON) += button/
 obj-$(CONFIG_$(PHASE_)CACHE) += cache/
 obj-$(CONFIG_$(PHASE_)CLK) += clk/
 obj-$(CONFIG_$(PHASE_)DM) += core/
+# ofnode functions are needed for OF_REAL even without full DM
+ifndef CONFIG_$(PHASE_)DM
+obj-$(CONFIG_$(PHASE_)OF_REAL) += core/ofnode.o
+endif
 obj-$(CONFIG_$(PHASE_)DMA) += dma/
 obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
 obj-$(CONFIG_$(PHASE_)DFU) += dfu/
diff --git a/drivers/core/Makefile b/drivers/core/Makefile
index a549890c22b..8bcba38de4d 100644
--- a/drivers/core/Makefile
+++ b/drivers/core/Makefile
@@ -16,6 +16,7 @@ ifndef CONFIG_DM_DEV_READ_INLINE
 obj-$(CONFIG_OF_CONTROL) += read.o
 endif
 obj-$(CONFIG_$(PHASE_)OF_PLATDATA) += read.o
-obj-$(CONFIG_OF_CONTROL) += of_extra.o ofnode.o read_extra.o ofnode_graph.o
+obj-$(CONFIG_OF_CONTROL) += of_extra.o read_extra.o
+obj-$(CONFIG_$(PHASE_)OF_REAL) += ofnode.o ofnode_graph.o
 
 ccflags-$(CONFIG_DM_DEBUG) += -DDEBUG
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 120393426db..3be7d0aea5b 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -128,6 +128,7 @@ static inline ofnode noffset_to_ofnode(ofnode other_node, int of_offset)
 
 #endif /* OFNODE_MULTI_TREE */
 
+#if CONFIG_IS_ENABLED(OF_REAL)
 /**
  * oftree_new() - Create a new, empty tree
  *
@@ -148,6 +149,17 @@ int oftree_new(oftree *treep);
  * error
  */
 int oftree_to_fdt(oftree tree, struct abuf *buf);
+#else
+static inline int oftree_new(oftree *treep)
+{
+	return -ENOSYS;
+}
+
+static inline int oftree_to_fdt(oftree tree, struct abuf *buf)
+{
+	return -ENOSYS;
+}
+#endif /* OF_REAL */
 
 /**
  * ofnode_to_np() - convert an ofnode to a live DT node pointer
@@ -375,6 +387,7 @@ static inline oftree oftree_from_np(struct device_node *root)
 	return tree;
 }
 
+#if CONFIG_IS_ENABLED(OF_REAL)
 /**
  * oftree_dispose() - Dispose of an oftree
  *
@@ -481,6 +494,56 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
  */
 int ofnode_read_u64_index(ofnode node, const char *propname, int index,
 			  u64 *outp);
+#else
+static inline bool ofnode_name_eq(ofnode node, const char *name)
+{
+	return false;
+}
+
+static inline bool ofnode_name_eq_unit(ofnode node, const char *name)
+{
+	return false;
+}
+
+static inline int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
+{
+	return -EINVAL;
+}
+
+static inline u8 ofnode_read_u8_default(ofnode node, const char *propname,
+					u8 def)
+{
+	return def;
+}
+
+static inline int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
+{
+	return -EINVAL;
+}
+
+static inline u16 ofnode_read_u16_default(ofnode node, const char *propname,
+					  u16 def)
+{
+	return def;
+}
+
+static inline int ofnode_read_u32(ofnode node, const char *propname, u32 *outp)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_u32_index(ofnode node, const char *propname,
+					int index, u32 *outp)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_u64_index(ofnode node, const char *propname,
+					int index, u64 *outp)
+{
+	return -EINVAL;
+}
+#endif /* OF_REAL */
 
 /**
  * ofnode_read_s32() - Read a 32-bit integer from a property
@@ -496,6 +559,7 @@ static inline int ofnode_read_s32(ofnode node, const char *propname,
 	return ofnode_read_u32(node, propname, (u32 *)outp);
 }
 
+#if CONFIG_IS_ENABLED(OF_REAL)
 /**
  * ofnode_read_u32_default() - Read a 32-bit integer from a property
  *
@@ -618,8 +682,72 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name);
  * subnode)
  */
 ofnode ofnode_find_subnode_unit(ofnode node, const char *subnode_name);
+#else
+static inline u32 ofnode_read_u32_default(ofnode node, const char *propname,
+					  u32 def)
+{
+	return def;
+}
+
+static inline u32 ofnode_read_u32_index_default(ofnode node,
+						const char *propname,
+						int index, u32 def)
+{
+	return def;
+}
+
+static inline int ofnode_read_s32_default(ofnode node, const char *propname,
+					  s32 def)
+{
+	return def;
+}
+
+static inline int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
+{
+	return -EINVAL;
+}
+
+static inline u64 ofnode_read_u64_default(ofnode node, const char *propname,
+					  u64 def)
+{
+	return def;
+}
+
+static inline const void *ofnode_read_prop(ofnode node, const char *propname,
+					   int *sizep)
+{
+	return NULL;
+}
+
+static inline const char *ofnode_read_string(ofnode node, const char *propname)
+{
+	return NULL;
+}
+
+static inline int ofnode_read_u32_array(ofnode node, const char *propname,
+					u32 *out_values, size_t sz)
+{
+	return -EINVAL;
+}
+
+static inline bool ofnode_read_bool(ofnode node, const char *propname)
+{
+	return false;
+}
+
+static inline ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
+{
+	return ofnode_null();
+}
 
-#if CONFIG_IS_ENABLED(DM_INLINE_OFNODE)
+static inline ofnode ofnode_find_subnode_unit(ofnode node,
+					      const char *subnode_name)
+{
+	return ofnode_null();
+}
+#endif
+
+#if CONFIG_IS_ENABLED(OF_REAL) && CONFIG_IS_ENABLED(DM_INLINE_OFNODE)
 #include <asm/global_data.h>
 
 static inline bool ofnode_is_enabled(ofnode node)
@@ -651,7 +779,7 @@ static inline ofnode ofnode_next_subnode(ofnode node)
 	return offset_to_ofnode(
 		fdt_next_subnode(gd->fdt_blob, ofnode_to_offset(node)));
 }
-#else
+#elif CONFIG_IS_ENABLED(OF_REAL)
 /**
  * ofnode_is_enabled() - Checks whether a node is enabled.
  * This looks for a 'status' property. If this exists, then returns true if
@@ -681,8 +809,47 @@ ofnode ofnode_first_subnode(ofnode node);
  * has no more siblings)
  */
 ofnode ofnode_next_subnode(ofnode node);
-#endif /* DM_INLINE_OFNODE */
+#else
+static inline bool ofnode_is_enabled(ofnode node)
+{
+	return false;
+}
 
+static inline ofnode ofnode_first_subnode(ofnode node)
+{
+	return ofnode_null();
+}
+
+static inline ofnode ofnode_next_subnode(ofnode node)
+{
+	return ofnode_null();
+}
+#endif
+
+/**
+ * ofnode_for_each_subnode() - iterate over all subnodes of a parent
+ *
+ * @node:       child node (ofnode, lvalue)
+ * @parent:     parent node (ofnode)
+ *
+ * This is a wrapper around a for loop and is used like so::
+ *
+ *   ofnode node;
+ *   ofnode_for_each_subnode(node, parent) {
+ *       Use node
+ *       ...
+ *   }
+ *
+ * Note that this is implemented as a macro and @node is used as
+ * iterator in the loop. The parent variable can be a constant or even a
+ * literal.
+ */
+#define ofnode_for_each_subnode(node, parent) \
+	for (node = ofnode_first_subnode(parent); \
+	     ofnode_valid(node); \
+	     node = ofnode_next_subnode(node))
+
+#if CONFIG_IS_ENABLED(OF_REAL)
 /**
  * ofnode_get_parent() - get the ofnode's parent (enclosing ofnode)
  *
@@ -1200,30 +1367,6 @@ int ofnode_first_property(ofnode node, struct ofprop *prop);
  */
 int ofnode_next_property(struct ofprop *prop);
 
-/**
- * ofnode_for_each_prop() - iterate over all properties of a node
- *
- * @prop:	struct ofprop
- * @node:	node (lvalue, ofnode)
- *
- * This is a wrapper around a for loop and is used like this::
- *
- *   ofnode node;
- *   struct ofprop prop;
- *
- *   ofnode_for_each_prop(prop, node) {
- *       ...use prop...
- *   }
- *
- * Note that this is implemented as a macro and @prop is used as
- * iterator in the loop. The parent variable can be a constant or even a
- * literal.
- */
-#define ofnode_for_each_prop(prop, node) \
-	for (ofnode_first_property(node, &prop); \
-	     ofprop_valid(&prop); \
-	     ofnode_next_property(&prop))
-
 /**
  * ofprop_get_property() - get a pointer to the value of a property
  *
@@ -1438,52 +1581,6 @@ ofnode ofnode_by_compatible(ofnode from, const char *compat);
 ofnode ofnode_by_prop_value(ofnode from, const char *propname,
 			    const void *propval, int proplen);
 
-/**
- * ofnode_for_each_subnode() - iterate over all subnodes of a parent
- *
- * @node:       child node (ofnode, lvalue)
- * @parent:     parent node (ofnode)
- *
- * This is a wrapper around a for loop and is used like so::
- *
- *   ofnode node;
- *   ofnode_for_each_subnode(node, parent) {
- *       Use node
- *       ...
- *   }
- *
- * Note that this is implemented as a macro and @node is used as
- * iterator in the loop. The parent variable can be a constant or even a
- * literal.
- */
-#define ofnode_for_each_subnode(node, parent) \
-	for (node = ofnode_first_subnode(parent); \
-	     ofnode_valid(node); \
-	     node = ofnode_next_subnode(node))
-
-/**
- * ofnode_for_each_compatible_node() - iterate over all nodes with a given
- *				       compatible string
- *
- * @node:       child node (ofnode, lvalue)
- * @compat:     compatible string to match
- *
- * This is a wrapper around a for loop and is used like so::
- *
- *   ofnode node;
- *   ofnode_for_each_compatible_node(node, parent, compatible) {
- *      Use node
- *      ...
- *   }
- *
- * Note that this is implemented as a macro and @node is used as
- * iterator in the loop.
- */
-#define ofnode_for_each_compatible_node(node, compat) \
-	for (node = ofnode_by_compatible(ofnode_null(), compat); \
-	     ofnode_valid(node); \
-	     node = ofnode_by_compatible(node, compat))
-
 /**
  * ofnode_get_child_count() - get the child count of a ofnode
  *
@@ -1661,8 +1758,423 @@ ofnode ofnode_get_phy_node(ofnode eth_node);
  *	   error
  */
 phy_interface_t ofnode_read_phy_mode(ofnode mac_node);
+#else
+static inline ofnode ofnode_get_parent(ofnode node)
+{
+	return ofnode_null();
+}
+
+static inline const char *ofnode_get_name(ofnode node)
+{
+	return NULL;
+}
+
+static inline int ofnode_get_path(ofnode node, char *buf, int buflen)
+{
+	return -EINVAL;
+}
+
+static inline ofnode ofnode_get_by_phandle(uint phandle)
+{
+	return ofnode_null();
+}
+
+static inline ofnode oftree_get_by_phandle(oftree tree, uint phandle)
+{
+	return ofnode_null();
+}
+
+static inline int ofnode_read_size(ofnode node, const char *propname)
+{
+	return -EINVAL;
+}
+
+static inline fdt_addr_t ofnode_get_addr_size_index(ofnode node, int index,
+						    fdt_size_t *size)
+{
+	return FDT_ADDR_T_NONE;
+}
+
+static inline fdt_addr_t ofnode_get_addr_size_index_notrans(ofnode node,
+							    int index,
+							    fdt_size_t *size)
+{
+	return FDT_ADDR_T_NONE;
+}
+
+static inline fdt_addr_t ofnode_get_addr_index(ofnode node, int index)
+{
+	return FDT_ADDR_T_NONE;
+}
+
+static inline fdt_addr_t ofnode_get_addr(ofnode node)
+{
+	return FDT_ADDR_T_NONE;
+}
+
+static inline fdt_size_t ofnode_get_size(ofnode node)
+{
+	return FDT_SIZE_T_NONE;
+}
+
+static inline int ofnode_stringlist_search(ofnode node, const char *propname,
+					   const char *string)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_string_index(ofnode node, const char *propname,
+					   int index, const char **outp)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_string_count(ofnode node, const char *property)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_string_list(ofnode node, const char *property,
+					  const char ***listp)
+{
+	return -EINVAL;
+}
+
+static inline ofnode ofnode_parse_phandle(ofnode node, const char *phandle_name,
+					  int index)
+{
+	return ofnode_null();
+}
+
+static inline int ofnode_parse_phandle_with_args(ofnode node,
+						 const char *list_name,
+						 const char *cells_name,
+						 int cell_count, int index,
+						 struct ofnode_phandle_args *out_args)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_count_phandle_with_args(ofnode node,
+						 const char *list_name,
+						 const char *cells_name,
+						 int cell_count)
+{
+	return -EINVAL;
+}
+
+static inline ofnode oftree_parse_phandle(oftree tree, ofnode node,
+					  const char *phandle_name, int index)
+{
+	return ofnode_null();
+}
+
+static inline int oftree_parse_phandle_with_args(oftree tree, ofnode node,
+						 const char *list_name,
+						 const char *cells_name,
+						 int cell_count, int index,
+						 struct ofnode_phandle_args *out_args)
+{
+	return -EINVAL;
+}
+
+static inline int oftree_count_phandle_with_args(oftree tree, ofnode node,
+						 const char *list_name,
+						 const char *cells_name,
+						 int cell_count)
+{
+	return -EINVAL;
+}
+
+static inline ofnode ofnode_path(const char *path)
+{
+	return ofnode_null();
+}
+
+static inline ofnode oftree_path(oftree tree, const char *path)
+{
+	return ofnode_null();
+}
+
+static inline ofnode oftree_root(oftree tree)
+{
+	return ofnode_null();
+}
+
+static inline const void *ofnode_read_chosen_prop(const char *propname,
+						  int *sizep)
+{
+	return NULL;
+}
+
+static inline const char *ofnode_read_chosen_string(const char *propname)
+{
+	return NULL;
+}
+
+static inline ofnode ofnode_get_chosen_node(const char *propname)
+{
+	return ofnode_null();
+}
+
+static inline int ofnode_read_baud(void)
+{
+	return -EINVAL;
+}
+
+static inline const void *ofnode_read_aliases_prop(const char *propname,
+						   int *sizep)
+{
+	return NULL;
+}
+
+static inline ofnode ofnode_get_aliases_node(const char *propname)
+{
+	return ofnode_null();
+}
+
+static inline int ofnode_decode_display_timing(ofnode node, int index,
+					       struct display_timing *config)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_decode_panel_timing(ofnode node,
+					     struct display_timing *config)
+{
+	return -EINVAL;
+}
+
+static inline const void *ofnode_get_property(ofnode node, const char *propname,
+					      int *lenp)
+{
+	return NULL;
+}
+
+static inline bool ofnode_has_property(ofnode node, const char *propname)
+{
+	return false;
+}
+
+static inline int ofnode_first_property(ofnode node, struct ofprop *prop)
+{
+	return -FDT_ERR_NOTFOUND;
+}
+
+static inline int ofnode_next_property(struct ofprop *prop)
+{
+	return -FDT_ERR_NOTFOUND;
+}
+
+static inline const void *ofprop_get_property(const struct ofprop *prop,
+					      const char **propname, int *lenp)
+{
+	return NULL;
+}
+
+static inline fdt_addr_t ofnode_get_addr_size(ofnode node, const char *propname,
+					      fdt_size_t *sizep)
+{
+	return FDT_ADDR_T_NONE;
+}
+
+static inline const uint8_t *ofnode_read_u8_array_ptr(ofnode node,
+						      const char *propname,
+						      size_t sz)
+{
+	return NULL;
+}
+
+static inline int ofnode_read_pci_addr(ofnode node, enum fdt_pci_space type,
+				       const char *propname,
+				       struct fdt_pci_addr *addr,
+				       fdt_size_t *size)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_pci_vendev(ofnode node, u16 *vendor, u16 *device)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_eth_phy_id(ofnode node, u16 *vendor, u16 *device)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_addr_cells(ofnode node)
+{
+	return 0;
+}
+
+static inline int ofnode_read_size_cells(ofnode node)
+{
+	return 0;
+}
+
+static inline int ofnode_read_simple_addr_cells(ofnode node)
+{
+	return 0;
+}
+
+static inline int ofnode_read_simple_size_cells(ofnode node)
+{
+	return 0;
+}
+
+static inline bool ofnode_pre_reloc(ofnode node)
+{
+	return false;
+}
+
+static inline int ofnode_read_resource(ofnode node, uint index,
+				       struct resource *res)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_resource_byname(ofnode node, const char *name,
+					      struct resource *res)
+{
+	return -EINVAL;
+}
+
+static inline ofnode ofnode_by_compatible(ofnode from, const char *compat)
+{
+	return ofnode_null();
+}
+
+static inline ofnode ofnode_by_prop_value(ofnode from, const char *propname,
+					  const void *propval, int proplen)
+{
+	return ofnode_null();
+}
+
+static inline int ofnode_get_child_count(ofnode parent)
+{
+	return 0;
+}
+
+static inline u64 ofnode_translate_address(ofnode node, const fdt32_t *in_addr)
+{
+	return OF_BAD_ADDR;
+}
+
+static inline u64 ofnode_translate_dma_address(ofnode node,
+					       const fdt32_t *in_addr)
+{
+	return OF_BAD_ADDR;
+}
+
+static inline int ofnode_get_dma_range(ofnode node, phys_addr_t *cpu,
+				       dma_addr_t *bus, u64 *size)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_device_is_compatible(ofnode node, const char *compat)
+{
+	return 0;
+}
+
+static inline int ofnode_write_prop(ofnode node, const char *propname,
+				    const void *value, int len, bool copy)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_write_string(ofnode node, const char *propname,
+				      const char *value)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_write_u32(ofnode node, const char *propname, u32 value)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_write_u64(ofnode node, const char *propname, u64 value)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_write_bool(ofnode node, const char *propname,
+				    bool value)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_delete_prop(ofnode node, const char *propname)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_set_enabled(ofnode node, bool value)
+{
+	return -ENOSYS;
+}
+
+static inline ofnode ofnode_get_phy_node(ofnode eth_node)
+{
+	return ofnode_null();
+}
+
+static inline phy_interface_t ofnode_read_phy_mode(ofnode mac_node)
+{
+	return PHY_INTERFACE_MODE_NA;
+}
+#endif /* OF_REAL */
 
-#if CONFIG_IS_ENABLED(DM)
+/**
+ * ofnode_for_each_compatible_node() - iterate over all nodes with a given
+ *				       compatible string
+ *
+ * @node:       child node (ofnode, lvalue)
+ * @compat:     compatible string to match
+ *
+ * This is a wrapper around a for loop and is used like so::
+ *
+ *   ofnode node;
+ *   ofnode_for_each_compatible_node(node, compatible) {
+ *      Use node
+ *      ...
+ *   }
+ *
+ * Note that this is implemented as a macro and @node is used as
+ * iterator in the loop.
+ */
+#define ofnode_for_each_compatible_node(node, compat) \
+	for (node = ofnode_by_compatible(ofnode_null(), compat); \
+	     ofnode_valid(node); \
+	     node = ofnode_by_compatible(node, compat))
+
+/**
+ * ofnode_for_each_prop() - iterate over all properties of a node
+ *
+ * @prop:	struct ofprop
+ * @node:	node (lvalue, ofnode)
+ *
+ * This is a wrapper around a for loop and is used like this::
+ *
+ *   ofnode node;
+ *   struct ofprop prop;
+ *
+ *   ofnode_for_each_prop(prop, node) {
+ *       ...use prop...
+ *   }
+ *
+ * Note that this is implemented as a macro and @prop is used as
+ * iterator in the loop. The parent variable can be a constant or even a
+ * literal.
+ */
+#define ofnode_for_each_prop(prop, node) \
+	for (ofnode_first_property(node, &prop); \
+	     ofprop_valid(&prop); \
+	     ofnode_next_property(&prop))
+
+#if CONFIG_IS_ENABLED(OF_REAL)
 /**
  * ofnode_conf_read_bool() - Read a boolean value from the U-Boot config
  *
@@ -1800,8 +2312,7 @@ int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset);
  */
 int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 				 u64 *bootscr_flash_size);
-
-#else /* CONFIG_DM */
+#else
 static inline bool ofnode_conf_read_bool(const char *prop_name)
 {
 	return false;
@@ -1817,7 +2328,29 @@ static inline const char *ofnode_conf_read_str(const char *prop_name)
 	return NULL;
 }
 
-static inline int ofnode_read_bootscript_address(u64 *bootscr_address, u64 *bootscr_offset)
+static inline bool ofnode_options_read_bool(const char *prop_name)
+{
+	return false;
+}
+
+static inline int ofnode_options_read_int(const char *prop_name, int default_val)
+{
+	return default_val;
+}
+
+static inline const char *ofnode_options_read_str(const char *prop_name)
+{
+	return NULL;
+}
+
+static inline int ofnode_options_get_by_phandle(const char *prop_name,
+						ofnode *nodep)
+{
+	return -EINVAL;
+}
+
+static inline int ofnode_read_bootscript_address(u64 *bootscr_address,
+						 u64 *bootscr_offset)
 {
 	return -EINVAL;
 }
@@ -1827,9 +2360,9 @@ static inline int ofnode_read_bootscript_flash(u64 *bootscr_flash_offset,
 {
 	return -EINVAL;
 }
+#endif /* OF_REAL */
 
-#endif /* CONFIG_DM */
-
+#if CONFIG_IS_ENABLED(OF_REAL)
 /**
  * of_add_subnode() - add a new subnode to a node
  *
@@ -1885,5 +2418,28 @@ int ofnode_copy_node(ofnode dst_parent, const char *name, ofnode src,
  *
  */
 int ofnode_delete(ofnode *nodep);
+#else
+static inline int ofnode_add_subnode(ofnode parent, const char *name,
+				     ofnode *nodep)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_copy_props(ofnode dst, ofnode src)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_copy_node(ofnode dst_parent, const char *name,
+				   ofnode src, ofnode *nodep)
+{
+	return -ENOSYS;
+}
+
+static inline int ofnode_delete(ofnode *nodep)
+{
+	return -ENOSYS;
+}
+#endif /* OF_REAL */
 
 #endif
-- 
2.43.0

base-commit: 42a4ff5f63baacc414b564c02541cd1f5c0862ee
branch: ofn-us
