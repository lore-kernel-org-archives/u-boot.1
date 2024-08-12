Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE215C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 19:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A852C88853;
	Mon, 12 Aug 2024 21:26:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="TKqWNZwf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD46886A7; Mon, 12 Aug 2024 21:26:13 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE2DD88853
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 21:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52efd8807aaso6171058e87.3
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1723490766; x=1724095566; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7I8s3XYe3bp4WbrsoFTAX9GhK687wu4Rci8IuR5u90=;
 b=TKqWNZwfeZfaeC0tv923Oeq2LZ+JzbD6R9NchFEGuJwmdgzwahVL7+wxC9jmVZUejQ
 awZHP+hwZDK715+txQnvGbdIRry/k7wCYH0sfD4+7yPEjNb99dYhvxtJWh4k95kCOtls
 5TFfrKrOrytjIxK0BspFTDINLmtegysLdv4b4RKKjTrb/ZWjthiLeYxfoedxFKNouuAH
 k8ZcIdbQa82l0poxtNAItGJLHIM7DDXd3ErtIU7KPxt057WLeQ2DHf9qM2plllaEHhr/
 LtD5C1eOkb21l+pc8l3py4VnUf7v+Zhbx1T1dPbMGUXtATAskwx3/azs00Y9XnBKKBKU
 fGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723490766; x=1724095566;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C7I8s3XYe3bp4WbrsoFTAX9GhK687wu4Rci8IuR5u90=;
 b=bYKg65s/9Av+CDR+ZpnkUW//kz5JEyfAHABPU67HYfx9AU1OIBFr4AW2w5t1K6fUEf
 HqaSP4td4Kv9ptdLs/tyMf+3ZAO2cUjIMYBG/vmvO+IVQkl9zctN3zW0blbv3onlmAt2
 m8tr12DkFwA8gH5W8VxNrKt5P6tF9mptlv9sKYuIWge3n1w0Wk1r3UL2KNUKVsao39XB
 cI6uJS9uWYo1rea3BuAvOUJzDe1VzGAevVStLb/97WQHRxYZbWFd4v+VF3OA/VDXPszt
 hgG+WVmkD68bPwVQCIDD5IXSiQsW5vGXXjcVnXNSrzHajMNioMQmjhXTUYtrpPocX9U8
 9Ixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWCbECseqE9M/q+Prrr59GkO5iaX6EAaXFI091L03j7a1HdRDrLcaKt4rp/RSjHlPGzTblS8UY0V0mOyLIiF3Wq3KI/Q==
X-Gm-Message-State: AOJu0YwWVuUaYX/kVpWLk6XaHdG+owwHHGQnKUhApRxZSCVyj7gVRxiw
 SoX4SgRY76XtFXoL1vfYrRZ9yxB7RWfblu+qflLSK5QVppFCjnQy2xOWcMPVg+LgnGKrsShoEtw
 HKKT+mewRLlecreJHZIzYp0K8vrxYmTwJG9G7Fw==
X-Google-Smtp-Source: AGHT+IEQsUgmFFbowoOnGDgQqLbrs6UiCb1S2nTNLfr1mZMHcEXOe0/6HzlCo5oP6kv1WuBQYd6KPk9ISYiRUqMvy+I=
X-Received: by 2002:a05:6512:b94:b0:52e:fd53:a25e with SMTP id
 2adb3069b0e04-5321364b515mr736589e87.2.1723490765057; Mon, 12 Aug 2024
 12:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240531153635.246154-1-tharvey@gateworks.com>
 <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
 <20240702192341.GR38804@bill-the-cat>
In-Reply-To: <20240702192341.GR38804@bill-the-cat>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 12 Aug 2024 12:25:52 -0700
Message-ID: <CAJ+vNU2+sYPS3pmOJs66wDc8-uXO0uosa=USRaDUTDHR=6TfOA@mail.gmail.com>
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

