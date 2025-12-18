Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083A1D6ACEE
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:14:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75E6983DFF;
	Thu, 18 Dec 2025 13:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="DtJs086o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE98D83D8A; Thu, 18 Dec 2025 09:33:42 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC1083CF3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAzPuK51fmTQK3ikWDu3dqdbaATdOAjNVCZvybY3PEA0vzzI9yEXKSi62s7376ZNhNhQIYAXrQKYXq2yftxXJvnmtyJJqKQVkwo0LeLG5Mkv9EyzIVWzUXINDWqQE5pFaigr32qX8ML7Z7T3vQfzKFjhNk/Ql40wO4wpDqp3oejtH899M6vHFPbtTq/aM/oI7ikTolNguxeraaysPUBahHjutJL4Ybid8KFfrZYhLnNqusKN5876wNheU6ZU9HN3tceQsrAWP8YCxXcUpoYgPyUTtF9HH0XF/hPMGw7iDOXwQsz/Eqpugd5DIkpnMloIWS8uyHwwxz17jRGokbp8YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ZddIdMzkIjoVazGUTXVBbWVJyO98Wm/X4uCISoxHg=;
 b=sfLNzbWtCCx1ubE9Xn1LAOH6b/pAR2ssFw6SdZ5//SS4YW3DhQXYpzTaLZbLF3P5aV49tHAAnkShy3Sb60fcIyUDlSQ7yq6ohXMdnmQ0IzPNs+BUIlsU3O2RHctlNikNj2mheXsXZ8VlBoFegqY/53pshC30XyfqywHi4zAy4EbEC6lG9ZHqLCtsz/RBrDvKW7cQpZywR+taIbD00F+zpyZq/5CmJagCPK6mFM7GSvZ3OdRYsvGK5kjYAP96SE+qdUBAIZ+ve1R00litjgWjlxA1fXxut2WMK6CsU1e0EorAlDV1y2gZU0ssPopkVcEQgPkH91Bvj09Eykjrcygbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ZddIdMzkIjoVazGUTXVBbWVJyO98Wm/X4uCISoxHg=;
 b=DtJs086oGYCr1yKyUaERixEqf0vb//DCTwFkQVcU7DsaLPMSW2LD1NbjrF8K69yAnX4EixXFimWcDd4aIVJW+nr4MENdKe6b3q53sVDT1Em/S9y/zZFWzAt6PZT352HGSO7Zwo6aDPOzAKxOVrZEgNf8bgQDUzQGfR8h88rsK5XINQKslTdLIOWP1tIOEHuQsAXnTNBHBu7y81wtZnDh97KDIRlKoZleTk4S1tOtxtPnp8YcXu2UBRXd4VwePK2Ive38VBVnl7rH+QGrB67Q3eJM0T41mWSodoxZI6BKHsOccNj5F0W/d4afCcNFE/0Khd24O7KHwDmV90POhHXYAg==
Received: from BYAPR06CA0059.namprd06.prod.outlook.com (2603:10b6:a03:14b::36)
 by BL1PPFA07C4456F.namprd22.prod.outlook.com
 (2603:10b6:20f:fc04::f3e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.7; Thu, 18 Dec
 2025 08:33:36 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:14b:cafe::7e) by BYAPR06CA0059.outlook.office365.com
 (2603:10b6:a03:14b::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Thu,
 18 Dec 2025 08:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Thu, 18 Dec 2025 08:33:35 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 475C8F2E64;
 Thu, 18 Dec 2025 10:33:32 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH v1 6/7] video: imx: ipuv3: use CONFIG_IS_ENABLED
