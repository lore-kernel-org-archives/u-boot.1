Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE932CAC587
	for <u-boot@archiver.kernel.org>; Wed, 10 Sep 2025 09:48:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D431A830B4;
	Wed, 10 Sep 2025 11:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WB8gcAi+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E67E83214; Wed, 10 Sep 2025 11:48:08 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2920982B20
 for <u-boot@lists.denx.de>; Wed, 10 Sep 2025 11:48:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58A9m14w489697;
 Wed, 10 Sep 2025 04:48:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757497681;
 bh=zwmjhpAXCtfBA1IQrX38uKkAiUsrZLYus9j67LZYhD4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=WB8gcAi+B6ILEakZJ57VIxoA4/LK9GPvcfkO1+MRjES8yl6hSG8qexRpHBUpUws9d
 0CIdGqeZvORnFeip//dNuCPh0mt/e4AMNxN+zy7rP/FNDcUu2zwfk9eyEg29EdSVMD
 TeZaTX8JPj/SQ3Txuyz9l0gN81Q55UebjwSYm3VU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58A9m1Xg199428
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 10 Sep 2025 04:48:01 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 10
 Sep 2025 04:48:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Sep 2025 04:48:01 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58A9lx6m292464;
 Wed, 10 Sep 2025 04:48:00 -0500
Date: Wed, 10 Sep 2025 15:17:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Anshul Dalal <anshuld@ti.com>
CC: <u-boot@lists.denx.de>, <b-padhi@ti.com>, <vigneshr@ti.com>,
 <trini@konsulko.com>, <nm@ti.com>, <robertcnelson@gmail.com>,
 <w.egorov@phytec.de>, <francesco.dolcini@toradex.com>,
 <ggiordano@phytec.com>, <m-chawdhry@ti.com>, <a-nandan@ti.com>,
 <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>, <devarsht@ti.com>,
 <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH -next v6 03/10] arm: armv8: mmu: export mmu_setup
Message-ID: <20250910094759.5xjon63dpgxplmpg@lcpd911>
References: <20250905081902.489345-1-anshuld@ti.com>
 <20250905081902.489345-4-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250905081902.489345-4-anshuld@ti.com>
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

On Sep 05, 2025 at 13:48:54 +0530, Anshul Dalal wrote:
> The mmu_setup function configures the page tables based on the board
> supplied mem_map struct array. It is called implicitly as part of
> dcache_enable but this limits us to only be able to use APIs such as
> mmu_change_region_attr only after caches are enabled.
> 
> This might lead to speculative accesses before we can unmap a region
> that is marked as cacheable in the static memory map.
> 
> Therefore this patch exports the mmu_setup function in mmu.h allowing
> users to have more control over when the mmu is configured.
> 
> For K3 specifically this allows for the following configuration sequence
> as part of enable_caches:
> 
> static mem_map fixups (TODO) -> mmu_setup -> carveouts using
> mmu_change_region_attr (TODO) -> icache/dcache enable
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
