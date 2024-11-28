Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94F6D6911B
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 15:51:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BC089D20;
	Thu, 28 Nov 2024 16:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P5/jYlOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CDAF89D84; Thu, 28 Nov 2024 16:48:48 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16AB489D6B
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 16:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ea4c550a3fso433590b6e.2
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 07:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732808924; x=1733413724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r59lnS9ted88mZtiv5di3gMKm6dNWml+RmTdamVb+Jk=;
 b=P5/jYlObzct+BIpdncV3kr98h31Mz9M7ye3VOJuZr402tg+sVs/6eGcB1u9iM1OmsN
 zrzmbA0iMgxmK4p+S65c9xvZw+ON2dDrzjuLz4gvGEEzkEP6z7DnlvwlSNkDCX7qHHwz
 Yek92s5pqLJ0uqlPkvV/wZxt6lx0wUvp4arRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732808924; x=1733413724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r59lnS9ted88mZtiv5di3gMKm6dNWml+RmTdamVb+Jk=;
 b=OBWp3S9oaykcxPtf66toaxrW90oWJGgF4sfvFCwBC5/p37A2kcowf8CmJKnmOYjWLl
 vQbhs3gT2TcYO2sCVgnnXcAIJVGRJNeVP9MnCvIfA+meB0n6/owyKgCcK8lEHCNPBkGL
 3mCDcgb6LN2tlaMYVKQDvmnIkCtCAtSxBF9eKjd1xybwEIxF8QvZrMGojhB3wRtY9RFA
 jbNpVMNMRblIgjVSBNxz/9j1I5hGBH76cZTpTWrA+rp5OWWRxNzVcYeyotyU/h72LvBt
 BKDu36n1gBxDE8eevAhui6JrNiP33+ZnCB5wUrYZZWdlH+QDdvZq+/5FeoOqkIXKx6Ek
 PJVg==
X-Gm-Message-State: AOJu0YyG7iEiTWV9QktsM8jw1zdFibQu+74tZRWXTbpHzwbr0d9GHCaE
 1wP54c+MwbCBRnqLoPR6qYGFwQQgLDds7+S5QT+NRDPNR4G10kNd0N8Zxg1XQrLRFIV7tpQ6eD8
 =
X-Gm-Gg: ASbGncthCOLJLeummx3GHHu4tEemi7fjZOU2egyOQbBmFY1cLy5vTWxzBCJxCn0+nM0
 9kW61UUKi5XBXtKNTGEpvhSfJTsdWZcOM/vjOe9X9+cSxpjLIH/E24oa7BzNIVqb0TuN1PnkvBH
 Lwk9k1uXVHCpaRwSCHncjrx3fOBab8jhK/VxYUk1NlgoERetFxgdEeCKQ4PcMvOsOgpkYQB0mI0
 Z/fgejvey1FE8LYcGLiHPvSmoHfIe/jG44UcHV7xCy2ag==
X-Google-Smtp-Source: AGHT+IFCrH/z2dEK4/UDUQANuaqaCZROdMOqS4eUGQovElw8MJN0x6jfW26ryNvdhzjhiTXAxhyrhw==
X-Received: by 2002:a05:6808:22a2:b0:3e8:1f5d:b7f8 with SMTP id
 5614622812f47-3ea6db63a4fmr6900242b6e.1.1732808924020; 
 Thu, 28 Nov 2024 07:48:44 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ea86347014sm305419b6e.47.2024.11.28.07.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 07:48:42 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 21/28] efi_loader: Use addresses in efi_reserve_memory()
Date: Thu, 28 Nov 2024 08:47:20 -0700
Message-Id: <20241128154727.771871-22-sjg@chromium.org>
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

Adjust this function to use addresses rather than pointers, so that it
doesn't have to use mapmem.

This is fix#2/4 for: Update efi_add_memory_map() to use address

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/efi_loader/efi_dt_fixup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/efi_loader/efi_dt_fixup.c b/lib/efi_loader/efi_dt_fixup.c
index 0dac94b0c6c..72d5d432a42 100644
--- a/lib/efi_loader/efi_dt_fixup.c
+++ b/lib/efi_loader/efi_dt_fixup.c
@@ -9,7 +9,6 @@
 #include <efi_loader.h>
 #include <efi_rng.h>
 #include <fdtdec.h>
-#include <mapmem.h>
 
 const efi_guid_t efi_guid_dt_fixup_protocol = EFI_DT_FIXUP_PROTOCOL_GUID;
 
@@ -26,9 +25,6 @@ static void efi_reserve_memory(u64 addr, u64 size, bool nomap)
 	int type;
 	efi_uintn_t ret;
 
-	/* Convert from sandbox address space. */
-	addr = (uintptr_t)map_sysmem(addr, 0);
-
 	if (nomap)
 		type = EFI_RESERVED_MEMORY_TYPE;
 	else
-- 
2.34.1

