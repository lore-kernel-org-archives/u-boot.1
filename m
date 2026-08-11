Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C554C5CFCF
	for <u-boot@archiver.kernel.org>; Tue, 11 Aug 2026 10:53:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02DFF810C0;
	Tue, 11 Aug 2026 10:53:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z9spM3eJJ5nH; Tue, 11 Aug 2026 10:53:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DB298810AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786445629;
	bh=PqaQTIasvALfbyob7siS+CuWsaNLe7OtlmM5eXPdGpE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJQggF/akJm3KaLWhjTF6Ydh9wURudhsnewFjve9kdBlicrXCYfPF5UDhC7dLIK0L
	 KZpCYhVyouVdHp2ILy/u1MEkkY40blMO4yc+UmsPaXYxZLTOGZIWjKwG260mretAV9
	 giu3LUv/f9imOiIgHZxMsaihjuPneuiPXOxfpl89iBhHGM3OPm/uHETjEU74+EwM5H
	 O6wONPGvAH1LMgQY79nP5PFfX8ENPfYhh1iH5oYO0euybnnHEmZ2B5yBK2W4H8CQx+
	 RezW6u+8tGeyfI/W3NWt3B0IDjTS1M/2AoI6zMtp9raA+Lqp4vSjR775FYn24LvOpG
	 v/Nz4nglZCUkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB298810AC;
	Tue, 11 Aug 2026 10:53:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FF034E0
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 725EF40752
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XDwbn0o3YQF2 for <u-boot@lists.u-boot-project.org>;
 Tue, 11 Aug 2026 10:53:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::5;
 helo=ch5pr02cu005.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C04644073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C04644073C
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C04644073C
 for <u-boot@lists.u-boot-project.org>; Tue, 11 Aug 2026 10:53:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ks2xXUkEifjidciTL6MyEa0V5Cja7Y0zJqCYqLpPs8WGPqRFF8+oO0mztGWR1KvBxhPWqWGYO6xvFQFlXtujv8LGviFzrezjDbL3m46fg3gMQeSVkPoAUsMF2nJ04YK/Za4qmyGp4V70xMqBUS+Pxzq2/a9Hv7fCHx9ING2QyqmB8sep2e9oroEknRm/+tkhkDJlv8rBTjkdDn/3n5JotodCryU6F5eUbp2WF89WLnfI51dFMkzvVUeLsguX/oZu4oC6xWhG1L/knMCpbIzpiKLVTRcIEsx0IIV9eAHti2XxDypyA3P24SGp0iyQ54zbHuf4N6Gc+xNKIESlVgX3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqaQTIasvALfbyob7siS+CuWsaNLe7OtlmM5eXPdGpE=;
 b=IMVIOePNImWKzfY2psqEAA9LfHrgOn1Jz++tJeA1RdmlbFWwS0vd8mVDnSYWpR038fT/RiuoALhqEyUwZbSpQAh3aZKHQmQuf2pIzVcfUDJB3m5ZlGlugJTjSRFjMxYrm70jq3865CtoNMM79mjBJvFeg0opGwo/93qBpPm5n8nRsuxXasN0Dml09GktIbTOwhHceq7DwON+vp6vj6PsgMhGNYiQtaUBtMTxeFUwXGJFNcptcmgQGzrjUcfeP3hfibSSyF08HIDpLHhgmnDTAoKob4V1XV0aHxvvoQfBn6piKkMKhRtbfrviejk2hiPjdZYgix+nPKmdvCKpRZYpJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BL1PR13CA0262.namprd13.prod.outlook.com (2603:10b6:208:2ba::27)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 10:53:39 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::76) by BL1PR13CA0262.outlook.office365.com
 (2603:10b6:208:2ba::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 10:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 10:53:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 05:53:37 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 11 Aug 2026 05:53:35 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/6] gpio: delay: free wrapped real GPIOs on remove
