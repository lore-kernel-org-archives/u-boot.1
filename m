Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D21E99062
	for <u-boot@archiver.kernel.org>; Fri, 10 Apr 2026 09:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14FED841D5;
	Fri, 10 Apr 2026 11:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0r/So4CZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D7DA83DC9; Fri, 10 Apr 2026 11:30:58 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C935B83DC9
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 11:30:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xdv94A/xfarS+bmd3fxQhjb71ZSn5fs1hoA7HQg21KMyFKnPlzg0bjWGq/dpM5j9+Vn1knKqh8y8/S1fn00yTlxSoe+bHcA6dHEE4j+LtoXjJxW3nKGRUgB8fXbR93iMLA8KvVQAe6Ir0VSLEUWANqq++qY0TMLBZzqNuZ7itDMfDh/SQNu6waQLhbylUwT1MQdk33I6KerWiuIH8qf22Dqdth1ZsDcgII1JZja3Xu6dmCCAAsxD6QVjw1Bqyrssar8M45qeNpWTGizQNG+6lc8jBMcBOPkMXShnXYZO4BjBGqdR/LZkiDFgHxPN5Dl7kqU1Jh4E8YzM6WO52sxiRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t091eMGxSdlXkCQO+cmty16hUAyI4DS2EKl9wPxT+gU=;
 b=sLdIGMLGBmzihjM+7Jw1q4hWyNceTX/rSsIBwfn5Gz+ifC0tgyo3mqfajU7y4+EuGaCOqiMNeHLHmg3YKyshNkllgVfHhjJLi3eV9W8Psz1D91ke6xzJiOCObGJGYl7bpEsL+RYJ29sYZNKTvgvxMyieO3hyDqLOeLY9hdEba7MJNkLRY5lQKBOl4MBuQWcqmWn3Ya4djo4ELFvRQ9TY6+swF8U81rkPqt7OloKkJ8z1Y7lEuRe0QDB/yGADb2UrRjYuWNXOoKLI9pkVn6UCBUrxln+4OGePT/dpR6wH9lCSTbbyDsLQREbUCjo/fbl+mCTxFiUiHa4eythkO1r51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t091eMGxSdlXkCQO+cmty16hUAyI4DS2EKl9wPxT+gU=;
 b=0r/So4CZPhoE1O6zVlH/lS6reGTMH/YS+xzbe49nNPoR4FY418Jz5t+5Od9QeOXxBPvWjALLbdnPuPMe8T3Kikn5ikuUf9euQOd4SjNvcUl3f7iSZ6T036nhXkM4/k95N6ujbFqhwqoahHGFhJTsabnPqcU1sbqsp/xGljZXh28=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Fri, 10 Apr
 2026 09:30:48 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:8:2a:cafe::c4) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.45 via Frontend Transport; Fri,
 10 Apr 2026 09:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 10 Apr 2026 09:30:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 04:30:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Apr
 2026 04:30:33 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 10 Apr 2026 04:30:32 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>
Subject: [PATCH 3/3] net: zynq_gem: reinitialize RX BDs on every init
Date: Fri, 10 Apr 2026 15:00:18 +0530
Message-ID: <20260410093018.1461732-4-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
References: <20260410093018.1461732-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0a22c0-7cab-47d5-d4d6-08de96e3d97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qNXW080N6LQFA4hfqX9GNprmmJg+KtvYpRzDdXcl5DiG+jopFNkUG+JsiaS/GeyIhPPpxcWrpTF2u7fau/jl3a5CdE/n5Vtas8Wm4MTeFhWcRkBhWm5yFBe1LCfW6Li5K/aD/FV04dG9y9JXWY9bXS9JF1evEWO5tDXe68RjOLnbGOQk2VrpB47B90A+K1jM7rSpFweiU5XUm6LaUG1Qkt4JrmIrc9lyCacN6kj6Ci+lhxaL9VnYnDYeQvPGqyMRn2U6TYYhZgAROwgZxm9mb0M+ScDFTYDV0eyAkYS5wjszqO8ucKjYrA4m9hkMQUnI5UnpXEOhiHfa5JnY/kQPXojc8GIxGOJzdJkOjXTDya/e6tlp6dKbu31Garc7K3fntEZ9m0Q7w88+3lnM5LirVBL/DctaeN4OqFC9+G7p3sHj28mZSZHht+FWeUfnd0mB+BrmREm5CwxnfHGq5xUHDxVfNzO2DtWFi8IwWlDI+chaJoEQz1WbXpp4HfrWuU/YMgTDRBf559hJ73iRZsPKoTR2xD1vSqrDdamVR3TrxejTFzTEnhLpuBT7a2dIksxMG9p59MQL1bKIL66Zl/aOe2vpOxwHTL/0N3sACJpo+Ree6w+wnnmlIAou/we/NirGRh3AnRi6T19qX4qhuNzaKIjjLxETfve/SnYKr8VCD2gEaf3HpWgRbLAptdvQyKRKQ3V8FaUbwDziJRgh/HtEUTZy2RO4aqPwdBNJT2vAoR3b28CZpCf8lecALwgQ0Os4KTBk3EuzRA8M4VF98VZf9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s6XkgqjBRyIL3DpayniVn7G2vGr+sEz2LbboW67jbDXNBtPhp0SyMlqDfUdwrba1G0DIuPRBceUVs8JwF62lUkCMvcSvgMqn376x2/HjfQbUTlmz7OhqkWDfrjr2/Xmzb2sn1U7G6df73G5rEeqHQ/nPPEI0Tqz0SxX2rkupoq2FkdC3RcD/b+osBIJ+yEXWyGdIpiBHtJAkZg+D3+p3hLa0xtVI+RXausrsSHbZKrHK4UZZw30WrWeNYmzh8Q2fyesWWctq4i5fJ95PBDyKnbfOhuOAQmtDQlu9vEJupXjllu5lbnA23yuZYnnVP8qwhKmf0vO5cL8q2Dy59Mx8G2V0CooXrqCakuYkWpSV6C18utR8FPEx/HHYis6Tib/Qf1TMHuyXHZJUgFcsqyoZagjM1q7fitj4pQayukOq+FD10qxNlGklZgy3wzlHxUN7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 09:30:48.3173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0a22c0-7cab-47d5-d4d6-08de96e3d97a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
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

