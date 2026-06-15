Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C56CD98DA
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 17:19:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E483846A4;
	Mon, 15 Jun 2026 19:19:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="m+teEbRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32D1B846B0; Mon, 15 Jun 2026 19:19:27 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2AA84105
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 19:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQP5gqZxclGb8UYgwpk6SyWBIPxvc9LbS0h0d0EhWILfns3BmkjShjKQl219ogdxkfNBaO+KF7Z7iUnBNRHLI5G8mRtGz2htZLKe8Hh89u110C0fwYxrT1t+8PBno61P7swrjdFfWIziXUVX1YQa2v23UInhO2klwZtRrTCdLYFLpxm57lpaI/iCt85c2MB1zAoTJlsTXOU8H97RkMtg3QaP09K0xasbT9ovpXLk32pSAgdFsJkNJYnDiveYfEo1HqH0eTkijb1qCzDYFI5V5W1ynJ1IFGFJCnKPodqptdBddyJwdnQJmjOyoNDj60RFchXeUN8ndJIHTGSZt3Jw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW48K1fiFffukVNBldmCD+kQjlgBAkHDDzXReYO//lo=;
 b=NSl4xozQbRqdpHRHEl/YmexhkpwZQ7R1n613Vln3sIhsJccvn7HzrqmPBjWzXzq9ubz+GfLD/R4NtS4Hhtxw+ww//RCkg7rqu+4hABWaU5N79Sd2z0wvsx0s/N4CR+E7CVDrTOiLwzQitFooMi3il6dLD8U5kTCLWroYW15c/y1i5eaQN57mc6si/Qm6G0jZAgxgWzFRs8ldt5Euzs++dcJoBMBnKZmHfOn/YmTGANfKUVTqpXtaa5+i+8bH4PcwEvh5VsrvBT1EhhIyTc4dmpLy+yyfxJYZ/2Z3ji1KzczQD8aBQjDmQoYt91ECL4YsEx8oOLN9TsrpLJ1O9ULWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW48K1fiFffukVNBldmCD+kQjlgBAkHDDzXReYO//lo=;
 b=m+teEbRdo0iYiCn6T8/p1a3Ue5hf75NE0J2zVLIuNeK/70of1Lvvdyvzl0ZmW0cHMpQAOFQuYfLgU0cb40pC9GXp7x7lsiN6kj8S+LauxucOA+5ZjW1F/lrDLMn9F6IWEpwbunl205pWByaVBgVxMpZ/8ANAsgEFTTeWn2x6xiY=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by PH3PPF2A078470E.namprd10.prod.outlook.com (2603:10b6:518:1::791)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:19:20 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:33e:cafe::6c) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 17:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 17:19:18 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 12:19:17 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 12:19:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 15 Jun 2026 12:19:17 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65FHJETV1798996;
 Mon, 15 Jun 2026 12:19:15 -0500
Message-ID: <80bc6c13-ba45-4df3-b226-fb86e520cdad@ti.com>
Date: Mon, 15 Jun 2026 22:49:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs/j721e_{beaglebone64, evm}_defconfig: reduce
 fastboot buffer
To: Romain Naour <romain.naour@smile.fr>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <robertcnelson@gmail.com>, <u-kumar1@ti.com>, "Francis, Neha"
 <n-francis@ti.com>
References: <20260426135715.1395250-1-romain.naour@smile.fr>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260426135715.1395250-1-romain.naour@smile.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|PH3PPF2A078470E:EE_
X-MS-Office365-Filtering-Correlation-Id: d8772a8d-4a18-400b-85cb-08decb023b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 2wcDVnOv5xl372xGsRYq1HsMRMTM3pf3lyFvCbseB4jESb8BbsQTGBgBxWXep+UxIVhkNW3b+l6DYRWYTb218NNF+vR4331aVLjDALivwRaWPLhwvM6h7MFFpk29JxvVhfB6SLTlxTPeJO4eU28zEqc+UkQYKVAd7flEHa87bskSFVRc1dxq0yn7thV3bw2DGabROr6EfxlUycPwETGNmh7EbKa62Sr9rKmmBpUwIcIKdAruqUhjwzEJknz9kepd/BQL5EmQtVu7smjDUSoePIH9T7Spr0WWUX0L0BMJGijywud+tDCwvtTuQcRtCB6akXqSbr2Vk/OhNfU6/rf9o+iYyiAQRm9U7raHXO0DuBQgAag+kdzseRAu5Y7NXtpho/m/GoggUEUeg6JIq3dNLW85iYLXNq7gBNcmdYNNqWXD/84yTTs8mpRn7BOvqUC8mD6VhwaGR1vgBWELuTHH8SUpSYZDKKeb0h14kMmqZKnYzKt6vwTotr4Jq47hmd5OusHaGfnxA3QwHSTw4XMEJpqyZM9/9OuFKdLa6Za2vwcUMUmBC+ndC1xvSCiONOQsZPPKMSCHfwzS4AT+elZsPQ1B2ApG5MPU03uRd08lJlMuFBcA378zFBjmMrnh+86UtzIIcafX3OfblHcTID64uK23A7aUSbeqFM917MAYvegnoyQNZcxKT11g/ac2UAArbbmhKvD+pAuZFJMWETTGc+PW+4C2lCQcqavDc8w8JUU=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iZNFop42f47qmNhBVpQKU6N2gs1y36mDf/CdZTd76+0CTsggazlPwvf9lKzXcmmmHxXEeCCbgIdStTNe/SgrOnx3LDDfs9tuTmEaFQh26NV2ENyatIEsrNduL4toOwqNtNP48hMNrLeKtkn/dWb+bYi5yVNa13IAobLma44X1xpI8Jm0DretzAamguoTxXCqNK9D1/MAdLUtd5VP6LLMgo3pumoAsL8TScS4IjuY0fXaF9+nd2OL/nUOwCLafntY3LzqszOUtx5unIcdqhtHleky704Ap78yidJX1PKc3rvAKw6Xwn0XJPa7S0VSfZqaxpp586NtorNV/jqu6vIGHdDfxv/+p7OvBAY0IwJANMU+NARPamDaQ+/Ung5l889Zl9BU6lwPrQhdTp94nyfVBnoLouR4oGEwwgINvig3BmAeeqcFLOGv3OgnfH/DchyB
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:19:18.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8772a8d-4a18-400b-85cb-08decb023b92
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2A078470E
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



