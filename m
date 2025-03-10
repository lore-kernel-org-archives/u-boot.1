Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10E5C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 08:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F12D8122F;
	Mon, 10 Mar 2025 09:04:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QpEppwnN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB723812C8; Mon, 10 Mar 2025 09:04:30 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2408::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B70A180107
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:04:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpqsVbA3HApaHbmewtrdlmvpsf58/WC0HJeGpLeQ0js4kjzl95Uh9msvSUrUOq6xWSirdN9F6IrkT+oqyxUQ1lr9BoLvR2CtgOO9n4o26ukgXkYzP681cpEdryloxqXJkzf8u/1sPa+SEmu4Cyhjdqyhw2M23vAkE9GHbNhdrZfI5iHiYoNBFBfxsE+3VRTHwlVLfBEcbAAfmoqqqASWqEswqwC8dwfUJCgK7ihNl4W6g8+awh0A92/TxLr7OIkkYku/FgTsFMu+o8uv0J8mUbXmgyg9LtN+mU1ZzhKFwbJv132vMijqeSOavLTPA0JZJGlQCUvomjD4WJVS5F8l1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE4DWJ/qNB7RrLrlsSYfLKbENxNDE6zTFIMPdY5sKD0=;
 b=L1BI36FYWIs84rIS9zCeIpmhJ2aPQamGbbU2vN4Rdtphh+RVTrth+PzMuDRDaa5VeR9Hef3Wz8dywiJo9/Vt7tGOUoR4lz0HqIRV91DW2dYtuLA6GgAx3+tKqJ/QEtFE9WmMajVBSGqtPt1znzp7vTkjLZVzbxKJyZm7lYH2PjcenJGzRrDYwGTMlbRnxci0PImw44bCy3so5s1Ooz53ZkVu776qcRrUgW48FFjokLkM7yNaxDU/Y4yuyh0Svx58wk9NY1fgKsMVqrq76vlej7OsYPe3i12cNPeR7zRwnlShLsqDJqX4B5j8GYopHcNCtzBNaiVzDhTC+GjmpzEuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE4DWJ/qNB7RrLrlsSYfLKbENxNDE6zTFIMPdY5sKD0=;
 b=QpEppwnNK4z1X7K9QFeKtWDitkUs7q61Ar27EtUdiY84iRVWub2Zqii44nUMlkDAhCuc8XXeWtIdvt8eyWDGJwnbHMrVRfOd9LvQXBWqvGdCWy1bATnXJOrl11fN5YtmN9Z35bFpyDYR7xoQAMfb8Psp1Fiop3rwH3iJjw1fY70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 08:04:25 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 08:04:25 +0000
Message-ID: <f48c3e7e-142d-4acd-a78b-a72bddd536a6@amd.com>
Date: Mon, 10 Mar 2025 09:04:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] amd: versal2: Add the UFS boot mode support
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, bhupesh.linux@gmail.com, n-francis@ti.com,
 git@amd.com
