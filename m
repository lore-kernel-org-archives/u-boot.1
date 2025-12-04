Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1786D1CDCD
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 04:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE38E83FAF;
	Thu,  4 Dec 2025 05:15:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="zlxpB/b0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8237584056; Thu,  4 Dec 2025 05:15:13 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35EF83D9C
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 05:15:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XRMuzOz2Q42+2G+5JQR3MYth2oQC5SK/AJQC4Yly9XBKCq6urKgynl1r21qDKoDqTlJup0upaRrdTHfbGV52j0p6dzoOpcyLfb1aDSQFXCdbhtKPnSO/0BJwKw+dNdHTPy4gYk0+aaLhodMFxJVR5U5W4duoWQF9gjOjLDw5aQyfcsBVQXi20iL8s34XERm9VqrirIN6x1c0XpCSybe/NZ+t4KjveArdmTpVWMxrmqpv2/LoVrr14xzL3D9or20Btv3svncQSEZIY344/Zdueb6E7EYqLdD9t5auWW4Yo3Qx1PLRoVndAHAI2VNo/hr6AMtCjKMP6s3TNJQCNEDYpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bTzNX6l24YmXNHkt03JhltYk5IAdKW10/X9J9my8hs=;
 b=ki+ZGBaS1nH6rz6MXoOWwAI/qRREBrH6djTb8P/TKIhNDqQ3/S4sVsFhbxXMecHQUnwXBDjf7K9DpOfFR/8eghHoBGk2c+nCuuoEaCD+n0mt2nCy1GDl+WNTZLMc3r/2wux3N9WtkNJLG5mJKQJpp8pa/wwfCSy0+r2CuQYK/a09JPu0mXRoFBvAXZY4MDzL6NJvPPTgGD9kdAeeQptvpmun/AChIntR4h6Ef1WQHknyuVkfNTYiI5FPk84JLunoDflroE51YGjr7WSfqWVZkq0phs/39uTidCnMQRmAx53v2COTxzYg3IrWaDtWf3Sx/4LgUk5VpB7bzW9VSsv5yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bTzNX6l24YmXNHkt03JhltYk5IAdKW10/X9J9my8hs=;
 b=zlxpB/b0HSlGS0pkm41ms9EEjhdkLLJJouaFEONSMsvQearTJC2r0FNsvL+hoThm62qNWmsSGob6q/6Ewf1ULCn0dwXZ6cvr19Hkx7lIO8E4uZ+S5SZQot6N3smhrL/crGhk0Te09P4vZBHReFp7h8DYnfzX0EBcAIfrdygKvzyMVldik2e05E85JKPgdI/4YQRcNid+7Hd9rrkyqjb980GmoHEOYqK0FyfsJ7S+jjrN6Fj/zGPNt7t15Q3CloTBC8yeKAlKtFOdKh1XQarSMuQDqhh3VSNBcG5nF/4wER47/XBdlY7ThbhgRW4gDYu/c0aif0qDlDBC39SZxELTLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by VI0PR08MB11134.eurprd08.prod.outlook.com (2603:10a6:800:250::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 4 Dec
 2025 04:15:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 04:15:09 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Yao Zi <ziyao@disroot.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Greg Malysa <malysagreg@gmail.com>, Markus Gothe <markus.gothe@genexis.eu>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH 18/19] airoha: add mdio child node to switch node
