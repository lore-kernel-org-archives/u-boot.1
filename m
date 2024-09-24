Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6CDCF9C6B
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B54884D2;
	Tue, 24 Sep 2024 08:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NU6n4iJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DFAD88387; Tue, 24 Sep 2024 08:28:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5C5B88356
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:28:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8yUip/j5E0ZAT9/D7nrhZuAyR2VP6FnjeTBIclZ49mB9muIcAb8N11AZ1D0VGZFOIWbEAsSMz8HweuKjR33jEgWhG0tnKUpQ3+KFvkEISajcMKFlcE2snmDHC+6J0n0DG8wiV3rAOpZrO0dQXitQ8svv7dXq68n+dwZhmaisEEnXwo0NPsPnwn57kG/osAXHLn8BHoG27l3vk9+n2/Lt+HiFsCoSE0nYDORiUdi/NLa9w2lyE5FsUaGYW2gfjDwckWEpkyywvoxuYh8XEEV4sGq3NQzV+C2nMra9P3aLzcnfnQQG+IgwmUjiEmA2LfYt1sVay524FzxA5x2o1qeIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgiDAXGPAAtaxNFGF/lCTMczxYKkjv1miihaKJt6V9k=;
 b=SuQUGnw8ps1tx5xC0pG+J8ZhcD/zpAycOmxYzQUb+CnjXJ7x0qzJMKW2Ax52qkVP4prbZ0PCBxPFv3UjooU0evy6pBcOH00t7T9UU620YfaLBm/Rf01+jrdIkXMsU/jV33cUxBnqAYD6YhkAof6LY5ZXp0BQkNPhsJL6yv5wf9qmbGWazEhUKPFm67JbgRhG0coGAsgOe8Kx3w/TSXRKm5v8AH4ZaNGBJ3vmePhWKNVdWThXXvG3Pf0QGI4qlqovJ9oOzd7kGCH4QNAOSgOqKNC+oYZmBkQobibEbWWbp6zDWCHSZ+bI0TkuiZDYyT4sjsW0TqqOKegylxfouQQrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgiDAXGPAAtaxNFGF/lCTMczxYKkjv1miihaKJt6V9k=;
 b=NU6n4iJuavhfTTvZ8Ivi1FcjVeCkpXHEBGAQcvM4MoW2hE+rRev3lt/FIBGJ0nIlT/6+sI06vM+zNoCsa6cKSXuotjNEyrPokzp6veyCTCdIu9kW/kVTe00yeICsIPqtPM1YdCM6G1lkY8YZ3Dt6iNokO6FZ1fEJoTiNO6yE1yP1gNwx2ZrjKGNN2cupJx4hi1sc2Wha0d0GNlqi0BLvWU1CJC+B5L+fvQG07OFarWIBSHFkZzNXT9jyBQOxOf+SbXdZfnwoAbiCULj8EXlNR5KPLiupSCeweJ5jDOMEykZ3Fr5RVC5GqGSIUSiDImZyXaUs20/UBpWiVrB3c8WejQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 24 Sep
 2024 06:28:36 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 24 Sep 2024
 06:28:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, joe.hershberger@ni.com,
 rfried.dev@gmail.com, primoz.fiser@norik.com,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH V2 1/2] net: fec_mxc: Fix clk_ref rate on iMX93
