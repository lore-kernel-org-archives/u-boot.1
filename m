Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF947C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 10:41:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC8C88710B;
	Tue,  7 Nov 2023 11:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CFWTHJl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B2E86CB1; Tue,  7 Nov 2023 11:41:33 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4565E87124
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 11:41:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ee6a=GU=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699353683;
 bh=WLr2rA5tqVxlJ5+F2bTfYVQUO+MHGhjMl2QehZrNNI4=;
 b=CFWTHJl2qroMh2jt5Y3nyIEN24GFy5BZGi2FhGVWJ2nuk+p5ahDuzia82hIASKTze3FRXsQL/
 TqsJTrjHxU7ArQ800HgdkfbFRZ1LPrqJsWzfgFjgz6KHxDn94m461sEKsxeptxLF1kPEKBNCkrC
 3cjsj4Am4R89L3kA72H6J4F8aJrXxsRpkvc5v8OMJNGrTXnKpAoymtdNcYNP/lSZuEt9sivbR88
 lmp+MmSQaMrr1s3NDXGyETJePYUfNNo2PDHb9eTCvjfpNLc2qnE6/D7hh7r1YxTgw3+q/fkE9ht
 OgirZiRXyzHXnkIkaCBmQaiXwv8IntOU7CNtGixM5KBA==
Message-ID: <644799d9-0144-4856-9980-cd95d2c29f89@kwiboo.se>
Date: Tue, 7 Nov 2023 11:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3588-rock-5b: Enable CONFIG_PCI_INIT_R to
 support EFI networking
To: Martin Roukala <martin.roukala@mupuf.org>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>
Cc: Christopher Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de
References: <20231104130451.111020-1-martin.roukala@mupuf.org>
 <ef28a2eb-131c-4b43-b048-f8af3160ddbb@kwiboo.se>
 <f27831c4-3ba8-4f81-89fb-256c3f0f77fa@mupuf.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f27831c4-3ba8-4f81-89fb-256c3f0f77fa@mupuf.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654a14532e3c46396d17e5fa
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

Hi Martin,

On 2023-11-07 10:45, Martin Roukala wrote:
> Hi Jonas,
> 
> On 06/11/2023 20:15, Jonas Karlman wrote:
>> Hi Martin,
>>
>> On 2023-11-04 14:04, Martin Roukala (né Peres) wrote:
>>> When u-boot chainloads an EFI bootloader such as iPXE, we want to have
>>> already initialized the PCI subsystem so that network driver is loaded
>>> and ready to use by the bootloader.
>>
>> This change slows down boot from emmc/sd-card where scanning for pci
>> devices typically is unnecessary.
> 
> True.
> 
>>
>> If pci must be initialized and scanned before an EFI app is started to
>> find pci network controllers, then pci should probably be initialized by
>> the efi bootmeth, not by enabling CONFIG_PCI_INIT_R for a single board.
> 
> Unfortunately, it isn't that simple. I am chainloading iPXE immediately, 
> so we never end up calling bootmeth... and so iPXE fails to find any NIC 
> because u-boot did not initialize the PCI subsystem.

How are you chainloading iPXE?, if it is not started using standard boot
procedure (the efi bootmeth). If you are running custom script to load
iPXE you can probably run "pci enum;net list;" before loading iPXE to
init pci network.

> 
> IMO, the defconfig should work in all situations. If someone wants to 
> speed up their use case, they are free to disable the features they 
> don't need.

IMO, the defconfig should work for generic use case with standard boot,
and with the lazy loading principle of not probing devices/drivers until
they are needed/used.

PCI_INIT_R will force probing of pci devices that may not be needed and
add a ~1 second timeout delay for each unoccupied M.2 slot on this board.

> 
> A generic solution may be for u-boot to start probing the PCI bus when 
> asked to enumerate the NICs through SNP by the EFI binary... but until 
> this is done, the defaults should just work.

Agree, this should be solved using a generic solution. Do not agree on
changing defaults for a specific use-case that affect other use-cases
and where other workarounds may be applied.

Regards,
Jonas

> 
> Regards,
> Martin
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> Fixes: 191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA cards")
>>> Signed-off-by: Martin Roukala (né Peres) <martin.roukala@mupuf.org>
>>> ---
>>>   configs/rock5b-rk3588_defconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
>>> index 0595325e81..938137c851 100644
>>> --- a/configs/rock5b-rk3588_defconfig
>>> +++ b/configs/rock5b-rk3588_defconfig
>>> @@ -36,6 +36,7 @@ CONFIG_OF_BOARD_SETUP=y
>>>   CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5b.dtb"
>>>   # CONFIG_DISPLAY_CPUINFO is not set
>>>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> +CONFIG_PCI_INIT_R=y
>>>   CONFIG_SPL_MAX_SIZE=0x40000
>>>   CONFIG_SPL_PAD_TO=0x7f8000
>>>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>>

