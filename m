Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44FFC3ABC6
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 19:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC5FB8269F;
	Thu,  8 May 2025 21:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JLW3l/gn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1456A828A2; Thu,  8 May 2025 21:33:03 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB97582162
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 21:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3f6eaa017d0so1246458b6e.0
 for <u-boot@lists.denx.de>; Thu, 08 May 2025 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746732779; x=1747337579; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=c2pU7QDvGABlhMJVKuDTtClo8+lgZzm1ceglv1me0z4=;
 b=JLW3l/gnqcad/u3Gup3uVNXWzkZiE7Q6ocO7+KtOe6lOgH+g7DXf4byZY9A2DHNYuB
 FzYePbxse8A3YrdvBNisYhmcGkFcHNrsd6ULl05G0gQoZyOdoAPHqYHRins/wT/Omclz
 KmDZZJfgquF6UH4tcrjoIW+oWx9qhWwWl0MnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746732779; x=1747337579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c2pU7QDvGABlhMJVKuDTtClo8+lgZzm1ceglv1me0z4=;
 b=CyC9S8bJWM6PN2SVv5v5f6vYxMbL+pdgAIvhcvE7yxDGDg3SKPRy3Ih3ejJCuJ5w08
 2olYHX7TFyjJC0Ty4F/w7VE38mKScYSvoC6PGXC7Y8Dj1SPoZXC2+g4kEjk2RQ+PQwrq
 nHlow1J3pT8RbuduNhT09zhelD+WB6rgM9wydeK8N/xykDyTXCn7xOUsyZMONc7LDdVZ
 +t4XRzpemK8JX9wPTd9zcURoB3qPOsSwpC7xE8v7h+myPnfwi3kqKVa0zyLZ01VviCDV
 Zz7yoirM5PDh7HMyziJwlmoieynvPH4X3PeGMtJuK8tayLEoW+kNLI3+yyFiyvXBvNx2
 fnJA==
X-Gm-Message-State: AOJu0Yz68Uvzlz2nDyHhvFvmodBleo/ed5wAxRnrd26W2TX4eOHVdJ1V
 EJz4zP2Oplv4uhWPSQ4WquajvTbSVjlCo+UG1CFBdaPUp9dAWYleI19Z+z+O7ew=
X-Gm-Gg: ASbGncsIT3TxEqDojlyQ2nCxPMSChleH0z+XNR6qZykm3A4d6omgQEvV10cXAihXCPi
 SKGMUX1Qn2OEs3W35R2SxirfofNGPMpfaEzhTR0SOR2PZ3CdxaIsiC1JhsmEF7ReORnyMpOGtht
 jYNf3yhRFqGyR32D+vRleJza37OFT8ZyfvS+mjGAVO2dmNRN1hDu0HvTSBlD2TRQ6QJRlZ7fws8
 LnTr81fEaiH4iRtP+AbXBEKchoQVBeMQhMfuCEujY0KFQ1AUIkBdEHpvqka5dp0GRGwIEdHOMNh
 FhU2fdLfO8RL5ZqqVV/aEhzFQWUfhu2OYTcamfJPWIaMuK2adHM10c5JVBIcU5PQjYn1N59/nnO
 Shw==
X-Google-Smtp-Source: AGHT+IFfEitSIvtlRSSLWocTXGPcDz9KZnauWaL3G+FwbKt89gVxrj4a57jmvc6IOlhim2uGVUZtHQ==
X-Received: by 2002:a05:6808:151f:b0:403:529d:e46d with SMTP id
 5614622812f47-4037fe8d30fmr531086b6e.34.1746732779583; 
 Thu, 08 May 2025 12:32:59 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40380389220sm112991b6e.37.2025.05.08.12.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 12:32:58 -0700 (PDT)
Date: Thu, 8 May 2025 13:32:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, joe.hershberger@ni.com, sjg@chromium.org,
 d.schultz@phytec.de
Subject: Re: [PATCH 0/2] *** boot: Add Kconfig options for script-based boot
 parameters ***
Message-ID: <20250508193256.GD603748@bill-the-cat>
References: <20250508131641.2561876-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LS1aQFKnrpY121Uq"
Content-Disposition: inline
In-Reply-To: <20250508131641.2561876-1-w.egorov@phytec.de>
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


--LS1aQFKnrpY121Uq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2025 at 03:16:39PM +0200, Wadim Egorov wrote:

> This series introduces new Kconfig options to configure default environme=
nt
> variables used in script-based boot scenarios. Specifically, it allows
> setting the following standard boot environment variables:
>=20
> - boot_script_dhcp via BOOTSCRIPT_DHCP
> - script_offset_f and script_size_f via USE_SPI_FLASH_SCRIPT and
>   related options
>=20
> These changes make it possible to define standard boot environment variab=
les
> directly via Kconfig, allowing higher-level build systems like Yocto to s=
et
> them at build time. This avoids the need for post-build environment patch=
es
> or runtime overrides, improving reproducibility and simplifying integrati=
on
> in automated firmware build workflows.
>=20
> Wadim Egorov (2):
>   boot: Add BOOTSCRIPT_DHCP Kconfig option for boot_script_dhcp env
>   mtd: bootdev: Add Kconfig option for defining script parameters
>=20
>  boot/Kconfig            | 18 ++++++++++++++++++
>  drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
>  include/env_default.h   |  7 +++++++
>  3 files changed, 51 insertions(+)

It would be nice to see what the Yocto side of this looks like for
example. My first thought is about if this is really easier / better to
maintain than dropping in a new env file? Thanks.

--=20
Tom

--LS1aQFKnrpY121Uq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgdBt0ACgkQFHw5/5Y0
tyz+rwv/S3Qbb1C6CZ/FsZBTTF0DT8y2sbfLId3J4KqeLC1GDc7yCiYIdixMwk7R
fDEP/vpFJeEVQ/2FWY6K14LUkcjuaS0YjwNwIh8PCfrr+qLFMHV1FFc9PJy2mCSi
lt5/eVC/QybhUuhaE3DXfn6I6dUtdqJUH7cubI91Li/I8jOUxu6UPR+6cDoVQUtd
iKGS4F9ax2Xg+HjEzH3TkO4zw16X06GvN7NE63dbjn4//dwpUv1/LRl/f3mM1eQE
CfA3tDBS6mQVQYfJ6FN+OPZo87bJv1jdR9vcoWj9q7w3//B3fUIzMqYVbbb2tauW
EKLuqtIP1y0y6RZWb0C4mtP+jW/ekT3xunnKRHzigV/Xw1ao9LfeLxx6zsSET7Ut
/pSlmioRu0j7MUOZVX92ub0sOBx5+9z+pnDM/D/57jNrvgOTYrHFPV4NBsSpQDJB
lUrMA5Zo2I4Htiq0ItwH2bzPERTZs5kXu2c1GY/YqJ98dB+n0PSyM2tCtCESP74/
Ff89QG+B
=k92x
-----END PGP SIGNATURE-----

--LS1aQFKnrpY121Uq--
