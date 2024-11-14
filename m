Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D42D65C6C
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 11:05:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25362895CE;
	Thu, 14 Nov 2024 12:05:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dv4yz8Pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D58D689613; Thu, 14 Nov 2024 12:05:00 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C78CF89574
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 12:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315839a7c9so4711405e9.3
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 03:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731582298; x=1732187098; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=2PfE4RuheTb6k8/JB+8283wC9GI63fQFQ5M8TmT3fwQ=;
 b=dv4yz8Pgd4od2rj+TtwXOe0qZaI3mM+fMTEIduM0ydD9v8aF1sQ+jtzoHBMIDPBkLG
 q2NGqeTzR8vLUEOXY3o8ik3dUdVp9jxHzoj5RNsfLeBwOyVmf2rLzx8QZkeUQQUuAzsL
 6ht26RH6/Ai1R92OZBTnEr9hyzdsUDmDsI454BaxkZYvoZdfeMgheRUqK5g126oPKdAu
 9VipXgz4LzklzlcApvmJot0f1tAodq5KoLt9ToZIkotaBmDS/o36cqdGQzDi6s4HsBOU
 mAPQOcTPc9MzILZsrNw8IaXrdzueBENDHohDl2L1940PwGO+CjQlCmOsd3z+bBBOKvkT
 CBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731582298; x=1732187098;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2PfE4RuheTb6k8/JB+8283wC9GI63fQFQ5M8TmT3fwQ=;
 b=ZtWyo/adlEOgpCQonyhoRbz7aneMe9DwpW8r6jF7yuJDowL2Nt+DOY5zu7ouM1SthI
 ITFfJzHZyyz6Te0Gu2VqfIZzTzReazldGaDrS7J0KA0417PHT4z2o88v4L9vEkeD4oOv
 ev8hqJXCAb7lZ9Nt5sZiO6sE9gnsgj+OTLx/emzt7bEXrF3XbZLA56g5tcJLs8LpXxrx
 ySTtKDJtuMAHjKRZegZpCxoDf/yPdXkbxEM11CAXbaGCmp2D60EEhxFQvgb2YQrvsQCf
 UOEXXrNDXkaWj+mHB76+PTrOc6RqqvKhJKaMd0lXUd9CHrqd4xMXIYtQSru2B1I69a/e
 8Bng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFhHlx8C641fC36KWBN/v2VzFoy1w9yd5iom7C4JQGEdpu2yhlbd/aduP10G3tmQIy2kz32YY=@lists.denx.de
X-Gm-Message-State: AOJu0YxNb+K2Iyjp/hKZaxEieOR9B3voNPVIeV99KmRWUNfjdsppSEGK
 5oNnMvHVyn7WsOoqAN2Z59AHQTKE2+wx8IYye6Qd36dXu908ia45MIB/GV/Igxo=
X-Google-Smtp-Source: AGHT+IFleY60umrY7yy6gW7kiHlL+VlRx7IlwWw7eioBgUjcYHnlgNxEI+nTHbWvqb8MPzwgaqc4iQ==
X-Received: by 2002:a05:6000:1564:b0:37d:4d21:350c with SMTP id
 ffacd0b85a97d-381f186cc7fmr19502498f8f.13.1731582298198; 
 Thu, 14 Nov 2024 03:04:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a62a:6bba:b737:406e?
 ([2a01:e0a:982:cbb0:a62a:6bba:b737:406e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821b31d9ccsm1069485f8f.99.2024.11.14.03.04.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 03:04:57 -0800 (PST)
Message-ID: <38da5ee1-8049-4f9e-b88a-5f6aa3fcbf91@linaro.org>
Date: Thu, 14 Nov 2024 12:04:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] iommu: qcom-smmu: handle running in el2
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241113050931.1853447-1-caleb.connolly@linaro.org>
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
In-Reply-To: <20241113050931.1853447-1-caleb.connolly@linaro.org>
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

On 13/11/2024 06:09, Caleb Connolly wrote:
> We only need to configure the SMMU when running in EL1. In EL2 the
> hypervisor isn't running so peripherals can just do DMA as they wish.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/iommu/qcom-hyp-smmu.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
> index 1b5a09bb7b39..7b7b3ba01a07 100644
> --- a/drivers/iommu/qcom-hyp-smmu.c
> +++ b/drivers/iommu/qcom-hyp-smmu.c
> @@ -90,8 +90,10 @@ enum arm_smmu_s2cr_type {
>   struct qcom_smmu_priv {
>   	phys_addr_t base;
>   	struct list_head devices;
>   	struct udevice *dev;
> +	/* SMMU is not needed when running in EL2 */
> +	bool disable;
>   
>   	/* Read-once config */
>   	int num_cb;
>   	int num_smr;
> @@ -276,8 +278,11 @@ static int qcom_smmu_connect(struct udevice *dev)
>   	priv = dev_get_priv(dev->iommu);
>   	if (WARN_ON(!priv))
>   		return -EINVAL;
>   
> +	if (priv->disable)
> +		return 0;
> +
>   	mdev = alloc_dev(dev);
>   	if (IS_ERR(mdev) && PTR_ERR(mdev) != -EEXIST) {
>   		printf("%s: %s Couldn't create mmu context\n", __func__,
>   		       dev->name);
> @@ -347,8 +352,10 @@ static int qcom_smmu_probe(struct udevice *dev)
>   	priv->dev = dev;
>   	priv->base = dev_read_addr(dev);
>   	INIT_LIST_HEAD(&priv->devices);
>   
> +	priv->disable = current_el() > 1;
> +
>   	/* Read SMMU config */
>   	val = gr0_readl(priv, ARM_SMMU_GR0_ID0);
>   	priv->num_smr = FIELD_GET(ARM_SMMU_ID0_NUMSMRG, val);
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
