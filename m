Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50AECD5BD0
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 11:46:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC666846EB;
	Mon, 25 May 2026 13:46:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zNJkdYYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3427846F4; Mon, 25 May 2026 13:46:33 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E42C9846E2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 13:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/sZjwlunqetEMhNvRSfCvNNwaxQKgrtMjdQbwCz6NcdZHfdulkGqIB3e1qhrym92alVQsHZ/GX47ehpt618y8ahsIDkZdXnsM5GwE/AsvYoWtrPVQcTQLP4iHkK/wBBJqI0xArvAL+sPz5ElUhESN11k3GFx/0isjX2EiJREXdO07qPVeOERb49QfGGHgTbAylspka7r5qin16WqarigdSRJQKxV4x8bnGJtTvaCkELk6JfjHGMAUVQQ/COL01njwjc63aihdvt4tSOklYwF7DK+jvxoVwjYvTcFeTudjjuN/muru0vZbcIMtscKhqp1DHrfOBGJkC2Flo8zNbwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8FNvPtB/VdvreB2yhfBbe2AclBTutklWd5kDd3Cae4=;
 b=Y5fcOamjTzRi9OiHGBGuScpehy23KLoxSBuYsVCub+NEwmU2Y+vhG3kKArx/BOXPo8q4WwpPhF6sRpnUDoHI3r0pHgCV5VNeMwiugyB2SGDaT0WR7CPgi/2fCm1c1An4dtLaj09Z04kxoi2faKQ87iyjVA26MHAKXFwScyAFQui2Ds76kAvki4LEaAV8+927WNR7pSXcR2Twg8pNSFXwokJGLSw/H6Akt02HNrK+IE7qCGlzEcPHVw7Y9PfEqFINP8kci2IhOnZbFta3ZZKYd6SQUfvkO2Aj+GBIx4mpzBeq+cwGSFv2xjzX9a+e03DxazdmQtZvJDdMiHl+pvTPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8FNvPtB/VdvreB2yhfBbe2AclBTutklWd5kDd3Cae4=;
 b=zNJkdYYVHUUTYfGWQBAmqyedpj0PutHLXqnglku+2gu0ZzR/dwxGjuoVNt+W1OSh/RE0EUAwIkYgLTDRp4VIrke0rLOC8RqWAwffF36ECVrl065ly0b6rv4zfbo/NHJauhLC2STAct0Qb8rdQtBOEhMkoCoyyrOCOIDIiKuQ82M=
Received: from DS7PR03CA0318.namprd03.prod.outlook.com (2603:10b6:8:2b::32) by
 DM3PR12MB9413.namprd12.prod.outlook.com (2603:10b6:8:1af::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Mon, 25 May 2026 11:46:26 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::74) by DS7PR03CA0318.outlook.office365.com
 (2603:10b6:8:2b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Mon, 25
 May 2026 11:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Mon, 25 May 2026 11:46:25 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Mon, 25 May
 2026 06:46:25 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 May
 2026 06:46:23 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 25 May 2026 06:46:23 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, Simon Glass <sjg@chromium.org>
CC: Naman Trivedi <naman.trivedimanojbhai@amd.com>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v4 5/5] reset: zynqmp: Implement rst_reset using
 PM_RESET_ACTION_PULSE
Date: Mon, 25 May 2026 13:45:46 +0200
Message-ID: <be77d6f1b60f591ef626c14229d85c5cab867967.1779709539.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779709539.git.michal.simek@amd.com>
References: <cover.1779709539.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1550; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=lcdM9YtyBLlDQoE59m726Ju03m3PFEFYPGTOSMBSa34=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSJmBU7Gyh9m87+6HvB5SmpCrHTnpoKtN5ymp7s/fF1o
 oD4zSfbOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiOWYM//SuZ58SzHzt+leO
 MzHSpTlIOpK35or0xcZol+Da/JTqxwz/PT1XXDzE6skkZ9LiuO5Q8vOmyiJxVu2IOccPVkXZzL/
 NAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM3PR12MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 4095fc02-efb4-47a1-7773-08deba534078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: odfNaRoG6y8f8KRWfau4wcOQbtH39TJ6WaZRKObGQAcXHGQjF/PdDSl6DgxyM8ska5FUSuMzVsBFNATVfO+Z2CbNWzSwN0OgU/P1EfTqNVedONX9BFNP9JyDKJv47vLJzTFbyDZYXoGEhZsh2wOVQsI1C/Msm9blmh7Acvh2NQR/IXPc0LzBrr1/t/dItqVgbxMOHo/JklYcQKp8JmZHlP10cvsa1kCtUPGpdvEpcNMkQHmCYg1QqVBjPYIHO4QEDj0iiDMVO2ybrTXIdhzgMgBerCLf+C1DBkduLscVPdpQxppKeB2NsZPsTRbU4TjXjPbmOP4wo/stcnzSHcgPWLZ1+H5CpQBaUJl0xWhSsYjrVtQoDr3hn7KgyrRjXsogQ0DNsYkgc9gV8l2zxvN9lpTb3BqFTbiI1GFE3CkKstgqH1z0/mZIVKVaNY6KMKvYv8JLCAptu04FDEmu5+4ivyZrcr3vD6yu+47yaTJzrPHJIX3AYET1BHi1PkXVnXtHgEKSubbI+PokLagGqunwxmITJx7acbpmGq1/WTgfB5wNadAt6u08ERI0+LcqkrFNJ+5khmcP8RHW4g1Ds6op8hMXuOgkJulZ7OqP0WEozqNKZlASaUE6eFfMDgTpd4ZwucAoGyMzRjfncRAakngihMyt8KbiA0ORbiJgcAv2kYvYZOlqc0SLQdJ77xJNtajefb5nIaUd9mHF5jjoX26TWO2d1UA0KSlu0oKCN6qI+zY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lNuW3XL3foOzD0K2b/TzeiMOQAF/TEK54HdtPcN/rl+L2/xi3mA09ZA/hHqOyCeQ1HoM9FRb1UCzE/qGh9cc+VqlKAChdRTv5dIf38BjNffna2nr7mUrOkFMqYMFBrhLsOxn0ObNcHz/J4R8shvKV0AxCokluXqqAn+6b46DD2cBpPJkoyoOjvnzgEjfro7kg1pKs12eLiGP9sKjWFOVVE46sgxPIFrqAAwWN8fQmDlHaS1yBgoQ3reYYr3m5sHExchXk8cHuVhE6d6TZn4fV+Wde8OLCfrgEBknDR+D+Ppqm3XajvdROvvmFVdB9T2WHUgFNN79MrW/P5yfimktDW5R041nsHYjOSgBtY1jhOonb516lhAuCz0TEtRf8iUpp0OEngErJPfDMgJnewBJL/eGNYOhUlP2ym5eBx1dKUD4WqqBi1qQHBm1ByxEO1TJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 11:46:25.9467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4095fc02-efb4-47a1-7773-08deba534078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9413
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

