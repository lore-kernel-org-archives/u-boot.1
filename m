Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B0EF8FA80
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 14:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEC4083E36;
	Tue, 21 Apr 2026 16:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="UvcWXvQw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F5E83FFA; Tue, 21 Apr 2026 16:26:33 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10EB183BC4
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 16:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43d70c30767so3086440f8f.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 07:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776781590; x=1777386390; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0V3f4Ow52Vw8H1WwQhAQ0mGK5PpEhEryVwOuVU2M03I=;
 b=UvcWXvQwgJ0u/XQMjmQbcn0RwIM89qxt3sxLKRx/JRvtFuJdF/C+gUycKJFNUq8Zmr
 3n3xzHpu2R9N71q9ghGkjeK+RDux/Vz2Tf1+pBsUfiD0ommJTjhkXGK80do3sLm1twY/
 qIbJLgFFYdIazT48yCjkwtB25FtqiD7PRunQBIMK/0vA6ewzWgTBTLF7d54pF0YTsYkq
 ZBc4Rw3erDiW5l/cVll/jvK0OKYXJW3RYafsH01bICR7bSQoAD9eOAVRyzOukiXECng8
 RM1xaXzsx2RXCzUpUWRT1YlNZQi6/yPhcASunpuZi9goMsDuO2lBXHQE3Dx6Z563az68
 8HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776781590; x=1777386390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0V3f4Ow52Vw8H1WwQhAQ0mGK5PpEhEryVwOuVU2M03I=;
 b=ZxNdQpCibCS+mMxApXyr0ndVTgvcqw3wOatH7TGe98nKt40kX+X+B0Cs122Yy87xjt
 UBS/5f6J/1lJXzSlLkxVjT2utGAI7Lk3H++yL3aXi9JIbpYOgp5nPsP0E3JW6zbd3khf
 BYA6OTaC+Rkkg4QW0EVOibsH53iIya7CJ2xdlUVcZ9N/VroFTUR2L88jX8APMGuIzyBn
 3V2vxe60sg9OLGQaY4r9RJstlRk7NY26pHWLbMvELbFeYcIzKz8T0DN528EmcoNOly+n
 /Tr1W6lfcw/8XhLWbmM1rytbS5lyH801RoNOCCi0z9eSI0a5pKZqh1n0/F0aAT4bA8h3
 7L7A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QW1oRw+Hlg3qqo24KwRwKqYKXUWcPns2/kCxmmiW/KmmtEezie1mbkpQMdUkaojtAWMtin7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxWFk5G0NvznHDFbh8V8SEPBqAnvTNaRF4yzGDB6FONaPKrWGz0
 Ik7ZvgTfve2zM0d8Ajf9eNQHbtZBElsxUz1P4wzWLWHiiB3+3BpT2I+EmIW6Yla+7m2r9vfF7AL
 9x2Gv254=
X-Gm-Gg: AeBDiesWmGUAM4zqbo3y2WU5PpPyoeYJUDK4SpjdO/hU1ia52ok9KaoT9fg2N0hfPlz
 neZJqCP5pDRI1uJczB7hLIC12gCyOVxezZNcOkd78gnnJdReJnQXCInrOmdfGRxS8+W0Bi0MCX1
 3HRP44rNetLt8LzRTQ9b6yQ2xg59fjW7jECHl8pS35Kj74gXxsKDVS4nn4quMYaZgymeasn6Fe5
 YsbsbjmvVlv6s/A6KBW0UITFvVDLRHldvf50X9Q5LCESrGZc60lgQKgPCT3Cv3NhuErWsj0UT3q
 TrYdol3BEc18ttgRiDA9V3VMoQJFtvlB+iIPbStTpWq6chjcPdpWfexhTFJZPnep+sdQVrxnXcU
 xwlfJkf0OIUkgmaxVwcoInz8jVu78nqbw65dMfOL8yFjeoDYAHJoG9tXVIh1bH0h4x/fXpg/Z3J
 riDnHwnr1i1pRaoIeU9KACT+M52HHyfzn2wjxNa5yeLXJDUvHxe3kV7x2fJvabZ5nqCFwLMruOA
 cBkSw8hihh7txi9x2EP65R/
X-Received: by 2002:a05:6000:1ac5:b0:43d:73d4:b1a with SMTP id
 ffacd0b85a97d-43fe407c0d8mr29522723f8f.19.1776781590344; 
 Tue, 21 Apr 2026 07:26:30 -0700 (PDT)
Received: from [192.168.1.134] (59.85-85-174.dynamic.clientes.euskaltel.es.
 [85.85.174.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm34891487f8f.32.2026.04.21.07.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Apr 2026 07:26:29 -0700 (PDT)
Message-ID: <a5bd4a1a-dd25-4b7a-8b6d-c9183bd98234@suse.com>
Date: Tue, 21 Apr 2026 16:26:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi_arm64: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20260421141156.359690-1-pbrobinson@gmail.com>
Content-Language: en-GB
From: Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <20260421141156.359690-1-pbrobinson@gmail.com>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 21/04/2026 16:11, Peter Robinson wrote:
> Enable LWIP and HTTPS on the Raspberry Pi arm64 platform to be able to
> use it in the boot process.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   configs/rpi_arm64_defconfig | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> index 69e8e72c5d7..90048a418f6 100644
> --- a/configs/rpi_arm64_defconfig
> +++ b/configs/rpi_arm64_defconfig
> @@ -11,6 +11,7 @@ CONFIG_SYS_LOAD_ADDR=0x1000000
>   CONFIG_PCI=y
>   CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
>   CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
> +CONFIG_EFI_HTTP_BOOT=y
>   CONFIG_BOOTSTD_DEFAULTS=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_FDT_SIMPLEFB=y
> @@ -26,11 +27,13 @@ CONFIG_CMD_GPIO=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_SNTP=y
> +CONFIG_WGET_HTTPS=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_FS_UUID=y
>   CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
>   CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
> -CONFIG_TFTP_TSIZE=y
> +CONFIG_NET_LWIP=y
>   CONFIG_DM_DMA=y
>   CONFIG_DFU_MMC=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
> @@ -64,4 +67,5 @@ CONFIG_SYS_WHITE_ON_BLACK=y
>   CONFIG_VIDEO_BCM2835=y
>   CONFIG_CONSOLE_SCROLL_LINES=10
>   CONFIG_PHYS_TO_BUS=y
> +CONFIG_MBEDTLS_LIB=y
>   # CONFIG_HEXDUMP is not set

