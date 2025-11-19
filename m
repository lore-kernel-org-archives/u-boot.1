Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5969CF2562
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 00:09:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 115F583984;
	Wed, 19 Nov 2025 01:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WFjst2T7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9FCA839A1; Wed, 19 Nov 2025 01:09:55 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA28A8397D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 01:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-656b4881f55so3017074eaf.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763510992; x=1764115792; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0HBBjk4Dj7shOveulG1Gq22RUBGdGMbA/CYa78qmNBE=;
 b=WFjst2T7WSuE9kJyViflctyp7aY8Ju2nFmBZ1L0TBNP1+XwNgiEcx/7eYAixAP1pEk
 KWtu3HpuEh6lhDk7tvfDxRuZ9/RlAKugyyEnKGfKovfD9m2MbCraYEqwxDHr27bUU+ft
 cYE2ikkKr/eAVPNZU04cix/sH1FT2n5Vg6FbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763510992; x=1764115792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0HBBjk4Dj7shOveulG1Gq22RUBGdGMbA/CYa78qmNBE=;
 b=xEEVCninMqneqxeQsb7mA4VFc5VEq0BLPTXkJDk3lnsMS5JJ4MdWzRw9Iqz18tCazR
 kJCOpTAjm4audWE0guH+pqyteRX5/K14HYnwkf7MX2/UGJsHq5mbxE7sTbTrVRDNRfu3
 BXTtA7NyZLokTb0Nsu1oC2JkAUCxUea7zO7r9bcweq8env8JEYBJJ9VuffuF0W5w+6T0
 I3Huqq76I2mYDHYp1qlnKkaxj31uQ1YCQCibp7DQuIsgkl1pe/BHnZMDDcp0asbhwnI2
 ufbFZHOXCVrHtovDIxHKFJYoufoWr+1JK3RSp/aWD108gRMK+UihCmsljeoQ15d3VyAd
 KBaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnow0otz7GnFk8eM2Xh9kG/WARi5hVd8JMHJCVJbCjTB6k6D8b9bSCag7nc4/QEBv6WZltgis=@lists.denx.de
X-Gm-Message-State: AOJu0YwcuojD9vjYcSnmsvTu+AXroh7ePCFYtJYcEjyXIUfGhN2tAo8B
 EYUiex4LWxXMofKpFUSRkh8Mr4P5ntSRmLVuy2VbAFFC0B2GKifiRfxXnxx7jxODd28=
X-Gm-Gg: ASbGncvlhZQr5d06K/5N7thbLKBnEJIvQqa4GKuUE1yyUgistxXr4MO9d6tBkrpC7jf
 oed+JHVR9Du9QJi9kyqPN9d/Qw1qXYme8pcdXgRZD3zCusmv0CqIarEZuLYxdb3bKMJfwzys2Cb
 HPR+U/F1N6p3eju6yuPXxX3RXxD9JF1QKFNUCiTn+TKdtqYknQbGVWwITpaAZBGQfDyio61/kJB
 tkM+EdhASK47+27R5UgGOzV6C06b+9H2YTtbsgZ/KdQ944Gsz/xTPCrYV9x76Bwt0ZGjonvm+co
 AVq0Q3iCvM6qABAhBvlKS6c+8jIjlYkJrVkyvtHtr5zaCTzijuyAqxoY/2iSkm22D8oeigJxBrw
 M2XIkqReR+EOAFN+6zsKLm5rt0goQw2JGcv1WnZVXviLAL2id7KsPYLcZphTT0nZfETnlQuBYM4
 OcslEovkFHeFfJoOM9PQ3VY3IpPYZSPPkvm6QIMPLOuEijY2ajvtv2Q6dNy7w4
X-Google-Smtp-Source: AGHT+IEG3WHOrFUSeRsUZsyxgc2b5g5meQcsUELKESR3w8pYTupHXGo9EXuldZ3+5O9BYDI0/GuiRw==
X-Received: by 2002:a05:6870:4f88:b0:3ec:50cd:2415 with SMTP id
 586e51a60fabf-3ec50cd3754mr3912023fac.29.1763510992311; 
 Tue, 18 Nov 2025 16:09:52 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e851ff9dfesm7566406fac.2.2025.11.18.16.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 16:09:51 -0800 (PST)
Date: Tue, 18 Nov 2025 18:09:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] ARM: stm32: Add missing build of debug UART init code on
 DH STM32MP1 DHSOM
Message-ID: <20251119000949.GW2125796@bill-the-cat>
References: <20251118231732.577952-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5NSMHfX4GuePnLiQ"
Content-Disposition: inline
In-Reply-To: <20251118231732.577952-1-marek.vasut@mailbox.org>
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


--5NSMHfX4GuePnLiQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 12:17:23AM +0100, Marek Vasut wrote:
> Commit c37a6684818d ("stm32mp: fix compilation issue with DEBUG_UART")
> split the debug UART initialization code into two files, but failed to
> update other non-ST boards. This did not lead to noticeable breakage
> until debug UART is enabled, which is not the default. Update the
> Makefile accordingly to allow debug UART to work.
>=20
> Fixes: c37a6684818d ("stm32mp: fix compilation issue with DEBUG_UART")
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>  board/dhelectronics/dh_stm32mp1/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/board/dhelectronics/dh_stm32mp1/Makefile b/board/dhelectroni=
cs/dh_stm32mp1/Makefile
> index 2f4a301d1a0..429e01453bb 100644
> --- a/board/dhelectronics/dh_stm32mp1/Makefile
> +++ b/board/dhelectronics/dh_stm32mp1/Makefile
> @@ -3,6 +3,8 @@
>  # Copyright (C) 2018, STMicroelectronics - All Rights Reserved
>  #
> =20
> +obj-$(CONFIG_DEBUG_UART_BOARD_INIT) +=3D ../../st/stm32mp1/debug_uart.o
> +
>  obj-$(CONFIG_PMIC_STPMIC1) +=3D ../../st/common/stpmic1.o
>  obj-y +=3D board.o

As a future cleanup perhaps for ST folks, this feels to me like there
should be more code under arch/arm/mach-stm32mp1/ somewhere and not
board/st/.../

--=20
Tom

--5NSMHfX4GuePnLiQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaR0KygAKCRAr4qD1Cr/k
CiUgAQC/cwyzIjDTjlDqBkrCtI8VhOjVOCPVspMPx7Rmn8KFrQEA4wj3I6tF/ulZ
l6M4ZqiyNRDofj6oF2xINVD2ntdCkQo=
=hJHD
-----END PGP SIGNATURE-----

--5NSMHfX4GuePnLiQ--
