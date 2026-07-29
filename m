Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B01C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:03:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA60F60628;
	Wed, 29 Jul 2026 12:03:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUMNQTwdAI2S; Wed, 29 Jul 2026 12:03:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 15D1E606C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785326600;
	bh=IuxBPAlvXIE0IVCPKIr1Zczym2WHbCEqs+9cIpeT3+0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GqAlcSVA0N58gtX78AwYDglfYsVJcWuzcKfBLPc+4EnApqwcHhImZEkl2rP1BrUTl
	 3ASmw/XmFcsOlrl6TJ1DeqKXjwumA8xch3OX2XDLZMAy75C8QQgv8d439LnFyMQaZa
	 VY7p9fTGiErZmyt2PHgzcWWQ2Q2svIPprPp+8iL/wnec1wwMJEKJw0ll48KZimGBPH
	 G7XBwn8RqRP2KPa/dpWNXM26C2nIy5DT5lYP6xPWAIfjwoP3v8YcdN7WJ1XQdjRaes
	 w99P6SUPzMovTkZePSPXQHaWa5VK7aKoSDxclfwHbGKJE+5TL2yJPFIUORpZ1zTsS0
	 ETv519GFfGzmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15D1E606C6;
	Wed, 29 Jul 2026 12:03:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id CF1323B1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B43A54025D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upfGJe19SdgG for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 12:03:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D7B28401A3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D7B28401A3
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D7B28401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 12:03:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atZBU5D4UY0jOBhvTCNie4vM9wvYociY2CX17ntCjqrY1cgdDgf+IS78WAZcykMNMvZ2kM76TgH3Uzt5EqjSFTGRTpeyvfeYVs/PMS0SQYKtWCzipRxbeCeMOLXRtuxanQdeOixMJrIJwfshmeOJdmAtn1ICdeVgAe1EqwndTbT/MQlgVGlLLmOKrJR6eB6+ZLCwxfir37Oz3pyUk9w+z6p84V45/ucKvjg4fd0NVYXV9ErEi9txjyrTe4Bpnt6xWLSS9wVDtGq35DtNdfKFDarO2O71j6hORsprdHYTLClkFyGeQY9tCOBWz5cRFVEPVre3179lzDfsAVLKg/ltkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuxBPAlvXIE0IVCPKIr1Zczym2WHbCEqs+9cIpeT3+0=;
 b=lTn+WZJp1Ctr+tr1cKDMfItYMoNgbxnGAzQYW3NvWvD9QImMv4isdfJr5l2361FG7u6IgAV6mp+dy1oNrZrlZKTUE1y/tCYiIAjExvcB+qf1qz+UaGHhm6InRB3juc34vR0v+zdqlX0ZKehMT73jc+m/qTr0Qzw5DNNUYF17HoBrG7KTvLvGCCyTy+FKQctsTl/EZbHNIwviSr2RzuMI++zLyFsBmRsPsJrI6wjt/VuILKWl8uchGy/bRpq16crPNHUWKs7z+gJc+k+ZBPk7pkPAT61ccv+BFzhP7txeoc9Ir6j8y1TkHF20iPhmdLR/PFuKeb9AzLGUylfZWyMMEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by DM4PR12MB6592.namprd12.prod.outlook.com (2603:10b6:8:8a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 12:03:12 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::3d) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.9 via Frontend Transport; Wed, 29
 Jul 2026 12:03:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:03:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:03:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 05:03:09 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 07:03:08 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 "Tom Rini" <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH 2/2] firmware: scmi: Support probe vendor ID 0x81
