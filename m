Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA33C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 18:27:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDC3088763;
	Tue, 13 Aug 2024 20:27:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="g4pAjrl7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD67B8899C; Tue, 13 Aug 2024 20:27:48 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FF868839A
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 20:27:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47DIRW38027767;
 Tue, 13 Aug 2024 13:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723573652;
 bh=Hh1yHO0jkAsOBKKxMoRpor8KDndYebVuW69AulBgR1Q=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=g4pAjrl7BZ7r/Lpe3fENEpJeiNxbY+uFt27/InSa0FQfQpP8J0SWMiPLT+ljkskLw
 Ugqartx8H3osM9J3SQpIfuoxDhABjIz+oRiAPBLnIOW+7cMWmSnioUMjnkzdChiA2L
 VP5QANtUNIw14aa92zciWM/LCWpZKmMN1W+Q4JwM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47DIRWwY015405
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 13:27:32 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 13:27:31 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 13:27:31 -0500
Received: from [128.247.81.8] (ula0226330.dhcp.ti.com [128.247.81.8])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47DIRVDS055015;
 Tue, 13 Aug 2024 13:27:31 -0500
Message-ID: <2d9d9eae-1bdb-44e8-976b-72ec5bc67aab@ti.com>
Date: Tue, 13 Aug 2024 13:27:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] arm: mach-k3: am62x: am625_init: Probe AM65 CPSW
 NUSS
To: Chintan Vankar <c-vankar@ti.com>, Michal Simek <michal.simek@amd.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, "Marek
 Vasut" <marek.vasut+renesas@mailbox.org>, Neha Malcom Francis
 <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>, MD Danish Anwar
 <danishanwar@ti.com>, Ravi Gunasekaran <r-gunasekaran@ti.com>, "Matthias
 Schiffer" <matthias.schiffer@ew.tq-group.com>, Andreas Dannenberg
 <dannenberg@ti.com>, Jonas Karlman <jonas@kwiboo.se>, Devarsh Thakkar
 <devarsht@ti.com>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Kishon Vijay Abraham I <kishon@ti.com>, "Joao Paulo
 Goncalves" <joao.goncalves@toradex.com>, Wadim Egorov <w.egorov@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Dhruva Gole <d-gole@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Nishanth Menon <nm@ti.com>, Sumit Garg
 <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
References: <20240812113621.3840652-1-c-vankar@ti.com>
 <20240812114856.3843785-1-c-vankar@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240812114856.3843785-1-c-vankar@ti.com>
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

On 8/12/24 6:48 AM, Chintan Vankar wrote:
> From: Kishon Vijay Abraham I <kishon@ti.com>
> 
> In order to support Ethernet boot on AM62x, probe AM65 CPSW NUSS
> driver in board_init_f().
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
> 
> Link to v4:
> https://lore.kernel.org/r/20240705045030.1141934-7-c-vankar@ti.com/
> 
> Changes from v3 to v4:
> - No changes.
> 
>   arch/arm/mach-k3/am62x/am625_init.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 72a752d38e..0182c153a6 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -280,6 +280,16 @@ void board_init_f(ulong dummy)
>   		if (ret)
>   			panic("DRAM init failed: %d\n", ret);
>   	}
> +
> +	if (IS_ENABLED(CONFIG_SPL_ETH) && IS_ENABLED(CONFIG_TI_AM65_CPSW_NUSS) &&
> +	    spl_boot_device() == BOOT_DEVICE_ETHERNET) {
> +		struct udevice *cpswdev;
> +
> +		if (uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(am65_cpsw_nuss),
> +						&cpswdev))
> +			printf("Failed to probe am65_cpsw_nuss driver\n");
> +	}
> +
>   	spl_enable_cache();

Any reason you added this before enabling caches?

Andrew

>   
>   	fixup_a53_cpu_freq_by_speed_grade();
