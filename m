Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF30C4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 13:52:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81E787CC2;
	Mon, 12 Feb 2024 14:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eWRwPDRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8B487EF1; Mon, 12 Feb 2024 14:52:47 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DAF87ED7
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 14:52:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso4539399a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707745965; x=1708350765; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NUgLYFJFuqicTYtNy7jbCaJkI13P0EV4MYR8uEASN20=;
 b=eWRwPDRFHiiA8Jzx9PsnLw0zTVzyVE9Lv2Rq55PZctRuhG9wwvrVpBp2P1PeTcKk4V
 Dnl3ElG0LdCdGkfBtNftTGLt0mt277PF4E8u9X5GkbGc/rsDDepw2xL8vhko9AfPbgvl
 NFPy8PZj3ZGOKrHt4wCGX+wBCS3qPYD9hvp8G79xgbfZchMw8YfKCU2sU5nw5RORrnLY
 F6hDr2ogmjQmr0VSgUyV3+V25g3b7H4wP+4CWew60dd9xTs6Ql6SE9VYN4ZUFUYTfkW9
 T+lCNn1NbIc95x9UW2L8TwNvozDxWWNhN7B2+7sDvhl7XsHGXgKuj/+W9XikEjSVv7jq
 zb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707745965; x=1708350765;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NUgLYFJFuqicTYtNy7jbCaJkI13P0EV4MYR8uEASN20=;
 b=dt66CZmOzP6CFWjbFQlq3VZeBXf6Lcqj0NCk6FZkyWgypn7gfmreo8C7ntJjyXHuKY
 0DlgnIJmpRJDxW3VNRvQAMMiqaDiLL8cajfDwkZ137qvWkYuV7UjAD0h2IB7ZLCoJYYs
 dwkdYq7Ai2g776P5IoZwPSBkfxaoWCchnsFNZM+f71yuLw/R0gO8yP/8F0xpO7opKu3w
 Uf642iI7rQhuAiTCk0W021o0+3y3mcjzMYTsh4uE/EyRjvmG12at1f/JHrZc4pcu3Z6g
 zAN3B9eVOroPaqeOaKj9SPC/qN1qjrvKEgbfcDDohDPt9997B0mWAdHy5Hc+dnw4l20E
 1ihw==
X-Gm-Message-State: AOJu0YxrSfeXxqPhQv1E1sfVML4ULbT0ZGnTo0aGq/hnijZReKV+L9/0
 kErvJWoPOA7yVioQkuXrPs/EoDszJQxLOYuTgeFx7X3f3KlK8GcS0muu058YmOpqzKGKRbJmOGM
 LIn3PIn2N2PkCa6TGo5YCRjGqLPo=
X-Google-Smtp-Source: AGHT+IF9osSghxGn+wfEU3p4T/8ZU/g+aBVpD9lQIpwsgvSx/AtRQ+uA/+VAv5o8T3EoK4+49EuJfm/wTqQu9fl7jvM=
X-Received: by 2002:aa7:c90b:0:b0:560:da94:2306 with SMTP id
 b11-20020aa7c90b000000b00560da942306mr4095572edt.29.1707745965039; Mon, 12
 Feb 2024 05:52:45 -0800 (PST)
MIME-Version: 1.0
References: <20240209-jaguar-v2-0-6c9ffe09b924@theobroma-systems.com>
 <20240209-jaguar-v2-6-6c9ffe09b924@theobroma-systems.com>
In-Reply-To: <20240209-jaguar-v2-6-6c9ffe09b924@theobroma-systems.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 12 Feb 2024 13:52:34 +0000
Message-ID: <CALeDE9O3SJmE24QqhKi0NS_xRvChRy13gGnKh5pOE0VB1Dypaw@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] rockchip: pine64: rockpro64: migrate to
 rockchip_early_misc_init_r
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

On Fri, 9 Feb 2024 at 09:50, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> Only setup_iodomain() differs from the original misc_init_r from
> Rockchip mach code, so let's use rockchip_early_misc_init_r instead of
> reimplementing the whole misc_init_r from Rockchip.

Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <foss+uboot@0leil.net>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  board/pine64/rockpro64_rk3399/rockpro64-rk3399.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> index d79084614f1..d0a694ead1d 100644
> --- a/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> +++ b/board/pine64/rockpro64_rk3399/rockpro64-rk3399.c
> @@ -11,7 +11,6 @@
>  #include <asm/arch-rockchip/clock.h>
>  #include <asm/arch-rockchip/grf_rk3399.h>
>  #include <asm/arch-rockchip/hardware.h>
> -#include <asm/arch-rockchip/misc.h>
>
>  #define GRF_IO_VSEL_BT565_SHIFT 0
>  #define PMUGRF_CON0_VSEL_SHIFT 8
> @@ -31,26 +30,11 @@ static void setup_iodomain(void)
>         rk_setreg(&pmugrf->soc_con0, 1 << PMUGRF_CON0_VSEL_SHIFT);
>  }
>
> -int misc_init_r(void)
> +int rockchip_early_misc_init_r(void)
>  {
> -       const u32 cpuid_offset = 0x7;
> -       const u32 cpuid_length = 0x10;
> -       u8 cpuid[cpuid_length];
> -       int ret;
> -
>         setup_iodomain();
>
> -       ret = rockchip_cpuid_from_efuse(cpuid_offset, cpuid_length, cpuid);
> -       if (ret)
> -               return ret;
> -
> -       ret = rockchip_cpuid_set(cpuid, cpuid_length);
> -       if (ret)
> -               return ret;
> -
> -       ret = rockchip_setup_macaddr();
> -
> -       return ret;
> +       return 0;
>  }
>
>  #endif
>
> --
> 2.43.0
>
