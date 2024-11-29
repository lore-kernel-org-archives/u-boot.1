Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE47D729E9
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 16:35:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA90891F5;
	Fri, 29 Nov 2024 17:35:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Obn3FFIJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF4E891F5; Fri, 29 Nov 2024 17:35:21 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCB7891CF
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 17:35:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5cfddb70965so2386397a12.0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732898119; x=1733502919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fU90U3F47CumcRAOvrvxLDb55n8icxq6eKeukvJX0Ts=;
 b=Obn3FFIJznTRm3qD9e/jU5nEumsU8Zf9K/TFq5HP40ALMqEVcq/3N3V4BUBnAD09pC
 2tapxqXAxqpSUr0cSJSAda26NSJVr+cZaop/XZicr9nkT32dUJ91/g3ZM0FubvWs55Qc
 FgjZH5UWWbDrHl1TVVmWK/gSvFwm0RwerGjwSjTL8npNaBPaFh9tT1ILWKtsUUSeqQTW
 DIgKJgKxPbD4QFSv1Ddi7nPr467VGudOGzfyi+NIdAC8DwQmpG13u/6QhUZ2AiuvyV3d
 feHLM0vVNpIHT5xyDxdpRxwyiWwi6htbIJhFBheQlpXDWk4vP/uG/TPd6F6y0Ft9ZL21
 XlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732898119; x=1733502919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fU90U3F47CumcRAOvrvxLDb55n8icxq6eKeukvJX0Ts=;
 b=hhnUJzxmOvsDtdjU0URXaEhzK8cIEZyez905c1MRX4qzcUxHr/KIgc1SmBOKc/pMyX
 n2QsriXKKuU1gZ2W0cRp1WYZhwE7HInSK4ZEypUbB+FnwcLl0y+qKS6Lz38tWXb685B/
 jpcZ++tsVas7gzcESbe8ZiIwytKqS/uXJgsY+AtqkgjM6F3fHLnCl0wP/dhV/Wj1cL4W
 bTRYKeJQ84LgB58Sy2cOn0fGFyQBEUPNLxbnesuyC2P+z8s/g6qpwnPOnIlmUL4gVCes
 W1dOO4c/xFP6OKjLVibAFasLN1HFDZLEHxQ6K5lF6oRvQ6+jbafiJd3G8B7L3ibu9f+w
 W/JA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIPk+fxon8+BuquhWuEjOxtNQLpeeJ/GPTn/bETpaKmzATzq/f/GHdGspytABx0d//kWwxeuE=@lists.denx.de
X-Gm-Message-State: AOJu0Yxs1WmXsFcCK857hK3nN3sMYFR9IGp4wF1m8iooYyRfu6apmiDW
 vSr7KZoGH2e3aiByrae47FTgNVrWXiGJN8rHbDacHEE0yKkTrRAd+2clZkqNbNM=
X-Gm-Gg: ASbGncuYhjxl4HE1dbmISIPFjRJAe7OkZ96AsulOAO93jTGpZUzqlbFJz4r6Mt/Bpbc
 naN79+s3d/jvLVQEFsWQiPw0xOZjMLBJXl6bj9DJVVQ3OLLdT/CRk75lUK+FA3Th93HW1TMX1xp
 yL8RHGHtamVbyQUWE3dj5CIWog0Px96/1JZHmGWZci1aoEuhwkBXKYab5INFVoYrLHx3UUYm8QA
 KWuO+poxFJh96o5p+yAfYOPcssQkeUWxOug3WwcVNKd8PFEC4yx61dF574CuECNx5pBqN+LuM6a
 JFmtnqFIcvw0oRAgOzkPaKPhtA==
X-Google-Smtp-Source: AGHT+IHay+xhKR65W4Oz4WjhYumGgz1+kYIsqxHdsiGdMTe6J6uxPZRaNED4SSO1WCz5/A8yaBfAyg==
X-Received: by 2002:a05:6402:5113:b0:5cb:dfd8:464d with SMTP id
 4fb4d7f45d1cf-5d080c5ac36mr12098711a12.28.1732898119187; 
 Fri, 29 Nov 2024 08:35:19 -0800 (PST)
Received: from localhost.localdomain (ppp089210064034.access.hol.gr.
 [89.210.64.34]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa5996c1945sm188254466b.19.2024.11.29.08.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 08:35:18 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: [PATCH] efi_loader: Add U-Boot memory to the EFI memory map
Date: Fri, 29 Nov 2024 18:35:10 +0200
Message-ID: <20241129163511.767015-1-ilias.apalodimas@linaro.org>
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

This code was removed when the EFI subsystem started using LMB calls for
the reservations. In hindsight it unearthed two problems.

The e820 code is adding u-boot memory as EfiReservedMemory while it
should look at what LMB added and decide instead of blindly overwriting
it. Thew reason this worked is that we marked that code properly late,
when the EFI came up. But now with the LMB changes, the EFI map gets
added first and the e820 code overwrites it.

The second problem is that we never mark SetVirtualAddressMap as runtime
code, which we should according to the spec. Until we fix this this hack
can't go away, at least for architectures that *need* to call SVAM.
More specifically x86 which currently requires SVAM, sets the NX bit for
pages not marked as *_CODE. So unless we do that late, it will crash
trying to execute from non-executable memory.

Notably arm64 disables it explicitly if the VA space is > 48bits, so
doesn't suffer from any of these problems.

This doesn't really deserve a fixes tag, since it brings back a hack to
rememdy a sitation that was wrong long before that commit, but in case
anyone hits the same bug ...

Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map"
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_memory.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
index e493934c7131..edd7da7d8c6e 100644
--- a/lib/efi_loader/efi_memory.c
+++ b/lib/efi_loader/efi_memory.c
@@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
 {
 	unsigned long runtime_start, runtime_end, runtime_pages;
 	unsigned long runtime_mask = EFI_PAGE_MASK;
-
+	unsigned long uboot_start, uboot_pages;
+	unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
+
+	/* Add U-Boot */
+	uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
+		       uboot_stack_size) & ~EFI_PAGE_MASK;
+	uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
+		       uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
+	efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
+			      false);
 #if defined(__aarch64__)
 	/*
 	 * Runtime Services must be 64KiB aligned according to the
-- 
2.45.2

