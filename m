Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587A7C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 11:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74161884C3;
	Sat, 13 Jul 2024 13:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="SmgpLlzB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D1088676; Sat, 13 Jul 2024 13:30:44 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 908C786BF1
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 13:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D0873F6B6
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 11:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1720870240;
 bh=gxOa+ISv//vzJ+IVAFjUmAgVcAJJiN9BVvOxU3gHeTY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=SmgpLlzBPjBZIO825uXjD/vtwGTkcq7K+I6OqZX05iAlSscdAkMnBrByXxLk8xu6q
 p4rNjnsuKBXPFm1QMwY9QUwKXAzLjNcMzloSJNAQddnRgnS0fTv/f8H4xeowqxydUZ
 xJaxo+tgy3z8HHs5Ng+UAYJXoPdu9CeGnrl/zh2tducAOr8gcaTfUjaNoEDXE+kw58
 L6Mey1yITCBieWgoagOqkjx2qAQot1J784ctbPFYtUdNlKInwcZWff8Z3GN7yUUfp7
 rscvZp1q9bviB+MPaCVMZZmRHIR0Az3llB/3nHBw1TbZDldpktprelDuJHIrjwHcIL
 4gZAZ04cOyiMw==
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-52e96ca162dso2742561e87.3
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 04:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720870239; x=1721475039;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxOa+ISv//vzJ+IVAFjUmAgVcAJJiN9BVvOxU3gHeTY=;
 b=JeWCe/KNOYiVtdZ7O+OxqHpVKiBls0NCCohTGgi67KaXWeD4w1SIxXfXAYOghUrwuk
 gj5KENlNHQ05LT3MgCVAg7XW02JYpg0WX27VfJlxnKHqN1YLmg2/xNcGgL5++4nl6A6q
 G+nfsa6rhjsnYZOcmvSNgb/y7H0hx0w0GxaSs+V1TiD3eJmFdQykXRoMfLDrecZs44Kq
 oS+e0uEIyzQRvDpfUQaUxBHUJAjYHKSGjiHC9P9LRdHZYcWZWwQwIdrySjheugkLyrDN
 gFlP2J6TmGYWvcxCR+gmErNTFuZfe0FbJAasH8ZdJwfMvicDqkID4InayQIzvI7Iu+rV
 5xgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnBOqCRLsO9nofMpllTS6iQ2j3mNTtfyFCcekDN6SlQktCixTLHyB/wLRO8AZsel8TigYRO+cD/elp9jbW9ksWBC803A==
X-Gm-Message-State: AOJu0Yyru4LOrTN8MajjwC439s/bfRAZZMkolpJCk3nxnGbGucZPNDYo
 NYysVV6YLN87l/pSeFZaPNDgIkYvhWunRer5vwJRmpUNm0giN3+y8PPbEdVpZffqbINk3QLmeR9
 o9lRY1mLp0+4noK38TMKBW6h8cAWVDNYSIqpZWpQ/QTMPI/T+lJs/8Fs1SuWmBug7/VY=
X-Received: by 2002:a05:6512:401a:b0:52e:9423:867f with SMTP id
 2adb3069b0e04-52eb99a137bmr10573815e87.36.1720870239131; 
 Sat, 13 Jul 2024 04:30:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7LW4p2xazB8RN33kW3/70Acilp+YITjWnU4SPVfRH4bCRIPC8vPAm5t+dRC0N+Fb3bQeVFg==
X-Received: by 2002:a05:6512:401a:b0:52e:9423:867f with SMTP id
 2adb3069b0e04-52eb99a137bmr10573795e87.36.1720870238437; 
 Sat, 13 Jul 2024 04:30:38 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-093-080.um16.pools.vodafone-ip.de. [62.143.93.80])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc244sm51368535e9.37.2024.07.13.04.30.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 04:30:37 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: E Shattow <lucent@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] efi_loader: find distro device-path for media devices
