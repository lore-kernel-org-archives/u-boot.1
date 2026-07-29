Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8683C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 05:14:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED628607EB;
	Wed, 29 Jul 2026 05:14:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DfJZozoCo9tv; Wed, 29 Jul 2026 05:14:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5F4FF60AA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785302052;
	bh=zyfsRnwg4UYxRktV7JOE7UsHJFtqMU6AIwJRcdA9TE4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IdTZeD/uPc3CnOXlfkoysAx4n5sgFMYE1KHEhB3NHu5Vh+BNBoL6acWZF1Q5Ri7gr
	 M6HLF9+2Poojxyr+xLO09hTbjNVP+CxWky0sKjTFPtFS9pa70gsYQgOa9QlSXIKGlO
	 MIqlVfXSY/oCosx/Pdmsmmti0wcttmk5kghlWUAP3U0rYiwFgsB0rFOQXICOzuQ9HT
	 Ep8s6Psko/BVC9pwcNnIUbHgAW9HL4ueqZZeUaXMhVrn9rEuoHLtWtN/kIvnp8eU7C
	 2KuYxPqw0kKguiN2vuvZvZsBTiK6rkcjKwATY2zMYU3xmzL6+Ur5Pu/S51Sq/iE1+9
	 gNZHixxAKB3GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F4FF60AA4;
	Wed, 29 Jul 2026 05:14:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F362F977
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9F7C81082
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A_1f0JiTqUeU for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 05:14:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 93D67810BE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 93D67810BE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 93D67810BE
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 05:14:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B3B48498B; Wed, 29 Jul 2026 07:14:04 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48FC38493F
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 07:14:02 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8lW2p+VSpL2pjwXSmpC2XYWdgmly2O+NUpQ9R5/fKrzWbykq4KxCD42T+pELVbToCLIX0v6Sg6BpTsjZQA1ar2MjYf69IaWp0B7+xHDJjEadDQFA5LF1XeeF8BGXZyC2ez2yl0kBO6q/0OCjtTHOmLx72PJlbATDpaOZ6rO3661JoPYey4/GyyWks6pweJvbFhO1f64uABa8L4kF2p4zxzd1TQibqxhbcBABBHV6JXRbaYjyP3xJnyZroyU7DmU0S8uOI/EAui4WQNOhNt4/gQwYax8FinD2roDmBBSuKK05w48YtzAx5iy2DDwacwRI16z6G8CnlokTuI2LmGe1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyfsRnwg4UYxRktV7JOE7UsHJFtqMU6AIwJRcdA9TE4=;
 b=HXUVUdrHxqnKTpjFlQ7xEppMXZt5uuOF8hi2SKHFyBzwG+Rbbw9mh8LVgz8BFNa2HLNByX9XESRJ6PuwIZivlWvaGnuAnHRiLe1t07ZPJJNbJhV/x1K6BtHIBHTdBG0Vfxe5ZxAnCHJFeoZoC0uql7BF3RmSID8q4yDLfyZ+hzS1VTeIn8FRbKDxLdu98WtI3lh+OTX2y9ffDsd6RupeYeiYDsuZ2Hxr4N6DrtJJvjo0Bne9SgI3ZQvXLEJQXR7uG6ARQfxqxGv83NIwwG4s1E3oJkymmtPwoPQrg4YruYH2tO5SlZR0hqZsVq9PKOR32EKSb0KgG694dw4JZoJ2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 CY3PR12MB9607.namprd12.prod.outlook.com (2603:10b6:930:103::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 05:13:58 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::5b) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 05:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 05:13:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 00:13:56 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 00:13:55 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 5/5] gpio: delay: free wrapped real GPIOs on remove
