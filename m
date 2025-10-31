Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ED2CCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 08:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0122E8331F;
	Fri, 31 Oct 2025 09:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CP9+TBTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C1AA83849; Fri, 31 Oct 2025 09:22:11 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC2FC800B1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 09:22:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso13591f8f.1
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761898928; x=1762503728;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eTZ0KoCPoG3MjuGCZpD/SuK6yiL8+YzWGgle1LFo/0U=;
 b=CP9+TBTpD8dn+hXJ2jk8Ziwkd78h9fBKdAlPm0+9dMRAWMZ6bZdCG52H8Pa0i42Rw6
 MfI82XKAZx0T5B17VhER6NWPCJZJneAFSHGGBIeyFd6wgg4oxeK7Yxqbfz4q/oJtnupk
 cSRZS0ImAs4qgryRHubUAhes5qvzJFxkkwWL8lk6FNUg6V5szr8pMSLdXPVVL4GoztNp
 U+lZ/85/IB1J5ki8LOCL1U+ijf46/MoUbuduu+n6qitoO3S3NEEqJC5jQNdDxypgLyHW
 lpm1XPN/cCnwLYNYu6ewNEdfNpeAnzpIku2mQ/mkurovRsM/JR+L+qS33kSfwnbhOEHf
 PGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761898928; x=1762503728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eTZ0KoCPoG3MjuGCZpD/SuK6yiL8+YzWGgle1LFo/0U=;
 b=K9FqEEeqK/3ZOJ3SJgYVxUCv5YoLEyltZrOm0GtpJU2tBRMihW9O3skaZWD8oFgwAB
 PEeV5gh0f+ErpMkvSmr5QZIKsWVD2wZgRgLcNBaQVtBRhlMKx+qqCPsJ6LcxLBNb2/RH
 8Q70fJXPpwdnW4ST1qPCsozuNnhNzBGT+xVL7n+/9wWDVX5xTeaBpqlJx3c8zPalsiQZ
 a47/nlaMiaKlomSD7UEk1najuaeEnugMn6WuTxXz3KVORN8NHSLl8atDM4QTt9B/lfe+
 Mw8X4SuBPcG44TV4nhXeRiIoLSWed7vK3rkL7GgQPvH87LxrK8OAvGpHMNPFZmLkXKI7
 +ErA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQFv6/0zmd61WYkCSh1c41CUNAw7H5QZ9M2JerS8mvXLwiEUeIa8Jko0kE226f7FPWCfojKR4=@lists.denx.de
X-Gm-Message-State: AOJu0YxWsva1z4/8kNCKzDtAjvDfb3AZDMNsbKgFAkbyhrs9wyx85tN6
 x7rF0JduaCaqSKedtcRCwWBlzS8sPPRMt8PUtqHdEa5evG8jjH5ZLuny15BzRqRvUgo=
X-Gm-Gg: ASbGncskVpLd5PB7I94SSgn0NDddN73UV0syMwDb0/chf64+gOJ2hfEzT+wBmNCfG1f
 EZhia35WdCX8gy+gMWdQiD2+k1tla2/B1SsKYFbTUkZ6WcgkgND6flQNCiesFCZ5Jh+n/x/S7OQ
 CSkda2wSsluEQP2I3E5BaTY/TtNXfwlWS6AZljyassOhzABQleDTP3QSZ7ZkfF7TbCDIM2/lSqn
 blXcz5dFIaCCmI93CRUz0W+OAybrUCvHpfHgALr8eH2vCrUAVy3rPqit8UbhBPj0RZTTJ+0gN8V
 HLvusfB3E7WDzHkhd+HndTIPARAdDaPFyP8dy5T45Xt+W3IdSJA0NonZznZNz//y+Hfe8eU6H7D
 fs/g2oN/rq74rigRRi06ZChpOxQUqaCpKpG6S/UpKIDv7OV1wXgSss1bqPCwRpEH6luHOlMqqxZ
 3QgdHGpPSoNW09cZw5lBWmEvpXHsL0BHRNNcXNl3S8vgn3klCTr9rqiFguyw==