Date: Sat, 13 Jul 2024 13:30:29 +0200
Message-ID: <20240713113029.78262-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

The auto-generated load options for media device do not contain a partition
node. We cannot expect the simple file protocol here.

Get the partition device-path via the loaded image protocol.

Fixes: e91b68fd6b83 ("efi_loader: load distro dtb in bootmgr")
Reported-by: E Shattow <lucent@gmail.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/efi_loader.h         |  2 +-
 lib/efi_loader/efi_bootmgr.c |  2 +-
 lib/efi_loader/efi_fdt.c     | 33 +++++++++++++++++++--------------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 6c993e1a694..2a06fbe4704 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1205,6 +1205,6 @@ efi_status_t efi_load_option_dp_join(struct efi_device_path **dp,
 
 int efi_get_distro_fdt_name(char *fname, int size, int seq);
 
-void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size);
+void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size);
 
 #endif /* _EFI_LOADER_H */
diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 304ed43595c..589d3996b68 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1277,7 +1277,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		if (fdt_lo)
 			fdt = fdt_lo;
 		if (!fdt) {
-			efi_load_distro_fdt(&fdt_distro, &fdt_size);
+			efi_load_distro_fdt(handle, &fdt_distro, &fdt_size);
 			fdt = fdt_distro;
 		}
 	}
diff --git a/lib/efi_loader/efi_fdt.c b/lib/efi_loader/efi_fdt.c
index 86ba00c2bdd..4ccf2055be3 100644
--- a/lib/efi_loader/efi_fdt.c
+++ b/lib/efi_loader/efi_fdt.c
@@ -75,28 +75,34 @@ int efi_get_distro_fdt_name(char *fname, int size, int seq)
 /**
  * efi_load_distro_fdt() - load distro device-tree
  *
+ * @handle:	handle of loaded image
  * @fdt:	on return device-tree, must be freed via efi_free_pages()
  * @fdt_size:	buffer size
  */
-void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size)
+void efi_load_distro_fdt(efi_handle_t handle, void **fdt, efi_uintn_t *fdt_size)
 {
-	struct efi_device_path *rem, *dp;
+	struct efi_device_path *dp;
 	efi_status_t  ret;
+	struct efi_handler *handler;
+	struct efi_loaded_image *loaded_image;
 	efi_handle_t device;
 
 	*fdt = NULL;
 
-	dp = efi_get_dp_from_boot(NULL);
-	if (!dp)
+	/* Get boot device from loaded image protocol */
+	ret = efi_search_protocol(handle, &efi_guid_loaded_image, &handler);
+	if (ret != EFI_SUCCESS)
 		return;
-	device = efi_dp_find_obj(dp, NULL, &rem);
-	ret = efi_search_protocol(device, &efi_simple_file_system_protocol_guid,
-				  NULL);
+	loaded_image = handler->protocol_interface;
+	device = loaded_image->device_handle;
+
+	/* Get device path of boot device */
+	ret = efi_search_protocol(device, &efi_guid_device_path, &handler);
 	if (ret != EFI_SUCCESS)
-		goto err;
-	memcpy(rem, &END, sizeof(END));
+		return;
+	dp = handler->protocol_interface;
 
-	/* try the various available names */
+	/* Try the various available names */
 	for (int seq = 0; ; ++seq) {
 		struct efi_device_path *file;
 		char buf[255];
@@ -108,10 +114,9 @@ void efi_load_distro_fdt(void **fdt, efi_uintn_t *fdt_size)
 			break;
 		ret = efi_load_image_from_path(true, file, fdt, fdt_size);
 		efi_free_pool(file);
-		if (ret == EFI_SUCCESS)
+		if (ret == EFI_SUCCESS) {
+			log_debug("Fdt %pD loaded\n", file);
 			break;
+		}
 	}
-
-err:
-	efi_free_pool(dp);
 }
-- 
2.45.2

