Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DFAECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 12:59:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0E5488AB1;
	Tue, 10 Sep 2024 14:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MycXdoo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E388902B; Tue, 10 Sep 2024 14:59:27 +0200 (CEST)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0EE88A1D
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 14:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5365c060f47so4872408e87.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725973157; x=1726577957; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FxBtOUMq2VNbAK33Y/MfZrv+izB+vU929krmlNheD9M=;
 b=MycXdoo0DQnivMwg425aNcRuuEBgzHWuM0yM5+dr/yMcnoisPftg10wdqpSuKsZGbq
 4BcDr+xzqZcWhjqYP10ER49PJj3AqokAijzsu9lznhASdcFeJRFY5wWffoC9FNMxbIx9
 qsVTPqFuALI0mz1Fu8u5g3+uvZnsCxQp/5jR5YPwttunoO6BPbFwZTYybCQQW3iJIF2W
 Gx42/XoGSIYcMbTxgDj/PNeHHTRg/hluPELreUivcpyuZ/Kmmx/CUZw9zfs8hA+6FstT
 JE6Q6Z1TwQKmxANxjnTRUjZXennYN2ImZ0xoMAq2qtHXEgx8UONS9Rc2AOCwVUV/S+EY
 NIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725973157; x=1726577957;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FxBtOUMq2VNbAK33Y/MfZrv+izB+vU929krmlNheD9M=;
 b=A6I/FxJSoEAQZBbiTb+9lTlwOeSQXEofz+6yYcrl2xvs4w9xYXF7IUpi9x/NBmNpvI
 XWNlWDb7YNa+UQ3J9PNBVMkWpxD1/tmr1qYgMktYn58N8vZFgTu0rLCND6wT0RAqOFZT
 T1qB9vZshX8MREHjSdGbl3ZQNwHDjPxGY3AhYXfL2/C8/McsfridLcjVA8Tv/4ZNsi4S
 w6xNejNqRZ+VvkpskI8wRmd8pShV+lXQtwl35Iq/htHxQV2bMDZq9ELZz/2le/sNJpKB
 2Mt8BPakOKhQ+qgTh0kNVqp1sGNiHeg1YKMf7BMWblRou8wp3LtrIXiN1mDhU1qPp7PO
 Ew+Q==
X-Gm-Message-State: AOJu0Yw36QBuJsmk5/rF9BTBl/NbWSDKXSlZM0FuORvOuhFZjhAJ5NsE
 95fjrvvVTB8Lv2c3Uh4Y+NJxUx4N/G8mDxaCOOBluVvcwGUhteboy7loGji0qqsKms8T7M1wRuQ
 T
X-Google-Smtp-Source: AGHT+IF+D3Iiv28l1XgczxDrfejevl07BHYg7vUQWJEOj4Vq5rEAE3M0hk6fLWodn2aNE2At7SB+Ng==
X-Received: by 2002:a05:6512:282a:b0:52e:8b15:7c55 with SMTP id
 2adb3069b0e04-536587b4169mr9538461e87.27.1725973155745; 
 Tue, 10 Sep 2024 05:59:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:44b1:5873:83f4:c201?
 ([2a01:e0a:982:cbb0:44b1:5873:83f4:c201])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649449sm8878023f8f.12.2024.09.10.05.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 05:59:15 -0700 (PDT)
Message-ID: <6a62be1b-34b6-4ae5-b285-4d711ddd7386@linaro.org>
Date: Tue, 10 Sep 2024 14:59:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 12/13] ufs: core: remove link_startup_again logic
To: Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <20240910-topic-ufs-enhancements-v1-12-3ee0bffacc64@linaro.org>
 <2f7f1274-bcc6-4f05-86b3-4be74f48cd73@ti.com>
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
In-Reply-To: <2f7f1274-bcc6-4f05-86b3-4be74f48cd73@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/09/2024 13:36, Neha Malcom Francis wrote:
> Hi Neil
> 
> On 10/09/24 14:50, Neil Armstrong wrote:
>> The link_startup_again logic was added in Linux to handle device
>> that were set in LinkDown state, which should not be the case since U-boot
>> doesn't set LinkDown state are init, and Linux sets the device active
>> in ufshcd_init() for the first link startup.
>>
>> While it worked to far, it breaks link startup for Qualcomm Controllers v5,
>> let's just remove the logic.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> I had sent a review comment here https://patchwork.ozlabs.org/project/uboot/patch/20240528-topic-sm8x50-ufs-core-link-startup-again-v1-1-146ca43e80b6@linaro.org/

Indeed I missed it, I'll fix the commit msg.

Nevertheless, as I explain in the cover letter the double link startup is
not done in Linux for the initial power-up:
https://elixir.bootlin.com/linux/v6.10.9/source/drivers/ufs/core/ufshcd.c#L10548

ufshcd_set_ufs_dev_active(hba) is called at ufshcd_init() right before
scheduling an ufshcd_async_scan that will call ufshcd_device_init() then ufshcd_link_startup().

The comment in probe says:
	/*
	 * We are assuming that device wasn't put in sleep/power-down
	 * state exclusively during the boot stage before kernel.
	 * This assumption helps avoid doing link startup twice during
	 * ufshcd_probe_hba().
	 */
we can assume the same from U-boot.

Neil
> 
> Would like Bhupesh to also have a look at this.
> 
>> ---
>>   drivers/ufs/ufs.c | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index d2df5c26f76..e34e4586224 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -462,9 +462,7 @@ static int ufshcd_link_startup(struct ufs_hba *hba)
>>   {
>>       int ret;
>>       int retries = DME_LINKSTARTUP_RETRIES;
>> -    bool link_startup_again = true;
>> -link_startup:
>>       do {
>>           ufshcd_ops_link_startup_notify(hba, PRE_CHANGE);
>> @@ -490,12 +488,6 @@ link_startup:
>>           /* failed to get the link up... retire */
>>           goto out;
>> -    if (link_startup_again) {
>> -        link_startup_again = false;
>> -        retries = DME_LINKSTARTUP_RETRIES;
>> -        goto link_startup;
>> -    }
>> -
>>       /* Mark that link is up in PWM-G1, 1-lane, SLOW-AUTO mode */
>>       ufshcd_init_pwr_info(hba);
>>
> 

