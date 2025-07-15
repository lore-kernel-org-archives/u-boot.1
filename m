Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9474EC83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 17:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC918309E;
	Tue, 15 Jul 2025 19:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YlCIEwqI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19478830B4; Tue, 15 Jul 2025 19:51:31 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE5F82E37
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 19:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56FHpQ7V2315217;
 Tue, 15 Jul 2025 12:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1752601886;
 bh=SFcBcXPZn5JY5uqGMLSZmk/iVKOX3TMvyOvXHFQwVS8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YlCIEwqIwjnzeLbgRVs/yRvlbiIEktvlIp6uqV9gs/kGPhLu5BHh6d+5UxBmUjdGk
 AU1zFCn3Q1mpyrdRZrSapyZPK1k8HJSaSQTHnqBO3hGsishUQxGAdYCONOk0iU08RB
 KiS/FMRb8p7QKz4/6822+IENqStTIEqQbeKsm7NI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56FHpQAL239382
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 15 Jul 2025 12:51:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 15
 Jul 2025 12:51:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 15 Jul 2025 12:51:26 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56FHpQ1W2994225;
 Tue, 15 Jul 2025 12:51:26 -0500
Date: Tue, 15 Jul 2025 12:51:26 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] include: env: ti_common: remove bootm_size
Message-ID: <20250715175126.umrhwcqpw73ab7eb@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250715-initrd-fixes-v1-1-8c41b1fdea6b@ti.com>
 <20250715165845.GF193579@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250715165845.GF193579@bill-the-cat>
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

On July 15, 2025 thus sayeth Tom Rini:
> On Tue, Jul 15, 2025 at 11:21:12AM -0500, Bryan Brattlof wrote:
> 
> > As the size of the kernels, DTs, and initial ram disks continues to grow
> > in size the 256MB size limit set aside for image processing by the bootm
> > command has become too small for some boards.
> > 
> > Rather than increasing this limit let's just remove any limit by default
> > and let each board set its own (if needed) for there use case.
> > 
> > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > ---
> >  include/env/ti/ti_common.env | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/include/env/ti/ti_common.env b/include/env/ti/ti_common.env
> > index 7029d12bf203320fde859965ae57c272ed4c685c..03e3267ef8a1bf3e14c65df124ed1ac842c88760 100644
> > --- a/include/env/ti/ti_common.env
> > +++ b/include/env/ti/ti_common.env
> > @@ -8,7 +8,6 @@ rdaddr=0x88080000
> >  ramdisk_addr_r=0x88080000
> >  scriptaddr=0x80000000
> >  pxefile_addr_r=0x80100000
> > -bootm_size=0x10000000
> >  boot_fdt=try
> >  
> >  boot_fit=0
> 
> So, which of the older families of parts use this file if any? This can
> be a concern on am33xx for example, still.

Ah I though it checked but I see some K2 platforms #include this. I'll 
just set it for those boards as I don't really want to mess with them.

~Bryan
