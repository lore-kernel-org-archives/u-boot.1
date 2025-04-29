Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAD8C3ABA9
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 11:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA77682162;
	Tue, 29 Apr 2025 13:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xLdkW8TD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F0582145; Tue, 29 Apr 2025 13:41:22 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760288210F
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 13:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53TBfI6m3831543
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 06:41:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745926878;
 bh=myQsN6ip1eK1/H4h+WhWj3/XrlJkWoBGsLHYXiSyJ+c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=xLdkW8TDchr5XbQcjOWHqD70JaxXlYHRm0XqG4UKtPInNN0qjtFUyA2necAsL/5W4
 wjIZJeJDb6w+GCHHq0KbpAFrD0yPrFYG+Ij7H6F6XoY6lDKLIsg2EZy4Wd3gxLjmzA
 Nrg7m4NrOLfgeSZukeiUEJhoIq7bB76AiflghGVk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53TBfIXC023748
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 06:41:18 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 06:41:17 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 06:41:17 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53TBfH6J004004;
 Tue, 29 Apr 2025 06:41:17 -0500
Date: Tue, 29 Apr 2025 06:41:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Udit Kumar <u-kumar1@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <d-gole@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <ilias.apalodimas@linaro.org>, <c-vankar@ti.com>
Subject: Re: [PATCH] firmware: ti_sci: Add Initialization of dev_info head node
Message-ID: <20250429114117.xw5z6l7a73nzrcca@proofing>
References: <20250429074950.2262104-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250429074950.2262104-1-u-kumar1@ti.com>
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

On 13:19-20250429, Udit Kumar wrote:
> On K3 devices two drivers ti_sci and ti_sci_dm are supporting firmware
> functions. At run time one of driver is used.
> 
> Driver ti_sci already initializing head for dev_list in its probe
> function, but it was missed in ti_sci_dm driver.
> 
> So add head list init support for ti_sci_dm driver.
> 
> Fixes: 5d5a699855a7("firmware: ti_sci: Add support for Resoure Management at R5 SPL stage")

Nice catch.
> 
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
>  drivers/firmware/ti_sci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 54d6689ce78..a599de9e013 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -2891,6 +2891,8 @@ static __maybe_unused int ti_sci_dm_probe(struct udevice *dev)
>  
>  	list_add_tail(&info->list, &ti_sci_list);
>  
> +	INIT_LIST_HEAD(&info->dev_list);
> +

I don't think this impacts a lot, but for sanity reasons, you might
want to do this before we add it to ti_sci_list.

Similarly, ti_sci_probe() does INIT_LIST_HEAD after adding to the
&ti_sci_list, might want to do the INIT before adding to list.

>  	ops = &info->handle.ops;
>  
>  	rm_core_ops = &ops->rm_core_ops;
> -- 
> 2.34.1
> 
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
