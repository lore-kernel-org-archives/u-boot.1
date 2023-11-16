Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79568C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 23:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E58186ED6;
	Fri, 17 Nov 2023 00:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eIMdwPxP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FBE586ECA; Fri, 17 Nov 2023 00:53:16 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E142F86053
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 00:52:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7789cc5c8ccso122027685a.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 15:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700178772; x=1700783572; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G4gxXUvh7P+zZQ8yNmWvHnmLCxgoa2S8x2teU+yY6vA=;
 b=eIMdwPxPm/iXPezXHLJ6DcAEksAlzhxnxxTxqtmgCS2ZH4GrXA/HOnb2ZUFMwA094X
 Y+Jf2zqLGjSQ10zNNQdvrkXAIiQwn9co5OdkeCEfI8fdBPxBAAaqJGW14DzL+leusYHT
 h4hDxSPbFkjjmtAWhsxlqHgH/oKcZv0vywMmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700178772; x=1700783572;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G4gxXUvh7P+zZQ8yNmWvHnmLCxgoa2S8x2teU+yY6vA=;
 b=pzGHOtZ6YKiXbYxf7OyvJjliklRTEyMC7Xo+Jfa4EAEIXm8U06hXbPDx2zBDjpgIa+
 QG0V+wY4wmvnpYvvz2AWQXUEBEESHFFmACC54yfdCjBe3nfoOHsO9Zlb16N2SLBvEvK4
 aL8mZ19ohhDGPx3xZbkcbE22lAwUs65kvgHHReHHxWP76DhUcj1HlYemtfJDDa0WYIS2
 mNqQ865YHW07JiN0D5nsScUA7EcMA3yoVnqInpbY2+bvcbkDM3FmUuzDca9Cr7PtE5wS
 qMBlG9mWXyZaJD04rba9QaeQHztfLCCTEYncq5R1z8eYA4rDBlqpggzMvKgToKBVfEv+
 xVhg==
X-Gm-Message-State: AOJu0YzcHa6jBccX5eU8m0ZC/K+JhquHrMNBDHNW3HBgyDobVWbPUrci
 YCZK7Wzb8MVofuy5dNopSQfNpBdj6o/SQYOkrUk25w==
X-Google-Smtp-Source: AGHT+IHiDN46oTn5eOU3vsNqZ0BBT+hhRiRK1nToAAyoMSKfrLaqtUZzADrFv6/Od2RNIPzaZ760Ow==
X-Received: by 2002:a05:620a:2587:b0:779:e19b:64f5 with SMTP id
 x7-20020a05620a258700b00779e19b64f5mr4833902qko.21.1700178772524; 
 Thu, 16 Nov 2023 15:52:52 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a0cebc9000000b0066d818fa482sm175570qvq.115.2023.11.16.15.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 15:52:51 -0800 (PST)
Date: Thu, 16 Nov 2023 18:52:49 -0500
From: Tom Rini <trini@konsulko.com>
To: Samuel Holland <samuel@sholland.org>
Cc: Stefan Roese <sr@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [RESEND PATCH v3] serial: ns16550: Enable clocks during probe
Message-ID: <20231116235249.GA623444@bill-the-cat>
References: <20231031050611.55422-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lu96YwNflfOz1xXu"
Content-Disposition: inline
In-Reply-To: <20231031050611.55422-1-samuel@sholland.org>
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


--lu96YwNflfOz1xXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 12:06:09AM -0500, Samuel Holland wrote:

> If the UART bus or baud clock has a gate, it must be enabled before the
> UART can be used.
>=20
> Reviewed-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>=20
> Changes in v3:
>  - Switch back to the original patch, now that the phycore-rk3288 build
>    is fixed by enabling LTO.
>=20
> Changes in v2:
>  - Only enable the first clock, as using the clk_get_bulk() API pushes
>    a board (phycore-rk3288) over its SPL size limit.
>=20
>  drivers/serial/ns16550.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
> index 6deb1d8ddc5..a206d00919c 100644
> --- a/drivers/serial/ns16550.c
> +++ b/drivers/serial/ns16550.c
> @@ -514,6 +514,7 @@ int ns16550_serial_probe(struct udevice *dev)
>  	struct ns16550_plat *plat =3D dev_get_plat(dev);
>  	struct ns16550 *const com_port =3D dev_get_priv(dev);
>  	struct reset_ctl_bulk reset_bulk;
> +	struct clk_bulk clk_bulk;
>  	fdt_addr_t addr;
>  	fdt_addr_t size;
>  	int ret;
> @@ -533,6 +534,10 @@ int ns16550_serial_probe(struct udevice *dev)
>  	if (!ret)
>  		reset_deassert_bulk(&reset_bulk);
> =20
> +	ret =3D clk_get_bulk(dev, &clk_bulk);
> +	if (!ret)
> +		clk_enable_bulk(&clk_bulk);
> +
>  	com_port->plat =3D dev_get_plat(dev);
>  	ns16550_init(com_port, -1);

This causes some failure to builds on platforms where we don't have
clk_get_bulk available such as lion-rk3368.

--=20
Tom

--lu96YwNflfOz1xXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWq04ACgkQFHw5/5Y0
tyxJ7Qv/fYQGfgzDChh5ZI5qwlUp9pfYbBftYq1tn8mRaK7q6WEFQnR1ExPdH49O
VTSLD6iksA3cGCDOZc4+uJIa9ZC7IldCY4A5w0bnSewuBJ/CcPegOK1r84Ydgx1Y
BcH1WUWYtCjWMe9o301zwLRAfcZuqiWbcKtv13sv3VurUcmRxIV/FIN9JfArRvsj
hQfFySrKGi7sWehd2nr5OEmIkocbGAWllKtqSCIJ29lYjlw22dTbWfqp3/CjZ3oH
x9pXewfsx4SA1JBJBgEI07Br8JQ9TfJ493oyz+geYaYo+cpnX9FcXO4XAW7n+kbV
OEhf/E15lhfAagZwkFCk+7zA/QOxCSGku3GZ3RjRdwSV5vZ3nrJgdAyXgWbZU4zr
XHf+Ui25EfVXG82TqxQy31QZe92IvUgKhgexoaARO4EAEnRvHeXBVh8FqQKCQ1Ax
oNqLaJqT9rKxoeS/gwsJ+ucbn8V3THGI9K9iInJQo5P0YWPhpB20if9PI0hTkOZ2
lpXOU10Z
=idaD
-----END PGP SIGNATURE-----

--lu96YwNflfOz1xXu--
