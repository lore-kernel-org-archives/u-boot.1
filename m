Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78A1C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 15:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D41A86F1A;
	Sun, 19 Nov 2023 16:02:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zgbz98gN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B79187005; Sun, 19 Nov 2023 16:02:38 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7429586E65
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7a9857c14c5so131511739f.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700406153; x=1701010953; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N51tl/zj6hx3y8C/i7pvWONxuVI4d2CkVjaNAa9KVfw=;
 b=Zgbz98gNRlysAEjgvVR6yJWlTkhfv8Cn3jzFa1njb+My5LNw7HnCJrbEKB0UJ3bCd4
 5qhaAQ8CV1LT6DZW3I8dyu/o52yoas8KjBM6qvvmCvWJ5Qdt15RGkVrbR90Q6m3zUkGw
 oCyAKdr2daFf5H1vyj2y54HTlyDixGlxcnDGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700406153; x=1701010953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N51tl/zj6hx3y8C/i7pvWONxuVI4d2CkVjaNAa9KVfw=;
 b=JCLvx1Acn6Ac6naMf40LyESN/pJO/Lv8H1JhXcV7vEjrb9QYWQwLYjLM+YZFlA7B/P
 TZcW/xXyvj9KMg9g/fCvlgvMr+fJsXvhFUKXuWVM/WnIbEBXIHB3RlLjXofTZhTQmwi7
 2tj4Dqc9Sauqan5aAOqF57cLblSPY4Qs8CRDNyfIWUND/mDVef9tZa1Hb5VnvxdHiahi
 +AdgomG0kXCqcWJJBEbPjZrFdePvAvmU54ZQYBnUASft7AWFON3PoGUgca2fMF5b398a
 oAiOO29A/LoWAoksv/bAlyLzABEcOm8XdW+4hwKQMBHsq8BbTK5Du4SchbHPZV9SS+V+
 O0lg==
X-Gm-Message-State: AOJu0YyME+oAUnZxL4sTmzgYdxtpB91XzPa4VljERvmCw3mM5f3pY7fE
 FoAPGW4SjpIwvm+L5QqM84WBlA==
X-Google-Smtp-Source: AGHT+IHKjO+9V/Ov2s/qDvhWacbsJZSlSMrqQojB8Glj0ndNWo7mxL+WGv1jtXPHhdXCO+WYlSj6Lg==
X-Received: by 2002:a6b:c505:0:b0:7b0:aee5:f9c2 with SMTP id
 v5-20020a6bc505000000b007b0aee5f9c2mr3285969iof.14.1700406153095; 
 Sun, 19 Nov 2023 07:02:33 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a056638379800b004665bec29d1sm79923jal.128.2023.11.19.07.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 07:02:32 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] arm64: Add a build target for Flat Image Tree
Date: Sun, 19 Nov 2023 08:01:13 -0700
Message-ID: <20231119150229.634424-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
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

Flat Image Tree (FIT) is a widely used file format for packaging a
kernel and associated devicetree files[1]. It is not specific to any
one bootloader, as it is supported by U-Boot, coreboot, Linuxboot,
Tianocore and Barebox.

This series adds support for building a FIT as part of the kernel
build. This makes it easy to try out the kernel - just load the FIT
onto your tftp server and it will run automatically on any supported
arm64 board.

The script is written in Python, since it is easy to build a FIT using
the Python libfdt bindings. For now, no attempt is made to compress
files in parallel, so building the 900-odd files takes a while, about
6 seconds with my testing.

The series also includes a few minor clean-up patches.

[1] https://github.com/open-source-firmware/flat-image-tree

Changes in v6:
- Drop the unwanted .gz suffix

Changes in v5:
- Drop patch previously applied
- Correct compression rule which was broken in v4

Changes in v4:
- Use single quotes for UIMAGE_NAME

Changes in v3:
- Drop temporary file image.itk
- Drop patch 'Use double quotes for image name'
- Drop double quotes in use of UIMAGE_NAME
- Drop unnecessary CONFIG_EFI_ZBOOT condition for help
- Avoid hard-coding "arm64" for the DT architecture

Changes in v2:
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint too-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

Simon Glass (2):
  kbuild: arm64: Add BOOT_TARGETS variable
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  13 ++
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 321 insertions(+), 2 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.43.0.rc0.421.g78406f8d94-goog

