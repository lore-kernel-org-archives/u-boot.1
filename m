Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37003C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:06:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6288129F;
	Fri, 16 May 2025 17:05:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KSJBA0Io";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E8438129F; Fri, 16 May 2025 17:05:57 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC608006D
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:05:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+wnDPn4OEP6GdSPdWbAZ5zXBSIdTftIZOKsaUV4DIrxYvq99bktNKYWyehwRF/14TOBrMNoG0mR6ewfNVUIQ49/jsoQWciD3Yi8O6wvQk/KntExULLpqXwKO5E5rmKzq2Dwu0APq3Gu0UIYbJjyqjvYGAx9SrPi+z8+yh5GeZQkmBzDquI5El5vI2aCqimGazoLDn2wwpd3hz7NrKJhYy3jyRRsadMFP6zE2N5Hr2Ik9Eh+HXD0bAyf28/DPZhMopEK3PXLlfJUHGhMbs0evtTLH/HRzrsy4DhQK5F5dVMuUDWgqrJA8ODq740DzY70uwhnSK0KS9r+Seo3efK99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykW3WghOvdt+i2yF9LQUH5wqAyUAf0sjZrlv6+vqU1w=;
 b=K5s+/k90jh1AcXtrOclhPW0gvtwYUDD271I6uLsQc1X/qrdlTIkJI35Izg7Z78N1guebpg6We4MhofbOFeATepUIJ2sZ7lwhETh2xg8zTwFN175PVKHBeMHGg4V95J2n38MpcKZTYwyonBjFJqUnee5Bt43evaXEfu7zIjQ2cWLgk3r7jNS9apeWBrRrHnEot8W5VUTsJqDiao98orL8onGTNGOtPWl3xQJRCr8k5BzPKZjvebdJbUM3cEKG4oa9ZKVQfDIzdOSpSyrPQOVPbt4ea1ZtErKtyXo4ofmDBPddLkcEPTj8v9kPR8HsonLvcnXRm+L/eNA8tTTXYnTrCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykW3WghOvdt+i2yF9LQUH5wqAyUAf0sjZrlv6+vqU1w=;
 b=KSJBA0IoPDY0OEGuR+L+Plp8OrKNvE8Y0ZLTfeu/v5NfF+Rrb5rziQXoX1QPaxoJsynU0TReNG9xAxMEjLlyyAYNtpqkTDypifr8t16tfV6o6J68oLMephOusMvaFLWne7dSY8Nm/++vDILGcVDhxxBm/k8gHfs+J7mmVjaCEb4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10601.eurprd04.prod.outlook.com (2603:10a6:102:488::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 15:05:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:05:52 +0000
Message-ID: <31a94b99-9341-474d-bfa4-869ed7962688@cherry.de>
Date: Fri, 16 May 2025 17:05:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] usb: onboard-hub: Add support for multiple power
 supplies
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <20250425-usb_onboard_hub_cypress_hx3-v1-0-3cc5a06087cf@thaumatec.com>
 <20250425-usb_onboard_hub_cypress_hx3-v1-3-3cc5a06087cf@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250425-usb_onboard_hub_cypress_hx3-v1-3-3cc5a06087cf@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10601:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0613a1-94da-4c75-9051-08dd948b249f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEZ1VmNUZ3FFb0xiTUJ4MlZqWVpYUCtzUnl4ci9EbkJuTWVOdlpSL1UzTkYx?=
 =?utf-8?B?OE5wK2hxUDhzVGRGdXZOY25OcDBVTHRRV2FTL2RwcjdIVkdvejczRVpaRWpt?=
 =?utf-8?B?TjAzeWUzQU83TDV1ZVIrYU0wNG9pZ2U0M3RkYjE0aGkyMDNRSkFrQkpGRTIv?=
 =?utf-8?B?K0xBc0hIa3RKZ0JacURqVWdZL1docGFaY3ZueGIvcFY0ai9TL0FNb0J0aDVl?=
 =?utf-8?B?ck1zbmVpVWZrR05helJTUmR3K1pKWkNLRXp0NGowSU1QL01SaSt3K0NMRmND?=
 =?utf-8?B?OVREQ21Kb3J5dmY4NHRDUDNGbGdjWDJwR2ZqWWZsMjB3dkp4SlY0RCtIS3VL?=
 =?utf-8?B?RTcreS9aTUQzTk9OZGVDRUlsbXl6NkNDNi9qeW96ak1SM1YyWUowQmNMUmRW?=
 =?utf-8?B?RHU0NlBGaGJZRTZtQXVlSEw4WHNiWE5jQnk2bmtoOWExaTlsbE0yZXdGbDk1?=
 =?utf-8?B?WkRHcElPTkdsQldUeE5YQTNZRm1OREs0YnBCYVVDZFZlWndpd0o3TmhYS3F4?=
 =?utf-8?B?aVRpT2FiNU5pQ1NoaDRzT1d6TlZTa2xIMW1sZE9qSWppTXZ2eEFxQjNqblNR?=
 =?utf-8?B?Q0hSUXNwY3ViRjdqbW1OZTVEemd2ZzNxSi9ZRDM0WWJXTHJScEthS3NCTjAw?=
 =?utf-8?B?aGhoM3hWS2l0YW4wSjBMTDBMSmxMMGQxcGpJbzc0OWZ5VWFxK3RPZ2VUczN1?=
 =?utf-8?B?VFRYSEhJYitFQmVsbkFZOUNTM1FyMGgrMTJKejR1UVZzWk5icmJwZHZiazRo?=
 =?utf-8?B?eE9SR0Z1MlhWM3pkRm9OQWRKdEF0VFY0OHhGZmRodUR1djdmWFBLV01jdUFX?=
 =?utf-8?B?bU54d2pxczVnZ3RUbVk0RDNObTljY2VpWWF4cm9odXB0RWVjREg0U1czMk8y?=
 =?utf-8?B?eG1iTVpPN0ZkQXZ5OGZLN2dwYi9leWc4cndNOVY1SVNTcW13V2ZUaDkzQlow?=
 =?utf-8?B?ZUlwcFpTcm9iMjlBT1U0QlhvNlFtbGxENS9nK21vSVEwdUtERHpTRTFhTkxa?=
 =?utf-8?B?ZE44dldzYkY4Z0NwYTNSRGl6RXNYVnFBTVNuQXJpQ3ZUUitTVkJEbWVZM1Ji?=
 =?utf-8?B?dnZlcktnQmNGdDZ5dytBRnBic2MyaCtrL1BpWVRyNmZTQ2FjaXFCYm1RMXUv?=
 =?utf-8?B?c2VyMG05bW1MbFp1WVVCbnRLS2RwTVFEQXpLRFFpZTBVT2ZPQ01xWHVadEZQ?=
 =?utf-8?B?SHNpcEN0LzAzU3E4dDlmSGtCRHJQOC84RmpibllUdFh0YTJXVWJZQ1BaNkRD?=
 =?utf-8?B?L0xnVDU2U3J2QVdycGdoTHk3cFBxcVhZZ0xKTENqSXEyK2NwL096cGZvL3lx?=
 =?utf-8?B?Ym9nM0RDWGNTQ2h2VjZzMDMrR0x1VGR0OERBUzM3MTBkcjhjTkUxNWQ3c1F2?=
 =?utf-8?B?ekowbHo4bnNYRXVkK2ZEVG1mV0ZGdytGcHhxeGduTVB6Ujloc2N3UGVOY2tI?=
 =?utf-8?B?cmxqMnkxNjRVRWl0TlVXSHVwNTBCRFRYZWV6QkRhUkcrazBZMERwcSs0dDJR?=
 =?utf-8?B?SHI4QUtOc0NITW52NDhTZ2p1cnJacGMxSjI3d3Q0OEtvamU0OWRxTVpJcFBT?=
 =?utf-8?B?Vm5KQnZEcFRlMy9idkxrT1VTU2d2K2dUWGhyditKQnVkdVRiTFNhSWxScG4y?=
 =?utf-8?B?NHhUS0dwekR5OG1EQmRPZndxMi8zc1BNN2xiUnFweVhwTURxTDc1bmprZHZF?=
 =?utf-8?B?TERQWkJabVBRY2I0Z0FHWjg1R3M3THVNWlN5MnlXQnlTQXlhUU10ajVCUXFi?=
 =?utf-8?B?VFlVTW5JTGxjWUEzRkdnYk5xZ3VjZUxycjZObmV6V1ZTV21nYkdNN0VxMDVm?=
 =?utf-8?Q?Tv1To2E4Jh+/mZLJaqSVtRGN9xqfuEMxJ/u7E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZheTFLaHp0cVZyWUhuMXI1dVpaaVJVdCtFdzJNZk9lQi9yRWdhdHpMcGdG?=
 =?utf-8?B?UXBmK0xpcmx2bVorZmg2L1o1Z3hUZFRkUmN3d0duN25SYmhQRGlBSm92WFA1?=
 =?utf-8?B?VjEwWmxQdFpDUlFHb3l3ME0yNkVlb2ZTQUlHTjVBcVZNTEJTTGowMkNMWUYw?=
 =?utf-8?B?bjJ5bWZCekc5c3gwUUt0STFiTkppbEZuK2d4RmpXNGtHd242TEM2VWdYdFVD?=
 =?utf-8?B?c0RzMk1aTFIzRC9LTTdSRmpseFl2SGVTQzMvWVNJVTg0c1Q0c3lBQlptRkF3?=
 =?utf-8?B?RTRiN2FkaDU1ODJsckliRnllYkozRmNqWmFUUncvS0lXaWFGdFUxRnRLQ2l4?=
 =?utf-8?B?aHVWdFJGa1hJdEJJL0xFNGpaVDB3dFRCem44bnpkRkNtUGZpSFgvNTJ4ZDl2?=
 =?utf-8?B?eXh3YVRyNnV3ckE0eEVmZ21HUVRURkRnK2ZHK1pRbjBnMFJDR1ZqbWhXUkwr?=
 =?utf-8?B?eXdNMVk4eGt6L2xXbUFWNS8vSjh4RDVkNDM1YWFkTWdkdmh6b05VMW5YanB5?=
 =?utf-8?B?MFNhdTBvNlFaQzkvUk0wL2E0WW9SS0tQSEc0MmJlbWdITTd3ZFFpU004NUdX?=
 =?utf-8?B?VXRYRVJiWU10czMrWGJTOHNTWjlsQTBsTTZjNHpEbXVFNWJHN0tmaTh0STRU?=
 =?utf-8?B?cjBneHY4dGwya0F4Y2ZJWXNPNFBSTGI2YWRxMzVwOE9UbVIrQnRjNlIwaHd5?=
 =?utf-8?B?dGx5QTVNdWthRFNtTGRqcFFyeENGTHVSbFZUdkVvNzRqREZ0b2dqR05GK1dv?=
 =?utf-8?B?cHJLZ3VBZ2hCM0Z5aUEvcFdGcElzNU9DRW1OTmg5OFc4Q242dXpBL1luRklo?=
 =?utf-8?B?UE9aS3Q4ZE1OS3d4RGE0Z0VBUjlqTkdQMFFiMUZoZm85dkVjS1R6VnhGTWVB?=
 =?utf-8?B?cmRVZ0I3M1VEQXNpNnQ2bzg2QTBpbUhHbllUZUNRcU1xUGdnSXY1cG85Ukdm?=
 =?utf-8?B?REdCR3JvVE82dlh5eHY0TmFuQXpOMjA2c2tEUTdaeVZpOFllVXhZbjFiYk5E?=
 =?utf-8?B?di9TV3lIcG53Vmd2TGMwWHUrK1NmeHpkNkJ5Nk96MHlvR1hDa2YrdjBOZkFE?=
 =?utf-8?B?ZjZ6SFBRYWI0YWFzLzBRckN5OFVUc3lqQUYzenJ6QW9EUTJyTmc5cEtXRjJj?=
 =?utf-8?B?SXFVSHpyTEZlcTlCakpoZjVmZTFiVzkvK1V2cU95VDhMcGVHdGRBb25adHFz?=
 =?utf-8?B?STBLVjVzSW9kRklUeGtndXNFa3FGdTRuS2E0eCs1Y3NGcys4NFZKODZabGlH?=
 =?utf-8?B?Z3NoWGtaOUdTWU81a1lsR0x5VGFFVVBDc2JOaXB6SXczK01BbmNuRmdZRjZ6?=
 =?utf-8?B?SEFOZXo2SHhSYy93amNRSE15bHZHWk55MTQ0Z0xCYUdUbFpoV2VvRm1obnZT?=
 =?utf-8?B?clV4akdsTFYrS1VOZ2hrZ1V2SHRqQysxaGlTMnBqZGlRZ0NXVVM3TkFhYTg1?=
 =?utf-8?B?UVFsL09tQTR1eGszejYyTncxL3R5Qk9ReFp2anBodUVnK2xpTnE3azlNNlZM?=
 =?utf-8?B?bGpFZmFxN1R6VTJleTZnclg5ZXpXSWJnQ3k1bGNaWmZUVmJvL0VoQ254Z0V6?=
 =?utf-8?B?NzhiSTBxR0EzbHZPbElXd3JVWXBKbGl5ZGh5WWZpcnRqRG1td0ZOY1J1dThE?=
 =?utf-8?B?a2k2dUJLNHlaVlFva0NKTWhsQjY3S3ZvWndHbDlxVnV5KytjUCtDcEJndXk5?=
 =?utf-8?B?R0Mwd3FBaFU3TmhjWlNmeXhOektSYXphenpTS3I5T3RZeFpiTTJaM0N6Z1Vm?=
 =?utf-8?B?QUgzZjJtc09kUzdVY2dWeHkyTnJjT3NEbjhuOGV4ZDVjRm1vczRHd0RCMm95?=
 =?utf-8?B?cXhTSlZVMjExbDJBampubkV2QlRkQmxabHJVUkdlN0k0MEtCeGFIb1NlanpR?=
 =?utf-8?B?YU1CR2M0aFpCTmwydTNvVUJOVXUzWVliYU55Ym9jL2JqWDBRMGFieDdQWDZY?=
 =?utf-8?B?Y3JuRjBaalBraHNTQ3hoSVdFRTlHSDdUcFA2OEhrM01zeHNnYmxlOEVOcEov?=
 =?utf-8?B?MkUrdDl5b1RGa2FqU2pDVlpWcUZ6T3ZEUk0yOFpMTVF5RzRmODNZOHUxTnYx?=
 =?utf-8?B?NmF0NTduYzdJZUpCbTYvTHdqRHlUQjR2bUZtTGpPci9NRTlLd0I2MlFjeUZD?=
 =?utf-8?B?QWVKekdhSURISXBINkxsekR1Y25uVUE5NTBHM0ZML1pja0xuREE4aXZEUnJY?=
 =?utf-8?B?c1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0613a1-94da-4c75-9051-08dd948b249f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:05:52.0744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sSCpJQi9QcqzM0pDpPNqFBRyElYM4pXmtYh/fO2l3xXNCnwBqck0WxMHXZWUXe+XV40+r9TS4YZHiK4R1bVHdZP7nz1V+soGYWzZ017Em7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10601
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

Hi Lukasz,

On 4/25/25 12:56 PM, Lukasz Czechowski wrote:
> Some of the onboard hubs require multiple power supplies, so extend
> the driver to support them.
> The implementation is inspired by the kernel driver, as introduced
> by commit [1] in the v6.10 kernel.
> 
> [1] https://github.com/torvalds/linux/commit/ec1848cd5df426f57a7f6a8a6b95b69259c52cfc
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>   common/usb_onboard_hub.c | 45 +++++++++++++++++++++++++++++++++------------
>   1 file changed, 33 insertions(+), 12 deletions(-)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 325c274ed952..b8fa38a4111d 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -20,14 +20,18 @@
>   #define USB5744_CONFIG_REG_ACCESS	0x0037
>   #define USB5744_CONFIG_REG_ACCESS_LSB	0x99
>   
> +#define MAX_SUPPLIES 2
> +
>   struct onboard_hub {
> -	struct udevice *vdd;
> +	struct udevice *vdd[MAX_SUPPLIES];
>   	struct gpio_desc *reset_gpio;
>   };
>   
>   struct onboard_hub_data {
>   	unsigned long reset_us;
>   	unsigned long power_on_delay_us;
> +	unsigned int num_supplies;
> +	const char * const supply_names[MAX_SUPPLIES];
>   	int (*init)(struct udevice *dev);
>   };
>   
> @@ -144,20 +148,28 @@ static int usb_onboard_hub_probe(struct udevice *dev)
>   	struct onboard_hub_data *data =
>   		(struct onboard_hub_data *)dev_get_driver_data(dev);
>   	struct onboard_hub *hub = dev_get_priv(dev);
> +	unsigned int i;
>   	int ret;
>   
> -	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
> -	if (ret && ret != -ENOENT) {
> -		dev_err(dev, "can't get vdd-supply: %d\n", ret);
> -		return ret;
> +	if (data->num_supplies > MAX_SUPPLIES) {
> +		dev_err(dev, "invalid supplies number, max supported: %d\n", MAX_SUPPLIES);
> +		return -EINVAL;
>   	}
>   
> -	if (hub->vdd) {
> -		ret = regulator_set_enable_if_allowed(hub->vdd, true);
> -		if (ret && ret != -ENOSYS) {
> -			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
> +	for (i = 0; i < data->num_supplies; i++) {
> +		ret = device_get_supply_regulator(dev, data->supply_names[i], &hub->vdd[i]);
> +		if (ret && ret != -ENOENT) {
> +			dev_err(dev, "can't get %s: %d\n", data->supply_names[i], ret);
>   			return ret;
>   		}
> +
> +		if (hub->vdd[i]) {
> +			ret = regulator_set_enable_if_allowed(hub->vdd[i], true);
> +			if (ret && ret != -ENOSYS) {
> +				dev_err(dev, "can't enable %s: %d\n", data->supply_names[i], ret);
> +				return ret;
> +			}
> +		}

I'm wondering if we shouldn't have all return ret; actually be goto err; 
instead? I would assume that the error path in the probe function should 
be really close to what we have in remove function?

To that extent, before this patch even, I think we should probably 
dm_gpio_set_value() the reset line when there's an error so that the hub 
is held in reset?

Additionally, I believe the dm_gpio_free() in the remove function is 
unnecessary because we request the gpio with a devm_ function which 
should call dm_gpio_free() whenever appropriate?

Finally, specifically for this patch here, I believe we should disable 
all regulators in the opposite order when in the error path?

Something like:

err:
     for (i = data->num_supplies - 1; i >= 0; i--) {
         ret = regulator_set_enable_if_allowed(hub->vdd[i], false);
         if (ret)
             dev_err(dev, "can't disable %s: %d\n", 
data->supply_names[i], ret);
     }

? what do you think?

>   	}
>   
>   	ret = usb_onboard_hub_reset(dev);
> @@ -208,7 +220,10 @@ static int usb_onboard_hub_bind(struct udevice *dev)
>   
>   static int usb_onboard_hub_remove(struct udevice *dev)
>   {
> +	struct onboard_hub_data *data =
> +		(struct onboard_hub_data *)dev_get_driver_data(dev);
>   	struct onboard_hub *hub = dev_get_priv(dev);
> +	unsigned int i;
>   	int ret;
>   
>   	if (hub->reset_gpio) {
> @@ -216,9 +231,11 @@ static int usb_onboard_hub_remove(struct udevice *dev)
>   		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
>   	}
>   
> -	ret = regulator_set_enable_if_allowed(hub->vdd, false);
> -	if (ret)
> -		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
> +	for (i = 0; i < data->num_supplies; i++) {
> +		ret = regulator_set_enable_if_allowed(hub->vdd[i], false);
> +		if (ret)
> +			dev_err(dev, "can't disable %s: %d\n", data->supply_names[i], ret);
> +	}
>   

The error/remove path is usually unwinding in opposite order than the 
normal path, so that would be looping from last supply to first. C.f. 
regulator_bulk_disable in the Linux kernel.

>   	return ret;

This one's an issue now, it'll return 0 if the last 
regulator_set_enable_if_allowed is 0, overriding the return code from 
dm_gpio_set_value and earlier regulator_set_enable_if_allowed calls. We 
should probably |= them or return some appropriate hardcoded value if at 
least one failed.

Cheers,
Quentin
