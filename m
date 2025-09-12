Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960A0CA101F
	for <u-boot@archiver.kernel.org>; Fri, 12 Sep 2025 20:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D039A833BF;
	Fri, 12 Sep 2025 22:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MbjF8dMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDDD0833E9; Fri, 12 Sep 2025 22:35:17 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B23E383322
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 22:35:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-746da717f35so1207522a34.1
 for <u-boot@lists.denx.de>; Fri, 12 Sep 2025 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757709314; x=1758314114; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=auBfLC7tlFgFDj0is2bjO+g0bXjAKIr5O0WN8fTcVHU=;
 b=MbjF8dMrb0euPQnJMSXgjWii8CjcJxy6jqh2eIS47Rw6v64qj07Ow664QIiZbvLjUN
 vuh/AUJLnExZA1sUjCF/36EgSFEoH6sAS63PElevmS6xC+JM2kk/IupKQfZlIRRY7e7q
 nxKK0OFjdMBLpdEn7tLU+hodPKpt6FHkUTWQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757709314; x=1758314114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auBfLC7tlFgFDj0is2bjO+g0bXjAKIr5O0WN8fTcVHU=;
 b=wWB81yyOUKFvtV4Ttp3ZTszPuLsRMrYCz7sQBdrbivhCWYmqmR47wy+iVski2OBCoL
 IWtKkMVrDpMca4Sj+k2cUnQpqeat/W/kzJFmuYKMhufV9K8AakpvCxMylvnAJfQvHOPX
 qIdzSx0TC3Dp5p9haKkRYUlAkBqTYjQdqDkVon1MHSPrcJ5HALYPo6yRLokB8Fb9vbvY
 CwGxBtBEuAZeVRi4g3UnJNWPk6HP27+4fMMvqaf1DVXsZXhsnqOwDhHXYn1vszmUxUkW
 J+gZf32uOgtlP6IsJS0xyl3Lx5vMhWZRg2XmDBRIOsx3gj+uQYxIj7tApkTMzF9vsL8L
 aMdQ==
X-Gm-Message-State: AOJu0YyYhhLATD751Jt5NNiOBLpI4vDq6thcXRCCD5k/msQmid3QgS0h
 5mph9PIVwHK/xnh0+l7Gk5je9/tiHSi4bGQUoLUX9v7TMthLveQi1KvyEKJpAgPjfbI=
X-Gm-Gg: ASbGncss60ztUGjSbl7J2cWlw17jKjKDgYIofbIByKUqxOYlazgCLgLDTRmoBcuj7bs
 5uVqD091kT1haGl8Owjkso18jHc6ujOyrz536h0TDh/DSw+EopwWHp63No/X+2TBOcrpLXy0NVp
 s61SAZlsY0TznCxdJ73TvJW7r3b/zYL6S7LhaPlkU2cownTeEQHzu6a/lGpLxlAvjFqjakCO3C6
 xs0fBi/ct9pAv6DhSSG71RaHvQeE6r/AT7+LWjwGJm2oFZqycNVXtiNeT2SsuXQzTk4SZl+D1/l
 SdWghdrizmYlJ7yS6dIwQHvyqemxRqSe2bu7fjOkZ9d/MKmu6CRmJySSO3il6ksTMzt7vWcrqMa
 dDnFwPybc8wBWVAfBiM7lGf1iz2KUyC5z/qFdDau22Ve5Dp8isV3+oXx+Sc3JbS+ZVoQ=
X-Google-Smtp-Source: AGHT+IHSbOnE2rfykqh5eCfbYANo4j9TTLQdXvb/u0KR44YMTK1Rm34/JUWFHXdSh3EvHL6+WdlfpQ==
X-Received: by 2002:a05:6830:2108:b0:746:d3f0:e948 with SMTP id
 46e09a7af769-75355cb1945mr2285369a34.30.1757709314387; 
 Fri, 12 Sep 2025 13:35:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-621b7d74121sm603020eaf.23.2025.09.12.13.35.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 13:35:13 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:35:11 -0600
From: Tom Rini <trini@konsulko.com>
To: briansune <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd/dma: implement dmareset command
Message-ID: <20250912203511.GD124814@bill-the-cat>
References: <20250831222501.2045-1-briansune@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jmkDcrizS97lRGRl"
Content-Disposition: inline
In-Reply-To: <20250831222501.2045-1-briansune@gmail.com>
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


--jmkDcrizS97lRGRl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 06:25:01AM +0800, briansune wrote:

> Add dmareset command to release PL330 DMA channel resets.
>=20
> Signed-off-by: briansune <briansune@gmail.com>
> ---
>  cmd/Kconfig  |  7 +++++++
>  cmd/Makefile |  1 +
>  cmd/dma.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 cmd/dma.c
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index e55a48a49af..720e3121018 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1149,6 +1149,13 @@ config CMD_DM
>  	  can be useful to see the state of driver model for debugging or
>  	  interest.
> =20
> +config CMD_DMA
> +	bool "dma - Release Reset DMA Channels for PL330 Handshake"
> +	default y

New commands should not be "default y" and this likely doesn't build in
a whole lot of cases. If this is indeed PL330 specific, it should have a
less-generic name.

> +	help
> +	  Provides access to Reset Manager Per2ModRst. Enables DMA
> +	  channels for ARM PrimeCell PL330 via reset release.
> +
>  config CMD_FASTBOOT
>  	bool "fastboot - Android fastboot support"
>  	depends on FASTBOOT
> diff --git a/cmd/Makefile b/cmd/Makefile
> index 082470fa104..748c53767b8 100644
> --- a/cmd/Makefile
> +++ b/cmd/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_CMD_CPU) +=3D cpu.o
>  obj-$(CONFIG_CMD_DATE) +=3D date.o
>  obj-$(CONFIG_CMD_DEMO) +=3D demo.o
>  obj-$(CONFIG_CMD_DM) +=3D dm.o
> +obj-$(CONFIG_CMD_DMA) +=3D dma.o
>  obj-$(CONFIG_CMD_UFETCH) +=3D ufetch.o
>  obj-$(CONFIG_CMD_SOUND) +=3D sound.o
>  ifdef CONFIG_POST
> diff --git a/cmd/dma.c b/cmd/dma.c
> new file mode 100644
> index 00000000000..b35c2f32fcc
> --- /dev/null
> +++ b/cmd/dma.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Brian Sune <briansune@gmail.com>
> + */
> +
> +#include <vsprintf.h>
> +#include <command.h>
> +#include <asm/io.h>
> +
> +#ifdef CONFIG_TARGET_SOCFPGA_GEN5
> +#include <asm/arch/base_addr_ac5.h>
> +#endif

If this can't be done generally for ARM then we shouldn't guard the
include, it needs to be part of the Kconfig dependencies.

> +#define RSTMGR_PERMODRST 0x18   /* PERMODRST register offset */
> +
> +static int do_dmareset(struct cmd_tbl *cmdtp, int flag, int argc,
> +	char * const argv[])

Incorrect spacing, please use checkpatch.pl to find and correct issues
like this. Thanks.

--=20
Tom

--jmkDcrizS97lRGRl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMSD+AAKCRAr4qD1Cr/k
CjIQAQC/RciqKwi93QdNQfZIpUYR2bKWEfMVJcvm0gJPq2IIyAEA7+9Tlim+E3K6
yntBq2wh2iion0/LgrLNarnY69M74Ac=
=vfVh
-----END PGP SIGNATURE-----

--jmkDcrizS97lRGRl--
