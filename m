Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFA5C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 12:06:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3830A87B7F;
	Fri, 15 Dec 2023 13:06:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nraZcU2n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99B7187B8B; Fri, 15 Dec 2023 13:06:50 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA2287952
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 13:06:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c19f5f822so2937795e9.1
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 04:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1702642004; x=1703246804;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6+AusPHn60096ExCwjqXoIH0+SjonAzFUWdTRu8crqI=;
 b=nraZcU2n24tVCZgyNFZejIKKDwTmJ86d9vZaSBaN3Yld11egnoiI3nA6L/gO/Gm48L
 08cEHHChjUJAarbSVarRQoLFCG6G/9E3AaDEB2/9ywzcL9OAWeWK9uB/lUlUzEHizeuh
 uV381kEMuz8iP/Fa5UTFL1ojLHk82m1tdQe54fgtfx5iPmLTgAHSI41arp5cilWn/bz2
 rOSKPpGBiJALVkul8Gs9ltOJYC+oUDqdaABCLHyuCmfAEX5byDgOl24XDAuA4FbYjZ+Q
 fMHKAacDSKowuu4LXEcFj6/QVgIQayDxDAw5KPmyZy+YKEYwhPFr5Qr76cT4YBv4roz5
 eTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702642004; x=1703246804;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6+AusPHn60096ExCwjqXoIH0+SjonAzFUWdTRu8crqI=;
 b=VY4iL4WoQBZQKuRJQ1mq+zhdLexbaGEVDnYlQ9WzbqYFGwp9b5PIx3Tat9stiq7oP6
 1m5A6JNczms2YQ/Cjdk9vtIr6gFmcOb+ArATVfr/2iO0QOHlPM4sBUpe9Js4xx6522l2
 +bhThbzc2bFXSyLEImlCF/giP+0TmO08k+OrUNW4zbMI7XYXl8So5PBJsT5VzYe+atWg
 A9MageNgOtqEKewu3h+Mkp+FE/fuYVEsa2fIyESWdRjZ+p30F43sSUn5T3fRj1Z9DsW5
 qc1UUUCOC2d2tmsyndB1aGUvTwrg6EgU5LAXRmRleik0ubKHd29LjykenzUgPjxbPj9r
 GYPA==
X-Gm-Message-State: AOJu0YyTWryufdewjirO5StokdfnwIRxjOmxsEQ8AS/9hIzMchZN8XIf
 bry/xpOjlh2qv0nFCXXxybJtvncfmXFwtkfQ6X4=
X-Google-Smtp-Source: AGHT+IGKb8sKpKbuRV42QjP0yiYSTNDgHJcNQcHzGHm0h3Y153dbdniA4rE9dyXiHnXicRiUUscwzA==
X-Received: by 2002:a05:600c:5117:b0:40c:6939:b470 with SMTP id
 o23-20020a05600c511700b0040c6939b470mr658418wms.53.1702642004505; 
 Fri, 15 Dec 2023 04:06:44 -0800 (PST)
Received: from localhost ([89.207.171.106]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d5452000000b00336367631efsm7727374wrv.65.2023.12.15.04.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 04:06:44 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alex
 Kiernan <alex.kiernan@gmail.com>
Subject: Re: [PATCH v2 08/16] fastboot: Remove dependencies on CMDLINE
In-Reply-To: <20231215041919.2197788-8-sjg@chromium.org>
References: <20231215041919.2197788-1-sjg@chromium.org>
 <20231215041919.2197788-8-sjg@chromium.org>
Date: Fri, 15 Dec 2023 13:06:40 +0100
Message-ID: <87fs03u0tr.fsf@baylibre.com>
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

Thank you for the patch.

On jeu., d=C3=A9c. 14, 2023 at 21:19, Simon Glass <sjg@chromium.org> wrote:

> It is possible to boot a kernel without CMDLINE being enabled. Update
> the implementation to handle this, and drop the condition from the
> FASTBOOT config.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>
> Changes in v2:
> - Avoid changing the logic when a command is not set
>
>  drivers/fastboot/Kconfig     |  1 -
>  drivers/fastboot/fb_common.c | 30 ++++++++++++++----------------
>  2 files changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 11fc0fe1c800..837c6f1180da 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -1,5 +1,4 @@
>  menu "Fastboot support"
> -	depends on CMDLINE
>=20=20
>  config FASTBOOT
>  	bool
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 07f5946d9ed1..595954542a6e 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -11,6 +11,7 @@
>   */
>=20=20
>  #include <bcb.h>
> +#include <bootm.h>
>  #include <common.h>
>  #include <command.h>
>  #include <env.h>
> @@ -142,22 +143,19 @@ void (*fastboot_get_progress_callback(void))(const =
char *)
>   */
>  void fastboot_boot(void)
>  {
> -	char *s;
> -
> -	s =3D env_get("fastboot_bootcmd");
> -	if (s) {
> -		run_command(s, CMD_FLAG_ENV);
> -	} else if (IS_ENABLED(CONFIG_CMD_BOOTM)) {
> -		static char boot_addr_start[20];
> -		static char *const bootm_args[] =3D {
> -			"bootm", boot_addr_start, NULL
> -		};
> -
> -		snprintf(boot_addr_start, sizeof(boot_addr_start) - 1,
> -			 "%lx", fastboot_buf_addr);
> -		printf("Booting kernel at %s...\n\n\n", boot_addr_start);
> -
> -		do_bootm(NULL, 0, 2, bootm_args);
> +	char *s =3D NULL;
> +
> +	if (IS_ENABLED(CONFIG_CMDLINE)) {
> +		s =3D env_get("fastboot_bootcmd");
> +		if (s)
> +			run_command(s, CMD_FLAG_ENV);
> +	}
> +
> +	if (!s && IS_ENABLED(CONFIG_BOOTM)) {
> +		int ret;
> +
> +		printf("Booting kernel at %lx...\n\n\n", fastboot_buf_addr);
> +		ret =3D bootm_boot_start(fastboot_buf_addr, NULL);
>=20=20
>  		/*
>  		 * This only happens if image is somehow faulty so we start
> --=20
> 2.43.0.472.g3155946c3a-goog
