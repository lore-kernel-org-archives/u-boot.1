Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C0AC10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:37:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 573C88774E;
	Wed,  6 Dec 2023 06:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vdegrG1z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2277F877AC; Wed,  6 Dec 2023 06:35:15 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E773587763
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIIV8qZL4BFkmT31yfPIRUbPw0w8FwTCSei6LgCEI61mG3hU22QyoUABPEmScMfiInghg99hjrWqS+5jctpG/DFJ2PARYFnuQR0dDjn48uA9uHhFOeTGXmLvPRW3B86N5YVXPUGbEF6yEjYh5Fi2JaYKKCb9kKMMOZnusMNeyD3enxRCcrc5xT8meqLDzcvEpTLeA4Wwv8aYietrdsp44TOfKptuOH49bRYDLtxRrf1PA1v8ct6lksKKGuCiU9OmHV1N2EUrJtcDbnsxuMzTpMJ/W0QOqqkd8lTcRRWdhQ030h+3VOg7PItnh783Fn54rWSOAS/iJukSvQFnOJmXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TAmB6Yz5h98xFccnM5g68u1Scl9jfq4y1eKw6dYSR0=;
 b=RJdmYME5wVHy7XlmZdh0WXBhR6rwJ+i6w4Uq+ynKZk+tdumU+4AejmHqdsu6yf+N3R+on16bxSVqyH+a7E0sy005tNnEq0k6BnuO+NHJLllGv/1J/vzyazJOQJLCgUZgzRtWV+9hBHEv2xAB5qtFSDnmGaoxRPPL4sq07p+ZjxTr6uEwwIzdOBgZ33JX+N69yWMAL0QBOSzHlbeK4Gpb+yGG8tdK1FOBdf6gvUmRyen8XZd9UMh70eKTgZL/RsulN4LzUvGHvZNMrpa/Z1VGzlh2yS8ziOKizGAwvC/Shdvgdabya8WpEh5TVunambkmzitPa/43hrrrkEFDWQXsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TAmB6Yz5h98xFccnM5g68u1Scl9jfq4y1eKw6dYSR0=;
 b=vdegrG1zAvaADKlPZL6XdHHozi8qDt15QjtP9hHqEw89NGz2J3vrhb80ouKZTu4KJP86LjFnKIrTJ4UNuGqPX6P86AYIg90ueRMR8FTxOkGW60wJQ5f0bvvpcyR4V/rT6A7vktzr1GPEGf15mB6qHHNpWu5ZbEVxhE9p1WPW5gQ=
Received: from BLAPR03CA0173.namprd03.prod.outlook.com (2603:10b6:208:32f::35)
 by LV8PR12MB9111.namprd12.prod.outlook.com (2603:10b6:408:189::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:56 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::f1) by BLAPR03CA0173.outlook.office365.com
 (2603:10b6:208:32f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:55 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:53 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 21/30] spi: cadence_qspi: Enable ECO bit for higher frequencies
Date: Wed, 6 Dec 2023 11:04:35 +0530
Message-ID: <20231206053443.3746237-2-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|LV8PR12MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 28aa451e-1eaa-4be4-91c4-08dbf61d146b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uQiIi1GIYHsxR+TxrGZK2BiuXsWe3PoF5aodybL6zCYbsIWKuyKfG6YvACuEO2h8lSdHije8BApfosR4vBf5n7AKPfgdh60fFvHAucbjUu96jEDawHYfZK+m5zoWq4sMYTWJHNyEAtEYK+BfXZKWANKl+H72+rZwDLYLdBZOu5CbRJzfAL/9I5hlv58ILpDKNYkEX+rlJkYoF3SdNTSFAzxvHQKcBUrQ7GkPy3XbZajXO9JqULbMd02dx9KrtQOGBH//JirpW6pfdxWeAjI7ufhehxc8U3wK33SZluIsGCQ3P7s1h/9QeWqoXh96JnXjejqzsSrZOPEPKJAorgrXPZg++Qepp26SRmM0e19cyWyqIwaPIDnTfPFExSO8ULZCqHtrcpUIiOfC+LBAzByEK2dHv6CvztXriBKq3nr8HNWDAV8oCxQ8hiIpcN1+m+t+nOAkDkGVH2sf+89f6IKAHCSamNohuS/2fQ/lFXWhdqdoFEqYQgViBPDrdsQ2KJXoQfmwuMuVFvbKdbVM/BTv2lJwZjHGiK/6hL73FKcNS5Qd7M+cmAW8n90YWiLvYfiUAWyGmMn5rIC3Z81DJU8yIcnz51FZhwLHMOSRRhpg8cSCiQ8dDWPhaU9hyCtv6UgUSau462GX8wvNcsV8h0/1/FwautR8NHkWyDoQr9FgQ26FaNmMRCohHsXfGkI3DtCx0sQ6g2MRFnb4m62C4X0ZHPU/2bSqWe2sOQt7eOFGb+PLNUAX1jX1cq/U0+fevAvx2cjk+oibj9XEVVlFBZccCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(426003)(478600001)(2616005)(26005)(1076003)(336012)(6666004)(316002)(54906003)(6916009)(86362001)(36756003)(41300700001)(8936002)(70206006)(70586007)(8676002)(4326008)(36860700001)(40480700001)(103116003)(2906002)(5660300002)(356005)(82740400003)(81166007)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:55.9666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28aa451e-1eaa-4be4-91c4-08dbf61d146b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9111
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

Enable ECO bit for Versal for frequencies above 120Mhz
for octal spi to work properly.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi.h     | 1 +
 drivers/spi/cadence_qspi_apb.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 73ef44fc1c..4906b9ef96 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -55,6 +55,7 @@
 #define CQSPI_READ_ID_LEN			3
 #define CQSPI_READID_LOOP_MAX			10
 #define TERA_MACRO				1000000000000l
+#define TAP_GRAN_SEL_MIN_FREQ			120000000
 
 #define OSPI_CTRL_RST				0xF1260304
 
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 052d7a1766..43dc4c6e70 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -382,6 +382,10 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 
 	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
 
+	if (IS_ENABLED(CONFIG_ARCH_VERSAL) &&
+	    priv->ref_clk_hz >= TAP_GRAN_SEL_MIN_FREQ)
+		writel(1, priv->regbase + CQSPI_REG_ECO);
+
 	cadence_qspi_apb_controller_enable(priv->regbase);
 }
 
-- 
2.27.0

