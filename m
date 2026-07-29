Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B56C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B944F60A99;
	Wed, 29 Jul 2026 05:14:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aD8BmqqF_1YW; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB77D607E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302047;
	bh=+D8BiibKyJM45AnPBx/j1/TrNaMF7GX6KwW4oFVx3K8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oesLUfkW8rtKLpbl6BoaiJV4kWBUzE+PkTIaGGLMdNG5/UicXgp6sap5349pedFdx
	 87CJtPGxiseZAEGpu9RpazHWdLcBWMrgBib9upJ/982Lr2kGlG3N9DYAZGylTRmKB0
	 dBQSm2Ubw7hKk2f1hU6cIxROZkbAWLSNRg1XMLXveKWdsELE6mBE+7bRRBBsx6DExW
	 ghr5H6XRqcnWyfoCFqEeIVtZLhs1GqIeEO03wJnkkcaAqc1E8JgoIgG2hd3sQP96nC
	 3bgi/KauXXEaTlpz0e54MMiDzzgRLTPmbIepyeTFvJmN6vO78l/vU0BKV/pdku+BJu
	 9/2p+B3hbu7zg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB77D607E8;
	Wed, 29 Jul 2026 05:14:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F094845B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E299040A9D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d1It9yZhhdgR for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:14:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 98F914099D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98F914099D
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98F914099D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A2788498B; Wed, 29 Jul 2026 07:14:01 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0CE8493F
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:13:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZfB8pft51cvUzLlnuONPcXNZRdD1LnJYpoy+hTMIcQYDPHwwU/knOIRQf414iaA+9dgfmyKZCj+7EH/EvohQwYlCaCDVAhS7ojeMjcTNNNhgHszluRMCFF24PA/a0w0Sl0rg90hQ95VCFEdRcoEJNFtjctKNFEEFUFTgc/wktAcPCuTfsXwkTQkHU6gB7VZ3VWvTGq4qTfyNO6EmbEg434m36h10x34EG+Qrs9arHv5ODu4dK75b5k/K1DA2g41DuEAgji7VUnvnQpq7WmGulb+fi7TtNvqU2sFxPR/BrnCr/XY8lbLHZ8wNuGBIBW4cyZA4q8f/u/9ysibV42vCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D8BiibKyJM45AnPBx/j1/TrNaMF7GX6KwW4oFVx3K8=;
 b=g8kjYcnPwTMFrNslkRaYjrGg0+CagPxipYqVBDso9t0WV/97KVTKDg6PLceGC5990g1P2yOxB5l6r5Q0nNbxOLirHqsWt/cbYxqq+k7jqu2VTcoqPvG19AonbgSQov1rTScExijLuXTyoHzk0+CqkFUJm9SxK2qJChabMM6Yp2XVjfjYVx/tnVjz2+DVQg5IG5ZPUPB/i/iXColNrMma6Q9gAedU0o0IGuOJBz54o0HAq3wa1pkXQmD6grkGKlzR6S6QF+QLxq7xZQ6MJRC8yDpaJQOXE59tKmJzNRAPImApfKVsx92DJbTNOeyg/AzvlRb/wH5p44s/G/EwAZy+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0PR03CA0322.namprd03.prod.outlook.com (2603:10b6:610:118::27)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:13:54 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:118:cafe::30) by CH0PR03CA0322.outlook.office365.com
 (2603:10b6:610:118::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 05:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:13:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:52 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 00:13:51 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/5] gpio: delay: set gpio_count and validate index against
 it
