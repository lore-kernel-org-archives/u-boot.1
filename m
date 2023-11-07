Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FFDC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 14:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9355887045;
	Tue,  7 Nov 2023 15:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HQcoKrR1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93BE387045; Tue,  7 Nov 2023 15:49:26 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2A386470
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 15:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so233069239f.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699368563; x=1699973363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mGdhwZC1aoWv4hm325gNK3bTc4NhbyLb0VzfJImw0Uw=;
 b=HQcoKrR104UY+SV794e1O1Rof4SozOlfoxSkHPYOHM3hSCL1kCSe22QsrhEWXCfuj7
 jfF+oIpSL92zbCKOT2bPdvm3W/4acx1t6IXA9AjSkpkqk3xGYuCxCO+ywhOyYs8y1qju
 LtzMb74BU8sR92wBJy68+rrQGemxEsPjGRyyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368563; x=1699973363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mGdhwZC1aoWv4hm325gNK3bTc4NhbyLb0VzfJImw0Uw=;
 b=W5mwW/60SHC0gbUXqk/iA4LJhDfQnf9sEkvbYJ3ElSuwLR8nYQNsmsGkscJX6LGW0/
 yyvbMNEIUtnVeUdZFd7xzfAoUZOqfpWCUKzkgqu4gRgFZkst4aKcWbAQu0j7Souhi0K9
 Eu6w4Sh9NItXfmSwJVTKJzLm9epnF76etvfuRPQGvwFhmnBc1LOA4S2ShsEs4V5SUCbG
 FDok42HKrk3vo9WiUONb1FHSsApDPFyqCuBM77ENXvAwR+PZJc71+dZvV8yaeZ+T6TPw
 qNZRnawFOn5XK1mn1X5HhU2YYwF/MtHJmSrVtWwLDFYlFEmdEiBQkcDUwAqs1Owavwhc
 0U9A==
X-Gm-Message-State: AOJu0YyZJgVfU6iLd6MDCwAskEKRR+24NqaIatnGBsgeWJBTBN038IA8
 1iHkkgUKNOBhBS89J9XUAblxMQ==
X-Google-Smtp-Source: AGHT+IFbWYxmCVLOPBkIKdca7xRPNMPu+WV7uYSe3XtBCvnGL0pLnyu5kmk3VGVXfipxrEiR5YJiqQ==
X-Received: by 2002:a05:6602:29cf:b0:7a9:509c:961 with SMTP id
 z15-20020a05660229cf00b007a9509c0961mr36574184ioq.13.1699368562862; 
 Tue, 07 Nov 2023 06:49:22 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a05663801b000b0045a66a26208sm2815200jaq.128.2023.11.07.06.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:49:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: Add a build target for Flat Image Tree
Date: Tue,  7 Nov 2023 07:48:48 -0700
Message-ID: <20231107144917.48304-1-sjg@chromium.org>
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
 scripts/Makefile.lib       |  20 ++-
 scripts/make_fit.py        | 289 +++++++++++++++++++++++++++++++++++++
 6 files changed, 326 insertions(+), 4 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.869.gea05f2083d-goog

