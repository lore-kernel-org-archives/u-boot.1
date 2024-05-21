Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C15DC25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 09:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A66F8811C;
	Tue, 21 May 2024 11:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="TbRb7s+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C73B088137; Tue, 21 May 2024 11:23:08 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20726.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A98988122
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 11:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGqoUXT7YGKMi+H/ulM4B9u5ip0ADSEzUQcqCCE2A4+96iXM0Kr1uqet+GTokdB7Ot0FvqlW6QJ+FAEmSTf2mI4n7DN68SNmNKcpsOG9fpW/GZtU8yMN8rQFCGUL6FT5pKIl43D1J/JLpiBiHYpeD63KYfWeG+pgEcKlc7PjDkuOOSW6SuKapg8ySDfeK/v6+2vbt+iXIUxQn/TbDN3R7vp0Qz51ulCjFnr3kJNdGi6QHQPHe0SD2VjBCKUyY9a6pFXChHC7KxEzkGiZWVufT0s5zUT8SbVhn7H9l9xqff9omzxdR46P910VoMvFj52RbdCLdnO5lh1pKNyqAEgEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSZT8j3+p2/0XpSRA//VIXRA0qekKVc5xAtqMMWM10s=;
 b=fMm/bdIzkiPrbc8qpG1odTxWkeY2dDZHqh3/ghZvYfX+3NeOQPyxNUc06AF3Uaq7D2NcRrdpLg3dY48RVYiw4+P2I1/uB1iBbGZBDmfZQoRPUtxpIXroGP5d8lJWO0LPs2xzNzYQVBR7HYnx2BbZ+IeMJUgJ5Lqk3xTXDA5K6HNJI/nbv1eoWxYoamoinkPpstomYMAgnfR5ZJMD5kdt7W2snfWnHxPOG5XRLfFaifMcZSS6ZztumU6oavgWxBip/xtjgEv3YQJQ+33Qqc13HBb3BKKY0V++ylKlKOr6jyKkEnJfetidmgIaYssbaBiZi7Rrz5AMxDDIJfFSQXxriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSZT8j3+p2/0XpSRA//VIXRA0qekKVc5xAtqMMWM10s=;
 b=TbRb7s+VO4FV6DuFo2WnU3k0eaciGh40oFQ4EdzNKsp8EeoOs2pOHEuIhrJ+bzt+oMYCS26nc8zG6MPa6ztnsFmX0DCVfPlO+m9Rd39qlRZxVRaKDltmmb8uOCBJbJ1LKhi6A3WZRaxieqyxV5PSs9w5Z793f5HvSJ0ki+FVf6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 09:23:03 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 09:23:03 +0000
