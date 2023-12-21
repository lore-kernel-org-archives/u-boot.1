Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F47C35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:14:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B340587860;
	Thu, 21 Dec 2023 17:14:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k1oP/Oc6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 436B887897; Thu, 21 Dec 2023 17:14:44 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4490887860
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c60dfa5bfso11125385e9.0
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703175281; x=1703780081; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7CHpftek0nDIT71zY0J2Sk0CoxkuYTeFF/iLQyqoYjY=;
 b=k1oP/Oc6ngDIALdinm/qVm9AKcwyplzWefxVAg0d6gGEXjLEEAHuGwyD85K29kgUFG
 wTjL7NX5cAK+sOjT6txy5cQ3dfGz7KSWHB1uzZG/9dUvtCPY2HMuKfgjBVs887jKC76u
 vzpk0KjG1xQoFC8yUAp1Ni4GWQcaVY1jPKPREqwmOChAhuoZoIM94U41FvnzmZJS5Efo
 jHQ5zhKD3Ux/Wqo03fB8ovlgn/4/wO6uLlA2+GWHMId5o7Q0nsn8J3boPKJKGH2dadCq
 P5yNhLCOA0ZnW+BOuFwNV/L8zqpPqcHS81MrWgkQhXAZLU+CzvEQmgaBAQH0RNCqtZpW
 IoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703175281; x=1703780081;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7CHpftek0nDIT71zY0J2Sk0CoxkuYTeFF/iLQyqoYjY=;
 b=wp3zRRf1mflRkuQ5YyYWBxxh5w0Ng0bLiZcKzLHLjxD2KwzwxjqXlugbcmuPn400Ol
 hTDPd0cyhAnzKw9AJjwxgmyYhLaTig4c77UUCc7eN/bsIYSUoZHzdkLZZO5DDlIf6zmt
 pcY15W2Cf2v1Y4X6RpT0OHXYK2nTt/C6Qvo1TwJSLkDKgXY95tp3tJTKN4W1ioFBYaMt
 A+STT/QWCyvb0PWLjZR3RTnkTyelw8S06EA04WLVVTrgOU/zYMxJUw4xRUMGOAZVFlI0
 SU8wXa83V04BfXeVKW+fd0Y1S5jdWxeKhGz7kyFo57wLNvOomEDRjt4Da9lHBGUfno9X
 nZCQ==
X-Gm-Message-State: AOJu0Ywk0U4cPA6p9sYA2NX9W4XHnjKRglWrDgw5gZadmUCpzpBD/MgY
 QxFQOPcI8H2c8oWVJRDQjC5m6A==
X-Google-Smtp-Source: AGHT+IFzZBLF/xzOD23wqH0nwTAzBasU8t5KG/DHMR6l9JDEk8kKloCvrq1Palj018ttde1zpTV7yA==
X-Received: by 2002:a05:600c:3f8e:b0:40d:3b88:451b with SMTP id
 fs14-20020a05600c3f8e00b0040d3b88451bmr850985wmb.157.1703175280692; 
 Thu, 21 Dec 2023 08:14:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm3865415wmq.27.2023.12.21.08.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:14:40 -0800 (PST)
Message-ID: <1c067ef6-a084-48e7-a4f6-33a30b74a84d@linaro.org>
Date: Thu, 21 Dec 2023 17:14:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 02/32] usb: dwc3-generic: support external vbus
 regulator
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-2-b6dd9704219e@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20231219-b4-qcom-common-target-v2-2-b6dd9704219e@linaro.org>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 19/12/2023 17:04, Caleb Connolly wrote:
> Add support for a vbus-supply regulator specified in devicetree. This
> provides generic support to avoid hardcoded GPIO configuration in board
> init code.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> This patch has no dependencies
> 
> Cc: Marek Vasut <marex@denx.de>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 744fde806948..e66e7961c70f 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -21,6 +21,7 @@
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>   #include <malloc.h>
> +#include <power/regulator.h>
>   #include <usb.h>
>   #include "core.h"
>   #include "gadget.h"
> @@ -47,6 +48,7 @@ struct dwc3_generic_priv {
>   struct dwc3_generic_host_priv {
>   	struct xhci_ctrl xhci_ctrl;
>   	struct dwc3_generic_priv gen_priv;
> +	struct udevice *vbus_dev;
>   };
>   
>   static int dwc3_generic_probe(struct udevice *dev,
> @@ -240,6 +242,13 @@ static int dwc3_generic_host_probe(struct udevice *dev)
>   	if (rc)
>   		return rc;
>   
> +	rc = device_get_supply_regulator(dev, "vbus-supply", &priv->vbus_dev);
> +	if (rc)
> +		debug("%s: No vbus regulator found: %d\n", dev->name, rc);
> +
> +	if (priv->vbus_dev)
> +		regulator_set_enable(priv->vbus_dev, true);
> +
>   	hccr = (struct xhci_hccr *)priv->gen_priv.base;
>   	hcor = (struct xhci_hcor *)(priv->gen_priv.base +
>   			HC_LENGTH(xhci_readl(&(hccr)->cr_capbase)));
> @@ -256,6 +265,9 @@ static int dwc3_generic_host_remove(struct udevice *dev)
>   	if (rc)
>   		return rc;
>   
> +	if (priv->vbus_dev)
> +		regulator_set_enable(priv->vbus_dev, false);
> +
>   	return dwc3_generic_remove(dev, &priv->gen_priv);
>   }
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
