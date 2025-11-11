Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891AACCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 06:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CD583AB4;
	Tue, 11 Nov 2025 07:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GHgclmSt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB30A83B23; Tue, 11 Nov 2025 07:17:09 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8249A83A98
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 07:17:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=h-salunke@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvKJdFuU6TGcv+AIWBcgBCiqdZzhhwiU2fodiZhQk4GitHhJoTWhctQ+DDzw6PtYn37X44i0ZAn532uCWyreWF0ckhuj3zSBbgOmsNmpH+zV/NjbpkYgxCHwI3TLVkMAjNe4chWQ5I8iV85mUPhcamisj96TaUyqxY+iA8zkFQKthHcI0xa0JFtURQF51KoDlm0zYfvfAjMftXVu/VSmnKl8IbAY+xmh32geWZtj1pgxKeobnmAJqt2mf8WWFY55biyoYnWeuFTq8o5CqfyNQrrRzZT10V+WhPkx0l3Cfy3LgKSuJBcIF9tzrLeQIzTVrKcfsnCm2y5oKD5LX44TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEjduVtwc5IbwSDtH/knqXc7tHOMOGqqzzpN0JIJ+zE=;
 b=x3ReueszWe095y4x2sbTTXihkZqvRMqbqPZFlHjxc88aLGYJwLJPGmdOeijBwn2zTZArIwJiMCNbnlGxpjn1SAVAEc92Vrq7T08WN8ZMmGg+OJX4yRHhEKijt8Y7Q4hzLFKmA+D3TDPo75qBHR/Axxniut/OuexYA1bG9LG6ixJaUukKUpMndkk25hRY/jP45dVbQjgX2appwNwSj6g5SEjzhPMCr8sAcY75WF+wtIim2oXONRA9KfamMTQVIDZ6YFweqF7KQ0Ux1HG+TELUjIsFAuSH1sMFyiWi3WeAeikEDC7KxqQfpi2MyMResPshOXsaBI+RmMms9tVWX/SKLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEjduVtwc5IbwSDtH/knqXc7tHOMOGqqzzpN0JIJ+zE=;
 b=GHgclmSt6XG/KscZ8nl9RZovqNfChYcMgYcTerkKUbZbDjVJ9tY74XZrP8rB37oj/wtWbZpEb5AYDMxbknI6sQTKbJey96UP5ibAXkj6ROHBedWmkbu2uvCUCn1Zk880WfQJD0LoNQcHQAqGA2u013j9e+nsDRjwEXi/mKJbeYs=
