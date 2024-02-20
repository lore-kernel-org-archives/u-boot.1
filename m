Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE0FC48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 05:47:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ADFE87D16;
	Tue, 20 Feb 2024 06:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OqPoiNr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81E187F6F; Tue, 20 Feb 2024 06:47:20 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D04F987F78
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 06:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4704c073becso335359137.1
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 21:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708408024; x=1709012824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BoubW3Q0yFjGit2HUyWj10+jJhr6K02fKtRZjUo5XBs=;
 b=OqPoiNr8NDAK3RWqup5Ka3VpG0e46HGRlYe0cdk+sd6ruasedjz2j2QSc6AnmFGcVO
 stnm3Rlf3AUG23apOUJW4oEnFG3KqZ+Tmi0t4SgFOkTKYt3jqLT/XSgI7triEKCAhA/Q
 4IuOhycFnF2cjg4WtenD+c/ideAw7OLhsHJ3mhFPsz9f2oiU5N0pG+wLNnKSbWkgueul
 ubOIYKFN7M3J9ERt6/MFAr+crLoFT3YwKP/F6cY9WRIJLM8bBdOG0j2DCeK4gk8eVTjg
 rQ9xlDbp7MKxX8Vv3hO8WMniOXC89iNSIL72gD8voO5nbrlhMsssOCRmDbY6ag96tbKi
 CQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708408024; x=1709012824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BoubW3Q0yFjGit2HUyWj10+jJhr6K02fKtRZjUo5XBs=;
 b=oZHS2Svink0xVC3RcwBI1MWGkkmXP7hEtvCGO1zb5nXtYbL5qyEtkk1wcUSoJ2brFb
 gq/wX0EflJXZg7oPyzaK7yVLgXK9nNpciudAn3GRNlrLi+WtST3qSLBcLpxgYggqZsDs
 y/SFn3BSf0ZtBRiVVxWMRTbkdwXYqpwU9RE3ubFLYak2W5pErjq4198EFx4CIH8qFbyT
 bQ4eMcfJZNhcAZyuduQpe7BMnmHu2KBWTsFuUk7NEJl11EJaglAwVi/Rwh7md158v7FS
 Uieg1zIF1YNv9yXqLY2tRb6gK2IfaWfH/wrG8HD7p9mBe9V/fZs7d1oM4eHfEJv9Qr5x
 SFwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/MvoIsd03WLlK9KbwdrMVZN2VbhkRxTZruZ0O03TtwmjcZu7WhKphuoUEaotyQqlwUJpdtjzu6yNP/A/RCGeA8DVqgA==
X-Gm-Message-State: AOJu0YwZL8dmcBAsXIRy1P3foVfwh4PHELoH8ED4FT7KE4n2KJTrxzT0
 UqlXCvSLb585njyzuoRzTXKI01RL1LZHarAo88jWm4AU/Lm5WiqewMHkOnbI0K/KX93YOd+M/rC
 +jXKQvHBs8wF0N4NEEFRV400FXqI37hrpexVbbg==
X-Google-Smtp-Source: AGHT+IHjWYcSeVPfW4KG9M0mRqJ0g2DakO74PhOBjir2+BMR3xgYQtDmmQYMckezA2FD/6GJPvVqXhYgbQKdrt8h6YY=
X-Received: by 2002:a67:fbcb:0:b0:470:3ece:b43d with SMTP id
 o11-20020a67fbcb000000b004703eceb43dmr9732951vsr.5.1708408024409; Mon, 19 Feb
 2024 21:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-5-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-5-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:16:53 +0530
Message-ID: <CAFA6WYO08icEpHVM4ciYDmzUuexG7_ZzAmL3hXOrfJh39=Q-zg@mail.gmail.com>
Subject: Re: [PATCH v4 05/39] clk/qcom: use upstream compatible properties
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

On Fri, 16 Feb 2024 at 02:22, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Adjust the apq8016 and apq8096 drivers to use the upstream compatible
> properties, and adjust the associated dts files in U-Boot.

It looks like you haven't adjusted the dts file for db820c. However,
later patches drop them completely so I am not too worried about it.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/dts/dragonboard410c.dts | 2 +-
>  drivers/clk/qcom/clock-apq8016.c | 2 +-
>  drivers/clk/qcom/clock-apq8096.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/dts/dragonboard410c.dts b/arch/arm/dts/dragonboard410c.dts
> index 6a4e3ccf17b1..02c824d0226c 100644
> --- a/arch/arm/dts/dragonboard410c.dts
> +++ b/arch/arm/dts/dragonboard410c.dts
> @@ -75,7 +75,7 @@
>                         };
>                 };
>                 clkc: qcom,gcc@1800000 {
> -                       compatible = "qcom,gcc-apq8016";
> +                       compatible = "qcom,gcc-msm8916";
>                         reg = <0x1800000 0x80000>;
>                         #address-cells = <0x1>;
>                         #size-cells = <0x0>;
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index c0ce570edc79..0af7191cff52 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -145,7 +145,7 @@ static struct msm_clk_data apq8016_clk_data = {
>
>  static const struct udevice_id gcc_apq8016_of_match[] = {
>         {
> -               .compatible = "qcom,gcc-apq8016",
> +               .compatible = "qcom,gcc-msm8916",
>                 .data = (ulong)&apq8016_clk_data,
>         },
>         { }
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index cf1a347309a5..1e6fdb5cd42d 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -123,7 +123,7 @@ static struct msm_clk_data apq8096_clk_data = {
>
>  static const struct udevice_id gcc_apq8096_of_match[] = {
>         {
> -               .compatible = "qcom,gcc-apq8096",
> +               .compatible = "qcom,gcc-msm8996",
>                 .data = (ulong)&apq8096_clk_data,
>         },
>         { }
>
> --
> 2.43.1
>
