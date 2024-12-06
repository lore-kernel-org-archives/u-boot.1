Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F0CE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:31:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63C1689535;
	Fri,  6 Dec 2024 18:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IMRIZHuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C621894F2; Fri,  6 Dec 2024 18:31:04 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BB189620
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:31:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee8647dbb9so1903055a91.2
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733506260; x=1734111060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qOQBipDm6oVcroQ2BZ0+jkSu5LIEWDy0IMHPFcDIbDw=;
 b=IMRIZHuhqAxRLeCEeVmBHlzKZbgIMV+DjZiyYTwO+hxzpiH+b60wigIZKfMQ1K+3lP
 NFPFP80mRVdXlpoR0XIxsysKlxeqNXxThVsHsuh0Yan02ZEkG4a+FG8S8hEpaakMWptY
 +oN8Ji6z9u8lCWQr5NZYR9404YZ8ICYQ3PDLIx5yr3cmg90CyQfbNV9s6G6czWLYFgH1
 UHsiRNCwSP5hfumpSewuggtDYOG1kDqSW7zIua4gGEYb0sThrr6bM6kZLV44hBYvH3vj
 7pXDfVg0t2nCyJxxbSExrQkUVE2T4FovRdzEUPl7jexq7g87nTbWq2sE1IJK/9THM4FH
 i0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733506260; x=1734111060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qOQBipDm6oVcroQ2BZ0+jkSu5LIEWDy0IMHPFcDIbDw=;
 b=KRBYDjy792pmkwF3+jBPnDhHREzup+N8ROTfJqY30ABsCafF0zWDr1EF6kA2kwOjey
 sIpvfok+1j9Vsrha+M+B8Q4yYNNzvC62FlbcRsW5mIVwymZQhpR5hFCNLenf3Fhi8wb0
 V1/A12mkGWnpKThz7W6EsEY88xYthnijIz54l8yd5NQutA5lUjMSU6dnt75qd7Ao8Hzn
 TDaM8ZqTzJrN/mTC8Qk1c48AF/Yg0re+Gf9dl0CtQEiSNASC6PuNXsCTFBw5Gfamf+yE
 Zpss2NXnwfa8pHKEUeqlRTfVMuxNuJ7lhKKAbdpZuRdZPzJquAUcKPJMvWsz73H8ATX6
 We4w==
X-Gm-Message-State: AOJu0YyHarrW1LCIB4KHOk446pU7kkSLPVc+EQhpPfv2bRob2mJifcmO
 BA+u1lgajEqYQi2Qqk2Rslxg9cj0elyHq8lvq8UyfvK5mCQR2XYVrEgnItgOd8c=
X-Gm-Gg: ASbGnculyi4dlp2+Qe2hPi9ct/HUR4BBxJVqW1TE79v4GzG/LmB4XDpQFoAbQQBIVqf
 TFoqgPPJ9qzwnzlt5gfh5Am90TEZMVHyDagxUGFEp14cbFfasiG9KgWTXpjmRlWr1vEeQjFJWE/
 M8JmmRXl6SfjJmDGMHr89NBMxMnyDtmLQPcSUYaSSKucEvA3ZAK9MXxgzLyOyrNZrqO/RS7uZDG
 +nWppaIpwov++DSpD7O0j1mchjEtFUSNr9OuYNKGKo1LNfLt8LGQ7gM8A==
X-Google-Smtp-Source: AGHT+IGs6bmiynsWjSowK/JLBUDXXyqOPMjsRU29/H6j1V9NSSzrICBKKPbcxFu7YjoXNnbPxQkMAQ==
X-Received: by 2002:a17:90a:d44c:b0:2ee:92bd:3a6 with SMTP id
 98e67ed59e1d1-2ef6ab0d2admr4372180a91.25.1733506260277; 
 Fri, 06 Dec 2024 09:31:00 -0800 (PST)
Received: from adriano.. ([191.119.55.5]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef31715ba8sm4810162a91.13.2024.12.06.09.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:30:59 -0800 (PST)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jerome.forissier@linaro.org,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, trini@konsulko.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
Date: Fri,  6 Dec 2024 14:30:32 -0300
Message-ID: <20241206173033.2403998-2-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241206173033.2403998-1-adriano.cordova@canonical.com>
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
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

The command bootefi calls efi_init_obj_list to do the efi set up
before launching an .efi payload, but efi_init_obj_list is called
only once. There are some initializations which depend on the
environment and should be done each time a payload gets launched and
not only once and can now be done in efi_start_obj_list(). A motivation
for this change is the following order of events:

1. Launch an EFI application (e.g. bootefi hello)
2. Change the ip address
3. Launch another application which uses the pxe protocol

As the EFI pxe protocol was initialized when the handles
for efi net were created in 1., the ip was hardcoded there.

In this example, another possibility would be to make a callback for ip
address changes to go all the way up to efi_net.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 lib/efi_loader/efi_setup.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index aa59bc7779..164586742a 100644
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
2.43.0

