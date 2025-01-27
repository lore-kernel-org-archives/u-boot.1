Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102BFC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 16:28:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D219F81668;
	Mon, 27 Jan 2025 17:28:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QG6EQ1wT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4628B81417; Mon, 27 Jan 2025 17:08:09 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D02D81292
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7be3f230436so444329185a.3
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737994086; x=1738598886; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DT/pqYkRf5bP3g9u8ly2Jh2IqjSp7J5qjogAPQvuHZk=;
 b=QG6EQ1wTfqxS6yKo+FHxNq78gDslthxqTDOv8sexpF98KKJXzvlzvV7j/ct67DSgOI
 Ou8sPFy5ftr2G69C/gp1+RyrXwRcqt+wZXucF+dPXkXWcagOmhEyDTTRvoFLSpOTmhEt
 XMIz1hBJ0Y6mh6C8QlyC76CyIRwixGhp2bNlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737994086; x=1738598886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DT/pqYkRf5bP3g9u8ly2Jh2IqjSp7J5qjogAPQvuHZk=;
 b=id8rRToqvxDr6q2rgGj86q5EDmaTGAN3Fccg+mjmcCJekqthz9LXWF13QZUAFZNZil
 xbOPx9/XonyHjiUL0ft4FosLb20ZXNpnaErMxk/K+EzaXcQ08EHg/GznmdCA5bnVMHVV
 oT0L6fe3rSG/CAOv2bHirQJ+BFG37cAR2vBlZyURX4tVT9dH885bx4GZ5Uoyqnfqfowd
 pNwllPxwkPr2kZECtLEI3RQQYO0+X41iEIiAO0n55rDKbozQbtOu48R5mN5zo171XyCv
 z3Iq0s8JgXs+7djDW60a3MTTp33Q4akcpP/17mmmEQAwq3JLfXksi0RpPw6bh5oBiOkZ
 TMhQ==
X-Gm-Message-State: AOJu0Yw4U1bBUsCiRoPVOs7VNoenuEQ3RcMJx13CcKnMhcJ9l9UBTrGu
 dWDhFerClsaz+Z0SMKdmEDw9VFbYw+5I0wOFKZKrUeSpRGdPMsxFbRrPZTm/B8A=
X-Gm-Gg: ASbGncs+PwP/UuKURX/9mvPl0ADPcHBw+NbaSqqZCtfgwgFItp3A98To+2TlAJd7Alx
 C2WN2ta1QCEej97bzGyhc8q90Km2sv9n2LiRMBtYzh68n/07i3qXLQVZ7I2m/0ZIDrLuCTfZ0wO
 jzvysnu8e/i/TLYq13hKUJ/DJ6ym/xu5kxzkwQqKWvaV7kpuHk8h9Nip2hD7xqqbyA2OfDc81gd
 HBiAQY79n970P9lTr2T2qCu+nxaoPcmKAzxSns/DJkGqSINGqYUD8mpZQrxbG+hi9tfJyKzliM9
 4yNiYZPyHBB9r18=
X-Google-Smtp-Source: AGHT+IESc1VowYJhBZYVgNfj2j/jcbarcpwNcPpwa4UxjJteXDYz74QJAbnkXNb3MJS2rU4/h56ioQ==
X-Received: by 2002:a05:620a:2849:b0:7b6:c2bf:3eeb with SMTP id
 af79cd13be357-7be6318021bmr6022781385a.0.1737994085827; 
 Mon, 27 Jan 2025 08:08:05 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9af03b6esm398428685a.92.2025.01.27.08.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 08:08:05 -0800 (PST)
Date: Mon, 27 Jan 2025 10:07:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Daniel Palmer <daniel@0x0f.com>, Devarsh Thakkar <devarsht@ti.com>,
 Franco Venturi <fventuri@comcast.net>, Gary Bisson <bisson.gary@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jesse Taube <mr.bossman075@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>, Sam Edwards <CFSworks@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 00/19] vbe: Series part G
Message-ID: <20250127160759.GD1233568@bill-the-cat>
References: <20250126184333.4058848-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ku35EDkUYArRzItb"
Content-Disposition: inline
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 27 Jan 2025 17:28:40 +0100
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


--ku35EDkUYArRzItb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2025 at 11:43:10AM -0700, Simon Glass wrote:

> This includes the VBE ABrec (A/B/recovery) implementation as well as a
> number of patches needed to make it work:
>=20
> - marking some code as used by SPL_RELOC
> - selection of images from a FIT based on the boot phase
> - removal of unwanted hash code which increases code-size too much
> - a few Kconfig-related additions for VPL
>=20
> Note: The goal for the next series (part H) is to enable VBE on
> rk3399-generic, i.e. able to boot on multiple rk3399-based boards with
> only the TPL phase being different for each board.

Size-wise, this seems fine and it's nice to be able to drop crc16 from
SPL from some platforms. I'll try and find time to look at the patches
themselves as well soon.

--=20
Tom

--ku35EDkUYArRzItb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeXr1gACgkQFHw5/5Y0
tywE4wv/Snp/AyX+1ipckGwOWsaEA+VGOHtEBY5CdYZVH2MXqCiNLDJSnLM1E77w
P4BHmoPgrkac2n8iED7wF3fWmd6MvKd+SwRzFG53/wbl6/d4p2Z1RgEo5rmOYYjb
1hu0vO3VXbP3W3UZsbUsPjCFn9oDjcs8zNXB5w2hMScq0269oIyWjIvBPNVvB3hp
hSipKOACFWd7y5H3czimlnntvsctRQq999S4oRJ4bqgoAAjaO3o6p4POnIQ2SSaZ
iF36lgoCh8o5rI/i55xvoyzHNR3aMdIJa/EN4QJlgnnWBraPMIV1hr+a21w0yqlY
zQ+NFxpY8kYtt3DzRId7nBIvt/zkKV5Ap61RrB/PEOuvbOpfjVpAmknOc67Lyfuv
hgZFKkX3IG1TEZJVNfBgmyHLYkjS3/H48VhkQfdiH9vkJtlRYkbtxaCuMqG5kuE5
fjZJtJWvL3l0k0NQ+b0f2ZTCNQYP1sDaaH8HOhP5xo0Eflc8jyu5nTI+8suPZtVN
bLaXaN+U
=tY7B
-----END PGP SIGNATURE-----

--ku35EDkUYArRzItb--
