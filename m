Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD04CC47DDF
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 10:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C2CF87C4F;
	Thu,  1 Feb 2024 11:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fod88D/h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1891287C4B; Thu,  1 Feb 2024 11:20:43 +0100 (CET)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com
 [IPv6:2607:f8b0:4864:20::936])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E84687C4F
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 11:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe5844so390319241.0
 for <u-boot@lists.denx.de>; Thu, 01 Feb 2024 02:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706782839; x=1707387639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=z8nUVh4H2mWfotFN+Xy6MLd6Lc4OMsJZAtZR/9loID8=;
 b=Fod88D/hG7lIkJwRvxPagIXMZ6Tx3lBwM21RwmTfhjRJgOT6/SjmIs09/Ei/4bDr38
 PcG92DS/Wd3c5XFGDqpod1CkXzpn5Wu98qcFDBXGJdDCRvJTdht9lKqM5h/egQzszo35
 n04X7w7VdI7JiqHLlU7BRNqfIOBpGE0/J0kt7nfRfSS3orCmmFJQIfEguodBsK4dGAB3
 7SQGPIJLO1qmD5oXTGZrNdjmVj8csAp+PqavY10S8MmuFVXOjknMV4SRg2e5+x6aosom
 Q3f2WTgpzAAFna05SvNDCtUJSg8G2e22o8hzL/0Be4ELIbHpDSHKDO2o3bAWx4pyQMjj
 VxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706782839; x=1707387639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z8nUVh4H2mWfotFN+Xy6MLd6Lc4OMsJZAtZR/9loID8=;
 b=FYMzIHrJptZwb2zwTygWx2JKO2IdP5OfcpQsAXxULSG3GhTnR/oRCwbKRBSvGGaFrJ
 8laDDc7ji2BMkwoek8Qs/rZqSInJen2SWYR5f5iJCIUlqjNlhpf1wQN9xrYUGhk+ddSk
 rGyAh30t+tY5oMQHrdVOJWFzyHo1trsXhxmdyoE+0NI+lzwMHO5FiRn3IK2FP4iulXo5
 xnfF54jW6dvwU2NVUOOtgdUZEROs2i/P+shwETtbf/eA87/hAlLN/W7QNqXOcvzYg0J5
 03QEvt+pxwEllZaz7pqd2Dxhz47X6N64tKMp90nFtCfQVgboShoXhbjs6+OSlgJ+Je9t
 BeWw==
X-Gm-Message-State: AOJu0YwAzzRGjJZGpwJeNweD/+lnPTxKBj9gn7gJ6LU8AZhfTD2Hbslc
 HhjdRAHtCkKWKSPP8DILiN+TwbE3jQ/Lz97A48meE6P0P9QWxkRc9D8Auu8zpBn680Gymo5NuGK
 lC2IR1GHuuUe3pk6HGBrYQGZ469vUiSyc7GiHNQ==
X-Google-Smtp-Source: AGHT+IEbUsm7okx83J4KhzAe5rjsCxfFNzsV77U2RMNh/CdabarDI9pkZHZP7re0lKTX+tNCMRi1Te4YjMBBL8RGomM=
X-Received: by 2002:a05:6102:30a9:b0:46b:303d:471a with SMTP id
 y9-20020a05610230a900b0046b303d471amr4006524vsd.31.1706782838932; Thu, 01 Feb
 2024 02:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
 <20240130-b4-qcom-common-target-v3-35-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-35-e523cbf9e556@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 1 Feb 2024 15:50:27 +0530
Message-ID: <CAFA6WYMFU3Dc5jvPtaFgsORCPgkLArs6D=UnQhRco=FpFrnceA@mail.gmail.com>
Subject: Re: [PATCH v3 35/36] pinctrl: qcom: fix DT compatibility
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
> Upstream devicetrees label GPIOs with "gpioX", not "GPIO_X", fix this
> for SoCs where we're now using upstream DT.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-apq8016.c | 26 +++++++++++++-------------
>  drivers/pinctrl/qcom/pinctrl-apq8096.c | 16 ++++++++--------
>  drivers/pinctrl/qcom/pinctrl-qcs404.c  | 16 ++++++++--------

