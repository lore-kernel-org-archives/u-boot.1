Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874B4C2BBCA
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 10:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A685688254;
	Fri, 28 Jun 2024 12:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rIguuHDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0355A88578; Fri, 28 Jun 2024 12:04:28 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4B3A88254
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 12:04:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec1620a956so3868051fa.1
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 03:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719569065; x=1720173865; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=GE8XRFmE3ja+LJZKwFZju1+ZaIQvzQwo9fxyZmchtn0=;
 b=rIguuHDk1VR9zW65+KTRsI3urjvxIZIogrNdrlEknYCXJK10cq+5HPzfZUiT/syVkt
 htKLR6FVF7b/KNVxSbEPA7tJJMS0QGzTUX1ZnPvKDf7eFn2VOSG++RQi1b3ZG/JFCw54
 Xab9OyypJfzQp2zL/jM/jBxeYoRPj/jJVrVsiSXvLtG+8Babm0XfG9Bl27GbiDzV2Pdm
 qOXBYPTTElfLWZq8snxx2uhUbASad+XZcLn+nXOiPXM0obj/ESW1NBpVEdXr2IUX3GB7
 TqacudpZ1bol3Opr6dUdygmw3K3JmqZognNBOdWf09jFVn4FiLHR95cbyH8A6HCSrPjo
 eNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719569065; x=1720173865;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GE8XRFmE3ja+LJZKwFZju1+ZaIQvzQwo9fxyZmchtn0=;
 b=cw+pVUHOrxmgQpg5b21ToO9VKtu64+I0n6wXP50BUUlcfFDeA2vpmwhLvR3LjfZ7Di
 HtKwF456gTO5Cx7TC++M8al6VpBma0KGO61ub8spgRalFSLhMf7gus8XsPmOQ55ZxJir
 fmOpsdzPi+KLTFl/S/DK+kFtyvI+jPafNCB9CjVXapDnIdaI1BVCGFK6oqUsefJolVfi
 a47qDY4ztVc3L8AdqXiAKJAG/P4waHKShHwuGUXvAJbXISxhdurW/XWsGdtJx8DgmtDy
 +SJVdYmB/pFWddgnNhVVuKvb5G0/A/e4jaxWLh9tBkXNDk37EkZn3/Rux2feKMiLuR9A
 H4rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2c07/59izsY3cx6igKLdlPW265tLhGuZn2Mv71tq7hzRzZpDaPO5EMO4X5ArKkU3ipzkJ336wiAGRfmFdjSiF2zve5Q==
X-Gm-Message-State: AOJu0Yz5HdXpimmowQ0vSdfKgkKMTWIg8isi/3neenybmt+YDxWiCqIu
 +nE9UtrUfRercGMIJxrMtEfjVO51mzOT0pMOL0hASdOUWkZcsIG6M1Km+uzmszQ=
