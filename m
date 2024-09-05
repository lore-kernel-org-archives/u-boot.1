Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A618CD98EC
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 18:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D08A88CBA;
	Thu,  5 Sep 2024 20:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="bLTD0qkR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E24B885A8; Thu,  5 Sep 2024 20:11:28 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7800488CC1
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 20:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2068a7c9286so10864115ad.1
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 11:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1725559884; x=1726164684; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EL3LPOotKzp9ruMVXNlaBXKSxT6LpB9X6TM5x89HVfE=;
 b=bLTD0qkRtrgZHF3iO96dZmEr6HjJuVjizfVek8Lfbakl5NSlHHhBCTGQeKrVEkRL8x
 DysP2XpakB2lrGmc40N1T6RaC6Of7sVkLUSbJSDjeiGGjXrCb7ERg728XuGnVI3Sl/Cc
 NBQ9C2mOrpluhxxMC2Hm8w+rCrkdEehzPteFPZbzxiZPyXQ3W2k88aoMtc2Zk6K+EucC
 TWfAemsQMkiuJM7ZOMVsAqOVZZC+m5Tg0yYFulYYk/WzLeddqciIROgjp1HjHjJ+YOED
 1UdWUF0A+e9U04+HyKwXaynr1cpY0LxI8gwatC1Mi/O3jh7kgppsjXviF2k8OgUg1QKZ
 ho5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725559884; x=1726164684;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EL3LPOotKzp9ruMVXNlaBXKSxT6LpB9X6TM5x89HVfE=;
 b=uwBxx0rdiFdT8K5xEDFlG6l3L93R6eQ+2ckeI+w02dXmUIA1tmo7u3Yy1K6upCdEl2
 za1ff7l3WIDwCQzQeuVNuSRgoOBSqOFNJCUiCqlHHyR+Mmb471TWKa88Kt5LnzonVbvl
 2Oo7QZHvYZOI1kVNs6y+H9z/vIoINROa6TttC5ASr2REbJwtkLJ8dZ4La379+yhhB42y
 KgS1jNC17B6Kv/diMyqlW/ITnaqhSbZ0ZLnkiNI1eBh0EP/fEyezVD5/mh/h3CkHoL11
 3ShS+TvlPd5oRpw2le0/gxg1mQwlCQRobWN9Ku7miaL0D22+ZJ9I2y3in8hYZLSC+TQH
 U8RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/iOlVNjnSMrjZC3pwKG/YGNYqz7rwgHH/u0BnVOzA3xLDd/thTcsXNsAFFb6gjo+GtgLXdY0=@lists.denx.de
X-Gm-Message-State: AOJu0YyIicm53jSa6zMfHd1aL/Q9gkkLRrIbbD6EyIvok8GRgVi9mIET
 VQyRlWH6+fvPSYKO1Ct266eRGFfyH55y0idZOK3tMhfw933HNKnbgpKdwX8LVvq2JG0PRpAXo4J
 h5Xv4o5ZgLVLr4VjsEuGwPv6UENRpzGWP/O14aA==
X-Google-Smtp-Source: AGHT+IHg7UV4cInjXI5y1ANWuwT2TTFGh3UbL3Z7HRi6MsFKRsnXk7vbvtSxJdSWkpYhyLLaEWi5juM/oMYwE8utR+k=
X-Received: by 2002:a17:902:da88:b0:205:7835:38e2 with SMTP id
 d9443c01a7336-205841c02b0mr176817325ad.36.1725559883608; Thu, 05 Sep 2024
 11:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240531153635.246154-1-tharvey@gateworks.com>
 <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
 <20240702192341.GR38804@bill-the-cat>
 <CAJ+vNU2+sYPS3pmOJs66wDc8-uXO0uosa=USRaDUTDHR=6TfOA@mail.gmail.com>
In-Reply-To: <CAJ+vNU2+sYPS3pmOJs66wDc8-uXO0uosa=USRaDUTDHR=6TfOA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 5 Sep 2024 11:11:10 -0700
Message-ID: <CAJ+vNU3vHGrp1gKCrYJYkvQ-SjjpyFSfO5mNeinHL_70v5PgXg@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
To: Tom Rini <trini@konsulko.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
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

