Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A00C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 093B28764D;
	Wed,  6 Dec 2023 10:33:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GZeFWQxX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE83D876D9; Wed,  6 Dec 2023 10:33:36 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5848779E
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpgaiZ+EOj+Mw/orNuAix7xvKn2iT//OWIgu8M6neLMjJnct0BTSuQIu0dUowrpCW3PRDcV4hO4th5uI8exTM8pu9hIcVwSEPTGLMaH+onGHpg1yiZPC8WlV+wNw4dRHaiG7yMaE2vrX6ggfooe5eka8liv2vw4OROplWibLxClsbFuF0uk3Wy3OEflubwOKTHxEo2Vj0WgjTWkDj4f0/U4ilLlTG2khjugOqPmPkabGdnA6wiDD9wRWc/Er4/nN9j1LAwKV5FcaYQZ9pQZ/D5Ggu4CeM5onuU6V/1zIGfDiMm9GjEpswcJ5/oTp3ccG6GYmr1nspnBkhTzcnepulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlybIRd3dgqBt58XjLdd4KvLoJpo79Iz9gSYOxKxh44=;
 b=WY/o/pp5QI109QedGvrAdozhEKrllSXZ6ooQWnLAasRN+4Qc41Ne9CmfmmIZZrkKKup09GgKnsRDnRjRGYSTIFS66lBrhlq7ZPie2kyAjCiz18k+IG6eMp07pxBWV4t1/In14wv0G2YnfAnhlZuDx4VBoB5U8JP1lqN/zTWHXJKj6erTODcUlcaMSORsTp02Ap4L2KxCsu1RZqHiF1aOLKajR2Z3qScEF8sSMbEswfF5MS016bSjj4Grvn3cq/8eC1M85i0AurMysYFibDSK99lwBpWkMmMbi12F5pyNzM1edDhmuQtS2LwgWjK0K/LZzkG7nUsq0X8uC56pvqwQlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlybIRd3dgqBt58XjLdd4KvLoJpo79Iz9gSYOxKxh44=;
 b=GZeFWQxXJ3gEkZMdrVZdqp1nLocqvOisJ4fYEOEhGffXwxXzz9sFPw5esNWf3pcgAid1xPMEihPYpX9Hk+IK3gIbq9dDcVKfXAI7m2xqqnH6JKt1YLyn9QPSu0/ACUKcK+ysQ13f77nLKqfs+bkTHeBMC89hWmbQaoZgJikhnmA=
Received: from DM5PR07CA0065.namprd07.prod.outlook.com (2603:10b6:4:ad::30) by
 SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:33:30 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::8b) by DM5PR07CA0065.outlook.office365.com
 (2603:10b6:4:ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:23 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:20 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 18/30] spi: cadence_qspi: Set tshsl_ns to at least one
 sclk_ns
Date: Wed, 6 Dec 2023 15:01:29 +0530
Message-ID: <270d9c8b0e2578a45317693c843ae22d2d409219.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3084e3d5-58b3-4a8a-f7ed-08dbf63e6845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIPu7OUAmSHH47jzYRWCmNX0XKdWMmnMwrWOjXWDjIDnHMu7E/lkGddI7Jyn5JEWGqazPjrChBAmPq0sftXMfCPGYoqU45vuIS9SJIueXlseRJrm2QWp4TbBhl6hC91OaBc8iz3blyGxvPU6vGzQ57sXTy38DvbHGCvEShg/5yFQHvBcUEjstm/3MN+621FODalslEjOXbmLk4E/fAu5ZgbA7K8qonb1CQLkWkRGcPAtO6ZNFSTb+p3/rpJFRR+CesIpsGirj1QQKuUYcGNDSqSvg4EdpIZGM8EsWE4+2gl7oOHvCvpZ36GMN9ctEzQTv2IXR3jfHejpOxmujEHFLb1v6WcutksiNQCrcvyXiKyVf8p42Wefrsh+co66CmmdWrYPe2GC/hiN34ILaxhdMtH2hXjms1EREhQyiwY9YxTORzDrNXpkqNuxwQJHOBsz8dsfSSwIGibxiCRJm66p7Nm26BQBq5xb3z61+a2IRI3IJlx+7JJ6FpzDENbXrAXmQ5MJ9Z7ZSsoxdj9/dt0RqJygepwSwA5BtdJOkfA/Nq9DRbj01Ewd9BTMKs6T/3mifqiLZw1PGlE7VQcDHRumR8pveXljXsKhNO9QmVu+9es3GbrSyjsTjOSPG+Xu5mERDlbRvY7xLrEDnt5ff7+E2L3xn/fsCfVaskjiOX9+lLk1T3DA+nF+7Uwj9WFnOZDMGAExYhH2zQ93tZsES9s4prap2Jlo0vYaTzGTIWRdSnY47IRS0e+GWlHq81LP5GCq9fKe8crYkz09c6qGfcCV2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(82740400003)(40480700001)(336012)(426003)(41300700001)(36756003)(47076005)(81166007)(356005)(36860700001)(2906002)(26005)(2616005)(478600001)(40460700003)(5660300002)(70586007)(70206006)(86362001)(54906003)(316002)(6916009)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:29.9940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3084e3d5-58b3-4a8a-f7ed-08dbf63e6845
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

tshsl_ns is the clock delay for chip select deassert. This is the delay in
master reference clocks for the length that the master mode chip select
outputs are de-asserted between transactions.

The minimum delay is always SCLK period to ensure the chip select is never
re-asserted within one SCLK period.

That is why tshsl_ns delay should be at least one sclk_ns value. If it is
less than sclk_ns, set it equal to sclk_ns.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 1b649abf21..0bb46f6ac2 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -306,6 +306,10 @@ void cadence_qspi_apb_delay(void *reg_base,
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
2.27.0

