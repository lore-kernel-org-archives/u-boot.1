Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C108BEE369C
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 15:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1770E8388D;
	Thu, 12 Feb 2026 16:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BgHjMlbM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BD683A47; Thu, 12 Feb 2026 16:50:57 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68C183015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 16:50:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fBfsS6YNdz9t2T;
 Thu, 12 Feb 2026 16:50:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770911452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZzplTXK9mVyrug4Teua98aUXXY/aMdQQ1Nj0hZh2608=;
 b=BgHjMlbMYEhPSfwl+uCEvCi3rqGZisYauCV9cUyrMiWjKwCgnUUkWRQhELmYczhDT79Gfh
 cB1Hxz4K458RfwzFOKc9wzlRxI0hGg4hUFZSusOd/xdXpgFgXXhZKYIGp7K4c7QhVD4uSn
 1+GAcfMpe50nH3tDgQYxbzUdSpdKu+QHC3EbKZWLu6FvWVeOZKM07klaEh/0M4ZmCpbB0L
 Y/VfCF6joyTjdGazSRkERGRSC0U3hZC1iGRFSPT4wHyyyUUa75B+02lrY4Waa3rNMhE8dN
 0tbGshXwZTTCh6+R0MeCZ+SyqLTwx+Jw4wrqB20zjOyx5zwDkNSigLtkaXuFCw==
Message-ID: <cf26ec32-984d-499f-a4ab-8f3544d0089c@mailbox.org>
Date: Thu, 12 Feb 2026 16:50:50 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: trini@konsulko.com, minda.chen@starfivetech.com, u-boot@lists.denx.de,
 srk@ti.com
References: <20260204121245.2105523-1-s-vadapalli@ti.com>
 <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
 <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
 <f503b515-3b9a-4dbe-bfdd-6ed02d2a02a2@mailbox.org>
 <e8146b36-ac72-44cf-bcae-688d02636159@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <e8146b36-ac72-44cf-bcae-688d02636159@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: adq6rw4iwo5d5t6xdsum7kkd8598149w
X-MBO-RS-ID: a5f81651a684fcd5e37
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

On 2/12/26 4:30 PM, Siddharth Vadapalli wrote:
> On 12/02/26 8:12 PM, Marek Vasut wrote:
>> On 2/5/26 2:11 AM, Siddharth Vadapalli wrote:
>>
>> [...]
>>
>>>>> +static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
>>>>> +{
>>>>> +    struct cdns3 cdns, *cdnsp;
>>>>> +    void __iomem *otg_regs;
>>>>> +    fdt_addr_t otg_addr;
>>>>> +    int otg_reg_index;
>>>>> +    int vbus;
>>>>> +
>>>>> +    otg_reg_index = ofnode_stringlist_search(node, "reg-names", 
>>>>> "otg");
>>>>> +    if (otg_reg_index < 0)
>>>>> +        return USB_DR_MODE_OTG;
>>>> This is wrong, the function should return error and possibly mode 
>>>> via function parameter , do not conflate return value and mode please .
>>>
>>> Regarding returning an error, the patch maintains status quo for the 
>>> case where we are unable to read the USB OTG Status register. Please 
>>> refer to the following diff in the patch:
>>>
>>>
>>>      @@ -413,6 +462,10 @@ int cdns3_bind(struct udevice *parent)
>>>           if (dr_mode == USB_DR_MODE_UNKNOWN)
>>>               dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>>
>>>      +    /* Use VBUS Valid to determine role */
>>>      +    if (dr_mode == USB_DR_MODE_OTG)
>>>      +        dr_mode = cdns3_get_otg_mode(node);
>>>      +
>>>           switch (dr_mode) {
>>>       #if defined(CONFIG_SPL_USB_HOST) || \
>>>           (!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>>>
>>> Only if the 'dr_mode' is already 'OTG', the newly added function 
>>> cdns3_get_otg_mode() is invoked. In case cdns3_get_otg_mode() cannot 
>>> determine the mode (otg status register cannot be read), we return 
>>> otg mode to maintain existing behavior, following which, the code 
>>> will use the CONFIGS to determine the role.
>>>
>>> Returning an error will alter existing behavior rather than extending 
>>> it for enhancing functionality.
>>>
>>> Regarding passing the mode via a function parameter, I could do so, 
>>> but I followed the implementation of other functions such as
>>>      usb_get_dr_mode()
>>> which 'returns' the mode rather than using a function parameter to 
>>> fill in the mode.
>>>
>>> Please let me know what you think.
>> I think this patch is wrong, cdns3_get_otg_mode() should return an error
> 
> Ok, I will update it to return an error, but please note that it may 
> alter existing behavior since the code is being introduced in the middle 
> of cdns3_bind() and not at the end of it.
> 
>> code and also return mode via parameter. This:
>>
>> static int cdns3_get_otg_mode(ofnode node, enum usb_dr_mode *mode)
>> {
>>     ...
>>     if (error)
>>        return -ESOMETHING;
>>     ...
>>     *mode = some mode
>>     return 0;
>> }
>>
>> Do not conflate mode and error code, this leads to problems.
> 
> Ok. I will pass the mode as parameter to the function. Thank you for the 
> clarification.
Thank you
