Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B8DC5CFE6
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 16:44:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FE4C83936;
	Sat, 21 Feb 2026 17:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XDU+DobK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20EA983A41; Sat, 21 Feb 2026 17:44:55 +0100 (CET)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BF06801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:44:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-40946982a78so1063167fac.2
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771692291; x=1772297091; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vJq3orPwGc7VYIqYSrv479RtJctWaL8LTsqdOJA4XHg=;
 b=XDU+DobK+oDuPtRsbhliwpCRJ+5NGhuYn4d0RGthL90FF/W7j7K9K3dja2cs/Qh9ST
 dk/TBVv+XiHSXIyubkQW26gHqKWnhOgOdkB8mOGAl472hVF+6HgMAGJvu1c5BkNIZJzk
 Hw06Ysx1Cs6YuQsbukoco6OIWiPLRg1eEEsJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771692291; x=1772297091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJq3orPwGc7VYIqYSrv479RtJctWaL8LTsqdOJA4XHg=;
 b=Ii6XqxuGG9isVovWcMvLE2SWLCWpRGMKvF75SZNs2kdzSPpj9YE0R+PpMje92cpGYc
 pB1Jgxrbglr4dKuORJrpYPD0WlyXO1QsauJmD5A/M/ns5I+Y8dwn+szf+IONE0aaJYqT
 8+QTS9fj5icXlA4nkY1StbQXckSILnuDtO/J4YZIvZpsQQdvcbhG4K45Up6sDKyKZuus
 BCkUOi3CNwCMeTCNSz68z6sQdJwZ/kjoIcYnDa0fK3lED/hX3WDQa2tEku1IBavQppEi
 ktoddeWX0iw5vfLt2+TuGOquQ+6/EM8WE/Xc/XL59BqMzj7GrceAcQHMejERpQEwH+xt
 sAzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxUcmdGB21CEMjjikKhDYNEl/YxyNzTu9H7S1c69T8N1f2kTzWZb0pEziKIJhiSzvMp1lUkGM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw/bjSV8VytYDSbRWgVtkNu3fh6oFKUodxN5KRkiI8rOPQ7EMTl
 vXHdv0N30sccO213liXQvBJiYefJ0SbPoYPdA43X4Z1xHmn88voN49o/G829qDWQ8Yk=
X-Gm-Gg: AZuq6aLEFdgJtLDaFWq1h9tWAAoYwck6WRl6vAsfMN9yc2+mpfhSGevvPip0icWOkdB
 HB2XpNaECwxK+aLfKz2vXmtEiLtgyzAMWcyEd+e4zonhkxHZNPijiW5uhkgr9QyfMM1m7w2gi2j
 sTICoQnKGeMXSay3O1I648FDbG1/QBLaZImk2BmKFzN7MCk3zIGFvvhLwGV9RkDln0RZTRiFBmm
 EO6ixGRcSw7LfP7Shb1EdL+qlSBBeU5xj6d14B6BQ/3s/2g9Ff0qZ7VGaU++H4I+Uit0BZTqgc0
 qJ4oBKNiH32ai2T4SpDa3uAHclSrVP4ZYWUypkVMm+c2e3aJCfrkkr8pQ8dUpg/UQ1OXgRaBzyA
 h5IXNjZNWAT0JWlG2WLNjUb6Z6eaAIrQ+wSdjep3LVzMwoyUePi9GllXCJPYscS6TK9UDifFp3l
 vfOIjfa7Z0LEq5qSiiPOzwnyuOIYj8hKk8f6UjewBChgirigDZKm+G/DUpDYre2Qcf3awB9DlKL
 PLgE0SYdUBPbC4gd7yGvcSr8lAKLz0uyzFLYI/L6hmDT8ut9Ls=
X-Received: by 2002:a05:6820:228a:b0:673:3494:cd12 with SMTP id
 006d021491bc7-679c4693a95mr1794889eaf.22.1771692290912; 
 Sat, 21 Feb 2026 08:44:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679c56dbdc4sm2133303eaf.10.2026.02.21.08.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:44:50 -0800 (PST)
Date: Sat, 21 Feb 2026 10:44:47 -0600
From: Tom Rini <trini@konsulko.com>
To: "Lucien.Jheng" <lucienzx159@gmail.com>
Cc: jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, ericwouds@gmail.com,
 kabel@kernel.org, vladimir.oltean@nxp.com, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/4] dt-bindings: phy: rename transmit-amplitude to
 phy-common-props and add polarity
Message-ID: <20260221164447.GY3233182@bill-the-cat>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
 <20260221163114.87553-2-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BHbpMcd5RbQE0xam"
Content-Disposition: inline
In-Reply-To: <20260221163114.87553-2-lucienzx159@gmail.com>
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


--BHbpMcd5RbQE0xam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 12:31:11AM +0800, Lucien.Jheng wrote:

> Rename transmit-amplitude.yaml to phy-common-props.yaml to better reflect
> its scope, and extend it with two new common PHY properties:
>=20
>   - rx-polarity: configure receiver polarity (normal, inverted, or auto)
>   - tx-polarity: configure transmitter polarity (normal or inverted)
>=20
> Both properties support per-mode configuration via a companion -names
> property, with a "default" entry as fallback when a specific mode is
> not listed.
>=20
> Ported from Merge tag 'phy-for-7.0':
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy
>=20
> Link: https://git.kernel.org/linus/b7b4dcd96e3dfbb955d152c9ce4b490498b0f4=
b4
> Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>

I'm glad ot see this, and just a comment for this morning, for v2 of the
series, this will need to be a cherry-pick (or series of) from the
v7.0-rc1-dts tag.

--=20
Tom

--BHbpMcd5RbQE0xam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZng9wAKCRAr4qD1Cr/k
Cps3AQCR9+vy0s5+FLfdCOoauQJZXd+JdrSDCWjigba9bEd7tgEAtdW+SwwT1Utg
pu+DbuZVo7yCs1hY7GlxIr5PrSarEgc=
=Avgm
-----END PGP SIGNATURE-----

--BHbpMcd5RbQE0xam--
