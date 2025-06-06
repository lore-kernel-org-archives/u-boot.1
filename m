Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A326C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 09:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83AEF81FEE;
	Fri,  6 Jun 2025 11:47:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="XD4ZPUka";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFDAB828F8; Fri,  6 Jun 2025 11:47:15 +0200 (CEST)
Received: from mail-m155105.qiye.163.com (mail-m155105.qiye.163.com
 [101.71.155.105])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AE02803DF
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 11:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTP id 17c46c1be;
 Fri, 6 Jun 2025 17:47:07 +0800 (GMT+08:00)
Message-ID: <ef361244-b5ec-4125-8539-bd7fd83cd747@rock-chips.com>
Date: Fri, 6 Jun 2025 17:47:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: px30: Implement checkboard() to print SoC
 variant
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Heiko Stuebner <heiko@sntech.de>,
 u-boot@lists.denx.de
References: <20250528-px30-identify-variant-v1-1-4ea69c527a0d@cherry.de>
 <b9a85c5c-ddbc-4c67-ba29-52a4cb7bcbe3@rock-chips.com>
 <55c63b2e-baac-457d-b6d5-b03eba4d30c8@cherry.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <55c63b2e-baac-457d-b6d5-b03eba4d30c8@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGE5KVk0YGEwYH0JCGBlCGlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a9744a3102e03afkunm89869c9e1f9c3c
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhw6GRw4HzErAxhIORQIMkgJ
 HxQwCj5VSlVKTE9CSUtISUlCSUpOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQU9PSU83Bg++
DKIM-Signature: a=rsa-sha256;
 b=XD4ZPUkas/4uGCxiNzGpxTPwV2dT5MhTjJ2nOrJ+4n9blQ588qdaOJqwxFwXRMzkpObArmzrIidPmZPT07lVbWnpOocHOV4O+kL/IsMo+JJUIcKdYLyLYP9lIn8oQKekCsIAA9yekYWTZGMBBS8o7fN6JI4Gfm8c+gIS6Ks+JQw=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=2INFFGw2K4rVnlE2PY3su0gA82SW0MFwNTGKnyz+crs=;
 h=date:mime-version:subject:message-id:from;
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

Hi Quentin,

On 2025/6/6 17:15, Quentin Schulz wrote:
> Hi Kever,
>
> On 6/6/25 11:09 AM, Kever Yang wrote:
>> Hi Quentin,
>>
>> On 2025/5/28 20:00, Quentin Schulz wrote:
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> This implements checkboard() to print the current SoC model used by a
>>> board, e.g. one of:
>>>
>>> SoC: PX30
>>> SoC: PX30K
>>>
>>> when U-Boot proper is running.
>>>
>>> The information is read from the OTP. There's no public information as
>>> far as I know about the layout and stored information but this was
>>> provided by Rockchip themselves through their support channel.
>>>
>>> I'm aware of at least one other variant, the PX30S/PX30-S but I have
>>> neither a board with that SoC nor the information of what the value in
>>> the OTP is supposed to be. If it follows what was done for RK3588
>>> variants, where the letter is derived from some offset added to the
>>> value read from the OTP, PX30S could be represented by 0x33 in the
>>> OTP. I'm assuming this is correct and simply printing the char
>>> represented by this offset added to the value in the OTP instead of
>>> checking whether it's 0x21 (PX30) or 0x28 (PX30K) or bailing out.
>>>
>>> Also add the OTP node to the pre-relocation phase of U-Boot proper so
>>> that the SoC variant can be printed when DISPLAY_BOARDINFO is enabled.
>>> This is not required if DISPLAY_BOARDINFO_LATE is enabled because this
>>> happens after relocation. If both are enabled, then the SoC variant 
>>> will
>>> be printed twice in the boot log, e.g.:
>>>
>>> U-Boot 2025.07-rc3-00014-g7cb731574ae6-dirty (May 28 2025 - 13:52:47 
>>> +0200)
>>>
>>> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
>>> SoC:   PX30  <---- due to DISPLAY_BOARDINFO
>>> DRAM:  2 GiB
>>> PMIC:  RK809 (on=0x40, off=0x00)
>>> Core:  293 devices, 27 uclasses, devicetree: separate
>>> MMC:   mmc@ff370000: 1, mmc@ff390000: 0
>>> Loading Environment from MMC... Reading from MMC(1)... OK
>>>
>>> In:    serial@ff030000
>>> Out:   serial@ff030000
>>> Err:   serial@ff030000
>>> Model: Theobroma Systems PX30-uQ7 SoM on Haikou devkit
>>> SoC:   PX30  <----- due to DISPLAY_BOARDINFO_LATE
>>> Net:   eth0: ethernet@ff360000
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>> Tested on a PX30 Ringneck and PX30K Ringneck. Would be nice if anyone
>>> had a device with a PX30S or any other variant so we could verify it
>>> prints what it should :) Or maybe Kever knows :)?
>>
>> PX30S has the same id with PX30 in byte 6.
>>
>> For PX30, there should not have other variant now.
>>
>
> Thanks for the info.
>
> Is there a way to differentiate PX30 from PX30S from the OTP maybe?

This is the code from vendor kernel for identify PX30 and PX30S:

drivers/soc/rockchip/rockchip-cpuinfo.c

         rockchip_soc_id = ROCKCHIP_SOC_PX30;
#define PX30_DDR_GRF_BASE 0xFF630000
#define PX30_DDR_GRF_CON1 0x04
         base = ioremap(PX30_DDR_GRF_BASE, SZ_4K);
         if (base) {
                 unsigned int val = readl_relaxed(base + 
PX30_DDR_GRF_CON1);

                 if (((val >> 14) & 0x03) == 0x03)
                         rockchip_soc_id = ROCKCHIP_SOC_PX30S;
iounmap(base);
         }


Thanks,
- Kever
>
> If not, do you want to show
>
> PX30/PX30S
>
> when byte 6 is 0x21?
>
> Cheers,
> Quentin
>
