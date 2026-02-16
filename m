Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D87E81A5D
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 17:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2ED7B8063E;
	Mon, 16 Feb 2026 18:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="G2Esl2le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F40B680FA1; Mon, 16 Feb 2026 18:39:35 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91EC80325
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 18:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz4CD33aAU8BrjfaropQrF3cjXAXYqGVUBSey2MRLcp4753FYr5fClOzQcjAiBBXYM4Vua90lmC6KJ+tUQ6bbXN17cA332QSWHb9gXnbdcxSqUUSCSw0U0WNeSDsMtmeUPzYXmiWWef4xlJUdB6uhNV8jDu4+RxFOs8cewP9rs6UgIJTDH9eOD1vc5o9ck71Bf3o7Zc15ntPsAKzvWPXXjkMoGDBs0G8x6NG6po/UFJWzV6oa8a1zf/gZIgk7zdzMIGVCjc8MlRonfDN0Po46QoZK8wko4dG0JH2x4ADxyvTzLzmGYNheK9nr1e0EQW3fiv+G79ShKaqM+ffCRHJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn/kmVg6ye8cn4qs/8mfTV1pR96a655M1vdX5x+7H6c=;
 b=ZfOFGyYDapBJ/NZ0Y3xT9uMeXD92dpVK/DP5Y5Sll+FraNGT3qbvX5AKdZ9da4PkgnuGWD8DnGPnJUiSaCuKDZNiAlHslPR5cMHVb7/CuHKp5BlZTBwXXF+oQy3+D4pYYxNHOJ7kDfpMAVDKzW4Q7KSiISln/wmQIWzSdDWYicNIGX7YANQ73e2wrRERvQiKu7Pq/KOeLAnNsVqdLQ5Q5JurAa9E8Ziu8HufjADu2qV3aYOFJYNo/06CQAIhNSKnuGkDqKv1V5X9Ayu4sy703tjmULD8Qy0TxWw39Qj9tNKrhBNuw8lk/K2hoTgbW5Gzws6ZJAb9f0ZhLdGO83AIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn/kmVg6ye8cn4qs/8mfTV1pR96a655M1vdX5x+7H6c=;
 b=G2Esl2lerWUC7ycgtSXUZ0hlRuDTlgEYskbZ7vQM9c36qNWHUKu/nWwiyLod2FR5MIMA7Y7qgq9iGcbgXTr7mFfSpAkpDM+lxAmjTY84qxE/H0r4DpL+igC5erDQptgX8zG7LeEnuLjBfv24b870ywRL1XsJiijlAJvaSI0kEmM=
