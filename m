Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3549D3E19A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 02:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F421D88D5B;
	Sat, 19 Oct 2024 04:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CIJlVdct";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D071888E0F; Sat, 19 Oct 2024 04:00:51 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 951E088BEF
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 04:00:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-460ace055d8so9937891cf.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 19:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729303248; x=1729908048; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb8nNFVFGQrMT4ncjDR/DH0aH4IKzGDpY1UFXbSHWCo=;
 b=CIJlVdcta1iwTpY9wr5wYNgp8XOgG4iS7CRX6c7lCoIWu4uCIvU2Uo/4ty066aX+AO
 fnb5L0zRiEA4YZ07GshTMU3z9Bh37c/UFNOxBQbbEEgRc1VPfFbWyILs5eco1grWqMZb
 MXFqJsp45YE6F4anhCCbHyidPyBvkz7Pu4QA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729303248; x=1729908048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nb8nNFVFGQrMT4ncjDR/DH0aH4IKzGDpY1UFXbSHWCo=;
 b=a2Yx38E8NP6iowZDZ2xQQ1+88ZdWbrEe7lKW5N8uGG3son9aFoDDzrkIY8JTODDVkJ
 mOSjwYyW1teo6RPiVuJTpVOFMrDJUT6b0iukxi7gC5deQcSHW07LpDxGNiNqAWST9NN4
 TNdkVqIwExhvA2U0qlbF5kKhBQRP5XZUUUH7hcIq3BirRmgGyP5JLMg7DPhZxkz2+UAN
 Na4Z0h5t8PuyCmqjPkaPiTr5+HCRifNihNJwa5zwIDYbzcSp0c+fV2UVVTi+L50I9wua
 SCKpc47ooHgwcex2iDRY8jD8sS9PSNt8lSyHN66Km6CP8RclVYPZjd/20Nl8O1chDTXl
 iy6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCULqDSC+oXFYei5k+2qr/MKbeRFO6Xkmq5ojjjNN1zImCrhJ/NMIsp990qAdkcJ6pG7+G5GYy4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6kDj0SWGeXsY4pociOlr5FiV8e2i5ikkY6rqHIQZJnZNXR4tE
 FYoFZAY2e+h/cVZ6yjef53OjOZfECvDtHxpX49pi+nJtLZX5PPf4NH69zWzJiTliWF3uomaQo7h
 eGpbDjf/OZVeufRK2nPiP/T3W4jij8odR+hkE
X-Google-Smtp-Source: AGHT+IGkG2HVKbxLakJ4NzPI0QrQa72Hx/GfDH5pYmC7gD4ZhF735xjeOdO1xiigWFpCK1b1Snzy+sxSJ76NL67G/ag=
X-Received: by 2002:a05:6214:318b:b0:6cc:654:a1cc with SMTP id
 6a1803df08f44-6cde15fe478mr52121166d6.47.1729303247538; Fri, 18 Oct 2024
 19:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241018163423.1562287-1-jonas@kwiboo.se>
 <20241018163423.1562287-2-jonas@kwiboo.se>
In-Reply-To: <20241018163423.1562287-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 20:00:36 -0600
Message-ID: <CAFLszTig2pF8pMhUCjjcfcJ6K4KQK2oWahsO7L5Bn9cwq2LEPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rockchip: rk356x: Implement checkboard() to print SoC
 variant
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Tom Rini <trini@konsulko.com>, Dragan Simic <dsimic@manjaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Jonas,

On Fri, 18 Oct 2024 at 10:34, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Implement checkboard() to print current SoC model, e.g. one of:
>
>   SoC:   RK3566 v1
>   SoC:   RK3566 v2
>   SoC:   RK3566T v2
>   SoC:   RK3568 v2
>   SoC:   RK3568B2 v2
>   SoC:   RK3568J v2
>
> when U-Boot proper is started.
>
> Information about what SoC model, variant and version is read from OTP.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  arch/arm/dts/rk356x-u-boot.dtsi        |  4 ++
>  arch/arm/mach-rockchip/rk3568/rk3568.c | 65 ++++++++++++++++++++++++++
>  configs/generic-rk3568_defconfig       |  2 +-
>  3 files changed, 70 insertions(+), 1 deletion(-)
>

Instead of this, can you use add a CPU driver? Then it should happen
automatically - see print_cpuinfo().

