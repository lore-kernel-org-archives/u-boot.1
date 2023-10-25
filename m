Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA767C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 13:55:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CCEB86F6D;
	Wed, 25 Oct 2023 15:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F8/VEyBZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF7286FA5; Wed, 25 Oct 2023 15:55:49 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F3A86F44
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 15:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-77891f362cfso73719385a.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698242146; x=1698846946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ajxJafjGPZVAWFcO33N+dDhLV8yQLzPedkFUPAOehU=;
 b=F8/VEyBZXyNWvA27r5HUUY86EH5Q9HGX7FrL1DVg8gkmL6GD1ja/ghK06eR4jKHNeY
 hmdYl4MdzKa6pcujPUtjPmbsCpSHN1KH9afxYks+7TAVUq7KgVoyOBsGduV1jp8S3rLE
 /EYodjbEsUFk3GUvrJq6VBhWV6QtSp/Lt3FgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698242146; x=1698846946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ajxJafjGPZVAWFcO33N+dDhLV8yQLzPedkFUPAOehU=;
 b=lJR3NrWp4U+OmNJUG5LvFQYMAKPpZgnUDUmdtizhn2mZeQeXeyM8wyljLNo051HTR2
 2zGx2FpbNBRwT/XkJw9jRyIYB5CNu/48+6sGpfhF3wJSxc5T3ZaTPXpFhDu8+qbj6MNb
 5K4v/3QRRNSGDWTg/vhlIXE0ML4y2lfrA954wNNfuc61V+Y+320WEfxDxXGZsuh7vY/D
 dSq++BO2T3Llhcc+N+qE2DGOPcjRhvbkxC7CKMoOaLrCgAuNtRCSbXhNjftCLofS8BDH
 ack71HqcrO0PvJzOi3McfljsH276htG9Q9EbgWIt/q7ik9ibDe/4XYhFIsuKIBf49GV7
 pDRA==
X-Gm-Message-State: AOJu0YwOapUYtYPoeyqBx4rlgiQ8x1Hxtj1oOQQwEO/d+QDxsx1FoYbm
 zlQP25iIdr7+PprtHHzdEmOjTdb2dEllDzAL9T8+AQ==
X-Google-Smtp-Source: AGHT+IE5zLuVrz92L9K0MfpBPnAwAQcAET5zUMnYFpixwcvqO5bVaJNuYOsYKRI4JTnkjFIDRVWZLg==
X-Received: by 2002:a05:620a:2982:b0:777:7214:44d with SMTP id
 r2-20020a05620a298200b007777214044dmr20615631qkp.23.1698242146494; 
 Wed, 25 Oct 2023 06:55:46 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 qs21-20020a05620a395500b007671cfe8a18sm4227570qkn.13.2023.10.25.06.55.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:55:46 -0700 (PDT)
Date: Wed, 25 Oct 2023 09:55:44 -0400
From: Tom Rini <trini@konsulko.com>
To: Michel Alex <Alex.Michel@wiedemann-group.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v2] misc: i2c_eeprom: consider pagesize when writing to
 eeprom
Message-ID: <20231025135544.GN496310@bill-the-cat>
References: <AS1P250MB0608EFCD6443148D5D9837C6A9F8A@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
 <20231024231543.GN496310@bill-the-cat>
 <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="a6pnq1kn2p2SVGwr"
Content-Disposition: inline
In-Reply-To: <AS1P250MB06088A3DFC19C7673DB0F551A9DEA@AS1P250MB0608.EURP250.PROD.OUTLOOK.COM>
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


--a6pnq1kn2p2SVGwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 07:59:05AM +0000, Michel Alex wrote:

> Calculate the maximum length of the buffer when writing
> across the page boundary. If the buffer length (len)
> exceeds the page boundary (pagesize), split it. Use this
> length instead of comparing the length with the pagesize,
> because if the write start address (offset) is not at the
> beginning of a page and the page_offset + len is greater
> than the page boundary (pagesize), the write operation
> would overflow the current page and the behaviour can be
> undefined (e.g. at24).
>=20
> Signed-off-by: Alex Michel <alex.michel@wiedemann-group.com>
[snip]
> +static int i2c_eeprom_len(unsigned int offset, unsigned int len, unsigne=
d int pagesize)
[snip]
>  static int i2c_eeprom_std_write(struct udevice *dev, int offset,
>                                 const uint8_t *buf, int size)
>  {
> @@ -67,7 +78,7 @@ static int i2c_eeprom_std_write(struct udevice *dev, in=
t offset,
>         int ret;
>=20
>         while (size > 0) {
> -               int write_size =3D min_t(int, size, priv->pagesize);
> +               int write_size =3D i2c_eeprom_len(offset, size, priv->pag=
esize);
[snip]

We don't need to promote the types to unsigned here do we?

--=20
Tom

--a6pnq1kn2p2SVGwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU5HloACgkQFHw5/5Y0
tyyBUQv8CWJTL04jiYa49jF9t/6I9FvNt+i0U/JPz8tZX4mJ4RuxyS3OpC3bPuRi
zhXQD637tC6CeGNx+kn1ZJmXvAwfqNuvFKbHRk6Jzn/WNRQO2J4J6ginEpDD8g8f
PDqINftAeowVkhT0SXkk2EV+LKSbm4HuGIFsJ13h24Dk4j5HIPkt2Wf5nluqQUAT
pFRCWj6cFXMls5P41F3dzId4eZ2uUw1A178Ga3fGR6a3X5yKJvsN2kDIiieGz61y
Bu9I6MmaXVr3HQyEvy+6/HMnhwR+KYomfT85XkVhkz90nqisjQToJxucsZ1Gvd6+
vClFsjzDb//I9dtCpK59tprKHk051HXPONcMtehFZ2sq5sEb6nEUENR3sU7VOc3s
pEds/gvbXvhMaODUTTzgqVTz2+gwecISdiBa2GK2yqokjQFU4JeHftHSimHtGH/f
gAi7NRIb+bLtIBoFd+o3dm7J4v11DA2wzz7ELoQb/gP2u8vWcFGEda4sGpOXsDIp
RuW00nUB
=uzjP
-----END PGP SIGNATURE-----

--a6pnq1kn2p2SVGwr--
