Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8A6D2ED0A
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 14:16:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64368840ED;
	Wed,  1 Apr 2026 16:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wVqYASCT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E36F840D8; Wed,  1 Apr 2026 16:15:32 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D63D683CE3
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 16:15:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso92209145e9.3
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775052929; x=1775657729; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ygNuSeQGX7Q2b/F+EBUD44n+zE24EFeQxx8wjWtK2jE=;
 b=wVqYASCTv5IrDAe6uA7iA8RTCtGD42hJldrAQDa/iXgEKN6sfoKjw9kd0fzhM5aFQa
 spjsSym0G91HzVeTGrzKdLIsjerb6R2OsLqkc604ddojRfx/VssOlGIpsS0J7uD31E8y
 aqKT/mb+A9gBwaI1O7v0nAgNpH6Hbk63lMpW37al7HVaIr3QIuok1cJUplHiXgeXMbzf
 Hc2d/0q8WqyswJRUFsOLVCAGkPNG4xgbJkI/cls2Sh4W4dU9rxGoVGHWVI6nTx9XU2ou
 iuK7r+2IjRw3JHVptFWIli/p4KzOMgOvtdWaAUzZZLsn92cIdt40VcZ2dHdxX2d9zwHI
 OegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775052929; x=1775657729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ygNuSeQGX7Q2b/F+EBUD44n+zE24EFeQxx8wjWtK2jE=;
 b=Xtc8sx80GDuFePIz+GxY4Y2YfHzbvudEdtll4Vu9Ap6zEdO9URJvBchvhHoD6Kro78
 VktF78J1p19kVaoD4lB0WJWEQFBZh4UwguDP77aR6Jzgp1fGTiJdCVinSeuuSqsIKL0T
 nqpS/j1oVOviiztpfWuP9Mu8NCRa8hTcGE5XZtrZZGOWFSO2k1RJwUDcKdvUsBJrqvWu
 a9KZPMcVvUUk+AaUMR7w9ALjwjnEYHxSb6bjRwb0PKwgyNUNHg9A2Ryhkmk3pYSKltH+
 Ic3awvn0DIXSMoQeuZ2f0zSqiiVOOG/yxgQjqh3Hy+qtHOuKMtx0vX7C+ffl/yPd5dMJ
 uPCg==
X-Gm-Message-State: AOJu0YzXboqmUo+28v12AuP9hrb/o1vxjZmO1FaaMqT+fGnmjUHiVsS1
 OvPtYxhqCv1zrFHQuxsB/Wxjn4TiXvsOiFh3M0K68qDjFQgE7s3aiPMubxQDlSDL35Y=
X-Gm-Gg: ATEYQzxAcxuEE7Egzx/UVhKMGDwKnFB0TG6QF6ksnnjU5buzuRXwcvPN15SMw7gF/ni
 n5leZgHcim2THkKVNYPrC2gR3nsaWQZtjKpUyG3gXYmKJfXyuiuECsP3vHEb8FzU6NaNtnWSvTC
 nYh/9vBT8iZexP1xDDe+cez3V0mevENCQt5NmgUa3lHzb2mlT646N27q9iByPzJ4FZy9lbqyihV
 yVMlQdSap9Cfub/LY3dso6v/OBNPveTt7i6gVk24h6S5x1TwOXz+zcjUzI8r+jCDu/QctNIh3gk
 npLYmOrvwRHru1gqllvQBsPjcN/Ab+nhz3QA7f1Gx7dtRiYv1fbCUjsTVBR5qJG5FsaybvxZNFw
 VR550YSSpSX8THp9MPjLPYdPsVUj3W+olUbWz7e7hc6x2y/jv/QLpS3GRcdqxxi+pwhuLvRE+jm
 DSK2q3pEoVr9t56QiWG0WMKK4Ii9NPTor6Fqb2H+NHeJpETKy+ggzSsmg1AuajhJ38DC3J
