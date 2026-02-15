Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647B8EF5858
	for <u-boot@archiver.kernel.org>; Sun, 15 Feb 2026 00:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8866083A5E;
	Sun, 15 Feb 2026 01:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="az0EvLo2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1AA183AA9; Sun, 15 Feb 2026 01:04:43 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7293C80B98
 for <u-boot@lists.denx.de>; Sun, 15 Feb 2026 01:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4fD5kH2F5fz9tsQ;
 Sun, 15 Feb 2026 01:04:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771113879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIMFzvBN0X3IwvNR2iCX4hO4N2CPaHh8FEHh4PvWcBI=;
 b=az0EvLo2kZrA5pV26+KbvybN7pjnmHvGIN6jYKnzQRs+QSIMEKNhEGMgPwYMml9wb9eoL8
 fxhFFBHnrwLLWRDoKI7Z0PyCkRXYXVDQ1gZPaXQqnGjsK39D8JkBF9P08mHOBYf694krEu
 8zHIMDEU6gGhLY2AsFefEa5YtwU5yKrPuY9bguEPeSmbTsS1lD6NUW5ADrFo9fWtj4FJF0
 tCzOjAaSoy3dcbGemc/1iTcVHlDQW1KRGVRncJAbTCBZuLcKK0K4Dd+Akc4fCrr8r5sYNi
 TIGFWtAiFCgxs6T5tqXNQUrDuwX7USMCXExkkAogx0JOafSiTICIkbT4irxSXQ==
Message-ID: <3b12260f-e0c6-41dc-9c56-596515f871ca@mailbox.org>
Date: Sun, 15 Feb 2026 01:04:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: marex@denx.de, trini@konsulko.com, minda.chen@starfivetech.com,
 u-boot@lists.denx.de, srk@ti.com
References: <20260213051556.1247716-1-s-vadapalli@ti.com>
 <595b83ef-f83f-4ee6-8026-853a7eb89f62@mailbox.org>
 <fd664cb27379c34463c6e0ac43bbd30c00483949.camel@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <fd664cb27379c34463c6e0ac43bbd30c00483949.camel@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d0fa220a458f580f1c3
X-MBO-RS-META: 7jjg7htzq3ftd5e71sysh7b58r46m9by
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

On 2/14/26 5:36 AM, Siddharth Vadapalli wrote:
> Hello Marek,
> 
> On Fri, 2026-02-13 at 16:04 +0100, Marek Vasut wrote:
>> On 2/13/26 6:15 AM, Siddharth Vadapalli wrote:
>>
>> [...]
>>
>>> +++ b/drivers/usb/cdns3/core.c
>>> @@ -392,6 +392,63 @@ static const struct udevice_id cdns3_ids[] = {
>>>    	{ },
>>>    };
>>>    
>>> +/*
>>> + * The VBUS Valid Bit in the OTG Status register can be used to determine
>>> + * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
>>> + * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
>>> + * it indicates the absence of a USB Host, so the Controller should assume the
>>> + * HOST role. If the OTG Status register is inaccessible, return an error.
>>> + */
>>> +static int cdns3_get_otg_mode(ofnode node
>>
>> Pass struct udevice *parent instead of node here ...
>>
>>> , enum usb_dr_mode *mode)
>>> +{
>>> +	struct cdns3 cdns, *cdnsp;
>>> +	void __iomem *otg_regs;
>>> +	fdt_addr_t otg_addr;
>>> +	int otg_reg_index;
>>> +	int vbus;
>>> +
>>> +	otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
>>> +	if (otg_reg_index < 0) {
>>> +		printf("%s: dr_mode is otg but otg register name is missing\n", __func__);
>>> +		return -ENOENT;
>>> +	}
>>> +
>>> +	otg_addr = ofnode_get_addr_index(node, otg_reg_index);
>>> +	if (otg_addr == FDT_ADDR_T_NONE) {
>>> +		printf("%s: address of otg registers is unspecified\n", __func__);
>>> +		return -ENOENT;
>>> +	}
>>> +
>>> +	otg_regs = map_physmem(otg_addr, 0, MAP_NOCACHE);
>>> +	if (!otg_regs) {
>>> +		printf("%s: failed to map otg registers\n", __func__);
>>> +		return -EINVAL;
>>> +	}
>>
>> ... and replace all that ^ with devfdt_remap_addr_name(parent, "otg") .
>> That should work.
> 
> It doesn't work because the 'parent' node doesn't have the 'otg' registers.
> It is the child node which has it. The device-tree nodes for parent and
> child are:
> 
> 	usbss0: usb@4104000 {
> 							=> PARENT
> 		bootph-all;
> 		compatible = "ti,j721e-usb";
> 		reg = <0x00 0x4104000 0x00 0x100>;
> 		dma-coherent;
> 
> 		[TRIMMED]
> 
> 		usb0: usb@6000000
> {							=> CHILD
> 			bootph-all;
> 			compatible = "cdns,usb3";
> 			reg = <0x00 0x6000000 0x00 0x10000>,
> 			      <0x00 0x6010000 0x00 0x10000>,
> 			      <0x00 0x6020000 0x00 0x10000>;
> 			reg-names = "otg", "xhci",
> "dev";			=> OTG Register is defined here
> 
> 			[TRIMMED]
> 	};
> 
> The 'udevice' for the child node is created in the cdns3_bind() function
> __after__ the function in this patch is invoked. Therefore, we don't yet
> have the child device which is created by:
> 
> 		device_bind_driver_to_node(parent, driver, name, node,
> &dev);
> 
> I did consider the possibility of using the standard APIs
> (devfdt_remap_addr_name), but since the child device doesn't exist yet,
> they cannot be used. Hence, I had to implement custom logic.
Maybe it would be possible to create a temporary udevice on stack and 
pass it to devfdt_remap_addr_name() ? I think this should be complete 
enough, although I might have missed something:

"
struct udevice cdev = { .parent = parent; };
dev_set_ofnode(cdev, node);
"

devfdt_remap_addr_name() internally calls dev_of_offset(dev) on the 
cdev, tests is device_get_uclass_id(dev->parent) == UCLASS_SIMPLE_BUS 
(it is not) and that is it.
