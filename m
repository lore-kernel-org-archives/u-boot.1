Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9634CDC19A
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 13:13:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21D4C83F66;
	Tue,  6 Jan 2026 14:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HjIhUFVy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8E7983F6A; Tue,  6 Jan 2026 14:13:26 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A6783F5D
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 14:13:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7LJwhypt0Essc56P0Dd5LUT/leqKu6QA6A6JkzbfH8EKMlvIVyRoZoyxdMX+Yle1W44b4/8k4oHASlbJqcKFAD0csASjB9mpsx8gspcs1QO7o5KoGfN9aSLp7A26KNbm2KHc+kPu3OWvmIEFQWIyt+9EAKdFbpfM9U8v68i36uZoAv/2MQOHAC8DFs5RCQuQFJoXQ4fb31ffbI2nO+NYg3g46Z98hNt+6kwg/37HNhzMhSdjo3aHVY56i1v0PFs6I/1jYKKTuR7qLt/5kQj0N0W+KJGfNNx65YMC/hQGs7vsazr/GCjVzUe2XX3EjXi069eROAuS9uUlLptjuTlTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04SeWwWaWrxiWjjsOKOyaUfu5SpICxjrwBKxGZO3qWM=;
 b=cfQaGEiYfFqo8qDQH6WMot5nTiRI82X2T+VNv+RVBR0p8IuEVlYNWDe+/C4hTWO0xtjOOxGIXnmFd95+q5KuLnNPV4C1rj2xgRDklCyxjpFysNdSMZ3Ah+qycTnZ+uhnUATo6cozby+wFwDnR9nYtol17j8kCQfX8apgchhbRnv8MCrFy4Hvuw18ltLtRsbiGEEeS6QlUYUXqe+im+AX8tShx40epUJJPAya5iqQwgEg0drdHhH3RlyE1X8P+AXEt2XslSY3Vt9rfR/iSfcm6l40xtbUnMnRHMgaCtQAlyO6RjVuZSWExvfZIPuSV9Y0hqwyt36jui5t6I9LzEoYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04SeWwWaWrxiWjjsOKOyaUfu5SpICxjrwBKxGZO3qWM=;
 b=HjIhUFVy+pUBbXA2oXEUn3ijZZiv/oG5qr/Xvz7DKMtCj2xC+3nvmjaOw5ODk58c8CNl/j2fY5zL34vOSG2q6ox50SDxE1LFTTPaeuimwcBxhRyMRvL7SMPKmRRct2+zlG3gIPBL7GRGUud0uVrToHEEA+IdaLKcETfqZZaD4t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB9072.namprd12.prod.outlook.com (2603:10b6:8:be::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4; Tue, 6 Jan 2026 13:13:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 13:13:20 +0000
Message-ID: <817bccfe-8919-47de-96f4-9fa2556d9b1d@amd.com>
Date: Tue, 6 Jan 2026 14:13:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] board: zynqmp: add cmd for getting boot auth state
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: igor.opaniuk@foundries.io
References: <20260106125901.1491300-1-neal.frager@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260106125901.1491300-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:a03:333::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB9072:EE_
X-MS-Office365-Filtering-Correlation-Id: feaa0e18-fab6-4897-1d2f-08de4d255cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDlVV2ZOOU8ybW15VFppczBiTWZzY0huSHVocFVJTU9mNlFjaEYreDZQS2NK?=
 =?utf-8?B?TUVKZlQzYnVuT2hpODFCM2RBNzU5VjI3NS92QjdBZnV5ZmZRNGh2dUxJRUFl?=
 =?utf-8?B?SWJlYVhaVFVxRm1zNGNsbUExc3RvWENxNWwzNk42UjhvYkhqcXpibnpuSlo1?=
 =?utf-8?B?dmdOOGFiWDFGMW1saEsrZ25CaEhBSDRxZm9tK25JUURrdGxjZmJHb2xxTXpS?=
 =?utf-8?B?M2JoTDFYTlVLYXFiVFZwcmt4TkJlUldvWEI3UlN6bmZqejRnVExlWlRzb1FE?=
 =?utf-8?B?ankxU2dSalVDOEtYWkg5WUEwWTA1aGdqL3F5ZUJxSjVvNWZRbDBJem81S3o2?=
 =?utf-8?B?dXZkYkdtLzlhN0gyNlNYQkk2UnU1N1Bja2FWZUszcnBYbitZUGdiR3Ixdit1?=
 =?utf-8?B?ZGVYcFpZU28vSkJpNmVWS2tBb1RITWV4Tzc0UlNMRE1Xc2RhUHViMFV1MlBP?=
 =?utf-8?B?cWhmdFRScE1DanZYSUx4bTZnR2xFckVpZytLNFN1UUp3a3ZNWWdKM0lVZlhS?=
 =?utf-8?B?WFEwbVJ5RC9uaUcrd0ZVNDNxZGlNcnZhdzJIT0tIdExaaDFqZkdtbllqNkFy?=
 =?utf-8?B?OW9Ka1JzVVoxbllwUUNJcTBoOENkWHRveit1Um01T0ZzTWxRMzhkOTI1OU1s?=
 =?utf-8?B?L1M4UTloMkRsRWg4S1J2SGp2QngwOVVwaE9YYTNQaDJrU3JBSGQzQ2lQNk5L?=
 =?utf-8?B?K3c4MEYza0l6RnJBaG1FU3VTaGFSMTVHVGhrV1dkRTV3U0xqbStRNnd3WXNz?=
 =?utf-8?B?bExoV01JU1RDM04yYUFJWXR4Q3Z6b2duZWM2eEVETlg5a2E2Vm0wUlY4NDFn?=
 =?utf-8?B?UkRsb1BKbmJ6ZHVMd2gvMEtOVHdXUXZtQU5aY3VSNlcvcy9GSVFwTEZqVndt?=
 =?utf-8?B?UzZzNTFEYW8rNHovdWFXMG55L2FvVmRPUVgwYjk0WUFKUXkweVVaTW54bWd5?=
 =?utf-8?B?RWZ5OVJ3ZVZwTkg3VVRxRDBMak5qRDlOOC9KMHBueEI4QWhRZWhESUxnK2ZH?=
 =?utf-8?B?ZGthcjlINGd6Tk13V1owOUs1c2J2Tnd0NWduUFlvTWxtQUcrYnRSdk9kcmpn?=
 =?utf-8?B?UlhlZEc1MWxTUTNnM0VVMjhWQzZESE9MSVgwU3FMMkJMV2lkVXlDVHJ6dm1i?=
 =?utf-8?B?RFMySUlWTE95OEtpeW52VVVMM0V0U3JVd2dveE9LZDVUcDhFc1Vsd2NtVFE5?=
 =?utf-8?B?bFF5bnNSVlZUQTJpbFBRdTVOaWZmT01oa1JBb3FxVFJFOGNuUjF4dm1KTmNM?=
 =?utf-8?B?ZGVic2FmckxtRmZVbWJ6WEJYNTBoNmx2TDB4TzFqWW1UZHlRbW11ZFFjeWRJ?=
 =?utf-8?B?ZXJXSm9VWnI5dWt6QmNKcEluRlNWc254ckdBeC9TamRuNyt3OXhrd0syREtm?=
 =?utf-8?B?QVFDa2l6SGZTR05mZUV5Tzl3US9kN3NhRGdLenVRRm1BR05UcjJFc2JSQUhj?=
 =?utf-8?B?M1I3WHYvS25FN0l5MU9EaENvUkNSc3dvQzlTaGNXaGtFTVduM1R3bC9tTkFq?=
 =?utf-8?B?M3lUOXVJV2R0eTVFcEV5dnUzQzNrWEh1aG1RZ081M2h5NU1PcWFhTGR2aUhM?=
 =?utf-8?B?NElhR3FaNCt4aERUM2lMTUFERFU1L0ZoYVo2T0NUdEh3T3RuVklMMGVmZFF4?=
 =?utf-8?B?UzE4MzdEMkhOU0QraVd2emRUYXdWZnQxMzcyT1ZodUc2Q21XSTFPZWtWWDVB?=
 =?utf-8?B?b3BsbW1qZnVGRzIycXFQaFcrb2dMZUlBVlM0SndBQ1IxL2x5TXF5VTJ3M0RW?=
 =?utf-8?B?NUFTdFhyR1F1UTlSakZ4Y3U3NnlzU0RneWc2M1Vrc25vejZqLytQM2F5Zzh3?=
 =?utf-8?B?alhNNjRIZEErdDdWTXBkcFdoSjgyVTRKTWNPNUpuajgvbVBBREtBQ1JKWVJC?=
 =?utf-8?B?MXI2TFpYNFlsQkRqM0dpbjhPWmx6b1prMzREMVVMbUdtSFZFUExZR1orWHJi?=
 =?utf-8?Q?aJmKnDkoq+7vccbqY/fFgUhbmIk6PnMd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHUxc1RvMmd6bHVKeUFGcFZkZ3RDUG84SXFiQW9pSDhoaXJPK2RsSDQzRFpL?=
 =?utf-8?B?QkJxTUgwNi8rTkxXSkpqdk9FWTlseE1YeXZrcm9zaTJqR0k3dkMzK3ZRUy8v?=
 =?utf-8?B?WjZBSmZDeEpvRS9WejBqOXhsWXA3S0xsMTJJdWpnRHYyZjJnN1VZa2MrTFhD?=
 =?utf-8?B?dmxlUThLTWduVUJxR3hDSjRVNWk1dktWbjkzdENvMDM5TTN4OGE1NDlCOE1x?=
 =?utf-8?B?aVVRSFJRWkZpZDJsOGVYRXlUblk0a1FQaEdFcGcwWVp4NStmT3pxQSthYUl4?=
 =?utf-8?B?QWNwZVRLa21VUFVFQVBoR0tETmRFMEVFWUxodGt6Q1J4emgvUkcrTnpOUGZW?=
 =?utf-8?B?VHN3V3M5UkcvT1RLY2xkRm1WYkhlL1lzTFJ2Z1FaNzQzUDgzTklMNDVaQnVT?=
 =?utf-8?B?cnNDa3BjRkFNMzV5bDZtUlNwZlpzT1Zya1duZEM0VGp5U0xaWGxPUnZEa2Vx?=
 =?utf-8?B?Sk9weDc2ZGQ5UjNlWE1iYnJJa0pDVjdZZ0p2U2JVZS9BRVNCQzhxTXJBV3N0?=
 =?utf-8?B?d0pIdzFlWGVpR2FSQXAxNm5JbURiRVBtbm5OVWxEOFFSNFNHbG9VODZsTC9t?=
 =?utf-8?B?aVBQVHgzK0RtSEM1V1BvVzRZbFhJWE1wcUx5cVBseVI2Ymdnd05ERGtJNUFF?=
 =?utf-8?B?YWNld3NqVlVTM1hsNWcxNUJNZEFJRy9YRmxxeTBvclZTcm5KTE9uamErYTgw?=
 =?utf-8?B?ZVVmbGtFMUd0dTA5SGxoMzN0K09oRi9EM0M4aFFidTYxSzhxMzBTY0tXV0Q5?=
 =?utf-8?B?dHB5NTF6VWl0VTBkb1Nkbnc3d21LRUFuMWxlZU1nU1d6SGNjSlVEMGQ0Y043?=
 =?utf-8?B?ZE1TUEtvODNHdGUwY0VCeWVhU1dwZUNFRmxDWGh4MlphdHpSMVJhVGk0TENT?=
 =?utf-8?B?cTdKYmNLZzR5Z05JNDNoWW5tUUFMdXowenFHTlQvUkEwdDBPeGt5dS9abTg1?=
 =?utf-8?B?VHpPNWQ5RVA0WTNia1NhMC96di9qeUVPMHN5RmJKOXNFMFVqbU1TRytzcnBM?=
 =?utf-8?B?azVxSmZidjFMbG5aeDRaMjQvVE81VXdOM2oyaGgvZ3hhUlJBS2FqbVhxREl0?=
 =?utf-8?B?elJDamNnakNHSkczek5wYmErL09SZk5aUUVUZjlnY0ZER2MvbFBzNnhSeTd0?=
 =?utf-8?B?ZnI1NDM3b1d2ZnRIZkl4NjZrejQvdlNYQnMwayt2aFhxTE4wcXBtVm1Md1B0?=
 =?utf-8?B?SXdpdzhvMVpMMENrNUo3MDVBOEJFajcyOTlqNE5leDh4ajAyeDJhYlk5RzdK?=
 =?utf-8?B?TnJybDk0ZHZHeFp0WDMrb25jQThZRzNPL0VzVC9XNjRoMjgyU2xSdGRBRCs4?=
 =?utf-8?B?L01yekF1ZS94N041alNFOFl4NGZuNElVdWhxUDUrWHZBWHg4Vm1ZQ1lpOFho?=
 =?utf-8?B?dzJkZzA0ZGI5WUpVelhYeW03Zk5pMW5URzBmcml0dm15QWtQTXE1eENrNEIr?=
 =?utf-8?B?TG9jODV3SnFFVDNyU0d1TzNnODUrdFZJdkI4NHVoalFndEZienJCRDhjdkZw?=
 =?utf-8?B?QTVpYUZ4RG11VkJJYjd2L2dwWGVVeTFMdTRlajZVSGt4cmNUY3RsUkM1K2xH?=
 =?utf-8?B?TDlpZWxxZWFrbCt6Um1VOWdLaTlNd212VmhsdzRvek9Ua2ZmenMweWxjZ0xZ?=
 =?utf-8?B?Y2JWQVNvV2IxVGlGZ3hneFlGeEVlcTdSYzkxQVM0ODVrK3RMRzdWY0hTeDkv?=
 =?utf-8?B?RjVxdE1reVRadW9RZHI0OHR2RGpwZElHL2JVSUlSUzRUMmR5bjdWL0tpMlRZ?=
 =?utf-8?B?aEdCM3M5MysrNlhNTEZNR29TOHRIR2pRZndqOXF1WGZPMW5acmdEZEI5NDNM?=
 =?utf-8?B?ZzlLSGpMdXgreHVDeDFabVJRdDRBeDVNcVc0YWdHUmZwa3FPU0p1M0tkWVo4?=
 =?utf-8?B?Wkg5ek1XSDNSRm9wY3VtZkgxaVFmaElBMVVSWmVBTFVOZWt6dUQ2YmIrTUJD?=
 =?utf-8?B?ajJ4MTJEbXg0SGR3VENtMGpVWTNaOXBvSjBwWXN4QU9OZndQOWFoQXM2SHhl?=
 =?utf-8?B?MlJBVWhYcGNXM1doWG1uSmx4Z2l2d0RoZUVzeVZVeWJwdi9ERjNYWnJFaXNa?=
 =?utf-8?B?R1VkQ3VIaHlicVh1S0VIQnBkU0NTMHZMcE1ORGx6czVsUXhEVjR5d09aMmR5?=
 =?utf-8?B?R0toTDRJcGFIRXNTVVVSbzQxbHluMStCbFpCUkpBLzE2eXE0WUpxMmVaalNr?=
 =?utf-8?B?dnNpeVlWdDIwdnRwL2Vjc09tcVhoTkNhKzd1b0tjOVNNeDk3RnpkL3B3ZG00?=
 =?utf-8?B?VzNNTGUxQjBNdlg2L3llTjBndHZJOEM4Z00yMG4wQjZaVDZmSXFmcUR4T0lw?=
 =?utf-8?B?ZkJ1cEN0OWVjWHc1eWFMVG5XL29CUmYxajRJazZ6V05hTXV0V1BuZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feaa0e18-fab6-4897-1d2f-08de4d255cec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 13:13:20.2303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GPST7ELMPfi4aq1JSZZ4AjoI0nz2tRTNjtwHibYd3ST2MSJMPRL75GDLjp7AZj+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9072
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



