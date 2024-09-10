Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3799EDE99A
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 15:18:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18D589037;
	Tue, 10 Sep 2024 17:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="YjUSSqoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE0C8903D; Tue, 10 Sep 2024 17:17:58 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD6D88CAF
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 17:17:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-53659867cbdso7247104e87.3
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725981476; x=1726586276;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wNf+g+o5S75zqMqKsfII6HuxOWT4/LHlFnajPuMSXrs=;
 b=YjUSSqoFxy4RDKGbOAqY0uyx00KTD5JdI6F4S1Ortn27XgXVEbb2Pgo+x9ZQWR+myl
 x8oO2oD55HiV+cYOFf3adErHZ/EYaJQEJ8cSiGv16ZYMGtt8kP0+9R4bIY/J7vD3F90U
 VfMaRQG6ahQ3RLKrR5zfcdmMQKCkQVjcM43+Mk9RRxERuv+v4ayGpatcTz8RjlN/T3So
 3TzS92G98TLt5+fQ9SfC2Sm6I9G4clRd9yLn2hfs1qLu19z5HzzhVbumqYM3Px/WiWp/
 +AxfxhezqpwpZ7KYIey39i5rKdOofexl59XYkyEREmhrmb9Y81h+kn7EPMFLVl1YjC+d
 y9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725981476; x=1726586276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wNf+g+o5S75zqMqKsfII6HuxOWT4/LHlFnajPuMSXrs=;
 b=WUgZrMWQ5gNxiozhwIS/nKRn2WTdR4tJf+SOkkA7F6KuuXUMYlBubF/ycSjJTGcF0M
 p1nMfTXNbp9pA/vmFFN+aMloLGdf2V922TDCDDgCfu6ihqWsTAyKytNH2iU7wHHwH1rH
 QDTeRVQrjF6MzC7NbS5u0EqD3pgyALwz5uJqFWyu321kPDZ6TnQS0i6/GVJ4FafDnfv0
 5U8YcViz8dGCH4wtuPBvZfnwtUFg6hcS9QGDv5NeFWBSBzlZ4f5jlGAXH2uVq2Qlb9yD
 9pmywsqPjcDZwRArxCVNf71kcR4zG1AMd9UN9tKM8sGmxgibTivG2P5Rm24K1H80cTxo
 RJ2w==
X-Gm-Message-State: AOJu0YxLKS/nZV9SjsBfgUwHTrFe/3VG/QEKTmfp7wxV+ymlG64xK+IP
 sNVuJ61W+1KoYfZkG1N24S8goWJ1HHjAtUeQGVox0PMy3bINTxpYMaadwGMBa9S8G1QswhoS53r
 yRnFWY6LCLuP9cJLpZuef9o9ym11N9phDsbjv7g==
X-Google-Smtp-Source: AGHT+IEvn3BEhGDXVOXErvnTeb8CR395YnA/9yjN0zgxDsKvlGsJR+mJBfSiwMyvvACAW966twV8VtnuCnL1qvfUhp0=
X-Received: by 2002:a05:6512:1283:b0:533:407f:5cbd with SMTP id
 2adb3069b0e04-536587a687amr14504466e87.7.1725981475347; Tue, 10 Sep 2024
 08:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
 <20240903163858.1155218-4-lukasz.czechowski@thaumatec.com>
 <b67d7193-7cda-461b-92fe-e07faa55017e@rock-chips.com>
In-Reply-To: <b67d7193-7cda-461b-92fe-e07faa55017e@rock-chips.com>
From: =?UTF-8?Q?=C5=81ukasz_Czechowski?= <lukasz.czechowski@thaumatec.com>
Date: Tue, 10 Sep 2024 17:17:44 +0200
Message-ID: <CABd623sqBjcVyK8Ht2q30Rjvv=DXR-nOwB9dadg0VZSG4SZp5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG
 config for TPL/SPL
To: Kever Yang <kever.yang@rock-chips.com>, quentin.schulz@cherry.de
Cc: u-boot@lists.denx.de, trini@konsulko.com, sjg@chromium.org, 
 philipp.tomsich@vrull.eu
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

Hi Kever,
Thanks for the review.
This patch is indeed intended to disallow enabling RAM_ROCKCHIP_DEBUG
when SILENT_CONSOLE is enabled and control what is printed on the
debug console more independently. Patch was created in response to
review of patchset v1, and implements change suggested by Quentin
Schulz <quentin.schulz@cherry.de>. The additional complexity with new
TPL/SPL symbols had been added because we couldn't simply add i.e.
`depends on !TPL_SILENT_CONSOLE if TPL` and  `depends on
!SPL_SILENT_CONSOLE if SPL`.
@Quentin, is it fine with you that we can drop this change?

Best regards,
Lukasz


