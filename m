Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E15BD3B98F
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:26:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E39B889700;
	Tue, 26 Nov 2024 14:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wVFhjfdG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB2D89680; Tue, 26 Nov 2024 14:26:48 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1358973E
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:26:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43497839b80so23510965e9.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732627604; x=1733232404;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=O92NB/UMO/Jh+pdNDJvs2hDdW61m5uHTYQMYcI4vG0A=;
 b=wVFhjfdGHAKF1gsZIOfaGGj5SOxBobrJ3r/D7sAD+FlvIwL6ku3C/3ya1yQltA9xjH
 NbAARENPw7RVI3IKsnZiLDRQigxtAl0fkiFRlLB67//uG8vPVSTBYG0F3MXgre9UBtH7
 hkTgyQYG9mB/zPGVZZMUsh1AO0mHgeZBINJXY/EEBTrDq4FlQQE/2YpwdQgNu9ZmKFGl
 ZMhcHnQnH44tdTubB9MPW+8Zm+LCuDcgJDzcbe7jqxk08Cc09CxdVh6R2xjD7PSC/CpZ
 Gvm/GlBeb3CL+fg9NRpbTVONWerMPOuBGSNlRMQ4x552XdMiEV2rDxDkXpb+nFbm6MX+
 1O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627604; x=1733232404;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O92NB/UMO/Jh+pdNDJvs2hDdW61m5uHTYQMYcI4vG0A=;
 b=BCE3jiQ0ZV4RMPT9bS5guctd9k6bUVnLvD8K82hQeZCeqeN4uYgUlUimjn1C3lDTaL
 EIcY7VmaiAGbCeutdC6/G0BKiVW1kKQH5W0RAbGraxvoOWKOAekklGNmdM9AAyQPEPur
 FPHAgiKWWyjG16QhBBW9Zcf00RFaJL3CrRfurB8xz0fUWUsfDhnfzRThbfAjOHrAnifn
 UeoK8bPt3G9B8ktl2QMfribCuQkXV6zxKVsx4UHLfnj4SoO4IR5cZivamJz03lRsSlfp
 ZpgKTPIkur2a12CrUGNk3GhrnL2515re/bO8fbafnkPDyRno711xOaWLP49pR8iHf0WD
 4r7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCuCYQ2QZ1v+3+tQSxc2J1oyCS94eTF2wUiLn+s/M3VTVPfe3sEIxlENoM63hpQEE/+vmVaTE=@lists.denx.de
X-Gm-Message-State: AOJu0YwDHVVv0+LKXGVZbKOb3yLEqfIJZw+GUq+helUxYTfBuO7Z6gW4
 7AiXno0Tb885EdzKYg8BVX+dCk//nBQ7hQqJdGMpoEeBjEWLdMrfNRDK8N2GaOw=
X-Gm-Gg: ASbGncu2loUOl83FKNj3w1IKq2peTiI11CjyArdFK1MfiQxwiMK1nea0e/WDxBIQZ2R
 I3UfzuFWP+fjSJNsJJlMX0zItzJnNc6MyE5y84qjJNItgrrgdhF63HEFnzl4HGqNehDxD84/pvq
 k6FHA0oyxtRub8/lwtWfvv+du9Ybu1vtJP27kxF51SSmLnJa0TVj28Oa5oO/srDlQzz1hY1B7x4
 uSK1Y6sVHMnflDZ/r8S+YZPE/Wqj+hM9Xor1IPGb9D9NCgfhxTHKA==
X-Google-Smtp-Source: AGHT+IEl+iN2Kivah1mCQs/1LyUlmtvC/Qd4EKFLUrFl29QRYaFTYtfaF1YC5QLP+lJ5Tz/gSSmtJg==
X-Received: by 2002:a05:600c:4ed0:b0:431:55c1:f440 with SMTP id
 5b1f17b1804b1-433ce4d4ad0mr158490285e9.30.1732627604254; 
 Tue, 26 Nov 2024 05:26:44 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463abb4sm235438755e9.31.2024.11.26.05.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 05:26:43 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Cc: Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Julien Masson <jmasson@baylibre.com>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20241126
Date: Tue, 26 Nov 2024 14:26:41 +0100
Message-ID: <87plmip1m6.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Please find some new developments for next:

Android:
- bootstd: Implement bootimage v2 support
- bootstd: Support non-A/B in bootmeth_android
- Migrate VIM3 and VIM3L to use bootmeth_android
- bootstd: Additional test for bootimage v2
- bootstd: Optimize load time when reading partitions

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23573

Thanks,
Mattijs

The following changes since commit 48380f9b2a12e3fc6339d6af5a154bded769d911:

  Merge tag 'v2025.01-rc3' into next (2024-11-25 17:34:08 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20241126

for you to fetch changes up to abadcda24b100b8eb0f138085cca6595518cec85:

  bootstd: android: don't read whole partition sizes (2024-11-26 10:04:40 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20241126

Android:
- bootstd: Implement bootimage v2 support
- bootstd: Support non-A/B in bootmeth_android
- Migrate VIM3 and VIM3L to use bootmeth_android
- bootstd: Additional test for bootimage v2
- bootstd: Optimize load time when reading partitions

----------------------------------------------------------------
Guillaume La Roque (5):
      bootstd: android: add support of bootimage v2
      bootstd: android: add non-A/B image support
      configs: khadas-vim3l_android{_ab}: move on bootmeth android
      configs: khadas-vim3_android{_ab}: move on bootmeth android
      bootstd: Add test for Android boot image v2

Julien Masson (1):
      bootstd: android: don't read whole partition sizes

 arch/sandbox/dts/test.dts                 |  10 ++-
 boot/Kconfig                              |   1 -
 boot/bootmeth_android.c                   | 104 ++++++++++++++++++++++--------
 boot/image-android.c                      |  45 +++++++++++++
 configs/am62x_a53_android.config          |   1 +
 configs/khadas-vim3_android_ab_defconfig  |   7 +-
 configs/khadas-vim3_android_defconfig     |   7 +-
 configs/khadas-vim3l_android_ab_defconfig |   7 +-
 configs/khadas-vim3l_android_defconfig    |   7 +-
 configs/sandbox_defconfig                 |   1 +
 include/configs/khadas-vim3_android.h     |  25 +++++--
 include/configs/khadas-vim3l_android.h    |  25 +++++--
 include/configs/meson64_android.h         |   6 --
 include/image.h                           |  24 +++++++
 test/boot/bootflow.c                      |  29 ++++++++-
 test/py/tests/test_ut.py                  |  49 ++++++++++++++
 16 files changed, 297 insertions(+), 51 deletions(-)
