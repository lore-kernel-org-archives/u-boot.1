Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A0C07548
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 05:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A162886C3B;
	Wed, 15 Nov 2023 06:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TXq1mpxJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0663586C3B; Wed, 15 Nov 2023 06:50:07 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BD186F93
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 06:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AF5nt1w030176;
 Tue, 14 Nov 2023 23:49:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700027395;
 bh=myuDF4GKD4RPAIt3G+cuVG6HJR5DIMigXC4epBIZudE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=TXq1mpxJnbtYt0TX0586xdmLlnZarAlFOJGlQNXfWX+EbznvdRXntXYGI0g2xf2e9
 ZauVyYbPUzpu9pfzJk/59YJzQzaWj99kXksOQFKPCQg8d3fPBi/WQRDcYnsWj959gY
 VnOad2wEx9KZqZ46el5fxnX1X7L7TJnOywe7IzHY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AF5nttR089025
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 14 Nov 2023 23:49:55 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 14
 Nov 2023 23:49:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 14 Nov 2023 23:49:54 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AF5npRQ125450;
 Tue, 14 Nov 2023 23:49:51 -0600
Message-ID: <6378b86f-e9aa-443d-9180-b37b9a718bf4@ti.com>
Date: Wed, 15 Nov 2023 11:19:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] arm: mach-k3: am62a: Add main_timer0 id to the dev
 list
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom
 Rini <trini@konsulko.com>
CC: Siddharth Vadapalli <s-vadapalli@ti.com>, Andrew Davis <afd@ti.com>, Roger
 Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Jai Luthra <j-luthra@ti.com>,
 <u-boot@lists.denx.de>
References: <20231113145149.1926732-1-nm@ti.com>
 <20231113145149.1926732-2-nm@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231113145149.1926732-2-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Nishanth

On 13/11/23 20:21, Nishanth Menon wrote:
> main_timer0 is used by u-boot as the tick-timer. Add it to the soc
> devices list so it an be enabled via the k3 power controller.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/mach-k3/am62ax/dev-data.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-k3/am62ax/dev-data.c b/arch/arm/mach-k3/am62ax/dev-data.c
> index abf5d8e91aa2..6cced9efd08a 100644
> --- a/arch/arm/mach-k3/am62ax/dev-data.c
> +++ b/arch/arm/mach-k3/am62ax/dev-data.c
> @@ -52,6 +52,7 @@ static struct ti_dev soc_dev_list[] = {
>   	PSC_DEV(161, &soc_lpsc_list[5]),
>   	PSC_DEV(162, &soc_lpsc_list[6]),
>   	PSC_DEV(75, &soc_lpsc_list[7]),
> +	PSC_DEV(36, &soc_lpsc_list[8]),
>   	PSC_DEV(102, &soc_lpsc_list[8]),
>   	PSC_DEV(146, &soc_lpsc_list[8]),
>   	PSC_DEV(166, &soc_lpsc_list[9]),


Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
