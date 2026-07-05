Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D11AC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 20:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D84848D2;
	Sun,  5 Jul 2026 22:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CwKA3m39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9A284942; Sun,  5 Jul 2026 22:26:53 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F56D84857
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so1173968a34.2
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783283210; x=1783888010; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9r8Ea1h4F5YpCK5o8kqWkeguaX53d9wcCuEQ8B9/zgw=;
 b=CwKA3m39JOfEJXL9cqSUJ6HsM00uYfzAGMIreEZ7o50GTmzo+KEuuZ4LH06BQudUXb
 SZ00lA8AzC+onI+Dsx1YKzSVnd6Ljtsd3RHfZDAfw0aH5SytSBzYW0pbK/C6b3iqxCF7
 TsiR8LIwSjb/uW5t99SdEpPcKo+fqTcF5BoQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783283210; x=1783888010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9r8Ea1h4F5YpCK5o8kqWkeguaX53d9wcCuEQ8B9/zgw=;
 b=mWUm9Y6k9P9XQabcEy24GhOeJ3rfRkjR44eQKCgfOPP3lZ81Agd3TqaspfFluhDhGA
 C1CV+DHAsBTGnRDdtyCBe1KB3SJBSKpGokGi531Rw2NIqV+P0N3/9xVb2LDtKx6sXQYD
 gW84AJ1yyBFLpV5WydObv6OxHR/Y3vVynR/BQibnNV6lCAuI6+WmUx5LoFxFfh4KuEps
 hBOrfescsz7umywc2MWZrMMieAlBhV0MDwDwWvWbtecjk2VE3TBxdrLeksxOCaJOpqvV
 KIWbuS0PxfE4DSDqW3aIm2/Fbcrnkt4gw/UwRf6Fi7L+qd5z9jIe81YiDn6bjjQ/Kzlc
 cDFw==
X-Gm-Message-State: AOJu0Yz6VKZmnVmgWeKVRcpkrCTp71N8lx1y5xuwYLfd79f5Ar23k4mE
 z1zkPPBmWRXpwOSBO9m0bP7bSKcFSHSZQqkOYDZEV78Ijw0Dkaw85zke4+nD4ATyW8w=
X-Gm-Gg: AfdE7cn1nLG6VWC+wmYxZHTE+2MMSkuFMmjIIhv9cwsJAtslOodY/2RDj/8vHXipXt7
 1IE+x5JNPV9VPWWvF1y7ECOqltXBUyFRCpcZvadQjPstCg2eF/TJlMFhOlnd1syBg8R1ZNrKmu6
 IeM/sewQhe3t/8UzxakJ7DpzGDkNxlzbGbhC36cS+THlt1f/JjyfMcTUkhmjz7qGtOfrkdjfCne
 Ef9R8RWgUpcz9R0Q1EHLw1p6H5S6y5yrAsY1KAB11uSSwf4yo0DcLxIuCkmH5y3D3B/GON9pwfg
 UxtENSJNitH/rl5Q+WsdUqN6yEBnnBDVwtTPSe62yarBCEBXukXxbu5h6ZTWvPxtSbLSv7Plx9K
 WOix2JvuFu2yxJXwsh0RhjgyqjmPdsdXaS6u8n6DC5N1XuSMCA/grTDFPRFbFEyiCTduihc7hxm
 mfVBGPkdf4WVfsMdE2ViKf7qqjglUb25E/yX16CQA502keX29RVEs1dGlBk0S/6+QifgbJe9bXi
 Ymue5SNc0yPrrQklKl+mgg+PCZCvdxpDg==
X-Received: by 2002:a05:6820:608:b0:6a1:683b:f5e6 with SMTP id
 006d021491bc7-6a32f499c3bmr4026895eaf.30.1783283208751; 
 Sun, 05 Jul 2026 13:26:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb5e257bsm8255313fac.14.2026.07.05.13.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 13:26:48 -0700 (PDT)
Date: Sun, 5 Jul 2026 14:26:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2 03/11] patman: Add a .patman-defaults file for U-Boot
Message-ID: <20260705202646.GR749385@bill-the-cat>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="X13IiRsBamX2n1Y1"
Content-Disposition: inline
In-Reply-To: <20260705193251.2190705-4-sjg@chromium.org>
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


--X13IiRsBamX2n1Y1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 01:32:14PM -0600, Simon Glass wrote:

> patman is now installed from the separate patch-manager package. It reads
> a .patman-defaults file from the tree root as its lowest-priority config,
> so a project can ship defaults that developers still override from their
> own ~/.patman, a local .patman or the command line. This behaviour is new
> in patman version 0.0.20
>=20
> Add one for U-Boot, alongside .b4-config, pinning the patchwork server and
> the get_maintainer.pl invocation so the tool works out of the box without
> depending on patman's built-in defaults. A few other settings are listed,
> commented out, as a starting point.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--X13IiRsBamX2n1Y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakq+BgAKCRAr4qD1Cr/k
CjsjAP47DdSKFLIy2CLQOPZ5V7N1zJ4jkZqFc+TMBu659Ie98wEA/p9u1KKNkn/i
4ju4fPA8tsxahbx+QQcOmrr8pAMUjQs=
=hMCK
-----END PGP SIGNATURE-----

--X13IiRsBamX2n1Y1--
