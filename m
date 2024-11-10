Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59578D3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:51:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BDA88FCB;
	Sun, 10 Nov 2024 12:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JjQX7xId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88B1C890D8; Sun, 10 Nov 2024 12:51:30 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A86F88D14
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so27874125e9.2
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239488; x=1731844288; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lSdHZriWMQtQvHlMMJ3ucXqw3XEqLQhophs0aQjovFc=;
 b=JjQX7xIdnCmVuItxCqDw6oYsR3DOzuUhS4O/q/48TLGLktZhW+ugU7wyOLBzQOzw+v
 EdnRDWK2XVSCyEMUkNGdHT48KoUBsTXAKyp4hQt4bRCZsSJ3cyIxvpI93fqPP/6GRSH/
 TRbXZ6R3WyrzgNfd0DkgEToK6V9hY7N2bb0IkekF8lwE946jEFgrGvMHWjB903xVJVsl
 IvD7cxNVc2H+rm+U9xktTYdjAEZcLWzc5bOJLPK3bK0Tua8h0t3D39jW7dIZrFDI0aCR
 wUm2UTtfY7+h3A/aF7lO3ky+9cseq3kF/aek3cTEFXqOA/gOZGC8B7OfKoENcAxQVuQq
 cl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239488; x=1731844288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lSdHZriWMQtQvHlMMJ3ucXqw3XEqLQhophs0aQjovFc=;
 b=Dyqv/8lUV6rQPRsT9C2q3e5WhfdHB07yyfDF0TTkhIl5wPei5pWF2l51dBde0eOS16
 EUc7iIAwjqnQEEnSSHqG9HzT5o8KSBkGWNx1BtFahv31pL3QnDHrCkb6kXcaLBZm5dOO
 oMchlj+VMuXTIOLUZCBpY0TVB4DEWvcZH/r//0FOl6+JNTsrWv7ZQaHvbJobE9nbIWNI
 m4B0pOu1LmIYzWfLHgpH1TU1iygJiK3KC1NjvwWNM1yazG66oN0kVmIM2NCzwgt7tB6p
 eFVtnHIAJmJaxNq09vw/7HgwsP96XnduxOqKx5S+Y6jCm3NfMwCc8GgUvax0sDoZmE1U
 wErw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG3KawQo1hGw7T8Yk47Bm0CQLc4F+Lq7w0Gq6B/u/tcMQLikpLSUuFrYnaVNoyTD6ci2hWUwU=@lists.denx.de
X-Gm-Message-State: AOJu0YyxTbprXDmngq0cQGesKKuGDwoj4kzL6vmQITMiE5HPEBw0rIk3
 bbZDnvIpcbJG3v5SA33F5hUsPA5Y4HjBEApadQ0/Ge0zC/Ioa7pO
X-Google-Smtp-Source: AGHT+IEAIhCM7yPcaWnC7SCma2PlPVYSqslGipLbRaXSLR0Ci22PJSnyUeiNQnCxJN2brpIiWVyQrw==
X-Received: by 2002:a05:600c:6987:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-432bcafd113mr46999815e9.4.1731239487349; 
 Sun, 10 Nov 2024 03:51:27 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:26 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 1/8] dm: core: implement oftree variant of parse_phandle OPs
Date: Sun, 10 Nov 2024 12:50:20 +0100
Message-ID: <20241110115054.2555-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
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

For FDT scenario, ofnode_from_fdtdec_phandle_args is reworked to accept
a new variable, node and noffset_to_ofnode is used instead of
offset_to_ofnode. This is required to support multiple FDB blob to
calculate the correct of_offset of the ofnode.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/core/of_access.c | 61 ++++++++++++++++++++--------
 drivers/core/ofnode.c    | 51 ++++++++++++++++++++++--
 include/dm/of_access.h   | 86 ++++++++++++++++++++++++++++++++++++++++
 include/dm/ofnode.h      | 66 ++++++++++++++++++++++++++++++
 4 files changed, 244 insertions(+), 20 deletions(-)

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
index 950895e72a9..b9cc9419407 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -879,11 +879,11 @@ int ofnode_read_string_list(ofnode node, const char *property,
 	return count;
 }
 
-static void ofnode_from_fdtdec_phandle_args(struct fdtdec_phandle_args *in,
+static void ofnode_from_fdtdec_phandle_args(ofnode node, struct fdtdec_phandle_args *in,
 					    struct ofnode_phandle_args *out)
 {
 	assert(OF_MAX_PHANDLE_ARGS == MAX_PHANDLE_ARGS);
-	out->node = offset_to_ofnode(in->node);
+	out->node = noffset_to_ofnode(node, in->node);
 	out->args_count = in->args_count;
 	memcpy(out->args, in->args, sizeof(out->args));
 }
@@ -923,7 +923,40 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 						     cell_count, index, &args);
 		if (ret)
 			return ret;
-		ofnode_from_fdtdec_phandle_args(&args, out_args);
+		ofnode_from_fdtdec_phandle_args(node, &args, out_args);
+	}
+
+	return 0;
+}
+
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
+		ofnode_from_fdtdec_phandle_args(node, &args, out_args);
 	}
 
 	return 0;
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

