Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A2C4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 22:59:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D31087D74;
	Sat, 13 Apr 2024 00:59:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=peacevolution.org header.i=@peacevolution.org header.b="iqQ/eQ1P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4484087ED8; Sat, 13 Apr 2024 00:54:29 +0200 (CEST)
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89C1B87D64
 for <u-boot@lists.denx.de>; Sat, 13 Apr 2024 00:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=peacevolution.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aren@peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
 by a.peacevolution.org (Postfix) with ESMTPA id 5550B45BEB;
 Fri, 12 Apr 2024 22:54:24 +0000 (UTC)
Date: Fri, 12 Apr 2024 18:54:21 -0400
From: Aren <aren@peacevolution.org>
To: John Watts <contact@jookia.org>
Cc: u-boot@lists.denx.de, Sam Edwards <cfsworks@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] usb: musb-new: sunxi: support usage with DM_USB_GADGET
Message-ID: <ewekir7xqzojtzn56vtv3tw5u7rdrywewmowbhrd6kjm7efdo5@wrin6nf5vmjc>
References: <20231231203930.1955090-1-aren@peacevolution.org>
 <ZheHOZebMGze5X09@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZheHOZebMGze5X09@titan>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org
 smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
 s=dkim; t=1712962465;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:in-reply-to:references;
 bh=LFHEt/U8RIgglC4yLDShfBXTJ4Dh19gLZiv47PZok7s=;
 b=iqQ/eQ1P66/HrMW1jhEXZYazmuA6MZv3c2soiqTK+WR9mN4UCRRGeTD0Fu5aPfpXcbCs+W
 ZqLW4vnFkVyg6DRYcpB/raRMAZWv9QIadvJatuj3dysqh8R1u9pFVtHT1dVNB3Qda5l5sf
 rmBfui61V+pWvfjT4UaH9F8Vcsl44wA=
X-Mailman-Approved-At: Sat, 13 Apr 2024 00:59:41 +0200
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

On Thu, Apr 11, 2024 at 04:46:17PM +1000, John Watts wrote:
> On Sun, Dec 31, 2023 at 03:38:37PM -0500, Aren Moynihan wrote:
> > Add support for building the sunxi-musb driver with DM_USB_GADGET
> > including adding a separate IRQ handling function and registering the
> > driver with the musb system differently.
> 
> Hi there,
> 
> Were you aware of this similar patch?
> 
> https://lore.kernel.org/u-boot/20230608195631.55364-1-CFSworks@gmail.com/
> 
> If not you might want to test it and compare it.
> 
> John.

I was not aware of that patch, it looks like it does the same thing as
this one, but without some of the bugs. When comparing with it I
realized that my dm_usb_gadget_handle_interrupts function is just plain
wrong.

I'll try to find time to test it soon.

Thanks for the link
 - Aren

> > The implementation of usb_gadget_register_driver from
> > musb-new/musb_uboot.c only works when the gadget driver for the device
> > has already been probed and has called musb_register. On the pinephone
> > (using a allwinner a64 processor) this causes issues when trying to use
> > usb gadget mode (such as from the ums command) and CONFIG_USB_ETHER is
> > disabled.
> > 
> > The implementation of usb_gadget_register_driver provided when
> > DM_USB_GADGET is enabled will probe the necessary drivers when it's
> > called.
> > 
> > Without the patch, this is what the error condition looks like:
> > => ums 0 mmc 1
> > UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3a3e000
> > Controller uninitialized
> > g_dnl_register: failed!, error: -6
> > g_dnl_register failed
> > 
> > based on:
> > commit 2e4865bc6486 ("musb-new: omap2430: fix compiling in DM_USB_GADGET config")
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
