Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A73AC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 07:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB8487B43;
	Thu, 18 Jan 2024 08:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="oHCS8Ayi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BEA787B85; Thu, 18 Jan 2024 08:05:40 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D653E877FE
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 08:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=17471e100a=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40I5hXfB022593; Thu, 18 Jan 2024 08:05:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=
 selector1; bh=Hzt+UWrHyb0o3a0pcDYfxzTSrcrhZyVVzEwCvNjg8UM=; b=oH
 CS8AyiRS7FvC3qAYjFso2y+dCFhcDiQYI/7UakMWdXjF3JwklKEzn8OZ0zj2eh/W
 a6q5gzNN7b8OI1ur7rlt691mprajczansAFNOMfbyfUFyEA0EU+0rdRry3IYJdGY
 LxLx/DTlszq8VOYKQF57i0aaiXbDSZ09vpgV9o2JAxd2fgwAX9MUTujNpsXaxKin
 agE9mL5mo+aIasKT+IhiCa7IqRMLIN1w5Q8kO+8RUJlI573xv9MmWUr48KTDVrko
 IAxwRHI4OZw6wi8hc7LR3Ka7lF2CBWz94SbYRG48jEaGMzoi8UTp52oDoCqchZL0
 VcoICFgUqLPwEpCMZj3A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vkmbhf45s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jan 2024 08:05:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0E35E10007D;
 Thu, 18 Jan 2024 08:05:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 026BB2128BB;
 Thu, 18 Jan 2024 08:05:17 +0100 (CET)
Received: from [10.201.20.205] (10.201.20.205) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 18 Jan
 2024 08:05:16 +0100
Message-ID: <f6e43c8e-9cc3-4edf-bef2-425092d9d43e@foss.st.com>
Date: Thu, 18 Jan 2024 08:05:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, Francis Laniel
 <francis.laniel@amarulasolutions.com>
CC: Tom Rini <trini@konsulko.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>, Michael Nazzareno
 Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <2170847.irdbgypaU6@pwmachine>
 <3033df6b-e9c2-41e7-a83e-4c3200268629@foss.st.com>
 <12363012.O9o76ZdvQC@pwmachine> <20240117173912.GA4046@francesco-nb>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240117173912.GA4046@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.205]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_03,2024-01-17_01,2023-05-22_02
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



