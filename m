Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9FADC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 08:40:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F2F3886D1;
	Wed, 10 Jul 2024 10:40:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nKxQoqek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 526ED88702; Wed, 10 Jul 2024 10:40:19 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0652B8801A
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 10:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52e9f863c46so6599849e87.1
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720600816; x=1721205616;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1yUXwnXnBIHAjMAVld7vKUDL2EOyAJqjOKSF9cFkOsc=;
 b=nKxQoqek9GMT1mJ6CVlQd52y/0J61hWRtwWnZjXVUSjgR1YR7qxbaAUWp1DxKWd6c3
 9vW3pRZl2FiNhFYcqwxCKlCP6Ohb7y+ZxbquA6Q7wYo41L4dInE3O0/66m795ppuPZBX
 ZUi+cEB5iS4an+e6du7+Fifd3GHa35MAtHAgm1nHCbnspLpNddKHiM0INlEnUKpSN9Wn
 PcWqxZ8ao4TuJOX6RRi/Jv1bwZBs/bZ3dYy9UOGxMkKXxE5/WxYKGt4JzfOvVbYtHZxr
 Q0+kH5qw8WokM6RZQ4O6vkzpucC7E+cqAy5QoIDTKwW99MK9OWxfSPV8ijQxA8P30Pms
 MSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720600816; x=1721205616;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1yUXwnXnBIHAjMAVld7vKUDL2EOyAJqjOKSF9cFkOsc=;
 b=Rq1Lv39XOeQzvVbzFWpTd0zFg+PjXp3AGbDNXYhvpTP27jig+2Dr75VSaCnxs5Q9hx
 UIrUoXbzxq9fhrHxc+//fqbFPnt7N6ZJsEjXd5nqa4lWj/3K+vxOG9A/9UyghfAqVY0y
 LmW6wjI/j1ZHv7cW99DWm2hIGDSX4RNnvwW4VQdYfpRKTc9pTb/4o7Q+YXeTccj6Yv0Q
 m2aZRTWeKFLf/cXmR+OdBtpUj62QmGpv6hmid8UhG+ouYpj5PcV+7TWIzpDHYOhPt4Jn
 Tvywf4jFueIWEll9sZJ2+LsUW6YTi1BVRJp7SfdN1FChlcJgPQnPlN/SyQpjTD//gNF6
 0Dyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmvi+ThT8hfrO41k5wqkCqQk3eFA/iQ25bjGwqUyGaVNTIw7BKPaf04sp41I/oVoffc/hO52yM4oUCT+HgkGE355ft9w==
X-Gm-Message-State: AOJu0YzlBlN3tBV8giYpWr00IGZ9Fgz4NCSOg5hfzEBkgG9JWTo4BqN7
 HMrUL3xzxhYBc06r8jBMu548L11s/izhiPA0fuFqcJFuMca8dwk+XfngnEEuyZTX0Re63NR74du
 a
X-Google-Smtp-Source: AGHT+IHRC8vuC8pXoGtNtK+mOCSAPw1ApqEGKEvpQpTQV1q2vA3r4SQfMQtJ1kniP0OQMU01RHqSOQ==
X-Received: by 2002:a05:6512:3a8f:b0:52c:7fe3:d3e5 with SMTP id
 2adb3069b0e04-52eb99d1448mr3379913e87.50.1720600815852; 
 Wed, 10 Jul 2024 01:40:15 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427270238a6sm39994945e9.20.2024.07.10.01.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jul 2024 01:40:15 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 0/5] bootstd: Add Android support
Date: Wed, 10 Jul 2024 10:40:01 +0200
Message-Id: <20240710-bootmeth-android-v3-0-b99406e22da3@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFIjmYC/23NQQrCMBCF4auUrI2kSTM1rryHuGjSqR3QRpISL
 KV3Ny0Ioi7/B/PNzCIGwsiOxcwCJorkhxxqVzDXN8MVObW5mRSyEiA0t96Pdxx73gxt8NRy27m
 DNoBGQc3y2SNgR8+NPF9y9xRHH6btQyrX9Y3BL5ZKLrhwYNqq0rVz+mSb6UY24N75O1u9JD+MU
 v0xZDaUqTtAALTSfBnLsrwAXkS1bfcAAAA=
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14.0
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

Android boot flow is a bit different than a regular Linux distro.
Android relies on multiple partitions in order to boot.

