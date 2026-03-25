Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B04109C046
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5AD983CE3;
	Wed, 25 Mar 2026 17:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n4c9Ghmz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FC7F83E76; Wed, 25 Mar 2026 17:55:36 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F37AA81E18
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-46703fb602fso7135b6e.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457732; x=1775062532; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Djx79y6zim88x1Lcr8YbHp2Jm2cLlYmn4DoS4o2rY0o=;
 b=n4c9GhmztVdEE13T22jK0Ep70ZIsZqjKHzo1p1BAWfxv3ZKYNfmd3zw0tRxtf+JvRR
 3lqFmCopSdLTrTYgYrm/Ki2Wv5IIlpG9eMhjYyT/N7oYro82X+RCk9vw+MvIR5/LIrD2
 LtGdO9A4XKiBHG8/5aA0nCRRdwEmmURwSl8Zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457732; x=1775062532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Djx79y6zim88x1Lcr8YbHp2Jm2cLlYmn4DoS4o2rY0o=;
 b=F1bZdqFR8KqxdD6508Ck3fs7xDDvtETID1K6Quqm+m5NnZCIw/nH5jVrWRRyvNfNYW
 bzvdDh9lMaJt7GefrITvZDGVK6TAJJDLvTqV5zJzvy0lgqGnlgy0n1p+aZv8lOY9uZ0w
 HiR8UbsnxMRE+8s4yjdo8LjDoWWPpyO385x9fQnw7Jgp5nH2dpm9oG/cqAAHlFLdslKf
 8LNOYiOcOXOGmiREf3yRBJa82A0d83cWX8x9Glmcg5lmxAl3gCNGcAmN6HOV0fCCtv8y
 WkV/X14Fz4KjGQEN58Ez5L5VYMMRXz9ExtyYOKLpmkfTRol/3eu4A301DhzdChheYUa3
 x/aQ==
X-Gm-Message-State: AOJu0YxTDpaN/nPzf+qQ+bozajJBCNocJqxnk+jnkjn0D3VdrEg7NHXk
 3BCWAVSH4klFtf6VekUY30fvb36oFWgXg/jr0sEXNh95/0O+G7yOlrMWL6NsUyucUg98CSHQ7ab
 75Ww9ZQ==
X-Gm-Gg: ATEYQzxXTiDUDJUKLAzCJMesmAYbUCeZVRVMtBkYxwDBL2FM9ezd24AVxgWKhUJMZmp
 B0cM71kRsSmuevrzFCjIyn9V0VGlnMUQnUFOHRdasSkUCGHplNU7Evum+oRJqy3fMwNpu2sgBGR
 yWluKKigEtCHLWS+8EqBqqoJE9Xx3QnhFJwbUYYIhi0eVcvtMHYW7af4iS+G2jtfokJbURx9Y6F
 2rrGlYn5YTUuZ2uUD5f23KdZN0fFL4nTRQmD7xqWVS/GmkcZBUhgCOb6hbpk7yhV0rA7nKfUfVj
 zrWv14+1NFGiy5a63D87N3giLag34d3dp/NDA0luJtGPKoDA76+fNCb0NAAKyKun1t2uMqEuyFb
 eFDZb3lvPZ0HVXdZwtFscR8fp5HK7EoA1TpSY2WY7qlFQUz06So72CNxHpAN0WhUEzicDD7kTF1
 c8J4kxh/isHAcsr1T+OA==
X-Received: by 2002:a05:6808:1928:b0:466:f60b:19c5 with SMTP id
 5614622812f47-46a5c57af7emr2006481b6e.6.1774457732085; 
 Wed, 25 Mar 2026 09:55:32 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/13] boot: Split out the first part of fit_image_load()
Date: Wed, 25 Mar 2026 10:54:10 -0600
Message-ID: <20260325165431.1027591-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325165431.1027591-1-sjg@chromium.org>
References: <20260325165431.1027591-1-sjg@chromium.org>
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

This function is over 250 lines long. Split out the image-selection
part into a new select_image() function which handles format checking,
configuration selection and image-node lookup.

Take care to only call fit_get_name() when a valid node is found, since
libfdt does not handle negative offsets gracefully.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 101 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 70 insertions(+), 31 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index e7c7212195f..a4402dcff63 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2070,33 +2070,35 @@ static const char *fit_get_image_type_property(int ph_type)
 	return "unknown";
 }
 
