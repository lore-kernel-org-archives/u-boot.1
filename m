Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F27C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 17 Jul 2024 06:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FEA886DD;
	Wed, 17 Jul 2024 08:55:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XebhQuQh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8E68841D; Wed, 17 Jul 2024 08:55:44 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7548800C
 for <u-boot@lists.denx.de>; Wed, 17 Jul 2024 08:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfsEiMoQWa7+jR4uSdeGOffhON4UMTaZsqqn0lS+XPLfuZQTmdeLJ5DCfNTgAmmCsd5YOp4HNxwwpz4F+8FNCmjf1HXcBNK9JXYBc38iOuBUEliHb1wQDUqG5mB/G65jiSt36DlA7jVei0bCkQ0Z4H2P71P6zrILhoOpipiCWDpDf5o1I52x08QXJkF7JgSnRdNDi7lsQtP1s/PAxDNkALy9q60vp82yCK1l0RZUgX3QMo2ewOogV5MNS7dHKpmv65D6uPqhwR7jalrr9vTDOUqA6Hm38ONKN/5RkHCRAd8r7Yos0N5TQTB5rDPmwqhk5SHjKPv1hxzAjPFI3NGUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mlaa+iZhq8cyyb7OKqXVq0ZlyRE7oh5lzAzbjHrzvvs=;
 b=KGEgr5zujlVu9xAFmKPEddL1BmJBNDWQXT/iGUrHyBYR7aFDkuwD6vdUwTbveYzJbGFqvUvjkwrNs9X8AhLkb+o+6Iaej2MpsZS2aiw6DF3Z/tOG7AeT80U+rhYLPwUm9hdUz0vqC/9DrQ02n5+GoncEF8rSdskCMmI/zdUnqjNZEO6PVTgSB8zEB2e2U1/Ea3sz5RH3XikLStz9OT0fhxdRVga0hmE+yVLM/V57/vWQlI2k/J9DoaPjcUKnT/ExKXrKVUVgecuGntxwKg5QWimvGRp/z996/LgMkBjt+xRS2ZjnOptIq6OC0xW0iyP7kvhX34MPluULOLuMUtlaFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlaa+iZhq8cyyb7OKqXVq0ZlyRE7oh5lzAzbjHrzvvs=;
 b=XebhQuQhYciKHFQJmEWZafpO6dszlEo1HR5/xXcIT3DbjsbSLCa656UkUFvCbwfK42Av2ps+mAp1lVF8tigH03ADhskNHzWmmU77G2CGBe/bGGY5byZigC53F0PCxTK621XveIs8N2SlDkLFI6MFQhtpWCOocAm7RxFI8tlB+OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7119.namprd12.prod.outlook.com (2603:10b6:303:220::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 17 Jul
 2024 06:55:37 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 06:55:37 +0000
Message-ID: <7f9107d6-5ebe-4656-8815-4be50b886bf4@amd.com>
Date: Wed, 17 Jul 2024 08:55:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v2] zlib: Fix big performance regression
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20240716143546.647604-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240716143546.647604-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0240.eurprd07.prod.outlook.com
 (2603:10a6:802:58::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7119:EE_
X-MS-Office365-Filtering-Correlation-Id: 102ec80d-19d3-4f65-5ac9-08dca62d7659
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dXoyV2hGU0FqWTNxUmZZQTdhZmU1Z1RHL0xXM2VzTWtDL0RFbzJTM242WXYz?=
 =?utf-8?B?bEg3ODRINHptL0pjeUVnR1hIOGxtWkI0STRPTWt1SEgrSlJQdzFIRHF3NFRY?=
 =?utf-8?B?RHVhaElqcHlTamdVS3lxK0lRQzJBcml2Yys4b2FPd1FPd2QxL3hNSVRocThw?=
 =?utf-8?B?YzhTTWxvODU4Tk9oYXpkblJtVmlQODdOdTNmbFdOd2toSTBxTjYxK2dhdGVY?=
 =?utf-8?B?amNMbUYwY215OUJ2S21GaVk4YzI3eWNKeVpMT0dPb2FoRzVuNlRXMm9ZZkJE?=
 =?utf-8?B?YU9XTDRUT0N2Tm1tQ3ZMNjI2SlMzV1hTSGVwd1ZqOS8xZ1AyNHNtdkV0MEVv?=
 =?utf-8?B?eWpzUU5KQUNrbm9tMVQweEpGb0pnWDNXV1gvSGFDVmx5elZZVVVUdnh5S0ZX?=
 =?utf-8?B?KzNLTGFyalJGZlp2Ym5BRzJNWWdIc0tNQVlIYm96NGV4dC9CVms1SG0vN0w1?=
 =?utf-8?B?bUdweGFFcjVKV20xZTgxcGsxSDFXdTBjNVk4RXpYR0FTclhTVHFuamxxSk00?=
 =?utf-8?B?dURSSHhTZlBieHgwd29WSXY5L2o5SVZ6eEFVOWRlQTZNalVjeittNExDQ0l1?=
 =?utf-8?B?K09QY1pvZWZZNlh2eXJROFRESmEvMWlVOEkrY1Nsam9PZHFhaTJXTXN6Z2JX?=
 =?utf-8?B?MXpqM0Z5Y2VxY1JsTmZZNWhZSm5qOWNCWkUzdlhlOVhFaE1CcTl5V1VpRjlS?=
 =?utf-8?B?RVpSYVplYUVyWGVvbzZTajc3aERlNVAyQndoMTI3SnRjbVhXRm5CTU5kYncr?=
 =?utf-8?B?dTdBK2tyREpvTjRLYXRLMmdINElOcjIwS21TbXpWZWE2SVNGSmVKdUxpU1RW?=
 =?utf-8?B?d2Rkc2VvWmR6b1BkcmovTUloc1J5bVB5YnI4ZnNoam9QbXhyUVkrbjRuYUxw?=
 =?utf-8?B?T0x6dEwxMHcrUHlUNnliWjJIMVV6dDRHa2wydEoyQlJkekQzSVFlWlZONkZ5?=
 =?utf-8?B?QllqWGhMbGhoSGZYWkt2dlNGS01ZUGh6QVZ4bnFaZmhsWmUydkc0VjlqUS8x?=
 =?utf-8?B?TWVqS3ZTbVYrUFh0cUx4Z3pTZ0Z6M1BRbzdPTTF6NVRLQzRjYVgwR29BbGQz?=
 =?utf-8?B?bkdnTHl3ZWtMdCtsVmxYSG1UU2ZwS2UxK1Z2TitYalNHUVZNTnZsOCt4b0hE?=
 =?utf-8?B?bFdhYTB0RXl6K1J1RWNlWnZadytNd1BGeHBnamYxNGhKZGs4Tm14cSszT3M0?=
 =?utf-8?B?R0xYMUlOLzJycS9qQjRsbWtNY05oSUhLdGUyUlVZU1NjOWdqNDV3WmxodStN?=
 =?utf-8?B?SHg0QWlNS1BacmRyUkNJL3daeGY3ZGRaZXBTTUY2SGVPMXphZkNTTDUrUDFq?=
 =?utf-8?B?TkNTU3pEcXVFOFNnVkdyd2F3RFBWRFRYL3NvamEvRUdPaW1CR1YzamlBUDVZ?=
 =?utf-8?B?TFFyZm1vK2xRcDZ0TDAvZzNBb0JUcmpESVJMYnhybnhEalhmQTJ6N3AzMW9m?=
 =?utf-8?B?eTQwY0xma3Y3Mkt1TjJmUTZHMnpNTmJiTUQ1dXBlV0ZDTVpzUXV3U01ZYUwy?=
 =?utf-8?B?eUhTbi9udXIrV1hzME40WUdVRVZHdVJ3Smc1MGYxOWFGM3ZkNlRWN0N0b1Bh?=
 =?utf-8?B?d1oveEpHTkFlbDhoaFU2K1Z0OWtRUlkxbFNQb0RaTU54eTkycVhwakhZVnQ2?=
 =?utf-8?B?VUhmYm9wWk9YeEFqa08wWDlreTdLTFV1RUJvL3NteEJ2VkIxR2Q5cEkrMVhO?=
 =?utf-8?B?OEcxMUJSOXd3UlNtNERwdFdvNWdvQWpQdXFaS2JUZ0N0Y2IrQzU5MUx3WU1h?=
 =?utf-8?B?TnZtZ1RYTEtBK2ZkMmM2Rjc0K0FoQ0JEZk5NL1JjNkQ2WW5XUjdtK2NmQ3ZO?=
 =?utf-8?B?S2laNW02b1hTN0xRK3M2dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdDZkxSeTlzL0ZSTENVdmtCSlRDa1ZuSmRMdmsvK1c3ak5EWS9ZS0JCcW1a?=
 =?utf-8?B?OUorT0s1YzlDdVBSMTJTaG9qcHU5eDdNY2NNdWZHM3gydlJqb3pmZk5PMzNX?=
 =?utf-8?B?WTJ6VHZnc2VBUkN0Z0lHWXg1b2RzQytjWjF2MXlVMWhhcXNOelFKeHFGRFJM?=
 =?utf-8?B?b2l2WmgwTnRiSGtvOC9rdXZnM2ZDbVlwdkErUEF6bWROUFRoT1VkV0kzVEd3?=
 =?utf-8?B?NVk1T1pRWCtwMmpIVzNNRVlBMzVpUWUyN3hMTWNVMlJWaVFEemZrVmQ5Vjd5?=
 =?utf-8?B?anBxQVg2RTg0U2FPckFIMWUyeWVnRVY1Tm4ySFpta2o2aloxRjF1MTVQd3dQ?=
 =?utf-8?B?cG03SkFwYXozdlNwdzRwbkNrRExHWGZMZ1NsUTJQNzEzN2RhcEFEQzFoSFQ0?=
 =?utf-8?B?bGNZbWpQNjRGY1lvdnNWdjU5RkNkQmZzYVVpYnQwUjNPYkNoQ0daL0phWGhF?=
 =?utf-8?B?MHdHa245Ukhab1dKQzlGSFQrV2ZIWXdDWnh1VFo4VGJKd1VUQTBnTmtHSHps?=
 =?utf-8?B?a05XWlZqUTJ3bWorRnV3a3NOdFJRVlVpT1M3YUl0SUZCZ3E0RGM3djZxcVRI?=
 =?utf-8?B?MlZqVEM2N3NtTHFMYkFkN2FPVGF2QW1QbmVMLyt0VkdPQ3NOVW9GYTFoOWo4?=
 =?utf-8?B?MlhUVlI2U2pzc0dzZHBEK0Y0SXNhaDZ2QkJEVHBEaUJZY0xyUXdzZm9kdEYr?=
 =?utf-8?B?RGxrWlBqNVgxeVdOZnRwenVmQ2VmTVZwSjIzZkNEN2xrTnRsb3o3bzBzbUJS?=
 =?utf-8?B?Vkt1ZjMrM1BNMG5iWS9XMTR2YkVFdXM0TlBTYkg3eWgrTkM1ZU5yVzJvdU1B?=
 =?utf-8?B?ZjFPd3NHeDdETUhGLy93ODJaZTlCQ3AxeEs3a04xVXo2NkhVQ0RQeUZyUHhv?=
 =?utf-8?B?N0IyNVA5NTBMalU0QldDKzFFdzZFZEErNDdqNzd6YTY0VTBxQXhRL3Q0Y3BO?=
 =?utf-8?B?U3lWdEMrS09xNWphQ0xiK1RDT29rVVdpSXRWNnk1a0NSb2dyZVB3U1BPb1cz?=
 =?utf-8?B?Z0RhNkJVcWNOT2FiSGlPWXRuNURhM1dkWkQ0eWVud3FiV1Bremt3VHU0WmJR?=
 =?utf-8?B?alNYRkN2YmRVQXhxTjd6VlJ2amM3MVhQWnJDK0phRk9veVFSM3BhMjMxV0Jv?=
 =?utf-8?B?SmMxcjBBdm5PS3dhek55VzRyVmU1SGhGVGh1RWFnTjhIM21SY2FnZVlmRXNz?=
 =?utf-8?B?TnFPd09HeG44Y0UxZ2lpRjNEN0ZPMGRDZ3dTK0tQWGFydGwweGVLOVlldSt3?=
 =?utf-8?B?WDlQcVJiM0FNc0c0Z1BjendRWG9yNmY4bWxiZVhYTGxPa2JhdHZGVnBQVVh1?=
 =?utf-8?B?SFdjYjQzNkQzU2hiTGFNZXBZQkp3b2h1V3JIbk00QlkyOHMwSks2RUdNaWI4?=
 =?utf-8?B?VnlqNm9NYVJlMEh4aXBCbHc1elRqaElNYVBUeW1qa3B2Y2NhMUlkYXNXYmRu?=
 =?utf-8?B?Q2pVakFrdWxEbERWKzBpNk8xNFZSUVhabWUzTUNOUFg2b0FnTThyVUp6WkdO?=
 =?utf-8?B?Rkp2djZEbGhNdm43Y1RxRDNiNHNyU1pleU1oR3dqaUFXcTVBcWwydDVPTENS?=
 =?utf-8?B?K2ZPbHZaT0IxT0RsVFRaUGJ6aCs4bzR1YzBkWDk3Vm5LT0g0UHpvZzRsV3Rt?=
 =?utf-8?B?TnpzSS84MTlJNDlkQ3hjYjhHQWpGd1pXMVNFOGNLTms5YmVMbE50K2d1SEtu?=
 =?utf-8?B?YStta1dWbkRFMDhlWG1FbVZqdnlKbzNCN3QzcUNzN1NpZkU1MmJ6VzhzZU84?=
 =?utf-8?B?Zk41UUV6SE1VR2F1cnQxanFQckYvTTRhOWkxOTNkbHF4c3plRmZlWnNHQTZZ?=
 =?utf-8?B?Qm9Gb3VBUzFlNjdlUHJ4VVV6TE1IWTFySDBzSEZlZ0hLb1JLbCs4K20xL29N?=
 =?utf-8?B?UUdBazNLSVlpb0dGWFRXald4blV6QmVrQVVoOG1JZVlKT3B5bUYya3gzVmlE?=
 =?utf-8?B?bm5QMi9yVHZITGN2ZFNObHB2d001QURoYmZDdjlOb1dOdVpxZzNyWmY1U1I1?=
 =?utf-8?B?bFFNM29zNUtENytpVVJuSTkyeUQyZEJRNit2V1dEdklQcUY1MDd0OExmbEdl?=
 =?utf-8?B?VUR0UDJIbElQZVZKUGpoZnk3MGdhdXFsYTNIVWRqRGlIR2pTVlkvU0xRRlpW?=
 =?utf-8?Q?D/NbjwLv1nViO8NL07PNE9Lym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 102ec80d-19d3-4f65-5ac9-08dca62d7659
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 06:55:37.1296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpF+cVE+hyV2KAYHmEngZ5AC5eem2hheqWVsqM9CcdoU/nCB4JUT0tjlf93xXHP/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7119
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



On 7/16/24 16:35, Tom Rini wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> brings a big performance regression in inflate_fast(), which leads
> to watchdog timer reset on powerpc 8xx.
> 
> It looks like that commit does more than what it describe, it
> especially removed an important optimisation that was doing copies
> using halfwords instead of bytes. That unexpected change multiplied
> by almost 4 the time spent in inflate_fast() and increased by 40%
> the overall time needed to uncompress linux kernel image.
> 
> So partially revert that commit but keep post incrementation as it
> is the initial purpose of said commit.
> 
> Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
> [trini: Combine assorted patches in to this one, just restoring the
>          performance commit]
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Given that in master we now have Michal's series un-reverted, I have
> collapsed Christophe's series down to a patch that is just fixing the
> performance issues, while not regressing other platforms.
> 
> Cc: Michal Simek <michal.simek@amd.com>
> ---
>   lib/zlib/inffast.c | 51 ++++++++++++++++++++++++++++++++++++----------
>   lib/zlib/zlib.h    |  1 -
>   2 files changed, 40 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
> index 5e2a65ad4d27..b5a0adcce69f 100644
> --- a/lib/zlib/inffast.c
> +++ b/lib/zlib/inffast.c
> @@ -236,18 +236,47 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
>                       }
>                   }
>                   else {
> +		    unsigned short *sout;
> +		    unsigned long loops;
> +
>                       from = out - dist;          /* copy direct from output */
> -                    do {                        /* minimum length is three */
> -                        *out++ = *from++;
> -                        *out++ = *from++;
> -                        *out++ = *from++;
> -                        len -= 3;
> -                    } while (len > 2);
> -                    if (len) {
> -                        *out++ = *from++;
> -                        if (len > 1)
> -                            *out++ = *from++;
> -                    }
> +                    /* minimum length is three */
> +		    /* Align out addr */
> +		    if (!((long)(out - 1) & 1)) {
> +			*out++ = *from++;
> +			len--;
> +		    }
> +		    sout = (unsigned short *)out;
> +		    if (dist > 2 ) {
> +			unsigned short *sfrom;
> +
> +			sfrom = (unsigned short *)from;
> +			loops = len >> 1;
> +			do
> +			    *sout++ = get_unaligned(sfrom++);
> +			while (--loops);
> +			out = (unsigned char *)sout;
> +			from = (unsigned char *)sfrom;
> +		    } else { /* dist == 1 or dist == 2 */
> +			unsigned short pat16;
> +
> +			pat16 = *(sout - 1);
> +			if (dist == 1)
> +#if defined(__BIG_ENDIAN)
> +			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
> +#elif defined(__LITTLE_ENDIAN)
> +			    pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00 ) >> 8);
> +#else
> +#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
> +#endif
> +			loops = len >> 1;
> +			do
> +			    *sout++ = pat16;
> +			while (--loops);
> +			out = (unsigned char *)sout;
> +		    }
> +		    if (len & 1)
> +			*out++ = *from++;
>                   }
>               }
>               else if ((op & 64) == 0) {          /* 2nd level distance code */
> diff --git a/lib/zlib/zlib.h b/lib/zlib/zlib.h
> index 560e7be97d3a..f9b2f69ac027 100644
> --- a/lib/zlib/zlib.h
> +++ b/lib/zlib/zlib.h
> @@ -10,7 +10,6 @@
>   /* avoid conflicts */
>   #undef OFF
>   #undef ASMINF
> -#undef POSTINC
>   #undef NO_GZIP
>   #define GUNZIP
>   #undef STDC

I am fine with whatever change which doesn't break functionality and address 
CVE. I took that code from upstream zlib version but I forget details why I 
removed this part of code.

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