On 4/26/2026 7:27 PM, Romain Naour wrote:
> Using Snagboot's Snagflash tool to flash the SD card using
> fastboot-uboot mode on SK-TDA4VM crash u-boot.
> 
> Flashing an image.wic.xz file generated by Yocto doesn't work as
> expected:
> 
> 2026-04-25 16:46:21,134 [INFO] flashed 267296768/267296768 bytes
> 2026-04-25 16:46:21,162 [INFO] Flashing sparse range 10/13
> 2026-04-25 16:46:21,163 [INFO] Flashing to MMC device...
> 
> On the the chunk is bigger that previous one and doesn't fit in the RAM
> memory mapping set by the SoC (TDA4VM)
> 

Thanks for catching this.
Most of TI soc has optee at 0x9e800000 address, so this address should
not be used.

> downloading of 267296768 bytes finished
> MMC write: dev # 1, block # 2101440, count 522064 ... 522064 blocks written: OK
> switch to partitions #0, OK
> mmc1 is current device
> Starting download of 486944768 bytes
> 
> "Synchronous Abort" handler, esr 0x96000046, far 0x9e800000
> Indeed, this memory address (0x9e800000) is "reserved"
> 
> "bdinfo" allows to notice that 0x9e800000 address is actually
> "reserved":
> 
>   memory.count = 0x2
>   memory[0]      [0x80000000-0xffffffff], 0x80000000 bytes, flags: none
>   memory[1]      [0x880000000-0x8ffffffff], 0x80000000 bytes, flags: none
>   reserved.count = 0x4
>   reserved[0]    [0x9e800000-0xa8ffffff], 0xa800000 bytes, flags: no-map
>   reserved[1]    [0xaa000000-0xabbfffff], 0x1c00000 bytes, flags: no-map
>   reserved[2]    [0xfce40b30-0xffffffff], 0x31bf4d0 bytes, flags: no-overwrite
>   reserved[3]    [0x8ffff7000-0x8ffffffff], 0x9000 bytes, flags: no-notify, no-overwrite
> 
> CONFIG_FASTBOOT_BUF_SIZE was initialy set to 0x2F000000 in the u-boot
> configuration for the SK-TDA4VM.
> 
> With SYS_LOAD_ADDR set to 0x82000000, the end of the fastboot buffer is
> at 0xB1000000 and overlap the reserved region[0] and region[1].
> 
> In order to avoid writing the first reserved address (0x9e800000) we
> have to reduce CONFIG_FASTBOOT_BUF_SIZE to 0x1c800000.
> 
> On this platfrom 0x9e800000 is reserved since it's used for optee
> (K3_OPTEE_LOAD_ADDR).
> 
> (Issue initially reported on Snagboot)
> [1] https://github.com/bootlin/snagboot/issues/90
> 

Please have fixes tag

While at this, please do fix for below SOCs

configs/j7200_evm_a72_defconfig:CONFIG_FASTBOOT_BUF_ADDR=0x82000000
configs/j721s2_evm_a72_defconfig:CONFIG_FASTBOOT_BUF_ADDR=0x82000000



> Signed-off-by: Romain Naour <romain.naour@smile.fr>
> ---
>  configs/j721e_beagleboneai64_a72_defconfig | 2 +-
>  configs/j721e_evm_a72_defconfig            | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/j721e_beagleboneai64_a72_defconfig b/configs/j721e_beagleboneai64_a72_defconfig
> index dc76504eb83..abb53687ed6 100644
> --- a/configs/j721e_beagleboneai64_a72_defconfig
> +++ b/configs/j721e_beagleboneai64_a72_defconfig
> @@ -97,7 +97,7 @@ CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x82000000
> -CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x1c800000

What you think to move CONFIG_FASTBOOT_BUF_SIZE to upper memory, similar
to  configs/j722s_evm_a53_defconfig


>  CONFIG_FASTBOOT_FLASH=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
> index ed94fff0885..dac1c5ec82f 100644
> --- a/configs/j721e_evm_a72_defconfig
> +++ b/configs/j721e_evm_a72_defconfig
> @@ -104,7 +104,7 @@ CONFIG_DMA_CHANNELS=y
>  CONFIG_TI_K3_NAVSS_UDMA=y
>  CONFIG_USB_FUNCTION_FASTBOOT=y
>  CONFIG_FASTBOOT_BUF_ADDR=0x82000000
> -CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
> +CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
>  CONFIG_FASTBOOT_FLASH=y
>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y

