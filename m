Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B530DC3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 16:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DDDB87214;
	Mon, 15 Jan 2024 17:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="MaEda4Dc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF63287252; Mon, 15 Jan 2024 17:26:37 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4537F86FC9
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 17:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2cd928a1d58so34692081fa.3
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1705335994; x=1705940794; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2ULnBts3eiCPQ4rcf6zBr7I4Aq0uQ8ncBziZmt4kGY=;
 b=MaEda4DcyhxHMyOHsetUetvWOjsdmzr37mFUmEismHL+K0YGWfZhV59sv8FQWGwsqH
 y2S2r5BYoX4wMn1Zf3NxVAhbdjqFmsAHQ+R1efeAEUhF4ZxCA7rOYjXyhYzvkPdvQ3z8
 9FBEs+MDpDDtEw/KZ4fDRdpKGQnfE6Tm3yH2Fkgw7I+LLe74dsR4jMnDOxW9E4eWBrfs
 wXSWk73P1F4q3CFi808KjsdmxS0hy3X54vuCRyN5Bno1Pnhx9yrdpOFdO10vlr3EaEdY
 P1/EEuArREFN3zY2AW/Chw6TMJbxqIIIeBBGV0u5emzuzqOKPUZyVG2zP1iwFIWrO79O
 E3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705335994; x=1705940794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2ULnBts3eiCPQ4rcf6zBr7I4Aq0uQ8ncBziZmt4kGY=;
 b=KGKnSe6qrb5oDGvdJeAipX1ktiGTFCuGOjfm5OYKW0JtWIzK8emthTOOex5fzZfmqq
 nxDsJS109UIZngqB5t+T6BU+6U66/geFCtE+2yuTQrAb1x8BXOQwUMPpt6sJ5mYAJZnC
 9fyXF52AsDaMot92PRTfC6sha+ls5P1XG/elxBPTz4xoLSFUyJ81Q9D+9DZRdyh2X5zO
 +FBsGXEiw45kwmMdip8f6cdRhCRVzQ4dawg0K2OEvpsEinj4oQI2B+D3u+ifc+9JWpzI
 Q0NKNha7yuX359Oz2cg51bQlk53Ocp9i+txxKiI6VmKfalrnH9VvmTN7Y4OXwqmm8U7Z
 4T3Q==
X-Gm-Message-State: AOJu0Yx4lDaUIE2VNyqo8ZALxXQqzztW+wLeEbbbToXSTyI8hk2G3AG+
 pFZcv2e0Q/ozkKsLV+i+qrAc+sOxNZSRqkH421bBBBvqqpesMg==
X-Google-Smtp-Source: AGHT+IFDSh8QJ4kBc7UCKdJoB75/I3NYWelHLRcjs3R9lttqmo4nvm/7BeJdzesFQufT+gct2mI6YzuHOHUM6a9MLY4=
X-Received: by 2002:a05:6512:3c8d:b0:50e:74c1:64d2 with SMTP id
 h13-20020a0565123c8d00b0050e74c164d2mr3778658lfv.94.1705335994365; Mon, 15
 Jan 2024 08:26:34 -0800 (PST)
MIME-Version: 1.0
References: <20240115140557.57448-1-patrick.delaunay@foss.st.com>
 <20240115150451.v2.6.I175b5b047ccdb4198f1ae11bac19411617623518@changeid>
In-Reply-To: <20240115150451.v2.6.I175b5b047ccdb4198f1ae11bac19411617623518@changeid>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Mon, 15 Jan 2024 17:26:22 +0100
Message-ID: <CAL6CDMESvLgGFrOb2767nCUiKPJcP9XLWkY1du+sKWamZf24Mw@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] stm32mp: add soc.c file
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

On Mon, Jan 15, 2024 at 3:07=E2=80=AFPM Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> Add a new file soc.c for common functions between stm32mp1 and stm32mp2
> family and move print_cpuinfo() in this new file.
>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
> (no changes since v1)
>
>  arch/arm/mach-stm32mp/Makefile       |  1 +
>  arch/arm/mach-stm32mp/soc.c          | 17 +++++++++++++++++
>  arch/arm/mach-stm32mp/stm32mp1/cpu.c | 11 -----------
>  arch/arm/mach-stm32mp/stm32mp2/cpu.c | 11 -----------
>  4 files changed, 18 insertions(+), 22 deletions(-)
>  create mode 100644 arch/arm/mach-stm32mp/soc.c
>
> diff --git a/arch/arm/mach-stm32mp/Makefile b/arch/arm/mach-stm32mp/Makef=
ile
> index 00dc25bb275c..fdcbbf91dfd5 100644
> --- a/arch/arm/mach-stm32mp/Makefile
> +++ b/arch/arm/mach-stm32mp/Makefile
> @@ -6,6 +6,7 @@
>  obj-y +=3D dram_init.o
>  obj-y +=3D syscon.o
>  obj-y +=3D bsec.o
> +obj-y +=3D soc.o
>
>  obj-$(CONFIG_STM32MP15x) +=3D stm32mp1/
>  obj-$(CONFIG_STM32MP13x) +=3D stm32mp1/
> diff --git a/arch/arm/mach-stm32mp/soc.c b/arch/arm/mach-stm32mp/soc.c
> new file mode 100644
> index 000000000000..8d5fa474ccaf
> --- /dev/null
> +++ b/arch/arm/mach-stm32mp/soc.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
> +/*
> + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
> + */
> +
> +#include <asm/arch/sys_proto.h>
> +
> +/* used when CONFIG_DISPLAY_CPUINFO is activated */
> +int print_cpuinfo(void)
> +{
> +       char name[SOC_NAME_SIZE];
> +
> +       get_soc_name(name);
> +       printf("CPU: %s\n", name);
> +
> +       return 0;
> +}
> diff --git a/arch/arm/mach-stm32mp/stm32mp1/cpu.c b/arch/arm/mach-stm32mp=
/stm32mp1/cpu.c
> index 55574fd4bebf..00fea7929b2f 100644
> --- a/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp1/cpu.c
> @@ -158,17 +158,6 @@ void enable_caches(void)
>         dcache_enable();
>  }
>
> -/* used when CONFIG_DISPLAY_CPUINFO is activated */
> -int print_cpuinfo(void)
> -{
> -       char name[SOC_NAME_SIZE];
> -
> -       get_soc_name(name);
> -       printf("CPU: %s\n", name);
> -
> -       return 0;
> -}
> -
>  static void setup_boot_mode(void)
>  {
>         const u32 serial_addr[] =3D {
> diff --git a/arch/arm/mach-stm32mp/stm32mp2/cpu.c b/arch/arm/mach-stm32mp=
/stm32mp2/cpu.c
> index f43d1aaf72cc..c0f6519e8d7c 100644
> --- a/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> +++ b/arch/arm/mach-stm32mp/stm32mp2/cpu.c
> @@ -67,17 +67,6 @@ void enable_caches(void)
>         dcache_enable();
>  }
>
> -/* used when CONFIG_DISPLAY_CPUINFO is activated */
> -int print_cpuinfo(void)
> -{
> -       char name[SOC_NAME_SIZE];
> -
> -       get_soc_name(name);
> -       printf("CPU: %s\n", name);
> -
> -       return 0;
> -}
> -
>  int arch_misc_init(void)
>  {
>         return 0;
> --
> 2.25.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Embedded Software Engineer
T:  +380 938364067
E: igor.opaniuk@foundries.io
W: www.foundries.io
