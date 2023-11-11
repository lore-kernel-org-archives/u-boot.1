Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D131C41535
	for <u-boot@archiver.kernel.org>; Sat, 11 Nov 2023 00:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A89298784B;
	Sat, 11 Nov 2023 01:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BCYiGg/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53C2A8784C; Sat, 11 Nov 2023 01:29:35 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D73986F32
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 01:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-66d0f945893so22002726d6.1
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 16:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699662571; x=1700267371; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M3FqWqpMvGy3I/j1a0yonrCNkExrkTlpaTzYW4XHQH8=;
 b=BCYiGg/jbYqEPpte/TW7tBgF1rV0/2JCrLCFSlK6/ZykVimZImriAA2GK+9AOcrGL8
 krX9pqKwYZdAKlFtuTKDiCoO+6DmSh3vIh7Md1ChQUMB3grD6iTeby0GbpuHwhnKui61
 Hsth04PcfuyqdobNuoHR3uuFre/YvHV8kGRmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699662571; x=1700267371;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3FqWqpMvGy3I/j1a0yonrCNkExrkTlpaTzYW4XHQH8=;
 b=Ed4YrqnONxpgVC+d8YX4niIxFOWVf2pm7oUCjSRwNbCXqwTrUQvGBjUtLsAhLx1Psx
 sDrbSGXrqErk/g+vsxpBUuC00t/+gA2p/oA4dOHHUxEwur2D4/eiel6i5xieomrY52og
 RWU/AId5OfeFh9Vqc9SHqSP9Da1y0ndngozsSlWZN725RgdpJspKioY1+jCUn2/IMQpp
 wXqJ6y9/GMZARLTz5U16TT/Bh9My2pA1aT8lL7jrz6x8IvgJ1bgOj/s6Yt7AoDswjHnC
 sSHeLXra8BP5T3FAWjOraBfg0tPkGTu4RQ6L0FRegYAJGZq3LyLBorVjeOyhkv1yJGde
 Evug==
X-Gm-Message-State: AOJu0YxxAtt2v85NiPGXFvzJlK9AWDHqghFb6BYLN3DJyomcXmTPW/PJ
 jnb2wFQqUoSW6SJWZljOh9BfWw==
X-Google-Smtp-Source: AGHT+IFKxCzqkIhj/4+puQidciJwVE6cx36K5j318gXTxCtNqzPsItFD1CVurLoJ+T7KVdksSn3fvA==
X-Received: by 2002:a05:6214:125:b0:66c:fa89:a894 with SMTP id
 w5-20020a056214012500b0066cfa89a894mr5337035qvs.10.1699662571162; 
 Fri, 10 Nov 2023 16:29:31 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5104:5a27:f95d:21d1])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a056214029000b00677adcfd261sm55898qvv.89.2023.11.10.16.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 16:29:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: lkml <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org
Subject: [PATCH v5 0/3] arm64: Add a build target for Flat Image Tree
Date: Fri, 10 Nov 2023 17:27:59 -0700
Message-ID: <20231111002851.1293891-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
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

Changes in v5:
- Correct compression rule which was broken in v4

Changes in v4:
- Add a patch to move the single quotes for image name
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

Simon Glass (3):
  kbuild: arm64: Add BOOT_TARGETS variable
  arm: boot: Move the single quotes for image name
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   1 +
 arch/arm64/boot/Makefile   |   6 +-
 scripts/Makefile.lib       |  17 ++-
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 323 insertions(+), 4 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.869.gea05f2083d-goog

