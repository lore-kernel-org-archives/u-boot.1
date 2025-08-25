Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4783CA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 15:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0718A83020;
	Mon, 25 Aug 2025 17:53:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TV3NgD65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A5F8304F; Mon, 25 Aug 2025 17:53:25 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39FC82FC7
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 17:53:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57PFrL7W1326374
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756137201;
 bh=Aopzv28HSUo3dtWkg6vtODby1h/n8SybppZwguWW+7s=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=TV3NgD65qz56pkBxb2JpYeDqTT0Uhs6g5zMV3zTUp+pujc3smeutL5ssPuasn0vh4
 EY4DWp5GeDsQeP1YI5h9srM4Smxbqs4XBJEh9vn36E1oD69utVENOxKscj2XaD9lui
 Uj9wZUl+B3TmKl/Y/h/kLgDkHozYR2+C2zhGXZGQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57PFrLor1690973
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:53:21 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 25
 Aug 2025 10:53:21 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.1748.24; Mon, 25 Aug
 2025 10:53:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 25 Aug 2025 10:53:20 -0500
Received: from [10.24.72.162] (moteen-ubuntu-desk.dhcp.ti.com [10.24.72.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 57PFrJiQ3859082
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 10:53:20 -0500
Message-ID: <486fd02f-6d83-4f9d-8491-a5b696d68685@ti.com>
Date: Mon, 25 Aug 2025 21:23:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mach-k3: am62*: Fix backup from eMMC boot mode
To: <u-boot@lists.denx.de>
References: <20250820215634.52880-1-jm@ti.com>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20250820215634.52880-1-jm@ti.com>
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

On 21/08/25 03:26, Judith Mendez wrote:

> Currently logic in spl_mmc_boot_mode only lookes at main devstat
> to determine the bootmode to return. Thus, when using: 'eMMC boot'
> as primary boot mode and 'MMCSD boot from eMMC UDA' as backup
> boot mode, 'eMMC boot' is always selected. Add check for bootindex
> to determine if ROM boot via backup boot mode and return MMCSD_MODE_FS
> which is the only supported backup bootmode with eMMC device.
>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   arch/arm/mach-k3/am62ax/am62a7_init.c | 5 +++++
>   arch/arm/mach-k3/am62px/am62p5_init.c | 5 +++++
>   arch/arm/mach-k3/am62x/am625_init.c   | 5 +++++
>   3 files changed, 15 insertions(+)
>
> diff --git a/arch/arm/mach-k3/am62ax/am62a7_init.c b/arch/arm/mach-k3/am62ax/am62a7_init.c
> index 00173e6836b..48d578e7d6f 100644
> --- a/arch/arm/mach-k3/am62ax/am62a7_init.c
> +++ b/arch/arm/mach-k3/am62ax/am62a7_init.c
> @@ -218,6 +218,11 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>   			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>   
> +	if (bootindex != K3_PRIMARY_BOOTMODE) {
> +		pr_alert("Fallback to backup bootmode MMCSD_MODE_FS\n");
> +		return MMCSD_MODE_FS;
> +	}
> +
>   	switch (bootmode) {
>   	case BOOT_DEVICE_EMMC:
>   		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> diff --git a/arch/arm/mach-k3/am62px/am62p5_init.c b/arch/arm/mach-k3/am62px/am62p5_init.c
> index 44a2d445d24..aebd5200b0d 100644
> --- a/arch/arm/mach-k3/am62px/am62p5_init.c
> +++ b/arch/arm/mach-k3/am62px/am62p5_init.c
> @@ -264,6 +264,11 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>   			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>   
> +	if (bootindex != K3_PRIMARY_BOOTMODE) {
> +		pr_alert("Fallback to backup bootmode MMCSD_MODE_FS\n");
> +		return MMCSD_MODE_FS;
> +	}
> +
>   	switch (bootmode) {
>   	case BOOT_DEVICE_EMMC:
>   		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))
> diff --git a/arch/arm/mach-k3/am62x/am625_init.c b/arch/arm/mach-k3/am62x/am625_init.c
> index 8f4ddf59753..14f93ac998f 100644
> --- a/arch/arm/mach-k3/am62x/am625_init.c
> +++ b/arch/arm/mach-k3/am62x/am625_init.c
> @@ -305,6 +305,11 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   	u32 bootmode_cfg = (devstat & MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_MASK) >>
>   			    MAIN_DEVSTAT_PRIMARY_BOOTMODE_CFG_SHIFT;
>   
> +	if (bootindex != K3_PRIMARY_BOOTMODE) {
> +		pr_alert("Fallback to backup bootmode MMCSD_MODE_FS\n");
> +		return MMCSD_MODE_FS;
> +	}
> +
>   	switch (bootmode) {
>   	case BOOT_DEVICE_EMMC:
>   		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT))


Reviewed-by: Moteen Shah <m-shah@ti.com>

Regards,
Moteen

