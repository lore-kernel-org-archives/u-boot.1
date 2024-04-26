Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FA9C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:14:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5568885CA;
	Fri, 26 Apr 2024 16:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RQQD71CT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEFEC885BE; Fri, 26 Apr 2024 16:13:52 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B485885AE
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 06BFB3FE58
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140830;
 bh=ycaUs8QeNyJ3M70xtoVidqljHwEoS3kMAM3I6zihxFs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RQQD71CTFGDM/k6kEVe0KcEnZxktFcIJuDDylnxUiZteAPCRgGT84s1H6kw77Pj7R
 HZ8uclseBMFJ9ZeA+K0rRxiEDOprYfup87ihGzljSNs78P4My32Pu7UmOzTCTKitPU
 /8DZVo6fVoOfy8+BCQHmiXdyDwkAHp1T9tVzPaE66fkydiNrHIvD5OZZdKE6EJevSs
 24wJ00ObXBzEicgNTydf2t/kf/JapAwLo0mraq3bq/9GozB0xvokq3yDroOW6tQEKc
 HfzLQ+Ch/inXpeNKpmckF+Cs+pmXtgNP4v1yoZcGM8g/nbP5Dh/WtpL+aaVm614uca
 UarTD+P8eFQ4g==
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-41a074e2d69so9627775e9.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140829; x=1714745629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ycaUs8QeNyJ3M70xtoVidqljHwEoS3kMAM3I6zihxFs=;
 b=YIY6BqJaVh6qLbrY8cJF8PxjNOYZHl4gb31iNasoUCsGElnbIaJKuiM0/2SJehsBTr
 nOOwsCH+8lJtpqsUXvjXcUJmzU+p32hQvwg7svn95jy/mLKvJJAkNeiH6G30Ro5TK/kn
 cRwU3L3aIokYmLp/U5ZxXw6vAO905BoTGiwFG37CQkP3QPugQ77W8lfPlpzZCxdFpy+S
 Tyiizn5CtMrcX2qyYMABeQslQzt98PKG7r+VpkXUf+Y5WsR58QzVYgCn/Th5URSoqAL4
 OXNgTHqGnq46g2baNlBcsxmdEUQdZE07uazmsMh2P05pBCn/UqO6+VW6wCfq1RFjWLn4
 DF4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDfrp8keloahgHZcoRQqBDKPSxVF8oQGhJFeoY9twpD9iGt3VGGAYYPHI8JRLVQl7QLCBa0/amcqyabds/EUDTdIF7ZA==
X-Gm-Message-State: AOJu0YyiCBLL/Grbkfo8vzoLKnfPEtL6vrb2RcImY4r2tynh2IwawqDF
 rx6q9eR8EEaF32IRnl2Nd2DI3tS+zw10Ec/crrD7G6MZc4MJlk2z5fcehxRC9PSb0pq50j1IW1y
 BOFBaH7bKof/L22gqZHBHyJt+1Wl+KMLrhfhbjXzmlA+ULdgeTjjZksPTeSKefhKhqJE=
X-Received: by 2002:a5d:60d0:0:b0:343:8373:1591 with SMTP id
 x16-20020a5d60d0000000b0034383731591mr1868907wrt.64.1714140829488; 
 Fri, 26 Apr 2024 07:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVvZrDT18HCuL85nAoQMA43X0km9Pimx1Q1JGn2566t2EFi+ronvgY6iZr0k2wEvZ8auDa7w==
X-Received: by 2002:a5d:60d0:0:b0:343:8373:1591 with SMTP id
 x16-20020a5d60d0000000b0034383731591mr1868888wrt.64.1714140829135; 
 Fri, 26 Apr 2024 07:13:49 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 03/14] efi_loader: simplify efi_dp_concat()
Date: Fri, 26 Apr 2024 16:13:10 +0200
Message-ID: <20240426141321.232236-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
References: <20240426141321.232236-1-heinrich.schuchardt@canonical.com>
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

