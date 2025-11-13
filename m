Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ABECD6E41
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 12:22:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4352983DDD;
	Thu, 13 Nov 2025 13:22:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="dJ/taU1W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="srCq9bqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBA6383E21; Thu, 13 Nov 2025 13:22:00 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFBF83D77
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4d6fXQ0Yzhz9tlM;
 Thu, 13 Nov 2025 13:21:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763036518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mY6jnZ9XzZx/QpoIIvONQZ2WUhmRE40uJt1YqRZJRs=;
 b=dJ/taU1WXRPUmK1Rak6M+pjWik411R6/TB1eDIMHTrLKtaSUMPNRhWaNQn//oV+XoTTRP5
 wBf022I07zz5MrIQByIWIvssDygqLCREnI2UhY6lDxRtslbVGAQKSMgO6l+pdv0Lr7Rk4d
 gF05A2XkoT0i7qxgJJMX8DmxYtx8aUyADX7ZUxb/keOxMJPf7+Mevxn0dh5k27mK1e8pVt
 VYq/BhqN9cwKI86FzfgLmrlZdmCUbXdOOopAt8ckWzuCeh0Cf9gKEiuYhUtO9gNNHBTgW5
 krko117CSNxnVSc3mTQ4FTM8UQ5X2Y/tKvUl7M01pVLjCBfcShS3Y1Yzq7d1Hg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763036516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mY6jnZ9XzZx/QpoIIvONQZ2WUhmRE40uJt1YqRZJRs=;
 b=srCq9bquief4PJZQFiyF5ia8ccsKXvt/02TjZpCqUylZCb0MqxypX2r4LdygQZJQsOgjJW
 oEvoAokWtyUbjcVQXM1N6PWsPVzeOM4iTxFsp6KdzX9RzY2VQgWcWdbbGYqVIpbh6uyFIg
 /oSFqW2vbg24Fajd61D5MLI+9o1RudBx7tzGHOkVGdSXEXmfi6CaRmLTiBdWS+xuoLF83j
 AF+PYY0MICjJ+bE3XyCmp5TVm4KdCH30hXFdU4x6xb5VYhP2vDlM1hvTgSBKT/MmXyUhP0
 ZimNACe4JcK+8mbZFNcae0MTB+UuWWqr/DimEpykjNJlpHPqUqQ84OMbtl454Q==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/3] dm: core: Check ofnode_to_offset() return value
Date: Thu, 13 Nov 2025 13:21:08 +0100
Message-ID: <20251113122145.949112-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pqccgi5dijxd6nhi13pfmxw81y8okdif
X-MBO-RS-ID: 77492dfa0ea3086d150
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

The ofnode_to_offset() may return -1 , which is not a valid value
and is not accepted by modern libfdt 1.7.2. Check the return value
from ofnode_to_offset() and exit early in case it is not a valid
offset.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adriano Cordova <adrianox@gmail.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Sam Edwards <cfsworks@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/core/ofnode.c | 384 +++++++++++++++++++++++++++++++-----------
 1 file changed, 284 insertions(+), 100 deletions(-)

diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index 071d998a0a5..55c2b3a10bb 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -335,7 +335,7 @@ bool ofnode_name_eq_unit(ofnode node, const char *name)
 int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
 {
 	const u8 *cell;
-	int len;
+	int len, off;
 
 	assert(ofnode_valid(node));
 	log_debug("%s: %s: ", __func__, propname);
@@ -343,8 +343,13 @@ int ofnode_read_u8(ofnode node, const char *propname, u8 *outp)
 	if (ofnode_is_np(node))
 		return of_read_u8(ofnode_to_np(node), propname, outp);
 
-	cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
-			   &len);
+	off = ofnode_to_offset(node);
+	if (off < 0) {
+		log_debug("(not valid)\n");
+		return -EINVAL;
+	}
+
+	cell = fdt_getprop(gd->fdt_blob, off, propname, &len);
 	if (!cell || len < sizeof(*cell)) {
 		log_debug("(not found)\n");
 		return -EINVAL;
@@ -366,7 +371,7 @@ u8 ofnode_read_u8_default(ofnode node, const char *propname, u8 def)
 int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
 {
 	const fdt16_t *cell;
-	int len;
+	int len, off;
 
 	assert(ofnode_valid(node));
 	log_debug("%s: %s: ", __func__, propname);
@@ -374,8 +379,13 @@ int ofnode_read_u16(ofnode node, const char *propname, u16 *outp)
 	if (ofnode_is_np(node))
 		return of_read_u16(ofnode_to_np(node), propname, outp);
 
-	cell = fdt_getprop(gd->fdt_blob, ofnode_to_offset(node), propname,
-			   &len);
+	off = ofnode_to_offset(node);
+	if (off < 0) {
+		log_debug("(not valid)\n");
+		return -EINVAL;
+	}
+
+	cell = fdt_getprop(gd->fdt_blob, off, propname, &len);
 	if (!cell || len < sizeof(*cell)) {
 		log_debug("(not found)\n");
 		return -EINVAL;
@@ -411,7 +421,7 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 			  u32 *outp)
 {
 	const fdt32_t *cell;
-	int len;
+	int len, off;
 
 	assert(ofnode_valid(node));
 	log_debug("%s: %s: ", __func__, propname);
@@ -420,8 +430,13 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 		return of_read_u32_index(ofnode_to_np(node), propname, index,
 					 outp);
 
-	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-			   propname, &len);
+	off = ofnode_to_offset(node);
+	if (off < 0) {
+		log_debug("(not valid)\n");
+		return -EINVAL;
+	}
+
+	cell = fdt_getprop(ofnode_to_fdt(node), off, propname, &len);
 	if (!cell) {
 		log_debug("(not found)\n");
 		return -EINVAL;
@@ -442,7 +457,7 @@ int ofnode_read_u64_index(ofnode node, const char *propname, int index,
 			  u64 *outp)
 {
 	const fdt64_t *cell;
-	int len;
+	int len, off;
 
 	assert(ofnode_valid(node));
 
@@ -450,8 +465,13 @@ int ofnode_read_u64_index(ofnode node, const char *propname, int index,
 		return of_read_u64_index(ofnode_to_np(node), propname, index,
 					 outp);
 
-	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-			   propname, &len);
+	off = ofnode_to_offset(node);
+	if (off < 0) {
+		log_debug("(not valid)\n");
+		return -EINVAL;
+	}
+
+	cell = fdt_getprop(ofnode_to_fdt(node), off, propname, &len);
 	if (!cell) {
 		log_debug("(not found)\n");
 		return -EINVAL;
@@ -488,7 +508,7 @@ int ofnode_read_s32_default(ofnode node, const char *propname, s32 def)
 int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
 {
 	const unaligned_fdt64_t *cell;
-	int len;
+	int len, off;
 
 	assert(ofnode_valid(node));
 	log_debug("%s: %s: ", __func__, propname);
@@ -496,8 +516,13 @@ int ofnode_read_u64(ofnode node, const char *propname, u64 *outp)
 	if (ofnode_is_np(node))
 		return of_read_u64(ofnode_to_np(node), propname, outp);
 
-	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-			   propname, &len);
+	off = ofnode_to_offset(node);
+	if (off < 0) {
+		log_debug("(not valid)\n");
+		return -EINVAL;
+	}
+
+	cell = fdt_getprop(ofnode_to_fdt(node), off, propname, &len);
 	if (!cell || len < sizeof(*cell)) {
 		log_debug("(not found)\n");
 		return -EINVAL;
@@ -534,7 +559,7 @@ bool ofnode_read_bool(ofnode node, const char *propname)
 const void *ofnode_read_prop(ofnode node, const char *propname, int *sizep)
 {
 	const char *val = NULL;
-	int len;
+	int len, off;
 
 	assert(ofnode_valid(node));
 	log_debug("%s: %s: ", __func__, propname);
@@ -548,8 +573,13 @@ const void *ofnode_read_prop(ofnode node, const char *propname, int *sizep)
 			len = prop->length;
 		}
 	} else {
-		val = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-				  propname, &len);
+		off = ofnode_to_offset(node);
+		if (off < 0) {
+			log_debug("<not valid>\n");
+			return NULL;
+		}
+
+		val = fdt_getprop(ofnode_to_fdt(node), off, propname, &len);
 	}
 	if (!val) {
 		log_debug("<not found>\n");
@@ -602,8 +632,13 @@ ofnode ofnode_find_subnode(ofnode node, const char *subnode_name)
 		subnode = ofnode_find_subnode_unit(node, subnode_name);
 	} else {
 		/* special case to avoid code-size increase */
-		int ooffset = fdt_subnode_offset(ofnode_to_fdt(node),
-				ofnode_to_offset(node), subnode_name);
+		int ooffset, off;
+
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return ofnode_null();
+
+		ooffset = fdt_subnode_offset(ofnode_to_fdt(node), off, subnode_name);
 		subnode = noffset_to_ofnode(node, ooffset);
 	}
 	log_debug("%s\n", ofnode_valid(subnode) ?
@@ -642,11 +677,14 @@ int ofnode_read_u32_array(ofnode node, const char *propname,
 		return of_read_u32_array(ofnode_to_np(node), propname,
 					 out_values, sz);
 	} else {
-		int ret;
+		int ret, off;
+
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return -EINVAL;
 
-		ret = fdtdec_get_int_array(ofnode_to_fdt(node),
-					   ofnode_to_offset(node), propname,
-					   out_values, sz);
+		ret = fdtdec_get_int_array(ofnode_to_fdt(node), off,
+					   propname, out_values, sz);
 
 		/* get the error right, but space is more important in SPL */
 		if (!IS_ENABLED(CONFIG_XPL_BUILD)) {
@@ -665,48 +703,71 @@ bool ofnode_is_enabled(ofnode node)
 	if (ofnode_is_np(node)) {
 		return of_device_is_available(ofnode_to_np(node));
 	} else {
-		return fdtdec_get_is_enabled(ofnode_to_fdt(node),
-					     ofnode_to_offset(node));
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return false;
+
+		return fdtdec_get_is_enabled(ofnode_to_fdt(node), off);
 	}
 }
 
 ofnode ofnode_first_subnode(ofnode node)
 {
+	int off;
+
 	assert(ofnode_valid(node));
 	if (ofnode_is_np(node))
 		return np_to_ofnode(node.np->child);
 
+	off = ofnode_to_offset(node);
+	if (off < 0)
+		return ofnode_null();
+
 	return noffset_to_ofnode(node,
-		fdt_first_subnode(ofnode_to_fdt(node), ofnode_to_offset(node)));
+		fdt_first_subnode(ofnode_to_fdt(node), off));
 }
 
 ofnode ofnode_next_subnode(ofnode node)
 {
+	int off;
+
 	assert(ofnode_valid(node));
 	if (ofnode_is_np(node))
 		return np_to_ofnode(node.np->sibling);
 
+	off = ofnode_to_offset(node);
+	if (off < 0)
+		return ofnode_null();
+
 	return noffset_to_ofnode(node,
-		fdt_next_subnode(ofnode_to_fdt(node), ofnode_to_offset(node)));
+		fdt_next_subnode(ofnode_to_fdt(node), off));
 }
 #endif /* !DM_INLINE_OFNODE */
 
 ofnode ofnode_get_parent(ofnode node)
 {
 	ofnode parent;
+	int off;
 
 	assert(ofnode_valid(node));
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		parent = np_to_ofnode(of_get_parent(ofnode_to_np(node)));
-	else
-		parent.of_offset = fdt_parent_offset(ofnode_to_fdt(node),
-						     ofnode_to_offset(node));
+	} else {
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return ofnode_null();
+
+		parent.of_offset = fdt_parent_offset(ofnode_to_fdt(node), off);
+	}
 
 	return parent;
 }
 
 const char *ofnode_get_name(ofnode node)
 {
+	int off;
+
 	if (!ofnode_valid(node)) {
 		dm_warn("%s node not valid\n", __func__);
 		return NULL;
@@ -715,7 +776,11 @@ const char *ofnode_get_name(ofnode node)
 	if (ofnode_is_np(node))
 		return node.np->name;
 
-	return fdt_get_name(ofnode_to_fdt(node), ofnode_to_offset(node), NULL);
+	off = ofnode_to_offset(node);
+	if (off < 0)
+		return NULL;
+
+	return fdt_get_name(ofnode_to_fdt(node), off, NULL);
 }
 
 int ofnode_get_path(ofnode node, char *buf, int buflen)
@@ -730,10 +795,13 @@ int ofnode_get_path(ofnode node, char *buf, int buflen)
 
 		return 0;
 	} else {
-		int res;
+		int off, res;
 
-		res = fdt_get_path(ofnode_to_fdt(node), ofnode_to_offset(node), buf,
-				   buflen);
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return -EINVAL;
+
+		res = fdt_get_path(ofnode_to_fdt(node), off, buf, buflen);
 		if (!res)
 			return res;
 		else if (res == -FDT_ERR_NOSPACE)
@@ -773,7 +841,7 @@ ofnode oftree_get_by_phandle(oftree tree, uint phandle)
 static fdt_addr_t __ofnode_get_addr_size_index(ofnode node, int index,
 					       fdt_size_t *size, bool translate)
 {
-	int na, ns;
+	int na, ns, off;
 
 	if (size)
 		*size = FDT_SIZE_T_NONE;
@@ -803,8 +871,13 @@ static fdt_addr_t __ofnode_get_addr_size_index(ofnode node, int index,
 		ofnode parent = ofnode_get_parent(node);
 		na = ofnode_read_simple_addr_cells(parent);
 		ns = ofnode_read_simple_size_cells(parent);
+
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return FDT_ADDR_T_NONE;
+
 		return fdtdec_get_addr_size_fixed(ofnode_to_fdt(node),
-						  ofnode_to_offset(node), "reg",
+						  off, "reg",
 						  index, na, ns, size,
 						  translate);
 	}
@@ -849,10 +922,14 @@ int ofnode_stringlist_search(ofnode node, const char *property,
 		return of_property_match_string(ofnode_to_np(node),
 						property, string);
 	} else {
-		int ret;
+		int ret, off;
+
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return -EINVAL;
 
 		ret = fdt_stringlist_search(ofnode_to_fdt(node),
-					    ofnode_to_offset(node), property,
+					    off, property,
 					    string);
 		if (ret == -FDT_ERR_NOTFOUND)
 			return -ENODATA;
@@ -870,10 +947,13 @@ int ofnode_read_string_index(ofnode node, const char *property, int index,
 		return of_property_read_string_index(ofnode_to_np(node),
 						     property, index, outp);
 	} else {
-		int len;
+		int len, off;
+
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return -EINVAL;
 
-		*outp = fdt_stringlist_get(ofnode_to_fdt(node),
-					   ofnode_to_offset(node),
+		*outp = fdt_stringlist_get(ofnode_to_fdt(node), off,
 					   property, index, &len);
 		if (len < 0)
 			return -EINVAL;
@@ -883,11 +963,17 @@ int ofnode_read_string_index(ofnode node, const char *property, int index,
 
 int ofnode_read_string_count(ofnode node, const char *property)
 {
+	int off;
+
 	if (ofnode_is_np(node)) {
 		return of_property_count_strings(ofnode_to_np(node), property);
 	} else {
+		off = ofnode_to_offset(node);
+		if (off < 0)
+			return -EINVAL;
+
 		return fdt_stringlist_count(ofnode_to_fdt(node),
-					    ofnode_to_offset(node), property);
+					    off, property);
 	}
 }
 
@@ -933,10 +1019,13 @@ ofnode ofnode_parse_phandle(ofnode node, const char *phandle_name,
 		phandle = np_to_ofnode(np);
 	} else {
 		struct fdtdec_phandle_args args;
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return ofnode_null();
 
 		if (fdtdec_parse_phandle_with_args(ofnode_to_fdt(node),
-						   ofnode_to_offset(node),
-						   phandle_name, NULL,
+						   off, phandle_name, NULL,
 						   0, index, &args))
 			return ofnode_null();
 
@@ -962,10 +1051,13 @@ ofnode oftree_parse_phandle(oftree tree, ofnode node, const char *phandle_name,
 		phandle = np_to_ofnode(np);
 	} else {
 		struct fdtdec_phandle_args args;
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return ofnode_null();
 
 		if (fdtdec_parse_phandle_with_args(tree.fdt,
-						   ofnode_to_offset(node),
-						   phandle_name, NULL,
+						   off, phandle_name, NULL,
 						   0, index, &args))
 			return ofnode_null();
 
@@ -1011,11 +1103,14 @@ int ofnode_parse_phandle_with_args(ofnode node, const char *list_name,
 		ofnode_from_of_phandle_args(&args, out_args);
 	} else {
 		struct fdtdec_phandle_args args;
+		int off = ofnode_to_offset(node);
 		int ret;
 
+		if (off < 0)
+			return -EINVAL;
+
 		ret = fdtdec_parse_phandle_with_args(ofnode_to_fdt(node),
-						     ofnode_to_offset(node),
-						     list_name, cells_name,
+						     off, list_name, cells_name,
 						     cell_count, index, &args);
 		if (ret)
 			return ret;
@@ -1044,11 +1139,14 @@ int oftree_parse_phandle_with_args(oftree tree, ofnode node, const char *list_na
 		ofnode_from_of_phandle_args(&args, out_args);
 	} else {
 		struct fdtdec_phandle_args args;
+		int off = ofnode_to_offset(node);
 		int ret;
 
+		if (off < 0)
+			return -EINVAL;
+
 		ret = fdtdec_parse_phandle_with_args(tree.fdt,
-						     ofnode_to_offset(node),
-						     list_name, cells_name,
+						     off, list_name, cells_name,
 						     cell_count, index, &args);
 		if (ret)
 			return ret;
@@ -1061,25 +1159,37 @@ int oftree_parse_phandle_with_args(oftree tree, ofnode node, const char *list_na
 int ofnode_count_phandle_with_args(ofnode node, const char *list_name,
 				   const char *cells_name, int cell_count)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_count_phandle_with_args(ofnode_to_np(node),
 				list_name, cells_name, cell_count);
-	else
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
 		return fdtdec_parse_phandle_with_args(ofnode_to_fdt(node),
-				ofnode_to_offset(node), list_name, cells_name,
+				off, list_name, cells_name,
 				cell_count, -1, NULL);
+	}
 }
 
 int oftree_count_phandle_with_args(oftree tree, ofnode node, const char *list_name,
 				   const char *cells_name, int cell_count)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_root_count_phandle_with_args(tree.np, ofnode_to_np(node),
 				list_name, cells_name, cell_count);
-	else
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
 		return fdtdec_parse_phandle_with_args(tree.fdt,
-				ofnode_to_offset(node), list_name, cells_name,
+				off, list_name, cells_name,
 				cell_count, -1, NULL);
+	}
 }
 
 ofnode ofnode_path(const char *path)
@@ -1326,11 +1436,16 @@ int ofnode_decode_panel_timing(ofnode parent,
 
 const void *ofnode_get_property(ofnode node, const char *propname, int *lenp)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_get_property(ofnode_to_np(node), propname, lenp);
-	else
-		return fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-				   propname, lenp);
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return NULL;
+
+		return fdt_getprop(ofnode_to_fdt(node), off, propname, lenp);
+	}
 }
 
 bool ofnode_has_property(ofnode node, const char *propname)
@@ -1350,9 +1465,13 @@ int ofnode_first_property(ofnode node, struct ofprop *prop)
 		if (!prop->prop)
 			return -FDT_ERR_NOTFOUND;
 	} else {
+		int off = ofnode_to_offset(prop->node);
+
+		if (off < 0)
+			return -EINVAL;
+
 		prop->offset =
-			fdt_first_property_offset(ofnode_to_fdt(node),
-						  ofnode_to_offset(prop->node));
+			fdt_first_property_offset(ofnode_to_fdt(node), off);
 		if (prop->offset < 0)
 			return prop->offset;
 	}
@@ -1410,9 +1529,13 @@ fdt_addr_t ofnode_get_addr_size(ofnode node, const char *property,
 		else
 			return of_read_number(prop, na);
 	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return FDT_ADDR_T_NONE;
+
 		return fdtdec_get_addr_size(ofnode_to_fdt(node),
-					    ofnode_to_offset(node), property,
-					    sizep);
+					    off, property, sizep);
 	}
 }
 
@@ -1429,8 +1552,13 @@ const uint8_t *ofnode_read_u8_array_ptr(ofnode node, const char *propname,
 		return (uint8_t *)prop;
 
 	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return NULL;
+
 		return fdtdec_locate_byte_array(ofnode_to_fdt(node),
-				ofnode_to_offset(node), propname, sz);
+						off, propname, sz);
 	}
 }
 
@@ -1570,8 +1698,12 @@ int ofnode_read_addr_cells(ofnode node)
 	if (ofnode_is_np(node)) {
 		return of_n_addr_cells(ofnode_to_np(node));
 	} else {
-		int parent = fdt_parent_offset(ofnode_to_fdt(node),
-					       ofnode_to_offset(node));
+		int parent, off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		parent = fdt_parent_offset(ofnode_to_fdt(node), off);
 
 		return fdt_address_cells(ofnode_to_fdt(node), parent);
 	}
@@ -1582,8 +1714,12 @@ int ofnode_read_size_cells(ofnode node)
 	if (ofnode_is_np(node)) {
 		return of_n_size_cells(ofnode_to_np(node));
 	} else {
-		int parent = fdt_parent_offset(ofnode_to_fdt(node),
-					       ofnode_to_offset(node));
+		int parent, off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		parent = fdt_parent_offset(ofnode_to_fdt(node), off);
 
 		return fdt_size_cells(ofnode_to_fdt(node), parent);
 	}
@@ -1591,20 +1727,30 @@ int ofnode_read_size_cells(ofnode node)
 
 int ofnode_read_simple_addr_cells(ofnode node)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_simple_addr_cells(ofnode_to_np(node));
-	else
-		return fdt_address_cells(ofnode_to_fdt(node),
-					 ofnode_to_offset(node));
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		return fdt_address_cells(ofnode_to_fdt(node), off);
+	}
 }
 
 int ofnode_read_simple_size_cells(ofnode node)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_simple_size_cells(ofnode_to_np(node));
