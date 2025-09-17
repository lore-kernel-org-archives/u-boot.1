Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1937CAC599
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 15:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A2BD8363C;
	Wed, 17 Sep 2025 17:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nU417N9v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E211E83642; Wed, 17 Sep 2025 17:12:11 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CDCF835B3
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 17:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45dfb8e986aso66208875e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758121929; x=1758726729; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdChvcsZurT4aEukC4KzCBEVO4iPeA/eHqHgPAYhQU8=;
 b=nU417N9vBQtdACisR6TvWuxnlxus9XHLD5QeCoCgdQ8zDp7cHHfQCM9YD0oFpM3mju
 i17khtLF3tvyfP1ty54RIcmHB2RVoQ1gKNAg66hxiwfEW9LPE3Rb/84NrciYyY5rDQND
 hREH8mBj8l7ALnsUKqbC7J2vzFxN43ugDcCPfFsrNCoDc3Zd9+VrxJKokgkUztXOZzqO
 wsBAQEYOQBDw9bpFDrph3DF9bflmYa9MzidQjhmUPwxd8zorWGGyhmdHfQbYvMa2Nx9e
 OZmZftdFnw+D4dGeOyXMJ/1hUbCI3Ojgy+cVp7m/+JXQuHYOYSn6T+syqlgvdZCbC8lk
 plqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758121929; x=1758726729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CdChvcsZurT4aEukC4KzCBEVO4iPeA/eHqHgPAYhQU8=;
 b=sgGhDkGgt8IiJeFh7ykqmoSJvJ++AnCbGxUmi9rUjAhbwKBDNeAnlaGgnioYH64Q2l
 joXRiU2xv1EbFNpYLLMC25k39H/AYvAYdwDhG9+tNj9y2DFl0sSY54vtX1g6irw57uor
 9shNHzDzt/oAe9ftRW2W1JsJNy+UGQlT1bEy0bBZSCcPix0ElCdPUQ673zPGjMP5HIMs
 yNccJwUTMm2554L+eXKjevuGjAag1/eIT1LzG8hcgFFepuCKBDttvA4kecgrgq49S+XN
 qQDPiv8BDbshozB6N7rtEWCcZcTBHJsYQLtttRXLoW4wktnhz1m129L/LlUYvPGmHxsT
 UrAA==
X-Gm-Message-State: AOJu0YxoANZY6v35c8I5utka6evlCarJiEuJ+xjIG2GhtvEOX+y1hVsC
 e9mJJabsiohA5JgyMOCUlys28In4sX6mEx/KFHluyRffWYqUYHqZlqJQKDaPKWKeGIc=
X-Gm-Gg: ASbGncuW4Wn6WezsJSa1Z5Lprmcez5NqEPbfLybouCA2+6wm1FKhtvxr/DLv1Z2fOqu
 Pe5ey97mnN9EtMHfNLt/favHQT+z+cdyPaN/4/cuunicyN1j2skv5FHpjaI5Dsa2FO6/X1E1ONI
 tZAji2SZvih0yHvKkQ1KEexCzE50SWaYX59Thv6Ku8M+UXjUhMPcxjBRjvdPJ/+ID1Vm9HSpupY
 7UdaDbqgW+oaYBSj3o5JlPECDqhUFGTdBbQJDC5JL4mittttcZ4VBwWxrGn77DK9QaDb22j7lCq
 yJRcwIfp9oKMcCEwZd7lMy1EJ91Krl2IfaQe5u2obZbS2Z99ZH+1LQf55QqgRsuM8Avi+nleua+
 DP8tXuaMx0dzVFKmvivTolEjbFkx+JMDUAIE21cwOSi/JYV9AB51J4RoBIiPrHfYKoSgUovAumZ
 s=
