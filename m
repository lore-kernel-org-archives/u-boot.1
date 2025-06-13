Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D0AC61DB2
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 07:55:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB7F82C30;
	Fri, 13 Jun 2025 09:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rfvnWxTu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9062582C44; Fri, 13 Jun 2025 09:55:23 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9939182C2F
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 09:55:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hSO7xecH+3Lwu3Y73509wk9RRL19Oc0IuYydTNQQtdpTIt3P2cML7B/BSj7nVA/zm/IV4aq05OMRSzpLbVBpU43cxmf7SzB4FPipDWmDMggtJJq5e8iiZ9qrntTP3/Thq7nCa6KUASUCd6Bnle9Sp5RB6EW3z8u7I2rbRWzFDJAQnEPY5GEjuFxwdP140p5d2G9yVtlKIJ3zFBvNtAX1RRYCt2HV8ofsKokHK7r/yU2NEaXJ2phVngjn3vsxIDpWOpEQot3o4IDZIXS32Q/XUUbAYDoK6Q5XQZEgSfF2g/9EhgOEaB+4SjPXi1rz2uNMIvlyrBGa/wE7Ch77zD8EkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+T5PWA0ukj1QATUH9QxmGCVIleeg5/q+9IbanHDh9M=;
 b=UXC3Ld2Cq4H8dOXEUOQQmuZB17D8ghq25qSfxo3JIfoHiFK9TaMttRXpLyO2EEm13U1F87uUGY6kK8LQydpHwpM8ia80M6Rr3cYmuVveYs1Bc9BeyRNwi9uycQkeEJh/TOZCwAuJvFKdW6eyWsXKRHZW/jsfhzT7LbBPOhIgoiyTJDcU+WTqY5i0lSGekFQPArT5qntb3visDHu5S3YvvCl4POVrudtx/VipUSsT2YDLKOzEOMi12+KgUOS6KNrd125bal/hpmE/5lHlt6ps2bEHbGrJQPAeHAtUiK41kEcw3gqT4k2iqbXyHJKhyNJzvHllTvSdiN6MTcg8HT210Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+T5PWA0ukj1QATUH9QxmGCVIleeg5/q+9IbanHDh9M=;
 b=rfvnWxTuGjNFvbZEA/kh7VdQqDm4+769/fzrw+CdKEOFIIPbMhvKCIQbekSoAY64rFS06FSCHuYSb95NAgY+c2rldt9gXX8qXKaqLOvZwMz4ISj+hX6iNT7VFQLktzfyKP9Arq//wNjTi11S4MRX11FasOxHP51OruM7oR2TxU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Fri, 13 Jun
 2025 07:55:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 07:55:16 +0000
