Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5993BC001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 13:22:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEED986932;
	Wed, 16 Aug 2023 15:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="wqJGnS16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D0DF869B8; Wed, 16 Aug 2023 15:22:32 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E96C586784
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 15:22:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6592a39e51=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37G9C4NV021292; Wed, 16 Aug 2023 15:22:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=7/b19q2mI6KhGNDBWvUC+0R8pSxIBh1b2/VvQi80ioI=; b=wq
 JGnS1634AyBX5N7JFYvNafozb/SMYKbyCtf1vHYdOtriAPXc5T1Px3S4dUkvfkCZ
 2SFAzAUnxZ2iNsEjeJq+MEze1tl5OebbTB5AAGM/oa23QlTe4EoAg2INveLyg6Nu
 jyEC5U6gAyKBD4SmkJQW3fl4TmwAf9vFtdLmFFcdphY7GtwGP7ZFo3YWVonbuk/U
 vnmV/BgHdHbyWGLVbCRCkyXakN9Z0EKdMKve0Shr7JU0LeTnzNUN4+i6G9q5XlEq
 TCbJ2lkSn2INPLjplHux3uXkKdLkZd0bW4UYtUBVNhkJWWw4d79GzBK1+HBus8f0
 i3nMP/WpZ5nACEfLRCKQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sgum7hdkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 16 Aug 2023 15:22:19 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8F1CA10005D;
 Wed, 16 Aug 2023 15:22:18 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 81D6A23D413;
 Wed, 16 Aug 2023 15:22:18 +0200 (CEST)
Received: from [10.201.20.38] (10.201.20.38) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 16 Aug
 2023 15:22:17 +0200
Message-ID: <fe65f376-a188-3f72-b6f8-58bd2a65542c@foss.st.com>
Date: Wed, 16 Aug 2023 15:22:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: stm32: Power cycle Buck3 in reset on DHSOM
To: Marek Vasut <marex@denx.de>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@dh-electronics.com>,
 <christophe.priouzeau@foss.st.com>
References: <20230517220239.329807-1-marex@denx.de>
 <e171b09d-0e7d-1815-6133-0946212a08d9@foss.st.com>
 <607a112c-4320-5a5f-b988-98e5ea8e3267@denx.de>
 <cb59086b-3212-3b46-990f-c8223a6122a4@denx.de>
 <f418e766-9063-496d-dd5c-05758cbabd38@foss.st.com>
 <bba7dcb0-285a-f3ed-1dcb-d631466c1ee2@denx.de>
 <40efc460-899d-f4d6-e79f-5c0e635f4387@denx.de>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <40efc460-899d-f4d6-e79f-5c0e635f4387@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.38]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_12,2023-08-15_02,2023-05-22_02
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



On 7/10/23 23:43, Marek Vasut wrote:
> On 6/17/23 02:36, Marek Vasut wrote:
>> On 6/16/23 15:04, Patrick DELAUNAY wrote:
>>> Hi,
>>
>> Hi,
>>
>>>> [   39.426015] Disabling non-boot CPUs ...
>>>> [   39.448635] Retrying again to check for CPU kill
>>>> [   39.451909] CPU1 killed.
>>>> U-Boot SPL 2023.07-rc4-00008-g2f4664f5c3e (Jun 15 2023 - 08:36:52 +0200)
>>>> RAM: DDR3-DDR3L 32bits 533000kHz
>>>> DDR invalid size : 0x4, expected 0x40000000
>>>> DRAM init failed: -22
>>>> ### ERROR ### Please RESET the board ###
>>>>
>>>> Press RESET button
>>>>
>>>> U-Boot SPL 2023.07-rc4-00008-g2f4664f5c3e (Jun 15 2023 - 08:36:52 +0200)
>>>> RAM: DDR3-DDR3L 32bits 533000kHz
>>>> DDR invalid size : 0x4, expected 0x40000000
>>>> DRAM init failed: -22
>>>> ### ERROR ### Please RESET the board ###
>>>>
>>>>
>>> I try it with the latest STMicroelectronics OSS image.
>>>
>>> I just change in U-Boot config to be aligned the expected SD-Card partionning
>>>
>>> configs/stm32mp15_basic_defconfig:
>>>
>>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
>>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=5
>>>
>>> But low power is not supported in this downstream config :-<
>>
>> Use multi_v7_defconfig or some such ?
>>
>>> I got the error:
>>>
>>>
>>> .......
>>> U-Boot SPL 2023.07-rc4-00008-g2f4664f5c3ed-dirty (Jun 16 2023 - 11:37:52 +0200)
>>> RAM: DDR3-DDR3L 32bits 533000kHz
>>> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s timeout)
>>> image entry point: 0xc0100000
>>>
>>>
>>> U-Boot 2023.07-rc4-00008-g2f4664f5c3ed-dirty (Jun 16 2023 - 11:37:52 +0200)
>>>
>>> CPU: STM32MP157FAA Rev.Z
>>> Model: STMicroelectronics STM32MP157C eval daughter on eval mother
>>> Board: stm32mp1 in basic mode (st,stm32mp157c-ev1)
>>> Board: MB1263 Var4.0 Rev.C-03
>>> DRAM:  1 GiB
>>> Clocks:
>>> - MPU : 800 MHz
>>> - MCU : 208.878 MHz
>>> - AXI : 266.500 MHz
>>> - PER : 24 MHz
>>> - DDR : 533 MHz
>>> Core:  288 devices, 42 uclasses, devicetree: separate
>>> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s timeout)
>>> NAND:  1024 MiB
>>> MMC:   STM32 SD/MMC: 0, STM32 SD/MMC: 1
>>> Loading Environment from MMC... Invalid ENV offset in MMC, copy=0
>>> In:    serial
>>> Out:   serial
>>> Err:   serial
>>> Net:   eth0: ethernet@5800a000
>>> Hit any key to stop autoboot:  0
>>>
>>> ....
>>> [    0.000000] Booting Linux on physical CPU 0x0
>>> [    0.000000] Linux version 6.4.0-rc6 (oe-user@oe-host) (arm-ostl-linux-gnueabi-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.40.20230119) #1 SMP PREEMPT Sun Jun 11 21:35:30 UTC 2023
>>> ....
>>> root@stm32mp1-disco-oss:~# while true ; do rtcwake -s 100 -m mem ; done
>>> rtcwake: unrecognized suspend state 'mem'
>>
>> Please fix your kernel config and enable suspend to mem, I am sure that is not difficult.
>>
>>> I check also with downstream (OpenSTLinux V4.0),
>>
>> This is not relevant to this discussion.
>>
>>> and I can't reproduced the issue but we are using TF-A  / OP-TEE / SCMI to support all the low power modes.
>>>
>>>
>>> And this low power support (in TF-A/ OP-TEE / Linux with SCMI) is not yet up streamed.
>>>
>>>
>>> PS: if you are not able to restart even after a RESET,
>>>        I assume something is wrong in the PMIC configuration
>>>
>>>        (for example in NVM or in initial regulator configuration)
>>>
>>>        so you have no power cycle on DDR during reset...
>>>
>>>         => something is wrong in PMIC configuration in linux ?
>>
>> Possibly, but then it is also something wrong on STM32MP157C EV1, because I can reproduce the failure on EV1 too. I specifically did check this on the EV1. Please fix your kernel config and try again, then you should be able to see it yourself.
> 
> Has there been any news on this defect of EV1 or has this been ignored by ST ?

Hi Marek

Sorry for the delay,

Patch applied on stm32-master

Thanks
Patrice
