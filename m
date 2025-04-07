Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81863C3601A
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:01:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B5F282D25;
	Mon,  7 Apr 2025 11:01:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r++ECsRP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7035482D2A; Mon,  7 Apr 2025 11:01:50 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7480D82CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso26168085e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744016508; x=1744621308; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=SadQZegIIE9R817fglqtDNx6cCzmLkxY5Pg2MxyzHgQ=;
 b=r++ECsRPfPElIYr1onThRrNeNpiuM4+eFJY+TvC4kMKIJiHScwYfmBs21Kw7zKArcQ
 alR/xik1r6tcxedWyPtvLkEWR0GOptHTiXy9DTSeK2k9l0+o8ROeExdgp6ZVKwmvfVJU
 4X5KDkhmMhAfEYKmLxG45v2DrTFZ9VPRF0adNMl2x7I9P2gzL3IO98gm5KX2sgsVQ5E3
 XO/0GHYwLkLwFmEoYkg6r7Cx3GU52DLZ6ZgnjNhqwcGExGR4zrUYC4vPsUaCGd7FW6Qd
 zwWNLlGkCGOXxZrmH7GNv8VhFtxboigfg85n/0vQhpGpJ94fCF5X61JXvtdxFCKhYtIJ
 Be3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016508; x=1744621308;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SadQZegIIE9R817fglqtDNx6cCzmLkxY5Pg2MxyzHgQ=;
 b=Yq+ZGVc7JVVv2rE16PqkT5hq1PW0XzCzROs+L++7wwbwxonvwAf5noQG5dkx1IqZE5
 rdTByLyf3isgzN8/5xEFgROwRRUUr1Nwp/jmgo7XUPxrBcvziZlFnwpy/GalKkwIXdNu
 hWLDlNZTEFGqHp9HJlGsiU7mFIIrLIE21a43MiYTTKTd2897KMtC07D/LOmV3J+q6SQk
 cfhJ5fHc+udxXV+F2MzdhvBor/qI0Cm9cgS956chlzLbV3EP3cUH5LPd1xuiQqlxDP/9
 LDpoaCjtqJDirhf5KcfQerLD9sNvmzHNr73F5NSQhzlqI+3hXOfYQgFeQR3GNcLWt1Mk
 5Uxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4fjWtUuwZGzeEA1zqCUBCDskFMcpnSBor9aPpv4TLjgLiiKe+zVJMH1iFSgUjwtBH/9n0b3M=@lists.denx.de
X-Gm-Message-State: AOJu0YwBz8TmL9JQgu+6XsGpS4hzugh4FevArkcuqjiRoV972g2XmsG6
 hIZ+4JRyBtuvNFk8oif9G8Jt6JBGAI2uj0iqS/YeZJnUTa8PzdZ6LsMtEq84Wkc=
X-Gm-Gg: ASbGnctzTxNzfQshCUMqBgtfFh2aK6K8BVpRN/fyQwV87lc9pQ6WesYxMjee+cNz6Qg
 4l/xPaIZwVvASe1189T6iInWy4FytZI+oYaq2e7ydL9gv1mvCCbi9Oacvo4M3zDvy/KuRjRWr6H
 ICalY4gEp0qwZNW1Ubymi11PjHTvmMKjN7ecnTfqU6xP+rH3ZZ6LuPSIzfaonMYnQtVac33tc08
 fYi1XvSFqE+3QwakQI4eTT5WXN0mdliRCdCygD9Wd2mvOSkoG5fK+pofJf6BDRdETCUQePzLKY6
 7lUafNgoVpJFR7ICmjrOjEuDT69Q/yzoLMYS37m8U10HxyVOKm5z2EOdJ4z7fBwbic88VG82IBv
 Z/5052TqAEwsOhkGxAvFOCw==
X-Google-Smtp-Source: AGHT+IG0A8wd6gsCdC64IDn9v3dae46byyuzWZoOPF6VbtoLpAFuMW+MeVG9EpTiYg8ABfroxS1PgA==
X-Received: by 2002:a05:600c:1d16:b0:43d:fa58:8377 with SMTP id
 5b1f17b1804b1-43ecfa418a0mr92201315e9.32.1744016507973; 
 Mon, 07 Apr 2025 02:01:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366b571sm124480595e9.40.2025.04.07.02.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:01:47 -0700 (PDT)
Message-ID: <ce8d4293-8ef4-4f59-9400-29e496027835@linaro.org>
Date: Mon, 7 Apr 2025 11:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/7] clk/qcom: apq8096: fix set rate for the uart clock
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-3-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407081927.138915-3-jorge.ramirez@oss.qualcomm.com>
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

On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> The function should return a valid rate.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/clock-apq8096.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index c77d69128b0..bc00826a5e8 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -87,7 +87,8 @@ static ulong apq8096_clk_set_rate(struct clk *clk, ulong rate)
>   		return clk_init_sdc(priv, rate);
>   		break;
>   	case GCC_BLSP2_UART2_APPS_CLK: /*UART2*/
> -		return clk_init_uart(priv);
> +		clk_init_uart(priv);
> +		return 7372800;
>   	default:
>   		return 0;
>   	}

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
