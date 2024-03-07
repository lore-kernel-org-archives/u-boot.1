Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7DFC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 12:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75A6987E52;
	Thu,  7 Mar 2024 13:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YHkPQanZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9175887E52; Thu,  7 Mar 2024 13:46:18 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4996387DF6
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 13:46:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42ee33b2d58so5326161cf.3
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 04:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709815575; x=1710420375; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YdGbiUV3PCiDcdvlTycSmQOvcgVpjLTZxu6z8zXb4Gs=;
 b=YHkPQanZwQ4f0nAMFLMv8KwAwCkfoVY39I446bZsdhgajLK4Vxzsptpke7kjuj+pJB
 hWdFUHZCcPZJWQ/Ba+vCWVQYdf1I+bnsgwubY5MoJpFkEEknFzpAVPeXiTo7WQehE/Je
 8p9XLusUqOrhWVc65imV/t1WxWeMzIfRQ3Ru4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709815575; x=1710420375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdGbiUV3PCiDcdvlTycSmQOvcgVpjLTZxu6z8zXb4Gs=;
 b=inzMUI5PIgfPA36N/v1qypok6m+yycSP2vcNFroPC/qYzt1Hp9z3B4myYUgZyCEJYZ
 x4wnYiLIMdPV3vsUEz8vNWlwv3AaBh/gNArHauTK9SurtzyrQpZya9q0R9MaNVTxff0t
 g6FaMnu3A5Dwzci35dQkB7BtjnZy6zTQxLqpCwy73NnAbR7dPEQPxwLfXoRnW2CQaxPh
 O6m7w7wsmHfUPYHmLKn4qlbX4fyPkHwsuw8OgnGwHwVYypLPrVUsoTw8iHj+gjqbPx0a
 WBre9hOQ9lk+tx8D1EOcb3X7x8cYjHoZhdBhHjOoolivVbpJJ6ODptPNfq6kanDNbP03
 wVzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgOCBVbh6PGsl6Jc6qBamh3YiZta2VBQh8sovQN+R0sN8GCoScBRCBUEkBjVqkNwGRMpFyCa9bILWWMEJ0IjCw8gK1kg==
X-Gm-Message-State: AOJu0Yza7Mk4b4g6JpLltDdhXk1o9J8earkVgMD1zS6kIN9/QyYACzkT
 MXBuuzBAvphTnY2031s5jOct2CL6e83s7yAG3ZKN5afXigg8KVK2DTnVJTte+mc=
X-Google-Smtp-Source: AGHT+IFRCTNBf6FDKJWrPiNtV7pCQb3qGosk/BTX9DIMS6wutWZTi/vam3sm3jhIZYs5GtNawSqzVA==
X-Received: by 2002:a05:622a:248:b0:42e:c3d8:3861 with SMTP id
 c8-20020a05622a024800b0042ec3d83861mr9178436qtx.23.1709815575066; 
 Thu, 07 Mar 2024 04:46:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 d17-20020ac85351000000b0042f148f6caasm1349976qto.78.2024.03.07.04.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 04:46:14 -0800 (PST)
Date: Thu, 7 Mar 2024 07:46:12 -0500
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 u-boot@lists.denx.de, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Message-ID: <20240307124612.GA4110939@bill-the-cat>
References: <20240228120645.958316-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aLwQ9E+QfQQN1nob"
Content-Disposition: inline
In-Reply-To: <20240228120645.958316-1-danishanwar@ti.com>
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


--aLwQ9E+QfQQN1nob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 05:36:45PM +0530, MD Danish Anwar wrote:
> Add APIs to set a firmware_name to a rproc and boot the rproc with the

> same firmware.
>=20
> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> load the firmware file to the remote processor and start the remote
> processor.
>=20
> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
> Kconfig so that we can call request_firmware_into_buf() from remoteproc
> driver.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

This breaks building on am64x_evm_r5 am65x_evm_r5_usbdfu
am65x_evm_r5_usbmsc in next currently, thanks.

--=20
Tom

--aLwQ9E+QfQQN1nob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXptxQACgkQFHw5/5Y0
tyzaDwv9GKRAi2awltvTzMabcLFAJsMpSvTRlkb6aZ6vCY+vCrB5efN33uiyL6xo
z6pXR7sc+ddIMt+Danzq0o0rUhXR7lmeS8OWas94eUPEYKriyoBZINVNud3FEC6t
zmTjTd0hoQRudex2cf3N8lNFnAmfeT0vM0TBOMWn1DeUXe62ng62LZ3gRzMDu/VN
XOC7P9T6aPdOOxFFVw9M+COqEqG87RbGi6JymSwtwTarOxtFtvaJNQqhXdbPTZFk
Jd5CXNGShAw8U1qJWCvKORwWpMkg3D1hnnPWVUNtSXFobQ4lDrEsfa9+64MpFQ2J
BwUFy60djqP7rb/+TQX94MeYe3FE3FF6MAos9BcFQKBVdtqsFpsGSaaNCp2ATZn3
FZ+SO5LfdLiOmprJJ4BcvM4NIAaHL3EYAOruuyhyWQb9IMKy04jIrFRl1zS4sd9Z
iws18khgWnWt1i5dbRtwdKuj8TdLUCQf77rqT5Six5nZPGjyQ20kVseX9jUT5gO5
8/qualcJ
=BIqx
-----END PGP SIGNATURE-----

--aLwQ9E+QfQQN1nob--
