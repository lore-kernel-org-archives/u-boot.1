Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A15CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 04:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B48983A3D;
	Mon, 17 Nov 2025 05:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=zoho.com header.i=krumelmonster@zoho.com header.b="Jbw87nSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CED683A3D; Sun, 16 Nov 2025 18:51:25 +0100 (CET)
Received: from sender3-of-g92.zoho.com (sender3-of-g92.zoho.com
 [136.143.184.92])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91B78839D7
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 18:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=zoho.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=krumelmonster@zoho.com
ARC-Seal: i=1; a=rsa-sha256; t=1763315477; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=kdn5VqEzD6+4ldXS2nL8pcEDqGU8fxvC1DYuITqcQdqmULtdHLuGMU18fPbnkEOq11eqFDIZlZ7+b9rJrGFWVpJ5LODbB7LBhIOjnUcNdPlb1ApL4aHTpc2XbQ7ar7+r8STtUTALpDTeQvNkNKgsgdJsTuwwCkOC/BougnnYu50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1763315477;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=G/EbIJZC91vqa5qhbWGOWyOihkcOovtLf938VdjSoEY=; 
 b=ZIRVJ2YgCamEpJG8fXluJ0qAFCLzoNxxZIeNRyBE9VExos3VqU7qUP1mxCwFCZd42Ag/DE1LIIPLmEJOA8De5vqzED+vpD4C1lxVxwVLWff+YRywawipDqUJHo+4W8gp/NebhWm91xg3VLHa1jPysZ8n4/Zyb94qDxxe5J4ycJQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=zoho.com;
 spf=pass  smtp.mailfrom=krumelmonster@zoho.com;
 dmarc=pass header.from=<krumelmonster@zoho.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763315477; 
 s=zm2022; d=zoho.com; i=krumelmonster@zoho.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
 bh=G/EbIJZC91vqa5qhbWGOWyOihkcOovtLf938VdjSoEY=;
 b=Jbw87nSsyYYMcb7ksJ9f+kA3EOJoFHIf9BosqrNigBD27HswEIoRjULPoZzLSTwg
 MNHyibRC+ccQFF/kfg/vDymUQn+snVvb57eLrn26u2pRJ+F2iNLbAKdlwprgCf59YAK
 zvR0IOO47Em+VPkiefTvhiWpx4YjPq+RkMaj8Kyg=
Received: by mx.zohomail.com with SMTPS id 1763315474347312.25433163564196;
 Sun, 16 Nov 2025 09:51:14 -0800 (PST)
Message-ID: <68a51783-56c3-4fb9-98ea-799187bb500e@zoho.com>
Date: Sun, 16 Nov 2025 18:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `usb start` freezes friendlyelec CM3588 Plus NAS board
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <0cbfcfd3-c0e1-432f-92f2-d7bc349bdf57@zoho.com>
 <eed6bd9d-c2f7-4003-af51-152c905c9532@kwiboo.se>
Content-Language: en-US
From: Krumelmonster <krumelmonster@zoho.com>
Autocrypt: addr=krumelmonster@zoho.com; keydata=
 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
 0umNs8easGJLUrDeEObR8cXi5oWRCGA=
In-Reply-To: <eed6bd9d-c2f7-4003-af51-152c905c9532@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122722c8a40d869a140eccd4907a00001851fbf4d040156b861a9089a0311f0bdc8b8051cac96e64f8:zu0801122674cf655db6e85d3953d1fd810000e4d7e03afccf64440281b4f3b5e9aded0310471e43a5f6a3:rf0801122b7bd9850ced007351e38b9985000035dc08bb46082908dc828ecb7dadc3dcdf194b9d785b9edd5112906b02:ZohoMail
X-ZohoMailClient: External
X-ZohoMail-Owner: <68a51783-56c3-4fb9-98ea-799187bb500e@zoho.com>+zmo_0_
X-Mailman-Approved-At: Mon, 17 Nov 2025 05:20:09 +0100
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

