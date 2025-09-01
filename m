Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70374CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2CA833AD;
	Mon,  1 Sep 2025 08:52:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="W1joN0kn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4424C838AA; Mon,  1 Sep 2025 08:52:41 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B92BD831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZywQYm/oMa1mzxOPSlU54jsroZglbw7C26GuEUYoI1reXfdYqRYWKzCbqLPs8nxB3AflV9h6ygBueOTOB63kHQmLqd4TETSb11QxYVrBMq3maPXXp5RW8XL6EGo+9Frz3pDX+0/XEttIEL9W/wdLHOnBhrlx2Kr8Swg/DGhslzNrWlJEiuo/jl8T71L7ln34wh5a9DIR7C+w0CA2ZxTflh+9jAP71qoIVHdAYcBAChPuFtJdyHi3/oFk6PQzAANgP2PU6vjHiX59sgq/cvceF0vnsy3fSwWoLcTT0txlrPADrLZ/vSPUDbTK7iC+HA5tNs39outDaQHYs7yHaKbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KnhDyzShzNlXqah9aAO8fnboHK0W6Wi/Ujyxwr/yZ5I=;
 b=gzVNi0jfE3Mto5OvJVG6OTM0t6ZpLqxPFWjDhO2mTZNUMr7i6dsBylKhH1WylIX5O3ZNLerIURMAc8ymqN5HFZJHE08N/bkUjRRBIdfA/bsex36msAGCsIHAb21jBWcTYrOWsT701ecQFeESncUwG92oGrVdV4IFYyfHn9jrvag7z3KE2SFNS7L7Vj9bRUxUHOvfdvwekRQF4HL8m935TQwn+pRdJ0nnpBzSovtjxpESIGPwpGcy65A4jex0srrCTyOEP7ihFfZuOkDzgAbMk0/UKDcV/r+cSCGa7Bq/P+HakaLB2+nSlygz1600CbeKi026twr9XsFlXbMu6Ibb/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnhDyzShzNlXqah9aAO8fnboHK0W6Wi/Ujyxwr/yZ5I=;
 b=W1joN0kntf3nvVdSHG8r0kVMnwBZjgSGSdMFa9WjxWM+kzGj0zw71F405mykLqU4hv7BWQNUzW79Ey3sLOVOrjAablzLKrz2Q/izwgphTt57iO4VNCSwdqtUnv5GPxQdWlAsnNqijzXglY7MF3648jFVbdgt/ZK8jscSMgRLwbX185sZjhSmrLl4PJ8lvVqVcEFv28z/5hUJdTT+FfPMhDDWFygl0sEiRRyhJ26Wh1ZhiPnckmVIdt06evHCu81teCLpKN1bllac16vFCouSdbmlWrTIdDxjXXSWdHzKHwCSJGIMzjJhXd1niqBHJgiWN3HEZ5LduK3IxDUvM9kdJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6849.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 06:52:35 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Mon, 1 Sep 2025
 06:52:35 +0000
