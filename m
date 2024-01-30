Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9AAC47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 210C087DB0;
	Tue, 30 Jan 2024 05:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u31Rb/Zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF04B87DC0; Tue, 30 Jan 2024 05:45:15 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8AB87D7A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di8duDFHCDguFS1pYSKtwM2V9gBbInnsw9RXKvSSSjiCrtipHqSTrqpMZdf27QU5rbk1x4M/zB35FVeFcCzBjpsulgGKyJ3czSiZIZYMFzL5mT+/w2MkMD5gL1Fgf7jQt8Xwmx074EO+SAx/Skl24l7eYmMUb+Jt0KZFfNVILLX2o1VDw1LOjCgrakGw2BC9VKsSLmWWoeOCk2kyzHTq+yvI8YJYvnH4u24nBtcEX9aYyN8ZT70WQJqbZotg8+VtnKWDicSt81t6tehrF8xeuB/10KbjVZL9C5OkqKGHVXrBD0sVlGWcAi6iuyU8CUaJnNFOKO3E7ljuft5MTgrKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TurD7fS2vN6ZSTeBsbW888txnNiYBrXPDXs8T1RgoNo=;
 b=QqNPprPl9Nk8b7ClAM/YuHYyAEMRFIgKuO8JcsZfzVD2CmLwbljAhVzakQAab/ImmYHwJH5zBnqGiJkgpN2Bq8NlTNtxnjIsj6KpSgVVManiqrGxnljxbU/LwKKybh9MfLwTRtOMEYu7P2UHzZgKIUkbkE1bICWLcKlROYYFEt7G2Ybewkz/RuKXW+HFe2c1LSh54bAKIPtWvFlkrb4EgJLHiSzJP6g/fmd5xLZ3uy/sxG/26WEw1C2XkAlGaaNb6I3Dpet7PqMKzhb9keSpWakE0yPR9uxKiGReaD+cwoEkOS3dBVcHOZFQOyXjo++AUnAxq+dzen0zdu7iv63myQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TurD7fS2vN6ZSTeBsbW888txnNiYBrXPDXs8T1RgoNo=;
 b=u31Rb/Ztzp0AsMzVNcoUSMvzNsW+keTfcktqi/eIboo5O1HrIH0i4IuzevYxOF+pGc2fM2NIVpqYygXoPfJ894PdLHkUC4IOMgaZBXtpy25/dbgm5HDO12zXH8fKJ4WBgHBAsapX78R7Hb5+AeY0EpFfxIkZfMdNU0698K9Q2I4=
Received: from BN7PR06CA0039.namprd06.prod.outlook.com (2603:10b6:408:34::16)
 by DM6PR12MB4928.namprd12.prod.outlook.com (2603:10b6:5:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 04:45:09 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:34:cafe::91) by BN7PR06CA0039.outlook.office365.com
 (2603:10b6:408:34::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 04:45:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:45:08 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 22:45:07 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v10 7/8] spi: Add the spi advance options for non SPL
Date: Tue, 30 Jan 2024 10:14:22 +0530
Message-ID: <20240130044423.1391251-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DM6PR12MB4928:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4553e3-2c70-439e-9bc4-08dc214e3cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Qv5kz5mm3UaIqs0yLS/TjKbByYYOS07Ht2epZajjIR/vBqYZsr6uuV1V53fyJbJlSGGMbW5DcnG5MxVyRO1R72grUnI9Zjh23f1J8j8XLUnwHRTRBYuyMZo+3LIX6SWwz+7NqESpERLQ5szW3bScKWkO63tl0Aro5mA6PcDi/7sGAIH3KRA3bpyyne9Jid52TF+9733UbzHuH5BZZPDbuEWQq6LJTK3nvYz7O0xA4/VVxsHe7+nSlBdLdPPgvIPr6us4cx9+/wE1WIezLCvPUNlWJE5nnKMSmeNf/M6IfrF7/eYhAr760o/PK6EiiXbSSTLCiUF+OzfPx8Wo4Fbo3ArqYpmoa1GlDlB97bmTxbtt2sgs31Qk6vfk8QYejU8wW0vLEGJ6l9AU7+JsoQUqQnt8Vsp7Q6y60rmTOH3kNs5Br/R6Y6TtHNHMiHWUNH1+vfEpmPafeKJU0AlTBgS7SrtfN2dCSN0lgBtIf3onfPCKLjVnDyuW+cvpP3DeClZ+G79JteIhtbmDo0Yns5XHoHWswLqJRAufx0rinsUoR1gSEbXU5EVyZmV8pHzUuVnwGf0vrodJGp7+gjvYFa+2cJ4Ph5yhxE8Ir+yov7hIE5LYTos74EVrG6MJVc12CwCJ/oBjfomP5SCmqFDswruTaPXgxNEZ/ZQnGbt/QleB0KJWc/8rNH3NDwcU6Y3ISDiLmx7tzP5W7iYBa4pDi0d188oPpZK6myrJ/2sX29VUkROAtyL5BujUauBM6rOUSCe1pNaFXt5taja52aAvZczbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(186009)(64100799003)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(426003)(1076003)(36860700001)(47076005)(86362001)(36756003)(82740400003)(41300700001)(83380400001)(81166007)(478600001)(356005)(316002)(336012)(8676002)(26005)(8936002)(54906003)(2616005)(70586007)(70206006)(6666004)(5660300002)(107886003)(4326008)(2906002)(6916009)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 04:45:08.9392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4553e3-2c70-439e-9bc4-08dc214e3cbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4928
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

Adding the config option SPI_ADVANCE for non SPL code.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/Kconfig      | 7 +++++++
 drivers/spi/spi-uclass.c | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 69b184b0d9..e5640bcbe4 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -50,6 +50,13 @@ config SPI_DIRMAP
 	  improvements as it automates the whole process of sending SPI memory
 	  operations every time a new region is accessed.
 
+config SPI_ADVANCE
+	bool "Enable the advance feature"
+	default y
+	help
+	  Enable the SPI advance feature support. By default this is set to y.
+	  If you intend not to use the advance feature support you should say n here.
+
 if DM_SPI
 
 config ALTERA_SPI
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index 992394c295..736159aa47 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -447,11 +447,12 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);
 
+#if CONFIG_IS_ENABLED(SPI_ADVANCE)
 	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
 		dev_err(dev, "controller doesn't support multi CS\n");
 		return -EINVAL;
 	}
-
+#endif
 	/*
 	 * In case the operation speed is not yet established by
 	 * dm_spi_claim_bus() ensure the bus is configured properly.
-- 
2.25.1

