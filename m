Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1469DEB8FAD
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 04:30:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A7E86553;
	Wed,  6 Sep 2023 06:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ws8J22EI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 137238656A; Wed,  6 Sep 2023 06:30:00 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68BA686308
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 06:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3864TtL9096758;
 Tue, 5 Sep 2023 23:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693974595;
 bh=O/B7QWYZespmLiOmBapypC6Sv0YLsHLAh28ugPPd1zg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Ws8J22EIK1SHm96zy6dCStWU4b69ReWNXHP/09ucdCMkoE0vSC2YyZdSmlPBKp554
 MSP9939fFKjrwPgaG8cLGyMYWmVPW24kuqH/eropeqHo2Y9cvlJvncemTXhpkxF7w/
 t2bqVBJBByuBf9VbAABXBaIuplQtKTwoqIDZ8Z+A=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3864TtOa064748
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 5 Sep 2023 23:29:55 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 5
 Sep 2023 23:29:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 5 Sep 2023 23:29:54 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3864TrkL086160;
 Tue, 5 Sep 2023 23:29:54 -0500
Date: Wed, 6 Sep 2023 09:59:53 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Vignesh Raghavendra
 <vigneshr@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Reid Tonking <reidt@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v4 6/6] board: ti: j721s2: MAINTAINERS: Update the
 MAINTAINERS File.
Message-ID: <20230906042953.agilh3r2wsf4ztvv@ula0497581>
References: <20230816-b4-upstream-j721s2-r5-pinmux-v4-0-dc114bece5d7@ti.com>
 <20230816-b4-upstream-j721s2-r5-pinmux-v4-6-dc114bece5d7@ti.com>
 <20230905122712.q3l3ecsygad4jsry@quality>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230905122712.q3l3ecsygad4jsry@quality>
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

On 07:27-20230905, Nishanth Menon wrote:
> On 16:08-20230904, Manorit Chawdhry wrote:
> > Update the MAINTAINERS file and propose a new MAINTAINER for j721s2 due
> > to the previous MAINTAINER not being associated with TI.
> > 
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >  board/ti/j721s2/MAINTAINERS | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> 
> For whatever it is worth:
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>

Thanks for your reviews Nishanth!

Regards,
Manorit

> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
