Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0637CD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 02:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31589846D3;
	Mon, 25 May 2026 04:41:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jkR5kml/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0056846CA; Mon, 25 May 2026 04:41:19 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6D6B8405A
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 04:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O8oYwP3lTConOx1ea2gw5q/6uHTr+rbFl2QhekmNf5M8gvA3ZAhhl6NQd810xbBzY3DjHDaaZCa1FckI2/qF73WA6+nVJv9zx1fZtXOyacMlfU0M3XbtqUSk38F9onRXdRdrP0iOllzH94CgFke5XajKVWazFMhOrzVYCmQHfSima56Qhny5xMM54RDd27cBBb3h0XL3GK+6bLbqFIOjWQG1VK6N9MGrb2DI0acOttIMsgVA+dW7q/ZU4C2HH1NV3q7rrXjpxfqkVa4WNXz86sqAbngefkPORRTbmq8CuHgwA6obxXhIcJ5O8qmAD3hnh6v+P5WmoWcT4h9afZLsxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0weNCX2HOAToR9KUw4LIHNRiBJ653OTj/RUgnKyTBc=;
 b=LJpcmYQfWzy+HMogLflRlVcmvdgEEcQ8jF47mKO6B1gcidbOTGkVcfI3kkKb/Nhqt3Tpzs4HrgvgMU/enfX42arPe/r3h6n27vyStNhYv5otUKlQgRi/JxedfhDH1T2tD91lx9RtJVUWqTTBqw+HN9WEZoKP7jG+stMlk0jcQOsID6zO0bjh5D7F8fvYxxXtEWkh8v/kw2QvljhWtjESuGXRscX03RA7Js2vuw2GrzPLqvT3H8hK+C56DyeHNjCuLZCwMozy6g0tMFtfVl446fksdx8Q22uH7pGu/RCS/ZZXrR4JkrcHx0zZDXlb8TVKQ2cOX9xTUEdL1GLv/CMUSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0weNCX2HOAToR9KUw4LIHNRiBJ653OTj/RUgnKyTBc=;
 b=jkR5kml/VDTP0UNyeNki9DXr4sgoHloztXFXFVS/5HyT0v1ZtkWKjMKv0y498gPdV5c1kW/5xKTop8aVIaG5YgXmVhKoL5MPHtEuGBLiv9ONSXIvJswYyRJKFz9J5P2vu1QZ1mSaRgBFbXer/9eDjLmg++BlGLkr9uIBxDRd6TpBPS+NhYTextcwlIJ50VojaEd8J1rxLQniceW3gZSy8F7IZgCK6lNb7iaBnq0s05yvx5r1t7ShsR7aO8Y+m1vc8/neyiIwYdvLePn5j0tRL1CG33xnJVZjiYjM9kjvkySsF6LEA4tq5R/2Ucug9RpAYsoxAP5Feuv69WePutsINA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM9PR04MB8953.eurprd04.prod.outlook.com (2603:10a6:20b:408::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Mon, 25 May
 2026 02:41:16 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 02:41:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] mmc: Use device API to replace devfdt_ helpers
Date: Mon, 25 May 2026 11:58:01 +0800
Message-Id: <20260525-devfdt-mmc-v1-0-018e94f1c87a@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMnIE2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDUyNT3ZTUsrSUEt3c3GRdk2SLJOMUk+RkAwNTJaCGgqLUtMwKsGHRsbW
 1AIujAMNcAAAA
