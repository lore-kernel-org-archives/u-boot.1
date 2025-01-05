Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AB0E77197
	for <u-boot@archiver.kernel.org>; Sun,  5 Jan 2025 20:38:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BFF3801DE;
	Sun,  5 Jan 2025 21:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1736109527;
	bh=cmdrgPOHH6Pz3FQC+woI0JVcNnQ0GBuaEsBKRAg3gt4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BqT+dnswJurirYxz59nM9xDO4OWn55BEfl6f5AMH76G5Ri9kHLuUAl4JJVsGNadeQ
	 upbrGDIaABybroSijCrxCFMZIlcVyI7vyExZ1Tn4kozF519WffV8ZKIutgwAovih9S
	 cEbPXo2UX59oPfMsXLP+Z7a83JIhJJPVrTwPmtwTnp6M05CtCBQUTu74mBf2C4MS8s
	 xGwQ242/eBXFHQ7azIaORgSHdfeNg1g7a0pwJteleWl4gna5fyikpIu7Yv3IiL4s5v
	 dFwDUBRE01oeMv3IsFP5dpzxL07zDNs5MUITuWMDl3IvtvM/KrlPLrLZ4xOi4/IJOz
	 brVJGgKk/ukaA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1F35801CE; Sun,  5 Jan 2025 21:38:45 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95BEF801CE
 for <u-boot@lists.denx.de>; Sun,  5 Jan 2025 21:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="JzBhRYKi"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1906E10408FB9; Sun,  5 Jan 2025 21:38:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1736109522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cmdrgPOHH6Pz3FQC+woI0JVcNnQ0GBuaEsBKRAg3gt4=;
 b=JzBhRYKiQg73X/m4ix46YVAXcR2hdlY3jx9wneK2y3T/T44PxpNYZhCNjA4mGbZQKtNO94
 o/W/LGVNsNZv5+RSI7TFaYp32cXFqbpOvvhkhaDoMbVpN8LATRWoSrwr2MLjzBrD42XImF
 cYlm/IR/YHliah8fSRVTR/a+K51J21IlQRwjIdRxxYYqGOiGu8s03mUhjf0WXx0Q9sJ9tQ
 +fGmb2DIQZQ4pdj3d8sBtLV45pp7CpjrhA7DMCDzZdyuDvO1ZwkPLKPqx/tPb5tatW10v1
 TbSqvV2Wo/0/Oa0om+t2WHV7ncMl3qgCEW1rZBrqRmQz+9FE0HhzDrAJJ8rzbg==
Message-ID: <5b5cba1e-b057-4d64-a836-603534d48620@denx.de>
Date: Sun, 5 Jan 2025 20:29:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3-generic: Fix build errors when USB_DWC3_GADGET
 is disabled
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
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
 <87a5jik9gk.fsf@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87a5jik9gk.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 6/18/24 9:15 AM, Mattijs Korpershoek wrote:
> Hi Jonas,

Hello all,

> On sam., mars 02, 2024 at 14:00, Jonas Karlman <jonas@kwiboo.se> wrote:
> 
> [...]
> 
>>>
>>> I will keep you posted.
>>
>> Thanks, much appreciated!
>>
>> Please also keep in mind that changing the interrupt handling probably
>> only fixes the second of the two build errors reported and fixed by this
>> patch.
>>
>> Trying to build with following will trigger the first build error, and
>> should not change because use of dm_usb_gadget_handle_interrupts() is
>> reworked.
>>
>> CONFIG_DM_USB_GADGET=y
>> CONFIG_USB_DWC3=y
>> # CONFIG_USB_DWC3_GADGET is not set
>> CONFIG_USB_DWC3_GENERIC=y
>> CONFIG_USB_GADGET=y
>>
>> E.g to only include host part of dwc3 and gadget from another driver,
>> to i.e. save on binary size, produce following build error:
>>
>> aarch64-linux-gnu-ld.bfd: drivers/usb/dwc3/dwc3-generic.o: in function `dm_usb_gadget_handle_interrupts':
>> drivers/usb/dwc3/dwc3-generic.c:201:(.text.dm_usb_gadget_handle_interrupts+0x10):
>>    undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>
>> I guess force select USB_DWC3_GADGET for USB_DWC3_GENERIC would make
>> that build error disappear, and increase binary size as a result.
>>
>> For my RK3328 series [1] I will just revert to use USB_XHCI_DWC3 instead
>> of using USB_DWC3_GENERIC on boards that enable peripheral use of otg
>> port.
>>
>> [1] https://patchwork.ozlabs.org/patch/1904779/
> 
> Marek ended up doing this rework.
> It's available for review here, if you want to have a look:
> https://lore.kernel.org/all/20240614005309.34433-1-marek.vasut+renesas@mailbox.org/
This should be upstream in some form now, is this thread still an open 
topic or is this solved now ?
