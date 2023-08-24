Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C501CC3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 293BD86970;
	Thu, 24 Aug 2023 21:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZohpGr3P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D63548693C; Thu, 24 Aug 2023 21:56:03 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 350668683C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so7754639f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906958; x=1693511758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sFlGN5dwEYd6I+M2jRQAudIBnCMLsnn9iVjBmeTmcNU=;
 b=ZohpGr3P0DQKLRZfSS01NlWKM94FQx4rV6+ufGI381PoVqX2+eM4E4TfFHp1hwFZWy
 nqweyH/HMHP8JqrVrzVvpOrlSteicgH3RbbhqfKKJfksvfVt9OcLXgRVQzws10+RfbfY
 zqdJE9S/pcoAATKoiY9kTuyCeeMP3jwHd2aaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906958; x=1693511758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sFlGN5dwEYd6I+M2jRQAudIBnCMLsnn9iVjBmeTmcNU=;
 b=Kbkcxc4WwLr2z0FYZQ1f2bWIKAk1bj39sXQusv4DYpv2oO1elaqNysuc/epLUWtQTt
 aUS2VvUsi99o9A5tGaO+GLhJzPzrkTesb61r6ypgkRlz9w1BVC31/biHgwuGosa/1g0j
 LKq/7+/2lJ9ihu20RERTE+b1zwNqcc8/Xs3x8DR372DDjOWVaFEhK0Q+ZaoUQXu9iJT1
 LaOtVd6VzRJuhQgIThTrJz/KS2iwW2rL84kuK8RsTiqrBURma9JLLS2LRWL3Idnf4ngn
 pWWypl6TUwEaztL1XwCUAlWtXe/19ijg2BPKcYyvD7WC5f5ksPPDHtNz7Xjx8AGSUZDJ
 IWzw==
X-Gm-Message-State: AOJu0YyjKdkbhDsYpOH894OJseqY46WmIp9obspS3iymcefEXcGmGUWd
 LP8DjxPmmGdPFJt9B0tEj4shZy7RWLKtFIX2vSQ=
X-Google-Smtp-Source: AGHT+IHURk/nOsZoInvJ2v3KnqEhMlYj8bNOU8dmTk/kw7pcd5G2b92vO+ROyoKYZYxGru9t9bbMbg==
X-Received: by 2002:a5e:8811:0:b0:783:3899:e1d7 with SMTP id
 l17-20020a5e8811000000b007833899e1d7mr5785881ioj.2.1692906958726; 
 Thu, 24 Aug 2023 12:55:58 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:55:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 00/23] bootstd: Support ChromiumOS better
Date: Thu, 24 Aug 2023 13:55:23 -0600
Message-ID: <20230824195553.1685996-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

This updates the ChromiumOS bootmeth to detect multiple kernel partitions
on a disk.

It also includes minor code improvements to the partition drivers,
including accessors for the optional fields.

This series also includes some other related tweaks in testing.

It is available at u-boot-dm/methb-working

Changes in v2:
- Rebase on -next
- Rebase to -next
- Rebase to -next
- Rebase to -next

Simon Glass (23):
  part: Use desc instead of dev_desc
  part: amiga: Use desc instead of dev_desc
  part: dos: Use desc instead of dev_desc
  part: efi: Use desc instead of dev_desc
  part: iso: Use desc instead of dev_desc
  part: nac: Use desc instead of dev_desc
  part: Add comments for static functions
  part: Add accessors for struct disk_partition uuid
  part: Add accessors for struct disk_partition type_uuid
  part: Add an accessor for struct disk_partition sys_ind
  part: efi: Add debugging for the signature check
  dm: core: Correct error handling when event fails
  uuid: Move function comments to header file
  sandbox: Add a way to access persistent test files
  test: Move 1MB.fat32.img and 2MB.ext2.img
  bootflow: Show an empty filename when there is none
  bootstd: test: Allow binding and using any mmc device
  bootstd: Add a test for bootmeth_cros
  part: Add a fallback for part_get_bootable()
  bootstd: Support bootmeths which can scan any partition
  uuid: Add ChromiumOS partition types
  bootstd: cros: Allow detection of any kernel partition
  CI: Add ChromiumOS utilities

 arch/sandbox/cpu/os.c      |  24 ++++
 arch/sandbox/dts/test.dts  |   9 ++
 boot/Kconfig               |   2 +
 boot/bootdev-uclass.c      |  24 +++-
 boot/bootmeth_cros.c       |  48 ++++---
 cmd/bootflow.c             |   2 +-
 cmd/gpt.c                  |  10 +-
 configs/snow_defconfig     |   1 +
 disk/part.c                | 226 +++++++++++++++--------------
 disk/part_amiga.c          |  34 ++---
 disk/part_dos.c            |  80 +++++------
 disk/part_efi.c            | 281 +++++++++++++++++++------------------
 disk/part_iso.c            |  52 +++----
 disk/part_mac.c            |  59 ++++----
 doc/develop/bootstd.rst    |  11 +-
 drivers/core/device.c      |   3 +-
 fs/fat/fat.c               |   4 +-
 include/bootmeth.h         |   3 +
 include/os.h               |  10 ++
 include/part.h             | 212 ++++++++++++++++++----------
 include/part_efi.h         |  14 ++
 include/uuid.h             | 103 ++++++++++++++
 lib/uuid.c                 | 110 +--------------
 test/boot/bootflow.c       |  80 ++++++++---
 test/dm/host.c             |  44 +++---
 test/py/tests/fs_helper.py |   6 +-
 test/py/tests/test_ut.py   | 148 ++++++++++++++++++-
 tools/docker/Dockerfile    |   3 +
 28 files changed, 988 insertions(+), 615 deletions(-)

-- 
2.42.0.rc1.204.g551eb34607-goog

