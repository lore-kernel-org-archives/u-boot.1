Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EA3C021B6
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 23:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DDEA80FA4;
	Tue, 25 Feb 2025 00:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kJUxGbd3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 366E980FA6; Tue, 25 Feb 2025 00:23:12 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A89E80F7B
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220e83d65e5so94847915ad.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 15:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740439387; x=1741044187; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vORhxi1lOBDrkMMVGX2y/eOpRRM/22C6f6z3d/tdZNA=;
 b=kJUxGbd3TO6QA4NOyIwriEHzL1bp9RqJ8UwqZVLoTf5tMkaYkxWzM7mcK3eTRifwh7
 C6revU/eejQ+t08x8ZvfclkRYujhnvMzWiPHyD6B5ZLuMpmXQzwMWpb0UVdIimBsY5If
 wtlM7Qt704em752TSWxC4YF/uRbEZP3ne8DI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740439387; x=1741044187;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vORhxi1lOBDrkMMVGX2y/eOpRRM/22C6f6z3d/tdZNA=;
 b=GObkyeAN5t5bHKLn8fit3Xf1ppRFkeOxXTHh4Cih9tk4OdTX7PlS1gfN/W6rzHJ7t1
 qnC6AnSRmTiC/sPXHSNnhXwvDpR39G5LFJqAtuNuq2IZ/6vT0CKw8qmiXTV+qqnd9TGb
 ZcpIw4lzNQYjQdC+nMm6QJuHDSs+kJ3Zso/SkwOpBZb1lfPG/aMereWBEDMGbcPf9ban
 tUQXVJQf2drtgQWYWoUas01BJxR7zSvElFSl0h1i6pRLswPNn9/MvwLtPdpyNclNPfGG
 /JLGHQ/ZK2vAWrrY0wOxe9xpY6Gl7WdGBIxQ2KseKgvdSgExGZVKvAYbR6bx9LzLc8WW
 zGUg==
X-Gm-Message-State: AOJu0YzoHbqqDA1eny3/zW6S2oQZXf+MmhSIhgkdCosy/MK4e1s/AbA6
 WAWdmc7OiMpklREJOH33IR2dwomaSsFKfeL6NC84GvqjNBzkXeGVzmwnFbmd/8i4OjX148LJjIx
 X
X-Gm-Gg: ASbGncvbtX6tv9RK9rIy3xb3UEJEANFXg0UraRsqQZel0T9AfB+Tp4WzGTxk/keO/LN
 5FPdk3mzBKUk/hAGW6so2oi53PGFmkITFfCJM0c0GdavftqyiYg36jmKTXizE1Fissv6wNGUTtQ
 ieYLkUueUnsSaJKlcouvAM/jQg0Sb6dns/r0RCRJ/5Pjtb1iJ1OqwbUaerR5lamcHLemfSgUkqb
 ddatJwQlKLqdZm2Bge8p0TwXY5RGAl7Kho45v2bG6hbmIw+flH/gUMqo1GBZPnUam+jSBswrHr7
 6DI1ttLYfrxoNpJetD9iBmV7
X-Google-Smtp-Source: AGHT+IH/2FJz9cGZPYuR/Ob8+qs3VemDYz0CUgB+68b+8xF5les2C2S7nqNgfmkaREVq/e1Z/Kusrg==
X-Received: by 2002:a05:6a21:9006:b0:1f0:ee68:ec37 with SMTP id
 adf61e73a8af0-1f0ee68ec7amr7618535637.27.1740439386883; 
 Mon, 24 Feb 2025 15:23:06 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7347a6abb0dsm204760b3a.11.2025.02.24.15.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 15:23:06 -0800 (PST)
Date: Mon, 24 Feb 2025 17:23:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
Subject: Re: Rate of change in the project (Was: Re: xPL Proposal)
Message-ID: <20250224232303.GJ1233568@bill-the-cat>
References: <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <CAFLszTh=oq3z4P_tAKYETHE40yfHQOH1XHeKqmhQEAQ=PL1HUw@mail.gmail.com>
 <20250221175320.GN1233568@bill-the-cat>
 <20250221181055.GO1233568@bill-the-cat>
 <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vJ5tqb07MLqfzx74"
Content-Disposition: inline
In-Reply-To: <CAFLszTgnj+ZFq1vEcSSKCOeYjx0NKesO8Lo3aOJ2Nm-jhuTvig@mail.gmail.com>
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


