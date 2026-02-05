Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F31CFEC1EA4
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 11:52:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8A018341A;
	Thu,  5 Feb 2026 12:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GTJsViZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4333B83B1E; Thu,  5 Feb 2026 12:52:55 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5098382A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 12:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=insNL7oKqeh/bXG2iS3ZbrjXqwTOXlBdehkLwOP0DGoU30D7TflfiMirSGHMBPcA61UtMGh3t8ud7CCDW9I6NcCdGH4RYXZ6toR5Zi0VwVv/gKIquTekWYB9YUeq+UmYVlCGj/CrY2sYEGhE0h7uVPgXrEtaERHvTVRC/lX1136OEGs9O/3im/Gn8WlmV54Uqt/lAiB2bsMquDRpPr9EHL/ofWbWZkCBE6EursUqJ4gs5UbcOuW9KjbjFKUeFHT1CufroNbH3TUMALl8Z5aTmBnU/FUM+SSsfifSPoMbVrudjnYZKTdSxsttpfgB4KbWqgR3zx0B2oFpEgJzNUj1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ7565GN5YyJSfg6iRCefhJW3xyrWziAb+Hs8QXvSoI=;
 b=U8vZb8nBMv2HHTRid4kuo6zxwfEN81nq5ex94E+KurhG1VOLxG69fXHQ9fMY2CH/eBk7qqrzH+UVxG2CWDjY1sLwxNVoMABxWHmP2lwYGIuI/sJEdEXlxiC1yDrEBd8OY/KCmhLUj1/s5gHhuJ8Pi8Jl3bUZWgUbq9jOAZgmiyszdohe49gvxTuNTk+kv1lCA+ELrzILLHkCvMQT2owRYUK5/Rr3RbnBNtI3zVfUAFaASw3E+rmsG8HQ8WPABCW88CyQ3XQv8XOe51Bi75mawGojLoB33XoCqBLerprLKgnqgJueIiK91DLvg/samEfXr0UBix9GNn5C6xNHzcs6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ7565GN5YyJSfg6iRCefhJW3xyrWziAb+Hs8QXvSoI=;
 b=GTJsViZMiyxqU7AyQ0egiOaHzXLO2hlCiBsbzxiwDvG0oKCSGpHMwFE/dpggKwohoLkU/g8w/ht7BdC7v0jSpyVorrg3aZjjPN7u6jt1ptnHW4ETx8GAOOxmE4rj0B2qwruKgoZHgxZEDVctKmiac/W/BozMv4AXOFFV+YLi1T8=
