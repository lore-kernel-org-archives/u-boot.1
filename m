Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB8C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B20CB40B4C;
	Wed, 29 Jul 2026 08:12:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B6Rk8Ht3O3Ym; Wed, 29 Jul 2026 08:12:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AADE640B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785312768;
	bh=zyfsRnwg4UYxRktV7JOE7UsHJFtqMU6AIwJRcdA9TE4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e9mEurpSXOesrsmoy4qnjs3xohF4BpLH8ryNuZRkR9C4ZIJ1fvcbmoIAQ9fDLtkt1
	 0yVCq5s7bxSOQ4q9qYWJmJs1SacJT7Ty2SDpwJIwzruhM9nDPMqTe/1M3cmMqv7bHh
	 uV+MAefB5Sc1uugiHupazlp1bn/oHXA60PBqhTrn/QGnenN7lnTIFrvh12Hi3jDm5K
	 Z2wieVdTo14DULWsXBgljX6k2kr0KCA6wyYU5S3rYhPblsgKs8DzvQa8TO1lDGCwQB
	 iypQPMd8uR8SOWPv+qV98MQgsvbaPkZfARWX1SEXq6smxm2N9nChdw6e2POTk+eFLu
	 AJSrY3u9yR/lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id AADE640B42;
	Wed, 29 Jul 2026 08:12:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DE2A23F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B5EC60ADC
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_TrxSuyheXK for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:12:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 46B3A60AB9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 46B3A60AB9
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 46B3A60AB9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6bFRhsuvO4lkThEUF+87TmAT2PW4nYZWTgUYptLbV5fX+33Oip5dLfCG3mKglegEYnjMtKKK6wiCL6SYtoXsiCjspI1qyPxN7SWONmL4zuSHUKidPmvRtEmxqvcN/E+zW9kckDaNcVJsCss2OPk78oWAfGwJEjKnHE91q4dND0jqIIwuJTwoC1NWnQ1RBwRDpUOosh7QtNj76J6zv9KVYhklzef4vkS62ZFlngJ2mVv/1J6LwKlhLXt6CCoZr4HbbarrxTaPVl2KDrCKJMmMBzlxBZEhiW9OrKLiXlBugZHbP/Ncti0WeZKfJvhzZM153z0XU6bZ3wl6jgBOS7+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyfsRnwg4UYxRktV7JOE7UsHJFtqMU6AIwJRcdA9TE4=;
 b=vq3StbaIq6p+umpY/s5KN2FWSmFfsJbhkLofnEGAz3VF4qRMcpBt9oCfFNeCizia8KDF3c3niikTANmcMCDcTu9TaqiHThECs/G3jqtbX0WXDxD4uiGK2VPSzYf9q6uyd6bU4GqcrZZky4JJpDp1Rf8Mot0wx+BUDe3N5gwKgvxw/ok0KmIV4gwQsKUioUtJ6OH1LB2bsHk24gQPT3R4+tRS/k4QE47EC+wj6MX47QeuHdyLHlQnXBMT9nLGs7SO5ZV44znEetBxGsgbi0nx/Vatd5Fv52dYepsvUFe6GkLyXs7MyUvNWUWX8QrQZ0Y8QlAFnEDk/Q7hS3kGxvRASQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH0P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::11)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 08:12:38 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::91) by CH0P221CA0009.outlook.office365.com
 (2603:10b6:610:11c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:12:37 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:36 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:35 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:12:33 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 5/5] gpio: delay: free wrapped real GPIOs on remove
Date: Wed, 29 Jul 2026 13:42:18 +0530
Message-ID: <20260729081218.550465-6-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729081218.550465-1-pranav.sanwal@amd.com>
References: <20260729081218.550465-1-pranav.sanwal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 7440994d-cf90-4109-579e-08deed492734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|376014|82310400026|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: w4DA/oFM0zQtDyEriOEOQtjB5i+5ILhVJOfdxdaGoGHONtfYP0Gw9rT4YvpwKOOqGzLqT14WKI/Yj9whdua6M0LJA0q1MBYdeBZQD9APlBYp8w+PQJe/rsZ1hohNl0ZS2x4mBtxiWI0dVd/F+VLT2hZgtXlSehKh2cBtePu7WR3IcLr9PCRglyu4knHY58cEhAl0rv9nbZKHsUJUTbI81wRfrvKrgdAIs+D29J+TKsJSOTXvvc5vC12it7tJv1cz9uN57GjlHkh/r1BYKpvH/+2iq7EZ4A5bYFKmkOlUK1gYqVWdP/84x2baJlGsGPp2TrbCs6NHXUC37Uyly9teK07HxaLVgASlJRU9dEXsuJcgEky/oZjMQZ5Xm+w0CpSgZKzKjGRJuGsoy1KnGq3YTtxOBt71YV+9PPCG2rItg6gyZgKW6fiuuFPESW6r2esERNIpAfKVilwIV0MMHJZXz6i6rvj/fAnlxB3wQZ1Cl99WJLglyK8u6BqBQ4q/IDxtOuFosJW6+LJPNhdJ2pKGjHLBsvulJnyEHjasS8Q7FLLYaOdaPttqYJtl2aMksbBUKVUThK40ZvLtjRJKxVP2UzeCkxx8jniDw76WSPzTMP8r7c4llfGpaqab5zCkKHzx5zgl13oyB9ESTH6CnfvkG7LL0uvubULcS7cgVa+MpeEOD+SGBIohmn1xtG13CjhH
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfqJcPB60tNAyZhMhdQkVKnHPnCZEDIYt40uWy2OhNhOzpUMgSsgsDU2akCE51GQOvoo7PEaSmKbtZu0iHBrSEXBMEu0yTvRX/al9tHvvHnTCf9xKJoYQ/J1JbA6d06m18F4pMprAhn7J22CFbl0cCM+GRB+htwMbkDvXCNX7vsCi8X8936tG8kTagObi6T0rOIf4UEipsLEMZwEDKS2+kCJLO2iBibJCiV7DubKpDQ9SVhlQ5QvANBq7YdAoXYzxIRH5iHycyBHWw0ds9oL88k8lAIY4MiUMvjLlt2lO2Z06A1ExHor/yUCtQblHBD1Z1GWecVvkOS1qX1RN4EXB6auHGOraSUxgQ1pOhXnW2FWliM639+jA2+kE7m1ACsnHDB4q2RC/ntvEwaGktzTI1JfNgNuljKbK93i6hax0xuTCYMdl4C7UpU5tWw71BzK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:12:37.9013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7440994d-cf90-4109-579e-08deed492734
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyfsRnwg4UYxRktV7JOE7UsHJFtqMU6AIwJRcdA9TE4=;
 b=XPepJ+KzJDFeMXG+ElHFD2UTB0+inDZNDX7xUVTj34uc4gZkD4vday2W5MlRWCHeLrhdPsXwZEav5S+BIxvp1haTZuiQ+d/OBIneZO2jBz5FaG1D76q2s0K3yNpYD1SI/sDZBASUupwA6BhGf5ZMEke8Qjdp9hVd+fzgSfgkpiY=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=XPepJ+Kz
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

