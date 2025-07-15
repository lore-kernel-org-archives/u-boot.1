Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58D3C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DBDB82F14;
	Tue, 15 Jul 2025 11:11:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UPYb5FiY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 387C782F8F; Tue, 15 Jul 2025 11:11:53 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48EB582BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:11:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXeWqx5zHeRX6BnCwod1tlRzDHQxixSZJFx/rDjyGYho0Xm0kXq09FlbSG8a65WGYNuMyq4LFSfZdEcQXOG+NBLfE1t+64ahojXF6LtAbPt+rWZZJ5bAfjycp03/6xeTn641ghhfCNkH2yCC/cXabd4FFUH4XV95N7wRHePW/tcp6a4BoSGdPJ8+virSvM161QRXvFCH/IzzSQkLaL//3pzOZCbA1xVHFGkB2rQSVI13C971gtRy5gp+e4jYjbEuAyRxP9BQ0tLD+77dE33Il3biWfrs8VdKUBLgvA1muDG+eABLDp+mY4JljZ69eHRC2E4j+6Gl6fHERoOYNELxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZJmS8RHZ8faODnu4PeCiXrmrVPBxA1b1H/e8eXy2Bw=;
 b=Uz5cMAooJJVHf1Majsdva1CO5M9fTPfuqdSGlO1ATxZZ2EtGICN7z4j03lwKidTuwk0axGpBO79xQfOP6eqTid2Fa/WwaciKzXVR3200NV1ZIwIj71llLNrCoK+il5wUdQ661RqdZHbnrO/zYVtQHcATGQL894IOb5Ogn3XJaRWtokybioU5Z/YTEQmSNfiReQgOgsimIHEJf6IpFlKNyWs5A0E+Xsm8yIXxo+lw7TZUKu16dvKWgZFxTBV0xwYD+mldwYrH9Ab71eMAx7SCj96pjshi13u+RX5fp9YfuP6Igh/Oy4LI9+cinXhSD5qxanduaw3N97l2mP8Zeq8Bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZJmS8RHZ8faODnu4PeCiXrmrVPBxA1b1H/e8eXy2Bw=;
 b=UPYb5FiYnI+TpOiIQYzPFXduU5gAHg451RcXbcCCCCMaiBrFFWuUp3noMaEGKv0P60PiLQz8JFjPCxM7q8JFuKzlqwk+jvZSRli2rLRAlflWlfcgD1bpaXYCiurWFXsZLfh5vOz0k62zjnKq/S8dNc8sN8A4YnrKdks+bmmt0mI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB11432.eurprd04.prod.outlook.com (2603:10a6:102:4f7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:11:48 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:11:48 +0000
Message-ID: <aa1c247f-c22e-4f4c-9abf-dd1bc23b4f90@cherry.de>
Date: Tue, 15 Jul 2025 11:11:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: Ensure env in SPI Flash can work correctly
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250712212710.684525-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250712212710.684525-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0040.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::24) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB11432:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b480175-af4a-49ed-4986-08ddc37fa0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmduNFVXVmc3ZExLQ0RQNXRVUGhWSk8wME5mY0dlSWYwcGpPbCtRZEYvRE5x?=
 =?utf-8?B?WTV5MmNpNWVPVUxSdEUwOXhISXkzVUZicmRyb2l2Rm5wdzFTTXAvaEZac2xH?=
 =?utf-8?B?eDZYaDIzMHc0V3Q4cnFuSkRlc1ZvZ0t6NkNlLzdzbWlMcFlZYjJXdGhDN1lv?=
 =?utf-8?B?djdXaFNWTHF2TjhTZElMYW9YNWEvNWhnUmFWdkZnR3ZZZlpaYkhyUHEyUDFr?=
 =?utf-8?B?TGRiYlA1anNpbzRKV3piSmZSSkpIaGowRlZEOS9YbDlSSlhXdklsVWN2Qkhs?=
 =?utf-8?B?VHpuOWNwTGZpdkNjNzl4NWNWZGdqWFFhMjlBL3RjaytNU1hobmpMcjArRkJo?=
 =?utf-8?B?REJPTXg4MmlyNXBLaHJGUkR1Um90ekUvbzRZcGdZcTRnUWN0TzVlbVpjZi83?=
 =?utf-8?B?c3ozemhqb255YkJyUVNON3llbmpMSXhDTW0zTHhXNlZmeEVsRkdIcUg5YjhX?=
 =?utf-8?B?SW0rNENZQU90d2VtZmk0d01nMUNYZktleXZ0L2FRZzFhSHJYVEZ5cGtSS0l5?=
 =?utf-8?B?dGRkMEdoZllENE5zKzRPMVB6V2JvdXZTRnphd1NkdVJsbWw3VFo5OTR4NEM2?=
 =?utf-8?B?Vm0yOFRjcjJPd2JSYk5OZUxneFdDOEtGUC9QZE5WZnJQMEJwZk14Tm5sMkV0?=
 =?utf-8?B?Tjh0M0xuSWF0S2dVaXF5eUk2MXIvL0djeU1ZMzl4Vjh3VVNhMWp3NVVadGtO?=
 =?utf-8?B?OEtOOC9vdUxpYlBWK3QwR0lnUzAxWkphVnlNS1hMVTVuUW52anVjSkFadWhx?=
 =?utf-8?B?UnBrNkRmbEtBUkd3UUpXRTJJY2gvSmtaamxwVkxTekEvanNSTXphajc5Q3V0?=
 =?utf-8?B?Yjd3Q3JhcE5vdHliUVBPUThxcUU5VDMyK2NDNS9DNjBwdGJIVG9uSzZSalF3?=
 =?utf-8?B?YTlVWCszYktpMEFGSWpyeCtGL3NjR1dJQ1R4SE9UTlp2eElFQThPNXZ5dGU2?=
 =?utf-8?B?b05nRnd2S2lGSUd5dW1JTUlZSFd3bnNPR3hYeFJWUkYxaXlkZlNOaEdPY1RS?=
 =?utf-8?B?dEdiWXF1bEllSUJLajh5dlV1WG5NcXJ6SnJzNkN0RmczQVd2Z1pnWnNnOVZs?=
 =?utf-8?B?T1p0L040KzhoVEROWFJ0QkRLek1ZcG82YXhzM01RWXdvdXNKdGZaRklUMU9n?=
 =?utf-8?B?dXhBTUZCMWZEUEdrMy94SzcwaDNWUjh6UlJuYm5CbTlLb0cxSkpRaEVmQ0xW?=
 =?utf-8?B?WjJHK25icjRBdEZYQlVHOGJYRlRva2gvU0o2SlBYUk5sSk5hdDRpYlBRZThv?=
 =?utf-8?B?c1Zwc0ZHaVM1SUl4N09ZMEU2cGloNlgvL1JmQTRUai8wVFZLSi9TeGpvTzI5?=
 =?utf-8?B?L3F4UHNMaitET1k3UHU1WkdmQThWaUZOcFFoVy9JUCtzUXFIek1DOE5sTCtS?=
 =?utf-8?B?Y1AxamxPRFhhS0FueXUvM0E2SXVVblFtdGI0eGZNMjRya0lJdVdmbmhDVG5B?=
 =?utf-8?B?N2tTN2hBcWRRd3NLcmcvdy9wM2lvNmZ4c3RQV1ZJMzU2TFNpU0pFMmZlQ08y?=
 =?utf-8?B?Wm5YUXM1UFFwRlV1d1FXY1o5ZWRGcEpGUGwzOG9GS3M2a1p1QTZsamlmOW1U?=
 =?utf-8?B?NFRLZVM3NUZkNUY0L3M2ZlF6MDUzN2RtVEJDOTNhSUdYWVNRaDZ3VXNrWHZ5?=
 =?utf-8?B?Yjl6SUJmOFZvOElzYUlpb0xWT1RRSUluRUlxV2lEVko0bmtDSFRxVUp6MUdR?=
 =?utf-8?B?R05iblp2NUNYTE53VlNuZjNCdTVqNGRobXpkQTNDUmc0OURwZkNqMmZNZyto?=
 =?utf-8?B?eUhFZ2JHbnR2TnpXODN5bXp2Uk1PNFQveWpEUjB6Ui9DVGl4TDNFbWpBVjlu?=
 =?utf-8?B?MTNzdDJuZlpuZkdDeW1MN3pQWk1GdGkvT3pYRmRjVjdWejR0QXZXemNkM0F4?=
 =?utf-8?B?UGFBVitqRmZwdXhKQXZWS3dyWG01cHY1dEI0UUtiZ2xad3BKNUhWeTdoUU55?=
 =?utf-8?Q?MlICZ/yVQ84=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2tsc1M2YXlXWE0vcFpoTHZmUWFTTW9WWEhzQnlMd09FcllxdVg5c3hKcnNY?=
 =?utf-8?B?K0RTYlp4OHdNcDQxT2o1TUJzWkwrb0tmTFBBZERsODNuSkFQRlljdXBOM2ZY?=
 =?utf-8?B?RHVqc1BLRW9pWmJEYko2OEQ1YWVnTE90cXh3b0U0TWhYYnpIbklGNVdXM2R5?=
 =?utf-8?B?bTdRZks3MXpONmJ0Ukcra3k0WHZxZ2FhT2JtRGFIdnpmYTYzRVkvUnlObFlr?=
 =?utf-8?B?c04vVzNId08yaGx4anBYU0ZZaTNNUVIzbUxwRUVQOVZQeUZ5ZmluU041MmhG?=
 =?utf-8?B?cWxxbjNPRkVWeGZTZVdCMjVEVHNXTnhETm9hakl1U3FSWlNNY3orL0FYK3pG?=
 =?utf-8?B?dFRBdmVFb05KMFI3U1BpZFY2a1BrZUphYnptOTMyc2VMQVJZdkZSRHpQSXlK?=
 =?utf-8?B?OGxPa0UzYUlLc2hFVWgvdkluUXdIYS9oNlEvV2s0UCt3RVlVMU5iSmtvellH?=
 =?utf-8?B?emR0amUwcXMyejRiNTA1SU15UGNvRHhPWUVaalc4NHYvY3NjZ0hycGl6dzc1?=
 =?utf-8?B?K0J6anMxYW8zYnhRVUVobzczWGhERSswWDNYSG5UcXpYR3ZWVXFEV2tPKzQz?=
 =?utf-8?B?TlA3bFNlVUpXelZ1QVN2bjAybmtJUjRLcGNTeVpJN3Z4ZGw2eWdNNFBRREdO?=
 =?utf-8?B?NHVSSzJ6Y1oxZUxETlN4YytVR1REWHZpa04rVElKSmFXS2QrT3EwandZV25D?=
 =?utf-8?B?RStTVHRJbkZYVGJIY05KeDV2dXRVV25Kd2wvWUphYU1sNmRIVDdLYkJ1MGE1?=
 =?utf-8?B?eUFpKys0NmxQclJvakh1NFdvOE52dVFiQ3BmUGRrejNpYW5Pc2s3WTl1YUox?=
 =?utf-8?B?S1paSDg5MW5FQmJKMFYrRXRFQWJaYzZKcGhrU0FkSUNSVEFHU3J6NUU3N29y?=
 =?utf-8?B?cm55ZGtiTGxoSTEzZkQ1dEIzWTVCMEFqcW9hSnNzUitVWlE0Qmhtbk1xdDNh?=
 =?utf-8?B?RExZZ0prOUhFenNHanBQNWh0YTR6bHJ5K1BaMHF2OWU5QTVYaXY1VlJQbGdK?=
 =?utf-8?B?SlFuWE5Ma04vMWpDM3UwaGozbm1BcUUxejVCL3c3NHdheGJtZDlqTHQ3WkNY?=
 =?utf-8?B?Y2xLcE1qaTUvaTJQb0U5dmt3cXRxbkgydkRVZld1T1lXbnJwRmhRSEV1cHBy?=
 =?utf-8?B?akl2d05rQnhMZk1lRU0zMDkwVmxWUCtXTHBWU3NvTmVnQjV2aVdadkJFRldT?=
 =?utf-8?B?czF6L3IrOUlOYm90WFFOTC9GWCtaNkZwbDlWK3JYOUViWTd3ZHI1bUZnUHY2?=
 =?utf-8?B?SFQvdXZMcjNKcmhCSm54VE1QSnZ2WFJTYnh0dE9SVlFzamUxNnRHb1NNbTlS?=
 =?utf-8?B?eTNNL3YrNHRBSHJNK2ZGYXZyc09JUWwxaVhHeUR6K3RlS2ZVdDBqQWYyVXhG?=
 =?utf-8?B?ZTVpWkFkOXI2YXJjeUpNWThyaS9xWGQvTFAwLzlrY2NSckE0cTAybmxYUE4z?=
 =?utf-8?B?ZHVyMUxrNjU2SVVveHJQVFNwcWxOZmVGT0d6VXFvRGlSK0xkNnhtNEFUdWs0?=
 =?utf-8?B?anR6RnVldkhUcjVtV1M5ZEJaNUdaV3NpV2ZuOHIxTFd5U0lkZlFWODh1bFNt?=
 =?utf-8?B?SmJPZFpkSjhYdnhLMGpHaDl1VWtCYmROenNJVjdmMW1XbC9xdUtSdE9KMndZ?=
 =?utf-8?B?WWZ1YUhPdVpJdG14bmVBaUpMV2tBZ0F5eVE4TS9PY2ovei94VnIrR2IvWjlo?=
 =?utf-8?B?cHB4Q3lSN1lkMzJWUWtqMEdma2tldHVWSzA0TEVyd3NjdXAvMk9rYURRbjVP?=
 =?utf-8?B?bmpZTERtYVZ5eGhBYWN3UGRPQ25zY1BSZytQQmp6cWMzS2cwK2lXZHVsckFN?=
 =?utf-8?B?SUhSOGJjdllSUzBJemtTejJOYXhveHVKU1daUXBjR3B3dWp0Z1dzcU1heXhF?=
 =?utf-8?B?VkpEMTlnTlpYTjZscnN4NTMyYnp4c0lmcnpnVWIrOXozSHpaaDg4UkptU2N1?=
 =?utf-8?B?R3c0bWpNZE1tNFZUWjhIUUR6QWh6bGlseUxjK2hkS2NFV3hqZ1RYZlY2THdZ?=
 =?utf-8?B?VjcwN2JkbEs0ZTBIQVVMWURJMDZKOU5QRFRJZG00ZTRtY0RlRnVDNVZFbXJz?=
 =?utf-8?B?T3BwaGszSW5TbjF2VWtFQ2xrQiswd0RTRnhFdFhLMDdnc2JoS00vUzBIMmF1?=
 =?utf-8?B?TlJCcXZmV21teUVBYThQeHZvSW40RjNFYWZ3aGlwQmloTE9XY3hDS0J4bFZT?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b480175-af4a-49ed-4986-08ddc37fa0ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:11:48.5251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVlRiN18Rhsf4UPw5rKHo6l6gY1zJFxAMf8uDerhcHcW3DXtNdieGWQ+Aroyny4vbljQp58ZjLflc4mjOZj0XWKfsTdPUnUZtWfBioRvScw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11432
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

On 7/12/25 11:27 PM, Jonas Karlman wrote:
> Ensure that the spi/sfc node for SPI flash is aviliable during pre-reloc
> phase so that env can successfully be loaded from SPI Flash.
> 

Shouldn't the pinmux nodes be added as well? Or are you planning on 
having those part of the individual board's DTS rather than in the SoC DTSI?

Cheers,
Quentin
