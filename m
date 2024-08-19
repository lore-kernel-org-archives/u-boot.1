Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E5FC3DA4A
	for <u-boot@archiver.kernel.org>; Mon, 19 Aug 2024 11:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA50887D1;
	Mon, 19 Aug 2024 13:49:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yCwm6LJR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E95C887D1; Mon, 19 Aug 2024 13:49:55 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAEA87E15
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 13:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42808071810so33679675e9.1
 for <u-boot@lists.denx.de>; Mon, 19 Aug 2024 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724068193; x=1724672993; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DZbC1oYQ97gmJAawVPC74gcosqxbQNboua+FgcrsW90=;
 b=yCwm6LJRrDM+JozOJJ2ZOkLS9dx8wWJH/hQeB1KwMsaCRRZT+UnsuSUVyabNeuiDjy
 PtksIB8+wkSkCRFcf1M62yjkbhmwe4x4DWmazVB29yTCmgNDJS/HI6kseajjGKbXHZ1e
 WRNUHvcdvxvhHerHltZ7lKQ56UjodqMbR+2zbzicDk0/AwD2VYLS6+WCeqsNI/cZTgk+
 P3DNBc8SxKPNadru67kyjQq8KiXKFVUV1azNLJtnTT2J11DYnxirLf5EICiMa1lb0+Rb
 eP8zlj5XFPf0iO6J8bR91wHp3cTJD0coYrXBDPHLiC0SYFXuvojMGs3QlrNlxO5ipjqy
 dJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724068193; x=1724672993;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DZbC1oYQ97gmJAawVPC74gcosqxbQNboua+FgcrsW90=;
 b=izkgkMhOAzpEhi/YTRk7xjKLzhjHp/aEezXjyvoLTWP/AgGUfj9+tsAKzndG2uw3Gk
 Pcl47uEZWEE/ySJZClGmvFfUXvtHCZr+VCGoIL4shT2jNb34HdEjkdoSscpURik+MkNP
 HB5smQAxBveIlCFUh1tRt/umlzNQLNBu+MQrVnB2hZmjI88e0keFKOX5OGwySSyDG5lk
 owtS8Qh18ZbG5d085it8WiC+K4b7Vd8uG1M9cLZ6n8aoGOKTFbr8UXXITGGUHhLskPse
 y4AmrxzAoEQL32zN4UwDZYO6Tgl7w/8y2yNFt8zGPA1vK7v+aMPcCoeRIxuVAnwjdNIA
 n3AA==
X-Gm-Message-State: AOJu0YygnsCDeoKjLNmfAFKQw3veZCcFxTYmCT/A8YWCeHSqQFUQQn1l
 dygEHK5rLx06pu6j74cwpN7cZhVEfdguYFTwA7F2/zyG2tC8wYX91GWTWpcFSCk=
X-Google-Smtp-Source: AGHT+IFp856eiT7gB1p4bzXh4m24SfHlAWKpNNx8bdwHBTVyhffppNU8ffMGz5gL/6MuTGt5IzY0dg==
X-Received: by 2002:a05:600c:3114:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-429ed79b8d5mr82432605e9.10.1724068192353; 
 Mon, 19 Aug 2024 04:49:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:f54e:4b0a:5175:5727?
 ([2a01:e0a:982:cbb0:f54e:4b0a:5175:5727])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ed648f0csm107567455e9.9.2024.08.19.04.49.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Aug 2024 04:49:51 -0700 (PDT)
Message-ID: <7edce5a1-ed7c-4d69-be86-13b75806217e@linaro.org>
Date: Mon, 19 Aug 2024 13:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 5/7] qcom_defconfig: enable SC7280 clocks
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
 <20240809-b4-rb3gen2-v1-5-7c73fe05b37a@linaro.org>
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
In-Reply-To: <20240809-b4-rb3gen2-v1-5-7c73fe05b37a@linaro.org>
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

On 09/08/2024 02:48, Caleb Connolly wrote:
> Enable clocks on SC7280
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 24b71ba7be29..1a079264a554 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -44,8 +44,9 @@ CONFIG_CLK=y
>   CONFIG_CLK_QCOM_APQ8016=y
>   CONFIG_CLK_QCOM_APQ8096=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
> +CONFIG_CLK_QCOM_SC7280=y
>   CONFIG_CLK_QCOM_SDM845=y
>   CONFIG_CLK_QCOM_SM6115=y
>   CONFIG_CLK_QCOM_SM8250=y
>   CONFIG_CLK_QCOM_SM8550=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
