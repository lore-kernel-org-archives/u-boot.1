Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6D6E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 11:38:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E97798021A;
	Wed, 18 Dec 2024 12:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D0nnc2y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091568021A; Wed, 18 Dec 2024 12:38:56 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D601180214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 12:38:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BIBcW0n3622015
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 18 Dec 2024 05:38:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734521912;
 bh=eBRzPKUEnIP5XE5eBFGJjbhs+AJc3qoO/oCFbignefs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=D0nnc2y9paUQw5jnGccvrhYEfwweM1tMWKc6KXxSo0N189veCVLkaLmepzk+G+X6G
 ywsLqHmRBQf1YnJJy0eWxY//PPgTIj22iPZP3zppB2P8/KY5MmedV7EuHqfulIOuEp
 srjbg/8+oSDCYiDHYQPTbnc04GcOxAQSyt4MMORI=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIBcWIV009296;
 Wed, 18 Dec 2024 05:38:32 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 18
 Dec 2024 05:38:32 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 18 Dec 2024 05:38:32 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BIBcUqB065495;
 Wed, 18 Dec 2024 05:38:31 -0600
Date: Wed, 18 Dec 2024 17:08:30 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, 
 <trini@konsulko.com>, <lukma@denx.de>, <n-francis@ti.com>,
 <afd@ti.com>, <glaroque@baylibre.com>, <sjoerd@collabora.com>,
 <martyn.welch@collabora.com>, <rasmus.villemoes@prevas.dk>,
 <caleb.connolly@linaro.org>, <j-humphreys@ti.com>, <rogerq@kernel.org>,
 <nm@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 2/4] board: ti: am62px: env: include environment for DFU
 Boot
Message-ID: <lsee53tp2jgp3hmiixlk6crexsxqtona46xufeuipj3c4mopmb@ezuvytz3oojv>
References: <20241217131658.2920799-1-s-vadapalli@ti.com>
 <20241217131658.2920799-3-s-vadapalli@ti.com>
 <87y10dwbxr.fsf@baylibre.com>
 <g7pupq6leeait24a4uqf3toncr5knxl2ffjvxtqesp4uymacdq@c3vsv5ee5mdt>
 <87msgtw91j.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msgtw91j.fsf@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On Wed, Dec 18, 2024 at 12:00:08PM +0100, Mattijs Korpershoek wrote:
> On mer., déc. 18, 2024 at 15:44, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> 
> > On Wed, Dec 18, 2024 at 10:57:36AM +0100, Mattijs Korpershoek wrote:
> >
> > Hello Mattijs,
> >
> >> Hi Siddharth,
> >> 
> >> Thank you for the patch.

[...]

> >> This change seems un-related, is it needed?
> >
> > My editor automatically adds a newline, thereby fixing the warning/error
> > regarding the absence of a newline. I assume that a newline is expected.
> > Please let me know if you want me to undo this in the v2 series.
> 
> This is editor dependant. I'm not sure if there is a coding style entry
> for having a newline present/absent.
> I'm in favor of keeping the newline addition, however, please mention
> it in the commit message.
> 
> Something between the lines of "while at it, also add a missing newline
> to the am62p.env file".

Sure, I will mention this in the commit message.

> 
> >
> >> 
> >> Also, looking at Martyn's/Sjoerd's series, I see a couple of things
> >> missing:
> >> 1. Documentation. now that am62px is compatible with the
> >>    am62x_r5_usbdfu.config fragment, we need to document this in the board
> >>    docs. See: commit def64b493748 ("doc: board: Add document for DFU boot on am62x SoCs")
> >
> > I planned on documenting it once this series got merged. The reason
> > behind it is that I was unsure if the device-tree patch in this series
> > will be accepted or will be asked to be enabled via the Linux DT Sync
> > process. In the latter case, documenting this feature will be incorrect
> > in the event of a partial merge (i.e. the documentation patch gets
> > merged but the device-tree patch doesn't).
> 
> Hmm, I'm not the one deciding if [PATCH 4/4] will get applied so I can't
> chime in on that. However, I think it's good practice to send the
> documentation changes along with the code changes. Otherwise, doc
> updates might be forgotten/de-prioritized.
> 
> I won't block the series if doc does not get send, though.
> 
> Maybe for future submissions, you can consider writing this in the cover
> letter:
> 
> "Since i'm unsure that PATCH 4/4 will be accepted, I've decided to send
> the documentation changes in a future series"

I will include the documentation in the v2 series, while also pointing
out that if the device-tree changes don't get in, then the documentation
patch should also be dropped.

> 
> >
> >> 
> >> 2. Including configs/am62x_a53_usbdfu.config in configs/am62px_evm_a53_defconfig.
> >>    This is how it's done for am62x, see:
> >>    commit dfc2dff5a844 ("configs: am62x_evm_*: Enable USB and DFU support")
> >> 
> >> Note that If we don't do 2), we cannot use USB gadget from a U-Boot that
> >> has been booted over DFU:
> >> 
> >>     => fastboot usb 0
> >>     No USB device found
> >>     USB init failed: -19
> >>     => usb list
> >>     USB is stopped. Please issue 'usb start' first.
> >>     => usb start
> >>     starting USB...
> >>     No USB controllers found
> >>     =>
> >> 
> >> For 2, this diff fixes it:
> >> 
> >> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
> >> index 9635beb1b27e..81f433c997b5 100644
> >> --- a/configs/am62px_evm_a53_defconfig
> >> +++ b/configs/am62px_evm_a53_defconfig
> >> @@ -183,3 +183,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
> >>  CONFIG_EFI_SET_TIME=y
> >>  
> >>  #include <configs/k3_efi_capsule.config>
> >> +#include <configs/am62x_a53_usbdfu.config>
> >> 
> >> In my opinion, 2) is a valid use case:
> >> 1. On a blank board, we boot the bootloaders over DFU
> >> 2. Once U-Boot is started, we start fastboot to flash all images to eMMC.
> >> 
> >> Could this be added for v2, please?
> >
> > Sure, I will include it in the v2 series. Thank you for reviewing this
> > patch and sharing feedback.
> 
> Make sure to check that am62px_evm_a53_defconfig does not contain any
> duplicate entries with the dfu fragment, like:
> 
> CONFIG_USB_GADGET_MANUFACTURER="Texas Instruments"
> CONFIG_USB_GADGET_VENDOR_NUM=0x0451
> CONFIG_USB_GADGET_PRODUCT_NUM=0x6165

I will keep this in mind. Thank you.

Regards,
Siddharth.
