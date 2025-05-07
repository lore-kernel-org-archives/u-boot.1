Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B21BC3ABC3
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 11:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88E081F32;
	Wed,  7 May 2025 13:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oeuhRxec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70B6F820EB; Wed,  7 May 2025 13:50:09 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD64E8059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 13:50:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4ac7so3138711f8f.2
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746618606; x=1747223406; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1LnVnCTum3o0nSiR3qftSrc+YWa26FpH15RbvGIzFVA=;
 b=oeuhRxeczWLRXaNXubnzcfMSlNINyuoRpTJ6f6GQIcdEsxYe4z+GhOTld6IDO/ioFL
 ajmpBqnPFhLrHC8D/ggyoY0tLtN/brmkigLR6QRAlHFr8+jUgyn9OZX/5jF1xUWs+CjU
 1QqY6dAD08EbbJupY5KRwtHL6VkLuWLDMDqn03XqefLnDXfdtPy7WaQA526pNC3tdLvP
 Y3hnS/N3QhgOVzTAXcFXOqvwRHwqND8VoA4WsvPyFIkBocWJbFZJ43YumKPgb3Q5brws
 pHBD1ccZt8rgOKQGuY7imYjqbAEHfXQCcin+P7sMEqdWuSrFP0R+lKWS3xQq87Ow40+k
 hCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746618606; x=1747223406;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1LnVnCTum3o0nSiR3qftSrc+YWa26FpH15RbvGIzFVA=;
 b=EmiRGEwdggTRBBGjsqfySQ3WM3+GZvjeysO/iRSZQMh6sLNenko548kByTIv5kkGOw
 o5zRB7ImNuUfi7M0CUk3yaWNp8SmwrBLSNyWWBo+3LuiWz+R3Zh0SC7dVyP0xpKZqWcT
 UEv5ILIqVipJ19TkPUb6RzN69tjJacgk+RUHWj+a8swwJNzYJ527z8cXqqMuzmKFo1sf
 sVljRzMuYuefSxTzCLIDVLJ371gtBVrkSyfB2EiBiO/n2j2BHQpfqWhws7mkk/XPpFK5
 gHZdctfobH33tshLZlk6oQOG7dDoY9kVB0gPVpLpN4Au/+j46hYAfQ1HLGGNWn/uEulq
 0ZYg==
X-Gm-Message-State: AOJu0Yxk1MchhC483vttZwXBd6L7dyRchOzwirxrtuUBmbUnaTf0rAnk
 QYo6ubHMxB9fTYG+OvkrDoEGeePbgVVWXhWOT54rEReZ9JvlMPFRBQ/5VS6mNxE=
X-Gm-Gg: ASbGncsdPXn7x/LWOpYHKU20yWL0aYVp0ujpWaVIH2WnidJHfEPdWUvVTse9HRFcdzq
 C5L8hYIH/t3lb5k5EWjGRW89k6EXNEZl1jYrb9VLa+gnO5VcG3cczZ1QeeR1fyR6kR0szM2afM0
 N0NnyPfoKXq4TWWE4US2f0qe5vOxUdXAYNfFbm2wv7XIlGbsxTG0UNjOgTFPwqZxUSIz7b4+apy
 n9a1B1t4t/d5B3ER5LHTG/fmURTGf5vMp2mRQsrtUky9Denfrdgsjom0A0C8WKYpa04i6+Kl1K7
 bY9BLDbT7ljZx2Or04xjwFr0L0fEXIumpbtClVtGpDFGz9wqNDCiK2eST7ruprZGpLhrJi2fLP/
 D1plM7FE8Jzzj3e4/xA==
