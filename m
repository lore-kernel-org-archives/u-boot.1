Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF01FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 14:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F65882C4;
	Wed, 17 Apr 2024 16:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="fsxiEjid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE54882AC; Wed, 17 Apr 2024 16:57:29 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ABC7882C4
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 16:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56c5d05128dso6287468a12.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713365846; x=1713970646;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LViZ2dXigtOjCpyrPZemveI5m60QnveR0dj+zMdQSxw=;
 b=fsxiEjidiOOra2cLpxBNkaEiGiJIcAbu4YWQXqZhWQVL4x4X2KDk+/ytPQ8AwsHVMF
 V9GQYgtY2fhwlxTrTe8Dr1DXrbgy3nZ+KxLvNtb+7E1RMhMeeMkfoLOT6HWBRb5IEN3N
 ZiE1FVja1n6AcYiRlz+hDfuO1FzkKlz0MffauhiZ+BzOzFNMh8iQrDvkNn5bdc5yeCas
 3mFqTgZxp/sniNNfRz+5birW1smUAOTsRRjm6XVKj/ISYtpPtN1ZzKLXoICnLxGAPAv+
 yM1D+P1S5jSwsj29mKJOgBeZBq0l6Wn9/+2wtsGWuSDnTlfVo/+OgNvQxA/ntE671PJd
 4KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713365846; x=1713970646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LViZ2dXigtOjCpyrPZemveI5m60QnveR0dj+zMdQSxw=;
 b=HXMDdaGez0tjRvOmv+G9WpWEz8fw8VR7/3EZ8PRd/6aiRw7vwk0IIC4hz7gcyvlzrO
 qd/ioVzq05CGdZtUmdDDujP/92MqTBqP1nKlU4Y24KOHgKXCEv1dbZb49vmFqflQ/VaC
 mf+vG5wolRXo3U39US9CQy+EdX02VDaH6PWOwaRH29TQiirCipYes7jnWIXFL/9h808L
 x9BaqCNrmepXUrwsCc2IS0VdObXKVplWlkbW/xZHj5ZFUEwYI92xNWsUSD/An0CeVpA+
 FEwtX4zCGauzXcc86aA38vgf8S1pL2TOxABLc6zJ+EObej3cAy/fNG6bsEmI6m8nL2k1
 VimQ==
X-Gm-Message-State: AOJu0Yzo3+jJPQdR4e1XzhYSUzLWMv/IP7pGDLqbcj1W0rLBNWV4kk7Y
 pvYCxMsqEqgzRQHd4EU/KgtmFoLzZlukMl24d3dY/kkfsik9cboM8V/8St6SqyXXylFeTFBYd7F
 Hgh2dTtVqlIko1Mad264aMH0viKcOqYQrTOjYeVXWyy1xVst9OUNtRw==
X-Google-Smtp-Source: AGHT+IFwnTzBJUMkujDBDyfMNZ/nDXzzFyB40vqXO3z/4F32ZwbsRa6my5FGBEt+j6RhHF8pHho/oFA0qBQr8EBIkFE=
X-Received: by 2002:a17:906:b818:b0:a55:63d3:7499 with SMTP id
 dv24-20020a170906b81800b00a5563d37499mr649602ejb.59.1713365845630; Wed, 17
 Apr 2024 07:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240417111625.288202-1-lukasz.czechowski@thaumatec.com>
 <09ab0f81-46fc-47ac-8eff-d7d3e05faa94@theobroma-systems.com>
In-Reply-To: <09ab0f81-46fc-47ac-8eff-d7d3e05faa94@theobroma-systems.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Wed, 17 Apr 2024 16:57:14 +0200
Message-ID: <CABd623vG5VOZKryg501hVnat6r1P=7y4b6aVwYYOoC8kwsbJhw@mail.gmail.com>
Subject: Re: [PATCH] ram: rockchip: px30: Replace misleading log message
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, trini@konsulko.com, 
 Lukasz Czechowski <lukas.czechowski@thaumatec.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Quentin,

