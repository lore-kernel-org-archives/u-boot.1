Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA95D44144
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 11:20:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310F98956D;
	Tue, 19 Nov 2024 12:20:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="opzIVXXZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 727108956F; Tue, 19 Nov 2024 12:20:54 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DC8789548
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 12:20:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4314fa33a35so44457985e9.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732015252; x=1732620052;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EPGcDdaJlY5dkuUaholqI2lueu6DBfuNVRTdSsSWk4E=;
 b=opzIVXXZ/vKsKmwG10TPhJhJfSOEUkkysV3DjfO4wPP4JJg+jTFh9oFpZAvj4lCrTN
 oIxZZ773agks8Gw3YV6mQYlMa7toZnukzRezV/kIKPyPjTm9s9ZDIT43O1eJ6AmN0rQQ
 U2KfA6ttolxalHABbs5l+BdZy2/bOGJbDCCgea5og1vPpYZDKIzBJHqtp+Z82Raciy6o
 AGkZs8EOlDtdok6qm0CRHvouteYkqR7EHXX7ghurkWWj827R9AxeHsCs4ShGKNM65Rzy
 CSF3jhgmPhS/mh9G0cLrMldBBSITPf5P4nl62fwLYb8j3/wTIADlOBRsu4xXLrXtHUgM
 tFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732015252; x=1732620052;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EPGcDdaJlY5dkuUaholqI2lueu6DBfuNVRTdSsSWk4E=;
 b=fce446Wv+Lu2d8Z2EGdnnKETqX0PYXVElYoXF7Hy9TfqF5aQpuSaybCAPyGQ+7BIFH
 vL+S2drN4lYYxaikjT+6BaCHwtfDGjbMLZ4K0X5n1ZSFWBxeRdbR/eFRw9m/4g6d2Lzg
 kbMcsHC+GBmCnIuX7YcybWjY+FCB/a9RSAPrRx62nvqgU2qZ4JXRIR8CY17SWiMCKrAF
 uC4+ppE22a/wKwCNoZVrx9yG6wxsysuxhDIROQdrt/s3q/i8NtbLxlbtkp8rM98hFufZ
 Cf0dQJN2Cz1jge0dtZhKIH6yOmb3odZ/vb5Ql8W2EljqvR7/v0nx+84DuwjTEKDSEEUJ
 iEMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5lBAytYPMLIRz5OMMqrgOLNPjn/z/H2/SM/Tx+2cHpiwkYuzoFHDU1bgFNNsK7ElK8Je7ON8=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt9qs7LDxqNUaJTUnvuIQTqFONp0jwEDRg+AxfPtMrUHxtzKcL
 O+X64RrBONemQ10e7FbQTMmi2kR/EqovBtRkx6lDLhbE9yKw6c2x5R++NgI+5Ks=
X-Google-Smtp-Source: AGHT+IEI05n8BF6vobAh6kAf72Ox/rX4l3P9aW7RxM++v0RjBVxKltNTRTJItEaAJER2DPHv2cvGYQ==
X-Received: by 2002:a05:600c:3ca9:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-432df72ab6bmr135834645e9.8.1732015251838; 
 Tue, 19 Nov 2024 03:20:51 -0800 (PST)
Received: from ?IPV6:2001:861:d40:ed60:3c21:a12b:c34b:7f11?
 ([2001:861:d40:ed60:3c21:a12b:c34b:7f11])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da2946a3sm190471555e9.35.2024.11.19.03.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2024 03:20:51 -0800 (PST)
Message-ID: <92320a14-650a-444f-a85a-750ef05d8349@baylibre.com>
Date: Tue, 19 Nov 2024 12:20:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] configs: khadas-vim3_android{_ab}: move on
 bootmeth android
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
References: <20241114-adnroidv2-v2-0-015bffb1373a@baylibre.com>
 <20241114-adnroidv2-v2-4-015bffb1373a@baylibre.com>
 <87serny0g7.fsf@baylibre.com>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <87serny0g7.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi,


