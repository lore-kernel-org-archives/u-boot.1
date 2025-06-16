Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90144C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4B780C93;
	Mon, 16 Jun 2025 09:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Bhe6FfqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6136281E18; Mon, 16 Jun 2025 09:47:43 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B5248007D
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2403370f8f.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 00:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750060061; x=1750664861; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BV3svweSgLAgKS8KoMKZwHmK/+FEUeUCrjF0qLw5rJA=;
 b=Bhe6FfqQkxqjMFBnBWnTp7aDCbcnuvHj3OSjSvbvo0RdHfUlgxPPiBH4DS4iAbDNDU
 mGn7KLdolJlgYgSb0BQqfLXxV/4m4BmJXW3KfRrQ89B9A3qWBonjalnFYyHUHyb8S+Su
 MxuZ8R4i1U0zaeNMlozp8Sl5EM1YUghTphdxZ87GRL73ppP14v+CwVSyve94f5/tdPyE
 YRfzACRTLdtk7oRoQMRU5KSVJLs4kxRqbSX6m1am5MuvjDlRezk+Jc25tplqW0EGemV8
 W/RlARLN9cI9jDBiaFNHhsHOzfcy/xUI8a1ReNWjhL9fD85V5uIlLx5gvLfegxMhSnbh
 7QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750060061; x=1750664861;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BV3svweSgLAgKS8KoMKZwHmK/+FEUeUCrjF0qLw5rJA=;
 b=H5asA38j50v9hF8dmTIvTndu8WPjpsZVvOhJTkqyqEN5GzKZxs5Aip7t8ifaOs7t6/
 Mm3YZ/vG3pnAgT77xP7HEDrXL+lApwU3UDjPdz+dJsKlyXjJ8R5QkmcHG5YnszKaYsPc
 MQbubj21ERC1g21zHtHWyNWCpdyYCdJsfIfir0D8tVn8jxCFq0hcuEI+59vaIfg+Yvbc
 JL4hWEjJOvK4lwxnYnzlyzR1HZuPxQ/sksq9Ztf2DLS1U+ruPnNM5u4APp+N6+IUkWmw
 gtAiNHEwPXijJnkfAGQLCBlZwYXMjHGU+J4PCOAoVFJnITTW+nTdXmHvnzDLTT3OBy/+
 SLGw==
X-Gm-Message-State: AOJu0Yw2ptlii9rL6c2Y8xrD7TGJDoBadZFD1I33FAV2DJTyQUufPdu/
 UEgMHoK64/yyGLcZwavNIeW3AHu6m5BfXJJo3KPZ4c+YQYCvt00mRfF7WDDSAX6LtvU=
X-Gm-Gg: ASbGncvwLJ24UZQgBRdlDuQUaXdFWmfPO08esXYezGYp3ms7ELyrpciicjnarKbngXS
 3tpB+HUOjq/eU/uoHWlmU1yfviTI0w6KGBAM8QPrlAlOFJnMfLxo2d4m3n+En/zV9fp5rWxqGdH
 eACBbhZ4esTnXN4+Y1yXCjAPubiUgpGDmyfghynUfCsOeGof0RfySInOFbscBa93pw3EIEmOUq7
 frlOraJSlwvJi4/QIqDVggJSiE38L/1lc7DjkB2ooqjnjGsqVTD9MP6lJSQYgRBsG49ry4hERsM
 pZOw4toL2xMUN+MQhrVBpNRZrTt4XmoomZP/SsuBFtygztb9EtfRcdpddbMSr9ET52Gv2oQdJR2
 xVBphBy1uk8u7W3WIpQ5GRN+qtG5xq6afV41x
X-Google-Smtp-Source: AGHT+IFdW21eCaTsl3CxcCDmnyDhqEmB9CzHeqPUPRN2/iwLCK6ScK+CbGitJ6gxrRB43LXYOTr6Rw==
X-Received: by 2002:a05:6000:2c12:b0:3a4:f8e9:cee0 with SMTP id
 ffacd0b85a97d-3a5723af507mr7021008f8f.40.1750060060802; 
 Mon, 16 Jun 2025 00:47:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6c7:97de:65a8:488a?
 ([2a01:e0a:3d9:2080:6c7:97de:65a8:488a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e25f207sm134993265e9.35.2025.06.16.00.47.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 00:47:40 -0700 (PDT)
Message-ID: <34f401cb-1ffa-4b72-adbd-402b48984a88@linaro.org>
Date: Mon, 16 Jun 2025 09:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 6/8] configs: qualcomm: use fragments for debug UART
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
 <20250613-b4-qcom-tooling-improvements-v4-6-7ea1c68779fa@linaro.org>
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
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-6-7ea1c68779fa@linaro.org>
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

On 13/06/2025 19:23, Casey Connolly wrote:
> The QCM6490 and QCS9100 targets always enable debug UART, but this is
> not really optimal for typical users.
> 
> Move these debug UART options to config fragments so that they aren't
> enabled by default.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   board/qualcomm/debug-qcm6490.config | 5 +++++
>   board/qualcomm/debug-qcs9100.config | 5 +++++
>   configs/qcm6490_defconfig           | 6 ------
>   configs/qcs9100_defconfig           | 6 ------
>   4 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/board/qualcomm/debug-qcm6490.config b/board/qualcomm/debug-qcm6490.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..9ea54758794ef9d2f698cb4026da44be2360147a
> --- /dev/null
> +++ b/board/qualcomm/debug-qcm6490.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x994000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> diff --git a/board/qualcomm/debug-qcs9100.config b/board/qualcomm/debug-qcs9100.config
> new file mode 100644
> index 0000000000000000000000000000000000000000..8ca042b440d100e9583ff9504f1b0e67a491dfcf
> --- /dev/null
> +++ b/board/qualcomm/debug-qcs9100.config
> @@ -0,0 +1,5 @@
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0xA8C000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 5ddc5ab3ef8cfe8f9cc09eb573c1a8130b394b43..54eb5dedaecb7a82c26a4bd7f5d1807ca6d4201c 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -7,14 +7,8 @@
>   
>   # Otherwise buildman thinks this isn't an ARM platform
>   CONFIG_ARM=y
>   
> -CONFIG_DEBUG_UART=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_BASE=0x994000
> -CONFIG_DEBUG_UART_MSM_GENI=y
> -CONFIG_DEBUG_UART_CLOCK=14745600
> -
>   # Address where U-Boot will be loaded
>   CONFIG_TEXT_BASE=0x9fc00000
>   CONFIG_REMAKE_ELF=y
>   
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> index 10ff4d2539803143c8b770b6b28e8dc52b1d5846..4ceeba63ec12cebbc2124eb256a255450500152f 100644
> --- a/configs/qcs9100_defconfig
> +++ b/configs/qcs9100_defconfig
> @@ -4,14 +4,8 @@
>   # a dedicated "uefi" partition for edk2/U-Boot)
>   
>   #include "qcom_defconfig"
>   
> -CONFIG_DEBUG_UART=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_BASE=0xA8C000
> -CONFIG_DEBUG_UART_MSM_GENI=y
> -CONFIG_DEBUG_UART_CLOCK=14745600
> -
>   # Address where U-Boot will be loaded
>   CONFIG_TEXT_BASE=0xaf000000
>   CONFIG_REMAKE_ELF=y
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
