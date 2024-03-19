Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECF0C54E71
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 22:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DAFA87E6D;
	Tue, 19 Mar 2024 23:40:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AFAXlcuo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD23287E6D; Tue, 19 Mar 2024 23:40:41 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33E3587CFF
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 23:40:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dbed179f0faso261846276.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1710888038; x=1711492838; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GXuPkBEKVgKpwrckzE7av0hqcZQqzmBbbDbG5FXtRYg=;
 b=AFAXlcuo3SPquioClLGOBeU9LzEyEoar/LXev2gG46thB64iHgF2SE6+1h5GRyQUPC
 wLErv5i9qhYYydj7a7F4arip/VkaTG4dYeINKbGPiFrxoFBhxHkAFr83ztUmI8xVDeSF
 7hlI8kuvdQgj60LVCWTT5KysA0jhM+l/9zpuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710888038; x=1711492838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GXuPkBEKVgKpwrckzE7av0hqcZQqzmBbbDbG5FXtRYg=;
 b=YEhmx37ushyUFAabXSw746kYfWBOzFvii5oq5W616nuTHHtid371WCKFrlNxwFxJew
 3Tgtd8L5/TTYsWOzMjcd6QE7k+HAfl/yRf7+zgUPb+BHXb7GUMOXONofhrzxl4o71Sko
 LpkikSmhv060G9uP0EGkgUl3tunoCneG6i3Ro9L0Ix0E9oKgo6agrjR9SBk2CCKoZc6h
 aBhBOVJ9cilb1BFzILu3H7zQQtuqCoU1t5T+8XD30HkHOX2q+Wgi0WdMyKtnmU+rdAA8
 GlU9uQCj3AkS1lVd52eYn3T0JLt6WHC/0VYtQpGpp8m2h5Gmtkpim9aIoD8YNty3EcCx
 gzMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv2M7fCXXFAEPrbYwOreE0v66m31DmLy1Adjo4zQ4NMQOJM9adkSWRuRY8/p4TvhGjdZ0b/kWL2kaeOqTIm8EkEPSknQ==
X-Gm-Message-State: AOJu0YyDYEvQxNq5VYwG1Zi7zGLNzEvDSpLseCdE0V6UvqTS9PnEzstR
 jnSEeXImPd8k3DffZbyapbM9I7Umet/o850BO/lViToPDCETaFC0DFn4Jpuv5nY=
X-Google-Smtp-Source: AGHT+IG8cScAFQEPebXTn6l6XHZ91i0APbjdH1BUw4QISN7QoDH3Q0m+bIyCE80IEhg7AfY8fHmCvQ==
X-Received: by 2002:a5b:c06:0:b0:dc6:f0ac:6b53 with SMTP id
 f6-20020a5b0c06000000b00dc6f0ac6b53mr548696ybq.15.1710888037955; 
 Tue, 19 Mar 2024 15:40:37 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 w131-20020a25df89000000b00dcbb7dd8b86sm856504ybg.52.2024.03.19.15.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 15:40:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 18:40:32 -0400
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
Message-ID: <20240319224032.GA1686480@bill-the-cat>
References: <20240228120645.958316-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fu63nSbmOTYbOSyi"
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


--Fu63nSbmOTYbOSyi
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
> ---
> Changes from v5 to v6:
> *) Collected Acked-by tag from Ravi Gunasekaran <r-gunasekaran@ti.com>
> *) Fixed few typos as pointed out by Roger Quadros <rogerq@kernel.org>
> *) Added if condition to check if uc_pdata->fw_name exists and free it
>    before the strndup as suggested by Roger Quadros <rogerq@kernel.org>
>=20
> Changes from v4 to v5:
> *) Added Kconfig option REMOTEPROC_MAX_FW_SIZE to set max firmware size
>    that can be loaded to a rproc.
> *) Added freeing of address in rproc_boot() as pointed out by Ravi.
> *) Allocating the address at a later point in rproc_boot()
> *) Rebased on latest u-boot/master [commit=20
>    9e00b6993f724da9699ef12573307afea8c19284]
>=20
> Changes from v3 to v4:
> *) No functional change. Splitted the patch out of the series as suggested
>    by Nishant.
> *) Droppped the RFC tag.
>=20
> v5: https://lore.kernel.org/all/20240217122602.3402774-1-danishanwar@ti.c=
om/
> v4: https://lore.kernel.org/all/20240130063322.2345057-1-danishanwar@ti.c=
om/
> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.c=
om/
>=20
>  drivers/remoteproc/Kconfig        |   8 +++
>  drivers/remoteproc/rproc-uclass.c | 102 ++++++++++++++++++++++++++++++
>  include/remoteproc.h              |  34 ++++++++++
>  3 files changed, 144 insertions(+)
>=20
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 781de530af..9f9877931c 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -10,6 +10,7 @@ menu "Remote Processor drivers"
>  # All users should depend on DM
>  config REMOTEPROC
>  	bool
> +	select FS_LOADER
>  	depends on DM
> =20
>  # Please keep the configuration alphabetically sorted.

Can we not make the FS_LOADER portion optional? I didn't realize how
many non-TI platforms this impacted. And even then it's possible I
assume that custom designs will load the firmwares in other manners.

--=20
Tom

--Fu63nSbmOTYbOSyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmX6FFgACgkQFHw5/5Y0
tyyZ2AwAoPSW97P4JkaUv9FOdZIf7fXu+TlqdcH4zRaAsbUfswi68Kk0PBcmH/Ii
x+5mRD62gi6AfuW9V6JnRN3rIl32Bfw6bfsEZqN7fuzQiCo+x5mOSlVliABtBwfY
qouBeHvSlKgM8Tn13ADJIlM2FA4Fu/erixo/fqpPP2KyjjeU4PJdbSmZbOGOS/Ot
BQA7AqbC47a0WB673iodgtItnVdhLPnzLpfNEbWNJ+9QxsFOk7cjdqFjH9ujtr8m
XwaoUB3JZXIFHJuJM3nanrZVxmq4CguGx0hDIjbAT03Tp/AB5ufBCXA/SsdVKWBc
iUnVLvYQWYz2Qykp6dZo9Ml3JLVanZlDMYayd2Gx8rOUexgcmqSaDyFXoQG3Z0Y4
+zAb113Qd1o5YtWf7zaENECdsInGXiSkz6huL9uieF+CZxy2hMLWuJdyJjRJu4ew
Q8vdSrDUTDVnTMfiNv95O3Ra/Z5MJRUG+xKNzsUNXXRRDqrsjkIIKsnHpE6pKdmr
DOzkTnOS
=PHAc
-----END PGP SIGNATURE-----

--Fu63nSbmOTYbOSyi--
