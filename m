Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAC6C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:29:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A0E984B9E;
	Wed,  1 Jul 2026 12:29:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eOUkta7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AAF84AE9; Wed,  1 Jul 2026 12:29:22 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EFDE84B9E
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYLT2sPODq/RP6h/DjEepO6Rrr0gOirkj0QBQNboNU1DE7E6PENLQNxXKH4s53K9coo9PZzoKfC5rYJXaRrbmvUwIzWpOB1D/B2VXf5M+UwBUOL8D+UeipLZIVwGS42eifhw8CmJteilged/03qcnIaJgiINuUDffnybm9DFigZYloE57GB2D2+QWb12TBE7PJMGYkW0MyiAwhxZy6eGpaR+aPV+4DKqPRTQJG35XuHiUnZdEJgOqEOBuz8ubve+DTVE4zWxTXPBEFcI7VSiLvF1aig7hAubC/b9pJoy8JfrRd88E9y8fNANrLM8KUj28fhI0ng5qq5vkNzaCUXcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyzacH0Yxk/KZlRNKfqWOFQqPHH3CWI/T1Q5Ew8H4Tw=;
 b=M2SI8UO8QCprQEM5uQDbRqDa88Gva/PoKz2gh6snaR2ebpB/rP6fjM81eb4tR5MyzCZH9K0e7xfEDc6MgZV4/LAGfEtNiSQ5cs2ljmg3aINI/L/xRX9/MGVJILjS3ZvrAXwNZWkTM0rp2td+1l/qfAUdSbJew8iFv5lPGco28aVYi20yLRelsoOysMfOzLCpFxgM2BieKY1enMNbG/PPO400RrsRWWmY1uKHT3YgH/4koa6LHbMAEoLaFwjjvgdlxUf2n+jgg1Z9TLSP9+jwfMNg1KyWdC6r1ZkmYGelaDmBS3euG99MMyFOcZ0m8j4P49kTlshFWrrWzRJ37eijmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyzacH0Yxk/KZlRNKfqWOFQqPHH3CWI/T1Q5Ew8H4Tw=;
 b=eOUkta7ng7uaTtaC5Ntjh6eU1VPWUw5wiXgcU23DTKQdnV/F+ejSaiiRCMluvFTxy7mrb5ZoolxSPuFe/FYBAMdtEkI7ryY70zgmf4mAkBFmvJFpXq3r+bNpxkYkFiUJMGRiDI3GlujzS9IAOjsbMtNVFpafNlRauBQgbe04QeE=
Received: from SA1P222CA0154.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::27)
 by DS5PPFBABE93B01.namprd12.prod.outlook.com (2603:10b6:f:fc00::65f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 10:29:12 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::95) by SA1P222CA0154.outlook.office365.com
 (2603:10b6:806:3c3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:29:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:29:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:29:01 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:29:00 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Dinesh <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH 4/4] i3c: dw: fix slave device setup after DAA
