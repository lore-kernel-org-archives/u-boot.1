Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3256DC4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E90987883;
	Fri, 12 Jan 2024 14:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NtY0QYlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 038518797C; Fri, 12 Jan 2024 14:26:13 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F297785E44
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:26:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5f68e2e1749so54733187b3.2
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705065969; x=1705670769; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9lDCI5HpGiuhoAaNAL9cgeSZ+HRpeV6ITqNguSKYgCI=;
 b=NtY0QYltvaT0BSp42bO0oxhBOzVvAsTD3KLGAnOykuyYxBtZEy3zsuU2t7AjdXMlqY
 atWOeWBz+ogTjwCZ8zvSRCLS/1tygmDWd1LZEbJuOe/jGIeghjxLwijZQS3oJjwWv06/
 xHO6IYZzDYZJt6pDb1/L4c8RnF28F+pO2U9RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705065969; x=1705670769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9lDCI5HpGiuhoAaNAL9cgeSZ+HRpeV6ITqNguSKYgCI=;
 b=fguuycn1g/rxxxkhGTfGHWsrG6f38FEGZDqVQe0cGpVrZSayTK6Ap+xWfIyd3+lwiR
 fFkIwZpKxKyNewoQa8TnsCt8oHh0EhjyV+tbjHF2QAkuNXDCMxZryBPONaiufB0lF74k
 TGfhBHU93UnSAKAUDbHRrZTXLzUfbY5wAVQ5VW42vdIsSIwid2tXd2mnH9xzJ2F6A3Y+
 hvWkw236+b6FIgIs3pUt4e4WzzO5MKl9N/4qnaT+o50Xrzptiu6fXLX6SrzbII6zrwwV
 wY2y45/LoM4BPT0MyQrNaSn8K3I528WL1lhMmDROngglFTySXheTfLSU40xwXTVtH58U
 qnJA==
X-Gm-Message-State: AOJu0YwJ5yGEMzj+afSJwry6MHKnCxlfAmuMKDpWIYjwg0VMyNlsgqip
 2ML3Ge+67AmuTeq5H2AEIMjnq2NJxpbnbQ==
X-Google-Smtp-Source: AGHT+IEDaMyX+wzcNzqag/2tY2n/o8as2FvJC5zrv+qWQjUGJM6n+2D5glibRtEmLyj51Ey8ZQ5PVw==
X-Received: by 2002:a0d:ea03:0:b0:5d7:1940:7d6c with SMTP id
 t3-20020a0dea03000000b005d719407d6cmr1252264ywe.67.1705065969696; 
 Fri, 12 Jan 2024 05:26:09 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ft18-20020a05690c361200b005fa813ac693sm1305138ywb.48.2024.01.12.05.26.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:26:09 -0800 (PST)
Date: Fri, 12 Jan 2024 08:26:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, sjg@chromium.org, afd@ti.com, vigneshr@ti.com,
 u-boot@lists.denx.de, dannenberg@ti.com, srk@ti.com
Subject: Re: [PATCH 01/10] board: ti: am62x: Init DRAM size in R5/A53 SPL
Message-ID: <20240112132607.GO1610741@bill-the-cat>
References: <20240112064759.1801600-1-s-vadapalli@ti.com>
 <20240112064759.1801600-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="I7u2lpkvi5mvJCK5"
Content-Disposition: inline
In-Reply-To: <20240112064759.1801600-2-s-vadapalli@ti.com>
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


--I7u2lpkvi5mvJCK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 12:17:50PM +0530, Siddharth Vadapalli wrote:

> From: Kishon Vijay Abraham I <kishon@ti.com>
>=20
> Call dram_init_banksize() from spl_board_init() otherwise TFTP download
> fails with error "TFTP error: trying to overwrite reserved memory..."
> due to lmb_get_free_size() not able to find unreserved region due
> to lack of DRAM size info. Required to support Ethernet boot on AM62x.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  board/ti/am62x/evm.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
> index ad93908840..35f291d83a 100644
> --- a/board/ti/am62x/evm.c
> +++ b/board/ti/am62x/evm.c
> @@ -85,6 +85,9 @@ void spl_board_init(void)
>  	if (IS_ENABLED(CONFIG_SPL_SPLASH_SCREEN) && IS_ENABLED(CONFIG_SPL_BMP))
>  		splash_display();
> =20
> +	if (IS_ENABLED(CONFIG_SPL_ETH))
> +		/* Init DRAM size for R5/A53 SPL */
> +		dram_init_banksize();

The list of conditionals in common/spl/spl.c::board_init_r() should be
updated and probably use SPL_NET as the option to check for.

--=20
Tom

--I7u2lpkvi5mvJCK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhPe8ACgkQFHw5/5Y0
tyzmvwwAhi/UKET1FhKqr8inCLVFB3YX/X5ANkSraZGKCKrr+JTNDECa4TCSRI1I
BfK1HXzip9vbtYwOW35hMzckYmq7S2SAoQ+f/tX9c9X35hjP3iB+Zv8ktnIQVMTZ
jZZfUCKEt7kW9LhUO1U9aymy1410n+ZG+E2x+52CyLhn1L0SWvhUd57TGGIwxvhR
/Yjrsm+Kze6udn+kDysrveBjtUESYTPMP5eA+ryGmmRGUGPperjOf/I//yrcSyMW
nxT2xGlp/IkkQ+XNduig6WEry7t3qV/D4kdWEGH3efbRq6HFe8zVEMtHV7jIH+WH
kvTKJqv9fMUSFHZ/xy4qchnbK9YXEvNe1Q/ejWQc/NgKU2YNif7aEAFN6tUMlkjI
llxA6xByKNgrTXpa8FPO/0bGOCRWzWokBa3zlo4UbuOmzTLuiChht8AA/Fskhfqk
sh+1DoWiobhkZr7b7WmACHye5J4Hpl4mdF0X3tIqu5EZA9SCYjjkO7FY/dlW778t
B3s1zhUC
=5fKe
-----END PGP SIGNATURE-----

--I7u2lpkvi5mvJCK5--