Maybe I was a little too fast with submitting this patch.
My original point of this commit was to get rid of the message "out",
that is printed without any context every time the board boots, or at
least replace it with something more descriptive, similarly like it is
done with other boards.
I've used the `debug` macro as it was used in the same context in e.g.
rk3399, but also already inside the sdram_px30.c file. Indeed I'll try
to revisit this topic once I'm back.

Best regards,
=C5=81ukasz


=C5=9Br., 17 kwi 2024 o 15:58 Quentin Schulz
<quentin.schulz@theobroma-systems.com> napisa=C5=82(a):
>
> Hi Lukasz,
>
> On 4/17/24 13:16, lukasz.czechowski@thaumatec.com wrote:
> > From: Lukasz Czechowski <lukas.czechowski@thaumatec.com>
> >
> > Remove the log message "out" from sdram_init function which
> > pollutes the console. It brings no meaningful information and
> > might be unwanted in case silencing the console is required.
> > Instead, add a debug log with a more meaningful message, printed
> > only if DEBUG is set. The same convention is used for other
> > boards, i.e. rk3399.
> >
> > Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> > ---
> >   drivers/ram/rockchip/sdram_px30.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/ram/rockchip/sdram_px30.c b/drivers/ram/rockchip/s=
dram_px30.c
> > index 21498e8957..3b429973cd 100644
> > --- a/drivers/ram/rockchip/sdram_px30.c
> > +++ b/drivers/ram/rockchip/sdram_px30.c
> > @@ -712,7 +712,7 @@ int sdram_init(void)
> >
> >       sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->b=
ase, 0);
> >
> > -     printascii("out\n");
> > +     debug("Finish SDRAM initialization...\n");
>
> Mmmm I don't think this is appropriate. debug() is essentially replaced
> with printf() whenever the selected log level permits. The issue is that
> printf() !=3D printascii() and I have a feeling we use printascii
> explicitly because it is a much smaller way to print data than printf.
>
> Additionally, we're extremely size constrained in TPL on PX30, so
> increasing the string size to print may also not be wise. If we are not
> enable to even build the TPL by defining DEBUG, this is basically dead
> code and it's as good to us as removing it entirely.
>
> So... questions:
> 1) does it actually build if you set #define DEBUG 1 or whatever is
> needed for having the debug message printed? If yes, does it boot?
> 2) What's the size of the TPL with this change and with this
> change+DEBUG set?
>
> What I can suggest instead is to guard all printascii (or at least the
> ones only useful for debugging) with the appropriate symbol, e.g. could
> be CONFIG_RAM_ROCKCHIP_DEBUG.
>
> I have not tested it (only build tested on Ringneck PX30 without
> CONFIG_RAM_ROCKCHIP_DEBUG nor CONFIG_TPL_SERIAL), but here's a quick
> attempt:
>
> """
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> index b7a6f100d41..17656e99a2f 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -11,7 +11,7 @@ config ROCKCHIP_PX30
>         select TPL_NEEDS_SEPARATE_STACK if TPL
>         imply SPL_SEPARATE_BSS
>         select SPL_SERIAL
> -       select TPL_SERIAL
> +       imply TPL_SERIAL
>         select DEBUG_UART_BOARD_INIT
>         imply ROCKCHIP_COMMON_BOARD
>         imply SPL_ROCKCHIP_COMMON_BOARD
> diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c
> b/arch/arm/mach-rockchip/px30-board-tpl.c
> index 637a5e1b18b..8f56147ca7a 100644
> --- a/arch/arm/mach-rockchip/px30-board-tpl.c
> +++ b/arch/arm/mach-rockchip/px30-board-tpl.c
> @@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
>   {
>         int ret;
>
> -#ifdef CONFIG_DEBUG_UART
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
>         debug_uart_init();
>         /*
>          * Debug UART can be used from here if required:
> @@ -51,8 +51,10 @@ void board_init_f(ulong dummy)
>
>         secure_timer_init();
>         ret =3D sdram_init();
> +#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
>         if (ret)
>                 printascii("sdram_init failed\n");
> +#endif
>
>         /* return to maskrom */
>         back_to_bootrom(BROM_BOOT_NEXTSTAGE);
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index 67c63ecba04..cb59bcf0414 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -16,6 +16,8 @@ if RAM_ROCKCHIP
>   config RAM_ROCKCHIP_DEBUG
>         bool "Rockchip ram drivers debugging"
>         default y
> +       depends on TPL_SERIAL if TPL_RAM
> +       depends on SPL_SERIAL if SPL_RAM
>         help
>           This enables debugging ram driver API's for the platforms
>           based on Rockchip SoCs.
> diff --git a/drivers/ram/rockchip/sdram_common.c
> b/drivers/ram/rockchip/sdram_common.c
> index 60fc90d0a5c..8076cfa9aad 100644
> --- a/drivers/ram/rockchip/sdram_common.c
> +++ b/drivers/ram/rockchip/sdram_common.c
> @@ -231,7 +231,9 @@ int sdram_detect_col(struct sdram_cap_info *cap_info,
>                         break;
>         }
>         if (col =3D=3D 8) {
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                 printascii("col error\n");
> +#endif
>                 return -1;
>         }
>
> @@ -348,7 +350,9 @@ int sdram_detect_row(struct sdram_cap_info *cap_info,
>                         break;
>         }
>         if (row =3D=3D 12) {
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                 printascii("row error");
> +#endif
>                 return -1;
>         }
>
> diff --git a/drivers/ram/rockchip/sdram_px30.c
> b/drivers/ram/rockchip/sdram_px30.c
> index 21498e89570..607d97c268e 100644
> --- a/drivers/ram/rockchip/sdram_px30.c
> +++ b/drivers/ram/rockchip/sdram_px30.c
> @@ -231,8 +231,10 @@ static unsigned int calculate_ddrconfig(struct
> px30_sdram_params *sdram_params)
>                                 ddrconf =3D i;
>                                 break;
>                         }
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                 if (i > 6)
>                         printascii("calculate ddrconfig error\n");
> +#endif
>         }
>
>         return ddrconf;
> @@ -281,8 +283,10 @@ static void set_ctl_address_map(struct dram_info *dr=
am,
>                           &addrmap[ddrconf][0], 8 * 4);
>         max_row =3D cs_pst - 1 - 8 - (addrmap[ddrconf][5] & 0xf);
>
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>         if (max_row < 12)
>                 printascii("set addrmap fail\n");
> +#endif
>         /* need to disable row ahead of rank by set to 0xf */
>         for (i =3D 17; i > max_row; i--)
>                 clrsetbits_le32(pctl_base + DDR_PCTL2_ADDRMAP6 +
> @@ -523,12 +527,16 @@ static int sdram_init_(struct dram_info *dram,
>         /* do ddr gate training */
>   redo_cs0_training:
>         if (data_training(dram, 0, sdram_params->base.dramtype) !=3D 0) {
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                 if (pre_init !=3D 0)
>                         printascii("DTT cs0 error\n");
> +#endif
>                 return -1;
>         }
>         if (check_rd_gate(dram)) {
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                 printascii("re training cs0");
> +#endif
>                 goto redo_cs0_training;
>         }
>
> @@ -543,11 +551,15 @@ redo_cs0_training:
>         if (pre_init !=3D 0 && cap_info->rank =3D=3D 2) {
>   redo_cs1_training:
>                 if (data_training(dram, 1, sdram_params->base.dramtype) !=
=3D 0) {
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                         printascii("DTT cs1 error\n");
> +#endif
>                         return -1;
>                 }
>                 if (check_rd_gate(dram)) {
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>                         printascii("re training cs1");
> +#endif
>                         goto redo_cs1_training;
>                 }
>         }
> @@ -712,7 +724,9 @@ int sdram_init(void)
>
>         sdram_print_ddr_info(&sdram_params->ch.cap_info, &sdram_params->b=
ase, 0);
>
> +#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
>         printascii("out\n");
> +#endif
>         return ret;
>   error:
>         return (-1);
> """
>
> I haven't put too much thought into it, so this is probably not the
> right way to do it, or it's reaching too much. After all, there is some
> important information that needs to be printed sometimes :) Don't know
> which ones for the DDR init though :/
>
> Cheers,
> Quentin