On 1/17/24 18:39, Francesco Dolcini wrote:
> On Thu, Jan 18, 2024 at 12:30:42AM +0700, Francis Laniel wrote:
>> Le mercredi 17 janvier 2024, 17:05:28 +07 Patrice CHOTARD a écrit :
>>> On 1/16/24 18:25, Francis Laniel wrote:
>>>> Le mardi 16 janvier 2024, 00:34:24 +07 Patrice CHOTARD a écrit :
>>>>> On 1/11/24 18:04, Francesco Dolcini wrote:
>>>>>> On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
>>>>>>> Le jeudi 28 décembre 2023, 21:58:59 CET Tom Rini a écrit :
>>>>>>>> On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
>>>>>>>>> During 2021 summer, Sean Anderson wrote a contribution to add a new
>>>>>>>>> shell,
>>>>>>>>> based on LIL, to U-Boot [1, 2].
>>>>>>>>> While one of the goals of this contribution was to address the fact
>>>>>>>>> actual
>>>>>>>>> U-Boot shell, which is based on Busybox hush, is old there was a
>>>>>>>>> discussion
>>>>>>>>> about adding a new shell versus updating the actual one [3, 4].
>>>>>>>>>
>>>>>>>>> So, in this series, with Harald Seiler, we updated the actual U-Boot
>>>>>>>>> shell
>>>>>>>>> to reflect what is currently in Busybox source code.
>>>>>>>>> Basically, this contribution is about taking a snapshot of Busybox
>>>>>>>>> shell/hush.c file (as it exists in commit 37460f5da) and adapt it to
>>>>>>>>> suit
>>>>>>>>> U-Boot needs.
>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>
>>>>>>>> Applied to u-boot/next, thanks!
>>>>>>>
>>>>>>> Thank you for the merge!
>>>>>>> If there is any problem, do not hesitate to mail me and I will take
>>>>>>> care
>>>>>>> of
>>>>>>> it!
>>>>>>
>>>>>> This change, specifically setting the modern hush shell as default, is
>>>>>> breaking our boot script, just noticed since the current U-Boot master
>>>>>> has a regression for us.
>>>>>>
>>>>>> We still need to figure out the exact details, here [1] you can find the
>>>>>> boot script (that has some placeholder that is replaced during build).
>>>>>>
>>>>>> and the error is something like:
>>>>>>
>>>>>> ```
>>>>>> ## Executing script at 90280000
>>>>>> Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
>>>>>> 69025 bytes read in 11 ms (6 MiB/s)
>>>>>> 82 bytes read in 9 ms (8.8 KiB/s)
>>>>>> Working FDT set to 90200000
>>>>>> syntax error at 'done'HUSH died!
>>>>>> resetting ...
>>>>>> ```
>>>>>>
>>>>>> that I _assume_ comes from this line
>>>>>>
>>>>>>     env set set_apply_overlays 'env set apply_overlays "for overlay_file
>>>>>>     in \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} &&
>>>>>>     ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} &&
>>>>>>     fdt apply \\${loadaddr}; env set overlay_file; done; true"'>
>>>>>>
>>>>>> [1]
>>>>>> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-bs
>>>>>> p
>>>>>> /u-boot/u-boot-distro-boot/boot.cmd.in
>>>>>>
>>>>>> Francesco
>>>>>
>>>>> Hi all
>>>>>
>>>>> I observed a similar issue with STM32MP157c-DK2 board.
>>>>> Since commit 78912cfde281 ("cmd: Set modern hush as default shell")
>>>>> U-Boot
>>>>> crashes :
>>>>>
>>>>>
>>>>> U-Boot 2024.01-00486-g697758e7c81-dirty (Jan 15 2024 - 18:23:52 +0100)
>>>>>
>>>>> CPU: STM32MP157CAC Rev.B
>>>>> Model: STMicroelectronics STM32MP157C-DK2 Discovery Board
>>>>> Board: stm32mp1 in trusted mode (st,stm32mp157c-dk2)
>>>>> Board: MB1272 Var2.0 Rev.C-01
>>>>> DRAM:  512 MiB
>>>>> Clocks:
>>>>> - MPU : 650 MHz
>>>>> - MCU : 208.878 MHz
>>>>> - AXI : 266.500 MHz
>>>>> - PER : 24 MHz
>>>>> - DDR : 533 MHz
>>>>> optee optee: OP-TEE: revision 4.0 (e92de4ca)
>>>>> I/TC: Reserved shared memory is disabled
>>>>> I/TC: Dynamic shared memory is enabled
>>>>> I/TC: Normal World virtualization support is disabled
>>>>> I/TC: Asynchronous notifications are disabled
>>>>> Core:  311 devices, 40 uclasses, devicetree: board
>>>>> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s
>>>>> timeout)
>>>>> NAND:  0 MiB
>>>>> MMC:   STM32 SD/MMC: 0
>>>>> Loading Environment from MMC... OK
>>>>> In:    No input devices available!
>>>>> Out:   No output devices available!
>>>>> Err:   No error devices available!
>>>>> Net:   eth0: ethernet@5800a000
>>>>> Hit any key to stop autoboot:  0
>>>>> Boot over mmc0!
>>>>> switch to partitions #0, OK
>>>>> mmc0 is current device
>>>>> Scanning mmc 0:8...
>>>>> data abort
>>>>> pc : [<ddb3f77a>]          lr : [<ddb44c95>]
>>>>> reloc pc : [<c012777a>]    lr : [<c012cc95>]
>>>>> sp : dbafc848  ip : ddbfc578     fp : ddbedf18
>>>>> r10: 00000000  r9 : dbb15e70     r8 : 00000000
>>>>> r7 : dbb5bf98  r6 : dbb5de10     r5 : dbb5bf98  r4 : ddbeda78
>>>>> r3 : dbb5dc08  r2 : 000033f8     r1 : 00000071  r0 : ddbede00
>>>>> Flags: nzcv  IRQs off  FIQs off  Mode SVC_32 (T)
>>>>> Code: 3138 1c48 f854 0030 (eb04) 05c1
>>>>> Resetting CPU ...
>>
>> I will take a look at the issue, trying to reproduce it and understand the 
>> root cause.
>> I cannot give you any ETA for the fix, so for now I can only advise you to 
>> stick with the old parser.
> 
> Should we revert the change that set the modern hush shell as default
> till this is fixed?
> 
> This is preventing us to run our automated test suite against current
> master. Whatever other issue might be introduced we will not be able to
> report.
> 
> Tom?
> 
> Francesco
> 
> 

Hi 

fully agree with Francesco's proposal.

Thanks
Patrice
