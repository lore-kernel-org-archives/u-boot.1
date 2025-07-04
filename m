Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164AAC83F05
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 09:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D2B8206E;
	Fri,  4 Jul 2025 11:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m/n0gUWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E97782A76; Fri,  4 Jul 2025 11:01:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EC8C803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 11:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVvncJtAvbee0fmic+ypkJvN7z5KhrAJ/qEUvP4PGA1j17aMFvyOOpy8kE2zYG+wWgiFKHnUlu/wWrwu9jioR8Y8COftdF6jqQbajuhSnDEi80ybh5Hn3IWsPl8NzI7SCak+bz01fj71mra6f+rRMiNEvWwsz06krHUI+NmZl274Z0RF14/6kfarFBwJicYhkgHeDoM345o9d7yVwLbztyvDnuINDoFVFnneuFwDIeVapyYWfmhgvApr8XuyWVkHv7ZnLAqOqTnl8z4j0y5nH6COjxCiti6TaqQgM5jhAHGJgcmD0t9hEgxWYV1i2g2/TuG4y1zhXianN7SjCGShTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7TvUZnsyUwcGiw6a9OcuZ+pbq4ayiIikaPtxY7SuOc=;
 b=YxkJoAuUuJuDVAMY1UQqBlRDaCUK9optA3hHlP8rdWxORVHkMUzXar1KvKQAdigR5/Ja27Gj9wdITjNYQhzcU6140o1Hf9tcJfI1fBLlugHJgOzf7+etoIAx3LKW269xiJ6GQIqhKRqo3s4AcX3ywqdYr5o3TGhrvcWtLnAkMj85Q5kGND9ZtZoaYkvYecniX1bIAxF4A/bP5m90c6aZ8O94z3PPXx9qST03KPc3nDTVQiGM1zAeILnbqaUcCA5GrVZohsLSEmSaA/Vrf/pJSeJFgKtdVEeRhfixp2b/GpN5NlW6U1CAxbwxqVk9l3dEESg5VXBGCKye/VMZ9RggHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7TvUZnsyUwcGiw6a9OcuZ+pbq4ayiIikaPtxY7SuOc=;
 b=m/n0gUWPv9evtk32QBr/MbJqf38MubyMdJI6pxn8OhK+uv+R+4J2a+9k7NEnK3dagc9Asq5GxzTZ1c/FxXb4eMDXVBywcpsCpNDWw3MYj1wnsXFV5Sbgbelcs8TpR8V8jhEnlLsNylsvqh9nsJWvrXyrdJ09TeUGgAnKU29SzkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:01:23 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 09:01:22 +0000
