Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC34CF886B
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 20:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152CD8899C;
	Mon,  7 Oct 2024 22:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="o9Vm4YMV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD39B88B11; Mon,  7 Oct 2024 22:16:35 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A12508852B
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 22:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e28a083d531so2636502276.2
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 13:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1728332192; x=1728936992; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+kzWMb8PnOgGUnCo+FUnHUHYAZj9YPhaWHyVPybO1t0=;
 b=o9Vm4YMVtw8NYdC3C5uoGDG8wJ14ErTH3gnjGRNoNsS+bEX7+Vu61NCagINR9EZ+qw
 PPMSWRv8J0k0OE81bfWeRTKDiByA6jrexnfNeexEVzfTpO9qYerEByqRv03cMfSM8B9z
 QqgPkFzDi12GIAMd0y7TG8gsn8F/CQOeWHzSxI0Yz37KedG236rtu5pfDeMI2eV4QU7f
 ZRsyKuWwofF5hCeUbkXrM4CujYg9c2g4x+3xgzjpS8vd9NBJUQfp2s++04Nv8kyPFCs5
 5Fm0vTR2mXcKb3B/h4huSRK+v4PNDDB/II0R7RKyphHazhL2QogQp5Zwu5S9N9Q5W63b
 6uZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728332192; x=1728936992;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+kzWMb8PnOgGUnCo+FUnHUHYAZj9YPhaWHyVPybO1t0=;
 b=B8UbYKElgrPI1WpO3FdxTmqu6xNwcUcv25D2ikikbi2vLWTF76839y3bjf4qxzf8Sm
 QFQJ2D+D5I50e1Mzhh2wEbUXmgI5FOdoWIg7+yB61wjJ62EB8ewQPKx1UDf0fAxyJ22+
 yL0Thle9rQ3IZ/gSxh+gDPH4snJyPYSRJ5IYbeCq0KyMrvD8EVydmy9B/UsfBI23z4RQ
 aYVxRq+9wclpeXU5BxR/uIzvksCn+OybI5iiObEm1qOBFWmAUm4qCOBednGirbFHxP/d
 lBEeeKkoJWxM1eXvjqERhZENZXgCotJlF1HNBp62HMfx2xtozEZyc+ahC3tF5K8CTek7
 Me/w==
X-Gm-Message-State: AOJu0YypoEZrBcvaN2UyqGR/y9ZsKPudLb/rohB9CUGgUO9wrMV1YQ9N
 EhwveAf5XT5CDlgmOto4t9Msd2q/RFBLVrYgXEYdDXhW6TKId33RLYOdUSvKNRnxm0qj3hr2Ntf
 Rtmf0XEtbY6PSx+2ppnkDLImXA61zsLeKDfTe3jXWKIjh+ibvoX4=
X-Google-Smtp-Source: AGHT+IFA+4aAYDsvUj1SAjlgPfQCFOENfOj0e010UZx/jwKUwep4vBy7L13arn12vC5NRhR3lvSzzlwVSie6pxt8YZY=
X-Received: by 2002:a05:6902:230c:b0:e28:ea75:5a24 with SMTP id
 3f1490d57ef6-e28ea755ac7mr1071388276.30.1728332192124; Mon, 07 Oct 2024
 13:16:32 -0700 (PDT)
MIME-Version: 1.0
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 7 Oct 2024 13:16:20 -0700
Message-ID: <CAJ+vNU3wz22Ni+Kqy=NuFiEYPdrRkzjRJDNhYGJcCdDsLpbvBQ@mail.gmail.com>
Subject: modify live DT with OF_LIVE breaking phy_connect?
To: u-boot <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Greetings,

I have a need to adjust the U-Boot device-tree live with some board
revision specific fixups. It would seem I need to enable OF_LIVE to do
so but when I do this on imx8mm U-Boot proper seems to fail
phy_connect() called from the network device probe.

The board I'm working with is an imx8mm-venice board and using
imx8mm_venice_defconfig (without OF_LIVE) results in:
U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:58:38 -0700)

CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
CPU:   Industrial temperature grade (-40C to 105C) at 44C
Reset cause: POR
Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
DRAM:  4 GiB
Core:  226 devices, 32 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from redundant MMC(2)... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:   GPY111 eth0: ethernet@30be0000 [PRIME]
GSC     : boot watchdog disabled
Thermal protection:enabled at 96C
Hit any key to stop autoboot:  0

Yet as soon as I enable OF_LIVE:

U-Boot 2024.10-00735-gc530f6079c70 (Oct 07 2024 - 12:59:35 -0700)

CPU:   Freescale i.MX8MMQ rev1.0 1600 MHz (running at 1200 MHz)
CPU:   Industrial temperature grade (-40C to 105C) at 49C
Reset cause: POR
Model: Gateworks Venice GW73xx-0x i.MX8MM Development Kit
DRAM:  4 GiB
Core:  214 devices, 32 uclasses, devicetree: separate
WDT:   Started watchdog@30280000 with servicing every 1000ms (60s timeout)
MMC:   FSL_SDHC: 0, FSL_SDHC: 1, FSL_SDHC: 2
Loading Environment from MMC... Reading from redundant MMC(2)... OK
In:    serial@30890000
Out:   serial@30890000
Err:   serial@30890000
SEC0:  RNG instantiated
Net:   Could not get PHY for mdio: addr 0
Could not get PHY for FEC0: addr 0
Could not get PHY for mdio: addr 0
Could not get PHY for FEC0: addr 0
No ethernet found.
^^^ phy_connect failing

Any idea what I'm missing here?

Are there other ways I should be modifying the live dt in U-Boot?

Best Regards,

Tim
