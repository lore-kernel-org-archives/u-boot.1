Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E42D116F1
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:15:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A459F83C4B;
	Mon,  1 Dec 2025 18:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mLHrZjVv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5AD683C6C; Mon,  1 Dec 2025 18:14:57 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00C5083C01
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so3125182a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764609293; x=1765214093; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ATvZt+N5OqcvDlKDeGp2up6Ep+bxMicySMusfLa7pXo=;
 b=mLHrZjVvCWWcVDd2gvd6xF6xYWCMp7SmMBNNopXV6P0qN/VCxZeLYzIpki0D98iEVx
 iBL2Gwv5x3jRgIpLFhCgsMo4oSDiT+KxdyrkCLcn5CEvRT6mnsUkbPTekfN4hKjU1IwL
 Imw06VG7zkY9Sc79/K5gSO6i0cg1BxJAjPvNxLdi6pm1+HBNaMo0uyIUrXSmZNesomhJ
 cekGPngJ0mdxWUxIIUNnJfBeeNwTJH4WfytvtiB4XbM6X9karixWob/QJMDoNckxU9bl
 E1BZZN8A4NAM6grssDds5ei4ilv/93NmtuyGdXzPt1DmLnl2+gl1tz0W0I33EHQ+QWtM
 H1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764609293; x=1765214093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ATvZt+N5OqcvDlKDeGp2up6Ep+bxMicySMusfLa7pXo=;
 b=P4vd8BxN5203Dwn33RgVRXpPZ2/1SXMBPA14/xJ9OsgVf/g1So7rklHKDeblTYEaCP
 DhZ1THxKCYmqXxuGc0c0D7bm7yoyATGtcbYhC8T15o+IjMQ6omtztDjzM9UgMIv93yBE
 sF2rKFimGNXm2Vq8hg3z71tme7h0kKCBGytSJ00SWdDmOgeuOBzdyZudwcMdOTA0mbvY
 sxaYNCz1snO592ORDX6ltdVsqskIRYOdnOQ+Vp8eYEIuOAs6+EjvyVPCx+EftbrOSVep
 PNNi0/qhLOdnwfJ2zZOWa/pTOpykxIrxgo5qygFfUGwpyR8LhfjtprWdS0+QP7yxcazx
 4WPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2nG6UK6+5tRzkYcs7szKzEBhyv0hwMG98ihBJZFAeekoIn47Envj827OoMqmmBxki6apum/I=@lists.denx.de
X-Gm-Message-State: AOJu0YzWvB5uvRgMUpssw9Vdo0MrWs52Q9pMkoipl0Tlno1eHX4bOWr0
 okTi7w8rKtFe927WcHvLfL5s5ug6WbLFPlWuG4pKkgUpORJkxgsap/5hUEjve/KQsAHom+1y82p
 fMPE798wneJ/R/Om/FaPbfSh/JMvoDPI=
X-Gm-Gg: ASbGncu63hAK4nQJaCMBtA1gTMB8gr0pP8xo11Bv+nDyJY9gDzf0iEa2ZSCsWD7EXmu
 TeAVbOR2k1MMfZK+EWqfWCx/GqBi4H2X9aAKYQlJ7HywvLmRJLZKlt3Ld4OXBUqpyWMb4aDOark
 g5FL6eMtcv1Urzv0sa1xiXR9utXj4cr8VlqT9SRVhQjO0Id4aXqk1DBdgthAwKxJvTBZgteg3gB
 yKrGpcecFO9w94ACMs9SHQjonY1z1zlE4m2Fn6X8EFo/AHgf9x+OtAwfYIsFVL2WBUQYk+Q
X-Google-Smtp-Source: AGHT+IEWVaYuMMMQrLEicaYSr74pUqpM9cRdlvAom7xdOJjzyOzm9inzp/7DTprb8g0iKMVV43mmUC0yqGU627xQJUM=
X-Received: by 2002:a05:6830:81d6:b0:7b7:59c5:766c with SMTP id
 46e09a7af769-7c7c443b5a4mr14021144a34.33.1764609293570; Mon, 01 Dec 2025
 09:14:53 -0800 (PST)
MIME-Version: 1.0
References: <20251129064818.1587-1-briansune@gmail.com>
 <20251201165122.GH303283@bill-the-cat>
 <CAN7C2SAGqRqd-TXpp-ALrDzbsgBmLaxywGbw6j9w0MZipEQHnA@mail.gmail.com>
 <20251201170534.GK303283@bill-the-cat>
