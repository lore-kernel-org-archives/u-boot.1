Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8C1C369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 20:15:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A9B1830B6;
	Mon,  7 Apr 2025 22:15:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MbRRPlh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D98C8830C0; Mon,  7 Apr 2025 22:15:36 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 862EB830B3
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 22:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 537KFVo7967876
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 15:15:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744056932;
 bh=H/pYagdYpy5VSUnkC63huWIo2XTPHaqhXh4w/dj/bgY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=MbRRPlh4YlDBWJu1QYDCqA5oiGpZAt+VLNbf4jXwWucEdv+7r6DVYZpQv9ArjbHIh
 rZD3JNk10Usawr2IOoEpgK8FrXAZViAqDW11zcBrble0anfNOw4GT29SCRNXGW3B9K
 dImKXLj/oFl/NvAsGTzeuBJdTniGlHbfCmF1+u2o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 537KFVdU007856
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Apr 2025 15:15:31 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Apr 2025 15:15:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Apr 2025 15:15:31 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 537KFVlD038245;
 Mon, 7 Apr 2025 15:15:31 -0500
Date: Mon, 7 Apr 2025 15:15:31 -0500
From: Bryan Brattlof <bb@ti.com>
To: Daniel Schultz <d.schultz@phytec.de>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <u-kumar1@ti.com>, <afd@ti.com>, 
 <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <w.egorov@phytec.de>
Subject: Re: [PATCH] mach-k3: common_fdt: Fix Label Issue
Message-ID: <20250407201531.dxgaz454i6nlxwqt@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250407060711.3160366-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250407060711.3160366-1-d.schultz@phytec.de>
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

On April  6, 2025 thus sayeth Daniel Schultz:
> Labels are not allowed before declarations. Add a semicolon after the
> label to introduce an empty statement. This will fix following error:
> 
> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
>   156 |  struct fdt_memory carveout = {
>       |  ^~~~~~
> make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2
> 
> Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> 
> I'm open to other suggestions! This is just the easiest way to fix this
> compile error. BTW, master is fine since 096aa229a9e is only on next.
> 

Ha I learn something new every day. It makes sense as we can't declare
variables inside switch statements so the same rules should apply when 
adding jump labels at the function scope.

I was never really in love with the layout of this function, my thought
was to move that carveout structure to the top with all the other 
declarations but I'm not apposed to the null statement here either.

Thanks for fixing this
~Bryan
