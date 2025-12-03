Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA95D15D8A
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 15:36:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15EBD83DA6;
	Wed,  3 Dec 2025 16:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oPxy1OP2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85D1983FE9; Wed,  3 Dec 2025 16:36:54 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856C383BFE
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 16:36:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDpqUSmiApS97V/Kkhw60n9lkhk3Mn4jFMgkXsEb1R8dxnTqsuz6KoOyW94lFzxbSAcb4FPRY/Su5rwmRvehdbqqv8hkW3VAUamgx5Zg2wWU4FF0M0+ASu2zTQP2SsLwVCO8OiugRAMWS23FX1hX/m1xrAMO9n2sh+xHMSqo4h/lzCb+bww94V8xyffg1fFZQ/L4xRiyg/P89TquDgizT8tKedFsHAxBjQOux8JrmxWcvFoN3elo3YGs3vvkRP/VUmt0RhMJ2JEYp/fXgw6xSI7byZ+0Dk8/MvD7Qchwi20fyBwMOLH8lRwg2yShe91fnZ5ipvvuz0kdAFkeb0PSow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylptnA6BhtW0JpOgeDaalF+dc1ecWQR7dvVhXy6NsZ0=;
 b=A0wU4ncJx2X9X1ZDxCorM+a0epOCPCkp0qc7FPxav9Rd2OdRK4JF21rAgBrwpr0VQL8w7WKJIw6Gcedu1gkJBpp0Qln8IFULyfPgvgQrVh+UMrNcsNYS74P16rpQJT4yNwnQ6hghSxtrRkwasSq4q5lt3fBUUiQhClbEELa8W7UywxPnu/ODD1cM311nh7STkhaDZeYpdCb0x8OzoymxCUH6jeV1T20T8LrzcZDt9vyTWhObldMN3Ry9bab6zGZiSTVOM1+lzRRwND0wCH0r7nLXO8Z2OrSdeAIDuzQBcuGskti7hp4ZTA261yuFCJ8cUAGJmF66HmMNBw/Vx6sU/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylptnA6BhtW0JpOgeDaalF+dc1ecWQR7dvVhXy6NsZ0=;
 b=oPxy1OP21NYNN+dln7W3VkK0YvILJ8cD5l3yUrEyfiK4ZeE6Gljq52ZJE2zvCdDV4PWq1N6ja6RWJzcOYPJJY5v29pCOZbCq2mSGeJFaFVGFenk6qJr2b/iu3Hr+FD/KCtSZKoN0c9hvzULbvqjzl9jXzy1RyzhBph0QpB40Uz4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com (2603:10a6:10:643::14)
 by AMDPR04MB11703.eurprd04.prod.outlook.com (2603:10a6:20b:71c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 3 Dec
 2025 15:36:51 +0000
Received: from DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b]) by DU4PR04MB12026.eurprd04.prod.outlook.com
 ([fe80::2c21:dc0b:a3c5:531b%5]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 15:36:51 +0000
Message-ID: <97a3117c-7bab-47d1-a5ed-1a33e7c2441a@cherry.de>
Date: Wed, 3 Dec 2025 16:36:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: single: Add missing free in
 single_allocate_function
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BESP194MB2805A2491EFE4D94C777F9C5DAD8A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0231.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::11) To DU4PR04MB12026.eurprd04.prod.outlook.com
 (2603:10a6:10:643::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB12026:EE_|AMDPR04MB11703:EE_
X-MS-Office365-Filtering-Correlation-Id: 6de2d6d8-9017-47d4-f325-08de3281c725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjlsYVNSKzFTaDdiRENCd0kwOU5JSzl0UHZBdXJXcWR3U0tTZ1ByOHpmSVpl?=
 =?utf-8?B?SzVVci9PKzVrSHlvYzV5TnRrTm1scWE5YWcrbTY0dW8wL1duSDIvdGNTOVpm?=
 =?utf-8?B?aklkRENJYmR5NmZYRXNJK242dFRaSWZHN3V2WWZFSE5xeE0zeW9zZGJVYkJE?=
 =?utf-8?B?bnpPOTVpWjRORS93eXdFTDhlcjJkWWZGVWNwTklTYk5BUUlRK25oMjl2c1Jt?=
 =?utf-8?B?VjBORFg3Z01VNW93UW1tR21SL0J2cDNraXBWYXVacm83Y3RJeDRZNGpDTnll?=
 =?utf-8?B?MnRmUjhQd3FzazhDY3hEd0dTZ0xmcGdxN05DSU9SQ3R2UEVzUUR2VjhsQWNG?=
 =?utf-8?B?ZTEwY24yM2ZINEJSVzdhUlBoZHFaQ1E2S3JvS0J4ZjFZMFIrMENPOEc2Qkpx?=
 =?utf-8?B?L001RUUxanVKcVdOSVc4UXJkdEx5Nm5ITE8vdE5XRDhJaXllMkxvTTNkWHdR?=
 =?utf-8?B?WVRvYURzMDN1dGZjYmxIeEdWWTh0NnpnbTJLOWFTYmx5QzhVQnZ5a3IwYTht?=
 =?utf-8?B?NC9KQkR3U2ZHM01DK0JDbGdTQzdmVm1hZmJkSWJod1c5SUhSbC8yS0E1SUkz?=
 =?utf-8?B?aFBNdWlhbllRVXdBMlJ0VlROUjlsV2UrdEgzS1VnZ1ltYkt5T3J5S25saStw?=
 =?utf-8?B?VjV4ZVZ1WDZLem5qNEdIeml5VzUya0FSakVnUDhGcXR6YjNPODU5bWV4UDFC?=
 =?utf-8?B?UjN6UUxFTnM4VUFNS011c2xNRm1TTitKUWwrMEoreHhCaE1jUWFiS09VdzMx?=
 =?utf-8?B?OUF4b0NFYk9QbVkwb1ZHb1NINStCc2xXcXFzME45TEt4RE85MmxzNmxHakJL?=
 =?utf-8?B?MGFXYWVtMUJkWlVLdjJ0MzFWN1pBWll0ZXNlbzdhZk40YlBheC9ES3RLSE1N?=
 =?utf-8?B?WjN3MkZDNGlhZW41TDVsTDN6aFFoUFVQMXRLUkFQSHpXaHBQM2V5bERVclpu?=
 =?utf-8?B?VTJmaTJCOW9KRGdmaXJaMWRTaExwcStscmIrMWw3V0oxdGxPUzNxSGM4a0Ju?=
 =?utf-8?B?WGFTT2ZxK2F3NkFGcjc4Tm5FUFhISFhBZUY5dy9TanQ5VHZudXVUbG8yNkxX?=
 =?utf-8?B?V2J1NnhNbkplak1SbDNWYlpmM0ZxZXkxNVBHMnhsZlk2OVZWeUxQTkkwN0Z1?=
 =?utf-8?B?aHI0RWwyVnhYU0hjeFFhdHNMZ2ppV0V6ZU5sZUx3NlJIMEpIRmdralhBNUp2?=
 =?utf-8?B?YlovOGM3SDhpRFd1NGh2azB1WjJ1MDNkM29pbTV5Ky9kQWNDUzBrM1RzLzY4?=
 =?utf-8?B?U1VIN2ZXZmg0SEVqMzQ5YmhCYjNxTHBlQ0w1a0ZPQnhWYkNZOTVZZEV6bDJW?=
 =?utf-8?B?YUJBcCtpaGp6a1JLczNwZmpsdjdESWp5dk9BVFZqc1NMYUpZT282Nk56QWxM?=
 =?utf-8?B?cE8yMFJDMEc3ODNENGRKeXVaRG9tMm5RUEtRVHhibUlvaG9ra0RSbExlTTl5?=
 =?utf-8?B?akhGaXRLOENJK2xzSEZjeVM4SmJKQjMzamRtRTREOHZ0cVdNWnhKcElFeUtU?=
 =?utf-8?B?a055cFFuN2RKWGk0T0RUM0h1eUYxczYrSE42SHk0L2tUWEFIZ0FLR0ZpalFp?=
 =?utf-8?B?QjUxSEl0bVcwQmUzQ241bWFGUlZXRFgxSDlsZlVuQ3EvT2FhemJyM3ZWNGNR?=
 =?utf-8?B?dU5rdGMzYXRiZ1lLdm1neEt6Kzg2L2wwT2JBRDE4QTZ6SnZkQzRKU0NwVktM?=
 =?utf-8?B?c0c3WDd2c2p4VzBGdW9ucThhTVQxbjgzK2xkRnB6WCsxWHJiQmhaTU43b1lT?=
 =?utf-8?B?UE5vSWpjWFA3bFl1ZTJMMWZ5TVdhSkJmZ1Z4b1RUZWJpd25ZeTBkUjlORnBv?=
 =?utf-8?B?R0srUk1SOGM0TldpV1NadVdzdFlkOHMxNDc2U1BBRy8vVnoxdEVmRC94c1Zy?=
 =?utf-8?B?K2VBS0Z3b3hNcU1CUkdsRFFWRlhSTTNZY0JNYXpwV3paU3JzT0orZTgzSzhT?=
 =?utf-8?Q?TZZnO0jlrGPvqfXrZbzhj83hA12GuWTd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU4PR04MB12026.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVlDV3NqNjUyVjdlRm83WmxjZzI3SEtsNlJCN0JtYmpPcFhtNnEvcTBEQlli?=
 =?utf-8?B?WFhZVDZJL0hkQ2o5N3BlbG1YVzlzUVZSbUpMeW9tbWlzR0V4L2o3UUtWdUVB?=
 =?utf-8?B?SWFqdXVCcHlpbm9hcSs0UXMyZ2Nwcjk3c2o5MUVQbTZSY2xuemZhSFl2TUJG?=
 =?utf-8?B?YjF5cERCWTlsY2NTOHNDTlN0UGJGNXVwQWpZdS9MeHdvNC9FeUs4RU5IMDgx?=
 =?utf-8?B?K1ZVWENPRXpNS1BIQUxhaGxmRS8xY1JoejRGN3ovUHBIVlRHMVlkcjY0L3ZB?=
 =?utf-8?B?NXVQOGxRSDFzQ0JvTDFQQyt1Wk9CMVUxOHJXTS9iaW5oK0ZYcWRIMkJVWjlV?=
 =?utf-8?B?T091L2xCZlBYbElLTmxpZkczQWRBUFhUZDdTUmdqMmNITXFYc2NzUVBPTlZw?=
 =?utf-8?B?UzRBZFFWZUR5QURObjVJR0JoWXU1T3pnQUorTFQybG50cEhPa0E5S2ZhcnV1?=
 =?utf-8?B?RDljamZEYjZHL0czRXRJbHYyZmJyOXZRSVhWdGZyVTM2NmloVUtNQWRkRVRk?=
 =?utf-8?B?L1lOQ3VXVXVkQkx1NjdReTJrcHhuUmUwN09iVzViNDhyemNnR0tvQTVmeWtV?=
 =?utf-8?B?aVh2UUc5WDYveG4xSWEyMXNZb2dPRlpBZkdOR2trb043dDgyTGFSWVArZWxh?=
 =?utf-8?B?VW1WRzJPRU4xWGNtdlBWaEFOMFV2Q25mbS9HN1AvSjZwemMyZkxXelo2bEl2?=
 =?utf-8?B?bHA2YW5sTFJyS09ZY3N5VnlsMkFtV3BNcWhNZ21LUmFJanJ5NlNsWXg1eXda?=
 =?utf-8?B?N1ZpOHNnYm1tVkFITlBtc2haUTVqQndqblcyVXpoUHBmaDdtUkxCVGdsaW5m?=
 =?utf-8?B?d3NOdndBYnZMdGoxMmx2SThDYzJPK1c5Wnk4Sm93ZERYb2dhQ3Rqc3p3cnRD?=
 =?utf-8?B?NnQ2ZDNKNXhBVkhMMmV2UmoxSk1PcnNaYk4xMWJpYXRrMEhFbkZxUVlENWww?=
 =?utf-8?B?b1NhZVFWbkMxSS9nb2xHeE1aZFBZQkY4dkhENTcyTVRRNmQzd1VzR0t2ZWdQ?=
 =?utf-8?B?N0VtWlF3TGhkU1RJbHRuK3lnSU9CWlFWOXdXb05nZFVNR25HQ05zUGVWRUV6?=
 =?utf-8?B?YmlKOStOREp0MjNYNmVyc2x3NmZFQkFTTVJ4VjdkTXFVL3IvUHpvZjhkc2ky?=
 =?utf-8?B?cXhnNE40T1BnQ2lWanlJNk4yTVllc3UvWUJSMGo5d0NVenVwMkdSY1ZyRURn?=
 =?utf-8?B?bG5wQk9udmxtdlp2amhoM3p4T0NQdG1HZlBueWlRenhrdUQ1UEN1cTZpMHV1?=
 =?utf-8?B?M2YwM29odjluQWJJQ2g1V1JRM1RjMzdpS1NhZ09LYXdPWk1uWlVPRm1HN1da?=
 =?utf-8?B?OG9zK1ZaWGtaRDJhdHYrVDVUcTVuMVpLdGtTejcrSGxGMDdPaTdrL01jL2tI?=
 =?utf-8?B?a1VJeDhEVFBtaHljMXJ2ZlpXTVg3U3NDVEc4SkpYb1hyOE9tQmJGeWhmYkRU?=
 =?utf-8?B?MmRZcHcyM01KS250UXJVc0FnSzROVkFCVmx0YzNFRjRuQTMwbVJoNnBiWC9r?=
 =?utf-8?B?R29pd2dDc2kzWWY5dDZyQTVIVGJBVDY0RUpOQ0duTzlIK2RHTHNyOE9zcDRX?=
 =?utf-8?B?V0hCVUtrQ25WdHNZQWEwQVB3MFh5MHl1d3BTZXVTeStqMEZDZGZjWVd5Wlc5?=
 =?utf-8?B?Q2hjK2Nybnp5eENaU20yWDJFRTRwRVBwSUQwaWdEYTRyZ1dBYzhLNzhrUEM1?=
 =?utf-8?B?aWI2UytPWU9ZQkY3NVpUb1RIM29LdEdQZjJiR3EzamNFeSt1blJISkRVM2xp?=
 =?utf-8?B?cnV1VVJFNEpaaEh5aWxFeEEyOTF2NnQ0SFMrN0NxcEQvbTVzd0hoQ2k5V3hG?=
 =?utf-8?B?dDh1YnQvNVhEQUEwVWNNM3hTaXIwQnN0TE9FVXdqcXFoczJ3VHJHQ09VVzVs?=
 =?utf-8?B?aTBQVW1tRzlzM2swOHJqbjNEUFowcVhtUWJmUm1NTjFjc1A5MzBmVzJJTlJE?=
 =?utf-8?B?Qm1GU2ljbEhEZDJPWjhWZ3ZNY3drdHhGekNzOXdYVGpIbUNTZW9IbXdvZkpI?=
 =?utf-8?B?ZmZTbDRTYTNnd2lRRG12UUpjbTlaWFY5Z0tpaFhrN0h3eWpFekdENjlJUVJl?=
 =?utf-8?B?cmgya3orWEQreEM2K1JUQThuOG90YUY2cmJPa1RqY2FkQy9jeGFycTVqdmRY?=
 =?utf-8?B?Y0k2WUhkRCtMelMzWnhQcUtuVEhvdjVnMkpmZDRDZGg1YXRNZzlnVC9tblp0?=
 =?utf-8?Q?wTVQS9v/md0iX/x+QTJ0NKk=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de2d6d8-9017-47d4-f325-08de3281c725
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB12026.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 15:36:50.7153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dnlqRqnkdzKBAWzTnvrq0Df8NP2CF3+4O3b1CWpXimeQvdknX6SvVxGHH/wll3HnCMVW42MzlxupskAGHHw26MFzGxZPRYoSKWP7KfSqcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11703
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

Hi François,

On 12/2/25 7:39 PM, Francois Berder wrote:
> If func->pins could not be allocated, one must also free
> func variable that was allocated previously.
> 

Well.... devm_* functions should take care of this when the device is 
removed (or probe failed), but if and only if CONFIG_DEVRES is enabled. 
However, in that case, this code may be executed outside of a probe 
scenario I guess (it is called in set_state() callback from the pinctrl 
device). This thus makes sense to me here.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

I'm also wondering if we shouldn't check the return value of 
single_configure_pins/bits in set_state instead of always returning 0?

We probably need to devm_kfree a bunch of other devm_ allocations as well?

I see a loop in single_add_gpio_func() we should probably unwind if 
there's a devm_kzalloc which fails?

Maybe we need a .remove callback where we devm_kfree all of functions 
and gpiofuncs lists from single_priv, in case DEVRES isn't actually set?

Cheers,
Quentin
