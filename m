Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83452CD129C
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 06:47:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2AB88344;
	Thu, 11 Apr 2024 08:47:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="XgrT3aTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 391E1883CD; Thu, 11 Apr 2024 08:46:57 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3DCB8838C
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
Date: Thu, 11 Apr 2024 16:46:17 +1000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712818013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l/45kKiJWS76tnvoJKCOcV/eMtdCk47DpxrPuyZSTjo=;
 b=XgrT3aTwLJXB09NtqNjoPRcMfF/xZ7lep1GrYc+mVtcEnBTZLsjJ3N/G/fsJEQG7WXZDP9
 weoQYE91LarF7l3TfRFijhLRrUSz3m2YSttEpWgFfdaICRuYokkNkDmoIrmYCUDYAfw5qT
 bG6C4gnhVmhz8a2AlgV96eQaM5nSOGNDwa86zZoKKd4sSz2iidBjXrpFYc3ueXrl5wbdGK
 Jr3t4P91fB8reDDxhKglwX8lUDnYpfN1f8i9+goPVOhlkNa9602CJlm1hNcCU7PguipfPx
 sNq2RzVm13QxgS6dgSsB6lfaLIm/6YBdKJ1BmZSAP1bVYVoyOvGDDMJ1v6oyxw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: John Watts <contact@jookia.org>
To: Aren Moynihan <aren@peacevolution.org>
Cc: u-boot@lists.denx.de, Sam Edwards <cfsworks@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] usb: musb-new: sunxi: support usage with DM_USB_GADGET
Message-ID: <ZheHOZebMGze5X09@titan>
References: <20231231203930.1955090-1-aren@peacevolution.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231231203930.1955090-1-aren@peacevolution.org>
X-Migadu-Flow: FLOW_OUT
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

On Sun, Dec 31, 2023 at 03:38:37PM -0500, Aren Moynihan wrote:
> Add support for building the sunxi-musb driver with DM_USB_GADGET
> including adding a separate IRQ handling function and registering the
> driver with the musb system differently.

Hi there,

Were you aware of this similar patch?

https://lore.kernel.org/u-boot/20230608195631.55364-1-CFSworks@gmail.com/

If not you might want to test it and compare it.

John.

> The implementation of usb_gadget_register_driver from
> musb-new/musb_uboot.c only works when the gadget driver for the device
> has already been probed and has called musb_register. On the pinephone
> (using a allwinner a64 processor) this causes issues when trying to use
> usb gadget mode (such as from the ums command) and CONFIG_USB_ETHER is
> disabled.
> 
> The implementation of usb_gadget_register_driver provided when
> DM_USB_GADGET is enabled will probe the necessary drivers when it's
> called.
> 
> Without the patch, this is what the error condition looks like:
> => ums 0 mmc 1
> UMS: LUN 0, dev mmc 1, hwpart 0, sector 0x0, count 0x3a3e000
> Controller uninitialized
> g_dnl_register: failed!, error: -6
> g_dnl_register failed
> 
> based on:
> commit 2e4865bc6486 ("musb-new: omap2430: fix compiling in DM_USB_GADGET config")
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
