Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C71BC369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 14:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0267829FC;
	Wed,  9 Apr 2025 16:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GPm4C3QV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA06D83710; Wed,  9 Apr 2025 16:15:21 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 613A1829D4
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 16:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2cca475546fso2690069fac.1
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 07:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744208118; x=1744812918; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oW4tPKvcscaSRmIRFzx2+JkzFkJa36ECtoitXap3bZY=;
 b=GPm4C3QV7JDbmLmoH1bGywbl98xluNhoxGj8K999rvjCdtmxqu65ySfbyJzlRKCrNl
 /BhQ8b6I2sQ6BfEv/v2AuMdB3oviPtLbWG/401B/guMjLoH4x1cJmuAGzSypqI33lcqf
 mDFl3c6gdlSdSezGTmv97g/2Al5IF+DkGldEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744208118; x=1744812918;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oW4tPKvcscaSRmIRFzx2+JkzFkJa36ECtoitXap3bZY=;
 b=vSnIMRt+rsos81yAtncDzFyw6U7wx4hbi/3Y1I4lLC5Ujq9538Dko4O45f6g7PzhM2
 0682sqKAtOy+3YXG/CVdsqp0vORT74bMlnvAf9MTRGts7hbxGbVQ4hQOz0/YJ8yLaXDO
 y8PcL7aRBiUvs/BNmpxJiK8H8KUNujOdBZ9R53xhdX/vxZRKDvJJLPSF2Nrhd25ad1CW
 40w/rCG1dkNUoa3dVHV7p9INNGXsADbEKMRC93ATCJihd3+PLBwszMqWMM/UBtgbKaJO
 y+rffDmukzvlp+rA06lDMZ9VK0W7+XN0yV6Pb+mYzwFYorvtbI3Kco/ESkVTL/hohlLg
 Efig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoPXYhJHNT5Z84WFHIjXON+F/sxfMs2YNDTVwPHKY8k09Xtk/OGA8Skepw3i7e803oTitdECc=@lists.denx.de
X-Gm-Message-State: AOJu0YwM02ikl+p2UoZU9y/TZAQMXrKqNR7Fnob+vSWW2J64Bo5u8zvj
 2oqXY5LU/Cu1rkI8VW1997HxJ3mzUvDngq5CwNDDRCmyey4V7uc0pX01xRr3mlo=
X-Gm-Gg: ASbGncuFgwDxsqzO7x0yizcdeLxukPsBbnprNhihDXJLbOd4mgZeJYTHm1j1q8UxKbt
 CTYHJ35CCahXYGwdzB23sSyqRmaPRxNGEvDpLDDQmvwypcjMJVqqW8RNJreelpfszxf7ssywc+o
 hSofRKXjRzM6H9ESoRmwyGG8VM0DKz/TCd0Qc9YmpR2zDs6pChdcdXkU3+DhLqmue8tBM9w3clF
 0Dp3JY70nAXoxKamS/738wiVxFNEEwW3OAo9sU2bySL+B5fO9zmNUPimNQU92eFBs69G/u/IPC2
 JFPjF11HLRpE8qg4HJ56d6AlB8B+OddUAZHPiR45EA0FyfDy59FGUVZCy9jIFKZnW4umspQNcO8
 LtQG5dteaouD3
X-Google-Smtp-Source: AGHT+IGgVEWrenip2lVtoJyCrNkeiCDVxxLk07Qe+QPzTr6GutNnLWc4upB09BodLRhvVMsab0zsiQ==
X-Received: by 2002:a05:6871:a98b:b0:29e:1cd8:4a0f with SMTP id
 586e51a60fabf-2d08dded39cmr1700044fac.17.1744208117779; 
 Wed, 09 Apr 2025 07:15:17 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096950929sm233305fac.13.2025.04.09.07.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 07:15:17 -0700 (PDT)
Date: Wed, 9 Apr 2025 08:15:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 05/18] net/net: fix switch/case fallthrough annotations
Message-ID: <20250409141514.GC5495@bill-the-cat>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-6-andre.przywara@arm.com>
 <20250408222918.GA1475540@bill-the-cat>
 <20250409005347.04003b4b@minigeek.lan>
 <20250409014646.GB5495@bill-the-cat>
 <20250409114137.181e39d5@donnerap.manchester.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6FHprQOm6uRkiLHs"
Content-Disposition: inline
In-Reply-To: <20250409114137.181e39d5@donnerap.manchester.arm.com>
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


