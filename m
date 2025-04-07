Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542A6C3601E
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 14:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB727810EB;
	Mon,  7 Apr 2025 16:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RdWsFWyj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA7698215B; Mon,  7 Apr 2025 16:25:32 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93756810EA
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 16:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so30497545e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744035930; x=1744640730; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cSA3E1h0pjdXO+pLH6bXLLWLMOgc9vEYT+mjUt68AKE=;
 b=RdWsFWyjs1wllLKma4wRjcO9FwATGJm/VR8/ewIfuVFKy8HvFTbaZCJpgLZHVADJ3m
 P3SCzOJO0HDnJd+tBUwSraYgur/AFMaoAxo8DDs5EZeWkAuOV1XpZxt5jCLasZvRGnll
 TSidpfduJc1B/zE+c8i9bAzBvpIyIeBjKnRv2QhWBaA/Gdaf3gM/exos0tbOYcPgaYwz
 8VWKdpJIx879enR/IPr60xJ4JE0o131RsCUZMvcEBo6CHUQVzBkKZd9sAiYURrd+i32j
 0iARGIcj7LKhk+XZ+flFrs2U8/ff7ECsEHN0gs091/MLBTRbqBLvShyLwc8aYVQ2137E
 V0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035930; x=1744640730;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cSA3E1h0pjdXO+pLH6bXLLWLMOgc9vEYT+mjUt68AKE=;
 b=QJQh6ay92UM9tMkdbTRC0ZKiR4OIR8LfGGjNCAlfS/Y3aXpfHbxz9Bv/4h1h6OS6Xs
 No1lnYyBOyCrt+AlCMSZuAyPADCREl0ZNNN8u34A/sksy6MosMmRz7aL7vl4fSFpqHzJ
 2G1tKI3gVhq1jHmAwFkHB+NTBdmkO1C3QMsYYzxhEzZyesp2CboCnrVIjTWYszQuqFGC
 R6+x7nIJRKb0ARaF1zFRoA2spxMxbWXhSjE6HsyUWb+WGLXWfN910WqIPlPKO2vrEfZo
 C9qThhOxep/mANyUl7q1vQj3a6jLCPZc6ylwMiDUuTG3nERWodInXrnqM4HEMybzVuhA
 CKMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWQChlZFyuayM3R2MoFcXhPCIWqXOKzRjcIfAG0/n1eka8nhlB90kMSXcCzCRkBAxB3NZXQoM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9ufUA/6OGp/qJeUpXG4O7T6NyENRYrMCYtiiePX1dTmbdHyKK
 mLR8WQD1nNL4cTTEB/kgSp3Y12rToZHNIul3I6xS6BOIvSgJ1B4CKkSH5MrmB2o=
X-Gm-Gg: ASbGncs+17woXC7KLUYnqiSrvGjKXCHDtOnDyA1A2KDUPZD5f5hrU8DnqLrcKq4Fz7X
 SyNhOq9F/Nyr0NNu/1KrjwdYUPB8cpa2C0+9P4aNfkenB49EqwLEnMjgOuR6pf0z9Pdg34fyJ5B
 6kdI/EhbuMmgMj0sGX1oC3sZRS8u38F92DnddVJBFjyw4YJ1u4QKQZymS9XLLwdxDpUuFobWn0P
 e4fSNVXGsaUQD7MJ9oW6JfoSmtWUwVbKoyZgvXzFTzLXcSb4COTkRFb9zV6HbSlmrVWlUIP35We
 F4ePy8pwXBmRjTO8Qy4qkwjtWK8ZdjW6gGt9fBfZdHxmeK8r2z8XysQyaclXJClPkEM+bk8Cyo2
 JngZCdYm/lTQ=
X-Google-Smtp-Source: AGHT+IESj3HnP72ptsAW+eYkghkXSlwvd1tBzi4yHIDL8VQI1LW1LTT9tOqHe30iOXiMUnefP6SDRg==
X-Received: by 2002:a05:600c:1e13:b0:439:8c80:6af4 with SMTP id
 5b1f17b1804b1-43ecf8d0b48mr116522805e9.19.1744035929831; 
 Mon, 07 Apr 2025 07:25:29 -0700 (PDT)
Received: from [192.168.1.47] (212-60-142-46.pool.kielnet.net. [46.142.60.212])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a6c89sm12119836f8f.28.2025.04.07.07.25.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 07:25:28 -0700 (PDT)
Message-ID: <74855492-37dc-4281-b088-5ad6e6a15aba@linaro.org>
Date: Mon, 7 Apr 2025 16:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] board: qualcomm: dragonboard820c: udpate readme
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
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



