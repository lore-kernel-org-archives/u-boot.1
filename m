Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B93CD5BB4
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 07:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4164584659;
	Tue, 26 May 2026 09:03:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rUMN2dpb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F7E846AC; Tue, 26 May 2026 09:03:14 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50267844CF
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:03:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4905529b933so18878395e9.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779778992; x=1780383792; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=uUu+gYR6vA034x05twnlW/1lU2+DEl29sAPffoiKlwg=;
 b=rUMN2dpbiyIKUfUSvf+EXgh5q7DXbggYubC4VuT7a/dWapQtGEXY51ruNBTZwI7lmb
 IK+dgZoXzjae3WPmkTO6mQWksmik/6/4hpBSGCpJrGIVh7pYV+F9glQUZk43o8VFzjXg
 Sya/SSgGgm+kxU1Mnp57tnwkwOdUJCycdNoc71o7wFr7vwhTz6FJBKa3gR89vfyyWT9T
 ZaFsVYVII5EESpCKRgjfIqCMCtLURoCKg25hBKSwlm6Z2hpwhImzG/k0IiXurmVhCmVi
 dWent8ZJ8vbyCbkR1iJY3vnfjuA2Zn1dQbDXZTlXjZSzNA1xrcxKhzq5lz9uD7WQvfNW
 Y9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779778992; x=1780383792;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUu+gYR6vA034x05twnlW/1lU2+DEl29sAPffoiKlwg=;
 b=py0+ncaGjjPLEKuutVWe2Qf/pePDCPNfs71BY2nno67urQSHAw1NjhpZS3/qB5wLz5
 R45ZEq9g5LMHgDfkyRZUOYqnRBXvjV1WnezucxCfTAVn34lEf5KhF1QFhpSr7Dl5f/E4
 W94YwuwoXx3+Z3Pq7SOqetwklodR21eVbnJCA86Yr4C65t6PlKTgDrQ23Vu45ewXs6cx
 UJ38xHURb9LIJqDqMA0xaWzBIBzCSio7AoKWi6F2N9uupN1p77lWBU45+JwJw8EaB6iX
 EcaNtA8b/IoD2PZVFS/j8IxUkCJN4aH15YVOOjUwrQdZ1QUDfONJ92LMAdI5ndsWvJiR
 6ecg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+goAmpQokHXUNTgpioU+Z6Q2e57ofV8sNEAKVgkNQuhNFnmvj8bkul7irQ5s2CUuDclSh1jAI=@lists.denx.de
X-Gm-Message-State: AOJu0YyHnSZV63VrxqHqENoD1vnKaogly0OvxjlidJSWOeM9NdIonpG8
 1bT4ZywtDGqvh2KyIi9iBdBPb4f9n0Dnq+jIvQ48aHS/9wYfhG3clHRqN3e1eeb2bSw=
X-Gm-Gg: Acq92OFLY+df/lW90gJkccAA4mX+pPlaRBp23Qg9pf/NPr+fIbQRkVJ2pFZVZXLFM4J
 ItRI6wd0CZJNI2XExoVBErFIbebP9zTVdBVA2yEzLHldAIn2NuoxspcW22iruTWUeta7Uu8jT4N
 rIBIXJNBJ/GzaIXVLtvPMQDWxesNqI6X1ptFM5hIAWNMHkXCQGGWWT5XLOYBvbNvhgTWupr8xNW
 f+or7QF6amqvc5gzsVyEyK6+PX1rse+VBcj2xcn1u1m3IAH2tb49hM2hCQrFCGcR3tWItql0JMJ
 ZPvE3jxhZyFErgcdREyhpOpdfB8UaAKokE5lQy5iCHlVgWim8b1r6RU1vNHWav4GDl/n7jTc7O3
 1g7QGEjkfuVHxdc0Y8WyPZl9+NBkvd9qhHIHrRH9yaXarCeXPF8yeHQ6nRH9C6ddjMoP2Gg336i
 siiHmQctrWWtUOmQjxNpLQfJvLN6PHROv+afN5SfPt5/+pLngLln/2pNge6arFTzshGuvqttxAn
 r1ZSFM=
X-Received: by 2002:a05:600c:3113:b0:490:6237:521b with SMTP id
 5b1f17b1804b1-49062375366mr126708985e9.27.1779778991592; 
 Tue, 26 May 2026 00:03:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:aba9:2be3:1465:636a?
 ([2a01:e0a:106d:1080:aba9:2be3:1465:636a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49048c6acf8sm91202275e9.10.2026.05.26.00.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 00:03:11 -0700 (PDT)
Message-ID: <ade2d8b3-0b77-4c5a-8636-aa3ddd5a8b64@linaro.org>
Date: Tue, 26 May 2026 09:03:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] nvme: free prp_pool on nvme_init() failure paths
To: Prashant Kamble <prashant.kamble223@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20260524145721.9206-1-prashant.kamble223@gmail.com>
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
In-Reply-To: <20260524145721.9206-1-prashant.kamble223@gmail.com>
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

On 5/24/26 16:57, Prashant Kamble wrote:
> nvme_init() allocates prp_pool after configuring the admin queue,
> but some later error paths return without freeing it.
> 
> Free prp_pool before freeing the queue array in the failure paths
> after nvme_setup_io_queues() and namespace ID buffer allocation.
> 
> This fixes a memory leak during NVMe initialization failures.
> 
> Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
> ---
>   drivers/nvme/nvme.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
> index da7dad9f52b..9df7824b1c5 100644
> --- a/drivers/nvme/nvme.c
> +++ b/drivers/nvme/nvme.c
> @@ -886,14 +886,14 @@ int nvme_init(struct udevice *udev)
>   	if (!ndev->prp_pool) {
>   		ret = -ENOMEM;
>   		printf("Error: %s: Out of memory!\n", udev->name);
> -		goto free_nvme;
> +		goto free_queue;
>   	}
>   	ndev->prp_entry_num = MAX_PRP_POOL >> 3;
>   
>   	ret = nvme_setup_io_queues(ndev);
>   	if (ret) {
>   		log_debug("Unable to setup I/O queues(err=%dE)\n", ret);
> -		goto free_queue;
> +		goto free_prp_pool;
>   	}
>   
>   	nvme_get_info_from_identify(ndev);
> @@ -903,7 +903,7 @@ int nvme_init(struct udevice *udev)
>   	id = memalign(ndev->page_size, sizeof(struct nvme_id_ns));
>   	if (!id) {
>   		ret = -ENOMEM;
> -		goto free_queue;
> +		goto free_prp_pool;
>   	}
>   
>   	for (int i = 1; i <= ndev->nn; i++) {
> @@ -948,6 +948,8 @@ int nvme_init(struct udevice *udev)
>   
>   free_id:
>   	free(id);
> +free_prp_pool:
> +	free((void *)ndev->prp_pool);
>   free_queue:
>   	free((void *)ndev->queues);
>   free_nvme:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
