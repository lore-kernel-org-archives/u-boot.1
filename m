Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B202D2168E
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 15:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8501183AEF;
	Thu,  4 Dec 2025 16:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ddodn320";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DC384053; Thu,  4 Dec 2025 16:30:44 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FBEE8367F
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 16:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c76607b968so462311a34.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 07:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764862241; x=1765467041; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dQ/h0NrSgPbbffDW6vpNFR7D+EG0Jlh2RdDeUry5P1g=;
 b=Ddodn320aUSF4jl38Nk4O5PD3b2vFd3IM1F5/esTigH2Xcph9hRm2fmZQUUPs/d58E
 vvWEa5cPxWvqiKjqn8HvL1I6VWPTmB8d0xFV49SsCJb9S2tSGT+nXIveTqEUuVccwOB+
 PB580oS71UQRKsMOKpDtv6hU09FBhDbmVdJiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764862241; x=1765467041;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQ/h0NrSgPbbffDW6vpNFR7D+EG0Jlh2RdDeUry5P1g=;
 b=dyuTSWJLAaBewZ6eNwj7ntmXbQn7mIhoV9GkQltQhaPssosWAImMxwiRl3dRQptQ6j
 bN8NnDDVKkBerATmq71VLmZYrHcTlVkUwnjHOj7cmOtZTp7b/uhP/c0s3kugBnPhOelZ
 1VeDuqw/Uarn98pe41B07SoKk1UdZKDVBmNixsIbVVCuGy50EwMXRxld0sOJrmCLiU53
 LFIdYIO8Ilr/hHfPw7Pl1o/yWauvF/lj0efM755WrniWT4AgzGxaBySGfNYi07gL5ls1
 /BZ7vWGEa2BCAmR4eUWlfyImGk6bN9r0gc4ExIDeMA4O27TRBH9YVa0xfbV4u79+qnjl
 Lh7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyqw9FoFXPGTTh4l+TwVZGoJDBu9UP0fQA6A0drGhgc8RxY02LyH21I57YFKRyS4b8S5F33jw=@lists.denx.de
X-Gm-Message-State: AOJu0YxUSh6W9j9ee1M/WR9WhphnjpbSASrlYPR3VWd0Df33Zr2Tubya
 F5tEFO3ndBeJhajGsUwwOXfHPd0uPGuyNu2infRYblux9hdsenAcm1ZYTNxcX+XC4mmP1iumnEe
 DOcLspAs=
X-Gm-Gg: ASbGncsPvYI5JErJzmDuC6lRtL8FieUgrHZ5PiZ7tSru3IyVckyciNCRrDpwzwWWeMJ
 IWWSRQjHdb7WSDIeg/13fRWpu2pogz9d37V/R/TW/4ls4X3k5C9fyTuDrf0Kl1KKbw/D7S3Hi0h
 Dl+Z+bJPX0AjVnQHh8mgpHmeLTGMJoHXgleTlC9fER09I7hIYJbeaq2pR65LIYBB6omzzbNJ790
 wYyWThhz+qR8x9ZDglVHtZp9F9wZyojpXpbq9nhrIj8PrfTli0/l4SOPmWviWkB478dcigELKce
 E1XOyhn6BuJproJG2FDU+QFf8fWapX3AvgX4j7ynlogrJcqBCddPN+l79QbvpXfgzfMNcMaFQQC
 QwoQqjxvT0vtSH4Se7bZu6/2MyTHGcoOpU9KGphuBmE7TUKvaP958r42r0xHqmYkHmpY5SJ1FWj
 vJ5jXdH2z+90dKVH7EHxmADolnnm43wuMYrChd9+7GGQTv8ZO7MA==
X-Google-Smtp-Source: AGHT+IGmOH56nZtpk8ibIO80MLT5ts5DQzZyj/0WxVlJsqaDpujnnbIj11XGMcowFtJy7KvvXAY4fQ==
X-Received: by 2002:a9d:615d:0:b0:7c5:3eea:7bdb with SMTP id
 46e09a7af769-7c94db43d57mr3952961a34.10.1764862240988; 
 Thu, 04 Dec 2025 07:30:40 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95acfafeasm1527962a34.29.2025.12.04.07.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 07:30:40 -0800 (PST)
Date: Thu, 4 Dec 2025 09:30:37 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: nm@ti.com, u-boot@lists.denx.de, mkorpershoek@kernel.org,
 n-francis@ti.com, anshuld@ti.com
Subject: Re: [PATCH] doc: board: ti: Add J742S2 support
Message-ID: <20251204153037.GY303283@bill-the-cat>
References: <20251204142451.834404-1-u-kumar1@ti.com>
 <20251204144840.GX303283@bill-the-cat>
 <c3416918-965e-44c9-b202-ab9703806ad2@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fo4mt7hLQ+p9LV4l"
Content-Disposition: inline
In-Reply-To: <c3416918-965e-44c9-b202-ab9703806ad2@ti.com>
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


--fo4mt7hLQ+p9LV4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2025 at 08:49:36PM +0530, Kumar, Udit wrote:
> Hi Tom
>=20
> On 12/4/2025 8:18 PM, Tom Rini wrote:
> > On Thu, Dec 04, 2025 at 07:54:51PM +0530, Udit Kumar wrote:
> > > J742S2 SOC is derivative of J784S4, most of build infra of j784s4 is =
used
> > > to build u-boot for J742S2 EVM board.
> > >=20
> > > Add guide users on how to build for that board.
> > >=20
> > > Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> > > ---
> > >   doc/board/ti/j784s4_evm.rst | 24 ++++++++++++++++++++++--
> > >   1 file changed, 22 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> > > index 22442874110..4162a42c075 100644
> > > --- a/doc/board/ti/j784s4_evm.rst
> > > +++ b/doc/board/ti/j784s4_evm.rst
> > > @@ -1,8 +1,8 @@
> > >   .. SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> > >   .. sectionauthor:: Apurva Nandan <a-nandan@ti.com>
> > > -J784S4 and AM69 Platforms
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > > +J742S2, J784S4 and AM69 Platforms
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This is too many '=3D' and now CI doc building will fail with a warning.
> > Please build doc changes with:
> >            make htmldocs KDOC_WERROR=3D1
>=20
>=20
> When I checked locally, I haven't encountered any error
>=20
> https://gist.github.com/uditkumarti/94780fe8ec2bb4b55c46b1ab4afc7e7d

But it also didn't rebuild the file in that gist. It's not like -Werror
in that it fails immediately, it just prints a warning while building
and then (only that) make instance will have a non-zero exit status.

> Anyway, I will send v2 by removing one extra =3D

Thanks.

--=20
Tom

--fo4mt7hLQ+p9LV4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTGpEwAKCRAr4qD1Cr/k
CjKJAP45g3CWs02z6cpUFDZpSJ4j/u+xdw3eWqFwjfkHB2LCcQEAzmXU+FTlRpf6
rykO41oZZG4NWIxx9TEDSeixYtr7iw8=
=eYTn
-----END PGP SIGNATURE-----

--fo4mt7hLQ+p9LV4l--
