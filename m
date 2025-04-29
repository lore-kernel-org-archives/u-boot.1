Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76700C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 13:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F1E82A3B;
	Tue, 29 Apr 2025 15:27:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GBUM78/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F19829B2; Tue, 29 Apr 2025 15:27:21 +0200 (CEST)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20B182AAA
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 15:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af50f56b862so4081537a12.1
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745933237; x=1746538037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkU4USPMzbiGMP1d9c43dN9ztVHy52m+jy3g/aCyjeE=;
 b=GBUM78/sP3MWKtaTWLGumIA9vL2S7ujiGkFuG7+qaX4uWUFaH7TBNZIdkpO0+5ikls
 ppcfJE9AXkEsEAJinONfyu076VVMb9fY+NKGBoYTucVLihkAPwtiMPfn+h6ineN7kiX3
 Qr24JfLVodD3NCt/qiz5QDr73HyRV3V4gfeg0HXZO5jvTQNIqe0YdPt6L1hhkzyUIgoD
 rH4kBDm3IMovitEWvbB4MPE4xWhvv/1PpFw2Yw+1ubLpeg8jTtN5LtJb5y8TIsXfq7GL
 IPkxhal9JHgNi5XCdqkbbVmlENLMhoUl6h7HTEukZgKI39PzgC7P9NPjWA7YQZsY6ynS
 AYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745933237; x=1746538037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rkU4USPMzbiGMP1d9c43dN9ztVHy52m+jy3g/aCyjeE=;
 b=OVYDSNsK0/+mHsP4DEDnGqahyT2cqufQNMFq4HMGyFvk8FfgS1MpnzSqXMrago4Zr9
 iMpq+e0ZOrQWf76/f/WthbPwg5dWSvobJd0Rws0Es0wsGGzfkMIwariOZhvgG1xX5rhq
 C6o9EEDcTW1i46n8dqSTJBrVmp08Rc3gP8ssIFmemm27QPe6mtAqe9dfyf0Ub9uXeKHX
 BoY1tKCDoVVCllFX69Qt+Kljhpf5tTNAFU2jyma2VM8A6m7I4iZF25IPSbtK7wQxJari
 lpcunvqEg8UlBLZ4EOcosOff7FE96el6eAhG+dbN74MGrL+w9tEKBi7AbtiKZ7+un+2u
 pT5A==
X-Gm-Message-State: AOJu0YxkW/nRycqvyAIkQ0VAJgeYwbz/kHh9cUzXvsnNCB2aDsZ9pNvT
 5Kb8ZVqMOVD6Wsz+lh3JumNbkkUoQQ8o53MXTps8JdSde/6fjVoKtCZXlGofdIg=
X-Gm-Gg: ASbGncsFZWTjyeuz24EShkeH9ZSjwttA0Wj63CWaWMhqqOeMH8DhW+hIV9cfxDAIsmS
 n6VBu5XHVyNRNdSW6n0CPC59RuJPfIcLICx/gMqEqYwTt6vdNVc6BXtTwcpxNSJYXJqDYNTPJhB
 amVULcmnHZ5uL/k4/xeHx1zdbJ/F6e3Kd28phi7+8gfMMis8151ZWli6B4ZENDTnoGq42F4SYMu
 z/x/dLakfcu6pg+6Q/pODOuhOFgNmqU7aiXV5vDL4NqmC98afWlac3McpWoxanVD/UU/WwsAM72
 SdbXsZdmmcC4MmMpkvqjWkNhSZQUHfylr2IP5xE9Pt+4IJdjWw==
X-Google-Smtp-Source: AGHT+IGfopd3JD6YOi0Wh1sR8DcusFOi/+nLPMQYTmNs1XNv5ViKgxN99u5E/HfATlVONafkxH0p+w==
X-Received: by 2002:a05:6a20:c990:b0:201:8a13:f392 with SMTP id
 adf61e73a8af0-2046a57d7a4mr17643715637.20.1745933237098; 
 Tue, 29 Apr 2025 06:27:17 -0700 (PDT)
