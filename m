Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EBBC54F57
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F5781168;
	Wed, 29 Jul 2026 08:12:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id im4Xl2UFU_pM; Wed, 29 Jul 2026 08:12:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 282A381172
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785312765;
	bh=+D8BiibKyJM45AnPBx/j1/TrNaMF7GX6KwW4oFVx3K8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hoarnXos+0WM7JZaOjcrTmHTCeibhXuOkEjnxhfyKV5NEgrHhQVE6TtPi6BZ7Cz59
	 W5rdVPROo60gkL/C/wDbiGThwDmYYT4X8+nxwk4dpor/B25CIYM6Vsx8WoqUdT7SQg
	 ZIJD4eRCEMtoBHbjgtE2TwA9Ncn8DJqBGeZDLamQyS7R0jbx6HBcMKHoA1IUPBoUn6
	 KEWIO9CHw+zJETqzjgadRTTnIuSX7B0PPAdgebjycefleVctG3+mI6JWw/OWfoAWmK
	 +s1VtXVy2JB3VZ0Nn0k69RJhm9di5v7TEC/+SH3QWPz0//aYsht9kPCU0MFeR15kkt
	 PQlPcMPEAYqSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 282A381172;
	Wed, 29 Jul 2026 08:12:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 015F745B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DBC994009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JWO03NNqYUw7 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:12:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 919F24004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 919F24004B
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 919F24004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bZ+oCY6Up0Clg2lQYcu/1G46bljnxRimLiBys5mMN587qm+ZcoY+I9VOmPXcC2FRoGQv/I5s6G2wMgWDGfefSaApP0CJw9jQ1YfAp1HnwIIxe4YhlqejQicOyWJBp4uIsiL6jTTZXtSG5hWcQJ9P6Pz0GJPlFKxAn7oI/c5+QmjLmvTlUKlUug5t7lvx/nNtzra0Ch8fhL4sI9pehy78h2ZiYXSXhUamW7/BrqJ0rIB8ZAduQnBo2uLdiMvNEjK/aaTEY4/3RD3v3m88iY/T+mfltcFtNUtS2gU3wRqtjsHPM1Z9bwQLn0wt+dAPs5F+lPAs48+4hPx63ZHo7s1sYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+D8BiibKyJM45AnPBx/j1/TrNaMF7GX6KwW4oFVx3K8=;
 b=F8JZCuAH1ueffw4PU1sSNVlEqjC1Bph0SnJwscHRfBWotzqsBBecvRDpJHBAXccGRzPiJoVeyOUrMqKpSO9WlND3X84RHlDEv4uiM+0gbK/MLl5KiDYYLUNin1AlkhS2WxFkYWDnuRsFG+olEQO7pqyAmjVswyuW15EVGQ8ssXhEBNXvViNk7baFWb4CgAzowM1sBcUG6eg1cAIGtWIEEGEqyl/Tv6vg6LVCclAlF1uZiWCL2k59yVVrf3Xjqp4sGbTFkr3ntDsIJKu6MxRbdTUanzHP0tGSrV5etP4ejCF7jt8dLj/Squk5N66/Ek7OmnP0i4YZjSkX/2bPD2z+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CYXPR02CA0008.namprd02.prod.outlook.com (2603:10b6:930:cf::14)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:12:33 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:cf:cafe::19) by CYXPR02CA0008.outlook.office365.com
 (2603:10b6:930:cf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 08:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:12:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:31 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:12:30 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/5] gpio: delay: set gpio_count and validate index against
 it
Date: Wed, 29 Jul 2026 13:42:16 +0530
Message-ID: <20260729081218.550465-4-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729081218.550465-1-pranav.sanwal@amd.com>
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 7601abaa-d8bb-4ca3-a5f0-08deed492440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: H2nFMQ9GIvrf4yqk0zuoPNWtl40s14iGKrGBQxVVtpdhGhvRdum4HKJG7Y5jO/IwzPEsZWoCtrzxlogXvHX6ZaGUfXFeTazZ2saUhFCsbyCbLPjg2Shs/CBTs+kJd1bqeG21ldzWtti/0ZSX78zGf773WvnZDGBARVaRoGPBUBa8xCWshoNFKWLcEzmsCC5zvQL9y+TaBuwuy3V+sEnnaQtJ2XKSD/HwspWWet3HAWqBNHx2ctunHmN2n12ihjrhTC2VU8uDUa+TDnXC0JdQ3kAISTds1OPwxsiaV3ACOk5e5hrERBs38yzRaM42do0mrxA5VujOWxVrGBOWMGftHKo1h5UzPgTih09HnlzD73atsL9n0NjxVpd+c8WEnG2rCGmqWCCSJP6ZdUeLdWSzM5CvHcLyovxORRdzcNxDiY7xF4mW+Fxr9Q/w0X5KwayXhgFFOvRqW68qKYIoWEERwxSnk4zZ4mFXFDQH+vTjDjt7J0tVq3RFa9Y+dixz07ygkoNkyRUyvtALhyJtHd3ua2FyfGGdq6BsCP2QDBsNig9pYC0LZuMcKzjo7lT6FLS80rTBF5jR3jHMCUYEmX/fUssD9BN9wrbUbFrLNcdSO9kQ5obfIvNB4UZOnEEjRB3FIH9RGjGwE9UFWOVpDzcWqUDZwl+Cfxu9klYKrSvd5EXTGnF+gWtPS6a/X4ZRM8BS/QWMtZljrkYx+dgTzHmDnQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +3acDGwAyrcTB6LyVWG89cjct5z7QmT4ziS61tdai7LJDvW7s/pnqaPTIJY9nVUHNnq9TyIf+yShPXB+aIT8tZ7eRNHz3OelTem3kYJHrnkgs+74awsGyGJFxYT0SJKDc4gQ4XwYrl9fZFean/0argUbxgPwx6/ASOG6oDyldptjvqXMkiO5zy/zgcSxO3OMjrOA0dXdmsBMyqfD+wbUbsbJG9KJQHfPH5RUrSAZzpTOOnlycUch3p9/2XDyAfCcHcwmXYuPOwEV7+lN5G3wFUKajtA7/YihmZV/Gv2pG3Hpj7J2J3W3K87c94yaXvzUReYNLzinDgb1lEIeimP/OMx9xrA7trcAIFFYL0m6jBs7IeVm2NTz5VTQVaMrUez+RfryUvwYoQM83YVqedaZRQVyyN+PPigwuZWshRR8v9ybC3EHsRh/sx/K88iII7OJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:12:32.8911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7601abaa-d8bb-4ca3-a5f0-08deed492440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+D8BiibKyJM45AnPBx/j1/TrNaMF7GX6KwW4oFVx3K8=;
 b=OIhfHYebHTxSepscvHLyhQ6MGjn2d1Dw9am4giO36sKphZiGcIdCGcrP5Pr1EYHhRabRfrxbnRm7+VCVnQJ4CeytTKpibDsHTHt6DP2XKrexBc+Kb+/x5bBrld8lnfSWaUUQE8RoW/L/rAhh0Vt9bh9raFCRkW9PeQmDw1r6GJ4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OIhfHYeb
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

