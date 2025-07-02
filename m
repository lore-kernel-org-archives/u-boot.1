Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41E2C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 06:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FD4B81FEE;
	Wed,  2 Jul 2025 08:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="op5Wnl9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16A982103; Wed,  2 Jul 2025 08:57:44 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D98D8003E
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 08:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyxCfbSdysONzkvP4WkMQqE6zI1iTHhsRUVfjUX2lhGoiFY2O6gmDibFUWcPPoEZtr8z+vfKkRB3y1XJZUH+em6IN6chnMbYz+ZF/iVIwvucT4qO4MHfqIH40m0mo4nq4+bn7dRPT36FJmX3T+w1sX6D8ACukspPdQ0X8Q6zMhzTvo57H5cilETt0u8qqXNHayFqurA3bpOZ6Umft0yCZJCyAcKbfVH5udEu2nlKBRVX6jD3KzYnjS5SpN4xtVC9aS/BkUAjoJ/1ikSQdJtgI4LbJa9sBM95glqYWbJ1RBqgbFQVnTTeB//1xDAoi1h2UB431gTJUoLOK72wZFIN1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07vToAXC9ApeA85JWIeug2N3IEtrOJImi/kPzJBFXPA=;
 b=nTD9qkRbrjrRNsQzmCKnZ5k6lY+a4h2QQjnyiwbjTScNZvZM9onoZQBeNEmzyhZB7vh9Ph0s9WzlkjzCttYwzSEG3C5Z412urg+GIFc7pqBod2y2bNrg7iQYlTf884rQyiLr6kMxmKFBL84fujImr8ijT/O9ngHOa5lFis6+bvXOtIkWgvsFx/vzNZARslPCD9vcudVx/I3UC4NMiQGwFUL7ho4ngQuSpXXn/j+NSz/tISd9KAJp74a/GeUzvbTqJjrPfEYsZ+rKM/J7+VLvIBIFSciH1YKIVgOu5Sdp1OYgw0k0DL8Qx9xzpWgNsirjEo72vT7oYpUAx5vUl2iXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07vToAXC9ApeA85JWIeug2N3IEtrOJImi/kPzJBFXPA=;
 b=op5Wnl9R0pT74KZwxuxenV9Ro4k46ZTgiUunK/HyP/o0HQy5BDEsKTTDUHy9My2lKaHLR3YHrGvKVaTzoDo7vHRzllos9BjH+3Ghl4h4N8/xUR90i753/p+T4OjICLxNpUD2GmTD/oWM1h/A1zjWwHltbzcnDphfmICLIKlbcWY=
