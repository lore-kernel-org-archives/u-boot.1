Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0B5E936ED
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 03:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43A1E86542;
	Thu,  5 Oct 2023 05:02:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qlwHb8ny";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6297D86AEE; Thu,  5 Oct 2023 05:02:19 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BCCD8652B
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 05:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEwdKOKeVlJp1/PHqFOviwSJ+5WcK0yvjxgEPK8/4LTB+lpn7UBndg5cwJhmRcrlZYCBZ6BZKlptxA4TqupgPqZwAZB1cFEi7nOZaUeokku762dZdiclH6YlLHihRByL23Sr4EyHdtuFX1KO9NmubcjsgZTAEBOe4AXAoGrwe7sASOLDQeGdz9jB068akE7UyGy04G484DwvB29lWeAfZUusLTcNxPCpiu3vpmW770zFwmSWEynVB8vUtgg06Bvsb6PX2MzaG+NDw1k0/JPQlMp/BdasDpfO/xGGg+H8rBM8M1i+CbqVdjlC56K/PCgSraJv807rT41Rnp1qypqSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvLC+8+McnvT5rVlS/hq3jOMO8rOzFwxuHLrkiPvcpY=;
 b=V1yydkZgCdVGZS8dTxE6FmxOAvLWFeKZnxNC40NC6bXN35Tk0oFx67kHGyNNbvB74CfRN4IMlszESkOfF6VoRIxD04CNCVQF9ZpxnFyiy6X56ev8ZufIqnq50UAejNhH/QGrxXXPyCMiE22wjNSG/AqNF5Lu/lDLXHegT9sZ661Pu+ofQDznTZ4XW9qShFyWMjR4RWXwL6mLpNhC9UGZrDScV2ToBSlw+TRj0hh5GTdG7n4RnQ25lRZkwKfeARGPpSpCvyB+NeOwIS9YLatd4jyn1bspdtRnZIbUxaeuM+Ug4c3E+905z+i5G3t/560r0Xh2EqM/jQu4XXpwOB4SdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvLC+8+McnvT5rVlS/hq3jOMO8rOzFwxuHLrkiPvcpY=;
 b=qlwHb8nymF/VYKvy8liY85TmSZ+1ubVEdknhHIgbaYJVuu7x48nvbLglVRHDA1Y+/jufCH/x7l+DM3lx9vM/C/nJbm4M7y5rxbZ+pnCq9P3zb8C947WHmWq6oYGtcWQZ446gW3kjHBSm2EYONU4tV8ccLJIIlDlqx3XpTPyYaFY=
Received: from MN2PR11CA0011.namprd11.prod.outlook.com (2603:10b6:208:23b::16)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 03:02:13 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:23b:cafe::e) by MN2PR11CA0011.outlook.office365.com
 (2603:10b6:208:23b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Thu, 5 Oct 2023 03:02:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 03:02:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 22:02:11 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 22:02:09 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <git@xilinx.com>
Subject: [PATCH] net: phy: xilinx_phy: Get rid of using property xlnx, phy-type
Date: Thu, 5 Oct 2023 08:32:02 +0530
Message-ID: <20231005030202.2764-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d26d66c-5979-40c1-b0e8-08dbc54f78aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvtAJvGOnhGQ3vwYwdInTf91gZXHMaW+UwCxQbDKdUd7mEdFPzL6JbXoFlVHjqcOom6raqHVBxT98Cf2iYjrQO5X8lYpWjz4iqr2zgdLEfCtmElaTMv+BJlkNxZmAajuxYhbd9DwgpfgBe4JUZq2yv8STW1ikyXwPz3Fm1QDWctYkt0fDcWK18G+fNZvxdk+dFXoCAZWpi0U1giDLKQ7Sw0cHgz8LJr38b5236+0pI2QjnVDAONibkT7gfMc3O8CUI0xxnNiUVZtk0pCddWraXR3NYrOMyn/T3PvprspIaacn+Ez+Hwgj7oBM9eK2jipk0PmayfKW9LK5Uz+kI+pgt0ePv0okWk7btbCHCMFL0Ez1nRgnDSqYwx7wgdJ4KmP8Ga9UgUDXCQg4K8aZbUD6v9WrAYZBJtKXL/d8w0mBITe0W/1+sCMh5PGVPKMrL/qfO0l9pw4M5hy21hDMA3Dio5RBR95BhxDA1Nn6xJ7Yv1tQH+jZ7Jz/iSKRdXT10vFkEUey8uJIa7DCA9gyCaykt+Kh/FrEI7A2bB9sf47VA8r9IxTkEUfIy3v+NZIqAcJ8VHV4XRRA37G1HqXGDVVJRR1vKcvqbMgbwgjHo+iXEXnJ+ju2hUsy5BG0+ZIHS0kn6VKK1nTj1v+xaxTDSFahPcqs6yR+y+Q1S+peioucdA1GbMznHqEJ/3Pl85O6+eRa/f7ofoWgLorUay8VFVO13M8oMZfUiUapm3CQ9lVBAaZaguaXX7TRBrMQz5iwroCnnSqlej5iuPxESu2jqb08Hpm2u88s/l4W1kYhC3P9IA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(5660300002)(8936002)(8676002)(86362001)(4326008)(40460700003)(4744005)(2906002)(36756003)(478600001)(356005)(2616005)(81166007)(6916009)(82740400003)(426003)(26005)(107886003)(83380400001)(336012)(6666004)(36860700001)(47076005)(54906003)(41300700001)(70206006)(70586007)(316002)(1076003)(26583001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 03:02:12.0129 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d26d66c-5979-40c1-b0e8-08dbc54f78aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
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
 drivers/net/phy/xilinx_phy.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/phy/xilinx_phy.c b/drivers/net/phy/xilinx_phy.c
index 1df639d6f4..50f1611ad5 100644
--- a/drivers/net/phy/xilinx_phy.c
+++ b/drivers/net/phy/xilinx_phy.c
@@ -107,10 +107,6 @@ static int xilinxphy_of_init(struct phy_device *phydev)
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

