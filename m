Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F7BECD980
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:35:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBF4883C39;
	Thu,  5 Feb 2026 16:34:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="pyt3y0rm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E1958341A; Thu,  5 Feb 2026 15:13:54 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C52CE83693
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 15:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3HZebLT+Qycs0r43poUmML6DvSTNh03PUpYy+p7DnKkrlt4rz/9m4xIoZ1dhuSt8zWpKfeRK9SD/SE9QuMl3osF1tMGaMYpntvqt11PwEd6ltSTCX98O5LvFnMoEpepPVylyUWSSgtyV0v0FlUlqbX8WzHipTnixxRKKpdJCy6uKZaoHBTGIFpSznR3U79vMrJi/2ud+PsQxzeI2gxF6BmPVasvU1fc4xiQGb6wDYyFJv5Wj07+ZU+zLG4CVJuWZM4ensX+tZCFe1B+XG3Iaf8A/wkvISkU3umjk+wGK0W9q07zcU91rdGkSxlZBWQjqH9fdh9MFrc/oxfIIX7Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbhlkvszX2nf+5uCX2GVKF/s9Ls9UJLxwGh8PnmpYeQ=;
 b=LKfB417QlRX/5hGn37/B/nO6lHeslM+gf8gIJRpEtSdN62fSq4mUlzTfD+1SY/OSkx/Ew9Vc0tKFuUEknDpS0InJnm7DVuhxsWnO0NMBrSoJJW6m1ylBNVgorTRMgjp7YOSaFxzuWrGwkj+D6wn6L2N8ScMqmliUMMC3jryjXaaun8A5jYJZJSNm/VYz1u1sv4lPqUISlh0ET8TAF7fCBWgnvHGSvb/OIHwckn/BIOVwmSMbTk3m1tNnfGhD0w3d55oMPBijYJ7ovt8U/2GThU/QxcaSC2zcxy2KX5gxcX+7V+EHy/f5XIl+5NxCtbyf73yojQA4/iA2hd+s47gfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbhlkvszX2nf+5uCX2GVKF/s9Ls9UJLxwGh8PnmpYeQ=;
 b=pyt3y0rmM9KXXUlJJUbJNNk7zmTIh36y72XA5zhy1tbhAl0IMyL932q1iL/sfmqYfkRL0d0zY97M/Q4TLBWRBKGPPGXlBGjYvzXofhTHPSILmW9k+wTQ8b7ek5L/wJKMagZAlNpJTlQgMoQSgDt05CI6MteWlBmgQMbHBUFhV+RrRTMBmnSJEwX8Fd5FYQ/hs9KDLBv606oQt12RqRl4ffplYHdCuTAAPgczR98vwne8h3m9yS2t2L1O50DWEyV/xUXwCSUkB6y6SmGfgtDI2Sf6kBdYDh7N1PSVwd8JOmMoOaiJyMW2lM5tleaGfuTcfWEM4XvTZ78Ygxt0hPuBsg==
