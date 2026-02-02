Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D12CE7FDC1
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 19:45:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCF3583F5B;
	Mon,  2 Feb 2026 20:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h7GE1HdY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F358B83F5D; Mon,  2 Feb 2026 20:44:56 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB73283F59
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 20:44:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-45c87d82bd2so3276122b6e.1
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770061493; x=1770666293; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q//uzJbbLBqQUda7Iz29V8vpE3J8pTD5MIs6jkQHel0=;
 b=h7GE1HdYVM0Nei6w/bhcq1GswCFljcGJq5O0D5heQcceFzHXmvSfAcTrjK9IGZwg2J
 CNOEMw6mH8pXHZXujvL4UBmKFljRTqZp3nRkMdjIE8iE1JUr8/2q2fGghZD/Zh+20Fwf
 quiCKTvKt/AKbeVZYlKX/cVWzQ4Uu12t3Wvug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770061493; x=1770666293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q//uzJbbLBqQUda7Iz29V8vpE3J8pTD5MIs6jkQHel0=;
 b=soMGFTjJPJZM/3vB058TSo6+PuF6c1+Tvg7Ma8iDRefitV5ktA8NsLMuTncuar1Hrn
 9X07WcaSsTmLcrf31ZCK3ri1RObXucJGb+nG6Z/Q7N5igu7ji0qvTqAQOeKHHQ2bs+vp
 mshGhqoovhgFvM12g6GOEcktnoZpuwpuSx41zNCorB8rdvCz1MfFlXvvGeO1G8hcCGFa
 ttuWKFYR3N9aetjf5fluuXkF/xQCRwniQjMP+SrI7NR3EI3aGxqt5NVxGH8EdwTZrdY1
 wAt2AO8zioXnm8lic3n+87W+ouWTODlArQga+Eocb0CR7M/1i606XLUWXMJ/7Z+OGf2u
 oREg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwLlO7LOMx7Ai9uDLbReiDzYATnaEva3XTU+zHtjH2XFk0noTB4IUlb4g8dIrVz/Ssxz2OA2o=@lists.denx.de
X-Gm-Message-State: AOJu0YwjdaGmXjiQq/DnaOkzvT4LKw6SOl1cM2fOvdiOhJzysFu67j+d
 YavwFpkwWh4qLjusC0ibm5fHacMKQtlBXcMorV9IJkmZDeGX9QyownXi/qq5BHUN2/g=
X-Gm-Gg: AZuq6aJu88Zr6VEagOrfv/nmJ48HAeS48TnD3WJD/kvKJ7/lPAN00rlAa7yCzAullHK
 kPYsolMSLYEj3DPT/3SYY6iTOGF2G11LvP/3jqOBuvyf+UPJxq8Mx5Rjnqh9wsxZ1ojV3EqN4a5
 Bviefyth5sH4sGylnl3N/UvhUAlwjbYtYMeFI8uK+h9KkqUfF/B6NanyXUk7oTgimR97McYsv/i
 tUvDSWdZ50Olj58sueSSBYAxmT2ZD3RaZy+jgpX+SsiWcsPFm17icfWr1EFDea6GnTXV1QdKPGz
 xth+ZoLsL3EyQIn3/oTBd6wpHCnu+ObZn1cbQEv514mXSDwSuOKrGhccbFmWTWVBLcxkKUVzYUs
 jPEyCJuIYLGWAtixLh/M+oaeXaALmfuCpKf7yoL8fEkl56J89sdrHXIVXHAuVCcnGuuwo7XZXSX
 tJX9rQhiKqguEu2oiOblDUysDzyYgG154JbAeCXqxI1lCB8wJHcpIil3iwmw4AN3aGtDfDgiriX
 Ond95vZpAoS8uoAa2XbCEPE7JWEoDkNCIBnoPw=
X-Received: by 2002:a05:6820:80c3:b0:664:86ce:df3f with SMTP id
 006d021491bc7-66486cee41amr3870051eaf.51.1770061492792; 
 Mon, 02 Feb 2026 11:44:52 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f994388fsm10233947eaf.4.2026.02.02.11.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 11:44:52 -0800 (PST)
Date: Mon, 2 Feb 2026 13:44:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Philippe Reynes <philippe.reynes@softathome.com>
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
Message-ID: <20260202194449.GE2603314@bill-the-cat>
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C4Vy3SFhK7yzy0u9"
Content-Disposition: inline
In-Reply-To: <20260202170307.217200-1-philippe.reynes@softathome.com>
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


--C4Vy3SFhK7yzy0u9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2026 at 06:03:03PM +0100, Philippe Reynes wrote:

> This serie adds the support of ecdsa with software
> using mbedtls. So boards without ecdsa hardware may
> also use signature with ecdsa.
>=20
> To add the support of ecdsa with mbedtls, I have:
> - enabled ecdsa in mbedtls
> - add a function sw_ecdsa_verify that uses mbedtls
> - add a driver sw_ecdsa that call sw_ecdsa_verify
>=20
> I have tested this code with sandbox, and I have
> followed those steps:
>=20
> 0) build u-boot using sandbox_defconfig and adding those options:
> CONFIG_ECDSA_SW=3Dy
> CONFIG_ECDSA_MBEDTLS=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
>=20
> 1) add a signature node to an its file
> 	signature-256 {
> 		algo =3D "sha256,ecdsa256";
> 		key-name-hint =3D "private-key-256";
> 	};
>=20
> 2) generate an ecdsa key
> openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem
>=20
> 3) create the itb file
> ./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>
>=20
> 4) launch sandbox u-boot
>=20
> ./u-boot -d arch/sandbox/dts/test.dtb
>=20
> 5) on sandbox u-boot prompt, load the itb and launch bootm on it
>=20
> =3D> host load hostfs - 1000000 uboot-ecdsa.itb
> 4628674 bytes read in 1 ms (4.3 GiB/s)
> =3D> bootm 1000000
> ...
> ...
>    Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK
>=20
>=20
> I have tested with success ecdsa256 and ecdsa384,
> but there is an issue with secp521r1.=20

This is good to see. Please work on adding this to CI automatically
(which may involve doing something like the sandbox_trace builds/tests
rather than just being part of the default sandbox suite).

--=20
Tom

--C4Vy3SFhK7yzy0u9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYD+rgAKCRAr4qD1Cr/k
CkstAP9UTWDElAbn/ZmaTy/xfyhomnTi/33siSmTGJl4fruPtQD/bW/PWEm9SvaO
CC0gB49Mi9TGWCPirE3Bt3ELgzUBmQI=
=v/74
-----END PGP SIGNATURE-----

--C4Vy3SFhK7yzy0u9--
