Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347B4C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53C688B14;
	Thu, 15 Aug 2024 22:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MVqxJlA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EEA388AF8; Thu, 15 Aug 2024 22:24:46 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D8D088ABE
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:24:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-396675b83afso5475375ab.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723753474; x=1724358274; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vP+eHtllxXFLh3S1JYYgb4WIjP8Q0ScZfnEYmBUpR0=;
 b=MVqxJlA59oZoJFMnhMd8XlGMnjZ8CKds5iwqDupjZG4nOJEwF9SB/uEsgy+Igc06jh
 eV2o76YyuStOcMsMvg+9rm4y1GwMRW1qTzYBWQCCJMWlDE5YP7ePiBjEevfpHeBZRqs0
 hPuC9kYuZztUo4q5CztI7JV0VSwslSM1qzDoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723753474; x=1724358274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vP+eHtllxXFLh3S1JYYgb4WIjP8Q0ScZfnEYmBUpR0=;
 b=HxOa0j/wbX154rlRyVCeFB9WGN1WijPeLy/GW3JGCqxBpa12xY6Vtmh1e/P/lhA1YD
 H5qJdVqcdJZj8pRaW0o/bSrIZTHtdYfaoyBKjHibCmmUud1B7VQXkJMYs3KZkOPgwhnq
 2+lKIJHKWgGeE4hswMfVE4kQLbtGqlCzlOjdVw50VJrvLDmonQ3hxj+2OsW0S+2kYmQ8
 /aLulocDCvAfWvmfQI5wZNzce/g55BzqFVuNVbYH0AEChPeqEnHwZ5CmfFvfTsDgfmsc
 0bi7/7ayszxFWaEEFgCUvgL29NZaYVvo4SGf+FkSS7ye8WAGVoazvcwKBKtw2XyoQzrB
 v9tg==
X-Gm-Message-State: AOJu0Yx686/WXb/CB8pTx1de0P08LkhP7SfsrRowaEjoGm8f/7ripWVL
 KpFBRv+bYCZlIc3rv5VUHgxvyvSXlDxxFQQalDmwlm8GXC+XkVWq4puqXuLtuMJLw0GvO4QGA0g
 Dyw==
X-Google-Smtp-Source: AGHT+IGlsX9doF9Vv4vyYTAZZYCm/QmgFniF8pwRqf+hA22+tbDJIZtY7UqbAGgFLLrzTeqN+WPHFg==
X-Received: by 2002:a92:870e:0:b0:39d:28b4:2514 with SMTP id
 e9e14a558f8ab-39d28b426camr1372055ab.10.1723753474345; 
 Thu, 15 Aug 2024 13:24:34 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39d1ead5597sm8144915ab.7.2024.08.15.13.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:24:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 08/14] efi: Use the same filename for all sandbox builds
Date: Thu, 15 Aug 2024 14:24:18 -0600
Message-Id: <20240815202424.766778-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815202424.766778-1-sjg@chromium.org>
References: <20240815202424.766778-1-sjg@chromium.org>
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

(no changes since v3)

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

