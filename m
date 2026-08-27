Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9280FC61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 19:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48F52607A8;
	Thu, 27 Aug 2026 19:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XHhC2GF9i7K2; Thu, 27 Aug 2026 19:50:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787860241;
	bh=NxS+oCp/6T0s1ymrtyu/LN6tc12yDwrQPBWfMg5vL3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IaU5PFbD1Ok68FE4aZBgejvXTiXRa5C8B8XexaPBPajAiOsvkLPWQR74W8EmjGnxR
	 0zFxMf95iPpmfjWoQEaij4GUccdnBBLJbXcECHEuvJBMBPS+EdxlUL6zI1J8wu/7MB
	 7YgEt2Ftuo1xF1tL22DP468tIxNxW6PfNlxYBxeFi6aDyXiFBa3qZnyRe1OFwkALBJ
	 9b3/DH1aLaDquWQwIuhcX7+vfYwVXF/pkAt6F7pC4BGaOrzyi+PLN7CiauoxG76E80
	 NdMi3XaYXTcG8A71HpVNVORmBjRsqA4stEQ439WnfMp6r3LA5FpsOx3kEWNieOjft9
	 rDl8gIB8YlYrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B377607A9;
	Thu, 27 Aug 2026 19:50:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 58228105
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:52:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3E53F80A9F
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:52:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VMXYsP1fpu2p for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:52:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f29; helo=mail-qv1-xf29.google.com;
 envelope-from=sanderson@brivo.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=brivo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=brivo.com header.i=@brivo.com
 header.a=rsa-sha256 header.s=google header.b=Jk8M2qPZ
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A82180A9B
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:52:23 +0000 (UTC)
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-90cc0e4c51aso767386d6.1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brivo.com; s=google; t=1787845942; x=1788450742;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NxS+oCp/6T0s1ymrtyu/LN6tc12yDwrQPBWfMg5vL3U=;
 b=Jk8M2qPZUfQAQGBX3EpgJ7O2k3U7ETlrGiTheMNxuAClzgVbP7XD2UlZCEGcHB3Sd2
 js3j9YkpwSurgkn6r2Gx7uIL5LD8P5YfFnfa0G4qo9AAS17qM8kOPMO9U3xWmUR8wdPB
 CobnHnh6b4BzARUQs3ZK5IwLBrMkmfTtx9SBNR6ab9YOhi5uUm8agjLjGAWbFQ/Ij5+B
 ToPye0ddEDBdtQqdUWN1xXF+1y+r6iMWAm5ICTKeq6UosLJlRoG9Vr6iAb7DiIxqqGwz
 iyNiN9d34J74lWS75X93cHVL46aA2ZL6YDZ0OjpyjfEtN4W/hTMJlXjX30pg1teGqa/6
 yx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845942; x=1788450742;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NxS+oCp/6T0s1ymrtyu/LN6tc12yDwrQPBWfMg5vL3U=;
 b=EeHB78MeeK3rtJrH5oskN81wDauI2yG8+JKr7sUXFEWKGB6c+zCZHXxaLm4rrfJVwl
 kwU2UAxLcZxs2Zn5IYJIXpNO9UZ7bt9UQCKaKBiSU6xG+HW6rZmSC6RwDmb3Mu9prtNL
 AJvbpztQM6Z9+Ib8sy9pRSMp/hmk7JN3qr0Qr5GfFJIigBqsHBgGESRfm0LaZNO6kbO6
 YTCCQlF3GJ8FwQsZI+mL7DMHtEC9Jgm00o8tBFBmFEZwSZPqItDnPbA6jKJMv2QfRqsh
 l48KDT0s1aVLeByvm2Da7nZswWX4d+eIpxZFIAW6cRo73s82RkuPO8qqCozOAucueVuo
 TmTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqUpl30b8yJs8wpK2tgipIKXeZiTqEOoLogM0RDjZ2B7ldRB0ZE+NcqRQhkxqUQkkbm4mn84jU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lI0i6dcmMDOU4xNJtIV/I3u6X3OoezzSSrirsJ0ljBHptMT0Ke
 ccRlCZ4wBEF77MEVC8jETGFZO2IJlLeRxf58W2EzZg6IB4Fgkx19knpFm83NLyEQAL7S7LZ3t66
 2h3bQN+ymbQP4sfFCeyR0d7foghhThEfcSZl2s4bplBOGIZEpStNdFTRxzN+Ycbc=
