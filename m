Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF86C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E374A82D32;
	Fri, 25 Jul 2025 14:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W7KFNhYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D43C683966; Fri, 25 Jul 2025 14:18:13 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFB0A805D7
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:18:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avgO9QSKAjU1GZX0fPEIJbmJ776ED17CcLli04CwxPqyzQbWFv3phD1B6GdgqCkBO+j8G7RSQ5inJ8BCbq9wr9iFZC/6hzoZD65lf1mwjVz96ZC8RWdKxiZ/5gBnJVjIGNnmMs8EYY0Fdy+U5xLA+AEgIaQPXorrH6SpQiRJ8L4mNjH0Q0pqiWnirq0qJfRSkOxmon13HGSVwOlpVCxBj2ig6Xzvezp3RQZ559+ZpDTD6T6a519DcCB84OJWnn+/kL3hmG9e+jWQ97Sjm1ml5uZqNZsy3SwSDYvUnLqPJIlTRL2QWJ0katUBpdqv1oznGBX57L+POiKxFF4z1YxOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XT6a/JbqTjGkfqTWRS7MQlu0w2YSIP0xV1tvUhCiofE=;
 b=GXBktwx0kOAzfr+hwp1Wx2C6nRO6zSeuVt3MHvcyEgnK2YGduStHr5rSsc3wJz5CC3K8/S8egOLgvkQlZEnvg2cxZuliBD5Z/4StQRlJ0ZUUDsigzagEQ59ZEdoeufQ4MTjS8xDGMbuzvhTkDoSRYVP2MZqGveEoA9wDeoFDgO4QwjCmwaguhxMU9/DK5ki2L32Ni8vF4zBBWBwpLNq8whAXzRoNLku+0FQq4DaSOMXgeXfAiWmnviqWQCOTxYoNCpwJ9RccUF9g8zwKCdj4aIf59D65/kp9msnpFl+jJGxBrZIRyg/XG6iVvEqFjOEPYOail68FzUk/9ce2AJyCiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XT6a/JbqTjGkfqTWRS7MQlu0w2YSIP0xV1tvUhCiofE=;
 b=W7KFNhYbiQD8iSLNntwzpg6F0CcW3LUqnEhhErQhAfgVAVlOpH1yALoxFA2rx2dkw6Ucm8qvvjtG6dCQTljlqYvrf8GhroLtE8bRMy4Hu3hsMcL7gFwx2AcA7wFRpbFfElW0Ufn+Kg45KUdJ1K1Pm7JVBNCEUhP9bbuv+Cc6W6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4236.namprd12.prod.outlook.com (2603:10b6:5:212::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 12:18:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 12:18:07 +0000
Message-ID: <5ccb25f1-c659-4511-953e-261ce32cfa74@amd.com>
Date: Fri, 25 Jul 2025 14:17:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] fpga: Remove ancient ACEX1K support
To: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1753442748.git.michal.simek@amd.com>
 <36c875d63ce340a56b71873460d56bb54675b42e.1753442748.git.michal.simek@amd.com>
 <20250725-doorknob-remodeler-a09f1a056ae7@thorsis.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250725-doorknob-remodeler-a09f1a056ae7@thorsis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0008.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4236:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e9207bc-9a97-484b-d488-08ddcb75502f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Nkswb1pOdU93ZzdSNmsvWGhKTFRrMm1MYkVPWEw2dkI5aEF2alRvQmtOblVT?=
 =?utf-8?B?T0pMT3cybzRZbXUzUzQ3LzJ3RHlGVm5xYkxPUDFKRzkvYWMyeG1IZXZWRjdK?=
 =?utf-8?B?aWE2OTdncXhFUkNTQXprcWZxSGY0bUo0SHFJK3hoN1VRcWszZnpOK3dIek0v?=
 =?utf-8?B?WmpyTkhOSmdubFdCZ3BWTnpOSTF2OExpR0N3anhwZURHWHNlZW53Skt0TFhy?=
 =?utf-8?B?SktucHArVS9GalVpR1gvSWd3Y0RacHJCSjVsT0RZUDhlRjBtZWdud2QvOThN?=
 =?utf-8?B?NmhJTndMeUVnWWs1VzgvbGhwdy8zTSt2alBmVEppT1RkT1RGdGplVHJsWWNM?=
 =?utf-8?B?QzJITm91OVJGd1RvYmxnZXkwM3pSK2k3dU9Mc25YRUpPZjBtbXh1Z0dkeHZy?=
 =?utf-8?B?TjdEUkNyNVJiY25uTTgzMUwrOE9LNnNQOXBFQ3JrZVVaTzlVSWRsOGVyZVpY?=
 =?utf-8?B?NTFrWTBDcEFZVC9GaUV6aXR3VmdsK0FmVkcxYnREQzlKWnJVV25UMFlqTkw0?=
 =?utf-8?B?K3ZxVXJmT1V4NU8zeWNucTdQQmtoTUllLzJlNFNWT0Jjb25Qa1U5a3J0VFRE?=
 =?utf-8?B?bU9ScG41ZHBkS3dubkJpSGxIUmYrMlYvVUFXa0FHa2tuaVFEdEU4Si9iczJv?=
 =?utf-8?B?a2wvMG5LNHNyN3FRczh1YU9GTzhUa3dXalA4RkpZc29mSHZGcGYzZ0p5YzBO?=
 =?utf-8?B?NC9rcXppSHVQcXVQaGdUWkwxdlJRT3dubzRPOWVNVG1YOGt5WU1VcTRKZit5?=
 =?utf-8?B?V2tLOHU0TjJQRlNVZlNlZms0MWFPUHp5NmxnWklVVkx4R3hOUXlBQ3JvYlU0?=
 =?utf-8?B?R0w1SXpVNFdHcStINFJaajEzQW1HaXVkWFN3YXJMRTI5d051RjFNNVNNa0NG?=
 =?utf-8?B?S1M3RFQxbTdPY1dJVFpVRExRL0ZNS3RlU2JxSWRSd3lNdWpyWExFS1pySkdE?=
 =?utf-8?B?Y3g3NU1qZkJBb1RzNFZka1pPanpxK2lCcEdvUkRhQnBQbnhCbVcwTFdwS0I5?=
 =?utf-8?B?SWl6SWNqa2svTTUyMnphZE9HVXpsWTdjSkpwOFZHdEIvMndoUWcxUjlORDJB?=
 =?utf-8?B?YmI3T3hHVW5OWVJPM0tsSlNkbUhOVERpaGx6MEpSVG1xVDhma0Job2JkcUJ5?=
 =?utf-8?B?a1Y5eGMxN2dDUm9Sd3d3RVFCd3pkQTEyTFpYb21nYklDZ2NNWHhrc3AwVVhx?=
 =?utf-8?B?enRITUkycTJTNEJVQUF4RlRSYXZqSWlBbkhRd2didktrZTV5c3h2OE8zTUxP?=
 =?utf-8?B?bXBwT1N6dGNqR0FnZWpFSmZ3YUROeTF0M2Y2Y1RrZXV1R08yUUYyazAxa2NN?=
 =?utf-8?B?OTVBZ3d2U1VxVkFKVUhEQWp0cS82ZzUvMnQrQTMvenJNRWxacnRXTTBSR3pr?=
 =?utf-8?B?dkhXTlZOTng0SEtuaDY1amtUYXlUN2M2Mk92SDlnMFZjQXVhQjB4Q0RpQndK?=
 =?utf-8?B?T1YraHZWN05GSHhNbUNWajYwUUh1NVlHUmU5YmJjem5aTGV2QTFZb3FyTGFM?=
 =?utf-8?B?MzVPdXp6ZSs2VFprUjgvT0RRZUxUajJ3TENYK09UUHdWeWlzRzV6eS9jYlla?=
 =?utf-8?B?MGhZNUx1UzY5U0lOVld1SDc2bGdZOHFFcGhJZzFNOFpxM0VDdjlNRitJM1Z1?=
 =?utf-8?B?WWxrZFBQMFZBWFFUbjRBc0tVQzdVMzArRWFFVFdDejA1SEwyV055ZWRFQ1JX?=
 =?utf-8?B?OXlMbVpjZjZMOWZqZ3ZNdmlpNVJQaE5OcXRRVmE2UmJzS1NLbGxLYjBQWFRP?=
 =?utf-8?B?NUx0L01vOHJidU5nVW1YRUZYVEpGU3A5dHRlbDBGNlFGN1pOeHAvekFxWW4w?=
 =?utf-8?B?NFF2RkRoeEtabGhxMUV0M2t6M3ZBRXlnYU52L0V1clR6Wk1NQUVYUC8yclVB?=
 =?utf-8?B?eWtlMXlDM25Hei9TOGRPMkpjUXllTXFHaUVEZ2VJd1NGdHpHZ3lhRUtleEx4?=
 =?utf-8?B?Ni8wa0s0MEdhdXlvaHI0V3BLNWJhYlh6SDE1SW1ka2U4R3NHSHVCVmxZMG8x?=
 =?utf-8?B?dU5ucGRUcWtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020); DIR:OUT; SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTkwR21sUk80dUplRlNDQWUzQlo5TnRVUVNLeHhNeENlZFVqeSt3Y3dhRXpo?=
 =?utf-8?B?WlpxNXgxUXBhTW5jRDMzZU1IRlVrckJPbENscW5PT0djSVFtQXNsdGVmSUVz?=
 =?utf-8?B?aXpRNzhiSFFkOGl5UTdpV01IaWxYR1F4dG9jQ29CTmxBdyszaThPK2hGYW9a?=
 =?utf-8?B?QkNWTnppbXVoNTg4cmpFUmdHUXN2OGxxOGI4QS9sODdaS3FodUlmRFB1T3ZI?=
 =?utf-8?B?OENpVGZONFIrckxiMTJFdkFQQVpnSjBuTlptRWxVT2hFTGJGWlZBL1lBcEp5?=
 =?utf-8?B?ZzNqUCtOSnBrVW9HUFBYL2gyMldnRDV6alhjbVVFNUpEU0NYcWUzZEEvRVNC?=
 =?utf-8?B?ZzZOd2k1WmQ0dExvb2RmSWVHTUhXSG4wVE01Z0ljNi9Oa1pEcENiYVpuK1Zl?=
 =?utf-8?B?b0I5OG92djg4TjJSMTU5L2F3TWxPaVRyenlTVStCRVJ5eHpVUXlNbFNZNWto?=
 =?utf-8?B?ei9DZkdyYUNRam9Td01sQUVvQUZEUGVhRUl3MjdQNEkydXVaYU91QlNPcThj?=
 =?utf-8?B?S3RNL2pyZHJucVJ0NHl6aWJIUDVqMWVYTWpacE5SSWxpQ3lQWmtvY2dJK0hE?=
 =?utf-8?B?QUprcTUyMFJqWDNCK3k3ejZmWmVESVJrNzNCUUM0enVNTkU3N0NQaHlxUzh4?=
 =?utf-8?B?dUdRQVpTSVNKcGVlQkM4dnZQLzJGcmVHY3ZKaW5HcDRpcVdDRTYzQ3hkTzBz?=
 =?utf-8?B?TWtzcWdjeVV4K2svRlcxMmVqbjI5ck4wN2ZYQXVkSUhZaHM2VnhWV0cvSWo5?=
 =?utf-8?B?N1RGK2YzeU9sWm5yV2JpTEM1SWJRQmdETjhtaWFhS1hQanFaSUVybW5ucmpL?=
 =?utf-8?B?bVVSS3l4SlByRGRvY3lhZmk3OHdSdDJrNWZQaWpIY3RsU1dDWUVLVFJqQXlD?=
 =?utf-8?B?QzZLbTE4dnlkSFRMaFBHYXM1L3BQNGQ1TDF1b0pRVkhLbmxQb3FpcmRKcjMv?=
 =?utf-8?B?UEVjSm5KWkJCbC9XeGVmanBXb2tKTWNqc09sTTRjYmlmdXdzQTQ4TllBQ2dT?=
 =?utf-8?B?aHoxSXpiSFh0K0kwcjBieEE3L05Xam04aEpjQTdrMGJLZjdDK2l2SGpmT0FX?=
 =?utf-8?B?QXl4TStvNkplTmwxZXBxNVppekg2Z1RyMWVhNVllVUFRQW4yZkh4cXFkK0JM?=
 =?utf-8?B?bVYwRjQvNnMzY1dyZHc2YWJkYWdSV0syZGowK1NLZEMrZGxrZXY5WGtwYXNv?=
 =?utf-8?B?eWJpNXBYT1I2bWVVQngxZEJLMHdCOHl5N2VqZUFjZ3lXV0U3blNZL3BId0xh?=
 =?utf-8?B?TjF4Ti9Cem5TRENPcGd4bytiSEpQaUh3c1F6STBLYVJTaDBiR0gwTTdWd0FO?=
 =?utf-8?B?QmxHdnIxdlh5aVlqdUtvWFdsTVNJRmJnS0YxcmJiOGJ3WjhzVHBBeUZMWWpt?=
 =?utf-8?B?UHcyK2grZStRaEM2QVFlOU9KY2FHWjJsOFBycXpTVVNWUHlMZHNseFQ0OFJr?=
 =?utf-8?B?ZVl2MHFoT0U0aDVaSWJXMDlnekhFNlhQYytsNlRtV202N0ZCa0t4dnRnMVVi?=
 =?utf-8?B?Zng5RFI5K0NQYjdYOUVMeHR0d0pnT0YxRVhKL1dpUWJ0WUo1WmFZOGFxdDY5?=
 =?utf-8?B?cFA5Tk5Rdm5WZkgwVWRrenlHSm9PeEdxUDRBTVJpM3VYRUgxZVMvaUErWHhN?=
 =?utf-8?B?a1JIOS8rSUwvYzlDV2psRmpTZ05zRmc3UTVnaStWVzd4blRhdzJjYTB1Q3NY?=
 =?utf-8?B?YUUvcjJuSEdIY2djWFZmcE56Y2ZFQXY3WVg5MFhNcDR3VW9PcEVuYkFGbjJT?=
 =?utf-8?B?VUs2a3I4VS80TnRlaGlkVDZCR3Y4NXQzR0ZuaXRBQ01WMXBKK3BKdGdrMEhS?=
 =?utf-8?B?SlluYVM3SVhnSXA1elc2cDlQWm5MZjRBYmVCRGJRcUpCRGlNNWpMeWQ4cFho?=
 =?utf-8?B?cU1qRXZjc0xlbmVkdktRTWFkRlJRWVNYblJQcUFBWm50dW8yQzE5dE5zQVI5?=
 =?utf-8?B?MXJMbGMxcFV1ejVJV3JXV0dTMkgrMkZaOHM1aERRcVdNdVRycmFYNVcrSStL?=
 =?utf-8?B?dUVGVGFnMFloS2EyNC9ucnREWjE5WVNiZFcwZXdONkpwNWJSV0NZTUI2Lys2?=
 =?utf-8?B?OU96VFRPZEVyUURBMUdJa2RhbUhpbkhmS0k4eFBpbHNucmVGOU5GRUp1dDJF?=
 =?utf-8?Q?0ZdLIFQfvQeAKNhZLDhLw15nq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9207bc-9a97-484b-d488-08ddcb75502f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 12:18:07.4835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dVvHGHjfmR95t5ZdSdxbj1SK4zVIuiRwcQZkKkI53WAdTxsnTUxrCVENUougjZow
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4236
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



