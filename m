Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76445C369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 10:54:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B67AD809A5;
	Tue, 29 Apr 2025 12:54:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="kp9+Vmf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D7080F03; Tue, 29 Apr 2025 12:54:51 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D663F8059D
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 12:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53TAsken3074070
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Apr 2025 05:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745924086;
 bh=E3sxL4FIUXUDIKI2YwbqYCk+1pfJjMNJOMIery5esME=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=kp9+Vmf7lOWn/ctCDtGtgBCgKuruwOKd+3Bnu96S3FvB/JV+C6IJeahMANmonLOKE
 n+6KDnn3hYtx7TrBfn+kk+IZdwirNZZqFeFYdsRpk0bgNo0X3yaUda/DjRMkrB1Oye
 8ZWDhMo4rNiiLdUzyVfKoLcNr3PU65LkgzO+zqwY=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53TAskpD059146
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 29 Apr 2025 05:54:46 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Apr 2025 05:54:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Apr 2025 05:54:45 -0500
Received: from [10.249.136.157] ([10.249.136.157])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53TAsgBY096667;
 Tue, 29 Apr 2025 05:54:43 -0500
Message-ID: <ea33d47d-39f8-4ebc-815f-be8a96fc4a6f@ti.com>
Date: Tue, 29 Apr 2025 16:24:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: ti_sci: Add Initialization of dev_info head node
To: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>,
 <ilias.apalodimas@linaro.org>, <c-vankar@ti.com>
References: <20250429074950.2262104-1-u-kumar1@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250429074950.2262104-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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

Hi Udit

On 4/29/2025 1:19 PM, Udit Kumar wrote:
> On K3 devices two drivers ti_sci and ti_sci_dm are supporting firmware
> functions. At run time one of driver is used.
> 
> Driver ti_sci already initializing head for dev_list in its probe
> function, but it was missed in ti_sci_dm driver.
> 
> So add head list init support for ti_sci_dm driver.
> 
> Fixes: 5d5a699855a7("firmware: ti_sci: Add support for Resoure Management at R5 SPL stage")
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
>  	ops = &info->handle.ops;
>  
>  	rm_core_ops = &ops->rm_core_ops;

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

