Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FF4C5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 15:36:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CA5A829E7;
	Sun,  1 Jun 2025 17:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TDDv4o5G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F84C829F5; Sun,  1 Jun 2025 17:36:12 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FC082103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-406e31162c6so501610b6e.2
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 08:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748792168; x=1749396968; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zi4PjQiN2Q1j8oinT56t0bC9gga0a5QzGKGAEv1WtvQ=;
 b=TDDv4o5GA59bFmUpEzmPsiAmsC+ezE0apX+AvM+sd+R2cM0FeOB8a6WPak5xE5s+gx
 1J+XIM701a3P0OM30J3oOAi2o8wu3joDLK3LrNMWye7cM5wPBGNy+jsFqxft60QS4Xy5
 EyHkKXJRqb/U57WqMbSGL2PviwW/meqT89qPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748792168; x=1749396968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zi4PjQiN2Q1j8oinT56t0bC9gga0a5QzGKGAEv1WtvQ=;
 b=i6/zqWuofzkH7ldJ9XqkkSRFoz6XmeUbpLxnOY5iENhmft0032LOsMkKgH0B9t73HW
 dL7EPZt2XDA2ZOnMNm+GwySaonc5hVfKYllbQE/xBbw+3LEp4yG/YMg9lc5NTIComz5Z
 Beyc5pkQA6/HxDD+iTzc431ZIYvpNKTAJyG04wRNx6jlDph/cZLnRvDf9irs2hseKRNE
 jYaXllpDpLlNqZ5NJQPzelemjcxcYSBheMyrlv3MsdK4SoZuz01qnLdFZ0oIVGDWYm0/
 OOOC5t14Ji5iUrOIoMaOJqjGOJCESgGofM0De9KjXstsYF7lgrEk1vpVfspgDiEZpaOX
 oGgg==
X-Gm-Message-State: AOJu0Ywn9HmniQpAKm075ChCdQHPs62DjiLkSGxy1riRGlHZHelyoLm6
 efwc7srbQQ5VP0ZiyVkjuNb2e0fRsot0rTykX59hkD7ltDmj+Y7aQyBSU6KGBfWOjrtuOETfbyK
 L1Sgq8oU=
X-Gm-Gg: ASbGncviDnvIOhOGwzfZO5tYPwY7BYdmOCsThEPssFBRUdkjb7729cED6PUvg91y8MM
 Sf+8pY56Hx9AeDU+FtYeGbAMRebZLc9+g4yj4WuKFmcsgRFCesk7yvSRcYf74qFAQR2gb9pvuUc
 Un72NAqoqxU4sZWLcqxCv/xVmH+AFGWFpN/TRxBzLNxsYY6n1e3BEaW4V1HiyvBLOsgdSuZbmvB
 6d07UNfmNytZ9/YwPrNjAtfvLtlxaePrEWYEci7BiimLlNmOcV0g48z0sY3vO45qQTybyofEBgF
 QIdV2eX+hJWCkFnRn8D5uWS6LcOO0sJ0MKI/pdDw29rIv25RdrT179FU5PXXt54CXFf132y03Dj
 v9otzFgogN+jW
X-Google-Smtp-Source: AGHT+IGmJc1TbVD0CLV+I/qEdTMhhFV82hHzEknh1Sg0uKKg7zJ14cgvcVg29QLUnHCxXQPmdw1HYA==
X-Received: by 2002:a05:6808:3c45:b0:3f9:2fdc:ee93 with SMTP id
 5614622812f47-4067971295dmr6684591b6e.30.1748792168436; 
 Sun, 01 Jun 2025 08:36:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c8aeb8sm1130491eaf.18.2025.06.01.08.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:36:07 -0700 (PDT)
Date: Sun, 1 Jun 2025 09:36:05 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: Determining Simon Glass's future in the U-Boot project
Message-ID: <20250601153605.GV100073@bill-the-cat>
References: <20250528175901.GG100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i6BKd2jTdBWjst/l"
Content-Disposition: inline
In-Reply-To: <20250528175901.GG100073@bill-the-cat>
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


--i6BKd2jTdBWjst/l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 11:59:01AM -0600, Tom Rini wrote:

> Hey all,
>=20
> First, I am not happy to be writing this email. But at this point, I
> feel I have no other choice, for the good of the overall project and
> community.
>=20
> Back in January[0] of this year I made a post with almost this same
> subject line. At that point there had already been a number of problems
> working with Simon and the overall community. I did not include a list
> of links. At that point the easiest answer would be to go to the mailing
> list archive, pick any thread that Simon and I had and see the long
> disagreements. This trend has fundamentally not changed. And while I
> started this out with some threads and my summaries of them, instead I
> want to point to this email I sent this mornig:
> https://lore.kernel.org/u-boot/20250528170533.GE100073@bill-the-cat/
>=20
> And to repeat what I said there, Simon needs to decide if it's more
> important to work with the community or have his way every time. Simon
> cannot have both. Simon needs to accept that some things he think are
> good ideas have been rejected or he needs to fork off from U-Boot. Or he
> can ask the community to take over as the project head. If the community
> wants Simon to run things, I will step down and just be an individual
> contributor again. Five months of this experiment shows me that it's not
> working at all and will only be a bigger problem as time goes on.
>=20
> And, I mean it. I cannot take the additional stress of what new problems
> await me every morning. I do not take the above lightly, but I do not
> think the project can become healthy moving forward without some
> resolution here and quickly. While I won't claim my time as the head of
> the project has been perfect, I have tried my best to always be honest
> and fair and to seek compromise.
>=20
> With respect to voting, would anyone volunteer to run a poll from
> https://civs1.civs.us/ (which is used by the Yocto Project /
> OpenEmbedded and likely other FOSS projects/communities) ?

I've since had emails with Simon and while he said he will send
something in public himself, for now he's going to take a break from the
project. I believe that as a community we need to figure out some things
as a follow-up here, but that belongs in its own thread which I will do
probably on Monday. Thanks for your understanding everyone.

--=20
Tom

--i6BKd2jTdBWjst/l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg8c2EACgkQFHw5/5Y0
tyw60gwAkYH4UI2R1rPiHO4vIdaRzVBL10UGbWXeimbv9FqVzekq/QwEDxFya71V
YkUW95akKklMcefn74hdYvwrlg/OIAgQYjAUKEgSA3wuhoVOZ7e+N7W93esyJAEo
7sC7TYRjwUB79G62UnzJE1LlnSv4f60hbsihJU1b90mRA9if9hlWiIetaaBcZxWt
JSj4AcxGAUpp80kxJMxtH/6rU1ndSiluQF0IzOVTbPLG1s8NQCWoFJRd2UvRvHuh
/F+wQl+KNFabhpcnUIUA4bo4AIRyR14iaWKsaKSd2Y9QzmswB2CaygwTWKI4Es/O
1bzImENUEeTLIecrO+5eraIhYlwo/r/X3EHuayg/3F1RS8pNXzsqZIRO9SeMFOkj
0EPRE/bZoq5JCqn0hTC253Vq9Gnmh6cM0Dlq/mllbHSzBsd/tuaw94W6WByicpPb
YxePJBeqkBHpq2m+u6lRY29Chl4WRVgZ6N4kaOMPf6gKyKKry1E+YKOPsc+MkkD1
0W1kSSLS
=VEGM
-----END PGP SIGNATURE-----

--i6BKd2jTdBWjst/l--
