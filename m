Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC73CE8E70
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 13:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BE688F16;
	Thu, 24 Oct 2024 15:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Js+M56+U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E0E688E96; Thu, 24 Oct 2024 15:11:22 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B4B488F16
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 15:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5cb6704ff6bso1130330a12.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729775473; x=1730380273; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZaZeQunFtRJOWa+3VSkMHZyVIvgNoGzhltGFYt9Ypu4=;
 b=Js+M56+U483xk30Hpo5/jm1qJ84pQtvqQLCzs/+xUlHBpllel7sAV1c4Qc6zpXsVND
 1UqfAXE0cU6iYGq19U3n0KggybT/2+dxYhQbrmQY46SPCrStRrbAiMYgHQSqxKi3L1Y6
 45SlyZ+JC1Q5scJy8sZaCaVVQAU1DsCMaaCme4UGPtrLW76EvTd5WfuB2ScuP12MaqAg
 msJcaaQfkab9+NgV2dmZ6PLs8sQzBJ1k9MbjOBXErdyBKzHdgQ4Ai2yN7AexpYfjZfMY
 Cg7tHmX0yeuC1WPh18B64yFgcjY7na8Chi1akxeCVdoAxp7IfFcx6dAlhntiiQ5nwNho
 vo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729775473; x=1730380273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaZeQunFtRJOWa+3VSkMHZyVIvgNoGzhltGFYt9Ypu4=;
 b=ZI0b41DWk3hXMYVWht+CI7Nd5pgnC5/Q4wfyK0U6kuRAlmYEj+NDtJWpyyhym1nn+U
 yfv7i9/KMC64ZAN01hSllzfIa1GUZ3Cb5rymTWn+McliKVt3/ikIDCo4ZIP2iCEPB7XB
 F2u5E4tXVGV4dZPdnawsPMVrTs+e5cZOs5y6VCihl32VFonYNuwBFy+DgofyjYzQalHC
 Qf4KfGojehOqeEjsIOJx4FhU2v5W1RtZY2pNXsyfixgU17ITfY6IoaL9NK4kSgXB/KD5
 M4daYrR6u+VpJzjQngUGCfeHZtt0meQEnGBLsXNBTjHDCplVnFENAmo237mJAFTH/SUs
 Nsgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC1cgwso+BWNftzr0615S4LrPt30K//F3WBkLwAytwxNRM/OQxe99HsBGNZPnckED+Ld5Ung4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxkf3ksY204hGaJTKhX6pco0JkhmvL1ijfnmsINBEcdYLNOZkOq
 V/Z9g8K4mRJX/wBLbk98ocWtdS5JuSWTPhDrBNb9khgnF5ioYMsP1py4jL5vqOM=
X-Google-Smtp-Source: AGHT+IFRDI21mwfexMi+bJ8QX4zSHcyqBGhCHtFhzQMOkEzDNsO0YhjlWmHtMF+Mw4SUgBRXIpxBzw==
X-Received: by 2002:a17:907:7e83:b0:a9a:714:4393 with SMTP id
 a640c23a62f3a-a9abf88947bmr478365966b.23.1729775473233; 
 Thu, 24 Oct 2024 06:11:13 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::4? ([2a02:8109:888d:ff00::4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a912edc07sm612969566b.69.2024.10.24.06.11.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2024 06:11:12 -0700 (PDT)
Message-ID: <cd028a77-c645-403b-9f2e-9ad2943ea146@linaro.org>
Date: Thu, 24 Oct 2024 15:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: msm_sdhci: enable vqmmc at probe if available
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241016-topic-sm8x50-mmc-vqmmc-v1-1-767af5351d37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Neil,

On 16/10/2024 11:17, Neil Armstrong wrote:
> On earlier platforms, the vqmmc regulator was enabled by the
> previous bootloader, but on the newest (SM8650) it's not
> and we need vqmmc to be enabled in order to have the card
> to respond.

Isn't/shouldn't this be handled in mmc_power_init() ?

Kind regards,
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/mmc/msm_sdhci.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index 4e5c932c071..27bb7052fca 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -15,6 +15,7 @@
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <linux/bitops.h>
> +#include <power/regulator.h>
>   
>   /* Non-standard registers needed for SDHCI startup */
>   #define SDCC_MCI_POWER   0x0
> @@ -43,6 +44,7 @@ struct msm_sdhc {
>   	struct sdhci_host host;
>   	void *base;
>   	struct clk_bulk clks;
> +	struct udevice *vqmmc;
>   };
>   
>   struct msm_sdhc_variant_info {
> @@ -163,6 +165,16 @@ static int msm_sdc_probe(struct udevice *dev)
>   	if (ret)
>   		return ret;
>   
> +	/* Get the vqmmc regulator and enable it if available */
> +	device_get_supply_regulator(dev, "vqmmc-supply", &prv->vqmmc);
> +	if (prv->vqmmc) {
> +		ret = regulator_set_enable_if_allowed(prv->vqmmc, true);
> +		if (ret) {
> +			printf("Failed to enable the VQMMC regulator\n");
> +			return ret;
> +		}
> +	}
> +
>   	var_info = (void *)dev_get_driver_data(dev);
>   	if (!var_info->mci_removed) {
>   		ret = msm_sdc_mci_init(prv);
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-sm8x50-mmc-vqmmc-b7cf8176ec51
> 
> Best regards,

-- 
// Caleb (they/them)

