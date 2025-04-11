Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13136C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 05:30:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6858482B7F;
	Fri, 11 Apr 2025 07:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GdyPvSCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFEAC82B95; Fri, 11 Apr 2025 07:30:09 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D88B582B72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:30:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53B5U4Ek1348953
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 00:30:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744349404;
 bh=b2zIAf6uE8HfoyOJk1fsCnapj7yCTomAr39zC1vMwCM=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=GdyPvSCGZer/eSqQXV+myxq7eeMZUPS8GBqSzR/oN8Ct4smhlhuJcZw8rg0/VISNk
 GPY4P6Z5Ux7RGB4ysjR8A5RgF8ch7+B0Or8R8DEi97514fZBwJ/1pHYzTp73pEVncU
 lOnDb1/6eZq677WM9IF73yjS92MIa7KiTUh/cuBI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53B5U3C0004597
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 11 Apr 2025 00:30:04 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 11
 Apr 2025 00:30:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 11 Apr 2025 00:30:03 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53B5TxYG032649;
 Fri, 11 Apr 2025 00:30:00 -0500
Message-ID: <2ae04e74-4672-41fa-8fa3-f3c0894f7df1@ti.com>
Date: Fri, 11 Apr 2025 10:59:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mach-k3: common_fdt: Move carveout struct
To: Daniel Schultz <d.schultz@phytec.de>, <trini@konsulko.com>, <afd@ti.com>, 
 <n-francis@ti.com>, <bb@ti.com>, <u-boot@lists.denx.de>
CC: <w.egorov@phytec.de>, <upstream@lists.phytec.de>
References: <20250410075525.390331-1-d.schultz@phytec.de>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20250410075525.390331-1-d.schultz@phytec.de>
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


On 4/10/2025 1:25 PM, Daniel Schultz wrote:
> Labels are not allowed before declarations. Move the carveout struct
> at the beginning and only update 'end' at this point.
>
> This will fix following error:
>
> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a statement and a declaration is not a statement
>    156 |  struct fdt_memory carveout = {
>        |  ^~~~~~
> make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] Error 1
> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2
>
> Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")
>
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
> Changes in v2:
>    * Moved carveout struct at the beginning instead of adding an dummy statement.
>
>   arch/arm/mach-k3/common_fdt.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
> index 361b0c0b31b..9437b923d49 100644
> --- a/arch/arm/mach-k3/common_fdt.c
> +++ b/arch/arm/mach-k3/common_fdt.c
> @@ -119,6 +119,10 @@ int fdt_fixup_reserved(void *blob, const char *name,
>   {
>   	int nodeoffset, subnode;
>   	int ret;
> +	struct fdt_memory carveout = {
> +		.start = new_address,
> +		.end = new_address + new_size - 1,

I think there is no need of assigning end here. As final value is 
updated at last.

With this change

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> +	};
>   
>   	/* Find reserved-memory */
>   	nodeoffset = fdt_subnode_offset(blob, 0, "reserved-memory");
> @@ -153,10 +157,7 @@ int fdt_fixup_reserved(void *blob, const char *name,
>   	}
>   
>   add_carveout:
> -	struct fdt_memory carveout = {
> -		.start = new_address,
> -		.end = new_address + new_size - 1,
> -	};
> +	carveout.end = new_address + new_size - 1;
>   	ret = fdtdec_add_reserved_memory(blob, name, &carveout, NULL, 0, NULL,
>   					 FDTDEC_RESERVED_MEMORY_NO_MAP);
>   	if (ret < 0)
