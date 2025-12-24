Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEB5E75423
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 08:27:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2A784223;
	Wed, 24 Dec 2025 09:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Gpr4Kd3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE80A84286; Wed, 24 Dec 2025 09:25:20 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0A8D841D2
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 09:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFpioSBhEiuoRR/bgJdctmdUvSkStOTDAeKuG2kLusWgGXH0mpCCh+ZMkmgpLRvs6kFh1hYZWUJhly0t3Phn0iZ2I5vTvf3dfHAtOFE7UFJnRNpnQdD9dH+a3kCMgZvytnpOgDMgMww2MKim4aBb2LsReukYh3uadgbwjiiSJWkjLkDFaFk53D+Pg/VHzl3flyKpI9g2ryTTjaqXwVPOzCQ/bBqhFHh78OunvaWn1rlkyvCpxS/mwyrsm8wV/b7SBumbAdz1x3EbI8hKTX9Sco7V3eDI+crdaFw3o2PoEQvswR38e4wt2eo/onHQdfVvg6o63AJ3r3/+lkd00GYhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6MM2DdJnC7NLlI6GoCM7YbN6kMMZMRjZOaZ3nzflXU=;
 b=DNXRbxyJH8Kj+kJCqDpBEGd41Gw/HFEfESk2O8BHAUw2gqwHapfDSPDg5o64AkgB+dv1Bys2YTq3n99jO2QyeVJlUVs9VXxqqsQg7t67FgHd6NAF/xpXIzbEtegniq4F3pg4VA4Pt+SA5HMDkk50l+OZiqT4EVWw6AVbjTqBQYDozx5hw8/e+XPRKMUhwHrfaC4zEsHji0AK1kxohMHqXGvCHkSUqU661neCsG7s01q8E762UBcZKtg8iYef8UrSO0hpZuhMH0CaX6nKD8FP21p6ctlrOvlD17kOxA7NMfBf+D6nRyANawrJ2/c++2UbSQ9MbWUC2CZCvKqG2E4Usw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6MM2DdJnC7NLlI6GoCM7YbN6kMMZMRjZOaZ3nzflXU=;
 b=Gpr4Kd3MW5zMQrKAGuKkT5cmBKpoVG/FCGt5OObjy/WKcfLqsfQKOl4AsungPKvY/F0K1hiipM3I1yeKyzEO93a4dZ+yz1ropK5iQFFv0Cad4zsEamdHsY7xhS+G0mBhMpbTNYTh/JSVRAaS41jKqoPpoD5jnHP57m9pUFpd+kqzFMTI/lytQ2jFB2uKRv2+moB/Ihx3NUr7pSo779vRRAXjqH/kVHN638Iq4fa2TPkSXmY+7XMtIN5hn/SJqkV7O6b2ZiEvmz2FtEZ9WG9JqCGdpqEYfjvVEM3mTP7xS4xL+ou/C554VZNyVZ6p4TRpAm9w0gv8LcKLJNzHu/zgNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6562.eurprd08.prod.outlook.com (2603:10a6:20b:355::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 08:25:16 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 08:25:16 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Markus Gothe <markus.gothe@genexis.eu>, Greg Malysa <malysagreg@gmail.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND 19/19] airoha: enable DM_MDIO and MDIO CMD by default
