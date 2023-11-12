Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D219C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2986877FA;
	Sun, 12 Nov 2023 01:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJoTTuJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52F82864E8; Sun, 12 Nov 2023 01:10:42 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 899DB871A0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-7a67f447bf0so125778939f.2
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747793; x=1700352593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fD4Earw8F43hwtcv3A40okCPSgm0M+ymyRdUjaCf7F0=;
 b=HJoTTuJYrFhf0EMxKd98/TPWdPbQ9wa+9Pja2zvBnT9+JClt2HgcmMW29JVEAIXtDt
 qb1PH0qSBvqQL1feXOIDuM2nTWLosqnzIqMMgSIgKdK0KtPMbp4A7qRrtqRF4HgmVpPI
 JQqbg6wZCEGnAQIsJpUUp90szU1BpYj3H77ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747793; x=1700352593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fD4Earw8F43hwtcv3A40okCPSgm0M+ymyRdUjaCf7F0=;
 b=LAn7P25iPNbBFvQtC3BtNkDpgPXwdHfgP4xzhtxYxaoxrd5G/I8BiCJjAn+OKXIgn4
 okhcFkbptyv7RYFNBX8zwQU9P6dMFtxsDrcFhnXYfQFrZE/ILJXGFaKLQxJkU5U4OaEt
 RhmjkyZc0DYRMRTbfFNiGvvbO1bz7qSWmYzOcBgw+ektnQwGVdE2qJpJBJ5a30Zvo2Ml
 24/aIdirgECTXz5S6z0TsMCU6+lxnPu/Ku94vvuRuKzwL28+AyWM0tTATJlCk3hUkfc7
 sNtD5NMYBn3vfCljSYmEl9M0QAGkMEBt8I8UeAU8cF2Ppatga7VU6kl9yJTGXRUGxSbh
 7q5Q==
X-Gm-Message-State: AOJu0Yynyh3bIm7csBLLss6tfG51F7r7aj/zLy0jgCWXPY98SImypaXL
 uLsVT4VLYd58Ri+CC9Pdctd8qemYkCuaRmgSZm1w7g==
X-Google-Smtp-Source: AGHT+IHTiN/06Y8BfRJgd+lGHQ/LZPwtoMJ5qrIFHWb+H4smNAQemmUzeaDp69Nnw7PR1QXQiDAGSQ==
X-Received: by 2002:a05:6e02:1906:b0:359:64af:c6e1 with SMTP id
 w6-20020a056e02190600b0035964afc6e1mr5160131ilu.9.1699747793140; 
 Sat, 11 Nov 2023 16:09:53 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:52 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH 25/29] bootm: efi: Drop special call to bootm_find_other()
Date: Sat, 11 Nov 2023 17:09:10 -0700
Message-ID: <20231112000923.73568-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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

The normal bootm flow calls bootm_find_other() can call the
BOOTM_STATE_FINDOTHER state as part of its processing. Fix the
condition there so that this hack can be removed.

-off-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootm.c    | 10 +++++-----
 boot/bootm_os.c |  6 ------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 41cb52fb72c7..342d6211a097 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -579,11 +579,11 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
 static int bootm_find_other(struct cmd_tbl *cmdtp, int flag, int argc,
 			    char *const argv[])
 {
-	if (((images.os.type == IH_TYPE_KERNEL) ||
-	     (images.os.type == IH_TYPE_KERNEL_NOLOAD) ||
-	     (images.os.type == IH_TYPE_MULTI)) &&
-	    (images.os.os == IH_OS_LINUX ||
-		 images.os.os == IH_OS_VXWORKS))
+	if ((images.os.type == IH_TYPE_KERNEL ||
+	     images.os.type == IH_TYPE_KERNEL_NOLOAD ||
+	     images.os.type == IH_TYPE_MULTI) &&
+	    (images.os.os == IH_OS_LINUX || images.os.os == IH_OS_VXWORKS ||
+	     images.os.os == IH_OS_EFI))
 		return bootm_find_images(flag, argc, argv, 0, 0);
 
 	return 0;
diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 9c035b5be886..9af084a9f823 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -493,18 +493,12 @@ static int do_bootm_tee(int flag, int argc, char *const argv[],
 static int do_bootm_efi(int flag, int argc, char *const argv[],
 			struct bootm_headers *images)
 {
-	int ret;
 	efi_status_t efi_ret;
 	void *image_buf;
 
 	if (flag != BOOTM_STATE_OS_GO)
 		return 0;
 
-	/* Locate FDT, if provided */
-	ret = bootm_find_images(flag, argc, argv, 0, 0);
-	if (ret)
-		return ret;
-
 	/* Initialize EFI drivers */
 	efi_ret = efi_init_obj_list();
 	if (efi_ret != EFI_SUCCESS) {
-- 
2.42.0.869.gea05f2083d-goog

