Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C84C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 09:11:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 318A3884B8;
	Mon, 10 Jun 2024 11:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="QiI/8Yrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D926A884C3; Mon, 10 Jun 2024 11:11:09 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7683B88476
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 11:11:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BD81C3F220
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 09:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718010664;
 bh=jkPCMGNG8vQDTIQiGgyugxGTxQlZTBjcrr9YeZ8BSOc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=QiI/8YrmNKaSMcjk16EgCKfMCnDhIq1+C4vbQkalSdynRX6KpUXyk3VPu8RaIgfH/
 pfvTqQcJwja5Myf+d0vrNWjLgmsKyrrwXj+Rn1lKcFjG059lXIrrxR97p29DgjWfsJ
 g8JWuwc50/C/iNKLtsHChedsXFr5fJ9gJqomhxEWGEDyKMy6i//gcUPc97ifTWYp39
 2VNOgj4LL6q+t6p76JyOiB1KEHal9a2o5D6tyXQkM/6bEI29WZoGthrKJ1icWNn+bZ
 +f06ZeUc+Z/AD2BRza+FOEuFYLuO5PkySFM3zdLFSPKmeKgxgEdC8LGvq72hwSTM43
 pXq0SC3cY+AHg==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42183fdd668so5805515e9.2
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 02:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718010664; x=1718615464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jkPCMGNG8vQDTIQiGgyugxGTxQlZTBjcrr9YeZ8BSOc=;
 b=UeqYHleQh04sDpqRRGvL6ajp1d8i4YsRwUSeAhYTBiMz4tdlNDt/tNbbV9qoOctk8S
 NZcS4bmtqLqwwZtp0HhXkNxm2J/raJS8ZrDHfOknDezwkuvXyr2GYEKlasTalW5H8VMj
 ZY8jMnC7Yo9BtDJYKg1unJH5CQORIReFhTmSlKioVkwOdLwDeSCMzBh0tiheepqD/Mnw
 fdPT8YqMhTW32TGcwe/Skl+oHaQTxn7UafkFplPlNaaM8Fe1C7eDadxQyRVK1W9uAGqv
 UD0dv3nf8JEfWGU7zKtGVtokzk7DZ4C5Fs1X1Ia6CY02GDXu74tFBC/UzS1Cu4YlyMnD
 109Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCg1d5Yft/VK1Vdc+1ejfZXJbL4Lm3jetb73nNFee8HFkdrUnrzSVHMCEzWR0FjxJihSZVaTraLfxnvPH2uShFraCxAA==
X-Gm-Message-State: AOJu0YyYr/Swln8dT/AxC/juh07FnJx+yzbrNb0zLFnYblwilaJGlwfd
 hB2PQas3ZUIf3eDmottBL4GrWHkN2Lakq4X6Cxy2kdVBMsVH9HZDHNrw+znO40XCyzTnqWFbGuz
 kLZjxW+1blCkt1MaSNiO9tpY66ZhEVUK5XEBmd1hBPd7ZvKoVFZxBZXgocZqe/Hikdbc=
X-Received: by 2002:a05:600c:3b08:b0:421:bb51:d605 with SMTP id
 5b1f17b1804b1-421bb51d71dmr22208345e9.6.1718010663898; 
 Mon, 10 Jun 2024 02:11:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC582yyO8SeqEatweGiMga2YQK1TpvRT940DFboRkuixrmVCc5AIqRYQTqkbeBy+MnAtyPQg==
X-Received: by 2002:a05:600c:3b08:b0:421:bb51:d605 with SMTP id
 5b1f17b1804b1-421bb51d71dmr22208165e9.6.1718010663491; 
 Mon, 10 Jun 2024 02:11:03 -0700 (PDT)
Received: from workstation5.. ([2a00:20:43:88b5:6b2b:e162:4c45:5c4c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42183c08f49sm41059465e9.6.2024.06.10.02.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:11:03 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Bin Meng <bmeng@tinylab.org>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/9] efi_loader: allow concatenation with contained end node
Date: Mon, 10 Jun 2024 11:10:49 +0200
Message-ID: <20240610091057.64463-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
References: <20240610091057.64463-1-heinrich.schuchardt@canonical.com>
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

Allow appending a device-path to a device-path that contains an end node
as separator. We need this feature for creating boot options specifying
kernel, initrd, and dtb.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
v3:
	no change
v2:
	update efi_dp_concat() instead of new function efi_dp_merge()
---
 cmd/eficonfig.c                            |  6 +++---
 cmd/efidebug.c                             |  4 ++--
 include/efi_loader.h                       |  2 +-
 lib/efi_loader/efi_bootbin.c               |  2 +-
 lib/efi_loader/efi_bootmgr.c               |  2 +-
 lib/efi_loader/efi_boottime.c              |  2 +-
 lib/efi_loader/efi_device_path.c           | 20 +++++++++++++-------
 lib/efi_loader/efi_device_path_utilities.c |  2 +-
 8 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 0ba92c60e03..b13d9a3d2d9 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -531,7 +531,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	dp = efi_dp_shorten(dp_volume);
 	if (!dp)
 		dp = dp_volume;
-	dp = efi_dp_concat(dp, &fp->dp, false);
+	dp = efi_dp_concat(dp, &fp->dp, 0);
 	free(buf);
 
 	return dp;
@@ -1485,7 +1485,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			goto out;
 		}
 		initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