Received: from PH8PR21CA0018.namprd21.prod.outlook.com (2603:10b6:510:2ce::8)
 by LV3PR22MB4848.namprd22.prod.outlook.com (2603:10b6:408:1de::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:13:47 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2ce:cafe::c) by PH8PR21CA0018.outlook.office365.com
 (2603:10b6:510:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 14:13:50 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay2.compute.ge-healthcare.net;
Received: from mkerelay2.compute.ge-healthcare.net (165.85.157.49) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 5 Feb 2026 14:13:46 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id DFF22FD2F6;
 Thu,  5 Feb 2026 16:13:43 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@nabladev.com>
Subject: [PATCH 4/5] video: imx: ipuv3: move clock code to legacy
Date: Thu,  5 Feb 2026 16:13:30 +0200
Message-Id: <20260205141332.2515996-5-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
References: <20260205141332.2515996-1-brian.ruley@gehealthcare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|LV3PR22MB4848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 50c0e648-8fdc-4d95-d16e-08de64c0c6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zjx6bRxpi4/vT4ibUrwi4ehiqUBAcBkTC2uWediswYxa2skjvRCgJ93rGvu+?=
 =?us-ascii?Q?kVt5muUMsZafywNmXiGxvWjV4GzcYLWUDsfv70NTFvQVXGp6ai9tex1NwCjj?=
 =?us-ascii?Q?EwqSKdAGioTTycSm3yP+0jrmP0bG2sXwojCPDWwpxWY68xJQXdXr9miXvqYy?=
 =?us-ascii?Q?VKI5Kde7Q50yBY/JlAgrsLe2dPCKCEhAGr1x8MzZPrJLsDTDTG6uoqhjIMhM?=
 =?us-ascii?Q?c/2++3Npzn2tbm3ZOJB0qtewAKU5FUWAcJiuI1euMRAxVEIl0rk8gdbvW7xw?=
 =?us-ascii?Q?yQiULtBDBl6iN4W8y7bMB+GMXcQF70mQbKc7vDs9u67o1q1YEjrRjOjcVf4I?=
 =?us-ascii?Q?WmYcsztr4V0tuwFPvHpFrfDU3usyvFp7O7SHS1214uToMM8cexN5BYgHpMXA?=
 =?us-ascii?Q?kTzVKDdJxzf5bmZFlIov4wLRcijIL1N92ZkN1KZ6215xfGvLUloiOpZThwfW?=
 =?us-ascii?Q?3H5g9iSkGRYpwOvzDp3OtUbMfAkc6zfwoStOa+t2iDFyH4OJdByz++faSlZC?=
 =?us-ascii?Q?uSJowXPYqExLqm2BrJfDtXo3pWqdJQq2ckwI4rOARVeYz/4L1nGYtJgm6hGX?=
 =?us-ascii?Q?CqLSbIWcLMQceXYnR45JLzxZA8wwCHShOzm2fYlPv1+aaLR9PwrOGAijnXci?=
 =?us-ascii?Q?bh3XxYpW/LZo07VN+vMOtojUYtGjNt+5cf681f/frd46brcI07uViNbs0duP?=
 =?us-ascii?Q?9vZgqTUaVGiyH0aC4yId3hsXrlXvsQL52aVW9wRphqdlJPRMyEDj6uMGxbNH?=
 =?us-ascii?Q?AKrVsJTZpT6bvPqdvcFZUx8Y7s9vUgNMrx5TuM/goqv+YgJZMkTVQ13m5whj?=
 =?us-ascii?Q?twyTMgnNtzA+a3ZVu2Tfmd0EvAezzZJFJPdFwxWDcI6sikDIgkaE90vNXbHN?=
 =?us-ascii?Q?SqXPargDEzJq0fIalZsMZjgfl25uVsbMud8cyaVcnNZ3CGDo8+ACZSpt/WQu?=
 =?us-ascii?Q?aByY2sCjbJulAPgo7ZUlQ7PZxNZw6o0C1kpVIERahSTdg9tnj+CV0mzeWk2P?=
 =?us-ascii?Q?zlVvEkym12KAMycTciTXEDik8FpW5w7tN3nCkYUJzihsG1ScrOb4LgeKOWg3?=
 =?us-ascii?Q?7c/ql7sjwKirXJNPAclUr40Dep+7WFNcgj0c3BIO87IPjJwCqLrwBOe+rgja?=
 =?us-ascii?Q?BF8FhKyvck2rzu0Y6ltoBa2/ygnnWJxzMVxgHdx5C0AhPyNDfKL6QlWsW9DS?=
 =?us-ascii?Q?XOTNRrT2EOZflf69kFRfoP0MfGuIPoCgaMYjb08028IpW6dBHwxoEq17vFt9?=
 =?us-ascii?Q?jqPp2Qt6O5+Kl0rHNBb5Du8EbVk2dfvIsEUBoL2lLjHYnw3ib3NIYLeU18/X?=
 =?us-ascii?Q?YHBwYTwUdKJgfpDkPvcqoovEszVXPjpKWUMhD/bVg5P+XAIVJjA5i1MMdPv0?=
 =?us-ascii?Q?/22fe4Gq+ZFvMPlPGdd/LfsEgwAXLlBtLxuFAm2PkBYlk3BBrao+0QIy+IKi?=
 =?us-ascii?Q?CgzcUCDGv7KKex87X7YVb5cfISp67mXSmpkxitLPW8oubwL9k17gdb8EuDj/?=
 =?us-ascii?Q?cF912jZYO3bqMmLQMxgy/Jk9Y1J/GQKuV0C8n64fyqJmxt4mlVQDrTeNhqx4?=
 =?us-ascii?Q?kbOWSUGsl71PfLGeqp5QuaWK1V3FFwIz52BptwnrD8nQGOZQCNwYI3suV2Ct?=
 =?us-ascii?Q?H2XjUwLvZUUjW2xJOYs+LJSFbnOhYOPXLssfAI+otJHtFM0IMsCp73DLc/6V?=
 =?us-ascii?Q?sUvXKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay2.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3G+kOvU0AXyFNYfTYrzstI+JtsJCrPbd3vB4UATf8o1PqgWmrECF0cZBe8BBkSqNXqXjNG66yZ175J0QiGfzaivWunxP8ZM8PWq0Q4P2nqwxw2k3H/4dVO04k0pxoqBmIWjFN9Hp1ezTyRJDA4gueHxnA3Rmq+EKarhUVAr6+mZm3yfTyoQ6y9RK3zx5Xg+x+hmr1buu7P1dcxbdU/9768Y7G7ebfjtcK1zX+haCapQPWOOYH2Vwutrctro5u2Vn0fwRexZ5ohjxH0MWOFFCUZwbpc0c0Lp6vtozNlw/hhtjC59J0Qgb6a6OM5xa7dA57Cz6pXfFKyrqtp9CDiES2MqEZvlvgmVb6eDbZCDnJO0nyOflcwnl5B5vKZd+VduegqThdQZMqgEj4j32C1B0hQSmKaQU6W7VqfpdO7qGxJ8kc4qcpbSS/aa05HGcjCL7
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:13:46.4022 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c0e648-8fdc-4d95-d16e-08de64c0c6df
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB4848
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

In preparation for CCF migration for IPUv3 separate existing clock code
to legacy files. These will be used by i.MX5 that currently does not
support the CCF. No functional change.

Signed-off-by: Brian Ruley <brian.ruley@gehealthcare.com>
---

 drivers/video/imx/Kconfig          |   7 +
 drivers/video/imx/Makefile         |   1 +
 drivers/video/imx/ipu.h            |  60 +++++-
 drivers/video/imx/ipu_clk_legacy.c | 310 +++++++++++++++++++++++++++
 drivers/video/imx/ipu_common.c     | 322 +----------------------------
 5 files changed, 376 insertions(+), 324 deletions(-)
 create mode 100644 drivers/video/imx/ipu_clk_legacy.c

diff --git a/drivers/video/imx/Kconfig b/drivers/video/imx/Kconfig
index b35ba965efc..c25f209629e 100644
--- a/drivers/video/imx/Kconfig
+++ b/drivers/video/imx/Kconfig
@@ -15,6 +15,13 @@ config IMX_HDMI
 	bool "Enable HDMI support in IPUv3"
 	depends on VIDEO_IPUV3
 
+config IPU_CLK_LEGACY
+	bool "Use legacy clock management for IPU"
+	depends on VIDEO_IPUV3 && !CLK
+	default y
+	help
+	 Use legacy clock management instead of Common Clock Framework.
+
 config IMX_LDB
 	bool "Freescale i.MX8MP LDB bridge"
 	depends on VIDEO_BRIDGE
diff --git a/drivers/video/imx/Makefile b/drivers/video/imx/Makefile
index 1edf5a6bdf0..0e7f71a9f93 100644
--- a/drivers/video/imx/Makefile
+++ b/drivers/video/imx/Makefile
@@ -4,5 +4,6 @@
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
 obj-$(CONFIG_VIDEO_IPUV3) += mxc_ipuv3_fb.o ipu_common.o ipu_disp.o
+obj-$(CONFIG_IPU_CLK_LEGACY) += ipu_clk_legacy.o
 obj-$(CONFIG_IMX_LDB) += ldb.o
 obj-$(CONFIG_IMX_LCDIF) += lcdif.o
diff --git a/drivers/video/imx/ipu.h b/drivers/video/imx/ipu.h
index 62827dc480d..ae40e20bc28 100644
--- a/drivers/video/imx/ipu.h
+++ b/drivers/video/imx/ipu.h
@@ -18,14 +18,23 @@
 #ifndef __ASM_ARCH_IPU_H__
 #define __ASM_ARCH_IPU_H__
 
+#if !CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
+#include <clk.h>
+#endif
 #include <ipu_pixfmt.h>
 #include <linux/types.h>
 
+#define IPUV3_CLK_MX51 133000000
+#define IPUV3_CLK_MX53 200000000
+#define IPUV3_CLK_MX6Q 264000000
+#define IPUV3_CLK_MX6DL 198000000
+
 #define IDMA_CHAN_INVALID 0xFF
 #define HIGH_RESOLUTION_WIDTH 1024
 
 struct ipu_ctx;
-struct ipu_di_config;
+
+#if CONFIG_IS_ENABLED(IPU_CLK_LEGACY)
 
 struct clk {
 	const char *name;
@@ -75,6 +84,46 @@ struct clk {
 	int (*set_parent)(struct clk *clk, struct clk *parent);
 };
 
+/* Legacy clock API functions */
+void clk_enable(struct clk *clk);
+void clk_disable(struct clk *clk);
+int clk_get_usecount(struct clk *clk);
+u32 clk_get_rate(struct clk *clk);
+struct clk *clk_get_parent(struct clk *clk);
+int clk_set_rate(struct clk *clk, unsigned long rate);
+long clk_round_rate(struct clk *clk, unsigned long rate);
+int clk_set_parent(struct clk *clk, struct clk *parent);
+
+/* IPU clock initialization */
+int ipu_clk_init_legacy(struct ipu_ctx *ctx);
+int ipu_ldb_clk_init_legacy(struct ipu_ctx *ctx);
+int ipu_pixel_clk_init_legacy(struct ipu_ctx *ctx, int id);
+
+#else
+
+static inline int clk_get_usecount(struct clk *clk)
+{
+        return clk->enable_count;
+}
+
+/* Stub functions for non-legacy builds */
+static inline int ipu_clk_init_legacy(struct ipu_ctx *ctx)
+{
+	return -ENOSYS;
+}
+
+static inline int ipu_ldb_clk_init_legacy(struct ipu_ctx *ctx)
+{
+	return -ENOSYS;
+}
+
+static inline int ipu_pixel_clk_init_legacy(struct ipu_ctx *ctx, int id)
+{
+	return -ENOSYS;
+}
+
+#endif /* CONFIG_IS_ENABLED(IPU_CLK_LEGACY) */
+
 struct udevice;
 
 /*
@@ -298,15 +347,6 @@ int32_t ipu_disp_set_color_key(ipu_channel_t channel, unsigned char enable,
 
 u32 bytes_per_pixel(u32 fmt);
 
-void clk_enable(struct clk *clk);
-void clk_disable(struct clk *clk);
-u32 clk_get_rate(struct clk *clk);
-int clk_set_rate(struct clk *clk, unsigned long rate);
-long clk_round_rate(struct clk *clk, unsigned long rate);
-int clk_set_parent(struct clk *clk, struct clk *parent);
-int clk_get_usecount(struct clk *clk);
-struct clk *clk_get_parent(struct clk *clk);
-
 void ipu_dump_registers(void);
 struct ipu_ctx *ipu_probe(struct udevice *dev);
 bool ipu_clk_enabled(struct ipu_ctx *ctx);
diff --git a/drivers/video/imx/ipu_clk_legacy.c b/drivers/video/imx/ipu_clk_legacy.c
new file mode 100644
index 00000000000..8aaafa2a080
--- /dev/null
+++ b/drivers/video/imx/ipu_clk_legacy.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Legacy IPU clock management for i.MX5/6 without Common Clock Framework
+ *
+ * (C) Copyright 2026
+ * Brian Ruley, GE HealthCare, brian.ruley@gehealthcare.com
+ */
+
+#include "ipu.h"
+#include "ipu_regs.h"
+#include <asm/arch/crm_regs.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/io.h>
+#include <div64.h>
+#include <dm/devres.h>
+#include <linux/err.h>
+#include <log.h>
+
+extern struct mxc_ccm_reg *mxc_ccm;
+
+void clk_enable(struct clk *clk)
+{
+	if (clk) {
+		if (clk->usecount++ == 0)
+			clk->enable(clk);
+	}
+}
+
+void clk_disable(struct clk *clk)
+{
+	if (clk) {
+		if (!(--clk->usecount)) {
+			if (clk->disable)
+				clk->disable(clk);
+		}
+	}
+}
+
+int clk_get_usecount(struct clk *clk)
+{
+	if (clk == NULL)
+		return 0;
+
+	return clk->usecount;
+}
+
+u32 clk_get_rate(struct clk *clk)
+{
+	if (!clk)
+		return 0;
+
+	return clk->rate;
+}
+
+struct clk *clk_get_parent(struct clk *clk)
+{
+	if (!clk)
+		return 0;
+
+	return clk->parent;
+}
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	if (!clk)
+		return 0;
+
+	if (clk->set_rate)
+		clk->set_rate(clk, rate);
+
+	return clk->rate;
+}
+
+long clk_round_rate(struct clk *clk, unsigned long rate)
+{
+	if (clk == NULL || !clk->round_rate)
+		return 0;
+
+	return clk->round_rate(clk, rate);
+}
+
+int clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	clk->parent = parent;
+	if (clk->set_parent)
+		return clk->set_parent(clk, parent);
+	return 0;
+}
+
+static int clk_ipu_enable(struct clk *clk)
+{
+	u32 reg;
+
+	reg = __raw_readl(clk->enable_reg);
+	reg |= MXC_CCM_CCGR_CG_MASK << clk->enable_shift;
+	__raw_writel(reg, clk->enable_reg);
+
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
+	reg = __raw_readl(&mxc_ccm->ccdr);
+	reg &= ~MXC_CCM_CCDR_IPU_HS_MASK;
+	__raw_writel(reg, &mxc_ccm->ccdr);
+
+	reg = __raw_readl(&mxc_ccm->clpcr);
+	reg &= ~MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
+	__raw_writel(reg, &mxc_ccm->clpcr);
+#endif
+	return 0;
+}
+
+static void clk_ipu_disable(struct clk *clk)
+{
+	u32 reg;
+
+	reg = __raw_readl(clk->enable_reg);
+	reg &= ~(MXC_CCM_CCGR_CG_MASK << clk->enable_shift);
+	__raw_writel(reg, clk->enable_reg);
+
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
+	reg = __raw_readl(&mxc_ccm->ccdr);
+	reg |= MXC_CCM_CCDR_IPU_HS_MASK;
+	__raw_writel(reg, &mxc_ccm->ccdr);
+
+	reg = __raw_readl(&mxc_ccm->clpcr);
+	reg |= MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
+	__raw_writel(reg, &mxc_ccm->clpcr);
+#endif
+}
+
+static void ipu_pixel_clk_recalc(struct clk *clk)
+{
+	u32 div;
+	u64 final_rate = (unsigned long long)clk->parent->rate * 16;
+
+	div = __raw_readl(DI_BS_CLKGEN0(clk->id));
+	debug("read BS_CLKGEN0 div:%d, final_rate:%lld, prate:%ld\n", div,
+	      final_rate, clk->parent->rate);
+
+	clk->rate = 0;
+	if (div != 0) {
+		do_div(final_rate, div);
+		clk->rate = final_rate;
+	}
+}
+
+static unsigned long ipu_pixel_clk_round_rate(struct clk *clk,
+					      unsigned long rate)
+{
+	u64 div, final_rate;
+	u32 remainder;
+	u64 parent_rate = (unsigned long long)clk->parent->rate * 16;
+
+	div = parent_rate;
+	remainder = do_div(div, rate);
+	if (remainder > (rate / 2))
+		div++;
+	if (div < 0x10)
+		div = 0x10;
+	if (div & ~0xFEF)
+		div &= 0xFF8;
+	else {
+		if ((div & 0xC) == 0xC) {
+			div += 0x10;
+			div &= ~0xF;
+		}
+	}
+	final_rate = parent_rate;
+	do_div(final_rate, div);
+
+	return final_rate;
+}
+
+static int ipu_pixel_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	u64 div, parent_rate;
+	u32 remainder;
+
+	parent_rate = (unsigned long long)clk->parent->rate * 16;
+	div = parent_rate;
+	remainder = do_div(div, rate);
+	if (remainder > (rate / 2))
+		div++;
+
+	if ((div & 0xC) == 0xC) {
+		div += 0x10;
+		div &= ~0xF;
+	}
+	if (div > 0x1000)
+		debug("Overflow, DI_BS_CLKGEN0 div:0x%x\n", (u32)div);
+
+	__raw_writel(div, DI_BS_CLKGEN0(clk->id));
+	__raw_writel((div / 16) << 16, DI_BS_CLKGEN1(clk->id));
+
+	do_div(parent_rate, div);
+	clk->rate = parent_rate;
+
+	return 0;
+}
+
+static int ipu_pixel_clk_enable(struct clk *clk)
+{
+	u32 disp_gen = __raw_readl(IPU_DISP_GEN);
+	disp_gen |= clk->id ? DI1_COUNTER_RELEASE : DI0_COUNTER_RELEASE;
+	__raw_writel(disp_gen, IPU_DISP_GEN);
+
+	return 0;
+}
+
+static void ipu_pixel_clk_disable(struct clk *clk)
+{
+	u32 disp_gen = __raw_readl(IPU_DISP_GEN);
+	disp_gen &= clk->id ? ~DI1_COUNTER_RELEASE : ~DI0_COUNTER_RELEASE;
+	__raw_writel(disp_gen, IPU_DISP_GEN);
+}
+
+static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
+{
+	u32 di_gen = __raw_readl(DI_GENERAL(clk->id));
+	struct ipu_ctx *ctx = clk->ctx;
+
+	if (parent == ctx->ipu_clk)
+		di_gen &= ~DI_GEN_DI_CLK_EXT;
+	else if (!IS_ERR(ctx->di_clk[clk->id]) && parent == ctx->ldb_clk)
+		di_gen |= DI_GEN_DI_CLK_EXT;
+	else
+		return -EINVAL;
+
+	__raw_writel(di_gen, DI_GENERAL(clk->id));
+	ipu_pixel_clk_recalc(clk);
+	return 0;
+}
+
+int ipu_pixel_clk_init_legacy(struct ipu_ctx *ctx, int id)
+{
+	struct clk *pixel_clk;
+
+	pixel_clk = devm_kzalloc(ctx->dev, sizeof(*pixel_clk), GFP_KERNEL);
+	if (!pixel_clk)
+		return -ENOMEM;
+
+	pixel_clk->name = "pixel_clk";
+	pixel_clk->id = id;
+	pixel_clk->ctx = ctx;
+	pixel_clk->recalc = ipu_pixel_clk_recalc;
+	pixel_clk->set_rate = ipu_pixel_clk_set_rate;
+	pixel_clk->round_rate = ipu_pixel_clk_round_rate;
+	pixel_clk->set_parent = ipu_pixel_clk_set_parent;
+	pixel_clk->enable = ipu_pixel_clk_enable;
+	pixel_clk->disable = ipu_pixel_clk_disable;
+	pixel_clk->usecount = 0;
+
+	ctx->pixel_clk[id] = pixel_clk;
+	return 0;
+}
+
+int ipu_clk_init_legacy(struct ipu_ctx *ctx)
+{
+	struct clk *ipu_clk;
+
+	ipu_clk = devm_kzalloc(ctx->dev, sizeof(*ipu_clk), GFP_KERNEL);
+	if (!ipu_clk)
+		return -ENOMEM;
+
+	ipu_clk->name = "ipu_clk";
+	ipu_clk->ctx = ctx;
+#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
+	ipu_clk->enable_reg =
+		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5));
+	ipu_clk->enable_shift = MXC_CCM_CCGR5_IPU_OFFSET;
+#else
+	ipu_clk->enable_reg =
+		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR3));
+	ipu_clk->enable_shift = MXC_CCM_CCGR3_IPU1_IPU_DI0_OFFSET;
+#endif
+
+	ipu_clk->enable = clk_ipu_enable;
+	ipu_clk->disable = clk_ipu_disable;
+	ipu_clk->usecount = 0;
+
+#if CONFIG_IS_ENABLED(MX51)
+	ipu_clk->rate = IPUV3_CLK_MX51;
+#elif CONFIG_IS_ENABLED(MX53)
+	ipu_clk->rate = IPUV3_CLK_MX53;
+#else
+	ipu_clk->rate = is_mx6sdl() ? IPUV3_CLK_MX6DL : IPUV3_CLK_MX6Q;
+#endif
+
+	ctx->ipu_clk = ipu_clk;
+	return 0;
+}
+
+#if !defined CFG_SYS_LDB_CLOCK
+#define CFG_SYS_LDB_CLOCK 65000000
+#endif
+
+int ipu_ldb_clk_init_legacy(struct ipu_ctx *ctx)
+{
+	struct clk *ldb_clk;
+
+	ldb_clk = devm_kzalloc(ctx->dev, sizeof(*ldb_clk), GFP_KERNEL);
+	if (!ldb_clk)
+		return -ENOMEM;
+
+	ldb_clk->name = "ldb_clk";
+	ldb_clk->ctx = ctx;
+	ldb_clk->rate = CFG_SYS_LDB_CLOCK;
+	ldb_clk->usecount = 0;
+
+	ctx->ldb_clk = ldb_clk;
+	return 0;
+}
diff --git a/drivers/video/imx/ipu_common.c b/drivers/video/imx/ipu_common.c
index e9897ee79d2..d994053394f 100644
--- a/drivers/video/imx/ipu_common.c
+++ b/drivers/video/imx/ipu_common.c
@@ -31,8 +31,8 @@
 #include <linux/types.h>
 #include <log.h>
 
