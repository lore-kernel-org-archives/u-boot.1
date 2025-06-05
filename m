Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F52C5B543
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 17:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB0D48091A;
	Thu,  5 Jun 2025 19:46:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xxk6ghG1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6704381E25; Thu,  5 Jun 2025 19:46:59 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B841A803DF
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 19:46:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso837860f8f.0
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749145616; x=1749750416; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BPwcItpqbGkZ1UZtZXLn0RYgwL/aZjMBrGYwm9Q1geA=;
 b=xxk6ghG1OsUoRPqKSKK9ZnfTzN1EAL1qb4uRcytYW3dmOZ7dANq9dOCt9rFtgGjvJr
 L9bvT0qPivhjsVl1kIjzD32LUZf74CC+5ZSEPphytEfYQkCpaQzri9SklI4HiJeNQ37e
 ZwnKCZXS1C1Tvc+dHjFW5ZTNEA8SWUI96v/YA9MwDSsa/yEFZoGnrYA55Vj4wjhjKcGz
 sGkseIc03O2Tj6iCMcWUex1PXvb/dGfJkgdWZtLSiOEDljd7P8CAB3kKDIIriY+fGXEE
 pxo9N5fz3aj0J9gc7+Pxgaa4uEPE5VBonUrm4BEn55PxoTgzS7REkxEqLQC0L0dm4dsm
 oa0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749145616; x=1749750416;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BPwcItpqbGkZ1UZtZXLn0RYgwL/aZjMBrGYwm9Q1geA=;
 b=L6QuNnAUlcfAplNNPD7+7UVejEdADWkbhuZVx+b43B9rK7AIygpSl4OZqh5F+QLtET
 QBpWPu1/xdR1Mgh2Kq/qJZ5iAhO+QGiletny1bD2f+Y/weQLDmsgchirHlHZyqVtbCQ3
 t1ivh+eDTUOAXLMyAr+YfV+YK0pheoRb8MPGPsF6Y3h32csPqxjYXb1h8+/vWjhbhtuE
 z/+0AFqKdPJLxUYvS7OLhYRpRKQ1vv44R8waqIuo11YLHna6YH855aQtvk7t4GVFQUsR
 CfRBStbt7ZZz28GVyTFn2SBF7A2Oa4+zoxx3jWeNI0GYhpFQFX2bbq8gSJIrGt6s1hvv
 TBag==
X-Gm-Message-State: AOJu0YzOGQ1fcV5+cYWOT635ev+mhGxxHR5kJvX3IStzsI6xeCDi6qls
 cy6FMHd87JPo9aXCgJqCmv8aoP+QllYW1rD9rbjGpXpRzEyO5a2OiPqk164LQndoiC0=
X-Gm-Gg: ASbGnctBSExKIHQ/l4QOjGFrLKZe9HTJvV+o3afEaRE/8dyHSQl8rOXFhzgoAC/C2d6
 FtasttyeV0Ff8FAn0UiQl6G0BLtRCbK1atjXoORBBe1tTEGr4ONoGGn3KgkTxH/gL9EK4ykYdeN
 FXVXUZMYeu4GTNvE9d4iHH9jER7iLaZ6bfgmSt0RxI8HC4GN717dtgwNH81HNCLf0PrtO8NukK2
 2F7DyyGfPGlVPxKUzBeM4k7uJivCDbXeACTgpIR2Ht4VvbZAOUWj3zhJgZscA8TmUJvRfYtH3bk
 3YEp1zdRofLt1nSVfpi3oiOIYuP8aQuvmTTaoHQZNzZycRIapRAPpeN+at6MzcN4LSvChLfbxNY
 Kh2lbxMIc6tth6r4TZyto0vvcW9yYgIvIh6flbDU=
X-Google-Smtp-Source: AGHT+IFsC/2XYrch6DMdW5bQuyKSLT7ija0V4ZWEbc0eWVdrNzTwN8be01p0ssRxR5Efa5GT4fIZPw==
X-Received: by 2002:a05:6000:40d9:b0:3a4:dbdf:7140 with SMTP id
 ffacd0b85a97d-3a51d9673aemr7056248f8f.49.1749145615995; 
 Thu, 05 Jun 2025 10:46:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:a613:826b:6813:c968?
 ([2a01:e0a:3d9:2080:a613:826b:6813:c968])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe5b871sm25504385f8f.13.2025.06.05.10.46.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 10:46:55 -0700 (PDT)
Message-ID: <5621cd82-042a-48be-a708-a29ea96d4f7b@linaro.org>
Date: Thu, 5 Jun 2025 19:46:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
To: Martin Schwan <m.schwan@phytec.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
References: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
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
In-Reply-To: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
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

Hi,

