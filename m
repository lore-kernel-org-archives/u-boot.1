Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8738AC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 07:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 056CA880A5;
	Fri, 21 Jun 2024 09:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="d0acPmc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA9E48816D; Fri, 21 Jun 2024 09:49:57 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE44987DEB
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so2007606a12.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 00:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718956195; x=1719560995; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pzfmAcaP300TNvRV18SAOfnr8piwlXJKzsPhucPZ2n0=;
 b=d0acPmc3mTRsuqula6FA2mTqAViBMqU2vJTEJc1QU7ftm1CrSBHSW0WnFZwZaSOT0L
 u1G5Nv6chSBkQVfw173SFKHO7QSzAY7MGJx6t0gmR8B5NkE63WtHKPXFjSqLPM+v9vf4
 KY63NWG2BYFUuAnFRR2XwQQFpDx5bdFqNnKMwUPkIDYRYrU2GGgjZfcNcYd2gdC5t4qR
 Mb2iZwRi14F/A/FQeHDltbFFBmsJFR+AYbLUqae0PCne1bzr4fYDX8qk/bZgQD1yCtE0
 9Mqyc/XLJvq515sOIhkKBKLULUKpEkKrSQnCGPlEECUsNcJtsb3/2wxsTEpuD37bXuxu
 earg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718956195; x=1719560995;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pzfmAcaP300TNvRV18SAOfnr8piwlXJKzsPhucPZ2n0=;
 b=Qbz7mCf7DYh3t+29K64aqctP5ckuIXDGh6qe2ufzlN6HMabcJa+ScGXqBpZhxs3zmF
 633t47os1drh4Nz82RwVRUcZ4O70L8shyqnsXLvji+3rAPgo6IyWjDOxYOMNUYIj/tB9
 lz9agram7Q1OgyX3gaz/iJnDtkMN2ZsLTgy779HA+6lYteEsngLYJ5uzAjV1SX8vXwXB
 9f29QpJE4Pbsawsa8qHleMdPEcia+sJxu/OAMoqg7wjIg188SsmawanOVr34o1mecRLL
 GKYB5EcPx6Co+GL44UCg4eEN1t69SKVHQURnwHjeaBneEMbqxFYDR87Rhs9kikTRF8eq
 PDMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVG8P/yaERalZndeCMlxY8Q7mxPgVxlgmnbk9JcfqUCkgAAH7pgKaUX0Y1ZthTvQGpNIhl7EhL8kN3FZwBbTXT9zgmW+A==
X-Gm-Message-State: AOJu0YwhmvNGUaHJVhVBWAa37xsBedSFj6jj8DeMat6hOsYBCJZxquos
 OaeIVrtBYW68LkJE2qVFP8/EFM87Kh9bRS+cTD+6wSZtAjM5dPBuX2NSkuDbsbo=
X-Google-Smtp-Source: AGHT+IE0V7VM3zBZ3izyQxLUN0UfDG8LwtzQRSYR3goCysLPZwIxVyZENXLtBPRXQc/UVBRocFoQdQ==
X-Received: by 2002:a05:6402:1805:b0:57d:101f:ae97 with SMTP id
 4fb4d7f45d1cf-57d101fb047mr5136576a12.31.1718956194928; 
 Fri, 21 Jun 2024 00:49:54 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::ebdd? ([2a02:8109:aa0d:be00::ebdd])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3040f636sm567712a12.22.2024.06.21.00.49.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 00:49:54 -0700 (PDT)
Message-ID: <d64e6ce3-0bc5-4175-af7c-6146d4402c60@linaro.org>
Date: Fri, 21 Jun 2024 09:49:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: move default environment to a file
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20240617085629.1744017-1-caleb.connolly@linaro.org>
 <CAFA6WYM1Rah1=Ktxk-64YhhwLQV7m9D0ixvErcMh7DDv7ssgVg@mail.gmail.com>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAFA6WYM1Rah1=Ktxk-64YhhwLQV7m9D0ixvErcMh7DDv7ssgVg@mail.gmail.com>
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



