Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85958D2F7FC
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 08:20:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E972788EE0;
	Thu, 17 Oct 2024 10:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AuEF6PYm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A73788D61; Thu, 17 Oct 2024 10:20:38 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0BB488EE0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37d6ff1cbe1so491686f8f.3
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 01:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729153233; x=1729758033;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3Tc+fNqf5YU8GAXfEsBmm7LZK+OAw4DUSxo2RXNWCb4=;
 b=AuEF6PYmHFx6AZ9CoDOFlsCdt37jnIU8e7BAoMJqnO0roPo7we6ZKpV/1HCv4z4hAI
 BeFnkUowGRYZSFXQayFRnTPzqnxeL7S+yjRolUU3p+1qZgO1oaHrMZNOYl187knRKAIZ
 Jw3MgMIwsUBFixcIsoqwWtXbl6GkOm69KkpLJi91CfQV+RKakRsbagtA5ZonkNNXbqyu
 zuzTRNt9pXUgLos7as/ufFv0DN1fLvxNCUdiqwXFHS9wHh/Y8RI8ZngQtMDDn/ER4Yzy
 oqCgS/ZGwgj0VT4NB8PfbRb4IFxNimG6x4g2oJ8azmW2rptQHG8aY4hOJrFWkHE8TguG
 yjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729153233; x=1729758033;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Tc+fNqf5YU8GAXfEsBmm7LZK+OAw4DUSxo2RXNWCb4=;
 b=ZdTvHoqYV6/uIK2VTNSovKVActcNaYOmlEumV5f294Tb6PiA4/Dtb+i6Wwwjqt9J5O
 A1FyDjbASRQ8Q4TZ5BjBUQdgko3+0X+dFckdK/wE4mxwNyl+XM5w/Yh68VbLxd5Eyj6r
 GO36SwAendChqASsSqq3ToCPAnlAckfe4fBpoTFeaQEbAyLEHsxE0Pa07lgRbZrYuwQU
 OVgmXPU4NFS+Xl8Tj4v1k/1ZToLQ95aVoN5/a9WKrDN9YMHAdRF6jJFtcUCuEO0H/yjY
 +PGiHAmVGDFHzcS+4b/IetToSvLeYjt2FPeTwcI2r3knHFdP8ELm3CJzYgMUuHur3Z6w
 VjDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhHw1MMbuC77A8P69jIrkU084c264fQbnOL3ESGiUePYumGVHMoVI263V8zvP/EbHTjh6sG8I=@lists.denx.de
X-Gm-Message-State: AOJu0Yxzo7FrKqP6MDa6w56slehftmbunF7FXXFW/ILIO+K7sxL1suR5
 R1LWuLGKoxcbgCfFakAGqcUNTYCe0D9BStwwAGbkPg0cWj6oshXNm0dpWX8PU3M=
X-Google-Smtp-Source: AGHT+IF9wWsrdXuUMGgsHSkUKp0ag9i8fZzD6gwwIvR/JF4C7RADKEgomAwiIfW1n4pohAH1W0/Www==
X-Received: by 2002:adf:b35c:0:b0:369:9358:4634 with SMTP id
 ffacd0b85a97d-37d551d65aamr15238896f8f.19.1729153233185; 
 Thu, 17 Oct 2024 01:20:33 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fa9077dsm6542572f8f.55.2024.10.17.01.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 01:20:32 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Jerome Forissier
 <jerome.forissier@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20241017
Date: Thu, 17 Oct 2024 10:20:30 +0200
Message-ID: <87iktr2l9t.fsf@baylibre.com>
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

Usb Gadget:
- Fix cdns3 endpoint configuration by setting maxpacket
- Fix dwc3 cache handling when using DMA

Fastboot:
- Make AVB_VERIFY depends on FASTBOOT

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/22742

Thanks,
Mattijs

The following changes since commit a404065479be2c1fe1167c3c91367e8194a69d1b:

  power: pmic: pca9450: Add missing newline (2024-10-10 12:17:46 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20241017

for you to fetch changes up to 3e47302dd71267b85e5ec65c5b6d881c23cce6cb:

  usb: dwc3: invalidate dcache on buffer used in interrupt handling (2024-10-15 11:03:57 +0200)

----------------------------------------------------------------
u-boot-dfu-20241017

Usb Gadget:
- Fix cdns3 endpoint configuration by setting maxpacket
- Fix dwc3 cache handling when using DMA

Fastboot:
- Make AVB_VERIFY depends on FASTBOOT

----------------------------------------------------------------
Jerome Forissier (1):
      Make AVB_VERIFY depend on FASTBOOT

Neil Armstrong (3):
      usb: dwc3: allocate setup_buf with dma_alloc_coherent()
      usb: dwc3: fix dcache flush range calculation
      usb: dwc3: invalidate dcache on buffer used in interrupt handling

Siddharth Vadapalli (1):
      usb: gadget: cdns3: Fix cdns3_ep_config() by setting ep.maxpacket

 common/Kconfig             |  1 +
 drivers/usb/cdns3/gadget.c |  8 ++++++++
 drivers/usb/dwc3/core.h    |  2 ++
 drivers/usb/dwc3/ep0.c     |  6 ++++--
 drivers/usb/dwc3/gadget.c  | 10 ++++++----
 drivers/usb/dwc3/io.h      | 13 ++++++++++++-
 6 files changed, 33 insertions(+), 7 deletions(-)


