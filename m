Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C2CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA7788B11;
	Mon,  7 Oct 2024 14:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RKfh+B9A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC7FE88B39; Mon,  7 Oct 2024 14:08:02 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C314488AE4
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 497C7sr5084985;
 Mon, 7 Oct 2024 07:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728302874;
 bh=OuhxcRYYubleFz7nOJpTyFGCWHzhmKgMgGFQGmClz9c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RKfh+B9AQollvsdSf+KZLb9cqIPfnXFyEWRhFXLHGvKO30QypoByKMPZhVZlZpXgN
 4f6fq+z3jyvSt1H9/EmAyR1LDXXQtIeXTV4+JjTWVxW6jGS383LH3fYkGhPbBttLiA
 Na8bpkpODOk4iwnuJi3tl/7fmL7jpbpideo73U+U=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 497C7sUU072775
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 07:07:54 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 07:07:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 07:07:53 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 497C7qZv014886;
 Mon, 7 Oct 2024 07:07:53 -0500
Date: Mon, 7 Oct 2024 17:37:52 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <lukma@denx.de>, <mkorpershoek@baylibre.com>, <marex@denx.de>,
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] usb: gadget: cdns3: Fix cdns3_ep_config() by setting
 ep.maxpacket
Message-ID: <fcebed5a-e191-4e5c-befe-217a9040dbe7@ti.com>
References: <20241007104239.1624430-1-s-vadapalli@ti.com>
 <edcf5ebf-d0d1-4722-b61e-016cadb12e63@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <edcf5ebf-d0d1-4722-b61e-016cadb12e63@kernel.org>
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

On Mon, Oct 07, 2024 at 03:02:34PM +0300, Roger Quadros wrote:

Hello Roger,

> On 07/10/2024 13:42, Siddharth Vadapalli wrote:
> > The function cdns3_ep_config() calculates the maximum packet size based
> > on the Endpoint Type and the Gadget Speed and stores it in the variable
> > "max_packet_size". This value is then programmed in the USB Controller
> > for the corresponding Endpoint. This may result in a mismatch between
> > the maximum packet size programmed in the USB controller and the maximum
> > packet size seen by the UDC Core via "maxpacket" member of "struct usb_ep".
> > Additionally, since TD_SIZE is calculated in cdns3_ep_run_transfer() on the
> > basis of the maximum packet size stored in the "maxpacket" member of
> > "struct usb_ep", it may lead to an incorrect value of TD_SIZE when compared
> > with what the USB controller actually expects (max_packet_size).
> > 

[...]

> > diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> > index ac7e469469..b0b08768d9 100644
> > --- a/drivers/usb/cdns3/gadget.c
> > +++ b/drivers/usb/cdns3/gadget.c
> > @@ -1637,6 +1637,14 @@ void cdns3_ep_config(struct cdns3_endpoint *priv_ep)
> >  	else
> >  		priv_ep->trb_burst_size = 16;
> >  
> > +	/*
> > +	 * The Endpoint is configured to handle a maximum packet size of
> > +	 * max_packet_size. Hence, set priv_ep->endpoint.maxpacket to
> > +	 * max_packet_size. This is necessary to ensure that the TD_SIZE
> > +	 * is calculated correctly in cdns3_ep_run_transfer().
> > +	 */
> > +	usb_ep_set_maxpacket_limit(&priv_ep->endpoint, max_packet_size);
> > +
> 
> from include/linux/usb/gadget.h
> 
>  * struct usb_ep - device side representation of USB endpoint
> ...
>  * @maxpacket:The maximum packet size used on this endpoint.  The initial
>  *      value can sometimes be reduced (hardware allowing), according to
>  *      the endpoint descriptor used to configure the endpoint.
>  * @maxpacket_limit:The maximum packet size value which can be handled by this
>  *      endpoint. It's set once by UDC driver when endpoint is initialized, and
>  *      should not be changed. Should not be confused with maxpacket.
> 
> What you want to change is ep->maxpacket and not ep->maxpacket_limit as that is
> fixed for a particular UDC.
> 
> how about?
> 	priv-ep->endpoint.maxpacket = max_packet_size;

Yes, this is accurate. I will post the v2 patch with this change. Thank
you for reviewing the patch.

Regards,
Siddharth.
