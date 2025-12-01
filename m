Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA0DD116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 16:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9E8482C7F;
	Mon,  1 Dec 2025 17:29:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YqWSMrVk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A145883B8C; Mon,  1 Dec 2025 17:29:50 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C3E809A5
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 17:29:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=db4MAdbU0J2moaJgDQo5vA8NfDmq3EFKP4ImS0x3g5nYOFQBNNFNv3EMQkUA6RnYloVyaC/epdj/VsaaKjEjqEBS+yjlFt/G6OKdtryqI2jVFCDOTRbb3kURnCM5LusQTppmN9VIYfMR7cQcaSOd3ar8ez0zzoTqvYGLZZxcPRuNDBMHxAQEgFoNYi1d/vUYFEds36dTP3YbvYpDW6VmTfTnR0oSBi4A0UxX2fWcB9Axv0yeLIZEgnqJx2i1qtREzQPTsMQZ2j1GfZ6mIDtSOkKnEtYrms1Iyz8Y/4XYxXjveN6j/VK6tKg5Urjz0v+PspvxCZqpzCEErUSzBDGKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAXynCO5K/yNHZQNco5FrvCPK6tHSygQcv3UBTRU4iQ=;
 b=xVOhEtxZjVpObIWJ2hTlbrW04dnL53OXPyZdJk3tfPgDHrgwsKEdMLVwq5IPwFtwDG81qEuCxqvK/e/7rgOZypX4JZYzeLxbFEehEYgMj81+dRzDe8omgeYQY01V2D6KHgElq6Zf/QbDgu14MjJENDaPIw2yl56fbP0K7RLr/Ox1I3hjw1EKO5kyGUcuYFx026dDA6j7o5mMchagujDMBTXo2EDc+vydp4ZfpmJ9XpQmBzRXSsrbMCMJtrJW+IUtQy1RCprOqyBlEpZOPjLT6uWdsNk7FHH+86ranY1Mt9EnAf7vDy/mnrLBgGy+F79QzsjU3h4PHyZueXY8ymokew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAXynCO5K/yNHZQNco5FrvCPK6tHSygQcv3UBTRU4iQ=;
 b=YqWSMrVkqxvS8ux4w2+L0TAwedlH11Ca22tOARW6+Zu09yHjNw6yexn81ccXhXKGcUu0L2PHP2bIGQ6ePCbZCpdWvQqeGnj356bkFPwjQPBKSutJwVLr/QV2zGbpj5PR/YJtAdGN1clAQiMgGJbrrMn14Ii9WNwIJ+Gik22L/xQ=
Received: from CH2PR16CA0018.namprd16.prod.outlook.com (2603:10b6:610:50::28)
 by DM6PR10MB4297.namprd10.prod.outlook.com (2603:10b6:5:210::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:29:42 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::26) by CH2PR16CA0018.outlook.office365.com
 (2603:10b6:610:50::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 16:29:41 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:29:39 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 10:29:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 10:29:38 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1GTWo7740226;
 Mon, 1 Dec 2025 10:29:33 -0600
Message-ID: <954b96da-e01e-4759-905f-4780419680dc@ti.com>
Date: Mon, 1 Dec 2025 21:59:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] configs: am69_sk_r5_defconfig: Disable PCIe boot
 configs
To: Hrushikesh Salunke <h-salunke@ti.com>, <trini@konsulko.com>,
 <a-nandan@ti.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <j-keerthy@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <jm@ti.com>, <anshuld@ti.com>, <s-vadapalli@ti.com>, <ahalaney@redhat.com>,
 <semen.protsenko@linaro.org>, <mkorpershoek@kernel.org>
