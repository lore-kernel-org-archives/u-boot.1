Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E368CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:38:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C682D86D01;
	Thu, 12 Oct 2023 04:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1697077730;
	bh=CTYrLo/Tab4P/z3iSlwnJgvCZb5gn41sja33LOKnZKw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kAJdb0i1ublOGcnTegh3qFH3acqMFVzLIVIEHuusOtHcWgiEHTnlgZniEfWX8Z93U
	 YGIZKirTi8leesx/Cp146/MhmxAOv9yzHOskP/kL+9J6eE6H1A+4ZfiecBDIBq1kdG
	 1f+giIlglEqth8RWOe6Unuyz+02wefToLD/IBWsmd7wIQKjwd4vz9hN+pLKeuBTywa
	 WLdFKu9jD4mUiDSw2JvlbEHRt92RfIykH0JxOEAsRT7WC8pMEVWYDRDrfcExDOwt4p
	 yNSNIFkdgxtxBAiXM129n8L+eAaTPyvy0sLMb1p9pb0EZWTdbrfpmFpXyWwQ9M+qIi
	 Q9+lRbgvzo7DQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4D14386B36;
 Thu, 12 Oct 2023 04:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1697077729;
 bh=CTYrLo/Tab4P/z3iSlwnJgvCZb5gn41sja33LOKnZKw=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=Qnztq23X8bJPlC78kZ+aVnzwsWWZC8/jizW1eHswnUl2MKbOKYm3467ewNEUIZNDT
 Pj7BXhCCKmwfim5emNV/r6ptNQIUmzbpNs0w0CJ+UfT0W6TQMUMb4BoE6+CRIyYpm+
 7weVpdE5u5zf0v3q0MIK9nr6GhXXrUipAwI5SH+OnlPeJmBbc1a/uTm5ioIZ4fKyjx
 szuxf7pdOQA+yn3oAG0OIXHtekfyIacdxe8CjVlMP8OVUpz30ToAaCxwVHfR4eyQKT
 KEQjvBQ9qOoMBcCo3Yf00wAAGHyg/DYz+7C1tL/WsrgCxWsavcX+1ndWZOGkBywnBZ
 OJwOz75YLHLyQ==
Message-ID: <aa9347dc-9d2e-48af-b8be-5b0db4d398db@denx.de>
Date: Thu, 12 Oct 2023 04:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: stm32: Power cycle Buck3 in reset on DHSOM
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@dh-electronics.com,
 christophe.priouzeau@foss.st.com
References: <20230517220239.329807-1-marex@denx.de>
 <e171b09d-0e7d-1815-6133-0946212a08d9@foss.st.com>
 <607a112c-4320-5a5f-b988-98e5ea8e3267@denx.de>
 <cb59086b-3212-3b46-990f-c8223a6122a4@denx.de>
 <f418e766-9063-496d-dd5c-05758cbabd38@foss.st.com>
 <bba7dcb0-285a-f3ed-1dcb-d631466c1ee2@denx.de>
 <40efc460-899d-f4d6-e79f-5c0e635f4387@denx.de>
 <fe65f376-a188-3f72-b6f8-58bd2a65542c@foss.st.com>
 <532a3a0c-389f-6945-9a20-0a523caebeae@denx.de>
In-Reply-To: <532a3a0c-389f-6945-9a20-0a523caebeae@denx.de>
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

