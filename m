Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3107FD0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:32:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 932C688FD2;
	Fri, 25 Oct 2024 14:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CkCtkCtB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5666F89001; Fri, 25 Oct 2024 14:32:43 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::615])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED4A088F64
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:32:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCUDdH2E4S6rwbH2jpAS95TAbM5Wnro+dKuqK3rzwwBx8ZRlon9jYd2BxZ/JdiS8zCJpIeZq5P6yEMhTPdrak0PHWgQ7MKzaRprhWAKFMH5D9suob6XA64oHcUeq1iEIgTjjWadoEdqGASLdM6ID9oraEqQv7gSLBgZbQKnrWoO3hjbjquq9482ppSGcN8etlNgYodg2BcD+dkc8fAhA/QFRBVOtfd5yxZB8LKPzg3jGytgH4GVBc/DnFLp0Ve9ov8q1MO8xGoQAQiIHg59084A5Xy6GuOoXVb5UWIbUGDPQbXttq9vCC69m7TguCe9tecJT1dohL9qPx2o9X6ue+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju7dcqOAIRyyD2j0rvF3ytoIZKSc+lFlwAqscYqLymo=;
 b=LrF2TjPKdeQQrjvYpDtOLf/eDyXcqVAvr4kS0jr+CpsjW7scGrLLYLzEwudhex1epG2LSxwgJ/DcayR9TW7+lgNNx9C42A2a8TGbf/bIFNUd5n9/D4eh+ozT8oxH4UOWVbMWO5l23+xX99hwzPWbAQO0kOAX2fOwdv8uHCwsX/C/RJOXo5GYsMmJpFYEn37gD2lP0qMwROUvI/eqk9oiScPc9VQFKm9oNWcBCkJqXQgxTjok+CjQkuFkizwby/cr20/3mPMtNDJj2th4+0DpcCKHvrt22uUkEW8u5gndPzxCyBYLa/GMK9rhR1fa9baMDzFMNZX6Dk9MzviFS1FgFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju7dcqOAIRyyD2j0rvF3ytoIZKSc+lFlwAqscYqLymo=;
 b=CkCtkCtBnsDkA5kGo3bop99nmg0quV5EBlWDZUBVd1VgKAXIeYyCO4fz8HgHPMhBb02P23OoqxAu6gg6xMHO0yPR0InepPFWPqdWZfdQKkf0iu+4ybaf3cGg6CuoLWW1ciXc6ve2jyiaHe1mObopN9Wkl2Z26e8DFPbYwQPxmJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:32:36 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 12:32:36 +0000
