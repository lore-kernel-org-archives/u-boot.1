Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 680BBC4167B
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C3D86FC3;
	Sat,  4 Nov 2023 20:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aEivncyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08DE486E1C; Sat,  4 Nov 2023 20:42:30 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 755ED86487
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a694a365d9so134220539f.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699126945; x=1699731745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S2OX4Eo9v+rQhNr2FvX3vObjPM79OTe5nhhahXKdqeM=;
 b=aEivncyU3206nIU2JWW/8fwrUsBGigd5ONXt3g0fWHq3pEZcKDR3xz5Dwc3t7AQFZD
 xY0SnDb9F25tv+G3zfl5CrRfRCq/+kxWuAWtLP7yh9zfQiXoLwmG+VU0Tn1sTdrsFkvO
 8EO9uWw22SwnHSe4s7LIHGgeqhUKotb5DEX3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699126945; x=1699731745;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S2OX4Eo9v+rQhNr2FvX3vObjPM79OTe5nhhahXKdqeM=;
 b=NOZsAptjxVG5Tfjg+pKFTLFZFlBBOC0m20qpAdMO8nAX2sLE85T4W5BuXB2KNm0mAg
 jmdYOUOqIF+Rbja3HetfrlCa3j3A9qv+3pmO8KBcKwYAWdoyR8doDPjW1gV2NaRWMTBL
 +ihKSpWe5t731wH/BOGggH3AnixY+ABbpoHOmi+82/5d4GD309DBEMi9RGKbZoObh71s
 E9bjeDvvFBFNAFJ2q+WTxEUQxdM76fxMrgwEW7iYaoIiSjnaRMwFlnhRK3QDGbORo/np
 05cv113STCjU+SJBukqi6DIRvGQITKSyyqbclNk1nzIJobUXOMKtQ0fRFhETSUsBCR36
 3eKQ==
X-Gm-Message-State: AOJu0YyVEJE5zTOwYB55Sv5XxR9xtv6pCYF/+o722ZIH276au2nEzQAh
 vhyAe6vQdCXpBJPEi0stM8PJTQ==
X-Google-Smtp-Source: AGHT+IEQmOlHpL29TdFXJFPMr5evJiymQwNEjalBxAKtB6JFDUpkecBI6UNYhrYY+8vXDuE77TuE4Q==
X-Received: by 2002:a05:6602:3419:b0:7a9:4b18:4c89 with SMTP id
 n25-20020a056602341900b007a94b184c89mr31619795ioz.6.1699126945152; 
 Sat, 04 Nov 2023 12:42:25 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a6b5a04000000b0079fbb834232sm1293318iob.19.2023.11.04.12.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 12:42:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Nick Terrell <terrelln@fb.com>,
 Nicolas Schier <nicolas@fjasle.eu>, Will Deacon <will@kernel.org>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: Add a build target for Flat Image Tree
Date: Sat,  4 Nov 2023 13:42:01 -0600
Message-ID: <20231104194207.3370542-1-sjg@chromium.org>
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

Changes in v2:
- Split double-quote change out into its own patch
- Drop patch previously applied
- Add .gitignore file
- Move fit rule to Makefile.lib using an intermediate file
- Drop dependency on CONFIG_EFI_ZBOOT
- Pick up .dtb files separately from the kernel
- Correct pylint to-many-args warning for write_kernel()
- Include the kernel image in the file count
- Add a pointer to the FIT spec and mention of its wide industry usage
- Mention the kernel version in the FIT description

Simon Glass (3):
  kbuild: arm64: Add BOOT_TARGETS variable
  arm: boot: Use double quotes for image name
  arm64: boot: Support Flat Image Tree

 MAINTAINERS                |   7 +
 arch/arm64/Makefile        |   7 +-
 arch/arm64/boot/.gitignore |   2 +
 arch/arm64/boot/Makefile   |   9 +-
 scripts/Makefile.lib       |  20 ++-
 scripts/make_fit.py        | 288 +++++++++++++++++++++++++++++++++++++
 6 files changed, 329 insertions(+), 4 deletions(-)
 create mode 100755 scripts/make_fit.py

-- 
2.42.0.869.gea05f2083d-goog