Message-ID: <7dd048ed-4f8b-4318-88d4-3bdf14f961b2@amd.com>
Date: Fri, 13 Jun 2025 09:55:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tools: zynqmp: add build script and documentation for
 ZynqMP KV260
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20250612153311.2379944-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250612153311.2379944-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0271.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::38) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: be91a667-2fef-4f68-47c8-08ddaa4fa246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTg1d3gxcExJbDhEZDRZeUlFZ2xpWGdnNWRyd3dXVHNEeFREZWxLNUw5OWFm?=
 =?utf-8?B?MFhDZXgyc0FBK1llbGRkSDdjRGNiNVdSZGg0NVREUVFrTFoxM1d3ekdBNmpv?=
 =?utf-8?B?MWdXSkI0V1p3T2dDUkk0UnFXN2xXVkhNV1dFbzVSSTRFMzdScWgwd0hMWXlK?=
 =?utf-8?B?ZkJ6TEtwY3lrMmhISWlST3pNR2tMSnh5cnJHYWtXYUJCRUR5UEp5L0NBOFBm?=
 =?utf-8?B?VDk3eGRCMENBTlFPdSswS2hwYXFEc3I5UG9WaHRld09MTVlDOGZ4K2x5Nnhk?=
 =?utf-8?B?YS9vU2JsREFXb1V1M25EaVJEamRYaHJ4b2xTR0tSWU8wV0hNb2FJUlZRM1Q0?=
 =?utf-8?B?YW5vZUE2OHVYZW9POWNNbVlpc0c2Q2JlcElkSTZTa3ozSUNIQjRoV1A1ZTY0?=
 =?utf-8?B?MHJDTGNtNkhNWTVmYnBHb0NoeTJIVHZvMjNkZFY3NTZqb0Q2cnhWNTh3VTBm?=
 =?utf-8?B?amw0d3FyZzdBUVA4SVZ4ZnYrdUdCTDVTcjZYdXNVQzRWa0ZYMjFHYklWT2E1?=
 =?utf-8?B?eHFJMFNVRzEyRFFDSEZzTXNNd3FXNUwyM3VIZ3FSeHN1aTNlRTI2a09FdUo4?=
 =?utf-8?B?WlhSSGtNZTFRTmNsWmZwenp6YzgwN1huRlNwMzBFelB4c3dMZTBMcjhZVC9h?=
 =?utf-8?B?RUFiUnVBSjZDSzVwYVVMY0ZEaStuUU1uSHdZM0ZXOXVxT001dlFOb1BFNWFC?=
 =?utf-8?B?M2FYMC93THNmTWs4QnlwWU9RZ0s2ZUo1dEFNQko5R2k5R2lENDB2TnpEaFNr?=
 =?utf-8?B?ZVptb3l1aDE1VHVwdnVkSFV0ejg5OXJmNDdYQWprWENtb1VETXhERFZicXhI?=
 =?utf-8?B?MXNKRy84T3NhWG5lb3c2d2pneU4vbnRKbG1ZVnN2UFVybm1FVnJjajMvRVAy?=
 =?utf-8?B?OU9iaWc4M09EWUgySm11Mkl2OS84OTRZUm8wbHVtSGlHZzlmbjl3dUh6SnYx?=
 =?utf-8?B?NUJRbFJKQURyQzZqRUR0c005ZVRjU29wclFPajJ6bUQ4YVJRYkY3dC93NkZR?=
 =?utf-8?B?VWZQcjM5YzNMZENaNEt3OTR4ZlRldDhsUlBZRnQ5OURKc0lIblRiRFk3SkRk?=
 =?utf-8?B?Yjd4MExDYmhOOTk4MjFTYng0aUJqc2FacVNOc2ltODIvRXE5MUdCekhCVkEr?=
 =?utf-8?B?ajkrbE9JazlXUGVYenM5KytrT2lEU3lMVHRlZVRnZHFQVzFHV0M3d0NUbVM5?=
 =?utf-8?B?bzV3YkJRdXY0OEpFcS9YeVE5ZnBTc2FZMFJuRGw4M2FBbHdvTnBINnYveEdF?=
 =?utf-8?B?UE5FTnhhVzlZaVBHUEprTDl4VWh6MVRvcGw4cW9jdE9qK0xNUEpQd0x1UGY3?=
 =?utf-8?B?WFJJbm5XM1JadmlMVTJzbk5uYmhtSkk2aFZLcTZsODBDUThrYzBFbmVIQy9V?=
 =?utf-8?B?R1N6YWtPbkR2QUhnckdmbHZWODZxL1JzUUVSc0N5ZGdNRHNmTTU1di9FZ1Ur?=
 =?utf-8?B?ZHFJajlEcmdlc1ZTL2VmOGR3Zi85WFFsY25ZdWdibHNnYnovQis1Mi84MFh1?=
 =?utf-8?B?M2tBalA3Qnh6VFlyMitxVHJ0NFNsZHc2RHdteEhYR0pydmdzempidWJ1UlZ4?=
 =?utf-8?B?QnN5WGpSVzk1Z3BaMTJFVFp2WDd5MGk5LzlkZXlsL1JLVjFkTWQvWGRMM25O?=
 =?utf-8?B?dzY1SldIandUNXRxWHV0T29TRHR5MVZLOTZjNXY3NEFYd3g4TzJiRmNSczJx?=
 =?utf-8?B?U2hRdlQvMFdVZ3pWbENPZ1AvazVIVnlzS3lUTTc2Wm9zWE4wV3F3d0dXbHNw?=
 =?utf-8?B?bHZnd3dCSmtOTHNKTko5MXlROGxuQkdFOG5oNTBNZy8rcXNFZ3pJVHFVd0Jz?=
 =?utf-8?B?YnM3SCs2eUVMNDVsaFFCVlRBSzlUTEg4bGdBeHFBYWZ1cms3eTdpTTFWZkZK?=
 =?utf-8?B?VVlVT3Y5WlQ4VlZvUW5zRVRzWUpzT0JhSGdzOTlZZ0dRdWZPQUdHS3Zmbk81?=
 =?utf-8?Q?ceVD8R32s7w=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk84dGQwVDc3eVg2cmswTkFoeGxUajhpR2FEd1JDdC93WGlja1JtOHR2WlFP?=
 =?utf-8?B?M2V1emlDYkJ2MjBlTWM4VUdnMUZvWmlqK29ySXBuVzNMSndoWmZSMDBuUmhQ?=
 =?utf-8?B?VlRWNjluSGhvdDQ2WVpUdzhnWi9DbzhQMlplZTlrTUtJRDhVbTdtOVJ5aGZY?=
 =?utf-8?B?czBnY0ZWMXNYSkVQOG1KVlZaT2VIUXYvQzRGYk9MSUFwb1RJTlROZ3l5SUMy?=
 =?utf-8?B?cmdrWFN3di8wQ1BoamRjak5QbEU1d21xcDZxZXkxY0gzaHZhMVBOUUVjU2g5?=
 =?utf-8?B?VlkzTWVmbnNGcWJFbVhVcnBZa1VIWDFUVXpwQ0dUSVhKRnkwRXYyZ1V1RjFN?=
 =?utf-8?B?WjNyVTBkN3o1MjlZTENCTEV0VWdRR1g2TlhTd09TUUQ5ajllaHJCZm5sNXp5?=
 =?utf-8?B?N25KOXRYSkx4QmNEZ1NzOEkyNDE2dG5za0NYLzZaajh5a1RqZ082SWxDUFl2?=
 =?utf-8?B?MnMvVXVnaU9ab3pvYUlqMVovQkQ0TFIzcWY2STlzaDBGRit4V1pxYzBHSHNU?=
 =?utf-8?B?dHNHTEl4MXRYTWM5bHZEV1czWlZqdG1OVWVMYzZ5Z2tqMzB0aGdnd3NwYnRm?=
 =?utf-8?B?dHFSS2RTR202VTVlN1hZTkFuS3pVTk91bWlTYmMzQ3hVRmk0cXNvQ0x3ZTdO?=
 =?utf-8?B?STRjME1BbytJT28vYkdrMXh0c09xWFl2YUlwL2JobXI2Z3dIRHBRcnBjTkNU?=
 =?utf-8?B?VkxZbXgxU1A1U20rbGNKNjNJUGNkRlpXQnhmSDAwUUE3WjFjVVhNK01jYTJq?=
 =?utf-8?B?QTA2ckRPYXl5Skg3Q1ZzejAxN21VL0JZdEVCZjl0cWZHS0prMzZQQWRhTFNX?=
 =?utf-8?B?YzB3QnNDWXg1alhmM3dKZnhkR0N5d0N4M08zV0tPWVNLZHRBaGFVMFZDM2RT?=
 =?utf-8?B?WVVPNks4VG02bzl6MUJjdUJsSDlaY2hWMXNMdzdPNkk3dnBjVGlrUVl6M0Z3?=
 =?utf-8?B?NGwzVTFZWHhhdWlGVjJOdGRhWFhyR3cvREgyTkJnSUJiL001RGJLNlIzcTE4?=
 =?utf-8?B?U0pWR01CVTBURHpwZHZxS0trWHVXSjg3Um9yalBHcHBwOUFIOFJsYWVCRzZ2?=
 =?utf-8?B?bkF5eEhzRFB1bUF2MWlvK092UzhJbFM3RGtzR0ZBcDZnN3F6YklFSmxSc2Yx?=
 =?utf-8?B?UFRzZUUrUHN5MVRHUjBybFJzWEFyQi9RenhwTmtZMno3RWtnR1BEYnJDTEgx?=
 =?utf-8?B?STFySTlOcm8raWdGUnMwQTFBUDNnZVc3dWt5YmtSWUsxY05UZkZ6dkxwK0xD?=
 =?utf-8?B?SVBaQW0rWmc5R005UDdZaElUYVIyNmpiejBvRzE1SDVRZzZ6a0xqMW1FNDR1?=
 =?utf-8?B?WnUrVS91bkRSK3hUaGpNTkNCUWcrUWhKMWl1SVdKaUMyQ3dhYzVEZVBPcUxo?=
 =?utf-8?B?VGhySHJtSFEzeWhHWUlUS1dZZkRKVXQ1MXY4TUlHTWVHc1VHcG9uaUYzK2ZH?=
 =?utf-8?B?MVdqaVQwUDZYQ3d4RWc2Y3JPenQ0YWdVL3REQjlUTkRiWlNxUUZTUjBCNGJY?=
 =?utf-8?B?S2dqeVA4cXBZN1RGR2VZUGNyck9MdmRFMFBOc3dzK0dRMllQSUxxdHA4dzVq?=
 =?utf-8?B?eVBXYjlLWmtzM2h0STNnNUYzYW93dG41QkgyZit4cmhZRGhKakg2c3psV0w4?=
 =?utf-8?B?ckZFT3RyRS9EU0w5UmQ3U1RtYjFYWng5VW81d2xDdjExaWtCeVBIWHFoR2Zy?=
 =?utf-8?B?ckF6bTJzUUtYcU45RlR3ZGp2YXE3azNQREFLY3grVHhoMjZZMFROdjVnUkd1?=
 =?utf-8?B?eDZEYWJUejE4NUdpd2NTZHBFNDhIb0dVeCt3a213RlZkSXB5OEpvaHVZYmFI?=
 =?utf-8?B?R0Vtck1UamxzQnVnd21weVM1aUJVcjY2dlZBcGF3V21FWksrK2svY0JEazlD?=
 =?utf-8?B?a0kwQmVQUWIzZWMxRFFXWEFzVzZjZ2hVdWVGSE1xMlAwcGVmZEVsaXpiZ280?=
 =?utf-8?B?dUFjbVhyRkhJRkhrWkNodG1DS0xRZlNDRFZMK2oxUGdNSTBXNFN0ZVBIS21R?=
 =?utf-8?B?V1dld1RMb05mNXF1RGtTYzg1YmdreXRwQzRDZUw2cjZabjRDTlN2M3J5VHV5?=
 =?utf-8?B?NGx2SjlzVnB6MHpOR3ZUaHcrNU5TQWJpS291QWlhS2twOThoR3FKNnlxcTI3?=
 =?utf-8?Q?7nnYleIBzXnoeDx4oEmcuA6nS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be91a667-2fef-4f68-47c8-08ddaa4fa246
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 07:55:16.0575 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5B96znG9+XowIAs+bOjaNWRVFEa+dyp3R2yFhZ+Hj7re+IbsUpoljMtsFpOu6B5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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



