Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB38C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 17:24:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DB8987CB7;
	Fri, 15 Mar 2024 18:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oSDUNh+X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62CA2870D2; Fri, 15 Mar 2024 18:24:45 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806E587CB7
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 18:24:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-413eee86528so15859155e9.3
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710523483; x=1711128283; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=4Tkk4CmByn1mZqe72G45G/3LfdTX7jRDBC4xFS13Y1c=;
 b=oSDUNh+XV4PmyGb/dtJTNKAHCosdiO/PqFNaoUdCt2Eck3Caz7iBA+Et+BmqD8LLvc
 T9c02+926BJWbi22DGFQGZCkkHmlzm1knjfR5QlR97Ojih8fj7L6wVVn1T/MzlYjOKvu
 cmfMFn7ZE2X7CMgq23hAFAP2ZWeqYuBFu5h8/2Ihsa/R+lUY5/ecYJTYrv9tUoXHieQu
 5t0kKoBCBgkXYT4vMt/U+J/m1lL6VMqHO6DxPlTtqLL9dhsYqlHcH0DK6hwH2hB1lgG5
 Fx86KCkJ0pTtCtIbw1WIwueI8NGFfOGRxhztx07qy5AtlxJd5yA3WnBePqEc09OdqBE+
 HXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710523483; x=1711128283;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=4Tkk4CmByn1mZqe72G45G/3LfdTX7jRDBC4xFS13Y1c=;
 b=oJ3GHow9QCrsGfKOA8R//0E3BgmWhheISDd/A66z0vnDwVPSyqA6coi29DvEg76G02
 uaiXsmppgmqAoTyan78owhL0cLLvfkFJdho+NvBwM/Mh51Il9tp7gNTA5XEbxCDLK6yO
 XBb/00AlVMp7AzCfGaq2I6EfOmoMsxKu5Uc77n/lZI6rdBA/15l8qoS1Ef9N48CPxEUY
 y2/h752Slef1TvnettTua0wlicVpVxKbdDstWJ6bsIKK3KaDeOKYI3+fyI35ah6/08du
 z41YZqr4TasQVEn366dP6nmE6aFtatGAD1/ttWGe6vgtIGNCXv7GZSOJWDY8WipQA3pf
 rimw==
X-Gm-Message-State: AOJu0YwoJ5LhIW0xUzSuG4OIAIx5B7zbT9sHjWIgkIKxXmL0hNhftH/b
 PteC02m63Xyrk+UaYbmyM8fzrsJyQvtLJNeSN6ZBzmev/jnEM6fBAtlbK1vksm0=
X-Google-Smtp-Source: AGHT+IF25axzNd/APU+fQxWPfblFzwVfFGRPQ9tJ13ub+8h6G++pmYiNCtrY8VceJFpp1Sr5NVWhkw==
X-Received: by 2002:a05:600c:1ca7:b0:413:1741:28b5 with SMTP id
 k39-20020a05600c1ca700b00413174128b5mr4440421wms.9.1710523482525; 
 Fri, 15 Mar 2024 10:24:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a633:992a:92cc:9c3?
 ([2a01:e0a:982:cbb0:a633:992a:92cc:9c3])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a05600c46cb00b0041312d21a35sm9684010wmo.7.2024.03.15.10.24.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Mar 2024 10:24:42 -0700 (PDT)
Message-ID: <a85c6220-89df-4cc0-9984-dfa065166a27@linaro.org>
Date: Fri, 15 Mar 2024 18:24:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 13/14] qcom_defconfig: enable livetree
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
 <20240315-b4-qcom-livetree-v2-13-ab635774b2dc@linaro.org>
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
In-Reply-To: <20240315-b4-qcom-livetree-v2-13-ab635774b2dc@linaro.org>
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

On 15/03/2024 16:10, Caleb Connolly wrote:
> Qualcomm FDTs are on the larger size, and with the addition of DT
> modifications during board_init() it makes sense to enable OF_LIVE
> globally. The cost of building the tree should be offset by the
> increased efficiency at which we can walk it.
> 
> Some rough measurements with CONFIG_BOOTSTAGE suggests that this might
> add 0.1-0.2ms to the boot-to-console time. However the reset-to-reset
> timer difference is in the range of 0.5ms so this could just be noise.
> 
> Suffice to say, no significant slow down.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index cbc612b44bd9..eebd0d74bd51 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -25,8 +25,11 @@ CONFIG_CMD_UFS=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_CAT=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_LOG=y
> +CONFIG_OF_LIVE=y
> +# CONFIG_NET is not set
> +# CONFIG_OFNODE_MULTI_TREE is not set
>   CONFIG_BUTTON_QCOM_PMIC=y
>   CONFIG_CLK=y
>   CONFIG_CLK_QCOM_QCS404=y
>   CONFIG_CLK_QCOM_SDM845=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
