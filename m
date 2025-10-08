Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7C7CCD183
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 12:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A9F48394A;
	Wed,  8 Oct 2025 14:26:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FE0f10pL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE5C8394E; Wed,  8 Oct 2025 14:26:10 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D56AC8393D
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 14:26:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598CQ2gq3973686;
 Wed, 8 Oct 2025 07:26:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759926363;
 bh=YFppdPFdvzw9pzzGHr/3EyBQber9w0A1rQVy3pm/xlA=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=FE0f10pLzzcTOc2TalVw3oNmFIqe9whPLeOrxVLLy2cGw0B+gk31IP370bNbiJ2Ft
 vDpjLdlR6slJvXUemMoR+z6jzROFzOm5/KISdA3qynTf54eV6WCLmqQMTwqg44vjUe
 B60eZEDs/IzBQJ5Daayg6Dr/QfvreYtxa2+OQ87g=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598CQ2hE3715088
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Wed, 8 Oct 2025 07:26:02 -0500
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 8
 Oct 2025 07:26:02 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 07:26:02 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598CQ2ms2525506;
 Wed, 8 Oct 2025 07:26:02 -0500
Date: Wed, 8 Oct 2025 07:26:02 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Dhruva Gole <d-gole@ti.com>,
 Moteen Shah <m-shah@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v3 0/3] ti_sci: Address some issues found by Smatch
Message-ID: <20251008122602.lr5afdqocdxr4znn@trimming>
References: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251008-ti_sci-v3-0-5866bf84adc6@linaro.org>
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

On 10:23-20251008, Andrew Goodbody wrote:
> Prevent a memory leak from a non-freed malloc.
> Return an error code on an error path.
> Assign a value to a pointer before it is dereferenced.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
> Changes in v3:
> - Pick up review tags
> - Change dev_dbg call to dev_err to be consistent with surrounding code
>   in 2/3
> - Update subject line of 3/3 to be more explicit
> - Link to v2: https://lore.kernel.org/r/20251007-ti_sci-v2-0-7561d7ea07b2@linaro.org
> 
> Changes in v2:
> - Add cast when assigning to resp
> - Replace malloc with devm_kmalloc
> - Link to v1: https://lore.kernel.org/r/20251006-ti_sci-v1-0-9cef92e1022d@linaro.org
> 
> ---
> Andrew Goodbody (3):
>       ti_sci: Prevent memory leak
>       ti_sci: Provide error code on error exit
>       ti_sci: Pointer is never assigned to valid value
> 
>  drivers/firmware/ti_sci.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> ---
> base-commit: c280c4f7e52f08255f491783b3143a3be1fc08b0
> change-id: 20250725-ti_sci-7bc55cb0cdba
> 
> Best regards,
> -- 
> Andrew Goodbody <andrew.goodbody@linaro.org>
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

Also tested with UART boot against u-boot master commit 92dcb3ad5d98  ("cmd/dma: implement dmareset command")


https://gist.github.com/nmenon/1f569681f43cfed456fcce729e0c6e29

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
