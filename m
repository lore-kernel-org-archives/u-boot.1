Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCDAC531CD
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 20:57:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D31AF83AC5;
	Thu, 19 Feb 2026 21:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M9mQqPFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DD2183CEE; Thu, 19 Feb 2026 21:57:33 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6276283946
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 21:57:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d15b8feca3so1568263a34.3
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 12:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771534650; x=1772139450; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c/np0MJ9hHWFoR8N8J2fH4q1Kp/BfELfiXK7qFpAIZU=;
 b=M9mQqPFvTxiE7vb0ZP8LWqnckceJCqBJ1q1Kcy0zUCWaOfhEJDmjh8e7/tJqOq6kga
 Yv/trsZoeywdo4TOPcXWiF8SVwiuFfkd3SYE4iIs50Zi6XDHttwcXC+aHGHlZTYUpQEb
 GpMKddHlaRYlPvQsMClwfs6jEHYGRJwtyrRhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771534650; x=1772139450;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c/np0MJ9hHWFoR8N8J2fH4q1Kp/BfELfiXK7qFpAIZU=;
 b=kSOZUB2pZJwUwHM79Mbbtf/EY47aaV4kv6PhFZXzJqZBh5vDuLfvrPETjk+3PllrVT
 HwcCrr5FoFwqCeuFZ7REER/zx2FSi7v68jUDh1aP+r5JIYRlYlaInGTT3oA8eZXtfw0e
 OjSDHKbbld8T7b9Xvbsb2YBfnTSgaiBRGhuy/TttWFWAAgzhQDBrhKaX349OgmLACeAN
 NNxQy0MBz5o1wxUIjdDDnAq6Q7gtmXgS1+dewnUIgiZmiz7T+isOqeXKILIRnjkN5TwF
 2Tt0HQE6qoI7g5OVmlrwB5jyLEUeKMGqy01kXb52+0i3vCJoyVHv7wkviUwivPWy+v8f
 g1kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/LMzSs+Fehhn6hDRYCVhT784Ws9FEXmNXGZea/05Hz2WpI7I99AUBvXU061QOvOazssA2JLk=@lists.denx.de
X-Gm-Message-State: AOJu0YxvVUgUK9XqM04QavCs08y3YA1c1QLbamVmvu4hKeVYnBTrYefA
 KRT5B2f7RYa5F8Axz6OkZMDPoRT9jFFPl1BnPLnX2EEYPsvw/K9GRaGptEKZyaxwN2g=
X-Gm-Gg: AZuq6aJ+AWrXhXgMzrJc4KfOD9jc0nGj1BzLteKzL0Wfm/fGenK7WOgyP8Pg1Bwa8yT
 yb1Gf3KoDV1fp0fHFo6hjhCMhijgu3cyz69eml9ZUJS/SvkS5oEf1cQb1C7WheTiQ4j3Z7dsVNr
 8qCczhYCqXsnch2VTqJtgCqLojPFJHDCad9eq3aVdcrKkH0xS+FV3tofJtoyyuKQtsI9UPhvwrU
 dC7ab2H6WP6dx8TMfmr6sgWdR0XRWiXsfxG1b235Mx5guQ2iHKNGGXPHFfu6lf++Jdzpfrgcftp
 OgMhPrhjUtw9U2HAPLOkYW3xA/r6dz/XlqpiakCZFtpT1LfmC+Qs+m2luDTiIMjfxKXTRu+Czc1
 +y9fvAEvvbeZ/tX9T/TRV09tjnuh2i4VO8U2ggIav/PXq7DIqGOMBz7FW0OxI01vKsjetJ1t7Rl
 pgjezHgpaAXCNB69akBZq8bdShttJCP4BMxE6aNIur3Rgd9o0Tz0yMd+84lyEn7JBRRyxWSPqPy
 etzTFq/mCnxi0r2QF09TWSbwkPG2Dynj6G5L6HqVBbi7TOekaI=
X-Received: by 2002:a05:6830:4986:b0:7cf:d1b7:c076 with SMTP id
 46e09a7af769-7d505e392ccmr4746072a34.23.1771534650087; 
 Thu, 19 Feb 2026 12:57:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a77200fbsm21280165a34.27.2026.02.19.12.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 12:57:29 -0800 (PST)
