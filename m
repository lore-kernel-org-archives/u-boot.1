Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB2BAC6FD1F
	for <u-boot@archiver.kernel.org>; Sat, 30 Mar 2024 19:36:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C2C88299;
	Sat, 30 Mar 2024 20:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f4vKMycP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FD748829C; Sat, 30 Mar 2024 20:36:13 +0100 (CET)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E87F888294
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 20:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-60a068e26d8so29866957b3.3
 for <u-boot@lists.denx.de>; Sat, 30 Mar 2024 12:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711827370; x=1712432170; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=860Jtg+TsYrMGczUxdpW8QsyHA2ukHWvyd1Siqnj/6w=;
 b=f4vKMycPgX6BnH1bLO61PS/mr+e+ztpAcu0ZPRqorBj96zBzVVWkWt86pdVvPJT0Tj
 eMgu15wmrwz6c6Oph4j1gHj6LNbtvIiWiotuW5Oqb+k0gAi1te3PdWNCUdds/e3PZtCf
 L/TPRMK9kR6DG+B9limd6+A/jFb8pxBaaJgfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711827370; x=1712432170;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=860Jtg+TsYrMGczUxdpW8QsyHA2ukHWvyd1Siqnj/6w=;
 b=OEiYWPlWLx5ANpEsNal5j2XfN+AAfp2qP7YaYbsmSu7g1NubTwnT308If4dGY80UYk
 e440bRCpRtXwlc1aZZg8HnUOMlNVqiuVEL9/1pXi9Pcm2rQLE0L+sCgFzTOaUggkYTE3
 V20r9HoW7h6LOlTnROl4dvuZfc6IKmuB4hKMMr3LUedmY5JUjx0QB+1qwtdkFV8B+a0O
 pqZPRHX/onDwC1NcdsPychf1rQa4qmlSlkNTloV7jT5kEGN2u+eLa32uFCTKV+augnSX
 dL1ukz6ul2cLXRtkFUxX50XX31KzEbI+8dhzqp/KSgyw9/pqs4itCRfFBsBdVYaiuTxF
 y2QA==
X-Gm-Message-State: AOJu0YxcF6wBvxOuW/i29anyM2eIw4guAyw+fHBRnEI6uhkZa/ZNK+Tk
 TBIgcGEwaibyzF+JKwfy1sjgNty6jQOOC7kDHl5xwxY6y6KfsfArji9xCWiG4MU=
X-Google-Smtp-Source: AGHT+IHxcrMYECzM0YPA04ZuooXG6TwYItjSqaKyfDbkppSA0Xf4qj36PieiGkIfszf5NzpsdoMoMg==
X-Received: by 2002:a0d:d783:0:b0:60a:16b8:1042 with SMTP id
 z125-20020a0dd783000000b0060a16b81042mr5327090ywd.16.1711827368875; 
 Sat, 30 Mar 2024 12:36:08 -0700 (PDT)
Received: from oliver.lan
 (2603-6081-7b00-3174-0000-0000-0000-1000.res6.spectrum.com.
 [2603:6081:7b00:3174::1000]) by smtp.gmail.com with ESMTPSA id
 k21-20020a81ac15000000b0061471353383sm523977ywh.93.2024.03.30.12.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Mar 2024 12:36:07 -0700 (PDT)
Date: Sat, 30 Mar 2024 15:36:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240330
Message-ID: <20240330193605.GA2107444@oliver.lan>
References: <20240330165321.2767621-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8zBwU8C+dsfkmjRs"
Content-Disposition: inline
In-Reply-To: <20240330165321.2767621-1-festevam@gmail.com>
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


--8zBwU8C+dsfkmjRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 01:53:21PM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull the following fixes from u-boot-master-imx, thanks.
>=20
> The following changes since commit 9468bf3a69b05bda05adb06f954b089ace301a=
fc:
>=20
>   Merge tag 'doc-2024-04-rc6' of https://source.denx.de/u-boot/custodians=
/u-boot-efi (2024-03-28 16:01:03 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240330
>=20
> for you to fetch changes up to fc07cac02adebc87b69cd82f6ca6f0283d11cd5a:
>=20
>   mx6cuboxi: Convert to watchdog driver model (2024-03-30 09:49:53 -0300)
>=20
> u-boot-imx-master-20240330

Applied to u-boot/master, thanks!

--=20
Tom

--8zBwU8C+dsfkmjRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYIaaEACgkQFHw5/5Y0
tywxaQwApzo3bp+1rvoCzrd+xOWIsLsPhzMk1kBj4p/EJiEttz+ww+zgvPW09JZk
WTuUPcBtT6x03Pwz8i5l8s+i0odwbkjfEn1dmldCoidm8ICAJT9E7+bqB5597xy4
llFx2L1/hh21p0QoeXtNIH5+tApDZJUDnboWR54kozTciJp8PASrdn70Sgv6q8UB
Y/PUYl2qML3YINWYChnzBw1VonUwyTYIvSyP6uSTBIITc9aVHlNIgAFltgSEe0mQ
L8Uh+T82W7oMX2vPTpDaOmdh2SOTgTFaOe9x7VEDSi1zLkkxnMBGJurovBRCjcG4
JHMk5Hqlh0ol3PrlNnqdShqjMPgSk0syylMqWIr78xYKaKp1QClHUK1Z8bCpuPpB
BZ+E3YitqgDlUbLUnXikMn7gLLtgXh0HhPkcFEyIZ9MpRE5MYIU/qeqpAbqmdyZH
hRLzOhXUKbUosXo4g8AxwvqiGevS97J6Y4sqQxksMsb8SLqduBftsRVRG54+PiT4
s0WVrsVK
=BP20
-----END PGP SIGNATURE-----

--8zBwU8C+dsfkmjRs--
