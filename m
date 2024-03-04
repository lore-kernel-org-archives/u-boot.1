Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44004C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 23:44:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E8A287FEE;
	Tue,  5 Mar 2024 00:44:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s4/jytUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BECB1871C7; Tue,  5 Mar 2024 00:44:25 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6591A87FDC
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 00:44:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-69076df51daso7467796d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 15:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709595862; x=1710200662; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yhYccH7w6Nz1CksNawZMg1yX/rS6aMmst5lpAj81B9c=;
 b=s4/jytUxKyBYMEkDA+FqW76FncqAb8Z7iJHUue3NJrg/Rc0lDZO+PcioT10MKRNs2K
 s06nvPODxVVIk1Uf5N4P03uy+d/uppr0NbfMWVpXP3zlLPwg0lj/+APEVebTE/6HGHb5
 xXMAljHp1KavHARYkjdGhECC3yApFOxr106uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709595862; x=1710200662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhYccH7w6Nz1CksNawZMg1yX/rS6aMmst5lpAj81B9c=;
 b=WTf2nSZtB7fzqpXgoLjVFES7phfavFBIfn1bo2wcAY8M/Bx0Zvv8PrbRZgWh/E4NRB
 GOKHWfscDNF0p8BzrpRGnAX83rvC/jdZg/onEwkXSnA3pGXiH4TZ1GYQmJEdtbWnPazy
 JyEcIqfe7zFFMbA7oMyNDAYP2TEw07OLjx8owN1T3meVn8LIJCWOnRocaGaSvDP9T/Sm
 CH9IncAMXXwuiIEEV3WnG0pH8rQR1V3skiARg+7NB0s5tM8Mq8u+ssziBKqSsJw985sD
 GZCHK5nNcC+VteHJNwhkuAXuX9jp40phEjC45gnxGy1lvLhQuKJrZYlk7TgeWV9+0hYm
 6gzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGEsdG/GusGax2a0h2LOvq4x3TvN8pSBf8AjjmzvJMmL8nT13GaB8on8hc2ReOMGd0kFHjSXLcI3N+g6gv63j15fTK/A==
X-Gm-Message-State: AOJu0Yze0OAfF78Ai7zQUamv/BEwBPtYG7WRNBbJxUNA75YjlkJyEyHs
 rTzT1dHmxyx86Lt8hzggxxWh/lm5Ivgpmiev2GacYqQLNfbU/33Odz4ZBdKDtfA=
X-Google-Smtp-Source: AGHT+IFZYpBHuDSHvcUMgXtJxLZOt2Bs9iau8a60+6RW0KHwupMZyNjFXn6bayk0ozjO5H8JFUrB+w==
X-Received: by 2002:a05:6214:4953:b0:690:74a0:16af with SMTP id
 pe19-20020a056214495300b0069074a016afmr427787qvb.50.1709595862158; 
 Mon, 04 Mar 2024 15:44:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 ld7-20020a056214418700b0068fe6f0d7e3sm5604496qvb.39.2024.03.04.15.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 15:44:21 -0800 (PST)
Date: Mon, 4 Mar 2024 18:44:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: sjg@chromium.org, vigneshr@ti.com, matthias.schiffer@ew.tq-group.com,
 nm@ti.com, dan.carpenter@linaro.org, u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH v2] dma: ti: k3-udma: Fix error handling for
 setup_resources() in udma_probe()
Message-ID: <20240304234419.GT1523872@bill-the-cat>
References: <20240220100451.1053667-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SHcA5EWYDOA0qsw4"
Content-Disposition: inline
In-Reply-To: <20240220100451.1053667-1-s-vadapalli@ti.com>
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


--SHcA5EWYDOA0qsw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 03:34:51PM +0530, Siddharth Vadapalli wrote:

> In udma_probe() the return value of setup_resources() is stored in the
> u32 "ch_count" member of "struct udma_dev", due to which any negative
> return value which indicates an error is masked.
>=20
> Fix this by storing the return value of setup_resources() in the already
> declared integer variable "ret", followed by assigning it to the "ch_coun=
t"
> member of "struct udma_dev" in case of no error.
>=20
> While at it, change the "return ret" at the end of udma_probe() to a
> "return 0", to explicitly indicate that probe was successful.
>=20
> Fixes: a8837cf43839 ("dma: ti: k3-udma: Query DMA channels allocated from=
 Resource Manager")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--SHcA5EWYDOA0qsw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXmXNMACgkQFHw5/5Y0
tyzqSQwAlnzsNdpuN/2Sx2HWiLtkVReypZVCDiStQTCb936AmRESS3EDcMIJ1rtz
V7YhbNlWamWLfURf0Zs/lYR0NfqF/fQx9BrmBHo+AVJaSFJMQQ4p4v456LuKIMDT
/xyorekt8kqEaxE5zNw4rTR6k0G44ap3DpVpLwzhxWDPBzBULFxZZaiapYMgTcIq
3Kg1uTVMGQF869mEo/tHLBwHy5OY7yXNjqtw9n3ERSQROlSwpTJ8jPJ36FOaxhus
fPnUNcDQWF1HkbEkoDsa6DRzmD11+xqhe3IRxBGF5qAt32bW7s0bEh5KcufQFoWd
I6T+lsn7HkUKLpiugXsb5Z8RLTKupmZB1gxwjVTmi796ciALItLGW2nsFh2S4zyA
sHG8gKPLgFe+EZhZ2LQplKb+qgu2JnHTAJ4pII7QrgOm8k2ek98HaUxfMMmu2GPX
ZFN+Ep/WpPGfCz8nQc7MCuqDerm0KtW4cGJ29h0scz+Azs6mvT+JuU9GzSwHYEPR
FRPw/wwu
=UG8j
-----END PGP SIGNATURE-----

--SHcA5EWYDOA0qsw4--
