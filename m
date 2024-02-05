Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAADC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 15:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3142A8786C;
	Mon,  5 Feb 2024 16:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PUIveooV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B0798798F; Mon,  5 Feb 2024 16:50:02 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [IPv6:2a00:1098:ed:100::25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC8A186D38
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 16:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1707148199;
 bh=pV9MDlvsb2bKd6hZgYFynlgRJv/dRB/DyOUCgAtreQ4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=PUIveooV2wRaWvfRn+jIpBMEFTNSkWZ8Vf3BkqodETlKlUsgg5ItPOE086ORBCbTw
 pWcTOApdlWsdMRj9/AYjm7zQy/l+oA2wxAtD0vfLW77MJrYVNYzbWL9vaLkOEa00az
 D/lkaLcEphwExmY7s4Vd+8MA3w35CgLzYqocrpENrVcv5ygC+1lj+SzUsSgIbOvM4T
 LEsRPWNZvD/+M6qlY3TbPeO6rrsmuBxf+/KRVbWpNcMWTavoHtTdqyh7WnvzgIbuZL
 PqVDwLizEciloDkSzsZBjbT6QG07YnwuhXnCEE1fu0kqBF67+HdASzy5gaeqEZp3He
 9lwfeJ8JzMYQQ==
Received: from [100.90.194.27] (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id D561B3781FEF;
 Mon,  5 Feb 2024 15:49:56 +0000 (UTC)
Message-ID: <acc39f3b-c1bf-417e-af2b-cd2b94615652@collabora.com>
Date: Mon, 5 Feb 2024 17:49:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rockchip: Reset to bootrom download mode on hang
To: Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de
References: <20240202001221.531207-1-jonas@kwiboo.se>
 <85ab4e51-2d93-4672-881c-8df353232d1f@theobroma-systems.com>
 <5041c1cc-1183-4fc6-aab8-8a7e12b7daac@kwiboo.se>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <5041c1cc-1183-4fc6-aab8-8a7e12b7daac@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
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

Hello Jonas,

On 2/5/24 14:34, Jonas Karlman wrote:
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
>>>    U-Boot SPL 2024.04-rc1 (Feb 01 2024 - 23:01:12 +0000)
>>>    Trying to boot from MMC1
>>>    mmc_load_image_raw_sector: mmc block read error
>>>    Trying to boot from MMC2
>>>    Card did not respond to voltage select! : -110
>>>    spl: mmc init failed with error: -95
>>>    Trying to boot from MMC1
>>>    mmc_load_image_raw_sector: mmc block read error
>>>    SPL: failed to boot from all boot devices
>>>    ### ERROR ### Please RESET the board ###
>>>    entering download mode ...
>>>    resetting ...
>>>
>>> Procedure to start bootrom download mode:
>>> - U-Boot SPL or proper write 0xEF08A53C to BOOT_MODE_REG and then reset
>>> - Bootrom loads and run boot code (TPL) from e.g. SPI > eMMC > SD-card
>>> - TPL check for 0xEF08A53C in BOOT_MODE_REG very early, i.e. Rockchip
>>>    TPL blobs check for this value directly at start
>>> - TPL return to bootrom with a return value != 0
>>> - Bootrom enter download mode
>>>
>>> This also fixes an issue where the BOOT_MODE_REG is reset to 0 when
>>> board is reset on RK35xx after TF-A has been loaded. To fix this the
>>> SOC_CON1 reg value is reset prior to issuing a global reset.
>>>
>>> The RK356x TF-A blobs will clear SOC_CON1 as part of a PSCI reset,
>>> however the RK3588 TF-A blobs does not seem to clear SOC_CON1.

Recently I tested BL31 with TF-A, it works, and you can send a patch to fix bugs in
there if you find them !
Its open source, I gathered the patches and tested them here:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/trusted-firmware-a

>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>
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
> 
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
> 
> I am open for any suggestions.

I implemented DFU in SPL at some point last year (due to DWC3 being unaligned with
Linux the patches weren't accepted), and defaulting to DFU is also an option when
nothing boots.

(
https://patchwork.ozlabs.org/project/uboot/cover/20230801072811.10354-1-eugen.hristev@collabora.com/#3185956
)

Eugen
> 
> Regards,
> Jonas
> 
>>
>> Cheers,
>> Quentin
> 

