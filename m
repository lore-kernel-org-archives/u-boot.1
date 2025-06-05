Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE4FC5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 20:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 607748091A;
	Thu,  5 Jun 2025 22:57:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QMwXnTdt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F39581E25; Thu,  5 Jun 2025 22:57:03 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99E1A80050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 22:57:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso1009912f8f.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 13:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749157020; x=1749761820; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=/ORrgJb0n4BR3EZiqZsyjAYU7wjvjal66253yYuQ//I=;
 b=QMwXnTdthNjxAiq3rWlraM1TJyVQ/ZeAXcfPCgtMhvh+rJSKkI/t5tgS9AKmzcUEli
 3mVNTuhN4o77Lb+fr3RZ5mO3BscyqZUuBR19eU4PBXdiiqCEidXd3CsrTwWxBVR75RSr
 0799iiCt6Dz3wCrAebMZhJ3IqzsjTSx6Qt1U86aOBUb7XObta1Yg6C5F2pvmRjZvtPv8
 SAGsZ1XhVMp1hYe6/l/iWLw+Ce4BTJ/HPlvYaLXqZeJ7Fr80rX5DbXP7pOipQUgvdjS8
 Qls4257W0+aJyCPYWAl5XkeW73AW9WvfmW61HV5n/3KSfVeopBTebhHE1r7DuyVoZXLu
 R9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749157020; x=1749761820;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/ORrgJb0n4BR3EZiqZsyjAYU7wjvjal66253yYuQ//I=;
 b=fTKhVlY6gRq7LOQnfN4TZ16k9u9zxiyMTQV33jRqQOm4Um637eUs39oJRqsG/ssNxv
 tX3yRgypTrFNpPGi8j4vUdvwvpqubdF+OXZeoudtBGnZSjqRzP9BqkqY7byXaT9R96BM
 UifpatouvV27Y8ekGza6maheq3t3oTf5C7aOgy4QoZ2ymxjzyXr1/3L7A1CkXmUZFmZx
 mZV2QLjI02hh739392lvOGSDMeT/jok9PDb6dLhlVwgnygq/9VSpq8zVWxPCF6mxrx1E
 AkSOZ33UXO/2c1Gx8qVV0Oa+oAxsF3DxandOjgYX5pyANHQuHWTa/lIM9Ug1eJFkYX2s
 r8VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfBO+kjMpfIG5lrTNL3RxoqbyzYriPL70qEN28HGwYspU8L+eyseKicKsjgmDvDNaSQKTYPk4=@lists.denx.de
X-Gm-Message-State: AOJu0YxzIEakr7UUS0wl72OLiQHIbO4GxbO0YGyHEziF6ChmN3RY7X9T
 9j5F8xkWf+BKF+81cgnHw4QvkeZ1Htq+m1Gvtwztw63fyxXDMZAi+AFecRyYYXLry9M=
X-Gm-Gg: ASbGncvE+W4kTLaOy6CMBPrJS+p2vcwkwUuwNl1AVCMX7n0avgbTfWPjGbE0Q39Ubho
 vfp+fkY+B4u8QFXZVE7NkaMhtFkWeHbOUV4HvvLtSmI3GSNM3JDft9HMbYsllXFyynEZbxl6pOj
 3c5qk57R0xd4Jgu3uBHOsOvlWUXJPfgKgx0op/yB6fQBR7FaV6w42/xylnjbZ1Az8iz7RbNoTaq
 E0GTye6jcNowaTI7JKiRDgoI8UU48iqdtUyjfdG2UqEAuZShLhi4VEveON44F2qw5HdLe4hefn/
 NS0bHNy7UpUCICm6SxnSpcmqzsOP5GjJrLIb3IUO3TeMwcldwHyU+VoypkrSaUH457xqS+J/g5a
 g7Eu0HWfCqm8lUwADmKBLmFjx5mIS
X-Google-Smtp-Source: AGHT+IEPSI60qu6dYKec3UDtOYIjbUcd76KvO9wlM3yY0QxjsJZoDShiOzO+dBlg+9/M+ZmdOaJizw==
X-Received: by 2002:a05:6000:2913:b0:3a4:e8c4:7a78 with SMTP id
 ffacd0b85a97d-3a531cf542bmr503620f8f.52.1749157019931; 
 Thu, 05 Jun 2025 13:56:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a613:826b:6813:c968?
 ([2a01:e0a:3d9:2080:a613:826b:6813:c968])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53244f0cbsm181009f8f.81.2025.06.05.13.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 13:56:59 -0700 (PDT)
Message-ID: <db594851-3e08-420a-a8d2-291eabe64a98@linaro.org>
Date: Thu, 5 Jun 2025 22:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
To: Tom Rini <trini@konsulko.com>
Cc: Martin Schwan <m.schwan@phytec.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
 <5621cd82-042a-48be-a708-a29ea96d4f7b@linaro.org>
 <20250605200238.GE1382132@bill-the-cat>
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
In-Reply-To: <20250605200238.GE1382132@bill-the-cat>
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

On 05/06/2025 22:02, Tom Rini wrote:
> On Thu, Jun 05, 2025 at 07:46:54PM +0200, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 04/06/2025 14:15, Martin Schwan wrote:
>>> This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
>>> Auto Update Controller) is a lightweight update client, providing "Safe
>>> and Secure OTA Updates for Embedded Linux". See the following links for
>>> more information about RAUC:
>>>
>>>     https://rauc.io/
>>>     https://rauc.readthedocs.io/en/latest/
>>>
>>> PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
>>> default way of updating embedded devices based on PHYTEC hardware. So
>>> far, the logic selecting the correct partitions and files to boot was
>>> being implemented in the U-Boot environment. While this is a
>>> straightforward way to do it, adding and supporting new platforms became
>>> somewhat tedious and is platform-specific. The introduction of U-Boot's
>>> "Standard Boot" provided a convincing alternative, promising a simpler
>>> and more portable way of booting, even for RAUC systems. This led me to
>>> implement a new bootmeth supporting RAUC A/B systems. Note, that this
>>> new bootmeth is not proprietary to PHYTEC products and is designed to
>>> work on other hardware with a RAUC A/B system, too.
>>>
>>> The bootmeth currently only supports symmetric A/B partitioning layouts.
>>> E.g. A/rescue is not (yet) supported. The partition indexes and default
>>> slot tries can be specified via configuration options.
>>>
>>> For now, the bootmeth_rauc uses a similar approach for loading the
>>> Kernel and device tree as the bootmeth_script, in that it requires a FIT
>>> containing a U-Boot script loading the desired distro. It could be
>>> possible to support booting without a script and load the Kernel and DT
>>> directly with this bootmeth, but I found the script method to be very
>>> flexible for now, in letting the distro decide what to load.
>>>
>>> The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
>>> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].
>>>
>>> Supported boot devices are currently only MMC devices, but it should be
>>> possible to add SPI flashes in the future.
>>
>> It's quite a late comment, but this implementation has really nothing
>> specific to do with MMC, you could just support any block device.
>>
>> So if you could just add a config selecting the block type, defaulting
>> to mmc, this could be used on any block like USB, UFS, NVMe, ... with
>> almost 0 changes.
> 
> I raised this with v1. The challenge is that RAUC itself doesn't yet
> support non-MMC options. If/when that changes it's easy to update here.
> 

Ack thx, indeed the code change would be minimal

Neil