References: <20250225032806.1842581-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250225032806.1842581-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::20) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 57afb703-5055-48a9-3e7e-08dd5faa2c60
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlFDemRzSHFPd1hiR3U1RHV0ckVuY1RWWE9OcmVOU09PbDExbExvSzVlZHow?=
 =?utf-8?B?ZDFCS2lnck1EK0hNQUZrRjdyczJaWi9hL3hybXlTNWZPL0VIcWpzNlJKK09U?=
 =?utf-8?B?dFlMTVFMVngyRVh4NWRFY3R3T3pJRFNFaHRZWGQxcmMzS1U4SGhjVXJ1MCtq?=
 =?utf-8?B?ZmFia3E1Um9HNEVRZmpJSGF2eHg3V2RsbnN5SFZVcG9LMUk0SnQzL0UyZm9E?=
 =?utf-8?B?dWk1MkpnWTF5WC9DeWtVV2FacEc3MUlHUzh1ZFprMDZudTZ1ck1RQ29xK1pq?=
 =?utf-8?B?S3lYWkFpM05ZZjBhOHNQQ3Q3VnBJTFpBSTRkd3dadFpVMjRzZnpTMGFDUmpV?=
 =?utf-8?B?TnBNM1QrVEFpL1lWWUdxelYxUDVHcE1YNzdtNWhoZEJMMytZclBtc3V5dUdC?=
 =?utf-8?B?L0E4dUN1R2ZSSDBHTlJyN1JIZTNVY1pEVGFtWmdTcGhwTVV1NTVMNUZUaWR4?=
 =?utf-8?B?eHdjK2h0UWQ1MTlOSnNXSnV6UzdocUdKeFhRYTRSYjhuTEVsdUJjOEx4aFYv?=
 =?utf-8?B?dHZFTkRkQXZnTlNMU1JNL1RPN0N0OENHcVJNdEo2VFNScHRxL1hueEpySU5R?=
 =?utf-8?B?QnNBRjcrS0NTWWE2aE82UXpVQWlJcWFISVRQcHJyMVk2OXJFb1paRW93S09V?=
 =?utf-8?B?UWVjR0graFBESlhhdXFoaUp2YlB2V0ozK2UyWnl1c0JsRm8wNkpQS25HNXoz?=
 =?utf-8?B?SllOTkVmNzRmcExObWNLUU1mWFkwMWJzRUZoTWc4d0ZqdmJVUndGUlU5L0R4?=
 =?utf-8?B?eUZzUG9aV0M1SmhjWHJKUUg3ZllaRU5vbHlDRlFJSTZHZC83TCtBWFVCZUZy?=
 =?utf-8?B?UjBmblorQndacEZYMC9aWEY1dGZ6MVZLSS9RRFdUS3Q1eFRzRGtBMUxJOXN1?=
 =?utf-8?B?SjRyaXFyb2RCcU1mYUR2V1M2VXMxdlpxd3RQdjg4Vk9WN0JXbEh0ZnZneXor?=
 =?utf-8?B?eWY4YzFlMjg4dVlYWVRxWlBBNVpZOUdDSnlvSUR1QWtMdzJFVE5CS1h3NGVU?=
 =?utf-8?B?YkRaUjFBbGk1djJvYk9kRUF0eTU3VzZIVm5tbHhVOUkwNDFZcVNFUllvaXNq?=
 =?utf-8?B?UmRjMHcwWXo1VFlQR25PUWZBcnpWL3F2WER2Vy82dXFwOGdYWW1ib0xaYkVQ?=
 =?utf-8?B?ZGZFeC8vdEs4dnhZcVNlZFloYnY3YUhQd2UyVG15UTNsZ1FTL3NaTFdFOERt?=
 =?utf-8?B?L2hVYXE3QUoyOUk1VWdrMlVjczNJT3RmKzVJS0RvdWxsQURyK1ladWZJTmxK?=
 =?utf-8?B?Z2xQa2t3R1REcXRXUjBQYXhBRkxNWFRyRlhMUEJFMnVUeXZjT1lQRFhXdFAr?=
 =?utf-8?B?ZGJWNjZ5OWRZQkRvcU53RzBJSDFxRE9kdlY1QkRubmxLQ0tGaUsyb1FEMUlm?=
 =?utf-8?B?eUVJY29ac2lrZS9LQ1Zkb0svT0s0cTFzb3NjMUhXNmJGOXhOWi85VXcxZEwx?=
 =?utf-8?B?RjFIVlljUTh1TDNIYWIzRDduWVlEQmZpRXR2aVRyVmlJQ21Kb1V5dVNNNlhj?=
 =?utf-8?B?eUhYbG83WkdlcFJZWWRHOEpoOEp4cDVFdnFJalZPL3d0MFR3a0kyZWtKdEIv?=
 =?utf-8?B?QVhxTUFLd2tDRC9DNnJIL0g3MndBQXJ3QkY0SFlEVll5WjZla3gzT09mMjFI?=
 =?utf-8?B?b1V0N0g2UDQvaDYwL01tekdrcFR6MGJJOCtqTjRld1BPV3E0UjVzM2huTVky?=
 =?utf-8?B?ZlpnQjlxOWRCSUJQYjJOSXlQZWtaZ05UTFhoUFBKOElEQ3lqWkJMN3A0SEVG?=
 =?utf-8?B?ZUszTlBoTHNUWGdzRU5JZDZkMS9PTlRUT1lkVVhPWlQ3S3VSck5tdW41UGdm?=
 =?utf-8?B?UmI0ZDc4MWN0TWEwd1F3RTdSMnQvTVhzVGtmV3NJekpNbUhHUm1XK2hxMjNi?=
 =?utf-8?Q?YyPoBH2Cx0Tzb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTFUL1NxcmVZb1hpUUJJUDEySnFlOVZ5K3JQTm1aMjB6a1kvTG51Vk80R1dS?=
 =?utf-8?B?MFlzM3VpcTVUQmRkU2dJcGhYTldIczdiRWdUY1crR0F6T3N6RXZSVEZtWDVG?=
 =?utf-8?B?c0JGZ3E4YXlDaVJ6c3p5S3VDVEgvRkpvbkFpRmg0aGYxQzlQYUE2Y01SUWdw?=
 =?utf-8?B?RzdNTGhUdG12UytwYWlQSGhsVmxweWIrbkNkVVQ2UkUxcWljUzFicjJJT3BF?=
 =?utf-8?B?L0ZkNnNkZkNoVzVHYU5kVHBVVDJkV1BYSW9GSFE1eE5qR0srS1BSNHZ2VDYx?=
 =?utf-8?B?bFhsZExraDlINHFqYUdtdGlLQ09xa0Nza2RkZGZSRUNqUGxsR0V5M2tHL25r?=
 =?utf-8?B?SGlzNXpqQ2RDdjlDUkxsVE50REJpOTAySndjSGQ1d0Qramt0WTA5ZlRoaFdu?=
 =?utf-8?B?enJhLzB5blQ2WHBqWDVUZTlOM0E2MEFGa2R0RHNkdHVLRkdNNFpSOTJSQnpm?=
 =?utf-8?B?Q1RsRzNZN0E0OHkvMDlXdFBBKytSUDZIY1RjQ2NBWjJqKzZpUk8vSlZCdWht?=
 =?utf-8?B?cnhYU1EzelRndDE5eVRnZkMrNlB5UWJQeSsvRG1jT28weCs0MlRNMTNRV3Qx?=
 =?utf-8?B?YnlyOGlnS1ovMmtkcTd1aWpvUjlpSGZEZDliUmFUV2pGY2JyejRyNDYwOEg2?=
 =?utf-8?B?U00rVFdRblpCTzZKaTBQakZGTk5PdkNxSVU0dUJHejdndzdBU1VZY2VvREZP?=
 =?utf-8?B?d0tBNDJOOFJrQUVnM3pzS1R6UlZ2SEVHMytDVkxVWmFldFJCc0IrU3RISzNh?=
 =?utf-8?B?ZGhYamVsb2IxVHpDZGszSUFBajV0R2R1NGhsK3FmYXJGdGRUcEZtYWk4WG9r?=
 =?utf-8?B?dFp4ZlZENDBvR1RxVDdvZWs2dzhjVUJqc0VXTXEvNGpTYjI5U2Q2aFNDOE9K?=
 =?utf-8?B?LzZ3NnRRWjhmaWhpczNnbzlwTzh3MUhic1RwSlVTT2tPRTZmOUo2RmxUeGVm?=
 =?utf-8?B?VFBZN09WditQWklLREtPK3o1VWdJZVdCZkR6SjI2d0RnYUIrSCtRRERaN3lP?=
 =?utf-8?B?bkNGWXB2MnpOeFVoRHhnSVRUM0paa3BXWXRaN01GdlV0ZC9yajJXZzRRY1Qr?=
 =?utf-8?B?Wnd1N3BRUzhPZkNSdkpEMTg3N2doZFNrUUxPenY3Y3pKelQ3Z2Zob3haQ1p1?=
 =?utf-8?B?azAxbFN2a01WQnRPK2RoWHVacCtMUjdBeVZtZEhFVThoeXN3Z01idkhGOS80?=
 =?utf-8?B?QkpjaHkvQ2NjMUdDNWpzR3l5YTc3QytoWnhXWkc5Y3FmalFtdnNSRXAwM0lq?=
 =?utf-8?B?cWh0Y1J2by93MjNrNHkxdlArWlVzTzE4TzEvYjlTMW95QTBqbDNxT3RtaWlQ?=
 =?utf-8?B?YXVVbXljN1BXT0FvY3U0Z2xtcjFZYnFxNHluWU0vUitnTzlVVGNlZzhpTVh4?=
 =?utf-8?B?c0svcUhLZjF5K1Z4RlJsaS9OcTRIOVl3OVp5TkpEV2dvTEVTY09WY1VzeXkv?=
 =?utf-8?B?eUVXRXhzWUxGcTlXUDh5RktpaFlpaGxjd3V1ZFhUYmNGNWN0U0RvVElzUFNa?=
 =?utf-8?B?YVdhV1BkN0hOMThkQWR4dm81aERzZXRHaDNJRFpNdTZ3YzJKbnJqZFFFUkxv?=
 =?utf-8?B?L3VLN1B0TUZ1WEVPN2w4cHhtVkYxclA0bTlwMVh6V2JweHZlZXhCQUV3cDVk?=
 =?utf-8?B?L2wyK3EyK2xncFhqN1paQ3pJNjNBTEZRTkl0WXExMUo0L3ltZ0kySjNVL2hY?=
 =?utf-8?B?cEhENDRDeUozNUJ1UWFOd2pNSnlTejlxWHZlU0VWOHd6WGZyU05lbVR6RGlW?=
 =?utf-8?B?RjlKaVdleXAvNFRySHQzSGdySFZRN0M0YmVEU1RmcFdZZVlFT243UTlyNmN1?=
 =?utf-8?B?Qlh3UzgxaEhnUURTYmpxeDJOejMzSTdCNDUvUWorZW1rL21pR05oVnFBY0hX?=
 =?utf-8?B?dkNJR0tjMlllRjZtTEE0aTRzL0JMelJUbE1hWmRwMHlUMnd2ek5qOVVWNExx?=
 =?utf-8?B?azhyeFJtUTQ3TlQ3eWV2SUE4ZWhmRjA0TXUzbzR2NWVKRGJ0RG85bTgrWGxT?=
 =?utf-8?B?cmhuamRBMVFMR3pJRkl6RXpQejZBSkM0NXBTMVdTZlNINmFkdlVBandiTm5k?=
 =?utf-8?B?amVJZTloSGlvNGdFdi9na2N3ajBlQ1o2SzcwQUV4aWFLOFZjRk5qUHBoWXdD?=
 =?utf-8?Q?5IxINIe0FQkr3bXlCgy63kgDw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57afb703-5055-48a9-3e7e-08dd5faa2c60
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 08:04:25.1131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yviRB0tfdFcYINkktmZzvT8H8agVXoPRN04PRyHVnpRwOUe1hBN/v6gklO3gqohi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200
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