On 15/11/2025 22.22, Jonas Karlman wrote:
> On 11/15/2025 5:30 PM, Krumelmonster wrote:
>> Using the cm3588-nas-rk355_defconfig, running `usb start` in u-boot
>> freezes my cm3588 nas in all commits I checked:
>> v2024.10, v2025.10, v2026.01-rc, and the current `rockchip` branch
>> (commit a81c91446a1) on collaboras rk3588 repo at
>> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot
>>
>> It doesn't freeze if I disable PHY_ROCKCHIP_INNO_USB2.
>>
>> This is the 32GB RAM, 64GB eMMC variant of the CM3588 Plus NAS Kit as
>> sold by friendlyelec.
>>
>> I don't intend to use usb support there, just happened to stumble upon
>> this. USB gadget and host are supposedly working on the CM3588 according
>> to commit 5bc8209e1ba ("board: rockchip: Add FriendlyElec CM3588 NAS").
>>
>> => usb start
>> starting USB...
>> USB EHCI 1.00
>>
>> No further output follows.
> 
> I am not able to reproduce this issue on a CM3588 NAS Kit, and looking
> at the schematics the only diff seem to be LPDDR4X vs LPDDR5.
> 
>    DDR b8ce94f14b cym 25/08/25-14:29:26,fwver: v1.20
>    ...
>    LPDDR4X, 1848MHz
>    ...
>    out
>    
>    U-Boot SPL 2026.01-rc2 (Nov 15 2025 - 20:57:41 +0000)
>    Trying to boot from MMC2
>    ## Checking hash(es) for config config-1 ... OK
>    ## Checking hash(es) for Image atf-1 ... sha256+ OK
>    ## Checking hash(es) for Image u-boot ... sha256+ OK
>    ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>    ## Checking hash(es) for Image atf-2 ... sha256+ OK
>    ## Checking hash(es) for Image atf-3 ... sha256+ OK
>    INFO:    Preloader serial: 2
>    NOTICE:  BL31: v2.3():v2.3-942-g98eaeb2f3:derrick.huang, fwver: v1.53
>    NOTICE:  BL31: Built : 12:10:56, Aug 25 2025
>    INFO:    spec: 0x1
>    INFO:    code: 0x88
>    INFO:    customer demand: 0x0
>    INFO:    ext 32k is not valid
>    INFO:    ddr: stride-en 4CH
>    INFO:    GICv3 without legacy support detected.
>    INFO:    ARM GICv3 driver initialized in EL3
>    INFO:    valid_cpu_msk=0xff bcore0_rst = 0x0, bcore1_rst = 0x0
>    INFO:    l3 cache partition cfg-0
>    INFO:    system boots from cpu-hwid-0
>    INFO:    disable memory repair
>    INFO:    idle_st=0x21fff, pd_st=0x11fff9, repair_st=0xfff70001
>    INFO:    dfs DDR fsp_params[0].freq_mhz= 1848MHz
>    INFO:    dfs DDR fsp_params[1].freq_mhz= 528MHz
>    INFO:    dfs DDR fsp_params[2].freq_mhz= 1068MHz
>    INFO:    dfs DDR fsp_params[3].freq_mhz= 1560MHz
>    INFO:    BL31: Initialising Exception Handling Framework
>    INFO:    BL31: Initializing runtime services
>    WARNING: No OPTEE provided by BL2 boot loader, Booting device without OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
>    ERROR:   Error initializing runtime service opteed_fast
>    INFO:    BL31: Preparing for EL3 exit to normal world
>    INFO:    Entry point address = 0xa00000
>    INFO:    SPSR = 0x3c9
>    
>    
>    U-Boot 2026.01-rc2 (Nov 15 2025 - 20:57:41 +0000)
>    
>    Model: FriendlyElec CM3588 NAS
>    SoC:   RK3588
>    DRAM:  8 GiB
>    PMIC:  RK806 (on=0x10, off=0x00)
>    Core:  422 devices, 34 uclasses, devicetree: separate
>    MMC:   mmc@fe2c0000: 1, mmc@fe2e0000: 0
>    Loading Environment from nowhere... OK
>    In:    serial@feb50000
>    Out:   serial@feb50000
>    Err:   serial@feb50000
>    Model: FriendlyElec CM3588 NAS
>    SoC:   RK3588
>    Net:   No ethernet found.
>    Hit any key to stop autoboot: 0
>    => usb start
>    starting USB...
>    USB EHCI 1.00
>    USB OHCI 1.0
>    USB EHCI 1.00
>    USB OHCI 1.0
>    Register 2000140 NbrPorts 2
>    Starting the controller
>    USB XHCI 1.10
>    Register 2000140 NbrPorts 2
>    Starting the controller
>    USB XHCI 1.10
>    cannot reset port 1!?
>    Bus usb@fc800000: 1 USB Device(s) found
>    Bus usb@fc840000: 1 USB Device(s) found
>    Bus usb@fc880000: 1 USB Device(s) found
>    Bus usb@fc8c0000: 1 USB Device(s) found
>    Bus usb@fcd00000: 2 USB Device(s) found
>    Bus usb@fc400000: 1 USB Device(s) found
>           scanning usb for storage devices... 1 Storage Device(s) found
>    => usb tree
>    USB device tree:
>      1  Hub (480 Mb/s, 0mA)
>         u-boot EHCI Host Controller
>    
>      1  Hub (12 Mb/s, 0mA)
>          U-Boot Root Hub
>    
>      1  Hub (480 Mb/s, 0mA)
>         u-boot EHCI Host Controller
>    
>      1  Hub (12 Mb/s, 0mA)
>          U-Boot Root Hub
>    
>      1  Hub (5 Gb/s, 0mA)
>      |  U-Boot XHCI Host Controller
>      |
>      +-2  Mass Storage (5 Gb/s, 126mA)
>           Corsair Voyager VEGA 070894224D1DDF08
>    
>      1  Hub (5 Gb/s, 0mA)
>         U-Boot XHCI Host Controller
>    
>    =>
> 
> Above is from using tag v2026.01-rc2 with only a single USB stick
> connected to one of the 3 USB-A ports on the board, using the reset
> button between each test to ensure a clean state.
> 
>> I will happily provide further information upon request.
> 
> Do you have any other peripherals attached to your board when you test?
> E.g. PCIe/NVMe, HDMI, Ethernet or similar?

I've always been testing on Micro-SD, with ethernet, uart and 12V 5A
supply connected, I reset by switching off power supply.

When systematically testing the mentioned revisions, two M.2 SSDs where
connected but I've observed the same behavior without anything in the
M.2 slots.

When systematically testing revisions nothing was connected to USB, only
when I tested for kconfig options that influence the issue I connected
an USB keyboard to different USB-A slots (and that didn't change the
symptomatic).

> For my test run above I only had 12V power-in, SD-card (with u-boot) and
> Debug UART connected to my CM3588 NAS Kit board.
> 
> Also what DDR-init fwver and TF-A (BL31) are you using?

bl31.elf from arm trusted firmware 2.13.0 f3db1dea4fde771fab3e3bae3b117a43
from
https://kojipkgs.fedoraproject.org/packages/arm-trusted-firmware/2.13.0/4.fc43/noarch/arm-trusted-firmware-armv8-2.13.0-4.fc43.noarch.rpm
rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin 
1fdd2039c042b04415c0085b85bd5300 from
https://github.com/rockchip-linux/rkbin/blob/master/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.19.bin

I don't suspect this to be the reason as I've observed the same issue
with armbian's u-boot build for the cm3588 nas.

Regards,
Krumelmonster
