Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDD81067040
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 15:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D597583F86;
	Thu, 12 Mar 2026 16:02:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n6AbNtsg";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Hi4/l0E3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07B5D84255; Thu, 12 Mar 2026 16:02:10 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA06A83DB6
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 16:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4fWrSG2f5sz9sWm;
 Thu, 12 Mar 2026 16:02:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773327726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn8nbAesTsWacDRSer4AHlabBb0Fatl+W5rJHRN634Y=;
 b=n6AbNtsgK+MgUy3s4Kihu+zXKl68UB0kSZl1pEEvoE66noYUIwiPT5JZvTOBYxlctQ9LGs
 MAA3wMLV+/Sc70soKLABYSX4XtsKVf9mj1L0VCF/rxQpmtx8Tbb2034FkWILUdnc3qtV5u
 TZCG4d332+p4eBLk+Fo9C6M3qP08yX0iRqCnG83cKwUxGjpmUb3Ln1WvkfUvpTfzgKhqIw
 yA9aTbE8C/0wwG4uQkVE3mN4Julw20x6GCay5jo2CCMwiwy7xPq2Ul6gGyQ2qD9Tz4G8f5
 o2wvqCGTgzFnj033Tk8lE3FCvC0ddSdbuvWp1/JzMPuZ39BhTFtjCTwmKslbLA==
Message-ID: <c57a8801-8282-4df3-a813-3ba7948cc054@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1773327724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qn8nbAesTsWacDRSer4AHlabBb0Fatl+W5rJHRN634Y=;
 b=Hi4/l0E3bqtqrMrswTDauiVniaiW0Y5jfrM8m/FEZiWK1XCsqnca2lHqB1LMyeT3ILBMvu
 O+bXsJPTsQ+H9yb65JeIyiOTS0Lg/HmQurdwl6uWhq/gMS+xjPV8AoKqCfeEhGuLl51dKy
 BBOtpMplC1iaeorwuY0IehpLFkxulu0CnRpiMSk0WeduMkIgUbiWuV+a5DzwNCtKVt5x/x
 rnQyTjUg/jfez4LjD0KlBIr9cSn4Bx5uGspNapIyjyWK8PfNZTkSHNQiIxrvvQUfV5Nup1
 SryCW3STwfJUMXSu1SCOIxI7W+IGfWx3iN/Y78otSM7wrwJS0aBPgBSF0hMFag==
Date: Thu, 12 Mar 2026 16:01:59 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG"
To: Tom Rini <trini@konsulko.com>, Prasanth Babu Mantena <p-mantena@ti.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Cc: u-boot@lists.denx.de, n-francis@ti.com, u-kumar1@ti.com, vigneshr@ti.com, 
 s-vadapalli@ti.com
References: <20260312133247.2192335-1-p-mantena@ti.com>
 <20260312135019.GA502704@bill-the-cat>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260312135019.GA502704@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 335aee29a9bfc43fdf8
X-MBO-RS-META: juaqeanthemrymbxsof4ys585grkaswi
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

