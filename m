Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCB5C28B2E
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 20:52:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47469805D7;
	Wed, 12 Mar 2025 21:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="OcTXenju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C78B80756; Wed, 12 Mar 2025 21:52:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A5068003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 21:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2C4363F298
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 20:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1741812759;
 bh=nec5nG8Rs2Gug+Jl9tOHLDkbhU4kfnXMzP7FELm3Ff0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=OcTXenjuvl3TUk0OkaBztdoDqZlYcCPe2YLGIRllwujq/XU1EnFKsI+u4ZfOkTmhx
 cv7U3Jj871R6APEmka6DhwMK2qVGnODH5OVOqd2XL8sGSajBlSSjl9YbSeDV+M8ZNZ
 JyX8hp2SjdIa98stIsBErzVdTbv/ZCiLAYTlgQmowFhqlZOkVsrrmG0ks+/yfHRHaz
 uvOuHbSL/W4rfIUGe7+GGs4dBmRJX33fjXkWh9uGsSvVIx3bwN0RcvTEnV/BermkT7
 5U4KxddxN6VHai4dTH1bXHaLGlxXIpfxz3imURHRVfS1gES7Cg/JCmhIniq072dHaf
 wk/VfVbFvpKlQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131851046so106359f8f.0
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 13:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741812759; x=1742417559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nec5nG8Rs2Gug+Jl9tOHLDkbhU4kfnXMzP7FELm3Ff0=;
 b=b+C5lEVFtEZb3km4X/SE/6VXeM/NY4WkAFOlj4Ujt3laNzI6mgobSA4FG9t7HLwH4d
 SOACePm8jF+pAvNqDlsCDiRdGB/17Q3Q9mLyZEiLhPYHCf7/Sisk7OXK97mFoebxAyIy
 W9C+WLh5vUvFud78gbG88AwJ+EhpcF4o5rqPCdTT0L5wYKP/SlwbGH1k3bDP0drMp5SO
 JL7ERb1H65cYeKSh/GA4WAKeZdNRVNzx+Ik1F+bokTgKLhVzOZdXS+LsOvjioe8mixRO
 aKZQcyG3wm569i3nbsDb9/K2Kykzx30mGmv+vCz6IZDC3RW9saSFgqoCLcAWw3lrQt2K
 oOGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh1DnMJlgEVienG5VzCfPxHuUA64UesVEGIvBIE7FLmApC/YWxLFiVIMZVWa/AJIUXedQpcOo=@lists.denx.de
X-Gm-Message-State: AOJu0Yw7OiSsn/DwjL+dG7lkaAXt5oAvBu0TSx7Z0ipz8AM4MDmzTZYt
 Kg7hyGRESnzoKBSSu+j3zU4CyqJRkAH+G+c3kfFVUBWUJvSvIPsWJPU9XRWi/XcoZIhaJ2HXAol
 dfFbIyDX++JZXiVMmMSi2pg8FXkNQhvOB7bBItZ3Yj8gnAdXVyQOqtaUzbvmVI0fVQow=
X-Gm-Gg: ASbGnctQMDvmQQsDKSyCdoW2IVWZvb4ZIZRdIuvIJGCZbHgYe+EknUFcEN0yZR71AQx
 U+JBYr6vmB7s8dqkvwrsUsHgGCIoFuySzAqq0HI1mKlAof8Jlux1fNn7TptqkMvsSI4XVt9uXAE
 rXzfLDFK+UjFURc2PnQZpufKz+fuiZyQYIBBVo2T9E036gUVoUOlgIpgVoJXff5qSAKiQYZZvHy
 tocqoSuStQCXg5GGgA7nmOGr60nEowfecy5DeeTo6GwKxCjdw488xtu2iRaCocKLsbhY0yciJcx
 OlC8MFI/L0PsYss2M6JV6hMx2uNLyboQB0aXkHpSbYY///cWDXEhYsaHywaEqQpE9C2LMQfNVZ0
 RjwYmSg==
X-Received: by 2002:adf:cb83:0:b0:391:23de:b19a with SMTP id
 ffacd0b85a97d-39132d57a26mr14566855f8f.31.1741812758738; 
 Wed, 12 Mar 2025 13:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQrJYTD7b+YvzpNw7eG54IatXPM9EoIzJuqoENdaCZHSDTextfLaL0sOFwL57ouOYfD5Bs0w==
