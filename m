Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE642C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 16:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94BD87653;
	Fri, 27 Oct 2023 18:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U5GvI8wb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F99D87532; Fri, 27 Oct 2023 18:43:18 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1521F86F6F
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 18:43:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cd444d9d0so16347211cf.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698424990; x=1699029790; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5O/dXedmhrMlCBNSfcYk6tZMni65WgP/3TglrRyJEB0=;
 b=U5GvI8wb2Y34TnzfOFiC3cKUC5OhKUfzr0vf6sUIoYzaFtnieikX6aQ2EiEQV3ecCV
 UWZIRhkFl+iKgIoy/oo+EI7IZSkwAtTGsCff7Lbb+U0QicLu4I1SpRhHYIsUsSw/5amk
 OFdBXt38a0GCMhlJZaHGvi6GxUdFoMdUn7Q5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698424990; x=1699029790;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5O/dXedmhrMlCBNSfcYk6tZMni65WgP/3TglrRyJEB0=;
 b=qZRO/sx67jQRuyfeMs01rdAt8I21BYLccHbef5EjeFsQGSGBs2mTMaVn/bpvOWEPjq
 Nlmz5Z33vQUiMmb1GjKsEOe7VvPpJBKtBQmAiUCBtNt42Zw8IRJ86ft0Dt6zRpN5AZ0l
 /QBRG/Wv5/ZvSVvOhdGzJFlxqqtbwphXp9pDmN9/siLipYv9Iu101LEaov/bcQ4/2kZV
 JaVF/lq1tRK8QIkRKQ37lCaAQX1+ie1qSX6hAdmxnD+2R0Ni+ftNrrB+E39h/zsz2nkA
 WW4htAHgbGSI/HRL+tAMRjHhDQxqK6iOOLpsloR9Atx/RWtqtb1fhW26kI+ycsa/bMdY
 jPHg==
X-Gm-Message-State: AOJu0YwcO5F5rfzk7FBfwQX/4OxtkJ0zrnSeKqqMuxrHmPSXI4Vwp5PE
 u0BP2+N7vcM+Dja9YmmWT+/71g==
X-Google-Smtp-Source: AGHT+IFMhfiUu5NziAEZ/ezXUby7fJZGLJkj8BgaIoMnBc7AaGrHliGu7KkvRy96ajJp6SqUndjnKQ==
X-Received: by 2002:a05:622a:1007:b0:40d:b839:b5ac with SMTP id
 d7-20020a05622a100700b0040db839b5acmr3009538qte.15.1698424989719; 
 Fri, 27 Oct 2023 09:43:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a05622a180800b0040331a24f16sm727938qtc.3.2023.10.27.09.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 09:43:09 -0700 (PDT)
Date: Fri, 27 Oct 2023 12:43:07 -0400
From: Tom Rini <trini@konsulko.com>
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: u-boot@lists.denx.de, greentime.hu@sifive.com, vincent.chen@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>, Green Wan <green.wan@sifive.com>
Subject: Re: [PATCH 1/1] board: sifive: unmatched: move kernel load address
 to 0x80200000
Message-ID: <20231027164307.GY496310@bill-the-cat>
References: <20231026032254.23043-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G+zlU6BxwjXp1y29"
Content-Disposition: inline
In-Reply-To: <20231026032254.23043-1-yongxuan.wang@sifive.com>
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


--G+zlU6BxwjXp1y29
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 03:22:52AM +0000, Yong-Xuan Wang wrote:

> U-boot initially loads the kernel image to the kernel_addr_r, and
> subsequently relocates it to memory address 0x80200000. Setting
> kernel_addr_r to 0x80200000 can eliminate one copy operation.
>=20
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> ---
>  include/configs/sifive-unmatched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/configs/sifive-unmatched.h b/include/configs/sifive-=
unmatched.h
> index 74150b7d4b..de8bfc1123 100644
> --- a/include/configs/sifive-unmatched.h
> +++ b/include/configs/sifive-unmatched.h
> @@ -36,7 +36,7 @@
>  	"name=3Dsystem,size=3D-,bootable,type=3D${type_guid_gpt_system};"
> =20
>  #define CFG_EXTRA_ENV_SETTINGS \
> -	"kernel_addr_r=3D0x84000000\0" \
> +	"kernel_addr_r=3D0x80200000\0" \
>  	"kernel_comp_addr_r=3D0x88000000\0" \
>  	"kernel_comp_size=3D0x4000000\0" \
>  	"fdt_addr_r=3D0x8c000000\0" \

This is I believe subtly wrong. If you want an execute in place kernel
image (and are using FIT images), this can be made to work. But if you
load your (Linux Kernel) Image to this address, the header will be at
0x80200000 and not the payload so you still end up moving it. Are you
sure this is (a) not still moving it and (b) it's OK to be executing the
header of the image like it's code (or is there some catch in the header
to lead to a jump over it, in that case) ?

--=20
Tom

--G+zlU6BxwjXp1y29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU76JQACgkQFHw5/5Y0
tyyBRwv/QDw5yjKt9sCbzQP43j46qAgWh45K+Zum82We7ZWvUVKNsm6q31YGxSz/
6nYNTCgABdwuh3aLLroKdBESQMvNONiV/MhAqgPCgdfzGl7yF3AAOGV7g/8S7JJw
ZB5GQ4vjLN48ctscoULBvJYBjcUCgSX3Px4eudcKwzvLNy/cM/5cbH/PrC//ChRa
LhEofc3d4yLRSBVpSVsZow8ZvfHg2e6Ldy8PPQcdMCelShuFPTImTFOJ36/yFy1x
iCb5UJdR9F3YsWYjFMNUFHelJyantOFyeQrNFNlxdL1dYtRBKhJ5f5YQ3V9npZW4
upJqe0nOIcEaRfxCtLNp/FEVsOYklPFOPvaaa8K8c85Wgobwe01N9Vs2n0WARtfE
ioewbq/O4FQi3pXhSk5yGB1B3FNr/njCF4cWV/B5XHTnKaQEaJiWz+b1UbACD2eQ
/lgGEvazMjUw7699SlEPn9wt8wMqTVoqH+K8Z2ZHXaYREyLRhmLCJO1pqSxZnPkk
qcZ/gHtw
=6a6x
-----END PGP SIGNATURE-----

--G+zlU6BxwjXp1y29--
