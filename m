Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC62EC43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23CA784B53;
	Wed,  1 Jul 2026 19:53:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BZo/pZ80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D354E84C46; Wed,  1 Jul 2026 19:53:35 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96086849FB
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a0e525db1eso592818eaf.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782928411; x=1783533211; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b9hGUHIA8vE/RvyiJdHJdknP6hzi6ottnNlS6wNNpfs=;
 b=BZo/pZ80U40SNi3qOjrCBXjifLDwizJX9HmhVcNvwQ/t2UGuit5OKVrD/Zot9DUdW/
 IbVb6EjO5Zi4tnzsXDdhSmsQ9neQfI7snj4mvKQxBlK54Gt13xtXCiaPJfS2NT9j0T2E
 WCQZxbaTCsv0Vfo7ZkXMDmKh4V9zP9uR4l3hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782928411; x=1783533211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9hGUHIA8vE/RvyiJdHJdknP6hzi6ottnNlS6wNNpfs=;
 b=ZDH8MLQ/qQZevTfjFXfhUVFoJ3h4MlkGBrUrkFUkGmAuL+da/1aP6X+u/kbr6zWhPu
 OyZub24dFk+6Jdd0F7dXrqYSncw9qyLwUbpiS5ZvizP49dk6VIGuPUxYA32jskK5jW2e
 LpsAY5E6WERpypP8b63tkR3+4hdeuLBnDU74bnrKD109SOEF8ixAZhWBsE44U/unkmC+
 IV7AT8BdRcIp3rCpsgWIzG4B9XmoQDksTaQGFnJ5amhUK0UQLx0akVORAeuKiSMdGEgX
 pPBXtunVf1ZaWYtayVf58WWdu54f6V1wQVLUmPwtHmeWEGkSJeaOd1j4eX0zWatg2sNJ
 Ua1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9niXFcj6Tudawn0Zxr9MagcRKzB+DQGNkYN5r3FqUF+X3micaqvt74vNkF4bFm9gouIgo0JDA=@lists.denx.de
X-Gm-Message-State: AOJu0YxtN7RRYXustkv5u4yECnh5rxQNidj92Z50zI9nCDn0ss4/TWe+
 qX7NpCKyVBcvxFReCrdcbubELKNQanCouRtBdKjRS2rf1/p3TCi813tIEEk5sPcQyTk=
X-Gm-Gg: AfdE7cmKLPRg0Wu9NNGwqHD/MY1K7MCvlUuTeXY2m4MjN4YMW+D1emzOtyEf9MCqMwa
 87jHbFW1Vc3+TosiM5/xJp0dGVptpbRDCSynDYBxt5orKtnroP00XAXd7BCW7MatE8vCps71Eiz
 byYG6mEFJguvFt/31MoA/sOWbmJcrQoT1SlwRvljfpNYtCHgx5Gyb1uo49hi99n59HHHxIQ4Stm
 PptoSaVBlDA0vOp6uFVwLV+ROprUeuc3P5Y1lDNk023G7QDbLCHXHAMIZqRp4B8rGipwrydgMr4
 HOjVYFTX+Ut2yp7wrE5xOALF2N1S+EZYG7kryTBOHRJvhR0aZx/zPJA8/wI3dryxkp1z/TUwP5/
 qOMweeET3tKgIbvtRUo65JcHILNYdduHd4d1yu6twNJmu3DInkP76UD+R6r55g+ofVWkdWmlMak
 +Kr0EdB3Bedu5K1/qsMiWd46HA/GfQu1ZSGwo1Ufon8gvOwRhfcMC0vUL/ixymVOhT7dyRr/m9d
 PGE2KJSl1dA6Zw01Xg84euXwl5NAXddK8kRPA==
X-Received: by 2002:a05:6820:1f04:b0:6a1:1b4a:dbe3 with SMTP id
 006d021491bc7-6a309a11f93mr1611973eaf.25.1782928410844; 
 Wed, 01 Jul 2026 10:53:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cbec93a70sm402212fac.11.2026.07.01.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:53:30 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:53:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Yao Zi <me@ziyao.cc>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 10/16] LoongArch: Boot Image bits
Message-ID: <20260701175328.GQ749385@bill-the-cat>
References: <20260701111808.870705-1-me@ziyao.cc>
 <20260701111808.870705-11-me@ziyao.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="foQTwMRbE4gOmdD7"
Content-Disposition: inline
In-Reply-To: <20260701111808.870705-11-me@ziyao.cc>
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


--foQTwMRbE4gOmdD7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 11:18:02AM +0000, Yao Zi wrote:

> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
>=20
> Implement loading and booting functions for LoongArch
> standard kernel image as per spec.
>=20
> LoongArch kernel do expect us to fake a efi systemtable
> for passing fdt to kernel, we don't need to implement any
> EFI functions for kernel because it won't look into anything
> beside devicetree from that table if we tell kernel we are
> not efi compatible by setting a0 boot argument to zero.
>=20
> Link: https://docs.kernel.org/arch/loongarch/booting.html
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Yao Zi <me@ziyao.cc>
> ---
>=20
> Changed from v1
> - Remove now unused arch_lmb_reserve()
>=20
>  arch/loongarch/lib/Makefile |   2 +
>  arch/loongarch/lib/bootm.c  | 163 ++++++++++++++++++++++++++++++++++++
>  arch/loongarch/lib/image.c  |  66 +++++++++++++++
>  cmd/Kconfig                 |   2 +-
>  4 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/lib/bootm.c
>  create mode 100644 arch/loongarch/lib/image.c
>=20
> diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
> index 3c17b9cd85af..e65e66357a9b 100644
> --- a/arch/loongarch/lib/Makefile
> +++ b/arch/loongarch/lib/Makefile
> @@ -3,6 +3,8 @@
>  # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
>  #
> =20
> +obj-$(CONFIG_CMD_BOOTM) +=3D bootm.o
> +obj-$(CONFIG_CMD_BOOTI) +=3D bootm.o image.o

We have LIB_BOOT[MI] symbols now, which should be used here instead.

[snip]
> +/**
> + * announce_and_cleanup() - Print message and prepare for kernel boot
> + *
> + * @fake: non-zero to do everything except actually boot
> + */
> +static void announce_and_cleanup(int fake)
> +{
> +	printf("\nStarting kernel ...%s\n\n", fake ?
> +		"(fake run for tracing)" : "");
> +	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> +#if CONFIG_IS_ENABLED(BOOTSTAGE_FDT)
> +	bootstage_fdt_add_report();
> +#endif
> +#if CONFIG_IS_ENABLED(BOOTSTAGE_REPORT)
> +	bootstage_report();
> +#endif
> +
> +#if CONFIG_IS_ENABLED(USB_DEVICE)
> +	udc_disconnect();
> +#endif

We don't have USB_DEVICE anymore, so I think you should look at the git
changes to arm and riscv for example to these functions, since the
loongarch port was done, to catch up on current best practices here.
Thanks.

--=20
Tom

--foQTwMRbE4gOmdD7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVUFwAKCRAr4qD1Cr/k
CvnnAP40DOHL/fA/hf1J7Nv5AYY613brnYkY4KANuxtQnaf4+QEAptjQ9RQNkTD8
tEU9rNGpWFr7hj64EHWWIj14zPEsyAE=
=cmQu
-----END PGP SIGNATURE-----

--foQTwMRbE4gOmdD7--