Date: Wed, 29 Jul 2026 14:02:48 +0200
Message-ID: <978aa3b1dfbf12798918c1eae45d06da35275b21.1785326564.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <9ca09685b22f3d2a93a63ebb7b29ab150b07eda5.1785326564.git.michal.simek@amd.com>
References: <9ca09685b22f3d2a93a63ebb7b29ab150b07eda5.1785326564.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+YSPPDiUonhgUDYeEtTVUBsLa3kWj0u0ms4GzaQhBgA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRlvn7D9n/J7btuN4I7Xv13aVUtWnNHbodan5RW+22V7
 b6HBNMPdZSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBExLkYGT7UfTq2oPONpeMl
 pjtrNQ4u2bx6VWL61WVPGw9O2RJj8X01w383+dvr+j+4p7vfO7n4N0/hkQJRdxv+DK34N1Kr0lV
 eMvMCAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|DM4PR12MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2db33277-f47f-43c3-a7d0-08deed695c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|56012099006|11063799006|3023799007|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZYWdPMQvQuWBoXmyXmnXl5cxFkEH8OPU+ma4d8wU8aPTtdnNnk6dlG/5c8RqilK3A0YvqHvXeK3DXg/cGTwuNPpBfa06ILYINiPxIWgqHzr5vkIfCiXhQETGeTDs5IWnybDU9rr1a8+1Cz7iWxLplXeWCxdtssX56VJPBNyA+CkJkFUSYNVNgKopAu7YH336hMfN1Z5EnuK0whun1pCSg2PLXytwkMNwX2h/JBlhQKIyDSx7GP+Ri5hEWQSX2s06ygZd4EFkWxnUrSvIW3HExPZBYVRlEjh5837uTRCqSQVHEEvNzsTdqmVP5G2PAhxaGfJ1nCBoYTsYWzisHW4nFNahnjgnoJg7qbn7AvvQYgwyfjUKVksEkLgtKuKALij8KjpxYSGrgntw0Q2h5Hn9IvwPRbaO5xKN5qmPoyCtc0tHQG7MWhIkcH5LFSPuVLaSMA4u4+xKVsKdGL0QH4x2MIg+psNAmXfz34zTo0hibR6jGJZSFRAYjH5F/lDE4AI2V/VvAe5MB7+x82JMtSvrkFlQxhPg+xpLjTUlNxUYINaKEf9aB16gRgfAwVlvQa67wBjLRA5rsZHIWrF8ZVWVkmLPQTqv2R2lqCdNoY39aNYIszd8jtzNo2LS/t9g6h3FpU+mltmpFWqStfiZLd/PbsA8PyQ1nFxmzc6NE3i7Fdm38y3ajCoZRG/9OtC/O4yYh2R96XKPyABXfRRFJFERfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(3023799007)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Uumu1WZCJ/bxGIwHxhQmRVD/ZhfdbupM772//OPVBwpCgSxpm9WFDv9SOEkZS+Z9A7SQUcCkusptFVNNPjHA0RZArf3cKjkZ2ZgcsQxy7u7rn5Bbz2FIhXFvMXamHq8Nbmqo1VHhJLzBXj8fRowLmhtDwAvlnqk5HJpWxz8jZi+QsgbKBAmAQFdnBFnywZps78Sv7Jln2mttNlcduMvrIIx1mFwcjhl5CIa4+oEboIgtfiGgd+fX/076Q2bHG8YnS78cBAhLgEzYoqS+z2DTOZTPC0oU3E+fje81UElwM2Hun2/lg9Aw/sYMWvI773gLfdIwLJDZG/FE/K8NaUfstOoUvh4vc7UkWL6RTZyBLeXMQ2GwlEae0D7jjAwtEMHirIKFu+Co/wQE0fF+xhtw/XFLcsVGCTyGcUbNTz+3zVWcyJNaaCSJUDY7ATcQVzJw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:03:11.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2db33277-f47f-43c3-a7d0-08deed695c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6592
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuxBPAlvXIE0IVCPKIr1Zczym2WHbCEqs+9cIpeT3+0=;
 b=oXyKLEGut34/n8WAfgqVS2DAtb+bqy36I/z0tfgQ0Om7C7Kxm5e1rkzFAuw2wWKqNkOvUuJMosDca866JOb6xQ4PChN33gkowXkd/qMXeus27dl4b0JR6MqiceerjOpL4SA6xdTkeOCBBCYzj/5Rtz0lyPbf4gz4qxnzp2vmUNQ=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oXyKLEGu
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

