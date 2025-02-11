Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D20CDC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 14:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D68B580AE5;
	Tue, 11 Feb 2025 15:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NBb78mUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A65807E1; Tue, 11 Feb 2025 15:55:07 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331D4803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 15:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f62cc4088so65128285ad.3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739285704; x=1739890504; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sEiPxKqkT83H5Z6J/kptZiZ82D4rqC2iEJ9ylHBZxH0=;
 b=NBb78mUeTSbPvh4ewEBKIQWSqKT5YYQzg4KQIJM1y5XcvggFdO4aAfbTxa/42GoGV9
 okydklnj2n/0kVReOxxWBxPQ9ovbU5fYWSysiacLPmGyJeFkI7Qcasby0tWrH1Uzjpcb
 sFMUFmm7ZT7eOcSK78XhDTV4aV19iBqzaM6x8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739285704; x=1739890504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEiPxKqkT83H5Z6J/kptZiZ82D4rqC2iEJ9ylHBZxH0=;
 b=ll/OOERR+kB6yDsAe2zso4PQtmjXUQ+kKHs7sh1xuOPY5smSSRW4iEQ2blI2tdYlIf
 izEcWqaSNbGWFabzKdLA1zmMTLYy5k2RK8smW6ufJXPDOnQow2/sHQNgfylyralUnSDh
 ClmRtBqSVTQx+yK3GlB/K2YZNBXHG8PGFV/nYjOzVWkN4ny6uIVBFrMabLMQiioDAXCz
 r0AtgivSbYV6+QGYtE6Zl5ZNiN4v+Vf3TLxGI97nYjBuA+ORvHSolDKWDc+ROxIPV6So
 pfnWoAWUdVmkjz8VZ2/AHBPnw28TywWPnTfjAMg8HjReCd98PTblRgG7db/J5g1UiI7Y
 pPkw==
X-Gm-Message-State: AOJu0YxrVCLG5mOC2wpphCm9rW8nxjmn1/hPzLILXdFiSw0y19WOzP8+
 4NFCiupTRuWPIh+4bkxXjk5WyMR7SfmhqeqQgkZAB7s/Q1G1VRUUZ2C1e2UqDrY=
X-Gm-Gg: ASbGncvRKvgVYqRVN4owyWrCud3zT+UUj5mK95D1RySpulOQDeNMuYvqPS8+3MsgDfs
 LbCCIT+MKkRYSPD0aXijFIurA6k0H/ETyIuGlxibzDOj5aAmXzJYg6wbEXmuKQufH487QP8isLt
 VOWyY4COpONg9JuQTHUnTq4zt22uEwIl7aISXQNyNe80h8HTsh8YgTjFKnPENTDWJ0+stEcRumh
 MoB7hDEZtQKyWrDIc1BOlYKKLtZHOIu5JcGSQCAXoBh2Bx2pbV5Jt8TJJjHx8tFfevyRKqBquNt
 EXymd+DgXMuDEZA=
X-Google-Smtp-Source: AGHT+IHX8lrYRyfVkGAI9PGN7hma34auKNFMT7Bx+FWuLeDRrCEWAhljhPh8qB7vaK3VZ3xiMWs7lA==
X-Received: by 2002:a05:6a00:4c8d:b0:730:d5ca:aee with SMTP id
 d2e1a72fcca58-730d5ca3764mr7602813b3a.23.1739285703675; 
 Tue, 11 Feb 2025 06:55:03 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73048ae7c24sm9458566b3a.78.2025.02.11.06.55.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 06:55:02 -0800 (PST)
