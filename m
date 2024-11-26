Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB4FD3B98E
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0E289734;
	Tue, 26 Nov 2024 14:23:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u16uM858";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB4B89C65; Tue, 26 Nov 2024 14:23:19 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC2589734
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 14:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so3340324f8f.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732627397; x=1733232197;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FA7eBmx1GsENcEiAvTdrEQEA7YfUtQBvAZyrMBtTybc=;
 b=u16uM858i/wH2UVp99HNJbLYflMBGriLUjycrbov6RTIjSenutluQBW4+ikadiAB4T
 9ZUAHqxHhBrt6upGp+Gm/v6X1edtT9qEjXnPA+eti4uURpSdCZ9SVWU4FYhCz3mQ9xR+
 9lunkW3H7zAVHD8449zdVIOE/CL1lrcH4gjJuyhs/jZSN2MVBlbuCShwORfFNqojJl7r
 c0MzIgIHPle5Cqca+mZOvMPNEupS9bP+OSULKAQ54Vm+X2K9ZkcpKewmuO1JetkLFgIo
 YryYlCtC2nlTRN0nEN5Qb8rr/GdIYsyoqULmwPoM9slPBNrRp/hFKtrcMx6WbSCsHhLt
 62hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732627397; x=1733232197;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FA7eBmx1GsENcEiAvTdrEQEA7YfUtQBvAZyrMBtTybc=;
 b=VDcL3dx0tJY4G5PCMtCdanYTzF4p1vz9PWvfZBwleuNXaLdieuNTSYC6QGH+EkuYfv
 P6xRSgtfQuK/NsCrsNgKjCOaW8RbjM1/QgV8UXdUD+E6M1QFJ+O48PbIyA3RPX7ub6bN
 LGfhWNIsZaAcyf5cLKXUK+rNhr367Tt1mpYHI31NbOTaXqfxngdxQBhl+Nplteao1MTz
 LOLROYkkXR80Unrwf85f/jK5TbhJGJ02NMcAdIcBVprP3HPzY+Qk+TzGQADYUfbWVhyg
 agunpjHjiu5VkHdkRaL+oCjP5PswLBbh4TXX2IN8S49qHjCoNGogq/F/4UZPcOSM+2wS
 pd2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3lQLRi5Gm/3KnFl3drSofklu3HkEblDEQYSN3eWKFrY3JKH7OQpLMhHbuc4n2Ox+tS5DbDX0=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7Xk4PYxik6MYy5dwlZfT42zTWg4nODgwGk6pt+nuVEn7bufIx
 3o1UAwcQznOLOubqNdYjJ1vSKWpl9uuCVZXL6g7gKlmSW5dgGryQ+HqLzYUXoCE=
X-Gm-Gg: ASbGncvumPPTET4mwVr1kF6DsLmqf6zcPB/p76j5BE+759znISFesZlkvIG9WewiPCz
 w9Hmr8H8ILYRwrlru69WxIyMQlWGttIo0nR6wdzC53hh4fau06jvWDJVNOmF6tlsEY0CzrEUYOG
 BznW00vkyYXw1qGm2C4u8Lcf9rnQODm326h2/MShMW1adFvBPLka+sUig4YIlEvX24g7FTlgtUZ
 IhIVkiBKC7cGyTB5hBlUyMX04RzPajDA2y/ngIWdy8aZItAuOkVmA==
X-Google-Smtp-Source: AGHT+IE3czjU6zQOuASJRI6LCJFZbdRAsO6XLM73VaMCYvex123KRZYo4wcjKPzblw0KANK4MYx5LA==
X-Received: by 2002:a05:6000:2a5:b0:382:4faa:767 with SMTP id
 ffacd0b85a97d-38260bcc47bmr15302112f8f.38.1732627396821; 
 Tue, 26 Nov 2024 05:23:16 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedf63sm13361897f8f.102.2024.11.26.05.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Nov 2024 05:23:16 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Caleb Connolly
 <caleb.connolly@linaro.org>, Ion Agorria <ion@agorria.com>, Svyatoslav
 Ryhel <clamor95@gmail.com>
Subject: [GIT PULL] Please pull u-boot-dfu-20241126
Date: Tue, 26 Nov 2024 14:23:13 +0100
Message-ID: <87serep1ry.fsf@baylibre.com>
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

Fastboot:
- handle unknown partition type as "raw"

Usb gadget:
- Fix ci_udc gadget driver for Tegra 2 devices by not using USBADRA

CI job:
- https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/23572

Thanks,
Mattijs

The following changes since commit 0e6432e19f9c812b4986ca7fd8e6db9fd2c199d3:

  Merge patch series "Fix boot failure due to misaligned DMA buffer" (2024-11-18 08:24:06 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20241126

for you to fetch changes up to 35d967f5a8219adc47628247a98c302b1870313e:

  usb: ci_udc: don't use "advance" feature when setting address (2024-11-26 09:56:03 +0100)

----------------------------------------------------------------
u-boot-dfu-20241126

Fastboot:
- handle unknown partition type as "raw"

Usb gadget:
- Fix ci_udc gadget driver for Tegra 2 devices by not using USBADRA

----------------------------------------------------------------
Caleb Connolly (1):
      fastboot: properly handle unknown partition type

Ion Agorria (1):
      usb: ci_udc: don't use "advance" feature when setting address

 drivers/fastboot/fb_getvar.c |  3 ++-
 drivers/usb/gadget/ci_udc.c  | 24 +++++++++++++++++++++++-
 drivers/usb/gadget/ci_udc.h  |  1 +
 3 files changed, 26 insertions(+), 2 deletions(-)