In-Reply-To: <20251201170534.GK303283@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 2 Dec 2025 01:14:43 +0800
X-Gm-Features: AWmQ_bmjmZDf54GYFz9_G0-yORADFmMDntR5PWL_4rqOP-URlBFK0yXgA2oH5Ds
Message-ID: <CAN7C2SBn6pq9DBO2GezyWcUVB6iZb-wQgmFyJF2ph7hV4WmiQQ@mail.gmail.com>
Subject: Re: [PATCH v2] Fix socfpga GEN5 boot by spl+u-boot sfp on RAW
To: Tom Rini <trini@konsulko.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>,
 Chee Tien Fong <tienfong.chee@altera.com>, u-boot@lists.denx.de
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=A5=
=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=881:05=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Dec 02, 2025 at 01:01:48AM +0800, Sune Brian wrote:
> > Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B412=E6=9C=882=E6=97=
=A5=E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=8812:51=E5=AF=AB=E9=81=93=EF=BC=9A
> > >
> > > On Sat, Nov 29, 2025 at 02:48:18PM +0800, Brian Sune wrote:
> > >
> > > > Thanks to Jan Kiszka had provided info on
> > > > u-boot is not able to boot by u-boot-with-spl.sfp.
> > > >
> > > > All three TYPE, NUM, OFFSET mode methods
> > > > are nonfunctional on combined raw boot.
> > > >
> > > > The major cause is spl+u-boot structure is
> > > > defined as 4x[spl+zero_pad] + u-boot.img.
> > > > Deal to this configuration since GEN5 is used,
> > > > the spl would require to seek by an offset
> > > > on top of the spl offset. This means for
> > > > each spl=3D0x10000 the offset is 0x40000.
> > > >
> > > > However latest u-boot do not consider this
> > > > major structure on GEN5 socfpga.
> > > > Meanwhile, the default include file as Jan
> > > > pointed out is completely wrong syntax and
> > > > caused issue.
> > > >
> > > > Combining both concepts, the minimum fix
> > > > patch is provide as follows.
> > > >
> > > > 1) Offset is control and default set to a
> > > > proper offset under:
> > > > SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET
> > > >
> > > > 2) Only GEN5 socfpga will be affected and
> > > > minimized contamination on other devices.
> > > >
> > > > 3) Only one compuatation adjustment is made
> > > > on spl_mmc_load. And simply introduce the
> > > > offset adding by the kconfig offset control.
> > > > It should be 0 by default and gate as well.
> > > > So no possible harm should be done.
> > >
> > > This sounds like a tricky problem to solve in a "nice" looking way.
> > >
> > > The first thing that's unclear to me is, which of
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR,
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION or
> > > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION is being used here?
> > >
> > > --
> > > Tom
> >
> > Hi Tom.
> >
> > This issue all happened due to the old "u-boot-with-spl.sfp" structure.
> > The old auto generated u-boot-with-spl.sfp that file itself has spl x4 =
and
> > zero padding. then it inserts u-boot.img.
> >
> > All are user dependent and have no restriction from the beginning.
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR any sector with A2 type.
> > SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION any partition with A2 type.
> > All are completely dependent on the user SD MMC setup.
> > So users can even use the last sector aka the most end of the SD MMC.
> >
> > That's why it is so tedious. And users even allow to simply use u-boot-=
spl.sfp
> > Then manually use dd  command to an offset that is in the A2 partition =
and
> > load the u-boot.img
> >
> > I didn't even like this idea and that's why I changed to the FAT boot m=
ethod
> > after 2025.07.
> > I simply bypassed the inherent issue that Jan was faced with.
> >
> > So long story short either completely drop this old compatible boot flo=
w or
> > do it in a very tedious way aka spl offset on top of u-boot.img offset.
>
> Well, wait, this doesn't make sense. The first thing is you pick which
> of the three I asked about as to how to find everything else at boot. We

But I am afraid that is the case. You can actually use any one of three opt=
ions
to boot. The requirements on Altera Cyclone V or Arria V GEN5 socfpga requi=
re
a A2 partition to seek the SPL. So this involved "TYPE" and "PAR NUM".
Then for the complete RAW setup it simply just uses the sector offset.

> don't need to support all three, we need to support one of them. I
> suspect the first thing is we need a default one-of-those if SYMBOL.
> This is what we do for MVEBU platforms which have, I suspect at least, a
> similar odd constraint.
>
> --
> Tom

That's why I don't even like to count debugging from first place after  202=
5.07.
SPL on A2 partition u-boot.img on FAT32 boot very fine and no issue.
You don't even need to consider the u-boot.img offset on top of SPL offset.
Very clean.
Jan proposed to fix the RAW backward support on the old combined
u-boot-with-spl.sfp boot method, which is completely not a must.

Hope this clears up some confusion.

Thanks,
Brian
