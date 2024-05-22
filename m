Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF5A7C25B77
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 09:52:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DA8688472;
	Wed, 22 May 2024 11:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tvFim1SG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22F7F88473; Wed, 22 May 2024 11:52:29 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2369C88464
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M9qK2h073670;
 Wed, 22 May 2024 04:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716371540;
 bh=lkNTeP1NXGZz+A+HQMWr+0x0C7RB7/ZOsQ2ydrZ1UhM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tvFim1SGweiGo5JF4rLWK+BWxuOlxT4Y4FXmPyA6H3wCLa+nJHl/J1spcWTmV3k//
 2staBnJVQU9UUGV4UCpbSEM0aY/f6Ib5agDtHb1QrKtzewvvC844NvtJFGbKwISDKH
 Ts6EZRoL+G98GKDk1hT8DeuDRSBCbMATC2oi1qiM=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M9qKXj003494
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 04:52:20 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 04:52:19 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 04:52:19 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M9qJeD044076;
 Wed, 22 May 2024 04:52:19 -0500
Date: Wed, 22 May 2024 15:22:18 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>,
 <trini@konsulko.com>, <clamor95@gmail.com>, <d.schultz@phytec.de>,
 <bb@ti.com>, <jma@phytec.com>, <mkorpershoek@baylibre.com>,
 <m-chawdhry@ti.com>, <n-jain1@ti.com>, <afd@ti.com>,
 <joao.goncalves@toradex.com>, <michael@amarulasolutions.com>,
 <festevam@gmail.com>, <sjg@chromium.org>
Subject: Re: [PATCH v2 2/5] board: phytec: Fix function definitions in AM6x
 SOM detection
Message-ID: <20240522095218.bwp22lgrdwgv5dbr@dhruva>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
 <20240522075505.3339347-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522075505.3339347-3-w.egorov@phytec.de>
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

On May 22, 2024 at 09:55:02 +0200, Wadim Egorov wrote:
> Functions are declared as phytec_am6* and not phytec_am62*.
> Update the definitions to match the declarations.
> 
> Fixes: 9d152c23279c ("board: phytec: Add SOM detection for AM6x")
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Tested-by: John Ma <jma@phytec.com>
> ---
>  board/phytec/common/am6_som_detection.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Dhruva Gole <d-gole@ti.com>

[...]

-- 
Best regards,
Dhruva Gole
