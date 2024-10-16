Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF207D206A4
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 07:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04E3588EBA;
	Wed, 16 Oct 2024 09:19:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sh9cv/aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D35588DDC; Wed, 16 Oct 2024 09:19:51 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F5DC88E6E
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 09:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RslpWzqWo9hhw4wt9XZdh2fyCEBpPQ2AjEGQNJdFwHdXNiuNUSmgEZJ3KyrqH31KYGJnYcVCtzLLRXSwD+mbbnBH93qYs/1Ny5XPgsE4WCR1cS/MLVSa6C4RFziBR/eKF56GZtE+jaFhyOAiS7cYjoC5PcuyFtWuKmNg16WnOXg1GGLciaIP3/Cl188H7fRpU0Oy7QYJsK2cHBOl0CTcWpathCIhLdgEvajoqkbOU2a+mzal+o4Jv9Bz5H3oZ2tyGIZUAU7YKvcZiVIecG3s61ohE4Hn/fLvEbsniTBLzyso3fSzRF05OPr/FL2DegoyQuHYzcVIXxyi82tr77LFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXS7vaeu7UhrssPQl6jEXhfjyMV2idiVFLqqEOJZxuM=;
 b=jZzQZFMuSbTbBJcCEXbIjP38b6SYnAjMQMQVBK2ZooVnUVDEZ8R13cUMzltL8zSyHqbo0/x9GgWgKt+CoqZ6OCN+NtNXXGUHgicbFazJW9mqXTsEQ8Ia1vW5Q6XmzTgdRzKxSoA5n4foypddwMHf5IzTR7i4/TuTZUdGMvHsJMWVkS35AtSI41fuMw9lcIg7lmTU7EscwTeb7YwHLae7+fopIN2akTmxQ1nsaxuGTZ16dAO28yMUmNV5ywVZSC9Ad5+f5CvwWo5X6Kn055uRwM4uH02YSdX1uqplK9sVIyUbN8pjAYOcDSeiTyTyuhV/ENAMGvJyRFJWsYLkDq91Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXS7vaeu7UhrssPQl6jEXhfjyMV2idiVFLqqEOJZxuM=;
 b=Sh9cv/aj4I0acBcFDyGRExxxB9EY4UwTo3cmU4QQrjpwj3Zx14G6OQMnpGwU0Dt+neoIQkgQtCANM/inUZP2l/qsfq6TDEsjJWVPJ1SF5MafY8LdyqKgPSfgvjOoNcIIaEgjOOKB9oETcImEO2qrtuI98kUwQeZAGJuPc0W9h1JMpmv23kGBasIrOZl3JjwZ22OA0CuOb/+kV81DNikIt9D0endehF+h81NcFk68oxiVVS4AM4x8msX2U346WpZUrKR7WkEMtcLTSzbZVMZu4JSqhvwCzyZbB1GQOnEIA39rJaQVGH0HRycs57t/ZRnPl4LvZHqFXFYWpOTGTAoi2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 07:19:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 07:19:48 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 16 Oct 2024 15:18:06 +0800
