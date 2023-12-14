Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C41C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 12:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D0EF87A4D;
	Thu, 14 Dec 2023 13:19:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AQozfg1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28B8F87A58; Thu, 14 Dec 2023 13:19:09 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 846A9878DB
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 13:19:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5e2bd289172so17087177b3.0
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 04:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702556345; x=1703161145; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eKAUGydXNOrN0rKXuDm7plYSce/ePZE3AD4Of+Xue7Y=;
 b=AQozfg1FDVDYzChqMXPe+kMieHd9pWX/pShYawXBtMP58z6TNDwj+297uyxkN/Wwau
 4t2fdWsURRYd7oaTZN07Qz9xye58Zl5498G1sYo/4WSvw9u6L223AV00Tnlerz7yMVZr
 s3btT74x7Uz3hQmfnSrTxaKFSzPArHV1STDKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702556345; x=1703161145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKAUGydXNOrN0rKXuDm7plYSce/ePZE3AD4Of+Xue7Y=;
 b=rGEz+4boZuFtP3zdOU8ExxG6OAeeFhZNbY0fe/d+vxHdKTtRFdxDj2hY9CxKF218nU
 zfI78reo297pZTCQxxZNn6p/kqANE+kJxC0L3PQtE1iRkUmFaErStG/mD17XiXVV3f4V
 LyMNYmN2saoc0wTfHmpe/C0u+awF0TR4xZvkQea5f7KnU3kxu6oA3WMRFL+gxFSZ+3ir
 azBpCAxjusvjFlVZZEpLngkeNGjPKlaBaxy4GZNiDVheaxLiY18vvW+PEHdCwPKqZJXv
 F9CqFaqEGf0+82hyomll2by/52/pWU/FnM93J5Q/bE4fqkFInVtHTFtv8/ngvJybf8Dx
 a66w==
X-Gm-Message-State: AOJu0YyhoQj6eMlgF+TexQpNg+L3NWvkCpmylgwge+jiNfgwnL49RzDU
 +2ivQQvOAX9WHkVQ/+qzy0gbDw==
X-Google-Smtp-Source: AGHT+IGWMp43X/WBsP7Mz6fzxXviBwjq3Nz/gc06EEOY8qb8LI+MVRXXvroypn+UKEhX136QTVH84g==
X-Received: by 2002:a81:49d4:0:b0:5e3:60a6:1859 with SMTP id
 w203-20020a8149d4000000b005e360a61859mr1269002ywa.36.1702556344947; 
 Thu, 14 Dec 2023 04:19:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a0ddd08000000b005e208e2715csm2016076ywe.91.2023.12.14.04.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 04:19:04 -0800 (PST)
Date: Thu, 14 Dec 2023 07:19:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Leo Yu-Chi =?utf-8?B?TGlhbmco5qKB6IKy6b2KKQ==?= <ycliang@andestech.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Rick Jian-Zhi =?utf-8?B?Q2hlbijpmbPlu7rlv5cp?= <rick@andestech.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20231214121902.GW2513409@bill-the-cat>
References: <KL1PR03MB6059E8E8F10CAE683A330D1FA58DA@KL1PR03MB6059.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9CV/fMH2kV627tr6"
Content-Disposition: inline
In-Reply-To: <KL1PR03MB6059E8E8F10CAE683A330D1FA58DA@KL1PR03MB6059.apcprd03.prod.outlook.com>
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


--9CV/fMH2kV627tr6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:38:07AM +0800, Leo Yu-Chi Liang(=E6=A2=81=E8=82=
=B2=E9=BD=8A) wrote:

> Hi Tom,
>=20
> The following changes since commit 20d0464300c25db673cfb5e4539aa3767606d1=
51:
>=20
>   Merge tag 'u-boot-imx-20231212' of https://gitlab.denx.de/u-boot/custod=
ians/u-boot-imx (2023-12-12 16:33:57 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to 8c785ddb7ae8d675faf558c81a29938cb0ec2b35:
>=20
>   riscv: sifive: unmatched: migrate to text environment (2023-12-13 16:19=
:43 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/18889
> ----------------------------------------------------------------
> - VisionFive2: Enable CONFIG_SYSRESET
> - StarFive: Modify starfive timer driver
> - AMD/Xilinx: Add MicroBlaze V support
> - Unmatched: Migrate to text environment
> ----------------------------------------------------------------

Are all of these really appropriate for a release less than a month away
or should I take this to -next? Thanks.

--=20
Tom

--9CV/fMH2kV627tr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV68rIACgkQFHw5/5Y0
tyxqyAv9HJ3xlwIUYKUGGDuuZ/XBv+p/I1EuTF+FrlmCEOy/emzh7lTwowAqXIvJ
C+COwXFhFqHGiZHLSuEyONU5TujCKxm6nJSfWLTUxrZ+GX5XVmKbGX38WC/k0l+P
M79nRwng4IalWq2dBcSrfZSLEilMV5CePMDCSYfIuZwkjMfapq5prE96UYoxMq3r
4w4JXAn9xvv9T/U7UoQQnHr6SnInI844YEHvccm+cPWvQecqDwsu+XgmDb2aMvHq
OEAr9TCSWyUPnAcdT7QygNzu38rmTGfXGIslQft06GSwr4ew1FZpmyYCyr1c1QLk
tPHAiaEvDTIndnxdpV04vm+dcLQc/H+akwU9E+b83I/BXprKSjarUYEDkisdhOZm
RNb+DnekK514/zm0WTCUNus27yRO+FKOsNRPR1sWOuh9Ibdxu/g1VjQThKWHvj7C
g9ERnmYexIMILTgZhSeg2ZzqRRZeDU5r3uUhiDrHhuLDEwnm9yHHQQfNRKd5dry0
B1TfDhAr
=2QPQ
-----END PGP SIGNATURE-----

--9CV/fMH2kV627tr6--