On 1/6/26 13:59, Neal Frager wrote:
> Add command for checking if boot was authenticated.
> 
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
>   board/xilinx/zynqmp/zynqmp.c | 38 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 3b28ba62374..92351aca36c 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -149,6 +149,44 @@ static void print_secure_boot(void)
>   	       status & ZYNQMP_CSU_STATUS_ENCRYPTED ? "" : "not ");
>   }
>   
> +static bool is_boot_authenticated(void)
> +{
> +	u32 status = 0;
> +	int ret;
> +
> +	ret = zynqmp_mmio_read((ulong)&csu_base->status, &status);
> +	if (ret) {
> +		printf("Can't obtain boot auth state");
> +		return false;
> +	}
> +
> +	return (status & BIT(0));
> +}
> +
> +static int do_is_boot_authenticated(struct cmd_tbl *cmdtp, int flag,
> +				    int argc, char * const argv[])
> +{
> +	int ret;
> +
> +	if (is_boot_authenticated()) {
> +		printf("Board is in closed state\n");
> +
> +		ret = env_set("board_is_closed", "1");

I don't think we should create variable in this form.


> +		if (ret)
> +			return CMD_RET_FAILURE;
> +	} else {
> +		printf("Board is in open state\n");
> +	}
> +
> +	return CMD_RET_SUCCESS;
> +}
> +
> +U_BOOT_CMD(
> +	is_boot_authenticated, CONFIG_SYS_MAXARGS, 1,
> +	do_is_boot_authenticated,
> +	"Check if the board is authenticated", ""
> +);

Also having this high level command doesn't look good.

You should extend
arch/arm/mach-zynqmp/zynqmp.c

and create new command there and return 0 or 1 based on status.
Then you can use it in scripts without creating variable.
Or obviously you can create variable when command pass/failed.

zynqmp is_boot_authenticated || setenv whatever

M
