Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4B5C02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 10:19:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A56C801B0;
	Thu, 16 Jan 2025 11:19:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fv8MgtXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 637B380283; Thu, 16 Jan 2025 11:18:59 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1E6480040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 11:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50GAIYQQ4193756
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jan 2025 04:18:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1737022714;
 bh=oWVhx93/Ehwvj8njv25dN/9VnWQDoIiCFspyehUwdgU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fv8MgtXqCJEKMlfoC7CZcQtrlmTWqiV66YVeFxHYtqyFuk7EqzvXbXXZpjfqGQ3/O
 Lzq6HcPNZrpwD5X89xPuS2PQlZ0oQacQLqpzxex8HNd3jLZIuxg0sMhdVEBy7QLuq8
 r+uviQW+qdWBo1tSkhmskRd2JZE67y5HDF1uqUNA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50GAIYld018928
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 16 Jan 2025 04:18:34 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 16
 Jan 2025 04:18:34 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 16 Jan 2025 04:18:34 -0600
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.104])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50GAIXOt004782;
 Thu, 16 Jan 2025 04:18:33 -0600
Date: Thu, 16 Jan 2025 15:48:32 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: Roger Quadros <rogerq@kernel.org>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <marex@denx.de>, <bmeng.cn@gmail.com>, <jonas@kwiboo.se>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] usb: xhci-dwc3: Bail out if "dr_mode" is "peripheral"
Message-ID: <mjtlqk7ddt7mjxu62vl3fpizhu5djemaodlpuprh2dp2kfukwh@y4vyhmxfbdxm>
References: <20241206110424.897283-1-s-vadapalli@ti.com>
 <ceb060fa-d430-458d-b711-508a4bd34d48@kernel.org>
 <87cygn85hu.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cygn85hu.fsf@baylibre.com>
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

On Thu, Jan 16, 2025 at 10:36:45AM +0100, Mattijs Korpershoek wrote:
> Hi Siddharth,

Hello Mattijs,

> 
> On lun., déc. 09, 2024 at 15:20, Roger Quadros <rogerq@kernel.org> wrote:
> 
> > Hi Siddharth,
> >
> > On 06/12/2024 13:04, Siddharth Vadapalli wrote:

[...]

> >> diff --git a/drivers/usb/host/xhci-dwc3.c b/drivers/usb/host/xhci-dwc3.c
> >> index e3e0ceff43e..7b1311503fe 100644
> >> --- a/drivers/usb/host/xhci-dwc3.c
> >> +++ b/drivers/usb/host/xhci-dwc3.c
> >> @@ -208,6 +208,9 @@ static int xhci_dwc3_probe(struct udevice *dev)
> >>  	writel(reg, &dwc3_reg->g_usb2phycfg[0]);
> >>  
> >>  	dr_mode = usb_get_dr_mode(dev_ofnode(dev));
> >> +	if (dr_mode == USB_DR_MODE_PERIPHERAL)
> >> +		return -ENODEV;
> >> +
> >>  	if (dr_mode == USB_DR_MODE_OTG &&
> >>  	    dev_read_bool(dev, "usb-role-switch")) {
> >>  		dr_mode = usb_get_role_switch_default_mode(dev_ofnode(dev));
> >
> > Although this proposal was suggested in [1] and later clarified in
> > [2] I will summarize the discussion here.
> >
> > This patch fix is not sufficient for all cases as the xhci-dwc3.c
> > driver will still be probed if dr_mode is OTG or HOST along with
> > other platform drivers if enabled in config.
> >
> > The only current solution is not not enable CONFIG_USB_XHCI_DWC3
> > together with another platform driver config (e.g. CONFIG_USB_DWC3_GENERIC)
> > if snps,dwc3 should not be managed by xhci-dwc3.c.
> 
> Given Roger's explanation, should we simply drop this, or is any other
> action expected from the U-Boot maintainers?

This patch could be dropped. Roger's suggestion is to fix this issue by
updating the platform configs wherein CONFIG_USB_XHCI_DWC3 should be
disabled on platforms that have "dr_mode" set to "peripheral".

Regards,
Siddharth.