Date: Wed, 29 Jul 2026 10:43:39 +0530
Message-ID: <20260729051339.221699-6-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729051339.221699-1-pranav.sanwal@amd.com>
References: <20260729051339.221699-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY3PR12MB9607:EE_
X-MS-Office365-Filtering-Correlation-Id: c0e16b02-3172-4ac7-bd4e-08deed30317a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5AU9pSQJYntc+uhQ+7Y0e7Vt9JqXhKfwLfogGawOWTsK0ddVfckkrNvwH6QiYahLl62wmDWTbPjlGysI+hhmLKxrYMupN9rlOQgEGHsM8kxfnFgqymIT9jEdxx4EuhZApGtuJUUVsI2bgkJCd6So7JTStyPyO3f0875TxfDTZQwsty2+WRGdFXcJvTiGckPYXy/NU8U2jvkue/sKaiflcFfaHZdZRf829SY5MeBXb7UcbMI/iluJEja28LVQeBRRIkr4h1jxXmLxbm2SibcC2dhZfPBT4nHiPTOI0LQ/HAGrcvsfoI4pAOeC4KWL2R6A2X4gBW/JKgQmr3zeuuXD98uF7MaMN33+3ex/MtWQ6iY/hNZpecyRaXRzXvtiV2vXe2OI2rznOI5cibZg0C1ADuNrG/Jf98+hKQqcYjfJt0zfQq1/w5268UOYoQsP9jvlsSoopiZd6MpP3a05zfnKaU73oCa33p3AhBdqse285A28QJBfAlonB6qEyF0VQslX2ZuKVjURiSUgbWMUJpoBriHYFScupRWS8bs6n7wxbUF6d2ZnswORMNZLGJfiwKRxRruVPv1Dp0IZDQrpQAMiWfbQb7eqxz/0dzq7SAmT4giWwdQZ4+ngOmc0Lrgg2Ll+6YSUZ9BiGTdYrKuQ/F9wnPqul+jkGUOYnDHtav1Ty83+R1szWdAQhVwWceQKnHr7
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RKo1FbUPznjaGJuseskMvRyMFH9m0CAoFCsiuO44lP4JvLI3Bt2l9vH5nFZSzuLTeE4dcyJoX4yyy7xKAtc3Toa/4tpHBihVVX1+3xrfoN6o9l0KEKJfeoxlc+XdZVn1tGTauDLzh+FzIrMlZWo4R5wuJc7XZ52YSooUhxQ0Qpx6FADRP3MeNa1FD4emBr77jWh1xa8WYPo648jS/flOSTyJADlRuFOLWBTB1CMdaXD9ui9PupslLvSfoT7+kQl7i0tg5VIOpdXtzMGuUhOH0SQ3GMYYiZ4IsRRN5beAxvauqEgZFYQRGSThtuaY74JLaw2wGSJQzac+ylrf23Retp2Tgb9FKC+izZZw5jhoBGU5m7Bez+YHgRpUDJkaLwOfRXdi1LKfuJpCinjS4zJ2on1qvH+MAr0G7h4W9AGmwrtCS1O29N1JxhHZuZ9da4tE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 05:13:57.6656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e16b02-3172-4ac7-bd4e-08deed30317a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9607
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyfsRnwg4UYxRktV7JOE7UsHJFtqMU6AIwJRcdA9TE4=;
 b=uDYlkSdwOUGaPd5H7vPsVK/PWrStiI1YtWgSZeAc6c3oj5sSsf2EHg/yQz3JKJREOncNPiVhXw2x7OOzhrMrJqttY3asX/tEhX1+bM/4jTsy94iEBmbq2l74myXBndcB6A3wqQWFxejojQMVEgE2A93J8mdv7nvqkf1bLhL84ZY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=uDYlkSdw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=fail
 smtp.mailfrom=Pranav.sanwal@amd.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=amd.com header.i=@amd.com header.b="uDYlkSdw"; 
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

gpio_delay_probe() requests the real GPIOs it wraps via
gpio_request_by_name_nodev(), which strdup()s a label into the real
GPIO device's own uc_priv->name[] array. The driver had no .remove
hook, so those requests, and their strdup'd labels, were never
released when the gpio-delay device was torn down.

Add gpio_delay_remove() to free each wrapped real GPIO. Guard each
free with device_active() on the real GPIO's device: generic DM
teardown (e.g. dm_leak_check_end()'s uclass-by-uclass destroy) does
not guarantee a consumer is removed before the provider it wraps, so
the real GPIO device may already be inactive with its uclass_priv
freed by the time this runs.

Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
---

Changes in v2:
- New patch.

 drivers/gpio/gpio-delay.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index f6c9c7efb0b..78e79176f3e 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -90,6 +90,20 @@ static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 	return 0;
 }
 
+static int gpio_delay_remove(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct gpio_delay_priv *priv = dev_get_priv(dev);
+	int i;
+
+	for (i = 0; i < uc_priv->gpio_count; i++) {
+		if (device_active(priv->descs[i].real_gpio.dev))
+			dm_gpio_free(dev, &priv->descs[i].real_gpio);
+	}
+
+	return 0;
+}
+
 static const struct dm_gpio_ops gpio_delay_ops = {
 	.direction_output = gpio_delay_direction_output,
 	.direction_input = gpio_delay_direction_input,
@@ -142,4 +156,5 @@ U_BOOT_DRIVER(gpio_delay) = {
 	.ops = &gpio_delay_ops,
 	.priv_auto = sizeof(struct gpio_delay_priv),
 	.probe = gpio_delay_probe,
+	.remove = gpio_delay_remove,
 };
-- 
2.43.7