On 04/06/2025 14:15, Martin Schwan wrote:
> This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
> Auto Update Controller) is a lightweight update client, providing "Safe
> and Secure OTA Updates for Embedded Linux". See the following links for
> more information about RAUC:
> 
>    https://rauc.io/
>    https://rauc.readthedocs.io/en/latest/
> 
> PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
> default way of updating embedded devices based on PHYTEC hardware. So
> far, the logic selecting the correct partitions and files to boot was
> being implemented in the U-Boot environment. While this is a
> straightforward way to do it, adding and supporting new platforms became
> somewhat tedious and is platform-specific. The introduction of U-Boot's
> "Standard Boot" provided a convincing alternative, promising a simpler
> and more portable way of booting, even for RAUC systems. This led me to
> implement a new bootmeth supporting RAUC A/B systems. Note, that this
> new bootmeth is not proprietary to PHYTEC products and is designed to
> work on other hardware with a RAUC A/B system, too.
> 
> The bootmeth currently only supports symmetric A/B partitioning layouts.
> E.g. A/rescue is not (yet) supported. The partition indexes and default
> slot tries can be specified via configuration options.
> 
> For now, the bootmeth_rauc uses a similar approach for loading the
> Kernel and device tree as the bootmeth_script, in that it requires a FIT
> containing a U-Boot script loading the desired distro. It could be
> possible to support booting without a script and load the Kernel and DT
> directly with this bootmeth, but I found the script method to be very
> flexible for now, in letting the distro decide what to load.
> 
> The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
> BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].
> 
> Supported boot devices are currently only MMC devices, but it should be
> possible to add SPI flashes in the future.

It's quite a late comment, but this implementation has really nothing
specific to do with MMC, you could just support any block device.

So if you could just add a config selecting the block type, defaulting
to mmc, this could be used on any block like USB, UFS, NVMe, ... with
almost 0 changes.

Thanks,
Neil

> 
> To test this patch stack with PHYTEC's phyBOARD-Pollux i.MX8M Plus
> board, you need to adjust the boot files to include the boot.scr.uimg
> containing the distro's boot script and set "optargs" to "${raucargs}"
> in it. Also disable any legacyboot in the U-Boot environment and simply
> boot with Standard Boot:
> 
>    bootmeth order rauc
>    bootflow scan -lb
> 
> Regards,
> Martin
> 
> [1]: https://www.phytec.eu/en/produkte/single-board-computer/phyboard-pollux/
> [2]: https://download.phytec.de/Software/Linux/BSP-Yocto-i.MX8MP/BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2/
> 
> ---
> Changes in v3:
> - Invert if-statement check for setting default value of BOOT_*_LEFT env
>    variables. This would falsely trigger an error message before.
> - Link to v2: https://lore.kernel.org/r/20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de
> 
> Changes in v2:
> - Remove LOG_DEBUG from boot/bootmeth_rauc.c
> - Reorder asm/cache.h include to be last
> - Do not check for RAUC-specific files in the rootfs anymore. This does
>    not work on encrypted root filesystems and is not a stable indicator
>    for a functioning RAUC system.
> - Add a description of the term "slot" in the corresponding private
>    struct.
> - Remove boot tries left from struct distro_rauc_slot. The boot tries
>    are read directly from the environment, as that's the only correct
>    source RAUC is relying on.
> - Remove the current boot_order from struct distro_rauc_priv, for the
>    same reason as above (env is correct source).
> - Add function for retrieving a slot struct, to ease finding the right
>    one when e.g. iterating or getting by name.
> - Fix multiline comments.
> - Fix various if-statements which were explicitly comparing to 0 or
>    NULL.
> - Free various, temporary instances of allocated string lists.
> - Set default env values for BOOT_ORDER and associated BOOT_*_LEFT
>    variables. These variables are mandatory for RAUC to work.
> - Use calloc() instead of malloc() for allocating the private slots.
> - Use config options for configuring the partitions and default boot
>    order, instead of setting them via the U-Boot env.
> - Use bootstd_get_prefixes()'s return value and check all available
>    prefixes for the boot script.
> - Add a proper boot order selection logic for the rauc bootmeth, similar
>    to the previous environment scripting, with fallbacks and slot try
>    checks.
> - Introduce config option for resetting all slot tries in case they are
>    all zero. This may prevent a system from locking up in the bootloader.
> - Rename env variable "mmcroot" to "distro_rootpart", to be in line with
>    "distro_bootpart".
> - Change the bootmeth flag to "global", as the rauc bootmeth does not
>    work for individual partitions.
> - Update documentation accordingly.
> - Link to v1: https://lore.kernel.org/r/20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de
> 
> ---
> Martin Schwan (2):
>        bootstd: Add implementation for bootmeth rauc
>        doc: Add description for bootmeth rauc
> 
>   boot/Kconfig                     |  51 +++++
>   boot/Makefile                    |   1 +
>   boot/bootmeth_rauc.c             | 432 +++++++++++++++++++++++++++++++++++++++
>   doc/develop/bootstd/index.rst    |   1 +
>   doc/develop/bootstd/overview.rst |   1 +
>   doc/develop/bootstd/rauc.rst     |  56 +++++
>   6 files changed, 542 insertions(+)
> ---
> base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
> change-id: 20250129-wip-bootmeth-rauc-03b5e2dd88f4
> 
> Best regards,

