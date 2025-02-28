Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB26C282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 15:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6557809A5;
	Fri, 28 Feb 2025 16:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m+tlru5T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F9180BA4; Fri, 28 Feb 2025 16:25:03 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDC25807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 16:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43948021a45so21035275e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 07:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740756300; x=1741361100; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ztZELQeROLpISgNr2l4oRWjaDWkYYmo24rdKC6Lkm+4=;
 b=m+tlru5TvUb4o7IDndMCZxqEcCVmOMFyFwZSz5AhJy63RK6diVeJkmPwf7PCDY5dHW
 Rs070CGzfnD9r5xAcfU972/B3SkwGKwFW6/OFgfziB4D+rHS1xwt5cQzMYjMN7781YV0
 /RcZ47MlZby0w2Mjqy7IlQM022CRz4U0OQiiGU39XXk6PDVRSHpOCtn4Ae+ND6cnm9DF
 ML0qlcFY9LA0GIi1xd6mCrHeE5WD+5Ao0BrkL7J1cu6tNnqFRxZBbPW4A+qvSCgdjJ4H
 zJc8ib0yI2CmodH6aLPUwfjnFmwHrhNy9jV5jBpfeBNdpvSo7EjoD8mZUjDDiaJRfWz9
 KX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740756300; x=1741361100;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ztZELQeROLpISgNr2l4oRWjaDWkYYmo24rdKC6Lkm+4=;
 b=l9Udp+7H13vODT8Elkxaj3Z/BDgB6nihirYvSgIAOzCa+BSkRZA07CyEEtVikNm/pM
 et6HHAIhWkm0ywGNylPdleyyvtFq4Qa2X1FmCF+zD/Uxr9092Ju8hOaFLpocKd6REVQx
 6Ze/ZRWcFHc3yR9PjL3YVi0wNv+nEszjAjdB54TghmlQdmYoLRLOZv+scFxK5uydGhyc
 6Kpg+lZaycDWEQkmiCBTNvI1dYpDaCgXxDKWhu1QrtUGi77sU2tc7ou5h/6Yi9PobSas
 IjaKTEAykuN4G7q2sbfoEx9HEJFyB+f051s6s4n08BQ6pvlD5F8VwFqqe+j8tnbGLoID
 XJ6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAWyt9vUE2OguGsUyaEfnW2XS0rkMwYCcyydFWzU8BMEoXkAvFiVr0y6/ZhtBfzWJ98p4aboc=@lists.denx.de
X-Gm-Message-State: AOJu0YzQXAxQvBw25cIrTrvFAnl6Bgh/8Z9jWvxUYX3YxMBw8XTFvFLt
 NOynL1HZiGFkBnPGgjOMGTyTSMJgJWr7mdhOWhaYm/r/BmBSA9sAbMiRonROv9M=
X-Gm-Gg: ASbGncuuu1jdrz3SUx8PtsUH0ThgDmKK9jRi45D2lVO0/97bJHrn1PrHIXGWWfI76hh
 9ni5tLA3X2g9gHsZN/07MHgbQTeit7OrLxrOGs5E3bswbvuKPVNMv0VHY89jP8XnZDMbsamLly8
 B4739yCNx3j3vLc2zVIJT3SEsNqs0SjGeh4EG0AsH/s47VYmXvswmbA5kiRBhqjikU7rOkyYXch
 bWAkWOA0U4V2cPuwEy6GcxlS+3QybJddrEagRjtavlvnp8vCVDnlQZ/DaaHIZnL2vwyyzTL3FFR
 DgyCiiRHfGj3EoAGgmPvwR8szNs60C1PeYjSnPMv1QRTgxxYbZYfrcycbIOn0K+7m8ozuzc1Eh/
 mdEs=
X-Google-Smtp-Source: AGHT+IEpsJkt+o3lzbYV2JCesUvwMtt4/3JBassJqd4YHKy/7ntfBpQIDUcd2S1VwpRK8KHqJE08Dw==
X-Received: by 2002:a05:600c:350c:b0:439:7c0b:13f6 with SMTP id
 5b1f17b1804b1-43ba6a915bdmr33591375e9.31.1740756300254; 
 Fri, 28 Feb 2025 07:25:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fb45:6b45:b4fc:66e4?
 ([2a01:e0a:982:cbb0:fb45:6b45:b4fc:66e4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43b694524c6sm63310845e9.0.2025.02.28.07.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 07:24:59 -0800 (PST)
Message-ID: <42964c7a-a544-4139-9e5b-9097b9e29159@linaro.org>
Date: Fri, 28 Feb 2025 16:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [RFC PATCH] UFS: Remove the timeout while send command
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20250227060428.2070765-1-venkatesh.abbarapu@amd.com>
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
In-Reply-To: <20250227060428.2070765-1-venkatesh.abbarapu@amd.com>
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

Hi,

On 27/02/2025 07:04, Venkatesh Yadav Abbarapu wrote:
> Based on the UFS speed mode(HS or PWM) the timeout might vary and
> can result timeouts.

Can't you bump the QUERY_REQ_TIMEOUT to the PWM timeout delay ?

Neil

> 
> ufs-versal2-pltfm ufs@f10b0000: Timedout waiting for UTP response
> ufs-versal2-pltfm ufs@f10b0000: OCS error from controller = f
>   
> It's a temporary workaround to solve the timeout issue.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/ufs/ufs.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index f7d8c40c448..c3acbd709e7 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -858,7 +858,6 @@ static int ufshcd_comp_devman_upiu(struct ufs_hba *hba,
>   
>   static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   {
> -	unsigned long start;
>   	u32 intr_status;
>   	u32 enabled_intr_status;
>   
> @@ -867,19 +866,11 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>   	/* Make sure doorbell reg is updated before reading interrupt status */
>   	wmb();
>   
> -	start = get_timer(0);
>   	do {
>   		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
>   		enabled_intr_status = intr_status & hba->intr_mask;
>   		ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>   
> -		if (get_timer(start) > QUERY_REQ_TIMEOUT) {
> -			dev_err(hba->dev,
> -				"Timedout waiting for UTP response\n");
> -
> -			return -ETIMEDOUT;
> -		}
> -
>   		if (enabled_intr_status & UFSHCD_ERROR_MASK) {
>   			dev_err(hba->dev, "Error in status:%08x\n",
>   				enabled_intr_status);

