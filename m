Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F1FC072A2
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 00:57:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D96386E96;
	Sat, 18 Nov 2023 01:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AFqWyaGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70CCE86E96; Sat, 18 Nov 2023 01:57:26 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E03E786DA2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 01:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cbd2cf3bbso32131291cf.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700269037; x=1700873837; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KxlTxkkrwX+IWZG3vN5vwWALE+jeOJpywdeK7IEINgw=;
 b=AFqWyaGrnyZCKI44D9klAlA75JeYsT9X15stsMTVQmS830MjRCWwurS00y+Z0VviRo
 gAtVG2RBJ2bgwvm4GY9LF6dGUuk5Rd0o+yucDqjp6wapsbNRs4d+qBVIuX7n9BGq6ZAr
 xEW9DEI3gVsTNc+gs/gzL5kHYPrIcMmpo9cXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700269037; x=1700873837;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxlTxkkrwX+IWZG3vN5vwWALE+jeOJpywdeK7IEINgw=;
 b=i38nGkPixLk+mXBZ0zKwRp83rEd11O/P/tQ4YkwjZt2CDlF1JqxeUWSLebGBmJN4DJ
 rpEOShbJlPSkaxQc+4HkrNgIHBORHPtErm7rBvggZ0JPbhj0an5cHkiSWi9EvfO4wAMo
 D3mRAVX/yeKK4t6ALuBqHETgiBGtwAl8oHW0Ivg7dyXYUAVD/LGQ4BaU5HKuAUivuwqR
 mYYPJnLLPsinqbBpAmAVDyIXOO/AFp9fBMmiT6B1gd0d8f9i5q9BuZ8duX5ra5vd8gt8
 pSKmNzd2CTWrSViFlZCwQRuv4c0cAh0z7V/0ABTI+bFzq5gB5V16+DeRjys/t62jikK0
 HMug==
X-Gm-Message-State: AOJu0YyTJAdQFUOMuul/sC6MqD7Pd6nGW1W6KLLIGai/xfqc0XSgu+ch
 w9ODUNfSIbe0YWHnOjV8Gm11s3PO+Dyobfq7O/KpQw==
X-Google-Smtp-Source: AGHT+IGXv0hx2GyLcvX6rR35QJWFpqms+aDpON/ZdQI6DcpMuh8dVrA2ES35THfICIdCiD858NCNoQ==
X-Received: by 2002:a05:622a:408:b0:416:4cc5:2f51 with SMTP id
 n8-20020a05622a040800b004164cc52f51mr1364062qtx.1.1700269037334; 
 Fri, 17 Nov 2023 16:57:17 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 k9-20020ac84749000000b0041cbf113c28sm965606qtp.40.2023.11.17.16.57.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 16:57:16 -0800 (PST)
Date: Fri, 17 Nov 2023 19:57:15 -0500
From: Tom Rini <trini@konsulko.com>
To: seanedmond@linux.microsoft.com
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de, pbrobinson@gmail.com
Subject: Re: [PATCH v5 2/3] net: bootp: BOOTP/DHCPv4 retransmission
 improvements
Message-ID: <20231118005715.GG170968@bill-the-cat>
References: <20231118004826.157835-1-seanedmond@linux.microsoft.com>
 <20231118004826.157835-3-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1pEDLyRJzgMqMi54"
Content-Disposition: inline
In-Reply-To: <20231118004826.157835-3-seanedmond@linux.microsoft.com>
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


--1pEDLyRJzgMqMi54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 04:48:25PM -0800, seanedmond@linux.microsoft.com wr=
ote:

> From: Sean Edmond <seanedmond@microsoft.com>
>=20
> This patch introduces 3 improvements to align with RFC 951:
> - retransmission backoff interval maximum is configurable
> - initial retranmission backoff interval is configurable
> - transaction ID is kept the same for each BOOTP/DHCPv4 request
[snip]
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ae846b204dc..93bf752035c 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1717,6 +1717,7 @@ if CMD_NET
>  config CMD_BOOTP
>  	bool "bootp"
>  	default y
> +	select LIB_RAND

This should be "depends on LIB_RAND || LIB_HW_RAND" and not a select as
either one provides the needed interface.

--=20
Tom

--1pEDLyRJzgMqMi54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVYC+sACgkQFHw5/5Y0
tyx72Qv/QAhSqFjvRRvTBB5fHSTBdw58jJl9Su9yVZ4RGfKdY4f01elbsAv2/+0d
yGMnDOC/U/Rx/ycoZtGSA2nHicMCDJegLx4r8LFwm2iPrpEJGz1GfY39+nCgYlBe
m6TRoj6qfyZnWZ2PmYpvNDM+3DrNau210nTDO1HCCA2xcf8rvSj6tIK1EZuLosAm
e+FOCB77eOdXFX7yzoWfnQvw+jsyhqkCnln/9vnWU7OTtecGL1FRDW/Iant1CjFj
IiT8nlFMNX8BbcsPypW65TbdqSUYxGgz5mlKuNFrSy51Fx+A3sDAw/n4/EWwFdF/
dww6+d7xVoRpx5iit/opQXnDakceCEL8PI47tgw7dcYa8VCjPaXvBgYuPDTkyRwX
8DvJ39+Q5LO9WIqll5sJcCXbZxfSgX6BJo4VDHdCvhxNFmUrbS1NRbVsr1G98Mg6
PGF42JXpcCbwkl3raGNJQcojMDqyCL6OWDN3Tax5cjlnQZ9B4oSrAhtl2+DFzvI/
ZOrOfb9O
=3KL1
-----END PGP SIGNATURE-----

--1pEDLyRJzgMqMi54--
