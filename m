Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE89DC369AB
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 09:41:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 371FB8043C;
	Tue, 15 Apr 2025 11:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bk3mFVLC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF767810EA; Tue, 15 Apr 2025 11:41:26 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0472480194
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:41:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLCWgiSPt1wuc+Bm8wFIMFWb6GrIW92OfYCeX9k5+q6MpYTDYEzub2lr/PRyj33Te2cIXAsPaQCGvEdQzUGilkIVWbPPw6B64QB06zGBoCIxRwXP9Iq+aGQie45qv/kUd2O1MdnvTeGqenDBeXCawn9bfiaLqeEOMhhnUlEgPHWwOBa1/WEVpYGkXETIauwxtdDwU5YNgatYSBUkJxvqhAi/4VR/2nfqXECWl+XlLmnP3qR3ahrKgsxjC/H8vaKh4BNHVx4Dcjl88631Izz8etenB9EOctEbjHWJoFmCqdXzG6UVrqNJu/ZrsdQt0PH5LcdaeMaZaAG1vVMR88MObg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4CxZm/k1p6gqZUNSN5KywRvqB9IunBqOslVysgShJ4=;
 b=eKm/q8G9ZX2K9GupiLcmrVy4B0yNUgpFrbuFTHEE0+PZQgrzF5lThqDlM81sWG89SqkvtvpLxZD8A5rKisK7l4O3Hvy+n2laE9Mpaw1Ebbe8aUvi2iqSnn8Llm4qLMk55EbkSVAy9z2/FK9fI4WgXFE956BcwtMHfgd0xH1IADc+ofArFhOPjiQ5Z0epuVQg0gIoMmAj0+smmkFscCf610/4mkKtLqhldM2eo9Ej554Cufzm0OqZTkfvUj5q7c6jpsov2fSB96xe0UZXwPiHRtuEcd0Iqfdz3aFk+N6AChB4PZIUkd6J2HyHeRUDz54oJcP/yuBPGoCkEv8Eib+Ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E4CxZm/k1p6gqZUNSN5KywRvqB9IunBqOslVysgShJ4=;
 b=Bk3mFVLC5ZIYTqz5ytjwOLG8+z1RsYKj61FCizP6xrtnRNiNJ1cylSVHpTscbM+umXBZ6YoWr+1The1QftcIf+yhLktL78pWm5w4A13XSVlr2OZi9JNJjy8XpZctCo1vs3A2OGQ4Q6Hv8s6RkpX1wq7bnRBZq+CuBeE/yGdvz3E=
