Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65017D6ACC2
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 11:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F68897C3;
	Wed, 27 Nov 2024 12:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Tv2i95SI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADFD0897C3; Wed, 27 Nov 2024 12:44:21 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EB28977F
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 12:44:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DglUPEK3cBP+aoBUyUP6U/JPCmHdM7W8QjGDbFjfYPLGIbPdvSYiLDMVq6wJtF1BbYHvBHyhJlGMrv+kK5EC4cojamKyokCYZvX0U3hIsLaiqicnyq5Fwtqn/Llf/vBxGVCHHQZGtyQOpBntA7MowfhpGPlTvZa0wr9viUYbMPRq3yN5dCBlV0nWp7Gql/qBJFAhyFnbxEIHJz//DmsVmEo4tXKB4Zg8qcx/NW+Yhl8YCKBqmYbuj9h7EFqU3ggVUNFCRKqLVY6X2ZByZnXfSY6SprHE4bMPw3X+g86SZbnRyirAufQsCXkF40KDeDhDhDVVy59RmFcVeLRXF5S/2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOtynAyEgc0KA+Ma2HbwxmOXm8qAKnyh8syljGtwyzM=;
 b=zGZdmcyStR/JRWcRH/UK5MckttQ7tQ97TTIZupb1L0TX723hIptkahM7FRL6xV6Qau+cZNqPYnAyyrzCsPn19MouVNPdz6TMp4LAksGHCW/2WJZtGYw+qgyfCOZmctQBxk/vR+DykSzcMoKBUOfoJIGBOJBqUXzzJHd+Cx/IsxkKXwUUoJZms2ILQ79L7m+MSrIUbAi6S1utCw/SCom4ad3lZ9yJTec5mynEnjK5AIX877T5ESZ+7BCVPpQmWH3TaD/B9XaJdTICKTWTGE4KsbZG/tjf77yqmCRr6prtopBzMvb8Ec1qAG6wcn22KfuXMNHnKezj6mfQ0IJmkYEQBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOtynAyEgc0KA+Ma2HbwxmOXm8qAKnyh8syljGtwyzM=;
 b=Tv2i95SIIZwdwCXAmOut45wdsav9232E3LXTmW/dXizLKGrC8guHhS7vQvMMkMZN1FjQV3oQD6waLcWmW0y15jeWuL2DpiRi2huDrgnrx8ZtQDsCzzeO1mcwEOjxHi9bhDljJ1VDjadQAB/LFzgme9yH8SnSSBqTHn2tz6dFInM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6950.eurprd04.prod.outlook.com (2603:10a6:20b:105::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:44:17 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Wed, 27 Nov 2024
 11:44:17 +0000
Message-ID: <7c03f58d-e804-4682-9850-9bd71de11f45@cherry.de>
Date: Wed, 27 Nov 2024 12:44:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/39] bootm: Allow building bootm.c without
 CONFIG_SYS_BOOTM_LEN
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
 <20241119131844.4078144-13-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241119131844.4078144-13-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0029.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::42) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa109fe-22a6-46d2-62ba-08dd0ed8d32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHZlemNGdUdEcE9XV2xtSGJFbFpXNjVON1VpSWtDTmVHN2ZaTFo2eldScXpN?=
 =?utf-8?B?cmxPM2RYc3ZRK3lvek1sM200Tm1Id3NDUDN4M1RzWFVxdnhmTVd5UWVhek1I?=
 =?utf-8?B?dTFlM0lWTHEyM3dFSDBTeDVkVnNDREdVcUNvQkl2UFFzQ01rNjIyc1oyN2FC?=
 =?utf-8?B?QU1tSkZpdHlId3FoWWcvNkNFT0dyRTl2R0tIQXQrRjJhT1dBNERtNW5RR1J4?=
 =?utf-8?B?MldtWEtzYUwyU1FnQXVHOXFoOExmY0J5Z01qQ1FiSXpScVl1N1JwV1VPUHFm?=
 =?utf-8?B?a3hveGI3Y0lva2xETThlcHA1dnNYcGl0R0Fod204cWtmN0FFNGJKblF0QThh?=
 =?utf-8?B?Z0x1U1hVL1RXckdEaW5tbGhaL1ArTTdYZVJiMW8xSFZtd3J3NWMzZFovQ1Bu?=
 =?utf-8?B?U2FpZVFDUHY4Q2NOMlg5RTR2YVFMdXlkbFVSeUU4ZDVnVUV6dmFZMXg3ZzRh?=
 =?utf-8?B?UFhrQlM3dE52anB3TUFIMFdlM1NUcFpZRjZ6amcrRW1FT0xYYXZwbDJGbWJM?=
 =?utf-8?B?cVpLd3JreFdQWlpXaDhrM21WWnFkZ2cybDJMYmRzZUhlOHA3aU41T0ZUcU1O?=
 =?utf-8?B?akU4UFhLOEJBQWkveFJJOTZLVUtPelhKM1dKa3dlRDNjcXBmRDJ4TktyeHZN?=
 =?utf-8?B?Z1JBeUdXbkErSWVLTDhXZ3NjZXovUTVwTENUWlVjbSszRXlwUEtlN2ZZOEtD?=
 =?utf-8?B?UE1mRVR4c1N6NnpiSHZjNWk1akdqNG5LSUJYd21paGdoeVlwZjRpcFBxdGQ4?=
 =?utf-8?B?Nk9ZbTMwQTV0UDF0N3NYZVlRSkJ5aUllMXp2dkRsb3NKNHJqbzZwUmQzVTFl?=
 =?utf-8?B?eUFZUlgyUTdIeWRUOE94NEw5VzdUREtKQ0pTZktkcDNaUmNtWU43QWErNENJ?=
 =?utf-8?B?Uklic3poNnVUY3d3dGtaWDE0RUxZOExUZ3ZFY2tMcjVoWUF6SEJqREJJcXM3?=
 =?utf-8?B?emlHZ0Jza2JXYVJZK2N1RnVwZ3NlbDZKbVFLNkI3bk4wUEsrWlNCK2Zza3BP?=
 =?utf-8?B?eUdVTEhjSlVtQkthZ3FVU1BJa0ZvWXBFeXYwV3l1MDRvMmVLRElndjB1bHQz?=
 =?utf-8?B?RkFDQUFEUGNVeWI0K1FBR2hjY25JZGlLdE9INnBCWWQ4b0c5TDd2T0J0djlX?=
 =?utf-8?B?WHRPK0NVUU9hY0l3WFlxV2JqQzNybytIWEYwNS90N1pkTTJwQTNJR0FUWW9z?=
 =?utf-8?B?OGRqaGNKNk4rOVIzTVpCSGlzMDBsRDRzSitseXM3UG5KSEVQWUs1Q2xUelpT?=
 =?utf-8?B?S3gxN3pMQVo5TTJtRVBMbTRNa0ZsSEc5eVVtellBUEZ6WHZmazE3d0syaE9U?=
 =?utf-8?B?T0NCVExrUkhQcFFHQ3Q2bjBMMFJ5dVRNS1BnbEsrQXRLMzZUZFdDdTZJSWxt?=
 =?utf-8?B?VHdkY2NMcUNZbkxLQXBVbkxOOFlCeXVyaVNPcWVSaWpETnBTbzg0QkJHSEk0?=
 =?utf-8?B?czYyQ3F3djBEd25IbFY3ZTZMNWJUQUIvaFp4UUtMWUZvZ3lZMWhBVks4d3JU?=
 =?utf-8?B?TU9Wd21VSi9yczk0R3Y1NldMWVFDMFpKQlFrcW1KWlQxNDBSZzFXVUthcGNu?=
 =?utf-8?B?ck1YekU2RWM1dlo4eVJndFNzZnYrUVJPOElISFE3RGFHTEExbTNXdnVINFlM?=
 =?utf-8?B?M2MxTTBSSk4va0FaNXlvQ293dUdBWFE2RmZUZnlkTFEzNGxmL05EN3JUOXV6?=
 =?utf-8?B?L0tsNEVIWDg1OS96TzE2czRqblhRUlMveGEwc2ljL0ZrTG5CMDlpcFVYdGEz?=
 =?utf-8?B?bzdNTUxMOGNjVlU5dGx3SWtwQ1IyUEQrL3dCMFBEMFgwZndlcm80ZEp2SmI1?=
 =?utf-8?B?dFYzcTdOSTFZT0I5K2hIUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXowem9mdThibXVSTXJMdVhWbEcrNXpzQ2tCYThOTXJuQk9nbVVUUkgrbEpn?=
 =?utf-8?B?Yi81RUpTOXRkN3ZXano2RUFuQ3lUTjJaZFF4QS9IYmxwcE5Nbm1iK2xzM3B4?=
 =?utf-8?B?K0dpbFBGOWgrK3ZkVmRzUHlCNzQ0Yi9vOW1Vdkp4S2dsUm85MzVkNy9iY3do?=
 =?utf-8?B?NnVWY3JRb3JqMHMwYWlWYUFad1ZYOGRJVWEzdGFEWlVTV1NWcFlJQjJCVCs5?=
 =?utf-8?B?cEVuTllHb1dKYVI4SmdET3I3M3IzNExxeElLV3dxMlZ6TDRxaDdEd2Y2SHp1?=
 =?utf-8?B?UExIMU53M2ZkNVhZSTlGbXNyYXF1L3hMd2ZQdE8wMUg4bFphSTlpTzdqZTBP?=
 =?utf-8?B?ZkFORURHT0R5VjhVU3htUDBaN0NXYzBmYUdzNndMOHRZaHhGckNtSFduL1Er?=
 =?utf-8?B?L3RUelRTdWVkUmEvTnhlUzR2VkR1VXhTcjBuN21UWC9ZWmk3SEdQSjlKNW1L?=
 =?utf-8?B?bHJnbnd0S0lHMFo0VDBDUGNTaHg2SGpYQ2tJdXpLQVExeDBuZDJSVnV5LzRB?=
 =?utf-8?B?MEdrcDJ6a3Y1NzFORXVBekIrMW5ETGhtdmswblk2cHZtbm1EWk5DaDE3dldR?=
 =?utf-8?B?NUFhU0h3ZUp0YXd3TGRMZml0VWNYVzFCZ3dEZ1JJUEZoY1NqbFJRb3pxQTlG?=
 =?utf-8?B?Sy9ZdnNaTEJLT3VjNWFveDJ6N2dqWkZYZVdUaEhPSHM0dHNsQkN2Q3dzV3hp?=
 =?utf-8?B?QWo1SE56NTZTK2lyZ21TYXBnM2k4aTZndytSNy9GYzdDbVdVR3lnRGhxMHhk?=
 =?utf-8?B?QzNhQ29BK21oc0JVVEord3Z6Tnh5VHdNNCtHb01RamhXVkU5bmR5ZlpmWGFw?=
 =?utf-8?B?K1VQVEZreXJ2N05QTWcydDlsYnRrbEZ5ckNZN2ZZV1NTQUp5WFkvUmN3Q2pn?=
 =?utf-8?B?TjEzd1htM2x0R2FXK3Rvbk0rZDliUVpFTFFFTkhGRDAzajJOd2xxK21OdU1T?=
 =?utf-8?B?cjhiUVpTTzVEbC9hYlR5OUw1MUZMUEM5RzQzenBpRlBsTTBGRm1GWVdjcXN1?=
 =?utf-8?B?TmY5U0ZUR082clBwQ1g1ajZ4US9XeHcrMWFoRWxUNnloSXF1MHpzeEZ5Z0R3?=
 =?utf-8?B?WkovTkQyR1ozRldSenZ0WHJ1Y1RwVS9tK1V2cUMxUy85bTU5MFJLS2xRbGtK?=
 =?utf-8?B?NUJ0amNTd1hFbndXRXoxcVhpWW01amNjSW1ITlAyUFpBRWpxMWF0VGRoQUVP?=
 =?utf-8?B?YTBwalFzUVgzbGFpNHF6VjQxbGxQOHpVd0R0L2IzUnZObWhjQi9paXRqSFU2?=
 =?utf-8?B?anlhQjhaSVQvWG9tVnBETmRZd25OcTZUZmhUcGVmSkhSVlE4blJ1MTZtdkpj?=
 =?utf-8?B?WllBVkJ2VlRza0x0cmxyeC9jbUxaRDV5RzBLNHAzKzFKclJFVU1BYWtKbjBh?=
 =?utf-8?B?dlA4RUR2c0JhaDcvY3I4UXlwcitXSXdjVHd1cGt4WkhWU2ZLNStkWXZiZlVP?=
 =?utf-8?B?YjNmbXB5MjcxVjVIeGxhL1NWWC9iSVVzMUhwSGp4enp1dy85dHdnbmtjUDlH?=
 =?utf-8?B?aWh6U1lnYUxQbWEwaHNGcU50eUx4NVJaOHltMjBHUjcrOHpRYW5pa0QyTHM2?=
 =?utf-8?B?UGtJS2V6bEcyNWRiZDJkS3RGTzN3TndiRmNNZ2h6VG9nd2lrNjBUbVZmYTVM?=
 =?utf-8?B?dmJOYTEySy9KVWpQbjIxVEZkWlVhZXRhekRjOTUrNGdFSlVkSGNDUGRSMlhm?=
 =?utf-8?B?N2lVclptS3ZWNnB3U2Y5MWsrS01IbHZ3MU5oQWVWa05FRlZwVGNrUEl6NFRx?=
 =?utf-8?B?cXBKbHNCZTk1TDlOK1N3MUZLSnJyZlYraHp5TEt5T2Y0WG42QTFRREMzUFo4?=
 =?utf-8?B?eklqRHFNZVFpQXNJZXVLNVZ2Z1h6bktUSkhpYWZJU1NpTG5qWEhQeE5mQzZF?=
 =?utf-8?B?UzJvdGowMXVWTUt4NGJsYklNSFcvUHlBTFQwWk9FaFhTSU9CeTJWeEJhVnZL?=
 =?utf-8?B?VS9sTzNLZ0V2eU9TRlYvajFOajZFODdURld6Mkd2Y1JFRmZ2amxZeVVQbllv?=
 =?utf-8?B?QkRmR2twRm1oN04rQnZ5S3NrSERwNjJndm45VkFETURaUTVVQVFyS2oxdkpL?=
 =?utf-8?B?d1R6cTMxMTd4Vnh2elZBRENtNW5SaEtqTHFSYVBXRWtoR1VERWpLRE5rS3hM?=
 =?utf-8?B?Mnc4WVBsYWJjMlVlTnh4UkJDcmpDMCt1VDJYNWJLQXRxbTBrcjRkVlM2SUVv?=
 =?utf-8?Q?r8Krtd6WNqyHLZP3IE33b7k=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa109fe-22a6-46d2-62ba-08dd0ed8d32e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 11:44:17.6950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GX5FrOLwJb4H9mw6ahoV+GRehXZKSa0nvQRPPU9eGiQGSY0dkuPszcG1CLRBqJ77rJc59gdw2Wef8IMHzizPskAGYvqmd/usWFBmKTJndts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6950
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

Hi Simon,

On 11/19/24 2:18 PM, Simon Glass wrote:
> This code cannot be compiled by boards which don't have this option. Add
> an accessor in the header file to avoid another #ifdef
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
