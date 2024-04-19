Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382CFC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 07:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A434F885B9;
	Fri, 19 Apr 2024 09:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZBvmzrkE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54A1B886B9; Fri, 19 Apr 2024 09:42:12 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1308688553
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 09:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so2166831a12.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 00:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713512529; x=1714117329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jSfcrLSxRJx5o7rnqPpbPn7q41A6wOhVSMrQXuaOitE=;
 b=ZBvmzrkEwvlLZeeUGOMIPhB5rsDhzX0CtT5llFZoojRRwuholTqDbAwAxqB/DE23Va
 mJ1k/9sAbFT8fdtOY0e8jAOX3cCEsipZztgw6yCW7P2BmurqaylhJJiLodPKJGEs+f6y
 +K/dRVvy5Ih+o/yw7Q09HXqM0Hqbg2bcOaIO9AhXvLAoGQolD5d1jp0d+QA6pnCAFaoA
 KFho72N5nQ84zIjzhzu1LdJEm8FX11sDGAbcf4+G09wH+8V+eK2pGwSZW+MeT69bqiZf
 mEmrHvMWWWjbhNBPFNe11qS5r3KUbVBkLbU7tG9+BIuvrZ1ZzGGz5LNF5gdbDY2wn38g
 yVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713512529; x=1714117329;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSfcrLSxRJx5o7rnqPpbPn7q41A6wOhVSMrQXuaOitE=;
 b=ObrQUFoDyzgQc/ezADMWpzHdKEx//cq3R/KYbzfxqoJHkxBZxFgKkAKSWyvDXQ4nFE
 T1vN6UeFzw3RHBw1jCjO3FmR1s2dN9KSPNVSnRbmaCMW7QpUNvKsaVERcSOKm6iaFp59
 EzoqR0VKVuLSyzn51DeB6f0Y1anpZMjVY2WRO3RIG6JBHoLN5GY/dAzA/utQgPTWq9gc
 vCn/18SHot1ElSbiYP1FeHvMg57C0CbisxFcwETm0VatTzD+in6BqCkJ+7hYTkUtu6R7
 4V3sQ5AyoRZ+Y7nZH8Wh/emyVulCUZuq2fgQw7SMKpSyHxd58LNYtUWFuwABcmyE33Cx
 BbYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVfVFTrT/X6UfUny+Vi8A0WzOKqwEeSHE8WY0/DtrZm6rJdm2Og0WQIWE22a0YQ/SqsEZxY9GFREuzhWwXuR0nIFqN7A==
X-Gm-Message-State: AOJu0Ywoa7ZJq2MCHfH9GrhhVf6JtfzD9uqjRoAwYxyBNsJ9YChoSE0j
 ZPct4esk2xQneltAWWbfd5AheanAf17T1e3bCCsPYtF8N5x12xaI909yHslzHQf1kQXra97Y3rK
 dlzk=
X-Google-Smtp-Source: AGHT+IFCLH85MTlnNz6m3aM8aXj2ce4f8Ze+I+fEKhHU+4T83bu+R1NIk1eHppZAjkMTuFOZy+TRdQ==
X-Received: by 2002:a50:8ac9:0:b0:56d:c91c:dfc2 with SMTP id
 k9-20020a508ac9000000b0056dc91cdfc2mr942668edk.31.1713512529493; 
 Fri, 19 Apr 2024 00:42:09 -0700 (PDT)
Received: from localhost.localdomain (ppp176092141112.access.hol.gr.
 [176.92.141.112]) by smtp.gmail.com with ESMTPSA id
 q10-20020a056402248a00b0056fe7c5475bsm1797858eda.10.2024.04.19.00.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 00:42:09 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: heinrich.schuchardt@canonical.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH] efi_loader: change the error message when storing EFI
 variables
Date: Fri, 19 Apr 2024 10:42:00 +0300
Message-ID: <20240419074201.9053-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
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

When we try to store EFI variables on a file, we need to use an ESP.
if an ESP is not found, variables will change in memory, but U-Boot
won't be able to restore them across reboots.

Adjust the error message so users can understand what's going on

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_var_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 413e1794e88c..5276740ffe7a 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -82,7 +82,7 @@ efi_status_t efi_var_to_file(void)
 
 error:
 	if (ret != EFI_SUCCESS)
-		log_err("Failed to persist EFI variables\n");
+		log_err("ESP not found. UEFI variables won't persist reboots\n");
 	free(buf);
 	return ret;
 #else
-- 
2.43.0

