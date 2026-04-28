Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629BAFF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 12:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2C86843D4;
	Tue, 28 Apr 2026 14:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="uyFbFTBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DC0F8466B; Tue, 28 Apr 2026 10:51:34 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 114CF8432A
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 10:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMw6xxjVKKe7rQSdmH1VkQRLZeDlmzQemQpzhh465MgWUgkV3rqpj3YTe3U3T+YKUPiu6haLJMo2HUahgz/ntUhYMw3W4crYI2M1w1BeQiXbNd4yhLPP9+Pmi0uaoj63vGwqvhB4rC+BkbvEnc3xJlev7PPkbefOnquOFjIGUEBWLUaVMOcaOCqhT9V7TkC3N+jiALS2Ne8bB7Q0UZap4c8Px3FaaB3AqUhTA8nvtZHh4kOqNQ7ynbWTgZGqeXlkp4rAGa1XRn6Y4oeRyq30gukBC5YKrPLWuFuxyguD70jIMRJxdaOs5LjlRZziKPQH+mjI82qRvtQpYqj0/jtwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DzUxC9ieEYBcgkLyk7IaekCLMQYjHvdJihZGGJGEAg=;
 b=y54W0Q9q1m5v4G+EMVUhWhVhZhVE/OPC9POftTo5you9Jkylizzlsj6kmXQQxUoPZ/I3QfH2II5BMR/0NV4wTcF/DJ7ivTmrHyXYsC3Q8QWiQ+wHD01sfhk+T7y/Sv05sbWZDYY02YIm1ZljDcwSkGLNb366VHBIyCrnUgzILYNZkRwQykZhJHi+Giu6VxT3/8hoX6jtih8yYuUasM0YppbkfCSlJR8vnv71K11fvBdNLzOYKkNtElOERtqyEUN+UL6dmruEwZGT9WncRZmwwRqkdb5xolosPP1W8Xfzac6Sw3c3I1YHXzF4TN69GjtRCXxxt9aj61YiD5Dn6nGNVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DzUxC9ieEYBcgkLyk7IaekCLMQYjHvdJihZGGJGEAg=;
 b=uyFbFTBmBKychN/+iRmF1un5Rdw4/N5Mwq7Z/Ey2pyAJ53SxAHmTeGCD37P5aLNsMur5KgCH9RpGLd0WNck2/4lWa6W83ozQRUQYvopznlkpv2Pie0huk9Ye7Dk0iHHnkwWKzLqiTjVHbwzRloBfNpmAj7vCQGpep6qowu3adRBFCMWelA0iWHaxQZSlw53GqI5MAKaSk9Cs63rDkGn1X1sJ24r5foo5Wr+6U9O9XaXZdWIHqu1EoTmZhEUMV8b2vSKHsyuu8G3M8PdcSDkvYfFYBG3VHIuAg/hNFIw6CZ+NO51vaDg3eqg/LvGEWu92WfTEx4nl1hyDouQwfQgPBQ==
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by MN0PR22MB5662.namprd22.prod.outlook.com (2603:10b6:208:4a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Tue, 28 Apr
 2026 08:51:26 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:23c:cafe::6b) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Tue,
 28 Apr 2026 08:51:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Tue, 28 Apr 2026 08:51:24 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 2B4121319B;
 Tue, 28 Apr 2026 11:51:22 +0300 (EEST)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: festevam@gmail.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: brian.ruley@gehealthcare.com,
	u-boot@lists.denx.de