On 3/12/26 2:50 PM, Tom Rini wrote:
> On Thu, Mar 12, 2026 at 07:02:47PM +0530, Prasanth Babu Mantena wrote:
> 
>> While USB DFU boot works with this patch, but the non USB boot modes like
>> SD Boot and flash boot fails for J784S4 EVM device.
>>
>> So, Reverting this patch.
>>
>> This reverts commit bfb530e06ca6c19f66c079601e568c761a001993.
>>
>> Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
>> ---
>>   drivers/usb/cdns3/core.c | 53 ----------------------------------------
>>   drivers/usb/cdns3/drd.c  | 11 ---------
>>   2 files changed, 64 deletions(-)
>>
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 10bc4cabed4..4434dc15bec 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -392,52 +392,6 @@ static const struct udevice_id cdns3_ids[] = {
>>   	{ },
>>   };
>>   
>> -/*
>> - * The VBUS Valid Bit in the OTG Status register can be used to determine
>> - * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
>> - * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
>> - * it indicates the absence of a USB Host, so the Controller should assume the
>> - * HOST role. If the OTG Status register is inaccessible, return an error.
>> - */
>> -static int cdns3_get_otg_mode(struct udevice *parent, enum usb_dr_mode *mode)
>> -{
>> -	/* Create a temporary child device for using devfdt_remap_addr_name() */
>> -	struct udevice child = {
>> -		.parent = parent,
>> -	};
>> -	struct cdns3 cdns, *cdnsp;
>> -	void __iomem *otg_regs;
>> -
>> -	dev_set_ofnode(&child, ofnode_first_subnode(dev_ofnode(parent)));
>> -	otg_regs = devfdt_remap_addr_name(&child, "otg");
>> -	if (!otg_regs) {
>> -		dev_err(parent, "failed to get otg registers for child node\n");
>> -		return -ENXIO;
>> -	}
>> -
>> -	/*
>> -	 * As mentioned in drivers/usb/cdns3/drd.c, there are two versions
>> -	 * of the Controller. The following logic detects the version of the
>> -	 * Controller and interprets the register layout accordingly.
>> -	 */
>> -	cdnsp = &cdns;
>> -	cdnsp->otg_v0_regs = otg_regs;
>> -	if (!readl(&cdnsp->otg_v0_regs->cmd)) {
>> -		cdnsp->otg_regs = otg_regs;
>> -	} else {
>> -		cdnsp->otg_v1_regs = otg_regs;
>> -		cdnsp->otg_regs = (void *)&cdnsp->otg_v1_regs->cmd;
>> -	}
>> -
>> -	/* Use VBUS Valid to determine role */
>> -	if (readl(&cdnsp->otg_regs->sts) & OTGSTS_VBUS_VALID)
>> -		*mode = USB_DR_MODE_PERIPHERAL;
>> -	else
>> -		*mode = USB_DR_MODE_HOST;
>> -
>> -	return 0;
>> -}
>> -
>>   int cdns3_bind(struct udevice *parent)
>>   {
>>   	enum usb_dr_mode dr_mode;
>> @@ -459,13 +413,6 @@ int cdns3_bind(struct udevice *parent)
>>   	if (dr_mode == USB_DR_MODE_UNKNOWN)
>>   		dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>>   
>> -	/* Use VBUS Valid to determine role */
>> -	if (dr_mode == USB_DR_MODE_OTG) {
>> -		ret = cdns3_get_otg_mode(parent, &dr_mode);
>> -		if (ret < 0)
>> -			return ret;
>> -	}
>> -
>>   	switch (dr_mode) {
>>   #if defined(CONFIG_SPL_USB_HOST) || \
>>   	(!defined(CONFIG_XPL_BUILD) && defined(CONFIG_USB_HOST))
>> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
>> index 0ca40a5cc8d..cbb13342343 100644
>> --- a/drivers/usb/cdns3/drd.c
>> +++ b/drivers/usb/cdns3/drd.c
>> @@ -301,17 +301,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>>   		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>   	}
>>   
>> -	/*
>> -	 * In the absence of STRAP configuration, use VBUS Valid to
>> -	 * determine the appropriate role to be assigned to dr_mode.
>> -	 */
>> -	if (cdns->dr_mode == USB_DR_MODE_OTG) {
>> -		if (cdns3_get_vbus(cdns))
>> -			cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>> -		else
>> -			cdns->dr_mode = USB_DR_MODE_HOST;
>> -	}
>> -
>>   	state = readl(&cdns->otg_regs->sts);
>>   	if (OTGSTS_OTG_NRDY(state) != 0) {
>>   		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
> 
> Adding in the USB custodian as this revert is intended for master and
> v2026.04 I assume as the commit being reverted is also in master.
> Thanks.
This may be related to

[PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and probe 
parent

?

Can you coordinate with Siddharth Vadapalli ?
