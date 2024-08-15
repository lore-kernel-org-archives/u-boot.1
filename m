Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF2BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 03:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7730E889FD;
	Thu, 15 Aug 2024 05:16:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VS6aTI59";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44DE488A1C; Thu, 15 Aug 2024 05:16:47 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E325E889F8
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 05:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47F3GgdE089908;
 Wed, 14 Aug 2024 22:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723691803;
 bh=bwEvXVqRtsBh+2a5EUYskSrGKYdEeWw+BVTZVqSpua8=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=VS6aTI59LU/Q3MU8Bi8GjAUg7H/rVTAoXf8Q+HG1HVRE7aF/O2efKWqsgchEUKXBf
 Imuxvy6h7sLdyPpctVR3zoH8eJ0NCZyO45IN+5vnvCZwk6VnNZPLBQc/Y/m+xJuRAk
 4j/dxh5CfU9/jQhhhIuaLADGIa7qJrYFUP7u0OY0=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47F3Gg0S011579
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 14 Aug 2024 22:16:42 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Aug 2024 22:16:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Aug 2024 22:16:41 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47F3GbbZ044007;
 Wed, 14 Aug 2024 22:16:38 -0500
Message-ID: <9ea12c2e-3fbf-4d32-9702-a97852a8ccde@ti.com>
Date: Thu, 15 Aug 2024 08:46:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] arm: mach-k3: j721s2_init: Initialize AVS Class 0
To: Manorit Chawdhry <m-chawdhry@ti.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Aniket Limaye <a-limaye@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis
 <afd@ti.com>, Nishanth Menon <nm@ti.com>, <u-kumar1@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
 <20240813-b4-upstream-j721s2-avs-v3-5-5115d93cdeb2@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-5-5115d93cdeb2@ti.com>
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


On 8/13/2024 11:40 AM, Manorit Chawdhry wrote:
> Initialize AVS Class 0.
>
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>   arch/arm/mach-k3/j721s2/j721s2_init.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/mach-k3/j721s2/j721s2_init.c b/arch/arm/mach-k3/j721s2/j721s2_init.c
> index 05453fcad41a..5f5961a2c17a 100644
> --- a/arch/arm/mach-k3/j721s2/j721s2_init.c
> +++ b/arch/arm/mach-k3/j721s2/j721s2_init.c
> @@ -315,6 +315,9 @@ void do_dt_magic(void)
>   #ifdef CONFIG_SPL_BUILD
>   void board_init_f(ulong dummy)
>   {
> +	struct udevice *dev;
> +	int ret;
> +
>   	k3_spl_init();
>   #if defined(CONFIG_SPL_OF_LIST) && defined(CONFIG_TI_I2C_BOARD_DETECT)
>   	do_dt_magic();
> @@ -325,6 +328,13 @@ void board_init_f(ulong dummy)
>   		setup_navss_nb();
>   
>   	setup_qos();
> +
> +	if (IS_ENABLED(CONFIG_CPU_V7R) && IS_ENABLED(CONFIG_K3_AVS0)) {
> +		ret = uclass_get_device_by_driver(UCLASS_MISC, DM_DRIVER_GET(k3_avs),
> +						  &dev);

Can we remove this ret, Something like


if (uclass_get_device_by_driver....)

printf();

if you think, ok to change

> +		if (ret)
> +			printf("AVS init failed: %d\n", ret);
> +	}
>   }
>   #endif
>   
>
