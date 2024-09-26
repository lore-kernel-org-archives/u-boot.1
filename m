Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0F3CDE03D
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:01:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4846788EE5;
	Fri, 27 Sep 2024 00:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GfRuDZ+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C418C88EF2; Fri, 27 Sep 2024 00:01:23 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A969288EEC
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb2f272f8bso10972036d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727388080; x=1727992880; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6LEpRQnkHzYLDHBZ8nGOQQ5vLJkYrhjalbNlynHgLA=;
 b=GfRuDZ+L8Kol5J3GQhzJRsSErjXs7zlef2iGFbYNgS41zQQg4Hb5tNJfVpSBn+tRcg
 XLaE0VWcDMSWeuJG8t6LWa8MNGNT1NnC2hNjuypOwL7C/36h7C/bvjkuNgiwPPyOMIBG
 ItL6l5JG4Pqt4T1Ag5It81JHQkJfPHTIP0h9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727388080; x=1727992880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6LEpRQnkHzYLDHBZ8nGOQQ5vLJkYrhjalbNlynHgLA=;
 b=IlxLgvKeIP7k7tFX9fDfB0sVruhi0tD4XRUkkcG2y8gvpkmBNc7s7ru6kYD9QX+K3P
 isApk9SGfMWepUGTlqGMeyAdkBIAQxJa44FEJqgzZFqG6gbkdWzAmSBhY4CygzwW8kZH
 KQ5uEPPAUv6cNep6NGHVhy16MoNQggNLCGqfr41AZkhKkvQcSULyX89JmRgr7vzyF9Dd
 T6BmYEurdalInANuU7kR7uioTrTr3im14Q1azY6SkR5huAiX66QV9H3gcxk6HG4By+mJ
 yZwRqCB0yKvNq7CYkzevDqt83SQNdur91TrfdXrURysAG8VakRT8ih+BRE82kQM6uRtX
 1Stw==
X-Gm-Message-State: AOJu0YztI17hJlnKlog0qXd0/vcPI506kRdEF2O41anLfr3Ok6BzatE6
 yuACjFuAOJj3nHGKIuN5jvODYSeqPjhhjUMAwYYDZwjy3MJWZQpJH16zY/xR4a0FO5kWZVynG3e
 K4nfc0L4=
X-Google-Smtp-Source: AGHT+IF5/at2FZb3hSA2uLME8guqOoucxVuyupEgJ4kltQuPpLlDw0YcDAXj577q/1R6ol/UeCzaUQ==
X-Received: by 2002:a05:6214:554a:b0:6cb:2e7c:a10e with SMTP id
 6a1803df08f44-6cb3b6a3349mr14409076d6.48.1727388079985; 
 Thu, 26 Sep 2024 15:01:19 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b632366sm3079696d6.71.2024.09.26.15.01.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:01:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 06/12] efi: Use the same filename for all sandbox builds
Date: Thu, 26 Sep 2024 23:59:36 +0200
Message-ID: <20240926215950.1265143-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926215950.1265143-1-sjg@chromium.org>
References: <20240926215950.1265143-1-sjg@chromium.org>
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
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v5)

Changes in v5:
- Drop the Fixes tag

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
2.43.0