Received: from CH0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:610:b3::34)
 by SA1PR10MB997558.namprd10.prod.outlook.com (2603:10b6:806:4ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:17:04 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::fa) by CH0PR03CA0059.outlook.office365.com
 (2603:10b6:610:b3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 06:17:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 06:17:04 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:01 -0600
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 00:17:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 00:17:00 -0600
Received: from hp-z2-tower.dhcp.ti.com (hp-z2-tower.dhcp.ti.com
 [172.24.231.157])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AB6GkPP448280;
 Tue, 11 Nov 2025 00:16:55 -0600
From: Hrushikesh Salunke <h-salunke@ti.com>
To: <trini@konsulko.com>, <a-nandan@ti.com>, <c-vankar@ti.com>,
 <u-kumar1@ti.com>, <marek.vasut+renesas@mailbox.org>, <n-francis@ti.com>,
 <peng.fan@nxp.com>, <semen.protsenko@linaro.org>, <s-vadapalli@ti.com>,
 <jm@ti.com>, <m-chawdhry@ti.com>, <ahalaney@redhat.com>
CC: <u-boot@lists.denx.de>, <h-salunke@ti.com>, <danishanwar@ti.com>
Subject: [PATCH v2 2/5] phy: cadence: Add config to enable Cadence Torrent PHY
 at SPL stage
Date: Tue, 11 Nov 2025 11:46:42 +0530
Message-ID: <20251111061645.1004382-3-h-salunke@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111061645.1004382-1-h-salunke@ti.com>
References: <20251111061645.1004382-1-h-salunke@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA1PR10MB997558:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d8891d-c40b-418b-aede-08de20e9eef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?42q7JGd32MRIZ5uE9FIFXD77SOMTVE6QOcuZ7tHPK3vfscbuhQyO2CeBwRRn?=
 =?us-ascii?Q?9bzlI2UqqGC9vdVloiFXraLc8cGTYcsUaPuw5C6kyujciwwgXRsH2K2Qav6N?=
 =?us-ascii?Q?SmoqWKUEz+lW65w+Dg49UjeJassCn5mW7so3utSWYG3WFDceBhpXuuvwky5G?=
 =?us-ascii?Q?R5Qvta//g/rsKFjeDw2HfcTQlkXqsibdGIscNZEKxAMQuV+CCRpFyeVVubmO?=
 =?us-ascii?Q?7obTrkK8Cnl8AJMTstDxe+idw7lXpa+XhBEbyY1t3/mp1DYXy9xDXIcHwI0R?=
 =?us-ascii?Q?RaOeZHp2X0ejdTj3bF4aItAuQV15RqQfFtJ1wYuH7xa3rHClQSUnILO+E72d?=
 =?us-ascii?Q?j0oFA2S4RVZChJ7SYdI8ekEZXjSBZguNhONXEDqNppfiHGcIH1zblb/hJFAo?=
 =?us-ascii?Q?Gq7V0q9G+CbBWdWkC7h87JnN4IWtKDVO9cjWRxvy8ZtawBwjJniaBounDAAX?=
 =?us-ascii?Q?97wKIWw9FzXvbx7lqTeZv9ClaYSuLJQD3ZKshXAvqRgrZF4Skij4Ml77myYL?=
 =?us-ascii?Q?FjDMjP/iqGwnpfR/z4byzybn5JIUfXAl9Rhkan6dl7pFpY8bWNE6qYEcjpq6?=
 =?us-ascii?Q?k6ll4g+oLv1CiwkqQupO4gUpH3sMnZ4HWah5Zs1d5peWgF9c2Kmv751U3kk6?=
 =?us-ascii?Q?K9yfhIWBLnd4z552IwjxDKyofiy7k/CWh4TH0EalzXzJakpkjIXvmx7HkPAy?=
 =?us-ascii?Q?xpeF6UIZWSunmtDFqpF75ER8ftsdHfyw24LYdKNvrNrqgDm2zOixivmRvcdz?=
 =?us-ascii?Q?DNJWyy73bah0GGgWW33jrkJv8il+8y/nxfskeqkypT2m7vR6uCan2nOwkyg5?=
 =?us-ascii?Q?Z/ziRJAZzJIUvAVinlPG5vmObOA68L76SMIu7vKoVuvwJsDO6Aexo1eIWhBc?=
 =?us-ascii?Q?ZsP8ltC6WioeC25rkC6T+fbWAcS9eT3Bf7YcNsSmy40x4aHhtTSP5OSzs9sF?=
 =?us-ascii?Q?Xja0FxWlhQCggK9CqIdYv/zC4uY8oWA7LDtfeQPsKby8SOZ9CSrwkuFveP99?=
 =?us-ascii?Q?1kS38CADI+6dMDmlFmir27eeM1fHP3AxcI/HKZcakMJyULwkCqSZytqQN/3r?=
 =?us-ascii?Q?Z7hJKL8w7zafAvFDLNSHX7aKb2eMplUEl03cWn6Se1wtXEbiDbpvI++QTlPF?=
 =?us-ascii?Q?EwaUtGXO1sgIWk7QUegkFFciBqli0M55jkWdDnNtAoQGOUmGgQAeY8BQziIg?=
 =?us-ascii?Q?iaIfRy30xDS14MHXqfBuU5FdggzwOf9ZU9Sj7Mnpx2Hi9Xk/pMVoipnk0OF2?=
 =?us-ascii?Q?64zaUuYll48py6CX4F2eG6AZL0EVVrk6/DW/TN8nTn8Hn4JPE0cl4OrxTAJT?=
 =?us-ascii?Q?jBJiTmp+NqNHapK4gAMfFDCr2huuWyTDky8E+/Focxj2fR5cGbMHXm3h01cr?=
 =?us-ascii?Q?5OWSwC1BpQTgVoL+J6mnhoPKonM/77zsmDjaq1U+87ai/A80rflb20l+1EMa?=
 =?us-ascii?Q?+dCMM8g2Act5/D6nvuJ6Z0/VvEExTDc1vbK4wriJti/Zp/cLzUStXeemLnGQ?=
 =?us-ascii?Q?L9ENNIbeOT6HowskL7uCXcwI2hcq+yLfi62l0bg7BjP8BbV/yFEYKY+UB31e?=
 =?us-ascii?Q?rXjuzeSGub/ENgxI0Dqkhi1Fc3SBKWWR0im1d2Fc?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:17:04.1406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d8891d-c40b-418b-aede-08de20e9eef7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997558
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

Add SPL_PHY_CADENCE_TORRENT configuration option to enable the Cadence
Torrent PHY driver in SPL stage. This is required for PCIe boot support
where SERDES configuration must be done early in the boot sequence
before loading bootloader image over PCIe.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
---
 drivers/phy/cadence/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 549ddbf5046..8c0ab80fbbc 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -9,3 +9,10 @@ config PHY_CADENCE_TORRENT
 	depends on DM_RESET
 	help
 	  Enable this to support the Cadence Torrent PHY driver
+
+config SPL_PHY_CADENCE_TORRENT
+	bool "Cadence Torrent PHY Driver"
+	depends on SPL_DM_RESET
+	help
+	  Enable this to support the Cadence Torrent PHY driver at SPL
+	  stage.
-- 
2.34.1