Date: Tue, 11 Feb 2025 08:54:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v4 05/15] lmb: notify of any changes to the LMB memory map
Message-ID: <20250211145459.GC1233568@bill-the-cat>
References: <20241015153717.401371-6-sughosh.ganu@linaro.org>
 <20250117-molecular-quicksand-e80bf947313e@thorsis.com>
 <CADg8p97Q70PnsXd=GtTLncg8B8LMTN7bda4YXxb+VDnCU4HL4Q@mail.gmail.com>
 <20250120-shine-extended-134d3ccac85f@thorsis.com>
 <CADg8p96wCZppfKBrVok6nU1eyx=dHcAH9iZaiHa_jMkYd1LHUg@mail.gmail.com>
 <20250211-distract-whooping-739989988035@thorsis.com>
 <CADg8p94iMJv5ph51ng8r=HaiMSdSMj08Lj03=Amt+2JzyFySYw@mail.gmail.com>
 <20250211135407.GY1233568@bill-the-cat>
 <CADg8p96rNvxQ7ugmexKhmJ092WJEMwYjF50KpASjVbNrA7xxsA@mail.gmail.com>
 <CADg8p95xSTpDE_6zKnKHCkJmv0_rqicFXRAXA54D0hzKG_pDaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+F+dqrRL5qxzSzlL"
Content-Disposition: inline
In-Reply-To: <CADg8p95xSTpDE_6zKnKHCkJmv0_rqicFXRAXA54D0hzKG_pDaA@mail.gmail.com>
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


--+F+dqrRL5qxzSzlL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 07:40:40PM +0530, Sughosh Ganu wrote:
> On Tue, 11 Feb 2025 at 19:30, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > On Tue, 11 Feb 2025 at 19:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Feb 11, 2025 at 04:41:09PM +0530, Sughosh Ganu wrote:
> > > > On Tue, 11 Feb 2025 at 16:34, Alexander Dahl <ada@thorsis.com> wrot=
e:
> > > > >
> > > > > Hello,
> > > > >
> > > > > Am Tue, Feb 11, 2025 at 04:23:13PM +0530 schrieb Sughosh Ganu:
> > > > > > On Mon, 20 Jan 2025 at 15:43, Alexander Dahl <ada@thorsis.com> =
wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > Am Mon, Jan 20, 2025 at 02:40:38PM +0530 schrieb Sughosh Ganu:
> > > > > > > > On Fri, 17 Jan 2025 at 16:40, Alexander Dahl <ada@thorsis.c=
om> wrote:
> > > > > > >
> > > > > > > [=E2=80=A6]
> > > > > > >
> > > > > > > > > This changeset breaks build with CONFIG_CC_OPTIMIZE_FOR_D=
EBUG=3Dy for
> > > > > > > > > me.  In a usual non-debug build, everything is fine.  How=
ever in a
> > > > > > > > > debug build now I get this error:
> > > > > > > > >
> > > > > > > > >       UPD     include/generated/timestamp_autogenerated.h
> > > > > > > > >       GEN     Makefile
> > > > > > > > >       Using /mnt/data/adahl/src/u-boot as source for U-Bo=
ot
> > > > > > > > >       CC      common/version.o
> > > > > > > > >       AR      common/built-in.o
> > > > > > > > >       LD      u-boot
> > > > > > > > >     arm-v5te-linux-gnueabi-ld.bfd: lib/lmb.o: in function=
 `lmb_map_update_notify':
> > > > > > > > >     /mnt/data/adahl/src/u-boot/lib/lmb.c:458: undefined r=
eference to `efi_add_memory_map_pg'
> > > > > > > >
> > > > > > > > Can you share the details of the toolchain that you are usi=
ng, where
> > > > > > > > can I download it from. And the target that you build which=
 shows this
> > > > > > > > up. Thanks.
> > > > > > >
> > > > > > > Although I'm actually building with ptxdist and
> > > > > > > OSELAS.Toolchain-2023.07.1/arm-v5te-linux-gnueabi for a custo=
m board,
> > > > > > > you should be able to reproduce the behaviour easily with bui=
ldman on
> > > > > > > master when building for boards sam9x60ek or sam9x60_curiosit=
y like
> > > > > > > this:
> > > > > > >
> > > > > > >     buildman -o ~/build/u-boot/buildman -e -a CC_OPTIMIZE_FOR=
_DEBUG sam9x60
> > > > > > >
> > > > > > > My output when running the above is this:
> > > > > >
> > > > > > Sorry, I haven't spent time debugging this issue, although this=
 is on
