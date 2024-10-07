Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298CACFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 08:15:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B043A88B78;
	Mon,  7 Oct 2024 10:15:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PGTJmV7y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32BE888C63; Mon,  7 Oct 2024 10:15:17 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF4E3884DB
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 10:15:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37cd3419937so2479119f8f.0
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 01:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728288914; x=1728893714; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CjGHEVLNIaMSva5DwxL0IzG3G3qYfEGpHN4fUVxLADk=;
 b=PGTJmV7yfMF841C1KIvlWgMjv9d1zUD/0R1OQlNOZ4aRa9Q7WjLI9Asd+KaQ97Z+B0
 g2ZzfHfeCLwIWgc/7Vf/JhyN3ehsx2/SATuHVueDUJ7zT0R7XmtjbKU3BMoUUVlb4mEF
 Ex8eNJdSuEIaMCrYaVVgPV+3AqnCsaQo4lQRyeQystpGg63zxnsukHoWpHXfwSQCjwQ0
 a99MwXkcKvC0JRDu4KPACLVIRzLd9uGVASSGC14kW/mR8YCuGqFiTjzXgTBhZ6I+L9AR
 vzZ5qYNSyZXyIz++kZyJSSi4+RfvqunnfvfNYqBeUE31Ts8Uye6VjxBW8gQ355QBePdj
 jsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728288914; x=1728893714;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CjGHEVLNIaMSva5DwxL0IzG3G3qYfEGpHN4fUVxLADk=;
 b=uZElfbTLVKhIBMngfQj53yQagaJfZGHb9+KY0dTWFSAkKRhciogrDo8UpMdMR65gSu
 vUhEZQ8RfPwi6VJ2sntwwOGZLOrORpdiyJNfjZDQTS/LKl5XJYWMQaaq8+NpY5qY3ETI
 7XBS4GPldtppMgQxrdB7bb4wCgFq7COMfBSF0plDnAG3VNDZ89Vh7ZffRxkHeyd/TZa9
 xTaW25QMQIP40r3aPvMPag2A54Kb/pEpdBsftJBvmsMgy/NFzzPaAuNHNSdVcduwRRfu
 QVq/RB51qVc341CbcOhTB1cpsTqCRP8cvSNxkebQyvbS5x2lwgSSNiH2oBFlbcQUIayH
 f3Tg==
X-Gm-Message-State: AOJu0YwYU4FyisWHIcpwz7z2cfQmGpjd1RiNMhWXtNF5jCDN1F6AkDL+
 EGLiW+uiUrtbjCT0avZK7MdXjpLaae1FyON1iTiq16JsvZLk7wwaKaNUINqQLag=
X-Google-Smtp-Source: AGHT+IHsgvYNmys/Z/cIOH6DYWKJbbXCmIlulbqiq9PGIl8OFginI5R+F+hCd7IhtzUrjr0dT/h1FA==
X-Received: by 2002:a5d:4092:0:b0:374:cd96:f73 with SMTP id
 ffacd0b85a97d-37d0e6dab46mr5993070f8f.3.1728288914307; 
 Mon, 07 Oct 2024 01:15:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7?
 ([2a01:e0a:982:cbb0:a99f:3c24:fa3b:1e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1691a713sm5121947f8f.42.2024.10.07.01.15.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 01:15:13 -0700 (PDT)
Message-ID: <c4f8bced-1adc-4f69-908f-4530d3de0f9b@linaro.org>
Date: Mon, 7 Oct 2024 10:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/4] ufs: add support for Qualcomm UFS Controller
To: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
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
In-Reply-To: <20240910-topic-ufs-qcom-controller-v1-0-54c0d2231b10@linaro.org>
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

Hi Bhupesh, Neha Malcom Francis,

On 10/09/2024 11:50, Neil Armstrong wrote:
> This iass Add Support for the Host Controller driver for UFS HC
> present on Qualcomm Snapdragon SoCs.
> 
> It adds 2 ops to allow more control on the UFS device.
>          
> It has been successfully tested on SDM845, SM8250, SM8550 ant SM8650 SoCs.
> 
> It builds-depends on the following serie:
> https://lore.kernel.org/all/20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org/
> 
> And at runtime it depends on:
> https://lore.kernel.org/all/20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org/

Could you review this patchset ?

Thanks,
Neil

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Bhupesh Sharma (1):
>        ufs: Add Support for Qualcomm UFS HC driver
> 
> Neil Armstrong (3):
>        ufs: add device_reset callback
>        ufs: add get_max_pwr_mode callback
>        ufs: allow UFSHCI version 4.0
> 
>   drivers/ufs/Kconfig    |   7 +
>   drivers/ufs/Makefile   |   1 +
>   drivers/ufs/ufs-qcom.c | 670 +++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/ufs-qcom.h | 147 +++++++++++
>   drivers/ufs/ufs.c      |  13 +-
>   drivers/ufs/ufs.h      |  21 ++
>   drivers/ufs/unipro.h   |   6 +
>   7 files changed, 863 insertions(+), 2 deletions(-)
> ---
> base-commit: 7725e4eb07c03ca0842b0a7ed425af28e1b8ed37
> change-id: 20240910-topic-ufs-qcom-controller-4b2905610963
> 
> Best regards,

