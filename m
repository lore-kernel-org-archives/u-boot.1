Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BCAD37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B01FD8063E;
	Wed, 14 Jan 2026 15:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XypidEX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4C288063E; Wed, 14 Jan 2026 15:36:58 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F80A80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so2110405e9.0
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401416; x=1769006216; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Pwby+EKMdGyD88YSaCSnZZGeihGIvJ+y3i5qLkijtzs=;
 b=XypidEX0wWEgpUmzm84CGWZYzom3DcLn1vP+id/JsSkxRw6kJn9SEbUuckmNwyFyHf
 jROThI+eggiIfV3VE4LadzLtPezBKowazd/ONfFjh/+XlS4/DkL8eclAc4O50SopNy/k
 4QrMFi8SRfFu3991plJIk6wtb30f2S9yr8YAgQ6xmA3fzqyL12vROYwxARE1hSymnq8y
 iVzbdROFw+FKLBNq3QlNjqf8VkADQErZoz4lJRK5InvwFpCe5/oOSo49D3CCpzjG8omL
 DN9Cnv0qy1f1Hfz6x8/1zk14PYj66ThZ+WpTIGm4WigmfxNSPbWDQXZ0+SG3ZG2Bouf0
 pVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401416; x=1769006216;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pwby+EKMdGyD88YSaCSnZZGeihGIvJ+y3i5qLkijtzs=;
 b=BOeI/GCwcLbnkNwLg+c5heqdlavRfcXuLVwdEc2iKjIl5pB86ExtVoOKU3ZKfn1Z41
 sBPl5M5eiaqralQz9MrCtFSRFbPk5du+q/CN9YcGZBlk4nDWBr5apL1K17InVvNjJdrn
 7wSDPJXLdtoHUsx576ZAkcBaOGQSR8lzaJnquHPf7qOY4Jr+Fh4ytJMolQRqA2SJJzVk
 tFwYU8IsWOkfBE6Vgfbrytd/PITz6HgDuSOEUb7m0nEUum30S7wdQwLHcsEXZMZ55BWX
 rqhLKP/RNwK2/ndgE5MoDfaFWl+KD2TwHjLAjVuy3iBPWY5ymnIk6FmyLLM2oiulePW9
 iFQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5gr5lJrgu/Rg/48sEWwyj4zofyFrWiHKJM5ftLUmb3yCAuLZCDPY16LUbtBwLqSWmwRMJhtE=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhh/XDxl+22NohWRZ9+Fo5sfL467JjGyByVJzS6lQbXj1y0UXa
 bqIRpTyC4Fgn1hvZ2VSX4ThtjtpibTKQxSSo3dnCvfQ6njyp9hr0f2q1oax2/NnxpeE=
X-Gm-Gg: AY/fxX54sMGIKCq/ePNQaztJHpslVJa7x9/O2ibOJJDg5Zo/jb7T6AdhRVzdissLzAY
 6JBQdSgO8QpgoHlAAAAUpwoaxwJ/Rb5xdbjMMUwGz3K9UXH7h+p7625udxSAkFha7aKXb6j8BQP
 Re1OPLWzapJkBoT4Bijax+/2Mi36qO/V3UG4AE2Gh9X4xafeB9LKyVpHF17xhwXuqDguaaLA2Fz
 nNl2zX6Y+h+Or5yKLKudV21M880axeWVZSzosmqbp7rZ0zC3GaMxIdnwRqy8ttLfNwo84udfuPU
 TQEbOH3gw2SS0JDIYws3Nw+INx9GrTJk+R2rANCq9/qX6vYcC7IcBd+reAV/a7SM0bA+20QzUj2
 0FR3pbCDEYNL7qJCYq0QVlklDvPQRbr6nQDXFAEUzYS3xXX2StSMg6WB0vlys9HqaW/q31kyckK
 gY7qu4eiM2NptTkfkZygjIPIXDgW337Ek+gU1toLx9NPIhlDCqrt2UcF/ZfX6DFminK4Darqg1V
 A==
X-Received: by 2002:a05:600c:5486:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-47ee9817917mr4166135e9.12.1768401415950; 
 Wed, 14 Jan 2026 06:36:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee2814548sm21103525e9.9.2026.01.14.06.36.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:36:55 -0800 (PST)
Message-ID: <cb7aae0e-aa2b-484f-91ba-6d356b3b26c0@linaro.org>
Date: Wed, 14 Jan 2026 15:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] usb: dwc3-generic: support Qualcomm flattened DT
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260114-casey-usb-role-switch-v1-2-fb7a626466b9@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/14/26 15:13, Casey Connolly wrote:
> Qualcomm devicetrees are moving away from having a glue node with dwc3
> as a subnode and now may just have a single flattened node.
> 
> Rockchip already have a glue_get_ctrl_dev op which returns the node for
> the glue device itself, commonise this and reuse it for the new Qualcomm
> node.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 02c02b1d80e4..7044696ced0c 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -6,8 +6,10 @@
>    *
>    * Based on dwc3-omap.c.
>    */
>   
> +#define LOG_DEBUG

You should drop this

> +
>   #include <dm.h>
>   #include <reset.h>
>   #include <asm/gpio.h>
>   #include <dm/device_compat.h>
> @@ -488,23 +490,29 @@ static void dwc3_qcom_glue_configure(struct udevice *dev, int index,
>   	if (mode != USB_DR_MODE_HOST)
>   		dwc3_qcom_vbus_override_enable(qscratch_base, true);
>   }
>   
> -struct dwc3_glue_ops qcom_ops = {
> -	.glue_configure = dwc3_qcom_glue_configure,
> -};
> -
> -static int dwc3_rk_glue_get_ctrl_dev(struct udevice *dev, ofnode *node)
> +/* In cases where there is no dwc3 node and it's flattened into the glue node */
> +static int dwc3_flat_dt_get_ctrl_dev(struct udevice *dev, ofnode *node)
>   {
>   	*node = dev_ofnode(dev);
>   	if (!ofnode_valid(*node))
>   		return -EINVAL;
>   
>   	return 0;
>   }
>   
> +struct dwc3_glue_ops qcom_ops = {
> +	.glue_configure = dwc3_qcom_glue_configure,
> +};
> +
> +struct dwc3_glue_ops qcom_flat_dt_ops = {
> +	.glue_configure = dwc3_qcom_glue_configure,
> +	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
> +};
> +
>   struct dwc3_glue_ops rk_ops = {
> -	.glue_get_ctrl_dev = dwc3_rk_glue_get_ctrl_dev,
> +	.glue_get_ctrl_dev = dwc3_flat_dt_get_ctrl_dev,
>   };
>   
>   static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   {
> @@ -711,8 +719,9 @@ static const struct udevice_id dwc3_glue_ids[] = {
>   	{ .compatible = "rockchip,rk3568-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3576-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "rockchip,rk3588-dwc3", .data = (ulong)&rk_ops },
>   	{ .compatible = "qcom,dwc3", .data = (ulong)&qcom_ops },
> +	{ .compatible = "qcom,snps-dwc3", .data = (ulong)&qcom_flat_dt_ops },
>   	{ .compatible = "fsl,imx8mp-dwc3", .data = (ulong)&imx8mp_ops },
>   	{ .compatible = "fsl,imx8mq-dwc3" },
>   	{ .compatible = "intel,tangier-dwc3" },
>   	{ .compatible = "samsung,exynos7870-dwusb3" },
> 

With that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

