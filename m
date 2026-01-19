Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77718D29C5F
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 18:48:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C92848313B;
	Mon, 19 Jan 2026 19:48:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7dB9TSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D215C8389A; Mon, 19 Jan 2026 19:48:27 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0CF8003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 19:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Br+kYZyCpkPIm9lJr6v9V1TweSPcwRHxJW/u6lAXsLSSiW53lD0K/t+cn+5Mv2HXV6Uq25VewEtxM19sL1FEqYJXtTfqNv7Kwgs+up3R6axAxVVLh9gfWc3nPjmla7jeiuWtSZqCJmx9luEYjupEad3f50AidNTk712zXmt4grzP0CK7Iu5IFv2RxTQe6ioincWeLCe07KqwsdWncB69BKVf/A7N1ewToX3ofQv6keOxSZlId/Efy9b9tahWAShdbBsvM9d0WyDRR2Ln394eG0yHoKpqo3puRryKy3eW0GXO8b1KsFEg+VmDbc7/wz4t7d6nHIyTzs1AjfIejUY0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiE35ikN3NS91Yr3WcZTHTrhDPShqC0HAvgUE7c4y5Y=;
 b=WbNlZ9wpxM88Q6r9Jgxe25H8HAltWlVrkuoY5RswQ5pq8CEEcFU75Tz7U2OmvVTnV14WBtd48DkbDduXSobA0bffzIdRAd6P4KuInZjKUx7Afo/T67l9/S056H6jFwTnovHa9VeF177bAzSfUSv8dpj7sOmr/vgTfBGLZy731p+zWWt1N70thn5+1vB1onyqrFwzNU48QX4Pz3zqSljdDFQd9yDBVrkVxJC7OVZA0/LhK7KtpoHuJpXKF0Abm7FxYYvazDwYpO4eX6eqp+Dg6BO/de1T6hnK874Tv/o0uzkRPZqVNawdDVXhoK9kIMdZflu7Znq+O2agTsSdzTpEtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiE35ikN3NS91Yr3WcZTHTrhDPShqC0HAvgUE7c4y5Y=;
 b=e7dB9TSwzUxZ190G8a+3C0B0AuGYpH8dB5HJnE8yidWjnY2dJGcExW3J4WghvwU0UcCA/LL7ss0+VGeGNuKddrrCxGiR4inuXSLcZcm+Mdpbopi34s8YinvsbBfvsZkdS5xepIErpY8xbTGVSTJC0IpNd6sg13lo9MLVSfuQln0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:48:21 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 18:48:21 +0000
