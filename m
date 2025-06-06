Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EA7C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B83081FEE;
	Fri,  6 Jun 2025 11:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JFOoKZx2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FEBE8291D; Fri,  6 Jun 2025 11:23:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8770D803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so24041075e9.1
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 02:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749201836; x=1749806636; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iAoqZ4C67Hen44mn90OD5ZTTaxdFPt9xRfeDjUsqa+Q=;
 b=JFOoKZx2mRu7Ua/kHrByspqdwYfQgUoZQsygs1HIi+r38SKBth/rh1Itz3WCbnz9B0
 6/jjjPd6gc/YGfhhjBo6GIqK8kb4iJzfg5hnEzDvCK/10NGr6+1anF2gE82kBDxT2oOh
 DGcFt+TeCenRAeD+8hh0Sxwb8AHpop5EcxNnfnC39KYsyS3l90LgagbrQGWTzhn7xjEw
 m7GIYJKTBfi/ag1K44NAQrhTJ1p1vg9qeJjb5uFnQhikg44zOz2yBVRs471dXX5zO5T4
 p80pvUetFOZxzm8itAhr2nCVhHNFsS0uSQVWvxet3/QsifwRWcjuS5jaU5Ajl9ZGHyys
 P3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749201836; x=1749806636;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iAoqZ4C67Hen44mn90OD5ZTTaxdFPt9xRfeDjUsqa+Q=;
 b=IaOEWo5yxbbMqX2Flnu0v8PG/C0o7XiBNu9K0xhZMznOBZogQ4suYMJxJgmNfNGdhP
 4+Y859kXi6pq9ZNvH9zoEtrSnNw/PiyQsCqODqmfZuHJnrUFvIbwtLIhbUXD0+6R8zhh
 iYCgOLQHcmtLbscRqf8s7sL3y5wm/cW0Z5UdKMUNSwIaYB6lLwg8QRe4dQdup+VIdmKr
 /M9kU2lbxHwrCFfu4CO8VKzRTj6LrrBHsnYilDV5hyzHFonWZ4SeK+SctUZh6V3k08ke
 +Tk1aMAVN8XVeCc4XEu6aOv38FLqmA1o1rFQgcIHdfFIGiIwWSIjeaRJ3NNAJ8dTb30o
 x8rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ9T5p9/BTmDJyV+njkpkuv3fIQapqyyJeF68HMEPvUzkjFLtbBTCZM+Ne9N0F9bRq43uquAM=@lists.denx.de
X-Gm-Message-State: AOJu0YxgOFEobeKbdk0vMFG/K9QcYXS6pZdDtKXjG3vUJYOLpuCGST3T
 g81IZRv48l6iGngPN34iJZzs+MfDEWQozjObYTe6aXUyq6ev/VWJGWoO9XPtbXi0RYw=
X-Gm-Gg: ASbGncsVmK9CRqfNW8qWWBDadqvJfUmqikgcgHjhq3KBETdVRH1PGkqhNEd+wriXFtB
 2+/9c7XLBZnKtfi5icjXpageTFDscq+nicN0J6+iC57DxdyGENt3bTI74X/Zac7pvnhGDV1xeDf
 X/Yb7tgxvaPfQTDKPm3QlrlaNx/F62NKlU22Ew7Wv9qQt/m4yvT6MDG9R1kQwsdTkgyb8XHuIQ4
 zuZNejdY7mbYWfqVRJYeUuz5njiWtO6L36/hLnNj9WWqOv4Q/nGe/ymu6IRCRU7A1Nek2sK4Kp2
 hN1DiFpW92SshdVqBm7pqjksT1rpq+tE55xF6p5KWbl70XSzigoPQJE8FA8jePE9oYn4hh8HepJ
 FA5UTkkrOJGflU5utwKzunhs=
X-Google-Smtp-Source: AGHT+IF7dbPt8nIWMBii5ETvI3T8b2MgZbqfgUcTd9tUI1mF4vbLLitWvwzj6nbApRxJ9NTtuRGshQ==
X-Received: by 2002:a05:6000:2890:b0:3a5:21a1:c25c with SMTP id
 ffacd0b85a97d-3a531457ca9mr2076937f8f.0.1749201835901; 
 Fri, 06 Jun 2025 02:23:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:6acf:5ad3:d07:470?
 ([2a01:e0a:3d9:2080:6acf:5ad3:d07:470])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4526e158428sm14669355e9.14.2025.06.06.02.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:23:55 -0700 (PDT)
