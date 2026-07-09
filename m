Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70B7C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC4F84BC8;
	Thu,  9 Jul 2026 16:29:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="omrQPOoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6516784B7F; Thu,  9 Jul 2026 16:29:51 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C36084BE3
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EL3+3Gjcdte4zH3yV3jDrLVfrUzqx/f2jocFgpirSkfSRAH6ekyrV/sa0t/Ik/HjPFpHQA9ygHblC0IVCNh7gJmwFlah6oDcZarYSqKx1zaxtTH9GSudb4kQgdNx3q7+ilKVHVo+r47uXRYzAfZNT56dmgjy7Yrx+cZRstYH1UH4LULvi2y/0NYw9caVHxq4ZNK+9LB4rW9joUOBOsIhq0oa+EiydfLwPhyPX6IuhkC2x6GVjntTD2uGui+/JEMxamVN8keU+NrLNihf0/JjqmREf8+3aSM1yqOVIASaGtfEFzzImx4HDl+DPbP7EjwPBz6G5yasQZXBj+J82BWLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyHzNmnpFIQgLroyBd7++f5U0o2F5Xg/LhuAkhq/m34=;
 b=Rc/dIk47R6ebX9VLZpgptZldwSEEQlikCHDeKxhoP7eCrCvF4etav/vzmq8EdBw1ytxacgt84wn0c2yFiy+hVPqDteJb+JfepSPNmVCRz3GfdqlQfludTLUTeT3y+qJToJuES3a4ZSyFa8OYnMjsc5qdE5hH2w2uEvJb2dShoCYX3mmDYRiA8jzXbk6U6EEVvNY2Z9FWbHyhtObGMWjB8xE15PXa1IkBnNBC+pGQ/Qvc61+/W5L/2niJJX/LAJBVEkpqdgqIO3wCqg0POznFX9A8Hl9/6DNCw56E2knb5bBBzL5JvYOYq3vDapMijgMJYRbtFQo/PebghoNupccQfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyHzNmnpFIQgLroyBd7++f5U0o2F5Xg/LhuAkhq/m34=;
 b=omrQPOoFG50Jrnd8rmWGf0N4p2gZaMmtid5ar6QYdE0Cp0aTpM0UueOnvA9KYuvt12iSWGPPTrLdIxpdJAzHZFVH+xyNrNVuyun/CG5dnafT52y1Q5wh4++UoZ5Jx7Q42acMmgYdm8HoSu+j5dhqLD0hRGCaTd53M9Adh3hGGZM=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by SN7PR12MB6912.namprd12.prod.outlook.com (2603:10b6:806:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 14:29:39 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::92) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 14:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:29:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 09:29:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 07:29:26 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 09:29:25 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 2/3] gpio: delay: set gpio_count and validate index against it
Date: Thu, 9 Jul 2026 19:59:00 +0530
Message-ID: <20260709142901.2054431-3-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709142901.2054431-1-pranav.sanwal@amd.com>
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|SN7PR12MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 92631b6d-ddb2-4752-ad7f-08deddc680c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: rVgshpTJuDIxy6iJFX1PSQ4lIcqu8srHJe9Lgfi8/7oJ0uJ92zefhneQZ9iHnRrudswpzQ4/v16z6LocWaR1uM5BDr0bVnbCQvO5rWFXsu0kfeOge14aKnX++Jao2NghzXYD8yE9OQNqCugOW1EQEPCAE/njVIwH7x8dh6Fs6WuE9feop81DPNgQEY+eYxe46+wqh9bSYN1S0azAaBU5npJXrLwmpaYir1HNApQdB+UXknt0nj9GVIH4ZNuIHh5KOKkmcFaMSIEsn9ZA1uMko1K+pygWFheaeABqlax2wRHfPK9vggVPjfQNS4VA6Ydk8wSi8w/tjAAQn2QT6zuZP/WM2rlBJBjKvpg0aIR/XrZF0dltOSbBdW86OcvFnPeO5Ar7j2OiZ4PzH38dB8aB5V3TZ2CoRne+31cfvpmc6QCdXB7/xxknqSwFw/VjI3pFUWjBkrcj8D4nRqv6I8AXdgmcMbPnRb1w+uU7IxEVtBZKsHZ1ejzVNVhi307Rabi0aF3+s9COOtSENGRt8n7NzVvAIcV8j3kCWZ/LMpWTnA6lp2jAgXRyqhd13sFkOrtfSxlo8uTxWFPhKdhRo5PQrsop91d0hXT0DlPyM9tCPU61tbDbLn0yrT9952LHPSLzzXyp0BSPvTDAZtOZ9aX4D8lJpJty7LxjA4PeiEPR1/YFT472qoMfux7eIPYr+uhcmpMLwnv8StY169G9EtvcVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vnY1u28LmGCdQ91vbiJQoJdPnzZEhkLhRd71wwcEL+M6IKmvOFK8FBmZ/m8Uiy1sjIaLlLK2WvTbDYlh2rSrfhxNp6m1MS/pvrcFu1Kf/KBom2/qm0Rha2fhY4CwPQ+uGvzkPJ/M+ZnnHUJY5TO/C63311eayU6nenEi8vfixqT8jPQynIjUxf0D2qyV/FUGY0DTj+8vYpJuN4DvV14DyRQJSr96xAdVd0K3uPnc4HjZAT9UpY3hCFi6hH1qiWuNF3snTvRfJ6k8dYFOLpXdb9CR0A3TRe7XdNm9IvUQTWs9Z3fuj6pcLYHsYE51X8scVvMQmBHAPB8L2KyqmknWb7YafIL9oJJM+RyZGXvp+v2gysXxpow17q4nqH2cCkDQyiH3laepTbtBTUMTcgkrVttrhWxGCK/LncOjPWHfW2tqX3ZCmuINO6CNAFg95oza
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:29:36.6122 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92631b6d-ddb2-4752-ad7f-08deddc680c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6912
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

gpio_delay_probe() never set the uclass's gpio_count for this
device, leaving it at 0. This left gpio_post_probe()'s claimed/name
tracking arrays sized for zero entries, and left gpio_delay_xlate()'s
bounds check validating the requested index against a hardcoded 32
that has no relation to how many lines this instance actually
manages (ngpio, from its own "gpios" property).

Set gpio_count in probe() to the real count, and validate against it
in xlate(), matching the pattern already used by the generic
gpio_xlate_offs_flags() default implementation.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
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
2.34.1