-	else
-		return fdt_size_cells(ofnode_to_fdt(node),
-				      ofnode_to_offset(node));
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		return fdt_size_cells(ofnode_to_fdt(node), off);
+	}
 }
 
 bool ofnode_pre_reloc(ofnode node)
@@ -1639,10 +1785,13 @@ int ofnode_read_resource(ofnode node, uint index, struct resource *res)
 		return of_address_to_resource(ofnode_to_np(node), index, res);
 	} else {
 		struct fdt_resource fres;
+		int off = ofnode_to_offset(node);
 		int ret;
 
-		ret = fdt_get_resource(ofnode_to_fdt(node),
-				       ofnode_to_offset(node),
+		if (off < 0)
+			return -EINVAL;
+
+		ret = fdt_get_resource(ofnode_to_fdt(node), off,
 				       "reg", index, &fres);
 		if (ret < 0)
 			return -EINVAL;
@@ -1668,41 +1817,61 @@ int ofnode_read_resource_byname(ofnode node, const char *name,
 
 u64 ofnode_translate_address(ofnode node, const fdt32_t *in_addr)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_translate_address(ofnode_to_np(node), in_addr);
-	else
-		return fdt_translate_address(ofnode_to_fdt(node),
-					     ofnode_to_offset(node), in_addr);
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return OF_BAD_ADDR;
+
+		return fdt_translate_address(ofnode_to_fdt(node), off, in_addr);
+	}
 }
 
 u64 ofnode_translate_dma_address(ofnode node, const fdt32_t *in_addr)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_translate_dma_address(ofnode_to_np(node), in_addr);
-	else
-		return fdt_translate_dma_address(ofnode_to_fdt(node),
-						 ofnode_to_offset(node), in_addr);
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return OF_BAD_ADDR;
+
+		return fdt_translate_dma_address(ofnode_to_fdt(node), off, in_addr);
+	}
 }
 
 int ofnode_get_dma_range(ofnode node, phys_addr_t *cpu, dma_addr_t *bus, u64 *size)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_get_dma_range(ofnode_to_np(node), cpu, bus, size);
