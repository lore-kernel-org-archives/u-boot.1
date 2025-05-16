Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3450DC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 13:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 936FF8006D;
	Fri, 16 May 2025 15:34:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="V0/VVY4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E1DB80050; Fri, 16 May 2025 15:34:54 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E04EB80050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 15:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkNSPjaTUKwe8NSpPzGBdcf0QwiDNznkHAmcAp6WbBpPl91GWTHZBzf+4NMG7kFzskp7541GQT1IUtUL+0QrtdcHOyGV95mScwE1130DyOILhi4sCD4C9nGTisMndwxIOTZnMlUqdH3n5tpju8Mp4n5QsbexOGXVlDPu+xDxSxD2UIj91nrTc3mHK64mMvFxLAPKkkT9AfUMB4DR37lARs9cmUorxIl63R8QjkjzP1tkORDQlF/wmPpkK4t54EpxiKrPPhia+Zp2leph1CTRYfNhZ6ZzO7OF+FZKtztyMTtrCc8QlyRzDzeIK7HVYXw5yK9onOnkmB6xtqZHQX/MsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7ZXH+QS1arhShWeuyvUbQLRdjim/LsIUOV+SfM1AI0=;
 b=FBkp2CB5m73l5m+LoX2OYMUREe2d6ZSa7FlCBBH1v5bxxI3VK6lHQI6OzzI4fN5zIeuNjtXrE3b5fhi7ln9QObQblPMAO6jciN51ylfehaotBRxW8aFf5CLB2haedauXnUPGSdcMxUhO0JXgfkJpRT1dq9ct+uQJlPY0sRUmeufXKYivmBtFfUb6pVPyOlPpIvv1lEkecwZlejR5D+tgjCML2JOfq1XfLFf1Nacyx1C0hqH+6jUfPW545E4uaSQGIcd5PohxJLRRrXAfGiX1aVu8RoXmyCBV5/f6YKl4b8lFRz+hRBWzjVTdV6W83Nfq/IVQLWwJr1M3xaMYZcmRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7ZXH+QS1arhShWeuyvUbQLRdjim/LsIUOV+SfM1AI0=;
 b=V0/VVY4hJIzN2r+W135lAA9P1BG7r0eW2UotSLNY2BROrOkvsYqb7QFIvPjdUV3u1TrLkf1XRwV+2IIdiLANa25JxwFfrEvH2svzQ7Qfi6GLqIN0bJKFUUrKyIooyLRwOBP8mbxyMPh80/yJTwXykXNAwcHmsTBzk59yOoIZSSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10351.eurprd04.prod.outlook.com (2603:10a6:150:1c5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Fri, 16 May
 2025 13:34:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 13:34:48 +0000
Message-ID: <5a645375-cab0-45e1-91c0-372ff8e8a186@cherry.de>
Date: Fri, 16 May 2025 15:34:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] tools: binman: control.py: Propagate
 bootph-all/bootph-some-ram properties to supernodes
To: Moteen Shah <m-shah@ti.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, alpernebiyasak@gmail.com,
 m-chawdhry@ti.com, n-francis@ti.com, vigneshr@ti.com, u-kumar1@ti.com
References: <20250516114148.3862114-1-m-shah@ti.com>
 <20250516114148.3862114-2-m-shah@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250516114148.3862114-2-m-shah@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10351:EE_
