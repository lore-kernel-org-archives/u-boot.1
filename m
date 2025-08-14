Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DFACA0EE3
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 08:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBADA8309A;
	Thu, 14 Aug 2025 10:46:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hMEy5RaN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3D95837A7; Thu, 14 Aug 2025 10:46:44 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37A9680548
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 10:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCiCFe3gygvWwMsGOcPj7SkTo7taK3Zm+jgdR30z5/nkmA0TrkCMOnIEaqRGHqRPUZ2IzjjH9tXuz/Y0gWv1ububAvG3hNe6ZWt7t0xxI0TmRH0mbCZpKLFcNdJ1Hbzotm+kTeVx9yBvV4HzQ/hlw4GURea1M+0ifz7UKsndzFbCcc1h1A33uIfLD4faWtCQgRwucBiaBmJ57Awxt1aFwaSISfAlD/HEPXS9SwV9lwX3Imv0PG3UPwa6nXCKV2nDf5AUm0JelNbv6Aw7/DeMtbRH+nrnTzay0LmRDO5RlSr7v3/BJBOuq/8ZpuZf1Zklg1Yv/jeXAn97BNUMU6cgZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyQXumUEiz79r7bOGtcyWWh/VT9NwWIQ7EGJhc7FWLY=;
 b=iREwPIXa1KJw1KrVcPgGZ6iUMBPCs5JlCBNvuAUTovQW7dzyhXPVYJXNfots+jVvyYJUXy5NBcxq8cuwXjXzbHbKxEvoPZ+MSkNAXeHuKLQhOmkhuiXljBQJ7lBOojS1WmM2+6Tj2AF+8L0wQR5VUGQXArhl9RgWQgY2K9133WAkymEtgeuxUT5dXyNrtnSiCKTIvNT6HqqwvkQC/5KndlMb6LCDz0HSgd9sAsM/4mbQLu/WXtUvtDJtIHXM/JJZg9KFZvNG4XnHttC3AUK6Q75m4GAiCHqL5fJWKi4KMgCZfXUEFhbR9Pt0yegOdN31Px6mM1oEB0h8KFgFhTU9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyQXumUEiz79r7bOGtcyWWh/VT9NwWIQ7EGJhc7FWLY=;
 b=hMEy5RaN94VHaJKunJKurCP9MSUWVwl1sdS4do77YXRaVpjnYqTl1qkhv3/u/IIahvmHnE0VF845Rli0YzHdYrpkeRHAfdymnDcHC6jix5krXpjrMCfZoGIIkHXn8jyL6VISkDseEKCQ5CxBU5he+x9a8NETmfx1B10WiSBvRSHQ+O12LXB4iVc1tbyi6ZrY5ZQapcp2lzdwowxglzv+3b9thdAo/zkfyRzm4KEPE3KbX5lwBHhdNBklnja+R7WEPjLWgEa6gR9wsRH/BDvS1yed4KFgYXZXDzWDel7gmC7d9rD+D3l76iGK7A6lDGZ+c99TNqzZxMOXc51RuVtEGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by PAXP195MB1168.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:199::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 08:46:39 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::f79f:1750:8791:4336%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 08:46:39 +0000
Message-ID: <1a53cbc0-e929-4e3b-8242-7e35c2d02734@phytec.de>
Date: Thu, 14 Aug 2025 11:46:36 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bootstd: Add implementation for bootmeth rauc
From: Wadim Egorov <w.egorov@phytec.de>
To: Martin Schwan <m.schwan@phytec.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de>
 <20250602-wip-bootmeth-rauc-v2-1-9d2384131486@phytec.de>
 <b1f83b3e-b5f5-4d7f-ac76-834ecfd6d5f9@phytec.de>