X-Received: by 2002:a05:600c:a406:b0:485:40fd:8390 with SMTP id
 5b1f17b1804b1-488835ccc61mr50601585e9.26.1775052929182; 
 Wed, 01 Apr 2026 07:15:29 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c8bcaf8sm43224135e9.27.2026.04.01.07.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 07:15:28 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Wed, 01 Apr 2026 16:15:20 +0200
Subject: [PATCH v2 04/11] ofnode: add read_u64_array and
 count_elems_of_size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-casey-ccf-compat-v2-4-414d5b7f040b@linaro.org>
References: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
In-Reply-To: <20260401-casey-ccf-compat-v2-0-414d5b7f040b@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Romain Gantois <romain.gantois@bootlin.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=11186;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=4U4486dk/kYnPVEPw0EBh1G48lAL739YPPX7748xid0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyzGpX/zrJ/OBCzZe2KNMW6+TMqg6oV7Itt59wKTpQ6v
 +ro8iTZjlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjARwTeMDAskhTwZt7c8ubBo
 UoyTpvy1rOvl+Ycmh/h0HfzOevn4HgdGhiWzzS6YWTw4tkXZdV5ua/uLK+FdmhXBKxrqNwgr5KZ
 kHQEA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

These are similar to their Linux counterparts, adding helpers
for reading arrays of 64-bit values with of_access and fdtdec
implementations.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 drivers/core/of_access.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/core/ofnode.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++
 include/dm/of_access.h   | 20 +++++++++++++++++++
 include/dm/ofnode.h      | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 include/fdtdec.h         | 16 +++++++++++++++
 lib/fdtdec.c             | 18 +++++++++++++++++
 6 files changed, 204 insertions(+)

diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index b11e36202c15..969492aae37c 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -597,8 +597,27 @@ int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
 {
 	return of_read_u64_index(np, propname, 0, outp);
 }
 
+int of_read_u64_array(const struct device_node *np, const char *propname,
+		      u64 *out_values, size_t sz)
+{
+	const __be64 *val;
+
+	log_debug("%s: %s: ", __func__, propname);
+	val = of_find_property_value_of_size(np, propname,
+					     sz * sizeof(*out_values));
+
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	log_debug("size %zd\n", sz);
+	while (sz--)
+		*out_values++ = be64_to_cpup(val++);
+
+	return 0;
+}
+
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
 {
 	int len = 0;
@@ -844,8 +863,41 @@ int of_count_phandle_with_args(const struct device_node *np,
 	return of_root_count_phandle_with_args(NULL, np, list_name, cells_name,
 					       cell_count);
 }
 
+/**
+ * of_property_count_elems_of_size - Count the number of elements in a property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @elem_size:	size of the individual element
+ *
+ * Search for a property in a device node and count the number of elements of
+ * size elem_size in it.
+ *
+ * Return: The number of elements on sucess, -EINVAL if the property does not
+ * exist or its length does not match a multiple of elem_size and -ENODATA if
+ * the property does not have a value.
+ */
+int of_property_count_elems_of_size(const struct device_node *np,
+				const char *propname, int elem_size)
+{
+	const struct property *prop = of_find_property(np, propname, NULL);
+
+	if (!prop)
+		return -EINVAL;
+	if (!prop->value)
+		return -ENODATA;
+
+	if (prop->length % elem_size != 0) {
+		pr_err("size of %s in node %pOF is not a multiple of %d\n",
+		       propname, np, elem_size);
+		return -EINVAL;
+	}
+
+	return prop->length / elem_size;
+}
+
 static void of_alias_add(struct alias_prop *ap, struct device_node *np,
 			 int id, const char *stem, int stem_len)
 {
 	ap->np = np;
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 3a36b6fdd031..d605c0f7b7c7 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -663,8 +663,56 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
 		return ret;
 	}
 }
 
