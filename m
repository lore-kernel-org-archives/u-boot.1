Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1149CC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 08:21:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98ED982C55;
	Mon,  7 Apr 2025 10:21:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W2DZfJyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F25F982C87; Mon,  7 Apr 2025 10:21:26 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FB182BCD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 10:21:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5378LMtK812411
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 03:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744014082;
 bh=ouHXsh4YqMLuatovi/qWxLfsx/NR+q5efdiydPqCfik=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=W2DZfJylRG1YM2rAyxGIlPCZ3uBqjhYys25UaqhNKIj1RjikcZR2YzB54SZ6d5m6X
 BKlq/NmCwVj+J2ToR5JefAGKZ1gmrClNRIZ9hLp6A2kQYVjAg74aMQt72DS2bWh/ZT
 ss/kdq02fiJy1e1zLBB5u5pJq1yRP2gieE+4CTiE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5378LMwk004252
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 7 Apr 2025 03:21:22 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 7
 Apr 2025 03:21:22 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 7 Apr 2025 03:21:22 -0500
Received: from [172.24.31.71] (lt5cd2489kgj.dhcp.ti.com [172.24.31.71])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5378LJc4072212;
 Mon, 7 Apr 2025 03:21:20 -0500
Message-ID: <92ee150b-1873-4856-a3cb-8e9d6af78c33@ti.com>
Date: Mon, 7 Apr 2025 13:51:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: common_fdt: Fix Label Issue
To: Daniel Schultz <d.schultz@phytec.de>, <trini@konsulko.com>,
 <n-francis@ti.com>, <bb@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>, <w.egorov@phytec.de>
References: <20250407060711.3160366-1-d.schultz@phytec.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250407060711.3160366-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Hi Daniel.

Thanks for patch

On 4/7/2025 11:37 AM, Daniel Schultz wrote:
> Labels are not allowed before declarations. Add a semicolon after the
> label to introduce an empty statement. This will fix following error:
>
> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
>    156 |  struct fdt_memory carveout = {
>        |  ^~~~~~
> make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2

Is there some specific compiler option you are using, Sorry but I don't 
see this error .

i just build sha id e458e103d4f5fb7aaf13e744c65916ab3ba4a18d of next


>
> Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>
> I'm open to other suggestions! This is just the easiest way to fix this
> compile error. BTW, master is fine since 096aa229a9e is only on next.
>
>   arch/arm/mach-k3/common_fdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 361b0c0b31b..7178918a12c 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -152,7 +152,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
>   		}
>   	}
>   
> -add_carveout:
> +add_carveout: ;
>   	struct fdt_memory carveout = {
>   		.start = new_address,
>   		.end = new_address + new_size - 1,

My suggestion will be to move this struct at start of function.

and change only size here

carveout.end = new_address + new_size - 1;


