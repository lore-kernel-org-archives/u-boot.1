Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8197FE77180
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 13:43:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99FF8012C;
	Fri, 13 Dec 2024 14:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="YCJA1C7f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C68F80137; Fri, 13 Dec 2024 14:43:49 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D455680104
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 14:43:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToBONcRqyyUKhOkbF6O3cry2MNoNNOB7mutCMLDSGFl1VrVMQ/CnLPcPSodKKlL3N3uRrJq//EjjOAXs/RLaSas0THUMotddb1MxZMjfB7O56xY/PhnyoUjN4Lv9A/zPTj1umT82hdeMsTm39veCuk/GTv7yerRkjho3h06xZ+SXwF3UXYBsyv+q8Ou2IY1PA43v2sEQF/LNbB+wCu8Oe79U2zvHj+gzT9szOpVU2nXljq/VNHm4BwMCQfJKhAB1Xr+j7JnjY46Wra60Ks1srPv+7eKEReV8EaPthb+VXRTE6Ij53pKUHmc24ryg3PdZ/UkW2PSWIlmWgVo6eloixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFqOAba+PHLLqwa0SceAiTfH8AydAtpVTkDwRdsIuk8=;
 b=txNsLkGctOpy7s+fwUTflxONW3sgDqkP5QQgEs1ND6xIwohCWsnBql+SNPHm3ACQYaDKxp5BcVzxRTuR1ce+es4asSWqyweXZMEEwtFiDz9d1RzTA0h8f9jDpUkkNGYt+w+6Q3kx/N74obm+MWLvpOwOGeT3Z7JrWdfYR8U52vKF/qyPOlAIIaKg/rWMg2VJAhjaC4Ai35lnOwiVOvdFqEOuUtDBe9k7ssw+mSyYSRwT7x4eyUMmsBwX6hJAI+xfFsYoOu7DU771I6wsxdsu2ichStATucNtjLYSoVStMpdFUZ9MxA4SJVVnqd/4KxWyuj21UPLVFHlYqWwng25sow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFqOAba+PHLLqwa0SceAiTfH8AydAtpVTkDwRdsIuk8=;
 b=YCJA1C7f8NjzXCjpL0+AEuTLPZgcAF2E5n7gJ30FsTP4kvOnBlqBlXDv30xPs9im3FwpwsmhBZkIcUkc/2T710E1ej7YbrhmT/OFePVo0mavWIaqXdRCStCx+PXlOyd/ZqpxAgCrHgViyl5dJDTYOEwv9gqeJTDr5edNr+i5Tvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10539.eurprd04.prod.outlook.com (2603:10a6:150:21f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 13:43:43 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 13:43:42 +0000
Message-ID: <e10f729d-cc77-41ba-b165-e32f6e058422@cherry.de>
Date: Fri, 13 Dec 2024 14:43:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20241210222341.3537543-1-jonas@kwiboo.se>
 <20241210222341.3537543-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241210222341.3537543-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0228.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10539:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d8da5af-e09c-47a2-c162-08dd1b7c288f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QjI4ODAveVRpSU16Q0JYRVVxc0VmUGtRZ21ESFovUForWUdlR3BZWjdObyty?=
 =?utf-8?B?a1VvV1pWbE1uNXUwZ2xOSStUYno3Q0MzM1lZTER5VG9wOFJ2Sy80d0lGVTRy?=
 =?utf-8?B?SGlYR29xREdwcjVmZVVvV2JuMU1tcFVFV2R0Wi9Qb29hV1Rxa3VGdUIxWWZ0?=
 =?utf-8?B?bWYwSjZLNi9TRnhkTDFONEdsL1lJR2ZUd0VYZkRuWkpPL3BpSDNhc3hueEo5?=
 =?utf-8?B?b2VOR1VDYnpiR2lrU28yQjEyMm9rYm16N29pZEY0R0ZkejhNdkRVZEdYYjZX?=
 =?utf-8?B?UnZkSVlVdzFyaXIvZmhRSk01a05HcERkemZjTCtnWENwUEJVNnlsMFZkVzBI?=
 =?utf-8?B?cmpaWUZiSGNmWmZMbWkyMEZMZktJa20yR0dOa1QxTlAzSGZMSXQ0NjR0TjVn?=
 =?utf-8?B?OVhkS3NJWGRET3ZEb0FGMmxObUxNYUtlUXJNYjNPdW4xQkNLWERkUzI0amND?=
 =?utf-8?B?VzBjQ0E0a2V4amFGMGhmeXhLdktSYjM4Q21kV3dVRXlIZXJVVnI4Mm44MWdF?=
 =?utf-8?B?QkswSWRDVVltRUFOeEhheFF0OHpqUWIreHRVR3ltcHBBZkk3T1VEaWZhYkto?=
 =?utf-8?B?QUZIays1UXdHOG5VL01UbStWNHkrNFdyRE1CRVZhVTdJNGpIc3lRbGVKajJO?=
 =?utf-8?B?a2hMWDNyNVZDeWo4bHJyY3lmaEtJa0VldmUySThHVWhncUc4VWlDYXFlUlZM?=
 =?utf-8?B?QnNpTjc4eDN0WUxzTG8wYXU1K2wzdHRpQitTYmM4Ym1YbmJLSUlDc2lkTUxL?=
 =?utf-8?B?RHRFK1lqN1RMUjBHZzJKSjdTZkhkTldrRzBka2k2dUZjbzZyK1crSzZiVGhW?=
 =?utf-8?B?NzFlZSsxdERSRm9BVmFqWkQ0U0xXM1ZjdEFZeDBkYUFQbDFPZnByL2xIUys4?=
 =?utf-8?B?SzhzbDh1bDFaUmN0MVBvZWkrNUhZeEY0Y3Azb3JtTXJ4LzJkYzFBUmtxVzRk?=
 =?utf-8?B?blduWE1ZQlFwU1kzYlUvMHBYdkpHUWw0SzR0NXYya2R4OEppck1aUUszNHJT?=
 =?utf-8?B?ZnBhNGZFb3ZKZm1DbWprRjNpWFliUlpETkpkQjE4UUc0cmN3aHVGRFBTM2hH?=
 =?utf-8?B?UDRBbGpUelZMUGhrL2trcjdEOVpaL0Q3NFlwZzBEaDJkQlRPSzd6Y1dhQ1B6?=
 =?utf-8?B?blRIK1lrZlA0b2t0OUc4VjZsZ1JKTFBTTlcvU21UazlJRW9ycGZPaVcvMXBX?=
 =?utf-8?B?K1ozcmNjamJhdG0ybkloUG02L09zc1FXa2NFRVg1cmNSZE5SeXFUZFF0Yjkz?=
 =?utf-8?B?cUJPQXRyQ2JENm1tY3VlZDlHeGh5ekNjcmJZdmkrR0E1OW1XZ1I2c3hMNHE3?=
 =?utf-8?B?VmQrWnpRL0UrTFp6VGxjWURqV1g0bDdJSVBWRm9CcWREaURtRW9OS0d4bWFx?=
 =?utf-8?B?aGlXZVlCYThQS1RrZkw3N0dPVURoOTZDVVM0N3dkZVhNNXA0NHpPUXVQSFNV?=
 =?utf-8?B?UWhNZ3Z0eGVHUGZPV0YvNDJLdStZbUJPM0Z1ZXUyS2lkTmxieURvcmh2R21m?=
 =?utf-8?B?eklvT1h3YmZuY0t3UlVqSythM0V0UHVaeG54K2gyQXM0QzlFZVhwMVdsUm16?=
 =?utf-8?B?QzEwZlAyZzd3R0krZTNtaEI4MVBXMld4RlVQWEFtd0RtQUVMcGNYT2lpRjdV?=
 =?utf-8?B?MVdUTERGS2grSENZRFVQYW8rSi9CMXNLRkRocEhhNGFuWEpMd0hyZFlmOFhV?=
 =?utf-8?B?STRTZXNqT2JyWnRoSUVTV3hjaUFaK2hEV25OZUFZRWVUMTBRaVFLclI1NnNO?=
 =?utf-8?B?eXR3SGk5czFaaWU3M09tSXk5cnlITENoTXZkUHJQOUlGb1BCdkVWNEtwTHA4?=
 =?utf-8?B?NDhYM0owREs3Rk4vaTEvZzdXb2xTd2E2UmpYbW5jZ2tyTVB3YlVwajVjOGNi?=
 =?utf-8?Q?aNBklw7WLKUaj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlByczV3OHNKYVIybFBQZVNSVGkxQTEvOEFrSzluMXd2T2ZETlZxWWk0SExa?=
 =?utf-8?B?bVRIWXRNZExtdWtmaFNKUTVXT0VXY1dCUGVnckd4aVJKRHhZWFJXTU1IRjdp?=
 =?utf-8?B?L09xOVU4c04vMHZ5SGo1QWVEQjRYVWIwaHJ6a0ZySWI4YkR6WGdVcWNyN1Vs?=
 =?utf-8?B?VWwrVG9lTkJra0FXSFZIRnpFLzRlc0dvUHNVLzkxY096K0Q2cnVhNEFpQUph?=
 =?utf-8?B?NDRwV2VYSXpKU2h0S0I4MldFejVVWFNqc3Y5WjB2TWdLZ0tUU1oreEdJZUtE?=
 =?utf-8?B?TVQzUGlLcUlDbW1hbHltSU92NTFYaFR2b2tUOHQwRXh1QXhYTmRUU0lnN2RW?=
 =?utf-8?B?Q3BxbDhsSVBLVnJWd1VTcDE3enMxUjVtcERqWmxSUlB2bys4NUhwdW9JVkFN?=
 =?utf-8?B?UW1wT1ZMV09haUk5TGt0TE0ySmpKZ0Y2TFpMOEdyaEl2aGVoaEd1R0QvM01j?=
 =?utf-8?B?d3ZRR3JpdUR1RFpVU0NWTUhWUDZKU2owRStvRUdQMFFLc1FZUVRicWtOYlZR?=
 =?utf-8?B?VFRyWkpZbys5N3dHOERjMmZTM0huWWtRSkJXZnh0aXB1eE5tZTY3aEJXd1ho?=
 =?utf-8?B?MzlxdTZPYUoyTk16YzBWaW1wejV3TktsVjFQNnExNzF3c00rSGhueXNlSHN0?=
 =?utf-8?B?WVR2SG9HNjFOZGFwa21McEhIQ2gyNjRQaXdmUjdjK0FUcGxRQnNoMmFZWHBM?=
 =?utf-8?B?RFl3WmFrVCtSNGZDR084eDhaeHZKbjhwZy9sWlZTTTlLZkVUMVRjMmZ1UjBh?=
 =?utf-8?B?dWJkMUhxWmZqOTFwWkh6TDVucTB2WmtMeHZoZEVNYVc3NzJBckhvL29kRXV3?=
 =?utf-8?B?UStPem91NWNta1gxNXhJUzAwaTFybm9PNHZhRVRUdkFmbGdhamIzL2FZUHVF?=
 =?utf-8?B?Y1N1YzRPbTRFTGpmN0tyQldNSm1wWnpOcmJ5MnFqNUxlRjF1WDByUDYxMkNi?=
 =?utf-8?B?ZzBXVUtSRGZSdk5nV3phdnNJT1JsRUIxNC9wQ1V2TnU3OStXOTdlMWFUdUFi?=
 =?utf-8?B?NDBHbkF4S1pGVU1DOXFRRllBeXpHNmluKzJ6MmFCMEViWE1xNEgzVE5QL0s2?=
 =?utf-8?B?VTBRL3NNSmkrQ1ZmZTFCZVFPU3ZNVjZYSU9OQXcwd0NmZkxKcWlEUWloL2p6?=
 =?utf-8?B?SE5uQ2lweE1UVTF0OVd5TWw4REgveGthM1pJQzEvYWZkekJ3R0l2aFZUNGxX?=
 =?utf-8?B?Sm9jUmljODVmcVJ0TStaZlVoRzh1dlNWWDdFWEdDdGhrM3RvamFLSkg3ak4w?=
 =?utf-8?B?bkZqTTNkaHk3NUFtQkJRSXh5eFhpZVRZWW9VTElpTlJoWmZ0d1RJSEg4dWlp?=
 =?utf-8?B?VG9ZYzZjV09BMjUxTXpQUWcvU2FpWFVReVpzMFVVZVBBd2czeDhLalg4MWZp?=
 =?utf-8?B?cE92RmxPZElHUEpGeTNTbTZPNmNEYUcyeUJTNHhLK0hhQ0xlam9MOWhja3Z4?=
 =?utf-8?B?TERNUHhWUGRGU050c3Naa0pHdTQ5WjRSZlE4SWZSa0FrUG1Ic0k3VENvTnRD?=
 =?utf-8?B?Nk9QNWdXTjMrbXAxMmNNUEFMODRsa3doQ1JiTmRTZlJzSmxOcFFqMWxCeTJK?=
 =?utf-8?B?NjRTNmdGcmh5Q1pXY1lIY2RjNUhBVmduTlFxRFIyZlRQSVhicFV5RTB5ZTdG?=
 =?utf-8?B?L25tYmNuaFVZdXd2Nko1eGp6dUFrZnVWUkNRN09IdmJ2WUdSZ01MMjM0ck9o?=
 =?utf-8?B?QXA2cTFNakN0b2VMZk1SQ1ROZkxXN2FZcHE5WHUwL2hyV29tbDJ0V2J2bFdw?=
 =?utf-8?B?RXlCK2N0TVlNWU91MmVxRGVqaFViOHlVSmxUckUxZ3VSNmx5TlBGQzBhMmoy?=
 =?utf-8?B?amJybnVvM2s4THd5VENEeXI1SVNPQjk5ekV4OUI3QTJ0UDR0RER2R0hqRjZx?=
 =?utf-8?B?eExQaS9DcFB5Qm0zVzgrSTRnRUNqdWFYQmlibGxxUjhXaVh3bjRVWm5sUXVO?=
 =?utf-8?B?SHdrSFN5dFlvdzhYclZCNFZSTEoxMzVIaHo2bDg3RFRJd2Fvc3plc0J2QzNj?=
 =?utf-8?B?U0JNNHBIbG8xV0p6bEs2c0ozaitLR1NHR2Vaeld5RmZxemxpM2xFbW50T1Zh?=
 =?utf-8?B?SDIzaVprci9KL1RCYlZQcU9wVW82VC9YMVRNVWYrKzdRL2tmQmQ5VE9pOFVB?=
 =?utf-8?B?WEFNK2lyaEEzOHNzeVVQajF0ek5PM1puK1lwMjhNcU5uU3M2a2Q0NHQrUUVI?=
 =?utf-8?B?emc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8da5af-e09c-47a2-c162-08dd1b7c288f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 13:43:42.8752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPlcX1scdSpLX9uJJkKHAO2MPkSK9c412YEVfTRpNFh++6PWfZ/TN9c2t/VLuPV6j9zSOoOXX8XVmX2eqcT0G+XwVOyEvPXs08LZxbaXB50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10539
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

Hi Jonas,

On 12/10/24 11:23 PM, Jonas Karlman wrote:
> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
> What blocks are disabled/non-working is indicated by ip-state in OTP.
> 
> This add initial support for RK3582 by using ft_system_setup() to mark
> any cpu and/or gpu node with status=fail as indicated by ip-state.
> 
> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
> cores and the gpu is always failed/disabled.
> 
> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
> the required DT fixups for RK3582 board variants.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 128 +++++++++++++++++++++++++
>   1 file changed, 128 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c1dce3ee3703..06e6318312b2 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -7,6 +7,7 @@
>   #define LOG_CATEGORY LOGC_ARCH
>   
>   #include <dm.h>
> +#include <fdt_support.h>
>   #include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
> @@ -185,6 +186,12 @@ int arch_cpu_init(void)
>   
>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
> +
> +#define BAD_CPU_CLUSTER0		GENMASK(3, 0)
> +#define BAD_CPU_CLUSTER1		GENMASK(5, 4)
> +#define BAD_CPU_CLUSTER2		GENMASK(7, 6)
> +#define BAD_GPU				GENMASK(4, 1)
>   
>   int checkboard(void)
>   {
> @@ -230,3 +237,124 @@ int checkboard(void)
>   
>   	return 0;
>   }
> +
> +#ifdef CONFIG_OF_SYSTEM_SETUP
> +static int fdt_path_del_node(void *fdt, const char *path)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_del_node(fdt, nodeoffset);
> +}
> +
> +static int fdt_path_set_name(void *fdt, const char *path, const char *name)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_set_name(fdt, nodeoffset, name);
> +}
> +
> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	static const char * const cpu_node_names[] = {
> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
> +	};
> +	u8 cpu_code[2], ip_state[3];
> +	int parent, node, i, ret;
> +	struct udevice *dev;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))
> +		return -ENOSYS;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		log_debug("Could not find otp device, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
> +
> +	/* skip on rk3588 */
> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x88)
> +		return 0;
> +
> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);