X-Gm-Gg: AR+sD12C4ytA3K3X+IVhtXpDGjFyvwF4Av/UosQVaLeVihiQ4aH/42Bype2RPAbPkmH
 Uq8LvHHUajYBcbuxEPJMQMFDB58NQDj8Ppqnnxrva8F5S0sxtSpsPQE+bvr7bb0elYUY6Um+on+
 H/tj+Log5ljVG7uL8fZ0kVnjFDuSdTwC6NkXegPe06sq8Eo4idXYt/WYhymuaAME5/YiOfjEADm
 G17hKhoepcZXX+43z6BdFjVd8ekl7L1J2SFYD1cpVqheuYZ1od9xVZwltweXpW8ZUU7yo9jUDN+
 3HR/27Sed9TT3FN4n7PV9rD0DQSn5CBOGDs32lJBEm/WS9zNPKViq8EYm1LToP4nfc48L4wT9Tr
 lIeYAQjHrTQSbY97khyPWb5Mp9xGD3/WjBfspQnIGUPQ+R77aDPO6RclIHMJmiL53k9HjDCxCfk
 qY7/nH7Mp1ku7iHHyqocWMQQzEpLRJHYOdWzoHz4nNDuSbbFF48HMkkkWuPwfA3ob0UG5Ctg535
 nxx
X-Received: by 2002:a05:6214:4497:b0:90c:d3be:7466 with SMTP id
 6a1803df08f44-90ce0c4294bmr2741536d6.12.1787845941469; 
 Thu, 27 Aug 2026 08:52:21 -0700 (PDT)
Received: from [10.200.233.210] ([71.163.254.246])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cd73fc28dsm19619976d6.34.2026.08.27.08.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:52:21 -0700 (PDT)
Message-ID: <2cdfec51-294d-43c3-832c-e49ac5fde186@brivo.com>
Date: Thu, 27 Aug 2026 11:52:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] [RFT] meson: Add Khadas VIM1S support
To: Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-10-sanderson@brivo.com>
 <5a690fd2-d02c-42fb-9113-658df02d44f1@linaro.org>
Content-Language: en-US
From: Sean Anderson <sanderson@brivo.com>
In-Reply-To: <5a690fd2-d02c-42fb-9113-658df02d44f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Aug 2026 19:50:39 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/27/26 11:40 AM, Neil Armstrong wrote:
> On 8/17/26 19:15, Sean Anderson wrote:
>> This adds basic support for the Khadas VIM1S [1]. I built this config on
>> a custom board, and I don't even own a vim1s. Please test!
>>
>> [1] https://www.khadas.com/vim1s
>>
>> Signed-off-by: Sean Anderson <sanderson@brivo.com>
>> ---
>>
>>   board/amlogic/q200/MAINTAINERS |  1 +
>>   configs/khadas-vim1s_defconfig | 80 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 81 insertions(+)
>>   create mode 100644 configs/khadas-vim1s_defconfig
>>
>> diff --git a/board/amlogic/q200/MAINTAINERS b/board/amlogic/q200/MAINTAINERS
>> index aece8d5e05c..5281e06f3cc 100644
>> --- a/board/amlogic/q200/MAINTAINERS
>> +++ b/board/amlogic/q200/MAINTAINERS
>> @@ -5,6 +5,7 @@ L:    u-boot-amlogic@groups.io
>>   F:    board/amlogic/q200/
>>   F:    include/configs/q200.h
>>   F:    configs/beelink-gt1-ultimate_defconfig
>> +F:    configs/khadas-vim1s_defconfig
>>   F:    configs/khadas-vim2_defconfig
>>   F:    configs/libretech-s905d-pc_defconfig
>>   F:    configs/libretech-s912-pc_defconfig
>> diff --git a/configs/khadas-vim1s_defconfig b/configs/khadas-vim1s_defconfig
>> new file mode 100644
>> index 00000000000..143425cd2ca
>> --- /dev/null
>> +++ b/configs/khadas-vim1s_defconfig
>> @@ -0,0 +1,80 @@
>> +CONFIG_ARM=y
>> +CONFIG_SYS_BOARD="q200"
>> +CONFIG_ARCH_MESON=y
>> +CONFIG_TEXT_BASE=0x0
>> +CONFIG_SYS_MALLOC_LEN=0x8000000
>> +CONFIG_NR_DRAM_BANKS=1
>> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x00200000
>> +CONFIG_ENV_SIZE=0x10000
>> +CONFIG_DM_GPIO=y
>> +CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-s4-s905y4-khadas-vim1s"
>> +CONFIG_OF_LIBFDT_OVERLAY=y
>> +CONFIG_DM_RESET=y
>> +CONFIG_MESON_S4=y
>> +CONFIG_SYS_LOAD_ADDR=0x1000000
>> +CONFIG_IDENT_STRING=" vim1s"
>> +# CONFIG_PSCI_RESET is not set
>> +CONFIG_ENV_VARS_UBOOT_CONFIG=y
>> +CONFIG_REMAKE_ELF=y
>> +CONFIG_FIT=y
>> +CONFIG_FIT_SIGNATURE=y
>> +CONFIG_FIT_VERBOSE=y
>> +# CONFIG_BOOTSTD is not set
>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>> +CONFIG_SUPPORT_RAW_INITRD=y
>> +# CONFIG_DISTRO_DEFAULTS is not set
>> +CONFIG_OF_BOARD_SETUP=y
>> +CONFIG_USE_BOOTARGS=y
>> +CONFIG_BOOTARGS="root=/dev/mmcblk1p2 ro rootwait"
>> +CONFIG_USE_BOOTCOMMAND=y
>> +CONFIG_BOOTCOMMAND="load mmc 1:1 $loadaddr linux.itb && bootm"
> 
> Why not leave the default boot command ?

