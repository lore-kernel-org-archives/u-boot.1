Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1905BC83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:38:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C7682FA8;
	Tue,  1 Jul 2025 15:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WE1laJtD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4364B82F6A; Tue,  1 Jul 2025 15:38:30 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3611682A76
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so3717485f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 06:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751377104; x=1751981904; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7WIF1WL7vJzvILF3ZNqF9ll4V9gcAQBMKGPZJySazVs=;
 b=WE1laJtDxdMhWSY2OYQb3MZ+zNc7cPDhlpyR5Akvso3B24goi9SqRFI2kc+OH7qNHB
 Sduu4hOZrTiWtqbP9bn1yaCQUoZ69axCqzHy+Jsy+HOTyQSZOzPDVps+wtrmo2m2Qf1N
 o6NK8QXNEqJrRU6U242ok3bAj04DffXshc4cIx8wFAcff3FynYAoFuA3LxfmBRA47Jhi
 J7/0rO2KaH9OynTXstWsIPwSGXF95Sh0CC9yU30e30h45TrUbwfVOK6qGRt0IkMYn17t
 LR9/PPAJu6AV8wkcN9Yb18OfeOwpcEJpUSk5bPi8hSP1n7PeJCGk0y51jpl9bNE287hU
 nHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751377104; x=1751981904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WIF1WL7vJzvILF3ZNqF9ll4V9gcAQBMKGPZJySazVs=;
 b=oCa+Y6l6dXwKRe3RkhY4x0tZENqwVgLHbVUFpHDfEANmyzfz9nsSmNay8TAVUi0WAO
 UGfGJwtNjGs7v8MJwOnnrj9GpCexxvfplG+VllsvsSTf4fKSn8guvbAjVqeUcsKlkz2q
 9jrheJIqzZy+a7OsXNbY9tiNQmveo8w1gq8V2NdKAzr/J6xs6OYwBUhp/CoKS/q1iNul
 chS63l9zNPg4DnQYMjE53dj1Yn5Zly2TqXIfPi8qVVn74NYiA1SOUCrBgEglU55daNip
 Sr501kWiedjn7v+z62Vx8AlPfHQEq8d88DOgospjb8dJpE9SLLNeXqZjjcRjzZyCh5in
 DVtA==
X-Gm-Message-State: AOJu0Yz2OqkqBivcoaFIlFoA9twKz7BwW+GaRynXSro99Sp1mstAXe6q
 0czs4lPD+NWC+8VBJwpbpYLigTVr1njaPSx71oz/1VR3uf/tUJO5LxAf8I3ZkleMH7g=
X-Gm-Gg: ASbGnctFbmTzhlLtHdfRrq14qbFxwwPVSLhNX+d4/moS0K3RETstCf48XU2NtNqNL9B
 lf44z38foTI8z+7jqrpsgOPla8gCMw8YKI7GfphrBBKt5dafGYVr9/5zETRuSLiQZDlR5rnRfTw
 Yd3K/RmI4zwOJbTIrPXGDUg+szBX9itGYotRZ/GtplmlCsUcp3+TF5vijz6M0Y40vSxOHUheGzq
 3XpUV/WlOmICT/0/j/ryeLbuuuiRJrfomWFiFTYfL5HvpO9WHNcN9qQNilnFb24668w2WuMnGmD
 caigip3FZeD/VSnCwxRwzNyLrDSNkgoVTn7AhnhRoiVN9R+0WxbbiTIcaOqtr5vj5LWiJk5EmgE
 HMo3cIsKw6WuCP72y/kFunS+lQg==
X-Google-Smtp-Source: AGHT+IFPx0+sAIVgv0WbtVVmclyOGNSYWSx7ScY2P2jx8IIZ2dhesWWkyyAy6je8WhlbNlhJJTpvHw==
X-Received: by 2002:a5d:584c:0:b0:3a4:d939:62fc with SMTP id
 ffacd0b85a97d-3a8fe89146cmr14888393f8f.22.1751377104586; 
 Tue, 01 Jul 2025 06:38:24 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ee3:2301:fddb:f4a6:27d9:d8d6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453823b6fa2sm197268095e9.27.2025.07.01.06.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 06:38:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 01 Jul 2025 14:38:22 +0100
Subject: [PATCH 1/3] efi_loader: Prevent dereferencing NULL pointer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-efiloader_fix-v1-1-f3c6e0b0ae43@linaro.org>
References: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
In-Reply-To: <20250701-efiloader_fix-v1-0-f3c6e0b0ae43@linaro.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

Taking the first goto error: in file_open could either result in an
attempt to dereference fh when NULL or else free fh->path which has
not been assigned to and so will be unknown. Avoid both of these
problems by passing path to free instead of fh->path.

This issue found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 lib/efi_loader/efi_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index 7d81da8f2d8..19b43c4a625 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -248,7 +248,7 @@ static struct efi_file_handle *file_open(struct file_system *fs,
 	return &fh->base;
 
 error:
-	free(fh->path);
+	free(path);
 	free(fh);
 	return NULL;
 }

-- 
2.39.5

