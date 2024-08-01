Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49178C3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 13:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B278188A9B;
	Thu,  1 Aug 2024 15:07:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LKDVSsWX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A845288ADF; Thu,  1 Aug 2024 15:07:17 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76A90884DB
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 15:07:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b7a3773a95so39138186d6.2
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 06:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722517634; x=1723122434; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Aaozah0U6ZnAXoxPoMzHntUvUufchCmGmw7m6Nawfrc=;
 b=LKDVSsWXKbCZC9QoHujSsAOy3xn1EFHMCNrqODpUXaTNIWGOY3VhLhmPrMOcUYhweQ
 11Q6jui8A8S8oBFRuEUuQcFThuz5DmIoAgqJxh7RVE0Dn23r04LiHrSLn7ews/ZdKRcP
 Le9v/d0vCfcc9Bn6v2ftAwjn76WDeE+73SpjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722517634; x=1723122434;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aaozah0U6ZnAXoxPoMzHntUvUufchCmGmw7m6Nawfrc=;
 b=HmdO9hShqaENi8ZFrmu8VWS45bm9+SRupo2aAihIE5QmmYSIacNqSzq5OsFoaD7Syy
 dkSk1tgfnHdZsIGAy2iUcm9tTS/icU80FBfofXMrxs7ubLq4nHQytcwayhtZBTIIBYAm
 u8AxfncKj2vnqPgolbLwk14urHlTkohigt5GcZWoe0Z3eCT4wTmBA1oLz3L4Kytfpk9r
 IHb0kOPy909ttasNvWaqrCt6czqina3WrOPsO7+dktDc0lNRPaAZEOJFjgHjMJmtRcLg
 DKFHMKvjjw4WApcrFJNIcSWw7RLa9Nb1+OmBnW8OZ6m2fHVAzah6krESvyqC2EjmJw5/
 YtGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqnOsrZ2sPqFyya88pyI89vrtGg0r+J5MII2T4nPidhA/IfK9zIAa/+WLL5QItA+PXVriPd8CwRss0NpZWxFOVkCGZ4Q==
X-Gm-Message-State: AOJu0YxK8rsZlwwFuD2DAmlUyOhzgWJ5WZmz+RS9acIuSj2Pl6dQQDoU
 TalhsKP6wCmCU3s6GmufVNvI4gI6TnZatoUpe+FcWOLIJWVpApTROxd/V4uxFuXEhh+hIeQyd9B
 jePD+Fo4GDxJj7yMDJATfoQfziTWHU4bXIUDz
X-Google-Smtp-Source: AGHT+IGsrmSCbkRVWEPPyhxuBg7vi9d44CkS4aJ74fiOw0VNmMpN0hkZNktWGekedbPK+lWWG2B/W8EAdyc3rUknLzE=
X-Received: by 2002:a05:6214:4b03:b0:6b5:e5fc:b8dc with SMTP id
 6a1803df08f44-6bb98332383mr196766d6.15.1722517634175; Thu, 01 Aug 2024
 06:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240801083656.1936910-1-jonas@kwiboo.se>
In-Reply-To: <20240801083656.1936910-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 07:07:03 -0600
Message-ID: <CAFLszTi6=T3Tv0JXjBereHcqHcBn9kvYVxzquH+gAsSJ1cLg5A@mail.gmail.com>
Subject: Re: [RFC] rockchip: rk3399: Migrate to use TPL on bob and kevin
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 u-boot@lists.denx.de
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

Hi Jonas,

On Thu, 1 Aug 2024 at 02:37, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> All Rockchip aarch64 boards, beside bob and kevin, use TPL to initialize
> DRAM and SPL to load FIT with U-Boot proper and TF-A.
>
> Bob and kevin currently does not use TPL and instead initialize DRAM
> in SPL and directly after tries to load FIT with U-Boot proper and TF-A.
>
> This RFC try to migrate bob and kevin to also use TPL to uniform TPL/SPL
> use for all Rockchip aarch64 boards.

Thanks for doing this!

