Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA61AC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 18:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6B387772;
	Mon, 27 Nov 2023 19:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lpa3PSZd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB9A8761B; Mon, 27 Nov 2023 19:36:25 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9DF987772
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 19:36:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d0572434afso11010007b3.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 10:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701110181; x=1701714981; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JeUHyLydfFXzDdLtRr25hLSQs3dMbBX+KwH9Fw59Quw=;
 b=Lpa3PSZdnfM1BWF4R8ZZbBIpPdooGt9JMhp4MfY69CN05l0b4F0epvQHM53aWUZuix
 UqZuUiOmIP+lhypU8FbqxpGlfptWWoxt5uM3Ere8TT4dbS8+e+mY1/P5jicoXJfjMFkA
 lS+8hXCqPRv2BflVTcL5rUBThnnwEvnEUaQHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701110181; x=1701714981;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JeUHyLydfFXzDdLtRr25hLSQs3dMbBX+KwH9Fw59Quw=;
 b=pP6OtzTHurS9s8vXNyi5zTY17U++tmixehy7OhekgxboYfDzH880Fxrc+s0tA2gScd
 2QNb8VJXZw2FNOT2InzbW3Wv8Ms+7YRrPwt+RLgk4B8moxy7DlOEg2u2ACAChKd0rTKe
 5ygbav8K2W1mQ6d5UBrcj1TeDuk4fzTaSvuBK9E4jZEuVkIDLEtuthQLY5ls6ZWO56Zc
 +KmR63kDwLr0y/XmSPGdKDylJIyRElP7E+oL+kd4zXuh8ZZagXlGPCPwQqH8thEQ83wO
 9mKiRtgHWp7DWy2gl26T7exH9jWvY1AiOs6V1RdVK2qIyWWEEM3c99sKZ45K6hobZHEC
 Azpg==
X-Gm-Message-State: AOJu0YyF/uBN/EuHAuecom6blLx63seF3DX5VQa2pHtrMwAC38ooH9/4
 JNuJIG2G61Z96mR/7fLsZJA+kw==
X-Google-Smtp-Source: AGHT+IFVEZPqwoqhuYDZOVv2IN1vEdErGhQS+TuWXSDC8S5AJAINLxZI3+DD5UYX2q7B0+GUL0sbzw==
X-Received: by 2002:a81:ae0a:0:b0:5d0:aa04:7b71 with SMTP id
 m10-20020a81ae0a000000b005d0aa047b71mr2825994ywh.24.1701110181479; 
 Mon, 27 Nov 2023 10:36:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-add3-c5a6-8002-bb49.res6.spectrum.com.
 [2603:6081:7b00:6400:add3:c5a6:8002:bb49])
 by smtp.gmail.com with ESMTPSA id
 t133-20020a815f8b000000b005a7c829dda2sm3449761ywb.84.2023.11.27.10.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 10:36:21 -0800 (PST)
Date: Mon, 27 Nov 2023 13:36:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 goldsimon@gmx.de
Subject: Re: [PATHv11 22/43] bcm_ns3: fix overlap define with lwip
Message-ID: <20231127183619.GU2513409@bill-the-cat>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-23-maxim.uvarov@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xqthDrJT531/aSNp"
Content-Disposition: inline
In-Reply-To: <20231127125726.3735-23-maxim.uvarov@linaro.org>
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


--xqthDrJT531/aSNp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 06:57:05PM +0600, Maxim Uvarov wrote:

> Rename declaration to not overlap with lwip.
>=20
> aarch64:  +   bcm_ns3
> +In file included from net/lwip/lwip-external/src/include/lwip/etharp.h:5=
3,
> +                 from net/lwip/lwip-external/src/core/init.c:55:
> +net/lwip/lwip-external/src/include/lwip/prot/ethernet.h:69:
> 		  error: "ETH_ADDR" redefined [-Werror]
> +   69 | #define ETH_ADDR(b0, b1, b2, b3, b4, b5) {{b0, b1, b2, b3, b4, b=
5}}
> +      |
> +In file included from include/config.h:3,
> +                 from arch/arm/include/asm/string.h:4,
> +                 from include/linux/string.h:21,
> +                 from include/malloc.h:369,
> +                 from include/stdlib.h:9,
> +                 from net/lwip/lwip-external/src/include/lwip/arch.h:83,
> +                 from net/lwip/lwip-external/src/include/lwip/debug.h:40,
> +                 from net/lwip/lwipopts.h:93,
> +                 from net/lwip/lwip-external/src/include/lwip/opt.h:51,
> +                 from net/lwip/lwip-external/src/core/init.c:38:
> +include/configs/bcm_ns3.h:52: note: this is the location of the previous=
 definition
> +   52 | #define ETH_ADDR
>=20
> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xqthDrJT531/aSNp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVk4aMACgkQFHw5/5Y0
tyx6aAwAmDQx4ZTV99lOK7VSA2BqQ3+a5UW46Hz9DyqiIxKohY0eL/IjQ89aA7Iw
8b3Q1/Eursgm2L9fRe8FKAK9Woq+bFyhJTkJON9drHY8Pzo78EJt4GTxH+wP493E
dGwOarYlcx0BUPaOLvUvGJyyR/qRWwAKmGOqlA2GFeqv+kNw+LWmwUNa7hTQM2V4
B1uomwoeTuO1lRoE5w3xqNYPf/L32/5lyiV9r6mmnCMZNt2IePnQlaijC5lq+dMn
e9tZYYuJTpanPEl4pQPbBBeWAGPhtospE0X7J47XsTzPeNdDCMdYPFjWG0vaNipM
jy3Ap24iiB1uhseIAg0EMahgk+yOfPOxYHeFPCoVVJWmhJy/MWQGfGtKKr4LliEG
vcClk/Sne3uaMVPPHjSIMgTH2t6vE/MDH6DbXFdhy6vDfbjm3rhFNk1+GJ8eeq7W
VmPhppJtIPOlO+L83+pIpieIieJ20ISYmOz7X/hDsRbzL5BU2impikPsNZMII1za
rfT1Pn+S
=a7qx
-----END PGP SIGNATURE-----

--xqthDrJT531/aSNp--
