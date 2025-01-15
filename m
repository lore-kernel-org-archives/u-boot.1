Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F81C02185
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 08:56:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC51880040;
	Wed, 15 Jan 2025 09:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="iqnw1uJV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31BE080214; Wed, 15 Jan 2025 09:56:28 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1051680027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 09:56:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xC8/4zEZxMQQ6sl6IjWZ0YbVrluKvgb26GUjUQu2l2bd1I3WkKpANhEVdKB6G18ad7VY+2TAC0aWUsvodG4WqMS4q05ysI+qMEKx8GL/1vDcUql54/uBtzGULesQ2yykxUgInqx+FVIKlWqipF1D0kFieZaI/gDCu/xfhP5emrQpyzabOLFHmy1TMSa0cvVzLkja8Zac7pIkeQWyCEATZdQKtgqj9MA1Tp42Zsq0+wiy+rrO4Dt0jOBsC6mBz6pS1CvHlbbMnUsqCjjRZxXhfhmRRSo64q0maghcUYLZw/YcQEhdTkpMWyw/ymsIxP4eC4x067viXLcRJ14MUOodiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0p/5eo8flPTAfXRGdUXsfQchh5q9KkqwnXAu+02G6OM=;
 b=ehwxVcMdgWr6/puQ5ANVPCyVcCT+rUqvswC7SHICVaUDSxKhxNdV1QXiJn12nhe6dFelRL/UNgdvTdjYK8eQqk178BrGsZbTBSdE1t9VfaYV6hsNhKICpaNarLQ6UPOWDxIg1mvyjv2Kl9GqDdFp7FIRb6Ana+TFdTHBpL4jZ8zazLxhkx6G9psSOHaRtCOSgBLsDMggACYV/sckFEUDpmCfzX2y5Jg93U4geNkYvlWX4uss/Lum7jIN0V0camt19IGDPePDjb2p2up4oxXwsQup5m0gdgZQljnwAi8Q77y7ePVGkVc6E3/VuOA7LPoAFRtHIZe9lnbiQy58HY5l7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0p/5eo8flPTAfXRGdUXsfQchh5q9KkqwnXAu+02G6OM=;
 b=iqnw1uJVcC5t1fbs9j+ohh+Ss50abZC1p+GHk6FpwBBd4NxW3wVscmn4j8FuCX7SvNNuchQeojegP4d7p4ZCidd/v0VvQI4rLX0cmNTWaFkn6aKCYh8zpeVHN5Q0XIU/2hDkBCIj4vxrPwrbsm7bJlUfSiDjs3vPoxIZtRwZHS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 08:56:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 08:56:22 +0000
Message-ID: <5db5d1a6-9855-4ad6-8f45-1a31ded4c339@cherry.de>
Date: Wed, 15 Jan 2025 09:56:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: nanopi-r3s-rk3566: disable unneeded
 CONFIG_NVME_PCI
