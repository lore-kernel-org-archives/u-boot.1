Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CDBCD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52F0D836AC;
	Wed, 13 May 2026 09:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YXYWh2cI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0238283E36; Wed, 13 May 2026 09:32:48 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A7AE8056B
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso58174465e9.3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778657564; x=1779262364; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=gyoLF9XKLhUGlGizujxAtJ7u3Ql2riA42P7OQDTMrFY=;
 b=YXYWh2cIj8JiF/4cR/ftKxExPZJYo2qN8ZnlegfSHYtNX0CniAoZu2OmyW2wYUZ3hf
 uIB4NIw1oFTQGvzARN1Mu8WFC85mfBLvBekEyX+a9BERBrqlGIoXRv3aDTN6y0idCTbm
 cdQJNXffGmiRLf1GCybw+X1/z1KHtwXBFgvIGoYpOr0yWvmQPNH4J/Ya4Zu2u+W7qNCA
 Qg6U5VDax43S0irmGn38OW0m0iO6RLJ+lkWA458KsTBbNtJuJ8X+zoRjddmVccQoae9R
 vfyrdegXj+Rc/pc05OK5SuowXRMVzyEMxBj34G/561bzNajj/057PatX2NDF9wnDMb1N
 2oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778657564; x=1779262364;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyoLF9XKLhUGlGizujxAtJ7u3Ql2riA42P7OQDTMrFY=;
 b=Gq7A8Gg/H4g/MkbDZa6NvmETUFEpMA4th0+WXNJhuIDmLIRnpiEDXYbsvIESpWX0bZ
 L+t2Mkl4VTla4L3FHEizOlA9Odf0IRYtB6ahMjCi/Yf7w9NYgbqh87GX0ARxedUpTyUi
 pwVT7FONbFjlNIbF6HvyL5mihs09hownPHfygd23VOvpu9IRPT6iwtivmuSxuM/Q/ELP
 EgCUe5Lc66PERvJqBDjTRdUQjZ3fLb2nQXn464cJcGWE5QeRmzroVdIddqPC2nK2kIyh
 X4H3slrkuGjYv0iJRkhqInCG5RwBzgCRIPecjrGLCAXRfzFl9wwFlUv5zj2psUvvNJwT
 ftww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Zy+d/0DizcN/BEFSj63LATZ+2NkwirUsFK5Vw2M6y4QXe5d2f3x57xY+IOnDP0EWUTddRFGY=@lists.denx.de
X-Gm-Message-State: AOJu0YwRifyUaRP0TKzmFI1xlmSC9TZMvxT8p99795mDLulmF8qvAH9a
 z0FzBZWBtBZ1vpNdmvw94BF4QD0NYC/Z0ERUNvHxdabhnXiYtqWniHU0mociUpgpCus=
X-Gm-Gg: Acq92OEooqs4X3R6VS1JP2tRTV8w6RyV04NcEc7cpy8P/4Yb8JU/iVzcY5xu7wrpAsr
 Vkiik6m9zKne5BWAoMtDXJphBcAUARqkAnhQDmlOGPk7v6vSrNIIbpYKqlfPb2V87PEVrVdzvdY
 181zpV9topiBYe/f6mHeTsXWr+yLvo1iIQxazxpvoG/1AvcxR3JeMEwCT4PF/xwymyHUZ90d9/Q
 R9eNm5H+7Sfmb8+pbIffMcXW9HYtkKvdqs4bYEitP9cANQ8ZB9hDaVGtkSjM+dptiLcwts8ulkt
 b1uE4Z+BYOnDmBOiekMzzFwepKruqT+LRIVKqMuOs+UVfbO5wU9tpk/lXsIlh2hkahOfxsh/OGg
 q1lAtk2ZVedWm4JUBr/ntXKj/8Grz5PZIaM/iMpyc+iLyAooSpdbkAJgaMFHc+755JJn6Oqt7n5
 /oN8FnAM+tvj2J0zCb66WwZTxcSoZgeAK2wmcQi/wWvSgZOfmREd4Yj7YCoRksQPTyQosMEQnWi
 ox+
X-Received: by 2002:a05:600c:1f91:b0:48a:7965:b943 with SMTP id
 5b1f17b1804b1-48fcea26600mr18891455e9.29.1778657563759; 
 Wed, 13 May 2026 00:32:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:6ee4:8e37:145:d60b?
 ([2a01:e0a:106d:1080:6ee4:8e37:145:d60b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f41b0b1sm64601865e9.8.2026.05.13.00.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 00:32:43 -0700 (PDT)
Message-ID: <85323751-c371-44f9-9cda-df1ddbba1f1e@linaro.org>
Date: Wed, 13 May 2026 09:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] phy: qcom: Add SM6115 and SM6125 to QMP UFS PHY driver
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
 <20260512-ufs-sm61x5-v1-1-c022cf988e89@gmail.com>
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
In-Reply-To: <20260512-ufs-sm61x5-v1-1-c022cf988e89@gmail.com>
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

On 5/12/26 16:44, Biswapriyo Nath wrote:
> The UFS on SM6125 can reuse SM6115 configuration, just like Linux.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 80eba734a633..3df88189a907 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -1741,6 +1741,8 @@ static const struct udevice_id qmp_ufs_ids[] = {
>   	{ .compatible = "qcom,milos-qmp-ufs-phy", .data = (ulong)&milos_ufsphy_cfg, },
>   	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
>   	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
> +	{ .compatible = "qcom,sm6115-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
> +	{ .compatible = "qcom,sm6125-qmp-ufs-phy", .data = (ulong)&sm6115_ufsphy_cfg, },
>   	{ .compatible = "qcom,sm6350-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
>   	{ .compatible = "qcom,sm7150-qmp-ufs-phy", .data = (ulong)&sm7150_ufsphy_cfg },
>   	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
