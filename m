Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7F5C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:07:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC36807CD;
	Thu, 16 Jan 2025 14:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="pNcx265X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30C98033D; Thu, 16 Jan 2025 06:44:56 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03BFA80040
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 06:44:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz9mRU+lCMejDHdjYIfV4QLgnVvjA+Wo4N5mYSI7P0sexIGDxu3hJJUV35UUB0gjppkneYi43G3Z+d3uUHpnz5ioaxnluQEw9Qg0qvL3uPHZqomkI0dlJI6R1/BmeAI1mMrozykwTovSM57QRi81cf2ndNNCQssg1aUXzeR3tAVYObQLoCUHdXC0MTK61IxuHr7VRBko+02KG36dEyLDZCl2vVRguSqBGjhk57uHE9z6eNMVEdwmUuSjjKHw6K+3/juQ+QCq87jHEeJZTvE4QwLg3WQeMZ9Q+tey/d77jolrb69GXJ2V0CPpL4+m7S8FqbNOVeqhQYXEtVb5yjYBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuoo7hbaOmKThXTYerS4OZXofJgD0Hgnl2FhTuU9m7M=;
 b=xquJWcYOBa4dHfNLBEKVmGBsUTI5yLXxgeVwlopnGBralKKbQrTKQa3qzwlgz2k0aIOE3IpdAcuyiCf03aakTSNL1NT4E/JmZ2QJm3lNcCaWhXcxzC7R1jKxwQXcsTAJmbmtzV2wGWto8TrWX1Wo7blz0/hmHrSu8Fd1rKC5sy7Ba2wCu4xBCzqeU5pmOkhI0AegfVhCsP4W6g1lEnpmozMREid/W0NEj2A72kUefxcORLMnb+LnR28f4hf9+3izmj493mXmUQgFRDoJy1RtYevxW9kZ9wfDJ+HcJ26TFyxcM2vpclzN1HfKfx6bxdMQnCJRa9KQd8zS15xfVidS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuoo7hbaOmKThXTYerS4OZXofJgD0Hgnl2FhTuU9m7M=;
 b=pNcx265X4s8J6jn4vRsloFI5kHDXbtziVv7IMb+3MOdYTHxsYWSj2494qqlcBDL02o/jFOXJtQK5S1G6RiWOxyU2veoZZMSLM8AtqEJlcE73sFUd4vczXFlsxstm2bsslNcH8cPzXkR2LWINl2IZdb7w9eBqwFGBx9uph4IMBv/RZbfQCHzVRm2F2Ity4OUMbhmGzi+Wjkx2oSnJ/s8CX590vn/in1wZGMAhL0zuuRDa9qC1arp+m6nT0eiVSXtEQnG7rFfj1ULQpI+EeUQ/FKnjaD5iN8p6LreYgmMvSkg6JujwO1xg7K3jmMdn+QZdE3+2HV9qKBiaK0B0FgRdoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by DUZPR06MB8794.eurprd06.prod.outlook.com (2603:10a6:10:4db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 05:44:52 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 05:44:52 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
To: u-boot@lists.denx.de
Cc: Tapio Reijonen <tapio.reijonen@vaisala.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/2] net: phy: Let gmiitorgmii converter create additional
 PHY
