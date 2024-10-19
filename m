Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC91D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9E3589358;
	Sat, 19 Oct 2024 17:25:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="a01p2QZq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F090892E8; Sat, 19 Oct 2024 17:25:07 +0200 (CEST)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B85488F8E
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:25:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-8323b555a6aso175479739f.3
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351504; x=1729956304; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLqmSH80dVmZ4NjaMBBU9KfO3pktiundn4Rjj9OOIdI=;
 b=a01p2QZqFQwrQv1G19orbIx8lmsm5C2JPPboIf+iqqOgNnv6FYOJEe/Ns2vWhjSkxk
 FEEjCk5BgCuIJhrJAWrTP9UdyKIXguPBupi3TETOe6zlXWygTMA/uW/+4xsYotT7OfSA
 WefDaTMa4YtRe6BQY5X06nkK54YmX9FHCTcms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351504; x=1729956304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLqmSH80dVmZ4NjaMBBU9KfO3pktiundn4Rjj9OOIdI=;
 b=LrOKfZTFZSnjV/VhIgPYLi+WZOfouwDIfC3okXPlcOSyiI5z70bhmUkvWL6FiROE7G
 p9alYmitVziRzRgQKi3CwIyCp8pL24JeMZ6CMjZFinR7YSmdN1Rbjwjta0m9wEBViGXx
 GdKAHhYcYFu0lisf5uL8mXsvCbvMQB9MNcBaqbJeSO0fCyN7stnJTUMhW2mSInBZhYIc
 SR31rvCmDt+FhHE75WlRf8h26nnRgdW578HjOK4/r2SsYwkoO6W5Vt3AxBsOWpU9ozcD
 2wUKXUZG8uiQDGkyX0E5v5OvKe7u2n1aC7BBvkn51RIBGBj+N3sJmrCQ9J9p2WmHjGXT
 0H1g==
X-Gm-Message-State: AOJu0YwGjV3alvRAcRlYERybKRaX29A/78LrtRG8+/lhmPfJV/KWaVRu
 3F+8Z43izGfq213n74vRrax7b+Ntu/IGEPcnjuf+CK3SGv43lfm8YMjmmm5lhsPFIZqeLOLTb38
 =
X-Google-Smtp-Source: AGHT+IFbcNVwJFiiT0WdUj5eItTzqWFTeBJeinwSutiz559Y4wZJVv718i/YVPeLZBk6ERA9NM9xBg==
X-Received: by 2002:a05:6e02:1fe7:b0:3a3:b3f4:af42 with SMTP id
 e9e14a558f8ab-3a3f405e452mr54257725ab.7.1729351504132; 
 Sat, 19 Oct 2024 08:25:04 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b5ada8sm1036833173.23.2024.10.19.08.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:25:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v7 3/7] efi_loader: sandbox: Use a different filename for
 sandbox
Date: Sat, 19 Oct 2024 09:24:30 -0600
Message-Id: <20241019152434.1017394-4-sjg@chromium.org>
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

Sandbox is a separate architecture in U-Boot. We want to create binaries
which can run no matter what host architecture is in use.

Create a special filename for sandbox, to avoid needing different
code paths when creating the file in CI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v7:
- Just do the minimal update for the sandbox filename

 include/efi_default_filename.h | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/include/efi_default_filename.h b/include/efi_default_filename.h
index 13b9de8754a..6806c0daa88 100644
--- a/include/efi_default_filename.h
+++ b/include/efi_default_filename.h
@@ -14,31 +14,21 @@
 
 #undef BOOTEFI_NAME
 
-#if HOST_ARCH == HOST_ARCH_X86_64
-#define BOOTEFI_NAME "BOOTX64.EFI"
-#endif
-
-#if HOST_ARCH == HOST_ARCH_X86
-#define BOOTEFI_NAME "BOOTIA32.EFI"
-#endif
-
-#if HOST_ARCH == HOST_ARCH_AARCH64
+#ifdef CONFIG_SANDBOX
+#define BOOTEFI_NAME "BOOTSBOX.EFI"
+#elif defined(CONFIG_ARM64)
 #define BOOTEFI_NAME "BOOTAA64.EFI"
-#endif
-
-#if HOST_ARCH == HOST_ARCH_ARM
+#elif defined(CONFIG_ARM)
 #define BOOTEFI_NAME "BOOTARM.EFI"
-#endif
-
-#if HOST_ARCH == HOST_ARCH_RISCV32
+#elif defined(CONFIG_X86_64)
+#define BOOTEFI_NAME "BOOTX64.EFI"
+#elif defined(CONFIG_X86)
+#define BOOTEFI_NAME "BOOTIA32.EFI"
+#elif defined(CONFIG_ARCH_RV32I)
 #define BOOTEFI_NAME "BOOTRISCV32.EFI"
-#endif
-
-#if HOST_ARCH == HOST_ARCH_RISCV64
+#elif defined(CONFIG_ARCH_RV64I)
 #define BOOTEFI_NAME "BOOTRISCV64.EFI"
-#endif
-
-#ifndef BOOTEFI_NAME
+#else
 #error Unsupported UEFI architecture
 #endif
 
-- 
2.34.1

