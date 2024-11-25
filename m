Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD8CD59D6C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:47:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD7189A76;
	Mon, 25 Nov 2024 21:45:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jwttvhd6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 682C489A98; Mon, 25 Nov 2024 21:45:50 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3086589251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84198253284so47206139f.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567546; x=1733172346; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aI1DqqzqAhkQ+ehoDpnwojU8Ezx4//zmjNnk7zv7Ttk=;
 b=Jwttvhd69du7kLMIx1LW9bbZSH8Xg1VQr/SvyMPBxvY6ABxVeLD2FFjk6VHs70gCwX
 IfCX3M9BmTumMo/OVBY9T979gZ/9DG84i4SQ3JhRy67sjKAiVqSIyjAw/LorZN1WkDCK
 5a+zHDeK+J02PrC1xzO7l3z/yqcpAz0rohKbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567546; x=1733172346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aI1DqqzqAhkQ+ehoDpnwojU8Ezx4//zmjNnk7zv7Ttk=;
 b=NbiEnmectYPDmSEGgwmIstaumKqkOL+kGfjGBEvRJCVG6RW/2m2XDp/uipGIqEiivX
 /VxT2jT+IVon/ZLjggmbmTtWyyX9YwR1xekZVS/HS/LNXPCrEgy6Cqq+PDMpS/+CPfJ2
 albxfggwbuouqIGzzwxSAOoRXJUUwQ/S4wQ0frg4zzfK52CQ8k3irDY1P5+uUwgwtr2I
 kqLOo0AbDC3ZnypPF6Tgxo72MqMTlZZDWXNRaOgUHlALqwh8+V2NT6yAMXgpVn1w+s2H
 EOpE5+Q9Iq/cO4/YfUJmA9zuXS5jIFimXQIwxfqBWhjcTfvlxMeK+Qt7E+osrpo2t31K
 318g==
X-Gm-Message-State: AOJu0YyP2QMfUkjKyOJVUWmoPJX8F3mfih9mGcnlANgHuUnhQlk1HkqA
 h6/6NNPYrNmbQsRbCVyDLbIsRkmrzK0PAJJ77AqII1h/OYsFozDsGp7BD8K+6liElhOXX17tHYo
 =
X-Gm-Gg: ASbGncuhVubv0GVYTwvTxwo+wPKVj4PXvXpTbB7r1fx7KBTOoK8PVP4mobpMUzXve0u
 jrlH1Yr80QiRD+Lrr0ZLZ0MmnXpwOWbr8BSdh1sCDwCR66PAqOozQYBl0e5rN+WjIPPJDqleeAi
 8fDS2RHjZluFFs78jfIgmngSDmDOrD68WFF8al/fyztRKHZ5LXmD/goJ6EwlcYHWVjG0ht53wet
 1VzsrICJz62TgrPY+2KYi9AEW8Sh4s98+tQ75Cige0uJ9k=
X-Google-Smtp-Source: AGHT+IFmseCzuSpOTfyCQjmfz/M+OUKtW0WBZfh/T/hxVDYFAjPLTom1IixU1kr7UguYC7otSvaJMA==
X-Received: by 2002:a05:6602:1693:b0:83a:acba:887b with SMTP id
 ca18e2360f4ac-83ecdd22d41mr1428414239f.10.1732567546412; 
 Mon, 25 Nov 2024 12:45:46 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 13/13] efi_loader: Don't try to add sandbox runtime code
Date: Mon, 25 Nov 2024 13:44:52 -0700
Message-ID: <20241125204456.1525752-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125204456.1525752-1-sjg@chromium.org>
References: <20241125204456.1525752-1-sjg@chromium.org>
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

This cannot work since the code is not present in the emulated memory.
In any case, sandbox cannot make use of the runtime code.

For now, just drop it from sandbox. We can always adjust things to copy
it into memory, if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 32c5143e205..30bc9803829 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -758,16 +758,22 @@ static void add_u_boot_and_runtime(void)
 	runtime_mask = SZ_64K - 1;
 #endif
 
-	/*
-	 * Add Runtime Services. We mark surrounding boottime code as runtime as
-	 * well to fulfill the runtime alignment constraints but avoid padding.
-	 */
-	runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
-	runtime_end = (uintptr_t)__efi_runtime_stop;
-	runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
-	runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
-	efi_add_memory_map_pg(runtime_start, runtime_pages,
-			      EFI_RUNTIME_SERVICES_CODE, false);
+	if (!IS_ENABLED(CONFIG_SANDBOX)) {
+		/*
+		 * Add Runtime Services. We mark surrounding boottime code as
+		 * runtime as well to fulfill the runtime alignment constraints
+		 * but avoid padding.
+		 *
+		 * This is not enabled for sandbox, since we cannot map the
+		 * sandbox code into emulated SDRAM
+		 */
+		runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
+		runtime_end = (uintptr_t)__efi_runtime_stop;
+		runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
+		runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
+		efi_add_memory_map_pg(runtime_start, runtime_pages,
+				      EFI_RUNTIME_SERVICES_CODE, false);
+	}
 }
 
 int efi_memory_init(void)
-- 
2.43.0

