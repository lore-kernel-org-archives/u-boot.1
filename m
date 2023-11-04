Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454DFC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 10:25:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24EC187090;
	Sat,  4 Nov 2023 11:24:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N232cTSd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A57487091; Sat,  4 Nov 2023 11:24:53 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291578708D
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 11:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A4AOdFm043321;
 Sat, 4 Nov 2023 05:24:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699093479;
 bh=2yIilkJjNMg8L1RT9+SP6oJBMCUg1pQ2tXjQ3xAEShw=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=N232cTSdAlw2qM6gljZVGBveegS4M45iu6thuP4cYX7R9mZUCckhHtiAtdfbqJ+sd
 i7GBn/n7z+Dy0H9mevVPB12FYHQoTTdme1jMxSJgYC/b9Xr4OJybeP8Ze6oGax1R/U
 WwmhXhihOtVInecKt8ZZHLB5j1SQGNs5amS0VPEw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A4AOcxL128169
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 05:24:38 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 05:24:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 05:24:38 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A4AOW0P083373;
 Sat, 4 Nov 2023 05:24:33 -0500
Message-ID: <0b3ecb9a-7099-4296-88af-dd204ffa600f@ti.com>
Date: Sat, 4 Nov 2023 15:54:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/15] arm: mach-k3: j721e: Improve support for UDA FS
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-2-nm@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20231103003805.2420005-2-nm@ti.com>
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


On 11/3/2023 6:07 AM, Nishanth Menon wrote:
> Commit 5019170970ad ("arch: arm: mach-k3: j721e: add support for UDA
> FS") introduced basic UDA FS support, however, we can Take approach
> similar to commit 0f1c1e8b368b ("arm: mach-k3: am625: Add support for
> UDA FS"). While boot partition support with EMMC boot is useful, it is
> constrained by the size of boot hardware partition itself.
>
> In the case of K3 devices, tispl images can contain OP-TEE images that
> can substantially vary in size and the u-boot image itself can vary over
> time as we enable various features.
>
> So use the CSD information in the case of EMMC_BOOT configuration being
> enabled to pick boot partition or UDA FS mode operation to pick.
>
> If EMMC_BOOT is disabled, then depend on filesystem configuration to
> pick data from UDA.

I am thinking, in which case we have EMMC_BOOT disabled,

Case here I am considering, updating u-boot to eMMC from u-boot shell, 
If EMMC_BOOT

is not set then , we can not set CSD information

>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   arch/arm/mach-k3/j721e_init.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
> index b1f7e25ed092..bcdfbfc79c4a 100644
> --- a/arch/arm/mach-k3/j721e_init.c
> +++ b/arch/arm/mach-k3/j721e_init.c
> @@ -294,7 +294,14 @@ u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
>   {
>   	switch (boot_device) {
>   	case BOOT_DEVICE_MMC1:
> -		return (spl_mmc_emmc_boot_partition(mmc) ? MMCSD_MODE_EMMCBOOT : MMCSD_MODE_FS);
> +		if (IS_ENABLED(CONFIG_SUPPORT_EMMC_BOOT)) {
> +			if (spl_mmc_emmc_boot_partition(mmc))
> +				return MMCSD_MODE_EMMCBOOT;
> +			return MMCSD_MODE_FS;
> +		}

I had a view EMMC_BOOT should be needed config.


> +		if (IS_ENABLED(CONFIG_SPL_FS_FAT) || IS_ENABLED(CONFIG_SPL_FS_EXT4))
> +			return MMCSD_MODE_FS;
> +		return MMCSD_MODE_EMMCBOOT;

If you consider, to make EMMC_BOOT as needed config, then this is not needed


>   	case BOOT_DEVICE_MMC2:
>   		return MMCSD_MODE_FS;
>   	default:
