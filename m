Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A268C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 16:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6681187214;
	Mon, 15 Jan 2024 17:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KbK5WKkO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5E1B86FC9; Mon, 15 Jan 2024 17:23:54 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9714987252
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 17:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3367f8757d0so1376684f8f.1
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 08:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705335832; x=1705940632; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvrYPCsuuL5dZ9ouOQ629EW/UL0JJXCha/HaDfZ+0b4=;
 b=KbK5WKkOTv0Ezdja7cYbS4yR7cujtMcjpiwPqLAqlE9JZJ5oRhGok1rhi4VIa5gttE
 ECWRNVuoLPKy39EuORzjLTdlXzoDz7chlnbdnmN8VDvq9yzWPK7y/ThgnqSh9sH4Wzu8
 Ss0yKc90ByzSScIKxYJkHt2VYlrBVNkBGUFpyvaX+OLktJzFNGfdHRmWvaDzTlF8puhY
 8tjxW5viYjd2nu0/qwcDAO8wyu2NbfWduoVEZPSHPcM6FzJyrkpA+VtYgF3DUkGBN8ju
 evqknRmv4fLHnXejUTGktpwVK9FgHZYumVtaQYcVuNvs1cWuAYLrbR6pRotNEUnz0DP5
 mJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705335832; x=1705940632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvrYPCsuuL5dZ9ouOQ629EW/UL0JJXCha/HaDfZ+0b4=;
 b=fXh2zVGFxwVyXGrQ8uQRMhQNsLxiXYK+XfzyhDgV2L83tQVjMeW9sgqide5BkQmR66
 LSTHQIo/YxK3+oMSg/JyH9KXkqgjELmaJKbOvm7bUP3EO1/pS7hf6Umvh4Xr3Lu64ZUc
 nmbuK33YJpmnRAMp1Cnrea+6RxQ0U8rqk8h8jIMNAKW12D37yTW7o6YPrgQc6ikFrrJN
 4u2J+K8lxiBGHT8f9JMGaA6U6111BHxW6WzdYcfDoerNJr1rrxzX8XxRFtWGLhbx5/R6
 p2HZ+9IiQP3nkLK8k73aBVMJY9m5rrj+v+QFX+Qnj6ggvTA+mmfNUVrPdwaiHMx/t4yt
 GOTw==
X-Gm-Message-State: AOJu0YyojCWvvwn3p23iWNfrs02atlycsKxLSMskSSMMjJSwzul4B9oL
 8dYn6QvgVhLeD5yAPjalmy9sCXcgcH9wikVUXAE=
X-Google-Smtp-Source: AGHT+IHmHiBywCNdNaMmhcpNpKUubzRf20caA/R8GWJoK24UmFNPU7sjXb8g5r39S4dZpmXpH9hCM59wuaXEnHs0uNc=
X-Received: by 2002:adf:fecb:0:b0:336:8103:6ce9 with SMTP id
 q11-20020adffecb000000b0033681036ce9mr6129182wrs.7.1705335831635; Mon, 15 Jan
 2024 08:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.7.I122ede30eb83184b996b7d3e1c480418b29ffbe1@changeid>
In-Reply-To: <20240115150451.v2.7.I122ede30eb83184b996b7d3e1c480418b29ffbe1@changeid>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 15 Jan 2024 17:23:39 +0100
Message-ID: <CAByghJaABf37PeVgEPWaQAtpZK4O=brECrLLAWnhWc5mrpW92g@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] stm32mp: add setup_serial_number for stm32mp25
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass <sjg@chromium.org>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
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

Hello Patrick,

