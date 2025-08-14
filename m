Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD37CA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 14:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541E78393F;
	Thu, 14 Aug 2025 16:10:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="hxKUVNOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E54CE83976; Thu, 14 Aug 2025 16:10:21 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25FF183939
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 16:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 47E583F798
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1755180617;
 bh=d6Of2rE1Q7AIyYzvKEu2YtL+584+kwzw+y1P+dDDRH4=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=hxKUVNOBcDK17TvGxswPWlfW3I2JPhuvYTkt61kAt1SNsijWAh6a37dGqNnqxacYB
 D3jfrWeOXHOMATDpLOrjNm30PteqDFqF4WCGh2WNzutzNQ7fxHuhJQZnZADpMAlfYe
 +wADDCekbLwAh7F7GekAUUrY/BdqMFn7pBFf+P1aY0pqZQBhEmGEBl1EWploX/CFD2
 m0Dxs6mWGXukyxMUdjFxUwKHyJe+fhygt+fRCT43NiUwi15cTOPRAAjhOVSrro1SYz
 M7QB2kS2M8LmIJLcl4wu//naJwxv/7WysXNVeFcUTtgrva7gsbIfJ5KGeWgfFEBfLx
 8TKK/2lCVv0jw==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45a1b05d31cso3760105e9.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 07:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755180616; x=1755785416;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d6Of2rE1Q7AIyYzvKEu2YtL+584+kwzw+y1P+dDDRH4=;
 b=O+46tsdq0KQDwKZUkHBFUTHMmDIqS9kbINtj6N7gH8eClUshKQ3MwtfxyP51MrYW3V
 zN49IbZ9tT2b35M7KTG2O/bxlG9jPSPPcCOkTQHSYuXak8A1rO6pkNYYp9GxEwFzmND/
 pltEgLrFll23Ms09B64pGU4jIhQ1QrAuv1RuGPlUbhlVZpVkz3ydmCfjAZKmbfPlGkyu
 SzhEAx3xmts+HQnNfJcpgWcoSn5WpHIi3hjK9DwnB3CXBN7eBOtQYDpGEzzMsqx8LHb3
 0Qj0Y6/9dgUnB0a3e09kEfQUUqdaBkJr+MXHVwkRy26WeJk//zCNE9wPfUHTPm7Qr1+T
 mIAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5jT5wMola22mt4DcEXVIFswhkvCyPA0xNKedOZ4a3NgbF9keKqAcaBHNzN6xC89gAisqFKoc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp1zwjfWRoTk4/vy63YhGS3GFmxKHwGkpua6VGNOc6vGPexTNR
 DSUPdijSu+t6D6WLb4E7fNfa+WYHED5aayb5Cuy7A1ClTMWBJhd5jh0/eXpKebFnGXD+qAMETJ2
 JQYHvO05T0iUYf4S4yUHf+6V2wh2OQw6e51C1qep5wM0Mckjb2tGyl+Xh2CrRddFG6Vw5/lY=
X-Gm-Gg: ASbGncv8SwjPhITVm95CNE5YRkmnjoKlEznCo0e0Xa138v1W85DWnlEcS3E0VnVsjTZ
 cUDfKgJiyqhBeW/LF+w6NdPppRVoX4jK5ZOHY0Dp0wMX9Jq1d0jAW0qrEZxSTSMzdDWf9kDZLez
 1MQtoLB//vPlCvCQt+qT8mdwkf8xitvRu7myYnrdHLQrzore96QBj49IyxNUfc0Kflkw1eKuZ6n
 VRXVSz0/cBUTxcFRCwNz2Lqhz6CgzUpRnRUR/NvpItD1NiAHh4htSa+ut/otrLB0z4sZ7j7PR2M
 UtsGzBIEMT/t8iS7i0XuQ0Hp8lbvKQ9/sUezRaaPDbAjJWHz6wrrR8Vw/5dMHL9XxHLxXt64bbF
 IdKK2lSmPSx7j7r7o9Jo=