On Mon, Aug 12, 2024 at 12:25=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> On Tue, Jul 2, 2024 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Tue, Jul 02, 2024 at 11:14:15AM -0700, Tim Harvey wrote:
> > > On Fri, May 31, 2024 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gateworks=
.com> wrote:
> > > >
> > > > Modern eMMC v4+ devices have multiple hardware partitions per the J=
EDEC
> > > > specification described as:
> > > >  Boot Area Partition 1
> > > >  Boot Area Partition 2
> > > >  RPMB Partition
> > > >  General Purpose Partition 1
> > > >  General Purpose Partition 2
> > > >  General Purpose Partition 3
> > > >  General Purpose Partition 4
> > > >  User Data Area
> > > >
> > > > These are referenced by fields in the PARTITION_CONFIG register
> > > > (Extended CSD Register 179) which is defined as:
> > > > bit 7: reserved
> > > > bit 6: BOOT_ACK
> > > >   0x0: No boot acknowledge sent (default
> > > >   0x1: Boot acknowledge sent during boot operation Bit
> > > > bit 5:3: BOOT_PARTITION_ENABLE
> > > >   0x0: Device not boot enabled (default)
> > > >   0x1: Boot Area partition 1 enabled for boot
> > > >   0x2: Boot Area partition 2 enabled for boot
> > > >   0x3-0x6: Reserved
> > > >   0x7: User area enabled for boot
> > > > bit 2:0 PARTITION_ACCESS
> > > >   0x0: No access to boot partition (default)
> > > >   0x1: Boot Area partition 1
> > > >   0x2: Boot Area partition 2
> > > >   0x3: Replay Protected Memory Block (RPMB)
> > > >   0x4: Access to General Purpose partition 1
> > > >   0x5: Access to General Purpose partition 2
> > > >   0x6: Access to General Purpose partition 3
> > > >   0x7: Access to General Purpose partition 4
> > > >
> > > > Note that setting PARTITION_ACCESS to 0x0 results in selecting the =
User
> > > > Data Area partition.
> > > >
> > > > You can see above that the two fields BOOT_PARTITION_ENABLE and
> > > > PARTITION_ACCESS do not use the same enumerated values.
> > > >
> > > > U-Boot uses a set of macros to access fields of the PARTITION_CONFI=
G
> > > > register:
> > > > EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
> > > > EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
> > > > EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
> > > > EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
> > > >
> > > > EXT_CSD_BOOT_ACK(x)             (x << 6)
> > > > EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
> > > > EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
> > > >
> > > > EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
> > > > EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
> > > > EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
> > > >
> > > > There are various places in U-Boot where the BOOT_PARTITION_ENABLE =
field
> > > > is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
> > > > hardware partition consistent with the definition of the
> > > > PARTITION_ACCESS field used by the various mmc_switch incarnations.
> > > >
> > > > To add some sanity to the distinction between BOOT_PARTITION_ENABLE
> > > > (used to specify the active device on power-cycle) and PARTITION_AC=
CESS
> > > > (used to switch between hardware partitions) create two enumerated =
types
> > > > and use them wherever struct mmc * part_config is used or the above
> > > > macros are used.
> > > >
> > > > Additionally provide arrays of the field names and allow those to b=
e
> > > > used in the 'mmc partconf' command and in board support files.
> > > >
> > > > The first patch adds enumerated types and makes use of them which
> > > > represents no compiled code change.
> > > >
> > > > The 2nd patch adds the array of names and uses them in the 'mmc
> > > > partconf' command.
> > > >
> > > > The 3rd patch uses the array of hardware partition names in a board
> > > > support file to show what emmc hardware partition U-Boot is being l=
oaded
> > > > from.
> > > >
> > > > I'm sending this as a series this time around as previously it was
> > > > repsented as two different patches.
> > > >
> > > > Tim Harvey (3):
> > > >   mmc: use an enumerated type to represent PARTITION_CONFIG fields
> > > >   mmc: allow use of hardware partition names for mmc partconf
> > > >   venice: show emmc boot hardware partition
> > > >
> > > >  arch/arm/mach-imx/image-container.c | 10 ++++-----
> > > >  arch/arm/mach-sunxi/board.c         |  2 +-
> > > >  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
> > > >  board/gateworks/venice/venice.c     | 22 +++++++++---------
> > > >  board/purism/librem5/librem5.c      |  4 ++--
> > > >  board/storopack/smegw01/smegw01.c   |  4 ++--
> > > >  cmd/mmc.c                           | 27 ++++++++++++++++++----
> > > >  cmd/mvebu/bubt.c                    |  4 ++--
> > > >  common/spl/spl_mmc.c                |  4 ++--
> > > >  drivers/mmc/mmc.c                   | 35 +++++++++++++++++++++++++=
++++
> > > >  include/mmc.h                       | 26 +++++++++++++++++++++
> > > >  11 files changed, 123 insertions(+), 35 deletions(-)
> > > >
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > Greetings,
> > >
> > > Is there any feedback on this series? I got feedback from several
> > > people on my first attempt (cc'd) but nothing on this version.
> >
> > Jaehoon, will you have time to review and pick this up, now that the
> > merge window is open? Thanks.
> >
>
> Hi Tom,
>
> I have not seen any emails from Jaehoon on mainline lists since early May=
.
>
> Best Regards,
>
> Tim

Hi Tom,

gentle ping here... not sure what you want me to do with this series.

Best Regards,

Tim
