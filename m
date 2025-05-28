Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC92DC5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 11:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DFA983A79;
	Wed, 28 May 2025 13:12:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qcznh+5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301E483A7F; Wed, 28 May 2025 13:12:21 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E94839A7
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 13:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so874863066b.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748430737; x=1749035537; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yGLBJjrGkZVcLCd/GZUuIohbvxvfMMBZnBB7e9GBgPc=;
 b=qcznh+5NwLxSFYHzK6JWNm69CC1wedPlJktKBBfOmRgEACDlH3si6bEuL0ZeWcWXqj
 Kq5s+O6SLL9lWuojZL39whyJ2HeIY5ymMH/bdMxmsG6MRP2aAdNczBAinB/HFkTRFENj
 3EPVTB4ADcNTWP0qtz9etDjh5bW+JuskJz2adZhviU//MhYbxeDk9YlBgkae/MyuZycf
 3YflV26Q9I191fJX9YpdPgFUgBrQoz5N6CQDIeVyVsZMeGW51pHvUTWqG2AzApquMB/8
 xac7/ZKHrjAyP92KkD4XjHYfk4MEGzI6GoLc26COITaE/muJOIHo7k+DMHbUIY6J04rs
 18Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748430737; x=1749035537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGLBJjrGkZVcLCd/GZUuIohbvxvfMMBZnBB7e9GBgPc=;
 b=Y8Q9jdMq8P5dBpbZxo1SYWnlaVBA2hbv/L4pi0+yXdNJjGx5o2whRTl5qqNO9Wj3/U
 XEl0oqZZ2jnbLOORM+kb+E7f1ecGJNt6lwV2HPNkdK7c+wXMhz2cbe860GWtVd/EaP1a
 Ga4WK72pf9+41ewvkdYJOL7FKZjNF+wsqrWNK2fN8prtcdJsf5ZUpnEzk3zJHJDLlE2b
 AbEmx42nylZzNHJuAC0/Qm+ueATfslg9GpDf26ZfrNl5PrRn6c0qRYNMYQbBJsXKHa3p
 iMg1BJ8LZn08XktEAe6HeXOw6rBiZMGak6H2v58LQwZ3nw+OxSnIUoZ6rF66pjvezaTj
 VAAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcfNQ3Z6ESXR4nxEHXItkByo+MnA59slahjhRsUmNYrHSFnY2hvd0Mk5eTiTEY3oJ6Jcgas/s=@lists.denx.de
X-Gm-Message-State: AOJu0YzHyobCS6RJqeuwLjmg46Nvrpl0Ws+H/FWCbaVhIlMzJp1rz6+l
 HxXfumIOlIGH2QdTdi/vEGU/YVT4ZzYyI7Qa7Vl6hsnwyMB/MsJjUJ0NPl4e8aczl3GaI604tnB
 jQffI
X-Gm-Gg: ASbGncvknYpP/SyV9/KHd0iNdOa7FeZJViTpRguNa3k0nNMoxFC4FJ+MaCMsgAVaaGQ
 qQYeqg53zMzyY9UhtvoO34rYHubE+He1DOUcnfQ5Z+cCbn91jukEi65jKYL/fdFNLoCJ11Q2mLC
 pJCJJkvpS+PVZgEVkPzdegrr9EiD2C2OsMtPJw5eZqsTv94sG+mvzTESyRdKxIluKoRwN77KTqc
 B121swCWVDG+epa1H/PF8q1Opq5R60VPP8bQVFaeUj8k4KYgn7lRw3KDr6g4B/hEcjQNkRFtbzG
 9r8DOeBMkH9hpPuXftLXJb3DkOuBeNhRXPH78K9cOodmEMsRKofd3U5K8VxrdkRKoNyH5SPjwBE
 tdTqUk2cAu4wWs+eO8Mio4NpAgCp2aai1JLwC
