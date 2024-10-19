Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54581D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5840A892ED;
	Sat, 19 Oct 2024 17:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RHETDsjR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71BDE892CF; Sat, 19 Oct 2024 17:25:06 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FFC187D1A
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83aba237c03so74010639f.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351503; x=1729956303; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+70WcbA74VuPeyhdS56gWVzIo/18Ac3yq2SMvYP8Aho=;
 b=RHETDsjRwC/VdjhjSDucT/enUQNz/OjSx8HwQU2Uc/f5xRBZnq/1G32Pw3v8nHYDud
 bK6UF5B5vDiFhVL2dxQiQaVObos9J8FxfJYrBRF1wpfVdsLRrr75Dr0tf9v3hxZ+bEte
 ZxRKvgst27Kg1yM2RZKWfcN4TMC+QST7IL9MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351503; x=1729956303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+70WcbA74VuPeyhdS56gWVzIo/18Ac3yq2SMvYP8Aho=;
 b=jR9fvfwD93CsD0gns1Xic8NfUBlx0uf620OHTYxAIc5QZ1N9yc51f9WBSy67Jhec9t
 qpZwGuzVmJ1yq7K2E9PUpqcznS7yE0uwb92h+2JnmenxVa3B42+X/gYHVO1/q5mDgpl2
 QWt8pW0a/J6xFCN2vRzCq2Kk6qJAkjYJ8krJFyNXUNlaW+nVOkn9EBVYyimCsQlHbXrw
 a6WUiRahTZeU9FT5xywbCdMSGwHjkyx2coT+ee4DIr7fUEs/QeAWU2USXYgX9bRfedpl
 hlbV0E1GmLang6xYACpBjFktK/jnbMiXQI+Ef9JFnQL+hrnWHXsFJhctEIUjLYbFIgKR
 twGQ==
X-Gm-Message-State: AOJu0YxCdKDOId9/gPYY8gTAI9YDcKxZQVwzW8Pux1agdURCWviuoMb8
 pvmehodp/w+GTmP7ndI0AIhBg/O/AsMlXtptEcC4HR9lG+eKQ5lxSDW1zpP1QgggACUw68jxSQ8
 =
X-Google-Smtp-Source: AGHT+IGd8fUuFbPREy081MFWyuXaRM3QabAaciR7NvTOGfRSBp99LfzK5gaq2wJzNWyqqAc3RzhIpg==
X-Received: by 2002:a05:6602:6c10:b0:83a:b52b:5cb5 with SMTP id
 ca18e2360f4ac-83aba5c8b84mr756155339f.5.1729351502891; 
 Sat, 19 Oct 2024 08:25:02 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 2/7] Revert "efi_loader: correctly identify binary name"
Date: Sat, 19 Oct 2024 09:24:29 -0600
Message-Id: <20241019152434.1017394-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152434.1017394-1-sjg@chromium.org>
References: <20241019152434.1017394-1-sjg@chromium.org>
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

This patch was applied without sandbox review. It has changed how
sandbox works and the original author has not been willing to
discuss alternatives.

This reverts commit 3a0654ecd0d6a39406e6fe91f7a40ce589594ae9.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Add a revert of the un-reviewed patch, instead of just changing it

 include/efi_default_filename.h | 41 +++++++++++++---------------------
 1 file changed, 15 insertions(+), 26 deletions(-)

diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
index 77932984b55..13b9de8754a 100644
--- a/include/efi_default_filename.h
+++ b/include/efi_default_filename.h
@@ -5,7 +5,6 @@
  * file name is defined in this include.
  *
  * Copyright (c) 2022, Heinrich Schuchardt <xypron.glpk@gmx.de>
- * Copyright (c) 2022, Linaro Limited
  */
 
 #ifndef _EFI_DEFAULT_FILENAME_H
@@ -15,42 +14,32 @@
 
 #undef BOOTEFI_NAME
 
-#ifdef CONFIG_SANDBOX
-
 #if HOST_ARCH == HOST_ARCH_X86_64
 #define BOOTEFI_NAME "BOOTX64.EFI"
-#elif HOST_ARCH == HOST_ARCH_X86
-#define BOOTEFI_NAME "BOOTIA32.EFI"
-#elif HOST_ARCH == HOST_ARCH_AARCH64
-#define BOOTEFI_NAME "BOOTAA64.EFI"
-#elif HOST_ARCH == HOST_ARCH_ARM
-#define BOOTEFI_NAME "BOOTARM.EFI"
-#elif HOST_ARCH == HOST_ARCH_RISCV32
-#define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#elif HOST_ARCH == HOST_ARCH_RISCV64
-#define BOOTEFI_NAME "BOOTRISCV64.EFI"
-#else
-#error Unsupported UEFI architecture
 #endif
 
-#else
+#if HOST_ARCH == HOST_ARCH_X86
+#define BOOTEFI_NAME "BOOTIA32.EFI"
+#endif
 
-#if defined(CONFIG_ARM64)
+#if HOST_ARCH == HOST_ARCH_AARCH64
 #define BOOTEFI_NAME "BOOTAA64.EFI"
-#elif defined(CONFIG_ARM)
+#endif
+
+#if HOST_ARCH == HOST_ARCH_ARM
 #define BOOTEFI_NAME "BOOTARM.EFI"
-#elif defined(CONFIG_X86_64)
-#define BOOTEFI_NAME "BOOTX64.EFI"
-#elif defined(CONFIG_X86)
-#define BOOTEFI_NAME "BOOTIA32.EFI"
-#elif defined(CONFIG_ARCH_RV32I)
+#endif
+
+#if HOST_ARCH == HOST_ARCH_RISCV32
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#elif defined(CONFIG_ARCH_RV64I)
+#endif
+
+#if HOST_ARCH == HOST_ARCH_RISCV64
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
-#else
-#error Unsupported UEFI architecture
 #endif
 
+#ifndef BOOTEFI_NAME
+#error Unsupported UEFI architecture
 #endif
 
 #endif
-- 
2.34.1

