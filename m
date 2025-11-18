Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F50CEDD8A
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 147FD83CB1;
	Tue, 18 Nov 2025 15:03:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hJk8cfs3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5526A83D17; Tue, 18 Nov 2025 15:03:07 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 141AF83C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-3e12fd71984so2950957fac.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763474583; x=1764079383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eRTbyEr5gnOvuZ+NRSBWU4/HHFE+VoBT1WKfqJQS/6g=;
 b=hJk8cfs3mbDn0HCG7AxzAmkkyAkMKyjP0I5GSOQ/Woetdu0zn1WT7tfP/MbzR1s0Wd
 ZybDEeVfusfSyerceAE6+st7tULwEp6t+/qfLNLD20BqBFGV9qcgkbh443Fu+O9Yi4/3
 j9fD1sWePYTKBWZV9A+jOVUTl5Nd7xDWuELxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474583; x=1764079383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eRTbyEr5gnOvuZ+NRSBWU4/HHFE+VoBT1WKfqJQS/6g=;
 b=UP1dw1852OOMJ+ET+urCNC6UC87a+B819Cu2hgd+fhGnMC0lo9K6YGu3c/QDxHtdxk
 P/qHyCfr6cnmcvgAaJj4QdaWoy6enoUuP/nd5GTG8oSZOqAnTrnddKnMA5bBgJjB4B9y
 ITyI8EFJW//q8TnYrHOJSCNGh6n44Mc7zCyflIvD7AUmBovejsyw6ka0u5mgggTzCCAX
 ZL+oLWVZ675Cin/PqNbBvvrKJlXX4sW/bD7OsKtIsq/satw2vfyTXw+AiegbumAdwjRF
 PhD1swGA+Mb4723CHiBSTkuls+KeTzokWc/44eSt11nQ8vZvLkvWs+pjzmeNfWsFW4nM
 auRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1OHCMvEvNYiebwA7eRfrPq+4lIUQl+DwAmDHwDNMMtW3xRdIU2TAa5v6FfPF1YOo7g69LjFM=@lists.denx.de
X-Gm-Message-State: AOJu0Ywemjlpe5nBuptd1MvkB3E4EaeSdULqspa2xqvIWS5spZzg6sKZ
 JQV/OdsDGX2xbm1DaqVbqWeR56R3jlAgbdCVXrrnCmbQMNszPlbm+4o5MO574pSQLOs=
X-Gm-Gg: ASbGncuuZSD08qHJMR6Xyb/eiSowiuGtD6tCgl+R1xaLIr5s0eW4lmcha48hMMaAICD
 886IHnb8jSX/FsFv/gEbyIkXgV0u+pLewTCNDvSEZt8s4ZQblzDBAuq0wxRASunJ1AuSKm6gXe3
 Hi9VtWtFHqdPR/l/OfkrUggDhWhHmpwNRvDIKt4x97FII58u/vGwsoulCQCX/FwZq/2QhQ5bgGm
 DOC1ls9HDOFXNlzEJzSu4cNQQCeE0dRuWMYi0B1In8RrmgUtKbGe5WRN9tyV64Fxj2Ybbs/dwlk
 GdwjZDtm2Eb2ELJMh4bW13RzZaum6o1mP/KbH7bkvOFwi32bFgiGCw+YyNgNOuN/nYJHzH4Sop8
 Uh+JzsaslC4vbZ7qG7O8xUm32gPq9GIScSxFa/3/foCWWSF2kz7z4iJyaZbS606fhFqHPzqTI39
 zv0S5Z8/qxB/nZ+/knUejvniCytzKrwQ2WqRKMvB8EtJgOk/iN9A==
X-Google-Smtp-Source: AGHT+IGKRHYSjl7ebjb7VQLHv1C7tyFbkSls7s6DXQ5odFYDnndrH+lePnp0FV5KNZV81hLci+4a4g==
X-Received: by 2002:a05:6871:d30a:b0:3cd:a995:6c6 with SMTP id
 586e51a60fabf-3e868e9f272mr6762499fac.13.1763474582476; 
 Tue, 18 Nov 2025 06:03:02 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522fca39sm7008427fac.22.2025.11.18.06.03.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:03:01 -0800 (PST)
Date: Tue, 18 Nov 2025 08:02:58 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>, u-boot@lists.denx.de,
 Kory Maincent <kory.maincent@bootlin.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Liya Huang <1425075683@qq.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Romain Gantois <romain.gantois@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Sukrut Bellary <sbellary@baylibre.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 03/15] arm: omap2plus: Select REGMAP
Message-ID: <20251118140258.GP2125796@bill-the-cat>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-3-91ce13c661e2@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0JglLO7eIMZuEBAk"
Content-Disposition: inline
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-3-91ce13c661e2@baylibre.com>
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


--0JglLO7eIMZuEBAk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:40:23AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> clk/ti/clk.c is compiled when ARCH_OMAP2PLUS is set and uses regmap
> functions. Add REGMAP dependency to prevent linking errors when CLK_TI_*
> options are enabled.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 3db5474a05b8c08e111e8c8b98c3a6fe68de15f2..c72821ce2131e9d9deebef4fc=
e3757fc68bd9f3f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -844,6 +844,7 @@ config ARCH_OMAP2PLUS
>  	bool "TI OMAP2+"
>  	select CPU_V7A
>  	select GPIO_EXTRA_HEADER
> +	select REGMAP
>  	select SPL_SOC_INIT if SPL
>  	select SPL_STACK_R if SPL
>  	select SUPPORT_SPL

This belongs with the appropriate CLK entry, and Yegor Yefremov has been
fixing some issues along these lines recently as well.

--=20
Tom

--0JglLO7eIMZuEBAk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRx8kgAKCRAr4qD1Cr/k
Cg8YAQD3Xe4zbP3+BmeUMI4N3PxRGWMmbqnUctalEJvVwCbXEAEAt1Gtdc/+t0Dl
VPvJ6AaX3UvUTxLlXSImJn/Ul1Sl6Qw=
=ipdz
-----END PGP SIGNATURE-----

--0JglLO7eIMZuEBAk--
