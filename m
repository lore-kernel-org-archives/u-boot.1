Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45FDC4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:15:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C3F388FE4;
	Fri, 26 Apr 2024 16:14:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="CVg0mHxH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D39E2885AE; Fri, 26 Apr 2024 16:14:03 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86D7B885D7
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DC88B424A3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 14:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1714140837;
 bh=jPJOvfltwrkiJrBW0CR3lSEbcz3sVU2bU9+mzQg84So=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=CVg0mHxH/wjXpB01GwkTj3R0NPwfKei2G5MdfmoB0k832BpWKplepsyl5O7AtnZKO
 aUxMWVu+kkNo/E57pcF/x07jwAFZzqsDvike7DPJHWr0AQKW2/YsXT6XwRXmfYEZFY
 s4CCzwrCc61fdVsYxKT0mu5vXGuWwanQ60oUeATUXKq24C9boN69AyPNTQzPYBrC5Z
 UA5U3wqXIfARauQGLbgcd+Nbuo5R/uEn7p0ILSaYuS6Yjl7R1aCjsuVrlqpTI3MKu0
 iD8RGiMI5wMGjZktf9FpFD/FCLBeek5QG8WTDYFqYJfD6NB+h/DO4VZ0H4nYsS1gRb
 eFdLMf8eBVMtg==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34b4bde57a8so1404430f8f.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:13:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714140836; x=1714745636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPJOvfltwrkiJrBW0CR3lSEbcz3sVU2bU9+mzQg84So=;
 b=EZV5K5dldRG1BwSyi9YewUp/J98rSgLn54Y76r2LElk468cb5tSvrzvroILI4pK3AJ
 1E1TxbcBEM6R95lCEhu5R6VQMuPegE9NORYZEtubp7BSbtr5ar90NKz/S7C8wY1QDBQr
 As0CaFGRKDb11Y0jK9q97F3DrbWsTj/Coo1MGtf62zoPXYY2VgF+p8opEXQXYQHfuGRv
 DkBsTwI+gU4GKBYDD9JKkesg8/FuoUnfqoK2dq/hvHb7KiEfBc6E1OaUMyFha4V4pZjk
 7guHSdbfifm4NoT0vsCuz5gjI3Oeh6WgsChwq7SwErZQkXz/Pv3+6/3TnBsRzqKHPanD
 9esw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGbzfVtiT/HMusCG9u0tkLH2t8arAGxkJEJ9U8QTELLVSew9f9euWwKdiWggVBLpmPaPqKGdT6UN+iIKg/1lLnBXyBXA==
X-Gm-Message-State: AOJu0Yxu8EtknlNjdVdQ9yZWUJmZTFmq2Qf93/RD8BjboLph+xVLY/MC
 NjstZZkQGKwkWY880WLI95bC/J437UrWMm+4FSnN9k1lWsrPJV//Afz7EIPiPfpvuoASH4JFOZq
 Gum4ZHP0dXlX5Bqg9G5NPo6EplmsQ68VGM4n5rCmkrfVo25jTeLAdYyxRrg/2qWzUrtk=
X-Received: by 2002:a05:6000:1567:b0:349:c63e:54f9 with SMTP id
 7-20020a056000156700b00349c63e54f9mr2290390wrz.43.1714140836011; 
 Fri, 26 Apr 2024 07:13:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRDCaY30nTY5PjI/CvxA4qcx9iIeIZwFTuMaF8thcegTBAGQov28p56MBKmusHTLcM1V1yjw==
X-Received: by 2002:a05:6000:1567:b0:349:c63e:54f9 with SMTP id
 7-20020a056000156700b00349c63e54f9mr2290373wrz.43.1714140835668; 
 Fri, 26 Apr 2024 07:13:55 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 s20-20020adfa294000000b003455e5d2569sm1460593wra.0.2024.04.26.07.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:13:55 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Shantur Rathore <i@shantur.com>, Bin Meng <bmeng@tinylab.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Raymond Mao <raymond.mao@linaro.org>, Mark Kettenis <kettenis@openbsd.org>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RFC 10/14] efi_loader: load device-tree specified in boot option
Date: Fri, 26 Apr 2024 16:13:17 +0200
Message-ID: <20240426141321.232236-11-heinrich.schuchardt@canonical.com>
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

We allow to specify the triple of binary, initrd, and device-tree in boot
options.

Add the code to actually load the specified device-tree.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_bootmgr.c | 57 +++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index d924810a94b..3d58a928b10 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -1185,6 +1185,55 @@ out:
 	return ret;
 }
 
+/**
+ * load_fdt_from_load_option - load device-tree from load option
+ *
+ * Return:	pointer to loaded device-tree or NULL
+ */
+static void *load_fdt_from_load_option(void)
+{
+	struct efi_device_path *dp = NULL;
+	struct efi_file_handle *f = NULL;
+	efi_uintn_t filesize;
+	void *buffer;
+	efi_status_t ret;
+
+	dp = efi_get_dp_from_boot(&efi_guid_fdt);
+	if (!dp)
+		return NULL;
+
+	/* Open file */
+	f = efi_file_from_path(dp);
+	if (!f) {
+		log_err("Can't find fdt specified in Boot####\n");
+		goto out;
+	}
+
+	/* Get file size */
+	ret = efi_file_size(f, &filesize);
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	buffer = malloc(filesize);
+	if (!buffer) {
+		log_err("Out of memory\n");
+		goto out;
+	}
+	ret = EFI_CALL(f->read(f, &filesize, (void *)buffer));
+	if (ret != EFI_SUCCESS) {
+		log_err("Can't read fdt\n");
+		free(buffer);
+		buffer = NULL;
+	}
+
+out:
+	efi_free_pool(dp);
+	if (f)
+		EFI_CALL(f->close(f));
+
+	return buffer;
+}
+
 /**
  * efi_bootmgr_run() - execute EFI boot manager
  * @fdt:	Flat device tree
@@ -1200,6 +1249,7 @@ efi_status_t efi_bootmgr_run(void *fdt)
 	efi_handle_t handle;
 	void *load_options;
 	efi_status_t ret;
+	void *fdt_lo;
 
 	/* Initialize EFI drivers */
 	ret = efi_init_obj_list();
@@ -1215,9 +1265,14 @@ efi_status_t efi_bootmgr_run(void *fdt)
 		return ret;
 	}
 
+	fdt_lo = load_fdt_from_load_option();
+	if (fdt_lo)
+		fdt = fdt_lo;
+
 	ret = efi_install_fdt(fdt);
+	free(fdt_lo);
 	if (ret != EFI_SUCCESS) {
-		if (EFI_CALL(efi_unload_image(*handle)) == EFI_SUCCESS)
+		if (EFI_CALL(efi_unload_image(handle)) == EFI_SUCCESS)
 			free(load_options);
 		else
 			log_err("Unloading image failed\n");
-- 
2.43.0