Date: Wed, 29 Jul 2026 10:43:37 +0530
Message-ID: <20260729051339.221699-4-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729051339.221699-1-pranav.sanwal@amd.com>
References: <20260729051339.221699-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f20cd7-a2be-43b2-9a89-08deed302f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|56012099006|11063799006|10067099003|22082099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: N742p9TKI7uVlqeKAdeGLjWFANJZXBY36nANvebNFbWItAG6yMlH+xaOyaRhtzngHbyBEmZnfkjHjOnkoi2mEYmQV4RlT2SxEGPH0ueHmRTgQ0nozsvR0Wfm8O90LmLSwqtJf2MjfAAqfajuzcr7/ZRd+MMs8Bh6XXV8AyVieA7QT+nPB92SC4nsBJh8OoYvvY+5J2l35OnTfRnfA4SXw4uN2c4HfNjLfLp6fb1wNCIqlWivbLhOxQ2lH3F6yRPx8bwPASDVZdi6AtjuMP6er0SToRQDSKDeeO72kzJmAlpNymbRSrrjFgEBA0HHXEXTzBfIGtRHf/wN6Q2amW1MeuHejkyzHe4CwC97zeIetcH3ZlTE6gXdjVfNY7Zdn9wFuS1Ayw6ZdWNybj9bQ1D1XQOguqrTY6SmbWTxoHa6m3oHebyUg4bQtl2TcJ4TgBtPdBh+7g73QR20S8eZc6/5wHkuaUIlepMwMH5WuhvLuKvyV2WXMExR5S0HNsEjuWFl3oSN6d9CPrVooOZBCHAhN/MwJQ8aq7o33Qyc/ksG15tCpah8abwRbkF6MHt333fD8LfYyoMuoG5TY0lMCjf5rt2oRItsg8QqczI1HUsbb8xx4hKZmizqL3LUKcq7x8YWwrn7XyL5SUHt+nVLsrcfFgFDg5OWqmd3N5z5JAc3NPO6IlnHmTQkrc9E7wYUPT0wTGERWkMebXbqGlQaz9pibA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v0cLfXIh31H7lEaOdkCusgIABrnwq7VyzFky8wuTTFZW/dS2nZ8WH+d0zOIRxsdmj8xMakXnyOx5lkpAT8yUFyyufVpA1CV1z5tY/CRtC8nkhqkbLB3LCwj2pxsDe6I5kvJZAfJjbYd7s2379en0H0Vwp8qdNTI9i/0kohhkej9ZQKcqHKUeE9ojIqHLXBnR70zQbWUYXModasf7e4cjSK23Yk+TmT/TSGYAn4qmIwen/CjbJA2316EW8f+uIPTgdh+zm+venuGqLeKna9beoQ6gX56t6+4/WDCKSo8UCBmLOD69rpRiYstJsQzqCB5klVrwCdInITyXi+Brx5d5paGQUDL8Zdcoby8cP116vm+bd4dIHc53cEjxHmoktSBLbMArUtRS779LBDBzK/vOhj2PXAVrtnzdWg9TZ9ix0FpsiJvmx+m/afPkXnPNKEar
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:13:54.0035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f20cd7-a2be-43b2-9a89-08deed302f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D8BiibKyJM45AnPBx/j1/TrNaMF7GX6KwW4oFVx3K8=;
 b=HKs5ribEyqkHTeSLWH8YOwLa8/NVGmJK1VO77sx6NLoBE8YnJFaJl4L6bTmcMiI8G+nMP2FnnB+2hjM9TTEGCGVXPiFtePgCwH3Rj56HrPsYtqBS27bvrxEuxr91AOz07Gtp64ICbn1VNt98/xeOTTFEloFlHPj77jEybck1tZI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=HKs5ribE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="HKs5ribE"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

gpio_delay_probe() never set the uclass's gpio_count for this device,
leaving it at 0. This left gpio_post_probe()'s claimed/name tracking
arrays sized for zero entries, and left gpio_delay_xlate()'s bounds
check validating the requested index against a hardcoded 32 that has
no relation to how many lines this instance actually manages (ngpio,
from its own "gpios" property).

Set gpio_count in probe() to the real count, and validate against it
in xlate(), matching the pattern already used by the generic
gpio_xlate_offs_flags() default implementation.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2: None.

 drivers/gpio/gpio-delay.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 9105deecc4f..533e7d2f8ef 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -68,12 +68,13 @@ static int gpio_delay_direction_output(struct udevice *dev, unsigned int offset,
 static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 			    struct ofnode_phandle_args *args)
 {
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct gpio_delay_priv *priv = dev_get_priv(dev);
 
 	if (args->args_count < 3)
 		return -EINVAL;
 
-	if (args->args[0] >= 32)
+	if (args->args[0] >= uc_priv->gpio_count)
 		return -EINVAL;
 
 	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
@@ -97,6 +98,7 @@ static const struct dm_gpio_ops gpio_delay_ops = {
 
 static int gpio_delay_probe(struct udevice *dev)
 {
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct gpio_delay_priv *priv = dev_get_priv(dev);
 	struct gpio_delay_desc *d;
 	ofnode node = dev_ofnode(dev);
@@ -112,6 +114,8 @@ static int gpio_delay_probe(struct udevice *dev)
 	if (!priv->descs)
 		return -ENOMEM;
 
+	uc_priv->gpio_count = ngpio;
+
 	/* Request all GPIOs described in the controller node */
 	for (i = 0; i < ngpio; i++) {
 		d = &priv->descs[i];
-- 
2.43.7

