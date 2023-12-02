Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40CCAC10DC3
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 03:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B60686D9A;
	Sat,  2 Dec 2023 04:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fu6/PWRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0C186F6F; Sat,  2 Dec 2023 04:55:28 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 915FB86A43
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 04:55:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c206572eedso1007566a12.0
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 19:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701489324; x=1702094124; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Nagqp0QINZEQDYIsDAmXj4OVh5WUG+529LOayf8ho24=;
 b=Fu6/PWRVGczIZ3P6Xv8wHBdW9RvpyCRTBwoeSUM7hgoTmd5pASXwLO51uUOgybpKA3
 6J5jkiFjsglt69OH/tVnlA7rDOPYcKiqBj45BkSgHtr18zv4nsUlB7b3aL8/VZrznF2h
 PLKR3iOP4OzpkDnfVEiQ86wELyhWbKmjzLfdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701489324; x=1702094124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nagqp0QINZEQDYIsDAmXj4OVh5WUG+529LOayf8ho24=;
 b=c2BDgJY+30DjAEWRgTo8ki9O/d0m//N43yvH/qNteQMJtXtCJwwRTgLPnBF+D437h0
 3/YJXkAMHFFVeGClucdjUK06sZxNfZiipeOjmQ0x9u9+8sv2xj+1vOXmF7AsW52TKXvR
 c2E2VQ3/2SYVtWlveZQzjH1YQ6zYApZ72gT2CCOIlNOKt27WwVkvxoUpTCgoabzy/avK
 e9e+KI4gi7et9Av81sflHYRzfPlCRIHCBjVWJ76IPechvmmEVh1oUVjuZ8X32g0Qci7u
 XwX5bXabBIwbn2L52rXhBPwbe/qtkivUzjROBksQhuBRUZA87OtmsGJWmyA6oStYJHt5
 VRlw==
X-Gm-Message-State: AOJu0Yy/UT8ZCbdZZRosSUfSDeQSXOUmdfKD7ZHs8o4f3TFxGsfJqVdL
 hRw0E8n0jorKTOD/el3XLRAJvQ==
X-Google-Smtp-Source: AGHT+IHknJk9EJeTCI+YGHGGAESdUt1vn2NNWbC28hZ2Kj/CzojYjDIpyW5vNlBm0dNz1t8I64kaug==
X-Received: by 2002:a05:6a20:54a3:b0:18b:8158:86ea with SMTP id
 i35-20020a056a2054a300b0018b815886eamr754283pzk.10.1701489323714; 
 Fri, 01 Dec 2023 19:55:23 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a62d147000000b006cb60b188bdsm3866565pfl.196.2023.12.01.19.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 19:55:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor <nathan@kernel.org>,
 Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Subject: [PATCH v9 0/2] arm64: Add a build target for Flat Image Tree
Date: Fri,  1 Dec 2023 20:54:40 -0700
Message-ID: <20231202035511.487946-1-sjg@chromium.org>
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

Changes in v9:
- Move the compression control into Makefile.lib

Changes in v8:
- Drop compatible string in FDT node
- Correct sorting of MAINTAINERS to before ARM64 PORT
- Turn compress part of the make_fit.py comment in to a sentence
- Add two blank lines before parse_args() and setup_fit()
- Use 'image.fit: dtbs' instead of BUILD_DTBS var
- Use '$(<D)/dts' instead of '$(dir $<)dts'
- Add 'mkimage' details Documentation/process/changes.rst
- Allow changing the compression used
- Tweak cover letter since there is only one clean-up patch

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

 Documentation/process/changes.rst |   9 +
 MAINTAINERS                       |   7 +
 arch/arm64/Makefile               |  11 +-
 arch/arm64/boot/.gitignore        |   1 +
 arch/arm64/boot/Makefile          |   6 +-
 scripts/Makefile.lib              |  16 ++
 scripts/make_fit.py               | 291 ++++++++++++++++++++++++++++++
 7 files changed, 338 insertions(+), 3 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.43.0.rc2.451.g8631bc7472-goog

