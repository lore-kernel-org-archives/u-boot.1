Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4644C25B6E
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 11:06:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A00F876CF;
	Fri, 27 Oct 2023 13:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ICJaa++6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8921F87709; Fri, 27 Oct 2023 13:06:42 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F87B876CA
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 13:06:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-457cdfc293bso876609137.3
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 04:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698404797; x=1699009597; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=phxF8i6gQgE1ufWQp+YsatDh1HhSDVY/kwS148XQ9ts=;
 b=ICJaa++6q4OesUMwwEuZcDpEW8jPVKtrHbuDgUGhyC/4TY6Ing5j2PkDy0EebIfts8
 0dKyCPDOXIHdT+OcLm2TUxAPIH0eSOjs4t4GV9bJISwceC+5bWmD5hDFLIEujnKBiKIf
 xZSkR0WbWDtcQi98bkTvpjj0ROTi2P3awFwBhb88BRysL/pdbnFbPRuhQH+ugj0mO1rA
 2CiZaHpmDH0dEV3qWW+FjLqk4TZyPYISV7Jikqp//1zZ9ha9qUzh76kUvyvVD4GEC0TO
 wISMPCNBpfk4RY++32Yf2cBEeBAaAh4JTQaQYa+odWF5ix45Zdrz0ErF5e+wskymNdEy
 SuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698404797; x=1699009597;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=phxF8i6gQgE1ufWQp+YsatDh1HhSDVY/kwS148XQ9ts=;
 b=vPMoXoN6GgbrSMIiB1vwl+yi88Ubh1Svwqo4y13SFFRO0IjhHxXUTOdgio8Be+q9tb
 sMOhWz7vywuv9DKDWO3KGNJejpnrg+EOn1Nv+xjU/ds0nlvszqHZMefj2+dCoTsjlu8B
 0Z63x1v9sXOEG1M9fT3VAW7Wp5D+08swcv1Qup8dHqGoilsB/S8NgUiKFIs0igK5jYRT
 8tEKzDUEocLHduW11mGHL8SU46wHT1DfFbWUbNqnWLcuIm1ouotLREgwnLSnwt2WiJ5h
 8GDv2/t+VOALdaVrOwes+WdpmVcS55avwlDyzQSdOS/Cpu9ipHayPl6Azdsaf0bBi7kC
 DQLw==
X-Gm-Message-State: AOJu0YzGxsl8rLlfKabYhijcfj0aAIZ5iGU/F1K9+ua5piDIB53e6qWu
 T4Bbo9oMNdN/AJmL6NQtXiMTKxVptP1wBAwMHHM57Q==
X-Google-Smtp-Source: AGHT+IFUamkgMMj835eLmTUvhlfRyJIeiqY0pV5S9jVxOYRV4zOMC6QeEK1kIhRNEcFN6YjJIK58DbRU27Sdj897qNU=
X-Received: by 2002:a67:ef50:0:b0:45a:67da:658 with SMTP id
 k16-20020a67ef50000000b0045a67da0658mr2338093vsr.33.1698404796922; Fri, 27
 Oct 2023 04:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-6-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-6-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 27 Oct 2023 16:36:25 +0530
Message-ID: <CAFA6WYO57W-e5S8pzKwT579BoBzMGE-3G5aQLF=r39Anyov0ig@mail.gmail.com>
Subject: Re: [PATCH 6/8] clk/qcom: use function pointers for enable and
 set_rate
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

On Wed, 25 Oct 2023 at 01:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Currently, it isn't possible to build clock drivers for more than one
> platform due to how the msm_enable() and msm_set_rate() callbacks are
> implemented.
>
> Extend qcom_cc_data to include function pointers for these and convert
> all platforms to use them.
>
> Previously, clock drivers relied on common.h to include the board

No it's not included via common.h but rather via target specific
include file like: include/configs/sdm845.h.

> specific sysmap header, include those explicitly to further reduce the
> dependency between the clock driver and a particular target
> configuration.

