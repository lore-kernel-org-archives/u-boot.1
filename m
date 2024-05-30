Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B718C25B75
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 02:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCC93884C3;
	Thu, 30 May 2024 04:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yw1lwWi6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 630C3885E1; Thu, 30 May 2024 04:45:32 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEAA6883F6
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 04:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U2jMc4122635;
 Wed, 29 May 2024 21:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1717037122;
 bh=EvAwv/+SXgPx/Cu54iMih3nCHav4c3NlvMu1SZnfrIg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Yw1lwWi6r9JhCCXHGAJjYrzbor97QgtYII/+jbjyvUeayPFEXhxU8JWIKUPo8gFTB
 ztdsr+eXq/YGJ8xPHhnMZthi9klo1xtapruaztBxXNKXB6qYRi2GScxYRBfDXVvzQU
 R719f5lGQfFa4l864Wk2WbZ8spkd5JFGV73AExaI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U2jMJY126572
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 29 May 2024 21:45:22 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 21:45:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 21:45:22 -0500
Received: from [172.24.227.36]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U2jI9S086496;
 Wed, 29 May 2024 21:45:18 -0500
Message-ID: <7bfd2138-d882-4e07-bdbf-f4fa907600f5@ti.com>
Date: Thu, 30 May 2024 08:15:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arch: mach-k3: Introduce basic files to support
 J722S SoC family
To: Jayesh Choudhary <j-choudhary@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <jh80.chung@samsung.com>, <lukma@denx.de>,
 <seanga2@gmail.com>, <vaishnav.a@ti.com>, <u-kumar1@ti.com>,
 <sumit.garg@linaro.org>, <afd@ti.com>
CC: <vigneshr@ti.com>, <nm@ti.com>, <bb@ti.com>, <rogerq@kernel.org>
References: <20240529132448.459330-1-j-choudhary@ti.com>
 <20240529132448.459330-10-j-choudhary@ti.com>
Content-Language: en-US
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240529132448.459330-10-j-choudhary@ti.com>
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

Hi Jayesh

On 29/05/24 18:54, Jayesh Choudhary wrote:
> Introduce the basic functions and definitions needed to properly
> initialize TI J722S family of SoCs.
> 
> Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>   arch/arm/mach-k3/Kconfig                      |   7 +-
>   arch/arm/mach-k3/Makefile                     |   1 +
>   arch/arm/mach-k3/include/mach/hardware.h      |   4 +
>   .../arm/mach-k3/include/mach/j722s_hardware.h |  83 ++++++
>   arch/arm/mach-k3/include/mach/j722s_spl.h     |  49 ++++
>   arch/arm/mach-k3/include/mach/spl.h           |   4 +
>   arch/arm/mach-k3/j722s/Kconfig                |  32 ++
>   arch/arm/mach-k3/j722s/Makefile               |   6 +
>   arch/arm/mach-k3/j722s/j722s_init.c           | 277 ++++++++++++++++++
>   9 files changed, 462 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/mach-k3/include/mach/j722s_hardware.h
>   create mode 100644 arch/arm/mach-k3/include/mach/j722s_spl.h
>   create mode 100644 arch/arm/mach-k3/j722s/Kconfig
>   create mode 100644 arch/arm/mach-k3/j722s/Makefile
>   create mode 100644 arch/arm/mach-k3/j722s/j722s_init.c
> 

[...]

> +
> +void board_init_f(ulong dummy)
> +{

J784S4 went through quite a bit of revisions and I personally would like to use 
it as an example (for now) for our code layout for all future devices until we 
cleanup further. See [1] where it was addressed to have board_init_f split up 
into calling smaller logical functions instead.

[1] https://lore.kernel.org/u-boot/20240103162504.xgbx73pnmthtzthl@vengeful/

> +	struct udevice *dev;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_CPU_V7R))
> +		setup_k3_mpu_regions();
> +
> +	/*
> +	 * Cannot delay this further as there is a chance that
> +	 * K3_BOOT_PARAM_TABLE_INDEX can be over written by SPL MALLOC section.
> +	 */
> +	store_boot_info_from_rom();
> +
> +	ctrl_mmr_unlock();
> +
> +	/* Init DM early */
> +	ret = spl_early_init();
> +	if (ret)
> +		panic("spl_early_init() failed: %d\n", ret);
> +
> +	/*
> +	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue

[...]

-- 
Thanking You
Neha Malcom Francis
