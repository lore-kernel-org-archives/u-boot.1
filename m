Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B746CC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F337287CEB;
	Thu, 25 Jul 2024 16:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="innAtiJW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17D187E23; Thu, 25 Jul 2024 16:48:22 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCCBC8789F
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-708cf5138b6so690433a34.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721918899; x=1722523699; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bcfSEo+PY02ryCG163BT9hjSkE4Iem0osi2xURz7dVg=;
 b=innAtiJW8k9FBNpkVGL22VHBaixHM6KIlC3bgWjd6FC0zZFh2oU0/rqOfPlt8K/ZNF
 /A53it5ta6is3Y0cEkVQ0dF+mG7aoR6JisckYivM+fjytpYZWuwIXO38h67R10FdMDu1
 xEfjWPFLhcv+l6RDzlTEW/9pAxl7oeSZ553sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721918899; x=1722523699;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcfSEo+PY02ryCG163BT9hjSkE4Iem0osi2xURz7dVg=;
 b=rmm5QPRGQMYwwtvDgZY9GAfBFJ0S3V9Kw29pYZ3OIfAGAQipOVITE9RWwl5D9X0mQb
 FJjlBKo1ijVhbFZYUB97E50y40dKlRGrCLyuHhrr1QlyQw4vsmUS3tvQym2HCXbn+gmD
 TxOCTa6sN2Vsc+Cy8rgyesNYzzsG1KVG7FotT3Ealg4SWL69TTxflgXH6qkiiINWFeFB
 lQKvKBkxbMWZ9V6e26ykpWuwT9YPYWW7MdetkqSpqpRWTFV8rqBY6HLlO9/TDqQJ9STx
 EGnyN7k/oOCDvczWqBGhhnt1s0g6TsMt6+0kXLfT1g9USEqDN+uJ5mhYruWLDl99NUfl
 SIwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW50i123rZimHlnzm7sRUZ+4O0tiIziU6RLD6hkq41QXxm2vAjUu1jUCCp3cYV3vhZ0Qf3qLRsMs5TGgNcSM1BjTC6qA==
X-Gm-Message-State: AOJu0YwoLG/Pca3AicFeirqM6Dm5awYFyvQ4x05V63yVuotie1RniRuj
 8grNWvNJkPkAxGp5jE1hYSjB38JvlhIZphHTYftaOfuAOd5LbFwmQNGFmmF8UQo=
X-Google-Smtp-Source: AGHT+IH8AyAykLl1Liu3kuAQJ5AedsE62oawpHshQqVYFru4REJdGFAkl0HkYw7+lCeW9Aqk6QphoQ==
X-Received: by 2002:a05:6830:611b:b0:703:6a3e:d3ca with SMTP id
 46e09a7af769-709324c4446mr2594197a34.26.1721918899480; 
 Thu, 25 Jul 2024 07:48:19 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-45.totalplay.net.
 [187.190.202.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70930719164sm326171a34.31.2024.07.25.07.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 07:48:19 -0700 (PDT)
Date: Thu, 25 Jul 2024 08:48:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michal Simek <michal.simek@amd.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 04/40] lib: Convert str_to_list() to use alist
Message-ID: <20240725144816.GT989285@bill-the-cat>
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-5-sughosh.ganu@linaro.org>
 <20240724205418.GM989285@bill-the-cat>
 <CADg8p95EwPkVH4Lo2+9O8QeSrE90xLpUQXYEngK+YEr+YiJ=qA@mail.gmail.com>
 <CAFLszTiYt6hPf7YuR5wqr6WjoX1BSKrNtKGdx66qD_g5L9hF7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CfNrZXjMuyoewSgj"
Content-Disposition: inline
In-Reply-To: <CAFLszTiYt6hPf7YuR5wqr6WjoX1BSKrNtKGdx66qD_g5L9hF7w@mail.gmail.com>
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


--CfNrZXjMuyoewSgj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 07:59:52AM -0600, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Thu, 25 Jul 2024 at 06:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > On Thu, 25 Jul 2024 at 02:24, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Jul 24, 2024 at 11:31:48AM +0530, Sughosh Ganu wrote:
> > >
> > > > From: Simon Glass <sjg@chromium.org>
> > > >
> > > > Use this new data structure in the utility function.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > >  lib/strto.c | 35 +++++++++++++++++++----------------
> > > >  1 file changed, 19 insertions(+), 16 deletions(-)
> > >
> > > This is rather big growth when we didn't already have realloc:
> > > 05: lib: Convert str_to_list() to use alist
> > >    aarch64: (for 1/1 boards) all +1765.0 rodata +37.0 text +1728.0
> > >             xilinx_versal_mini_emmc0: all +1765 rodata +37 text +1728
> > >                u-boot: add: 7/0, grow: 1/0 bytes: 1728/0 (1728)
> > >                  function                                   old     n=
ew   delta
> > >                  realloc                                      -    11=
20   +1120
> > >                  alist_ensure_ptr                             -     1=
40    +140
> > >                  alist_expand_to                              -     1=
36    +136
> > >                  alist_init                                   -     1=
08    +108
> > >                  alist_uninit_move_ptr                        -      =
76     +76
> > >                  alist_add_ptr                                -      =
72     +72
> > >                  alist_uninit                                 -      =
48     +48
> > >                  str_to_list                                204     2=
32     +28
> > >
> >
> > I am working on an implementation of lmb maps using lists. The list
> > nodes are then allocated with calloc, which I believe is included in
> > most of the board images. We can then compare the size impact with the
> > two implementations (alist vs list). Thanks.
>=20
> This is for use with EFI,

Am I missing some context? The LMB rework is because what we have today
doesn't work all that well for what we need in a modern system (and with
modern security concious eyes on the code) with EFI_LOADER=3Dn.

> which is very large, so I doubt it is worth
> it. The alist code is simpler to work with and will be used in UPL and
> likely some other areas.
>=20
> We could provide a variant which uses malloc()/free() instead of
> realloc(), as I mentioned/ The impact then would be very small.

Switching to malloc/free instead might be fine as well, yes. Aside from
the realloc growth most platforms are at a minor size shrink. If we
address realloc then we get something more functional and smaller. This
should make everyone happy.

--=20
Tom

--CfNrZXjMuyoewSgj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaiZawACgkQFHw5/5Y0
tyyIHAv9GmUEtjreQtcAD/oKlu3Uf7j+zQvOTCz5COhlp2uY9z1Jb6KjtyofJJDP
ECiXMdvnpCSgKBdPrTPbuxK+JoOs/0qzcjdW5uVU2ohC9crlKSGBu3EyOzdDJ2B1
zXQk1wN5inbCKNxkdf5nLRBswU6obCUwlUtdL2Y5+VilzwN456cKdI7bEO8GhzvP
66ynlgo/9BHhLrFiikJN/8RhaTkMzyZzNz/spF2CnAtycsXWVvKIvAbWv+0u/C1h
W2l9JMC2y11EETDezbg149czyX6hPw5szmqma1itVbMV05DE5BrRmqAXHsg2IXKN
d81PVNqyPLVE8STBTlzs3QUEjSmkwg7OyfcM7Rd0+NLOSXwr1Ut63Rz0ujaQUClZ
NYmCYS8rX3AOUCMtlmTxEqL13iN2t+AzhFiW0uinFGudlap85MGIYoOV5CIDMKbp
1hiWCn3y5Kw/arvfVxmmX81zury8JyBd89u7yZ5WIGePQJaUh1TsqdsA8JHqOEcQ
hg6TOPoU
=rCJI
-----END PGP SIGNATURE-----

--CfNrZXjMuyoewSgj--
