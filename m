Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A827CA101E
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 01:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18B788A49;
	Mon,  2 Sep 2024 03:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EwDqRHmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0860988A31; Mon,  2 Sep 2024 03:18:47 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E77B588717
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 03:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-82a2a035b59so112619139f.0
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 18:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725239923; x=1725844723; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqr+BHhkymfVA0BI9nYI05WKqVyavf2N8o9TANhxBkc=;
 b=EwDqRHmUWjhdL1KXs43z61pLonQzxF94q8ld4bi+lYoDls3YAlJiS9O8wMSPwH1/Rk
 ynazEy/Dg0h3oN643if+9rv1gBJurLTWKTXp5XB3tzg4Gzn9jFLabpD43JiNVAO7ufDw
 phBk8uS3nM+uwCaJa6nXnoDuhCs6LG/Pgczsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725239923; x=1725844723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqr+BHhkymfVA0BI9nYI05WKqVyavf2N8o9TANhxBkc=;
 b=IpoeQNeixSuWMW7R0r3NWRrakBUBWf4HViZMuCg5HqLZ30zCkCHnOg3oph6suiCYxO
 MTgcmVJ901LOr62vfWTq+tVzZgQ7uRiVWC9VG6QjxfkXh0rfF0XEkzWOMfX+SH7KcK3J
 MqZSbwiWDpVXK5FeFbo39xf+We1xcqkvCFBZ0PBCHRoLWZgqcFmYDGB/mMO8Djn2/OS6
 huqT7IiHeexVwVSe9YO4DnzsqM4qFZFzVyhoFQDNEClw/4OaqL7f2xgBPYbSg0jQAmRx
 Uel/4nYjgjtIYmPJgkFtJOPiyvSUD00WTDQUQx91L27X4eWTKM/3ukfT4PscCnEs/yYj
 733w==
X-Gm-Message-State: AOJu0YxMOuBGs9T1/WK1cqs3iEFRUsSLL+WA9gtHKBues505Wcfo8LG8
 dLGEa2ThXnG0updFgCelzCAPRSMXkq7qcHu3mNN4pj8HNPypFN3lwr2xqZXA79KpFOrMGWuZenI
 =
X-Google-Smtp-Source: AGHT+IGJHvx97orouOtVZxuEyqZh4n6O5d43yVFrpEZ51zapzLg27yHsMZQKP7rX7n5WETUYsx+25Q==
X-Received: by 2002:a05:6e02:1885:b0:39f:6180:afca with SMTP id
 e9e14a558f8ab-39f6180b0ecmr16449375ab.13.1725239923378; 
 Sun, 01 Sep 2024 18:18:43 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39f3b03f266sm22925335ab.57.2024.09.01.18.18.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 18:18:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 08/14] efi: Use the same filename for all sandbox builds
Date: Sun,  1 Sep 2024 19:18:19 -0600
Message-Id: <20240902011825.746421-9-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240902011825.746421-1-sjg@chromium.org>
References: <20240902011825.746421-1-sjg@chromium.org>
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
2.34.1