Message-ID: <78f0a868-bc30-4a7b-817e-2e1618d46736@linaro.org>
Date: Fri, 6 Jun 2025 11:23:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v4 3/3] fastboot: integrate block flashing back-end
To: Mattijs Korpershoek <mkorpershoek@redhat.com>,
 Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-3-af7f7f30564d@linaro.org>
 <20250522143958.GJ100073@bill-the-cat>
 <b83cfc3a-39e6-4710-a6ac-c24c878052cc@linaro.org>
 <20250605142126.GV1382132@bill-the-cat>
 <3d86cf5f-028c-4858-b292-5233b7194c60@linaro.org> <877c1ptjvp.fsf@kernel.org>
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
In-Reply-To: <877c1ptjvp.fsf@kernel.org>
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

On 06/06/2025 09:22, Mattijs Korpershoek wrote:
> On jeu., juin 05, 2025 at 19:48, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> On 05/06/2025 16:21, Tom Rini wrote:
>>> On Thu, Jun 05, 2025 at 10:16:54AM +0200, Neil Armstrong wrote:
>>>> On 22/05/2025 16:39, Tom Rini wrote:
>>>>> On Thu, May 22, 2025 at 02:37:07PM +0200, Neil Armstrong wrote:
>>>>>
>>>>>> From: Dmitrii Merkurev <dimorinny@google.com>
>>>>>>
>>>>>> 1. Get partition info/size
>>>>>> 2. Erase partition
>>>>>> 3. Flash partition
>>>>>> 4. BCB
>>>>>>
>>>>>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>>>>>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>>>>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>>> ---
>>>>>>     drivers/fastboot/Kconfig      | 29 +++++++++++++++++++++++++++++
>>>>>>     drivers/fastboot/Makefile     |  1 +
>>>>>>     drivers/fastboot/fb_command.c |  8 ++++++++
>>>>>>     drivers/fastboot/fb_common.c  | 22 ++++++++++++++++++----
>>>>>>     drivers/fastboot/fb_getvar.c  |  8 +++++++-
>>>>>>     5 files changed, 63 insertions(+), 5 deletions(-)
>>>>>
>>>>> I know this was posted before I replied with more feedback moments ago.
>>>>>
>>>>> [snip]
>>>>>> @@ -193,6 +197,31 @@ config FASTBOOT_MMC_USER_NAME
>>>>>>     	  defined here.
>>>>>>     	  The default target name for erasing EMMC_USER is "mmc0".
>>>>>> +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>>>>>> +	string "Define FASTBOOT block interface name"
>>>>>> +	depends on FASTBOOT_FLASH_BLOCK
>>>>>> +	default ""
>>>>>> +	help
>>>>>> +	  The fastboot "flash" and "erase" commands support operations
>>>>>> +	  on any Block device, this should specify the block device name
>>>>>> +	  like ide, scsi, usb, sata, nvme, virtio, blkmap, mtd...
>>>>>> +	  The mmc block device type can be used but most of the features
>>>>>> +	  available in the FASTBOOT_MMC will be missing.
>>>>>> +	  Consider using FASTBOOT_MMC on a MMC block device until all
>>>>>> +	  features are migrated.
>>>>>
>>>>> A default like "" in order to un-stick configs that are now here and
>>>>> enabling the option is wrong. If we're enabling new functionality for
>>>>> platforms, it needs to be configured correctly. This leads to building
>>>>> code on platforms that won't be used on the platform so we've likely
>>>>> added run-time bloat for no benefit.
>>>>
>>>> I agree but what's the solution ? I'll prefer having no default as it was initially.
>>>
>>> No defaults is correct here, yes. It's just that the primary
>>> dependencies need to be fixed so that platforms don't get stuck on the
>>> prompt on features they won't actually use either.
>>>
>>> Seeing what boards get stuck, and then having an idea on what
>>> dependencies trip them up is tricky. What I usually do in this
>>> situation, to see what platform is stuck on the prompt is:
>>> - In one terminal, fire off tools/qconfig -sC. Then wait for it to
>>>     seemingly be stuck with just one or two platforms left to finish
>>>     syncing.
>>> - In another terminal, 'ps uxwwww | grep make' to see what the build
>>>     directory of one of those stuck platforms is, then manually save off
>>>     the .config file, begin investigation.
>>>
>>> That should provide what platform is asking this question and not having
>>> a reasonable answer. Then it's a matter of seeing if it makes sense for
>>> this platform to be here and so just needs to be migrated to this
>>> functionality or if it's here because of some dependency problem, for
>>> example what I was talking about in the previous part of this series.
>>>
>>
>> Ok I can't reproduce the crash with the last version, somehow v4 fixed it,
>> and the changes I did still work:
>> https://source.denx.de/u-boot/custodians/u-boot-ufs/-/pipelines/26523
> 
> Hmm, maybe v4 "fixed" it because we have:
> 
> default 0 for FASTBOOT_FLASH_BLOCK_DEVICE_ID
> 
> If you drop that, do you still not reproduce? (note that we don't care
> as much since we agreed upon using "default 0" for device id, but it's
> odd that the build issue is no longer there.

Yes confirmed I removed the "default 0" and it failed again.

Neil

> 
>>
>> Neil
> 

