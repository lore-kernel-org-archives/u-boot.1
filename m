Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01002C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 03:00:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD676870D2;
	Tue,  5 Dec 2023 04:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="cQ6NojpF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C38A6870A0; Tue,  5 Dec 2023 04:00:41 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F7A5870DE
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 04:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dimorinny@google.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b51e26a7aso19395e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 19:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701745235; x=1702350035; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yL8Sjflz26gYuFQ5n9zBYajO6Gk9Zra0B3VCSsLmxC8=;
 b=cQ6NojpF5J3uUaAfCd/aCI+0V3Qb7j66fh3OdS95GtN7AdH6yS1pcLx36o37biayrc
 it8pwHNUBRrPid6axasYuH0wIiOJv0+N08+2YEKxcXIFB7qS3o4MBwdsRcjB+Akhd3Q+
 +BDph6oplyP5G8lSMsdjMdDprZXm32U7vsUCBT/bO3fQN3ViLoMjkN/DzATraADS0KYx
 zjPVQEYxyOe6esQ0Sr3tyYRXKpREw7d473EvPTrL1qTQjOoAaWcoAyIuBak38CvyECVK
 uYL9MqoT0RQzoXpCY7JIFlLd5o2ucvdt/XERin9QCFTt1FVikSLrZNM3ErMu6bsx/YGf
 ZJ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701745235; x=1702350035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yL8Sjflz26gYuFQ5n9zBYajO6Gk9Zra0B3VCSsLmxC8=;
 b=dwg+EzBnfF+Szi/mdT8ek16foypXCwhqJ0GU/PgRCFIN5Dxj40IREVuckBOlCdc1Lj
 yYSOcv+X7wnGuamjMzYM4wqAWG9s1277ERRJfauA3/56NJS43L8Uhl+M3Ye7yK6iN0b5
 /MIt9NJPwtWxHrpN38xGveYxS2Fv/jydFu1BivhTsHd1/VFPb+/Oif0kgIA9gV3Dwi7G
 wcZdFMkEUxJcVTJO95iQGVmTDNoPfAz3GKGDIHoWGTInC8siVO7MvfHCrl47I1BhQBUf
 dQOiUC3TwZNe2BF10ke0ZuSu/7eZxFroT3qVtxV47eGF68OgfYnQ4PCQkKADIf7lbJt+
 dWXQ==
X-Gm-Message-State: AOJu0Ywsv8oWez4FahqWHy6SPbgMJlOtFdhW4XpSpVZAIMhE9f6I+7h9
 Wzvpk/smT1qOGdBLA5fZSFwdHvG1zgRnbLpK4QNtJw==
X-Google-Smtp-Source: AGHT+IF/PpoG8hlYLQ6bYo81ivP2fdEWHnhA9ZcitmVvuh2VVQcaGYyFcL+RjZfd4h0zI88CAeHzXeOwiHdkddzUndM=
X-Received: by 2002:a05:600c:6014:b0:40b:33aa:a2b9 with SMTP id
 az20-20020a05600c601400b0040b33aaa2b9mr516934wmb.4.1701745234768; Mon, 04 Dec
 2023 19:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20231204003144.899097-1-sjg@chromium.org>
 <20231204003144.899097-6-sjg@chromium.org>
In-Reply-To: <20231204003144.899097-6-sjg@chromium.org>
From: Dmitrii Merkurev <dimorinny@google.com>
Date: Tue, 5 Dec 2023 03:00:23 +0000
Message-ID: <CAOWkq4kr4xo-swYej0LyCsrsPEQDu2=QEdtpCtzsdwVr3WHeEA@mail.gmail.com>
Subject: Re: [PATCH 06/14] fastboot: Change fastboot_buf_addr to an address
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heiko Schocher <hs@denx.de>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Verified this change with AOSP u-boot fastboot flashing tests and it works
as expected.

Reviewed-by: Dmitrii Merkurev <dimorinny@google.com>

