Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1C0C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 12:06:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D96281703;
	Mon, 10 Mar 2025 13:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fgOjfITr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6798814A4; Mon, 10 Mar 2025 13:06:11 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB3D181417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 13:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22423adf751so55556885ad.2
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741608365; x=1742213165; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kE5AAvBpr42KcArcvaGjq0Lp5nYWyY2ew4PfgolOQ14=;
 b=fgOjfITrgIBgkIyt168FtQD3A9JA8C99g78yXSCYjlsLtZZUZPqZe31gdISJXR91BP
 sgKyiIh0ItdcjhOezwNtzd30qesv3SJQ6V7CUMr081ov2TZR4mDu2WVZ6jfYjuelCmn1
 AbUgd3TK3YAX7hr39lZAbPLatN00ZEm3ckwiPcfydKc8/234H3+1owkgKk9MuzxZme9V
 4SECbnxtSpqSLalHMoVpaZfmKvLjcAP1oNcj9CguFyeGOzDOuL/HUAMBfM6x3JsMdfpD
 0SxEWczvvezo9fcq2UGhbQqaoDew5XsYo+OLm3J/fKPsB1cJb604984I+RmKOsJWmK1b
 y/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741608365; x=1742213165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kE5AAvBpr42KcArcvaGjq0Lp5nYWyY2ew4PfgolOQ14=;
 b=CKZ9py7osbUz5CA+ESCvho5TiY8IOAwUkv527MxRHMGO/5OGtzVsI+fr7opHWon5XN
 gwQABOGgqLWjwgWwSmx0M2upSbald+cvBCQdbOOJRkN/oi2Uix8o/fZcFPK9GmeQVd4H
 /BxwkIS01hNNwzjLlc5BEiILTKVHpDXAmQ2Jcf3/TFrCtG7WcXNNyawuzd8cbSz6T2qb
 DVWeJEcS/hiFIJlkt4rA2n7R+wCgo4AXKvgkNUAxWs4VHfAto7HnmIgCVyWSRIfiB54r
 RShCVDi2HwnVMuzmK8aRupClU2x94G3dZtlAD0u6UY7cjMC0acS8m3enPidFQAcBjRsd
 o9KQ==
X-Gm-Message-State: AOJu0Yxy84kMg9wUV7n039cjNRtd65aRYBBbTLzJU+ycFZwnFIelu6ZL
 +RQVSzW7Ld1CtCcRBNzv95igEKpP58B+CP/MrQcUNNDSnzlvelKTMuFSl2Aqeio=
X-Gm-Gg: ASbGncv0MSUgbzO5R4MXe7qqA8BZiEFxGnzdDQV7HF0eRhXxfwYkHbgF0xgE9ioxugO
 TOUpeLeZl9Las/2mC6rtXi+J/VPoJF4YtaBf8d8ina1lWq4qdZS9GUGMHdyUzpfwXQi5m3s3Mq2
 IoCMNH0tufZ5BOXE8QfFlR6jGKqm5QNFEMBTP4d24rZe42TbVirx8hoLouibIjlRpCHwIhBte9t
 D9ZcFstE7khpSy9LyIhsprmol3vQz4i9L2EK7oJYTu1ck6iTItNwEKxZkB7E3p5XsflQiG1dcTk
 SuHo/bSGW3yJ8AAcjcOfIn0XwTKgPXuQpkmyrnQDjRf/x2IvVPYqfiw=
X-Google-Smtp-Source: AGHT+IFDR7zP0ZAUlg1aAYMzpLnWYcQ+1ssb2gUCPuM5MEmAYK+tYSCg8QNI2ihfO/s4xX5eez93fw==
X-Received: by 2002:a05:6a00:2351:b0:736:65c9:9187 with SMTP id
 d2e1a72fcca58-736aa9db600mr17739730b3a.9.1741608365363; 
 Mon, 10 Mar 2025 05:06:05 -0700 (PDT)
Received: from adriano.. ([190.215.89.187]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736a8b61f76sm6968899b3a.103.2025.03.10.05.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 05:06:04 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v3 3/8] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
Date: Mon, 10 Mar 2025 09:06:02 -0300
Message-ID: <20250310120607.186999-3-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310120607.186999-1-adriano.cordova@canonical.com>
References: <20250310120607.186999-1-adriano.cordova@canonical.com>
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

The coomand bootefi calls efi_init_obj_list to do the efi set up
before launching an .efi payload, but efi_init_obj_list is called
only once. There are some initializations which depend on the
environment and should be done each time a payload gets launched and
not only once. A motivation for this changes is the following order
of events:

1. Launch an EFI application (e.g. bootefi hello)
2. Change the ip address
3. Launch another application which uses the pxe protocol

As the EFI pxe protocol was initialized when the handles
for efi net were created in 1., the ip was hardcoded there.

In this example, another possibility would be to make a callback for ip
address changes to go all the way up to efi_net.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

(no changes since v1)

 lib/efi_loader/efi_setup.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779d..164586742ae 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <asm-generic/unaligned.h>
 
+#define OBJ_LIST_INITIALIZED 0
 #define OBJ_LIST_NOT_INITIALIZED 1
 
 efi_status_t efi_obj_list_initialized = OBJ_LIST_NOT_INITIALIZED;
@@ -208,6 +209,18 @@ out:
 	return -1;
 }
 
+/**
+ * efi_start_obj_list() - Start EFI object list
+ *
+ * Return:	status code
+ */
+static efi_status_t efi_start_obj_list(void)
+{
+	efi_status_t ret = EFI_SUCCESS;
+
+	return ret;
+}
+
 /**
  * efi_init_obj_list() - Initialize and populate EFI object list
  *
@@ -217,7 +230,9 @@ efi_status_t efi_init_obj_list(void)
 {
 	efi_status_t ret = EFI_SUCCESS;
 
-	/* Initialize once only */
+	/* Initialize only once, but start every time if correctly initialized*/
+	if (efi_obj_list_initialized == OBJ_LIST_INITIALIZED)
+		return efi_start_obj_list();
 	if (efi_obj_list_initialized != OBJ_LIST_NOT_INITIALIZED)
 		return efi_obj_list_initialized;
 
@@ -349,6 +364,10 @@ efi_status_t efi_init_obj_list(void)
 	if (IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK) &&
 	    !IS_ENABLED(CONFIG_EFI_CAPSULE_ON_DISK_EARLY))
 		ret = efi_launch_capsules();
+	if (ret != EFI_SUCCESS)
+		goto out;
+
+	ret = efi_start_obj_list();
 out:
 	efi_obj_list_initialized = ret;
 	return ret;
-- 
2.48.1

