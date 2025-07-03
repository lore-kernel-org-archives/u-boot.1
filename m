Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C721C77B7C
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 07:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDF0282A76;
	Thu,  3 Jul 2025 09:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JAHHBEla";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136B882CFA; Thu,  3 Jul 2025 09:32:53 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA77D81FEE
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 09:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a54700a463so362639f8f.1
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 00:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751527970; x=1752132770; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=6d+3CgYJCfXTS3bj1I/J/6+kdX+n8W10egf7B0KeCDM=;
 b=JAHHBElaQ5oqCFeWEbLnLxrzNP8J5SbZhTeuoq9b+RDCu0tF8vQ9HSbYjwlLcW8dc5
 udcnXu79oS01mzobbuDcXBWrN9Lku7ph76zcheKS/hGmy7FJRxzTMY1csKRTpIq3sMoJ
 bNud7SEMHef9qvlo85x0Ts2fZUX1zz+Qqt01irZUfbq05DWu76kIQpbUwUw547b3yFRF
 JdEA+tjk42CPYF7ZzlF7fIA+epWlRA+peNe1GNcvaSA8bzqmrI1m+Hd/6qhu3s6Wk97O
 QJ3GWECg2jrb/UNquZ4snIVD4awSeJn2cQZ53Ykcjqj2sYZ6KKNb9GtNkhZTURtR2bzd
 iafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751527970; x=1752132770;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6d+3CgYJCfXTS3bj1I/J/6+kdX+n8W10egf7B0KeCDM=;
 b=QiWR6nH5ZIURkQXrA8MLg3xSqWRopZal+84+O1A48DcIFepuG4QmmRN6wTKMVdc49G
 P/olPmB8v0rVd/kpV4Tn6/7ETDbrV8A2ZprKM4ga9gm4EK8OtbxX1ltNgVN+tO0yoROs
 OS8fH1Mvfc+HhcX1nAu86pCTXSUeYNbr7lFv95ryLJ9HWgMxXbAXwvo+qVIDJznGSH70
 ZfMVppyckwt0wFK0NpNP7M7/FgvNMjf9ChF5avL+nNOEYagVY5BmT6DJY8OE8Fi+x7pr
 gYNUDBDJQgM+wT4V6rs29E9qj9vuvJdd48HjMXyaFO/fomWnAjZW4BkjwJJ74uxEYcRo
 zjCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKAsmcCrAGNWyrBnf7VH0vt9l8lkxYWtycDi8I1MLs+ja8nScUQ9cekj5p3hJRx8z4Jiyhi+A=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1AGxJk2ndasECmBNw0U3ehtvkfU5BWVqNrC2LHge6Tu8CJp1C
 IP5aanziswzuYpRJJI+rlQmoJgziGH8kTUEPjWPvsrXOmoETPyRT1U9jElrBI7x03yo=
X-Gm-Gg: ASbGncuBhMMBKt/aMmKttXR00SZOHwatZbm7pnaxwE3p8GRAnJEmZAA4G67E8opp0tU
 0OCZtblAdNNhDZYXbNQkdEypprkrsP4/q3ENvQmZFydKy+Pra0+I9NLrMU6G1l9lDeCPQVIoEH8
 Datbf0djLNpEm4wvvyAY+WEZjMMm89K8JU03XVF0oS5crjU8FcoZSoZJYIixTechm4ySgiTqJX2
 KBGgIpV/e+Y1FtwhYvPKORJIjZhB3B6ZUc73AV1SAo1Q+z6tKSGEWNI9VnvtlzeLo1Dk2WhZ5Gj
 BlvtFbJXZvsB0KUTa0v4WOFd9PhW1rG3HcNfCkCYS84FXwN4lGW/5dbasrS6FwZBqO9LYG96QAL
 MEcUSOtsGAU3mN0piuPjfy4UdkZPA5HgUB2SlPIA=
X-Google-Smtp-Source: AGHT+IGwqf4wZSmNKPkyWlDetxXiM2Zdqh6ONuL4sn2YjZopjw1TRIOixNvkE89bvGNeADliKASFaw==
X-Received: by 2002:a05:6000:4026:b0:3a5:6860:f47f with SMTP id
 ffacd0b85a97d-3b34281c3efmr1322043f8f.6.1751527970062; 
 Thu, 03 Jul 2025 00:32:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4232:f5b9:37fe:c24f?
 ([2a01:e0a:3d9:2080:4232:f5b9:37fe:c24f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b50bsm17681188f8f.42.2025.07.03.00.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 00:32:49 -0700 (PDT)
Message-ID: <8469298d-1e3e-420d-a5f6-7caa9b130988@linaro.org>
Date: Thu, 3 Jul 2025 09:32:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/4] configs: qcom: Add OF_LIVE_SA8775P &
 QCOM_POWER_DOMAIN config
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, trini@konsulko.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, jh80.chung@samsung.com,
 ilias.apalodimas@linaro.org, rui.silva@linaro.org, me@samcday.com,
 christopher.obbard@linaro.org, quic_varada@quicinc.com,
 sughosh.ganu@linaro.org, balaji.selvanathan@oss.qualcomm.com,
 miquel.raynal@bootlin.com, sjg@chromium.org, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250702180133.1889709-1-aswin.murugan@oss.qualcomm.com>
 <20250702180133.1889709-5-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20250702180133.1889709-5-aswin.murugan@oss.qualcomm.com>
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

On 02/07/2025 20:01, Aswin Murugan wrote:
> Enable QCOM_POWER_DOMAIN & OF_LIVE_SA8775P config for qcs9100

Please fixup the commit message and subject, because there's no OF_LIVE_SA8775P
nor qcs9100 config.

Neil

> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> v3:
> - Removed OF_LIVE_SA8775P config, since there is no SA8775p specific fixups are done
> 
> v2:
> - No changes to this patch in v2
> ---
>   configs/qcom_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index b8399701da0..f7780c06454 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -123,6 +123,7 @@ CONFIG_MSM_SERIAL=y
>   CONFIG_MSM_GENI_SERIAL=y
>   CONFIG_SOC_QCOM=y
>   CONFIG_QCOM_COMMAND_DB=y
> +CONFIG_QCOM_POWER_DOMAIN=y
>   CONFIG_QCOM_RPMH=y
>   CONFIG_SPMI_MSM=y
>   CONFIG_SYSINFO=y

