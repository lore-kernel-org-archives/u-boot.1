Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748B8C369B8
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 13:51:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD0548212B;
	Mon, 14 Apr 2025 15:51:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="s/srBhbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD4A82132; Mon, 14 Apr 2025 15:51:44 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 712748212F
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EDpbSU2070878
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Apr 2025 08:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744638697;
 bh=k7mtDtKYFT2O35xKT9RrOSaMaKZIqvElq9DLkyAvR9k=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=s/srBhbvu9FDDiBqn0lTn8ia/HKg2JXjBnShxZWWxWkG8tz03ePq7/UO4Vw9EU7n7
 LBzv7PbJwqVKd/ddiMVGI/TcGYzJBmJo3j9c2S2QmcOE/YQTgewdjH7FTJyNiVMeWm
 iNm+AfdSJz3ZMkdG2g5VYOw0wcgY5w1Aso1Z3bmk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EDpbk2035735
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Apr 2025 08:51:37 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 08:51:37 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 08:51:36 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EDparY086021;
 Mon, 14 Apr 2025 08:51:36 -0500
Message-ID: <e0f5dff0-3dab-444d-95cb-b06de90d84d5@ti.com>
Date: Mon, 14 Apr 2025 08:51:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] configs: am67a_beagley_ai_a53: Enable additional
 features
To: Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Neha
 Malcom Francis <n-francis@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, <u-boot@lists.denx.de>
References: <20250411225717.3117370-1-nm@ti.com>
 <20250411225717.3117370-9-nm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250411225717.3117370-9-nm@ti.com>
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

On 4/11/25 5:57 PM, Nishanth Menon wrote:
> Enable basic efi capsule features, switch over to stdboot, enable
> GPIO, LED and PMIC used on this platform. And enable UHS mode support
> for SD cards in U-Boot.
> 
> Capsule support is still pending.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   configs/am67a_beagley_ai_a53_defconfig | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/am67a_beagley_ai_a53_defconfig b/configs/am67a_beagley_ai_a53_defconfig
> index cbf19a03b136..657920025ad3 100644
> --- a/configs/am67a_beagley_ai_a53_defconfig
> +++ b/configs/am67a_beagley_ai_a53_defconfig
> @@ -32,7 +32,7 @@ CONFIG_AUTOBOOT_KEYED=y
>   CONFIG_AUTOBOOT_PROMPT="Press SPACE to abort autoboot in %d seconds\n"
>   CONFIG_AUTOBOOT_DELAY_STR="d"
>   CONFIG_AUTOBOOT_STOP_STR=" "
> -CONFIG_BOOTCOMMAND="run findfdt; run envboot; run distro_bootcmd"
> +CONFIG_BOOTCOMMAND="run set_led_state_start_load; run envboot; bootflow scan -lb;run set_led_state_fail_load"

nit: should be space after all the last ";" char

Acked-by: Andrew Davis <afd@ti.com>

>   CONFIG_BOARD_LATE_INIT=y
>   CONFIG_SPL_MAX_SIZE=0x58000
>   CONFIG_SPL_PAD_TO=0x0
> @@ -49,7 +49,9 @@ CONFIG_SPL_RAM_DEVICE=y
>   CONFIG_SPL_THERMAL=y
>   CONFIG_SPL_YMODEM_SUPPORT=y
>   CONFIG_CMD_CLK=y
> +CONFIG_CMD_GPIO_READ=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
> +CONFIG_CMD_EFIDEBUG=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_OF_UPSTREAM=y
> @@ -81,6 +83,10 @@ CONFIG_SPL_DM_GPIO_LOOKUP_LABEL=y
>   CONFIG_DA8XX_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_OMAP24XX=y
> +CONFIG_LED=y
> +CONFIG_SPL_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_SPL_LED_GPIO=y
>   CONFIG_DM_MAILBOX=y
>   CONFIG_K3_SEC_PROXY=y
>   CONFIG_I2C_EEPROM=y
> @@ -88,6 +94,7 @@ CONFIG_SPL_I2C_EEPROM=y
>   CONFIG_FS_LOADER=y
>   CONFIG_MMC_IO_VOLTAGE=y
>   CONFIG_SPL_MMC_IO_VOLTAGE=y
> +CONFIG_MMC_UHS_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ADMA=y
>   CONFIG_SPL_MMC_SDHCI_ADMA=y
> @@ -99,12 +106,15 @@ CONFIG_SPL_PINCTRL=y
>   CONFIG_PINCTRL_SINGLE=y
>   CONFIG_POWER_DOMAIN=y
>   CONFIG_TI_SCI_POWER_DOMAIN=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_TPS65219=y
>   CONFIG_DM_REGULATOR=y
>   CONFIG_SPL_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_FIXED=y
>   CONFIG_SPL_DM_REGULATOR_FIXED=y
>   CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_SPL_DM_REGULATOR_GPIO=y
> +CONFIG_DM_REGULATOR_TPS65219=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_RESET_TI_SCI=y
>   CONFIG_DM_SERIAL=y
