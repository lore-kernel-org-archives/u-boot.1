Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA09BCA1013
	for <u-boot@archiver.kernel.org>; Mon,  8 Sep 2025 07:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1901982AE9;
	Mon,  8 Sep 2025 09:09:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="y9hP/HQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0147D82B20; Mon,  8 Sep 2025 09:09:13 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C90FD82A9E
 for <u-boot@lists.denx.de>; Mon,  8 Sep 2025 09:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 588796pi048138;
 Mon, 8 Sep 2025 02:09:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757315346;
 bh=jMGNMLhf/99s9A7urq9iux4Fypwk3XMbdG6nMR6b4MQ=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=y9hP/HQgUvTQRSUYj5A0I0/qHB6D/VYNgq+Bg9ljbaU4EX19k8vCwfrAlqBBxnDP3
 MeR5wnwjmqsNGMRtJDPcpLXPIvOCz2CeLotPEiH6Cf/y1A962NnO6keS9lrQlx2STS
 pe30h77VD6+83mMy37MzMXe/SvVFD0hRQQub/y/Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 588796l42227978
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 8 Sep 2025 02:09:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Sep 2025 02:09:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 8 Sep 2025 02:09:05 -0500
Received: from localhost (uda0492258.dhcp.ti.com [172.24.231.84])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 588794Ha479623;
 Mon, 8 Sep 2025 02:09:05 -0500
Date: Mon, 8 Sep 2025 12:39:04 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Marek Vasut <marek.vasut@mailbox.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <u-boot@lists.denx.de>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] phy: Reset init count on phy exit failure
Message-ID: <3754b1cf-1b71-4849-a143-eb3bd0590ef2@ti.com>
References: <20250906230052.582621-1-marek.vasut@mailbox.org>
 <0924d46e-9275-461b-bdad-7341f844aea4@ti.com>
 <b06616ae-4472-4512-938c-ab76a189b3d0@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b06616ae-4472-4512-938c-ab76a189b3d0@mailbox.org>
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

On Sun, Sep 07, 2025 at 06:13:33PM +0200, Marek Vasut wrote:
> On 9/7/25 9:18 AM, Siddharth Vadapalli wrote:
> 
> Hi,
> 
> > > diff --git a/drivers/phy/phy-uclass.c b/drivers/phy/phy-uclass.c
> > > index 714be123856..f8d4fb3b41b 100644
> > > --- a/drivers/phy/phy-uclass.c
> > > +++ b/drivers/phy/phy-uclass.c
> > > @@ -274,7 +274,7 @@ int generic_phy_exit(struct phy *phy)
> > >   {
> > >   	struct phy_counts *counts;
> > >   	struct phy_ops const *ops;
> > > -	int ret;
> > > +	int ret = 0;
> > >   	if (!generic_phy_valid(phy))
> > >   		return 0;
> > > @@ -292,12 +292,11 @@ int generic_phy_exit(struct phy *phy)
> > >   		if (ret) {
> > >   			dev_err(phy->dev, "PHY: Failed to exit %s: %d.\n",
> > >   				phy->dev->name, ret);
> > > -			return ret;
> > 
> > I assume that a generic_phy_reset() may be required for generic_phy_init()
> > to succeed after generic_phy_exit() has failed.
> 
> Likely, that's up to the driver(s).
> 
> > While I understand that
> > the current patch allows retrying, this may not be complete in allowing
> > users to make use of the change being brought about by this patch.
> > Nevertheless, the change being proposed in this patch looks good to me.
> This only corrects the inability to retry on failure due to refcount not
> being decremented. Recovery action of the PHY is up to the
> user/driver/consumer .

Thank you for clarifying.

Regards,
Siddharth.
