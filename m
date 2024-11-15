Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6F3D6DDE3
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 13:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B4968933B;
	Fri, 15 Nov 2024 14:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fnDhNJhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4895989326; Fri, 15 Nov 2024 14:48:17 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C05E688B6D
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 14:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-83ab21c26e5so61061339f.1
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 05:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731678492; x=1732283292; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z/SVmmOquWrTWheDBOKDIwyiNYoWq7fxKAi5M0qhde0=;
 b=fnDhNJhytH0XQmWGvQqCMODJLSGAVHojQ6ccc/Tlb6iouYcV5yBYrWXzMB0bj5uvMB
 0ZnnqXMUsFrtRNPKsHjJZpvmoOcF0qrJud37sft+/XWEAZSftr4wlr0eZuy/VHSmcgnW
 S/IwRFJZGvNmSOPZENAEq3V716JpYAzAccCk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731678492; x=1732283292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z/SVmmOquWrTWheDBOKDIwyiNYoWq7fxKAi5M0qhde0=;
 b=o/Gf8n79Mz4B+P8/qX+TptUCmAgQ7y4b1JiA/3pe5D6kDqCKuZat7OU15AFqAcf2o6
 TknlqIRV97VzzwZ645jY/195v+Ya7HguD/LZvebf0Z44ZyDiu81fgkhfg1ry6K90f8VQ
 VuIR3dtjzjliAiza+4i8TQDhQbmC0HDTcnHwF/JTh2yjLwZGq7CxK2ylp0wdp3fvmT4W
 d4uZVNpK3wh4MTcnqt9jOn/7mcepUyt4PgKJQ7HCCM7XmZxCV6buxj6ibDpR2K7E7B52
 JAOZVWPTL+AtouqPfP4A0eTXmnFL+GbifsEIg4ozeXXSeNoAXOinZjpdp7/8hfK7TY9M
 gkIg==
X-Gm-Message-State: AOJu0Yy0ZOvQXdlgQjuX5eNONpYXtB4BaCjLm9hoPbaKpily/Hs55BM/
 9MmulkApPerGFruxhyuOyrF+PBgEPSHqdnTa84T9SCOL0xU4fLbhVpXkV6Sgnwo58yPR9gg7syU
 =
X-Google-Smtp-Source: AGHT+IGgrohqlBWEXYH9P3K/WZ2paSpMJBjaU1+g7aO0DRUR5NBnQhESEKY4Wzjjc5dGuXLomYVsjg==
X-Received: by 2002:a05:6602:6405:b0:835:4cb5:4fa7 with SMTP id
 ca18e2360f4ac-83e6c301bf2mr372812239f.12.1731678492534; 
 Fri, 15 Nov 2024 05:48:12 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e6df91554sm34118439f.9.2024.11.15.05.48.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 05:48:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 0/6] CI: Set up for an arm64 runner
Date: Fri, 15 Nov 2024 06:48:01 -0700
Message-Id: <20241115134807.3068947-1-sjg@chromium.org>
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

Changes in v5:
- Drop the comment in the gitlab file
- Add back a final missing sudo

Changes in v4:
- Leave the 'sudo' in

Changes in v3:
- Move ARGs to the top
- Revise documentation to explain a common error and building on arm64
- Use grub-efi and linux-image-generic for both archs
- Add patch to install toolchains on arm64 host
- Drop patches which remove grub and tracing for arm64

Changes in v2:
- Update docs also
- Add comments to the ARG variables
- Swap order so that amd64 is the exception

Simon Glass (6):
  docker: Support building for multiple architectures
  docker: Adjust packages for arm64
  docker: Drop coreboot for arm64
  docker: Fix LegacyKeyValueFormat warning with PYTHONPATH
  docker: Install toolchains on arm64 host
  CI: Add platform variable

 .gitlab-ci.yml          |  1 +
 doc/build/docker.rst    | 23 ++++++++++++--
 tools/docker/Dockerfile | 69 ++++++++++++++++++++++++++++-------------
 3 files changed, 69 insertions(+), 24 deletions(-)

-- 
2.34.1

