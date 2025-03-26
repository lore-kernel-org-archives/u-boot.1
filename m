Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D8AC3600E
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 09:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BCB680756;
	Wed, 26 Mar 2025 10:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="i/q/BxtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2B6808B6; Wed, 26 Mar 2025 10:22:41 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6176B8070C
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNQhRWH3Ikzd+Jr5spKSdfiq8tqaRdq1RQuvIPz6sFUIRYRjYtJjohYAgWHKIhSG7ar1c0UbhWanmgTPsz+PE+9vn5zBQcszCM7sbKRseLu2mQADtwTHlANBGnhaq8D3YOCAZw0NpWHXhgnNm1qLZaAeumDRYubkQVovyJ1ALdVmkdx0GH7Rx7vccnexCWG/FMgw5lqpnvvVgxOVLtVPEleRTpxIFCovPT4ONHWJ+eh106SQmzE0YD3XOXvv/VLoaNHOkaoGVLbtAHZygPw11dmw5vPvNshymzX92WvoUNCcDYV46CK93o7imqlhF3NLHWdrEoARHHMfvf59RhM+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtAob+wjz+jK8AaSx9xW6geNwN5BKlQOhveb5nYUZ4s=;
 b=C+khNR5W48Lnz/IQ8l7DVvVTJcNlxK3twIlUFVOS87r/Kf/eNv+SCgwDqNh5TyYg3ItVI3KDiTlKCgAcvvlC88Th7LEK5D/UL8HUn3UI4ACh8/Lojo0Vyi7EEtJH/O/QSb/Ss/il0PsPSYBjXCIrzhMP9IOogRllz64skeV0fy3GCkYGGwgJ+ic+4YYV1S9xsJWXfj26zurZVwDeX8kkiZzV55726QvvWTa4t0ygWsMn295r7EA+paHrxq6QpHiNo6P9m3OOSXeDNVspZiAARBiFvlQZWCKGAa64/HqdNGPymBLp0DTL6m1C3d8jjygw9UByR8jOlW1psDY4uMRaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtAob+wjz+jK8AaSx9xW6geNwN5BKlQOhveb5nYUZ4s=;
 b=i/q/BxtLLY6vIFjyIYgLXZ9WSb5MaPy0vIvrfNLpH3AwCgXKz7yKAqz/Yr2RXyLlH8URUaE71QpjXnwTkTaafBRrrObvRmM2vhN3pohczO+z3DF+I5073lWIv71cmnYNChDCVQ+aBs6NEpYXb+VFrIFj20kXeFHY8FUwEKfQaIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8375.eurprd04.prod.outlook.com (2603:10a6:102:1be::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 09:22:35 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 09:22:35 +0000
Message-ID: <d9382933-70f2-4c3c-abf2-4fd711fbfc4f@cherry.de>
Date: Wed, 26 Mar 2025 10:22:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] env: Rename SYS_MMC_ENV_DEV to ENV_SDMMC_DEVICE_INDEX
To: Marek Vasut <marek.vasut@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>
References: <20250322215624.18994-1-marek.vasut+renesas@mailbox.org>
 <20250322215624.18994-4-marek.vasut+renesas@mailbox.org>
 <90254a96-5d67-4d34-afe6-772af42ee557@cherry.de>
 <e385568e-59b1-4adf-9fb7-d87b4254eae9@mailbox.org>
 <20250326001521.GN93000@bill-the-cat>
 <d576535e-f8d0-4ae7-b8b7-f4316535a6ee@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d576535e-f8d0-4ae7-b8b7-f4316535a6ee@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 17569a74-8269-45d8-a604-08dd6c47be32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm95WUZ5VUdiZXBjT0NZcHVQUFZXWiszYXdnUEFkeVpuUVhoWCtXa1dmUzFh?=
 =?utf-8?B?NkNpeFByYWhranJlTFdMWGhCRHpCL1JNSHY0dlAwTnVuUkxUYmdYbEppcDRC?=
 =?utf-8?B?d3BEZHF5bFNlVG9WbXZoYWdzNU1YNyszVnhRd3VwbjlqUTNZK0wwNURiZnZY?=
 =?utf-8?B?anU1aE9uajlWMmhWUkgwbTF3R0FndjhIeGxINjhuK0NxNk5UY2ZqQ1UyK3BK?=
 =?utf-8?B?MEw5cXY4RzVvSGFraUJvZmVpQUZPdnlJT0lEWkRqVktFL0Z0Q1RmSGRWM2Ft?=
 =?utf-8?B?eGo5Z25ZT3cxRTRmTExXV2krei9sR2N5SHJacHB2VFpKcFBRNE5YRElTZ1Fj?=
 =?utf-8?B?Q2V2ejRoU0Y1cEVhU1d5TTkzVUhSRUZDQzZwNGZjenU0SnhGVGFpT1B1NzBG?=
 =?utf-8?B?d09vRlRRTnpHSkJESlBpZ2g2VEVRYW8yWTFtRmlvWDNEU2NjdC8wQitGRDg4?=
 =?utf-8?B?bXowekVBeUJlRjFOSy9GRUlmV3kxQ0dJQ21mNENUQStOakdBRlhKWGpwcTYz?=
 =?utf-8?B?R3NIQ0J0WHVvbFIxOW1ydE9DdC9IOEJIQ29YUTBRT0dvbkhVTTNmeE0xN2Vi?=
 =?utf-8?B?T1VyVUpQYkRwN1JiUE9QeFRIdWkxU09TTXRGbWcya3k1cEFqWGwzUXAzNkJ0?=
 =?utf-8?B?TnBPR1BZaDFvbjBtZVo4OW1iSzNBOVZvYUN3bk9iUFpyK2VhTFpTVGszcDBx?=
 =?utf-8?B?TUE5S1ErTElzTlpjcGw1VnRFZ3FwK0lZQXRjWldYcW1SbW1QaUIrZ1VtblNk?=
 =?utf-8?B?KzcvNlNiY2hlNElaa3ordG9NblJMOHIzdG5pQkFMMlIvVXpmT3F3MTZ3ZFJH?=
 =?utf-8?B?eHY0eEJPL0t2Tktkc3hVY3IzRzVNY0JZR3VXWVAyYWxyQUg4cWtBZXNhREhL?=
 =?utf-8?B?TUZhQStIeGt3MWxJa3k3TlRxdVYrTG5pN0drbzNHaVRvY0ZqeHNmTmFGUG5Y?=
 =?utf-8?B?SFpwTEhXZDdOSGVSTEhFbE5weXZBc05IKzJyRzVvRUxBQTNIVUhRVFJNN1pa?=
 =?utf-8?B?cmRwa2liblU4ZFkyZXpzWmhyMkt3eTJ1TGwzajNPeEdjTHFHZEpZSlR1bTJG?=
 =?utf-8?B?UDBPRko1eHJhQU10dFBlYUtqVmU3OUZaN1ZGeWJGTG1Gb0NNZ3M4enpobWYz?=
 =?utf-8?B?UWN1Nzljb2ZtTll0TlhNWjVabktxcW8wUFdHMzVHbjM4N2ZtZjRFQ1IyRGVC?=
 =?utf-8?B?QW9TQ0R2dG1zZmtWYzlyVTFGeHAraE05VHdzWkI4NGQ0Rm1OWkozZFJIOVM1?=
 =?utf-8?B?NVJLSlJ5bW9BU29ub1VaeXlUR1dBU3lEZFhXRzNrNU5ORWJocVJrdVRyYjJG?=
 =?utf-8?B?bVRYTHJYM2h1T0xVaHBqeEpwakZhU2Y1cU5yMVA1M1ZZdmZhcmFSWWpUS0s3?=
 =?utf-8?B?bzN3NnZ1U0hYa0RnVEk5N01Oa0pjdHV0d3hhOTE0YVI0bGNiYlhuUUJLZXN5?=
 =?utf-8?B?d3VFK1JiQ05qM0h3d1VRT2hkQzhOdmZRWG1PeWIwWXdPZnZnQ2cySUgrM2JH?=
 =?utf-8?B?c3YwRlY3aDdYRWdMT290UzYxUUpIckFIb09aVVE2aDZRVElmbHNOOGNkc1JJ?=
 =?utf-8?B?Y2FvT3NmYXJlS3E4bkFLR1AxNHpybkdUZUxOcTRLUVVhekVWbjJpQnZQd2ZH?=
 =?utf-8?B?Z2VWZGt2MTA1R0lYY2VTaGMrT0ZlTlFvOEFQeVUxZm9VRmZVMGVoN21lU1l1?=
 =?utf-8?B?c0lycGNhMG1SK3RiU0lmdzFBMFJNUnh5RWJSN2tOR0lhNzdkTFl5OTZSVzdN?=
 =?utf-8?B?UXZ1QWZMaS9VUlplUHNXMVEwcmdqOFpNTXRFajFtdnFaS1Mva0ZLYURqWHJB?=
 =?utf-8?Q?eg3JgVX5H5KzfENGhgBzAIckT22PUARh7Fu0M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmZmb24wQTRZUVZBZXlxdnR0RUpGdkxFWTVYOVRGV21WS2lpdGRMN1dzZ3NB?=
 =?utf-8?B?dVVEK2lWSHFvLzVKeGFUTDF1VjdTb3ZkejBYaldleG9xV1dzL21HSG1oYlNm?=
 =?utf-8?B?TUVxVERSdkdZNjFwN0lsSDgzMmErMWpoNHlsYitLTmQwMWhnQzVYdFIwOElr?=
 =?utf-8?B?ZmFwVmhCS2Z3bC8zYWxBZWVleTdsQWhwTm9XSkxjS25ZdGsySFphTFptbmhI?=
 =?utf-8?B?THVxR29IYjRsWlFkdVFXMFA4bXhpb1BtR2dvZmdmd3A4emhQNEhUL2ZHRkxs?=
 =?utf-8?B?UjN1QnVFd0ZxMkhaQ3VESnZVcDVhcGtOdDlvM1FYb0VFeUk3QjNaZGJZK3c3?=
 =?utf-8?B?NEdlL0VucmF1L0Q0VkhyYytFaGoxeUJIWCtSN0FDQk1Jclc5ZlBiWTBJRUY5?=
 =?utf-8?B?akhlbnRNRWlHc1lxYlRNM1pRS1VTUFZmTkZBMkFkWDlPYnVXOWJLZUtiSVFl?=
 =?utf-8?B?dG1SanBab29PdTFnSW9KZXRXL1JLb2lkWFFJc25BcjJLMkQ0WnI2c2ZHbzZS?=
 =?utf-8?B?TE5HV3FBTUN3WG5kRjVqeHVaRUdLY3Z1UUpaQ0NtYkxZK0hEMUVVYUl6MXJH?=
 =?utf-8?B?WDJ0eVR2K3AyM0NCOGJTZVpEeUhwWHg0WFFiaVNFSVZRelpBdWVFVHlaVTV6?=
 =?utf-8?B?MU5JU20xc3ozMTJRMG5DVmk0M0U0M2xRS25FVERBS21GYjNjbkRna1EzdGhr?=
 =?utf-8?B?V0pTSnZsK2ltZHRMVmt2RGZvSU96dm1wVmhOKy92NEMrSG0yMzliS1hLL0dN?=
 =?utf-8?B?em5ucVIreHBVcGhVeWNDWVc1RktOYm1JakpCNjJReGd2ckh3Uk9Manp4YWVQ?=
 =?utf-8?B?NCtaazVpR3NsME12WGttdXk3V3dsVDFwbGd5WjdoSmE4aGVnZERRd0RicWRY?=
 =?utf-8?B?cDF3dThzd2VpN1NOelRjRVlwYU1tajRqOUtLaWk0VEFvRE55V3E0aTdPcElG?=
 =?utf-8?B?dXNnR0pjZFZ2YVZ6VVYrMlFHL0UrdWZVdG5YV09ZNE1aMkViamhPTWtDdGFu?=
 =?utf-8?B?VE0yQWMzZ0svSGdoNFZJQ05YejdrcW1mQXBFN0k5aDhob1FnRlJ2R3ZQQWhQ?=
 =?utf-8?B?ZitQUGV4YXpibXBFYW5UcjdLUE55bnVPWUVvdHpwdDRrU2Q5NWRTcjc4c1VK?=
 =?utf-8?B?WWF2OXFQTVJ3eVdCU3hsSDFaS0lOZnNrMFNBaWNyVzJicXRKMUtpYVFraDRz?=
 =?utf-8?B?bEQ1R2QyTENuRHhCZCtoM0N2QXVLZXlSNnRXQnJ4bHV1UUNpRloySXc0UFJr?=
 =?utf-8?B?VnQyenpVRU5GdC90SlVreExHa2paQU80MVpvT2FaNkRzM2U2WUVZYmhXN3Jl?=
 =?utf-8?B?bGN4blp2dENnUmVPaUd2eTdsTFBDYXNadmRYdExHODZBOW9YMkZ5b0poR0RS?=
 =?utf-8?B?SDk1dmR6SHFQZW5kcjY3UUd3NGNISk5QYVc4YVhvSlFuMXRsaFhFVnRub1k3?=
 =?utf-8?B?aEtqNGdvNERzRUFNK3RrZ0xueXlxcHJFSlYyY0p2cHpKcVh5d3B4cTY5bUNV?=
 =?utf-8?B?cENMa3VYVjNiMjJFMmladWVjNklGT3A0OE9HM2Z4WmszZGlER1hqQVpFTG5L?=
 =?utf-8?B?WTE0Um80WEdTTys4ZTlkaC83ZldqOWwwdVFOZ2N2TlNnc0lYb3ZjbFp1QXF5?=
 =?utf-8?B?d0xKMmlMd09JbXB4anVVZXplTjdzeFFGVEtPY1lZYmxzVXRpdG1lZGJDZy9v?=
 =?utf-8?B?d1QvU1BqUE9sVDBJOHNaeC84RTFZWWVsT3R0SDlnekZpWWdnczAvV1lBeE0y?=
 =?utf-8?B?clA2ZC9mMXRBUTNtRTZpSHh4OVRCTmRaNWFteDNFQ24yUnpOeFRETlV6clo5?=
 =?utf-8?B?ZWs0eHFZNlltc3Z4a1hnSk5pQTNJY2RPTmFpZUJIK2hnRXN5NGlyL2J0Q2dD?=
 =?utf-8?B?S1lFTEQ3M01ZOEZwbWlvUEUwTllIOHBuNXQ4bU5ucmx2WVBHZGxmUnhRRlZx?=
 =?utf-8?B?Rk0wTGJQWUhCRnN2SFczcitCWjZGelFhOUE0RUJOck1TcHY3bGo3Q0tXdVd5?=
 =?utf-8?B?NnpiK3hXNkxoOHI1aTRhTzhpRkI3bUlRU1ltSG9vR29xeFl2WDU1Zk8xNTcr?=
 =?utf-8?B?L0hWK2lIc2xYM1B6MVNQMUhqME5WcXpuYmxJOTJLTGFFMlp0M3pveXB3OWwr?=
 =?utf-8?B?UUhtVjE1cTF5cW1Ub0JpeTFubU1DSGZFdFhjdWRmaEdmclkreTFHMlMzR2Rq?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17569a74-8269-45d8-a604-08dd6c47be32
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 09:22:34.7584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QQ5AO9qlN1OIvXP/SCZlJD5zGv/YJCx6S9a3Wbpw/zOxYdBycBV7ZGcZ5EUXlVYj6mCLUBhVnQ16Kq0hZsaD/kZYquZODPitrOMwAh3W1Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8375
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