Content-Language: en-US
In-Reply-To: <b1f83b3e-b5f5-4d7f-ac76-834ecfd6d5f9@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::31) To DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|PAXP195MB1168:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ccff67-a785-4a30-52aa-08dddb0f15a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGFyUTg4WlE3OUJvb0t4aWtNRE0vUXk1eWVRTlY3WTBrMWlnNnF3QUdIRmVl?=
 =?utf-8?B?a2xkaW5FWXV0MnE5MTVNMHdQL0tJb2Nkbk9iV3htMVQvZ3ZHM1d2MHNXMVRu?=
 =?utf-8?B?cjZjSjZ4N3FLQjhuVTAyOVByNG5qZGtpSk8yeHoyR0xMYUwzMUZpVFVoR21J?=
 =?utf-8?B?ZFdIdEdBVVpUNnhxMUF2T0RWZFlNUm5aWFFXZjd4cTl2ZEE0L3lWRU9HY2FQ?=
 =?utf-8?B?eTN6RXZWQXNGdUg4dVJMeVNEVkVxNDNhY21jb0R3Rkc1OFJhY3dkc1AzRzJL?=
 =?utf-8?B?UGFxWHNoUEFLcUl4aGlnR2xYVklDWjNXMVovVXIxTVJackx0RGFITGpxTmgz?=
 =?utf-8?B?WEd2RjdOVmgzM2ZpVTQ0OGp3bTRqcCtKOHRKNml3RUxYM1BmSUdHbkFvK1VV?=
 =?utf-8?B?bGRMTjFidU1OUWlEaGhNYkk4d3pIZHE2NVE3L01McktVRlY4TE1TR0ZFKzlD?=
 =?utf-8?B?QWNwaWRnZmtDbGg5TytwbmFHQklSTzJlM0IwSFk0cnlrTWdxb3BsYUNvTlZR?=
 =?utf-8?B?K2N0Y2NqYXUrTG83RVRZVGpkdHl1WkxNd20yaEEvR0t2WGxyYlE4ajltZy9B?=
 =?utf-8?B?ZTdLckVLRldwUVE3MHZraXJLVGd0UCtGNkxweTI5bENDWm5WTFM3NzBBbXRq?=
 =?utf-8?B?L3VralQzVEhqcVM2U1hBbzhlS3pNZ2t0bmJlVzFRYm01V3NNbEVZZGx5cTQ2?=
 =?utf-8?B?ZmdyYURuc0ptYlp4Uitxank1d2l3NWRueHdTWFY1bjRaWjdsby9QRTFydXJl?=
 =?utf-8?B?K0E2TGZNc2dBaGwySXVLek05UnFobXllelIwVy80c3JJRjlFbHVWeEg3VGls?=
 =?utf-8?B?TGJFc0cvNUxBTXlUMXRlYXpMeWp4Z1liT1pkb3VBZXY0eHFiSjhCSEh6SVdx?=
 =?utf-8?B?eGx6U0c4TXhIOFhDLy9hbW1FYldRaGpEZWJWaENrU2ZERWZoMUN4eVl5MU9L?=
 =?utf-8?B?TjhvZ3ErQUVQdFJ5eTRHMjRWelJVOXRKYUtiamQ5N2ZHVW1BQTdQMFJMOUY4?=
 =?utf-8?B?Y0ZmMzJCL1VGc21nSjQ0QWhEaFIrdyt1Snl3akoxZVlqVkdjTndmaDBzM2Vj?=
 =?utf-8?B?Q3FZY1M3OVcxbk9WMWx3RFIxcTFWRDl5d2ZvZXIrMm4zUmM3MXd0RWZzQUtv?=
 =?utf-8?B?N1gzUHpCTU5DZTVFcG4xVVNkWW5xU0RxWXhVR2pKUjVMT0xSbXA3OU11d0Qx?=
 =?utf-8?B?QjZaRmFPZU5TS3kwd1ZxKy9SMFJGSW5nZjYrb0FyN1RaWEkzd2kwampjalFq?=
 =?utf-8?B?VDZBUkFoaXV4ZU5zT09TNFdMODFyMUF1d0ZCTHhMK1JLRGtxWDhMQkc1bVdr?=
 =?utf-8?B?MUZINndnR0NsUlR0cmN4azhXVDBNb0lSTWFCYjFpT085SFdJMjFjc0l3K0JS?=
 =?utf-8?B?UThXU3R4cUx6TmNXdWoyM2RCQndmVFRnWXZFQXBKaldGS08vSS9sMTVGekJK?=
 =?utf-8?B?OERqc3VVVkVVcFBydUVmQVpRSGUycjd6UmVNUFZTWUUxNTJYZHFNenMwQnFG?=
 =?utf-8?B?Mmc5QXNIa2tmZU9DcjNONm5kQ29Mekw3Z1hHV3pPQ1VXS284bHJhdnUzOGpa?=
 =?utf-8?B?OERWWEhvZ2I3SEpGSVNGeFZzLzFiOWRwQVZjczVoeDRwdDd3ZUYvbzVTRjlB?=
 =?utf-8?B?dWNGN01iM1ZadEp1WkpWQ2hjQnNPZDl6YVhtVndPcGcxR1JkUnlwWXEvUDZC?=
 =?utf-8?B?dkdyYVd3UGk5WGhZd2lKQWEvMWdNQ2RSZ3ZOM29adXk0bUlkYlR0QVdlbms3?=
 =?utf-8?B?TTliZGViQklZRjhQZ1RObjZUTWFmRFNnTCtPMG91Z1ZnVG1TQ2p4OVU4VlhD?=
 =?utf-8?B?NFZsWHVkYnlXWllTeHJKTDlIa2xOVFplQjRTaEsvemgyWDNJR3hNeGkrWjRw?=
 =?utf-8?B?azUyUUQxakFHUkpDV1RNN2k4SzM4N1Z5SzJiTm1uZGczcHdQekMzMURPQzBi?=
 =?utf-8?Q?h2/8VlTt+kM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cEg1Zld6L3M0ajdFamN4VDlxSW9WRUlhRUIxRi9paFlia0wyZVVqdEF6ZThR?=
 =?utf-8?B?ZXh2dWE2UERCR1FHbUNrWXRGRUZBVU9uYmxYR1B3VkREaytqTlJsc2dPSmN0?=
 =?utf-8?B?WUVJNjZhaXppNDN4c1ZrV05SMWt2RFQyekhXL0RxUWw5RTBxc3NwOGVNc09M?=
 =?utf-8?B?Zkl5ZTM3Z1lvclZqNjZJNFZHU2ZnUUMrY1BFcXBNOGhyMlV3ZWcvSHJtdlRk?=
 =?utf-8?B?NngxVkFOdHc0amJaU3VPUkhzVFpEaXVMRllTdFdwM1ZCTjByQ2pwT2ZsTDIw?=
 =?utf-8?B?aWVienZ2b045Z2h6WnhjaFBDOWVOS3haZHdRRzQ1S1JIUUtXYWx0VU5JM3BO?=
 =?utf-8?B?WEtJSnV5V2xScWNhMjE0RjFaazR6Y2JpcnhzQVY3SGJlalpFb2wvKzVmV2Rn?=
 =?utf-8?B?WW1IZVZTWUdhK1dSbVpSbjlQQmozVi92K2oycHRhcyswWjdqQ3pxMXpXazNo?=
 =?utf-8?B?MGgrMC9weEdjOERleWZxVDFHem9QTjgwZE5rZkd3MWZjSUxZclU0a3VIWVpO?=
 =?utf-8?B?N1pIdmlkeDJKamtFcUcycUF3NzJMQUdLV3hMSWRRTmJoUEVwUlFCMDJjMng2?=
 =?utf-8?B?OVVxWGtLQW9HU1EwcUFmNHRLSURJYVp4eVE2RHVZMXNZYWF2SzhoUUFCWEFG?=
 =?utf-8?B?MlZDS3dqR0FYV3FhZHFGTm1SN0FiOGFkOHBjUUNJVHFqYitzUVZwRjdjTnR1?=
 =?utf-8?B?L21sODNuSjV5YkpaZWR2YzR5S29qaTBPQVQ4bkdIaDMvbVI5ODd5bzEydjNy?=
 =?utf-8?B?MkZER2FTRjhqcjQ2ZmRzK2hxeEd3ODNmaTU2NzhPM3YxL1F4aGc3cENBMW1i?=
 =?utf-8?B?bkcxNDBjTnNYOEJtRmpUcGFIWm9OT0xobko2TDAvaFNyUDYyVG5TYmZKSGpu?=
 =?utf-8?B?NkQ3NDBHRzU5d0t2SEdTT0JzdWpBeU1GazJWUmNCVmVNSUtBcC84VDdISVNR?=
 =?utf-8?B?cFV1OGNCMUdNWWErU1VFZFVDM21UMFRPRVlsSm1pZThBdXhPa285WEt4TlhT?=
 =?utf-8?B?WVlwQkJVN0xnclZ2UHFCdU9vNThEK0ZSMUpzZTBoWnNnamhIU2szTUgrZzVC?=
 =?utf-8?B?dERKNitNVnhJdGtBNWpjR1ZNS2MyL2RpSUYrNDVYelcvaFdDajdOMEwwRGI4?=
 =?utf-8?B?VGNxdmhtby9LQUt2VWxPUThQREFkZzBDaEppTElIZEFLVW1lVjhHWW5Wd0t3?=
 =?utf-8?B?TlhGc0FNTUs1Y2lTbSszcjFiRFpuM2hrTXdKdXdBeW50Z2FXTjJENW1ZNXZ1?=
 =?utf-8?B?OVphdFV1Ky8yQzJ4S1RtMllQZS85Mk5UT1JiaEwrNkwrQXlqNUlWTENBd1pr?=
 =?utf-8?B?a3RWWmI2OXdDZ2tVT1NrWTZYVi90UG4zV2UrR3VwUElnNndWbHJMc0ExYlFY?=
 =?utf-8?B?NzE0SzRVditxOVpVNmROeVM3S0JXZ2xsTW9rKzlBaU9mU21teGRsZ201QWV3?=
 =?utf-8?B?UDl6YkxtUHRDNC9RcTdDODVYcFl4T2R4Wnd4bWVMamVRL3ZKNVg2RnVOOUNp?=
 =?utf-8?B?Uy9hS1cyNU5wUzhOUENwenAwc1lQMkJVdllMMW1FQVJuWDFTVXRKc2pWZ0tT?=
 =?utf-8?B?aVFEeXQvb3RzMmhtMlBMamlxK21WcExiVlowRXRGenNKRkk0SFRuSlE4eTNn?=
 =?utf-8?B?UVo1S3VYam50MlVGNmREeG5JTElmUWlwdjFvdUZNM1Rzd05qYUF4MTNhT1Ju?=
 =?utf-8?B?MThEdkJXSzExWExDSFhNUjFWTnAvNkhtY3FIRXhNQXdYSldXL01hR1l2WHBt?=
 =?utf-8?B?cEpNTVloa1lULytPUk42bkdZOUJ5bDdaeUgydDZUTENIdmxzZml6YUFtcmtw?=
 =?utf-8?B?UnVHZ0VCTlFCZFBOQVJLNlZ6RlI4RVBlYU9Fd2RyQTRXSkNMK2pwejNxQzJP?=
 =?utf-8?B?eWNRMlNxUlQ3eWpyYkxPV3EzSDJYZW5kMzlnc3hIUDhBbjB3V1haWGhwNldw?=
 =?utf-8?B?cVVVb2ZRbTkveFNkdnlMTVYyQ0dwbGpIakx6ci9aWmVBYSsxVy9KYkpxU05Z?=
 =?utf-8?B?UGNWRi85cTFnVUVxQ2t3d0JGQXFDMUlKVW0wL2tTc29FWktZMERobkFJL041?=
 =?utf-8?B?SVhlbnZrZk5WTUd6eGhjeUxPaS9XeklYTS9yUHh1TThVcEVLMTI5Z0dvWFNG?=
 =?utf-8?Q?FAiDv6PwoYd0fOvMpGAMvpJVJ?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ccff67-a785-4a30-52aa-08dddb0f15a9
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 08:46:39.2347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeJewmEgApYppv3DFnlWLnH3xMCy6zaTdhm5yTGqPkF3vzIlOiTekRfiwcAtvW8JRqqSey1REtuuNSmhfSveIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1168
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



