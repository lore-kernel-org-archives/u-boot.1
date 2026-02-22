Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D0BFC624A5
	for <u-boot@archiver.kernel.org>; Sun, 22 Feb 2026 06:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F05E83DEA;
	Sun, 22 Feb 2026 07:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QEvDgcQy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECEB80FA1; Sun, 22 Feb 2026 02:55:00 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4402C80077
 for <u-boot@lists.denx.de>; Sun, 22 Feb 2026 02:54:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRQpWJd/TRFYA6VaOj8LKHz7AYrLQsfpTNhp8FL+pEhUH3e2IMZhLWJkrPUCDFsFdqSJn6xYdeJpyf/zK3HSUDQ7S40bz9hQ4ryW7RYVvhcE92CDcmUDQq/YLbHg6ysEXs7Ue0GpXfH/IctZhZq7VHu2iOUHzQ84wyWGPtH0z5IUzOaPnEH5xT653gWNvBs5IPk+uAVTkVku4Pdx2Eht7BxTrrHcfeCDXI9cZWtuRnBaeZJ+0WLKaZO/LFv1YR9YjU2hFN9fqvRO61O9rd9C50uWqqdl6vriLDxB4ufR1J5XG+0XTcOF3SdQQRmB77UFVeCfNIn4dAUw15Q/2ZkASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFgzREnlAMunc0rsY2HmA2A4KsMxf0XIJhY04BadNFE=;
 b=U2eOQk83ANYVKK9VBcB5PIR/LmDZZFO7SkrbGcix7BzV0GEyyyGH2SZiaL665P7Xk9gUNu9srNCPUTJYvu2qk3L6rPSb7Lym36wSNIPaGGsIgwxIkpfEgvXWlypTvKcjCmouAGRvHKTDH1doKmD2OuQwLTC1IjWwrt9TxyzJsB94MViDs3idWJoJWkOArGOxSy1/Ep/ebHS5NOu2b5rTIIr0CYUAZAldWn20XQ/bpgvB88kqBJeOdgR3dNvlMNSxf5l1fGiK/DC//7dNK5xkXQHWHyhzutqnFVG2kgbVysdXx9SOXCxHYOcNxnvMTyQ3q6+qnpebLCiN1UEOUyev+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFgzREnlAMunc0rsY2HmA2A4KsMxf0XIJhY04BadNFE=;
 b=QEvDgcQyQR+JEfctZGGg/8J9x95zhF32hGsnnl7Zme9U+zG38wJKgBNwUkf6ARcs0iHodBsLDrI93jaonZ4CnNvbdgwUGIZvOHdlaH6MZm7xECj55CLBAZyJeE3eoODEZmz9IJROVV/zCFg8/m4mmKwtVb4++HdqjvQJyRgnld4=
