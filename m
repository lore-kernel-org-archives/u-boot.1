Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7E7C27C75
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 10:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4690D888DE;
	Thu, 13 Jun 2024 12:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fzN3I06C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC8F888E5; Thu, 13 Jun 2024 12:13:34 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6050B883D3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 12:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-35f2c0b7701so520030f8f.0
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 03:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718273612; x=1718878412;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8pe2DmHZFec7+U1q+pm2c6pHF42jBGg87NoIPPRAQyY=;
 b=fzN3I06CeCCO6sy9rMFFnS5mBUmaOmMj08xlSD1c61REb8aNUQQgZzaIlWbqfK79lg
 o7y5XPqjH2dEZSbpX99EQTz3k6rnAJGIx173Q64AMgJ2XuULmsVqP94yEv7r+Z8c7jQW
 qpr1vX+cmSzkb0M0S3q27Z5AR9FY+c/l796BfmOUNOMhOPxfXIT1W73ta6Fm2CFUJvCL
 rRvhmqjSwGBS6/iuLUdA7boGrWfe5nemVQ4ex33s1aw0NPDDsviRcGM6ws3j4LPSwh/z
 qTTf78b2Nwy5Ix+yowB79DnaMc1smeNkUqj7IIJ5V8LHKjNmCsSVHZFzlzzu5Te1jBX5
 ailQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718273612; x=1718878412;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8pe2DmHZFec7+U1q+pm2c6pHF42jBGg87NoIPPRAQyY=;
 b=dqiyWKc/6yUriWQyHljmjHn2tT22ngJ+kG8aHzwnsrUCRtpVh99urDU1ryWhfNGyUF
 LEX5nORKigoQp+Q5m39cevmixhW25dbvbIGxDkirQDHnfaAcpESsZ+ZFN4S18zKlJUUo
 GkyXeuuwy3ZKibo0TmRp+GQuKnBuUHgHCKbCOTfaXALoORr94AKBWQbZEueEJJ56AbJZ
 ZOILL5fBNHRV2aYYZK+BHXViETMOioX1tnGCtgAEOCHkxbDxh3TIyr1F9kifsB4orqEa
 Np5KgqIv96CWXGOOXo/jl3ypLPwo+L/hosrP9SLPQ2zrR3caZam15jPH0rbuOpufb0Iq
 p83Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXovvfrwINHMzsoqF2To4jCY3qA9TUZq1cN1Qna6uqxvUNOjH+Vz3dsvtQoq+MFtjpV+1lQIee/uxaPTNbUeJnRlVIZKg==
X-Gm-Message-State: AOJu0Yz0ZByMZvCTrZDfV8v191LB93B1hBtfrIePmKIufb9hKMnCjctT
 gCFXyJmweDd9WGEbsIOWB0+rZ08ny4qQEU4i8v0w/ofJXgSQctq8RsMwWvgQNtg=
X-Google-Smtp-Source: AGHT+IH0syiJZo8MCfdYo/eLD/c6pOV52wXIWNe0BbSRXZjKGqEsPwwwkdxJsAFTRqk6Yku5U1dTCw==
X-Received: by 2002:adf:eccd:0:b0:34c:77bd:2508 with SMTP id
 ffacd0b85a97d-360718d648cmr1751584f8f.11.1718273611736; 
 Thu, 13 Jun 2024 03:13:31 -0700 (PDT)
Received: from groot.home ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2295sm1251573f8f.82.2024.06.13.03.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 03:13:30 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 0/5] bootstd: Add Android support
Date: Thu, 13 Jun 2024 12:13:07 +0200
Message-Id: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADPGamYC/2WNyw6CMBBFf4XM2pqCtFhX/odh0ccgkwglbUMkp
 P9uJXHl8pzknrtDxEAY4VbtEHClSH4u0JwqsKOen8jIFYaGNy2XXDDjfZowjUzPLnhyzAz2KpR
 EdZEdlNkScKD3kXz0hUeKyYfteFjrr/3F5H9srRln3Erl2lZ01oq70duLTMCz9RP0OecPCf9oj
 LMAAAA=
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
 boot/Kconfig              |  16 ++
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
 test/boot/bootflow.c      |  65 +++++-
 test/py/tests/test_ut.py  |  76 +++++++
 16 files changed, 811 insertions(+), 5 deletions(-)
---
base-commit: f9886bc60f42d5bcfcfa4e474af7dc230400b6be
change-id: 20240605-bootmeth-android-bfc8596e9367

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

