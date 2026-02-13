Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72AEEDF160
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 13:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2122683CB5;
	Fri, 13 Feb 2026 14:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="E14oaSfV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAC3883DCA; Fri, 13 Feb 2026 09:50:12 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE13183AAB
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 09:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=beLpfixiSRhpTxrYMPmRuQCgREwzsYZFPYU/OCL3stN/lqO6L7qr4YtWo2y0LQy13cExNOLMZUDrvnt+IU92N9dLMxAHi4RVaUdKx9dxiRe4iwBXPyKUnNHkFJYKrSoWM5yHvyoD8y/xdK02e97RUHuYQDdb3I13TkIPmwf8U6EIEqLGpJO7fx3ily+UKMJhlW89fPSY8uu8+CvbwMtkv85lkYYKDPITpRpgI3gVli6UfsezfRw45sfqbPsjmx/+CD4M7BJCDRH3gtRGIyGI7MCs2iCfwj0Bqm3TuxsiI3MMsUY+12Lxs5Z7ttaU3mLvNt4sdBSNCacJaUOPJ3ehSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se8EnvWXNoMRImt3aCyFqkCEz+5s3ydWlU4kFxeSVdI=;
 b=rG+03/LwRfj8c0bcnF8jBWsDpnjq15IoeF9NlEtXFb5IlptJl7T0OynOPGM34kCjEDX5i9/Wr1Fq9FI4iLKt6FPl5DW4DJJEtTizEpbSJzNUdiVaryXzaRAtfgNsXMLk1vrWH2QCfI3IOUkry+Z01WjDWc8vdm3x3ITNjqLMzqEcw5ySEvRsO2TgxqQYXLUX1HW6m2KukXvLfx1zl6Xsms38mELDOowOYqFxalcD8LMjO1VU9BmWr2GLoPKLy9L3OqWj2yu7zXdZaY1yQOwej/wGZZtqPYVOY//JFQZVMLd5rnPkV4VtHpG65Cqz78uy5uy/0jfiorw9jlNw0mHD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se8EnvWXNoMRImt3aCyFqkCEz+5s3ydWlU4kFxeSVdI=;
 b=E14oaSfVveEW7qRwCmgLpMDrK2YiGRDvc1vNwFnVdXuINBz0xfFUEQAcQk/SiXmZj3LLDHte1bM0YcLlExEXV3Vm2yjPSkXeigRuWRtH5K2bhxM4uwHbs6dg+hPYjALRvf/i+Wg4QDA7nwQJZZLCYgPRHbyTLTof+IEcy8ExjUf9YfeLxjrQLxkU9Zjr/gh3wqFDO+1Qg99mPJh74fBAIhHhnBWv7C5nOhisbS5GTFLTVYngU1uaDFNZxN+6mCJu4a22Fsdj91fOcyq0oLuriEVK6LADTigM36uNabzbS/WfWLaGi5LC5PQvgne3LX2lvUecXdob7iacQssqQWTspA==