Message-ID: <b160b75b-513a-44e1-ab1c-cdcb42a44dda@cherry.de>
Date: Tue, 21 May 2024 11:23:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/2] doc: process.rst: Use subsubheading for "Phases of the
 Development Process"
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20240517174930.1028063-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240517174930.1028063-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 037f17ff-64a6-4346-5497-08dc79779daf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1pvNHFxcXRHYVhObFlLb09UVWt5V05WVG5RaDRyc0Q0ZVlFalp0dFdVSHhX?=
 =?utf-8?B?UzR3ZmM4YjQ0UFlzOWpObTFyOFVNK01TakxjczlobzRnR2t6ZVNKZlM3dGFv?=
 =?utf-8?B?TlFKT1ljcUZrQyt4QzVFN01MejBaWi9DWFd1bm9kT0NsSmNldmJlckplalpS?=
 =?utf-8?B?WkZNZVZrY0JpeFVmdWhZL0l0SGZuNnBSZk10SjBDRkcxZXFRb1hyQjRXcDUw?=
 =?utf-8?B?Z3h2dHdDa1dxanVFMVRMY1pKSmFtUUFIOHA1ZUpseDJnVWRTOWgxYk1GRzIy?=
 =?utf-8?B?dm5aMHVuMFJzalJ4YVFUZ0RWaHI3YUZjQjFWWHhYOGo3S0xnQjZxVlVrZnhK?=
 =?utf-8?B?dTVBQTNDbGF2ZU9WTjFpZ1AvTW1DT01oYzI4SlVBS0ZmVG5lYXJwcUx4bThH?=
 =?utf-8?B?NDhrMnd2d2NZanZMaVQySDdmQ3dMTTh0cFZDVUtYei8zNXIrdFJ5TXZOMitY?=
 =?utf-8?B?VnFvUmw0UHF1RVJDRlVBMlJSVUlQQ2NLNmJxSUdEZDBuckdCR1BSQWhtdWFU?=
 =?utf-8?B?NmhpOHJ0WVA3YmdsdFhjSCtHVEdJb0dIQ3NTM2ErQkI2UEIvTU5IVHNsbVc1?=
 =?utf-8?B?bHUrZEx0anV1QkRLTmtwd2xGL1lRUnRzc01xdUhkcDdobjFoeDFDamlRV01R?=
 =?utf-8?B?V3NGd25kd24zNmsyT1d1RFN5YS92Y09OMWM3NlZYNWhDVkc5cURmR241eUta?=
 =?utf-8?B?R0Q1RzIvcmZ0d1hhZ3d6KzlpTjNiTWkzZkF3NGJObnQvZS9RamMza2ZUYjNC?=
 =?utf-8?B?N1AwZnkwTzVUdlI1L0Y1VTBaMkhuTTg3eHphaVlxSks0dXdaaWJpNitHaENi?=
 =?utf-8?B?aU4rVEJOVy9ZdjlGSDk5MS9UbWRyS21UMHhMQlBIY29FamlwazVzdDFFLzVP?=
 =?utf-8?B?MkVIR2dOMjg5eGl4UE5vcDV3OVpUdlo3VGpHU3RnbnFycnRsdXduVVY2RHFO?=
 =?utf-8?B?VnU0VjgxTFplVTJTdVNwVllmMmJvM0d1eUQ1dlkrSkpuWnZYcmQxNGZGR3ln?=
 =?utf-8?B?TXVyenFreDhTSVhwdko5MEJuZmVaM2l5Y0drbWhZMlViTlJVWFU1TGdxK1lK?=
 =?utf-8?B?QkZraU5IUFZkemM5eXFlb3J0OWJqRGsvbmg2TlBtV3JwMGlmWWFpeUhERlJn?=
 =?utf-8?B?VG5oVSt3ZEt0RytVRkpaN2JvT2U5UUNEMEJPaHVzaTRHVlRPZFhHZTk3YVRG?=
 =?utf-8?B?VlpGUjNZV1E1YjJLRnYyWjczOXpUV251Wnl3Q3N3TTgzU0ErbmZ1L1FlUTJu?=
 =?utf-8?B?Mmh6UFN5RDlYSVd1L1ptZkdvNEhWai9OZTBQRWNPVWJ2a0IvcWFtbnlWUDdS?=
 =?utf-8?B?UDY5YlJVZEUrNittRW5NUmZZTm43SFRjMk9HRWY4YUp6dndMV2dDTGFHZWp0?=
 =?utf-8?B?SUpPMUU5cVRrR094V2VWQkh2T2hmNjJjdTJwb2tDNTRkem5EK25wTHNWblgy?=
 =?utf-8?B?eDFtK2dTcG5BRk10dmMzVjQxQ3VISm5DaVhxSVFxc1BJOXd5SGdybHpSYWJz?=
 =?utf-8?B?bmZTUWR3VGltcFp5S0YyMDVIYzM2QjIrV1FVYVViUm9uR3pQSzNOVG16ZmJj?=
 =?utf-8?B?TXpJUWlYWmRsdW5lQWx0L1VQY3NiMjdmUk4xUXZZZ0lBbzlDYWNiL1Fpdkhm?=
 =?utf-8?B?UzcyWkk5U0llVGU3OEhaaWxxQmpzaENCMzN6c2hKZE9LeVBKQzlsckVLQWNs?=
 =?utf-8?B?dGo4aGpCUEFrL3d4bGRxL0xvanJBMzNabW1FVXphMzhLL2RkcjlCRWtBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWJYYWQzZUQwM0IyNkNJdWljTE0yeGNuYUl4ZVUwWFRGQXNZakF3dE5rWHNJ?=
 =?utf-8?B?SElyam1lS1NMYTU5czNBb0x2amxVcHJ2dnZsQitlUUE2Szg3ckZIVHY5dmhJ?=
 =?utf-8?B?RnZWS1VYc3VhZFR4bHBTd2ZpbXdJUmJCeW5MRXZCdmtGN2RGbG5laC9JT0xs?=
 =?utf-8?B?VG9ZNnprdDF5Qy9HOEliemVZenEwWWZRbWhQdnFPbkYxNWNEMW5XVFdMOHBY?=
 =?utf-8?B?aC90algrdENEakRiOS9kZkE1NGRGSkh3K1VsSWpCTkZkcjRld2xBemdyMm9m?=
 =?utf-8?B?OGtzek40L25zK2UvNnFISTBqQW1IZXBXMU16T1RPTThKRkpNNHFYSWRhV09E?=
 =?utf-8?B?Zm8yamsyYmVsZHZ5QjVXRW9vZG5OOFhDbXNLMFF0b1JLODBoWFNLSHJjc3dH?=
 =?utf-8?B?bURvUUZ5NTRvTHA5R2pzMVZ0Zmo4VmtJUEorT1dUQStEeitacVJmc2k0RjZh?=
 =?utf-8?B?UUlJWVNMVEhmNGczdGpTMXg4WDlaSk12K0NJcDdLeTA2c0E5M25BdnhUdmhG?=
 =?utf-8?B?bGVDektQN3NvQW1qYTloUmk4OGRWNStXK3p1RVlCcUkzc1l1c2FTL29ZdFIx?=
 =?utf-8?B?RjM3SGtPSS9YTkxJWU01NmRBcDJtZHpXTXZMUGQvUkN0Y3ZuamxJaWFtL0dF?=
 =?utf-8?B?NU1yWGxRdVJPTU41eHQxT1FJL0dka1U3dFhUVXUxSFJWVWp5OWo1WmcxQTZQ?=
 =?utf-8?B?NVpCNlhxRGtoRVFUbWMxYUZqL0UwS3laMytyc2tYNzRicWZQM0dpUFpNbjRC?=
 =?utf-8?B?b0MweFhIaWZBRCt1OEdrRlRlYmpyOEhqTW9uU1JPSUVSU21OaDB1N01Nbmh0?=
 =?utf-8?B?dTR4RTI4VXZkWjlzYUpYY0RnRzJlaHBTWEE5bEFVNENpUERHYnYzUG5Fby9D?=
 =?utf-8?B?cGV0eFRlMWluRTV0VGh3RTBvTVpMM0E3eVhGSHFSa0Q0WTVpZDQ2K3VyL1FI?=
 =?utf-8?B?QTBkQzFSNDFZOFVhOWlML2p3eEcyaDBybGs2ZTFpa3d2UlErclFrVUZvWVJM?=
 =?utf-8?B?K01hQnpZQjF6UDh6TzBhWWsvb1NDUVE1Q0dpTUVudVd6Tjh4TUc2RGd0dml2?=
 =?utf-8?B?Ykg0VFhJZW5LWTJ5M3pWenVhQ1g3aWJjUXpKU3BHQkFLSkR4MFBUc1A5R0VR?=
 =?utf-8?B?em5qYXNnSzQ3L0pxb1ZvUW5MRzlDTStoUzgrZUk2T1dtanJ3OXFNS2xocHgz?=
 =?utf-8?B?WE9saFVhTjVubXhaU2g1WkxiV0FTVlNEZjBvSU1VU3ZRWXAveFlmaXhkcTBm?=
 =?utf-8?B?YXdZaXZvdVI1d1VuYlZSMFdvZkZCMWdOZ1A1RkdYMCtQOGRnVThwNG1ENm5X?=
 =?utf-8?B?YW9HVGtKYk44R0FtVmdpZGF4SEFsdHJPWEh6TjQrMW4vREpzT3Z0UkVGM1Vp?=
 =?utf-8?B?Wm16RldGcExGMG1OVk9oTkNZQzRvM1Jzd0M3Nlo2aEw0U0pmRXR0VnJMKzV0?=
 =?utf-8?B?U01uNlV5cnpMVWpuM1lTdHdIMm04Zkl1UWdaZmFRYkVQa3VRSGpnc21PK2cv?=
 =?utf-8?B?Rjk4czBhOE5PQ1ZhRmtnQnFYZFFuMzJGaXhHUDBsRHRCc3cvcW5QREJiNFRY?=
 =?utf-8?B?Skx6RlVtUWVSemlnQ3V0a3c0NWRRbFJtWUJ1L1d1Y3lSa1NGMHF2U0U1c1Bu?=
 =?utf-8?B?aURaYitZUHhoUDE3UWd5YTFGMDR2cnJyRmtlcVJubGVuNGt3UTN6SFZDbWUy?=
 =?utf-8?B?WjV3TzNMMHNHejBIbVFzVUZrYlRFRTJMcUxiZmZidjhsdVZUdEdEdWh1OSs4?=
 =?utf-8?B?KzFZZTAveEt0NFBGdHVhQjVxK040dGdIQmFZcVU4enZuWERsM0N1NEc3V1pi?=
 =?utf-8?B?WDdDZThFODBzSE1VNTEzdGtYUmN0ZGlVbzJPNzMzOVMydFo5YnRoRGpqVTdT?=
 =?utf-8?B?SmlMR2Fua0VMSisrRE5HMWNrTWx5eHVJMSszakIwZGgzaStPbzdSU09kZEF6?=
 =?utf-8?B?UXhod1dsQ29vUDMzVWtuZlI3N2ZrbGw2Sk54TkU3MTJVRHlRSEFrYUtobmo2?=
 =?utf-8?B?a1czOWpwOU5VTWJaK2dWaWpXR2xYZnV2VnlRU0N4Qk1xcE96SUJPUS9uYklF?=
 =?utf-8?B?WUFtSzlZdk1ObTQ3Z3N3Zmc0SjUzdWNET2pPSFVqUTAwVVNXb1UydDJGVEZI?=
 =?utf-8?B?NXhPTC95UDRxK21KT3VVeGppWm9kY241Q0RTWjkwenQ1bWlOQXhmMDJvZ2NO?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 037f17ff-64a6-4346-5497-08dc79779daf
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 09:23:03.4803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDHaq0zowwc+zmjD3wXwwQloOft5/gssgTOurhroMsRDpa24kcxTu2VaWxAzzabYKUKTrxBvf0/zkC4p3VUedmCGy8k14bB45jy5ZS4/HK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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

