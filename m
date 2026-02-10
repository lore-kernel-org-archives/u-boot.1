Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60936EB26F5
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 18:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A18FF8367F;
	Tue, 10 Feb 2026 19:05:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G8KsGeTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E47483A5A; Tue, 10 Feb 2026 19:05:39 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C6EA802C1
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 19:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz7HHDuZNYm2nOow3hwl3nlaEqGM269fW4ZVVoZ6RaAtUaT9ay5swhlB2Z1gyQHtafCp52y8Weo3/+vcz5Lpexo7JiM0q7j/1OJ+wQFaHWxaz70jiTCEDeBN0/2RZdWOQkuOX1Afsb6VD0KZD021cozTaUBA8VGsrK/UYOf4vCukmycr/euVH3QIJtwODhvYm6NHRvsL0+dwK4/WESeennFxOLkXkgLBf6VzatQn0gE+AcNWeE0VqcY+CPFarMDUL5lvEshGw4SZ2buC4xei54MoAjvKPGn2yN/IgQMoR8rZ0yn/20IO5N6ckk5z/cr9v6CMTzZjmsKNmYnbOYmWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjoqT7Iw/jwmrtNre8QaVwlfzNpIONvM4P8husnaAp0=;
 b=MHsyNxWpDhzwCw88MEffBi2DU2FpTPdF1aMOH2bdtQZesskGTlwaU69Iakv8iM+CQnvyzdRe72ZqRSDoWrxBLnAerJENKUoDwHy9He8SA+a9cDcDzYLHh0LLCStR6eaSBHlKgjSB7Chrk4yoc3Qax25OUNgX2OHkezex57siAzwigsJT+RxKNDDE6rwyTMfUDFTtxHpUwVTRkTpFxkGcF2SwApkGjM2VdjTxhpfsU1E+VYHCUjlBmDyUg+Lr4vjCX/XZ+worwDBDsNkpnY7JH9SRufW+0KB+Lv/kBGPUuAo+KYC657Q2UR3aO+hPNZB9yjuEhdR/rj0l2Mfkx/M6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjoqT7Iw/jwmrtNre8QaVwlfzNpIONvM4P8husnaAp0=;
 b=G8KsGeTxfEKqIo82/mMvzXMEaZ4XNpH42e9vp77pUKWrpwVQ07GCDk62sMxgIlrqEMh9ldhpy6IS4NSYWLhsj6j+bOOy5Ed2CXYeeMpqTG3hiyhfzDwlnkOfcgUejxDsPvggqynnqHV9uX22h5iNQ6tIoVHb+L7us02ZwwEJsTU=