On Mon, Jan 15, 2024 at 5:03=E2=80=AFPM Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@foss.st.com>
>
> Add support of serial number for stm32mp25, gets from OTP with BSEC drive=
r.
>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
> (no changes since v1)
>
>  .../arm/mach-stm32mp/include/mach/sys_proto.h |  1 +
>  arch/arm/mach-stm32mp/soc.c                   | 31 +++++++++++++++++++
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c          | 27 ----------------
>  arch/arm/mach-stm32mp/stm32mp2/cpu.c          |  2 ++
>  4 files changed, 34 insertions(+), 27 deletions(-)
>
> diff --git a/arch/arm/mach-stm32mp/include/mach/sys_proto.h b/arch/arm/ma=
ch-stm32mp/include/mach/sys_proto.h
> index 83388fdb7371..2a65efc0a50a 100644
> --- a/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-stm32mp/include/mach/sys_proto.h
> @@ -97,6 +97,7 @@ u32 get_bootauth(void);
>
>  int get_eth_nb(void);
>  int setup_mac_address(void);
> +int setup_serial_number(void);
>
>  /* board power management : configure vddcore according OPP */
>  void board_vddcore_init(u32 voltage_mv);
> diff --git a/arch/arm/mach-stm32mp/soc.c b/arch/arm/mach-stm32mp/soc.c
> index 8d5fa474ccaf..ff70ebe97464 100644
> --- a/arch/arm/mach-stm32mp/soc.c
> +++ b/arch/arm/mach-stm32mp/soc.c
> @@ -3,7 +3,11 @@
>   * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
>   */
>
> +#include <env.h>
> +#include <misc.h>
>  #include <asm/arch/sys_proto.h>
> +#include <dm/device.h>
> +#include <dm/uclass.h>
>
>  /* used when CONFIG_DISPLAY_CPUINFO is activated */
>  int print_cpuinfo(void)
> @@ -15,3 +19,30 @@ int print_cpuinfo(void)
>
>         return 0;
>  }
> +
> +int setup_serial_number(void)
> +{
> +       char serial_string[25];
> +       u32 otp[3] =3D {0, 0, 0 };
> +       struct udevice *dev;
> +       int ret;
> +
> +       if (env_get("serial#"))
> +               return 0;
> +
> +       ret =3D uclass_get_device_by_driver(UCLASS_MISC,
> +                                         DM_DRIVER_GET(stm32mp_bsec),
> +                                         &dev);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_SERIAL),
> +                       otp, sizeof(otp));
> +       if (ret < 0)
> +               return ret;
> +
> +       sprintf(serial_string, "%08X%08X%08X", otp[0], otp[1], otp[2]);
> +       env_set("serial#", serial_string);
> +
> +       return 0;
> +}
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp=
/stm32mp1/cpu.c
> index 00fea7929b2f..f84cb26fa565 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> @@ -336,33 +336,6 @@ __weak int setup_mac_address(void)
>         return 0;
>  }
>
> -static int setup_serial_number(void)
> -{
> -       char serial_string[25];
> -       u32 otp[3] =3D {0, 0, 0 };
> -       struct udevice *dev;
> -       int ret;
> -
> -       if (env_get("serial#"))
> -               return 0;
> -
> -       ret =3D uclass_get_device_by_driver(UCLASS_MISC,
> -                                         DM_DRIVER_GET(stm32mp_bsec),
> -                                         &dev);
> -       if (ret)
> -               return ret;
> -
> -       ret =3D misc_read(dev, STM32_BSEC_SHADOW(BSEC_OTP_SERIAL),
> -                       otp, sizeof(otp));
> -       if (ret < 0)
> -               return ret;
> -
> -       sprintf(serial_string, "%08X%08X%08X", otp[0], otp[1], otp[2]);
> -       env_set("serial#", serial_string);
> -
> -       return 0;
> -}
> -
>  __weak void stm32mp_misc_init(void)
>  {
>  }
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp=
/stm32mp2/cpu.c
> index c0f6519e8d7c..301e365cf4f4 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> @@ -69,6 +69,8 @@ void enable_caches(void)
>
>  int arch_misc_init(void)
>  {
> +       setup_serial_number();
> +
>         return 0;
>  }
>
> --
> 2.25.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
+48 666 108 041
http://ua.linkedin.com/in/iopaniuk