Message-ID: <ff3fdbe9-25f5-448a-b221-fec3f6f7b205@amd.com>
Date: Fri, 25 Oct 2024 14:32:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add generic function for computing ram_top
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Cc: love.kumar@amd.com, Tom Rini <trini@konsulko.com>
References: <20241025121547.181633-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241025121547.181633-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0227.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: e75464e8-ebcd-4ee7-c3ea-08dcf4f11b40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnhuWlpmUmhlY2RoMGxNeFduSDJjcm1ZUWRkaDJmaUVEeHBIN3d4b3F4aG1D?=
 =?utf-8?B?UThtU2t4d0M5RmQ5MFkrRlRNRkNXa0JxczVIWU9RcnNqbEtjNlJUSmdkWjdp?=
 =?utf-8?B?SjdMS3VFbDViU3dUVVc0SWxoc3VvQ3hpQWF0L0k5S1FPa05QcGxBNVZMTGJJ?=
 =?utf-8?B?TnJ1T2QvR3NCdTVKNmxSZDBMamFuMkJIT21PVUd2ZXpJV0V1cVozV1AyOUVo?=
 =?utf-8?B?NGdNMTNxRHMzYi9RK0F5TFI0bjMxaXlBa3RsYXc5L0xRRVJhV1pLcngyekIr?=
 =?utf-8?B?Um9FL3FPQTRqUEF3ZGwrYlY4cnF0MU1Wazl3VUo1MkRQdWxGWTRFQmpsS2ww?=
 =?utf-8?B?YVhMaGdWOC9qUXVwYXRWalU4d29ISFZIUXIwWjFnZEI4bVcwcHZISGR0amV4?=
 =?utf-8?B?TzIreGFHZ25CNlQzdkF2QVdnY3p4QXNzc3Bpb0l3NEplMUhId1RpR1NGNEIr?=
 =?utf-8?B?ZWtLSEpPUllGUzBQQWRPd3ZnT2p2MVErcFVidW0ydVhTdSt3UUpWb2NEdC9Z?=
 =?utf-8?B?R2dUNzcxNU1DLytOdng2c2lJZ00wRGZlYTArZTNGVEdxZU1sQlhwdXRwRWdZ?=
 =?utf-8?B?eW0vT0dleDRqNmFINDAvVDM4Um0rSkw1dWRIcEEzQUR4S3U5dVhzZUJianBx?=
 =?utf-8?B?cWpwMFBtb2hSR2c2SGc0RWNyTGRRNTBZYW9HQjl1TGp6cW1YNnNqTUE1Tyto?=
 =?utf-8?B?VU81UFZzSm50a2xJNXVwbG9xSEF1ZkVHZW1HODg3am1BKzZKTmtPdytDOGh4?=
 =?utf-8?B?LzJTdGdFbkZQaVdEREM2eVdTTktBNnRtdHBCbmdLdE93ZXR1UkFna1BvaEZs?=
 =?utf-8?B?a3RmV1hkU0tVTjA2M0dYOHBTck1LR2dteVZwYVNTK3FHQzJGZnRHcFNhRmhE?=
 =?utf-8?B?T2ZNVTY0dWNHRUdJUmNqYStNSlJ4akNqd016WFhWMVVJVkhnY2lmZ3liRTgz?=
 =?utf-8?B?OXpIZkV6QUhmYVdBZUl0T28vVzl0MHNJS1BjbnVnbW5kOTc3cFpNTzR6REhD?=
 =?utf-8?B?dHJnMG5XQUlZSzNnZTlHMXJDK3VGZWd6TVJBb3lqSUEyZlVGamR0V2FvSW4y?=
 =?utf-8?B?SmtDdkZhMTBnVjVHQWQ5aVBBaFVtMHBHZWR1M2c1eG1hSk9TS1o0TytiWEtx?=
 =?utf-8?B?L00yMHVBU1V3b3FLV0luQUF0KzN4ZWx6R2ZKdm9UeHM4ZmRBbUkxa0hYZmxC?=
 =?utf-8?B?SXA5Q0tFZ3h5WUlhakZtellZanRxenFScklCY0JpVkljL0JVT28zNFh0TldR?=
 =?utf-8?B?bXlRejhqYys3K2R0aFdLT1N6bGdlM003TDgwZEFRdUJuc1J6Z01GWXVpK0Vr?=
 =?utf-8?B?UkJCQkhhS3dSMG1pZVAzNm00NTNxNFlZY0o0bFlkQnFyOStJSjNnQ1R0eUtx?=
 =?utf-8?B?T2dMQ1ZKZ1pKN0t5OWlIM3Q5T1o4VDQxbkhRWk9iTW9IMWgzamJRSExlNkt4?=
 =?utf-8?B?RDVFTEdpd0tjT1V1ZVd3aVFTdzFpM1EwekNIaU5ab3RxRUxPQ1RSL1pkQVRL?=
 =?utf-8?B?L0FuZ3RoaHNRR1dWS0M5bTZIVHVSWDVLVjZZWDdlWk5xN291S292N2ZLeGVU?=
 =?utf-8?B?V0plODdtMUtXcGdOeWxHOVRrWEgrTi96Tm92a2JMVDR4SC9ndEtVK1RhdEZu?=
 =?utf-8?B?T3ovU3BHbmwzb1ptMU5YN3gwV0NEbTlzMUtlWDZTd1d1K0Z6cnlmVUdiZnAv?=
 =?utf-8?B?SE90a0VZY2svRGVBWWtDR0J4ZkllY2VaaXVBMHV4NHg1UENyeS85VG5JL29r?=
 =?utf-8?Q?Fk+BCE+Ke7Mo/7whpvoA9OS6nCGgmemQv0IcEkp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akgyTk0yZmhySWwwV1FsMEhobVYrRUtwbzVBZStSWUtKcTlhSzlLakVvTWth?=
 =?utf-8?B?SnVXa05jOGdpN1hRdnVjZmw2VzhYczIzVnpBY0FnazB4N1M1M243TGVLRjZk?=
 =?utf-8?B?czFxVEIzU0RrVVJsWmNjTU9PU3ZGNlk2cWF6RVVlK2pXcWRBZ0E3Z1RhV09v?=
 =?utf-8?B?TVVITWNGQWgzS1NXSzEwS04xT3dVdENaRG1jb3BBOWJRMjhMSVdNNmZ3MitY?=
 =?utf-8?B?ZGtUeUU5cy8rL2NsRG5yZ09ieC92SUxhNjVGS0J4YTZFdjh1c1FjNXlScEZI?=
 =?utf-8?B?RXdWY0FFTUxYS3lQZC9BS1JPNWIvQ1A4U1pSS1kwVjNJMm9tSFVsSVZHU1Nx?=
 =?utf-8?B?MmRYTElnTVVYOVZGZEtRaXNEekYxZCtBSENhUkorVitMUi8wWVlpWjNreFpK?=
 =?utf-8?B?ZjVmL0k5N0N4UGtYeFRKV3JYaWNpTXI4SWY0NFo3Y3BKU2ZVQXBjY2RBeHFM?=
 =?utf-8?B?UnExa0RhRU9BOCtXSGVjTk9kWjl4TDJQUE1BeWVVMHhUZnhaTTRnUjk5Zzds?=
 =?utf-8?B?NWxIWFc0RUNUcTh6bzEvOFVGaUR5SG9ocGJYY3k4L1ZtRWhmeG5pWVZ1NEpv?=
 =?utf-8?B?bkFkb3liemIxOXoxbkN4TnFXdUVnaHl2MDB5Znl0Q2lKbDNRck1VWGpNNjNO?=
 =?utf-8?B?N2ltbk1tQy9iUlBSUjc5Z08xT2t4WHZ5N3B3cVF2RlJXY1Z1Z05ycWxyVFNR?=
 =?utf-8?B?SnlOZy9XL0s2bGcrSitZVzRRK0NGVlJxYm5ReHRlUTArTnplTVV0UE9xemhH?=
 =?utf-8?B?Z1VnT2xJc1o5Y3AveUpON1FjUHRkNDc1ZWludGZNZFZDbzdCUVZzWmxkTzIr?=
 =?utf-8?B?ZUlPTlozdVQ2bWlMLzFrakVZYmtOOWJQRy8yN3NjME9NdFNQV3ZReUJXbDRW?=
 =?utf-8?B?R0YwUFNSYUNyUm1YbkticGZhcTFITEFaQ3ZLbm1KSnVYS3luZ1BiWkQzdDBD?=
 =?utf-8?B?d2xidzZxUDd0RmhBRjNIZjhjck93V09oN0RYdE5POTA0QlhFT3JEMFJhTzJo?=
 =?utf-8?B?WjVkbTNqb2ZDYnlxNkJ5TDNTYS9UNCsrb1AzSU81N1BNNWtUNlgyY1d4VzlL?=
 =?utf-8?B?U0p1Qk9TVGpzQUYzN1p0OGlubnhvQ05mdmxyZHhySkRqOHgrVzdyeWRZNHFS?=
 =?utf-8?B?bWo0M1V2enhnTXNGaVpYWW9zS3pHYk05SGZzQ2l4ZjVaK21pUTNVVDRMcVJE?=
 =?utf-8?B?V0hYOFQ3Mnh4L2tTb2UwN0ZJNkt5V2VCZWVpYjZDNVh2VjRWQmhaMmdQWXpn?=
 =?utf-8?B?b3pLTXdnVWxMaURwNElrV2dwcnVPQWM2RktMeW1JMDFvZ3NKZ2V0RHZ1eWJR?=
 =?utf-8?B?eHdKM2xCbi8zZnRqM2h1ZVprNGpQN0Y2a1R6dG95SUNsME5Yb3J4SlllZDFp?=
 =?utf-8?B?cjltUXFMa0wrcS9TVTNpbkp1SzRENUh6bm9PczY2SC9heGpPcmxlUmZKUmpI?=
 =?utf-8?B?RUxPUHBoSjI3UjBTOWU4WjZsWklsSkEzN1o0TjkvVUJEUzNYRW9xUVhhMEdl?=
 =?utf-8?B?TlVRTE9yUU1oMTJCbHpvd3daK096VlBZYnhIQ2thaVByTC9GL3ZkSHl1NW5U?=
 =?utf-8?B?ZlMzSFpHR0hnQ0IraVZVZXUrMzBZTGNFWlNKTlZicEF4c3NFMlVzY3NkSkFp?=
 =?utf-8?B?WlhodFFvNHVxaGRURlpaaEZBazdsMG5ycHpoVC94UzhXSFhxWHU0bnBvWkxW?=
 =?utf-8?B?V1lYV3NqMjd2OFdxOVU5YU1Hb2VDLzlST1BNZmhDUFJ1MzVIZnE1L2hJb0FP?=
 =?utf-8?B?Y0I0cjdVZXlsMFhLY2EwTUxyeGJUZGZocDJKSlVKUHp3UWNyM0VWeE93KzIv?=
 =?utf-8?B?bHpuMkFpMHkxMTJCNjZJSXlTM2ZRdS82T2ZNMjdQdU4yd0JmNGo3R1VBNUlN?=
 =?utf-8?B?SHFVdkZOUDBhVUgvRWJwbHR5N0ZXbXhPVVRsSCtQaVAwaHlkekM2ajhFRndW?=
 =?utf-8?B?VDlaS2lKNExaRnVCOWJHRWdTUFMrZnlzajdGWjB0SmI2a2FjZTc4RTRPdWNl?=
 =?utf-8?B?V3pueEdHOTVvZ0RoR01OYzkzYlppdFhpUjB0SnhCcE53Zlh4ZjNNR2pWYTBm?=
 =?utf-8?B?RXNUa1Q3clpHNW1ZbTlzdTFOVWd0dWpjbUxwZmFYZ0VxTXJYYkFsc3FkeWwv?=
 =?utf-8?Q?tauYTFmWQRPLILJhQkrQ3IuCL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75464e8-ebcd-4ee7-c3ea-08dcf4f11b40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:32:36.3692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIaixuxFuTkJsP5334bMGevWMT6vAf8U/Njebf3v3wUjiW+5lYQ2XNZ/YBcoEYOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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



On 10/25/24 14:15, Sughosh Ganu wrote:
> The board_get_usable_ram_top() function is used by boards to compute
> uppermost address of RAM(ram_top) that is to be used by U-Boot -- this
> need not be the highest RAM address of the platform. This computation
> happens before U-Boot relocates to its final destination address in
> RAM. Certain platforms, like the Xilinx boards were computing the
> ram_top value in an indirect manner, through some LMB API's. Thus it
> is no longer possible to use these LMB API's to compute the ram_top,
> as the LMB module gets initialised only after relocation, and the heap
> memory has been set up. Add generic functionality to compute the value
> of ram_top which can be used by platforms.
> 
> 
> Sughosh Ganu (2):
>    common: memtop: add logic to detect ram_top
>    xilinx: use get_mem_top() to compute ram_top
> 
>   board/xilinx/common/board.c |  25 +++++
>   common/Makefile             |   1 +
>   common/memtop.c             | 186 ++++++++++++++++++++++++++++++++++++
>   include/memtop.h            |  22 +++++
>   4 files changed, 234 insertions(+)
>   create mode 100644 common/memtop.c
>   create mode 100644 include/memtop.h
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
