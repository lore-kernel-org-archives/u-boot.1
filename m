Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1450CEE3692
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 14:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 173978388D;
	Thu, 12 Feb 2026 15:42:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qA03mHuw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B81B283B9D; Thu, 12 Feb 2026 15:42:45 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0D0A83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 15:42:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fBdLn66n7z9t46;
 Thu, 12 Feb 2026 15:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770907361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cv98wrJi1h/RrIMQQc6szPIbAZPPLdUlzeTLvwVu1eQ=;
 b=qA03mHuwlEpCNcupiVuIdiwY5tYyanwG89TvLPKIQ3F1c6JsUegXgufYvrn3gQNSSd7OKn
 oxrb5adaobMNt32MPJZph3xEwaShgE3c2SVa+QFKCAAtfqLlkqXJz6yFN+krEXaUaFuEtM
 4pKgjYqi4EwFXbSVI2Zyzy1QOciKP6MTvgI4AJgY1gBB+qQDGhgSzV9AV0m3zBLbILuFGJ
 nlb98EQgnhgz8iVpNBD+A7YkvwDabJ7XuEaYRNYoDANbFffjs71O8SQHzDjJpUtuaK8/99
 PB4SsnMz1jrxOW0RzJj/rmTDX6DO2UwwDLG8FeU7/93/m/PgZ6igvz143XOU0w==
Message-ID: <f503b515-3b9a-4dbe-bfdd-6ed02d2a02a2@mailbox.org>
Date: Thu, 12 Feb 2026 15:42:37 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] usb: cdns3: use VBUS Valid to determine role for dr_mode
 OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, trini@konsulko.com,
 minda.chen@starfivetech.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20260204121245.2105523-1-s-vadapalli@ti.com>
 <4267b260-9479-44b4-bbeb-521738845be1@mailbox.org>
 <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <26f52e6f-d936-4180-8405-d30de803fc09@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rornsmnuhq79d6wcppeq7mp6krtjx6k6
X-MBO-RS-ID: 7bae1ad1cdd691326d3
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

On 2/5/26 2:11 AM, Siddharth Vadapalli wrote:

[...]

>>> +static enum usb_dr_mode cdns3_get_otg_mode(ofnode node)
>>> +{
>>> +    struct cdns3 cdns, *cdnsp;
>>> +    void __iomem *otg_regs;
>>> +    fdt_addr_t otg_addr;
>>> +    int otg_reg_index;
>>> +    int vbus;
>>> +
>>> +    otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
>>> +    if (otg_reg_index < 0)
>>> +        return USB_DR_MODE_OTG;
>> This is wrong, the function should return error and possibly mode via 
>> function parameter , do not conflate return value and mode please .
> 
> Regarding returning an error, the patch maintains status quo for the 
> case where we are unable to read the USB OTG Status register. Please 
> refer to the following diff in the patch:
> 
> 
>      @@ -413,6 +462,10 @@ int cdns3_bind(struct udevice *parent)
>           if (dr_mode == USB_DR_MODE_UNKNOWN)
>               dr_mode = usb_get_dr_mode(dev_ofnode(parent));
> 
>      +    /* Use VBUS Valid to determine role */
>      +    if (dr_mode == USB_DR_MODE_OTG)
>      +        dr_mode = cdns3_get_otg_mode(node);
>      +
>           switch (dr_mode) {
>       #if defined(CONFIG_SPL_USB_HOST) || \
>           (!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
> 
> Only if the 'dr_mode' is already 'OTG', the newly added function 
> cdns3_get_otg_mode() is invoked. In case cdns3_get_otg_mode() cannot 
> determine the mode (otg status register cannot be read), we return otg 
> mode to maintain existing behavior, following which, the code will use 
> the CONFIGS to determine the role.
> 
> Returning an error will alter existing behavior rather than extending it 
> for enhancing functionality.
> 
> Regarding passing the mode via a function parameter, I could do so, but 
> I followed the implementation of other functions such as
>      usb_get_dr_mode()
> which 'returns' the mode rather than using a function parameter to fill 
> in the mode.
> 
> Please let me know what you think.
I think this patch is wrong, cdns3_get_otg_mode() should return an error 
code and also return mode via parameter. This:

static int cdns3_get_otg_mode(ofnode node, enum usb_dr_mode *mode)
{
    ...
    if (error)
       return -ESOMETHING;
    ...
    *mode = some mode
    return 0;
}

Do not conflate mode and error code, this leads to problems.
