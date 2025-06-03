Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B71C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 08:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FB0981F0D;
	Tue,  3 Jun 2025 10:38:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JYhFQ38C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC45881FFC; Tue,  3 Jun 2025 10:38:07 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77FDA81E72
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 10:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5538c1DA3447192;
 Tue, 3 Jun 2025 03:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1748939881;
 bh=x65LJbhdKYv5D1YYJbrnu/OqZcOashUrer1xSgXOKuU=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=JYhFQ38C5qoHHwoyqXUShALS9Xx4SkcVzId7NKA2lszZsr5/kzSLKVNVkgWTr5nfU
 hZjnpGmjPnSeVgyeS0Q61bZWQDXpGOTXwqRFz/5AVoArnOoG0htfGtbfKT26xreHTN
 1ahr/CkgIBlXXRBuW9wCee5KKWkQynmMlGTKEhaU=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5538c1cm3614133
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 3 Jun 2025 03:38:01 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 3
 Jun 2025 03:38:00 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 3 Jun 2025 03:38:00 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5538bxss080511;
 Tue, 3 Jun 2025 03:38:00 -0500
Date: Tue, 3 Jun 2025 14:07:59 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Moteen Shah <m-shah@ti.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH 3/6] firmware: ti_sci.c: Add a function to query DM
 firmware's capability
Message-ID: <20250603083759.4wdymfuxi6i47jl4@lcpd911>
References: <20250528080519.677750-1-m-shah@ti.com>
 <20250528080519.677750-4-m-shah@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250528080519.677750-4-m-shah@ti.com>
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

On May 28, 2025 at 13:35:16 +0530, Moteen Shah wrote:
> Add a new function to query the capabilities of the DM firmware, using
> TI SCI protocol to retrieve a 64-bit firmware capability, where each bit
> represents a specific capability supported by the firmware.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 45 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
