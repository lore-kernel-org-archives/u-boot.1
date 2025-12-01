Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64944D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E93A83C54;
	Mon,  1 Dec 2025 18:02:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LeUQ0Llg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A6683C54; Mon,  1 Dec 2025 18:02:07 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02CC083C39
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:02:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVMVJPuXnEwud2yub6ggqZhQsR32buZwyyX2zNkh1C+W2a9BWF1FN2B9V+33uKlZe2Rx6LIJp4X7P2FreoCD8Cq37blrcJIk2pq87itqMdxTxVc3KWvLeaIw+u1WUUNfDh0VWrykh5+7pEP+oX+5DgDLbLaOHkSmMk9vU2TvIrojzRFRYdBy/xqXEuVTK+SQiJ5rjW8WETRr8cW9dL1c3EePeBLt6OzSfHQNnB092il1eQesHc/Eahz0qIztpdhBlGCq28fngB8Lga5V+p8MSDUmiUeH5SGP3SfdZ6pq6p6OSMlIcZyk9XsRCxxuGYh4dpdEnR/E7FFc+/uezDoCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhM0b4doLoCdHSG7zzUtdOjFh3LoQa5EB1ZUwF2z+40=;
 b=a7n0Rp0oWXegEo8+8bmnuHNc/vaUGeIFP635TJunU/HQcIyQmX19y9VKG5/+hHave7jTGsOQ/1UCWZVwbraen7ydOhrEu+GOuCJi7GjE8RRpOzfwScwyfb496ZdVGCUk6KkUkLWtZFGyEjvB/+WrKd8N4gLOgJvf9GFOht8RPoWF0bHfvYh6UwrL1vIcrRqGZOD6uwRjNzNzeN705luQs2G7HEwfGdFEIfUi8g8YHtf2lkyd2WW/pJoUFc5UsNQ6S52rVSf/n6pxQ0OgFZyQhmjtHIOqWwHFLMkdBwLJnwSLK8graGa5W5BMlUabzDN8lukfWjYvTsW1jrFe32ovCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhM0b4doLoCdHSG7zzUtdOjFh3LoQa5EB1ZUwF2z+40=;
 b=LeUQ0LlgwlAI7aR+OAIZGBXW9ybphVuWCQQA6aiF9a055/vfXVAfrUYBnl7rSwfxUEObinDMlx7NxTi2xEHjvPAadvc3kq7dwKzeLTts4oUlGZbHv8ZacRj/9VWtS5n9s62Cb8ey24I5WHSzm9vGVHC2kmbrAfMT3A7wjpC6l5A=
