Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CFAC8303F
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 07:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E3B18323A;
	Wed, 27 Aug 2025 09:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oIqt79nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 648FF83253; Wed, 27 Aug 2025 09:35:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62B32831E0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 09:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqRcpw73gHvRvOXbtJQ3EUbnC0db5NVy3njtGW/Jh1PYsN+WztYHruq27j5f0EKTg9RYRoJ5bQOYRMdNW/kWl0pOFSKk3JhQkc/zSKj6YE+zeogdou1prN71OYAXg/xlJ1rapWhg7pa0i5a4LbUemVDreM3NHWMBGfT3z9P2Rw2cycch4vKPlcIhFkluGe9wm1seXRbqVJCHIuhpy8j/NXpNAyPZR+8KXbbO44buUYZldxToryYU9Bb7tl2/kdThOuhdUju/v9hCkR1RqcV/Tpv4XMzVwfHbV/Ip83O8QmJUiD7VFnqAwN38k0fIoe3PaaabM4fv8Ul3QWchn+PaiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M51XvvnxgEfR321ddNFpvLMbRG+YekdQjcZrJg6dHWA=;
 b=ZKK1gbzUOMnWr1VIguNtOFFlg7J5/HXHFECcbOXbpWqFSm/T8r/mP+oHch9WBJ3FxCqJzwt1R1HXI9fXbIwF0w7c2kOqDVcKEMzcZgYhD6F/7k8pYezR/n9TwijgijPQ6s67eO4+abf6DEvDKdWk9tyhhmrQ2i2oDI/gf4yDsu/66jpR2+K0n1cbAFb683vO+SIttjqcztwzn9oGLUOnkjb+Kpx/DD7LfwQxC1dTvgK80t31kxQtcZYCqxGkj19i8lWGVOOgDUSBy/JibTMggtz8m8p/d7VQvrx7LjybQUlhXaL4eQPSQvQmQk85BqlN9ZY18Kw3Ex4S2/07cQpOPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M51XvvnxgEfR321ddNFpvLMbRG+YekdQjcZrJg6dHWA=;
 b=oIqt79nW/emZjV7MvKBqc7QSFjkx3OSREZWwJ5b+AdcRerD0zooWXeLU9j6cPNkXhxKYs8gxRpfuN2yfw7mdCm5a2NWD00L59jke4pOLl0JcXuahuw5QPywYQyjkgF9hv8zOglJusThthjvfmk4W1gXm1x41S/F0A3u8QPflDMEGMGZ9dklKU6Ax3W+0qRKva3m7VHDEhzikGXArNMic9osm71FB8UwDUrsJuxqTs4zZ+8HPhqghZsEm7GD+y4MGQEeKb7sghPvgbKWeBjCNmO01z1BKj8NK1ob7EqcEIc1pPWuXfFgzGYPyjWukao6/iaxDh5lJrvRlccllTF8oMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 07:35:17 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:35:16 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] serial: lpuart: Return value from correct variable
