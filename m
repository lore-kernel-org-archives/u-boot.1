Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FB0C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B957288085;
	Mon,  4 Mar 2024 16:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PdPB2iYA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D61488035; Mon,  4 Mar 2024 16:28:42 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 938C888084
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6907ab22f47so2687156d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566119; x=1710170919; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XvDsv7z9W3BYf4YRBPJtTBiGT02Y6jD5+V7w8UtZzkI=;
 b=PdPB2iYAta+oBu50G2Pa8+5lpvQ3S9nipsc5UyoWhyepBg+kR5GZQQN603CAUHe9/a
 8gsEwYe1eF5DI+dLIZP30nrK5PtVoFYNvty5rLa62lQEiXCaASDJ4qbLB+5rWvTb7L8i
 Ftv7DMABiUdwMcmn0U/sAVXrp8pQnuFxd5ZKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566119; x=1710170919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvDsv7z9W3BYf4YRBPJtTBiGT02Y6jD5+V7w8UtZzkI=;
 b=smERl9vsoy8HC2eqvUKr0O7kUn5Ka/wX0B/8Cj38TJyMv2tJHKlzVo8kKrbrZaNWOq
 +u0+tG6Zt3y9JVAouHeYXy95O3qzok55YMW2SQPWq+iQ8PfOPxJUH1bfy5kfk9pJJjRJ
 c7wP8kwhopBvnYsKs81gF41PSoD12j9jT+327XQ4805BFycJ1SgpeaUBhmjm9em38rz7
 zOuWdMP3aC8QzVHmT3HRVCwqNDwkdMTvIQvS5RoulXodZplpblHKLTD7Yt2AjHAaL7XZ
 uD40ulHlv1/VTLG7cuan9ypdfJHVffmpIgCU+XUx3r2DRA2IzO3dyFEiEG+cFXzhfkSV
 sx8g==
X-Gm-Message-State: AOJu0YzhKf7FXRfaxHLbQP2X/IdeMxoHRjmhIx1bXMSSyEqYQMyIJs8i
 utx/Ky/8OmkqsCn/+TQiIAjSw3JiZdrWp7F+e1vY4UDETa8x98cQeb+fBIT7rNA=
X-Google-Smtp-Source: AGHT+IEFCQ1kBGQ8huAD7DBK8+qcOMJsaOhRL4hldpYn03Bi2AMj9CN5w+m/zjCnr2NbcZW1Gx74UQ==
X-Received: by 2002:a0c:fdec:0:b0:68f:3f98:f695 with SMTP id
 m12-20020a0cfdec000000b0068f3f98f695mr9728248qvu.39.1709566119332; 
 Mon, 04 Mar 2024 07:28:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 ng8-20020a0562143bc800b0068fa4534070sm5201928qvb.83.2024.03.04.07.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:38 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Massimiliano Minella <massimiliano.minella@gmail.com>
Cc: u-boot@lists.denx.de, Lukas Funke <lukas.funke-oss@weidmueller.com>,
 Massimiliano Minella <massimiliano.minella@se.com>
Subject: Re: [PATCH v2] cmd: setexpr: fix no matching string in gsub return
 empty value
Message-ID: <20240304152836.GE1523872@bill-the-cat>
References: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C0KNftj+Eojny3TA"
Content-Disposition: inline
In-Reply-To: <20240208145827.3547501-1-massimiliano.minella@gmail.com>
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


--C0KNftj+Eojny3TA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 03:58:27PM +0100, Massimiliano Minella wrote:

> From: Massimiliano Minella <massimiliano.minella@se.com>
>=20
> In gsub, when the destination string is empty, the string 't' is
> provided and the regular expression doesn't match, then the final result
> is an empty string.
>=20
> Example:
>=20
> =3D> echo ${foo}
>=20
> =3D> setenv foo
> =3D> setexpr foo gsub e a bar
> =3D> echo ${foo}
>=20
> =3D>
>=20
> The variable ${foo} should contain "bar" and the lack of match shouldn't
> be considered an error.
>=20
> This patch fixes the erroneous behavior by removing the return
> statement and breaking out of the loop in case of lack of match.
>=20
> Also add a test for the no match case.
>=20
> Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>

Applied to u-boot/next, thanks!

--=20
Tom

--C0KNftj+Eojny3TA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6KQACgkQFHw5/5Y0
tyzaHQwAmBZQlmuNHaTT1onAdn4BZKjRUNt2cnLNQytBdBT1RolNlR1QN8+OMYcW
D33S9z7pGdhAmf5Tw1n15icUJANeoSMnDKfrW0HttWvH542Khu9EsnwjdTLvKtpJ
q/GNIul+iNi7I05qeZ/lfEmpKno5+sSh9c2DqB0lSIXaxBFT/E5/Z7IOgvLjcN2l
rp/n4lvXCVSglBzQFZ8OZt/dJILN7MUfowKjBiqT/O//nyH0nzj7hsRZsbJNjN+H
tglhFl6E1Gk9M505KKSQ0DEALFpp3oAUE3xlYUdz59e3e3nzEMJ4kmZoERh30S78
4HEgVcedhs6+vrSm+BdXJ4rj7oRbr8rkbuTp398EvczdJYsdj2GLBFyAewxYY5op
88fSQjLRBO8B4JEYe3ZI2Pggg6z/V7hjck0RgNAGlJZjhsSJg6CEgar2WkFgvXJk
hzMW0R32d9yq94HBN3mUI2TcSTRuWHRE11qbotPPSLCwfpw2Iwj0CZ94sSaUNf7I
PzCDh+dM
=3RHC
-----END PGP SIGNATURE-----

--C0KNftj+Eojny3TA--
