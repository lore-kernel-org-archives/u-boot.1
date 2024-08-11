Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22403C3DA4A
	for <u-boot@archiver.kernel.org>; Sun, 11 Aug 2024 15:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E264B88C3C;
	Sun, 11 Aug 2024 16:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TAsLKdvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 254F388BA5; Sun, 11 Aug 2024 16:53:00 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC07388C2A
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 16:52:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-81f85130660so143489639f.1
 for <u-boot@lists.denx.de>; Sun, 11 Aug 2024 07:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723387976; x=1723992776; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwxAiFESs65vbo6QNOU8SXLS8pkdRiY6L9eOgLqhNdc=;
 b=TAsLKdvkRHxNFGvJs+vR8EN0TbY0L4IFRU3E6jTYZhDocR47/D2qwJMrsFwKmFh8jf
 gHHlIKmT0pUG+UnqVPmYV48D+gf7lIVqJ0/MLp3WsjPKvx4nOGy266nasQeNprnV2wcu
 yktjMqj+aNYQzLcEUZWh1BZ73cCCZpkE55hiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723387976; x=1723992776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwxAiFESs65vbo6QNOU8SXLS8pkdRiY6L9eOgLqhNdc=;
 b=SMfdLvwi3X2pZ8JMY9fG0HqcjuEcr1n6WKRTNcEi4OmBZjxmzjLVVIoHCYXDM+CLXf
 uYctBpNN19MjMJQlLgqMciBRrpXFD+GdgeucjW+LRvshSN0ITTWdu2WkrbcNe+7zFWKW
 ruGQVAz/Yyr02D8dIXsyZCEf+WoFaFkXZIyh/j1Egoe+20DeciKDv3obfxzrm8j8wwY/
 QLU9lTPYSW2FyHVVpSwAbyxr8HWuh6GonEHlGSo21WkY8C9fSWWVna5G6l7rJodaUTPo
 YWPGkotGuwjSEWj8aedbVTHAWDiMO0oiUSd5w0zcXuArmCjTg9jMORZW6cz0uRnZqdH1
 ZwIg==
X-Gm-Message-State: AOJu0YxqMwjmiRz36SmCN+rGGhtoau7adHAVWFd5FExO8+6eeKBDGQtH
 3eTrPGYSGTCUycCN7V9AVjiwx41NhfO/SsToICtXenLtWISGdipHyRRUUZ3XJRjY5ntp9ecowjM
 =
X-Google-Smtp-Source: AGHT+IHtXje9OyFNqb9tbpa0zW37Dp0GTmky/6EkK+4nDEqBzRhhFiYvCjpCWBjdccGYq0BwBflsZQ==
X-Received: by 2002:a92:c56a:0:b0:375:acd3:31b3 with SMTP id
 e9e14a558f8ab-39bd419bcbbmr80004615ab.5.1723387976495; 
 Sun, 11 Aug 2024 07:52:56 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39c30a9a2c8sm11195855ab.43.2024.08.11.07.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Aug 2024 07:52:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 34/40] efi: Use the same filename for all sandbox builds
Date: Sun, 11 Aug 2024 08:52:03 -0600
Message-Id: <20240811145209.4191404-35-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240811145209.4191404-1-sjg@chromium.org>
References: <20240811145209.4191404-1-sjg@chromium.org>
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

Sandbox is not a real architecture, but within U-Boot it is real enough.
We should not need to pretend it is x86 or ARM anywhere in the code.

Also we want to be able to locate the sandbox app using a single
filename, 'bootsbox.efi', to avoid needing tests to produce different
files on each host architecture.

Drop the confusing use of host architecture and just let sandbox be
sandbox.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 3a0654ecd0d ("efi_loader: correctly identify binary name")
---

Changes in v3:
- Put back the Linaro copyright accidentally removed

 include/efi_default_filename.h | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
index 77932984b55..06ca8735002 100644
--- a/include/efi_default_filename.h
+++ b/include/efi_default_filename.h
@@ -16,26 +16,8 @@
 #undef BOOTEFI_NAME
 
 #ifdef CONFIG_SANDBOX
-
-#if HOST_ARCH == HOST_ARCH_X86_64
-#define BOOTEFI_NAME "BOOTX64.EFI"
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
-#endif
-
-#else
-
-#if defined(CONFIG_ARM64)
+#define BOOTEFI_NAME "BOOTSBOX.EFI"
+#elif defined(CONFIG_ARM64)
 #define BOOTEFI_NAME "BOOTAA64.EFI"
 #elif defined(CONFIG_ARM)
 #define BOOTEFI_NAME "BOOTARM.EFI"
@@ -52,5 +34,3 @@
 #endif
 
 #endif
-
-#endif
-- 
2.34.1

