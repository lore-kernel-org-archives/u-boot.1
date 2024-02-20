Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE13C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 06:07:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C84A87F85;
	Tue, 20 Feb 2024 07:05:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dFQYhIwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B639087BB3; Tue, 20 Feb 2024 07:04:58 +0100 (CET)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0D9879F6
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 07:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4703958f28fso219034137.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 22:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708408986; x=1709013786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jFcaZz3WlVxUj67iTmy7VeuC+jlR4TP+NibdZXmN7Ag=;
 b=dFQYhIwREPULoWFdOKN1QGPFtoXfGm1wRJZVHvG4Yd6H+jbIhAcdxvtfIyXdocEQci
 GaJrFdM/DTSOyIdxH+BUXfV82j46kXc4CsC2KV4RccIiL/Mi8uDFnS6XqWXoOmA3Q1h9
 XGJo8K5A39Gy76cXNVH7Zem9xSenVLO5dy1Of4eGCNkA8cLQ2Mv59iEC025TLsoRTEkd
 j+pSDLI+KXErNBystpGSUEKqxPmhFO6jaXy7MEpdF9wSn+Bvcnf/nNnc3Hq2c40qrNfB
 dUNq9e+nqQfMvXOzM5rbrofwrFWz9U3C7wMXR0w8zOfnCZOxSH9RnMQzkny2ZhD2xUUf
 BqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708408986; x=1709013786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jFcaZz3WlVxUj67iTmy7VeuC+jlR4TP+NibdZXmN7Ag=;
 b=Krg495M8xWLYMcPt3sat3uN1MUanRh5ULrufxCACMEERgmkQMImp15BRJgBiDAurIW
 zlW7m/+sPHHd6MJ1b75GhE4TWQQKXvVmVoo5mpw0o5j2Y43+VNEXexbc122JCNTrlNKH
 fYhnHty2SJoqfKpCyuVYHy9VSBvaKNAogD/sgRZAIPefEZtW7RIYUWjbXQo0Zr+/FcZk
 8SbjoVIajUmNI6rNrCx/Mvh+YR8LUbp32xg8rhGVLB1OGJukxQF7CpxfwyVwg2T39Qzr
 szq6R+iUeP9TBuLhVmEtHFKm5pMw84VHRSl8fU6Q7vXQn79RegrwoeojTnOktSqmr+72
 +fdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSc3HgZerW9NMA++LbdoqeXw3A6+QB71XA9nKoBU/UzCHPTWIvVheV+oX1mVz5D7J8IzrbD5Hb+URVFNh+ryS9alFtvw==
X-Gm-Message-State: AOJu0YzVzAGx4GlNrkQ8m3y95Um1GczGhuGO9PqXJdSU7q6H1oxRAHuD
 0fUKETpxD9rE3LzAZby16QLHI+O1Hhkw9p+wGsoHo37N6G8vinY6xmpS+OtpNFbaXBfH6ZpU8C1
 xNn5376r2OIG1SfEJ88PawVFvNph/RTAlDM+KAg==
X-Google-Smtp-Source: AGHT+IHzqlr6cdO1gx/tfYsN0nCM5eXuwqWfNdoGzmF1rJ3LYZS5vJNaBTEWXuLTwkrn3Ts6W3OdcyrmqNFYjdaXyNY=
X-Received: by 2002:a05:6102:b16:b0:470:5e90:a45a with SMTP id
 b22-20020a0561020b1600b004705e90a45amr3742262vst.18.1708408986114; Mon, 19
 Feb 2024 22:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-6-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-6-ed06355c634a@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 20 Feb 2024 11:32:55 +0530
Message-ID: <CAFA6WYNrzQpKWB8cvhTnBp+TfmPXtsAc7ztzGKe4hN4SfUPxKw@mail.gmail.com>
Subject: Re: [PATCH v4 06/39] clock/qcom: qcs404: fix clk_set_rate
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
> We should be returning the rate that we set the clock to, drivers like
> MMC rely on this. So fix it.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-qcs404.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index f5b352803927..958312b88842 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -193,24 +193,18 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>
>         switch (clk->id) {
>         case GCC_BLSP1_UART2_APPS_CLK:
> -               /* UART: 115200 */
> +               /* UART: 1843200Hz for a fixed 115200 baudrate (19200000 * (12/125)) */
>                 clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
>                                      CFG_CLK_SRC_CXO, 16);
>                 clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
> -               break;
> -       case GCC_BLSP1_AHB_CLK:
> -               clk_enable_vote_clk(priv->base, &gcc_blsp1_ahb_clk);
> -               break;
> +               return 1843200;
>         case GCC_SDCC1_APPS_CLK:
>                 /* SDCC1: 200MHz */
>                 clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
>                                      CFG_CLK_SRC_GPLL0, 8);
>                 clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>                 clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
> -               break;
> -       case GCC_SDCC1_AHB_CLK:
> -               clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
> -               break;
> +               return rate;
>         case GCC_ETH_RGMII_CLK:
>                 if (rate == 250000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
> @@ -224,11 +218,15 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>                 else if (rate == 5000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
>                                              CFG_CLK_SRC_GPLL1, 8);
> -               break;
> -       default:
> -               return 0;
> +               return rate;
>         }
>
> +       /* There is a bug only seeming to affect this board where the MMC driver somehow calls
> +        * clk_set_rate() on a clock with id 0 which is associated with the qcom_clk device.
> +        * The only clock with ID 0 is the xo_board clock which should not be associated with
> +        * this device...
> +        */
> +       log_debug("Unknown clock id %ld\n", clk->id);
>         return 0;
>  }
>
> @@ -305,6 +303,9 @@ static int qcs404_clk_enable(struct clk *clk)
>                 clk_rcg_set_rate(priv->base, &blsp1_qup4_i2c_apps_regs, 0,
>                                  CFG_CLK_SRC_CXO);
>                 break;
> +       case GCC_SDCC1_AHB_CLK:
> +               clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
> +               break;
>         default:
>                 return 0;
>         }
>
> --
> 2.43.1
>
