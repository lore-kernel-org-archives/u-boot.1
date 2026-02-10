Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46CCEA8108
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A7AA83D0F;
	Tue, 10 Feb 2026 13:41:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="XFBmiCJN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A81A8309A; Tue, 10 Feb 2026 10:00:55 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECA638309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz1jgwslOJ4yeP5PGM3j4sUd1/kUjefD8l5w3i2HWd5omxyWWRXolbdQehTIpAEB/sgV/JyLraUOGQ34156KBvrT8IRsxdk90efUxtpwU1J+G6RXSRMBzt9iS/jNwpBJwix2rMd03fJbyeXKVHPDUy2L0WBxRN19Fc0ZV/vMSgBvdDayq9tOhvyim5ZEO8Z6dHk9UqPm4jVyCXnFqNwmKJpPsm5hNbxQvXThd9r1kgWcA3RZbMWjsHW+SlMsqgc8roXzV2QcAv73XhjO6KTyzIqjd56LgRNO3NUkk/YW3zvCKHomiaAN1QMfBKY4AKMe/9WLgTNEVSnJiT+LVA/HAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvRKZSsyZAqYfeVAo+2JJepTS5soVT4XelPsiwpjLF4=;
 b=aImyI5IuBDVtqOny14qkrf6NpAm6UmDAdvkLgXqpX81qfaJLJ886y/6fSV4of+g9NM7C1B7fxe4KtAlx2EGUbafRoDQDyoDLQI1UEXbp3WmNNFN3wjVCAJXEF9gcIP7r/qhHGSt8CGit9PhJNwjuHEtgbTgkQxJAAxZPwZyPXxc47zCwBZDtCeDj9ZAuhh7lU0VfpebzqcSUVy0cbvLDDWsKkgM8grLU1K5Gym88cmfWhk7kltd7JJmyvQnLu6UndM7JqJiqFB5KJbPEGQN2aMArOxU7LsQaBIWo3whGaOarPT1nZA+IpEzmi2x0fIQVfdS+yIoOBVn3ZvjmV/CuLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvRKZSsyZAqYfeVAo+2JJepTS5soVT4XelPsiwpjLF4=;
 b=XFBmiCJNdj4V9+h0j+oy7iDxStqkwz3JFcuDduJLG0+mAxr17FYGIpqw0KWoEW+VkYv2uL6Pkko0npDTbsBneptUv0Uywg0HttynUbJX10RCkJNH7VCgXa4xUJKVY94nc9nmASqdDTjh8rLkx0rD5TpfRkFWL9kMoJOyidfmnu/5dV9utdR9K8Xo49x4+uQSq+1275hO4jdWIzuCJp1Z6Xxz941DG65vzX0T+E0duZPCiO+4gm3gzhm7j10eRA//C34yEfhSZg0LGm57rPpH+JwW1OLV/dfcA1KXGaPz1gCiT4lg4ryBjZOMKr06UQGUAzlR8cVH7IdeGV91p2UXGQ==
