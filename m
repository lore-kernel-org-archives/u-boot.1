Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBF1C9EC8E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:23:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BF7C838A5;
	Mon, 12 Jan 2026 14:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZyuhdWQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F4F8391B; Mon, 12 Jan 2026 14:23:01 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8558A8388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:22:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b8b5410a1so9383668a12.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224178; x=1768828978; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RCnCFKZAKlrhV4uezCJ1fEuMt6hNfQ3mBXx9JNrPjxo=;
 b=ZyuhdWQO2ecwQ0mia1vSmRFcSDSytPcMRGpCNsmZ2bt82s8F7LH1n/SlNxTk17X/9P
 0biIliDInuK/+UG+fqjXK3V0XwFAUwJW4Idw8Zqw1qpDNIelUMpu0MmQX/MMzPMf1ygH
 RFc45gv+aGPir5x0V2zitkR3lxSeCt/ipqTy4uEzIP5tvodhQnZLxxkflTSS0/Tx7MDI
 nZ1y2Y0C/7nlkewW77zp8Nk71MP7HGERn3SrV2WiLi8wl8X7qKRIUilH0YPsTxi5ammk
 5oEkl6c/4xhGMPMnnzZ7+kzJxVErmI6iCEDn6U0CkAVlkxzC80Nf3A+uRpwukEDMxeNT
 bAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224178; x=1768828978;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RCnCFKZAKlrhV4uezCJ1fEuMt6hNfQ3mBXx9JNrPjxo=;
 b=nxGbxYovisNZqLKKz0F7uVwuAFPPfA3YZV3uPizTXb8X2Kre+Tr+WQ4GtTcWkZng4y
 g0a+EqSTHL3FMK2XfsbCbje75JgGihitc/EuL8BZdVf1FaOTMCczCPcmRSjeY0tI68K4
 UP7x58j0ry2gzns4u9PMRIwMLCAABVb2AcUJvR2ntV16ViJnuo8zWUANSSGQXiYAVXez
 0D0Vriezf+Lk4/luSDDLWr4Ndy4zffRkds/NosTJuT8JbGPljE8HTA5zrV16/XA2ir7b
 aPKSGYjehnArCgk2X6Ywds3ogxVXWzbHizY1BoJcCbeJowbX6yNk1Ha4xyXUA+uF+Khh
 Fmkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWaFaMHlNxYOxn31fGqMqgppzsaf6TtTd+ljEkKfJeBOygw/YEg9wX6EonksBQvgBQB1MZtNA=@lists.denx.de
X-Gm-Message-State: AOJu0YwzJOUavo2nPTBXoqK42lTIHbcUXH0GlZ2TUSEGXcKGA2WJ1GIu
 KT2slfhkzNJPyLXTuSZxByVfOtAsZC+YmgcFt9l00zIpV1VHZOuwtl7pei1OV3AX7SE=
X-Gm-Gg: AY/fxX7zvoj8hWtly32Rxqspc+2KXi98GTc84JjFdU81IEUHWCMn3nYLQlmN05lMjiK
 ImIVfQaaEFjCsumTNPyVbyHOuUJN02xLkRUXX7+Hlx1byyi19diy4FISay+kg/cAwHDqpCsktQP
 FADPthIzRzSnK299HMjTu830WzpknCjWnSxifldQR8McV8N4bT8gNwb4+9qq0MNucTaKXe06GGr
 rpzzp2ol1k54fTB7JqbHwbAZNoyRdS6O4mSpouqVI3gCp0ce3+n5FLvcMoPOkIFDsNDa4cwllHP
 k5PfrWuRzcewd5gaa196syA7r5DpcQDfTmHt+Z4aK/occiXy5+SJI2w37T4rRwgG8Rtlfm4Rw+4
 GnrXJwq8vbXwLSr6QECKDpPZ0dUFsF1xh6qNViabZ3WG4uEpvs+xPX6GHn1ResjJ3vk3SW+4WKb
 QNkvreG5guAfFK9b4UVyfDCirFTKmKx4lo7zrlUxlKIu9NXzwuqYyYR2yDTiRRvg==
X-Google-Smtp-Source: AGHT+IG2OzPBicZeUg/yW85t0AdKDJZPhjn61MtAy3UFtptU3gPbQumfKgnE0JxXLVbvqAI5Mha0UQ==
X-Received: by 2002:a17:907:7fa7:b0:b87:7e8:e268 with SMTP id
 a640c23a62f3a-b8707e9127fmr456554366b.37.1768224177917; 
 Mon, 12 Jan 2026 05:22:57 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b86f61d2774sm706413366b.41.2026.01.12.05.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:22:57 -0800 (PST)
Message-ID: <4ce7da40-8c8c-4594-a108-15a723006a94@linaro.org>
Date: Mon, 12 Jan 2026 14:22:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: qcm6490, qcs615: Enable PSCI-based system
 reset support
Content-Language: en-US
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com,
 aswin.murugan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20260112070219.2193004-1-balaji.selvanathan@oss.qualcomm.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260112070219.2193004-1-balaji.selvanathan@oss.qualcomm.com>
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

Hi Balaji,

On 12/01/2026 08:02, Balaji Selvanathan wrote:
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Enable CONFIG_SYSRESET and CONFIG_SYSRESET_QCOM_PSCI for qcm6490 and
> qcs615 platforms to support system reset functionality through PSCI
> (Power State Coordination Interface). This allows proper system reset
> operations on these Qualcomm platforms.
> 
> This patch is based on the already submitted patch:
> https://lore.kernel.org/u-boot/20250613051957.3159564-4-quic_varada@quicinc.com/
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>  configs/qcm6490_defconfig     | 3 +++
>  configs/qcom_qcs615_defconfig | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
> index 54eb5dedaec..8d70ae8cede 100644
> --- a/configs/qcm6490_defconfig
> +++ b/configs/qcm6490_defconfig
> @@ -13,3 +13,6 @@ CONFIG_TEXT_BASE=0x9fc00000
>  CONFIG_REMAKE_ELF=y
>  
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
> +
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_QCOM_PSCI=y

SYSRESET is already enabled in arch/arm/kconfig by ARCH_SNAPDRAGON, I
think it would also make more sense to enable SYSRESET_QCOM_PSCI in
qcom_defconfig (I assume other modern platforms can use this driver too?).

Sorry that other series never got picked up, I was waiting for some
additional feedback but I'll take another look at it now.

Kind regards,

> diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
> index 2468267b955..7a8f231aabc 100644
> --- a/configs/qcom_qcs615_defconfig
> +++ b/configs/qcom_qcs615_defconfig
> @@ -20,3 +20,6 @@ CONFIG_REMAKE_ELF=y
>  
>  # Address where U-Boot will be loaded
>  CONFIG_TEXT_BASE=0x9fc00000
> +
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_QCOM_PSCI=y

-- 
// Casey (she/her)