Date: Tue, 24 Sep 2024 15:31:59 +0800
Message-Id: <20240924073200.27578-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 09cddb01-0509-4f78-cc66-08dcdc621e57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k7NYgsm8fTAiisOKSpkhndMEoglgpzmawUOCr59xSf4Z0abd4kq/+gpVCwkV?=
 =?us-ascii?Q?pA+GfSJ05AuLoGUzowK9IS2hU9Iyl2CaSdmP2Y8+pdZv2vlibtCjaevRK4EK?=
 =?us-ascii?Q?0Ab91eavYYpg+BsQnSTOwnDNscSwRmYYKxduUBAhZEDzLFsgx+6FJadhDVRq?=
 =?us-ascii?Q?qtky6bh/4GZWACJkeJFnWcxabnmoNg4f2OLui4OgrfeYcnSQXNGfhhL8C14o?=
 =?us-ascii?Q?YS2l7iEUa/4Seec6NvvEHziqIqrjUqNmWAsdQqYbq5eC7A8dWVQD6FKzPjCw?=
 =?us-ascii?Q?uAhmaCQkSDijxNiRHZrjpXB03iC2VotdPrZydhe2n/jK9+hBeH+I6z2Vd7vn?=
 =?us-ascii?Q?gUTwEhfd7ahbPnCcwsVfcpO19zwpAOGnsBK4CfSnCJx9AvOIBVucyfhVq5Ew?=
 =?us-ascii?Q?YfG0ryyoRqTP81lYxlV1UjacuYxWPawpR98qE1O2ujy0jBPa8Tugn3U81tLG?=
 =?us-ascii?Q?ptaqIso4p3c5DeHCms13JV41LTe7SoxW1Snoo5V2mr4nlBZJ++FCT8BQD3U0?=
 =?us-ascii?Q?ZjO7aifeqPu+jJPgrqeb383xkIKIez++StmeTuijmjSt9l8EeRfBT9ZiejNy?=
 =?us-ascii?Q?AnG8d5DGb/+SuLr578WRTN+2LLJzwTjOSQWlreQGn2p4ybWcRYhzNS2qZJ8T?=
 =?us-ascii?Q?UFjeHYj6FJaFRAOdPcOiRMUhqVA6dUMrjheibOEh1G6WlUjBTdcEOq7iBgm2?=
 =?us-ascii?Q?yf/P/Wxwhw4dUbdooIC9infVJlL/US4jaf+snCJm5n6wQoYs4yo8VDR2OEEs?=
 =?us-ascii?Q?ZBHd9MuSPWFm5fLbU6VvWcZcdulsGq9qGE5EKxqhMHgYzbwNN838Vf5ku1hk?=
 =?us-ascii?Q?jBKOYS3/AcfxUDrnY84czZgP7plJjSMChZQUaaCK/nxwEIcqKij5JrMdIQ2F?=
 =?us-ascii?Q?dHigWT1QgA7jLqm5jIwYMfvOriI5W1vD7eI15YOyuos88mAmtwAzH3zmht6f?=
 =?us-ascii?Q?CXBg6kz9up9dZN3ZUO/HeHrPt/r0rqALs2qM/MM4TnlQ+5wo0fqBHtQA+doK?=
 =?us-ascii?Q?X19DLmjPg33SSRgvtQd7XJlM1SVSm4NHTGSz5DR+cIdmgTQeJ37qN3jEEdkF?=
 =?us-ascii?Q?xxXwdMKXefvkKGhRMp0dUppbgRaEQMvooyCbw1Om9+aARqQgn8VBRGuafsTi?=
 =?us-ascii?Q?O9eKWNbvC/+mDJUtB4Ab8dTRb8tlwA/4/QhJvXkTt5o9q3AiFCGC0JY8WNMz?=
 =?us-ascii?Q?cjDHKKQbkheRLM70FDLOSJGT2W68yXqtl5afI+xMFYbHeFN4hkX34E+6VQ9G?=
 =?us-ascii?Q?d3jU0LGAoVzul+tKjcDlKGp7l1ttXadpXWR8yAB/SvEbPyTYluB9Q2PqBL3L?=
 =?us-ascii?Q?FFrFGO1krcYrngbk1lu7joaV+ag1LB3ksPqh12VFJGTzPJg3A4PFYCaPRTnP?=
 =?us-ascii?Q?9j7T/FxoZtsoeI2iB1PFfl4ZtLBw16YxxiswFCXw7KzfWeb81A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Rz/g3c9OFULFoeFtEHDVRgsbW21/L0mbk1E4jF+/JkApIMtZ5WM5EpFRN2L?=
 =?us-ascii?Q?HfWMlGMGvjMsB/XBjN0QyAvsgdQf7hpTIU7Z52VzdUoGPC7Zy9afHOaG0fv2?=
 =?us-ascii?Q?MC43v3LmQx5t4ga+oO/amFQs7FGrKmjTo5CLnODCgEF/6DJhszHqBNgi6cGb?=
 =?us-ascii?Q?DU5Ze2EczL9hyd1O2dNBq5nuQoGLCGHGozms+iRJgXrvDPI2L9Ktw5Qo5Ztc?=
 =?us-ascii?Q?+MMGe0wCqoX8qs9ivOM7GGE+rR/9/lWiLggI3Fdgc5SkBdApj5GvAC51DDmD?=
 =?us-ascii?Q?8UhZF4MaeLP9XrFeuxNt4kVM/L2b0bTM5CW5mrwL7oRX5hjkPF4t/qckTn9K?=
 =?us-ascii?Q?XpzYlf9haE3usgym6G2/5brvPvdqj8wpuATx1LgbSwk4GASxbV1ZTiZE7+8g?=
 =?us-ascii?Q?ALTpFDPNioL7+C90JDwI5KfOaX2vX7pGX6KcOy7v/VhUsuJffW9JaB8bl0rT?=
 =?us-ascii?Q?y3DfVf3Fer8r2OCjdeq5U/dVo+zn1UnjXamds6vjqELTU7PzqMdzihGbBtAK?=
 =?us-ascii?Q?7kF39DDgjcBvO3J4kmSvzo2BwEiDKylg2cQRwb6Xp/PHmD3ar1Vx+mgvJnjt?=
 =?us-ascii?Q?pjM53QS4G5L68l2/qrdqzaPH720GgzAomDI91x9JJp6sL108QQomX86ONQLK?=
 =?us-ascii?Q?uzCp02lWBYyw88KoV+A1SoReBop792y6nxcvTUW+2uWKMxzFhyR9MBHRBwTV?=
 =?us-ascii?Q?Sl8JPfx4iQ5R6QPsv5ow/+ozfUBa7cSTYwEUGxIRHqW7olrfVqrJsed0a369?=
 =?us-ascii?Q?FxW/iv0Z37QMlDyOeKYT4cohc5XfFHZD+oP/zHNNOj9fEIjauswg2+ysa4PD?=
 =?us-ascii?Q?YJGXfAW0r2Sai+m1Gu72phkZmxX+9/1Ai9o3M/zBRWm9P567pjmueYpmjP+D?=
 =?us-ascii?Q?lPo8J+78mHcVw8nltojNRigfirXaaxAKBs1AoARK220YQYWrF0YXW+28P/Qd?=
 =?us-ascii?Q?WA8PG3L2u5SHy07w/FGZK7ud1oE4HdWbLZfNUiwTTKfVapT+U9hSLfxLmPN/?=
 =?us-ascii?Q?pMUW5ptyOwj/mjqeC64c1N92C2Mb1Z2zmEUc6jdcMRPykLo3RZh376n4OROz?=
 =?us-ascii?Q?UgS1PXM4pWPnpiOXbnTnJczm1x8dHxVV1lJGEbpwM17oCGtN8p/zyP81o1VE?=
 =?us-ascii?Q?MXbp1+KWkQ7Er/kNIKc2MYCJnBnZeEWYYy4DSu4vgrakGEmUdFJb33Cg+g0A?=
 =?us-ascii?Q?SYjEEbCBF3CjkVE7dJrOx64fB5Y4c7mYkxZT7dhaHnVjKKTBn+Po8yua81Wm?=
 =?us-ascii?Q?9htPPYwOFdnuHLu+Zwf6MrCzE3RUxloro85T67PzfUHDDMCnQPudk7MFCsF3?=
 =?us-ascii?Q?Eq6sdej7/SXa4HXHH/ZOkj81/IYPjDIctoFiT1Wcvgr3Pq7Mnn+lo5WmI28J?=
 =?us-ascii?Q?3gY+a1BVfEdPvU54/mDNRgfX+kGFwFeOck1AVy8h49X6n1AOmHR9cdndGC6r?=
 =?us-ascii?Q?CYLP68FmesP1ijlhCMJVi+v3fuQoP2iFzDM0y1R1hwwn7ZqGkHjQx2XcWbWv?=
 =?us-ascii?Q?DpnMA2gK7qlf5Op6qQR7ue3jouCV1qw4t3fNRRv68RLA0XAKkD9Wi2yNCyUC?=
 =?us-ascii?Q?zsB0dT2OLt17DLtCSN0C3vMmZbqRwt9L+GrppFA1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cddb01-0509-4f78-cc66-08dcdc621e57
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:28:35.8333 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JNv6kxTX+iHG6PyNMHGPZB40bH5V757GREybp49GW0LrwHyOdFCxDUKtuPkcKFGwe3rYoYJRH7JN2dXoc/vTtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633
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