Date: Wed, 24 Dec 2025 11:24:09 +0300
Message-ID: <20251224082409.1347373-20-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251224082409.1347373-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0004.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc0f95b-4060-4ffb-4735-08de42c5f792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BNCnWYt/0d/kpkN2psVEaOADcPQ+6tu85Gc7wipYD6VB3bK1Id1zf8piW7AV?=
 =?us-ascii?Q?MV2TGHoMqrr17S/NPLodltssCU9mQsEUTLIdiUosJ76G9+17y1JXR565CcY0?=
 =?us-ascii?Q?H/QKEHuWObZqCbtQvpiFHAG1Fmwr780Mrp0rJe83zCRyap0dRas9uByk2FLl?=
 =?us-ascii?Q?gJItJs9AoofzLHhwPk1iGko6oKzcgdVJEoe/HnBwSFw+RxlSTtlN4WX7r0EQ?=
 =?us-ascii?Q?xCePU1l60wRL+hkt1HUs9eiC8ssoXKUEqAxEz1iixagjWRmh3VPVs4e7froI?=
 =?us-ascii?Q?3MIIE3Wt9d3tyKyWOdpNwF6xektMZW4hVupbQq6KqjHdbxEJT3ljwFiWhio0?=
 =?us-ascii?Q?5qVlWEDWNjbzDrr7z0W+IW5KvFEdwpjDC4DUDumAhrkn1rBAL2JjfPP8YmQ3?=
 =?us-ascii?Q?WdxxvYfvZnznaXHBRFxIz2fK2NKuXZawcNZQ0cJxWjiYiyP28za9iu5Qu4MC?=
 =?us-ascii?Q?qvwMwV/2fJtoW6p/0oQxmD2aG1YWZho6mqhm+PeJuBMVbXYRtOkOvoiE9/aM?=
 =?us-ascii?Q?nA16y+Bl5BhI+AWkbP1HAA2dim0B2ZogA7e3L3ZRB2MuWt438uMUAJceNYB/?=
 =?us-ascii?Q?hgY2VvmtbHMGB/AfmGzo6ltWLC1NtS4IZ2fcbF6a6dSCJQW+uROI4ECV/pc0?=
 =?us-ascii?Q?vn0hfKtICIYnJz461zISBS+gHb8eDXdYSK4sFHLIFAB+1kRmrO861EGTaxae?=
 =?us-ascii?Q?XAUsvRUt2SMrqE5w5a6Stm6kM4QGR587xohaHvIeyopbNarKKBdxImOjBzP0?=
 =?us-ascii?Q?3SpZuWKInKuupDCT41naJU8FqNdaZO4WFgkmDctrs7Ixmu0FwnMUHZg94xwD?=
 =?us-ascii?Q?L48cQ7NaxQ28+ns9jT7AKU+fehb0qOfAgVKe6avm9cAgjh0L/QEj8eIICGEr?=
 =?us-ascii?Q?4F4XZ6y4rzHhYT9aVULuqbNoQ2MaRx4yaDQyO5fE3xySPPrEolQ5lW61OzOe?=
 =?us-ascii?Q?a+w1Q3VdCMwHfoD2v6LwIelVY8BhTVTgaEKhfFpxF6Z11Wi5rZenXdl+cn4l?=
 =?us-ascii?Q?tBn72Aaf/lX+qIp8LV7U5VoV5VhmMbLr8Mi/MoHTDTUnsXTatzMD2KQhcBZj?=
 =?us-ascii?Q?7KRAIef4Ags/Crsv7R7Vy90GVANx99WJ1iH6I3c8oaX8eHhfwJvXK2AlqbVP?=
 =?us-ascii?Q?3SJINIknzUc34t7ENxWrgq16idNS9IKiT6EvcuEqtZuwbgQHLsQazgr0vv6T?=
 =?us-ascii?Q?CoKE06XWLp1gtOBQcY1N7KGHwtjMPwYaE2B2Qw65B9/+EXqip1f5m3ETEoqU?=
 =?us-ascii?Q?oUTtFrFsecNxjUMlVSgIE0LLVzp+QD01Cd2dp2g2ItMBiPEbrxCtnczu9LoO?=
 =?us-ascii?Q?dvef+/+8xH7LFPIHut1vft+YnpeMyoeDZek7OaVtZGn7VFyswXWilL/Y+sfd?=
 =?us-ascii?Q?l+NMBXPWEiaGgx9kIx7tkEGNI9NSDRBOrna7i2gWXymznbTL7q63LVfvLhV9?=
 =?us-ascii?Q?Mex+TAaoaDwoIuSfW7gl36F1bejYEuJ6TTbxssPnrRxO3fJ3KoAdlkCaNVgl?=
 =?us-ascii?Q?hw+Ki5DUoa3Pvhr8MmjZvkaBhN9VQyfhetUQPPYe0a4F1veJ3NKy6+vOCg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lf/uodVYrLJd1b7QIwdYWl60a0ZQ7wek83Q5Xvzq+9YQyc6E/YBX1V40n3tJ?=
 =?us-ascii?Q?bFUu/FSxEVJdyvLxYhHjT4ulYMzjh37Hp2/2CdQEJCZ+myWZtmJgnYnarKlJ?=
 =?us-ascii?Q?Ht6QSKFme2F5D7oSerVnhYSx4/HpI27MrEfisLpyk6eOODdVOfr7wEEEvR+m?=
 =?us-ascii?Q?rjzn+Vi5Eg9KDNHDfiotYB9ibauKzU8XSGhNY6CqzA4QhE08kDfwPimSBmQs?=
 =?us-ascii?Q?paE6F6gR5DgQPDPVDzWT4tzZTnA7mm0LUwl05PKWs2oMfZBDzGEqC37gp+Rl?=
 =?us-ascii?Q?2Ls7aMwNjpLhhw59XkG3m5Ighi4qvfGhqF5YF088lVnNIjqUJiRdBaW9ywU2?=
 =?us-ascii?Q?H4zMIAkr2AR9M4FE6uIhHhLjpLNMR4iwYvsF6j2ZwzwTFqaQrWOedeKnhYVn?=
 =?us-ascii?Q?Gi1tABcyOeIiyp1Q/AmH5QQyDEglvVjOuL1M2Ts5T+KVNc6cpMYlrG2V3tDW?=
 =?us-ascii?Q?JiUFN0BhgxNiB7Px+Dejm3731aibZ+z8IHHnRi1Ae2ahToUQuqont99iQU7I?=
 =?us-ascii?Q?ugHewDqJesj/UC48hjF51s/Ekx6J9DQ1G9tDeN3QJYbVPANBR2UdK+fQQBmg?=
 =?us-ascii?Q?r+zHUfn3phcYPVbKcnEAj4qV5SUUEsDQh677m7sqQttBSdMZ95bC9FI1R83c?=
 =?us-ascii?Q?YrM2zw2kXVevfnVpzSqASo1svRPC6Y1mWiiORjHf3Hbe9UvW+7r3+TqHKcYf?=
 =?us-ascii?Q?P88QKp3jFZwYKkjnv/skqFhr1eAxU9MNC5GwrBpWf9ZL7kOm2buCS2Vl+ixO?=
 =?us-ascii?Q?pijvznnY+8OV9hATyQ8B4pA2FzjlsrOBlKi0PdIf11d4eoUfXeQ1+lx25oYp?=
 =?us-ascii?Q?LSlt0XkxVFMfJPCO/sTx7QesFDBNxbNBRGGogOoPyWzZ21y8AsKASlzV/tAh?=
 =?us-ascii?Q?hRW3kMfHzaycAiGvGUYvDnnOU+HG6dgR9rSnyPfUHRLU5R6AYJmlWkXA4nv9?=
 =?us-ascii?Q?uO1B/LFid9wdDaKPfRFN26EkTHhq0PQrxuARqshhCNmW89m9caWs77xYS3FR?=
 =?us-ascii?Q?5hDzM1SEtJ3Jq6oPUBFzhu+L/Q9vTz+z07JBszJG1RyLtXu2Q16u5vtwDQyC?=
 =?us-ascii?Q?xVfhJ940mArY6eM4t4D2CxBxEeEPlBT5KRn8c5ykNi/+U5r/EXqwG7+Z4RVB?=
 =?us-ascii?Q?ToLRPGwv76RpCsgYjX0DEMSVjUCnLLN/mr9qpOWENbryeAJnS5jwlS67OStX?=
 =?us-ascii?Q?A0CrZTqKNF0lkq4Q+xHeufvkpSi7RebqGtLnKLG646ogMsnfpXPSq34aXtiD?=
 =?us-ascii?Q?e4R+iNzB0cfy4lauVGppFF/HreVC+F+QgDsRHqQCX6ySQQvuk5CBo/CBBAkY?=
 =?us-ascii?Q?Qhb7yhkDydPtbexJPV68z4UHVdG4UIYEqO3WNbuHdFZywWsSK9meObyftTqj?=
 =?us-ascii?Q?Q4DBIJTxGIn8zT138coQ+JD3wX3cAFG1NFqRuUR2ykDHFfFvzDjaVL2iwAmY?=
 =?us-ascii?Q?HNCza0FdrRRkmgvJumBMt4MKMR1WIVxfIXfiQbQUvoT1oplxYwJIWvrfwU6N?=
 =?us-ascii?Q?FAzzvmUg5F65bfXdBxJX7ldI2tYSylFoztTTwVL/NuJRmtcpg8d8I/SHI9tE?=
 =?us-ascii?Q?KXMJQ09oCAg84vfKizftYYfBnrkV1pgcns44gw0qcK+6cluiTo3EQaUKYEFp?=
 =?us-ascii?Q?sh0foscTkKrZudj1AfCDOvSjlmGETfmm1GDsGFSk3HTCeJzH6rJWmI7Zqe/p?=
 =?us-ascii?Q?ePDnPFZwCLgrWoyWQVhvnvBny/uKz6hIzxnkIaCJr7/+fUssUMrBYcLK/MLP?=
 =?us-ascii?Q?MAweFLF9D3KyrMMdhlAwWl7PXvUgIsI=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc0f95b-4060-4ffb-4735-08de42c5f792
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 08:25:16.4741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFwPr4EYZzkApgSN9tny3xYDgdYEa4l43HGANdZkHlshzYY5Hs+3G0vXLjXSyO4HStZjonlCgmEEAM+L59OqVrqb5XKz0O2ccJT4saUTz4g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6562
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

From: Christian Marangi <ansuelsmth@gmail.com>

Enable DM_MDIO and MDIO CMD in the default config.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 3 +++
 configs/en7523_evb_defconfig | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index 37786ace2b4..606689c829d 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -67,6 +67,9 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_AIROHA_ETH=y
 CONFIG_PCS_AIROHA_AN7581=y
+CONFIG_DM_MDIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MDIO=y
 CONFIG_PHYLIB=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
diff --git a/configs/en7523_evb_defconfig b/configs/en7523_evb_defconfig
index 113ddb46a7f..ebd99d133c9 100644
--- a/configs/en7523_evb_defconfig
+++ b/configs/en7523_evb_defconfig
@@ -51,6 +51,9 @@ CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_SPI_NAND=y
 CONFIG_AIROHA_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_MDIO=y
 CONFIG_PHY=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
-- 
2.51.0

