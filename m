Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B342EE14D3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 19:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 140CC865A2;
	Wed,  6 Sep 2023 21:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CTy678Uw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 752D5865A8; Wed,  6 Sep 2023 21:28:40 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8FB98655E
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 21:28:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=reidt@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 386JSY6k127356;
 Wed, 6 Sep 2023 14:28:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694028514;
 bh=FLcRNO4tfCbgvn7HXqOnAM0m8WOmOZmDr7Gif43B3ro=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CTy678Uw9iK11KZ+vXpkrqOtbYOD4eGM49oM3/8Jqvkbt+4UYIXPHxtr5h3HnT/14
 UXfxHh+ZFvv9BqLDRWUICEixcDUj7G5f2lZkhtDP7O6KWWqGtAjTO/cNsZV75+D9cq
 dg+gEJZEGys4k4OIPUar0OubAz47YMkvX97mP7Ms=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 386JSY15024282
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 6 Sep 2023 14:28:34 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Sep 2023 14:28:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Sep 2023 14:28:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 386JSYxE036584;
 Wed, 6 Sep 2023 14:28:34 -0500
Date: Wed, 6 Sep 2023 14:28:34 -0500
From: reidt <reidt@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <afd@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: Re: [PATCH 1/3] drivers: misc: k3_avs: Add Linux compatible to
 enable avs in u-boot
Message-ID: <20230906192834.54weltwklcmgclto@reidt-HP-Z2>
References: <20230905181309.61666-1-reidt@ti.com>
 <20230905181309.61666-2-reidt@ti.com>
 <20230906180631.6cn5dva5ie3xm74w@slinky>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230906180631.6cn5dva5ie3xm74w@slinky>
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

On 13:06-20230906, Nishanth Menon wrote:
> On 13:13-20230905, Reid Tonking wrote:
> > The ti,j7200-vtm compatible is used for voltage and thermal monitoring 
> > (VTM) by (drivers/thermal/k3_j72xx_bandgap.c) in Linux, but the same 
> > hardware is used for adaptive voltage scaling (AVS) in u-boot, This brings
> > both drivers in line with the same compatible. Since the j7200 uses the 
> > config as the j721e, the data is inherited from j721e vs creating a 
> > duplicate in all but name.
> > 
> > Signed-off-by: Reid Tonking <reidt@ti.com>
> > ---
> >  drivers/misc/k3_avs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/k3_avs.c b/drivers/misc/k3_avs.c
> > index 840148d090..f7936017ba 100644
> > --- a/drivers/misc/k3_avs.c
> > +++ b/drivers/misc/k3_avs.c
> > @@ -382,7 +382,7 @@ static struct vd_config am654_vd_config = {
> >  static const struct udevice_id k3_avs_ids[] = {
> >  	{ .compatible = "ti,am654-avs", .data = (ulong)&am654_vd_config },
> >  	{ .compatible = "ti,j721e-avs", .data = (ulong)&j721e_vd_config },
> > -	{}
> > +	{ .compatible = "ti,j7200-vtm", .data = (ulong)&j721e_vd_config }
> you don't need the null terminator?
>

Ah, I wasn't aware of its purpose until now, but searched it up. 
I'll add it back in for v3.

> >  };
> >  
> >  U_BOOT_DRIVER(k3_avs) = {
> > -- 
> > 2.34.1
> > 
> https://lore.kernel.org/all/1fed9388-dfc4-0b9c-4502-b5020b2aed1a@ti.com/
> 
> Will let Udit and you sort this out.

Udit and I talked a bit about this yesterday. It's something to explore
implementing down the road, after this sync - nothing immediate

> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

Thanks,
Reid Tonking
