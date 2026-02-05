Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81964ECD983
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:34:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00F5D83BC8;
	Thu,  5 Feb 2026 16:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="uCbBp8U5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D39183AAD; Thu,  5 Feb 2026 15:13:53 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EBDF83015
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 15:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2Jf+KkGWkFoJ48y0579ALwZE49PMNYU7SfDZwKBEwp4FQDdieIVbzzzyuMdsGqfOXDTGsJwwfPZoN/HAG2GXnSxkFHrY6LZILdwFShXluAMcFp5SsbXLFTxhHbqSM7vKGTZ63vrUDlnFw3cgxNnBZUWrBZrFbs6W/OCczgnloGdz3IPbeZlY+6JbsljLJn/ePLeUquM6L6MxAEFW4UkEzwtCowMd+3heiethVs8GGwqIliXRvmPUOvr26fTS5Xj8SUa5HfT7gIQ/fnVtROyKl/Zc77xLpZPfWNJ3GIHKpfORSxf2c0GLAMRhGxxzN86IvLhqrMAuVCjL0Dg21IGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7kwHTlk5774Hj7xQ9aedCd7Kfp3rPhP9QSZ4WNu/5s=;
 b=i6+sMV8XVL5XTc4Tfz2gZlWrSveFUnNLMcRDyac8hPQ9xRoDdsxBrrmzj5eMeVFL1mP4X3MhjgT41RBE4bpMyMAEqyWewYyoaBQ9DCr7aDGABbXi8Ry0MqPuE9NgTSIf7j1wMsRfk0R7Ghujes7G0P/O5q64YrX3XrrZ/T8qrTG2BAejhiXkO6mxWtg/wqjqFHpGg0hbXAtHqrdY258vHuwA6XfgjuGMFEHYbBH0kl9KnoN+JxYujlJqrws3iAb0LeQiUTHwm1lhgvwmkACfPbEkMENikFsLxSz6Z6+8343It5S1IKVfJTTJmdYOsshfMgvIUnwOvxfILLESKOLG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7kwHTlk5774Hj7xQ9aedCd7Kfp3rPhP9QSZ4WNu/5s=;
 b=uCbBp8U5+1KNg7HXbu6R3j/ZY9M9xP9CWoMbnz6J8ztAW3hf02KP8Q5JPP5kZfrY4NtQNObYB/eMKPpv5TJl8Fbh3+Gih2BDCNcI+e+8x+kau0SiNV9EgCnUDvjkxHxjSet/eY8p6vMuoSpuEgRy+BTM112tupfGVNoZslfEBxLGFYApIT0EqtyI9DjUJ7hJQW0v8XXFPJRqI318qlzqch9/CiLG23Vb13Spr2/FpVTHy0A4Xz8n57I07w3w1gz0980XK0DCsVaS5nvqx5A/4jexyedfJxMlCIPARPK09mml4Jgb+JHhHeVU5fes7+GgECQWEUFJJ8GEkun/ndVl4g==
