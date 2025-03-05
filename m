Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B5DC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57EDE8083E;
	Wed,  5 Mar 2025 19:18:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R+aYMfEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19C74808A2; Wed,  5 Mar 2025 19:18:04 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CF1807D7
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 19:18:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6fd4dcf2df7so45673257b3.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 10:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741198627; x=1741803427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c3fQCEFlF8l2oDfOfPp7NbGezsQctQtWLczjm5YptsU=;
 b=R+aYMfENuK1M/mIvWOzxplSJ3CbxkveYiqouQSrouvIS/uS1YH20CjzsYX8IlLddwV
 8RZ76hUq0lJIkhCW/HtTRIR56BuFtTTKbvbA8Lr9XP8ceqVB7BoHly0n5AXbmtQjcraT
 +GYXKeP3Vr+R4bEwXDKH/wMZ3RqTwct4jfWZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741198627; x=1741803427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c3fQCEFlF8l2oDfOfPp7NbGezsQctQtWLczjm5YptsU=;
 b=avKrCeNWrFZFkIctXUYHzj0Mkc9GYlGXpA2zH8XyubWSWzffTu6rsPNV++okMsVnMr
 vli1EVcb6wJuZ8G1ncxgxoLk9Vd3WHBoP6cbfEtJYV807MA9d/IiDv9qAwP2TtpjBOrp
 +1+u2PU9hDJ/M/WpyLT3deyHjBo5AXu46QkQXlHeyRu+WAwUO7dwWp4F44VaVDTb2KVp
 ds5BnJNk9B6JxB2Jr3T1sPLiV5Y0pmo+EyYxQ0q7BgPF8p1lMcKVl1ibEqqEE+ING5F1
 5BnqivSttUHlh3asYRCOEMPBvE4CO3Nqt/LIPWbEOCh9aOBlikHWRJs0a/XfPvy4+bu7
 xhCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXebm1/M0E2IOfaQhZ7TtrNuT4C9lpYx9YcyDQKf5NCk9zSjjzDPzpqTuTjbi3u1tTnCIpuKzk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7iHRWRw9jEFXsaxcdeInm2KogycMJcgbGSETQpsRF92NgEqwU
 et71tNpBoX0inxvnK/O6oSEfeEaORlt+BQd/GdaTBmZM5fPDxeqIXa2QSN4BsnA=
X-Gm-Gg: ASbGncuKkHacWc4oap84a3dCisgvhKf6iBe9az8VFtbFfOgqC30D+3WuZVIGJKSz+zA
 921/VWW8E1mAxIEV97eeK86cP6c9rBvfBYbTeFGu97IH7QnWii7qTIfWgggXEciSaU8OuBppr68
 bYOs+Kc+n7pbQsc+Yl0m6VjQlRATc6U7Krvb7erREgfn5kgLqzkokVeG7fgBxn3zsOT/Bn3rs9u
 7EkZXkyUcjcnfClV26oDJxQ2zRxKRFpeWUDhvO3HcWm7RJPPngLkJJJ3DmJAa5ZTAQz//GNgYdr
 NSpgKPuIb8xxmguKnhWfYCUafh8uHl3vQk2nQ2pXnUjNYw==
X-Google-Smtp-Source: AGHT+IGUAS3ntsHgR86ezjv+gAwKXmAb+Liay/pZUnTPlJu69EHFk6rls0WkHsemNbcqpiQ4GAmUHw==
X-Received: by 2002:a05:690c:6a09:b0:6f9:aeee:8f1b with SMTP id
 00721157ae682-6fda31a8a2fmr55704907b3.31.1741198627184; 
 Wed, 05 Mar 2025 10:17:07 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb9e6e3sm29877897b3.103.2025.03.05.10.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 10:17:06 -0800 (PST)
Date: Wed, 5 Mar 2025 12:17:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Simon Glass <sjg@chromium.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Mario Six <mario.six@gdsys.cc>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de, Ian Ray <ian.ray@gehealthcare.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v4 00/12] Add imx8mp video support
Message-ID: <20250305181703.GW2640854@bill-the-cat>
References: <20250129-ge-mainline-display-support-v4-0-a43b3657ed7c@bootlin.com>
 <CAOMZO5BGBv_hM30W+_J8AS_X3fqj6MXy8DYDhoyROdC89=k7aQ@mail.gmail.com>
 <20250303170640.GS2640854@bill-the-cat>
 <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZsqfzqaNUMlKd4W2"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BTCir859QDcR9XEDTnc4JnMHdCSLXTe94Z9z_FY5bwbg@mail.gmail.com>
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


--ZsqfzqaNUMlKd4W2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 05, 2025 at 03:12:09PM -0300, Fabio Estevam wrote:
> On Mon, Mar 3, 2025 at 2:06=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>=20
> > It's a tangential failure. Svyatoslav reported this with a series he's
> > working on and Simon wonders if bloblist support got broken but hasn't
> > had time to look at it.
>=20
> Please let me know how to proceed with this error.
>=20
> Because of this error, I cannot send you a PR with this series.

The series is delayed until someone has a chance to look harder at
what's causing the handoff test to now fail.

--=20
Tom

--ZsqfzqaNUMlKd4W2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfIlR8ACgkQFHw5/5Y0
tyzQiwv+P7wG10Lb9XppV2f0A+f6qrZQ/Vr4bBYGbTJ3jVrVaoS600DG+KRJhOY6
wduSTRAH3fslf+rzkXNr3oR9So0RMTx+Hi6XAjaWy89Q01+2JhxdScRv1PV3Tefy
7nzKHp1AmVfJ81QPulhjrHiQHkqmw91G2LXOlgFI4RfgwC38jryKqME8t3Eoi7zM
X1+V3JdSMZ6J0vDFcY5sbQlfhylNDEKMvjXmk07rFqiBsHd0g8wRSU7AiLcSFDmY
4jSfMb1lHK6BzGoHjxIU+6ftABunZ7EUxWn0w+julMDAUnj9QxYQVtNMVlYM06e/
WbIFzvVg0f4Cqjh95m2kPGsyw321+iquwtXd88BvR6zmVKQ2VUM33cLC+iXMRhPV
VTwJkh1ciqUSFI0D72C2WgDLM2mciANzVgVfovt98f/BbwdIWnTCMqTvRo56aU5D
LV1IjQiB5mHy+3wgkyQJrf9z4SvUpaUzoc72mgYyhdMEuJgtz3C6KcSvrjiXELhH
vMz3Sspe
=6Gas
-----END PGP SIGNATURE-----

--ZsqfzqaNUMlKd4W2--
