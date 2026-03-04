Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594FFEF9002
	for <u-boot@archiver.kernel.org>; Wed,  4 Mar 2026 16:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF3A8838BB;
	Wed,  4 Mar 2026 17:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U/CwEook";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D62ED83AA9; Wed,  4 Mar 2026 17:17:39 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CE083642
 for <u-boot@lists.denx.de>; Wed,  4 Mar 2026 17:17:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so60432335e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Mar 2026 08:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772641056; x=1773245856; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=PRJd8X6zl8QyZLiDiXVWAQZJ1GByTpABIJ3R/9x7JSM=;
 b=U/CwEookoEEtTXaPKNX8RLfA8TQmS5Qk6NOthcrK1zM3koVhpTKUrfY/KkGmkbJnEL
 6sMJPv/nO138bjnfjSRNqGeEREXE2tjVEjjeWRMrc8I54spi6mzGU5rlloI1KEDRWC2m
 4hYnshfgaAzpM0kSsE+4ou+v/ZjtVYNQizfttjKlFJqBEXqqQDyqxeQjkXAesVA2yD24
 GJBfGD3w+DQ+++gXvdzFdGbgEIVrYuwt0uRPPK87oDDkdQlp9RK2ItaUIn/OHQxThQkz
 Ol4Hloo+o737iec5KlucH/rIqnlYvjOL9YGngF1NWYO5jwOyn+XlsIykShmuJ96prbQH
 LlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772641056; x=1773245856;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PRJd8X6zl8QyZLiDiXVWAQZJ1GByTpABIJ3R/9x7JSM=;
 b=Z/aDUI9boo36lqoSJ5MAj2dy8H5f9jQXq1MDNFXqQb7jCmmR1TMgrOj1romXUaFc52
 sxOHKAo1ujHbgoD+jaIlRA4b+Em8A5J65y3zYZUfdLiEAJETg25F53b39zxPR2Hie/TU
 PkYFWNYLG8iO1veK04zxYxRX7Iy3M+0NBWI1nP8sFgWuT/kCfKprBvG636rd3fsTmCps
 kcBZvBpCBLtuxtIj40dFW/ZMiVZMIb4QhGt1RqY1lyWRhRl7sUDehDKi8cgzyln0CIeO
 JGdBhT1jCN3ngBV58y8fNRlCZenyUiqFnZwGI93SsbUW690msbZ+Vlzbx2BRosgnDr9q
 K7XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtcfJzu9Iv99xaI8C/71gZI+mqzZmy52yqJuflf4PG75RArdlfYhEWd3CxMlV/L1hxv9ZBrdQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwMJ9AVR4Xyrmr24AxZ9ihSUlJY0WCCXM2i+U/enuEnZTpaUtJM
 LbQasnoormaJTt/u0mGmh3m+Y+E1lU2BGYSe8DJPTpUG5IFdhC8+YQELFOU3b/VuNkc=
X-Gm-Gg: ATEYQzxEZeOzrjm1rdA2pEr2m3zWcgE37pqeSBNqri4gCwww7Ofo52Gwx04V3zHG0tQ
 3tg3ttyJ1Ff5lJ6qMltPm+6ANbOFYuKETqImFFvU5mj/96BSJKqVnf0wnpKcNg5yjT+nQ+kDHDM
 l9S4pUoZmMNnScJb8aep1HjnojfMe6kck0gnpjm7OuEdvjkoRu3PU9nLj+ch8cBJsvap/sDPi1x
 v2Gd68LeUcVKJwCvuDjQ2fscb7+gmuefNib52AnH5CJpFHis7qW2UnMm/EG+4x2Ezf9MMojwfq8
 12tAlFOG3KuvdmKus/TZLjWBIE9K4mqgJzIVDR4NxrcCoeUe5BhebIdBokqHqIeFgfZn64SEX9B
 aMCSMeU13sW6hv8slwE5H7Mj4HX5S/KYiPRX1Q/irK4OzXKgOeT8qgKq/wTveSJoWhyLZZ+qgWP
 AmshRCG3T4Wt7+LWk5+eG89wgwOiXdrHv6lAfM4nKYwTSMs74j9Fv3MomARYImA6DIXQV+AtK9r
 lrI
X-Received: by 2002:a05:600c:8b54:b0:47e:e20e:bbb4 with SMTP id
 5b1f17b1804b1-485198a38b2mr39776985e9.26.1772641056017; 
 Wed, 04 Mar 2026 08:17:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:da6:dde3:e477:94d2?
 ([2a01:e0a:106d:1080:da6:dde3:e477:94d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b6d540b2sm24410650f8f.36.2026.03.04.08.17.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 08:17:35 -0800 (PST)
Message-ID: <405d7b14-fdb3-4ee6-a986-3951053ff319@linaro.org>
Date: Wed, 4 Mar 2026 17:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/3] drivers: ufs: add helper for phy_initialization
 callback
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Shawn Lin
 <shawn.lin@rock-chips.com>, Bryan Brattlof <bb@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Jared McArthur <j-mcarthur@ti.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Michal Simek <michal.simek@amd.com>, dlechner@baylibre.com
References: <20260210-ufs-ufs_hba_ops-cleanup-v2-0-dd73da21aa92@baylibre.com>
 <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
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
In-Reply-To: <20260210-ufs-ufs_hba_ops-cleanup-v2-2-dd73da21aa92@baylibre.com>
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

On 2/10/26 17:22, Julien Stephan wrote:
> Introduce ufshcd_ops_phy_initialization() as a helper for invoking the
> phy_initialization callback from ufs_hba_ops.
> 
> This mirrors the existing helper pattern used for other ufs_hba_ops
> callbacks and keeps the call sites consistent and easier to maintain.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
>   drivers/ufs/ufs-rockchip.c | 10 ++++------
>   drivers/ufs/ufs.h          |  8 ++++++++
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-rockchip.c b/drivers/ufs/ufs-rockchip.c
> index 0384244387d..cad753d5990 100644
> --- a/drivers/ufs/ufs-rockchip.c
> +++ b/drivers/ufs/ufs-rockchip.c
> @@ -30,12 +30,10 @@ static int ufs_rockchip_hce_enable_notify(struct ufs_hba *hba,
>   	ufshcd_dme_reset(hba);
>   	ufshcd_dme_enable(hba);
>   
> -	if (hba->ops->phy_initialization) {
> -		err = hba->ops->phy_initialization(hba);
> -		if (err)
> -			dev_err(hba->dev,
> -				"Phy init failed (%d)\n", err);
> -	}
> +	ret = ufshcd_ops_phy_initialization(hba);
> +	if (err)
> +		dev_err(hba->dev,
> +			"Phy init failed (%d)\n", err);

So this fails with:
drivers/ufs/ufs-rockchip.c:32:9: error: 'ret' undeclared (first use in this function)
2342
    32 |         ret = ufshcd_ops_phy_initialization(hba);


It should probably be: "err ="

I'll drop this serie from the PR, please fix and resend a new version.

Neil

>   
>   	return err;
>   }
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index bc839a43704..74125b1ab31 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -756,6 +756,14 @@ static inline int ufshcd_ops_link_startup_notify(struct ufs_hba *hba,
>   	return 0;
>   }
>   
> +static inline int ufshcd_ops_phy_initialization(struct ufs_hba *hba)
> +{
> +	if (hba->ops && hba->ops->phy_initialization)
> +		return hba->ops->phy_initialization(hba);
> +
> +	return 0;
> +}
> +
>   static inline int ufshcd_vops_device_reset(struct ufs_hba *hba)
>   {
>   	if (hba->ops && hba->ops->device_reset)
> 

