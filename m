Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35FAC87FCA
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 16:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E81838F3;
	Thu, 31 Jul 2025 18:05:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jEDkwHzZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A93A838F3; Thu, 31 Jul 2025 18:05:23 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3C78309D
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 18:05:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-41bc2668f75so561787b6e.0
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753977920; x=1754582720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7wiLTgNirISwhXsZBkquFLnxeN97HaEaGUis9+dmx64=;
 b=jEDkwHzZfy1qqCDvPGxRdeXeFuYPuaTakmCI8S3PPkD5wfikNW11XDhrkAsZUTV8Gm
 yvCNvU5j8f6Sz5FGJxommC9cZFXNnvCsjh+JAeFdPouiowHD6apPXQtcMScgeCQQvmaJ
 vAklY0+C3C8BraGQ0O3J1dce2pcIpjL9hErmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753977920; x=1754582720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wiLTgNirISwhXsZBkquFLnxeN97HaEaGUis9+dmx64=;
 b=Ee1WRvrlpnmuQMMguXaqG139FJDtuVN7c9dmTUNH2XeI5/35CBmaN/3r0Q5zRuC5Tn
 N+D5zo247hQCdQR6veZxAaTkGITWs8s4ToaFZucAWY2shLdAJQ6la1HsT8r6mkIVwW8Y
 sCBgZUBRxeEtbiWOydmtKgyarlXWnVRaOQIKT6wHfQiAKZTgQA3kJThTBgZHlozOwgpa
 MMIeN2AOFlmIhtJ+h15yrGfxfQTkQ1hWBMeYarXBDF7wjDyPA2C1bDe/lvOq482DAtTs
 ya/2Jf/HyG8EFW6NATOGB5vMoeAAnA0o87TpXBm5M32G6OIe15h1D9A+d7m84efZOH0T
 AMQw==
X-Gm-Message-State: AOJu0YwpfXBtgDB+XKMUUqMbuhmYMa32kbvclFOkEuhNw6N0sgEjnvM3
 aF0cj5lQWjYyjb77k5sOCMtcA6l0KOCOszU9wDi3/Mc6CDqWcEm19klzbPNiSF9oNTI=
X-Gm-Gg: ASbGncuQJAEtaNDDInTRWdB57r3Jz2gkC9GhQcHGgFF1c9+ntnv68gW0P1CtqWz41Ul
 JZJeiNbSLJ6SKbU+R6NvBVUV64Nliq1r/x4QSvZqY5gUC+N/6um5mr2ps0Qv8C2UZ2fMNROGpsj
 Yno85yqEdDgec/5fiLPWmlw1sIdEiXXb17P1l3xVQlOdSF+5OkzcIDUP9bGVDH3RZnZD4NvpTpN
 xpk5CSZz+03TULmv6s9AFqEowT0Ldn+CshbOgEVRpW5i6DJIAnecu5wFv/B461Fbts8Qjn8YBA0
 UwOxTzu7forXDV0hF0KZQR7NF0j7+bkugyunwq6Z6HGJ1OWqMIz5ObEK3A8l0E5HNDjfv4/LDQV
 AwzhPLMHBTd6lWeMQOqCiXpbahiikQ7yeUIlqF6xOP9NVhguPF/38c3X+
X-Google-Smtp-Source: AGHT+IGIIXxqWoZ7IrPzdJNGuKY/1nM0pMqYFYhmL2THSMb2dar9rU8wPD7ilDiFle6YMILR43ukJA==
X-Received: by 2002:a05:6808:3998:b0:425:767e:9ca2 with SMTP id
 5614622812f47-4319999cb6dmr5020880b6e.1.1753977919928; 
 Thu, 31 Jul 2025 09:05:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4335938b264sm309390b6e.37.2025.07.31.09.05.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 09:05:19 -0700 (PDT)
Date: Thu, 31 Jul 2025 10:05:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v5 2/4] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <20250731160516.GY1807455@bill-the-cat>
References: <20250730123833.249923-1-pro@denx.de>
 <20250730123833.249923-3-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hoExF2ZDpbQXbzza"
Content-Disposition: inline
In-Reply-To: <20250730123833.249923-3-pro@denx.de>
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


--hoExF2ZDpbQXbzza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 02:38:31PM +0200, Philip Oberfichtner wrote:

> Introduce another SIZE_CHECK macro for u-boot-with-spl.bin.
>=20
> Note that we cannot reuse BOARD_SIZE_LIMIT here, as this also applies to
> intermediate u-boot*bin images, which, before being compressed, may be
> larger than the final combined image.
>=20
> Also SPL_SIZE_LIMIT has to be a separate option, as some boards might
> just want to restrict SPL size while still allowing u-boot-with-spl.bin
> to be bigger.
>=20
> Signed-off-by: Philip Oberfichtner <pro@denx.de>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hoExF2ZDpbQXbzza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIuUPAAKCRAr4qD1Cr/k
ClZlAP4izpc90F67xjrP8u6737k0jGCrnYfZJ13wczMhApeyywEAsufNC2tY9OO0
AY3sNVIXuCkTT/52UIToXE3gYt2pXgQ=
=LvzR
-----END PGP SIGNATURE-----

--hoExF2ZDpbQXbzza--
