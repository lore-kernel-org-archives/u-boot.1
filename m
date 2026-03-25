Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD79109C045
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 16:56:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A95A84073;
	Wed, 25 Mar 2026 17:55:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VHE7O4un";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1359783FC6; Wed, 25 Mar 2026 17:55:53 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C07128406D
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 17:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-464ba2bb3aeso708713b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774457749; x=1775062549; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVf8oOj4tPW/YL1dCIS0G+uZRc1VnyGv1WkxRUKHY0A=;
 b=VHE7O4un8mt40hMBvGTtOeAQf85gXrCWNQSE0Q57YLxt+w2y5A8zC8KFcJqiNxhVDs
 1hodj22lYql9DcGXSuTYOmdbm7TFJCLYxsLOx8zLl9NjI0nvDW24q9QNpCbYQZX/xv68
 H6eVjl85AYRQTwAIUqSbYVn1OLY92n3jTwVGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457749; x=1775062549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OVf8oOj4tPW/YL1dCIS0G+uZRc1VnyGv1WkxRUKHY0A=;
 b=hCKNNdw7MpeoclNZXE/pkz0Rq2jA3C9Z5hqHOVqTMC8QSEDhaxVqmI+Ou4KykgtfEI
 PmmWS1FRX/nLUgXUqnlwua3EmlkSmQn0156SgqdVebsTIvyQ8oAfQGseSy6l8XvF5fE3
 9VvuiGCh/YLyCHdn7yfMaBlhuzIjPy38aJY3ISvZpn3GntisFM4UatxD9gkw+YOshWRs
 7Mu3FW/Nd/pdhja8+H7XBbJyLSftZYsw0Jqn+rkcbkuL5iAh6cGKKFxsuPBtqxAtByI/
 iNB48uPHg+EZ3pin/qFu4NpplHb7PoYM6q8gjFAy5pMQhCd98AesVbxu6xUHqzJy13WB
 YTmA==
X-Gm-Message-State: AOJu0YwC4E+cnTA4bVuAFiW9Tb0PsmpM+4hAOnU6cIjaINNbbPAjIDam
 0FSBjuWlIDyomWNpUNOu2xxW74NiVExgW1mpPEWdnf8hrcoLtV4edeMnmjESiMjZVHvG16ZSrT/
 +mNQSsw==
X-Gm-Gg: ATEYQzyoHMmrBxg5WNSpMGacNiBOIPVY14ihZnweDrKAxdPOp9ysRwSdx/9Pwm9ihV+
 ya/QmARsvM5/yiWJ+ygOnHw+8zdL25DJzlyym9Ut1I0pZlZpBsjqlFHgwT0QxKBNaXheZYC9NJ1
 kX4uQq6aYCk3gulYbUw+9b5W+akLex6K7C2Tudt7KBElE6FmVxxmj4gj3wxB+0c5ZMbU1XF2L1f
 G43sbxeZIwY2OHEF35JPBA5H0Tj9TgFzGuZWdmD74WE9eGQE4x4KHBeuH8vyHzVY7uptbTeR2bk
 wboyL+7J9XZ0CWpjY5lDh72j0FiRkjIK3IaVk9+Jzwpu9la6fGIa3gPAh1CwbWIreUHcl8nRs8v
 v4s6G1shrzm/pdxuWLMzezCXn8KlnSjftrslpyvX2lH8e7Lxgus0vc5vBA2yKq/UX2V6hs1W+6u
 0wCXY/pZ+eJiEMtqQ2Y/hqS8HEm7j8
X-Received: by 2002:a05:6808:509e:b0:467:fb12:c9f6 with SMTP id
 5614622812f47-46a0cdc14b5mr4355955b6e.14.1774457748684; 
 Wed, 25 Mar 2026 09:55:48 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm30481b6e.15.2026.03.25.09.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:55:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/13] boot: Move image-decompression into a separate function
Date: Wed, 25 Mar 2026 10:54:18 -0600
Message-ID: <20260325165431.1027591-10-sjg@chromium.org>
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

Move handling of decompression (or perhaps relocation) of the image into
a separate function, to slim down fit_image_load() a little more.

Move the bootstage_mark() call in there too.

Pass the load address by reference since it may be updated when the
image is relocated for alignment.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/image-fit.c | 154 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 104 insertions(+), 50 deletions(-)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index 0a880863063..a59226d42c5 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2288,6 +2288,104 @@ static int obtain_data(const void *fit, int noffset, const char *prop_name,
 	return 0;
 }
 
