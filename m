Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19815C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 14:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F2084BDA;
	Thu,  9 Jul 2026 16:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KMCRjlfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC96884BE5; Thu,  9 Jul 2026 16:29:43 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9B0F84BC8
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 16:29:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bC1S6gjgqX/yy2Wfqd0m/eMaWw0cerVZQzv43HslXt6eweTFxUK/bWenHlVX5D5fdnOiNuaRKhy0HR3UGSxRdul8jOGoa0wpLggdG20Ej+3V+t8rdTqsIcWBIFixxDNzFrWMsxEIiMlL0oWxhGNJESXee3+Cc2Dw6dmkfdJQmAS35J93FETI/yYIfvYIRoVRzs9SoAMC4h4Qe13rDmFl5Q40U6Qde27wXPYcCHovmGBZ1aOCyb3cqx0abM+UDNKOnD3sAthvekBWNodbgN3HuVxbqkq7RD65lnVQK314ZkU62U6bUOKZhplXFGOdhJWAi/ZRpj/GMwOPHn7ZGoSusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE8FfVBhWrb5kfNh9vWJ+2ryGvWoxqrwPpB6cCHIWNw=;
 b=KJAu2wwK1gBiEgYus4HEuPJQxyuUEmflJOvEsj4iInE3OLhnbCNbj/XnLU85FmnzN1AnowGS8KZeFWL6WNp6/Pjq3XIeGvQ2WKON3zU70Ez/le8MN2+wNjpB9h3bxD5xddOeTgh06uE+0p0oKZIx8Ahs6PyJde+84lwzwVGIP9lqf6QWcAYLvgEs90XqpNvj4cDTqZq3JoIPGn9XeK0b/r9Ydz6yp41uM0er2NSzs/phQ1yHdpZpxrh6ToWgV9tflyVwAV6OSp/S5KdzXawPi9kiDq9L872i/rWFFd3mteoGnMrNe2EDIVhnuCrpeMkIRaMlkYVcvbaxxPh8G1LlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE8FfVBhWrb5kfNh9vWJ+2ryGvWoxqrwPpB6cCHIWNw=;
 b=KMCRjlfmja76LGUp9gcj0g0XHKmLTbijWwU8qFKlLnuddJuk/ioXY5ZmerCsCC4xGdfcChG3Tt1VRdgJc9LHEQbkJGt/97tOImXf98/S2tn3XV3ZdocCtYBJDU8rb1sUIOr9bMkkIuroYICRfNwYP9x/1UMvm0u69Qbte+6nDh4=
Received: from MN0P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::31)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 14:29:36 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::95) by MN0P222CA0026.outlook.office365.com
 (2603:10b6:208:531::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 14:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 14:29:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 09:29:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 07:29:28 -0700
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 09:29:27 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 3/3] gpio: delay: fix offset propagation in gpio_delay_xlate()
Date: Thu, 9 Jul 2026 19:59:01 +0530
Message-ID: <20260709142901.2054431-4-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709142901.2054431-1-pranav.sanwal@amd.com>
References: <20260709142901.2054431-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 66df18a9-60c5-4c34-7baf-08deddc680be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: D7drTmrfKBcxhYYsigwBh5w5coxLjenTCgE53rjzd28Ni8W4fy/XJMMgC3vnOuWWMRhHdgeYP/STx3jAUjnW43H/hkamGQye1l1SlXC6Bpw0gZyMPPdJZHURpdz22fF/C4MlC4Px4OWtVIpANu6Ds9Mt/hLYpVDJXnkqZBIGo6h1tDC7zjB8CYGAbDY5pRUZCeO7gVHNFwLJ8tdXclrYIcbRJwipyb2dplEcl2GEsLxttUNvx+jPBAB4RU8JlzxPq/v19ucYWKxEMgZUbHT77JA5tYechpyRbwk1kCx0eCbURyG/nRHqBq+WNriZ94PqdQImwRZWyyUanyHLSA48Vv4iXjnqU2V54QddRLYBVB1nmynSLmM/McoC8D0rndZ+y2WH7HH7QKsRKWOAZsolZK5y+7wvT6Y+v/g3R7IPkjlr0k4YYL2iQGkkAC50UnX+GFF4HBeDFJ8vlUpMm5tyAqBq7kHE7bcsHAQqJxURco4rnRqus+TCg2Iwj36VP6k8dCCyYI/DxW+qV5ZgzFJhu+o3UgpJErF85EcSlvEIeOYaRAlHWMjPV5moQ+Lv0iEP7bjjsOV+pIOd/GVIvr+4PiyBvV1l3d0WVPw6k+ZGishOiZqpIXqXFFhnZJmdta0YDRXsIOeDELsq17i4U47gERLr5fitbvqm9SDM8hxYJx94xS0X9gfrOaGdMd8wnbfvMnLkFMmtdykmVSmvOFkreA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S0xTpjvcrQMbc9LHrPTxfx+X/NINqmz1Wyrm6kRUi5OV/3g3EWjrsh+Zdr1+JtvFHK6tdgcMwN0s9602pOvnUlcvXQg/fbBtz4dPKbuZQNL0BdpEpO38bhDkm3Jh5I5nsOv8t4Bs1c1+zK3kZkaiBMwMJ7yLUyqwMPKJPuJ+45wq5D2q7ug0fKEDaN97IxnD7f6FBS4WiB770HbTPdH0auSyLGNvRlTu0+0XgmpBxxxHnGyE2CJMEoZdCidrwJAFq1JOQUUVwUWW0AthJ2gpCSgg8ikfcohYM8JydgGH/r3pov1yxaE3oyVz4zRzCnVRB1yNICnRLVtPyojIHJTzVb5G3vIeP/aI2LSESmqu5A6zuYuHOmioTX5+Aq5wvTbUa7dXUDFFQfaQfT5Zu1GHC7hkK6nSTlmb+j2aU2uDe1/VFtpEAOvWuTIFtLAWbQ1R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:29:36.5983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df18a9-60c5-4c34-7baf-08deddc680be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

gpio_delay_xlate() indexed priv->descs[] correctly using
args->args[0], but never propagated that same index into
desc->offset. Since gpio_desc_init() initializes offset to 0 before
xlate() runs, every consumer's returned descriptor ended up with
offset 0 regardless of which index it actually requested.

On boards where gpio-delay wraps more than one real GPIO line, this
caused every consumer past the first to silently collide with the
first consumer's already-claimed offset 0 in dm_gpio_request(),
which returns -EBUSY. The second consumer's real GPIO line was
therefore never toggled.

Fix gpio_delay_xlate() to record the requested index into
desc->offset so each consumer's descriptor is routed to the correct
underlying real GPIO.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---
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
2.34.1

