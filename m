Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7E3C9EC94
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 14:56:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9FFD838A5;
	Mon, 12 Jan 2026 15:56:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RsZpT3Gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC5E48391B; Mon, 12 Jan 2026 15:56:05 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56F5C8388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 15:56:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b87108066c3so176939466b.2
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768229763; x=1768834563; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ho3JWd1qBDxwZqqi09OA06jZCfVGdrCUniSS/pVfdQ=;
 b=RsZpT3GkgYtRxDBSrb3ocJK8gedfHlRg+sqH23PSe2a5Zjn6ZHjV0W0YK08JdYeQgk
 0F+wl6HvTJAyKHcgDS6M99KNNRG7nHJr5C0u2zzJGNJe373IvYtpyVIIfHdX43MgE843
 LHNxLT5Yy4fyA0qUKBoufOx2wBJE4JLP/8JDCcIOQG0zFHvjwanJiAy4XuT5l1dX8XHE
 WOUF84X1WLtY1FSn9vEHT3U/YrVSq9K27FF0hgHapL/9zm8zmqXmRSXnIOipKuJXJBxX
 SacJjkRyX6SoI4RkLFo17zNnhLdH7ZNnDwOkseAH/mxYuyXcZJeYqdbCqlaEJ6Lt27mh
 70Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768229763; x=1768834563;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+ho3JWd1qBDxwZqqi09OA06jZCfVGdrCUniSS/pVfdQ=;
 b=RVEmiqY6En4eeFtxdVgbxz4W5R71k4EdrfuP9UBTX1aJNKEQgCwItqypR1ch63geN0
 Wy2ze/7o+skS5RED1DVViinPszDWDcoqO21cnxTv2jNFtfvmoITRCGqz4DNWh54rTBV2
 EbnGGKrDa3K8BLmRP9hrl06ELTWwWQYH9xOQpaLc2pDP1GLO2bsLVG7EBW0F81as95cA
 +R8i3wddE97uHhzcl4LmyNGeOGvr7u/nUWjr7AmAJ6ZpG8P7tiQiirXfC2uZL2uu4SSJ
 g3fMZBZq2rJewADUqQzKa6jxYZBP3FeHNa8Z1Iqs3cx8rMiXnkzHiklj2GqjsiTU9WHS
 gTYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAp1FB5YT6Z/Pk5uAkIssDrcVu9bubrVzUT2gGSs4HitiaUyMevNlOy9l1BnVhObz/r7IX540=@lists.denx.de
X-Gm-Message-State: AOJu0YwEbfwnwZjVmFgKX8+RulzWHB/3Z1U7AqnaWkS6Jp79Ohvn9qej
 7NRuWswSgvVLrpGKU/GenTNg9L2nQtuwselD96WnzUU4Sk4Y9k2VZwXBDZ5FiDqYOKE=
X-Gm-Gg: AY/fxX5kFdeNgz068xVTsok2mB1H6L4IOI0HwFB90BkgI+jMYXIz4VhVU+3aAQ/QzxN
 jwkXtSXjiQfGBs88/uvA2K5TLKVkghg5lk0WLE9qZ7X+can4z3jfvd1FhLDI7sfKX8gFAXBTPwu
 xH0oDlQSrsxu6EqWq9ay7ZteLioEslXYMrO3Oku6tvvMNLcXbssizLWfE358SvWAmLGNPHKtyzH
 qXsxhd/IG0eyjuA+yGJHtv22XLI0GACin2RZcvNR5jAhcPuIjSJaSO5ahV7kk3J0tiuVDtIHvXk
 JA9Xk0zUT2a16x5oY4318nX7VzBEBVOQLIFsqmI3rTZ3lHNxuQE3v94awjOgtNO8ZQ+TRzl9n/K
 TNIOz30P+fC567kC126+e9nqIKOq8UwhI3asJ+D+LXziaYopXRbXflurbTxOCJR0l+bp0ZZ0W2A
 kmkhRI3+x5rN8WlZiokn9/RgQnvnloX2lhRE/uPdVLmuXq9jezjC4=