X-Received: by 2002:a05:600c:4e90:b0:459:d6a6:77c with SMTP id
 5b1f17b1804b1-45a1b667c62mr21764525e9.33.1755180616308; 
 Thu, 14 Aug 2025 07:10:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAgmYwnPQg9GpOrXcrJd9wrX4Fefk7QwghDbWeOoaJ+stMoszfGvHvx72hBJNABGYw4MzZGg==
X-Received: by 2002:a05:600c:4e90:b0:459:d6a6:77c with SMTP id
 5b1f17b1804b1-45a1b667c62mr21764265e9.33.1755180615843; 
 Thu, 14 Aug 2025 07:10:15 -0700 (PDT)
Received: from [192.168.103.116]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b9132f00ecsm8744171f8f.24.2025.08.14.07.10.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Aug 2025 07:10:15 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <8adf6ea6-e1c6-4dc2-b692-222381a02eb9@gmx.de>
Date: Thu, 14 Aug 2025 16:10:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CONFIG_SYS_EARLY_PCI_INIT for PCI-attached eMMC
To: Fabio Estevam <festevam@gmail.com>
Cc: jan.kiszka@siemens.com, trini@konsulko.com, u-boot@lists.denx.de,
 Mark Kettenis <mark.kettenis@xs4all.nl>
References: <cdfbaad3-e9ed-4678-9a65-c3561537d600@siemens.com>
 <CAOMZO5D+1v-721g5nE3NFQ4igrBHvF0rWs6Jkvm-Jo+R0QXKwA@mail.gmail.com>
 <87h5yakqug.fsf@bloch.sibelius.xs4all.nl>
 <CAOMZO5Cmgs3zUxdy_PRtE85pJLzG5=_1kReezFfKX6Xv05vHdg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOMZO5Cmgs3zUxdy_PRtE85pJLzG5=_1kReezFfKX6Xv05vHdg@mail.gmail.com>
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

On 14.08.25 15:27, Fabio Estevam wrote:
> On Thu, Aug 14, 2025 at 9:52 AM Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
>> Not without removing the 2nd pci_init_r() that is conditionalized on
>> !CONFIG_IS_ENABLED(SYS_EARLY_PCI_INIT).
>>
>> That would require some thorough testing though; I certainly wouldn't
>> be sure calling pci_init_r() is safe at that point on the boards I
>> maintain.
> 
> You're right.
> 
> Maybe we could solve it with two patches:
> 
> 1. Convert EARLY_PCI_INIT to a Kconfig symbol:
> 
> diff --git a/common/Kconfig b/common/Kconfig
> index a2f653f7e722..9119a1c0869f 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -824,6 +824,13 @@ config SYS_I2C_EEPROM_NXID
> 
>   endchoice
> 
> +config EARLY_PCI_INIT

Please, do not rename the symbol.

%s/EARLY_PCI_INIT/SYS_EARLY_PCI_INIT/

All configuration symbols starting on CONFIG_ should be defined in 
Kconfig. Only CFG_* are not Kconfig. Something must have gone wrong in 
the conversion work some years ago.

> +       bool "Enumerate PCI buses early during init"
> +       depends on PCI
> +       help
> +         Do early PCI configuration _before_ the flash gets initialised,

Highlighting is not supported in Kconfig.

%s/_before_/before/

> +         because PCU resources are crucial for flash access on some boards.

%s/PCU/PCI/

We were talking about eMMC, not SPI flash.

> +
>   config PCI_INIT_R
>          bool "Enumerate PCI buses during init"
>          depends on PCI
> 
> 2. Select CONFIG_EARLY_PCI_INIT in the defconfig
> 
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index d5890bf87fb3..a0d03dc19d0b 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -28,6 +28,7 @@ CONFIG_USE_PREBOOT=y
>   # CONFIG_DISPLAY_CPUINFO is not set
>   # CONFIG_DISPLAY_BOARDINFO is not set
>   # CONFIG_BOARD_INIT is not set
> +CONFIG_EARLY_PCI_INIT=y

%s/EARLY_PCI_INIT/SYS_EARLY_PCI_INIT/

Otherwise looks good to me.

Best regards

Heinrich

>   CONFIG_PCI_INIT_R=y
>   CONFIG_CMD_BOOTEFI_SELFTEST=y
>   CONFIG_CMD_NVEDIT_EFI=y

