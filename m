Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB88D2505F
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:29:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA93583CBD;
	Mon, 12 Jan 2026 10:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AqU6FDTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2337383CF5; Mon, 12 Jan 2026 10:29:00 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF6683CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy/Y4UbE20RbTv6tYOq9IdO/DB6OKzpKbHaaFEPtAqGRniqrxBKlOWXT6bgHShVL1uU33xZZg6rFoA3vSbmiPquqRDjP6iFIDERHP9LTqtreqUobx70QP1GU7CC/rKyfjomzy+u1Yq9PBmFp1jmJsthxQ/DkKxhOY/zgCSCV2Qo42t4iLdpooE/R5Ew578bpj6y1ypgu7uaGF8g4swK6XlIqKB0/JD2wVJrC9qSlLjB+i7dBb+joEE2WxeenfyH7UG0RbRLUy4fSu8yfTtAcAWR+hhM1PlbWfCoHBTbdwnyX+kAhTCFmZtKf2e84udSuQpw+FZMHsLBJ9GUiTetdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tA13Hdg0SG4pnY7viOY5pRFcirZfR1k+yDdTooiP8Lg=;
 b=bEG8nNOGfI3FhNJf5Uv9MXhlXckGw2+2uh6sGww8MBi9PHM8HjhBzDzqP40qeYm4RIR4xU9DH0tM8Bgn5EBrS1w10RXBcTVEa4nt3gjg0uXgUQWbevhVfdXRtyDzSvyt8qBuEIaEfADLOELPZDwHPOIHEGrFUgmwLKhI9ULm0Dj0DaW4n+eJMODfq1IqFUvhI0whsAENQn2DxGFBBqQ3bh18XHxAJ1P+VdV53bIlmVaIqWOZ8y3A9zkD/feKSB0NK37iHMHcaD92OWNm4NdmNHkvhF35PatBJYAs0jdx/vnLxhDICwtTemTRhWHc8C2ipVUR3MtSiD0QcSg4nkq2pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tA13Hdg0SG4pnY7viOY5pRFcirZfR1k+yDdTooiP8Lg=;
 b=AqU6FDTg3lSDmloAlPJR6C6XktTdbsvNbfqKhUwfCgchY8k1dQEdQ/boBPVkuw821yMWkrYALH9m0Rbz35iEHm+QZAtWS1S7W6EQi+A31zXSCF/HkFteLv17mGtbwnCqBNbruJkLasGdsYVYXU0B9cvHhwHzSHcjjf5PEno8WKI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7013.namprd12.prod.outlook.com (2603:10b6:303:218::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:28:50 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:28:50 +0000
Message-ID: <06087768-6dbb-41de-b141-7ca0e4a60ea2@amd.com>
Date: Mon, 12 Jan 2026 10:28:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Enable pci root port driver
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Anshul Dalal <anshuld@ti.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <bc09405d9a2df190f807bdf750ed47b86e6b83b2.1766153383.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <bc09405d9a2df190f807bdf750ed47b86e6b83b2.1766153383.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:510:23d::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 86edc8e0-d044-4048-8677-08de51bcfede
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V2VQWUt3TVJtbUVkc0xvOG8yUkdQa0FhWDUrUDQ4KzhJeG5SVmNHV3NTOU9t?=
 =?utf-8?B?bGpybXRZMUl3U1FnR3RzaGxNSWZMSnRlanNvL2xrcjJhbU9WNGozTDE5endP?=
 =?utf-8?B?VUY2bm9uVjVLcnFrdHpFTzBqaC9RM3NYOGNOQnFPdFRaeHJnbUxsOXVEZi8z?=
 =?utf-8?B?T3Y1RlRQVkVwZFFCRU9EQlBMTStCQi9JTkx0WVJ3TVVRc015Tmg3M0tYUSt1?=
 =?utf-8?B?aVpyLzlvamlTaTBWRTgveFdKcStzUWgvazFwNzVqY0hOc1h1STY5YzRHZ1pR?=
 =?utf-8?B?cm5BV0M2WDhpdE9SNjRCSkZRTmNITmQwK1M5OUoyTkZiUEhacStTTkdmemMv?=
 =?utf-8?B?a0lWY2tESGphVGZISXFha3JsbDdlaTRiM3FuQnVJeW90dUE0ek5aaE8zeG9R?=
 =?utf-8?B?LzJxNExJbXg5TEpzcUlpQlBpUHI0aGtxZU5rMXM4ZzR4LzlCdHB5QlAzZm1a?=
 =?utf-8?B?T2JzcWhVaGVUd3NHZkpIZzVmMHVNREdqZExDYnU3UktwL3REeWlMbGgyOGUv?=
 =?utf-8?B?Q2VSVVNLcTFiS1MxdmptaytMSUlTMzRZbGlwcHlmdmV6TWFTQ2JQQ3hXL0dP?=
 =?utf-8?B?QjYrYUxjdUFER1UweDBFem1zZ0NGYlFGR1ZFSVRTZ2lURVhBKzZBa1Q5U2RB?=
 =?utf-8?B?bm5wcHF4QnIyaVBrOG1WNEQ2cityOUUxK3ZyRnZHMmJwYmF5YlFZemx1T2Iw?=
 =?utf-8?B?MFhJSUoyTjVFdHFtOEhOYjNMRDBNOEg5UTV6YVVmOGdkMng3UWN5QUpOUmVn?=
 =?utf-8?B?LzV1NnRYSlRJTmJZZlM1c2Y0SmtIcWcyODczVFh3dmxienRWakpqMm4vaElG?=
 =?utf-8?B?Qm1VSU5FNitTbEZVMEN1cDhndjd3VW43VVp0VEM5WlJRNGNicDlEWmFKU1FX?=
 =?utf-8?B?SUE1R0N6T2FodUs3eW5uV283YUJiYmc0MCtzZGIvR1RwSndXbGNINTNzMzI1?=
 =?utf-8?B?Q1VKZHJRUGRLS2FHR0FFRFh5ajV0dkdUd05PSWtaanpGVDVYL0tXK3RUT0Zq?=
 =?utf-8?B?QTd2aENoWlpHaVhBanoxUUhTMVoxVGJybkQ5L1pEaURIUUQwSXg0d0xVV0Vj?=
 =?utf-8?B?WFVSTk9qRUVkOVlMb05OTkozSmVCa1E4S3R3a1B4RkVFdGd6ai84bHFhdzJT?=
 =?utf-8?B?Tm1mZXlCWnJjbFlPL01xbzY5Y1BwbWRrVFVMQmpkaG5QVkE4NDM5MUNBZXgw?=
 =?utf-8?B?Ui82c2twU0o5SEFwMTFFSEJYTTU3dHBwY05aWW1rZHk4TzlJbHRUUFhVOTZy?=
 =?utf-8?B?S0JDZk5sS1E5eTcvdE1NU3UvUU5ZQjVGMXprcEF0ZXFwc1pwc2lQQWViVE9z?=
 =?utf-8?B?cFJBUXZLd3c4R0J1RThoWEhSTFVWdWdiZGRMTmFMN3pPQWVVTytrOVh4OWd4?=
 =?utf-8?B?R3o2MGl6UDF2U3UyT3hOTVM3ZFpuZU1tRnFFMkplNnBrbWtTRDNucTlPTWlp?=
 =?utf-8?B?WmlESWwzeGF4VWtpZi9LREpKSHFCUGIyclU1dmN4ZlRaZFp5dlNxZHJ4NlJY?=
 =?utf-8?B?Z1cweTFiN0pTSS9IbTVHck9zSyt1VjBvUG94NXpjZ2RETHhkYkx4cDlFNUEx?=
 =?utf-8?B?M3NXUlQwRWh1blFUZklyb1lJQUh5OHBMaHJhQmcwbU95QjlSYVptVWI2a01O?=
 =?utf-8?B?Q1RYTU0vcGdkVkM4aWJWYzZ1MmdkTmUvZmV5STJjYzZpSjJ2MnlRaGczaFd1?=
 =?utf-8?B?NklxdDlVUjl1N1pHK21LTjh3ajFCOWFjYWFKQ2ZpVkh5alBadVdzQ1BSYmha?=
 =?utf-8?B?WnM0d3YrbWlGQnlBbHNQVC9lbVFWZzZGMVNxREp2Y0xwcFpDdmZqb0RRekxL?=
 =?utf-8?B?bjEwUDBpbHRIMk8xSXJSMFJPeElnNWx4R3NpTndSNWt2ZlJaUjRpQW1mZUx6?=
 =?utf-8?B?cGdYV3VxVTVGZjRPVnd0WmRjVUZGY0hYY3V1dEE2SjRyVU1QM3ZPcGZ5SitC?=
 =?utf-8?Q?b+ZtIMjFcL5pFRg4ZOTAhGdYCYGjevRt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFB0RVZKRzVDcjczOThBcDRYbnFSL3ZSVjNUWm42SU05anJOWjF5cDBpbjls?=
 =?utf-8?B?NTZHbWVkQkJ4VmZOMlJ5dkhpRTVtQmdVN3ArRE5WK1lKOW8za1ZCUHBnR3dh?=
 =?utf-8?B?L21IaHNnVUpCaTNTSVY3RXdOOU1oaVdTTzdIU05PS0VHQ0xzZXdiUENsSmd0?=
 =?utf-8?B?L2FEUGJ6V2FoVlk1R29sc2ptRkVXZDBaM2NlSzFnOGJDMVNPMjdmT2FaY0lQ?=
 =?utf-8?B?OUNkb0FmREhYTWZ1RDRiUFdxRmJsb0V5WnMrQWNHSDlDcWVxWHdqNVlFbnFL?=
 =?utf-8?B?REhIemxwUmxYd1NmOXVaRG9tZE1vMklSbk1ydFpPbFdkdUw3a0dGR3BDbnFm?=
 =?utf-8?B?TFoyVTRDRUtxMXRtWnhQamkvTkN4Uk5mWXNOSjFxNE5kb0V4R09rWXBRSUhV?=
 =?utf-8?B?Syt2bmhpZitzYXNxeTN1NzZvRmtRR1VLM1F5aEw0MDducG5IUUJteWJwZU4x?=
 =?utf-8?B?NW1RNkVwWENlT0RwZTU2NWNzajdYS0xmeHdjZ0FDRXNkdHN6bzc4ZFFobGFh?=
 =?utf-8?B?Um93SWhtaktmVTZQdlh5bTlUNkNCbXNRK1hwVzAwNzdodE1xWG1BNDFRbFFX?=
 =?utf-8?B?TW9rcG1uTEhzZi9KSGNTK3NBcW9GU3dldWxOYW1STkMyWHhIakZzckN2SkhG?=
 =?utf-8?B?d01vRkFDdndVeElBUDJZTjlqRWpVSnpWcklhY2J0TWFUMWxZc2hpZ084Mko3?=
 =?utf-8?B?bEFydDJTR1ZLZjBOOE5CK1piNXVKNzNvWWd5SkVQMHQwcmJjNVdIOWZycGJW?=
 =?utf-8?B?cjJUcSsvT21vNUkrSzBQcUVSTEwxSlVCcnhkLzVYcktRY3h6REpXRGQrRWVz?=
 =?utf-8?B?dm04YmdFOE9WMXFEN1lFdGp6ZktZTFRoUHVaYkNuVHAveE93NTN6MmJBdW5m?=
 =?utf-8?B?MENCRjJhVWRuNHgzSUpXOU8zam1pNkQ2UWxOVGJWdExpYlRmS3ZCN09iWjNv?=
 =?utf-8?B?UGxwQmdsalgvNk5kUklROTNveEpHTU04RkxUbTQyRHA0REIxaWJ4MmJNRWwy?=
 =?utf-8?B?MWtZam1PWWZGUkloaVlEMVRSNzlYNlI0YWRsMllRamRvYjc2bmF0cVFqRkQy?=
 =?utf-8?B?Sy9EczZtMkZNZGkxWkZMWTFOZzJMdlc2MTM1ak1nanVKdXpHRVlhV3BZN0RR?=
 =?utf-8?B?bzRDMUtrbUxiZ2ZwSnk4d1poWUdOUzY3S21GakNOY1JBS3AxTnExWkcrK1Vm?=
 =?utf-8?B?UEltOXh2UmJrWlVDMUZ6blhsTGdKcS9iUCtpeVRhL1h1SlozVnpRVzRJV01q?=
 =?utf-8?B?UEF1RXhRWGdTWUJRTW5FNFdOaURzQVBhUHRadlB5a0lPR2k3eTVQelk2a1Fr?=
 =?utf-8?B?N2dCTmljeE1EL1M2VlFNZUI1aERNaWwxTHB3QmlsVk8rSDY5SE1qZ3JUVml4?=
 =?utf-8?B?aTJqRmdIa09YZVFjNUtvdXcvdjhqVGM5QldzYm9KMTJRRDNHeDRYWHZhSFZ6?=
 =?utf-8?B?c1RZRHVXeDQwd1pROUVTMC9jWUhSbGNsdi9HZ0FDRHNqQk1YTzdvbEcrNHhE?=
 =?utf-8?B?NWVwaWEyR2NkSmJvUUdIU0VUcHRaY0E5Z3dtUzNyK1NzNE1pWHEwdWhqempl?=
 =?utf-8?B?Z2M0MHFHTmE4K0FtT21rYU1BN0o5bmdTelY3b1NLSnZ2dGo1SytNK0hyUVBF?=
 =?utf-8?B?VUtmTHlhVVllSENUeVUwODRTcFIxb081dXFUOGcvdW1qZDJXVzB3Y3JDTFhJ?=
 =?utf-8?B?Y05yWVNRNDUrTDZ1TXV5b3ZwWlhDRUFmSDk4Z3F6bWVSL1pNdDYwWXR2WVdo?=
 =?utf-8?B?amtlZ1ZCaGhUaTYvT1pVancrSWFoNjRBOENHcklOTFBIWWdXTnkycHFTRW9v?=
 =?utf-8?B?cXQzNGkyaGRpN3lRNjhJVzBJRlBIOUdhd3R5MEVTNDFpenRWMXdHdmxxVVho?=
 =?utf-8?B?blZXclBLV0JpSjBCekxiMnNRM3JWWkI2VkJkRUduVUYyS2lySzZEOVhsTE5a?=
 =?utf-8?B?Tk5ocDdiSW1pVTZRM3F2b29sZVNEcU9NbjN3WFRLR1BWWjUrS0ZGUno3TnVi?=
 =?utf-8?B?VjFkNmw1ZE5lckxRWlBON0RtUVN6QURPTTlBRTJPcU9YeWJUaExLZE1od3ln?=
 =?utf-8?B?aVFkdUxiNWsrdFBQT0dGM3FCaWdTMkhzb2gyNWlwUFoweTd3VUVHTGVwbnhY?=
 =?utf-8?B?aXhZZ3lDcWM1bVBETXE4eDNPc1dNYTA1bVVZcjQyZTcwTmJSaFNWL1U2SkJp?=
 =?utf-8?B?MCs0K1cwNzgxWGRVM1ZQQkIwalN6V0ZrNmw4TlJEKzl1Um9XWk5XRTRIRFpO?=
 =?utf-8?B?Zk5tQzE4eDhiZXZIeWVtT1FBeTM0M3FlS0Q4NHVMNWhBdjRMMit2azNkamd1?=
 =?utf-8?B?OTlHSHZnUk9tMWk2WUkwQkRIWjlGYzBmeEJzZWhvZzl2L2xWcHZMdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86edc8e0-d044-4048-8677-08de51bcfede
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:28:50.5771 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnGQhFS+5OG9Gc+ID5oVEHNNwnjkGNoVdb82+xR+tIgr31swFr89ymQxVJfR62sL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7013
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



On 12/19/25 15:09, Michal Simek wrote:
> zcu102 has PCIe x1 enabled by default that's why enable PCIe root port
> driver also with e1000 networking card for validation.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/xilinx_zynqmp_virt_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index fc610fd4af5f..bb79ddf989e4 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -20,6 +20,7 @@ CONFIG_ENV_OFFSET_REDUND=0x1E80000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_CMD_FRU=y
> +CONFIG_PCI=y
>   CONFIG_AHCI=y
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
> @@ -76,6 +77,7 @@ CONFIG_CMD_MMC=y
>   CONFIG_MMC_SPEED_MODE_SET=y
>   CONFIG_CMD_MTD=y
>   CONFIG_CMD_NAND_LOCK_UNLOCK=y
> +CONFIG_CMD_PCI=y
>   CONFIG_CMD_POWEROFF=y
>   CONFIG_CMD_SDRAM=y
>   CONFIG_CMD_SF_TEST=y
> @@ -180,8 +182,10 @@ CONFIG_PHY_XILINX=y
>   CONFIG_PHY_XILINX_GMII2RGMII=y
>   CONFIG_PHY_FIXED=y
>   CONFIG_DM_ETH_PHY=y
> +CONFIG_E1000=y
>   CONFIG_XILINX_AXIEMAC=y
>   CONFIG_ZYNQ_GEM=y
> +CONFIG_PCIE_XILINX_NWL=y
>   CONFIG_POWER_DOMAIN=y
>   CONFIG_ZYNQMP_POWER_DOMAIN=y
>   CONFIG_DM_REGULATOR=y

Applied.
M
