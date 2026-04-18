Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA936F99C95
	for <u-boot@archiver.kernel.org>; Sat, 18 Apr 2026 22:53:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8631683BC8;
	Sun, 19 Apr 2026 00:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n2RmnFgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 076A583E81; Sun, 19 Apr 2026 00:53:06 +0200 (CEST)
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com
 [IPv6:2001:4860:4864:20::43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC6F839D9
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 00:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x43.google.com with SMTP id
 586e51a60fabf-4152698e745so785735fac.1
 for <u-boot@lists.denx.de>; Sat, 18 Apr 2026 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776552782; x=1777157582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WIYcgSsqEAFD/7576DYSGhmlkCKImBL08erbylrBTEI=;
 b=n2RmnFgZDmmixIWCfR3XsEFcvphmjVdGu+MOgC+xq3TX9J8dp/ahQwbTozY3CsK5L4
 nMCw6aMtBWoKx60RTLf/VPCxUFUqrD+FNhlqv2mTlcj6+K7D33K2ivBEIjEYoOmlMc35
 4EpbT+lxpVJgiSjiq7UpR4hKCaN7yiEqJUty4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776552782; x=1777157582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIYcgSsqEAFD/7576DYSGhmlkCKImBL08erbylrBTEI=;
 b=pM1KvxARFmsJBeGKrccWKwjpCPELiHYJKvF/HTV8Pf0P+AYi3+Vwu6WfuQSgAVWFbz
 lJjP3u1FgTELyrsnolwHEABGozatgIersoGIDCyjqNdgbiwnSSSDH+kkkMttuFXYP/5m
 P5xSQvjQL8IxOACyIVpk5gDT15jz2mhf5dxaVWiIm0QXRjWjoQV7N3fD+iDw08dM326Z
 JgUgrq/YD1BHg3FsJbCWSKyQna1dzT2C9NnQYpd5aFoUul3zweJXzvNWZzyl/Xvu1h8I
 +DjZLGCit8DXIReTFu+CP/KDnHFDFibsMCPK2fEl4W+KZkmlpC3N0gFIen4dqVwYhe3V
 nc1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ//mXZGDutu60IlFrf3WFmgz/aDwyr4tcKYzZKF1p3+/2nxhfkJJAdZ3qVhqq83Z4oZ687gj7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxiUg8zFqzQM+60c9x/aZIyDsUjmV+y2wOBQzlcSPyh6HSjWP3h
 SIQuCiL4S8IpZ9qUc8IVxg1mgas2XOMehWrlVwO5+3tkGj7Mj2bmmc9Zht7viVTBS0w=
X-Gm-Gg: AeBDiesiRbu9yp2FVnNvk/VNxsiPW7dHHoqOMOFie6nDRRfXNiObCVP9TcH1c5FAd0D
 Zo7zWlOkGN65amJDk3puUp1md+KWMzrCfb27FaqY8t5A3Fb6nQKqRh5Mz2d2k/7BVrX2/GYbWnR
 PBFxxhDBePxU/i9an5pIvtlbp5psOiEt/6GIQEo+Kp1djv0dD7PiCDg72EaVY3DBHccG8AmVHJe
 MK8MPzNAGrF7Zn+4fr0/9ydNx56X67F+j1YLqllxMSjfiH5JbAaAIiHSE1j1M/RiZ7pe1LOwYR0
 5ZO4zZbzRQcP1IeKXd7wGXPK6LQp/5FGFYngHk05JJ7W+GjWXuLelGhGY7IZwb9WeaS6xe+bxRM
 MAgAEXRJHpQp2joggWdG+Br1xa2u5/xRpGfnRAL0UoFGDRvNQuw6oRgKcvhNXunnaj3PvzHgA5s
 RQ6TAoHuh8lpgq+yMjBV9ojti2Gs6KxM5F6ALlk04TjH4jTrvymbNHMFishISlaXjeOHGkkN+pT
 CKLD9/EJCaP3aUgHm8bVBbcdzC2fZkWOZMoPKmrMb1ujUEAbidaDWPOsuVhRQ==
X-Received: by 2002:a05:6808:1384:b0:466:eeac:bdda with SMTP id
 5614622812f47-4799c818beemr4528233b6e.5.1776552782160; 
 Sat, 18 Apr 2026 15:53:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930480bbsm4475670fac.4.2026.04.18.15.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 15:53:01 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:52:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] scripts/dtc: avoid discarded qualifiers in
 overlay_fixup_phandle