Received: from CH2PR15CA0008.namprd15.prod.outlook.com (2603:10b6:610:51::18)
 by DM4PR22MB3490.namprd22.prod.outlook.com (2603:10b6:8:41::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 08:50:06 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::55) by CH2PR15CA0008.outlook.office365.com
 (2603:10b6:610:51::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12 via Frontend
 Transport; Fri, 13 Feb 2026 08:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 08:50:06 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 8478DFD318;
 Fri, 13 Feb 2026 10:50:04 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>
Subject: [PATCH v3 4/6] pwm: pwm-imx: enable ipg or per clks only if
 CONFIG_CLK enabled
Date: Fri, 13 Feb 2026 10:49:53 +0200
Message-Id: <20260213084956.1031000-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
References: <"aYtUi1WdLPLEnv2X@zoo11.em.health.ge.com">
 <20260213084956.1031000-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|DM4PR22MB3490:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2aebd8f9-24ae-4aa4-1e57-08de6adce2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nLT6Xa8TA+qGiHU9lx7n/wDoDrdkxDFN8muM/RPXkeaKf0n6+NGOPu6DxQNg?=
 =?us-ascii?Q?tpcDJ+HTexjaauGfjTx8xcukbf9XYIx5FufyAz73zHFEgpZ24vSQ/vqqxBjv?=
 =?us-ascii?Q?BIntERfk/56RjHeKFwx8G5cClppGMMld/imqkxPFmS6Av5a9WL/YLy6Qtj9Y?=
 =?us-ascii?Q?vMAczt3w7UoV8T4G+dyR6jtcQ+9urXdaT/jy2JrbZGGBJ3ZNcYdlOuAsA2xR?=
 =?us-ascii?Q?TZvdXE0+3EhhJuk61rTGVn4CVE051ZrODpN6toqLvj/36aP2p0fbZWw8o4cE?=
 =?us-ascii?Q?lYlJtIUV3HzK0v1cV4H7EkMIM7ltr7z0sUqvybojoA67nihc+bigYXXCawoA?=
 =?us-ascii?Q?d47w3Jr/QX4ZcRz6xijTgpcGtK1IyZz12ZGIWXG6R/3kjENLavBCS/Pzyg39?=
 =?us-ascii?Q?j7kGRcP0LR+6Un9V/V+CbwqbUuWXHKCWoj9einxUE4r0iy8pvW2xkXLE+Kc+?=
 =?us-ascii?Q?4QOUUQGaVRVpCdUuXfPdoP/jtNhn3MsApqGzxa2wCTYn/4NmzKTNjSpg4g5Z?=
 =?us-ascii?Q?2om3+x0n715/AWdHozy7Tm9d7FBRQ6mzq6Jpd7sbzarV8hjopj8c5H8benhj?=
 =?us-ascii?Q?3/4oiXt8sihIpNNKyegxMLotaS4l+BXl/TGY28UuiuBlIFviVIbRf5qtshK4?=
 =?us-ascii?Q?GR26dt8eywArib5xJDzhhs02x493zXAyVeSLyt63sPZTjx1V64AgsPhH7leE?=
 =?us-ascii?Q?+zr2CYwITx8kO9ETR4iWPR/LSLyxwtN23UjNECY4QS5JhTqlHCmmoo2wzkOx?=
 =?us-ascii?Q?Tj0cyMdnzcBYyLlmQXuOVss1HEq6gPfwLfqbI4HifnYcWQkEbXHCdfoV10kd?=
 =?us-ascii?Q?R9HSRJ93XOkEbfox2woFji/tr5ifbk3e2CZsyI2yHqXgKD1/1p04yDlbxW47?=
 =?us-ascii?Q?sNKcMEa/W12mLJMrrK/bliF235lQj7+JRiI6uSnb0n9rfSBP+Fd4lQ+xWcgt?=
 =?us-ascii?Q?WCnR0CGJAIUpWGG9Al8Lyj6dLK2v1RZUVcQSzFwmO7vgIqKfwpB9OA9Zi6zp?=
 =?us-ascii?Q?QivCodc9vaTD7C7EA4NIWkAkpjDb1JU2bcvq0pAiR0QPYJh3Lu6oxN45H8tR?=
 =?us-ascii?Q?8/mqDt29LvPXNo71coMu+P6NhO8g4vnbGYB35eFK9tk8Oo3iZMhhyxJtgT7p?=
 =?us-ascii?Q?DuJkX1vxUt5WvMzJEOMCmMfDVvgWlKIsiXefX1TwQvoZKQkkBiXoT6sNfcEL?=
 =?us-ascii?Q?aXQ/JUC8qteQUtEl+BImVIahpaXOcpUnZ2f0oa4XurThUEPnN/nUD6LUoWyo?=
 =?us-ascii?Q?mZSZiLFIACIETGW6wLXLdq8EdBk7ZLM082w4JkXikj3GfwKn4SXZOdjQ4Fw5?=
 =?us-ascii?Q?nkp6elbYcS7fa9XQY8ZWK0lEDDwcJ0qNI80OS1We0Kf/GOkHHYxaXsQgCSFj?=
 =?us-ascii?Q?fn9p6m+ZUHoia/UR59J73Kq4D4cO1U3Y4kZPS8sKCsgL0r1fU0XclXZyzqdD?=
 =?us-ascii?Q?nYCS8lSX7TgfU3gzu+wmKsEZH0P2dpjLLdZ+gR1I3oCgA0G9TjJQ4xjyEOxQ?=
 =?us-ascii?Q?Ncbzznb5/sAxNw1tR7z/ZtdQnNM1RmPVAdM/a9oEJb+L0yYAmOsH7uBHZTj4?=
 =?us-ascii?Q?oubAzvexsigb95mYdEZPEUPROWhYHUuNjsSYMfpKnmKklVj0eSShWXLKuZVF?=
 =?us-ascii?Q?mNtWNxLTtnLQVFGiBLIedMt6O0Qrm0dpqv1RZ67HcXfNuaZksCjQ+Uk9O0to?=
 =?us-ascii?Q?J1OzAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7q+fl19MDsEGG4dXBwZKgink2mepNghK0d46LRjK5iCMtoDtXrYyG58zJ9u1VS5VNj4LUI9+LkEzwo7ZLxjVfmG93z8DtHzZTLXORLcrFu5v0pzlKvPAwV41jPW2V3rEq6065KjQRHvj7/736AYiPPM+8hQ+Xagwn1FAUQCbleKluYwNhWpTnklX4KZWwpSpWNb6cK1hGysn5j+dyZ07/LWNEaDIqgJoH9oHbfP9TFcmVJzTk7cj1aZOG/vo23HZhc2XwoNkhM9XYNwfuhb5LbSihNLNP8pnnfdJ2yZWLj8zWv5wdmBeOjkQX4laEzTJaMo5KqVUdAOYxukq2SkQFspiUJMVtzIryJHz4qLHrUEufgD+DBB3lBOhIBthux1A+CFViY1kSSge0bXrHSBbu+3bs7EB4zKLpeTIdYz35PBRikClV7QdknCI8KgA5HE6
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 08:50:06.4485 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aebd8f9-24ae-4aa4-1e57-08de6adce2ec
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR22MB3490
X-Mailman-Approved-At: Fri, 13 Feb 2026 14:24:08 +0100
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

(no changes since v1)

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

