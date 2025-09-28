Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1840CAC5B5
	for <u-boot@archiver.kernel.org>; Sun, 28 Sep 2025 19:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF22C828A2;
	Sun, 28 Sep 2025 21:27:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="ttpWrwO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D971F80FA1; Sun, 28 Sep 2025 20:38:32 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0C7380819
 for <u-boot@lists.denx.de>; Sun, 28 Sep 2025 20:38:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwChV9kgxdn2ldKLqLCZVSoz7Y/RJJ+VHnCdndCgPNueA3xwzudYASgdiO+K1d8BCf0sYBoBKc0b/t5rwfisfc6lVWPwvqRlPKwnEJIVEtaFHyhBdHFVhGaf0AaBKTDixAO4I5EocVUIAMllfw6Qp5onTnCGYxfJRiJNwHRortk9dRAdHm/pG4RVAYD0WN2BZfX1q0uqlLWf8+sajIeUscYcYCYd/raIraJPcYsTcwH0ufgSogHNMiLgNuXdTfE6m85gC619dx9IXDel94Il93zMkHndJpM8+yoYEcTJmWOKeZi1YRm7O/E1MqJPStS8EU2Hxm53mtJLsjF2M4LUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zk0z0gMLYEOBImFjnV9F6thIpHpx0ChORn68vFRWLWo=;
 b=ETYGSca6biUs2PyoZOTY4PdPsFgM84AvHBDjS/x71JAEqA/AoE1Q+DEy6P7t7AkoaXjKH0j/KuRrB4y7u0egxXgSWvDRsqtwjfR8gn6fhlGSPOArVGzNckzd6LfZB0twDUmHwlXjSWUZqYv0onlNbb/RscZdz5AuxjsCswMCiqcsmdJx0+Yw2Ozqg3PsGwysxozf2Wz+G7av4lja7EGapyVKCTTmq4OPSRBk1spzPOpVArhSOBvVWdQac8dGIF7WrOWTGrMjTS7iECoKTm+L3xPM1M+gwb1sC8RlsvTaf/JLC11SWJrKDPRHQ0u51AjpmsbrWWgHpRB/fYQmzJdBPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zk0z0gMLYEOBImFjnV9F6thIpHpx0ChORn68vFRWLWo=;
 b=ttpWrwO7PnN0eeaTmKEBBrZ1tebE6ByASE9wSlAPnCf9inTRswO+RRAFiAJjdoD606yooXJsQVmxAo/XAeJWpB80EW5+5ycwwGbH1J7+H0ed8R6YRx1rz50peA5uwZof9BacCx0EJ4/dxpzk2DYr9QjUcIuHJUUb9fjq3NaVLko/TFtlItOyUM9d+tXUFVOTqPaBwqJmVGdz6eMGpUns5dyNVzyeTNXY8q/hhcaFtAEC/wmj3ylTccBlUECOgX/X1Yza6h5ZcRkNU2frIbsReQGkE9UYtAUKjIfiXL24Tf22TWAIG3ANyppBjE4ls9X2EX7pvoh7RTmpPhXSrjmdSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by PH0PR03MB6557.namprd03.prod.outlook.com (2603:10b6:510:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 18:38:27 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9160.015; Sun, 28 Sep 2025
 18:38:27 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 kuanlim.lee@starfivetech.com, weiliang.lim@starfivetech.com,
 yuklin.soo@starfivetech.com, e@freeshell.de, marex@denx.de,
 tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH] mmc: sdhci-cadence6: Fix DT property value endianness
