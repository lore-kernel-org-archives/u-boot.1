Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD464C25B79
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 08:05:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 418E988412;
	Tue, 28 May 2024 10:05:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="R0foHlG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64ED18842E; Tue, 28 May 2024 10:05:11 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77E6087F31
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 10:05:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso512905f8f.1
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 01:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716883509; x=1717488309; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QY+9OwkTgcAQ8yfNt52lEm/R6KnrhEN9i2VAzhufzE4=;
 b=R0foHlG1k4SQYTEmXI0cNiW6qsuXx5NaWHqET1qGH4DH10xLzX36eZBMZZRLfHKePB
 6MGiSByb6gGk+bbtIcDalmAC0m2u/s4rVqFvdT/e2OQCDK96WWowe1+f/I2aTUsliwQg
 jcEQkD8fhixLrYpcxWEKIta6gzJUZSPSiMIMUtzLr2OZ86tRtN++jyl3ftpDL1QTjVxY
 DAe/dgLrn8fB07aij6MyefcegL5in7dDPwmL8Ql54jRTilGqnxZHQKpIpEYdnRLrIOqu
 24Rxbhnl4GByphy8NmKIZ0YHp4yroJiF9VraCV+ZxknNzgpupHi8qKzitK9ngc8Amhes
 KxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716883509; x=1717488309;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QY+9OwkTgcAQ8yfNt52lEm/R6KnrhEN9i2VAzhufzE4=;
 b=C+s03hT57PRNTp2TWFDKkg69rQHs8YfmLdXfzT4frD+1jTSvJ2dHT92TmfiQ+iEoAB
 EO/Ib/A6/vZ3dzEBdan3bb4hGPN7uI0nXwOb29+f8SqxPHcE5KgWRQKKiJG2XtaqvgCq
 D2yB6kz9ubTVdEJ2+lHOZ+aFv6C3mEp6W3nzOYQn2HkcPIE0geHImZoUuiRBMomULfxO
 LEWj1QJZPAmJ113CrZGwnNjaondVtBf/ABm8y0fLJqwHh21eEfS/Q4CiYkGNPKMrVq6B
 hjIlzKcYP44rSTG4MmQLkhg+wUFzRLYdxIwibdh4bAmz+Nl0eKSmAIvTlmWyJqjT+CBX
 SmBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4hCWvw1XbvnjyapU0tDAYf/wnn08ngUCb6lv70TJ5viA1fsPSSABrhV2Xb0AT7pu+ygaQgjfvebxS4z+7TL4OmbeqVw==
X-Gm-Message-State: AOJu0YyQgtVByLo5djMYBAyA3hICfBUigitLZ7wp3apAwwk4Mt62F2+B
 EYzcElNbh1sAsBMftM/gHuQY/oLx+J5mOlpN7OUSipkB4eMlrvhn4Lldz8ke4P4=
X-Google-Smtp-Source: AGHT+IEVaZbS5FzK051VaMvxpErLIwIgRdV/ML2P58q3x77XdyzYwhaelX4p8X0zhYnXBs5B637NKQ==
X-Received: by 2002:adf:e102:0:b0:35b:1d7a:4866 with SMTP id
 ffacd0b85a97d-35b1d7a4a0cmr865061f8f.10.1716883508858; 
 Tue, 28 May 2024 01:05:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8f19:f965:3f93:6385?
 ([2a01:e0a:982:cbb0:8f19:f965:3f93:6385])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a0909a7sm10918826f8f.55.2024.05.28.01.05.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 01:05:08 -0700 (PDT)
Message-ID: <65d4927c-dbdd-475e-ad2f-495083b21a7c@linaro.org>
Date: Tue, 28 May 2024 10:05:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 5/8] qcom_defconfig: savedefconfig
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20240527-b4-qcom-capsule-updates-v2-0-47583d7ad428@linaro.org>
 <20240527-b4-qcom-capsule-updates-v2-5-47583d7ad428@linaro.org>
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
In-Reply-To: <20240527-b4-qcom-capsule-updates-v2-5-47583d7ad428@linaro.org>
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

On 27/05/2024 19:17, Caleb Connolly wrote:
> run savedefconfig
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   configs/qcom_defconfig | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 65f13ae7a089..f2dfced4bc1e 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -1,17 +1,18 @@
>   CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_POSITION_INDEPENDENT=y
> +CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_ARCH_SNAPDRAGON=y
>   CONFIG_DEFAULT_DEVICE_TREE="qcom/sdm845-db845c"
>   CONFIG_SYS_LOAD_ADDR=0xA0000000
> -CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
>   CONFIG_BUTTON_CMD=y
>   CONFIG_FIT=y
>   CONFIG_FIT_VERBOSE=y
>   CONFIG_BOOTSTD_FULL=y
>   # CONFIG_BOOTMETH_VBE is not set
>   CONFIG_BOOTDELAY=1
> +CONFIG_OF_BOARD_SETUP=y
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
>   CONFIG_SYS_CBSIZE=512
>   CONFIG_LOG_MAX_LEVEL=9
> @@ -33,9 +34,8 @@ CONFIG_CMD_USB=y
>   CONFIG_CMD_CAT=y
>   CONFIG_CMD_BMP=y
>   CONFIG_CMD_LOG=y
>   CONFIG_OF_LIVE=y
> -CONFIG_OF_BOARD_SETUP=y
>   CONFIG_BUTTON_QCOM_PMIC=y
>   CONFIG_CLK=y
>   CONFIG_CLK_QCOM_QCM2290=y
>   CONFIG_CLK_QCOM_QCS404=y
> @@ -106,6 +106,5 @@ CONFIG_VIDEO_FONT_16X32=y
>   CONFIG_SYS_WHITE_ON_BLACK=y
>   CONFIG_NO_FB_CLEAR=y
>   CONFIG_VIDEO_SIMPLE=y
>   CONFIG_HEXDUMP=y
> -CONFIG_GENERATE_SMBIOS_TABLE=y
>   CONFIG_LMB_MAX_REGIONS=64
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
