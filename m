Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9485FEDF172
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:05:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C9783DF3;
	Fri, 13 Feb 2026 16:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="D2Ddmn3g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D0A83C4B; Fri, 13 Feb 2026 16:05:01 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87ED682A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4fCFp03G8hz9scD;
 Fri, 13 Feb 2026 16:04:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770995096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97ikCDFMcp9OEQo+qfcKhILErWCHbBneLRLpPxR2kZc=;
 b=D2Ddmn3g42ToCiF8RGqptynbZcu4q8u+38V3qviZNYT+APXmD7mXmJaAgYaDmIPpzk0PEY
 qHQsDRsf48Tvdcv9wOBK6v+xGZ/Lby4KpbO3Oe20IaYkbATuw6X4nUApsNKPeyzedxPUGl
 GxyUdo6xDsfw6q6v7BAu1LZbmtZVXnMaLIu8BAM7G8HVsETU3WpqB1W8FCFbryNNjLVWx7
 dG8uA7u/MRZd8GCBqLKhpnJcfmAyJ/Vz7avz635hMK9LyyDWjJQxbaLFx69sKv96v1dwrE
 7wBco000v5t7d51hKT0D0Dk7I7GJjCUOUmQyUqhXkBIXjlmeJ3dcllqx7jSMfA==
Message-ID: <595b83ef-f83f-4ee6-8026-853a7eb89f62@mailbox.org>
Date: Fri, 13 Feb 2026 16:04:53 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb: cdns3: use VBUS Valid to determine role for
 dr_mode OTG
To: Siddharth Vadapalli <s-vadapalli@ti.com>, marex@denx.de,
 trini@konsulko.com, minda.chen@starfivetech.com
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20260213051556.1247716-1-s-vadapalli@ti.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260213051556.1247716-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: kx4h1gb38mrugkqfq1nstebgwjc6if8p
X-MBO-RS-ID: 548dd2731897640f40d
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

On 2/13/26 6:15 AM, Siddharth Vadapalli wrote:

[...]

> +++ b/drivers/usb/cdns3/core.c
> @@ -392,6 +392,63 @@ static const struct udevice_id cdns3_ids[] = {
>   	{ },
>   };
>   
> +/*
> + * The VBUS Valid Bit in the OTG Status register can be used to determine
> + * the role. When VBUS Valid is set, it indicates that a USB Host is supplying
> + * power, so the Controller should assume the PERIPHERAL role. If it isn't set,
> + * it indicates the absence of a USB Host, so the Controller should assume the
> + * HOST role. If the OTG Status register is inaccessible, return an error.
> + */
> +static int cdns3_get_otg_mode(ofnode node

Pass struct udevice *parent instead of node here ...

> , enum usb_dr_mode *mode)
> +{
> +	struct cdns3 cdns, *cdnsp;
> +	void __iomem *otg_regs;
> +	fdt_addr_t otg_addr;
> +	int otg_reg_index;
> +	int vbus;
> +
> +	otg_reg_index = ofnode_stringlist_search(node, "reg-names", "otg");
> +	if (otg_reg_index < 0) {
> +		printf("%s: dr_mode is otg but otg register name is missing\n", __func__);
> +		return -ENOENT;
> +	}
> +
> +	otg_addr = ofnode_get_addr_index(node, otg_reg_index);
> +	if (otg_addr == FDT_ADDR_T_NONE) {
> +		printf("%s: address of otg registers is unspecified\n", __func__);
> +		return -ENOENT;
> +	}
> +
> +	otg_regs = map_physmem(otg_addr, 0, MAP_NOCACHE);
> +	if (!otg_regs) {
> +		printf("%s: failed to map otg registers\n", __func__);
> +		return -EINVAL;
> +	}

... and replace all that ^ with devfdt_remap_addr_name(parent, "otg") . 
That should work.
