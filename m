Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235B3CEDDA3
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:59:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2EC688EEF;
	Wed,  9 Oct 2024 16:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CkfCVYfA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B1A88DFA; Wed,  9 Oct 2024 16:38:33 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D01C88D54
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:38:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-45821eb62daso42774861cf.3
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 07:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728484710; x=1729089510; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T5TE2hwX1mkuJQqpk8wlfcm7lKH3KQRrLL88iI7zPG8=;
 b=CkfCVYfAaHYz1VLPZZF1SaIEWKIdffY2uCXHdjHKpwRJWMN/OEUrT2AeDNlVDUGhEP
 LMHF0JiALmwRLxhh+sHsx/hYsHtpLUlRY9wPoD+InFsGPe2axI5vpeUppitM0zq9guTA
 gS9bJhDyWQfPnPlBKns3exYrFI/QAaFO83YQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728484710; x=1729089510;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5TE2hwX1mkuJQqpk8wlfcm7lKH3KQRrLL88iI7zPG8=;
 b=tTqUuke/HybDGGgiHIAPHPADqHYhwFgY4EER0i6JUWwWNcN2g1Z8Ow81x3XPbGZqIL
 5duYbTodZeMPHjXdcIwvnoNWrVcj9xGqpj0sRunkCOsTq6PGcH20Iqevrdc1LjalmtzM
 fxOt51FxN3zMxg3dHsM1a0N4mGG27McdlaCAPDmpm5/uYkeEtqu2boZUpX4IqoHV4/u8
 aKYrFIeRQOTR6PimkVUP58r0T3+BBdTGA9Uwuk1qf08UFUvkJ3gvBGyLKdvRgprlwuSp
 eeyzcw40eXPmL0R9DuKFnil9gkm+CkYX6vgO38UsTiygLZ5y6iHyePdO1EljAbYov9N8
 TPMg==
X-Gm-Message-State: AOJu0Yy2UgVkWwmb+QlODUrr2TsI9+57R80xpyWiRjvmUK++/H7jKBVL
 0BBcauJXl+xwlH71R0LvPJVP29nYxMxUhnnNuCx79fDGSFTWQs+b7BucOW9s0T8=
X-Google-Smtp-Source: AGHT+IGem7brAfpo43NqVRqZ7clRWJMJEGDvXxxhJfGOSt1SFABByyDhwmYpUuriC2ysPaeZJMj6yQ==
X-Received: by 2002:a05:622a:298c:b0:45d:8627:3d02 with SMTP id
 d75a77b69052e-4603ed63097mr4045781cf.27.1728484710351; 
 Wed, 09 Oct 2024 07:38:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45da7514306sm47031771cf.39.2024.10.09.07.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 07:38:29 -0700 (PDT)
Date: Wed, 9 Oct 2024 08:38:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Sumit Garg <sumit.garg@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonathan Humphreys <j-humphreys@ti.com>, Marek Vasut <marex@denx.de>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH v8 03/27] lib: Adapt digest header files to MbedTLS
Message-ID: <20241009143824.GJ14210@bill-the-cat>
References: <20241003215112.3103601-1-raymond.mao@linaro.org>
 <20241003215112.3103601-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cv9N7qa+HN6tlaeS"
Content-Disposition: inline
In-Reply-To: <20241003215112.3103601-4-raymond.mao@linaro.org>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 09 Oct 2024 16:59:07 +0200
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


--cv9N7qa+HN6tlaeS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 03, 2024 at 02:50:16PM -0700, Raymond Mao wrote:

> Adapt digest header files to support both original libs and MbedTLS
> by switching on/off MBEDTLS_LIB_CRYPTO.
> Introduce <alg>_LEGACY kconfig for legacy hash implementations.
> sha256.o should depend on SHA256 kconfig only but not SUPPORT_EMMC_RPMB,
> SHA256 should be selected when SUPPORT_EMMC_RPMB is enabled instead.
>=20
> `IS_ENABLED` or `CONFIG_IS_ENABLED` is not applicable here, since
> including <linux/kconfig.h> causes undefined reference on schedule()
> with sandbox build, as <linux/kconfig.h> includes <generated/autoconf.h>
> which enables `CONFIG_HW_WATCHDOG` and `CONFIG_WATCHDOG` but no schedule()
> are defined in sandbox build,
> Thus we use `#if defined(CONFIG_MBEDTLS_LIB_CRYPTO)` instead.
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

There's three platforms where we see something like:
       arm: (for 1/1 boards) all +5651.0 data +112.0 rodata +139.0 text +54=
