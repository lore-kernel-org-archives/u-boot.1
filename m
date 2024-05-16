Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36782C25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 13:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9495688297;
	Thu, 16 May 2024 15:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="C09DwEqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3278C8829E; Thu, 16 May 2024 15:45:34 +0200 (CEST)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01on0722.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1e::722])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483988824A
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 15:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlfW0YTcdX1vmXFd8hPgMUQ7/W6XpLmLC+spErbKYdJqMm6Zz6icqM9WQ9MyBvU8kdQy7ovTsf60ZekQrkqRSm83Gz6AupTpFU9LpRSBge7iamaAiiBSXJvEZUlVNm1cEaRp0mafmDqRQm4rkRsApAUjApyt/qKgQFhuQvREu16C1CrNh0eXWXXKS5DPwsGnVXDaixP3/aAXdm3ktOwCZEgPLXeY5DbyPl/4laYCoiWq8WlIsHwLz+WNdNDNyiTj59QSG2mGY0s2wvEbGiEp4cfkR9IQXqdvT5XsyJEBjhCRAmfcbl5nNSX+ONUpvZ/ZOzIXsLA3YzBYnlsbYVA0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VH9UDucvd5V9ew3BBamBUCczY1STD+kjxU/vH7x8s/I=;
 b=OwFDqV14fSJq895fhgCz4UKbVxWyUUQ9R5uRMZEwmihe+62v07QD4WjX87SYEGlq19VEzUM08BXfQJXBhn5vKyA43zlkxs7Fsp27ISubCGeoYHq2mhokvaB/qTz6mTFhrYJcqS8G9zL5ppXWg8FlTpQFoUTmgoBC2fkoNqXlxUZ70T05PyNfvmCznJ7D+YSKoHFtkcz/0vvnOyyC8DdOLmmTFQdrpgPwlgkkqK+BouTGENClxgPCI0Xn+tz4iPY1KzJJCGf2SF/K4BbzLpyKs7q/Hh+7vMPkXbv/ddZuIknD0nTHaMnideMMPPAynSZyFPX8b5W/m6tjA77ddFaJBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VH9UDucvd5V9ew3BBamBUCczY1STD+kjxU/vH7x8s/I=;
 b=C09DwEqZZ36zeL66YA5ib7Y6Co72a+uyt6Y4KF7Nz0nRRyWw5PnMw1XMC6TR6a5+QHQgiK0P+Dx7SofzEojS51IkEoMIYupnLD4EBOttyYuXLcvIMuNkVyVhrV0VgkldlUO+oOoWPUfZU5ATsmrG+rhepHmXiBnLIjCDZfNTUdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AS8PR04MB8280.eurprd04.prod.outlook.com (2603:10a6:20b:3f7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 13:45:30 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7544.052; Thu, 16 May 2024
 13:45:29 +0000
Message-ID: <ab5ca03b-021c-46c3-90b6-079fe6b01aa8@cherry.de>
Date: Thu, 16 May 2024 15:45:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/9] arm: rockchip: Enable display cpuinfo to be build
 with SPL_BUILD
