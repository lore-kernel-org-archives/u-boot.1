Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865BCC10DAA
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:22:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D581A87638;
	Wed, 29 Nov 2023 18:22:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZ++yIk1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 289F987691; Wed, 29 Nov 2023 18:22:52 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70A6A875F5
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:22:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7b3ec83a8d4so19434839f.1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701278568; x=1701883368; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FmMU4E/b+uSxcWr7/YV1tz9g4DZ7LEAYA6oOOjTn5rY=;
 b=fZ++yIk15X7vuwVQR1RTK+5rb8JB+4UGhGV/uTxaUV+DchNJYlK5mb55J42wHXZcQ+
 5ug9DtqxoEkJN88waiG6DpbU94FimRIlS/B0mfEJMM+mUYg8e+CuyYwNivn4UyKSr+6C
 A0yEnqD2FzCb2o5Elh4Es3Fzeg+RN29qRH3WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701278568; x=1701883368;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FmMU4E/b+uSxcWr7/YV1tz9g4DZ7LEAYA6oOOjTn5rY=;
 b=Is0mxVC1U/FIB2gE1SepV68k7YMj0uo2Lhnd4gZ6m+hJiRs4wVZMjyqxk7hCPex6B0
 ptgaUJUCMEtZ30f86yTM3dpAP0qHQGSKXHQ833QC7ijnydGaP2hV7BdR7UhqbRfMpfbr
 cVVnb8RQytUtIyloz6FE/kJxpkkNr5UOzRU2+Yj+hjaO1Eh3Jv3d1naMEAmpJcpctSDu
 GtQeL3i9MfBZRziehQbUHiXJVCtWXq1/WtUr34lJOTRLzZqOBWaXxyXVKG53qOY61zXO
 Ybgx1mTOgKNDjcGnZmuQzCCk9pyqW1vJ90hSTvMm8iE2lpFSpHxt7L0h3hRj1c1zHWwz
 rmGg==
X-Gm-Message-State: AOJu0YyWOUy8zkShCRbeAuA1DtBk+iEfl/B7ByWgNfJgMWwKb909Qa25
 fxz32Qc+VKv/0dfJzi2ABW0pcA==
X-Google-Smtp-Source: AGHT+IGBxziXrcPo8J6ti14stg5UnqZ33EBytnwprKYBbSzdEFUFDixLcVYV2vqJhDc547Ifaf7fVQ==
X-Received: by 2002:a05:6e02:1c88:b0:35c:c82c:c79c with SMTP id
 w8-20020a056e021c8800b0035cc82cc79cmr9781849ill.7.1701278567855; 
 Wed, 29 Nov 2023 09:22:47 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:f4fd:5056:45a8:b749])
 by smtp.gmail.com with ESMTPSA id
 di5-20020a056e021f8500b0035d2fc4ce47sm471212ilb.9.2023.11.29.09.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:22:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>,
 lkml <linux-kernel@vger.kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org
Subject: [PATCH v7 0/2] arm64: Add a build target for Flat Image Tree
Date: Wed, 29 Nov 2023 10:21:51 -0700
Message-ID: <20231129172200.430674-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
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

Changes in v7:
- Drop the kbuild tag
- Add Image as a dependency of image.fit
- Drop kbuild tag
- Add dependency on dtbs
- Drop unnecessary path separator for dtbs
- Rebase to -next

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
  arm64: Add BOOT_TARGETS variable
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |  13 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  13 ++
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 326 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.43.0.rc2.451.g8631bc7472-goog