Received: from PH7P220CA0139.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::30)
 by CY8PR10MB6540.namprd10.prod.outlook.com (2603:10b6:930:58::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 17:01:56 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::80) by PH7P220CA0139.outlook.office365.com
 (2603:10b6:510:327::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 17:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 17:01:54 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 11:01:50 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Dec
 2025 11:01:49 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 1 Dec 2025 11:01:49 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B1H1lYG789493;
 Mon, 1 Dec 2025 11:01:48 -0600
Message-ID: <df77fb4b-8cdc-4029-abf9-4757d7d8ca25@ti.com>
Date: Mon, 1 Dec 2025 22:31:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: mach-k3: j722s: Fix eMMC boot functionality
 broken by Ethernet boot
To: Chintan Vankar <c-vankar@ti.com>, Tom Rini <trini@konsulko.com>
CC: <vigneshr@ti.com>, <mwalle@kernel.org>, <u-boot@lists.denx.de>,
 <u-kumar1@ti.com>
References: <20251201060839.777816-1-c-vankar@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20251201060839.777816-1-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|CY8PR10MB6540:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c247dd-bbaa-4654-5775-08de30fb5498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFo5N1huby9STnk0NDRNZUNmdFhJMjgxOTNIMVdVM2ZTVjhta1orVkdjYm1Y?=
 =?utf-8?B?Q3Nld1VGbkFQbmhCYTRMOXd6V1hLT2s1YXAra3MvejdCL2NGSzJtbWVjazhZ?=
 =?utf-8?B?YnBUUWppWVF1Y3Z0dkcwejRkVlp0cUp1M2pWa2xUZEk3azFrRGFGYlp4bmtp?=
 =?utf-8?B?ZER5RThQempOM21EZjZlUzlFSExqclZXVEI0Mzd2MzJsUkMxVTFKamF3Uk9t?=
 =?utf-8?B?Unh4SGwrWXpYOTZUMVk0K3lFNkw4Q3hLZDZJYklQOHhmajZkTHJkZ0tNMVhn?=
 =?utf-8?B?RkNvaGU4ZFJNd0lCL1VEWjZsQWhscmRacXhwc29sOG5DeGZZRWdweWhXakxv?=
 =?utf-8?B?MHRoVnZoR01veGhQeUVxT1RtN1R4ZVFzRFNHSWZhQk9aZGg2OTFXekVyeUxJ?=
 =?utf-8?B?V01hRXpZVnRzZFoxaWF5YnBxcEs2NjU1K3gzS2dVUUlSYmVoRXVuSFZ6TFdy?=
 =?utf-8?B?VFY5ZEFHSDQ5YTJrc3hWRnE2WFpkYkVFVHc1SmhwbWJnazZrK1Y0Y1ZNMWRT?=
 =?utf-8?B?dzI1aVdIV1Zwd2ZSQUE3VlJHaENLZEV3OHhaYnF2S1BhbEYxTEdaWkQ1d015?=
 =?utf-8?B?ZFBLOEdpMVhjUSs1eDFwUTBwOEd5NG9YbW5PelJYVzVQMkRGSkdJMm1CNXJS?=
 =?utf-8?B?U0NVbENuWG1zeGdZamV2bDhXdUpvRGhuL1FyN3p1eU5PQXowUTl0VFFvblUz?=
 =?utf-8?B?Ky9JcTdpVlgzVXYrWW1ZSFlYbi90b3R2S1B6azBOS3hjTGY1aUYwb0toRjdr?=
 =?utf-8?B?NElnWWRtUmxVSGxqdFVzS2M4REU3bkZBVnE1VExyNXlyNW5qd01Ia1MvZms5?=
 =?utf-8?B?VzJMRVlWSVhnNHhUNjk2ZFFYdHJTY0Z4Mi9nSE44clpkTnE5d2czV3R5U0hQ?=
 =?utf-8?B?UmNHRW9pSkxsUWh3VDBManhJa3d3NkdKdmg5S2M1ekVSRGZ1TGxmWmppaW83?=
 =?utf-8?B?VjRYZjQvYUVNTWM5bHZTcUIyKzMzRE9yaGVmUkFxYTZnTmpCSWpUM0ZzOHk5?=
 =?utf-8?B?N09SWXkrRkExMWtDL2dKL2dCL2F1dDBCY21NcmcrU24xL1dWR0hiZ3FHZGdP?=
 =?utf-8?B?MGN1alMzRmJMcjJ4YlNVSlhBcnBIK29aRkxVUHNQbGhJTmJheFJTK1VDalJL?=
 =?utf-8?B?azJIckV6bzEzL2R5d2tXcUNkN0NQeEdVNnhWY1MzVlhlYWtYVGFObmpyMlc5?=
 =?utf-8?B?eDhGTUVTOE5MQ2RvYWRLRWFjcWljc0FiU3lrUUpRMHN6SjBqUElEVnZnUFJB?=
 =?utf-8?B?a0ZuZndPSUNPeHA3YldUUXZLRW5MOHlyb0pnYmx3T1dZN09ERjBZa3FyRTMx?=
 =?utf-8?B?aFBUR3VHRWR0Ym43Q3Zwb2I2VnVpYldLZlRBTHpZaTBqd3piYUtpNVlLcTc3?=
 =?utf-8?B?cUJNdjR2STZISGNCTnpYZ2dHbG9reWtvQmhOS1JiemRDUkVWOHgzMmtTdi9L?=
 =?utf-8?B?aUJ5OFVjZW9mNlQ2WHRnRk8vV0pKcU9FeHZQdVFGUnRKLzNGOEpkakF6VVRn?=
 =?utf-8?B?QUd6SGhFbWJpaHlqWFZlZHd2ZWI0SitoOEswOE0yNVErUS9VSTJkMFpUUXp5?=
 =?utf-8?B?RWg3TmhFSW5rcWl5MVM2WmxLL2NEZnk3OE9CaUZVelVoaWxuRDVaaTBLY1RD?=
 =?utf-8?B?WVc3Q1VIWXdUaDR3NHlFaVVtUkdYZnR4bi95WVlUaHBUVVBVWU5Pc1JuWks4?=
 =?utf-8?B?MG9tNUF1eithMEVlV004OXpYdG5zZUF6ZFladEwrSUdsOWdDYlZJTTR1OFdN?=
 =?utf-8?B?M1JESmdjZ0dxWXl2dkxYUC9aeEI5L08ySzFaaDhkUTZPR3E4N2pFOWpQSkVP?=
 =?utf-8?B?WEhGelc3REJlQ0lDWmFVbFNkS2I3MFF4VUZhUnJLU0Zxb1VYaWFYYzQrMTg2?=
 =?utf-8?B?SjlJSmFQL1diWEg0aGc3ajFWTXoyYml2Y3I5dVZYM280dDNLSVVSVWg0YWVJ?=
 =?utf-8?B?a0lMM3oxZTY3R2xEcWgyUWM1Sm1YVFpNUnd6cGxWYnpLVkwzV2c2WTJTdVlB?=
 =?utf-8?B?d0wzeTV1Y0xSaWdEUU1XU1Z4Z21ySUtWNnU5dzgra1lmVGNvVWFhQjQvL3VL?=
 =?utf-8?B?VVRwd205RUxidjg5VThNUUNBWE5KMVMxU2FsYkRyNTBWbmhjelJkMXJwT3hK?=
 =?utf-8?Q?DQtU=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 17:01:54.7077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c247dd-bbaa-4654-5775-08de30fb5498
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6540
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


On 12/1/2025 11:38 AM, Chintan Vankar wrote:
> While adding CPSW device support to enable Ethernet boot for J722S in
> dev-data, the eMMC boot functionality was broken. Fix this by adding the
> missing device ID 57 and its associated clock configurations.


What does device ID 57 represent here , give some reference or

you can simply say, while enabling CPSW support... dev-data and clk-data 
for eMMC

was removed by mistake, which leads to eMMC boot failure. So add this back



> Fixes: a02009f3a816 ("arm: mach-k3: j722s: Update SoC autogenerated data to enable Ethernet boot")
> Reported-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> Tested-by: Michael Walle <mwalle@kernel.org>
> ---
>
> This patch is based on commit '31bf4a1c30877' of origin/master branch of
> u-boot.
>
> Changes from v1 to v2:
> - Updated commit subject and message to convey what has changed by this
>    patch.
> - Collected "Tested-by" tag from Michael Walle.
>
>   [..]
