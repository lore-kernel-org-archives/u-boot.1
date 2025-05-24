Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF18C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 17:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9F568307F;
	Sat, 24 May 2025 19:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V80kmarx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73F0C82E28; Sat, 24 May 2025 19:28:44 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35048307F
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 19:28:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-86a55400913so19747039f.1
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 10:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748107719; x=1748712519; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rxgHpjO6o3JxQnJxFqJZuAD+JHTf1naL/fcmPLKLYpQ=;
 b=V80kmarx5BRf8WVzbDJE73ZeGenPbMZbr169GVMhltWolRCK76aOUX315VE1K5JR+M
 ulYXlvjgDq9u0zovW4YIFvyX7DsG9XQVG6a1Ld+6GjvKpC28APMVKBxms2y80jHisHIJ
 3c2YamkH4Je7BzlMrUuCI7CvkH/ZtSh0tW3lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107719; x=1748712519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rxgHpjO6o3JxQnJxFqJZuAD+JHTf1naL/fcmPLKLYpQ=;
 b=h3h06c4a/nQTeMJc5ScxosMcwVc44UTDffoeX3nk5I5fcaNAEePY1u1SG86O/ycyNs
 QuKQKR/yPAqx8UYVzK/nUYWRK9jRMAklIrAmdVsJJ+jFYKbtq4u2yHXXA3Cq6IGkov8Y
 0Dtv2e+bSywt44VooUtZmo3A8M0SR/ny2g80Mx1HaiMe0v8Ty8UnlGRrhRHqaeMEyuJr
 /y9A9k0TSLPtnYx2ir83a/ppFjlcpv7rKe4MRitioD+VcGeBg1n3V03+Q3pF33n8e7T2
 XIXjoKaR4koDGqx4+Csk6+6t2xeNp3AVVsunKcy1EGsJ9OslysS5GLDgiGb0K3fRk/FT
 DGFA==
X-Gm-Message-State: AOJu0YzxuesHzcqB/lIKJJv8uUWiT4n3h+wDByQMx9ZXciQVBdQc2OCD
 +4AZf3oUgzpGP68xNR/l1wC0O18rUqLyO7c+7HV8t9MgG+dluj6zaJXX4bpsfbIplTGFZnC6+8l
 0FEL8u36V
X-Gm-Gg: ASbGncuJQdQlqOdQu9pDfYWtQjq0GYqPiFo7I9l1xGtVJbW6vwYVcgNwKChXmJo945T
 IaDsNz+aRCnFfpYcfQObRUeSVpD/73qGMjsgKI3/BaV7pYfXiO7b/3rxdkJKL4W/Jksp4GzOsp1
 WjgxBozLrfSTkGsV03KPBMuV6x8N1Zkz9hYCxZKHYwFH85d/BDZdM9N4QDc6yxwMtrhOBlew+g6
 y3hlhbzmdEbSxA8ik+yGKWAtcNqry4IIGAH/GEcV0GEROQ9K+WD92ge7btxGfrNofuoQpVq7qPy
 e/39uqimFVvgxfjwrC250fFOjFuQYRSxJ/GF/UNixF5K8+bgzRZX9A/dej0mxdQ7Jlsk0tvjBTt
 RBBOeECiVAq0C
X-Google-Smtp-Source: AGHT+IFQG1e2b7nUGpgSgsSrJpjQ1GpaUUKj5maGYLT6cd2HzFyGMzx2ht8bP0g1puKKH8+YmFNKTw==
X-Received: by 2002:a05:6e02:1566:b0:3da:71ea:9a59 with SMTP id
 e9e14a558f8ab-3dc9b6f64f0mr25657625ab.9.1748107719501; 
 Sat, 24 May 2025 10:28:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3dc79b5b4a0sm26521105ab.11.2025.05.24.10.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 10:28:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Adriano Cordova <adrianox@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Moritz Fischer <moritzf@google.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH 3/3] efi: Rename END to EFI_DP_END
Date: Sat, 24 May 2025 11:28:23 -0600
Message-ID: <20250524172827.1243975-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250524172827.1243975-1-sjg@chromium.org>
References: <20250524172827.1243975-1-sjg@chromium.org>
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

