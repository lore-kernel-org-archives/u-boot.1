Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F149CC36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 09:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10AEB81F28;
	Mon, 24 Mar 2025 10:20:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w74Kuwno";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9381981F45; Mon, 24 Mar 2025 10:20:25 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA46881EA2
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 10:20:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so38067435e9.3
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742808022; x=1743412822; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=eHifDTGzPuLasuczuhpe596n5XbXeIyWtaFwKBuLDoQ=;
 b=w74KuwnomKs5KbcCnkQioBqcisEwzfFcwU2Utg7ytM5p9KkU4aejYaDNH+Igw7Q1hJ
 4m85qC2aqn7Sm6l2PvAvULJ2R+E0IBXldaH/79T2tm5KVag42bKtiP644KEE6IsA+7T2
 e8O7BBPpTt9sY0TvTbzjP0K9QZrT838a0XKALxd+G6j27F8XCdjX2u11xu0ppxtTjyhi
 u8zdJ1M8dBIH5sc6Dyjh4qJmat6fPRJbUSQ/U/jj5zcT03s+IY/IL5I/OjXBIjY2rv7U
 afIw+qEJSse8kY1fCceNtgEUvDFHAg6edkXK6V1vegsprbQwD9FrW/Dzb/ghWjTHRJ/p
 e+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742808022; x=1743412822;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eHifDTGzPuLasuczuhpe596n5XbXeIyWtaFwKBuLDoQ=;
 b=hjr214wjPpT8XE5yX4xqPBkCI74eYixpcWWjZxwx32CZ1slAL0oJbpcD1jKBmXcKdl
 j707BfztRwcJ7+t6I08Qtq2qBfR/wCVYMFnxeKc4BRK6B2Ku43QFW+s7cF2OjP0smw4d
 dJcRhZ8uUZzFFtm19quN3LJsDqRRyCLnL6l/NFnNC90rCC+eY+SXC5d4rmI+WXSwPBsQ
 azL+/A82X7YH2I9HY8FbR/mgrq7rbLri1j+PujsCzBmxr0glnR0cjsZmR4Ns3fL62AEY
 iKYO6YwmlIOi3QMEC4uV8NBc1JOot1zCSQ3MUZPh1fQQtanbFvhUMQNCtp0rRftmH7f8
 Xmvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7W5Qoc/HoOpdCRzXSaVjQ24Delkc+wywFotj2AkO3mOuQ3GPcaKT4T09FurVutDSr/FKzxo=@lists.denx.de
X-Gm-Message-State: AOJu0YwbabDhHPEwOxeiS/4SVU3RWCo++t/E+rZun4cczk234TTi2j/p
 wEQg4LlPDIpSR+aYw1iaiiiCmG1BItOUf7/A1s+IiXaR4+cqfI1t6J+F/+cnA/E=
X-Gm-Gg: ASbGncs3YmoNsxFnqAa3QzzFXyv7JRUU0os2tYZx21Gl80TKlMAsJwWZqwF8RCePb9w
 CN/3UvXhfUBRk2GOX7WcDhHHUO8Y2L/xSYpvEsg6sMpffDX3XsHWcsJtISzCRgpDHokWIiZtLha
 hhlV6n4ujU8+8sUVBz37GHckP8OZwK6MBOiU97n6UIoEBDOsbPo1X9+Y3QRsbEpuqOw2zv7D9cH
 fGzSiFIg6q+0BqEq6VWffSxI1V2yfnUJt8UVUL9nUMuHKA6VQifUAcqZmgLv8qbH7c6MRzOZvbk
 cjI+nhD2ncYza32zefvo/2qvec88BeyEmpHDSWXZ6eVuDEXTc2T2APpcequpjzsxfz+TBZvuOQF
 nHzWzLpzsqs7S6PY9
X-Google-Smtp-Source: AGHT+IFxi+KRpnlNf4TywFNWJaRZmGezzk8mocOy9J17NHCtYfya96DPu6Y20Qh0ar7gSQPHMBZJlQ==
X-Received: by 2002:a5d:5989:0:b0:391:2e31:c7e5 with SMTP id
 ffacd0b85a97d-3997f8f8b0dmr9294910f8f.6.1742808022286; 
 Mon, 24 Mar 2025 02:20:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f?
 ([2a01:e0a:3d9:2080:a356:8d0:d4d:bb5f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3ae040f9sm145117615e9.0.2025.03.24.02.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 02:20:21 -0700 (PDT)
Message-ID: <8214b374-b268-489c-b80e-61b0780f72e5@linaro.org>
Date: Mon, 24 Mar 2025 10:20:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Fix match_ep callback for NXP UUU tool
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>, Lukasz Majewski
 <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Tom Rini <trini@konsulko.com>
References: <20250319220805.219001-1-marex@denx.de>
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
In-Reply-To: <20250319220805.219001-1-marex@denx.de>
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

On 19/03/2025 23:07, Marek Vasut wrote:
> The UUU tool excepts the interrupt-in endpoint to be ep1in, otherwise
> it crashes. This is a result of the previous hard-coded EP setup in
> drivers/usb/gadget/epautoconf.c which did special-case EP allocation
> for SPL builds, and which was since converted to this callback, but
> without the special-case EP allocation in SPL part.
> 
> This reinstates the SPL part in an isolated manner, only for NXP iMX
> SoCs, only for SPL builds, and only for the ep1in interrupt-in endpoint.
> 
> Fixes: 1918b8010c32 ("usb: dwc3: gadget: Convert epautoconf workaround to match_ep callback")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> NOTE: This should go into master as a bugfix.
> ---
>   drivers/usb/dwc3/gadget.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index e5a383407a2..477ecd02098 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1631,8 +1631,25 @@ usb_ep *dwc3_gadget_match_ep(struct usb_gadget *gadget,
>   		return dwc3_find_ep(gadget, "ep1in");
>   	if (usb_endpoint_is_bulk_out(desc))
>   		return dwc3_find_ep(gadget, "ep2out");
> -	if (usb_endpoint_is_int_in(desc))
> +	if (usb_endpoint_is_int_in(desc)) {
> +		/*
> +		 * Special workaround for NXP UUU tool in SPL.
> +		 *
> +		 * The tool excepts the interrupt-in endpoint to be ep1in,

Small nit: expects

> +		 * otherwise it crashes. This is a result of the previous
> +		 * hard-coded EP setup in drivers/usb/gadget/epautoconf.c
> +		 * which did special-case EP allocation for SPL builds,
> +		 * and which was since converted to this callback, but
> +		 * without the special-case EP allocation in SPL part.
> +		 *
> +		 * This reinstates the SPL part in an isolated manner,
> +		 * only for NXP iMX SoCs, only for SPL builds, and only
> +		 * for the ep1in interrupt-in endpoint.
> +		 */
> +		if (IS_ENABLED(CONFIG_MACH_IMX) && IS_ENABLED(CONFIG_XPL_BUILD))
> +			return dwc3_find_ep(gadget, "ep1in");
>   		return dwc3_find_ep(gadget, "ep3in");
> +	}
>   
>   	return NULL;
>   }

