Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5B4D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796FF89D0C;
	Thu, 28 Nov 2024 20:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OaNZlVWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE08C89D23; Thu, 28 Nov 2024 20:13:10 +0100 (CET)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E7C89D3E
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-296994dd3bfso660262fac.0
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821186; x=1733425986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HUaUpwiQYkli58IVrFzZf2BGkBfnfEb85/8u04Z0F5I=;
 b=OaNZlVWNxCDtqNx/AqU0XS/LtzBYQyGhJyhRznUhuJJwZkxMAfDHR2hEI5A1wx7OBD
 gxpLGjDOmHBNhbby4xiJtneWlU0PoAGvZJ8rrTKNOqCFzdehLN1MkFaDCe+HphJ3TAOq
 9AOU+G3aI0+AezoaRbhSRJJzcOehmWrRGOmUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821186; x=1733425986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HUaUpwiQYkli58IVrFzZf2BGkBfnfEb85/8u04Z0F5I=;
 b=T/ZFlu/dbmqYZGSxNcGgbm93Kw0aDFDgUY/SXUt1fAWHisimoOCpgeI1S/d4NkKHnl
 XLIvjtnb+xJeVcVLorIFTMEJBWiY9CyJeu4iCDp0/dCiFjQcSkGQv96nrIKtASQw/vLx
 8coXJKTXOEfx5ghy+mfWWO1Mp68oGINFwKSgxuj/VJGNAhHeRZZwiR2gXKL5rQpuyY9g
 mrrHTJPXdLemPWN+OgtfrLXfVFUwpUKZvXHvIUWOQy9NSQ56JKLAsO6Ye0mrKBdPUGrN
 IM0oK2V62YwU9VQFcss80jm4f6kBJxGB7f0vuP2y2BvvWp35BpGYf3B8efme1iFc2ldc
 TWxg==
X-Gm-Message-State: AOJu0YyL+Tz81Btg5HF+uUa8vYXg3I9rYuEJ1zgNpI21hGiMt8uLHJRk
 rn92IrVJX//MXG5DrJqrZsw+NtplH/pweUKKwIe4+qBFuFPmc8vjydcG2qVcLmGz6A8pBKA4vGI
 =
X-Gm-Gg: ASbGncuphYsZ1HFkaCusWiVbJCfs45GvaULnurDZAa/0AaxITbt4qzDCA9dNzQy0T1L
 VACraGtXg+Dh9UfN9503omVji5kYBu3ia+FWbgi9SBaah3Bfx1Hs9KtgwmdJc2TOmThhOASVvsB
 p2YmLVIjxKjlaHPM9rNgEtxPaVblgm7vM76tfTfqbkUmN1jeqcPKDAecVYos3fZZRP6BqjqXvPh
 1IQFXAy9h7NZ5A8k6hF/mt3bzYz2fuHO345BctoTfeSLg==
X-Google-Smtp-Source: AGHT+IGy1KwnjsZFP+tEGl6NbARr4QEUIwYsQNRgIdK67KJrwP3G37zOU6oJ7GP44IacWSYNr0JjGQ==
X-Received: by 2002:a05:6870:a19e:b0:296:a67c:d239 with SMTP id
 586e51a60fabf-29dc4008d30mr6291130fac.12.1732821184760; 
 Thu, 28 Nov 2024 11:13:04 -0800 (PST)
Received: from chromium.org ([50.190.87.202]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm429521a34.54.2024.11.28.11.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 11:13:03 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 05/28] efi_loader: Show the resulting memory address from
 an alloc
Date: Thu, 28 Nov 2024 12:12:21 -0700
Message-Id: <20241128191244.900006-6-sjg@chromium.org>
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

Update efi_allocate_pool_ext() to log the pointer returned from this
call, which can be helpful when debugging.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Use EFI_PRINT() instead of log_debug()

 lib/efi_loader/efi_boottime.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 080e7f78ae3..be8e4f41ad2 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -511,6 +511,9 @@ static efi_status_t EFIAPI efi_allocate_pool_ext(int pool_type,
 
 	EFI_ENTRY("%d, %zu, %p", pool_type, size, buffer);
 	r = efi_allocate_pool(pool_type, size, buffer);
+	if (r == EFI_SUCCESS)
+		EFI_PRINT("*buffer = %p\n", *buffer);
+
 	return EFI_EXIT(r);
 }
 
-- 
2.34.1

