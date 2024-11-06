Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225B9D29FB3
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 08:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6785D88D09;
	Wed,  6 Nov 2024 09:38:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A+hq8Bhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C06188E63; Wed,  6 Nov 2024 09:38:56 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF5688CEC
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 09:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ov9zhO7ClJ52ZqW/IctWsZ8qA8iJneZa8dmV5mHucEqEQtbmY5gZGzdx7sc/5mU/iEUygKOcbqe/hLqT5oDuqdU3yGlskuAxQZKTn7XvjQablxRFWPRMgbfP6iHpzPwcjaFdnPUXSzqSiBJ5Kl1HL27bUMNyWGVIgA0W33ZvhMIwJ4FFZiFASDeR9gXpJ02XvD9pqlE66W4Cc6KmhivLf5KwQm1mcuyBTXpflZittu7nzD4d/x6GYUYFhfFVlp8Mv/BKuY7kaoCgAhqK3hc07FSgp2vQrTrNro/V7S6lj1s/8UQIigB3uCBs397l04oC4LuDMkXa3xhOn1PFCTKP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHldF8xNje3cUOA9pYfn0cusVWKbF17KXyskjcj14J8=;
 b=uEPdjbSA47N8yovNvp/sjcM7p7JBuSB0mKuIvi/z4//HA0svVrJbY3PV77+LxMgTBvtpkR7RZjM/kUS9OjqMIfLmGwHhnJnuqrQWqg9BCZC95IGv6us0Yd56DGMmesfG+6B7QEz3uPJrAhqRpn4FSzaTwziU0mmw2pG/XJcMO2xbATlQOpOD07wcQhXVkYkKFMCBJLElT1BAXgKd7pUQPkE0/G4xcjeSYZyXo0SupoN/V4zvcjq0rM7YVG+N4fKnmz8qSfJdYaMwTrnaQh2GrU/3s2DP5SI7MiNOkjBNfoN+IWgkI5IMTBeoalVT7sDGyJAlisDM9tH/SPRALxtQsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHldF8xNje3cUOA9pYfn0cusVWKbF17KXyskjcj14J8=;
 b=A+hq8BhctL9/GwdDk/bFBX4gfmSwW2cmCF4REF7DJXtheo4/JbdpX6fcqP4/fBDpgEUBHkGl+8kYlHZwDRbaY7Gs+xup3+vWGSMysEYkk/c48qO5zmyeU969rhCb5T2/8SA1XxkpuLNQeDrWU4szHqueVKXW5s5wprn2vSmF+tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 08:38:48 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8114.031; Wed, 6 Nov 2024
 08:38:48 +0000
