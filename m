Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78250C4167B
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C47387C8F;
	Tue, 31 Oct 2023 14:01:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bmAdURpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5B187C8F; Tue, 31 Oct 2023 14:01:09 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A4687B53
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so3398857b6e.3
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698757264; x=1699362064; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VJbUGEK6s8VDEHmk8SuyzqyarikmsOwxvE4EGBswG3A=;
 b=bmAdURpGV3H4IzSY8jaQVX4SsuSZVmrdvjIcvsc1IW9bfYcGyGXt22WT+EwqmB0r5d
 xjembOAzXo1pm8gNighiBTTqfCdB2kgRJYaYGJjsyQoUn+kQu7nXCOyf9Q5Al21vdVAm
 z/6G+uFLZr/ECFDgxb+Tqx64RsvG0y9JJ1KdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698757264; x=1699362064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJbUGEK6s8VDEHmk8SuyzqyarikmsOwxvE4EGBswG3A=;
 b=ubQDTt9W5Jk+RKIkyAW4TsSncSDdtGmnqBpLNUGlhSDyy3zPE6Mwg4i/xCWPbPtdhf
 qyqfkVgVtT92/N1s6mAVV3hiUzKOEDqMLwHnH6zft3QtMF8Myt3Y4cUsIeNmCQdxviEZ
 MkrR66dRk548kKpjdw0u9fcq1Be1uWFya1DYH8eyI68EsZFs4HxO79D+vweC9R0+36Yp
 y7e07r0sQ6y3aWDcnK2cMhkZDpG0oJodVLgF+6+OjuEsbUp31GcFfI29XX0VhG3HWAPj
 LNcndJxiMYOjEjQFiZHSMVgnGxQLgFHS6Wile6n7Kxnhf8353zeN9ZwNzul4QD6gmBbP
 f0uw==
X-Gm-Message-State: AOJu0YxngxW3lMxFi9YbeFPb4qGxjxTMh2eQmmtx5PjJy0Vy9zHcepVA
 PqrEfKjPT65exeP1We4KgbSIKg==
X-Google-Smtp-Source: AGHT+IEPY4ghsRfJWkDg8yz/IDkGcq5XN9mnZVrrm9Nom4aU4vDLxjeulfTLHUF3URnkxT75RSOvCg==
X-Received: by 2002:a05:6358:903:b0:168:dc03:5b90 with SMTP id
 r3-20020a056358090300b00168dc035b90mr17455204rwi.23.1698757264164; 
 Tue, 31 Oct 2023 06:01:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 l3-20020ad44443000000b00674a45499dcsm495113qvt.88.2023.10.31.06.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:01:03 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:01:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, ycliang@andestech.com,
 yanhong.wang@starfivetech.com, minda.chen@starfivetech.com,
 xingyu.wu@starfivetech.com
Subject: Re: [PATCH 1/2] riscv: dts: jh7110: Add a gpio-restart node
Message-ID: <20231031130101.GI496310@bill-the-cat>
References: <CGME20231031082448epcas1p33a8ff166d2e48df3dcd6c0b1f0132efc@epcas1p3.samsung.com>
 <20231031082439.395320-1-jh80.chung@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/KBf6PZGtLjjiM7A"
Content-Disposition: inline
In-Reply-To: <20231031082439.395320-1-jh80.chung@samsung.com>
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


--/KBf6PZGtLjjiM7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 05:24:38PM +0900, Jaehoon Chung wrote:

> Add gpio-restart node to do reset.
>=20
> Before applied this patch, System Reset Extension doesn't appear with
> sbi command.
>=20
> OpenSBI 1.3
> Machine:
>   Vendor ID 489
>   Architecture ID 8000000000000007
>   Implementation ID 4210427
> Extensions:
>   sbi_set_timer
>   sbi_console_putchar
> ...[snip]...
>   IPI Extension
>   RFENCE Extension
>   Hart State Management Extension
>   Performance Monitoring Unit Extension
>=20
> After applied this patch, System Reset Extension is supported from SBI.
>=20
> OpenSBI 1.3
> Machine:
>   Vendor ID 489
>   Architecture ID 8000000000000007
>   Implementation ID 4210427
> Extensions:
>   sbi_set_timer
>   sbi_console_putchar
> ...[snip]...
>   IPI Extension
>   RFENCE Extension
>   Hart State Management Extension
>   System Reset Extension
>   Performance Monitoring Unit Extension
>=20
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi b/arch/risc=
v/dts/jh7110-starfive-visionfive-2.dtsi
> index e40f57a15080..e94f9fe826a8 100644
> --- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> @@ -34,6 +34,11 @@
>  		device_type =3D "memory";
>  		reg =3D <0x0 0x40000000 0x2 0x0>;
>  	};
> +
> +	gpio-restart {
> +		compatible =3D "gpio-restart";
> +		gpios =3D <&sysgpio 35 GPIO_ACTIVE_HIGH>;
> +	};
>  };
> =20
>  &osc {

My only concern with this change (and a few other similar things I've
seen of late) is where is this change with respect to the upstream
kernel? The goal is the dts files should be able to be dropped in from
the kernel (except for -u-boot.dtsi), so we don't want to have changed
get dropped when they're re-synced.

--=20
Tom

--/KBf6PZGtLjjiM7A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVA+ngACgkQFHw5/5Y0
tyzz7QwAnBNk/XpdcqgQ4gH5PSyKw9Ex9I9OvXG/Ca/Tip3nLUYxP0M3RdVybe5x
oI4ambB+03IgpmhHQifbLXHfL1y5FmwISOT1RDd5eOTCuSHn827IiN/UgJ66OGio
ibml4IuAICalAPzDFtgjSBWCMc7iJ2Q0YDaE0sY77Lcqq6NeVjrWABTbBbfjTlVv
mlzll6wjTLogVePsMARJizWBRyQtCXvIGnyG8+KpzieW+yNXU9Z8kRC1u+Vzdjsg
mXuQVctr9UZNdCWiXdZ5+pbSVNTw4ZOvW+cFK399J4XCiVQdsiFgF1VK9ibCgJjU
6xSQA478Kwxrx6GW3bxv9PhazsEvPoBqsLWl4k6qdUucYus84NU7kO1IETYA6377
mgT5hrcjET8LZnClPFUISXVianonPOK4lVRNVY7gNc0LX1SE6d8ubdd9gVkaGSnR
lrsXfC/rpOUPaC5bmAoi/EC9ZBDomaoiPute/FcxcxCxObJZiwTtLmWJRroGuHKB
XB0/I1Ah
=Fc7a
-----END PGP SIGNATURE-----

--/KBf6PZGtLjjiM7A--