-extern struct mxc_ccm_reg *mxc_ccm;
-extern u32 *ipu_cpmem_base;
+u32 *ipu_cpmem_base;
+u32 *ipu_dc_tmpl_reg;
 
 struct ipu_ch_param_word {
 	u32 data[5];
@@ -92,126 +92,6 @@ struct ipu_ch_param {
 
 #define IPU_SW_RST_TOUT_USEC (10000)
 
-#define IPUV3_CLK_MX51 133000000
-#define IPUV3_CLK_MX53 200000000
-#define IPUV3_CLK_MX6Q 264000000
-#define IPUV3_CLK_MX6DL 198000000
-
-void clk_enable(struct clk *clk)
-{
-	if (clk) {
-		if (clk->usecount++ == 0)
-			clk->enable(clk);
-	}
-}
-
-void clk_disable(struct clk *clk)
-{
-	if (clk) {
-		if (!(--clk->usecount)) {
-			if (clk->disable)
-				clk->disable(clk);
-		}
-	}
-}
-
-int clk_get_usecount(struct clk *clk)
-{
-	if (clk == NULL)
-		return 0;
-
-	return clk->usecount;
-}
-
-u32 clk_get_rate(struct clk *clk)
-{
-	if (!clk)
-		return 0;
-
-	return clk->rate;
-}
-
-struct clk *clk_get_parent(struct clk *clk)
-{
-	if (!clk)
-		return 0;
-
-	return clk->parent;
-}
-
-int clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	if (!clk)
-		return 0;
-
-	if (clk->set_rate)
-		clk->set_rate(clk, rate);
-
-	return clk->rate;
-}
-
-long clk_round_rate(struct clk *clk, unsigned long rate)
-{
-	if (clk == NULL || !clk->round_rate)
-		return 0;
-
-	return clk->round_rate(clk, rate);
-}
-
-int clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	clk->parent = parent;
-	if (clk->set_parent)
-		return clk->set_parent(clk, parent);
-	return 0;
-}
-
-static int clk_ipu_enable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg |= MXC_CCM_CCGR_CG_MASK << clk->enable_shift;
-	__raw_writel(reg, clk->enable_reg);
-
-#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
-	/* Handshake with IPU when certain clock rates are changed. */
-	reg = __raw_readl(&mxc_ccm->ccdr);
-	reg &= ~MXC_CCM_CCDR_IPU_HS_MASK;
-	__raw_writel(reg, &mxc_ccm->ccdr);
-
-	/* Handshake with IPU when LPM is entered as its enabled. */
-	reg = __raw_readl(&mxc_ccm->clpcr);
-	reg &= ~MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
-	__raw_writel(reg, &mxc_ccm->clpcr);
-#endif
-	return 0;
-}
-
-static void clk_ipu_disable(struct clk *clk)
-{
-	u32 reg;
-
-	reg = __raw_readl(clk->enable_reg);
-	reg &= ~(MXC_CCM_CCGR_CG_MASK << clk->enable_shift);
-	__raw_writel(reg, clk->enable_reg);
-
-#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
-	/*
-	 * No handshake with IPU whe dividers are changed
-	 * as its not enabled.
-	 */
-	reg = __raw_readl(&mxc_ccm->ccdr);
-	reg |= MXC_CCM_CCDR_IPU_HS_MASK;
-	__raw_writel(reg, &mxc_ccm->ccdr);
-
-	/* No handshake with IPU when LPM is entered as its not enabled. */
-	reg = __raw_readl(&mxc_ccm->clpcr);
-	reg |= MXC_CCM_CLPCR_BYPASS_IPU_LPM_HS;
-	__raw_writel(reg, &mxc_ccm->clpcr);
-#endif
-}
-
 /*
  * Function to initialize the ipu clock
  *
@@ -221,43 +101,8 @@ static void clk_ipu_disable(struct clk *clk)
  */
 static int ipu_clk_init(struct ipu_ctx *ctx)
 {
-	struct clk *ipu_clk;
-
-	ipu_clk = devm_kzalloc(ctx->dev, sizeof(*ipu_clk), GFP_KERNEL);
-	if (!ipu_clk)
-		return -ENOMEM;
-
-	ipu_clk->name = "ipu_clk";
-	ipu_clk->ctx = ctx;
-#if CONFIG_IS_ENABLED(MX51) || CONFIG_IS_ENABLED(MX53)
-	ipu_clk->enable_reg =
-		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR5));
-	ipu_clk->enable_shift = MXC_CCM_CCGR5_IPU_OFFSET;
-#else
-	ipu_clk->enable_reg =
-		(u32 *)(CCM_BASE_ADDR + offsetof(struct mxc_ccm_reg, CCGR3));
-	ipu_clk->enable_shift = MXC_CCM_CCGR3_IPU1_IPU_DI0_OFFSET;
-#endif
-
-	ipu_clk->enable = clk_ipu_enable;
-	ipu_clk->disable = clk_ipu_disable;
-	ipu_clk->usecount = 0;
-
-#if CONFIG_IS_ENABLED(MX51)
-	ipu_clk->rate = IPUV3_CLK_MX51;
-#elif CONFIG_IS_ENABLED(MX53)
-	ipu_clk->rate = IPUV3_CLK_MX53;
-#else
-	ipu_clk->rate = is_mx6sdl() ? IPUV3_CLK_MX6DL : IPUV3_CLK_MX6Q;
-#endif
-
-	ctx->ipu_clk = ipu_clk;
-	return 0;
-};
-
-#if !defined CFG_SYS_LDB_CLOCK
-#define CFG_SYS_LDB_CLOCK 65000000
-#endif
+	return ipu_clk_init_legacy(ctx);
+}
 
 /*
  * Function to initialize the ldb dummy clock
@@ -268,23 +113,8 @@ static int ipu_clk_init(struct ipu_ctx *ctx)
  */
 static int ipu_ldb_clk_init(struct ipu_ctx *ctx)
 {
-	struct clk *ldb_clk;
-
-	ldb_clk = devm_kzalloc(ctx->dev, sizeof(*ldb_clk), GFP_KERNEL);
-	if (!ldb_clk)
-		return -ENOMEM;
-
-	ldb_clk->name = "ldb_clk";
-	ldb_clk->ctx = ctx;
-	ldb_clk->rate = CFG_SYS_LDB_CLOCK;
-	ldb_clk->usecount = 0;
-
-	ctx->ldb_clk = ldb_clk;
-	return 0;
-};
-
-u32 *ipu_cpmem_base;
-u32 *ipu_dc_tmpl_reg;
+	return ipu_ldb_clk_init_legacy(ctx);
+}
 
 /* Static functions */
 