Hi Marek,

On 3/26/25 2:37 AM, Marek Vasut wrote:
> On 3/26/25 1:15 AM, Tom Rini wrote:
>> On Wed, Mar 26, 2025 at 12:02:08AM +0100, Marek Vasut wrote:
>>> On 3/24/25 1:39 PM, Quentin Schulz wrote:
>>>> Hi Marek,
>>>
>>> Hi,
>>>
>>>> On 3/22/25 10:55 PM, Marek Vasut wrote:
>>>>> Rename the variable and add ENV_ prefix, so that all configuration
>>>>> options which are related to environment would have an CONFIG_ENV_
>>>>> prefix. No functional change.
>>>>>
>>>>> Use ENV_SDMMC_DEVICE_INDEX to clarify this is the SD/MMC device
>>>>> index, a number, as enumerated by U-Boot. Update the help text
>>>>> accordingly.
>>>>>
>>>>
>>>> I disagree with this part of the rename (MMC->SDMMC), our drivers all
>>>> are using mmc (env/mmc.*, drivers/mmc/*, cmd/mmc.c, ...) for both SD 
>>>> and
>>>> MMC. We also have ENV_IS_IN_MMC which is for both. I don't think it's
>>>> worth the confusion.
>>>
>>> My main problem is, that it is confusing to call everything _mmc_ 
>>> even if
>>> most of it also applies to SD . There is no way to discern parts 
>>> which are
>>> MMC specific from parts which are common to SD and MMC now.
>>
>> Do we have support for anything using the MMC part of the standard that
>> is not storage? I certainly agree it's confusingly named atm, but I
>> think changing some parts but not other parts will make it worse, not
>> better.
> That's not what I am concerned about. What I am concerned about is that 
> we are talking about partitions, and only eMMC supports HW partitions, 
> but both SD and MMC support SW partitions . So we should refer to 
> CONFIG_..._SDMMC_..._SW_PARTITION here when talking about SW 
> partitions , but CONFIG_..._MMC_..._HW_PARTITION when talking about eMMC 
> HW partitions. Currently we are missing the two and it yields a horrid 
> confusion. That is in fact what prompted this series.

But the controllers handling SD cards or eMMC are both called mmc in 
device tree and in U-Boot (see mmc command). So for me, MMC covers both. 
As a matter of fact, the mmc command also handles the boot partition 
that is specific to eMMC.

Quite interestingly, the MMC (MultiMediaCard) Wikipedia page starts with

"Not to be confused with SD card or eMMC" and then the first sentence in 
the history section is "The latest version of the eMMC standard", c.f. 
https://en.wikipedia.org/wiki/MultiMediaCard

So essentially, I'm wondering:
- if boot partitions are specific to eMMC and not simpy MMC (and are not 
part of SD card). I know eMMC has a separate standard than MMC.
- if there are other things than eMMC (and SD cards) that are supported 
by the MMC subsystem (outside of the embedded world). It seems like this 
is taking the MMC = eMMC shortcut that I'm not sure is correct?

To add to the confusion, Rockchip often has MMC controllers named SDMMC 
(and their use varies depending on the SoC, sometimes for SD, sometimes 
for eMMC, sometimes for SDIO).

Cheers,
Quentin
