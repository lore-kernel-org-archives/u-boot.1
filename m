Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A48DD70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:17:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9C7489D9C;
	Thu, 28 Nov 2024 20:13:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kjYF1+Rh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7A78938D; Thu, 28 Nov 2024 20:13:56 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3ADE789D74
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71d4994dfbaso1134551a34.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821232; x=1733426032; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Mw1t/I+/muCk46ImzpLc+2GXIP5Z6/o6wtnRIY2esI=;
 b=kjYF1+RhDEQYQcio/m5Thb/D7kxbAYEekWTp/Yjyw398Hjt+rhRIT3eggd1VWA4n0G
 +YN0bGuJ7De7FWAY+nbgbt4TpXvbxduqY3Gyah5Z/ibxOvKff+YRBhFBNQCHnCGkSEaO
 fzh2JqjYLxUghT+QNYDJyIF6w/3EmqhmwYXjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821232; x=1733426032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Mw1t/I+/muCk46ImzpLc+2GXIP5Z6/o6wtnRIY2esI=;
 b=KPd+b0km8Xg9ZKrMov7AS6Tuy6qP6sQmIzYsyh2U8L8/IlorQLbyZlW9+78lFF2P+l
 MK9VnlAChZ5IIUEn37FaMtWiE3gflhkeO69RC90eAK9ox4e7CrhtOX4yTL2nNW2WQGNV
 l5jQgNxjIRSvdPVhBU7ltkb64yizakeT93l6/WwSf4v6hBqQbeCwIp/7eDYAm5SCReao
 lMqAMCTTyt+FBN6bOl/8QkYbxckCyTHV7NA6nwhCPlouriIO6hmXBsezjQMm/0Jj+SEI
 VycIu6KkWC60bkRulll0ePuihHAAuFHGQqKmObfFGnnWANgqFlBP26TjjetDglBQPUqu
 CjTg==
X-Gm-Message-State: AOJu0YyRVuj8/o7K7qTG1y7Hguyy+RaL+oGODeu2KtbrYwbfEdA9OpAY
 /bKArJ48KMN+l9Ibv7sSUR9d3WeBhG+BDTEWaYrcT1/VN36/07a66Bld2hirsy9lthl3T6JI5pw
 =
X-Gm-Gg: ASbGncsLQGUhwUh33dtmw8kgwt/cRXAzhNB5DPw/EgdE5Z4ic0t7pNeic7hh64yyllB
 mnZOK31u5QPDhyODSrD1AiWUoapQ04S8wokcfA9otUNc+fXlwsDp/VD+7ujPjJq7uqp5xAcrW84
 P8u6AylJrPcx38bGXqtkVtG3f/pqqkhsfQABzqWQoXk2/JH25IsxarH2+KovM/va3DWe4dUIe4j
 S+lWoAayqepJIxIF+r0avIJ96vPCal+gy7L6MF7d0YI3g==
X-Google-Smtp-Source: AGHT+IGaaZVh9Ic1MGtXqKq+bTNYdOzKNOZXiLk1/mhaiIFpIFjWBo7isq8phWDMiPOZftX/o5o4UQ==
X-Received: by 2002:a05:6830:1bf2:b0:71d:4081:7bdc with SMTP id
 46e09a7af769-71d70c87fc4mr2506767a34.12.1732821232473; 
 Thu, 28 Nov 2024 11:13:52 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:51 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 27/28] efi_loader: Don't try to add sandbox runtime code
Date: Thu, 28 Nov 2024 12:12:43 -0700
Message-Id: <20241128191244.900006-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128191244.900006-1-sjg@chromium.org>
References: <20241128191244.900006-1-sjg@chromium.org>
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

(no changes since v1)

 lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index a33c025fa20..796fa99f4fb 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -755,16 +755,22 @@ static void add_u_boot_and_runtime(void)
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
2.34.1

