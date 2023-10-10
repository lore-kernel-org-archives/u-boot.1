Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8549ACD68E3
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 03:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C565864A0;
	Tue, 10 Oct 2023 05:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MahVLnEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 289F4864A7; Tue, 10 Oct 2023 05:05:33 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 969BC86489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:05:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCf64NSy9pwJNyX+toZPGV/5UAMkI0tjrMpEMIo8vxKUf7y45QHFGlcKODxYgv1JV+86FKs7zHAv/0LTjNEzEzQEM1emYJk+9MUa1hdBM64tbPOvMjYAYYUIx/HDSdl5lPK9e4KUt8uz8sNvJWUED8iMks/ewjg2HJ143WsIz5/D49LxfdRQL5aCI9p2tA44nsAduV78p0H5Vu+tSuVsXo3n5zjAMSXdcJXgzI1vUwkA8kgdRs95qGdviMPKULTPe/G8QUZhX8bM56zQZqzmjoqboMTFgR3TDFPQqparduRHU0Fsfl13EydHmkBNr5miRfI1XISl0iFAXC0HVBR9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvIVoMmARx1HNw78qRKFQj/EDckxVFTtfLH7nd8isP8=;
 b=YAajdjMPHFsXnBf8oz7YpNfgLn4IZb3oddpiezgDpeiKiOHDmLQwuu+XZWiNt4zRF6ur6IZpCj2BFQAp8aNe/v0KbGL+iM9n0KHqZFVq7dHOwsPtMERFm0O2yiUTP9WRdgqYVYzvrB+NkeKVPQGmIH4D8iZlm3gguFHhYjQuZE5aj99q1y7Ly8VmBaKwfFWHigfCUuZehr9jagFIaR21Zd31sSjl0EYJxE5rAMPVIayZJRGlltKVDbmQfIPnCR8whmsXk40W9XrFoS1noTl+3m0FZmK3yXxn7LB5AjytO2hslZSH9yDf53Klo4Xj8rDRXp/w9yUoeNYs/CFL01WVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvIVoMmARx1HNw78qRKFQj/EDckxVFTtfLH7nd8isP8=;
 b=MahVLnEnO2Rh9FTWdcT8Lv3CyCYY2BNsUgnpQExeNreaRRIBV4RXAwiy4LZndn2cqKlmOKgGCTJaG33BbKaa5bMbv5/T3Yem+pLL90DvKyyKaa9jShqp5/kktwm1HSjSbanEL2nxgcs05tChMAECSg5QttAyKhHvOHWHURvye54=
Received: from MW4PR03CA0230.namprd03.prod.outlook.com (2603:10b6:303:b9::25)
 by PH7PR12MB7890.namprd12.prod.outlook.com (2603:10b6:510:268::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 03:05:22 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b9:cafe::a9) by MW4PR03CA0230.outlook.office365.com
 (2603:10b6:303:b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 03:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.2 via Frontend Transport; Tue, 10 Oct 2023 03:05:21 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 22:05:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 20:04:44 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 9 Oct 2023 22:04:43 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <git@xilinx.com>
Subject: [PATCH v2] net: phy: xilinx_phy: Get rid of using property xlnx,
 phy-type
Date: Tue, 10 Oct 2023 08:34:36 +0530
Message-ID: <20231010030436.11854-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|PH7PR12MB7890:EE_
X-MS-Office365-Filtering-Correlation-Id: 08daca40-8e8f-4dd5-d766-08dbc93dbda8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hlICAKC9b4XJCJdHt+jZX/H0hbLh+lk9ydkVB//MafPyL7k8rPimPAvV63Toww51jEzlLOce/x/EgdgqvmCl2N1JNuovUxKtwGgTl4RrseTd/KWk4GOoCFP5L95tnWs8ufDpE+HEn9ijPpVjTQ94tlwYcErXCTVly7Agrq/Q9TZjB3N2uuopeoukc0DkA0mDBERWv7kmYSd1M1zqDoXaogktLtJhvcVinflypGGAxeArRy+nFcbKf3Tf75AML7fLrMEQPe/tLYK1Z5+F2X7tTBYK5N5uiltPjiHkZp+Xf5nkN9BtngnrZKdfFPw9cBfDlh7Mg7XWivMr742sPHtAY/C4Nym57Vr3ESAJ4MKOxcQtJ4zHs62ETcJJnG61CjoBY+ymvITxGdCYE+oBYXpIRLoU8s/D53MoqT/k2mPuwcUBbyoytiU/TwNP5z1WEDIex9d2EiG3h5F180qCL8Xl7vRip8a0g7vXpA+AXgtlVtWcv+L3eafMQrcOwhxE/5BjMuj5LhwWnelZArIIEGn8QXcd4l/Nq0YctZeaKtXh4V5uRvNZSRVexwEakH22qeTIGNpwO+cR6OEjtUtJdbY7gKqP78X7jteHs/W0WNQ4GEqtTsMv7nvHVEn2id7dzGxwaLNvih3LYGEq3kmPtiduHTyKx0HHQFpzi7NmTqzlvnNzRJznUYkCDzEbSAKiUdMUcHo6IBi5LOb6+z5xNW9vs6Mnse551V0iiiusdV1qZ06Pek7dUECOV7fBir6ERiAm/sSARkrS/OojuUJtwYim+BhWEUU8Mep16YLI9gbbrE4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(1800799009)(64100799003)(46966006)(36840700001)(40470700004)(40480700001)(426003)(70206006)(1076003)(336012)(83380400001)(2616005)(107886003)(40460700003)(26005)(47076005)(36860700001)(54906003)(316002)(70586007)(6916009)(4326008)(41300700001)(8936002)(5660300002)(6666004)(8676002)(2906002)(4744005)(82740400003)(478600001)(86362001)(36756003)(81166007)(356005)(26583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 03:05:21.3798 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08daca40-8e8f-4dd5-d766-08dbc93dbda8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7890
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

As the xlnx,phy-type device tree property is deprecated and phy-mode
is being used, so removing the code references of xlnx,phy-type.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Removed phytype variable.
---
 drivers/net/phy/xilinx_phy.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/phy/xilinx_phy.c b/drivers/net/phy/xilinx_phy.c
index 1df639d6f4..c07c780193 100644
--- a/drivers/net/phy/xilinx_phy.c
+++ b/drivers/net/phy/xilinx_phy.c
@@ -99,7 +99,6 @@ static int xilinxphy_startup(struct phy_device *phydev)
 
 static int xilinxphy_of_init(struct phy_device *phydev)
 {
-	u32 phytype;
 	ofnode node;
 
 	debug("%s\n", __func__);
@@ -107,10 +106,6 @@ static int xilinxphy_of_init(struct phy_device *phydev)
 	if (!ofnode_valid(node))
 		return -EINVAL;
 
-	phytype = ofnode_read_u32_default(node, "xlnx,phy-type", -1);
-	if (phytype == XAE_PHY_TYPE_1000BASE_X)
-		phydev->flags |= XAE_PHY_TYPE_1000BASE_X;
-
 	return 0;
 }
 
-- 
2.17.1

