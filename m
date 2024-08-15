Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF983C3DA7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:37:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3133688B5D;
	Thu, 15 Aug 2024 22:34:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bP6ptn9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3713A88107; Thu, 15 Aug 2024 22:34:19 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA5B88C6E
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-26ff51294c4so973879fac.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723754050; x=1724358850; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NrqltztDphO4vMDOtnpUHFtKNjypEEHYF2dzG/fGCm8=;
 b=bP6ptn9h4BZihBAecbtO4qc12/vPfy13vzZYMH6xxIGBUw0RC/loFuEgwg3OEi/gTA
 O12x8TYHyFlj7VW+bFiohHCZugpQxrFlABoH83QGWruTZQQHCztLHj31PdHg1OKE7q+D
 7hr22dOjc0H8r/h5fyRLifIpgq/UBzytEbly8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754050; x=1724358850;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NrqltztDphO4vMDOtnpUHFtKNjypEEHYF2dzG/fGCm8=;
 b=eYANfy/m+l329JAiMb2lW0pnrLmdjvPHMaQjg0RnxV4/ovmfpiXO2HTupPATETQGqi
 5oaqsJN93FrZ6Un4MrA/KDZ+g7+J7K8Yoj443qs+qmF6F5uxZZwGmeIKN1OT/UiSUiHk
 K6Jps44KIcoyCkaQB09Zhsq09WRdWRu9mPqRUOBbdCWL2PDgEH7F+PuqndCFBzTnA1yn
 qUnx0yfH24v+y9fJwECC76LLE1rtrIPYvP1D/zmiu3e5eOQWqjj8RsOWXbH71vmS6VcH
 CF1vhlmvpxGAcVZ4BzXGxeT+aBEizJChdxX2ChaCrywGCOgVZz5ctqeeJzHomwnWKAHJ
 U4Gw==
X-Gm-Message-State: AOJu0YyOZpNeUtiYvpXVhM8Rvu4BlVGO9D2FusVb8mw8vTAhl3oE4b9H
 0vf+R4eHkEDh5z14HPGYLBGKnESLF18GRbPdMGaciOQ/5/kAkXmmNzWZvN2dWmQ=
X-Google-Smtp-Source: AGHT+IE2YHiEeNy1tX019nu5CMTGgm8ocoJjUmRXIonLn5NJ6Utwv3JkbbuktQKyJDZnf00zF4wO1Q==
X-Received: by 2002:a05:6870:a2d4:b0:260:f50e:923c with SMTP id
 586e51a60fabf-2701c349f44mr749917fac.10.1723754050341; 
 Thu, 15 Aug 2024 13:34:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70ca65c8801sm416814a34.41.2024.08.15.13.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:34:09 -0700 (PDT)
Date: Thu, 15 Aug 2024 14:34:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] defconfig: Add a config for AM335x High Security EVM
 with SPI Boot support
Message-ID: <20240815203407.GV1626301@bill-the-cat>
References: <20240807152659.313103-1-afd@ti.com>
 <172375398885.3490037.11788799387337293392.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YMih+vQLMrbQlOz9"
Content-Disposition: inline
In-Reply-To: <172375398885.3490037.11788799387337293392.b4-ty@konsulko.com>
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


--YMih+vQLMrbQlOz9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 02:33:08PM -0600, Tom Rini wrote:
> On Wed, 07 Aug 2024 10:26:59 -0500, Andrew Davis wrote:
>=20
> > Add a new defconfig file for the AM335x High Security EVM. This config
> > is specific for the case of SPI booting.
> >=20
> >=20
>=20
> Applied to u-boot/next, thanks!

=2E.. master, I meant master here.

--=20
Tom

--YMih+vQLMrbQlOz9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma+Zj8ACgkQFHw5/5Y0
tyy8igv+PDVRTtFrTC0ZlMMgu4x/qQHXkf+X5Z6xLZdsK5RRbFseDBXACOBUVrUw
gudnkEo9FK5ONeYESMw/yZTP+64Dp9OWqSY86jFYiIi1UH7x2h2KI+FGRpaSUxYw
tCQaQn4hseLDgkHNEMKJP95i53hCdcxI4hnhPdoDfX7YgLUj2tQdxoCNDa6Pszpn
mX8TCPZBIP3n5OhX8p6GnLH+uB8HIJh1sDGwkr6VaeFBwdbrs8VxN5+8iCOX1mqT
gsZwAW/61YPfsBjiehhkEHFmbh2Ht3yfv7rFUaI7BsfgWkvvXJJ7PjMrOWRZdNoI
bp644HEZJZJr28wkeK+he7QvkyKacHWBpYr4xilChSCOODpWodlyyI6L9JzM5r3b
LGPFt3Qu8CCJYGjNtfBcmRGvOtoLDxcC2VzQTHtlHrvSEVuyd7RW1n896+gaN4Qt
NE89sLatOkJfmLGGS3tkkLJPlWy8V+zzzgDuihOQACBDUE78EGzteD9EGO0plcUf
/hAa+5wl
=lOdn
-----END PGP SIGNATURE-----

--YMih+vQLMrbQlOz9--
