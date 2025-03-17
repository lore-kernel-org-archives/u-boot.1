Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B484CC282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FDCA810F5;
	Mon, 17 Mar 2025 15:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="c/5gttgb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4D0A81101; Mon, 17 Mar 2025 15:04:09 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA7A280107
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso16236045e9.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742220247; x=1742825047; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=REiMitY3EYATKPRZfjdCBApToG8YD5AzOcu2SeDUo3Q=;
 b=c/5gttgbNaVoDsMvVJ/VgocLcra5Q7CTmR248lN3lqlgxC25wmn5VjUPRySBaX1vG4
 TCNvfJ3r5qrgZ4Kt6S/Xg+BLN0fu71Ywot+ftIuiod6kUSXfHXlK28ENBqDy98hYfxQa
 Hn1slAj1UYawGc5zvUYFz8TY/0MWjJAfeZ8EHSmEuqLt5ipEeo3GRNCZr1Z+U7bmdgvP
 9gRYxz1T94FySjnwU9JHagwlj6DnLL356rNup9HwvtYY3fC/JrqUexlrPREKV578a+Z/
 knUtHTqhn/BRr8tVCwWxTfczCBTCmKgU9iEl4wr+3Tz4Wzg/Hvo2s+XplVzLF1M1y6gp
 8paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220247; x=1742825047;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=REiMitY3EYATKPRZfjdCBApToG8YD5AzOcu2SeDUo3Q=;
 b=HTWrAZ1gs1cDsy3TejuGTB8wjk4Rmngo6xzc98jBjgQi/GoRN08CKssG32n0ygULZt
 zycOBSI8MFGgUjX+zO0g6lXR0eX+RUx7YK0ah7XyFH37PAMjKhkswuq5/xULV5730JBz
 at1U37/ngdBsxQA1OizjASB41/hKccziK77/HnnkuUxUSfQ/+EYl024u8Z6QxCHnTS2i
 zphxaKa0Pa11bEVqtK9/0ZxdcTOrumUq9vCXmjI+Va/gF57XRmfHS0ZlvHYkp6SQrxun
 EIUJU3DKQgSQE9ialR6UerqVLnXYjKi5wtQnQx1E2Vo2r6p4SYb4noBfA+DNZkjcBsLU
 SG+Q==
X-Gm-Message-State: AOJu0YylIxcnaBIohzeMVV0FB8bqMPKZhzr1W6SNPKGt+x8UO7Q8mXTi
 z5MXFjEtkdADgbcwQtEi2NsO+tAZa2y4gad3JNWX1trwY9dlT05l9DL2zZZkp48=
X-Gm-Gg: ASbGncs4wVvi55tui5pOA3jKzYvcDIfTgPaFhC/28Br8QpoAXZ+bLoOAaX8NfbhLNZZ
 AXN4gMub/f9H4/Pn5WEIq7QCICaQBIeTBXtk9MUChaL4xC3sZHaMUXdsZkg9h0VcUnLyFHIqYoe
 1F+UIM08R+0l0ixST+651B5SPGM67ZHoyytboXDbq/ptQxEDtJKFLoJfp0AwHDn3PjCUvEiXSlB
 4ua3lV1C12+Gq7wSKnsXvTnfbWSxUiMe9WnmCEYA29Yh2N++SZ6X2GqBqDPZ3cESy8ELWBvbn6u
 HC5nYGuSzIJIVaIjo5sCPTUVrURh+09r0r0VX7tAkX6SoW/GiM7IAlfFUABIBPcv/KjLplulTji
 mFj0uxl91RYxrHH3bc2hCQEN/ZVjFkkQs
X-Google-Smtp-Source: AGHT+IHAhTXrwd2xNXZVztoaEM/95bS5rvg4MySi28GfiiCa2jGOP0gmTTDyVXns4TOnP8GF/5W/yQ==
X-Received: by 2002:a05:600c:4eca:b0:43d:bb9:ad00 with SMTP id
 5b1f17b1804b1-43d1ecc7d78mr138247915e9.15.1742220246745; 
 Mon, 17 Mar 2025 07:04:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d2010e0bfsm104742405e9.36.2025.03.17.07.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 07:04:06 -0700 (PDT)
Message-ID: <161b113e-4cd2-4870-9a87-30a64b1385a9@linaro.org>
Date: Mon, 17 Mar 2025 15:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/3] i2c: geni: fix error message wording in clk_disable
To: Caleb Connolly <caleb.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
 <20250314-geni-load-fw-v1-1-587f25f2812f@linaro.org>
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
In-Reply-To: <20250314-geni-load-fw-v1-1-587f25f2812f@linaro.org>
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

On 14/03/2025 17:09, Caleb Connolly wrote:
> Correct the error messages so they accurately describe that we failed to
> disable the clocks, not to enable them.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/i2c/geni_i2c.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index eabf5c76c21c2bc12c80dbb9fb498a0080928248..4eb41ba852f7790ca646c8ba38f29fdb727fa804 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -330,17 +330,15 @@ static int geni_i2c_disable_clocks(struct udevice *dev, struct geni_i2c_priv *ge
>   
>   	if (geni->is_master_hub) {
>   		ret = clk_disable(&geni->core);
>   		if (ret) {
> -			dev_err(dev, "clk_enable core failed %d\n", ret);
> -			return ret;
> +			dev_err(dev, "clk_disable core failed %d\n", ret);
>   		}
>   	}
>   
>   	ret = clk_disable(&geni->se);
>   	if (ret) {
> -		dev_err(dev, "clk_enable se failed %d\n", ret);
> -		return ret;
> +		dev_err(dev, "clk_disable se failed %d\n", ret);
>   	}
>   
>   	return 0;
>   }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
