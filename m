Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E00ECA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 09:58:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED0A83106;
	Tue,  9 Sep 2025 11:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gi1xxvyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9116B8312A; Tue,  9 Sep 2025 11:58:15 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC733830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 11:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3e5190bca95so1887580f8f.0
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757411890; x=1758016690; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iBJWc++0ecoCD4GUH2IBkXGYDDPgTvO0Ubrae8Czmlc=;
 b=gi1xxvyVlcFhIJQJ90FFcNu3Xi1UFMwZXtHWN3XDM2fpk8o753EWzynq9kKYsaySUA
 xHOPJhKIL4POp5+PovBGIKTVo6djCygLJTQcUzPo4oFS300VtndCyUcjV3bi1p2sNLB+
 B21pLiY7BKY0i955YhpEggMry/rf9xSPC2yjctuPI5pf+BLwb8Ha67zOLEX4FpdBAa9X
 yGXSzxOqrWjzlkKOOTRbslmT8z8RpstyLITeJZB7IEosl2ZmsnMXe7af5ssezw1Vk+ot
 RgCH6IxIJaCdLibtDlGhUn/crk6lQ+6EG3cpuZGz53YX301LaboL5C1QeZ8k1iuNRJW2
 7jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757411890; x=1758016690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iBJWc++0ecoCD4GUH2IBkXGYDDPgTvO0Ubrae8Czmlc=;
 b=vAZJ+f9fx63lU86rApT7FOroKmbIpABaPepwhVABfRY/aAijG790EzSOx/obyia1pR
 oUliZ7pBGROFjJVkVo5qkETyD8/YkU1vYKOjv87Tr0vZiRfwh6nbjzbyf6G/Mvjp/f3Q
 drMunvZYXZ1BwDotanMLJZJ5gO9DmM4YpRM8iC2nb5WVVeUWWNFouU5+ppmUTS6+c0W7
 4miZHuy782sYMmgdD8Xg2q79bn7adK6lSgfkC2TDTwSnxCfk9/A7Ivx0+PFNE58eLc8V
 iF9XCyJaIub2b9XN9kc4s2WGXfmcuhvuGyUt6weH5KAl/tlFqfmnmrtNAe5SF7jfkGdD
 4TTQ==
X-Gm-Message-State: AOJu0YweAIpJsM+3AdrUVXVGrL/NZ5rblbBWIcjEEvfCICkJxajyaJaR
 2NJGl7hvZYTBD2j3tBAP51O+4nmeh2rY+kT5+aGICLPK1wwlJgOaaVRjXt2jiUkLvNI=
X-Gm-Gg: ASbGncvzVbuIclcXWIwsHgmc06DR6cpOHhRfE/fZSAN8kTxbh+yCsjgBW72wvpbvldG
 ICatgAbCaCsxHtjVel9DJkaAHdPz2UJJz+IkyPfaMMC14Q8UwG+wD/3TSToiIjSLYpFxfJU3DlK
 bTn2swIEHf85d3Xb03+80OvUBAqcxAjFamPrTrMDhg7NibgbtZYuuMiccDNhqZAdIN9J3vjxskE
 8+kFHF5/R+0LBrrjjAKKpsggI2xWnEA5wdKTTd+p4g2rdgly/c1k2MJquQN8vFPY152IwyOG8f9
 AHvmOFdQD+Q4ii5pjN64wvG1wYYoTzB8QzjybBt3puGeb/oYSTPnZ2GhDKbqnHL2XMgSZbLHeNw
 wMp+4aNEcLZB9QjUAk6kIonIgsl8AeycrWIE=
X-Google-Smtp-Source: AGHT+IGhuv6aVlG6+RNvpg46z+89g/Wch4CyERXnvRL8OWI4O//Dk2t/UH4/vybQxFRU6el5raEXUQ==
X-Received: by 2002:a05:6000:22c4:b0:3e7:47c7:9cf with SMTP id
 ffacd0b85a97d-3e747c70e38mr6167641f8f.4.1757411889705; 
 Tue, 09 Sep 2025 02:58:09 -0700 (PDT)
Received: from [192.168.7.92] ([212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7522562d1sm1905808f8f.63.2025.09.09.02.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 02:58:09 -0700 (PDT)
Message-ID: <c2da0d18-9ce0-4c0f-8495-977ad7d8ca5b@linaro.org>
Date: Tue, 9 Sep 2025 11:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] doc: phytec: imx8m: Style and firmware update
To: Yannic Moog <y.moog@phytec.de>, Tom Rini <trini@konsulko.com>,
 Fabio Estevam <festevam@gmail.com>, Teresa Remmet <t.remmet@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 Benjamin Hahn <b.hahn@phytec.de>, Yashwanth Varakala <y.varakala@phytec.de>,
 Jan Remmet <j.remmet@phytec.de>
References: <20250908-imx8m-optee-enable-v3-0-14bfe249b3c6@phytec.de>
 <20250908-imx8m-optee-enable-v3-3-14bfe249b3c6@phytec.de>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250908-imx8m-optee-enable-v3-3-14bfe249b3c6@phytec.de>
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

On 9/8/25 08:34, Yannic Moog wrote:
> Use single make command for compiling blobs and U-Boot.
> Update the imx firmware version.
> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>
> ---
>  doc/board/phytec/imx8mm-phygate-tauri-l.rst | 27 ++++++++++++++--------
>  doc/board/phytec/phycore-imx8mm.rst         | 28 ++++++++++++++--------
>  doc/board/phytec/phycore-imx8mp.rst         | 36 +++++++++++++++++------------
>  3 files changed, 56 insertions(+), 35 deletions(-)
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

This CFG has been removed from optee_os since 4.2.0 and has never been enabled
by default, so I would think there is no need to set it to n here.

Thanks,
-- 
Jerome

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
> index e1385be25e1a862db7021e29cd5d0d3ba68cc01b..8995a2965328dc645fd29ad979e399bf7652106c 100644
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
> @@ -32,20 +36,20 @@ Build the OP-TEE binary
>  
>     $ git clone https://github.com/OP-TEE/optee_os.git
>     $ cd optee_os
> -   $ make CFG_TEE_BENCHMARK=n \
> -     CROSS_COMPILE=aarch64-linux-gnu- \
> -     O=out/arm \
> -     PLATFORM=imx-mx8mp_phyboard_pollux \
> -     CFG_TZDRAM_START=0x7e000000
> +   $ make -j $(nproc) \
> +          CROSS_COMPILE=aarch64-linux-gnu- \
> +          CFG_TEE_BENCHMARK=n \
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
> @@ -57,15 +61,17 @@ Copy binaries
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
