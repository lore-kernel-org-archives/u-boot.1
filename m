Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928A6C61D97
	for <u-boot@archiver.kernel.org>; Fri, 24 Nov 2023 10:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD31B86E81;
	Fri, 24 Nov 2023 11:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0y0Mwxjj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83024869DA; Fri, 24 Nov 2023 11:44:19 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76BCB86E81
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 11:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507bd64814fso2438445e87.1
 for <u-boot@lists.denx.de>; Fri, 24 Nov 2023 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1700822656; x=1701427456;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kzPIW36QoiWx5NStxG2py/Q6AL2THyPcXdd0pI4w8RA=;
 b=0y0Mwxjj8CT4HxNBXZhkNbp9ZgVU0EidcMqpw5Xe7et3/IHRWSxv3ok4bpc7oKjFqX
 yppWaeO8uFj/+8gkJFHHJNZko0HYtQpUXv/mKZf/HLtL5zLeVg/seekx6C5b2ziR8VUY
 kY3grrqB6Q9TL9qEJ5gzoRILZKo3sPxT0HDGoDCcrPWAi0Tdf72AT6NsXqZe71OkghK/
 rUKqAnAC8LmkkGYgd5sUAq2r1t2DiQuVoVwLAVfVMxToXNCB7qwl4OLPR6+U6LPG2zO6
 oXvOx3whaR0wBOwTZJ8AHboq+fdcvMwvp2m6UMvx2gEdsqIz2/d+0p1SswQaGLdbmLwk
 nKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822656; x=1701427456;
 h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzPIW36QoiWx5NStxG2py/Q6AL2THyPcXdd0pI4w8RA=;
 b=Et66OC2YuJbMmxqgnrTKv5pt7LGwbde1no19Jql1oWYD1XJokxdmoWx3DCQWpSkXP3
 QRrBj6hIK+aQfQyrsmedeDgx2OWmvyVwwQcNcOtKtRU8T1InfWkKPADN+aoyENOnNr3E
 VaaQ1OYa+NOMTS5IHFJOxY1mzdkpn+LBr8SUomaVkE9ctT+C38YkeM3iEk2LG/f+n6c6
 F1iS30lgxt2RC03dJdwojEUlwaTVHIqym6OxcXpUWXYemoOzu270wgzVwhSEa2FE6Gcu
 qRDzWUPluRMmi50+JRRG3miMlts0K1iUSOYr/HkVkmdcwjX10KOdULsNrsnDI/yAhmqF
 /u6Q==
X-Gm-Message-State: AOJu0YyGb5/Ngah97NyWQMTyzDMpQ9OUwZI2QBK7TSWH6v6OPgRAc71U
 9I1WLfXROMrtc4VyClF/WJq3VA==
X-Google-Smtp-Source: AGHT+IGnauOAOSINfEigHc6lKWAZOaSk6OGZ+XCszXRQ7j78N416CJPlMgcVuvufKW7+USNfUAQ6Vg==
X-Received: by 2002:ac2:5fc5:0:b0:500:daf6:3898 with SMTP id
 q5-20020ac25fc5000000b00500daf63898mr1248013lfg.26.1700822655683; 
 Fri, 24 Nov 2023 02:44:15 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a05600c320800b00405391f485fsm4559755wmp.41.2023.11.24.02.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:44:15 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: [GIT PULL] Please pull u-boot-dfu-next-20231124
Date: Fri, 24 Nov 2023 11:44:14 +0100
Message-ID: <87fs0vbfcx.fsf@baylibre.com>
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

Here are some developments for next including:

- Make dfu entity name size configurable in KConfig
- Implement start-stop for UMS (graceful shutdown via eject)
- Improve help messages for cmd/bind
- Improve help message for udc bind failures

The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/18704

Thanks,
Mattijs

The following changes since commit dca7a8958f8d0dbd53072caa4353353e062d80ca:

  Merge tag 'v2024.01-rc3' into next (2023-11-20 09:19:50 -0500)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-next-20231124

for you to fetch changes up to 8a0d07807abb5370fe879321c7f1d22fdda3255f:

  usb: udc: Try to clarify an error message (2023-11-21 15:48:38 +0100)

----------------------------------------------------------------
u-boot-dfu-next-20231124

- Make dfu entity name size configurable in KConfig
- Implement start-stop for UMS (graceful shutdown via eject)
- Improve help messages for cmd/bind
- Improve help message for udc bind failures

----------------------------------------------------------------
Jaehoon Chung (1):
      dfu: add CONFIG_DFU_NAME_MAX_SIZE configuration

Marek Vasut (1):
      usb: gadget: f_mass_storage: Stop ums on START-STOP UNIT SCSI command

Miquel Raynal (3):
      cmd: Change the dependencies between CMD_BIND and USB_GADGET
      cmd: bind: Try to improve the (un)bind help
      usb: udc: Try to clarify an error message

 cmd/Kconfig                         |  2 +-
 cmd/bind.c                          |  4 ++++
 drivers/dfu/Kconfig                 |  9 +++++++++
 drivers/usb/gadget/Kconfig          |  1 +
 drivers/usb/gadget/f_mass_storage.c |  7 +++++++
 drivers/usb/gadget/udc/udc-core.c   | 13 ++++++++++++-
 include/dfu.h                       |  5 +++++
 7 files changed, 39 insertions(+), 2 deletions(-)

