Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6EECCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 20:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 292FF83E7F;
	Sat,  8 Nov 2025 21:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aJpYrGZb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB3C83EA9; Sat,  8 Nov 2025 21:48:52 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED9E383E83
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 21:48:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d3dx12.xx@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b3c2c748bc8so229374266b.2
 for <u-boot@lists.denx.de>; Sat, 08 Nov 2025 12:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762634929; x=1763239729; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PvR2kcoKGfIIG9FahzLPMLIwRF5/t63RsDNeDnTW7PE=;
 b=aJpYrGZbHkQFLc4NFDiYCymhxcbOSvxM19A4YKWEIYFN5aPoqrrrIvt9v3ODrM6jl2
 pvNEsuocStoNfnwhbmrJFgM1lbfPK7gkTGNN5iNWNXaziOjAmjGe5F86AkbhV1MJxPfa
 4Krx6Psyv7z8pZrGaBilZGBpo98JvnO5iYPzSAXPf5QpyC2EZINED4Idw7jfWuO9xNVU
 ji/kgJyecMYvWQ42EkbVTqUYpxHL5tYRj2xLVOXOKIgU+7hzJsYkOgjHjRFkwMt1pfea
 q5XF7rTcn0kT4iqffaIk11o8zTMMCzJuGNI7qxSbB4MRiuYTceXICJBL/imw17kXFt6t
 /xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762634929; x=1763239729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PvR2kcoKGfIIG9FahzLPMLIwRF5/t63RsDNeDnTW7PE=;
 b=KFwDrpvjS30RsG+hsZ/x1HLjR6cRzwVeHlYeD10gEEs3S+oZiFtvcQyYvX6YLab39c
 mMepTHHaRLBiiTQ44Ap+fLUhjqkncsWozYJgoLNpuyq1lANBhE2UN0UMIBtcrAUHx4Zm
 jskjrvXr1i5tsu1h3uJljeHdQDBBT7EqNbdhdopXZajdOX78o8D9j86E7o+o6HlsW9N6
 VBNMrrWOg2PNFqXkEvFJlkBqoaqxFbkXfR9EIW0r0BblaKI7x11H6ebOI9qAAqsLuyGC
 UczFzzjlPQGkn7OR3Vn7WBmFhUaYKsoguv6HXmLXNThvu8JpDBPAx3e+3HpCbQriwxeY
 BMyA==
X-Gm-Message-State: AOJu0YxY1QIV/HkRr0ZwWKQSI5g+xNJA3rYN+/SAC5qT/539s+yGlclW
 BSUi4JqaDJqTb4KEEmbztk2nYPuLEa0luuZJTipHXT3xA/gSCa/88ruK
X-Gm-Gg: ASbGnctpQgq8BWxiznNXE6Vj3TY/GyxDvIHz4kdhaBQIVESAbhic/Jl0oZCYsv3EO5S
 Rjz6XFxXIE9JBn3Ol3r/44SQ+SOoEclOcfhHaseUJItjy0pTVx5hFNIHmSUV3IbDxw69MDWYQbY
 pft2RGzBWTzNX0opIa46O6mAxgAsl9k8LjKhrsRimBvhsRtjaBToEpzUdJWvJtWALiy6uGeb7CT
 mAwSAV7f1XGSSMvbzKNtw3Mnr3NJX12EB4zYTMLcOht3pJcZWj3eDq7L9v4Etg0ojVHlNT+tAQL
 jMFpkhC7yrKjcTtSH9qB12DXNZ91B/EvoxvDDvR5g9gtxx2alPl5dgpTJutq2XWGdCrBQHa3fW0
 M4YH6Cl26HEjLH72A4qVCu/Fu8cLgS2EiH8tSMRnVCgBf6pp28dIr0R/uHXERDCAGkm//JNfyxs
 k9HZWLrAmiDS0YX+paKKKSnIEwAbh0woceB2w=
X-Google-Smtp-Source: AGHT+IHy10Tahl54E2866H+W7TEC+JhJLpZZhEvr2e8QjJ3GlCSyi81IWBEw/023M0nFi+KSy/Rg6g==
X-Received: by 2002:a17:907:2d28:b0:b33:b8bc:d1da with SMTP id
 a640c23a62f3a-b72e02b31bamr302438166b.1.1762634929275; 
 Sat, 08 Nov 2025 12:48:49 -0800 (PST)
Received: from [127.0.0.1] (B-228.ahl.uni-linz.ac.at. [193.171.46.128])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf9bd3d1sm642067366b.58.2025.11.08.12.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Nov 2025 12:48:48 -0800 (PST)
From: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
Date: Sat, 08 Nov 2025 21:48:46 +0100
Subject: [PATCH 1/2] build: fix prefix for Clang when CROSS_COMPILE is an
 absolute path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-clang-cross-fixes-v1-1-ea6c4282844a@gmail.com>
References: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
In-Reply-To: <20251108-clang-cross-fixes-v1-0-ea6c4282844a@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>
X-Mailer: b4 0.14.3
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

Clang cross-compilation worked when cross binutils were available
in PATH. However, when binutils are not in the PATH clang failed to
discover the assembler, falling back to host one.

Make --prefix always absolute, Clang supports this and will search for
e.g. $(prefix)-as for assembler. This makes sure user does not have to
add cross binutils to PATH for Clang build.

Fixes build for these examples (with qemu_arm(64)_defconfig):

make CC=clang-21 CROSS_COMPILE=/.../bin/arm-none-eabi-
make CC=clang-20 CROSS_COMPILE=/.../bin/aarch64-linux-gnu-

Also validated for the case when provided with cross toolchain on PATH:

PATH=/.../bin:$PATH make CC=clang-21 CROSS_COMPILE=arm-none-eabi- -j20

This patch does not affect GCC builds, and they have _not_ been
validated against regressions.

Reported-by: Tom Rini <trini@konsulko.com>
Closes: https://lore.kernel.org/u-boot/20251106221355.GZ6688@bill-the-cat/
Signed-off-by: Dmitrii Sharshakov <d3dx12.xx@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 62a24e38283..cca82a01843 100644
--- a/Makefile
+++ b/Makefile
@@ -600,7 +600,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
 CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
 GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
-CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
+CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)$(notdir $(CROSS_COMPILE:%-=%))-
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
 ifneq ($(GCC_TOOLCHAIN),)

-- 
2.51.1

