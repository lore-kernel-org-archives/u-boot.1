Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F86D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2202E8063E;
	Wed, 14 Jan 2026 15:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gyEsr3cm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C32808AF; Wed, 14 Jan 2026 15:35:40 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E666580325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso40253365e9.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401337; x=1769006137; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zJpwKqnT8M2w66Gw6X2PinRk0i7N2EJumzORsrkA2/A=;
 b=gyEsr3cmpp6joWUBkxCIoDqfLoTeYlbA8iAvjiwF52Ksuh1bLdV3ZhNLQZnce3rD2t
 bmvU2lon2U4McNNhhBAbdZv4/jtQF9C+ILoVEFT4IoUDEaHdO9MZUJ40LnJrVMG305iX
 7l8WCU63uIs5VdkKghE88fO/Ps1WC58i7VafNW3gG19Ovnh7ualPyyL8yPbbaD8Qho0a
 1jEtlrEC2D2wOJbevb2mcgwhj4GpJ2WpwqXuS+VGAEqtaIo6hCYqnPyXN0SbZqc5WsaU
 oGwvao11WTXFMMNBlmkjFhxnHhdQK9lPPV7WWPELi1asSfRsXuYM+bHvIS2DQZZG2fmA
 cSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401337; x=1769006137;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJpwKqnT8M2w66Gw6X2PinRk0i7N2EJumzORsrkA2/A=;
 b=tJGl0xq1ru3PrbREo9ytJbexypGq5f92mYcSj13W5nj2eA2ubp7Csv2/S/DQx5N7fD
 DRsPPTqPhJ7lTCO2e9aY/tAYduYPz1J/Jsr/eWdxbho4PU6oag0kE1LOdzZSNNf6qHa7
 GEhwmOT7BvDwMFYyC1bNcMjVF1KJzTDzo+g5tYEPvyexwYQ7Iu6KG27K9dU1ETSbiJP6
 Iod6eFxcEVeMHxgA0iquB7sfvVCvPS9IOsLHqsGIS4nna/BtGRxWh77PPkl6jg5Q+Qkh
 unZ6eCz1X92O477sr/RKlwrZvb8WN7pnLw4nlBx/bY6DtFlCKuDU5+5oc6Uska9k3bCJ
 eZeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBiqlZ2+XPgF4xIWfFTOCMrg5eUdXOiBYrm4FJJgDBQ8MW3qCiOFna5sYLBU91R5iWfsunB/8=@lists.denx.de
X-Gm-Message-State: AOJu0Yy2bdYjlkDjHbvqoE91rY/xrJkfnUEwbDQv36acjOk+QTBo676Q
 89DpAgwI2xVaPh8uMC5TGaXIvAzd9cUo2PK15eJjQLnYSsXaL2kL0hlGyiw6a/R2OwQ=
X-Gm-Gg: AY/fxX47uZewFM4poddT+e6ChDLhtgIYzH4bPd5sLvuLtafALe8srwO2DJLIvjmsRcO
 96+fakL6mQDpAD3JibkJIzl6xJw8Ki6OGqrkX0zT5pv/TYLnA3edfxRQ+RtsN19Aa+zGi5ohFfR
 ufr2yuV5i1YeYMRnEcVFmz+sXe9sArOvr+5OgJMVocR93Neh+Gi9YACOSNK8BEXswDeg/YeZLG9
 oAZmXlE/2RTbrI2ky4RXqDQFTu1QS7iJCJjefg/S811JG98/K8DXkN6XluvMkNfzqwi8CV5sqpK
 Cc+NLiHTbEjtjsaWSFC31XYnq3wDjNPA1zbTtuYfZUYc40eUIPBxg/lsguhyF7sMamMK0k5oqrb
 u3XrejtjXHWhqICI6UZh0phOOf8HqPnCUKWWjANcJhuiZkZAgPcA0azqSRQ0cZpxbY97qbeZ97B
 T69uhod0rDtazsnrAOa3J9nu35MUaD7t6zMRcQq+54u5tmZ2X30KHmtMvfml3ccvI=
X-Received: by 2002:a05:600c:638f:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-47ee4841b44mr21327125e9.37.1768401337213; 
 Wed, 14 Jan 2026 06:35:37 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0daa84sm50282220f8f.2.2026.01.14.06.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:35:36 -0800 (PST)
Message-ID: <573a72f5-7de7-4f9e-936d-2be0c3c2f3dd@linaro.org>
Date: Wed, 14 Jan 2026 15:35:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] usb: common: default dr_mode to OTG when not set
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-1-fb7a626466b9@linaro.org>
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
In-Reply-To: <20260114-casey-usb-role-switch-v1-1-fb7a626466b9@linaro.org>
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
> DT bindings dictate that dr_mode being unset on a DRD capable USB
> controller means we should default to OTG mode. Adjust usb_get_dr_mode()
> to reflect this.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/usb/common/common.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/common.c b/drivers/usb/common/common.c
> index 13e9a61072a9..e3bd7339e68e 100644
> --- a/drivers/usb/common/common.c
> +++ b/drivers/usb/common/common.c
> @@ -29,9 +29,10 @@ enum usb_dr_mode usb_get_dr_mode(ofnode node)
>   
>   	dr_mode = ofnode_read_string(node, "dr_mode");
>   	if (!dr_mode) {
>   		pr_debug("usb dr_mode not found\n");
> -		return USB_DR_MODE_UNKNOWN;
> +		/* Default to OTG mode as per DT bindings */
> +		return USB_DR_MODE_OTG;
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
>   		if (!strcmp(dr_mode, usb_dr_modes[i]))
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
