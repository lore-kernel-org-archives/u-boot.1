Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EDFCDB47E
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A08C86D12;
	Wed, 11 Oct 2023 21:02:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dF/ijVzh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA0486CE8; Wed, 11 Oct 2023 20:40:51 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86CFB86D9D
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-579de633419so1797657b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049462; x=1697654262; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hT8G0W+K//nthH/lJ5fWU+cs+9fRFXLeKjEOxOjeBl4=;
 b=dF/ijVzhRhf7kYexFGGk4y3u/ZVmKo0cIzyLv8JPcdB92wzG4qRlA/MogV8AZ2UYP0
 69w3/LLG4pk1HW5mP0NUOE5pio+H/Dk76wFPuWoDCT8olGqpQeuCIXG4a00SAXWtDXNy
 xRfsY+FzacrXCiUP1w1lUKHnMmCVQEq2LIujE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049462; x=1697654262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hT8G0W+K//nthH/lJ5fWU+cs+9fRFXLeKjEOxOjeBl4=;
 b=GhMZu/qurU4mu/8Ta1muQLrjHj4l4RaQhdp606txvX6bRuPCldoKbQibBPP9S4qrPY
 PhHsXslgh660DYwWs2YDEp4Bbdp29hV/YjXHUVmBcas4th3b+EJuasNMO1mivDEIqsvU
 wqc4hX2GqJbDEDPHRKGAB0tqhmdeJ9FIR2xUscCjgv8z8IDSG3lwLycurKoqx6t9ioTZ
 85MI34EkhIpVluxWHg84XsksXqJwT/CeBeB4D8bpGXVg3aLLafV5btHhk2ogfIThANNc
 XTAsjwmQXWrBqZdRpQ9b1tI7Cb3Y6/YCK4RsqPQVpYGmdCO6L8u+GZmT95auOLaX+1sI
 qYlA==
X-Gm-Message-State: AOJu0Yz+TNUY7qyVKnTH0Qm1hofTA0ro0JRQXTuKjANAzNnSVfHFLzIS
 hP2cnawpe6C+e4JeNnOryrZ25A==
X-Google-Smtp-Source: AGHT+IFvn4bGtrJy+Rg6PF/e1E8qvprnvAyNxtmVaGWg74bbMs8Qh4iNdsze1NTCdP4TeKjaqvpk1A==
X-Received: by 2002:a0d:cccc:0:b0:5a7:cfc7:7b31 with SMTP id
 o195-20020a0dcccc000000b005a7cfc77b31mr5008792ywd.24.1697049462212; 
 Wed, 11 Oct 2023 11:37:42 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 x132-20020a817c8a000000b005925c896bc3sm5391444ywc.53.2023.10.11.11.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:41 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:39 -0400
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 daniel@makrotopia.org, jagan@amarulasolutions.com,
 Weijie Gao <weijie.gao@mediatek.com>,
 "SkyLake . Huang" <skylake.huang@mediatek.com>, ftp21@ftp21.eu,
 chunfeng.yun@mediatek.com
Subject: Re: [PATCH] spi: mtk_spim: prevent global pll clock override
Message-ID: <20231011183739.GX3119521@bill-the-cat>
References: <CAC8rN+AFz_Kh8uRgZJD8N_NF=jpobRAyVMoc-1wq7g1WdGD81Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cTEALM2qbv7ZWyZC"
Content-Disposition: inline
In-Reply-To: <CAC8rN+AFz_Kh8uRgZJD8N_NF=jpobRAyVMoc-1wq7g1WdGD81Q@mail.gmail.com>
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


--cTEALM2qbv7ZWyZC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 12:14:26AM +0200, Nicol=F2 Veronese wrote:

> With commit 793e6230118032a099ec42a1ea67f434721edcc0
>  a new system to calculate the SPI clocks has been added.
>=20
> Unfortunately, the do_div macro overrides the global
>  priv->pll_clk_rate field. This will cause to have a reduced
>  clock rate on each subsequent SPI call.
>=20
> Signed-off-by: Valerio 'ftp21' Mancini <ftp21@ftp21.eu>
> Signed-off-by: Nicol=F2 Veronese <nicveronese@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--cTEALM2qbv7ZWyZC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm63MACgkQFHw5/5Y0
tyxQAgwAoF35FPqxOqGHpmBY7Hsa55eYXmUuAWMgpj0UuAWf9LSvd9jXFAPJoMsZ
I8ALWIJ/1pW4RUdMlsykXyFIUeKVHXu6GFM4qaR5IvYOAEfgu/hJYgKtdwBaYXgB
yh097pRAfnh0aH1SqzNfaD9rPg5aMea00WIS26EIeBMDVBRK9o8mtmxotws+oNaE
jKD1yMZKqI/YlygKSPTp+6BOxBt+GYiEtN5IchlVqwVqGAaZiLvWVy5quDTbYBsW
4WNUYPEJTtcUq/3AejI5n6oWutEDWp94o6U4CrPywYNlWF5NjVmcluc6gheVuO5M
/0wtaYc7rbH1bH1eylTQ+pvruXpI/J3i0sIVLZH8VXAkyd+ffhbHvBGHFUxwhlJ7
0lS6T9HgZD3FuyGcckwi/4jc1EHnapj0z15ask0/ZWZGZzOd8d+QnVcDmtvXU2QF
U5RBgKxl/Q7eyxsN5nFmPrGKtYhZEqxQsyNOKz4uGu3b1FHGQRiOxsoL5G/43ha0
exemFiQs
=gCgO
-----END PGP SIGNATURE-----

--cTEALM2qbv7ZWyZC--
