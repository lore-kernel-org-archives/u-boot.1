Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4A1C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 14:06:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89A258141D;
	Mon, 10 Mar 2025 15:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="we6Ip7Mp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F251A81430; Mon, 10 Mar 2025 15:06:13 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E0E81417
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 15:06:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so2273235f8f.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 07:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741615571; x=1742220371;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Un+C7+rs+/huCPFrj+uUj5fOw/bOuTldQiOMFszWBa4=;
 b=we6Ip7MpzJDkIdCsQZQA3XHMWkjpyZPn5jqo4IXhYNy9zsbTEF2Me4OLm4YxRey9/v
 VZWyVEccAUGPnBX75UYI6ozkcuGM7CoCqAQzKLrod3nA8c8pXK/mTEkKMdu7rEmuAOfz
 hfQ45M/21z0XVSoeqzlxdAc04J/Kde/EgJewVYKuE/XeLHkR76wbAesCg768YaqegaBW
 jPvJljHbfPi8AbIfe7+oLxRJs0TA/UIhdIx9gNrMoVzn3DzEUgvGT12fZmOksA2pQbnw
 cJq6XkHMkY9GQ7lf/BwUuCrGqH7i5fSqv9SsGV34aCJPi8yX5ZerGMoyS9nhfSoPtcgt
 5dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741615571; x=1742220371;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Un+C7+rs+/huCPFrj+uUj5fOw/bOuTldQiOMFszWBa4=;
 b=Q5zKpTg1Bxt9PD9eivuUBZgwhjMIpGRbXr/ZbSVHDniYfFV5zf7pqDIEpZF5N1qfFS
 2V54x53is1i+Di0OcIFXjmErzxzP3t0ENhqtdkzSiK45AIWeSSn/0K0O2ZwbpR7GLlrv
 ZoEsl81ZnL27dorAt8xddWn+gSMr/nzuvO2Vp76evZgZZFCQ0+tMd6pA9sGdcsjcZEm9
 DL5cgg9owqo+1uz22YQw+9/VZD/10LbrUbkKidB7ou1iR/4ECxsPDVpGXnI1HxXdXCjF
 vbRnqT8iGrYoYJOpXSfsAhgkNbVbXbsXJzOGY/dyx6Z4nqgvUhznLlOV7kk/wUrUT0/k
 IBNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbaHwJt1GgM7WD/j6p0cl3QyanOBIm6VGlR3pgVXnD3CKKGDgl34WnwT2Ljbex9Ueq1OOgfng=@lists.denx.de
X-Gm-Message-State: AOJu0YzugmP6ZQKcCU2GVol1yfgkXHhhf0pxX0AWAyQWa4+c6DBLswdu
 /tgHEQSTtr62l8z76xnZ9KJryk7pSv9Wiw0IIzQnbZTei9b0bdfxixlpVXGh72A=
X-Gm-Gg: ASbGncuyzasu3oNzj7j1Zk+SOXYabawyS0agxsAhFj/DwGSXTvedq5vpIDjsKJ490u+
 +0lIkrAwgKGa4NsKmponCPn5TUcWjRekufK2PmccE+q20gt9xjI0QihtSH0qUxBwVu+FRvT5LEi
 6BLm6M1T+V9Yqtf+b6NdxFlwt3X82dzJqBMbN8Lyk1VnHTSQK4oyEpBzCGTCMgBhBXkXs5RuMGC
 NOMoE37mahG3UcfYbswjI1CSzDhx3E37js+Ar/pEBILCoW3svDOJYqgo5oI7w6r//7EKrYUmqJ2
 btZydzOJpONDwseWNjUxGQzN39jSHx8KOBCxlk79bwtTDvBPHXSKTTSwGQmOQa0D
X-Google-Smtp-Source: AGHT+IEEOsYXI3slPz99PM+/fT4czLbqoZ+e9OcMhMJbpt+lQdAxW4Kyh9r45+gulu1LSHcZGQqvwA==
X-Received: by 2002:a05:6000:1ac6:b0:391:4189:d28d with SMTP id
 ffacd0b85a97d-3914189d71cmr4073128f8f.34.1741615570833; 
 Mon, 10 Mar 2025 07:06:10 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01cd31sm15124409f8f.52.2025.03.10.07.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:06:10 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Subject: [GIT PULL] Please pull u-boot-dfu-next-20250310
Date: Mon, 10 Mar 2025 15:06:08 +0100
Message-ID: <87wmcx3rqn.fsf@baylibre.com>
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

Please find the following developments/cleanups for next:

Usb gadget:
- Remove legacy CONFIG_USB_DEVICE
- Remove legacy usbtty driver

CI Job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/25060

Thanks,
Mattijs

The following changes since commit 743c15b9fdd2f639012a2c26734dc146dc568218:

  Merge patch series "This series adds support for file renaming to EFI_FILE_PROTOCOL.SetInfo()." (2025-03-07 12:06:21 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20250310

for you to fetch changes up to 6689b0c955f1ec885ed1acafc7c5d7c1565dbe63:

  usb: gadget: Remove the legacy usbtty driver (2025-03-10 09:22:35 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20250310

Usb gadget:
- Remove legacy CONFIG_USB_DEVICE
- Remove legacy usbtty driver

----------------------------------------------------------------
Tom Rini (2):
      usb: gadget: Remove final remnants of CONFIG_USB_DEVICE
      usb: gadget: Remove the legacy usbtty driver

 Makefile                      |   1 -
 arch/arm/lib/bootm.c          |   4 -
 arch/riscv/lib/bootm.c        |   4 -
 common/stdio.c                |   3 -
 drivers/serial/Makefile       |   3 -
 drivers/serial/ns16550.c      |   8 +-
 drivers/serial/usbtty.c       | 983 ------------------------------------------
 drivers/serial/usbtty.h       |  49 ---
 drivers/usb/gadget/Makefile   |   4 -
 drivers/usb/gadget/core.c     | 621 --------------------------
 drivers/usb/gadget/ep0.c      | 619 --------------------------
 include/serial.h              |  20 -
 include/stdio_dev.h           |   1 -
 lib/Makefile                  |   4 -
 lib/efi_loader/efi_boottime.c |   2 -
 15 files changed, 2 insertions(+), 2324 deletions(-)
 delete mode 100644 drivers/serial/usbtty.c
 delete mode 100644 drivers/serial/usbtty.h
 delete mode 100644 drivers/usb/gadget/core.c
 delete mode 100644 drivers/usb/gadget/ep0.c
