Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A50CC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 04:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E3C8880D5;
	Thu, 28 Mar 2024 05:06:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KsWAwBss";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB8358806C; Thu, 28 Mar 2024 05:06:22 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0789E88035
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:06:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGVZhqCThNPxYUuqL9e/JUrWrucgcBnnO+Htknh9o3oewDlfALwn/rn8rmYmTPNmZRzsRxDgVUUJr9nbwCSbU/WlNp30DgOgvkHaQpFykgIi2Sm0prAeeZ1OlxvtNP0LQ+O0/h9ME2ZtY3RG3qcQwXwAd9Irulg52gH1WEpII6bm3dhjzcRkAXA7j/ii29NWj17R7zWBO1Ndyk18u/GtUnKhkPmnPfxo/9TCU1mlLO6K2A0tjoqxzUfrEUVmndS+7AlWlthJZgMwc+Y9XffQpz7HtZV86WMhouxqKXFSH3cV6IDXZIQhFHnwDNOxQG/jm7zX9w3rp/Q4zFEJAjklgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=Y0G0jHfJNuhQ3nMm3aE+8J+4ttOG3w+VMTwzCk60P/xps42DFTuxdxQ5j1y+GougwyEX3HlHLgHwvYZLMc2zoR32ZZazz/msfHJPBUn0Q14IoMnUPghGddbLplAwsnbJqoxkwiWDhrmUUej5N2w4hBbjYn9+vtM873muorZ/mZ1QSbekeIHFzVjoYznnR+gYbMg9jL0JaXvd/xepSOoP1CwcafewKfg2sdphbmzF1u2svtC/VyopVTXCyxMlZDQJkkxH0s/f0gwbUAbLqfdTuQ9bMcNaQoIGCxYGyVEky4yK+MGQQhEXj/unt/wYH5esKW7H5jPZ+QH0g5jK11ddog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2apRpJ7rgh6shHzqqLbCaAC+wmcq2NUoYjF1/VDY0b8=;
 b=KsWAwBssKHt5HNAcy/YRAtAv+MgXCdvefTU0+63YzezRHFGvh38O9rZM4m5pK4tV95fhflFIGxeiPKBSPMXHHnDwsi6u9rBY1DTNP1o7P5ASaBNEE44C0xQ0s+1MNwNbm06v8ZxoUOS9tFvEG5GtUGzNFBzdSqkosWhXagdH0NQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9488.eurprd04.prod.outlook.com (2603:10a6:102:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:06:19 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 04:06:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 13:05:48 +0800
Subject: [PATCH v4 4/5] clk: imx93: fix anatop base
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-v4-4-338d15a65c36@nxp.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
To: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf7c03e-7359-4f7a-1db3-08dc4edc6c36
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgtcpCy/oNoXa/2FkrCqHLl1j8aQ4MpOmNWC4MHVg48cheW+8PgvcM4G5ytn9m3cLTsJrfFD3AJuXoNkXW4FueZbxug2CHf4+BO37pPYL4EBpIU3nYJN1sD7RX7IqlyQGZj3j3/d0PiFjStYlQ9CwEggMjDy6AlufWCRNG1VEsZy+B8o6agTwJflzwZTf6sCe3X1C8e0Z/b+Ya4okU1e4J+75xpI/36LLPbodatUB7HM+JfU3nd/ABmxP1sbGZyHeume6GYRD37+ImTqGqMH1QTIp0ek/kKGlqksw4My8t0DR1IBMx2Wl3+hEh2KWy/yFtPr9OrJwTqVviTCdafcqbDWyvGAMF+yWCEHs/19+WwjUbtuRugTRirCpduEJGghHb3GWhXeAS4rZmYl9Fj6x3yMQXNPk7jodHxtJ2gLVm3vj4KujO32T/SKxlwcCLyPWc0/GqKipqMI7BzQk1peBQZ2W7ivpsW3yoLq2VEMmjEErAXkfePZsqCoazbrgMF/S8RDZS+P04U+fObtkJeClBThege5fI2waHFrp46sY6lHDDMye3MDP5u17nSW98FqEgSft8LPffySTAvZSKYOVkHzFz7Riy2WQ7aSbKvrZm6X2q2bZzh+SoXrhkuEDL2rLfSzHofwRGxP4vRuHBPRYW2Q5fUU0YtIa9WXbmEkgfKE1rslF03mGbjJVk7L1TMjQAaMg2adVx0jZOMggWo5gQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1pOVnlkNjBpZ1YzRDBJU29JUzNXZ1lSZHRBMDA5QklCS3NpMm0wZ3UrTVV5?=
 =?utf-8?B?cW8raW8zNFo5QW1PbjhISVVjcHJKVUw3QTJTUGJaQkc3NUR0clhyTCsrY2ts?=
 =?utf-8?B?NWVoR3pNMlRoZ0dwOVh5SmJWS0xyazhxTnVJREFrYmxqaDFlUmoxSnRvQy9n?=
 =?utf-8?B?TnV1dEtxVDVLVTZuNEcrbVZaeWdGdWJhSHZ3SHdPNGdNckJBRnVUZjJKQlJD?=
 =?utf-8?B?ajZrVVp5VWlYb24zRENSTEVHeHA4dkIvT1pYcmoycmZhUUh3OE0zc2Y0YXl2?=
 =?utf-8?B?Yko5WkZFUUNZTmJIdHEyU0YybVowemxiZ2JMMUkyRVNBclVQTGpwKzByWCtz?=
 =?utf-8?B?c2g0VWJJSThZaFN2dDRCRFd4RkFONEc3RUEzYXdkUzNxeE1DYVBTRFRwdDdz?=
 =?utf-8?B?OHJGZTNxeDR1cXEveTBSMmo2YVJWWEZBbzRoUitDVmtyM3VCVkY5dWVGU2Jw?=
 =?utf-8?B?K0RocTdicWh3VG1YWG1LdGN6ZXRJemFWbWdVOHFydndiN2pxWktkRzcreXdi?=
 =?utf-8?B?N1VoTVhNT2tzRS9kazFLM3pZZ0Q4emJNcVNXR0ViY29pS1BpdDRmWnh5SUxJ?=
 =?utf-8?B?SVBuOHdWYVhNa3MxZGd2L3UyN3F5WHUzREFMODdBa25MazhSdGZvZ21GdjIz?=
 =?utf-8?B?WUo0bzNUQ2tBbnlEZGF1Sjk1M2RDT2loRSsxNEJEeHVDTUpKcEVwUU04Tmw4?=
 =?utf-8?B?NE81YnEvNnIxWXNURDR5Nm4xTDR1Q3VkNG5xMWQ0WDdBNnZOTlRWVjkwSWJC?=
 =?utf-8?B?WlAwZU83Zy9KckF2enlwNlhtTURjZS9tYmNiQkpWNGgxemxlUzdlSnd4UmVK?=
 =?utf-8?B?U2ROd0NvS0o5NXRiL2tiVjJNcThYbkt0cXJkZGZ0RkZaa2FIVXorYW82SWhE?=
 =?utf-8?B?T2RLcXN1Z045bk1RdjF0ajNFZHB3MDZoT0duRW5zTHRXeVBBMzVjYjY4Q1FM?=
 =?utf-8?B?bFk0dWZTb3VSeGQ2ZjRDRThmSTBhQWc0SmE5ZllaSXl0YjZINS9qWnRPMzZD?=
 =?utf-8?B?cGs2aEczUXN4ZDlSYmh4Um1Gbi9pR3pCVnRVbGVzaWp0QkVFWHRCbWNNa2hk?=
 =?utf-8?B?c056UVppZWNiTFdGT25SODMxU0l2RHViQ0hTWUtMQmVtOFc1Qm84UDh5V0xK?=
 =?utf-8?B?NEpnbjAxVE1ZNnpSRUQ0d0k1MDF1VTNFcGFuZElnWXBTeW9yNERmVzhqMzAx?=
 =?utf-8?B?WFVHaFRaM3Z3ZjQ0VTV3bWorTjZrYm9sRFNCb29maE1yekRmSjBjUEpIUGY5?=
 =?utf-8?B?QjdLYWx0RjZVaStJZWpiL2RvWWp2cWtGRFp4K3QrMlVpd0pRMHhmZTYrUjJr?=
 =?utf-8?B?bmgxd2lFczNsK1prMGtubjl1a29nZUlWaSt4NHJJS0JDeitabHB3SUtFS2pL?=
 =?utf-8?B?clo1S2U3cmd0aTFjb284UHNmbFpIb3U1MU1RcmYybitIblpJRlM2N2xxU2h1?=
 =?utf-8?B?VmlqN0EzbDh6aHVSbWxtQUtKSjk2YnIxOTRsR0EvdkYwOWZ0a2xkN0EwS2Yz?=
 =?utf-8?B?RTVKVlU5cUtmL2FuZWFYcVhOVC94STNQYTZYR1RYQkhsVy9PbGhCV0E5YytP?=
 =?utf-8?B?TTUxNlZKMXJOaS9QWS8xNXZNK2NDeTYvVXF1MU9MRVZFMk5mSjJGdVVwYWYw?=
 =?utf-8?B?UC9ueEc1bGV1MWc0d3ZHQ29tNnpUMWNLYVd2NUtYQmJLWEVsbkFMZ1UvcVFP?=
 =?utf-8?B?RmVmTm5ISCtLYXBKRkxqaktjOUNtMUQzLzVCVE8rY0IvVjhyTXhMaU55WFlZ?=
 =?utf-8?B?cTIveitYbDE4c1hxQk9zaHQvbUJCT2QvOW0xdGFFUmJSRGNWK0tQK0N3bGEv?=
 =?utf-8?B?RWZsdVMxYUVmTWtWQ2ZkWXYxNXVvMjQ4T0JvdGp2Z0V2TDNBY3RHMkRuZ3F1?=
 =?utf-8?B?YTRlR0N3ZkdzT1lQUmtBYkoxWnU4aS9JWmNmbmFSY25yTVBHaTk3VDVLQ0gz?=
 =?utf-8?B?ME5USVpxeDJRbEowZktYZ1NkazZkVjEwMGFsSHp5dVdVMG1uUGQwUUVkcW1o?=
 =?utf-8?B?N0lEZGhRNlc4NVRJaFNISXF4VGZVVEhmZ3g1RW9GMVJWVE02b2hzeThKTFd6?=
 =?utf-8?B?SWIvYkJSOTBMUHB6dmN3eDVkeXN4VWxobkFFWDFOUzZIem01T2R4cVliRzBC?=
 =?utf-8?Q?ousz5gQV0MZHo8NTBhNjBLxxz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf7c03e-7359-4f7a-1db3-08dc4edc6c36
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:06:19.5903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLNaRJWgCS5tsdrwssmhfhr1Oj9wqSISljHFsAzrytYNyFdnNUHDoBDC/SVRbMJdI8L6T8ehWcZRAilFVxIPfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9488
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

The PLL clk needs use anatop base, otherwise wrong PLL address will
be used.

Fixes: 9c153e46661b ("clk: imx: add i.MX93 CCF driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index ce10d795316..f0cb797d975 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -289,7 +289,7 @@ static int imx93_clk_probe(struct udevice *dev)
 	clk_dm(IMX93_CLK_SYS_PLL_PFD2_DIV2,
 	       imx_clk_fixed_factor("sys_pll_pfd2_div2", "sys_pll_pfd2", 1, 2));
 
-	base = (void *)ANATOP_BASE_ADDR;
+	anatop_base = (void *)ANATOP_BASE_ADDR;
 
 	clk_dm(IMX93_CLK_ARM_PLL,
 	       imx_clk_fracn_gppll_integer("arm_pll", "clock-osc-24m",

-- 
2.35.3

