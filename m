Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48957C61D97
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 23:58:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C1E87574;
	Wed, 22 Nov 2023 00:58:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="xJG5X0ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33F1287605; Wed, 22 Nov 2023 00:58:31 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3044F87585
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 00:58:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32fd7fc9f19so4147077f8f.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 15:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1700611108; x=1701215908;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LvcMsqCwMS6GPvn/N56MNNSaGezcXQNasaxe0rDViLU=;
 b=xJG5X0ks/VArth76/KrqVb/IbZcytvJ83sYo6C3OU1Ev10Y/WkQUkRFYUVRNxk0/KE
 K4MQpGG/XDHUc3GxocDBQpuwF+n6StgmXFC1KO/YJTlp73Fqx38ca21m2wEqRw65226v
 s6j9Gh7gm0adIyeX/HXrLzLheAJVmz6GpBmHBePMtDBjPhp2EIljJEMmj38V96rpQ3TF
 69P0ryO7wdsiUBMrvilzEBKydGgQdGjTwrgGH9lhHqC4davmplblrG2eC/J7w6L/VcwK
 SayMPfmCMlLHea1MsmZGhPedgCtDW3KM8RRA54UdBnxM0d5uvttQN6kpCgL9aInoHfGi
 ZREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700611108; x=1701215908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LvcMsqCwMS6GPvn/N56MNNSaGezcXQNasaxe0rDViLU=;
 b=T6WRBWApFsMrnScV2+ATRuiGEBZxnAID0jnpWEggBpgflqK6x7bZmiOlKQyLN3rDbT
 5r+t2OXJBR8FoSZulTr7Xbdl+517MnSTK/aqaWqqUexS8i906C940Q5vC1ar3k7qIeSI
 cRLGcUeGqEruNSBh6jpKOoZ0EU0lhq4Q1yzTSjOftY1VyIlyFSf+weVwGfkWrXA/sAos
 EZUUBHd2dr8IOq0/d+GHYbO5xj4Nuu7LRxEOFo94rhfMFgLkWArl31F3L5wZeLYyWAHF
 db8Zcqz4pdP8xV3HsQ/wBPMO/ZESP2jlVw+DBe0m/Y7Z85G9qebm8vaQhS5w0X7zRUuW
 Uy+w==
X-Gm-Message-State: AOJu0Yy0rhaB0zvkHQ/ga/IDZYL+NgVdnWuuDOAuUWdSjeV/FeIb82CG
 MAayrkLKXDu3HqF73b/jtxXW5FMVubJyY7ZJo+rhsQ==
X-Google-Smtp-Source: AGHT+IGwvDpLYhAZ4Flp2VWact3ubA6nPvexgqDUvPoKwHzZalVooK0TGDkLUi00g9nWQFnndv17AQ==
X-Received: by 2002:adf:f70f:0:b0:331:6c7a:73f with SMTP id
 r15-20020adff70f000000b003316c7a073fmr236456wrp.17.1700611108334; 
 Tue, 21 Nov 2023 15:58:28 -0800 (PST)
Received: from localhost.localdomain (host-212-159-138-247.static.as13285.net.
 [212.159.138.247]) by smtp.gmail.com with ESMTPSA id
 d1-20020a5d5381000000b0032f7f4d008dsm15625566wrv.20.2023.11.21.15.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 15:58:27 -0800 (PST)
From: Shantur Rathore <i@shantur.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Shantur Rathore <i@shantur.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v1 1/3] efi: filestore: don't compile when config disabled
Date: Tue, 21 Nov 2023 23:57:11 +0000
Message-Id: <20231121235713.1530289-2-i@shantur.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231121235713.1530289-1-i@shantur.com>
References: <20231121235713.1530289-1-i@shantur.com>
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

Compile out filestore functions when config isn't enabled.

Signed-off-by: Shantur Rathore <i@shantur.com>
---

 include/efi_variable.h        | 21 ++++++++++++---------
 lib/efi_loader/efi_var_file.c | 13 +++++++------
 lib/efi_loader/efi_variable.c | 10 +++++++++-
 3 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 805e6c5f1e..ca7e19d514 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -136,15 +136,6 @@ struct efi_var_file {
 	struct efi_var_entry var[];
 };
 
-/**
- * efi_var_to_file() - save non-volatile variables as file
- *
- * File ubootefi.var is created on the EFI system partion.
- *
- * Return:	status code
- */
-efi_status_t efi_var_to_file(void);
-
 /**
  * efi_var_collect() - collect variables in buffer
  *
@@ -172,6 +163,16 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
  */
 efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
 
+#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
+/**
+ * efi_var_to_file() - save non-volatile variables as file
+ *
+ * File ubootefi.var is created on the EFI system parition.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_var_to_file(void);
+
 /**
  * efi_var_from_file() - read variables from file
  *
@@ -185,6 +186,8 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe);
  */
 efi_status_t efi_var_from_file(void);
 
+#endif // CONFIG_EFI_VARIABLE_FILE_STORE
+
 /**
  * efi_var_mem_init() - set-up variable list
  *
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 62e071bd83..7ceb7e3cf7 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -117,6 +117,8 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 	return EFI_SUCCESS;
 }
 
+#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
+
 /**
  * efi_var_to_file() - save non-volatile variables as file
  *
@@ -126,7 +128,6 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
  */
 efi_status_t efi_var_to_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	efi_status_t ret;
 	struct efi_var_file *buf;
 	loff_t len;
@@ -150,11 +151,10 @@ error:
 		log_err("Failed to persist EFI variables\n");
 	free(buf);
 	return ret;
-#else
-	return EFI_SUCCESS;
-#endif
 }
 
+#endif // CONFIG_EFI_VARIABLE_FILE_STORE
+
 efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
 {
 	struct efi_var_entry *var, *last_var;
@@ -198,6 +198,7 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
 	return EFI_SUCCESS;
 }
 
+#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 /**
  * efi_var_from_file() - read variables from file
  *
@@ -211,7 +212,6 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
  */
 efi_status_t efi_var_from_file(void)
 {
-#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	struct efi_var_file *buf;
 	loff_t len;
 	efi_status_t ret;
@@ -236,6 +236,7 @@ efi_status_t efi_var_from_file(void)
 		log_err("Invalid EFI variables file\n");
 error:
 	free(buf);
-#endif
 	return EFI_SUCCESS;
 }
+
+#endif // CONFIG_EFI_VARIABLE_FILE_STORE
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6..7fa444451d 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -357,8 +357,11 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	 * Write non-volatile EFI variables to file
 	 * TODO: check if a value change has occured to avoid superfluous writes
 	 */
-	if (attributes & EFI_VARIABLE_NON_VOLATILE)
+	if (attributes & EFI_VARIABLE_NON_VOLATILE) {
+#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 		efi_var_to_file();
+#endif
+	}
 
 	return EFI_SUCCESS;
 }
@@ -466,7 +469,12 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+#ifdef CONFIG_EFI_VARIABLE_FILE_STORE
 	ret = efi_var_from_file();
+#else
+	ret = EFI_SUCCESS;
+#endif
+
 	if (ret != EFI_SUCCESS)
 		return ret;
 	if (IS_ENABLED(CONFIG_EFI_VARIABLES_PRESEED)) {
-- 
2.40.1

