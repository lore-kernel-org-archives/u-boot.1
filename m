Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECFCE7E62A
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 04:15:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68E1286BF5;
	Wed, 27 Sep 2023 06:15:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mlHR0rqY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 092BE86D36; Wed, 27 Sep 2023 06:15:41 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92BE8609B
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 06:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38R4FaFE104767;
 Tue, 26 Sep 2023 23:15:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695788136;
 bh=ZA3DU0mzgaXqdblr5O0XpUk6eK7h4lkaJkaLJjLMx04=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mlHR0rqY5f0J62oCxBqETz5uYW5vV1ScPVXfIMkmuhYZOoGZHYPrO85UTnQcbKPlU
 V4mA7OxfWpszqRNxco6Wv09Jjd6dp/w8umyhOPEdgxmQ2RNs770EJ3vVY+euuv5ySN
 bOnuUDSz3AmI9kE9x+JVIn3L8uZ3iUpLvv+ylxpg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38R4FaDB001347
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 23:15:36 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 23:15:36 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 23:15:36 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38R4FZTa005221;
 Tue, 26 Sep 2023 23:15:35 -0500
Date: Wed, 27 Sep 2023 09:45:34 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: Nishanth Menon <nm@ti.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>, <gadiyar@ti.com>,
 <a-nandan@ti.com>, <vaishnav.a@ti.com>, <b-kapoor@ti.com>, <bb@ti.com>,
 <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 6/6] arm: dts: k3-j721e: Sync with v6.6-rc1
Message-ID: <20230927041525.6ewaeomgilnbjtro@ula0497581>
References: <20230922103954.3454891-1-n-francis@ti.com>
 <20230922103954.3454891-7-n-francis@ti.com>
 <20230925140230.c6pr7hxjhxyalh2z@carpentry>
 <1973a1e4-a22b-4010-af68-b7513135a3eb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1973a1e4-a22b-4010-af68-b7513135a3eb@ti.com>
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

Hi Neha,

On 19:03-20230926, Neha Malcom Francis wrote:
> Hi Nishanth
> 
[..]
> > > diff --git a/arch/arm/dts/k3-j721e-r5-sk.dts b/arch/arm/dts/k3-j721e-r5-sk.dts
> > > index 1cc64d07f7..0274465fa4 100644
> > > --- a/arch/arm/dts/k3-j721e-r5-sk.dts
> > > +++ b/arch/arm/dts/k3-j721e-r5-sk.dts
> > 
> > Unrelated to this patch: I noticed also that the DDR configuration for
> > J721e-sk is stale (0.6 rev of DDR tool Vs 0.10 for EVM)
> > 
> > 
> > For SK's R5 dts and u-boot.dtsi:
> > The above pattern of comments from EVM repeat on SK as well, I will skip
> > repeating the comments.
> > 
> > [...]
> > 
> 
> Thanks for reviewing, all are valid points. Regarding why clock-frequency is
> mentioned for a bunch of peripherals, I will be looking into it and
> accordingly posting v4.

Not sure but could be that the clk-data.c is not populated with those
specified clocks with frequencies due to which we have to provide them
here. I could see that autogen does allow us to set some fixed clock
frequency so maybe that might be it.

Regards,
Manorit

> 
> Thanking You
> Neha Malcom Francis
