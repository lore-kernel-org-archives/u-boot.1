Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B34CC46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:46:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 451FD87DDA;
	Tue, 30 Jan 2024 05:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yCKydet3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7501587D78; Tue, 30 Jan 2024 05:45:30 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7878987751
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:45:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kG91trolM+HJUlgadOD73yrMjauxChorXkUNMbmlk/4zONRYQ5QdmePhgLtCSO8359MDtJEv2GjjKUOeR96MtU/5Eo0Yg6ywfbohJRfYIsy8fYfF6DRXo2cUUUAPLT0etMp+6BjA+O/11VRGeRBdFAP9tTTlruFyddz6nHqrGMM4uNMoFcUFg90IA4bo48wU/G/U1VXP80RkFhWO6Zexo1M5dd/Um6+ZpHvb1qPRNHC0PaW2ZoHltaaujYURr97BE29DHN3jrleaIHugStcZ7QMdyZjQbQ51NVZGvwX1hahOT/Of+cvtFsaeGEbw0tT8f+6JusNA75QQATL1qxzXWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MDYvGllRDcGcaggeGh53RL7GHTCEMfyfFE6/DlJgig=;
 b=E3mQ484MDpBAegRcr8i2/Ldfx4igXeZQPmYhVN1CTyfc7WKvzq/RuUAo778fzp15uu3+sdvUAX1quhw0MXPycEmZibMR4hZuNvzU4U7usd7zMv0Ftw9Jf73by6C6YdRmk0F7vAKfztILGp0AqVSsfpCYHYLRfkKJzx3OXJLw1FDxx3Ra3UwfZ9c8yXclKVExTm39MwxjvalRzfgKexeb7/I+SsSEgASrWuu2qCrv4F+IEw0wIBm0PW5qRuprHYlSy/B8ZPbM3YfMnYFcWCsIDV6P/CYL5hptDvPBhyKVRkLIYRdCM6vlGuojGEZUiYllLqexZluJHoeQc0gKA4lrWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MDYvGllRDcGcaggeGh53RL7GHTCEMfyfFE6/DlJgig=;
 b=yCKydet3dZetszQMP9UINaAVjdKvHvD/KDInUFxxNvXBnivDyFheS8zr54e8x+t3P7Q1FkQQpKKahN4Hj31XOJ9KqnKM7Fr2JezCP25bLiIKJIhGjBvOca7b2zJ33g0pyiWmo2fAXfpFkoUemOuqrkTrJUX2okvF1Yxa5Pseb2U=
Received: from BN0PR08CA0010.namprd08.prod.outlook.com (2603:10b6:408:142::11)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 30 Jan
 2024 04:45:25 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::d2) by BN0PR08CA0010.outlook.office365.com
 (2603:10b6:408:142::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 04:45:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:45:25 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:45:10 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 22:45:08 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v10 8/8] config: xea: Enable the SPI_ADVANCE config option
Date: Tue, 30 Jan 2024 10:14:23 +0530
Message-ID: <20240130044423.1391251-9-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d97ffd-9faa-4b30-a7c0-08dc214e4697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0a6wX2piW3PYZWXEBYPKm6vNArlINyw02TMWQinsTBYopWsyyn2vOJKZrXfweUbiBHQXJkRcsVaB3wWDxD9QJJHa7MnrmvJHVR2mMSbeqgQEnQeZvSDP8B9m908YqckvIiECftgQs+yIp1tpKH3Ob7lAtSbRaS5LV2D7kZPHArSx8TGTazlf1wGakbPZZKbKiTGEP3b7HCc9JEP5001vbZ099z1gkXjUkxCav2WUokfdo0KadmlyyKfGQ+hhBbPdDp8ODktWKrVfwjmTU5fUSfHW9mAvxyZj+GBTm0HhgRuTeUafN3uambkzDVPaeUq/qQ7PVEboIWT2WXM6/d9Bm77hsMEzytEbxRpBJfkelTzAdG8eCcq1SP9r87TewtR9OJR+lJmyJhIXVvmrG7/iF+8Crnee9fk/ZHFc0EJtPyK2HXM0gWB6V5HZcBD751l4+aHPd0Nkv1WOEUUt84jQvYHHSVJ/dOUm2vkZyhoPrOYEUTN7J4CinmNoo56URAIdjCWqMnPw2SqEbCY7vUikjpsY5VRtKfQX/VLu6vqdHHsMaQsPkKkRyK4Zi+wKAG3OVWTy1RrUHFz1x7stpMHx9cW8ky1ArMK2Jm3QoAXEYYXJRUGJZJfv2ZDUVZv46OJsd8/gov5FAzpKmTrYhk6Ok0Xv1aR/tVYXwKXOaRQkfHWPMtHui577oo06VrIv/RRzJKyjDgiRSBX9qizJcOmT6miaY1i/PA48FR3gNQfUtbF4YGd/iZRRBQ5h/w4w+pKzLtqUg5gLHBH3cbWPfGIrVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(36840700001)(46966006)(40470700004)(41300700001)(2616005)(6666004)(478600001)(1076003)(26005)(107886003)(336012)(426003)(4326008)(8676002)(5660300002)(8936002)(4744005)(2906002)(47076005)(70206006)(54906003)(316002)(70586007)(86362001)(36860700001)(356005)(81166007)(82740400003)(6916009)(36756003)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 04:45:25.4808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d97ffd-9faa-4b30-a7c0-08dc214e4697
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

Disable the config SPI_ADVANCE, as getting the below error
../arm-xilinx-linux-gnueabi-ld.bfd.real: drivers/core/ofnode.o: in function
`ofnode_get_property':
/u-boot/drivers/core/ofnode.c:1185: undefined reference to `fdt_getprop'
make[1]: *** [scripts/Makefile.spl:527: spl/u-boot-spl] Error 1

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/imx28_xea_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 64a0561a34..36d3e73d0a 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -122,6 +122,7 @@ CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
+# CONFIG_SPI_ADVANCE is not set
 CONFIG_MXS_SPI=y
 CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
-- 
2.25.1

