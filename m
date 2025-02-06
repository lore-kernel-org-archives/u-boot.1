Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF7EC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:07:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6F4580ECC;
	Fri,  7 Feb 2025 00:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="arA8RxCJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CFB480EF6; Fri,  7 Feb 2025 00:07:53 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DAD180CB0
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 516N7m3e3712111
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 6 Feb 2025 17:07:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738883268;
 bh=tJ6++CgfZgaGjCVPxBnfMDg+e6ArZH6HInXE3skpZks=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=arA8RxCJHx+fC/Tfgw3W07JXkQyY9lWp8YtBwOL+HzxTGj0BCg/oZ1sjWy0Di0beM
 iyDRCf2Sc6SV02qnQhk7njH01fMb87WYcMQifrGFRDKgTvn03kfAzjLa1lFKpAueot
 Hp1b/mWZfatCaj1W95Q3NjTZKcGFy4o6VifhH7yU=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 516N7m4A126425
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 6 Feb 2025 17:07:48 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 6
 Feb 2025 17:07:48 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 6 Feb 2025 17:07:48 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 516N7lL5111031;
 Thu, 6 Feb 2025 17:07:47 -0600
Message-ID: <90090081-09d3-4c02-937b-f35e1594f434@ti.com>
Date: Thu, 6 Feb 2025 17:07:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] configs: am6*_evm_a53_defconfig: Enable remoteproc
 support
To: Judith Mendez <jm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
References: <20250206015406.2702944-1-jm@ti.com>
 <20250206015406.2702944-7-jm@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20250206015406.2702944-7-jm@ti.com>
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

On 2/5/25 7:54 PM, Judith Mendez wrote:
> From: Hari Nagalla <hnagalla@ti.com>
> 
> Enable configs needed to enable remoteproc drivers for AM62
> and AM64 devices.
> 
> While we are here, cleanup some remoteproc configs, there
> is no DSP subsystem for am62px device.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> Changes since v3:
> - Add remoteproc support configs for am62x
> - Cleanup remoteproc configs for am62p and am64x.
> ---
>   configs/am62px_evm_a53_defconfig | 1 -
>   configs/am62x_evm_a53_defconfig  | 2 ++
>   configs/am64x_evm_a53_defconfig  | 4 +++-
>   3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
> index 30b4a24ee9a..10e00519bc1 100644
> --- a/configs/am62px_evm_a53_defconfig
> +++ b/configs/am62px_evm_a53_defconfig
> @@ -147,7 +147,6 @@ CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_SPL_DM_REGULATOR_GPIO=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
> -CONFIG_REMOTEPROC_TI_K3_DSP=y
>   CONFIG_REMOTEPROC_TI_K3_R5F=y
>   CONFIG_RESET_TI_SCI=y
>   CONFIG_DM_RTC=y
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index c77e09db156..51b8c0ae3fb 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -56,6 +56,7 @@ CONFIG_SPL_YMODEM_SUPPORT=y
>   CONFIG_CMD_BOOTEFI_SELFTEST=y
>   CONFIG_CMD_NVEDIT_EFI=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_REMOTEPROC=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_OF_CONTROL=y
> @@ -121,6 +122,7 @@ CONFIG_DM_REGULATOR_GPIO=y
>   CONFIG_SPL_DM_REGULATOR_GPIO=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
> +CONFIG_REMOTEPROC_TI_K3_M4F=y
>   CONFIG_RESET_TI_SCI=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_EMULATION=y
> diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_defconfig
> index a501f3f567e..5528f54549d 100644
> --- a/configs/am64x_evm_a53_defconfig
> +++ b/configs/am64x_evm_a53_defconfig
> @@ -70,6 +70,7 @@ CONFIG_CMD_DFU=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_REMOTEPROC=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_EFIDEBUG=y
>   CONFIG_CMD_TIME=y
> @@ -149,8 +150,9 @@ CONFIG_DM_REGULATOR=y
>   CONFIG_DM_REGULATOR_TPS65219=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
> +CONFIG_REMOTEPROC_TI_K3_M4F=y
> +CONFIG_REMOTEPROC_TI_K3_R5F=y

Would it work better to add these to the kconfig for AM64 so
other boards get this without needing to add to each defconfig?

Otherwise whole series looks fine to me,

Reviewed-by: Andrew Davis <afd@ti.com>

>   CONFIG_REMOTEPROC_TI_PRU=y
> -CONFIG_CMD_REMOTEPROC=y
>   CONFIG_RESET_TI_SCI=y
>   CONFIG_DM_RTC=y
>   CONFIG_RTC_EMULATION=y
