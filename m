Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA0FC4452F
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 02:59:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D86D5607BD;
	Tue, 21 Jul 2026 02:59:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yyoBJToaAVZE; Tue, 21 Jul 2026 02:59:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CEF6D607B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784602768;
	bh=E+f9OYe+WzhJkQTmkgKk9AjCg0aY3V2AMYEjXGTXvyI=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=pzXIwedau7mdKSXr+mtfq4y3Ltqwmilif30sT2BaFbi5z+B65OowhfNYfONWzB/VK
	 s9KD31sKO8HBqsTUC7zwIlbNslcTb4MIIrL3V5lGz6876J7HjMJDOhb9wWZgvXPNQt
	 oTlVM6cnILDTGdxmzD9yv8m4xBYon0Xxjs1ZQdvu7NwJtuxpdqyK1rc8KsZmTCVRIt
	 JiZFDaVqByMWB9YujUhkAFl9FwC0E+VUoyl3m2K7ayi3/Eg/JrbbXEf8eO3yjMf7zH
	 CMz2p0dXixwkD0yCz4Q8YXwquUFZGfTrvwJ+xgzNgPy+Noff260jddDKlGR8PlhOWI
	 27tP3p3zAUo9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CEF6D607B9;
	Tue, 21 Jul 2026 02:59:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D96B224
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 33A8080BF0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5_ayvuVdX_eN for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 02:59:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1522680BE5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1522680BE5
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1522680BE5
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 02:59:24 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wm0Jz-000000000Kl-0OWQ; Tue, 21 Jul 2026 02:35:03 +0000
Date: Tue, 21 Jul 2026 03:35:00 +0100
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Ludwig Nussel <ludwig.nussel@siemens.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v3 1/3] boot: fit: factor out node-path collection in
 fit_config_add_hash()
Message-ID: <9268873181e9be314113938bf98c7541aeade92f.1784601041.git.daniel@makrotopia.org>
References: <cover.1784601041.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784601041.git.daniel@makrotopia.org>
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=makrotopia.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Daniel Golle via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Daniel Golle <daniel@makrotopia.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Both the boot-side and host-side fit_config_add_hash() repeat the same
sequence to append a node's path to the hashed-node list three times:
for the image node, for each hash subnode and for the cipher subnode.
Extract it into a helper, fit_config_add_node(), in each file, with no
functional change.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
v3: also factor out tools/image-host.c's fit_config_add_hash(), which
    had the same duplication, per Simon Glass's review; this keeps the
    sign-side and verify-side node list construction easy to compare.
    Kept Tom's Reviewed-by: the boot-side code he reviewed is unchanged
    and the host-side addition mechanically mirrors the same pattern.

v2: no changes

 boot/image-fit-sig.c | 73 ++++++++++++++++++++++++++------------------
 tools/image-host.c   | 73 ++++++++++++++++++++++++++++----------------
 2 files changed, 91 insertions(+), 55 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index fe7ca6e4ab5..3357ec92116 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -230,6 +230,37 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	return 0;
 }
 
+/**
+ * fit_config_add_node() - Append one node's path to the hashed-node list
+ *
+ * @fit:		FIT blob
+ * @noffset:		Offset of the node whose path should be added
+ * @node_inc:		Array of path pointers to fill
+ * @count:		Pointer to current count (updated on return)
+ * @max_nodes:		Maximum entries in @node_inc
+ * @buf:		Buffer for packed path strings
+ * @buf_used:		Pointer to bytes used in @buf (updated on return)
+ * @buf_len:		Total size of @buf
+ * Return: 0 on success, -ve on error
+ */
+static int fit_config_add_node(const void *fit, int noffset, char **node_inc,
+			       int *count, int max_nodes, char *buf,
+			       int *buf_used, int buf_len)
+{
+	int ret, len;
+
+	if (*count >= max_nodes)
+		return -ENOSPC;
+	ret = fdt_get_path(fit, noffset, buf + *buf_used, buf_len - *buf_used);
+	if (ret < 0)
+		return -ENOENT;
+	len = strlen(buf + *buf_used) + 1;
+	node_inc[(*count)++] = buf + *buf_used;
+	*buf_used += len;
+
+	return 0;
+}
+
 /**
  * fit_config_add_hash() - Add hash nodes for one image to the node list
  *
@@ -250,18 +281,12 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 			       char **node_inc, int *count, int max_nodes,
 			       char *buf, int *buf_used, int buf_len)
 {
-	int noffset, hash_count, ret, len;
+	int noffset, hash_count, ret;
 
-	if (*count >= max_nodes)
-		return -ENOSPC;
-
-	ret = fdt_get_path(fit, image_noffset, buf + *buf_used,
-			   buf_len - *buf_used);
-	if (ret < 0)
-		return -ENOENT;
-	len = strlen(buf + *buf_used) + 1;
-	node_inc[(*count)++] = buf + *buf_used;
-	*buf_used += len;
+	ret = fit_config_add_node(fit, image_noffset, node_inc, count,
+				  max_nodes, buf, buf_used, buf_len);
+	if (ret)
+		return ret;
 
 	/* Add all this image's hash subnodes */
 	hash_count = 0;
