Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C38FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478A188753;
	Fri, 19 Apr 2024 17:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AWkffWnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D499B8875E; Fri, 19 Apr 2024 17:20:43 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42E088753
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:20:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-418c0d83e61so22967745e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713540041; x=1714144841; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=fHpDk7i0IAPqRQcK81TTSOAHojBhqqayLe0QeFVsCbw=;
 b=AWkffWnlaN19iKkipx11qUk7a9+OuXYNFVyvfwobp0gTACSF/Xni7jhENBTnzuAesB
 iWGmpd+bQoj6mLqItacWvktWUtmTmEACcJ3h8Fngfs04ffO1SUBMViCcYFZYFXpJAYlj
 /XjJasxX2Q+IILyJkTD0pkuI/48AMUTFaqpBtpD2NrwnufjVJbF8Eie2XeVQUbp7Hw9e
 sJ7C5vEDRCWAYFfSf+VOYZaegooLN6VCyRNOek49VXM/cBvH6MlFPdWEyFFN8+Uvgn1L
 BJpaI3GzDlOzEdj77uWu/+P9WNsCZviKe705c5sbonBoLn1X7JIMvJL+pMmLwDqVlYAM
 1DPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540041; x=1714144841;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fHpDk7i0IAPqRQcK81TTSOAHojBhqqayLe0QeFVsCbw=;
 b=iOavWsbtQByIyM2BAV+V0bkdXOORtSvCgulnCZNgG9sVKd+YcXJzhipS499hf4gGhE
 C/uANv+Ju2uc/ecoEzErFT3NZ0BoYGjD81QM1PWbr1+WvQrhouVyBCS11K3qqDwDoz4O
 feYev5NYqb2ijDfEoDm7M0OpjU7RZT4Y9MtD3nwMOM/Z1MaT5lLUeqA755quWLHySn/i
 g3a5h8csAVdDPjLsDW8UeNJ28SzLpcZA57vS4t0SF1TbFpLdth8eBeUunuFSiexQO676
 0OpgU5VCBXFcGqeFHJU9Nk0d6ZZbyj+Yx49jWBXN8hFVKnplRcCwRGSLixSZKH3G6NNI
 He6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO1c//yx6RsaYIAotd5pRpJzJ92UrbCyCzFxMt9/+Lch5sghtTTMg1wYT4N7lt9+MyjCGpCFxBuBOnt+Hd+CdqUWomuQ==
X-Gm-Message-State: AOJu0Yzi9gpv38qZoGM51JsjCXSq1aVBJUmdKTYMrFubHTIM+1n87U0w
 m6yjT7gx+HjCw3rwVBnqDgQ33GMV7oVvG18Sx/f/m3vcoRjWCqtM0f20Wdkd2F8=
X-Google-Smtp-Source: AGHT+IG6Unoe44oZotVL35LNPsplrSsoGmfJsR+3Ui74Ou96qRiMVxPqB8q0gx8AHxooGgTvGf8k1w==
X-Received: by 2002:a05:600c:5021:b0:418:ff78:3e72 with SMTP id
 n33-20020a05600c502100b00418ff783e72mr2537136wmr.41.1713540041338; 
 Fri, 19 Apr 2024 08:20:41 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
 by smtp.gmail.com with ESMTPSA id
 ay23-20020a05600c1e1700b00419d3de56bbsm235194wmb.23.2024.04.19.08.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 08:20:41 -0700 (PDT)
Message-ID: <d0ea52e8-bac8-446b-8e82-15eace7e2032@linaro.org>
Date: Fri, 19 Apr 2024 17:20:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] arm: dts: drop qcom dts files
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
 <20240418-b4-qcom-rbx-fixes-v1-2-e524eb29ae86@linaro.org>
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
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-2-e524eb29ae86@linaro.org>
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

On 18/04/2024 19:24, Caleb Connolly wrote:
> These files are all identical (or older) than those in dts/upstream.
> Drop them as we now use upstream DTS files with OF_UPSTREAM.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/dts/apq8016-sbc.dts                |  729 ----
>   arch/arm/dts/apq8096-db820c.dts             | 1137 ------
>   arch/arm/dts/msm8916-pm8916.dtsi            |  157 -
>   arch/arm/dts/msm8916.dtsi                   | 2702 -------------
>   arch/arm/dts/msm8996.dtsi                   | 3884 ------------------
>   arch/arm/dts/pm8916.dtsi                    |  178 -
>   arch/arm/dts/pm8994.dtsi                    |  152 -
>   arch/arm/dts/pm8998.dtsi                    |  130 -
>   arch/arm/dts/pmi8994.dtsi                   |   65 -
>   arch/arm/dts/pmi8998.dtsi                   |   98 -
>   arch/arm/dts/pms405.dtsi                    |  149 -
>   arch/arm/dts/qcs404-evb-4000.dts            |   96 -
>   arch/arm/dts/qcs404-evb.dtsi                |  389 --
>   arch/arm/dts/qcs404.dtsi                    | 1829 ---------
>   arch/arm/dts/sdm845-db845c.dts              | 1190 ------
>   arch/arm/dts/sdm845-samsung-starqltechn.dts |  460 ---
>   arch/arm/dts/sdm845-wcd9340.dtsi            |   86 -
>   arch/arm/dts/sdm845.dtsi                    | 5752 ---------------------------
>   18 files changed, 19183 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

