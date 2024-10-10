Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385CDCF11FF
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 15:55:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9412C88EB5;
	Thu, 10 Oct 2024 17:55:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="CDJQUgSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A2A388EE6; Thu, 10 Oct 2024 17:55:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3621488B64
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 17:55:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49AFtiKY129455;
 Thu, 10 Oct 2024 10:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728575744;
 bh=stOqvU5JfAOo26ScgxEwPM9W9oSZfiSwNR2Mq0qs/Pg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=CDJQUgSJdOFeu1ot/njnYP46/YcWagmmWen9UQzldz/VCj/DDTGwcie+/aV0z5paP
 9MLaMyMYcvWGbg9IEzAW5jOVkNl8+DWWXtzO5u9fuVkBlK4OG5EUnWnBoP4rNW7NaK
 ZksZ2Hif9VUGRvKqntYkgpdJRxoh9LJ6dO26q4Z4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49AFtimf012226
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 10 Oct 2024 10:55:44 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Oct 2024 10:55:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Oct 2024 10:55:43 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49AFtPg3085247;
 Thu, 10 Oct 2024 10:55:35 -0500
Message-ID: <3170149c-2e82-48f3-8477-e82acf6c58dd@ti.com>
Date: Thu, 10 Oct 2024 21:25:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boardf: Modify DRAM message
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <sjg@chromium.org>, <devarsht@ti.com>, <jonas@kwiboo.se>, <richard@nod.at>,
 <raymond.mao@linaro.org>, <u-boot@lists.denx.de>, <u-kumar1@ti.com>
References: <20241010070909.288313-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241010070909.288313-1-n-francis@ti.com>
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


On 10/10/2024 12:39 PM, Neha Malcom Francis wrote:
> The message "DRAM:  2 GiB (effective 32 GiB)" can be a little confusing,
> modify the message to show exactly what is meant:
>
> "DRAM:  2 GiB (available for U-Boot out of total 32 GiB)"


Still confusing for me atleast :) can this be

"DRAM: 2 GiB available for U-Boot, out of total 32 GiB"


>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   common/board_f.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/common/board_f.c b/common/board_f.c
> index 154675d0e40..b7add8f7d3d 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -254,7 +254,7 @@ static int show_dram_config(void)
>   
>   	print_size(gd->ram_size, "");
>   	if (!sizes_near(gd->ram_size, size)) {
> -		printf(" (effective ");
> +		printf(" (available for U-Boot out of total ");
>   		print_size(size, ")");
>   	}
>   	board_add_ram_info(0);
