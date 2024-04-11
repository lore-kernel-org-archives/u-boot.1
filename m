Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18668C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 13:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4174D88005;
	Thu, 11 Apr 2024 15:59:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HPrI/rT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13E6A881F1; Thu, 11 Apr 2024 15:59:38 +0200 (CEST)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com
 [IPv6:2607:f8b0:4864:20::92c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2FBB88005
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 15:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7e3555015a8so2863832241.3
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712843974; x=1713448774; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NlwB33NUOtKSs4vh3Sb6L20P8tS3ku5TA43b+FOcgjk=;
 b=HPrI/rT8mbTwltkRlsZLSKtvcOqKN4ik98ks5p9yv1ejQSKipUpHFM9ut+S91Ib0fo
 MShZcYIJIvTnLmFNyp82LmK36kvgE9fTy1HScKup3stGN7BsH1bjzKyCX4Oonitn9MjA
 BSyo66O6CAEhf7VM1iKCsHcsfR+m3YAr7KiDd/x+FrPAIIkVs7c41NhGP84CW+fgOq/S
 qI5gdbK/yehYItqC7alXFFEOZk8SYO4wbecqikxn0A7mVCLw7Yb9gtWTvpVEDEPnmxIh
 mzSrVTQG64dx78Zog7+J2FcUue7BkthCEgat0fxhj1f+819Cup/zf+3QPYE2CUGA7RXQ
 X/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712843974; x=1713448774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlwB33NUOtKSs4vh3Sb6L20P8tS3ku5TA43b+FOcgjk=;
 b=K1VXVaIhPk1vrngpWOv5mj12EZT6Te760jowij80SHf23zcFHzSSrVgap6xAWXtZ74
 m9Z+6myzI0QBJCYItNBO+fEI+PIS7xSuvvllejHTqdCjYhsMby3G2OPiMB8UqyADbulC
 uJLkeq6PSsc/hWmQrXnpmldxNvyTIDC1cBA3MeyETf5jGn9SnEcMZvFwNmxleGN0xQZX
 aK8NEtjliIW1nV2h5A9THCM+2Zeq7ifW/cMM7UH6QE7ZMF7lDietFf8hI3kvHyvl5Ko2
 JU6F+2g2wGaxfjVKYXcyjeIjG/vzDc3LwmleALEjCBZzQV324xcNVkLakDI806lUMU7G
 /EIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMOajArnJAWiPU20Lhu50rBqL07+MTu961K/2bVDlXU3xZKOa3GRs5cUluTXbTZ1R8X7sc43aHupMkPl5J0ubaXupTWw==
X-Gm-Message-State: AOJu0Yz0+Atq7by/3nafITvmFnVdRagbS8uYaEnXFPCzhJYVUS5lxMwQ
 g4EbBQ6AoUPG8BJxwCsWV0jN72QUXmYnjPgk1zxCLAfJgLziVUHjIaqzAXfHTkalDRtCCK8pEoL
 9DlS769kPah9vbTfqgsrDJW6MYh/ghf1bCnpjrA==
X-Google-Smtp-Source: AGHT+IErcznOk+6iGXDnbZn491NxI8WTzlbUx3YlJlC+EPxOVUhpxH021FOu526cYDd5wppwpCyT0l3WNIynOMOAqgg=
X-Received: by 2002:a05:6102:1507:b0:47a:28a8:48de with SMTP id
 f7-20020a056102150700b0047a28a848demr5200846vsv.5.1712843974619; Thu, 11 Apr
 2024 06:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
 <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-1-5039164ecbf7@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 11 Apr 2024 19:29:23 +0530
Message-ID: <CAFA6WYO+3VroUdFUVH390taViQX8pMQrOQDTSn0yU6BD5YY53A@mail.gmail.com>
Subject: Re: [PATCH 1/7] mmc: msm_sdhci: correct vendor_spec_cap0 register for
 v5
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de
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

On Tue, 9 Apr 2024 at 23:33, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> The V4 and V5 controllers have quite varied register layouts. Inherit
> the register offsets and naming from the Linux driver. More version
> specific offsets can be inherited from Linux as needed.
>
> Fixes: 364c22a ("mmc: msm_sdhci: Add SDCC version 5.0.0 support")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/mmc/msm_sdhci.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>

This patch broke booting on the HMIBSC board, have you tested it on
db410c? It's very likely that this has caused regression there too.

Error observed:

sdhci_send_command: Timeout for status update: 00000000 00000001

-Sumit

> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 059cb3da77c5..f23d425144ef 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -32,11 +32,8 @@
>  #define SDCC_MCI_STATUS2 0x6C
>  #define SDCC_MCI_STATUS2_MCI_ACT 0x1
>  #define SDCC_MCI_HC_MODE 0x78
>
> -/* Non standard (?) SDHCI register */
> -#define SDHCI_VENDOR_SPEC_CAPABILITIES0  0x11c
> -
>  struct msm_sdhc_plat {
>         struct mmc_config cfg;
>         struct mmc mmc;
>  };
> @@ -48,8 +45,10 @@ struct msm_sdhc {
>  };
>
>  struct msm_sdhc_variant_info {
>         bool mci_removed;
> +
> +       u32 core_vendor_spec_capabilities0;
>  };
>
>  DECLARE_GLOBAL_DATA_PTR;
>
> @@ -180,9 +179,9 @@ static int msm_sdc_probe(struct udevice *dev)
>          */
>         if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
>                 caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
>                 caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
> -               writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
> +               writel(caps, host->ioaddr + var_info->core_vendor_spec_capabilities0);
>         }
>
>         ret = mmc_of_parse(dev, &plat->cfg);
>         if (ret)
> @@ -243,12 +242,16 @@ static int msm_sdc_bind(struct udevice *dev)
>  }
>
>  static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
>         .mci_removed = false,
> +
> +       .core_vendor_spec_capabilities0 = 0x21c,
>  };
>
>  static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
>         .mci_removed = true,
> +
> +       .core_vendor_spec_capabilities0 = 0x11c,
>  };
>
>  static const struct udevice_id msm_mmc_ids[] = {
>         { .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
>
> --
> 2.44.0
>