wt., 10 wrz 2024 o 11:51 Kever Yang <kever.yang@rock-chips.com> napisa=C5=
=82(a):
>
> Hi Lukasz,
>
> On 2024/9/4 00:38, Lukasz Czechowski wrote:
>
> Introduce new config symbols TPL_RAM_ROCKCHIP_DEBUG and
> SPL_RAM_ROCKCHIP_DEBUG to allow for better dependencies control
> of RAM driver debugging configuration.
>
> The RAM_ROCKCHIP_DEBUG should enough because this only happen when ram dr=
iver
>
> running the initialization, and this init process always only run only on=
ce for all SoCs.
>
> RAM_ROCKCHIP_DEBUG depends on DEBUG_UART is the correct and no need to ad=
d more
>
> other dependency.
>
> Add negative dependencies to TPL_SILENT_CONSOLE and
> SPL_SILENT_CONSOLE, respectively.
>
> I believe this is he main target, you want to control the UART output by =
SILENT_CONTROL,
>
> but the RAM_DEBUG should follow the DEBUG_UART.
>
> So I think this patch is no need, please drop it.
>
>
> Thanks,
> - Kever
>
> Replace IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG) directives with
> CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG) to utilize the configuration
> changes.
>
> Update defconfigs of affected boards so that behavior
> is not changed.
>
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>  configs/anbernic-rgxx3-rk3566_defconfig   |  1 +
>  configs/neu2-io-rv1126_defconfig          |  2 ++
>  configs/roc-pc-mezzanine-rk3399_defconfig |  2 ++
>  configs/roc-pc-rk3399_defconfig           |  2 ++
>  configs/rock-pi-n10-rk3399pro_defconfig   |  2 ++
>  configs/sonoff-ihost-rv1126_defconfig     |  2 ++
>  drivers/ram/rockchip/Kconfig              | 24 +++++++++++++++++++++++
>  drivers/ram/rockchip/sdram_common.c       |  2 +-
>  drivers/ram/rockchip/sdram_rk3399.c       |  4 ++--
>  drivers/ram/rockchip/sdram_rv1126.c       | 10 +++++-----
>  10 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/configs/anbernic-rgxx3-rk3566_defconfig b/configs/anbernic-r=
gxx3-rk3566_defconfig
> index a03509bf467..4392bb5af00 100644
> --- a/configs/anbernic-rgxx3-rk3566_defconfig
> +++ b/configs/anbernic-rgxx3-rk3566_defconfig
> @@ -68,6 +68,7 @@ CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  CONFIG_SPL_RAM=3Dy
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
>  # CONFIG_RNG_SMCCC_TRNG is not set
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
> diff --git a/configs/neu2-io-rv1126_defconfig b/configs/neu2-io-rv1126_de=
fconfig
> index 2a4c9b45a04..1bdf99887b3 100644
> --- a/configs/neu2-io-rv1126_defconfig
> +++ b/configs/neu2-io-rv1126_defconfig
> @@ -46,6 +46,8 @@ CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_REGULATOR_PWM=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYSRESET=3Dy
> diff --git a/configs/roc-pc-mezzanine-rk3399_defconfig b/configs/roc-pc-m=
ezzanine-rk3399_defconfig
> index a57899bfdfa..45c4975e452 100644
> --- a/configs/roc-pc-mezzanine-rk3399_defconfig
> +++ b/configs/roc-pc-mezzanine-rk3399_defconfig
> @@ -66,6 +66,8 @@ CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
>  CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
> diff --git a/configs/roc-pc-rk3399_defconfig b/configs/roc-pc-rk3399_defc=
onfig
> index b45f0e0a899..3f2d5650249 100644
> --- a/configs/roc-pc-rk3399_defconfig
> +++ b/configs/roc-pc-rk3399_defconfig
> @@ -63,6 +63,8 @@ CONFIG_SPL_DM_REGULATOR_FIXED=3Dy
>  CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_RAM_ROCKCHIP_LPDDR4=3Dy
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
> diff --git a/configs/rock-pi-n10-rk3399pro_defconfig b/configs/rock-pi-n1=
0-rk3399pro_defconfig
> index ec995a54a0e..d4ba628e428 100644
> --- a/configs/rock-pi-n10-rk3399pro_defconfig
> +++ b/configs/rock-pi-n10-rk3399pro_defconfig
> @@ -52,6 +52,8 @@ CONFIG_PMIC_RK8XX=3Dy
>  CONFIG_REGULATOR_RK8XX=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYS_NS16550_MEM32=3Dy
> diff --git a/configs/sonoff-ihost-rv1126_defconfig b/configs/sonoff-ihost=
-rv1126_defconfig
> index 4890644c7e6..1b10cded8fd 100644
> --- a/configs/sonoff-ihost-rv1126_defconfig
> +++ b/configs/sonoff-ihost-rv1126_defconfig
> @@ -47,6 +47,8 @@ CONFIG_MMC_DW_ROCKCHIP=3Dy
>  CONFIG_REGULATOR_PWM=3Dy
>  CONFIG_PWM_ROCKCHIP=3Dy
>  # CONFIG_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_SPL_RAM_ROCKCHIP_DEBUG is not set
> +# CONFIG_TPL_RAM_ROCKCHIP_DEBUG is not set
>  CONFIG_BAUDRATE=3D1500000
>  CONFIG_DEBUG_UART_SHIFT=3D2
>  CONFIG_SYSRESET=3Dy
> diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
> index d707d09c1c8..5e069dca3be 100644
> --- a/drivers/ram/rockchip/Kconfig
> +++ b/drivers/ram/rockchip/Kconfig
> @@ -24,6 +24,30 @@ config RAM_ROCKCHIP_DEBUG
>    This is an option for developers to understand the ram drivers
>    initialization, configurations and etc.
>
> +config SPL_RAM_ROCKCHIP_DEBUG
> + bool "Rockchip ram drivers debugging in SPL"
> + depends on DEBUG_UART
> + depends on SPL && SPL_RAM && !SPL_SILENT_CONSOLE
> + default y
> + help
> +  This enables debugging ram driver API's for the platforms
> +  based on Rockchip SoCs.
> +
> +  This is an option for developers to understand the ram drivers
> +  initialization, configurations and etc.
> +
> +config TPL_RAM_ROCKCHIP_DEBUG
> + bool "Rockchip ram drivers debugging in TPL"
> + depends on DEBUG_UART
> + depends on TPL && TPL_RAM && !TPL_SILENT_CONSOLE
> + default y
> + help
> +  This enables debugging ram driver API's for the platforms
> +  based on Rockchip SoCs.
> +
> +  This is an option for developers to understand the ram drivers
> +  initialization, configurations and etc.
> +
>  config RAM_ROCKCHIP_DDR4
>   bool "DDR4 support for Rockchip SoCs"
>   help
> diff --git a/drivers/ram/rockchip/sdram_common.c b/drivers/ram/rockchip/s=
dram_common.c
> index b7a8fce607c..c2a6310388c 100644
> --- a/drivers/ram/rockchip/sdram_common.c
> +++ b/drivers/ram/rockchip/sdram_common.c
> @@ -10,7 +10,7 @@
>  #include <asm/arch-rockchip/sdram.h>
>  #include <asm/arch-rockchip/sdram_common.h>
>
> -#ifdef CONFIG_RAM_ROCKCHIP_DEBUG
> +#if CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)
>  void sdram_print_dram_type(unsigned char dramtype)
>  {
>   switch (dramtype) {
> diff --git a/drivers/ram/rockchip/sdram_rk3399.c b/drivers/ram/rockchip/s=
dram_rk3399.c
> index 45270e27184..99a1cc6c174 100644
> --- a/drivers/ram/rockchip/sdram_rk3399.c
> +++ b/drivers/ram/rockchip/sdram_rk3399.c
> @@ -2558,7 +2558,7 @@ static int lpddr4_set_rate(struct dram_info *dram,
>   lpddr4_set_ctl(dram, params, ctl_fn,
>         dfs_cfgs_lpddr4[ctl_fn].base.ddr_freq);
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG))
>   printf("%s: change freq to %dMHz %d, %d\n", __func__,
>         dfs_cfgs_lpddr4[ctl_fn].base.ddr_freq / MHz,
>         ctl_fn, phy_fn);
> @@ -2980,7 +2980,7 @@ static int sdram_init(struct dram_info *dram,
>   continue;
>   }
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   printf("Channel ");
>   printf(channel ? "1: " : "0: ");
>   }
> diff --git a/drivers/ram/rockchip/sdram_rv1126.c b/drivers/ram/rockchip/s=
dram_rv1126.c
> index 4fbb088a8d9..14e1df71ae4 100644
> --- a/drivers/ram/rockchip/sdram_rv1126.c
> +++ b/drivers/ram/rockchip/sdram_rv1126.c
> @@ -3375,7 +3375,7 @@ static void ddr_set_rate_for_fsp(struct dram_info *=
dram,
>   if (get_wrlvl_val(dram, sdram_params))
>   printascii("get wrlvl value fail\n");
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   printascii("change to: ");
>   printdec(f1);
>   printascii("MHz\n");
> @@ -3383,21 +3383,21 @@ static void ddr_set_rate_for_fsp(struct dram_info=
 *dram,
>   ddr_set_rate(&dram_info, sdram_params, f1,
>       sdram_params->base.ddr_freq, 1, 1, 1);
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   printascii("change to: ");
>   printdec(f2);
>   printascii("MHz\n");
>   }
>   ddr_set_rate(&dram_info, sdram_params, f2, f1, 2, 0, 1);
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   printascii("change to: ");
>   printdec(f3);
>   printascii("MHz\n");
>   }
>   ddr_set_rate(&dram_info, sdram_params, f3, f2, 3, 1, 1);
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG)) {
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG)) {
>   printascii("change to: ");
>   printdec(f0);
>   printascii("MHz(final freq)\n");
> @@ -3493,7 +3493,7 @@ static int rv1126_dmc_init(struct udevice *dev)
>   save_rw_trn_result_to_ddr(&rw_trn_result);
>  #endif
>
> - if (IS_ENABLED(CONFIG_RAM_ROCKCHIP_DEBUG))
> + if (CONFIG_IS_ENABLED(RAM_ROCKCHIP_DEBUG))
>   printascii("out\n");
>
>   return ret;
