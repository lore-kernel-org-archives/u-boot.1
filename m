Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D133C48260
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 14:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F0D876A7;
	Thu, 25 Jan 2024 15:17:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jsd0IuDd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0979287887; Thu, 25 Jan 2024 15:17:40 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEC2A865F5
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 15:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-42a67eec0ffso6265501cf.0
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 06:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706192256; x=1706797056; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=en1bIOV9mvmuAqP5yLoSkkDXI9A/qHPTTKDPl7D+ufU=;
 b=Jsd0IuDdFqhEWtwc5PP52dF/hx8gWgIVprVzKgVf3cuqB/7jXK8Yq2fOV1vZFnnVRm
 7pU0Fyqti6Il3OclRa+fkA7fPdLODWpaUU+oa0/MQRONKirZ3K6lxvvsKlLd/alfCBkG
 62niHWl4stCAyzq3oUJVd+3B1keEq8jewcdIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706192256; x=1706797056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en1bIOV9mvmuAqP5yLoSkkDXI9A/qHPTTKDPl7D+ufU=;
 b=gtwqQcRu7bMUTMmtKDzurPxXr3EOOdff150fN3yZ950tsBI/Bm2rpAvutI1/L3eqNZ
 86lxXtGBO3ouZbz8+GmPP7oYj6nL6kTRHtKiY1qeIyx9aEod7AT/UhRjK0hoqd1zYyUz
 3lmp3PnYgHBlpkI/DeOrWvbhLQrvrqMd8YR7o3k/0I0NU4FxPudV/6bDJB1uyQlSAOPc
 Gxh740opAzIxcSkINTg4bAndumZJG3at0YwyTsat7ek3+53D2VjzaocjSgDu/41OZvFi
 qQAroTjYFu43I0OBQ6k+b7erDNqa5SbC4LDSsrsBHkRFCmlp4IsfVEkiKDyHH9i7ZYDf
 kKWg==
X-Gm-Message-State: AOJu0YxvFqQAyAWqXp5tT8tQjMF+8KDnjcdl7jc3Dg+hmWXl8TBMzTHd
 nbBnG4/TzfhTGqs2cif7t9X0kmPaK6mGqQ3LquiLveXHnfMmzO9eWMNm0W0zeGE=
X-Google-Smtp-Source: AGHT+IGvspshhuYSj0M3CiRxdHVPRow1jxjp0z3HCL3PnCKoJuw+SwVg0I+U7ZNdmb/bZjk7by/ojA==
X-Received: by 2002:a05:622a:1811:b0:42a:5d0c:da18 with SMTP id
 t17-20020a05622a181100b0042a5d0cda18mr1051522qtc.114.1706192256675; 
 Thu, 25 Jan 2024 06:17:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05622a17cd00b0042a0a0d4225sm5408703qtk.38.2024.01.25.06.17.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 06:17:36 -0800 (PST)
Date: Thu, 25 Jan 2024 09:17:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav <clamor95@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas =?iso-8859-1?Q?Schw=F6bel?= <jonasschwoebel@yahoo.de>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/1] Fix booting kernels with ATAGS and extlinux
Message-ID: <20240125141734.GK3652023@bill-the-cat>
References: <20240124202731.39212-1-clamor95@gmail.com>
 <4b77da9a-9700-43de-a833-14f809e2919b@moroto.mountain>
 <FDCB4AEF-9106-421F-BB9F-16E2339B2148@gmail.com>
 <20240125141236.GI3652023@bill-the-cat>
 <389188F7-7622-4109-87B5-7B136BAEABB9@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ow9IGzoRx53xGlRL"
Content-Disposition: inline
In-Reply-To: <389188F7-7622-4109-87B5-7B136BAEABB9@gmail.com>
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


--Ow9IGzoRx53xGlRL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 04:16:11PM +0200, Svyatoslav wrote:
>=20
>=20
> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 16:12:36 GMT+02:00=
, Tom Rini <trini@konsulko.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=B2(=
-=D0=BB=D0=B0):
> >On Thu, Jan 25, 2024 at 08:51:09AM +0200, Svyatoslav wrote:
> >>=20
> >>=20
> >> 25 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80. 08:29:54 GMT+02=
:00, Dan Carpenter <dan.carpenter@linaro.org> =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=B2(-=D0=BB=D0=B0):
> >> >On Wed, Jan 24, 2024 at 10:27:30PM +0200, Svyatoslav Ryhel wrote:
> >> >> Currently, if boot with extlinux.conf and do not set the fdt
> >> >> U-Boot will provide its own device tree. This behavior is
> >> >> beneficial if the U-Boot device tree is in sync with Linux,
> >> >> but it totally halts the booting of pre-dtb kernels (3.4 for
> >> >> example) since it uses ATAGs. To fix this, pass `-` in the
> >> >> fdt extlinux field as a signal that no tree should be used.
> >> >
> >> >Passing - doesn't seem like the most intuitive thing...  Is there a
> >> >different argument we could use?
> >> >
> >>=20
> >> I agree that `-` is not the most intuitive argument,
> >> but this is a way to implement a fix with the least
> >> code posssible. To make this less obscure I have
> >> adjusted documentation.=20
> >
> >It's also how historically we do similar things. eg, "bootm
> >$kernel_addr_r - $fdt_addr_r". My question is can we re-work this,
> >cleanly, with guards around SUPPORT_PASSING_ATAGS to not increase size
> >anywhere that doesn't need this legacy case.
> >
>=20
> Which behavior you propose?

Well, using the IS_ENABLED macro with the new tests around "-".

--=20
Tom

--Ow9IGzoRx53xGlRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWybX4ACgkQFHw5/5Y0
tyw+RQv/ftL119A133/fSb2FV1vXE7BYYV+caoha6UJoyfD55KALC5olblo7CYA7
+RhjQS6klR/FD9EnyB3VdywSmPZ3dG/eJbgdA1MYmRr4XrW8/EFPU2guNd1YraOc
pdEvM4ncrxL2TeFHQvnkiKknavz8EIvrltSzaAnUKNGkdLNBOckVTbLohuI2o1W7
k4zeul85Hb6zcLcNFWgsL1bPJf8kNOYo/ZOAS4tLOpL2K4Vkcd2djQFZQnsfI9rb
5/FGotkI7ShairHOS4W7MPQwGzioOVO5FOJhMZW968+ueMxeJSYLS/eboPVUss/9
4WnJXIX9YPYlP2MpQCzjFppW897UeYcLvZlBzQ2NXDePy1T0AFneDY5M0lDL+7E4
BLzfFpjk4K/4izpzss45Jp7yhLlHIo50Z2yMw8vNhIGvPuN7q4ZZEs0XtBBj9Adj
+37e9heUVU0saUJ45koz5BTR4fISauI2fXVxyh/2rp14LntRi4suoXD6+Fv+HRtu
8UZD11TP
=QfuB
-----END PGP SIGNATURE-----

--Ow9IGzoRx53xGlRL--
