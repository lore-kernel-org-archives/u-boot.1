Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44024CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 06:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A5ED80B9B;
	Thu, 21 Aug 2025 08:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UOPi97Ko";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5CAA81FEE; Thu, 21 Aug 2025 08:16:28 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55F6280422
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 08:16:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57L6GILs421882;
 Thu, 21 Aug 2025 01:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755756978;
 bh=j7kx2CDEYiBRVPMDiF5nzdqragPQdtcmkPiWueCcrgg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=UOPi97Ko7+0yUy1EAkmbWgvBGzAvRE2fMeHZKUVPVupzGy+AdF/JNC3GxJaoz3w/w
 4IyKfPh/JNqZHFKO3KWnke1/U2ZYiF9pB2zLL6eRZfYfWZLIELFQSSwYbqWDzrslK8
 xrjL+FlYgVMmOmqfHlc8+7zv3RXUx+cc9qfs/3TQ=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57L6GISi1748959
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 21 Aug 2025 01:16:18 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 21
 Aug 2025 01:16:17 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 21 Aug 2025 01:16:17 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57L6GGxJ1707139;
 Thu, 21 Aug 2025 01:16:17 -0500
Date: Thu, 21 Aug 2025 11:46:16 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
Message-ID: <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
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

On Tue, Aug 19, 2025 at 04:51:25PM +0200, Marek Vasut wrote:

Hello Marek,

> On 8/14/25 12:45 PM, Andrew Goodbody wrote:
> > On 14/08/2025 04:21, Marek Vasut wrote:
> > > On 8/13/25 6:30 PM, Andrew Goodbody wrote:
> > > > The call to cdns3_gadget_ep_free_request will free priv_req so do the
> > > > call to list_del_init which accesses the memory pointed to by priv_req
> > > > before the free.
> > > > 
> > > > This issue was found by Smatch.
> > > > 
> > > > Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> > > > ---
> > > >   drivers/usb/cdns3/gadget.c | 4 ++--
> > > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> > > > index a30c40ef80e..9eaf7e40ab6 100644
> > > > --- a/drivers/usb/cdns3/gadget.c
> > > > +++ b/drivers/usb/cdns3/gadget.c
> > > > @@ -557,10 +557,10 @@ static void
> > > > cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
> > > >           trace_cdns3_wa2(priv_ep, "removes eldest request");
> > > > +        list_del_init(&priv_req->list);
> > > >           kfree(priv_req->request.buf);
> > > >           cdns3_gadget_ep_free_request(&priv_ep->endpoint,
> > > >                            &priv_req->request);
> > > > -        list_del_init(&priv_req->list);
> > > 
> > > Shouldn't the kfree() be moved here instead ?
> > > cdns3_gadget_ep_free_request() also accesses priv_req->request .
> > 
> > No, I do not think so. The kfree frees priv_req->request.buf not
> > priv_req->request so must happen before the call to
> > cdns3_gadget_ep_free_request.
> Thank you for clarifying. Please add this into the commit message, ideally
> wait for TI to test this and provide RB, then send V2 so this can go in.

I was planning to test this patch but the change being made is only
applicable to Controller Versions:
	#define DEV_VER_NXP_V1		0x00024502
	#define DEV_VER_TI_V1		0x00024509
and not to:
	#define DEV_VER_V2		0x0002450C
	#define DEV_VER_V3		0x0002450d

Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
it. However, the change looks correct to me.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