Date: Wed, 27 Aug 2025 16:46:08 +0800
Message-Id: <175628406773.4168.2812327330184464579.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250811-serial_lpuart-v1-1-6f498328554d@linaro.org>
References: <20250811-serial_lpuart-v1-1-6f498328554d@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e933ab5-5fc5-4ed9-819f-08dde53c442b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eVc0cGYwQ2s5UC9EOGFlbGFPcjlmV3NmZTBnek1LQ1ZlZXpJR2hkZ1U0Zmwv?=
 =?utf-8?B?MWRFMk4xRU54TGJBNXhJWnN1ZTk4ZWhXUjZCRkc1OVZ4K0JlaUNHcUNMamhU?=
 =?utf-8?B?cVB5dVdlaFdpWm50TDZidEFUK293bTJnNXhLdDBuZk81d1JEMnZ4RDNFRHA0?=
 =?utf-8?B?bWZwaXMvOUMrb2ZsQlo5eHpEa3JUbGhhaWNEUGl3UmVvWTFBZEVlenZNZ05q?=
 =?utf-8?B?OWxwd0Y0cUZxNFdBeVhPV2RBT3VzdCtHNFkyekVaNUpBTkcxV2JXMGhSaVh5?=
 =?utf-8?B?K3ZrWU1kanQ3RUxiOG9ib3pkbnVvQlNGNW90a00zbkhBUC9lWHFiMzZYNXJw?=
 =?utf-8?B?cmdOUkdleXpBU1gvcllZZ0l3akxzME9NQzhxR3AwUkwvT3ZudzVrdnRseExJ?=
 =?utf-8?B?dDVDdFozQ2hMRjg3T2dSWkxvamt2WUZXYVVHNHBLdnFNTmh6eHcvUFpDUUJh?=
 =?utf-8?B?OEMrWWVtK0tWdjJXdVh0eGZlWmFaQ2M4YXQ5VmNUMFNidjZCL0k0N1VjUlJl?=
 =?utf-8?B?RGZDa2l3cDdpZHhJbFBWdDNZRU42ak1Qak54YkozNFE1RTYxQ2tzSlhLUnVu?=
 =?utf-8?B?SHhJakk2MlpoQS9uOG5HYUFNU0JtU2hjNDRkYzZZajl1ZG1LbnVXbXUwVHpt?=
 =?utf-8?B?SGFFWHd0KytMV3J0aktRRGRoejFuMWlNYkF1MWJDTHROeWZBMW05cWxEL1hR?=
 =?utf-8?B?K1hmalF2OFdXY2tObGcySUVHVHR0VFVaNDU0NUtvQUNtMEgwMHV1dE1zT25Q?=
 =?utf-8?B?bXB5NXloeHdlQ3l2bWVmcWVueTFMKzVtTFNwMzRMTE4wUUtCUWZENE1YZnds?=
 =?utf-8?B?S0pKdUEvWThCUW1MR2d0TEU0cldSTTg3Y2QyNENBQ0RpQUYwNldnSGF3c2hq?=
 =?utf-8?B?bUNWSVdYUHVQMks1Znd4d1B6Ulp1eUIwN2ZxanlaWnM4amNGZk1yRmlKTmRI?=
 =?utf-8?B?L1Q2cGUvRUowRDNDc1VaSGFROUljaW92MGEzZEl1eTJoZDZ5L0JLbkhUbnZr?=
 =?utf-8?B?SG5xSjNiZXZrc3dVUjhQWEUyMzcyZElyQ1lHM1VIQmlCRnVnNW5pTzg0U2tW?=
 =?utf-8?B?bVEvVUUwbUNtVC9IYmtyWnR0MlpBLytQK0VOaTE4ekNaS3hjc1h2UnQ1WVg3?=
 =?utf-8?B?YmFFQkJPbUVja1pGUnR2dU0zVnBDUUtRVEhFeVEwcGxiRTZ2MmFOT3NuSlhp?=
 =?utf-8?B?TEJmWW1NN1lQdzUrSzhxRVlzN2xzcTRTTjNHQ2N6dEZNL0Z4L21DRTh0N1ZU?=
 =?utf-8?B?cG9ndzkzMmdhTlhMak5mUEVVU3J1SmpTdTEveWVJdDdhT0dGT2dMUkx1Tytp?=
 =?utf-8?B?NElIcWFFMDVqRmxxRkZzUW1kS28xSWJGRTRMMDJoZmM1c3VnTzVObDZGdzdS?=
 =?utf-8?B?TWJyTzlkUjlOT1VORmxOaXlvMi9NR2s2M3cwTTA4aGxLMk9wUFY4REM5blhP?=
 =?utf-8?B?Qk8rODJhRjJ0enRJVlVSTzFpVU43cktJT1ZTRW1KK1dhMUdpcnJDRE0rbGtR?=
 =?utf-8?B?dG8xZTV2MHAwR2k2NGxlT0MwSXRvaFB6SUVLaFI1Wmg4clhGb1RidVFodmFL?=
 =?utf-8?B?SUc1R3RrQUIydStXN1NFZWNBc1pzcXdsNWRHZ0lGSDJJQnVnZEJ2cTdGVDJE?=
 =?utf-8?B?MXJ2Y2ZjakVSazdJZlFsU0N0QzF5TldhZjdFNzBDRFowRncwT3l2Y3VKQW5T?=
 =?utf-8?B?VnY5Q1hSSjZ6eWo2RDNqYmcyY21KWWNtY1RUbVgwL1hlVHNMNG1FejFzOUxS?=
 =?utf-8?B?QUxiSVg4OG43VGNUc3pRQytaYlFiN3R0UnEzZnVvTGhTZlZ5Q2hMejBqa0Fi?=
 =?utf-8?B?dHNib1ZxeFh6VEZGekVxWlI3RmZlTTJBWnk5S0RvbDRGdkFUZVBtMm80dnpy?=
 =?utf-8?B?ZTJNM0ZZMnl3WGNnN0U3bGhTOHFFSzkzM1pBMkxkcHdGdWI0dVByQk42SEpL?=
 =?utf-8?B?bHdNdmtKWjk1NkJCeU1EYjRtZ2VmMXB2eUkwNHNxTFh6YmVTZ3l0ZFYyQXY5?=
 =?utf-8?B?b09xV2FCK0xnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzR3NFVJcnVVblBWQVRGMWN1eVdSUUE1eHJwaGRjWjJjYmwxdHp0ekdnVEdR?=
 =?utf-8?B?SHh0MzV6aUxBS3ZXMG52a1pjL3ViR09rVVplWG5pWWM1QUZKQUtLK1Y0RzJ3?=
 =?utf-8?B?Z1NqUUhlOTlMdFdzZVJNZlRKaVk5bDhRM01yRnJkemtWek5oTW9mK3F0Kzgy?=
 =?utf-8?B?RFZMSDVsNEhqWGIwSWNFaWptTkF3QThzSlRtNFhUbXFyLzJYMnhOdCtpR081?=
 =?utf-8?B?K1JsanBhSFJTUFNiUFJuTW9CWDRhWFpSNjh0d1l6V1FBaWlEOGxZN2h1Nkha?=
 =?utf-8?B?NFZZMlFWRDdZejVTbDg5d1BhRk85a1cxL0I2UFBZSVB2QWJ1WjFUOGc4eXZQ?=
 =?utf-8?B?R1h1RkNNMG8vWkVXZmpCT3djQVRuUUQ1aDJSRDhNUm44ZnpNZXNHamZzS0lp?=
 =?utf-8?B?TEkzWEI3NnI5djlkVFBPdldmWFZ3ZWlWRzlab2dtakxsWlJoeGlySVNqM053?=
 =?utf-8?B?cEpaNWlKT0Y3aHNZUE1IWHRDTHdpSEV4L0xIMVJOWHFFeno0WDhzZUdWYVBI?=
 =?utf-8?B?UEFZWURjbnd1eUVsUUlXRDBESUt4UzdwVXNibkp6S0hBYnFFQnBNZC9oaEJL?=
 =?utf-8?B?Snk1RUIyaFBiaGFsczJyRHdZTEpOQmlGRm9MampWZllmQklYQkc1S0dYV3dI?=
 =?utf-8?B?bUJuUk5LYnh5Smczc0p4MFJoUWVXVXArZHpTOE0rZTRLVk83WG9nVkVaR1Js?=
 =?utf-8?B?T1ltQ3V0NjFqbmM0S3JlOTN2R0txUVE2SFBXSW9vMi9Bd2RwZTZmTy9Nd1Nm?=
 =?utf-8?B?VWZrM1NTUzh0cnlZcStjeWpZL09KUDdwajNldzQzSnU5SFBWVUVaZm9ZOXYr?=
 =?utf-8?B?VDJ5NnpiNU4wM0hFRVZseDBFTXViTFRvaUdYd0pkZ1U2OG50YTNVL1poRmVF?=
 =?utf-8?B?RFFYMStCREFLNlRuTTZOYldnSWgwUzE3NEdCWUgzdzRBbzN4OG5paEpQRXBO?=
 =?utf-8?B?RldoNUhFU1FMTmFOd2NGOVg2RVoycG1IK08rVXFVaW1ESTZZWFY1ZEcxTnAx?=
 =?utf-8?B?OFFaenFJVldZSmxyOTltemN0eXAzRXVORXJDKzQyeVNFUWh5aG9oK0QzZ29X?=
 =?utf-8?B?dW80L0JtTWZlQUIxb1VjZ0p6RkRQdHRQVkpLbDZHRzcvdTZVc0hiam9RR08z?=
 =?utf-8?B?SGpqUG8zSkNNQjVGMGlyK0hHT2Z6UXFzQmFYS0U5bTlST21yYkpKUklYSVBa?=
 =?utf-8?B?K1FaS0pXdTNHbjZXL0tYb2p5aHV1cy81akJoVW10UEFZWVp6QVBiNTBSR1Nn?=
 =?utf-8?B?Nk83Q0lXTXh6NVR5ajVWVWFOOWpiNlNTUkl4U0x2aHZESWYwRU1UdTRJSVZ2?=
 =?utf-8?B?dmtpMW1jSVFTMmtCYlZGZ1dEMHA0VjZmdTFuUjBOL2lRc0hTajFhSEpsWmRC?=
 =?utf-8?B?SGRuOEg0S1RiZmdDOEMxdGdLaTIwZFc3dXowYkNhZk5DWlpHRHA1TWZOaHpN?=
 =?utf-8?B?Vk1QajZoS0kwb2VhRTU3eGZ0eVRCSXZsTmV6QjBacUdqNHd2TjV5YVZFMUhC?=
 =?utf-8?B?V01CS1BuYnJYUnhSTmNDWW82SXk4dURCYW8xMjZpejBhbDQvK00rcVQxV0FZ?=
 =?utf-8?B?K3A0R0FnRXRpWmFtUllMZklSSDJmZ283TGVLNUZGK3IxU0UrTDFjZ1c4OVFZ?=
 =?utf-8?B?ZlorUU0zOWQ4WlJNOVNibUlWSjZTK1lLdUlRenVZWnk0Tms0SkVBVkZnMTdK?=
 =?utf-8?B?c0ZldU4rUFhGYXBSSUF6RGl6WnhPWTZvMHRBa0ZWK2lpWmp4SEpTdVpCQUJa?=
 =?utf-8?B?MmxWRHRuNHA2Y0w0aHRmaGw0WGJRQ1ordVNIZlJvdEovWmw4azR0aEJQRUNH?=
 =?utf-8?B?eTIyMHl1VmZJWm43bTlISGhIaU5KT1grK1dmTFdDNFB5eHBQUXNuSVlham8v?=
 =?utf-8?B?M3piZkIzOFFib0kzQTZqQStCUFBFOFF5VENzU1N5ZEhzWVlkVHRCbUpqdzBS?=
 =?utf-8?B?MXlCSzNEUzJuNi9uQ3Q4RTljejJDN3JnZm4wZUsyRGNOWVNrTTlnUzZtT1Nn?=
 =?utf-8?B?YWpnYTUvWlNQRk13NE1MRG5zSU9HUlNJUURVSkt4OTl5ZTNXeGtQVDJWbits?=
 =?utf-8?B?ZlEyZkwwcjF4VnZJSzR3clgvSnJ2a1lyM2tCem40akhxNWYxN3J1T0Uzai9t?=
 =?utf-8?Q?a0q2vpxdt31t8Jg5iVCwqeAIk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e933ab5-5fc5-4ed9-819f-08dde53c442b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:35:16.6454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Pq/9DsnNdN2GBKC3C15JhAKUT/EMpaEKz6ErUHCZyGGwpozMSpcBoUobvRZK8+WltU9iEne8ZLo8lOA2tPbXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687
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

From: Peng Fan <peng.fan@nxp.com>


On Mon, 11 Aug 2025 17:25:17 +0100, Andrew Goodbody wrote:
> In get_lpuart_clk_rate if the call to clk_get_rate returns an error then
> the call to return should pass the value of the error which is in rate
> rather than ret which will be 0 as its value is not affected by this
> error.
> 
> This issue was found by Smatch.
> 
> [...]

Applied, thanks!

[1/1] serial: lpuart: Return value from correct variable
      commit: 4d3183723f34d58cb5decec77e8bf64b84d309d1

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
