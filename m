Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA1C6C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 17:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A95928799C;
	Wed, 31 Jan 2024 18:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="ZhSKaXcK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D7B487BC4; Wed, 31 Jan 2024 18:00:40 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACA687613
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 18:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40fb44a9520so332735e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1706720437; x=1707325237; darn=lists.denx.de;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3tMPlI3qJnLhzHoFIsTUwRfbC3p9JkK4xIgTAEVxIOM=;
 b=ZhSKaXcKg0nbuOt1LO40LzAG/kLzDTTi8zw6x0z6DwCKM/Sep04jkZwedq/bQqkkQU
 Xm5amCuUUQnC+tQ9jD4bwS0MgYge3iOLt6bLW6ZvgA6JrzYmY8mwVYRlKVY0D6+RvfTB
 YJAT6ldn2fywTGRuKUx6HjIYPQJqWUg5GM2w9SMtmbD3ycu76byUcrExgaCnxirUaIYe
 BUaejMdWuTDRYtdXscRi5+RquN9UxbTapcNzb4G5f0NWvfudlXd91SY9FO/Coh8r/eYw
 TLWfsUN3iil6Wb7qXF4wtWiBBfmkvYF4hfYix+ZsPSktxVsJ3gXkL8MEYPOwkUmMAAy6
 rurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706720437; x=1707325237;
 h=content-transfer-encoding:autocrypt:subject:from:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3tMPlI3qJnLhzHoFIsTUwRfbC3p9JkK4xIgTAEVxIOM=;
 b=puUGgt6u0iufKJ3Z9H8/Sla14icMicIlwxgNAplGwqlaAWFOATvDeE9wvyqyrtgeNd
 yt33apFYy2zuXEQ1+DCHVNuOztpnigkoqcHLLV5975Dk+mqmxFoJrHP8b7UzViQMuhtv
 fxmpVz/padW0cNXMpyYY2hf9L8t+5mzs89zdpoXp26OBQH5jK4AJIZE3AUlE+v2ss3gA
 PeMXgYrfgMdqqdEusVqYZl3S+SlzMikqiFVqsuKTbPPnBfTPEkqPJyuF+qjVo3VcC6y/
 7kbn0w20S3P0BJthUWvnLvqtIR/0kMzxlODc4j/8GaVd758/+9i3z8gSIRgVepbCir7I
 A4tg==
X-Gm-Message-State: AOJu0YxDGx+6j8mCsO8XF2GlZ5JD03azLMSjBFkevBnJhnQWn/9GTWZU
 TMQoJ+nEm2DGSY2bx8FpOOGLnJvf/LQ02sNo2eAtqtfCTq5wMVjxvMaAb2a6K6o=
X-Google-Smtp-Source: AGHT+IFMMHqrWyWOp1U+y4mLS6znHUbLz9I2wDR9/OLX3iBOMG1lnaEPo/lcJsrqxvv3H0wiFOd0Fg==
X-Received: by 2002:a05:600c:46cf:b0:40e:fa75:7e30 with SMTP id
 q15-20020a05600c46cf00b0040efa757e30mr1538131wmo.28.1706720437233; 
 Wed, 31 Jan 2024 09:00:37 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.188])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a05600c320200b0040ef04987e7sm2035389wmp.16.2024.01.31.09.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 09:00:36 -0800 (PST)
Message-ID: <37425599-aba9-4abd-8fb1-3fc9fb78dd8d@suse.com>
Date: Wed, 31 Jan 2024 18:00:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ca-ES, es-ES
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, "Ivan T. Ivanov"
 <iivanov@suse.de>, Dmitry Malkin <dmitry@bedrocksystems.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
From: Matthias Brugger <mbrugger@suse.com>
Subject: [GIT PULL] rpi: updates for v2024.04
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Here come a small set of patches for v2024.04 for the RaspberryPi.
It adds basic support for RPi5 to be able to boot on a SD card.

You can find the passing tests here:
https://source.denx.de/u-boot/custodians/u-boot-raspberrypi/-/pipelines/19512

It's the same commit ID as the tag, although it's not the same test-run.

Regards,
Matthias

---
The following changes since commit 6faba41927bdc8973b59678649ef83c564cc421e:

   Prepare v2024.04-rc1 (2024-01-29 20:53:19 -0500)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git 
tags/rpi-next-2024.04

for you to fetch changes up to 12d479d01849c164020e17c3ae921f974b96372d:

   configs: rpi_arm64: build position independent code (2024-01-30 17:40:13 +0100)

----------------------------------------------------------------
Add RaspberryPi5 basic support.

----------------------------------------------------------------
Dmitry Malkin (2):
       rpi5: add initial memory map for bcm2712
       rpi5: Use devicetree as alternative way to read IO base addresses

Ivan T. Ivanov (5):
       rpi5: Use devicetree to retrieve board revision
       bcm2835: Dynamically calculate bytes per pixel parameter
       mmc: bcmstb: Add support for bcm2712 SD controller
       configs: rpi_arm64: enable SDHCI BCMSTB driver
       configs: rpi_arm64: build position independent code

  arch/arm/mach-bcm283x/include/mach/base.h  |  5 +-
  arch/arm/mach-bcm283x/include/mach/mbox.h  |  3 +-
  arch/arm/mach-bcm283x/include/mach/sdhci.h |  3 +-
  arch/arm/mach-bcm283x/include/mach/timer.h |  3 +-
  arch/arm/mach-bcm283x/include/mach/wdog.h  |  3 +-
  arch/arm/mach-bcm283x/init.c               | 74 ++++++++++++++++++++++++++----
  board/raspberrypi/rpi/rpi.c                | 22 +++++++--
  configs/rpi_arm64_defconfig                |  3 +-
  drivers/mmc/bcmstb_sdhci.c                 | 64 ++++++++++++++++++++++++--
  drivers/video/bcm2835.c                    | 18 +++++++-
  10 files changed, 171 insertions(+), 27 deletions(-)
