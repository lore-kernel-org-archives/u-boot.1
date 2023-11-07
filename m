Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0C7C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 11:43:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3F2886BD7;
	Tue,  7 Nov 2023 12:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4272D86BD7; Tue,  7 Nov 2023 12:43:44 +0100 (CET)
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [IPv6:2a0c:5a00:149::26])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BC9D870FF
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 12:43:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=mupuf.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martin.roukala@mupuf.org
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1r0KUd-00D2Os-HD; Tue, 07 Nov 2023 12:43:39 +0100
Received: from [10.9.9.72] (helo=submission01.runbox)
 by mailtransmit03.runbox with esmtp (Exim 4.86_2)
 (envelope-from <martin.roukala@mupuf.org>)
 id 1r0KUc-0005b5-Jc; Tue, 07 Nov 2023 12:43:38 +0100
Received: by submission01.runbox with esmtpsa [Authenticated ID (1057822)]
 (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.93) id 1r0KUS-00EH2j-44; Tue, 07 Nov 2023 12:43:28 +0100
Message-ID: <079df03e-7442-433e-86dd-a24245af1d10@mupuf.org>
Date: Tue, 7 Nov 2023 13:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Enable CONFIG_PCI_INIT_R to
 support EFI networking
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20231104130451.111020-1-martin.roukala@mupuf.org>
 <ef28a2eb-131c-4b43-b048-f8af3160ddbb@kwiboo.se>
 <f27831c4-3ba8-4f81-89fb-256c3f0f77fa@mupuf.org>
 <644799d9-0144-4856-9980-cd95d2c29f89@kwiboo.se>
From: Martin Roukala <martin.roukala@mupuf.org>
In-Reply-To: <644799d9-0144-4856-9980-cd95d2c29f89@kwiboo.se>
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

Hi Jonas,

On 11/7/23 12:41, Jonas Karlman wrote:
> Hi Martin,
> 
> On 2023-11-07 10:45, Martin Roukala wrote:
>> Hi Jonas,
>>
>> On 06/11/2023 20:15, Jonas Karlman wrote:
>>> Hi Martin,
>>>
>>> On 2023-11-04 14:04, Martin Roukala (né Peres) wrote:
>>>> When u-boot chainloads an EFI bootloader such as iPXE, we want to have
>>>> already initialized the PCI subsystem so that network driver is loaded
>>>> and ready to use by the bootloader.
>>>
>>> This change slows down boot from emmc/sd-card where scanning for pci
>>> devices typically is unnecessary.
>>
>> True.
>>
>>>
>>> If pci must be initialized and scanned before an EFI app is started to
>>> find pci network controllers, then pci should probably be initialized by
>>> the efi bootmeth, not by enabling CONFIG_PCI_INIT_R for a single board.
>>
>> Unfortunately, it isn't that simple. I am chainloading iPXE immediately,
>> so we never end up calling bootmeth... and so iPXE fails to find any NIC
>> because u-boot did not initialize the PCI subsystem.
> 
> How are you chainloading iPXE?, if it is not started using standard boot
> procedure (the efi bootmeth). If you are running custom script to load
> iPXE you can probably run "pci enum;net list;" before loading iPXE to
> init pci network.

I am loading iPXE using the bootflow way... AKA, no script at all, just 
have the ipxe EFI binary in /EFI/BOOT/BOOTAA64.EFI in a GPT partition.

I thought this was the preferred way of doing things: moving away from 
these hacky and purpose-built scripts in favor of more generic boot 
flows that don't require recompiling u-boot or a script when wanting to 
change the boot target.

In other words, making u-boot having a sane user-facing interface, and 
thus being a good target to be flashed in an SPI memory on the device 
and thus allowing distros to ship generic EFI images for more than one 
board.

> 
>>
>> IMO, the defconfig should work in all situations. If someone wants to
>> speed up their use case, they are free to disable the features they
>> don't need.
> 
> IMO, the defconfig should work for generic use case with standard boot,
> and with the lazy loading principle of not probing devices/drivers until
> they are needed/used.

Indeed, you are right that it shouldn't work in **ALL** situations. 
However, I believe chainloading is still a pretty standard boot 
situation, don't you think? If you don't think so, I hope I can make my 
case for it... or just look at the boot flow of your development machine ;)

> 
> PCI_INIT_R will force probing of pci devices that may not be needed and
> add a ~1 second timeout delay for each unoccupied M.2 slot on this board.

That's indeed annoying, but still less annoying than not seeing any NIC 
detected and having to wonder why they don't show up (missing driver? 
missing DT entries? Missing bus? ...).

In my view, sub-optimal is less important than less compatible, 
especially in the EFI/bootflow world where u-boot would not have to be 
recompiled all the time. Up to 2s boot time increase is a minor 
annoyance in CI, but I don't believe it has any impact on actual users.

I know I am new to the wild world of arm64 bootloaders, but in the x86 
world the default boot configuration is not "Fast boot". And even there, 
you can specify to which degree you want to limit device enumeration... 
AKA, the *_INIT_R config options :)

I'm all for speed, but let's keep defaults reasonable ;)

>> A generic solution may be for u-boot to start probing the PCI bus when
>> asked to enumerate the NICs through SNP by the EFI binary... but until
>> this is done, the defaults should just work.
> 
> Agree, this should be solved using a generic solution. Do not agree on
> changing defaults for a specific use-case that affect other use-cases
> and where other workarounds may be applied.

Agreed, but I would still want this patch to be merged before moving 
forward as I am sure I won't be the only one who has to bisect this 
regression. Speaking of, isn't there a non-regression rule in u-boot?

Cheers,
Martin
