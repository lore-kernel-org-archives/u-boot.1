Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE50C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 16:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21BA482104;
	Thu, 30 Jan 2025 17:59:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ilqyoaru";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1069882114; Thu, 30 Jan 2025 17:59:36 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7FEA8820F6
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 17:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-71e36b27b53so578172a34.1
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738256372; x=1738861172; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JtN02xtJ+vdqI3gjCbrr0mpJd5Slk72MveYL8e+ftmI=;
 b=Ilqyoaru4u5P+4rebvGWAvjcnsgdKqqulFg9mLiQ8FZKcfj/91i7z98/1lKt7WMmEe
 1eua9+2HbFz9X+A1lYx2V0rX1a/X9Ltb6Xeu/LIr5cBfdFCfFrlsBbKI2gfZZMZTnOaI
 L3igcq65R4jqzAWVuq7AWw7nmsCnmelTqmvuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738256372; x=1738861172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtN02xtJ+vdqI3gjCbrr0mpJd5Slk72MveYL8e+ftmI=;
 b=Gkb9Or87RcsFqCHoK1KRMKHXResqqeEKoz5hO9IRwP7B2oetGt5zBynxQrS+O0L64b
 BLnx3qymqNrBfD2nYbutAYiui0ZcKXQoG2EFql0nu5NknZRXwsoBUalBIoOi+NPqN6oN
 AFRMDmLdcrDGV3Ndim/R2niXn2Nsz29Hxd8CQZWEId+dFqSGCgGnlZo9eiwLU7rfwirs
 dH0D83xwjDJsIHyAXuixTisXPkpRH9/lsCPRoqW9iwE2/lI5jdwUlyRf+PlwvpdjpXWp
 JPIbd0ut62t8GvbyHYPOV0SkOtJgMezckfdRp8mitRtsvcag26Si5/mS1Gbb36e+fW+R
 gsZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9MUX57Oaky8q+FmlTmjKfg5F/e6kBCuVMw7Us8dhIO/WXDbphWOQ9EEab6FRCcUxUxAljcJ4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxa764iD7KoxBzLPwzPr+B0oJo1crXM3iUDJPG0m2MJnlB1UFsq
 qEHQFsw8BWCKMtBWWtyyk0XpvOY+vlpNfPcaDzMk1YsAAzLDYTfix58R3E1iXY0=
X-Gm-Gg: ASbGncu1eMqxLwumYH/7G19KCR89ugItSxq5GGgMfhKQRvRPAP/7MonCUC1jB42ojZY
 n8JypRnI1XfR4dAGj6Rty4A5o50xBT6ghq4Esg6CN4nXUhS2YXVGjU+5YPFMf4AEcbE8SLl6322
 juX338xDTzzGgT+HMZWPA7t0vGjWool3ASuypj3WRlb0nxr3uotjMnGzx9oWCFpZgxbXwwxIaHK
 vQnTu+Gsu5O2t2ywHcMuqSr972KPxrIHCi/Lx5IgwmdCouo7wi310R5RzM3ldshsqh8tkvJE94p
 H47ssM/qWEsQJbA=
X-Google-Smtp-Source: AGHT+IEe9M6M3thq/+64o1GsGbkhv5dwHEP6nTzPedlr1ZJr+q+Nez7b8dmG88SRgphvKyD7W/H+hw==
X-Received: by 2002:a05:6830:700b:b0:71d:f9f1:7f3a with SMTP id
 46e09a7af769-726568f915bmr6028743a34.24.1738256372238; 
 Thu, 30 Jan 2025 08:59:32 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-726618c8a96sm391689a34.66.2025.01.30.08.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 08:59:31 -0800 (PST)
Date: Thu, 30 Jan 2025 10:59:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: make tests skips the DM tests
Message-ID: <20250130165929.GD1233568@bill-the-cat>
References: <92438c16-1b8b-4e90-a44c-285140f59f0f@gmx.de>
 <e3ed313a-847d-4307-8c58-f40e8fcee86f@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ODpiunFMJKt6Uxp0"
Content-Disposition: inline
In-Reply-To: <e3ed313a-847d-4307-8c58-f40e8fcee86f@gmx.de>
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


--ODpiunFMJKt6Uxp0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 08:32:28AM +0000, Heinrich Schuchardt wrote:
> On 1/30/25 08:08, Heinrich Schuchardt wrote:
> > Hello Simon,
> >=20
> > when running 'make tests' locally I get:
> >=20
> > test/py/tests/test_dm.py .
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > short test summary info
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > SKIPPED [2] test/py/conftest.py:625: .config feature "sandbox" enabled
> > SKIPPED [1] test/py/tests/test_bootstage.py:39: No bootstage environment
> > file is defined
> > SKIPPED [1] test/py/tests/test_cat/test_cat.py:8: Setup failed
> > SKIPPED [1] test/py/tests/test_dfu.py:114: got empty parameter set
> > ['env__usb_dev_port'], function test_dfu at /test/py/tests/test_dfu.py:=
113
> > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! _pytest.outcomes.Exit: Lab failure:
> > Timeout executing 'dm drivers
> > ': Marking connection bad - no other tests will run
> > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> >=20
> >=20
> > Shouldn't the required boardenv_* files be generated by running 'make
> > tests'?
> >=20
> > Best regards
> >=20
> > Heinrich
>=20
> When installing all packages mentioned in tools/docker/Dockerfile the DM
> tests are executed.
>=20
> What is missing is an error message which package or tool is needed when
> the boardenv_* files cannot be generated.

The boardenv_ files are not generated, they're configuration files.
sandbox does not use one today (but perhaps a few more tests would run
if there was one) and at least for CI we use
https://source.denx.de/u-boot/u-boot-test-hooks

--=20
Tom

--ODpiunFMJKt6Uxp0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmebr+0ACgkQFHw5/5Y0
tyw1Xwv/a4iCiojOuZnuKkJJQCfqWcrwLRdjKqAq1yQ2b9/b0B/a//SLKLP1d8IG
GwNw6mAFqZtkjkFA+C2wJlkpisNeXwdCZrIlrZ/43dJqgxT+25w4nU6QKf6p1gRA
iKjQEPajKxGrApvNDi/2fnFUTvQujY6AWQjjxMlaFks4uG58x4ixxXLPLA8HI0se
iPPzZQDzTppYttE4WMSkW75AXYkRBjfOIWNSaAEOImnkzOW1yJC+GK3lzgJrcZhH
V5JXLb7rhJYqMqA4qpoqAX/l+raARhVKm/U5OEp+gva2xCDo5GfuYYsad5A6Zqo7
4pR6APl1TlODe51km6gjRbpq9nJbg0jj4eBL7s8BvmgFz8ep7rHB+NSAHk6yNdAp
+epgx7x1TM64i+hA8DuJ4xCNZHl2ggvSJ+ZDOQGV/g44J9EJLetQpZK1qnAouwrc
yHs647IlRzVxrYChxfUYqQWm6RT6huX3PhtrVBm2uc0U1T0Zay9rXJB2A7gtLyfw
BT0OfOMg
=WWod
-----END PGP SIGNATURE-----

--ODpiunFMJKt6Uxp0--
