Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37ABEC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 18:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A80849D2;
	Wed,  8 Jul 2026 20:09:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MZGyNCDg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06BD384A0A; Wed,  8 Jul 2026 20:09:49 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E848E8497A
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 20:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so100129a34.1
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783534185; x=1784138985; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LuIGdyg4f+BaRMdtCq/0KBICpEVJ0wSH9zRg4Juk7Gc=;
 b=MZGyNCDg7DxKYG6oVlPNBPJOaRsaXtZ7Qi+myI7bInLIU7TtGz6nhbBNwZyOa/8NSH
 juxZHO5KtUu4GAfz887FZ2dpUjwwV7oJ9aguZBF2c9dm94QQvJeI67xUVtduSNdFBwmF
 ryVkM6L6hUnnMuNqkgjKlvdzvmlf7z1DcACOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783534185; x=1784138985;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LuIGdyg4f+BaRMdtCq/0KBICpEVJ0wSH9zRg4Juk7Gc=;
 b=VeqGWprwdPnNZWlEmGpL5wn1ynENQumvlu+GQsZN3bFifHcQx6rRG01SFAKsUnprwB
 nUEluYsYc2/wO1hlVQM4eilb5Bm7835oUqH1ZIooa7XuX338/bHGMHTDSowLNxtD/a9t
 2/s9K9ryif4uJXzDhlOh3eyOcSj5glylss8Y/MPJaggnSFvmTVPOr7+1y8Zroig/1Vz5
 DbWeIhgbOVfXK9Mh+B/uIleJ5eU+A4zW5fthDCSgb1UnjxRpfIrswzWhCrZi/DsUe/kT
 htXiybqaZ7PUUQhay7AvLCEBhYDPoiLYZLzZzijPTA++6UykB5N9DiXXI8kKzDktr3h5
 vOew==
X-Gm-Message-State: AOJu0Yy+H3hmvSB1216zvtXRiR2ceVqiHl8tFmbk2lebQPSOzLQ5jwq5
 TBF574kBP3ToyRfiJ0N2rJD0gVCGyICMahEb38NUJJ3j1XTRVG6Dm0icXzStlqhBo9I=
X-Gm-Gg: AfdE7cmzqPJdTqbIAioYDxJSkuB6sYmoYgTp/mFJFyUU2PBJheGucB2MziC35XCEf0+
 EU3HD6fDKrFXY4bdpkbaVy3SmKXqkxh9vDugfF/j+zvAvZJZ3yT9wBC0P41y95G9jxsbR4cFMi2
 dhe82x7ni4/aK8XTT0+Q41tay2QZbWy74NSpw50EecUvf+rQ82ipK6AaXrKLZSYPzmKtoFw8IHV
 nNYiICLFP8EppEHGb0zmzxfoJlUQZF+tRk4TyunnNb3oJ36D/xmiNhMHcYzzU10GZ4JahUhgy2r
 S6aV4Q9pCCQyJ3MVmSA3QbSnBjh3V6JKkeLdDlWto6i1rAJ3DLrMiv6tGV861O3Ld6nqSj3g62f
 tZhSk0+8tGWEKQAPO+oc42ISJkTA9BIZeDQDLFYNTDN4ujLkus0i64P5TmrkZbqcZ9EX2l3kZ5S
 HCcjP25GF62vic1YQulehuhldFG4ZZilim3yz3TdLfnOvb/VEUGo2znF8Ea9HvYDLKuEZP4op9T
 90vL9mVHcuo4QiJ/HiOzNZKwmH5Jyzhjqm18w==
X-Received: by 2002:a05:6830:2e01:b0:7eb:21d:70b9 with SMTP id
 46e09a7af769-7ebd02e3e6bmr2259652a34.22.1783534185721; 
 Wed, 08 Jul 2026 11:09:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcae1ddb8sm2397394a34.6.2026.07.08.11.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 11:09:45 -0700 (PDT)
Date: Wed, 8 Jul 2026 12:09:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tony Dinh <mibodhi@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] doc: CONTRIBUTE: explicitly list tests and
 documentation as welcome contributions
Message-ID: <20260708180942.GF749385@bill-the-cat>
References: <20260708-other-contrib-v1-0-8b3bd4d265ef@cherry.de>
 <20260708-other-contrib-v1-3-8b3bd4d265ef@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jNqGPYKOJI/4roor"
Content-Disposition: inline
In-Reply-To: <20260708-other-contrib-v1-3-8b3bd4d265ef@cherry.de>
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


--jNqGPYKOJI/4roor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 07:21:15PM +0200, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> We don't have too many people looking at those at the moment, so having
> people getting into the project by adding tests or documentation is I
> believe a good thing so let's encourage those specific contributions.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--jNqGPYKOJI/4roor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak6SZgAKCRAr4qD1Cr/k
Cj0AAP9ix7CRL2S+eA/T2f3+XOSfOZrYU3JXEXe2OQdTYp/cbgD/QRih/KIuecqe
d17db01YfRRbi51buk5YC05iTUkjIwk=
=/ui2
-----END PGP SIGNATURE-----

--jNqGPYKOJI/4roor--
