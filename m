Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C79BC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AA0D8779E;
	Wed,  6 Dec 2023 10:33:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYYqt0IN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731C287879; Wed,  6 Dec 2023 10:33:38 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B769877BC
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl0xu8an7JCyLmM5L2sGtiarRM+Xf6fVAxLcTaE2klchFi08cenQWEcGJ3vZV8kVet9qYtaNYhLBn3tLzoiB9wEW3dlOckx4FZLJvNgkKFSK61ndBjAaqGSOAdeZEGWny75PiT7gDn5dkP3T9Pw6uABbaYDHnI4S76s6VAWD+AMHVby4Crr/4TclOvUcFsMOiZLG9BAJDE1gru04JOpWWhK3K4Jf/BdrxrUarrNB12dubmpR7BsuTes5DrbobfsGZxoY8TYkXbrnj79+TZ0YzrFbwir87luUUyKScxhZj/1rULIxnGi5CQzozVCRI+Grol2tiU3bOEUlGI+TrTrGag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TAmB6Yz5h98xFccnM5g68u1Scl9jfq4y1eKw6dYSR0=;
 b=M0GyTBbroJCZV1Z/bIrx16eKpJR4/9ejU13wUhhEc0fnaoJ/vsuEVbtRPRDO+/nwhRHhWkWFTewWLfy2KsTo31YFw+4AMY/8QNxrZp61ZorUtP3uy7/Q55KkumyZ4+TTMbDEDQxZfSAjZNjA4CC+xKLY341WUt4+05K7xulssCB7yDOfFuut9lf8GHDwq/KJImw0ClRDi7G9ciu2u//oA5dVQPuX2DYScQdgtJ2UolNc9i2datHKqj9M/xNAO+BrvxE4mrK/AeX8w3eThS/NNmMlNWZ47RxwnCtoV2tE9ixkW+8wuV4gfQJVjJCTdn5K7d4bpTRHe0DP1mxDN027Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TAmB6Yz5h98xFccnM5g68u1Scl9jfq4y1eKw6dYSR0=;
 b=nYYqt0INqHUBN92sMQYzLnIXsbnOHCE7pPahjg86tX/gohYGdjifHKti/QeCg9EJF0GdpOevFoZ3WWvbgryWKnWW3PM9WMwqdrSLJ7/sxAEm607SZvF1BLghFBHxuDRiD9OTarlGNPPsD371EOtDjnEcOS9houongStjQrtiD+k=
Received: from DM5PR07CA0074.namprd07.prod.outlook.com (2603:10b6:4:ad::39) by
 PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 09:33:32 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::1a) by DM5PR07CA0074.outlook.office365.com
 (2603:10b6:4:ad::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:31 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:30 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:29 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 21/30] spi: cadence_qspi: Enable ECO bit for higher
 frequencies
Date: Wed, 6 Dec 2023 15:01:32 +0530
Message-ID: <06e7b0cfecbc30d26429bc5d4989a287a5e812dd.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: 871a1cd8-ecb0-4bac-fbe7-08dbf63e698e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1QX2apspMsnDqOunC/Uo/EHnkfjiL0qgP1U06ya/BaDM+JTYNzKa7qEC3Hq09RwGTfFbXQ8nOMKd+ZQ1z1qMqdpbayzzd9qlmX7Z5/VEvZ2oOvW+ImkDQoiC/lZ8kaktqJ5gaAk4a0Tu0zARNqTnnSkvAnMH95S9i/2l3DG+Ghd405I1xAURWAZ3R6zYtDe3KfpmalfjYgoejgWummj8h+I/blC6F20RpXMZrqXW2oYGxLFibZr716FpTt3Pc9Huv+WvjnIx+ap9Ca2CVAUkgligpJorqpYLogfg77LEZ9Snh3SAsVmkrbK/th/FRR+/SNlCdDffoTBWICESL22ZAAvrxN8r7A1b7ItwD9s2N+/HRrI1xnU4s1vD07CdxpnfEy8807cXeAnWFe6g9Bkllcj8drSc6vZMvNzyHKsh57saZSja3D0iM2ZrbxIqVrS/my9QjQZqiiBvu9L1+HAH73pSlTDLm4XMtEpCGMg9xW09W+kg8888tHa1ljOcLjucDTGDrmqA5d8vc93St0GW/+8L4M1GaqN1FC5FmnhNOXxWrdJU6wMu1DhdiklNG09TubV124Qe/HHLUovZKlIicNFOiM3LFJe8AMrDcyjzen+cU/f6IdjmxH5+T2IyO36E5MjAuAtI/ADqUjeG/AhLn2tP9qPbUeHG6oXqgy+zyNlMH05CPOgj1y0mUtDTgAW//+mdyatIhOV5w3wsRCJ3RFePRmtVGxJwrKRD1a3S25p2Z3j98EUfvAIIrEAFanhdysYU/sOcB8zOTwiBSDZwNQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(36860700001)(40480700001)(6666004)(478600001)(54906003)(81166007)(70586007)(70206006)(356005)(316002)(26005)(2616005)(47076005)(4326008)(6916009)(8676002)(8936002)(426003)(336012)(82740400003)(5660300002)(2906002)(40460700003)(41300700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:32.1503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 871a1cd8-ecb0-4bac-fbe7-08dbf63e698e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
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

