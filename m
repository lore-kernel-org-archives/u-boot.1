Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA2AC4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 15:21:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD75888766;
	Fri, 19 Apr 2024 17:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FtLYLe1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28C4F88766; Fri, 19 Apr 2024 17:21:42 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63B318875F
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4199332c1dcso3751075e9.3
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713540099; x=1714144899; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DIP3Rljanh4ScHkOyM8Q8ie1EPgPeAZRpw3RHrqT3Hg=;
 b=FtLYLe1NJx44Nuy4h/VqJPihErtBlKWn+QpjNDJz6Eht5Pgt64hCCfVY8PUdahQK4a
 BehQGqHN8+ToFzKYcTSY15O/B746WB9rTErFW+cdzHlP4RjgZqAtkZEiilagiVZvTGrd
 lhMsD4bgVcr7+IXMboAB8XYnKt+WCdMwiHJDHUezDNCZ4KY5G4c8oNBgwe68jv54W23O
 I5+84qrzOk50l49jfHV2DXOAOTSzsB8B+ctWCiTL3uagbx+LF7A9AHBUrPBYipYlRPoN
 J99U18a1fZ36xtrgFXOAhLYeTGxcJCqkjzUYpW9dtg8cIu9xGs4clyU7bwK7QNScvUuK
 k5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713540099; x=1714144899;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DIP3Rljanh4ScHkOyM8Q8ie1EPgPeAZRpw3RHrqT3Hg=;
 b=FuDtEuWer+t78wxuSqmUFfEWP1EQwFBEU2Yb1qMXIHyHugopWGVZ8g5DPWqCEoQmgf
 jlocCr3W/D/O6/Km2sAFaXKHOjlZqPVZvefRHdIhSQaVZSd5ghBRkXpOlGZLgAmCK1jX
 W+0X51ApAcARoUvuzbNOlp6MSlqarjmHxbpkQJgET5SdWAA42IO6Phkn4JYLnPhxEPym
 03WUxASb2GwUCR69tkqBYa5bOyFR/gs9JXBgOmfEM5qN5h+zaZIqyzeLKEH4VQk0stRK
 u8rDTiiPXkLd/y2M5AyRzHO/KHF1FEL58Eu2ofIF2KF32R5gUBFHRJvBMnM0XGNVZsJv
 yt4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIdcJpiWpV9WlO2sCjHDkBvt+6PNEyqsepFIsOSLMv0DykVJdzo22GRExcIvb8DFavPiurGQM05rgwgbUmbqKVe4muBw==
X-Gm-Message-State: AOJu0YyTOUr1HrFRGTZ6bZ1hlrfpaKWoy9e409FcxNlfGNPSU84APi55
 hu0/iYZokmW2bNZP4u9vMqfh94JSIWU+0JLsITh2SqZC33MAsf5GtXPYOImqfbE=
X-Google-Smtp-Source: AGHT+IFcZy6ZMDlT+I+5n4yu7kXhtk0QWEXZnZ7rP1Y6x4m36hSb+YpY2HUipwfvF8WCfRizxJ5Hug==
X-Received: by 2002:a05:600c:1987:b0:417:d4f5:6501 with SMTP id
 t7-20020a05600c198700b00417d4f56501mr1887005wmq.27.1713540098732; 
 Fri, 19 Apr 2024 08:21:38 -0700 (PDT)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
 by smtp.gmail.com with ESMTPSA id
 fk4-20020a05600c0cc400b00419c8e2bc3csm899689wmb.6.2024.04.19.08.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 08:21:38 -0700 (PDT)
Message-ID: <716a0c7d-97af-4732-8148-5f0e3c7518e8@linaro.org>
Date: Fri, 19 Apr 2024 17:21:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] qcom_defconfig: set SYS_INIT_SP_BSS_OFFSET
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
 <20240418-b4-qcom-rbx-fixes-v1-3-e524eb29ae86@linaro.org>
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
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-3-e524eb29ae86@linaro.org>
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
> Give us lots of room for the appended FDT.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 218a9a769682..7b589f0bf7a7 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -3,8 +3,9 @@ CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_POSITION_INDEPENDENT=y
>   CONFIG_ARCH_SNAPDRAGON=y
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>   CONFIG_SYS_LOAD_ADDR=0x0
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_BUTTON_CMD=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_BOOTSTD_FULL=y
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
