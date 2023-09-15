Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4594EE6459
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61BE986967;
	Fri, 15 Sep 2023 13:26:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="g5OYP4AM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 165CC86466; Fri, 15 Sep 2023 06:51:13 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC5B86466
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 06:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSO5skkmOTp/M+BVH6p4bZ+lmZeOih9kkLdC1/5kqueAbEvAkYWUXUGilNt+amCHfogtWzHRH7ezt0a9s9egOBo4VtKQOIEczWZiEWcdI6z1fElMrWpxbnzRVGgCbwevbNPthTaB9ciJqtO4VOHnk29CL0L6eGf49gTkhP3wiGBSEwqVp/ajGsRuqk2AUBD516vjmQOFQiIk5SGB0+SebkIVt1qEvUnBR/3WrFCR2DiWtg57B92vTcTw9P/tjDUMaum3jWyzvWyGhRIoNmvt/G9L+FWA+WHm9enqTKUZfcrS9JmXzwhoHoDCB+pPpXn9vk+1EV07FxXWp2VtKZCa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdoP//sEr3rl0fnMsf4Y/pDV+wc3YGeDZ9wGI0ljTzc=;
 b=TE9T5u3KURessV52/EEHWOJSBPAVHoUjzYx6uhX47Luz01uMgWNcI3Jj00XY2YC4Qgptg/krULXhskIJqDey7cbGe3a4f/5NHzH7+9kfq4ULeTsoTfQ6exEHSslFCn+rftEeyZPDyIUyw65Iq+TWg1PyVztnYZV0CKXd/5FRWFjlkRlW8p91cc3nTJVsJ4flFMdMKXlO7xDVcDFMZnO1RWyCU2TRNaML3ZaYUW7M2WocHvmX/cfnNqcUsjc5O9Asinn99y2kE2QwzgCwhkTXDpz+6mjdLIF97xjSIfPvIUUKUxs48SEESSqTd6/7o0hNptT47OLeGakJYxbPVynKsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdoP//sEr3rl0fnMsf4Y/pDV+wc3YGeDZ9wGI0ljTzc=;
 b=g5OYP4AMb6NgmaEM8rGvRt2amkUQvdxm73fgysZ139lXNwLilJ9Qlfo2PYFkWki8HIJItn0NBT+SpdBnXf52nEvJSOv7BaCSl+17JMZuX6oUI5TTEPlLS3qLG6EBg2GBt+o2JJDU4Hm4caOo0sHdBFfWIoQyXPPyQpf/HLGXAc0=
Received: from MW4PR03CA0265.namprd03.prod.outlook.com (2603:10b6:303:b4::30)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Fri, 15 Sep
 2023 04:51:07 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::c3) by MW4PR03CA0265.outlook.office365.com
 (2603:10b6:303:b4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 04:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 04:51:07 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 23:51:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 23:50:51 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 23:50:50 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <git@xilinx.com>
Subject: [PATCH] net: phy: xilinx-gmii2rgmii: Removed hardcoded phy address 0
 for bridge
Date: Fri, 15 Sep 2023 10:20:43 +0530
Message-ID: <20230915045043.4167628-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c10970-5d2c-4c41-1707-08dbb5a75faf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbYOA5C5PIfM/UbHQAuib1WEkQogDKQfYF+XCk5aUW3AvLpFp5JAgkgO6eSzphLTSc7qzrMGyaqT18xt+ST579hcJr5QuHQZXOJFMWQzui8DIEtWOTfn7KhWMtOowsN5Vkpp/C99tSPbPhihfP7ke0ZiJLFSgeTLDAok/Uwpd2u2EuuCv7mJ+djZIvjgcORimJ3VZdBn5pUuPxfM+QOGtbXd+pW7iWWCWvfTbPBuZeTdXmvjKhDKMmxUA3u1WaIB0W0YK47TDvfLqYNBusLOq0l6P+aKIM3XFbIeE0vqa0QjLboWLIowKeRz4ExKdW/95g3ATAMpk++EJbcNnkf7TlPOu+oAREtpDzR/8ndRVQg0tc4GHal85kHnFf9foD2tWRcHx2f/hk6v9YSsPnMut38R8F2jwsD6eExD7kWsNJmjJtvWwLnAwAvasrrO6UhsX2zQEVbTrLiEJeTz7h+0qk8k5yWjTO19YBZmOahvAC9cm3DThrlQoLG2cygBuvnmKZPDQE9DD1oywTO62NEtqMJSsnSNz1789zWsUC/fLQdSehPn+wN/Q+JcAB7KwCC+W90lMqXIWkVQmm9VD1TShqQILvM1QJDZGxmzbUwJn9UQeUB9Eq9CI8iPicigrSKaQzd7XwavzAbeuuZJAsgLwUwCTpVD6yFcS6+MaQaNxsaTD8HZjeoXji+BmbJXHj0fBV/yvi5Na1Yw73l9nzvnQMTXXFh2lk7yKYKevYvh7Rfw/YkjTjGIIWr1myMoI+J0qjOLouuCbWCRnqV8I2l9ng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(6666004)(82740400003)(83380400001)(86362001)(356005)(103116003)(47076005)(36860700001)(36756003)(2616005)(107886003)(1076003)(426003)(40480700001)(26005)(8676002)(2906002)(70586007)(336012)(54906003)(478600001)(70206006)(316002)(41300700001)(6916009)(81166007)(4326008)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 04:51:07.0814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c10970-5d2c-4c41-1707-08dbb5a75faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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

Current code expects bridge phy address at 0 which is not correct
expectation because bridge phy address is configurable.
That's why update the code to read reg property to figure it out
where bridge is and use it in phy creation code.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/net/phy/phy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index ae21acb059..d64a83b83d 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -838,7 +838,10 @@ static struct phy_device *phy_connect_gmii2rgmii(struct mii_dev *bus,
 	ofnode_for_each_subnode(node, dev_ofnode(dev)) {
 		node = ofnode_by_compatible(node, "xlnx,gmii-to-rgmii-1.0");
 		if (ofnode_valid(node)) {
-			phydev = phy_device_create(bus, 0,
+			int gmiirgmii_phyaddr;
+
+			gmiirgmii_phyaddr = ofnode_read_u32_default(node, "reg", 0);
+			phydev = phy_device_create(bus, gmiirgmii_phyaddr,
 						   PHY_GMII2RGMII_ID, false);
 			if (phydev)
 				phydev->node = node;
-- 
2.27.0

