Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55828C25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 09:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8C9188473;
	Wed, 22 May 2024 11:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DT3Q4HmG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263B688491; Wed, 22 May 2024 11:51:10 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB50B88472
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 11:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44M9oxn8058748;
 Wed, 22 May 2024 04:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1716371459;
 bh=qGSUgrbwEDpcU8OtY205rZeNKSEptLftef/GImeHcGg=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=DT3Q4HmGFtNnHhCRmSPQPiD1mUgRTCzJwtzoi/lWKxAWHNWCZJ6+J78CzoBmP/0vN
 LdyZ1v9jw0TSsIX8zVt6cK+a7Eol6nFYxzdSL6QEziOw3A8g8o7pUps1mShYAmBw+0
 CjL+sx33cBtjtGYpFXLESdJKCR3O6oTWUbOExxVs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44M9oxfs057132
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 22 May 2024 04:50:59 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 May 2024 04:50:59 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 May 2024 04:50:59 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44M9owWG046757;
 Wed, 22 May 2024 04:50:59 -0500
Date: Wed, 22 May 2024 15:20:58 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Wadim Egorov <w.egorov@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <nm@ti.com>,
 <trini@konsulko.com>, <clamor95@gmail.com>, <d.schultz@phytec.de>,
 <bb@ti.com>, <jma@phytec.com>, <mkorpershoek@baylibre.com>,
 <m-chawdhry@ti.com>, <n-jain1@ti.com>, <afd@ti.com>,
 <joao.goncalves@toradex.com>, <michael@amarulasolutions.com>,
 <festevam@gmail.com>, <sjg@chromium.org>
Subject: Re: [PATCH v2 1/5] board: phytec: Make AM6 SoM detection depend on I2C
Message-ID: <20240522095058.uwgiafx4gn7dm42i@dhruva>
References: <20240522075505.3339347-1-w.egorov@phytec.de>
 <20240522075505.3339347-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240522075505.3339347-2-w.egorov@phytec.de>
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

Hi,

On May 22, 2024 at 09:55:01 +0200, Wadim Egorov wrote:
> SoM detection is using I2C driver model functions.
> Let's depend on I2C.
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Tested-by: John Ma <jma@phytec.com>
> ---

Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva Gole
