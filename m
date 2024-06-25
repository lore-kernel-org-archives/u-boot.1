Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F68C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 14:34:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0E9F88452;
	Tue, 25 Jun 2024 16:34:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qcbRaUgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FC6688464; Tue, 25 Jun 2024 16:34:28 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 771CA8844F
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 16:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-25caf76158cso2985472fac.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 07:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719326064; x=1719930864; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KfN0njXFflXaHXT8UB/njLjvXZDUx+HVhqJWgE54IYA=;
 b=qcbRaUgP8aH4XEgbD58/Q4cIlpslvh6+qlklbQ3FDXluHpC1rJYXelzfBi679+gu18
 qGgk2o1Z4xFrGIn/5HnDxpT3zYr+KdTtQkmAj2LwnqI5iMMVjMzJdP12AGEqDDrmWZ57
 kvLRn9B/2Q671qZipsgjH09q5Ja2hoj1AWrmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719326064; x=1719930864;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfN0njXFflXaHXT8UB/njLjvXZDUx+HVhqJWgE54IYA=;
 b=KItSsKJ/UXjE1Gnu3JfRNCC9zUA/wrZyQdnFOBjBGtIy0hjwLIdkWT76eeMz5vJDmE
 UJydmAMqpetMO9eDekGnimq1B7YkYjfMA7eMoYFmkwUMVA+5jL6Y4wLEcW9m1pEdy2mj
 nH8mZ0GLjp/mSpk/Zcqix0HsQkSzQBBUIw38KL7kksqSR/b40Hp90rVsnh1ssTxGylM3
 1MgrOhvknMHX5xwZlAZTJg1vVmymoqU2TG2/6kDn/RhuktvRTbfVHdjDcf8ftiR3PJwQ
 1TbcMA38hkAfd9XvUOJACa1soJAJIWS2ddRKENYohcIxR7ZpDoxJcD83sAGdfKzcNfAB
 Y0zQ==
X-Gm-Message-State: AOJu0YzlFr7eBbfd60BlJyYiPg/OkAMVdy1nQNE/l2hxnBw/HfvI/5p3
 fydOZe8OjsdvExU4jvcIZIwJrrCgbP0LODdNFuaF+CyWARBnfZL5fn8Sq0zac90=
X-Google-Smtp-Source: AGHT+IFEztEd5X80aKVwcf3WQjrAs5xhwoF2MRdmRhYCzty1hpAKasOsr6uC6WZTtn2Y0kE/Ni14og==
X-Received: by 2002:a05:6870:7184:b0:250:6f17:fbea with SMTP id
 586e51a60fabf-25d06edd79bmr8102190fac.57.1719326064042; 
 Tue, 25 Jun 2024 07:34:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd4941a1esm2473440fac.8.2024.06.25.07.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:34:23 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:34:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor.dooley@microchip.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, conor@kernel.org,
 Ivan Griffin <ivan.griffin@microchip.com>,
 Padmarao Begari <padmarao.begari@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>
Subject: Re: [PATCH v1] board: mpfs_icicle: implement board_fdt_blob_setup()
Message-ID: <20240625143421.GR38804@bill-the-cat>
References: <20240625090806.1787287-2-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k91o8aXoDXCHIuqr"
Content-Disposition: inline
In-Reply-To: <20240625090806.1787287-2-conor.dooley@microchip.com>
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


--k91o8aXoDXCHIuqr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:08:06AM +0100, Conor Dooley wrote:

