Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C6AC369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 10:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD3DF80FEC;
	Tue, 22 Apr 2025 12:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tB3qMMb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFCB80FF7; Tue, 22 Apr 2025 12:19:17 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B7780F9C
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 12:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAJ7FV1191474
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 22 Apr 2025 05:19:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745317147;
 bh=YM9WPP71Pxbq5Q7DuXQrgSLGY8cMWPEZH0u/8a2Qkh8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tB3qMMb+BCwqDYFb6Q3llqh2o1ZEWlW4vtjOCspnXxd0RryqvxmaD9k1bMunelJQD
 v8MEtWK4hthrdx+b0YX7fLVoITHQ5eS/xJEvQDdjDRWRGMlLPmkhQ9+dPpi+d/An3p
 JuDq0ukZ1jw2JQDaO79X4qmqzjgOqhu7NoX4lD0I=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53MAJ7N8001223
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Apr 2025 05:19:07 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Apr 2025 05:19:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Apr 2025 05:19:07 -0500
Received: from localhost (uda0492258.dhcp.ti.com [10.24.72.113])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53MAJ5Qk103988;
 Tue, 22 Apr 2025 05:19:06 -0500
Date: Tue, 22 Apr 2025 15:49:05 +0530
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Hrushikesh Salunke <h-salunke@ti.com>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <j-humphreys@ti.com>, <jm@ti.com>,
 <sjg@chromium.org>, <s-k6@ti.com>, <n-francis@ti.com>,
 <rogerq@kernel.org>, <danishanwar@ti.com>, <s-vadapalli@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>
Subject: Re: [PATCH 1/3] pci: pcie_cdns_ti: Include linux/sizes.h header
Message-ID: <ac71d2a6-5445-46e3-8d46-8ca2431aa3db@ti.com>
References: <20250416120830.138965-1-h-salunke@ti.com>
 <20250416120830.138965-2-h-salunke@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250416120830.138965-2-h-salunke@ti.com>
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

On Wed, Apr 16, 2025 at 05:38:28PM +0530, Hrushikesh Salunke wrote:
> Driver uses macro SZ_4G to configure inbound base address register.
> The macro is used without including the header file in which it is
> defined. Fix this.
> 
> Fixes: 59ad5480098 ("pci: Add TI K3 Cadence PCIe Controller")
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>  drivers/pci/pcie_cdns_ti.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
> index 41469a186a3..e5bcc6eb53e 100644
> --- a/drivers/pci/pcie_cdns_ti.c
> +++ b/drivers/pci/pcie_cdns_ti.c
> @@ -19,6 +19,7 @@
>  #include <linux/io.h>
>  #include <linux/ioport.h>
>  #include <linux/log2.h>
> +#include <linux/sizes.h>
>  #include <power-domain.h>
>  #include <regmap.h>
>  #include <syscon.h>

Regards,
Siddharth.
