Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5389D5E379
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:01:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D3618926A;
	Sat,  9 Nov 2024 19:01:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K3HCik4b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8941389145; Sat,  9 Nov 2024 19:01:13 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AC689221
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37d4a5ecc44so2079476f8f.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175270; x=1731780070; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RNiV7CYUJQ9IVOJHSUNF5Hahqyb+2SCbGk6R9hQHDJ0=;
 b=K3HCik4b4belMozxOCj0gv9vMcQ4wVBs7LKhPS5MYuKQYaFiDDd/Youkk3IFwyx43a
 FdMY+GRnBWOxlzar1uXW+uE/BrOpHAwDz0YLZHss4e+QUbl26VmYJ3VyS5XZD0/sAVHv
 TGnN7bmVYlu9LnkKIQ3KMRZWTBwJ/r0mXLtSpHjYgSEe6hWQgsLyRRW8+g7boCrQwopw
 Lt/186lfMCs1ZvDM/J/sN7hAJbjYCOcj/A7OtlmbgAC0S8dSgYhb+QE4MLapF+Ncgb1Q
 0ZZiAXRP7WCp7peAF059djpc9mEnB0c/TOEt7beaNmxvmU43MXnBXRTBKSHIAqE/zCV8
 dITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175270; x=1731780070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RNiV7CYUJQ9IVOJHSUNF5Hahqyb+2SCbGk6R9hQHDJ0=;
 b=FNsPvsFOPbs7QEr7TTsEEf3Eounu0LwyJXYMI2PjPGv/94ME32A4HPBGwoowdbzvyb
 mQbpiZV+qHsa9ol8AFYF2hMwzDgi9e6ghge7ZH3aKD3IHS9tFWBWbOciCVzIWqa8Da7W
 3UmAeDfC3kRmTewZCR8SPuwbNKg8xXowC3AvrDeBLtvT0P2IaaGcobkWvp9qZEuHnajf
 4si7HctTaGaaQWxowCX6cicLuOAqGzzPug7tLAQcjBJ7uQkReF+UWY9KoCQw0+LdBZf/
 ezPUhYcQTGKeWDSf3SD7xt/VZYHJozLuwv4FXa2p51hP418Aij+yq1xM6kKX6pSZEc6B
 ciMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4MuYVk2X2QVCtAZKYXnxTVOqWIU4G8bWwVLZJ464claVSe793Btdi74y4gStjVyWfddNIxqA=@lists.denx.de
X-Gm-Message-State: AOJu0Yw0f3D2pUB/+J4VPllabVRmP6qejChT1Dt4VruA/sFaOmMiplrf
 YESDQQLntFpFK5BMd6Wy23pCI2MJtZ0KKTz28hw43o7suayi2W6N
X-Google-Smtp-Source: AGHT+IHazYYPN710J70vHuYqNr5cDNq/Sa/WbszOyOPgz75C7YSnXHmZnTLVC1kcRNqWBEhIDMsBxA==
X-Received: by 2002:a5d:6da8:0:b0:37c:d2ac:dd7d with SMTP id
 ffacd0b85a97d-381f1872f17mr5873036f8f.30.1731175270018; 
 Sat, 09 Nov 2024 10:01:10 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:09 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 1/8] dm: core: implement oftree variant of parse_phandle OPs
Date: Sat,  9 Nov 2024 19:00:26 +0100
Message-ID: <20241109180038.10344-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
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

Implement oftree variant of parse_phandle OPs.

There is currently a very hidden and laten BUG with parse_phandle OPs
that doesn't permit the support of multiple DTS in a system. One usage
example if sandbox with the usage of other.dts

The BUG is only present on live scenario where of_... OPs are used and
it's not present when fdt... OPs are used.

This is caused by an assumption made in __of_parse_phandle_with_args,
with the of_find_node_by_phandle call that pass the first arg as NULL.

This makes of_find_node_by_phandle use the default root node of the
system and doesn't permit the usage of alternative tree. This is correct
for normal system and also for the linux kernel where it's assumed a
single device tree.

