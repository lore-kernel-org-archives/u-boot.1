Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA199C02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 15:45:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E56688036F;
	Fri, 17 Jan 2025 16:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cQKj/aqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B948069D; Fri, 17 Jan 2025 16:45:55 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A98DB80312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 16:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmNw15TJbRW+r9Od/sGFCz5HADZTmy8sOK7Eddw+fBjjxJtdnG375dIb5M/0+RHeomKuprBIdty+P25mDDnL4aJZNGhDkok6fpSXP1tfWx0HLQP7melM+F44XY5GQiGvfuc6MpFhWj9VbZwcZEomZWsbL++L5vW0ZtevxAGyoSVTsv2NIkGaKLVoetWPPSh6xPhm0n9tgfrmKnZIdDs96XfR1IvFML5/G63WaVNkbhggM7RVsVK9oxqD1XAFi+YqO75uzmthIIBL/nvqIvBumTBKrSwAWcG9Pe7qzuBmOHlZX4Onq2MlwbIy/8C9vcDmTQ/UZ0Sl9fGxFlw+0XswPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nNQKJezZC5ElYvfivS3azbU3Vq/sCGU8RLed2ydKhs=;
 b=kezN3amuasMf6GM8XSiwtpVWIwrLmwwGAmv8ee+gD6a9M8BnCXTyCXmHD7A/QfGYG9QFQ/sjtN4xPC+biiizFMRM4Uf89xWmrSaHEugP/2cL6NpuxLxC6s1ELj7V1uR4uDna52xsaIYSORyB6+ap00SxVrwOOjOPFBNxriocZCH0wStuGxAOhzVA/+ISb91zXGBqeAZgwsngv+gDSmhG/ey1mj8G5wgjhsEvS0UH7Gfy0wJCuOdm1uzIOjg91NPLxg/FM8cDAfnPYk7mWur14sz5wrUMG2ggt8ZVpdt0Y3INieHCL9d+NvKPVQ1oao+7Hz3ux6nPdh3pcN6sY1OrTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nNQKJezZC5ElYvfivS3azbU3Vq/sCGU8RLed2ydKhs=;
 b=cQKj/aqn2XUJVEax/ggDL6SiRlisddZCqkNIzFnPJlVS4BGwbzSfT8JV3xY3W9keWtD+ZDg8nSCNbvu3i97obs9I9wxJQSROnEr5ZgKqWuI8lKmfM3HNhUIMr6VPsseAmCEE0pqaoiXW6Twvi+pv2TYptgns9/Gz+tmF4rv2R5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB8570.eurprd04.prod.outlook.com (2603:10a6:20b:435::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 15:45:51 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Fri, 17 Jan 2025
 15:45:51 +0000
Message-ID: <e9dfc85b-ad9e-4c27-8509-0fce5648e7b1@cherry.de>
Date: Fri, 17 Jan 2025 16:45:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next RFC 0/5] rockchip: panic() when DRAM init fails
To: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>
References: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241105-rk3399-dram-init-v1-0-1e29acdf0966@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0029.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::22) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB8570:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d6ab2b-c8c4-4d9e-245a-08dd370e054d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZnRYbFk2b2xpTklaWk1sS2VNSjZQMGg5UEdqN0hCMS8xRWtTZDZodHJUeCt6?=
 =?utf-8?B?VVNPL04yZFhITzBLRGpZcmxXck9ETjlsdDdhWDlsQkNtUGFiL0tDWFAvOXhm?=
 =?utf-8?B?MjF2cEZ3TG1NTUxEeUx6NGJPd3k4VndkK3hXSVgvdDBjTWZWeStMNENhLzIz?=
 =?utf-8?B?dFRISS9VTkI2YktHS1FoOVVGdjVDSUR5MDExOEI5NkN6UFl3Yjk0MGFOMUNE?=
 =?utf-8?B?VWY1NUlSR3g1NVNDSzJia0hRbmV5ZDhvS284MnJyMVREUlpTZlJ0YW5EL2hr?=
 =?utf-8?B?UW14QU9jdDhwN0wrV05YeTA2RkhkUk5qdUROWStRQ2VLdXBDYUlUMEUycWhk?=
 =?utf-8?B?VkREUnhVZ21Td2ZaaGdnUzk0aWJKVFlqSkFVVi9BTStzZmZrWmNEZlhEd3JD?=
 =?utf-8?B?MzBhYTliYW4wdmhLcElWNTIwa2lGL3JwY2lnaWNSbGNmcnRxOHFkYnNHaDJK?=
 =?utf-8?B?VWJDeHZWOVlTYlhNWkE4cDF0dEFaMyswd3V4RGVrd29UL1BxMk5mQVZlbW10?=
 =?utf-8?B?am9RMjlwRGJYOXZncS82cEJsWk84RnJhZkt6RWZlNFZ5NnN3S2I3NDhEK3Vt?=
 =?utf-8?B?UFhKZHZhT1dEOXhBOUg0VEtEL1RQU0xIOENENWNkMm81QWZkaXd4c0hGYk9V?=
 =?utf-8?B?amZQUzZTamRlcDNFR2x0dDJtZjFLNk1NOEp5cWVScFA4SVY4RHZiR1Y2K1p5?=
 =?utf-8?B?QWlZV29BMEJKdm1KZWQ5YTM0dVU4T3BmQ3pkZjk2TDV6NkNqamNickJJSlhR?=
 =?utf-8?B?czBQNlZVWjlwMWZHeHR1bkRBTzZ6RnJPYitjLzQ0QU1rM1pJclFkR3oyTzdt?=
 =?utf-8?B?Q0ZJVm5zTGI3cXN3TmMvOGN3bGpaaFppRHVjNnN0dGJvWnUvSXpodG55dzRh?=
 =?utf-8?B?TUpuQ05HVlY0aHA5bEZvcWZ3NEpVZnRydnRrL0xiL1ZnemhkNzhmb1lOVUZZ?=
 =?utf-8?B?SkQ2SWNJdXFhbCtiNkV4Tm9PNDFHU3N0aDFDMDB3VklFWGUydzlqSzhvZFF6?=
 =?utf-8?B?WkJGOVZBYTFZQjgrYm03b2U5aU52M3o3RjJkWnY5S3B4b1lhaTZ5SDFKd0FZ?=
 =?utf-8?B?UDB4UWpmV1BQMVJ2aXpLeUNpQy84TFdtdkRLN0lnemJxcjlqb3NQak1xOGlo?=
 =?utf-8?B?U0ovTlVyK2tHanNxTFE1TjNkYnFwOTdGRFcwNVpEdmE2dXBsT2VQSUVFZ2lm?=
 =?utf-8?B?L3dtUGtlYnExRndsQk5SQ3BBZGprR3pRc3M2ak5Ta0JCUkpaeWJLenVxWnIx?=
 =?utf-8?B?cm5KZ1RrdEZTOWN4bXQwbzNqakhVZVB4NVJJUndRUUtMTkVVOGF6RE8vSGVN?=
 =?utf-8?B?bHkwTW9DSTVBMWF5b3hlVmZwbXlEdGQvemNnUE43YlVyc01lWTd2T0hwTHhm?=
 =?utf-8?B?enRnTlpSZE50VzFWQnpwZnN4M213cUJHUUpCWElGbVdkbkFRQ1JxZjR6Zml0?=
 =?utf-8?B?d1pMOS9Fbk9Mcnk2R2hFcXF4WmhpZFFxazNlWVd2VEY5UzV2K1Q5QVExZlJs?=
 =?utf-8?B?VFMzUkhSbXNldnJDMm1FOXM1S1duUU0zdDFQaHBMWlpNdGRKV1ZaTGk4Rlls?=
 =?utf-8?B?SW96N1l2U0V2NHJmenFuTjEzMnAwVFRlTFNZdWRLR3hLczJJWS9HcDdad0d3?=
 =?utf-8?B?VkhpSElyWHlPK0xzdm1DZEk4RHNPL0VjNXpFNE5BQWh2bFRBWGdGUW9idElk?=
 =?utf-8?B?MkY5aTVhelk0UktVUngrMWJDeUNKZWpGdEVpQzRVckkxbHhDekNlcE0yMURh?=
 =?utf-8?B?YTZwWWVUMTVwTXRiSWRtWDhTNTRvRlJmcEFMSmpMcUpaRDVuR1FOSjlnZUk2?=
 =?utf-8?B?Z3RzRTRUanErb3d4djVzK2w3dHhpYnJrZ3p5TS9qN0JObU9QNE1zbUtFWU5o?=
 =?utf-8?Q?Aj6xi+g84eMQf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBONU1Kc0hTc09abHRmck41L1NXbXhHT2EzUnRMZUpVdDY3WWRMaFRPRDdZ?=
 =?utf-8?B?VFhEWW1XL29vUUlQbGdOQlMrc0NYbHluTitKMUZGVlZSNDdYeXdiaTVPL3Jl?=
 =?utf-8?B?TGl6OUh2SVNsUE9QM0ZNMVpTU3d4T3A1czFlQXVETHFQT21QYXVOL0pSbTJq?=
 =?utf-8?B?SkV5VWluVzgvQ05ubmxJRUg3eWdlWnhDVFRtNS9BdGxiQ0RNS0VXcWRWTUxS?=
 =?utf-8?B?UzBRU2wxTis2UHJtNTZLNFg1OUd1bFM1TFl0WFV5MFhIenhHTTVBbFJhMkxl?=
 =?utf-8?B?cUMzaW1xcDBDYjNYTlF3S2x1NU1OcjBEQm1zQjhkM0xPQVNpa2pxTFFRQWsv?=
 =?utf-8?B?YVRnR1BFQW4wY3hxVDlSc1Z6VXlSeVNPcHZ4Q0hpd25MQyt1TVd3UXRtSXI3?=
 =?utf-8?B?YUJ3UDMzZDJlRDFjUXZCZVdoWDdURkVPeHFqSnJVaDhQeEUvWUxHYkhESGEv?=
 =?utf-8?B?N01udnBjRytFVmNZa1R5aG5RdkU4bWcxTzhobEwzbnhldnR3WWxNUWJacStM?=
 =?utf-8?B?alZTdUE1QlF2cHRueFhTSFRnVzhpL21PKzNXZ3Z1cDlTeGRkS3NVdGJkZmRK?=
 =?utf-8?B?eCsxcm8wazhRZVlDWEFveVlPZisvSVE2VVBYbFRkVjhPUXFQWTVmZmNYKyt5?=
 =?utf-8?B?eUtFWU4wRkR1NlZiRWdRNitQWEFoUGxSM0ZSSE8wRll3Snc0Vy8yMlRGREhC?=
 =?utf-8?B?S29rbkhVYlFhRCtZampVdVNpN3hKbjduWExIMUx5U3hjUjZWTS9ManhELzk4?=
 =?utf-8?B?anVZb0ZTZ0JqRGxUalk4MmQrU0tOeU41bU1JWHhPTXNuWDYvelBZYVVaTlZB?=
 =?utf-8?B?bHVtM2lqU1FtNnNIbVRoMzNWVFBzU2lKcHp1cmlOYnYvWVNrN1Z1UUpTMlhH?=
 =?utf-8?B?dWtwRVlPRjIrbEVQQ3ZhY0ttbzJTR3d6dGwxNUgzc2wzcW13ZHg0VEFFMGlX?=
 =?utf-8?B?QzI2emYwUCtwaU0rRzB2ald5WDNld3V3MUh4YkptVHp5VUZtUmJxaGplNVFV?=
 =?utf-8?B?OTdOZ1J0eFlXbkl6N3NZQk1WUW9aVWllTUo0aHhXcktlZGpRK0w4blEzUWg4?=
 =?utf-8?B?aTJFcnNSQTYxaGVlTWYrT2tiS3A4VG8xZ3gxTjRLMnpOVVhkNFVxQTljMWtP?=
 =?utf-8?B?NnZmZStndjU1U2JhOFJsdHRVQzNLOVlEWnYra2pOczVxbnNyZlFrTEFTeEVM?=
 =?utf-8?B?KzE0Ulg2S2VGTHJmaExlWEpHbGsxcVYzRTBaZ21nd01lQjczLzF6czRlanB6?=
 =?utf-8?B?UzBSTHFZc21KT0lXOHhWbGF0eHU0NUxVcXFQVVQwRDNFTy81aWtnL2piNERF?=
 =?utf-8?B?S1V2SHljUUN4eXd3Z0lzdjlJL2RES0FkRHp4dE84V2haZEIrNWwyczV4eVNl?=
 =?utf-8?B?U2tMRC9Ib1d1dGpKZmRuUFg1M0pxZGRsandFamdFcFN6dSs0dHdkMEtMWFRp?=
 =?utf-8?B?bDJkVGRVUFF6cHdrOWhQVWdYKytMbjdmTTJIY2E1OXVKNmVZaUpXSDU3RllU?=
 =?utf-8?B?dVVPMmN1ckd2L0IxajBENXYrOTkwSjQwTFdjWHUyZUJlcE1NOHczV21kcFk0?=
 =?utf-8?B?Q0hiaWNKaWs5MnI1VXlHT2pUSExsR2pKNy9YdTFsQktwQVVROE9zM3hnVVVo?=
 =?utf-8?B?QXp3Z0tLWVRCRCs0NWVHUzFFMnhNNEp1TlRZcmRxOGo0eG11eDZKbzgwMzR3?=
 =?utf-8?B?eTl0ZXh1QlRUcklHOFA5eXI4RUpQdHJPaHJ5cE1JNi8rTm12TFlhdWgxcDVX?=
 =?utf-8?B?K3B2R3JqbXdLZVVBd1Y1UXZXQUNoR2JoU3hwTnVFKzV2ajZrTWo5WVA4OHpR?=
 =?utf-8?B?UzQyZVhoMmFkYjJzdHdPaHVQZFB1amN5UVk3c0l5cVdTcFdDc2NneVpqU2tX?=
 =?utf-8?B?Q05Ka1p6RFJNRDZhQ3Fqd2xNcWJURzFBK1Y5NlVXaFpLU1JKVDJhM2tWM3Rh?=
 =?utf-8?B?Zi8rcUlaWDRUWm00OXUzUDE4OGVCMVZHdU1hazBLd01qcDJ6SkZOMmQyVWY0?=
 =?utf-8?B?bGYzaTNOc1p0WjRPanc4dFBYbXZHQWoyQkhVUUk5MHl0dGhha2Vja0RiSXJx?=
 =?utf-8?B?TGpiTUVUVU8vSDYvQTVabHhTNkViSWRvWE42MThRaU5IZ1pUb2RXanl4WHBO?=
 =?utf-8?B?cTZ4SVBENERoSk9lc0tnUURpMjVIMjIydkdSVjdyZUR2R3FMd0ViUjNiTkRJ?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d6ab2b-c8c4-4d9e-245a-08dd370e054d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 15:45:51.6037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ex+CJLaaQt8A16o616vkgCEteIeLOIKYRcfS7Kb2kAkbQYok53stV6Y/5cuesVJdmmKVRaim8XG/hWDkYovyjhif4cw2Rzoyr9jXEDH+joc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8570
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

Hi Kever,

On 11/5/24 6:21 PM, Quentin Schulz wrote:
> I am the unfortunate owner of an RK3399 Puma that is failing DRAM init
> every now and then with the following cryptic error message:
> """
> pctl_start: Failed to init pctl channel 0
> """
> 
> When it fails, the current logic is implemented in such a way that the
> board enters an infinite while loop. This is not ideal for embedded
> systems that are not easily accessible and also an issue when having
> devices in a CI lab for example.
> 
> Therefore, let's simply panic if the DRAM fails to init. This was tested
> only on RK3399 Puma, similar changes may be required for other SoCs to
> properly propagate the errors.
> 
> While this is all but a work-around instead of fixing the DRAM init
> sequence, I believe it is important for resilience of devices in the
> field.
> 
> Marking this as RFC because:
> 1) panic()s for all Rockchip SoCs but only tested on RK3399
> 2) unsure about error return values (ENODEV and the likes), not sure
>     what would be better than that though :/
> 
> Note that one can still hang() if they want by setting PANIC_HANG
> symbol.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

What should we do with those patches?

Additionally, is there something I could do to help fix the DDR init on 
RK3399? Increasing the timeout didn't help sadly :/

Cheers,
Quentin