X-Google-Smtp-Source: AGHT+IF+7sT9T3wfMZ7ShiDJfRx9LFdBPQV+iNqSfj3CyAZfeQcpGowAEUiVPTwIW95n93No8BXAdw==
X-Received: by 2002:a05:600c:b8a:b0:45d:d50d:c0db with SMTP id
 5b1f17b1804b1-46202de09d9mr25537045e9.15.1758121928568; 
 Wed, 17 Sep 2025 08:12:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:377:2351:2ad0:8bdf?
 ([2a01:e0a:3cb:7bb0:377:2351:2ad0:8bdf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ecdab0ce66sm5368570f8f.36.2025.09.17.08.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 08:12:08 -0700 (PDT)
Message-ID: <0bec0b3b-bd14-4b26-99f3-a0df5e652ab5@linaro.org>
Date: Wed, 17 Sep 2025 17:12:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] doc: phytec: imx8m: Style and firmware update
To: Yannic Moog <y.moog@phytec.de>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Teresa Remmet <t.remmet@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Benjamin Hahn <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>,
 Jan Remmet <j.remmet@phytec.de>
References: <20250909-imx8m-optee-enable-v4-0-6dfe494cc939@phytec.de>
 <20250909-imx8m-optee-enable-v4-3-6dfe494cc939@phytec.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250909-imx8m-optee-enable-v4-3-6dfe494cc939@phytec.de>
Content-Type: text/plain; charset=UTF-8
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

Hi Yannic,

On 9/9/25 16:05, Yannic Moog wrote:
> Use single make command for compiling blobs and U-Boot.
> Update the imx firmware version.
> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  doc/board/phytec/imx8mm-phygate-tauri-l.rst | 27 ++++++++++++++---------
>  doc/board/phytec/phycore-imx8mm.rst         | 28 +++++++++++++++---------
>  doc/board/phytec/phycore-imx8mp.rst         | 34 +++++++++++++++++------------
>  3 files changed, 55 insertions(+), 34 deletions(-)
> 
> diff --git a/doc/board/phytec/imx8mm-phygate-tauri-l.rst b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
> index 7efc9392361b4a867ce2bc18db11aacf31208800..4dd82cd9785fa585ed216664a25f593d4e723dbb 100644
> --- a/doc/board/phytec/imx8mm-phygate-tauri-l.rst
> +++ b/doc/board/phytec/imx8mm-phygate-tauri-l.rst
> @@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
>  
>     $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
>     $ cd trusted-firmware-a
> -   $ export CROSS_COMPILE=aarch64-linux-gnu-
> -   $ export IMX_BOOT_UART_BASE=0x30880000
> -   $ make PLAT=imx8mm BL32_BASE=0xbe000000 SPD=opteed bl31
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          PLAT=imx8mm \
> +          IMX_BOOT_UART_BASE=0x30880000 \
> +          BL32_BASE=0xbe000000 \
> +          SPD=opteed \
> +          bl31
>  
>  Build the OP-TEE binary
>  -----------------------
> @@ -32,8 +36,9 @@ Build the OP-TEE binary
>  
>     $ git clone https://github.com/OP-TEE/optee_os.git
>     $ cd optee_os
> -   $ make CFG_TEE_BENCHMARK=n \
> +   $ make -j $(nproc) \
>            CROSS_COMPILE=aarch64-linux-gnu- \
> +          CFG_TEE_BENCHMARK=n \

CFG_TEE_BENCHMARK=n is not needed anymore

>            O=out/arm \
>            PLATFORM=imx-mx8mm_phygate_tauri_l
>  
> @@ -42,9 +47,9 @@ Get the ddr firmware
>  
>  .. code-block:: bash
>  
> -   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.23.bin
> -   $ chmod +x firmware-imx-8.23.bin
> -   $ ./firmware-imx-8.23.bin
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
> +   $ chmod +x firmware-imx-8.28-994fa14.bin
> +   $ ./firmware-imx-8.28-994fa14.bin
>  
>  Build U-Boot for SD card
>  ------------------------
> @@ -56,15 +61,17 @@ Copy binaries
>  
>     $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
>     $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
> -   $ cp firmware-imx-8.23/firmware/ddr/synopsys/lpddr4*.bin .
> +   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
>  
>  Build U-Boot
>  ^^^^^^^^^^^^
>  
>  .. code-block:: bash
>  
> -   $ make imx8mm-phygate-tauri-l_defconfig
> -   $ make flash.bin
> +   $ make -j $(nproc)
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          imx8mm-phygate-tauri-l_defconfig \
> +          flash.bin
>  
>  Flash SD card
>  ^^^^^^^^^^^^^
> diff --git a/doc/board/phytec/phycore-imx8mm.rst b/doc/board/phytec/phycore-imx8mm.rst
> index ba6299a968ae9980d583b87b46dcccba5aa4a186..d5edbc91474e95f677dd12e5fcc6c16092dea1cd 100644
> --- a/doc/board/phytec/phycore-imx8mm.rst
> +++ b/doc/board/phytec/phycore-imx8mm.rst
> @@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
>  
>     $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
>     $ cd trusted-firmware-a
> -   $ export CROSS_COMPILE=aarch64-linux-gnu-
> -   $ export IMX_BOOT_UART_BASE=0x30880000
> -   $ make PLAT=imx8mm BL32_BASE=0x7e000000 SPD=opteed bl31
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          PLAT=imx8mm \
> +          IMX_BOOT_UART_BASE=0x30880000 \
> +          BL32_BASE=0x7e000000 \
> +          SPD=opteed \
> +          bl31
>  
>  Build the OP-TEE binary
>  -----------------------
> @@ -32,8 +36,9 @@ Build the OP-TEE binary
>  
>     $ git clone https://github.com/OP-TEE/optee_os.git
>     $ cd optee_os
> -   $ make CFG_TEE_BENCHMARK=n \
> +   $ make -j $(nproc) \
>            CROSS_COMPILE=aarch64-linux-gnu- \
> +          CFG_TEE_BENCHMARK=n \

Same

>            O=out/arm \
>            PLATFORM=imx-mx8mm_phyboard_polis
>  
> @@ -42,9 +47,9 @@ Get the ddr firmware
>  
>  .. code-block:: bash
>  
> -   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
> -   $ chmod +x firmware-imx-8.19.bin
> -   $ ./firmware-imx-8.19.bin
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
> +   $ chmod +x firmware-imx-8.28-994fa14.bin
> +   $ ./firmware-imx-8.28-994fa14.bin
>  
>  Build U-Boot for SD card
>  ------------------------
> @@ -55,15 +60,18 @@ Copy binaries
>  .. code-block:: bash
>  
>     $ cp <TF-A dir>/build/imx8mm/release/bl31.bin .
> -   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
> +   $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
> +   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
>  
>  Build U-Boot
>  ^^^^^^^^^^^^
>  
>  .. code-block:: bash
>  
> -   $ make phycore-imx8mm_defconfig
> -   $ make flash.bin
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          phycore-imx8mm_defconfig \
> +          flash.bin
>  
>  Flash SD card
>  ^^^^^^^^^^^^^
> diff --git a/doc/board/phytec/phycore-imx8mp.rst b/doc/board/phytec/phycore-imx8mp.rst
> index df087072062a0b8ca2179fecaead4fa3d0b9eff4..0252cbd08249fa37e979e13bb5ffac9c2b7bb723 100644
> --- a/doc/board/phytec/phycore-imx8mp.rst
> +++ b/doc/board/phytec/phycore-imx8mp.rst
> @@ -3,7 +3,7 @@
>  phyCORE-i.MX 8M Plus
>  ====================
>  
> -The phyCORE-i.MX 8M Plus with 2GB of main memory is supported.
> +The phyCORE-i.MX 8M Plus with 1,2,4GB of main memory is supported.
>  
>  Quick Start
>  -----------
> @@ -21,9 +21,13 @@ Build the ARM Trusted firmware binary
>  
>     $ git clone https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git
>     $ cd trusted-firmware-a
> -   $ export CROSS_COMPILE=aarch64-linux-gnu-
> -   $ export IMX_BOOT_UART_BASE=0x30860000
> -   $ make PLAT=imx8mp BL32_BASE=0x7e000000 SPD=opteed bl31
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          PLAT=imx8mp \
> +          IMX_BOOT_UART_BASE=0x30860000 \
> +          BL32_BASE=0x7e000000 \
> +          SPD=opteed \
> +          bl31
>  
>  Build the OP-TEE binary
>  -----------------------
> @@ -32,19 +36,19 @@ Build the OP-TEE binary
>  
>     $ git clone https://github.com/OP-TEE/optee_os.git
>     $ cd optee_os
> -   $ make CROSS_COMPILE=aarch64-linux-gnu- \
> -     O=out/arm \
> -     PLATFORM=imx-mx8mp_phyboard_pollux \
> -     CFG_TZDRAM_START=0x7e000000
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          O=out/arm \
> +          PLATFORM=imx-mx8mp_phyboard_pollux
>  
>  Get the ddr firmware
>  --------------------
>  
>  .. code-block:: bash
>  
> -   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.19.bin
> -   $ chmod +x firmware-imx-8.19.bin
> -   $ ./firmware-imx-8.19.bin
> +   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
> +   $ chmod +x firmware-imx-8.28-994fa14.bin
> +   $ ./firmware-imx-8.28-994fa14.bin
>  
>  Build U-Boot for SD card
>  ------------------------
> @@ -56,15 +60,17 @@ Copy binaries
>  
>     $ cp <TF-A dir>/build/imx8mp/release/bl31.bin .
>     $ cp <OP-TEE dir>/out/arm/core/tee-raw.bin tee.bin
> -   $ cp firmware-imx-8.19/firmware/ddr/synopsys/lpddr4*.bin .
> +   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4*.bin .
>  
>  Build U-Boot
>  ^^^^^^^^^^^^
>  
>  .. code-block:: bash
>  
> -   $ make phycore-imx8mp_defconfig
> -   $ make flash.bin
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          phycore-imx8mp_defconfig \
> +          flash.bin
>  
>  Flash SD card
>  ^^^^^^^^^^^^^
> 

Regards,
-- 
Jerome
