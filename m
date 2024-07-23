Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDFEC3DA70
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 13:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F18E18881C;
	Tue, 23 Jul 2024 15:35:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="RBgPN3NV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B580C88747; Tue, 23 Jul 2024 15:18:46 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D50D887B4
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 15:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42726d6eca5so40264595e9.1
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 06:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1721740720; x=1722345520;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Hj0f+HOWbsov9B6C1mB8hAGdGFL52D/P74cEdUi4JCI=;
 b=RBgPN3NVWEakQQbB/Rx7ggfgiCIm0lz2ata7KPqPsnXf21MK0q0yEKLWwGPstu9GXG
 EiMRK0Dhdf1L/rJIAisMN2UzRMBwUqa8YTOYQs/wTxhEmD+cEUp6dK52Ue83UX8Emxd+
 P/ybOFaaIKSCAhb3sXpbGGfaI2o4NKpdRf/DQqRUxsPJbzYq81kkFW7cFZWkN45oG837
 Zo7gLqioOg1awbdlppkcFbNrNxP/4qUwGP2d2+H/5iaLXXNSbmhmftbHgc9yPh/LVazu
 30GLJZNvUdJt3o4rejzHbmDAYPg0T6akG7sf1txabLMQkiXZx2gVuES/8tk1zJ9hsr0/
 rr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740720; x=1722345520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hj0f+HOWbsov9B6C1mB8hAGdGFL52D/P74cEdUi4JCI=;
 b=SR9ocrWgpjQ0EtFvj0BZA9gCZZCkASK8lMthEbTrfZUVs0OLvaOH+7eRgSXGTUKKrt
 fHIoGO3sUQOlDMSy3CmAI5q0/WYC4Jk9y18bXEl17D20xUdLcSx9CNbeYFyyCrzCNjwP
 iJqZhXAXrcnSZkQEutX0l0Tl7w3XzaOn59LWyqJMqySZlaWPiRV3CJNn9W/QLD9hbzrB
 gp/V5sn1Xvy9JxvlrgZicn4ICqSNvx42ww2IlrEEjRkNvPPT5S+wc8jYjeO0wcNxYf+l
 J9Ex4NQnz61fpuW0afbuavZh4nCUc3ulPgpEzbID8DPvRhpwAe8Pfyw65yXi/3Jow79P
 GWuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpVEfBhJzwJjXSxoEP74VPWh1Fxpv6Y81+iv2eKt1iqfhtsomEBL9kQuZMco1ch+/wopw4sCygQsF8i0MYwqJdO9ZVMg==
X-Gm-Message-State: AOJu0Yx4Epf9oCWbHFlqscO8aHehOPh8j/HYriRA3ypFdfSGeUbAp13I
 8R+2vyYK0JcygJGMNLUtQvkBrenmoLGfta16o7KhToewwaJeK/YXI+/08j1vIHs=
X-Google-Smtp-Source: AGHT+IHnROQEWIshAqNLi33jAZSxrwr7pPSrZ/f931DWlTQbw0+v6U5i1tE7xjnh1Oi51Yuu8+TGKQ==
X-Received: by 2002:a05:600c:470b:b0:426:6e95:78d6 with SMTP id
 5b1f17b1804b1-427dc516017mr67396895e9.4.1721740719772; 
 Tue, 23 Jul 2024 06:18:39 -0700 (PDT)
Received: from localhost.localdomain ([78.199.60.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427db2a4e3bsm140312545e9.44.2024.07.23.06.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:18:39 -0700 (PDT)
From: Zixun LI <admin@hifiphile.com>
X-Google-Original-From: Zixun LI <zli@ogga.fr>
To: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Zixun LI <zli@ogga.fr>,
	u-boot@lists.denx.de
Subject: [PATCH v3 0/7] usb: gadget: atmel: Code refactor and DM_USB_GADGET
 support
Date: Tue, 23 Jul 2024 15:18:07 +0200
Message-ID: <20240723131817.262596-1-zli@ogga.fr>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jul 2024 15:35:55 +0200
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
  usb: gadget: atmel: Fix typo in usb_gadget_register_driver()
  usb: gadget: atmel: Move usba_udc_pdata() with other static functions
  usb: gadget: atmel: Rename atmel_usba_start()/_stop() to
    usba_udc_enable()/_disable()
  usb: gadget: atmel: Add attach/detach support
  usb: gadget: atmel: Add DM_USB_GADGET support

 drivers/usb/gadget/atmel_usba_udc.c | 250 ++++++++++++++++++++++------
 drivers/usb/gadget/atmel_usba_udc.h |   3 +
 include/linux/usb/atmel_usba_udc.h  |   2 +
 3 files changed, 208 insertions(+), 47 deletions(-)

--
2.45.2

