Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F13C021AA
	for <u-boot@archiver.kernel.org>; Mon, 17 Feb 2025 15:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E2968083C;
	Mon, 17 Feb 2025 16:02:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ig6Ov5OT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B8B2808B6; Mon, 17 Feb 2025 16:02:26 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9754A807F1
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 16:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCOYY7esvPidcxYUDdFZLte3BuVKvr/JUfbq9Z27rtij3+D+kAdcXEMShzBTs65ECvKfyl5FIIxzHo4PpM0akIve7GJqqMx3O54kdr1LNBNcyFoyIpRvtj+rip/laGIr4Mhvwr3Q75CB9XVrCJy71D2MPIU4MfoVfQ0rfnnh3ayZkptqJ5AE2lKXMF5zag0PyBmJgQ7G/eOGK0KvoAwa5Sc6lCOAaugjP++h9EAkBi0jkbuO1ua3utj6a55BNkref+CPWhu3sZpwj4jwSNJCT+0bKuaiwDjHLB3fNlcsc57ax5GyXiBShxVSEwVVaVpPfTpuxXcjzy/ijqc8rtS50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79bNJZiG5d1TFgYfLYStGaVazW8wOk+sFJGJESaNXHI=;
 b=FXmHAPgw/Bp5a98qB/uBLJCVdjtFyKNvmRSiGzyCZBInBejMqrRPJ8e4KtM4qrC2xWy9K+cKPVR84J+jEAYK4o6endqOYST84pDviRBSf2hMtvPTh2WzuvG659ZK6ywY2DevvRgYb/B1ToK1fwGEojaxb0BB1jTRiAmxNGsSWK0RDwwtZIQX6kCzPTeXIPHFizWtNCz/ZFyOLV1jTwDhFZXmwhfknOyRmcjT4fjr77w6hkEMKVbp8ggFfq5wCey8MW0KTC+WIbGQWjM/t00he1mioFpD9Rdk042/noz610jbvN4qNi3QtNaqimiI5uOEWCvKoT89q1rvLBBgesYeJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79bNJZiG5d1TFgYfLYStGaVazW8wOk+sFJGJESaNXHI=;
 b=Ig6Ov5OTNIbcLJ4U/pnKNHamyf1Ep6qkLqVUe00tmw5Xj0EgpRrx9dezWYIBhMnWYjcfOjeXWoI+IxMgPqySGXjCZQRQAWBolmbfkFXWqDdrJlMWE3dEhYeumGLKCM3TkJXXUmv/6J6eEFjHAs8SIEsXZ5Gyc+NUh39Oe0vVX3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9359.eurprd04.prod.outlook.com (2603:10a6:20b:4db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 17 Feb
 2025 15:02:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 15:02:20 +0000
Message-ID: <445f7dd4-d445-41a2-ad0b-f0c2002f3f1a@cherry.de>
Date: Mon, 17 Feb 2025 16:02:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2 v1] Propagate bootph* property to all parent nodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, m-chawdhry@ti.com,
 n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com, a-chavda@ti.com