Received: from MN2PR08CA0014.namprd08.prod.outlook.com (2603:10b6:208:239::19)
 by LV0PR10MB997564.namprd10.prod.outlook.com (2603:10b6:408:344::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Thu, 5 Feb
 2026 11:52:45 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::5d) by MN2PR08CA0014.outlook.office365.com
 (2603:10b6:208:239::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Thu,
 5 Feb 2026 11:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 11:52:44 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 05:52:44 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 05:52:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 05:52:43 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 615Bqg182936940;
 Thu, 5 Feb 2026 05:52:43 -0600
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 5 Feb 2026 17:22:42 +0530
Message-ID: <DG709O3VZYP3.36G3YDA35CVXG@ti.com>
Subject: Re: [PATCH v2] mtd: spi-nor: ids: Add support for Puyasemi flash chips
From: Anshul Dalal <anshuld@ti.com>
To: Ssunk <ssunkkan@gmail.com>, Anshul Dalal <anshuld@ti.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260204140020.5769-1-ssunkkan@gmail.com>
In-Reply-To: <20260204140020.5769-1-ssunkkan@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|LV0PR10MB997564:EE_
X-MS-Office365-Filtering-Correlation-Id: 10534335-f404-405a-f8ef-08de64ad1334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUZyaVd4SlJHdUhId1VkbEdPNjM4VG1SbWROb2RqUlo3LzlONUtya3RsK1ZS?=
 =?utf-8?B?eUJxc0FoMjIzK2toaExYbzdOL1IyZ09rNGMyZjk4em9ZQktvVE5xWndobWNH?=
 =?utf-8?B?Ym5pcGVUMnM5dCtvOWRCTFh1QmlaVFVVZGtsNUFrR2RDeDJnMEMrcUZCcHBl?=
 =?utf-8?B?NytPMzkvVVB5Z0FWYm01SFc3UmFEMHdEcTlncEJKdGhsV05uT094QVVEU0U5?=
 =?utf-8?B?RFBFcEZHQXhFbmdSODhSSHZJcGNBck5OelZGNWVPRitpUjNOb2pyeEtqREIv?=
 =?utf-8?B?ei9WUkxrVHdQTC9SVWpSazh4VXVJQTlZZWg4cTJFQ2M4NXFhR2pkbmI0clM4?=
 =?utf-8?B?SUZLbFJYRXBLaHBCczg1QUxBaUNnL2l4dDYwTzVzMW00S0JIOU1xcjJndm92?=
 =?utf-8?B?SkNDcVNhYk5Gc3p3aUJTWngvRThmaUtuVWZ2dDFjVnFuOXNoOGdtdTFGSkVS?=
 =?utf-8?B?bkZPOHlPODRyZXJuWDBGQUFhaldaUUlkeVhuTEVVbTZXUG1uNW5xMG1PQVd4?=
 =?utf-8?B?UmxBSERRYnEzdk5lRVFodW5pVFBCdmZSREczbTVUMVJHUG9JV1ZxTldwTFk4?=
 =?utf-8?B?QzRCVXJpUWxpWFhxVC9BMURHSW1May9sblBnREhQQ1R2RTNWSmZidHJzSWtu?=
 =?utf-8?B?MjYyL0t2MFl5eHUrUEZEdDAzNjhVd0ErVDNHbSt0RjFXZ2YvQ0NhYWg3MFZZ?=
 =?utf-8?B?bWpxNFdmQ2xWU2h6M3FuWW9qcnJKK1lpUU5sYWFhQ0NpK2xVUXBzSGw0NEg2?=
 =?utf-8?B?SkFFOHpZY2xZMU9TQzIrNUdiODhFSkRmVTVsVWozb2RRL3hDc2xEUk1uN21o?=
 =?utf-8?B?NU9mQTA0OUVVaUZLeVY5N1BPSVBKUkhSQzNUM0hEOFppMWRkaU1ua0YxSG1s?=
 =?utf-8?B?VjJ3a3o0RDNDNDdPMWN6YVlONU1kY1VTbEszQ3lObEhiUFFONjdVak1TWHJn?=
 =?utf-8?B?VGFEZmRQcjBwTWpRZFU4NHhKRGEvaFNIQ1V2dm5YRkp1STBsSHgyU3pMSGRZ?=
 =?utf-8?B?SWEycWkvMVQxTkxWa1pBQTBNSVJJZTZGSFNKNWVUVTdhL2ZQRDJIcjdZYkRl?=
 =?utf-8?B?cVhYWFBWcGVpZkxyazd4S0JWK3czODVMU0owQUN4K0hab3BUdFR1MHRpeWVy?=
 =?utf-8?B?eFp5alBNRm1GQ2ZIN3NidkpBR0FMOGMvZ0FoMWJQbkxTNmRVMU0zcitqVDhy?=
 =?utf-8?B?Tkx4SUZxdG5icHZoVStQdi9sb2wvOUlrODRqTm1nVU13OFhpUFNPN0VoMS9E?=
 =?utf-8?B?M0l6dDZQcGdNNHhuYXVyNlVjTjdiODdnbGZrVzZJczBWa1BIeElyY0F3SmpI?=
 =?utf-8?B?U2tLY0JCTGNlU0VOZlJieGZPa1ZlcWlUQVhUc2ZJUDg2eVhhbWNlNTN2OWs1?=
 =?utf-8?B?RUY5RW1iNE1aTXJsOUlDemFLb2hoUUhFS0xzOUVuYm9tV3Y0SitwZlJvMzBs?=
 =?utf-8?B?SHZYem9DS0pqUXljY1RNZHhQZ0FNY3dmMFBuYUdQM1RyM3c1ckFrem9yak80?=
 =?utf-8?B?c3RETEJDam9RTm5FOVR4ajZ1akFRaEphSjNja2lOSUtUeU9IT0kwLzRYRmVL?=
 =?utf-8?B?RkMwSGlJSkhlRWdMUXdzTXV2TzI0RnJXYlFnb3RoaDhRbjFvSEk3MWRjOGNT?=
 =?utf-8?B?WnRjRURGRzI0RUR0eXhNWWgzNW5lT0hKYkRBTnFKNktheERLWDgwV2svN3NY?=
 =?utf-8?B?ZWQ4STA0YU9oQkM5cHFNb0gzSHNGYnlvdlZhZWYrVHBiQmQzN3RNWklEYndS?=
 =?utf-8?B?WGRndzNLS3ZSd2Q1RVJITHp6SWZvWUc2aE95eWF3ZHpnOTA5dVk1eWlyYkhr?=
 =?utf-8?B?Q1VCV2V3Q1VBY3RrZEhwSnlpVzQ2L3lSbEViNnI2czdXMWd1OEVMRWRqVEFv?=
 =?utf-8?B?VCtCN25GSzgvM2Rtb0JTVUZtUVBUTW5BdHlybGo3dU1LNjZrelgyYVBkbzYx?=
 =?utf-8?B?azRXL1h5TGxZWkNWQkw1TTk0cG1LRnJUcTZqZTBhdkE3YUZFNzdTUmhzMCtX?=
 =?utf-8?B?VEZXejAvZFFZaStacjVtWjNGV2wwYzJta3lVRFZMZUR6OFljeU56M0hIcXlS?=
 =?utf-8?B?ZnJTOGFXdlY2SUFwdmtwM2QwWkVXZGRhWldGSkZaZUdtSWpHUFZJZkR6cHF4?=
 =?utf-8?B?RVI3RjhDUS90aHNZL2drWW0xYWxuaWlsK2ptRWlJc1U0dE9PbHZTWjVEdFF1?=
 =?utf-8?B?eEE9PQ==?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QK3U6LZBdnKCNqcuQnPHka/L1GEf8qlyfg3CgkfdHf0y+xIhm5eWPnMUOjdo3HU1nBL3Ihzowyp+gi1fuI30B54x59TtheSlgoh1mnQ4y2v/0vOTJhWJeBdzzwcdaETA7LBrw7u5An+NP9snD2FoqTEqqSrMqd/97lv+tZyEWVPdzxgTD/BOBhQvS7706mbVflFxTRjoxC23EQTST/ddeYN+2AngREKLF+duukLxSeqQ0uOy06HQbEWUai//oYTyWwchYC6mh6Nrn7IaBPXU3krBhgXbrJFz3abtFL2lriQbA2hqe+9zpdB5e5FJgBC9oJ1AVGs6htvN4ruvMaUmAI7ILe3OlfAr5GDgNo/QyQ+Z4uzM8ldyysZ7K2jNYAifcKgm9rzIK30iQ4pRh8QNDuMwmUUEw2nohVWN6k9pR8QXPR6pIJwjNuylKzSQbZWz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 11:52:44.6322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10534335-f404-405a-f8ef-08de64ad1334
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997564
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

On Wed Feb 4, 2026 at 7:30 PM IST, Ssunk wrote:
> Add JEDEC IDs for Puyasemi PY25F512HB, PY25F01GHB, PY25F512LC,
> and PY25F01GLC flash parts.
>
> Datasheets:
> PY25F512HB:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%=
8C/Flash%20%E8%8A%AF%E7%89%87/PY25F512HB_Datasheet_V1.2.pdf
> PY25F01GHB:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%=
8C/Flash/PY25F01GHB_Datasheet_V1.1.pdf
> PY25F512LC:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%=
8C/Flash/PY25F512LC_Datasheet_V1.3.pdf
> PY25F01GLC
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%=
8C/Flash%20%E8%8A%AF%E7%89%87/PY25F01GLC_Datasheet_V1.0.pdf

Nit: Missing colon ':'

Otherwise the patch looks good to me,
Reviewed-by: Anshul Dalal <anshuld@ti.com>

>
> Changes in v2:
> - Rebased on latest master.
> - Dropped new CONFIG_SPI_FLASH_PUYASEMI and used existing CONFIG_SPI_FLAS=
H_PUYA
>   as suggested by Anshul Dalal.
> - Added links to datasheets.
>
> Signed-off-by: Ssunk <ssunkkan@gmail.com>
> ---
>  drivers/mtd/spi/spi-nor-ids.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.=
c
> index b6a07fa9063..fb8a1972299 100644
> --- a/drivers/mtd/spi/spi-nor-ids.c
> +++ b/drivers/mtd/spi/spi-nor-ids.c
> @@ -323,6 +323,18 @@ const struct flash_info spi_nor_ids[] =3D {
>  	{ INFO
>  	 ("p25q128h", 0x856018, 0, 64 * 1024, 256,
>  	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> +	{ INFO
> +	 ("py25f512hb", 0x85231a, 0, 64 * 1024, 1024,
> +	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)=
 },
> +	{ INFO
> +	 ("py25f01ghb", 0x85231b, 0, 64 * 1024, 2048,
> +	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)=
 },
> +	{ INFO
> +	 ("py25f512lc", 0x85631a, 0, 64 * 1024, 1024,
> +	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)=
 },
> +	{ INFO
> +	 ("py25f01glc", 0x85631b, 0, 64 * 1024, 2048,
> +	  SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES)=
 },
>  #endif
> =20
>  #ifdef CONFIG_SPI_FLASH_SILICONKAISER

