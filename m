Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13273CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:43:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A73784671;
	Wed, 13 May 2026 11:42:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xLM95WsD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 241A28341A; Wed, 13 May 2026 11:42:53 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B8DA8460E
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:42:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNdl8PGqcRydkXPL4SRdAmCo2j4yGT0hs/mAhlIPaMR70IHVvRNbaKMhWUOc3KJe+k7aBm5Yg/Ywk2KNkAKg9ICQyhTm2ET8u/pAHoCmf08P9xnPaKz9RE9j6lu6m6hLevGDEXt84cxKaE0qpfsUVHeH5a4bZDWGe7N4/heokzKbeTcqtY9JHfcb1smFvkA4EwL5U6qeKVk8Me/xyla8QUoqPBS8dQGxKlIHVfrkdEjsOFukOxgp58yp99H3dBFCy0paALTvRvb4vQi2mSfQrHCDjN1H5ITHEZgfdKaSUKiZ2hicCd+pHOE/aFK/ZfOg0hY/sox+vKmM6X4rHzjjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8FNvPtB/VdvreB2yhfBbe2AclBTutklWd5kDd3Cae4=;
 b=YmRT/1HPlAeWE+XZFLEcgj3NSL31ehU/pYPoKvfiSMZl58K3Lg2s2JE2cj/0mP6LAYGaeiNLENs+4khz8GRIfcRO5gQBeOGFHF3iuhh1dVm56Yl2LRbGD/bTf+G7dOk3IJVpgHbXXZF2EhYaDKS7iL0KC87m0Ky+MlvfAv7eEyeLi1+405vKURtdgm5E7tONtv4v4sJIk4JeY9+k8v4JeCaroAN7hLkUgg+cN+ArejBIedLJdcTIih/HOtNNInw/mwB9B9zAm56yTHSgeWPRB/1l16/xd8dJiONcjuLHz4AwFDVcgQhDJw2XubB7o+JHpH+1ejuitEJnEYCudFouKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8FNvPtB/VdvreB2yhfBbe2AclBTutklWd5kDd3Cae4=;
 b=xLM95WsDFZJEstWg3JPoN1OBhLZTdFQL1q4cHqIrHF7d5v/irScJX5YKSu9DnsolI1DR9nHxevb2jq5zK/tMMg2VTlvt9A7JhVMCeqlkub7MeFlUiYQ/7C6bY6Sa7WVsYyBc7WiGinFgfKEzSXZE/9cZLorMk+nLktGmVe2pN8s=
Received: from BN9PR03CA0357.namprd03.prod.outlook.com (2603:10b6:408:f6::32)
 by SJ2PR12MB9113.namprd12.prod.outlook.com (2603:10b6:a03:560::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:42:45 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::77) by BN9PR03CA0357.outlook.office365.com
 (2603:10b6:408:f6::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 09:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 09:42:44 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 04:42:43 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 04:42:43 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v3 5/5] reset: zynqmp: Implement rst_reset using
 PM_RESET_ACTION_PULSE
Date: Wed, 13 May 2026 11:42:10 +0200
Message-ID: <bcc96f82287a679e86745783479989acb8908da7.1778665323.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1778665323.git.michal.simek@amd.com>
References: <cover.1778665323.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lcdM9YtyBLlDQoE59m726Ju03m3PFEFYPGTOSMBSa34=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSxuJcfe7SvSOKMjn/TN2ufzw98jznKKoXYLPjy2XPFl
 ej57++f7ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJfHRg+F+s8n4B599+uZu5
 If/nWtzLyFZ9sGWbt2nRMSfHy3o1YisY/rveecHY1N05k1VvTcTNhg3pdzWmpiiGW+/I3vh1t1P
 IXx4A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SJ2PR12MB9113:EE_