If you really need to remove that dependency then the clock specific
macros need to move out of the system map header as a separate header
in drivers/clk/qcom/.

>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-apq8016.c | 12 ++++++------
>  drivers/clk/qcom/clock-apq8096.c | 12 ++++++------
>  drivers/clk/qcom/clock-ipq4019.c |  6 ++++--
>  drivers/clk/qcom/clock-qcom.c    | 17 ++++++++++++-----
>  drivers/clk/qcom/clock-qcom.h    |  5 +++++
>  drivers/clk/qcom/clock-qcs404.c  |  5 ++++-
>  drivers/clk/qcom/clock-sdm845.c  | 12 ++++++++----
>  7 files changed, 45 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index e3b9b8c1b91b..f74f7a0f5ad9 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -13,6 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <mach/sysmap-apq8016.h>
>
>  #include "clock-qcom.h"
>
> @@ -94,7 +95,7 @@ static int clk_init_uart(struct qcom_cc_priv *priv)
>         return 0;
>  }
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong apq8016_set_rate(struct clk *clk, ulong rate)

I would rather prefer it to be renamed as: <soc>_clk_set_rate() which
is self descriptive.

>  {
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
>
> @@ -113,15 +114,14 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -int msm_enable(struct clk *clk)
> -{
> -       return 0;
> -}
> +static struct qcom_cc_data apq8016_data = {
> +       .set_rate = apq8016_set_rate,
> +};
>
>  static const struct udevice_id gcc_apq8016_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-apq8016",
> -               /* TODO: add reset map */
> +               .data = (ulong)&apq8016_data,
>         },
>         { }
>  };
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index dc64d11ca979..1efb6e2313a5 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -13,6 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <mach/sysmap-apq8096.h>
>
>  #include "clock-qcom.h"
>
> @@ -80,7 +81,7 @@ static int clk_init_uart(struct qcom_cc_priv *priv)
>         return 0;
>  }
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong apq8096_set_rate(struct clk *clk, ulong rate)
>  {
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
>
> @@ -95,15 +96,14 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -int msm_enable(struct clk *clk)
> -{
> -       return 0;
> -}
> +static struct qcom_cc_data apq8096_data = {
> +       .set_rate = apq8096_set_rate,
> +};
>
>  static const struct udevice_id gcc_apq8096_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-apq8096",
> -               /* TODO: add reset map */
> +               .data = (ulong)&apq8096_data,
>         },
>         { }
>  };
> diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> index 6636af98132d..d42b32c3afd3 100644
> --- a/drivers/clk/qcom/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -17,7 +17,7 @@
>
>  #include "clock-qcom.h"
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong ipq4019_set_rate(struct clk *clk, ulong rate)
>  {
>         switch (clk->id) {
>         case GCC_BLSP1_UART1_APPS_CLK: /*UART1*/
> @@ -28,7 +28,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         }
>  }
>
> -int msm_enable(struct clk *clk)
> +static int ipq4019_enable(struct clk *clk)

Ditto, <soc>_clk_enable().

-Sumit