On Tue, Jul 2, 2024 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Tue, Jul 02, 2024 at 11:14:15AM -0700, Tim Harvey wrote:
> > On Fri, May 31, 2024 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gateworks.c=
om> wrote:
> > >
> > > Modern eMMC v4+ devices have multiple hardware partitions per the JED=
EC
> > > specification described as:
> > >  Boot Area Partition 1
> > >  Boot Area Partition 2
> > >  RPMB Partition
> > >  General Purpose Partition 1
> > >  General Purpose Partition 2
> > >  General Purpose Partition 3
> > >  General Purpose Partition 4
> > >  User Data Area
> > >
> > > These are referenced by fields in the PARTITION_CONFIG register
> > > (Extended CSD Register 179) which is defined as:
> > > bit 7: reserved
> > > bit 6: BOOT_ACK
> > >   0x0: No boot acknowledge sent (default
> > >   0x1: Boot acknowledge sent during boot operation Bit
> > > bit 5:3: BOOT_PARTITION_ENABLE
> > >   0x0: Device not boot enabled (default)
> > >   0x1: Boot Area partition 1 enabled for boot
> > >   0x2: Boot Area partition 2 enabled for boot
> > >   0x3-0x6: Reserved
> > >   0x7: User area enabled for boot
> > > bit 2:0 PARTITION_ACCESS
> > >   0x0: No access to boot partition (default)
> > >   0x1: Boot Area partition 1
> > >   0x2: Boot Area partition 2
> > >   0x3: Replay Protected Memory Block (RPMB)
> > >   0x4: Access to General Purpose partition 1
> > >   0x5: Access to General Purpose partition 2
> > >   0x6: Access to General Purpose partition 3
> > >   0x7: Access to General Purpose partition 4
> > >
> > > Note that setting PARTITION_ACCESS to 0x0 results in selecting the Us=
er
> > > Data Area partition.
> > >
> > > You can see above that the two fields BOOT_PARTITION_ENABLE and
> > > PARTITION_ACCESS do not use the same enumerated values.
> > >
> > > U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
> > > register:
> > > EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
> > > EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
> > > EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
> > > EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
> > >
> > > EXT_CSD_BOOT_ACK(x)             (x << 6)
> > > EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
> > > EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
> > >
> > > EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
> > > EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
> > > EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
> > >
> > > There are various places in U-Boot where the BOOT_PARTITION_ENABLE fi=
eld
> > > is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
> > > hardware partition consistent with the definition of the
> > > PARTITION_ACCESS field used by the various mmc_switch incarnations.
> > >
> > > To add some sanity to the distinction between BOOT_PARTITION_ENABLE
> > > (used to specify the active device on power-cycle) and PARTITION_ACCE=
SS
> > > (used to switch between hardware partitions) create two enumerated ty=
pes
> > > and use them wherever struct mmc * part_config is used or the above
> > > macros are used.
> > >
> > > Additionally provide arrays of the field names and allow those to be
> > > used in the 'mmc partconf' command and in board support files.
> > >
> > > The first patch adds enumerated types and makes use of them which
> > > represents no compiled code change.
> > >
> > > The 2nd patch adds the array of names and uses them in the 'mmc
> > > partconf' command.
> > >
> > > The 3rd patch uses the array of hardware partition names in a board
> > > support file to show what emmc hardware partition U-Boot is being loa=
ded
> > > from.
> > >
> > > I'm sending this as a series this time around as previously it was
> > > repsented as two different patches.
> > >
> > > Tim Harvey (3):
> > >   mmc: use an enumerated type to represent PARTITION_CONFIG fields
> > >   mmc: allow use of hardware partition names for mmc partconf
> > >   venice: show emmc boot hardware partition
> > >
> > >  arch/arm/mach-imx/image-container.c | 10 ++++-----
> > >  arch/arm/mach-sunxi/board.c         |  2 +-
> > >  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
> > >  board/gateworks/venice/venice.c     | 22 +++++++++---------
> > >  board/purism/librem5/librem5.c      |  4 ++--
> > >  board/storopack/smegw01/smegw01.c   |  4 ++--
> > >  cmd/mmc.c                           | 27 ++++++++++++++++++----
> > >  cmd/mvebu/bubt.c                    |  4 ++--
> > >  common/spl/spl_mmc.c                |  4 ++--
> > >  drivers/mmc/mmc.c                   | 35 +++++++++++++++++++++++++++=
++
> > >  include/mmc.h                       | 26 +++++++++++++++++++++
> > >  11 files changed, 123 insertions(+), 35 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Greetings,
> >
> > Is there any feedback on this series? I got feedback from several
> > people on my first attempt (cc'd) but nothing on this version.
>
> Jaehoon, will you have time to review and pick this up, now that the
> merge window is open? Thanks.
>

Hi Tom,

I have not seen any emails from Jaehoon on mainline lists since early May.

Best Regards,

Tim
