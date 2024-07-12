Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB2EC3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 16:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A72F887E4;
	Fri, 12 Jul 2024 18:48:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A8ESk4QG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BA50887CF; Fri, 12 Jul 2024 18:48:06 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6BBA887C7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 18:48:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3d91e390601so1266912b6e.1
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 09:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720802883; x=1721407683; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NCoXzICXHpeGI9ufRfHke35XbnVEI8OKLEPbZWHr9Ts=;
 b=A8ESk4QGK09HwhHxiymnP2+zJ5CrUjr9I5pAzSCJfB5VwsEKqR1itJorvVtET9yoGB
 5QVWT6u4DwOf0vAEl6GA3kfL4hRGaMHyh8RluH2vp/3ewPvEYY1W+GPnHygor/CJddgw
 MraLKB29V5m+Q/L/fwbs3C3KXnu6/rmD7SeTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720802883; x=1721407683;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCoXzICXHpeGI9ufRfHke35XbnVEI8OKLEPbZWHr9Ts=;
 b=aCER693pvssoizXIpgGFoG7m3x6PMsKtBYm1yI9lQCopXpO6aHB3GlsGLPZWg4Wjdm
 c5kK15l3M8DXbu5ImCPGA31a1cG17vLDKQTRQYfkHymrz8YVDvBKhchbJZsX0ImKJsdW
 /xD9+4M0vQrsuwJx1tsxzj+KDI+Hx2Q4MbzMSzPkung9P+lEptj+P2vGFuBDg5clSxbl
 RF+0Rra42RZcuFAIOUJlkqtnrxBpLN5d4hUuukj1NAYGxHurGG6AuH6YTA0wXxuvf14c
 00Bi/4yxcQbmvItcAozCKZxXZFf5p9MzUkP1AQTrOv07jc7WMktLT+bTNL+z2Qw4VqqY
 1U+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdftfGYzTd2cSo+n/V1balRUbsf8xbt2aCfUnsaJLWtpbGfgYbFciDb/subRURf8/D65gpIVFzEHRXFhOfbOQ52qgLkw==
X-Gm-Message-State: AOJu0YzYS24RCs77LAdSb88X9gwYXipt6qeGMbvoki32wWVaBiHii97C
 0FHON4clzmpBqD02uuHEd06goFoFDRXS7/C+xLqe1Bn4NxWMEnWfdNifPUqhSqg=
X-Google-Smtp-Source: AGHT+IHe1K3D7gN7LRDjti/VbiW/5riNMTUms5zsXo2nnA60iqos4Q3bIzT9pQYrTfcPWspaex/gYA==
X-Received: by 2002:a05:6808:1718:b0:3d2:1a92:8f4a with SMTP id
 5614622812f47-3d93c070425mr13403600b6e.23.1720802882649; 
 Fri, 12 Jul 2024 09:48:02 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70374f88de5sm1680196a34.47.2024.07.12.09.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 09:48:02 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:48:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 2/3] add support for symbol lookups
Message-ID: <20240712164800.GT38804@bill-the-cat>
References: <20240710-arm64-backtrace-v1-0-5a2ba50485dd@linaro.org>
 <20240710-arm64-backtrace-v1-2-5a2ba50485dd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QtoHfN02ZKmbAVbu"
Content-Disposition: inline
In-Reply-To: <20240710-arm64-backtrace-v1-2-5a2ba50485dd@linaro.org>
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


--QtoHfN02ZKmbAVbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 06:26:19PM +0200, Caleb Connolly wrote:

> This is mostly a port of the Xen hypervisor implementation. The U-Boot
> binary is built as normal, then its symbol table is fed into
> tools/symbols to generate an optimised lookup table. U-Boot is rebuilt
> with the symbol table and handling code in lib/symbols.c.
>=20
> Based on code from Xen at
>   c20850540ad6("x86/altcall: always use a temporary parameter stashing va=
riable")
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
[snip]
> diff --git a/lib/Kconfig b/lib/Kconfig
> index b3baa4b85b07..06a78f83b7d6 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -977,8 +977,14 @@ config VPL_OF_LIBFDT_ASSUME_MASK
>  	  are made, and libfdt is able to deal with malicious data. A value of
>  	  0xff means all assumptions are made and any invalid data may cause
>  	  unsafe execution. See FDT_ASSUME_PERFECT, etc. in libfdt_internal.h
> =20
> +config SYMBOL_LOOKUP
> +	bool "Enable symbol lookup"
> +	help
> +	  This enables support for looking up symbol names from addresses. The
> +	  primary usecase for this is improved debugging support.

This only works on aarch64 for now so please add a depends on.

> diff --git a/lib/Makefile b/lib/Makefile
> index e389ad014f89..a4ccda76f438 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -121,8 +121,9 @@ obj-y +=3D linux_string.o
>  obj-$(CONFIG_LMB) +=3D lmb.o
>  obj-y +=3D membuff.o
>  obj-$(CONFIG_REGEX) +=3D slre.o
>  obj-y +=3D string.o
> +#obj-y +=3D symbols.o
>  obj-y +=3D tables_csum.o
>  obj-y +=3D time.o
>  obj-y +=3D hexdump.o
>  obj-$(CONFIG_GETOPT) +=3D getopt.o

Drop this hunk.

> diff --git a/lib/symbols.c b/lib/symbols.c
> new file mode 100644
> index 000000000000..e881d5603425
> --- /dev/null
> +++ b/lib/symbols.c
> @@ -0,0 +1,126 @@
[snip]
> +DECLARE_GLOBAL_DATA_PTR;

You can drop this since there's no references to 'gd'.

--=20
Tom

--QtoHfN02ZKmbAVbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaRXkAACgkQFHw5/5Y0
tyymAQv+N4HVN5IAE4L7BtJPBkR5BJowafqeZwXgdd0JgqAV5yQYWualotoyUXEA
ugn474kAJwykpiaHu1HhGR+T/Xb6u+n+xqdU307L+wlYneWNNVNT1ksBAtOu+PkQ
Q07b0msRDXUr9SifRR/JXrBHHFIbc5HSZBp1eWYTRMGqtESVt3vSsKtj90q+M/Gz
cSaHMuI1UP/iN96RS6A9shRCbh0HrCER/oAmPfziVYDZ4whpw8C0Drvry+34EnuQ
kFMrf/yl7QLDAzip/VOTvGpu1ova1lULNjHqSR8RDIoOi943QdWGL3DyKkbEcm5V
iIV++j/eEa9Mn7eeuNzKBdlDSGmlI7+DGIkAF1uXiCsMz+I/5QO4XwYX07l+dt/u
Lr78hHCPoQV+JKJupcP2QU7CVs8CVbsENuIXCT8/8Xsspx3j7xi+fWIYB977FLjt
XVuq8EpggMjfWQCXU7ZOzsXScDNs7/+2Slgx3cc+Qk9hLZ/gCoJbM3M2Knjbvn+B
y1WLzolA
=404i
-----END PGP SIGNATURE-----

--QtoHfN02ZKmbAVbu--
