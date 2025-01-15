Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D2FC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 045D3800C2;
	Wed, 15 Jan 2025 11:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="eW6aGuMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F33A980269; Wed, 15 Jan 2025 11:38:52 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB8AB80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:38:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdlRGbmKEqo5o7vjHIdljlVeDVu2BtYpg8embT10veilwMkvEVvipOs8Yf0Eln8a4AotqLmvgA1gGtTWmSEMLMx7wp8VHsrE9Da7ZLviSN0z8hBdN6175k38m5j5Yw3cYCQJmO28FxE0wYKVZeg8DgFhF2on3Gn44fdUwTZda/kMYk1vftw0Oiz0LKoxSPfKuXzpR3xT+XA17Df/iYXL1e8wkpYQDF90wILY15tvKKPSTWSqrV4FUats6CNFuL7MS4rOFSsmJZcR0e6Bi6pG1LAn/hXe7FEVz/veQ2DDhnMyjQfc0HLwiqDVbJBER62jlEdHkDFmU3wSFYSGZYpeXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpQAAOX57qAjOcpDgDvHto8RxtAkQEPd4jSfEC0Rkok=;
 b=r3cDoSufcmcaKNiucgXvXqYtp/NcmUQrI3N6AwkdgjSGLXUKkHm009Tas3GecSvyaRC5n8ReLBXL2+6qyBA7hRgeHEm71bHghSuJbpOd0oC+Ueh9tPf9QfPDeGE7kkxhvG5x6UcgBhU10GqPyN+cWFMPZf9cDrMCpQfLXAuS4b1e8sy3voKo56LNBBK7CV07VJdp3bU2WT9wp8T8QXMGiX0KbxVAM04SSQ2EcQRX2QjOBv5P45dRq/e1wcz6zJoZ/72bSmVRq2OZBYtmf1CRiKr/3gh6460966v6etVR9T28VtwRSUalsA0eWNTH7YGtdmJW+P7oeurH7+VjsE1Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpQAAOX57qAjOcpDgDvHto8RxtAkQEPd4jSfEC0Rkok=;
 b=eW6aGuMoRbUhmF2BOLP13igXTxDFVbB2C89rwtFzCogUhVvfOn9RdZMj2ItGIkAHaOANqQHguenL6pY0stweEdUP7fIMvV4CwRW+ueXTX6vw2GE+oYSWKQtsHI3Te2XRdf31X7K9a4EuVlB4bwKBJAKC/N9fC0bfENOombG1Is0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7759.eurprd04.prod.outlook.com (2603:10a6:102:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:38:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 10:38:49 +0000
Message-ID: <c2dc2745-5288-4182-a25a-561b96126cce@cherry.de>
Date: Wed, 15 Jan 2025 11:38:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: Make sure all linker input objects exist
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bryan Brattlof <bb@ti.com>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Roberts <ian.roberts@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223252.179123-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223252.179123-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0086.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::27) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e6c161-83c5-43ba-2a08-08dd3550cba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3gvakZkMmtVcWZXMlk5UWd6ODY3YzNhYTNVdGJjTTBnTXVsYzBrL1BjdWhx?=
 =?utf-8?B?K2xjeFl6bU5vcCtKVkNTWFRqUHhLcVdTWUVJMnU2ckRGSmU4b052S2N4Q0lS?=
 =?utf-8?B?OTU3NjNncGlrczZSd1UvNG96T2RVTUVFYmJ2K0dEbXdyMDJXcTgvNDN5MUhZ?=
 =?utf-8?B?NWFQVnpDNUVId1NMd2UzMXdnMXEybXdWN2tNZEFRRzFjNWdrb2RhRnhRcDhJ?=
 =?utf-8?B?UU45TGsxem9lSTh6clN5QzU3WkZWVWdBUDBJczBidXRZR25sVjJIMHZlcGRQ?=
 =?utf-8?B?Z2xTdWxQaUhITTh1bTR5eXE1T2I0eXJtZlY2VWhxdkZYb0p0aVc4cUJLajBt?=
 =?utf-8?B?VEoxNFc3NlVHNkx0TzE1Q2NvZXU3L1hqS0EzRDRMRVU1ZSszZ3ZmdHJ2RWxw?=
 =?utf-8?B?VDE4MHllL3hTdWJUeG4yUjBnMlVydGo5ZUhkeWZMRkRyNG9XRE9rTXUwYVZI?=
 =?utf-8?B?ekphVUoyeUduSEN0Y1ZnQ2UwUis3UlNIUTE3cGdJZHdld3NBL250dHY2Y3hh?=
 =?utf-8?B?THptUnAzdDgzZVVOOGpnK3VyRzIxS21HQmZWeXQ1cUdWZ2dJbUN5a0lKWCtF?=
 =?utf-8?B?TmlnMitXMWNyNkJHSTlrU2J6U0VDdGR2UUtoeHYzNlZkSzd0OGx5ZHhQN2lx?=
 =?utf-8?B?clI2T0hTSGJOMXA0SS8yZFlrNW5CZU1HVDE4Q2NuOHZ2Z1FkcWxoU3Z4anlt?=
 =?utf-8?B?cCtaWmRBcXhrdlZPVmZuWlBpRXMxZkhiUWtsNHBjcFh4NFp1WGdDaHdhU0J5?=
 =?utf-8?B?SEhmY085Q3hJVTZ2bmFNcDJGQ3NwSW1kNkc2MFVLS3N5TldKUDFYSWJtQzND?=
 =?utf-8?B?VmtLQnZCVnMyTXZ0QjM1eDV5SDIvbk9Tajhud0Z4RGpCalBjMVpsdVdZNjZE?=
 =?utf-8?B?SG5lNytUYnFlbklkZXZGQUdWUUdZOHIyZ2NtMmJvVGJIWDdVTmRpdUM1Nnpl?=
 =?utf-8?B?aDVuTG1RNktNbzQzWTlRejN4NG1VOEdwUVlSSnVNV3BSaTcyV2M2OGo4ZUg3?=
 =?utf-8?B?K1RuYUZUSVV2cUV6QkdHWTlQQkEybjB4eFdJWjhlZ3YzalRVdlZjc3VrMUFE?=
 =?utf-8?B?NXNQeFBNV2laY2tzNkVpcTJMYW54dlZNVTVqbjF0M216bVBNMXo5RXRXTFBm?=
 =?utf-8?B?WE1lT0JZT0N5cVdXeURCNGlic2FzamE4R3FLSy9tQzA1Ly9FN2xmVzlTdGo2?=
 =?utf-8?B?b3htdXRDWlhrZU1sQ1ptcVMrdDM4VUtUVktDbi9hRXJVY0J2QitZbEZwWnU0?=
 =?utf-8?B?bEdUWkNiN244Ky9oeUI1Y0xySUJKVm5HSzczZnA0YUxjWmNXb09YdDVQdTRW?=
 =?utf-8?B?V0V5bmNVWXJxVXVPNEo5dU1ZdFhsV0krY3NBazJGcENXblZ4dHQxWmlrYjZu?=
 =?utf-8?B?Uyt5NlZmbG8xblNZQzR1dHBxNXlUbWJVd2duMmRoSnZLRGcyam1QRXJJWUZz?=
 =?utf-8?B?Rk9jbGxncjIzUDFLTzhZWGxPQTlNTFNra2hOejQxOEEzUmc3Ny9xZjB4QU9S?=
 =?utf-8?B?a0hMSm5pRmNlUTRGRXMxK1BkTFRZUTFtdUg1ellpT1VzdkNhdWhGL0hVWXVp?=
 =?utf-8?B?NUhmaFB6TGdZRGl0bDM4aXRYVXFSWFZ3bTBjQTl1WnllSGNuckU1NjRBbHFn?=
 =?utf-8?B?cHBaME84YTdUMTRWSzd2aE5jeGQ4aytSY0hDdHVXTDFra2o5Wk05UzNnUnM2?=
 =?utf-8?B?ajRaMnJRLzFEdmlSVy96UlNncFJpL2xRKzFCM0tTQ1lMU014YjRieDRiQmk1?=
 =?utf-8?B?S1h4Rko3NnhSaWR1TGUzSmkwYmZTK1VRTjQwbFltOTVSYWU1d2dLYi95elR3?=
 =?utf-8?B?aVpqeWV5ckNUYkRET25iQVN4TFFhMkl4TURmWXFJSExQbjZWM0VYbDYzWjJQ?=
 =?utf-8?Q?WC4M8lEAZ2tmM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SklRYjFacU1sS0tEQ0Vjb2xlTnFXSDcrN2xlT1k5SXZLVWJ6elZab2YzSkds?=
 =?utf-8?B?eTBoTGtzYmpoZGVsR3NUS3lXN0hyM0N1aDFnOWFubXZQTWZTdXBmOFg2cVRH?=
 =?utf-8?B?amlvc1hYUFNSTU54UE12RkRDSkNILzVSaklZUGM4K0hMbTd2SjFJaDE0ZnZk?=
 =?utf-8?B?STF4MXplODZMTE93Ylo1M3QxUys1emdXWWxWbldQYXo5MmszZ2tzeDNRNHZF?=
 =?utf-8?B?UEhsNzJnMUpTSDFpbnBPVklFb1JFVzFLZlpCNEF3RDNJV1h2OW9wY0VLNndX?=
 =?utf-8?B?dUFuMWNwRGkrSmFRWGVGMm1IZjRpb3FlOWxzTHpMRDk0OWtZV2szM0FzSjZY?=
 =?utf-8?B?WllseTZXS0VLaTBDUFkreElZenBuWjZ5RVM3M1dTdHl4MHJReHQ5cGRqSEVF?=
 =?utf-8?B?WVVnN1B5RUdyVDVReS8wNStoWFpiWFhxekxncW51TjByQ0o0RSsrbjhGY2k1?=
 =?utf-8?B?OXNFNXpXVEFrSktodGtCNXBObThBWUhiS1RFMithdk9jM2s0Y0NXMDRVRlVv?=
 =?utf-8?B?bk5LTmtjcHRvUGdKeWV1MXByWC9qaGo4dTNNZWxMRUJod1U2US9tTWRsWmRX?=
 =?utf-8?B?YmF2SjNubDdEREJCTGNxVndjaWtSWGs5Tmp5UmZ2ZTR1dndGQndiOEcwVnE0?=
 =?utf-8?B?YnBsY3ZaTDFVK0JIYjBjM1BSSjlkVElVMGlMSDhnNW1LWkYvRGE3OEJQaHVT?=
 =?utf-8?B?VG5DbzJzaEh0dHZTZVQrWVVPUmtjaGphSzdhY2U2bW5QQ2dBWjYxS1R0d052?=
 =?utf-8?B?S1A0a0QwVXlRbkhnSWlVbzFraTQ5cHhiTHpEZS9YTGxrdjFOK0krZ201a0Rs?=
 =?utf-8?B?TWNpR0JJbTd6N1VDV0wwZDFsTVFqWFJUL2tEcWhwL2NMbkZkMG9SaFpPalNG?=
 =?utf-8?B?cStMVURlbng3c1NTYVhWSEhZMU5SeW05eHV1OTVKcGV6RDZLOVpkMUErT2Rq?=
 =?utf-8?B?TlM5TllmbG5jREo0RERmWTc5eVcrQkk3SnpvYmxoTnluZldXbFg5RGJSdVJF?=
 =?utf-8?B?QkZjYlJEOUI0YkdEQ1ZNZEdSTStOY21kODk4RUJTTEx4UHFBcGFkZmlVd3l2?=
 =?utf-8?B?RzJFekpZZGdVTDhJQmhmb3dLNzJ4UENhbkVRVFBzRHhGcmV5ZHF6dWZ3VUxC?=
 =?utf-8?B?c3BFY2lVd3JNWlFvUFZZRnZ4MFJlaU9DalBwQXFseGtmSCtoMEU2RGM1dE9H?=
 =?utf-8?B?b3MyZFZhcGVybXoxVjZqdG91dWd5ZDJGSkxzS2JJNForb0VHUS9pV0kyaFB0?=
 =?utf-8?B?bmlmQjhqKzhXRXNzSzc1NElaNjFnOG5rdmRWSkhoU0t6VEtaUnlpekJiOE1V?=
 =?utf-8?B?LzNFMXkrREtWMW9hYm0wdHFDdUhkODd5ZllHV1NibGRqTWtZWk5Ha1R4YWxm?=
 =?utf-8?B?VjlhQWtQeStieDBnMnFTdldYYThHQms3bVpJajExa1dKdzlyS2Y0WDJVYVc3?=
 =?utf-8?B?b25nN1lNc1BwN0JuSWc5VTFPWE5FcW5DMjNIdW5EOUp0WG5JL096NTgxSlpZ?=
 =?utf-8?B?bFBaUnZuRyt3V29xUGxqWGQ5MEZDekJ2NlppMnZ5QWVlQ3RGOElrSFB4d0cr?=
 =?utf-8?B?LzdxZEFzQ1FkSUNKK21JdUVYY0xqa3NuaVZxekFwUytlQmlRbkIrVWhYRW41?=
 =?utf-8?B?TDJJajZxZjRlYWZpbVRzZm1SYVFTUyt5SmFKK1dTYWMyRHNWM2FuQWF1UEZp?=
 =?utf-8?B?dEk2dkNhbW1KcXJEQnUxalpObm5weCtZaXRXR1dRV0hrTW5rcGRDTStGUldD?=
 =?utf-8?B?bkpIRlNRTXJyRFY2VGtCUGY4Y0J4YnRoMlBmeGxoL0haeTRsVGI4TGNFNll1?=
 =?utf-8?B?RGdXZHRtdmQxdG1NUVo2WjlFMlBHYk5YT09WU2JZNEVybFhIVjM3bkswU1N2?=
 =?utf-8?B?NWVDTDZ6bFRzd2t3VC85djN2YWhmOFVTeXhpRi9xMk1VaUZFTFZhQ2o4aWRw?=
 =?utf-8?B?dU45Sk4wZnhrVCtqV2d2Mlc3Vjd2eFBWRXVJdDVOc3lNeFdBQVdOa0Jnamtj?=
 =?utf-8?B?Y2dEMGVIKzVMbXNCUWpPUzNYQllRbG5VMlNXSTc3MHprQ3YwRHFFd0dvMXJR?=
 =?utf-8?B?M2xUVnI2VXFmWGREV3oyK1ZSc21mNXBhd3hSaDNhU0JZMk92RnVqVnJ1T29I?=
 =?utf-8?B?L2FjOVNFczVhc3ZVTEs0SGM1OW1iRXhFTUdLMVR5b2MrTS9ad3p5d1ZiQmhS?=
 =?utf-8?Q?azE+/unOEDKMQSDQS62TvbM=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e6c161-83c5-43ba-2a08-08dd3550cba6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:38:49.0969 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itRSjDfUsqZrDgHfEQvNxKcTmi+jC9jUVR3njneK6gw0c2n5M9rMypyMFiBxO1ubU24DqUTaq2EgSZq4Ogh8elP049er1ulskcNi4DAV7OQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7759
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

