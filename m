Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FE3C48BC4
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 09:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C55287FA6;
	Tue, 20 Feb 2024 10:54:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CSLNu8xz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1AE287FA7; Tue, 20 Feb 2024 10:54:41 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F6AE87FA3
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 10:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41K9sRLG057682;
 Tue, 20 Feb 2024 03:54:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1708422867;
 bh=yY/Trme9e+avy/KYJhWcS5yXz3EtiDKcIGOfXJXc7JI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=CSLNu8xz/Udfb584ctA+ubFvAeW3lAGoaSDdGtF9/+ehXuYvPnaPCxp4O+NatlKay
 4a8C3ogMVh4kX7dQ5fMEhAwJMsQkmxCXf5sTKJmhgtHtpV4Jw8EkHKKiScKOv7qAm7
 6r5Xy9sKw9b52tvjXLJAeLY+d/6hMhClcAj+Nnpw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41K9sR2O087249
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 20 Feb 2024 03:54:27 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 20
 Feb 2024 03:54:27 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 20 Feb 2024 03:54:27 -0600
Received: from localhost (uda0492258.dhcp.ti.com [172.24.227.9])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41K9sQvD030808;
 Tue, 20 Feb 2024 03:54:27 -0600
Date: Tue, 20 Feb 2024 15:24:26 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <sjg@chromium.org>, <vigneshr@ti.com>,
 <matthias.schiffer@ew.tq-group.com>, <nm@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH] dma: ti: k3-udma: Fix error handling for
 setup_resources() in udma_probe()
Message-ID: <61c1d2ad-ea24-4057-9e0a-9ff53db73b0b@ti.com>
References: <20240216104105.494602-1-s-vadapalli@ti.com>
 <bca16d1a-986d-4e73-9ac0-2799a058c06f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bca16d1a-986d-4e73-9ac0-2799a058c06f@moroto.mountain>
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

On 24/02/20 12:51PM, Dan Carpenter wrote:
> On Fri, Feb 16, 2024 at 04:11:05PM +0530, Siddharth Vadapalli wrote:
> > diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> > index eea9ec9659..8a6625f034 100644
> > --- a/drivers/dma/ti/k3-udma.c
> > +++ b/drivers/dma/ti/k3-udma.c
> > @@ -1770,9 +1770,11 @@ static int udma_probe(struct udevice *dev)
> >  		return PTR_ERR(ud->ringacc);
> >  
> >  	ud->dev = dev;
> > -	ud->ch_count = setup_resources(ud);
> > -	if (ud->ch_count <= 0)
> > -		return ud->ch_count;
> > +	ret = setup_resources(ud);
> > +	if (ret <= 0)
> > +		return ret;
> 
> The code was like this originally, but setup_resources() can't actually
> return zero so it would be nicer to say:
> 	ret = setup_resources(ud);
> 	if (ret < 0)
> 		return ret;

Thank you for reviewing the patch and pointing this out. I will fix it
and post the v2 patch.

Regards,
Siddharth.
