Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87BCBC3DA6E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 10:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 014C187A53;
	Mon,  8 Jan 2024 11:54:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oxovODLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1049C87A58; Mon,  8 Jan 2024 11:53:59 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC2287A4F
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 11:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mza82owuvt1tuq+2j0RxalamdW+jbpudKws7XTol4mr2IE1H7qml9ponIwznwOCTHwTLZUMmcBo/pjmbQ0yRzm2reSWJsmmCP3FG2wcCjtfjMbta6fYJE4wwcSlmxlbwrYYyWO+kI35Xjh6VkFZsi1c0i/hduFfT11xACQC7E2583UeiNUIyRzWEi20V+9aJFaWeDHp+nL8vgGyIhswCFX9bDZNjjapBFoeqG/KU4wkLAXxnBbcKRshE/0bkP9a5PVrqj5L+8T1bzGWjMpG7MkNkcr9H/zQOMSW1M+y633FtwoPSShj4swPAl2r7si/45kimBYevZR+ifKUQ+Z97FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRfV/tgj3QIHifWWrup6WZRk/BQo4BMtR8yl++xAm3o=;
 b=DMnPsz8VbMrQ2I+WBixwyGC5MH7RNO2ObsR36XBpYva7w/AXqHc/KofXSD7MU+mJ+cHOz/PufL8OU1J+1YSKqBfCSV28gCmo3XKNxNiq4ppATCY7DPib0dYqv8D8rwFNfLRJ2EWhXxSAXhHRBVPHop+H9oDeCXOFIsl3G+iJCkhNHGI7+z5zElZ5WfG1Tu7DQbS0pVWbhuLj6NbxCQszOFQgA+yvQtk0yIVZrsPFhHjam7GS+aGdsgnaIwb2o4wAfvYL1cXgcRX7AltHnWpHYrGDPhGtEV0qEDSTOJUYBLgIP2GzDfh5B5M/j15cCayjhjK65Wp3ODilTGZggZbI8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRfV/tgj3QIHifWWrup6WZRk/BQo4BMtR8yl++xAm3o=;
 b=oxovODLQVchknMa/mK23HYD6v7HV9Dq6D3RpykujK7ZR52DbUpVp9L5KkQAjoB9dzze/EsXetnOdlLz6MyVrtiCVmJVtuBS2jE8LNSDMXxBrkZZRLBJMWmqrGd+/ifZzRCNI1X0gYU1RXYrFAICxi6qDNcxKIg7gZC9gaaR+8YE=
Received: from BL1PR13CA0425.namprd13.prod.outlook.com (2603:10b6:208:2c3::10)
 by CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 10:53:53 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c3:cafe::a1) by BL1PR13CA0425.outlook.office365.com
 (2603:10b6:208:2c3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14 via Frontend
 Transport; Mon, 8 Jan 2024 10:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 10:53:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 04:53:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 8 Jan
 2024 04:53:52 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 8 Jan 2024 04:53:51 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] xilinx: r5: Include the sys_r5_proto.h header for future use
Date: Mon, 8 Jan 2024 16:23:39 +0530
Message-ID: <20240108105339.662755-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e0d9dd-e7bf-4bcf-0dde-08dc10381aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26+qo+kB1SjeD6Y5r5BNynrcswXJ2RiW2i/VFkr1CWHeW0flUx0a/6ONrwQWl21+WHzBs0dR1CcQjwGYHdVTbBlG4T2ClGS8BvLEJzLqVCYG9jA2fZGVIaDKmx4AKCOngCznv3uz6MfS7S/ccmklN54SwqhxLBOmDBddkRqPysSTFeNC6VJq3UQb5lmCiRy1u7IBcKvMYYwJQLKGPAfyLX2MUqo6UsAVW/Gn076XleOzixY8b22CJnDVa2IM6iwvfAnGIgIl9AwGTd0tZ6SFdoHCLvkD2KQBnx0S0dOltta6s/Mcb3km42RWuRr4Y78Ygo2czyhlltJT/lWbjlueZuR+H/wbwSGtrny6R9+NuctK/utu+jBbVnia2c0Oehr8/QQLnsCy9WyXUxHq0Sq8SJMBb3bSiGJj1DyXIeSew13wv21IjX8Dt5Pg2j6ZhK8BFnLAEPBpUGz/szPx0vkCEZ7vsYixU7mQVGZhF03Z6/irhIPFtlZzhgFh9p7dBlOqJ03VmYhGF8Oq+QctFu6JVQR9t1qRbrbm8XYGQSSbs0ErKFdQHMI98KdO1qPrpytYYnGV6d1vr6AbmnFFCTXniW3wASrLfkc9O8Kyt1arp7CjExmDX+8us6jokno+i85OU2l6KEGshDAlp6S4d7oN1Qw9etPtVS92dYRIqjqIILaF7OviiPnq359GidpGkG9ytaWAHmH1U63f9LSERWpVMzwZ+/tjYHeJCrQ3FfkGvortH6OlmBG4Puor7JvjyZ8Q6B3OhHwO/2NCczPjMgez4Rf8vmoqcYe1/gClmd7N8JHYfNqrk9l/I+ulupN1380M
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(2906002)(5660300002)(82740400003)(86362001)(81166007)(41300700001)(356005)(316002)(36860700001)(54906003)(426003)(336012)(36756003)(8676002)(47076005)(8936002)(2616005)(107886003)(40460700003)(70206006)(70586007)(40480700001)(6916009)(26005)(1076003)(478600001)(83380400001)(6666004)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 10:53:53.1192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e0d9dd-e7bf-4bcf-0dde-08dc10381aaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065
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

Currently when using "W=1" with xilinx_zynqmp_r5_defconfig, getting
below warnings.
cc1.real: warning: ./arch/arm/mach-zynqmp-r5/include:
		No such file or directory [-Wmissing-include-dirs]
Fix W=1 missing-include-dirs warnings by including the headers and
sys_r5_proto.h file which can be used.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h

diff --git a/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
new file mode 100644
index 0000000000..3f75658c15
--- /dev/null
+++ b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ *(C) Copyright 2024, Advanced Micro Devices, Inc.
+ * Michal Simek <michal.simek@xilinx.com>
+ */
+
+#ifndef _ASM_ARCH_SYS_R5_PROTO_H
+#define _ASM_ARCH_SYS_R5_PROTO_H
+
+#endif /* _ASM_ARCH_SYS_R5_PROTO_H */
-- 
2.25.1

