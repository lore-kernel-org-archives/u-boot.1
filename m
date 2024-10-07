Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B349CFB43F
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 12:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C61788C63;
	Mon,  7 Oct 2024 14:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="KGkHu3P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11C788CA8; Mon,  7 Oct 2024 14:21:44 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A22D88AB9
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 14:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 497CLatP087895;
 Mon, 7 Oct 2024 07:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728303696;
 bh=RwwtnrSWNqLTH5hPQP7PAYCO7sUI4VRvW72nKTFCluQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=KGkHu3P3k6yYbF1xoaBr+9VUMeSTwOaqIwvDYaDhxGHC1SQavELOq5CTCRyw7C6sV
 jPDorv4zAuslPXTbbnZPX4JyvohrlQpJ7i4O8UvS47vlvz6iEhe2vThsYgzgMJVt9L
 16w0eF/Pp8HieyJUjxgNPTr9zyf2gXI+aKY82A8Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 497CLahG019594
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Oct 2024 07:21:36 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Oct 2024 07:21:35 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Oct 2024 07:21:36 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.81])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 497CLYtR031011;
 Mon, 7 Oct 2024 07:21:35 -0500
Date: Mon, 7 Oct 2024 17:51:34 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Roger Quadros <rogerq@kernel.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <lukma@denx.de>, <mkorpershoek@baylibre.com>, <marex@denx.de>,
 <vigneshr@ti.com>, <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] usb: gadget: cdns3: Fix cdns3_ep_config() by setting
 ep.maxpacket
Message-ID: <cb413e93-94a4-4fa0-82df-0074efa13d96@ti.com>
References: <20241007104239.1624430-1-s-vadapalli@ti.com>
 <edcf5ebf-d0d1-4722-b61e-016cadb12e63@kernel.org>
 <fcebed5a-e191-4e5c-befe-217a9040dbe7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fcebed5a-e191-4e5c-befe-217a9040dbe7@ti.com>
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

On Mon, Oct 07, 2024 at 05:37:52PM +0530, Siddharth Vadapalli wrote:
> On Mon, Oct 07, 2024 at 03:02:34PM +0300, Roger Quadros wrote:
> 
> Hello Roger,

[...]

> > from include/linux/usb/gadget.h
> > 
> >  * struct usb_ep - device side representation of USB endpoint
> > ...
> >  * @maxpacket:The maximum packet size used on this endpoint.  The initial
> >  *      value can sometimes be reduced (hardware allowing), according to
> >  *      the endpoint descriptor used to configure the endpoint.
> >  * @maxpacket_limit:The maximum packet size value which can be handled by this
> >  *      endpoint. It's set once by UDC driver when endpoint is initialized, and
> >  *      should not be changed. Should not be confused with maxpacket.
> > 
> > What you want to change is ep->maxpacket and not ep->maxpacket_limit as that is
> > fixed for a particular UDC.
> > 
> > how about?
> > 	priv-ep->endpoint.maxpacket = max_packet_size;
> 
> Yes, this is accurate. I will post the v2 patch with this change. Thank
> you for reviewing the patch.

I have implemented your feedback and have posted the v2 patch at:
https://patchwork.ozlabs.org/project/uboot/patch/20241007121927.1680039-1-s-vadapalli@ti.com

Regards,
Siddharth.
