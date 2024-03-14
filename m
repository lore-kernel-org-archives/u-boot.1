Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A2DC54E67
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 12:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22E8D87F19;
	Thu, 14 Mar 2024 13:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R9D86H61";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A02787EDE; Thu, 14 Mar 2024 13:45:34 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B4BD87F5D
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 13:45:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6e4e952467fso380432a34.2
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710420329; x=1711025129; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Hw2I6kwSPEsX7ekpe0W7ECcjI2763xOBgB1WtJ2Egdw=;
 b=R9D86H61Chvv0aS9czIlQ60Vdmd3NyrEydlTFJtxGaP9V8sKPhbTgtLxv3pEC3DzR2
 FPVKJkXHJnQ79oRm2vPqt9lN/rq5Muwv/L3oxkccXHwvRzEcBg7BgyKdtskOCtaREv1c
 xFbLntl5ae1IG7HfuPmijCwknnyn396C7dTK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710420329; x=1711025129;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hw2I6kwSPEsX7ekpe0W7ECcjI2763xOBgB1WtJ2Egdw=;
 b=jPqi1lKxRPoVtTL0pQ3+bycjilCjd1rC7Xvpdtu/6VpEiPqvTpZyM6HGUk28KwCH2B
 5UXo0E2JO5wr5RLf38W8HNHFbxzsGbvNH3ERp+Eb04L8p8MH3We0pj4Tu9dCaqf3OQFd
 1ehXKdah/iaBFqHmcdkTeSNoxwpltkxI7qgxz4G1s6ksDi6efiZNI503E+LFX0muR8PG
 JA1Z0Q6H/qw7Np4JAgQwU6D+sAF8yxGG116xruRPm14n90I9HT8k6UMBoBobTtHjMKeE
 vXTTot5Ue4BLdvXvl89C6yZcdQRb1Qaz3YVTihPld+LQoyWvk4Sdx+B1z/7W2b3Sgfn7
 nkCw==
X-Gm-Message-State: AOJu0YxZZgPu7vT09mj05BD2xN3NmA9zbWP3o0VRfUOK70I5DyHBhQ5V
 /mLgEyaZjvJCygxmYU91fpOZfZngP4v0N3tNO8cNt2yu6fjU8b99NNqg2flHFtU=
X-Google-Smtp-Source: AGHT+IH40bAi9KX5/DMO+Ezi1QYkp4dqfMN86qdE6PP/cXgb63+hzAlTJSXeaIb6lnT1AZtAPSf77Q==
X-Received: by 2002:a9d:6e83:0:b0:6e5:21c1:b425 with SMTP id
 a3-20020a9d6e83000000b006e521c1b425mr433500otr.7.1710420329117; 
 Thu, 14 Mar 2024 05:45:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:7f::1005]) by smtp.gmail.com with ESMTPSA id
 d2-20020a05620a158200b00789cd996cbcsm752341qkk.134.2024.03.14.05.45.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 05:45:28 -0700 (PDT)
Date: Thu, 14 Mar 2024 08:45:26 -0400
From: Tom Rini <trini@konsulko.com>
To: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PULL] u-boot-mips fixes for v2024.04
Message-ID: <20240314124526.GT3442575@bill-the-cat>
References: <20240313211401.253572-1-daniel.schwierzeck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c5NqYaJ+IDS2NNY6"
Content-Disposition: inline
In-Reply-To: <20240313211401.253572-1-daniel.schwierzeck@gmail.com>
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


--c5NqYaJ+IDS2NNY6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 10:14:01PM +0100, Daniel Schwierzeck wrote:

> Hi Tom,
>=20
> please pull two bugfixes for MIPS, thanks.
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-mips/-/pipelines/19933
>=20
> The following changes since commit f3c979dd0053c082d2df170446923e7ce5edbc=
2d:
>=20
>   Prepare v2024.04-rc4 (2024-03-11 13:11:46 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-mips.git/ tags/mips-fix=
es-for-v2024.04
>=20
> for you to fetch changes up to 6806a133cde6f99777925953ee046bf2f050d4ef:
>=20
>   mips: fix change_k0_cca() (2024-03-13 21:15:40 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--c5NqYaJ+IDS2NNY6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXy8WMACgkQFHw5/5Y0
tywx7wv/dWiyVZTfAPWBU1Vn82ypk0d+wWjAgxlPoAluzA2wbnlDKt75jgbBglUf
RLaRVK5Qi5KJupxXkLDSSoeGErt6xzKt/hrfEd3qsaXpPpJlxXBg5LD1bLC9e7v7
CdubhuATEi+sdfGTPIf8wUSfCYmb/Zqenm3GGPH2HyDNauXDvlBjVKmAFNVSi21o
VyoA8B8yrTMk2p2veRLQ8svT30cOq7D2+r9YDCwaoBL4rE2ZiN80QDS2erMPWVfm
fVrriMOkccv+1/zLQZGIeyGiRxtrPpnqVImh845LOqeOBZKwsuS/PGaK33tTe+4a
ozBjqlfRlO67IzOFzmGqWzfDaQGiB4bp5FLJfdlP1KvVT1O7TENFPWjvEAl3NvRi
981ZkkVKE/+XH0ogxLpq3mYZhRYNcFmWKrrRddhcwIHFshOPmh/vlDoRGCfQAF4b
/p5nf2TchqyQfWV90564LEgqS2k1nm+efgodScComK1P/2cA4vH9wdrC9ZDzalhr
o0YBsSOJ
=widi
-----END PGP SIGNATURE-----

--c5NqYaJ+IDS2NNY6--
