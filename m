Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA553C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 10:05:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 970F0875E1;
	Thu, 26 Oct 2023 12:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cgMqD0jK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E00C87599; Thu, 26 Oct 2023 12:05:08 +0200 (CEST)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com
 [IPv6:2607:f8b0:4864:20::92e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7779A8759C
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 12:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7b610279c8aso334601241.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698314700; x=1698919500; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0Mz0VXcyhm2+XKX6uL45lIvMAUWbALtj8vDVdr3EBAk=;
 b=cgMqD0jKkrVaj3mpEZ/A3ZO5fgjg25lTvva6aP7ulW7A7wFlays1kFirEu4LOiQnGq
 z7oCzHa+z2Qqwv1YS+QUWF5KN/dVAZNOj61RrbHTgz546lEPy9xerYpodapnJ+7A+IgI
 vLImA1N9qakbU6lV9RE78bNvw5jEgCHT5+vX178Bpt8bNrVjCJ1nyyAQwJWw52cMgL1e
 fmKx+d73lzYSaQi/8h46bpoCeE5isbK0yVA8VoFuAvI5m6r2RR54gGXgEuQbmH1qGKCn
 M62ky/QhVjW7UHWEJzucrAg6EkO6IqqDX7vjbDn4xZhwGW67Mr6GQZMFIKwwM0khlFLX
 9QfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698314700; x=1698919500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0Mz0VXcyhm2+XKX6uL45lIvMAUWbALtj8vDVdr3EBAk=;
 b=gSqj9oVKA3BSym3YUvfHbPjBqMrtoXdeJyjf8pihkatL0xv3K8x3NXL2fHemeoDkzA
 MOEJD0psZ5WLf7Mvw995Dms0+PXqUsCWJMlX0vfCzYDvsbpYs7Gr3RZcwXRK4csIAjSn
 TEZhAP22rEooLBdm0m/y2psEVk6pw015qFthodan4fP9kdZBYadWbfwQ3n5ukJJnLg7H
 VtLAxk8KVTlKT2e2Ewbcr53eWtCEVR5iRiRoe6PxGvZkIWc/IS/bUpUSAg0WhIYjS2TN
 0sbb2EWx1pK7rsP0XdRyWPPUFzZ4qfDb4l8vrYWkHUWXyP2Jwjdv10Wmmj5/HHXaoN2c
 /icw==
X-Gm-Message-State: AOJu0YwMUb+r7PvzvbUNEPX41XCr0SFzGrtR/8TDdsnMnvQZQAb5TzK6
 e1/82iZqMTGqTMxRpPcJO6Umn4zcR2kcr0ny9vzaEQ==
X-Google-Smtp-Source: AGHT+IH+SNXhUDAIWvT4PdjdFmXyPFswg199MbaSMwomiEiTSsBqKpobePjzcWsAq4yrYGoOk3W0xij0NfP2uy65vV0=
X-Received: by 2002:a67:cc15:0:b0:452:78e2:4a07 with SMTP id
 q21-20020a67cc15000000b0045278e24a07mr14871895vsl.8.1698314700436; Thu, 26
 Oct 2023 03:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-1-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-1-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 26 Oct 2023 15:34:48 +0530
Message-ID: <CAFA6WYNz6SrOQiuWuXoyDbAaO2qo_NROK352nigJxOmNfrZ4XA@mail.gmail.com>
Subject: Re: [PATCH 1/8] clk/qcom: move from mach-snapdragon
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
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

On Wed, 25 Oct 2023 at 01:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Clock drivers don't belong here, move them to the right place and
> declutter mach-snapdragon a bit.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/Makefile                                | 5 -----
>  drivers/clk/Makefile                                             | 1 +
>  drivers/clk/qcom/Makefile                                        | 9 +++++++++
>  {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-apq8016.c   | 2 +-
>  {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-apq8096.c   | 3 ++-
>  .../clock-snapdragon.c => drivers/clk/qcom/clock-qcom.c          | 2 +-
>  .../clock-snapdragon.h => drivers/clk/qcom/clock-qcom.h          | 0
>  {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-qcs404.c    | 2 +-
>  {arch/arm/mach-snapdragon => drivers/clk/qcom}/clock-sdm845.c    | 2 +-
>  9 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
> index cbaaf23f6b56..497ee35cf7d3 100644
> --- a/arch/arm/mach-snapdragon/Makefile
> +++ b/arch/arm/mach-snapdragon/Makefile
> @@ -2,20 +2,15 @@
>  #
>  # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
>
> -obj-$(CONFIG_SDM845) += clock-sdm845.o
>  obj-$(CONFIG_SDM845) += sysmap-sdm845.o
>  obj-$(CONFIG_SDM845) += init_sdm845.o
> -obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
> -obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
>  obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
>  obj-y += misc.o
> -obj-y += clock-snapdragon.o
>  obj-y += dram.o
>  obj-y += pinctrl-snapdragon.o
>  obj-y += pinctrl-apq8016.o
>  obj-y += pinctrl-apq8096.o
>  obj-y += pinctrl-qcs404.o
>  obj-y += pinctrl-sdm845.o
> -obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
>  obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 26bf429acbc0..dd90c7672e1b 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_CLK_MPFS) += microchip/
>  obj-$(CONFIG_CLK_MVEBU) += mvebu/
>  obj-$(CONFIG_CLK_OCTEON) += clk_octeon.o
>  obj-$(CONFIG_CLK_OWL) += owl/
> +obj-$(CONFIG_ARCH_SNAPDRAGON) += qcom/

CONFIG_CLK_QCOM is better suited here. You should introduce that here instead.

-Sumit

>  obj-$(CONFIG_CLK_RENESAS) += renesas/
>  obj-$(CONFIG_$(SPL_TPL_)CLK_SCMI) += clk_scmi.o
>  obj-$(CONFIG_CLK_SIFIVE) += sifive/
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> new file mode 100644
> index 000000000000..5f0c7a79d2ab
> --- /dev/null
> +++ b/drivers/clk/qcom/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# (C) Copyright 2023 Linaro
> +
> +obj-y += clock-qcom.o
> +obj-$(CONFIG_SDM845) += clock-sdm845.o
> +obj-$(CONFIG_TARGET_DRAGONBOARD410C) += clock-apq8016.o
> +obj-$(CONFIG_TARGET_DRAGONBOARD820C) += clock-apq8096.o
> +obj-$(CONFIG_TARGET_QCS404EVB) += clock-qcs404.o
> diff --git a/arch/arm/mach-snapdragon/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> similarity index 98%
> rename from arch/arm/mach-snapdragon/clock-apq8016.c
> rename to drivers/clk/qcom/clock-apq8016.c
> index 23a37a1714dc..90f2a93d9ed5 100644
> --- a/arch/arm/mach-snapdragon/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -13,7 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE BIT(17)
> diff --git a/arch/arm/mach-snapdragon/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> similarity index 98%
> rename from arch/arm/mach-snapdragon/clock-apq8096.c
> rename to drivers/clk/qcom/clock-apq8096.c
> index 66184596d562..d5388c69aefe 100644
> --- a/arch/arm/mach-snapdragon/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -13,7 +13,8 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +
> +#include "clock-qcom.h"
>
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE            BIT(30)
> diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.c b/drivers/clk/qcom/clock-qcom.c
> similarity index 99%
> rename from arch/arm/mach-snapdragon/clock-snapdragon.c
> rename to drivers/clk/qcom/clock-qcom.c
> index 0ac45dce9a92..5667abeb89a4 100644
> --- a/arch/arm/mach-snapdragon/clock-snapdragon.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -13,7 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  /* CBCR register fields */
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
> diff --git a/arch/arm/mach-snapdragon/clock-snapdragon.h b/drivers/clk/qcom/clock-qcom.h
> similarity index 100%
> rename from arch/arm/mach-snapdragon/clock-snapdragon.h
> rename to drivers/clk/qcom/clock-qcom.h
> diff --git a/arch/arm/mach-snapdragon/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> similarity index 99%
> rename from arch/arm/mach-snapdragon/clock-qcs404.c
> rename to drivers/clk/qcom/clock-qcs404.c
> index 3357b54c30c0..80218af73ef6 100644
> --- a/arch/arm/mach-snapdragon/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -11,7 +11,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
>
> diff --git a/arch/arm/mach-snapdragon/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> similarity index 98%
> rename from arch/arm/mach-snapdragon/clock-sdm845.c
> rename to drivers/clk/qcom/clock-sdm845.c
> index d6df0365afca..95a057b82986 100644
> --- a/arch/arm/mach-snapdragon/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -15,7 +15,7 @@
>  #include <asm/io.h>
>  #include <linux/bitops.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> -#include "clock-snapdragon.h"
> +#include "clock-qcom.h"
>
>  #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
>
>
> --
> 2.42.0
>