Following diff is also required to get rid of pinctrl errors on QCS404:

diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c
b/drivers/pinctrl/qcom/pinctrl-qcs404.c
index 2718afc7859f..a6efadd99f28 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
@@ -23,7 +23,9 @@ static const char * const msm_pinctrl_pins[] = {
 };

 static const struct pinctrl_function msm_pinctrl_functions[] = {
-       {"blsp_uart2", 1},
+       {"gpio", 0},
+       {"blsp_uart_tx_a2", 1},
+       {"blsp_uart_rx_a2", 1},
        {"rgmii_int", 1},
        {"rgmii_ck", 1},
        {"rgmii_tx", 1},

-Sumit

>  3 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 8e698085d78b..bcff6abca4a0 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -14,18 +14,18 @@
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const char * const msm_pinctrl_pins[] = {
> -       "SDC1_CLK",
> -       "SDC1_CMD",
> -       "SDC1_DATA",
> -       "SDC2_CLK",
> -       "SDC2_CMD",
> -       "SDC2_DATA",
> -       "QDSD_CLK",
> -       "QDSD_CMD",
> -       "QDSD_DATA0",
> -       "QDSD_DATA1",
> -       "QDSD_DATA2",
> -       "QDSD_DATA3",
> +       "sdc1_clk",
> +       "sdc1_cmd",
> +       "sdc1_data",
> +       "sdc2_clk",
> +       "sdc2_cmd",
> +       "sdc2_data",
> +       "qdsd_clk",
> +       "qdsd_cmd",
> +       "qdsd_data0",
> +       "qdsd_data1",
> +       "qdsd_data2",
> +       "qdsd_data3",
>  };
>
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -42,7 +42,7 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
>                                         unsigned int selector)
>  {
>         if (selector < 122) {
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>                 return pin_name;
>         } else {
>                 return msm_pinctrl_pins[selector - 122];
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> index d64ab1ff7bee..f2eeb4cf469a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> @@ -14,13 +14,13 @@
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const char * const msm_pinctrl_pins[] = {
> -       "SDC1_CLK",
> -       "SDC1_CMD",
> -       "SDC1_DATA",
> -       "SDC2_CLK",
> -       "SDC2_CMD",
> -       "SDC2_DATA",
> -       "SDC1_RCLK",
> +       "sdc1_clk",
> +       "sdc1_cmd",
> +       "sdc1_data",
> +       "sdc2_clk",
> +       "sdc2_cmd",
> +       "sdc2_data",
> +       "sdc1_rclk",
>  };
>
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -37,7 +37,7 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
>                                         unsigned int selector)
>  {
>         if (selector < 150) {
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>                 return pin_name;
>         } else {
>                 return msm_pinctrl_pins[selector - 150];
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index ac00afa2a1f4..2718afc7859f 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -13,13 +13,13 @@
>  #define MAX_PIN_NAME_LEN 32
>  static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>  static const char * const msm_pinctrl_pins[] = {
> -       "SDC1_RCLK",
> -       "SDC1_CLK",
> -       "SDC1_CMD",
> -       "SDC1_DATA",
> -       "SDC2_CLK",
> -       "SDC2_CMD",
> -       "SDC2_DATA",
> +       "sdc1_rclk",
> +       "sdc1_clk",
> +       "sdc1_cmd",
> +       "sdc1_data",
> +       "sdc2_clk",
> +       "sdc2_cmd",
> +       "sdc2_data",
>  };
>
>  static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -49,7 +49,7 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
>                                        unsigned int selector)
>  {
>         if (selector < 120) {
> -               snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +               snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>                 return pin_name;
>         } else {
>                 return msm_pinctrl_pins[selector - 120];
>
> --
> 2.43.0
>