Date: Thu,  4 Dec 2025 07:14:32 +0300
Message-ID: <20251204041433.3459826-19-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251204041433.3459826-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|VI0PR08MB11134:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fe7fa4-9080-4477-9b15-08de32ebb638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pK9EHDoEm9nkmb+NJClHtZZKjTFX81z+A3RCi0L5nLbK637lJj9Nu6T0n6HR?=
 =?us-ascii?Q?hyd5ElMm13UAaX8B360wtCOgP/d/urxHjC367AIGo/ch7jXcc/G+EiaJ3kx6?=
 =?us-ascii?Q?BZ083V4shFpFM5kLOUz5pFCLe4kOmZ4Ug4OpCLAJFG8U7A7ZR4rDkwEs2DpZ?=
 =?us-ascii?Q?EvpsKHCJVNLfuUEUopWy3eNOD2RYttl+DaZcJq7ak0EZOkclBP51hMAPCKGk?=
 =?us-ascii?Q?mwbdqfHKkOsOOgXaYWJM3xJQ30WAFYVCJmqvjujLitdAGSJisLgYmAAqNLpT?=
 =?us-ascii?Q?8cudTT7FJyrSRmAfAeFWcsnw65FSTahjWpzZGug74YdIefBO6qEVAm5oeMm8?=
 =?us-ascii?Q?1U2qQCYU92leewvNVwIg8EvztAcjpbB8caLPW0D6tnIS7XWToDlvsHud4LWU?=
 =?us-ascii?Q?t/kg1yZFlLuVg4rLZqx3rrhclE4uYE8ESZLck3qb++IOXtzLVACLSWd8UdsL?=
 =?us-ascii?Q?JqE++RJho7DTJIuhK+xCofJ612YTtjUKg9nt2nAHL8ghRL3fLRvrB3UQmaZ2?=
 =?us-ascii?Q?tTq2BuXMjqevZBm2aSgv1fzXGkntmjJH/kc2ZN0Pc1JTgRhKSD2fQ3TFAkXK?=
 =?us-ascii?Q?d0QOScU4Iqy7CQVIb+Z+y6HID7GiqPbTI5aD26vnKRRTZtohF1dvQGJwgsYr?=
 =?us-ascii?Q?nUe+Eny0EHH2p/PpBrsL/oC3YrlUYrrR3FcnXz013Q3rcvjG/iF7ChDcBPIK?=
 =?us-ascii?Q?GlAqdSOUAFlUzttRj2T4h1cmPM6o7apAJC5lToL7AjR2UJYoVScudBoXsjqp?=
 =?us-ascii?Q?tRznzuThEE6kkjMrEaj6TkKuE5+vQrFBFx4yJ4IEoyW53X3HThvzqEjz4M4t?=
 =?us-ascii?Q?zLmdD+1pFLnZ2jFQ3pFKMhf7v0glk13mSnT8T1DgyNdkYrUb0Ji1bRf34zu6?=
 =?us-ascii?Q?jfxmx4hAC4Z/LCJD+HPpsmr/IBRxixYe2G3nWYSamE/AGXvuGQm0L+n8ogxB?=
 =?us-ascii?Q?lCP2PyZ6R84NsI5NuCsAIPwCGaZOPzNERPRlVIGqgAS2ghDkNBmL/b/HKlPy?=
 =?us-ascii?Q?KhWNKMG0YYFRBPJb9q7rnnvvJfNLp9vilZTzPZIhmSPj5gwGbFpKhXyxxuvq?=
 =?us-ascii?Q?Mdlw3qsRCW1fye+473TX4LD+Ak1H5yJIxEj8xbwJLagXeaODU6cUwD1HWnG9?=
 =?us-ascii?Q?gsKBCzMAMmytf4bnpEjRatXBtij4/iW7h2gMD1xER/Q/cCF+L1nwhbE6Xr6f?=
 =?us-ascii?Q?KmSnvRrunJ+DHlAlN6ioPValDjHD53ENV8Ab56SUi5eupzyeOyQGCzFFcUap?=
 =?us-ascii?Q?auZNF8S4GK+UsTY4tF3qU3LQA5aS77ffDEzWec6yPmLSBIr0P1LrZPZXiFzm?=
 =?us-ascii?Q?2BvqHOaBW8nFaLPE8Y7HEi1wbe7f1ad0mhyiHOuZfOSvE2kB5/S6MZijdwg6?=
 =?us-ascii?Q?wd3D330dq/ykIXV7NKhP2VMQX2M2nX7aMvMKVbkpnPHbzO3Phy1e15bdi8kp?=
 =?us-ascii?Q?2fTK0SmrpQArqid6AAxX9YHnACGKht+7EBBzTO5+xDmW7tJXVhAFNOYvrZU6?=
 =?us-ascii?Q?X19Brt3MecsYbSWWKfon3FITJdwJg9tQGta/u5fZ75Z2PbuiWJ9b4kAdtw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l/7qMnipLdH5o9DSn7S83EFPkVfAURSQTvFEfDUs541rndmFdAJSzVV36fcr?=
 =?us-ascii?Q?FD8Kc3xIEBINV0OvV2QXK+71S4mGMqag9NoOcknSFszBii8h7rn3soOvZ1ym?=
 =?us-ascii?Q?6X0yvLOdpgVSsYucRVCSc1PZuZ53VViz2dnE421PYclQGzwKkJb/pnTqzHFX?=
 =?us-ascii?Q?0o1gCpRiH+kBe/AQxnmfbq9/PN2p1qMXGcVNDlq/0CdQuirnNGw7xMsuAEv6?=
 =?us-ascii?Q?6urxQ8o6T8xJKu2KG88uG/Wsa5tRC9bnwtlgqfxrNEJk7g6DVcQVc6Ac/Jaj?=
 =?us-ascii?Q?u+hLx5/GvyoBXFx5o5WWCIuV9reo3AAN0NA31ZM3uXmWpfTb91pTxCb0jqf7?=
 =?us-ascii?Q?msEw99GM7shB8aJb7mavMIOXjvj0/EhW5Al8OevK2WAYFix5FlqTOXQBMe2f?=
 =?us-ascii?Q?WdxWs8XKO4oKIk9PDOgOXBxGPvLy7/HQWn7oYbY7N6lSdDmtkCEkBibIGi+I?=
 =?us-ascii?Q?xxDpUwfBcjdnf2XPCTXKL3STVlTMG5kApy4lvzQ1RjnOGqBR2kFJUhzcQOR8?=
 =?us-ascii?Q?8p3EskII+sB2FXjiN4MHij3EgZS3GHh0MC1aq4a7F+8ZKYmu7Go8xK9eRzjS?=
 =?us-ascii?Q?Dl30w9IBXFlkzsXJNiqHkXTMkDHhDlMIKxWxPvHU91+KSjhvuIbqnUgUiGS2?=
 =?us-ascii?Q?wffrILsxX8hw9Ryv5YDfefAgzykibPJotola21O07mubxkm1DIgq1tX4k9Ee?=
 =?us-ascii?Q?El86rDMjF3g8ZGIEYMWQwN8DnN2iHhuYUk4TgMMw/kwL3tBgScSR3jwdMKKY?=
 =?us-ascii?Q?Q05aQ/sQVLXFqv+aqS2s6pDAd3kawXCZV1M7WzhnjlMtVcgCNlX1e1gGkXF+?=
 =?us-ascii?Q?tAZ7+pMkoBWnGCrOSuznLKN3m6FtPqAsrKDuZLiZLboJMSlyyCuAKD9UXLtz?=
 =?us-ascii?Q?h0VxAspwo1kN7DR+Wc9Hvz6gFt86zx9bl3cwnJW06ikI/s+0TAg92HtubKID?=
 =?us-ascii?Q?G7VogZZVGhhEUV69v/lDhLG63mKpyzyvj2yr8QuMewGBCYV8YkhDVN8W54jD?=
 =?us-ascii?Q?bRaKpdfLFShDpzGxJTFGt20gV5A7F3oTzQZysqFseFKW2P296m558eL12COZ?=
 =?us-ascii?Q?s9KDfNqIG4gCSNMJdqEYWyLZilZV9nwP4jhdZcaKacBR4+NpKU7JXzErCoRc?=
 =?us-ascii?Q?m9hPoTcd0ZTeNgM+c5NITVzH1Tc9kfpOs8uYyM66RQ/RFsp0RP1Iy3oF2z1p?=
 =?us-ascii?Q?BBolu0+xrZkN2sMx+o3Tf5LTBk54fYlOG3ewjpMXZSezFkFTWiicMFZZgv+Y?=
 =?us-ascii?Q?8NUyHSI3YyV9yxFQDuNo1S+AJk8nwlP522tY2SM5ZTbedz+2OakAx6AKWInc?=
 =?us-ascii?Q?CN7bkdD0xp6sGhd1VhdksTnaO6SWmJpcemQDRVumr74FWqoloe9ez4JGpn7R?=
 =?us-ascii?Q?kVqvPCuHIGc7S+ZFurmHtAvICKpCSL3bTmVZw1yMFnvYWk8U2nhA5BQmiQQn?=
 =?us-ascii?Q?wMPzLREDSa1xcJSoDXIsT1ZoxjufhCLJmRPaezhi1SjnRYP8JYZ4rPx8/BzW?=
 =?us-ascii?Q?tiqNayAAN837WXU+TU0SrsG7mW3y8eyPEqb/tFK40OeqILWQF3SBSGp1yPm4?=
 =?us-ascii?Q?XI299laOsNbxbvtAfRSpXE43AQF/d04q1VqaRbxcCP+7MzUM5XFNV8jYqjdU?=
 =?us-ascii?Q?1dUG3hEkAW3fpuCHMEfPma8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fe7fa4-9080-4477-9b15-08de32ebb638
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 04:15:09.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SechXpDclgikO9TaPvzTGMwVTVwiRzpou3oJUzZG+Y+9qNpKGaKG5dAaQKrhRbs1+FEzpMpK+PKYbULHNOND9kDliCNtod6sHny8p/FUkwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11134
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

