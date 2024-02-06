Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EE8C4828D
	for <u-boot@archiver.kernel.org>; Tue,  6 Feb 2024 02:25:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E57A876FC;
	Tue,  6 Feb 2024 03:25:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Gz2KkMYU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EF48786E; Tue,  6 Feb 2024 03:25:48 +0100 (CET)
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com
 [101.71.155.88])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0BD86D38
 for <u-boot@lists.denx.de>; Tue,  6 Feb 2024 03:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=Gz2KkMYU3vsMHddYHbRsUR9GSqZFwzKX7VOmAo/UCTzWD+AvEk7cZwg8ubJ+CCuJNSzFbcPn4tBEuvi3L4gHrhs9DnIjTobwRycc6Brh6JNFywYn8pDpiAdHHwvQ99RM0Nu37G+Gz+FQpQncbW5/Kl+wjHIJv7vZSSRcFPz3MNY=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
 bh=Rxa4ZUGiTW+9fY78tVhQsLzfeKhDK3M8/zYopKAdhzg=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.93] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id C4975900133;
 Tue,  6 Feb 2024 10:25:27 +0800 (CST)
Message-ID: <1bed8e20-99d5-4ef6-a984-ed33ab435654@rock-chips.com>
Date: Tue, 6 Feb 2024 10:25:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: Reset to bootrom download mode on hang
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20240202001221.531207-1-jonas@kwiboo.se>
 <85ab4e51-2d93-4672-881c-8df353232d1f@theobroma-systems.com>
 <5041c1cc-1183-4fc6-aab8-8a7e12b7daac@kwiboo.se>
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <5041c1cc-1183-4fc6-aab8-8a7e12b7daac@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGk1IHlZDHx1JGUNDQx5PQhlVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSU5IVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8d7c3c128c03a9kunmc4975900133
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nz46Ghw6MDMKKTNMCVYfSVE8
 MjJPCk9VSlVKTEtMSkNNSElDTkJKVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFOSkNMNwY+
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

Hi Jonas,

On 2024/2/5 20:34, Jonas Karlman wrote:
> Hi Quentin,
>
> On 2024-02-05 11:49, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/2/24 01:12, Jonas Karlman wrote:
>>> Add support to reset to bootrom download mode on hang in U-Boot SPL and
>>> proper. ROCKCHIP_HANG_TO_BROM can be used to enable this feature.
>>>
>>> Example when SPL cannot load FIT:
>>>
>>>     U-Boot SPL 2024.04-rc1 (Feb 01 2024 - 23:01:12 +0000)
>>>     Trying to boot from MMC1
>>>     mmc_load_image_raw_sector: mmc block read error
>>>     Trying to boot from MMC2
>>>     Card did not respond to voltage select! : -110
>>>     spl: mmc init failed with error: -95
>>>     Trying to boot from MMC1
>>>     mmc_load_image_raw_sector: mmc block read error
>>>     SPL: failed to boot from all boot devices
>>>     ### ERROR ### Please RESET the board ###
>>>     entering download mode ...
>>>     resetting ...
>>>
>>> Procedure to start bootrom download mode:
>>> - U-Boot SPL or proper write 0xEF08A53C to BOOT_MODE_REG and then reset
>>> - Bootrom loads and run boot code (TPL) from e.g. SPI > eMMC > SD-card
>>> - TPL check for 0xEF08A53C in BOOT_MODE_REG very early, i.e. Rockchip
>>>     TPL blobs check for this value directly at start
>>> - TPL return to bootrom with a return value != 0
>>> - Bootrom enter download mode
>>>
>>> This also fixes an issue where the BOOT_MODE_REG is reset to 0 when
>>> board is reset on RK35xx after TF-A has been loaded. To fix this the
>>> SOC_CON1 reg value is reset prior to issuing a global reset.
>>>
>>> The RK356x TF-A blobs will clear SOC_CON1 as part of a PSCI reset,
>>> however the RK3588 TF-A blobs does not seem to clear SOC_CON1.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> I'm wondering if there isn't a simpler way to do this?
>>
>> board_boot_order() could parse u-boot,spl-boot-order for e.g. "bootrom",
>> the same way it does for "same-as-spl" for example.
>>
>> If it is set, then add BOOT_DEVICE_BOOTROM to spl_boot_list.
>>
>> Then this would call spl_return_to_bootrom() from
>> common/spl/spl_bootrom.c which in turns would call
>> board_return_to_bootrom() and back_to_bootrom().
>>
>> What do you think?
> Something like that is what I did in my initial implementation :-)
>
> I appended a BOOT_DEVICE_BOOTROM at the end of board_boot_order() and
> implemented necessary parts in spl_return_to_bootrom(), and that worked
> great for SPL.
>
> However, to catch a hang() in U-Boot proper, e.g. a failed initcall, the
> only existing integration callback for hang() is to override
> show_boot_progress().
>
> Because the use of show_boot_progress() worked for both SPL and U-Boot
> proper (probably also TPL) it seemed better to only have one integration
> part for all phases.
>
> I am still not sure exactly when we would want to fall back into bootrom
> download mode. Always at a hang() or at controlled parts e.g. when no
> FIT can be loaded.
There are two case need to consider when hang() happen:
- For release version: a reboot and get into reset into bootrom download 
mode if boot fail more than 3 times;
- For debug version: a dump stack with hang() will be better(which is 
used in rockchip vendor u-boot);
Reboot to bootrom download when hang() happen is handy for U-Boot error 
happen, no need to press the reset
and recovery/download key in this case.
The final logic would be: fall back to usb boot(bootrom) whenever we 
fail to boot in to next stage,
so that we have chance to update an available firmware.

Thanks,
- Kever
>
> I am open for any suggestions.
>
> Regards,
> Jonas
>
>> Cheers,
>> Quentin
