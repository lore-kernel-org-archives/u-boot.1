Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B552D6555F
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 12:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC66C839FA;
	Wed, 17 Dec 2025 13:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nDdSO66u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E39D083AA0; Wed, 17 Dec 2025 13:38:23 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABA3F83979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 13:38:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47789cd2083so31042685e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 04:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765975101; x=1766579901; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PZYyfVzZLpltw6jK2IfLTbBR4RJG79dS5KXtHWzPGfM=;
 b=nDdSO66uZXWBgc6tyHHZV5bBR8crfOs0c+DzrRu9en+MmkhSSi/dTa14mtY2wbmzus
 KvntvXcdGrxDNJs6AjELsIu+35KMR33FEgWf0H0qM0HM97eYeAypqs1JTUAzBYCj2Wxp
 18IPh/JVzjcp1OZTCkLh+7Jk+GdgBMGlXOmfOrYj/1CAMDTdEFxjUny847ePI58nS6CN
 0qwYel9GZELyzbn0krDytqHaRyALIgRwlzleHho/miIiBTwCB7LckTIM9naHyO9Ct/M0
 CCDPf8WQ3vxK/cEw0aJs6JADdaargZZD7NgG1kd7ZCdYm9OLFSjndJGXTvnrjZPyFkB6
 fwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765975101; x=1766579901;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZYyfVzZLpltw6jK2IfLTbBR4RJG79dS5KXtHWzPGfM=;
 b=bw8Vu14DN+vczAxMCl+bgeTLPnCOY4fuaOlLL5W1aQWhOlntovrTzJ6j8+TXJMI//p
 cn+1kEcbao2QXINbj+uDAWZRbRC8Uc4yU5n3jqSHBOp/JCCBsBP/LWmaS3FBg3ilbmGL
 AJlVamTxxuxPiKsHza/gsdP75k1+dq7V0oEi15FmEh5uJeZu9S0Lhn7sUAnTM8yqDPOT
 xzy1mV7IJMBo+nR4tqtCmZn9mE/ZCWWDLVasSur2faPDg8Rf8mj90VlAebXa5MCVGE7e
 dblv0S1+M++MwQ2MuyIj2AzjZL3R1nVa+vvR7c4LXM5gVprAzPd0m7axxkiWV3llixix
 uAsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/rVr4WH2D1HnhnzSFEcEDR2nGARjIhLL90j31OdBrrOK+0L2LSjlqeB1LO9Bz4EIFyohxqnA=@lists.denx.de
X-Gm-Message-State: AOJu0YwXL3v1+JdZ7xoL/x5qet069P1kDvyvDY+HCEet/xN8VwgzBijS
 lsZI4WkPr+MohU+gui34HfQ7vRPZG1yJYFUqI+TQA38lypmHINMpC+mAitYePfdldU0=
X-Gm-Gg: AY/fxX7Fxi5SDcOQp0ceerjw0LNxPYQAWXrd2+bLNd6Fq9iq2gyLLB/9NFMG0N7tBjO
 V5FOearnNpvsRE1WHNGR/oJF6HOaoYnj0FXpdiAnu7WkxXNYPauuCofyw+rH7ie20+zpB3j0cuP
 u8jox9UBIvBlKrL9vvP9Wsv2MvtTzdjq0jrjl8HmFShvXNAakaAxsSvmyHOyvSpE55/55V4sN71
 +1iyYGX8lGmW97/5sSauLnsIpTfSeGW4WhpyLW+IBo4sd8VbDiptxcB1n07DLvZghBi9OkKlXHD
 U5zwlr1J1GG7hKdeGGWmc06xNXwetm2JqUv44yMSJH4pqeAoYpsfJezGM2A0xQkEIdrXV/3bEjE
 yM6LnHI1oiIJluwzyCR4ZFOJ5UkiXWNjjDMmjfb+dBSv0xjabKaZvnqsLZ5QSvrf/c4Ju11S8np
 qTGaCc57m/FHUz10Gf6n8TLkQDQK8S0iYz9rJa+ztXVAaEhbtKudDJ3d9qw+GnZormIXNx
X-Google-Smtp-Source: AGHT+IErJm0ft8eqdtErFELmxmoI6GYRflJVWlQRQ+wsX2z2xAjYXC9C4+tigOP6JHTCcwQDwLNe/g==
X-Received: by 2002:a05:600c:46cf:b0:475:dd8d:2f52 with SMTP id
 5b1f17b1804b1-47a8f9155bamr170390405e9.32.1765975101069; 
 Wed, 17 Dec 2025 04:38:21 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1236:7c01:43a2:9012:56dd:2d0c?
 ([2a0a:ef40:1236:7c01:43a2:9012:56dd:2d0c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47bdc1e6306sm36616755e9.11.2025.12.17.04.38.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 04:38:20 -0800 (PST)
Message-ID: <a9021cf3-5646-4c5c-b0df-e8a023821c29@linaro.org>
Date: Wed, 17 Dec 2025 13:38:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: qcom_qcs615: Correct debug UART clock
 frequency
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 aswin.murugan@oss.qualcomm.com, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251119152312.4175482-1-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20251119152312.4175482-1-balaji.selvanathan@oss.qualcomm.com>
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



On 11/19/25 16:23, Balaji Selvanathan wrote:
> Adjust the debug UART clock frequency from 14745600 Hz to 7372800 Hz
> for the QCS615 platform. This correction ensures proper UART
> communication timing and resolves baud rate miscalculations
> that affects early boot console output.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   configs/qcom_qcs615_defconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 2468267b955..f0362aa6976 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -12,7 +12,7 @@ CONFIG_DEBUG_UART=y
>   CONFIG_DEBUG_UART_ANNOUNCE=y
>   CONFIG_DEBUG_UART_BASE=0x880000
>   CONFIG_DEBUG_UART_MSM_GENI=y
> -CONFIG_DEBUG_UART_CLOCK=14745600
> +CONFIG_DEBUG_UART_CLOCK=7372800
>   
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
>   

