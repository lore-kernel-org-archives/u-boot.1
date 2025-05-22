Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2FAC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 10:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 615FE82FC8;
	Thu, 22 May 2025 12:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s2gEio68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6182083043; Thu, 22 May 2025 12:23:10 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7088282F67
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 12:23:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a366843fa6so3441764f8f.1
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747909388; x=1748514188; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FonmydH4s3e2BmFGmGpnb4+luy4GBbVZMq5td4KieUI=;
 b=s2gEio68TewJfYgISAGSqIN3JSwrdPsc9tSqjhy3nrbIK53js+5DtxG4Yp44TJLdmd
 YMhsZMYQsXHWUOafWDWB+FidlXbuVV2XEn1BYCcsfnB07A8sthQKzM2XDF3ldNHoTDfj
 xqDbd6W+kdiugjr+4q78Wy1ZrIJ/jSR5+vsAtEHKF/bA7lOgAvl5xE+fdncZDCecHKJ5
 xiMBpUBnPP8KB0n2fNsiq0zsAVv/if+jzIE6wbzTZSSsk++Gcq1jr50pnoRyXCuRklgq
 EMbckP9Qdta5oR+JyqtYuMXmbHjQdAagtB6dF9G0gGvdWSIDpze+6NsXJz+divAAXqug
 AqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747909388; x=1748514188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FonmydH4s3e2BmFGmGpnb4+luy4GBbVZMq5td4KieUI=;
 b=cmxCHmspMonrBoWUQvaiBb/dOe6taDUntpmU6Tg1+oIlNbONIRoMNW4LewbBezpClQ
 ngJyVMYH1tzYQn9mabJtq8cpEDVXsGo/VVkzC7RCLwBNgHe4rruyq7aJG7rusZqsmhKC
 DOeEfY9OwSeWwujtUVS8FkNzuRkS9DGtYgnQSSXNE7oO9jKrDvwj0a0K0ScL5TITReuT
 KOfFLNwjSse5+OB0YQeOtibozW+Z79c/kONWrhXYBO/DcG4ArUZ0BVL95+KYuKsCUU2e
 NWWMJzxA0u0FMyYJCU9fOyUIFwr10u7x4+qZcAQz0adlzpO9A9xecf9IiPObmeqZPuj5
 OpTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk7vWdbVYlYpD6NLFlX3A7Ej9DsA+rtMLcS8Oa8SOY9pAlPRanEFBdOqXV1TnSZLflVCxE5mo=@lists.denx.de
X-Gm-Message-State: AOJu0YyViVTLVcKuGfhztsc0x30yvrvVt1bl52zp3ssWMZriduBL+72Y
 56kGIxh0F8vW7u7zbmS7JKu8s+YHjz381ai25LIF8RpsGwkVYCnsT4uLaDHwlnsLL7A=
X-Gm-Gg: ASbGncvyZ4j879YLX0OTbZ36st7NI8i0mxaGWFI0fbkLwhpKMs6z3Jgw8oS9iy0MelD
 iAMykjwI4FvAFH3rBZSjObBLchDa2Ved7kfDt2r8Z0RUhYaUVXitLYekOgtgFTJpfr5djVJK3Hw
 8RRNki6+6wAo2GyPn5VCl1cZgaN89viMQWf9kX4WVCj2zMZb0PpC5TklLsadYjxS5rTNvoo/jAY
 g5wchvFG5kZauPljNtGp1Y4PgADe2aSpa6JneVMbNCTSfDMBSJrMqWY7GOmDHcyxNjSnWWSKhz8
 jl4Gk/onqJvkrXQqBm1i4DvPpx1+kC54TiCtSa0fUPaoRyaO9ijL4iXfcsn4XVXpY6cfpE4LYzp
 xz3+E
X-Google-Smtp-Source: AGHT+IFGpCPaP4uqDPToR396Sfgd9fqLOYupHt5uuYteaHTZP57ReFErUsiWGBBbbNegBDO9EeP6Tg==
X-Received: by 2002:a05:6000:2dc5:b0:3a3:6958:88dd with SMTP id
 ffacd0b85a97d-3a369588c37mr15661784f8f.23.1747909387871; 
 Thu, 22 May 2025 03:23:07 -0700 (PDT)
Received: from [192.168.1.47] (i5E863A39.versanet.de. [94.134.58.57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f6f0552esm98172265e9.11.2025.05.22.03.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 03:23:07 -0700 (PDT)
Message-ID: <dfc021f8-d3f2-4fb4-8016-568dbf528c22@linaro.org>
Date: Thu, 22 May 2025 11:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] configs: add qcs8300_defconfig
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, quic_varada@quicinc.com, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250521094442.3522036-1-balaji.selvanathan@oss.qualcomm.com>
 <20250521094442.3522036-7-balaji.selvanathan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250521094442.3522036-7-balaji.selvanathan@oss.qualcomm.com>
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

Please update the commit title, "qcom_qcs8300_defconfig"

Kind regards,

On 5/21/25 10:44, Balaji Selvanathan wrote:
> Introduce a defconfig for QCS8300 based boards.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> v3:
> - No changes to this patch in v3
> 
> v2:
> - Renamed from "qcs8300_defconfig" to "qcom_qcs8300_defconfig"
> - Corrected a comment in qcom_qcs8300_defconfig file
> ---
>   configs/qcom_qcs8300_defconfig | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>   create mode 100644 configs/qcom_qcs8300_defconfig
> 
> diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
> new file mode 100644
> index 00000000000..5fffcddc16e
> --- /dev/null
> +++ b/configs/qcom_qcs8300_defconfig
> @@ -0,0 +1,21 @@
> +# Configuration for building U-Boot to be flashed
> +# to the uefi partition of QCS8300 dev boards with
> +# the "Linux Embedded" partition layout (which have
> +# a dedicated "uefi_a" partition for edk2/U-Boot)
> +
> +#include "qcom_defconfig"
> +
> +# Otherwise buildman thinks this isn't an ARM platform
> +CONFIG_ARM=y
> +
> +CONFIG_DEBUG_UART=y
> +CONFIG_DEBUG_UART_ANNOUNCE=y
> +CONFIG_DEBUG_UART_BASE=0x99C000
> +CONFIG_DEBUG_UART_MSM_GENI=y
> +CONFIG_DEBUG_UART_CLOCK=14745600
> +
> +# Address where U-Boot will be loaded
> +CONFIG_TEXT_BASE=0xaf000000
> +CONFIG_REMAKE_ELF=y
> +
> +CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"

-- 
Casey (she/they)