X-Received: by 2002:adf:cb83:0:b0:391:23de:b19a with SMTP id
 ffacd0b85a97d-39132d57a26mr14566840f8f.31.1741812758327; 
 Wed, 12 Mar 2025 13:52:38 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:345b:e644:8505:68cc:d761?
 ([2a02:3035:6e0:345b:e644:8505:68cc:d761])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c015c2csm21591704f8f.49.2025.03.12.13.52.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 13:52:36 -0700 (PDT)
Message-ID: <60a1eccb-e4a1-4e38-b0d8-2e1693cb9abb@canonical.com>
Date: Wed, 12 Mar 2025 21:52:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/8] efi_loader: preserve installer images in pmem
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, u-boot@lists.denx.de
References: <20250312085424.1201148-1-sughosh.ganu@linaro.org>
 <20250312085424.1201148-6-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250312085424.1201148-6-sughosh.ganu@linaro.org>
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

On 12.03.25 09:54, Sughosh Ganu wrote:
> From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> One of the problems OS installers face, when running in EFI, is that
> the mounted ISO after calling ExitBootServices goes away. For some
> distros this is a problem since they rely on finding some core packages
> before continuing the installation. Distros have works around this --
> e.g Fedora has a special kernel command line parameter called
> inst.stage2 [0].

The patch is about RAM disks and not about installers.

> 
> ACPI has NFIT and NVDIMM support to provide ramdisks to the OS, but we
> don't have anything in place for DTs. Linux and device trees have support
> for persistent memory devices.
> 
> It's worth noting that for linux to instantiate the /dev/pmemX device,
> the memory described in the pmem node has to be omitted from the EFI
> memory map we hand over to the OS if ZONE_DEVICES and SPARSEMEM is
> enabled. With those enabled the pmem driver ends up calling
> devm_memremap_pages() instead of devm_memremap(). The latter works
> whether the memory is omitted or marked as reserved, but mapping pages
> only works if the memory is omitted.
> 
> On top of that, depending on how the kernel is configured, that memory
> area must be page aligned or 2MB aligned. PowerPC is an exception here
> and requires 16MB alignment, but since we don't have EFI support for
> it, limit the alignment to 2MB.
> 
> Ensure that the ISO image is 2MB aligned and remove the region
> occupied by the image from the EFI memory map.
> 
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V7: None
> 
>   lib/efi_loader/efi_bootmgr.c | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> index c6124c590d9..081eff057f4 100644
> --- a/lib/efi_loader/efi_bootmgr.c
> +++ b/lib/efi_loader/efi_bootmgr.c
> @@ -18,6 +18,8 @@
>   #include <efi_loader.h>
>   #include <efi_variable.h>
>   #include <asm/unaligned.h>
> +#include <linux/kernel.h>
> +#include <linux/sizes.h>
>   
>   static const struct efi_boot_services *bs;
>   static const struct efi_runtime_services *rs;
> @@ -362,13 +364,16 @@ static efi_status_t prepare_loaded_image(u16 *label, ulong addr, ulong size,
>   	}
>   
>   	/*
> -	 * TODO: expose the ramdisk to OS.
> -	 * Need to pass the ramdisk information by the architecture-specific
> -	 * methods such as 'pmem' device-tree node.
> +	 * Linux supports 'pmem' which allows OS installers to find, reclaim

If the RAM disk contains is used by an installer is irrelevant here.
If it is a data disk used by an OS the same patch is needed.

> +	 * the mounted images and continue the installation since the contents
> +	 * of the pmem region are treated as local media.
> +	 *
> +	 * The memory regions used for it needs to be carved out of the EFI
> +	 * memory map.
>   	 */
> -	ret = efi_add_memory_map(addr, size, EFI_RESERVED_MEMORY_TYPE);
> +	ret = efi_remove_memory_map(addr, size, EFI_CONVENTIONAL_MEMORY);
>   	if (ret != EFI_SUCCESS) {
> -		log_err("Memory reservation failed\n");
> +		log_err("Failed to reserve memory\n");
>   		goto err;
>   	}
>   
> @@ -490,6 +495,13 @@ static efi_status_t try_load_from_uri_path(struct efi_device_path_uri *uridp,
>   		ret = EFI_INVALID_PARAMETER;
>   		goto err;
>   	}
> +	/*
> +	 * Depending on the kernel configuration, pmem memory area must be page
> +	 * aligned or 2MB aligned. PowerPC is an exception here and requires

%s/pmem memory area/pmem memory areas/

%s/MB/MiB/

Best regards

Heinrich

> +	 * 16MB alignment, but since we don't have EFI support for it, limit
> +	 * the alignment to 2MB.
> +	 */
> +	image_size = ALIGN(image_size, SZ_2M);
>   
>   	/*
>   	 * If the file extension is ".iso" or ".img", mount it and try to load

