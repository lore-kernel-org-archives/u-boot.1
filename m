Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAAC0D70DED
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:16:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD0589D7A;
	Thu, 28 Nov 2024 20:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gpZfSd6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0CAF8938D; Thu, 28 Nov 2024 20:13:41 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D7689D48
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71d4d0516e6so484166a34.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821217; x=1733426017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZYDkIVKzhWactk/ctPat93Nv3pcKjT/jUjDinUg5E0=;
 b=gpZfSd6+HGX+rOOtbclejQ2hZJ7S3bC/QZ5dXhY+fCC3p4p+k1t6K38A5iJTHnfwJC
 2/8dYe1ZNrwcFMgkhs/HdL0SJy8w/w4csty/rhvYs1qaHJmswKQXw4bq42BKbRJf/iMW
 HqJ6UDL3IvUYhm1PzFq3zFLMlsGrPelmQwLBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821217; x=1733426017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZYDkIVKzhWactk/ctPat93Nv3pcKjT/jUjDinUg5E0=;
 b=oy3kCGGLYjtS2RSJ9/TNEoZ1WlcEmrZ0NENa/XMcd0rodhTgsI4OUvR4NK01uSijA4
 V7Waa4peKoBR8Jx6vRgGjCTzlhJxojCc6im3ta0KZddUEB1XAfu36MpcAVlzd/ucibhB
 gMoFp0FVi5QI3ZwHliyIEhCagLWpfivMmXZvieRRi4TpOHBpR06H1g92tyxfxhRwmYCY
 l1EfAtMbB8fnLxLPaG8O4YvB/OQzBzj6O7FnrOfAhIUbGcMNuKiZkOf+6BY8WWvZAE7M
 1mmIERZGrT3w2s7S5dh4IAPOHiBpMCF+hT4UZFfRRLkrmzM9T+yknkWwniuhvZVzLJVD
 4O5Q==
X-Gm-Message-State: AOJu0Yz/utw5Dl5st4TUhMl2bmtNvcYVNEW89pb3zo9HFrT0Y10b3Wec
 M6WuFYkgTqw5H+Hv0hkZuR91pXg5vpzXajmIJWD5b4FmWX3Agk9GViw/8NN8pcQ4g1A1jyax+/Y
 =
X-Gm-Gg: ASbGncs1R3LH7mA8Cf7Ccryw40NFm4ZTc+vSUpzowIhlM21lexlEQIkm/06JANwqhQB
 I6AV50RsYz5wwtalmPpZNP+XC9N5+bTSlxCKuTAtFucTqiboZgUf/pmdaX/V3QtN4p0x5jDR/rM
 z5rzfSMXhATko5dsOLKSpJSIpd5uyVL3RFzl3YCDgHVjSL43ytH/kMwcHhzca9YxkHrYniwSJ42
 tom+ZFQHk5wfbCs2NwM5eWbnS1xfrLYCw1lFAGZHEgwfQ==
X-Google-Smtp-Source: AGHT+IE7bRHegeo0luUDjei3GixjqbKbI3UIf7q3ppsngWTSWge2OOmAVCuzC0Id+zJWQyEmBPlh3Q==
X-Received: by 2002:a05:6830:4389:b0:71d:4b55:ae20 with SMTP id
 46e09a7af769-71d65c7a27fmr8338546a34.6.1732821217640; 
 Thu, 28 Nov 2024 11:13:37 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:36 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/28] lmb: Reduce mapmem contortions in
 lmb_map_update_notify()
Date: Thu, 28 Nov 2024 12:12:36 -0700
Message-Id: <20241128191244.900006-21-sjg@chromium.org>
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

Now that efi_add_memory_map_pg() uses a address rather than a pointer
cast to an int, we can simplify the code here.

This is fix#1/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/lmb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 14b9b8466ff..588787d2a90 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -10,7 +10,6 @@
 #include <efi_loader.h>
 #include <event.h>
 #include <image.h>
-#include <mapmem.h>
 #include <lmb.h>
 #include <log.h>
 #include <malloc.h>
@@ -448,7 +447,6 @@ static bool lmb_should_notify(enum lmb_flags flags)
 static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 				 enum lmb_flags flags)
 {
-	u64 efi_addr;
 	u64 pages;
 	efi_status_t status;
 
@@ -460,11 +458,10 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 	if (!lmb_should_notify(flags))
 		return 0;
 
-	efi_addr = (uintptr_t)map_sysmem(addr, 0);
-	pages = efi_size_in_pages(size + (efi_addr & EFI_PAGE_MASK));
-	efi_addr &= ~EFI_PAGE_MASK;
+	pages = efi_size_in_pages(size + (addr & EFI_PAGE_MASK));
+	addr &= ~EFI_PAGE_MASK;
 
-	status = efi_add_memory_map_pg(efi_addr, pages,
+	status = efi_add_memory_map_pg(addr, pages,
 				       op == MAP_OP_RESERVE ?
 				       EFI_BOOT_SERVICES_DATA :
 				       EFI_CONVENTIONAL_MEMORY,
@@ -474,7 +471,6 @@ static int lmb_map_update_notify(phys_addr_t addr, phys_size_t size, u8 op,
 			status & ~EFI_ERROR_MASK);
 		return -1;
 	}
-	unmap_sysmem((void *)(uintptr_t)efi_addr);
 
 	return 0;
 }
-- 
2.34.1

