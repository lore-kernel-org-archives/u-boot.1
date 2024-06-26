Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98C5C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E8F288528;
	Wed, 26 Jun 2024 18:00:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XZzzfan8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DECEA8852D; Wed, 26 Jun 2024 18:00:12 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B1C884DB
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42561715d41so3038285e9.0
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417610; x=1720022410; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AgDkU3kc+gE9cH9KGK92Fgrg6aAJ0qflIR6mzpaVBA=;
 b=XZzzfan8XlKuMYfyZNUeD5IFx/c/HqESWUXhBG1oKprUGSshkCEJgWQXm+yGzM/2uZ
 K9R8z+3TuMVxXRXt56uV9emTOuYwHfDq3pTcWq4dXfpYNq5gGFxCwa/BtI8K5cVdZnRa
 sq8XvlCa5Z8UA5HtyVP2VWTwWBUEWuuyKj/vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417610; x=1720022410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AgDkU3kc+gE9cH9KGK92Fgrg6aAJ0qflIR6mzpaVBA=;
 b=nSrhhNe/x2o6Xp8ystBU9nuukqowlai2dfKJmUcM+xYYTfT8gPL1Z7F4DCVHrLIXF/
 6/ErjTKqc4bniO4i24sjurBIW2HXDveVF6wG2fhJeHdcE/y2FSXYDazG8biD9PSv+skG
 oXW3lSmIzCytPQUHAq7R8To8MRz/NPC2qh23Ol3jj7CbtyGP1iv8dHGyLbMjsf8prtjs
 hra2fpdp2s8j8YjrxiihRSz+mLqEAOsrV8FVxhN0cxvc5Iu0PbKA/gq3fIGCRiLtRMDL
 37NSTWZFijx7abDjUea6Tpriphw9Rlc+wFx3DVwHp1Dk84ICxUBSG9U2BSYcQ909LRzB
 +2cw==
X-Gm-Message-State: AOJu0YzzSqS3dHrt0l7ms3DKQH7qYV0lkpC7HdPIdkThxejNdYOLq2ww
 yj5Ggy+BVTi4t80UtikqnDqyflzZ2z197y/nET3gCjKe+0pJjypSCMYqcbVfa/7MSjo2ZwJyupo
 BOw==
X-Google-Smtp-Source: AGHT+IEV8bM0FPDvE8P/gkwpAvSvOvY8BRBSKmkpblGtHPwEfwSshrEiUdHGR7HmlYbUx9Q6g2JEQg==
X-Received: by 2002:a05:600c:3096:b0:424:8acb:7d53 with SMTP id
 5b1f17b1804b1-425630daf25mr895775e9.1.1719417610268; 
 Wed, 26 Jun 2024 09:00:10 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v5 07/16] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Date: Wed, 26 Jun 2024 16:59:36 +0100
Message-Id: <20240626155945.278640-8-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

It does not make sense to enable all SHA algorithms unless they are
needed. It bloats the code and in this case, causes chromebook_link to
fail to build. That board does use the TPM, but not with measured boot,
nor EFI.

Since EFI_TCG2_PROTOCOL already selects these options, we just need to
add them to MEASURED_BOOT as well.

Note that the original commit combines refactoring and new features,
which makes it hard to see what is going on.

Fixes: 97707f12fda tpm: Support boot measurements
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too

 boot/Kconfig | 4 ++++
 lib/Kconfig  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 36bdc83b957..4c9d2c0f79a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
 config MEASURED_BOOT
 	bool "Measure boot images and configuration when booting without EFI"
 	depends on HASH && TPM_V2
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..568892fce44 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -438,10 +438,6 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
-	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
-- 
2.34.1

