Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88720D59D6C
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 20:46:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E60F89A86;
	Mon, 25 Nov 2024 21:45:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m4vJudUk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9E9E89A96; Mon, 25 Nov 2024 21:45:39 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8506289251
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 21:45:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8418ecda199so65755339f.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732567536; x=1733172336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgnyo9CsADHGmYilUfrDGFAOum3DjE3JX24TwOXEZxk=;
 b=m4vJudUk6TVqvK4CF9zcQXhITaMJmDfbZuMgtgCM6eL7JnZ2QEAiF6LBOIgRWs+h1J
 RhXhAc0tDj14i18zY2mmnMHd/6X9xnL/pCT/7Vj/ehmmKxlKFofj3+h08PIzWJ68zUM/
 H8vTBh1d5mkmX8Raucy3aaTJTottMaiA/Nyow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732567536; x=1733172336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgnyo9CsADHGmYilUfrDGFAOum3DjE3JX24TwOXEZxk=;
 b=HD88Qq9TCfitX1tjSoi6VJl+Hh+Du0AJykOoReiIWx+Y4C3Wr0PwUAcWj3vt2nHfhl
 eJ3Zd9eE8b72eViZ9gyBga6xIvOq5PqLXH3QQyPZSfy3dPOasgc4wqwwTPI/in2PzM4Q
 iwFVU9+BmbQfH/y0vKWMVA8Cpm1Uvp0L65kMTEgWXCsyoKG/2C/BsxXlzVNBIbzSdtZE
 PYIM0TCVId7iYjtjIXwUSs6hVHD6Yid0oK2XuRee7BilRtbaUx9ZWHPcG7GfTMDzBMFn
 cZOqVwDq2XDgWN8ERLhmdHucVECVNR3TjIk9KFasaBezuoRrThi6+iRUZ5NGBk+JsAKv
 Fc0Q==
X-Gm-Message-State: AOJu0YxkDpGzaZwgIodRm/BsV1e9104M3hbjrVjlAK440Rn1oxifFZ1d
 MwDc0YADfm9OKc4Y+gg3MnZhgyXsnkGtRE2gvuzOkm18nMzQJXg49daGgIzkdvnQGY5p2gpA9+Y
 =
X-Gm-Gg: ASbGnctyVh1LOMiJozaKad9EUp3zGPOkJG4vAtBNDHjwR02aq+RUNZJImGKk5ztPbfx
 odXikZhY0jS5iC5J4fbkmB8BGEI+4isTi+xW19UMh4Uww5d23c9c7DKaJdpk9Tx+J9qkTteuIIH
 dkf9pDVPMO84ZMY4Je72hSosrn7U1NprEJT7XdsacgDVSwMIWSYNDGLXyQ+8tpKT1JWBD2YvVjf
 xyL/5J2nYCNktSZzguG3v81pRjWOCSgpB0dtqZjnO5oyDE=
X-Google-Smtp-Source: AGHT+IFOG8Kc8/9BxtO94ylHzgxGXWeyEcFXb+3xeslzkjR1W+bvVuYHcY3Etb1PmyaiTKWcGhIqYA==
X-Received: by 2002:a6b:4e17:0:b0:841:9516:4e2e with SMTP id
 ca18e2360f4ac-841951652a8mr421067039f.11.1732567535779; 
 Mon, 25 Nov 2024 12:45:35 -0800 (PST)
Received: from chromium.org ([50.235.115.130])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-841ac8403a2sm26134639f.9.2024.11.25.12.45.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 12:45:34 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/13] lmb: Reduce mapmem contortions in
 lmb_map_update_notify()
Date: Mon, 25 Nov 2024 13:44:48 -0700
Message-ID: <20241125204456.1525752-10-sjg@chromium.org>
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

Now that the EFI-loader uses addresses, we can simplify the code here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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
2.43.0