A typical boot flow would be:
1. Parse the Bootloader Control Block (BCB, misc partition)
2. If BCB requested bootonce-bootloader, start fastboot and wait.
3. If BCB requested recovery or normal android, run the following:
   a. Get slot (A/B) from BCB
   b. Run AVB (Android Verified Boot) on boot partitions
   c. Load boot and vendor_boot partitions
   d. Load device-tree, ramdisk and boot

The AOSP documentation has more details at [1], [2], [3]

This has been implemented via complex boot scripts such as [4].
However, these boot script are neither very maintainable nor generic.
Moreover, DISTRO_DEFAULTS is being deprecated [5].

Add a generic Android bootflow implementation for bootstd.

For this initial version, only boot image v4 is supported.

This has been tested on sandbox using:
$ ./test/py/test.py --bd sandbox --build -k test_ut

This has also been tested on the AM62X SK EVM using TI's Android SDK[6]
To test on TI board, the following (WIP) patch is needed as well:
https://gitlab.baylibre.com/baylibre/ti/ti-u-boot/-/commit/84cceb912bccd7cdd7f9dd69bca0e5d987a1fd04

[1] https://source.android.com/docs/core/architecture/bootloader
[2] https://source.android.com/docs/core/architecture/partitions
[3] https://source.android.com/docs/core/architecture/partitions/generic-boot
[4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/meson64_android.h
[5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.org/
[6] https://software-dl.ti.com/processor-sdk-android/esd/AM62X/09_02_00/docs/android/Overview.html

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
Changes in v3:
- Fixed CI issues (Tom):
  * Generate bootv4.img and vendor_boot.img in test_ut.py
  * Mark CONFIG_BOOTMETH_ANDROID dependent on CONFIG_CMDLINE
  * Make bootflow_android() test dependent on CONFIG_BOOTMETH_ANDROID
  Because of the above changes, I've removed the reviewers on patch 5/5
- Link to v2: https://lore.kernel.org/r/20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com

Changes in v2:
- Dropped patch 2/6 boot: android: Add image_android_get_version() (Igor)
- Fixed multi-line comment style (Igor, Simon)
- Added dependency on CMD_FASTBOOT for BOOTMETH_ANDROID (Igor)
- Fixed various resource leaks (Igor)
- Fixed bootmeth_priv dangling pointer on error cases (Igor)
- Updated test instructions in commit message for patch 6/6
- Added __weak impl of get_avendor_bootimg_addr() in patch 1 (dropped
  Igor's review because of this change)
- Added extra info in Kconfig to detail MMC limitation (Simon)
- Fixed typo Bootmethod->Bootmeth (Simon)
- Documented android_priv structure (Simon)
- Demoted various messages from printf() to log_debug (Simon)
- Fixed some lines too long (Simon)
- Added function documentation to read_slotted_partition() (Simon)
- Added some doc about avb extra_args being modified (Simon)
- Link to v1: https://lore.kernel.org/r/20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com

---
Mattijs Korpershoek (5):
      boot: android: Provide vendor_bootimg_addr in boot_get_fdt()
      bootstd: Add bootflow_iter_check_mmc() helper
      android: boot: Add set_abootimg_addr() and set_avendor_bootimg_addr()
      bootstd: Add a bootmeth for Android
      bootstd: Add test for bootmeth_android

 MAINTAINERS               |   7 +
 arch/sandbox/dts/test.dts |   8 +
 boot/Kconfig              |  17 ++
 boot/Makefile             |   2 +
 boot/bootflow.c           |  12 +
 boot/bootmeth_android.c   | 553 ++++++++++++++++++++++++++++++++++++++++++++++
 boot/bootmeth_android.h   |  29 +++
 boot/image-android.c      |   5 +
 boot/image-fdt.c          |   2 +-
 cmd/abootimg.c            |  10 +
 configs/sandbox_defconfig |   2 +-
 doc/develop/bootstd.rst   |   6 +
 include/bootflow.h        |   9 +
 include/image.h           |  14 ++
 test/boot/bootflow.c      |  68 +++++-
 test/py/tests/test_ut.py  |  79 +++++++
 16 files changed, 818 insertions(+), 5 deletions(-)
---
base-commit: 475aa8345a78396d39b42f96eccecd37ebe24e99
change-id: 20240605-bootmeth-android-bfc8596e9367

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