To: Tianling Shen <cnsztl@gmail.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
References: <20250115053705.911296-1-cnsztl@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250115053705.911296-1-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: b91ad1b2-fd8b-49d4-fb9b-08dd35427bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c0dtbGNCd1kwcldMOVZKOXJJV0dBa05mbnBGU2N1a0NkcmFpNkYrVzJrWnkr?=
 =?utf-8?B?UVBTQkUwNVczWUtXeTBSMk1ha2w3bDE4bWZ1TSszSVVtT0lYVHIxWDJRN0dk?=
 =?utf-8?B?KzVuYU4xYmUwSnNoZk5CbTc1NTcyMEQrelJRVFZseklmOFQ1cW53dW9VVDQ2?=
 =?utf-8?B?UkRnaWQrYkZtTFRZZTBydDIrb1YxYkJLV29OVDVIbHBiYWpQNEhuUEFIRURF?=
 =?utf-8?B?NGtEREZGRDV5VnQ0bnRWYWNYQWhETUM4MVpFbnBRdnExamhUQ1FQN2s3L04r?=
 =?utf-8?B?bmZLMnhYM1VTc0p5a1c2aTU1UjdKbXVkUlV5TlhzNC9kSUVZOXVtK1phNnlU?=
 =?utf-8?B?aWh5K01XcTh5c25DK2RZYlNqR3VCRjZHd2c2QzRBeCtaTTMzeHF1RzN0bVV2?=
 =?utf-8?B?RUZ1TWJUbHk4Nk5lenlya2tYV2hLQXNtMEdwWmhrWGwwcGY2aFFkRUZmRUhX?=
 =?utf-8?B?VzY3UmZWUExrREJTRnVrakM0YzI2dkg2cjhwOUpmbklTR29JR2tBNzQzVFNp?=
 =?utf-8?B?bjhjK1o2anEwck9Kbjh6Uml2aVlwVC85MDEvb0N2TFFmc1ltTTNGUGY1TmQy?=
 =?utf-8?B?UWRvdmVtWFYvWTIrYlkyWXhYZzI5UFJrMUp3RTVSS1Q1OFAwSTY0cTNjU3gx?=
 =?utf-8?B?djRnOFYxditEcWlJN0MxR25wUkgzc2RPc0paTUhVdFJNcUZGcGhJTjhrWnpV?=
 =?utf-8?B?dDhta3RwRnJYUE91bkFlcGZYSGdwNS9jMEJOdnNSK2ltOElmMTZHVWs1Uk5l?=
 =?utf-8?B?MHd6c013STRNeXV0ME93cklnRWFOMjdLSDhVYWVNcUdhaHg1RGhJWHdpQkZr?=
 =?utf-8?B?VEJzQTgzNVVueXlQYUtVRDJ4TStYaGhNNzIwajFrTVYyaEo2aFUxaUhMMzZy?=
 =?utf-8?B?ZnV4S0NkMmlnU2YxQmVRMDMrNDZJelNRR1pzNzZaalRUTjcvZG0rbll6a3I2?=
 =?utf-8?B?Qlc2S0xXam9HSTBtQis0Zis2OWhVZG9SbWp6QTRyeUt2NW9aVGZyenV1MHJt?=
 =?utf-8?B?OFVXTkE1K0V1WG1YYXo2TzJQdEg2eFVub0NTSTR2TjF0am40NkY2M2V1STk3?=
 =?utf-8?B?VTRYdDh1SEtqUFN4WC9lekxpdmRhU2NYeGVkdVNTWlhVcEhUdFp1dWN0Zm5X?=
 =?utf-8?B?TVNaclFLVUJXMDlzN1FrMEhWY3NZRmZrZ0dZNmtHb0lGUlFRUTZHbUNQUS8x?=
 =?utf-8?B?c293VTRDYmZLQWtzYU9tNnR6d1pLZFV5ZGVrYTl2S2tHbUg2MFFBb2VqbTJM?=
 =?utf-8?B?RGl5S2VTVGhiNE5qNk1na0JmNUZscTgyenZuR1h3eFQxaUQ0RU0wclJudmFw?=
 =?utf-8?B?ZVI1WERTSGovWWMrZ1lQTXBPQ3VRK0tZSFBIUld0enN6bHZPa2lhdkZteDcw?=
 =?utf-8?B?RFhRd2pUS2ZQK2h4WDdsZ2hjbllKV2Znb21MNnJmTXRCc3JUenYrVmdEdWsy?=
 =?utf-8?B?MDFlOEYrWjE0U1MxVitrbk5ZaVltVlA5RTFXR1Y0eU1VWXpQaGpod1c3Nm9j?=
 =?utf-8?B?TGwrU1Z6cTNSVjYxSUxwMFUyYkdVQlRtTHVHMXA5UDdOdXlTTnhqOXptaVJU?=
 =?utf-8?B?YjRINnd1ZnU2bGV3emhVQU5FdWM4L1U0Y0F6MCtKYUZTaHJlTGZibEg2amlj?=
 =?utf-8?B?SHBZaE5vY1J3REpnTnpKZDlScUcvNjNYeXBBMnhkemdTL3kzK1lWbC92TFM1?=
 =?utf-8?B?VnBhWGxpMXd2cFRkRFdMU0ErWHhsSVFmalVsTTE5eWhDN2xsMCtTbUJEdE42?=
 =?utf-8?B?d241VmE5Z0Y5ajhuQkEwckR5akFSc1A5SU80d3B4cThiL0lSTDJUR2k4TG4z?=
 =?utf-8?B?azI3alBtWTlaVlNhRk45dEVjVC83OWhVRzRQSW9PS2h3c3JjK0ZNQTduTTJQ?=
 =?utf-8?Q?6PNTrUkzgxTyJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDl0bldVcFlqcHN4eGJydi9CMi9kUnRGSGNScmZGZmJaRzEvRStiZDljOVZi?=
 =?utf-8?B?Q2N6UXBrUFYrblRFOFlhdmZaY2VPV1J6U1NSOEhIaWwrUVZ2R0FjSGpZVVU0?=
 =?utf-8?B?SEJmM3VMNDhEZlN4b3lvdVp6WVk3ZEhOcGpvRWlVWW4yOU1hRXNpUDZkalEx?=
 =?utf-8?B?QldQcGUvKzBUUDMvWTQ3eXU3M1EyaTVOaUFKV0NCL05CQkREdFU1NE9xZHBy?=
 =?utf-8?B?VVpob0RjcCsxZzc1VmtialRUUEZqazJzbnhvTEpZY0NrTzZtSjdBK3g5bGxN?=
 =?utf-8?B?UzhuamEvR0ljN2t6aXFiODQzWnNxa3BEOCttT3Q2MXozV2ltd01yTUttK1hU?=
 =?utf-8?B?SDZQcXNYOE5UWlBZbXNhU0pGN3A2ekNOV0tjRVBvd3lDL0NpYzlSVXYrN0t6?=
 =?utf-8?B?NXpRVXRxaVZMWmZqQjNURThrc0F4UDZ2WUcrZWlmMjgyRWZmSUZuNkhKa0Zu?=
 =?utf-8?B?a2hIQ1c1NFVZMHMxeVJudTJxc1l1VWRIUmVhM1BnblZxSmFoZ0lCdTZMTE05?=
 =?utf-8?B?MUVyaDVoV3VSVys5SFlnS2dVbjJwUkt4VjVMSFovdkNqaUNUUllkT1hqakVh?=
 =?utf-8?B?UWJ1d2pzMnplTkdPTmM2ZHJtd1RSMzJZWm1tSkNDTFpMVXpXdzFOb2d1eExC?=
 =?utf-8?B?UTMyWm9NTEt1cThzdjZRTHFKSXpzd0tHaFRhR1pZZnJWVEtxQUMxVkI5dXhE?=
 =?utf-8?B?QkNKbFFCQVNVUVdEM3F1bzdrSGNLbkhOM0kvS1F3VGhPQTAyZFNKZ0tuOFRF?=
 =?utf-8?B?K0x6Vjh4NDE3aURra01DUTRuNGUxRTU2SUp2OG14YWV2emlhNU1VZE0xRWFT?=
 =?utf-8?B?SWJLYWRLUko3ZnRUQ1lFMlJKcTArY1loUkhwaXIxcEtNY0xDYlpDbGt4NEp5?=
 =?utf-8?B?QXdCblRZdU13bUN4RTlLekt5SjhRZCtNR2t0cEs3WFcyOU1GcHJYRTd5V0dy?=
 =?utf-8?B?bFNra3l5YmhhQURGbkFISkVXbk9qU3ZFTGM0dGFNTzZhUTFYUFRKMm5wSTN3?=
 =?utf-8?B?VDJ4OUNqeUg1NVp5bkxtdm1LalZKSXY4cS9nU1JyWjVWVnhzV0tnWGN3ODBw?=
 =?utf-8?B?MDdBQThaaisraWNiRldRRmJqRmJFM2loNy8zSnhBNmlkVURtWWMvd2xJdVZW?=
 =?utf-8?B?UU5RaFJVNDJ2R25kTnM2SHgzZFFWZXJkOGtTMHdhTytUS2ZiMzU4THMyaDh1?=
 =?utf-8?B?K3Y2L0ZKQmdxK2NndGhRMHdqOHYzZ1RPQU5ZckdXY1V0aUc4VXBxNW9wcjNr?=
 =?utf-8?B?NG16YVdvZVdVZjRZUDFzRlNIZ1NHcVEvZFVHNElvdXhGSVVQL0FVemJpTFkr?=
 =?utf-8?B?OWRHVHU4WWVOTFpSYXdvWU13Y202YWIwN1Jha1FMNXFLV1ZxTXg2dEZWTzFT?=
 =?utf-8?B?MmcvN0JWRlJNNmVaMWEyajFOenBWdHZ0N0szeWR6ME9Jb0h2anF2NEpqc210?=
 =?utf-8?B?YjJhdUtsai9pdkZ6bmpsSnFlLy9QSzExbmVaRk9iZjRIaFU3MXNZUTU0Z0Zr?=
 =?utf-8?B?eXEwMmFyQ2psd3BvYm9GMmZQYXdaSnZqKzZMZ1cwVjdXbXU1TFZPaktMOWMr?=
 =?utf-8?B?VUNaMDN2eng1WDlxc2hFdFRJbEJqWXRscVVXdDJMQjd6cmd4ZEdTaUtJSG5R?=
 =?utf-8?B?R2xucHpZdmxZSm15aWNhY2dUMlAvMmtXNW5kY1o1VlJYUW90dlFSQzU5SGh0?=
 =?utf-8?B?bHhnUzBSaXpOWmwrNTR4Y1NFS2l6K1JFVE1kOUEvOU8xRmNkZUI5SWxIM3ZK?=
 =?utf-8?B?R2l6RnhyV3htUTJBaFE2dnZ4V1VOOTVtOGxvK2RleWR5U3pZUGZkcUlKTys2?=
 =?utf-8?B?Z0lWdXVEaE9hcS85N05KUGVObUp3ZnJLbkpaQ3FXVGU5Z2xrb3V1YUhFZ1U0?=
 =?utf-8?B?aFlsTURQekUvREVrZlZ5L3hsc2s1OEZmdGhsT3BkUWtHWkErVm40eDZFb3lG?=
 =?utf-8?B?ZS9IZkIwNjRsSXkwWFBrT0pwMzZTSVpzN2ZuS0djQTdhcDRUMlFDQzNPcVRR?=
 =?utf-8?B?T0dFSnk2amlBanlpRU9mdk5tTVZ0MUcrTm1VWGV4SU1kY0l0OHQ1engwdHNa?=
 =?utf-8?B?Z2s3bDRmZC9vdkx2K1RNNjJZeDlkQzQwNG5iQXV6Y3pDNWluM1hIQ3NEWkpP?=
 =?utf-8?B?M1NPdkYwVGhhQktYbkh6dXV6cFJ6N2wyVkpsdjNVTWd6NWRObkFNOWxXNXVx?=
 =?utf-8?Q?Xuc3AZEktikUtnkFgiKaFhs=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b91ad1b2-fd8b-49d4-fb9b-08dd35427bf3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 08:56:22.2872 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWV6u0xamG220FFA11jPFipScoIvisH8lWxjea9TKNIaMB8lu+3gIISTJsy3t+zaz/tk/8lx20iyssObQhdZY8G5qz4lOmchj4ZjiWFHRuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499
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

Hi Tianling,

On 1/15/25 6:37 AM, Tianling Shen wrote:
 > This board does not have any NVMe slot, so disable unneeded
 > CONFIG_NVME_PCI option.
 >
 > Fixes: bf4a33e725ae ("board: rockchip: add FriendlyElec NanoPi R3S")
 > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
