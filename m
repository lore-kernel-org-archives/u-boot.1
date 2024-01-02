Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA4FC46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 12:53:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 884898747A;
	Tue,  2 Jan 2024 13:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iNrHo/ME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5F4876FF; Tue,  2 Jan 2024 13:53:41 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF5487128
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 13:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBaZ9CUhJD4YiKU9FKfb12eE35tiPqyseGkIi0qi28UmalN9RKFktO1k6HJzaKEktHUnLdH5EfKts4K6AkPbCrvcNt/vHaCod+4H6LiJDXEsojhGDTyz3eeHXtM689gYnGqOKtOgFX9sWEQwCEFmXHSa3R5LBgcbL0J37hysB+K9Ik14xCnhXVAsIdnWs9WFz25zNj25Q8v+iXlr3eeVH1JtWgG/T8FhrJSCrMFTkyLmQZyID7bqeytlTLHk9BnHnb9l9zZtqGZZuafhXEVxv3L1IXr8jK8tZJT3+z4lA6tYV2B1IIovCom5/s7RH2QZ3LNfHvqpAsjwCZ6zJCX9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luHYe3znu+Dc6Nw/j5hqqqRW+dQZ7i66+sKaZwMnZzg=;
 b=CKCABBVu2Unx9L24mGRl1WBmZ2djqfToVjFSOhZQtG3zBHAcBcAO98CTgsafYnPA7+uXMyJSn8sG+8j4ITUtExYhTO1gTxJ136edXp2yPJ2CCaV9emTKTlkSviPE8HsTne9Kono0W+BOBCqMj4Ii1qMh0Q8a1QGXmk3GkTvN9RiCNjjiDd/pswZwLVhwZ1BPQWpUOSiP+lH2Zeq1997i1cHezyL1CV67fTTQML2z61lOCHRgyozfYPf990Ovpf9mAmMphcIFBIOh4C+cWs0qb/m0eL8a/A2+yqzlP4cjBa/nm5X4lvZ1W8r73BClEhmxgrGl7DX4nAPSfAppFAfC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luHYe3znu+Dc6Nw/j5hqqqRW+dQZ7i66+sKaZwMnZzg=;
 b=iNrHo/MEzEB60FWhxpw1Z5VMT0eUJf/84558y4D+A8/XukrcvZu1QZ45VHK0u7slkbn1RRYXWW6rK0ah87hC20FT32tE7YlXJQNTKUMg0H0y4VA32I8luvxX8wUAfd5qz6MlUNffG69DpnkuSCXEdfktYX1uBwaAhiILMZ5NRpo=
Received: from SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 12:53:35 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::20) by SN7PR04CA0077.outlook.office365.com
 (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25 via Frontend
 Transport; Tue, 2 Jan 2024 12:53:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Tue, 2 Jan 2024 12:53:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 06:53:34 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 2 Jan
 2024 06:53:11 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 2 Jan 2024 06:53:10 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH] mtd: spi-nor: scale up timeout for full-chip erase
