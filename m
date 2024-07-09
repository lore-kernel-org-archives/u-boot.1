Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1B4C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 07:37:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D37E883C3;
	Tue,  9 Jul 2024 09:37:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="eMeBVGhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A841884CC; Tue,  9 Jul 2024 09:37:11 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B18883AF
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 09:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720510628; x=1723102628;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VWYc1yuZkCpT9nYn/QMjobJ3aMiDgVLR3XyJ98WuDkI=;
 b=eMeBVGhshk+Nprj5Iem5GnVe+7H65dzCIuKw5C65ipF5hmW9ZHREBrr6rOUhIEeJ
 F3qsjdAiOhIbhzSyZZqE5OV5pImNReB1qOjoiq/WjOditpcGboHp6imtIv6Wzfoo
 oygUBx4TsSxOH1y5Ju6TgfWmWn4EHHkKldkTXNcfHms=;
X-AuditID: ac14000a-03251700000021bc-d1-668ce8a4f898
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9F.57.08636.4A8EC866;
 Tue,  9 Jul 2024 09:37:08 +0200 (CEST)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 9 Jul 2024
 09:37:07 +0200
Message-ID: <ddd54c7c-685b-417e-988c-e548d19df666@phytec.de>
Date: Tue, 9 Jul 2024 09:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] configs: phycore_am62x_a53: Add more commands
To: Daniel Schultz <d.schultz@phytec.de>, <u-boot@lists.denx.de>,
 <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <d-gole@ti.com>, <mkorpershoek@baylibre.com>,
 <nm@ti.com>
References: <20240701062050.1475249-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20240701062050.1475249-1-d.schultz@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWyRpKBR3fJi540g9WLDC1a1npYvDg2l93i
 zY+zTBZTJ21mt3i7t5PdovudugObx/sbrewerw6sYvc4e2cHo0d/dwurx/Eb25kCWKO4bFJS
 czLLUov07RK4Mpb9Dy/Yzl3R3rSCrYHxMGcXIyeHhICJROPaR2xdjFwcQgJLmCR2rdrGDOHc
 YZToOLaWBaSKV8BG4vHil4wgNouAisSeK/9YIeKCEidnPgGrERWQl7h/awY7iC0s4CZxrmcX
 WL2IQJzEul2vmUBsZoFQiU0b+sBqhASsJK7tuM8OEReXuPVkPlgNm4C6xJ0N38DmcwpYS0y+
 dZsVosZCYvGbg1D18hLb385hhpgjL/Hi0nIWiG/kJaade80MYYdKbP2ynWkCo/AsJKfOQrJu
 FpKxs5CMXcDIsopRKDczOTu1KDNbryCjsiQ1WS8ldRMjKGZEGLh2MPbN8TjEyMTBeIhRgoNZ
 SYR3/o3uNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2M
 PB2LJxwO/t/i80/p9KqnjsGLDjWZVq3v4ov9evV6rMKFbeZ9YRVMBuefclee9n+3JKROP7Sv
 S/e++NlDK4SUTNc27A13vC033d3uVOkZ7bjeeS2Zlgbrm26Ei3/SYwkojRLYxXr67bb0Pe2i
 MZW+Qor/fkrM4d52nHPCtKu3VLNby7ccmnZciaU4I9FQi7moOBEA5mvQyYcCAAA=
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



Am 01.07.24 um 08:20 schrieb Daniel Schultz:
> Add i2c and rtc commands with all dependencies which are
> required for testing.
> 
> Additionally, add smc and cache commands to boot Zephyr on the A53.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>

For this series,

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore_am62x_a53_defconfig | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
> index 56302383c0f..06b8834e074 100644
> --- a/configs/phycore_am62x_a53_defconfig
> +++ b/configs/phycore_am62x_a53_defconfig
> @@ -1,4 +1,5 @@
>   CONFIG_ARM=y
> +CONFIG_ARM_SMCCC=y
>   CONFIG_ARCH_K3=y
>   CONFIG_SYS_MALLOC_LEN=0x2000000
>   CONFIG_SYS_MALLOC_F_LEN=0x8000
> @@ -63,9 +64,13 @@ CONFIG_SPL_SPI_LOAD=y
>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
>   CONFIG_SPL_YMODEM_SUPPORT=y
>   CONFIG_CMD_DFU=y
> +CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_USB=y
> +CONFIG_CMD_CACHE=y
> +CONFIG_CMD_RTC=y
> +CONFIG_CMD_SMC=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_SPL_OF_CONTROL=y
>   CONFIG_MULTI_DTB_FIT=y
> @@ -123,6 +128,8 @@ CONFIG_TI_SCI_POWER_DOMAIN=y
>   CONFIG_K3_SYSTEM_CONTROLLER=y
>   CONFIG_REMOTEPROC_TI_K3_ARM64=y
>   CONFIG_RESET_TI_SCI=y
> +CONFIG_DM_RTC=y
> +CONFIG_RTC_RV3028=y
>   CONFIG_DM_SERIAL=y
>   CONFIG_SOC_DEVICE=y
>   CONFIG_SOC_DEVICE_TI_K3=y
