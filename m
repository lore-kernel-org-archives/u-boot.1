Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FE8C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 21:16:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4084A88B66;
	Thu,  1 Aug 2024 23:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MlC+G7kF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C243D88646; Thu,  1 Aug 2024 23:16:16 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FFD88B58
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 23:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3db2315d7ceso4259156b6e.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 14:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722546973; x=1723151773; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RIC6kSiOkYOOOCTzdjfnidrRPsrd2hNxVUVYAY/ot84=;
 b=MlC+G7kFfNLaTx5CvlFKEZG1/mGFKUGjMZKsKQN3j/86xhLg7ygJ/pLi1v4lPJpfS3
 FiQHw/sGFiesM0MCLROj1gkNIppOetcvIhSPQK3gzDUSy8289eB42KsbnqsLGuIOpB2w
 d+x+MaoJ+n3FsCitdmcLymg+cI1L6Ewunl33E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722546973; x=1723151773;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RIC6kSiOkYOOOCTzdjfnidrRPsrd2hNxVUVYAY/ot84=;
 b=FrBmmgdLDp50EKExg8ikRw8Cb5eMdWNO/YkELV1E0TIrWgiuB3cW5tB9xw8IFlJG15
 3G0c2rsqLRVZeY5onvBBV8abiUKA+dkA7dn5Q7hUCkJ8tb+dXZZvDxZWNwqewo8jfqJW
 5N8lFgkoeBZQyIN0VaBvgUdCb1j4Rbmx2b3Rm+7HaqtBzNXOkQ3jqlKa2ijhMoLMeNI8
 Fkdd3qzcC4Xzvh5Xy9zj2PDPdYzboncLd+OnBFroDO3/drNsPcViCOGvNZz0jOdx/4Zl
 TuWJLCo3w835SWXeUchSX/MoauFUN6G4DWEgO/SpyyiLnSL/BCbTR5cHFs5uw9QPnFsh
 MsjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfrM/lCWcdwPRFuvezXHEEarNpX8LWpZH9CVWNLqj24Wj7iH4mlapT2piRojaPHT82gItBP13+G/ua3pPI7vqGCsIXVg==
X-Gm-Message-State: AOJu0YzOLNRsVlHb5X+xD8ObfvP3nfQhlB2QN9h5r8qfmOt+Wh8aBCe1
 OsIT3tfpc86dx5GlrDzK3OjvCFhlaDXCmLtPykf9zzyfJSGJgv1DkN+NhvU0gRU=
X-Google-Smtp-Source: AGHT+IGSQKm5UAF/A1Zf9VYqaS5RjOyHzZUfjQ0fPmT3SsJExriwM6hxI0Bf80Ob2omuL2DNy5iidg==
X-Received: by 2002:a05:6808:2123:b0:3db:15ed:2a21 with SMTP id
 5614622812f47-3db55802279mr1706477b6e.16.1722546973346; 
 Thu, 01 Aug 2024 14:16:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70a31d9dd3bsm154949a34.10.2024.08.01.14.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 14:16:12 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:16:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Teresa Remmet <t.remmet@phytec.de>,
 u-boot@lists.denx.de, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <c.tenruh@phytec.de>, Martyn Welch <martyn.welch@collabora.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 1/2] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Message-ID: <20240801211609.GM3794063@bill-the-cat>
References: <20240801125416.1582652-1-lukma@denx.de>
 <CAOMZO5AJw66wweVOL0QkvnKrAWCKRvQ9n00OdRfUPxfR8LUibg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UB3c3dDg2E2THwyi"
Content-Disposition: inline
In-Reply-To: <CAOMZO5AJw66wweVOL0QkvnKrAWCKRvQ9n00OdRfUPxfR8LUibg@mail.gmail.com>
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


--UB3c3dDg2E2THwyi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 01, 2024 at 10:13:13AM -0300, Fabio Estevam wrote:
> Hi Lukasz,
>=20
> On Thu, Aug 1, 2024 at 9:54=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>=20
> >         "mmcdev=3D" __stringify(CONFIG_SYS_MMC_ENV_DEV) "\0" \
> >         "mmcpart=3D1\0" \
> >         "mmcroot=3D2\0" \
> > +       "update_mmc_part=3D1\0" \
> > +       "update_offset=3D0x42\0" \
> > +       "update_filename=3Dflash.bin\0" \
> > +       "hostname=3D/tftpboot/lukma/\0" \
>=20
> I don't think all the users will like to use this tftpboot path :-)

And while we're touching these boards, can we get them migrated to plain
text environment please?

--=20
Tom

--UB3c3dDg2E2THwyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmar+xkACgkQFHw5/5Y0
tyygTAv8ClGx0CxTBePz4Wgt9ypPz134NRqkzkZ4uZ8zT8stQXzoox9GbuFat+so
Vw0D59JHepo0AEePUVyE8hhGj4rgw0q4uRgJXRR44AUTRO/dkiXsPYL8zHb8tfAQ
rbQ34ZOGXIpk5J1MIMFZ2Tlsaa/kojduiLfPgbfTO4/fel8MCtpUIMrR8WekNY4+
nMxAxIfmnqmuBZCChIWfzNnNCGO5Ya5Oo6PpjU9qpDNt8qvxGnesiWInNONxcVG3
R5tGIw4FrT5nR7uOG+1XhgcwxOkXNQmZnyZWHYCzQBkjARCxpfgWklqXrjO1hAlN
iWCfb++QQ7preiEcOOT3QTOWju6k87/K2PIJJ8pB+6PR+nf3UgpOSYsHdGwUltLp
60tKwYHSmvJhCLoq/aNI3g32Ig95z2SHRGtRXVAbkMYFAZ8/CmkUbGtNLXgVxYtR
iIE4KbeQoAVXVKdS+pwTWNRIFiU0YNWdwNDnAxhCyWNbZGO1MaJv3yCRyedGHHLw
DJ/Jpwzg
=NCUp
-----END PGP SIGNATURE-----

--UB3c3dDg2E2THwyi--