X-Google-Smtp-Source: AGHT+IG0M1wxjkmIzAirfu/aSAX/WWAa0KXYbc6wxJYer8dxtuIrxGgH57tQvPfbK/MJClcfZap2sw==
X-Received: by 2002:a17:906:9fca:b0:b87:2c3d:ef08 with SMTP id
 a640c23a62f3a-b872c3e04e0mr167627266b.33.1768229762687; 
 Mon, 12 Jan 2026 06:56:02 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27cc6bsm1967918566b.23.2026.01.12.06.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 06:56:02 -0800 (PST)
Message-ID: <80f0a67d-689a-4865-a792-9f7967ab740f@linaro.org>
Date: Mon, 12 Jan 2026 15:56:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v2 4/6] configs: ipq9574: Enable fastboot support
Content-Language: en-US
To: Sumit Garg <sumit.garg@kernel.org>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: trini@konsulko.com, neil.armstrong@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, lukma@denx.de, marek.vasut+renesas@mailbox.org,
 michal.simek@amd.com, alexeymin@postmarketos.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20251218061557.1999367-1-varadarajan.narayanan@oss.qualcomm.com>
 <20251218061557.1999367-5-varadarajan.narayanan@oss.qualcomm.com>
 <aUVhRIWmfRHPnhRV@sumit-xelite>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <aUVhRIWmfRHPnhRV@sumit-xelite>
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



On 19/12/2025 15:29, Sumit Garg wrote:
> On Thu, Dec 18, 2025 at 11:45:55AM +0530, Varadarajan Narayanan wrote:
>> Enable relevant configs like USB PHY, gadget, fastboot,
>> fastboot MMC support etc. to enable fastboot flashing
>> of IPQ9574 based boards.
>>
>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>> ---
>>  configs/qcom_ipq9574_mmc_defconfig | 22 +++++++++++++++++++++-
>>  1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
>> index 6592d9de39d..ac534738994 100644
>> --- a/configs/qcom_ipq9574_mmc_defconfig
>> +++ b/configs/qcom_ipq9574_mmc_defconfig
>> @@ -45,7 +45,7 @@ CONFIG_DWC_ETH_QOS=y
>>  CONFIG_DWC_ETH_QOS_QCOM=y
>>  CONFIG_RGMII=y
>>  CONFIG_PHY=y
>> -CONFIG_PHY_QCOM_QMP_UFS=y
> 
> Any reason to drop this?
> 
>> +CONFIG_PHY_QCOM_QMP_USB=y
>>  CONFIG_PHY_QCOM_QUSB2=y
>>  CONFIG_PINCTRL=y
>>  CONFIG_PINCONF=y
>> @@ -54,3 +54,23 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
>>  CONFIG_MSM_SERIAL=y
>>  CONFIG_MSM_GENI_SERIAL=y
>>  CONFIG_SOC_QCOM=y
>> +CONFIG_USB=y
>> +CONFIG_USB_GADGET=y
>> +CONFIG_DM_USB_GADGET=y
>> +CONFIG_CMD_USB=y
>> +CONFIG_USB_DWC3=y
>> +CONFIG_USB_DWC3_GADGET=y
>> +CONFIG_MISC=y
>> +CONFIG_USB_DWC3_GENERIC=y
>> +CONFIG_USB_FUNCTION_FASTBOOT=y
>> +CONFIG_FASTBOOT=y
>> +CONFIG_CMD_FASTBOOT=y
>> +CONFIG_FASTBOOT_BUF_ADDR=y
>> +CONFIG_FASTBOOT_BUF_SIZE=y
>> +CONFIG_FASTBOOT_FLASH=y
>> +CONFIG_FASTBOOT_FLASH_MMC=y
>> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> 
>> +CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
>> +CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
> 
> You should rather try to update following for fastboot:
> 
> $ git grep -nr ARCH_QCOM drivers/usb/gadget/Kconfig
> drivers/usb/gadget/Kconfig:64:  default 0x18d1 if ARCH_QCOM
> drivers/usb/gadget/Kconfig:92:  default 0x4ee0 if ARCH_QCOM

This should be fixed by
https://lore.kernel.org/u-boot/20260112144933.3992369-1-casey.connolly@linaro.org/>

>> +CONFIG_FASTBOOT_BUF_ADDR=0x50000000
>> +CONFIG_FASTBOOT_BUF_SIZE=0x4000000
> 
> -Sumit
> 
>> -- 
>> 2.34.1
>>

-- 
// Casey (she/her)

