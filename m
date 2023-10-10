Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A2DCD80CA
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 12:59:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3F9986BF2;
	Tue, 10 Oct 2023 14:58:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UUW1Icp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B68386C53; Tue, 10 Oct 2023 14:58:12 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D5D186BF2
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5a24b03e22eso69026427b3.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942688; x=1697547488; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1tqFD/+r/Ypj0hSe9vuXpcjoBzgyvF9eDTWKZv3GfPM=;
 b=UUW1Icp100L/qCMn2E3o0svAyRlZo+XTTbCJ4m8iyiDrTl0yMGV53A/F+B7M6ddpKQ
 aKhgKbHIFCzSX1ZHq06mwVMdAXPXvbNqX6jZIfYNhpSDGtJ+FIE1VvdtMLjy9hhZMRb/
 pcRB+ydJ6fStQ6V8vse8nulB8cC91ghyC7yS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942688; x=1697547488;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1tqFD/+r/Ypj0hSe9vuXpcjoBzgyvF9eDTWKZv3GfPM=;
 b=SXNOf5vFB+9o0ZQAk3FohtH7Nw7IUqX9eeocB3lORqWVvcyGXgTL9G1C4G+1nEJfUi
 zrUKi++k9nx7FTiNMA1gtLgSLWviOb3ObBiOEe9VSlvLi/yi0jPgTI2jg4p6ns0zQqai
 9h02KEh5aP5AJZDTOudWHa1pT8/IyetzQr2BbDUirNz+ga5pPdsVdV2PLsn6AzjLoZFa
 JS8JO43WMNxChfsaSMjEKlPBj9R0DHbSNS2kEgYtjw7Dnb22lZVLH3z98sEd87sclOm0
 v/qI9QS+w87ffnKfZOm340buSbet35otDR3ywBA3W1c32OvWM+u769AFYYMUk3VVma7R
 xmfw==
X-Gm-Message-State: AOJu0Yx98bUYpe83qF2W9duBy9BN7opqtlMJQUW0BgY7OCs6EC/cboU7
 nfE65p8VNjvakHMWBI0avwpLWw==
X-Google-Smtp-Source: AGHT+IFUP4IzdmdLcDB7mTEZ+k/hO1iPKVgOWvzirHBag0/BmCCAv0GAQguh2ah/xkRqLpOubjSBFA==
X-Received: by 2002:a05:690c:2a81:b0:5a7:c777:2be1 with SMTP id
 ek1-20020a05690c2a8100b005a7c7772be1mr824396ywb.11.1696942688366; 
 Tue, 10 Oct 2023 05:58:08 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 fv3-20020a05690c370300b005463e45458bsm1673533ywb.123.2023.10.10.05.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:07 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] Makefile: Force regeneration of env.txt
Message-ID: <20231010125805.GW2227687@bill-the-cat>
References: <20230915144323.76660-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4v+bFaR1na86rXWX"
Content-Disposition: inline
In-Reply-To: <20230915144323.76660-1-afd@ti.com>
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


--4v+bFaR1na86rXWX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 09:43:23AM -0500, Andrew Davis wrote:

> If the source .env file changes to one that is also older than the
> generated env.txt file then the .env file is not regenerated. This
> means when switching board configs we do not regenerate the env.
>=20
> This can be tested with:
>=20
> $ make j721e_evm_a72_defconfig
> $ make # this may fail to complete but that is okay for this test
> $ make am64x_evm_a53_defconfig
> $ make
> $ vim include/generated/env.txt
>=20
> Note this is still the J721e env not the AM64 config as expected.
>=20
> As ENV_FILE is set based on configuration, regenerate anytime
> autoconf.h changes.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--4v+bFaR1na86rXWX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSl0ACgkQFHw5/5Y0
tywgKgv+JPHUxevZUKsG/Jj1sCMC70L8IAKTQXTffFxrBh3YhkYabCucmxCvwVKy
ZzAoEb3m1g+ZtGCTIfa1eucFFSTU44O8HslwrcWL5x8BQFhrIpulCegPdhWAZhfo
PEiD5HzFbyJhZ4XCpjdhR5CXwDzGiGoAN38ikCaeVWWUcSyqZLYeX1n9umyATOcj
3tN9/0SwhjHrqEj7cIsqPYUMt1PFiGJ2V7MIZAEPMp7Q8XimSJk+Au4sC8LLzHO0
AjvZA5rXthVo/gcpBHPlLcsZ/2niEXQMy2M9JhtoXEAZzXSyEqf1Hfiq8VBd1avY
3R5hAXqRcedTgVK4vM8rM5eEPHpArXlhgH1lXdad2yXADV6cim79sYBRH4c//sns
CtZr3vSyQ9kxfJzxs3v/PyqGs8z2HDZlNnKXOfYdkzLarlCT6GShlchSznl+i90E
DOgcXwghOxiy7M1+89VXi3eDr/IrfaY5eDnjpbCoqnSDbfF7WKWZJFRbiwEjkcMu
yDlIHfuD
=5LLo
-----END PGP SIGNATURE-----

--4v+bFaR1na86rXWX--
