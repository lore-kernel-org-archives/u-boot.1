Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16391CCD197
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 10:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E5B488B49;
	Wed, 18 Sep 2024 12:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GdR5wsDD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A05688B49; Wed, 18 Sep 2024 12:40:35 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008F588DBA
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 12:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3780c8d689aso4838191f8f.0
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 03:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726656032; x=1727260832; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/YftGR5akPSnbShux19TfK7C1vu5vMDSi9Y4aNS6h7M=;
 b=GdR5wsDDbNySA07L8u/cWcSdNsYZH+FpwcuE2w800P/Tg5CnflmvD1RNDa1m1+FK98
 DWSXHsot35j71QLaqGdBDsB+i+gcE+QQcKf5giRx78VgAYduDqtiMsz/5/SBKfW7f6w0
 BxAqSGjPRrBPbYLPIs4zXczwY0dR6WxEtQPyvBt+gZL9Isw8nJckSQ+2vuN6DkfP2tZg
 KETlzgrp/nqILZkWLJfYN/tGBJt2huAQ4GeXgmGJfbxUXAo0+OIjZDI4elWGN/H4W5T9
 8iTxzBqct6d+IQWzG/Sz8KUbunx1BxohVUTIa3gI2HLNo/P9h4ZyK5zizYhHEXMz/irs
 pi/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726656032; x=1727260832;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/YftGR5akPSnbShux19TfK7C1vu5vMDSi9Y4aNS6h7M=;
 b=LSCymhdS7UxUsTmYKk7LVXfz0RsfWxCwnunOx6OrOtYVbEwoK2NtYYTRIe2Z2T7KY2
 oQQlvcJuQZkz5M5JrWJl7q783Zv9d4Ir5/8IOsXjtzr1bG1VPvhsNcw+tbWdn/1twzZZ
 tFTMTFI9ET4adCt3mkLNo+7Vw/EQWo98EKy8JGkITPHur1nTwjCR8cK7GhuDn+Par9aJ
 nnO7/4jHgzcBw+zcEqS/qwnKyfLmlD+rqL3BsnmtDOkIk/5QT+N4grTNlH+RJzjo8riK
 Spg81ICuyxM2BasGhRLglfqCp6CR/2kj7g50ZXv/IwrQjvUU6M5xyV7sU+pUT0mu8Rlw
 rHqg==
X-Gm-Message-State: AOJu0YxrcRcxj4P8krCH5GzhDF4wU3oHFzKZ2aPT0Mptyc6jyMlu9UJh
 bT15ceF9tzRLG/DuBT0dOkR3Qteg9IMnCZz3msxlfQ6dI6ofyVCy0yhGosHI73Y=
X-Google-Smtp-Source: AGHT+IEn2LELLI7HXj9p8wBYfWzaKUxHpDTdthSTkYaLH72FGxrw+21WLgsbbaxmTYoSnpeXSBb6KA==
X-Received: by 2002:adf:f801:0:b0:374:c1de:5525 with SMTP id
 ffacd0b85a97d-378c2cfecefmr13959231f8f.6.1726656032158; 
 Wed, 18 Sep 2024 03:40:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2782:e782:f1c:dcad?
 ([2a01:e0a:982:cbb0:2782:e782:f1c:dcad])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e780519esm11951749f8f.103.2024.09.18.03.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 03:40:31 -0700 (PDT)
Message-ID: <79c51777-fbe0-4a02-9f81-bd468740ac6b@linaro.org>
Date: Wed, 18 Sep 2024 12:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 00/13] ufs: enhancements to support Qualcomm UFS
 controllers
To: Michal Simek <michal.simek@amd.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>, bmeng.cn@gmail.com,
 "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Bhupesh Sharma <bhupesh.linux@gmail.com>
References: <20240910-topic-ufs-enhancements-v1-0-3ee0bffacc64@linaro.org>
 <bff9ce50-b5a6-45d8-9969-f116d91f75dd@linaro.org>
 <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
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
In-Reply-To: <49932fef-c37a-4736-a2ac-829d5c39081d@amd.com>
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

On 18/09/2024 11:03, Michal Simek wrote:
> Hi Neil,
> 
> On 9/18/24 10:06, Neil Armstrong wrote:
>> Hi Marek, Manorit, Tom, Michal,
>>
>> On 10/09/2024 11:20, Neil Armstrong wrote:
>>> This serie regroups all the fixes and base enhancements required to
>>> support the Qualcomm UFS controllers in U-Boot.
>>>
>>> This syncs headers & defines from Linux, and includes 2 set of
>>> fixes that were sent separately:
>>> - ufs: core: remove link_startup_again logic
>>> - ufs: properly fix cache operations
>>>
>>> Without those 2 sets, UFS cannot initialize on Qualcomm controlers
>>> since v5, and a numerous of Cache issues makes any UFS controller
>>> fail to initialize.
>>>
>>> Since UFS core hasn't changed for a while, and since UFS is core
>>> technology for the Qualcomm SoCs, I volunteer maintaininig the
>>> UFS subsystem if Bhupesh & Neha Malcom Francis are ok with that.
>>
>> Could you run this serie on the r8a779f0_spider, j721s2_evm_a72, j721e_evm_a72,
>> j7200_evm_a72, amd_versal2_virt and qemu-riscv and check for possible regressions ?
>>
>> It seems the only user of UFS_PCI is qemu-riscv, is there other users ?
> 
> 
> Good timing. We are close to send some updates to UFS which we require to get DWC version to work inside U-Boot.
> 
> How far are that core changes from Linux? I see 9/13 is sync with Linux but when this is done you should also say which Linux version was used for sync.

I think we are still quite far from Linux, we just took the basic required bits and pieces
to at least make the Qcom UFS controller driver build work, but Linux driver is overly complicated
with power management code we do not really need in U-Boot, so it's quite hard to sync honestly.

But the plan is to align as much as possible once we get the basic Qcom UFS mainline.

> 
> I see that there are definitely some kernel-doc issues
> 
> Also s/U-boot/U-Boot/g

Ack, will check

> 
> Venkatesh: Can you please look at this patch series and validate it on our platform? Also make sense to send our changes to make sure that they won't break others.
> 
> Thanks,
> Michal

Thanks,
Neil