To: Anand Moon <anand@edgeble.ai>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Jagan Teki <jagan@edgeble.ai>, u-boot@lists.denx.de
References: <20240516090031.2373-1-anand@edgeble.ai>
 <20240516090031.2373-6-anand@edgeble.ai>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240516090031.2373-6-anand@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0196.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::17) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AS8PR04MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 50072649-6687-4772-0c5f-08dc75ae7326
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGh1WUxvUEN1KzJ0YXF6dEc1a0U0cG9GZWtQbzdXYmZPTzVHUkF2d0xHSmNY?=
 =?utf-8?B?U2xOMktScHJJZkJNdkh2RmJScEcreHoxRnowZlQ1MDZXU3lEZ0NuQ1hmd3dz?=
 =?utf-8?B?NXNZRmQ4dVNYZHlyK2VhNG5Wc1AwQ3N3QUJPUm9ZK1FNM0JjQnY0MjIvK3ZQ?=
 =?utf-8?B?d0FCT1hhRzZzRU92SmtZNlZrc25zRnR4U0Jia3NGeHNoRjNyeFNRTnQ3RzJ3?=
 =?utf-8?B?WlQ0Nmp1QUNMOTVqTnowdWJyaU1ueDUxVUpLNXVvZmVvVyt1cC9xYUJ5aWk3?=
 =?utf-8?B?c3dmcnZoNDNnTUFVREdwdEVrYUh1QVMxTjNGZU10V3g3elhwd0lXUXZuRGE5?=
 =?utf-8?B?RGN5NmFvMEVENWNJSS9HRGY0eEc1QTR0ZUtsbWl4UGYxdjhySjdrSmxBalEz?=
 =?utf-8?B?ZGtSM3d5Wm1DZGRjNm9HS3lUTy9RNGVGZXRKVnpieTJsWEhBZHM1dkpKSWcv?=
 =?utf-8?B?aS90Uk5RL2VQVjRJY3dLeG9nVG9WK3RyemJRQ3ZOcHVzT2MzUGFBUnZ3NFIz?=
 =?utf-8?B?UmJKNlRzNHJSdTVCbVlISzZ0ajQ1VEYyM0RUeWZaVGc2NjZBUWsvTlhhWE5Y?=
 =?utf-8?B?S2ttbWloQ0FvMXl6NGpCa3daeXN1c0hxK2ZGK0tmczNPWVRpZHRSSHFMejBO?=
 =?utf-8?B?RTBERUxBbnZWMG1FTmJIckFaN1Z3Nm1tUGpQdzQ5SkdTV2poVHEvR3JrK1Qw?=
 =?utf-8?B?c1plS0gwd05WYkh0VDJDc2U2aWFmc1dEYnJwZVVMRmxpbXdSd09mWkJ0NWpB?=
 =?utf-8?B?TzhKMUlveFpRVklLU2E3WjNJK1lSRGkyMGd0V2pIMnU2eElrRENHRTFTWFhm?=
 =?utf-8?B?cVRsVkRDWFNKRk43elQ3MnRjRzFHVkZjbEZ1REJXV0lHcFVhM3Vmdy9paE5r?=
 =?utf-8?B?N0VzalBDODAweGNWZWFqMnNEZlpxQ1VEK0tJc0xENWNGb2lCdjlJeTVEZzA4?=
 =?utf-8?B?dmV5RC9HTDYvTVNzMk5TajhacFptdHU3ZVdBQmN3empReUxCbnZMLzNvaVpr?=
 =?utf-8?B?bVZGeWJYeTlxeDQ4K1c2UVVjb3N4NjE1VE1ielpyVEQxbmwxYjV0TkNpZVRW?=
 =?utf-8?B?OEtxWUFhTFZoNXlBaEJYWi8raGJxNFBTZXE0Mm1SWlY5Mk0xMzhpdmlWeHVZ?=
 =?utf-8?B?N2daVmg1SDVSYVBSaFR5STg0ODV6TEsrRk5WVzVUOTU3eFFGSXI3M0ZtSDRR?=
 =?utf-8?B?a1ZGYURvNHZUdVVZaGtxaUhlYmQvM1QwYjExK00zcGxXcnI5ODcvTzF1ZVZ4?=
 =?utf-8?B?RW5TUGZ5RW1ldUtMcmlEOXhkdFhjSkM5ZFBPZ0FEK3pxMDhLbkJqMkNseDVO?=
 =?utf-8?B?SGZleGRoUHROUDhUS0xuMkttMGs5MTg4emxFNXhUcHVmaERaVW9KRngwM0xB?=
 =?utf-8?B?ZGExQUx2YkFWTjFiSEVkelM3SVU4RDhkaTA2dHJJdUdXZnN4ZGdlUktZUVBj?=
 =?utf-8?B?enR4QjZ5TkxhT0tkSVcxRlRZODRFaFF5cWhkemNhRk5acHlDU1NQU2VPNmxo?=
 =?utf-8?B?V0IrWmEzSXdhL2lmY3h5UU4yODVsL2Znb2srU0hCTmFlZWtPMzh5WTNycGw0?=
 =?utf-8?B?am1mMk1UMTR4TEQrSjM0a3Y1NnBGei9XWW0wSVlXaXZDZ1VSYnVlL0dDamly?=
 =?utf-8?B?YU14M1VIcWhZZTJCL29yVllyYnJYQm00c2dsaExGU05OY2tpaXJkZjVLV2I5?=
 =?utf-8?B?elp5Ylk1b0FGZ0VQOEsybXdqR0JOajVuNTRFT3VabGZVZjRBN3FGVVpRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01uVFAyNUVac0xnU2ZqS0ZzVXk4NG45dkU4VEtmbW5yL2FzZTZpaWhMbVNi?=
 =?utf-8?B?Y3YzWkhJS0ZaZTBNRG9JYjBJYnFTeG9QSHZmVFUxcDQ5ajJpaUI2SUN2Ynox?=
 =?utf-8?B?TlVmT1I0Njl5clVCNG1YYVFVSlBkSHBlczdZSmp5U2REODZoMmVYV29YMW9K?=
 =?utf-8?B?VDFqdmpRSzFERXhRQytFd3dLMnNtUDEwVmlEOEUzc2pyNWZhRmZVZWhQM1Nt?=
 =?utf-8?B?dlMrVHRGQ29qZVQzazVnMEkzQVc0eGxTM0hDK2JGSS9CQm5Hb3ZFb3lBMHZS?=
 =?utf-8?B?MSthaWZPVFNLS1ZLcFNRMUFhdGw3Z3lUSmpqWTdycjVTemJnNHkrWGVDZkRX?=
 =?utf-8?B?dDJqS1JPOHd5cmxreVdWTG1xcFVIVHc5endqQTg0SUJsRDFQOVRFK3lPcHJh?=
 =?utf-8?B?M2Eza092Z0NOYUcxdUF5TXdZRkRjbDZUOW9SUGdDamNxaG50emdtU1JxdEN5?=
 =?utf-8?B?QUo2UC9RQzVacVYxaFUwVUVwVVJwd0EwbE4wREsvRTlmQ0pQN3RDalZ6NFBx?=
 =?utf-8?B?Tks3TzkzTVM3ODd0TUtNbmFBZ0ZTdFdGK2pLVmVWNVlUb1RLVSs4Ulg4dnlT?=
 =?utf-8?B?RG04WWowZHl3OXVad3RQNGdIRDlDVnlqTjhQdDF5OVh5aVE5R1k5VFVXYjl3?=
 =?utf-8?B?K1I3dnpKbExmb3N0WWZrUkFSZk50bWlNa1ZNczQ1ODlVNnhMNmhxamU1bGox?=
 =?utf-8?B?bXY0TmM4UXVKQjlMSnJreDBzaTl5TkU1ZXVpWnhRVkpzV1J1QytHdW9Zem4y?=
 =?utf-8?B?ZU1zajF5REJuY1hrTkhFWWlDdEs0TnFONTNka1JvYUNZZTlINU9RNkIrOEo3?=
 =?utf-8?B?b2xISThYV3Jzc25GK09xZ1VUK2N0czNVNzd3d1hJdXhjeHlyNUQ5OEVKVUoy?=
 =?utf-8?B?WnZ0R3RtWHAvY0J5WmNFaGNGTHRUQzdwajMvcm5Kd3lRZFRSSUVUd3ltVHZw?=
 =?utf-8?B?ODRNTXFBUWl0dGROQ29ZdU0veERrbm5WYlRvam16VCs0OVd5UUV3aytZZW9n?=
 =?utf-8?B?VGxYT0hJSjA0NzM0OFdkOHdrcHliNjQ0bDVUZEVrOUhzQlBoZThzcXAydGZp?=
 =?utf-8?B?cHV1c2toUURwdnhxMG5SYjBvK1BuMkdpWm8rc2hMbzdEcmVNMjhhVzhaNXJa?=
 =?utf-8?B?djlsU1ZBakFVbGtOZGJ1OS9EWHdwVUlSMm1rY2d2QkhkTFQvT0FraEFpbzVC?=
 =?utf-8?B?TDNuSkpnU2hEY0djdWRyejdYMVJCZ1luV2VpTnVOZVdiTVk4Z1VhVFNYTVV2?=
 =?utf-8?B?aVdTdUdPZk1qa1U4RkIrNStQZE13N1A5UUhOVE12MEVycXlIMEhZellyQ01L?=
 =?utf-8?B?Wld2YlJQYW9aNmFDRVVPZGdodk4ya2VqU3RTNWxycy9GSTBXY0RDdUFxNnYr?=
 =?utf-8?B?TmYwbWRPMFZjeUFMYVFNZnlYYXZPMGUxbUF4bE9RcEgrTTJVeFd4OVFkSXBC?=
 =?utf-8?B?a2oyelc5ZS9ybnRPRDFHWlQ3T3lXRVlEc0tRbUxnWnFRUjVUWU4xWHR0NUpa?=
 =?utf-8?B?UEZwZlROcFBFVng5b2hOVnZiQzFISEVVTzJlYURScUlLS3pFRDYwWHZuNjZQ?=
 =?utf-8?B?YUtiR2tDcUtNVFdQL0ZNbWFpejZCSVpEOStBTnJma0NWOGtHK0JudkQraWNl?=
 =?utf-8?B?eFA0eU03TlFoRER5dmZwaHhab2dOZ095MDgyeC9LOGhZOFdaSnU4QTRCNU9p?=
 =?utf-8?B?YmRzZEdCNDVVNlNVc0JBUVhHWnN3MVVZeFlFY3Q3d3VBY1U3LzJjd0ZMZU5h?=
 =?utf-8?B?TmlMVnZVT2VDS3dNeXJ5eUJpM0tlbGNpK1N2TmgyM0ZEQ2hpQlVrbndkZjNB?=
 =?utf-8?B?bE9mSzlmM3ZTaVExUStJbHlXRkRIekpZTnZKMVJXNC9IMFAvWVRoVjBQdzhM?=
 =?utf-8?B?M2k0MjdHM2xYTUZRZ2Z4b3JEcjRVYzFPaXR3SHlheTBZNUc4am0rSjZTQk5q?=
 =?utf-8?B?S01GUmpPM3BiaXdKOVd1NG5xRTkvOWhJb3J1ODJVQXNqMmNWVUgvWlA5TlV1?=
 =?utf-8?B?RzNlTHJDYjIvNjIyWUs5dFF2RlRZQlFDeEFZc3B5OXo0NWY4NXFBUmhic1Rl?=
 =?utf-8?B?RXhVdWNXSkdLNDJ1ZkRBMXNvRm9pOHNyRys3T3IwbkU1NlZVRW0zOVdPcUlx?=
 =?utf-8?B?QzVCNE1nWndoc3doYzB2LzB1TU56MmZGY2d4TFBSck1lTlFncllLTzl1cWYr?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 50072649-6687-4772-0c5f-08dc75ae7326
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:45:29.8018 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvjWeG757+4tNkkBMh2wOJwobgpsfFQxMRKzpIjp1CQZWNNjnN7XoBYVjbz/agnLw6ez2NZ0hHbq7ddEjHuImBtkLdPag+C6+wOq3k5psqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8280
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