>
> Notes and questions:
> - Is u-boot.rom even used for bob/kevin? It use u-boot-img, yet SPL
>   expect to load FIT and does not permit use of raw imgage.

Yes it does use u-boot.rom

>
>   Q: Can we remove what looks to be a faulty u-boot.rom definition and
>      just use u-boot-rockchip-spi.bin instead?

Maybe, but we do need the image to be the correct size.

>
> - FIT location moved from 0x40000 to 0xE0000 in SPI flash to allow for a
>   larger SPL, up to 256 KiB, same as on other RK3399 boards.
>
>   Q: Can we use this location?, or is there something external that
>     expects fit or u-boot-img at this location?

It should be fine.

>
> Features that is now used:
> - Use of Rockchip aarch64 common bss and stack addresses
> - Checksum/signature check of FIT images in SPL
> - Use of dcache to speed up checksum check in SPL
> - SDMA use for eMMC access to speed up read/write in U-Boot proper
>
> Changes that would be good for future:
> - Include and use pinctrl in SPL

Yes

> - Use dm gpio instead of spl_gpio functions in SPL

Where are you looking for spl_gpio? I'm not seeing it.

>
> I do not have any bob or kevin so this has only been compile tested.
>
> This should be broken down into smaller logical patches if this is
> accepted and works on real hardware.

I forgot that I broke my bob and need to fix it. For kevin (which is
very similar):

before:
06:57 $ ub-int kevin
Building U-Boot in sourcedir for chromebook_kevin
Bootstrapping U-Boot from dir /tmp/b/chromebook_kevin
Writing U-Boot using method em100
Channel 0: LPDDR3, 933MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
Channel 1: LPDDR3, 933MHz
BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
256B stride

U-Boot SPL 2024.07-rc4-00009-g0ae095f4664 (Aug 01 2024 - 06:57:12 -0600)
Bloblist at 100000 not found (err=-2)
Trying to boot from SPI
ns16550_serial serial@ff1a0000: pinctrl_select_state_full:
uclass_get_device_by_phandle_id: err=-19


U-Boot 2024.07-rc4-00009-g0ae095f4664 (Aug 01 2024 - 06:57:12 -0600)

Model: Google Kevin
DRAM:  4 GiB (effective 3.9 GiB)
Core:  329 devices, 33 uclasses, devicetree: separate
MMC:   mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from MMC... Reading from MMC(0)... *** Warning -
bad CRC, using default environment

edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
In:    serial,cros-ec-keyb
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: Google Kevin
Net:   No ethernet found.

Hit any key to stop autoboot:  0
=>

with your patch:
06:53 $ ub-int kevin
Building U-Boot in sourcedir for chromebook_kevin
Bootstrapping U-Boot from dir /tmp/b/chromebook_kevin
Writing U-Boot using method em100

U-Boot SPL 2024.07-rc4-00010-g14d97804e94 (Aug 01 2024 - 06:53:17 -0600)
Checksum 0 != 68
Bloblist at 100000 not found (err=-5)
Trying to boot from SPI
## Checking hash(es) for config conf-1 ... OK
## Checking hash(es) for Image firmware-1 ... crc32+ OK
## Checking hash(es) for Image fdt-1 ... crc32+ OK
ns16550_serial serial@ff1a0000: pinctrl_select_state_full:
uclass_get_device_by_phandle_id: err=-19


U-Boot 2024.07-rc4-00010-g14d97804e94 (Aug 01 2024 - 06:53:17 -0600)

Model: Google Kevin
DRAM:  4 GiB (effective 3.9 GiB)
Core:  330 devices, 34 uclasses, devicetree: separate
MMC:   mmc@fe320000: 1, mmc@fe330000: 0
Loading Environment from MMC... Reading from MMC(0)... *** Warning -
bad CRC, using default environment

edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
edp_rockchip dp@ff970000: failed to set rate on clock index 0 (362) (error = -2)
In:    serial,cros-ec-keyb
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: Google Kevin
Net:   No ethernet found.

Hit any key to stop autoboot:  0
=>

Regards,
SImon
