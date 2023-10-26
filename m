Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8440C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 10:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F383875B0;
	Thu, 26 Oct 2023 12:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wYEdkSDB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33635875B0; Thu, 26 Oct 2023 12:15:35 +0200 (CEST)
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com
 [IPv6:2607:f8b0:4864:20::931])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FA48759C
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 12:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7b6043d0bbeso276860241.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698315331; x=1698920131; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=seAjm/+TMciGLp9qLdRjmGEjXPqCM/i84dRVQlVE994=;
 b=wYEdkSDBMTImEuDXikT05cl0SeFaR1ZEFxiGA/3vIR+rgOW6r0Jno9PtPmLy+GeBsC
 EUKAyoLGQ6M3wpKIHAls8KVtRVlXqM2EOODBLo52/oretyyScIumzGxbmbJkTEEKooQo
 jcCMdzfeSypGfsxxm1OhLjL9ngbEzx3rwVNZZcGw3i4OLzlBcJq8K3Ayrjyxz/4bWHVY
 gEAsg48KHKPtHl7jrZqlwX4+GAGR2sdgltgud9aO5Su/nItayEf7wZQ1t7rX+4PTNexs
 7thVQfCpX84OgNEYuW4fnUao9915lHw5wXK6bWViLa+HLL0xjZfmJU29mpZQLc177s9y
 k2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698315331; x=1698920131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=seAjm/+TMciGLp9qLdRjmGEjXPqCM/i84dRVQlVE994=;
 b=J5ic+/tJia4Q4jLojF3lRFpEYwFhMLeRf/tQiI0C3boxXbnQI4ezkKaO0+oLOllLxw
 /lEbQG5ZDuPYo7qL0BgVqTQPokyM/2qmEmd2GIWEXmk+/e2Zr+Q4oTHY9b5RW6XPNZKy
 zd5mx4VYL4LKfLyyztxFiyjYzc4s/xl41OixXsno7Ap2Oc7fGXFXaEaCufCvQWOyEjs0
 lyqSgeqPZWC7900eyORuNtr+BmKWTFLMr8MTCqj9HP9N7BcxHlEIyxJBeINdcsmjYsgY
 HW6pAVhbR/57ekRmfhWziaV5cgOCWtS1zP6kERZuL8TUGl86u59jIM8NJKmiNe3vwG9y
 qguw==
X-Gm-Message-State: AOJu0Yydy8L0pZdHJaIdaoUjPvU2xIBTD5a4pIKh5IEbbdevIPOsurg9
 fvsN+9kd1wWey4BZG6nj1eq5C5kqT8JhEfTV0+ArAg==
X-Google-Smtp-Source: AGHT+IETt4fMUJQHgf2m7wBCMUwzDZ0OhZfJT5OWzIlx8TeCb2VyHsTvgw6yDArPK2yDgSyhrO3omYB5dbyq/rLk2VE=
X-Received: by 2002:a05:6102:101d:b0:457:c52e:deda with SMTP id
 q29-20020a056102101d00b00457c52ededamr14060608vsp.34.1698315330900; Thu, 26
 Oct 2023 03:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-1-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-1-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 26 Oct 2023 15:45:19 +0530
Message-ID: <CAFA6WYPxtCdzFoumiEWkWUSEa15Mkth7Ntw+yYKaCdDFf2w0ng@mail.gmail.com>
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

Similarly, I think here we should introduce here SoC specific config
options like:

CONFIG_CLK_SDM845
CONFIG_CLK_APQ8016
CONFIG_CLK_APQ8096
CONFIG_CLK_QCS404

-Sumit

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