On 2/25/25 04:28, Venkatesh Yadav Abbarapu wrote:
> Add the UFS boot mode support and update the boot_targets with
> ufs mode. If the UFS device is not accessible from APU and
> running this is detected as a warning, as the device is not
> accessible.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Use uclass_get_device() with index 0, as we have single
> UFS controller.
> ---
>   arch/arm/mach-versal2/include/mach/hardware.h |  1 +
>   board/amd/versal2/board.c                     | 10 ++++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
> index 42e3061a0ae..022c8b3c832 100644
> --- a/arch/arm/mach-versal2/include/mach/hardware.h
> +++ b/arch/arm/mach-versal2/include/mach/hardware.h
> @@ -67,6 +67,7 @@ struct crp_regs {
>   #define USB_MODE	0x00000007
>   #define OSPI_MODE	0x00000008
>   #define SELECTMAP_MODE	0x0000000A
> +#define UFS_MODE	0x0000000B
>   #define SD1_LSHFT_MODE	0x0000000E /* SD1 Level shifter */
>   #define JTAG_MODE	0x00000000
>   #define BOOT_MODE_USE_ALT	0x100
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 5651d516a9e..220ab63c994 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -252,6 +252,16 @@ static int boot_targets_setup(void)
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;
> +	case UFS_MODE:
> +		puts("UFS_MODE\n");
> +		if (uclass_get_device(UCLASS_UFS, 0, &dev)) {
> +			debug("UFS driver for UFS device is not present\n");
> +			break;
> +		}
> +		debug("ufs device found at %p\n", dev);
> +
> +		mode = "ufs";
> +		break;
>   	default:
>   		printf("Invalid Boot Mode:0x%x\n", bootmode);
>   		break;

Applied.
M