References: <20250212091820.213895-1-m-shah@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250212091820.213895-1-m-shah@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9359:EE_
X-MS-Office365-Filtering-Correlation-Id: f1134052-69a4-4e73-e1cd-08dd4f641335
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy9oR053OU9jNXNxV1RNd1pBZHdLZWNHcmVhRk1xaEd4SkN3OEd3VThuZ2tZ?=
 =?utf-8?B?cmhicERmZTZubmtvSXQ3NTFyK3lRNERMeEQxcTZoRWpvSy9qVHN5N05UUS9F?=
 =?utf-8?B?ZUlTVkpnN0Z1WG5wdUZVQit0cy90NE9sVWpXNTdaYVhRMVUyN0JUbWdyeUJJ?=
 =?utf-8?B?UHgyNUJrU3RDOCtxZ3hXUENadVF6ZGZCREEzQlY4djRNVU4zUkxaaTJlU1h0?=
 =?utf-8?B?bFRxOGJnWmxBeGVNWm8vZ2plcERyWlEyTy90MDlTdTZiWGdFTnkzVkk4bnZJ?=
 =?utf-8?B?TDF3bnNtazJpNDFxMU5qemtrL25oVml2VXdkalBYUmNvbWk2ZTA3SHlvWXlB?=
 =?utf-8?B?bm5pc1NjS2NveEFRNDhoa2x2NC85MDB5cHBPNC81Um1qOHRiWkhKVytpSEdN?=
 =?utf-8?B?Wmk5Rzh5RTZFeGtaRmlNLzM3Rll2TDVySHNjaEVrWHFhVzlrL2dpdzc5VVpP?=
 =?utf-8?B?VG1hQnRUTm5OV0N2ZnNsSzY3SUdnQmVpT3o3L2FLTDZma3VvMkRJa1gyN21j?=
 =?utf-8?B?OVJWK0FuZUpGRDg0dlVXT2d6MzhQVVppd2pCazVYZ1ROdFhLcXV6V0drZXNr?=
 =?utf-8?B?ZzNOZE5LRFFwd3lhdGFtak9HR3NpN25iU2FiR0pYWUNpU1JjWHVIMHc4N0FQ?=
 =?utf-8?B?NWUySHhmWFF5SU5UdlpIUUNRMlJXc0h2cmhpN28yUnJVY1NZMU5Yano1RXZn?=
 =?utf-8?B?cHBmMlFUNzF6UFl2dE9CbXlnSWFkSlY5VFpnQUR6WVkyS2V3UVIyY0xxaUVU?=
 =?utf-8?B?QVFSbVZnOHJ1dmVOa3NEUHRsUURDemtWQ1lpWi9FSkE2dWlFREpPTi9qbUtm?=
 =?utf-8?B?OEM5cmRYWlhzaCt2dEJQWXNGZlNRMXQzSHdHYXFQMk5tano1MjlTdUFRbHgw?=
 =?utf-8?B?SUtCbW9OK3ZMQ09oMndiZXJHMiszWSsvY3BiTXBVelpGR0JUZ2JLdlIxTnN1?=
 =?utf-8?B?TE55WEZ2dkRDcVN0WjBBekVWd3RSK1RPa1RYSUJoaFZSNEFpK2tUYVBQSTAw?=
 =?utf-8?B?WUlNSldXUXdpMys1Rm9PRXNPMDBGYkxGNG1oaDRYZVhPM045cC84VnZIV01H?=
 =?utf-8?B?dWpxa3d2RU1ZWFJ2UVdOWEFSdWpFb1ZiaFNUM3hwQ0lwQlEralJlczZtaUg2?=
 =?utf-8?B?SkM3TWZuWUlqRHJBakFyWkE1ZklNWHg0WWMvZVhzY3h5MzNVUVFrNnJzZnBa?=
 =?utf-8?B?c0VPbm8zRysxWm9SMVlvb0txMVh3MS9wRjdnL2Z0M3U3RlA5QTRGd1NBdy9L?=
 =?utf-8?B?UEErOEp1T2hoQ0ZsMG5rd1kxY3BqUGtWMFNjYzBkYlZRV0FrcExJc2N2bzJ6?=
 =?utf-8?B?OGpCMUgrUUUwTU5CTDk3QnFleDlWVzlNWXlJVTVMUDhQaGNYODVBSzdHb1Z1?=
 =?utf-8?B?UHJqZ1pzRlRRQmdLU0hrWk1ueTJmUnV5RzlEV2tuSGgxUnBCU0ZjS2J2MFFD?=
 =?utf-8?B?dUllYSsrWms3cXJjcFVvTUpCNTZRczJnT3dwWXJYdXhEUEYyd2M5bVFlV25q?=
 =?utf-8?B?b3A0eXczTmNnU2N6Tm53WkNTSTlWSnBVUmtMM2pEbHp1QnRpNkZXRHk0ZUhs?=
 =?utf-8?B?WGlUVFhGZkJUWHE1dkp6NG02T2VoRStGeCthbkJXVU9qSEthbGdaVm5BYWN1?=
 =?utf-8?B?SE1LdkthQnRyTERJKzA1TFVrV0RybkxRNjRadmZKUUd5M0VjSnBIOUZPMU54?=
 =?utf-8?B?VHJBZytCeFJaYWFyZFJHcmJSUk1NNWU0Y2RWK1ZOR20zOUpIUmkxcWZVcFEv?=
 =?utf-8?B?MFJaYXR6ZVhqV2RGQ1hZVmlNa21oQ3NtaXYxVW43VS92SWs2SmpxYktlU3pl?=
 =?utf-8?B?a3hCWW1zS1dTbEdXU3ZBTjNRYlVwY2Y0NUxsSVVOYVZaNzFmRCtPNUQ3ZG9i?=
 =?utf-8?Q?ATeYMAZg9nG1q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1kvL0gyTzBqOE1tZndJZmF5R1EyOTV1RVFjcjc4TkUzK2pKb0MxMitGU1E0?=
 =?utf-8?B?bUJRTnA1aXQ5Q3Nja3ZWYXRXSFlYWkRkVnlFSzkybUh0YTFTbFhzU1owZmc5?=
 =?utf-8?B?WFRGcngveWVSbWI1QjFEeGNFdng2YThSY0RaaU9INEtqSmVzS05ESFJhUmU5?=
 =?utf-8?B?akw0RzVWdE05eG4wTWVFdVZsVlZOejRodndHdEt5eHhlT3lBWklidXdURmtk?=
 =?utf-8?B?TDV5S2xpUndjTmZsSUN0Yy84cFlWZW1CWEtpOEROY2ViM0FOOWZRS1BLa1Jj?=
 =?utf-8?B?Z1pmMjZyWkZJcGh2SC85M1pvYm1zMi9MTWZQV0QzejBVNWpHeEVtR3pmaXN4?=
 =?utf-8?B?em9IZXRLNC8rOUpyeGNPRXlNOTJ5T3IwajZ2dFVHTGEzRnFYdEtvalVOdmlx?=
 =?utf-8?B?dE5BNGJpRnZ6QTFibWxQeitxY1o5SEdGQU1TUzJZYU9ZV3VoaGRwTnYyaTc2?=
 =?utf-8?B?OFlBd3lsVG5Mb1V3d2o3VHFVdHFpMGk2bHB2dWhFU3BxNkVkNTg4dHdNQUQ0?=
 =?utf-8?B?d2R1aXdncXVVWGFhemtoa3JhM1pucFM1Q0ROcGJmNGFPMGcwTFlmRUh1K1VZ?=
 =?utf-8?B?N1JVajFoUzVoQy9WT2VQVk1kVzJmb1dWVWttL0EvQ3FHOHNXaXk2MHhSV1k3?=
 =?utf-8?B?enlmSGNYRXArVXF1TndoaWJsUVNTZUFyVm9wN3VsY2h5dEtHWTA5Y0kwdVdW?=
 =?utf-8?B?czRTRjhWOWtBeVZ3NGhhdmo3R2ZGditXVlpuZTE0L1JEb3dlWStZUlEvTTZC?=
 =?utf-8?B?bHVFSHpjYlcrbDB3RjYrcnJqUk5IME9nY0EzQTVtYzdtc0s1MTZPQnpQNU0v?=
 =?utf-8?B?VkRVVjhtVzZQMTFmRzYzUFZrQkJ6S1MwMmZsNzJzVkJSbjNhV2ExZWxGYUY0?=
 =?utf-8?B?L0FoQXB0cER2Vmc4UkFkNEpuWGs2MjFIRHdlZldEUnI5bFlqaEowZjVJTU5y?=
 =?utf-8?B?Z2RQKzNwZC9hbDBDbEZlSDZNOVFGRFJ0cDNrSHlDc1RSVkVLL0dhVjRxS21R?=
 =?utf-8?B?ckYvYWZ2WVUvazdRZUJDb0ZDejhrcEhyeUE3aW84d2Y4bVRBdVUxRUQ0aTUw?=
 =?utf-8?B?bGNVY3lsM2hMenZaelJYTElxS0RkUzJaTUFJUit5ZnQ4Q2pWV0JxeVBDL2tv?=
 =?utf-8?B?b1hnbXhIbHNML01JTnA2THp2RWRRWkcyVnV4WEk5L2RxQk1UekVrcis1bk9X?=
 =?utf-8?B?NmFLOWNQNmpEMlQvTVRKS0xJNnhZSzV0T3Q4cW5vWmZyeDBqbVdzWE4vWlpO?=
 =?utf-8?B?NmE3VjJVVlJybGVxdTVGNXlTc3J0TmFYMDBEdGpDRXZHVDdQLzNidnRsUEcy?=
 =?utf-8?B?U1NJWStVRjJFWmlSSUF0SkNOZ1JmWVhreXpyVEdtRitUeEdLd0xLRXlmWkhP?=
 =?utf-8?B?bGRrRWV6SURCeEZQcFdTbkVpejZodWRXcTV4dG5DdE8xaXlQZElOR21LTWJG?=
 =?utf-8?B?YUI5Mit2ZE1NVkpBeEVHZFVGWGJXUjVvTmltaDN2ZVVYN0JLeWt6NFlvbG5x?=
 =?utf-8?B?SkJBeDNWWmFBT25OUmJWTWpuK2hoQkxPa0xMd0hqMytzUkJWU010NUE0RlI2?=
 =?utf-8?B?d3JSdHdnMkR1OXBBVlM5Y1FhZjIzS0x5c1N4NEtEa0xVUlFYd1Rsa3ZHb0JC?=
 =?utf-8?B?QWgrYVVuaENSd1ZtbkZTeWJNZGhDMTN2d2FZb2M3MVlBWmluUGpKR085QVBk?=
 =?utf-8?B?SCtkMUlLRmt2L3lvdWh1Zk94WlQrTk10a0F3bVlCT0x5MHFmZm5xZG0ra2d3?=
 =?utf-8?B?ZTdlMFc1QjJrNm5GY29BSU95OVpZZERmR2Nja2JoU1dhS2ZWVXpxOHBJK2FM?=
 =?utf-8?B?aytIZ1dtVFIrKzlSZS9NcHJOOGd5YkxOMXUyM25IQW4rSyswSGhKUndyN2kz?=
 =?utf-8?B?a2JIVzFKMy9QUWZIQlNQVkFYa1NOcXVUcEhBVkc0RWI1M3hBSGlQOFZieDM2?=
 =?utf-8?B?NXlJME1nekh1RzRWVWN5bjluNS9nOVNEM3h5NVB6blYydi8xTEFGdmF5enVq?=
 =?utf-8?B?M1VDRi9uRlRMYTBTRHdTN0UvcS9vWDdJTUQrTmhIbms0UisreTIzTHZHME9l?=
 =?utf-8?B?aG1NQWh4OHNMS2hqU3d0L1ZUbDVZRTZLcGRYd1RkclR4MDFwSVJsNmdLenZ4?=
 =?utf-8?B?VlFvcW10UGFXKzQyNjluRGRIRjQxU0dPM3A1bVBQTUx3bzgzYXdSZXVsZVhL?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1134052-69a4-4e73-e1cd-08dd4f641335
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:02:19.9602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puE+JCtBHrenXZ90su/P4p27rJxoxhpwPfRjWFBxf136ojV4MrAmtK3lRW0foiHXKjh0ainpXDN0AnfwIl4CdGm02e5noQOPx0DbLg2YJG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9359
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