00.0
            o4-imx6ull-nano: all +5651 data +112 rodata +139 text +5400
               u-boot: add: 23/0, grow: 1/0 bytes: 1172/0 (1172)
                 function                                   old     new   d=
elta
                 hash_command                               108     296    =
+188
                 sha1_finish                                  -     156    =
+156
                 static.sha1_update                           -     114    =
+114
                 hash_algo                                    -     112    =
+112
                 sha1_padding                                 -      64    =
 +64
                 hash_lookup_algo                             -      60    =
 +60
                 sha1_starts                                  -      52    =
 +52
                 crc16_ccitt_wd_buf                           -      36    =
 +36
                 sha256_csum_wd                               -      34    =
 +34
                 sha1_csum_wd                                 -      34    =
 +34
                 hash_finish_sha256                           -      34    =
 +34
                 hash_finish_sha1                             -      34    =
 +34
                 crc32_wd_buf                                 -      34    =
 +34
                 hash_finish_crc32                            -      28    =
 +28
                 hash_finish_crc16_ccitt                      -      28    =
 +28
                 hash_init_sha256                             -      22    =
 +22
                 hash_init_sha1                               -      22    =
 +22
                 hash_update_crc32                            -      20    =
 +20
                 hash_update_crc16_ccitt                      -      20    =
 +20
                 hash_init_crc32                              -      20    =
 +20
                 hash_init_crc16_ccitt                        -      20    =
 +20
                 hash_update_sha256                           -      16    =
 +16
                 hash_update_sha1                             -      16    =
 +16
                 sha1_update                                  -       8    =
  +8

This is because:
> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
> index 982e84dc3bc..5d7fd904950 100644
> --- a/drivers/mmc/Kconfig
> +++ b/drivers/mmc/Kconfig
> @@ -119,6 +119,7 @@ config MMC_HW_PARTITIONING
>  config SUPPORT_EMMC_RPMB
>  	bool "Support eMMC replay protected memory block (RPMB)"
>  	imply CMD_MMC_RPMB
> +	select SHA256
>  	help
>  	  Enable support for reading, writing and programming the
>  	  key for the Replay Protection Memory Block partition in eMMC.

Wasn't true / required before now, no hashing algorithms were enabled.
This was fine because:
[snip]
> diff --git a/lib/Makefile b/lib/Makefile
> index c4950b78a29..33755778283 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -50,7 +50,6 @@ obj-$(CONFIG_XXHASH) +=3D xxhash.o
>  obj-y +=3D net_utils.o
>  obj-$(CONFIG_PHYSMEM) +=3D physmem.o
>  obj-y +=3D rc4.o
> -obj-$(CONFIG_SUPPORT_EMMC_RPMB) +=3D sha256.o
>  obj-$(CONFIG_RBTREE)	+=3D rbtree.o
>  obj-$(CONFIG_BITREVERSE) +=3D bitrev.o
>  obj-y +=3D list_sort.o

Got us the library access without bringing in everything else. And since
two of the platforms that are hitting this now are "nano" this is an
important thing to figure out how to continue to support. If there's
just no way around it, we can likely live with the size increase, but
I'd like to see this looked in to specifically first, thanks!

--=20
Tom

--cv9N7qa+HN6tlaeS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcGlVwACgkQFHw5/5Y0
tyww7wwAgMfwvhbeFiRJb4UXeIMQRcej8ZMS6BNXJfCZdZ05jp+Be2uSYG5LBdtx
rXHSE/qdHJO4kblwXA1nrEF9jUDgVjD4QodceaQQ4F1GCdG6gEsY7hcTlP56HEV0
vA8rPPWVGwrSC18igLG7spfRqg9AN2SNTeZJLDpH8ERSV2CFagKyLMnwmtJC95SY
fwZlTUI+BbryJV5o4vw8HTXWjJFTRxpDgDRo5Gi0C6AFSSfLmJC2+mf3yMkvrFBU
n9mFQgzdTTYKxtF8zrQFRZ8x8KLmDCreu7SOSTwgzUFMv8v2KoK7nU8ALAJc3FVh
mu/pQ/pozhnlsCw/BKjruiu87iWrbGmDlW8hyQq4fDJ07JHiE6qghWoW2aSJdhLV
7JYihG48fs4LMlATnwIa7ItZc5doQR4TtdzVQforaQoMcddpQpWwA0RxvJeiVxFs
3xIuw9C4CbW8WLqDE4HLUhWDSdpqSHRA+8a7gz0BpTv3uVVjpJ60637J1GAxUgXq
nmy70ym/
=mTiG
-----END PGP SIGNATURE-----

--cv9N7qa+HN6tlaeS--