Date: Tue, 2 Jan 2024 18:23:03 +0530
Message-ID: <20240102125303.808037-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 4999cbc8-d30f-4401-4e04-08dc0b91d4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k9tah/+NfXCaRAOwgIn22NeTk59/0U2lENzPuaB1Eiqk2YUDIflcXlx9GEs4ihbowAVa+ZW0+5iRGscGLPNdRJBvDVJj+4dZp73hrum2WE8sHpsi3Cf+kSCbCvS7yzfLctd/vopvV5OZfVicPihLnsTicdHWOCUeE0pem7Yx/Ji6BhHGsXRlE0VvpxjekV72DWXQlsU9dWmgtZZA/LdrIkbOSS22oMbBVMYq/CcZNyC6/boeeg8Ndq/N7sDZXG7yctN5HfvlH8dMr0F4R8eISNEXT/3BpaTUibCgavQAyGt+IOcmw/iFtkaKBVZxtz67OxPKr3a8DB/5Z4+N8mx5x79M/wo1vWyuFOzD2Kzr6zbxybX5D/ciLuTYk+pLqupPaCmAspqBxC+EFjSK/GbuEA8k/f0tlwBEF9Xtc8lURiAttEalxB+wvjPNVDx2uVjwLobDS70t7ekV8owNRD+guyC3CBk3VRGHq3AeMBhpJ/COVYsHv7I9P7g4ggjWxtHMZDIXzC8j4gEiQdh0mMpDEr8a0hp9o8IV+/GBCRr2ZHPWfRIp23YDTtboA+kd+rLBhltuQPFoNxZ4cdq/aOMu4d/VCNOmQOEZjE9vdcTGROvi31xPL6q6J11cGixud+hZb/7WIgsKuz7oHRy0Vyit508AsFIE0YYLDgYwoZh26T4TUUZFH7J42qW0ygZcXC7EvS7ElJbx5WWkme0ZKcCBhoAg9GVDvInsrkDamM8xJHUs4rEg46f1mVlrqd6xu94F4osAXkpxlucLLv/6f3Jh4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(478600001)(107886003)(40460700003)(41300700001)(82740400003)(356005)(6916009)(36756003)(4326008)(81166007)(54906003)(316002)(70586007)(70206006)(86362001)(6666004)(47076005)(426003)(26005)(336012)(1076003)(40480700001)(83380400001)(8936002)(8676002)(2616005)(2906002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 12:53:35.0348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4999cbc8-d30f-4401-4e04-08dc0b91d4f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066
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

This patch fixes timeout issues seen on large NOR flash.
For full-chip erase, where we use the SPINOR_OP_CHIP_ERASE (0xc7)
opcode. Use a different timeout for full-chip erase than for other
commands.

 [Ported from Linux kernel commit
                09b6a377687b ("mtd: spi-nor: scale up timeout for
                               full-chip erase") ]

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 9a1801ba93..171c68787c 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -45,6 +45,12 @@
 
 #define DEFAULT_READY_WAIT_JIFFIES		(40UL * HZ)
 
+/*
+ * For full-chip erase, calibrated to a 2MB flash (M25P16); should be scaled up
+ * for larger flash
+ */
+#define CHIP_ERASE_2MB_READY_WAIT_JIFFIES      (40UL * HZ)
+
 #define ROUND_UP_TO(x, y)	(((x) + (y) - 1) / (y) * (y))
 
 struct sfdp_parameter_header {
@@ -832,6 +838,20 @@ static int spi_nor_wait_till_ready(struct spi_nor *nor)
 						    DEFAULT_READY_WAIT_JIFFIES);
 }
 
+static int spi_nor_erase_chip_wait_till_ready(struct spi_nor *nor, unsigned long size)
+{
+	/*
+	 * Scale the timeout linearly with the size of the flash, with
+	 * a minimum calibrated to an old 2MB flash. We could try to
+	 * pull these from CFI/SFDP, but these values should be good
+	 * enough for now.
+	 */
+	unsigned long timeout = max(CHIP_ERASE_2MB_READY_WAIT_JIFFIES,
+				    CHIP_ERASE_2MB_READY_WAIT_JIFFIES *
+				    (unsigned long)(size / SZ_2M));
+	return spi_nor_wait_till_ready_with_timeout(nor, timeout);
+}
+
 #ifdef CONFIG_SPI_FLASH_BAR
 /*
  * This "clean_bar" is necessary in a situation when one was accessing
@@ -966,7 +986,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	bool addr_known = false;
-	u32 addr, len, rem;
+	u32 addr, len, rem, max_size;
 	int ret, err;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
@@ -980,6 +1000,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	addr = instr->addr;
 	len = instr->len;
+	max_size = instr->len;
 
 	instr->state = MTD_ERASING;
 	addr_known = true;
@@ -1012,7 +1033,13 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		addr += ret;
 		len -= ret;
 
-		ret = spi_nor_wait_till_ready(nor);
+		if (max_size == mtd->size &&
+		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
+			ret = spi_nor_erase_chip_wait_till_ready(nor, mtd->size);
+		} else {
+			ret = spi_nor_wait_till_ready(nor);
+		}
+
 		if (ret)
 			goto erase_err;
 	}
-- 
2.25.1

