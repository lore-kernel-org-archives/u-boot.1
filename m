Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691E0CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 08:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1929880DD;
	Tue,  2 Apr 2024 10:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fhh1ytRU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C671288076; Tue,  2 Apr 2024 10:32:33 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FFE880E5
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 10:32:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4161bd0a4ecso1880265e9.1
 for <u-boot@lists.denx.de>; Tue, 02 Apr 2024 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712046750; x=1712651550; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=os+PEmtXmoBZe558Fyn8SqCTeeClEIncj5tFJ4TZ+LI=;
 b=Fhh1ytRUV5SvVySBzsisBXGHP4sqEAghGEUrouibfcdKHV625yXgGXynQxBHQ5j2vc
 N+z9n3X4bByaBzezvWTA4RIy0B5hQrsr/ck60oE6tqV5hms6DkvJ57Q7z9xtLx/6LXYN
 fEpVkND51JOnwpMkWpGfpb3AKGPuiOgOmMWKU8LCnsLvxJ8FxYvN7fBY0S3GJlZeeoti
 e6wxSMNxJSXLAQoUjeHypOkM7V9Rkp02qNfZiVn/FEdxc+6nRw3kvrSkGMlzgDJBKQQu
 Jt2BXvk9SsIHOc40pD9WXdcfZOAkp2/NfxGdQKdAFQ6MbevpQbZV+mU4pkOWxVAHnNjl
 txPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712046750; x=1712651550;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=os+PEmtXmoBZe558Fyn8SqCTeeClEIncj5tFJ4TZ+LI=;
 b=SoIEhvvPvXUcEwv0SCxDh6pn9ynsf/XXVQxZOi36Q6xxXrDXgz+KKOJtifLZjP502s
 4vF7/We/Ha+hkZLRLHMcJ4qmxEdTKTcfFNC2v16rvCs7HYUUPq8qV+PIhPkrMtbB8tCo
 q3MgAhcQ98VL2CHmN8cDCbN15OmzmeFDNwFrzWCHMUknk3HxGHvkXQ6VWpItjW32cnHV
 UsQaQTLh29SS/Isjy30OdNDb67LVSEhqWn63qh9JR9EmkoA5h/lCUOi5EwSRMKN13ttL
 F3L+417YeWtQh3H9ENcUj8UeIyIft0nJUfRZtJtvgePJQJ4T9Wy1YmxqDF4+5MMELx54
 b+BQ==
X-Gm-Message-State: AOJu0Yzs8Rul9QuIff0igub0QYi3b/0+Niyx7dnAh/zq4FUz54lcrgVl
 k6BiCsoVKchlM3j01eeNfGCBR+zic4G1GzNibuaJt6YzXVqABHWK8VzFmiuLxJM=
X-Google-Smtp-Source: AGHT+IHTfOEE45BIKh2LYE9U8HAmPep6iOVMpSwVpwsg9cTfjSUZXTRE6rTngAO39o9CxD+QvnP7jQ==
X-Received: by 2002:a05:600c:927:b0:414:669b:aa9 with SMTP id
 m39-20020a05600c092700b00414669b0aa9mr7527289wmp.28.1712046749711; 
 Tue, 02 Apr 2024 01:32:29 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c139600b00414906f1ea1sm17048893wmf.17.2024.04.02.01.32.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 01:32:29 -0700 (PDT)
Message-ID: <e6dc1214-f006-4394-b6fa-022254b06634@linaro.org>
Date: Tue, 2 Apr 2024 10:32:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v5 12/16] mach-snapdragon: call regulators_enable_boot_on()
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-12-4e98228b3d03@linaro.org>
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
In-Reply-To: <20240328-b4-qcom-livetree-v5-12-4e98228b3d03@linaro.org>
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

On 28/03/2024 18:59, Caleb Connolly wrote:
> Make sure we power on any boot-on or always-on regulators. These are
> used for peripherals like USB on some platforms.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 65e4c61e866a..3d5994c87886 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -15,8 +15,9 @@
>   #include <dm/device.h>
>   #include <dm/pinctrl.h>
>   #include <dm/uclass-internal.h>
>   #include <dm/read.h>
> +#include <power/regulator.h>
>   #include <env.h>
>   #include <init.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/bug.h>
> @@ -160,8 +161,9 @@ void __weak qcom_board_init(void)
>   }
>   
>   int board_init(void)
>   {
> +	regulators_enable_boot_on(false);
>   	show_psci_version();
>   	qcom_of_fixup_nodes();
>   	qcom_board_init();
>   	return 0;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
