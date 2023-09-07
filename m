Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E079EC8726
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 18:10:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEF6986784;
	Thu,  7 Sep 2023 20:10:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jCFCS94f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6040486784; Thu,  7 Sep 2023 20:10:00 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00E508644F
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 20:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 387I9s5p081415;
 Thu, 7 Sep 2023 13:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694110194;
 bh=iSNSfmtEDfNx6O44yL01GdU16Q0yq4yXEGDSapw3bhI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=jCFCS94fmkCe8Ond55PISsyrcp2t2/Itv6jKJPLdHILShm4qzcggRv+7YEyWOnMEG
 FYkvf0rrQMXxIFnl5G1AVZLSGAOGw0jYt1ZehIZ20RpSHDSFf94SCZm/jYXKRB2DTO
 kg3EyQ31x51wQkA45k+989ajhJvBtCNPeelwjbE4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 387I9sTv123290
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Sep 2023 13:09:54 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Sep 2023 13:09:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Sep 2023 13:09:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 387I9s1g079546;
 Thu, 7 Sep 2023 13:09:54 -0500
Date: Thu, 7 Sep 2023 13:09:54 -0500
From: reidt <reidt@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>
Subject: Re: [PATCH v2 1/7] drivers: misc: k3_avs: Add linux compatible to
 maintain sync
Message-ID: <20230907180954.h6zxgoiif6z73nq6@reidt-HP-Z2>
References: <20230907141407.382215-1-n-francis@ti.com>
 <20230907141407.382215-2-n-francis@ti.com>
 <20230907150858.3l6q2yxyfgdx3jvn@mulled>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230907150858.3l6q2yxyfgdx3jvn@mulled>
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

On 10:08-20230907, Nishanth Menon wrote:
> On 19:44-20230907, Neha Malcom Francis wrote:
> > The U-Boot AVS driver works on the VTM (Voltage and Thermal Management)
> > module, also used by the Linux TI Bandgap temperature sensor driver
> > (drivers/thermal/k3_j72xx_bandgap.c). Although the purpose and
> > functionalities that these two implement are different, the hardware is
> > the same, so ensure that their compatibles are in sync. Thus, add
> > ti,j721e-vtm compatible to the AVS driver.
> > 
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > ---
> >  drivers/misc/k3_avs.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> > index 840148d090..3008cf9810 100644
> > --- a/drivers/misc/k3_avs.c
> > +++ b/drivers/misc/k3_avs.c
> > @@ -382,6 +382,7 @@ static struct vd_config am654_vd_config = {
> >  static const struct udevice_id k3_avs_ids[] = {
> >  	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
> >  	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
> > +	{ .compatible = "ti,j721e-vtm", .data = (ulong)&j721e_vd_config },
> >  	{}
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> https://lore.kernel.org/all/52a7c0b2-7a87-c74e-e63f-d07821ffc1f8@ti.com/
> 
> we are going to end up creating a dependency nightmare.
> 
> Can we just do a single series(might be just a single patch) for
> compatible additions for k3_avs.c and make the dts syncs dependent on this?
>

I submitted one here if this works:
https://lore.kernel.org/u-boot/20230907180635.89011-1-reidt@ti.com/T/#u

-Reid

> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