Date: Thu, 18 Dec 2025 10:33:25 +0200
Message-Id: <20251218083326.644326-7-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
References: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|BL1PPFA07C4456F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 457a56fb-eb01-4ae6-e236-08de3e1022c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wfr6jVxVJdIHSWNLx4RvieWLINg2YLwc9pwSp3KsxVTsR0g41W4q1LQN+Sdd?=
 =?us-ascii?Q?ybBM4Llh2J/ULxx2jRVJCGuEAL1y64YXUl38M2A105P1leVqJpGUu2Vg27yG?=
 =?us-ascii?Q?p6DWYs61ft8exPLJP7jq3Qn2DuQZlFbAIb8skL+0KhzonCeSO6ano3QJds6P?=
 =?us-ascii?Q?KLyj5ZyIExBimItF1tvKI3oRlDrfhzaZE7tpg6bknCwmJC/olZZXMxvn36Fb?=
 =?us-ascii?Q?MAwIFqw6gNoWvUc4KOqrjFno3TbmpSc58yFpVsz+wJwd89iNK+hcnMTwJkdX?=
 =?us-ascii?Q?cjhXl64jNkxFtkIWotKXTTAlhe8YZ6fggIyUj+zecqEYJfIxGuJuy9KkBtHx?=
 =?us-ascii?Q?2Ix8P5Z1J/1zAdxTUG/5D0jLklkPZvWuyYmMeVuQq1Y3/71KjpYG+SMgXyST?=
 =?us-ascii?Q?C6T1RHZU6EAmSWltbWuPu2sjUy2infhM9t/SF9Di6fyr6xjfDRZIHoXg2jLc?=
 =?us-ascii?Q?KYWGeUXq1Nn1Xd+DCexDaNtkyonq7gbRAhA1uDrBVj9fO33ayY7O6KBy+U4N?=
 =?us-ascii?Q?HJa0pjdxzPcQ1nYUeRpWbmIofebSIVMMOTsuskgdbFzlPaLqjdUHMbI/iMdE?=
 =?us-ascii?Q?uzLwNk8+4CEsFZW852EHewUTgjZ/EGR3FedykTKcJrgQWWPq5Kd0vf3odWvG?=
 =?us-ascii?Q?lrhzd64vG1B09AxO4ujfT1U96GzjO/VSkPwgtPTL6r0cxEwahgr+0fquF+7Y?=
 =?us-ascii?Q?3us/x4pcBbonhqFxmuWoyACYV1MKw1H7W+M3+lbECRgJ2vCD0hbIvCXN2LR6?=
 =?us-ascii?Q?NQgrwuPp+iVwPnQCZIjOF59ahBh4fHj7vDkaWbmQZAInqUK6Nwrw4ozjf5ry?=
 =?us-ascii?Q?aMJmwePAqItRtKJkjVYCHfX6UriRAdYWBiHnttFbnNznZyVkI2aM3P6M+RvT?=
 =?us-ascii?Q?2JaI7CTVYI1xdAeOMrzvf+MNXJQSnXQAnN8Zg93YofgmQXV/wUoF63MJZKQr?=
 =?us-ascii?Q?1GdMWgz6xfEsuOl6U0ZBL2Lx9mm6i6m0bwKQYOL4yI/hMFnTkR9/V+thgrqV?=
 =?us-ascii?Q?ukNJuSpLndDJGe1XPjCAUE/l5C5mWL7I0oTVj41ljWhJKYDL10yrrqabzsAD?=
 =?us-ascii?Q?uQeEB2wbAg/frtkxTV+Hcc8Ojd+Jt1QHdpgmjiJIXfxkWjI1ewUUBM398NFa?=
 =?us-ascii?Q?zvUgbhRMSErh7vXMy1umXGphp1r27Vr26yznigwxHYteBbUsuBv6KdEGlGxn?=
 =?us-ascii?Q?6CnUbiSAg4ecLurZJFqAx2Vh8YVCQqkN54Wd5lr5TOw1MVxkWlDXHxH1jUnf?=
 =?us-ascii?Q?ZnBvitus2nVCT42nSOGCzPwzYmCeAgKOrvKiHQ803mT94hPjygTH6KFSLPuR?=
 =?us-ascii?Q?8HJgEPORrwU45wwvhP9NaPZRaEcYEED0DBTD+QxRgEvN0cnJj9Vc/jjx92ZD?=
 =?us-ascii?Q?ZcFMAOGEjNTVp79tL7Zb7iYekHCroKsQJtHi7piMIGhEMN1IOpIsSI/DhpBX?=
 =?us-ascii?Q?+eU3Ial8WVSNvhYAh85spvI3OuXAsp9d89oyAfRoor90o5wQqlPcWtYE4EFa?=
 =?us-ascii?Q?pYOXaEGN4+D8rnN0I5nue58dr3/rHsjsn0kjCHYYeUj5D8683K7qQGLkXvPP?=
 =?us-ascii?Q?XaA2sL8bBBC4BKYQXkI=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:35.3484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 457a56fb-eb01-4ae6-e236-08de3e1022c0
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PPFA07C4456F
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:44 +0100
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