On 4/7/25 14:05, Jorge Ramirez-Ortiz wrote:
> Update build instructions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>> ---
>   board/qualcomm/dragonboard820c/readme.txt | 47 ++++++++++-------------
>   1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard820c/readme.txt b/board/qualcomm/dragonboard820c/readme.txt
> index 966e9520e85..a01d24122cb 100644
> --- a/board/qualcomm/dragonboard820c/readme.txt
> +++ b/board/qualcomm/dragonboard820c/readme.txt
> @@ -16,10 +16,7 @@
>                        Build & Run instructions
>   ================================================================================
>   
> -1) Install mkbootimg and dtbTool from Codeaurora:
> -
> -   git://codeaurora.org/quic/kernel/skales
> -   commit 8492547e404e969262d9070dee9bdd15668bb70f worked for me.
> +1) Install mkbootimg
>   
>   2) Setup CROSS_COMPILE to aarch64 compiler or if you use ccache just do
>      CROSS_COMPILE="ccache aarch64-linux-gnu-"
> @@ -33,15 +30,15 @@
>   
>      $ touch rd
>   
> -5) Generate qualcomm device tree table with dtbTool
> +5) Append the dtb to the u-boot binary discarding the internal dtb.
>   
> -   $ dtbTool -o dt.img arch/arm/dts
> +   $ gzip u-boot-nodtb.bin
> +   $ cat u-boot.dtb >> u-boot-nodtb.bin.gz
>   
>   6) Generate Android boot image with mkbootimg:
>   
> -   $ mkbootimg --kernel=u-boot-dtb.bin             \
> +   $ mkbootimg --kernel=u-boot-nodtb.bin.gz          \
>                  --output=u-boot.img                 \
> -               --dt=dt.img                         \
>                  --pagesize 4096                     \
>                  --base 0x80000000                   \
>                  --ramdisk=rd                        \
> @@ -251,44 +248,42 @@ Wait for 5 seconds before proceeding
>   [5300] booting linux @ 0x80080000, ramdisk @ 0x82200000 (0), tags/device tree @ 0x82000000
>   [5310] Jumping to kernel via monitor
>   
> -U-Boot 2017.11-00145-ge895117 (Nov 29 2017 - 10:04:06 +0100)
> +U-Boot 2025.04-rc5-00020-g40a61ca0e7eb-dirty (Apr 07 2025 - 09:37:03 +0200)
>   Qualcomm-DragonBoard 820C
>   
> -DRAM:  3 GiB
> -PSCI:  v1.0
> -MMC:   sdhci@74a4900: 0
> +DRAM:  3.5 GiB (effective 3 GiB)
> +Core:  136 devices, 18 uclasses, devicetree: board
> +MMC:   Bulk clocks not available (-19), trying core clock
> +mmc@74a4900: 0
> +Loading Environment from EXT4... OK
>   In:    serial@75b0000
>   Out:   serial@75b0000
>   Err:   serial@75b0000
> -Net:   Net Initialization Skipped
> -No ethernet found.
> +Net:   No ethernet found.
>   Hit any key to stop autoboot:  0
>   switch to partitions #0, OK
>   mmc0 is current device
>   Scanning mmc 0:1...
>   Found /extlinux/extlinux.conf
>   Retrieving file: /extlinux/extlinux.conf
> -433 bytes read in 71 ms (5.9 KiB/s)
>   1:      nfs root
> -
> +Enter choice: 1:        nfs root
>   Retrieving file: /uImage
> -19397184 bytes read in 2024 ms (9.1 MiB/s)
> -append: root=/dev/nfs rw nfsroot=192.168.1.2:/db820c/rootfs,v3,tcp rootwait ip=dhcp consoleblank=0 console=tty0 console=ttyMSM0,115200n8 earlyprintk earlycon=msm_serial_dm,0x75b0000 androidboot.bootdevice=624000.ufshc androidboot.verifiedbootstate=orange androidboot.ver0
> -
> +append: root=/dev/nfs rw nfsroot=192.168.1.6:/home/jramirez/Src/qualcomm-lt/db820c/rootfs,v3,tcp rootwait ip=dhcp consoleblank=0 console=tty0 console=ttyMSM0,115200n8 earlyprintk earlyco0
>   Retrieving file: /apq8096-db820c.dtb
> -38134 bytes read in 37 ms (1005.9 KiB/s)
> -
> -## Booting kernel from Legacy Image at 95000000 ...
> +## Booting kernel from Legacy Image at 155000000 ...
>      Image Name:   Dragonboard820c
>      Image Type:   AArch64 Linux Kernel Image (uncompressed)
>      Data Size:    19397120 Bytes = 18.5 MiB
>      Load Address: 80080000
>      Entry Point:  80080000
>      Verifying Checksum ... OK
> -## Flattened Device Tree blob at 93000000
> -   Booting using the fdt blob at 0x93000000
> -   Loading Kernel Image ... OK
> -   Using Device Tree in place at 0000000093000000, end 000000009300c4f5
> +## Flattened Device Tree blob at 148600000
> +   Booting using the fdt blob at 0x148600000
> +Working FDT set to 148600000
> +   Loading Kernel Image to 80080000
> +   Using Device Tree in place at 0000000148600000, end 000000014860c4f5
> +Working FDT set to 148600000
>   
>   Starting kernel ...
>   

-- 
Caleb (they/them)