On 8/14/25 11:44 AM, Wadim Egorov wrote:
> Hi Tom,
> 
> On 6/2/25 2:31 PM, Martin Schwan wrote:
>> Add a bootmeth driver which supports booting A/B system with RAUC as
>> their update client.
>>
>> Signed-off-by: Martin Schwan <m.schwan@phytec.de>
>> ---
>>   boot/Kconfig         |  51 ++++++
>>   boot/Makefile        |   1 +
>>   boot/bootmeth_rauc.c | 432 +++++++++++++++++++++++++++++++++++++++++ 
>> ++++++++++
>>   3 files changed, 484 insertions(+)
>>
>> diff --git a/boot/Kconfig b/boot/Kconfig
>> index 
>> 30eb5b328d7ad8a73a2e84812dd7853b66039164..a610cf9faf99cd5480f94dcac89c3401cca394ae 100644
>> --- a/boot/Kconfig
>> +++ b/boot/Kconfig
>> @@ -855,6 +855,57 @@ config EXPO
>>         The expo can be presented in graphics form using a vidconsole, 
>> or in
>>         text form on a serial console.
>> +config BOOTMETH_RAUC
>> +    bool "Bootdev support for RAUC A/B systems"
>> +    default y if BOOTSTD_FULL
> 
> I noticed that the merge 009d7722ffd7 ("Merge patch series "bootstd: New 
> bootmeth for RAUC A/B systems"") deleted the above line.
> 
> Was it on purpose?

