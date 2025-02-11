Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DE8C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 11:43:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34CBE800B3;
	Tue, 11 Feb 2025 12:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h7gaNWUR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C85D80104; Tue, 11 Feb 2025 12:43:37 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8588880079
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 12:43:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbgxV2JGfh43Z3UG32YOcsknm+k6RNDp871V3NUvfhDIIJU6ZC/2MhA2BrwZ/olpM9n6F2PgIPA3Xq8WD/jDUOpVwA+HtrSXokZ44YLZfEabQzyw8JC7o4KCMQaOMvQMbbf7MzmWcUewvhU9aj6KA8loA1X5+Do8uWs0AD72H5Z7OdYymsjdF1r9pIMDJmRhkRa9rWHc52bZjPkaEyxJvlLbZfl7ci+ixUPLF8Faliv9fQbD0DgCb7NrMFZd8qjBWfiREQJV+NR/bP8wGpMEiZWSO1RvKk4ToQj2ccsY0kbYZYmMlJbu6oxgQvm6ov+2O7tV1oilXjo/SDCW+Qc2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPm+ZO9XhCode/xfjo3ufaq2Ch8fQHc8qkuCL9dnYFk=;
 b=BWxRcLN7PugYI51nEq8lvNIp6yA2qPRV/N6KF+W4OU0/86bP7u9rY58W1/yT1muuZvOvBQ4tTNNF4MgKXHB0vRrXEQuP6Qh/wAire+LESte5sXvhqFmrOkMjKgi2c8RMKr0nvI2am2xPTdZpWO96Pcv2kq56n+ACB5TUd3m4BST+C+5askM7oxeiRGWzHKSwLGNpRJkZ1QSdulm4Bj+w2B3HTZd1hSGYaii0FZFST0JNY2Tpf2M/9r48+zV2r2dJYDJT02FJV2zzp5dbephX9BpKu6AxbcpEGnbprAi2ZvN/uO3dH7ClEF33Qzy9k7IFgDLEPZUAuz2UxxUMY7BuOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPm+ZO9XhCode/xfjo3ufaq2Ch8fQHc8qkuCL9dnYFk=;
 b=h7gaNWURbUUaJgSp75UtLCqNq51IguDmulcSyi18Em5qahKNa7T4RDeNNbI3a2o/J74OfaRU3138Gbh9Av312HYzDwbSPNpkENY2qlSzAT57AAB48CQBPB0OS5TPqFTppGpOyF+wsiX4etU8toPFAmVZYHzH9YsCPHLTXv63wwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7041.eurprd04.prod.outlook.com (2603:10a6:208:19a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 11:43:31 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 11:43:31 +0000
Message-ID: <67492a22-0e36-4466-9b34-6b27d30271a3@cherry.de>
Date: Tue, 11 Feb 2025 12:43:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] rockchip: avoid rebuilding most binaries for
 u-boot-rockchip-spi.bin
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
 <20250211-has_rom-u-boot-rockchip-spi-bin-v1-3-0d77f95b6239@cherry.de>
 <d46f46fc-4300-4bf1-b547-c1e87e066e67@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d46f46fc-4300-4bf1-b547-c1e87e066e67@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 42048a6c-80f4-44ba-3787-08dd4a914ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2lETW1UWi9lZUcrWjRibFkxbi9iVGk2cDk1aGFTSno5SFdyd0djeFJEclUx?=
 =?utf-8?B?eDkxdGU0WnBxRWFmRGcraG0vRFpPaWcxT0xQczNwd3BRZEEwRE1NUm01TytQ?=
 =?utf-8?B?RmpWY0duNkpoZmM3ZWVyeXVVeUU0Z0tySS9NWFZyOWdyb3hTT2tGV2dqK3k4?=
 =?utf-8?B?RmMzU0EwTkJ1Mlh2TnlUbmRaZEZ1eCtIeHExYXZPMDBaclZVdGtaRDh4d0xq?=
 =?utf-8?B?Q0R2cy9GMFFWM0ZGSko1aE9KdUJmUDMrZEtjQ1l6amZvNE1vaWFwZ2kvdlRY?=
 =?utf-8?B?Rll6cGEzRTFMcDYyZVZXNy8zQS91VkFQcU9xRUo1Y3R6QStJcjk0QnJLQnpN?=
 =?utf-8?B?S3liNk4zVUdYblBrTEZ5ZnY4T0JjRHFwb1NTdm4yQVZwcjJEbjRXZFVyMHdu?=
 =?utf-8?B?N3ROak9mdUpFTEZPMHVGYkgzMEl0VXM3VWtuWUlmeXh1Vy9wRlREZCtlVkhT?=
 =?utf-8?B?MU1xanF2Y3lwL3BsY2NiMmw2ekRaVVduUWJmenlub2NxL1g5VlJpMUFONmlF?=
 =?utf-8?B?SzM5LzRhOGFVU0p5dzNuV0srZzF0bE92YlZzMXppWmQ4OXF3Y2JEN2ovWmgv?=
 =?utf-8?B?eFZPTUo3WklsSDd4RzFXMjVLdytYVmU4anljcjJTb2RhY0wyenYvZnM4MGMw?=
 =?utf-8?B?dWVPL2pyenZWVGZkemVhYUpQTnpQWG95clV6dGc3Z2JSMW5xMmRsZGlNOVdy?=
 =?utf-8?B?Y1NYTnpYV0hXZU5zT1UyaFpuZlNsNnVRZWlKZ1pGQ0p1azhTUURJWHpYSlZG?=
 =?utf-8?B?N282b2JSeE0wLzJmenVEdXV3bUxpNjVWWVU1VVBPVnFVZkRrbTczdEowT3Y3?=
 =?utf-8?B?dDI1QzRoc3ZrMUIrMERZRGhqOSt1V2FwQlUrUFlmdnVzVGF6bWJWK0RjTWpJ?=
 =?utf-8?B?YktrOFh2emI3c3hVVU03QkoyRytHQWtnUmlxYzRBRWFUbVRXajNHY3Q2UTZE?=
 =?utf-8?B?ODNmSmRJbWhrU2ZYOGoyN09hNFRRWmxUVytzckd0Q3A2VG4wUkRkQ1plcFFF?=
 =?utf-8?B?Z01NdFFCUzJaK3RhM0MxM1JhK0dEa0hjZnI1SzJ4TUJXY3RIODc4dzFKSEc3?=
 =?utf-8?B?cXl2TEFhcWhoQmxhY0RQOEtJTkhSR3lOWVlZd25weWtUVndMU3pUZkppSWsr?=
 =?utf-8?B?RDQwNVdaQXo1djhUTS9RWWU4YnB0ZzZSUlR2N05HT0N0NktQQU5hd1JYVXM2?=
 =?utf-8?B?NUR0OW04STBMMHdGQUNNUFd5VjltdVZsU2FrSUx5UGVCT0V1Zng3TGsvdUZt?=
 =?utf-8?B?djNFN0w0NCtlZFY4UzU4UXVuMlozNEhLUGNydzhTRm5uZDJpLytkdk02YUJJ?=
 =?utf-8?B?RXFvMDV6RldLNWV2dzB1UGNaWk9LZlBWT05FQUpyc3BBeGljTWdMeVNXUVdG?=
 =?utf-8?B?VWJQaU9WNU13SjBrS0kzekRoYS9LNXRjNUdocjVPVldjUkc3bWtJQk91OGZV?=
 =?utf-8?B?K0ZRYVl0R1l1TjV4RERmVC9XdTlqcGI3SFN1b1g3ZGM1WWFYeGFQOUlLUkRW?=
 =?utf-8?B?OXJVWjc4RzU4b0pMMVZiZ1FVNE1PN3paelFOdTNJYVp6RkFkZXJ3bnRrRWFJ?=
 =?utf-8?B?UkxZS1I1aWUzV2swbmlLdHdwdVBYUWdzMjRvQ1VnOFFYWVUzbWlHSzFUblI5?=
 =?utf-8?B?dlNrTjJWTEh6UTdKR0lNK1dSMDFtTU9FV2VRVmJYMmpCTEtnT3o5T3hrNlcw?=
 =?utf-8?B?YkNJVVhUZ1luVjBjRzNFbWY4L3d6Wk5YU3J4U0x1c1QzMm0xcFBvQnFzYU5j?=
 =?utf-8?B?Z25rQnAzUW9WVXNDNXJkYVloZFdKbHZYS2xTczUvVXFzT1FCWk1PdHFaM05H?=
 =?utf-8?B?SjlWL1I5THJ6NHJaeVlWd2wxNi9RUlJCS0NFUDFmdnVKOHh2WE1icWRqVCtX?=
 =?utf-8?Q?33rNshFN08V04?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1RJYTFzUUNTQ1pSZW5maGJUa2JZWGx5VUx4VWE4TG5BYnVCT0VKWEhabW1s?=
 =?utf-8?B?TEpRczVGRkU0RzdGSlFrSjhFK1dlcURHeGdtbkFiOVFQUkZ5THRQNFJ1eUZu?=
 =?utf-8?B?UlZjSCtpc0xlWjM0T2g5bkFqbGUxSzMyTDkrYVJ2ZGdaWjN0YjFoTGVTVTQw?=
 =?utf-8?B?M3Bicjd5S2p6TExzMEFuemlmZ3c0ZTEvQXh6Tm83ckFMeE1taWJtbnhvSllm?=
 =?utf-8?B?aTJoZHhwM0JPNTZINmZ0VnJoT2Zoazg3U1ZvVDBhWG5tVFBLUE5VeEQxMTJQ?=
 =?utf-8?B?NFJ3V2o1WGdoZVdzZ04rYU4vUnJjYkVxVXNjbFdPSG9YbDRIeGdPbnFwTGxS?=
 =?utf-8?B?dzJBbWE2TkwrUGhyR2lXbHRqczU4ZDJEdERhbCtibzJqSVpWSlJkR2VTVm1H?=
 =?utf-8?B?ZVJkOEpyTnZTRG53cFVvU2MxeGNobVhUeDRnQ3lGK3BsT3hxVzdRU1ZOREVE?=
 =?utf-8?B?aVQvbSt3dVdHcU12dEJtcnBvc2hrVGNJbCttY2QxeW13UjVSTG1QbVcrQ1RZ?=
 =?utf-8?B?YnM5c3A5K2NOcFR4eXA2RDQ2M1lEa25Gd3FaWXE5L3BJM3NhZTN5QzNVNzdB?=
 =?utf-8?B?L21MZjRNUlFITGo3MjFCelEycFVWSjV6QlFlWVZCOW1VTDFJZmVQckpNNFVs?=
 =?utf-8?B?K0kwNWdrSlR2K1BzeEV5NDlZbEs4am1FKzR2VUZsRTFpQ21UN25ub3NWcWhL?=
 =?utf-8?B?RXBNYzF0SWtrUlgyRGhicFNwYnZTaUJ5YVVkNUlRMEpZSCtrN0FoWDVOdk92?=
 =?utf-8?B?UEFKbTd2eGt2cjBmWnZnYzNYSTB6TVA4Y3lUMnY4bWthcFQ3UHRtOVZ0dzM5?=
 =?utf-8?B?ZjNJazYyclZLZW1GdXVVVWxEOEZBRDlBTisyVWtSS0VzSVM2eTR4WVdoR05X?=
 =?utf-8?B?OTdQYndhSS9mRzNzSTVGc2ZxUUd6em00TVZ0WDF1eFVDbXdnZDRWSDh0Wmpw?=
 =?utf-8?B?M0dHeFNPR2hBVFp3a1hjS2VCNWJhTlFUcG5JS0hYRitrT2F3OEx4dWlzcDBW?=
 =?utf-8?B?YTlCWFJzQ0JSdEdVUkFiR2dxcVZXUkxERnI2M25PdnZaMmFKUzV6cTIxbkU2?=
 =?utf-8?B?YWJGUnpJeHloazh2QlBWTWc4NEt5TG5pK3R2VW93ZWJkd2JIWE1wWnRxdmJi?=
 =?utf-8?B?Q3liMklkSlQzeHdaM2JCMXRNQXUrN3VBM0s2WEJBc3l0WVlYWDZXUkd0WW8w?=
 =?utf-8?B?ckxud2JnT3U5eGFYa2FFV2hNTm51YTA3LytJdEVvMXU0b25ma3hUVWhOeW1C?=
 =?utf-8?B?R1ZqVG9OWU5TekkvTVl2RGViUEJFMXI0WDRWdENKMVB6UHIvaVpDVHliZENv?=
 =?utf-8?B?MVo1SXNXVWtjZm9kN0dnUnVyTEUrTUhHRVNmU0lPcnhUTU1UNDRVVmlxTUdw?=
 =?utf-8?B?QzB1R2Ryb0M2UVdFNVRmcThsNHJwQ3c1TnA4TWhqaFZNQkp6TjV4Z2o1SEpR?=
 =?utf-8?B?OE9oL1JFTFNGLzVpak5URXBEdTljVU14TjFjNi9kcTlkc25YRTZYdWRNSGxR?=
 =?utf-8?B?Z2lESTRqakFOT3pxdWsvZFhqc0FKVEEzNHR6dm50bzdsaEhOU3hVbjlweGdO?=
 =?utf-8?B?M1pHZ0dxMVlNZldWeWxFTk9NQTZJQ1g5VDY3elVvQU9PZmNMWXFjVER2RTF2?=
 =?utf-8?B?QVl5YjBtYlgrYWgxYXduZTFGeU55eTNFVEJsYVNoUjY1WjB6RlRNRytpMWR4?=
 =?utf-8?B?V09zeGFaeDRFV1d5UFFjb1NsSkJ0bVpGS1hrT0dGR0Exb0NtZjVZYkZHUDJ4?=
 =?utf-8?B?ZWI2SDlNbzVJZjdTV2ZUWFF2MzM0dHFiVllaM3l3V2lTOFAxZEtodyszdXUx?=
 =?utf-8?B?azBGUHRNaTBMa0NxL2NvZmFpUGVNZi9jS1BwbmsvemYvbjlOVVF3S0dDMlM0?=
 =?utf-8?B?VVFQZWIzSmVIRFM4b3dMekJvb0xieFF0emFKeEtOK05MNThWc2JYQkVXRFRN?=
 =?utf-8?B?VTl2NUE2c0oyRHkvQjVBYWdSYzVRa3hLbThoUUJCWTN5R0RPa201TlVyWTlV?=
 =?utf-8?B?RGU1S25ONkdFeWRiMWlaNG8yV3BCbGR0YWlLTG5iZnI4Mm5WTE9kM2VZSEhp?=
 =?utf-8?B?Zzk5TURsWWZ2VW1pRkRpL21OM2g5aC9WZGxCMloyRkR0Y0NiSXhKa2V1SGc5?=
 =?utf-8?B?RGV3b2VWYjJkT1FBVnJRcXoyd1VlNGNCSzJLZW1DTVFWREJVWjAvdGlUa2JJ?=
 =?utf-8?Q?S/zuQz149rJ4WJZhqMUPOPQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 42048a6c-80f4-44ba-3787-08dd4a914ec5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:43:31.0450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wybrgOdXfmhHE4DKBoIXIlj2V7VMua26hDzU+QaC5duC+ZqLVEGImmTdxQ+TyXtt+AusJkhOLeIBBDk0CrKol67tSmNfjwQuvLLaWRU+x3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7041
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

