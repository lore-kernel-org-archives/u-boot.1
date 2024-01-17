Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66CFC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 08:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2639C879F2;
	Wed, 17 Jan 2024 09:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HU/4VSwa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C70687990; Wed, 17 Jan 2024 09:59:32 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55C3687A0E
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 09:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e8801221cso5736015e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 00:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705481970; x=1706086770; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=g++HePyerak7/LIfwpX5BYabmfrG24Knlw4vLCO7xvM=;
 b=HU/4VSwaTKusxh/hZUBfiI2PIT74vKzCteeV6dM+1b87aguXhXXGyaYdYA85LXWf3B
 9Zc3SfhKPYmRk2T2QK1wuKMD1FoO3qORZ+U8qqisJuWrLpDUkKSWZElzCs4VsoHlwQZu
 xFJEagqm8XE1q6RAKdO9hCUdGUtWw4oIcVZCShWsawMHByShAbFZ2Di22/f0ZMlRP8GG
 NCC0stRv4OQxH1pW+t/Wjor3uFsA7F6Z5oWZwjMHxuk+xL7XusMD9bEwpzqbMCJurdX2
 doQbqsc4Cyw46z9NSNxiW+wjTKcEAxguPL+t0VRqL79PqalOOKPMFEgwJVtTmT4r3FGt
 Ubzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705481970; x=1706086770;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g++HePyerak7/LIfwpX5BYabmfrG24Knlw4vLCO7xvM=;
 b=AMlU8X98LthO4XW9bcx8rNM/13lJpcNYNNhK2sc4qforBsoE1LmLpKppKy8mH6/sTu
 Y9UOv2o9tpT7MNd0DJ6cZaL2QwXslr2QeHP6TU59iXI619JMDkl8DGZr+YHx2H8glPMx
 3Q+at0LtNBMX4K36N37Ea9Md1NFbVD3vlNr5USStKPCLw/laAUqqZ+kw4y6+HgWPf4VP
 4lFpixua0wz0OGBMDv9dSDU8HDNZ9xXH+zoCicbjXTkqACnbzqGx5iSNinKf4kbKbg14
 7RS2YoOiacXMKC7YvOGO94gBnGXr+RqZ5/y0Bi0cnNorJtAnRYRkmDOIjZpjyObiEPbI
 W7Zg==
X-Gm-Message-State: AOJu0Yw/MZRewt6QLi3ce7nQlhy4fBRn2vqo2edI0QpRUoo3SUGgr+fg
 T64vnkd2+F2eQ/php58anL3SIEGllHyRWQ==
X-Google-Smtp-Source: AGHT+IFtsU0PF/Tez5JpysL/vKTdGEqPysFdb6OdKK+nn3TB9hc5Xacxa66XqnZaaNogszr+OCeObQ==
X-Received: by 2002:a7b:c457:0:b0:40e:6703:cfb1 with SMTP id
 l23-20020a7bc457000000b0040e6703cfb1mr4954752wmi.15.1705481969858; 
 Wed, 17 Jan 2024 00:59:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1?
 ([2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1])
 by smtp.gmail.com with ESMTPSA id
 i19-20020a05600c355300b0040e76b60235sm10528547wmq.8.2024.01.17.00.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:59:29 -0800 (PST)
Message-ID: <940b34b4-f062-4b83-9c6b-f88ce9d174b0@linaro.org>
Date: Wed, 17 Jan 2024 09:59:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 05/17] video: dw_hdmi: Add setup_hpd hook
Content-Language: en-US, fr
To: Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, Andre Przywara <andre.przywara@arm.com>,
 Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Heiko Stuebner <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Da Xue <da.xue@libretech.co>, u-boot@lists.denx.de,
 Jagan Teki <jagan@edgeble.ai>
References: <20240117075154.58747-1-jagan@amarulasolutions.com>
 <20240117075154.58747-6-jagan@amarulasolutions.com>
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
In-Reply-To: <20240117075154.58747-6-jagan@amarulasolutions.com>
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
> Add support for DW HDMI Setup HPD status.
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
> index 989b7ab2db..ab4811cfc7 100644
> --- a/drivers/video/dw_hdmi.c
> +++ b/drivers/video/dw_hdmi.c
> @@ -1061,4 +1061,7 @@ void dw_hdmi_init(struct dw_hdmi *hdmi)
>   
>   	/* enable i2c client nack % arbitration error irq */
>   	hdmi_write(hdmi, ~0x44, HDMI_I2CM_CTLINT);
> +
> +	if (hdmi->ops && hdmi->ops->setup_hpd)
> +		hdmi->ops->setup_hpd(hdmi);
>   }
> diff --git a/include/dw_hdmi.h b/include/dw_hdmi.h
> index a1f0e64507..f4d66edace 100644
> --- a/include/dw_hdmi.h
> +++ b/include/dw_hdmi.h
> @@ -539,6 +539,7 @@ struct dw_hdmi;
>   struct dw_hdmi_phy_ops {
>   	int (*phy_set)(struct dw_hdmi *hdmi, uint mpixelclock);
>   	void (*read_hpd)(struct dw_hdmi *hdmi, bool hdp_status);
> +	void (*setup_hpd)(struct dw_hdmi *hdmi);
>   };
>   
>   struct dw_hdmi {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