Message-ID: <23e4e07a-43ce-4037-9cb9-d528b2b10d8e@amd.com>
Date: Wed, 6 Nov 2024 09:38:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Fix r5 mode for cpu release command
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20241104122750.96251-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241104122750.96251-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0113.eurprd04.prod.outlook.com
 (2603:10a6:803:64::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: bf0f60fd-98b4-4edd-932c-08dcfe3e6f03
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YThQZ1E4Z2V4cUQrc0RRRkhKOXgvbmJWMXlxaDNlR3dlQmE0dVdkL1ZMcFE5?=
 =?utf-8?B?bndhbnhLQlBoblZrak1YYXZZdDEycm9lS1BPVG9BQkgwSFhKNE04clVNM2hl?=
 =?utf-8?B?Y1pZRW1yTTZ3bXFHK3ZLYzlBWDU5dUlIZ0dxbExZMzRpQnY3bURNWkZVVGJ1?=
 =?utf-8?B?blQ5WnVMeGIwSFhCa3pCektic3pmWU1NdFlLQVNZOUVUREZGdG5YU0o2VkFQ?=
 =?utf-8?B?OEtTQy9yY0NvaG84Q21UeklhL29vZG9lRW5ubDI0bnloenh4M3FLREVsa2lU?=
 =?utf-8?B?Y2pkT0VMSlQzNjdRRXY1MVNVUjJ5aW1oYjg3TkNtTHBEcXFhZ3BNRmNncEVt?=
 =?utf-8?B?RDVJU2dyRngybXE1TU9lTThKMXFTRG43T3lsUVBiNW5iZFJtZFh0UHNCT1Vs?=
 =?utf-8?B?TndpVS9WYTVUdG9TekI2Yk1PSGFNRkx4TnRQOU1PNzZEYXN3bE14MEtnRXl2?=
 =?utf-8?B?K0p6N0NoMWdTSWhvcTlhYnVvcHV3SnFzSzlmWTM2dGE3VzQzSWZOTXR4VHZZ?=
 =?utf-8?B?cEJUdEFzaEg4SDZxM1ZCN25mQzJDalhOSVVQeWpldHJYWS9GSFF2RzdMdi9T?=
 =?utf-8?B?THM1SngvckZFM0x1UkdvRzBNQ2d3WC9wRzNId2xLR2ZRMGdnb01ndlpkZnB0?=
 =?utf-8?B?c3ZnZkhqNjlGMWhyT3ZlUXJFdWlDZlpWcmxDS1BoQlZVY0c3bUd6VDZzblZK?=
 =?utf-8?B?Z1BuYWV0SEszRDV4MXJUV2N3bHl0NXVrNGk0WU9RSkRNazh4Qm5OWTE1ZlVL?=
 =?utf-8?B?SmcrVG5NemNhTHBnNmdKbU41ZmxtT3RCRi90RTE0cWE5Q05pRGw1MytqNk93?=
 =?utf-8?B?cTdLTUgrNDdtZGRpN2ZGS3pxbnhvUGdUdVloSXVKU0NHUHRYd2Q0Z1E4Wm9s?=
 =?utf-8?B?MWRwWjB6WkhQQUdZZTN5UGZnTG5VUzhhU2dBVnB1QWVwZmE0WUhMVWppS1o5?=
 =?utf-8?B?bDN1aURXbDJER2dTQVRzRlhKYVRuTHh0b3dpS2RKeENTVDd3RUlOL2pNeitI?=
 =?utf-8?B?azd2VG1raHIwUmU2TEpiQ2V2MnpCT2Z2ZEs5OFMrTHB4REQ4QUIwdmo4RnRU?=
 =?utf-8?B?WHowUm9ONmU2eWZER0RVVW5YZ2JNbWw5QStxNm94VUFVN2cwUE1tbTV0Zmxz?=
 =?utf-8?B?cjZsOGtEMTZ5SUFpRE52RVlJRUg3ZFhYN1VVQnR4eHkrY3RuR015MjEySnVR?=
 =?utf-8?B?V3dGYnQ3Nk9OM25Wa1BSa08xeHJnUUxEdHEvTVdLRjZvWFpyNWJpczcyZy9m?=
 =?utf-8?B?YXpyM3EyUyszT3FURjBacTFabHhVUkxRQ3VZcDRwR3RRbUxoV2Q5MlgyVzNL?=
 =?utf-8?B?MHJ5VXhjYnk2TCtld25VN2JRVjRseFIxb0ozRUZCK2drbjArR01aVUhTWDly?=
 =?utf-8?B?Rjh3Z1RDNlhORlZYWXcwVGZLbnptWjhrYzRKNE5VTW03OGpkL0IrcWJoTDlM?=
 =?utf-8?B?NC9qc0Z2ZEFiVmUweHdXc1dnTUFTdCtxeUp6MFpJN3dUV2tLTnRnWitHSUt0?=
 =?utf-8?B?SjVUMnhoOTVXUk01LytYMkx6L2Y2NWhRWWl2WnVaY05mMjg5aU5yVk03VUdu?=
 =?utf-8?B?RmwyQ21hMzJCQnhYbnFkY2FBTm5nUVlYWXI4SHFpNklFVDh4aXozUG5SaXZz?=
 =?utf-8?B?OHFBbHJiR1NHTnB6L280VTdxbkt1ejdiVDlXSUtWZGVoQ0NEb01Za3JPQ2VT?=
 =?utf-8?B?UEowTEV3clZPMk1BenZFSlZFbmRSWmtIcUhGWEZUWUp0Z1gvV1RWR1l1WDVJ?=
 =?utf-8?Q?AaK/z/TqTWfZ65LULQsDJn40o3Js4Ij5VGvqQua?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXp6akwrNHdiOGF4S2F4cWwyUTlwaDFGcXU1WWFyOWg0OHNpSlVNMU5IYy9M?=
 =?utf-8?B?SEQ0TUplcG01Rjg1UlZGcGpzQlZUbHduTm9GSzlJdWJrSjN4ZVFYSUhIZUZi?=
 =?utf-8?B?ZndVb3FUdXpLM09NV29QMHJzYzNKSmM0L1h5RkRKUXdlZTRNTThZUFBHb1o2?=
 =?utf-8?B?NEdWZ25ncFZaRlhSbnB2ZmtyaEc3Rklzck83NUZvTUdaaTBSVkJ0U1RiLzVs?=
 =?utf-8?B?VEJoVlRaYmgzRCtycWpKdlFPQUdQRGhNMXFSZExjeTVVMWhFWlVwWUdpNWd4?=
 =?utf-8?B?M0N6alhVOTJJbFZkTTROemtWUEYxRVU0R0hVcHlTcW0wTC91aFVJcjJnYnVL?=
 =?utf-8?B?d2prMFNFT01mM2dwZUtnV3VJblJMdlRNVWJ1ZGtlVThQbDgyZStqeE1zY3NX?=
 =?utf-8?B?YWNoNFJtc0I5K3E4cmhhOVBuOFphMi9Tdys2L1VjUFFpajlnbHpOK3c2dHlV?=
 =?utf-8?B?NEJIZDJ0OHpaZS9LS3dSSk9scHNHcXlEeGgzdWM5LzBXcEVxRmxwY3E3Sm5Q?=
 =?utf-8?B?VXMxbzA3RkJJSzZjTDg0VUlQcFdRTEJLS1VNRDdJWmpzZHd3MzFQUko5M0JF?=
 =?utf-8?B?dWZ5b3hIVUh4ZmpTbjVaT3QwZ2RuQkVPQTNOeURQMUx6VTNXdFFUR25rYXg2?=
 =?utf-8?B?TEwveEhrYkJ2RmNaMGxPdTh0alJCOUp3cWtXVTRBTU1DSXQvR1EyS2RETnNp?=
 =?utf-8?B?VUJ3aTRxb2xDSmxuMktFVWRLZmxJNFNFSThXUmpHMklZbzk2M1drQUN1MTJM?=
 =?utf-8?B?K0dIZU42YXVRa0pUWCtWSUN2dGI3eUNrNDBnYzdaNmIrQzd0WGkvUGo0Zmhn?=
 =?utf-8?B?QmhQRlZ4M0xKMElmbzUwRXE3WlBqditsNWxCdHFxTWlDODF4ekc4R0NOWWtO?=
 =?utf-8?B?RTk5QzV1MHNrMHA2amlyazBXanEwS2ZtVGdhZFlHRDdPOWdXNFZUbnlLdUlX?=
 =?utf-8?B?cmQ1WGxvZXJ6SDZjY0tWaEdjalJralRwZW5kYzRRbFRveGtCSDl0bW1Bb2xN?=
 =?utf-8?B?bG00Q3F5N3NGeGRjWTNUQnhFMmJZaDVDQmJZeVFxbG42MzNldC9Sb3Q5L1k2?=
 =?utf-8?B?Y2xHRG0wdHR4ZTEyb05NZEJyQzZwaUdzdkVYRXZkNTdSS2w2WXZXVGtuL2Ri?=
 =?utf-8?B?OUd6U255aHJDcG9KeEFuUE9xTGMrUjY1aW8wMUpCRDJRdkFJZzZUQm4xYWVX?=
 =?utf-8?B?SW5MOEFWbUpyb0JYZ1l6SXE1MDZ0RmV1MldGVFlGQXVSTXYyeVFPUTRjTmpF?=
 =?utf-8?B?TkxFbFdURWVPZzNRUlNUNG9LSmFXZUZTK3VPd0V5M1ROTXgySFFaUXQ4eGh1?=
 =?utf-8?B?MzFPSlJqKzVOOGVNMHV1VE40azVWUW10NmxTVzJUaFBkd0ZaSXJKQ0R2Q3VK?=
 =?utf-8?B?MmtST2tvRFI1SnZUcjEyUkRNTWJYUHpBMm8xL1U4MzkwamsxeU5FbmdtTU9N?=
 =?utf-8?B?ZzdMSVgrS2tQM0hyeFFxY25jdkkyTUlVY01KLzJDUmdpU3hHdlJkZldxcmc0?=
 =?utf-8?B?TFZBMCs0UDRNdERiMVJXWGJTRGJlQTZFUFhHZXNJSjF5TkhOdlMwdjNYK3hk?=
 =?utf-8?B?NXNDVTBUVUJ3WllyOFhGNjNTMzgxKzVjaTVCLzBubTZZeVJNb0FQa0FTYzFp?=
 =?utf-8?B?cnJpOTBPMTZQYytQaUorY2FKZUFCemhzeTFrWE9XcnA5Umtjb0dtSFBRTnlF?=
 =?utf-8?B?VkZROXVjUmtuenJKWmZrVy9ibTVZNkMzM3JaQTN0OGNsT3c3dVhEUE42Wmov?=
 =?utf-8?B?ZVFDM3J1M2h5eG53eUVqVm9lNmQ2TUMwZ2pJNUxJTEtDcnFTa0ZveDR4c3l4?=
 =?utf-8?B?RFpoREdjZnRPRFAyQzhOd0xLd04xVnRMSzVjUzMrZ0dzcXo1Q2h1eHRqK25R?=
 =?utf-8?B?bm4zSXgxcFNNajUzeCtFRDZ3blMxVFZ1VVA3Nm5wZjFjSGtDTTFoWjZUWS9k?=
 =?utf-8?B?dWpSTm5lbVQ0dzFxRXlzMXZ1UWRxcjlQZVgvOWJTdW1HcGpLcS9XVVlQdFh0?=
 =?utf-8?B?cEZ3UnhNUHdEem1YaGdTTEdGVUZGK2VSb1JxQXJGUGxSdDE1RENOeEY2Y2ls?=
 =?utf-8?B?ZFo2MlhjeUV0Uzdwdlhua3gvUGNCUUlIY0ZoUFZ4d21tMWVZTmpXbDdxbk9I?=
 =?utf-8?Q?Mi+EaIA2dV+Ds5g/57mwmNNON?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0f60fd-98b4-4edd-932c-08dcfe3e6f03
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 08:38:48.6118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIPFrRKkDL5sAbSSPbFsE8EU/5vDXXTTO5B5IhK+QHyNSlaZ8JE3Si15ioHMaB1L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550
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



On 11/4/24 13:27, Padmarao Begari wrote:
> The cpu release command for r5 mode (lockstep/split) argument
> accepts only string. But the zynqmp tcminit command accepts
> string or number for r5 mode (lockstep/split or 0/1) argument.
> To fix the r5 mode argument, the common argument (lockstep/split
> or 0/1) is used across different u-boot commands. Use the strcmp()
> instead of strncmp() to make uniform the r5 mode (lockstep/split
> or 0/1) for the zynqmp tcminit and cpu release command.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   arch/arm/mach-zynqmp/mp.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
> index 6e6da8008f..448bc53286 100644
> --- a/arch/arm/mach-zynqmp/mp.c
> +++ b/arch/arm/mach-zynqmp/mp.c
> @@ -352,7 +352,7 @@ int cpu_release(u32 nr, int argc, char *const argv[])
>   		 */
>   		flush_dcache_all();
>   
> -		if (!strncmp(argv[1], "lockstep", 8)) {
> +		if (!strcmp(argv[1], "lockstep") || !strcmp(argv[1], "0")) {
>   			if (nr != ZYNQMP_CORE_RPU0) {
>   				printf("Lockstep mode should run on ZYNQMP_CORE_RPU0\n");
>   				return 1;
> @@ -369,7 +369,7 @@ int cpu_release(u32 nr, int argc, char *const argv[])
>   			dcache_enable();
>   			set_r5_halt_mode(nr, RELEASE, LOCK);
>   			mark_r5_used(nr, LOCK);
> -		} else if (!strncmp(argv[1], "split", 5)) {
> +		} else if (!strcmp(argv[1], "split") || !strcmp(argv[1], "1")) {
>   			printf("R5 split mode\n");
>   			set_r5_reset(nr, SPLIT);
>   			set_r5_tcm_mode(SPLIT);

Applied.
M
