Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084B4C369BD
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 14:18:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6346981FFC;
	Sat, 19 Apr 2025 16:18:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q3trkC4U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B8008210E; Sat, 19 Apr 2025 16:18:44 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C00DC8129B
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 16:18:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3f8ae3ed8adso1482569b6e.3
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 07:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745072320; x=1745677120; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Da6/0nywIpCt00wyeo/mFbkxcs4/Buwl5ZQ2s2Jn2M8=;
 b=Q3trkC4UOG49ik54XNII754mkqipnrAZjcHsk9q2xY3CTKKDNQr/yIQMr2VxCCsy0V
 1cw/S5jFXYEO1hdl6ttRCwi3LuQFyHqkLwZmxj096YNgBn+46ywmQeMB1+zYFG75PQyy
 E6s89au0S3iIGGZw6O1j5dJAo5s1su5jDBRio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745072320; x=1745677120;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Da6/0nywIpCt00wyeo/mFbkxcs4/Buwl5ZQ2s2Jn2M8=;
 b=ngA141AF8867lZ/c2TeNpL3hHCUv+Ocvx6cbDNiZCDj6Kj+Xop+RN/tzC7q6jH0x+w
 1i4MTmyn2b+2CMzYm3ATdtyBrqSNURwcXh4aDm9jL48yCinpqAfFBK2JeaIA0Hl7j7wa
 TkZHX0Kl6rZ62mxHYQgQU+2KDGzTaFNAKkx5lUEUxQ+coKvHYm8P2NpYHAJVUxUvzUlt
 L2HKX+Yc8SWZouDvwEDGUACiR3QgeIuynQx+lPeR82zWG9SF9SKOTyuZfSM0HAq085jT
 Qjt5OIeIppjJhKKM+fHCDTQLQQNzJhXr3vkpeEPIPig/yRkE1u+X7NVphIoOS7s2KK8C
 y2Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq6pALXrRFOx/aGcdqfRB0tg4+3OMNZyS+BR/TVWHISaCXEvp440RhyU9oqiJEk2DHFqXAxtk=@lists.denx.de
X-Gm-Message-State: AOJu0Ywtq33O7KyWHQUKN7KWO6VCR2CpAhTioBoIy6kDvs2SD8m+BHKG
 qD1iT+Dklq1pOCAWIsLPVKcBvCHqKy/743XCSk30NcfK9sDjsPjH0548Tm6tw8o=
X-Gm-Gg: ASbGncsO0v4qgGc7alnXXAXWznNnS+QZVfZdcimL4NY3i76Yf8Af5Pulgt2OxZNe0Va
 zzn585mE+AjoPjfImhKbc3m1nM4+CUrEoPZkqGoScuuB6HKiZ1a+WMJv9x3zmnBpBqILT87kdLA
 xKykeTH8UKIZvwbldYyOh5YunGlpp6ggTc5XvrI4Tgu5z5N6fhI2Hos4/2LoqVCZbNtdRZ90ZOa
 KUAim1fNm/6R3zBfV8LyRsLUZPhgjMLD7kOUCfLly51AojYdSep3vjOrda+qaTsxqsavt4L5SlB
 bEjEgbU1cWkO0qr8MdXRBsBmwftcC5QjvJc4IqkifAMXgUuYWI12haUAGUV3NmWAQhLUXY1reiY
 kmg==
X-Google-Smtp-Source: AGHT+IEMm/z1sjeD6W6q1ghYWEgF1RZsbwuvnT2ETsJD1EiujRaCMKxo/J5+UpMb3shEQzdIdlh+0w==
X-Received: by 2002:a05:6808:6c96:b0:3f6:abec:2ba4 with SMTP id
 5614622812f47-401c0c0a1c2mr3270328b6e.23.1745072320469; 
 Sat, 19 Apr 2025 07:18:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-401beeaf8f2sm733086b6e.10.2025.04.19.07.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Apr 2025 07:18:39 -0700 (PDT)
Date: Sat, 19 Apr 2025 08:18:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
Message-ID: <20250419141836.GS5495@bill-the-cat>
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
 <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+TrpEmXbn0Tixpe6"
Content-Disposition: inline
In-Reply-To: <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
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


--+TrpEmXbn0Tixpe6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 08:14:22AM -0600, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Sat, 19 Apr 2025 at 04:20, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 4/18/25 13:39, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.d=
e> wrote:
> > >>
> > >> Hi Heinrich,
> > >>
> > >> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> > >>> Currently we are no able to build with configuration fragments in o=
ur CI.
> > >>> With this patch buildman gets a new argument --fragments for passin=
g a
> > >>> comma separated list of configuration fragments to add to the board
> > >>> defconfigs, e.g.
> > >>>
> > >>>       tools/buildman/buildman \
> > >>>       -o build \
> > >>>       -k qemu-riscv64_smode \
> > >>>       --fragments acpi.config
> > >>>
> > >>
> > >> What about using:
> > >>
> > >> --fragment acpi.config --fragment fragment2.config
> > >>
> > >> ?
> > >
> > > Yes that could be useful. It would also allow wildcards, although the
> > > code would need to drop the config/ directory prefix. Also, I see that
> > > -z is available so perhaps that could be a (bad) short option?
> >
> > Hello Simon,
> >
> > What do you mean by useful?
> >
> > --fragments a,b conveys the same information as --fragment a --fragment=
 b.
> >
> > We are not passing any config/ directory with the fragment names.
> >
> > Using wildcards in does not depend on how fragment names are passed.
> >
> > As maintainer of buildman, please, clearly express how you want the
> > fragment names to be passed. "Could be useful" does not indicate any
> > decision but let's me hang in limbo.
>=20
> NAK
>=20
> We need a file which lists the valid boards for each config fragment.
> Buildman should parse that and it should be possible (with an argument
> like --build-all-fragments) to build all fragments for a board (or all
> boards), to make sure that things actually build. See [1]
>=20
> So until that is done I'm going to NAK the whole concept[2].

And [1] was also already NAK'd, so I guess we wasted Heinrich's time
here? Sorry about that.

--=20
Tom

--+TrpEmXbn0Tixpe6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgDsLgACgkQFHw5/5Y0
tyw5YQv/aSU/0F0PLMknyJ0qpk+TDxsCrcdoyPYoj0h6dbzQDyvfLGzAPIvgHVsv
CImq9ZIMv2PKrKbHrUsXfN6GkTYNR3zw655E2IwjCjrwEwRtrrOP7Qqk0jarP86X
LdWKrPjDAXtGNiYjwESK5j6XWDgIBoe++N81i/6Se5aKAOnku1z03wLv1AgFYAlF
vAhMFFIFX/c8m+y2hDWMosCornCfY7G3Ffl1oaS1AFoC3PNV/mo8bp9rS52vZ7iG
4JnBafh+V00ymPJS6VkZJMJYvT0FVeIn0yal2BfEJ1nbmzYYoB+b0BkoqfD5/qqO
M0QrxH8dF3T7a+xy5KwitTJ+o0Kly00iW4ynMOcCDddGHgx+bg1a7nfIV8FObT3z
HP1V0nFGH9sJ0UcR/lM02lpxA+k7NElDzdOAN2RCKaWTrP2oTt7EXD3y0mYWSVXu
I4Pklc+84zZDJ1bWrt4DMOhCu6c0a2Zx8e1/gMg5ZtJJUDxDOLvT/ei8a1iDxABd
dQI2FZ9b
=WZT8
-----END PGP SIGNATURE-----

--+TrpEmXbn0Tixpe6--
