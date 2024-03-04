Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766E4C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:35:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C878987F8A;
	Mon,  4 Mar 2024 14:35:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KeKd4c8F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E19F87F8B; Mon,  4 Mar 2024 14:35:06 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C9AF86F1E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:35:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7882b02ed2dso23175385a.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 05:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709559301; x=1710164101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gCaPIgYthu5ksgoFKyBr4HGRZi52HLxti3n6uKOizuk=;
 b=KeKd4c8FSd7q65hN3204nxjabxjkMYlXtI1sAmj0MFvpwzIcHF9aIlJreA/3cMhLCv
 cTAv2EwnyYhAH3iRRmVSlrNxnYBVl1LuU2IYELnz8AxIrHYngLj9wUFkTTDm6fBIeIUv
 OBY09EQVakR0XPa9uLHgCxXdT6AVZ5veKbYZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709559301; x=1710164101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gCaPIgYthu5ksgoFKyBr4HGRZi52HLxti3n6uKOizuk=;
 b=B+qYbHqjrJru+rZXnO0I1MuqSrYt5CGVHayiNUs6vIj2jKLma+adsEkY2EHmCKVv/l
 WsmTmR4eqHKUQj+lGVRM8Vqas26HEWl35OsyrJI6LSKjAQkYZswoYUb86ZNPI/Eglp38
 Hb3LgtUIxLuoTpYliGalMGn1u2J6OHpJDYA0IpzleCM3salkBZkaJzTIgoaQU5lS4bam
 qv3LiPcQcVBZPIbiRGa3GvfOIhoE/HStqyrkswWImSmA1hhbLSg9Kgm4wiLcVRsFMUjW
 2XDToTt4vq6A442rf3zOP8Ym1r+7BcnoOCN1kkcxbU7Ct1H9K/H3G++47u/ffCTuMeHB
 sh5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRLCytbLzrSPB2+UGPHDm22uPShnOxlYSpQj+oQjksgdpdR0rCi1W8WbXb3qrWavOEavJIMnynAlatXUBJucsvvTZ0hg==
X-Gm-Message-State: AOJu0Yy63SCAU8sKW1qhxfpzrNkJXtdQdZiK82n/2bIo153B9P6X3lll
 UQKZHquVp9TppHcoCd66mbiC1J6ZLS0T8vJsBNVWEI0ijzSOJj5Ui8aUKymcR2w=
X-Google-Smtp-Source: AGHT+IF/2uLivYW7Jm6tHWMYunCxgLq+HNHhFcRYQf9lyVKVugw0FJu9k7Am4KuvM+dxKkL6MwwoDQ==
X-Received: by 2002:ae9:f406:0:b0:788:2fda:a800 with SMTP id
 y6-20020ae9f406000000b007882fdaa800mr725591qkl.3.1709559301078; 
 Mon, 04 Mar 2024 05:35:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 bk36-20020a05620a1a2400b00785b064156fsm4328406qkb.101.2024.03.04.05.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:35:00 -0800 (PST)
Date: Mon, 4 Mar 2024 08:34:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>, 
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240304133458.GE1523872@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <20240227154234.GK3040305@bill-the-cat>
 <CAOMZO5CBY4+CogKi767RVvT0F89Kpp6Hb9p1o7cw8jRE9PwUuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3BePCh1R/aBMix6u"
Content-Disposition: inline
In-Reply-To: <CAOMZO5CBY4+CogKi767RVvT0F89Kpp6Hb9p1o7cw8jRE9PwUuA@mail.gmail.com>
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


--3BePCh1R/aBMix6u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:04:28AM -0300, Fabio Estevam wrote:
> Hi Tom,
>=20
> On Tue, Feb 27, 2024 at 12:42=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
>=20
> > What's the long term fix here? Why aren't these needed in Linux anymore,
> > and perhaps why was it OK to remove them? This is perhaps another case
> > where we as the U-Boot community need to go and talk with some Linux
> > Kernel community people. Thanks.
>=20
> To fix the issue for 2024.04 I suggest that this series gets applied.
>=20
> In the long term, I suggest S=C3=A9bastien send a patch to the Linux DT to
> add back the panel timings.
>=20
> Do you agree? If so, I can apply it to u-boot-imx master.

For v2024.04 yes, this is fine. For long term, we should parse the new
timing properties that the simple panel driver takes in our simple panel
driver instead.

--=20
Tom

--3BePCh1R/aBMix6u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXlzfgACgkQFHw5/5Y0
tyxcIAwAkeWRrkElE91zGE8pzLUkUpSWyYS1ZHfaKRk/zKkReX0S1T2fOmqkkViu
GDXg9FhDcj4OstDnL2Ll3DeojR5s3gGp/JnPKkuqA5M4yoNQJYY2V7Vd2DHox52t
n29HRi4N40sk4rAwh82HOWcolQMdIQLjezPlS2TlvBIvJTPN1MyWIHKysrIWyKRK
qAP2KGURVnXZN5UL2SpaTnOA2pNOiAg/EKjOH9v7j4DmXmHF+Fcjxkr6/pq5j/ek
CXl3DKk/nbe6mrL6O5L1z7TWbN0SQzHbEwC1TRWD9Kh+DoBIXc388iVLz0SaK1Db
x6fbTyTzuU0h2QsoNudy+3pHf9SMmPbxqQPoMkC28IWuP7Zg2R03xYGC6biuB0/G
n/f3mtM/H4BuMzV6qUExlo1P5NI2L7BzIGUS5LrGwgSry171fxQUZVdsS3O3+tTT
wpYoXBW2ddP1dyBy6TYUs4ke9aEnKmEMa8YB3qazOmqqBe30LbnQ5s3pIEGApiLf
+xv+bkQX
=fYyL
-----END PGP SIGNATURE-----

--3BePCh1R/aBMix6u--