On 2/11/25 12:35 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2025-02-11 11:29, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> Essentially the only differences between u-boot-rockchip.bin and
>> u-boot-rockchip-spi.bin are the formatting of idbloader.img which is
>> handled by mkimage (via -T rkspi/rksd) and the offset at which U-Boot
>> proper is flashed, the content of the binaries are identical otherwise.
>>
>> This fixes some issues[1] where binman tries to find the symbols defined
>> in the proper binary to install them in an xPL binary. However, because
>> we use the binary for proper (on Aarch64) generated in simple-bin image
>> node and not simple-bin-spi image node, binman doesn't have access to
>> that symbol anymore. Therefore, let's depend entirely on binaries built
>> by simple-bin in simple-bin-spi so those issues do not arise anymore as
>> nothing is compiled essentially, just assembled.
>>
>> [1] https://lore.kernel.org/u-boot/20250129132529.807031-3-naoki@radxa.com/
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   arch/arm/dts/rockchip-u-boot.dtsi | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
>> index c8c928c7e5089db3a2239f2564e6dee1d82aad95..2e8a3bd09e49ed73a8cea3fadfb6d2b592082365 100644
>> --- a/arch/arm/dts/rockchip-u-boot.dtsi
>> +++ b/arch/arm/dts/rockchip-u-boot.dtsi
>> @@ -187,18 +187,28 @@
>>   			};
>>   #elif defined(CONFIG_TPL)
>>   			u-boot-tpl {
>> +				type = "blob";
>> +				/* sync with /binman/simple-bin/mkimage/u-boot-tpl */
>> +				filename = "tpl/u-boot-tpl.bin";
>>   			};
>>   #endif
>>   			u-boot-spl {
>> +				type = "blob";
>> +				/* sync with /binman/simple-bin/mkimage/u-boot-spl */
>> +				filename = "spl/u-boot-spl.bin";
>>   			};
>>   		};
>>   
>>   #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
>>   		fit {
>>   			type = "blob";
>> +			/* sync with /binman/simple-bin/fit */
>>   			filename = "u-boot.itb";
>>   #else
>>   		u-boot-img {
>> +			type = "blob";
>> +			/* sync with /binman/simple-bin/u-boot-img */
>> +			filename = "u-boot.img";
>>   #endif
>>   			/* Sync with u-boot,spl-payload-offset if present */
>>   			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
>>
> 
> I think changing to using a template may suit binman better, however it
> will be at the expense of having to re-generate the FIT, not sure what
> option is best.
> 

Unnecessarily rebuilding images is not great for build times :) If I'm 
not mistaken, binman still compiles sequentially so doubly not great.

At the same time, this is relying on undefined behavior (according to 
binman spec; i.e. using a binary from another image node) but we've been 
doing this for a few years now and it seems to be doing ok so far?

> It would be great if Simon can split out the rockchip-u-boot.dtsi
> improvement commits in a separate series as I suggested in [2].
> 

That's fine but we need something soon, this is already preventing 
people from contributing stuff for their boards. I don't mind either 
(haven't checked the template stuff so far though), just no need to wait 
too long for the perfect implementation. Also this can be merged as an 
intermediary fix and templating done afterwards.

Cheers,
Quentin