Hi Moteen,

On 2/12/25 10:18 AM, Moteen Shah wrote:
> [You don't often get email from m-shah@ti.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> In the U-Boot pre-relocation stage, if the parent node lacks bootph*
> property and the driver lacks a pre-reloc flag, all of its subsequent
> subnodes gets skipped over from driver binding—even if they have a
> bootph* property.
> 
> This series addresses the issue by scanning through all the subnodes
> of the current node for the bootph* property and propagate it to all
> of its supernodes, ensuring that all of the applicable drivers are
> bound and probed prior to relocation. This series implements one of
> the solutions mentioned in [0].
> 
> Since, all the nodes which are not having any bootph* property will
> also be traversed, we will have to incur some overheads in boot time,
> hence protecting the feature under a config.
> 
> Boot time overheads:
>      Baseline: Upstream u-boot
> 
>      Patch test: Baseline + remove all bootph-all properties from
>      *-u-boot.dtsi except the ones which are supposed to be probed
>      but have no bootph in any of its subnode.
> 
>      J7200 delta from baseline  : ~100ms
>      J784S4 delta from baseline : ~350ms
> 

Pfew, that's a lot of time. Can you tell us what's the delta in 
percentage from baseline? Because if your system is usually booting in 
one minute, 100ms isn't too bad :)

FYI, I believe we've been hit by this issue on Rockchip but cannot find 
the thread or patch right now.

For TPL and SPL, the Device Tree is parsed and looked for appropriate 
bootph properties. Any node which doesn't have a bootph property and 
doesn't have any children with a bootph property is removed from the 
tree. However, the bootph property (if only present in a children node) 
isn't propagated (meaning the node doesn't get the property). This is 
done by fdtgrep.

The issue is that for U-Boot proper pre-relocation, the whole DT is 
taken and only nodes with the appropriate bootph property is probed and 
children nodes do NOT count as opposed to the TPL/SPL case.

My idea was that maybe we should rather propagate the property, at the 
very least in U-Boot proper pre-relocation. This does mean we will 
increase (by which amount?) the size of the DT in U-Boot proper because 
we would add this property recursively up the tree from a node that has 
the bootph property for U-Boot proper pre-relocation. This **could** be 
an issue as the DT could be passed between stages and we would then hit 
the size limit. Sadly, I didn't take the time to look into adding 
support for that in fdtgrep nor will I have the time to do it, so take 
this as me sharing my wish list with you.

I would really like to avoid having it guarded by a knob though because 
I really think this is an issue that should simply be fixed 
unconditionally for every platform with DT support.

Cheers,
Quentin