>  {
>         switch (clk->id) {
>         case GCC_BLSP1_QUP1_SPI_APPS_CLK: /*SPI1*/
> @@ -125,6 +125,8 @@ static const struct qcom_reset_map gcc_ipq4019_resets[] = {
>  };
>
>  static struct qcom_cc_data ipq4019_data = {
> +       .enable = ipq4019_enable,
> +       .set_rate = ipq4019_set_rate,
>         .resets = gcc_ipq4019_resets,
>         .num_resets = ARRAY_SIZE(gcc_ipq4019_resets),
>  };
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index b0416a05789d..a9602d0c9ca6 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -28,9 +28,6 @@
>  #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
>  #define CBCR_BRANCH_OFF_BIT     BIT(31)
>
> -extern ulong msm_set_rate(struct clk *clk, ulong rate);
> -extern int msm_enable(struct clk *clk);
> -
>  /* Enable clock controlled by CBC soft macro */
>  void clk_enable_cbc(phys_addr_t cbcr)
>  {
> @@ -160,12 +157,22 @@ static int msm_clk_probe(struct udevice *dev)
>
>  static ulong msm_clk_set_rate(struct clk *clk, ulong rate)
>  {
> -       return msm_set_rate(clk, rate);
> +       struct qcom_cc_data *data = (struct qcom_cc_data *)dev_get_driver_data(clk->dev);
> +
> +       if (data->set_rate)
> +               return data->set_rate(clk, rate);
> +
> +       return 0;
>  }
>
>  static int msm_clk_enable(struct clk *clk)
>  {
> -       return msm_enable(clk);
> +       struct qcom_cc_data *data = (struct qcom_cc_data *)dev_get_driver_data(clk->dev);
> +
> +       if (data->enable)
> +               return data->enable(clk);
> +
> +       return 0;
>  }
>
>  static struct clk_ops msm_clk_ops = {
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 7b3bcf41f421..4c5959b60038 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -47,11 +47,16 @@ struct qcom_reset_map {
>         u8 bit;
>  };
>
> +struct clk;
> +
>  struct qcom_cc_data {
>         const struct qcom_reset_map     *resets;
>         unsigned long                   num_resets;
>         const struct gate_clk           *clks;
>         unsigned long                   num_clks;
> +
> +       int (*enable)(struct clk *clk);
> +       unsigned long (*set_rate)(struct clk *clk, unsigned long rate);
>  };
>
>  struct qcom_cc_priv {
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index e622309b6747..ce83ec741278 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -12,6 +12,7 @@
>  #include <asm/io.h>
>  #include <linux/bitops.h>
>  #include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +#include <mach/sysmap-qcs404.h>
>
>  #include "clock-qcom.h"
>
> @@ -157,7 +158,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         return 0;
>  }
>
> -int msm_enable(struct clk *clk)
> +static int qcs404_enable(struct clk *clk)
>  {
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
>
> @@ -266,6 +267,8 @@ static const struct qcom_reset_map qcs404_gcc_resets[] = {
>  static const struct qcom_cc_data qcs404_gcc_data = {
>         .resets = qcs404_gcc_resets,
>         .num_resets = ARRAY_SIZE(qcs404_gcc_resets),
> +       .enable = qcs404_enable,
> +       .set_rate = qcs404_set_rate,
>  };
>
>  static const struct udevice_id gcc_qcs404_of_match[] = {
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index ccad73b6ff15..7b614f9661f0 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -16,6 +16,7 @@
>  #include <asm/io.h>
>  #include <linux/bitops.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +#include <mach/sysmap-sdm845.h>
>
>  #include "clock-qcom.h"
>
> @@ -72,7 +73,7 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
>         return f - 1;
>  }
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong sdm845_set_rate(struct clk *clk, ulong rate)
>  {
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
>         const struct freq_tbl *freq;
> @@ -224,7 +225,7 @@ static const struct gate_clk sdm845_clks[] = {
>         GATE_CLK(GCC_CPUSS_DVM_BUS_CLK,                 0x48190, 0x00000001),
>  };
>
> -int msm_enable(struct clk *clk)
> +static int sdm845_enable(struct clk *clk)
>  {
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
>
> @@ -264,17 +265,20 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>         [GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
>  };
>
> -static const struct qcom_cc_data qcs404_gcc_data = {
> +static struct qcom_cc_data sdm845_gcc_data = {
>         .resets = sdm845_gcc_resets,
>         .num_resets = ARRAY_SIZE(sdm845_gcc_resets),
>         .clks = sdm845_clks,
>         .num_clks = ARRAY_SIZE(sdm845_clks),
> +
> +       .enable = sdm845_enable,
> +       .set_rate = sdm845_set_rate,
>  };
>
>  static const struct udevice_id gcc_sdm845_of_match[] = {
>         {
>                 .compatible = "qcom,gcc-sdm845",
> -               .data = (ulong)&qcs404_gcc_data,
> +               .data = (ulong)&sdm845_gcc_data,
>         },
>         { }
>  };
>
> --
> 2.42.0
>
