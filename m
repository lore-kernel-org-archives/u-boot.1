Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F5C3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 08:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C8F87929;
	Mon,  8 Jan 2024 09:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S2pjqTxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D392D8794A; Mon,  8 Jan 2024 09:55:44 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B52E5871A7
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 09:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d89446895so8731855e9.0
 for <u-boot@lists.denx.de>; Mon, 08 Jan 2024 00:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704704142; x=1705308942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XD+Jnl/IQEUwYUhUzl7LpqY5fOXTIO68nzQ9CAuBE1Q=;
 b=S2pjqTxE5we2BGxbwkr7++3FW7XqFdonGt4Sl0D6miWRmkv27a5FXBEOWNLfIdyC6F
 MudK69vMtWt5WsMFFA0WJvPVK6kmxSf34GXINbM4WdHZENcDL6nJgHRZVVaMxGUucFWl
 9hQOFNRKzr+MlmZD+mYBFNrtwWLWa8LHLj78jdZC+4qGUKVekhvjHukr05NOUx4cUxzz
 CewA1zdmnEp7OYgPGGydOk19z+OETWGp09O3jTH5ExKKhsnU2mudCn+xFxiBz3SXIyPP
 EYXFIUtwHyS2p7lFDJDG9EHXk6REI+RgWOAaHPcuTUmAxoZ4eVYQ7YN+j7j9HJJtWtCq
 WOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704704142; x=1705308942;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XD+Jnl/IQEUwYUhUzl7LpqY5fOXTIO68nzQ9CAuBE1Q=;
 b=mj1rvUsplMAJZ9myiDsnHtPux6NNk8quHDuk5+OLchmRnVLm78qC0DArPL0h+UqxEU
 bfaAQ6hDZszn4e0kX94TI3+b5Yb61TLvfgYnVz3Uxs8JWfyHp+oyMjMAr2yofI9m+qWL
 M48dNRH4V25eL7CLcdwF+x315myggmfOh78n+ls05ck7E+9PDd0PydK5m9vuTc3X6KxD
 jTZcCKQO8e0DMjs+38Db44gMDaaluydoOds3N+6kk+2MYBJAVWJ7fH9dU5rF9PwP7E0d
 fAFmLnG+9dUjZxTlWaZKSrd+jzAeum/bcX/CX+CxHapboEjoUeq3dJMasir22flInZPM
 sGSg==
X-Gm-Message-State: AOJu0YyZK899t1EbleqLlc3hIsbuciVjZDCfHWlXYmoWqV/+yZugjard
 ibn478mYtcjySKSy6dYdtiswtCboIecVCw==
X-Google-Smtp-Source: AGHT+IHEfpDijrxobZS+UeK0n9Ldw8y21Cz8fJlgej/VnjcgUDe24FPtIx61AzaoGnSfBbodYdW/Vw==
X-Received: by 2002:a05:600c:3583:b0:40e:4550:f35c with SMTP id
 p3-20020a05600c358300b0040e4550f35cmr739173wmq.129.1704704141964; 
 Mon, 08 Jan 2024 00:55:41 -0800 (PST)
Received: from hades.. (ppp089210121239.access.hol.gr. [89.210.121.239])
 by smtp.gmail.com with ESMTPSA id
 fm7-20020a05600c0c0700b0040e4914f28dsm1028916wmb.18.2024.01.08.00.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 00:55:41 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	u-boot@lists.denx.de
Subject: [PATCH v2] efi_loader: Clean up efi_dp_append and efi_dp_concat
Date: Mon,  8 Jan 2024 10:55:33 +0200
Message-Id: <20240108085534.951333-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
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

Looking back at the initrd storing functionality, we introduced three
functions, efi_dp_append_or_concatenate(), efi_dp_append/concat(). In
hindsight we could have simplified that by a lot. First of all none of
the functions append anything. They all allocate a new device path and
concatenate the contents of two device paths in one. A boolean parameter
controls the final device path -- if that's true an end node is injected
between the two device paths.

