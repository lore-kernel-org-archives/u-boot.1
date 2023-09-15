Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDC7EE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A77586945;
	Fri, 15 Sep 2023 13:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yJXdJWqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE5BF868D9; Fri, 15 Sep 2023 05:18:21 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D780686823
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 05:18:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE/9ccH5emzIgTOIbZXibUSRXvOoh9k4DGYHxdJWfm40kJZZizMdyPqXs1JXl9M3JIro2Fp6zS/TJ3q1uSUlCnGt/KVdQatbTdhwVlvCfRFMstqNHlVZgzQIH96gOrHla5fGtc8HeVGn88kSM2eEMzJH0hI8xzqLGlX3stfiHwdgPs8ivy95Z2apFPSpKMDoWJWxQC1ZFtJA5A7F09TmrlJ0XjNqz1bP+MZ20WC1fo7YowMYE0LkKn4Kaog4rbH99gHCSUWt/2MiVO2/UfrTLDNuYlC16koTIiDiBVQOIKSos3YHjpej2srg4UZmLODuoacCpUjo8GTw3BGKbBv0HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynMHvMI+MGed962qLaau+RzGR987E846RgvQsRjNTbg=;
 b=YefNLdRPqJmE1HPeuNqbvFFZZe+hnCd6bkSf5upDI6tPm06u8R+Wfegh2GpHPAdGnvRHlDFNdSsAz3ZdJXDDFQb7iotE+X50m4ZJQkFfzM/pEES06uv13UHC4F2b6AIv9sEYpRrAl4LBzNS+avLfZHIdTyzYritB0BpOrQLGL2NryaS8BDeLCkByVq7xb9pptw86iFqbl8lQvjmTVAs6vRjeHpFIqL9NEmgD5AoEn4LgRMEyKBKnShn1EoJYx3pg1FEG/RG5iehYcWHsZBStydu0hSB5ymivmJHKFM8XHIS5prGRku80ZV9vV78+7CZqmoSm86izmWoxuY85J6hwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynMHvMI+MGed962qLaau+RzGR987E846RgvQsRjNTbg=;
 b=yJXdJWqj7BaOqgX1fg+eWJrUN7TOIHEygd2j84EtUy1XOEwGTJDvVTLdIGmJBWsE+Ne8bSeHE7jjWnNw2BELN2Vyi3VqWhtp811R/zGZAdZsrqGvQ5EJnQn7oA8pnGtZc+A8E2G+ahWy4bTksXpLuoMj8KipW3UdDz7zcEIw9IA=
Received: from DM6PR03CA0023.namprd03.prod.outlook.com (2603:10b6:5:40::36) by
 SN7PR12MB8769.namprd12.prod.outlook.com (2603:10b6:806:34b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:18:14 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::76) by DM6PR03CA0023.outlook.office365.com
 (2603:10b6:5:40::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 03:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 03:18:13 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 22:18:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 20:18:11 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 22:18:10 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 2/2] spi: zynqmp_qspi: Workaround for small data cache issue
Date: Fri, 15 Sep 2023 08:47:59 +0530
Message-ID: <20230915031759.28889-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
References: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SN7PR12MB8769:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b02617-7322-4e9a-b47c-08dbb59a654e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGtSZ7cVGkHOqK1P3+ksujCtaSZEysrmZD6UbKyvKl3jbsmJKo2/YzfZRuCfJxx7ZRsyY5Tm8l8phYY6DBE+wHLkk+bQCCmA6uQXYanImQYhkdMY7DKsqDynrsZS5rqYgppbualcoEDfD2eYR8qMIjAnCeYlJXuB74TqrE4uYn8xCr6n45lTB2LdlJY3Fv43AhNZ4jwWdgt1MglNi4BGKSvAZAlUfQR+sn4hDQaaycO0USEwEpJ7a37wC/gI1qxaw7hh++KkH8py3a8vvg2W/yqIECXouRdBbNqstY9MF72g7VSUPWKdetfvhL1/8op+Wad3bQ0Gihv8ZOZuI49vhYXumFla/09NQvr5GBdSZecCg/vplIRf/Ne6wg11OeUqrTG/wX/9UY/xGcJRrcqWK3D8b63f9TFd/mTUSHkf9uXADEa7JwcdY3oZrujPIilHne42NgQEmY5NnpDchrk3BWpe7e/mRaaP8hFPpGVTAViBt6/fLv0H8Drlz8+L+UjaIIkRFCcaVGmgc3nZnv2kdh8Ycg54+7Fxo5R/3i3+F8DJJ+3z6S/G9Ko5EKRsGK0X5wshj0FKN+JBsC7eq5CkhHwEHilnsxNH9Y0F7hhFH7v6gMcGCezpVlqaGXztnML3BR1nn6Zebt+sJZ/XQi5QkRSA5K8yaFzhdxGkY+OVv1ExC3GUSAOzESV7Hgi3hduK7pVbUh8nhcn2240l9EMzjphMNvmUdKw25gDvaYCERdbu7EmaAsSwS/2QFrMdZ7oQ8MEiqCB3123KvI4rmwLe9w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(82310400011)(451199024)(186009)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(478600001)(83380400001)(26005)(1076003)(2616005)(336012)(426003)(4744005)(2906002)(54906003)(70206006)(70586007)(316002)(6916009)(4326008)(5660300002)(8676002)(41300700001)(8936002)(47076005)(40460700003)(40480700001)(36860700001)(36756003)(86362001)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:18:13.1523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b02617-7322-4e9a-b47c-08dbb59a654e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8769
X-Mailman-Approved-At: Fri, 15 Sep 2023 13:26:40 +0200
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

Cache related issues are seen with small sized data reads.
Due to this, proper data is not read. Also some times sf probe
fails randomly. To workaround this issue, invalidate dcache after read DMA
is triggered.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index a506d15227..ec59ef5804 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -707,6 +707,8 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 			return -ETIMEDOUT;
 		}
 
+		invalidate_dcache_range(addr, addr + size);
+
 		writel(GQSPI_DMA_DST_I_STS_DONE, &dma_regs->dmaisr);
 
 		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
-- 
2.17.1

