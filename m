Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7B0C27C53
	for <u-boot@archiver.kernel.org>; Fri,  7 Jun 2024 21:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BD7A87ABC;
	Fri,  7 Jun 2024 23:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="M3J0Cfn2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF65B87E49; Fri,  7 Jun 2024 23:19:21 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B858E87842
 for <u-boot@lists.denx.de>; Fri,  7 Jun 2024 23:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6f96f8489feso140144a34.0
 for <u-boot@lists.denx.de>; Fri, 07 Jun 2024 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1717795158; x=1718399958; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cXQWjGqIR79Ml+Xsssn8mRcGR/tkft4KP4jr+OEpIhI=;
 b=M3J0Cfn27ITtamnJQVCTztyPxnlg4Ovoor5nQSO2im3aME8zKs0XRh2teRnA/NxSlX
 LnE5IZd073Nz71C6NpS4fFhOr5RCVqp6eISRGUEtfgoUETi1npVhjziht+iwyM60MfwW
 OQDli0eNQW0bYMGftlrE9tkQrMMdR2LRdqpTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717795158; x=1718399958;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXQWjGqIR79Ml+Xsssn8mRcGR/tkft4KP4jr+OEpIhI=;
 b=txV7AKKWQmDsVQrhZpKrY2rldcQGE6DGvsNeVA+rW4Oyu8WUxnAmQwyuei+qmhIJt/
 Kwww3zXDygFIBNrJsKfsxz7rSVdQe1bq2uqJsT7Al/2i4n1FyT58nXvKyRzDMGjsIIUQ
 tWMOwXHVa1iYReICBGUlE68mOnQH5KxNN1arNyRebrDYVEKQoVoxlv/tPGzyO64D5LSe
 y/HblQZJxUw7aRNBXLVFYYDrNG84IVkwDyA7doE9cBg/Cr8xqj+4DPcwD6e5FWDVtmuA
 TUefZjx272dum+3uUcPjp+50nbI7SxpV9Jq1xYZ7zYMoT3mdVgiOyMrF4oY9GkIVABya
 F+aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXof9QkU2yCGNe55o1fCeCknwZxN5MEPp2o9GVrG4e5OcakapmUkkeXGZL0mi5MF2ElTaTavOStG9c5lPtm4JZw5Ar9A==
X-Gm-Message-State: AOJu0Yz4ArbRb2hfZzNR6uiDY31jrba1uP8qV7azy4K+s3Vmt+0KT9lS
 NuhVLOXVn7cOvnWwKQSpC+rf8fbnymltowouoJB9pYdM5CZhNBfigJx7gU6qmvg=
X-Google-Smtp-Source: AGHT+IEdjwjEI2S88hWd+c0CAgOCY4dkBie32nyAcDfjEs/QCEev7zLcrsgDuVoRP8e16AYftzNmRg==
X-Received: by 2002:a9d:6658:0:b0:6ef:7f93:13ac with SMTP id
 46e09a7af769-6f9572d4b3bmr3797023a34.29.1717795158113; 
 Fri, 07 Jun 2024 14:19:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6f96578d58fsm174546a34.51.2024.06.07.14.19.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jun 2024 14:19:17 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:19:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/3] doc: arch: arm64: describe pagetable debugging
Message-ID: <20240607211914.GL68077@bill-the-cat>
References: <20240607-caleb-upstreaming-v2-0-bae407f51f22@linaro.org>
 <20240607-caleb-upstreaming-v2-3-bae407f51f22@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KI0vCGFkgDZKxZXu"
Content-Disposition: inline
In-Reply-To: <20240607-caleb-upstreaming-v2-3-bae407f51f22@linaro.org>
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