-					  dp, false);
+					  dp, 0);
 		efi_free_pool(dp);
 	}
 
@@ -1496,7 +1496,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 	}
 	final_dp_size = efi_dp_size(dp) + sizeof(END);
 	if (initrd_dp) {
-		final_dp = efi_dp_concat(dp, initrd_dp, true);
+		final_dp = efi_dp_concat(dp, initrd_dp, 1);
 		final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
 	} else {
 		final_dp = efi_dp_dup(dp);
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index c2c525f2351..762027daf8a 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -697,7 +697,7 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
 		short_fp = tmp_fp;
 
 	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
-				  short_fp, false);
+				  short_fp, 0);
 
 out:
 	efi_free_pool(tmp_dp);
@@ -917,7 +917,7 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 		goto out;
 	}
 
-	final_fp = efi_dp_concat(file_path, initrd_dp, true);
+	final_fp = efi_dp_concat(file_path, initrd_dp, 1);
 	if (!final_fp) {
 		printf("Cannot create final device path\n");
 		r = CMD_RET_FAILURE;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 9600941aa32..ddf2e41a95c 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -946,7 +946,7 @@ struct efi_device_path *efi_dp_from_lo(struct efi_load_option *lo,
 				       const efi_guid_t *guid);
 struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 				      const struct efi_device_path *dp2,
-				      bool split_end_node);
+				      size_t split_end_node);
 struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
 efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
 					 efi_uintn_t *size);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b7910f78fb6..a87006b3c0e 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -150,7 +150,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 		msg_path = file_path;
 	} else {
 		file_path = efi_dp_concat(bootefi_device_path,
-					  bootefi_image_path, false);
+					  bootefi_image_path, 0);
 		msg_path = bootefi_image_path;
 		log_debug("Loaded from disk\n");
 	}
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 7da3139f917..b0bf21cf841 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -130,7 +130,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
 		if (!dp)
 			continue;
 
-		dp = efi_dp_concat(dp, fp, false);
+		dp = efi_dp_concat(dp, fp, 0);
 		if (!dp)
 			continue;
 
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 1951291747c..630c5f52c4f 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1816,7 +1816,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 	if (device_path) {
 		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
 
-		dp = efi_dp_concat(device_path, file_path, false);
+		dp = efi_dp_concat(device_path, file_path, 0);
 		if (!dp) {
 			ret = EFI_OUT_OF_RESOURCES;
 			goto failure;
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index aec224d8466..c8c8d54f733 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -276,10 +276,11 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
  *
  * @dp1:	    First device path
  * @dp2:	    Second device path
- * @split_end_node: If true the two device paths will be concatenated and
- *                  separated by an end node (DEVICE_PATH_SUB_TYPE_END).
- *		    If false the second device path will be concatenated to the
- *		    first one as-is.
+ * @split_end_node:
+ * * 0 to concatenate
+ * * 1 to concatenate with end node added as separator
+ * * size of dp1 excluding last end node to concatenate with end node as
+ *   separator in case dp1 contains an end node
  *
  * Return:
  * concatenated device path or NULL. Caller must free the returned value
@@ -287,7 +288,7 @@ struct efi_device_path *efi_dp_dup(const struct efi_device_path *dp)
 struct
 efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 			       const struct efi_device_path *dp2,
-			       bool split_end_node)
+			       size_t split_end_node)
 {
 	struct efi_device_path *ret;
 	size_t end_size;
@@ -301,10 +302,15 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 		ret = efi_dp_dup(dp1);
 	} else {
 		/* both dp1 and dp2 are non-null */
-		unsigned sz1 = efi_dp_size(dp1);
-		unsigned sz2 = efi_dp_size(dp2);
+		size_t sz1;
+		size_t sz2 = efi_dp_size(dp2);
 		void *p;
 
+		if (split_end_node < sizeof(struct efi_device_path))
+			sz1 = efi_dp_size(dp1);
+		else
+			sz1 = split_end_node;
+
 		if (split_end_node)
 			end_size = 2 * sizeof(END);
 		else
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index c95dbfa9b5f..ac250bbfcc9 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
 	const struct efi_device_path *src2)
 {
 	EFI_ENTRY("%pD, %pD", src1, src2);
-	return EFI_EXIT(efi_dp_concat(src1, src2, false));
+	return EFI_EXIT(efi_dp_concat(src1, src2, 0));
 }
 
 /*
-- 
2.43.0

