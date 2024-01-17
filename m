Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC40C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 08:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42A8A8799E;
	Wed, 17 Jan 2024 09:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ISnalHFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3FD1879E7; Wed, 17 Jan 2024 09:59:23 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C34F8799E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:59:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e88012233so6930315e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 00:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705481960; x=1706086760; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JSBzFv7T+cNCDSdIEnrUjihreUzL+VtOWox0Xl9IUrY=;
 b=ISnalHFSNDg1mxdudNBJE4EfrRgCPTbIKcY3pCnszYLePOgtz3dqb9lJU1qzEwtD98
 2QF9gdInuOPUDEQ3erNQI2ZuCKCC1hWnJhDFuo7mY96rCwpzDd6It2qG7oGrVV4Bvs7w
 iGTgoydpKLcxvzeqyFJFPPX3Wjch21rcJ+ifLhquNmGf1rNUe1KqoCwQQ4YBzyDZ6mBS
 S3QmOtRbCwUgzhGjKLJORMpvZICUqy6TNWYxlmUiO0iFLnXeH49iYn3V210jDul5Kn8m
 1IqKL5W9Xri26WXqpOPQjkqTWM0Lhu6iEW7WcA6C8y7D2DBIhVxMwLFlMYWFCm+8PJly
 lQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705481960; x=1706086760;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JSBzFv7T+cNCDSdIEnrUjihreUzL+VtOWox0Xl9IUrY=;
 b=e1asY36sjuDXKuUB9rxEbAGVZyR2dUDqj6gnBzecZoPdRiTCQIQWRnUhjheQpOv41J
 pGMYbjzISrS55QfFaX10w0k6p+wCXekXmfmleRThhYtFx1ltWkzPXuTS252OxSyf3EYR
 No175kFhbx2l+Dj2En0wYYn+z3LCE2XvoM6RAFdPK46JqstJILVwgPurZ72AnkCWBmJG
 kB/UVIjsDewZ8AqAe9YPVP9IbjCHxpA2sfjpRhINT9ewEbV14lzcdDdyDQQFp/3UrAtL
 BrTJHN7Xg1h28ewDMq4j8GTcVsZoa+cD3rkdb+EuNLrsdmz90Ap9RR13AFh/b1XLE0uU
 PSGw==
X-Gm-Message-State: AOJu0YzIzY8XDiZC5I5wuzyWXLYkKewNveQX8LcxUCUx8CNt0GuS/9f1
 zNNRgMvn9psiGNciG3vdg9sPvIxrjA/gfg==
X-Google-Smtp-Source: AGHT+IEtffUES/6I94h1dTcE/uE+PA/vdm9cnA0Dv1OhU3gouwtnChptdFTGzZQoZiYByrYzEwo0bA==
X-Received: by 2002:a05:600c:3799:b0:40e:6854:d4a1 with SMTP id
 o25-20020a05600c379900b0040e6854d4a1mr4258771wmr.133.1705481960096; 
 Wed, 17 Jan 2024 00:59:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1?
 ([2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0040e76b60235sm10528547wmq.8.2024.01.17.00.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:59:19 -0800 (PST)
Message-ID: <2fe89971-71de-4396-a34d-f4fcee8c93d6@linaro.org>
Date: Wed, 17 Jan 2024 09:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 04/17] video: dw_hdmi: Add read_hpd hook
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <20240117075154.58747-5-jagan@amarulasolutions.com>
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
In-Reply-To: <20240117075154.58747-5-jagan@amarulasolutions.com>
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
> Add support for DW HDMI Read HPD status.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
> Changes for v3:
> - check hdmi->ops
> Changes for v2:
> - none
> 
>   drivers/video/dw_hdmi.c | 3 +++
>   include/dw_hdmi.h       | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/video/dw_hdmi.c b/drivers/video/dw_hdmi.c
> index 3a3b9b7a21..989b7ab2db 100644
> --- a/drivers/video/dw_hdmi.c
> +++ b/drivers/video/dw_hdmi.c
> @@ -946,6 +946,9 @@ int dw_hdmi_detect_hpd(struct dw_hdmi *hdmi)
>   		return -ENODEV;
>   	}
>   
> +	if (hdmi->ops && hdmi->ops->read_hpd)
> +		hdmi->ops->read_hpd(hdmi, true);
> +
>   	return 0;
>   }
>   
> diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> index ba2ce5ea7f..a1f0e64507 100644
> --- a/include/dw_hdmi.h
> +++ b/include/dw_hdmi.h
> @@ -538,6 +538,7 @@ struct dw_hdmi;
>   
>   struct dw_hdmi_phy_ops {
>   	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
> +	void (*read_hpd)(struct dw_hdmi *hdmi, bool hdp_status);
>   };
>   
>   struct dw_hdmi {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
