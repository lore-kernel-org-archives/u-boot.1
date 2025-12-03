Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C19D12D55
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 12:23:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EDA283FBD;
	Wed,  3 Dec 2025 13:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DalON8B4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA2FD83FB5; Wed,  3 Dec 2025 13:22:36 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDE0C83F89
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 13:22:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEHHOJfEJqHdWudCc6nATGfyIUc8pLR0t9UHIlKcHg3vsvYcyv2lndxYbmLjeYMBqx+CiLq+JBokHNlV0HNtramUCgfshkMDOKiUFSbr0pbhjB3DyfRa8ggxmZ+USteA3HhMCh0Hpn3PMSUur7S8SM0JS+Ppt3//iz22rSN9zElC1zqC92pAepf6ss/HECjslAERRWD2+SLhSzVWwkTau+8pR5Vs6saO0EtFlPV9jvqsyYdzPXYaf93IKTe0EOXo9QolBtCNEbjL96CfDNFmzR1+3JFeeCzCUB83C6TjqnyZRxY11Gz7HUmv0ME6PDDXkzO/HYaHnx1brG38Hk8O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXjeQO8hMt3hbT9YESBoP5CPoyMTiZXvO9q96KpKCUY=;
 b=Uin+OCso0dLd54ooCGf7Ot/mBHbaHFaGmqa1GQKYz4j2147n0QaOUyJXzlKZdVioXF0Kf4LCwK94mGAda2lz9/U1dynp/BuNwRWIuw9civRrvRng0//dcA3yTQP3yYT1+mf7uR+n8w4UMTbM4sBkxbG+suaup3F+c1bp5G3vFZNXENOqOqAYSOXJ2u/GBY3vpxn3kn7EvexPF23X3wyLVhy10vKkduqkDhuNPQph6KqQB97qP2aH2JQNtgeLDoz8spRxfHKa/eBKrn9gUJxC8zGbrXp49lF+zpZRy0Hk7qLonIznxGj1vd0NKt2dmAE6PAg2o0GDEzvAEUZK6rAlcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXjeQO8hMt3hbT9YESBoP5CPoyMTiZXvO9q96KpKCUY=;
 b=DalON8B4WCCwlZZ5zhfnPVdQ6KTpJllbizHLS8HnbiJSA2qdzgoHpdPQoBmyBo0fdgje88sa7tJr9jjlbZwrvEtwUOUfRYwHEm0gZoMkK1SsebjZR27W9IjM/gm+ULs5+aIMCdDzN0fKPknDD/IVkHEpj/28Votws/WIa12NkH6pDjJd14WtoGeC4Z952NKft8ymA9jq5A2DvTDgB5EhRmZyFFhpy6DpXl6E0wOLXLZkyF0RtXvS2jBrw6DiOlwrEjkHR/PHY99t/E6FuEioTvv89eDQ1KgIb04GlvLAWDLJaPnvvdf7YSjuGmY00lH57mJNQku6W9iHmqbp5ViOlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA5PR03MB8452.namprd03.prod.outlook.com (2603:10b6:806:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 12:22:32 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9388.003; Wed, 3 Dec 2025
 12:22:32 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, peng.fan@nxp.com,
 jh80.chung@samsung.com, trini@konsulko.com, marex@denx.de,
 tien.fong.chee@altera.com, balsundar.ponnusamy@altera.com
Subject: [PATCH v2 7/9] mmc: sdhci-cadence: Enable software tuning for both SD
 and eMMC interfaces
Date: Wed,  3 Dec 2025 04:21:37 -0800
Message-Id: <d1af5400543f402da1c36e7ab786e7c1f1cdb21b.1764760325.git.tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1764760325.git.tanmay.kathpalia@altera.com>
References: <cover.1764760325.git.tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA5PR03MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f745059-13a6-42e8-86b8-08de3266a20e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YcnnbdxDHsTsHIJxLt5ABJnQtpzY2WLn6MQ8pIT46RGpeLigL1rfG1XfBIiU?=
 =?us-ascii?Q?EOyxbTqjNTes32rcidgZjhe82r6lEEtSxm+7FC4nmx6k/pm0WMLac63v/6w4?=
 =?us-ascii?Q?gK8R8xIuua4V6zs/hi2eCG5fNU0l/iYuMGa/G5FQnVwSyAdblFGVD3fab6py?=
 =?us-ascii?Q?HKTqkZrHuTl8IKplryIUFZOkOr3b1fGIfdzDs66YVdeuYwJJ6CdcCa69Vy+A?=
 =?us-ascii?Q?+Gxm0/TMdSjjWnDRnxatcXKbnILqHmrGgZEyLuqHYNgnDOtak2ha+zGzhqFp?=
 =?us-ascii?Q?FAwGivog/DJrVblHfZno6Ali4Nxs/CpowmZWlIUev5dOjKT6cFKnUk0P4T5e?=
 =?us-ascii?Q?JhJbv1dJrxezXVKlfGRZ8Qtvwr4kSFnhX97jCh+dGeDDDaJJd4z1T9vURqva?=
 =?us-ascii?Q?valpnFxO54v2gPJzk8Reua70Q3tobvjstnR4nHBI4W+udZL6NX7SVnMAJzv8?=
 =?us-ascii?Q?ojAvicIbTGkV7N0mIkTs0K1keO1OXkJaE7KcFMK+paZOZIAyWwU87EnoPi1w?=
 =?us-ascii?Q?ODOO9lJ2sXlwdUaAjHNNLfb9X9hiAt7P8fD8pQpmqStFVAdj0LLunUWwlFYo?=
 =?us-ascii?Q?yCIb6b0AcJiY92yySXsA6u69yyZiC8fWMs85P9j1Kdsm2QGu5Sp1lSrKkt1U?=
 =?us-ascii?Q?QMJ7ctAghfEJ7ddFpv/5t3acbRADhspe7atc/+B54Zk3YJVb0qFaWX9XBvGm?=
 =?us-ascii?Q?8IbyZevW2pB72PS55or/m+d9wSx45/yMaxtsrgEQo9Gk7F+VwgQLqnHwYwYO?=
 =?us-ascii?Q?9WmU3+yKYwzGZbzYpYcjsSdTrLV7V4I+8S6cjKRFgXcRR7dhXxepAPaXxmlE?=
 =?us-ascii?Q?Od6J8TDoB32jjFU8kOX5rGHeBsuiY1+i3aUcL0bnzoXaq0hHatx1gW2U3/hx?=
 =?us-ascii?Q?GmDjVqjhm/SED5Gdwm9yt95av0Q4DESi77foA1cu18TZJHVQ6tu4i8meDw5q?=
 =?us-ascii?Q?ictZma/77loXS1yaa4sGtPplXGk55cjWiFvbdb7bVaQ2jazPkQBnJ4RSryVh?=
 =?us-ascii?Q?AsIG9v2o7eIl5sp9UAYtAQONVZRnawvoVWoS6SyhM8J49PDwE1KGpbVe8RP7?=
 =?us-ascii?Q?VcCbbf3rACHaQFNF7SBGnOaGqmlxVbuo17MtzSjq7vsVYtSoKTGAFNi5uPr9?=
 =?us-ascii?Q?+qFB/29apYaGP7nLeyMccdAL3Md5O6svKn48wztqpuX/0D1cnCs22uhiBE6U?=
 =?us-ascii?Q?5gJqaoWIgmpa6OgznbfBxaLYPx+enS5sSclym1VyKI9lLEymCbNp61S2l2zz?=
 =?us-ascii?Q?LWVqrIBnL4aSbsAHd33yShckCA2Gcip8194afufihNMlKL2KJPF8NE7RUiZT?=
 =?us-ascii?Q?MoyO7k4nzZPfwxCxLXPSW9rfHKw3s4Uj24rHhNkgliEGtngN2fZ7ricIhKLg?=
 =?us-ascii?Q?n3FbS2reRrKTae04QSoWAeZqzOdRAYLB9rdWyMyHRnMNeuny+96N3R0ojCDr?=
 =?us-ascii?Q?muZqNXAYVBccYWIELiHELtv4W1UjIS33?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RmpbXlvpoQLJ4QIqAOahfJSmwwqTwT5AM9xuO+K/xjDr7z/ytZ2c7dsh2eZU?=
 =?us-ascii?Q?Ee5dq1XItRuHrdKbZTUhrBL+3/BwZdhsIHzVDhbph/NJ3hFuJdikf/jzXZg/?=
 =?us-ascii?Q?EpktFFxK2DrTkibGoo38qDiuiizWA0JR0S0xFDGz/Tsz2W/bl/jfGVPLbkrU?=
 =?us-ascii?Q?Up6YzaJi9uZETH99nqcXcrqbiTVrzFAdRGkNu/65d3g8gRcOIJrkM1KxqDB1?=
 =?us-ascii?Q?giSYAZzvUAhVWQo07Mo1L+OrSqCXd+u3j8oRZodkzzkypZSn2Mdjr/VVXj7C?=
 =?us-ascii?Q?8CZur8kHb+zbdkBsmg1AK9gsRIuQP38f9fWPcTYre5EuZzjhu31fSRWzqf6K?=
 =?us-ascii?Q?RxxvJhmgsNQ+uVJ9CVrx6nPa6bbR0h7KGFmc++aa+CnOttwalwmdmyHfCeRi?=
 =?us-ascii?Q?IVmTVbkivTHyQ7F5+BtYdVm8b5C7VW6oQ2/+L5DzhdBCudDgX3uTl9t2gBAQ?=
 =?us-ascii?Q?RTpz4PMczd/rRio0YeTRrHiRupQ6OaUH2yWezwuGL9VI+PQrBfqKsiwR2dC2?=
 =?us-ascii?Q?3Hpei4NSdRYdYQDbJvff6OWMhEx07W/OctloJkGlG2kQFQ9J0gvkiIxfJMcJ?=
 =?us-ascii?Q?sOgdPCPWSZxDXnNNbqdOcDcq2tkmvy8NmoY7MX32QPPqPIFuodJEYdAXG8CX?=
 =?us-ascii?Q?PL6Q8a7NIadg76Qa1hsDnfUjRmhxGmleqx9vy6vDb8TBjj055GeMzcNe1USK?=
 =?us-ascii?Q?5+BePf5n5Gx12NOcTxAcOEnwPk4O3LgFzOnU4RqX8gN7tEXbiPqpgZjbnw62?=
 =?us-ascii?Q?74Ba70t5J7WBDJsYKYKe/tlU3xekUpLZ2B2gLrR52IISsXt665M48m1pCf4J?=
 =?us-ascii?Q?3+9GvhZQVINM9bnPd3cDvb7qKiHMtbBb6eGeyk+/DG0DIaDU8N0aRhk5JohO?=
 =?us-ascii?Q?uzmrTsWCFEIr9CtLbrJ0669sIPuFmshpeuRAwt4Y0LDxj3g+s9117NDXixpB?=
 =?us-ascii?Q?e56h0KfCoUCeJ51qHhAgqyCkRMT21PfUscxS2refGr8WIs64/r7tsv41kfqe?=
 =?us-ascii?Q?Sgn/DNRYQP+wsvmxlHp02WOWUGvuW6kLSS74SKkZayP1MMspdbrQSHXVHKOQ?=
 =?us-ascii?Q?ihd9+UNbLuhssq0VX+3TtIa7WsBeH6TQzbmQzvNwv95xg+tIkp5hiUbIPQI3?=
 =?us-ascii?Q?xE7KDFA8SXi4dESFxDXb/qXybnFXDm79u90WRZMGNcBoeu1EFBXXE4slG1Ec?=
 =?us-ascii?Q?xEXHecYsqEWacV2pt4QgEw6VK73gsc4KF1mQsM3HiRVINn31a6grPeu4EJmJ?=
 =?us-ascii?Q?y53lCct8wpeF48y1EXKikVOkHQWBnI1Mw0gNENEqixrPJxaPRJFQg7AWfIw2?=
 =?us-ascii?Q?jY34+ppKdNgcR15rVh+SGJk3xelDE/VpXQkHdl5E2gOhacPMkm/btkTgBYFu?=
 =?us-ascii?Q?llESIf5YbbCTKyo+eiTTkRtrBAUH4P5kN8hfdRLHsqStA+kVxvIqPcNOsOLd?=
 =?us-ascii?Q?8NNDA2lbFlosJCKOqpu6qX4DCB99LpRupOyum8Ax9D3B6XLMPj7lkLSoc9Vt?=
 =?us-ascii?Q?mmtP59JYHHBBxTt6P+a7QdgfO5srs+JgNqgX5fHuyzWr/HhNyyQdpBZVdeQI?=
 =?us-ascii?Q?sbInHdHSAswPE5M/Hp/AtE/056JQCASfFMqqI1bzonoNvs0dI6eiHFRz1U0G?=
 =?us-ascii?Q?SQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f745059-13a6-42e8-86b8-08de3266a20e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 12:22:32.0869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u54lPEFA0j4lRhOBObIJr+t4T7FyYNeud3+l5nd+aD5hIwY0FL1Qu0xb1pO3SmtP07U2GZk5kYzhshvOgMy0Q9T5uKHmSj3b8kCFf7IsGVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8452
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

Remove interface type restrictions in sdhci_cdns_execute_tuning() to
enable software tuning for both SD and eMMC devices. The previous
assumption that SD timing should be handled by SDHCI core is incorrect
based on the actual function assignment logic.

The execute_tuning function is assigned based on MMC_SUPPORTS_TUNING
config, which is enabled by both MMC_UHS_SUPPORT and MMC_HS200_SUPPORT.

Changes:
Remove IS_MMC() check that restricted tuning to eMMC only
Remove opcode validation limited to MMC_CMD_SEND_TUNING_BLOCK_HS200

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
---
 drivers/mmc/sdhci-cadence.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/sdhci-cadence.c b/drivers/mmc/sdhci-cadence.c
index a0b9434e4f0..c7f88977ef9 100644
--- a/drivers/mmc/sdhci-cadence.c
+++ b/drivers/mmc/sdhci-cadence.c
@@ -207,16 +207,10 @@ static int __maybe_unused sdhci_cdns_execute_tuning(struct udevice *dev,
 	int i;
 
 	/*
-	 * This handler only implements the eMMC tuning that is specific to
-	 * this controller.  The tuning for SD timing should be handled by the
-	 * SDHCI core.
+	 * This function performs the tuning process for both SD and eMMC
+	 * interfaces. It sweeps through all available tuning points,
+	 * sending tuning commands at each step.
 	 */
-	if (!IS_MMC(mmc))
-		return -ENOTSUPP;
-
-	if (WARN_ON(opcode != MMC_CMD_SEND_TUNING_BLOCK_HS200))
-		return -EINVAL;
-
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
 		if (sdhci_cdns_set_tune_val(plat, i) ||
 		    mmc_send_tuning(mmc, opcode)) { /* bad */
-- 
2.43.7

