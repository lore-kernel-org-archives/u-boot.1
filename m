Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B803C3DA47
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 09:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEF1A88763;
	Thu, 11 Jul 2024 11:02:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ldlw5iPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 646A28879C; Thu, 11 Jul 2024 11:02:47 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 348E186DBD
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 11:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hdqc8NnfBNFocmlMBI7ngn4SFdVjMT65b7MWF2KaAABZAc0nYHfZRQoj9CxEwW/GrSIxZOM+OirmXWyd9UJESafqLkP66R7mQgDpBurW0S/SSsGAUkYvwKLho2gFMaGlvjW2vYPSV4vroJjrFOjSpG4KvSe++vRrVDMrhAZy64PHptIi4YMR6/FZtgElSgbc6G2AQJyD9AZX10qJPyX2FVAjz262c5a1tLk3Qm1S0ZUEg23lPHFq74JbLNTTnbyuUXaXBq2QoK7mmz8hsI25U79rOYxd6fiUI+nB+dIoqXTE7Oig1Eq8F8iHTqq/IbdJ+10HUCJhwolftNFHl7GQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPV5gLlKTXx9QUmWqbk+HCxR+xwVhvTh/szcRlzT+Cc=;
 b=W/XQnliBHfpz1Eqfr8yc5oFtgu/m2k61i4IUzeTVcx2EGXM5VIZhliNohe2ENP1aOF8twB9fnxHIjZ4SbK9fWjGHRIIwPilhW/i2Dy3Q3etneA38E3qn3qMjkTCaZXzAl5X3EwF083dpyA3/ZKRA2PQcRKdc4z0emwlfAM/N16JQ8+zJtzMPcQVmNUWujZNy5BpoyQMIJD0X/uXiI9cXyr1FirV3RGXZQnflcjdZnEUtJpFTVU5BxtuuevHhwt5s+a/VH7iq4VOSYebs/5DGc8LnjEJOujQ49v/lZkLddb8tEcv7JbaiAWTvcYyQg0Wdb1BtSaW07GDbWtsVvrpMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPV5gLlKTXx9QUmWqbk+HCxR+xwVhvTh/szcRlzT+Cc=;
 b=Ldlw5iPUmTelcrUWcW2BH85ViZ8edvutPxjcMP5p8S0p08fSjtkICrYONkULIK4+jrx3plntNF6KAi/iCGKVSTIKtZFPbQm1iOIObc0YLlyYCTHaQLfgm0+Tl07ptU2ixkyVJxQQe/9iRDJ4oe2e5Q4hnPZWtiIrPTR/vpYN2VE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PAXPR04MB8912.eurprd04.prod.outlook.com (2603:10a6:102:20f::22)
 by GVXPR04MB9849.eurprd04.prod.outlook.com (2603:10a6:150:112::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 09:02:40 +0000
Received: from PAXPR04MB8912.eurprd04.prod.outlook.com
 ([fe80::7a71:bd84:cbb9:add8]) by PAXPR04MB8912.eurprd04.prod.outlook.com
 ([fe80::7a71:bd84:cbb9:add8%4]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 09:02:40 +0000
Message-ID: <1e514f7b-cd6f-4403-b1f6-50e7c60316f5@cherry.de>
Date: Thu, 11 Jul 2024 11:02:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] fdtgrep: Allow propagating properties up to
 supernodes
To: Manorit Chawdhry <m-chawdhry@ti.com>, Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
References: <20231217163627.2339802-1-sjg@chromium.org>
 <20231217163627.2339802-10-sjg@chromium.org>
 <20240710061528.4afx6lcsdsbookug@uda0497581>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240710061528.4afx6lcsdsbookug@uda0497581>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::12) To PAXPR04MB8912.eurprd04.prod.outlook.com
 (2603:10a6:102:20f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8912:EE_|GVXPR04MB9849:EE_
X-MS-Office365-Filtering-Correlation-Id: f74907d0-7345-4851-3cc6-08dca1883793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjVWQk0veVpZS2ZPUUFsY2RoRExGVHdyZ3NYTnc2bkRzak5veitkQ2pTN2w4?=
 =?utf-8?B?Wno4bVZFaTdSaDY1WExidDE2QjVaNUFPbXd0ZkVweGJaQ25FRVhjL0dRQWtj?=
 =?utf-8?B?ZTRCeUJUK0ZwTTM2QlBodmpUamhsYnI5bkVxcEoyc1hRcGxGR0hzV1RsV2xn?=
 =?utf-8?B?cXRXcHVtbWtmV3JYMS9weE56OGNTVXd6VEFZUE1KMXlaK3d2TkpKV1FUQzNj?=
 =?utf-8?B?ZzIzVjdGYS9aUHBreWhGVWZNQkJTY1BPZEx2K0dqTlA3WGovL0lGRlhGbHo0?=
 =?utf-8?B?Z2drV1JkWFk0aWt0QWZnK2d3ditOR2RzYTF1NkdzNzFqNnRvVzZyRmhTVGFk?=
 =?utf-8?B?R08yL282eVhwOHhQVU1aQWpXSXdqcUpkV3ZmOWNWU3BlRmx0UjVsWklzb3B4?=
 =?utf-8?B?aWRuWGZFU2x5VDR1UlpGY2hDZ2hDN0t6K0hQdCtqZ1ZMWnN5SlVHTnFwS1Bq?=
 =?utf-8?B?N0g4cytmckZXUDhTOUdiUm5NSi9yUmNzNXBFU3NneHZrMmZKYTllTjVXbzdH?=
 =?utf-8?B?RWV3Q1J3Nm1OdjdyQkpkOG90WEtySFN1MUlSUGpLa3RzZG14cmx3MGdpQUlY?=
 =?utf-8?B?SXhoK1hKTG1nblduN2gwaWNWQ24xNkVadFlJNit4dzNVMnErdGd2UnV1cEQ5?=
 =?utf-8?B?bmRSUk5oZEVoRTlzS25ObzdXZzNUYlN4RUM3M05pQ1NCMjQranpZRzJCMDhi?=
 =?utf-8?B?UnkyZFI1bGtySTFvRlFXdWlsQkR0Q3VyS080Mzlob3lVVHpla0ZPNW0zQjNQ?=
 =?utf-8?B?UUE1T3hlWTNVc0JSYnVVWWV4QWJKMXVYZEl0UUk5YmVFMEpXMFZOSmJDMGFQ?=
 =?utf-8?B?cHd1NC9GUVkyWnpoODArcHVFZGdMQXE4RVhza0RtSFp6Zkx2Sk9jVGRvMWtO?=
 =?utf-8?B?QWVXTWt1MmM1RCs0blRNQ1gxMFJ0U29ibmp2aWV3cDBkZmZNdFJwcEp4Y2sr?=
 =?utf-8?B?OFB5U0RocVBySVQ4bHcrQzQxUUdHRHNhS3ErYnBqZWRYZ3IvR2p2YjZDYUV1?=
 =?utf-8?B?bWpHbGtXUWxYcGIwK3JIV01xV3gvNmtQa3BVYnlTRGU3aVVnWnRsYlc3RWY4?=
 =?utf-8?B?bVhFVXJDejU5aXdkTTZ6MzZ0a1REY0o1aWg4M1pMelpuQjg3YnFHUnFwYXcy?=
 =?utf-8?B?TytXV1k3NHZzb3JRNExMWk1Gb0lveEhESzNaRXREcGtQY3hjc01jYjBuMm44?=
 =?utf-8?B?WnIwaEVFeG1sU2JkMTBqWVl4RnRxU256UktlekJiOE9yNXNyYnFSWFVHWm1Z?=
 =?utf-8?B?K0xNeFNYb3FpNUJEaHBRQ2VRdDR5aTJhVmp1ZkI1UEc0NjE4ek1ncE90SlV2?=
 =?utf-8?B?M05wYUlNaEpYVEFYOGVvWnBHb1V0Vi9wdFd4ajZkbTAzbGR3cHBtNW5SclNO?=
 =?utf-8?B?dkhsc0JuSlFwcWtyMjVRSnhCcGlJN2M0UlFnQ1hZd1pZWTVPMGNxU2dRNURo?=
 =?utf-8?B?SkE4MkZQRkw0bHY2MG9ua21RcGVVQXRHMklKSjZsYTlINTNJR0NkODMwZ1Zz?=
 =?utf-8?B?OUo0dnp2RWdsVXhIZEhTb1Q1TDR4Mmc5ejhLd2hHSGtJUzdPK1R3OHRuODZB?=
 =?utf-8?B?NlJrWFl1TXh3VzNIczRtWkxNcUN0REdMZVJ5ZU1xOGFGaEtoOW1ac3ZOMGxC?=
 =?utf-8?B?aUs5SklhRHpibUtZMUJnS0c5TUhydVoyRHcrdTB3dlBHY1pJazVEVzhuOU5v?=
 =?utf-8?B?WWt2S0hRNlVTQVNCVTVxNVpyVWUzdDNEYTMyL1RaQVkzRkh4eENFaFY4QWdN?=
 =?utf-8?B?S05GQmNqNld4SXUrNzdFNU5NY2lzcHhJbzJqYW5oK0w1OHYwY0FVVmx3L28y?=
 =?utf-8?B?ek1PQnVxQ0Zqb0U3TjZlZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8912.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THJEaC9meERPcFJWTHJpSDFYWTlTYjcweGw1TERtNDQxSG1CZzdWNjRHaklw?=
 =?utf-8?B?ekh0c2FMS3JRY3FpS1JnclZkdS9GVnhObDJqWkRuaUpDRjRndG8wRGVyb3Vj?=
 =?utf-8?B?R0I5RVI4bkpjSFdzN2tLYWloZC82ekNQckFNU0lkMUNXRlRjTWZnaVNSMnh2?=
 =?utf-8?B?MWNlcHRnRFByU1dwYWxGeDdkQTgrTENKdXlsOGREdGFKRElZUGpmU0dDWEdn?=
 =?utf-8?B?Lys5OXo2WVVwdDJDRUVFdm84eFF3emphOTc4WnBYUCszb3dvckFoRkVWOURQ?=
 =?utf-8?B?RkVHTTNQNXhMTjlERUlnbXJseC9SanR3NDU5WmxYZ3Y2UjI5TnhjWUdFT3Zt?=
 =?utf-8?B?NGEvbTF1cFVHNi80UVJPQy85V2FxcmRlMkFLSW5SUFVMTUFYS1NUYSszMzZa?=
 =?utf-8?B?OG42TVV4ak9xSzg0WG5Sa0F5dnpUL2g2S3JCR09iSjJNZU5GZkZkQW5KTms2?=
 =?utf-8?B?WWFva2JoNGFqN0tpbjZVY09wbVRjbGRXUEF5UWRsOFNMSGhtQzBNODVEL01B?=
 =?utf-8?B?TW1NdFkvR0ZJb2lnUlVZeml2aHhNd0dGM3FBQ2huZkMwQ0ZzMWx3QndmNnhB?=
 =?utf-8?B?SlczbkxmYzlSVWdKdS9kMzFMKytDSlVtSkNzVSs0OGxhenJDdUVjb1FVaVJX?=
 =?utf-8?B?MDhEWE94eVV6NXh6ai84cXVJcTRGa2pWMWZheFZwbHBaMldKZUIzKzJtTmZR?=
 =?utf-8?B?aWRTN1d6NFdnQ2JVcGdjcTVnY3c2RzcxQVg0TUlQQ2RnSHcxd2UyRGhvN09B?=
 =?utf-8?B?ZGJ5RGRlMVRSSVZTeVJwUlJ2enR6dzRBcFo3OWRqbkFKOHlmdExCcWNLckVn?=
 =?utf-8?B?VkhNSUdyMCt0N284QlZBSFZ4VmlDSVlEM2htUjB3SU9ZWW1rN2tKU2UzV01x?=
 =?utf-8?B?cEdEc2QvOUIrZTlXbnBpb1hKVGlyaHhaZFJhRWpVZ2FZS3lJSEl6M2Eyc0cv?=
 =?utf-8?B?N2R6WDNvV0xkazB3M1dteWwwQU9tSHgzWk5CbWxFd3lrcHZOOFhmTXgvcU5n?=
 =?utf-8?B?WGpPSzRIY3VLNTFVdW9QSjVPelFxdjFJRHhEa1VTYzFhcUZRM3YrNFRYT0Jv?=
 =?utf-8?B?MDFlaGtQdmRoZUNPU1pzbGJmaDVHOGZqem9MSHp2NUwxenRQSnBWbFJTVDg1?=
 =?utf-8?B?TjRPaG9pM3pqNHZtLytoR0IzZlZxYnk0ZldhRHZPQnFvMVcrajJDV0tqV1VI?=
 =?utf-8?B?Z1lqRDExaGREUHU1MEdzbkJ1NlUzOU1Wa3Mvakc3eHB1aGNUS3lWcTlXTGFZ?=
 =?utf-8?B?NW5pc2F3OVhEaFRXa0JhRTdueUx1cGswVDc2Y3JOQnFvWEVGRU1ETFBLWXB6?=
 =?utf-8?B?S09sc3ZIdW5rYTV1MVg2RW44ZFVhekVXK1RaM2Y4SGtjYmplTG1wUjk4aUc2?=
 =?utf-8?B?WlZ4ZEZoQjhselNKSFY5R01uU3ZKdXF0WTNRaWZtWlArRExIQ1o1RjB4Z2NP?=
 =?utf-8?B?bFlYQXNIQ2d1b0FZaWt4MUtudDhZalNPVVVKSU51QThpSXkxVjM1UzVNY0Nj?=
 =?utf-8?B?OENBUkVKTmtxTlZURkFnVVgzRkFKN3NuK2pCT283TGhSYUtka0xLckVsMm9v?=
 =?utf-8?B?R2cvaXo1TTA3ZVFqU3JpQTZNbnl6SVJ3bytmWkRlRzhETFZwcUsvSE1jc2lx?=
 =?utf-8?B?eDNoeWtNQWVtOVRHQ0N0cDYvZzl1TjV6SzNYMDh2TTBhVkdUdDFseWpkTisr?=
 =?utf-8?B?VDNJWEM1WUtSdkkxbDFCeTBsUTFCZTVaT1BKNnJPbWlhU0ZzcFhZWkVZU0lC?=
 =?utf-8?B?aXVJa1BXSjVGOGVjOTVkM0pSRGdSdkJ5aWtLcENwYzdBK1hlMTRIQmpCSDRl?=
 =?utf-8?B?dkxQMEVlREcvRTBpMjJzR1ZUMzQzbHA5eDh5ZTBJeGQ0WWJRMVJiL3V1MUtX?=
 =?utf-8?B?enM0YTU4VVd1WVVMaDNmUkVzdUp5ajN5RmJkVUU5d3gxRDZWT0Rabk5VSFNt?=
 =?utf-8?B?eGlCOGFkaEJhL1dRTjY2aWJQOXNWZkJXWWVYVFRWU3VKS2VGSURCdUgyRThl?=
 =?utf-8?B?Z2MzYm96SmtWL2hDbW9wQ082OWplK1BxNkFPRitvaUxlZEluSzI5NDlWcTJH?=
 =?utf-8?B?czRBZnlPSFZ2TE8xN3hXV1ZTK2luTmR4akVON3pZc3FIcERxVUpRQVEyaHpQ?=
 =?utf-8?B?UWhJMVZESDFJR0cvckFpL2J5T0ExenJwZ3hGNWMyU1pWR3plbzdEL050QUkr?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f74907d0-7345-4851-3cc6-08dca1883793
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8912.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 09:02:40.1138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYR3tdO1VvmofNZfkegUfEEXcjIItJyc1KHMWZKfLFuNRrRJ/0oStG18GaNwBWQDlbHVfuvmdBc1twNnMUz99LiSIZ5Eg1iYlrw6u/tZDag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9849
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

Hi Manorit,

On 7/10/24 8:15 AM, Manorit Chawdhry wrote:
> Hi Simon,
> 
> On 09:36-20231217, Simon Glass wrote:
>> The existing bootph binding is defined such that properties in a
>> subnode are also implied in the supernode also, as in this example:
>>
>>     buttons {
>>        /* bootph,pre-ram is implied by btn1 */
>>        compatible = "gpio-keys";
>>
>>        btn1 {
>>           bootph,pre-ram;
>>           gpios = <&gpio_a 3 0>;
>>           label = "button1";
>>           linux,code = <BTN_1>;
>>        };
>>
>> Provide an option to implement this in fdtgrep.
>>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> Coming back to this patch as am facing some issues with the bootph-all
> propagation to the parent nodes [0]. We have a dmsc/sms node in our
> devices and it is a parent node of k3_pds, k3_clks, k3_reset.
> 
> During U-boot proper we are initializing the serial console and during
> that time we have to make some calls to our Device manager for clocks
> and power domains. With the DT modelling, the clocks and power domains
> come under the device manager node ( dmsc/sms ) but interestingly that
> driver is not getting probed while putting bootph-all in the child
> nodes. Do you know anything about this? I thought putting it in child
> node will propagate it to the parent nodes as well so it'll be probed as
> well. We are having to put bootph-all explicitely in the dmsc/sms node
> for it to work.
> 

I haven't followed the whole thread but it seems to match something I 
looked into recently.

The properties aren't actually propagated. What happens is that this 
option is used to NOT delete parents (or rather, their properties) of a 
node with the passed bootph- property. This is only useful for TPL and 
SPL device trees which are stripped down versions of the full U-Boot 
DTB. The parent nodes also incidentally do not have this property added, 
they just are merely allowed to exist.

fdtgrep needs to be reworked to allow passing the bootph- properties to 
the parent nodes. I quickly looked into it a few weeks ago and it didn't 
seem like a 5min job to me. This would be also beneficial for U-Boot 
proper pre-relocation stage, which suffers from missing bootph- 
properties in parent nodes (been there recently) as well.

Cheers,
Quentin
