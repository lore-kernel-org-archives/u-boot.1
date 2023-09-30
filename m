Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B588E77375
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 14:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D27686F6F;
	Sat, 30 Sep 2023 16:44:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NRsGl9Rx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B8987018; Sat, 30 Sep 2023 16:44:11 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F5786D63
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 16:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-59bf1dde73fso188881207b3.3
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696085048; x=1696689848; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YUCTYMmmJYGqXI87oXqpiz066KnomxqLaVexjz1rahM=;
 b=NRsGl9RxF5cS+BoG0iohAUntMRP61/wj4uAG7Kv5CDmOr3KC/e/YiEFIerM7SJgKeM
 frvwEyigzrMnjuz9v+124oUgltBMCiXJlLmsob4MyrvHrlyRa8bCUXrlP6q/isUYl5J4
 49AIcR4DG9AtfkS+kulIkqGtsY3ZnY5fW1BRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696085048; x=1696689848;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUCTYMmmJYGqXI87oXqpiz066KnomxqLaVexjz1rahM=;
 b=twUbPMj/emel2GuwfLNYq/9Mn7xD/fM5wjbdjYZ339bPqBP/4DjmODPTALdeVDeQvc
 lkzzRPcpk9ckZHYVcThJqQiEyGGOHqjzWG9YVxFvS55rUKRP9DXooejFjCcP8MRBnvS3
 1YYsQgjglhDYbYWkcMcCQsOf9CFrtWgdwQOob3B8eAZvdGSyAzTkZdp03BjL5BkO8cWD
 k1BB0ARLJVzPM8irO65wEY4004BW2Dg5H/3S/ZF8GU8hciWB9IRygnPesDw2Mf56P9TP
 jkN8ZgkCVxX9ScjlrSsSQnMh0zGb6k6iD2AM+Ux1miai7hYWV23fD44Fm6001ALsybZs
 Zw/Q==
X-Gm-Message-State: AOJu0YwocC2TSaLFU2FMTWz4yV99pCfKX3vYxEu9n4YX6Fg28sD9bgrD
 Gz29FXWclWzVKzik34ntScJu9Q==
X-Google-Smtp-Source: AGHT+IFRgDdCRpVzFyFbNj8xrBdB3mDA6aAoY22t6Ld3fm53uzT7RXf2OW1HtVnb3iFJdWJdcnXGOA==
X-Received: by 2002:a81:5cd6:0:b0:577:1560:9e17 with SMTP id
 q205-20020a815cd6000000b0057715609e17mr7163825ywb.35.1696085047674; 
 Sat, 30 Sep 2023 07:44:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-018d-5d59-64ed-f6e8.res6.spectrum.com.
 [2603:6081:7b00:6400:18d:5d59:64ed:f6e8])
 by smtp.gmail.com with ESMTPSA id
 c13-20020a81c94d000000b0059bc0d766f8sm4884434ywl.34.2023.09.30.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 07:44:07 -0700 (PDT)
Date: Sat, 30 Sep 2023 10:44:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: "u-bootlists.denx.de" <u-boot@lists.denx.de>
Subject: Re: github dependabot alert on py / pytest
Message-ID: <20230930144405.GQ305624@bill-the-cat>
References: <trinity-bf8ba9b5-b264-497a-b0b2-6af0ff5c1a7f-1696079610910@3c-app-gmx-bs36>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="c831AGuSK3YJnumK"
Content-Disposition: inline
In-Reply-To: <trinity-bf8ba9b5-b264-497a-b0b2-6af0ff5c1a7f-1696079610910@3c-app-gmx-bs36>
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


--c831AGuSK3YJnumK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 30, 2023 at 03:13:30PM +0200, Frank Wunderlich wrote:
> Hi,
>=20
> dependabot reports a high security issue
>=20
> https://github.com/frank-w/u-boot/security/dependabot/1
>=20
> it seems it is not yet fixed in master and next as there py is still in a=
nd pytest=3D=3D6.2.5
>=20
> I have not yet seen any topics for this...are you aware of this? I know t=
ests are run in
> isolated environment through gitlab-pipeline, but maybe this can have sti=
ll a risk.

The dependabot requests aren't public.  But I don't see one myself when
pushing to GitHub, can you please elaborate on what it's saying we
should have updated?

--=20
Tom

--c831AGuSK3YJnumK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUYNC4ACgkQFHw5/5Y0
tyyZGQv/R1nSZQqsWqY5mEwlwWzDXe0YUdv8h+0d0O6t7HkSS9JmFuMWhrRwnHe3
yvFCFvtRxDyTlR6kNMWIlFzSoYJ92HDdPApA5UFUkgIJpwvF9OvwtjPdFBd5fZfG
fue9XtMUwBsytTEACHBG5/E7NFEMmFwHSBH8DZ2VToIlGsKjLsFY8Rcpzifoy8ZV
LQFnrK4JWp+b4wcsCOFn+N2mVT10iFR4PIQvx2dFn0IRpqLXyKi3K5A5aBIcUWvN
gkIe+zOvSCEb/WmqBdEB2kwicYuLDwsdDZTeJfMeuY96EHWtLvE+383Hp1u3/x6E
K6BJ3M6CvhNHEcuioib2Q82MOA0i9EImEFxWZvVSs+pdzFCnVi8Pkz8PwGBVwWPB
1hQzIRU1VTeq1E3nBnIxvgO2wWtCB/Fk6jI/hhsVQLYArUQ+q60tagaGTayJ4RyU
KJ53YPiCPnbTYTs1TCC7y/LSvG4xVWu50E1pg6NRkhz7l14aruX5a4jnvKY3110H
2drPV6WQ
=GQ8j
-----END PGP SIGNATURE-----

--c831AGuSK3YJnumK--
