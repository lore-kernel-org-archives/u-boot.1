Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFABE66894
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 09:00:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3817688AAC;
	Sun, 24 Nov 2024 10:00:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q3z8GiaB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1775A89535; Sun, 24 Nov 2024 10:00:12 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E728E889EF
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 10:00:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so5199733a12.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 01:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732438809; x=1733043609; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c0x+S8fN5tg3OjvzXTcLAJz1VQ5U1XX27OfsMOODU78=;
 b=q3z8GiaB/KbogBjtB3YsvAnp3FT/+qZ6/fwkXXnAx7OY/ieZbYbeeir2VOim3n1xPi
 u6MoTCXm5iailtsAObwOXa/Ym20a3geO+PC0dQFEGCc8i0X6/bnBI4iLDDYQ8vfYNKii
 oXKGytTG7fmsCkQ5jAXwbOXFbdS0/ZKrbLHd7aWkDuc4lwIGfAAtJ7Q5ynR8oSlekcA3
 qBb9fHmuChNT+Yu87NnhGvWZX1501AoBqRIAS4lCAvD39UriZ9eS2vixHwYR653wt1PP
 H2Lio12A7tZ4AWk2p3T/dSZcqG8YZQkkV8O2WIrDcbisdhQv2ScgZxZEa6E9WtpNt0NC
 32tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732438809; x=1733043609;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c0x+S8fN5tg3OjvzXTcLAJz1VQ5U1XX27OfsMOODU78=;
 b=pTuBNRXVjNLdJ6jA7PYXvapF0oPHdteXx8pETe3dWJNSXJk/AO2y+I9SfXsJQeK9Nn
 tYGyRGYbjKVxODF/RpZp0FchkD9m6pnY8Fi1m/E7CPvmu+shVgbdga+48PgLCgIDmMio
 p9+hoW4hkjvQd5S9WS4xK9WX1QWUC9y3UA+ep93loPa0nggq97Q2F+2pRU0HtQtBVa4q
 08FezWDLHf2aIurMw9C34W+MdQHnx7Txt8H2+Ky3GCqCBhqBrTmYrOYP3Iok+7sgskEi
 n4oKayQ3ggmqTR31KBm4kuDvN6opoNFlFLVQEe00uccJoLRl7/tJuRzKTqS0lkPx3N9e
 bpPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjvKlR+p9u1IJ/pO7H6n9PUr4ZW6CY5YbHmLrLG96oxEXMH9SrcfFNLqUUOkd7aOi1QZkl8kg=@lists.denx.de
X-Gm-Message-State: AOJu0YwciBhirunRYoPoecnW3gnt07hacEyxRauY/OFgW4T3fHoMqjrM
 7WBU2KC2wPADZEkh7GpLY9TmijctoAe0vBuoSi2KhJc4YLs/u+1LFHIOfi1Pc64=
X-Gm-Gg: ASbGnct0A1VK9nfGVRYJSZlrHX8BfoIUG21RpZxWtQSlvBP3afSDAkVlTg7mayB9CKx
 plC3/4NN//oGRJcjBT68x72SXvy9XRC2RAmvURiJ0FUHAnLfWSYZ6NxhGc1FRKN+FmA0Dm61rgL
 ETlTSxyNAbqwJw6XGun2PrbHbiAj2Bi/dSJDU3EsKPj70cFORmzXYTT9+sMVqeZlqs+juK/ee4a
 QJvrceBeqbBZt47QRd8587TpNyGNCp/zWHJgDcSPU+TdQBOPUDuH70v/euSI/yY96KfRQdPU39O
 Hr3AjLE4TO3/tyq++2pOynTJiw==
X-Google-Smtp-Source: AGHT+IH6aZXM7hjq5Wh+/SYE//sbTczOqIMuZudUo6uaqMuYqLJeJco/sYK9iT3+gseLipXFvLPYCQ==
X-Received: by 2002:a05:6402:27cd:b0:5d0:975:b1c0 with SMTP id
 4fb4d7f45d1cf-5d00975b228mr11826912a12.11.1732438809304; 
 Sun, 24 Nov 2024 01:00:09 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa54423e8e9sm74790566b.77.2024.11.24.01.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 01:00:08 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH v2] lmb: Correctly unmap and free memory on errors
Date: Sun, 24 Nov 2024 11:00:03 +0200
Message-ID: <20241124090003.495315-1-ilias.apalodimas@linaro.org>
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
freeing it. The latter won't cause any problems even on sandbox, but for
consistency always use unmap_sysmem()

Fixes: commit 22f2c9ed9f53 ("efi: memory: use the lmb API's for allocating and freeing memory")
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
Changes since v1:
- added r-b tags
- reword the commit message
- rebase on -master

 lib/efi_loader/efi_memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index d2f5d563f2a0..e493934c7131 100644
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
@@ -546,6 +549,8 @@ efi_status_t efi_free_pages(uint64_t memory, efi_uintn_t pages)
 	if (status)
 		return EFI_NOT_FOUND;

+	unmap_sysmem((void *)(uintptr_t)memory);
+
 	return ret;
 }

--
2.45.2

