Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B07C48BF6
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 02:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4DB687FBC;
	Tue, 27 Feb 2024 03:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vlZvQ9bq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A02487FBE; Tue, 27 Feb 2024 03:52:25 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 484FE87FAD
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 03:52:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412a9ea61adso4725845e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709002343; x=1709607143; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hDzwr5loYLwdiczTKyI4ZwrH9DitXFOz194Vpb6o5J0=;
 b=vlZvQ9bq7uh5mnJ03Gn0mAZxQnhmg/I3J1eHrB7uMIgPjtNpLiH14BiNFmystL/8AZ
 gV6yMkWZgNs/sRm/GZVoFA+9J/owkhufzum0Q8c6DRmj2diSxuP0TV09fe2Bz/82uh+o
 oDgnLTZMsqBWi1QFsLjO0R2qNiLkk2jvs2eXNAo9wiUcVsfYGBzDtbaas2qEK/kGzdhk
 QwSxyJw9q+N5d0ax9iC+sONKha7FEnnDblYaD2lYYlevRoJHWoZpcNs15GLlxVsl63Xm
 KdQbsQ/mdwrKKl3LwpFAwp9alj/f/J8lsN3lDdcApGvCVYOJf4gYlT3TqpelHFNZJ4z/
 7KlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709002343; x=1709607143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hDzwr5loYLwdiczTKyI4ZwrH9DitXFOz194Vpb6o5J0=;
 b=NgnBGZALNFijWJUNpHzGlBY3cxStT7txL1Ce30jqtqwf8tIhcMI/sUmb4+NNNTLWMh
 srAZflD2cJn/WP+TDlu/JndJqGQAIndCrW+hwokfEvKg0/p/Sd7/KDnmPh1d2HgNEmQ2
 WHHsmSzmjJSqc547tciJMb1i3NwE5f5USYeUtgVY6bUP/M+vaG5yARk1XyiHlMPPIu3Z
 gM06LaDomc+rWInFezghQ7XPxCr4zDF8M7iPsAecZ5FSms5DURF8u684hWcEnsFpCGZ4
 /Eq5ZEOfk835NYv5fwwJ3AByIIyRIOeX2cAe4h2VLNp16HZCW9gsPa1/eUE/rerTTnoB
 g5zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu6iM5hCoBD7Ni03bl7wmMgIj41DRRXUyyZiv+Vo1D9cKHanaaHpgOWl+Y9eqXO8rgjfBL+HFqAoEqe5rhEGZJmXCbDQ==
X-Gm-Message-State: AOJu0YzP4TkHP+jRXfHNro/+liDNXHGKuDg3Kxiv+eWXCK6g/ZWyAOxm
 pkUmrg5Uu9Wlr9U4GoBC92iHhSX0cZG9eUrOcPQ+209aqR093Gc8N9AEN/VrY5s=
X-Google-Smtp-Source: AGHT+IHdCI5yBnUZZvSOh1MatvPn+VK0+uOutG9zkNLbbV3saKKkdbA6ll5wYd1TRkoR8tjTE03RAw==
X-Received: by 2002:a05:600c:358f:b0:412:a7da:8286 with SMTP id
 p15-20020a05600c358f00b00412a7da8286mr2204701wmq.4.1709002342768; 
 Mon, 26 Feb 2024 18:52:22 -0800 (PST)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a05600c3b1a00b00412a5cb5a76sm4149563wms.23.2024.02.26.18.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 18:52:22 -0800 (PST)
Message-ID: <e6d6b02e-4826-4190-817b-f6ad07e4a387@linaro.org>
Date: Tue, 27 Feb 2024 02:52:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] pinctrl: qcom: Include IPQ9574
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
 <20240226100807.1095607-8-quic_varada@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240226100807.1095607-8-quic_varada@quicinc.com>
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
> Add support for IPQ9574 under pinctrl/qcom.
Likewise, squash this into a patch introducing the whole pinctrl driver.
There isn't much to review here while all the actual code is in one huge
patch.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> 
>  drivers/pinctrl/qcom/Kconfig  | 7 +++++++
>  drivers/pinctrl/qcom/Makefile | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 2fe6398147..558a4d9bbd 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -27,6 +27,13 @@ config PINCTRL_QCOM_IPQ4019
>  	  Say Y here to enable support for pinctrl on the IPQ4019 SoC,
>  	  as well as the associated GPIO driver.
>  
> +config PINCTRL_QCOM_IPQ9574
> +	bool "Qualcomm IPQ9574 GCC"
> +	select PINCTRL_QCOM
> +	help
> +	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
> +	  as well as the associated GPIO driver.
> +
>  config PINCTRL_QCOM_QCS404
>  	bool "Qualcomm QCS404 GCC"
>  	select PINCTRL_QCOM
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 6d9aca6d7b..90e85510fa 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_PINCTRL_QCOM) += pinctrl-qcom.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
>  obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
> +obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
>  obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
>  obj-$(CONFIG_PINCTRL_QCOM_QCS404) += pinctrl-qcs404.o
>  obj-$(CONFIG_PINCTRL_QCOM_SDM845) += pinctrl-sdm845.o

-- 
// Caleb (they/them)