Received: from CH5PR02CA0014.namprd02.prod.outlook.com (2603:10b6:610:1ed::18)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 09:41:20 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::3f) by CH5PR02CA0014.outlook.office365.com
 (2603:10b6:610:1ed::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 09:41:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 09:41:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 04:41:17 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Apr 2025 04:41:15 -0500
From: Love Kumar <love.kumar@amd.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <padmarao.begari@amd.com>, <mkorpershoek@kernel.org>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] test/py: spi: Prevent to overwrite the reserved memory
Date: Tue, 15 Apr 2025 15:11:09 +0530
Message-ID: <abb932b3b23cb3c6035bfdf1929f91fb958d74b6.1744709852.git.love.kumar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: love.kumar@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a1f77f-9cb7-4812-ec9e-08dd7c01ad0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DtmMaeaxmYk40WVkf6Ot/oWBh1cPDjYzcleIKhlJx5521lhRbNZyVKyz2Fhp?=
 =?us-ascii?Q?n52QX9jiJFd4r39QYICF94Q9zcUe9Vl/Ltj8zmiRNDrBPh4wyX9krpzru/17?=
 =?us-ascii?Q?JKs+3gvkJvOa42WoLLlfSVsZNlwIF4d4KBmJCNu8Oq8k7ngcpgDWLKJF/XEU?=
 =?us-ascii?Q?foruQXU9txUnhYyWSSIfhchVO2T4V24rz/jvkxsvPiO6jF+6m/veFnwL9bXT?=
 =?us-ascii?Q?xa4k1McLb5/nkSsXAxUX6+33lGBKEbTyjGftaw8QCdGb0cWbulZFOwVwZtXR?=
 =?us-ascii?Q?horsKS+p3u2jQVSnVdVXdMgkQ66EL/R6hyKqk95zK9kb8g5SVJOm9PD2iNaO?=
 =?us-ascii?Q?FPCxS5HwBjuB0Fsi6mU2A0SOA9avcVHr/Az/wsDxiz9XSLPiN4ZtEKsKPqEQ?=
 =?us-ascii?Q?6oWDSeUC8HtPiRzgB9HNl/6n5DzyqOoF9CYeI4UCVoCQ4kpTbZhz8dXb2cnR?=
 =?us-ascii?Q?oV5vvsvWilrb92pWOnF1tQV9feQqmgr/BwE45lj3DwgmjKWwtiLBttmSp+0g?=
 =?us-ascii?Q?Kt0vG9xZOnDy9PW/VwGwzKc/hSoESWzpCR3qEreJxtbGw/BZ4UJvcXCUMLjD?=
 =?us-ascii?Q?qv10UDC/q2VO7bi13bir6Oyfbbo9POYnjEaeqH+IAx4gb7+bvZnbFcKaIrqL?=
 =?us-ascii?Q?tIH2BL4kaNxvBMlZK2WQN/HgSwFfG1kGBf+C6TdJOigcObAFpCGdt5gBVEdS?=
 =?us-ascii?Q?IBY2emj7fOK2EtyFoGGoBGswph2bhNFSCHYQFw0EyEX1J399zqNeyU98P6JU?=
 =?us-ascii?Q?pe/HIEuwCTSfMiL4BHTPdTyJvRap0cgnehn5V7Pl5ri6jY8/3EviogvRGORg?=
 =?us-ascii?Q?nB91I2p1IhOGmc3bK4nYFXyRS5L2X0C+cACuheZIXYp6OIs28xAgrMNKh5O2?=
 =?us-ascii?Q?qC2+O243smZCN7GNHNJBveFhTZghKLD3DNMSQ/mDY8GWdu9NcFafu8fyXUyg?=
 =?us-ascii?Q?By5C6Cssnj0mA9WXlgKpzcmEG64BVRFK9vf8WHO1wnya1zRzTAENNwfEB46v?=
 =?us-ascii?Q?XweEXG9MPsvcs5mY7re/ljduR4XYm7IDyPAfh1v0KB0l9w2m0yzeo4WA2WHi?=
 =?us-ascii?Q?4Ct11HCKJ6ZjADqeeNhhrHA3fJUah/1vMqoY8sBkfO062fd+QhEguxNAulop?=
 =?us-ascii?Q?H8OxOqwV1QpU0Bqd6cMLVGgqqVXCPZdpsbGOfDta0wJ8CHkXMEFPVq2+LcoQ?=
 =?us-ascii?Q?MZ9AqfnkEdR61lP/rZVXePSTIiYtPMugamW5ZqrOmRr2Tlba8GU1yqFdZqbk?=
 =?us-ascii?Q?0exheJGJ2iPFOYXWKBrZx7QZtFlVCOgweg2h1Nf7oDCeD8NuervnZ67qtS0B?=
 =?us-ascii?Q?aVz22bkih2JIGd9vcyTFFckUSamZHaRIlIG2Yx4JC+dEgGYufpX/3lbEx12P?=
 =?us-ascii?Q?HY3ueMKKkHqk+lK8+ev1QyeZW5D/BuA3d/hn9yIVPXXz14MTjnNJv8R9Er++?=
 =?us-ascii?Q?Q7OwebSxuW47fIelGJi62xIisGqxvQsa9nVri4MtrdaGruKqDBXvtg1BqXhi?=
 =?us-ascii?Q?IiSamnhfBS0S7C7Mb/wQaOYPgLTKBIgmqdSJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 09:41:19.5683 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a1f77f-9cb7-4812-ec9e-08dd7c01ad0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049
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

Update SPI negative tests to prevent SF command from overwriting the
reserved memory area.

Signed-off-by: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_spi.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index dd767528dbfb..09174f91e987 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -703,4 +703,33 @@ def test_spi_negative(ubman):
             ubman, 'read', start, size, res_area, 1, error_msg, EXPECTED_READ
         )
 
+        # Start reading from the reserved area
+        m = re.search(r'reserved\[0\]\s*\[(0x.+)-(0x.+)\]', output)
+        if not m or int(m.group(1), 16) == 0:
+            ubman.log.info('No reserved area is defined or start addr is 0x0!')
+        else:
+            rstart_area = int(m.group(1), 16)
+            rend_area = int(m.group(2), 16)
+
+            # Case 1: Start reading from the middle of the reserved area
+            r_size = rend_area - rstart_area
+            r_area = rstart_area + r_size
+            flash_ops(
+                ubman, 'read', start, size, r_area, 1, error_msg, EXPECTED_READ
+            )
+
+            # Case 2: Start reading from before the reserved area to cross-over
+            # the reserved area
+            rstart_area = rstart_area - int(size/2)
+            flash_ops(
+                ubman, 'read', start, size, rstart_area, 1, error_msg, EXPECTED_READ
+            )
+
+            # Case 3: Start reading till after the reserved area to cross-over
+            # the reserved area
+            rend_area = rend_area - int(size/2)
+            flash_ops(
+                ubman, 'read', start, size, rend_area, 1, error_msg, EXPECTED_READ
+            )
+
         i = i + 1
-- 
2.25.1

