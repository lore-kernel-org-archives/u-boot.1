Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A94C5C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 13:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED7587E11;
	Mon, 18 Dec 2023 14:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HO7Wxl1e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0943087800; Mon, 18 Dec 2023 14:14:32 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AA8487DF8
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 14:14:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-425f5964ce1so29563601cf.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 05:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702905266; x=1703510066; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6/KM9S427Jd31j1Bc0LGHPkssVinhrQSzcZG9VKpmRw=;
 b=HO7Wxl1eqZE3GDX9sVykhtKI68Shl/MnOH3NkEcabdLmUVauRPkc4Bt+ID3RHm6CKC
 G1ZzlHRrzktDL90Co/RoXs9LO62DiKo9gvwsHd5JHrkLwACw6RqIy+Qv2g+xjmjJhW1v
 wJ/GzgMABTgEez537M6MO2afWfIZa0oi2c7yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702905266; x=1703510066;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6/KM9S427Jd31j1Bc0LGHPkssVinhrQSzcZG9VKpmRw=;
 b=InQsYIFu94ZwvcItAmr/9DCk/xDKf0VgWo2M4v1bYdKkJ+u8bK8UfFprzuaDv5J2VB
 f6a+adLodOxVosS7Uth1Xako+gl0VlotigyMPyV345Mlt+RhaGEkBJV0zrv9UYZDms8h
 9KFcS7RzvdgD2+2R1GZOQ06sXt/aepf10DTFZr/Zn15cUlos342BpesboPR4d/uu5IYz
 dJc9hReAimHN7R9ZhWb74W/51lsWdQRNLBEQKCJqEbLVeLrggXOvlbMRrsu1ryQ77bgb
 6nx3AVk42jPbASMG1UmOLqeLOgHWstOGpWIjGefg18rknC8+H9j+53AWFCde8Xmg9kQK
 /wYA==
X-Gm-Message-State: AOJu0YwWwHPvC+gZFtlC4AIVPCR4g5fk/VwuPvgTvxCAiKxblD9zB6N0
 7oeakSAAlncps1ZajO9Y8Fo8TWvHPpBovGIDhjc=
X-Google-Smtp-Source: AGHT+IH2ZlvrtbDsrNRirA3R3Mss3pJCici79ThB/AbmVNYZux4ro9+j+cjjzPCGu29iHj70ClRHGA==
X-Received: by 2002:a05:622a:1d0:b0:423:6f8e:cd79 with SMTP id
 t16-20020a05622a01d000b004236f8ecd79mr22345300qtw.54.1702905266002; 
 Mon, 18 Dec 2023 05:14:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a72b-a3fc-ffa6-9927.res6.spectrum.com.
 [2603:6081:7b00:6400:a72b:a3fc:ffa6:9927])
 by smtp.gmail.com with ESMTPSA id
 o15-20020ac8698f000000b0042388bce404sm9292961qtq.57.2023.12.18.05.14.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 05:14:25 -0800 (PST)
Date: Mon, 18 Dec 2023 08:14:23 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.01-rc5 released
Message-ID: <20231218131423.GF2513409@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qq6WjerXFQbAAM8g"
Content-Disposition: inline
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


--qq6WjerXFQbAAM8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc5. At this point, I think we've got all
the fixes I know of that are critical enough to come in for a release
that's just over 3 weeks away, with many people on holidays during that
time. If I'm wrong however, please speak up and let me know what still
must come in now.

In terms of a changelog,=20
git log --merges v2024.01-rc4..v2024.01-rc5
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

At this point we have one more -rc release on Tuesday, January 2nd, 2024
and then the final release a week later on January 8th, 2024.  Thanks
all!

--=20
Tom

--qq6WjerXFQbAAM8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWARa8ACgkQFHw5/5Y0
tyzkRwv9FdySeTOVyTqjA6hl7Dirm4B2QNrW8cYauFhkSCuEZ95xdjPE4XEL+bQc
LRSUFp9QGRAnuNZhy7ngO92PY0rc/9sbmQGsf/N6BXoaUiK/B6REtWdpbflK2T9W
5sqx4u3IG0jHMUb7BPPhxBbhJOWjbRoy2vWqTgNFBMxpgLCA6j93nMFw5tMFYtoj
N2ditAr4fGJUtP5Z2S3GM6wHa5KjVZwbjuGQbT7Sxqi93B/IwljSpsc6h8X5EqrA
ayj6Uq4VPpIC4c8BM8cNVEEGzvaL4GoCEZ5+AarQWcjILmuXTznf4OAAa26tGqzc
2AmleJf2Yn/DQOs9pvA1IyTP++eT6u2ONIjeKQM6T7JoJDhkT17GaF5+Yzc4sYmO
PfPeZnl324XHnYKzq2Zf3HA28zyiQtk0q4ss+4Mx/ca2d17Ez6LK8oFxgMWqSjZ+
GJZDkZ/tRhiXzuKdlGH6G0gM/MlvvMH+nz/+Ud55W0mnD2y42bu6nZrlflK4fPos
Ri+/b0Yw
=toVS
-----END PGP SIGNATURE-----

--qq6WjerXFQbAAM8g--
