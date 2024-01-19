Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72888C4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 05:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F53587BB5;
	Fri, 19 Jan 2024 06:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ccUVd4q4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DB7887BB8; Fri, 19 Jan 2024 06:33:54 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D29F787BB4
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 06:33:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsdzH2zCuy/ang8MvdAfizaJfqBfejII0xMz95tw+0diBzaJ3DOg1cwJPo5Gzts74P5cxvoMxUwwHLwqcezYZv+rLE36nqPbAPRykVSZg4yFX8G/5d0zpRk6ozuRdnrfYYxhRoIaPpdcHqF/g4LLblASeOzav+jyfSz/rybqLb0YPliGwKCfZ9Z9E8q45NeHlAST3xj6WSCF7FTG+saPolETJhpMwE3O1uLXtbRR4qbtiuN0RHrHBhcnOI23qz6T82zcyopflzhczTLAj8stoAdjWz0waP+vUN9k50zPStKBMdkcxP6jCfyjSS8i2eNNp3l3EKyCUx8a+p29fGKaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w10R+uaz6I0u4cnC7k0NE6wAFS7AxgVV6fTvZ8xHmBY=;
 b=c8n7CPFGQlkZpsk44qQw7QcejqHW/qUcLASwSfvz6zYBqhf8Yo5NxbZg3atzLE4KGeFsbpW5nXw5svi+uQph+L2KiucNOcUxEZqdU7ynwopVwu+CQBpbuNOvViyMA38vo7ti/in7PbtiM7UPxzXCI4hs27zguhvKvyq+b4KPkm7tVeRvXDa1v1dk7nr8nNR/nT2FPpZHqKi8Le/aa1ZSzTThSMTlP5bPVhgZGT7YKBFhkOZA0lZpHf4tmD5SjOrJWazm9oRd7+7vQZC8aOANIAdZo4mhuLvgy4V/bqVX/qQCba081lvdVj26zNx9f0IIZXNnnwOZo3kK3XV6q2Sg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w10R+uaz6I0u4cnC7k0NE6wAFS7AxgVV6fTvZ8xHmBY=;
 b=ccUVd4q4dZlvzyTxqj0SZgi1xI9gC4sUdDssun0ybAw5ts+VWPwlEDICeHTWnyZgZA4qAptzowzhhoroxOXMYTOjDtZ2IG4mPU9DBg7WnL6utLN58/qxzOPNtCspSiHqLAKEshsTZD04+5Sj8iTcysE0PkafiLUisImjEIkhP84=
Received: from CH5PR02CA0013.namprd02.prod.outlook.com (2603:10b6:610:1ed::27)
 by SJ2PR12MB8925.namprd12.prod.outlook.com (2603:10b6:a03:542::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 05:33:48 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::4e) by CH5PR02CA0013.outlook.office365.com
 (2603:10b6:610:1ed::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 05:33:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 05:33:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 23:33:47 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 23:33:46 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 23:33:44 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <michal.simek@amd.com>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v2] mtd: nand: arasan: Print warning for unsupported ecc modes
Date: Fri, 19 Jan 2024 11:03:32 +0530
Message-ID: <20240119053332.3145351-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ2PR12MB8925:EE_
X-MS-Office365-Filtering-Correlation-Id: ca795abc-a647-4f40-e98a-08dc18b035cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4YgfSRqM9CxSmUWuHxisWHylZdvopwXM4HpsK5YLtJkr64HqgMn3P8nghxhwnaSU9nfwFFCDvve0gH4Awt1ba4Re99TiNDPEIomZCZorohv6zZsqRv0HZ+2gXxsbskRPsCAaxTwJn1VO4oFLEKSjXZfiM7nsyWXQXxxqUvdImUbNKzBLJ6O05/rpg5XYr/8i/B4I1QL/kspIcx38pLwe6XaDdy3atHzKkaA/GglVnRKPQHdeQWAX8b1Kt0lNdlJv85VQbyqGHNI1NNjQtp0ucg6lV0u2INlgygWsoAqm+L8Qmtz1wp0vpeXSyY3hpN4QycDDW5QN+OVqm+yiQQebiUsym4WkU4frXD2N1LERoSdxXChO/vUbmekVB2oyERy0R+jUpaewMOPK/ZF6XppqeZu2STJjEmpBFNsdiGFVG336Xdn+3FYjXAlHdAbViXTZ9trBLs+/Dnh3314TJ9sB4bGL2J2qrm6eKBeC+fn5+4UbqYwChlMwb47KXrgUACOVxAqKBFJfTJaQAT6UqhPnBBptAWP5Q/u45MHLOQqH+9nyUUXnJGnhbSEtjX67yOCsLdI26j5vosuFy+LgS+LQV7DiGaX7flK0jwHDwFMXopcMVX8KV96do0SX9MSHsfcDW1rlamx4EWYN2YUtAzNPNnGDfq5ohmpJuCYrhRYbE+voHM3xg7CoKTaZvLRu4dMRW0dGKGiBhdvuroGRgZD7UjPKWZTne2Zrbd058poKXvlN3oCsFcqMLbF+dBC9nsaMzBRohx1gKaQGlP9rqTfWvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(4326008)(6666004)(1076003)(336012)(8936002)(426003)(47076005)(5660300002)(316002)(6916009)(8676002)(70586007)(70206006)(54906003)(478600001)(2616005)(26005)(356005)(81166007)(82740400003)(2906002)(41300700001)(36756003)(86362001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 05:33:47.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca795abc-a647-4f40-e98a-08dc18b035cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8925
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

Currently only hw ecc is supported in U-Boot. If any other ecc mode is
given in DT, it simply ignores and switches to hw ecc. So better print
what is being done.

Revert this patch once soft ecc support is fixed in future.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Added the ecc mode check in the arasan driver itself.
---
 drivers/mtd/nand/raw/arasan_nfc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/nand/raw/arasan_nfc.c b/drivers/mtd/nand/raw/arasan_nfc.c
index 14766401bf..8e5eef0881 100644
--- a/drivers/mtd/nand/raw/arasan_nfc.c
+++ b/drivers/mtd/nand/raw/arasan_nfc.c
@@ -1233,6 +1233,7 @@ static int arasan_probe(struct udevice *dev)
 	struct mtd_info *mtd;
 	ofnode child;
 	int err = -1;
+	const char *str;
 
 	info->reg = dev_read_addr_ptr(dev);
 	mtd = nand_to_mtd(nand_chip);
@@ -1263,6 +1264,10 @@ static int arasan_probe(struct udevice *dev)
 		goto fail;
 	}
 
+	str = ofnode_read_string(nand_chip->flash_node, "nand-ecc-mode");
+	if (strcmp(str, "hw"))
+		printf("%s ecc is not supported, switch to hw ecc\n", str);
+
 	nand_chip->ecc.mode = NAND_ECC_HW;
 	nand_chip->ecc.hwctl = NULL;
 	nand_chip->ecc.read_page = arasan_nand_read_page_hwecc;
-- 
2.25.1

