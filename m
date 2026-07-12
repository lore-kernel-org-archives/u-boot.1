Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CE6C43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 13:09:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B7284A4C;
	Sun, 12 Jul 2026 15:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TQrmTCDq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB1784940; Sun, 12 Jul 2026 15:09:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A9584A4C
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 15:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqvmbEc6WdAtSIjCTbvw767MCLsjmvl6YxrAbB/jEA529iyqqIFVWcwRywH6TXa15lW41BfGk94zQdGzS9XIhJQHR/+TcuJnEwWY6Ypr0i9jpbur5QZcrExOvfq5weAGV9zkt2jS83ENbOssYRfnTf6tfCITdxyqU3PJB69LOdurYp+zYlNNlNNK3J2d9RIB5IM0t/SBda3F98AiBn3DaMYXh8A15RF+8H7TaSxp4H3lrouhlIXUvTzyFMBuH+uFBmLcjPStZ76S6oSkEXLjSmoKFgg6L05fN1s0BFi0OmXwleXJQ+o6ALsfTSDla2bi98WND8p7Uot3yUip2N7NVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXIx+9WVQxmSPUSVC1QfEBcel1/odgZwSLF5aQy9fjY=;
 b=K5ILANsVVlhsGO+7dTl8fUv+W33UQ7Sm4xtgM5bsPcXS8SJ9p9Iy/bMurZOZu0r4Ml7rN9cwpVVWD7NuiY/ulfxJBYABy7aj+hKG3rJtTSE5USZkI0Eu0MEkiHYafkqEAGIxODgEmHDJYwgZi7med5eKTl29LKF0MZn8zY/INEeRqTARjJk8tw0FC5kFwea9zc3SKxYLB1kXeJlB/vaYDuNJSQBPDfvdr44+LvEHEXHE76IvYRMvIhuKY/nTUGWNsen0pc9IHuoTkcvk+f+AJxPpSHshkTnsmxuUvKilqiAYYRltmXHkdIZ2Ta8tG1xwvltTKx2UiV8ySaws1nswcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXIx+9WVQxmSPUSVC1QfEBcel1/odgZwSLF5aQy9fjY=;
 b=TQrmTCDqzA5V86AD18fQ0ACXtpItdSeCJIJm978FU/hU+Qwy1orOqpUix6OLLqVryu36ifL+qVQfqGMw+KUdCFp0gkJG6kvF8RW8WReQq5qAuAN5rzkjOO/u8sxJCDfk52/9gZ/o8pjb11G1j+OgVkbaNVsazcxMx0PqdIDSzHCz21u7XSH20dWWoe8Uyo77i3TkRq/R9z98IX67N8TWLbznjBMI3HoJgE3bhH1ZbWBXUl+0c8VcUGGfkEzbn8aZQlBZ3V8hGEZCg9Uh4GU73c3nl+jUaXaGfujnsAHeWgHIblU9UWg/s6QMCd+6wH8cpCSKkmV7z79vWTrHCZx5LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by GVXPR04MB10945.eurprd04.prod.outlook.com (2603:10a6:150:21e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.19; Sun, 12 Jul
 2026 13:09:15 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0181.019; Sun, 12 Jul 2026
 13:09:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sun, 12 Jul 2026 21:07:30 +0800
Subject: [PATCH 3/5] mmc: sdhci: fix align_buffer memory leak on
 re-initialization
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260712-mmc-fix-v1-3-99a1136bbe54@nxp.com>
References: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
In-Reply-To: <20260712-mmc-fix-v1-0-99a1136bbe54@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI3PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:295::8) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|GVXPR04MB10945:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d7bdda-9874-4355-f962-08dee016c67b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|7416014|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rrlEuMTM9wP0JLnp/MFaRHdHJpbtgTdsU8ntKXjy4JIgRU5tMKY49ARjJ/f8UcUMngnxL8qsWZrfltxVb5NbesEYtV3Ed4xOSvbfLosCGGPpq0MPXSem6TVByNJ3Um92U7y/p72UFW21sI5trRRUvIqZ9qvQwGwhABsO/wh5/i/T7x86hUIaStnQIdeNJynQ34sEiMqDWJniFcAb1MlxNovEFG814/sJ5vJkleIeVG7fYnj+x4EZ6mpOfP6J/LAxgl0dNMOjLWpkPoVUwrsyYSgL8//kIVm6uHEjzXpjNOaNOMvOfW2AwAFbZca3ciAwoMou4eeXthUYOBRYXn7HfX5rZp5FMAPhgo0i0rJl9Klf2c6Mu7XREpw/I6Lr+lOj/yV1TU+CmmbpMOURcM+E2gx08jhigXBet+KFsgjWUoS0VtIpaBfxMZPtQ/HbXYaR+sBuhgS48fai7XUTlRI1R220ki2nXC6S24BGw8ma1yfZQGkyFuTAJ6T8h73XirjEGofuT5ZCCITekJWYe5SklKt3ZNkKYQ4jbJ/XZDph2UWDVpM33HNn0NEbEc+mvFXj/tRnYzFeFUvLOAvA3vMQkA81e6WAK53KUD/BL4PZtNYGcy6O0qbLiuNrNFkxh3JzpytYf29gJbsHpeGY6/xqp1O/nuJKF2ssLEyDxf5n6Ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(7416014)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFh2NW9XR25PWFU3ZzNnakxBREp1RndiRHRqbU1aTElMTXJKQmZsQ1BmakZr?=
 =?utf-8?B?ZFNudk5Vb3ZWbGd2Qm1DRVVQeXp5NGhWSjlUcUFhNlVEd1J1TTF1SWdDWEM2?=
 =?utf-8?B?QllwOURwNm1xSjNSR1AxMTRnOFh5cDJEZU14b3U4UElUdVBxVlR5aW02TVd2?=
 =?utf-8?B?ODhpRk1KZEJ5NnZvM05oVFpQMUVNUEgwVEY3WEVNVmFQbzk4dHQ5MHNUNzQy?=
 =?utf-8?B?cURyd2tFcHBxbTlFRCtDdEdIL0w3M1F6aHVMOFRucDlxWnRSQWVZeGRIUTZU?=
 =?utf-8?B?MFJ0SWJvRWtkdXBWbU9lalJMSVdVTVpiT0JyUGFkSE9neDlBdDJPTlBVVjZN?=
 =?utf-8?B?UDVGNzdXQVJQaG5YZEg4eFJVSHVaTGxMeU1PNmVZc3c5UVhseU9NcVgvMDVJ?=
 =?utf-8?B?OHVVdSt0c0tQT2VGUUFaT25KUEZ2dTdSTzBsSzVmY1lJUEg5d0tuRy9uQXY5?=
 =?utf-8?B?K2FHWHEzaUxEN2lzYlQ3K1hyWlVvVGdEWTAxcVJmQlV1cktER2I4Rk5hWURQ?=
 =?utf-8?B?ZC9odlNPSTJMdUg3QmgvNTJQV2thS1FnQmlkcXRXOFNjUEJIZW52eExkQW0v?=
 =?utf-8?B?S1JNelRyZE0ra253WVR2am5NNm1wWnFQamYwbWNITkVCSEVWQ0l4bmNjNWVB?=
 =?utf-8?B?bTZBZnRqdTdISWNSZDIzbVlxTlhBOUttdUZnL2RiODBNb2lBNmN5Y01maXZj?=
 =?utf-8?B?SzhIOS94aW1udmQ5QVlwSitaNWhUWGZiOHZnKytPN0NQWFl1d0lMOG54VUo2?=
 =?utf-8?B?bWVFc1g3QUt0OEJYdzc5bzRTUU5hWFgxSnVxaklDLzVCbDB0TXZZZzNqT1Vy?=
 =?utf-8?B?Mjh3cFk0cjVEODRUc0F1RXZBdzVTeHd2a0wxV2NMSU51WCtPRTFPLytkWkg1?=
 =?utf-8?B?YmVnN0s0WkdKNURkZmZkTTZzUHgxcG1iR21USVNUZFVCbjB0em4ydHZuWUts?=
 =?utf-8?B?MmJMSUdMUGZyemc0MWlBZTZ5bDRJNzJDVjFhTktZeSthUFRqMHh0a1pVY0Jp?=
 =?utf-8?B?ZjdkUHJFYm9jT0JOZVlPSU5QNkZLSGhTQ2hnOGYwNTRsWG1LR09iL2JOVVhQ?=
 =?utf-8?B?NCs2dTNTNWViTThuQ0lBTE11TEJvMW1jemRab2ZnV0d5dytDdWpETXc4ZnZX?=
 =?utf-8?B?V0xrTWF1QkthYnB2MFB1c0h4NER1V0hjcHhuZG9pSWRiYXJtc2xnRGNZazBt?=
 =?utf-8?B?cDcvNHl0VncvelRYSXVZUHZSek5Sc2QvNnNTUVpiUERadzhlQzRNVVRZVXZO?=
 =?utf-8?B?U053cTVnSGVsUG4zTFFDQjNOM1QzdDNYcUxBRFQ3WVRJSnhjK2FJdmp3Y3I5?=
 =?utf-8?B?VFdZN2diYi9Va251RWJNejluZXYzcHRrUDBBdzNablFTRmt3bW5TYmorUS9J?=
 =?utf-8?B?SXB4VTdZdCtFZzNTaXNjc0loc0lYVjJIMVp1Sk9GNVoyYkRpcnVLN204eE5J?=
 =?utf-8?B?VnlpVW5kOFAwWWhYVWRBem8zWXdVTVdlYnFxK2VxeGxhaXU0YVJOYXBSMGZE?=
 =?utf-8?B?cHdlSmF0T2FOQTlzREFRUGFtaE51cEEzdVFkUnhocHFYWFArZHpjWWVyWER0?=
 =?utf-8?B?VjZLeTV6ZHRON1JYWDcvcWNKNlJSTHBHdVhyMWlnRExyQm4vVUZvODlwaUxH?=
 =?utf-8?B?WjlyaytGdWE2UUUrQ2FpeVF3U0pBQWsyNVBHWThJWktDYmNDdldycWpZeDhS?=
 =?utf-8?B?VGd0UGlyVjYrdk5mNktFQ3Fkc215b3NadmNXV2NVeUljcmdqV0xSaXhHaXVF?=
 =?utf-8?B?cHkrQnBrMkFpd3BFT2M2TXpvZVlxL01PZ3hMM3E3R3V3TWllazFNRVpkMjd3?=
 =?utf-8?B?czBZMTUyZE5MTkhpczVWOU9WQ2QvZEhnTGgybUFBMDQ4TURMTldMV3d6UUpZ?=
 =?utf-8?B?UHB6RDNRT3BRVFJFOHExSVFoaEVXcmJtaFdZa0kxckFQQUQ1U3llU1dKZS90?=
 =?utf-8?B?c3NkN3IzY3lnZVJlUlFEb0NFVEpvdE1SS1laRW5jVER6dWZ4SE1vT1hSNVh6?=
 =?utf-8?B?Uk11ZVA5TVNWMGFHZnlwSnpTcy9SZzVma0VaYzVCdHFPQkZrK005Qk5XTVB3?=
 =?utf-8?B?ZjJnejR0Z3g2SVptbG41dXFEdnFlS3dibzR3MDFvTnZyN2RrdEp5TmNmQ0FB?=
 =?utf-8?B?ZDA0QnA5bER4d0t6UmwrVDJwQm5LUVc2TGNjTWFBU05rakpaZ2xTVGsvc1R0?=
 =?utf-8?B?UUxFQ2ZnL0xCS24zTDIwTVNUTHo5TTdmc3FDb2xMSE9EdnczdDZzRURoR0JG?=
 =?utf-8?B?Q013YlJBNWZCWFJhOWFTcCsyTzZUaStLeUtlcVc5TVU1UnlNZEJoS2R2S0Rj?=
 =?utf-8?B?Sk9ObWVuRWNTZDB0bTRmaUxTelM4UlBFakpLWlRmSGl5dEdNS1V5ZzgxeU5F?=
 =?utf-8?Q?cERUsUNML4lkORlM1z7A8CRbU3BcaRK6T8xdh?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d7bdda-9874-4355-f962-08dee016c67b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2026 13:09:15.7860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gbvwcZtjSvVy0eN83saFQniVYBebSu1XMcU8iki2ZKV1q3rsa6ONrWIr87hhXkEtOoFBwhaRNRAu/GYgmBevhRLmih1vEfy6qGql+SpW3efcxhWfzg5jswMWpKRQTSU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10945
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

sdhci_init() allocates a 512KB aligned bounce buffer for controllers
with SDHCI_QUIRK_32BIT_DMA_ADDR. In the non-DM code path, sdhci_init()
is registered as ops->init and called on every mmc_init(). Each call
allocates a new buffer without checking or freeing the previous one,
leaking 512KB per re-initialization.

Fix by guarding the allocation with !host->align_buffer so it only
allocates on the first call.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/sdhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index 08594e10266..ef20e881542 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -733,7 +733,8 @@ static int sdhci_init(struct mmc *mmc)
 	 */
 	host->force_align_buffer = true;
 #else
-	if (host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) {
+	if ((host->quirks & SDHCI_QUIRK_32BIT_DMA_ADDR) &&
+	    !host->align_buffer) {
 		host->align_buffer = memalign(8, 512 * 1024);
 		if (!host->align_buffer) {
 			log_err("Aligned buffer alloc failed\n");

-- 
2.51.0

