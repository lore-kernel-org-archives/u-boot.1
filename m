Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EC2CAC58D
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 12:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 648E583487;
	Thu, 11 Sep 2025 14:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="DQYIx7gX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EB188331F; Thu, 11 Sep 2025 11:59:23 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 430AF83314
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 11:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXnc9pIx14KSqhuqrUQEhl0Gw7sCkW52qzS20EFnfih4gTd4O4zmqhEvJc5H5NVoqH/cFDVQ7BNIjuWtt7MmoiTFCA+d7wEKGBoZM9ri/NLBseKkuB70aa2tohGbLFIiJCUb+qz19PWzdfz4OZwZ5ORszwWKz/iKbwEQ3OhybYyax7UQkKvOillFJP8I/moG+ZtKFt4ZkAqERq/6EFxgvzR7gUwKlArXMn74tZ5oCh9N6sB+OI99oFsnSiazgiU8u/4y1rH/0SxG/VeThMkmHOgegyb4FGCm2nyarp5G6mRGEOsc7joupoLdb6n7SpbNgtuxsCSMoUlHkdrx7OzL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BeMmfuGOa9gp4Gre/129kqxq/5svh2kuDyDU2z7LXE=;
 b=J1vjKkbi5hvywTdYot5rmWVWkcq20lMmNcZrz/T7Q8n27PoVe+Qf7A8lFsN9v0dIgwgDwWVRH+R6ZlgEsD8U5CGFkp6OyY7qF18voBFETe2GW71Ielz6CH7XJ60P88jWrROBN7yrgapIb6Aapq9qlPXkKpfUm0Fq6t7hsWHeptYmXJjT7oVsYyXzKb9461ImfLDAqi38jW8VJkeiehKCp23X/YanVj1KvI/CrRg5ba8eIXqEfq3K2eD3GQh1JtEc6tUPXCDARKZTz9ThZZyQ73m6tL0Yt5xG2rCtjLYS9dAviX3pTpGrvdR6aOMqFEAHAY2RBUiSWVJ6ka4KWiDNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BeMmfuGOa9gp4Gre/129kqxq/5svh2kuDyDU2z7LXE=;
 b=DQYIx7gXDWcmhv2zDnax8/cHUCXQ4n4sZ2jMJBEr7JPk/sMdzL611cPtsAIfPmSG0h2YG1WBYslEgfq3yNjBQGVXq+VK0+EJLGb7QTjzCPeaGj4YaCub/T1xsxRlNOHS35LrPGtOYzY7Akt/huTNcpnjRxs5gr4Dqr8DOjzeeVEQf/oFvitQFNB25xHfw67/91UTLU4XZEn0wM6U9ql6i9bZGR5RhfdicgpWGcEOYCDKsob3fz1rvB1Hp2dxDMwZtvR51+lolQtySNgcH117r2emzId/PauSRbsVQiLzMGwqImwrB8BFtSHVh+EH81nwMZ04zdUlj2rko+7r+PXw2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB8490.eurprd04.prod.outlook.com (2603:10a6:102:1de::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 09:59:19 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9115.010; Thu, 11 Sep 2025
 09:59:19 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, festevam@gmail.com, uboot-imx@nxp.com, alice.guo@nxp.com,
 ye.li@oss.nxp.com, tharvey@gateworks.com, sumit.garg@linaro.org
Subject: [PATCH 5/8] clk: clk-uclass: Fix clk_set_default_rates issue
Date: Thu, 11 Sep 2025 17:58:38 +0800
Message-Id: <20250911095841.3659022-6-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250911095841.3659022-1-ye.li@nxp.com>
References: <20250911095841.3659022-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|PAXPR04MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d837a5-cfc6-48c7-8413-08ddf119e004
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|376014|52116014|42112799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wnS8Pu5hZSKk+Ls9RC70aHEQt+mhD3ABWsKQwRkYKGZra3kvJ2820O/Keham?=
 =?us-ascii?Q?wDSs2Y3hOMR0Wi+dIcGpX9CDXjBnvyrjiIN+Pau7noln4sOGKFoKUQft53Rg?=
 =?us-ascii?Q?1SVykD2Y7Ro1HcGofAFfet+IPX1pjKM9uaW/tSQxjHTyf5N7DcY8t3y+nb/3?=
 =?us-ascii?Q?xjWSEaKihNt1dPeYK5ukjU3KxkCeJCpn0oQ/kHBp/joAvh33tVUVybith6Dc?=
 =?us-ascii?Q?nw0qXJMhTKfSbWK7kxEDF8id5ZjwXQzJN00Oq1jEv+fe928FPGA9Rhj1CTwk?=
 =?us-ascii?Q?4Y/5FVbonm+W09AhWtV8PT2h5kf6LzX4Xn9b0wXP+uMPq2oc+YXWrDaZK5Y8?=
 =?us-ascii?Q?lRw4VNckDYfjl9a4HkaHFqOIwGPH44Wbiu8wXfDFkDSDgWcmXZTMEnsfeWjq?=
 =?us-ascii?Q?iQf1rFrlhT3JDD4KgEs4AMJujEznwlY/hKc7pGoWyBuejDjq4vrC3tJJWvfG?=
 =?us-ascii?Q?m1JhEXRLkgoALaS5qeFMZF1lgs0xrmOihNEk2VI2VQU5bIfcjpOGgZy9Vl4v?=
 =?us-ascii?Q?0HX6xAkNiLoyVDAkAoPj9RJsRkjL8GD4QPzcrPsuk8dBMuJEZhGf1jLxdRLn?=
 =?us-ascii?Q?QlksNLpXmaYyHG014wWtka5wjDlBatysDtCtJ6wV7aoUvBxaNr0iwkOD7QPA?=
 =?us-ascii?Q?ALNzbL4lc7EHoMiH1hnX4Zop+I1bFArLi/IS9FKn7WamxlXhcgRpHAveTNa8?=
 =?us-ascii?Q?Ij8ibIGFd48VGMz8V6bQ00G4glSAy/FPSCiCAfpm3Tp6HWaNhcLvy4Yef5WI?=
 =?us-ascii?Q?FrE6PyBUoxNJsFE2AnGD7lBUCkggiZ9bnZAuxs0xJE9C0byLcllKTXo5NGCi?=
 =?us-ascii?Q?L6/w2eNFYKFeG0oO+Zb+W0ovuYDHCOkVvSXFhvBy2suANlkokJGpvcfF413F?=
 =?us-ascii?Q?8C7Xg8CDsBCodG3xrJsa2YEypLjSTTA42SQ+xJEY54JOdYcsNy5CLIlpYFo4?=
 =?us-ascii?Q?xxDNyzxD29yd9cQxIOiJzVkrJZgqMnGI7/1poyh0BBvyCTBKe7tqyxa3xAsl?=
 =?us-ascii?Q?Mav9sdoLvETTLxSwSfvoNH+P0uktsQoE4gt3TZai1vN8c7SeHAnyiTEHghRr?=
 =?us-ascii?Q?mD4DKwDMso4EhHlknKaNCAktMSSLVWiZf7HXkmR2zSJj2rd0/DcFzZKx5eWF?=
 =?us-ascii?Q?7MkIKPJBJVG3jmpueHVfXR+HpFgYT4XAtKlEibggBt5IV+wp/KmuM9+CDloi?=
 =?us-ascii?Q?QFm7jy9Hk8ZNbnKPk46/adx+4iLUUDLIGLunJGIajOV5IOAbuSDvnOiFl87+?=
 =?us-ascii?Q?AAp/lKoickS9T/tF8Mf+3fIFHgUZy9jNrgW4rfGQMQROVXoEyYhpuX9JhRFj?=
 =?us-ascii?Q?dRrStAhJHDJXR1LyYq5xvkUTPt1rfbx+Fc6sGIcVJlLoQrkC4ukVvvVCkhES?=
 =?us-ascii?Q?G8whPZfrKhuW/tFMV3ZyGM3oT465tSCEgYxR9KlmQbMPJ4JK3Mh17SS9tJ+0?=
 =?us-ascii?Q?czA3byfpYVd7kVdB+v5CW+YXZZCHmvljKolenEQrqiw9KhxkQ6akNNM+Slrz?=
 =?us-ascii?Q?SmzmDjPptnuvijk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(42112799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/nIouB80tCJfNNzhWY8anIpmaE/vHpVtTWMujXH8vpfdscD2ZhmRaA9MCli?=
 =?us-ascii?Q?ROqLrk72mBUETEbAjzevBKORN6tXVwc740d1F7XQFEJ8cRPxHWKl/402V18F?=
 =?us-ascii?Q?g8pEOvh7DLdX1xb7XnWnyizRL1Y/ApYFJMDqtFfZCugV34LRhgKq7ovQPJHS?=
 =?us-ascii?Q?2Hdwr5rQRZw5De5w2/qwQEuyUp8SPmwQ4risBqAb0B9vKTTt8Q0f/8FiWx9G?=
 =?us-ascii?Q?oE75/8Y4m7YYHk6+Yvnd8aSbpUNoT9kN7hAjW20d7j2iyPJAeEz9hXZ5RB0P?=
 =?us-ascii?Q?0O3XpNl4WUDQkQSf57WTKwH6S5omiStZtutIcrJJZ3+lY/Tu8YO3LhUufqoL?=
 =?us-ascii?Q?78QLlIbhYAFokvMgZVFJTbOPb1Yo0rtFOmWsaKb4ogYbzuafGhI175oYWoTK?=
 =?us-ascii?Q?Jd7HGL4WggBUk0EF+jB9Huo6UnbYPMPx7k0p6Vb3KOd+R4ikS8ar8gB8axp8?=
 =?us-ascii?Q?LosjlWRgz5x5wakF3yj6Q2lXoTimclRFzfdN1rHAXlgHLayRtjuidpL8tpFJ?=
 =?us-ascii?Q?SVKZHLtbhRbT6gVLFqu1aqeE8357H4z/Pt23C57CLFEninnFlT5a7SUgtiWu?=
 =?us-ascii?Q?hUY/G+0yPLL6S7UK6js3lCCRzMoiACkao0jYaKvHg++mT8hM8gnWw7HBzoV+?=
 =?us-ascii?Q?vEBQz85T/5ilOSklmcigu0yyp2niOsUODanqkx11IHrwL37LJvixAQA4P5LJ?=
 =?us-ascii?Q?Hn8mD8Q0vTBD7P56GhbAJ7PWoVl1NcnTAPd4JSsxerBOD+7l28G2MYZFWPg/?=
 =?us-ascii?Q?kv1sWwX3VoenZ2Mehrgv4F0MmmnywT2PYYipTmoZ5iWs+CxQb4A1AgrF874G?=
 =?us-ascii?Q?13KSJjLBPp4Wle2x6+N6C5wtrl05MmX6DeNjK0IIQZFyOLAD2OrA+2Qc7kbi?=
 =?us-ascii?Q?sGvwQslY65AV56o0hEpW2EjyoG4SrIb8uS6ayFfs2Zu1t9TyOo768VOSuoHp?=
 =?us-ascii?Q?dZjDbsejLfoMF5kJ8+7fOk3mOaFch6EJApGOjfRQfl+WqLyJ3QskEOpv/pmC?=
 =?us-ascii?Q?bT3R5V38OvS1IsYpODClQ9NOzwdDewRV0EKj9O+hCCCuTGqBzscmPmc/E4kZ?=
 =?us-ascii?Q?9pWeTWufb9LASat5g5S2ESpWIugcB0K3bPxfa52vGSXFl4D9fU8lWYGRzwjL?=
 =?us-ascii?Q?8vBdLrgWEUMYmUAfFGZcdBM6YLiLoKAEwzxW9C+tfvX9wIqO2QqAgEMC+KUj?=
 =?us-ascii?Q?NU8Wt9+AQ3awlJaUj9UhHfbb8UU3+Pz9eVLDes43dHCV9BPJI90eIOBfBMpm?=
 =?us-ascii?Q?3FunzL3A45jy7hcA548ZgHm6BvTDrcNxlSDnpzgp2FimYaQBy70bWPj08xjb?=
 =?us-ascii?Q?m4dB9DYVHgeFKXH1NVWAi/vsSzsnlLoiu1N0fOfuP4ZN1LPKDgz87iMT4giW?=
 =?us-ascii?Q?v+9sUumYQ8WrzOGtHMpgHUfxFJ+nN81UsQoGiJzpNtbTwkTFBpYYck96mwVW?=
 =?us-ascii?Q?uTB94t1yiNw2q1MHJ0VPg8O7+IKbzE6ZWi9wKIonci1dYLAYkdkbKqKchGUc?=
 =?us-ascii?Q?/QZJi2fHztFjnluxxkxlVPjJFjxl81dWqfQ8xD8TeFEFxDMCRsG4ShXvJnUR?=
 =?us-ascii?Q?oemk5pV+xQZal9VrEok=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d837a5-cfc6-48c7-8413-08ddf119e004
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 09:59:19.4774 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wDF/C6i2CqO3/PGQw9MX2Xd4lepb7XKrj8uJwnssiDf3MyvFh0FkFaB0dINmffs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8490
X-Mailman-Approved-At: Thu, 11 Sep 2025 14:15:16 +0200
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

clk_set_rate returns the actual clock rate, When assigned clock rate is
higher than 0x7FFFFFFF, the return value will be recognized as error.
Change to IS_ERR_VALUE to check the return value.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/clk/clk-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 7262e89b5128..3dbe1ce9441c 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -358,7 +358,7 @@ static int clk_set_default_rates(struct udevice *dev,
 
 		ret = clk_set_rate(c, rates[index]);
 
-		if (ret < 0) {
+		if (IS_ERR_VALUE(ret)) {
 			dev_warn(dev,
 				 "failed to set rate on clock index %d (%ld) (error = %d)\n",
 				 index, clk.id, ret);
-- 
2.7.4