So let's rewrite this and make it a bit easier to read. Get rid of
efi_dp_append(), efi_dp_concat() and rename
efi_dp_append_or_concatenate() to efi_dp_concat(). This is far more
intuitive and the only adjustment that is needed is an extra boolean
argument on all callsites.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- move the size calculation in a single if
- Clarify the subtype of the device path we are using on the end node
- Rebase on top of -next
 cmd/eficonfig.c                            |  7 ++-
 cmd/efidebug.c                             |  6 +-
 include/efi_loader.h                       |  5 +-
 lib/efi_loader/efi_bootmgr.c               |  6 +-
 lib/efi_loader/efi_boottime.c              |  2 +-
 lib/efi_loader/efi_device_path.c           | 70 +++++++---------------
 lib/efi_loader/efi_device_path_utilities.c |  2 +-
 7 files changed, 35 insertions(+), 63 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 34a59cb15d0d..8234e602b8fb 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -531,7 +531,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	dp = efi_dp_shorten(dp_volume);
 	if (!dp)
 		dp = dp_volume;
-	dp = efi_dp_append(dp, &fp->dp);
+	dp = efi_dp_concat(dp, &fp->dp, false);
 	free(buf);

 	return dp;
@@ -1484,7 +1484,8 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			ret = EFI_OUT_OF_RESOURCES;
 			goto out;
 		}
-		initrd_dp = efi_dp_append((const struct efi_device_path *)&id_dp, dp);
+		initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+					  dp, false);
 		efi_free_pool(dp);
 	}

@@ -1495,7 +1496,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	}
 	final_dp_size = efi_dp_size(dp) + sizeof(END);
 	if (initrd_dp) {
-		final_dp = efi_dp_concat(dp, initrd_dp);
+		final_dp = efi_dp_concat(dp, initrd_dp, true);
 		final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
 	} else {
 		final_dp = efi_dp_dup(dp);
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index e10fbf891a42..836014ab8eab 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -699,8 +699,8 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
 	if (!short_fp)
 		short_fp = tmp_fp;

-	initrd_dp = efi_dp_append((const struct efi_device_path *)&id_dp,
-				  short_fp);
+	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+				  short_fp, false);

 out:
 	efi_free_pool(tmp_dp);
@@ -916,7 +916,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 		goto out;
 	}

-	final_fp = efi_dp_concat(file_path, initrd_dp);
+	final_fp = efi_dp_concat(file_path, initrd_dp, true);
 	if (!final_fp) {
 		printf("Cannot create final device path\n");
 		r = CMD_RET_FAILURE;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 34e7fbbf1840..d3725041b20d 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -819,8 +819,6 @@ efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
 /* size of multi-instance device path excluding end node */
 efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
 struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
-struct efi_device_path *efi_dp_append(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2);
 struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
 					   const struct efi_device_path *node);
 /* Create a device path node of given type, sub-type, length */
@@ -937,7 +935,8 @@ struct efi_load_option {
 struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
 				       const efi_guid_t *guid);
 struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2);
+				      const struct efi_device_path *dp2,
+				      bool split_end_node);
 struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
 efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
 					 efi_uintn_t *size);
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index a032d3ae04e2..dd2dd23c7b5a 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -143,7 +143,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
 		if (!dp)
 			continue;

-		dp = efi_dp_append(dp, fp);
+		dp = efi_dp_concat(dp, fp, false);
 		if (!dp)
 			continue;

@@ -1579,8 +1579,8 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 			goto out;
 		msg_path = file_path;
 	} else {
-		file_path = efi_dp_append(bootefi_device_path,
-					  bootefi_image_path);
+		file_path = efi_dp_concat(bootefi_device_path,
+					  bootefi_image_path, false);
 		msg_path = bootefi_image_path;
 		log_debug("Loaded from disk\n");
 	}
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index c579d89211be..1951291747cd 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1816,7 +1816,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 	if (device_path) {
 		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);

