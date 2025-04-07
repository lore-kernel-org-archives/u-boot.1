Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C81CC36002
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 01:36:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0585782C87;
	Mon,  7 Apr 2025 03:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l2oabdSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23F6682BCD; Mon,  7 Apr 2025 03:36:04 +0200 (CEST)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA93882CB1
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 03:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224171d6826so50345935ad.3
 for <u-boot@lists.denx.de>; Sun, 06 Apr 2025 18:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743989757; x=1744594557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNKGvekmzeH9w6cnX3aSSu0nSGpKbLSs8yjgzUL5ZxE=;
 b=l2oabdScR84+cBqO1c0NZGHu5xaQLl9ODxJCbCnr/PpGolmP5FrMnSyF8slqRKNbrE
 R0EXtZ2dL9BAQlbNhJ3d3rFEAKWmTKmHIOKHhOpOyrjTXuogXF0VbzH2taaz7EjaqX9A
 K6FJzQXEUIE+8S1N6sqBdl7y+yekRpkJMVASw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743989757; x=1744594557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNKGvekmzeH9w6cnX3aSSu0nSGpKbLSs8yjgzUL5ZxE=;
 b=AtsiAueFGumYSQxCW28uINCP54rBkQ37YWte/quWZH3lnEZ3rUyGBEBg1o5b4dvD3C
 jLRt/FE/wtFdV420moLsfLQ6HqHbn03WBIk/R52UME9I4Y50J0x+JMfX4wTm1/Kw+T80
 thhtqGNl69tPf2Dpu0VA9PPYhdU/hM5oSChbnAqmqhd3aohbcIQz02LY6a6N94G1OqIs
 eIBZmX6gT9AH/zrxiI2m8qEVGYYCwC9d079CW5+HXfFQGtT9giP+jPRmnFY9F543C+OP
 nDF5SLNe2IPxWZSmFR1lamubvjqR6DPM+w8wWyxOHz/fhvwoGtKRO9YiJ6Kqrf0IrUVe
 3l9w==
X-Gm-Message-State: AOJu0Yx6ifKGW4x2iHjgwPuR7mE0bvnL5EyQn3VqgJpjU64vdlOjthDi
 UIArXNfWLNFooQglVKuD9230cEeBY+N9OU4QrivLxUOOch+5EkUvsuTtuHRjdKzEC6JZj7SKBEM
 JeA==
X-Gm-Gg: ASbGncvcuVE1OMnKs2BL0v3i9Sr4I7UQUc+V5In3slJkp7BhPhQm/6k7kFkbTbCSjYF
 1zkSw9Qwk/EGdTS7H6+M+g+E5akbozj0tS38Z9HdBKpz9QgG0jPnf8El61gbljbucJFj4ktgbp0
 pcJwV2MdWYPxcI1s3Yu/cZOQdDUCphtKQG7W1cCXtbmcqq/u4iTs1IR82hAb4WSX/W0x5o2zNo/
 EHm/rOuaigXfWEVIyD75UvCh8W2d53HXQo3wqko+pWsbfAh1TSty8HkhGDahjG4tbh4zJ1vvBj8
 PFO0gJF+lWyz8ZBrhq1cO87ywbH06amMg93PLKX4iXm4B+eP
X-Google-Smtp-Source: AGHT+IE9WfUWf4kUWKbw70bvVzVLjab0KHTcb0Sb60PuGdJ/klHc3rK/29KtKCVnzAoCfHtviLR66g==
X-Received: by 2002:a17:903:8c7:b0:21f:71b4:d2aa with SMTP id
 d9443c01a7336-22a8a042b20mr158856755ad.5.1743989757417; 
 Sun, 06 Apr 2025 18:35:57 -0700 (PDT)
Received: from chromium.org ([161.29.84.47]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785adad8sm69535765ad.35.2025.04.06.18.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Apr 2025 18:35:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 neil.armstrong@linaro.org, Jonas Karlman <jonas@kwiboo.se>,
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Christian=20Kohlsch=C3=BCtter?= <christian@kohlschutter.com>,
 Janne Grunau <j@jannau.net>
Subject: [PATCH v2 3/4] efi_loader: Move device-removal later in
 exit-boot-services
Date: Mon,  7 Apr 2025 13:35:09 +1200
Message-ID: <20250407013513.638110-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407013513.638110-1-sjg@chromium.org>
References: <20250407013513.638110-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This removal should be the last thing done, so that U-Boot does no more
memory allocations afterwards, thus avoiding potentially allocating
memory which has been freed by a device that fails to de-activate its
DMA.

Of course, devices should be marked with DM_FLAG_ACTIVE_DMA or
DM_FLAG_OS_PREPARE but this change is good practice, in any case.

It also matches the code in announce_and_cleanup(), which we should at
some point unify with EFI_LOADER

So move the code and add a comment.

Note that the TCG2 log is updated after this call, but I cannot see any
allocations there.

Reported-by: Christian Kohlschütter <christian@kohlschutter.com>
Link: https://lore.kernel.org/u-boot/C101B675-EEE6-44CB-8A44-83F72182FBD6@kohlschutter.com/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_boottime.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index ffe43accd1e..e525662f82f 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2250,14 +2250,6 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 			list_del(&evt->link);
 	}
 
-	if (!efi_st_keep_devices) {
-		bootm_disable_interrupts();
-		if (IS_ENABLED(CONFIG_USB_DEVICE))
-			udc_disconnect();
-		board_quiesce_devices();
-		dm_remove_devices_active();
-	}
-
 	/* Patch out unsupported runtime function */
 	efi_runtime_detach();
 
@@ -2279,6 +2271,19 @@ static efi_status_t EFIAPI efi_exit_boot_services(efi_handle_t image_handle,
 	/* Give the payload some time to boot */
 	efi_set_watchdog(0);
 	schedule();
+
+	/*
+	 * this should be the last thing done, to avoid memory allocations
+	 * between removing devices and the OS taking over
+	 */
+	if (!efi_st_keep_devices) {
+		bootm_disable_interrupts();
+		if (IS_ENABLED(CONFIG_USB_DEVICE))
+			udc_disconnect();
+		board_quiesce_devices();
+		dm_remove_devices_active();
+	}
+
 out:
 	if (IS_ENABLED(CONFIG_EFI_TCG2_PROTOCOL)) {
 		if (ret != EFI_SUCCESS)
-- 
2.43.0

