Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50848C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 06:11:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7706F8785F;
	Wed, 31 Jan 2024 07:11:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vFPI1guk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F63587887; Wed, 31 Jan 2024 07:11:40 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBEC87796
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 07:11:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40V6BaEU129415;
 Wed, 31 Jan 2024 00:11:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706681496;
 bh=mdgvSTOodNfM7L6QN9M3RNrNHAOv7OE4vSngiNw/PwI=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=vFPI1gukYQIaYRpDygan91nym1lSHZxkLCCu4KnN2/FsDfQp+DNRpobUAUqRkxDm8
 JGuJ17RjQz/j+F7pqx7jqT2Q1BK9D4i24L+AxlSZOgNlb/i/pVbXRZr71C//08QVFm
 0byMulih41nR0SIGvqQa63tSK52ocQhrm9P7/jIo=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40V6BakU024802
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 00:11:36 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 00:11:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 00:11:35 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40V6BY6n075453;
 Wed, 31 Jan 2024 00:11:35 -0600
Date: Wed, 31 Jan 2024 11:41:34 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <u-kumar1@ti.com>, <afd@ti.com>,
 <christian.gmeiner@gmail.com>, <j-choudhary@ti.com>, <nm@ti.com>,
 <d.haller@phytec.de>, <joao.goncalves@toradex.com>, <u-boot@lists.denx.de>
Subject: Re: [RESEND PATCH v2] arm: mach-k3: j721s2_init: Support less than
 max DDR controllers
Message-ID: <20240131061134.3swmvabc3xvkdvj2@uda0497581>
References: <20240130102356.2762733-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130102356.2762733-1-n-francis@ti.com>
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

Hi Neha,

On 15:53-20240130, Neha Malcom Francis wrote:
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
>   (Udit)
> 
> Boot logs:
> https://gist.github.com/nehamalcom/740e3dcc1e94ca36250f0248d73f6b37
> 
> arch/arm/mach-k3/j721s2_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
> index fb0708bae1..3374889558 100644
> --- a/arch/arm/mach-k3/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2_init.c
> @@ -228,7 +228,7 @@ void k3_mem_init(void)
>  			panic("DRAM 0 init failed: %d\n", ret);
>  
>  		ret = uclass_next_device_err(&dev);
> -		if (ret)
> +		if (ret && ret != -ENODEV)
>  			panic("DRAM 1 init failed: %d\n", ret);

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

Regards,
Manorit

>  	}
>  	spl_enable_cache();
> -- 
> 2.34.1
> 
