Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65294E9A02C
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 13:32:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB2583D2E;
	Wed, 18 Feb 2026 14:32:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uym5Go6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA74183AC5; Wed, 18 Feb 2026 14:31:18 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B292183A47
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 14:31:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXdt43hYLXzWOTRkMAFqEqPa92R7EZVRnHlN3ChjEqSt5wFHDh8Ug2azKgE3Ok2KlOnvt1d3LJ+uxtVl1zeNJse8gcbUKy/l/NZ7YUt5b9xMgfyXI7C3XCjD6nPfCB5io/ZUlJQr/uLJ/9CiMbq/lwpDhi6AVqw8yscP1+ujQJRhxEt/n/bF29aKBFA7kK2wViWlQ3g8UAfiSRdd+Uk1+Q48AieaNOOGg9fIkb0zKVKAst5crC4QypXTcrnyH0dr8dFrFJoZC1pAbtU4p2uhH2l9jro3IIAXz5RsWngXvnZzbeY12tCDE/EcS277fV9VVLyQRIAoGfaM6kePpmAhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4chkM20DBhhADYWX9Scr9SgumtxIQsrxyFp/y/cFJVc=;
 b=IAJ5n7QoVHOFJJXgB12cHVfZd1xVnm1Ne0YhN21VUJiKTjGPkd1TJ7UNkI1nMPBt2vaxKeMtQYLauml93Sd9rT65/pyngcC/ZaRPGCz/GHxSyMWavmESdD+fkxlARGfg1+wHbKlX8Q5aSwXSuQIrodzS/Qz6RBKGoDAeMfPTH7ug/ZXLtidHCiuvzdCHP9MJovNRZSctILVXPpp9N/aRUVoU5Emo4KLl4jWy3LzxhKCe/J1Z89fjgKqTvrZVbWmnoUAVglYVCFhskKLFpHZapDrVwmO91ptoULALSGacgO/RHna+pa+qVR8qn29atP90ryAJRder/u4KMKG6GODxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4chkM20DBhhADYWX9Scr9SgumtxIQsrxyFp/y/cFJVc=;
 b=uym5Go6Cl+x6DnLSDfT3/vckrDk5/eS+njX1fMK+ChVbdzl2YeKGmfSNUCz7lMqwhh0iuXUtNXdogj/KO44eg+IGFdEI6CuLB800kNRdB9sxFU+3jx6NNOawGyBJIutqqWiNBqYIfPhWxnFdeLRYUyTME+WoOUVUxjtE4WkUD94=
Received: from BY5PR16CA0001.namprd16.prod.outlook.com (2603:10b6:a03:1a0::14)
 by PH7PR10MB6601.namprd10.prod.outlook.com (2603:10b6:510:205::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Wed, 18 Feb
 2026 13:31:12 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::30) by BY5PR16CA0001.outlook.office365.com
 (2603:10b6:a03:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 13:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 13:31:11 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 07:31:10 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 18 Feb
 2026 07:31:10 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 18 Feb 2026 07:31:10 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61IDV4RL446200;
 Wed, 18 Feb 2026 07:31:05 -0600
Message-ID: <00033976-0f4a-4045-8d9a-4f84b026a337@ti.com>
Date: Wed, 18 Feb 2026 19:01:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] configs: j784s4_evm_r5_defconfig: Enable configs
 for PCIe boot
