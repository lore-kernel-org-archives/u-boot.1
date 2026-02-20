Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431ECC56206
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 15:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58A6683A5E;
	Fri, 20 Feb 2026 16:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Y9ogGQZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 501E983AC5; Fri, 20 Feb 2026 16:07:23 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B0B83936
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 16:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45f171cb842so1532950b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 07:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771600040; x=1772204840; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rKsrXrzi69k2FJ44N4F68J9PrX8HXuFz20u3D81FFqg=;
 b=Y9ogGQZxmitUfSGr6knzjYA1VGjZJJ5jyE/F+5VWrWdX5rGADZuKCwwqYijAucUylI
 rsu1/Ku4c80oYtMvKXwdkD7TWhcbzBEo9Z8WVoPqFsaleZ24O9CqmfoI5PL3UwLT+cEA
 FpH6YX9toZgKX5ed2ZeeFeDIMHv/1MSv9OIAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771600040; x=1772204840;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKsrXrzi69k2FJ44N4F68J9PrX8HXuFz20u3D81FFqg=;
 b=tSfgQBy/DStN4pzOZ6bJzYNzOYo0+F3I/VMljJyZr2mE3hda1X6C+WaY/m9TPGhbeo
 dTx0KzPwrDAfgP9piPtdoFpCBc8GIKJGGz3QBL4YE60eToOuLp1PDAPwJVdnFiFGASbU
 R1wd9KNrhncOFKZ5+QXzIPiIR4cTnLVCP6TaoOHzrxYl9ph+xbYu9YqdmJTO7gUbwsv7
 CJRYI7EUY2vWnJoq2YNOe8c/PEwsgGuBuiEkMUX7CPSylKqrSE5InbFWv1gwNcZ6F2Rm
 LIRkg0ReKsgf9u/VUzMW7mx5MZuIwpTJuwV+P3hY5skGwl3ZhdinDnnmgrIsCG83yg+O
 dclg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4rJ4L6omszGQlwZ01jwOrrLr1sXBirqSgJmWvr9fcXWXE2xKSa7edpxloJzZvMcAssrRMf9s=@lists.denx.de
X-Gm-Message-State: AOJu0YzP8+3lCjLo6S0AGKjrrCvTk2oGG1umtKzAc1CxjV9mh1Kq73UR
 NdXpNMaDOCNTnPEHXGhn8lxj9unKc3rA3/tk9QKqycjAT845MMVb2Z0GgbUQC8BgdL8=
X-Gm-Gg: AZuq6aJnWG2ucs5pbIA9czQvoGASIPzCdKm6J/zC8oMghH3n1Exj0GwyuJ4vvA3oism
 fyt+QIKgd067ubMhOFtNfy1qjKNbTC57P++zJ5lRtI+PZvXUu6BTyUyj2pJPu//9J9li/unBmTP
 rCQRkTelDySlXfenvXbEKjcy/ArdFDn1BY87otBLRLYvKEizkdrS0zjTSj9id9bkSw4TB40UhCp
 4KMy5kI17X3b6mqitemY2yH/c3743wgDLM7DRUBTf0pSx7Ba7XFbBUBAUR/2dKXu5NYLCk7oPxr
 /GgrjoEwzMerSnQCJeJg9dgOBevKOUAmYDkKgz227Ektm9Sv3+XCI1J6WAkcKlYbHe5xgOsBP6u
 IsrO1+Xd+2fDZoxizdnhRQsIQ2sCGKfgRpwHP4zocHDByyM4IXxf8PRDThcnDpyB2rFAD1xK8hK
 qGYPrD9rkUMrOIWXX/Av0w3rFZyzK5rCeAjZxVwZTOAF8cRQUuvLi5oLWrFoJHopBINj27n5awG
 8gbTCqM/4abXZDLCNUrEJub3nwidGg0YhuVc5XSrsXN7RctPd8=
X-Received: by 2002:a05:6808:c228:b0:45e:fcf2:b693 with SMTP id
 5614622812f47-4643b987ed1mr1184540b6e.29.1771600039665; 
 Fri, 20 Feb 2026 07:07:19 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4642b1c526bsm3316873b6e.8.2026.02.20.07.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 07:07:18 -0800 (PST)
Date: Fri, 20 Feb 2026 09:07:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Michael Walle <mwalle@kernel.org>, Conor Dooley <conor@kernel.org>,
 u-boot@lists.denx.de, Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [RFH] SPI and SPI-NOR patch help
Message-ID: <20260220150716.GT3233182@bill-the-cat>
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat>
 <87bjhmv20f.fsf@bootlin.com>
 <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
 <20260219205726.GP3233182@bill-the-cat>
 <c1d92200-1099-4d8a-aae1-293cd1ee3f41@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oaq6rve+jYTAOM1p"
Content-Disposition: inline
In-Reply-To: <c1d92200-1099-4d8a-aae1-293cd1ee3f41@linaro.org>
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