Received: from BN9PR03CA0360.namprd03.prod.outlook.com (2603:10b6:408:f6::35)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 06:57:37 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::b6) by BN9PR03CA0360.outlook.office365.com
 (2603:10b6:408:f6::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 2 Jul 2025 06:57:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.1 via Frontend Transport; Wed, 2 Jul 2025 06:57:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Jul
 2025 01:57:34 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Jul 2025 01:57:29 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, <marex@denx.de>,
 <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
Date: Wed, 2 Jul 2025 12:27:17 +0530
Message-ID: <20250702065717.3871435-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 613aedca-e0be-4c07-8a3b-08ddb935b9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2moqazWZ2b5y0iRylWXbMRCTbtSfl6bQzuMub2qm68D9NvHn4cl1SPnIe7Ui?=
 =?us-ascii?Q?VXLjZfkqR8IKCf8zFJzfnDdJySY67nzCmDHXfZ/coFlL1S23EN4T6eeZyYHl?=
 =?us-ascii?Q?tx2GSWSTxQT88b4+RcNSgXeRaoWFyq1FPZEfdmkjwqYtkGlQtvh9Fsf8xkxF?=
 =?us-ascii?Q?NL2Bg3rTBZcroWYS3jHCoGPVCaDpDWsZrmRel+WTUKJuyAx0aOMaE8INZqfz?=
 =?us-ascii?Q?NEH1XWzrE2ZwOFB2DkJYAodWsRlJEgovH/A6YAbmSGjra/NK7KVnzm2XUsEe?=
 =?us-ascii?Q?571PfkX9bOntn9w5j4kTmHKlmVhsPB/6ZCd+7kPimYl4DzeZtaKuwUth/EsW?=
 =?us-ascii?Q?lz8Q9miAF4bT5LNv9mWWJiCIwdeWHFIRURMJjQKNzGWaTHaZpQLp9SyqDLe5?=
 =?us-ascii?Q?TZrq2JMFuJ9YxB0SXO6OtwrSF03fMaTeBcEmTkFd04aOu2r/BHgwF3hGralO?=
 =?us-ascii?Q?1UN5P41Oo4kaS24oc6xBKj52lmZwMWT7RHvFr2l+HXqPOqNUUS+utWSEbLUx?=
 =?us-ascii?Q?2MtFFgGVlI9hhzWAdUMa6w1yEqrlv9pbMlXhzmMVjAa6olkE/MwuPpQ0gzMk?=
 =?us-ascii?Q?KWXKrqLVsY9RI6Zx3W3JDHdxjq1PBjnoxoJjKoK1Zxhk3AIpy0tRzzKh7abt?=
 =?us-ascii?Q?C7vDHRS7D8u1IWNKG2fL3VS3333aZJ5MA3oCP4cszTdV+LYYZnsR46hJihzY?=
 =?us-ascii?Q?bMp9C8WNWEObNmF6jGvlOCqlIVoMq3XxD6JbJf28zSHrtAFNyWp8xhYMFAPy?=
 =?us-ascii?Q?zJrqRiF4TFADBsU26b9srO3j8JmNhOzr2V6lRotyUbT+4hiCF6MChrMCLMOn?=
 =?us-ascii?Q?DC0HhNSiwxSyYyJg+delwZWeLEhBFt20bmRt+U2hR4yE2KJ70z7Euq/gkcua?=
 =?us-ascii?Q?5jqA4ruQ+SsRz5GOklx6nRhGBykg9miiOcbWnuTuX5l0cRKceGdGTv6LvNmB?=
 =?us-ascii?Q?7PcdsNEaVdUBUcbbIqcFn/DNzXw41NBeY9Zk+1TkJMIAapIWt79xz41Q8ysT?=
 =?us-ascii?Q?Yg/8P4eN0eDLvZIFqXIKJjh5OWHlHWDtgZ2Vhh9Vwr4fq14F+S1iVe86ZWd9?=
 =?us-ascii?Q?NSv6tXVPpDqrfEHuW95LdGdy+Xn1wrFsAu87YNyFKkolH1Y2byAmXzBehyJI?=
 =?us-ascii?Q?P4W7WdDJwX6q7fW648DEjJwuvnhkiK5ui57qIMXd0dG/KGHRgwvzOFN3+I0o?=
 =?us-ascii?Q?mTk+QLlrPIa5s5ZUhDKzRFdU/5vDircGCZuxXiCOMSdPJHlvLLjjaCZUUs5Y?=
 =?us-ascii?Q?omP2OkVxBT/4KwbmIF79NU9Gp8GGISx+7RtvL1LLBcayloehaOAWOtB5tBIa?=
 =?us-ascii?Q?l131EsIV4HAkuUS0NJ7IyrAuOZ9rVozpUxm75yhsiuDI5e4/aWV3Uirl2tjQ?=
 =?us-ascii?Q?l86sCLhMYZCRBgMLZXJiXc/7R8t2FaqLsP5qOHrLIDJgxXOQMqpht8L83Pnw?=
 =?us-ascii?Q?tq3t/+YAm/fqHwGQ/j7P5V+77E2LzOV0fXmH57Fj2SD6k4PjHyy1wHmh31uu?=
 =?us-ascii?Q?zrs7PDe5isMGEy6UuKS0TTMsVEZyK2YOZH1T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 06:57:35.6140 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 613aedca-e0be-4c07-8a3b-08ddb935b9b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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

tshsl_ns is the clock delay for chip select deassert. This is the delay in
master reference clocks for the length that the master mode chip select
outputs are de-asserted between transactions.

The minimum delay is always SCLK period to ensure the chip select is never
re-asserted within one SCLK period.

That is why tshsl_ns delay should be at least one sclk_ns value. If it is
less than sclk_ns, set it equal to sclk_ns.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 65fb2d8f9fb..4696c09f754 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -303,6 +303,10 @@ void cadence_qspi_apb_delay(void *reg_base,
 		tshsl_ns -= sclk_ns + ref_clk_ns;
 	if (tchsh_ns >= sclk_ns + 3 * ref_clk_ns)
 		tchsh_ns -= sclk_ns + 3 * ref_clk_ns;
+
+	if (tshsl_ns < sclk_ns)
+		tshsl_ns = sclk_ns;
+
 	tshsl = DIV_ROUND_UP(tshsl_ns, ref_clk_ns);
 	tchsh = DIV_ROUND_UP(tchsh_ns, ref_clk_ns);
 	tslch = DIV_ROUND_UP(tslch_ns, ref_clk_ns);
-- 
2.25.1

