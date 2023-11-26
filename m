Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11A4C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 17:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 091F986D9A;
	Sun, 26 Nov 2023 18:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l9BXhx0J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60E7986F88; Sun, 26 Nov 2023 18:35:27 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EECB086D9A
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 18:35:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1fa1bcf1d01so876131fac.0
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 09:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701020123; x=1701624923; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iXScdeMXarpEtPw4hDGL6QH+fcA6YwBLMEQcfFt9eAo=;
 b=l9BXhx0Jm0PrmAJuiFU2D+z+u8/aHDolBMj6w1vRPbhjBNW6eN1sGZ6sozHb+SQz/f
 6rj9VyhUekNEoYatY8cVLhocSTtrMUPgJGpa9FCR9dFzIJVkJoph4qpif9I0y3SoUsQJ
 4rZXcvtYQrm9HGsV1Bbr6Op5URYHW5ZQOB19c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701020123; x=1701624923;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iXScdeMXarpEtPw4hDGL6QH+fcA6YwBLMEQcfFt9eAo=;
 b=sj0QZHB/Eayl+l1Xb9It+zVibuNH3xUE2Kok3cn5o67RDiSKB1SeUX43+GSH3ruTe5
 fn+XRxebpKqcdUQM7v9RlHKeXDBFcrmVuUuGDcFvWVx/+u3ce3NbEZHGaKXEcMDMsri/
 4jcXRq+JnvrDgcbWXrQnbCxDs1wZGGfFVBfV3oqjAIsPgvnY6kYTaXk40OsnM+derSJ6
 KUDyHJxS8LCfcDJCdJGEp5k3MVHGe0shiEKFTZzXDcpOs+JCBx/fbNRJuT1qgEEZESsX
 lEdkj1gjugCoodOqVKKbrKx4GSuMKV4mkyGP6fRakPfYA8ZOMg+IPlFF/U7nKyt7c3od
 bI1A==
X-Gm-Message-State: AOJu0Yx6IYOYT3LFKVbxo4mg5Sd4v0XDXvbzKuFk8CAk5ubLolrVhu2u
 Vmc0x+F7gdqcUXOQ8AKdoCiB5g==
X-Google-Smtp-Source: AGHT+IHDohxBokSy2cCaGFpocGM2d5uirR8nWAAjQzv92CufV5d65xz9dQ8pVSSHzOAieqf8OuWofA==
X-Received: by 2002:a05:6870:c154:b0:1ea:38:8e34 with SMTP id
 g20-20020a056870c15400b001ea00388e34mr10922572oad.17.1701020123538; 
 Sun, 26 Nov 2023 09:35:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 cj9-20020a05622a258900b0041cf5ec8b75sm1748124qtb.96.2023.11.26.09.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 09:35:22 -0800 (PST)
Date: Sun, 26 Nov 2023 12:35:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
Message-ID: <20231126173520.GA2513409@bill-the-cat>
References: <20231125111605.47536-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fWOzMbBuzos+fs9J"
Content-Disposition: inline
In-Reply-To: <20231125111605.47536-1-rogerq@kernel.org>
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


--fWOzMbBuzos+fs9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 25, 2023 at 01:16:05PM +0200, Roger Quadros wrote:

> AM335x uses a special driver "am335x_spl_bch.c" as SPL
> NAND loader. This driver expects 1 sector at a time ECC
> and doesn't work well with multi-sector ECC that was implemented in
> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based corre=
ction")
>=20
> Switch back to 1 sector at a time read/ECC.
>=20
> Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based corre=
ction")
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
>  1 file changed, 29 insertions(+), 66 deletions(-)

I'm glad to see this fixed. My question is, can we abstract this
slightly as I assume there's a performance hit on the newer SoCs that
support more than one sector at a time for ECC and I assume it's just
am335x and related that don't support the feature. Thanks.

--=20
Tom

--fWOzMbBuzos+fs9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVjgdUACgkQFHw5/5Y0
tyy3DAv/US49SVzL70iylPvYw1l5j8aMzm4FFHaSdvPNKfA2usEvpgrNNT6UUsuX
txkZeU6c24vROBQEZGPdnQ4csp/fA3BSWvAoxnBElfeX19p3IQeIQ1JYAA15mbrU
OP76jPhKxckFjDW8p7HH3zTG1v8S0uDuUzT8P1JkLD9XGKE/ZMdV6lT51gHG7epI
TRtgEDw/rIlbHhiNE9+dj0Bh04zSuyffrUQF/fh0THcNLxwul8RhEh7KRpM7IubA
9rkjeOP6uUyR/gZbk3q6/Gsgn9Y0mU+TreX4LliWkCfhBenPQWM3ltbpQ0HfcZV6
PlXmAX3I9D7Fs/weCtgWp4XpWAl+qrqcI5QXtsCwaa1RXrpB4340zD4ysCzCCor+
7WinSgl6WqX72ug4nxQsD37727iz90M4JjsedHsTo0LM1cQKul0V9HL4crSpgP73
vjRL9MAG0SNpmzXuWyqQNH7Ljxs6cSgUkEXPX/DvT7RAseh/ltJT4ZdEorkEuCoZ
Obwm8Klc
=vPYA
-----END PGP SIGNATURE-----

--fWOzMbBuzos+fs9J--
