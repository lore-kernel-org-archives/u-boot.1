Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E469D637A8
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 18:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE55988A1B;
	Wed, 13 Nov 2024 19:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XTh2UwhS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CDA88A1B; Wed, 13 Nov 2024 19:53:50 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 320FA88216
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 19:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3a3c00f2c75so25687255ab.2
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 10:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731524026; x=1732128826; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E7OYVUulx4i/brhcw10kyYIt8TeQJpB8vdUJ7vkauhA=;
 b=XTh2UwhSNDj1ETRbh1wSsvhF+WRrAUn4aEPModrDwQS5Mje+1QnepPlkO2TkarsmSq
 rQfJ0h8nRddMGj20pLAhKQOqJSEn78KSrDNK8ajnZS8tilu15fC1EuPc9cGe+9hw4M4F
 Gn7V2unNzCdi4C8WBPAxPXCek/DR7f8Od6tnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731524026; x=1732128826;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E7OYVUulx4i/brhcw10kyYIt8TeQJpB8vdUJ7vkauhA=;
 b=V5Nf3a9PGb9QbK29Vzc+LnfYGyKqq3dmmIlG1WRRtlljhOjwPnvv/r8FXZ03LTOner
 wVJBMeiyuHeWlpOzFVUBAqgTjQd5A5pAVAlSVYH4Et0I9lS5PEeSuOFS7BM6YC3y7gb2
 K/T6Zlapdd+BrpH48MTjU84BjM7JdhGRSgeiEjdZPi7m9kUo92BHiWcbaF8qnsxET3ta
 Ge09pCkbowBcN3AFum0ggXS5Qy82rTQq6CPCnmz1g3j29qiDwci3bR2Ex1ARhinyGUnB
 qo7HhK1skSKrfNUH6d1MAjAXco5bJAy1FWBKZ0ew91f8O9+/fXrG+mmU/YzHwEFUC0WX
 M49A==
X-Gm-Message-State: AOJu0YxTTa1DNuVTB3mkDCE511WMiJPgjtBhMasF9arNTzqPhVmpVWoz
 OeCoOxaEZSAF8XsiJE/MCpDzv4jci4FyW5dQS8AyH2OCADpdtFF64PG1vKuEkYNl+FBbZiK0FAU
 =
X-Google-Smtp-Source: AGHT+IF2YxBU41UPtxb4i/5ySii8Wi3Ot2DEIuDtmoT/SzBlgxulZ6OwzlTbqLhYRBpjo62n029uVg==
X-Received: by 2002:a05:6e02:368a:b0:3a7:1de2:1dab with SMTP id
 e9e14a558f8ab-3a71de21e7dmr6225115ab.10.1731524026270; 
 Wed, 13 Nov 2024 10:53:46 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a6f9890ec4sm30733675ab.75.2024.11.13.10.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:53:44 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 0/9] CI: Set up for an arm64 runner
Date: Wed, 13 Nov 2024 11:53:31 -0700
Message-Id: <20241113185340.1661198-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

All gitlab runners are currently amd64 machines. This series attempts to
create a docker image which can also support arm64 so that sandbox tests
can be run on it.

The TARGET_... environment variables for grub could perhaps be adjusted,
using the new variables, but I have not done that for now.

Currently this builds OK on amd64 but fails when built on arm64, in grub
on arm64-efi:

2022.6 gcc -DHAVE_CONFIG_H -I. -I../../..   -D_FILE_OFFSET_BITS=64
   -MT argp-pvh.o -MD -MP -MF $depbase.Tpo -c -o argp-pvh.o argp-pvh.c &&\
2022.6 mv -f $depbase.Tpo $depbase.Po
2023.0 gcc: internal compiler error: Segmentation fault signal terminated program cc1
2023.0 Please submit a full bug report,
2023.0 with preprocessed source if appropriate.
2023.0 See <file:///usr/share/doc/gcc-11/README.Bugs> for instructions.
2023.0 make[4]: *** [Makefile:1714: argp-pvh.o] Error 4

Perhaps this doesn't matter, though, at least for now.

This passes gitlab:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines

but still fails on arm64:
https://source.denx.de/u-boot/custodians/u-boot-dm/-/pipelines/23346

Changes in v4:
- Leave the 'sudo' in

Changes in v3:
- Move ARGs to the top
- Revise documentation to explain a common error and building on arm64
- Use grub-efi and linux-image-generic for both archs
- Add patch to install toolchains on arm64 host
- Drop patches which remove grub and tracing for arm64

Changes in v2:
- Drop message about EFI_LOADER
- Use '\0' instead of 0
- Update docs also
- Add comments to the ARG variables
- Swap order so that amd64 is the exception

Simon Glass (9):
  sandbox: efi_loader: Correct use of addresses as pointers
  test: Adjust print_ut test to use unsigned char
  docker: Support building for multiple architectures
  docker: Adjust packages for arm64
  docker: Drop coreboot for arm64
  docker: Fix LegacyKeyValueFormat warning with PYTHONPATH
  docker: Install toolchains on arm64 host
  CI: Add platform variable
  WIP: CI: Update for arm64

 .gitlab-ci.yml                        |  3 +-
 arch/sandbox/cpu/cache.c              |  8 ++-
 doc/build/docker.rst                  | 25 ++++++++--
 drivers/remoteproc/rproc-elf-loader.c | 18 ++++---
 lib/efi_loader/efi_image_loader.c     |  3 +-
 test/print_ut.c                       |  8 +--
 tools/docker/Dockerfile               | 72 +++++++++++++++++++--------
 7 files changed, 98 insertions(+), 39 deletions(-)

-- 
2.34.1