To: Siddharth Vadapalli <s-vadapalli@ti.com>, <trini@konsulko.com>,
 <m-chawdhry@ti.com>, <c-vankar@ti.com>, <neil.armstrong@linaro.org>,
 <marek.vasut+renesas@mailbox.org>, <j-keerthy@ti.com>,
 <semen.protsenko@linaro.org>, <afd@ti.com>, <anshuld@ti.com>,
 <peng.fan@nxp.com>, <ahalaney@redhat.com>, <mkorpershoek@kernel.org>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
 <20260216102858.2745657-5-s-vadapalli@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260216102858.2745657-5-s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|PH7PR10MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: e50ae86e-4da1-4b99-645c-08de6ef1fb5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dUpRd2ZBY2x6bmpCVVJOY1FYRmIwVFQvS1pzOU1EWXZaN0JHeHgwSFlpK2VQ?=
 =?utf-8?B?RS92aWxBTjNrU3pBREMwUUhXUStGUk0rekVSN2RHcDR5ZnhCZWhVdFhCK0Vt?=
 =?utf-8?B?Q0MwdUhOcnliWXh2c1VTODBSMTJPeHNpa3k4SytXcTV6RFlaNllwQnN0a0ZT?=
 =?utf-8?B?Ni9xU1RDTzAwRlZvNWY1cDc2NjErVkxmOGxKQ2VMbkJXeTJobzlhYm45M2ls?=
 =?utf-8?B?YWFLV0QwWnoyaFh5MVFqTHg5SXRTYmlzaW0vYTRMcGZINHFHTEt2amFDVjBk?=
 =?utf-8?B?eVdITkFOaXBLa1dmK1ZtSXRUM3lycyszL1hjZkRJU3pyaE5vZ2V1UW1ydmZp?=
 =?utf-8?B?SnJoQzNXZ1NDTUJUa3oxc2NYRjBqWXBkalh5VjJUUlZ1NnNuR3B4V1U4Qlh2?=
 =?utf-8?B?b0lmYnJKMFE4SjZiNG5ETnRCT2JKYTY1TjVHR1ZuSjB1NytHYm4vdXFpRHpW?=
 =?utf-8?B?Qng5Y25POFJ0bHdqbjdKMVI3dEtTd2hncVQvSVlXdlV5K09XYncxRkxvcDdT?=
 =?utf-8?B?Y3U5RUhRNE5CQVlPcjQ0S0VoajZzYk5oK0NVTDVLL2wzTi9LUFRSUFQrUzYz?=
 =?utf-8?B?VFpudldIQlBGTWlCK1BkYnE2WFpsRXh0OUNIOW9KMEZkMEhYTUw2T2doR0tV?=
 =?utf-8?B?QWM1Smlja3pDSk1vdjJvOEkvZTROcFAwNS9sN3lUOWdzakc0NnRaM2VsTFpt?=
 =?utf-8?B?b0NXdGF1TjJBM2hsRUFOWlRodUVkQ1hLM0FYMkx1OS9FSUxvdGxETWlrVFNP?=
 =?utf-8?B?OEtKY3EwK1EvUHJQbHZYbzFsalQ3MnBjNmFhMTZKdFVNc0Fkbys1cngxYkVM?=
 =?utf-8?B?ZUVYSTY4NGI5UzNYNUx0elJINzZPRU5aTWVwTGRzaGc1RStJdmRQM1hrSUJa?=
 =?utf-8?B?T0NVc0FkRGpRZEl4dkVPT1F2Q3M3eUVYelExbXVMelJmNVMzQk9wai9hTmU0?=
 =?utf-8?B?cklxd1VqbVVYcTN2S1l5M2FiajRqV0YwR1VwYTZnZU1wVDhxaU5Nc2FIcUJv?=
 =?utf-8?B?ZUN0RXozRW15bDRXM0VqaU5pdHg0MzZlTVBwSkk1ZXlzelY2aFE4bXVWWEYx?=
 =?utf-8?B?TjNmRTZxNFowV1JPQXhyUHc3enVVZkJPV1g1cmZ3eDlkT0Z1OEFvSHhkNzIv?=
 =?utf-8?B?Nmgzc2twdFYwMFN2WUpTOE8wNUNaRmQ3alErSFFZRXZ5aGtPVEFiZVhpckpv?=
 =?utf-8?B?Vm4vMHYxSklCZmJIaFFJajRsRlFYZ1VLdUwrcU9rWTIzUUg0TjBQZTVDQkFl?=
 =?utf-8?B?U25WbTY5cnZWRnJ6bVF5WWNOREdTekxJQnJuc3czMjN6QjNVQ3dCbDRwK3I0?=
 =?utf-8?B?Qk56cWZxeE14ZTVnbUdHRnV1WW9udUZ3WVdNendzNFpETjdleXBGZ1VzOE5h?=
 =?utf-8?B?UUJDN3dHYWVuZU5QQnF1TjB5V3hKZGl1K2NlTlUxNVF2TzJYbER3bVhRZVdH?=
 =?utf-8?B?TU5hSEFlNGZsaFZDYzBLVjZ0VXFTSkI4Y3JCQWJIQnVocTRTV1REenh0UU5M?=
 =?utf-8?B?a2RuQWhtRTFjajY1WE54ZlhGbWptdVNGUk5uWXYwY2dHWFl0Z0NjUlIzWjg2?=
 =?utf-8?B?azZCTXdtc2lFZ0dYWXNRTmhnWDltM1RicEljVDVZUXlNWXNjeXdvK3pIdmts?=
 =?utf-8?B?eHBmQ2dvOE43KytMVXJWcXYwNk9HRk8rSWpKUW9ma3hqU3UwVVBsV3hKamF3?=
 =?utf-8?B?SXJRZFN0QzFqa0krRlIwYXdqUStDTXVmSkFtNGd5SFp5QmhoVEdWR2JtSmMw?=
 =?utf-8?B?QjNlS1JwWHR4N1BPaG51Z0lOdXRORWQxNXc2NEFkUzdIQ3FuVVBOSWVIOTNV?=
 =?utf-8?B?ZDdpOGIxREZyTjlMKy9DeklScTExUkMwMEkzZ0E4SmtiM0UxeGU3ZjdpWksw?=
 =?utf-8?B?dXExZkdQaVdicUxzZ011eStvZC9kKzhhWERuc3BhYzEzNTN2d0hmOUxMOTdi?=
 =?utf-8?B?S3M0NEpUM0ZtaDBGZHFCZTZkSDBuYnl2L0pZY0kyOFlSeHJ4TCtYWXFWakVX?=
 =?utf-8?B?OWtyK3BKbDFEZjNoTjlyVWYwNlo0U3pCem9zMnBISzBLV2FxTUFuQzV3ZCtt?=
 =?utf-8?B?QXBhUmJ4bFJFY1RtN0VzM1ovdXNQeXowRTBRU0wzVmxzWHNoNTdIUUtRVXhp?=
 =?utf-8?B?Lzk2OHBCZjN0WDdlcThMdnlSd1FTYzdzMWFSUlhWeTBvVS9LYjdZYTJvUHQx?=
 =?utf-8?B?V1IrZHJ2QS9rc21XY3BqaDd4cFUzNHdJRTZZazNrS1hVRGFUZUdNd2RDcEw0?=
 =?utf-8?Q?4uMpLzcsDQ/Ef5W8jUaOniOsNWkUsrPqj0sOOMWey0=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ra0LmZ+zlO4+8KESXE9saX+RiNNoxe72VXb3sx7Tjz/+zdNVGAnQq3PDqrhKM4ODltN0x2MG6gnVJq9oQ0nz6pLXUaeHBS/YyHwGjPDXCNDzwzDHN6pfn5F4ytFxUOJw2lq85/H/FFEW1svKDdtNxw2b09BWPJc1Hh5MFdENE/9/jpeJe0pggNjwZb27pBNw3pNG+SEHcFrAvQV/Sy/gbHLjiJpk4jDse/2/I9ZtsURW4RDzh5AFPAY4jQi5A8Fa92VwSQaSeaGwIVE0vpb1i12y5mt1Lq4Yas6m4Y21UB4q6g12lVnymgKcs+jK+lne3HO8OTWuvztcCzVgA+2vyyUadhtk/2iddoSnYMJz17QMokPDLyqmqTtxZQqOFOnuHiAgBF9NirmtMu5p5dCsQiCxkhEOAD0LjZHC+2PRCxD+4Y/kObSXfp55hSLqljG5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 13:31:11.5049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e50ae86e-4da1-4b99-645c-08de6ef1fb5b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6601
X-Mailman-Approved-At: Wed, 18 Feb 2026 14:32:16 +0100
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


On 2/16/2026 3:58 PM, Siddharth Vadapalli wrote:
> From: Hrushikesh Salunke <h-salunke@ti.com>
>
> J784S4 SoC has two instances of PCIe, namely PCIe0 and PCIe1. The
> PCIe1 instance is used for PCIe endpoint boot. Enable the configs
> required for PCIe boot on the J784S4 platform.
>
> Additionally, enable configs for J721E WIZ SERDES wrapper, Cadence
> Torrent PHY, and MMIO multiplexer. These are required to configure
> the SERDES lanes at the R5 SPL stage for PCIe endpoint operation.
>
> Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>   configs/j784s4_evm_r5_defconfig | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Udit Kumar <u-kumar1@ti.com>


> diff --git a/configs/j784s4_evm_r5_defconfig b/configs/j784s4_evm_r5_defconfig
> index 25ab6f17d17..4462e7530e4 100644
> --- a/configs/j784s4_evm_r5_defconfig
> +++ b/configs/j784s4_evm_r5_defconfig
> [..]