Message-ID: <2668bcaa-cc82-433d-be05-f97b120b3fff@amd.com>
Date: Fri, 4 Jul 2025 11:01:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/25] fwu_arm_psa: Add FWU acceptance mechanism
To: abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Casey Connolly <casey.connolly@linaro.org>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-18-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250702152528.1180414-18-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0110.eurprd04.prod.outlook.com
 (2603:10a6:803:64::45) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b8266d-05d5-4562-cd49-08ddbad95959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cEloOURtVzBma1ZuTjN6N0ljSUoraXE1VHRBS1Joc1I4OGRSTzllTStJSWkw?=
 =?utf-8?B?Z0pWMkNja3Bsd2sxVzdGV0QyOG50aXYwTlA0T0JmR1k0WlZ4VDQvMHVVMTVD?=
 =?utf-8?B?ckNaTUxSUk4xYUM0V1I5N0xQZkVZdGUzelA4eDBFSzhMMnBTL0FvNUcxQWZP?=
 =?utf-8?B?cVM0bk45eTBCMEd5UFNPUURmNldWSmNabTBHNStkVnhDdXRzYTlFSmJGY29v?=
 =?utf-8?B?MUU5bDZrZ2NJd2o2RjhDSndlR0d3cVF1RWp1TFFmeU4wQjRVZTBUT1BIR0Zj?=
 =?utf-8?B?U0M1UWhNWlJURXZWSDBXOEl4Q2F1SzRsdC92YXFlaEQzbEJnMUJrRzZCcXl1?=
 =?utf-8?B?ekhTc1pKNU5YT3Z3dWVMRHhMTm1lSVI5dG1MbUlsTCszcXk5bFU2QjR0c0lz?=
 =?utf-8?B?ZWh2UXQrZThPd0U5ZEVqcjdJbEtlME56RFVHNlVEVkdQV1ozcDlZV2pQQUhN?=
 =?utf-8?B?NHdSTncyVTFsUTNTenF6RXZpaGhwcTVQeHJvQ1dWTStiTExDakkzVHFqa2Rk?=
 =?utf-8?B?RzdLWGNjdUJwUkFOWjBSbzZqS09hT2U3b09LVE5CcitBQktDVkE2VDVOZmNn?=
 =?utf-8?B?UTJiOG8zOVA3VDhQMlUwZ0JWaUVsMVNsTk5keWxvQnhGakhhQ3dKRFJhQmZr?=
 =?utf-8?B?MXU5NlhyR0VoK3J5NC91ZzNFdCtZSzVRUUViNVZhRnVveUtGSWZLM0w4Tmlk?=
 =?utf-8?B?eXp6T2JRbGhXQUduUHBwQXluZ0UzNisvWXFoWUtWRTY5YmxmeEtGYW1hb05x?=
 =?utf-8?B?cjdoT0ZnSno3emhkOEhUVFYrYWdPN1pNTUpqdjZjVHhXaktSOURORng0L1lO?=
 =?utf-8?B?QU04bzJITU1aTEViOGVtcEVDWGhXT0FvS2g0OC9jaHhuZmVPZmFxM2VCUnRT?=
 =?utf-8?B?aUphczVIL2dRaytGS0NraUF5OWdteE9QWGdpSVVlQjdtY05IYkluenpISHh5?=
 =?utf-8?B?K1d6L3FBSWJVNTFDQy84RTZZVFBKbjdycGxKWER1R1ExRkVTWUpmL2twbUt5?=
 =?utf-8?B?Y2crSzQyQWRoUWc2MnJLNlpYb0pXL3RMZkVzWXFvbGorc1R2MmIvbjhhbzg2?=
 =?utf-8?B?cDc5T0gxVEV2VWdHLy9uMjM0cXkvRHFNRmJkWWE3SDhJWE1jWGR1ejdjbnlQ?=
 =?utf-8?B?SmpMNVdseitGMStPenU1cGZ2cms4aitXZ1Ara0JEcFg1eGM1K3cvRjhKL014?=
 =?utf-8?B?VXp3dnJWMmwvRXVPeU1sMzFDWGR1MUJ2V2ExQ0x2VGx1UXFoZndsSXpTWEcw?=
 =?utf-8?B?aXZXQ2xiTkg4TGRiTk02NmZtcTJtbmJQTi9kalExRHdISHBGbFBSbzhFN0JN?=
 =?utf-8?B?eXZXbnhza2hrU012aVpHOTNhTnU4MjZNcjRMdFFVeTl2eCtRWTJYMDFIa2RS?=
 =?utf-8?B?bXlHMUV6QW5NbGwwSWp5cXBjWFhFOFd4Wlp0U0RnSnpDeUowOEg4UllmWjdt?=
 =?utf-8?B?RGh0elRmSzRaa1A0dmVYRkZ3WmtkOHJuamJleUEzbEI3aEF0RldGMGNQbXF3?=
 =?utf-8?B?YUFhbFFmd3BzRVJpNnZmYU1ZWUZkOTd6bUh3ZWs5bmhGQm9kd3dGb3ZIcTUv?=
 =?utf-8?B?Mm1FVDNLaG5WVFJ2cFZCQ3RiWkxhd2phY2Znb0ttcUU2Zm9pVUg4dGJ3SlBP?=
 =?utf-8?B?WjR1cng0ME9CcTFSeVVGY1pPRlNBL0grZjlHdmlwZkd3QXB0RXdvMjdOYWkw?=
 =?utf-8?B?V2prbitSUS9hRE45QTl5SXkyTFFibmpZWnRLMU1tc3hOdnp5S0NUWVZHTzhU?=
 =?utf-8?B?VTNKWllmZ3E2Tm80TS9JQXZqTzN0dCtab3NBdGRMQ1FqMU9ua1h3b1U3N0Jz?=
 =?utf-8?B?cDRWNlNjUXg4UGd5MDA3ZGRCR0txaWRiMGI5Ylo1L1RVN00zaERIRjR2alhF?=
 =?utf-8?B?akxrbVN5ZmhlbFlYWVk3WGZFZ1g3VmdWWWc3VWFENU81bGdObUtmVWExL1lZ?=
 =?utf-8?Q?ffu9sqW1NPI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSs3RHMxSzAzN2hoSmtTL3F6ZlNXMG9uTWpEdXRrWmxRRUNsQWlXb1VSUnVh?=
 =?utf-8?B?YUJOdTJMVmFxT1V5MlVxMG4vMVhjTjNaa1hBZzVXOUhNSWtlZmtUd2dwMWUw?=
 =?utf-8?B?SXoweGxVVk41NkJQZVlTZWJvcXJ1ZTlPb3hjSDFSekJBT1FkNWkzanM1bEZN?=
 =?utf-8?B?L2N0SndUR29peSs4UDNqRjZlQ2M4Ulp5c0hiSnBIR3RtSmJ5Y21tYW5pRHo3?=
 =?utf-8?B?VTRMc1ZSQmZWb2NMQUVVS2ZDKzdNNVBjcVJIS21Yd24wOUlJbUQ4YTlQUVhu?=
 =?utf-8?B?cE5scGJSSmVmM2lYTkdKczJRUUZLcEttdVRoTHBHbFBsNlE5WHNhMElCZ2oz?=
 =?utf-8?B?NVB3ZmI5UVNuQ2c5Z29KTFFVT2pUN05nV1hCK01OSFlMSS80WnoxRUd1bHFh?=
 =?utf-8?B?TkpEL1ZqVjd5RmNzeE9ueHRJZFROaVdVREg4WExzY3Q3SC8rVDUwS3Z1VTA4?=
 =?utf-8?B?K2VpaE8wTm5BTnNXYWo4OHdXRmlmWkN1OVhyVk1PWjlvMnNnYStSRGROdlc3?=
 =?utf-8?B?VXE2ellaTndWUlZXT0UyekVaZWRsQnlSa0M4ckMwcnZGbHo3WlJRSTFMRFp1?=
 =?utf-8?B?bEc1NldWQU40bmZIQnByUG9xYW9WSUdKbi9Pa25aWTU0V1VDYU1VQzNTV1Y5?=
 =?utf-8?B?bXJ2N05SL1NRYVVGK2tUUzZoZlIvTnd1RDA3RVo3TXA0Y2poYXhkWllkTmcr?=
 =?utf-8?B?OHRyQmZoY2FEdUJRNERhbHEvR24vb1lBZExjZERDU1daQmkvdGs2WTM0K21K?=
 =?utf-8?B?bDV6dzdpOU00MlJBN21GQ2RhMHRDT0Rxbmp2VUo2UnJwOUlLNUhrWWs5WmJS?=
 =?utf-8?B?NlF6Wmpaa1U5QlB3R3FVbUhQcTZOWkttUDVwaGtaMHJzQVRIN3k1alJteG1B?=
 =?utf-8?B?ditOb25wUU9PejFyQVdCTDRZaTF2Q1pvZ0k4cXRBUndQYm9pb0FGV3pYUFZF?=
 =?utf-8?B?ZkhtYmxnZ09NTzd6KzhiZGo2T2J2MHpTb2Fvc0c5bzJyR0cySXdBWXZOWGFj?=
 =?utf-8?B?Qk9ETTh5MDFlMjk2eVJRWnhOQ1gxVVRSM0VDQW9zZUZWeEV6Y1BlczByblh4?=
 =?utf-8?B?dmpTVk5MKzd4QmdvZitya2Z6bmFwN1ZRRlQrRDVOUHJpK2d2UG9KMDQ5UUN2?=
 =?utf-8?B?cXlYQXBnSXpvMTVCcUhVcXJDemw4eEducU5YQkVncjNMdVZIS1ZUc2o1VlBr?=
 =?utf-8?B?MHRRaTZXTE9zQktLVlMwQU5wV3pVY2xMeHhUUG1FYURlZ0I1RHd3VCtBRXph?=
 =?utf-8?B?QjIxZXhHMVkyam0vYVZMdWx2WnZPaHZFTjc2ekd2R1BmWm1wSzNUVXNtRE53?=
 =?utf-8?B?a2N2bGEyUjZ5Y3Z4M2VXZW9VWjBUTEpjMHQ0WHkrU2dJWTd2NThFeFNQRTRX?=
 =?utf-8?B?cnJiRHpIL3NGemZBcllSSWFXL0RPOUR6bjBUQldEc3RrYjJQaG93VlNRMmln?=
 =?utf-8?B?RTZRRW5ydTFpQ0QyOW10WEZQWGNiWFIwS085K2RuZnY5c1R3c2QxOFhuTCtv?=
 =?utf-8?B?Sm4veWhPOUF0M3IyWnFJdythb1VKTUNsRnR2d3YxTlZyVTFTYk1LaU12SUZM?=
 =?utf-8?B?VlJHZ3EwT20wd1cwZ0VkQlBrSVA3S01KNnRDd29hYXhQSlROQ1Z0RmJNWFJD?=
 =?utf-8?B?Yms3SHRaUmk5c0orS05EdEdNM1JNRUd4TXVGaVdLY241T0xXR293cEk4Nkxs?=
 =?utf-8?B?T2NBdkx4Tmc4MzhsZkFSY0Q3bThFUkEzc3VXNXpid0ZhZ3llbUZSYjlLbHpB?=
 =?utf-8?B?SE5wYzVkdXRwaGlNR3hOTHdFVXdFZHNvTzNrQ1psU3gxd3ZzRmtvQkdRVHZa?=
 =?utf-8?B?eDNPb2R5TVZjblNtc2VEeXFZakRGSDFsQmRsUmhJL2s1clR1MURaT0VCUlQ5?=
 =?utf-8?B?R1VSQTJzWFhlc1BtYmVBWVV5UEhEbXZwZFRxNW1aNHlYdUdHUUo0VW0xOVRB?=
 =?utf-8?B?VXVtZ1lnaWJOUmg2aTMvQXhCbUxjbWM0cXZaWTVGY1BtRzZ6Q1lxMnFwdjhh?=
 =?utf-8?B?MWQ3RW9ONm1lWUwxeFJCTGhhaVAyK0ZKTFVWUjAveEZmbysyZHZmeDlSRVlq?=
 =?utf-8?B?LzNQVXVMOXp1WGVEeG9PRERYRWZJYk5tUGVvNVRPd1BuRmROVDVHN2RQeHRh?=
 =?utf-8?Q?GMPZBpGq6HtdCZDlZi3fCx0HU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b8266d-05d5-4562-cd49-08ddbad95959
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:01:22.8784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: df1JHwLqX9zDXFXvylv4lr7da263hmgnnrNtDGZd8vIIZ448FsQK+w1ff6DYEyut
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
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



