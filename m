Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE0E1CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 12:37:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E1B983189;
	Mon, 29 Sep 2025 14:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SZdJBkLP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFAC8319C; Mon, 29 Sep 2025 14:37:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB62A82A9E
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 14:37:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jljFow3jSj97F0GfcaChHbepS/wfOFEJxPPAe9eeDvrLLpN23NW0D/maBdcBNJsJcLVYzEfy7x3+aqrlFHLvSZJ2bDF5RpS0GuiIvl5nEOlZpnXumcoBTGDP3Dm+DI7JNHvdXkZqFRBzthgdAsABoAnILNd9WZqOqrkYQlzoRzuH2L6IgH8SUw+lZSAk4xtXgD1BDSnm6TNKWnvFaHEqsoNmV32909UYOXQBCQFuJj8cPjmb1ISgQ7msLqLfY4i6uupYsdChFdMtiwV94drqJDL9wtjNanYSEQksr5ZeterkctkkA2yFTVkWajwjVa1gwLlxaJgQED9TGoDMn7pV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkzpsXvNYFLHF0h84zd5RiGRnxX75KL97WfnTz8EFoQ=;
 b=uVJr/z8uJ6IbefTE7IuLGdflUQwGApznuN8Vr+p9fTM9ohcZ8vAGr49Wn52Cu6dYyGSDS77MvD8CBNVLFeeYx7lh93u8h5TEABciuudKGBJTor4BWQdraW2Mu44wLizawRWQksX5VYxRIZXVKygRMu/5pGoVDjuFPBi7tRWrrtKDAhq3XVWLgWhHZw+WbTcnLEEKTBs46xqwZiZsYA5e+4YByTlswbEzvdhSjDRdhagwC/Rf9mFsUBzGPPoKOKk+VJg4Qp8n5y8m2WNKCWfqNpqIamldx3In6m49FRy6U6Yl+fHD6MsBVR6EiYk2F7MwtAEbDAhjnz5SKqou0jaapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkzpsXvNYFLHF0h84zd5RiGRnxX75KL97WfnTz8EFoQ=;
 b=SZdJBkLP+C5Svf+fABi6tFMnKn9ovyBgkH00elrpDN7lGO46JdSKr4BcF1UXZfWdhdAuqknG/NU+5nAtl1mrK2HGIhPSNLd+Ma1gKLAHMvYfstx6tPvMLpy7nvW7Qb9VHVBfeH+phPdevSZkna+CJ1PFNMoGDsQcvaNjQPP9Hqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 12:37:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 12:37:09 +0000
