Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B56C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 14:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2DE88756;
	Mon,  8 Jul 2024 16:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GY993TwQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91C4688756; Mon,  8 Jul 2024 16:46:32 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E4C988756
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 16:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-5c44ec4f2dbso2127738eaf.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 07:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720449989; x=1721054789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UQf9c0isvFmS9nyUFh2EZeuqQg8GC0zuXSjFGMGPU60=;
 b=GY993TwQrsw0sSkAkkeJuqZ6SNS26nPrhU0kCkPtxAkiXPFF+CJGyVhLOBxdGttRIW
 A1DrrRq07btmIjMwjq8asVc88D1q69NbR7jOaMWN3M8+Dr7CoaSDwTBLcXdNA22+tEW8
 Yu/wMrBLNeuDyI3NEpe2TBjMVuipIUbIxNcPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720449989; x=1721054789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQf9c0isvFmS9nyUFh2EZeuqQg8GC0zuXSjFGMGPU60=;
 b=CT3Abd53Pwyub5Y4ZTsGT3KYnP8yHKEvoJjBJLAuQsvw/lGAvBy/ihicHErYK2DCyg
 G/1Kq+8zSJdvJdZaA7LZysFd81lIaDsxPwjKa6uUj1gg0SgUtvQLjJHwv7mrdWw+a1rj
 T6gNDarsMnsm1NzRzLHIdgyJOweejmK1xWR62jRvoe8+RDt/CJdLUWdp4uAFNJtREkYy
 0AK1dHcWcgOcNPGb168Yeo3bTTYo5U6k8aD2UITQmopsAkX1dG/4RjgReX7cH5BFegDw
 BfFepB2LHGKrEetZaYaRe+1bSOAfR9/PR1aEUVp+K8GUVjMX0p81Uf2NMT0ZZ/InZ3IB
 fndg==
X-Gm-Message-State: AOJu0YxizHqkoWjwqZhT22eMKe2Ww75vlAh+bbTodl7n1MgcFY1OH+Cn
 XdUaP2fMMWZL0Zu1FdGCO7E3dalNsKNCNjUkDK9e5YtFL8rr2fBQxcWwltffuNg=
X-Google-Smtp-Source: AGHT+IH094iw++c/zp2M9xS8iLaFHM6mULlr0yQrlDRap1wA4pzeiB8H/y8JyjoF/Mwa+KSnYEszqg==
X-Received: by 2002:a05:6871:24c1:b0:25e:1610:96fa with SMTP id
 586e51a60fabf-25e2bd7a6demr10964462fac.25.1720449989025; 
 Mon, 08 Jul 2024 07:46:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f78d35sm16757a34.23.2024.07.08.07.46.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 07:46:28 -0700 (PDT)
Date: Mon, 8 Jul 2024 08:46:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 16/48] lmb: config: add lmb config symbols for SPL
Message-ID: <20240708144626.GD38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-17-sughosh.ganu@linaro.org>
 <20240705194841.GO38804@bill-the-cat>
 <CADg8p95b2XybOZSB=YcX6hwP6mQrvxZs4tLNjhT5g3AeKve4cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="74oGwAWS/I3SbZTi"
Content-Disposition: inline
In-Reply-To: <CADg8p95b2XybOZSB=YcX6hwP6mQrvxZs4tLNjhT5g3AeKve4cA@mail.gmail.com>
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


--74oGwAWS/I3SbZTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 05:06:45PM +0530, Sughosh Ganu wrote:
> On Sat, 6 Jul 2024 at 01:18, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jul 04, 2024 at 01:05:12PM +0530, Sughosh Ganu wrote:
> >
> > > Add separate config symbols for enabling the LMB module for the SPL
> > > phase. The LMB module implementation now relies on alloced list data
> > > structure which requires heap area to be present. Add specific config
> > > symbol for the SPL phase of U-Boot so that this can be enabled on
> > > platforms which support a heap in SPL.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1: New patch
> > >
> > >  lib/Kconfig | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/lib/Kconfig b/lib/Kconfig
> > > index 072ed0ecfa..7eea517b3b 100644
> > > --- a/lib/Kconfig
> > > +++ b/lib/Kconfig
> > > @@ -1103,7 +1103,17 @@ config LMB
> > >       default y if ARC || ARM || M68K || MICROBLAZE || MIPS || \
> > >                    NIOS2 || PPC || RISCV || SANDBOX || SH || X86 || X=
TENSA
> > >       help
> > > -       Support the library logical memory blocks.
> > > +       Support the library logical memory blocks. This will require
> > > +       a malloc() implementation for defining the data structures
> > > +       needed for maintaining the LMB memory map.
> >
> > Even today, LMB really should be def_bool y rather than an option, so
> > this series should correct that. That said...
>=20
> Okay
>=20
> >
> > > +config SPL_LMB
> > > +     bool "Enable LMB module for SPL"
> > > +     depends on SPL && SPL_FRAMEWORK && SPL_SYS_MALLOC
> > > +     help
> > > +       Enable support for Logical Memory Block library routines in
> > > +       SPL. This will require a malloc() implementation for defining
> > > +       the data structures needed for maintaining the LMB memory map.
> >
> > The question I guess becomes when do we need LMB in SPL, exactly? And I
> > guess it's another case where it should be def_bool y (but still depends
> > on what you have here) since we need to make sure we don't overwrite
> > running SPL.
>=20
> So this is a question even I had. Do we really need to enable LMB in
> SPL ? The main reason for introducing the symbol was to have more
> granularity to remove the LMB code from SPL, but should this really be
> enabled in SPL is something that I am not too sure about.

Yes, we need to ensure we obey reservations in SPL, both for U-Boot and
for when we boot the OS from SPL.

--=20
Tom

--74oGwAWS/I3SbZTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaL+74ACgkQFHw5/5Y0
tyyBIQv/cFRW5oVpNI8fdkHYFa6GDwqjE14KFxkwARNkyzXmyht2Co+TXcsZZpeZ
k1ZsNzw7nS12tYocDowoBNxadm3/BSNT33MHBIvR2sXeIvOqz+hCHsuVlyiHktHm
dyFERvXsKNMG9a33pgbyAsEDONgnNnnOl/WftrCKWbU7S4EbTrSfW09gJeFWALPn
lkl7zLewhThRhuukE4jlqivKSYEqYiKU6GpLrAHEReP/MYfNasAQXV89lpBts3yV
qeJKtxenJAYAIdqkyV5mc4laqfbq/kFNcBZreVK3vLjypGsVeMDUP/uM/CV1kmoI
z3srjYXqZuxnBy1/S8ZF0dS1udYF8ixc7cDZIFNYMN0qR/+PHqMuAmA9X9fwCQqi
Aj3fUwLfE8VH/9LlmOTGtKfbVjOUv544U2BGvoGWow2X2MnPKxuTZFU2B8Ui5Zz3
qCYobi22+ynpXIHcy51NY8sFVaGmzManU3GEzUz75B3+KWMy6V0PsLq4jne+4ZBo
lUJpzomK
=9o/D
-----END PGP SIGNATURE-----

--74oGwAWS/I3SbZTi--
