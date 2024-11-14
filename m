Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E692ED6A235
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 21:30:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9358969D;
	Thu, 14 Nov 2024 22:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lnnpXwsH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 794B289693; Thu, 14 Nov 2024 22:29:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8BF88E00
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 22:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37d495d217bso880783f8f.0
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731619794; x=1732224594;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RjN3qlgGFfhL4mVwuA/OEAAvF6xy8UbYiYCvSsUW5+8=;
 b=lnnpXwsH4DBMe7G0rXleiEbCMEzzbYlf4r/X5OKrYz4tx0dU46WS7spNU0f/hwKaIF
 6pyvhbZWwVoy+lgHWV7rsNK8s57rU/8FzThVfT2Ob5zcYmgC8JYuneXdtPFW8/ZDhP5E
 zEoVoyo66ZmW/9hzrc93qquiMenG3yV3hbVXxkZplxYTGdvMzUj8yEK+bgUA1XcMoRa/
 7lPkjTKRo5rHOXUZ0JxssPiPDPeD8FBhwzBAVPDfW1JxaXGVCWDR4+xQ2GYvjlNhGt/W
 LlrRNtI89eFLpvoNpwHonFYxVsg60m9lUEAYpPvviqZbcfH1JKxqkXp7BMe6feaYT8bL
 3TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731619794; x=1732224594;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RjN3qlgGFfhL4mVwuA/OEAAvF6xy8UbYiYCvSsUW5+8=;
 b=ASKGLpETEDMZyzP/JZTTsBG7U9Q6lM/uJcHcmbcyedCSQpDg1BTWXSPJphUyDEE9rn
 DuEufqhIqpn6RHngPiPsRrU91TEbBLh0TcXslyoGogYaFPnrTd3So2/Hr9D8QTNqqAKR
 mF6+qimVXKkYaFSnpX35rh2grL447JHr98J6R/ugP3AywogYeX7PgPBQZS8V0fZr+Zpf
 3vd1QL1glSKLUpK/xVE5eLNgqBGnJ1956/8tNCjLm89OBaG+yquKAjbre6B954QPOIws
 OcBV03huKs/FCjpW4YjMKlUmG8vziS9YABs4eualgoBNUAHAFVSqirVtiXO443Zf/8Gj
 LRcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe7ibtrvAB17LuyaZd82l2kjkv6KjjzF/1qxCVbCVBFkVyyYqVBtCs5mPIFL5N++W6wOc901g=@lists.denx.de
X-Gm-Message-State: AOJu0YxpjrAe7Pr1iITHgWFZ21b+pQn5ZljZvD1gBQQdycirX98P19tK
 m8It16LcBrN98VCzRdsIoZWhEI1OSPxbruXynJYQuaZWAKlT+zM+neCL7Tg00+s=
X-Google-Smtp-Source: AGHT+IEkIpw1ZEX9yT+w0svWDyxf20o1KQv18adjSSn6HL2sPd1WARXjXmP7/q6zSkO7GjGesqG83w==
X-Received: by 2002:a5d:64c7:0:b0:381:d890:b5b7 with SMTP id
 ffacd0b85a97d-38225ac47famr231167f8f.52.1731619793619; 
 Thu, 14 Nov 2024 13:29:53 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:89e8:c8e2:1fe:645])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ada3febsm2459782f8f.19.2024.11.14.13.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 13:29:53 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v2 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Date: Thu, 14 Nov 2024 22:29:43 +0100
Message-Id: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhrNmcC/02Nyw7CIBBFf6WZtZgBH4gr/8N0QQHtJFp0qMSm6
 b+LNUaX5+Tm3BFSYAoJ9tUIHDIlil0BtajAtbY7B0G+MChUa4lyI6zvOJLPSliU3tktGo0ayv7
 G4UTPuXWsP8zh/ijJ/idbSn3kYf7L8m2/af2XzlKg0DvpzMoYVM4cGjtcqOGwdPEK9TRNL1pl9
 JW6AAAA
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
 include/configs/khadas-vim3_android.h     | 26 +++++++++--
 include/configs/khadas-vim3l_android.h    | 26 +++++++++--
 include/configs/meson64_android.h         |  6 ---
 test/boot/bootflow.c                      | 29 ++++++++++--
 test/py/tests/test_ut.py                  | 49 +++++++++++++++++++
 14 files changed, 208 insertions(+), 47 deletions(-)
---
base-commit: ce427e40a2422b75374ee3404e3f5c6536e8984a
change-id: 20241015-adnroidv2-a01dca609707

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>