Date: Thu, 16 Jan 2025 05:43:23 +0000
Message-Id: <20250116054324.836712-2-tapio.reijonen@vaisala.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:208:14::28) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|DUZPR06MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed19f85-ddf6-4833-d7ec-08dd35f0e602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9zihnbze8EsgEmhLyfcvYltjwUxpfIrCaRv5zTmfPFOmlBygkBcF7Ke7S1yg?=
 =?us-ascii?Q?tAyvg7hxnYIuTH0wwWHihGSWCHRHZRM/U9l5RmHDRidVnXZ4k6mBJHZ29XlZ?=
 =?us-ascii?Q?5mXkoPnfgNnfbfWfbHSb0wEqgS54YPCtDbl4n3+ybJIwTG/bDDsJZaD3Pj/b?=
 =?us-ascii?Q?/CBrhdPOOPH+FiiHOSKtnoDCkg6l0pCwr+CxWfqzwYjb4XAJOGTXJKx94U77?=
 =?us-ascii?Q?286y75vcd20xvfkX2lwMSBPyZYMVL0dlOQ0e+6oqnSMGfttA9BZxDvD29PkX?=
 =?us-ascii?Q?l9kdUK2daIx9f/ghHMu2B5pouaROTJK/Gkmva+8wb3HoyviTTzwiNn+5PvYm?=
 =?us-ascii?Q?MPssClIHgr1EZ8yzd+faxHemGTLod2CSEPtf+dHcNxgESNLIZU+YwQztJA2A?=
 =?us-ascii?Q?byx5y+wOy6r3wo0YNJtHfcABs3XPQldGKjW127DxKTSPPzqwIG3zbHWgiaey?=
 =?us-ascii?Q?qT0mcOlP9u+7pbhP0W9sUPKyQjo3/6tEawFlc0sOQaIKfxDzpplTwDrFoRUy?=
 =?us-ascii?Q?QOAy9NRaEzlIyie267kI1GrDl2jrvU246Te0CERPHPG4c/gjMUJCdJcEAYyg?=
 =?us-ascii?Q?OAvUVJ5Ec5hCGsimdCnx+kg0sbQka24VinyNVqLuvM65oOrJapopjIIIP9oy?=
 =?us-ascii?Q?vnPH5eNvjxu+fcS2eoq5Wc31Y/yMlM5OsOZtAkQaR0GCLu9Tl04yXX+YZ7Xf?=
 =?us-ascii?Q?duokF6R5BhrFsbxfofwiLIhFQYP4FyplDBsngQNrryTHxe4HId9tA4tu08JH?=
 =?us-ascii?Q?zjxZWnj4V/zZq6y/RjetXkETHdu97N2TT4oE/tgeUqTEhnLlXf6wEAB7PHYp?=
 =?us-ascii?Q?rrn+tnANrrt3LiG4h7/68ylriSRytOmluK4kvOpa2qNgE66pbzfbs2gbUM3Z?=
 =?us-ascii?Q?X1ggMiJWHiHOXgA2OMy5dE1DKnPLa1tbMq3MuFfeTZTTH8jYMhgM49expXTo?=
 =?us-ascii?Q?/0zfALexzqGbgKxnoYB9shq72lcsJtlmQrhgi9x4yDz/dSdxJJRej8q3Q6+J?=
 =?us-ascii?Q?Se/jm4l/ZYUSwLGI3p6oaGwEbc8BYeKJ2N8q1ktdyFLgVK6LurGtx6bhHDaF?=
 =?us-ascii?Q?gULqHOiU7nKjw/vOelcj8DXuVbesH6d/ItKrcih92Gl7aBaZ3SK4KJBoic6D?=
 =?us-ascii?Q?dxCe4rBhe+rFu0It7V6MG80wA4dGjTQ3KSAxCw8IPwLkt1/Bsp/WiXtPcD/G?=
 =?us-ascii?Q?bTj5+hIeoOkGuQbyNdDsNAg09Ovm75FhzDnzALSW1TKNCYChF2bC2BJoEx+1?=
 =?us-ascii?Q?MAECSxhzK8qb/97NHvnuxu4jFvSQO6gaerxELMLDF8G0p7sfw2F61fjAAwyb?=
 =?us-ascii?Q?P0lZF99qtxDeH7OpmAl2Oiz57loT9QtKli0SAsLXvqoDaJAd2/zz40U0Y1hg?=
 =?us-ascii?Q?u6jS1yemMBUiDEdv1YWitG6Yd5UEBdUPGRLjhhZtZVMSpmNrIyo4gOMdvRp6?=
 =?us-ascii?Q?E3JtJIPRx6OEEgho/cpxUJUcMYBC30Mi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jxvi4vDOz7o9aBX7WpK4AJ7eLQ/mR151D8x/eWNorv2OG3kO/od0MqLHqDM8?=
 =?us-ascii?Q?VajgwRbse0joP73AUvCATUDl5ge7YpLvtYn96CoYtuSSX3aN7GlLHWwrAb6z?=
 =?us-ascii?Q?8Y74VaMZFh0KlvD9UwbGXqpDk8N5vhFZevXd/TM4qUoIdy3+tNb/PPImoyij?=
 =?us-ascii?Q?71QfE2j9MyjFoNMlRZCo0wSMX+slzrstV7MG8niBcBc+huYT6TimFw1n7ksO?=
 =?us-ascii?Q?XWOqh5AoeW+2HdH7pzY9rwvWZ2sVQtzdx+FU9v8VYOpx+SA2y2Oj5TrxCi3p?=
 =?us-ascii?Q?qYTTDmw84Q4AR/7WFKDdYjLoygLetFNJfy4A4/30wVWRERCTqdighPKuDOd5?=
 =?us-ascii?Q?7PcklXqZ1zI7Wj8EMQO2zq/DtFgxtU7248W5GLQxS0czzqpC/6UBEXX/xhVG?=
 =?us-ascii?Q?99duRM3bIbQRdnF+lTT4uGGuAj8tjr1HUssJQ3+gymc8zTGxn5qGKmDADLJn?=
 =?us-ascii?Q?xQdJIJGd7hbEpNKLt+lfRNXXvzMjl/mkyeS44y0WvligwrR57Be2kcAq3qqZ?=
 =?us-ascii?Q?eWJ1FJM3oS7u10ygUU8rvDwtSUo7IkFx+9Je14jkIpVXPDU5WL+BLkQmDdny?=
 =?us-ascii?Q?PCQaJE4rbOaaJO4nZDSDphDwn0nnGar4/rbDvAk8/Jj2EHoU9ka9E9tsC1v7?=
 =?us-ascii?Q?tSYhjCfHPu0o60Iok8l7jUWi7NIStqrUJ2R3Jb5LQVYwQO3g9ngg0m7rP3Fu?=
 =?us-ascii?Q?11QFRpi7iWMV26k5+5evJu1SeAXcFs7R1j39XOy9SvF5l1cR2624fD+Nv8FQ?=
 =?us-ascii?Q?zCdnl2zfPI7FmsYhzBF/ZCANNsNWic+Nhc5WlaWDmPeOiw6rf0/uXyUXXOOM?=
 =?us-ascii?Q?NY6dVpyY5FeZ5NF0qTQt8qFo6TqIC3F+LkUb6C9/oarteNJcOce+k4YxobtO?=
 =?us-ascii?Q?NqwaAp4EGWHEEc5ib2dSsEWVcr04e1X/F+sUDkM+Hc4D55evXGQA48rhnG8W?=
 =?us-ascii?Q?SdJ3bFIgcI+N4u6gXWE1HubPDz/O69IarMxn2ORiGF2iaVl67SLRmEmTG3s1?=
 =?us-ascii?Q?OnpuR5zR7X6oklmba5O3CX5IGpTTjGMpMDwUyBULz4pB9IK9Jdo+Be7rLFE3?=
 =?us-ascii?Q?SKLFI5eidBClWmdCGUruHNBrmCnx6jUReYczKnZVnpmS5yR0v55hEmv9r80k?=
 =?us-ascii?Q?P7JbnvzrwvVieitMS61zyJuYqhUdTiT8X5RGh903CCRGQG9zkesi92oP3Bh7?=
 =?us-ascii?Q?7MatCB4p//vHriBO+K9FzlQEi29k5uZqt4mD/YW6IzAXfL+WmdR5UV4x92E/?=
 =?us-ascii?Q?vNktrWC8w3ePqy86NT8PUyDeSuwNaKLqOZ59YetLOy3Z/ShNpX8DEgmCSm4C?=
 =?us-ascii?Q?u7rhpk31mNS5HuGcg4FY2IXHFzw1RZzJtQRDlV+dqSK29r69VR4AW3sdnAL4?=
 =?us-ascii?Q?SudemreSYpunde1k51XxcTt3ewaXJOLX17ZT1Gq+OAS8MB1g3EU9vIxhWa5d?=
 =?us-ascii?Q?uQle4MuQiuYJjiIz1ks19eJLIHnCQfHlx5mxQ40m51sYUeuahZCLIhXxoj7R?=
 =?us-ascii?Q?RwK8IdWd5GaDw9jC59h+mN4sRqCwD3WSGfguEv/50AjoNw0tuAH2UyAfV8KV?=
 =?us-ascii?Q?tmAG8NZwuBJQeaWuv7aA/oJgqDBD+s15cAEcKx1tcCNr5//ns/A/tDC5/Uul?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed19f85-ddf6-4833-d7ec-08dd35f0e602
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 05:44:52.5402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jq2X4rUqWAlKKwi44/awUX58ydVs/0p9K+jGnpuAXaJDVsQcDHzcT+cGKZgaPfCXipe/v9J052PHEqlyKtNgFvs0Bqjag5V0HjHtB3prjow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8794
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:52 +0100
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

Change the order to connect gmiitorgmii before PHY creation.
The gmiitorgmii create additional in DTS configured PHY during
it's configuration. This ensures, that converter sits between the
MAC and the external phy
MAC <==> GMII2RGMII <==> RGMII_PHY.

Fixes: commit a744a284e354 ("net: phy: Add support for ethernet-phy-id with gpio reset")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---

 drivers/net/phy/phy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 716a1d46111..740533adeca 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -939,14 +939,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 		phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
 #endif
 
-#ifdef CONFIG_PHY_ETHERNET_ID
+#ifdef CONFIG_PHY_XILINX_GMII2RGMII
 	if (!phydev)
-		phydev = phy_connect_phy_id(bus, dev, addr);
+		phydev = phy_connect_gmii2rgmii(bus, dev);
 #endif
 
-#ifdef CONFIG_PHY_XILINX_GMII2RGMII
+#ifdef CONFIG_PHY_ETHERNET_ID
 	if (!phydev)
-		phydev = phy_connect_gmii2rgmii(bus, dev);
+		phydev = phy_connect_phy_id(bus, dev, addr);
 #endif
 
 	if (!phydev)
-- 
2.39.5

