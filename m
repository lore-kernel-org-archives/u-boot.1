Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09669C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 14:45:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430E982E3F;
	Wed, 16 Apr 2025 16:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Lk5WsPAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC25F82F00; Wed, 16 Apr 2025 16:45:30 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A2C82D17
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 16:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53GEjQR82685919
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 09:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744814726;
 bh=VgliO+aZuh6ShQudjQpOThBNljEBVrLVwtI807nmS58=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Lk5WsPAVfCK8gBPpI+u/yr4mmKlkSWhBV5vh8fY8+9TVGWJRq1rsClSQQE0d8dYhR
 omJjfIYvEKSORelDmahNHtcatKbpCmgUKZDAppzGF36AOQuFemjf6CyGDn4ahEF+jv
 QAs4iqAI0FS8MyRdlltxBfDh0Anpef8L6Yw3jciw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53GEjQoG122467
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 16 Apr 2025 09:45:26 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 16
 Apr 2025 09:45:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 16 Apr 2025 09:45:25 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53GEjPsZ075222;
 Wed, 16 Apr 2025 09:45:25 -0500
Date: Wed, 16 Apr 2025 09:45:25 -0500
From: Bryan Brattlof <bb@ti.com>
To: Daniel Schultz <d.schultz@phytec.de>
CC: <trini@konsulko.com>, <u-kumar1@ti.com>, <afd@ti.com>, <n-francis@ti.com>, 
 <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <upstream@lists.phytec.de>
Subject: Re: [PATCH v3] mach-k3: common_fdt: Move carveout struct
Message-ID: <20250416144525.4o4mhduifb27wgki@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20250415151241.3128391-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20250415151241.3128391-1-d.schultz@phytec.de>
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

On April 15, 2025 thus sayeth Daniel Schultz:
> Labels are not allowed before declarations. Move the carveout struct
> at the beginning and only update 'end' at this point.
> 
> This will fix following error:
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
> Reviewed-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Changes in v2:
>   * Moved carveout struct at the beginning instead of adding an dummy statement. 
> 
> Changes in v3:
>   * Removed .end assignment from carveout definition.
> 

Thanks again for fixing this up

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