> diff --git a/arch/arm/dts/rk356x-u-boot.dtsi b/arch/arm/dts/rk356x-u-boot.dtsi
> index 0a0943b462a9..24a976cf7e21 100644
> --- a/arch/arm/dts/rk356x-u-boot.dtsi
> +++ b/arch/arm/dts/rk356x-u-boot.dtsi
> @@ -87,6 +87,10 @@
>         bootph-all;
>  };
>
> +&otp {
> +       bootph-some-ram;
> +};
> +
>  &pcfg_pull_none {
>         bootph-all;
>  };
> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
> index 768a37393290..fc4c140ab970 100644
> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
> @@ -4,6 +4,7 @@
>   */
>
>  #include <dm.h>
> +#include <misc.h>
>  #include <asm/armv8/mmu.h>
>  #include <asm/arch-rockchip/bootrom.h>
>  #include <asm/arch-rockchip/grf_rk3568.h>
> @@ -133,3 +134,67 @@ int arch_cpu_init(void)
>  #endif
>         return 0;
>  }
> +
> +#define RK3568_OTP_CPU_CODE_OFFSET             0x02
> +#define RK3568_OTP_SPECIFICATION_OFFSET                0x07
> +#define RK3568_OTP_CPU_VERSION_OFFSET          0x08
> +#define RK3568_OTP_PERFORMANCE_OFFSET          0x22
> +
> +int checkboard(void)
> +{
> +       u8 cpu_code[2], specification, package, cpu_version, performance;
> +       struct udevice *dev;
> +       char suffix[3];
> +       int ret;
> +
> +       ret = uclass_get_device_by_driver(UCLASS_MISC,
> +                                         DM_DRIVER_GET(rockchip_otp), &dev);
> +       if (ret) {
> +               debug("%s: could not find otp device, ret=%d\n", __func__, ret);
> +               return 0;
> +       }
> +
> +       /* cpu-code: SoC model, 0x35 0x66 or 0x35 0x68 */
> +       ret = misc_read(dev, RK3568_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +       if (ret < 0) {
> +               debug("%s: could not read cpu-code, ret=%d\n", __func__, ret);
> +               return 0;
> +       }
> +
> +       /* specification: SoC variant, 0x2 for RK3568B2 and 0xA for RK3568J */
> +       ret = misc_read(dev, RK3568_OTP_SPECIFICATION_OFFSET, &specification, 1);
> +       if (ret < 0) {
> +               debug("%s: could not read specification, ret=%d\n", __func__, ret);
> +               return 0;
> +       }
> +       /* package: likely SoC variant revision, 0x2 for RK3568B2 */
> +       package = specification >> 5;
> +       specification &= 0x1f;
> +
> +       /* cpu-version: chip version, e.g. second letter of lot number */
> +       ret = misc_read(dev, RK3568_OTP_CPU_VERSION_OFFSET, &cpu_version, 1);
> +       if (ret < 0) {
> +               debug("%s: could not read cpu-version, ret=%d\n", __func__, ret);
> +               return 0;
> +       }
> +       cpu_version >>= 3;
> +       cpu_version &= 0x7;
> +
> +       /* performance: used to identify RK3566T SoC variant */
> +       ret = misc_read(dev, RK3568_OTP_PERFORMANCE_OFFSET, &performance, 1);
> +       if (ret < 0) {
> +               debug("%s: could not read performance, ret=%d\n", __func__, ret);
> +               return 0;
> +       }
> +       if (performance & 0x0f)
> +               specification = 0x14; /* T-variant */
> +
> +       suffix[0] = specification > 1 ? '@' + specification : 0;
> +       suffix[1] = package > 1 ? '0' + package : 0;
> +       suffix[2] = 0;
> +
> +       printf("SoC:   RK%02x%02x%s v%u\n",
> +              cpu_code[0], cpu_code[1], suffix, cpu_version);
> +
> +       return 0;
> +}
> diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
> index 1d06f3411fe0..f79f0e84400b 100644
> --- a/configs/generic-rk3568_defconfig
> +++ b/configs/generic-rk3568_defconfig
> @@ -22,7 +22,6 @@ CONFIG_SPL_LOAD_FIT=y
>  CONFIG_LEGACY_IMAGE_FORMAT=y
>  CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
>  # CONFIG_DISPLAY_CPUINFO is not set
> -CONFIG_DISPLAY_BOARDINFO_LATE=y
>  CONFIG_SPL_MAX_SIZE=0x40000
>  CONFIG_SPL_PAD_TO=0x7f8000
>  # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> @@ -31,6 +30,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>  CONFIG_SPL_ATF=y
>  CONFIG_CMD_GPIO=y
>  CONFIG_CMD_GPT=y
> +CONFIG_CMD_MISC=y
>  CONFIG_CMD_MMC=y
>  CONFIG_CMD_ROCKUSB=y
>  CONFIG_CMD_USB_MASS_STORAGE=y
> --
> 2.46.2
>

Regards,
Simon
