Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02220C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 17:36:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61E9687575;
	Tue,  7 Nov 2023 18:36:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w/5/9VzV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B53871E9; Tue,  7 Nov 2023 18:36:42 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFA0E8757A
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 18:36:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9d242846194so890523266b.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699378599; x=1699983399; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c6LERe7z5UPQIrbXlOQrYISUbEmuTvjOYdoBpVeR/bc=;
 b=w/5/9VzVzI9dOAWxJuxkuplTTBaQzlb7nUIl2hbaDYGjBPkBNPBUcPcKiq/JLdQxtq
 d76m9vPAk9KyZf2W6vXkK9Uz7J0rWQR/pNdbtoogMpCXj9MK7lbFChbxkWl7AfOGxq3U
 7gkUZR8+ZWkMvK0xwl3VNjOI9Sf/nROkvOCkMlzJhO0QXZRmlwQ4UKg/6BVeEAe3yDl+
 /V6H56dwsrvunMh8pWk4O0vj6dTjQuRUhsHs/nRyR2iheeI2pSZcuiNDkUhT46y98FBV
 abNCV4zJ0SS6J3ywFgCEzdriIgqmdzm+uiDygD0kgleK4wVSgb75lOG0t0N+dvLsNnCq
 KNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699378599; x=1699983399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6LERe7z5UPQIrbXlOQrYISUbEmuTvjOYdoBpVeR/bc=;
 b=RrGzYpbPOyEnPTWl+3OqDu01gbTx+W36CGCOlJPizOktJvwLhFJ1222X54G+wc5MVN
 +FqMsE7F4cnc50ckbEfTzsShu+kQi6xcHYDZQhNd4CbWXh15OT7B2ANJalwMHfb+tNNx
 B79uin1L2DMVtTzTvmgWDVI7O09J7nEvFt3kQbxr7LP8sku4Ttsy2ciIp7cqiSNsUbkf
 fpzT/CBAzq4qR+gDAXhOY7+re0k0u5PpTDllglEcmmGmYDucuAz6sYMcXweoEQvBJbw2
 1x44FV88NWPJzroCu6AJbhnlruQMS1MLUYGcmd2YQkpNHT7yiCnqlGIqJgDg+qwx8xfz
 0+eQ==
X-Gm-Message-State: AOJu0YzwmQoP32tPCf48Zq70G26kt7n31VBTe50rOG2PlZ/F1h8jJhDU
 MTO1B8gD8z2AlcjUTjwfNMVoow13Pdq+44H/q8A=
X-Google-Smtp-Source: AGHT+IG6RHADDQ3OGp9Y8/ro6sOqtoeerieq5ZzvaCcesEngDRaH1A42HL/tSYGyI2aKN4YmBHZ8CQ==
X-Received: by 2002:a17:907:25cb:b0:9e0:727a:e491 with SMTP id
 ae11-20020a17090725cb00b009e0727ae491mr5584059ejc.35.1699378599355; 
 Tue, 07 Nov 2023 09:36:39 -0800 (PST)
Received: from localhost.localdomain (ppp046103219117.access.hol.gr.
 [46.103.219.117]) by smtp.gmail.com with ESMTPSA id
 n19-20020a17090625d300b009adce1c97ccsm1287234ejb.53.2023.11.07.09.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 09:36:39 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de
Cc: masahisa.kojima@linaro.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH] efi_loader: Clean up efi_dp_append and efi_dp_concat
Date: Tue,  7 Nov 2023 19:36:36 +0200
Message-Id: <20231107173636.114705-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
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
Kojima-san, I think this might affect your EFI HTTP boot series.
I don't mind waiting for this and merging it after your series goes in
(and adjust it). The changes should be trivial anyway

 cmd/bootefi.c                              |  4 +-
 cmd/eficonfig.c                            |  7 ++-
 cmd/efidebug.c                             |  6 +-
 include/efi_loader.h                       |  5 +-
 lib/efi_loader/efi_bootmgr.c               |  2 +-
 lib/efi_loader/efi_boottime.c              |  2 +-
 lib/efi_loader/efi_device_path.c           | 66 ++++++----------------
 lib/efi_loader/efi_device_path_utilities.c |  2 +-
 8 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 20e5c94a33a4..eb839136bf7e 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -513,8 +513,8 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
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
diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index e6e8a0a488e7..470adb7eddbf 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -528,7 +528,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	p += fp_size;
 	*((struct efi_device_path *)p) = END;

