Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A894C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 13:54:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BD9803CC;
	Tue, 11 Feb 2025 14:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EHbiE5FV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 208908043C; Tue, 11 Feb 2025 14:54:27 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1EE80077
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 14:54:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso87515355ad.1
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739282063; x=1739886863; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WA5Y8+y1CRHFdWqEooSwt3f7h2kW0hLedyCd6L5eELI=;
 b=EHbiE5FVMOW5Nwcpn4QvPuLkcDpbUlGs01ePOPNfqsIg9kufNpxhvjTIpOo6zdEbE9
 ptuM65trIyDn56Y3l/rN9bFxbDvuTa5fmnJ6w7bcNox+ed+qGRCY0yUM88obVq7Fd6V0
 1W7dSxCkYEEwL/JutVl288Kb97ocApV3fTgCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739282063; x=1739886863;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WA5Y8+y1CRHFdWqEooSwt3f7h2kW0hLedyCd6L5eELI=;
 b=L4JTTfhe7t4e/AYcgM+sqk10AY/VDt0TIrBSibZ82dbHOU69yRyBr3JVon9RnDh3Tb
 EknAIMPuuqg3To54FzcTEJ09mHP+poPfP4WayMs0h32SXF/s/GNm4R61z+mxUv6JfI0p
 vxGrkFBQKjhxyDDKntTW/Nt9bpwsjAvknFsvyPz7n5uHoNIfDlV+YMIdjvi9Rathr8W3
 VCkpbrq1P2CeJFXphLTfmj6UKMEmGGx+xpRmg8eYqHgH636SGvD1xSOPL+GKVkTh78Zq
 9DywcXKdgyoju5T/cdPzwig/KBTRsMXkrerWlPOYazCWgSXAYT1pDxy8dsy9zS3Aqa9z
 w2Zg==
X-Gm-Message-State: AOJu0YyfWmczNe8ntpUSDDQyD+DiWnqX10ljuNwFHzOtOFbRtDuJEw9u
 j3Giptv6KZXKnErM4yW0H3pJguM06cK1nZO1BSR+bgKAKZJPnWVvZYKay7VLg8E=
X-Gm-Gg: ASbGncuEE5Tff7AHRUNHWMAJNbqwO9LKmSrfaYH8Y1SLMXNNzyk1DqMptcvZSwqE2HD
 WobxNQH+iBHXqSmhLEMqvz+2xW3ZDA7eyBxLaJAYfqQmXVawR7j3KWNWxqpG8wTEpfTh3Z1YDSz
 vJaK4bObmmg3AdXWEDiNxw1AQHIpqxqcb3O3EbTLJm95h4vWBn3GwSMXhrjQoLwLt4g0J/tC2gS
 gGKYI9wybFwBP7OOTo02T2g3FUJXeOzSx9M6LcNaVMfnOv+zO4VSLg9LiB9oDA24I53KfL22kp9
 gMhNX76m7bwNnLI=
X-Google-Smtp-Source: AGHT+IEygH5lZe3cFDpyg5R01rfPOLJ7BDXnYBYItEverOvks2AsGtYvF7OoJo2j/FWja4j/Dq0wAA==
X-Received: by 2002:a17:902:d2cc:b0:21f:6167:183a with SMTP id
 d9443c01a7336-21fb6f1219cmr54688685ad.15.1739282050673; 
 Tue, 11 Feb 2025 05:54:10 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368affccsm95964465ad.225.2025.02.11.05.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 05:54:10 -0800 (PST)
Date: Tue, 11 Feb 2025 07:54:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
Message-ID: <20250211135407.GY1233568@bill-the-cat>
References: <20241015153717.401371-1-sughosh.ganu@linaro.org>
 <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DNNLWZqkx6c1pOrc"
