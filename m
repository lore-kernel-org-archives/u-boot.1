Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF55C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 07:13:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5B4D87C7D;
	Wed,  7 Feb 2024 08:13:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Wo2kbWbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A79187CCB; Wed,  7 Feb 2024 08:13:05 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5708C87BC6
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 08:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707289976; x=1707894776; i=xypron.glpk@gmx.de;
 bh=Mc/lGiAt/1cKqzvKjd/T9q4gFnNR/ThVzNkKL/kcLZU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Wo2kbWbo9YcsUswxazyi1p949dxbAXMBTNx5IW52/fh1RdXZxdcHovSVMHcyOPmr
 cJrPoX20+mIheH0KnE8bPN2EHS5PPZuNPuFMObJqruCYBa/7PPOzA2kqPdDSE4aGH
 3EfXH5zNLnuwTZWbizBjzWvQTGhU3ObDA/xhV6oIdyHA4j6qKQBRfKlSl4DFzUxbV
 cjxV/KXRuPxN9rXWmtqh5amQszSuHsyKBuKEI02OdPtGDMIL+z1u2CU/jKO0UaLJt
 6gTh3yK8xJ8DZF1+HxwyCj3xjP1w3QSuoLV2ofJuJ5hTzSA4wpYnylVNniGKaalMQ
 Dd163yQ6fG2UmfFZiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.51] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9Mta-1qvIj62f5g-015K58; Wed, 07
 Feb 2024 08:12:56 +0100
Message-ID: <9c8e247b-e827-4c0d-953c-4cbab061bb24@gmx.de>
Date: Wed, 7 Feb 2024 08:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/15] rng: rockchip: Use same compatible as linux
To: Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20240207000301.3270722-1-jonas@kwiboo.se>
 <20240207000301.3270722-11-jonas@kwiboo.se>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240207000301.3270722-11-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KD2ejhEqb430AVGEJbYgHi3bdNPkC/QsdnrSOGf9bZLR20+omxP
 85RpxsuZ5kVk4oCXZev7BlGqSDEmTCpl5nbanIMOoFXiZ9Hy4XBChBpjGTRSOU5lm9PB0pv
 khZxGFSOcwUFh7R3e4Y2NWhxvEecIp7NUx8IPmFUeJZ0WTZoBGoUXoxRBqMxl/ZBlqW+9Vs
 lbxveqrmeXJUpIZWnzHWg==
UI-OutboundReport: notjunk:1;M01:P0:8Q3Mopg1sac=;jqz2JVbZAkpU7DUFoaSWaOMkprJ
 rahPmZWxy7nkRBkzuvKPlkHuAFa9a/zUDyZ8u9j3xNHMC4cLteIf2S7l7RiGMYEtfFHUDYWvl
 w7k0c1XMG2L6Ca5FSh18R02zGGByC83IbfgBafCASlg3EEGvmoPmQAnmWn3nfU1Dl1A+c3S3u
 qNgrx059jFJJdM7TY8Rxz0m/txOOWrU25y5NPV0ivKN8YB52I33l0iRWxF4STYP7aeSDFjsqZ
 wpDHkGbzuVF08U6ycB4YlWHy8jB49r5fV9okLiRclWNsRPOD5DM5qobWh1U5TnF7Ng9/TeClR
 iHRnIENWPhF3/jXg7Z6AcEH30GCwgIWxv4A5JolRIa1PibiM+CYK9hyQCQ1L6AUyOuKkn1BWV
 Df0A7Dpd2xsY1sN0x9s1KKwF+SGkKjEBynUto4tm4Lnu4+4IxRxu+/aGxOrnQSR2dOR2T+ItB
 mx0BFQLRnzcW1LZ5mC67FiLNcQzkIebPgFTweZDz31V91e8aYO4fAxYXZ3HDjIloUGeYvXeIw
 +nIYaEYUNJko58VTRBCknhoiRkM/06NGdargZk7z4fGtBPY6Z/5HvLUfal8cvZugiP5ZU2kvX
 iQ322vvrh3MiI1VzWw4kT49odevyEPGB/KRvcGyNUSA+ckSf/U0ni8qPJFQBN9OGuMz9x1O9g
 M+Nmp/zSojaevJO/XONT9wJ4cSP2MIyuNVpHF0hVQQg/6IvHswl0WczJjbp0HOkNz0EaQYM75
 q+pRAyqcLPA/pY9+RH+ZCz9WMitQ6Mj6HJtBFqe2pd7MF6dzoFSmLTcKzlJesUlNWQCUlW2uP
 /mliAj8o3uSacXjoN6hktw5y6gyo3MaL/9fOehzozpE3A=
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