X-Google-Smtp-Source: AGHT+IHNW7jFL+LHkrlX3gnhxdwm8UpKwgoETEB5jaeTXtQ6KMk0vwiljA+cf1wHJlidnA/KcL/23g==
X-Received: by 2002:a05:651c:10a2:b0:2ec:5cfe:2e99 with SMTP id
 38308e7fff4ca-2ec5cfe2efcmr86755971fa.6.1719569064539; 
 Fri, 28 Jun 2024 03:04:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b17d:324d:ca1:ab31?
 ([2a01:e0a:982:cbb0:b17d:324d:ca1:ab31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a104023sm1736863f8f.109.2024.06.28.03.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 03:04:24 -0700 (PDT)
Message-ID: <05c16a1a-11d1-48ad-83f7-6b1741b5545b@linaro.org>
Date: Fri, 28 Jun 2024 12:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/2] clk: add stub clock driver
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-clk-stub-v2-0-29013855e343@linaro.org>
 <20240527-b4-clk-stub-v2-1-29013855e343@linaro.org>
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
In-Reply-To: <20240527-b4-clk-stub-v2-1-29013855e343@linaro.org>
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

On 27/05/2024 19:12, Caleb Connolly wrote:
> Add a stub clock driver which can be used to bind clock controllers
> which aren't required for the platform to boot, but which are needed for
> U-Boot drivers to work.
> 
> In addition, add a NOP parent driver to allow for binding the parent
> nodes of the clock.
> 
> Initially this driver supports a Qualcomm platform where the MMC driver
> tries to fetch the RPM clock controller, which is not actually required
> for the device to work.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/Kconfig    |  7 ++++++
>   drivers/clk/Makefile   |  1 +
>   drivers/clk/clk-stub.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 71 insertions(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9acbc47fe8ed..965bc4959403 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -95,8 +95,15 @@ config SPL_CLK_GPIO
>   	help
>   	  Enable this option to add GPIO-controlled clock gate driver
>   	  in U-Boot SPL.
>   
> +config CLK_STUB
> +	bool "Stub clock driver"
> +	depends on CLK
> +	help
> +	  Enable this to provide a stub clock driver for non-essential clock
> +	  controllers.
> +
>   config CLK_BCM6345
>   	bool "Clock controller driver for BCM6345"
>   	depends on CLK && ARCH_BMIPS
>   	default y
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 847b9b291100..b2cea41419b7 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -10,8 +10,9 @@ obj-$(CONFIG_$(SPL_TPL_)CLK) += clk_fixed_factor.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk.o clk-divider.o clk-mux.o clk-gate.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_CCF) += clk-fixed-factor.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_COMPOSITE_CCF) += clk-composite.o
>   obj-$(CONFIG_$(SPL_TPL_)CLK_GPIO) += clk-gpio.o
> +obj-$(CONFIG_CLK_STUB) += clk-stub.o
>   
>   obj-y += adi/
>   obj-y += analogbits/
>   obj-y += imx/
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> new file mode 100644
> index 000000000000..3f9c758ef115
> --- /dev/null
> +++ b/drivers/clk/clk-stub.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Stub clk driver for non-essential clocks.
> + *
> + * This driver should be used for clock controllers
> + * which are described as dependencies in DT but aren't
> + * actually necessary for hardware functionality.
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +
> +/* NOP parent nodes to stub clocks */
> +static const struct udevice_id nop_parent_ids[] = {
> +	{ .compatible = "qcom,rpm-proc" },
> +	{ .compatible = "qcom,glink-rpm" },
> +	{ .compatible = "qcom,rpm-sm6115" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(nop_parent) = {
> +	.name = "nop_parent",
> +	.id = UCLASS_NOP,
> +	.of_match = nop_parent_ids,
> +	.bind = dm_scan_fdt_dev,
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> +
> +static ulong stub_clk_set_rate(struct clk *clk, ulong rate)
> +{
> +	return (clk->rate = rate);
> +}
> +
> +static ulong stub_clk_get_rate(struct clk *clk)
> +{
> +	return clk->rate;
> +}
> +
> +static int stub_clk_nop(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static struct clk_ops stub_clk_ops = {
> +	.set_rate = stub_clk_set_rate,
> +	.get_rate = stub_clk_get_rate,
> +	.enable = stub_clk_nop,
> +	.disable = stub_clk_nop,
> +};
> +
> +static const struct udevice_id stub_clk_ids[] = {
> +	{ .compatible = "qcom,rpmcc" },


If you resend, please add:
- qcom,sm8550-rpmh-clk
- qcom,sm8650-rpmh-clk

Thanks,
Neil

> +	{ }
> +};
> +
> +U_BOOT_DRIVER(clk_stub) = {
> +	.name = "clk_stub",
> +	.id = UCLASS_CLK,
> +	.ops = &stub_clk_ops,
> +	.of_match = stub_clk_ids,
> +	.flags = DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};
> +
> 

