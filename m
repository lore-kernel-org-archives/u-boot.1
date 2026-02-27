Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF88DFD7F95
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 11:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FD483BB1;
	Fri, 27 Feb 2026 12:57:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n82s1u6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36AEB83EB3; Fri, 27 Feb 2026 12:57:32 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD2683AA9
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 12:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeOJoahIND77H8UsLf3xZdYJlE6SLc+jdL5UBPuCmJM8lFFLzNvcm1UhRpZ4u7PcdgRh8iFwwLXoXmeAZ8FnOvLS8WFt1DN8/b3CtsatmGXf9td6d3/5MyMTU/0qlngqSTOaFF9jcFfHQ6bn3m4Vz2sGs6aPGusFuDwtV62cOlY6CIj829ADYzUfSYohjOkezLkTVY/LMeFTuBpBU9TuXoXgK1GE1KJ5G646o9+wup2WoIj364jkj1hEq6D4wn2c0qzPbG5MazZpSbqF1qcaij8T9FLaKwR72YZDnBoGmw8pLmmOoeTFztElLyCpgar/n1+1svWEuIWlZ/4U1S7sCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1Z5ABqDb+crfUu1CVYWwPneFKo1Q7QnBTTSVuNVfnI=;
 b=q4I2J1nT3IStYqTIlt8Rk6Ra2zW3yg0//ogdK8ntQoFd8B/QZW3imgltag92leZ1sAnJm4McJlDgeSgJBg5O/Kmavcc3O2V094w6xOY00p5l8xXmRwKmjgLO5kcA6bWTom2K4vRlYL9hm7cVGWfnrwwMeOOyDotyDSbgT7tbiYCE67xA5BJtUvBDYa41mg5mH1rfz/W14+uZBIIYFAfHcyJRmqVZ46sQlOzCO3D85ki7hXSrTxZ+f/0J9JG9KO2q9zL2fT8PvDhZXCpSoXEHKJP37oEkisbEPJ74uCW34yJ5rWZ2e1t2tai/mo8iaWuArsmCv0h+9Ed4nSpXVAvvlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1Z5ABqDb+crfUu1CVYWwPneFKo1Q7QnBTTSVuNVfnI=;
 b=n82s1u6zjrKwFqpiTmMeU6ElnpZSj5I9F+uL9zqWrTEL9q+8Tb7sy45nScuEBjSvsSAhv0tHWOgQcNpvNUBMQdzQxnuAIK4RIhP6yy44Ahg1ZQl++tJgDtDM+kv+VXs2nKadu1D+wT+WwzWpSDcCGp8vj5Ek+oGoFPbtTicMrwI=
Received: from LV3P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::8)
 by MW5PR10MB5716.namprd10.prod.outlook.com (2603:10b6:303:1a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 11:57:27 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::ac) by LV3P220CA0029.outlook.office365.com
 (2603:10b6:408:234::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Fri,
 27 Feb 2026 11:57:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 11:57:27 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:26 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 27 Feb
 2026 05:57:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 27 Feb 2026 05:57:26 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61RBvApZ3689228;
 Fri, 27 Feb 2026 05:57:21 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <anshuld@ti.com>,
 <d-gole@ti.com>, <n-francis@ti.com>, <bb@ti.com>, <jm@ti.com>, <s-k6@ti.com>, 
 <afd@ti.com>, <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>,
 <a-dutta@ti.com>, <neil.armstrong@linaro.org>, <semen.protsenko@linaro.org>,
 <peng.fan@nxp.com>, <george.mccollister@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 2/6] pci: pcie_cdns_ti: enable PCIe root-complex mode for
 J784S4 SoC
