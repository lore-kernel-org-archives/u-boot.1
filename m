Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C8DC53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF3BF60AB1;
	Wed, 29 Jul 2026 05:14:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cY6tjg2oLHVC; Wed, 29 Jul 2026 05:14:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 463F160A57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302051;
	bh=a5HNQ/bcLuc6vQ/FesB9tR9s1TZNY7FrwFwB4FNfCAo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yuF/WoljBy2f+RSAKpJvhMQluYnyHo33wdkbf0DcS0zX7/T6WYtc8v99F13ZMJ5bn
	 5/qyf0lslhHW/Mo1CqszVl2WHRfvq9lZP60tZ011uQsXIkxsutyCNiFaqNsIpL/YDQ
	 zKNEhZcpbgwnsK+cZHlzlyqJumTQ8p5nR09PFOtZQGO/zd1XDZJHrygE709PoCdIl7
	 Qc5LhtR0jn1FVrW9zOf6kAQeF9g2jd20i5VltJiiG9psIol+PuLLou4CPHzDtgWmgl
	 SEkRje1adFkZ7+QxwgQlvXNUGITT1vEhgFngcpUYWZu6bbnYpHkFsg8j6np30iuJGX
	 oiJcvc5AUs2CQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 463F160A57;
	Wed, 29 Jul 2026 05:14:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id EEC7B788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E9080810BA
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uBMmw5dBtABj for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0ACD5810C5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0ACD5810C5
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0ACD5810C5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5FA8493F; Wed, 29 Jul 2026 07:14:05 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69028849A1
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:14:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL/gGUehYvwAJMPD1Kk4TZmMAZiHKPC+VU2V5oaKTWqAFgMmbqL3cWfFHNaJjaWxM/iorCr3zZJr3rhJlQidiHNcP5/2HV7zax+nKSlv13RAkKfw/2dLG86HxZLfYBDlO0HKk/22nDtoL4nmHeqp/AYvRUHwhVw5/gfwjaRsHWu6x5KswswIT7HNNv79mvbSkR42bea6PwGipRerKnJtviIMHlZ4yjdkiEh9A7PO2sXsnfYhi6Fh5bijNwYFxdEnhy54gykcK3sp0vAEhhLDr3yweXSwc7XhmNIXCtqAhWm2D4QSPFx5CcF5UgIAmsy3MBu6sHE8qU3a0bw/q4TSMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5HNQ/bcLuc6vQ/FesB9tR9s1TZNY7FrwFwB4FNfCAo=;
 b=zHnms+QkihdD6NWyFqk2PAg1/CbbdzN9zNwmO9bvAE3/6dcR3ndzOhW2b0wZzNpTr0vCCI93Ck1UDdufQmuuEGM5Qdi/YMG5qa73FRp0QmYSsvzOhk2JMJKB64OQ+2CMAia6sl/PHg6UGjGWe14yP9Oi22nZeFOTP7o8LUbEcBhdFRMCvX31m7obphwkySyWs2uT8Y5MwT29W5hYlbKknAAfS01nVrdmFv6xMxLhPoss/9W8EghF9inHJPRU5lxT0I5CxRURTUk8Q5+oxCiwegmCSTTUO0y+yjvK2XJq7pxjXSggir61wKpRWFDUFZCXlv2dNWW3jJOwdhODtZpvMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS7PR03CA0209.namprd03.prod.outlook.com (2603:10b6:5:3b6::34)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:13:57 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::92) by DS7PR03CA0209.outlook.office365.com
 (2603:10b6:5:3b6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 05:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:13:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:54 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 00:13:53 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/5] gpio: delay: fix offset propagation in
 gpio_delay_xlate()