Reinitialize RX BDs and rewrite rxqbase on every init instead of only
on the first init. This ensures a clean BD state on every init for all
GEM configurations.
For AMD Versal Gen 2 10GBE this is required since the USX block
resets the RX DMA pointer to rxqbase on each init, so BDs must be
rebuilt each time to stay in sync with hardware.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/net/zynq_gem.c | 51 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index e9210d42438..e3f9fd72d2f 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -474,28 +474,6 @@ static int zynq_gem_init(struct udevice *dev)
 		for (i = 0; i < STAT_SIZE; i++)
 			readl(&regs->stat[i]);
 
-		/* Setup RxBD space */
-		memset(priv->rx_bd, 0, RX_BUF * sizeof(struct emac_bd));
-
-		for (i = 0; i < RX_BUF; i++) {
-			priv->rx_bd[i].status = 0xF0000000;
-			priv->rx_bd[i].addr =
-					(lower_32_bits((ulong)(priv->rxbuffers)
-							+ (i * PKTSIZE_ALIGN)));
-#if defined(CONFIG_PHYS_64BIT)
-			priv->rx_bd[i].addr_hi =
-					(upper_32_bits((ulong)(priv->rxbuffers)
-							+ (i * PKTSIZE_ALIGN)));
-#endif
-	}
-		/* WRAP bit to last BD */
-		priv->rx_bd[--i].addr |= ZYNQ_GEM_RXBUF_WRAP_MASK;
-		/* Write RxBDs to IP */
-		writel(lower_32_bits((ulong)priv->rx_bd), &regs->rxqbase);
-#if defined(CONFIG_PHYS_64BIT)
-		writel(upper_32_bits((ulong)priv->rx_bd), &regs->upper_rxqbase);
-#endif
-
 		/* Setup for DMA Configuration register */
 		writel(ZYNQ_GEM_DMACR_INIT, &regs->dmacr);
 
@@ -524,6 +502,35 @@ static int zynq_gem_init(struct udevice *dev)
 		priv->init++;
 	}
 
+	/*
+	 * Reinitialize RX BDs on every init. The 10GBE USX block asserts
+	 * RX_SYNC_RESET during setup which resets the GEM RX DMA pointer
+	 * back to rxqbase, so BDs and rxqbase must be refreshed each time
+	 * to keep the hardware and driver ring indices in sync.
+	 */
+	priv->rxbd_current = 0;
+	priv->rx_first_buf = 0;
+	memset(priv->rx_bd, 0, RX_BUF * sizeof(struct emac_bd));
+	for (i = 0; i < RX_BUF; i++) {
+		priv->rx_bd[i].status = 0xF0000000;
+		priv->rx_bd[i].addr =
+				(lower_32_bits((ulong)(priv->rxbuffers)
+						+ (i * PKTSIZE_ALIGN)));
+#if defined(CONFIG_PHYS_64BIT)
+		priv->rx_bd[i].addr_hi =
+				(upper_32_bits((ulong)(priv->rxbuffers)
+						+ (i * PKTSIZE_ALIGN)));
+#endif
+	}
+	/* WRAP bit to last BD */
+	priv->rx_bd[--i].addr |= ZYNQ_GEM_RXBUF_WRAP_MASK;
+
+	/* Write RxBDs to IP */
+	writel(lower_32_bits((ulong)priv->rx_bd), &regs->rxqbase);
+#if defined(CONFIG_PHYS_64BIT)
+	writel(upper_32_bits((ulong)priv->rx_bd), &regs->upper_rxqbase);
+#endif
+
 	ret = phy_startup(priv->phydev);
 	if (ret)
 		return ret;
-- 
2.43.0

