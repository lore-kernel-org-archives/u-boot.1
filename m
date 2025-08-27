Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B868CA0EFF
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 05:03:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FBF783145;
	Wed, 27 Aug 2025 07:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o+Mu/GVH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DD083189; Wed, 27 Aug 2025 07:03:21 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3059D8313F
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRvGN5I5dZd2ONi/Caph58fIV+g0/tXsU37pMHTohZ+P54gR0E2eAtSFEDtSUdDjopaFDIo6PtwhfAT4IYe91j37GuXDE/EUgOwtBQ+Q1c2wVB2RyI2aKn7VZGlJwUyWegZ0PKWF+70FD9cExHEm43kK1dBO5P1Nnce46ZDPzjN98Raw6qoi+udZortQZPzENMZz1V9g02l7CgwlYW5lSVTpQMRtxGlnB2gV9MMmlG3qQLEULd50ueuOyWHD69vC7KiGk+6YPKH/x4UGE4DRJ1HATWeVr5kxA6YP88SraKHLVjJ3wiD9SZA0xEeNndJOBItZajT+bh09nqdfZOhE9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErY9VtTMhooCfPriMdIJ2uAXLHNkXOuHvuKlIX5UaBE=;
 b=N0bX9G+S/OjQ+8Jh7hbgqTrocFG415v5b8BWizDAc52oIsxAZkxG8af5MfTkIglcI8n/TE8JfOzqkuQY0kQDzJtf8+SLa7/SV4OJ+WunDoc1AvWMoYE0buNW5uAty/kIvmd8Np942EjCSX1ztZSLV6COnWp2xS2c1owsFSYl/yIESB9aLoVwMYF6RZRhJ4O7XPfyVfhuevDlp+vuTt471yvgDXemLNuVeYhgrjqnSD/j0qcCcXFZ/gj7YRfzY7Sj2bBLSxU6n+lbpXTjFQxJajZRq+ul8889wRDfUz9nVBu+aepItgZyv+hIWrJB4ZsyQ/V2L+Hwd6tvpqABbQHLqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErY9VtTMhooCfPriMdIJ2uAXLHNkXOuHvuKlIX5UaBE=;
 b=o+Mu/GVHimKvRrJQcNOvIgRS07dckHYoA8Awzakzqhu+g9sJcD0/2nZGNMZRp62H5u94ci0xA/JyRyOBz+TngK0yY/PfnGOa+2kxfnSccKO8KeqNoZf8waa8ts+2/csoOLFEtAzSSfJii1Sn3TH4Wmdk8r3b/KwFNheJ56WBGTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 05:03:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 05:03:15 +0000