@@ -320,124 +150,6 @@ static inline void ipu_ch_param_set_buffer(u32 ch, int buf_num,
 #define idma_mask(ch) (idma_is_valid(ch) ? (1UL << (ch & 0x1F)) : 0)
 #define idma_is_set(reg, dma) (__raw_readl(reg(dma)) & idma_mask(dma))
 
-static void ipu_pixel_clk_recalc(struct clk *clk)
-{
-	u32 div;
-	u64 final_rate = (unsigned long long)clk->parent->rate * 16;
-
-	div = __raw_readl(DI_BS_CLKGEN0(clk->id));
-	debug("read BS_CLKGEN0 div:%d, final_rate:%lld, prate:%ld\n", div,
-	      final_rate, clk->parent->rate);
-
-	clk->rate = 0;
-	if (div != 0) {
-		do_div(final_rate, div);
-		clk->rate = final_rate;
-	}
-}
-
-static unsigned long ipu_pixel_clk_round_rate(struct clk *clk,
-					      unsigned long rate)
-{
-	u64 div, final_rate;
-	u32 remainder;
-	u64 parent_rate = (unsigned long long)clk->parent->rate * 16;
-
-	/*
-	 * Calculate divider
-	 * Fractional part is 4 bits,
-	 * so simply multiply by 2^4 to get fractional part.
-	 */
-	div = parent_rate;
-	remainder = do_div(div, rate);
-	/* Round the divider value */
-	if (remainder > (rate / 2))
-		div++;
-	if (div < 0x10) /* Min DI disp clock divider is 1 */
-		div = 0x10;
-	if (div & ~0xFEF)
-		div &= 0xFF8;
-	else {
-		/* Round up divider if it gets us closer to desired pix clk */
-		if ((div & 0xC) == 0xC) {
-			div += 0x10;
-			div &= ~0xF;
-		}
-	}
-	final_rate = parent_rate;
-	do_div(final_rate, div);
-
-	return final_rate;
-}
-
-static int ipu_pixel_clk_set_rate(struct clk *clk, unsigned long rate)
-{
-	u64 div, parent_rate;
-	u32 remainder;
-
-	parent_rate = (unsigned long long)clk->parent->rate * 16;
-	div = parent_rate;
-	remainder = do_div(div, rate);
-	/* Round the divider value */
-	if (remainder > (rate / 2))
-		div++;
-
-	/* Round up divider if it gets us closer to desired pix clk */
-	if ((div & 0xC) == 0xC) {
-		div += 0x10;
-		div &= ~0xF;
-	}
-	if (div > 0x1000)
-		debug("Overflow, DI_BS_CLKGEN0 div:0x%x\n", (u32)div);
-
-	__raw_writel(div, DI_BS_CLKGEN0(clk->id));
-
-	/*
-	 * Setup pixel clock timing
-	 * Down time is half of period
-	 */
-	__raw_writel((div / 16) << 16, DI_BS_CLKGEN1(clk->id));
-
-	do_div(parent_rate, div);
-
-	clk->rate = parent_rate;
-
-	return 0;
-}
-
-static int ipu_pixel_clk_enable(struct clk *clk)
-{
-	u32 disp_gen = __raw_readl(IPU_DISP_GEN);
-	disp_gen |= clk->id ? DI1_COUNTER_RELEASE : DI0_COUNTER_RELEASE;
-	__raw_writel(disp_gen, IPU_DISP_GEN);
-
-	return 0;
-}
-
-static void ipu_pixel_clk_disable(struct clk *clk)
-{
-	u32 disp_gen = __raw_readl(IPU_DISP_GEN);
-	disp_gen &= clk->id ? ~DI1_COUNTER_RELEASE : ~DI0_COUNTER_RELEASE;
-	__raw_writel(disp_gen, IPU_DISP_GEN);
-}
-
-static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
-{
-	u32 di_gen = __raw_readl(DI_GENERAL(clk->id));
-	struct ipu_ctx *ctx = clk->ctx;
-
-	if (parent == ctx->ipu_clk)
-		di_gen &= ~DI_GEN_DI_CLK_EXT;
-	else if (!IS_ERR(ctx->di_clk[clk->id]) && parent == ctx->ldb_clk)
-		di_gen |= DI_GEN_DI_CLK_EXT;
-	else
-		return -EINVAL;
-
-	__raw_writel(di_gen, DI_GENERAL(clk->id));
-	ipu_pixel_clk_recalc(clk);
-	return 0;
-}
-
 /*
  * Function to initialize the pixel clock
  *
@@ -447,26 +159,8 @@ static int ipu_pixel_clk_set_parent(struct clk *clk, struct clk *parent)
  */
 static int ipu_pixel_clk_init(struct ipu_ctx *ctx, int id)
 {
-	struct clk *pixel_clk;
-
-	pixel_clk = devm_kzalloc(ctx->dev, sizeof(*pixel_clk), GFP_KERNEL);
-	if (!pixel_clk)
-		return -ENOMEM;
-
-	pixel_clk->name = "pixel_clk";
-	pixel_clk->id = id;
-	pixel_clk->ctx = ctx;
-	pixel_clk->recalc = ipu_pixel_clk_recalc;
-	pixel_clk->set_rate = ipu_pixel_clk_set_rate;
-	pixel_clk->round_rate = ipu_pixel_clk_round_rate;
-	pixel_clk->set_parent = ipu_pixel_clk_set_parent;
-	pixel_clk->enable = ipu_pixel_clk_enable;
-	pixel_clk->disable = ipu_pixel_clk_disable;
-	pixel_clk->usecount = 0;
-
-	ctx->pixel_clk[id] = pixel_clk;
-	return 0;
-};
+	return ipu_pixel_clk_init_legacy(ctx, id);
+}
 
 /*
  * This function resets IPU
-- 
2.39.5