Date: Thu, 19 Feb 2026 14:57:26 -0600
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
Message-ID: <20260219205726.GP3233182@bill-the-cat>
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat>
 <87bjhmv20f.fsf@bootlin.com>
 <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pYfhOsEFBJgUno+D"
Content-Disposition: inline
In-Reply-To: <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
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


--pYfhOsEFBJgUno+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 02:13:24PM +0200, Tudor Ambarus wrote:
> Hi,
>=20
> + Pratush,
> + Vignesh,
> + Marek,
>=20
> On 2/18/26 11:23 AM, Miquel Raynal wrote:
> > Hello Tom,
> >=20
> > On 16/02/2026 at 09:31:10 -06, Tom Rini <trini@konsulko.com> wrote:
> >=20
> >> On Mon, Feb 16, 2026 at 09:21:55AM +0100, Michael Walle wrote:
> >>> On Sat Feb 14, 2026 at 7:58 PM CET, Conor Dooley wrote:
> >>>> On Fri, Feb 13, 2026 at 10:46:07AM -0600, Tom Rini wrote:
> >>>>> Hey all,
> >>>>>
> >>>>> To be blunt, U-Boot needs help with reviewing and maintaining the S=
PI
> >>>>> and SPI-NOR subsystems. We haven't had someone with time to actively
> >>>>> work in this area for some time. I'm going through the outstanding
> >>>>> changes now, but it also seems a common problem is that with respec=
t to
> >>>>> device IDs, most of the new ones also aren't in the upstream Linux
> >>>>> Kernel. Is there some better and generic solution we're missing so =
that
> >>>>> we don't have large and often growing device ID tables? I'd rather =
not
> >>>>> make that problem worse, so I've rejected two of those types of upd=
ates
> >>>>> today and I'm just setting aside a large number of others.
> >>>>
> >>>> Dunno if your timing was cursed on sending this, but Tudor submitted=
 his
> >>>> resignation from spi-nor maintainership in the kernel about 10 mins
> >>>> after.
> >>>> I think Michael Walle might be responsible for what you're talking a=
bout
> >>>> here, with his 773bbe1044973 ("mtd: spi-nor: add generic flash drive=
r"),
> >>>> but idk jack about spi-nor stuff.
> >>>
> >>> Yeah. Nowadays SPI-NOR flashes come with self describing tables,
> >>> which are already supported by u-boot, I think. The only change that
> >>> seems to be missing is the fallback to it if an id isn't found in
> >>> the flashdb. Only thing is, the SFDP doesn't describe all features,
> >>> most prominent example being locking. So if you need that, you'll
> >>> still need to have an entry per flash.
> >>>
> >>> In fact, in linux I'm planning to change to make it probe SFDP first
> >>> and then amend it with the flashdb information (if there is an
> >>> entry).
> >>
> >> Thanks for explaining. So in that U-Boot does have SFDP support, the
> >> first thing is platforms should likely be enabling that instead of just
> >> adding IDs, at least for basic support.
>=20
> Right.
>=20
> SFDP is behind a config, because of size constraints I assume. And then we
> also have a tiny duplicate version of the driver for stricter size
> constraints. Are these size constraints defined somewhere? We need to know
> them in order to choose a direction.=20
>=20
> Also, I'd argue that having the tiny version of the driver was ideal.
> Instead we should have tried to modularize SPI NOR, by SFDP, static
> initialization of flashes, manufacturer drivers.

Some platforms define their overall size constraints, and so we know for
sure a hard limit even in full U-Boot. More platforms do this for SPL,
but not all. So the general answer does end up being that we always care
about if there is a more size-considerate solution with minimal
trade-offs. Especially since we are also in a more minimal overall
space.

--=20
Tom

--pYfhOsEFBJgUno+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZd5KwAKCRAr4qD1Cr/k
Cp/WAP4p53DJF5O1TCDDpAt1dOP+t4MbPDLicM7Sq3MPhitHHgD/epQ9UMZAePWm
JhZ+9hBacJWQQJm/Qzj1GpVsSWGPkAs=
=WO4m
-----END PGP SIGNATURE-----

--pYfhOsEFBJgUno+D--
