Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F17AC2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:30:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0445587DEB;
	Fri, 21 Jun 2024 01:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DXimConY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71C3787EF6; Fri, 21 Jun 2024 01:30:32 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3889287DD3
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-25cb994dbfeso668908fac.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718926229; x=1719531029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dE6dUcsrvgzYITP1JWF3IvEN+/3tHXe+f882yn0QIHE=;
 b=DXimConY6Lr8H4Sjji7lVOR6cBaQei9ehru3DRE4ULrAs7HGkxX2sD2fdQJmuY/mIJ
 teYMJ8CkxE7tIk7hBvExBIRvs/S7PsRGmHPOduhXsphWHfyhMPxzN9cvptDlDI0/79Pd
 oAgbB11SQdoCW4EuaBtew2JHk+SXKlW67T/JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718926229; x=1719531029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dE6dUcsrvgzYITP1JWF3IvEN+/3tHXe+f882yn0QIHE=;
 b=PqmFOSXRv23Nn/t9CiIdDL1PD2stkDXR7l+SOu9WAdiIawgoeKhkrWv+GhzlBeOKza
 EBeWiOl8KUCOlmPa9i1U76HzxIMdgllm6JzOWi95ICIk1XWdUDTXxlVB8ZxXrMK+d4dK
 Rl0CLUjLktRRUdzi9kue95DwIi2KgNqxiN1AkK6PeLmOiKxzh6IVmd3srcvnTwlPu47K
 NGyJ9FKxJCpKCvQoQ+b7ZvDr/yhieiu1pqhjXH40Ci95uFGvWZWdFVshmPL8tHt+J6Yr
 OUs4fc400LNOCECb9winIk1D2L1QMx90WJTe0LhIomdvwGxCkCCuHWGCjVkWqXlFEqw4
 nQ3Q==
X-Gm-Message-State: AOJu0YxUlv57SIKWytwlivFcZhzerYWhvDUOlq+fW230BL7R2eul1Z+d
 a+KOyaXv1VCFMXEDF1aJGVIHXSRIk/8WQfr371BYPLEvUga3c8PLBkl5zwyJvQw=
X-Google-Smtp-Source: AGHT+IGQogBX2itY1/CyX7tEUSsuqxFBYPVN6pqzcfwYYR0B0Y8G+crGdTdXloNn7Dzw1hcZyVOcZg==
X-Received: by 2002:a05:6871:b28:b0:254:f00e:569b with SMTP id
 586e51a60fabf-25c948e9dc3mr7899010fac.6.1718926228895; 
 Thu, 20 Jun 2024 16:30:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd49d18c1sm136568fac.28.2024.06.20.16.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:30:28 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:30:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] buildman: Support building within a Python venv
Message-ID: <20240620233026.GU68077@bill-the-cat>
References: <20240620131937.1130446-1-sjg@chromium.org>
 <20240620131937.1130446-4-sjg@chromium.org>
 <20240620143232.GM68077@bill-the-cat>
 <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eZuMwjQ97vQVMHhe"
Content-Disposition: inline
In-Reply-To: <CAFLszTj0QgctNFigd=m7450gCLU3mnu9bTXtk=DuZmE7eAtWBg@mail.gmail.com>
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


--eZuMwjQ97vQVMHhe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 05:05:30PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Jun 2024 at 08:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 07:19:35AM -0600, Simon Glass wrote:
> >
> > > The Python virtualenv tool sets up a few things in the envronment,
> > > putting its path first in the PATH environment variable and setting up
> > > a sys.prefix different from the sys.base_prefix value.
> > >
> > > At present buildman puts the toolchain path first in PATH so that it =
can
> > > be found easily during the build. For sandbox this causes problems si=
nce
> > > /usr/bin/gcc (for example) results in '/usr/bin' being prepended to t=
he
> > > PATH variable. As a result, the venv is partially disabled.
> > >
> > > The result is that sandbox builds within a venv ignore the venv, e.g.
> > > when looking for packages.
> > >
> > > Correct this by detecting the venv and adding the toolchain path after
> > > the venv path.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Why are we using PATH at all in this case? Shouldn't we just be setting
> > CROSS_COMPILE=3D/full/path/to/the/prefix ?
>=20
> This is the -p option to buildman. The original commit was:
>=20
> commit bb1501f2c22c979961b735db775605cccedd98f6
> Author: Simon Glass <sjg@chromium.org>
> Date:   Mon Dec 1 17:34:00 2014 -0700
>=20
>     buildman: Add an option to use the full tool chain path
>=20
>     In some cases there may be multiple toolchains with the same name in =
the
>     path. Provide an option to use the full path in the CROSS_COMPILE
>     environment variable.
>=20
>     Note: Wolfgang mentioned that this is dangerous since in some cases t=
here
>     may be other tools on the path that are needed. So this is set up as =
an
>     option, not the default. I will need test confirmation (i.e. that this
>     commit fixes a real problem) before merging it.
>=20
> As to why we don't always do this, well that is back in the mists of
> time, 10 years ago.
>=20
> BTW, this is raising a point ("let's change the behaviour") separate
> from the goal of this commit, which is to fix a problem with venv,
> albeit that if we made -p the only option, then we could potentially
> drop all PATH changes. Perhaps toolchains are built differently now,
> such that they always invoke their tools using the same prefix and
> dir?

Wait, I'm confused. buildman internally updates its own PATH to avoid
calling CROSS_COMPILE with the full path due to a concern about
toolchain bugs?

--=20
Tom

--eZuMwjQ97vQVMHhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0u44ACgkQFHw5/5Y0
tywdxQwAtk7WBHNMWFSN1kZhSSLrlbadxEArCA+z/bYt5O6YXU7r2pAoE+zGIx/O
Kr7DcwCulrKLfNA099KET2U/EzaiK5NupvV+BGM2lGb8dWE75U+evWffBcej96VX
grnCQcLvKwxEOA/xcjgH6vSR0o3gqGuKWnOdllaRyaz/9Z18ifwMaEechuNo7+nn
nerfrOultiXoLcik6wFUW0/tkrM3KvFGyzgTq4DkUyza6M9RvSuhIz41C8YlbE6x
vBqbbwCl3NpOiszrdBryyvqX1okNKF14NorpfM400k42uCLbtcgbAtl3MRiNdrds
E02ZkcQXDW94REwJtewZ1VHq4K+Sp+xWrPLuJLeZbd9DDQ4WL7aJoGTHfMtkz836
08takKVhgCBiSsY1Bz2WFYx4D6xLODu50vkt+ATs3DR0CjwJXnm+vHU3CMBOrsXD
zPv8lBDrmnsPv9tRMGE3Tho1EmaEMK0ugo7ln4pLtptqUkMnkALcyWxE2k+8jXCq
szbeV0GQ
=yOOS
-----END PGP SIGNATURE-----

--eZuMwjQ97vQVMHhe--