On 21/06/2024 09:35, Sumit Garg wrote:
> Hi Caleb,
> 
> On Mon, 17 Jun 2024 at 14:26, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>>
>> Make use of CONFIG_DEFAULT_ENV_FILE and move the default qcom
>> environment to a file under board/qualcomm.
>>
>> This is much cleaner and means we don't need to recompile on changing
>> the environment.
>>
>> Additionally, extend the environment to include a boot menu and
>> auto-boot using EFI instead of bootm. Since we now support MMC and USB
>> on most platforms, these are much more useful defaults.
>>
>> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
>> ---
>>   board/qualcomm/default.env | 12 ++++++++++++
>>   configs/qcom_defconfig     |  2 ++
>>   include/configs/qcom.h     |  7 -------
>>   3 files changed, 14 insertions(+), 7 deletions(-)
>>   create mode 100644 board/qualcomm/default.env
>>
>> diff --git a/board/qualcomm/default.env b/board/qualcomm/default.env
>> new file mode 100644
>> index 000000000000..243aede77be7
>> --- /dev/null
>> +++ b/board/qualcomm/default.env
>> @@ -0,0 +1,12 @@
>> +stdin=serial,button-kbd
>> +stdout=serial,vidconsole
>> +stderr=serial,vidconsole
>> +bootfile=/extlinux/extlinux.conf
> 
> Is this file used to perform EFI boot or is it redundantly copied from
> somewhere?

This is here because there's a bunch of codepaths in U-Boot that 
implicitly expect the bootfile environment variable to have something 
useful in. It stops a whole class of null pointer exceptions.

extlinux isn't used for EFI booting, but it's supported, and having a 
sensible default here is nice-to-have regardless.

Kind regards,
> 
> -Sumit
> 
>> +preboot=scsi scan; usb start
>> +fastboot=fastboot -l $fastboot_addr_r usb 0
>> +do_boot=bootefi bootmgr
>> +bootmenu_0=Boot first available device=run do_boot
>> +bootmenu_1=Enable fastboot mode=run fastboot
>> +bootmenu_2=Reset device=reset
>> +menucmd=bootmenu
>> +bootcmd=run do_boot
>> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
>> index 80ad3b32e139..a9e3797bb39a 100644
>> --- a/configs/qcom_defconfig
>> +++ b/configs/qcom_defconfig
>> @@ -35,8 +35,10 @@ CONFIG_CMD_BMP=y
>>   CONFIG_CMD_LOG=y
>>   CONFIG_OF_LIVE=y
>>   CONFIG_OF_BOARD_SETUP=y
>>   CONFIG_BUTTON_QCOM_PMIC=y
>> +CONFIG_USE_DEFAULT_ENV_FILE=y
>> +CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>>   CONFIG_CLK=y
>>   CONFIG_CLK_QCOM_QCM2290=y
>>   CONFIG_CLK_QCOM_QCS404=y
>>   CONFIG_CLK_QCOM_SDM845=y
>> diff --git a/include/configs/qcom.h b/include/configs/qcom.h
>> index e50b3bce5cdd..5b5ebbd844df 100644
>> --- a/include/configs/qcom.h
>> +++ b/include/configs/qcom.h
>> @@ -10,12 +10,5 @@
>>   #define __CONFIGS_SNAPDRAGON_H
>>
>>   #define CFG_SYS_BAUDRATE_TABLE { 115200, 230400, 460800, 921600 }
>>
>> -/* Load addressed are calculated during board_late_init(). See arm/mach-snapdragon/board.c */
>> -#define CFG_EXTRA_ENV_SETTINGS \
>> -       "stdin=serial,button-kbd\0"     \
>> -       "stdout=serial,vidconsole\0"    \
>> -       "stderr=serial,vidconsole\0" \
>> -       "bootcmd=bootm $prevbl_initrd_start_addr\0"
>> -
>>   #endif
>> --
>> 2.45.0
>>

-- 
// Caleb (they/them)
