Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1872CC2BD05
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 08:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F4B287CFE;
	Mon, 24 Jun 2024 10:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yhG40wWv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0158087DEA; Mon, 24 Jun 2024 10:18:54 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA8FC87CDB
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 10:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42189d3c7efso44193995e9.2
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 01:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719217131; x=1719821931; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ukqViPM6903ByOj7FHDg7fovrP9WQgu6WiEQJ2dEhYo=;
 b=yhG40wWvvhaq17BAhFhji31HXyqpbf0noyum6RaPh7k6qT+bnwxfngIkVJGEtr+3Ks
 I98o+ALA3ziJmtqGVuSiohEl2eFdpxU6UZaVRhGxSRBzPO/se6o4RQAYOGdKmmNAjIhu
 vBybAhzTU2Fn0SVGu09rVvc7DS2eTXu9jsLqWmKRjcf9vSawLlslBO0uz8SuoE8g/6Xh
 pqOJy1wJ4w2n0TtpW73fWt5fC5vl4C67hWKfmO18ZQKQz7z3qWTyxaBNMzt9DyKXDOiY
 WbkHBtFfppQBJCGHLRIaU6s8JQiwyI0SiyflvY/AM5/gfrj3QWMn4wNg/hW8FlQ48caL
 1XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719217131; x=1719821931;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ukqViPM6903ByOj7FHDg7fovrP9WQgu6WiEQJ2dEhYo=;
 b=OjfIqKOTijx0kwMImheOWDffVJinbKF70bndlCasyG3RLpgcJBigMp9VzowPMNBX5X
 UwB1ZdDBBig232b+CzGCGbtLlHBDDVQg/xgB67Lz4UT1vQGc8rsFlraewm4b43a4t348
 RMNASeJ+c/djSgBCERWCouPwVdym6nrk1zzriYIkWjm3rjhyL4wyn4fCIj09YJdnC5qO
 N0bXmMMi9ckfhJkgixqg79Zo/MUzcdczjunUwc466XTAlC8VcQBHUqJFwxAFCu1q60cG
 sME5oUhfLOTevfLRdcp6JMtL42kcuMHbSAIy3IfcXVtm9U/sDJ6RCTZ7FbQwZsCviQWX
 IkWA==
X-Gm-Message-State: AOJu0Ywcy0iAtbNoyCz//eto20HVTjeBVktPtzrOE7EwUcjHSlpfU3GV
 e0yymtM8n8l41tIy60sTjbCuXuLRYkzv7sivuBNSQm96pwvmbqxcTXw/+MOvdfU=
X-Google-Smtp-Source: AGHT+IGrwujlW83j9PkeL47wzlItro7064LVHZD66Xtn6nlf9IOgwRbk958VR19D5EK77Bizmg37HA==
X-Received: by 2002:a05:600c:220d:b0:422:7899:76d2 with SMTP id
 5b1f17b1804b1-4248cc33cdcmr34670985e9.17.1719217130739; 
 Mon, 24 Jun 2024 01:18:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cf01:774b:55fd:ab74?
 ([2a01:e0a:982:cbb0:cf01:774b:55fd:ab74])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-366e0750e41sm6821901f8f.97.2024.06.24.01.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 01:18:50 -0700 (PDT)
Message-ID: <8a410cf1-2dfe-4bac-b709-c79178ba5870@linaro.org>
Date: Mon, 24 Jun 2024 10:18:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] spmi: msm: correct mac_channels for v5 controllers
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240624022333.2380607-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240624022333.2380607-1-caleb.connolly@linaro.org>
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

On 24/06/2024 04:23, Caleb Connolly wrote:
> Commit ee1d8aa5ecf7 ("spmi: msm: support controller version 7") broke
> support for channels > 128 on v5 controllers, resulting in some
> peripherals (like the power button / pon) working but others (like
> gpios) reading bogus data.
> 
> Correct max_channels for v5 controllers.
> 
> Fixes: ee1d8aa5ecf7 ("spmi: msm: support controller version 7")
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/spmi/spmi-msm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spmi/spmi-msm.c b/drivers/spmi/spmi-msm.c
> index 58c676423f40..49aad439648f 100644
> --- a/drivers/spmi/spmi-msm.c
> +++ b/drivers/spmi/spmi-msm.c
> @@ -270,9 +270,9 @@ static int msm_spmi_probe(struct udevice *dev)
>   		priv->max_channels = SPMI_MAX_CHANNELS;
>   	} else if (hw_ver < PMIC_ARB_VERSION_V7_MIN) {
>   		priv->arb_ver = V5;
>   		priv->arb_chnl = core_addr + APID_MAP_OFFSET_V5;
> -		priv->max_channels = SPMI_MAX_CHANNELS;
> +		priv->max_channels = SPMI_MAX_CHANNELS_V5;
>   		priv->spmi_cnfg = dev_read_addr_name(dev, "cnfg");
>   	} else {
>   		/* TOFIX: handle second bus */
>   		priv->arb_ver = V7;

Thanks for spotting this...

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
