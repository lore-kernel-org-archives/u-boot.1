Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C5FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 18:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43BDC8829B;
	Wed, 15 May 2024 20:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RtQC4g2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23A7882CE; Wed, 15 May 2024 20:51:12 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A721688261
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 20:51:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6a04bb4f6d5so37636686d6.0
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715799068; x=1716403868; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KTJEbWyYk0cgssWCplfExz8UafbYvdA0491L4/k5+mI=;
 b=RtQC4g2gK6j0Q07DZPmQ9UZV/qb94V5uVUNLVvwdYEyZY7ANWeey1xY41Z6m0CmZvz
 +ZLpFieHW/76L67l685MywT2xhddkexCJRJp3IrTLY2P9txd7p5zFqZZGskXYciCWnRM
 LnltVM9xS5DcZ5NACirE9AMyemhHiIBVRgRr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715799068; x=1716403868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KTJEbWyYk0cgssWCplfExz8UafbYvdA0491L4/k5+mI=;
 b=rseaR3wzCVcUdK6i5MaeWTffEVXw65Qw2YcZs50BWoew+8yhuiPGNw21Ap5HBoXg9R
 D2YjeD+dfS67Sk9GYJE8gOCm1dst7tHwrL7AeE+8EzwKoyYsXBomUCUTFBqgp0FrifJ2
 2gsT4c0a12yVHkfaqc//2lQ1mfuVglk7ew+ESZRMenPTyNvresv9Yz0hhRhGQlj2qGKg
 pL/jJqgq/RbMoku4Q2iOEn4mMI4eWRk25M7T5BQaacSd3zjMFM1S5Zx8lF5Vs/45Mg6L
 s1DgCEvTVVj+4R6MA1eoR6DBQPaFUhyZi4y9NCW6Bv15O8Ko8F9SuQTRGU7zVyWu+HIx
 RtHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc72cJMSv81Iqdwr6uffpnxBkDi5OQQ0BbzAHbUTIsXyKnqaLVo7lA9+ZJ+sHCyRhcp0tc1K0dD7iYCsksfdZ0mXDmQg==
X-Gm-Message-State: AOJu0Yw0dsj58QMq+HvwRnQBG8s1rT9/YcklUjONQD0FeCi7kynNcgPJ
 zXmqdgAcLYN5EhkZ9uj2JIgReKBmHrWxdorn+3wkME9v7UtthszoMdCuONRAU90=
X-Google-Smtp-Source: AGHT+IFgedIZ8buN8Q+DC1IC/+oN53QK+ebFh1X+Q7dJlAv5zdjayyEsM8SB9WEadBJn/AFgvmxi0w==
X-Received: by 2002:a05:6214:4807:b0:6a3:5d98:67c8 with SMTP id
 6a1803df08f44-6a35d986d42mr8983316d6.51.1715799068511; 
 Wed, 15 May 2024 11:51:08 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f179aa6sm67101606d6.9.2024.05.15.11.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 11:51:08 -0700 (PDT)
Date: Wed, 15 May 2024 12:51:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: YSCHU@nuvoton.com, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v1] board: nuvoton: Use an event to replace
 last_stage_init() and fix build error
Message-ID: <20240515185104.GZ2568172@bill-the-cat>
References: <20240507091055.1749680-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LiaYiH//q3bC9Sdm"
Content-Disposition: inline
In-Reply-To: <20240507091055.1749680-1-JJLIU0@nuvoton.com>
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


--LiaYiH//q3bC9Sdm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 05:10:55PM +0800, Jim Liu wrote:

> Followed the new style use event to replace last_stage_init().
> Fixed build error After replace last_stage_init().
> And remove CONFIG_SYS_SKIP_UART_INIT from defconfig,
> system will reuse the setting from bootblock
> and skip the baud rate setting.
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
> ---
>  board/nuvoton/arbel_evb/arbel_evb.c | 7 +++++--
>  board/nuvoton/common/Makefile       | 2 +-
>  board/nuvoton/poleg_evb/poleg_evb.c | 6 +++++-
>  configs/arbel_evb_defconfig         | 1 -
>  4 files changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/board/nuvoton/arbel_evb/arbel_evb.c b/board/nuvoton/arbel_ev=
b/arbel_evb.c
> index 53c931c3c2..d112329dc1 100644
> --- a/board/nuvoton/arbel_evb/arbel_evb.c
> +++ b/board/nuvoton/arbel_evb/arbel_evb.c
> @@ -5,6 +5,7 @@
> =20
>  #include <common.h>
>  #include <dm.h>
> +#include <event.h>
>  #include <asm/io.h>
>  #include <asm/arch/gcr.h>
>  #include "../common/uart.h"
> @@ -95,9 +96,11 @@ int dram_init_banksize(void)
>  	return 0;
>  }
> =20
> -int last_stage_init(void)
> +static int last_stage_init(void)
>  {
> +#if CONFIG_IS_ENABLED(CONFIG_SYS_SKIP_UART_INIT)

The CONFIG_IS_ENABLED takes symbols without the CONFIG_ prefix part so
that it will be true for FOO, and SPL_FOO and TPL_FOO.

--=20
Tom

--LiaYiH//q3bC9Sdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZFBBQACgkQFHw5/5Y0
tyyVegv/ar5rAZt8ZJtBjkRzLRpK2UwYVtymSOW0DdIM51IZ6I9hTEwak+pJjsug
SlnmR1hrZ/K0tds1uL7kFz1KqvYLL/2o5uDlWrg8+aDYD3FK6Ukdnq40eChT3RfM
6g5h4IRc4uiWagMbOKkNtjRqDmI8cbApBM2tYiTRfW2zj+LdnyXURfZA/xnZ5QT4
GgCVPopZDlNtx89dLBPeXzPAZxRxIo3BJEpzN79idG49un95PKIyBELIblpJkEC2
VTmTl1lIMCOp4d1JOgLGezoj9pYxocc0moapq1WeENh+agqphHpWyZS0TYu+Ks2f
VAXRA1e5mV31cORBp5x/kkwjXbnj4Tw8UlmuL/whD2Ygq9EcWkkqcq0M45BoMOHI
E00WoYIjvcOCoTPFURciw23xsfV/u2IfqnKtTagxJbxUahMsg/dmmY/3tq6KhueG
T0AnSNDgyjD6FkLjI4NhPcBP5e35TuPt1gqdj5zY+qfropGU7BWrEktZLbG5nPTF
KWIwsSKI
=y3DG
-----END PGP SIGNATURE-----

--LiaYiH//q3bC9Sdm--