X-Change-ID: 20260525-devfdt-mmc-4c8b3d4cc005
To: u-boot@lists.denx.de
Cc: Stefan Roese <stefan.roese@mailbox.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Hiago De Franco <hfranco@baylibre.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|AM9PR04MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5876a2c0-e6d2-4d2a-e069-08deba0717ad
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|19092799006|366016|38350700014|56012099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: OKYL8r3VMSxRA6QwVf341PHiJlzLJs4y5ljHM35SYBdKOA7mL723L9EQjtyS9iHOiUkr7g6jx0M522uEqihq+FiJRcLWUltGZg2rr+TOHs37Svsg/Q73VK8Q154aLYNRJAf5DBnCYTkR74Su//LLI9QaDAoNfkPMIwQVf8L1jVtNvhtsMiL6hc7n7jYmJcrF8pyiAA3KPE16joZYXlBjJV4Pw7w6Mk4/ILb9hSAKl6fyplY8yDXeKKf6zhQJSLtDG2wmBw0EN5E2fu4vP8VKe1eqFYYffEm2xodHWn+pSvdreIGYNuq+rg50XiIiu3HAxx4FCtCpqpdK3NnGMmcsjAZ6JzabmGOSmkhsrnIJUlta4ojlJajTGC/CrwV/OfV2DXvkiZqFyIJ+ZQDTeZViz4Jugmmu/UMA8WgDWVY3K3BP7gF4Xs8mynb7OOySa57oEpqNViWEmOw1vgWEmFrnXq+R91apbt+71cDV+GvcCLuMZ8O2KqSCB98NFJx1WEIbEDyrTLj5xIU3d0Ec4kLDRdTJ8qhsWC7olXQvBExL++sJR18ioBolzsd120O+JGmTazzvuD26GNP5FiAKhTy2B+WDWilIFLzjAfeoYGBFz1xpoNoJH6ekz6JPNIbbGbvtJYJyVChAfpgukUJZT6cm8L9+pKEX/RIMwUD43vBrR3Wyv4MnMMQpTVn9n/CaDdsw+wz1K5z3sondgxmv4iJrkc7qJaXc+6BmIuezfwU9ALlECrh+rG7valX6foDNtjOW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(19092799006)(366016)(38350700014)(56012099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTJQNGJLY0ZIcExWcUdwcEdKL1JLUk9GZG9oSjVsU0EwdWNtdG84REUzeFBz?=
 =?utf-8?B?UU51SEtCRW9aWkR3NWZUcTN2QTJVSWxSOUQ3U21jQ3Y5enc0Z29oNXBiUngr?=
 =?utf-8?B?S3Y2cCs2KzFtcUNRN3dhdWxyOWx4Vk51YlMvVjNxa09oQ1M5OGhqYktXU0Jo?=
 =?utf-8?B?SDRYQy9TQWVBYzlKTkpPSEp5T1h2UjNMdWJoSGhGVVgwcWpGVUZIZnM0dUp4?=
 =?utf-8?B?SzF5SjFuTTRJbU1lYmo5V3VzbGllc3Y1eE1VQjlJUnVibHhzL3FYRXh2VTJV?=
 =?utf-8?B?Mkt5OVBudUR1aWFYbExNUHBYdUliWE50Zm5mSmRCa2lkV21jdFJlL1Voakww?=
 =?utf-8?B?QkdzWXNsZlloS29MN256SHFJVStoT20xamFnUGpFMGw0Q2pyRUk4QW5FVWs5?=
 =?utf-8?B?b0ZjZldzQkJNa0p5SlJaNzBDK1Z3WEYxNlorMVloS0JnNXdJeWlLS2x5VjZY?=
 =?utf-8?B?SWFhazRaREhOMXJ0bmNtTzd0d3V0N2YwdzNTNDdoaFhyaTJmWTliR0x4RWNZ?=
 =?utf-8?B?SlVUWW1CWklWdWloTEJGbjEvK0pzalI5VGxYUHA3cFBQYkZNM3drY0wxejNT?=
 =?utf-8?B?dXZseGJCdEZpUDdOVzFleDd6U0JpWWxWUU1xNHZlS1FSNm83ZDF3em1MRHVm?=
 =?utf-8?B?T3JMdlNNTUl4NDh2Y1R3Y3JmaUdjVi9EdXp3TW5iRXhNbzFtWjA0OHdSODNT?=
 =?utf-8?B?S3pRNktFZWxMdHFQWjFHNWhPSTdXZjhCRjAwNms3dXFTd1BKZXpobko4SkZS?=
 =?utf-8?B?Y0VmRDUwOFEwcDVyMGFaSzM4WURqMzk0M3hzWTJ5S0RhTFhOSHZubXNQMldy?=
 =?utf-8?B?SWZOUXk0RnFLeDBjcE9vM25TbUFsTTk5WFRhL3BHY1FDZjA5SGwrbE16ajRk?=
 =?utf-8?B?bWVHZFh3Um5pSW9DM2F6eUxZUHhCTmRvWjJsMVJwNXNxQ2VPSnNZQTJhTDBK?=
 =?utf-8?B?MVZMZ1c3dFhZSWtkMjBrVTBCOGc0aXVwNWJCcnI1eWJ3U2VnbncwU25vRkoz?=
 =?utf-8?B?M0dlcEhTVW9QK1RvMEJRL21KejZ1bzh0RnZzaHJ3Qk1GOWlpQ0FkdGVDS0dF?=
 =?utf-8?B?SVZYK2xnOThYd0VaS0Rra1NBbmRZVy82eUV6YkRIVXdQbzRUSm9xKzN6Kzlk?=
 =?utf-8?B?M0d5eEVYNVJ2M3k5a1RRNjA0MjBzbFhLRWhFNkUzaE1JMGVaN2ZkQW1lM0hH?=
 =?utf-8?B?K0M0US91MHFBaExVcllxaW4xbEpuYkpkVFhibWFselp4M0tCZzhmTTAyQnIz?=
 =?utf-8?B?cE9ybFdwSDRWbXMvOWh0RkZGN0tRV2pZdCtKeksvZ1U1bEZza0ROVUxUZVU4?=
 =?utf-8?B?MGwxNjV5amRUZGg1SmNxWmZMVDVKV1hmdk92cG53SDRUQmZkOGZ2VnZqZkps?=
 =?utf-8?B?eTNZdVlka2NlenhIcG16MmUvMlp3elRENDhDU2Y4TVJjSnh1dG9HRHNhSWsz?=
 =?utf-8?B?TE5pUDB5d0IxNUtHeFJqbjgzd2tJaFhtWXRGZ1pYZ1ROUk0vTmRRbzc4MVV3?=
 =?utf-8?B?U1gyU2dOUlN5b3VKY0NmVnFMT1lMTVEraTR3WmNmV1Z0QU9waElIZXordmJw?=
 =?utf-8?B?N0ZQZGs5bGQ1ODFtcGhWeXlnZFByQVBRNFI1SjVBVlJtVFJ1NnRna0FLa1FD?=
 =?utf-8?B?TkVZTDI3dWlHNmVMSHllZE1nQ3dBWHpMYXY1bWZ4UGlyZ0h4Y3RtVFhQb3A1?=
 =?utf-8?B?bXhHeWRySWdnVkhUNGFYckN4emlET1RHb2I5ZjQzL1BnZXNzSzZmeUVOWlhq?=
 =?utf-8?B?QlN0N3M1VnpsRmsrV3dMeEZHd0F5UXRDS1VDTTlTL1Jvc0dhOFdqVHJoZ3d2?=
 =?utf-8?B?M0xQaTV0QUlTZzlmRnNTK2JDYlp3WS80K2FsUzhwVU5SRGtFM2xxOWUvbW1u?=
 =?utf-8?B?ZVRpaW1hM3pRaU5UcEVweFdqTEZoclNra2pwZlpBUmM1RHpuSUxMQUJKNDFU?=
 =?utf-8?B?QnNidkxhZ2kzbTNWWjZCZlorZlJwUkVEY3BwK2lSK0crb3NlR0k2THllY3RV?=
 =?utf-8?B?M2VzLzNVcWwwWk5WVVRzSjdTTlpYTGFpZmFYcnpnNldUcFl5bjd4c3VpaUVI?=
 =?utf-8?B?dm8xcUNYM0k1Si9nRk5OYXdza3N3TUNxRVFzNmZFc1FlR01DcGVhTzc4WWhz?=
 =?utf-8?B?SG95Qk5GK251b041VUdYZVVaSm93Y3JjUTFtYTc0M1pXaFNxTU16RVFRWHpF?=
 =?utf-8?B?cWxQWWdacWhHYVdjRUtkN25lMngrSEluR3BwNCtFQ3JZMWRjdEpJdkkyMWRQ?=
 =?utf-8?B?bDFFR1ZrbVJzR3c0MTQyTzlvUVhVM01pMmo0UFRyb2ZnR3B0ZTFMb0VBU1Bm?=
 =?utf-8?B?bFE1SlZOdFV3QWhhcTRkaFBHQzl1VGVlMHRkc3VVMjEvZFJmU0llQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5876a2c0-e6d2-4d2a-e069-08deba0717ad
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 02:41:15.9167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5vzh+Qlm8a+9+hT3bd78ufgA86IpkndVW/Vq8X364NuCawihd+FGnWt3SPhDc+2Jtl0oG0rjl0d3zur48HqbWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8953
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

The goal is to remove the direct usage of devfdt_ APIs in drivers. The
device APIs supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      mmc: xenon_sdhci: Use livetree API
      mmc: cv1800b_sdhci: Use dev_read_addr_ptr()

 drivers/mmc/cv1800b_sdhci.c | 2 +-
 drivers/mmc/xenon_sdhci.c   | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)
---
base-commit: bb354d04459f5425318aeb8a70bae995ee573f1d
change-id: 20260525-devfdt-mmc-4c8b3d4cc005

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

