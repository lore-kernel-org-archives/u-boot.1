Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D9FC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 08:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D6EF88DF4;
	Wed, 24 Apr 2024 10:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RDJ8iqO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE0E088DE6; Wed, 24 Apr 2024 10:12:30 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FB588DF2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 10:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gd9HcEboGOMz4wXzAzO3KWd58Z+ivv9zoD79Emhv+MbcsLUxn5sYGUZkpS4rlM3XCD6pK1lS+5qpX3mKuksGMVPiLdK9YOpMyV8MAwWEPfaXa2X1hNxsxPMT1hlmD9WiPyUK+DJ9zze+mVEQKZ0I0MrucekXWGwaNRxJ+JoRnNgSyPZ60Bj8rE4j3s8Nys8y5KPrNNFry5yttnmlTow7QKRK+EtBxxQB60/zVnUbU3c6drkjZeP7mfyOZokQXs49vafa/EKh0qin3Vb95vmA8AdkuqoAZsHpGc3SfSQGC8l8IDjErWCTc9A0vZYymcb65wELBpDhxtwVcNllVvUbiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WeB57gVMIwj9ZEFA3/3gV6nKjnwUm707wni0SaFvnr4=;
 b=FEtfLCbyb6McRziz/xDISy7NyjBd5Ma49eroKuno2WzTz+qwHjA61YvsV+RgHqjMw1K/UKcyV9LjGxF8J/sfsQcVlGSQMdFRg07LVCjXDB2r4694sfvo7VHFEyIdZtXehJ4NxrxUtXoyp4YnfwVswXiC9EB71NOF9V08gOmA0w/v6LoKZK1FyrcKe5ZcQIbMbhZoptaN4ejBA6wNzLMkJgPSL/ymfxYmDZ/Zh9hOYYOy5FONhkn11FkcNvzF7GHXmxTXUvGG+fu4SRHmsyQV0GMF2F84jz+OuvTKDj2j8eJ2NhC+CcQ+fXLHkEYRuU8+gEarHwi9RMzMHm6NeTsaOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeB57gVMIwj9ZEFA3/3gV6nKjnwUm707wni0SaFvnr4=;
 b=RDJ8iqO6lEypo8eb1z1IkK3DSgYs6Wg82u1p8armGgMe+bfddC25Tbp+de1CecO0KP6APtPDWWx37ptxSXlrNzp4Z+T5S9Vz6n2kfp5Ee9R/Jdppn0tBhma9e6FSNpWBDUX1v/r4JG7U/5WRIvK1KkETYTvxSN7kVdudrt3Kf8s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9466.eurprd04.prod.outlook.com (2603:10a6:10:35a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:12:24 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 08:12:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de,
	Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	u-boot@lists.denx.de,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] dt-bindings: imx93: sync clock header
Date: Wed, 24 Apr 2024 17:12:21 +0800
Message-Id: <20240424091222.10843-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240424091222.10843-1-peng.fan@oss.nxp.com>
References: <20240424091222.10843-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::29)
 To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU0PR04MB9466:EE_
