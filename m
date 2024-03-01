Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CABC5475B
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 23:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF8C87D7C;
	Sat,  2 Mar 2024 00:31:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UDh/dwDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112FB87DFA; Sat,  2 Mar 2024 00:31:23 +0100 (CET)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAD6879FC
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 00:31:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-608342633b8so27496367b3.1
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 15:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709335879; x=1709940679; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YV81UKNFloTDk1l1n+tHBTT0+k556uITEVdg3LYtFoU=;
 b=UDh/dwDQQJZHH2H2/lS2ddIxKwjqY0nAiEWwz0+jCnW6Fq6itJ8bp4jBA7vGmvtkNw
 kNh95YsDOwEkge9TuNiQiJLBb8S/cNTXTAlEBSahZR8b/wFwvt58H9kYjs2NEZmfJJdQ
 D1p964lIlbZ83bG4gbacBJtJiMOHCRAsUo2nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709335879; x=1709940679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YV81UKNFloTDk1l1n+tHBTT0+k556uITEVdg3LYtFoU=;
 b=M8wUUmr5S46NS8ojT/aRV+c0ZyqdL+jwzhc/spHva9FS0keIAQRyQx9Srw4v1nVFzr
 pzsUDooXjgZbx9CNugPTkK7RQPBktAybZeXCFf8NNxlY+ksKBS1jW7+A8USNZwYyxIpR
 IPCbNiq+FRruLNheJGhrYzb0J8IqiH7FuYrNAdMYUGwpaFcMqwZ258pslQ7k9qmkpAMT
 T0PoPuNl4q6CeBo5bqCRkgz4WGlDB+6JFDjE1DJX4zNInG9n6aoqQFet86Uan+H3zMDh
 hLT+Qhl0aajiYC0P3OHqNKh540GL6mV2cj3cTcKEnhEJfiCNx4ESP+2NwN/l1wqRGucH
 dajg==
X-Gm-Message-State: AOJu0Yxs7EHfDmHzom3ouRIF0vjljKJKjj0gu5ueYs9e8Kmf9Jo/yviI
 DAHHQ7XDhXSnZU9YALr6eEm9sjZStd79xXr6ym0KJN0ek+rkrCW03gUV9Hs6Apc=
X-Google-Smtp-Source: AGHT+IGMnahVaJmlXVArXymxC4wK2+VnBJ+TgxdH2yNo2nj4e5UapsyDdtnI5MZde1w7ZDsTfmczOg==
X-Received: by 2002:a05:690c:fce:b0:608:9758:9256 with SMTP id
 dg14-20020a05690c0fce00b0060897589256mr3575223ywb.36.1709335879599; 
 Fri, 01 Mar 2024 15:31:19 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 q63-20020a819942000000b006092cc38381sm1185170ywg.106.2024.03.01.15.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:31:18 -0800 (PST)
Date: Fri, 1 Mar 2024 18:31:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH v1] cmd: md5sum: use hash_command
Message-ID: <20240301233117.GA1492435@bill-the-cat>
References: <20240211185616.1041356-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FppptOFe69AmpBix"
Content-Disposition: inline
In-Reply-To: <20240211185616.1041356-1-igor.opaniuk@foundries.io>
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


--FppptOFe69AmpBix
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 07:56:16PM +0100, Igor Opaniuk wrote:

> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>=20
> Drop old implementation and use hash_command() instead, as
> how it's currently done for crc32 and sha1sum cmds.
>=20
> Test:
> =3D> md5sum 0x60000000 0x200
> md5 for 60000000 ... 600001ff =3D=3D> e6bbbe95f5b41996f4a9b9af7bbd4050
>=20
> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> ---
>=20
>  cmd/md5sum.c | 149 ++++-----------------------------------------------
>  1 file changed, 9 insertions(+), 140 deletions(-)

This breaks building of imx8mm_phg.

--=20
Tom

--FppptOFe69AmpBix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXiZTsACgkQFHw5/5Y0
tyznRAv/b8pc9dBfVByX1NtiuyT2rfaxzwPXgjn83Lk7i/3iBZaog2zx8wz4Rz90
rq1PdHe7vNXmWoJZIomTBjVCg0osDeWnI9oA10DkLSYoix/Xn1rLgwIhekSwh2Rz
oyUiEDRkxAZSANSkRTIOmXYUiuBp7AXOEayQ6ZT35c6zADBIfdUMrfJlGeHcWU3z
8ZQ/BDj/vpOVXhnnaSIadkjrCm0fhA6v5WWWkYH94nexnc6GI6dc7VqjDsXXy/lj
mkDNafW2Z6F8VdSPOwF6DjAxfINUUBppz6QY5yl22HNTXZGffDYCS6UrN6l78oyT
eT8bdc3dOK6Ob75taG5g6IjCN9+mNVepAubaC+qUajliYclcSebLbAQDOynYg8T7
mltPSYNi4iKuOT5KVjqv9r40jdjfseL00sdvMfKtLewPqS1ZA48HAh9GwThUwGNR
O/8RPIgdcuX2Y8xRKO7cP9Gz3oKDwNyLZiJDVB2FxDLogHJjziUI45tLMEdwgti0
FnDrsYoz
=R9jM
-----END PGP SIGNATURE-----

--FppptOFe69AmpBix--
