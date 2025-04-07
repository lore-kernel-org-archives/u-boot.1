Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39439C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCDC182F65;
	Mon,  7 Apr 2025 20:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="g9la/shz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5F0282F85; Mon,  7 Apr 2025 20:07:45 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5D2F82F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so45102235e9.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049263; x=1744654063; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=NSs655TZtgDba89Fc3lH/CqurTPcZgwNyWBUDljTuL0=;
 b=g9la/shz4LLrbIU6y2rrpbfgaVxNoNfqJjZf1pW8dFYagBVJ7jzTfM2Q/4wmDr6++V
 pBYR0FKbnIrfIZCB4A0/jEk1/LxbEG+Ti0C8p90cgUY/5zn57TNR/ivoCngxt1P14L/E
 JTO2ar/lke5eX52L91t08gEnU6SbXoGr9EkO1w7x0w8RaNQh9JaEJeORI1zeSCuF3XbU
 3CfGa90qDBfBzsQWwiiwCr+X/ZZJPn9EsIgiXGyHAosplUMscIiofrCbk6rLPZEmD6iQ
 qy9gLUqmcpfwmkztITblC6RQ2873l6nm2rCqyS7T5KygVJHxaqG3tUAjwVtxYg/7Unnt
 QxrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049263; x=1744654063;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NSs655TZtgDba89Fc3lH/CqurTPcZgwNyWBUDljTuL0=;
 b=RFy9dNYWJs96ajiAk7ULT6mxme68ilEN6Zk+/oCZG8xEGzZSvmtHUH4US+ljixo0Ih
 qDyGgSHfTPbSlP2BmRQkuMsrELz/9Lhz2qEZsl1nooY1fObmUXS5zDxaPueoGmvC2dKH
 08sn0lBdd53Fb6hMXzfgLevSl2WmLLcVvZk79Ix1+ELSduAUYhP7lU6S3CykNMDlVShU
 22/Qphtc1tAk4D14NQnAfCd0RMR2/1g/0RqINC34YYfD7JVFWxNLyyNCrquX7dlI3rmQ
 ervr9K+JfA8llLPvt6HuUXtQXpzl/8pUB0zkdSjYEU/1EhxCd7RdvpMcG0aW1SbrMnvR
 w4Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvdge20W605rNj0w13lSpdd3qbD2v2D8IXnUZ4FLqw5E9mCw2iaxUp8pzbmsB0/y2zFfIploM=@lists.denx.de
X-Gm-Message-State: AOJu0YxmsiBWbAV0DgrRRJa5vj+PVgnB4OqytrAQ340y4vflAVmvokcQ
 0hPQGLXoD+ZS0toGoEeizPNLVU9QakeKgobs8tBo7l2zQJSmEHUWKO8VFGkNtjM=
X-Gm-Gg: ASbGncuIUWCrIqEPdkR3EJn7kiDUkm0UY6EAHKQfDOs22nUrykdE/VCHaUjGRSYXmHS
 NUWOXALok/lAermgFg02H6KVEds5k3gP60zG53PT1OzkNGEvoJeLzQBZt94u0W/b2zwfcirbh3x
 asoxHnpsgbtSzJDM4kNyzrTWaMYkCkz8pMBZRnGuJb83aoiHkSmOBHzWOJk1Oawgui18hF/KXUk
 O08s2mF8t1jxxRLpziXMqbibfiuVNO71nuekN3kZVWlpl8rOZtRQ5XdLBRIxU0NS9daJX4yvHAD
 DWD56IaX/qa9mn2XVT8B2ZxqfVwGvCcNJIVNlAunZ0HFD3sW+pkENg8eKOoIqQt4r44C8aqI2kz
 /KTeqSmt5fnQyx7h0pIpIog==
X-Google-Smtp-Source: AGHT+IFirhqdoblN7UsQVAeIs9NnuD9dofvy7tmZT3boR4yGxgyj0WUscv5dZOBzXVtaD9z4sl1Zvg==
X-Received: by 2002:a5d:6d83:0:b0:391:4889:5045 with SMTP id
 ffacd0b85a97d-39d0de6797emr11643749f8f.36.1744049263134; 
 Mon, 07 Apr 2025 11:07:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795205sm141763485e9.30.2025.04.07.11.07.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:07:42 -0700 (PDT)
Message-ID: <d54331c8-3da3-40b5-b984-d07156c39f34@linaro.org>
Date: Mon, 7 Apr 2025 20:07:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/13] board: dragonboard410c: Drop UNSTUFF_BITS() macro
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-4-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-4-524aefbc8bb4@linaro.org>
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> This was originally taken from Linux, but at this point it's an inline
> function upstream and no longer a macro. Given that we just want to extract
> the serial number from the MMC CID, let's just inline that specifically.
> This is also the style used in the MMC core code within U-Boot.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
> index c33529d31869b17c7a30ec83af1199d01db472f5..61d68e7f0c6bed16861e6ceaefd2c7dc94807d65 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.c
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
> @@ -22,21 +22,6 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
> -#define UNSTUFF_BITS(resp, start, size) \
> -	({ \
> -		const int __size = size; \
> -		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
> -		const int __off = 3 - ((start) / 32); \
> -		const int __shft = (start) & 31; \
> -		u32 __res; \
> -					\
> -		__res = resp[__off] >> __shft; \
> -		if (__size + __shft > 32) \
> -			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
> -		__res & __mask;	\
> -	})
> -
>   static u32 msm_board_serial(void)
>   {
>   	struct mmc *mmc_dev;
> @@ -48,7 +33,8 @@ static u32 msm_board_serial(void)
>   	if (mmc_init(mmc_dev))
>   		return 0;
>   
> -	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
> +	/* MMC serial number */
> +	return mmc_dev->cid[2] << 16 | mmc_dev->cid[3] >> 16;
>   }
>   
>   static void msm_generate_mac_addr(u8 *mac)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