--6FHprQOm6uRkiLHs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 11:41:37AM +0100, Andre Przywara wrote:
> On Tue, 8 Apr 2025 19:46:46 -0600
> Tom Rini <trini@konsulko.com> wrote:
>=20
> Hi Tom,
>=20
> > On Wed, Apr 09, 2025 at 12:53:47AM +0100, Andre Przywara wrote:
> > > On Tue, 8 Apr 2025 16:29:18 -0600
> > > Tom Rini <trini@konsulko.com> wrote:
> > >=20
> > > Hi Tom,
> > >=20
> > > thanks for staying on this!
> > >  =20
> > > > On Thu, Mar 27, 2025 at 03:33:00PM +0000, Andre Przywara wrote:
> > > >  =20
> > > > > The net_check_prereq() routine in the generic network handling co=
de
> > > > > mixes case: labels with #ifdef's, which makes predicting fallthro=
ugh
> > > > > situations tricky. We had two "fall through" comments in the code=
, but
> > > > > at the wrong places.
> > > > >=20
> > > > > Remove one unneeded comment (no annotations necessary between jus=
t empty
> > > > > labels), and move one other instance to the right place (before a=
ny
> > > > > label sequence).
> > > > > This makes GCC's implicit fallthrough checker happy.
> > > > >=20
> > > > > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > > > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > >  net/net.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/net/net.c b/net/net.c
> > > > > index 5219367e391..f191f16357c 100644
> > > > > --- a/net/net.c
> > > > > +++ b/net/net.c
> > > > > @@ -1525,7 +1525,6 @@ static int net_check_prereq(enum proto_t pr=
otocol)
> > > > >  #if defined(CONFIG_CMD_NFS)
> > > > >  	case NFS:
> > > > >  #endif
> > > > > -		/* Fall through */
> > > > >  	case TFTPGET:
> > > > >  	case TFTPPUT:
> > > > >  		if (IS_ENABLED(CONFIG_IPV6) && use_ip6) {
> > > > > @@ -1539,11 +1538,11 @@ static int net_check_prereq(enum proto_t =
protocol)
> > > > >  			puts("*** ERROR: `serverip' not set\n");
> > > > >  			return 1;
> > > > >  		}
> > > > > +		fallthrough;
> > > > >  #if	defined(CONFIG_CMD_PING) || \
> > > > >  	defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > > > >  common:
> > > > >  #endif
> > > > > -		/* Fall through */
> > > > > =20
> > > > >  	case NETCONS:
> > > > >  	case FASTBOOT_UDP:   =20
> > > >=20
> > > > So this one is harder than it looks. With clang, we cannot seemingly
> > > > have:
> > > > 	fallthrough;
> > > > #if defined(CONFIG_CMD_PING) || \
> > > >     defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > > > common:
> > > > #endif
> > > >=20
> > > > And gcc was failing on:
> > > > 	}
> > > > #if defined(CONFIG_CMD_PING) || \
> > > >     defined(CONFIG_CMD_DNS) || defined(CONFIG_PROT_UDP)
> > > > common:
> > > > #endif
> > > > 	fallthrough; =20
> > >=20
> > > Yes, later stages of the CI told me so already ;-)
> > >  =20
> > > > Maybe we can move the label to inside the next set of cases, and th=
en
> > > > also add CONFIG_CMD_PING6 to the checks, as that also has 'goto com=
mon;' =20
> > >=20
> > > I found some other solution: dropping the #if's around the common:
> > > label, then marking this with __maybe_unused instead. Seems to work f=
or
> > > both GCC and clang, and makes the code even more readable.
> > >=20
> > > Will send this among the other gazillion fixes I meanwhile added in a
> > > v2, to a mailbox near you.
> > > If you can't wait: sunxi/fallthrough has the bits, though not yet spl=
it
> > > up and without commit messages. Still not passing all checks, but the
> > > CI builds seem to stop early, before revealing all issues, so this is=
 a
> > > piecemeal job :-( =20
> >=20
> > I thought I had tried what you suggest but maybe didn't quite get things
> > aligned right (but I also modified sandbox so it would trigger the
> > unused warning). That said, I'm applying most of v1 now'ish, and have
> > only stopped as part of trying to narrow down the seemingly random
> > evb-ast2600 CI failure.
>=20
> Can you hold back with this patch here for now? I will send my new version
> of this one later, which passes more CI. I didn't find more overlaps
> between this and my new series, so I wonder if you could apply what you
> think is ready from this one (definitely minus this patch, but maybe
> others), and then I send another series with new fixes plus what's left
> from this one. This would avoid me sending a v2 of this just because of
> this one patch.

I'm planning on applying everything except this one, and 18/18
currently, so that works yes?

--=20
Tom

--6FHprQOm6uRkiLHs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf2gO4ACgkQFHw5/5Y0
tywMAgwAgJqbVTKbl0Go1f0AhhWWpASOPZXqWlJ3Lt4PrBkWtPu/KsLaGlS+SfLj
D5bd0p0/DH3G5U1zuUJz5j6b1DDKgLMRXZGsorwTS8FINWAjUg9zAmjxzJcvG6Bj
TI8HEKcNVHLg5c5BE0/PXeUxCzXw0AwdDSzrrYzhHa2md8eXh7GTioWDB33wQgIc
iIBek3lOI5ZplKyYlufe7iUsfpfbgXSkkex8/CKFViV50UTivTXDr+5cp9E+u+dg
zUOLnTGv/V5EGmXFgFLIWnwP5QVnhGtYjo0YO4inrTYTST9/LS6iu7cgyNDjoNNF
VAuqYJ87Ew+zLL5OPd/qN5W+nai95cpqX939mpXRBrqTZHQwgm0+bRy6zE654xMX
OB1h3PiNTPFfaSAotHerUFUgrp2sDyK4L0vrmZa+LNdCN5aikiSdZtkIG4tNDKaA
o/muI02sDhqZSaDEdYRCXwZ7iO4vyso9MA/AcSz1ChZnYz+fgELZLVANSYWUlV98
6qdjr7fG
=NCBj
-----END PGP SIGNATURE-----

--6FHprQOm6uRkiLHs--