As we now have efi_dp_merge() we can use this function to replace
efi_dp_concat(,,true) and remove the last parameter from efi_dp_concat()
otherwise.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 cmd/eficonfig.c                            | 22 +++++++++---------
 cmd/efidebug.c                             | 17 +++++++++-----
 include/efi_loader.h                       |  3 +--
 lib/efi_loader/efi_bootbin.c               |  2 +-
 lib/efi_loader/efi_bootmgr.c               |  2 +-
 lib/efi_loader/efi_boottime.c              |  2 +-
 lib/efi_loader/efi_device_path.c           | 26 ++++------------------
 lib/efi_loader/efi_device_path_utilities.c |  2 +-
 8 files changed, 31 insertions(+), 45 deletions(-)

diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
index 0ba92c60e03..1c57e66040b 100644
--- a/cmd/eficonfig.c
+++ b/cmd/eficonfig.c
@@ -531,7 +531,7 @@ struct efi_device_path *eficonfig_create_device_path(struct efi_device_path *dp_
 	dp = efi_dp_shorten(dp_volume);
 	if (!dp)
 		dp = dp_volume;
-	dp = efi_dp_concat(dp, &fp->dp, false);
+	dp = efi_dp_concat(dp, &fp->dp);
 	free(buf);
 
 	return dp;
@@ -1485,7 +1485,7 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 			goto out;
 		}
 		initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
-					  dp, false);
+					  dp);
 		efi_free_pool(dp);
 	}
 
@@ -1494,17 +1494,17 @@ static efi_status_t eficonfig_edit_boot_option(u16 *varname, struct eficonfig_bo
 		ret = EFI_OUT_OF_RESOURCES;
 		goto out;
 	}
-	final_dp_size = efi_dp_size(dp) + sizeof(END);
+
+	final_dp = dp;
+	final_dp_size = efi_dp_size(final_dp) + sizeof(END);
+
 	if (initrd_dp) {
-		final_dp = efi_dp_concat(dp, initrd_dp, true);
-		final_dp_size += efi_dp_size(initrd_dp) + sizeof(END);
-	} else {
-		final_dp = efi_dp_dup(dp);
+		final_dp = efi_dp_merge(final_dp, &final_dp_size, initrd_dp);
+		if (!final_dp) {
+			ret = EFI_OUT_OF_RESOURCES;
+			goto out;
+		}
 	}
