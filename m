Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8555D73E88
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 20:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58DA4840F1;
	Thu, 29 Jan 2026 21:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wzSzlsFM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6330840E0; Thu, 29 Jan 2026 21:33:04 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8261A840EE
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 21:33:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f29nR4yyrz9vHh;
 Thu, 29 Jan 2026 21:32:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769718779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o4r9czgdA1tDXdYYHfsEqI6z1mrWGpaGN/QMgjfyE9c=;
 b=wzSzlsFMYRF6OUSjyeJTOeTiCL71YpdwKWiA04t9zMv+n5S8z1+CumZ5GnAqMaSrqo5ICV
 +Y18y10/04PD3vuupkejXZCtj9hPUfnUTiRNW7cA7doIivddSz6g+gu+X9Bks1k09cV2UK
 TqE+v+t5cAOBRiudLsXwSBHqTPyRNuuT/CKWOqd6yCRIgNEgjG8XvIRc5KoF0sAlFrTcNI
 h4XOLDFpPCgOEsAz5+qBxt8xMkjCW4MkVddHkCh6ovpEdz7BVMaIyPFH+BkB6Ob8DvNylg
 NJnYfm/rwpZHxNgWXOoC3oSIr91356X08O3z6fKiu4QvDA/wvUxaD0EVucFmiQ==
Message-ID: <c1c714c6-a2e8-4c8a-8e1a-56cba84d3ad6@mailbox.org>
Date: Thu, 29 Jan 2026 21:32:58 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: gadget: dwc2: Move dr_mode check from
 of_to_plat() to bind()
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20260129195207.2260264-1-jonas@kwiboo.se>
 <87fr7omb2h.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <87fr7omb2h.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ffb261e5f43556988d6
X-MBO-RS-META: awnffq9gyspcada7ejcwnh6hkq8a45x1
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

On 1/29/26 9:13 PM, Mattijs Korpershoek wrote:
> Hi Jonas,
> 
> Thank you for the patch.
> 
> On Thu, Jan 29, 2026 at 19:52, Jonas Karlman <jonas@kwiboo.se> wrote:
> 
>> Rockchip RK3288 and RK3506 contain two DWC2 USB controllers, typically
>> one controller use dr_mode=otg and the other one use dr_mode=host.
>>
>> With USB_GADGET_DWC2_OTG, DM_USB_GADGET and USB_DWC2 enabled this result
>> in the dwc2-udc-otg driver binding to both controllers, however only one
>> will probe due to use of dr_mode=host on the other one.
>>
>> After the commit 6668b8e7cc68 ("dm: core: Support multiple drivers with
>> same compatibles") it is possible to bind one controller to the
>> dwc2-udc-otg driver and the other one to the dwc2_usb driver.
>>
>> Move the dr_mode check from of_to_plat() to bind() to allow dm core to
>> bind the dwc2 host driver to dr_mode=host controllers.
>>
>> Before this:
>>
>>    => dm tree
>>     ...
>>     usb_gadget    0  [   ]   dwc2-udc-otg          |   |-- usb@ff740000
>>     usb_gadget    1  [   ]   dwc2-udc-otg          |   |-- usb@ff780000
>>
>>    => usb start
>>    starting USB...
>>    No USB controllers found
>>
>> After this:
>>
>>    dwc2-udc-otg usb@ff780000: Invalid dr_mode 1
>>
>>    => dm tree
>>     ...
>>     usb_gadget    0  [   ]   dwc2-udc-otg          |   |-- usb@ff740000
>>     usb           0  [   ]   dwc2_usb              |   |-- usb@ff780000
>>
>>    => usb start
>>    starting USB...
>>    USB DWC2
>>    Bus usb@ff780000: 1 USB Device(s) found
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 
> Marek, can I pick this up since it's gadget or do you want to take it?
Sure, go for it

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

Thanks !
