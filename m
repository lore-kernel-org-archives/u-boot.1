Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBA7C3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F83881F69;
	Thu,  3 Apr 2025 19:19:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eAkeweQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AF8D81FEE; Thu,  3 Apr 2025 19:19:00 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DB181F44
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:18:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso996233276.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743700737; x=1744305537; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AC+O9fTano3Ew7jIRVhFV3xEAo2UCJQ2o+7u2UlZZSA=;
 b=eAkeweQOyNgSwWiAYpxL9t2Ue53g3z+ED8TWfvi57oJ4yvKsueW37g3ZTtpt58ijOj
 7bFXGPzBJbz8qglSpZoyZKCWfoaR6yVvY6YM9QOr681jaLsCmiUovLSPxvwp6Wbp/1la
 Z1wuD9XnfotwnCSmlCNGzexPCMRAcdcJlyhRLLGDCcICWK2n1A54gnYbO9ntXQP5h2mM
 DWANvonTsHyeZY3DJXGbAaKOqg5cQPDyh7oqgsSHvRLi1GO5cRTucxZCqUL/snF8onS6
 gugDu4oB2DEbJwH1qC/1KcYBb4i4kSnq4FKdwahFCoa5q3kDC+tFYBZrBT2pAz8VarHl
 UVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743700737; x=1744305537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AC+O9fTano3Ew7jIRVhFV3xEAo2UCJQ2o+7u2UlZZSA=;
 b=X2nuSvzToZSs6dngx7XRPusjF0XjtQsQlSaXLEZnNqfPzWOUVA8hef6/MtVvb2OeQj
 W1ss9nBDdS3wi/1AxCdEeBuf5cjvdHUY/glqc0LpVxJNShFmGmpP9aa8sOsDx0gdrG9n
 ZSXxgE4WGCjX/G1mwV+3x3NhZyp0LXZaBcjImgr096jNaBrqqWWaRM92Kz+I+t46i6Vl
 rSVlKyFTAAKNn6Nm2VzjAZgPM+U3gGlKZXfWyURxSjYs6fA0tyFt5N3qViAmYaUXzDST
 d1izzH+iGwlEH8yzdKRj/6SPCcgy/3Z2EmE7UuCkHJCKbuTkaF/yJ0iKONSwXZJm57SQ
 clIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoTZy7bbq7d+HbYqrl6wxOpQhB5EtNw0Tbn1QnXLXNWxYvc8iU0fq3JTB8fdt978zIT9By7e4=@lists.denx.de
X-Gm-Message-State: AOJu0YxXG/zXzdlxLcRIzBR1QPwTNw1hCylSZDI3y4Rxlc6580nvd9Im
 FRTms8cN6LbXcepGsOdAIGtSKe6bv41z3Zcry3tmMP4BHMpJFa+wUceg2BVt0IvuHas+vKi4Ghv
 p67JV+Yj59gwFneAjQyAxbKfF8Un0lb9rGQhnJw==
X-Gm-Gg: ASbGncuvj+IqvwudxjcPEWe8qLJ35mG6yEZ1SK1mmcCX3Ynufr/K9wseXq+GAQPqKAB
 3dxsoWe3hT3Em7rrpOiR078lUYfPAnTysVQ2VkNed34R0hWbwcXEZ1tFTcecLLaY4bdpYM5d3bk
 GYeSFQsbTndbYddDrd8FI1r537
X-Google-Smtp-Source: AGHT+IGbU7FO9H7IXZvfHIdzagrA3LXly3nGem9B5aL2I5nI2T68NdR5JkgbmkME8FP/QAM7Re0PCTt8ZyXrttgA+lE=
X-Received: by 2002:a05:6902:490f:b0:e69:1efc:9e9f with SMTP id
 3f1490d57ef6-e6e1c2ced8bmr480651276.11.1743700736999; Thu, 03 Apr 2025
 10:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250403144753.1065007-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250403144753.1065007-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 3 Apr 2025 20:18:21 +0300
X-Gm-Features: AQ5f1Joqd9NBFis_1jVTFVF1Uc-awnhUSJ3yR6n8kgYf0MJG2fJW-y6W8likhm0
Message-ID: <CAC_iWjJjnM0XB8yv72pzQ_=YSXDyjDcn8W-EFfPE7-Z4szy3wQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] configs: qemu-arm raise CONFIG_NR_DRAM_BANKS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Thanks Heinrich

On Thu, 3 Apr 2025 at 17:48, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The number of memory banks in QEMU is not bounded by 1.
>
> In this example we have two banks:
>
>     qemu-system-aarch64 \
>     -machine virt \
>     -nographic \
>     -cpu cortex-a72 \
>     -m 8G \
>     -smp 8,sockets=2,cores=4,threads=1 \
>     -object memory-backend-ram,id=mem0,size=4G \
>     -numa node,cpus=0-3,memdev=mem0 \
>     -object memory-backend-ram,id=mem1,size=4G \
>     -numa node,cpus=4-7,memdev=mem1 \
>     -bios u-boot.bin
>
> Use the default value defined in /Kconfig as 4.
>
> Suggested-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Adding a suggested by from Sughosh as well since he helped figuring this out

Suggested-by: Sughosh Ganu <sughosh.ganu@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


> ---
> v2:
>         correct title %s/riscv/arm/
> ---
>  configs/qemu_arm64_defconfig | 1 -
>  configs/qemu_arm_defconfig   | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 03028c76acc..6c9d2505a69 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -3,7 +3,6 @@ CONFIG_POSITION_INDEPENDENT=y
>  CONFIG_ARCH_QEMU=y
>  CONFIG_SYS_MALLOC_LEN=0x1000000
>  CONFIG_BLOBLIST_SIZE_RELOC=0x2000
> -CONFIG_NR_DRAM_BANKS=1
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
>  CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_SECT_SIZE=0x40000
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index e09f54e0685..2d642f86ba6 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -3,7 +3,6 @@ CONFIG_ARM_SMCCC=y
>  CONFIG_ARCH_QEMU=y
>  CONFIG_SYS_MALLOC_LEN=0x1000000
>  CONFIG_BLOBLIST_SIZE_RELOC=0x2000
> -CONFIG_NR_DRAM_BANKS=1
>  CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x40200000
>  CONFIG_ENV_SIZE=0x40000
>  CONFIG_ENV_SECT_SIZE=0x40000
> --
> 2.48.1
>