Date: Wed, 29 Jul 2026 10:43:38 +0530
Message-ID: <20260729051339.221699-5-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729051339.221699-1-pranav.sanwal@amd.com>
References: <20260729051339.221699-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af31388-4380-46ce-68d5-08deed303072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0teVWO/wj7OYEAfJpYnqcO4M99i+yH1fc8bAbwju58CjmhSo3YBxqpyiYUf8VesIjKlkI8UWtTkcEos/Wi4Ij1QTTnaZ+46BM/yf3Ov2kR3wAPj4JkTYUQcRduD2YNgxgymrq1SE2GTg+Ct4rUpjrVDmjV8UpPKoR1lC1If1J/Md1ylEmjPgVJHLESZonXE+LwOt1wQ1cghj3fgYW8wHNuKgQ8EWIuuzodk26kIdGQuS+kJf7wYRLaLictIOyhaJzkx8KLWRegNBpaV6ZJ5areSZ+ep2tj6sw2GKl9HIrxjVAESJ314S0qa8p6+H7+YSZdeRsdlK0FKi2eg8wZxIvV/lCoWuwKLkfcx22H61KdOp5Z0xP5onZ6DFGjT8jRtoi8Yh6ddVb9Qk2O5ZojERX1Y9GBKY0Xl4zWyqoE+1zt4ScU09GqMC7oOTBgwxMyCpQZ/ddAnLmlFGdkAJnGIgF7X0zxn4zkBIT4Dl2lLYdXrxBqUdGe6nDJSCSGXL6/YRsWlE/Enk2mX9R0+uxi0yXsRvMw0kn0OnkGEx+b10Cc0LfT+2+7jBinl93xwjl4ROBMbz41qJyDpXk/Kv+QxYt3ABUPCjruXia10yvgD+2f0Apa22uo29d58LOg9goN/fJhmGcw6D/Loth/ri78ZPZgxqY41w2DrM+uGRhUGA+sG6wSmUFKEsH2kX8j3u+xajaLX7ktjOxAQS8kEAOTt7Xg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mDri1NaHOuHYJKpvuYt0F62Rn0kTGq19h63hw3tBWm9NEFV6f55Z+PheFHo9IZiIh2IHJqf4vmNjjaUijK4CuvEZnrIn09PXoaItX7JXBRqpt24OS88NrIFqdaRqbEbzD5W0aOH94HkNX+8DwZZb0AXPjWm4kQzNqgouhtmdpI3/Xl64/G+LfPYHzq0v4rN3mYO+mmSamEzGZSiiJtSFkm2JXQ2JFaozevryUkndudUFBlKoHi39WW2fZwwpsUxnHEMvaU/NErkrpQPGMqQln3Her+C8bhmzwhEKyzhhHMhHP6Q1eyBm9BYNd+JPOtyUFw+AdoLlml0phV6Zh8NQgQ4WP6WV0nEZISbDHS7GNQBXYXhktzvrN71e2hdz1ImND2Q7iGG3qZuwNfSP1Tx4x4uGVgWDE3uOwCnFntmR1+KVO3vHWVF5Lb2xK5u6nmQG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:13:55.9457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af31388-4380-46ce-68d5-08deed303072
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5HNQ/bcLuc6vQ/FesB9tR9s1TZNY7FrwFwB4FNfCAo=;
 b=mAeJ4S8WdMlX5b29Rr92IO7V1FAlePrFE3GzbgOeidJG0HZb6ZHjCzqGG5je56NQRomz5MZupeb7dakj7fFPb1gzuQgZyMuCAaPKsLMdzMvC1bx0huaTT3Z77Kugc7XEqLdngz64bdQBukl02a+g7TjpII1XuEUBfUXDEm28yv8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mAeJ4S8W
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="mAeJ4S8W"; 
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

gpio_delay_xlate() indexed priv->descs[] correctly using
args->args[0], but never propagated that same index into
desc->offset. Since gpio_desc_init() initializes offset to 0 before
xlate() runs, every consumer's returned descriptor ended up with
offset 0 regardless of which index it actually requested.

On boards where gpio-delay wraps more than one real GPIO line, this
caused every consumer past the first to silently collide with the
first consumer's already-claimed offset 0 in dm_gpio_request(), which
returns -EBUSY. The second consumer's real GPIO line was therefore
never toggled.

Fix gpio_delay_xlate() to record the requested index into
desc->offset so each consumer's descriptor is routed to the correct
underlying real GPIO.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v2: None.

 drivers/gpio/gpio-delay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index 533e7d2f8ef..f6c9c7efb0b 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -77,6 +77,8 @@ static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 	if (args->args[0] >= uc_priv->gpio_count)
 		return -EINVAL;
 
+	desc->offset = args->args[0];
+
 	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
 
 	d->ramp_up_us = args->args[1];
-- 
2.43.7