Message-ID: <fbe2f3d0-c9bc-4b31-b443-ada162841078@amd.com>
Date: Mon, 19 Jan 2026 19:48:12 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: Michal Simek <michal.simek@amd.com>
Subject: [GIT PULL] AMD/Xilinx changes for 2026-04-rc1 v2
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0004.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: edc20400-41f2-4d7b-4594-08de578b50dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnZEbHBsMnc3VEF5QUNIZnhPT3RLU2NVelZSTE5rUi9GOWo2SWZDT29sNkdj?=
 =?utf-8?B?blZFRk0vbzdUcTE1aGVraVhEYWdBejZoMTUwYjFtUVZ2aFBjM3Rhb0tDcndR?=
 =?utf-8?B?SjdJYXVRR3FoKzFBbHhEK3BNa2NwY3NOeWN4UnBCdEc4UWpZNjFRZnN6UW1Q?=
 =?utf-8?B?akpYVTVvdWxQVk9pNk1Ya2FRVHE5eGJoL25sMWlVR3lSc21QVnlvakVSUVhl?=
 =?utf-8?B?UDNsYXZyOUhvL3RRNzNZcW13RUc3YjBYM0MxOVM2RGlHdis3c3VRNmNMTUlP?=
 =?utf-8?B?WGlMRUYwcUd2TWw0NkhWUWgyT2dRbjhHaUlkdll0K0xUV0ZLenU2ME4wRFVt?=
 =?utf-8?B?N09oSDhRRkZVU2VBTU5GUWRRNThyL1dyYnM0Y3laaDB4ZDd4cm03cDJCcnEx?=
 =?utf-8?B?dVp4TEdZaUhqb2NvUXBqS1lIUnlKdDI5dzhNR0E4V3NMTTkzN1I3NTMrUlRr?=
 =?utf-8?B?MEtEUG5pUDJCTFNGak81RHVmWjJsWFltMnJ4TmhhbTB5MUxMZ3d1TnkramIv?=
 =?utf-8?B?NXBudHk3cW1xY3g4WUxlU3pCZENRenV1Qkd5RUkyYmt2UWQ3VHROaTk3SUFo?=
 =?utf-8?B?NzM1bklTZ09QMFgyQThJaHhUei93TXFOTlhyVTdPb0Q2WE9OOFY2MXloK3Qz?=
 =?utf-8?B?cktIL3NuSkd3N2hRQm00SnVRNXdnQUxIYU4ycVhiVTVqM2N0V1VyUEpuRmJV?=
 =?utf-8?B?alJRdmltaW5TT0RQS25YaTFTWUdpUk1RTTJiM2JxcGRCcFdyM3d5Zms4MjJC?=
 =?utf-8?B?azhUMlBxSG9PSHZrV0VmUzdmUVdnZTQ0N2t0eHVxTHdRc3dNdWFhdURqNVpX?=
 =?utf-8?B?WHZtY3BtTFZ2dHJSaDhxSTkxUEdrQnR4a2g5Q1M1NjBINXd0UThETlRCa3FY?=
 =?utf-8?B?RU5NSm0rQWRMSS8rZExacC85UFcvUjZxcThOeENBeDYwQ0NBQVlSZUp4bTY4?=
 =?utf-8?B?M3ZJY2pCcmk0dGV2MWpEaG1VaDRWUXRMc241ZnZ1Tk0rYlhxR215V1RJQlp2?=
 =?utf-8?B?ZGVlMHhvWmFYQTBrSlFEL1k4dUh5M0oxaVRRNElQYWpuamswdUV2ajVJK1Ur?=
 =?utf-8?B?ZjRNbWdBaFF0b2lTRE4zZ00vRlVwSCtteDBVVU8wUHBRZXNMYUFrOXZsOG85?=
 =?utf-8?B?RGNHNmRuWEVLYVBHS2dnWXZlKysyNmVWV2s2eE9XekZyK3RvSk83aW9QbFQ1?=
 =?utf-8?B?bnR2Q1RXMGdXRjdjSCtzTEJSVHJQVUNQcklFWWh3UWdMbE1vNjFvaTd1ZDJq?=
 =?utf-8?B?TWVyeU5yNnZjQXFtb25jSG42a3JWYWtzdE9mK2tQcXVzOU5pRnlXU2FseTZU?=
 =?utf-8?B?bFU2MVNxekJ1OVdZdnVBZE1CdjZrVTVnOHN0eXNmd1BmV0VUUGZjOUh0VDFp?=
 =?utf-8?B?ak1OSkxVTWYyS2pnUWxNNzJPUVpOWm5qZkJYN0FpdTNSQ09DMmh3WWhwN1Uw?=
 =?utf-8?B?b1FqNEJ5czVTYmFCMzc5eXRpaHhoRG50VjJVUFRia1ZYeU9FVjZJaGNVMWlV?=
 =?utf-8?B?VzdJcFo2NGM3dUdUNVJlSDhpVWlNdXJxeVA1QXVIRnpYMklRMFlyRGxqRDZH?=
 =?utf-8?B?dDQ4eG55S2NxbW5aSUxKNEFMUklaZmZ4V1dzVG9zQklrSlFmYlFlSDdQRGZT?=
 =?utf-8?B?UUo0Q0UwQ0NyQ2ljRXZmUWl6dWxoc0ZScGxSWGwvdjlXVUxqbXdscVh3TXpI?=
 =?utf-8?B?SXd6aW5rejhHRkdsaFdZUy9WdmU0WVVqQkZZL2FyLzBZYmtZZmV5d21Ka0tM?=
 =?utf-8?B?bWpnZVJKZ3lYbHFWakU2U3VnMXBGRWdLSlFnS1ZtUXQxY1l6dzN4TElLL3Q0?=
 =?utf-8?B?dmo5M0ppcGNTZmVpeG1zMGtUc2dkRTBMZHNNN0c0ckU5ZDVxN1I2QTBrN2dB?=
 =?utf-8?B?YXBEMFVOVHRyRVFQYVNva0t4Y01xTlRiRmY3QVE0akpHVjJ2dE8yOTFRLzJ0?=
 =?utf-8?B?YzVYR05CeEpKTi9KSnhuSFQrQTU4ZEM5UGZYL3MzK1ZCUVRhUUM4Rk10SkRI?=
 =?utf-8?B?YkhIRmpOemM2Y2c5dkFxV2xtL2RqZUxlaU1KUnhrVEdlMnhEZytnZHNWRTMr?=
 =?utf-8?B?OU0wMm5DUHBTbU1sY3pSN1Q2emdFMWxqdjJQYm42VmFQdUFPSXRQZlNBdXFk?=
 =?utf-8?Q?I8i4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk1LQnlrYUh5dHNyTHd1SXgrSnM4ZFIxZ0tmdTNIdFFkNmdFTGxPL3VFNGp0?=
 =?utf-8?B?dTZqZ1k4cndZSjJiYlVMTmtPRnlsd3RCOCtkd0RXT3VYSjhNSEV4L21vanFh?=
 =?utf-8?B?N0hMQnV0eDVWMHJHRTNUcjVsVVJTcWpMYkpFNDIrb3VJd0ZkYVgzZTJhTTQ0?=
 =?utf-8?B?RmJpRE85YlFwbGxHakIrNE5uNU5rMjdJMU1NWlVEc2lyZXV4RVhVeE5PcEF2?=
 =?utf-8?B?MHFvNnUwWWlicWw3M3hadmRhOHVPQmVjL2orNkdhYU1NaFdUcDI1Yk1RWlVo?=
 =?utf-8?B?ekc5ZFU2c1ZuQnVPc1prbFU4VFNGR0pDRXBWNkQwenlIZU1xZXNIV0pROERx?=
 =?utf-8?B?bzlhckhFQkJLMVFmZHFybmx2WW1ZUDdPRS9IcVhoWHF3V0hUcWZJcHZ5T2Z5?=
 =?utf-8?B?RTFRbEtiaGc4VCtZMEZEZHdCRjRSeUJQckRRa1I3aXhjMFpKNlc4M0ozSldU?=
 =?utf-8?B?RFhXd0xzQzlMU3BuY1I1TU5SaEFFU0k4S05ZRFo2NDZEMlRHRlVXMVpaVnM5?=
 =?utf-8?B?YjQwVlNlZ29pLzIxRTgyT1h5R3d0MERKV25mNnBKUkJzSkwzQ245ZGp2U25Z?=
 =?utf-8?B?YzBTd0hWR0JnbEROL0dsTTBrOFlxRHdJTEFWaW5uVWgzdEZYVFQrVGdCNWJS?=
 =?utf-8?B?cFBtWjE0N2I4ekp6bzcvQVpsbTUySHVrSE1CQ3AwZGpWZEdWbmFtWWpTM2Ux?=
 =?utf-8?B?M01oVUdzV3BxSXZoYnAzVUpxc0xOTWN3eG9BM0hHc1pFT3BkNldCY0hTdGRV?=
 =?utf-8?B?bDZFZjZrTWhoSldZbXd5d0F0L043WHZPbjEwUEV5VlhmM3BhWGx0dDA1WEU0?=
 =?utf-8?B?aHloRXNDM0hMWlQrZVRlalpjeHVnV2NoU29KOVdlaE5GeGIvY20zeFVwVHZD?=
 =?utf-8?B?T2Y5Vk9yb2NTTW8wZWxWOUllaHAwcE5rd3JxQk1pRlFKaUpXN0ZzUHdJL3dw?=
 =?utf-8?B?bGlaRm1LVkZ6RXhrYWFjcmVoWkRmbXhnMldhc3ZVWEJTTkcrQm9UQnFNWnhi?=
 =?utf-8?B?dGdEYzZXSE5UcnBNNk9CYWJJNXNSOEIxaDlnOFRBWVA2TXV5ZHN0Y0ZLN1hW?=
 =?utf-8?B?VnhieXhnbG51cVVqbUI2ZHNMWHdPTzVNaGhaeHdiQnJGVUxxQXlRbWhoZytV?=
 =?utf-8?B?VzRQYUQvYVo4VU5kdE4zK0Myc21mTCtzSHZrUEN4aW5INStzTG5LRDdUTFVG?=
 =?utf-8?B?SzkyK2N0RFlxbHEyZGEzTm5LdXREZVg3cmZlc2NrOXJVV0JHSjdQQlhRVUFy?=
 =?utf-8?B?MmczWDQrREFneWt1U3ZESlZ0eGM5MHZzMkI2R2ZDelFxMG5KNmtlYVQ1ZDVR?=
 =?utf-8?B?MjlQN2srNFRGZ0pOSWNjR3YySTJMbWhsV2s1TFRwZzlqcytuVXlPTURwbFdV?=
 =?utf-8?B?NCswaGdmYjZSRzBJb3dEOVZRdnJldER3NmNmdTBHQllTZTZmczJKRGdJZ0s1?=
 =?utf-8?B?S2JlUVIrL3RGL0lNTjNRdGdoeDhhanJxa0ZxUmxQakpIMkxSTTBXQUxyeGhn?=
 =?utf-8?B?QzQ3bGJKVmpaMU8zVHBDcVNVT3VDWjBQMXJGK1RTN2h2MC9sbnJJbjlpWE9z?=
 =?utf-8?B?djc4aVNoamNkT3B0VVZRMnoxbjJiTFZuMGNLbTRiMTJBTU54Y1UyRWY4bWRC?=
 =?utf-8?B?UUx4NUJiaVQ1WTdDaEVoaFR2S25lYnBhQ3YxdFA4d0pmVG4vUWtzYXI5LzJs?=
 =?utf-8?B?RFY0QVVteGFjUGkxT3ZuSUFLQUVOZnUrK2lpM00rYVZFa1V6L3JiSmU5S2dJ?=
 =?utf-8?B?SHFId2ZCeG41OHZlTUJXYzFlUldEQXZOUS9SL3RENTMrTlJlalQ0bkZHRTJR?=
 =?utf-8?B?NWZ4WEhwcExlR2VsQzFYMkpHWkcxQ0tKTlArczY0RkJuQm82b0ZyNUcyaGNC?=
 =?utf-8?B?MFlUL1UzLzV6ZVFsM1pNamNJTTlMdGNKbS9pRUpBNERzd2E5YWNsR3hpaE1J?=
 =?utf-8?B?K1h4blpWeDVrMEFXd09vYmRqa0xsWlVydTZwb1JlN2dKb1k0WUdTYnp3VTBv?=
 =?utf-8?B?ZUhRMmxhazVwc1Y2SzZXZGRkTjdwVW1ZTFJEM3k5dHo2aTVnOEswd3RxYTVY?=
 =?utf-8?B?SjUyc2JBM2ZJNFZ4V0tSUXVaS0hFcUIyMms3emk2TW4wbW05VHRrMExzcSsw?=
 =?utf-8?B?cmt3dlFkL1VPZlU4dkdrQVlGTFY4UVRwRGg0dTI1a1h1bWdHSlY3c0hmcTFN?=
 =?utf-8?B?b1F2QmRMUkFaMDlOZW1hbWxsaEhyaTMxQitBd3BzWHNQYmRmZVpjQ2JpY0c1?=
 =?utf-8?B?Mks4U0xJOTlPa2pycEl4WUpYU1lGcTduanJJYms0UC9ST0FBbFNWanl3dzhk?=
 =?utf-8?B?ZzFLa0szdUEyZ2hzQWFsNlBJK3pYQ0tQNzluYkwzM0xIc2ErRVJJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc20400-41f2-4d7b-4594-08de578b50dd
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:48:20.4513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCuqh8pNhE3jnB7VAkOBMRyL32KVQMC23D78AbdD7U7t1voT/QLQ5sEPZb6C7LcO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707
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

