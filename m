Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5C2D6911B
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4894F89885;
	Thu, 28 Nov 2024 16:49:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nsXCnKHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE7C689D8D; Thu, 28 Nov 2024 16:49:05 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A506F893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:49:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ea552bb91aso410621b6e.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808941; x=1733413741; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Mw1t/I+/muCk46ImzpLc+2GXIP5Z6/o6wtnRIY2esI=;
 b=nsXCnKHhkfFvx7HEkptjJLZtzVV9/nAqjaM2V3zANogQ/36ppUqi31ebNc4+l3eFFu
 uNdThogjnSxFIpEglnhpGj6zOMe8MR7+U2YQoydIDEUODoAOBfQVh4qDOLKZ68I6YW79
 a3uPBv0LUuAMdVG82WwUmMydd+O/d8RgIUWI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808941; x=1733413741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Mw1t/I+/muCk46ImzpLc+2GXIP5Z6/o6wtnRIY2esI=;
 b=eS+OdKNqDmdHtNVDpnDMxDqPgj47cxAryUFImJhWIATCDXK0SvmjMiXoqBnsm/5qkS
 vJG33RcE3nLWeyPh9+kLzs2ICnfXQ1SqyV1Rj413PRs4hz+qaOfkPBPEWLo+oFHAWSvl
 +sTJe27rxT+Uzh+XpaRfxWL3rUmEoNP53ne+XWa6zkEAxRVHyCr2qnT0q/BJywomwxJz
 9D9kn/2atC9GulTJZ+Qhv96cRJsnjCqTKJOvtMSVejdTpYGCkqr2C/GYoOCEKzzIyqJo
 aGF/vpyOeO3WTd7e2hW47MdnXfzqhpQFp9obAnRUjHRkEUB7zrb+lsyk33nNuKQLM+YI
 DvWw==
X-Gm-Message-State: AOJu0YwimDa1Bdbl0XC8c3pu0wM/LgpioO6ntLOmAB+c6UrhcwmMNMhS
 eGQhOl7WSR2tQMUDNO6QxNyvwsEvQGZ0vmu23vddVBlmy2LBAEvh67/Azly3fxeglT3bnYXDb+c
 =
X-Gm-Gg: ASbGncss/Q2lpzkIhNV11/gNhn3VCl2Dd64yoTEAb8fgdRNbHAU3WcnPW3wh1INApjZ
 26S8xV5wttK9bHOAngXmoT5do5c5rWE45/ez6cml62Sqv6gNa2wejnqsseY7PY3HSAS2i/gjt1l
 ds54iPMwo0+BLrwobuqfN173gUy6wIjmx3SOTjhTOEecdLG/M+K9vX1IMnRAtxeJd1JmeJ85tB0
 qaTJWzr7PBlzX49VXzxDpD7O+W0jOrMpohr2EAVEizHLw==
X-Google-Smtp-Source: AGHT+IEyn/HtgXpfBrsUUJ1+2KtiEsGBa3bYj7Pj9Uvw50Mx4D5AclJiXiG/M8OogEQuZE4zHgfTZg==
X-Received: by 2002:a05:6808:3994:b0:3e2:9468:49db with SMTP id
 5614622812f47-3ea81577446mr2323085b6e.21.1732808941435; 
 Thu, 28 Nov 2024 07:49:01 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:49:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 27/28] efi_loader: Don't try to add sandbox runtime code
Date: Thu, 28 Nov 2024 08:47:26 -0700
Message-Id: <20241128154727.771871-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241128154727.771871-1-sjg@chromium.org>
References: <20241128154727.771871-1-sjg@chromium.org>
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