On 8/16/23 15:28, Marek Vasut wrote:
> On 8/16/23 15:22, Patrice CHOTARD wrote:
>>
>>
>> On 7/10/23 23:43, Marek Vasut wrote:
>>> On 6/17/23 02:36, Marek Vasut wrote:
>>>> On 6/16/23 15:04, Patrick DELAUNAY wrote:
>>>>> Hi,
>>>>
>>>> Hi,
>>>>
>>>>>> [   39.426015] Disabling non-boot CPUs ...
>>>>>> [   39.448635] Retrying again to check for CPU kill
>>>>>> [   39.451909] CPU1 killed.
>>>>>> U-Boot SPL 2023.07-rc4-00008-g2f4664f5c3e (Jun 15 2023 - 08:36:52 
>>>>>> +0200)
>>>>>> RAM: DDR3-DDR3L 32bits 533000kHz
>>>>>> DDR invalid size : 0x4, expected 0x40000000
>>>>>> DRAM init failed: -22
>>>>>> ### ERROR ### Please RESET the board ###
>>>>>>
>>>>>> Press RESET button
>>>>>>
>>>>>> U-Boot SPL 2023.07-rc4-00008-g2f4664f5c3e (Jun 15 2023 - 08:36:52 
>>>>>> +0200)
>>>>>> RAM: DDR3-DDR3L 32bits 533000kHz
>>>>>> DDR invalid size : 0x4, expected 0x40000000
>>>>>> DRAM init failed: -22
>>>>>> ### ERROR ### Please RESET the board ###
>>>>>>
>>>>>>
>>>>> I try it with the latest STMicroelectronics OSS image.
>>>>>
>>>>> I just change in U-Boot config to be aligned the expected SD-Card 
>>>>> partionning
>>>>>
>>>>> configs/stm32mp15_basic_defconfig:
>>>>>
>>>>> -CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=3
>>>>> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=5
>>>>>
>>>>> But low power is not supported in this downstream config :-<
>>>>
>>>> Use multi_v7_defconfig or some such ?
>>>>
>>>>> I got the error:
>>>>>
>>>>>
>>>>> .......
>>>>> U-Boot SPL 2023.07-rc4-00008-g2f4664f5c3ed-dirty (Jun 16 2023 - 
>>>>> 11:37:52 +0200)
>>>>> RAM: DDR3-DDR3L 32bits 533000kHz
>>>>> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s 
>>>>> timeout)
>>>>> image entry point: 0xc0100000
>>>>>
>>>>>
>>>>> U-Boot 2023.07-rc4-00008-g2f4664f5c3ed-dirty (Jun 16 2023 - 
>>>>> 11:37:52 +0200)
>>>>>
>>>>> CPU: STM32MP157FAA Rev.Z
>>>>> Model: STMicroelectronics STM32MP157C eval daughter on eval mother
>>>>> Board: stm32mp1 in basic mode (st,stm32mp157c-ev1)
>>>>> Board: MB1263 Var4.0 Rev.C-03
>>>>> DRAM:  1 GiB
>>>>> Clocks:
>>>>> - MPU : 800 MHz
>>>>> - MCU : 208.878 MHz
>>>>> - AXI : 266.500 MHz
>>>>> - PER : 24 MHz
>>>>> - DDR : 533 MHz
>>>>> Core:  288 devices, 42 uclasses, devicetree: separate
>>>>> WDT:   Started watchdog@5a002000 with servicing every 1000ms (32s 
>>>>> timeout)
>>>>> NAND:  1024 MiB
>>>>> MMC:   STM32 SD/MMC: 0, STM32 SD/MMC: 1
>>>>> Loading Environment from MMC... Invalid ENV offset in MMC, copy=0
>>>>> In:    serial
>>>>> Out:   serial
>>>>> Err:   serial
>>>>> Net:   eth0: ethernet@5800a000
>>>>> Hit any key to stop autoboot:  0
>>>>>
>>>>> ....
>>>>> [    0.000000] Booting Linux on physical CPU 0x0
>>>>> [    0.000000] Linux version 6.4.0-rc6 (oe-user@oe-host) 
>>>>> (arm-ostl-linux-gnueabi-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 
>>>>> 2.40.20230119) #1 SMP PREEMPT Sun Jun 11 21:35:30 UTC 2023
>>>>> ....
>>>>> root@stm32mp1-disco-oss:~# while true ; do rtcwake -s 100 -m mem ; 
>>>>> done
>>>>> rtcwake: unrecognized suspend state 'mem'
>>>>
>>>> Please fix your kernel config and enable suspend to mem, I am sure 
>>>> that is not difficult.
>>>>
>>>>> I check also with downstream (OpenSTLinux V4.0),
>>>>
>>>> This is not relevant to this discussion.
>>>>
>>>>> and I can't reproduced the issue but we are using TF-A  / OP-TEE / 
>>>>> SCMI to support all the low power modes.
>>>>>
>>>>>
>>>>> And this low power support (in TF-A/ OP-TEE / Linux with SCMI) is 
>>>>> not yet up streamed.
>>>>>
>>>>>
>>>>> PS: if you are not able to restart even after a RESET,
>>>>>         I assume something is wrong in the PMIC configuration
>>>>>
>>>>>         (for example in NVM or in initial regulator configuration)
>>>>>
>>>>>         so you have no power cycle on DDR during reset...
>>>>>
>>>>>          => something is wrong in PMIC configuration in linux ?
>>>>
>>>> Possibly, but then it is also something wrong on STM32MP157C EV1, 
>>>> because I can reproduce the failure on EV1 too. I specifically did 
>>>> check this on the EV1. Please fix your kernel config and try again, 
>>>> then you should be able to see it yourself.
>>>
>>> Has there been any news on this defect of EV1 or has this been 
>>> ignored by ST ?
>>
>> Hi Marek
> 
> Hi,
> 
>> Sorry for the delay,
> 
> No worries.
> 
> What I am more concerned about is -- why is this problem present on EV1 
> too and how to solve it there ? (and no, "add more unnecessary software 
> to the stack to cover this up" is not the answer)

I ran into this defect again, it seems the EV1 problem is ignored by ST, 
or are there any news ?
