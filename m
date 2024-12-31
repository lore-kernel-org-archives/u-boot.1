Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CB7E7718B
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 18:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1A5803AC;
	Tue, 31 Dec 2024 19:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1735668798;
	bh=sbCw4ijdaidaoLeDJk4DPiMXiu6r5fFZFQDuXX7Ygxg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=y+A4Nkd2pdrsvLjB/oLnG3ZjdR3JFy2X/0GW3zm9VODbMpAb8uC6Qr2ODQD4/mtGd
	 wdDV0tA+uLC8i97biFzWHBunPJOo7k/nok5UGaC9tHsV5HO4izHaTdUJ1gNFlUOzq/
	 0v040m7W7Y7q+tLRRtBONNltqYd/IttKvrNXCrbr1wTyk8wF6lg56l2K65JpZtMdgP
	 aT1LNeIHshRWyUk0xLek9b8EE2yMTwwziuNKiE+U3u6oWcMinWxRl8BZoEz64NDVZr
	 I5gsqtB8Q5SXF1wL3fTIv17lEivmvzDLF9g0tXHTPCx9rWc68Io5IwaFb4OsUjJ0Ol
	 roYIGRI+qmK+Q==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F9AE803AC; Tue, 31 Dec 2024 19:13:16 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9429C8021D
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 19:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BXZGmJE9"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CDB6510486D87; Tue, 31 Dec 2024 19:13:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1735668792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sbCw4ijdaidaoLeDJk4DPiMXiu6r5fFZFQDuXX7Ygxg=;
 b=BXZGmJE9BFhKdRMWYaXWb8aI7y5kyugmU0JaGeGct0g7vUM0BfS8GPKoYuB7NuHsXrzHPL
 yYaKgq6ylG3BmAZAgBUBvWmKot2tZ2hiH8r8+yd6X3LlDL6EppLdCDchW/1LOTbv6tdu37
 0lkXG6I9zuYfOqXhc58U9DLHiWHrzeGcRSAyk2b9VJVDsNQfLJ+IXmM/c5eutwhYyC99uW
 38VRdnk3Y9lQjj6a6X0ZxTrJ1MqYqgxLSt4jurueibag2pP9kPG0259eakYyhhzMHEsyvt
 KWtA4jPNm9DlEnTIzJF5/PSikw8mxUINGGhz10YecSsGmD2//rxZub2y4PBuMg==
Message-ID: <8baaae27-8e42-4f5d-97e5-088740d0f40f@denx.de>
Date: Tue, 31 Dec 2024 19:08:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] usb: dwc2: Unify flush and reset logic with v4.20a
 support
To: liujh2818@outlook.com, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>
References: <20241230-dwc2-dev-v2-0-12cd9b8a2358@outlook.com>
 <20241230-dwc2-dev-v2-7-12cd9b8a2358@outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241230-dwc2-dev-v2-7-12cd9b8a2358@outlook.com>
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