Date: Sun, 28 Sep 2025 11:38:16 -0700
Message-Id: <20250928183816.25623-1-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|PH0PR03MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: f5efdf54-e2b7-4d12-5520-08ddfebe366b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TLGsQ5vJ0whUNOzMB7lzFG+2VrAYSkwsDM6LZf4vDp2+ZzsemLotuaTJKZpE?=
 =?us-ascii?Q?FnC3smiJ3qBCK/G9WMbFEWY8+fgbKsYuWvr5ZQEduJFW2oiFO4C9kTOHtNvk?=
 =?us-ascii?Q?F2Z0z5kJsQSxDCCCv9JsxfyZl1XbEGrHujYfxQ94e7XfCCHpYCF+rjyHgCvU?=
 =?us-ascii?Q?8PCETwdZRVGkEHRjmjaJYYso8lIzcmhT945vYUrI/3opfe/ZtCYreBohGJwW?=
 =?us-ascii?Q?hC8Vz7XX1Eb0CX2/3r6cFPHqGqUwpJlaatyXgzhviP5C9FQFn1E5V4qZKXBg?=
 =?us-ascii?Q?xZcEZl41vGzFiaGokFG3TmNs5QyPtmc1sCFJo9/oIxm+JFb364qyMJoNSjqc?=
 =?us-ascii?Q?XBX3EYYM9KwS6239NOQp+EznRYWdAwaVkJU5BZHihTWOpXk8xUqzD3JuTZxm?=
 =?us-ascii?Q?Zy+f6fQlNruNxgUrGD1lIQNKiIXM4T9SCJ+QS0gWEupsn3bzwIuk9zqSp6UE?=
 =?us-ascii?Q?RWw1IUdIKvghRiQkoj+R+GtVQ19ah5kwqa10osE0ZsfWpGFhIIMmG3PoBTLK?=
 =?us-ascii?Q?LrrqSwLs2TdgReJBfEZ80dRyjsS25mmaz3VVIGuQh3IiNMkLucAqzJU9v7qS?=
 =?us-ascii?Q?kw7uxnyqpQDLlwJgskeWu3MKmyPVTDbfHN+37GoWE4ecEeOnMMYD52HD3cPS?=
 =?us-ascii?Q?xWqmyocZ2KhnIbyBSCkSvM1duvuZEG+DrWVhysjg57pbf3Y2De+rt25Amgtq?=
 =?us-ascii?Q?2lQxJvsSBdUANrOQEHHTt3g2imCo0wi7v2chcM3FiyNvsTXk5c+KfcVF0lOO?=
 =?us-ascii?Q?WHSe9SQQ10S+FSV+m++H6PiCh3mVg3APpE0ZXVdi39u/G51PdeYAvuc21qKX?=
 =?us-ascii?Q?tqk/2ZerxGZUjViTiiQcGCjf1BcCqe5sIW/9Hv4MQvcBT+84QCy0aG0QeDHa?=
 =?us-ascii?Q?rDsIRGWD+Sq2bmTQgPCdK3oS5THs/aQTLkhSIE5Utpg8wBG7DBD/U4xFMt+B?=
 =?us-ascii?Q?lx9xKp7e4XtkU/mKx66INxJV/UmAStSGk0R0GgQh/vKsOT2OWH6G4kjdtev3?=
 =?us-ascii?Q?S4FWQ9f6b6ZbsI2Ny2/GqmkIEjyNvt0cGhGnZeHz4mZho2MnxFgQGl2noaw/?=
 =?us-ascii?Q?/7F9U8HUsp9gIUp3tXUtgLNFygRi2DcxvYpH8aOPkgz4k8+7T34pwzQjqxvD?=
 =?us-ascii?Q?KdYxwVSrPt3ivPIBjB5LMCcRaS+poW8wP9UiU8EaRP8ixBq7lYkrxtYt/vh6?=
 =?us-ascii?Q?a6pPCpjREmKHs6Rfi6aQDQylaajrWS7X86xFjb+/MAJbytGC25ZxapKyTWSc?=
 =?us-ascii?Q?EJuxVZRSXqVzDKh+D33Bpuc+mgVZqX6R41Smq/M8hd2mwgEYmCGEQPrrqWCY?=
 =?us-ascii?Q?ya7PVQSxPKZOcmzUc/jKcIr4lFzmsL2az3y4es0V9bJ4B1bPXu4sNkkpcdSe?=
 =?us-ascii?Q?ViLDW/58vG9Rg+zkqO9Eqv5SS2v9RjBezUGkK9xyOBPGRFv1sFewqLCTCT9g?=
 =?us-ascii?Q?KaBnRMkYYaBUoJPYSBEU0s+EbSfMOR0P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EG1SZ9DODBDW4pdxpJjJK3XF/TyjHwRV5xXWOsr6vgCZzQRabHbi+WHS1lJb?=
 =?us-ascii?Q?ur+AMfrWjnXyUewnIw2waxKMAJcBRdf2GycrWM/QTyicRWMftuPNib/ltCXD?=
 =?us-ascii?Q?YvvD/LNCdgyKix+LEkGUH0n7taIpZ26w2j8MpUMt9MLvw0uT+lauEnyBJHEL?=
 =?us-ascii?Q?90mTw8//MTX/82Rxp1lHMZiOPCAsqKrVcaBlPx1kMyU8HKTTFNg6y1NFZCiJ?=
 =?us-ascii?Q?2q9IRqIqBuG1uRi2NxmVddDXBokvtTfnzSAgxL+HwhoJkSsTR1trOEwJmLaX?=
 =?us-ascii?Q?C5KvAmdm7zD8QkOyxnccVLge6iBjzJj8wuC/OdoBIX0gWyJf99zWgFgk5/Sx?=
 =?us-ascii?Q?GhPEXv0kzIgasDWTiS+d13DsSNnvlb7OLh6egX2DGK+Kzx/cBKjv37ZmMNXB?=
 =?us-ascii?Q?gkz8e3Botu++42A7smT8sDTXkWdcTHHSYTfqrgpQ2pUoc6a7zQeKu0CZhdv4?=
 =?us-ascii?Q?8lphiaSoTgOYMesMIcchPV04nM7U/WbAXs/RlQrwtXJSEXJipGtik5/8Uw8Y?=
 =?us-ascii?Q?19evhJ8uFzC3OYr/vXAb/ZJ/LLx0uA4SEE49hn7GjYh2OCfJUb32IXUC+Aj/?=
 =?us-ascii?Q?0C+SX2NhnLu7eHHnzUX+YY7AvkPM1NRhSWkdH1SnSLtat0B2+cIPE1RwwyIP?=
 =?us-ascii?Q?sJ54K2UY7IA6UrC/Vk/3JfhBmiAXzZKaKoaBwHMTH5PtzCxh/8kHDhNBXw1b?=
 =?us-ascii?Q?7eY5Dh1UQW3i+Qf3PFkE5KuBd3ka/NZ0M58XJuj4l5n19fkAJL+2aFtEmDph?=
 =?us-ascii?Q?0iElTmWdOEW4ToXe2lJF6rdJDosUMoL7qwoVjo6ooZpbFZN9jBkAKHluNdPy?=
 =?us-ascii?Q?fJFbi5DEziIK39Be+wZnJy1NDRASpp6FCu/SZXxhkrPppGK+n8Ve7bB5A2ul?=
 =?us-ascii?Q?so6lllWPZB9AbUojAAOFI7SbRjCVn9PjtzgL2LWmUvdf3zYqcnkIS5BOxcht?=
 =?us-ascii?Q?xiL6A3Lype9/i7hHfseylRyUgHGZwrp25tzyDy8b6m1lsGc7LGLotq/yPMLa?=
 =?us-ascii?Q?uEFs+IbhZV0e5mJNpZXNFxa5COwuc+zgvihL6XwM8rBtgrDMnbq7M1La0a9p?=
 =?us-ascii?Q?dwET+Oc2NvHm+f4DU+DBCoKS40J0mALNU1PDt5ukBayiyVn7D86Dk4+UvKrk?=
 =?us-ascii?Q?ACuetxEjDgrv7SXBfTniMGpHsRZHVhCGlcRNCJVzg0eTuvv0Aiyqgt7sTpn+?=
 =?us-ascii?Q?NNnRFRnY6+JijYhIXE4jX76469VwyxJtiDGF4ODD8hnT6ZKjAI0o/x4n6kQE?=
 =?us-ascii?Q?vretrX6WKwHN0I0G9rPbNzAUxximvcat3nJwQJ0Fnh1jC4EUptg7tK7CRE+e?=
 =?us-ascii?Q?kKUVEvDH5Mtkl2goJU91JLrO+KHeG8AmxhmMbg8sYvrMNpc7rRoqkk6t3VRi?=
 =?us-ascii?Q?atk41nHZrf9o9kiFlr4hqTzSJVzQQyTF79CUklbPxz4VdXeqYvVcGUlUMxEN?=
 =?us-ascii?Q?0wym7tIehAiYHhWvj39cP2EAoyvd4dNiK2q3DSIHegd4RWTVtIZgUsKx/Lsw?=
 =?us-ascii?Q?u130z3AG9tFxOO3cQgYgDJ67H9C2bzsq4A7s4MEOO3D7e0XLpP7IRKA1eLAd?=
 =?us-ascii?Q?xp2KZAsnvA2wozS7UZcCLw8q5sw4aM64KcfOoNg2oZbdq5BPqX8aFqWRK3Il?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5efdf54-e2b7-4d12-5520-08ddfebe366b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 18:38:26.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfWfEeSQqOUPPoZeUq20Y8SBqi238Wx6s8iHy5+yWX/umENNvmsd4EgxUVkLhg0qkuVVFiBp9MKqy41Dc3hkcJQBUG+Weh+HNHQFkE24slw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6557
X-Mailman-Approved-At: Sun, 28 Sep 2025 21:27:17 +0200
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

Convert device tree property value to CPU endianness using
fdt32_to_cpu(). This prevents incorrect values on platforms
with differing endianness.

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 drivers/mmc/sdhci-cadence6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
index 9a92b8437a6..6f60fee6df4 100644
--- a/drivers/mmc/sdhci-cadence6.c
+++ b/drivers/mmc/sdhci-cadence6.c
@@ -220,14 +220,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
 		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
 				   sdhci_cdns6_phy_cfgs[i].property, NULL);
 		if (prop)
-			sdhci_cdns6_phy_cfgs[i].val = *prop;
+			sdhci_cdns6_phy_cfgs[i].val = fdt32_to_cpu(*prop);
 	}
 
 	for (i = 0; i < SDHCI_CDNS6_CTRL_CFG_NUM; i++) {
 		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
 				   sdhci_cdns6_ctrl_cfgs[i].property, NULL);
 		if (prop)
-			sdhci_cdns6_ctrl_cfgs[i].val = *prop;
+			sdhci_cdns6_ctrl_cfgs[i].val = fdt32_to_cpu(*prop);
 	}
 
 	/* Switch On the DLL Reset */
-- 
2.35.3