Received: from CH0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:b0::31)
 by MW6PR22MB4176.namprd22.prod.outlook.com (2603:10b6:303:23c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Tue, 10 Feb
 2026 09:00:48 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::44) by CH0PR03CA0026.outlook.office365.com
 (2603:10b6:610:b0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19 via Frontend
 Transport; Tue, 10 Feb 2026 09:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:00:48 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 14A63FB3EB;
 Tue, 10 Feb 2026 11:00:45 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>, Adam Ford <aford173@gmail.com>,
 Marek Vasut <marex@denx.de>, Mark Jonas <mark.jonas@de.bosch.com>,
 Peng Fan <peng.fan@nxp.com>, Ricardo Simoes <ricardo.simoes@pt.bosch.com>
Subject: [PATCH v2 2/6] clk: imx6q: apply clang-format
Date: Tue, 10 Feb 2026 11:00:24 +0200
Message-Id: <20260210090029.728636-3-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
References: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
 <20260210090029.728636-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MW6PR22MB4176:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c99f3bbc-e0f8-4716-f008-08de6882e225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ldR8IANmbPHzhwpwh4uiuh2OfRAeUjQTMQQEMdZnK5Vd624w7Nde8toUaWyD?=
 =?us-ascii?Q?kZUxjesJKfUG4bmgZ5WYAF0XBzNGCOewksVtvPV49DHXC4u6CE+WFrfGg0rV?=
 =?us-ascii?Q?iFkOnbGXoj7un8qmsddTg0fEYN3VFJJQIws+0yL6x519+EyZsk55DIDoeFjh?=
 =?us-ascii?Q?vBxYoqBtigZLBldmwbOuzGmqbcYQ5D9SKfif7A8TBRQLUlJm6jNoqXGcxymh?=
 =?us-ascii?Q?j0Cprit4BeSpA8QiDauuQsEzilBgqL87QhQ8i/8DW2EBViTfV0q7fDLcBypC?=
 =?us-ascii?Q?nDUIYL+494q4dMddDXoTTTp1Boo6KA+pCl2GATwElUOpyTGfvpcKeiX6/nfm?=
 =?us-ascii?Q?ZrizTUWlkm34svOohtJn0Ei81qMZYnHTLKKWQF+sTXGXHEiFPaw5n4rihCuK?=
 =?us-ascii?Q?+ant0rFLv3vC7n4TRmei2T7YDeG/1Sp4HkgS/KkgEtDYvwvLMFFfh+3hWUBY?=
 =?us-ascii?Q?HHpgUc92XTdq+IuzzV80VXPyhN6PeamrdjaNWU3aQ+8YYF12GJkH56XXsfYC?=
 =?us-ascii?Q?MvU+C1l0s1961zBo0dIhiGT/ygTM8vmQmY03n2lSXyQLS9djCkFiMGYzXl2P?=
 =?us-ascii?Q?6ir8zAZ/dAfwsgYyz2ePbgb9NIpBXqEjOruo6XpRkEbgYZ2v/LWcqEpnL+rS?=
 =?us-ascii?Q?dAQuBMOLKF4qBopK6hYG5qjUvewhO0CeWHx/Va7MiPk5aYVnNkDmTKm5+aKx?=
 =?us-ascii?Q?RP1MAwx/NaKnem2GxP94GIun0F4SKMB5l+RFChDDV/aKrAfJLEYG9bSsHVrk?=
 =?us-ascii?Q?S00AR680OQV3+pCG0bSBzjKlU0O/JVZvkteUUkPKmWY0IvNtQa2Ci1vc+tYi?=
 =?us-ascii?Q?xeIpDIln6+SAZSzS5+hJsLz8ih69LCoMnzIYsvpOZJYE3Gh8hIr7FXdfvQfv?=
 =?us-ascii?Q?SiGiTVV1eilC20NcnTuEtKiEH1oT0q616AZSuJPIzCSQt/9hQR4av6+fc79r?=
 =?us-ascii?Q?B3CJih891AV47YNxrUGBus43j1hV2znBSZn6VxJF4eGmwrnINT8Jc6ca5ete?=
 =?us-ascii?Q?caSvAO/hgBrbAVeX2L36WNxNQ6HzqtnjdTUsVt1AZfdottVORe68vPrESG00?=
 =?us-ascii?Q?PTGW6TQ5q1WBmjw8zVmD6jR5uYrszQPLWqhYb8qsiZfhDssmno6rxNsronDc?=
 =?us-ascii?Q?swn3OQ3sEx0nXr83xm9PBnStsM3m+yAk6Y+ZkVqBCa4dPN7M873gg1eG/hZ1?=
 =?us-ascii?Q?7fT3t3dMSh35w4xAL8vHd77DojoGvnA21ibMipacWB0rMXMYPTV4vLIb1DUT?=
 =?us-ascii?Q?3GrCsEQcBh/0ePaJ75TRg7trZoWxtaQ9dlH3XHsTwph9HuZ9ilnTduQuAWXH?=
 =?us-ascii?Q?uqGnnRw4r941LEY+so0qhUKAC5LDMk1VrX52hO9qJOhlb1YDqXe9v0JEqD20?=
 =?us-ascii?Q?iIqTCIGQBjY0r1tGwZr8VS8qs+1+FP31+5E7NW1/6M6KigRGrcHYzXQ5u6+h?=
 =?us-ascii?Q?LFZ13fDM3DyxylwSupHGFwprpsHYaqBc/MmbB4/+hefEcdTUOporqo7NKJQV?=
 =?us-ascii?Q?VTvYNIFdS93/vQFXHkDlwqYuEryfEaa/Vgg5IEMsjZFi2RAk4mS4Q+zwfoxf?=
 =?us-ascii?Q?abuAMuYt31SK/HNFbzgywv4PUXZmq/Ysz4KTilQb3h1JKgnhhB4UCXQRrCpW?=
 =?us-ascii?Q?Vq76Hwmeq4Q314x5j0WowOPuol8VwMZ6IXvuLw2I/EXSAOs+O1+6gKK3WUSA?=
 =?us-ascii?Q?TgBWHw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BhZR1U8BKJ/VIEF3WU1fVvs9Ql6cgwhpNkyEQ2YxJB9xp+j0vt5x8o9S0UiUk8i2xeniEr3r4pkh/+Bx7NIbmdGwVoCAIT94eRoi7dxRO5A2S5pdle28Qzn46cNipkulG+8av2YcaWDtTcbM7sFDijg5y3ZE+yKpfP8X4LmMRbdLdzXEjlUoROJfvKBSGRs/mmmzXQrZUDXN+4bm/5klROEQcE1J0pZstbkemxx1G5iIyPpKkfKq+zQyrnEArmUzZAujIxcGYSJCMmV/KBOMwfv1J9r+W7EQSXTx/mAcmkNygSZ8uYPRm5okUN+MUJPMYBV8i2jEcN3KpNTNQN+un5pTn9f2mdLr2nvAJBJxqIezDjgqwaJaVr+IaBbb4wJCZcXPTJMXUuu3I3wKqpo1uafmOXbrE7xmiXyRmKI0/b83opq02P6X3iS3/xpPpYrX
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:00:48.1174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f3bbc-e0f8-4716-f008-08de6882e225
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR22MB4176
X-Mailman-Approved-At: Tue, 10 Feb 2026 13:41:53 +0100
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

Conform with U-boot guidelines.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

(no changes since v1)

 drivers/clk/imx/clk-imx6q.c | 102 ++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b69355cefc7..f11f9045abb 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -31,12 +31,28 @@ static struct clk_ops imx6q_clk_ops = {
 	.disable = ccf_clk_disable,
 };
 
-static const char *const usdhc_sels[] = { "pll2_pfd2_396m", "pll2_pfd0_352m", };
-static const char *const periph_sels[]	= { "periph_pre", "periph_clk2", };
-static const char *const periph_pre_sels[] = { "pll2_bus", "pll2_pfd2_396m",
-					       "pll2_pfd0_352m", "pll2_198m", };
-static const char *const uart_sels[] = { "pll3_80m", "osc", };
-static const char *const ecspi_sels[] = { "pll3_60m", "osc", };
+static const char *const usdhc_sels[] = {
+	"pll2_pfd2_396m",
+	"pll2_pfd0_352m",
+};
+static const char *const periph_sels[] = {
+	"periph_pre",
+	"periph_clk2",
+};
+static const char *const periph_pre_sels[] = {
+	"pll2_bus",
+	"pll2_pfd2_396m",
+	"pll2_pfd0_352m",
+	"pll2_198m",
+};
+static const char *const uart_sels[] = {
+	"pll3_80m",
+	"osc",
+};
+static const char *const ecspi_sels[] = {
+	"pll3_60m",
+	"osc",
+};
 
 static int imx6q_clk_probe(struct udevice *dev)
 {
@@ -52,13 +68,13 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
-	       imx_clk_fixed_factor(dev, "pll3_60m",  "pll3_usb_otg",   1, 8));
+	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
 	clk_dm(IMX6QDL_CLK_PLL2_PFD0_352M,
 	       imx_clk_pfd("pll2_pfd0_352m", "pll2_bus", base + 0x100, 0));
 	clk_dm(IMX6QDL_CLK_PLL2_PFD2_396M,
 	       imx_clk_pfd("pll2_pfd2_396m", "pll2_bus", base + 0x100, 2));
-	clk_dm(IMX6QDL_CLK_PLL6,
-	       imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6", "osc", base + 0xe0, 0x3));
+	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
+					       "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
@@ -68,50 +84,54 @@ static int imx6q_clk_probe(struct udevice *dev)
 		return -EINVAL;
 
 	clk_dm(IMX6QDL_CLK_USDHC1_SEL,
-	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc1_sel", base + 0x1c, 16, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC2_SEL,
-	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc2_sel", base + 0x1c, 17, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC3_SEL,
-	       imx_clk_mux(dev, "usdhc3_sel", base + 0x1c, 18, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc3_sel", base + 0x1c, 18, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 	clk_dm(IMX6QDL_CLK_USDHC4_SEL,
-	       imx_clk_mux(dev, "usdhc4_sel", base + 0x1c, 19, 1,
-			   usdhc_sels, ARRAY_SIZE(usdhc_sels)));
+	       imx_clk_mux(dev, "usdhc4_sel", base + 0x1c, 19, 1, usdhc_sels,
+			   ARRAY_SIZE(usdhc_sels)));
 
 	if (of_machine_is_compatible("fsl,imx6qp")) {
 		clk_dm(IMX6QDL_CLK_UART_SEL,
-		       imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1, uart_sels,
-				   ARRAY_SIZE(uart_sels)));
+		       imx_clk_mux(dev, "uart_sel", base + 0x24, 6, 1,
+				   uart_sels, ARRAY_SIZE(uart_sels)));
 		clk_dm(IMX6QDL_CLK_ECSPI_SEL,
-		       imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1, ecspi_sels,
-				   ARRAY_SIZE(ecspi_sels)));
+		       imx_clk_mux(dev, "ecspi_sel", base + 0x38, 18, 1,
+				   ecspi_sels, ARRAY_SIZE(ecspi_sels)));
 	}
 
 	clk_dm(IMX6QDL_CLK_USDHC1_PODF,
-	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel",
-			       base + 0x24, 11, 3));
+	       imx_clk_divider(dev, "usdhc1_podf", "usdhc1_sel", base + 0x24,
+			       11, 3));
 	clk_dm(IMX6QDL_CLK_USDHC2_PODF,
-	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel",
-			       base + 0x24, 16, 3));
+	       imx_clk_divider(dev, "usdhc2_podf", "usdhc2_sel", base + 0x24,
+			       16, 3));
 	clk_dm(IMX6QDL_CLK_USDHC3_PODF,
-	       imx_clk_divider(dev, "usdhc3_podf", "usdhc3_sel",
-			       base + 0x24, 19, 3));
+	       imx_clk_divider(dev, "usdhc3_podf", "usdhc3_sel", base + 0x24,
+			       19, 3));
 	clk_dm(IMX6QDL_CLK_USDHC4_PODF,
-	       imx_clk_divider(dev, "usdhc4_podf", "usdhc4_sel",
-			       base + 0x24, 22, 3));
+	       imx_clk_divider(dev, "usdhc4_podf", "usdhc4_sel", base + 0x24,
+			       22, 3));
 
 	if (of_machine_is_compatible("fsl,imx6qp")) {
 		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
-		       imx_clk_divider(dev, "uart_serial_podf", "uart_sel", base + 0x24, 0, 6));
+		       imx_clk_divider(dev, "uart_serial_podf", "uart_sel",
+				       base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-		       imx_clk_divider(dev, "ecspi_root", "ecspi_sel", base + 0x38, 19, 6));
+		       imx_clk_divider(dev, "ecspi_root", "ecspi_sel",
+				       base + 0x38, 19, 6));
 	} else {
 		clk_dm(IMX6QDL_CLK_UART_SERIAL_PODF,
-		       imx_clk_divider(dev, "uart_serial_podf", "pll3_80m", base + 0x24, 0, 6));
+		       imx_clk_divider(dev, "uart_serial_podf", "pll3_80m",
+				       base + 0x24, 0, 6));
 		clk_dm(IMX6QDL_CLK_ECSPI_ROOT,
-		       imx_clk_divider(dev, "ecspi_root", "pll3_60m", base + 0x38, 19, 6));
+		       imx_clk_divider(dev, "ecspi_root", "pll3_60m",
+				       base + 0x38, 19, 6));
 	}
 
 	clk_dm(IMX6QDL_CLK_ECSPI1,
@@ -125,7 +145,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_UART_IPG,
 	       imx_clk_gate2(dev, "uart_ipg", "ipg", base + 0x7c, 24));
 	clk_dm(IMX6QDL_CLK_UART_SERIAL,
-	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",  base + 0x7c, 26));
+	       imx_clk_gate2(dev, "uart_serial", "uart_serial_podf",
+			     base + 0x7c, 26));
 	clk_dm(IMX6QDL_CLK_USDHC1,
 	       imx_clk_gate2(dev, "usdhc1", "usdhc1_podf", base + 0x80, 2));
 	clk_dm(IMX6QDL_CLK_USDHC2,
@@ -136,11 +157,11 @@ static int imx6q_clk_probe(struct udevice *dev)
 	       imx_clk_gate2(dev, "usdhc4", "usdhc4_podf", base + 0x80, 8));
 
 	clk_dm(IMX6QDL_CLK_PERIPH_PRE,
-	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2, periph_pre_sels,
-			   ARRAY_SIZE(periph_pre_sels)));
+	       imx_clk_mux(dev, "periph_pre", base + 0x18, 18, 2,
+			   periph_pre_sels, ARRAY_SIZE(periph_pre_sels)));
 	clk_dm(IMX6QDL_CLK_PERIPH,
-	       imx_clk_busy_mux(dev, "periph",  base + 0x14, 25, 1, base + 0x48,
-				5, periph_sels,  ARRAY_SIZE(periph_sels)));
+	       imx_clk_busy_mux(dev, "periph", base + 0x14, 25, 1, base + 0x48,
+				5, periph_sels, ARRAY_SIZE(periph_sels)));
 	clk_dm(IMX6QDL_CLK_AHB,
 	       imx_clk_busy_divider(dev, "ahb", "periph", base + 0x14, 10, 3,
 				    base + 0x48, 1));
@@ -163,7 +184,8 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PWM4,
 	       imx_clk_gate2(dev, "pwm4", "ipg_per", base + 0x78, 22));
 
-	clk_dm(IMX6QDL_CLK_ENET, imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
+	clk_dm(IMX6QDL_CLK_ENET,
+	       imx_clk_gate2(dev, "enet", "ipg", base + 0x6c, 10));
 	clk_dm(IMX6QDL_CLK_ENET_REF,
 	       imx_clk_fixed_factor(dev, "enet_ref", "pll6_enet", 1, 1));
 
@@ -172,7 +194,7 @@ static int imx6q_clk_probe(struct udevice *dev)
 
 static const struct udevice_id imx6q_clk_ids[] = {
 	{ .compatible = "fsl,imx6q-ccm" },
-	{ },
+	{},
 };
 
 U_BOOT_DRIVER(imx6q_clk) = {
-- 
2.39.5

