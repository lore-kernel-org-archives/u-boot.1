Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B77C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:01:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C689282CF5;
	Mon,  7 Apr 2025 11:01:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dGBplT7v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F5A582D17; Mon,  7 Apr 2025 11:01:33 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34CFD82CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so27467755e9.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744016490; x=1744621290; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=QQaano5XWwgPyLKBqBtnRzKpquvnzm5o+FVILr/rjew=;
 b=dGBplT7vos1RWeFnPXpLOrvPP+4k72Ya/f90K92SWh0bm9hTgqOd1aBEWO45ARSj0M
 iK2D0fHaX4mtvC6GrsOqKKYio4soFFdFcucklhDbk51Ad8dBEYrM1keKDgZ3QkVOWn+d
 2ak+zw7Rg+ojlnWl2vQPDnUKXhHR85MdYZMGWOO0PD4nNCSwUm66iO/rv5vPUe8NPyNW
 zOkE7rHMyqdYcG/2ZMvRHHQSY3pDdXi2YokvwHkUXuFfaDwoGavhCR5b+qjtkmbOsZ4z
 cYF4C501l5A465IlGFEcjK4cvVEBVF9ebQXTWBv5EcyfmdMK7iNTrNq7dQq+otM5JEyz
 /hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016490; x=1744621290;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QQaano5XWwgPyLKBqBtnRzKpquvnzm5o+FVILr/rjew=;
 b=MZzgDL9g9oKsJbwMFugbxCLaTt0lbm25nUIbtJ5mpfLarWXU4TD0oqgFUdmorjBEvt
 cWIHTio97PNCy/oC+EKR1FeZ1Bh+nN3zzh8iF1M3CZyuVDxnxXWGMm3J4JyS/YSNOjUY
 8WS2n+7UoiTx61atqwo6XChmCs2LwSamtPsyxFk1VV3QZ8IMbu1PmKPf8fBASox8sU48
 K8Cr6N1HKzA5/nNhO7WQqE2mPs1WemmlVEVB/6NaLRIduYe/DwsiIixwYf5cnk/vMLHF
 CfHxDsadC7VW+S4gHehcKrIjVggNtcII5dqRvZRThlz3gDfm+GGjDhrvuBJerTE4X29P
 B5vQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXU3AFsCoBrwwOre8eGK7rnDr9dAnGLqPS1SYWTBNZyKa3ZPcw9kVYxK5v8RviIIf++pmTc7Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxUbmBJVmvsn0uulVKxsMdWMoxPN45pd/+zi2t08A2PbD5kSGT/
 2KTL2R+qjaMbgHyj/NZ5D7Oiu1ErMUtghjIqBCfFYbpYwL15cgulUi7BPrq06go=
X-Gm-Gg: ASbGncuG8qpygVHRBg89ffeywkkD54uSatzTwoGKXVweNVT6y4kmwhqDvQBb35eIOgs
 XC1afzq1zDxemM11lEJvN3CerXafjvWQJ/KDLqDDr/f8JrHJCckEyUuKISlvgq24cfHXuo/MKEl
 mfxwazZ9q9faz7a624ed4z+ewpzR8WTrNOPZNNBDolfqDpqRXids8/VlMFdY/xZDz2oqgL80MPC
 kQnL54hULsZhbK1au78rYa54XRleVddB3RfdaxC20/nZwZvTwwSTJ7uRFiJmqsCzn75GwM4fPsT
 Uh58Yzwhl4U0EEjzOpdLnSWwkP2nFYH18I92WO8snuFUNhuNwXGBoej0+m0sWYLK5fFSLpVvTKA
 M40xOkULFhsgdwzpSj7uJ2g==
X-Google-Smtp-Source: AGHT+IHpKTVYpf8tU7GaTZsPipY8VuLi/pOChkUTJE/TW/q6kHERBrOpBril6xkYIA0IFpkujjKN6g==
X-Received: by 2002:a05:6000:4387:b0:391:4231:40a with SMTP id
 ffacd0b85a97d-39cba9328a4mr10513455f8f.33.1744016490576; 
 Mon, 07 Apr 2025 02:01:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d66csm11831213f8f.63.2025.04.07.02.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:01:30 -0700 (PDT)
Message-ID: <36e05748-0cca-41aa-87d4-8790569b623c@linaro.org>
Date: Mon, 7 Apr 2025 11:01:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/7] board: qualcomm: dragonboard820c: udpate readme
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-2-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407081927.138915-2-jorge.ramirez@oss.qualcomm.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> Update build instructions.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   board/qualcomm/dragonboard820c/readme.txt | 47 ++++++++++-------------
>   1 file changed, 21 insertions(+), 26 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard820c/readme.txt b/board/qualcomm/dragonboard820c/readme.txt
> index 966e9520e85..5817c837fdf 100644
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
> +5) Append the dtb to the u-boot binary
>   
> -   $ dtbTool -o dt.img arch/arm/dts
> +   $ gzip u-boot-dtb.bin
> +   $ cat u-boot.dtb >> u-boot-dtb.bin.gz
>   
>   6) Generate Android boot image with mkbootimg:
>   
> -   $ mkbootimg --kernel=u-boot-dtb.bin             \
> +   $ mkbootimg --kernel=u-boot-dtb.bin.gz          \
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
