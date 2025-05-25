Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AF8C54F30
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 23:02:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1A7D82B31;
	Mon, 26 May 2025 01:02:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NI/altTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8878282B37; Mon, 26 May 2025 01:02:08 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D19182B19
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 01:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-2d4f8c42f49so1459877fac.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 16:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748214125; x=1748818925; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xseIWdahJF2J6SBdk7+Bf5Chd0iWv9/o0f/1QPGrd74=;
 b=NI/altThzsJt5YHnLx6P6GBzl666HF2ws2+CnRC4JDaWuEHjYfR3TwTTXG864Yazp+
 CnF0yTdt5O91hL2Rr3zrZxjzrfLfoVy3nWi9PxpNI+ve8+lM2hPMSmGG/dONOKjrXi4R
 YNa+tveFveyQ141l2Zt1gNRpw1VPNiTcHmor8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748214125; x=1748818925;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xseIWdahJF2J6SBdk7+Bf5Chd0iWv9/o0f/1QPGrd74=;
 b=vz2pIp1DEYT+KE+D1oZICi1ZCqOR29Go4wmmCu7IzXooOlxTo7cEQVZjNeFNo5yetH
 muN8wpOxx+lgG7thNoxBUH0QEHdDHPfe+2Q/KDqsijMc2OVFEnojTZVem0dTiFSb5gSj
 HQxK904TmKH+IPcSwRdiP6WVJZeln+bHkO4xVqU+OGauK0VcKtwd04Anb/kqX0njeyei
 1egS6OQ0FuQV6zNceIzsMGoKo5cirll852k432en6TtY+74c4vrdM1/C7HMbkawyIsXf
 xxTKf5vC9mH+7SZC51LL8UivQtQ/gI/G+t87+bZf45kNaezqb6f74NBB6l7POZFdVgU6
 AfiA==
X-Gm-Message-State: AOJu0YwqxbOdpv+iW7H0bF964ajeKdhzt5y2evq/bX5hbPxV5RO8+KOz
 j5TVnkfnh3ItxHNYeelZ8nIxO7IqwvGejGmpA7OqC42bfrU1VCeg7WcqZzVVdb3N3ws=
X-Gm-Gg: ASbGncvL190TlWwtojmq0DjSj69mrWyCgzzB/agj9ardgRjuvPjK4rLEaTS+yq12KiN
 tViWsTAGZqclIsihBaqDMGKDvsZU5Qx9phbPHrOZJ0nJLayhp5gXSQVNrzyvw4bct4qbWDtnW+n
 CxqhqrX1FFbCGXfBh4pg9B9UVh/1xqVvh3uyXLh09u10lDceb42xzqon76hLzmWZwH2ByXbvTOZ
 EZ+GK1vdHSnR1+P8F0ZN/fwuRkfVIdaN1sCdHTYXpr+p84xJir8k53tn2RwC70TevY69CHOkgEN
 RryiJQ1nHq7lYFAtKjtMzHJBlwEmgadiml68eG76vcl3a1OKEL2Q7PaMR+apRvGGddfNTaGucjG
 LVBzKA/MYPMqXi3JeA7vXSgQ=
X-Google-Smtp-Source: AGHT+IEaJsbq0iwsEX9Oyau5PZASjrLOKfar3Z2S+ZoqoTx11vivKnr8Sz+kO7Tc+9wybruSoVDLpA==
X-Received: by 2002:a05:6870:e994:b0:2b8:b76f:1196 with SMTP id
 586e51a60fabf-2e860b8762amr3637122fac.19.1748214124733; 
 Sun, 25 May 2025 16:02:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0aa15f5sm4629751fac.39.2025.05.25.16.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 16:02:03 -0700 (PDT)
Date: Sun, 25 May 2025 17:02:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: Re: [PATCH 0/4] list.h/treewide: get rid of no-op prefetch()
Message-ID: <20250525230201.GS100073@bill-the-cat>
References: <20250507121246.518691-1-ravi@prevas.dk>
 <20250522165656.GB2179216@bill-the-cat> <87r00c3143.fsf@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="h5jPE2NKhDzN2p8W"
