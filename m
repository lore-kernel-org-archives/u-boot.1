Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCCAC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F67D8006D;
	Fri, 16 May 2025 17:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F8/5N8ZM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8770A80079; Fri, 16 May 2025 17:31:44 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ECA080050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPhldf+ZclSYwiHYNw9hxzM+X/BiTQte9K3M+HHRtPsZF841jHZj2apsyUReS6m7QM/YkqTtd1tNICHYeIM5lXZoGo/E+bJJOpQwLT9vroeaqPbVQeTp4D+g38PF+oy3jJmnlTkCq8fpTLOewfVK7wOyd9hZhuvjtQVWxo1zxgE3WRgFGxrGiRE34WQXXOSFWko4zvaT78TFrNZM4qoA0UDSouF8YsGudkZAQzgte18UlZ35tVaukwlHOphPCeO8LmK8NH/CCINohRzx4BoyHIkgVAbmNIUGWGqHgq0aKz+nvKBUPjJI2IFFuLu99B+lm4MT6huk078nop3RRnPbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnnbu6F6ukZPjZSoKa6tC7eFRuNVuTiJ8uXKxOc9Yac=;
 b=nxZZ24gZm3mS+kOYBMqJVO0JlOiobk+c8ekq+8a4Ga305vo5+Xt4rp8phRAZzT1xMcHgT7VMmiaCBr7EHx5mkrDuq3y19hwOYFRKUwuj4dtz2gzt75Byz2cV6HRAVWQi26NhdCnM1WyRjQLDyJOW1KWMxx7GklDPEyMHv3ilIQ4VgA4AHSt6FMdl3u3jSD82/jbycCBDPXslb9Mw4UzAumvZcTkZzghjeCIfdV/MWVkBT4mpX4P0HwLPtzU9tlkeT0hrrJxbfYPMAqAJ0FGdpp3gUJwBcCUbDfqOqdvYvtcS6Lp6ec2QASd33obVi71vrJAuIBHq7OSKCPiM4u8CfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnnbu6F6ukZPjZSoKa6tC7eFRuNVuTiJ8uXKxOc9Yac=;
 b=F8/5N8ZMVdSWR1hmifDzAU8/QNuyjcs8bwWwyFQzi/PSe+gAQTaKyhOonR1xmkoSJ2YLRBx1felbXY2pLag236RSCQ0fgDmSoFjtOdqeT9VmvFDMY/1rfLgFXjXCaqsg84Qr7EY6Y6uznyjUDRllnYGD5joFkAuVEfehkX8FPbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7757.eurprd04.prod.outlook.com (2603:10a6:102:b8::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 15:31:40 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:31:40 +0000
Message-ID: <8bd3cdd7-4e07-4f4e-bdac-3bb14bc23b91@cherry.de>
Date: Fri, 16 May 2025 17:31:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-3-dec6c8391f01@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515-silent_console-v4-3-dec6c8391f01@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: fb692bae-f95e-43bf-6063-08dd948ec143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3dnNmJWcDhyVHRxUDk4Vjl6QlUxbGZaZHF0YmVvL0xraWczY0toVG9hcVZi?=
 =?utf-8?B?emdoVTVrZHNnQ0FubGp3aVNZeVhRMEVCWDJqaklvZllSVGdPQTJOeC9PYkFr?=
 =?utf-8?B?ZFJHYURKZUt3ZEdMa1p2ZXVoaVByZ2M1SC9vRjh4VlIrUE55dHNVbE45b1pn?=
 =?utf-8?B?eFVXeWprMEoyblduclZQcTVGQ0tzSXhjMjFHdU1nTjhkbjVYOFpGQkNjOWhq?=
 =?utf-8?B?Zy9TQU8zQ1JkbnNjL2VaRXN0TDl5dURKK3M5dDM5b0M5YXpsSDcrc1c5QTZ6?=
 =?utf-8?B?eW5oWFpjR1FNdjludHp0U3pYT2F2QzNzWHAvYWIyQmxwYTlDejVzay8xMW55?=
 =?utf-8?B?M0xUT0U2aDhLdklYNjJFK0pzUUptQ3ZvUTBtaERuUk4rODFmWW9Ba1p5RDho?=
 =?utf-8?B?R3QzN2E4Nk5XaXVFN1FrTDA3ZXhKUGoyZ1lpYldaUS9JcUZ4aFk0TUtxSEVi?=
 =?utf-8?B?SFRPbFI1VHE1WEhZZjdJeUxrM1F4RDVrUWZnNDZkSzRSdjUyRGRvME5wSVdD?=
 =?utf-8?B?dGdwRlNRalhpd1dXaGYwRVFrKzVWMHJiSXczVWx4MmpBSUt3Y1g5R0pYcW42?=
 =?utf-8?B?TzNUR29xZVpDS0QzUVB0OUNqL2ozTkRPem8ycHEzUUlGRkY3L1liWEE3OEFM?=
 =?utf-8?B?aTRXMFU0cGt2c3ErSlN4Tlp6OWNJekE3Y2U0Y1VqRVEvbVVVRVZFVEJyWkFp?=
 =?utf-8?B?MTZiMjh1OG5KSkVhaTRVY2tFd3hZTUhhYjN1dFRpZHphVk50Z0tPNzg2OUp0?=
 =?utf-8?B?SFBFd2FDS1BLcmo0L1NPK1hSaUFjcTJJY25FTTRHUUhObVlGMkx5bE9BaS9L?=
 =?utf-8?B?OVhmMEtmcXN0b0JFSXJ2UXc4Yit6K1BnY3hVcHMxQjRlRWxzQnFPSG1ZYWFy?=
 =?utf-8?B?M3A0Vzd5bmZjTjcxbzBSNGVkMndtN2hXeXU2aWRmdlNIQ3JZSjZsSFZuVUEy?=
 =?utf-8?B?RHpwTDhDTEw4ZDZSZU4wM3dWV056dWRuOVVkcWpxeWtlclFPNElBbnFpV2hJ?=
 =?utf-8?B?S0JnNWVSWC9nM3BkeHdmc29jM3I5eCt6Z0lWelJWK1RTRHlMVHR1WGc4eGRu?=
 =?utf-8?B?YnFhYXlTVyswUWZQdWl4WXVhUDVrd1ZJZnZrY3hHODN0T1diVWxncEJubC9K?=
 =?utf-8?B?S204bjdISDFyVFpqVmw0OGlDVlExR3dka3V6MnN3M3hBOTVzYTFPTTNFM3lv?=
 =?utf-8?B?QjlBY1gxUkZoYW9VNUtvMHh6QkxtajJSUmhNS2NjRDZxRVZnYWE1RnRiVHE4?=
 =?utf-8?B?c2p6TTczeWNlZjRZNDR5MW8yRFdxTy9qRlNTcS82WS9GOUdHOHBVeE01MWNZ?=
 =?utf-8?B?ZkxWSWwwWHdaY3ovQThxVnlzd3Zpazd2ZVB0cDk0MVNoU0h0aklQYWVRYVl5?=
 =?utf-8?B?UVRKYitHdk9IOThWV1M5UDFLczRScXlzWmUyRmVBZ1pMWmN2RnpNZnZKTC9m?=
 =?utf-8?B?YW9mQ3puK3h2K3Fyam9wcWZVbC85Y1VHd1dKK2tKZm1jUGJLcXdWM1htYW93?=
 =?utf-8?B?WkhMeUhlMzc3ME1MaU1YNzNTMlVuZWVITVRoNnJkYU1TdGJWTUt1YTJ4dDlE?=
 =?utf-8?B?MUU3ODhFbFpzSVZsNGk1T3BrVzlIUjFaRFJwcElTVlFiUjdSVnQ1QVdhODY2?=
 =?utf-8?B?RHJQTWVnNWh6dVJ2SnJYNmlncUpOeFB4clNCVTlyY0tRK1VGZVZoRFduSUxm?=
 =?utf-8?B?NXg0a1E0R0MwbmZ2RFljNFd4VDZrZUdQQkNEdnplYXQxWVpPbFNoYWt1LzJr?=
 =?utf-8?B?WGdZYmVuaS9HUVVzRkNMU0RuM1pNZ3ZwRWJpSkJjU01NN1FjbzhIeUM1ZytM?=
 =?utf-8?B?QWtkUTJJM1BEL3dDQkdDUWZhMXNyakhjU2hISk5kNlV5d3dKdU1saEJ1ZDFT?=
 =?utf-8?B?SDJ4OFYvUUZvV3lCMTU2b0k1MldROHpJTXFhd0FaTGZZSTBrNDNxR29UeEgz?=
 =?utf-8?Q?XXl4cgF5ue4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU80VzRJcXhORnVPb28xNlhZcjZKOWpLbEREdkYvb1YyaG11dUpNczhEV0dN?=
 =?utf-8?B?bUxRTDI3TjY1U2pLb1R2TG50UTk0dFgvcjZsbEFVU3pTUnM3eGNIUmZjbndq?=
 =?utf-8?B?dWpUS3FhMDNnUklZMU1GN1lNVTFWdHNPUHlITzNBdE56UHc3WkhWRWZtWHVp?=
 =?utf-8?B?bjFYYUFVTUIyOVBhMlR6Mlh3U2hhdDlNdnF1STR4QUMzc1J2bXRKUkdoK3Nr?=
 =?utf-8?B?RGk0T1Q2MlR6OVNQMWY3bUpYN3BZZmxaY05RRjl1N0d2bnN5WXdGWGoyOXor?=
 =?utf-8?B?SzNKOS9RQkxFKzF0MHBiamI4eUNYamJ3NnByYVBiMVV4TlBiZzVkZXVxKy91?=
 =?utf-8?B?M3JNendVQnJHWWxhYi9JS3hNb0U3REtSOHN6SzBsR0dOL3lVUWZtaTFwOElO?=
 =?utf-8?B?UjRFWDcrTTFsemovZGRqemhTaHR4b24vWk4xT0ErcSs2NVFXOE9SWHNUUzhj?=
 =?utf-8?B?aWhPN2c5YmcrbmJsd09idlpJbXV1Z2hBSFlMZndrVEtJSkdnYms4Zk5xRjl5?=
 =?utf-8?B?Y09VbElqMFczbHVOZHdQT0ZTMHhIMDZtcWE5dWlReWxUYUtmcVFVclFrTFZ0?=
 =?utf-8?B?TmpEQUpsTlhQMDViSFhrQTFhRTZ4dVJHQkZFaE03ODYreU94Qzlic2tzTkVM?=
 =?utf-8?B?QUJqSWYyMUdub0ptZzFpdHIraUdtM0JRcUhieG4vNWh2TFJxZXZhR1VxWjB6?=
 =?utf-8?B?ZEhXU1Y1Tnd6VjFjYThuUk5QUTAyV21GVEh6dzY2TEgzUUU1TG1UbUwrZ0xY?=
 =?utf-8?B?UnNDRU15ZnYwTWQ5Q3Q4YUcwVk11MVhycDJoM3FjQjhPVzMyUFB2TW4wbmYr?=
 =?utf-8?B?dEdiYXdmNHhMcy9DS2FwT1BxZk1ncTZWTXBpT2IxVm9OWjcrWFZWWWtLeENU?=
 =?utf-8?B?aE5hR2c0d1V5cXQxV1ZCV3ExT2o3d1FEOVBoRWtJNmx1RHZjMVFsQVE3bC9u?=
 =?utf-8?B?aFJBTjkvOTd2c2xjcmVJcnF5ZVd1Ry90bzQwemRucWJLbHUxa1ZXNG42VElJ?=
 =?utf-8?B?NmVNU3NGYWdseGJlZDZJdVJETVJSZlBMQ0tiLzY4WThBTjNPK29lQllsL1Bv?=
 =?utf-8?B?M3A4MDZzNm1NTzNrQWo3RmhXWWpacERZZE13WTJXYmxDbkJ1UG13VGszYzdO?=
 =?utf-8?B?eVlEYUozL3pId01YdlI1U3NWY3VzZHVIeWZLQVR1Qk8zS3hPUXpKTkFIMjJa?=
 =?utf-8?B?WlJhdm11TXhIZWhyd2I2WXdUa01GRlFWRTUzaVRDTThHd3A5a01Dczd1WkVB?=
 =?utf-8?B?RGhHeU8xSytFMlV0bTFqdkRobytUbjBTQjlSb0NQV0tqNmk0aXlrSkhyM2Rh?=
 =?utf-8?B?aFByVDlxd2V4blM5NFlJbnR6TTErSi9ObHdmSmpHa1NOU2dJRk1KVTVYWmZJ?=
 =?utf-8?B?UnJTM2w4QmtRalpxZ0RCWFFXaUcwem9UMzA1UldpQWt5ZGppcnRXVVAvOEVi?=
 =?utf-8?B?d1RGWXhYNlJGR201TFBrRzIvalRsb2grd2FrUXpDV0VYWnpuZ0JRV0EzQ1Rk?=
 =?utf-8?B?c2g1M2U1OEhkS2hnRFdreHA4RkVodDQvd2lnTXY0STVaMXZPMDRqR2RNbUcy?=
 =?utf-8?B?aVpxVllpem5xWUdtMHNmVDRtQllFdTJvWFNwVGtjYkVWSDhFNzBKNGhlSzZS?=
 =?utf-8?B?dDlZUzhzdi9wVktDOCtBU2VjODNjdGVVTXphZEZKVVdVaXArN0J4bU5LSENP?=
 =?utf-8?B?VDNqUzgwTTY0N1ZmK2FvZUFIZ05rTnJtK1drdWJLTmZwcVp3QlJqaVllTWNv?=
 =?utf-8?B?QUNXc04zbWdnamt6YUwvRzRzY3NuQlFFbU81WElNYjRGeGo0N0c4dUttd3Rr?=
 =?utf-8?B?TUgvU3VZT2hyQmFKWmNRYWp6OFhrZHF5S1pRcS9meWUvVDFJMWhQM296N0Mr?=
 =?utf-8?B?TnNRU2tGQ0wyQlkzL3FYd2dtcXNJQWR2Z2tqZ0p0dUZiU2UvTWxPNUlNYzZ2?=
 =?utf-8?B?dmNFZmE4OXRXYUd4MFBvR2FGR0dJL1JJZXVGNGlNWHd3VFF2bUR5ZC90bUNF?=
 =?utf-8?B?RmxxZkt2SVovL0NRdHJXaE5tbWVVWGhLK0R2WCtodGJ5YjhRUXNySTZQVEF6?=
 =?utf-8?B?WktjSzBrKysrWHBiVmpSR1lmRGt1RXRjWWxxMkVrOGUrQWlIbFJrUEpjU1Rr?=
 =?utf-8?B?ZnFQOU5IZ3RTLy9YUk4wWDROdHdGcmJwT0FVMnUvUlV4czZsbXRrNVpNM3lq?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb692bae-f95e-43bf-6063-08dd948ec143
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:31:40.6749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZPaNoLTyq8zrYYQAx2lecZM53alZQ1oWHTrhaD1SWlBe0gpAmAdMOBxsLoZ540Nlby0j542cwIdy+XoWA5FbJWwTWRultPOssyzsCF+Gmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7757
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

On 5/15/25 5:55 PM, Lukasz Czechowski wrote:
> The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
> available, otherwise it won't have any effect.
> 

I think it used to have an effect before patch 2/5 no?

If that is the case, I would recommend to reorder the patches so that 
3/5 is before 2/5 and in the commit log you explain that the next commit 
is going to require DEBUG_UART to be defined in order to be able to use 
printch/printascii/... That way, expected behavior won't change (i.e. if 
I checkout at patch 2/5, I don't get anything on the serial anymore, but 
I do if I checkout 1/5 or 3/5).

Looks good to me otherwise:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