This is just what I used for testing. I can remove it for v2.

>> +# CONFIG_DISPLAY_CPUINFO is not set
>> +CONFIG_MISC_INIT_R=y
>> +CONFIG_HUSH_PARSER=y
>> +CONFIG_SYS_MAXARGS=32
>> +# CONFIG_CMD_BDI is not set
>> +CONFIG_CMD_CLK=y
>> +CONFIG_CMD_GPIO=y
>> +CONFIG_CMD_GPT=y
>> +CONFIG_CMD_I2C=y
>> +# CONFIG_CMD_LOADS is not set
>> +CONFIG_CMD_MMC=y
>> +CONFIG_CMD_PART=y
>> +CONFIG_CMD_WDT=y
>> +# CONFIG_CMD_SETEXPR is not set
>> +CONFIG_CMD_DHCP=y
>> +CONFIG_CMD_MII=y
>> +CONFIG_CMD_PING=y
>> +CONFIG_CMD_PXE=y
>> +# CONFIG_CMD_DATE is not set
>> +CONFIG_CMD_RTC=y
>> +CONFIG_CMD_SYSBOOT=y
>> +CONFIG_CMD_EXT2=y
>> +CONFIG_CMD_EXT4=y
>> +CONFIG_CMD_FAT=y
>> +CONFIG_CMD_FS_GENERIC=y
>> +CONFIG_ISO_PARTITION=y
>> +CONFIG_OF_CONTROL=y
>> +CONFIG_OF_UPSTREAM=y
>> +CONFIG_DM_I2C=y
>> +CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
>> +CONFIG_SYS_I2C_MESON=y
>> +# CONFIG_INPUT is not set
>> +CONFIG_MMC_MESON_GX=y
>> +CONFIG_DM_MDIO=y
>> +CONFIG_DM_MDIO_MUX=y
>> +CONFIG_DM_ETH_PHY=y
>> +CONFIG_ETH_DESIGNWARE_MESON8B=y
>> +CONFIG_MDIO_MUX_MESON_G12A=y
>> +CONFIG_PHY_MESON_GXL=y
>> +CONFIG_PINCTRL=y
>> +CONFIG_PINCTRL_MESON_S4=y
>> +CONFIG_DM_RTC=y
>> +CONFIG_RTC_DS1337=y
>> +CONFIG_RTC_DS1337_NOOSC=y
>> +CONFIG_BAUDRATE=888888
>> +CONFIG_MESON_SERIAL=y
>> +CONFIG_WDT=y
>> +CONFIG_WDT_MESON_GXBB=y
>> +# CONFIG_TOOLS_MKEFICAPSULE is not set
> 

