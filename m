Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05BACC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B68A86583;
	Thu, 31 Aug 2023 16:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TpsrnwdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E13908659D; Thu, 31 Aug 2023 16:01:55 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4BDD8657F
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 16:01:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58cd9d9dbf5so11022937b3.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693490511; x=1694095311; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ahugI8H95IShE9yqqyFZcMa3XuhqNcl0epvyEPW9zo8=;
 b=TpsrnwdJXChOJpXOLUddxy3spr2Bz4uodqky4IOKVxWuQbCb3KrLEToyVN5RdSQRgr
 Xu1G4hswj63ScOBXhBCIFJbcG2u8FYmz1owgIyTcWb7xoqxvrxXfDcNTZAYYKkXJbLLZ
 MiSRpc3+I2rbdel93D0DWS7kodojreTcgiUPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693490511; x=1694095311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahugI8H95IShE9yqqyFZcMa3XuhqNcl0epvyEPW9zo8=;
 b=apnuOWxwt1TQ4tDrOcJdWFnh9NWM3mi+oJaYBX1BPkt2Zr5zSh72Z26Yztv3+0wGWz
 t2l4JvtqnDhBaDWJL95SxSFGinLxtr68XbgpbGCEu9VSjZricR5YEBQgF/c/CTzq8L/T
 H4CGJnnw8nTAE6hMK8NM4nOoHaOsctiIVBpM2mfEFi5nH626bWTm74KICgsGq6/41eEq
 MLpKDjnhRWIDnfJyWwkWMDDoU2NrgKFQIHreDcl2M2BaYcFhIKX87kRMbUNLfea7Urfm
 cyBaEs+/e59AfqxVhzkGyK1qG6YrptBBvlLjbZv+TKG7M3mP1o53RSJWVECW3LpOitRs
 SrYw==
X-Gm-Message-State: AOJu0YzxogS+HA34+SPnXhD1I1uCQNdFGvTSAy7aqdpVViSywUgTmZ9Q
 VZWyLYFR2xWipOQtVQ4M9zNRAA==
X-Google-Smtp-Source: AGHT+IFPzJfXwGlC520c4JUfbTyWqD8jA4ynuyojspE9mGWN3ocxZBOD7JFoWQpWqDFioeUn6Q2EoA==
X-Received: by 2002:a0d:cc45:0:b0:581:7958:5bda with SMTP id
 o66-20020a0dcc45000000b0058179585bdamr2592163ywd.1.1693490511633; 
 Thu, 31 Aug 2023 07:01:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a0df104000000b00583d67839fasm424851ywf.121.2023.08.31.07.01.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 07:01:51 -0700 (PDT)
Date: Thu, 31 Aug 2023 10:01:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 19/19] boot: Join ARCH_FIXUP_FDT_MEMORY with related
 options
Message-ID: <20230831140149.GR3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-20-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CTyttYQalUAxfGOZ"
Content-Disposition: inline
In-Reply-To: <20230831035319.2316665-20-sjg@chromium.org>
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


--CTyttYQalUAxfGOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 09:53:13PM -0600, Simon Glass wrote:
> Move this to be with the other devicetree-fixup options.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  boot/Kconfig | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 023446130282..257f4cc085e1 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
>  	  address of the initrd must be augmented by it's size, in the following
>  	  format: "<initrd address>:<initrd size>".
> =20
> -config ARCH_FIXUP_FDT_MEMORY
> -	bool "Enable arch_fixup_memory_banks() call"
> -	default y
> -	help
> -	  Enable FDT memory map syncup before OS boot. This feature can be
> -	  used for booting OS with different memory setup where the part of
> -	  the memory location should be used for different purpose.
> -
>  config CHROMEOS
>  	bool "Support booting Chrome OS"
>  	help
> @@ -1492,6 +1484,14 @@ config FDT_SIMPLEFB
>  	  the presence of the simple frame buffer with associated reserved
>  	  memory
> =20
> +config ARCH_FIXUP_FDT_MEMORY
> +	bool "Enable arch_fixup_memory_banks() call"
> +	default y
> +	help
> +	  Enable FDT memory map syncup before OS boot. This feature can be
> +	  used for booting OS with different memory setup where the part of
> +	  the memory location should be used for different purpose.
> +
>  endmenu
> =20
>  endif # OF_LIBFDT

It seems like fixups are mixed in with other changes in this menu when
we should probably keep the fixups lumped together at least.

--=20
Tom

--CTyttYQalUAxfGOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwnU0ACgkQFHw5/5Y0
tyyZ4Qv9GAr6gqDyuplmRyJ00jRNz8ttK3kUrMRjNnnnP6X2dl2mgEsxrxdT4526
YmVnwdMtdAS6D/kjaujUY3MzptoMwhjfkuSsWj+xWlLRSky3+lnOGmmTFMc6JXb/
kNZBYUjFLOr0anQzeRpxMcGQtxliNkJrFv/L92NY6pnBG3pTzTBaG3IIODOalkRn
oZJH2EEbjznOwQJGsy3oJL7V12WA++SaPLdNYf/xO1aNLZ6xjJe0iG8FqU/p1euZ
bWRNv/5JM677hwtaRTqUwqXrwM9brgQdAepnsZQUBvlDsxNdd4tNauJjG3l8xbdT
6q6fgFwTRPO/GRcpPSE4evYh1zdQHPYULXtgbgIH0xMBKji5jTMFldg3OX0ydUFZ
6W4ewlLXd4/a0fu+fLHIlcBqMMplI343bMAFgOpI+8XoEaxLymMGziPPPNmrzSxM
3N/bItFh1Nv5ppE8EOIAXvomoH/PXvSReRXA3OL/eGWsPP8nyRueDhXeoZn0HdqR
ULneJRsN
=ZMTY
-----END PGP SIGNATURE-----

--CTyttYQalUAxfGOZ--