-int fit_image_load(struct bootm_headers *images, ulong addr,
-		   const char **fit_unamep, const char **fit_uname_configp,
-		   int arch, int ph_type, int bootstage_id,
-		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
+/**
+ * select_image() - Select the image to load
+ *
+ * image->fit_uname_cfg is set if the image type is IH_TYPE_KERNEL
+ *
+ * @fit: Pointer to FIT
+ * @images: Boot images structure
+ * @fit_unamep: On entry, the requested image name (e.g. "kernel") or NULL to
+ * use the default. On exit, the selected image name
+ * @fit_uname_config: Requested configuration name (e.g. "conf-1") or NULL to
+ * use the default
+ * @prop_name: Property name (in the configuration node) indicating the image
+ * to load
+ * @ph_type: Required image type (IH_TYPE_...) and phase (IH_PHASE_...)
+ * @bootstage_id: ID of starting bootstage to use for progress updates
+ * @fit_base_uname_configp: Returns config name selected, or NULL if *fit_unamep
+ * was used to select an image node
+ * Return: node offset of image node, on success, else -ve error code
+ */
+static int select_image(const void *fit, struct bootm_headers *images,
+			const char **fit_unamep, const char *fit_uname_config,
+			const char *prop_name, int ph_type, int bootstage_id,
+			const char **fit_base_uname_configp)
 {
-	int image_type = image_ph_type(ph_type);
 	int cfg_noffset, noffset;
-	const char *fit_uname;
-	const char *fit_uname_config;
-	const char *fit_base_uname_config;
-	const void *fit;
-	void *buf;
-	void *loadbuf;
-	size_t size;
-	int type_ok, os_ok;
-	ulong load, load_end, data, len;
-	uint8_t os, comp;
-	const char *prop_name;
 	int ret;
 
-	fit = map_sysmem(addr, 0);
-	fit_uname = fit_unamep ? *fit_unamep : NULL;
-	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
-	fit_base_uname_config = NULL;
+	*fit_base_uname_configp = NULL;
 	prop_name = fit_get_image_type_property(ph_type);
-	printf("## Loading %s (%s) from FIT Image at %08lx ...\n",
-	       prop_name, genimg_get_phase_name(image_ph_phase(ph_type)), addr);
 
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_FORMAT);
 	ret = fit_check_format(fit, IMAGE_SIZE_INVAL);
@@ -2108,10 +2110,10 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		return ret;
 	}
 	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_FORMAT_OK);
-	if (fit_uname) {
+	if (*fit_unamep) {
 		/* get FIT component image node offset */
 		bootstage_mark(bootstage_id + BOOTSTAGE_SUB_UNIT_NAME);
-		noffset = fit_image_get_node(fit, fit_uname);
+		noffset = fit_image_get_node(fit, *fit_unamep);
 	} else {
 		/*
 		 * no image node unit name, try to get config
@@ -2133,11 +2135,12 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		}
 		cfg_noffset = ret;
 
-		fit_base_uname_config = fdt_get_name(fit, cfg_noffset, NULL);
-		printf("   Using '%s' configuration\n", fit_base_uname_config);
+		*fit_base_uname_configp = fdt_get_name(fit, cfg_noffset, NULL);
+		printf("   Using '%s' configuration\n",
+		       *fit_base_uname_configp);
 		/* Remember this config */
-		if (image_type == IH_TYPE_KERNEL)
-			images->fit_uname_cfg = fit_base_uname_config;
+		if (image_ph_type(ph_type) == IH_TYPE_KERNEL)
+			images->fit_uname_cfg = *fit_base_uname_configp;
 
 		if (FIT_IMAGE_ENABLE_VERIFY && images->verify) {
 			puts("   Verifying Hash Integrity ... ");
@@ -2161,10 +2164,46 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 		return -ENOENT;
 	}
 
-	if (!fit_uname)
-		fit_uname = fit_get_name(fit, noffset, NULL);
+	if (!*fit_unamep)
+		*fit_unamep = fit_get_name(fit, noffset, NULL);
+
+	printf("   Trying '%s' %s subimage\n", *fit_unamep, prop_name);
+
+	return noffset;
+}
+
+int fit_image_load(struct bootm_headers *images, ulong addr,
+		   const char **fit_unamep, const char **fit_uname_configp,
+		   int arch, int ph_type, int bootstage_id,
+		   enum fit_load_op load_op, ulong *datap, ulong *lenp)
+{
+	int image_type = image_ph_type(ph_type);
+	int noffset;
+	const char *fit_uname;
+	const char *fit_uname_config;
+	const char *fit_base_uname_config;
+	const void *fit;
+	void *buf;
+	void *loadbuf;
+	size_t size;
+	int type_ok, os_ok;
+	ulong load, load_end, data, len;
+	uint8_t os, comp;
+	const char *prop_name;
+	int ret;
+
+	fit = map_sysmem(addr, 0);
+	prop_name = fit_get_image_type_property(ph_type);
+	printf("## Loading %s (%s) from FIT Image at %08lx ...\n",
+	       prop_name, genimg_get_phase_name(image_ph_phase(ph_type)), addr);
 
-	printf("   Trying '%s' %s subimage\n", fit_uname, prop_name);
+	fit_uname = fit_unamep ? *fit_unamep : NULL;
+	fit_uname_config = fit_uname_configp ? *fit_uname_configp : NULL;
+	noffset = select_image(fit, images, &fit_uname, fit_uname_config,
+			       prop_name, ph_type, bootstage_id,
+			       &fit_base_uname_config);
+	if (noffset < 0)
+		return noffset;
 
 	ret = fit_image_select(fit, noffset, images->verify);
 	if (ret) {
-- 
2.43.0