Do you have information about what;s in the third byte? It's not used in 
this patch series for example, so wondering if it really makes sense to 
read it and dump it?

> +	if (ret < 0) {
> +		log_debug("Could not read ip-state, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("ip-state: %02x %02x %02x\n",
> +		  ip_state[0], ip_state[1], ip_state[2]);
> +
> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
> +		/* policy: always disable gpu */
> +		ip_state[1] |= BAD_GPU;
> +
> +		/* policy: always disable one big core cluster */
> +		if (!(ip_state[0] & (BAD_CPU_CLUSTER1 | BAD_CPU_CLUSTER2)))
> +			ip_state[0] |= BAD_CPU_CLUSTER2;

That's a very interesting choice, wondering what's prompted this 
decision (which I assume comes from vendor tree :) ).

> +	}
> +
> +	if (ip_state[0] & BAD_CPU_CLUSTER1) {
> +		/* fail entire cluster when one or more core is bad */
> +		ip_state[0] |= BAD_CPU_CLUSTER1;
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
> +	}
> +
> +	if (ip_state[0] & BAD_CPU_CLUSTER2) {
> +		/* fail entire cluster when one or more core is bad */
> +		ip_state[0] |= BAD_CPU_CLUSTER2;
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
> +	} else if (ip_state[0] & BAD_CPU_CLUSTER1) {
> +		/* cluster nodes must be named in a continuous series */
> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
> +	}
> +

