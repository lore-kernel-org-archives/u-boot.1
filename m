Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F85C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 14:09:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACF6B87FD1;
	Tue, 20 Feb 2024 15:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bqMYij2q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFBB87FC3; Tue, 20 Feb 2024 15:08:41 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C46B87FA7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 15:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c049ccb623so3222893b6e.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708438113; x=1709042913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yZ+67XKHSgz9QQhmNBwA6NzmrIauL3Rvxs/XLpiE+m8=;
 b=bqMYij2qzWY3vpCHaZQTCb0wiz/DsR4DHhJViLaeKxY/8gs4bVXKEQZeHQf5FvDODn
 7C1Q5/46aO7t7EDic1uLEUY3N15+Km7QuOt5AUhoF/2dvfgoj1d5QdgOLwsG/OqVvXF9
 sHI1WWTK6IBDY8d+LOVeD+UgnKDmGYJla2+VZFPQ0TEhe0SOy/kfQWdSPeztk2uFRLVH
 IF11MDt/ZKCvd8DF9BkbCrRdwa/KPpN+zFi3O9l3tllS9Cga0Ii7h1j4cO4ARq7/Hau5
 p9QxNHCgt3n4IhWtfGZTh1STNt+EYpsfgoTWflgcW6Z4bJGhIqsYSHAXB8B35l88uwxu
 oAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708438113; x=1709042913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZ+67XKHSgz9QQhmNBwA6NzmrIauL3Rvxs/XLpiE+m8=;
 b=OGQuU43mDhK5nzsyWbjBP7MPW30WibNTY6OMmIk04asjF5D7FvtaIKPtKJWkEFG9kz
 Fc2zjUc3rcx9EgLShl/t651uLCqgC7QIEBOoWpfZcWsauWz5vkq/VlTBZwuzDabHzXzl
 uS/BAcCbKB8FlGCLhJ5059dPC4EVLciDdAJ2KcfNDDz+diSPFjzhglzUDrGdfSHJqfoT
 cK5DpDq0fN565S2qxa+wUWksY9WfSizAQy9Zcr+mvPI+nHvDgxLvdZb7SUImvGut0vzT
 cx1llBp2LbmezIljbb6UOrC0g3+Jp9bCWTZTzvOPgqXdDCd9ot2PFayxv5PQa/ckCwKF
 Belg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtV6OfWm7ek6O9iFUZ89FbFWKsiotLthZtHL4C0ZCVFUrEXdIX7KemOb7DQLG2Yqv7kYVz5ALrJCflm67utySlrJPk7Q==
X-Gm-Message-State: AOJu0Yz/oxxvLHke58pmVZc07zJPKQQY1RM0JylJFOb9h6ul74aVFV34
 47Rewe7pVcNuOc8uG/MrIOr6ViJgOEhfNiY6lXYyNZ4TPxNyUMan+biB7GLQDPGW7cHjHBTk7be
 +LcVl8C4WmChWmxbGGWL4cY0BeSZM1nNj4RiVfw==
X-Google-Smtp-Source: AGHT+IGy83Ck3JDMN7LmgYRjF5RV63m1LF88FzpTXoZVI69YrHBiJZUCrQekT5zeDAtDVI3Kr3rZNrQZK++N9AmsTPE=
X-Received: by 2002:a05:6808:1893:b0:3c1:558d:fc60 with SMTP id
 bi19-20020a056808189300b003c1558dfc60mr7474512oib.43.1708438113004; Tue, 20
 Feb 2024 06:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-35-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-35-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 19:38:22 +0530
Message-ID: <CAFA6WYMdjYMe-05HQ5s3GzB9uEG+Grp_tapBWx=12Nsa8wRJjQ@mail.gmail.com>
Subject: Re: [PATCH v4 35/39] dts: dragonboard820c: use correct bindings for
 clocks
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Fri, 16 Feb 2024 at 02:23, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Don't use hardcoded clock IDs, use the IDs from the dt-bindings to be
> compatible with upstream.
>
> Taken from kernel tag v6.7
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/dragonboard820c.dts | 5 +++--
>  drivers/clk/qcom/clock-apq8096.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>


-Sumit

> diff --git a/arch/arm/dts/dragonboard820c.dts b/arch/arm/dts/dragonboard820c.dts
> index 86b7f83d36d6..282c37e28f42 100644
> --- a/arch/arm/dts/dragonboard820c.dts
> +++ b/arch/arm/dts/dragonboard820c.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>
>  #include "skeleton64.dtsi"
> +#include <dt-bindings/clock/qcom,gcc-msm8996.h>
>
>  / {
>         model = "Qualcomm Technologies, Inc. DB820c";
> @@ -78,7 +79,7 @@
>                 blsp2_uart2: serial@75b0000 {
>                         compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>                         reg = <0x75b0000 0x1000>;
> -                       clocks = <&gcc 4>;
> +                       clocks = <&gcc GCC_BLSP2_UART2_APPS_CLK>;
>                         clock-names = "core";
>                         pinctrl-names = "uart";
>                         pinctrl-0 = <&blsp8_uart>;
> @@ -89,7 +90,7 @@
>                         reg = <0x74a4900 0x314>, <0x74a4000 0x800>;
>                         index = <0x0>;
>                         bus-width = <4>;
> -                       clock = <&gcc 0>;
> +                       clock = <&gcc GCC_SDCC1_APPS_CLK>;
>                         clock-frequency = <200000000>;
>                  };
>
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 1e6fdb5cd42d..a4731613c5e0 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -13,6 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8996.h>
>
>  #include "clock-qcom.h"
>
> @@ -107,10 +108,10 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
>         switch (clk->id) {
> -       case 0: /* SDC1 */
> +       case GCC_SDCC1_APPS_CLK: /* SDC1 */
>                 return clk_init_sdc(priv, rate);
>                 break;
> -       case 4: /*UART2*/
> +       case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
>                 return clk_init_uart(priv);
>         default:
>                 return 0;
>
> --
> 2.43.1
>
