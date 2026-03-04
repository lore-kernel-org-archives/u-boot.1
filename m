Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCD8EF8FEA
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 13:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C45A583F61;
	Wed,  4 Mar 2026 14:52:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EEBNW9gO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBF8C839A8; Wed,  4 Mar 2026 14:52:55 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 033FF838BB
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 14:52:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d4c85307b2so4836460a34.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 05:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772632371; x=1773237171; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WtLwvVxcuMhapW2dH4pdufMXrcwRkHK8O/a5cuIHxOg=;
 b=EEBNW9gOa5tSVZlKjplen66HDeW7xON/x8WFuAEFDTNaCAgV7kLBzBUNDZmRW+bT+U
 Ly9JWVrpwhJaRZQ+DbsFeTKJtfOqmiDrvjtC/0S2UHjS5gPha71EgfAP9bntiYZU9uNu
 RJDFuv8h8A067+wK2SEnQKAvTqumhOCIZGpHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772632371; x=1773237171;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtLwvVxcuMhapW2dH4pdufMXrcwRkHK8O/a5cuIHxOg=;
 b=SbKnMYI8v8FJ3xtJ2hOoHdPGaZNNUvBlLy68GkOxsuPUQPlHen+rDmuuTTpkVsQP9t
 /s6YFKMROJIfwDOaLsKUHPFpzDcDDmFAIz4weSYrYIXajFFT8TE5PNzxdbo7lSjfIDIv
 f1Kfyt1EHm3waRTUBpY3NPNrXWKDP/j8+tVgUS/mTU1xft0KUpZgSEKBWugMDjukCFTv
 Y1RL3Q2XlSnPCcsS8a32GLUDHw+HLr0tABwECZaQzpHRd9L9IHTGkXG/mFYu4WeU7Z/7
 GLTBPDYOKM1dv8Psugp00wQvgk/J+FbO0JvZSOnSHz1MbaIHR1MhY/pqieRMUMEpl2N/
 pgQA==
X-Gm-Message-State: AOJu0YyLqUPC+yQtEVQCAvh8dxxlSPwq24HWFixH1vFq8WK7V9nJEFf3
 92umAxgA4fG8cKZFZGXfYNB3SDddmPNEU38kx6vshfyIy2NNqO2QMZMG4assBqpw2aa+ZmJTM2I
 oigU=
X-Gm-Gg: ATEYQzzo6w0ChUKkzinQ6sZBuavuCeNf2PzF6bztBOuj3RQ+kBusyte7bry7+TOvd0H
 ctw4RUWBqYlx6j6fL/4xA/KqA70Q9FaPFRpUTj+sWt7j4aumPjL4s9iN4+rV3UByeE43SC66SEF
 +XvIXpQfLt6WO7O283okoDrMTSVG4JhoTrASipVSYXx0XvzlSibY0Fo4XHIORvadWgR1cDOZrTa
 +QBoT/yFVfad9wvIWvgADHT2QW82RE3pexCbqDRMuoZnrtafzZyrp1BUvK/5vBg9SqEv5OQOBy1
 Mn2vLPWSFv87qabD6x8WZy+6LVf9/ZodoefHlnco53+4nd0fROkjxtN9GBdd4y0AzfGDSU3mqaf
 hu61KL5T0XHZy5sRvq1jE+xXXwcZ/97CSGHUaX6Tx8KD+xYYYH8YYjsM6o7aMxlbF4c9U4XglgH
 WCLwcLgPlNTO323aLaKQ==
X-Received: by 2002:a05:6830:924:b0:7d1:94d0:e8f1 with SMTP id
 46e09a7af769-7d6d12682f3mr1069386a34.15.1772632370982; 
 Wed, 04 Mar 2026 05:52:50 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586226d14sm15599418a34.0.2026.03.04.05.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:52:49 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Tom Rini <trini@konsulko.com>,
 Ludwig <ludwig.nussel@siemens.com>,
 Simon Glass <simon.glass@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH] boot: Add fit_config_get_hash_list() to build signed node list
Date: Wed,  4 Mar 2026 06:51:48 -0700
Message-ID: <20260304135202.1535134-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