X-MS-Office365-Filtering-Correlation-Id: 6da8d3c2-9c21-4c75-18b2-08dd947e6d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGFDNDBEMlBkZlVVMk1RekowM2UwVHEzcDA4U2VnUVkvem1sWldNTFlIN05Z?=
 =?utf-8?B?MmtuSEYxTFA5UzB6MkVjZERRV1VxcGF2ZjBQdEhoYW1Lc1Vnc1lzdTE1RzRh?=
 =?utf-8?B?U1dveW9UZVEyaWt4UUUyQW1pMzRxMW5HcDd6UW0wcHVQejZaVlJXenpnSWll?=
 =?utf-8?B?UHdOVUFQN3dzSXBORE1qamNUYnVqaG8xU1JvNHNXeXloclhJbVZ4NWNGZkRo?=
 =?utf-8?B?MmZvZ1FJVVFYR2VHdDdlRGEvTXJkaWd2M0l2YldrR1I4emh4d2FiRmh0ZUp6?=
 =?utf-8?B?aC9UY2VnSlFRTnd1ampUREN6RlhqZkZkaE9OT2VWb3EvY3ovL1JmbEFRZ0pC?=
 =?utf-8?B?ekV5dmlaa0IyLzU2QWh0bmMxc2JsS2NOc2JhMG9TLy9vRUZkUWdnUXAwa2xq?=
 =?utf-8?B?bWZuK3QxM1NVQnRhV0c5R3EvWXlyU1U0NCtJNENJcThtMkpoMlNienZrR3lV?=
 =?utf-8?B?M3pKcDFWSXFDblRmeEg5TGYxUitHVXlNckl0RHFFeVpQaytvaUtQbXN0M25O?=
 =?utf-8?B?eHlrSTdjU0U5Z0VaaERlT3NCK2hKRVZrVnNTVXVRdnBEY1ZxQXhYMDdDcDZ1?=
 =?utf-8?B?VXJUUzNYM3ZFZTlSS3FFM3Ardjl0eEcyeTRjZ25HeHFrMzRFUlBlZElBZVcr?=
 =?utf-8?B?cGs1KzViV3hpTUxVVTU5STByNkNoMkNPR2NadHprdXNVd1BqZTU0d01Mc3NW?=
 =?utf-8?B?bmVXM0I1Y0F4dDBpRi9oSzBzY3JjdG80Y1lqa3dxVHQyZkJ0eWsza0ptSEJO?=
 =?utf-8?B?S1BmcDViSFJoUmFyRjA1Vjd0QlRDdmJMOVQ3SHdMNVhwWFZhTmFkczdmRVEw?=
 =?utf-8?B?cDhlcWV3WTcyMld6ODNDNmw4Y0lxUTczNUFzcm5ZTXZkNW9pdHBIN3dsdk5J?=
 =?utf-8?B?Q2VOaGtPc0tOQm51akkydjZEcjNYWTd3MFRVcDk1T0NYdGNLNmtaU0xsMnBZ?=
 =?utf-8?B?YUcvcFhKNUJ5cXEwYlBBVnlzVEtXNXpucVNDRVNSNFVKVmorbDkyK21QVWwx?=
 =?utf-8?B?LzdvTFhXaEoxTFg5U25NVWVjUjd1K3pEUFV5MzBTSkxRL0U0T25DUmlNTFZJ?=
 =?utf-8?B?WmNlaVZDeXpXaXNEVjhweDlCS2xQSlVGbnZKbVZmWmJPcGhLOFhCc1I4b3dy?=
 =?utf-8?B?VVlMVzdEdE1DU3RKYTB0NE1ObTVIWitRQ21oL3hKSDAxOU9oZ0RuZ2tDclFJ?=
 =?utf-8?B?R1g1eG5uMUZuUVRPL3NULzlaNGs2MmM2VklkVDg0aStjNWY2N3ZxckE1bWtG?=
 =?utf-8?B?RklQcDhZZ0JhMGhHMDI2L1NDSEhDY1gzLzVrUEduNlpoZW9sN29wbjZMeU52?=
 =?utf-8?B?bGliUVNRSlhSZ21IS3VSWUhTRlZmWDl0bEFlbFFpQVF2UmhJMFYvclN6MkNa?=
 =?utf-8?B?cGRYQzZrTnNaYXRaMGFZNFMvMTl3SnI5U0grVkZOWDRPRXBZSW5aKzRQT0Ey?=
 =?utf-8?B?MG1oT0hpQkRYMHQ0OGxadnJFVWJIQzdUeSs0Q0V4K3RqYlN0U1M4MGx3R0tH?=
 =?utf-8?B?UHlaUkRIYkV6ejJhL1hVdGJkVk1QUFg3SExYZU1RVHVmcTVpcXg4azNJaGxv?=
 =?utf-8?B?djdXMmdySXZGOU1TNW13dmdZR3hSRS9ESGoweDZRTVB3dUFpeG5HcWl5MElY?=
 =?utf-8?B?ZWkxQndUUFB4Smtsa01NRUpZenBSUHU2L1h5VlFNV0VkVG9RbTVOQWptQ2F2?=
 =?utf-8?B?b1d1ZmNyQzd4b3V1ajh5RHNHTFdqQ0svOGNVdlZQZ3pqR0Rqdmp4dXR1UkdP?=
 =?utf-8?B?aFNxUDZUR0h3MUxBNU9TQVNDTGQ2ZVZlaWM3UU0wVjY2Q2VBd2dkTXM4bGRn?=
 =?utf-8?B?dmVldTJXbUdlRUdoTFNWYUVpcU90azkyRnc1MnB2a0FmQjllNTB6aXJtWkk5?=
 =?utf-8?B?Nm00SWUyT0xCSkI2S3JWeWFUMUVhTHFNUUJXZ3A5ZFkxM1FxOFN6MTlHK0xx?=
 =?utf-8?Q?E9yNnEvFMDE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpoekt0KzFGRXRSSnkrR1pyNEU3OFlUQUc4K2llVXcvOVl0S3JBYmorcnZp?=
 =?utf-8?B?SGlUZkExcXVYaHArQUkvL2pMSytrZFM3Zm5jRGhMUDE5ZDZWRnRLRkNFcUVq?=
 =?utf-8?B?U2lNVWRybENnRDBhRmFWeGRmVy9na3R1bE5hNjN0cURiUzdrN2tNa09ZNHhT?=
 =?utf-8?B?dmljVkFFU3RtOERIR2JjWFVsakJERE5KRDV2bUtuY0dXTTR0WWFFY21hSFh6?=
 =?utf-8?B?REVHd0h0S0hnRVBSVy9JbTViZ0RoMjV3ajlZRUtwU3VONWlhM0psb3VYYTZp?=
 =?utf-8?B?RGNYaXEyandvd2N6d1dRU1lNcmhLWVZMeGk3NEc1RTVnNkk3eFQxNDNqYkRK?=
 =?utf-8?B?RkVHa1B6Rk1sbTd5Z3E3akJ5MmlzaXdqajdmQ0k3QXgyUVhiOE5rOHk2TlNB?=
 =?utf-8?B?TWZ3di93Z3hXZ3BIZGw5UGQybVJXWGNhSU54Y2pKeTNCNmdyTTZQRWpYMCtv?=
 =?utf-8?B?ampRT1dFMWIrZmZ1OS8rQjRHbHFHenJUNk9TNzY2TTBzUW1YWU9rOEJndmZr?=
 =?utf-8?B?a3pnRVg4RGFNdE5SR3pYWTFVamRJTlJ4dFVIUHNCNms5OVBCZ1dOZCtUQ09a?=
 =?utf-8?B?Qm1iVGg5aElHUmJGVXVYb044c2IrYzd4RDZqT25wdXYvdjlIeU54Ykd5NlRR?=
 =?utf-8?B?YUJoMFBRNGRidDVlSWUxV3dQZTdTTXBzUXhxbTR4UTZIY2tPdDRzU2NWbXBT?=
 =?utf-8?B?WHdMUW0vdG9yNkdHWVo4bks4aGNVclY0Z0FpSFB0RlBVWGwzanNKSXZ6d0cv?=
 =?utf-8?B?aFBBZ3I1cFo3T2g2UVd4eWt1VFJMd1BlY0pSc2Q4VE4xVC85MjNOY2FtN2lL?=
 =?utf-8?B?MjN6aStrTzJZRzZsT1ZYL1JoakRUSXhYODVnTXhXaHRwVnNWVUFrQ2hhaFg2?=
 =?utf-8?B?V0VQRkl4a2tRbTNnOG9lTCtHSXFFaWdUZDVKMmxCWllraFA4ZjJhVWQrK1lM?=
 =?utf-8?B?dFFqbnBGc2x3Zmd6a0Y0dDZ3RmpvUHh1NVJTck9PbUtSQkNtKysvZTkwYjBH?=
 =?utf-8?B?V0FiOFRvV1NjNTdZYjFQcUNHY3RtY3NnRkEwYThDcEoxTUhEcjRSQ3BkL0Zx?=
 =?utf-8?B?RWZKZlZNT2plNFRDM0pmVC9rakdFY1ViYU03RnlaRTdmZ0M3b09kZ3dWUkh2?=
 =?utf-8?B?dFhrT1JaNG0yOTRZRnBGRmNJb2ZabDFzTE1WWnRxZEYrVmhrVkMvY29WcElZ?=
 =?utf-8?B?N0JQb2ZzTTRMZm5sbklmRFN5NzRBTjhmRW94Y1FMNWREc0RxWU1OS2krU29R?=
 =?utf-8?B?NUxjVVA5clI1UkpUZzlIMytBTTdUbFIrcWdWaGVpMEF5cHJoYXpneWtXakJI?=
 =?utf-8?B?TkJzNmd3Zkp4clBRc0lFenZEckRVcTNtaU1tWFpVNTVYTjNKbGVLSFZ4ZXI5?=
 =?utf-8?B?VStEcVZESm9NM2F5S2N0SG1ROEtTaEp2YlJ2emJGc3RLQ2Jmb1BPUjhRZHBQ?=
 =?utf-8?B?YXlJNGJFeVcrSjE0ZEpQOEFXaEZYMTNRamVqQTVoQkl0a3gzZm0rbWhQNEFT?=
 =?utf-8?B?UmFRNTJPZ0ZXUnh5a3NTOXN3QlpRZlBUQ085ZFM1dmhYNHhvdUdENjJmdC9P?=
 =?utf-8?B?RVN3VXJYMHZ6OXBHZ1pPSENMK3pOTUxSQi94Rmc2ZEJQVUoyUGl3YlgwNi83?=
 =?utf-8?B?UThRL0U0Zi9STXIxakVWdUhiVXdZYTIzcU5rVXlaK01NaXRSSTdTbEluWk1T?=
 =?utf-8?B?Y1JoN1poTmNRMEtTQWpSWExCWFRIOWtwa2NUb1NMZ1ZwY2QwdzQrUWpBdFlD?=
 =?utf-8?B?UkNZdmF0dE1ndDl3MEJ0MllqSFhZVURlNE9mSEpQenRZRENZTmg3Y1NGWktG?=
 =?utf-8?B?RnJJVkl3MjF6MTNkek9BeDR0R2Q4TmJXRFpDdXNFaDl2dEdQVGcySjhTS3Rx?=
 =?utf-8?B?cWM1MjJ0d2lLUWIxejRmTElGZUUvM3pvVm4veW5pMUduU0g1TDFDaTlUbDd4?=
 =?utf-8?B?bkxrSU5SNEkzeENYUEQ0ejBTdk12cjkzcVBBUk5PNlRNSFFXZExCMFJZVkFM?=
 =?utf-8?B?dlR2ckU2YVNEYjhYWk92Y0tucGEvREZJRW5tTkJsQlZ1NDJFTndVQzNCS3Bm?=
 =?utf-8?B?RDc2TEpZaU5OOXJ3VFRQWUpoWkZZUmJEN0pZbkNtRkE0TUhmOVhGd2tFNEMy?=
 =?utf-8?B?ZXFyR1pkc1RYV2huZGU5Ymt0dlpSa0FCdFo3ZG1QMWpvVFl5ZzB2NzYxaURX?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da8d3c2-9c21-4c75-18b2-08dd947e6d52
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 13:34:47.9384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7x3hFm8lNeUb8BMQcEWl4NYK8eDYzswx/B+s38lV3T5+NTj6t02tgZYTB9g2k6bNSdNvG6789KEezb2AtSkIjDOlab0li7WY9nFOX1+MwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10351
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

On 5/16/25 1:41 PM, Moteen Shah wrote:
> As per bootph schema, bootph-* property in child node should be
> implied in their parent, but this feature is not implemented in
> the U-Boot proper stage (before relocation) resulting in devices
> not being bound because of the missing bootph-all or bootph-some-ram
> property in the parent node.
> 
> To mitigate this issue, add a function to scan through all the nodes
> in the device-tree for bootph-all and bootph-some-ram properties. If
> found, propagate it to all of its parent nodes up the hierarchy.
> 
> Signed-off-by: Moteen Shah <m-shah@ti.com>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
