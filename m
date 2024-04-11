Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48097CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 07:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D68F881B2;
	Thu, 11 Apr 2024 09:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IyvxZ1l/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E037F881BD; Thu, 11 Apr 2024 09:07:39 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58F7287F3F
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 09:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-345522f7c32so1382798f8f.0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 00:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712819257; x=1713424057; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=YGRD04OJy+tvcvfQIIP+W5sFikDkwNFTKBYqBoXy26Y=;
 b=IyvxZ1l/jHmsjWjvYyKoUTwDlXryOflymLIhbWUN/MLA1exlQ1XiEoepSJrcr+rVYY
 jVBGz+d+OC0B8o2qbDukmBfqsLJrcQ2hT7ouphYjkiIjlUXHZ+6+Zqcqbxmd+bQ8aOP9
 G9L7gC9sfG1C6xwTLvG/KU1pP7DscPBxuXljYVA4jLzNEukbziuHn/b1MTyEUiaDlRtt
 hLTwf27cm3eiRNZ5eyUQ6LniAPl/Pi+4TQnjC51s6YkXE0ckRjWvMIZBMNFHuXjJ++0X
 XSKMLWfK6qUOYeLGpLHsh9YqB36RkbrBz8z9/nbSGP2qHK9TkaRcVeGJzcKp0GQy4onV
 2/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712819257; x=1713424057;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YGRD04OJy+tvcvfQIIP+W5sFikDkwNFTKBYqBoXy26Y=;
 b=LoSfkI1y5qEe+HYzxur9VFLwKH1tGN68x6dXV7qD7CCj1fWVecn5AHWVmPqYQEHG1z
 kmW9hviaWpaZH5ikhZ0ywYFgddJKVscmUjIvPUyy5wSQjNEr6hT2iU+yaucRba4EXRDW
 eBPdBFqjcYooJ7WsUl1sKRyDBQzCLhvFnHx77boCgHWtm/Uia6z+e7KpKVAfEC8wK7zN
 OMmF0aTdUeK37vPRM3gjTf4Rc6JfHcJuzkD1yyZ5ABt7Rgap+nHXOBz3XslA+TXxKJek
 tT/raLQZDeoVGs7Lv4nzIH+eESD1gP7B6DLFEOXs6UZu0VW9gZN6DAApP2jnB63Xi8HZ
 B4fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj6N1xHljk4v+QLe9F8gIl4gZf+Ua+KeyY6T0ioZlsx1FID953fTcnB9VWx4hYMLowwoJzah1EYwN6CnzkRvegmssPQA==
X-Gm-Message-State: AOJu0Yzr1mE4oEiek9E3Lrh1sCN2R53xsGVA6zeVckQGQHLWavisWvZ9
 I8EMl7lMD2EdvqYsdzIHMMIST5SDX4FBoxwvWNaaw8FwuMv3Bgz/S+Ap19/L59Q=
X-Google-Smtp-Source: AGHT+IGen71y+r6CZ7Kp5tg0rNSUnrSvMYhvqJkf+OhCkUlGzu2qNS7ewlxSTirqb89gBUvxRXelwg==
X-Received: by 2002:a05:6000:e12:b0:346:a6ae:7a07 with SMTP id
 dx18-20020a0560000e1200b00346a6ae7a07mr1127974wrb.9.1712819256279; 
 Thu, 11 Apr 2024 00:07:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:9b22:a845:661:e15f?
 ([2a01:e0a:982:cbb0:9b22:a845:661:e15f])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a5d680d000000b003433bf6651dsm1048841wru.75.2024.04.11.00.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:07:35 -0700 (PDT)
Message-ID: <2f0adc2e-86d2-4e6e-be47-51eef9563f35@linaro.org>
Date: Thu, 11 Apr 2024 09:07:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/4] qcom: pinctrl drivers for qcm2290/sm6115/sm8250
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
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
In-Reply-To: <20240410-b4-qcom-rbx-soc-v2-0-5120a9c7f6ce@linaro.org>
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

On 10/04/2024 19:52, Caleb Connolly wrote:
> Introduce pinctrl drivers for three new SoCs and enable them.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes in v2:
> - Fix a few formatting issues
> - Link to v1: https://lore.kernel.org/r/20240408-b4-qcom-rbx-soc-v1-0-900db37b8bdf@linaro.org
> 
> ---
> Caleb Connolly (4):
>        pinctrl: qcom: add qcm2290 pinctrl driver
>        pinctrl: qcom: add sm6115 pinctrl driver
>        pinctrl: qcom: add sm8250 pinctrl driver
>        qcom_defconfig: enable pinctrl for new qcm2290/sm6115/sm8250
> 
>   configs/qcom_defconfig                 |   3 +
>   drivers/pinctrl/qcom/Kconfig           |  21 ++++
>   drivers/pinctrl/qcom/Makefile          |   3 +
>   drivers/pinctrl/qcom/pinctrl-qcm2290.c |  70 ++++++++++++
>   drivers/pinctrl/qcom/pinctrl-sm6115.c  | 200 +++++++++++++++++++++++++++++++++
>   drivers/pinctrl/qcom/pinctrl-sm8250.c  |  99 ++++++++++++++++
>   6 files changed, 396 insertions(+)
> ---
> change-id: 20240408-b4-qcom-rbx-soc-44ee99c8b799
> base-commit: 4ba549b0a4e67c563785ab144edf47e108b34822
> 
> // Caleb (they/them)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
