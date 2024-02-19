Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42640C54764
	for <u-boot@archiver.kernel.org>; Mon, 19 Feb 2024 09:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5E5987F34;
	Mon, 19 Feb 2024 10:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="l3BshUDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5AAB87ED3; Mon, 19 Feb 2024 10:51:03 +0100 (CET)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C7A587F34
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 10:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d22b8c6e0dso21397271fa.2
 for <u-boot@lists.denx.de>; Mon, 19 Feb 2024 01:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708336221; x=1708941021; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OPG9/Sx5GuNkiPd4Cmnl9Qv7mOfNuFo+EEB15Vvej28=;
 b=l3BshUDvvUo56roCqvf251zZrR5kXXM3isLDxOmnyvrfbUgKt5y59M5ymvgTj+rrRU
 NK3UfjiKdbvonCVi+LjON3TSUAfmySzwliSA453bQRyL3oHa5vtMJ1OJINBp5BZe+lIj
 XXSH9XMlTi2ZsLkVUqsFafD20/772hpd85atIDqiX0xZ5HukRU7O8V5DulPgHGJX1kh5
 v1Kj7IQUQKoRZrPhhZenZJ5vg39mhmDUWmKGThJlUSMpYq9z0kjiBd8PnomT/sS2FzPD
 fZ4jXQbekK8BH7Dsc70SvqAA1rYUZE547Wl22QUUnmBNyaX9WJJ1xLiN+wyg6K64YqBH
 C0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708336221; x=1708941021;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OPG9/Sx5GuNkiPd4Cmnl9Qv7mOfNuFo+EEB15Vvej28=;
 b=SZB1kPfv3aUQrD5Q8oOYK378iIuSvxRgFLwwBd9rRD5pCKg5nY3KIDyH8V/dlSXMhx
 qbZISdb1640a4P/KzKJIYq5Li/8eESqNi7Elk9nREq6jUICYGpfDc4S+1veOCdDDuaZa
 8uocznZAI7LIxjybI0J5G3WDD3ManQf/mDSqHESjrS3qJV3+mUdUSljEM9kfJngYt+XQ
 aToySqRBcjh03NH9alTX9HBGR9L3P7ynsWin8StUWPjyleNMPGpzLwnhBdwEXnUZWxd4
 B8/OiY0Hv6N2SsayeWhM82eXSPUfI0GjFMSxISIOJUuR/DcVTkChCL23xs8nYYxAG5UL
 OkQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYW3spQ5LV5+hOzaTm6NYb8k0H0GeaoqQZb60CO13/8WR3bGVNFn8lMvEURevfcnVx7hd5thU/Bv1ejJsDnUGr4f3MZQ==
X-Gm-Message-State: AOJu0YySVAXpQegvcVVcWVh5pg05K1F4V7C9ZjYZYGsGaNhfzbch/Bhd
 5iGs/inO6HKDA/hfxL66NVvd0PLtTAmkfnRLx6jhvFE2fo65n1c8FWjXRfO8bI0=
X-Google-Smtp-Source: AGHT+IHoBHBRhYLLn7OWFFYTxlU5UuItRodr0pp6Ix09ka27YVOxgUz/Jy1+yJmsmep0fDyL+IWxaA==
X-Received: by 2002:a2e:a724:0:b0:2d2:35fb:8329 with SMTP id
 s36-20020a2ea724000000b002d235fb8329mr1674862lje.33.1708336221237; 
 Mon, 19 Feb 2024 01:50:21 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f?
 ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a05600c46d100b0041249ea88b9sm10136159wmo.16.2024.02.19.01.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 01:50:20 -0800 (PST)
Message-ID: <014a0eca-635d-43a3-a2f5-3ef458adba50@linaro.org>
Date: Mon, 19 Feb 2024 10:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 14/39] pinctrl: qcom: fix DT compatibility
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
 <20240215-b4-qcom-common-target-v4-14-ed06355c634a@linaro.org>
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
In-Reply-To: <20240215-b4-qcom-common-target-v4-14-ed06355c634a@linaro.org>
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