Message-ID: <20260418225258.GU41863@bill-the-cat>
References: <20260418181510.51490-1-heinrich.schuchardt@canonical.com>
 <20260418190921.GS41863@bill-the-cat>
 <b67ed115-b040-48b0-b7d3-936dc8fb7dd6@canonical.com>
 <20260418194953.GT41863@bill-the-cat>
 <9447010a-c660-4776-8d8c-4313f4c40ae4@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XKkaDoZjm/v2TjEE"
Content-Disposition: inline
In-Reply-To: <9447010a-c660-4776-8d8c-4313f4c40ae4@canonical.com>
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


--XKkaDoZjm/v2TjEE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 18, 2026 at 10:01:29PM +0200, Heinrich Schuchardt wrote:
> On 4/18/26 21:49, Tom Rini wrote:
> > On Sat, Apr 18, 2026 at 09:46:47PM +0200, Heinrich Schuchardt wrote:
> > > On 4/18/26 21:09, Tom Rini wrote:
> > > > On Sat, Apr 18, 2026 at 08:15:10PM +0200, Heinrich Schuchardt wrote:
> > > >=20
> > > > > When building with GCC 15.2 the following warning show up:
> > > > >=20
> > > > >       scripts/dtc/libfdt/fdt_overlay.c:422:21: warning:
> > > > >       assignment discards =E2=80=98const=E2=80=99 qualifier from =
pointer target type
> > > > >       [-Wdiscarded-qualifiers]
> > > > >         422 |                 sep =3D memchr(fixup_str, ':', fixu=
p_len);
> > > > >             |                     ^
> > > > >       scripts/dtc/libfdt/fdt_overlay.c:432:21: warning:
> > > > >       assignment discards =E2=80=98const=E2=80=99 qualifier from =
pointer target type
> > > > >       [-Wdiscarded-qualifiers]
> > > > >         432 |                 sep =3D memchr(name, ':', fixup_len=
);
> > > > >             |                     ^
> > > > >=20
> > > > > Define sep as const char *.
> > > > >=20
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical=
=2Ecom>
> > > > > ---
> > > > >    scripts/dtc/libfdt/fdt_overlay.c | 3 ++-
> > > > >    1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > Is this something already fixed in upstream dtc?
> > > >=20
> > >=20
> > > 9a1c801a1a3c ("Fix discarded const qualifiers")
> > > in git://git.kernel.org/pub/scm/utils/dtc/dtc.git
> > > implements a similar change.
> > >=20
> > > But the patch is not applicable:
> > >=20
> > > error: scripts/dtc/fdtput.c: does not exist in index
> > > error: scripts/dtc/meson.build: does not exist in index
> > >=20
> > > The change in fdt_overlay.c is identical.
> >=20
> > Yeah, we need to re-sync with the kernel again, and there's some other
> > issue to sort out. I don't recall what, just that someone else had
> > looked and it wasn't a "update, no changes required". So we should look
> > in to that I think. I don't know if gcc-15.2.x has released with a bug
> > fix for building all of our platforms or not yet:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121588
> >=20
>=20
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D121588 is marked as closed=
 and
> backported.
>=20
> releases/gcc-15.2.0-665-g4886dd899bb
> 4886dd899bbb ("lto: Fix SegFault in ICF caused by missing body")
>=20
> This is in Debian and Ubuntu since release 15.2.0-15.
> Ubuntu 26.04 is at 15.2.0-16ubuntu1.

And not in
https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/15.2.0/ so
not available to CI yet. So I would like to see if we can move up our
dtc backport of the kernel backport, by the time there's new crosstools
available.

--=20
Tom

--XKkaDoZjm/v2TjEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaeQLRwAKCRAr4qD1Cr/k
CiIzAP4vu1rgORCzUTEnUfr48rsgF7pPF0iuTcL/ST+b++fXtQEA0JTev7dFp6CZ
/XHoi3slqRxoKzeK07jTXFUW0ivIrws=
=ADJT
-----END PGP SIGNATURE-----

--XKkaDoZjm/v2TjEE--
