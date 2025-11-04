Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D06CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 20:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76C3A808AF;
	Tue,  4 Nov 2025 21:42:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oYskfUzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 289D7832AD; Tue,  4 Nov 2025 21:42:53 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7D78004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 21:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74526ca79beso4233927a34.0
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 12:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762288969; x=1762893769; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TKiub1F/8tpXrzLg5+RhXwfUECNtj6kfWxjwFeCqlXA=;
 b=oYskfUzdfE/dZ9EXgzFdtaHLrI1FiGjrx01QX4dcZ0gUVL/rW/X+hadtee3XckAbzl
 N01rUYianeNOE5Bop2LZ4ilut8QfgdNOsK3iQ1avkLJmKQ9qhDGUoSVJYJRN92qD2+6w
 18/O3CbRzb03ryassqUVX7UWKKDYmvUQW42u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762288969; x=1762893769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKiub1F/8tpXrzLg5+RhXwfUECNtj6kfWxjwFeCqlXA=;
 b=kyitrQm4sbEJ1o2li6qslOooUFTUdRTQbqiQHyRmsORhEVIGgHWDNYIdv6A/+pD4cZ
 f5GumMqTturJAlHUF2VqjWyYkrUfHiPM+PFAXbxOx4NP+c+fPWQRicCfGuiIhqTVUr7o
 fRoUZyH/HHmDm8IgoHF3SdOXt5O78wa1xFWrVjri2rV7Q5P6AhzohwHwRPy3d01OhJca
 VBXEU101yAqdYNDyqXvoeSApbIilPmgoQ51C6y/ufb839W/9DuUN1bolLN806i5xrxjd
 WgEAqAmbddonwYkbCcvKEcgE6R48dVXAK19HxxkfHwRRvoZXDBW3Vp4vjcCSeRr0oYMp
 KPrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWd2XFJMdT4Y4fqZ0MfovnrfFuFvsNRepI7LOnaqypdhMq+c3hdj7oHGAKyoEuvMi5yPRH2cJY=@lists.denx.de
X-Gm-Message-State: AOJu0YwO5yOad/vrwBqWrle0MbdMmPQ4ic3CZoQ1aYWssMt65XE0K18K
 z/d0NXK09BR1O7rPml/JnLrt0aVzbXW5P7Vy4Xv6w9u8YXqGIwPQfl6YQW2Sj8pmfYs=
X-Gm-Gg: ASbGncu0+9zLAESqREKyiLZm79WolTvIfxdGeTvJ70J2WINc4Nn7mZ4hmE7+Oa0JY9q
 oE46x9UZT3AL85Lz+7WyZhOMLea5KbZfHy3VrcqEolxYkANJegn7FFPZsr43xD5Q3xqtR2DCbn9
 05KeGOP83LwHWAtUYn5m8fVRd0rZL0RAgP0OtUcKpWkwzX31+lvECTV6s2i9ph5XuBC+L3RV167
 P4MiYG27NU06d5AQ0Xl8whSkPMUoSmCJmnZJ2RwSeUvj27Il9Fc3xCsmDpCGXldgG8ganEsq+tm
 VBHcFLQ5IOnYogi/JhY67i7AoZsClMk/vigMlwAmjuqKXCg03eM4TICXhmtgRJl6GuW5i/01BsP
 zwMzCo+S98SMupCTmgsXJVnIbllwM73sspidIrSi4r3X30NOBeCBgpkW4zxJ6OAVSSGO/c9OjWv
 eidrJBNondSvaCjBmhJGV2fJAYI/rJIKDsBkx/1UxC8DV4UDXJ3Q==
X-Google-Smtp-Source: AGHT+IFs2WlnqUBUc5i2aKSl/Vfd0cLtk1vWOXWHxwlVaSSeNHlEPBT3TV8iLaCK8qZPwoSkCmAC5Q==
X-Received: by 2002:a05:6808:ec5:b0:43f:18a2:97ae with SMTP id
 5614622812f47-44fed32a3f0mr404111b6e.30.1762288969648; 
 Tue, 04 Nov 2025 12:42:49 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44fe4ca9d03sm418115b6e.24.2025.11.04.12.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 12:42:48 -0800 (PST)
Date: Tue, 4 Nov 2025 14:42:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: raymondmaoca@gmail.com, Xu Zhang <423756212@qq.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] armv8: Fix transfer list passing with KVM
Message-ID: <20251104204246.GG6688@bill-the-cat>
References: <20251104150404.3355422-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="maWxgzM7kHT+XpLy"
Content-Disposition: inline
In-Reply-To: <20251104150404.3355422-1-ilias.apalodimas@linaro.org>
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


--maWxgzM7kHT+XpLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2025 at 05:04:02PM +0200, Ilias Apalodimas wrote:

> When loading U-Boot in a low memory address, the adpr instruction
> to preserve saved_args[] end up within the memory space of QEMUs
> mapped pflashes. As a result the following store pair instructions
> lead to a crash since instructions that modify more than one registers
> can't trap into KVM.
>=20
> This problem can be solved with loading U-Boot with -kernel
> and defining a different text base address. But when running with
> -bios we always start from 0x0. So let's postpone the calculation
> of saved_args[] post relocation, where we will have an address that
> doesn't collide with the QEMU flashes.
>=20
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  arch/arm/cpu/armv8/start.S | 8 ++++----
>  arch/arm/lib/crt0_64.S     | 4 ++++
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv8/start.S b/arch/arm/cpu/armv8/start.S
> index 40c342e97e9b..ef335de16b79 100644
> --- a/arch/arm/cpu/armv8/start.S
> +++ b/arch/arm/cpu/armv8/start.S
> @@ -387,10 +387,10 @@ ENDPROC(c_runtime_cpu_setup)
>  WEAK(save_boot_params)
>  #if (IS_ENABLED(CONFIG_BLOBLIST))
>  	/* Calculate the PC-relative address of saved_args */

This comment is no longer correct. We're saving a few regs in other regs
that can't be touched until later.

> -	adrp	x9, saved_args
> -	add	x9, x9, :lo12:saved_args
> -	stp 	x0, x1, [x9]
> -	stp 	x2, x3, [x9, #16]
> +	mov     x0, x19
> +	mov     x1, x20
> +	mov     x2, x21
> +	mov     x3, x22
>  #endif
>  	b	save_boot_params_ret	/* back to my caller */
>  ENDPROC(save_boot_params)
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index 3e7627aa389b..d6246010f368 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -132,6 +132,10 @@ ENTRY(_main)
>  	b	relocate_code
> =20
>  relocation_return:
> +       adrp    x9, saved_args
> +       add     x9, x9, :lo12:saved_args
> +       stp     x19, x20, [x9]
> +       stp     x21, x22, [x9, #16]

Here is where we should comment on what's being calculated (and is it
safe to do this without BLOBLIST?).

--=20
Tom

--maWxgzM7kHT+XpLy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQplQwAKCRAr4qD1Cr/k
CgPgAP0SZuA96kn9jXJEDbEtsCRjNDzd2fSji1WHy6rWBa4QOwEAyiqgFwBTQJkm
5RPQwIORtWnIc3k/bYIHaNOURLX2gg4=
=0rCF
-----END PGP SIGNATURE-----

--maWxgzM7kHT+XpLy--