Hi Tom,

please pull these patches to your tree.

Thanks,
Michal

The following changes since commit 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550:

   Merge patch series "Enable / require DEVRES for devm_.alloc usage outside 
xPL" (2026-01-09 10:19:57 -0600)

are available in the Git repository at:

   https://source.denx.de/u-boot/custodians/u-boot-microblaze.git 
tags/xilinx-for-v2026.04-rc1-v2

for you to fetch changes up to 8a532b5a2219d9e275fd1b9de40391852b30784a:

   microblaze: Fix SPL device support (2026-01-19 09:17:00 +0100)

----------------------------------------------------------------
AMD/Xilinx/FPGA changes for v2026.04-rc1 v2

microblaze:
- Fix spl_boot_list order

versal2:
- Fix EMMC distro boot setup
- Align distro boot variables with memory layout

zynqmp-phy:
- Sync with Linux kernel driver

zynqmp:
- Add verify_auth command
- DT sync
- Add placing variables to FAT/EXT4
- Enable PCIe driver by default

pcie - xilinx-nwl:
- Fix Link down crash

ufs:
- Align clock/reset with DT binding

----------------------------------------------------------------
Michal Simek (7):
       arm64: zynqmp: Enable pci root port driver
       ufs: amd-versal2: Fix clock name with binding
       ufs: amd-versal2: Fix reset names with binding
       amd: versal2: Align distro boot variables with default memory map
       arm64: zynqmp: Remove ina260 IIO description
       arm64: xilinx: Fix DT coding style violations
       microblaze: Fix SPL device support