On Mon, Dec 4, 2023 at 12:32=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:

> Given the name of this variable, it should be an address, not a
> pointer. Update this, to make it easier to use with sandbox.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
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
>                 return CMD_RET_USAGE;
>         }
>
> -       fastboot_init((void *)buf_addr, buf_size);
> +       fastboot_init(buf_addr, buf_size);
>
>         if (!strcmp(argv[1], "udp"))
>                 return do_fastboot_udp(argc, argv, buf_addr, buf_size);
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.=
c
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
> @@ -252,7 +253,7 @@ void fastboot_data_download(const void *fastboot_data=
,
>                 return;
>         }
>         /* Download data to fastboot_buf_addr */
> -       memcpy(fastboot_buf_addr + fastboot_bytes_received,
> +       memcpy(map_sysmem(fastboot_buf_addr, 0) + fastboot_bytes_received=
,
>                fastboot_data, fastboot_data_len);
>
>         pre_dot_num =3D fastboot_bytes_received / BYTES_PER_DOT;
> @@ -296,13 +297,15 @@ void fastboot_data_complete(char *response)
>   */
>  static void __maybe_unused flash(char *cmd_parameter, char *response)
>  {
> +       void *buf =3D map_sysmem(fastboot_buf_addr, 0);
> +
>         if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
> -               fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr=
,
> -                                        image_size, response);
> +               fastboot_mmc_flash_write(cmd_parameter, buf, image_size,
> +                                        response);
>
>         if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
> -               fastboot_nand_flash_write(cmd_parameter, fastboot_buf_add=
r,
> -                                         image_size, response);
> +               fastboot_nand_flash_write(cmd_parameter, buf, image_size,
> +                                         response);
>  }
>
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
>
>  /**
>   * fastboot_buf_size - size of the fastboot download buffer
> @@ -154,7 +154,7 @@ void fastboot_boot(void)
>                 };
>
>                 snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
> -                        "0x%p", fastboot_buf_addr);
> +                        "%lx", fastboot_buf_addr);
>                 printf("Booting kernel at %s...\n\n\n", boot_addr_start);
>
>                 do_bootm(NULL, 0, 2, bootm_args);
> @@ -214,16 +214,9 @@ void fastboot_set_progress_callback(void
> (*progress)(const char *msg))
>         fastboot_progress_callback =3D progress;
>  }
>
> -/*
> - * fastboot_init() - initialise new fastboot protocol session
> - *
> - * @buf_addr: Pointer to download buffer, or NULL for default
> - * @buf_size: Size of download buffer, or zero for default
> - */
> -void fastboot_init(void *buf_addr, u32 buf_size)
> +void fastboot_init(ulong buf_addr, u32 buf_size)
>  {
> -       fastboot_buf_addr =3D buf_addr ? buf_addr :
> -                                      (void *)CONFIG_FASTBOOT_BUF_ADDR;
> +       fastboot_buf_addr =3D buf_addr ? buf_addr : CONFIG_FASTBOOT_BUF_A=
DDR;
>         fastboot_buf_size =3D buf_size ? buf_size : CONFIG_FASTBOOT_BUF_S=
IZE;
>         fastboot_set_progress_callback(NULL);
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
>
>  /**
>   * fastboot_buf_size - size of the fastboot download buffer
> diff --git a/include/fastboot.h b/include/fastboot.h
> index 296451f89d44..744ab61cc18a 100644
> --- a/include/fastboot.h
> +++ b/include/fastboot.h
> @@ -103,13 +103,13 @@ int fastboot_set_reboot_flag(enum
> fastboot_reboot_reason reason);
>   */
>  void fastboot_set_progress_callback(void (*progress)(const char *msg));
>
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
>
>  /**
>   * fastboot_boot() - Execute fastboot boot command
> --
> 2.43.0.rc2.451.g8631bc7472-goog
>
>
