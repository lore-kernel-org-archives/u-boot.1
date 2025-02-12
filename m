Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A77C021A0
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 15:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C295080BAD;
	Wed, 12 Feb 2025 16:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bl3eJ2Pe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FE180BAE; Wed, 12 Feb 2025 16:08:57 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC372809D0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 16:08:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4395dddb07dso5013375e9.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 07:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739372933; x=1739977733; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xdCpsoT4/3MknHpWjl/GXo/MeDPycKMD0O9hflvQOlY=;
 b=bl3eJ2PeyEw0AHQPzznllw73z9AE+cpAaidWeYDSGzY3IfqSNmvs0v71QVt2LSixaY
 o7hFQsB72ZDXEZmFyT5BCQTJAESwmSD8581KEDx9tMypqpV+sbXQDtWtYRMz7hUGZ/26
 rijDVP5afsL1uZPPX+BbwKBAOovlVKQXv36Z0Io9nRi2Rmwnf2Jp7iZs0RIRQXaJ4nwh
 Ouoiusu+SfcRDaehmr++5DdA52RPK5yDOphFTiwaDPo6u8o2XBuUmjKTf4yZTz7UUJMd
 d1jOUnfU478JQEkCIh4awKryMCaYfdZraHouo1hb/hYh8DJYi73s2Y6E9Ew1Vx5ZNjR+
 jgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739372933; x=1739977733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xdCpsoT4/3MknHpWjl/GXo/MeDPycKMD0O9hflvQOlY=;
 b=NemzfP4abVndUU8pCIASVmnl9oEyK7fa/zDnAHeopJ1jFg2oJnv1zzurWaCs7rkyoI
 lazJpOBns/KuLmuADCCafEcEER7HIGPV8/MFAFZCYfSxaHJyHTNGVw/F9iN0Tnpzgwu8
 x9iGt2T9yZAw15VYCIS+/H36sAzNOSAEoxwTE2G786Ny4iMCIaBTdvchUR8FhDWiNAqi
 +KsijYA3G34Pd1dCPm/l/1CQTUsnX5eTuuLi9WAY0km6KR+qNU81T9wuw/2EP6ZV9sHi
 GXm2uPDxSLdfT2uj891kvWpGFapv1RrydXUQqp6bVZi/Ekb6o4TzOENbFo4HyBaedbq/
 XeLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCv+i1YAwZaYW2TXavVlIr4lvayS3dtMXg+VUU43qYAKZvJUkuy/yJ6/qr4HZ3lR4kK17rtEY=@lists.denx.de
X-Gm-Message-State: AOJu0YysC2epGA9LwzBPhZng3UPuDLY/tYK+SlBuVSrryiDEE3NWCWBU
 SR5eQWrd3MjQfOnEgaCBiGz2I7LqK+6VCAM6KtTUCMGWxq24wyi5jAxbFLcPQB8=
X-Gm-Gg: ASbGncveb+BdHBwifEcp+9yGY2/4GBvO4z8bhQLESnvpip5FfS5mouAq0bUHlY5JDww
 /yWLuH861cQVNH0UVt09p2O+TPxG6JgN5cDp63ZbFGUuPaC5U2yU1F6yVBuAzeZX4BNHYK9nfko
 ElFj9N6J4DpdY+4mEQxjjGxJJ6L0q3Bk0a8EHZiwfb1jpCHl4ItBADRSlzocsu3Qk0+8+xXx8WS
 n+UM/sH5dMWS4Li3ItUOHQFQrGPd8xcdck/sPa3QQ/nLw4tJdo6o+G5657vTAxqPbv8b/5+CY2I
 LHHWL/rdDeI4z6wIuWWx2g+P78F3zVLi89Htwaa/Fn3lJCFuSDYPfOBRs40m8h694LOswA==
X-Google-Smtp-Source: AGHT+IFF+KLlsmFtLt5/JJe9IQ1Xsd/frSlDxCwHa/cYZcHgYHVoEyoE0HyeJAo/7hrebgL2sk0fHA==
X-Received: by 2002:a05:600c:4fd1:b0:439:35d2:ed6 with SMTP id
 5b1f17b1804b1-4395816077amr33407055e9.3.1739372933154; 
 Wed, 12 Feb 2025 07:08:53 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1d11:ab01:416b:3913:893e:bb4?
 ([2a0a:ef40:1d11:ab01:416b:3913:893e:bb4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a0725eesm22004095e9.31.2025.02.12.07.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 07:08:52 -0800 (PST)
Message-ID: <83fb637e-e55e-4fc9-821f-af28b6c15d2e@linaro.org>
Date: Wed, 12 Feb 2025 15:08:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dts: ipq9574-rdp433-u-boot: add override dtsi
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, pbrobinson@gmail.com, marek.vasut+renesas@mailbox.org,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
 <20250130053751.3148614-2-quic_varada@quicinc.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250130053751.3148614-2-quic_varada@quicinc.com>
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

Hi Varadarajan,

Sorry for the not getting to this sooner!

On 1/30/25 05:37, Varadarajan Narayanan wrote:
> Add initial support for the IPQ9574 MMC based RDP platforms.
> Define memory layout statically.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Use upstream and override DT instead of own DT
> ---
>   arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>   create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> 
> diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> new file mode 100644
> index 0000000000..71832d350b
> --- /dev/null
> +++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/ {
> +	/* Will be removed when bootloader updates later */

Could you elaborate a little here? Are you referring to when SMEM 
parsing is supported in U-Boot? Or some change in a prior boot stage?
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x40000000 0x0 0x40000000>,
> +		      <0x0 0x4a500000 0x0 0x00100000>;
> +	};
> +};
> +
> +&sdhc_1 {
> +	sdhci-caps-mask = <0x0 0x04000000>;
> +	sdhci-caps = <0x0 0x04000000>;
Please annotate this

> +	resets = <&gcc GCC_SDCC_BCR>;

A comment here explaining why this isn't in the upstream DT would also 
be good.

Kind regards,
> +};

-- 
Caleb (they/them)

