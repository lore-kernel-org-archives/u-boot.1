Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAD9C35FF3
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C2908192A;
	Mon, 17 Mar 2025 17:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dXF1Tm9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B40080F4C; Mon, 17 Mar 2025 17:16:34 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22398811DF
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 17:16:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so4591083f8f.2
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 09:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742228191; x=1742832991; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=J5K8IIS+XUSKaNMc4KLwGzGQwE1QsDJ1FGfRkjF3aQg=;
 b=dXF1Tm9le9OfRplSL4MA8TFzkNvh+82mQHA7NRdTahcEKjtW9wn/IlVPm51hEAJeHG
 9vqPpUPEtFWZiHxRKeqdYy6aeN0qWPiTUME4OD+9YI/kuLXc8zvr/tib1yKQDSt9KlVd
 /3ZuGU6yo28I0gE7LQrVPR4s9y/XtmuLambxTRkf28/fTpNJMTH4SjbHfZFen5is7JNj
 Ryvzg1l9V16XWI1OSiQ/fuklwzRW3F3wQhtb1cOqMdfIBYEhiCUFp/wz7OL6BYmWNrAL
 mfHolZFNSmU9JJub5VETAj8HwUACcAibLO6uK1tCR7HV1pEgRcoNepT2+HRix+SBwCYS
 FlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228191; x=1742832991;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=J5K8IIS+XUSKaNMc4KLwGzGQwE1QsDJ1FGfRkjF3aQg=;
 b=KV6dUZXRnZMBwEKLgb6VM5nGhMZsUkyIaPm5PSWEpFGeX4ZkiWf0JSl1XOGGCezd2j
 GuAA6iLssvpFVAUpLDR+WaNOzRucxqCkYTg6ZbVx80HAGkcdJtHwolbWv60R0iS7WVuI
 D8Ich8fYcKRT8zRdxMRzEyAZCqX605eOAkuk56iad6DRrkyR5hItbCcV6zt1uA3C12Ql
 gvcE0TtU6JK3v9huSFpoIz+xamHz454tLqXTeDqdtGxc9oCpbFo+8VncQeM4e5Phj0l8
 A+06rNWklOKEBPSNTCAB+TKRzxL0fv57yFyoe/HQMnVZgnKQFoXHTuEltiOEOQz32zMg
 AAxQ==
X-Gm-Message-State: AOJu0Yw8X9TkIP0CrJOnU0gIL05JyU4t/04E7VfBJATvqF8gvA7t4OTM
 00o5u/7aD5z5PxorvvByMlJL3pYZZvIG4fnZhCgBiODUp4GFoYOI0P0IKiqSTt3RM0Vn2BVvJnk
 x
X-Gm-Gg: ASbGncvkdK0FyyGS0UX/1O7vixOJnMcMnvCasOTLWAVZeyMh6MuIdmC6wH7JydyjiPV
 +EWcseeRHw0vM0FYr6lYXYyoKckiXButTsBx8ESxeh/bqUJXY7wEYn69ViwGm7sr0bCKvbYoUfc
 PXLn96SKlbr0d9horHQ1i8DBS7KomRO42LB3RpyWa3orVhC9plecDedtrlQk7q3hElWPwKqLgUX
 5nnA4KgTTcXt942pFklEwoplOypKksVa5x6pHLFkGjVN324pG3xcwKTJ9CmCM7I8O7T6sv2+kqz
 oxUFzFg9Nz/cgIGoi3GsaC20uGiWoHQpEh5f8DA3NchREIWiwU2Nhg+Pb/qIxdmYiRSVbUb04bQ
 19a9l0PzGRC+wfVykC+wdIQ==
X-Google-Smtp-Source: AGHT+IF9Wy/JtE9dAQO5zCmXk3Un6wDbwBjP5wb8Zt7G/Ab6xo1NF+YxjiE7A5KtSLE9P6tKxMwdDA==
X-Received: by 2002:a05:6000:1f8b:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-3996b4991c9mr214494f8f.34.1742228191599; 
 Mon, 17 Mar 2025 09:16:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df402esm15171282f8f.1.2025.03.17.09.16.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:16:31 -0700 (PDT)
Message-ID: <a9fd846f-547f-4769-9d57-20595640875e@linaro.org>
Date: Mon, 17 Mar 2025 17:16:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] clk/stub: add sc7280-rpmh clock
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250317-sc7280-mmc-ufs-clocks-v1-0-38e05c16511b@linaro.org>
 <20250317-sc7280-mmc-ufs-clocks-v1-1-38e05c16511b@linaro.org>
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
In-Reply-To: <20250317-sc7280-mmc-ufs-clocks-v1-1-38e05c16511b@linaro.org>
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

On 17/03/2025 17:15, Caleb Connolly wrote:
> Stub the RPMh clock controller on SC7280
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5fbbb07b7f7b93e619baf596064c4b3a3bfeecc0..343fa5cd3fe1704c6bb15a8c9852b9b4e4990351 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -49,8 +49,9 @@ static struct clk_ops stub_clk_ops = {
>   };
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sc7280-rpmh-clk" },
>   	{ .compatible = "qcom,sm8150-rpmh-clk" },
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
>   	{ .compatible = "qcom,sm8650-rpmh-clk" },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