Date: Tue, 11 Aug 2026 16:23:13 +0530
Message-ID: <20260811105314.3837228-6-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811105314.3837228-1-pranav.sanwal@amd.com>
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8ef95f-12a2-4146-b52e-08def796cca0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|11063799006|56012099006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: C8QukjKPYfhwGR8QlerI06zYPkV5Maf+UB8LQa7q1Sl2+ZaRf1zn+oWHmpvMexFWFFQrVurwz3YPb/qfGCMGQ72HJa1xfaceoWEsU3OM3BrDaR/OPxiGdcouIFEZ1REipU5Iisas1sym2qSyrA+W4o0OYVkS6MarQggOyXsR50jLdc0vtFiAwVGmhvNEQ7uonJ35yrTVRgc3Xq1wcBiBGVFEsm3SNsOclCtMFLlGKj3+OYhL4uX30yZrwCnYfIA8jrwLogKq5NIgg6Grfia0RNauzdsxdRuJfHaWrJ8//y7bE5YCQiQ+9MW+TlXco2zUoNEDB096n0Nl2GaB/p0iwuLQ5MN2rBHu6Q+tIALD6vfCrhHhrKRu6U0pFp+16ZoPAZlaEwRdQYHMXLhSnRAufi2oO+gGLD4TdUHTKSvDy4R7qeGozqS3OiZW7ap2Qfj9a2KquQi7E2ybiug9iuAmGJ1QxkWEwR2nG+LM+OZsjbOlfiw/VghA5BkhA81KxG/q+N2M1ab6vfAmDRJgxCPxD1FzkTaPilirLN6RtXF+sxpAcny15D2kCt/DROJNrKwMNiVCgvsLLU43+LhfmkQftHBV1sfWt4NFIu/i4+6YtK3Q2IVJxNeD75+yocEJlAQUSyWhN4++Z72t9fBfLVFWcUQDeU1p6E6zecFL0w3klvL9e8CxaKngdX8i5oIqnKbQUvW9ATU4mBgCbbLFfhUz/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8RLLxSoROuz8nHTZIMMLThH1SI7Cg9jGyW56fZo0YFRISV5bFPqkYeb3QL5pcE5s85XFbAv7RJVIQMEwydE4LHkGZFAWviY2NkbXDFeF935qWaAg7FgT2VMq7y+hGwxzwAZ9aDx+J1RblJmMAxsJFD44dvAtHsmYMy16uR3wXr0uFlqMLDspp2o38FY4G3xhw8zD0fF7G/5pTspLNspFQEnxuqY4dGUFH9LI1YgwsAlf6Ev6ImC8a7nuEajBMsBnlRwNMaow8fR484gkIyw8njN/2zi5cRUnDSipl5DQvs4IR9qRkOeM5G3PF31x3SmwavhQM69+K6olM7voDBolRXgDs8RSY5R4zxemOcl4ZYOA6nP7yGmSlibSd69nZRWksFEzpiZcSUzIYsjtZ0ows24ZJSEtTF233bVLREdCykGcvnpBP25VCOFR6U57gPjC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 10:53:38.3004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8ef95f-12a2-4146-b52e-08def796cca0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqaQTIasvALfbyob7siS+CuWsaNLe7OtlmM5eXPdGpE=;
 b=Hm1joSTpfHe87WGSmvFXxRNZ9WgMMYCAp/EPuz0XXtQEbMqqc606Ihsi1heWzyhjxJrwmgZiWKlZamxJgLiS5YBjm8M7CFBCaSY/1HY3qVo0ZPWMp51tnu68SHc6QoRyBNE7GIIlP8Bdh4XVQmYxHl+WBrngrQf/GbydquMINwM=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Hm1joSTp
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/gpio/gpio-delay.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
index f6c9c7efb0b..27fc59b5ee4 100644
--- a/drivers/gpio/gpio-delay.c
+++ b/drivers/gpio/gpio-delay.c
@@ -90,6 +90,33 @@ static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
 	return 0;
 }
 
+static void gpio_delay_free_wrapped(struct udevice *dev, int count)
+{
+	struct gpio_delay_priv *priv = dev_get_priv(dev);
+	int i;
+
+	for (i = 0; i < count; i++) {
+		/*
+		 * Generic DM teardown (e.g. dm_leak_check_end()'s
+		 * uclass-by-uclass destroy) does not guarantee a consumer is
+		 * removed before the provider it wraps, so the real GPIO
+		 * device may already be inactive with its uclass_priv freed
+		 * by the time this runs.
+		 */
+		if (device_active(priv->descs[i].real_gpio.dev))
+			dm_gpio_free(dev, &priv->descs[i].real_gpio);
+	}
+}
+
+static int gpio_delay_remove(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	gpio_delay_free_wrapped(dev, uc_priv->gpio_count);
+
+	return 0;
+}
+
 static const struct dm_gpio_ops gpio_delay_ops = {
 	.direction_output = gpio_delay_direction_output,
 	.direction_input = gpio_delay_direction_input,
@@ -142,4 +169,5 @@ U_BOOT_DRIVER(gpio_delay) = {
 	.ops = &gpio_delay_ops,
 	.priv_auto = sizeof(struct gpio_delay_priv),
 	.probe = gpio_delay_probe,
+	.remove = gpio_delay_remove,
 };
-- 
2.43.7