Add mdio child node to switch node to reflect upstream DTS.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/arm/dts/an7581-u-boot.dtsi | 5 +++++
 arch/arm/dts/en7523-u-boot.dtsi | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/dts/an7581-u-boot.dtsi b/arch/arm/dts/an7581-u-boot.dtsi
index 9ee0f808660..4548076b96a 100644
--- a/arch/arm/dts/an7581-u-boot.dtsi
+++ b/arch/arm/dts/an7581-u-boot.dtsi
@@ -128,6 +128,11 @@
 		switch: switch@1fb58000 {
 			compatible = "airoha,en7581-switch";
 			reg = <0 0x1fb58000 0 0x8000>;
+
+			mdio: mdio {
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		snfi: spi@1fa10000 {
diff --git a/arch/arm/dts/en7523-u-boot.dtsi b/arch/arm/dts/en7523-u-boot.dtsi
index a403e684adc..62d1a724678 100644
--- a/arch/arm/dts/en7523-u-boot.dtsi
+++ b/arch/arm/dts/en7523-u-boot.dtsi
@@ -55,6 +55,11 @@
 	switch: switch@1fb58000 {
 		compatible = "airoha,en7523-switch";
 		reg = <0x1fb58000 0x8000>;
+
+		mdio: mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
 	};
 
 	snfi: spi@1fa10000 {
-- 
2.51.0