The hashed-nodes property in a FIT signature node lists which FDT paths
are included in the signature hash. It is intended as a hint so should
not be used for verification.

Add a function to build the node list from scratch by iterating the
configuration's image references. Skip properties known not to be image
references. For each image, collect the path plus all hash and cipher
subnodes.

Use the new function in fit_config_check_sig() instead of reading
'hashed-nodes'.

Update the docs to cover this. The FIT spec can be updated separately.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 boot/image-fit-sig.c        | 227 +++++++++++++++++++++++++++++-------
 doc/usage/fit/signature.rst |  19 ++-
 2 files changed, 195 insertions(+), 51 deletions(-)

diff --git a/boot/image-fit-sig.c b/boot/image-fit-sig.c
index f23e9d5d0b0..f426ead13c0 100644
--- a/boot/image-fit-sig.c
+++ b/boot/image-fit-sig.c
@@ -18,6 +18,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #include <u-boot/hash-checksum.h>
 
 #define IMAGE_MAX_HASHED_NODES		100
+#define FIT_MAX_HASH_PATH_BUF		4096
 
 /**
  * fit_region_make_list() - Make a list of image regions
@@ -229,6 +230,179 @@ int fit_image_verify_required_sigs(const void *fit, int image_noffset,
 	return 0;
 }
 
+/**
+ * fit_config_add_hash() - Add hash nodes for one image to the node list
+ *
+ * Adds the image path, all its hash-* subnode paths, and its cipher
+ * subnode path (if present) to the packed buffer.
+ *
+ * @fit:		FIT blob
+ * @image_noffset:	Image node offset (e.g. /images/kernel-1)
+ * @node_inc:		Array of path pointers to fill
+ * @count:		Pointer to current count (updated on return)
+ * @max_nodes:		Maximum entries in @node_inc
+ * @buf:		Buffer for packed path strings
+ * @buf_used:		Pointer to bytes used in @buf (updated on return)
+ * @buf_len:		Total size of @buf
+ * Return: 0 on success, -ve on error
+ */
+static int fit_config_add_hash(const void *fit, int image_noffset,
+			       char **node_inc, int *count, int max_nodes,
+			       char *buf, int *buf_used, int buf_len)
+{
+	int noffset, hash_count, ret, len;
+
+	if (*count >= max_nodes)
+		return -ENOSPC;
+
+	ret = fdt_get_path(fit, image_noffset, buf + *buf_used,
+			   buf_len - *buf_used);
+	if (ret < 0)
+		return -ENOENT;
+	len = strlen(buf + *buf_used) + 1;
+	node_inc[(*count)++] = buf + *buf_used;
+	*buf_used += len;
+
+	/* Add all this image's hash subnodes */
+	hash_count = 0;
+	for (noffset = fdt_first_subnode(fit, image_noffset);
+	     noffset >= 0;
+	     noffset = fdt_next_subnode(fit, noffset)) {
+		const char *name = fit_get_name(fit, noffset, NULL);
+
+		if (strncmp(name, FIT_HASH_NODENAME,
+			    strlen(FIT_HASH_NODENAME)))
+			continue;
+		if (*count >= max_nodes)
+			return -ENOSPC;
+		ret = fdt_get_path(fit, noffset, buf + *buf_used,
+				   buf_len - *buf_used);
+		if (ret < 0)
+			return -ENOENT;
+		len = strlen(buf + *buf_used) + 1;
+		node_inc[(*count)++] = buf + *buf_used;
+		*buf_used += len;
+		hash_count++;
+	}
+
+	if (!hash_count) {
+		printf("No hash nodes in image '%s'\n",
+		       fdt_get_name(fit, image_noffset, NULL));
+		return -ENOMSG;
+	}
+
+	/* Add this image's cipher node if present */
+	noffset = fdt_subnode_offset(fit, image_noffset, FIT_CIPHER_NODENAME);
+	if (noffset != -FDT_ERR_NOTFOUND) {
+		if (noffset < 0)
+			return -EIO;
+		if (*count >= max_nodes)
+			return -ENOSPC;
+		ret = fdt_get_path(fit, noffset, buf + *buf_used,
+				   buf_len - *buf_used);
+		if (ret < 0)
+			return -ENOENT;
+		len = strlen(buf + *buf_used) + 1;
+		node_inc[(*count)++] = buf + *buf_used;
+		*buf_used += len;
+	}
+
+	return 0;
+}
+
+/**
+ * fit_config_get_hash_list() - Build the list of nodes to hash
+ *
+ * Works through every image referenced by the configuration and collects the
+ * node paths: root + config + all referenced images with their hash and
+ * cipher subnodes.
+ *
+ * Properties known not to be image references (description, compatible,
+ * default, load-only) are skipped, so any new image type is covered by default.
+ *
+ * @fit:	FIT blob
+ * @conf_noffset: Configuration node offset
+ * @node_inc:	Array to fill with path string pointers
+ * @max_nodes:	Size of @node_inc array
+ * @buf:	Buffer for packed null-terminated path strings
+ * @buf_len:	Size of @buf
+ * Return: number of entries in @node_inc, or -ve on error
+ */
+static int fit_config_get_hash_list(const void *fit, int conf_noffset,
+				    char **node_inc, int max_nodes,
+				    char *buf, int buf_len)
+{
+	const char *conf_name;
+	int image_count;
+	int prop_offset;
+	int used = 0;
+	int count = 0;
+	int ret, len;
+
+	conf_name = fit_get_name(fit, conf_noffset, NULL);
+
+	/* Always include the root node and the configuration node */
+	if (max_nodes < 2)
+		return -ENOSPC;
+
+	len = 2;  /* "/" + nul */
+	if (len > buf_len)
+		return -ENOSPC;
+	strcpy(buf, "/");
+	node_inc[count++] = buf;
+	used += len;
+
+	len = snprintf(buf + used, buf_len - used, "%s/%s", FIT_CONFS_PATH,
+		       conf_name) + 1;
+	if (used + len > buf_len)
+		return -ENOSPC;
+	node_inc[count++] = buf + used;
+	used += len;
+
+	/* Process each image referenced by the config */
+	image_count = 0;
+	fdt_for_each_property_offset(prop_offset, fit, conf_noffset) {
+		const char *prop_name;
+		int img_count, i;
+
+		fdt_getprop_by_offset(fit, prop_offset, &prop_name, NULL);
+		if (!prop_name)
+			continue;
+
+		/* Skip properties that are not image references */
+		if (!strcmp(prop_name, FIT_DESC_PROP) ||
+		    !strcmp(prop_name, FIT_COMPAT_PROP) ||
+		    !strcmp(prop_name, FIT_DEFAULT_PROP))
+			continue;
+
+		img_count = fdt_stringlist_count(fit, conf_noffset, prop_name);
+		for (i = 0; i < img_count; i++) {
+			int noffset;
+
+			noffset = fit_conf_get_prop_node_index(fit,
+							       conf_noffset,
+							       prop_name, i);
+			if (noffset < 0)
+				continue;
+
+			ret = fit_config_add_hash(fit, noffset, node_inc,
+						  &count, max_nodes, buf, &used,
+						  buf_len);
+			if (ret < 0)
+				return ret;
+
+			image_count++;
+		}
+	}
+
+	if (!image_count) {
+		printf("No images in config '%s'\n", conf_name);
+		return -ENOMSG;
+	}
+
+	return count;
+}
+
 /**
  * fit_config_check_sig() - Check the signature of a config
  *
@@ -269,20 +443,16 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		FIT_DATA_POSITION_PROP,
 		FIT_DATA_OFFSET_PROP,
 	};
-
-	const char *prop, *end, *name;
+	char *node_inc[IMAGE_MAX_HASHED_NODES];
+	char hash_buf[FIT_MAX_HASH_PATH_BUF];
 	struct image_sign_info info;
 	const uint32_t *strings;
-	const char *config_name;
 	uint8_t *fit_value;
 	int fit_value_len;
-	bool found_config;
 	int max_regions;
-	int i, prop_len;
 	char path[200];
 	int count;
 
-	config_name = fit_get_name(fit, conf_noffset, NULL);
 	debug("%s: fdt=%p, conf='%s', sig='%s'\n", __func__, key_blob,
 	      fit_get_name(fit, noffset, NULL),
 	      fit_get_name(key_blob, required_keynode, NULL));
@@ -297,45 +467,12 @@ static int fit_config_check_sig(const void *fit, int noffset, int conf_noffset,
 		return -1;
 	}
 
-	/* Count the number of strings in the property */
-	prop = fdt_getprop(fit, noffset, "hashed-nodes", &prop_len);
-	end = prop ? prop + prop_len : prop;
-	for (name = prop, count = 0; name < end; name++)
-		if (!*name)
-			count++;
-	if (!count) {
-		*err_msgp = "Can't get hashed-nodes property";
-		return -1;
-	}
-
-	if (prop && prop_len > 0 && prop[prop_len - 1] != '\0') {
-		*err_msgp = "hashed-nodes property must be null-terminated";
-		return -1;
-	}
-
-	/* Add a sanity check here since we are using the stack */
-	if (count > IMAGE_MAX_HASHED_NODES) {
-		*err_msgp = "Number of hashed nodes exceeds maximum";
-		return -1;
-	}
-
-	/* Create a list of node names from those strings */
-	char *node_inc[count];
-
-	debug("Hash nodes (%d):\n", count);
-	found_config = false;
-	for (name = prop, i = 0; name < end; name += strlen(name) + 1, i++) {
-		debug("   '%s'\n", name);
-		node_inc[i] = (char *)name;
-		if (!strncmp(FIT_CONFS_PATH, name, strlen(FIT_CONFS_PATH)) &&
-		    name[sizeof(FIT_CONFS_PATH) - 1] == '/' &&
-		    !strcmp(name + sizeof(FIT_CONFS_PATH), config_name)) {
-			debug("      (found config node %s)", config_name);
-			found_config = true;
-		}
-	}
-	if (!found_config) {
-		*err_msgp = "Selected config not in hashed nodes";
+	/* Build the node list from the config, ignoring hashed-nodes */
+	count = fit_config_get_hash_list(fit, conf_noffset,
+					 node_inc, IMAGE_MAX_HASHED_NODES,
+					 hash_buf, sizeof(hash_buf));
+	if (count < 0) {
+		*err_msgp = "Failed to build hash node list";
 		return -1;
 	}
 
diff --git a/doc/usage/fit/signature.rst b/doc/usage/fit/signature.rst
index e5b5a8432e9..da08cc75c3a 100644
--- a/doc/usage/fit/signature.rst
+++ b/doc/usage/fit/signature.rst
@@ -353,20 +353,27 @@ meantime.
 Details
 -------
 The signature node contains a property ('hashed-nodes') which lists all the
-nodes that the signature was made over.  The image is walked in order and each
-tag processed as follows:
+nodes that the signature was made over.  The signer (mkimage) writes this
+property as a record of what was included in the hash.  During verification,
+however, U-Boot does not read 'hashed-nodes'. Instead it rebuilds the node
+list from the configuration's own image references (kernel, fdt, ramdisk,
+etc.), since 'hashed-nodes' is not itself covered by the signature. The
+rebuilt list always includes the root node, the configuration node, each
+referenced image node and its hash/cipher subnodes.
+
+The image is walked in order and each tag processed as follows:
 
 DTB_BEGIN_NODE
     The tag and the following name are included in the signature
-    if the node or its parent are present in 'hashed-nodes'
+    if the node or its parent are present in the node list
 
 DTB_END_NODE
     The tag is included in the signature if the node or its parent
-    are present in 'hashed-nodes'
+    are present in the node list
 
 DTB_PROPERTY
     The tag, the length word, the offset in the string table, and
-    the data are all included if the current node is present in 'hashed-nodes'
+    the data are all included if the current node is present in the node list
     and the property name is not 'data'.
 
 DTB_END
@@ -374,7 +381,7 @@ DTB_END
 
 DTB_NOP
     The tag is included in the signature if the current node is present
-    in 'hashed-nodes'
+    in the node list
 
 In addition, the signature contains a property 'hashed-strings' which contains
 the offset and length in the string table of the strings that are to be
-- 
2.43.0

base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
branch: fitg