On 7/25/25 14:10, Alexander Dahl wrote:
> Hello Michal,
> 
> Am Fri, Jul 25, 2025 at 01:25:53PM +0200 schrieb Michal Simek:
>> Coverity (CID 583149) reports issue on code which is not enabled by any
>> real platform that's why remove it completely.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
>>
>>   configs/sandbox_defconfig |   1 -
>>   drivers/fpga/ACEX1K.c     | 245 --------------------------------------
>>   drivers/fpga/Kconfig      |   6 -
>>   drivers/fpga/Makefile     |   1 -
>>   drivers/fpga/altera.c     |   5 +-
>>   include/ACEX1K.h          |  49 --------
>>   6 files changed, 1 insertion(+), 306 deletions(-)
>>   delete mode 100644 drivers/fpga/ACEX1K.c
>>
>> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
>> index 0c030f4a7925..96546cc0bcfe 100644
>> --- a/configs/sandbox_defconfig
>> +++ b/configs/sandbox_defconfig
>> @@ -206,7 +206,6 @@ CONFIG_ARM_FFA_TRANSPORT=y
>>   CONFIG_FPGA_ALTERA=y
>>   CONFIG_FPGA_STRATIX_II=y
>>   CONFIG_FPGA_STRATIX_V=y
>> -CONFIG_FPGA_ACEX1K=y
>>   CONFIG_FPGA_CYCLON2=y
>>   CONFIG_FPGA_LATTICE=y
>>   CONFIG_FPGA_XILINX=y
>> diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
>> deleted file mode 100644
>> index e1514fc56d04..000000000000
>> --- a/drivers/fpga/ACEX1K.c
>> +++ /dev/null
>> @@ -1,245 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0+
>> -/*
>> - * (C) Copyright 2003
>> - * Steven Scholz, imc Measurement & Control, steven.scholz@imc-berlin.de
>> - *
>> - * (C) Copyright 2002
>> - * Rich Ireland, Enterasys Networks, rireland@enterasys.com.
>> - */
>> -
>> -#define LOG_CATEGORY UCLASS_FPGA
>> -
>> -#include <config.h>		/* core U-Boot definitions */
>> -#include <console.h>
>> -#include <log.h>
>> -#include <ACEX1K.h>		/* ACEX device family */
>> -#include <linux/delay.h>
>> -#include <time.h>
>> -
>> -/* Note: The assumption is that we cannot possibly run fast enough to
>> - * overrun the device (the Slave Parallel mode can free run at 50MHz).
>> - * If there is a need to operate slower, define CFG_FPGA_DELAY in
>> - * the board config file to slow things down.
>> - */
>> -#ifndef CFG_FPGA_DELAY
>> -#define CFG_FPGA_DELAY()
>> -#endif
>> -
>> -#ifndef CFG_SYS_FPGA_WAIT
>> -#define CFG_SYS_FPGA_WAIT CONFIG_SYS_HZ/10		/* 100 ms */
>> -#endif
>> -
>> -static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize);
>> -static int ACEX1K_ps_dump(Altera_desc *desc, const void *buf, size_t bsize);
>> -/* static int ACEX1K_ps_info(Altera_desc *desc); */
>> -
>> -/* ------------------------------------------------------------------------- */
>> -/* ACEX1K Generic Implementation */
>> -int ACEX1K_load(Altera_desc *desc, const void *buf, size_t bsize)
>> -{
>> -	int ret_val = FPGA_FAIL;
>> -
>> -	switch (desc->iface) {
>> -	case passive_serial:
>> -		log_debug("Launching Passive Serial Loader\n");
>> -		ret_val = ACEX1K_ps_load (desc, buf, bsize);
>> -		break;
>> -
>> -		/* Add new interface types here */
>> -
>> -	default:
>> -		printf ("%s: Unsupported interface type, %d\n",
>> -				__FUNCTION__, desc->iface);
>> -	}
>> -
>> -	return ret_val;
>> -}
>> -
>> -int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize)
>> -{
>> -	int ret_val = FPGA_FAIL;
>> -
>> -	switch (desc->iface) {
>> -	case passive_serial:
>> -		log_debug("Launching Passive Serial Dump\n");
>> -		ret_val = ACEX1K_ps_dump (desc, buf, bsize);
>> -		break;
>> -
>> -		/* Add new interface types here */
>> -
>> -	default:
>> -		printf ("%s: Unsupported interface type, %d\n",
>> -				__FUNCTION__, desc->iface);
>> -	}
>> -
>> -	return ret_val;
>> -}
>> -
>> -int ACEX1K_info( Altera_desc *desc )
>> -{
>> -	return FPGA_SUCCESS;
>> -}
>> -
>> -/* ------------------------------------------------------------------------- */
>> -/* ACEX1K Passive Serial Generic Implementation                                  */
>> -
>> -static int ACEX1K_ps_load(Altera_desc *desc, const void *buf, size_t bsize)
>> -{
>> -	int ret_val = FPGA_FAIL;	/* assume the worst */
>> -	Altera_ACEX1K_Passive_Serial_fns *fn = desc->iface_fns;
>> -	int i;
>> -
>> -	log_debug("start with interface functions @ 0x%p\n", fn);
>> -
>> -	if (fn) {
>> -		size_t bytecount = 0;
>> -		unsigned char *data = (unsigned char *) buf;
>> -		int cookie = desc->cookie;	/* make a local copy */
>> -		unsigned long ts;		/* timestamp */
>> -
>> -		log_debug("Function Table:\n"
>> -			  "ptr:\t0x%p\n"
>> -			  "struct: 0x%p\n"
>> -			  "config:\t0x%p\n"
>> -			  "status:\t0x%p\n"
>> -			  "clk:\t0x%p\n"
>> -			  "data:\t0x%p\n"
>> -			  "done:\t0x%p\n\n",
>> -			  &fn, fn, fn->config, fn->status,
>> -			  fn->clk, fn->data, fn->done);
>> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
>> -		printf ("Loading FPGA Device %d...", cookie);
>> -#endif
>> -
>> -		/*
>> -		 * Run the pre configuration function if there is one.
>> -		 */
>> -		if (*fn->pre) {
>> -			(*fn->pre) (cookie);
>> -		}
>> -
>> -		/* Establish the initial state */
>> -		(*fn->config) (true, true, cookie);	/* Assert nCONFIG */
>> -
>> -		udelay(2);		/* T_cfg > 2us	*/
>> -
>> -		/* nSTATUS should be asserted now */
>> -		(*fn->done) (cookie);
>> -		if ( !(*fn->status) (cookie) ) {
>> -			puts ("** nSTATUS is not asserted.\n");
>> -			(*fn->abort) (cookie);
>> -			return FPGA_FAIL;
>> -		}
>> -
>> -		(*fn->config) (false, true, cookie);	/* Deassert nCONFIG */
>> -		udelay(2);		/* T_cf2st1 < 4us	*/
>> -
>> -		/* Wait for nSTATUS to be released (i.e. deasserted) */
>> -		ts = get_timer (0);		/* get current time */
>> -		do {
>> -			CFG_FPGA_DELAY ();
>> -			if (get_timer (ts) > CFG_SYS_FPGA_WAIT) {	/* check the time */
>> -				puts ("** Timeout waiting for STATUS to go high.\n");
>> -				(*fn->abort) (cookie);
>> -				return FPGA_FAIL;
>> -			}
>> -			(*fn->done) (cookie);
>> -		} while ((*fn->status) (cookie));
>> -
>> -		/* Get ready for the burn */
>> -		CFG_FPGA_DELAY ();
>> -
>> -		/* Load the data */
>> -		while (bytecount < bsize) {
>> -			unsigned char val=0;
>> -#ifdef CONFIG_SYS_FPGA_CHECK_CTRLC
>> -			if (ctrlc ()) {
>> -				(*fn->abort) (cookie);
>> -				return FPGA_FAIL;
>> -			}
>> -#endif
>> -			/* Altera detects an error if INIT goes low (active)
>> -			   while DONE is low (inactive) */
>> -#if 0 /* not yet implemented */
>> -			if ((*fn->done) (cookie) == 0 && (*fn->init) (cookie)) {
>> -				puts ("** CRC error during FPGA load.\n");
>> -				(*fn->abort) (cookie);
>> -				return (FPGA_FAIL);
>> -			}
>> -#endif
>> -			val = data [bytecount ++ ];
>> -			i = 8;
>> -			do {
>> -				/* Deassert the clock */
>> -				(*fn->clk) (false, true, cookie);
>> -				CFG_FPGA_DELAY ();
>> -				/* Write data */
>> -				(*fn->data) ((val & 0x01), true, cookie);
>> -				CFG_FPGA_DELAY ();
>> -				/* Assert the clock */
>> -				(*fn->clk) (true, true, cookie);
>> -				CFG_FPGA_DELAY ();
>> -				val >>= 1;
>> -				i --;
>> -			} while (i > 0);
>> -
>> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
>> -			if (bytecount % (bsize / 40) == 0)
>> -				putc ('.');		/* let them know we are alive */
>> -#endif
>> -		}
>> -
>> -		CFG_FPGA_DELAY ();
>> -
>> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
>> -		putc (' ');			/* terminate the dotted line */
>> -#endif
>> -
>> -	/*
>> -	 * Checking FPGA's CONF_DONE signal - correctly booted ?
>> -	 */
>> -
>> -	if ( ! (*fn->done) (cookie) ) {
>> -		puts ("** Booting failed! CONF_DONE is still deasserted.\n");
>> -		(*fn->abort) (cookie);
>> -		return (FPGA_FAIL);
>> -	}
>> -
>> -	/*
>> -	 * "DCLK must be clocked an additional 10 times fpr ACEX 1K..."
>> -	 */
>> -
>> -	for (i = 0; i < 12; i++) {
>> -		CFG_FPGA_DELAY ();
>> -		(*fn->clk) (true, true, cookie);	/* Assert the clock pin */
>> -		CFG_FPGA_DELAY ();
>> -		(*fn->clk) (false, true, cookie);	/* Deassert the clock pin */
>> -	}
>> -
>> -	ret_val = FPGA_SUCCESS;
>> -
>> -#ifdef CONFIG_SYS_FPGA_PROG_FEEDBACK
>> -		if (ret_val == FPGA_SUCCESS) {
>> -			puts ("Done.\n");
>> -		}
>> -		else {
>> -			puts ("Fail.\n");
>> -		}
>> -#endif
>> -	(*fn->post) (cookie);
>> -
>> -	} else {
>> -		printf ("%s: NULL Interface function table!\n", __FUNCTION__);
>> -	}
>> -
>> -	return ret_val;
>> -}
>> -
>> -static int ACEX1K_ps_dump(Altera_desc *desc, const void *buf, size_t bsize)
>> -{
>> -	/* Readback is only available through the Slave Parallel and         */
>> -	/* boundary-scan interfaces.                                         */
>> -	printf ("%s: Passive Serial Dumping is unavailable\n",
>> -			__FUNCTION__);
>> -	return FPGA_FAIL;
>> -}
>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
>> index 9456ca3149ae..18e7d7c99a9a 100644
>> --- a/drivers/fpga/Kconfig
>> +++ b/drivers/fpga/Kconfig
>> @@ -34,12 +34,6 @@ config FPGA_STRATIX_V
>>   	help
>>   	  Say Y here to enable the Altera Stratix V FPGA specific driver.
>>   
>> -config FPGA_ACEX1K
>> -	bool "Enable Altera ACEX 1K driver"
>> -	depends on FPGA_ALTERA
>> -	help
>> -	  Say Y here to enable the Altera ACEX 1K FPGA specific driver.
>> -
>>   config FPGA_CYCLON2
>>   	bool "Enable Altera FPGA driver for Cyclone II"
>>   	depends on FPGA_ALTERA
>> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
>> index 610c168fc35c..6c779d5b5df6 100644
>> --- a/drivers/fpga/Makefile
>> +++ b/drivers/fpga/Makefile
>> @@ -17,7 +17,6 @@ obj-$(CONFIG_FPGA_XILINX) += xilinx.o
>>   obj-$(CONFIG_FPGA_LATTICE) += ivm_core.o lattice.o
>>   ifdef CONFIG_FPGA_ALTERA
>>   obj-y += altera.o
>> -obj-$(CONFIG_FPGA_ACEX1K) += ACEX1K.o
>>   obj-$(CONFIG_FPGA_CYCLON2) += cyclon2.o
>>   obj-$(CONFIG_FPGA_INTEL_SDM_MAILBOX) += intel_sdm_mb.o
>>   obj-$(CONFIG_FPGA_STRATIX_II) += stratixII.o
>> diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
>> index 64fda3a307c7..4a9aa74357ec 100644
>> --- a/drivers/fpga/altera.c
>> +++ b/drivers/fpga/altera.c
>> @@ -28,10 +28,7 @@ static const struct altera_fpga {
>>   	int			(*dump)(Altera_desc *, const void *, size_t);
>>   	int			(*info)(Altera_desc *);
>>   } altera_fpga[] = {
>> -#if defined(CONFIG_FPGA_ACEX1K)
>> -	{ Altera_ACEX1K, "ACEX1K", ACEX1K_load, ACEX1K_dump, ACEX1K_info },
>> -	{ Altera_CYC2,   "ACEX1K", ACEX1K_load, ACEX1K_dump, ACEX1K_info },
>> -#elif defined(CONFIG_FPGA_CYCLON2)
>> +#if defined(CONFIG_FPGA_CYCLON2)
>>   	{ Altera_ACEX1K, "CycloneII", CYC2_load, CYC2_dump, CYC2_info },
>>   	{ Altera_CYC2,   "CycloneII", CYC2_load, CYC2_dump, CYC2_info },
>>   #endif
>> diff --git a/include/ACEX1K.h b/include/ACEX1K.h
>> index 7c5253c66cca..44d1b9765657 100644
>> --- a/include/ACEX1K.h
>> +++ b/include/ACEX1K.h
>> @@ -12,26 +12,10 @@
>>   
>>   #include <altera.h>
>>   
>> -extern int ACEX1K_load(Altera_desc *desc, const void *image, size_t size);
>> -extern int ACEX1K_dump(Altera_desc *desc, const void *buf, size_t bsize);
>> -extern int ACEX1K_info(Altera_desc *desc);
>> -
>>   extern int CYC2_load(Altera_desc *desc, const void *image, size_t size);
>>   extern int CYC2_dump(Altera_desc *desc, const void *buf, size_t bsize);
>>   extern int CYC2_info(Altera_desc *desc);
> 
> Maybe CYC2_load() etc. can be moved to a different header file like
> altera.h for example?
> 
>>   
>> -/* Slave Serial Implementation function table */
>> -typedef struct {
>> -	Altera_pre_fn		pre;
>> -	Altera_config_fn	config;
>> -	Altera_clk_fn		clk;
>> -	Altera_status_fn	status;
>> -	Altera_done_fn		done;
>> -	Altera_data_fn		data;
>> -	Altera_abort_fn		abort;
>> -	Altera_post_fn		post;
>> -} Altera_ACEX1K_Passive_Serial_fns;
>> -
>>   /* Slave Serial Implementation function table */
>>   typedef struct {
>>   	Altera_pre_fn		pre;
>> @@ -43,37 +27,4 @@ typedef struct {
>>   	Altera_post_fn		post;
>>   } Altera_CYC2_Passive_Serial_fns;
>>   
>> -/* Device Image Sizes
>> - *********************************************************************/
>> -/* ACEX1K */
>> -/* FIXME: Which size do we mean?
>> - * Datasheet says 1337000/8=167125Bytes,
>> - * Filesize of an *.rbf file is 166965 Bytes
>> - */
>> -#if 0
>> -#define Altera_EP1K100_SIZE	1337000/8	/* 167125 Bytes */
>> -#endif
>> -#define Altera_EP1K100_SIZE	(166965*8)
>> -
>> -#define Altera_EP2C8_SIZE	247942
>> -#define Altera_EP2C20_SIZE	586562
>> -#define Altera_EP2C35_SIZE	883905
>> -#define Altera_EP3C5_SIZE	368011		/* .rbf size in bytes */
>> -
>> -#define ALTERA_EP4CE6_SIZE	368011		/* 2944088 Bits */
>> -#define ALTERA_EP4CE10_SIZE	368011		/* 2944088 Bits */
>> -#define ALTERA_EP4CE15_SIZE	510856		/* 4086848 Bits */
>> -#define ALTERA_EP4CE22_SIZE	718569		/* 5748552 Bits */
>> -#define ALTERA_EP4CE30_SIZE	1191788		/* 9534304 Bits */
>> -#define ALTERA_EP4CE40_SIZE	1191788		/* 9534304 Bits */
>> -#define ALTERA_EP4CE55_SIZE	1861195		/* 14889560 Bits */
>> -#define ALTERA_EP4CE75_SIZE	2495719		/* 19965752 Bits */
>> -#define ALTERA_EP4CE115_SIZE	3571462		/* 28571696 Bits */
> 
> Can we move these definitions for device image sizes to altera.h
> instead removing them?  I added some of those with commit 3b2a595fc659
> ("fpga: altera: Add some more device sizes") back in 2019, and I'm
> using some of them in downstream code/dts.

I expect you are also saying that these are Cyclone 2 related right?

No issue from my side.

M
