Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2C2C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 10:06:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD87C881D3;
	Thu,  6 Jun 2024 12:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1PxqUp/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3B3C87F64; Thu,  6 Jun 2024 12:06:51 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82540881D3
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 12:06:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-35dd0c06577so810990f8f.2
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 03:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717668408; x=1718273208;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rPdkKDiF8mj1REg3z1iFlPJNMKprRWEhNj5UcUUBEQs=;
 b=1PxqUp/h7KFqo44+L9IUmWb9piA83ND6VgkQGGXzxtR0QdfKRiQDt3YqkwwQdWVqpl
 IyiQGn+qRgnzPzXQSwMas9hZAOgFyhX+lTA8GL0MNUTTi4SvG/JmTnAbX+Rqeolt+x3C
 dw1jL6V43SDLXRVllYuikvuzfYush5Ntjo/nkkIgA6zWfOBw/eHTlv+OMp4hiqcosmz7
 i53P/ZDGlJ3zoi+ZEh9k4MWFkGcZ5tLubi0nznM/ZuKzAjb87t3Nn9NAt0SDM/9e7z56
 WPousk9xoInefwtywpzIo3qoOeBOgN/YoOW5tnM8UFHY7dOpzhhOdC7Sh55NowTgVbQW
 unDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717668408; x=1718273208;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPdkKDiF8mj1REg3z1iFlPJNMKprRWEhNj5UcUUBEQs=;
 b=uRTC4SNghC9ESWSTDHqBEDSSgHV69j9KGZ3kPGuAL7L9Vv22bobOqUSw71zjlcOzKC
 zQi1Q8QHChjYmRRrAQtt1mwqGJV2iX7s1zDP1sidZQQPzp3EfEVPs/r4h5kfV9n/GfWD
 ZNwBw5iVWjnQrmuceEJg4zssQaV9wmYelwXau54Zkrm+c+yA9JcwMkTKuIj9ctAG1AKK
 fM12DHEFEqon+9TgAKd1h4pqBk6bKkD4evEmeBmRcJOX7M597yizQ0iV/N6SKeTto84y
 PGh/hGXfaSkrYrUjk6x+7cRwPMHtlY8d61pZVptwHruYAVF4BBsJ7U6hdhMIm8os9LgZ
 U2Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSQFsvc1akZa9SjDZUJqfEyOhYP6HD4bA5eX4q3bOaApU6mw2eYwhWYgzIe7aztNINIBuM7y8AAER0j9mIlYc+b7/4jQ==
X-Gm-Message-State: AOJu0YyGF0NZDWwkUotQJGDhejVhyOfFNRgpwDPgg8VKrTdnWRu+yukE
 YtXvUWOwGTPiFxF9RnVUnjfGbfoj3n29dD2WERSkt4iDP9+lvNa9e0SAV6RawoE=
X-Google-Smtp-Source: AGHT+IE5DU43uZnMBS87tIUXGdllj+c3lCuhoTjKyra0/BuEyNdz69qiUVIxSdB8z3+vG52NJ7T3xw==
X-Received: by 2002:a05:6000:b0f:b0:358:2003:766c with SMTP id
 ffacd0b85a97d-35e84070f8fmr3951766f8f.22.1717668407792; 
 Thu, 06 Jun 2024 03:06:47 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35ef5e989b3sm1132798f8f.71.2024.06.06.03.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 03:06:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [GIT PULL] Please pull u-boot-dfu-20240606
Date: Thu, 06 Jun 2024 12:06:44 +0200
Message-ID: <87le3i1j2j.fsf@baylibre.com>
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

Please find some fixes for master:

- dwc3 fix crash when ep0 stalls or gadget is stopped
- Kconfig build fix for DFU_SF (SPI flash DFU driver)

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/20990

Thanks,
Mattijs

The following changes since commit c0ea27bccfb7d2d37fd36806ac2a2f7389099420:

  Prepare v2024.07-rc4 (2024-06-03 18:34:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20240606

for you to fetch changes up to 4339138a2086f8449b9356130cb6e97a81aa8679:

  dfu: add missing dependency for SPI flash DFU driver (2024-06-06 09:11:21 +0200)

----------------------------------------------------------------
u-boot-dfu-20240606

- dwc3 fix crash when ep0 stalls or gadget is stopped
- Kconfig build fix for DFU_SF (SPI flash DFU driver)

----------------------------------------------------------------
Heinrich Schuchardt (1):
      dfu: add missing dependency for SPI flash DFU driver

Neil Armstrong (1):
      usb: dwc3: gadget: fix crash in dwc3_gadget_giveback()

 drivers/dfu/Kconfig       | 1 +
 drivers/usb/dwc3/gadget.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
