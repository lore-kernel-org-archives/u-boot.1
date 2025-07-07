Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A685CC83030
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 19:59:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5355831C3;
	Mon,  7 Jul 2025 21:58:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oT9JNSiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F516831C3; Mon,  7 Jul 2025 21:58:58 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249238318E
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 21:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ebb72384dbso1063268fac.1
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751918335; x=1752523135; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nCy4pexkQ6n3QFa8O+2bN5C7QwkeLOFBFYvU+KCiIKE=;
 b=oT9JNSiFAsebOnWaISiQbcVIq0HEiiUSlyiTKzu9ly7jZjNHg863Ctn88p9nFlhkam
 tkC+ruL8YQbZ6Qp47/17GoUiASVEkTY2jGKVL4dQRWcAQXuwF0ETAuS6q7ecbsYPiz8j
 hxyp/SKg3wo09y7FBTZL1GI+6ClkmjDtupFwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751918335; x=1752523135;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCy4pexkQ6n3QFa8O+2bN5C7QwkeLOFBFYvU+KCiIKE=;
 b=ioSy2FbTBJ8r2tmOjLc+1RA1YUzLpc3ZPrMz1ABWvw/0eyjhIBd84Z826bCgvbkD0n
 4kcEe2VvXnlLL1dVdnfeFQy5uKQags09oF8+0I4rJdy5QyLyGcz37TNkxhD11IMncsRG
 w5aZKLRhq6I37QApq/YNAqXNfguTV55REIjsFFar8/+GlCqzcgwqw/1yCGWjDqEwXfKX
 XX2LOslsRzMhp9soGxQknHMeZCUJlTtKX4VACVYbE9uQooOsWOxbdxej2i+wyDrCECpt
 bVFRCDhAOu29qe2PoxkvxpxoPs8dkjNsl/XSOrHPa4szmAsapxfrGfWXrnEwu0mtsf78
 yu5Q==
X-Gm-Message-State: AOJu0YxA2NUD0Fy7sC71U4QW1PnR7RG/4XzEooxg+u0JD2DaVZ8mHArt
 wgWqzM8tsJitK54cxqUoHa26BBru4LdXSbvcfsp2RRYYKV4e/fKE5IkUyC9ghktqTww=
X-Gm-Gg: ASbGnct8jeoroEJ48bOhUwvW2r9sK9Tys1J98aAgSuQUUPKXehofT8X4yqidffiAMKV
 rE6DN5gKF7qkV3AOLBBOea2eNgz0EenLY4K/7DujV8JfcnezAZw3RCd7HRyQHAMbMRps7TA4JRo
 0sJBcll8VO5hytc0qBKuTja64orVArUZg/2AN5SompOWGqSWDLPWRXrNGX6V0ZOfBcjOkjGzLfS
 F23nKgkiWIgi8cA2o9VZWt2WDh1EpIvWrcy7+12BCj97DimBuMnswmEfO9XAW62M1ON/n+DMBmM
 H2VkaZOsDdZty87YOEYhvmh9oHTzBT3VeLgAvfXdtxMlVLPrl/n0GePliwxMGCHmk5r+Yho81iA
 8KF0wpNEX7T9pLFGpYBO6
X-Google-Smtp-Source: AGHT+IF489tt0Ogh5gr2NuCEfMXqN5bmw1pmKWfCOrc54ee5v8SiLOn9HpSdVuQEuLv3+jMit053rQ==
X-Received: by 2002:a05:6870:328a:b0:2ef:e245:c65a with SMTP id
 586e51a60fabf-2fb6c413bd4mr419310fac.38.1751918334821; 
 Mon, 07 Jul 2025 12:58:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73c9f751f0esm1680167a34.21.2025.07.07.12.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Jul 2025 12:58:54 -0700 (PDT)
Date: Mon, 7 Jul 2025 13:58:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: PCI config read functions
Message-ID: <20250707195852.GQ6424@bill-the-cat>
References: <3df65973-626b-4894-84bd-5a03a19032c2@linaro.org>
 <20250704205905.GL6424@bill-the-cat>
 <2ca9c84d-5b07-483e-aeac-77b9fa4df4bd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p8zex50fgatjZE0c"
Content-Disposition: inline
In-Reply-To: <2ca9c84d-5b07-483e-aeac-77b9fa4df4bd@linaro.org>
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


--p8zex50fgatjZE0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 03:49:51PM +0100, Andrew Goodbody wrote:
> On 04/07/2025 21:59, Tom Rini wrote:
> > On Fri, Jul 04, 2025 at 10:53:55AM +0100, Andrew Goodbody wrote:
> > > Hi Tom,
> > >=20
> > > Smatch reports that the callers of the functions
> > > (dm_)pci_config_read(8|16|32) from drivers/pci/pci-uclass.c do not ch=
eck the
> > > return value for an error before using the variable that should have =
been
> > > assigned with the value read. However in the error path that variable=
 is not
> > > assigned to and so the code can use an uninitialised variable in that=
 case.
> > > eg line 1396 in drivers/pci/pci-uclass.c addr may not have been assig=
ned to
> > > in the error case.
> > >=20
> > > This also seems to be the case with callers from other files as well.
> > >=20
> > > Would a patch that adds a default assignment before returning an erro=
r to
> > > the affected functions be accepted?
> >=20
> > Can you please check the size growth on say qemu_arm* and we can go from
> > there? Thanks.
>=20
> Size info from buildman
>=20
>    aarch64: (for 3/3 boards) all +26.7 rodata +2.7 text +24.0
>        arm: (for 1/1 boards) all +16.0 text +16.0

Seems reasonable, lets go this route, thanks.

--=20
Tom

--p8zex50fgatjZE0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhsJvwACgkQFHw5/5Y0
tyz0twwApXY522wW6AUjNvVbIDZ68GRVWtHbmKVOVdQEM0L6XHvpX1kCiikWBIAH
NUMWZMMm+wDtbpOFB01G4RliBZQFVjOcPVNUT4XxxUf3Te8o/d+/caAovvYbZ++i
Ijvoj2HLIeszDRMU77L5G2aNkj6k+357AtyCVjUTr8zIHrk1hf74mP7kOxrYOyzs
vxXIN9xt8uZmMx3SjtxwYLzJdCFLhK9MV2I/7MNpADJq1C8EpB19qYRwPeFfoRaa
Z3Tmi/Bwp8883ZnW5R/UBAgRp3KQTrgwMTOsDcTBXxdz5kozUBxjfNPbYFbkPjXq
nXeXPAs6xBVB3fLXFLRjthZzBu6gZtSs8yfyegIF2U0V5BcKJfKQ5XNmCaj4QEnB
6JubQOn7ms/tbTAVVdB4aN/+KTTffv2OhbqiVWwG7u7TKrzsoABzAY3JQHEgxM3+
pz586eaIrJXQJZOCfZbdlNKxtOKlrrfrL8JlZ57DypOIdWH5o7038WG1dk6J6rB6
2HOm/rgR
=THKg
-----END PGP SIGNATURE-----

--p8zex50fgatjZE0c--