Message-ID: <a69aecba-186e-4ce4-ba8f-2c72b1d94267@amd.com>
Date: Mon, 29 Sep 2025 14:36:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] env: spi: Fix gd->env_valid for the first write
To: E Shattow <e@freeshell.de>, Marek Vasut <marek.vasut@mailbox.org>,
 u-boot@lists.denx.de, git@xilinx.com, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <7a6ffee423f45507af680c63a86cc50fb9e3a5df.1757489188.git.michal.simek@amd.com>
 <1684bd0d-b831-43e6-8713-95a2675957db@mailbox.org>
 <39f7c9df-9a8a-447d-8689-4f99676fb1e8@amd.com>
 <48de987c-1255-4c90-8477-964d153809d3@amd.com>
 <401851f4-36e7-4e11-9d2e-e85753d916bf@mailbox.org>
 <e436dd80-3693-472b-b9f6-5d27a8310397@freeshell.de>
 <49902e34-a01d-422b-bd60-e97aef7d859e@amd.com>
 <88692c72-1c86-45d3-bf2b-1a21debc5785@freeshell.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <88692c72-1c86-45d3-bf2b-1a21debc5785@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR02CA0055.eurprd02.prod.outlook.com
 (2603:10a6:802:14::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6c2430-a0a7-4c52-250a-08ddff54e85d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnJqQk9WaEI1aEdrVkJBdDhNRmJyUk5WYXpKdnpETmxHNEt5QVRCTFVvd1pE?=
 =?utf-8?B?TXladXgwTjBXbm9OWmg1eFd3T0hoc2JETjBrYmJIelJGL2RBRnMzVzk0SHpo?=
 =?utf-8?B?VG9FVndsSkd5MGlVSHk2ZWRNRzdJTzhiQVU4b2VtNlNhWHVkcVAwaVd1aFdl?=
 =?utf-8?B?aUFpS3VqZTZSNFY0ZW1EV1BjLzRLQVJxU0JWcXlWV2dKQUxWalNpcWErSERq?=
 =?utf-8?B?M3NHMkJlQ214ZlJ2V3hCS05RTFFRMGlTMlhTdUlUbmpDRHI5ZGRLSm1RQUJs?=
 =?utf-8?B?ZXVLV0NheVVkTUlGZEo2dW5iNnhlNkU3T3ZPd1p5dDFDSGhoSlZZQzJ1aFpl?=
 =?utf-8?B?a292MDVNelNNM1E0TGd1ZmpJd24vZDJRWVpscjNET2h4bkpyOWhIWmsrSkRv?=
 =?utf-8?B?Smd5ZlJVU3Y2djFmMmkzNmZZbk4rNmtVb0wwZXV0Y2VsRzdjRFVEcjNveHht?=
 =?utf-8?B?cm9oYkdoY0JDWHllelBrSWtMMDBNRXBYd2x0aHo2VjdwNk1Fd1JWZGtwTUdj?=
 =?utf-8?B?eXo2ZVA4T3dqYzRLMEl6MVR6M0xVZkhZZjdGVlA1ODJMSnZDV3IrUVI0R3Jp?=
 =?utf-8?B?STBYYVNnMEtOVC9PZ0tSRTZKcmNYaU1BVmVkV3ZFemZXZkNjMkQ5cUZFN2tP?=
 =?utf-8?B?MXpRTGQwT1A0VmNKeERrY3VWY1d3TW5TWUxqMGhEMFJSZlNGZUxWS3o1Nldz?=
 =?utf-8?B?RkIvNlFkK2g4Wnp1Y1o4TkdzR0JSdG5YMWg4YnBmQ2hpM3hlVXRmaGYzYkZT?=
 =?utf-8?B?L0lJQlAyWjBuMHBoR05Tc2lWSUxja2NQQ2FBUlFoSm5uT0NFVFlySkFPMlRF?=
 =?utf-8?B?LzgvOTl1Mm9XVHljazJlRVdqQ1JHOEJxTTU1TXUzeFVMYjF4UlNPSFJBR1NR?=
 =?utf-8?B?TFdiS2w3MHF2ZjZ6RWdlSzJvZTRsem1ISW5RUktUdXRjWnZRR2J4REw5SHVV?=
 =?utf-8?B?MXJ4Z3Q3UGZ6dCtXV3czZ2hNczlCcjd0dmordTkrbTBPQmlOL0F3VjZ1SnVU?=
 =?utf-8?B?MlFnSFVBTGVhZW91ZXZyOUpBc3ZxMmRvN0l4MThRN0tZWXEvdTJkbEtpUmF3?=
 =?utf-8?B?QWpiVzk5MC9OdDVQRmdzbmJ1dGljU0ROYi9oNVplQjlIdVBjdklnTGwwL1dC?=
 =?utf-8?B?UE9Vby9TSk1lY0FiMGs0Z0tRK0o0NUFDSzB0MUVEOFZrVHNKVUlDSEdpd3Bw?=
 =?utf-8?B?UU84QW9FRVhML01hY21hVjNBRm4vOW5Ta21TRHhHQ1llZi80VHJ5Rm81anBh?=
 =?utf-8?B?dVBGSStRdDVHcE5acXdXVWFFRmFpRUoxd0JWYXo1OHdIc0c0YVhiS0Y0OFc1?=
 =?utf-8?B?SUhGMUtFVUdIL2hFYmMzWlBKUlpUdG03djlDMVpPYmpxcGczclE0SXU1d29R?=
 =?utf-8?B?SWgvMFNHeGF5ZVQ4Q3MwRERIQU9IMzd6R3NaVDdLQUZBV0JYazFYbTNaQldz?=
 =?utf-8?B?U0d5N3RDeGdXY3hYNGFHcTgrclpiZ2NkT0NhaE1ydjA1RUZrak1leUVUTkdI?=
 =?utf-8?B?ME5MT3htUVVtZGFsWUpSeDd6Y3kyOEs1L21NeGd6d0oyaDliakdrcjFKTWl0?=
 =?utf-8?B?QnppQUc1clF4M0xUSjBCYzU0VWRjUC9LL21HdldPQnh4aEZDLzJVNWhkTHpl?=
 =?utf-8?B?ZUtGUTQrT3lFUm5zckgvK2tWUktwQzdBMFlTaUNKSXd0K2wyeEU5VHVFVURB?=
 =?utf-8?B?UEM3TG5sVXdkTDRIL3MvSjJYd1hRb25vOXVBc3VoWWIxclB3T2dhdy9PQTVP?=
 =?utf-8?B?aUJvMjNCVVNaQ3VrN291bmZDZWtNditMa0ZVSmZoSFlmYU9UTkdnMjRVZ3NX?=
 =?utf-8?B?bks3dWx1eVV0YzJJRkNrc0VJUnk4dkxZbXdrWTR2UE4vS25Ra1ozSXFFMUJh?=
 =?utf-8?B?Wk5Ea1M4T0h5blR3N05LNUNYZWNrajVCN2VLYm02dnV0Y2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1UvUm9COVlpcXlnYzNqclZldmVCR0RrUlZNNjgxaE41Mm1iT2FSR29VTzFr?=
 =?utf-8?B?MWFPSG9iSDNWaXRzK2JLbEpGTnZpMVROWWxxMm5ZUWhvTFlydUtqZFZ0RGkw?=
 =?utf-8?B?SnVDQkxXTzBmNVF6SzdQV1ExN2RoWnZWV29pY1BWMXNmY1lOdThOdXp5eEU5?=
 =?utf-8?B?Y3EyaFpheDEzSWwvNmx3VjlHT3h1RzNyM0hjMStMZ0QyL0l6TmFRa2NxcTMv?=
 =?utf-8?B?OGowZlhFUzFtc0RPYnhmSnI2U1dsbFdjTnoyRitPNEdCNmw1NWRyL0NkTFdD?=
 =?utf-8?B?RVg5VEVpajhaeE13Y25DaHRXR0VVMnRTbDRyR2J4bGxpT25ScnFTVGhJSmhi?=
 =?utf-8?B?ZGx1NkhsRW44dUZpMGJtY0VHeGp4LzlJaVc2am1McGRjVW9iWENjVWZrbkg0?=
 =?utf-8?B?WmRaRlc1Zk9LWW5YdmNkTHA1M3o0OGZZcTQ5Y0NLckt3S2hUYUlPUUVwbXpY?=
 =?utf-8?B?dWQySUlrYUFFTmtPaWtSMloyQnoyQ0xxLzdmN0syMVhWT2RTTWh4Y3ZBQ09h?=
 =?utf-8?B?T2U2VmJrakhTOUdCZFBON1Qvb1VocE4yNkp3N2xmdzA3YkYvdFJ2a0x0aWhE?=
 =?utf-8?B?OEJJdTZrWk9DTDlHVU9RL3RLQUV0bzhnWGxXQ09HNjh6T0NIdUFyZU0yZmp1?=
 =?utf-8?B?dFk4ckRFRXFtVEp6Y3k4ZVY2ZU1paFhQc3ZCaENCNXFsWE9Ha0dwU0U4ZjNh?=
 =?utf-8?B?U0ducUdGcWRBcmkzd3dyRm5SYXhpMy9HWDI5ZElPTjFGOVpPamxBbm90U3N4?=
 =?utf-8?B?UlY5NC9KcEhrVmlNVDFleEhCbFdZbTlHL04xYmxqaGhlamZkL090aG5lTWFo?=
 =?utf-8?B?ZWtyS1k0cW9pazlraXBGS0RQdlI3ZWx2bEJHdUNFUGg0MzBaQStYNjd2T3hG?=
 =?utf-8?B?RjVVV01mUEZTUklWcnF3UTdnQ0o3cXZ1Vi85THVNek9ReGNmbnFvZjBJd3dt?=
 =?utf-8?B?Z04vOERPd01zeUUxRHpuc1lOWUtPclFwSlpkTmdsQTV6b0xCYUxNOXJQdzY0?=
 =?utf-8?B?OEEvQWdYS3ZKczdEaFdTNU1VeXpCUk85UzFIMzBKcVM2ZzlPdUFQQ0hKWW5h?=
 =?utf-8?B?cnh2cHhmWnppY3lYb3JrNHNqd3VjY203cjkxc25IYnZDT1N4NlhsYS90N2xX?=
 =?utf-8?B?eWxNbHVoZHJDQkQ5NzJNMWdEOGxjc1ZPS2VHSS9ybUtHUk55NUJpQnJiY0w1?=
 =?utf-8?B?R1hYSFRxUFRFZ3NBQ3I3c3RhV3NuRHphOVVlRTZtdWhNd2FxeFpycG50Q253?=
 =?utf-8?B?OGczT3NuMTk2OGZvdnFtK1BTczhuTTJjYlpzeEp2QUJ0OVdpd0J3R2V3eUNL?=
 =?utf-8?B?dXpXYWlMaE1nS2pyanZCWGhBbmtKcUgrMWJycVgvV1dUQUk5a3NEZVNaaXVa?=
 =?utf-8?B?TCtDY1dWRUsrcHZ0c0JzVFdHb3piaHY1MlJrVXhDT2JvS1JmSk84cTlZaVo5?=
 =?utf-8?B?UEFPWE96V1RFMmV2UDl6eXFFMUVacXlvMWZUanVXdzVIbjBpbk9kUUxOWmJU?=
 =?utf-8?B?ckZuZHlWK3REYjM5eVFOdHFOTzNNc2FmVXp2UTZWS1lGeVV6K1ZwVFNTRGwy?=
 =?utf-8?B?SWlyNldPbisyUWdaNWJ1MnorSXp4OExITG0vOTRiUW8xKzhLNnJMV3lYMUM0?=
 =?utf-8?B?TE5HNVp6cVhZRjF3LzhQM1ZzU2JCUm5lTnVjbDMrampyZDFIa0NRaWZWZWxG?=
 =?utf-8?B?VkVRTVl6VG1iUDVZakhDNHhCQUJ4MVFueERPZ09PNnVkRVhEVDdrTFVXN09i?=
 =?utf-8?B?TnplSEZPaXp2bEw2Z2thWDU3NmtJU0hHelM0MUN3OFlHbGUrZWQ1TnlwRWI3?=
 =?utf-8?B?NDhBWjFQeGdicityYU9FZllzRTc5RVRLWjExcm5yclZ3TXRQdVA4V2NvME96?=
 =?utf-8?B?RVU0ZVhNdlMzcXpPcHZEd0xjZFdPelhjWS9UZnB4M2ZWYXJEV1BSazI5cXd2?=
 =?utf-8?B?OVhFNHdNUHNhbjc2SUJBT0dxWmpVcEtvOGY0RzNiNjZxWkFlS2liRWtXK0g1?=
 =?utf-8?B?OVNRVmphTEl3YlRzb0VuSUlHK0FNeVlpTHZQSktzdzhMclJlOUE2cFducXNH?=
 =?utf-8?B?aXR1aFdmdXQ4YUc4M3RPUm5DZ0JDQWRac00wdlcvRnNVSnNKM3JZNHh3ZlFH?=
 =?utf-8?Q?sga/RHxks2Zu0h2BSuKynUkPr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6c2430-a0a7-4c52-250a-08ddff54e85d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 12:37:09.8902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: go7GMNDJ68omqEAiLLm/Apks2h8k+i8lee46CdQSPP2aUKMOj4fJixdCG4v9VmzR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
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



On 9/29/25 11:49, E Shattow wrote:
> Hi Michal,
> 
> On 9/29/25 00:08, Michal Simek wrote:
>>
>>
>> On 9/23/25 23:18, E Shattow wrote:
>>>
>>>
>>> On 9/22/25 07:51, Marek Vasut wrote:
>>>> On 9/22/25 4:02 PM, Michal Simek wrote:
>>>>>
>>>>>
>>>>> On 9/11/25 07:40, Michal Simek wrote:
>>>>>>
>>>>>>
>>>>>> On 9/11/25 05:28, Marek Vasut wrote:
>>>>>>> On 9/10/25 9:26 AM, Michal Simek wrote:
>>>>>>>> In case of ENV_INVALID (uninitialized variables) the first env
>>>>>>>> location
>>>>>>>> should be used for storing variables.
>>>>>>>> That's why change the logic how env_valid is setup to be aligned
>>>>>>>> with
>>>>>>>> offset calculation.
>>>>>>>> This will also fix the print about Valid environment is showing
>>>>>>>> proper
>>>>>>>> location where variables are saved for the first time.
>>>>>>>> And also fixes behavior where the first two writes were going to the
>>>>>>>> first location instead of the first to the first location and
>>>>>>>> second to
>>>>>>>> second location.
>>>>>>>>
>>>>>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Changes in v2:
>>>>>>>> - Simplify commit message
>>>>>>>>
>>>>>>>> Origin commit message with more technical details.
>>>>>>>>
>>>>>>>> When both location for variables are not valid (or empty) gd-
>>>>>>>>> env_valid is
>>>>>>>> 0 (ENV_INVALID) which is setup by
>>>>>>>> env_sf_load()/env_import_redund()/env_check_redund() calls.
>>>>>>>>
>>>>>>>> When saveenv is called in case of SPI env_sf_save() is called which
>>>>>>>> contains logic which describes new/old variable locations.
>>>>>>>>
>>>>>>>> if (gd->env_valid == ENV_VALID) {
>>>>>>>>            env_new_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>>>            env_offset = CONFIG_ENV_OFFSET;
>>>>>>>> } else {
>>>>>>>>            env_new_offset = CONFIG_ENV_OFFSET;
>>>>>>>>            env_offset = CONFIG_ENV_OFFSET_REDUND;
>>>>>>>> }
>>>>>>>>
>>>>>>>> In case of ENV_INVALID option the first location is used (else part)
>>>>>>>> and variables are saved with ENV_REDUND_ACTIVE flag.
>>>>>>>> The second location flag is rewritten to ENV_REDUND_OBSOLETE.
>>>>>>>>
>>>>>>>> And
>>>>>>>> gd->env_valid = gd->env_valid == ENV_REDUND ? ENV_VALID :
>>>>>>>> ENV_REDUND;
>>>>>>>> is executed. env_valid is ENV_INVALID that's why ENV_REDUND is setup
>>>>>>>> but that's not correct because the first location has been written
>>>>>>>> and not
>>>>>>>> the second one.
>>>>>>>> That is confirmed by
>>>>>>>> printf("Valid environment: %d\n", (int)gd->env_valid);
>>>>>>>> which is showing number 2 (ENV_REDUND).
>>>>>>>>
>>>>>>>> That's why change the logic how env_valid is setup to be aligned
>>>>>>>> with
>>>>>>>> offset calculation which also cover the case where initial state is
>>>>>>>> ENV_INVALID.
>>>>>>>> Then print about Valid environment is showing proper location where
>>>>>>>> variables are saved for the first time.
>>>>>>>> But also it is fixing behavior where the first two writes are going
>>>>>>>> to the
>>>>>>>> first location instead of the first to the first location and
>>>>>>>> second to
>>>>>>>> second location. Alternation is happening after it.
>>>>>>>>
>>>>>>>> v1: https://lore.kernel.org/
>>>>>>>> r/03aa59f72f47fe0ecafd1e1ca52cbb8a5a8f0446.1755613540.git.michal.simek@amd.com
>>>>>>> Sorry for not being clear, the original commit message structure and
>>>>>>> technical details were fine, it only needed slight rephrasing, in
>>>>>>> the original form it was very hard to understand. Can you please
>>>>>>> reinstate the original commit message and only clean it up slightly ?
>>>>>>
>>>>>> Can you exactly point me to part which wasn't clear? It has a lot of
>>>>>> details about flow and obviously it makes sense to me that's why I
>>>>>> would like you to point me to exact part which should be improved.
>>>>>
>>>>> What about this?
>>>>>
>>>
>>>>> When both SPI environment locations are invalid (gd->env_valid ==
>>>>> ENV_INVALID), the first call to saveenv writes to the primary location
>>>>> and sets the active flag. However, the logic for updating gd-
>>>>>> env_valid incorrectly sets it to ENV_REDUND, which does not match the
>>>>> actual location written. This causes the first two writes to target
>>>>> the same location, and alternation only begins after the second write.
>>>
>>> nit, the use of word "alternation" here reads as splitting (no
>>> duplication) the data one-by-one into multiple targets. I would give the
>>> game analogy of 52 playing cards and alternating to deal the cards to
>>> players, each player gets one card in a sequence of alternation; if
>>> there is more than one player in the game then no player will get all
>>> the cards from the action of dealing the cards.
>>
>> tbh before this patch I though that both copies are the same but that's
>> not how it is implemented.
>> It is switching from Location A to B and then to A, etc.
>>
> 
> Okay. That is also surprising for me.
> 
>>>
>>>>>
>>>>> Update the logic to alternate gd->env_valid based on whether the last
>>>>> write was to the primary or redundant location, ensuring the first
>>>>> write sets ENV_VALID and subsequent writes alternate as expected. This
>>>>> aligns env_valid with the actual storage location and fixes the
>>>>> alternation sequence from the first write.
>>>>>
>>>>> With this change, the "Valid environment" printout correctly reflects
>>>>> the active location after each save, and the alternation between
>>>>> primary and redundant locations works as intended from the start.
>>>> Yes, perfect.
>>>
>>> I do not understand what this description is saying because alternation
>>> of write operations to multiple targets would not be redundant.
>>> Alternation with the meaning of "fail-over" is similarly not redundant.
>>
>> How the code is written is that you have location A and B.
>> And when you call saveenv variables are written to A.
>> And next saveenv variables are written to B.
>> Next to A, etc.
>>
>> It means unless you call saveenv twice you never get data in A and B equal.
>>
>> It means it is not alternation of write operations to multiple targets.
>> It is alternation of location where one complete write is done.
>>
>>>
>>> An alternative method has the meaning of "do something else, do not do
>>> this". In the common use, an alternative may have the meaning of "do
>>> something else if needed as fail-over from what is first being
>>> attempted". Do you intend for the meaning of "fail-over" and "duplicate"
>>> or "duplication" where you have written "alternate" and "alternation"?
>> I am not a native speaker but the word alternation between A/B sounds
>> the best for me.
>> Feel free to suggest how to describe it better.
>>
>> Thanks,
>> Michal
>>
> 
> This is not easy to describe with a small quantity of words. The common
> phrases are "taking turns" and/or "round-robin".
> 
> It is clearer to say what this is not, as:
> 
> "... results in alternation of saveenv location with each invocation.
> Data is not duplicated or striped between locations for any single
> saveenv invocation."
> 
> I like your explanations, you understand the functionality and can
> describe the problem clearly. I just do not expect that functionality
> would be useful so without additional context and full explanation it
> seems unlikely to be what you say it is. Thank you for expanding on the
> meaning.

What about this full description?
M

When both SPI environment locations are invalid (gd->env_valid == ENV_INVALID),
the first call to saveenv writes to the primary location and sets the active 
flag. However, the logic for updating gd->env_valid incorrectly sets it to 
ENV_REDUND, which does not match the actual location written. This causes the 
first two writes to target the same location, and round-robin switching only 
begins after the second write.

Be aware that data is not duplicated or striped between locations
for any single saveenv invocation.

Update the logic to perform round-robin selection of the environment location
based on whether the last write was to the primary or redundant location,
ensuring the first write sets ENV_VALID and subsequent writes follow the
round-robin pattern as expected. This keeps gd->env_valid consistent with
the actual storage location and fixes the sequence from the very first write.

With this change, the "Valid environment" printout correctly reflects the
active location after each save, and round-robin switching between primary
and redundant locations works as intended from the start.