Received: from BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21)
 by CY5PR10MB6071.namprd10.prod.outlook.com (2603:10b6:930:39::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 17:39:29 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::cb) by BL1PR13CA0106.outlook.office365.com
 (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 17:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 17:39:29 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 11:39:28 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 11:39:28 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 11:39:28 -0600
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GHdRtk2090260;
 Mon, 16 Feb 2026 11:39:27 -0600
Message-ID: <0de97221-047c-420b-aeab-3b5eee74f97c@ti.com>
Date: Mon, 16 Feb 2026 11:39:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] configs: am69_sk_r5_defconfig: Disable PCIe boot
 configs
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <u-kumar1@ti.com>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <anshuld@ti.com>, <peng.fan@nxp.com>,
 <ahalaney@redhat.com>, <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-7-s-vadapalli@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260216102858.2745657-7-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CY5PR10MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: d174754f-8f02-4d0e-8157-08de6d82563c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020|18082099003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K21ZRWxoMTcrUFlMYm82ays2d1FrM1UzeGtwODN5YzRrbGFyNVl5QW02Wk5v?=
 =?utf-8?B?bklXbDBkUzQyVjlvMjB4K3hKeWo5STZaMWhMblY1YWVUb3MyQkUxVlFYcXg0?=
 =?utf-8?B?bjNxcHVqb0NvbWRkQ0FMbkdGWklzTGg1aG84b3k5eDhoVnVrMkNhR3dkblQz?=
 =?utf-8?B?NDJxblAwc2ZVMjdDeVVkcDZialQ0WjBIeWVWU0VJRGRMUk9UOEFaUkpZNGoy?=
 =?utf-8?B?TDc2ZG44ZzNwbC9EZEg1bjVKSmk5cHFyTmhTSUpwd2JUVkU3Z0tDVjJNUnZl?=
 =?utf-8?B?dmhHbUxMRUhrMWRraGtHd1phWWxFUGgyOUdtNHoyWFFZVElKV3JNSUxwaTZ0?=
 =?utf-8?B?YVNBRllwQm5TZ0FDMXFwQzBTK0ZSTFFub25ZUy9zblB1eHRvUDF5QXdsT2p6?=
 =?utf-8?B?enVvZ0NsRy9yRk1ObEpla0Q0cUcyNmJPdEVBczY1SDQwWmFFclJhSmFEOTdI?=
 =?utf-8?B?bHBWdjlHRTZubDYzVEhVREszZ1VzTy94alY3S1BkeWJiRHU5UjcwNUVCd3Er?=
 =?utf-8?B?dUJYMHFuMWhMZUhGY2R5eHdpYjY3ckNxVlBabnV6ZlZhd1dTREZjQVRwUHNN?=
 =?utf-8?B?OGhWNS9udTQyMWFWMHcrS2I2Q1ArVVBHd1RLL3RQbzB1RThpcHdhbHU0TGdh?=
 =?utf-8?B?UFcwUUxZUWdSOFBZbEZpZFYySlhObSs3QjgreTd2RVB2d2pWV1g2Wm44Q1Ur?=
 =?utf-8?B?NmVCNVFqbXQ1STlCN1hpMExMc2lhVTc1bnljWHdrVmhaN1BjZms5Z1M1SEND?=
 =?utf-8?B?Sm1PaW5adkk3VkdrdTBCY1NrUGdESFcrdlhBU0Nlc1Q0U1oxT1RJQTRSVGNR?=
 =?utf-8?B?bmdKMWtOMm9GWmU0bFY3OUhKNEhWcWc4L0FZVlhCSnVZY1pHNkJxOUJTSzMx?=
 =?utf-8?B?ZE1SVW95bFFlY2JkNGw0dlE2VlVCbnJsdlRRc0ppTDlqa1hnUmRMZWtjdWt2?=
 =?utf-8?B?dDNHbE9mc29QOTlOLzJvZkxRSWc0SEowNVhaNXVKd1pXRkJ6US8zOVhZNk5C?=
 =?utf-8?B?clFtRnlpWmJ6VFJzV3JOM1gwbFBjTy9sR05TUHNCVDUrUXRUTENlRktOSGtU?=
 =?utf-8?B?RGZ4SDFrSkJjcG9LcVZiT21HMnEzKzVQcHFNQzJUVzJRMDQ3N0FjeFBXeDFw?=
 =?utf-8?B?OGxGc29YRk03NlRvN2VsMmxaa3pvbDJENWJnaW1KdGlvU0Q5dzhGdG9vTFVX?=
 =?utf-8?B?S0twemFhUUhDRjljTDFKQkhGa0huaktYNk43cDd1SS8wWlhlSGE0VjBWeHM4?=
 =?utf-8?B?WnVMZHU3dTZzalYzc1B3Qjd1Wkl5NVBXcGgxLzZibWxqNTVOYzRkQjJIY2JQ?=
 =?utf-8?B?c25PK1FvcHI5dkJ0VHV6UGNDdUUxbjlsRmNnU0RkTFNMRE1qSTlrYlFMcnND?=
 =?utf-8?B?WGd6YkxBTG9kMURiYjhpblZIZUtuRkp4aU9mc242b0o5RDlHSkVXVlhFSVpt?=
 =?utf-8?B?RXFUQkg0RUVRbmFqUjVFQ1VMK0k1THFNb2pqSUI4TGNnWTBsMmI3R0pSQ0lp?=
 =?utf-8?B?YnRlSk8vUDZzaGRoSW9tb3psMi9zejhuNVRvcFBJM05lRnFDKzU4MnBIR3Q5?=
 =?utf-8?B?Q2tHc2hUTStrWHcyUzRJRnZ3M05mZkREeXM0cUJBZU4ydW43ZEVhcTFPb2hm?=
 =?utf-8?B?aGRQUVBCRzI3eEJ2S1Z6cGt1UE5mbjdMNnRrcWQ4WjN4Yll4U1o0clhpVzhW?=
 =?utf-8?B?MlZINXJ6d20vYWhLeWlNU2laWVU4UGVrYXpHRXZLczVXYURRb204VE9LUkRV?=
 =?utf-8?B?dWtDbEc5OC9zWnZONTAvVEJYVkR5WkhUK0o0ZWFUVjNMa044bDJseWw5TWVa?=
 =?utf-8?B?Rk1YK21wNGNCcTJxYmtLbzk5TEpyeGlvcHRhYm8zMm14VXE3L1I3Mll2Ym1F?=
 =?utf-8?B?cDR2ZzQwaEg4N0k0N1RhV0h6di94VUJGWnAvMFpFeGpWRWFFRlYyMWJoRkVm?=
 =?utf-8?B?Ly91MUEya2pETUpHWGRML2pGWERJaXlNNVlaUFZQVnh2NytXeDlxNXROUVFX?=
 =?utf-8?B?ZG1ZZHhxM29vWGxmNXlDYjIwS3pjNzNPQlp1UDVPZmowbTdpRnlFNVp1eGJH?=
 =?utf-8?B?eHZMQ1VzWEVEM1BDMTUzZUJpZ3FzSU96Vnd0K2QzYmZwMjlqTTBzZ1VFd2Ru?=
 =?utf-8?B?ejJqMDl1ZFdNUS91Ky91UldOczQxSzJ5bnBJUVhPY0c5dWlvUlhTY1E4VXpB?=
 =?utf-8?B?TE1IWkNQSmNuTXNjTlRvOG5Ga3F0OUk2QVZJOXZxZEQ0bHIvLzNpQjhhKzNq?=
 =?utf-8?B?ckdLTVc5UUVaOFBDMDdzMFVablNRPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020)(18082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9x3FaJ8vv2ccsMTS30KczAw3a5+yMBooHYIWz7o9ZcZYZOlbc+2DKO+C0PTI6O6hdGU53OTKGER0fOkz2hgcTjnCqBziOxQRnxja09mBRylKl46m0AYRxARgKMr93D7kpeeRZkBgJLfNAWJirrEss2L9vjAzeWojUpZWqEden4pOCArFwGGT4VK4qr+KfMUV/tqLIU71Xx3M3+lA2HVW3RzE/c199FS7naVyPaCmdu5jysDFaAtP9SnzgV75RlfyT8a/imaBGO3LQpECGMqP+ApTZLQjU7lW5r5Ei8IKpkvTs7SpAOr4/455lTzDItfT0RsmmHUP/DpkVh8s2YiK9m9zxrMhSLBjZcUoXyolH1uSaTPq0EF1BYrTid8PiMyaJnfwrFrML8gO2VfDFkfriTJMRMNgJYhn+wkq/cPIPOkqGbREE4mQZAZM7I2G7170
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 17:39:29.1983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d174754f-8f02-4d0e-8157-08de6d82563c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6071
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

On 2/16/26 4:28 AM, Siddharth Vadapalli wrote:
> From: Hrushikesh Salunke <h-salunke@ti.com>
> 
> AM69 SK does not contain PCIe Boot in the list of supported Boot Modes.
> Hence, disable PCIe Boot related configurations that are not applicable.
> 

The board does not have PCIe Boot selectable on the DIP switches, but
those switches are not the only way to set the boot mode. I'd just leave
these enabled unless you know of some hardware issue that would prevent
PCIe boot on these boards.

Andrew

> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   configs/am69_sk_r5_defconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/configs/am69_sk_r5_defconfig b/configs/am69_sk_r5_defconfig
> index 2186b9a0490..166f774aade 100644
> --- a/configs/am69_sk_r5_defconfig
> +++ b/configs/am69_sk_r5_defconfig
> @@ -5,6 +5,12 @@ CONFIG_ARCH_K3=y
>   CONFIG_SOC_K3_J784S4=y
>   CONFIG_TARGET_J784S4_R5_EVM=y
>   
> +CONFIG_MULTIPLEXER=n
> +CONFIG_SPL_MUX_MMIO=n
> +CONFIG_SPL_PCI_ENDPOINT=n
> +CONFIG_SPL_PCI_DFU=n
> +CONFIG_SPL_PHY=n
> +
>   CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
>   CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
>   CONFIG_OF_LIST="k3-am69-r5-sk"

