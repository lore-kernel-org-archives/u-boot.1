Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7827BE7718F
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 15:13:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59F18035E;
	Fri,  3 Jan 2025 16:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XyncyVrC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCE798042F; Fri,  3 Jan 2025 16:13:12 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD35E801A0
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:13:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so4411936f8f.0
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 07:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735917190; x=1736521990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=78+Gh4RvzDEStyP5lR81C2z7naQUeeP1OYnYs5egVAc=;
 b=XyncyVrC1ZeiypI/Mh6MwjfuEDuAxHbd3RF6jEFtNhnf6XlHLbeyphDntZm17bVmtc
 T/KF65tvEMWtYeBZxirCz24PganmkA1D9XBRk0qwzs+IXmBhkNzdJu8lu9Eic61GI659
 Y41GZUew3YPdw210PimnEPG75RUFT4YiQxpyW2Jq7BSkMgG4tlRruyU6LjOU0diBBZqn
 2RDilT/7azXSaTrz2482fiiKfmM2CDJnrNRpfDWF/WF5oZGiNvU4VknsaXmyanwKZXAS
 LPTmcpy+hhJQax8+FbBFhtjal7CeYHigrLQKugG2jlAxwNgkjtrriy6JyscsjhZZVG3F
 A6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735917190; x=1736521990;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=78+Gh4RvzDEStyP5lR81C2z7naQUeeP1OYnYs5egVAc=;
 b=ns7fbT2TB52g0bs+vUcYUDNoBHiz2Xv7zckOG9YxKrcfpx+b2v525/wTniN8KTTnOi
 aqCQ+cVRG1Yt7kzXk0Dl/MH+2HWJSR2p7djbAq1wDX+I0FmHqHK2G9a5/l29UhMhXb6d
 TorzNzrEiJL8bgxjK4PzH5tHzCviKzGIJ18xBhvRm/VOjHVCVIbc1Zh9kI3fP5mYc7aD
 nD9UirGLATwtg/ZsGBMvoLJOt8GOTBlU7cP40bcwRoYdmm8sD2ZsVVzxggmRmcBoOLZu
 kuGlnE9S3MG/Jza3B7fLMGVhmF0ufRKASZrYN+nfquxO3cbKs2aLielE3M67b7Geu45x
 GSFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWadAWP68Y8VFdpCC5zqdwq0IHR/v3gCcraAy8h2Eypa1yaOoybOZBkotKS6sBMZY97ryxgqP8=@lists.denx.de
X-Gm-Message-State: AOJu0YxziwNyE9alFgnQccMffS7yFih5QOwFE2fGggxkCIfEfkx/mXHf
 gOvIAuIaemmleL0Iq/nqRN+zlsmFtJROM9maJ+gPlIj4HvU0A+1CXnHgGoBy3tA=
X-Gm-Gg: ASbGncurRoNg570Pg3n+JjsDQ6/GXgehAVlakKPPrmDoIR4Y9e/B5P7I5c1XVW3BaRT
 GQEfe99MZMttsfTwseJ16s6hn29sdslOAm+5RCA3vMJfPkHkCMAmQevqLkwmnuhhJK2foYCiPyC
 3n61KXCYDSRZ8nhWD4wjFxSz9AbcWvzAiSXSlJHG5VzdJ6b/cc7D2LgTXae5cmsimV6pwbRfL2u
 1LJeEb9zpQwvnMeI2lB7EDFzynJcId37JlqSi0am8zN+AXhkXkAHydPO0WH/oMDkGDTonqPZauS
 EiEs+mun72OCoxtwUHsgCbt+js0R0FA8Ww==
X-Google-Smtp-Source: AGHT+IFVWGCXq/kDCJ21jfm3QDp6kMCGVD1HLGY5TO8m4nfhthINGMz6JhmLFckS8TEbN0RGvf5HOw==
X-Received: by 2002:a5d:648d:0:b0:37e:d2b7:acd5 with SMTP id
 ffacd0b85a97d-38a221f2fc8mr45453186f8f.8.1735917190204; 
 Fri, 03 Jan 2025 07:13:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:3084:b2a4:688f:2d3a?
 ([2a01:e0a:982:cbb0:3084:b2a4:688f:2d3a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8ac97fsm40365333f8f.92.2025.01.03.07.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 07:13:09 -0800 (PST)
Message-ID: <533d2515-6e07-48ee-a643-560080b3dcb5@linaro.org>
Date: Fri, 3 Jan 2025 16:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 4/5] qcom_defconfig: enable SA8775P clock driver
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, sumit.garg@linaro.org, lukma@denx.de,
 seanga2@gmail.com, ilias.apalodimas@linaro.org, sjg@chromium.org,
 Volodymyr_Babchuk@epam.com, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
 <20250103051404.1965469-5-quic_varada@quicinc.com>
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
In-Reply-To: <20250103051404.1965469-5-quic_varada@quicinc.com>
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

On 03/01/2025 06:14, Varadarajan Narayanan wrote:
> Enable the SA8775P clock driver in the Qualcomm defconfig.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index cd94315f17..2cd5a5602e 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -48,6 +48,7 @@ CONFIG_CLK_QCOM_APQ8016=y
>   CONFIG_CLK_QCOM_APQ8096=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
> +CONFIG_CLK_QCOM_SA8775P=y
>   CONFIG_CLK_QCOM_SDM845=y
>   CONFIG_CLK_QCOM_SM6115=y
>   CONFIG_CLK_QCOM_SM8150=y

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