Message-ID: <6c8ae3a7-858c-4d1c-8e05-9f7ad766bd93@kontron.de>
Date: Mon, 1 Sep 2025 08:52:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Please pull mmc-power-next-2025-09-01
To: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250901050359.GA31200@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6849:EE_
X-MS-Office365-Filtering-Correlation-Id: 0571ff08-ad10-477d-5660-08dde924218b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0tTZDY2T1kyak1OdGdFTjR0S2tVUmVjcmZpZ0ZXZS9HcmNrN3pKaWdQbG1k?=
 =?utf-8?B?MmwwTm9FN1ZEZEVZMHp6ZTI1LzdKd0FCdWpxVTJGOTFTU3FnYlVJWjZ0V2Ji?=
 =?utf-8?B?Ny9xbGkxTjZpdFJUNy93VGJUN3R5NndFTzcycWdtbHFlQ1JqT0t0Y3FwMHRC?=
 =?utf-8?B?OFQ1TGtJeXlHc3hXbkdqbU10Y2QxTnd0Y0hrVVAwYnJIZzU3dExpYXFTQitV?=
 =?utf-8?B?QnZvVFVRNEUwZGlEMi9SdEpWME91RXhkZzQ1ZGdrenhlci84bWFtL2YxTVJn?=
 =?utf-8?B?WG9TSG5oYmRHdFgyNStmRWRDeHVpYUJpWVhmUURTZ1gveHVkZ0hsckx0L1A5?=
 =?utf-8?B?Y2J0cEZ2M25MRkM1M05NNGh2VjFLZk5zcHQ5OWtxY0hQNTFCUG1iQ3RrNTBK?=
 =?utf-8?B?a0t6L1ZuckkvbmxxU1lzWkdyeGhNdWlvdERRNjQyS0dDdGJaSnZBaW5jT0VG?=
 =?utf-8?B?R3QrUURadldHU1RXUis3R0VpYUZIazIrV0E1M2Z0VUNlcFNzVWRMYXVaYzdR?=
 =?utf-8?B?QUg5TU9GcFhyU0RpaUQxb2dzZjZZbDJJclZyamt0VTBadjYrbXhMZXN6aXEv?=
 =?utf-8?B?RUNJOWgvVFFJZmthWklnWkpiR2RGblc3K0N6NWpOMUVTckdRcHVxYVJZazAw?=
 =?utf-8?B?dnh5L0hhUTQ5M2Z6eHpET2JzMjgzemVyN1dPM1VZb2tDa3pianppSjh0UkVU?=
 =?utf-8?B?RUxFbC9MWnNuWlFpZDQwYjNvblBFV0dhT1dXVUt2TEQxZXNONEJaT0MxNFlF?=
 =?utf-8?B?R2UrbklFaUpTN242K25sZU9zMFBSbGg1QnVSQlZYaEJadFlqeHBXcHFVa1pu?=
 =?utf-8?B?aWVubyt6QmkrWFI4OFVqODZLaVZ2eVBVMUYxbGFNaWlQSFpzMkZRSmJZTjFW?=
 =?utf-8?B?YUY3U3h3ZFpuZVlYdHFEeE1NV3JJWU5LMGNxS0xZWkdUcS82NUQwYk9hNnkv?=
 =?utf-8?B?MG53UmEyUWdEaVdMVGtKSDkwaWFrQk9aa1JhRWVDZHhjbk92NlhoOVJCeG9n?=
 =?utf-8?B?cDFoNWg5Q2RNSVZRVnBWNE5DeUNhZXcyck1kVERhUEUwZWpXZXhTbm91MGtC?=
 =?utf-8?B?ajRjVStqMnVRcGxGZXFlNy8vRmNBZlA2N1Y4ZUpNdldYbXFiT25ubC91bHJx?=
 =?utf-8?B?b2ZpOXFPdnZQaFZ2QVFXVTlrT2ZTR29SUGhrYWllQjVablpOSE5NejJVTGE2?=
 =?utf-8?B?Ukx3NGIrZWhTNVUzNVFLVlZRaHFxQ256NFF2UUlEQVBMZWJTNXpHWXg2SWdk?=
 =?utf-8?B?cGZJSU5hTGxsemV1S3cvem1aSEdEQzFnYkN4MzdFWjBYcUE3bGZIK3NXd1Zs?=
 =?utf-8?B?aWIwaHpIa2FBQVB0d3FWdnhxNG13R2FwZzNHOXBZVFAyZjVLVGxQRG9hakFz?=
 =?utf-8?B?WVJib3ZSZjlzV3c0K2Z5T0pQL2RKK1dibUhzQXhoVklvUHc0bUt3WC8vOEZU?=
 =?utf-8?B?bjFYMTBOMEtudFBrcEtVdXRiYlNmY0VCN3dnQmZyN3ZZVlhqK2EwOHJMTzZN?=
 =?utf-8?B?VUo4N1hCc3ZkVndZcHNlZVljYmlrU1lPL0xFWTJjRlM5alZ3WFRpQ3puU0hK?=
 =?utf-8?B?ZTl0NjZOUWdZNlhsQmVkdFJEQnRFVlJSQzVYRUpsb1dKNnptMFUyL1BZcnda?=
 =?utf-8?B?T2xRdjVDREkzY20rdEtKODJCbkpYZUh1cFU5TVJLbWVsbEdLandSNnVLNGNl?=
 =?utf-8?B?NFNaUlROSE1EWVY1VE1jQ3RxUU9hcTl5Y3h0T3ZWVWI0R25IM0kwekRJZTFP?=
 =?utf-8?B?WWpTODRLTXZ6d1RFMTRQKzNIbVhNZGxyTmk2RFk1WUVMdmlCUDFXV1piZGlv?=
 =?utf-8?Q?/lpAX5R9NUtXCD9x4JaM/nsjL2B9ylAnuoN4c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkduNzlnYUowb3pXT25yeVh3UFRqZWdQMDUzMFVrMFhBSUd1Ty9EYjhuOERV?=
 =?utf-8?B?VnJjZXpCZEVOVHdCSnlGOGl6K1RzZWhPQzI4cC8xenQzUnFyMDRBMXpJMURN?=
 =?utf-8?B?a1ZRblJnTHBCWXF3dVN6bG15eGZ1bUZOWUlNMnJET1FnUnNqU0w2a0lkeW8z?=
 =?utf-8?B?TVFWZlpJVTg5R0JUd0RXcEQxMXZlTGsxNFErSnF4ZWlaUzVkQ25DOEVUUURw?=
 =?utf-8?B?QUNKMytQM1h5cjFEVDdiZmpSMGRQMU9JcnFLZGZMdFBJK041aGQxS3Fra2pJ?=
 =?utf-8?B?UUVXWVAxSkx0aUdKOWxRbWxYYWFHUnpuTzlmSXlxQ2h6K0NLSWJxaWpJM2lt?=
 =?utf-8?B?Y3NIcUVVRzQrT003eEYvenQrTWZQN1VYdldkYlFkQkRqT2s1Q2R5WkpTVnNo?=
 =?utf-8?B?VFNvQUxKQ3pTSmY2TnB1RmRsaGpDaDlodFB6bnRTY1hTVEVFUCt0bmt1OGdJ?=
 =?utf-8?B?M3gvbTJHcHRidGdIVTlzdXQwL3RXMldHOU9WaUNYczUwanFJd0pGS29vcDZz?=
 =?utf-8?B?eDBsamFPTzg5VTVzZmR1VkZ1N1J0OHpGdTc0NDJ4M1FVMlZ6WWZkdGxXeWpn?=
 =?utf-8?B?RmlhQ0dqcVd6d0tJQzNoSGM1OUV4cFkzalVwTEVWVHViMVo0MjRielV6VDFR?=
 =?utf-8?B?M2NNeGFvOVg0NmdBcm5NVjBvTlhwLytOSXRkdUtVNnhBaVNoOGJQNVdmN1Z0?=
 =?utf-8?B?YU43WlA4QlVucW5yRysvd2djT2NadXByUWZ5eG9iWWo1UyswYXFUdTVidmJ1?=
 =?utf-8?B?Y0htRTFFTmhrWUhtcWhWbFZJbWR2ZFFZb2REdW42RGF1dVNmeExQMHJUWlFH?=
 =?utf-8?B?Uzlpb0hXSFpGVlVKZVJpV3paQlJ5VG9tcmpnT25zam1aaWNZQ2hJdDRFemFi?=
 =?utf-8?B?b1IxNEdJQnBOenhlbE5DSGpOVHBXRllRTlluNUNMTHVtMDQzRHB0L3QwZCth?=
 =?utf-8?B?YnorTG1ockl3cE9tKzFUZlJzSG04RktBcmxBOG4yTlhqWFVyTWJZWHJmYUFv?=
 =?utf-8?B?TkgyZG1SZDNiMGduZHNFK1M4V0QxSUpHVHNUWENxR2VLNENuSng2bXpwUXN3?=
 =?utf-8?B?TW5vTitqQWQ5QWlKYWN6NlBnTGtOUHBoUEI5aEJSVlkvRDRISDBESXVFTVR3?=
 =?utf-8?B?Z3l0UkxiRmJDWVB0d2JPanhXbVRTUzBDVEFvZjl0SWFFSkZRR3o0MU10WDNC?=
 =?utf-8?B?K1YyVERJOWYreDM2b2dORHR2Qm9OejFtV3lYaXlSMFRUNmJINnl5WFpKYnR6?=
 =?utf-8?B?d0I4QW93WHcwdEhweE1LdGJjeFhhRCtrVzhGS0FqN05aM3d3NHlZMEl6TnZY?=
 =?utf-8?B?Y2hUTEdlNGQ0eitNTTF1ZVJUK2tTWEJRK2QrOEZKdnJLNXh5eGdMUXNHRDVx?=
 =?utf-8?B?d1NESm5DeXJrNHAvbmhMb2RhbWFobUVpdFFhWjRlczRlcWFRbFlRNTZPWDN0?=
 =?utf-8?B?SXZZRk9vVk45MU94N3ZYQmFlUnNwMXhRQUFyR2lzQ0pFY09mT1hWV2tYY3RV?=
 =?utf-8?B?dEVoQU9DNDh3TjdJSEFlMFFtTTd6NXprWW1tNWtKenAwdUhhdFRyNXpXc3RK?=
 =?utf-8?B?bk9KTngzUjhsMlNjcmw2ODhpNmxJQkZMdlYrNTE4aE8vc1QzQmwzS254Z2NG?=
 =?utf-8?B?b3BleDllMWdrMDBmOEU4alIrZHZlRG5ya21JOEhKbXpSazQvQXd5WDlQdWNJ?=
 =?utf-8?B?MTZReURueHI4d0lWOERXT3lPbXJydmNWbWE0L05rTVV2NDZ2NDV1Q3ZuUUlH?=
 =?utf-8?B?R0N2TjlxRjlwQWU3eTZrR2FVYkoxZWRQdGczd2NCaDh5bWU5Q29LOFYvanlF?=
 =?utf-8?B?QnMxM0l6RXpaOEhoREhNOEVIcU1VVzhaVDNibS9BUEliM0tJVmhCbmJoTWp1?=
 =?utf-8?B?UEdqUzZZT2Z0QUVPdEZhVE43VWJRV3BHUlkwQ2RGTitOSVFpWnBZV1A1MTFk?=
 =?utf-8?B?U0UyWlNQazZiSG1ZUThCbE9Edi9sQWJWNHlscE1ZSzRvRC9ibmpVTGEwZ0Jk?=
 =?utf-8?B?cnFydStmQkZMdmY0VGNCak1ISHFYNU0ybVVUVmE0dENBVnF5b2JSOVlOcTdn?=
 =?utf-8?B?UUl5YWVsL1hKWDkzbGdDSnlCaUI0anBJRmxYZEcvWjVNL2xvS1NZSktWemk1?=
 =?utf-8?B?Q04ycGZ5WWRFbUVQZ1NTZFZCUkc1c2llNjdkdUpGdWxSeWp2YUEwSXF2YUdT?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0571ff08-ad10-477d-5660-08dde924218b
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:52:35.0184 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mQHrxHq0d80rzfapS0uoWJ5KfH58F66EBr5Jitd5Hw0D1C2yg4ygewbXWfvHCS2+rvygmZIj3gVn7vV4qnvZtKJLjo1K89lemQ5p/eKJuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6849
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