> > > > > > my todo list. Btw, since you already have a working setup, can =
you
> > > > > > please reset your tree to the following commit and then check i=
f that
> > > > > > fixes your issue.
> > > > > >
> > > > > > 92e75ee47f1 ("board_r: Remove duplicate headers")
> > > > >
> > > > > Does not change anything.
> > > > >
> > > > > Note: my tree is not special in any way, it's a clean mainline u-=
boot
> > > > > checkout and I'm building for a board with an in tree config.
> > > > > Everyone should be able to reproduce this by using
> > > > > configs/sam9x60_curiosity_mmc_defconfig, enabling
> > > > > CC_OPTIMIZE_FOR_DEBUG and building with the default toolchain
> > > > > downloaded by buildman, which is also mainline u-boot tooling.
> > > > >
> > > > > My assumption is: some efi code is pulled in unconditionally here,
> > > > > but efi is not enabled on armv5 and it can not be enabled,  efi i=
s not
> > > > > needed on this target anyways.  Furthermore: I assume the code is
> > > > > optimized out when doing a normal build without CC_OPTIMIZE_FOR_D=
EBUG,
> > > > > which is basically building without optimizations and keeping deb=
ug
> > > > > symbols.
> > > >
> > > > Okay. Please give me some time. I will try to spend some time on the
> > > > issue this week. Thanks for your quick response.
> > >
> > > Yes, the problem is that CC_OPTIMIZE_FOR_DEBUG disables compiler
> > > optimizations that we normally rely on to avoid having to #ifdef the
> > > code. In this case, lmb_should_notify() causes this to normally be
> > > optimized away as CONFIG_IS_ENABLED(EFI_LOADER) will be false and the
> > > compiler will do the right thing. The "fix" is to instead make most of
> > > the body of lmb_map_update_notify be guarded with #if
> > > CONFIG_IS_ENABLED(EFI_LOADER) ... #endif
> >
> > Yes, that would be the obvious thing to do. But I suspect that because
> > there are no optimisations with the said flag, it might be needed to
> > even protect the function calls with the ifdefs. Which I am hoping to
> > avoid.
>=20
> If we cannot do without using ifdefs at the function call sites, what
> is your opinion on disabling lmb with the CC_OPTIMIZE_FOR_DEBUG flag
> enabled? Maybe this can be converted into a config flag. There are
> existing configurations like xilinix mini which too are disabling lmb.
> Thoughts?

It should just be a single set of #ifdef ... #endif, and possibly adding
a __maybe_unused.

--=20
Tom

--+F+dqrRL5qxzSzlL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmerZLkACgkQFHw5/5Y0
tyyBxgv8D8T9oXe4PFQtSeJgWr0CJS/Fo1lWiIz5eyFHLrDI7akSn+MJI06NcO6q
WsCXiSdwMsxE8ffF9PHk8lpL1s7KwG6DCf9p+skTvF6cNWZDER3B4zQC60S7rnU8
YBm7VPkyvOXBoEqS7PE4lpJHSqH1QvXy4y8jG3l/etd1HcmKc9AGhT75vz2qtoy7
Rqr7xpRw2BTN597eNP2gnxevYjVpvkjaZXyQz0hJ/K52Qw6OxuZKPyfDFi8riUIn
tg/mabCA3chSLoSJBBnGDIQw474PSOvesleObYZTVFYb2HxFQhsSDtHtuFfD6GAY
8xBjG8l1XUqrhU0YSNeYP6BQuRXm1xFHktkBF49MD1xgY2CMllmPvXbVp45c+RZs
WHIV+XyfjWhxDgUulseYNzrSCXq25MoiRN6RYUdobSrVp+/VaKYUHf8c33XVrY85
xiiPsp7nDZVEeNvECh7jd57CatJMtbl3aH1E+LTJQ1FFiujqkN4/YBuzw4udTPZ0
eohZjA21
=Xb2I
-----END PGP SIGNATURE-----

--+F+dqrRL5qxzSzlL--
