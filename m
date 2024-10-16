Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A22D2A559
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 20:34:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B27CF88D5C;
	Wed, 16 Oct 2024 22:33:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L89J7+hr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B02B788DE1; Wed, 16 Oct 2024 22:33:58 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F32F889C5
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 22:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so1240746d6.3
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729110835; x=1729715635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gzqr1CZ/CLWH23Pvg8zgD33mMX6r3gvcBJn4ke4VSUM=;
 b=L89J7+hrtaRYyC+3XniCwYDn2l5cBVdcPY+C+hhIn8s8wFcWTL/eO7YtJ7VkTg9RaK
 2ntf8OvsqNp48qQv7DNczWFsqZt03RwqPUdrWS+iBM6AyppwzJjjvQMiIQyC4TPE7DG4
 nDkTfy5rgzEubj2DcbBLFxU2/3JnJQiisMcvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729110835; x=1729715635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzqr1CZ/CLWH23Pvg8zgD33mMX6r3gvcBJn4ke4VSUM=;
 b=cQgucDQdzpvF/0PkfClmnVOPAIPvXfAmnx+d313ztFkkPDPOUhjQ2L4FBy+S7TyPAV
 eGPst8SbTiaVtv+VlNj0Agvlh8cE+EV+OBHT6EegTJXwSokOrOlllDUfgQkkhcj4+lEO
 WYTGAfMt+/n+YJGGUpRiiWEYJjEmQ1sLvZWCB8ThaaX54Wcn5lfTK4XSZBYSANhk4K0i
 5f7feLj/wyn32aabqlUERsQSbI8G2khJqFXx/Xz7p7ye3WYpNhSmR5wnt36+KUhMYBKe
 YVZDdJEMAmaMVqnIlM2cXeESTOZrUnVRvYmhZ767o7ztNhQmJD/FA9OIUKwySua6nw3/
 0psw==
X-Gm-Message-State: AOJu0YwU3O2IxB2CQbxryJz1kApESHwYmzRZc57WdGPqltkEh47PAApc
 sZZfeSD+QrWxdrBcLR+UHz5iQYnAqd/iAAyrEWEunjDcehyIpgrrhUx1cNFtmmbiyMgoSHy9HqI
 4FEM=
X-Google-Smtp-Source: AGHT+IHyhG9vKvRqhgKSoJ7LUlomcl745LrDSd2U6hlNwq+RZjhz4Ue6GC6KtaqPxkcH8re1r61RQw==
X-Received: by 2002:a05:6214:4489:b0:6cb:ee38:1bf8 with SMTP id
 6a1803df08f44-6cbf9d1f81emr276104596d6.13.1729110835470; 
 Wed, 16 Oct 2024 13:33:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2295a31bsm21104536d6.101.2024.10.16.13.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 13:33:54 -0700 (PDT)
Date: Wed, 16 Oct 2024 14:33:51 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>
Subject: Re: [PATCH v13 00/21] Introduce the lwIP network stack
Message-ID: <20241016203351.GH4959@bill-the-cat>
References: <cover.1729070678.git.jerome.forissier@linaro.org>
 <172910926540.24133.2953899765717446506.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DhzEkc5APECEgctf"
Content-Disposition: inline
In-Reply-To: <172910926540.24133.2953899765717446506.b4-ty@konsulko.com>
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


--DhzEkc5APECEgctf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 02:07:45PM -0600, Tom Rini wrote:
> On Wed, 16 Oct 2024 11:56:22 +0200, Jerome Forissier wrote:
>=20
> > This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> > library for the network stack" [1]. The goal is to introduce the lwIP T=
CP/IP
> > stack [2] [3] as an alternative to the current implementation in net/,
> > selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> > reasons for doing so are:
> > - Make the support of HTTPS in the wget command easier. Javier T. and
> > Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> > so. With that it becomes possible to fetch and launch a distro installer
> > such as Debian etc. using a secure, authenticated connection directly
> > from the U-Boot shell. Several use cases:
> >   * Authentication: prevent MITM attack (third party replacing the
> > binary with a different one)
> >   * Confidentiality: prevent third parties from grabbing a copy of the
> > image as it is being downloaded
> >   * Allow connection to servers that do not support plain HTTP anymore
> > (this is becoming more and more common on the Internet these days)
> > - Possibly benefit from additional features implemented in lwIP
> > - Less code to maintain in U-Boot
> >=20
> > [...]
>=20
> Applied to u-boot/master, thanks!

With that said, checkpatch.pl finds a number of style errors under the
new U-Boot code, please address those shortly, thanks.

--=20
Tom

--DhzEkc5APECEgctf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQIywACgkQFHw5/5Y0
tywxpgv7BvH74avZexwlrCyNHK1yQhZgIH0b0ZZ0puL4k/gTshXO6sS0c/w6lO++
R/psgKZjJIgcoXW1reU6mGvHKZR2mfCD97o516EQtDBntWOL+Q3BXyN8tjnMfPDd
xKMYlrkzVAnZWZpIhYmkwjqN06co53NuIWZOavbZqEUMCQ1QKhAOMYZb6fp38Dj8
30p/8X6WQecOZO9D04aAUwpG5oEAPOT5ng+dYdHaNaDP3LWtULrM3bY0LTP3vZzf
TmbhRkeuA3DnYcagW6XCb8+gML9MDVgeWR1Sa9JuD101bXKKhwtTq9qiH9+NHv5r
OEC9O6N7lBCdkY1Cwjs9T7/+IudLFzBTh8PyCDsDU3fyd5c2h4VCHOHqCgOrNMs7
BvUrPp0rRur8WPxu57cu4g+/aAJjR/oAnKIt1qqphfdvglnwhPMLUJuTPSO4en5y
IVNIEdnqJe5z9qQgnSSUxSurXwxSy3/sza3m4GAPn+9OviNavgGIC3Ilpvyv6KFU
TzlRbVBj
=/E+6
-----END PGP SIGNATURE-----

--DhzEkc5APECEgctf--
