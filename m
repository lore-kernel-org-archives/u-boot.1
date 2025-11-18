Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3233CEDD93
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 14:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1911983D5D;
	Tue, 18 Nov 2025 15:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zr0pUNGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BA0283D77; Tue, 18 Nov 2025 15:05:54 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BB6E83C5E
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 15:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-45085a4ab72so2520812b6e.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 06:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763474751; x=1764079551; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VfKIW+cbQVILTVdVcofOlJoASBjA3gsiFdgwinmBjOA=;
 b=Zr0pUNGdNH9T89Y3yWjHK8Ga79PA9r33xOjYkB5+0XcAqT3Sn8fcj5W701Asaet2BT
 z93HSavjjv/U1ippJFFFcmPcSQHEO9lUkt64ebOW+wbS/8EbW3bWcU70E+qOK3isi1jm
 8LEBk0ifid46IlPVVkkURhoDujSFa0VTiehlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763474751; x=1764079551;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfKIW+cbQVILTVdVcofOlJoASBjA3gsiFdgwinmBjOA=;
 b=WJ8XHoU4Mnq6e+O9eraqQa5AjhbLstoCtDrh7dafwlHnrwqb6NV14jW3RBA7ogoiep
 1+VEbGi5mHc+AoCgg0mhEbBvKo/75Cmx7aMESEazC3SYmQXbSlYZNQ92GMysFZPMnPwh
 QoFfyYqzgUJ2RYSAHEp0hHc175ip80j0nZI+ujjB2/ponkVn4d95U3ylsLz38LJcAOWz
 l8oru9agz6R6j62bEheqMejvlVRFPG/72UHGn6Eg30Sbf3jXqA5hng6TPxbYTLQDL18n
 xacStv9IqEgKDoT/AppRrEbru1Xi3u9LVjYZyE/HeW9HcWkFuTUm6pGYuslQTq4Ip1Th
 F7ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZeaalH9pUgt7/I9SQVQJFFB6dffb0VlIRmxx8kG8MXMcWMFreb9xMJpy69/JDLSOX/Vcajgo=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4Pvxt/SABO3W0GH/GccAdiS5PeBdi5ZpqhZOJkK4sD3a/E5lK
 YGLfi2U8kRCPBqrNxUL/yxGA/TFIKyvdAq/cEypQ0p8Xa4UGs7iS1Z9Sftm8VwVKnZU=
X-Gm-Gg: ASbGncsWqqCY5W/F63KBZ8XG0AlctkXBs2NtUsrGkkm+xoakVXyMJIftf7k/yy4vB2G
 Fs7Wod/Ld7KsmX8W0NhovzaqUhkCeuwMb4izTKl5+mHk6xhL+vgTtZYcaxrZX/sO2c9IKnntUd3
 v/d8sZ6aaZgaRfoy1Ba3U5UtxyASkvWalwcdICNitsYnf2c+aRhVjx2cUl0HBYyMUOyowSZBq8O
 JR76qhAw11VsSO4BksABQWad3WJjZke5uB3iUqJAf4w+JOopWAYJf9gc2B2dk4DR+5tEcJz0huz
 DUZEoOy31fBE7Ga0pMFPPG7Sum7EumOgH0cNJbiiZVtzcc+h6Y4edw+cjik/WoKbCaE4drDRRp5
 YjqeBAuhIJ7QYHkHJ929H/6FCG/RNe+vmhQCwhFtbjjTF6T7ltQ+5U0pDl4cVA6jue01Np2ABQL
 qWMlGtrk09Tfi1v43S5uzak4asyI/C+xA6Un91bTn5voCmrXXW+VWtC7nlGesg
X-Google-Smtp-Source: AGHT+IEArReHfkbW9zxWftoAqv8T1cvbhZ1c7DLdwvnhCdUarO7ijdlvR/qxrj4t6z+1AxPDtQlWtQ==
X-Received: by 2002:a05:6808:8955:b0:450:c877:fd5f with SMTP id
 5614622812f47-450c8780525mr3982955b6e.49.1763474750923; 
 Tue, 18 Nov 2025 06:05:50 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-450b8ea2651sm2316903b6e.4.2025.11.18.06.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 06:05:50 -0800 (PST)
Date: Tue, 18 Nov 2025 08:05:47 -0600
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
 Sukrut Bellary <sbellary@baylibre.com>
Subject: Re: [PATCH 07/15] arm: dts: am335x-evm-u-boot: Add chosen tick-timer
Message-ID: <20251118140547.GQ2125796@bill-the-cat>
References: <20251118-topic-am33-evm-oftree-v2026-01-v1-0-91ce13c661e2@baylibre.com>
 <20251118-topic-am33-evm-oftree-v2026-01-v1-7-91ce13c661e2@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MjKEI+GLQj6PLAVC"
Content-Disposition: inline
In-Reply-To: <20251118-topic-am33-evm-oftree-v2026-01-v1-7-91ce13c661e2@baylibre.com>
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


--MjKEI+GLQj6PLAVC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 11:40:27AM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> The upstream DTS is currently lacking this information which is
> required in u-boot.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> ---
>  arch/arm/dts/am335x-evm-u-boot.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/arch/arm/dts/am335x-evm-u-boot.dtsi b/arch/arm/dts/am335x-ev=
m-u-boot.dtsi
> index 72402c82928a72abe3847bfcc0771dabc571d8e6..2ebf60bf7d6ce007e033b75a2=
5a10c60a83e218e 100644
> --- a/arch/arm/dts/am335x-evm-u-boot.dtsi
> +++ b/arch/arm/dts/am335x-evm-u-boot.dtsi
> @@ -5,6 +5,12 @@
> =20
>  #include "am33xx-u-boot.dtsi"
> =20
> +/ {
> +	chosen {
> +		tick-timer =3D &timer2;
> +	};
> +};
> +
>  &l4_per {
>  	bootph-all;
>  	segment@300000 {

Since this isn't part of the upstream bindings we should rephrase the
commit message to explain that (and at some point figure out what to do
about that, ie upstream or adapt our code).

--=20
Tom

--MjKEI+GLQj6PLAVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRx9OwAKCRAr4qD1Cr/k
CgCcAP47uAPVpmurWYWtJDHuVPLo3zlePRC/ZQgihL+CNiRMrQEAsX7eQnI4wI5P
oYzPXvAnd9jAZkkTmPD1I6dKT7WfQA0=
=Fr3P
-----END PGP SIGNATURE-----

--MjKEI+GLQj6PLAVC--
