Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459DFC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 19:02:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 883B988113;
	Tue,  2 Jul 2024 21:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="SHAZrYEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9239487EEE; Tue,  2 Jul 2024 21:02:36 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BD088757
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 21:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so2228666a12.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 12:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1719946950; x=1720551750; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKC2Iz4289V8RCYO7JQAvxMhjTlFoEbbY4y3e1Ok2yE=;
 b=SHAZrYEp85OtLjHZ1Y7jF9UEY6osmNbgaQFyiCt6w+lapOAICf3WU9Kq7iWh2Bz8a8
 IVgUHDFUbEWfEiO3gch6wHJXTCPN6MZOFHHscY4KvEkW8jaL6egVFXJSmjiPvOP9lzbM
 cNJugJR7P3/jiJkW63ndXNMA5J501mZBCDC26F8VgTLiQqc468kCBV4MYUbPhWyAKzIi
 VGVGWjUmdArvcNqEpaOe7jHFugAVZkF/6vGAEjyAQ9wwl7Epl+73e7T/MwujEsoq3QBa
 N8Oz0+vAYGvLHuJvE+HwKBooyyb32EVNVMsuCq+j9SRdYnj+kp4G+z9P9r/62l4mFOc2
 Fj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719946950; x=1720551750;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKC2Iz4289V8RCYO7JQAvxMhjTlFoEbbY4y3e1Ok2yE=;
 b=fcfP04bjY/ctFt9hquO239Dh1QAKqhdET9Bsi5YhRgQMZA0rS2g2vzSPTKFmvk83Uh
 1IsCB9N8Spi42priJZQH+dMKDf0piNar+HIr/87TWZ6k9BFtqspEKGym0BZcq0/Rwra5
 Bhh/KxvDNIQDrprb0Wc7TQGtQGSVoXPDIYxSwMmjZyWsoWY6YkWWLNxi/2aVVdEainNw
 z769KqvsJVzgUIuMLSmfAVo4G+jWiFw6keuh25sFhNmFk8RDrNGFsuOtllJfIUcpWvNi
 0uNTWDlRSFGApwIjvJPcTdAXI5WvOdCXU/DKtga1lzqFhlHo4EGaOIHQrrLr6wUyM8Ku
 I2ew==
X-Gm-Message-State: AOJu0YwQAO5xyDTu47fYq2uqxTTvHCTfSfpwePrd+4O51HWiEnXg7LL7
 JSr2oYuDVjGjE2J3i/Uhv7wB3X0Pn2/tExlXDQllJq4dfp9rlmBokC7guz2bXbl+HfiwzIR6nq/
 IpV8e5dwwpccwcRmOxYhH1YllAkMxWjoRv6+POA==
X-Google-Smtp-Source: AGHT+IH3Zs6ZlsLG0XPZjX4dJ7MsWdlqUTjbV4zYfvfPrJWG3/5aJiCpRofk3Pm5yS1vg9psVzzntG+ZOTI3diIDRq0=
X-Received: by 2002:a17:906:a3c6:b0:a6f:e60b:911a with SMTP id
 a640c23a62f3a-a751449f177mr769504366b.42.1719946949811; Tue, 02 Jul 2024
 12:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240531153635.246154-1-tharvey@gateworks.com>
 <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
 <6f37bd3dd369d3a63be7d8c00666c5e9@manjaro.org>
In-Reply-To: <6f37bd3dd369d3a63be7d8c00666c5e9@manjaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 2 Jul 2024 12:02:18 -0700
Message-ID: <CAJ+vNU3p9nb=2vH1V8pkT21982c8kkeT64xxWKWxQxMN0GtZMg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
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

