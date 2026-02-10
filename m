Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0450EA8109
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 12:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4184983D77;
	Tue, 10 Feb 2026 13:42:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="AyN00ha8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A33848388D; Tue, 10 Feb 2026 10:00:57 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AB583CBD
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 10:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSaTNB4A9X53wWv0vdWy7s0w51E2rGCvxi3OahCfwEqnA4PpDcT+yVTWPRYhO9/x+Dg5DDyXLSjJp8HPThf8rAGZ23B8vBWId6wQLhBJd91qjV56VhQkcFkMTKwsAESxsKuOpwnXbSr6drPvTpRogCvptWvc4NCwpnEVqH5egvn2eAhTCLak9yMGG48W2hOJ9/2svp3ImIbBHhwzfqLnBg8bQPg1fnGn6D1MX+SvaaZyhROPenMuzWre3DzO1swGVVOl8FA00NLdVU7nrlRXfiEp2mekGPWdaQP9ae9M1Qz0WntY6d7+X9D44zqVMofPPpSzl6lV28tcHragLeHikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se8EnvWXNoMRImt3aCyFqkCEz+5s3ydWlU4kFxeSVdI=;
 b=cXdFxYJw0wCgMOp87jgawJrvIJg7CKSXBEAwd9y6d2aE9ogy5RQOJXKycMS/5lcXSDj4sBi8sA0YiMqxxv9gr6cXDHqPtX9FZIz4UOL1XmxRX6ZGwzdAD3kOsHyHGsFsmXzZIL7KWOpcOhXBTb8a6+iwFY4/gwxPXus7vJ9BZQSxplwfQV5xkYRtSiNCYlZtw/l4eEV0obM5LPkhmdgBUyFY0kjzPED9K7+VVMHPGJliTaddptRXRWv4jQmA5zzTuO9ukVjW2QDOXIuA7LGJYXoZLLwugxBQ6bSqCEVwwwT91ZCrkhrS2YnwV6VXhI2OvwUNQFcGoh4NKjoZxeXf2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se8EnvWXNoMRImt3aCyFqkCEz+5s3ydWlU4kFxeSVdI=;
 b=AyN00ha8fzPtSp7qGhU4AldJHXwhsYIIPhHSLu9Hwqi7Q+RLX7bNIlfTkHPXszHNcppYCvDqNqA6EZSb0B45lzrfywANnfFghHsLvLU6rN9l5e+t1x4vN2OxN27yagjSKwWZmPV6UtnczWGtNwfzbhfzOQ6d33qQwD2xZlJnhxn1ZbhNLW2xkT5cygm7pEplMYf22XK9rpL0bWEuKL3BM7KIo8GPRG5JfqxFl2YFYroJxV9I0qfUS4IMrfmAXYhhOjXD/CNvkELwROW7zaLN6/UZKmnCvGhVk8BpbXhV0DwjCmvenY6F3t32kO2GluS4VzygN55bt33isazMgueGXg==
