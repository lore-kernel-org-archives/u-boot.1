Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED7BC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 08:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707198091A;
	Thu,  5 Jun 2025 10:14:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PzHUvfDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B16381E25; Thu,  5 Jun 2025 10:14:52 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFC1C80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 10:14:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a3771c0f8cso369863f8f.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 01:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749111289; x=1749716089; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=I1+LqLV/YQJSQU1rB/WNwBClGQG32iWpxc/+U8bfn6s=;
 b=PzHUvfDbeY+e2BkiOXD0rqXp9L0OoVXK2lA0XVT3JZKPjxhTTMj5R7UUkoW5UDjOQR
 2EoQotjoNP4xWlD1tWaNfoQP6ARG/2dQsw3qwbH9aFfvf0AJzFtRdtcTOAk9SqbXAX9C
 SjMvwLo0XZA9ITIsLhCW6csix3V68cC/NSO3k3YD3RexVgWX3WmitKgEpAWPDRo00XZx
 d6Y6S67IfFBoMRv3Pe7yBYq6+1kTiCQnjRTG9+sHRC4UYPamweDFfM6mUFngBhv6vpvM
 Bn3ASdJVmAIqJ5ZfCueeHbU/jEbpe8HfvJB7TDOWE8CA9uCqn9h/E17KTbXYgfpt21Vf
 wqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749111289; x=1749716089;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=I1+LqLV/YQJSQU1rB/WNwBClGQG32iWpxc/+U8bfn6s=;
 b=OBrAc/uRcvF2yq8VVRCVu/TYMyqpfNkS6G+BeUS5eiwKMoN0C74b8sUXy+EXHokAN5
 o/Yx51AWcucGbUAB1RWd+yk+fVSvL8gQwf2UwdpJSKYSbNN2pyfcVREOaaitukRczQgj
 Futq1rGWmhvgswCJRS5kPMHYnh++L1aJqsTr5FhFT2Nf+tzJ0RUsmZDj+RArtI962vkP
 Br7F+UjHh8AYdkDufMN/C2ONQ2EE8YrhnTiu9pT/8FZI78/1AXi7mFPU05UaukdL1kyw
 TQc65eR903O7LN1MLm2Suv4dhvzfvnLj7C8z2NRhN/31Bnsd8K7nw6BHQSHrRjosyZhg
 BENQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnjoSdZ+XFxWSgC99KtpXU2WPKJFNBcdX8dFZ9PkA2VyLQP9unXmfV6w+JtbKc9roSiPBpeCA=@lists.denx.de
X-Gm-Message-State: AOJu0Yypm3AV31jVq/NpnAr7asi0vA7BLubYNnc3lP8Zwe8uyDvJhBBR
 8ICUVnyD14kUP4XkNIfEQPiYDG7wvzu2FmTZdBW2ZfjHAgNTmPGjV6oorU4oVnqBn84=
X-Gm-Gg: ASbGncs4ZZ+65L5Q+gXOJLThFkIANh02pB/zzR+VS6IA6oBPXEOTBazPl+CGo1V70/n
 aSOObwR/OhoAHIOnGNkMOtNFOmamD2OCSAv/TPfLEWEvjr0m93Shbfdu8MBqpnZ1q5YzZq87xE7
 SUHy2enWvfgPOtfUai9+VdJ/kCJM3hp660eH+rotRo9HfRfTG+5ivK0n6T/9AXNVM0MABN/O8cg
 3q4uuqnqaR3BNRJmTiIYeISroilk40PN02j4H1BL90PbuGIquU21c1RPDH0OMMPD1NMnYgilTKC
 ml53ds21h1uLlRyfL+Gi9i9mt/LxY0j9BIpf+dXnZc0mfs23TRVM+4lmHPD03o+MoywCs02TPgm
 2XNT0DAhye0ulmmhZS4kRk/ZO4mSx
X-Google-Smtp-Source: AGHT+IGin1wiFbMdawSerzKYzLaDb7NvceuiGdZvPzYlVVOKKdYnAO5Ww7+hJBlE7YvqOoVLkot5eg==
X-Received: by 2002:a05:6000:40d9:b0:3a4:ee3f:8e1e with SMTP id
 ffacd0b85a97d-3a51d97bd12mr5178379f8f.39.1749111289189; 
 Thu, 05 Jun 2025 01:14:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd?
 ([2a01:e0a:3d9:2080:53e5:f2b3:9ac1:62cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb207e02sm9982185e9.25.2025.06.05.01.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:14:48 -0700 (PDT)
Message-ID: <edf32bcf-c004-44c3-9ee8-868ca73937f1@linaro.org>
Date: Thu, 5 Jun 2025 10:14:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFT v4 2/3] fastboot: blk: switch emmc to use the block
 helpers
To: Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de,
 Dmitrii Merkurev <dimorinny@google.com>
References: <20250522-topic-fastboot-blk-v4-0-af7f7f30564d@linaro.org>
 <20250522-topic-fastboot-blk-v4-2-af7f7f30564d@linaro.org>
 <20250522143512.GI100073@bill-the-cat>
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
In-Reply-To: <20250522143512.GI100073@bill-the-cat>
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

On 22/05/2025 16:35, Tom Rini wrote:
> On Thu, May 22, 2025 at 02:37:06PM +0200, Neil Armstrong wrote:
>> From: Dmitrii Merkurev <dimorinny@google.com>
>>
>> Switch the mmc backend to this new shared block helpers,
>> reducing block logic and only leaving MMC specific logic.
>>
>> Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/fastboot/Kconfig  |   4 +-
>>   drivers/fastboot/Makefile |   3 +-
>>   drivers/fastboot/fb_mmc.c | 210 +++-------------------------------------------
>>   3 files changed, 16 insertions(+), 201 deletions(-)
>>
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 70207573de2bd0d56b4b7fa6f7e17fdc5803ba15..33825ee408fbd9aff26cd390a140421c7c98ecc3 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -91,7 +91,7 @@ config FASTBOOT_USB_DEV
>>   config FASTBOOT_FLASH
>>   	bool "Enable FASTBOOT FLASH command"
>>   	default y if ARCH_SUNXI || ARCH_ROCKCHIP
>> -	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>> +	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>>   	select IMAGE_SPARSE
>>   	help
>>   	  The fastboot protocol includes a "flash" command for writing
>> @@ -113,7 +113,7 @@ choice
>>   
>>   config FASTBOOT_FLASH_MMC
>>   	bool "FASTBOOT on MMC"
>> -	depends on MMC
>> +	depends on MMC && BLK
>>   
>>   config FASTBOOT_FLASH_NAND
>>   	bool "FASTBOOT on NAND"
> 
> OK, this logic is odd. For a little while now at least, MMC select's
> BLK. So neither of these are needed. And I bet the first hunk is what
> causes the issue of some platform getting stuck at a prompt when
> configuring in CI because it enabled FASTBOOT, enables BLK, but did not
> enable FASTBOOT_FLASH before now.
> 

Right, will drop then

Neil