Received: from SA1PR02CA0021.namprd02.prod.outlook.com (2603:10b6:806:2cf::20)
 by CH2PR10MB4198.namprd10.prod.outlook.com (2603:10b6:610:ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.20; Sun, 22 Feb
 2026 01:54:53 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::55) by SA1PR02CA0021.outlook.office365.com
 (2603:10b6:806:2cf::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Sun,
 22 Feb 2026 01:54:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 22 Feb 2026 01:54:52 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Feb
 2026 19:54:52 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 21 Feb
 2026 19:54:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 21 Feb 2026 19:54:51 -0600
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61M1smc52614228;
 Sat, 21 Feb 2026 19:54:49 -0600
Message-ID: <1c38a0d3-8c40-4ba8-8038-df1d1bf1c85e@ti.com>
Date: Sun, 22 Feb 2026 07:24:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: k3_*: Add config fragments for inline ECC and
 BIST
To: Neha Malcom Francis <n-francis@ti.com>, <trini@konsulko.com>
CC: <bb@ti.com>, <reatmon@ti.com>, <u-boot@lists.denx.de>,
 <gehariprasath@ti.com>, <s-k6@ti.com>, <u-kumar1@ti.com>
References: <20260220091532.3584771-1-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260220091532.3584771-1-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH2PR10MB4198:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6b66f8-6952-4450-d15c-08de71b55eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Sk50NWhUVDRERGZPeXlCNVlpKzgzQnRXdTFQWkRWLzZXYnNUU1ZHaXAwb210?=
 =?utf-8?B?TmYzbFlnSWNwMzRodUR0cnlPeXhDWUVzWUdGM1ZydnlIQmR6SHl3YkJxWThp?=
 =?utf-8?B?V2Z2WlBsajFYUzkySUNCRnUzeE1rVkNWbm9WQmFsZjNIZGxEdDhFVmRmOUsr?=
 =?utf-8?B?YkJPS2JEU2owNHBXbnMrYStoMWpVR2t6WkZTQUIzaWhRMEZDRnYySEJNaXR1?=
 =?utf-8?B?TEdZaVVZUGY0b2RjZkNvV1FlN2Q5L204R25pT2dBS21CMG5taTRvcllFZEFy?=
 =?utf-8?B?VW1Ddk9NQktvaVpSWFdRbzZweC9HVCtlcSt6bkFrZ0ZMRDkyWVhydTNDVUJk?=
 =?utf-8?B?WUtTQXdIbGVBOS8rb01lZGVwUUJYalR6QWNUb0puaEtCTkFveGgyWDhRdXBC?=
 =?utf-8?B?WVBibnFPdlRjeS9tbTdLK00ySWlvTmpGY29VODRFTlNXTnl3NWlwVWIwYktu?=
 =?utf-8?B?UzlBWGlxQm00d3hyMUoxWUE4cldxaERya3diU1dvRjZXakVGVmdZVXg5MkZT?=
 =?utf-8?B?THlZVGIveS91dlU3Zks4MjlwdGwvaVlxT1p1Z0VXeW5qWFc0NndpYldPeGRv?=
 =?utf-8?B?S1hUdDZZZTUvNVNEY1ptVE1aenlZT2EvRDVhQnVzN3dSemcwUmxhdlVqWUla?=
 =?utf-8?B?M2YzUXpyYU1Vd3lZWWQvQnRIbUFqdzBJbjAraW1hdnN1MWIvd1NEaDVUL1Fo?=
 =?utf-8?B?elI0T0tYdWJ0aWh3OVNPblNXTzZibFg3L2xqZUVudDNPNXA5UTgvWldPM2Fw?=
 =?utf-8?B?Ky90c0MrUnhNQnduZXBZenBHaVNSMDFDMW5vT2pPdXBUbjgxaWI0QTZpS0Jp?=
 =?utf-8?B?NXhmRmpmK0Y4K3ZnREE0V0tQcnIvNW14SkNrL20rYmJqTk1kNUgwNVJiWTE4?=
 =?utf-8?B?dDdEL0F5THRyZ1EzL3FVdlB0TmlNTVB6b2ZxSmtGeU5aMXg2S0hUaHNqUlJi?=
 =?utf-8?B?QmNZWTBLWkIySHRERUNkYUJta1NHZjZYaFFRZzM2ZzFJY1dhNHkxVmFmYVRM?=
 =?utf-8?B?RTRRTlg0MGhGeFdqVUQzek9abzlaanZXaEJiKzM4cHgzd1RQS3VlRSs2cTdY?=
 =?utf-8?B?NURSLzdEWk9tSE8zNWZpTlZyUWNFM0FFUjlNUGZPM25PaFBicGErZGhmUHJ0?=
 =?utf-8?B?Nk8xNFpVajdvL3pQK2toa3RmWFo2c3pSa3FWZFRxYUkxSTFjakkwdEw1NTBk?=
 =?utf-8?B?Y1pWV0cxamZ5dGVrUFVjQUd5T09BbzQvTE9TZk9UTjZ3eWhwOTFkWTdYMjJ5?=
 =?utf-8?B?UEx3REVBSVB5T2psMnhhWjN2SkEvcGR4VWg1SjZoellTUkJSZ0t6RlV1aUhX?=
 =?utf-8?B?QkFoSUhtNkpnL1pYaWtDSmE3ZkpnZ2t0SlM1RzVVQlNuZzNVck8yekN0NDFL?=
 =?utf-8?B?d3Z0QXFJS2xja1dRUEx6TUkrbUorYXhNMmYvcWFqK0l1UmlPOUhzdGJveWR5?=
 =?utf-8?B?ajdDRnBJQlB0VS9BelU3QlBFNDVjejRHU3BId2d5dDFTb3ZGN0p2R2RYMnYx?=
 =?utf-8?B?U3RsV0JRMGVHcHc2WDIyY0lBbVFHbHlza3l2RG1hVTdYdnRNU24xejRaK1Vv?=
 =?utf-8?B?RG9ReHUrQm9qRElKcDNPMDdKUXN1QU9tbVVFa0NmbXpZYkNuK0g0d0loQ3J6?=
 =?utf-8?B?a3I2dEMwNFc1T1d5b2FFc3EvbWcvZU5yTFVBamQvcVYxRWxORXpSVVRZMEMx?=
 =?utf-8?B?UFphV0hBeWZ2YTRzb2JvazZrWlhBQzNFMkp2dzFnY3V6dlI2Q3BsQTZCMEtV?=
 =?utf-8?B?R0RLdThEU1g2Y1J5WDZ2Y1J5RTZYZzZoakdJSFRSb2NYUk9tOGVUTDQ0RThv?=
 =?utf-8?B?MzVxem13MHlueFRnblpMallUKzVQd1ZPZkJDa2pDc1VlcDk5WTRCTWJYRHUz?=
 =?utf-8?B?MDFjMVg3K0J0aFplUzB3MUZ1bW9rYm9sNHQ1NWlJeWduSlVxNTNxQStmbG5y?=
 =?utf-8?B?dWp4YVZOT1VGVUhiN0loek04WEdPaHZWYUxBUmdwRzB3UkhVUG90SEoxY0ZT?=
 =?utf-8?B?aVJaKzFidml3NEprWGNXeGdscExrZGt6TEZtdTk2dDhsMlRzdXNkVFh4enlD?=
 =?utf-8?B?VFQxeFFTRXFob0VWaTI5bjNIaC90ZVJFd2tDeTRISjg4bzY2Wk03SmxRUUZ2?=
 =?utf-8?B?Q0VkSmF6SDArek0wRitMbzFhV21tU2R3ZFZRWDAvZEdCUlRIMjRoc0ZXSS9H?=
 =?utf-8?B?TmY5cDlqMXJjVTJiN3MzWkdsRlhPUzZxcWFDTmsybWkybFlwMXgrS3QzWHJq?=
 =?utf-8?B?cXhONmwxU0dNc0JFbkRDdm5vYldnPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WurQilcRavx7/cdR6KHs9BLEUDIDz0jLKgU1WWMTE+S/2g+f2HbqpkXyvqMZfFg9pB1XmgjnbyZiRs6N8GEFR8ru9drRlQt9KS5GCQHR/xnhSvGLNrZTK5DUoiVsy2Xb7CcrZWj2A7JdcpK2bjR7L0lD7RXJ/DLOc4KsasApHldgnmmORQTFmk8mjDjILE1uobz8b8WISfV51Z6XNcFvOmKomDIoNGM9B7XrfEvqeGIqyqWfJscAuzONBhWx57vSkb6Ed12Gq4lZpSYMDtVh8NvptS9cwjPAg9L+h9lG/nFamyC2Tc2Un4cLNxSb98rm0NfxkZoC/jz7IFfYYE5sacuX4xBWB9jBnc8k/z7Rmr7AEkKni/ddQbt4Jied7V1rsRpaFJkc9swf4TGuUtGwCoPkSiLLxa/tv1Kcf2VmY8l6b9GoS+YVQgcBqnGIJRxy
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2026 01:54:52.4597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6b66f8-6952-4450-d15c-08de71b55eb7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4198
X-Mailman-Approved-At: Sun, 22 Feb 2026 07:59:29 +0100
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


On 2/20/2026 2:45 PM, Neha Malcom Francis wrote:
> Add config fragment support for enabling inline ECC and/or BIST on TI K3
> supported platforms.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
> Typically we do not enable these configs by default but would still like to have
> the option to start building them in our default build flow for testing. Also
> there is the added advantage of users being able to see what is needed in case
> they choose to enable these features.

Can these fragments exits together ? , if yes then one config fragment 
should be ok


>
>   configs/k3_bist.config       | 1 +
>   configs/k3_inline_ecc.config | 1 +
>   2 files changed, 2 insertions(+)
>   create mode 100644 configs/k3_bist.config
>   create mode 100644 configs/k3_inline_ecc.config
>
> diff --git a/configs/k3_bist.config b/configs/k3_bist.config
> new file mode 100644
> index 00000000000..671dda1a9dc
> --- /dev/null
> +++ b/configs/k3_bist.config
> @@ -0,0 +1 @@
> +CONFIG_K3_BIST=y
> diff --git a/configs/k3_inline_ecc.config b/configs/k3_inline_ecc.config
> new file mode 100644
> index 00000000000..143c814b41c
> --- /dev/null
> +++ b/configs/k3_inline_ecc.config
> @@ -0,0 +1 @@
> +CONFIG_K3_INLINE_ECC=y