Message-ID: <5b4bddac-8663-4087-a0a1-1b556a4bcce4@amd.com>
Date: Wed, 27 Aug 2025 07:03:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: zynqmp: Intended use of ZYNQMP_PSU_INIT_ENABLED
To: Sean Anderson <sean.anderson@seco.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
References: <b84e2f4e-e511-4894-ae16-2ff00be0858d@seco.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <b84e2f4e-e511-4894-ae16-2ff00be0858d@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa9f3d3-cd30-414c-2f74-08dde52707dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkJ3RlNzNkFxV0tmZnNNRFhmUWpJbCsyMVQ2SFlPMFAxbGY3Rjk2ZGhJWDJz?=
 =?utf-8?B?OFkrd3pnd0V1NFFRQmNzVHRYVmJvTnRzMlVFazhsQmdWZ2NkRW5nNnpjSkxX?=
 =?utf-8?B?bFdlVFJMWGZ6SGNsQWplOUdHNDdsaUJ6L0xIVW53WFhjSkt2VTFGVjVkLzY5?=
 =?utf-8?B?cGpJbThvSGVzMVRZZ3BiQUQ5dVp2d2VESHoydDVlckVCOU92ODJrZzVvLzQy?=
 =?utf-8?B?QzE5U0F6VmRxSHRsNVhGZUpra3ZkYVJ4alF0VXlpN1pvZ0hxd3ZQNlkxY205?=
 =?utf-8?B?VVNrcDZJaEpzUEV2aUl6aXJxY0RJN1hOSEFZNFZkbUlqNXArd3BjZGdwblVu?=
 =?utf-8?B?WXp0S0Z5Vng3MWs5c3JBOVFCQTNMU0JqcE5Ea0ZrdS83eUQxeTRHL3E5TjlT?=
 =?utf-8?B?emNDVVpINEVsUHhTUDZ0Q01HUXhoRjEwbGRaVk0xYkdLVnhsSDNPZ0kzYytr?=
 =?utf-8?B?TGJoM29WQXNRS1dtcE1xOHNkSTNBU2Q4bEZDNjNqb1JxdHlXNFArVmVqWTFl?=
 =?utf-8?B?bkt2c25OcXd0d3hRb2NFNCs0ZkFSN01rQUQ2QUk5cmlCVVFxVHBtbFV6YXF4?=
 =?utf-8?B?d1lkUzU5VXFmWitxOHplamNZWVZmeXJjZ2hrQmVGZStmZ3NZYWtSN0FuQWJE?=
 =?utf-8?B?cDlCMGkweWV6aXRPTG1icnArejVJdHdmUDdwclQ5QVI0WENNQUgzc2twMzdW?=
 =?utf-8?B?WEJYejRnTm9Wa1NTd2gxOXZHV2xqcnhCWmErVWNvektacEpycE9wTFg2Yzlp?=
 =?utf-8?B?bDJ0NHg3eVE0T09UQnVsQzI4Rjh3SWVvb2xJOEFzaG4wYUJ4OCtMMHFFMTFF?=
 =?utf-8?B?dGk4UTB6K1ZMa01IRGl1OHFsT0Y3TENvZmVwSkNIbjRoN2dIbjNhd3ZkR0hZ?=
 =?utf-8?B?ODdUS0c0WDdFMHc0cTNOWDhTMFFwR2tCRWpPaDZvVHVyQTg5MHFSNCtoMzhr?=
 =?utf-8?B?TW1uOE95bkhTS1p6S1RINmdSUXp3WVpiOS8yZUVZV0t0bFo0bll3bnpnU2dW?=
 =?utf-8?B?RGZYZ0lWTStHNnk4aG9OYjkxNUhmSVpRSWNackdSdTN4aE9MS2lraGdxNGR4?=
 =?utf-8?B?OGxpeDVpVzdySVZJNFUzbWhib2ZPWWN5YnUzajIwVjZvZlhxRXh2ei9RMVFD?=
 =?utf-8?B?OFRRYW9EeVlubWd5bnJSNlRQS0FidW41OGJ4ekJRd01DQXBTWFRML25HRU5h?=
 =?utf-8?B?bTNWRFBzQnNnbEhwbklVOXVQMW9JU0xGS0o0WXdSU2RVbGErZ1BZVVhUdlEw?=
 =?utf-8?B?dUNlcFg3UEpXTmxsaE9EdVk1S3EwTFZURlpETnJ2eTNoTmdGTG5vYjlVMlJi?=
 =?utf-8?B?ZzBQVUFkcWxqRlZIbjBEamlQQU0zbFg4QW0zYUx3MUd5aUJ4OGhSRWJNRzA3?=
 =?utf-8?B?N0hOM3RydGwxTnJLUks3VEhNRXlLTEJ6SUJwazdkaGhjRW5oblkyeHI1Q3p6?=
 =?utf-8?B?eElhT25TblZNR2RRcmtKWllSSk1sZWF5czZxMHhFMTNxNENUQ1crYUdiL3Bv?=
 =?utf-8?B?Wjh2M083N0poRUhheW9sT1FFY2Z1bTk1WmxGc3RXd1FCWUZIbW1HVC9laDJU?=
 =?utf-8?B?ZXQ0SXBKb2ZhMmlvQUZKZVlJU0NMSEJ0K1Z6WmJsK3VPKzlsQnNLQ1diVVpz?=
 =?utf-8?B?NzIrS1Y3YlhqNDEwdlFoME94M0pzZngwZ3padGpJVmZET2txZ2E5T3A0U1Q5?=
 =?utf-8?B?YTY4NWg1cHBuYVVmUVdZUWhtU3pYMktHMU4xNGc4UVhPZDU0Y3RrZCtzMEFZ?=
 =?utf-8?B?YVdQQlBWRG9CaEpFS1B0eDVGcjNTREhOUlBIaHpMTUhkUnVydC9QMEVpV3RS?=
 =?utf-8?B?TDVSaHZ5OE8zYzZiK0pDZ1hPNEtZLzB4Zmh1Q1BDVTFncTZjaGxuWnVNVk5h?=
 =?utf-8?B?VmRkTkJiWWJCc2xyTzJqV24vTVJoU0VkNE4vQ3VVSFhvK0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnY4cGtqVlR6dEJzRkZ6R25pVTd2ZW9MUW8yb0d2M2J0VVFJalhoaDByQi9u?=
 =?utf-8?B?K0t1VEpaZEZVVGRha0R2T2VIUGRqVVQvR09aczFpb202ZHdnNlR3N3B5SkxG?=
 =?utf-8?B?enJna2JwWE55UjhhdHNzcm1NdS9QblF0VVJkRGc3S2o1bHdwNWV5VW9Da0JJ?=
 =?utf-8?B?UmpJc0hZRVR1QTMranBxR2RKWGp6bmgzWHpuY0p2OE4rc3Y4aWVFdlY2ejZ0?=
 =?utf-8?B?K0daM3REcHVwMVZsOWI2eTdCdldZT2lTcnJaVUo0L1N3YkJQSTkvNWFPa0cx?=
 =?utf-8?B?N0VnckIzTEp0Mlg4THl1aFh5OS9Wb2JZV3NtOFFka0VuRXBRdVdzODFrMjVz?=
 =?utf-8?B?N1hRbmpmajRkeWZ5Rm85dHRpNnVLVmlUd01iS1BuajdKMjBGYjd2WW8vdTVD?=
 =?utf-8?B?NUZsZitWQmhtMHkybkx3QjVkNkc1eGM2TmNHSGdxb0pRQUNjelp4MjhjSmVr?=
 =?utf-8?B?TEdjUmFSOHpwNkNZa3ZDakxZV0VJNmNmM1NPVWNSaGlza1hqTjdiVklYWDk3?=
 =?utf-8?B?YVltQy81OEVtR0dhbDh2dVFjaXlmTURxZGk0NXdIMVBxcWZoZVErMmZQczRJ?=
 =?utf-8?B?b1VqRTUzTFNTN3RTdmlPcFBHQnMrZUxUZ0pvZ1hsYVIyRFZaWVlNbk56MGVr?=
 =?utf-8?B?SnJMYnNkTTJiZ3F3dExXUXl4RDRFcDhOOHNaUjk0aC9zKzZha3ltVGlGZG10?=
 =?utf-8?B?Mm1aQmR3WlZsbm5zdXl2VEV0V2pYeVJMcnpnWE5LbFFuTlJyTFNJUUwzY3FZ?=
 =?utf-8?B?RHlaUENLS05nU2MvMGJNTCtLVVFYOVA1ZHN0THcxT3I4c3BBOHpIQXRyOWtM?=
 =?utf-8?B?Ly9iOXJ1a0lpUW9PU2JkT3hQMk5IQlA4d2tOL1AzY0pPcEp0RGh1R1VuSSt6?=
 =?utf-8?B?VHM1NEU2VU9JSDRjOGF0WUg2clluV3g3MURkNm5FbGJYaU8yS0pjcFcvMjRv?=
 =?utf-8?B?UEk1QXoweFRLaUxuTnFyNmVjOWE2SHAwekx1cmtEb3RUeVRKZVVnck9BR2Fh?=
 =?utf-8?B?bXdURVd3aDBreWdUc08xQ0lhK3NLSDNNeEFjQU0zUUdqNjZ6R3o1aTNLYlpL?=
 =?utf-8?B?WmhLVExBTTB0ZHJBNlYwVnhpSExEWmJVaE1hVFFLUGVtZ08zcGZGRU5lN0NF?=
 =?utf-8?B?b21mb3dPRzdoZlBrdFd2QVZhbGtIZ2ZoZi9sWnpacWZFN0FyZGFabWlJUGFx?=
 =?utf-8?B?QVZhWmIvSTdNTUIzY292OWNjQWh1MXk1S1lRSHJ1SEROR29tL0ZVNTVzblpw?=
 =?utf-8?B?MWtSNm1FdFhCdGhRRkphN3dETGY5VkJBT1ZUdXB1VmJsNXVGeHRoM1pjMWE1?=
 =?utf-8?B?V0NrbDQzbGVlZGNEWm0yNVRpL3l4aGNUc09mNUZ5MnkyUWlabTBDUENtbkpB?=
 =?utf-8?B?S1FnczhZTWVBNk1RK3dRRi85YlVYSzZSS2NDZWFKUUFwUjFXeEtYM1hlWkp1?=
 =?utf-8?B?eUpRdDVDQUVLN0loa2lnSzAwMjF3MzluRFJYQ1ZFVmlnUCtROGpYQmErZjRF?=
 =?utf-8?B?V0ovL2RlQ2FTMnN3cHZRR0tDVDR5REdORThmL1BTT1lEUkttWllqU1I4ZzZl?=
 =?utf-8?B?dU9iWkh4ZSsrTGNzRGhHUXljcWFpVk9pYlBzd08yTXlYdkVpcXdSc05Jdmpq?=
 =?utf-8?B?ZlRHNkpBeTdCWkF5TXNyQlhEMmRneEpaOWdZZ1RKSVQ0VmZUT1hXQnRkaUlK?=
 =?utf-8?B?Z0llZ0QrZGw4UFMra3ZHY2oyVC82M1pjTHJRY0lLUjdCNWJFaWF1R0hwdUpw?=
 =?utf-8?B?VzV2c3EyWGRaZlVhWm41dXZzcWdJSEhVUjhLR2YyNWx1OGdEaHhBUXVGZG5T?=
 =?utf-8?B?TXVEYm1Vd0x6WjlGSTNQSi9TcDJRVExUYTAzdVg3RmZ4YzNDZG9wdi9KRjdm?=
 =?utf-8?B?WVFoazkwUXFTUm5ab25UUTZzcnZNaWZLR3VEVUZwUXF6cHVWMU82akU3QzhG?=
 =?utf-8?B?c1NqWFJESUlNNHRkUmUzN29la08zM1AybkRTY21EWm44cmQzNlVzTTc1K3RV?=
 =?utf-8?B?VEVTYXpxRnR1YWdVUTl1NEhtNW5XMlJNV3ZPUXRyRS9oOHQ5Z0hqL25OeE9Z?=
 =?utf-8?B?MTZFdGdGVHNPaGN5cWpPcjNteWxtc0tCYk0xOWV6Y2t1aUk5cGtTV05xMDE1?=
 =?utf-8?Q?OBL3NPq+EUMj7K8eJj88B2LLm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa9f3d3-cd30-414c-2f74-08dde52707dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 05:03:15.7546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfKv7JCUuX6Xhvob1uR5NKFxuKtIPZoyaugvTORm4bGcj+hUZtbEll1L9RITUKfK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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

Hi Sean,

On 8/26/25 21:53, Sean Anderson wrote:
> Hi Michal,
> 
> How is ZYNQMP_PSU_INIT_ENABLED supposed to work? U-Boot runs from DRAM,
> and one of the things that psu_init does is initialize DRAM. This tends
> not to go very well. So I am wondering how this config is supposed to
> work? Note I am not talking about the SPL variant of this option.
> 
> I am wondering if we even need this config in the first place.
This is for configuration where small/mini u-boot is running out of OCM not DDR.

Thanks,
Michal



