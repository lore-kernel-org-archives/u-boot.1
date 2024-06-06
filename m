Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F4AC25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 12:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2F018842E;
	Thu,  6 Jun 2024 14:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T4ACf5/s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4569588428; Thu,  6 Jun 2024 14:24:19 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E4D8823C
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 14:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-35dc36b107fso874785f8f.1
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717676656; x=1718281456;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I60JXyCBdLlIY7wrqjkt/ShcWvIMOsipdW9NXKaidwU=;
 b=T4ACf5/s7/JKe3Xz4PxIX//eBttO2X8HuikdAJv9w9GsBXO9wiIcjE2fNrcOEciP3h
 c7f9ojkiCADzBGyJbgNaIMnLSZckHqz3/nUYQoKn6U90VeITTNlBF79pqE5ahgmMhxhd
 /k3+9qa9zDNK4mq1+vqK/1Ur/eUeHk8btdU7C69i7XsO/jF//iSsdjMJNZbf3rVwvSWU
 WBNmlOA2gly3zHEfAMPmBBEVnprCQcwZTa1s0o1H5Gs50hAPAUs3ejPRKMHpAPz7+9ZB
 NVV0HoJN1Ic58K+xUyMx5EUchFCDfTo1AdsdhYtv0aNjWFF3IcqYzl5kCNakEttpiziR
 YoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717676656; x=1718281456;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I60JXyCBdLlIY7wrqjkt/ShcWvIMOsipdW9NXKaidwU=;
 b=LxVrJ73Z2oOtX199zt7xaj4FiMkFUkUcGROvD/2EZAKDkByAOhSWgnLFTlBLauHXvx
 gC91xY2yusUnLo24mHnExqZMCOeldPNDgCrcMtCW8GkAN3UawCLwNfUP/zoWEN7VPIdL
 CGAhAmQNgtNVlK7eQiGJvboPHscCCeb6U6qnlLFpNyveWMnuE7F3EB1FLGhuzZjz4xHM
 aqnOet9+cDJoHg+Z34H+2O6FMdYzsny5/ihNn5auZsrqiv5kWL99q2nKBNsfR+naWV5C
 w6FiponG+HwUUtwRQ1+sW4877BfKx5fDaTiOHmuGElv5P3XL7YOkQhuk9rBXgApHPkLm
 oKJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUK/REQthEMpqAP8UBIW9oFLAzYh90JXff2zqDMs5tHpJ4bBrs+o+L3es6zLz+RtKfSIY/bKj35DOHzVyHSjB3g2ewQXw==
X-Gm-Message-State: AOJu0YzV2eIfuTh8Ckl/6N+ZZcL1NVgzjrNl6bTyjuMTBJkuhFf/ikjl
 l6n68tM7i8kcJMe14jNR+iScoyBo0vGPqeGn2b+eeDpPogy1YXMeMDggGNBYCVA=
X-Google-Smtp-Source: AGHT+IFmrOAdVSJA6E33uvwvltxug/CT+6w7NEJpZnDnnVmoDeNzG16FnVmzB7awG2q1fsKExc5luQ==
X-Received: by 2002:a5d:5547:0:b0:354:f802:f3a6 with SMTP id
 ffacd0b85a97d-35e8405818fmr4275560f8f.9.1717676656169; 
 Thu, 06 Jun 2024 05:24:16 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5d66d01sm1432828f8f.50.2024.06.06.05.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 05:24:15 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/6] bootstd: Add Android support
Date: Thu, 06 Jun 2024 14:23:52 +0200
Message-Id: <20240606-bootmeth-android-v1-0-0c69d4457cc5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFiqYWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNT3aT8/JLc1JIM3cS8lKL8zBTdpLRkC1NLs1RLYzNzJaC2gqLUtMw
 KsJHRsbW1ALqRJj1iAAAA
To: Simon Glass <sjg@chromium.org>
Cc: Julien Masson <jmasson@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Dmitrii Merkurev <dimorinny@google.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
X-Mailer: b4 0.14-dev-d4707
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
Mattijs Korpershoek (6):
      boot: android: Provide vendor_bootimg_addr in boot_get_fdt()
      boot: android: Add image_android_get_version()
      bootstd: Add bootflow_iter_check_mmc() helper
      android: boot: Add set_abootimg_addr() and set_avendor_bootimg_addr()
      bootstd: Add a bootmeth for Android
      bootstd: Add test for bootmeth_android

 MAINTAINERS               |   7 +
 arch/sandbox/dts/test.dts |   8 +
 boot/Kconfig              |  14 ++
 boot/Makefile             |   2 +
 boot/bootflow.c           |  12 ++
 boot/bootmeth_android.c   | 522 ++++++++++++++++++++++++++++++++++++++++++++++
 boot/bootmeth_android.h   |  27 +++
 boot/image-android.c      |   7 +-
 boot/image-fdt.c          |   2 +-
 cmd/abootimg.c            |  10 +
 configs/sandbox_defconfig |   2 +-
 doc/develop/bootstd.rst   |   6 +
 include/bootflow.h        |   9 +
 include/image.h           |  21 ++
 test/boot/bootflow.c      |  65 +++++-
 test/py/tests/test_ut.py  |  76 +++++++
 16 files changed, 784 insertions(+), 6 deletions(-)
---
base-commit: 227be29df37545f74243a98c12a4a33c4160e3cd
change-id: 20240605-bootmeth-android-bfc8596e9367

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

