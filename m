Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF63C83F17
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFD3D835C3;
	Thu, 10 Jul 2025 00:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n6yTZG5d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720088354B; Thu, 10 Jul 2025 00:29:30 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 463A28354B
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40ba3c10b3bso162444b6e.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100167; x=1752704967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GHBox/91gmVvD+NXXH2cQQywTBjOjFHzo5xi8F8CwDQ=;
 b=n6yTZG5dsNdDKTfn4EPndwJBfKMFUciodNFmOAjN4yLRStICtp2FVHViMMV1CZ3jBg
 Pqb0HhEC8mqBwMai39p5GT4/oJLzN/BgUnFqEXJ/tQ0ZnC6b30gvm6L+alswZlG7PBEW
 OypYzyfhwWmLt6nt/6RTL1rN8EldVwZz0WHjXiymvRwpl7HwFIhy9LJxgQlL+xNNyq4W
 exUsAkBkb+EV/+Wtyj7foBJ9ibHxxVjy3koG1xmqt0Gj6rOoHy2jqK42b9I0cugQrU4n
 aZ7pYQ3cvIq41jnTd/4LC0KjEsXncMkDse7bIV9KBdMfvCcSrpO3Q285ja7mWehgKuqm
 kIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100167; x=1752704967;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GHBox/91gmVvD+NXXH2cQQywTBjOjFHzo5xi8F8CwDQ=;
 b=FPt8iuzWoMsh+0A0S3l6bOvCY+Smbn8gFZD4J3twUDZvX5/lxnUJ8IZUrzHA08qNFl
 irwyRvAP9QPaicY5rppUm0Qpy65gXbhciUVmIQuq83qLZPcRmbPVDb0DR/eMtIyRIhkO
 p95sLBY89azRhCNxPOGiVjOmPxq0GgC0cdt56JSEebprZ0m89j9vW0XrrUSUztdHybRl
 b4xpg7IEd1d11HDj3mH23f/BjXLxkg600+ZNRbtPt3LILBwcPl6lt99bhYStBL16Jm31
 EAswx9GYZ95vaEJWMiqyEbdk1+LrzlZv1fbOonYYJd1/mESvIh1pbxr+aNUDaU1rGXTk
 ZzYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcZ00Snk2iLm8X6fh0gi57WW4/xY6oafX6pAwjZHbqS1WH37DYTrxirRwTDXvXKVzexjgxmD8=@lists.denx.de
X-Gm-Message-State: AOJu0YwRMpvgC014Fk5Ge435V5JMzpryqWRGSmLYFE7xFizX4ebMZeis
 ObXzTWHF0QsAVIGUry+2n0JsxiBJ+lhm42s4i2fqG5GvTm5SFz2ntLmi6MjNwAWOgIQ=
X-Gm-Gg: ASbGncv2zChm5I4hZvNmsIL4j1acrPh1Jo5mahoekqduKdo9areVw/f8CF9nO61Go6B
 BPaw7HDEHVmTVUn1WLgLi5/YPYdBX9RHz82KJNZPeoP2eQVMADkvrxNXbfoN3JojoPPJyd5uWzR
 pME0Z6PoyGcN+/kd7r7AflhMdeUdjTBt/9w3vy2q4lHLDk+3JfqsAFnjjF2HSafmRt/xiPbXkWq
 9lO28DI3B/Mv106qGJqxHuBZrpzhsRcPHRwUS21LDnAgypBFUil6wN48RZM+2K0LvEcfPBQ76Lc
 YUUREUzunC3nRU5LcC3h7QQbVrjNya7Qw2j16O5+gcLvq+e3uLKhpPlhPsAI9eQGdIIXWAJz
X-Google-Smtp-Source: AGHT+IFkQo1MX4IA9RGfPCr4WZMraXnhXvhmijHk/MEv5ivtFzz/jyDwvv1+I4bmCrbV8UKjv39UiA==
X-Received: by 2002:a05:6808:50a9:b0:40c:5b59:6b8d with SMTP id
 5614622812f47-413f57e342bmr303682b6e.26.1752100167024; 
 Wed, 09 Jul 2025 15:29:27 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414196c8e13sm2509b6e.16.2025.07.09.15.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:26 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 0/9] board: samsung: e850-96: Enable USB
Date: Wed,  9 Jul 2025 17:29:17 -0500
Message-Id: <20250709222926.24671-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series enables USB and related features on the E850-96 board. For
now only USB gadget is enabled; USB host will be added later. Next
features are enabled:
  - Fastboot
  - DFU
  - EFI Capsule Update (not really USB related, but DFU related)

All features are tested with Linux and Android partition tables, as well
as updating 'boot0' eMMC area where E850-96 firmware reside.

Sam Protsenko (9):
  phy: samsung: Add Exynos USB DRD PHY driver
  usb: dwc3-generic: Add Exynos850 support
  board: samsung: e850-96: Setup serial# env var
  board: samsung: e850-96: Add dfu_alt_info
  board: samsung: e850-96: Add Android partitions
  configs: e850-96: Increase malloc() pool size
  configs: e850-96: Enable USB gadget and fastboot
  board: samsung: e850-96: Enable EFI Capsule Update mechanism
  doc: samsung: Describe flashing process for E850-96

 MAINTAINERS                       |   1 +
 board/samsung/e850-96/e850-96.c   |  77 ++++++
 board/samsung/e850-96/e850-96.env |  44 ++++
 configs/e850-96_defconfig         |  25 +-
 doc/board/samsung/e850-96.rst     |  85 ++++++-
 drivers/phy/Kconfig               |   9 +
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-exynos-usbdrd.c   | 386 ++++++++++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c   |   1 +
 include/configs/e850-96.h         |  21 ++
 10 files changed, 637 insertions(+), 13 deletions(-)
 create mode 100644 drivers/phy/phy-exynos-usbdrd.c

-- 
2.39.5