Nvm, missed your comment

   [trini: Don't enable by default].

What would be wrong about it to enable it by default?

> 
> Regards,
> Wadim
> 
>> +    depends on CMDLINE
>> +    select BOOTMETH_GLOBAL
>> +    select HUSH_PARSER
>> +    help
>> +      Enables support for booting RAUC A/B systems from MMC devices. 
>> This
>> +      makes the bootdevs look for a 'boot.scr.uimg' or 'boot.scr' in the
>> +      respective boot partitions, describing how to boot the distro.
>> +
>> +if BOOTMETH_RAUC
>> +
>> +config BOOTMETH_RAUC_BOOT_ORDER
>> +    string "RAUC boot order"
>> +    default "A B"
>> +    help
>> +      Sets the default boot order. This must be list of space-separated
>> +      strings naming the individual boot slots. Each entry in this 
>> string
>> +      should correspond to an existing slot on the target's flash 
>> device.
>> +
>> +config BOOTMETH_RAUC_PARTITIONS
>> +    string "RAUC boot and root partitions indexes"
>> +    default "1,2 3,4"
>> +    help
>> +      Sets the partition indexes of boot and root slots. This must be 
>> a list
>> +      of comma-separated pair values, which in turn are separated by 
>> spaces.
>> +      The first value in pair is for the boot partition and second 
>> for the
>> +      root partition.
>> +
>> +config BOOTMETH_RAUC_DEFAULT_TRIES
>> +    int "RAUC slot default tries"
>> +    default 3
>> +    help
>> +      Sets how many times a slot should be tried booting, before 
>> considering
>> +      it to be bad.
>> +
>> +config BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES
>> +    bool "Reset slot tries when all RAUC slots have zero tries left"
>> +    default y
>> +    help
>> +      When all slots have zero tries left or no valid slot was found, 
>> reset
>> +      to the default boot order set by BOOTMETH_RAUC_BOOT_ORDER and 
>> set the
>> +      slot tries to their default value specified by
>> +      BOOTMETH_RAUC_DEFAULT_TRIES.
>> +
>> +      This prevents a system from remaining in an unbootable state, 
>> after
>> +      all slot tries were decremented to zero.
>> +
>> +endif # BOOTMETH_RAUC
>> +
>>   config BOOTMETH_SANDBOX
>>       def_bool y
>>       depends on SANDBOX
>> diff --git a/boot/Makefile b/boot/Makefile
>> index 
>> 71dafaefa76bca7896741dd896829575bd9e8f10..46f27e71856c598a866424cb93ee01444ea6a19a 100644
>> --- a/boot/Makefile
>> +++ b/boot/Makefile
>> @@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += 
>> bootmeth_pxe.o
>>   obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
>>   obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o 
>> bootmeth_cros.o
>>   obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
>> +obj-$(CONFIG_$(PHASE_)BOOTMETH_RAUC) += bootmeth_rauc.o
>>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SANDBOX) += bootmeth_sandbox.o
>>   obj-$(CONFIG_$(PHASE_)BOOTMETH_SCRIPT) += bootmeth_script.o
>>   obj-$(CONFIG_$(PHASE_)CEDIT) += cedit.o
>> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
>> new file mode 100644
>> index 
>> 0000000000000000000000000000000000000000..4d48d643c0a727d5ebd5f3514c173f0dd824b7cd
>> --- /dev/null
>> +++ b/boot/bootmeth_rauc.c
>> @@ -0,0 +1,432 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Bootmethod for distro boot with RAUC
>> + *
>> + * Copyright 2025 PHYTEC Messtechnik GmbH
>> + * Written by Martin Schwan <m.schwan@phytec.de>
>> + */
>> +
>> +#define LOG_CATEGORY UCLASS_BOOTSTD
>> +
>> +#include <blk.h>
>> +#include <bootflow.h>
>> +#include <bootmeth.h>
>> +#include <bootstd.h>
>> +#include <dm.h>
>> +#include <env.h>
>> +#include <fs.h>
>> +#include <malloc.h>
>> +#include <mapmem.h>
>> +#include <string.h>
>> +#include <asm/cache.h>
>> +
>> +/* Length of env var "BOOT_*_LEFT" */
>> +#define BOOT_LEFT_LEN    (5 + 32 + 5)
>> +
>> +static const char * const script_names[] = { "boot.scr", 
>> "boot.scr.uimg", NULL };
>> +
>> +/**
>> + * struct distro_rauc_slot - Slot information
>> + *
>> + * A slot describes the unit of a bootable system consisting of one 
>> or multiple
>> + * partitions. This usually includes a root filesystem, kernel and 
>> potentially other
>> + * files, like device trees and boot scripts for that particular 
>> distribution.
>> + *
>> + * @name    The slot name
>> + * @boot_part    The boot partition number on disk
>> + * @root_part    The root partition number on disk
>> + */
>> +struct distro_rauc_slot {
>> +    char *name;
>> +    int boot_part;
>> +    int root_part;
>> +};
>> +
>> +/**
>> + * struct distro_rauc_priv - Private data
>> + *
>> + * @slots    All slots of the device in default order
>> + * @boot_order    String of the current boot order containing the 
>> active slot names
>> + */
>> +struct distro_rauc_priv {
>> +    struct distro_rauc_slot **slots;
>> +};
>> +
>> +static struct distro_rauc_slot *get_slot(struct distro_rauc_priv *priv,
>> +                     const char *slot_name)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; priv->slots[i]->name; i++) {
>> +        if (!strcmp(priv->slots[i]->name, slot_name))
>> +            return priv->slots[i];
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static int distro_rauc_check(struct udevice *dev, struct 
>> bootflow_iter *iter)
>> +{
>> +    /*
>> +     * This distro only works on whole MMC devices, as multiple 
>> partitions
>> +     * are needed for an A/B system.
>> +     */
>> +    if (bootflow_iter_check_mmc(iter))
>> +        return log_msg_ret("mmc", -EOPNOTSUPP);
>> +    if (iter->part)
>> +        return log_msg_ret("part", -EOPNOTSUPP);
>> +
>> +    return 0;
>> +}
>> +
>> +static int distro_rauc_scan_boot_part(struct bootflow *bflow)
>> +{
>> +    struct blk_desc *desc;
>> +    struct distro_rauc_priv *priv;
>> +    char *boot_order;
>> +    const char **boot_order_list;
>> +    bool exists;
>> +    int ret;
>> +    int i;
>> +    int j;
>> +
>> +    desc = dev_get_uclass_plat(bflow->blk);
>> +
>> +    priv = bflow->bootmeth_priv;
>> +    if (!priv || !priv->slots)
>> +        return log_msg_ret("priv", -EINVAL);
>> +
>> +    boot_order = env_get("BOOT_ORDER");
>> +    boot_order_list = str_to_list(boot_order);
>> +    for (i = 0; boot_order_list[i]; i++) {
>> +        exists = false;
>> +        for (j = 0; script_names[j]; j++) {
>> +            const struct distro_rauc_slot *slot;
>> +
>> +            slot = get_slot(priv, boot_order_list[i]);
>> +            if (!slot)
>> +                return log_msg_ret("env", -ENOENT);
>> +            ret = fs_set_blk_dev_with_part(desc, slot->boot_part);
>> +            if (ret)
>> +                return log_msg_ret("blk", ret);
>> +            exists |= fs_exists(script_names[j]);
>> +        }
>> +        if (!exists)
>> +            return log_msg_ret("fs", -ENOENT);
>> +    }
>> +    str_free_list(boot_order_list);
>> +
>> +    return 0;
>> +}
>> +
>> +static int distro_rauc_read_bootflow(struct udevice *dev, struct 
>> bootflow *bflow)
>> +{
>> +    struct distro_rauc_priv *priv;
>> +    int ret;
>> +    char *slot;
>> +    int i;
>> +    char *partitions;
>> +    char *boot_order;
>> +    const char *default_boot_order;
>> +    const char **default_boot_order_list;
>> +    char *boot_order_copy;
>> +    char boot_left[BOOT_LEFT_LEN];
>> +    char *parts;
>> +
>> +    /* Get RAUC variables or set their default values */
>> +    boot_order = env_get("BOOT_ORDER");
>> +    if (!boot_order) {
>> +        log_debug("BOOT_ORDER did not exist yet, setting default 
>> value\n");
>> +        if (env_set("BOOT_ORDER", CONFIG_BOOTMETH_RAUC_BOOT_ORDER))
>> +            return log_msg_ret("env", -EPERM);
>> +        boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
>> +    }
>> +    default_boot_order = CONFIG_BOOTMETH_RAUC_BOOT_ORDER;
>> +    default_boot_order_list = str_to_list(default_boot_order);
>> +    for (i = 0; default_boot_order_list[i]; i++) {
>> +        sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
>> +        if (!env_get(boot_left)) {
>> +            log_debug("%s did not exist yet, setting default value\n",
>> +                  boot_left);
>> +            if (!env_set_ulong(boot_left, 
>> CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES))
>> +                return log_msg_ret("env", -EPERM);
>> +        }
>> +    }
>> +    str_free_list(default_boot_order_list);
>> +
>> +    priv = calloc(1, sizeof(struct distro_rauc_priv));
>> +    if (!priv)
>> +        return log_msg_ret("buf", -ENOMEM);
>> +    priv->slots = calloc(1, sizeof(struct distro_rauc_slot));
>> +
>> +    /* Copy default boot_order, so we can leave the original 
>> unmodified */
>> +    boot_order_copy = strdup(default_boot_order);
>> +    partitions = strdup(CONFIG_BOOTMETH_RAUC_PARTITIONS);
>> +
>> +    for (i = 1;
>> +         (parts = strsep(&partitions, " ")) &&
>> +         (slot = strsep(&boot_order_copy, " "));
>> +         i++) {
>> +        struct distro_rauc_slot *s;
>> +
>> +        s = calloc(1, sizeof(struct distro_rauc_slot));
>> +        s->name = strdup(slot);
>> +        s->boot_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
>> +        s->root_part = simple_strtoul(strsep(&parts, ","), NULL, 10);
>> +        priv->slots = realloc(priv->slots, (i + 1) *
>> +                      sizeof(struct distro_rauc_slot));
>> +        priv->slots[i - 1] = s;
>> +        priv->slots[i]->name = NULL;
>> +    }
>> +
>> +    bflow->bootmeth_priv = priv;
>> +
>> +    ret = distro_rauc_scan_boot_part(bflow);
>> +    if (ret < 0) {
>> +        for (i = 0; priv->slots[i]->name; i++) {
>> +            free(priv->slots[i]->name);
>> +            free(priv->slots[i]);
>> +        }
>> +        free(priv);
>> +        free(boot_order_copy);
>> +        bflow->bootmeth_priv = NULL;
>> +        return ret;
>> +    }
>> +
>> +    bflow->state = BOOTFLOWST_READY;
>> +
>> +    return 0;
>> +}
>> +
>> +static int distro_rauc_read_file(struct udevice *dev, struct bootflow 
>> *bflow,
>> +                 const char *file_path, ulong addr,
>> +                 enum bootflow_img_t type, ulong *sizep)
>> +{
>> +    /*
>> +     * Reading individual files is not supported since we only 
>> operate on
>> +     * whole MMC devices (because we require multiple partitions).
>> +     */
>> +    return log_msg_ret("Unsupported", -ENOSYS);
>> +}
>> +
>> +static int distro_rauc_load_boot_script(struct bootflow *bflow,
>> +                    const struct distro_rauc_slot *slot)
>> +{
>> +    struct blk_desc *desc;
>> +    struct distro_rauc_priv *priv;
>> +    struct udevice *bootstd;
>> +    const char *const *prefixes;
>> +    int ret;
>> +    int i;
>> +    int j;
>> +
>> +    ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
>> +    if (ret)
>> +        return log_msg_ret("std", ret);
>> +    prefixes = bootstd_get_prefixes(bootstd);
>> +
>> +    desc = dev_get_uclass_plat(bflow->blk);
>> +    priv = bflow->bootmeth_priv;
>> +    if (!priv || !priv->slots)
>> +        return log_msg_ret("priv", -EINVAL);
>> +
>> +    bflow->part = slot->boot_part;
>> +    if (!bflow->part)
>> +        return log_msg_ret("part", -ENOENT);
>> +
>> +    ret = bootmeth_setup_fs(bflow, desc);
>> +    if (ret)
>> +        return log_msg_ret("set", ret);
>> +
>> +    for (i = 0; prefixes[i] && bflow->state != BOOTFLOWST_FILE; i++) {
>> +        for (j = 0; script_names[j] && bflow->state != 
>> BOOTFLOWST_FILE; j++) {
>> +            if (!bootmeth_try_file(bflow, desc, prefixes[i], 
>> script_names[j])) {
>> +                log_debug("Found file '%s%s' in %s.part_%x\n",
>> +                      prefixes[i], script_names[j],
>> +                      bflow->dev->name, bflow->part);
>> +                bflow->subdir = strdup(prefixes[i]);
>> +            }
>> +        }
>> +    }
>> +    if (bflow->state != BOOTFLOWST_FILE)
>> +        return log_msg_ret("file", -ENOENT);
>> +
>> +    ret = bootmeth_alloc_file(bflow, 0x10000, ARCH_DMA_MINALIGN,
>> +                  (enum bootflow_img_t)IH_TYPE_SCRIPT);
>> +    if (ret)
>> +        return log_msg_ret("read", ret);
>> +
>> +    return 0;
>> +}
>> +
>> +static int find_active_slot(char **slot_name, ulong *slot_tries)
>> +{
>> +    ulong tries;
>> +    char boot_left[BOOT_LEFT_LEN];
>> +    char *boot_order;
>> +    const char **boot_order_list;
>> +    bool slot_found = false;
>> +    int ret;
>> +    int i;
>> +
>> +    boot_order = env_get("BOOT_ORDER");
>> +    if (!boot_order)
>> +        return log_msg_ret("env", -ENOENT);
>> +    boot_order_list = str_to_list(boot_order);
>> +    for (i = 0; boot_order_list[i] && !slot_found; i++) {
>> +        sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
>> +        tries = env_get_ulong(boot_left, 10, ULONG_MAX);
>> +        if (tries == ULONG_MAX)
>> +            return log_msg_ret("env", -ENOENT);
>> +
>> +        if (tries) {
>> +            ret = env_set_ulong(boot_left, tries - 1);
>> +            if (ret)
>> +                return log_msg_ret("env", ret);
>> +            *slot_name = strdup(boot_order_list[i]);
>> +            *slot_tries = tries;
>> +            slot_found = true;
>> +        }
>> +    }
>> +    str_free_list(boot_order_list);
>> +
>> +    if (!slot_found) {
>> +        if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
>> +            log_warning("WARNING: No valid slot found\n");
>> +            log_info("INFO: Resetting boot order and all slot tries\n");
>> +            boot_order_list = 
>> str_to_list(CONFIG_BOOTMETH_RAUC_BOOT_ORDER);
>> +            for (i = 0; boot_order_list[i]; i++) {
>> +                sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
>> +                ret = env_set_ulong(boot_left, 
>> CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
>> +                if (ret)
>> +                    return log_msg_ret("env", ret);
>> +            }
>> +            str_free_list(boot_order_list);
>> +            ret = env_save();
>> +            if (ret)
>> +                return log_msg_ret("env", ret);
>> +            do_reset(NULL, 0, 0, NULL);
>> +        }
>> +        log_err("ERROR: No valid slot found\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
>> +{
>> +    struct blk_desc *desc;
>> +    struct distro_rauc_priv *priv;
>> +    const struct distro_rauc_slot *slot;
>> +    char *boot_order;
>> +    const char **boot_order_list;
>> +    char *active_slot;
>> +    ulong active_slot_tries;
>> +    char raucargs[64];
>> +    char boot_left[BOOT_LEFT_LEN];
>> +    ulong addr;
>> +    int ret = 0;
>> +    int i;
>> +
>> +    desc = dev_get_uclass_plat(bflow->blk);
>> +    if (desc->uclass_id != UCLASS_MMC)
>> +        return log_msg_ret("blk", -EINVAL);
>> +    priv = bflow->bootmeth_priv;
>> +
>> +    /* Device info variables */
>> +    ret = env_set("devtype", blk_get_devtype(bflow->blk));
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +
>> +    ret = env_set_hex("devnum", desc->devnum);
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +
>> +    /* Find active, valid slot */
>> +    ret = find_active_slot(&active_slot, &active_slot_tries);
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +
>> +    /* Kernel command line arguments */
>> +    sprintf(raucargs, "rauc.slot=%s", active_slot);
>> +    ret = env_set("raucargs", raucargs);
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +
>> +    /* Active slot info */
>> +    slot = get_slot(priv, active_slot);
>> +    if (!slot)
>> +        return log_msg_ret("env", -ENOENT);
>> +    ret = env_set_hex("distro_bootpart", slot->boot_part);
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +    ret = env_set_hex("distro_rootpart", slot->root_part);
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +    ret = env_save();
>> +    if (ret)
>> +        return log_msg_ret("env", ret);
>> +
>> +    /* Load distro boot script */
>> +    ret = distro_rauc_load_boot_script(bflow, slot);
>> +    if (ret)
>> +        return log_msg_ret("load", ret);
>> +
>> +    log_info("INFO: Booting slot %s, %lu of %d tries left\n",
>> +         active_slot, active_slot_tries, 
>> CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
>> +
>> +    log_debug("devtype: %s\n", env_get("devtype"));
>> +    log_debug("devnum: %s\n", env_get("devnum"));
>> +    log_debug("distro_bootpart: %s\n", env_get("distro_bootpart"));
>> +    log_debug("distro_rootpart: %s\n", env_get("distro_rootpart"));
>> +    log_debug("raucargs: %s\n", env_get("raucargs"));
>> +    boot_order = env_get("BOOT_ORDER");
>> +    if (!boot_order)
>> +        return log_msg_ret("env", -EPERM);
>> +    log_debug("BOOT_ORDER: %s\n", boot_order);
>> +    boot_order_list = str_to_list(boot_order);
>> +    for (i = 0; boot_order_list[i]; i++) {
>> +        sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
>> +        log_debug("%s: %s\n", boot_left, env_get(boot_left));
>> +    }
>> +    str_free_list(boot_order_list);
>> +
>> +    /* Run distro boot script */
>> +    addr = map_to_sysmem(bflow->buf);
>> +    ret = cmd_source_script(addr, NULL, NULL);
>> +    if (ret)
>> +        return log_msg_ret("boot", ret);
>> +
>> +    return 0;
>> +}
>> +
>> +static int distro_rauc_bootmeth_bind(struct udevice *dev)
>> +{
>> +    struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
>> +
>> +    plat->desc = "RAUC distro boot from MMC";
>> +    plat->flags = BOOTMETHF_GLOBAL;
>> +
>> +    return 0;
>> +}
>> +
>> +static struct bootmeth_ops distro_rauc_bootmeth_ops = {
>> +    .check        = distro_rauc_check,
>> +    .read_bootflow    = distro_rauc_read_bootflow,
>> +    .read_file    = distro_rauc_read_file,
>> +    .boot        = distro_rauc_boot,
>> +};
>> +
>> +static const struct udevice_id distro_rauc_bootmeth_ids[] = {
>> +    { .compatible = "u-boot,distro-rauc" },
>> +    { }
>> +};
>> +
>> +U_BOOT_DRIVER(bootmeth_rauc) = {
>> +    .name        = "bootmeth_rauc",
>> +    .id        = UCLASS_BOOTMETH,
>> +    .of_match    = distro_rauc_bootmeth_ids,
>> +    .ops        = &distro_rauc_bootmeth_ops,
>> +    .bind        = distro_rauc_bootmeth_bind,
>> +};
>>
> 

