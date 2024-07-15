Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80BC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 12:29:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB54F8882C;
	Mon, 15 Jul 2024 14:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BRD4j35y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E7EE88831; Mon, 15 Jul 2024 14:29:39 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE6A887E2
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 14:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3679df4cb4cso2660891f8f.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 05:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721046577; x=1721651377; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wEeAyIRJst9sDxyqsdKoPQlrbIwLQPAbxc6P2ys/4IM=;
 b=BRD4j35y9fLeznsA+SoNN+LbvTrag+Q7VjkKyfB8pk0f/4s0ZcZePS1G3xoC8xgKx4
 +6o502V7PfXwOWMp2SnZb5jR9/54OLfsOcGVHN74mZ1VVVgtB+RywY6e6/7k4PAg6u08
 GxfkUPVBv/T3L16Dqy+xF3ptDFuitXiWLfnio7M7utOqPyXyoZnuPRJL2xaAdcpw1mHQ
 eSYRnNl9dHPg5jX4FrCx6dYyjCfGHCtMu4+hvLZ7ZmtdZIqTCKiohk3sZmw3iNMfQegG
 UIlF8iib1r8oTTGi0uX/yVtjQormd2qvsyc/QVFIy7+1d3x1IzHAf7/3eEhdyXrUWqHi
 GLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721046577; x=1721651377;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wEeAyIRJst9sDxyqsdKoPQlrbIwLQPAbxc6P2ys/4IM=;
 b=QNAPbqf0RqB+OGqi36yJeHKnDody13D6pBSMJHnXFawVAHBH3XTo/q2sL8uEs/l/3w
 lLzl6Z58oeDo2tooUScNkx7SZrPvJ3FNfvoAmwqTIYaQEbmp6/lS26JBtKn4zP0q6KJ5
 n9NBVauMB98a6BHRnh53F30Q3gUIQpPF+Ff+QJ1VGeQ0Ewov3Rtm12uhX2Dg3gxGqEPP
 09lX4OGiwipkKNSmjmknio/RdDu4Iryr/+ZB4i3L5Cq0FZh3JVEEirjUNCG9rUnUKBDJ
 LtTI4SixIXckZn4GXE/VwKSauauG6t4MZVmtif2LVvsyDvWxIyddhL7ocqjhpdrixKan
 cZ8w==
X-Gm-Message-State: AOJu0YxF5co6J7E9vw9d0BXRSk9zfqQmuRvKI9/UbYywQ/DymTA4H0az
 v6+zVmh4xX1TsfX+lF6/0k3Bwj/D6/BJO8xSjwOxct1buzF4XxTbZz68JKZV76A=
X-Google-Smtp-Source: AGHT+IHqM+z4YRdoN4gIL/J5x2AKoSTF4SbBkxzUXrcp4RBxbuZQSTPcwdXvbYckuvi7EE7W6ZYj/A==
X-Received: by 2002:a5d:584d:0:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-367ff705388mr10160841f8f.21.1721046576807; 
 Mon, 15 Jul 2024 05:29:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:79bb:5f59:8e51:52d4?
 ([2a01:e0a:982:cbb0:79bb:5f59:8e51:52d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbf4bsm6282483f8f.73.2024.07.15.05.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 05:29:36 -0700 (PDT)
Message-ID: <268511f7-a79c-46f4-89eb-a46dd53a292b@linaro.org>
Date: Mon, 15 Jul 2024 14:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v6 23/24] power: regulator: qcom-rpmh-regulator: add build
 infra
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240715-b4-qcom-rpmh-v6-0-0c948a25d018@linaro.org>
 <20240715-b4-qcom-rpmh-v6-23-0c948a25d018@linaro.org>
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
Organization: Linaro
In-Reply-To: <20240715-b4-qcom-rpmh-v6-23-0c948a25d018@linaro.org>
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

On 15/07/2024 12:08, Caleb Connolly wrote:
> Add Kconfig and Makefile entries for this driver now that it can build
> for U-Boot.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/power/regulator/Kconfig  | 8 ++++++++
>   drivers/power/regulator/Makefile | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
> index 102ec7bc5f89..bc061c20d75e 100644
> --- a/drivers/power/regulator/Kconfig
> +++ b/drivers/power/regulator/Kconfig
> @@ -215,8 +215,16 @@ config DM_REGULATOR_GPIO
>   	This config enables implementation of driver-model regulator uclass
>   	features for gpio regulators. The driver implements get/set for
>   	voltage value.
>   
> +config DM_REGULATOR_QCOM_RPMH
> +	bool "Enable driver model for Qualcomm RPMh regulator"
> +	depends on DM_REGULATOR && QCOM_RPMH
> +	---help---
> +	  Enable support for the Qualcomm RPMh regulator. The driver
> +	  implements get/set api for a limited set of regulators used
> +	  by u-boot.
> +
>   config SPL_DM_REGULATOR_GPIO
>   	bool "Enable Driver Model for GPIO REGULATOR in SPL"
>   	depends on DM_REGULATOR_GPIO && SPL_GPIO
>   	select SPL_DM_REGULATOR_COMMON
> diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
> index f79932d83307..56a527612b74 100644
> --- a/drivers/power/regulator/Makefile
> +++ b/drivers/power/regulator/Makefile
> @@ -20,8 +20,9 @@ obj-$(CONFIG_$(SPL_)REGULATOR_PWM) += pwm_regulator.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_FAN53555) += fan53555.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_COMMON) += regulator_common.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_FIXED) += fixed.o
>   obj-$(CONFIG_$(SPL_)DM_REGULATOR_GPIO) += gpio-regulator.o
> +obj-$(CONFIG_DM_REGULATOR_QCOM_RPMH) += qcom-rpmh-regulator.o
>   obj-$(CONFIG_$(SPL_TPL_)REGULATOR_RK8XX) += rk8xx.o
>   obj-$(CONFIG_DM_REGULATOR_S2MPS11) += s2mps11_regulator.o
>   obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
>   obj-$(CONFIG_DM_REGULATOR_SANDBOX) += sandbox.o
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
