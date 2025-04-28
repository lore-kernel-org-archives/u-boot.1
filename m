Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E254C369D9
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E565C82145;
	Mon, 28 Apr 2025 19:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RUKAG6Pg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49F7582A31; Mon, 28 Apr 2025 15:53:45 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7121C82A31
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 15:53:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf257158fso27605815e9.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745848420; x=1746453220; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDiJCXHlO6jcf1IUS55c+Ue/lMn6tZ3wQgziSdyLlNE=;
 b=RUKAG6PgTD8cUq23Fr63B/2UfKYddH5Z+vnTUNVvulynmV3kvdYAwXD66uODo2hsQI
 2pc5lXXI/+ZZvIkl2EuyYgPOvaSAqNZcM83YL432L+t0ErIcwDdRYanGeII6+mACMTXu
 ohf+c+SQWmChQJr85fOOs/F/20KsHmX8+/aNx8widTuY0FUdEeJK3HtxzpWnVsFTUj4R
 yh9cviSnvly3FXYbnGWjJ2vHZ9FPHdTSRwhW4jMpS25MZv9o7P9dcZG5NQGGT02L7Y8C
 2H+Xa7r+vLq6x22mBJ2lonqmbBlYBR6gXAzEinWnOp9rPuk1XzqWJtpf/7E+p6PCZQcP
 WSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745848420; x=1746453220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDiJCXHlO6jcf1IUS55c+Ue/lMn6tZ3wQgziSdyLlNE=;
 b=v52ZQS7ng9/hfa6FmdLS+dhlAcwAhqhyDea5Gl2GJXOw2EeW587eSbcRdq4tOdQix+
 /NlYD/rUoK0kq27NfyADYDoS/uG9V6zWm/RQvlLSK8aQuqQS47MfSVZzvpqMi4i7P7fP
 NnBDLKwzDy+rZv9vMK9cgcD5KjGx7bR1bUAdXSTDZHwDv48cXVciE77j0Ocb3JNQdqCT
 VrdLR+uuRaqdDgimmoBvkKWeREhsLOMfK22tLlUUC0Ya2RiiUfD4r4f0Dz9iia7bQsbq
 xKSFrDcVxLz/CAf6RnF8aBzZKl71AZ+qNSuMhMIr8573XuaDsYFG1JNJVAoNJKrCNkxw
 bhYQ==
X-Gm-Message-State: AOJu0YwJsamf0EdGV1auzSql1JSCLT2TEuYBCfFvM70HFTvaXcIT5G1N
 Ti0A1EKjE+AgsXaZSj15KM718siHL7Fs5DerXflqL7rPz9AlQDgZWkOHucGOjCVhX1G7WLkN1Ps
 vlQg=
X-Gm-Gg: ASbGncvz0jG/niB4QZBygUoGxPayhApVDIg8zb5iIuHMxhcJ4u4VJmXGKkJQNyGXlSU
 MYAaM/lCNnKZZCOT9+J5tlbsWQQpE8ZOki1yFsScNeIEIxhXBkg1bgCjEGq/+6wJ0me+6GxICEw
 t1+Z5Hs1i/2cmhe+FV6c/rM4FIKvnjNs46YsdWU3NnBwogHnZqA9iVd9GsOQQyxfd0VrBqJXNrt
 3X+NBP/vYmnL7rl/+FRb0Yc2B5MBtuqSR7EV9mXvNfsofHxALIjsGFXAn+i6KSM4hLnRocE7rdI
 VrfHctbiIpUsYd927HxdT21Tpq1p7eT68bDeo593m0jfcptB1HuklzgCiKioSsnjClB4dCU=
X-Google-Smtp-Source: AGHT+IErgTmN9JX69AmpAeDCNZ4BwqhoHfhIg2Q/N58tPWwxypLhZvhpnyXtDiG5uMH0JumUjVtSTw==
X-Received: by 2002:a05:600c:4e47:b0:43c:f513:9591 with SMTP id
 5b1f17b1804b1-440ab7be06dmr91101585e9.14.1745848419820; 
 Mon, 28 Apr 2025 06:53:39 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A78.versanet.de. [94.134.58.120])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d29b990sm162284925e9.4.2025.04.28.06.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 06:53:38 -0700 (PDT)
