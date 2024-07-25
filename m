Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE97C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:14:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94AB287E64;
	Thu, 25 Jul 2024 19:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="X0sUqFHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0BB387876; Thu, 25 Jul 2024 17:32:27 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89B5F87C38
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 17:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42793fc0a6dso7867985e9.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721921545; x=1722526345;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CDvS+N3YNS16WkCvUdRUvZ99O7zGf3lJumO7cj10Ogw=;
 b=X0sUqFHKOwn8+dgtAcOfQZuIty/T5JbRTBLu8kiFcsk5e+0IMorwYXSVh0MukpEJyG
 jhQ+r+zERQkciiJuLz9cpyE7F9EgWCbDRbsSLA30/qed+S5Hdmkg7Pu2bd+nNEngcjq2
 pZPNa3icU0XF8FXaV52qwBhVVskmsg/kWofbBkv6N2Ih7xWleG4PyJCe9O2m/KuJmpMd
 Fc3+MwgdCE8snq0hADkGDLn72VK9ydBHFWxvjva2Dily0nRRUXrqNwvlk2GWinAvFXki
 cYjQ4vFGFwQQ0kgpZvRsNmJU9oEMR5MqfQgAQuCYkIbEj4wl35pOvlD33yl21gTyJ+kO
 NVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721921545; x=1722526345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CDvS+N3YNS16WkCvUdRUvZ99O7zGf3lJumO7cj10Ogw=;
 b=oSMg1LLPe4y7QcRvLPsdVavAntKaK/wUSW6gtlDrAxmGYfjVDw/DKYvxSjuFTQOfMg
 suTB9sB7mMSrsd9/9APllSysA8RfkfCc3Hp285LliL9HcSoHNE075qiZ36/bw97lGBO7
 HREe1arDxYkdbVEZbmH0cUSEjMum6AFW+w2hifwrHkNHaF4t26igm0N+tU1ePqb5GVXj
 UHh5hNC79wfbMjkWLFi4vqJKSzn8vyUtDAjvJMOp1DDt50KV1FL3nCJRPFmckVNMMgsq
 n+UgHyV2icHgxPkCkumXv5YZ1EwBewSEszphNRGMMQ4CYMxSbv+zF/ziP482NjgBVuHq
 u5/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyPPA6pQ8yxuSnBDNYxia0npl/qMq8mGxGL7kvei1v+B3iFT1U+wacHoEn7hq9SWklhu1X0jOdpcElShws0r0J/PFh0Q==
X-Gm-Message-State: AOJu0Yz+W2W527UxnKACmxxzGXnGffMpTiqs+6ZaRhJeIPWy4WoVXbRv
 II/43hcwGx86Ukr2yZ5T/5FI8wRe/NpE7XYhuftAbojXq/g1r5L1e4r7ghJNLqg=
X-Google-Smtp-Source: AGHT+IFkgVSykYIP/S7c57pjUOrN8BUem0TZsfWcM4nKg+WjAqLkNMRV2gPintQ+lFO7Q8pxwrKJfw==
X-Received: by 2002:a5d:40cb:0:b0:368:3789:1a2 with SMTP id
 ffacd0b85a97d-36b31add956mr2117050f8f.21.1721921544834; 
 Thu, 25 Jul 2024 08:32:24 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-36b36861b54sm2530805f8f.95.2024.07.25.08.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 08:32:24 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <admin@hifiphile.com>,
	u-boot@lists.denx.de
Subject: [PATCH v4 0/7] usb: gadget: atmel: Code refactor and DM_USB_GADGET
 support
Date: Thu, 25 Jul 2024 17:31:54 +0200
Message-ID: <20240725153204.358925-1-admin@hifiphile.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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

Changes in v4:
- Release clocks if probe failed
- Add missing endpoint data free
- Addressed comments

Changes in v3:
- Separate code refactor into individual commits
- Extract the controller point from udevice private data in DM functions

Changes in v2:
- Fix null pointer deference in driver unbinding
- Separate code refactor into 2 parts
- Remove dead code

Changes in v1:
- Based on [PATCH RFC] usb: gadget: atmel: Add DM_USB_GADGET support:
  https://lists.denx.de/pipermail/u-boot/2024-July/559503.html
- Addressed comments, moved the refactoring to a preparatory patch.

Zixun LI (7):
  usb: gadget: atmel: Sort includes
  usb: gadget: atmel: Replace printf() and pr_err() by log_err()
  usb: gadget: atmel: Fix typo in usb gadget driver register and
    unregister
  usb: gadget: atmel: Move usba_udc_pdata() with other static functions
  usb: gadget: atmel: Rename atmel_usba_start()/_stop() to
    usba_udc_enable()/_disable()
  usb: gadget: atmel: Add attach/detach support
  usb: gadget: atmel: Add DM_USB_GADGET support

 drivers/usb/gadget/atmel_usba_udc.c | 256 +++++++++++++++++++++++-----
 drivers/usb/gadget/atmel_usba_udc.h |   3 +
 include/linux/usb/atmel_usba_udc.h  |   2 +
 3 files changed, 214 insertions(+), 47 deletions(-)

--
2.45.2