+int ofnode_read_u64_array(ofnode node, const char *propname,
+			  u64 *out_values, size_t sz)
+{
+	assert(ofnode_valid(node));
+	log_debug("%s: %s: ", __func__, propname);
+
+	if (ofnode_is_np(node)) {
+		return of_read_u64_array(ofnode_to_np(node), propname,
+					 out_values, sz);
+	} else {
+		int ret;
+
+		ret = fdtdec_get_long_array(ofnode_to_fdt(node),
+					   ofnode_to_offset(node), propname,
+					   out_values, sz);
+
+		/* get the error right, but space is more important in SPL */
+		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
+			if (ret == -FDT_ERR_NOTFOUND)
+				return -EINVAL;
+			else if (ret == -FDT_ERR_BADLAYOUT)
+				return -EOVERFLOW;
+		}
+		return ret;
+	}
+}
+
+int ofnode_count_elems_of_size(ofnode node, const char *propname, int elem_size)
+{
+	const char *prop;
+	int len;
+	assert(ofnode_valid(node));
+
+	if (ofnode_is_np(node)) {
+		return of_property_count_elems_of_size(node.np, propname, elem_size);
+	} else {
+		prop = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node), propname, &len);
+		if (!prop)
+			return -ENOENT;
+		if (len % elem_size != 0) {
+			log_debug("size of %s in node %pOF is not a multiple of %d\n",
+			       propname, &node, elem_size);
+			return -EINVAL;
+		}
+		return len / elem_size;
+	}
+}
+
 #if !CONFIG_IS_ENABLED(DM_INLINE_OFNODE)
 bool ofnode_is_enabled(ofnode node)
 {
 	if (ofnode_is_np(node)) {
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index 44143a5a3917..fe0de73d7e25 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -384,8 +384,25 @@ int of_read_u64(const struct device_node *np, const char *propname, u64 *outp);
  */
 int of_read_u32_array(const struct device_node *np, const char *propname,
 		      u32 *out_values, size_t sz);
 
+/**
+ * of_read_u64_array() - Find and read an array of 64 bit integers
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it.
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @out_values:	pointer to return value, modified only if return value is 0.
+ * @sz:		number of array elements to read
+ * Return:
+ *   0 on success, -EINVAL if the property does not exist, or -EOVERFLOW if
+ *   longer than sz.
+ */
+int of_read_u64_array(const struct device_node *np, const char *propname,
+		      u64 *out_values, size_t sz);
+
 /**
  * of_property_match_string() - Find string in a list and return index
  *
  * This function searches a string list property and returns the index
@@ -615,8 +632,11 @@ int of_parse_phandle_with_args(const struct device_node *np,
 int of_count_phandle_with_args(const struct device_node *np,
 			       const char *list_name, const char *cells_name,
 			       int cells_count);
 
+int of_property_count_elems_of_size(const struct device_node *np,
+				const char *propname, int elem_size);
+
 /**
  * of_alias_scan() - Scan all properties of the 'aliases' node
  *
  * The function scans all the properties of the 'aliases' node and populates
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 120393426dbf..c905e86b2835 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -374,8 +374,15 @@ static inline oftree oftree_from_np(struct device_node *root)
 
 	return tree;
 }
 
+/* Dummy put for Linux compat */
+static inline void ofnode_put(ofnode node)
+{
+	if (ofnode_is_np(node))
+		of_node_put(node.np);
+}
+
 /**
  * oftree_dispose() - Dispose of an oftree
  *
  * This can be used to dispose of a tree that has been created (other than
@@ -587,8 +594,27 @@ const char *ofnode_read_string(ofnode node, const char *propname);
  */
 int ofnode_read_u32_array(ofnode node, const char *propname,
 			  u32 *out_values, size_t sz);
 
+/**
+ * ofnode_read_u64_array() - Find and read an array of 64 bit integers
+ *
+ * @node:	valid node reference to read property from
+ * @propname:	name of the property to read
+ * @out_values:	pointer to return value, modified only if return value is 0
+ * @sz:		number of array elements to read
+ * Return: 0 on success, -EINVAL if the property does not exist,
+ * -ENODATA if property does not have a value, and -EOVERFLOW if the
+ * property data isn't large enough
+ *
+ * Search for a property in a device node and read 64-bit value(s) from
+ * it.
+ *
+ * The out_values is modified only if a valid u64 value can be decoded.
+ */
+int ofnode_read_u64_array(ofnode node, const char *propname,
+			  u64 *out_values, size_t sz);
+
 /**
  * ofnode_read_bool() - read a boolean value from a property
  *
  * @node:	valid node reference to read property from
@@ -651,8 +677,32 @@ static inline ofnode ofnode_next_subnode(ofnode node)
 	return offset_to_ofnode(
 		fdt_next_subnode(gd->fdt_blob, ofnode_to_offset(node)));
 }
 #else
+
+/**
+ * ofnode_count_elems_of_size() - count the number of elements of size @elem_size
+ * in the property @propname.
+ *
+ * @node: ofnode to check
+ * @propname: the name of the property to count
+ * @elem_size: the size of each element
+ *
+ * Returns: the number of elements or -EINVAL if the property size is not a
+ * multiple of elem_size.
+ */
+int ofnode_count_elems_of_size(ofnode node, const char *propname, int elem_size);
+
+static inline int ofnode_count_u32_elems(ofnode node, const char *propname)
+{
+	return ofnode_count_elems_of_size(node, propname, 4);
+}
+
+static inline int ofnode_count_u64_elems(ofnode node, const char *propname)
+{
+	return ofnode_count_elems_of_size(node, propname, 8);
+}
+
 /**
  * ofnode_is_enabled() - Checks whether a node is enabled.
  * This looks for a 'status' property. If this exists, then returns true if
  * the status is 'okay' and false otherwise. If there is no status property,
diff --git a/include/fdtdec.h b/include/fdtdec.h
index d9fcd037ed26..3d199e56b031 100644
--- a/include/fdtdec.h
+++ b/include/fdtdec.h
@@ -699,8 +699,24 @@ int fdtdec_lookup_phandle(const void *blob, int node, const char *prop_name);
  */
 int fdtdec_get_int_array(const void *blob, int node, const char *prop_name,
 		u32 *array, int count);
 
+/**
+ * Look up a property in a node and return its contents in a u64
+ * array of given length. The property must have at least enough data for
+ * the array (8*count bytes). It may have more, but this will be ignored.
+ *
+ * @param blob		FDT blob
+ * @param node		node to examine
+ * @param prop_name	name of property to find
+ * @param array		array to fill with data
+ * @param count		number of array elements
+ * Return: 0 if ok, or -FDT_ERR_NOTFOUND if the property is not found,
+ *		or -FDT_ERR_BADLAYOUT if not enough data
+ */
+int fdtdec_get_long_array(const void *blob, int node, const char *prop_name,
+		u64 *array, int count);
+
 /**
  * Look up a property in a node and return its contents in an integer
  * array of given length. The property must exist but may have less data that
  * expected (4*count bytes). It may have more, but this will be ignored.
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c38738b48c79..e23e53f58f24 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -713,8 +713,26 @@ int fdtdec_get_int_array(const void *blob, int node, const char *prop_name,
 	}
 	return err;
 }
 
+int fdtdec_get_long_array(const void *blob, int node, const char *prop_name,
+			 u64 *array, int count)
+{
+	const u64 *cell;
+	int err = 0;
+
+	debug("%s: %s\n", __func__, prop_name);
+	cell = get_prop_check_min_len(blob, node, prop_name,
+				      sizeof(u64) * count, &err);
+	if (!err) {
+		int i;
+
+		for (i = 0; i < count; i++)
+			array[i] = fdt64_to_cpu(cell[i]);
+	}
+	return err;
+}
+
 int fdtdec_get_int_array_count(const void *blob, int node,
 			       const char *prop_name, u32 *array, int count)
 {
 	const u32 *cell;

-- 
2.51.0

