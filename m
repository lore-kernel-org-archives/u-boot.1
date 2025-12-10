Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFCCD3C928
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4EA283B48;
	Wed, 10 Dec 2025 18:22:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UsfOZ6CA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F034E83C7B; Wed, 10 Dec 2025 18:22:25 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4666283AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:22:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so359115e9.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765387342; x=1765992142; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/SclT3Omm+2CZXKkcGUNW/0XaceWcAuVmgtRXsAEUAE=;
 b=UsfOZ6CARfQT/bRWITqJ/aFcgqCa7SF5Bvy3BvUHsaK4AA8RdBGnf522X2RDWI30ej
 N6cf6KsYLJ+kRaWIM5JwwRVQM5qH/oJpM+Y9fuA1MdUg29z4Vh6zZwiBYp+0XIsY36/U
 lvKJXsSANiTmi9cJXUbSMJQM3XC0frsYZQnnqwF9NzyXz5ggrjTw2I2BYKhfw0n1owAU
 TvRGQR597hLxwgu2Fod80/Ff4Yll0GAay+gIoafLsBf3YUrTJWBg6oGjWNLijlGTVdms
 lFkFIB2BuqnSQ+Il6Foxn6kjI9qq1fm+zz96V9py7ku8+A9DO/GuISCNtVyxwVkuzjWI
 z7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765387342; x=1765992142;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/SclT3Omm+2CZXKkcGUNW/0XaceWcAuVmgtRXsAEUAE=;
 b=Mf3lnFnowEkqVlLzH2tbbysIvWbdotcCytpNxNjRNenJ7s8LUtTUxDygBVhLU1YUKe
 lHJYR5CM5uFVlb/yol6uaXSMTKtjgUwYue4tcF/gcWYNlELDqeJUdEId5s2+AuaTepc6
 fF9KNNoAakbtOTxseI3fN2i+fhM7SIxWphgCWaCsNGVbknIFK0O3N4cDxdhMzAtzFrq9
 0gV8cFJsrGqyxr8Jfqd+quuHQNq2zYFboAk/ZofymFMe5XcmzGYhUMvPTRN+naTM3FvD
 AN+nEAdslrEYJa6mi13frPCd7HlxpNPEwSCF7zmk2kVoc/l97LjlGs2fczjEO6M2HYOm
 vTKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0AHoxzU6wSB/ozaGIcoMI54+7y5YUinqRtUkjUx0scyfan+zzeWaOz+omD0t5EnDDn+vViS8=@lists.denx.de
X-Gm-Message-State: AOJu0YwFOskLXbV5IWaa69YMbIPmM47KhJEFyLdiu0imA7iT79cMfsUq
 cQZPGBPsMmcxIRm63wcOcYag4a5S3aYb+QO8OHPY4xzMqoRW77H6kB4mA41tXLbOsJ8=
X-Gm-Gg: ASbGncv7N8yyGgCCFdHg0vHAxOzIc134mYvXmPBtGRLTtkkt8OS3kJ3AKgwGVcpXiaZ
 pL3EbHWdvCeKqgtxrz14Tru/ML5bdfX2p8ib4hm2nQg2XQ1IRPAu41NPjr/AcMs9WrinXRMDrHr
 R2JjhSkGX0PejU2jJDoOxPLNsGXKLlFrp0epuPc645pA34Bmz8KMUbXBaoR4bLDFkhF96gOdLnk
 KLOFdU9it2kF2ETknyIuplZuoqhL23t6FwasYW6kS/GJKx4tB4+84961IBf5rPR80YeGW7fUYgy
 EgVIhZW07a25+bjc+261GnuTAU5Djhj0luKdB6O3YikeHzysPx7dJCKkurFk+hv97tdao7E93Fx
 3HtHqdHlJgev1rohO/5ahGpldgM/NY+RKG6WEYvNThhPucy9eu6XTNvn/iuwnuYIiV9Oz/cdqRe
 kWy62irPQLbCxH0nF1MRPGMBmLAhHkA+Rck/M9kmXCe6uBELw2Rowt5JPGLN6qHTI=
X-Google-Smtp-Source: AGHT+IEGhy86JbGqNlDWvi701eZr2/85Zeh/lYkKno0m+i1a8XIdhjnDKyqQ5iiKCFv4R/5cm/6Fuw==
X-Received: by 2002:a05:600c:5246:b0:477:89d5:fdac with SMTP id
 5b1f17b1804b1-47a8379669amr33863825e9.31.1765387342247; 
 Wed, 10 Dec 2025 09:22:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:4565:581d:e0e3:e5e1?
 ([2a01:e0a:3d9:2080:4565:581d:e0e3:e5e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8835c7acsm961425e9.0.2025.12.10.09.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:22:21 -0800 (PST)
Message-ID: <799a8118-f555-4fd9-8d3d-7bfa96fcffeb@linaro.org>
Date: Wed, 10 Dec 2025 18:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: Disable UTP command timeout in slow mode
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Tom Rini <trini@konsulko.com>
References: <e6deb9086afab9d2bdd53db8ecbc7db93af5204d.1764169598.git.michal.simek@amd.com>
 <d0bb740d-f4ca-4d20-9a62-0295438f16ae@amd.com>
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
In-Reply-To: <d0bb740d-f4ca-4d20-9a62-0295438f16ae@amd.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 12/10/25 08:41, Michal Simek wrote:
> Hi Neal,
> 
> On 11/26/25 16:06, Michal Simek wrote:
>> From: Padmarao Begari <padmarao.begari@amd.com>
>>
>> When the UFS controller is operating in slow (PWM) mode,
>> the driver is disabled the timeout for UTP send commands.
>> In high-speed mode, the timeout remains enabled to
>> detect stalled or failed transfers. This change ensures reliable
>> operation in slow mode, where command completion may take longer
>> and timeouts are not required.
>>
>> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   drivers/ufs/ufs-uclass.c | 12 +++++++-----
>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
>> index 3c8e4299259c..7a80a9d5664b 100644
>> --- a/drivers/ufs/ufs-uclass.c
>> +++ b/drivers/ufs/ufs-uclass.c
>> @@ -917,11 +917,13 @@ static int ufshcd_send_command(struct ufs_hba *hba, unsigned int task_tag)
>>           enabled_intr_status = intr_status & hba->intr_mask;
>>           ufshcd_writel(hba, intr_status, REG_INTERRUPT_STATUS);
>> -        if (get_timer(start) > QUERY_REQ_TIMEOUT) {
>> -            dev_err(hba->dev,
>> -                "Timedout waiting for UTP response\n");
>> -
>> -            return -ETIMEDOUT;
>> +        if (hba->max_pwr_info.info.pwr_rx != SLOWAUTO_MODE &&
>> +            hba->max_pwr_info.info.pwr_tx != SLOWAUTO_MODE) {
>> +            if (get_timer(start) > QUERY_REQ_TIMEOUT) {
>> +                dev_err(hba->dev,
>> +                    "Timedout waiting for UTP response\n");
>> +                return -ETIMEDOUT;
>> +            }
>>           }
>>           if (enabled_intr_status & UFSHCD_ERROR_MASK) {
> 
> Can you please take a look at this patch?

I started to check, but was preempted, I'll continue asap.

Neil

> 
> Thanks,
> Michal