X-MS-Office365-Filtering-Correlation-Id: d277de6a-4a9d-4c49-0aaf-08dc64364573
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o1wiLXm3t3LerUjH4weWRkUqm3BMJB/wofDlE++QqB+G0X2INQmcNGmwBfio?=
 =?us-ascii?Q?zZmuzFytpvnQ7AyR3P3T4dOALALuw2OH8DyZgJldlSQWMVjnQVqkvCxwREzK?=
 =?us-ascii?Q?5g8c8eZpzV8FEZkEN4W3PYzUlY+Xs3gQDbegTOO0ucfaa9oxbP+7TZ+b5ywh?=
 =?us-ascii?Q?6gGOcV7qHBT0xVEpyiRo1qz6THfaE/cGRk57JiRkkRN077FPEnXzk9QcHLVi?=
 =?us-ascii?Q?2LcRTGbnlLhQflbARH0a1bCi6UykKO3KtlB8ZUktTZoTbrbO1Z2flNOPrDBm?=
 =?us-ascii?Q?VnkMKMAXWKlsfUP6y+tmsTrzY6Xd+8B1QRnmeCmfy26V+Eghtt1cfwfz1/pR?=
 =?us-ascii?Q?Z0od7PROPwhjeP7IYPB07jLVTt92Fpz/lwfY9qqfD3BY+FFiXrMDhxXdENuR?=
 =?us-ascii?Q?yY5Kf9G8f6k0TcC4y+famoje2+tOKaUlV3NxHv850q5jU2qMJJMCraEpk17n?=
 =?us-ascii?Q?z9gT6ARc893cHTbUYyTbxhcd68DN8TPUrGV4Zg2717ji33+sm9T3jCPbDr8W?=
 =?us-ascii?Q?DGfI8WR1bnd3jjI7+fA6F3AbIYTELlHXbF23TAYS5pCMDXTwuEcseckU2rTN?=
 =?us-ascii?Q?NxtgFqCX0OzuxCO+N6gVElhevXaF9AzF/NGqncN9kUo0vz8EE0t71VRFQ/8k?=
 =?us-ascii?Q?JTDG9T9EGeIkL36LDW8LmlXdGcKznTl9Nq86hGXaSRCNPv+ITekA/IIsmnsL?=
 =?us-ascii?Q?95l1XorDgIWDsRv3nsATwCFpD/OLEPlNKGjCtq6HZv8Jtf7k4BEd9+FLbCnh?=
 =?us-ascii?Q?FOhLVpuyT+qgVwe0a93EjYeLhchbfTsUOs0CECuLjfnE+gxSqU8dfOuJWRcB?=
 =?us-ascii?Q?5MiOO2+gLtrU2XUFGiHlm8EQMA51WIkH6CZCjD+krRMW0KPi2qwn47vqxDJv?=
 =?us-ascii?Q?8VBMSy7BWGLbImbr01+iCCJ9tzdJoB7dBVfU4zt1X4dGNSD4VKvl/AwJrZZE?=
 =?us-ascii?Q?sz3LBWmc4ol3A+cC5eDoXvMLYO09aeZnR3HNqMHrMQUNhTZBM1QNJkP2DNc9?=
 =?us-ascii?Q?LfwiVg8wnF8RR21RrgMgFH5pWXyWDvjbnfgHIQyE/GcDDVH/OtAnGnWnN6Tm?=
 =?us-ascii?Q?9ePqhcrbViqHQozUwKVIlKJn22SAgD/vhaOszLAjTCa1pvJEmsL2uy6KUA5w?=
 =?us-ascii?Q?qV5LrBfnzarH/7jrx549z6F1qhe3XvfSBDliPYwmFTklmLDhpcOANZlYR3oa?=
 =?us-ascii?Q?BFLFH8FkMIKXT/R8Gr4bJmWA+ZMNupuhmLLUtrsTgX60SyNipHdcgF3j5M/q?=
 =?us-ascii?Q?0ggow1p+wOufQrMtgvRXfdb9l/+gWw0LeUyV1VT/KSzY1DtGnw6DuIzX82hY?=
 =?us-ascii?Q?krp8S6sx4qy9cz3E1cjafRr4z5YT3ez0Fl0QxEhNwD6/Wg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GSIYrXfTgd5UPjNvMobdZgSsPLGBMK6D3+ua0+JS8/4BvcSsI34sHeyAXe4L?=
 =?us-ascii?Q?MowOn3/nJPeA0R1iPcdDRHDK/QiH+9QftnQueaQz3O0lqB0ywB4Hg+1Yndty?=
 =?us-ascii?Q?6K26pIKsJF1ZFBS8KB9qLGrmwJvyKJH9luJp+EedbNQqoDUk3VBuTubxsfFt?=
 =?us-ascii?Q?VVg4Amjic+Nt72HPbDtfl0UkxYTsrBSkj0sPSZBFX+isZvMdwtrnn2Wmq8te?=
 =?us-ascii?Q?jX+ufMZL83HD3BOPM5Fgu2It/qWkP+ObIeNcQYa20NTBipf6RZZJJWz6zjf5?=
 =?us-ascii?Q?k8WJ3AXGABqc7eQ5BTStCibzmt3kT6OR4MxGzOZUObGOPycUzfFEPKIL8yQ/?=
 =?us-ascii?Q?I/cQoYcW2yqW6LJ8VmmW83vkBrEE35XHNLJqD/8BTT9bgGfK0EeyizeO7zQE?=
 =?us-ascii?Q?iLJUWZDv7qG5F3v7+aTtRjUSujBy7PeJJsJ71q8NmIoTb/F2DEpb8LHKC/m/?=
 =?us-ascii?Q?dkUdXPy6ZvziuBV2y5GIdcK22NKhB42EXgMKn0AbCd/PJQdq+Mfnb36VHYRb?=
 =?us-ascii?Q?H7vZgsNtN34p0SkOwSAcmBzBU2sJkutQMOWqBxNdybVBCcAklV5/1dF72J4d?=
 =?us-ascii?Q?ActvGLgeCwLYlLckAeC38jdUnYywLNKcVAF8NdB1y979yRqCAMOBixR+ntry?=
 =?us-ascii?Q?vcBZj5UlHAKsoO6co4nG7A7OYSyfTG4vBVwgxLQzYE7OKjPbmhPSNlsU3jkT?=
 =?us-ascii?Q?fE+8znLfF3gJ2kos1tIAVR/HZHoDerT8S1hTA8ur2PPY4aK8Pp2dpXBY5k36?=
 =?us-ascii?Q?eSXx/PXNJ+C8CrUUDMPK5qU8hFcO5H7OJ8S48cwW1qBVoI2qXWU+qLTmzOiy?=
 =?us-ascii?Q?xq3FomGO3AK3LFp4VRXzjt2KBnlVmCeI4eaZsZGqhEtsLLKTP7BP3mxJUwFJ?=
 =?us-ascii?Q?XgcfC9HFvAknQ/uz5DjzEg5R7qi7srR5sgMz/hlvbajbQ2pUyRvzWeXbuXFe?=
 =?us-ascii?Q?WuUl+1OCcZWWovI8fm4HHd7t5zRUbpqWBmkbNQ3U7AwcEBE6/OfemzrO/wNv?=
 =?us-ascii?Q?eKrXtBj6jOLMEjHwzMdZpfI634ykvTxgDUJEZvr2VaD+Fl3HI8DyYFGZYXPU?=
 =?us-ascii?Q?RsaVzBpFjPPUHUic7a7jmFcE1qNRtzFC4OiHIwR8g13bNVzSo5K5KUlumSNj?=
 =?us-ascii?Q?JNQndAWaIx8ojDQymJfYAeARDuitPxeH5HTmZnS+JPrx8H2PGy6SMkrbgkpM?=
 =?us-ascii?Q?OaBGxPUblN7eUK+EgXPxH4lWNz+afq4vxtoqLis94iihPLmiA25xBVD62KjF?=
 =?us-ascii?Q?arCQmtcYFW+4/GyXQ72iGZs98QogTfVCogtL1oj1rzcWbx5ENOZjCRcalP9D?=
 =?us-ascii?Q?kBNSiN9O+FFbhaW3CvE9N1G8g2GcM6KXuq7PKsnWYzXxOs6GnPNEaz1FsmBv?=
 =?us-ascii?Q?0FOQhio5sUxegEwFjOsDBlGGXBZXeZxSJEIysu7rjNh/z21kuyBxDyHvHcyI?=
 =?us-ascii?Q?u7ztsm6LRwwPvB4jxJupEgNwQwkxWl9Iuz9K3J+G9rGj9teNzygbYlKp2+ly?=
 =?us-ascii?Q?I6V0RyFm88bsiIVkyZK87r5ya33ea36zS6fVieqD7H2IACi4fUt3XvAK9RYW?=
 =?us-ascii?Q?stQJRm7+wTIAOIxHUq6K0st9ukci4OnDEEr5aJxW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d277de6a-4a9d-4c49-0aaf-08dc64364573
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:12:23.9874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cy47aVyljd8LztEULjg1BZRgRXDI42ZS3Lt9Cye3ISaYVqQaK1UomkFHfCmAdbun8r5vrYDw7AZMTRCF30Se0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9466
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

Sync clock header with kernel 6.8

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/dt-bindings/clock/imx93-clock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx93-clock.h b/include/dt-bindings/clock/imx93-clock.h
index 35a1f62053a..787c9e74dc9 100644
--- a/include/dt-bindings/clock/imx93-clock.h
+++ b/include/dt-bindings/clock/imx93-clock.h
@@ -203,6 +203,7 @@
 #define IMX93_CLK_ARM_PLL		198
 #define IMX93_CLK_A55_SEL		199
 #define IMX93_CLK_A55_CORE		200
-#define IMX93_CLK_END			201
+#define IMX93_CLK_PDM_IPG		201
+#define IMX93_CLK_END			202
 
 #endif
-- 
2.35.3