Content-Disposition: inline
In-Reply-To: <87r00c3143.fsf@prevas.dk>
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


--h5jPE2NKhDzN2p8W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 10:07:56PM +0200, Rasmus Villemoes wrote:
> On Thu, May 22 2025, Tom Rini <trini@konsulko.com> wrote:
>=20
> > On Wed, May 07, 2025 at 02:12:42PM +0200, Rasmus Villemoes wrote:
> >
> >> While looking through list.h, I saw that the regular list_* helpers
> >> (and one of the hlist_* ones) still contain the prefetch() that was
> >> removed in linux 14 years ago. It doesn't do anything, but makes the
> >> macros harder to read, so get rid of it, and the fallback, no-op
> >> definition that they relied on. That requires removing a few uses
> >> outside list.h as well.
> >>=20
> >> checkpatch warns about some whitespace issues in list.h, but as I've
> >> copied whole kerneldoc+#define blocks directly from the linux kernel,
> >> I think it's better to just accept that so that we don't introduce
> >> needless diffs. The "macro argument reuse" arguments should also be
> >> ignored, as e.g. the "member" arguments are obviously always just bare
> >> identifiers, and the "pos" arguments must be assigned to multiple
> >> times.
> >>=20
> >> Rasmus Villemoes (4):
> >>   linux/list.h: drop use of prefetch()
> >>   treewide: drop no-op prefetch() calls
> >>   mips: drop unused prefetch code and logic
> >>   linux/list.h: drop fallback definition of prefetch()
> >>=20
> >>  arch/mips/include/asm/processor.h |  16 -----
> >>  drivers/net/mvpp2.c               |   1 -
> >>  drivers/net/octeontx/nicvf_main.c |   2 -
> >>  drivers/usb/gadget/at91_udc.c     |   1 -
> >>  drivers/usb/musb-new/musb_core.c  |   2 -
> >>  include/linux/list.h              | 104 +++++++++++++++++-------------
> >>  6 files changed, 59 insertions(+), 67 deletions(-)
> >
> > Unfortunately this leads to build problems on lots of platforms:
> > https://source.denx.de/u-boot/u-boot/-/jobs/1141951
>=20
> :( so we've been relying on that prefetch() laundering away the
> volatile.
>=20
> Which really begs the question: Why, exactly, is it that gd even has
> that volatile qualifier in the first place?=20

The answer is likely early 2000s GCC.

> I'm 98% certain that we could drop that and get better code generation
> and avoid a ton of places where we cast away that volatile which
> shouldn't really be there anyway.

It would be a good thing to experiment with now and maybe try for real
in a near-future merge window.

--=20
Tom

--h5jPE2NKhDzN2p8W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgzoWkACgkQFHw5/5Y0
tyxyPgv8CmU/dbHwFTpg7kSaWav/8PGtwakZw+YiVeezC2clGm+D1WU3XPTTwcle
wYEvkVle2VJ6lbmeDBQ2iPlsZQi6WfqLD3DDL4kRPPewisKqDrBoj9QLZyFj3Bqb
i4D2P0hKMTR2kRz/1kxerxKdJkNpyC3+B5rREHawQG6OhUuCfPhX2NR4AQd8CFz5
PgsZG5TecYzVqhbjMrUwgAOqgatRcx8gdl3okwlSUQTlehBb/QHlCVRvwxrrRWhg
xM6qUDrDp6kQyQnWKZ+1wsjSb4ZBy33HlnCQvGbusyV6GPFPoQ2JK85klP7o5zMl
7N5P+/3WX9UeYOseEoPFCj/I9m3SzOu/C0DSFtYCvH/vUSFWmOCLQYPUpjVpp9fy
FUNOY/yTZ3OO6LW39I/+XTQNl4NvMuTROHo7Lwld3yRJK5SdvPQe2W12sCGgGE9M
lBGfFrX3ZTZKKic7TfMntsE9+JQ09iUGoiOAIVOBFnUdQwwNS/Bq758pPWvYM1kB
ppVBSzJF
=UVys
-----END PGP SIGNATURE-----

--h5jPE2NKhDzN2p8W--