--Oaq6rve+jYTAOM1p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2026 at 09:35:50AM +0200, Tudor Ambarus wrote:
>=20
>=20
> On 2/19/26 10:57 PM, Tom Rini wrote:
> > On Thu, Feb 19, 2026 at 02:13:24PM +0200, Tudor Ambarus wrote:
> >> Hi,
> >>
> >> + Pratush,
> >> + Vignesh,
> >> + Marek,
> >>
> >> On 2/18/26 11:23 AM, Miquel Raynal wrote:
> >>> Hello Tom,
> >>>
> >>> On 16/02/2026 at 09:31:10 -06, Tom Rini <trini@konsulko.com> wrote:
> >>>
> >>>> On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
> >>>>> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
> >>>>>> On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
> >>>>>>> Hey all,
> >>>>>>>
> >>>>>>> To be blunt, U-Boot needs help with reviewing and maintaining the=
 SPI
> >>>>>>> and SPI-NOR subsystems. We haven't had someone with time to activ=
ely
> >>>>>>> work in this area for some time. I'm going through the outstanding
> >>>>>>> changes now, but it also seems a common problem is that with resp=
ect to
> >>>>>>> device IDs, most of the new ones also aren't in the upstream Linux
> >>>>>>> Kernel. Is there some better and generic solution we're missing s=
o that
> >>>>>>> we don't have large and often growing device ID tables? I'd rathe=
r not
> >>>>>>> make that problem worse, so I've rejected two of those types of u=
pdates
> >>>>>>> today and I'm just setting aside a large number of others.
> >>>>>>
> >>>>>> Dunno if your timing was cursed on sending this, but Tudor submitt=
ed his
> >>>>>> resignation from spi-nor maintainership in the kernel about 10 mins
> >>>>>> after.
> >>>>>> I think Michael Walle might be responsible for what you're talking=
 about
> >>>>>> here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash dri=
ver"),
> >>>>>> but idk jack about spi-nor stuff.
> >>>>>
> >>>>> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
> >>>>> which are already supported by u-boot, I think. The only change that
> >>>>> seems to be missing is the fallback to it if an id isn't found in
> >>>>> the flashdb. Only thing is, the SFDP doesn't describe all features,
> >>>>> most prominent example being locking. So if you need that, you'll
> >>>>> still need to have an entry per flash.
> >>>>>
> >>>>> In fact, in linux I'm planning to change to make it probe SFDP first
> >>>>> and then amend it with the flashdb information (if there is an
> >>>>> entry).
> >>>>
> >>>> Thanks for explaining. So in that U-Boot does have SFDP support, the
> >>>> first thing is platforms should likely be enabling that instead of j=
ust
> >>>> adding IDs, at least for basic support.
> >>
> >> Right.
> >>
> >> SFDP is behind a config, because of size constraints I assume. And the=
n we
> >> also have a tiny duplicate version of the driver for stricter size
> >> constraints. Are these size constraints defined somewhere? We need to =
know
> >> them in order to choose a direction.=20
> >>
> >> Also, I'd argue that having the tiny version of the driver was ideal.
> >> Instead we should have tried to modularize SPI NOR, by SFDP, static
> >> initialization of flashes, manufacturer drivers.
> >=20
> > Some platforms define their overall size constraints, and so we know for
> > sure a hard limit even in full U-Boot. More platforms do this for SPL,
> > but not all. So the general answer does end up being that we always care
> > about if there is a more size-considerate solution with minimal
> > trade-offs. Especially since we are also in a more minimal overall
> > space.
> >=20
>=20
> Thanks, Tom. I get this. I was curious about some numbers, but probably a
> good reference is the size of spi-nor-tiny.o. My point is that if we try
> to modularize the SPI NOR core we might get a chance to strip it to a
> spi-nor-tiny equivalent. This would reduce code duplication and
> maintenance cost.=20
>=20
> In what concerns the flash IDs array that keeps extending, that can be
> indeed mitigated by implementing just the BFPT (Basic Flash Parameter
> Table) from the SFDP (Serial FLash Discoverable Parameters) table. So for
> SPL we would have a minimal core with a minimal SFDP (just BFPT or parts
> of it) that can handle the basic support for all flashes that define BFPT.
> We won't need to add new flash IDs for flashes where we want just basic
> support.
>=20
> Unfortunately I currently don't work with MTDs so I'm not interested in
> implementing what I'm suggesting.

Those are good suggestions that hopefully someone can pick up and
implement, thanks!

--=20
Tom

--Oaq6rve+jYTAOM1p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZh4oAAKCRAr4qD1Cr/k
CuImAP9bjDuv7WAW8LhBuiy8hTNGdDxG8zu6dAKVhd5hLepdTAD7Bi27QXxLSS5b
5KYlU1wUlVl3dYe8Ics02Vy0tGb0fAg=
=zJYx
-----END PGP SIGNATURE-----

--Oaq6rve+jYTAOM1p--
