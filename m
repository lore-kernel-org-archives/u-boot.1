Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D9DC3064D
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A5D488005;
	Tue,  2 Jul 2024 15:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lpzy/iwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AC0787666; Tue,  2 Jul 2024 15:36:31 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE59B88005
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 462DaEae126501;
 Tue, 2 Jul 2024 08:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719927374;
 bh=eNaOTKkjboRZNVyfqtmSOByMGjyf1GbshMm9c5gCbK8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lpzy/iwNj+5zKmkp4n6zs/CVovxNw0BItW/83wYYbc5boqDvs+qcqSAyJTzVjJNxX
 y91HiXC83cpPkdyssny+SuwkpXhC8731A1bNjmuu+16KZNqPaZ0es6Yi2O4GUZgISP
 1BzACuHDDja+A9knxaEkSBxHL8MAZsNWgG7Uuz3o=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 462DaEVD056588
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 2 Jul 2024 08:36:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jul 2024 08:36:13 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jul 2024 08:36:13 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 462DaD6A063933;
 Tue, 2 Jul 2024 08:36:13 -0500
Date: Tue, 2 Jul 2024 19:06:12 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <marex@denx.de>,
 <trini@konsulko.com>, <mkorpershoek@baylibre.com>,
 <u-boot@lists.denx.de>, <u-kumar1@ti.com>, <danishanwar@ti.com>,
 <srk@ti.com>
Subject: Re: [PATCH] usb: cdns3: continue probe even when USB PHY device does
 not exist
Message-ID: <a7f7fccd-6c97-4617-be71-e5986e359adb@ti.com>
References: <20240702120724.368102-1-s-vadapalli@ti.com>
 <f75621af-cfcc-4909-bb79-dbbc9aeb30e2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f75621af-cfcc-4909-bb79-dbbc9aeb30e2@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On Tue, Jul 02, 2024 at 04:20:43PM +0300, Roger Quadros wrote:
> 
> 
> On 02/07/2024 15:07, Siddharth Vadapalli wrote:
> > Prior to commit cd295286c786 ("usb: cdns3: avoid error messages if phys
> > don't exist"), cdns3_probe() errors out only on failing to initialize the
> > USB2/USB3 PHY. However, since commit cd295286c786, absence of the PHY
> > device is also treated as an error, resulting in a regression.
> > 
> > Extend commit cd295286c786 to treat -ENODEV as an acceptable return value
> > of generic_phy_get_by_name() and continue device probe as was the case
> > prior to the commit.
> > 
> > Fixes: cd295286c786 ("usb: cdns3: avoid error messages if phys don't exist")
> > Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > ---
> > 
> > Hello,
> > 
> > This patch is based on commit
> > b4cbd1a257 Merge tag 'u-boot-amlogic-20240701' of https://source.denx.de/u-boot/custodians/u-boot-amlogic into next
> > of the next branch of U-Boot.
> > 
> > Regards,
> > Siddharth.
> > 
> >  drivers/usb/cdns3/core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > index b4e931646b..5b3e32953e 100644
> > --- a/drivers/usb/cdns3/core.c
> > +++ b/drivers/usb/cdns3/core.c
> > @@ -338,7 +338,7 @@ static int cdns3_probe(struct cdns3 *cdns)
> >  			dev_err(dev, "USB2 PHY init failed: %d\n", ret);
> >  			return ret;
> >  		}
> > -	} else if (ret != -ENOENT && ret != -ENODATA) {
> > +	} else if (ret != -ENOENT && ret != -ENODATA && ret != -ENODEV) {
> 
> With this change we will not error out on a genuine error condition
> that produces ENODEV.

It isn't necessarily a genuine error condition which is why it was a
"dev_warn" earlier for any error. If the previous stage has already
configured the PHY, or if the PHY present in the device-tree in Linux is
not the same as the PHY being used at U-Boot (USB 2 PHY at U-Boot vs
SERDES in Linux), then it isn't an error.

> 
> If PHY phandle is not present the API should return ENOENT right?
> 
> static int __of_parse_phandle_with_args(const struct device_node *np,
> 
>         /* Retrieve the phandle list property */
>         list = of_get_property(np, list_name, &size);
>         if (!list)
>                 return -ENOENT;

The PHY phandle is present, but it isn't the one being used by U-Boot.
The device-tree could be pointing to SERDES as the PHY, since Linux uses
USB with SERDES. So the entry exists, but the error is -ENODEV rather
than -ENOENT.

> 
> Can you please check and point where the -ENODEV error is coming from?

The sequence of function calls is as follows:
generic_phy_get_by_name
  generic_phy_get_by_index
    generic_phy_get_by_index_nodev
      uclass_get_device_by_ofnode
        uclass_find_device_by_ofnode
	  -ENODEV

In the above sequence, the device-tree contains SERDES PHY as the USB
PHY since Linux uses the same and U-Boot's device-tree is in sync with
Linux's. However, USB at U-Boot will use the USB 2 PHY. So one option is
to remove the SERDES PHY from USB node to have it fallback to USB 2 PHY.
At the same time, if the previous stage has configured SERDES for example,
it might not be necessary to reconfigure SERDES. -ENODEV might be an
acceptable error in such a situation as well. Please let me know.

[...]

Regards,
Siddharth.
