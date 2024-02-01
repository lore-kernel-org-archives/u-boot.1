Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03877C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 10:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C0287C5A;
	Thu,  1 Feb 2024 11:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nlTErwkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AB8E87C68; Thu,  1 Feb 2024 11:25:41 +0100 (CET)
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com
 [IPv6:2607:f8b0:4864:20::e31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4209587C5A
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 11:25:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-46b29f09401so305088137.2
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706783138; x=1707387938; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/vW+HIpDcqRZe3lEoxXcu/ZuvGahrIcZERAnzP4WGII=;
 b=nlTErwkWriff2DfQbaWKxXtTvRJPuI+nY2xUFudnMKF5YCVM24IO0nfrJ3thm2mFoz
 uehZCuZ6JwdekMxhePdYIPFOVPQp08fQ49OJtJ2XJv0O7glsxt3CE+KStlryANMVEbnW
 FaeLyWiNNn2Ze/zo2eJSqL0QAWS6EksQ1yKrNHYVB0qxMHfQ/4/FoApJrrqTNORKnC34
 hWtvVe4tcaPmFK/Pp1383CEUa79h7GjSv5xZjB7pirQc0U8BiEFn7qjdMV+VsjbX1SoG
 S1y7ZVZzIFYPGOOlDzB1BlOl+s8O1oLsj89BhvsgrWrhiT2WiCqB9NwPmqgNGdJkWC92
 v7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706783138; x=1707387938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/vW+HIpDcqRZe3lEoxXcu/ZuvGahrIcZERAnzP4WGII=;
 b=sX39midxesRI4do1CBIGrc9+vzdKEX3ODlQ7Q/BUyqfCv1vGAsDoa5tu7LNStULs9w
 Cj7f8w+QLD0JiXYna2U3C+R68FE+24DUzwvhKK94t0oubTdxycLRAh3V5iExclxvU8mj
 k5HUvi0GJriAZMAq9fn+ATtsv6FAkY6L1anFScbQLV1it7fMWrwqgUDL2xEPor63AOHr
 rATA7rw5eXYHSpF2g+iB/mOD1hGOSH0ETzmWNl4AM9fvJjxcNjKzCsI7t6/GAagcsKbN
 7ntfcrelvDNM3aMSLdaiYhvqq4dEi12ixWVi0kcXrRv5CALvH8hCdWI6Cjh+nyfV0hBR
 O7sA==
X-Gm-Message-State: AOJu0Yw1bgTC9Rvv6AKyUf8CSIRZxGbuMy3PDPSjhtZQqDVHDhhfuapf
 RltqtrwJCXq5UFnQUA9/dyny1MEedhRSD/nBdKmS4bMjTML3uRI5EtKJftWei/wbM0fqYw7C5WA
 Pgdu5Bln2mag2RmLK5o5ZPA9FVjBlFuEHzwCu3w==
X-Google-Smtp-Source: AGHT+IG9xqYJtGhLc97D+1wdixQ9hAQ2kt5sOIKkH4llRouty7FOHOr//QVMxGRrWtCeMYPrYsJtwjCVdomp6SYgoXc=
X-Received: by 2002:a67:fc4b:0:b0:46c:f267:90c with SMTP id
 p11-20020a67fc4b000000b0046cf267090cmr1135489vsq.14.1706783138003; Thu, 01
 Feb 2024 02:25:38 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-6-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-6-e523cbf9e556@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 1 Feb 2024 15:55:26 +0530
Message-ID: <CAFA6WYN3GA17ACSXpr-ukrpvgh_5jnby8VU9QA54Wj-RpGGqVw@mail.gmail.com>
Subject: Re: [PATCH v3 06/36] clock/qcom: qcs404: fix clk_set_rate
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

On Tue, 30 Jan 2024 at 19:35, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We should be returning the rate that we set the clock to, drivers like
> MMC rely on this. So fix it.

I suppose following diff make sense on top of this patch given the MMC
driver clock changes:

diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
index 03fd65a9328b..97668f18cd8c 100644
--- a/drivers/clk/qcom/clock-qcs404.c
+++ b/drivers/clk/qcom/clock-qcs404.c
@@ -208,9 +208,6 @@ static ulong qcs404_clk_set_rate(struct clk *clk,
ulong rate)
                clk_enable_gpll0(priv->base, &gpll0_vote_clk);
                clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
                return rate;
-       case GCC_SDCC1_AHB_CLK:
-               clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
-               break;
        case GCC_ETH_RGMII_CLK:
                if (rate == 250000000)
                        clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
@@ -225,9 +222,11 @@ static ulong qcs404_clk_set_rate(struct clk *clk,
ulong rate)
                        clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
                                             CFG_CLK_SRC_GPLL1, 8);
                return rate;
+       default:
+               log_warning("Unknown clock id %ld\n", clk->id);
+               break;
        }

-       log_warning("Unknown clock id %ld\n", clk->id);
        return 0;
 }

@@ -304,6 +303,9 @@ static int qcs404_clk_enable(struct clk *clk)
                clk_rcg_set_rate(priv->base, &blsp1_qup4_i2c_apps_regs, 0,
                                 CFG_CLK_SRC_CXO);
                break;
+       case GCC_SDCC1_AHB_CLK:
+               clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
+               break;
        default:
                return 0;
        }

-Sumit

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-qcs404.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index f5b352803927..03fd65a9328b 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -207,7 +207,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>                                      CFG_CLK_SRC_GPLL0, 8);
>                 clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>                 clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
> -               break;
> +               return rate;
>         case GCC_SDCC1_AHB_CLK:
>                 clk_enable_cbc(priv->base + SDCC_AHB_CBCR(1));
>                 break;
> @@ -224,11 +224,10 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>                 else if (rate == 5000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
>                                              CFG_CLK_SRC_GPLL1, 8);
> -               break;
> -       default:
> -               return 0;
> +               return rate;
>         }
>
> +       log_warning("Unknown clock id %ld\n", clk->id);
>         return 0;
>  }
>
>
> --
> 2.43.0
>