+/**
+ * decomp_image() - Decompress / relocate the image
+ *
+ * If the image is compressed, decompress it to the provided load address,
+ * making sure it fits within the allowed space.
+ *
+ * If the image is not compressed, copy it (to the load address) if needed.
+ *
+ * Kernels are not decompressed here, since that is handled in bootm_load_os()
+ *
+ * Compression is ignored on ramdisks, although a warning is provided. Since the
+ * ramdisk normally uses its own compression, doing additional compression at
+ * the FIT level is counter-productive.
+ *
+ * For devicetree, check that the image is actually a devicetree
+ *
+ * @fit: FIT to check
+ * @noffset: Node offset of the image being loaded
+ * @prop_name: Property name (in the configuration node) indicating the image
+ * that was loaded
+ * @buf: Pointer to image (within the FIT)
+ * @size: Size of the image in bytes
+ * @image_type: Type of the image
+ * @load_op: Load operation to process
+ * @bootstage_id: ID of starting bootstage to use for progress updates
+ * @data: Data buffer
+ * @loadp: On entry, the address to which the data should be loaded. Updated
+ *	if the data is relocated (e.g. for alignment)
+ * @sizep: On entry, the size of the image in bytes. Updated if the image is
+ *	decompressed
+ * @load_end: End address of the data-loading location
+ * Return: 0 if OK, -ve on error
+ */
+static int decomp_image(const void *fit, int noffset, const char *prop_name,
+			void *buf, enum image_type_t image_type,
+			enum fit_load_op load_op, int bootstage_id, ulong data,
+			ulong *loadp, ulong *sizep, ulong load_end)
+{
+	ulong load = *loadp;
+	ulong size = *sizep;
+	void *loadbuf;
+	uint8_t comp;
+
+	comp = IH_COMP_NONE;
+	loadbuf = buf;
+	/* Kernel images get decompressed later in bootm_load_os(). */
+	if (!fit_image_get_comp(fit, noffset, &comp) &&
+	    comp != IH_COMP_NONE &&
+	    load_op != FIT_LOAD_IGNORED &&
+	    !(image_type == IH_TYPE_KERNEL ||
+	      image_type == IH_TYPE_KERNEL_NOLOAD ||
+	      image_type == IH_TYPE_RAMDISK)) {
+		ulong max_decomp_len = size * 20;
+
+		log_debug("decompressing image\n");
+		if (load == data) {
+			loadbuf = aligned_alloc(8, max_decomp_len);
+			load = map_to_sysmem(loadbuf);
+		} else {
+			loadbuf = map_sysmem(load, max_decomp_len);
+		}
+		if (image_decomp(comp, load, data, image_type, loadbuf, buf,
+				 size, max_decomp_len, &load_end)) {
+			printf("Error decompressing %s\n", prop_name);
+
+			return -ENOEXEC;
+		}
+		size = load_end - load;
+	} else if (load_op != FIT_LOAD_IGNORED &&
+		   image_type == IH_TYPE_FLATDT &&
+		   ((uintptr_t)buf & 7)) {
+		loadbuf = aligned_alloc(8, size);
+		load = map_to_sysmem(loadbuf);
+		memcpy(loadbuf, buf, size);
+	} else if (load != data) {
+		log_debug("copying\n");
+		loadbuf = map_sysmem(load, size);
+		memcpy(loadbuf, buf, size);
+	}
+	*loadp = load;
+	*sizep = size;
+
+	if (image_type == IH_TYPE_RAMDISK && comp != IH_COMP_NONE)
+		puts("WARNING: 'compression' nodes for ramdisks are deprecated,"
+		     " please fix your .its file!\n");
+
+	/* verify that image data is a proper FDT blob */
+	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
+	    fdt_check_header(loadbuf)) {
+		puts("Subimage data is not a FDT\n");
+		return -ENOEXEC;
+	}
+
+	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_LOAD);
+
+	return 0;
+}
+
 /**
  * handle_load_op() - Handle the load operation
  *
@@ -2369,9 +2467,8 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	const char *fit_base_uname_config;
 	const void *fit;
 	void *buf;
-	void *loadbuf;
 	ulong load, load_end, data, len;
-	uint8_t comp, os_arch;
+	uint8_t os_arch;
 	const char *prop_name;
 	int ret;
 
@@ -2404,54 +2501,11 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
 	if (ret)
 		return ret;
 
-	comp = IH_COMP_NONE;
-	loadbuf = buf;
-	/* Kernel images get decompressed later in bootm_load_os(). */
-	if (!fit_image_get_comp(fit, noffset, &comp) &&
-	    comp != IH_COMP_NONE &&
-	    load_op != FIT_LOAD_IGNORED &&
-	    !(image_type == IH_TYPE_KERNEL ||
-	      image_type == IH_TYPE_KERNEL_NOLOAD ||
-	      image_type == IH_TYPE_RAMDISK)) {
-		ulong max_decomp_len = len * 20;
-
-		log_debug("decompressing image\n");
-		if (load == data) {
-			loadbuf = aligned_alloc(8, max_decomp_len);
-			load = map_to_sysmem(loadbuf);
-		} else {
-			loadbuf = map_sysmem(load, max_decomp_len);
-		}
-		if (image_decomp(comp, load, data, image_type,
-				loadbuf, buf, len, max_decomp_len, &load_end)) {
-			printf("Error decompressing %s\n", prop_name);
-
-			return -ENOEXEC;
-		}
-		len = load_end - load;
-	} else if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
-		   ((uintptr_t)buf & 7)) {
-		loadbuf = aligned_alloc(8, len);
-		load = map_to_sysmem(loadbuf);
-		memcpy(loadbuf, buf, len);
-	} else if (load != data) {
-		log_debug("copying\n");
-		loadbuf = map_sysmem(load, len);
-		memcpy(loadbuf, buf, len);
-	}
-
-	if (image_type == IH_TYPE_RAMDISK && comp != IH_COMP_NONE)
-		puts("WARNING: 'compression' nodes for ramdisks are deprecated,"
-		     " please fix your .its file!\n");
-
-	/* verify that image data is a proper FDT blob */
-	if (load_op != FIT_LOAD_IGNORED && image_type == IH_TYPE_FLATDT &&
-	    fdt_check_header(loadbuf)) {
-		puts("Subimage data is not a FDT\n");
-		return -ENOEXEC;
-	}
-
-	bootstage_mark(bootstage_id + BOOTSTAGE_SUB_LOAD);
+	ret = decomp_image(fit, noffset, prop_name, buf, image_type,
+			   load_op, bootstage_id, data, &load, &len,
+			   load_end);
+	if (ret)
+		return ret;
 
 	upl_add_image(fit, noffset, load, len);
 
-- 
2.43.0

