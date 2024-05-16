Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0922C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 09:46:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1156D88266;
	Thu,  6 Jun 2024 11:46:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3ZZvc8RQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA9A28823C; Thu,  6 Jun 2024 11:46:33 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A497188266
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 11:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421578c546eso8282615e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 02:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717667191; x=1718271991;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rPdkKDiF8mj1REg3z1iFlPJNMKprRWEhNj5UcUUBEQs=;
 b=3ZZvc8RQvOaJ88+KULeJPcm4EbqokyfFqCzeDmRJa7EFEMy4QHsqQh7JRCurIaGl/5
 mcMugQLzBAbJoIVMZKVGBup5AL5b2c9FC9ZSXTF+rGOwSAGYqIK/BJQbyXdM1JyR2tyc
 4rUsUCUeYpj9BEsZbSvpOn+EoDXHqtTBOEXc9UWRrah1kjrImZ3Gx9tI28Uc1o/jyjzI
 Bb8jwzOZXtQ2okKDfGGsPWFPL9SN+RSoqr4c/KTuACW+2PurajYQjDu5fB6su878hKmC
 jdwiB6SynVKSWeVssXkpCweZpmuCLGHoXrApQACxudWPJyX85rBZbYb9yJCRnc2dqjVl
 Uzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717667191; x=1718271991;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPdkKDiF8mj1REg3z1iFlPJNMKprRWEhNj5UcUUBEQs=;
 b=rIYssgeqfxxyrvi32NrJNs+OOQnVra9oizKpcPW5mLVxQExoboHUx872TP3R0UC8FG
 Gh0yLZ9hXRpFO97f97UtYQ6+39teN33mziQVGhCIcwiVfqJy+tFIYHVVNIuwaCPufdA0
 tqVf2UKGLzNX5AD4NPWyBX37NNK7vMFOvYzaSWH8Bvya59b2u7votIHQPL7RRRrkQX/M
 9Vlu0DTSwb3WTNFnTjqCQsbEJrT6lKjYBP54bj7s6my9ozJRF3saaMmywFwcVj+mjL6X
 PzVDar9fvRJiGApkFGvF70AgQHcg+VOWhYeAmdCEc9SsQHnvXzhBxNV3o7DvfHufsGGx
 kVqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNoRjHfCPQGXclCFy1IkXfVBmklq5HXTXXKM9Bn+bI8JoaF75IRISJM/xPn42Hy2+5evhh+bue4VQuFxvA7s6XKvAirQ==
X-Gm-Message-State: AOJu0YwpHueVnEk0B5KHJj7tvbxVkWyDQeYQADlszxdi7K7tB1EaVOs4
 6r51v5BSh2YETqOnElxUqrevm8Nf0pqhU2+BNxltBok4vQt8wdmxbj9HPqRYRpVw4sptnrJVJvf
 5fDQ=
X-Google-Smtp-Source: AGHT+IFo18El9TMW4kV4hK+4kCX+cByt6llmWXPtc8up067+pp/t+Ar9rnYRjSl3SM4YjAQrt354xg==
X-Received: by 2002:a05:600c:1908:b0:421:2a14:3132 with SMTP id
 5b1f17b1804b1-42156351e62mr38393725e9.25.1717667191060; 
 Thu, 06 Jun 2024 02:46:31 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102a69sm50181345e9.15.2024.06.06.02.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 02:46:30 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [GIT PULL] Please pull u-boot-dfu-20240606
Date: Thu, 16 May 2024 17:12:33 +0200
Message-ID: <87o78e1k0c.fsf@baylibre.com>
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

