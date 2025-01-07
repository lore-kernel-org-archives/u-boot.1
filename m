Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61289E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:16:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8854801E8;
	Tue,  7 Jan 2025 15:16:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="yue8quhV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E57E4801FD; Tue,  7 Jan 2025 15:16:25 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83868007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=af48=UA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1736259379;
 bh=+nLPNajdUS9Zr7g7ucXpPL28S9euVT18GV7jlb+Fx9A=;
 b=yue8quhVZ3IeHZur5FmxKSD4VyBrgccACKct+YJ/lTCrUZZNz8F6yEV8ZnkyieTGti/nlBRm8
 bIzalqm04v6ov3sriOruCjtN55aZ1cBZaJBRMFFWcZ8AvCGXx4BR+ZI7rNllBdhnfm+cBsIbbuY
 SpKike5e/+H4fiuwsjfiUY+mNMBHVog0R6FLKA1z3JM7n9iLQmgcCH0RmKi1N+xO7dnFCyNtegp
 LQC4R+7px2RMx/tDL94HjBLD9AIe7WHNYpLmPCbFxsC5d0hPfg8RwOwCrtzj3YhZPQtBBumjDHl
 bodaCGSulWnMLUnUwfxwc11MxviNCxLmlTOm5jPSFBvw==
X-ForwardEmail-Version: 0.4.40
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Received: from [192.168.2.234] ([78.69.151.207]
 78-69-151-207-no600.tbcn.telia.com) by smtp.forwardemail.net (Forward
 Email) with ESMTPSA (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384); Tue,
 07 Jan 2025 14:16:09 +0000
Message-ID: <7893ae9a-3f2f-4377-90ec-f24655e55384@kwiboo.se>
Date: Tue, 7 Jan 2025 15:16:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240225152715.1821613-1-jonas@kwiboo.se>
 <d9d049c8-d498-48ec-87f6-4127dd7a4ae6@denx.de>
 <5bafad42-2c61-43eb-8fbb-cec7159132a6@kwiboo.se>
 <20240226014708.GH3040305@bill-the-cat>
 <81bdee81-2f8f-4fbf-a729-8fd543492adb@kwiboo.se>
 <a809eb32-ae70-4f69-b5f0-81488759e838@denx.de>
 <e14e9c06-ca37-4572-b410-c40a8c52898c@kwiboo.se>
 <1544e744-bbf7-4460-b2b4-12a971e70d49@denx.de>
 <7805b8d0-fb7c-41d5-8d74-f85dfd40233a@kwiboo.se>
 <87y1b2nfpn.fsf@baylibre.com>
 <6bf2af4a-740e-4cfc-9009-0892139738c3@kwiboo.se>
 <87a5jik9gk.fsf@baylibre.com> <5b5cba1e-b057-4d64-a836-603534d48620@denx.de>
 <87ed1edc3h.fsf@baylibre.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <87ed1edc3h.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 677d372da21c62606d591497
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

Hi Marek and Mattijs,

On 2025-01-07 13:48, Mattijs Korpershoek wrote:
> Hi Marek,
> 
> On dim., janv. 05, 2025 at 20:29, Marek Vasut <marex@denx.de> wrote:
> 
>> On 6/18/24 9:15 AM, Mattijs Korpershoek wrote:
>>> Hi Jonas,
>>
>> Hello all,
>>
>>> On sam., mars 02, 2024 at 14:00, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>
>>> [...]
>>>
>>>>>
>>>>> I will keep you posted.
>>>>
>>>> Thanks, much appreciated!
>>>>
>>>> Please also keep in mind that changing the interrupt handling probably
>>>> only fixes the second of the two build errors reported and fixed by this
>>>> patch.
>>>>
>>>> Trying to build with following will trigger the first build error, and
>>>> should not change because use of dm_usb_gadget_handle_interrupts() is
>>>> reworked.
>>>>
>>>> CONFIG_DM_USB_GADGET=y
>>>> CONFIG_USB_DWC3=y
>>>> # CONFIG_USB_DWC3_GADGET is not set
>>>> CONFIG_USB_DWC3_GENERIC=y
>>>> CONFIG_USB_GADGET=y
>>>>
>>>> E.g to only include host part of dwc3 and gadget from another driver,
>>>> to i.e. save on binary size, produce following build error:
>>>>
>>>> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>>>> drivers/usb/dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>>>    undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>>
>>>> I guess force select USB_DWC3_GADGET for USB_DWC3_GENERIC would make
>>>> that build error disappear, and increase binary size as a result.
>>>>
>>>> For my RK3328 series [1] I will just revert to use USB_XHCI_DWC3 instead
>>>> of using USB_DWC3_GENERIC on boards that enable peripheral use of otg
>>>> port.
>>>>
>>>> [1] https://patchwork.ozlabs.org/patch/1904779/
>>>
>>> Marek ended up doing this rework.
>>> It's available for review here, if you want to have a look:
>>> https://lore.kernel.org/all/20240614005309.34433-1-marek.vasut+renesas@mailbox.org/
>> This should be upstream in some form now, is this thread still an open 
>> topic or is this solved now ?
> 
> The thread reported 2 problems:
> 
> Using khadas-vim3_android_defconfig, I tried:
> 1. DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled
> $ grep -e DM_USB_GADGET -e USB_DWC3_GADGET .config
> CONFIG_DM_USB_GADGET=y
> # CONFIG_USB_DWC3_GADGET is not set
> 
> 2. USB_GADGET_DWC2_OTG + DM_USB_GADGET is enabled and USB_DWC3_GADGET is disabled.
> $ grep -e USB_GADGET_DWC2_OTG -e DM_USB_GADGET -e USB_DWC3_GADGET .config
> CONFIG_DM_USB_GADGET=y
> # CONFIG_USB_DWC3_GADGET is not set
> CONFIG_USB_GADGET_DWC2_OTG=y
> # CONFIG_USB_GADGET_DWC2_OTG_PHY is not set
> CONFIG_USB_GADGET_DWC2_OTG_PHY_BUS_WIDTH_8=y
> 
> In both case, I could build succesfully on master with commit 6d41f0a39d64 ("Prepare v2025.01")
> 
> So I think this is solved now. I'll let Jonas confirm.

Correct, this patch can now be ignored, this issue has been resolved and
I was able to complete the move to use USB_DWC3_GENERIC with DWC2 GADGET
for RK3328 in [2].

[2] https://patchwork.ozlabs.org/project/uboot/patch/20241008192719.2192430-1-jonas@kwiboo.se/

Please also take a look at an old unmerged cleanup patch at [3] :-)

https://patchwork.ozlabs.org/project/uboot/patch/20240121203818.2075381-1-jonas@kwiboo.se/

Regards,
Jonas