Received: from CH0PR03CA0333.namprd03.prod.outlook.com (2603:10b6:610:11a::7)
 by DS1PR22MB5706.namprd22.prod.outlook.com (2603:10b6:8:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:13:46 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::8f) by CH0PR03CA0333.outlook.office365.com
 (2603:10b6:610:11a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 14:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:13:45 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 24354FB3EB;
 Thu,  5 Feb 2026 16:13:43 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>
Subject: [PATCH 3/5] pwm: pwm-imx: enable ipg or per clks only if CONFIG_CLK
 enabled
Date: Thu,  5 Feb 2026 16:13:29 +0200
Message-Id: <20260205141332.2515996-4-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
References: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|DS1PR22MB5706:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 62fb8fa1-378c-4d63-e74e-08de64c0c691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9gnHzfTiy4pzuuDIYG2wr8u0wnXUMEvCsyLiYnZBFSuPoGLxzoplPIGstwX6?=
 =?us-ascii?Q?SvSBfScd8u1/6OCZaMWjHUCp8BZR23EHVCFRATB1I0icP9UUTljXEzQ6ayDC?=
 =?us-ascii?Q?REZT/Cr7W2xDBfXC9XmhfD0x1OBOv17miawlWI+gcj3IPYaJ9EOb5DwD3YI6?=
 =?us-ascii?Q?8e6n9ZhsZ+tqXv7TawA1MGmJbVjVSdurNqjWuzqkygoQU6aNXROzZ/AQ3JDh?=
 =?us-ascii?Q?hN/iPPuSg8tVuicPc1gAj3hu9MDZsm1CEDUOMyT3qM3/2DYjUQOEFKDodHIv?=
 =?us-ascii?Q?51C2zn9PP7GfjEIClVAxJ2QOOltYQwS1+Y+vdJBzdLtV4iwvIXE6WWbXZm2d?=
 =?us-ascii?Q?LZ5GjnaNt1W1RYT5B3Y8EhWNNthHwo12G1SmXt4IJzVRmt/acEOQK7+eVaQj?=
 =?us-ascii?Q?KO6erIM6XK1nZL6IYL86DQgKSSEyK7Vhk6aZcO3NFuo90aveRUU0f0FSctF4?=
 =?us-ascii?Q?mqneAtuvO7Nalao+37YM+sDSa9r5QQjjPlnxzs1qzF9e21eeRbc9BHdVQYL0?=
 =?us-ascii?Q?v+0sjbK7oeHcPttTSnEos6lxoaWPyxbNsgWDjaIwTG4+dkufBa3oO7vk+et1?=
 =?us-ascii?Q?w3kuQfMYYYpgiAfUfN3JZdg++e9isJRs4+yKzFl9Dtifimc6HMTGbZ3lJ0X4?=
 =?us-ascii?Q?jQXtCyUONRco4YDw1PqqF4LeR4PO+MPGVafeaiUMFkM0Q/eII0tCiOc5gDTC?=
 =?us-ascii?Q?hjodoH+pNlUCKOuSm3tn6sQEMLcBtV/O9i2N5h+vERyr+HEpmaD37h+eQWYA?=
 =?us-ascii?Q?hDMQPtlDfp85t/Ocyb/TYh8TKylVomedUn5fmXZoDJh2GfeoSW3cs4kBe0g8?=
 =?us-ascii?Q?bNGSMJVmQXQCG4IrNUDpKqOjQNlkDbiN+u/eWP1Nu2gqiMjni8gH5aNm8/N1?=
 =?us-ascii?Q?MZHrm7eizhlNSn3xGlgjuUGwvEpCkA0aPHC90ik1+l+Y7BnnQAB/EeJUqO7p?=
 =?us-ascii?Q?ZYSJdW2M3KyGONp3MIdOreVB5SLN01017qzWAO1mU3UsYwhwV83x9GomQm89?=
 =?us-ascii?Q?5DDJo8E59+jLR+2jXxD426zK0oyiDYeMDDAXLeD4/TK1XUPmIa7Xz1PkdEHQ?=
 =?us-ascii?Q?CnGSqzNfRZLMUKPS6dMe1Z+U9qNO5DoHiFjqKtbfJ8nwv4a1ZAPPg+M7WwZc?=
 =?us-ascii?Q?8PlcWHX6ihTzaq2nqAO8MLJ+sWpBlr12L244xofELyjzbASwjyJit/4jGfg4?=
 =?us-ascii?Q?9nleRisYtLnhtK758+fW/COsG+GJJV+igUc68pe2a8DBoQE8eHYXYvnan/GB?=
 =?us-ascii?Q?B2TD0fGiv0D6doT0qqRwXjpb5Rue6kNtdDcOJltpX5c2013bOiu4TW5tpum9?=
 =?us-ascii?Q?cZ8N6DIAz1B6MuWUfjp3sso+5uGCUrlHmm9t48ijGtj29bvwZSjpSEh1DMZ7?=
 =?us-ascii?Q?ZgBICpnP7Am1q6nVPQTtXQDwSeXAI7v2owfCG/pscEDkuf7vCUmG2RcJW1wL?=
 =?us-ascii?Q?t4SPJQx539QnMCFZe7OupMoFUDJIpOq20mdSIWrhk7Jif0QiBdtf3QgauvQW?=
 =?us-ascii?Q?rpl4mXzHvGoYtR28QaGJ1TG98siQ8ov/ig28W8Y435thbiyhqr2xIVmcIvvm?=
 =?us-ascii?Q?5+VJyhKi2AlE5a5Fv7bRICoDCgxSeuo+tf79kItbZPdo2nsBVWwGa+Ad5aMp?=
 =?us-ascii?Q?ANfwjJzhcKKQRUvm4hqUXPJpI3lucKcx3+lSISp6kHXes23U9jA2pBf/1G0b?=
 =?us-ascii?Q?DWGKLg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: X8al9BOOuhw6YItHarcI7fHpFpfwEP2xWrtDCthSHYq002KAnS8NdpLn6YIyauLsR4CcEqynxdpJ/imN/QPjsSrHaxRbIIQoEAsFHm/zoJOBhxGLboRe7grdZk+7u//SXVmFTuzOvys24SxYAhhonM7AjDuJXcm4oJ5RtpRk1mhNNk35KV42NFy7W6XeyUGOz7Pt55PBqfNeTDtTB8gGl9G3GTmvWk4cVvSxsZMUjfoViZdxxrm6cxnSshBCM2HMfHzs7f8SyRzkAziTA0fEHjUlzFnkvGGJGU0N+1RNJaFzdIZZ8O08H1eqawcF5px6j+1ey6kpQkwNACx5rV3jKrQ0xsxQjYxU4+DZxQa+tgbrXasDtnfWohKtZYoMlMBwF3ZFtcMmDFKalrvoeTf4i76gNTrwI2BdC5EZ5psaPULWEtD0UD/uOBSOW0tu72gQ
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:13:45.9622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62fb8fa1-378c-4d63-e74e-08de64c0c691
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR22MB5706
X-Mailman-Approved-At: Thu, 05 Feb 2026 16:34:47 +0100
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

This caused linker errors in cases where IPUv3 was enabled (which
defines its own clocks).

Fixes: bfc778cb93a ("driver: pwm: pwm-imx: get and enable per/ipg
                     clock using dm")
Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/pwm/pwm-imx.c | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index bb37b39fa0e..fc5d2a3e5e3 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -232,17 +232,19 @@ static int imx_pwm_of_to_plat(struct udevice *dev)
 
 	priv->regs = dev_read_addr_ptr(dev);
 
-	ret = clk_get_by_name(dev, "per", &priv->per_clk);
-	if (ret) {
-		printf("Failed to get per_clk\n");
-		return ret;
-	}
-
-	ret = clk_get_by_name(dev, "ipg", &priv->ipg_clk);
-	if (ret) {
-		printf("Failed to get ipg_clk\n");
-		return ret;
-	}
+        if (CONFIG_IS_ENABLED(CLK)) {
+                ret = clk_get_by_name(dev, "per", &priv->per_clk);
+                if (ret) {
+                        printf("Failed to get per_clk\n");
+                        return ret;
+                }
+
+                ret = clk_get_by_name(dev, "ipg", &priv->ipg_clk);
+                if (ret) {
+                        printf("Failed to get ipg_clk\n");
+                        return ret;
+                }
+        }
 
 	return 0;
 }
@@ -252,17 +254,19 @@ static int imx_pwm_probe(struct udevice *dev)
 	int ret;
 	struct imx_pwm_priv *priv = dev_get_priv(dev);
 
-	ret = clk_enable(&priv->per_clk);
-	if (ret) {
-		printf("Failed to enable per_clk\n");
-		return ret;
-	}
-
-	ret = clk_enable(&priv->ipg_clk);
-	if (ret) {
-		printf("Failed to enable ipg_clk\n");
-		return ret;
-	}
+        if (CONFIG_IS_ENABLED(CLK)) {
+                ret = clk_enable(&priv->per_clk);
+                if (ret) {
+                        printf("Failed to enable per_clk\n");
+                        return ret;
+                }
+
+                ret = clk_enable(&priv->ipg_clk);
+                if (ret) {
+                        printf("Failed to enable ipg_clk\n");
+                        return ret;
+                }
+        }
 
 	return 0;
 }
-- 
2.39.5