Received: from DS7PR03CA0084.namprd03.prod.outlook.com (2603:10b6:5:3bb::29)
 by CO6PR10MB5620.namprd10.prod.outlook.com (2603:10b6:303:14b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.8; Tue, 10 Feb
 2026 18:05:32 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::3d) by DS7PR03CA0084.outlook.office365.com
 (2603:10b6:5:3bb::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 18:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 18:05:30 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 12:05:05 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 12:05:04 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 12:05:04 -0600
Received: from [172.24.233.254] (santhoshkumark.dhcp.ti.com [172.24.233.254])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 61AI52Ya221598; Tue, 10 Feb 2026 12:05:03 -0600
Message-ID: <141c6627-6ceb-4bd7-871c-d2828887e28c@ti.com>
Date: Tue, 10 Feb 2026 23:35:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Update DDR Configurations
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
References: <20260203063529.1551907-1-s-k6@ti.com>
Content-Language: en-US
From: Santhosh Kumar K <s-k6@ti.com>
In-Reply-To: <20260203063529.1551907-1-s-k6@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|CO6PR10MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ccc873-143d-4d98-cbdb-08de68cefa66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFRpYkFHZFc5QVJRcC9jSkdGWVE1UnBQblY2bEJ6bEVlRWp4bTFGY09LOGlx?=
 =?utf-8?B?OHZNandnNHIrc0NNWFFpNXZSSUl3cXVYY0J6RUxoNGk4RmdKeXg4dTQxeDc1?=
 =?utf-8?B?RUxJK0M5OGdlazdwUFV5TlN0Z2FSNFNieVBaSkJ2WjRXdnF6eFZtNGpBbmN0?=
 =?utf-8?B?TkVWYWx3Rjl3a3pnbkVYakJ3SjYzU2RXKzA4R2NXYUlmbWY1cUpuSm1DYUNZ?=
 =?utf-8?B?V25JUDhONmVZWFE2MHpKQWU1VzhwSVpxMjExUTRiTFMwdi95YitUYnJCWFl6?=
 =?utf-8?B?OWRyNklPakQvVmp6UnhDQ0R0RHRwcUNSZGp0azY1d3Vyc1F0NjltRzh5QlFk?=
 =?utf-8?B?NFM3NHp2WVgwZENYVVg4dVY2ZU5jdlRSVS8ybFJGaUJFdXlRRlNJazR5dVBk?=
 =?utf-8?B?bElReUZVa2E5dm5pV1hsRHA3azZYMTd2QlMzZkI0TzhkU0twZkdvc2JwbEU2?=
 =?utf-8?B?RFpMdlNNZlVyOHVwVzJTR2dGaHdHLzZlK1VTZ1UwempuS3hXY1V4bS93QW9L?=
 =?utf-8?B?QW56amxiTDhSRlVYKzJmaW90cnJmZEpHbXFleXVvR1ZZakpwR0FOMkQ0eWtF?=
 =?utf-8?B?VDNXeTJTNHFZY3NZN2VtODJsd0tIVFdaTCt4UUhtT3FwelhkUVdtbUVKMTlX?=
 =?utf-8?B?dVZ0Ym02UXduY0xGVC82RXN5RThZc1NteUdWOElxRFZEUFg2ZFErMUJza2tk?=
 =?utf-8?B?VXF2QUJUdkRtMWR4MUZ1WUtMYzhTakU2V1htaFhUc2ZpTFc5OEE0TkpkbkVI?=
 =?utf-8?B?eWlUZjV1SjFkYnpIOTExY1lhUW9pNjJsSllGMElNV3B5NDE2NEgwUUl0dkxp?=
 =?utf-8?B?SU5JZmNuRWp4MHJMUkU4aThyUXQ3ZnNTc1gyVmlPdGVlSVFyOE5mM1RKamZ5?=
 =?utf-8?B?cHdmODc4RHlCS0NlOXFPYmRnYkdaQzFENXVBbXJkd3hVMk1veVd0WnRZcEE4?=
 =?utf-8?B?SGNKWXQzQWVGTWFzemtWdHFRc0VnMzJvUUl3WmFseWtWOWx4Y3kyQjZ1QndI?=
 =?utf-8?B?ekFLaHNpM3ZHYlBRUkZuYy8xY3JKekNOOTR0bjcvRGRHT2ZpazFJVDM3bUpl?=
 =?utf-8?B?Q1hLWDgyZW55alVmRFUxQmNIcEl6S3pqQzRtRStDdGs4eUhTODRBZzMvWkNs?=
 =?utf-8?B?R0RENjVDU3dPWUhML1RKQ3JaR2dFYXpzWUtHZGkyWHRvdjFGaVZuL0I0Wkt5?=
 =?utf-8?B?SFF6M1lBKzh2cVhJZUI0b0ZTL1RFTjhoekUwdmdScWE2S1Z2N1g2VUNyTkFX?=
 =?utf-8?B?QkJxS09QSytOZXZMc3I0a1RVdnJ2alo1OWhZM2w3QXlPWHBVNFhVWW5kUFkz?=
 =?utf-8?B?Mmt3bmN1NkU2RCtGRTNMYzV5SjlMQ3hWeVFudDBzbjFJMDg5Z0lqMUtaQ2hM?=
 =?utf-8?B?YkIrTW80UFhubHV2bllnR3NQN0RYbEI2QVdTc0pFdlUvQ2JlUHB3VGw0ZFRU?=
 =?utf-8?B?SytmRE52YitaczZWT1lWQis1Wmw3K1ZkVERvWFFRTkdRUlcxSGdsR3ZpSXU2?=
 =?utf-8?B?Q1lTQXVVdzlhWi9UcTVyMEVsS2tsS3ZwNXFwU0kwLzB1SnVTd2NTaHdicWJm?=
 =?utf-8?B?NFRFM2VCSHdjdnV0YnlkYThJb1NJSTkyRTI3RlZ0MWtjbzBjOWRMWmlwRzI1?=
 =?utf-8?B?S3pjUExUTGNQUlB3Y043azJCVDVYVk5GL0k3bHpvWS9MY1dUWEp1NmtVUU0r?=
 =?utf-8?B?R0xkd3JUSzJqbUVuR1N2TzZnOVRWK1JoWlJ5QjhaMmJSaHAzV2g4MSs4dkxK?=
 =?utf-8?B?V2U1bGRaK3VldmRrVHpseHdHYTVPYy9oekM5bU5HWVlCS081ZEZObS9JZjVV?=
 =?utf-8?B?dnBBb0V5bjJYYUYzOExtenU2RkMzbVRMc212OHVycjEvMS9uQytyVUZiVlF2?=
 =?utf-8?B?Y3pKWWR2aHQ3R0h5b083dEloMFpSMXNycU5vRVQzTzJmd09EMjdheURXTlVs?=
 =?utf-8?B?ekRITk95N2svdGRReUtubUlhY0pyVTR2SGgvYno3Ym5ZNnRGMnNhdkFuVk5x?=
 =?utf-8?B?REY5TXdtY0dmVkpaR3J5MjJUVlR4V0JUeFQrakRhTnBaNklEcHI1bTgvd0oz?=
 =?utf-8?B?Q1g2bWx4VFhaYUhmbE1pSVU1YTEwNCt4bUJiOFhUWWtGaEEranJQNkxiTmlL?=
 =?utf-8?B?TDFpRkVQbUtYcDA2SUkzaFBFa1ZmOTBKSkZXT1VMQzNjT3MrYnNyZGljbDhE?=
 =?utf-8?B?RTFZbUZJZE1tbklKMWtJclRnOFVGa3NVUzZLeG9Uek9kSmNxWkMwVUJMQWVB?=
 =?utf-8?B?SmMzejB6d09vUFZ1aEVYTWFJU0FnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MAMxi5rR8kYwDu+DuQcNlpq6YNLafg1Zbq2Q9Ccol4CWHm0PaOIGBlB4Aj05WxcmjKL8Mjd+m24D9gfLG7Lv1iDqiNjIhI45wubBCEulYbdQCyP+sWUiR7tYRgJHX+6NnMVjf/qraVXkvEXli21ck23puXeoSKPrgOzRRd7/55qrjUGi/6HtWl9xVaDxMswtOmsclC7RhsKFWCxEol3KvopUqGKvZhNTRY5OdbkCiB+kyfsVJYCzBw5NqLYpn7tn8zxRvAUEarkn1z6fd7LuDJvu+LmzJbxbc59zKKtI6ezq/YWEcW6qmG+QDzQnV58saQMgk0KSlJQqlmg1WKlZKip4HFGCULoA2LBloRrygfm1hHSkXb7HBv81JfbDHNPMOCCH6XuRZVYcY0Nl9ti6cgt4y1qpvwBxYhLUjut7EZbs2xuLLNHkHOMFi+Nwvm6X
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 18:05:30.5806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ccc873-143d-4d98-cbdb-08de68cefa66
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5620
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

Hello Tom,

On 03/02/26 12:05, Santhosh Kumar K wrote:
> This series updates the DDR Configurations according to the SysConfig DDR
> Configuration tool v0.10.32 for the following devices [1]
>   - AM64x EVM
>   - AM62x SK
>   - AM62x LP SK
>   - AM62Ax SK
>   - AM62Px SK
> 
> Testing:
> memtester - 50% of memory for 10 loops - PASSED
> 
> [1] https://dev.ti.com/tirex/content/Processor_DDR_Config_0.10.32.0000/docs/REVISION_HISTORY.html

Gentle Ping!

> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> 
> Santhosh Kumar K (5):
>    arm: dts: k3-am64: Update DDR Configurations
>    arm: dts: k3-am62x: Update DDR Configurations
>    arm: dts: k3-am62-lp: Update DDR Configurations
>    arm: dts: k3-am62a: Update DDR Configurations
>    arm: dts: k3-am62p: Update DDR Configurations
> 
>   arch/arm/dts/k3-am62-lp4-50-800-800.dtsi     |  13 +-
>   arch/arm/dts/k3-am62a-ddr-1866mhz-32bit.dtsi |  25 ++--
>   arch/arm/dts/k3-am62p-ddr-lp4-50-1600.dtsi   |  25 ++--
>   arch/arm/dts/k3-am62x-sk-ddr4-1600MTs.dtsi   | 119 ++++++++++---------
>   arch/arm/dts/k3-am64-evm-ddr4-1600MTs.dtsi   | 117 +++++++++---------
>   5 files changed, 152 insertions(+), 147 deletions(-)
> 