On Tue, Jul 2, 2024 at 11:25=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello Tim,
>
> On 2024-07-02 20:14, Tim Harvey wrote:
> > On Fri, May 31, 2024 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gateworks.c=
om>
> > wrote:
> >>
> >> Modern eMMC v4+ devices have multiple hardware partitions per the
> >> JEDEC
> >> specification described as:
> >>  Boot Area Partition 1
> >>  Boot Area Partition 2
> >>  RPMB Partition
> >>  General Purpose Partition 1
> >>  General Purpose Partition 2
> >>  General Purpose Partition 3
> >>  General Purpose Partition 4
> >>  User Data Area
> >>
> >> These are referenced by fields in the PARTITION_CONFIG register
> >> (Extended CSD Register 179) which is defined as:
> >> bit 7: reserved
> >> bit 6: BOOT_ACK
> >>   0x0: No boot acknowledge sent (default
> >>   0x1: Boot acknowledge sent during boot operation Bit
> >> bit 5:3: BOOT_PARTITION_ENABLE
> >>   0x0: Device not boot enabled (default)
> >>   0x1: Boot Area partition 1 enabled for boot
> >>   0x2: Boot Area partition 2 enabled for boot
> >>   0x3-0x6: Reserved
> >>   0x7: User area enabled for boot
> >> bit 2:0 PARTITION_ACCESS
> >>   0x0: No access to boot partition (default)
> >>   0x1: Boot Area partition 1
> >>   0x2: Boot Area partition 2
> >>   0x3: Replay Protected Memory Block (RPMB)
> >>   0x4: Access to General Purpose partition 1
> >>   0x5: Access to General Purpose partition 2
> >>   0x6: Access to General Purpose partition 3
> >>   0x7: Access to General Purpose partition 4
> >>
> >> Note that setting PARTITION_ACCESS to 0x0 results in selecting the
> >> User
> >> Data Area partition.
> >>
> >> You can see above that the two fields BOOT_PARTITION_ENABLE and
> >> PARTITION_ACCESS do not use the same enumerated values.
> >>
> >> U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
> >> register:
> >> EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
> >> EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
> >> EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
> >> EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
> >>
> >> EXT_CSD_BOOT_ACK(x)             (x << 6)
> >> EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
> >> EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
> >>
> >> EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
> >> EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
> >> EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
> >>
> >> There are various places in U-Boot where the BOOT_PARTITION_ENABLE
> >> field
> >> is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
> >> hardware partition consistent with the definition of the
> >> PARTITION_ACCESS field used by the various mmc_switch incarnations.
> >>
> >> To add some sanity to the distinction between BOOT_PARTITION_ENABLE
> >> (used to specify the active device on power-cycle) and
> >> PARTITION_ACCESS
> >> (used to switch between hardware partitions) create two enumerated
> >> types
> >> and use them wherever struct mmc * part_config is used or the above
> >> macros are used.
> >>
> >> Additionally provide arrays of the field names and allow those to be
> >> used in the 'mmc partconf' command and in board support files.
> >>
> >> The first patch adds enumerated types and makes use of them which
> >> represents no compiled code change.
> >>
> >> The 2nd patch adds the array of names and uses them in the 'mmc
> >> partconf' command.
> >>
> >> The 3rd patch uses the array of hardware partition names in a board
> >> support file to show what emmc hardware partition U-Boot is being
> >> loaded
> >> from.
> >>
> >> I'm sending this as a series this time around as previously it was
> >> repsented as two different patches.
> >>
> >> Tim Harvey (3):
> >>   mmc: use an enumerated type to represent PARTITION_CONFIG fields
> >>   mmc: allow use of hardware partition names for mmc partconf
> >>   venice: show emmc boot hardware partition
> >>
> >>  arch/arm/mach-imx/image-container.c | 10 ++++-----
> >>  arch/arm/mach-sunxi/board.c         |  2 +-
> >>  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
> >>  board/gateworks/venice/venice.c     | 22 +++++++++---------
> >>  board/purism/librem5/librem5.c      |  4 ++--
> >>  board/storopack/smegw01/smegw01.c   |  4 ++--
> >>  cmd/mmc.c                           | 27 ++++++++++++++++++----
> >>  cmd/mvebu/bubt.c                    |  4 ++--
> >>  common/spl/spl_mmc.c                |  4 ++--
> >>  drivers/mmc/mmc.c                   | 35
> >> +++++++++++++++++++++++++++++
> >>  include/mmc.h                       | 26 +++++++++++++++++++++
> >>  11 files changed, 123 insertions(+), 35 deletions(-)
> >
> > Is there any feedback on this series? I got feedback from several
> > people on my first attempt (cc'd) but nothing on this version.
>
> Any chances, please, to provide links to each of the patch and series
> versions on https://lore.kernel.org/u-boot/ , together with a brief
> changelog and history?  I'm having troubles refreshing my memory on
> what patches were actually pulled into what series.
>
> My guess is that other people would also benefit from such a refresher.

Hi Dragan,

Yes, I should have done that. Here are the references:
- latest v4 series:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D409052
(combined two patches into series)
- v3: https://patchwork.ozlabs.org/project/uboot/patch/20240427001157.14603=
02-1-tharvey@gateworks.com/
- v2: https://patchwork.ozlabs.org/project/uboot/patch/20240426171205.13822=
12-1-tharvey@gateworks.com/
- v1: https://patchwork.ozlabs.org/project/uboot/patch/20240426001419.12103=
64-1-tharvey@gateworks.com/
- https://patchwork.ozlabs.org/project/uboot/patch/20240426165554.1376497-1=
-tharvey@gateworks.com/
- display emmc hardware partition for venice

Best Regards,

Tim
