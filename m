Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DADCC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 19:43:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FAA874EC;
	Fri, 17 Nov 2023 20:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JowV4pZu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5CAB874DE; Fri, 17 Nov 2023 20:42:30 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBFCB874D9
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 20:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41cd4446cf5so13753281cf.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 11:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700250144; x=1700854944; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MqtFy/OumRhYO27WaEYot9nG9K6LY6sT4yFUUk81gSg=;
 b=JowV4pZus1135taQH4JoqitP/w5U0y02BLtAtWkp0uPCg62Kxq9O75GxoGyBQthcwD
 ooRvMVUgAw8iRr5lOBL/F/x2VF8o0cTQUQ/1yGZ1lM+GXMme8VElx48SwHeI3Gj4mPYV
 1hlfB3WFHy6HIgbBwEi5+ITttdcOb2quvPIOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700250144; x=1700854944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MqtFy/OumRhYO27WaEYot9nG9K6LY6sT4yFUUk81gSg=;
 b=uxoXn28EL541+UJbfNgwp38+yJnFgeUkdFDxZrKalTsVxQDgAWcvqlItjCEePW/Yfa
 SI5H3NjIa4UsI2Rv143EBZSVU/6oouBdoS8FCwz2CU2+XICgYTipwltqN//qF6aJo0aX
 ILI7GYxSZIPFkiiTuUZ0vrKw9WiT0fJmhSuCzkdSqoZ/qt+Z76o03Pr47mX3En0jmYr7
 g9qSdcH0F1sQwEZtNvOg6t6yVQKM1bdkPcYcac1NoVGm3AxcUffmsw5QA9RY9kkus1kn
 JaGBzwNLMH+DGuLj4/mva662RC+gxtdbFOA8rUKbWlmOP9Ye+tkllbMJWuLRYWOIMZM5
 sA7g==
X-Gm-Message-State: AOJu0YzWH+IUAJJIOQSV1JjRJ8mN204dl6QINQp5oX61ghvGCuwyIw+M
 IZ7Si4AkXzmAv4nSQkryHNHT2A==
X-Google-Smtp-Source: AGHT+IGCoW8nUXHNKHUaaFnvdZK5lW3fFCrlal+MEmAB25MoQBy1uCowxKXmn4NjFvpmYB7uSDN6nw==
X-Received: by 2002:a05:622a:20a:b0:417:ccef:7fd0 with SMTP id
 b10-20020a05622a020a00b00417ccef7fd0mr720882qtx.22.1700250144652; 
 Fri, 17 Nov 2023 11:42:24 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8548c000000b0041cb8947ed2sm795239qtq.26.2023.11.17.11.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 11:42:24 -0800 (PST)
Date: Fri, 17 Nov 2023 14:42:22 -0500
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Peter Hoyes <peter.hoyes@arm.com>
Subject: Re: [PATCH] virtio: rng: gracefully handle 0 byte returns
Message-ID: <20231117194222.GX170968@bill-the-cat>
References: <20231107160900.2652813-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6jxFjnI3DS4+/fLy"
Content-Disposition: inline
In-Reply-To: <20231107160900.2652813-1-andre.przywara@arm.com>
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


--6jxFjnI3DS4+/fLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 04:09:00PM +0000, Andre Przywara wrote:

> According to the virtio v1.x "entropy device" specification, a virtio-rng
> device is supposed to always return at least one byte of entropy.
> However the virtio v0.9 spec does not mention such a requirement.
>=20
> The Arm Fixed Virtual Platform (FVP) implementation of virtio-rng always
> returns 8 bytes less of entropy than requested. If 8 bytes or less are
> requested, it will return 0 bytes.
> This behaviour makes U-Boot's virtio_rng_read() implementation go into an
> endless loop, hanging the system.
>=20
> Work around this problem by always requesting 8 bytes more than needed,
> but only if a previous call to virtqueue_get_buf() returned 0 bytes.
>=20
> This should never trigger on a v1.x spec compliant implementation, but
> fixes the hang on the Arm FVP.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Peter Hoyes <peter.hoyes@arm.com>

Applied to u-boot/master, thanks!

--=20
Tom

--6jxFjnI3DS4+/fLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXwh4ACgkQFHw5/5Y0
tyx4LAwAs+Gu8FAS1CCVHo+cjtNzZq4gO9qUyLupCEfB37wuG8teZHwfoyXJ4xW7
DuxSAeRzqRKQw1zqeEccpeKUYVd7uQ1dMq05WoIgJYd5bgslnSr5sY0djNK2AjKb
XAhZ5jeynJbLhEZVnORgkWzjtMR9EjTavfw5k0KQYDb+XvO12sKcvScR4EmwGUUU
7HE1tCmIC1eC0zMPZtTYzFsVR9rsdxYfYl9AdXQBamynLY/Ut05lmNSQ3Y662wa3
LQ5KDCGraad0aaPFQIzBlgJvoStMC33hm6XHT+7ckU/pMPkU6fOxOOUcdJqLwbOQ
nZnMFJXDOCeHPQ6dTSnrWixx/buqxMx8X1AZCu260BT8wSZ1y8dcd6W1R9x1cv11
QNFoN/Dg19O5YO78RbQVzGA6zRqWIEbd7IQEvg6WjTDimb1PAmvk1xYtHy5ABXYM
BuKFzlDaQrAYMLeiGnhwXDLdkcolRkE1Y6+f9nm+b1tzelx+tld3dVCRQkq4URuZ
clcWGeVI
=zr31
-----END PGP SIGNATURE-----

--6jxFjnI3DS4+/fLy--
