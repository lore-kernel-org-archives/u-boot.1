Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF8CCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:43:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C65D84693;
	Tue, 19 May 2026 11:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dTNXPnb2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B488469F; Tue, 19 May 2026 11:43:04 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C68C08056B
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ad135063so25659245e9.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779183781; x=1779788581; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=H/0WEw/ksLA6GN6PoIH5YQ5cHQLovSUFQoTGbQ2xc7w=;
 b=dTNXPnb2Yb68DMuwVeyYlXgiEE63cWIYdjDQXF+rucnKEon8XCcG1cvQc8nYj6SS9D
 lk1zpWmm8vNb5OeHtZOCHrLLw4lwQ+/VX/Wa+gX5L5N6FnF/D0Bt4DfZPb3rvL3yJzFw
 CyWrNB5XbluVywXBWrK9Vj9FCQ0Gkk9/BOUsbM/CvCy7U1AdYQXU0hXqlX5aSx9tPuDd
 02QXZZYNh7RFkvjEfsgCpu7XLRvG2qTcWCQPU89V5RU6vKnuAXcsSbXkGkvHQcT0uwpT
 cKrz7cuuaZuHjYpRMLwbZxp3hNAsM+ejy76Ksv8R/zKCyjpNsVQRgrqNPDCNA41g39fe
 oNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183781; x=1779788581;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/0WEw/ksLA6GN6PoIH5YQ5cHQLovSUFQoTGbQ2xc7w=;
 b=kOESN7TxREwN5VTeMIHYUtPtvaJsJnlwGf+58wf4HnP2pwhuxUwH7VGkB1IuDn9jl1
 nA/w8N1b/1GYJJeqV96czqCDFkzZGwer7V+7dfOLZ7CymvMQoZywglS+MCU3TuzHP8md
 nOn9EC5wlKlbDjhv/0xHpD+eCK29FwSWhRaCvjgHou+6VDQqEQTUaIPquB2/xcRrbmEv
 CntgTFOpsyrX9YJGiZEcXMqDPpRXjdNykThgAoXFtvf3H+rVnTmlJzTMhh8B9SiGtvUs
 sPzrWojXmjM53dS5jOgL+XoSafXcc1U0q/YfmqjhcBFhJrmR5Ru03y/0LqwGDwNQV42Y
 xldQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fjPjjww2Icebi6C78QBRDeHlKGbnBDIU3jvKW1Y73INrgKlDFzpW7Xljzm3Gqbj7l/PWd2o8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6KkG1QRQfXm3u7D+faqLLnteWGJ3FB7rmiEa3DJeTU1ShNpt3
 TNcPaQW1YsJ/UcNT7UI7BrCmLqgM7dKgr7D/tCwAz0bAJgwr9ovTwPxEa+L0e7Jkpkc=
X-Gm-Gg: Acq92OFvmC3VgmwsfxAFHEx0c/pMWhgZMVRfFoAjtd0pfV+T2kA1SAJid+5zBkQr/Lz
 WrW0zE0K4oRmzuUFS+/iGV0WWVyAAGq3F9jQN26KUlzA2XgcaIYOFcpid3P0RcwlGUewxOnko+A
 Ci3Dtx5Yi9Q8AFiemey9Xf4tFrY7CN495upK2at5wIZZ4L148ib4PNZsbKXXD2kuek6rJkrpROz
 KqiKdcbfu0Oh4cc5VcnXazudqfkjUH99WDvFRYL7nbAHKWHyAl5QATdXTSnqcH5DBtG+mKAj9N5
 C2nvDsFyHrNzFji/0egYwyN5qiCeWWeCtNrTz2+fHoEZ7xJK8ASGI2CtDEiz1uptJNHfL8QzWXF
 mtFCEzNSFYFsmgRo4Ed7zWxLIxmYcV28YJT4zdEm+bet6Dr4EQWfudLM4C2zpwx3cqI6IFoQVmf
 VmkDetISI4Dc9ieL/B7zM1YYCOM91dYyzQNpxvG7ceMuUWKRwl9V3E4yQtFLwjzDiti25Oj47SE
 Iivpo01Ko426xI=
X-Received: by 2002:a05:600c:848c:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-48fe60e54cbmr289627135e9.1.1779183780923; 
 Tue, 19 May 2026 02:43:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe5bc94sm193103745e9.4.2026.05.19.02.43.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 02:43:00 -0700 (PDT)
Message-ID: <e50a8489-c796-4bb3-9b39-4fac3577f136@linaro.org>
Date: Tue, 19 May 2026 11:42:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix command ID wraparound handling
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20260518060915.45607-1-prashant.kamble223@gmail.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260518060915.45607-1-prashant.kamble223@gmail.com>
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

On 5/18/26 08:08, Prashant Kamble wrote:
> nvme_get_cmd_id() returns 0 after cmdid reaches USHRT_MAX,
> but fails to reset cmdid itself. As a result, all subsequent
> calls keep returning 0 indefinitely.
> 
> Reset cmdid when wraparound occurs so command IDs continue
> incrementing correctly.
> 
> Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
> ---
>   drivers/nvme/nvme.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index 2b14437f69c..4f9473367d3 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -112,7 +112,10 @@ static __le16 nvme_get_cmd_id(void)
>   {
>   	static unsigned short cmdid;
>   
> -	return cpu_to_le16((cmdid < USHRT_MAX) ? cmdid++ : 0);
> +	if (cmdid >= USHRT_MAX)
> +		cmdid = 0;
> +
> +	return cpu_to_le16(cmdid++);
>   }
>   
>   static u16 nvme_read_completion_status(struct nvme_queue *nvmeq, u16 index)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