On 7/2/25 17:25, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> Accept the FWU at ExitBootServices()
> 
> Provide the FWU_ACCEPT_IMAGE ABI and setup an event triggered
> on ExitBootServices().
> This mechanism notifies Secure world that the system booted
> successfully by accepting the images in trial state.
> 
> Also, add FWU_ARM_PSA_ACCEPT_IMAGES config
> to allow platforms to switch off image acceptance
> in ExitBootServices().
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> ---
>   include/fwu_arm_psa.h         |  22 +++-
>   lib/fwu_updates/Kconfig       |   8 ++
>   lib/fwu_updates/fwu_arm_psa.c | 183 ++++++++++++++++++++++++++++++++++
>   3 files changed, 212 insertions(+), 1 deletion(-)
> 
> diff --git a/include/fwu_arm_psa.h b/include/fwu_arm_psa.h
> index a8f0ff93d51..451d8b614e3 100644
> --- a/include/fwu_arm_psa.h
> +++ b/include/fwu_arm_psa.h
> @@ -84,9 +84,10 @@ enum fwu_abis {
>   	FWU_WRITE_STREAM = 20,
>   	FWU_READ_STREAM = 21,
>   	FWU_COMMIT = 22,
> +	FWU_ACCEPT_IMAGE = 23,
>   	/* To be updated when adding new FWU IDs */
>   	FWU_FIRST_ID = FWU_DISCOVER, /* Lowest number ID */
> -	FWU_LAST_ID = FWU_COMMIT, /* Highest number ID */
> +	FWU_LAST_ID = FWU_ACCEPT_IMAGE, /* Highest number ID */
>   };
>   
>   enum fwu_abi_errcode {
> @@ -311,6 +312,25 @@ struct __packed fwu_write_stream_resp {
>   	int status;
>   };
>   
> +/*

/** for marking kernel-doc format. Please fix this in the whole series.

M