CC: <u-boot@lists.denx.de>, <danishanwar@ti.com>
References: <20251201110103.845413-1-h-salunke@ti.com>
 <20251201110103.845413-7-h-salunke@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251201110103.845413-7-h-salunke@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DM6PR10MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: 75637ec9-efef-4154-641c-08de30f6d443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aklXSmlXRzdaS3hmaDJzTHc2ellXMW1Ec3JpbWo3OEFmL1VFZnhIT2JDWVBL?=
 =?utf-8?B?TG03WWo5R2NGdm5nbnBhNThCZWMxYlU4NDROdXhMRTloQmhkeHdtSDIvc1lm?=
 =?utf-8?B?ekxsbFNZZm8yWlZxNnBnZmc0UzlOZU1Xa1NoTlAvMkdKMzNJK0Jxdjl0NkpB?=
 =?utf-8?B?R0RWMU5LQVM2cEVFUGZ6aVRHY2Z4YzVWcDRDemkvN0NOaXJlQ2ZBT3hRYURi?=
 =?utf-8?B?M0YxYnhJU29qZ1RESmhmRFVtWVo1VHVEcXhzaVNZS2R2ekhHMkluV0VROU1C?=
 =?utf-8?B?ZlBpZHB5anA0NkFvOUZTOGo4U21jRkZvUm5FSDJ2QmVHY21zZC9JRkgvNWRa?=
 =?utf-8?B?ZW9ENWVIT1A3TDg5T0RyZVBuckVKVzRZZEw5YjdRV1FNdUI5M3hrM2lnWG56?=
 =?utf-8?B?dGZETk94bDZHT084Y0l0T1pIc3Nyd01DMkJyMDVSUythS0JsWjA2VGhISyt6?=
 =?utf-8?B?LytyVHBoTnY3eTV5SGt6RVVQaWNOcHZ1ZTBzVnR4MmxacUQvZTAzNTh6M1ZI?=
 =?utf-8?B?OWhsZXNRSGxxUDBwSUJkRHVnTEtuRDlIcTQ0RklSQUVqa0V6dTJ0MGlBWDBU?=
 =?utf-8?B?SlN3TDJicU5IckdTS0pnY2pCenlybVM3d3lGNFh1clNJc00wSVVsdDhvSFhJ?=
 =?utf-8?B?cXFJakEvdEVIOWxacmJKSk9mK0RpWWZLeG9UcnNqeVNxVG9tVjFaOWgrU3M2?=
 =?utf-8?B?Z2d1TlBUVGUrWGM1bjJ5Tk8rWkRUZFdVV2Rwa0wyc1dCbXpaQjcwWUQvMTFY?=
 =?utf-8?B?QUNZYi80V0hrUkdna0FqaHVvR2RzdUc5d2pwMkdLSU5BeFkwcGNzNTZDNDR6?=
 =?utf-8?B?cTB5emMxRkZZUDRsdm5aTldnUldNbkxlRWZNWnhIME12QkVHYTdnV1djbm93?=
 =?utf-8?B?MU5GZWNMOVMwR0d1YzMzSExDKytvd010VnpIemphTnBGSXl0NENSQkY3RjBK?=
 =?utf-8?B?U3IwMnhHTEl3Ykt0VkY5cUVwZEJZZnc5U3NMSnl1c0xvSGZ2anZEbTY3Q2pp?=
 =?utf-8?B?b01jVy9Rb0pSd2xwVEtTYVlTYUJMMURHMjFld2UwTkFtdHBUZi8yR1hpaGVW?=
 =?utf-8?B?N0VvbTk2ei9yLzlqUDRqUDRTaXk1bWkwVHY5enF3ODF2aUlkUWxkT3lSMHFz?=
 =?utf-8?B?cHBJU3UwYWdOMTluVTNCS0l4OXZhYzZ5eVlwQzhRdXRDNHpDbTd6d3p6SmdW?=
 =?utf-8?B?ZzFociswc1NUM0lDdjB2RkhFU3VYcTRZckFZTEZPTjJqdWxoMm1ickFCaUJV?=
 =?utf-8?B?TEtNSGttb0hOQk43bU5jR2krcGhwMlpCZWpTaCttSStFOThDeFF2Smp4WWhx?=
 =?utf-8?B?dHcwWG9lcXlpa3NYQjJjcGZEN0FYaVVUWmptK09CSGhBZkJ1a0E0dEJqd0tM?=
 =?utf-8?B?bnZMYkNTV2MwWUZzK2Y5S0JJcGNDcXZlTUdINFAzalk1aWtUUmt5S0VqUnRt?=
 =?utf-8?B?cVhRblN4djhpWEwxdm5mdzgwcGxaY3FBNFF6c1NMbnZtamlFMHVDcmEwQkZ1?=
 =?utf-8?B?RCt6YjZXT0cvMkY1UG9MNmlDcW01MitzZHUwa2tnbUdkd284UGlKcGdpR1R1?=
 =?utf-8?B?aXBSQkhzTG9Bd3Y1Wnd1a1FBZVlXUi9rOG1aRFBsczdJcGtqSTBoQ2tneXJV?=
 =?utf-8?B?aTlHOFdndG03VWFpS0FDNHd2S3Z4OWhKcTdnbmZqejBiTFVaVUYzS0lCTlpi?=
 =?utf-8?B?LzlEc0hmUUZXQnd1U3h6Ukl2N1BOK3luL1NyMzN2czRYVktydlBwK1lYbzQ3?=
 =?utf-8?B?ZFlDQ1lMWkpMV3E0d3UrSjVsL0hMaFl3WFdVRndPUGJXMWs4L1VkdzhEWS9O?=
 =?utf-8?B?VDg4WE9SZ0tRdGVxVXMvVkQrYjYvS1FHdHNWQzZBalBVK3Z4Ymc1ZkNLS1Bk?=
 =?utf-8?B?Ti83aDZaRWtJUWZlV25kbVEzeFUyVXBTemFGaEYrdUtLV0tTTHFnZVZ6QXls?=
 =?utf-8?B?eldLbzZzaVBVamlKVEJKVjFmYlFpeENSSERKR2RSYlhHNnZUblJBUEttWE5Y?=
 =?utf-8?B?cVIySno3dW12S3NaN1dadGs0aUt4U29ueG5MNUludGRtc3Jvb0pkdUFYdGNQ?=
 =?utf-8?B?dFRMVDFoRnAxVlZMcmptS0VYeWtzM3hyb0hTc2lNQ1lKOHhnMWZEQys5dTcy?=
 =?utf-8?Q?Kq1U=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:29:41.3799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75637ec9-efef-4154-641c-08de30f6d443
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4297
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