On 12/30/24 4:30 AM, Junhui Liu via B4 Relay wrote:
> From: Kongyang Liu <seashell11234455@gmail.com>
> 
> This patch merges flush and reset logic for both host and gadget code
> into a common set of functions, reducing duplication. It also adds support
> for the updated reset logic to compatible with core version since v4.20a.
> 
> This patch mainly refers to the patch in the kernel.
> link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=65dc2e725286106f99c6f6b78e3d9c52c15f3a9c
> 
> Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
> Signed-off-by: Junhui Liu <liujh2818@outlook.com>
> ---
>   drivers/usb/common/Makefile                |   2 +
>   drivers/usb/common/dwc2_core.c             | 103 +++++++++++++++++++++++++++++
>   drivers/usb/common/dwc2_core.h             |   4 ++
>   drivers/usb/gadget/dwc2_udc_otg.c          |  12 +---
>   drivers/usb/gadget/dwc2_udc_otg_xfer_dma.c |   6 +-
>   drivers/usb/host/dwc2.c                    |  80 ++--------------------
>   6 files changed, 117 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/usb/common/Makefile b/drivers/usb/common/Makefile
> index 11cc4657a0f403b84b1b8336781e1893d9c7a8f1..73e5bc6d7fdca692276e119911b47db4bf03586a 100644
> --- a/drivers/usb/common/Makefile
> +++ b/drivers/usb/common/Makefile
> @@ -4,6 +4,8 @@
>   #
>   
>   obj-$(CONFIG_$(XPL_)DM_USB) += common.o
> +obj-$(CONFIG_USB_DWC2) += dwc2_core.o
> +obj-$(CONFIG_USB_GADGET_DWC2_OTG) += dwc2_core.o
>   obj-$(CONFIG_USB_ISP1760) += usb_urb.o
>   obj-$(CONFIG_USB_MUSB_HOST) += usb_urb.o
>   obj-$(CONFIG_USB_MUSB_GADGET) += usb_urb.o
> diff --git a/drivers/usb/common/dwc2_core.c b/drivers/usb/common/dwc2_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..323326e05d7b0318d883d4a3b8186b812c42f9ca
> --- /dev/null
> +++ b/drivers/usb/common/dwc2_core.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2024, Kongyang Liu <seashell11234455@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/errno.h>
> +#include <linux/io.h>
> +#include <wait_bit.h>
> +
> +#include "dwc2_core.h"
> +
> +int dwc2_core_reset(struct dwc2_core_regs *regs)
> +{
> +	u32 snpsid;
> +	int ret;
> +	bool host_mode = false;
> +
> +	if (!(readl(&regs->global_regs.gotgctl) & GOTGCTL_CONID_B) ||
> +	    (readl(&regs->global_regs.gusbcfg) & GUSBCFG_FORCEDEVMODE))
> +		host_mode = true;
> +
> +	/* Core Soft Reset */
> +	snpsid = readl(&regs->global_regs.gsnpsid);
> +	writel(GRSTCTL_CSFTRST, &regs->global_regs.grstctl);
> +	if (FIELD_GET(GSNPSID_VER_MASK, snpsid) < 0x420a) {
> +		ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST,
> +					false, 1000, false);
> +		if (ret) {
> +			log_warning("%s: Waiting for GRSTCTL_CSFTRST timeout\n", __func__);
> +			return -EBUSY;

Return -ETIMEDOUT or even better, return ret; to propagate the return 
value of wait_for_bit_le32() as-is , which is really -ETIMEDOUT if the 
wait times out.

> +		}
> +	} else {
> +		ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST_DONE,
> +					true, 1000, false);
> +		if (ret) {
> +			log_warning("%s: Waiting for GRSTCTL_CSFTRST_DONE timeout\n", __func__);
> +			return -EBUSY;

DTTO, return ret;

> +		}
> +		clrsetbits_le32(&regs->global_regs.grstctl, GRSTCTL_CSFTRST, GRSTCTL_CSFTRST_DONE);
> +	}
> +
> +	/* Wait for AHB master IDLE state. */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE,
> +				true, 1000, false);
> +	if (ret) {
> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
> +		return -EBUSY;

DTTO, return ret;

> +	}
> +
> +	if (host_mode) {
> +		ret = wait_for_bit_le32(&regs->global_regs.gintsts, GINTSTS_CURMODE_HOST,
> +					host_mode, 1000, false);
> +		if (ret) {
> +			log_warning("%s: Waiting for GINTSTS_CURMODE_HOST timeout\n", __func__);
> +			return -EBUSY;

DTTO, return ret;

> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void dwc2_flush_tx_fifo(struct dwc2_core_regs *regs, const int num)
> +{
> +	int ret;
> +
> +	log_debug("Flush Tx FIFO %d\n", num);
> +
> +	/* Wait for AHB master IDLE state */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
> +	if (ret)
> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);


Should this function return an integer and an error code on failure ?

> +	writel(GRSTCTL_TXFFLSH | FIELD_PREP(GRSTCTL_TXFNUM_MASK, num), &regs->global_regs.grstctl);
> +
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_TXFFLSH, false, 1000, false);
> +	if (ret)
> +		log_warning("%s: Waiting for GRSTCTL_TXFFLSH timeout\n", __func__);
> +
> +	/* Wait for 3 PHY Clocks */
> +	udelay(1);
> +}
> +
> +void dwc2_flush_rx_fifo(struct dwc2_core_regs *regs)
> +{
> +	int ret;
> +
> +	log_debug("Flush Rx FIFO\n");
> +
> +	/* Wait for AHB master IDLE state */
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_AHBIDLE, true, 1000, false);
> +	if (ret)
> +		log_warning("%s: Waiting for GRSTCTL_AHBIDLE timeout\n", __func__);
> +
> +	writel(GRSTCTL_RXFFLSH, &regs->global_regs.grstctl);
> +
> +	ret = wait_for_bit_le32(&regs->global_regs.grstctl, GRSTCTL_RXFFLSH, false, 1000, false);
> +	if (ret)
> +		log_warning("%s: Waiting for GRSTCTL_RXFFLSH timeout\n", __func__);
> +
> +	/* Wait for 3 PHY Clocks */
> +	udelay(1);

Shouldn't this delay be derived from the PHY clock frequency somehow ?
Are we sure 1us is always sufficient ?

> +}
[...]
