Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6B7EE14A9
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:54:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3927869F2;
	Thu,  7 Sep 2023 03:53:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="itd9h+cl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB31869FB; Thu,  7 Sep 2023 03:53:29 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067A3869F2
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so5858547b3.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051605; x=1694656405; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nCmcv06FnqYNC+qIgvlOPNeIGFinM5cRJwZqrWcFeJE=;
 b=itd9h+clp6Ds5/YkwDvNbHgCXN55RH0aO4D+jNckaNHfCZVqIz/ea3YEqqNFufvPPt
 9PiwYCl1LTSwCNeb6ADFddUU+3qIIcT13dCjiaZc44Xy2D7UGPGMuE0lGkYNd1e+uAT7
 W3b8n8DyNP0Ri+w+mZiMxObdf0waLbTOmjy6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051605; x=1694656405;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nCmcv06FnqYNC+qIgvlOPNeIGFinM5cRJwZqrWcFeJE=;
 b=eT8jhuuqlUxjl+zAFrk7nc7lt0zQkmHUZm2LWVmmJ3AcharnxSvrA6/xdKzNRow1Kl
 v2J/oIZZjlhg9Dm53ajLKHh3ncaf4MRZRQXMhQqRiLEHsa4imsTnt7OCAOIb7PrdS4nW
 iSrgeulDAg+kKG5zIkdUeZ/+jqIjtSm9rmIz7Pd/yyWB6SvXyJMA7x5G+4QvAYUx3+Kv
 V0OkfkJWh3EwuuuA5ifpuX0bpm3BpFibyw+XYpQDj91GkLdNc2xcZrOw6N1b8Y8L5OX1
 9JY0yDIU0fWfTZ8qSm3RE6RvlDkONKu4S/322YRjmvvVxuzxQdOA8jdtgtr8THP89SRY
 41Fg==
X-Gm-Message-State: AOJu0Yxbm8vUQWDKsY7j+6pvPEyjkyOkESZi9chBOKldKTPuZh2+NDiC
 D13aIgjl6maQ63CrZgJ1+03ZAky3l0UG4CRRMr/yHw==
X-Google-Smtp-Source: AGHT+IEoDPVvGLe8IJQTU21RMqOTnaNDqueOxyngPuvmL1lFl1WUkTHNNSvXbgcfQHDZlJoSskarrA==
X-Received: by 2002:a0d:dfcb:0:b0:586:b847:5ef0 with SMTP id
 i194-20020a0ddfcb000000b00586b8475ef0mr1641646ywe.4.1694051605646; 
 Wed, 06 Sep 2023 18:53:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a819c05000000b00589c103d00asm4074919ywa.79.2023.09.06.18.53.24
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:53:25 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:53:23 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] Azure: Split sandbox and qemu test.py runs
Message-ID: <20230907015323.GT305624@bill-the-cat>
References: <20230901204143.3617876-1-trini@konsulko.com>
 <20230901204143.3617876-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oWlQqM/ZmMxPDSPW"
Content-Disposition: inline
In-Reply-To: <20230901204143.3617876-2-trini@konsulko.com>
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


--oWlQqM/ZmMxPDSPW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 04:41:42PM -0400, Tom Rini wrote:

> Currently, most sandbox runs take a long time (due to running so many
> tests) while QEMu based test.py runs are fairly short.  Split the
> pipeline here so that we get more consistent average run times.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--oWlQqM/ZmMxPDSPW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LRMACgkQFHw5/5Y0
tyz0zAwAhZ8Ov34SKezq1/jAtHupimFMu1m0y4uekvq0nIMCarP0xTTZvnS07oKi
vdYML7iRtADUQ/JhGfN4OfMum8aw33Pkw8psIpeL4KjVcVB0NrkArKEGS7/Xh7eU
PR3FcdPLSG5tSZpPum5I7Qvs13tLryBgXb2PcXIPPNxNywc/Nbc+djkwuNU512l1
1LEN89ZVVUaBu6FC02cTNJDsAOWwjnmbw4vKml1ir1rdbYqLG5uURsVpdE6V6k8y
BAuesu3FJkkkvF6OfS/nwQaNn13wrnPesQmGY7MSesw9seAkUXWfltqlvfVRI4em
d1G7jJHXmbnUnKqQkBj76JCyhQqjiHKfvXTf8FpCviRMx86Ob9Wf5s+rQ9FpmAk2
AqqLoN/Iw51xL5FHbm7g1RMHBhN5jwLMDAhamsXLKJOpaaPVDmWPMDFMFl+B6IL3
msB4yMB9nxQRvPCHR1rav32Om0meDbdz2nS8uBrAcEKJZ8FwAiuSn4yF2TlMkLaA
rjBPlPdu
=Etm7
-----END PGP SIGNATURE-----

--oWlQqM/ZmMxPDSPW--