On 12/1/2025 4:30 PM, Hrushikesh Salunke wrote:
> AM69 SK does not support PCIe boot. Disable PCI boot related
> configurations that are not applicable.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> ---
>   configs/am69_sk_r5_defconfig | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/configs/am69_sk_r5_defconfig b/configs/am69_sk_r5_defconfig
> index 2186b9a0490..385fd999d30 100644
> --- a/configs/am69_sk_r5_defconfig
> +++ b/configs/am69_sk_r5_defconfig
> @@ -5,6 +5,15 @@ CONFIG_ARCH_K3=y
>   CONFIG_SOC_K3_J784S4=y
>   CONFIG_TARGET_J784S4_R5_EVM=y
>   
> +CONFIG_MULTIPLEXER=n
> +CONFIG_SPL_MUX_MMIO=n
> +CONFIG_SPL_PCI_ENDPOINT=n
> +CONFIG_SPL_PCI_DFU=n
> +CONFIG_PCIE_CDNS_TI_EP=n
> +CONFIG_SPL_PHY=n
> +CONFIG_SPL_PHY_CADENCE_TORRENT=n
> +CONFIG_SPL_PHY_J721E_WIZ=n
> +

Please check, if this make sense , PHY_CADENCE_TORRENT and PHY_J721E_WIZ 
depends upon PHY in Kconfig.

In order to disable, just say CONFIG_SPL_PHY=n.

Same way PCIE_CDNS_TI_EP could depends upon PCI_ENDPOINT


>   CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
>   CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
>   CONFIG_OF_LIST="k3-am69-r5-sk"
