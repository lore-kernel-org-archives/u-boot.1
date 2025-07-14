Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029BBC83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:04:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0109F83022;
	Mon, 14 Jul 2025 15:04:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="l6dLZaAc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D349881FEE; Mon, 14 Jul 2025 09:01:34 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D1E805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 09:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josef.holzmayr@northern.tech
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-553affea534so545865e87.2
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1752476478; x=1753081278; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R+5cCEf/lfAyHAFrybRs4QrFGRAcH+yPSBYXvIgPP/w=;
 b=l6dLZaAc5qIuADzlC/fcU220UMWVN66iKOXCyJJm9BlSB52MYm4+qEXcx2jcwaSn3o
 rLepMRMzqHBPqrnNvg/nBGi0nPfxJGzYrVGNWHWli9mlIZI1XjVmTXtF3Ze3hw9zU/eT
 DZRfexb4CTB2mbI+OfcUU2p4XG+UppkmmqkzzNa/6ZSkHQa+JsFobmZNDmiYj2PjmQIn
 ectw/KabQqgdKiEcBkIsoFGDo9rYNqAAZWpB+AoSyBI+9T/dni/e2mCfR2+pgXQGdTHl
 qmfLSFFOgwLgDL+rEaTcwnmYDqbHVppM8MNFWRIsRddw0S3GFISQ7t31WFbsEN/fmbJW
 olMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752476478; x=1753081278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+5cCEf/lfAyHAFrybRs4QrFGRAcH+yPSBYXvIgPP/w=;
 b=vlJt64RqZXMFvyhQRyIbUm62lEFadpGpKVK4eHwiplaCbauNNtPgVgENjyCMjVLBgb
 nxNC5/TwNdcnM5M9H+3hAAf8LDSBDe19CyqVoe1cDkOsmd4N3SMAMynb3ij3vH5n6Za9
 Z0RYJBNAkz4Mi0QG8uDMAvdpjuVlMLf9pPMnt6raCaMmr4AT9HBMQ4CBsjp1DOM2daOv
 xHTflieRHdof1SLEmR4qtbqZVlup9bUpmIZV1TeEDNsl7Frbwru2v4J8TErVYzB1KLQM
 EKhcWrfFwqIwRw7JMn7Jr5yWsfVK89rrhHgrBMDTjiMJPVzD9P3EF8gGVI8yXdLV3Oxd
 7fug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyEA3EcJviX+RhMqh9t/pF4tpeYZpORK+biaPCvlFl1xGKmiYdHH1QKlgIoV8XdhhHZLsSe6c=@lists.denx.de
X-Gm-Message-State: AOJu0YwFzIj7f8BTHJhSsS2eJfv7mIoarzvjxB49jhfXruTAmqDARxft
 HbyY32P/xjocJ/Oqd4OFi7BprkDes8s0d5/MbCQyOrA7n7HL0nVJBCUjnrV+RXdZUkxYSEiefE4
 XuqsNdw5ZYLH+CAxbRRUc1Je6B+4VoHXYXfIIsphvcYZdK12SDPxoWm5P5uTkGWlbQFIyeRblFf
 Vp3D7vNm1G2yrs4YpaMhU=
X-Gm-Gg: ASbGncvCE06Iw8J8hWWvW0GVqGGny7eLN/0jbehNsWte2xPX56L2NJVgnGbMOkkBUhF
 Kyttk3PYD/q+9rlfyxuuHvHjtLcLb1mFNyH1ckPhRGpRJ6PEXruHnPfj8dz/5T0oxrYiZ//5etZ
 1znm9LE//Hbci1nu6LSd7QivXqD4692ZqAclnNmUtmpAj9472mXlZ4S50tPRG+UhIbz6A9vibW9
 iOzog==