Hi Anand,

On 5/16/24 10:59 AM, Anand Moon wrote:
> Changes help enable CONFIG_DISPLAY_CPUINFO to build with SPL_BUILD for
> SoC RK356x and RK3588.
>  > Cc: Jagan Teki <jagan@edgeble.ai>
> Signed-off-by: Anand Moon <anand@edgeble.ai>
> ---
>   arch/arm/mach-rockchip/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
> index c07bdaee4c..6722e7c9ea 100644
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile
> @@ -25,7 +25,7 @@ obj-y += boot_mode.o
>   obj-$(CONFIG_ROCKCHIP_COMMON_BOARD) += board.o
>   endif
>   
> -ifeq ($(CONFIG_TPL_BUILD),)
> +ifeq ($(CONFIG_SPL_BUILD)$(CONFIG_TPL_BUILD),)

If I'm not mistaken, this is a way for disabling building cpu-info.o if 
either in TPL or SPL build mode (therefore only compiling for proper 
build mode).

I think it'd make more sense to convert CONFIG_DISPLAY_CPUINFO into 
three symbols, e.g. CONFIG_TPL_DISPLAY_CPUINFO, CONFIG_SPL_DISPLAY_INFO 
and then use

"""
obj-$(CONFIG_$(TPL_SPL_)DISPLAY_CPUINFO) += cpu-info.o
"""

Also... considering the mail I sent to your first patch in this patch 
series, if we migrate to using sysreset driver to print the reset 
reason, we wouldn't need this file anymore so we could remove it and not 
have to care about this.

Cheers,
Quentin
