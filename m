Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64B7C48BF6
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 03:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F43C87FA6;
	Tue, 27 Feb 2024 04:04:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b4OGrSb1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E57187FA7; Tue, 27 Feb 2024 04:04:23 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4819187F9E
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 04:04:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412a87f0d8eso8082215e9.2
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 19:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709003060; x=1709607860; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6KdF1Svt3bCUXQ60CK/fKpGOjBjuMOBF6q2JIdtHJD0=;
 b=b4OGrSb1JaCJuJAOgg06ibIbbfc6vfbV5RGGkh7eETE6tWKa1gZK364M+K0mwlOmY9
 mC2L8o0DdNx/MJ79HGTDymp/+paGnccFu1GGWFUgxTERhmKz6taYDcbwdtUTPI2ECzyu
 EBgrfBd+G3YjpWfEJsmjyy2ghdO05sz8ZICmyaQSki6SQZrbFFatgeQ9Rk4GG3B3aU4V
 stzs8mvrkCuUSzWkq6NuT0Wiz2KONtBObFMLg71O2AfpovOaTj2lvZrHfbGm5ow50pyZ
 9q5aQGcGvAAFgRnlA687+zRd621M3MUMSLxR3xSQVgoIe7ka60+CRFhfczgOT6PPeu0L
 RMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709003060; x=1709607860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6KdF1Svt3bCUXQ60CK/fKpGOjBjuMOBF6q2JIdtHJD0=;
 b=JrEjr0r84jfo3xCBNMBMh112xE6u5V81yMlvP2f0ojyK8mppSrB4XilIUNVJtT17B9
 wdzvySAiKxMQ9N73cj3JgkIpZMY+OGDKnYy39nvY/474akhePl6ZtY09U931GqX0u0mi
 NH2ANCIkJfmX8VQzykj7iTag+YhvpTIPNHE6Powd/SnRycys7CJGtiTjnrEWw37Pu5aW
 UEIPs/LuXnhrt8nCy60Y8da9EoIzco2M/Q5PsxbtoHm8tEuNMgOkkL7vPT01OwJdqWxK
 APulPhDcZ0y8wMvh2pM7g7yFfzaqGGIP8FDWNSH3VMVZH0ukOD5g73oojav4cbPe7Xrg
 k+3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxaHVKxkNg7CcxxuKKr9hTeAey/ymEe2wlMOTrUyPNQMnxG1JGMg7YSdQn4ay2BythJ44Mc+i7aJqAomqPWtdEYT9aAA==
X-Gm-Message-State: AOJu0YwHSaTy6zGbfwnZhMwyhknzNO4KnOAqL4fTTQu9dSfA2++mSqng
 NMAoqNXj0VWD9RTUKvCNEht9tiSBGuvpsCyIcUb36MEzaUtBj4Gvl/AoO/wsdi4=
X-Google-Smtp-Source: AGHT+IEo9wL9nAbVg9zAc9hoeSMVcajG2OxICXRnMBfnDIjjUOzFdGgkWWKNHEh8RoNeymZSHRJXWQ==
X-Received: by 2002:adf:f089:0:b0:33b:187c:4ca0 with SMTP id
 n9-20020adff089000000b0033b187c4ca0mr5322595wro.62.1709003060501; 
 Mon, 26 Feb 2024 19:04:20 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 cl7-20020a5d5f07000000b0033dc931eb06sm7163600wrb.0.2024.02.26.19.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 19:04:20 -0800 (PST)
Message-ID: <2bcd24b3-7b2c-46fe-b6bb-8b61068f14c2@linaro.org>
Date: Tue, 27 Feb 2024 03:04:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] mmc: msm_sdhci: Handle different vendor cap
 register offsets
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-9-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-9-quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
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



On 26/02/2024 10:08, Varadarajan Narayanan wrote:
> In the IPQ9574, the vendor capabilities register is at a
> different offset than in other SoCs. Hence add a vendor_cap
> field to msm_sdhc_variant_info structure to get the correct
> register offset.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
With below feedback addressed, please add

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
>  drivers/mmc/msm_sdhci.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
> index fe1e754bfd..9285d412fe 100644
> --- a/drivers/mmc/msm_sdhci.c
> +++ b/drivers/mmc/msm_sdhci.c
> @@ -48,6 +48,7 @@ struct msm_sdhc {
>  
>  struct msm_sdhc_variant_info {
>  	bool mci_removed;
> +	u32  vendor_cap;	/* Non standard (?) SDHCI register */
>  };
>  
>  DECLARE_GLOBAL_DATA_PTR;
> @@ -158,7 +159,7 @@ static int msm_sdc_probe(struct udevice *dev)
>  	if (core_major >= 1 && core_minor != 0x11 && core_minor != 0x12) {
>  		caps = readl(host->ioaddr + SDHCI_CAPABILITIES);
>  		caps |= SDHCI_CAN_VDD_300 | SDHCI_CAN_DO_8BIT;
> -		writel(caps, host->ioaddr + SDHCI_VENDOR_SPEC_CAPABILITIES0);
> +		writel(caps, host->ioaddr + var_info->vendor_cap);
>  	}
>  
>  	ret = mmc_of_parse(dev, &plat->cfg);
> @@ -219,15 +220,23 @@ static int msm_sdc_bind(struct udevice *dev)
>  
>  static const struct msm_sdhc_variant_info msm_sdhc_mci_var = {
>  	.mci_removed = false,
> +	.vendor_cap = SDHCI_VENDOR_SPEC_CAPABILITIES0,
>  };
>  
>  static const struct msm_sdhc_variant_info msm_sdhc_v5_var = {
>  	.mci_removed = true,
> +	.vendor_cap = SDHCI_VENDOR_SPEC_CAPABILITIES0,
This is wrong, it should be 0x21c for all v5 controllers (see
drivers/mmc/host/sdhci-msm.c in Linux).
> +};
> +
> +static const struct msm_sdhc_variant_info msm_sdhc_v5_ipq_var = {
So this can be dropped
> +	.mci_removed = true,
> +	.vendor_cap = 0x21c,
>  };
>  
>  static const struct udevice_id msm_mmc_ids[] = {
>  	{ .compatible = "qcom,sdhci-msm-v4", .data = (ulong)&msm_sdhc_mci_var },
>  	{ .compatible = "qcom,sdhci-msm-v5", .data = (ulong)&msm_sdhc_v5_var },
> +	{ .compatible = "qti,sdhci-msm-v5", .data = (ulong)&msm_sdhc_v5_ipq_var },
This can be dropped too.

For future reference as I really don't want to deal with these, please
never submit a patch using or otherwise referencing a compatible string
starting with "qti,". There is never a reason such a compatible should
appear in upstream code or DT.
>  	{ }
>  };
>  

-- 
// Caleb (they/them)