X-MS-Office365-Filtering-Correlation-Id: 7467afcd-0dc9-496d-c882-08deb0d3fc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|22082099003|56012099003|18002099003|11063799003;
X-Microsoft-Antispam-Message-Info: Ghbpyyh2KS5RmEBCTvAm/pGgzYbcY3Bx+FmDtzrZ+KbAaJMz0HHF0TE/oFEv9JyrNJK5cAX2Fk9QJhs7n8tVvt0uYvG1ro8y67ozXz7lkADoM7oZX8vFalPxpk5OjrNBboTHlqYzBl5MGsmxzedksmpPhO1z0BQ78t0NiFk9Al5AWpw+KYE66ZYM8ipm+0LXI2zcoVubTHnuRNzlL8lVKjs0I15LHBg91B78vDzQpOQkq/X5L1Aqq3RORwq3Lz3uwurt+4HFEi7MymfqrpTdN3z8+e5M8NBfXbQGgX8Aldq/chE7lPy/btoScWyosqD8IgBsycIp/EiEiHloLlt2urlIiyyl7Au8X9671F8ApSOAvi0gztaGKrU9uCLSeKTANgzwCFHEvnN9Xg402V560azphS4Dh3UDcJqwjquZ6c82ibvf4stpimklChMQ9UZZ6Fh+YKCztuOVgQeG7G/7R4Lr1cwxfEO4q5MVVimFbhp25KXxeAyhQhxO1YS1VnLJgNbRAfI24jvXRUgyHJvTH24l1okjI2165HLkZLnG0X1fB96PAN4zf7sIPYuJ1K9tHYYyBWBPrfqahSk8ovV0e2r3Oh1ABLEk/joQtdNU6BUzjpayvcj2X0KgyguSJxYi/dMdY9rvr1bq1aycG3uLP5vJF8WUpI+oCmnVeEKz0xJhEoet+HC0orXiXRB2BhESe+8m1VFPle5lOTYAz5aETGoKXSr5x4RR8/1jaEW3nKk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(22082099003)(56012099003)(18002099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CNaawu+1eMBZqvGjg/SLwbranLexZSC+pJfveacvbkSZ2Sp2sLiWmg/yfVgbW0+9+11uQt/ZhUkuD4icLcWpgvTvZSK9ENSuGEoBKo/tzylJ5LJQWM/+/VqchC9L+JB2ynCrFuyWDLo5+ffVwXCJUILTQBb3kc9qKew5Wa6g3t0g1ZoiRcWMNg0yBwOLKsR+M/MvS8/TFzhcVDlv8QGIzx4Aa2otrBxRdasiuV6yJFJXxOn+YUVmrtF4eHbXifAYwEnxw3lzAk8u/T6TSlix6tPvWZvdcjR8tIcx/xMMxuGRbP06Nk4YdYKkG/q/uxgQKSNPrhH61S7gzxtxPUYrt24EsQMn0eZqGTonfFSiGpiABHI65onZqBpikESxBliTBwkMGStSCaYcKeYDNYLpMXS7JVpRn4qCLr5L/w5EIE+7qnj5NRVbFlqrZKXRWIas
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:42:44.9886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7467afcd-0dc9-496d-c882-08deb0d3fc46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9113
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

Implement the rst_reset operation in the ZynqMP reset driver to use
PM_RESET_ACTION_PULSE. This allows the reset controller to perform
a reset pulse in a single firmware call instead of separate assert
and deassert calls.

This matches the Linux kernel implementation of zynqmp_reset_reset().

Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/reset/reset-zynqmp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/reset/reset-zynqmp.c b/drivers/reset/reset-zynqmp.c
index d04e8eef3bb4..2b58f3a75b42 100644
--- a/drivers/reset/reset-zynqmp.c
+++ b/drivers/reset/reset-zynqmp.c
@@ -45,6 +45,16 @@ static int zynqmp_reset_deassert(struct reset_ctl *rst)
 				      PM_RESET_ACTION_RELEASE);
 }
 
+static int zynqmp_reset_reset(struct reset_ctl *rst, ulong delay_us)
+{
+	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
+
+	dev_dbg(rst->dev, "%s(rst=%p) (id=%lu)\n", __func__, rst, rst->id);
+
+	return zynqmp_pm_reset_assert(priv->reset_id + rst->id,
+				      PM_RESET_ACTION_PULSE);
+}
+
 static int zynqmp_reset_request(struct reset_ctl *rst)
 {
 	struct zynqmp_reset_priv *priv = dev_get_priv(rst->dev);
@@ -74,6 +84,7 @@ const struct reset_ops zynqmp_reset_ops = {
 	.request = zynqmp_reset_request,
 	.rst_assert = zynqmp_reset_assert,
 	.rst_deassert = zynqmp_reset_deassert,
+	.rst_reset = zynqmp_reset_reset,
 };
 
 static const struct udevice_id zynqmp_reset_ids[] = {
-- 
2.43.0

