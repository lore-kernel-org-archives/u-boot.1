Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 528BECCA472
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 13:25:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D1B4839B9;
	Wed,  8 Oct 2025 15:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fry23xwq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556FE839DE; Wed,  8 Oct 2025 15:25:54 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 580238394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 15:25:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598DPjj3232374;
 Wed, 8 Oct 2025 08:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759929945;
 bh=qYKiLoNvzy4hri+7mUUS8ikd6sOMQxKeMkhvAZhZx44=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Fry23xwq9qY3p2uOMr2tFhyMnSGeRaQCxeeL+vdHa+3fDWTlNEcKkrB9sJsXMIpcT
 vzvU6E+ZfX7sHgbXcNBlyGh96L0c/efn1OIZpxAXZY5BJE/j0B2hADTnveCPgg7WaR
 OzF/l4XOULsAt27RT85wsSDgxPsVTjrrWyTj1zdo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598DPigp670519
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 08:25:45 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 08:25:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 08:25:44 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598DPh3b2598990;
 Wed, 8 Oct 2025 08:25:43 -0500
Date: Wed, 8 Oct 2025 18:55:42 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>
Subject: Re: [PATCH -next v8 05/11] arm: armv8: mmu: add mem_map_fix_dram_banks
Message-ID: <20251008132542.or3dpjsvx4u6jqi2@lcpd911>
References: <20251006082852.4008937-1-anshuld@ti.com>
 <20251006082852.4008937-6-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251006082852.4008937-6-anshuld@ti.com>
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

On Oct 06, 2025 at 13:58:43 +0530, Anshul Dalal wrote:
> For armv8, U-Boot uses a static map defined as 'mem_map' for configuring
> the MMU as part of mmu_setup.
> 
> But since the exact configuration of memory banks might not be known at
> build time, many platforms such as imx9, versal2 etc. utilize
> gd->bd->bi_dram to configure the static map at runtime.
> 
> Therefore this patch adds a new API mem_map_fix_dram_banks that modifies
> the static map in a similar way. Allowing the caller to map all dram
> banks by just passing the index to last entry in their mem_map and it's
> length.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Tested-by: Wadim Egorov <w.egorov@phytec.de>

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
