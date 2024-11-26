Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ED3D5A6EC
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:07:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B4B189C14;
	Tue, 26 Nov 2024 09:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aRCibk9G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A25D189C0F; Tue, 26 Nov 2024 09:06:58 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633AB89189
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:06:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38230ed9baeso3743744f8f.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 00:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732608416; x=1733213216;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=68mSnIrNtR068OZSgD0LLYKHzK2yliNfMsp4/Ndr0Jk=;
 b=aRCibk9Gla8aerVvZqFirs09RFMPVmMccIcWdbrdBEN4v5D2o/WDKOCBDW9jroy3sm
 jM1iEe6D4SAB8PIcDy52Q70L2GxATKk0De/xqLaLh5nQ2jzvnLHLv/0i8sayyne7ChsJ
 gLYo7EpYBw4K2aZ+lTIyiNvqrsxZjRYLfLjllZpW9pPbAd/trz04ANcTvf2WXcp5k+TT
 dS+iPLu2Qwv8QEWUU7AWdNSg+vNBPeP8+l1d75D/kxWCYItFo6GHLDb1SZYNIOIX5RMv
 fx22VoY2iHyqIAd6QHLBP4HHgW/KPLFobMtKiHB1SlCjuVO545iT7bIx6/7uuNZimNQs
 0UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732608416; x=1733213216;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=68mSnIrNtR068OZSgD0LLYKHzK2yliNfMsp4/Ndr0Jk=;
 b=NC6nbk3WlBjIXv9zTNjT0mZxX2C5dQKHkxZYFbGLiUg2PyCDbRsO5K8PpFXZw2dbl4
 z+RNPk5QFPxc8D29/Ka8eqIFCVD+EgtBVVdkyJ/VN4iSyPqZoVmtXMCFruN7fUUbYlR1
 eIl5YKkSed4Tbz4kfE0MLFcE03TOvdmoOjbWJXpbyoHfHmHppCGofE8BaMEsudt9zDwW
 7E5PGJX8NSLMgPi4GNPhLjyyVCDTdB8ptnA26MVsg3rEFWmv+V/0GAvqtBkfZJzeTi0z
 WH1QT9OLEjEh+QPLle59fYBJotBX+dZ5fUBT2W7ayzoNdjfSL7y856mHCGN4hAwX7r6l
 +XKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX05NMh11ngkuX7Mc2EaZ6Rlt+IweQUb5ynrA4bI4/vh5jsasj5sVxC15gQwDXstHamnBRtO+Q=@lists.denx.de
X-Gm-Message-State: AOJu0Ywb3Kkbsy2GTe/Y+qzlvuud3ugjwU531rWiE0ndz+gplU2sRdaD
 bz8z9tRDHtXN71woDnCZcANfg7hFQjDSJFSrMDr+pYIXgjAA3/EyOLepNPUwbdM=
X-Gm-Gg: ASbGncvWD0PKAm2Is+7i6Cd8Y4zjiA4OXrGy48qfs75Dsw2j8XLbDMozXUliex+64h+
 BLbowS10XNnOX0bovRyNqiPNjM8mLkUK19hZEnyVsoy2I0TZndIUoDVMZH6SOpt8+FItLBqTJLm
 MqVeuJx+mwoXkx5oM87N8ogu3o/Tdwy8fmnnXCrJpTd7c/3gKYMOSs+WjcZ1sL+c7WTQK5k1y7y
 fjE8ZvdojhBkt7j15v7Rk4R3bi0YyYx7/URmrNpCLEEKGGFKBYVKg==
X-Google-Smtp-Source: AGHT+IGyhWEcUhR9tXD639AoAocVALAu2ClfLCEW8FGvMLBTFP6AWFm8dzO6KvPO9zuYMB70MezViw==
X-Received: by 2002:a05:6000:1ace:b0:382:40ef:4319 with SMTP id
 ffacd0b85a97d-38260be4e03mr13926752f8f.55.1732608415845; 
 Tue, 26 Nov 2024 00:06:55 -0800 (PST)
Received: from [127.0.1.1] ([2001:861:d40:ed60:86be:4d54:1784:8cf7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb36612sm12513102f8f.59.2024.11.26.00.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 00:06:55 -0800 (PST)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v4 0/5] Add support of Android Boot Image version 2 and
 non-AB image
Date: Tue, 26 Nov 2024 09:06:08 +0100
Message-Id: <20241126-adnroidv2-v4-0-11636106dc69@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHCBRWcC/22O0Q6CIBSGX8VxHY0DKNJV79G6AMRkKyk0lnO+e
 2hrutbl/+98339G1NngbIcO2YiCja5zvk2B7zJkGtVeLHZVyogSyoFAjlXVBu+qSLEiUBlVECm
 IQOn+HmztXovrdP7kYB/PpOzXsnFd78Ow7EWY269abNQRMMGiBCOZlIQaedRquDod7N74G5pFk
 a4wAN/CNMHpVV3XGphg6g/MtrDcwizBPNdK8bKoNYMfeJqmN4TxDMM0AQAA
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
Changes in v4:
- test: fix test after patch done on it by Mattijs :
  https://lore.kernel.org/r/all/20241123024300.GY3600562@bill-the-cat/
- Link to v3: https://lore.kernel.org/r/20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com

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
base-commit: 48380f9b2a12e3fc6339d6af5a154bded769d911
change-id: 20241015-adnroidv2-a01dca609707

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>