Bring driver up-to-date with U-Boot conventions, but also takes into
account SPL and TPL, let compiler optimize while keeping code more
readable.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/ipu_common.c | 13 +++++++------
 drivers/video/imx/ipu_regs.h   |  4 ++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index 6ce44e42349..4ca81d48a5f 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -168,7 +168,7 @@ static int clk_ipu_enable(struct clk *clk)
 	reg |= MXC_CCM_CCGR_CG_MASK << clk->enable_shift;
 	__raw_writel(reg, clk->enable_reg);
 
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 	/* Handshake with IPU when certain clock rates are changed. */
 	reg = __raw_readl(&mxc_ccm->ccdr);
 	reg &= ~MXC_CCM_CCDR_IPU_HS_MASK;
@@ -190,7 +190,7 @@ static void clk_ipu_disable(struct clk *clk)
 	reg &= ~(MXC_CCM_CCGR_CG_MASK << clk->enable_shift);
 	__raw_writel(reg, clk->enable_reg);
 
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 	/*
 	 * No handshake with IPU whe dividers are changed
 	 * as its not enabled.
@@ -199,7 +199,7 @@ static void clk_ipu_disable(struct clk *clk)
 	reg |= MXC_CCM_CCDR_IPU_HS_MASK;
 	__raw_writel(reg, &mxc_ccm->ccdr);
 
-	/* No handshake with IPU when LPM is entered as its not enabled. */
+	/* No handshake with IPU when LPM is entered as its notenabled. */
 	reg = __raw_readl(&mxc_ccm->clpcr);
 	reg |= MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
 	__raw_writel(reg, &mxc_ccm->clpcr);
@@ -208,7 +208,7 @@ static void clk_ipu_disable(struct clk *clk)
 
 static struct clk ipu_clk = {
 	.name = "ipu_clk",
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 	.enable_reg =
 		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5)),
 	.enable_shift = MXC_CCM_CCGR5_IPU_OFFSET,
@@ -485,13 +485,14 @@ int ipu_probe(void)
 	g_pixel_clk[1] = &pixel_clk[1];
 
 	g_ipu_clk = &ipu_clk;
-#if defined(CONFIG_MX51)
+#if CONFIG_IS_ENABLED(MX51)
 	g_ipu_clk->rate = IPUV3_CLK_MX51;
-#elif defined(CONFIG_MX53)
+#elif CONFIG_IS_ENABLED(MX53)
 	g_ipu_clk->rate = IPUV3_CLK_MX53;
 #else
 	g_ipu_clk->rate = is_mx6sdl() ? IPUV3_CLK_MX6DL : IPUV3_CLK_MX6Q;
 #endif
+
 	debug("ipu_clk = %u\n", clk_get_rate(g_ipu_clk));
 	g_ldb_clk = &ldb_clk;
 	debug("ldb_clk = %u\n", clk_get_rate(g_ldb_clk));
diff --git a/drivers/video/imx/ipu_regs.h b/drivers/video/imx/ipu_regs.h
index 8e57a2add69..21bdff9363c 100644
--- a/drivers/video/imx/ipu_regs.h
+++ b/drivers/video/imx/ipu_regs.h
@@ -33,14 +33,14 @@
 #define IPU_DC_REG_BASE 0x00058000
 #define IPU_DMFC_REG_BASE 0x00060000
 #define IPU_VDI_REG_BASE 0x00680000
-#if defined(CONFIG_MX51) || defined(CONFIG_MX53)
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
 #define IPU_CPMEM_REG_BASE 0x01000000
 #define IPU_LUT_REG_BASE 0x01020000
 #define IPU_SRM_REG_BASE 0x01040000
 #define IPU_TPM_REG_BASE 0x01060000
 #define IPU_DC_TMPL_REG_BASE 0x01080000
 #define IPU_ISP_TBPR_REG_BASE 0x010C0000
-#elif defined(CONFIG_MX6)
+#elif CONFIG_IS_ENABLED(MX6)
 #define IPU_CPMEM_REG_BASE 0x00100000
 #define IPU_LUT_REG_BASE 0x00120000
 #define IPU_SRM_REG_BASE 0x00140000
-- 
2.39.5