Am 01.09.25 um 07:03 schrieb Peng Fan:
> Hi Tom,
> 
> Please pull mmc-power-next-2025-09-01
> 
> ----------------------------------------------------------------
> Update compatibles for PMICs used by exynos devices
> Support system reset and reset status for pca9450
> Fix for pca9450 LDO5 registers and drop deprecated sd-vsel-gpios
> Two minor fixes found by smatch
> ----------------------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/27536
> 
> Thanks,
> Peng
> 
> The following changes since commit c9ffeefeb3efedd754e3ffa3440bfeb15cea00c3:
> 
>   test: Update logic for video test (2025-08-31 09:32:17 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-mmc.git tags/mmc-power-next-2025-09-01
> 
> for you to fetch changes up to 140562d3a2b447079499d773a7d21ec1728692cb:
> 
>   mmc: core: drop space before newline in trace printf (2025-09-01 10:33:10 +0800)
> 
> ----------------------------------------------------------------
> Andrew Goodbody (2):
>       power: regulator: tps65910: Cannot test unsigned for being negative

The change above has unresolved review comments and IMHO it shouldn't be
applied as is. In patchwork the status is correctly set to "Changes
Requested", therefore I would expect it to not be included here.

>       mmc: iproc_sdhci: Cannot test unsigned variable for negative
> 
> Bhimeswararao Matsa (1):
>       mmc: core: drop space before newline in trace printf
> 
> Frieder Schrempf (6):
>       Revert "pmic: pca9450: Add optional SD_VSEL GPIO for LDO5"
>       pmic: pca9450: Fix enable register for LDO5
>       pmic: pca9450: Fix control register for LDO5
>       pmic: pca9450: Handle hardware with fixed SD_VSEL for LDO5
>       arm: dts: imx8mp-data-modul-edm-sbc: Remove deprecated sd-vsel-gpios
>       arm: dts: imx8mp-dhcom-som: Remove deprecated sd-vsel-gpios
> 
> Henrik Grimler (11):
>       power: pmic: s2mps11: look for both {voltage-,}regulators
>       ARM: dts: exynos5422-odroidxu3: rename s2mps11 regulators node
>       power: pmic: s2mps11: remove check for voltage-regulators node
>       ARM: dts: exynos4210-universal_c210: rename max8998 regulators node
>       ARM: dts: s5c1xx-goni: rename max8998-pmic regulators node
>       power: pmic: fix typo and capitalisation in max8997 Kconfig help msg
>       power: pmic: max8997: support maxim,max8997-pmic compatible as well
>       ARM: dts: exynos4210-trats: use maxim,max8997-pmic compatible
>       power: pmic: max8997: drop maxim,max8997 compatible
>       ARM: dts: trats: rename max8997-pmic regulators node
>       board: samsung: odroid: drop exynos_power_init
> 
> Primoz Fiser (2):
>       power: pmic: pca9450: Add support for system reset
>       power: pmic: pca9450: Add support for reset status
> 
>  arch/arm/dts/exynos4210-trats.dts          |   4 +-
>  arch/arm/dts/exynos4210-universal_c210.dts |   2 +-
>  arch/arm/dts/exynos5422-odroidxu3.dts      |   2 +-
>  arch/arm/dts/imx8mp-data-modul-edm-sbc.dts |   1 -
>  arch/arm/dts/imx8mp-dhcom-som.dtsi         |   1 -
>  arch/arm/dts/s5pc1xx-goni.dts              |   2 +-
>  board/samsung/odroid/odroid.c              |  15 -----
>  drivers/mmc/iproc_sdhci.c                  |   2 +-
>  drivers/mmc/mmc.c                          |  14 ++--
>  drivers/power/pmic/Kconfig                 |   4 +-
>  drivers/power/pmic/max8997.c               |   2 +-
>  drivers/power/pmic/pca9450.c               | 100 +++++++++++++++++++++++------
>  drivers/power/pmic/s2mps11.c               |   2 +-
>  drivers/power/regulator/pca9450.c          |  37 ++++++++++-
>  include/power/pca9450.h                    |   7 ++
>  include/power/tps65910_pmic.h              |   2 +-
>  16 files changed, 139 insertions(+), 58 deletions(-)

