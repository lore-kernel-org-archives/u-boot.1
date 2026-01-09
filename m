Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08403D232EB
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 08:06:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46BDC84121;
	Fri,  9 Jan 2026 09:06:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VhSjagQj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F367984158; Fri,  9 Jan 2026 09:06:35 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC0084113
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 09:06:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so2923500f8f.1
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 00:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767945993; x=1768550793; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iZG04fU9A7l3TEffS4WplzZRWWYJxa+xnP32KxuPRZs=;
 b=VhSjagQjmuCHtXig0NTXcJdJqG26WewBDUP/DcJLEbphT4QPKTk09hyCzjdkV6LRnG
 09s/9neSSlAOIP6iohXG5TYV7xSFap7CkSplxgrJhgkneUcZAaA5w+WB1q/ScEMk6uGq
 mrlLGzHBn3E6W1ZhRsFYH7xHtVV3OV2FPMKaBCDCx0lmfqQUhUrg9ZcxI7bvEh4H34Qd
 ExR11d/mY7NslnxEa7hYMBP/pWRnlLHAehUJiEDLisOms/PDpFOSGuwru+pxLC3V9DKL
 ynAX46GWRsB62ffk+vHIaM3UfbPXFfomldabh0t+OF+Gsuo/vUn14X8Dw9mJ8x8DwMC3
 pA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767945993; x=1768550793;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iZG04fU9A7l3TEffS4WplzZRWWYJxa+xnP32KxuPRZs=;
 b=AQ+YXw5B8Gt0LH4GFgp1gVt5NcwVp/kEsnxOoW2cR8r1zWeVl4yGAzoWPkBnD9urWk
 h0IOWlcQS9HxeWGMwtxS31P9mSVnZQMuzigqHce1C4Uen+trt16uPUdFuum4zCU/TSlR
 d+MohOK9YIjCcKgzcxQl2qHyUbXK4bLymOaxVPn0GIOO+xit/fI3exgjIDvB1+NT3O0r
 ifFWq7l2zsCJXIrXVdV5moFqFWrc1xdi0D4zVknjA0hb1SESvcmZUEbs+47ty0qoWRqM
 9Vy9/PanS3oeTPI3wnfbTFCpYuTI3vpvP/Wp+EGVohV+SVu6w+Z6C0xzmYqwhIsSakud
 0yVg==
X-Gm-Message-State: AOJu0YxSrp/aoy6wcV3JDLUaO7jtFTBRPk6d/b+vRVcpXW+syWY4LNqc
 ihyKuDPR9HUa4xbu7N/1nvLvjf6BVpumj8gP8q6WyYo6fOXIAORKzqgBl9yo8D7HDEndPYc3BYR
 ozP/6
X-Gm-Gg: AY/fxX7EKIo7Q2HFDYXJjhSbvlsijGFMkOMSD/bzQcaU+52cvtES+Ke8rvecDTbO+C/
 jhgapwB0BAXIEvuW1TeD2Sx+gmvSltyG+gWvHe0hm5/RISEjQtr8Pykef8OTOWtIEvj/EIx4yXm
 7rJptT5zYo3fSqz+9NbtEomiVf3oO+Ph+9UgUt7oXoxT/xjs2sHoUjjoUZzTapXtE49RBqLQKNr
 2B6MeVrp+unRBq90znsBU9GSrv35G5ktTZXwrudfua0XpLoyxQEOI8zy062Dq4GXTi70ZES4sn/
 AMCkhgQxQosX5ci7lt3VCYUb1fRKIwkVrd8Bv+TUUwrF5Mv324+kB9eekFr3lnlrTlLBopc0wfd
 6nW3dBnNQ1ZkZnQz/iPBokWHhCY199TXifBnRtrKfFnOFYhAyAcFgT2ITlZn5NShY8zROHICm3Q
 PqZIyc7XQXkkRIEOssal319ol9WYpO0xT5wcZwKJ7UTEJllzC4CNHxVlkYJTfTPFvKrzqMmqB/u
 A==
X-Google-Smtp-Source: AGHT+IEyekN6TRz/BC8W4YcxZI5RFmB8JbAKfuRR4CH6tKXv/fwqCC2vcW5N12D1ND4HKb9Y1ifB+Q==
X-Received: by 2002:a05:6000:25c6:b0:42b:4267:83e3 with SMTP id
 ffacd0b85a97d-432c374f5femr11392779f8f.5.1767945993093; 
 Fri, 09 Jan 2026 00:06:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e6784sm21023450f8f.19.2026.01.09.00.06.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:06:32 -0800 (PST)
Message-ID: <ee1128f4-ab9b-44f9-a1c6-a607e45364d4@linaro.org>
Date: Fri, 9 Jan 2026 09:06:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] i2c: geni: bail when clocks can't be enabled
To: u-boot-qcom@groups.io, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260108195301.3159260-1-casey.connolly@linaro.org>
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
In-Reply-To: <20260108195301.3159260-1-casey.connolly@linaro.org>
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

On 1/8/26 20:52, Casey Connolly via groups.io wrote:
> Failing to enable clocks will lead to bus hangs and the board crashing
> in some cases, let's actually deal with this error and fail probe rather than hoping the clocks are already enabled.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/i2c/geni_i2c.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index d29e00fdf41d..fbe5ab0ad0c6 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -493,9 +493,11 @@ static int geni_i2c_probe(struct udevice *dev)
>   		dev_err(dev, "clk_get_by_name(se) failed: %d\n", ret);
>   		return ret;
>   	}
>   
> -	geni_i2c_enable_clocks(dev, geni);
> +	ret = geni_i2c_enable_clocks(dev, geni);
> +	if (ret)
> +		return ret;
>   
>   	proto = readl(geni->base + GENI_FW_REVISION_RO);
>   	proto &= FW_REV_PROTOCOL_MSK;
>   	proto >>= FW_REV_PROTOCOL_SHFT;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