On 15/02/2024 21:52, Caleb Connolly wrote:
> Upstream devicetrees label GPIOs with "gpioX", not "GPIO_X", fix this
> for SoCs where we're now using upstream DT.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/pinctrl/qcom/pinctrl-apq8016.c | 26 +++++++--------
>   drivers/pinctrl/qcom/pinctrl-apq8096.c | 16 +++++-----
>   drivers/pinctrl/qcom/pinctrl-qcs404.c  | 58 ++++++++++++++++++++++++++++------
>   3 files changed, 69 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8016.c b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> index 8149ffd83cc4..10796710ba7a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8016.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8016.c
> @@ -14,18 +14,18 @@
>   #define MAX_PIN_NAME_LEN 32
>   static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>   static const char * const msm_pinctrl_pins[] = {
> -	"SDC1_CLK",
> -	"SDC1_CMD",
> -	"SDC1_DATA",
> -	"SDC2_CLK",
> -	"SDC2_CMD",
> -	"SDC2_DATA",
> -	"QDSD_CLK",
> -	"QDSD_CMD",
> -	"QDSD_DATA0",
> -	"QDSD_DATA1",
> -	"QDSD_DATA2",
> -	"QDSD_DATA3",
> +	"sdc1_clk",
> +	"sdc1_cmd",
> +	"sdc1_data",
> +	"sdc2_clk",
> +	"sdc2_cmd",
> +	"sdc2_data",
> +	"qdsd_clk",
> +	"qdsd_cmd",
> +	"qdsd_data0",
> +	"qdsd_data1",
> +	"qdsd_data2",
> +	"qdsd_data3",
>   };
>   
>   static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -42,7 +42,7 @@ static const char *apq8016_get_pin_name(struct udevice *dev,
>   					unsigned int selector)
>   {
>   	if (selector < 122) {
> -		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>   		return pin_name;
>   	} else {
>   		return msm_pinctrl_pins[selector - 122];
> diff --git a/drivers/pinctrl/qcom/pinctrl-apq8096.c b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> index d64ab1ff7bee..f2eeb4cf469a 100644
> --- a/drivers/pinctrl/qcom/pinctrl-apq8096.c
> +++ b/drivers/pinctrl/qcom/pinctrl-apq8096.c
> @@ -14,13 +14,13 @@
>   #define MAX_PIN_NAME_LEN 32
>   static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>   static const char * const msm_pinctrl_pins[] = {
> -	"SDC1_CLK",
> -	"SDC1_CMD",
> -	"SDC1_DATA",
> -	"SDC2_CLK",
> -	"SDC2_CMD",
> -	"SDC2_DATA",
> -	"SDC1_RCLK",
> +	"sdc1_clk",
> +	"sdc1_cmd",
> +	"sdc1_data",
> +	"sdc2_clk",
> +	"sdc2_cmd",
> +	"sdc2_data",
> +	"sdc1_rclk",
>   };
>   
>   static const struct pinctrl_function msm_pinctrl_functions[] = {
> @@ -37,7 +37,7 @@ static const char *apq8096_get_pin_name(struct udevice *dev,
>   					unsigned int selector)
>   {
>   	if (selector < 150) {
> -		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>   		return pin_name;
>   	} else {
>   		return msm_pinctrl_pins[selector - 150];
> diff --git a/drivers/pinctrl/qcom/pinctrl-qcs404.c b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> index ac00afa2a1f4..5066f2bba6b3 100644
> --- a/drivers/pinctrl/qcom/pinctrl-qcs404.c
> +++ b/drivers/pinctrl/qcom/pinctrl-qcs404.c
> @@ -10,20 +10,24 @@
>   
>   #include "pinctrl-qcom.h"
>   
> +#define NORTH	0x00300000
> +#define SOUTH	0x00000000
> +#define EAST	0x06b00000
> +
>   #define MAX_PIN_NAME_LEN 32
>   static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
>   static const char * const msm_pinctrl_pins[] = {
> -	"SDC1_RCLK",
> -	"SDC1_CLK",
> -	"SDC1_CMD",
> -	"SDC1_DATA",
> -	"SDC2_CLK",
> -	"SDC2_CMD",
> -	"SDC2_DATA",
> +	"sdc1_rclk",
> +	"sdc1_clk",
> +	"sdc1_cmd",
> +	"sdc1_data",
> +	"sdc2_clk",
> +	"sdc2_cmd",
> +	"sdc2_data",
>   };
>   
>   static const struct pinctrl_function msm_pinctrl_functions[] = {
> -	{"blsp_uart2", 1},
> +	{"gpio", 0},
>   	{"rgmii_int", 1},
>   	{"rgmii_ck", 1},
>   	{"rgmii_tx", 1},
> @@ -37,6 +41,40 @@ static const struct pinctrl_function msm_pinctrl_functions[] = {
>   	{"blsp_i2c_scl_a2", 3},
>   	{"blsp_i2c3", 2},
>   	{"blsp_i2c4", 1},
> +	{"blsp_uart_tx_a2", 1},
> +	{"blsp_uart_rx_a2", 1},
> +};
> +
> +static const unsigned int qcs404_pin_offsets[] = {
> +	[0] = SOUTH,    [1] = SOUTH,    [2] = SOUTH,    [3] = SOUTH,    [4] = SOUTH,
> +	[5] = SOUTH,   [6] = SOUTH,   [7] = SOUTH,   [8] = SOUTH,    [9] = SOUTH,
> +	[10] = SOUTH,   [11] = SOUTH,   [12] = SOUTH,  [13] = SOUTH,  [14] = SOUTH,
> +	[15] = SOUTH,  [16] = SOUTH,  [17] = NORTH,  [18] = NORTH,  [19] = NORTH,
> +	[20] = NORTH,  [21] = SOUTH,  [22] = NORTH,  [23] = NORTH,  [24] = NORTH,
> +	[25] = NORTH,  [26] = EAST,  [27] = EAST,   [28] = EAST,   [29] = EAST,
> +	[30] = NORTH,   [31] = NORTH,  [32] = NORTH,  [33] = NORTH,  [34] = SOUTH,
> +	[35] = SOUTH,  [36] = NORTH,  [37] = NORTH,  [38] = NORTH,  [39] = EAST,
> +	[40] = EAST,  [41] = EAST,   [42] = EAST,   [43] = EAST,   [44] = EAST,
> +	[45] = EAST,   [46] = EAST,   [47] = EAST,   [48] = EAST,   [49] = EAST,
> +	[50] = EAST,  [51] = EAST,  [52] = EAST,  [53] = EAST,  [54] = EAST,
> +	[55] = EAST,  [56] = EAST,  [57] = EAST,  [58] = EAST,  [59] = EAST,
> +	[60] = NORTH,  [61] = NORTH,  [62] = NORTH,  [63] = NORTH,  [64] = NORTH,
> +	[65] = NORTH,  [66] = NORTH,  [67] = NORTH,  [68] = NORTH,  [69] = NORTH,
> +	[70] = NORTH,   [71] = NORTH,   [72] = NORTH,   [73] = NORTH,   [74] = NORTH,
> +	[75] = NORTH,   [76] = NORTH,   [77] = NORTH,   [78] = EAST,   [79] = EAST,
> +	[80] = EAST,  [81] = EAST,  [82] = NORTH,  [83] = NORTH,  [84] = NORTH,
> +	[85] = NORTH,   [86] = EAST,   [87] = EAST,   [88] = EAST,   [89] = EAST,
> +	[90] = EAST,  [91] = EAST,  [92] = EAST,  [93] = EAST,  [94] = EAST,
> +	[95] = EAST,  [96] = EAST,  [97] = EAST,  [98] = EAST,  [99] = EAST,
> +	[100] = EAST, [101] = EAST, [102] = EAST, [103] = EAST, [104] = EAST,
> +	[105] = EAST, [106] = EAST, [107] = EAST, [108] = EAST, [109] = EAST,
> +	[110] = EAST, [111] = EAST, [112] = EAST, [113] = EAST, [114] = EAST,
> +	[115] = EAST, [116] = EAST, [117] = NORTH, [118] = NORTH, [119] = EAST,
> +	/*
> +	 * There's 126 pins but the last ones are special and have non-standard registers
> +	 * so we leave them out here. The pinctrl and GPIO drivers both currently ignore
> +	 * these pins.
> +	 */
>   };
>   
>   static const char *qcs404_get_function_name(struct udevice *dev,
> @@ -49,7 +87,7 @@ static const char *qcs404_get_pin_name(struct udevice *dev,
>   				       unsigned int selector)
>   {
>   	if (selector < 120) {
> -		snprintf(pin_name, MAX_PIN_NAME_LEN, "GPIO_%u", selector);
> +		snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
>   		return pin_name;
>   	} else {
>   		return msm_pinctrl_pins[selector - 120];
> @@ -62,7 +100,7 @@ static unsigned int qcs404_get_function_mux(unsigned int selector)
>   }
>   
>   static struct msm_pinctrl_data qcs404_data = {
> -	.pin_data = { .pin_count = 126, },
> +	.pin_data = { .pin_count = 126, .pin_offsets = qcs404_pin_offsets, .special_pins_start = 120, },
>   	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
>   	.get_function_name = qcs404_get_function_name,
>   	.get_function_mux = qcs404_get_function_mux,
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