Subject: [PATCH 13/17] imx: Kconfig: IMX8_ROMAPI is not configured for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-imx95-v1-13-f640c8f3bc1b@oss.nxp.com>
References: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
In-Reply-To: <20241016-imx95-v1-0-f640c8f3bc1b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Alice Guo <alice.guo@oss.nxp.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0016.APCP153.PROD.OUTLOOK.COM (2603:1096::26) To
 PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: cb8625b0-891b-4a4b-57a9-08dcedb2eac7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjB0bWZGSjRuQ3kxM1RjajRwN2hOZWprb0gzVzduTG9ldFc3L1prdWxwMndI?=
 =?utf-8?B?Z1lPbDNFZm9PNzIxUWphYlVUc0htT3RPelhwK09vdkdIUFFhVXpxL0RlNUdJ?=
 =?utf-8?B?UnpiMkVITHM2SkJUWnJWVWpCOUY3c2EwbkxDbmVVT0p3Sk1aaTJuSm92OFIx?=
 =?utf-8?B?NG5YZlUrbXBoWkIzNVlWK0w1aW52NEFJZzhUTHBVR25UZ2pTUEh1ZXl2M3ZY?=
 =?utf-8?B?RFpNZVk1U2dkVFBFQmpXaEJ0b0RwRmpDU0JYZ2hTcy9JNzJTZGNobHU4R094?=
 =?utf-8?B?V1NCNnhkRUxRSlNOR3hsSU4xRUJvYjZ2bVJPUDlqbU5wT2VLVWRQbEdXbkF2?=
 =?utf-8?B?djFQRFZqNmhuaGZCVncvNTJwVjFmUS9XR3E1aTRWbTN3TlhVcnBUTHVya0dU?=
 =?utf-8?B?d2l0cWRPMURPYkg0N2xVeGM2VUVyeXY4MGYzamErQkVTQUZuMk9lSCtyT3lh?=
 =?utf-8?B?UVgrZUVCMXZ2US9pTmRrSWJobUVDZytleUR0ckh2djVOd043YU1PaXAzTzhM?=
 =?utf-8?B?YzN0bTJNcGFCeTN3QWxpeExxem40R0NmdE5iYkphRDRNYkVSZDZHYU9KejRL?=
 =?utf-8?B?QVBuMXJIaU9ucmQxSFJobE9rRks0S1pPSDZXZTZNWUZub0NSUUxjMGJ5NlFG?=
 =?utf-8?B?c1BZdVdRTDA5eXJHdUUydVVPeXN1aWtGcE50cGVwcy9kbTY4NVFKZ0JnblBP?=
 =?utf-8?B?VkNzdUoxM1hINFJOc2wxZXkwV1NrTTQ2SjVDUmNmTy82M0tFcTBJTXZPbGlG?=
 =?utf-8?B?Ylh3MlpuWVFaQWpjRGorKzhqK09xZVlodmlWR2lCVUlOZm41RjF4djd5UlRr?=
 =?utf-8?B?MWduSGpQTHZzVHAyTndkMGplT24xbkV6Q1JqcCtNSGo3N3hHeVUxSlRvSjFM?=
 =?utf-8?B?dmZ6ZEcwdUhPZ3JtVXpneC9hdmhiYm5mNHg5bmRMYnRYZDdpWDY2d09wbm1T?=
 =?utf-8?B?cFhjRm9uNGdZa1hlUmtlM1diMVNXSzREUDBPNjVUeWRQRU4rSTloMzNIVU0z?=
 =?utf-8?B?ZHNaeU4yV1QzR1NENk55SWNKV1pvQ1N1RnFaSmNrY2xSN0hkaDRmd3pkZkZs?=
 =?utf-8?B?YXB0dUlMUzRoVXRwOHZmTzlONVZFbXFteEtaanlCbDhqUHVMbVlhalhBQnV1?=
 =?utf-8?B?ZkZoOTNvTzlHZHdxd3Y5TXhJb0dCbmhxWUpUKzkrKzFZeDg4ZEgwWUxjM0tS?=
 =?utf-8?B?MXpUd25kR3Q1RW1KRC8wWXN0ZUE2TWRQTHNHVUtkWkoyd0toRDVmZWlTb3gr?=
 =?utf-8?B?Mk1pZ1U5QXVjemJ6M3ZNVHdPcVV3ejhmY3NGMVJNUmxXR1lONzZNRE9BeGx2?=
 =?utf-8?B?MjlKVXN3UlAzdFN1MmZCcXJvdVk3STFTbk1jS2dCcGRjWmswbHVPZnErN1Q1?=
 =?utf-8?B?TGdYRzkyT0lralNVeTNtY3FwWWg0QjRKZEFwVk5jMklPWXRXdGFoZ3ZERklC?=
 =?utf-8?B?aitibWEzRnpRU291c21FR2VYclEyZ3Q3L3dDTkFBTlNqT0w0aFovOGo5K0k5?=
 =?utf-8?B?VHJ5N01qbUJZOHp4am9XTmxIZ0k2OGFSWGg3WDJpdUFNRkFoNi9LZWRDeS9x?=
 =?utf-8?B?bGpIL2VSTTk1K3lDMjNpRDhXalU3RzhMUHNZT2JjeGRDMCtwRDR3bkNhQkkv?=
 =?utf-8?B?b2VJY3lXSXpQaVRxSGNYTEFEaTlSQ2NoUkJCNEN4RklDUW43RzZLeHAzbjg5?=
 =?utf-8?B?T0w5WkFKYzNYeXVMU3lXYnZ4cE1jektROFRkUEJmZ0FTUGZEejlpeVdYUDRp?=
 =?utf-8?B?cWx0dnJKZEJFVWM1NC93NHcxSy9jUnpReUE2RzJMa3VFN3FVMGhsWTRqaDNx?=
 =?utf-8?B?UmxxeGlZZTdkUVJYdmRkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enp6elNWQkIrWWZvd1Z1RW5KMDdCL1g0K0xnVS9GeU1WdzdQZm5GbVhXTkNL?=
 =?utf-8?B?MUUyUU5KazA2azFuTTk5eFdJejBnY1grOWhHS09kTHZYa0RxWTBNU2dSTXpN?=
 =?utf-8?B?NjNMbk1MNXNTRGIzRkZRdythWE16eEZzRVh5cHhwV09EVDdSeFE4RFR4eHVC?=
 =?utf-8?B?WkdOYlJReDdkUWFaU2EyQ05FbG4vMHZkQUJMZEdyV1gyRlIyQTMvWkd2bWVW?=
 =?utf-8?B?UlZ0UytmRFFNZWovaWppV2o1bG9OaVJWYkNhNkVwRWhlTmhXNkRiY2Z2MjQz?=
 =?utf-8?B?dE44aUZvSnBGTmxkM0xBWFpEOVRqWVgwL1ZnRHN1MXFzbnlKd0dEMjZzRmc2?=
 =?utf-8?B?ZVRYbkdlMnZSaDM1QXJYZVp0SytaTnBjem9WNlVnQlJzYW1mVmw1Y2hjSnQv?=
 =?utf-8?B?QW42ZE1HUmxaVnhSd3JyKzNBOEt6Y0ZZMVd0MDV5bEhQdGpKczNjSnlNWlRY?=
 =?utf-8?B?K3JFdTl2Z0dtNnFGWHByamd5WVNaWk41ekdWdmVSMFpoYmdVSG9Ma21aeEIy?=
 =?utf-8?B?TnlrQVJPTGZSVFJaZzBlZTVGU2lteUVxQk1SOXdIMzhzS0JmMi90Vml0dmk4?=
 =?utf-8?B?WTRTRTc5UlU2U3UzUEREeGdiNk5Ea05NWlJlZUNrUHU4eFEvZzY1cmw0UWt2?=
 =?utf-8?B?bDE4NkRZazNveEttbzhpWnI1RmU5VWtta3d5MVNaVittSjlVNHQ3Z2pNTk15?=
 =?utf-8?B?d1c4bzVVOUNleTM5ZDNRVTJUKzdaOWxyZ0dJeWJ3cW8wdzdKb0RUdS8rd2hT?=
 =?utf-8?B?Tm9SZ3dJekh2UEtGU3Y2RktTQWtqaE9EeW9leWFSQWdDR3h4cEhSdUlRZXR2?=
 =?utf-8?B?a1M4ZUVGbUdjRVZXYjRYbzZaaFdxNkdKdmdSbE9XdWx4d1dNU1JLS3c4RUtJ?=
 =?utf-8?B?R3VINmJheHpXdnV4bHZEZzlFSnIyaDNOVEs3WlJsTVB1TVdPSUcyakZFa1lj?=
 =?utf-8?B?SDdYNVZPVlB5cStEblprVEFVeGVJMVFzNURIak81MldZMUlXTXcxY29zckxE?=
 =?utf-8?B?azBCaHh4ays5UXZvWUZHZG5iNS9XV0ZsWTJMZ3k3Rm53QlQ5UXA2cUtrRzZL?=
 =?utf-8?B?V2orcHlsQXVkazQzN3BFa0JQQmxPWU9HZ29RWER0VXpJdDJrN0ZsbXVVdHpO?=
 =?utf-8?B?WUVZYm5ZRm9GYlhtNmd3WDRseVROYkt4V1FLK3lkODRqM1owL05jUmlPS01R?=
 =?utf-8?B?TzBGbW9yZTRuVnVEbHFNcHF0SGJGOCtNbjhBMm4vSUExQ2RKdEtXWHFxbEVl?=
 =?utf-8?B?V0hTNGlvSUZqRUFZUW44N3ZueHFQalBNSUlHNFh4V3Zyc2p5SEVhTDg1WlBi?=
 =?utf-8?B?Wm15Z3NtQjBZYUkxUGVjeUQzSkpiYlF0M0hHV1lTQlp0Tm9kajJXeHRHQ3o0?=
 =?utf-8?B?Q0hzd0FaUVNyczlUTHFBQ0VlbFdpOUpYN1dhMkxIalltVEJ2OGE4bnpteWpT?=
 =?utf-8?B?TDJUUXFpdmtrNDJpT0VudnlEQWwrR1pmSitMZWNUUmtHY09JUnkzMG5ob3F4?=
 =?utf-8?B?WGdPdElCb0VoOUtuMWV0TkJmWVJWQTRiY1ZENkVQMHhQcGdxYTRQUyswMTVX?=
 =?utf-8?B?MlpNVjF2MVBWbkpXOHc3S1FlNWw2SG0xSklKK0VNRk5aSVZkc3VEY2F6alV1?=
 =?utf-8?B?VGNUWTRTRlRzZE9jWFF2Ym1wZytBUmlLTnhUTDRvak5EK1RUM1h5N2RsWi9u?=
 =?utf-8?B?RjJYM1dnelZWamk3ekVmNU8yUnVwVnhMNGNYR29jZDl4dUROU3dzZ3dSKzZR?=
 =?utf-8?B?dkVadWdOZWQzZG9KTGVhZGw1WHZnc1owQ0hQL2MwUFg1UldVSGgzclRCcE1G?=
 =?utf-8?B?c01vUnVvejlUb2N0KzNSM2U4SFM3Ulg0TVcva3lnZjBNRm1oMUVWUzViVUxL?=
 =?utf-8?B?U3g3YmNma04vL2pwY2wrbE9lUEN4SURncGRFS3VIZUNtYlh5cUdIbFZwNmJy?=
 =?utf-8?B?bzBGb1lOS0cvSjRwV2ZLZitXT0RPbWZuNFg0UkxEWi9LSlh1S2w5Q2lKZGRy?=
 =?utf-8?B?bVZJL3hHOXpXdU45cW9jQm9wWnhHM1Zac08ySHc0djJRUitMekx3R2FHQ1N1?=
 =?utf-8?B?Z3BGZHY0VWUrdW5TNE12NWd2QWdUZExVeGh2NnRYVFdtMVhGZUJ1R2NaWDc1?=
 =?utf-8?Q?DCvc31teGz3MwfniRqQ6Jfh/j?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8625b0-891b-4a4b-57a9-08dcedb2eac7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 07:19:47.9698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbYn6i5jqcWTeptOjEmABL+fWV35/dl9Uw31FdVNSDEplpkSnjcEAXhO6Ymwgw9+J/jBEQ8ed7Y7gmANswN0ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3787d78e28af03d40c41a8b2b1981b..56577b9ade349740b6d98ab933797d7072985de0 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -179,7 +179,7 @@ config DDRMC_VF610_CALIBRATION
 	  the ddrmc_cr_setting on relevant board file.
 
 config IMX8_ROMAPI
-	def_bool y
+	def_bool y if (!IMX95)
 	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
 
 config SPL_IMX_ROMAPI_LOADADDR

-- 
2.34.1

