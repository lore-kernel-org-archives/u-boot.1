Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C7CC197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:16:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2C18750C;
	Thu, 16 Nov 2023 05:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kA4GxCtr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD2DE874D6; Thu, 16 Nov 2023 05:11:46 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B69C7874EA
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3594149e3a1so1430805ab.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107903; x=1700712703; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2ZXOH5KxcfIoNAS3GSC31PJq5q5BSw9oHIyhQxocf0=;
 b=kA4GxCtrOVVQmJdkfTzq/yUiXCM9FNWOMrjWhfIxDAu34OIdJ/TFATtL2CG3g05s7N
 PoKh+06x014MOQKZK+YmSqnLjqe4au9X5xbH0dUzOqttjaDDwZCoxvCMYqrBl+HYU0mu
 rH0rcGbeUiAW4RiKwN32IVhu4gKfZSjKKOtuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107903; x=1700712703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C2ZXOH5KxcfIoNAS3GSC31PJq5q5BSw9oHIyhQxocf0=;
 b=VV1YYv9fsbxeiyIRPsjXn5PdGre5T1UEZyhZe0ZI3owZYH1FNdartsHnBs0/T0/vg0
 K7nVDLkJsrAjo1GbR1hF8iXyCM+GrJmujhq5aMLMHoo1jC6knUJRHqCQVNEt6slwmheZ
 WY8dc2XcTs4fyqX82whpXPfDsfMSZxrTRu3UBAbXy4Hg67AgiSibuFkYWRfuqoMul8Zb
 44b6NQq3iohzg1Jqpr3JljOBPnhKSedavVXXpuF8cc8TyXNoDdKNe3JGaLZ3mtReZVt6
 wPegG38/XR5zWV0hegRjsPNPrhwX2fsarCqHTPfb4GMx11met+mJz0DJGcrFl231ModO
 bZeQ==
X-Gm-Message-State: AOJu0YzsFwe+GkXgTFbBdyUZu/U4C4OzPO+wq3yPQ08j46YdKzhvd9KV
 4ZMa02lWiD4rDQ+S0yDoaxrFVZ/Xb7cn3QgcokAdgQ==
X-Google-Smtp-Source: AGHT+IFUyhOVYRxoXyB1xpL0oJprTHjsfWCuxlU4MJEhg2POD/gvEu/hzMqlM7uhA4dK6lNALxdPUA==
X-Received: by 2002:a05:6e02:1c0b:b0:357:3d32:bf76 with SMTP id
 l11-20020a056e021c0b00b003573d32bf76mr19872788ilh.1.1700107903240; 
 Wed, 15 Nov 2023 20:11:43 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v2 27/32] bootm: efi: Drop special call to bootm_find_other()
Date: Wed, 15 Nov 2023 21:10:27 -0700
Message-ID: <20231116041043.362055-28-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootm.c    | 10 +++++-----
 boot/bootm_os.c |  6 ------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index db1466cecf2d..dc64de952c23 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -580,11 +580,11 @@ int bootm_find_images(int flag, int argc, char *const argv[], ulong start,
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
2.43.0.rc0.421.g78406f8d94-goog

