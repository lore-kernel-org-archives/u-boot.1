Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12400C61DB9
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 09:50:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC1CF406FB;
	Thu, 27 Aug 2026 09:50:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id akwhOijbCXui; Thu, 27 Aug 2026 09:50:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787824241;
	bh=uzfxZ6NrlBZiv2O3Tb+E/Ov2rZTdrwhWZW9h4JXKnuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGECJJIpN1YouZZAMMAdaTzZdsEI+ydJuE8irpeaWhUFcu602iUITSAj+6y35Cog6
	 XPFVybJ6mKctQmfhxoiWLmU43qlkw6LXONFbaUrBPiYpN73zoWuwa8Dxa3z0oiGuE2
	 yBgs+cbZU0dl1VFudrrwNQLNMErYF+NhGbABVZ9sDllLhMIvCYoxC4xTSYfiUn7LNI
	 DoTdigKAFfqJsGlQ22XLqnO/Jf98kdp+h5tY6nXEihOFc72wibHEeBjN8oXxfrGUeT
	 pP57+8RZEPWcNXDns9jOU46+4pBS4OSJdALaUte2xwdMRnQs6Oh1PyFv25LGx9Ug5m
	 F69ea47i6prWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 21D1B406EA;
	Thu, 27 Aug 2026 09:50:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E8B3A3AD
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB01380DC6
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id piraGgqwbXWo for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 09:50:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=k0einIyD; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=RFZgr3oA
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 19EEA807EF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 09:50:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hVxbH0j20zKn8w;
 Thu, 27 Aug 2026 11:50:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787824235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzfxZ6NrlBZiv2O3Tb+E/Ov2rZTdrwhWZW9h4JXKnuE=;
 b=k0einIyDHq2PkVj7nxsGuA/YOFZLh0Ya3qVAQe8arh4Zwm6k5BXn2n2ajeLMdi5yfpUtlS
 /g88M9AK6nEr1q3HWqQOpq5S7bdLY9/Miw8FlybZBvUJNclH9wM2c4CtpnlJprXSHsuMy5
 1K8Na471Q/tlFkaIWqlHUeq/TycerzEGeI771lvJp2L0Y1NaJA8+5wuWHnIPqD9dK7cx01
 LTmtI0Q1uDtf//NNruPtVjWVB8CEfAQbqJyvg3Uf+KikKqDTZPZmbpazjVl60VDO7qKQx8
 +aMB4WyMmtehfRnkscUANUaw1LG2W7BhempV4Cylzu2Im/CYdr00ZCX/IgF/uA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=RFZgr3oA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <6bc22ec6-0a7f-4f9d-b078-bf75d8b42584@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787824233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uzfxZ6NrlBZiv2O3Tb+E/Ov2rZTdrwhWZW9h4JXKnuE=;
 b=RFZgr3oAR4e9NqxnEqwkP2jMX+JSv05U8sLQ5sQguZouo1Mc0y2ijVoh6FiDfYMlYga71i
 75CkDKYLAVTzBKwt+EbAtsjPNcjeoDml343zqMOE6wMfj2U+Xz4DMD5q6DeqRaTD8lt/t9
 UTF4s35mjqQPom3g+2ZxFGJ2q4VMY/cmQeONZabLtUf8Azkk07yYX/86lw99M0nlNQQkDT
 ZTpxqq0ObIDexQHIS3htVaoXsVW0xpqEceb4sspJkou+HETqXJfU70yASBwB6Cqp5sMLTU
 0XgjjS/DGMrjJfcZ0ZWMDU+ROlmbtDg/Wos7+bC00ICJ1JhI1TZqbO/XX+s2hQ==
Date: Wed, 26 Aug 2026 14:27:50 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/6] usb: dwc3: core: only provide legacy gadget IRQ
 handler when USB_DWC3_GADGET