Nitpick on readability (to me at least, matter of a taste :) )

Could suggest:

if (ip_state[0] & BAD_CPU_CLUSTER1) {
     /* cluster nodes must be named in a continuous series */
     fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");

     if (!(ip_state[0] & BAD_CPU_CLUSTER2))
         /* cluster nodes must be named in a continuous series */
         fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
}

if (ip_state[0] & BAD_CPU_CLUSTER2) {
     /* fail entire cluster when one or more core is bad */
     ip_state[0] |= BAD_CPU_CLUSTER2;
     fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
}

For CPU clusters, it seems the bitmask matches how many cores there are 
in a cluster. Right now we are removing the whole cluster even if only 
one core in the cluster is broken. But I see later that we only disable 
the cores marked as bad. The dt-binding says clusters are for one or 
more cores, so maybe we are too eager here to remove a cluster even if 
not all cores in the cluster are broken? Do you know what are the 
possible side effects of removing a cluster but still having one of its 
cores enabled in DT?

> +	/* gpu: ip_state[1]: bit1~4 */
> +	if (ip_state[1] & BAD_GPU) {
> +		log_debug("fail gpu\n");
> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
> +	}
> +

Here I'm a bit perplexed. We don't define multiple cores in the GPU node 
on Linux kernel IIRC. I have not a single clue why the bitmask for the 
GPU is 3 bits, do you have any idea or information?

> +	parent = fdt_path_offset(blob, "/cpus");
> +	if (parent < 0) {
> +		log_debug("Could not find /cpus, parent=%d\n", parent);

Any reason for not making this an error message? Are we expecting this 
code path to be hit in "normal" behavior?

> +		return 0;
> +	}
> +
> +	/* cpu: ip_state[0]: bit0~7 */
> +	for (i = 0; i < 8; i++) {
> +		/* fail any bad cpu core */
> +		if (!(ip_state[0] & BIT(i)))
> +			continue;
> +
> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
> +		if (node >= 0) {
> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
> +			fdt_status_fail(blob, node);
> +		} else {
> +			log_debug("Could not find %s, node=%d\n",
> +				  cpu_node_names[i], node);

Any particular reason for making this a debug message rather than an 
error message?

Cheers,
Quentin
