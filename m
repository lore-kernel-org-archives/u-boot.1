Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D691BCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 17:23:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C8684704;
	Mon, 15 Jun 2026 19:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sfose+U1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DBB784869; Mon, 15 Jun 2026 19:23:08 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BCE3846CF
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 19:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ky0TrbwTh/4Abi0JWRVeHpol27yaQrCuVDsN0fiPEPteAGdYNt09hX+Nv9C4j7kewSTDeyW5TeaMywgD6N4F9445yDYCGEw8I4/eOZjBR3K+yxiqqtbjF+pIWVSOQXyzJ1oQiPHrS+QTx/mnZNHomwc+foqpSPKeTYTDbaj6Lj+GGh67Q7lP3e/6p+pKEijQNQ4veTWSI+/jGaRUz4wd0rk8IQnolZXRfHIncZJFBHdBZHZnCEFXHD85BmgLM7aQg2JJ2ZTbeWCUxRIxG8zEOBDC15iMIjZSdI7C7mIqPQVj4CDcBfZh2fvpKABXKJUm0Il8voouHFicVq2Bot/xuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZjadLv1B+rdOkCh5QkQXCP3xM9qgZdU1MBiQpusHVA=;
 b=I3vjf7+KoTiaOVEzWnpN0axEGgtpTpOeRQME280/TQ5kBh11lp/Kk2OHiBFEfUxUvMeCaCug65WZ+osK5uS0cFuN4Tnis6T0O4To+kmSMlUw0pedb90BJ0JihRft+3x+1xM8n3HQagAKtKjAXQHocIEfUbPnFwcfh1YArmFZhFnTcgoHzQAr3bNKNsCFa1XFjIQDVognOE6Z8opW2eNTQhJ0fBJdgxZz1dfkLdzOLY18gyKfHKQwFdIbFRTBcvaIOy/mvDTLzvci7A+Fz2y455Z+pzcgeNH4q5+fU6GE49LNu7m1cA1lE5BscA4IA/Bo4u5xu4VTnbsNbm6Ddc6XjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZjadLv1B+rdOkCh5QkQXCP3xM9qgZdU1MBiQpusHVA=;
 b=sfose+U1V2egJuhcLlf8ypRieMi7ucxots1KnKZyB5vPnAvVBaSLA6l+Fljkyca2N317PsLe9oiGGXlIAXXKDgSeGT7Rgtuc+4uJvvbF3JsPnGRBXcizUJNk/rChoy8wqN15Y4b+YU5t+fYHMhZqbD1g1L9ANTiYnUJb21vExq0=
Received: from DS7PR03CA0173.namprd03.prod.outlook.com (2603:10b6:5:3b2::28)
 by CHAPR10MB997699.namprd10.prod.outlook.com (2603:10b6:610:2f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Mon, 15 Jun
 2026 17:23:03 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::80) by DS7PR03CA0173.outlook.office365.com
 (2603:10b6:5:3b2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 17:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 17:23:02 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 12:22:58 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 15 Jun
 2026 12:22:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 15 Jun 2026 12:22:58 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65FHMtxc1803983;
 Mon, 15 Jun 2026 12:22:56 -0500
Message-ID: <f8f72ef2-84e5-450d-9c2c-884107c447df@ti.com>
Date: Mon, 15 Jun 2026 22:52:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] configs/j721e_{beaglebone64, evm}_defconfig: reduce
 fastboot buffer
To: Romain Naour <romain.naour@smile.fr>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <robertcnelson@gmail.com>, "Francis, Neha" <n-francis@ti.com>
References: <20260426135715.1395250-1-romain.naour@smile.fr>
 <80bc6c13-ba45-4df3-b226-fb86e520cdad@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <80bc6c13-ba45-4df3-b226-fb86e520cdad@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|CHAPR10MB997699:EE_
