Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D27C83F26
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 16:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB6982E52;
	Mon, 28 Jul 2025 18:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YgHdGIQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C21682F00; Mon, 28 Jul 2025 18:53:37 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E43D682E34
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 18:53:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-41b4ebb157dso3107970b6e.0
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753721613; x=1754326413; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gp29TK8E7HMBx00caDMcMGrIUa4xZ+/cHaZ+VpiErPw=;
 b=YgHdGIQ5406B+cCy60PUH30kj9H9fAug9sZU/TE4QPCoN+ymfU7jwjj45Nf+ADeE6J
 RtoVKRDdJy4Pxgs7+HvFDLlRlggazYmPW9LQfQnkVBRNOc6J0xjLIKbz1wClDKlDgW8F
 eOSMQaXkKUxlXh7a+VfaeVoa6BL/zD3iG1QWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753721613; x=1754326413;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gp29TK8E7HMBx00caDMcMGrIUa4xZ+/cHaZ+VpiErPw=;
 b=OiyBIjhnkqBUP7oOi4KgxIlofLCNVNEKzNiGE3wsKR7DYvg10/J0yz/98EirNieIbw
 vwT2FoZnkUMtNzs/HpgsN47/CzgtgUDsjEC2Fj6rsEY0dTe/etU/4sJwlOXsgRZpWI0B
 YAs7bwAV6hET3u3Y+i6RrCg4SPGHI4SnfmeYaxVOM4CZJT8cRsgQ0/fKtSIk588lwrms
 faUHJnwaIvzpHMA8he6zrrxxKRsO2kN/77LF+Sh0Kwi0H5iwJgLSeAgBiYo3gU4X6qJP
 uBW5+E2esH3TvqHZAvnUad3XCu8cnRBSiJYSvkMv7xAMMvAqx0OkQOs9wQ0r+3pbwTHm
 TUfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyJ2GL/pfZCjqQQnaMV8EXOFR6SfhArniJbAiU+ypON0zxYwewi3em28uu3uUT16ZrjM2cVAs=@lists.denx.de
X-Gm-Message-State: AOJu0YxsfSE8XINqVWhVp23wnBk6hICk3CcuvTS02pPeZHSLbC2OaUvW
 YL06f15jzIO3Xp0n6dlcB5HKkqSCOBrnyCd2xz93k/USqLlVNSrDk0bDKsHfS19PXtA=
X-Gm-Gg: ASbGnctXafMZ/+DEbjX304TBfYYKyuclG84xUeTuFRlNyedm9zH6mDEbX1Eh7ZF5vR6
 UoXcj7WBY7SukJfsD5V8kHh+e2zRF2Pz9JTl6vaWjrHc5JrvTRLYOXt9mbBrnuYswCW5E58FhuL
 WmFdV34Nc0qK16CiC+QHPQXfcJYLa5EW+5T4Bo9L8qBP80mC1QqnlwzxA0GtSGzxi9lQupyhlTG
 HxiCMBIxy7uLkxJEnZmIOXioJGHxg2DHD8cV7K2Yt8y56UAjRGGEZDzwgm55La8jWFAt6uESMYp
 Zytho13WD+WZTVumFJEyJOunb3rvqafKMwo/qU4zFeLIpFzoy+u8Se3+TgR4pnQvtQYTcVeUlKx
 rcAC9SXINF/30IqN+rbmlapDprYh8EgwZHFK283nFy5A+V+lWgoUVTbon
X-Google-Smtp-Source: AGHT+IFpTSU+Gf7IAMqsodDPLK1HXhsxP5nx/uPDZFjRDfIGtNDEia8lmPhRf9L8kGiAUNEejImx9w==
X-Received: by 2002:a05:6808:80ca:b0:41f:8e03:6ca9 with SMTP id
 5614622812f47-42bba9d358bmr7085140b6e.36.1753721613417; 
 Mon, 28 Jul 2025 09:53:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42c7b8430dcsm1182117b6e.15.2025.07.28.09.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 09:53:32 -0700 (PDT)
Date: Mon, 28 Jul 2025 10:53:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com,
 bb@ti.com, nm@ti.com, m-chawdhry@ti.com, vaishnav.a@ti.com,
 j-choudhary@ti.com, a-nandan@ti.com, a-dutta@ti.com, anshuld@ti.com,
 jm@ti.com, p-mantena@ti.com, n-francis@ti.com, s-k6@ti.com,
 rogerq@kernel.org, kamlesh@ti.com, a-shenai@ti.com, c-vankar@ti.com,
 kishon@ti.com, dannenberg@ti.com, h-salunke@ti.com,
 u-boot@lists.denx.de, praneeth@ti.com, srk@ti.com
Subject: Re: [PATCH 01/45] configs: am335x_baltos_defconfig: Increase aneg
 timeout to 20000 ms
Message-ID: <20250728165329.GI1807455@bill-the-cat>
References: <20250728145034.225997-1-s-vadapalli@ti.com>
 <20250728145034.225997-2-s-vadapalli@ti.com>
 <a0f6b8ef-ac29-4f53-8d02-c20b1cb0305c@ti.com>
 <9303e5f8-9723-45e4-9ef6-5aef6234bd10@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="twgf1a7y8YUYiRZh"
Content-Disposition: inline
In-Reply-To: <9303e5f8-9723-45e4-9ef6-5aef6234bd10@ti.com>
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


--twgf1a7y8YUYiRZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:36:53AM -0500, Andrew Davis wrote:
> On 7/28/25 10:33 AM, Kumar, Udit wrote:
> >=20
> > On 7/28/2025 8:19 PM, Siddharth Vadapalli wrote:
> > > Increase the PHY Auto-Negotiation timeout to 20,000 ms from the curre=
nt
> > > default of 4,000 ms inherited from "Kconfig" for PHY_ANEG_TIMEOUT.
> > >=20
> > > The motivation for this change is that existing devices will continue
> > > working as-is (timeout is an upper bound and auto-negotiation can be
> > > done earlier), while older Hardware connected to the board that might
> > > occasionally take longer than 4,000 ms for the Auto-Negotiation proce=
ss
> > > will benefit from an increased timeout.
> >=20
> >=20
> > Can we think of using TI_COMMON_OPTION , similar to TI_COMMON_CMD_OPTIO=
NS
> >=20
>=20
> Or simply change the default in Kconfig to something like:
>=20
> default 20000 if ARCH_K3 || ARCH_OMAP2PLUS || ARCH_KEYSTONE
> default 4000
>=20
> Much better than 45 patches updating each board defconfig individually.
>=20
> Side question, if this is right for TI plats, why is it not right for
> all the other platforms? Should this be the new base default timeout?
> I don't really think so in either case, the point of the timeout is to
> switch to a fallback port or boot mode in a reasonable time, not sure
> 20 seconds is reasonable..
>=20
> (you probably don't need ~50 people in the TO/CC on this one either, not
> everyone who has ever touched the defconfigs cares about PHY timeouts)

[trimmed the CC list a bit]

The other part of this to me is, is this even right outside of "we have
a big test board farm" ? And since this is read from the environment now
(yes?) can we instead not just expect big labs to update the
environment? Or no, too many of these will lack persistent environments?

--=20
Tom

--twgf1a7y8YUYiRZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIerBQAKCRAr4qD1Cr/k
CgggAQDfp6E2+LtmyDrlvEaleWpvpvRXn16hBB/+0Hd/4A6bcAD/ShUhqreQcgwT
geJYX/5C0pWQfeST8c799wtvOASfrwM=
=skfT
-----END PGP SIGNATURE-----

--twgf1a7y8YUYiRZh--
