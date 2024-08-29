Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A11C87FCD
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 17:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB58088C1B;
	Thu, 29 Aug 2024 19:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R9n8JVoC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D61988CA1; Thu, 29 Aug 2024 19:31:23 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06DB087BF4
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-270596dbf59so633229fac.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724952680; x=1725557480; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Wg4ZJlI0gu98JoOS2QXeUOMcuLdDOG/lR0vukwGCPUo=;
 b=R9n8JVoC/nvhnAbflNyKI+8z0P2FuaxK/ydZtexkKo+ZdmmxhUcrcOu9CuH1ZcJ3Ft
 v2/ZqcRIqIJzkMFF4aFeUgJcsNRqBTQr5lUjgOm16pg6yvjTxb1RD0QRvZZ1sDzAUGr0
 On0EzeQRZz72uEuKCSdIQiK6ZMBYfFGrDlzVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724952680; x=1725557480;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wg4ZJlI0gu98JoOS2QXeUOMcuLdDOG/lR0vukwGCPUo=;
 b=rQsItCUGBPomgeZQ3p98pXiLupgSjyADVlva13O+IhtXEYvR8h29qwmE7IaMHcq8e8
 /1Z3NZXXCTRBNJdCX4ve/2VomuJOGDMz3gZ7a+1SEn57WNxTln0W++h6p+PyRWvFviYb
 bOmeHyyxxd3CxE5aBFAF/cL0z/g5GpmqBN2PNP7Tl1XxusdheDCHGVUIKxYqxAkMO+Lz
 blYkWS9DBG9eJi2VuRpOucATzapErOzmifat5HQF6zIz5oBDsb+2KHhkH1s/UkUivOa3
 BdcqvTfjq2SmuPyMA2bHcqd8GoGCeUVXvwHk1c3kv4AZRpEl+XonbAfGZ6e2aQQvCr3V
 kT+A==
X-Gm-Message-State: AOJu0Yz/MhFuRWXS/Cf3uOUEDCHLfS7Bb2h9XcSslKEhsLXIbF+e8Zav
 jHb2O1MGm3ZUOKMTEamahMOlmHu3GzvKKylvQNnihumnmTldVnuXXxM/FoIaBkY=
X-Google-Smtp-Source: AGHT+IFzfIMqgmHw3JS2CtfB7zbo5vPLaIYxy+Slw134ncKWZQxjHYKd0mXIOl1Km500tcefwvpR8g==
X-Received: by 2002:a05:6870:9110:b0:25d:fab0:b6f4 with SMTP id
 586e51a60fabf-2779008e683mr3886447fac.1.1724952679633; 
 Thu, 29 Aug 2024 10:31:19 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806d5dda7sm69049985a.106.2024.08.29.10.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 10:31:18 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:31:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH 18/19] boot: Imply CRC8 with VBE
Message-ID: <20240829173115.GM2479150@bill-the-cat>
References: <20240829145802.1827952-1-sjg@chromium.org>
 <20240829145802.1827952-19-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wII9/Byf9IGA14Bh"
Content-Disposition: inline
In-Reply-To: <20240829145802.1827952-19-sjg@chromium.org>
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


--wII9/Byf9IGA14Bh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 08:58:01AM -0600, Simon Glass wrote:
> VBE uses a crc8 checksum to verify that the nvdata is valid, so make
> sure it is available if VBE is enabled.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  boot/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index afe04c7327a..49e99e5e155 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -716,6 +716,8 @@ config SPL_BOOTMETH_VBE_REQUEST
>  config BOOTMETH_VBE_SIMPLE
>  	bool "Bootdev support for VBE 'simple' method"
>  	default y
> +	imply SPL_CRC8
> +	imply VPL_CRC8
>  	help
>  	  Enables support for VBE 'simple' boot. This allows updating a single
>  	  firmware image in boot media such as MMC. It does not support any sort

I really worry the lack of "if SPL" / "if VPL" here leads to Kconfig
warnings that CI doesn't pick up.

--=20
Tom

--wII9/Byf9IGA14Bh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQsGMACgkQFHw5/5Y0
tyyHqQv8C+9WgsW30otd1kjEcJwQCiCFihbEAi93t0yccQ9sWmI6puDsw5UlICQz
8TmU73Y5+Z/9Bfra0/5V636BB4p+UXozMu18DGgdJFqeqosBR68vTJJ/BmEjBDiG
CdnPQFD/1BepUuvqy3a6G2g04Xrw6pxsZoV0aztTgubpOeegpQHeeNQwnTCxLDXo
LNm6uqRYOpbvIZMAzzc/EuvvaEwd9vqDTnQd4uv0MGaqJw+kNoTjYpGCKQHsulth
Xv6d0FGINW0jluWibSaDnuuQpQKB0b6bfWIRqni0wi+zMSZgoseHbA6o6TWRPBEF
xfqomXOR0+ofO1MYtJiSdChGZFAXu811qac9twzTMxYOByvwvM58QqUx8Ahr6rZT
Dn0tYzD6tqXKzyCPpuraYo9BVvo/aXVaVqsKevNg5GSERj8QKfUL9/GZAZ5I8DvB
8yu9PjdGHz6TldGAcn5hKaj/ZTMxfd7GW5icCxH/gMRwV8sXRmXytVxUzNEy+jdn
iiADTQ34
=oJJ3
-----END PGP SIGNATURE-----

--wII9/Byf9IGA14Bh--