Received: from BL1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:208:256::29)
 by BL1PR22MB3683.namprd22.prod.outlook.com (2603:10b6:208:396::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:00:49 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::ec) by BL1PR13CA0024.outlook.office365.com
 (2603:10b6:208:256::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Tue,
 10 Feb 2026 09:00:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 09:00:48 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id DFEC0FD2FD;
 Tue, 10 Feb 2026 11:00:46 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>
Subject: [PATCH v2 4/6] pwm: pwm-imx: enable ipg or per clks only if
 CONFIG_CLK enabled
Date: Tue, 10 Feb 2026 11:00:26 +0200
Message-Id: <20260210090029.728636-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260210090029.728636-1-brian.ruley@gehealthcare.com>
References: <"20260205141332.2515996-6-brian.ruley@gehealthcare.com">
 <20260210090029.728636-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|BL1PR22MB3683:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35e54326-d209-49a3-a8bf-08de6882e2ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HfBEYQnol6FYtNrpDoJ9iGu3ksraHBnjyQMea3nxZWo1ZmbrvAHVQln3hq4l?=
 =?us-ascii?Q?UH2aq3crcsF8W5ESvjIg04NrWWqLPEsEZPqtW6IjizAaQouPnfU45EnsoIbr?=
 =?us-ascii?Q?20ZrKPNYt8UH+fJ+Vgj2bA840IhlXyxnHYU47xVbWC4EvxYoQ2oqVjO0oJVO?=
 =?us-ascii?Q?+93VnvLOorWoRK8+u/tiLLCr2FEaGRaeCs/IAlZQaTmdjr7EfcvZecUheUPA?=
 =?us-ascii?Q?ePB7AdfHe/0hrCZdJmHr2ub12UpDFoDrELURTYqM13T4g+2mAD+zPW9D4z6H?=
 =?us-ascii?Q?1IYohRiz8s4Z9C2i5IDYUD4sXhXUFWwApqKsjH5O4uQr7pcQpqaFX2AQwXei?=
 =?us-ascii?Q?9WrLDtYUuDmPELJ3lSA84mZC1cG4y2UoZdCheIw37h1PDkhpR7xf9N5S3KJs?=
 =?us-ascii?Q?gwUSHCf11HSaog3XvZQC3JpFjOf7FU/BzEXvkcoVkSQOKBmapMrw63BLw6VI?=
 =?us-ascii?Q?MfCr9b1kvJGhrf9qFntdQJnsNEmtUvBN2TwvuGsL8Fe/hMkQOZEx99Xedvtk?=
 =?us-ascii?Q?eBThp88owlLQWGZ5Kw0In1f69iN/noKE+HjUEcRVwvhmgUiuBVkV3kzn3KOF?=
 =?us-ascii?Q?i/gu7QwEiSaW2ZnKHyMfV2CRHP1aDXe7oQQXqVa95G0M+XaDNlb9wds2bTLo?=
 =?us-ascii?Q?b112foGf0CNuPP/7pUrdjBnvYtovKQjzbW3wFpodSOtyfycqSEVtTc1L+TZX?=
 =?us-ascii?Q?qsf+shQMwaLSL/TUHbIPR3Q4dygN3lyoGF780GsAcg4ZCDSwa1h/uHOhXvJO?=
 =?us-ascii?Q?fwsn/B6OuP/SO+IBjZTdwZR/sYr5/Rht4Lf+WAfTko9I07gJWsbIBDpqWy6e?=
 =?us-ascii?Q?OQ/8DQFWl/F4CKA1yzA8YjbEKUIj83Xe5e4pHX6Dg1PC1vl71amV3Dao6ZLy?=
 =?us-ascii?Q?8RwoHBTceXu3WrcMIUOyyGxWjfhYszMvIFo8cSjyKuDeIkPm3yB+DK830AXU?=
 =?us-ascii?Q?SuI3hdRNICY+uAZbPLVN6/yrrinJHUYaVR1hIAzkVZ4SnXLIBY2gl0DpashT?=
 =?us-ascii?Q?+DPna1csNdLCKE0nTGrYgBfxjmJU0A57rv1bPxdG2e1Cr1hjw9auuWs+Tajy?=
 =?us-ascii?Q?wRsGOlkA6zLERr9kvdBpOLMfvHG1541TK0Kyg05kzwD6TqJfb3KcfZdikdgr?=
 =?us-ascii?Q?tDbTXJyyF1koKL8yuHLbYIIOq445FhxZpWkZCJ4HZluVMDoeF/X/+ta0SLtP?=
 =?us-ascii?Q?xUAGMihC70bAkvCq45k7acca60+eXCuWhFYLgDKRnYwoXVvqGQdJXo9x4kyo?=
 =?us-ascii?Q?+p8clBBdggoz6C0dZXmmYhK14T7QPRqhw1z3g+V8wiz4v6kc58L1jG6can33?=
 =?us-ascii?Q?EQ6qQaBV5vWEGFwTGtlRuG56CGfGpMhzN7LbW/VGDGw+jkPox9ZNkVvCQzeT?=
 =?us-ascii?Q?MihTICc7IVwpeCF2vlfMhBBY24euhbCAqhv+i8WtITIDEeuR0qscIGshgbfp?=
 =?us-ascii?Q?ySdbje7nsBHD5HXVc46y5Ir2CfuE1pW1mFVuPN61iSUkyExL5TD3JKsFCXb7?=
 =?us-ascii?Q?PuEhiA01pqIkuTx+aCdpOYMU1XE52o59T6F4BI4jr2yhflkvh94IhiO51mJL?=
 =?us-ascii?Q?9SJXjkBAs5fQMftOLS1yhtjtYUgPLUPpZp6r0p6WNGFPM3n9J4CKIGGXw6d0?=
 =?us-ascii?Q?C3LYXQ6FnjjXdoga6k+xZXZO9cIcFlHOAjWNyfT6fW2Bpi+QklHX1MAUUo5i?=
 =?us-ascii?Q?6JisIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b5aOGRtF2EC9sJjGEM0uAJQbNlUffZRyr2NaomDrXlFlN7rOmeLzw+0XXc8unhT7ltYZmckm1B4kr/49qwVFHGzLaQ/O5qaezNfcfeuRVyE6rLF9Vs/C79wZDqq5Sd8YXS3EUtIAnXFH8O3KIyEkdPSMAdWvsprHpBhze17j1XDUzBgmvUfxwBzKiXgnW2bv8TB7ftwBw4EzpR66bXIEQdmMkJRa+o2YApSChFTIcyONGushs7ZmmLLV28RBpUburtMi2uq0pRp6JcccO/v0gDe1Ydf9uYIOwVeXnXmwE3hI87M4BZymwW+KIpXX07k5LkqJqDB6DNkoOx1KiOyUYSipTJgPNdpARCTGZMCyTaB2IikNw7/IBo3yrrs5Cxj5wKdh+jSn8YCDNPtUaer1NTouJ0TkkuLvajZHrFiLHYyDYqELyAAe59ocJhEUtRWz
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 09:00:48.9653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e54326-d209-49a3-a8bf-08de6882e2ae
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR22MB3683
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

