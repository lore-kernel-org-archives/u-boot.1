Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD93C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 09:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 477DA87655;
	Tue,  5 Dec 2023 10:16:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SLvnS4Yb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3170C871B2; Tue,  5 Dec 2023 10:16:45 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB74D87873
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 10:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-332fd78fa9dso4325878f8f.3
 for <u-boot@lists.denx.de>; Tue, 05 Dec 2023 01:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701767802; x=1702372602;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q4tQ32aqXTMDVCEv5irkWVuBmjZ7VxLpB5/fQtxifUQ=;
 b=SLvnS4YbLBVAITRcAU/6HPSAC90nwoeD85ivqlL9l+uE//2ECIvaEmdgxUfWy9DXtT
 hDwm9stzgayMpPSItb02iwaSMmJUytCAV8UlomCrj26wS593t3r5pQkMcpLews8hZ6JS
 uf+rfOHMcqTIFr3Xw5umBvxKzDpvuYRzqEDMwtNUNhUV/gWsyqLpxwY7/Y1hLxSQUkyo
 sLVjxZILloCjTbVFcChz7Y2i4fxn5rCW5pd8M0a9DX8owfEbSEaCoknki7K/yl2XUG9M
 4c+e8ryf7nOwD64Vf8Go+TIuq4cxsgjDdlaFO9lSVb5RHXdWHFI6NE9/nTIL+uKa3tH9
 7oiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701767802; x=1702372602;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4tQ32aqXTMDVCEv5irkWVuBmjZ7VxLpB5/fQtxifUQ=;
 b=a2PhvgZQDX8J1Nbr/o4oBQ60n2w0Hx3gm679MOD/LzK0XsfcF8ELAt2SVG20D/NqXe
 xVqCz9JmKmigCwbD8oLSpSXi1ifYFSUuAcxf1hyq4A7HXavdWgXg+pNDNMytvuuHW68O
 p3+fWD8JBF9eXMY4M49+6OPlFRka72ImD2idkvyCJKtiq5bi6z1+grhEqccV/TE0Z3fv
 k+odGxb9rKOp5tCMJ24Ph2dYZeTB6saLqZ0bHKFVewRA7Jh6ytqHUeTA+RMkrWqHwzpW
 RvlosRY9hDxSN+WHjlkFxHfEEzJYmvmg/HJguICv3N52rSFSxOJLQW9dIauizItvimJ2
 57VQ==
X-Gm-Message-State: AOJu0Yz5fSExTK/uYkjzjTWxy2QD/7CGEm+EXqSubVN0T5QEm90dxsuw
 C6WKgdYgcpgFCuY5Q4Zl8KkqRQ==
X-Google-Smtp-Source: AGHT+IFF++/tACrGXaL2BpbFYIkqtnL+bmBEFud7ASf2tch+exdNYN7SQj/RletHT12KqIi+4Dd3yQ==
X-Received: by 2002:a5d:6887:0:b0:333:2a1e:8373 with SMTP id
 h7-20020a5d6887000000b003332a1e8373mr1518957wru.35.1701767801933; 
 Tue, 05 Dec 2023 01:16:41 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 e8-20020adfe388000000b00333381c6e12sm9164876wrm.40.2023.12.05.01.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 01:16:41 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Dmitrii
 Merkurev <dimorinny@google.com>, Heiko Schocher <hs@denx.de>, Marek Vasut
 <marex@denx.de>, Patrick Delaunay <patrick.delaunay@foss.st.com>, Ramon
 Fried <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>, Sean
 Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH 06/14] fastboot: Change fastboot_buf_addr to an address
In-Reply-To: <20231204003144.899097-6-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-6-sjg@chromium.org>
Date: Tue, 05 Dec 2023 10:16:40 +0100
Message-ID: <87plzlypon.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hi Simon,

Thank you for your patch.

On dim., d=C3=A9c. 03, 2023 at 17:31, Simon Glass <sjg@chromium.org> wrote:

> Given the name of this variable, it should be an address, not a
> pointer. Update this, to make it easier to use with sandbox.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Tested that I could reflash AOSP on the Khadas VIM 3 board.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com> # on vim3

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Some small nit/question below.