-	dp = efi_dp_append(dp_volume, (struct efi_device_path *)buf);
+	dp = efi_dp_concat(dp_volume, (struct efi_device_path *)buf, false);
 	free(buf);

 	return dp;
@@ -1481,7 +1481,8 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			ret = EFI_OUT_OF_RESOURCES;
 			goto out;
 		}
-		initrd_dp = efi_dp_append((const struct efi_device_path *)&id_dp, dp);
+		initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+					  dp, false);
 		efi_free_pool(dp);
 	}

@@ -1492,7 +1493,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	}
 	final_dp_size = efi_dp_size(dp) + sizeof(END);
 	if (initrd_dp) {
-		final_dp = efi_dp_concat(dp, initrd_dp);
+		final_dp = efi_dp_concat(dp, initrd_dp, true);
 		final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
 	} else {
 		final_dp = efi_dp_dup(dp);
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index 201531ac19fc..a62298bf5987 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -698,8 +698,8 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
 	if (!short_fp)
 		short_fp = tmp_fp;

-	initrd_dp = efi_dp_append((const struct efi_device_path *)&id_dp,
-				  short_fp);
+	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
+				  short_fp, false);

 out:
 	efi_free_pool(tmp_dp);
@@ -841,7 +841,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 		goto out;
 	}

-	final_fp = efi_dp_concat(file_path, initrd_dp);
+	final_fp = efi_dp_concat(file_path, initrd_dp, true);
 	if (!final_fp) {
 		printf("Cannot create final device path\n");
 		r = CMD_RET_FAILURE;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index e24410505f40..398cd20c7ae6 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -808,8 +808,6 @@ efi_uintn_t efi_dp_instance_size(const struct efi_device_path *dp);
 /* size of multi-instance device path excluding end node */
 efi_uintn_t efi_dp_size(const struct efi_device_path *dp);
 struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp);
-struct efi_device_path *efi_dp_append(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2);
 struct efi_device_path *efi_dp_append_node(const struct efi_device_path *dp,
 					   const struct efi_device_path *node);
 /* Create a device path node of given type, sub-type, length */
@@ -928,7 +926,8 @@ struct efi_load_option {
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
index a40762c74c83..646c7c7faaad 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -110,7 +110,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
 		if (!dp)
 			continue;

-		dp = efi_dp_append(dp, fp);
+		dp = efi_dp_concat(dp, fp, false);
 		if (!dp)
 			continue;

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 0b7579cb5af1..709ea07655c2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1821,7 +1821,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 	if (device_path) {
 		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);

-		dp = efi_dp_append(device_path, file_path);
+		dp = efi_dp_concat(device_path, file_path, false);
 		if (!dp) {
 			ret = EFI_OUT_OF_RESOURCES;
 			goto failure;
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index ed7214f3a347..ad79b65843e9 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -272,30 +272,27 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
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
+ *                  separated by an end node.
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
 	size_t end_size = sizeof(END);

-	if (concat)
-		end_size = 2 * sizeof(END);
 	if (!dp1 && !dp2) {
 		/* return an end node */
 		ret = efi_dp_dup(&END);
@@ -307,14 +304,18 @@ efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
 		/* both dp1 and dp2 are non-null */
 		unsigned sz1 = efi_dp_size(dp1);
 		unsigned sz2 = efi_dp_size(dp2);
-		void *p = efi_alloc(sz1 + sz2 + end_size);
+		void *p;
+
+		if (split_end_node)
+			end_size = 2 * sizeof(END);
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
@@ -328,37 +329,6 @@ efi_device_path *efi_dp_append_or_concatenate(const struct efi_device_path *dp1,
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
index a07d9bab3a3c..fa211aee495e 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -77,7 +77,7 @@ static struct efi_device_path * EFIAPI append_device_path(
 	const struct efi_device_path *src2)
 {
 	EFI_ENTRY("%pD, %pD", src1, src2);
-	return EFI_EXIT(efi_dp_append(src1, src2));
+	return EFI_EXIT(efi_dp_concat(src1, src2, false));
 }

 /*
--
2.40.1