Le 19/11/2024 à 11:36, Mattijs Korpershoek a écrit :
> Hi Guillaume,
>
> Thank you for the patch.
>
> On jeu., nov. 14, 2024 at 22:29, Guillaume La Roque <glaroque@baylibre.com> wrote:
>
>> Actually khadas vim3 use distro command to boot android image.
>> Move on new bootmeth android for A/B and non-A/B vim3 android.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>   configs/khadas-vim3_android_ab_defconfig |  7 ++++++-
>>   configs/khadas-vim3_android_defconfig    |  7 ++++++-
>>   include/configs/khadas-vim3_android.h    | 26 ++++++++++++++++++++++----
>>   include/configs/meson64_android.h        |  3 ---
>>   4 files changed, 34 insertions(+), 9 deletions(-)
>>
>> diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
>> index de5357c45cbf..a078c5d363ae 100644
>> --- a/configs/khadas-vim3_android_ab_defconfig
>> +++ b/configs/khadas-vim3_android_ab_defconfig
>> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>>   CONFIG_FIT=y
>>   CONFIG_FIT_SIGNATURE=y
>>   CONFIG_FIT_VERBOSE=y
>> +CONFIG_BOOTMETH_ANDROID=y
>> +# CONFIG_BOOTMETH_EXTLINUX is not set
>> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
>> +# CONFIG_BOOTMETH_EFILOADER is not set
>> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
>> +# CONFIG_BOOTMETH_VBE is not set
>>   CONFIG_LEGACY_IMAGE_FORMAT=y
>>   CONFIG_OF_BOARD_SETUP=y
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> @@ -35,7 +41,6 @@ CONFIG_SYS_MAXARGS=32
>>   CONFIG_CMD_ADTIMG=y
>>   CONFIG_CMD_ABOOTIMG=y
>>   # CONFIG_CMD_IMI is not set
>> -CONFIG_CMD_BCB=y
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_I2C=y
>> diff --git a/configs/khadas-vim3_android_defconfig b/configs/khadas-vim3_android_defconfig
>> index a0d9c423c3c3..b77a44ce859b 100644
>> --- a/configs/khadas-vim3_android_defconfig
>> +++ b/configs/khadas-vim3_android_defconfig
>> @@ -24,6 +24,12 @@ CONFIG_REMAKE_ELF=y
>>   CONFIG_FIT=y
>>   CONFIG_FIT_SIGNATURE=y
>>   CONFIG_FIT_VERBOSE=y
>> +CONFIG_BOOTMETH_ANDROID=y
>> +# CONFIG_BOOTMETH_EXTLINUX is not set
>> +# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
>> +# CONFIG_BOOTMETH_EFILOADER is not set
>> +# CONFIG_BOOTMETH_EFI_BOOTMGR is not set
>> +# CONFIG_BOOTMETH_VBE is not set
>>   CONFIG_LEGACY_IMAGE_FORMAT=y
>>   CONFIG_OF_BOARD_SETUP=y
>>   # CONFIG_DISPLAY_CPUINFO is not set
>> @@ -34,7 +40,6 @@ CONFIG_SYS_MAXARGS=32
>>   CONFIG_CMD_ADTIMG=y
>>   CONFIG_CMD_ABOOTIMG=y
>>   # CONFIG_CMD_IMI is not set
>> -CONFIG_CMD_BCB=y
>>   CONFIG_CMD_GPIO=y
>>   CONFIG_CMD_GPT=y
>>   CONFIG_CMD_I2C=y
>> diff --git a/include/configs/khadas-vim3_android.h b/include/configs/khadas-vim3_android.h
>> index 0e2953fe71b3..096ab4e5fb1f 100644
>> --- a/include/configs/khadas-vim3_android.h
>> +++ b/include/configs/khadas-vim3_android.h
>> @@ -41,10 +41,28 @@
>>   	"name=rootfs,size=-,uuid=" ROOT_UUID
>>   #endif
>>   
>> -#define EXTRA_ANDROID_ENV_SETTINGS \
>> -	"board=vim3\0" \
>> -	"board_name=vim3\0" \
>> +#define CFG_EXTRA_ENV_SETTINGS                                    \
>> +	"board=vim3\0"                                               \
>> +	"board_name=vim3\0"                                          \
>> +	"bootmeths=android\0"                                         \
>> +	"bootcmd=bootflow scan\0"                                     \
>> +	"adtb_idx=3\0"                                                \
>> +	"partitions=" PARTS_DEFAULT "\0"                              \
>> +	"mmcdev=2\0"                                                  \
>> +	"fastboot_raw_partition_bootloader=0x1 0xfff mmcpart 1\0"     \
>> +	"fastboot_raw_partition_bootenv=0x0 0xfff mmcpart 2\0"        \
>> +	"gpio_recovery=88\0"                                          \
> gpio_recovery is not used anywhere. Can we please drop this?
yes i forgot this part of gpio recovery not needed anymore i will do in v3

Thanks
>
> With that addressed, please add:
>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
>> +	"stdin=" STDIN_CFG "\0"                                       \
>> +	"stdout=" STDOUT_CFG "\0"                                     \
>> +	"stderr=" STDOUT_CFG "\0"                                     \
>> +	"dtboaddr=0x08200000\0"                                       \
>> +	"loadaddr=0x01080000\0"                                       \
>> +	"fdt_addr_r=0x01000000\0"                                     \
>> +	"scriptaddr=0x08000000\0"                                     \
>> +	"kernel_addr_r=0x01080000\0"                                  \
>> +	"pxefile_addr_r=0x01080000\0"                                 \
>> +	"ramdisk_addr_r=0x13000000\0"                                 \
>>   
>> -#include <configs/meson64_android.h>
>> +#include <configs/meson64.h>
>>   
>>   #endif /* __CONFIG_H */
>> diff --git a/include/configs/meson64_android.h b/include/configs/meson64_android.h
>> index 37ef8b8f7a7e..d6ef0a83a686 100644
>> --- a/include/configs/meson64_android.h
>> +++ b/include/configs/meson64_android.h
>> @@ -104,9 +104,6 @@
>>   	"elif test $board_name = sei610; then " \
>>   		"echo \"  Reading DTB for sei610...\"; " \
>>   		"setenv dtb_index 1;" \
>> -	"elif test $board_name = vim3; then " \
>> -		"echo \"  Reading DTB for vim3...\"; " \
>> -		"setenv dtb_index 3;" \
>>   	"else " \
>>   		"echo Error: Android boot is not supported for $board_name; " \
>>   		"exit; " \
>>
>> -- 
>> 2.34.1