Neal Frager (3):
       board: zynqmp: allow env in fat/ext when booting out of qspi
       arch: dts: zynqmp: align cpu_opp_table with linux
       board: zynqmp: add cmd for getting boot auth state

Pranav Tilak (1):
       arm64: versal2: Fix emmc boot mode boot_target issue

Sean Anderson (5):
       PCI: xilinx-nwl: Avoid crashing if configuring when the link is down
       phy: zynqmp: Allow variation in refclk rate
       phy: zynqmp: Enable reference clock correctly
       phy: zynqmp: Store instance instead of type
       phy: zynqmp: Only wait for PLL lock "primary" instances

  arch/arm/dts/zynqmp-clk-ccf.dtsi         |   2 +-
  arch/arm/dts/zynqmp-dlc21-revA.dts       |   8 +-
  arch/arm/dts/zynqmp-e-a2197-00-revA.dts  |   4 +-
  arch/arm/dts/zynqmp-g-a2197-00-revA.dts  |   2 +-
  arch/arm/dts/zynqmp-m-a2197-01-revA.dts  |  13 +-
  arch/arm/dts/zynqmp-m-a2197-02-revA.dts  |  11 +-
  arch/arm/dts/zynqmp-m-a2197-03-revA.dts  |  11 +-
  arch/arm/dts/zynqmp-p-a2197-00-revA.dts  |   8 +-
  arch/arm/dts/zynqmp-sc-revB.dts          |  20 +--
  arch/arm/dts/zynqmp-sck-kd-g-revA.dtso   |   6 -
  arch/arm/dts/zynqmp-sck-kr-g-revA.dtso   |   6 -
  arch/arm/dts/zynqmp-sck-kr-g-revB.dtso   |   6 -
  arch/arm/dts/zynqmp-sck-kv-g-revA.dtso   |   6 -
  arch/arm/dts/zynqmp-sck-kv-g-revB.dtso   |   6 -
  arch/arm/dts/zynqmp-vpk120-revA.dts      |   1 -
  arch/arm/dts/zynqmp-zc1232-revA.dts      |   2 +-
  arch/arm/dts/zynqmp-zc1254-revA.dts      |   2 +-
  arch/arm/dts/zynqmp-zc1751-xm015-dc1.dts |   2 +-
  arch/arm/dts/zynqmp-zc1751-xm017-dc3.dts |   8 +-
  arch/arm/dts/zynqmp-zc1751-xm018-dc4.dts |   2 +-
  arch/arm/dts/zynqmp-zcu102-revA.dts      |   2 +-
  arch/arm/dts/zynqmp-zcu104-revA.dts      |   2 +-
  arch/arm/dts/zynqmp-zcu104-revC.dts      |   2 +-
  arch/arm/dts/zynqmp-zcu106-revA.dts      |   2 +-
  arch/arm/dts/zynqmp-zcu111-revA.dts      |   2 +-
  arch/arm/dts/zynqmp-zcu1275-revA.dts     |   2 +-
  arch/arm/dts/zynqmp-zcu1275-revB.dts     |   2 +-
  arch/arm/dts/zynqmp-zcu1285-revA.dts     |   2 -
  arch/arm/dts/zynqmp-zcu208-revA.dts      |  22 +--
  arch/arm/dts/zynqmp-zcu216-revA.dts      |  22 +--
  arch/arm/dts/zynqmp-zcu670-revA.dts      |  18 +-
  arch/arm/dts/zynqmp-zcu670-revB.dts      |  18 +-
  arch/arm/dts/zynqmp.dtsi                 |  16 +-
  arch/arm/mach-zynqmp/zynqmp.c            |  32 ++++
  arch/microblaze/cpu/spl.c                |  13 +-
  board/amd/versal2/board.c                |   6 +
  board/xilinx/zynqmp/zynqmp.c             |   4 +
  configs/xilinx_zynqmp_virt_defconfig     |   4 +
  drivers/pci/pcie-xilinx-nwl.c            |  17 +-
  drivers/phy/phy-zynqmp.c                 | 178 +++++++-------------
  drivers/ufs/ufs-amd-versal2.c            |   8 +-
  include/configs/amd_versal2.h            |   8 +-
  42 files changed, 249 insertions(+), 259 deletions(-)