Date: Wed, 1 Jul 2026 15:57:20 +0530
Message-ID: <20260701102754.345049-5-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|DS5PPFBABE93B01:EE_
X-MS-Office365-Filtering-Correlation-Id: 06382144-5bc9-445e-e3f9-08ded75b9813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|22082099003|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7F3thXFjo47E9/Loi/HOUAY4z454OG05ZJ2oZ65lIQ7wxXqzZCMqq6VRqHuRid2fUo7I8n9VDlOFE2+WhG5V+/h9URwUx6ECdK1vYzlALTwLlu01asGQGt2cYTpMk0ezCtl2bkTt2vsUpS7sBokWdHaF2ZJSqU+xWM9uhMpydgtaKxM8sIRowZqWVF794nUKuTrWfUtVsFdUW4wBooskQtWoegxv+a58iBx22TFooVp1oO1657U7g34aPnaaNarKowUBasn1pbQDimglo0mq5suRbvmDgRamiTlIABgQ/Y2zhPBHdvMYZIDXzuZsNHfIyP2Xczd90X3XCs/69QYKAxQ/QIJLMoF6Cxp6yTby8TJQsxwMAWoAGRjd2iWPg93dLCBW9EMhpR3fzHYkXNjowmVBDPH+CkAHuA6eogJfKdPce/SAhDCT1CmbjVzmJIatjBqvguTWvbBFw3qHdLvEYXLzadEXOhqiXiLrY/le41g/ddyqGTVQkLIUSbI0sesDxPe5djDw6swA40hzxfm16U2vSLPn2ndlFUMto1aFiIlRHo5Yi2WqVY/9tNi6OK1CUkeDY02UzDP9U8/BSKBg2Lm7rOKa44ueuWba4WCgdO0QTZzdaV0uVSarb42eOI6eQR/Zr5ek4JumhjqNUUi5BG2gQ7WVCfBrYEHP9+h1b6CxNVzsePh630f95fe6YvvqXyr2tcAZJfwG+B7fzfU41A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mNwsCpBduvs5K7jit98r0v5xOGtsCe4kbn33WSNMyf3nlhZKUwERdpxrtaxShZzEu8KL7jKTddL0gkT5kzez3rY7uGfsQ45iMe8fx5z0IsJhmcS56W5s1gcOYeopw4rgc+/8vFy3PwESYlkWUiZe9Ki2JBsck9gvx4XX3Gff4wti5M0nTPuTS5UYZu6gGO4EsjGhJtSmkrsqlgxQiKR0VmT++dBD8EoFymjOChDXSd4LiDvEFWXFfR7/T7egkOCk6hOPIuvW/imcV3w/NZMZjUi/6Xt2EcHd6fsjkCtAeMGy4qjZkyhyVSVn4ye0QC9nXN6VHOxdSjvgodiLuYlw/5u6HM/DaeVBh6h+ej0pv85GNf2J8iJxQReDULlUpD/2Gj8IOXCq/WH541CqR95oOfMHbFHMqxrCpm7ioKclbzoWp/LqHFCmHWfpRSGKnQVV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:29:12.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06382144-5bc9-445e-e3f9-08ded75b9813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFBABE93B01
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

i3c_master_add_i3c_dev_locked() incorrectly set master->this to the
newly discovered slave device, causing i3c_master_attach_i3c_dev()
to skip the attach_i3c_dev() callback. As a result the slave device
never got its master_priv (DAT slot index) allocated, free_pos was
never updated, and the DAT entry was never written.

Fix by removing the incorrect master->this assignment. Store the
slave descriptor directly in master->i3cdev[pos] inside
dw_i3c_master_attach_i3c_dev() where the DAT slot index is already
known. Also check the return value of i3c_master_add_i3c_dev_locked()
and skip num_i3cdevs increment on failure, fixing dummy devices shown
when no slaves are present on the bus.

Fixes: 1009c96f1590 ("drivers: i3c: Add driver for MIPI DWI3C")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 drivers/i3c/master.c               | 1 -
 drivers/i3c/master/dw-i3c-master.c | 5 +++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 019167a2dc5..1cf1ffd99cc 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1443,7 +1443,6 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
 	if (IS_ERR(newdev))
 		return PTR_ERR(newdev);
 
-	master->this = newdev;
 	ret = i3c_master_attach_i3c_dev(master, newdev);
 	if (ret)
 		goto err_free_dev;
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 384fd27b750..84a499c210f 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -671,8 +671,8 @@ static int dw_i3c_master_daa(struct i3c_master_controller *m)
 
 	for (pos = 0; pos < master->maxdevs; pos++) {
 		if (newdevs & BIT(pos)) {
-			i3c_master_add_i3c_dev_locked(m, master->addrs[pos]);
-			master->i3cdev[pos] = m->this;
+			if (i3c_master_add_i3c_dev_locked(m, master->addrs[pos]))
+				continue;
 			master->num_i3cdevs++;
 		}
 	}
@@ -806,6 +806,7 @@ static int dw_i3c_master_attach_i3c_dev(struct i3c_dev_desc *dev)
 	master->addrs[pos] = dev->info.dyn_addr ? : dev->info.static_addr;
 	master->free_pos &= ~BIT(pos);
 	i3c_dev_set_master_data(dev, data);
+	master->i3cdev[pos] = dev;
 
 	writel(DEV_ADDR_TABLE_DYNAMIC_ADDR(master->addrs[pos]),
 	       master->regs +
-- 
2.43.0