Date: Fri, 27 Feb 2026 17:28:30 +0530
Message-ID: <20260227115841.333073-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|MW5PR10MB5716:EE_
X-MS-Office365-Filtering-Correlation-Id: e8629390-f4ed-4714-3f31-08de75f760b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|34020700016|36860700013|376014|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: INqC1lZWBoeuOgEYYmIwCvg7CHPCmhJ2NZ5ziBauMP4qp1I6Ngxzd9lAFVexR74NOui3vMo0Yc5T3Yj9Yt54Lzkn4ZyGw4MbF/VmXPJzQo7kd2hRIemwYALR39/PB5+DQwAz7JjEzJ+w+o87K1SkxTBMQ+ipSYDkOLv/JUkvIiPFxklwRxA/MDnb6tntjC02LDDI5g0rXndyUfPu1cM1m4uCWCspkP6RU6M3fMsvwacYPseAM9iJjUxKpIpTCCT6CrlK6AY19hta7OKNDpy5BYZ+jGeTqOt1oCXQp5cf4yPu1bjDU302XWDGlD73qMLZE+t/5idD4FrjPg9SCAcsXs/FtGufk0AWkuft+PHIeYIjq1fjFcY2YHdcAPAfjN/vNFyPcZ2+Ue7OtNyFf58L9WN3wsLgz9F15DG8WE68o+vI1bcCmZj539xOVLIyw+h0ssJlsaLyxfipWMAJA9esDn19CVCtc5DibSsyCK/8SssCAR9oTwzE32hda04+TZw/xZQOCL2ZLMEvKV9XPo1tIlK68G9XXKO97gOOOsBnC4vivUiUv1hPyciRaJKpfMlMu4yZN3kvJenjOSeQWdM/d8n0fbU514kfevn+E6qXkQCFTUtKQyaIADxd5RwwiVKRz8W4YpU+RfpFGOTY4wRPJbh1oFh/QxY3QViWZD0c/NAvd6V/RJmwheIb6BNC3PHNj64rF6s2aDk33NffFfOEfpr2cow6FTJq2dsOJPNociLyGeswta3hV31jxT9nKJ3+fdWVj65Zs3AV/LXpS20j7LiC1tzuAN4Z+lzlswzkKefl1+ZtVEWqHKLbJnYEWh1kQTZTBQT7gy41Ph9nLsDsFZ893K835ClAFn9afrbi+VE=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /8dNtydsjoYTgjHTuAI4z/Ou8K5y9xY6wSs1LVYJMmvOrCPm65NAzpgfj3jBh3bL9iv7bkaKBpMP30asNvGrBXlh7shPB2BnHMv/XgBre6Agcycpcl3sqb6/+LBdryCrvZ7HfcTpQwTGuiC6vgmUj1HC2Rz8IDXvzBvSDSPa87G6tKaPsD1aj8nkz8oTASToT4Ozbr5ZxCaGsVm3VbltjKLWocedY+mLOgafT42lZMIk2HmZqxG7JXu0YTFGD4wxTcjDX6ebescUX7FdvRkPxYsReXyHppA4+tFBqBYy939KK+0AAdtyIctxj8/04mo/2V0aW2RW+9YaeDuq/BbpDyZ8Be4N/z6YwWDWkR9jj9BkJkrWDmqtx6tcQpgrf8THNRBKeZvwbZ4YGjLArYndLEVaxPj85C9tZ/hNe11OKXvh7owyNvEHSnuXjF2JeItf
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 11:57:27.1904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8629390-f4ed-4714-3f31-08de75f760b5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5716
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

The PCIe Controllers on the J784S4 SoC support Root-Complex mode of
operation. Hence, enable it.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/pcie_cdns_ti.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/pcie_cdns_ti.c b/drivers/pci/pcie_cdns_ti.c
index 38804f1c09c..63d249c2506 100644
--- a/drivers/pci/pcie_cdns_ti.c
+++ b/drivers/pci/pcie_cdns_ti.c
@@ -860,6 +860,12 @@ static const struct pcie_cdns_ti_data j722s_pcie_rc_data = {
 	.max_lanes = 1,
 };
 
+static const struct pcie_cdns_ti_data j784s4_pcie_rc_data = {
+	.mode = PCIE_MODE_RC,
+	.quirk_detect_quiet_flag = true,
+	.max_lanes = 4,
+};
+
 static const struct udevice_id pcie_cdns_ti_ids[] = {
 	{
 		.compatible = "ti,j7200-pcie-host",
@@ -873,6 +879,10 @@ static const struct udevice_id pcie_cdns_ti_ids[] = {
 		.compatible = "ti,j722s-pcie-host",
 		.data = (ulong)&j722s_pcie_rc_data,
 	},
+	{
+		.compatible = "ti,j784s4-pcie-host",
+		.data = (ulong)&j784s4_pcie_rc_data,
+	},
 	{},
 };
 
-- 
2.51.1