On 2/7/24 01:02, Jonas Karlman wrote:
> Replace the rockchip,cryptov1-rng compatible with compatibles used in
> the linux device tree for RK3288, RK3328 and RK3399 to ease sync of SoC
> device tree from linux.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

It is strange that U-Boot only uses the random number generation while
Linux only seems to use the crypto algorithm acceleration.

U-Boot has some crypto accelerator drivers in drivers/crypto/. But here
we only make use of modular exponentiation (see struct mod_exp_ops). We
could improve on crypto acceleration.

The current change looks good to me.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   arch/arm/dts/rk3328-u-boot.dtsi |  2 +-
>   arch/arm/dts/rk3399-u-boot.dtsi |  2 +-
>   drivers/rng/rockchip_rng.c      | 10 +++++++++-
>   3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/rk3328-u-boot.dtsi b/arch/arm/dts/rk3328-u-boo=
t.dtsi
> index e087b02893c1..d805c2f394f8 100644
> --- a/arch/arm/dts/rk3328-u-boot.dtsi
> +++ b/arch/arm/dts/rk3328-u-boot.dtsi
> @@ -28,7 +28,7 @@
>   	};
>
>   	rng: rng@ff060000 {
> -		compatible =3D "rockchip,cryptov1-rng";
> +		compatible =3D "rockchip,rk3328-crypto";
>   		reg =3D <0x0 0xff060000 0x0 0x4000>;
>   		status =3D "okay";
>   	};
> diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boo=
t.dtsi
> index 3423b882c437..87b173e59579 100644
> --- a/arch/arm/dts/rk3399-u-boot.dtsi
> +++ b/arch/arm/dts/rk3399-u-boot.dtsi
> @@ -30,7 +30,7 @@
>   	};
>
>   	rng: rng@ff8b8000 {
> -		compatible =3D "rockchip,cryptov1-rng";
> +		compatible =3D "rockchip,rk3399-crypto";
>   		reg =3D <0x0 0xff8b8000 0x0 0x1000>;
>   		status =3D "okay";
>   	};
> diff --git a/drivers/rng/rockchip_rng.c b/drivers/rng/rockchip_rng.c
> index 705b424cf3dd..e82b5572fec5 100644
> --- a/drivers/rng/rockchip_rng.c
> +++ b/drivers/rng/rockchip_rng.c
> @@ -302,7 +302,15 @@ static const struct dm_rng_ops rockchip_rng_ops =3D=
 {
>
>   static const struct udevice_id rockchip_rng_match[] =3D {
>   	{
> -		.compatible =3D "rockchip,cryptov1-rng",
> +		.compatible =3D "rockchip,rk3288-crypto",
> +		.data =3D (ulong)&rk_cryptov1_soc_data,
> +	},
> +	{
> +		.compatible =3D "rockchip,rk3328-crypto",
> +		.data =3D (ulong)&rk_cryptov1_soc_data,
> +	},
> +	{
> +		.compatible =3D "rockchip,rk3399-crypto",
>   		.data =3D (ulong)&rk_cryptov1_soc_data,
>   	},
>   	{

