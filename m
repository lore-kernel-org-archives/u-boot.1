Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8183C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE5187F50;
	Thu, 28 Mar 2024 13:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gJfVNSLO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18D778810E; Thu, 28 Mar 2024 13:05:06 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC29787D9C
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SC4qPL089785;
 Thu, 28 Mar 2024 07:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1711627492;
 bh=6/XZo+TAyIV6DMPlKqYHRzUwe2loGuk1/Smhj53az3s=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=gJfVNSLODHR46V8sETJo7Fk04MyD63IZc3XKqx9M8QDtwb8kk6E0YOzXaY+oG60tM
 0F87tDj98t5WtYuRvIMckbrqEsLuKlKUTrjXG+5yipJPPR1N1UHWveYbT/uKPiOk0j
 6qcuOOprt3aPcOPp6PipTGvPkeyU1jXw1v1Gd5xo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SC4qie064232
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 28 Mar 2024 07:04:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 07:04:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 07:04:52 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SC4pwv081579;
 Thu, 28 Mar 2024 07:04:51 -0500
Date: Thu, 28 Mar 2024 07:04:51 -0500
From: Nishanth Menon <nm@ti.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
CC: "rogerq@kernel.org" <rogerq@kernel.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "dannenberg@ti.com" <dannenberg@ti.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, "s-anna@ti.com" <s-anna@ti.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] net: ti: am65-cpsw-nuss: handle missing PHY in
 am65_cpsw_phy_init() gracefully
Message-ID: <20240328120451.tkj2e3nk35wbfsjz@isotope>
References: <20240328062914.486999-1-alexander.sverdlin@siemens.com>
 <20240328114541.pep2fszctvzc3qqt@slept>
 <b7627659d44bad98fce87d4526bb8fb105a9233c.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b7627659d44bad98fce87d4526bb8fb105a9233c.camel@siemens.com>
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

On 11:53-20240328, Sverdlin, Alexander wrote:
[..]
> > Btw, this no longer applies on next. only applies on master. Depending
> > on where Tom would like to apply this change, might need a rebase.
> 
> Thanks for the hint! I've totally missed this!
> And I'm even not sure the patch makes sense on "next".
> I'd need to retest if the problem is still there (and if there would be one,
> then it's rather subsystem problem, not am65-cpsw any more.
> 
> So the patch only makes sense for stable branches, if any.

On next, I think a variant of the patch will be needed as well. I see
the same bug on latest next as well (ab8d9ca3044a Merge tag
'v2024.04-rc5' into next)

https://gist.github.com/nmenon/691ccd210ed7e1add4c865ca9a698f2e

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