X-Google-Smtp-Source: AGHT+IFp2c0pTEznqj+VoIu/2m+A6HksLqDTvM7faNzjdNHuNoXO2NVv9rDrNsDtiRWe9lmsKb9YdA==
X-Received: by 2002:a17:906:d542:b0:ad8:a4a8:1034 with SMTP id
 a640c23a62f3a-ad8a4a8118cmr96250566b.8.1748430736883; 
 Wed, 28 May 2025 04:12:16 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:7b9d:1015:16d5:5c7e?
 ([2a01:170:117e:fc:7b9d:1015:16d5:5c7e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8a1b5ca28sm91109366b.172.2025.05.28.04.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 May 2025 04:12:16 -0700 (PDT)
Message-ID: <d5865822-79d6-4266-96cb-a864c3fb2a60@linaro.org>
Date: Wed, 28 May 2025 13:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] x86: efi: Various app improvements to support
 bootstd
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>
References: <20250528082520.152391-1-sjg@chromium.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250528082520.152391-1-sjg@chromium.org>
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

 > base-commit: 42c99ae5bebcecc7b734865c8077c4bf9275e78a

$ git branch --all --contains 42c99ae5bebcecc7b734865c8077c4bf9275e78a
   remotes/sjg/HEAD -> sjg/master
   remotes/sjg/master
   remotes/sjg/appc

So just totally ignoring the exact same feedback again... Why are these 
patches on the list? These patches don't belong on the list.

On 5/28/25 10:24, Simon Glass wrote:
> This series makes a number of improvements to the EFI app. Mostly it
> applies to x86 but the ARM version will share some improvements.
> 
> The main updates are:
> - Improve linker scripts and options to detect missing symbols and
>    remove unused code
> - Enable bootstd and provide a default which can find an extlinux OS on
>    EFI media
> - Make the 32/64-bit apps more similar in terms of features and link
>    script
> 
> 
> Simon Glass (27):
>    scripts: Tidy up build-qemu a little
>    scripts: Change -k and -o options
>    scripts: Update build-efi to support kvm
>    scripts: Update build-efi to support booting an OS
>    scripts: Update build-efi to allow showing the QEMU cmdline
>    scripts: Update build-efi to support passing a root disk
>    scripts: Update build-efi to support debugging with QEMU
>    scripts: Update build-efi to allow firmware settings
>    bootstd: Tidy up help for boot flags
>    bootstd: Provide an option to scan any partition
>    vbe: Avoid accessing TEXT_BASE if undefined
>    efi: Use the correct driver for TPM
>    efi: Allow disabling networking in the app
>    efi: Rename the media device
>    efi: Allow disabling the TPM in the app
>    efi: doc: Use inline links for EFI app documentation
>    efi: Add a bootdev for EFI media
>    efi: Provide an easy way to debug with gdb
>    x86: efi: Sync up the two link scripts somewhat
>    x86: efi: Tidy up the link scripts
>    x86: efi: Add a few dummy functions
>    x86: efi: Avoid calling arch_setup_gd() from jump_to_copy()
>    x86: efi: Drop relocate and physmem
>    x86: efi: Enable --gc-sections to drop unused code
>    x86: efi: Drop some unused options
>    x86: efi: Enable bootstd
>    x86: efi: Add various useful options
> 
>   arch/x86/config.mk                 |  2 +-
>   arch/x86/lib/Makefile              |  3 ++
>   arch/x86/lib/elf_ia32_efi.lds      | 29 ++++++------
>   arch/x86/lib/elf_x86_64_efi.lds    | 30 +++++-------
>   boot/vbe_common.c                  |  2 +-
>   cmd/bootflow.c                     | 10 +++-
>   common/board_f.c                   |  2 +-
>   configs/efi-x86_app32_defconfig    | 26 +++++------
>   configs/efi-x86_app64_defconfig    | 24 ++++------
>   doc/develop/uefi/u-boot_on_efi.rst | 48 +++++++++++++++++---
>   doc/usage/cmd/bootflow.rst         | 15 +++---
>   drivers/block/efi-media-uclass.c   |  2 +-
>   drivers/block/efi_blk.c            | 30 ++++++++++++
>   lib/efi_client/Kconfig             | 12 ++++-
>   lib/efi_client/efi.c               | 36 +++++++++++++++
>   lib/efi_client/efi_app.c           | 10 ++++
>   lib/efi_client/efi_app_init.c      | 18 +++++---
>   scripts/build-efi                  | 73 +++++++++++++++++++++++++++---
>   scripts/build-qemu                 | 20 ++++----
>   19 files changed, 292 insertions(+), 100 deletions(-)
> 

-- 
Casey (she/they)