Hi Marek,

On 1/12/25 11:32 PM, Marek Vasut wrote:
> In case the build system builds a directory with empty Makefile,
> one which does not contain any obj-y entries, the build fails to
> link due to missing built-in.o .
> 
> This happens because of this part of scripts/Makefile.build
>   81 ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
>   82 builtin-target := $(obj)/built-in.o
>   83 endif
> which does not assign builtin-target in case obj-y is empty. The
> built-in target is then not built at all, and built-in.o is not
> generated by this part of scripts/Makefile.build
>   325 ifdef builtin-target
>   326 quiet_cmd_link_o_target = AR      $@
>   327 # If the list of objects to link is empty, just create an empty built-in.o
>   ...
>   335 targets += $(builtin-target)
>   336 endif # builtin-target
> This is the correct behavior.
> 
> The final link however expects the built-in.o to exist in every directory
> included in the build, even in those where the aforementioned code skipped
> generation of built-in.o . Make sure the built-in.o does exist for every
> directory used in final link simply by doing touch on every built-in.o used
> for the link, which will create empty built-in.o in case any built-in.o is
> missing.
> 
> A possible alternative fix is the always define the builtin-target
> and always generate built-in.o .
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

I tested this with the following diff:

"""
diff --git a/board/theobroma-systems/common/Makefile 
b/board/theobroma-systems/common/Makefile
new file mode 100644
index 00000000000..6125c1a0b79
--- /dev/null
+++ b/board/theobroma-systems/common/Makefile
@@ -0,0 +1,9 @@
+#
+# Copyright (c) 2025 Cherry Embedded Solutions GmbH
+#
+# SPDX-License-Identifier:	GPL-2.0-or-later
+#
+
+ifneq ($(CONFIG_XPL_BUILD),y)
+obj-y        += common.o
+endif
diff --git a/board/theobroma-systems/jaguar_rk3588/Makefile 
b/board/theobroma-systems/jaguar_rk3588/Makefile
index d43bf194b68..38b73d2846c 100644
--- a/board/theobroma-systems/jaguar_rk3588/Makefile
+++ b/board/theobroma-systems/jaguar_rk3588/Makefile
@@ -5,6 +5,3 @@
  #

  obj-y += jaguar_rk3588.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
diff --git a/board/theobroma-systems/puma_rk3399/Makefile 
b/board/theobroma-systems/puma_rk3399/Makefile
index 2256e72cda1..d962b56f111 100644
--- a/board/theobroma-systems/puma_rk3399/Makefile
+++ b/board/theobroma-systems/puma_rk3399/Makefile
@@ -5,6 +5,3 @@
  #

  obj-y	+= puma-rk3399.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
diff --git a/board/theobroma-systems/ringneck_px30/Makefile 
b/board/theobroma-systems/ringneck_px30/Makefile
index 4d108f2d011..31ada1a6942 100644
--- a/board/theobroma-systems/ringneck_px30/Makefile
+++ b/board/theobroma-systems/ringneck_px30/Makefile
@@ -5,6 +5,3 @@
  #

  obj-y	+= ringneck-px30.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
diff --git a/board/theobroma-systems/tiger_rk3588/Makefile 
b/board/theobroma-systems/tiger_rk3588/Makefile
index 94b0859eb35..900647735fb 100644
--- a/board/theobroma-systems/tiger_rk3588/Makefile
+++ b/board/theobroma-systems/tiger_rk3588/Makefile
@@ -5,6 +5,3 @@
  #

  obj-y += tiger_rk3588.o
-ifneq ($(CONFIG_XPL_BUILD),y)
-obj-y	+= ../common/common.o
-endif
"""

which allows me to use HAVE_VENDOR_COMMON_LIB mechanism with an empty 
Makefile for TPL/SPL build stage, so:

Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Looking forward to being able to use HAVE_VENDOR_COMMON_LIB!

Though I could actually always include the file and just ifdef 
CONFIG_XPL_BUILD in common.o, but let's see where this patch goes first :)

Thanks!
Quentin