-		dp = efi_dp_append(device_path, file_path);
+		dp = efi_dp_concat(device_path, file_path, false);
 		if (!dp) {
 			ret = EFI_OUT_OF_RESOURCES;
 			goto failure;
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 8dbd8105ae26..500fa10d405f 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -271,30 +271,27 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 }

 /**
- * efi_dp_append_or_concatenate() - Append or concatenate two device paths.
- *				    Concatenated device path will be separated
- *				    by a sub-type 0xff end node
+ * efi_dp_concat() - Concatenate two device paths and add and terminate them
+ *                   with an end node.
  *
- * @dp1:	First device path
- * @dp2:	Second device path
- * @concat:	If true the two device paths will be concatenated and separated
- *		by an end of entrire device path sub-type 0xff end node.
- *		If true the second device path will be appended to the first and
- *		terminated by an end node
+ * @dp1:	    First device path
+ * @dp2:	    Second device path
+ * @split_end_node: If true the two device paths will be concatenated and
+ *                  separated by an end node (DEVICE_PATH_SUB_TYPE_END).
+ *		    If false the second device path will be concatenated to the
+ *		    first one as-is.
  *
  * Return:
  * concatenated device path or NULL. Caller must free the returned value
  */
-static struct
-efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
-					      const struct efi_device_path *dp2,
-					      bool concat)
+struct
+efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
+			       const struct efi_device_path *dp2,
+			       bool split_end_node)
 {
 	struct efi_device_path *ret;
-	size_t end_size = sizeof(END);
+	size_t end_size;

-	if (concat)
-		end_size = 2 * sizeof(END);
 	if (!dp1 && !dp2) {
 		/* return an end node */
 		ret = efi_dp_dup(&END);
@@ -306,14 +303,20 @@ efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
 		/* both dp1 and dp2 are non-null */
 		unsigned sz1 = efi_dp_size(dp1);
 		unsigned sz2 = efi_dp_size(dp2);
-		void *p = efi_alloc(sz1 + sz2 + end_size);
+		void *p;
+
+		if (split_end_node)
+			end_size = 2 * sizeof(END);
+		else
+			end_size = sizeof(END);
+		p = efi_alloc(sz1 + sz2 + end_size);
 		if (!p)
 			return NULL;
 		ret = p;
 		memcpy(p, dp1, sz1);
 		p += sz1;

-		if (concat) {
+		if (split_end_node) {
 			memcpy(p, &END, sizeof(END));
 			p += sizeof(END);
 		}
@@ -327,37 +330,6 @@ efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
 	return ret;
 }

-/**
- * efi_dp_append() - Append a device to an existing device path.
- *
- * @dp1:	First device path
- * @dp2:	Second device path
- *
- * Return:
- * concatenated device path or NULL. Caller must free the returned value
- */
-struct efi_device_path *efi_dp_append(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2)
-{
-	return efi_dp_append_or_concatenate(dp1, dp2, false);
-}
-
-/**
- * efi_dp_concat() - Concatenate 2 device paths. The final device path will
- *                   contain two device paths separated by and end node (0xff).
- *
- * @dp1:	First device path
- * @dp2:	Second device path
- *
- * Return:
- * concatenated device path or NULL. Caller must free the returned value
- */
-struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2)
-{
-	return efi_dp_append_or_concatenate(dp1, dp2, true);
-}
-
 struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
 					   const struct efi_device_path *node)
 {
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index 844d8acd67c0..c95dbfa9b5f6 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
 	const struct efi_device_path *src2)
 {
 	EFI_ENTRY("%pD, %pD", src1, src2);
-	return EFI_EXIT(efi_dp_append(src1, src2));
+	return EFI_EXIT(efi_dp_concat(src1, src2, false));
 }

 /*
--
2.37.2

