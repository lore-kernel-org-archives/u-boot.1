Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D984FC5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 19:00:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0B182145;
	Fri,  6 Jun 2025 21:00:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dxaty/Nf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F0C807B1; Fri,  6 Jun 2025 21:00:50 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAA0807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 21:00:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4066a0d0256so1638164b6e.3
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 12:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749236446; x=1749841246; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gPvncmOqLY/v/Alwt+56FJAr70RWcicvsKkWSbxVvkI=;
 b=Dxaty/NflwPHooHzD9mxNvL+aXc6kE9okiOL2OiypWYnXFwea7GI51rAoPlpxrcTyo
 ynfFRMEaWQXyv8jfRr2utIEfvOfIdQzfZNry7XKbyxQ1k7PWboV3xLQiS72VcLxT4bMx
 2BWb6Y/w75mUoiQ8+tgxGAnWLb2rCWu8G6zZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749236446; x=1749841246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPvncmOqLY/v/Alwt+56FJAr70RWcicvsKkWSbxVvkI=;
 b=d+ESon0mv8/4fiv1RDWh2zKqHQxhENJSKw50kMN3ffvKvW/V59UhsGtrNrO2WtslqE
 s5gMJ6GBe1nRBzQ4HmcXmc10HPO8PHsdU5PFmkzMuB7CzcOgmR99Nj7G2YBVXQZYW2Zt
 imkO/KC5qhppuvPXiMKVz/PemU1oHk/iN1lrw91LLoPDMvIby3ujcSyZsy2LCOKhFjGM
 o5NvMu+KRP5zB3yAFA5DDNE1anGzlVmc6St2qsMMhppBspLGYOhJ4RoAlAfQ3qKpLYp+
 3bIGOiCc3dUAwCxkwCJlGD1v2Zz3ds5sS0grbjOVo3pgqdEMuIel0TWREwl3EgGAgkb+
 Ez1Q==
X-Gm-Message-State: AOJu0YzLd9L3arDwLXCsLR2H8KaB0+MqSIcrOxwhNo6rZ5so+wRkVGHQ
 G7KENi4OnfgkcWEsgjZI5X1ip74fnbWLEkt/7/wSHlXiM+8qViPssFFvkfpLjPI/l7Y=
X-Gm-Gg: ASbGncsxmKznB6lReLAWMZpYL1HbbL5JNgLH9fov+PrEtPKqsa1tN0AuqAVziRyNh67
 sEK7hmpyL2gqqtGqXo6DMtEPsp5IRp27weVTaam0cm0om45JUKSWfA1wNF5Yi0m8XxADL9rS0EJ
 zNODyCpLcJSLN76vjd+FnVw3Oqk0Muowb/pfwoZrm2IQcXA0kOCe2kEfjfiVa9wlQq4e5W04OO1
 HeKd/PbCwvASMwb3AQMOmP/xPZd3QVu9F7yjlQa+f4VDs9T2R2hGpSQVdrV+qBBn+YSvfcx9YI+
 vCJBe+t0q5WaD2Xh13GgZ53CCPt0JXX0eed6C2VV19RtPAfUUh3F/xC4pl3itaeZaz1JEBj/mI4
 9o0cxr726PD7J+vgA3ZP2K8E=
X-Google-Smtp-Source: AGHT+IHEwZiF/cqjURm46HfrWkvDaacONTgKfnHcmnfGLFScp0gZ5EsywPWziqIMCz3n9rZvgc8CZw==
X-Received: by 2002:a05:6808:3999:b0:409:5d4:6371 with SMTP id
 5614622812f47-40905d465e8mr2788500b6e.34.1749236446209; 
 Fri, 06 Jun 2025 12:00:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-409069448dasm446713b6e.20.2025.06.06.12.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:00:45 -0700 (PDT)
Date: Fri, 6 Jun 2025 13:00:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 02/10] spl: make CMD_BOOTZ exclusive with
 TI_SECURE_DEVICE
Message-ID: <20250606190042.GY1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-3-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5JTDsT4P1yIt49hN"
Content-Disposition: inline
In-Reply-To: <20250603142452.2707171-3-anshuld@ti.com>
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


--5JTDsT4P1yIt49hN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 07:54:42PM +0530, Anshul Dalal wrote:

> In the secure OS_BOOT spl execution code path, CMD_BOOTZ enables loading
> of a zImage which might allow an attacker to bypass the authenticated
> boot with fitImage by replacing it with a malicious image with header
> identical to zImage.
>=20
> Disabling CMD_BOOTZ ensures this code path is never hit inside
> spl_parse_image_header.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--5JTDsT4P1yIt49hN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhDOtcACgkQFHw5/5Y0
tyxaqwwAqaJ+wbRMOxOgv6V3oYFAy4gS9YX/sxEdCvS1JUIQKcxE6IPy2DISuIGm
gXoa6PiA8pQRwap5i2WwTOxiXAW9fE8BaJMa1xB42jFO1FAtmRiXDqzGZYKi4bHq
Nk9rOVOKPiVQs6rR7aPmbI/zFtX+zjPrJcWk+XvxH+Z/CZ9rSFpw1N+RNf4qNEXs
JpXIn8DWMEf+glfT64feYR7ZfXoj55wnxnkwSd7P2TBavSvTPuqmniIeSWKNhaC6
6KcTLs/vhKJZZVdqy+vujc53Ulx0/e5/uxeEkleNoaG+SPF/7PzQhYaqJfZ3blmp
z1/8Ks0Qs/U2qMO22zPvZy0kgfJO9dc9IottmCGTdJPGRGmZnRP4LUb30jVHFXYW
++wY3EyXYK5If0J0+Fa8hf9w5fts3QCICyxjGECp4y8hluVF6RQMpwYXwyeF/DG2
bD/Cb8V5UDigDSGajv36XmwEcLPhQ3RXj3HvqhIJ1+z6y/uoYDHvEKP06l06H9hG
pgWRksm6
=VwNb
-----END PGP SIGNATURE-----

--5JTDsT4P1yIt49hN--