i.MX93 FEC ENET port supports two mode: RGMII and RMII. For RGMII,
there is an internal /2 divider, so the freq needs to set with (*2),
otherwise the speed will not reach 1G and cause communication error
in some network environments. For RMII, the clk path is
ccm -> enet tx_clk pin -> pad loop back to enet, no /2 divider.

So fix for RGMII mode with freq multiplied by 2.

Fixes: 09de565f76b ("net: fec_mxc: support i.MX93")
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 only update freq to RGMII mode

 drivers/net/fec_mxc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index 0a0d92bc2cd..d0590fd137b 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -1210,10 +1210,13 @@ static int fecmxc_set_ref_clk(struct clk *clk_ref, phy_interface_t interface)
 	else if (interface == PHY_INTERFACE_MODE_RGMII ||
 		 interface == PHY_INTERFACE_MODE_RGMII_ID ||
 		 interface == PHY_INTERFACE_MODE_RGMII_RXID ||
-		 interface == PHY_INTERFACE_MODE_RGMII_TXID)
+		 interface == PHY_INTERFACE_MODE_RGMII_TXID) {
 		freq = 125000000;
-	else
+		if (is_imx93())
+			freq = freq << 1;
+	} else {
 		return -EINVAL;
+	}
 
 	ret = clk_set_rate(clk_ref, freq);
 	if (ret < 0)
-- 
2.35.3

