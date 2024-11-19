Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C29D44146
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:37:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382868952A;
	Tue, 19 Nov 2024 12:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="m1v/KKvP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1B08955C; Tue, 19 Nov 2024 12:37:50 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB728894FD
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:37:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3824aef833bso1205659f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732016267; x=1732621067;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R4B7InArHQu0ADiydUZLTVxC1H9B3Rgd/GxItu7hDcI=;
 b=m1v/KKvP0rD7E+WgyflCnW0MzUoCA8zt2rVE4L9WW6s+FWT2pay5x3hyWN1/k7jeax
 uazODVCJ+chLm3Te8DsL+HAIqZRNZjFeUuyp106XdbRTDU+KBDf4kGosS603k+nuPv+C
 FG9XCMUpBB4sAOO2e/o8mqls0U1svHf4qU5kWrsQMgXcDGuVFJNOjW0XbZzQzJSM6tvq
 +WrXG0UzSzcAhealX9pXnxpFD/ZGZSIjJWy9JKLeuFZ7etQaOqxhHeUcvRZcw+6COiHY
 k6rNN5S3JwrEs3epmMAW24IEwyXylLYXWJvyJG2oCp4RgiZ+ObWslHZFO6aNfZT5aSWe
 lJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732016267; x=1732621067;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R4B7InArHQu0ADiydUZLTVxC1H9B3Rgd/GxItu7hDcI=;
 b=qtPPytw6KZCHgC8lJdCDbE+Wq6kpkvbgkHxEc3qgQbop7uiunknU7JTGgWPWtyC7BO
 Oi7b2bRC2uwabCzc4hlyGFnZWB4Wo5xU+1VC/iW01IYY2l1tsO+ecTUvczSt096K1BTk
 2j0mbJcecTB2lpKXG9JXDA9ZsiOwmob4TVtCI9otN1Qev9DQNNBiVASABLm3gWNeecU7
 UoPM8Y8ZgmTW+rQiQ3FsF6xJy+mF9QtZn7gtjdf3xQwk1PaN4l11BF82ClIRKDh+RY5p
 BAfij4ZMM14R0uFetIocmh4SeaJQyCpSO9T7oxNhEHevGhG/qsrhhZlZh1IPbSTSAtK+
 DO9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXppP021wRB2eD9pSHzO2Ibwsl7U8j9yBSiV3iEE6tJ6nl/V985QOSatjSMqt6IYPu3oe0HqKc=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8kIo5FXNucKLdOX0lXnojaFFk5ybTUqC5DZcBckP5EdLZViCJ
 N3Yw3olIVke2qGvsM2Bg8XUwgGzSgj0Is1bbCBNxYuA0+B0wnCzuOryBuhAf8mo=
X-Google-Smtp-Source: AGHT+IEl9L8wStCKHPWYefOQya9aVXw0r2Kl7gSfRgCQF/LbioEz1c+jtJuPnNg2k1eAqVXDK55hOg==
X-Received: by 2002:a05:6000:1568:b0:382:4926:98e6 with SMTP id
 ffacd0b85a97d-38249269a44mr5093987f8f.55.1732016267318; 
 Tue, 19 Nov 2024 03:37:47 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:cc39:27ba:4c6c:3c84])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3824259dda3sm7580388f8f.77.2024.11.19.03.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 03:37:47 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Date: Tue, 19 Nov 2024 12:37:37 +0100
Message-Id: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIF4PGcC/12Oyw6CMBBFf4V0bU2nRWtd+R/GRV/IJEq1YCMh/
 LsFYyAu782cc2cgrY/oW3IsBhJ9whZDk4PYFMTWurl6ii5nwhkvgcGOatfEgC5xqhk4q/dMSSZ
 Jvn9EX+F7dp0v3xz985WV3VLW2HYh9vNegqn9qeVKnYAyKg9glVCKcatORvc3NNFvbbiTSZT4A
 gOUa5hnOL9qqsqAkEL/weM4fgAIW/S09wAAAA==
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de, 
 u-boot-amlogic@groups.io, Guillaume La Roque <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

Actually bootmethod android only support android boot image version 4
and with AB image, some old platform wtill use android boot image
version 2 with AB or without AB slot.

This patchset add support of both version 2 and non-AB slot images.
It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC

patchset was tested on khadas VIM3 and VIM3L with AOSP main branch and
android-mainline kernel and with TI AM62P with android release provided
by TI.

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Changes in v3:
- Remove gpio recovery stuff not needed anymore. 
- Link to v2: https://lore.kernel.org/r/20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com

Changes in v2:
- Drop patch 3 (configs: khadas-vim3{l}: fix userdata size) already
  applied 
- Apply Tested-by and Reviewed-by from v1
- Fix comments
- Revert malloc/free for slot_suffix
- Remove vim3/vim3l stuff in meson64_android.h 
- Link to v1: https://lore.kernel.org/r/20241017-adnroidv2-v1-0-781c939902c9@baylibre.com

---
Guillaume La Roque (5):
      bootstd: android: add support of bootimage v2
      bootstd: android: add non-A/B image support
      configs: khadas-vim3l_android{_ab}: move on bootmeth android
      configs: khadas-vim3_android{_ab}: move on bootmeth android
      bootstd: Add test for Android boot image v2

 arch/sandbox/dts/test.dts                 | 10 +++-
 boot/Kconfig                              |  1 -
 boot/bootmeth_android.c                   | 78 +++++++++++++++++++++----------
 configs/am62x_a53_android.config          |  1 +
 configs/khadas-vim3_android_ab_defconfig  |  7 ++-
 configs/khadas-vim3_android_defconfig     |  7 ++-
 configs/khadas-vim3l_android_ab_defconfig |  7 ++-
 configs/khadas-vim3l_android_defconfig    |  7 ++-
 configs/sandbox_defconfig                 |  1 +
 include/configs/khadas-vim3_android.h     | 25 ++++++++--
 include/configs/khadas-vim3l_android.h    | 25 ++++++++--
 include/configs/meson64_android.h         |  6 ---
 test/boot/bootflow.c                      | 29 ++++++++++--
 test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
 14 files changed, 206 insertions(+), 47 deletions(-)
---
base-commit: ce427e40a2422b75374ee3404e3f5c6536e8984a
change-id: 20241015-adnroidv2-a01dca609707

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>

