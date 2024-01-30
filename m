Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D215C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 10:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0583E87C46;
	Tue, 30 Jan 2024 11:04:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dTCZGOYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53D7D8309D; Tue, 30 Jan 2024 11:04:00 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DBBE87C4C
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 11:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UA3pse069549;
 Tue, 30 Jan 2024 04:03:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706609031;
 bh=4S6LhHAPnwgW1KF52X8Lr/lsLE1rcnKgPTVyIYC1waE=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dTCZGOYy4PjzVYs0DcV7SAy1VLNfQpvNKthVjaiI/q38AiN7y398eiQfoo+uNcma6
 zZp3W0YLB2labgRVAJ35nlYoZ1w6ksOohDi/90qmivDSHk3TnjlH4PweR7aMT/sjfq
 lteS41hglr89T3rdiUo1dWlDQMYnpehEU4Xi3wfI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UA3pQb030805
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 04:03:51 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 04:03:51 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 04:03:51 -0600
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UA3lb5026662;
 Tue, 30 Jan 2024 04:03:48 -0600
Message-ID: <b6baa964-e1f2-4fe0-8b24-a1f2c6fee007@ti.com>
Date: Tue, 30 Jan 2024 15:33:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mach-k3: j721s2_init: Support less than max DDR
 controllers
Content-Language: en-US
To: <trini@konsulko.com>, <m-chawdhry@ti.com>
CC: <u-kumar1@ti.com>, <afd@ti.com>, <christian.gmeiner@gmail.com>,
 <j-choudhary@ti.com>, <nm@ti.com>, <d.haller@phytec.de>,
 <joao.goncalves@toradex.com>, <u-boot@lists.denx.de>
References: <20240130094247.2707253-1-n-francis@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240130094247.2707253-1-n-francis@ti.com>
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

Hi all

On 30/01/24 15:12, Neha Malcom Francis wrote:
> The number of DDR controllers to be initialised and used should depend
> on the device tree with the constraint of the maximum number of
> controllers the device supports. Since J721S2 has multiple (2)
> controllers, instead of hardcoding the number of probes, move to
> depending on the device tree UCLASS_RAM nodes present.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Changes since v1:
> https://lore.kernel.org/all/20240130074139.2627793-1-n-francis@ti.com/
> - Moved away from using loop since J721S2 has only two controllers
>    (Udit)
> 
> Boot logs:
> https://gist.github.com/nehamalcom/740e3dcc1e94ca36250f0248d73f6b37
> 
>   arch/arm/mach-k3/j721s2_init.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
> index fb0708bae1..07f9221baf 100644
> --- a/arch/arm/mach-k3/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2_init.c
> @@ -228,8 +228,8 @@ void k3_mem_init(void)
>   			panic("DRAM 0 init failed: %d\n", ret);
>   
>   		ret = uclass_next_device_err(&dev);
> -		if (ret)
> -			panic("DRAM 1 init failed: %d\n", ret);
> +		if (ret && ret != -ENODEV)
> +			panic("DRAM %d init failed: %d\n", ctr, ret);
>   	}
>   	spl_enable_cache();
>   }

Kindly ignore this patch, will resend v2.

-- 
Thanking You
Neha Malcom Francis
