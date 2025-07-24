Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 711DBC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 07:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2AA983642;
	Thu, 24 Jul 2025 09:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F16bno4t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D611B83653; Thu, 24 Jul 2025 09:06:03 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFEE83641
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 09:06:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xK45jswq1J4f4X3tx3j1zss3GYSLL9FRpdh+ifgamzZvIfkxpaAs5a7cHoWErxFnjKDUmZYOwUPRGR++NyZ3y8mjkT3Q5laR9Q3jlY6XOMzU8Sins9wguHnnH7vwEQN2PoYrPhfPNolOgtspcf6Ytxq1OUzw94ynAkYlP/XFAnKv68f3RqOjNGCZ+EIp6J8qUNk9nQTwsW6jP9s3+SXyDmUQSbgUeLsHNGTBDb1alOE2Acm16wh+su3yq0MJVBwZ5mAzaiVJFsfSstd3hAl0MpA1D3b8/BEGUzFtJU8vSNjxwPtAga8R6qnHn1B9alAHR/IywwsOWGvOpVN8Kvr1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=shNziJ6/hRQTX8fnCIrXdXUHV5V1SSqojb9DVND0EZY=;
 b=BhrkisMbD8zv93LMpYPJo9u3cvLDvwC7M2wVb8cXUbcTUqozbGNAmFl6yiwL6oqc9+24/33q2Qsk59Nj67vNI9rDQ8nU1EXEL7HSyO6nSFkZEOvKx+5jBtfsXZ3Idn21lFi+RDEimKveFMcJxBXQpwMZOQl5j54Asd9Mm5P9bdNzQcGGNoA6UYqMtCqw1h2tuDbWYJtH1r6QrHlgOoXJMTLFva4olTVaRHjtmQ5+pu1GeciQOd9NmOfTbqRuPTtVUO8k14YcK2Glad0mEa2rSSjBQ2zAbkUkBsTKzadFMaxDi6eK0GYZ4n+P+E586anW2yeCEQE48BL3adqaXVgZ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=shNziJ6/hRQTX8fnCIrXdXUHV5V1SSqojb9DVND0EZY=;
 b=F16bno4tM3oEnePVLTDe6On1ZtXAVUBF5P1kC6rCHN8ZUsQLkwPLIbMRw+xE89riWh2R8SHGEqxxj/1uL3jbsGEsNDDlJmMqYspvWaVgYWI/0hWHOhs8xVhuSZI3zv22/CtE8+AFqLV3UBpSy2y2SbxjkOBmmcJT/4QzqkEdHSw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS2PR12MB9661.namprd12.prod.outlook.com (2603:10b6:8:27b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 07:05:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 07:05:57 +0000
Message-ID: <77c572f7-e7c9-4f06-8c5b-5e9338773b36@amd.com>
Date: Thu, 24 Jul 2025 09:05:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Let fit-dtb.blob generated all the time
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <c2952da3c064d67821cd166d2392db39c1d23b2c.1752822270.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <c2952da3c064d67821cd166d2392db39c1d23b2c.1752822270.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS2PR12MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ee2e62-9ef8-41fa-529b-08ddca808a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RThZQzhNZGNVdkJyMnlaM1Qzc3BlSE5YNjczTkxEL0hxQkw5RnZNRGdHY0Ji?=
 =?utf-8?B?ZVgyYmNBWFhnb1RxdjJzWVZySTRWdVZnNXVzbmYySGtLUm9BZk1IanJaRzZt?=
 =?utf-8?B?QWxJTUxxcENUaWRxYzNTQ2ZTSGFoR3dwcFNha08xSGtGNVo0UkFOUjdOaklU?=
 =?utf-8?B?TXNWU1N6aGlHdkt6WjBLaUZaTWswOHdOSnlWNmRScW1wQm14WGpkSmZiYi9W?=
 =?utf-8?B?VmlqZjZ6SFhZb1MyT3ZNSVdoK3R1R3F6QVNoSW9pQUV4U2M5aUxXS2lTL2pV?=
 =?utf-8?B?UEU2bENlemJPRWxqelZ5UVA1UFVzZ0hLYXg3K0pkcUJRUDY3dHFqWUhSeGZj?=
 =?utf-8?B?aGdCTnIvV1lpRllaUXZxOUlyUVFsTE56SjltbGNzNEJOTGVyZkYrSlNMWGd4?=
 =?utf-8?B?NkxEVGFBcmhqZTVWeC9pSUkvamtOR2Z6clJwcDZSYUFKY3IrbmFYT0l3MGs4?=
 =?utf-8?B?cG5hcE1sU0FnODNFZm1rQ0h4YXRqZDg5S29hZXBpVFpPZWtxSDN2YlJicHYw?=
 =?utf-8?B?eXFtQytmSVJZKzVGQlAxZjd2QUwzbXJMME1jTkJxclRDMm02K1pPT2cxaVpz?=
 =?utf-8?B?ZzJaam50bk12WWdzVHJHcUxuL1pubWFHMlYxaDFUQXdONUtKRnA5YzR4cXRN?=
 =?utf-8?B?N25OM05va29DODgwQk1Majd5dEdRbytHcjVTWTNuVG1pOXFxbFJxVnkwSmdl?=
 =?utf-8?B?YUJRc0pqT2xDclM0QnhESlhlZHBINTdNSlFady92T0JxMEFmb1hlRlFOZFov?=
 =?utf-8?B?L0JBVllROWI1ZGZIYW1XcDBpTkk2Y2FNVWxxUzFxakovN2hvS0dGWmhZWmgv?=
 =?utf-8?B?RXdwMVhqR1pqNk1tYzB4VVpLbG5sR3AzenpBOUJoaWVDTFJySWkveFA4d21t?=
 =?utf-8?B?WXZ1a09Bd25TZzlWcHFEMW5jM012c01KeFkyaVBDanQ2UHhyQ0h1cGJCamtG?=
 =?utf-8?B?QnJpOEV2QUU5Sk1yVkYxWFk0TWdCWFJVTml5N1ljVklQUUJsNXZsWC9RUEw3?=
 =?utf-8?B?SzlEb1dUTzdXYzdnT1VmRGJNN21NWlpraERsQStYQWdtbDBabG1lU0c5YWw0?=
 =?utf-8?B?Q1JxSTlvUnZZOGQxREljU1d6TVFlV09CR0Y2RlZhTEJ5eFZPZVN0eDJsRUtk?=
 =?utf-8?B?K0xrVTVqcTRlZ1k4TVBvKytuNWhxeFVMSkxrMzRNdW56VU5pTWN5OU03QVN1?=
 =?utf-8?B?UmJnVGtKRnpZUHBnQkxHSXFGVVNTNkMwbVNFZWV3Q3NFNWMyL2R0MmRaOEFx?=
 =?utf-8?B?TnJjNGdSSUJDZW1zcjlrKytodGpHWmxvcXJZYW1ST1NMalVyQ2d1MEdDVHBn?=
 =?utf-8?B?bUtPUlZTcFJNd2dGajBmQXh3SDM4bVhXU3RPSjJrUk9RZjhyK3c1ZEV2UFJr?=
 =?utf-8?B?MlVCbGhrMmZhNG91V3BBaUFLU3N3aXRNK2s5bGdab3I0VDZ6ck9vSm95UTd3?=
 =?utf-8?B?SXdzSWd0Q0pHR3ozczhNV1FPVUtjL3RtZWd5cVFDR09YSmd3TXRRT0pwZERL?=
 =?utf-8?B?NlFGOEs0UHozbGdhK2libHdzMXExL2lOQk1PWGxDVUxJOHJ4aWoyeVFBL3Uz?=
 =?utf-8?B?TncrYWx4TTdDS2RLK0JoWSt1bU8zOGtzME1lTXFLT3YwSTR0eitYNVF1T3FE?=
 =?utf-8?B?ODNzRWY2MjV3WlJsaGRFUHg2R29SSzBGcSttYVJqWWhQVWVTaVl3Y1Z6Slhj?=
 =?utf-8?B?cXRXYnhpV1g0S2l6Y2RwbmE0R044cDZsZzZUZkt5RDRqaEcwdDJXOU5iQkg4?=
 =?utf-8?B?bVRGSlhRT3l1bldxVENjZ0d2RndPTDVQc250allNMUhHdDNQRHhIeDNSS0Zs?=
 =?utf-8?B?YVVDZmRzaURpaFNQS0NWaUhyMnFVN2hHOXpDbDBBK0R0SEU0R0ZUQkRtdzdZ?=
 =?utf-8?B?azJJVEFoM3JFMkJNc3JUdTREZzUzZUp1MDZ3SE5mcEtKZDdvUDRyKzRVS1Zn?=
 =?utf-8?Q?BkTJ1cM5Zbg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRnK2pHblpzbENPcTdIUlpMV0EzRHB5Wk13V0xyZWZDdjltNVhjT3BockdE?=
 =?utf-8?B?aHNFSFIzYVRYalR6TGN6SUF4TkQ3WUlpckV0Vi9hdkRsOEZFaXJJMDlhd3NL?=
 =?utf-8?B?enk5cndhcW4wVm41QmJHcVV3WlhTNk5GNlN6dFcybWQ3QUk1eXJUZHV3K2VP?=
 =?utf-8?B?ZXNJSXhUcEFtWHI3MGkzam9YTGlyNUkwaEd2dkg0QmFKUXhxVmtaMExJN0ky?=
 =?utf-8?B?RlJkUjQ4QWJlVzdPeGMvekFnVFBZM1JaQWR4Ly93QTh6YkdQaWpHVGw4RFRl?=
 =?utf-8?B?bGhXaDhNZENmemFmTVNKWnkwY1lpYisrQUV2WGtpUXNUVnhheCtkbGJ2djd1?=
 =?utf-8?B?emsxSHNEK0piZDNRVi90czhjYkllMkJwSHVQQW1WQUcxR01uNGQ4R01IOW5T?=
 =?utf-8?B?NnRiclBVZzF0YkpaN2haNEFsd3U2RHlVd3h3WmRuQjF0RkRXVkF3K3N1ak1F?=
 =?utf-8?B?UmV2em9tNUhxaTBPbmJKcXRVSHprVWdrb3hGODV4d2Yra1RBV1UrbmFuSTN6?=
 =?utf-8?B?R2F2QUJCTzRsSkFyOEdZWWdrMWJyelQveGZVQSsyalcwbHFTMnl4ZUp6RU9O?=
 =?utf-8?B?R0QwY0VxNWpQT0tBVDZIb3dmdTNNUENVNCtVRkltYTJUS2hvZHU0OHlaYnlu?=
 =?utf-8?B?bGIvVy9TSk9WMElSUWpvNUFOT2pVU2VISGd3ZDJISW83SHR5SFZZSVNwSFk1?=
 =?utf-8?B?QlEzdndmTm8wekhlYWpyM0ZGbTNQbGFpbHE4d01FRS9Gak8xYU1NVVVCRmk3?=
 =?utf-8?B?MStlcW52VGNDVHR2VkQxdFBFN1FINm5LbVFzb24wRWs2aC9wd3JVbUx1ay9C?=
 =?utf-8?B?RUp5bmJJVzI3TDVrOENJTWpqdXNtRUF6eU1uRThKemNXZ2JEbHZMMFpKN0w1?=
 =?utf-8?B?OG1MeUxaOEk1b3dnR3YwTEI5UnlmdGNob3kvb2VRQ2pSUE9IWFVUN3NBQUhQ?=
 =?utf-8?B?bFc1aXViSVh5VnYwMGV0NVZJQmdDb0cxSWpsdll3OU9YMFhVS2ltQkdmWEFy?=
 =?utf-8?B?bGQzMFRjc3J4RDZBeGFBdDFGSENReW9IN0VQbFhBdlVWTzh4OHRwSW9HOHpz?=
 =?utf-8?B?NjdMdDlaZm95VzNOdmk0Ym1ma24vRFhXQzBIQnd0STdSTXltZlhqa0ZHZDRO?=
 =?utf-8?B?RnV3MjJ0cE5PNUh3YWRmdmUxbFoxYTY5aVFuRWV3NHgwMm5zNmlZZDlXS3p0?=
 =?utf-8?B?eXhockx5Mm5RbHVTUWxIUUNPaC9IazFCSE14dGJRbW5pNWFmK3kzNlBkTzFY?=
 =?utf-8?B?aXZQTHVwQUhwbGFnbnZYMS9ZWmJQaWtORjRlNjZwVVJvNHd4eVdlVGVVcHZG?=
 =?utf-8?B?aDVvSUd5d25laDJiVkpJUzNjSW5vZ0drajg4Y1Z4NnBnN1EzOWcyOGpuOEMy?=
 =?utf-8?B?b1pKZmtjak9kT0RPUEh5b3d1dDdVUGhJMG9YOVd0eDJ3dmZyNmYwZDdkOE0y?=
 =?utf-8?B?dUxDTWdoV1BCdHJPaE0zd0ZXZnlFOC9TN3lVN2F2NkFCUDllQ3RZdkdtME0v?=
 =?utf-8?B?SGRjVi9WK2gzNHV5TTZoaVc3NjZveldrQlM4ZlZDeUdFN0k1eGV4U29PalV4?=
 =?utf-8?B?aGd3ODB3L3pMUlFWbXRkTzA2T0xUd1hmMms1MEUzZE4yVDl0UFNyeGxLNHRK?=
 =?utf-8?B?YTd0alFjYVRHUC9UaGZFenBja3RFb2twV05jMjkzRENFODhqcThIb3ljSUlE?=
 =?utf-8?B?TEZXT2xJeUhEWkNIL250cDZkcytEK29DWXk2OFhSdFhJbVFYZjdaUVl1bmNj?=
 =?utf-8?B?QnNPRUFOcllCTGRlcUpDaEJGcnR1QUhDVzNvT2ZkcHNxWkhHdU8ybnB6czQy?=
 =?utf-8?B?aFpETU00RW1lNjZaQVpuekN2V3FNUmc5b3o4ZU5HL0thNm5PVGRpaXNSeUZl?=
 =?utf-8?B?cFBuaUh6dnpZejFick1YNWNOanA0c0xTWm1nVmxJUTdUWDZ1TlVNOUFtMUs4?=
 =?utf-8?B?NjZiZWM1M3RiREJBbTllaEpxZzNFM1RFU0VuWWo3cWt2b1ZJTHh6U1JIZ2xp?=
 =?utf-8?B?cVZyWVdqNUhPVGwrbytGdXlQeDAxcGdvWFJDZTN3d09jejhyVGNLUGJQZUFh?=
 =?utf-8?B?Qnc3SmJpMDVWZ1E5R2diWTg5c25OQ3JMUWJNcEZnMlhQVHhtSWtGTCtkR202?=
 =?utf-8?Q?7oowleM7wkcNz6v408ySBczKR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ee2e62-9ef8-41fa-529b-08ddca808a19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 07:05:57.9126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmiuteIvIcLiUFlZUhILuNGD7ktgj4h9EMHAYwGYR0y5JQbMlHwRCOgFmo2pJR0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9661
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



On 7/18/25 09:04, Michal Simek wrote:
> There is a value to generate fit-dtb.blob even for cases without SPL
> because flows with FSBL also require it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-binman-som.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
> index a70123feeadd..469b94bbde60 100644
> --- a/arch/arm/dts/zynqmp-binman-som.dts
> +++ b/arch/arm/dts/zynqmp-binman-som.dts
> @@ -20,7 +20,6 @@
>   	binman: binman {
>   		multiple-images;
>   
> -#ifdef CONFIG_SPL
>   		fit-dtb.blob {
>   			filename = "fit-dtb.blob";
>   			pad-byte = <0>;
> @@ -109,6 +108,7 @@
>   			};
>   		};
>   
> +#ifdef CONFIG_SPL
>   		/* Generation in a static way */
>   		itb {
>   			filename = U_BOOT_ITB_FILENAME;

Applied.
M
