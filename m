Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2572BC48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 09:55:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCF8874B1;
	Mon, 12 Feb 2024 10:55:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZzSP1Yej";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D87E879DF; Mon, 12 Feb 2024 10:55:34 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E5E68723E
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 10:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4109f9afc1bso14424555e9.0
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 01:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707731732; x=1708336532; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=a1KjEFoJ8MzvohwDz5zGvXu10jQQ+nt1jM1qVTlru8E=;
 b=ZzSP1Yejl8Zw/bV25oQ2BUxXnk1tTZb8xRgklW489BtyiIx3huzTy6VbhndmE9nGo2
 4wWpe2cWrENiwWM6GpryZ9R+6/DTa6KraVE24y5i0av2eagZszPJDoFvpYy6Hi0X8yG1
 0OUnP8GG5H+oFnq1/UjkS/gPQy0ta3kRj7IhQOoO8CyF5YHGlERt3DSxU3C8mN0FkcoN
 KFSp4EOGgHFXpkJLCWCHR2w73El5j2Z5/DED4scYgbWaQntMnKu50ohiGOjzr9AAlUsK
 3/n5ACtFXKXD/m3SbS5eVMS+r5wlQ71CnPE+Dp/1+zZz93x0b9YAxc7cxKPeAYuHZ84O
 1iYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707731732; x=1708336532;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=a1KjEFoJ8MzvohwDz5zGvXu10jQQ+nt1jM1qVTlru8E=;
 b=TkUahpGY3cTewX5jWeoNiB5o5HXX5jYx0x2kMssaTnAN4tbp3GqBg5CVvqyrfKIeaa
 cI+Vte+s99Jt2t6Uwu1HBqzVY/YEuEPH4AMQKVIkvRdSgJ8OhBvcQHhVeff0KdjfGZsH
 SxkwJYib+bz9ZBJlY3K/qRi1v6W08rAAfEuKNufEoxsMKGb2w01Jry1vVkb5IruWsVSm
 o0XZHGGjuBo3WTLxVzH+NfoJtwC62jpyYQbrVuC/YGL85IyKZxfkRbbRckoXp5o8CRGS
 XgTzFSeg1jmvRkcma6qpo6CrJL5aB51UMipRq1KF2uGrOuJpTUoqmnHfjap19X1NLsLd
 aRdA==
X-Gm-Message-State: AOJu0YwVodemoMg9QhQ8oQaejViCSV/HVhr0Ip/t69r3O0ROgOoQolhJ
 AG9eKlHVbOmcaJb3leU6TodMH8U0TB6kiVHrTJSwFAouyEcOemD4QBtvL5g3X6A=
X-Google-Smtp-Source: AGHT+IGoHMc29DAiCxLVj3iTqii0Xl+HeALNJt1Rm8M6GawBXl/oiuF6XAVWWSqg8BX9W0aRP38Ckg==
X-Received: by 2002:a05:600c:5126:b0:40e:ac8f:e6c with SMTP id
 o38-20020a05600c512600b0040eac8f0e6cmr5136939wms.30.1707731731928; 
 Mon, 12 Feb 2024 01:55:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVHDi1f7oUQ1jLkTu8OhinX7fXNBkhLfopmq+C0hR/Z8L5a7n0Rn5MHB1yf5ubLTwJcMkzp7y5cMcYzl/IK0U2pKdqmHWmG+49hpvvEQysaelA823M1HrNh
Received: from [192.168.7.190] (212-114-21-58.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adffc0d000000b0033b63a0bd0dsm6307341wrr.109.2024.02.12.01.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 01:55:31 -0800 (PST)
Message-ID: <bc51e1eb-705e-4cd2-afa3-c09ee2e61935@linaro.org>
Date: Mon, 12 Feb 2024 10:55:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] button: qcom-pmic: demote "unknown button" message to
 debug
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
References: <20240209151221.3967655-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20240209151221.3967655-1-caleb.connolly@linaro.org>
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

On 09/02/2024 16:11, Caleb Connolly wrote:
> This message isn't an error (there can be a watchdog subnode for example)
> but it shouldn't be printed unless this driver is being debugged. Demote
> it to a debug print.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/button/button-qcom-pmic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index 34a976d1e6c6..e6702139ca2d 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -133,7 +133,7 @@ static int button_qcom_pmic_bind(struct udevice *parent)
>   		} else if (NODE_IS_RESIN(node)) {
>   			uc_plat->label = "vol_down";
>   		} else {
> -			printf("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
> +			debug("Unknown button node '%s' should be 'pwrkey' or 'resin'\n",
>   			       ofnode_get_name(node));
>   			device_unbind(dev);
>   		}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
