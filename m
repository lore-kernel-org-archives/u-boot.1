Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A59C83F1A
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 21:40:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C01E8340C;
	Tue, 22 Jul 2025 23:40:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLdSox9q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3C618340C; Tue, 22 Jul 2025 23:40:32 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608D78331F
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 23:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-615df2e8c27so1510847eaf.2
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 14:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753220429; x=1753825229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WNDxoJ92xc7IIqXUN1/ZJO5ui0+097QTgCvIhpcNPI4=;
 b=dLdSox9qhQ/nX7n8jVcJE/XsUnVSpI+O8AJwSwjDY4YE6sg/6+eapOOmdhXAfiw/xH
 ZTxVI7csNGogacL6adqs6Jyz47SGyx9i/5J2v+HmLFGdQzlpq4Oi0HQnuXJoIa4jseHa
 ywYwY1wiGJwgSCjgOYfS/BXXc0buxaaiBZCCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753220429; x=1753825229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNDxoJ92xc7IIqXUN1/ZJO5ui0+097QTgCvIhpcNPI4=;
 b=PfyaWSukcS5mLrb6M1EAUG2+na5QNWNI/+pNXletPKusyCLdm20aYQljgB1EODohIC
 mnRxy3Ks/GqxwmVBLdvx0gTyw5yVMxdhWsDpf49Wmp97zCDZKZoPP/iXzZjHA6p8/it7
 6oQ52d7SxeVptORdU+rOq0W5CS7mMGEH6DeDiIQ9ajdTX5uPAux8Isqjp+Cr0Orzh/Hn
 XfpbGKKgp0IrM8mb+D9P2De0aVpVr54cJEZrNyTgAvOnabipLyiKFmX1Jo/l+IfDJITB
 TpgtpO3Wh2826RXOmQFLD2jH0dmvPHulIqzUygl8goplvODtVvrxCW/cXCe2RomxPlt1
 6EYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiGHjz6j3X8OawPtOxly6L9F6AeedGHSYzd1SPJ5Y4hpE1mKgjxj49R2RE9NvCB0M5aiv3ER0=@lists.denx.de
X-Gm-Message-State: AOJu0YxfU2d3mC8SJYGOGAhgr9wjFI3xd0CTRY0/hAMHna/sE9/LGQTt
 KEdp25hl2GDq1xmA/JEeYFeXfgsJMhqhxZeUceRTAmWeYAM9HTcCxM1w7Ude7YVUwZI=
X-Gm-Gg: ASbGncuHc3T6GW3FWdqY8E5d9+VO7ZWP570HFp0QC+3UMfzEySQNO9Y4NgEwaE+4kMq
 DRb5xUIdakBub10wTWn9JfqUlW6oKWRpV50oP3j1iKtr9tCMKM2Egh7PT80is/Hm87VebK40cZh
 CoL+vBRF0FA8oEdyzKq5i0obWx3Y66PHDSR3kUEmd21+2tCmb/gENvR7gGAjVZJYs40i5ytHQFa
 Qwx5EDgW7TyDolfspdjXJZZxf7jOGeloLP01tTEEwa3rj+PUTmlEQu8oGXbeSvEZ6H7sgnbFlOC
 GEdEGQlh/K1CHZ20gJf4NLTmvwBRTWbBFVqc0/rp8cciDJTM0omG6/JkQn7xjGVMcn3uPWFMZvX
 cfiFbdFIwzbd/FrHAItuJ6t5OtfaSjkPMjN0ayLwgetoSElV0zZRWJru5
X-Google-Smtp-Source: AGHT+IEX8ptwixr2JV+XPZecgXVB19vLReSf8abhjCzJYO4BFkS4hMCDgQezVO3NdC7lBF6nPhAaYw==
X-Received: by 2002:a05:6870:700c:b0:2ff:a5b2:81de with SMTP id
 586e51a60fabf-306c6fdcd93mr428498fac.17.1753220428891; 
 Tue, 22 Jul 2025 14:40:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30101cd7f83sm4367308fac.18.2025.07.22.14.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 14:40:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:40:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de
Subject: Re: [PATCH] imx93_frdm: Add initial board support
Message-ID: <20250722214025.GJ2847763@bill-the-cat>
References: <20250722203736.1792103-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W017OfFHVDDP9YNW"
Content-Disposition: inline
In-Reply-To: <20250722203736.1792103-1-festevam@gmail.com>
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


--W017OfFHVDDP9YNW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 05:37:36PM -0300, Fabio Estevam wrote:

> Add the initial board support for the NXP i.MX93 FRDM board:
>=20
> https://www.nxp.com/design/design-center/development-boards-and-designs/f=
rdm-i-mx-93-development-board:FRDM-IMX93
>=20
> Based on the NXP U-Boot code.
>=20
> There were attempts to upstream the board devicetree, but it has not been
> accepted upstream yet:
>=20
> https://lore.kernel.org/linux-arm-kernel/20250526-fpg-nxp-imx93-frdm-v2-2=
-e5ad0efaec33@pengutronix.de/

OK, that's good. Note:

[snip]
> diff --git a/arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi b/arch/arm/dts/imx=
93-11x11-frdm-u-boot.dtsi
[snip]
> +&{/soc@0} {
> +	bootph-all;
> +	bootph-pre-ram;
> +};

The bootph stuff can be upstreamed.

[snip]
> diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
> new file mode 100644
> index 000000000000..c2672fdc2365
> --- /dev/null
> +++ b/include/configs/imx93_frdm.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2022 NXP
> + */
> +
> +#ifndef __IMX93_FRDM_H
> +#define __IMX93_FRDM_H
> +
> +#include <linux/sizes.h>
> +#include <linux/stringify.h>

These are both unused here.

--=20
Tom

--W017OfFHVDDP9YNW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIAFRQAKCRAr4qD1Cr/k
CkAOAP9qIfifA3uKTYPHYJqvQddtl2ubiagSa6THUIxrtVWMygEA3rmtWSp8YgNr
arcSY/p5zA+Q9whnN+JZaG/bnhX5ngw=
=040N
-----END PGP SIGNATURE-----

--W017OfFHVDDP9YNW--
