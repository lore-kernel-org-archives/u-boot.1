Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C024F513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 01:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD42B838BB;
	Fri,  6 Mar 2026 02:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="F6ujwLFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4796283F2E; Fri,  6 Mar 2026 02:24:26 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90AEF836D3
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 02:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-506362ac5f7so80022451cf.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 17:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772760262; x=1773365062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qPRU6PB4dGGAWVGOCd8wWVl2OCHCZrPcZKsocCPtRZg=;
 b=F6ujwLFavF9x02CQN15QIEZrRSBd4Hup/OaPYThKbiz4+4DYAbJWI4U2JO72HC6rDN
 mOB5BBemQlAx3WDICkjGtJMyEsNIYs+ZMi9VLPdmlfNpOao/otZztcTA+rc00Aimxaqi
 0+lP6Lyy/04hK+Y1e7MF+L0t6Oznn0iLcBzmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772760262; x=1773365062;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qPRU6PB4dGGAWVGOCd8wWVl2OCHCZrPcZKsocCPtRZg=;
 b=twTqpTWPBpoZyCeIjK34XNSEJsFWehLjiqlj1ia2IbYP05sieEDUY8Rgt0FowMa/dd
 v1RgWSVmpIXSUjXwnKLnWYNTiPc0I+Kbh9l5g+TJhjg4FPFm1XmOc20up4boD2xfAzzw
 Jdp4grlxFywfupe3eaESWMFFZ+MKSVvWasSZzHpy4mkz3vRJEC6epKMXfjAMhEsiP5Xl
 ubcd4e2malKco2K0FGDMZzs7KXDdSzenxxouPC+BS6z9vEJ/lh0QXArask91xR51N3Gh
 szjPVhPkgPYCWEcPrfzB67+QqjNa1ZfhOzwKkksmRepTdtgHi2K2sY7gvEQVz5pK6Jlr
 iIAQ==
X-Gm-Message-State: AOJu0YxtDk+5Qsg3RUTglYGw+o3vcdk9rW5GFxhVUwNPwiP32ByUjgRG
 vdmPmjGobr0oiFExke92s7tLDA7TlmBq4ZB2Bc2aUaMuB7ZAMr8WhUkyvdMxgIOxv8t1/USmb7a
 bynQ=
X-Gm-Gg: ATEYQzwHqSoF4uYFdG+fsdwmUIMQEU5d83SD4KjZinX7D7TNWzeJPxfagYclvG53Oi6
 /sl6gd+wRoug0hJP/XKzj3smLiFy+K0YB6pdMeNsrgfiStH1TUIHWgo7Og0pRdUukPbtmoxWvd3
 gGTw9ALmBWKcdaROPLZCGMP39M9a7N9lxfXePBosIMj4IZrhlJ8tE/8mdvLjSKndU5mkYkM5QDJ
 8kVzbtOXZMcbIFr4LwFKBARrvZ6ynnKjyLt8UT/KNqLQSco9zbI2rlnPk67kNwDlhBMV3FNehLu
 DzPQl/60EGVrlkeWKAY9qqrx6Q+9QPxrem27SdLjqAbRdOxvbuh4W0d3qgIRh1wJ/boiwwMt1na
 24xEpK3fu8NeUdkrbdDCDcZC62/UnzLb3h6eSDq+DuKtPEdivsh1SgBeP3GxVFBgIsfwIlKbo4D
 NE6s1GbaNTFMNcd77xTA==
X-Received: by 2002:a05:622a:14cd:b0:4ff:9688:7dca with SMTP id
 d75a77b69052e-508f470587fmr6028201cf.8.1772760261820; 
 Thu, 05 Mar 2026 17:24:21 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449630b6sm213755891cf.7.2026.03.05.17.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 17:24:21 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Ludwig <ludwig.nussel@siemens.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Simon Glass <simon.glass@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed node
 list
Date: Thu,  5 Mar 2026 18:20:09 -0700
Message-ID: <20260306012019.800588-1-sjg@chromium.org>
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

Update the test_vboot kernel@ test case: fit_check_sign now catches the
attack at signature-verification time (the @-suffixed node is hashed
instead of the real one, causing a mismatch) rather than at
fit_check_format() time.

Update the docs to cover this. The FIT spec can be updated separately.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Update messages for a test case

 boot/image-fit-sig.c        | 227 +++++++++++++++++++++++++++++-------
 doc/usage/fit/signature.rst |  19 ++-
 test/py/tests/test_vboot.py |   8 +-
 3 files changed, 201 insertions(+), 53 deletions(-)

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
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index 7a7f9c379de..19f3f981379 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -362,10 +362,14 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             shutil.copyfile(fit, efit)
             vboot_evil.add_evil_node(fit, efit, evil_kernel, 'kernel@')
 
-            msg = 'Signature checking prevents use of unit addresses (@) in nodes'
+            # fit_check_sign catches this via signature mismatch (the @
+            # node is hashed instead of the real one)
             utils.run_and_log_expect_exception(
                 ubman, [fit_check_sign, '-f', efit, '-k', dtb],
-                1, msg)
+                1, 'Failed to verify required signature')
+
+            # bootm catches it earlier, at fit_check_format() time
+            msg = 'Signature checking prevents use of unit addresses (@) in nodes'
             run_bootm(sha_algo, 'evil kernel@', msg, False, efit)
 
         # Create a new properly signed fit and replace header bytes
-- 
2.43.0

base-commit: c0ca147ac6228949a6d6497531c9f2f4a0dc6c67
branch: fitg2
