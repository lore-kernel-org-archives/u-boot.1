Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9FCD2C542
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 10:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD1B288C7B;
	Thu, 24 Oct 2024 12:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kAaT15/D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EB5A88DB7; Thu, 24 Oct 2024 12:46:20 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F0F988BB7
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 12:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so118722066b.0
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 03:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729766768; x=1730371568; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=llggovwtdPHjq8gq0kgQDelnBh9ebffUtwHswj1YMDY=;
 b=kAaT15/DejqPTEkU3Yk9bnLlLcXyRxb174qQDleK2ewspaoyFrKVIFssY9FfYh0oRk
 99xyDfDab9GTR618SzOmQENv3jZds0sn6zlsWpbF5L5eDM+PT33Ae2hJYmaxX3jBtuHK
 2ZesgWBvQqOGaNIEDHF3ImgN5How/ryDkSWwo5Wou07rMYRFcsFyzazR9u/TXlLgJ0WG
 3QV3DBA2xKYWEwEye5MaTL7rtUYHSiaYXbzQo6NL83F6+BeB8aylDqHvxYaPi+iXjDYt
 8K0m5cUr9z7EXv6UjDSynvGQG/N71bq/R+rWxg0jrH8g3y5RrM37uAY2ph58pT7Lr5OT
 116A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729766768; x=1730371568;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=llggovwtdPHjq8gq0kgQDelnBh9ebffUtwHswj1YMDY=;
 b=vEoyNWBa4EHJv7jlX7f7AEEzMYQngzo1nL4R6rEcUXD42CFyxMdwXuEded9Ykwv6tK
 wvLe3mW8SoueqpJwV2xtpY0BkINULTXA3/vaIgPeEYS/s2A1cu0CFsBb5foHvHH8bzcA
 SYZps5iRAtReVj6cUh2hxk7q9mLtf6886raspu3l4IqFaybVWQ3SHnfxERih1pvxrM9X
 7tjCemdKBtR+kKQHP6LesxtFuZWARexyzHOLKy2tMETVHtrmhKr8KV5GPtl+n8XvPsdi
 w3s7YE3CkiEIr6HWkuNJnnuWXwQyx/PKn3oY6y7WUAUjjOJnLvccwCW3dRZejMjFTdsP
 Qabg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXlGzcgWFrZrPxP0hly2Yd1rc0VDt6XeEN0AwKMIxZ7E7Adxz5Stx31s5kPJ+UbM6zHhfKs6w=@lists.denx.de
X-Gm-Message-State: AOJu0YwpIcZ60D/2PzGW0DJvTU4ULw3NG6mG3J2wvEXNO3YczircuYVG
 kAveTHXhZhsQJEONdkUjTI0iKuGy+OfdUX1TUfpCIrj4Zr+L6Z89pBV0cvSeySU=
X-Google-Smtp-Source: AGHT+IH+8XN8uecImBsc2j8YZNkZy7CtA0NJ58m76FpQF+vOPIXcEslwdGbWmX3wCkq/hZQX/1DigA==
X-Received: by 2002:a17:907:1c8b:b0:a9a:522a:ba70 with SMTP id
 a640c23a62f3a-a9abf8aefb2mr532319366b.32.1729766767608; 
 Thu, 24 Oct 2024 03:46:07 -0700 (PDT)
Received: from localhost.localdomain (ppp176092143132.access.hol.gr.
 [176.92.143.132]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9159a1a6sm597792766b.204.2024.10.24.03.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 03:46:06 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] lmb: Correctly unmap and free memory on errors
Date: Thu, 24 Oct 2024 13:46:02 +0300
Message-ID: <20241024104603.1340301-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
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

We never free and unmap the memory on errors and we never unmap it when
freeing it. This won't cause any problems on actual hardware but it will
on sandbox

Fixes: commit 22f2c9ed9f53 ("efi: memory: use the lmb API's for allocating and freeing memory")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index 9f3f08769977..84be5532a655 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -451,7 +451,7 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 				enum efi_memory_type memory_type,
 				efi_uintn_t pages, uint64_t *memory)
 {
-	u64 len;
+	u64 efi_addr, len;
 	uint flags;
 	efi_status_t ret;
 	phys_addr_t addr;
@@ -499,14 +499,17 @@ efi_status_t efi_allocate_pages(enum efi_allocate_type type,
 		return EFI_INVALID_PARAMETER;
 	}

-	addr = (u64)(uintptr_t)map_sysmem(addr, 0);
+	efi_addr = (u64)(uintptr_t)map_sysmem(addr, 0);
 	/* Reserve that map in our memory maps */
-	ret = efi_add_memory_map_pg(addr, pages, memory_type, true);
-	if (ret != EFI_SUCCESS)
+	ret = efi_add_memory_map_pg(efi_addr, pages, memory_type, true);
+	if (ret != EFI_SUCCESS) {
 		/* Map would overlap, bail out */
+		lmb_free_flags(addr, (u64)pages << EFI_PAGE_SHIFT, flags);
+		unmap_sysmem((void *)(uintptr_t)efi_addr);
 		return  EFI_OUT_OF_RESOURCES;
+	}

-	*memory = addr;
+	*memory = efi_addr;

 	return EFI_SUCCESS;
 }
@@ -548,6 +551,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	if (ret != EFI_SUCCESS)
 		return EFI_NOT_FOUND;

+	unmap_sysmem((void *)(uintptr_t)memory);
+
 	return ret;
 }

--
2.45.2