Preparing to add the AMD/Xilinx SCMI vendor protocol driver, support probe
of SCMI vendor ID 0x81. Add the protocol ID, the per-agent protocol device
slot, the probe/lookup switch cases and the scmi command name, gated by a
Kconfig option for conditional compilation.

The same wiring has been done by commit 7830ccc77a13 ("firmware: scmi:
Support probe vendor ID 0x80 and 0x82").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/scmi.c                                |  1 +
 drivers/firmware/scmi/Kconfig             |  3 +++
 drivers/firmware/scmi/scmi_agent-uclass.c | 10 ++++++++++
 include/scmi_agent-uclass.h               |  3 +++
 include/scmi_protocols.h                  |  1 +
 5 files changed, 18 insertions(+)

diff --git a/cmd/scmi.c b/cmd/scmi.c
index af9743145835..1aa20c7bd961 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -31,6 +31,7 @@ struct {
 	{SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN, "Voltage domain management"},
 	{SCMI_PROTOCOL_ID_PINCTRL, "Pin control management"},
 	{SCMI_PROTOCOL_ID_VENDOR_80, "Vendor specific (0x80)"},
+	{SCMI_PROTOCOL_ID_VENDOR_81, "Vendor specific (0x81)"},
 	{SCMI_PROTOCOL_ID_VENDOR_82, "Vendor specific (0x82)"},
 };
 
diff --git a/drivers/firmware/scmi/Kconfig b/drivers/firmware/scmi/Kconfig
index cd912ebe4096..64bc9aef5af7 100644
--- a/drivers/firmware/scmi/Kconfig
+++ b/drivers/firmware/scmi/Kconfig
@@ -46,6 +46,9 @@ config SCMI_AGENT_OPTEE
 config SCMI_ID_VENDOR_80
 	bool
 
+config SCMI_ID_VENDOR_81
+	bool
+
 config SCMI_ID_VENDOR_82
 	bool
 
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cd458a7f4588..9159e59385b0 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -116,6 +116,11 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 		proto = priv->vendor_dev_80;
 		break;
 #endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_81)
+	case SCMI_PROTOCOL_ID_VENDOR_81:
+		proto = priv->vendor_dev_81;
+		break;
+#endif
 #if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_82)
 	case SCMI_PROTOCOL_ID_VENDOR_82:
 		proto = priv->vendor_dev_82;
@@ -189,6 +194,11 @@ static int scmi_add_protocol(struct udevice *dev,
 		priv->vendor_dev_80 = proto;
 		break;
 #endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_81)
+	case SCMI_PROTOCOL_ID_VENDOR_81:
+		priv->vendor_dev_81 = proto;
+		break;
+#endif
 #if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_82)
 	case SCMI_PROTOCOL_ID_VENDOR_82:
 		priv->vendor_dev_82 = proto;
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index c40b448bcba1..c9d77ad8ec7c 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -58,6 +58,9 @@ struct scmi_agent_priv {
 #if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_80)
 	struct udevice *vendor_dev_80;
 #endif
+#if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_81)
+	struct udevice *vendor_dev_81;
+#endif
 #if IS_ENABLED(CONFIG_SCMI_ID_VENDOR_82)
 	struct udevice *vendor_dev_82;
 #endif
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index a8fd0a5a729e..801912d16a92 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -26,6 +26,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
 	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 	SCMI_PROTOCOL_ID_VENDOR_80 = 0x80,
+	SCMI_PROTOCOL_ID_VENDOR_81 = 0x81,
 	SCMI_PROTOCOL_ID_VENDOR_82 = 0x82,
 };
 
---
base-commit: 264994658ecab72cc292f8ce433469b01f170e5c
branch: debian-sent3

-- 
2.43.0