Content-Disposition: inline
In-Reply-To: <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--DNNLWZqkx6c1pOrc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wrote:
> >
> > Hello,
> >
> > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.com> wr=
ote:
> > > >
> > > > [=E2=80=A6]
> > > >
> > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_DEBUG=
=3Dy for
> > > > > > me.  In a usual non-debug build, everything is fine.  However i=
n a
> > > > > > debug build now I get this error:
> > > > > >
> > > > > >       UPD     include/generated/timestamp_autogenerated.h
> > > > > >       GEN     Makefile
> > > > > >       Using /mnt/data/adahl/src/u-boot as source for U-Boot
> > > > > >       CC      common/version.o
> > > > > >       AR      common/built-in.o
> > > > > >       LD      u-boot
> > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function `lmb_=
map_update_notify':
> > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined referen=
ce to `efi_add_memory_map_pg'
> > > > >
> > > > > Can you share the details of the toolchain that you are using, wh=
ere
> > > > > can I download it from. And the target that you build which shows=
 this
> > > > > up. Thanks.
> > > >
> > > > Although I'm actually building with ptxdist and
> > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custom boar=
d,
> > > > you should be able to reproduce the behaviour easily with buildman =
on
> > > > master when building for boards sam9x60ek or sam9x60_curiosity like
> > > > this:
> > > >
> > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR_DEBUG=
 sam9x60
> > > >
> > > > My output when running the above is this:
> > >
> > > Sorry, I haven't spent time debugging this issue, although this is on
> > > my todo list. Btw, since you already have a working setup, can you
> > > please reset your tree to the following commit and then check if that
> > > fixes your issue.
> > >
> > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> >
> > Does not change anything.
> >
> > Note: my tree is not special in any way, it's a clean mainline u-boot
> > checkout and I'm building for a board with an in tree config.
> > Everyone should be able to reproduce this by using
> > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > downloaded by buildman, which is also mainline u-boot tooling.
> >
> > My assumption is: some efi code is pulled in unconditionally here,
> > but efi is not enabled on armv5 and it can not be enabled,  efi is not
> > needed on this target anyways.  Furthermore: I assume the code is
> > optimized out when doing a normal build without CC_OPTIMIZE_FOR_DEBUG,
> > which is basically building without optimizations and keeping debug
> > symbols.
>=20
> Okay. Please give me some time. I will try to spend some time on the
> issue this week. Thanks for your quick response.

Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
optimizations that we normally rely on to avoid having to #ifdef the
code. In this case, lmb_should_notify() causes this to normally be
optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and the
compiler will do the right thing. The "fix" is to instead make most of
the body of lmb_map_update_notify be guarded with #if
CONFIG_IS_ENABLED(EFI_LOADER) ... #endif

--=20
Tom

--DNNLWZqkx6c1pOrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerVn4ACgkQFHw5/5Y0
tywEDAwAhrGp/qhLCocxRfaGrt8fpmii6jok08hhZoGrffKmVT8XnZtAE76BWh/A
prqkPAlwi2T1RMUwJpeerJF7om52jbJg3xuPy7bXLIXSS1xZ4+T/oHvQbogIzQyw
kBxwhT9l2+U66BMtm76r8IgYW6JDiNuYpaaxdbinowBDlvhRmOY+362v0WeFcvXP
LD+2nr0JX6TP6aHXViH7UOqEWvg+6gjJ+pBoRzORAUkS4yZYqeC7FA4ZCjSTja7e
qo9IGfSvot49Q+3AagW3OMyFrQLubD39GY2SbQJfqhu427uJMlRy7x7NC18/j8Qw
S9Ra5NH4t6UUFsmkDKnbY/51jHEVUX4xS0IRyx7YFznCgc05LE0udrVtamFw5StC
87ipf7jKFVlnkbUScdF9hU3A3Yy8nei4M1YwqZ25n3n7MiLO/0VtudSmbkb9bPfM
qiyI/ta5bshABWYW7TrG/1xpyNmdfoh6ZQYOWAhQeALAxtA6eViTXQZ27rJv+T0e
gMWduVvS
=hmtt
-----END PGP SIGNATURE-----

--DNNLWZqkx6c1pOrc--
