Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8272ED116F1
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 02:17:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFED83DBF;
	Tue,  2 Dec 2025 03:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UOpNRZSu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F3DF83DE0; Tue,  2 Dec 2025 03:17:05 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17D7F83DB6
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 03:16:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7c75178c05fso1343061a34.0
 for <u-boot@lists.denx.de>; Mon, 01 Dec 2025 18:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764641816; x=1765246616; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwl2+c2z8F3/g+bKB05LRiek90OhbLnWx8WipANn9z8=;
 b=UOpNRZSua/yEfcLyt/nzHvm3S4vvMpYRqsyHgxcioq1CvBlcnQz/yC4HvInNtIj+/l
 /esHiVCyfYYSeL1Qd24K2E3HUuQRKMuNxlrKVdwqqcdi0Xm2v3pQbRoLXgDdjccFMaah
 MUZtTYa4U4F1uObqLdB84goZVKx+ugh3uUx88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764641816; x=1765246616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwl2+c2z8F3/g+bKB05LRiek90OhbLnWx8WipANn9z8=;
 b=QV87gTzMWehgFYftsess7RDyLGrnHbu6GnukWX1MP2pumob0h4xJh3P020tI5acS3v
 KoBRSizkQ9DgwIkIbzHBwC/Ai/OuE6oEOHrc7Yxz0mlYoXlHQkejwUtq+akM81nPAZ9c
 Dbeu1mOAd/htcpCInmgILWWrRBHMBy1yXlZPyVqDVD7fTNK+mwv5pzokEW8muXrXkv5l
 FT3r3G1fNpkTtUTJvyMe7Xv+JOmzP1z1fOE4OFMRtIlcCR/vwMygarqabJR1gnK5JeuJ
 yZYGdmAFsTmt8NZLYwsxcVl32AayxVkLPvcwJGdnqjIHPTb+W5W81+m5L8jqXZa6hPUo
 2Tig==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgOYHY/2+hQ/vgtfSaOo17EGyd4n89vG7yzZQhJEBnYbn32ahkZtnfeHhzI4jH7BpY1AIjs+U=@lists.denx.de
X-Gm-Message-State: AOJu0YwNyzQcGuptsjVM9tq9kD+2Du+WhP526RiyW1pV0Hwriw9dMD0T
 20nDqjSv+UDoOo8jgiuEfzSsK0aWmQnQVSeqK3Fod2oxB/liWmClO1s57lU2H5dHhuk=
X-Gm-Gg: ASbGncudx1ePSyDaMlmzmseT53KK/xXMgjuyOCpWJrEOgZ+T0oova0sHkOXvrze2eNV
 H62aK/HRQcOkUQjXku3sbl0cSwgjOlwzgs4nxwOVGpmXFNS0jBg2a0Hk7lZ7QJbdBPRjK6zeHgQ
 qNucYOFGE7mXdaKugvK3KW2DAQx3PLr0ojOXfu6bGwK1dXCA95P8mW74j5kMrfkIzZah2UmZlKZ
 sVU7mKym5yz6lDAh2IHJE+aM/jDIcuRTT6N3StHb/+WjcsfJDk5CDBIqpWrzUbfEinxFfxTPaLl
 9FIIBGrRAjjvqtzswrucgPBN3cP/qIaVuYyNO+sNWlmKyffrZmvKO5uRHMIIUg9Y/o8f/ZqGAyx
 HmmlNB2GL1xLGqQj5rrII1irwlXFrPSODCHy4ELZ1EzlCZvii/36QQhYqWSnKbly/LV/eKA1bdL
 6FxlgqupibvdgKNSFoiLkvVI55m3fev5HuRPDopMZwqRzhN9Sy7A==
X-Google-Smtp-Source: AGHT+IF2LADdE0fyYNth1bZmNhtPlZHOQd+PnW2icM7PXuy7lqY0Px1EwR74DnLMBlal2pHL+OT+3A==
X-Received: by 2002:a05:6830:6e05:b0:756:a322:311 with SMTP id
 46e09a7af769-7c798b03853mr23525825a34.10.1764641816618; 
 Mon, 01 Dec 2025 18:16:56 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c91002922asm5790468a34.31.2025.12.01.18.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 18:16:56 -0800 (PST)
Date: Mon, 1 Dec 2025 20:16:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "davidzangcs@gmail.com" <davidzangcs@gmail.com>
Subject: Re: [PATCH v1 1/2] imx8ulp_evk: Move environment variables to .env
 file
Message-ID: <20251202021653.GB303283@bill-the-cat>
References: <20251201105657.1968244-1-alice.guo@oss.nxp.com>
 <20251201144151.GD303283@bill-the-cat>
 <PAXPR04MB84593934DDC86F86B14886B588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Kruk1xNFJ5MiuAz"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84593934DDC86F86B14886B588D8A@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--5Kruk1xNFJ5MiuAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 02, 2025 at 01:49:24AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v1 1/2] imx8ulp_evk: Move environment variables
> > to .env file
> >=20
> > On Mon, Dec 01, 2025 at 06:56:56PM +0800, alice.guo@oss.nxp.com
> > wrote:
> >=20
> > > From: Alice Guo <alice.guo@nxp.com>
> > >
> > > Add board-specific environment variables to imx8ulp_evk.env for
> > better
> > > maintainability.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > [snip]
> > > +fdt_high=3D0xffffffffffffffff
> >=20
> > NAK. I just the other week sent out 40+ patches removing that setting
> > from other platforms and you weren't even setting it before.
>=20
> How about add a check in checkpatch.pl to give a warning on this?

There's already one which this triggered and is an ERROR level as well.
It also tells you not to disable initrd relocation, which is just a bad
idea in many cases, rather than often fatal to the OS like fdt_high is.

--=20
Tom

--5Kruk1xNFJ5MiuAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaS5MEQAKCRAr4qD1Cr/k
CuxmAP9Np4ac3w2BdA1lwkccddLGOXK8xfr9gtCwD1rSjS2VKAD7B48QaJH09PF1
tD22IfGlB0h1+Vx6AKVqbGfbjoK/YQk=
=Q+54
-----END PGP SIGNATURE-----

--5Kruk1xNFJ5MiuAz--