-	efi_free_pool(dp);
-
-	if (!final_dp)
-		goto out;
 
 	if (utf16_utf8_strlen(bo->optional_data)) {
 		len = utf16_utf8_strlen(bo->optional_data) + 1;
diff --git a/cmd/efidebug.c b/cmd/efidebug.c
index a587860e2a5..93ba16efc7d 100644
--- a/cmd/efidebug.c
+++ b/cmd/efidebug.c
@@ -697,7 +697,7 @@ struct efi_device_path *create_initrd_dp(const char *dev, const char *part,
 		short_fp = tmp_fp;
 
 	initrd_dp = efi_dp_concat((const struct efi_device_path *)&id_dp,
-				  short_fp, false);
+				  short_fp);
 
 out:
 	efi_free_pool(tmp_dp);
@@ -917,11 +917,16 @@ static int do_efi_boot_add(struct cmd_tbl *cmdtp, int flag,
 		goto out;
 	}
 
-	final_fp = efi_dp_concat(file_path, initrd_dp, true);
-	if (!final_fp) {
-		printf("Cannot create final device path\n");
-		r = CMD_RET_FAILURE;
-		goto out;
+	final_fp = file_path;
+	fp_size = efi_dp_size(final_fp) + sizeof(END);
+
+	if (initrd_dp) {
+		final_fp = efi_dp_merge(final_fp, &fp_size, initrd_dp);
+		if (!final_fp) {
+			printf("Cannot create final device path\n");
+			r = CMD_RET_FAILURE;
+			goto out;
+		}
 	}
 
 	lo.file_path = final_fp;
diff --git a/include/efi_loader.h b/include/efi_loader.h
index a7d7b8324f1..0ac04990b8e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -948,8 +948,7 @@ struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
 				     efi_uintn_t *size,
 				     const struct efi_device_path *dp2);
 struct efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
-				      const struct efi_device_path *dp2,
-				      bool split_end_node);
+				      const struct efi_device_path *dp2);
 struct efi_device_path *search_gpt_dp_node(struct efi_device_path *device_path);
 efi_status_t efi_deserialize_load_option(struct efi_load_option *lo, u8 *data,
 					 efi_uintn_t *size);
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index b7910f78fb6..745b941b6ca 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -150,7 +150,7 @@ efi_status_t efi_run_image(void *source_buffer, efi_uintn_t source_size)
 		msg_path = file_path;
 	} else {
 		file_path = efi_dp_concat(bootefi_device_path,
-					  bootefi_image_path, false);
+					  bootefi_image_path);
 		msg_path = bootefi_image_path;
 		log_debug("Loaded from disk\n");
 	}
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 4ac519228a6..db394df6bf4 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -130,7 +130,7 @@ static efi_status_t try_load_from_file_path(efi_handle_t *fs_handles,
 		if (!dp)
 			continue;
 
-		dp = efi_dp_concat(dp, fp, false);
+		dp = efi_dp_concat(dp, fp);
 		if (!dp)
 			continue;
 
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 1951291747c..33f03c0cb0f 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -1816,7 +1816,7 @@ efi_status_t efi_setup_loaded_image(struct efi_device_path *device_path,
 	if (device_path) {
 		info->device_handle = efi_dp_find_obj(device_path, NULL, NULL);
 
-		dp = efi_dp_concat(device_path, file_path, false);
+		dp = efi_dp_concat(device_path, file_path);
 		if (!dp) {
 			ret = EFI_OUT_OF_RESOURCES;
 			goto failure;
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_path.c
index 16cbe41d32f..75fe95c9c1e 100644
--- a/lib/efi_loader/efi_device_path.c
+++ b/lib/efi_loader/efi_device_path.c
@@ -307,21 +307,15 @@ struct efi_device_path *efi_dp_merge(const struct efi_device_path *dp1,
  *
  * @dp1:	    First device path
  * @dp2:	    Second device path
- * @split_end_node: If true the two device paths will be concatenated and
- *                  separated by an end node (DEVICE_PATH_SUB_TYPE_END).
- *		    If false the second device path will be concatenated to the
- *		    first one as-is.
  *
  * Return:
  * concatenated device path or NULL. Caller must free the returned value
  */
 struct
 efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
-			       const struct efi_device_path *dp2,
-			       bool split_end_node)
+			       const struct efi_device_path *dp2)
 {
 	struct efi_device_path *ret;
-	size_t end_size;
 
 	if (!dp1 && !dp2) {
 		/* return an end node */
@@ -333,29 +327,17 @@ efi_device_path *efi_dp_concat(const struct efi_device_path *dp1,
 	} else {
 		/* both dp1 and dp2 are non-null */
 		unsigned sz1 = efi_dp_size(dp1);
-		unsigned sz2 = efi_dp_size(dp2);
+		/* the end node of the second device path has to be retained */
+		unsigned int sz2 = efi_dp_size(dp2) + sizeof(END);
 		void *p;
 
-		if (split_end_node)
-			end_size = 2 * sizeof(END);
-		else
-			end_size = sizeof(END);
-		p = efi_alloc(sz1 + sz2 + end_size);
+		p = efi_alloc(sz1 + sz2);
 		if (!p)
 			return NULL;
 		ret = p;
 		memcpy(p, dp1, sz1);
 		p += sz1;
-
-		if (split_end_node) {
-			memcpy(p, &END, sizeof(END));
-			p += sizeof(END);
-		}
-
-		/* the end node of the second device path has to be retained */
 		memcpy(p, dp2, sz2);
-		p += sz2;
-		memcpy(p, &END, sizeof(END));
 	}
 
 	return ret;
diff --git a/lib/efi_loader/efi_device_path_utilities.c b/lib/efi_loader/efi_device_path_utilities.c
index c95dbfa9b5f..5f06602dba6 100644
--- a/lib/efi_loader/efi_device_path_utilities.c
+++ b/lib/efi_loader/efi_device_path_utilities.c
@@ -76,7 +76,7 @@ static struct efi_device_path * EFIAPI append_device_path(
 	const struct efi_device_path *src2)
 {
 	EFI_ENTRY("%pD, %pD", src1, src2);
-	return EFI_EXIT(efi_dp_concat(src1, src2, false));
+	return EFI_EXIT(efi_dp_concat(src1, src2));
 }
 
 /*
-- 
2.43.0