> ---
>
>  cmd/fastboot.c                |  2 +-
>  drivers/fastboot/fb_command.c | 13 ++++++++-----
>  drivers/fastboot/fb_common.c  | 15 ++++-----------
>  include/fastboot-internal.h   |  2 +-
>  include/fastboot.h            |  6 +++---
>  5 files changed, 17 insertions(+), 21 deletions(-)
>
> diff --git a/cmd/fastboot.c b/cmd/fastboot.c
> index c3c19231c988..792e83d372c3 100644
> --- a/cmd/fastboot.c
> +++ b/cmd/fastboot.c
> @@ -159,7 +159,7 @@ NXTARG:
>  		return CMD_RET_USAGE;
>  	}
>=20=20
> -	fastboot_init((void *)buf_addr, buf_size);
> +	fastboot_init(buf_addr, buf_size);
>=20=20
>  	if (!strcmp(argv[1], "udp"))
>  		return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 5fcadcdf503d..ec030886dbb8 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -10,6 +10,7 @@
>  #include <fastboot-internal.h>
>  #include <fb_mmc.h>
>  #include <fb_nand.h>
> +#include <mapmem.h>
>  #include <part.h>
>  #include <stdlib.h>
>  #include <linux/printk.h>
> @@ -252,7 +253,7 @@ void fastboot_data_download(const void *fastboot_data,
>  		return;
>  	}
>  	/* Download data to fastboot_buf_addr */
> -	memcpy(fastboot_buf_addr + fastboot_bytes_received,
> +	memcpy(map_sysmem(fastboot_buf_addr, 0) + fastboot_bytes_received,
>  	       fastboot_data, fastboot_data_len);

I'm a little confused on why there is no call of unmap_sysmem() here but
that seems to be the case for plenty other callers of map_sysmem().

From what I've seen, in the sandbox unmap_sysmem() is a no-oop, but what
about other architectures ?

>=20=20
>  	pre_dot_num =3D fastboot_bytes_received / BYTES_PER_DOT;
> @@ -296,13 +297,15 @@ void fastboot_data_complete(char *response)
>   */
>  static void __maybe_unused flash(char *cmd_parameter, char *response)
>  {
> +	void *buf =3D map_sysmem(fastboot_buf_addr, 0);
> +
>  	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> -		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
> -					 image_size, response);
> +		fastboot_mmc_flash_write(cmd_parameter, buf, image_size,
> +					 response);
>=20=20
>  	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
> -		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
> -					  image_size, response);
> +		fastboot_nand_flash_write(cmd_parameter, buf, image_size,
> +					  response);

Same here.

>  }
>=20=20
>  /**
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 3576b0677299..07f5946d9ed1 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -20,7 +20,7 @@
>  /**
>   * fastboot_buf_addr - base address of the fastboot download buffer
>   */
> -void *fastboot_buf_addr;
> +ulong fastboot_buf_addr;
>=20=20
>  /**
>   * fastboot_buf_size - size of the fastboot download buffer
> @@ -154,7 +154,7 @@ void fastboot_boot(void)
>  		};
>=20=20
>  		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
> -			 "0x%p", fastboot_buf_addr);
> +			 "%lx", fastboot_buf_addr);
>  		printf("Booting kernel at %s...\n\n\n", boot_addr_start);
>=20=20
>  		do_bootm(NULL, 0, 2, bootm_args);
> @@ -214,16 +214,9 @@ void fastboot_set_progress_callback(void (*progress)=
(const char *msg))
>  	fastboot_progress_callback =3D progress;
>  }
>=20=20
> -/*
> - * fastboot_init() - initialise new fastboot protocol session
> - *
> - * @buf_addr: Pointer to download buffer, or NULL for default
> - * @buf_size: Size of download buffer, or zero for default
> - */
> -void fastboot_init(void *buf_addr, u32 buf_size)
> +void fastboot_init(ulong buf_addr, u32 buf_size)
>  {
> -	fastboot_buf_addr =3D buf_addr ? buf_addr :
> -				       (void *)CONFIG_FASTBOOT_BUF_ADDR;
> +	fastboot_buf_addr =3D buf_addr ? buf_addr : CONFIG_FASTBOOT_BUF_ADDR;
>  	fastboot_buf_size =3D buf_size ? buf_size : CONFIG_FASTBOOT_BUF_SIZE;
>  	fastboot_set_progress_callback(NULL);
>  }
> diff --git a/include/fastboot-internal.h b/include/fastboot-internal.h
> index bf2f2b3c8914..d3e1c106e23f 100644
> --- a/include/fastboot-internal.h
> +++ b/include/fastboot-internal.h
> @@ -6,7 +6,7 @@
>  /**
>   * fastboot_buf_addr - base address of the fastboot download buffer
>   */
> -extern void *fastboot_buf_addr;
> +extern ulong fastboot_buf_addr;
>=20=20
>  /**
>   * fastboot_buf_size - size of the fastboot download buffer
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 296451f89d44..744ab61cc18a 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -103,13 +103,13 @@ int fastboot_set_reboot_flag(enum fastboot_reboot_r=
eason reason);
>   */
>  void fastboot_set_progress_callback(void (*progress)(const char *msg));
>=20=20
> -/*
> +/**
>   * fastboot_init() - initialise new fastboot protocol session
>   *
> - * @buf_addr: Pointer to download buffer, or NULL for default
> + * @buf_addr: Address of download buffer, or 0 for default
>   * @buf_size: Size of download buffer, or zero for default
>   */
> -void fastboot_init(void *buf_addr, u32 buf_size);
> +void fastboot_init(ulong buf_addr, u32 buf_size);
>=20=20
>  /**
>   * fastboot_boot() - Execute fastboot boot command
> --=20
> 2.43.0.rc2.451.g8631bc7472-goog