On 6/12/25 17:32, Jerome Forissier wrote:
> Add a script to help build a functional U-Boot binary for the ZynqMP
> Kria KV260. Also add some documentation.
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
>   doc/board/xilinx/index.rst        |  1 +
>   doc/board/xilinx/zynqmp-kv260.rst | 27 +++++++++
>   tools/zynqmp_kv260_build.sh       | 43 ++++++++++++++
>   tools/zynqmp_pmufw_elf_convert.py | 96 +++++++++++++++++++++++++++++++
>   4 files changed, 167 insertions(+)
>   create mode 100644 doc/board/xilinx/zynqmp-kv260.rst
>   create mode 100755 tools/zynqmp_kv260_build.sh
>   create mode 100755 tools/zynqmp_pmufw_elf_convert.py
> 
> diff --git a/doc/board/xilinx/index.rst b/doc/board/xilinx/index.rst
> index 2e31fe3f3a4..3f3a85b709c 100644
> --- a/doc/board/xilinx/index.rst
> +++ b/doc/board/xilinx/index.rst
> @@ -9,4 +9,5 @@ Xilinx
>      xilinx
>      zynq
>      zynqmp
> +   zynqmp-kv260
>      zynqmp-r5
> diff --git a/doc/board/xilinx/zynqmp-kv260.rst b/doc/board/xilinx/zynqmp-kv260.rst
> new file mode 100644
> index 00000000000..219bbd602e9
> --- /dev/null
> +++ b/doc/board/xilinx/zynqmp-kv260.rst
> @@ -0,0 +1,27 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +..  (C) Copyright 2025 Linaro Ltd.
> +
> +ZYNQMP KV260
> +============
> +
> +Building
> +--------
> +
> +To build for the KV260:
> +
> +   $ ./tools/zynqmp_kv260_build.sh
> +
> +The first invocation will fetch and build some required binaries (bl31.bin,
> +pm_cfg_obj.o, pmufw.bin). Subsequently `make` can be invoked directly as
> +follows:
> +
> +   $ export BL31=bl31.bin
> +   # export CROSS_COMPILE=aarch64-linux-gnu-
> +   $ make -j$(nproc) BINMAN_ALLOW_MISSING=1
> +
> +Flashing
> +--------
> +
> +Press the FWUEN button on the carrier board, the press and release the RESET
> +button, then release FWUEN. Connect to the embedded HTTP server and upload
> +`qspi.bin`. Press and release RESET again.
> diff --git a/tools/zynqmp_kv260_build.sh b/tools/zynqmp_kv260_build.sh
> new file mode 100755
> index 00000000000..3cf7147e3a6
> --- /dev/null
> +++ b/tools/zynqmp_kv260_build.sh
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0+
> +#
> +# Copyright (C) 2025 Linaro Ltd.
> +
> +set -ex
> +
> +if [ "$1" == "-c" ]; then
> +  rm -f bl31.bin pmufw.elf pmufw.bin pm_cfg_obj.c pm_cfg_obj.o
> +  exit 0
> +fi
> +[ -e bl31.bin ] || {
> +  ATF_SRC=$(mktemp -d /tmp/arm-trusted-firmware.XXXXXXXXXX)
> +  git clone https://github.com/ARM-software/arm-trusted-firmware ${ATF_SRC}
> +  make -C ${ATF_SRC} -j$(nproc) bl31 CROSS_COMPILE=aarch64-linux-gnu- \
> +	  LOG_LEVEL=40 ZYNQMP_CONSOLE=cadence1 CONSOLE_RUNTIME=cadence1 \
> +	  RESET_TO_BL31=1 PLAT=zynqmp ZYNQMP_ATF_MEM_BASE=0x10000 \
> +	  ZYNQMP_ATF_MEM_SIZE=0x2ffff ENABLE_LTO=1

As I told you this is shortcut. Recommendation is to put TF-A to OCM with FSBL.
That's why there are some challenges in connection to fit both of them there.

Another thing is that none is creating reservation for TFA in DT. When you boot 
Linux than there is big chance that user application will rewrite TF-A and you 
break your platform because of missing protection.


> +  cp ${ATF_SRC}/build/zynqmp/release/bl31.bin .
> +  rm -rf ${ATF_SRC}
> +}
> +[ -e pmufw.bin ] || {
> +  wget https://github.com/Xilinx/soc-prebuilt-firmware/raw/refs/heads/xlnx_rel_v2023.1/kv260-kria/pmufw.elf

Better to use 2025.1 version.

> +  ./tools/zynqmp_pmufw_elf_convert.py pmufw.elf pmufw.bin
> +}
> +[ -e pm_cfg_obj.o ] || {
> +  wget https://github.com/Xilinx/embeddedsw/raw/refs/heads/xlnx_rel_v2023.1/lib/sw_apps/zynqmp_fsbl/misc/pm_cfg_obj.c

This is any generic configuration which is not aligned with standard firmware. 
It means yes you can use it but it is missing SOM specific configuration. It 
means for example power off don't need to work. Also this can work on kv260 only 
but don't need to work on kr260.

My way is to extract it from released fsbl instead but up2you.

M
