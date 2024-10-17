Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C223BD21271
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 16:10:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA4D89068;
	Thu, 17 Oct 2024 18:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MEo7OA4V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62A2989068; Thu, 17 Oct 2024 18:10:50 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D06B988D5B
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 18:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4314a26002bso12439985e9.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 09:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729181445; x=1729786245;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i/6g9QE3f+WP55Ncpx5cM2zPhfavAXgJcyJU+2FsYcI=;
 b=MEo7OA4VinKyItYjd+Ia7aiC9D0IDaHPsRU+UFMw7KR/Xm+UW/GwrHbQ7E7L+zAQ3E
 iTJaP9Wewy/luEdT/oebWu/EcnqIK766ZGjJnLwhCkKi5mg3T2w+gd6dNIR70pcT+QBh
 7R9akskZgVBH8r2Z8301S3IBUhyDMi2Amws/6auGltJ4bhz8FAOH7HfpXvF5MmXKpHo1
 89ubsbq7OK1DttIzVkaAhYOC4mbp3DaBUcuV3Rw82t++68qfXOQ8SOcDOJNlJkOAtkni
 QBdezZUGYPX47PjcahIcOulyvbwG6u3xBybt9zXfzICl9xKJT2Ox44JS9qyN1OngRhx4
 KAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729181445; x=1729786245;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/6g9QE3f+WP55Ncpx5cM2zPhfavAXgJcyJU+2FsYcI=;
 b=wBjJMjkNGwS2FdvtBDdcEKNgqUBbAc2nC2LgbxjM4d0vGEzWN2VT9nc2h0ppE/C/VK
 +P9MvjLlR2sEHOqB1wtttGqc8NbRzWyCJtbGeIcaaRq8cpkYwSd47ntPjvwBBIN0YUc5
 2ZeHQtO2gaG8uxCiwRPl+IrbfWIRWfTjlMxLx/WhIWAItiJE3XwNPmhpM/TgLMaWP0Zs
 fYrP8nGZ2TJlYUY/Lmv6hYdkqDtYZC/bLf3cqLNZuEXDnggvrxJhdbaZZUOR3I0CQL/d
 ULsECCpwj5JWj42sAC3fbAbm89zCDN8way4GEYJe4ymrSwXEOJiaQFJ0rJTZerGomFhr
 xzBA==
X-Gm-Message-State: AOJu0YzmRKkYFHssx3xhoZqheKKtfjg7AeNMr5MhUSYae4/fGvqCgLxi
 umiPJk7Nkvp+hjBhJbpI5lnGXSR/fbmc+DmoqZ5aYtResNzX8IkXu3vW5LSgqv7gOznn5I3Gqmm
 8
X-Google-Smtp-Source: AGHT+IHbE83aCpnHHzxRLlCjwThlkUFut0WEG2Sso3O1TvVSLZ9HJQjBXE0E1rzyQrCkLJzczPNP5A==
X-Received: by 2002:a05:600c:1d94:b0:42c:b1ee:4b04 with SMTP id
 5b1f17b1804b1-4314a38157emr62678055e9.28.1729181444757; 
 Thu, 17 Oct 2024 09:10:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:4754:2b9f:eb4f:125])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc42160sm7653993f8f.112.2024.10.17.09.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 09:10:44 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/6] Add support of Android Boot Image version 2 and non-AB
 image
Date: Thu, 17 Oct 2024 18:10:24 +0200
Message-Id: <20241017-adnroidv2-v1-0-781c939902c9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPA2EWcC/23OTW7DIBCG4atYrDsR4PgHr3KPKoqGYeyiBpOAY
 1WKcvdip8suX4Se+Z4ic/KcxVA9ReLVZx/nEuqjEvSF88TgXWmhpT4qqRpAN6fo3aoBpXKErTS
 d7ET5f0s8+p/d+jy/O/H9Ucjl/SgC54w7OVR/YAc4uw28oL0EzAsnWBuQcKztSCRN60xzynh9L
 OzKPuJ8oBi2e/9qS7x5grFANsYF9kEQvrfwYYIyWwLVRndKamdqdbr6GVM8xDRtpsXMUPzgl6E
 yrMjpUZPt275trCUpNTvTKpSmoQ57S2R6I86v1y++TgRsSQEAAA==
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com, 
 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
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
Guillaume La Roque (6):
      bootstd: android: add support of bootimage v2
      bootstd: android: add non-A/B image support
      configs: khadas-vim3{l}: fix userdata size
      configs: khadas-vim3l_android{_ab}: move on bootmeth android
      configs: khadas-vim3_android{_ab}: move on bootmeth android
      bootstd: Add test for Android boot image v2

 arch/sandbox/dts/test.dts                 | 10 +++-
 boot/Kconfig                              |  1 -
 boot/bootmeth_android.c                   | 80 ++++++++++++++++++++++---------
 configs/am62x_a53_android.config          |  1 +
 configs/khadas-vim3_android_ab_defconfig  |  7 ++-
 configs/khadas-vim3_android_defconfig     |  7 ++-
 configs/khadas-vim3l_android_ab_defconfig |  7 ++-
 configs/khadas-vim3l_android_defconfig    |  7 ++-
 configs/sandbox_defconfig                 |  1 +
 include/configs/khadas-vim3_android.h     | 31 +++++++++---
 include/configs/khadas-vim3l_android.h    | 33 ++++++++++---
 test/boot/bootflow.c                      | 29 +++++++++--
 test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
 13 files changed, 219 insertions(+), 44 deletions(-)
---
base-commit: 9e1cd2f2cb86865bbc002ed961a095c7a8bcc989
change-id: 20241015-adnroidv2-a01dca609707
prerequisite-message-id: 20241017-android_ab_master-v5-0-43bfcc096d95@salutedevices.com
prerequisite-patch-id: 2741d3997913068fd4ce70645feaf67036adf401
prerequisite-patch-id: 3aee9fe1151f7f358c37dd18068f2270cfd11bf9
prerequisite-patch-id: d43a2bb0407de9b4d76464f5edc7d08eecb6e637
prerequisite-patch-id: 887f326fb6118f3b032f843d4f9edd382a0f3e8f
prerequisite-patch-id: 51498bd770f7fe82cf6954ba61564cfd4644aace
prerequisite-patch-id: 93d7bac8e10fad672833df6647f346cfce38f008
prerequisite-message-id: 20241017-topic-fastboot-fixes-mkbootimg-v2-0-c3927102d931@linaro.org
prerequisite-patch-id: 03ee7fe890d6cc5734ba5950fcda820466f9eee5
prerequisite-patch-id: cdef2f4a68a8ae2eb4ffee5467ef45d1638e5266
prerequisite-patch-id: 93aa15770f62ff17e55b74480456cf1f305de65e

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>