X-MS-Office365-Filtering-Correlation-Id: c2db6cee-ab18-4b0c-2ac8-08decb02c127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1QsMJVaKUVMIZuQpxub385OvkIulCeqaoPj/uD6T4b/wbuupn3pbLU4bJXIcfsA1r49ThiEC0yCVJ+VLA6BTRMbD3TXEwbUYpO8XsyGa3tlmgXGRs2ajSJcQn6DJGjLGPQKANQjRd9zBkWJyBNKWVmMcUSSHZHSnv2+lCwPP1ZQJG+AhhM5lIV3l+qmfnEIN0Gp2gHRVEm5L/M5u3vckDOdBIyiR2t8VTjRFg5c+VJEaSa2s/PhWEhTrTtvSlej29ZV87Ofb08WJ8wgVzSSRz4n+TpXQrPhv2azxkMFRGWOg0YVOhRKA5gK9+iTe0MXB52/7nUrTUFcT5KgDnXKY7/kEuDXB0JPyHDxGRFU6hOWO8uX83sl1kMDjkYTwGggXe9HFQ7NU3FCglyq5WRlOe+OQbOGkHky8UyhcDsqVcWTmjcNkbvb6SZqtEjXoK8B2Wg6tRQD1A9j+aruH0iGwnjuXJOBb1hRv+OJMJRGbHUkTF8QZ9SYn2QlV+M0gKtYAVwDK2D3uPcdeKIwgnkvKnhDwFGmfUVIJKWxDER9TxIz6ksTENGmQGpzmlgJuUcync7NEv4ZcUjJ92GtegP4lGUzJ1L+r2P2HVhbTigc0sGFUYuqtAncOK+XY7yh9cgvzKejzwWi68h/ul7ARWJGNhidGr6v4uz17cTTq+TLawc50AUjyil1JdZSErIENfjzD5gX1ar2WgXFe0AMPLwSL/fqGJpjzLVy/3tH6F0TWRXw=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m7pO3vVzxMogrgMkjv2b/G//1YBo+lQZrbIpOZQ5DCWW3qufJr1imE/2YyLqgC5jgxF7TH9cul3OU2hRjVzrVn4MCrFr1h211VVSqhHqidesMLTOSj4r3c3tR1fYf5WQH5tTVAlYEsN0GgxHUzINpTjKHFZYh7nfbPBFDkQ8cDsN3KtuEF83W+9R+rZ+ZKQGKJ8cVaFmQs2OLQIlDZSJbVGFcOJAZzfqXjBAkwY+zKie+Ap1h4+3isevCW6ISSHNgz0Vvxppv3EBUk6wE6pxOxwmtjAH7xxSZLRMykf+Eqe4q6pg5EgqImnLAYOgLwnGjo6w1I3iHnRv94mrcbSiOzNwbWfCfk+7pg4USEqxhHs3aOchcLMTMObzfYuAU9euZ7j1Z9aWYRLGfIeXNvF52Ahf8CDPz+s9QqZbHBA06Vl9G380Fqt24gdOxhtgXe9G
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:23:02.3304 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db6cee-ab18-4b0c-2ac8-08decb02c127
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR10MB997699
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



On 6/15/2026 10:49 PM, Kumar, Udit wrote:
> 
> 
> On 4/26/2026 7:27 PM, Romain Naour wrote:
>> Using Snagboot's Snagflash tool to flash the SD card using
>> fastboot-uboot mode on SK-TDA4VM crash u-boot.
>>
>> Flashing an image.wic.xz file generated by Yocto doesn't work as
>> expected:
>>
>> 2026-04-25 16:46:21,134 [INFO] flashed 267296768/267296768 bytes
>> 2026-04-25 16:46:21,162 [INFO] Flashing sparse range 10/13
>> 2026-04-25 16:46:21,163 [INFO] Flashing to MMC device...
>>
>> On the the chunk is bigger that previous one and doesn't fit in the RAM
[..]
>>  CONFIG_FASTBOOT_BUF_ADDR=0x82000000
>> -CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
>> +CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
> 
> What you think to move CONFIG_FASTBOOT_BUF_SIZE to upper memory, similar
> to  configs/j722s_evm_a53_defconfig
> 

Sorry for typo its CONFIG_FASTBOOT_BUF_ADDR

> 
>>  CONFIG_FASTBOOT_FLASH=y
>>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
>> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
>> index ed94fff0885..dac1c5ec82f 100644
>> --- a/configs/j721e_evm_a72_defconfig
>> +++ b/configs/j721e_evm_a72_defconfig
>> @@ -104,7 +104,7 @@ CONFIG_DMA_CHANNELS=y
>>  CONFIG_TI_K3_NAVSS_UDMA=y
>>  CONFIG_USB_FUNCTION_FASTBOOT=y
>>  CONFIG_FASTBOOT_BUF_ADDR=0x82000000
>> -CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
>> +CONFIG_FASTBOOT_BUF_SIZE=0x1c800000
>>  CONFIG_FASTBOOT_FLASH=y
>>  CONFIG_FASTBOOT_FLASH_MMC_DEV=0
>>  CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
> 