It's problematic if other device tree needs to be used.

To fix this, introduce __of_root_parse_phandle_with_args to define a
root device tree for of_find_node_by_phandle.

Introduce all the variant OPs for this and in ofnode, the oftree OPs
following how it's done for other OPs with similar task.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/of_access.c | 61 ++++++++++++++++++++--------
 drivers/core/ofnode.c    | 45 +++++++++++++++++++++
 include/dm/of_access.h   | 86 ++++++++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h      | 66 ++++++++++++++++++++++++++++++
 4 files changed, 241 insertions(+), 17 deletions(-)

diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 77acd766262..b11e36202c1 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -666,11 +666,12 @@ int of_property_read_string_helper(const struct device_node *np,
 	return i <= 0 ? -ENODATA : i;
 }
 
-static int __of_parse_phandle_with_args(const struct device_node *np,
-					const char *list_name,
-					const char *cells_name,
-					int cell_count, int index,
-					struct of_phandle_args *out_args)
+static int __of_root_parse_phandle_with_args(struct device_node *root,
+					     const struct device_node *np,
+					     const char *list_name,
+					     const char *cells_name,
+					     int cell_count, int index,
+					     struct of_phandle_args *out_args)
 {
 	const __be32 *list, *list_end;
 	int rc = 0, cur_index = 0;
@@ -706,7 +707,7 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 			 * below.
 			 */
 			if (cells_name || cur_index == index) {
-				node = of_find_node_by_phandle(NULL, phandle);
+				node = of_find_node_by_phandle(root, phandle);
 				if (!node) {
 					dm_warn("%s: could not find phandle\n",
 						np->full_name);
@@ -783,39 +784,65 @@ static int __of_parse_phandle_with_args(const struct device_node *np,
 	return rc;
 }
 
-struct device_node *of_parse_phandle(const struct device_node *np,
-				     const char *phandle_name, int index)
+struct device_node *of_root_parse_phandle(struct device_node *root,
+					  const struct device_node *np,
+					  const char *phandle_name, int index)
 {
 	struct of_phandle_args args;
 
 	if (index < 0)
 		return NULL;
 
-	if (__of_parse_phandle_with_args(np, phandle_name, NULL, 0, index,
-					 &args))
+	if (__of_root_parse_phandle_with_args(root, np, phandle_name, NULL, 0,
+					      index, &args))
 		return NULL;
 
 	return args.np;
 }
 
+int of_root_parse_phandle_with_args(struct device_node *root,
+				    const struct device_node *np,
+				    const char *list_name, const char *cells_name,
+				    int cell_count, int index,
+				    struct of_phandle_args *out_args)
+{
+	if (index < 0)
+		return -EINVAL;
+
+	return __of_root_parse_phandle_with_args(root, np, list_name, cells_name,
+						 cell_count, index, out_args);
+}
+
+int of_root_count_phandle_with_args(struct device_node *root,
+				    const struct device_node *np,
+				    const char *list_name, const char *cells_name,
+				    int cell_count)
+{
+	return __of_root_parse_phandle_with_args(root, np, list_name, cells_name,
+						 cell_count, -1, NULL);
+}
+
+struct device_node *of_parse_phandle(const struct device_node *np,
+				     const char *phandle_name, int index)
+{
+	return of_root_parse_phandle(NULL, np, phandle_name, index);
+}
+
 int of_parse_phandle_with_args(const struct device_node *np,
 			       const char *list_name, const char *cells_name,
 			       int cell_count, int index,
 			       struct of_phandle_args *out_args)
 {
-	if (index < 0)
-		return -EINVAL;
-
-	return __of_parse_phandle_with_args(np, list_name, cells_name,
-					    cell_count, index, out_args);
+	return of_root_parse_phandle_with_args(NULL, np, list_name, cells_name,
+					       cell_count, index, out_args);
 }
 
 int of_count_phandle_with_args(const struct device_node *np,
 			       const char *list_name, const char *cells_name,
 			       int cell_count)
 {
-	return __of_parse_phandle_with_args(np, list_name, cells_name,
-					    cell_count, -1, NULL);
+	return of_root_count_phandle_with_args(NULL, np, list_name, cells_name,
+					       cell_count);
 }
 
 static void of_alias_add(struct alias_prop *ap, struct device_node *np,
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 950895e72a9..a2136f61b7d 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -929,6 +929,39 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 	return 0;
 }
 
+int oftree_parse_phandle_with_args(oftree tree, ofnode node, const char *list_name,
+				   const char *cells_name, int cell_count,
+				   int index,
+				   struct ofnode_phandle_args *out_args)
+{
+	if (ofnode_is_np(node)) {
+		struct of_phandle_args args;
+		int ret;
+
+		ret = of_root_parse_phandle_with_args(tree.np,
+						      ofnode_to_np(node),
+						      list_name, cells_name,
+						      cell_count, index,
+						      &args);
+		if (ret)
+			return ret;
+		ofnode_from_of_phandle_args(&args, out_args);
+	} else {
+		struct fdtdec_phandle_args args;
+		int ret;
+
+		ret = fdtdec_parse_phandle_with_args(tree.fdt,
+						     ofnode_to_offset(node),
+						     list_name, cells_name,
+						     cell_count, index, &args);
+		if (ret)
+			return ret;
+		ofnode_from_fdtdec_phandle_args(&args, out_args);
+	}
+
+	return 0;
+}
+
 int ofnode_count_phandle_with_args(ofnode node, const char *list_name,
 				   const char *cells_name, int cell_count)
 {
@@ -941,6 +974,18 @@ int ofnode_count_phandle_with_args(ofnode node, const char *list_name,
 				cell_count, -1, NULL);
 }
 
+int oftree_count_phandle_with_args(oftree tree, ofnode node, const char *list_name,
+				   const char *cells_name, int cell_count)
+{
+	if (ofnode_is_np(node))
+		return of_root_count_phandle_with_args(tree.np, ofnode_to_np(node),
+				list_name, cells_name, cell_count);
+	else
+		return fdtdec_parse_phandle_with_args(tree.fdt,
+				ofnode_to_offset(node), list_name, cells_name,
+				cell_count, -1, NULL);
+}
+
 ofnode ofnode_path(const char *path)
 {
 	if (of_live_active())
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index de740d44674..44143a5a391 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -453,6 +453,92 @@ static inline int of_property_count_strings(const struct device_node *np,
 	return of_property_read_string_helper(np, propname, NULL, 0, 0);
 }
 
+/**
+ * of_root_parse_phandle - Resolve a phandle property to a device_node pointer
+ *			   from a root node
+ * @root: Pointer to root device tree node (default root node if NULL)
+ * @np: Pointer to device node holding phandle property
+ * @phandle_name: Name of property holding a phandle value
+ * @index: For properties holding a table of phandles, this is the index into
+ *         the table
+ *
+ * Return:
+ *   the device_node pointer with refcount incremented.  Use
+ *   of_node_put() on it when done.
+ */
+struct device_node *of_root_parse_phandle(struct device_node *root,
+					  const struct device_node *np,
+					  const char *phandle_name, int index);
+
+/**
+ * of_root_parse_phandle_with_args() - Find a node pointed by phandle in a list
+ *				       from a root node
+ *
+ * @root:	pointer to root device tree node (default root node if NULL)
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @cells_count: Cell count to use if @cells_name is NULL
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ * Return:
+ *   0 on success (with @out_args filled out if not NULL), -ENOENT if
+ *   @list_name does not exist, -EINVAL if a phandle was not found,
+ *   @cells_name could not be found, the arguments were truncated or there
+ *   were too many arguments.
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->np
+ * pointer.
+ *
+ * Example:
+ *
+ * .. code-block::
+ *
+ *   phandle1: node1 {
+ *       #list-cells = <2>;
+ *   };
+ *   phandle2: node2 {
+ *       #list-cells = <1>;
+ *   };
+ *   node3 {
+ *       list = <&phandle1 1 2 &phandle2 3>;
+ *   };
+ *
+ * To get a device_node of the `node2' node you may call this:
+ * of_root_parse_phandle_with_args(node3, "list", "#list-cells", 1, &args);
+ */
+int of_root_parse_phandle_with_args(struct device_node *root,
+				    const struct device_node *np,
+				    const char *list_name, const char *cells_name,
+				    int cells_count, int index,
+				    struct of_phandle_args *out_args);
+
+/**
+ * of_root_count_phandle_with_args() - Count the number of phandle in a list
+ *				       from a root node
+ *
+ * @root:	pointer to root device tree node (default root node if NULL)
+ * @np:		pointer to a device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @cells_count: Cell count to use if @cells_name is NULL
+ * Return:
+ *   number of phandle found, -ENOENT if @list_name does not exist,
+ *   -EINVAL if a phandle was not found, @cells_name could not be found,
+ *   the arguments were truncated or there were too many arguments.
+ *
+ * Returns number of phandle found on success, on error returns appropriate
+ * errno value.
+ */
+int of_root_count_phandle_with_args(struct device_node *root,
+				    const struct device_node *np,
+				    const char *list_name, const char *cells_name,
+				    int cells_count);
+
 /**
  * of_parse_phandle - Resolve a phandle property to a device_node pointer
  * @np: Pointer to device node holding phandle property
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0787758926f..7ece68874ae 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -909,6 +909,72 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 int ofnode_count_phandle_with_args(ofnode node, const char *list_name,
 				   const char *cells_name, int cell_count);
 
+/**
+ * oftree_parse_phandle_with_args() - Find a node pointed by phandle in a list
+ *				      from a root node
+ *
+ * This function is useful to parse lists of phandles and their arguments.
+ * Returns 0 on success and fills out_args, on error returns appropriate
+ * errno value.
+ *
+ * Caller is responsible to call of_node_put() on the returned out_args->np
+ * pointer.
+ *
+ * Example:
+ *
+ * .. code-block::
+ *
+ *   phandle1: node1 {
+ *       #list-cells = <2>;
+ *   };
+ *   phandle2: node2 {
+ *       #list-cells = <1>;
+ *   };
+ *   node3 {
+ *       list = <&phandle1 1 2 &phandle2 3>;
+ *   };
+ *
+ * To get a device_node of the `node2' node you may call this:
+ * oftree_parse_phandle_with_args(node3, "list", "#list-cells", 0, 1, &args);
+ *
+ * @tree:	device tree to use
+ * @node:	device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @cell_count: Cell count to use if @cells_name is NULL
+ * @index:	index of a phandle to parse out
+ * @out_args:	optional pointer to output arguments structure (will be filled)
+ * Return:
+ *   0 on success (with @out_args filled out if not NULL), -ENOENT if
+ *   @list_name does not exist, -EINVAL if a phandle was not found,
+ *   @cells_name could not be found, the arguments were truncated or there
+ *   were too many arguments.
+ */
+int oftree_parse_phandle_with_args(oftree tree, ofnode node, const char *list_name,
+				   const char *cells_name, int cell_count,
+				   int index,
+				   struct ofnode_phandle_args *out_args);
+
+/**
+ * oftree_count_phandle_with_args() - Count number of phandle in a list
+ *				      from a root node
+ *
+ * This function is useful to count phandles into a list.
+ * Returns number of phandle on success, on error returns appropriate
+ * errno value.
+ *
+ * @tree:	device tree to use
+ * @node:	device tree node containing a list
+ * @list_name:	property name that contains a list
+ * @cells_name:	property name that specifies phandles' arguments count
+ * @cell_count: Cell count to use if @cells_name is NULL
+ * Return:
+ *   number of phandle on success, -ENOENT if @list_name does not exist,
+ *   -EINVAL if a phandle was not found, @cells_name could not be found.
+ */
+int oftree_count_phandle_with_args(oftree tree, ofnode node, const char *list_name,
+				   const char *cells_name, int cell_count);
+
 /**
  * ofnode_path() - find a node by full path
  *
-- 
2.45.2

