Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14600C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 14:13:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9FB88874;
	Mon, 15 Jul 2024 16:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="JTA9H1ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8EB87B84; Mon, 15 Jul 2024 16:13:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB13E888B7
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 16:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3mBmz824RASnR+FBgMNQNOk82h0n8SKopTJV0vjcSAoLfaWWoQcG8hlidd+0BfHtZyV/UwA+9kt862a14dciMQlwNN+eDm3MEGzJ782IYXYOy9mt7CJMpoWVOu1QEoYlgmItLUwFw+LbQzcTNbUMF/Eolze3nglsFwTZA/xO8PI3VRiJH0jQvYtNnwGt1idTn2OKSSnWyI04MZbXTofd6GOR6aBAQkSpOTtD5dhNBAUDUB5d8sw1GkSx8WM6ksJdK6F6qlAEnQd8Dvfb+7eBwGcRHRzRtxsCpQF44Zc8ue/MDPHSdWPJuKQnrfwdDe9FBKi7+8gui1hCks7z3WqYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHGPFxLMojDRikxJH5eOWgySyt+619tBgiGd6+LRtiM=;
 b=xkzhh9dIcho1cAwmRghUrFKUYdsWSfm7DvV7bL8M6T4yAdQHg04yRrqd6JARfPOlFK9Ih8Mjx1x4/MOFs+BZ0wGIB75iDJ7BGU3aqcrDJoKbuGO7/im9D7ENfAk6LcINP7Hsb18IzoB5VABYfVO8YVR10wx7gs0PQSa03WuZGj98J5sdt17taFVYCRz/GYnUsZtEGpaAHpLJgD0hbZumr4qoGipsljUrVFUMD6TCiqLuyAzpPzWulQqkGuBi0b/HJg2gJqvqUNcH7pA6OdsfJlVQmfU5QpTA7LmaopVgrzWq7S7bOWqRIKOvZXXzo++yXFdsM9IlnaZyUTxxCm5E1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHGPFxLMojDRikxJH5eOWgySyt+619tBgiGd6+LRtiM=;
 b=JTA9H1wwNO8kV/jPGYGKGqPM0z6hbWiyrybsMSRM6iPQN2yBCH9mf/kr8oWPbz8nSfJxXF3LOlfrSBDns0v2KgG5Q9cnxbkyO2Cxl6E4oZ3vTw4E0e4CtsgWFmWv2boKlh8BBUnSlSm/FJFwCVxh2BXARJTBfnG5LFPhrUJ9+Zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10885.eurprd04.prod.outlook.com (2603:10a6:10:587::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 15 Jul
 2024 14:13:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.7762.020; Mon, 15 Jul 2024
 14:13:25 +0000
Message-ID: <4fbd50df-fddb-47e5-9d33-8f57557cb3ae@cherry.de>
Date: Mon, 15 Jul 2024 16:13:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] doc: Add a description for bootmeth_qfw
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Nam Cao <namcao@linutronix.de>
References: <20240715101354.97895-1-sjg@chromium.org>
 <20240715101354.97895-6-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240715101354.97895-6-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0117.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: ade874e2-19ac-46ee-b60d-08dca4d84aee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVFBQkN5QlRFREdoV1pmcGsxTVFjTnBkbW53VVlBVWlkWmlFOFFJWHRuekR1?=
 =?utf-8?B?YUI1RS91cm4yeHBnZ01YTmdOWFVIR2p5cGZ0SjhnWFZzZVovTUlwMFJWTjhp?=
 =?utf-8?B?LzVmKzY2WGVYaWo5UDRkZUpha3FDeU52SjRnZWtMV3BKbWY1Uzk2M1FkbS9i?=
 =?utf-8?B?bjlKYUkyYVphb0o0TXZDdWlLb0xucFIwZHhJTmxyWCt0V1RWWHZFMFkyYVE2?=
 =?utf-8?B?cWhQRGJIK1FGQ3duTHN3M1RsRTExSkVRRjYrUzNpdkFacTlqRFpMV3hRdHdW?=
 =?utf-8?B?YzNtZFdmRk8vWWlhelRib1dyYi9xQWZjaEhsWTdRT1lTZVJuYndDdGcrazBG?=
 =?utf-8?B?Z1Jib1FCUjZpV09xc2RBeExWQ3kvbTRrYzU3Q3Y2Q2lmOHZQb01JY3VXWHM2?=
 =?utf-8?B?OTdWSVVOQVA1enN2YVVaOEJVbGgrTXc4QURydWlSeHlvcTVHVDEwY290NFRi?=
 =?utf-8?B?RUcyTWkxTjhBY0NhSWRWZC9PdElBaXFuVzRadDczRnR3Tk00bDFrL1p4NDRJ?=
 =?utf-8?B?c1RQUU0zZGFPUmRvdEY4Z2c4N0toSnNLUkZYVTh0Q1pmczU4dUg0cXJwUUI2?=
 =?utf-8?B?Skhza0oyUkR5NG5nOHM1SkV6QTZ4UXpYVUMzelRxK1NCbEN6eXlUeGIzT3kw?=
 =?utf-8?B?eHZBZmtGaGZmVVh4bi95WkZsQU5jd2VKQ1UwZ0JsTmg3b2F5Nkg4WGdVWFA0?=
 =?utf-8?B?SmlqRjhHMjdaNEYzYThlVFZCVm9BaWp0cTZxcHhpcUx3WW9iVkZKY3Irb2ZV?=
 =?utf-8?B?VXhQOGNwdVRLY3JYSmJsc2JocDIxL1V5bTlIakhrbytEaFgvNDBxWXZKV2wx?=
 =?utf-8?B?THdHMWY0T2YrR2RyS3Erc2ZMT2pCQjRlOHE1aERPOTgxT2ZONXNRaFJaMEU0?=
 =?utf-8?B?OVpRcUF0eXRtalY1Q2VDTWMxcytLeFlsZzhLc1JJTlVqNlZSNzFhbEgrYlA3?=
 =?utf-8?B?SDZLTmJ0Q1h3cTVMMTFyaXpMR1pKNDZ0Q0V4MzVxNkNpL2Zydk9RWkJpeGRs?=
 =?utf-8?B?dU1LdE1mcldCUEpIOGZOSWhnWGxlL2NxbVlueVl5UzRGZzBTZk1GL0ZYdjlU?=
 =?utf-8?B?SmNtdzVwYUFBWlFwZ25nS250YUNXT3dpT21TcmROR2lqa0svb1hPV3lNdTQr?=
 =?utf-8?B?dDBzcDFMTzczdHdpOUZJY3RHTW1ySHNEajV3TktOUm03allXSThrMkxFem5r?=
 =?utf-8?B?UjdKbFc5emlic0NaakUxNDd5dnlNSHlNTmF0N0wwNnRTbEhON044eE8rV0xB?=
 =?utf-8?B?ZlZXQ0VMYjlDcFJiSnQxUnFNT2pCQ3h0SzRTcE1yL0dZN0svd3hOQzZIRlhC?=
 =?utf-8?B?OHFiV1dhWHhRSkorclZHOWsvZGdBMHNMR1grSHBEbldDR1RIdHY1cE45QmR6?=
 =?utf-8?B?OTllbFpXRHhvdnN2a25ndEt3Z2NXelkvaE1TNTJhdTQwc0lOcnVKSmVjRjNh?=
 =?utf-8?B?MUtrT25OaDVibFRYQ3NndU15ZEZ1RXh5c2w4SFRBcUl2bjhtZlo4eEszaStl?=
 =?utf-8?B?amxaTWdrYWd2YkFEUVFIWXJEWlNmaUdSQW9EaHZWVnRrc2hUMUg5WWtpYVRi?=
 =?utf-8?B?Z2ViSDBLT2lJbGdCeEJud1VLelFna0RyZHgza2JvVjVqeGhlcG9mR0tQOFNP?=
 =?utf-8?B?RTZsWlN3bWlwc0dKNk5TQndRRWVBdThlMzNCdW1xRVR5OEdXQ0JibUFjL3Bi?=
 =?utf-8?B?alg4YkVwRzVjRHNKL2FZQXlCY2tPZmd3aDY3Q01rK3NLeFhqcTdFeWJUVXhq?=
 =?utf-8?B?elZSdG1wb2xCN3UzUy8xSjZad2R3WklGZjkwMjAwT3NmaUFTekxjWlpvcTRH?=
 =?utf-8?B?dE9YdlUvSElGeTVuRVUrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z09IajZERVFRTFRNMEViRWpDRXYvd0ZFcXVLZDA0RXJzaTFvdVVwbllycTBG?=
 =?utf-8?B?YkhibEJPbDVYZXR1ZDEyVGYycmVOUWl3OTg2WThhTlVEcGlKYWNFMHo1SVpN?=
 =?utf-8?B?NytoVkFySHZwYkROY2tYR2ZGbWpwNmJLYWkrTHlFSzJZeDYrckpLTUJQNHUy?=
 =?utf-8?B?anI5ZnQydWxxY0VtNDE3d1h4Q2x0cG1DbENEcjY1WTBtN2I1Zm5vdkF2RmVl?=
 =?utf-8?B?UHNtaTYySjRUV3NPMkt1enhnb1B4dGpNc2l4ZC8vQ0lCSGtFcHhaV1FjajIx?=
 =?utf-8?B?UzE2a0x4UHUra3RFTTAwVG1XNkxOR1MwL2FzaDRSMFY3d2dTYkVzeXV4aity?=
 =?utf-8?B?UUthSjUrT0lSbFlrS2tqTWduY1NoRXB3bTRVMGt1Y2RhakgyZFdpbm93N3Bi?=
 =?utf-8?B?V21sY3l2aDZGWDVJVWIybWp2aHFGUi9uYWRsL0FnL3IzMnNsamp6TUY1cWZj?=
 =?utf-8?B?djRMbnkxcmlXclA0c2MyRWtmenlXUlJFU2tYdnR3Z2locjZrQm1aYU9OWUlW?=
 =?utf-8?B?ZUZxK3dKQitlM2RYQ1Vnc1VpSlB5SmhQNzQvMGlWODFKNVBwWFRONHJ1N1JN?=
 =?utf-8?B?SDd0MkFBZ0k2NXQyTEtOOVhhWmVvK21PM3ZTM09WNHVua2E2TE1jdlZSSjB5?=
 =?utf-8?B?clJTaVA5Wm5EWHNlTmk0KzRqTGx5S1MvbjcrODFqREluTmxBclRJdXNTalpN?=
 =?utf-8?B?YitmZGxvdy9FclI5QzNiK08wcWpDdUFQMVk3MWNYQzE2dlNUQUxGbitiNHVI?=
 =?utf-8?B?Y1NkNmMyUURSNWtFSVAxdk5pS0Z5MWlwYWNldURoSUdEQWFyZTJVK1dtZzZJ?=
 =?utf-8?B?aUNaMXZNTGFxVUFHWnJqdVVmRU1DUWwrMXQ0QWlvR2pESFZtMG5aV3FPSFdl?=
 =?utf-8?B?ZmlmSEVUcy85RTFSSHpTdlZYR3RtZ2pxYk5mYVpZd003UkpKb3lZS3lQRlhz?=
 =?utf-8?B?VjJzMHduRDJXYmFKdnVCbXd4RC9STTVBUUhFM2EzUVZocDlGU3BwSWI3eUdR?=
 =?utf-8?B?Si95MDlDWFZhNkVKUk84R3JXMzI0TnJlUWZrR1htWmRMbkFVS3VyZDJLNmdC?=
 =?utf-8?B?V1pwVkRodW5iVkxmK1ZaMWhmVHVWYnBsUVVNUkg4ZFAvYm4rOGY1WStIWmZq?=
 =?utf-8?B?dzhZNFl4YXVXUzJXcDRUWDZTckk2MWJ1ZUZKUnd6RkxJa2dWckVWWHJjcm1u?=
 =?utf-8?B?UmZMYThPN3p0RkNIQ2lzRHBBNGpuWDJGMVRZay9TUk5iMncyQ0psT2poL0hn?=
 =?utf-8?B?REVSRk1ZTWNQeVIrUzdrTFc1bDNuMEYxVHRVVW50VGRodm1GaDJwVW1jdDhy?=
 =?utf-8?B?clhMM2ZGYWI1cTRSbU9neE15aGprK3lMUGl5RXFlR0txUWI4YVRwTWF0bmtt?=
 =?utf-8?B?bVlFZFdNc3RFTlRSVHFNSlo5eC9yTGtFZHJ3SlpEcDN5VXZjTEN1UUhlQVV3?=
 =?utf-8?B?cVlrMUpVY3VjaUc0TmRRRnlHM0xxaVFqWkJCdEFhZ3lCblRwRGt6bEtiZVlT?=
 =?utf-8?B?bTVJSkdueVVSQ3Y0VnYzdVVVZitKb0VBSnVmNTBaRVFoYWJTYmk0dGZrbUxC?=
 =?utf-8?B?ZUdjZEJrZzBQMzZYYkVmeUJBYnJGamZDZEhzSFlHZ0JhVGUyc3M1aFZ2bEJC?=
 =?utf-8?B?MjYrS2IzZ3czMTFPTjkrcnRpYml4aTh5ZmxMZHdEQ2FGZTVDSmpvVDAycHlo?=
 =?utf-8?B?K0pnTnZFUDlZOHM1L2ZuWXVGYk5OQ3BIS2FTRHdhRUVyYys2dENrYi8vRHNx?=
 =?utf-8?B?ZEtJVDRoN2pFQU41eE85L0ZmUkVaKzd6d3BKeklIaWl0R1NzQTZsWmtFaW5U?=
 =?utf-8?B?d044b05vWVpiMm9SSHdKc2FrVnFGb2RqalJkUjZrVkdmYmxGUEhlRlk3dmRu?=
 =?utf-8?B?c0dtMmpBU3NBaVZ4UFFKTXI1SUVJOWZWQWkzbXRuOFVmSEdXS005OWRLRi81?=
 =?utf-8?B?aXBhY2tpSjZ3Ykl6UmF1aTNjS3UrSWtxaW5FRTAzNFBwb1EzNnpYbUZpSGhW?=
 =?utf-8?B?alE2bFpEVEdhTkYwNXI3QVkxUGxVMDZvVEYzZlRvcDF6K20xenl5RlhWcVM0?=
 =?utf-8?B?b0lkNy9qNXYxM3lMRzR4NndlaWtUOHBvRklQRDRwZ2Z2S2lZaHVwZVoxbjlM?=
 =?utf-8?B?U3hVWTRERGZ0WDhtWktuOG4zbVhoaHJZOVU0enVsaDAvZGRSbFpCdUNIbzg2?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ade874e2-19ac-46ee-b60d-08dca4d84aee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 14:13:25.8764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH9xOzvlEDIwV5dUv4bT8WfidYVBng9p0P5VkMLcSEI2iMlxgfe/BMnSWudXCLsdw+PW3sKv3Id82SumZm4mK3Cs7YfeF9odPNAoS7yfPiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10885
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

On 7/15/24 12:13 PM, Simon Glass wrote:
> Add documentation for the qfw bootmeth.
> 
> Fix up the compatible string to drop the 'extlinux' part, which is not
> relevant to this bootmeth.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