--vJ5tqb07MLqfzx74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 05:00:59PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> (I think you chopped off too much context, so I've added it below)

That's fine. But I omitted it because it's also true for any other DM
migration, and bootstd more fully and adding more classes of devices for
bootmeths and I honestly think you have a half dozen big things that are
in various states of being merged and enabled and perhaps even more that
didn't get much past sandbox being enabled.

>=20
> On Fri, 21 Feb 2025 at 11:11, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Feb 21, 2025 at 11:53:20AM -0600, Tom Rini wrote:
> > > On Fri, Feb 21, 2025 at 08:03:12AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > [snip]
>=20
> [unsnip]
> > > > > >
> > > > > > Sure, but we can't even get sunxi bootstd or LED over the line.=
 How do
> > > > > > you imagine we could retire the legacy image?
> > > > >
> > > > > Partly by focusing on one thing and not 5 things at a time. boots=
td is
> > > > > stuck on reworking efi bootmanager integration, and LED is waitin=
g for
> > > > > someone to confirm that really, finally, we have all of the old u=
se
> > > > > cases supported in the new code.
> > > > >
> > > > > But more importantly, do we really have anyone not using u-boot.i=
mg? I
> > > > > don't know.
> [unsnip end]
>=20
> > > > If we did one of these sorts of things at a time, we would only get
> > > > 2-3 things done each year!
> > >
> > > A project with 4 yearly releases finishing two 2-3 big changes a year
> > > sounds great to me. Rather than not finishing a dozen things?
> >
> > As this is a huge thread already, I'm splitting this part out.
> >
> > I would seriously frame slowing down and having just one big change
> > being in progress at a time, until it's done, as a good thing, not a bad
> > thing. We're a small community with limited bandwidth.
>=20
> I can't see how that would work.

Well, what we have today is clearly not working well enough for you. And
"just land my changes" is still not an option for mainline.

> I just looked at LED[1] originally sent almost 5 months ago and the
> latest version is marked 'changes requested'. I don't know of any
> changes I can make. Are you hoping that [sorry forgot who it was] will
> get around to digging the only affected device out of his drawer and
> try to get the activity-LED going? It might take a while.

Yes, and as a reminder it's only been 6 or 7 months since mainline had
all of the required functionality, maybe. And what *you* could do to
speed things along is implement the functionality on any of the boards
at your disposal. Anything with a LED today would be fine for this.

> The sunxi one[2] was sent over 6 months ago and the latest version is
> also marked 'changes requested'. You could apply that series with
> either the bootmgr revert or the patch that drops bootmgr for sunxi.
> Then Heinrich can come along with his patch on top of that.

The sunxi one is blocked because it needs to be rebased on top of the
fix I did for BLK stuff and then yes you also could have done the
"bootstd uses bootmanager" idea that you've both agreed is a step in the
right direction. Because it's actually a generic issue with bootmgr +
bootstd that only became more evident as more platforms moved
towards using it. Which is why I had spent so much time trying to get
you to migrate more SoCs to bootstd because it's your feature.

So yes, I think things would be in a better place if we tried to get
*less* big things done at once and didn't pick up another big thing
until the last was really done.

--=20
Tom

--vJ5tqb07MLqfzx74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme8/1cACgkQFHw5/5Y0
tywx1Qv7B6V3RMmleXwy/pava5rwA5l3pYTDG0V13lVC6CKDmzjGAGFbbcFwznCF
3qE+cmNGSZRoL71ApQCFpONpqzKPljftjbAcMzHllKzhWQb//rC8XAN5qNvYu8EC
01GdXO0S/B4b7uTg2QQDyEk4kiIR7Ne8zX4vi2PLvnpTka6eYObGsp4J6YpEAkGx
FYT4cQv/NrB+gk5Ry7riiljdhA41azvHwk3HkfRHRa/r2NVtC1f7TODcpYLZiA5p
Ioi1TQdPMsDi1Zq/dK4H4F4ecKSyKJPHCV0VRe5GPC8Ga6n/JUsjRdrb90BgG0D3
eOx9qmIKEDKEYR3Vz3yFB7s0gvfza+znpEo5o3lQRGRu+YNyY9dOQ9OKlCTup2sS
sGCKWKTuZJC0QBylqO3FECR88OOhEH2//VVLHgbHGsKFVcTQKdD7dUmntXTNqlMP
zXfXoGKnLPXPo3XSNcYk71aDrnzulf7wGGUKkQWg5gWynojZnbKGbYVIKKeJx9Nd
vU1EVdTx
=Ycdn
-----END PGP SIGNATURE-----

--vJ5tqb07MLqfzx74--
