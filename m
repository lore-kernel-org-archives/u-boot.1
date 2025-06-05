Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA8AC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 17:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49B968091A;
	Thu,  5 Jun 2025 19:12:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fv7g3tmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB2E881E25; Thu,  5 Jun 2025 19:12:55 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E90DB803DF
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 19:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-60f24b478e3so602148eaf.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749143571; x=1749748371; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VdJoBAMhJykv955evgKYCL4jBBxTi7fHf4LSKNFJJXY=;
 b=fv7g3tmcFeuzhCSIS2z1VBjt9dIr7t/MBPdBrc6snJ59LY9n/uPyjmXxLw/bQcXxBd
 gj+eoSyy0u8nMS6jqQ57ne+wHRRAMZrH5uJHjjvTbTYwLg2Xv6AD2oxZ8ZUnJDgaNJhC
 JjQ496kp8oIB19582E1udUL85LKidbtcjPDBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749143571; x=1749748371;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VdJoBAMhJykv955evgKYCL4jBBxTi7fHf4LSKNFJJXY=;
 b=LH2gKJrKm/MyXLevXQOYBHqQhbl1lQckbPo1KanuhqHnYCzwWPersz8o4B8Dfm19b6
 1CLjCKaPCYzlI01KETrN7zM6DtmuLFBo6s2fNuRTAJUOM6ioA5VcwJTJhf/MYLetQSnW
 evgp+5it9IpchyBaSE3bPHAUUYTVO2DAWP3rHNaPzUgWdebvZX0BSdGHk3dqSWd2ywA3
 FnFacPd1DR4WlH+q41AWNk/pxaOvZwHm1zTmZ07nacPxdx90z/R7U1bDMAj6rGpZjJxH
 VuoEMRfkuUg/STqP5icXUuMqBZiD/VOZdInTX6vFA79f2Ol5uZkQ6alZPmm2/ybx4zwQ
 JBxQ==
X-Gm-Message-State: AOJu0YyGerWsBUL9yLLy2T24hDotKnYgQl/gKEmapFY1ItyFIawVyEMh
 LGnNCQxkv3LeC1FQ39AKLqEsmcV9q5nz0dwrx1YI879vQvVhc5FPgtl2gMr7Lz3+lxY=
X-Gm-Gg: ASbGncugSQpm9lzlAHEtqND+8s+IE7gO+9AtJQsY4TmDKtylTuVd+satibxcat97aIs
 +4PYwtz/PSNJKcEJAzjhq//8z3Cjz4L7ea26Hg5fBkSi8Z58f7iRwDkxOKauTiJaAr6o9IeYpb7
 Jv2XGy6jOejXh+Qq/Iysf8S8F5PRk/DIcHKDTelzF7bdwNl855Cxln3vVCPqXt0Am9rzCB8Jfmy
 4k1RhOlGZXUi6aAVHUmOtGkt+5VnhutjAC7s8M3OObTqIRmlqQnNX5wW0ipcaaYN5JR8rfrPmfP
 PEF7q+DlQoCqrkY4m7iLaJSo4qMdl70KUqE9147VAWMWKEuilyYzNqJ/jAXc/fJjk31KQWS8iUv
 qA+UVD8dLiHRYQuyQOPs+fqo=
X-Google-Smtp-Source: AGHT+IF3RqU2jQv9Ab2XJ4GVB3jyS61csZi1SfnMs/VG0pH7xoLaPHfXFq7X/Q8t9Z+0mtnQ4zaoDQ==
X-Received: by 2002:a05:6820:986:b0:606:293f:f37e with SMTP id
 006d021491bc7-60f3cf6407cmr182941eaf.6.1749143571696; 
 Thu, 05 Jun 2025 10:12:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c1eb9c036sm2708422eaf.34.2025.06.05.10.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 10:12:50 -0700 (PDT)
Date: Thu, 5 Jun 2025 11:12:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <malysagreg@gmail.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>
Subject: Re: [PATCH 10/10] MAINTAINERS: Update ADI entries for new boards
Message-ID: <20250605171248.GB1382132@bill-the-cat>
References: <20250602194507.15159-1-malysagreg@gmail.com>
 <20250602194507.15159-11-malysagreg@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ABULH/xHNsYoEDbS"
Content-Disposition: inline
In-Reply-To: <20250602194507.15159-11-malysagreg@gmail.com>
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


--ABULH/xHNsYoEDbS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2025 at 03:44:48PM -0400, Greg Malysa wrote:

> This adds missing maintainers entries for the ADI SC5xx defconfigs.
>=20
> Signed-off-by: Vasileios Bimpikas <vasileios.bimpikas@analog.com>
> Signed-off-by: Utsav Agarwal <utsav.agarwal@analog.com>
> Signed-off-by: Arturs Artamonovs <arturs.artamonovs@analog.com>
> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> Signed-off-by: Greg Malysa <malysagreg@gmail.com>
> ---
>=20
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d62dd35a385..cee5f1a9271 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -631,6 +631,7 @@ F:	arch/arm/dts/sc5*
>  F:	arch/arm/include/asm/arch-adi/
>  F:	arch/arm/mach-sc5xx/
>  F:	board/adi/
> +F:	configs/sc5*
>  F:	doc/device-tree-bindings/arm/adi/adi,sc5xx.yaml
>  F:	doc/device-tree-bindings/clock/adi,sc5xx-clocks.yaml
>  F:	doc/device-tree-bindings/pinctrl/adi,adsp-pinctrl.yaml

This doesn't also catch the other drivers and so forth added. Perhaps
the "N: " regex syntax would be helpful here, to make adding all of
those as well easier? Thanks.

--=20
Tom

--ABULH/xHNsYoEDbS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhB0AwACgkQFHw5/5Y0
tyxnoQv+IWj1JchgNM9BtIntNn56m0ZxpM2qREVEw1lWkAuv1C0Y8W8hyoraxVJe
T/iex9koXn7xq5Oih0/+15Dlhx8icK/qkGHoXmg2A8lo6B8DVkPxuNTlynWC7Tks
2eIrxiTVOi3UkZSw88KbR8pVLB1bdHIzytcxaEgMlSmVPKs+/x2Ty0SiPNauP5UB
GAsu2iQZ9gA1ZTIYF5B7zv6j59U3TOkM2AtKBFKr1EQhUH8nc+ST44Oxp19bTxl6
E8RaCuvnF+2/+ZZtijjsRFREThMdzL4fvm5VrsJaL4i3fb19BB8solhJfdFlgVUA
xHlyLHhmPD5BlBTL+wdUFPAfhWO+LYwTKbkxH9UrXwpDKyXFY7dwti/2Yk8hhKE8
DfH3tQBrErfQFzDjLu3u5m7v1r3UHDjpxP/QZDtaincV+bQIXys9zbKad0tH5rqW
XPhJoUz23lnf/jWJy1qdNZkF+nyDa5blDBFOfscLRGmf4Gw0uogbgNSZIW0oENZj
26AQcZzR
=70kR
-----END PGP SIGNATURE-----

--ABULH/xHNsYoEDbS--