@@ -273,15 +298,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 		if (strncmp(name, FIT_HASH_NODENAME,
 			    strlen(FIT_HASH_NODENAME)))
 			continue;
-		if (*count >= max_nodes)
-			return -ENOSPC;
-		ret = fdt_get_path(fit, noffset, buf + *buf_used,
-				   buf_len - *buf_used);
-		if (ret < 0)
-			return -ENOENT;
-		len = strlen(buf + *buf_used) + 1;
-		node_inc[(*count)++] = buf + *buf_used;
-		*buf_used += len;
+		ret = fit_config_add_node(fit, noffset, node_inc, count,
+					  max_nodes, buf, buf_used, buf_len);
+		if (ret)
+			return ret;
 		hash_count++;
 	}
 
@@ -296,15 +316,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 	if (noffset != -FDT_ERR_NOTFOUND) {
 		if (noffset < 0)
 			return -EIO;
-		if (*count >= max_nodes)
-			return -ENOSPC;
-		ret = fdt_get_path(fit, noffset, buf + *buf_used,
-				   buf_len - *buf_used);
-		if (ret < 0)
-			return -ENOENT;
-		len = strlen(buf + *buf_used) + 1;
-		node_inc[(*count)++] = buf + *buf_used;
-		*buf_used += len;
+		ret = fit_config_add_node(fit, noffset, node_inc, count,
+					  max_nodes, buf, buf_used, buf_len);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/tools/image-host.c b/tools/image-host.c
index 8f1e7be4066..fd2ef99d399 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -1183,6 +1183,41 @@ static const char *fit_config_get_image_list(const void *fit, int noffset,
 	return default_list;
 }
 
+/**
+ * fit_config_add_node() - Add a node's path to a list of nodes to hash
+ *
+ * @fit:	Pointer to the FIT format image header
+ * @noffset:	Offset of the node whose path should be added
+ * @node_inc:	List of nodes to add to
+ * @conf_name	Configuration-node name, child of /configurations node (only
+ *	used for error messages)
+ * @sig_name	Signature-node name (only used for error messages)
+ * @iname:	Name of image being processed (e.g. "kernel-1" (only used
+ *	for error messages)
+ */
+static int fit_config_add_node(const void *fit, int noffset,
+			       struct strlist *node_inc, const char *conf_name,
+			       const char *sig_name, const char *iname)
+{
+	char path[200];
+	int ret;
+
+	ret = fdt_get_path(fit, noffset, path, sizeof(path));
+	if (ret < 0) {
+		fprintf(stderr,
+			"Failed to get path for image '%s' in configuration '%s/%s': %s\n",
+			iname, conf_name, sig_name, fdt_strerror(ret));
+		return -ENOENT;
+	}
+	if (strlist_add(node_inc, path)) {
+		fprintf(stderr, "Out of memory processing configuration '%s/%s'\n",
+			conf_name, sig_name);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 /**
  * fit_config_add_hash() - Add a list of nodes to hash for an image
  *
@@ -1202,16 +1237,14 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 			       struct strlist *node_inc, const char *conf_name,
 			       const char *sig_name, const char *iname)
 {
-	char path[200];
 	int noffset;
 	int hash_count;
 	int ret;
 
-	ret = fdt_get_path(fit, image_noffset, path, sizeof(path));
-	if (ret < 0)
-		goto err_path;
-	if (strlist_add(node_inc, path))
-		goto err_mem;
+	ret = fit_config_add_node(fit, image_noffset, node_inc, conf_name,
+				  sig_name, iname);
+	if (ret)
+		return ret;
 
 	/* Add all this image's hashes */
 	hash_count = 0;
@@ -1223,11 +1256,10 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 		if (strncmp(name, FIT_HASH_NODENAME,
 			    strlen(FIT_HASH_NODENAME)))
 			continue;
-		ret = fdt_get_path(fit, noffset, path, sizeof(path));
-		if (ret < 0)
-			goto err_path;
-		if (strlist_add(node_inc, path))
-			goto err_mem;
+		ret = fit_config_add_node(fit, noffset, node_inc, conf_name,
+					  sig_name, iname);
+		if (ret)
+			return ret;
 		hash_count++;
 	}
 
@@ -1249,24 +1281,13 @@ static int fit_config_add_hash(const void *fit, int image_noffset,
 				fdt_strerror(noffset));
 			return -EIO;
 		}
-		ret = fdt_get_path(fit, noffset, path, sizeof(path));
-		if (ret < 0)
-			goto err_path;
-		if (strlist_add(node_inc, path))
-			goto err_mem;
+		ret = fit_config_add_node(fit, noffset, node_inc, conf_name,
+					  sig_name, iname);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-
-err_mem:
-	fprintf(stderr, "Out of memory processing configuration '%s/%s'\n", conf_name,
-		sig_name);
-	return -ENOMEM;
-
-err_path:
-	fprintf(stderr, "Failed to get path for image '%s' in configuration '%s/%s': %s\n",
-		iname, conf_name, sig_name, fdt_strerror(ret));
-	return -ENOENT;
 }
 
 /**
-- 
2.55.0