> The firmware on the Icicle is capable of providing a devicetree in a1 to
> U-Boot, but until now the devicetree has been packaged in a "payload" [1]
> alongside U-Boot (or other bootloaders/RTOSes) and appended to the image.
> The address of this appended devicetree is placed in a1 by the firmware.
> This meant that the mechanism used by OF_SEPARATE to locate the
> devicetree at the end of the image would pick up the one provided by the
> firmware when u-boot-nodtb.bin was in the payload and U-Boot's devicetree
> when u-boot.bin was.
>=20
> The firmware is now going to be capable of providing a minimal devicetree
> (quite cut down due to severe space constraints), but this devicetree is
> linked into the firmware that runs out of the L2 rather than at the end
> of the U-Boot image. Implement board_fdt_blob_setup() so that this
> devicetree can be optionally used, and the devicetree provided in the
> "payload" can be used without relying on "happening" to implement the
> same strategy as OF_SEPARATE expects in combination with
> u-boot-nodtb.bin. Unlike other RISC-V boards, the firmware provided
> devicetree is only used when OF_BOARD is set, so that the almost
> certainly more complete devicetree in U-Boot will be used unless
> explicitly requested otherwise.
>=20
> Link: https://github.com/polarfire-soc/hart-software-services/blob/master=
/tools/hss-payload-generator/README.md [1]
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Ivan Griffin <ivan.griffin@microchip.com>
> CC: Padmarao Begari <padmarao.begari@microchip.com>
> CC: Cyril Jean <cyril.jean@microchip.com>
> CC: Tom Rini <trini@konsulko.com>
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: u-boot@lists.denx.de
> ---
>  board/microchip/mpfs_icicle/mpfs_icicle.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/board/microchip/mpfs_icicle/mpfs_icicle.c b/board/microchip/=
mpfs_icicle/mpfs_icicle.c
> index 4d7d843dfa3..2c1f7175f0e 100644
> --- a/board/microchip/mpfs_icicle/mpfs_icicle.c
> +++ b/board/microchip/mpfs_icicle/mpfs_icicle.c
> @@ -9,6 +9,7 @@
>  #include <init.h>
>  #include <asm/global_data.h>
>  #include <asm/io.h>
> +#include <asm/sections.h>
> =20
>  DECLARE_GLOBAL_DATA_PTR;
> =20
> @@ -50,6 +51,24 @@ static void read_device_serial_number(u8 *response, u8=
 response_size)
>  		response_buf[idx] =3D readb(MPFS_SYS_SERVICE_MAILBOX + idx);
>  }
> =20
> +void *board_fdt_blob_setup(int *err)
> +{
> +	*err =3D 0;
> +	/*
> +	 * The devicetree provided by the previous stage is very minimal due to
> +	 * severe space constraints. The firmware performs no fixups etc.
> +	 * U-Boot, if providing a devicetree, almost certainly has a better
> +	 * more complete one than the firmware so that provided by the firmware
> +	 * is ignored for OF_SEPARATE.
> +	 */
> +	if (IS_ENABLED(CONFIG_OF_BOARD)) {
> +		if (gd->arch.firmware_fdt_addr)
> +			return (ulong *)(uintptr_t)gd->arch.firmware_fdt_addr;
> +	}
> +
> +	return (ulong *)_end;
> +}
> +
>  int board_init(void)
>  {
>  	/* For now nothing to do here. */

I'm adding in Simon and Ilias as this touches on one of those frequent
topics about how device trees can/should be passed along to us.

--=20
Tom

--k91o8aXoDXCHIuqr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ61W0ACgkQFHw5/5Y0
tyzVIAv/QQfDBgJQYDCDC8hUEJQfMSIPfhJF6swjCwxL0qC1lmhumfAnuNFLDsbh
Kgs6fmdoEA8JmHxdIFzu2Qj/Rp5GfEuVJIwq8li3mszkM+jEXE/5QckYotThCuaa
u+fM+sNdn2kCNUZgnzfwHkWMhIggCeIvVxeVh/iglqCdeEQTdM/a2QTc7sd8zh92
uprbaOa3mL2ytKBCZYXRhNw9M8y5AEDDZPoSO8qHtXU5M+vWMzLyFDwKnbIKE3Nj
hpEH69rWJzBSXlsZEFNLa8HOAnNF2p7mP3mvGsrR3ci3mRx0IuXCxFH6oS7F1N/O
iCFAQ9Rp/wUJ47KxVrfShqyzxbkkaYc/s4/hgtM6XGA/ytXt9DCWy7/WudANibXe
H02cr9VKhjB3UckmTN/5MLIcPUAeuXmcYG6+8dmwmCfA/pb7ry+RDfdtUt/A37SN
8zr5UijH9ktpOb/eWTFgqfql5zjUbxZOKua7PYehEfwU7EOWbZJQugqFwaW8quyn
KQUbA30G
=NNMo
-----END PGP SIGNATURE-----

--k91o8aXoDXCHIuqr--