To: Stefan Eichenberger <eichest@gmail.com>
Cc: u-boot@lists.u-boot-project.org, francesco.dolcini@toradex.com,
 trini@konsulko.com, ilias.apalodimas@linaro.org, sbabic@nabladev.com,
 festevam@gmail.com, uboot-imx@nxp.com, marek.vasut+usb@mailbox.org,
 alice.guo@nxp.com, antoine.gouby@toradex.com,
 stefan.eichenberger@toradex.com, emanuele.ghidoli@toradex.com,
 franz.schnyder@toradex.com, balaji.selvanathan@oss.qualcomm.com,
 gurumoorthy.santhakumar@oss.qualcomm.com, mkorpershoek@kernel.org,
 xypron.glpk@gmx.de, casey.connolly@linaro.org,
 hayashi.kunihiko@socionext.com, sean.anderson@linux.dev, sjg@chromium.org,
 ernest.vanhoecke@toradex.com
References: <20260824183048.419198-1-eichest@gmail.com>
 <20260824183048.419198-2-eichest@gmail.com>
 <ab7c860e-2f59-4c60-96dc-0c510a63d64c@mailbox.org>
 <ao6SdYSOzJGKtgIa@eichest-laptop>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ao6SdYSOzJGKtgIa@eichest-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: nhin6w5pumy3oh66excgr5gpm1kkxb9n
X-MBO-RS-ID: 600286fdb5c1e6505a3
X-Rspamd-Queue-Id: 4hVxbH0j20zKn8w
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/26/26 9:15 AM, Stefan Eichenberger wrote:
> On Tue, Aug 25, 2026 at 01:33:27AM +0200, Marek Vasut wrote:
>> On 8/24/26 8:29 PM, Stefan Eichenberger wrote:
>>> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>>
>>> Building a board with USB_DWC3=y (DWC3 used purely as an XHCI host
>>> controller), USB_DWC3_GADGET unset, and DM_USB_GADGET disabled (e.g.
>>> to use CONFIG_CI_UDC for a separate ChipIdea gadget/OTG controller)
>>> fails to link:
>>>
>>> drivers/usb/gadget/ci_udc.o: in function `dm_usb_gadget_handle_interrupts':
>>> drivers/usb/gadget/ci_udc.c:983: multiple definition of `dm_usb_gadget_handle_interrupts';
>>> drivers/usb/dwc3/core.o:drivers/usb/dwc3/core.c:1034: first defined here
>>> drivers/usb/dwc3/core.o: in function `dm_usb_gadget_handle_interrupts':
>>> drivers/usb/dwc3/core.c:1044: undefined reference to `dwc3_gadget_uboot_handle_interrupt'
>>>
>>> Add "&& CONFIG_IS_ENABLED(USB_DWC3_GADGET)" to the guard so this code
>>> is only compiled when the DWC3 gadget driver it depends on is actually
>>> present, matching the Makefile dependency. Boards that combine DWC3
>>> (host) with a separate legacy gadget driver like CI_UDC, with
>>> DM_USB_GADGET disabled, now link correctly. Boards that already use
>>> DWC3 in gadget mode without DM_USB_GADGET are unaffected since
>>> USB_DWC3_GADGET is set for them.
>>>
>>> Fixes: 4d1589808970 ("usb: udc: dwc3: Fold board dm_usb_gadget_handle_interrupts() into DWC3 gadget")
>>> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>>> ---
>>>    drivers/usb/dwc3/core.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index be198041f08..9bff5149c5f 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -1016,7 +1016,7 @@ MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
>>>    MODULE_LICENSE("GPL v2");
>>>    MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
>>> -#if !CONFIG_IS_ENABLED(DM_USB_GADGET)
>>> +#if !CONFIG_IS_ENABLED(DM_USB_GADGET) && CONFIG_IS_ENABLED(USB_DWC3_GADGET)
>>>    __weak int dwc3_uboot_interrupt_status(struct udevice *dev)
>> Simply enable DM_USB_GADGET , then the drivers/usb/gadget/udc/udc-uclass.c
>> dm_usb_gadget_handle_interrupts() is used which correctly invokes the
>> per-controller IRQ handler. DWC3_GADGET should likely depend on
>> DM_USB_GADGET.
> 
> Unfortunately, CI_UDC is not a DM driver yet and it depends on
> !DM_USB_GADGET that's why I can't enable DM_USB_GADGET in that specific
> case. I think NXP is working on changing that driver to DM (at least
> they did that in their BSP). So my hope was to have this as intermediate
> solution. Also in our case we use the DWC3 controller in host mode only,
> so we don't need DWC3_GADGET at all.
Let's convert the CI to DM and be done with it, esp. if there is 
existing code which does it.
