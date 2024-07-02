Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6355AC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FA6688712;
	Tue,  2 Jul 2024 20:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="TBoCY08a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA26B886A0; Tue,  2 Jul 2024 20:14:32 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6FDA88722
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-58be2b8b6b2so1125521a12.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719944069; x=1720548869; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3TW5g4pSwt/RfgoSwTdB4qD7yn1QXSuxN7CGjXaFls=;
 b=TBoCY08ajZ/I1f10q6WbfGMIqmPtjG0pNyXcOON3ony0vGuOi+En9WLhbUh0IqeoSN
 TjjxqvgA0F8aHmeDqEySNW2DWAZdmi/MD6HhUW1vIwV2XyLFm4OY7n2VhDuqM8Wo5bI4
 DZAe3dMJvHfcDvBpSI5+txWz9aAvUfhIrQQHFxdSPPgVmsXt/bw7MTnQZST9cHGyaOVs
 JodczqxI9Y18zwGnniBJqSvYZdfWcDPjmK0bcYUVX2L15Uym9qoca8nN8mbkEpXMSEQ6
 qtx98iDB5C1HPb5GICtSnhhDLETZPjidJtGK2j1HmEp8YSG3NRWFUyzrCI5MQV+8lr4V
 hYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944069; x=1720548869;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m3TW5g4pSwt/RfgoSwTdB4qD7yn1QXSuxN7CGjXaFls=;
 b=pUu10Q5DLIag2l8Pgba0o4q7Q09vBmPRaBqI1n34ly9mffTp9L24PxGM30WSEGB0tR
 5QRKKbXLfncnAgAa4n0INTWJRrqGX9kY5RojePYI3pAV1Ece7uKTSa6FTm1pS65f26r4
 WLKrPWMXDHv00FtcGm1wg5vuUvy4laWExufnfZbrcpQrijuGSEEIaEBFz4U8g8rAPD0z
 bKh3j+5+AhiDm/G48/rPPipm9lco6XF9IQMSI8Ff9+Wn8QkNeOngXSfPfYUDpA4EjEAM
 pkt+0oqR5VV6sOkQPddA92g6EST1Dis8W4cYOXbFul8ff6q/sCyvzbFKkNu5c5HSg5zD
 c+zw==
X-Gm-Message-State: AOJu0YwXSpNus7rQaCgF5xlu6VK3KaZY+9/HCcAbyRwDkD2nL0sCtFw4
 qYPbHOHqDLc/Yfi0yCsic8mcjYnK1h3kthufW0oaOZwUExX29d4lOze8UDPtUggzhhgH0VvBglE
 t6pAZWm7Hen1eQdp1gw0hjPi2G1Q6HjI1YA/GIWRAxcDLGItWag0=
X-Google-Smtp-Source: AGHT+IHzwQ3NcMviUHOM6gjnd6Dlvu8uxwBSTtHQdT4IJ86YGdUzOfS4E37Qj8bCuBF3WmSxmWmi3CqmWW8aOA6rAr0=
X-Received: by 2002:a17:906:690:b0:a72:b1f0:fb50 with SMTP id
 a640c23a62f3a-a751441a672mr655747866b.3.1719944068734; Tue, 02 Jul 2024
 11:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240531153635.246154-1-tharvey@gateworks.com>
In-Reply-To: <20240531153635.246154-1-tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 2 Jul 2024 11:14:15 -0700
Message-ID: <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Dragan Simic <dsimic@manjaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
 Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, May 31, 2024 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> Modern eMMC v4+ devices have multiple hardware partitions per the JEDEC
> specification described as:
>  Boot Area Partition 1
>  Boot Area Partition 2
>  RPMB Partition
>  General Purpose Partition 1
>  General Purpose Partition 2
>  General Purpose Partition 3
>  General Purpose Partition 4
>  User Data Area
>
> These are referenced by fields in the PARTITION_CONFIG register
> (Extended CSD Register 179) which is defined as:
> bit 7: reserved
> bit 6: BOOT_ACK
>   0x0: No boot acknowledge sent (default
>   0x1: Boot acknowledge sent during boot operation Bit
> bit 5:3: BOOT_PARTITION_ENABLE
>   0x0: Device not boot enabled (default)
>   0x1: Boot Area partition 1 enabled for boot
>   0x2: Boot Area partition 2 enabled for boot
>   0x3-0x6: Reserved
>   0x7: User area enabled for boot
> bit 2:0 PARTITION_ACCESS
>   0x0: No access to boot partition (default)
>   0x1: Boot Area partition 1
>   0x2: Boot Area partition 2
>   0x3: Replay Protected Memory Block (RPMB)
>   0x4: Access to General Purpose partition 1
>   0x5: Access to General Purpose partition 2
>   0x6: Access to General Purpose partition 3
>   0x7: Access to General Purpose partition 4
>
> Note that setting PARTITION_ACCESS to 0x0 results in selecting the User
> Data Area partition.
>
> You can see above that the two fields BOOT_PARTITION_ENABLE and
> PARTITION_ACCESS do not use the same enumerated values.
>
> U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
> register:
> EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
> EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
> EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
> EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
>
> EXT_CSD_BOOT_ACK(x)             (x << 6)
> EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
> EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
>
> EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
> EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
> EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
>
> There are various places in U-Boot where the BOOT_PARTITION_ENABLE field
> is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
> hardware partition consistent with the definition of the
> PARTITION_ACCESS field used by the various mmc_switch incarnations.
>
> To add some sanity to the distinction between BOOT_PARTITION_ENABLE
> (used to specify the active device on power-cycle) and PARTITION_ACCESS
> (used to switch between hardware partitions) create two enumerated types
> and use them wherever struct mmc * part_config is used or the above
> macros are used.
>
> Additionally provide arrays of the field names and allow those to be
> used in the 'mmc partconf' command and in board support files.
>
> The first patch adds enumerated types and makes use of them which
> represents no compiled code change.
>
> The 2nd patch adds the array of names and uses them in the 'mmc
> partconf' command.
>
> The 3rd patch uses the array of hardware partition names in a board
> support file to show what emmc hardware partition U-Boot is being loaded
> from.
>
> I'm sending this as a series this time around as previously it was
> repsented as two different patches.
>
> Tim Harvey (3):
>   mmc: use an enumerated type to represent PARTITION_CONFIG fields
>   mmc: allow use of hardware partition names for mmc partconf
>   venice: show emmc boot hardware partition
>
>  arch/arm/mach-imx/image-container.c | 10 ++++-----
>  arch/arm/mach-sunxi/board.c         |  2 +-
>  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
>  board/gateworks/venice/venice.c     | 22 +++++++++---------
>  board/purism/librem5/librem5.c      |  4 ++--
>  board/storopack/smegw01/smegw01.c   |  4 ++--
>  cmd/mmc.c                           | 27 ++++++++++++++++++----
>  cmd/mvebu/bubt.c                    |  4 ++--
>  common/spl/spl_mmc.c                |  4 ++--
>  drivers/mmc/mmc.c                   | 35 +++++++++++++++++++++++++++++
>  include/mmc.h                       | 26 +++++++++++++++++++++
>  11 files changed, 123 insertions(+), 35 deletions(-)
>
> --
> 2.25.1
>

Greetings,

Is there any feedback on this series? I got feedback from several
people on my first attempt (cc'd) but nothing on this version.

Best Regards,

Tim