X-Google-Smtp-Source: AGHT+IGySIjInTRRPnZEjZ5BWBMM/a8f/z8YRLDJtmRMo0xYi1qx9TAaRA0440ftvVAI3FmUlr2Hag==
X-Received: by 2002:a5d:588e:0:b0:3a0:8492:e493 with SMTP id
 ffacd0b85a97d-3a0b49ae782mr2259267f8f.6.1746618606245; 
 Wed, 07 May 2025 04:50:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:784f:3312:6406:12a9?
 ([2a01:e0a:3d9:2080:784f:3312:6406:12a9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae3ccdsm16854544f8f.38.2025.05.07.04.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 04:50:05 -0700 (PDT)
Message-ID: <361a0089-862f-4535-b489-78cd779e0169@linaro.org>
Date: Wed, 7 May 2025 13:50:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v3 0/3] fastboot: add support for generic block
 flashing
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dmitrii Merkurev <dimorinny@google.com>
References: <20250506-topic-fastboot-blk-v3-0-d94be5829f46@linaro.org>
 <87o6w4agdc.fsf@kernel.org>
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
In-Reply-To: <87o6w4agdc.fsf@kernel.org>
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

On 07/05/2025 12:02, Mattijs Korpershoek wrote:
> Hi Neil,
> 
> Thank you for the series.
> 
> On mar., mai 06, 2025 at 18:10, neil.armstrong@linaro.org wrote:
> 
>> This serie permits using any block device as target
>> for fastboot by moving the generic block logic into
>> a common set of helpers and also use them as generic
>> backend.
>>
>> The erase logic has been extended to support software
>> erase since only 2 block drivers exposes the erase
>> operation.
>>
>> Tests are welcome to make sure this series doesn't
>> introduce any regressions on the emmc backend.
> 
> I've tested the series on khadas-vim3_android_defconfig
> keeping CONFIG_FASTBOOT_FLASH_MMC=y (so with the emmc backend)
> 
> I tested the following:
> # flashing a raw partition with a descriptor:
> $ fastboot flash bootloader u-boot_kvim3_noab.bin
> # flashing a sparse image:
> $ fastboot flash super super.img
> 
> I also testing reflashing the super.img when using the generic block
> layer:
> => fastboot usb 0
> Warning: the fastboot block backend features are limited, consider using the MMC backend
> 
> $ fastboot flash super super.img
> 
> Both work great!
> 
> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Great thanks for testing !!

> 
> I've also opened a issue on gitlab to harmonize the fastboot emmc
> backend with the generic block backend:
> https://source.denx.de/u-boot/custodians/u-boot-dfu/-/issues/6

Nice !

> 
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>> Changes in v3:
>> - Move Kconfig/Makefile changes over the 2 patches
>> - Relicence to GPL2 with Dmitrii approval
>> - Move soft erase in a separate function
>> - Update help text of Kconfig BLOCK entries
>> - Add warning at init if MMC was selected with BLOCK backend
>> - Link to v2: https://lore.kernel.org/r/20250409-topic-fastboot-blk-v2-0-c676f21d414f@linaro.org
>>
>> Changes in v2:
>> - Dropped applied virtio erase patch
>> - Reorganize patches, introducing helpers first, using them in mmc afterwards
>> - Added soft-erase logic
>> - Added move helpers to handle the partitions erase & flash from emmc
>> - Fixed const var on last patch
>> - Link to v1: https://lore.kernel.org/all/20240306185921.1854109-1-dimorinny@google.com/
>>
>> ---
>> Dmitrii Merkurev (3):
>>        fastboot: blk: introduce fastboot block flashing support
>>        fastboot: blk: switch emmc to use the block helpers
>>        fastboot: integrate block flashing back-end
>>
>>   drivers/fastboot/Kconfig      |  28 +++-
>>   drivers/fastboot/Makefile     |   4 +-
>>   drivers/fastboot/fb_block.c   | 323 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/fastboot/fb_command.c |   8 ++
>>   drivers/fastboot/fb_common.c  |  22 ++-
>>   drivers/fastboot/fb_getvar.c  |   8 +-
>>   drivers/fastboot/fb_mmc.c     | 210 ++-------------------------
>>   include/fb_block.h            | 105 ++++++++++++++
>>   8 files changed, 502 insertions(+), 206 deletions(-)
>> ---
>> base-commit: 4d3b5c679bc9d5c6cbbeedcc1e4a186f1cc35541
>> change-id: 20250408-topic-fastboot-blk-c5e14cd59224
>>
>> Best regards,
>> -- 
>> Neil Armstrong <neil.armstrong@linaro.org>