Subject: [PATCH v2 1/7] clk: imx6q: cosmetic: keep pll definitions together
Date: Tue, 28 Apr 2026 11:51:06 +0300
Message-ID: <20260428085117.402523-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|MN0PR22MB5662:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d476189b-1825-467f-7db3-08dea5035416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: XiGR2giAwYrG2Mig7/euVDatxFOGzSOS/j73Vez42HgKJbC1C730ZLp9OeFyNH6C5KnWVCcntfCHEc+oEjI198Ov6/tCj/hBs22N+af991bF5CNjQaRSRSt5NjbLrYUeySuKuhOBS3uYhu+8C4ApZwcUNVroTO0EyMeRgiNzn4nr+4UKw+/ZWUj/YEhjKhL4mdBINA0HOaxysh/Lk5gDMiZN60TMn3moutmsj8dilyT4w7cxnJa8ANiYaJECKSX/HIDyPgmjNXj1CO0UQJV8+eHp+Oi45m9pwSYu4hyAjlhXCQRIvoTQEVtYPp055kgTjQ54OSakKOVFdXWfc3CBiXHO4Bbf0NKx0l+aLnJfsX9glY5j65rII2g32DnI5KfL+n8dvzt9v2cHlhw/tcEIfoPlKsHdPaQq5LD5hKi46XVCB9qfFJI4RIDugaDFuEni5isnyC4Ot1yMu9lNcvpLNY1xlL7rTVwTv2rlS+Pgl/v/dVppyW9uwPKtXppfSFUFdm1AhLUGUB+HC3CcjxAJjmSS1tXgh/lgubrvTHUUzUsKmTTQhUUg+ZqPXEz0dA60v9PQY4mVzapUq5y5Vkrdb4Q8j+8OIFF264+64WyXhn8yxkMgMhUTyZFc7CTxyXz8yjN2c3LrmkVWUulEWYCq19N96oqbyIrGEhmNsrADlLw3LCRfCR8BuZw+BK3OIIGGXH+WYGjS3medtbiOluqUyra2wLT63VK5VtLOMpDFnCHDEBjum2wbb7PE0G6db0X2
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: P6v5x7ddMfRZqxKA6Q0nT9qws5ZuSlb0N5noo4tTpn8A/v6FPfzz2Y7wNH6ns2jP4/dFqJ1PumG9V7I22uJm4TnbPCrq2NG4+8QeGajeWsyLy2dpuPpDmNoA3rtJ3iS+WLfJ0BaQhl667R3Eivfg4W1yGLTMoZ1/NnLdMfP6AzeO0ZFpjROI96qHkEqT73XTPIKkbZgpw9FdDTPYOJLM9uYarbv14oyMlMbXRU0Kavam+gPTpt4bU6j5Tz5sfDNPW1rLlS6SNSSL0eBJxV4PXvGdHT7f52MfIxAGHzVDsrsbQQrLTN5vXDURfSvqs0/RnB0/iMkLTaAODklm6QTgcNO3DCBPUmKHXmGKa3wiiJHEpGcXI/OyUfa/g9AxUyXPrEacIOxQ07lkkIlLe3MsbqykRvKbtqnWYUbuCmBeW1l7F+e8HPaW8al2wbaxES7G
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 08:51:24.4647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d476189b-1825-467f-7db3-08dea5035416
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB5662
X-Mailman-Approved-At: Tue, 28 Apr 2026 14:41:00 +0200
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

Make it easier to reason about by keeping similar clocks grouped
together. While at it, fix comment spacing.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---
v1: https://lore.kernel.org/u-boot/20260422094649.57611-1-brian.ruley@gehealthcare.com/
---
 drivers/clk/imx/clk-imx6q.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index f57ac79f8ca..cd06d211e8d 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -126,18 +126,19 @@ static int imx6q_clk_probe(struct udevice *dev)
 	clk_dm(IMX6QDL_CLK_PLL3_USB_OTG,
 	       imx_clk_pllv3(dev, IMX_PLLV3_USB, "pll3_usb_otg", "osc",
 			     base + 0x10, 0x3));
+	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
+					       base + 0xa0, 0x7f));
+	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
+					       "osc", base + 0xe0, 0x3));
+
 	clk_dm(IMX6QDL_CLK_PLL3_60M,
 	       imx_clk_fixed_factor(dev, "pll3_60m", "pll3_usb_otg", 1, 8));
 	clk_dm(IMX6QDL_CLK_PLL3_80M,
 	       imx_clk_fixed_factor(dev, "pll3_80m", "pll3_usb_otg", 1, 6));
 	clk_dm(IMX6QDL_CLK_PLL3_120M,
 	       imx_clk_fixed_factor(dev, "pll3_120m", "pll3_usb_otg", 1, 4));
-	clk_dm(IMX6QDL_CLK_PLL5, imx_clk_pllv3(dev, IMX_PLLV3_AV, "pll5", "osc",
-					       base + 0xa0, 0x7f));
 	clk_dm(IMX6QDL_CLK_PLL5_VIDEO,
 	       imx_clk_gate(dev, "pll5_video", "pll5", base + 0xa0, 13));
-	clk_dm(IMX6QDL_CLK_PLL6, imx_clk_pllv3(dev, IMX_PLLV3_ENET, "pll6",
-					       "osc", base + 0xe0, 0x3));
 	clk_dm(IMX6QDL_CLK_PLL6_ENET,
 	       imx_clk_gate(dev, "pll6_enet", "pll6", base + 0xe0, 13));
 
@@ -279,9 +280,9 @@ static int imx6q_clk_probe(struct udevice *dev)
 				   ldb_di_sels, ARRAY_SIZE(ldb_di_sels)));
 	} else {
 		/*
-                 * Need to set these as read-only due to a hardware bug.
-                 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
-                 */
+		 * Need to set these as read-only due to a hardware bug.
+		 * Keeping default mux values. Fixed on the i.MX6 QuadPlus
+		 */
 		clk_dm(IMX6QDL_CLK_LDB_DI0_SEL,
 		       imx_clk_mux_flags(dev, "ldb_di0_sel", base + 0x2c, 9, 3,
 					 ldb_di_sels, ARRAY_SIZE(ldb_di_sels),
-- 
2.47.3

