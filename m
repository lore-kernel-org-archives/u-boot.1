Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40847C47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 08:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A40687A08;
	Wed, 17 Jan 2024 09:59:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LuE0ij0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6028C87990; Wed, 17 Jan 2024 09:59:43 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C56587A09
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:59:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e88bb6d2bso2571225e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 00:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705481980; x=1706086780; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=01Rnji9Et6EwmuoF7Jr+OUWA+eO+vFFAEO4w3EEvKAU=;
 b=LuE0ij0jWTBuMtKj93cctgdPNTdUmxNvRyVS/thHICI2OcMFc9jUmdgmMpLA2W9L6e
 aTnW/3if7PWYA3w7xxM0WSlmQUN7Do9NKUorueUS9j4ctt542pLojPtMGILnjG5NO+C0
 rzeX4BcVRQ481AZBNV9NnW7nnm7yfRtXH9qglsI+4Kq8tv2NYrUlZjE+SyBa6SE/eiUO
 AymqgMe8KQwuDr603fgQOWYbGymxohsftC0JU9kifVPDxc+57gMbxNztX9XpU2OJcoqZ
 iDTVF8mmP4ZKG6q310AU5p/jVHEBn1/1G93nERsIGe8H8aC2phjTrU8SXcKwosq6NPxe
 x1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705481980; x=1706086780;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=01Rnji9Et6EwmuoF7Jr+OUWA+eO+vFFAEO4w3EEvKAU=;
 b=ZURHCgVKXb0eKYYfUJZl1J2pFU0wmzGkoajGkT1+eH6bjKa2TeAN73KcbjrBIGcoKB
 B89TVfekcnjYm67ssct1advbyql/0mtKRtZSD7Fuq0L5552RSDl5FqBrPvjOiksrmbsV
 JBF6a0sKxAKQJN54v9EEKUErgWLEWXYCiiJDwVciUwU8y6qjy2cZ+c1saxYbPbi4PbTk
 6Or2mr8x1rTPeEqHu9q49d0l2YWN7k1c05aOyds2QXzRN6XhkWCg3wbpJZIfdnQg8cBY
 lTNfn5yBxH+JveyAH02zi4h7evi+9DOINqX9uuXd7zR1VV7PgAjRmNVZzOcblkefngx7
 L4hQ==
X-Gm-Message-State: AOJu0Yy1rabdVLNRdvBxW6jJzPZGaLh7wHy670LGoEBVTHr8rys6wLew
 O529kvINgw6N3v6kkAA1z6V+DCEcyV+eXQ==
X-Google-Smtp-Source: AGHT+IEfIRl4nbersiToVTouiz8NosJcvoCWFMJkBf4uNR5ek7dgUJJ6Hwx8/HZz0Cc9PgQSa4tysg==
X-Received: by 2002:a7b:c349:0:b0:40e:50e7:db49 with SMTP id
 l9-20020a7bc349000000b0040e50e7db49mr277138wmj.102.1705481980536; 
 Wed, 17 Jan 2024 00:59:40 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1?
 ([2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0040e76b60235sm10528547wmq.8.2024.01.17.00.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:59:40 -0800 (PST)
Message-ID: <37bea1a0-1d0d-4b20-b78a-a4eb2985b07e@linaro.org>
Date: Wed, 17 Jan 2024 09:59:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 03/17] video: dw_hdmi: Extend the HPD detection
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <20240117075154.58747-4-jagan@amarulasolutions.com>
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
In-Reply-To: <20240117075154.58747-4-jagan@amarulasolutions.com>
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

On 17/01/2024 08:51, Jagan Teki wrote:
> From: Jagan Teki <jagan@edgeble.ai>
> 
> HPD detection on some DW HDMIdesigned SoC's would need to read and
> setup the HPD status explicitly.
> 
> So, extend the HPD detection code by adding the dw_hdmi_detect_hpd
> function and move the default detection code caller there.
> 
> The new read and setup hdp will integrate the same function in
> later patches.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
> Changes for v3, v2:
> - none
> 
>   drivers/video/dw_hdmi.c             | 13 +++++++++++++
>   drivers/video/rockchip/rk_hdmi.c    |  8 +++-----
>   drivers/video/sunxi/sunxi_dw_hdmi.c |  8 +++-----
>   include/dw_hdmi.h                   |  1 +
>   4 files changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> index 4914ba6146..3a3b9b7a21 100644
> --- a/drivers/video/dw_hdmi.c
> +++ b/drivers/video/dw_hdmi.c
> @@ -936,6 +936,19 @@ int dw_hdmi_phy_wait_for_hpd(struct dw_hdmi *hdmi)
>   	return -1;
>   }
>   
> +int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi)
> +{
> +	int ret;
> +
> +	ret = dw_hdmi_phy_wait_for_hpd(hdmi);
> +	if (ret < 0) {
> +		debug("hdmi can not get hpd signal\n");
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>   void dw_hdmi_phy_init(struct dw_hdmi *hdmi)
>   {
>   	/* enable phy i2cm done irq */
> diff --git a/drivers/video/rockchip/rk_hdmi.c b/drivers/video/rockchip/rk_hdmi.c
> index d5b5a529d2..16f6303513 100644
> --- a/drivers/video/rockchip/rk_hdmi.c
> +++ b/drivers/video/rockchip/rk_hdmi.c
> @@ -114,11 +114,9 @@ int rk_hdmi_probe(struct udevice *dev)
>   	dw_hdmi_init(hdmi);
>   	dw_hdmi_phy_init(hdmi);
>   
> -	ret = dw_hdmi_phy_wait_for_hpd(hdmi);
> -	if (ret < 0) {
> -		debug("hdmi can not get hpd signal\n");
> -		return -1;
> -	}
> +	ret = dw_hdmi_detect_hpd(hdmi);
> +	if (ret < 0)
> +		return ret;
>   
>   	return 0;
>   }
> diff --git a/drivers/video/sunxi/sunxi_dw_hdmi.c b/drivers/video/sunxi/sunxi_dw_hdmi.c
> index 986e69d66b..a5e8d39e98 100644
> --- a/drivers/video/sunxi/sunxi_dw_hdmi.c
> +++ b/drivers/video/sunxi/sunxi_dw_hdmi.c
> @@ -358,11 +358,9 @@ static int sunxi_dw_hdmi_probe(struct udevice *dev)
>   
>   	sunxi_dw_hdmi_phy_init(&priv->hdmi);
>   
> -	ret = dw_hdmi_phy_wait_for_hpd(&priv->hdmi);
> -	if (ret < 0) {
> -		debug("hdmi can not get hpd signal\n");
> -		return -1;
> -	}
> +	ret = dw_hdmi_detect_hpd(&priv->hdmi);
> +	if (ret < 0)
> +		return ret;
>   
>   	dw_hdmi_init(&priv->hdmi);
>   
> diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> index 17bdd2dbf9..ba2ce5ea7f 100644
> --- a/include/dw_hdmi.h
> +++ b/include/dw_hdmi.h
> @@ -562,5 +562,6 @@ void dw_hdmi_phy_init(struct dw_hdmi *hdmi);
>   int dw_hdmi_enable(struct dw_hdmi *hdmi, const struct display_timing *edid);
>   int dw_hdmi_read_edid(struct dw_hdmi *hdmi, u8 *buf, int buf_size);
>   void dw_hdmi_init(struct dw_hdmi *hdmi);
> +int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi);
>   
>   #endif

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
