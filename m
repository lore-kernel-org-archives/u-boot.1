Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DA5C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 20:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75CFE882C9;
	Fri, 19 Apr 2024 22:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="E2caNyYu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 851CC884E8; Fri, 19 Apr 2024 22:33:21 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B1F88208
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 22:33:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43JKXGCO064084;
 Fri, 19 Apr 2024 15:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1713558796;
 bh=YSyW6A06eDrnw7ZEol7rmyZ3pWDStvpKt9qAmLTGe9k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=E2caNyYu5PxXPLip5ln6nGUYufjW+vTqKbP5z270N0i3lN5sk/CargBPUGi29zcp5
 /oGD9YOnGYh5R9uBX6rv0goBx21Q5QC49oLa8Gg3JiQpAOx7MBCFbFKWNe1fSmR1Zu
 MGEN9aG6oGn/YdVYSx+tiwRcYb8uPcO+og12qjHQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43JKXGvt096348
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 19 Apr 2024 15:33:16 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 15:33:16 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 15:33:16 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43JKXGOW051195;
 Fri, 19 Apr 2024 15:33:16 -0500
Date: Fri, 19 Apr 2024 15:33:16 -0500
From: Bryan Brattlof <bb@ti.com>
To: Judith Mendez <jm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tom Rini <trini@konsulko.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>, Simon Glass
 <sjg@chromium.org>
Subject: Re: [PATCH v2] configs: am62px_evm_a53_defconfig: Enable MMC UHS
 config option
Message-ID: <20240419203316.pggh2gsrybzprkoo@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240416162115.2743405-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240416162115.2743405-1-jm@ti.com>
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

On April 16, 2024 thus sayeth Judith Mendez:
> Enable MMC UHS support for to allow to enter the UHS
> modes for MMC1.
> 

s/support for/support/

Though it doesn't really matter to me. ;)

> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v1:
> - Fix typo in patch description
> ---
> 
>  configs/am62px_evm_a53_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 

Thanks for finally getting MMC sorted so we can enable these configs

Acked-by: Bryan Brattlof <bb@ti.com>

~Bryan
