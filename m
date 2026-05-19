Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A342CD5BA3
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93865846CA;
	Tue, 19 May 2026 11:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N2zpxIuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51D89846CC; Tue, 19 May 2026 11:43:25 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE90F846C6
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48fde648a71so23780395e9.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779183802; x=1779788602; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2QaSV5xwxYEP32Sr1KXPP5PkH0qA+Itl8WH0Qca/xLY=;
 b=N2zpxIuJVgKSKufCtuQNdh76d+XKZEEK0XAhbkG9aq2jR7iH1QE6Ag/RW4nKYe/jYK
 sgoL353DOvuLd449SoEPyOd7N59xOowNhcKjy826EW4F/P+RTeHSgjgxuCvVrpbYJy8e
 AWAJJESVz27ci6ASdZsJIf2mL6A+FrpCXteB+DehJjVN8nAFashcx3L7k71kDszlNf7+
 DqD9nAGjn+/LV67j58wHm/xOCUtaX+bYoKY/L6l7egHh4HIbSIOv1+tykk2/DlgJnFI1
 YovWPsl91lYYcBEYXLIrkwQzuOZ1x7hcUNaBuxljCGxSlMWsOnVM4amQ+OkALIRLFKW8
 Qlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183802; x=1779788602;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2QaSV5xwxYEP32Sr1KXPP5PkH0qA+Itl8WH0Qca/xLY=;
 b=Q4GVfx2hBQy8F8CVlbKvKuIroSu0TxHz3W5ARYflcHFailv1IXZYXs9R26xwmKBKOb
 3tapDBYgwCV8VcV5R1ZvgA3qwNd6AKDNv/EFWZdDXK2aJ8KdYky4wnadUYTYMaMP9cxC
 64iLWNBbq4hLwa2EcIfLm2CAmdhUZj8d89WiOuxSDcJDwq+X3rpeYBQ73jC2OCKbgJE0
 1n+jqgE/IXNz05hNgeDXJ/gdmPciQqEOp9I556NddemI3Cd48IzN5Qd/3kdlGiIbwoJ6
 xMmmyuGk7RVkD8Y9TeCLXv43hlycxTU0mx81HlyZbRcb+Ar4MBc55BRBtQmOVoIXD1/+
 HC9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9AmzwGF8Ga3c496Sjrbyj+FLJjS1msc2jo3/KFdmdjKVb+aUgAcCKe8ubcSg1d9YUWd+L+/Do=@lists.denx.de
X-Gm-Message-State: AOJu0YwxexX+c+PcCkk971qw2Fz4S6exNsGnK/X+n9vjDQgarVz+RUQL
 Q0/M0xaQfzI8ZJqjngRp5OrjIVA3ajtCKHeLkfqjd2Au9wJhewXA8Mj8Py+vWJ2Yug0=
X-Gm-Gg: Acq92OFkaS8SnraqAUh0HdncAnhzpkmAP1RWeYdGsb/e5MyoYBy3krGj0GRai9KLb5o
 1voOC3PR8y2HutPEC7Qf00TINietMtEj1Q8nSVVxTof5UFoza2Ug721mQ9w+UfmqLTGE8MD6/9C
 stSpCN3lO80/+oN99pUdbFZBtQ6Vv012Jy3XuEODK+Dpn1P6fae4uVA87EhqcWdrsuJTabXIQMK
 XYl1HfMODGv03wAVu/Emo0fhZQaxPIdZV+RfhL0cMgO0/AyU8QZ+x038mjcrsr0sbxEosTD6KJX
 PFubzaAD49Ei9i99tEZkEZaYpJe1mcHH/AovYAC7EPgZEgq/uF/OOrvkbffgLVDO2zlkzzZqOEf
 tqybLmIykWtMnZm6BmmKEtUERpnzcwYWzMRo2DJEcUzcGLgJwK+IacrV9WiV0/G/1JBZNvaAD0T
 CMw21ISsOhONooCvt93zYEvKKg3uw/K/eOrS+jojR0/XCnsuGdj28cFLoq2sqjI7NwnT9myq267
 vUxSSu8gztZSmc=
X-Received: by 2002:a05:600c:a30a:b0:48f:e230:29f4 with SMTP id
 5b1f17b1804b1-48fe53a4866mr211981685e9.15.1779183802116; 
 Tue, 19 May 2026 02:43:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:1d4b:274c:94d:a69f?
 ([2a01:e0a:106d:1080:1d4b:274c:94d:a69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8d39esm319524415e9.7.2026.05.19.02.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 02:43:21 -0700 (PDT)
Message-ID: <95229be5-73d4-4cb9-8b9a-31b44cc10a8a@linaro.org>
Date: Tue, 19 May 2026 11:43:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: apple: Check memalign return value
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Mark Kettenis <kettenis@openbsd.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <BESP194MB280542535B098A33C8A815EEDA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
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
In-Reply-To: <BESP194MB280542535B098A33C8A815EEDA3A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
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

On 5/9/26 22:13, Francois Berder wrote:
> memalign returns NULL if it fails.
> This commit ensures that we handle this failure before
> filling the buffer with 0s.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   drivers/nvme/nvme_apple.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/nvme_apple.c b/drivers/nvme/nvme_apple.c
> index 7e7538553e3..46af1d716ff 100644
> --- a/drivers/nvme/nvme_apple.c
> +++ b/drivers/nvme/nvme_apple.c
> @@ -87,6 +87,9 @@ static int apple_nvme_setup_queue(struct nvme_queue *nvmeq)
>   	}
>   
>   	priv->tcbs[nvmeq->qid] = (void *)memalign(4096, ANS_NVMMU_TCB_SIZE);
> +	if (!priv->tcbs[nvmeq->qid])
> +		return -ENOMEM;
> +
>   	memset((void *)priv->tcbs[nvmeq->qid], 0, ANS_NVMMU_TCB_SIZE);
>   
>   	switch (nvmeq->qid) {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
