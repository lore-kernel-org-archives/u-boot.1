Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7732BCFD316
	for <u-boot@archiver.kernel.org>; Fri, 11 Oct 2024 10:20:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF575892B1;
	Fri, 11 Oct 2024 12:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FoFZ+E3y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9D7892C8; Fri, 11 Oct 2024 12:20:15 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9F8A89155
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 12:20:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOpQ7HG6qHqVbStRQ6R0OjQfWVdtHSUnOEFudDuAX0EAffOR7uAnTY/yfLwpCI+99VVNEAeDhi2cLNypeTWbcmJmFBDFMu/lGtd5jqPkxJT9Yr9gDfbHx7IWSXbTwsKy56ZrMg1VFxvkDlD+UR7oXlu+/Tx6RUbAF6KwNFaH7hrQEtqarxLb0ak28vnSAR6QJqsowxY459NLdlWMDoKs3LdsW0s8Fzj7mBMlrzn70pGO2gSrmeJ2IuKWUu7KMt6263IBcWWMCWcrO5ob4lOh9OqnjNlednF/Rjtj5cQ9XY3Aq2+HLzjVIAS/I1X1JTzxLxgbvxdm1gN7vnIjNqn4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oheqeX3Jvoq8pb8aJfHauzOVnE4IClUSww+svR1g9hQ=;
 b=ImLEz/jVVHJX1GcF97aaOBZsX/soZboMhH9IPqgnRhOstc+ZnkOxkxUWoIhNVIa6lUnonUsGHsr4pNO3kw9Ts2E+HAU+OTUeLpelYIk8XOU6bn5WQIY1ELioxVwWIYVpe5o9FKtxgZ/HLr78IHur2jREGyyW+UIZBUTAN/0vqcVcTGppTCWH9DbpO3TnMgkpA0bAflCEsiKlA4yO2/xGl+GSjTescLZ4aCyHvldZwn98XABhBq30nsTQJbwinjxLSqIw2b0puQWsVNAGvz3UtxL60VsxHuZ5o8KlNkVHrAqD2mXZ9Ap6wi7dxOXep/EHewsIvljf2iDdrqxasZCHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oheqeX3Jvoq8pb8aJfHauzOVnE4IClUSww+svR1g9hQ=;
 b=FoFZ+E3yzq41pC+UVXNRUYBdEVF71KeRcLhXYEgNsf6iTMDC+8G0wey1vtC+rqWb9zK/pVy11DfHRa3nJ9tPfOyjN0tpDj6RTnHzxbLhKBSOqFLMjPKE1kV6QJNav8Kg/A70oCfaJfjPyfZt3QkDCJgI58SjX3NCLG6stZWA5ygAvhMsXsHJFas37foCS3m/2KOGaNkjFxQeajaPdEwK7njaWElT4JShHXDsgTBx2I8z9lXFOE7GkUyeecG3+wVoA7j2nBuLcJCSJhco9+g+p34br7AZ5MZ5J9AsAfBw5vkS54+GKtEL/lOSyZge0CcXfcyiuUZQQtAMBLyFp52goQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB9208.eurprd04.prod.outlook.com (2603:10a6:20b:44f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 10:20:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 10:20:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com,
	sbabic@denx.de,
	u-boot@lists.denx.de
Cc: uboot-imx@nxp.com,
	gilles.talis@nxp.com,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx8mp: Add i.MX8MP Dummy clk
Date: Fri, 11 Oct 2024 19:24:02 +0800
Message-Id: <20241011112402.3168-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cc7c4ba-0142-4175-d93c-08dce9de4a01
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HDWzyNY2ZC8WAPNddHpyKO32Itk6ATkcL/+UKhxlNb06A9UU9zblHYGmuAmq?=
 =?us-ascii?Q?ZC0PLttHIWXH73WDLthxZZue2oyuX/wvxNty3aBBh3Ijl76UdZAK8qzOjTg5?=
 =?us-ascii?Q?UrMMPm9kk4RhIiRu9sC53ZOyDgqws8X86fqFTyYv7vFfSegeYYMAVwnQ4cRB?=
 =?us-ascii?Q?Wsi0MeSi7rnAn1dvmXKy6sKVHR1l+7NsEpwIx9OBgjOC4pqhUTQpv1PEn4t5?=
 =?us-ascii?Q?bMcP3plGwqO/CtsxtGxSqsPvbGAl3OLue2ufIQMsrB1vENgvCyTqAbKTlbuJ?=
 =?us-ascii?Q?H51TA5IfSO/NaWv7NQRsSpgWkHOufO6IuHyL4vflWFfBvnBeAmfAW2G3B+up?=
 =?us-ascii?Q?yrtsS7d5+7mv4pI+gctzmmFyM30usE/ajZ6IL0o8r+nyR/mhmj8P02InVfc1?=
 =?us-ascii?Q?DrXo1bU8JuE3XD4YMBZReTqZNEvAfCJXXJBVQ32+OfhlaVUUCPHcNuM5N9vM?=
 =?us-ascii?Q?1LIsfoHpqGX3aI9WapqQV7A0B/fJxrGFTYFnRipZ/ZEmyOEmWDbI9mO2R3Xi?=
 =?us-ascii?Q?50uDOvk+pcEMygzpiA3aJhU1NXC+JnUA0zJe6med+uqwKWCrVyImG6fOZZuz?=
 =?us-ascii?Q?A7bELXTV9ujOp/W8xhxBqhFEYDLaOfkBPc2H/2VVnECmKkoyYWuQnbpy/lAS?=
 =?us-ascii?Q?253qDunuoJFNU5Is164efcKtF52HR4tdgTFlF6wbnK/p5xKFSkmpzzromjNk?=
 =?us-ascii?Q?sRwWMO4ebDXQaUDfQo8+PMlO2PXRczMn3x4gwPqPHBctbr3WTSlVztyzq2Xd?=
 =?us-ascii?Q?/D3Sh2mey+Ujo80o7uShPbzTmPZ2sIYno4d9YOXQqmD1GCE35azT0vJCCnZ2?=
 =?us-ascii?Q?UwpxZDkcieGpwgT+D7h2flmwLDHeB4/3JoqWwQLXVPKYhZf2OnY2FkMEF5Mf?=
 =?us-ascii?Q?7rldz+vfJQuNy6I3eSDuw0ANSgfu5gHYIuUSZJGVRQesx6qDHovjldRsD/hn?=
 =?us-ascii?Q?7rQJBidxhay2uDWfWTRTiUJzRIxWq4iYlXTwzuJRcmiAqdYJjObBbIR4/gLE?=
 =?us-ascii?Q?F9n5P3ZCjw3wjQUIppVsuCUEq6xfoYyE+olWnTCusc8C/VzCw/5VRo+pQwvN?=
 =?us-ascii?Q?apeevjXSEdatOtB6WAA9pxmg5x0ZoN8XJkp4ODWd5dTX0zlXy4WJzmQIjGKS?=
 =?us-ascii?Q?JVKdyriyzGL/7O0ySVityhcHWNmcTVnk/Dkg8lqf0/j/cYu1erEbmBhncBNW?=
 =?us-ascii?Q?gQD/aIMV/5YvUmnfLNZqDPmkme6lkJSlZLqGFKcmT+0f6Ae1Ve4Dn0MemvIi?=
 =?us-ascii?Q?WIy01BXdkQE6v4eVDGgf7pBz44OdoQJdB7JkMt6XQ6K0wc4AZLee2I/Mteex?=
 =?us-ascii?Q?NmqNZPO0OQin1qIJpeDCM9tD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJjSclln3LMp/Jo69+7PrYkjhJc+gzVVxDxxtB+CGkqtCr01Wa8mT5kRUXhE?=
 =?us-ascii?Q?0DJHU0+nwNszwTlSHbrBe6+cEvTwtldPG0UPnLbPg6exuuVv4gt90WVpdc7s?=
 =?us-ascii?Q?NCjBePhSAo/GyJ8nPLzgdlRcV0u354JtU9QtmDqmONaKOWiiGeF2B28oIbiF?=
 =?us-ascii?Q?THNTdppvBDQk5eFHz4Vvl3PLHhuWVkEWtED44ho0dwpOQj+9lU1Mdx11HgFH?=
 =?us-ascii?Q?rY7woLcXqonhj6ZKI4WjXPLouql134wVFj8vZVomjfw82oYkCP3Po1739BCV?=
 =?us-ascii?Q?nWEGfETp298HTwFMT05u4nnv9sDNYaZtbb/wgb2T8/gif5cLBMoVixXt6rhI?=
 =?us-ascii?Q?DeWv5uloyeXcYjsPdoVuK5tT2DKVjZmM0kXR2VTATFZ35rbn7gZbQeiFXSRX?=
 =?us-ascii?Q?kl3nza+7Lj32xSvGSJQxJqgpyvW1/eKXrp1mSYR4Drmj6Qi1TxtYNSill3Wh?=
 =?us-ascii?Q?t1QpIsiWrEl8YX2e+n0i27qykVbRB0DrihAQbXnqa/1xjtTSRjD0j4/4G49V?=
 =?us-ascii?Q?NiF1ky4BUbovcUDCbA9BuvdAOqEF7NFzACkADZu35MzTpEkUBbtIn+QtS6M1?=
 =?us-ascii?Q?RGyPCjBmi7wVtLi+OM+umpbaqSbv9hC2K6u5AOR8WcOGR88Ra+TT0Y4vZaGP?=
 =?us-ascii?Q?AYmBsQyjmDZx9ggKJ7azMws4yl+aJcSjMkuUFHyxBG+lqL4sJRQ9BUSt2oMX?=
 =?us-ascii?Q?tW83OQgRXJA6sv+1mA52DkTMerF/UARQuaiO3KPY9fgcaIl7QRg5xwWsEcWd?=
 =?us-ascii?Q?F3TZoMI5VWJeSQvJJiPRD+PqzbQ3WtEumZuWy/hBn9q4OJLKHdfVX8lPTQ2C?=
 =?us-ascii?Q?47mBvKC0MGbsOtSaaOHNVeZrEu0QlHN3yEEBmZlTZjNjLFtcTt/hfDIyydXF?=
 =?us-ascii?Q?GJHEDc7kWwrYCYLw0GgiOScmqzyNYOvX8gLPzQ4PzZxWEoLTdqqPsVhJVh7D?=
 =?us-ascii?Q?aYXHNS+g0c4FLKK4UL1D2Bjg0xi9sh/9K9ZFuQqVeBMkGgdSs/jVsNFfistF?=
 =?us-ascii?Q?RZyMKOe49DU3jlVrkmnnH3USOg6x0HRx2tClC/XWhTK6sQnfTpmdy4slY5RG?=
 =?us-ascii?Q?0ebaJfiJ4qqNwBbnFd5yris2hdmSe8JUPfbIXrLMMWLr2JXP8VkjIBZhF3q7?=
 =?us-ascii?Q?vpwuAwCMyQ4TAcam5bVaESgSKV4+CybO4UsErQJhKJXRsef4sr5AHJVXbv81?=
 =?us-ascii?Q?OEgc85lHBTjITFauIo3qDvAdHWn0y+J8wiiOWhq/loFQCYvf9cjUj5TwZkE4?=
 =?us-ascii?Q?EB3+XX1fVPz7TTQvw3EoFLkc2dcS/fENQDCYBD7g90PBMYHkgBQ85cFWdFyd?=
 =?us-ascii?Q?iph4xzDFoSLTWsb0Ps+hZBuhqaUcwmeM7SEB2Ek07bdDS1t+3skZL+DjZT0k?=
 =?us-ascii?Q?f0GIS+NwAERuWh8oVzcoARglatH/9uJeb2lzO4xktuAIDEhLfNEj1Rc2jHM5?=
 =?us-ascii?Q?ibapIq9kbW8gsPDZPwMVVqu3gTB30Z02aDtgwOGMFbH0SisO7HwHQqnmc72q?=
 =?us-ascii?Q?z9EAf6g5sPWuds6RjUNy2fl/hDzOPzd6bgS6joZrmJX8iaK+QcylAVn5sfpZ?=
 =?us-ascii?Q?Ajb37wSvqNSROqmV3BlaZ3xIquMCpNswOg2oKbKO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cc7c4ba-0142-4175-d93c-08dce9de4a01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 10:20:11.6722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCc9FZo8fbiu7PoCU2tpJleMLL1WydVslEyI1Vmhwu8U3WgrGv+a/6ada/+Lffz+FB9+KnZ1u86lOPVzfhnJrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9208
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

i.MX8MP SDHC use CLK_IMX8MP_DUMMY clk entry. Without the clk, the bulk
api will return failure.

The correct entry should be replaced with IMX8MP_IPG_ROOT clk in device
tree. This will be done in Kernel device tree and sync to U-Boot in
future.

Fixes: 76332fae769 ("mmc: fsl_esdhc_imx: Enable AHB/IPG clk with clk bulk API")
Reported-by: Gilles Talis <gilles.talis@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 34d91cd6880..1d04090ca00 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -197,6 +197,8 @@ static int imx8mp_clk_probe(struct udevice *dev)
 
 	base = (void *)ANATOP_BASE_ADDR;
 
+	clk_dm(IMX8MP_CLK_DUMMY, clk_register_fixed_rate(NULL, "dummy", 0));
+
 	clk_dm(IMX8MP_DRAM_PLL_REF_SEL, imx_clk_mux("dram_pll_ref_sel", base + 0x50, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_ARM_PLL_REF_SEL, imx_clk_mux("arm_pll_ref_sel", base + 0x84, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
 	clk_dm(IMX8MP_SYS_PLL1_REF_SEL, imx_clk_mux("sys_pll1_ref_sel", base + 0x94, 0, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels)));
-- 
2.35.3