-	else
-		return fdt_get_dma_range(ofnode_to_fdt(node),
-					 ofnode_to_offset(node),
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		return fdt_get_dma_range(ofnode_to_fdt(node), off,
 					 cpu, bus, size);
+	}
 }
 
 int ofnode_device_is_compatible(ofnode node, const char *compat)
 {
-	if (ofnode_is_np(node))
+	if (ofnode_is_np(node)) {
 		return of_device_is_compatible(ofnode_to_np(node), compat,
 					       NULL, NULL);
-	else
-		return !fdt_node_check_compatible(ofnode_to_fdt(node),
-						  ofnode_to_offset(node),
+	} else {
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return 0;
+
+		return !fdt_node_check_compatible(ofnode_to_fdt(node), off,
 						  compat);
+	}
 }
 
 ofnode ofnode_by_compatible(ofnode from, const char *compat)
@@ -1753,7 +1922,12 @@ int ofnode_write_prop(ofnode node, const char *propname, const void *value,
 			free(newval);
 		return ret;
 	} else {
-		ret = fdt_setprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		ret = fdt_setprop(ofnode_to_fdt(node), off,
 				  propname, value, len);
 		if (ret)
 			return ret == -FDT_ERR_NOSPACE ? -ENOSPC : -EINVAL;
@@ -1821,8 +1995,12 @@ int ofnode_delete_prop(ofnode node, const char *propname)
 			return of_remove_property(ofnode_to_np(node), prop);
 		return 0;
 	} else {
-		return fdt_delprop(ofnode_to_fdt(node), ofnode_to_offset(node),
-				   propname);
+		int off = ofnode_to_offset(node);
+
+		if (off < 0)
+			return -EINVAL;
+
+		return fdt_delprop(ofnode_to_fdt(node), off, propname);
 	}
 }
 
@@ -2040,6 +2218,9 @@ int ofnode_add_subnode(ofnode node, const char *name, ofnode *subnodep)
 		int poffset = ofnode_to_offset(node);
 		int offset;
 
+		if (poffset < 0)
+			return -FDT_ERR_NOTFOUND;
+
 		offset = fdt_add_subnode(fdt, poffset, name);
 		if (offset == -FDT_ERR_EXISTS) {
 			offset = fdt_subnode_offset(fdt, poffset, name);
@@ -2067,6 +2248,9 @@ int ofnode_delete(ofnode *nodep)
 		void *fdt = ofnode_to_fdt(node);
 		int offset = ofnode_to_offset(node);
 
+		if (offset < 0)
+			return -EINVAL;
+
 		ret = fdt_del_node(fdt, offset);
 		if (ret)
 			ret = -EFAULT;
-- 
2.51.0