Received: from adriano.. ([190.215.87.40]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15faded711sm8892333a12.66.2025.04.29.06.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 06:27:16 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, o451686892@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 1/2] efi_loader: bootbin: do not load an initrd if none is
 provided
Date: Tue, 29 Apr 2025 09:27:55 -0400
Message-ID: <20250429132756.2105309-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250429132756.2105309-1-adriano.cordova@canonical.com>
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
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

Do not try to create an initrd device path nor try to register
an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.

Handle initrd installation in efi_binary_run_dp with
efi_install_initrd, imitating what is done for the fdt.

Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
Reported-by: Weizhao Ouyang <o451686892@gmail.com>
Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
Tested-by: Weizhao Ouyang <o451686892@gmail.com>
---

Changes in v3:
 - Do not clear images->initrd_start in boot/bootm.c, as this is
   done in bootm_start().

Changes in v2:
 - Free initrd_dp

 include/efi_loader.h         |  2 ++
 lib/efi_loader/efi_bootbin.c |  7 +------
 lib/efi_loader/efi_helper.c  | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 144b749278a..84e8cfe320e 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -597,6 +597,8 @@ efi_status_t efi_env_set_load_options(efi_handle_t handle, const char *env_var,
 void *efi_get_configuration_table(const efi_guid_t *guid);
 /* Install device tree */
 efi_status_t efi_install_fdt(void *fdt);
+/* Install initrd */
+efi_status_t efi_install_initrd(void *initrd, size_t initd_sz);
 /* Execute loaded UEFI image */
 efi_status_t do_bootefi_exec(efi_handle_t handle, void *load_options);
 /* Run loaded UEFI image with given fdt */
diff --git a/lib/efi_loader/efi_bootbin.c b/lib/efi_loader/efi_bootbin.c
index d0f7da309ce..6a189c31ffa 100644
--- a/lib/efi_loader/efi_bootbin.c
+++ b/lib/efi_loader/efi_bootbin.c
@@ -220,7 +220,6 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 				      struct efi_device_path *dp_img)
 {
 	efi_status_t ret;
-	struct efi_device_path *dp_initrd;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -234,11 +233,7 @@ static efi_status_t efi_binary_run_dp(void *image, size_t size, void *fdt,
 	if (ret != EFI_SUCCESS)
 		return ret;
 
-	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
-	if (!dp_initrd)
-		return EFI_OUT_OF_RESOURCES;
-
-	ret = efi_initrd_register(dp_initrd);
+	ret = efi_install_initrd(initrd, initd_sz);
 	if (ret != EFI_SUCCESS)
 		return ret;
 
diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
index 3936139ca41..19fb5d03fec 100644
--- a/lib/efi_loader/efi_helper.c
+++ b/lib/efi_loader/efi_helper.c
@@ -622,6 +622,35 @@ efi_status_t efi_install_fdt(void *fdt)
 	return EFI_SUCCESS;
 }
 
+/**
+ * efi_install_initrd() - install initrd
+ *
+ * Install the initrd located at @initrd using the EFI_LOAD_FILE2
+ * protocol.
+ *
+ * @initrd:	address of initrd or NULL if none is provided
+ * @initrd_sz:	size of initrd
+ * Return:	status code
+ */
+efi_status_t efi_install_initrd(void *initrd, size_t initd_sz)
+{
+	efi_status_t ret;
+	struct efi_device_path *dp_initrd;
+
+	if (!initrd)
+		return EFI_SUCCESS;
+
+	dp_initrd = efi_dp_from_mem(EFI_LOADER_DATA, (uintptr_t)initrd, initd_sz);
+	if (!dp_initrd)
+		return EFI_OUT_OF_RESOURCES;
+
+	ret = efi_initrd_register(dp_initrd);
+	if (ret != EFI_SUCCESS)
+		efi_free_pool(dp_initrd);
+
+	return ret;
+}
+
 /**
  * do_bootefi_exec() - execute EFI binary
  *
-- 
2.48.1

