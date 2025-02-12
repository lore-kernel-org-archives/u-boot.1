Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAEAC02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 08:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D08180824;
	Wed, 12 Feb 2025 09:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e5c00vh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90A31809D0; Wed, 12 Feb 2025 09:22:35 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98AC7807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 09:22:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-38dd93ace00so1956558f8f.1
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 00:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739348553; x=1739953353; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=A4A02sqlrsMrpHcnK/dJCXAFqCNxdPnrv1lioOyoK8E=;
 b=e5c00vh7qZ7VtjXgaedyXpjg/iyernaqDAqUPwPrJCibB042ayOVOodgcprZr664RF
 03THxEvkk/fzwzq7nIadplOhOFiZGHr3pFJpDoi8N5QYGxv1qyOphUOUDZW6BQz14i5w
 eGHufAh8s6SePg4LpjpRxDxWhJFSrZNVnQP8JT8xSmYehZ42hlMa0+cE0GV7C9fUKpUz
 R+JgbxzqkmQGCTOi46GIf3hqr51NndKq1EN3bfcPg7pWFC/BJeA9w6M0rV3QN10loyyW
 vlniuF0ri210F9has1i0dQn1z43umzROTAYX6kbcKQEWU3yyYpoojoBwbzTpuEdktFms
 6Pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739348553; x=1739953353;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A4A02sqlrsMrpHcnK/dJCXAFqCNxdPnrv1lioOyoK8E=;
 b=AllwEZqk3Dq1qy0mKjAdNytziDH+bKItARYVfNEjjcRgRTRm1PKxlYDm1E/1F+WhQO
 Rn5VGLQiOtrcYunIFgNVFWp+VwTjqsPY8EoCSYS9tYyo9Toe0Yj/C1FvIDeiGCdc4RiO
 y4FOpEaoyMxTgo6wgOcLsW0Z+6C6DdJgX4sE4yV03Ga95Pl0aLmNDwW50UJboHt04ckn
 L3C33vyVZ+Is1lQYkNulev6arRUQ9jQo4ogsb/3todt8ppUFjbg7NhVbUU5AmWj4RsHP
 UZt07zsF66Fe2EGmvluO/WkaPIN8OUbhUx0Y+bb76wJUETTfJ0o52Hf5cliRlgisspQ6
 M2kA==
X-Gm-Message-State: AOJu0YzMcYt1Ihm2OViIRH1ta4g/DgI5fNoWTXgnWJFWC2hPhd+D/21Z
 nN/cmJADyHP2OpXUt6c/D6jAWfb0eQn1veBSeNJ+TePRyQEsZTLRJHbF9nHQ/akKEDxxl7cFLFg
 D
X-Gm-Gg: ASbGncvmPNcp5cnqrJ3sBUchL/apQCbKnUR1BB/wdOFVsM1/tCEiijk8If49WfhtIg1
 L29MfQ3IYAw1PqeeCwPzhU/3Mu5imsplrSQS1bmhOGxVkfJ6xDgaKOFuWUPLD2Je+9idIig2YpX
 BCTUdrrWcBBJXA4MQ8qsfrM61P11VjWmA2uZdC1THn5APsDNKOp0wlM84iNGbjdWY5KchxyjylY
 VcA+IVyI8anITiem1XWc49RNJRel5taWNYyD+wKDvhKtFGnu7lmroTlnhVAdJ2PX9vkmALmc6M+
 5CxrcPeJeq8tJoZ1fV6S3Ac1Q5DEeOntDq8A7uB5DaC3J4NTQ+5h/s/Pg/OqocBMTLKj
X-Google-Smtp-Source: AGHT+IHag99LNao790wT2sTBIcTT5a8Lo0gGQX2jgmGmadynfjIuGjbM2baEWVwObv/hbUQuad0FxQ==
X-Received: by 2002:a5d:6485:0:b0:38d:bf09:aa2b with SMTP id
 ffacd0b85a97d-38dea2ece7fmr1550007f8f.54.1739348553088; 
 Wed, 12 Feb 2025 00:22:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:aaf2:5110:cd96:8172?
 ([2a01:e0a:982:cbb0:aaf2:5110:cd96:8172])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f026a81a5sm499914f8f.65.2025.02.12.00.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:22:32 -0800 (PST)
Message-ID: <2191af37-01d5-43a8-b1d0-f6d43669ec2f@linaro.org>
Date: Wed, 12 Feb 2025 09:22:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 3/3] clk: stub: add sm8150 compatible id
To: Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>
References: <20250210-b4-clk-stub-v4-0-f1e7d845f57e@linaro.org>
 <20250210-b4-clk-stub-v4-3-f1e7d845f57e@linaro.org>
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
In-Reply-To: <20250210-b4-clk-stub-v4-3-f1e7d845f57e@linaro.org>
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

On 10/02/2025 17:27, Caleb Connolly wrote:
> From: Julius Lehmann <lehmanju@devpi.de>
> 
> Add support for sm8150 clock controller to clk stub driver.
> 
> Signed-off-by: Julius Lehmann <lehmanju@devpi.de>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index ea817031fa6c0cc1ea21000273b5651be5d05e65..5fbbb07b7f7b93e619baf596064c4b3a3bfeecc0 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -49,8 +49,9 @@ static struct clk_ops stub_clk_ops = {
>   };
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sm8150-rpmh-clk" },
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
>   	{ .compatible = "qcom,sm8650-rpmh-clk" },
>   	{ }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
