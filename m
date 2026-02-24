Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A0FBF3C991
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 15:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9780683642;
	Tue, 24 Feb 2026 16:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n0kZwsuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D58883D8A; Tue, 24 Feb 2026 16:40:43 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E9682BF2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 16:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4648448e387so473588b6e.1
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771947640; x=1772552440; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XxlsMWMpUbBiiVc9fIXB3fUZ45rxPZxhgwnIpDzoYBw=;
 b=n0kZwsuDD5NTFuwj6S74iJaAyXGR8eINv6oyd3yAO7Fzy7Px+facJyrgD9mZ9Hech/
 DtMb/eI3xRqSLzHETXQju1NQyyp341bbXcdGzeo7Rth61A8Kg38lYzmqpcNNDOYeNbfo
 /2XxknanNmeL4y/IxqMrQE4MYZjQQpoIRd8ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771947640; x=1772552440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxlsMWMpUbBiiVc9fIXB3fUZ45rxPZxhgwnIpDzoYBw=;
 b=dPYYE0BWlCpNEClJbbKp2OfsUxkJ7e1W2aCpcpK6lFoKOIEzI6V4NisMezA2uCfEZm
 mRjaZOEF0310sBKZd2Q5EkSWjT/d6zMZHGqDN/+7B1LzzGefYnR1K464qT8WLZh81bXJ
 Bgw/Z0rkpDiCLLqp+8UvKMuUSRZj2R9Ud61ud7xiPOI6xbcjauUKun94FPGmKj+tqiKl
 xyVZMLVkiowuEA3yfxoMUPH5T+Q9Nsw168k1OGnck6UBtrgu9ktMbDWDig964DDVjfnG
 IpujW/jOZhw4HBBkLfhQ7m1kfaTrykay3GIDxPslAeQYxbAkNrKaJtp5voSei4I8/G8G
 SCEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDDZ7DBdhncwdBSmaFE9mROuNvPC3g9UIa1sXsS4hUpeeXHpLx0XiiI/p3m11MR3J8jKd7Ok8=@lists.denx.de
X-Gm-Message-State: AOJu0YwAbR6T783sejcRPCZ+0X8TFR8yKpHWLSgR/Lo3zTzEJGObInch
 p8cAITwry8LfoEzlsrhFJXZB7+2Ntm+LOyYmVS3nUHWY3vF422UPNTv5CBAAeXpFD+s=
X-Gm-Gg: AZuq6aLi73I/IsfoJ8xvXf7AsY6NYAagvUyrXMKZFx3V2OoGY4XWFtmD9btqKnzyXoR
 L0kP2J7a9zdDdiB6La73iYG7dbZde8y9gMV91Dh0SU7mwz3XYhq7hE0QEOpU/fwylMTZE3aNGPE
 OSo3qqV22zge+ao5TvYUNn2VOS9B+qiGDn+u8N7qsLxZbZvWRyGBA8VS+7IuMpVcQP7CAJ/OYus
 8d43z14wV4anXO31rp5xDLAZQTeXuGkkn+7aE8nh1W0cDP3MObe//sstKg1rn0d4rKhnQgkoJaz
 Q5H1Nvz3pNT7yOiHb9mSrGIpTyR2zoYr0pJKRnD/Em06QIh5keaFQXYrpYsOAc85fZ3CsfR0D/O
 HXaOC85vulqwXlYoOTrGcKQ0Tdz/QvTXPtyftFEpPp8YtvrqF8n9O7YaUapZVPr77qJBy5ww6ky
 Maew8uVjJXRGcqbfkKNvPL4ONIbCsG6YyT5aipbdVEGdjO99hFB2h78LoLspnnwlDmhCVWFxo71
 wSmnaU/lF+xcY4am0n4nEGJaXyb4MlE0QFOEpo8m0EpMs/+MvU=
X-Received: by 2002:a05:6808:4f61:b0:455:8400:f078 with SMTP id
 5614622812f47-46446245852mr6987706b6e.25.1771947639685; 
 Tue, 24 Feb 2026 07:40:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a1aef6csm7242022b6e.15.2026.02.24.07.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 07:40:39 -0800 (PST)
Date: Tue, 24 Feb 2026 09:40:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Takahiro.Kuwano@infineon.com, miquel.raynal@bootlin.com,
 mwalle@kernel.org, conor@kernel.org, u-boot@lists.denx.de,
 Hiroyuki.Saito2@infineon.com, venkatesh.abbarapu@amd.com,
 p-mantena@ti.com, vaishnav.a@ti.com, prasad.kummari@amd.com,
 pratyush@kernel.org, vigneshr@ti.com, marek.vasut+renesas@mailbox.org
Subject: Re: [RFH] SPI and SPI-NOR patch help
Message-ID: <20260224154036.GP3233182@bill-the-cat>
References: <20260213164607.GI2747538@bill-the-cat>
 <20260214-sternness-cling-4259916a8f73@spud>
 <DGG8OA1O1UEL.12RR559TX4XX6@kernel.org>
 <20260216153110.GV2747538@bill-the-cat>
 <87bjhmv20f.fsf@bootlin.com>
 <46b5a69c-f589-4c4e-99e8-6bf0c41be573@linaro.org>
 <90d5d396d2ec4888a4359ca4b2392b8d@infineon.com>
 <4e4d660e-b9a1-48ce-aa60-ae63bea6bbde@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7hzDFr1r1hF0+6uJ"
Content-Disposition: inline
In-Reply-To: <4e4d660e-b9a1-48ce-aa60-ae63bea6bbde@linaro.org>
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


--7hzDFr1r1hF0+6uJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 12:23:33PM +0200, Tudor Ambarus wrote:
>=20
>=20
> On 2/24/26 10:39 AM, Takahiro.Kuwano@infineon.com wrote:
> >> Takahiro recently accepted becoming a designated reviewer for SPI NOR
> >> in Linux, and I think his expertise would be highly valuable in U-Boot
> >> as well. Takahiro, if you have the bandwidth, would you be open to
> >> becoming a designated reviewer here too? Or maybe see how things are
> >> going in Linux first? No pressure.
> >>
> > Yes, I'm open to do that.
> >=20
>=20
> Wonderful!

I too am very glad to hear this. Can you please send a patch to update
the MAINTAINER file? Thanks again!

--=20
Tom

--7hzDFr1r1hF0+6uJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ3GcQAKCRAr4qD1Cr/k
CouZAQCXFHHdl5Rhd1oLiZtAnYcT2MXlrNopNKXlw2lKz/X+hQEA86TvJgPH8wiv
7HQTescd20IvnP9stNN/r/NzVUXSLwo=
=mZ2w
-----END PGP SIGNATURE-----

--7hzDFr1r1hF0+6uJ--
