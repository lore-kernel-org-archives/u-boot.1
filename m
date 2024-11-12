Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AD8D42B85
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 14:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A44BD89443;
	Tue, 12 Nov 2024 15:11:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FQZSgbh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA45989440; Tue, 12 Nov 2024 15:11:14 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F67A8913B
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 15:11:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3a4ccfde548so16176145ab.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731420671; x=1732025471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VjhaTSfHCVkQ7uZIgfXTWfR5Ticnbjf3iR5bDgM8BVQ=;
 b=FQZSgbh5GRcl3ypmm0ERsTndI2vG0KRgoB3U/mtZIB/LcQ6QTOWhmTevE1/LsPy6IW
 W2IbkAyuisE5GDQxtlLmQPQooyPuvReUugPNDGD3RdBayTBDARdKmXSu2PUHXgMpojy7
 U4d/27BgiecPIm87MD05uOJQQRHI5uj00upfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731420671; x=1732025471;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjhaTSfHCVkQ7uZIgfXTWfR5Ticnbjf3iR5bDgM8BVQ=;
 b=qS5XS0Mn5dP8nxEBC7wQRxqkO5OKNY3v3sHiZT7nJMSlfRFNEa6WImt1+HL2Pd5Tum
 8EUYTNlBkD6x2JE+Qv4ZxLkw7Vs3bdHT3ZfzoUFnPeji2UDYt5z3FCydcTaPOGznfihN
 12JL/vJtNQ5ICFnWlf6HhSnE5sS14pzlBYg8VBDsds4HFLS+Oz+9473MjT1NBC1CQIjZ
 jCkcNIJUM/GqRhsMXQEp1UwX6B/Lb2EFNIYLsMX2hj2XnrlSCSdI7rPToR8x3P+01fAf
 Qj1auRe9RJJXblbyYTDlG9cQnQHqEhjnrsU34rIvUGFA11uH1g56PWxq3nLlaiV0p6Rd
 Nr+A==
X-Gm-Message-State: AOJu0YwGch+BLcxMikVDpdgyjN8MK6MVWwUi9oqtdA9QQSM4/jaItavI
 TxMXG9EdpghVgvRuABKaQ8wuS5xQxC2/XpqMy5xXLkcteUGKPTwYGbmWvyzuB5Rn26nJyhU82cg
 =
X-Google-Smtp-Source: AGHT+IEL+tRdu7inm3vpo+s5s9O9uQ3DLyWeLx2+WxnP4+Gq3OUaHyla+tD6AwGCxPVsJN/k31FEPw==
X-Received: by 2002:a92:c60f:0:b0:3a6:ac4e:4d with SMTP id
 e9e14a558f8ab-3a6f11bb220mr150692475ab.7.1731420670651; 
 Tue, 12 Nov 2024 06:11:10 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de783d11f0sm1977776173.0.2024.11.12.06.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 06:11:09 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 0/9] CI: Set up for an arm64 runner
Date: Tue, 12 Nov 2024 07:10:56 -0700
Message-Id: <20241112141105.640189-1-sjg@chromium.org>
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

 .gitlab-ci.yml                        | 11 ++--
 arch/sandbox/cpu/cache.c              |  8 ++-
 doc/build/docker.rst                  | 25 ++++++++--
 drivers/remoteproc/rproc-elf-loader.c | 18 ++++---
 lib/efi_loader/efi_image_loader.c     |  3 +-
 test/print_ut.c                       |  8 +--
 tools/docker/Dockerfile               | 72 +++++++++++++++++++--------
 7 files changed, 104 insertions(+), 41 deletions(-)

-- 
2.34.1

