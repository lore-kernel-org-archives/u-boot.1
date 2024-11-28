Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E2D69114
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:51:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFD189D87;
	Thu, 28 Nov 2024 16:48:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OvuFfMno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B04689D6B; Thu, 28 Nov 2024 16:48:54 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC5E893D7
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea3bf79a03so460945b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808930; x=1733413730; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8kKT9HoY2+7KH63qIOQXaz9mBZ0nLzOo2Q/+WA0kqS0=;
 b=OvuFfMnomgyPuol9MeBskS808eUEI8pUspp6o4YVgWME4xHU0ATAZVS0u5jzttlJKj
 /sWmKa4cUH/YVqpYt0a+9RfDRUBWqciegciV7rz+7Dd0z89pzBWOYcbKcMAHNN46JO/F
 kkNIGheHdh4R+lxmVGv9oktJXnXkVZsggU+I8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808930; x=1733413730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kKT9HoY2+7KH63qIOQXaz9mBZ0nLzOo2Q/+WA0kqS0=;
 b=GJl9vSh1JPE+9pbFakAa08KQlNI6w/W3egrX99RfkoVsG5ZrMvwzQdBigM7Jj7F/PY
 XcN1Si9PQBAczKfzF8fvbyYSY1tqdr/GIG8apI37CgvKCgi1CbpWUgG3jlMYvb+X1Oh6
 29wVXi1IEQAbIfpg9a2Ba8u4U6DNS67jJU9LdNSQvnmCu9c9MGpohq8Q+1gNeTK+Izgj
 psCsOCdb0Sz31Xg1sC0+N3PQgABI5rANJnaTuq93BaQO1KDYm7o5a6JBAAlD+Rk6Wg1X
 QB4yWtCmszbqCuE7klPAEKcP/r5acZOgFEUFrG/lfY5qQRrnzLlpULpxZKIZhoVXF1+l
 QpAw==
X-Gm-Message-State: AOJu0YyYt9rsKCftDivRxXszzgk5EWl1hV9rdWFESP0d9+T0RIo98jpi
 PhU2VAsoUf0N4FgMxxrWJhY/ev7KaMVwWFUEOkH5G2z6m1HjoKIa11dUcDGO3ULYQzS8NZ/2de0
 =
X-Gm-Gg: ASbGncsUkKOLG6G3jxfkfPwB+uxh9Z+mzCW0/TkLhwyVsUCwFC7yykKt3V9sqywxTej
 eXwT/kKyRyfTeDWreDRRM15fapVYjm0vRXRWRFbCgQmpH/AkyJyOH91fOPDi11dmCv52Nus/726
 068FLO7OTTpObdw9awIaS5eRZxcgZ3SUvfdfIf2heO5Da5+ZSZNk61PGBKF/cIuhDU9ChLk0Uxh
 Mog+hAFlGXcfIPIc/8jzzJ12Ia5RuMsfVUzjFkgNOhSwQ==
X-Google-Smtp-Source: AGHT+IHUVIJ6NV0WYrHMR+HCOI/BXVEJYQi8IaaaaiIGS/dAoIFB5z2qqtRh81vfO37kUAhPIhIKZA==
X-Received: by 2002:a05:6808:17a8:b0:3e6:63b5:f248 with SMTP id
 5614622812f47-3ea6db60e41mr8645217b6e.7.1732808930235; 
 Thu, 28 Nov 2024 07:48:50 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 23/28] efi_loader: Update efi_add_runtime_mmio() to pass an
 address
Date: Thu, 28 Nov 2024 08:47:22 -0700
Message-Id: <20241128154727.771871-24-sjg@chromium.org>
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

Now that efi_add_memory_map() takes an address rather than a pointer,
do the mapping in this function.

This is fix#4/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_runtime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 9d3b940afbd..37ed5963e2b 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -13,6 +13,7 @@
 #include <efi_variable.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <rtc.h>
 #include <asm/global_data.h>
 #include <u-boot/crc.h>
@@ -930,7 +931,7 @@ out:
 efi_status_t efi_add_runtime_mmio(void **mmio_ptr, u64 len)
 {
 	struct efi_runtime_mmio_list *newmmio;
-	uint64_t addr = *(uintptr_t *)mmio_ptr;
+	u64 addr = map_to_sysmem(*mmio_ptr);
 	efi_status_t ret;
 
 	ret = efi_add_memory_map(addr, len, EFI_MMAP_IO);
-- 
2.34.1