Hi Tom,

On 5/17/24 7:49 PM, Tom Rini wrote:
> These sections which talk about the different phases of the development
> process should be using the subsubheading identifier.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v3:
> None
> 
> Changes in v2:
> None
> 
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/develop/process.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index 92477d05dd85..a66540a698c1 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -34,7 +34,7 @@ It is followed by a *Stabilization Period*.
>   The end of a Release Cycle is marked by the release of a new U-Boot version.
>   
>   Merge Window
> -------------
> +^^^^^^^^^^^^
>   
>   The Merge Window is the period when new patches get submitted (and hopefully
>   accepted) for inclusion into U-Boot mainline. This period lasts for 21 days (3
> @@ -44,7 +44,7 @@ This is the only time when new code (like support for new processors or new
>   boards, or other new features or reorganization of code) is accepted.
>   
>   Twilight Time
> --------------
> +^^^^^^^^^^^^^
>   
>   Usually patches do not get accepted as they are - the peer review that takes
>   place will usually require changes and resubmissions of the patches before they
> @@ -65,13 +65,13 @@ the Merge Window does not preclude patches that were already posted from being
>   merged for the upcoming release.
>   
>   Stabilization Period
> ---------------------
> +^^^^^^^^^^^^^^^^^^^^
>   
>   During the Stabilization Period only patches containing bug fixes get
>   applied.
>   
>   Corner Cases
> -------------
> +^^^^^^^^^^^^
>   
>   Sometimes it is not clear if a patch contains a bug fix or not.
>   For example, changes that remove dead code, unused macros etc. or

Wondering if we shouldn't put:

Differences to the Linux Development Process

section under the "Phases of the development process" section as well?

Otherwise,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