X-Google-Smtp-Source: AGHT+IHZOudIWXFEhZewBgYIw3zZ2Hsd5qp6GMp2ulptVb90sBRL6HVo4RjRTBuvu0cVfqslccCd6g==
X-Received: by 2002:a05:6000:26d2:b0:429:bfbb:5dae with SMTP id
 ffacd0b85a97d-429bfbb606cmr1269633f8f.17.1761898927956; 
 Fri, 31 Oct 2025 01:22:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e50:3860:d519:e583:910d:b32c?
 ([2a01:e0a:e50:3860:d519:e583:910d:b32c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47728a979b8sm82132135e9.10.2025.10.31.01.22.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 01:22:07 -0700 (PDT)
Message-ID: <c2121665-7eb3-473d-8933-e6729c3e9040@baylibre.com>
Date: Fri, 31 Oct 2025 09:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] board: am62x: Add support for reading eeprom data
To: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de,
 Anshul Dalal <anshuld@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Tom Rini <trini@konsulko.com>, Garrett Giordano <ggiordano@phytec.com>,
 Wadim Egorov <w.egorov@phytec.de>, Neha Malcom Francis <n-francis@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Santhosh Kumar K <s-k6@ti.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Devarsh Thakkar
 <devarsht@ti.com>, Prasanth Babu Mantena <p-mantena@ti.com>,
 Judith Mendez <jm@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dhruva Gole <d-gole@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Aashvij Shenai
 <a-shenai@ti.com>, Peng Fan <peng.fan@nxp.com>
References: <20251024-am62xeeprom-v2-0-0e372347e7d4@baylibre.com>
 <20251024-am62xeeprom-v2-2-0e372347e7d4@baylibre.com>
 <8127d3c6-3b1e-4e8c-9ae5-efd7740cc54c@ti.com>
Content-Language: fr
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <8127d3c6-3b1e-4e8c-9ae5-efd7740cc54c@ti.com>
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

Le 27/10/2025 à 19:08, Andrew Davis a écrit :
> On 10/24/25 9:17 AM, Guillaume La Roque (TI.com) wrote:
>> I2C EEPROM data contains the board name and its revision.
>> Add support for:
>> - Reading EEPROM data and store a copy at end of SRAM
>> - Updating env variable with relevant board info
>> - Printing board info during boot
>>
>> Use the generic do_board_detect_am6() and setup_serial_am6()
>> functions to avoid code duplication across AM6x family boards.
>>
>> Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
>> ---
>>   arch/arm/mach-k3/am62x/Kconfig |  3 +++
>>   board/ti/am62x/evm.c           | 54 
>> +++++++++++++++++++++++++++++++++++++++++-
>>   configs/am62x_evm_r5_defconfig |  1 +
>>   3 files changed, 57 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-k3/am62x/Kconfig 
>> b/arch/arm/mach-k3/am62x/Kconfig
>> index 81199ada3a1..f7ad52db7d8 100644
>> --- a/arch/arm/mach-k3/am62x/Kconfig
>> +++ b/arch/arm/mach-k3/am62x/Kconfig
>> @@ -14,6 +14,8 @@ config TARGET_AM625_A53_EVM
>>       select ARM64
>>       select BINMAN
>>       select OF_SYSTEM_SETUP
>> +    imply TI_COMMON_CMD_OPTIONS
>> +    imply TI_I2C_BOARD_DETECT
>>     config TARGET_AM625_R5_EVM
>>       bool "TI K3 based AM625 EVM running on R5"
>> @@ -25,6 +27,7 @@ config TARGET_AM625_R5_EVM
>>       select K3_DDRSS
>>       select BINMAN
>>       imply SYS_K3_SPL_ATF
>> +    imply TI_I2C_BOARD_DETECT
>>     config TARGET_PHYCORE_AM62X_A53
>>       bool "PHYTEC phyCORE-AM62x running on A53"
>> diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
>> index c2c7a0216b9..591324ecc15 100644
>> --- a/board/ti/am62x/evm.c
>> +++ b/board/ti/am62x/evm.c
>> @@ -22,8 +22,16 @@
>>   #include <dm/uclass.h>
>>   #include <asm/arch/k3-ddr.h>
>>   +#include "../common/board_detect.h"
>>   #include "../common/fdt_ops.h"
>>   +#define board_is_am62x_skevm()  (board_ti_k3_is("AM62-SKEVM") || \
>> +                 board_ti_k3_is("AM62B-SKEVM"))
>> +#define board_is_am62b_p1_skevm() board_ti_k3_is("AM62B-SKEVM-P1")
>> +#define board_is_am62x_lp_skevm() board_ti_k3_is("AM62-LP-SKEVM")
>> +#define board_is_am62x_sip_skevm() board_ti_k3_is("AM62SIP-SKEVM")
>> +#define board_is_am62x_play() board_ti_k3_is("BEAGLEPLAY-A0-")
>
> BeaglePlay is not a TI AM62x EVM variant, its support is handled
> separately over in board/beagle/beagleplay/, might be good to drop
> this line to avoid any confusion around how the board is supported.
yes sorry i forgot it i will fix in v3
>
> Andrew
>
>> +
>>   DECLARE_GLOBAL_DATA_PTR;
>>     #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
>> @@ -74,9 +82,53 @@ struct efi_capsule_update_info update_info = {
>>       .images = fw_images,
>>   };
>>   -#ifdef CONFIG_BOARD_LATE_INIT
>> +#if CONFIG_IS_ENABLED(TI_I2C_BOARD_DETECT)
>> +int checkboard(void)
>> +{
>> +    struct ti_am6_eeprom *ep = TI_AM6_EEPROM_DATA;
>> +
>> +    if (!do_board_detect_am6())
>> +        printf("Board: %s rev %s\n", ep->name, ep->version);
>> +
>> +    return 0;
>> +}
>> +
>> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
>> +static void setup_board_eeprom_env(void)
>> +{
>> +    char *name = "am62x_skevm";
>> +
>> +    if (do_board_detect_am6())
>> +        goto invalid_eeprom;
>> +
>> +    if (board_is_am62x_skevm())
>> +        name = "am62x_skevm";
>> +    else if (board_is_am62b_p1_skevm())
>> +        name = "am62b_p1_skevm";
>> +    else if (board_is_am62x_lp_skevm())
>> +        name = "am62x_lp_skevm";
>> +    else if (board_is_am62x_sip_skevm())
>> +        name = "am62x_sip_skevm";
>> +    else if (board_is_am62x_play())
>> +        name = "am62x_beagleplay";
>> +    else
>> +        printf("Unidentified board claims %s in eeprom header\n",
>> +               board_ti_get_name());
>> +
>> +invalid_eeprom:
>> +    set_board_info_env_am6(name);
>> +}
>> +#endif
>> +#endif
>> +
>> +#if CONFIG_IS_ENABLED(BOARD_LATE_INIT)
>>   int board_late_init(void)
>>   {
>> +    if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
>> +        setup_board_eeprom_env();
>> +        setup_serial_am6();
>> +    }
>> +
>>       ti_set_fdt_env(NULL, NULL);
>>       return 0;
>>   }
>> diff --git a/configs/am62x_evm_r5_defconfig 
>> b/configs/am62x_evm_r5_defconfig
>> index 18ffc991b25..d42bdf1f074 100644
>> --- a/configs/am62x_evm_r5_defconfig
>> +++ b/configs/am62x_evm_r5_defconfig
>> @@ -85,6 +85,7 @@ CONFIG_SPL_CLK_K3_PLL=y
>>   CONFIG_SPL_CLK_K3=y
>>   CONFIG_TI_SCI_PROTOCOL=y
>>   CONFIG_DA8XX_GPIO=y
>> +CONFIG_DM_I2C=y
>>   CONFIG_DM_MAILBOX=y
>>   CONFIG_K3_SEC_PROXY=y
>>   CONFIG_SPL_MISC=y
>>
>