--KI0vCGFkgDZKxZXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 07, 2024 at 10:42:51PM +0200, Caleb Connolly wrote:
> Add some brief documentation on using dump_pagetables() to print out
> U-Boot's pagetables during boot.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  doc/arch/arm64.rst | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/doc/arch/arm64.rst b/doc/arch/arm64.rst
> index 7c0713504c47..0c851304aad4 100644
> --- a/doc/arch/arm64.rst
> +++ b/doc/arch/arm64.rst
> @@ -47,8 +47,45 @@ Notes
> =20
>  6. CONFIG_ARM64 instead of CONFIG_ARMV8 is used to distinguish aarch64 a=
nd
>     aarch32 specific codes.
> =20
> +MMU
> +---
> +
> +U-Boot uses a simple page table for MMU setup. It uses the smallest numb=
er of bits
> +possible for the virtual address based on the maximum memory address (se=
e the logic
> +in ``get_tcr()``).
> +
> +As with all platforms, U-Boot on ARM64 uses a 1:1 mapping of virtual to =
physical addresses.
> +In general, the memory map is expected to remain static once the MMU is =
enabled.
> +
> +It is possible to debug the pagetable generated by U-Boot with the built=
 in
> +``dump_pagetable()`` and ``walk_pagetable()`` functions (the former bein=
g a simple
> +wrapper for the latter). For example the following can be added to ``set=
up_all_pgtables()``
> +after the first call to ``setup_pgtables()``:
> +
> +.. code-block:: c
> +
> +    dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
> +
> +This will result in a print like the following:
> +
> +.. code-block:: text
> +
> +    Walking pagetable at 000000017df90000, va_bits: 36. Using 3 levels
> +    [0x17df91000]                   |  Table |               |
> +      [0x17df92000]                 |  Table |               |
> +        [0x000001000 - 0x000200000] |  Pages | Device-nGnRnE | Non-share=
able
> +      [0x000200000 - 0x040000000]   |  Block | Device-nGnRnE | Non-share=
able
> +    [0x040000000 - 0x080000000]     |  Block | Device-nGnRnE | Non-share=
able
> +    [0x080000000 - 0x140000000]     |  Block | Normal        | Inner-sha=
reable
> +    [0x17df93000]                   |  Table |               |
> +      [0x140000000 - 0x17de00000]   |  Block | Normal        | Inner-sha=
reable
> +      [0x17df94000]                 |  Table |               |
> +        [0x17de00000 - 0x17dfa0000] |  Pages | Normal        | Inner-sha=
reable
> +
> +For more information, please refer to the function documentation in
> +``arch/arm/include/asm/armv8/mmu.h``.

Since the function comments are kernel-doc style, can you please rework
this to leverage "kernel-doc::" and make sure it renders nicely? And
this may show we should be putting some function comments in 2/3 of this
series as well.

--=20
Tom

--KI0vCGFkgDZKxZXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZjeUwACgkQFHw5/5Y0
tywr/gv+LQaH4KgXdZPvkxi33Z+cLjWlK1fNCbw/vIiTVCuXwqI4erD0ZFpf41mC
lCB1y+sjGr6G73HqepXAUSHtn2107qCpW+8HPrbjv/s4U1PYdQBR2s4MVzfgweKU
wV//6dO8ap4lhnjykxT5mUcat0k1sJP/v14cLn1M+LOgfzaW8T+e37QD2aEyH4Xj
IQyzo7pqxOMgMliiaZlkl+KQmau8unyZqVZzl5EVDh/zXWvucxN9cG6ttRPLY24A
B9dvwilOv/IuuMYDcAas34QkLCfHpKStYOQECCmNydqN9cTiKfAy2w44EEr1+MHO
aWV9cmS7RzgEhpTFKK+X4EvO1dlWI5h6wrP0ktfgJakMvK5daEPlftQB7BsCEEJI
RQXcsBaEvHxpBmw8F28KiM00ma6/bEzogux/WgGo2zAC+Prlhlr7xCjqQ9pdiy4O
JaB36rVUrL20jJ1bMfo+sx49XF8X/qLlG3jKyJe77nBUjfvLusTdsShB0acxt8q0
xW7cVtfr
=dKai
-----END PGP SIGNATURE-----

--KI0vCGFkgDZKxZXu--