X-Google-Smtp-Source: AGHT+IEX6HqfpK3jyFcj01EBGXQLt+yKAB5roa5+RUA/fc4Eya4PdTo3RSOJhfF/IlSs8t89w+TwmtP7w+MONuI80nk=
X-Received: by 2002:a05:6512:4024:b0:553:35ab:30ae with SMTP id
 2adb3069b0e04-55a04663de2mr1169511e87.13.1752476477844; Mon, 14 Jul 2025
 00:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250711185512.2250368-1-trini@konsulko.com>
 <ECA70B87-D474-4408-B523-86F4A2D02D09@gmx.de>
 <CAC_iWjJQh8M8KsscLb6JXkFH4t+wr+oi9xX=gko6ztPm2YuQWw@mail.gmail.com>
 <87y0stbssf.fsf@bloch.sibelius.xs4all.nl>
 <87wm8dbp1e.fsf@bloch.sibelius.xs4all.nl>
 <20250712154847.GM6424@bill-the-cat> <87ms99b5l9.fsf@bloch.sibelius.xs4all.nl>
In-Reply-To: <87ms99b5l9.fsf@bloch.sibelius.xs4all.nl>
From: Josef Holzmayr <josef.holzmayr@northern.tech>
Date: Mon, 14 Jul 2025 09:01:06 +0200
X-Gm-Features: Ac12FXzUGnr-gwF6KNDQAhKxAOjfazSVSIce7HU5XSSWsfkrLAfGTFW_tcn_MIY
Message-ID: <CA+AKJpETJfQ9j-u582i4aYyaOFaromQXvt0N-TUw9x=KZ65fkw@mail.gmail.com>
Subject: Re: [PATCH] vexpress_ca9x4: Disable EFI_LOADER on this platform
To: Mark Kettenis <mark.kettenis@xs4all.nl>
Cc: Tom Rini <trini@konsulko.com>, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, u-boot@lists.denx.de
X-Mailman-Approved-At: Mon, 14 Jul 2025 15:04:16 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi all,

thanks for keeping me in the loop. Not sure I understood everything, but
I'll check with folks here and figure out how to move forward.

Greetz,
*Josef Holzmayr* (he/him)
Developer Enablement Expert
Mender <https://mender.io/> | GitHub
<https://github.com/theyoctojester> | Mender
Hub <https://hub.mender.io>
<https://www.linkedin.com/company/northern.tech>
<https://twitter.com/northerntechhq> <https://northern.tech> Northern.tech
<https://northern.tech> | Securing the world's connected devices


On Sat, Jul 12, 2025 at 8:56=E2=80=AFPM Mark Kettenis <mark.kettenis@xs4all=
.nl>
wrote:

> > Date: Sat, 12 Jul 2025 09:48:47 -0600
> > From: Tom Rini <trini@konsulko.com>
> >
> > On Sat, Jul 12, 2025 at 01:56:45PM +0200, Mark Kettenis wrote:
> > > > Date: Sat, 12 Jul 2025 12:35:44 +0200
> > > > From: Mark Kettenis <mark.kettenis@xs4all.nl>
> > > >
> > > > > From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > Date: Sat, 12 Jul 2025 09:28:07 +0300
> > > >
> > > > Hi Ilias, Heinrich and Tom,
> > > >
> > > > As you probably know, OpenBSD/armv7 relies on EFI_LOAD, so disablin=
g
> > > > EFI_LOADER on a platform means you can't boot OpenBSD on it.  Ilias
> > > > and I talked about this a while ago.  We talked about telling QEMU =
to
> > > > use an older version of the architecture that didn't do this
> alignment
> > > > check, but that may have been based on a misunderstanding of the
> > > > changes in QEMU.
> > > >
> > > > At the time I didn't look any further into this, but I did now.  An=
d
> > > > I'm confused because...
> > > >
> > > > > Hi Heinrich
> > > > >
> > > > > On Fri, 11 Jul 2025 at 22:35, Heinrich Schuchardt <
> xypron.glpk@gmx.de> wrote:
> > > > > >
> > > > > > Am 11. Juli 2025 20:55:12 MESZ schrieb Tom Rini <
> trini@konsulko.com>:
> > > > > > >As part of upgrading to QEMU 10.0.0 we discovered that the EFI
> loader
> > > > > > >tests would no longer pass CI, on this specific platform, whil=
e
> still
> > > > > > >passing on real hardware. Upon further investigation it turns
> out that
> > > > > > >on ARMv7 we rely on some undefined behavior with respect to
> enabling
> > > > > > >unaligned access. And while this is seemingly fine on real
> hardware,
> > > > > > >QEMU is now correct enough in implementation to no longer allo=
w
> this. In
> > > > > > >order to not rely on this undefined behavior we would need to
> implement
> > > > > > >some MMU configuration (and then ensure proper tear-down
> possibly).
> > > > > > >
> > > > > > >At the moment, the most reasonable path forward seems to be to
> document
> > > > > > >this and disable the support here.
> > > > > >
> > > > > > Where will we document the issue?
> > > > >
> > > > > I think we can add it on the EFI documentation? IIRC we only enab=
le
> > > > > the i-cache not the mmu + d-cache. I can double check and send a
> > > > > patch.
> > > >
> > > > There is code in U-Boot to enable the MMU and the D-cache.  The cod=
e
> > > > turns on the MMU gets turned on when we turn on the D-cache, which
> > > > happens when we call dcache_enable().  That function typically gets
> > > > called from the board.c file and the one used by vexpress_ca9x4
> > > > doesn't seem to do that.  But other ARMv7 targets do.  For example =
in
> > > > arch/arm/mach-sunxi/board.c we have:
> > > >
> > > > #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) && defined(CONFIG_CPU_V7A)
> > > > void enable_caches(void)
> > > > {
> > > >         /* Enable D-cache. I-cache is already enabled in start.S */
> > > >         dcache_enable();
> > > > }
> > > > #endif
> > > >
> > > > Note the CONFIG_CPU_V7A there.  This means that for the Allwinner
> > > > ARMv7 SoCs, which typically use Cortex-A7 cores that do include the
> > > > virtualization extensions and therefore should implement the strict=
er
> > > > unaligned access checks, we do enable the MMU.
> > > >
> > > > > >  Does it imply that we should discourage EFI use on all ARMv7
> systems?
> > > >
> > > > So no, it does *not* imply we should discourage EFI use on all ARMv=
7
> > > > systems.
> > > >
> > > > > The spec says the MMU must be enabled, so I think yes. I thought
> about
> > > > > disabling it, but that's too strict.
> > > > > Perhaps someone that uses v7 and *needs* EFI can look at enabling
> the
> > > > > MMU with a simple identity mapping.
> > > >
> > > > That should be as simple the diff below.  I've not verified if that
> > > > fixes the QEMU issue, but I strongly suspect it will.  Whether this
> > > > works on actual vexpress hardware is a different issue though.
> > >
> > > Fixes the issue with QEMU 9.2.2.  Before it would reset, now it boots
> > > into the OpenBSD installer just fine.
> > >
> > > > diff --git a/board/armltd/vexpress/vexpress_common.c
> b/board/armltd/vexpress/vexpress_common.c
> > > > index 6c374e25e32..3833af59b09 100644
> > > > --- a/board/armltd/vexpress/vexpress_common.c
> > > > +++ b/board/armltd/vexpress/vexpress_common.c
> > > > @@ -165,3 +165,11 @@ void smp_set_core_boot_addr(unsigned long addr=
,
> int corenr)
> > > >   writel(addr, CONFIG_SYSFLAGS_ADDR);
> > > >  }
> > > >  #endif
> > > > +
> > > > +#if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
> > > > +void enable_caches(void)
> > > > +{
> > > > + /* Enable D-cache. I-cache is already enabled in start.S */
> > > > + dcache_enable();
> > > > +}
> > > > +#endif
> >
> > Thanks Mark! I was hoping this would spur some further discussion and
> > perhaps a patch. Please post this formal patch and I'll go reject the
> > patch I posted now.
>
> Done.  I also noticed that the vexpress_ca9x4 board was added back
> specifically for use with QEMU.  So any concerns about real hardware
> are probably unwarranted.
>
> Cheers,
>
> Mark
>
