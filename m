Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5868CA0EEB
	for <u-boot@archiver.kernel.org>; Sat, 23 Aug 2025 02:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B39A681D5D;
	Sat, 23 Aug 2025 04:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Iws+Ob5B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0061E82BF6; Sat, 23 Aug 2025 04:07:41 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A423680422
 for <u-boot@lists.denx.de>; Sat, 23 Aug 2025 04:07:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57N27QJ7368001;
 Fri, 22 Aug 2025 21:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1755914846;
 bh=6nTVz849EflvDH/x8ksCHhqtdtDNnt1FG2sS2TT7tX8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Iws+Ob5BUgVi5dAI6mp3YS3QKLXYLZipvTi8o4ga1pxkbNBv9mCVu0PqJ2JPFzpRU
 eM+uZAWoemVdGu2VypRBg6wqwslKdJHbfdV7CUWNnPFGMNGc/99sQe0M5bIwd3nnu6
 hpwFFPfJOQlfbAnuv3Guptca//wfFSC8dqc2j4xw=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57N27Q733339330
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 22 Aug 2025 21:07:26 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 22
 Aug 2025 21:07:25 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 22 Aug 2025 21:07:25 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57N27OpJ506750;
 Fri, 22 Aug 2025 21:07:24 -0500
Date: Sat, 23 Aug 2025 07:37:23 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] usb: cdns3: Do not access memory after free
Message-ID: <a6bb77e3-2702-469d-a684-0dce753e78b0@ti.com>
References: <20250813-usb_cdns3-v1-1-3779912fe660@linaro.org>
 <b83f79a7-66e9-43b9-859e-ebb69e4d536b@nabladev.com>
 <0a4f4611-8858-4a38-be70-bf0947d689c1@linaro.org>
 <84535d73-7496-4fd3-8ecb-ac6830974d51@mailbox.org>
 <e2257066-ee97-44ff-9338-cec69f8c7f03@ti.com>
 <2ff9412a-795c-422b-9be4-576e64a7f395@mailbox.org>
 <63d6759a-a8be-41d6-8870-72bdc3856c05@ti.com>
 <bf35a459-29dc-48f8-a353-7f75493e959c@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf35a459-29dc-48f8-a353-7f75493e959c@mailbox.org>
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

On Fri, Aug 22, 2025 at 04:55:49PM +0200, Marek Vasut wrote:
> On 8/22/25 4:14 PM, Siddharth Vadapalli wrote:
> > On Thu, Aug 21, 2025 at 10:22:43PM +0200, Marek Vasut wrote:
> > > On 8/21/25 8:16 AM, Siddharth Vadapalli wrote:
> > > 
> > > Hi,
> > > 
> > > > > > > > diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> > > > > > > > index a30c40ef80e..9eaf7e40ab6 100644
> > > > > > > > --- a/drivers/usb/cdns3/gadget.c
> > > > > > > > +++ b/drivers/usb/cdns3/gadget.c
> > > > > > > > @@ -557,10 +557,10 @@ static void
> > > > > > > > cdns3_wa2_remove_old_request(struct cdns3_endpoint *priv_ep)
> > > > > > > >             trace_cdns3_wa2(priv_ep, "removes eldest request");
> > > > > > > > +        list_del_init(&priv_req->list);
> > > > > > > >             kfree(priv_req->request.buf);
> > > > > > > >             cdns3_gadget_ep_free_request(&priv_ep->endpoint,
> > > > > > > >                              &priv_req->request);
> > > > > > > > -        list_del_init(&priv_req->list);
> > > > > > > 
> > > > > > > Shouldn't the kfree() be moved here instead ?
> > > > > > > cdns3_gadget_ep_free_request() also accesses priv_req->request .
> > > > > > 
> > > > > > No, I do not think so. The kfree frees priv_req->request.buf not
> > > > > > priv_req->request so must happen before the call to
> > > > > > cdns3_gadget_ep_free_request.
> > > > > Thank you for clarifying. Please add this into the commit message, ideally
> > > > > wait for TI to test this and provide RB, then send V2 so this can go in.
> > > > 
> > > > I was planning to test this patch but the change being made is only
> > > > applicable to Controller Versions:
> > > > 	#define DEV_VER_NXP_V1		0x00024502
> > > > 	#define DEV_VER_TI_V1		0x00024509
> > > > and not to:
> > > > 	#define DEV_VER_V2		0x0002450C
> > > > 	#define DEV_VER_V3		0x0002450d
> > > > 
> > > > Since I don't have an SoC and a Board with DEV_VER_TI_V1, I cannot test
> > > > it. However, the change looks correct to me.
> > > > 
> > > > Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > The change does indeed look correct.
> > > 
> > > Do you know who might still have that board and could test ? (and which
> > > board/soc is that) ?
> > 
> > None of the boards that I have worked with have a DEV_VER_TI_V1 version
> > of the controller. I also tried to use the Linux device-tree to check if
> > I could identify the SoC/board but I was unable to do so.
> Do you know which SoC is V2 and V3 ?

I spent more time on this and found out that J721E SR 1.0 has the
controller with DEV_VER_TI_V1 version but other revisions of J721E as
well as all of the following SoCs have DEV_VER_V3 version of the
controller:
AM64, AM68, AM69, J7200, J721S2, J722S, J742S2 and J784S4.

I will try to find an SR 1.0 J721E SoC and test the patch on it and
share the results here.

Regards,
Siddharth.