Message-ID: <dfe2c6d1-1935-4af3-b7d2-b04fdcbe6f29@linaro.org>
Date: Mon, 28 Apr 2025 15:53:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] u-boot chain-loading LineageOS bootimg
To: gchan9527@gmail.com, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250427-android-boot-v1-0-bb6b37c9c9f1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:10:31 +0200
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi George,

Thanks a lot for the series, it's super exciting to see support for 
booting Android on top of U-Boot :D

On 4/27/25 13:25, George Chan via B4 Relay wrote:
> This is a series of patches to enable chainloading LineageOS on qcom SOC.
> 
> First patch is to workaround kernel/ramdisk invalid addr by identify
> its physical memory address out-of-range. Since qcom SOC usually have
> 0x80000000 as start/base/real memory address but androidboot img
> specified to around 0x0. If other vendor bootloader behave similar then
> this patch can also workaround it as well.

I'm curious to know what values are there, tbh I think U-Boot should 
entirely ignore the values in the boot image but I guess that could 
break some other platforms.

How about adding a config option CONFIG_ANDROID_BOOTIMG_IGNORE_ADDRS and 
just ORing it in all the places that have checks like 
"img_data->kernel_addr == 0". Then you can enable this for 
mach-snapdragon by selecting it in the ARCH_SNAPDRAGON config definition.

> 
> Second patch is enable bootmeth-android to have chance for extra mem block.
> Usually the fastboot mem block, to hold androidboot img, and loadaddr for
> unzipped kernel. If other SOC have extra mem block available but
> fastboot block, we can add extra logic to take care of it.

There is a small hack in mach-snapdragon that we put kernel_addr_r and 
loadaddr at the same address to avoid using up too much memory on 
devices that only have 1GB which explains this crash because we try to 
decompress the kernel to the same address it got loaded too.

I think we can get away with giving loadaddr its own allocation of 64M 
or so, maybe 96. This would make your second patch redundant (and feels 
like the right fix to me)

> 
> Third patch is optional to enable snapdragon board to have extra cmdline
> found from original bootloader that is required for LineageOS boot init.
> An alternate method is to put the append string into a dummy device-tree
> file, as /chosen/bootarg ofnode porperty, that also contain msm-id. Then
> encapsulate as androidboot img and let u-boot as kernel binary. Below is
> an example for Xiaomi Miatoll device.

I assume you're chainloading U-Boot on this device? If so, isn't it 
enough to just copy the boot args that ABL gives us and maybe tweak a few?

I'd also rather keep this constrained, maybe an android specific board 
callback to set boot args (if there isn't one already) and have the FDT 
fixup code be alongside some other generic FDT fixup stuff. I'd rather 
not have this stuff in board specific code.

I hope this makes sense, feel free to ask for clarifications on anything.

Thanks and kind regards,

> 
> /dts-v1/;
> 
> / {
>          qcom,msm-id = <443 0x0>;
>          qcom,board-id = <0 0>,
> 			<0x10022 1>,
> 			<0x20022 1>,
> 			<0x30022 1>,
> 			<0x40022 1>,
> 			<0x50022 1>;
> 
>          #address-cells = <2>;
>          #size-cells = <2>;
> 
>          memory {
>                  ddr_device_type = <0x07>;
>                  /* We expect the bootloader to fill in the size */
>                  reg = <0 0 0 0>;
>          };
> 
> 	chosen {
> 		bootargs = "";
> 	};
> };
> 
> Signed-off-by: George Chan <gchan9527@gmail.com>
> ---
> George Chan (3):
>        boot/image-android.c: Workaround androidboot kernel/ramdisk addr
>        boot/bootmeth-android.c: Reuse fastboot memory block for unzip kernel
>        mach-snapdragon: Add support to append string to kernel cmdline
> 
>   arch/arm/mach-snapdragon/Kconfig | 11 +++++
>   arch/arm/mach-snapdragon/board.c | 97 ++++++++++++++++++++++++++++++++++++++++
>   boot/bootmeth_android.c          | 12 +++++
>   boot/image-android.c             | 10 +++++
>   4 files changed, 130 insertions(+)
> ---
> base-commit: 5a0a93a768487e55ebe50a34cc90d751bf99cc56
> change-id: 20250427-android-boot-ecbb768cda72
> 
> Best regards,
-- 
Casey (she/they)