This exported symbol has a very generic name. Rename it to indicate that
it relates to EFI and device-paths.

Fix checkpatch warnings related to use of multiple assignments.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

---

Changes in v2:
- Fix EFI_DP_3 typo

 cmd/eficonfig.c                            |  4 +-
 cmd/efidebug.c                             |  6 +-
 include/efi_device_path.h                  | 27 +++----
 lib/efi_loader/efi_bootmgr.c               |  3 +-
 lib/efi_loader/efi_device_path.c           | 86 +++++++++++-----------
 lib/efi_loader/efi_device_path_utilities.c |  2 +-
 lib/efi_loader/efi_helper.c                |  6 +-
 7 files changed, 68 insertions(+), 66 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index de1647b943c..6e14d34a6bd 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -515,7 +515,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	struct efi_device_path_file_path *fp;
 
 	fp_size = sizeof(struct efi_device_path) + u16_strsize(current_path);
-	buf = calloc(1, fp_size + sizeof(END));
+	buf = calloc(1, fp_size + sizeof(EFI_DP_END));
 	if (!buf)
 		return NULL;
 
@@ -527,7 +527,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 
 	p = buf;
 	p += fp_size;
-	*((struct efi_device_path *)p) = END;
+	*((struct efi_device_path *)p) = EFI_DP_END;
 
 	dp = efi_dp_shorten(dp_volume);
 	if (!dp)
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 01e58031573..109496d9e95 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -813,7 +813,7 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
 	lo->label = label;
 
 	uridp_len = sizeof(struct efi_device_path) + strlen(argv[3]) + 1;
-	uridp = efi_alloc(uridp_len + sizeof(END));
+	uridp = efi_alloc(uridp_len + sizeof(EFI_DP_END));
 	if (!uridp) {
 		log_err("Out of memory\n");
 		return CMD_RET_FAILURE;
@@ -823,10 +823,10 @@ static int efi_boot_add_uri(int argc, char *const argv[], u16 *var_name16,
 	uridp->dp.length = uridp_len;
 	strcpy(uridp->uri, argv[3]);
 	pos = (char *)uridp + uridp_len;
-	memcpy(pos, &END, sizeof(END));
+	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
 
 	*file_path = &uridp->dp;
-	*fp_size += uridp_len + sizeof(END);
+	*fp_size += uridp_len + sizeof(EFI_DP_END);
 
 	return CMD_RET_SUCCESS;
 }
diff --git a/include/efi_device_path.h b/include/efi_device_path.h
index 33b6cfe9b79..03fbe8f1622 100644
--- a/include/efi_device_path.h
+++ b/include/efi_device_path.h
@@ -15,12 +15,12 @@ struct efi_load_option;
 struct udevice;
 
 /*
- * END - Template end node for EFI device paths.
+ * EFI_DP_END - Template end node for EFI device paths.
  *
  * Represents the terminating node of an EFI device path.
  * It has a type of DEVICE_PATH_TYPE_END and sub_type DEVICE_PATH_SUB_TYPE_END
  */
-extern const struct efi_device_path END;
+extern const struct efi_device_path EFI_DP_END;
 
 /**
  * efi_dp_next() - Iterate to next block in device-path
@@ -85,11 +85,11 @@ efi_handle_t efi_dp_find_obj(struct efi_device_path *dp, const efi_guid_t *guid,
  * efi_dp_last_node() - Determine the last device path node before the end node
  *
  * Iterate through the device path to find the very last node before
- * the terminating END node.
+ * the terminating EFI_DP_END node.
  *
  * @dp: Pointer to the device path.
  * Return: Pointer to the last actual data node before the end node if it exists
- * otherwise NULL (e.g., if dp is NULL or only an END node).
+ * otherwise NULL (e.g., if dp is NULL or only an EFI_DP_END node).
  */
 const struct efi_device_path *efi_dp_last_node(const struct efi_device_path *dp);
 
@@ -101,8 +101,8 @@ const struct efi_device_path *efi_dp_last_node(const struct efi_device_path *dp)
  * end node (if any) or the final device path. The end node is not included.
  *
  * @dp: Pointer to the device path.
- * Return: Size in bytes of the first instance, or 0 if dp is NULL or an END
- * node
+ * Return: Size in bytes of the first instance, or 0 if dp is NULL or an
+ * EFI_DP_END node
  */
 efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
 
@@ -115,7 +115,7 @@ efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
  *
  * @dp: Pointer to the device path.
  * Return: Total size in bytes of all nodes in the device path (excluding the
- * final END node), or 0 if dp is NULL.
+ * final EFI_DP_END node), or 0 if dp is NULL.
  */
 efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
 
