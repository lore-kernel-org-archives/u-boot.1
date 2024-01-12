Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E42C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 08:56:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16998792D;
	Fri, 12 Jan 2024 09:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YeTFqBza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AB398792D; Fri, 12 Jan 2024 09:56:11 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53CAC879CB
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 09:56:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e5f746ac4so18537585e9.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705049769; x=1705654569; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1CfNwzikwHdlXB6AsG7zIlf0cCL6lbFjUJwzhlGd4zE=;
 b=YeTFqBza0rzxd0wsQ+yGkY0AJYQbfwhS17bA9CI5o7VVDOq/v9TAYcYK2mOGY1tTHl
 aDMpF0Qfo4/PjpbycymQN5OehPV/kEo2h2i1ZITF0MoHJR6H7qIWgokVtBzF80ayRpoB
 7KXM6FTp5Jnnp2YF8nPlQzu8iQoKc5Zc8glcOfi3alHX8YCANOOKXs20/jacg+9D6RLv
 exCJafRRI4j4ze27JeevUldeaVimGEWWn+O+7EAdDJMqgovBLQ6jBdztROpoateXIV/g
 taxqit1FBStoTeyRRKl/ITAfJcMTNokVHkbpG49uVlzZud/fNaJ3JvxeLVtIR47D3Dq+
 wTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705049769; x=1705654569;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1CfNwzikwHdlXB6AsG7zIlf0cCL6lbFjUJwzhlGd4zE=;
 b=ud8oyOzuZ6VSWSAPPh6JEb3SeYYf0lHmVloFP0646tQElHOdLZH/xsDGO5L9G5BTjE
 F2k3W7qAh6cVw2C2OgCSpBBESEosHUfScEO/Rz1i890DtzhXOC+Fcbdc19mmSwoyJ/aF
 KS0V7k3gzaraN+Db9DEGpHgC9AvmOLZll7JH8Y3Qt023jlv6cmRsUNZQ24/zCWmFs38b
 kTbt6v+GmDIOjYKzov7J70dgXVkCLyFH6maorX3iiKP9ym5ixLFb0sj5wYLfA6a1O+nn
 34R+GHAbl4eqmCKhvQh7c0UkJ12mHNsL1sdnRMpghBAnE46TbNTyNs1013jJfUPkTYbx
 eTyg==
X-Gm-Message-State: AOJu0YzeSE+cGyJR3LdU3gsg9YiwBkmSkx2BZJApt184xGK1iAYLeAz1
 9tPFgOmsrN9jFdZpNlnXF9hIeh2a0cEdLQ==
X-Google-Smtp-Source: AGHT+IFBCLK+bl2rZrsF4WxJ/BAKEhv46KRCtfmbyOUanRUU0bfx/XShZ//pgQ8jE+vsZK+rVFudWQ==
X-Received: by 2002:a05:600c:3549:b0:40e:42b5:a19b with SMTP id
 i9-20020a05600c354900b0040e42b5a19bmr614047wmq.154.1705049768769; 
 Fri, 12 Jan 2024 00:56:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:59d5:231:f1ee:77f?
 ([2a01:e0a:982:cbb0:59d5:231:f1ee:77f])
 by smtp.gmail.com with ESMTPSA id
 g1-20020adfa581000000b0033680f7be5fsm3278900wrc.87.2024.01.12.00.56.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jan 2024 00:56:08 -0800 (PST)
Message-ID: <3ff5d6ab-bdeb-472a-b156-70bf866293aa@linaro.org>
Date: Fri, 12 Jan 2024 09:56:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add Mattijs for Android AVB
Content-Language: en-US, fr
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240112-maintainers-ab-v1-0-f2a538eab18a@baylibre.com>
 <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
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
In-Reply-To: <20240112-maintainers-ab-v1-2-f2a538eab18a@baylibre.com>
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

On 12/01/2024 09:40, Mattijs Korpershoek wrote:
> Igor has not been active for quite some time on lore:
> https://lore.kernel.org/all/?q=igor.opaniuk@gmail.com
> 
> I'm interested in helping with maintaining the android_avb
> command. I'm a long time android/aosp developer and my daily job is
> still doing android work.
> 
> Add myself as maintainer for Android AVB.
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c73d8c35c4a..4978470c1664 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -70,6 +70,7 @@ F:	test/py/tests/test_android/test_ab.py
>   
>   ANDROID AVB
>   M:	Igor Opaniuk <igor.opaniuk@gmail.com>
> +M:	Mattijs Korpershoek <mkorpershoek@baylibre.com>
>   S:	Maintained
>   F:	cmd/avb.c
>   F:	common/avb_verify.c
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