@@ -139,7 +139,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
  * @dp2:        Second device path
  * @split_end_node:
  * - 0 to concatenate (dp1 is assumed not to have an end node or it's ignored,
- *   dp2 is appended, then one END node)
+ *   dp2 is appended, then one EFI_DP_END node)
  * - 1 to concatenate with end node added as separator (dp1, END_THIS_INSTANCE,
  *   dp2, END_ENTIRE)
  *
@@ -160,10 +160,11 @@ struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
  * Create a new device path by appending a given node to an existing
  * device path.
  * If the original device path @dp is NULL, a new path is created
- * with the given @node followed by an END node.
+ * with the given @node followed by an EFI_DP_END node.
  * If the @node is NULL and @dp is not NULL, the original path @dp is
  * duplicated.
- * If both @dp and @node are NULL, a path with only an END node is returned.
+ * If both @dp and @node are NULL, a path with only an EFI_DP_END node is
+ * returned.
  * The caller must free the returned path (e.g., using efi_free()).
  *
  * @dp:   Original device path (can be NULL).
@@ -216,7 +217,7 @@ efi_dp_append_instance(const struct efi_device_path *dp,
  *
  * Given a pointer to a pointer to a device path (@dp), this function extracts
  * the first instance from the path. It allocates a new path for this extracted
- * instance (including its instance-specific END node). The input pointer
+ * instance (including its instance-specific EFI_DP_END node). The input pointer
  * (*@dp) is then updated to point to the start of the next instance in the
  * original path, or set to NULL if no more instances remain.
  * The caller is responsible for freeing the returned instance path (e.g.,
@@ -226,7 +227,7 @@ efi_dp_append_instance(const struct efi_device_path *dp,
  * On output, *@dp is updated to point to the start of the next instance,
  * or NULL if no more instances.
  * @size: Optional pointer to an efi_uintn_t variable that will receive the size
- * of the extracted instance path (including its END node).
+ * of the extracted instance path (including its EFI_DP_END node).
  * Return: Pointer to a newly allocated device path for the extracted instance,
  * or NULL if no instance could be extracted or an error occurred (e.g.,
  * allocation failure).
@@ -408,7 +409,7 @@ struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
  *
  * Set the device path to an IPv4 path as provided by efi_dp_from_ipv4
  * concatenated with a device path of subtype DEVICE_PATH_SUB_TYPE_MSG_URI,
- * and an END node.
+ * and an EFI_DP_END node.
  *
  * @server:	URI of remote server
  * @dev:	net udevice
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a2ab90030b4..3ef0a9e73f3 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -856,7 +856,8 @@ efi_bootmgr_enumerate_boot_options(struct eficonfig_media_boot_option *opt,
 		lo.label = dev_name;
 		lo.attributes = LOAD_OPTION_ACTIVE;
 		lo.file_path = device_path;
-		lo.file_path_length = efi_dp_size(device_path) + sizeof(END);
+		lo.file_path_length = efi_dp_size(device_path) +
+			sizeof(EFI_DP_END);
 		/*
 		 * Set the dedicated guid to optional_data, it is used to identify
 		 * the boot option that automatically generated by the bootmenu.
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 818f993f7cc..7316a76f462 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -22,11 +22,11 @@
 #include <asm-generic/unaligned.h>
 #include <linux/compat.h> /* U16_MAX */
 
-/* template END node: */
-const struct efi_device_path END = {
+/* template EFI_DP_END node: */
+const struct efi_device_path EFI_DP_END = {
 	.type     = DEVICE_PATH_TYPE_END,
 	.sub_type = DEVICE_PATH_SUB_TYPE_END,
-	.length   = sizeof(END),
+	.length   = sizeof(EFI_DP_END),
 };
 
 #if defined(CONFIG_MMC)
@@ -214,7 +214,7 @@ efi_uintn_t efi_dp_size(const struct efi_device_path *dp)
 struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 {
 	struct efi_device_path *ndp;
-	size_t sz = efi_dp_size(dp) + sizeof(END);
+	size_t sz = efi_dp_size(dp) + sizeof(EFI_DP_END);
 
 	if (!dp)
 		return NULL;
@@ -237,7 +237,7 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 
 	if (!dp1 && !dp2) {
 		/* return an end node */
-		ret = efi_dp_dup(&END);
+		ret = efi_dp_dup(&EFI_DP_END);
 	} else if (!dp1) {
 		ret = efi_dp_dup(dp2);
 	} else if (!dp2) {
@@ -254,9 +254,9 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 			sz1 = split_end_node;
 
 		if (split_end_node)
-			end_size = 2 * sizeof(END);
+			end_size = 2 * sizeof(EFI_DP_END);
 		else
-			end_size = sizeof(END);
+			end_size = sizeof(EFI_DP_END);
 		p = efi_alloc(sz1 + sz2 + end_size);
 		if (!p)
 			return NULL;
@@ -265,14 +265,14 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 		p += sz1;
 
 		if (split_end_node) {
-			memcpy(p, &END, sizeof(END));
-			p += sizeof(END);
+			memcpy(p, &EFI_DP_END, sizeof(EFI_DP_END));
+			p += sizeof(EFI_DP_END);
 		}
 
 		/* the end node of the second device path has to be retained */
 		memcpy(p, dp2, sz2);
 		p += sz2;
-		memcpy(p, &END, sizeof(END));
+		memcpy(p, &EFI_DP_END, sizeof(EFI_DP_END));
 	}
 
 	return ret;
@@ -284,26 +284,26 @@ struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
 	struct efi_device_path *ret;
 
 	if (!node && !dp) {
-		ret = efi_dp_dup(&END);
+		ret = efi_dp_dup(&EFI_DP_END);
 	} else if (!node) {
 		ret = efi_dp_dup(dp);
 	} else if (!dp) {
 		size_t sz = node->length;
-		void *p = efi_alloc(sz + sizeof(END));
+		void *p = efi_alloc(sz + sizeof(EFI_DP_END));
 		if (!p)
 			return NULL;
 		memcpy(p, node, sz);
-		memcpy(p + sz, &END, sizeof(END));
+		memcpy(p + sz, &EFI_DP_END, sizeof(EFI_DP_END));
 		ret = p;
 	} else {
 		/* both dp and node are non-null */
 		size_t sz = efi_dp_size(dp);
-		void *p = efi_alloc(sz + node->length + sizeof(END));
+		void *p = efi_alloc(sz + node->length + sizeof(EFI_DP_END));
 		if (!p)
 			return NULL;
 		memcpy(p, dp, sz);
 		memcpy(p + sz, node, node->length);
-		memcpy(p + sz + node->length, &END, sizeof(END));
+		memcpy(p + sz + node->length, &EFI_DP_END, sizeof(EFI_DP_END));
 		ret = p;
 	}
 
@@ -341,17 +341,17 @@ struct efi_device_path *efi_dp_append_instance(
 		return efi_dp_dup(dpi);
 	sz = efi_dp_size(dp);
 	szi = efi_dp_instance_size(dpi);
-	p = efi_alloc(sz + szi + 2 * sizeof(END));
+	p = efi_alloc(sz + szi + 2 * sizeof(EFI_DP_END));
 	if (!p)
 		return NULL;
 	ret = p;
-	memcpy(p, dp, sz + sizeof(END));
+	memcpy(p, dp, sz + sizeof(EFI_DP_END));
 	p = (void *)p + sz;
 	p->sub_type = DEVICE_PATH_SUB_TYPE_INSTANCE_END;
-	p = (void *)p + sizeof(END);
+	p = (void *)p + sizeof(EFI_DP_END);
 	memcpy(p, dpi, szi);
 	p = (void *)p + szi;
-	memcpy(p, &END, sizeof(END));
+	memcpy(p, &EFI_DP_END, sizeof(EFI_DP_END));
 	return ret;
 }
 
@@ -366,17 +366,17 @@ struct efi_device_path *efi_dp_get_next_instance(struct efi_device_path **dp,
 	if (!dp || !*dp)
 		return NULL;
 	sz = efi_dp_instance_size(*dp);
-	p = efi_alloc(sz + sizeof(END));
+	p = efi_alloc(sz + sizeof(EFI_DP_END));
 	if (!p)
 		return NULL;
-	memcpy(p, *dp, sz + sizeof(END));
+	memcpy(p, *dp, sz + sizeof(EFI_DP_END));
 	*dp = (void *)*dp + sz;
 	if ((*dp)->sub_type == DEVICE_PATH_SUB_TYPE_INSTANCE_END)
-		*dp = (void *)*dp + sizeof(END);
+		*dp = (void *)*dp + sizeof(EFI_DP_END);
 	else
 		*dp = NULL;
 	if (size)
-		*size = sz + sizeof(END);
+		*size = sz + sizeof(EFI_DP_END);
 	return p;
 }
 
@@ -763,13 +763,13 @@ struct efi_device_path *efi_dp_from_part(struct blk_desc *desc, int part)
 {
 	void *buf, *start;
 
-	start = buf = efi_alloc(dp_part_size(desc, part) + sizeof(END));
-	if (!buf)
+	start = efi_alloc(dp_part_size(desc, part) + sizeof(EFI_DP_END));
+	if (!start)
 		return NULL;
 
-	buf = dp_part_fill(buf, desc, part);
+	buf = dp_part_fill(start, desc, part);
 
-	*((struct efi_device_path *)buf) = END;
+	*((struct efi_device_path *)buf) = EFI_DP_END;
 
 	return start;
 }
@@ -836,7 +836,7 @@ struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 	if (fpsize > U16_MAX)
 		return NULL;
 
-	buf = efi_alloc(dpsize + fpsize + sizeof(END));
+	buf = efi_alloc(dpsize + fpsize + sizeof(EFI_DP_END));
 	if (!buf)
 		return NULL;
 
@@ -853,7 +853,7 @@ struct efi_device_path *efi_dp_from_file(const struct efi_device_path *dp,
 		pos += fpsize;
 	}
 
-	memcpy(pos, &END, sizeof(END));
+	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
 
 	return buf;
 }
@@ -862,7 +862,7 @@ struct efi_device_path *efi_dp_from_uart(void)
 {
 	void *buf, *pos;
 	struct efi_device_path_uart *uart;
-	size_t dpsize = dp_size(dm_root()) + sizeof(*uart) + sizeof(END);
+	size_t dpsize = dp_size(dm_root()) + sizeof(*uart) + sizeof(EFI_DP_END);
 
 	buf = efi_alloc(dpsize);
 	if (!buf)
@@ -873,7 +873,7 @@ struct efi_device_path *efi_dp_from_uart(void)
 	uart->dp.sub_type = DEVICE_PATH_SUB_TYPE_MSG_UART;
 	uart->dp.length = sizeof(*uart);
 	pos += sizeof(*uart);
-	memcpy(pos, &END, sizeof(END));
+	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
 
 	return buf;
 }
@@ -887,13 +887,13 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(struct udevice *dev)
 
 	dpsize += dp_size(dev);
 
-	start = buf = efi_alloc(dpsize + sizeof(END));
-	if (!buf)
+	start = efi_alloc(dpsize + sizeof(EFI_DP_END));
+	if (!start)
 		return NULL;
 
-	buf = dp_fill(buf, dev);
+	buf = dp_fill(start, dev);
 
-	*((struct efi_device_path *)buf) = END;
+	*((struct efi_device_path *)buf) = EFI_DP_END;
 
 	return start;
 }
@@ -903,7 +903,7 @@ struct efi_device_path __maybe_unused *efi_dp_from_eth(struct udevice *dev)
  *
  * Set the device path to an ethernet device path as provided by
  * efi_dp_from_eth() concatenated with a device path of subtype
- * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an END node.
+ * DEVICE_PATH_SUB_TYPE_MSG_IPV4, and an EFI_DP_END node.
  *
  * @ip:		IPv4 local address
  * @mask:	network mask
@@ -934,7 +934,7 @@ static struct efi_device_path *efi_dp_from_ipv4(struct efi_ipv4_address *ip,
 	if (srv)
 		memcpy(&dp.ipv4dp.remote_ip_address, srv, sizeof(*srv));
 	pos = &dp.end;
-	memcpy(pos, &END, sizeof(END));
+	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
 
 	dp1 = efi_dp_from_eth(dev);
 	if (!dp1)
@@ -979,7 +979,7 @@ struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev
 	}
 
 	uridp_len = sizeof(struct efi_device_path) + strlen(tmp) + 1;
-	uridp = efi_alloc(uridp_len + sizeof(END));
+	uridp = efi_alloc(uridp_len + sizeof(EFI_DP_END));
 	if (!uridp) {
 		log_err("Out of memory\n");
 		return NULL;
@@ -991,7 +991,7 @@ struct efi_device_path *efi_dp_from_http(const char *server, struct udevice *dev
 	memcpy(uridp->uri, tmp, strlen(tmp) + 1);
 
 	pos = (char *)uridp + uridp_len;
-	memcpy(pos, &END, sizeof(END));
+	memcpy(pos, &EFI_DP_END, sizeof(EFI_DP_END));
 
 	dp2 = efi_dp_concat(dp1, (const struct efi_device_path *)uridp, 0);
 
@@ -1009,11 +1009,11 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 	struct efi_device_path_memory *mdp;
 	void *buf, *start;
 
-	start = buf = efi_alloc(sizeof(*mdp) + sizeof(END));
-	if (!buf)
+	start = efi_alloc(sizeof(*mdp) + sizeof(EFI_DP_END));
+	if (!start)
 		return NULL;
 
-	mdp = buf;
+	mdp = start;
 	mdp->dp.type = DEVICE_PATH_TYPE_HARDWARE_DEVICE;
 	mdp->dp.sub_type = DEVICE_PATH_SUB_TYPE_MEMORY;
 	mdp->dp.length = sizeof(*mdp);
@@ -1022,7 +1022,7 @@ struct efi_device_path *efi_dp_from_mem(uint32_t memory_type,
 	mdp->end_address = start_address + size;
 	buf = &mdp[1];
 
-	*((struct efi_device_path *)buf) = END;
+	*((struct efi_device_path *)buf) = EFI_DP_END;
 
 	return start;
 }
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index f3ef3eabdae..87d52df5066 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -32,7 +32,7 @@ static efi_uintn_t EFIAPI get_device_path_size(
 	efi_uintn_t sz = 0;
 
 	EFI_ENTRY("%pD", device_path);
-	/* size includes the END node: */
+	/* size includes the EFI_DP_END node: */
 	if (device_path)
 		sz = efi_dp_size(device_path) + sizeof(struct efi_device_path);
 	return EFI_EXIT(sz);
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 2acae7856f9..44b806aadc4 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -200,7 +200,7 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
 		efi_free_pool(tmp_dp);
 		if (!*dp)
 			return EFI_OUT_OF_RESOURCES;
-		*dp_size += efi_dp_size(initrd_dp) + sizeof(END);
+		*dp_size += efi_dp_size(initrd_dp) + sizeof(EFI_DP_END);
 	}
 
 	if (fdt_dp) {
@@ -210,10 +210,10 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
 		efi_free_pool(tmp_dp);
 		if (!*dp)
 			return EFI_OUT_OF_RESOURCES;
-		*dp_size += efi_dp_size(fdt_dp) + sizeof(END);
+		*dp_size += efi_dp_size(fdt_dp) + sizeof(EFI_DP_END);
 	}
 
-	*dp_size += sizeof(END);
+	*dp_size += sizeof(EFI_DP_END);
 
 	return EFI_SUCCESS;
 }
-- 
2.43.0

base-commit: bab54f5942c428be698216224fd10b91d974d4da
branch: app-us
