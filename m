Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBFCC47422
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 04:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9714D8751B;
	Wed, 17 Jan 2024 05:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qr654hxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD83B875FE; Wed, 17 Jan 2024 05:08:39 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95B0586F6F
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 05:08:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFlJyHPl8AaNrvZNnTINYlv1yx/Z6JhkcmKFnsbiKx9TgrkzJvSgn9bsnhvOHI++/BT+Ptvp3iaVYzMEFDClZzyN5eaG8qoPZGUb2foOa5fOta28T6wGqYt6Cca9mBq2EjyP2Z0j/4j7EOeQoO208x8mocpEEU6245tq4fMfwqOw0hZeowyLdtlxMhT9UpKetdHWNnkKfJseGl07gmANc+piRWEQVRrqS8tg5iUZ7BqLaXZ7q9xA7uv7u4l4tmxNmEddmPrFUpRGYAxsaRlzfCkguw8BsnFmFHyV672/DelcvDvDqy2kDO8dHPuzt+kBb0IrSaBqs1CFrdoUjDo0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3EhA+FrKB3SRxeZvXiTfT8xtzHBdiGo15kLjPFO1C0=;
 b=iPTQRVBaKiM2NAQkIoF1yJUhQ5qcv4LwPJ4GV3KiG/RIEmlKgFynf1hOw3GsfoVYevBNhpQ1bcOlA1Fg4Pgv+PYMxjrOeDEy2qPICRo/eAwNDWbaux6zMamdaRP+wL/1pC5K/UIk6tPzArxYSIOnbbE0341AtEEO4mc3JycP0AzGtyOO9rRsVHcnkdj5zHLhUoeHnEW75E1My0UI9IKXkdfLcFVGDKJRI+Pwqu8emngv97QQ7gi8mBQpHT4TRDH+xJuBPTApx0mJ1H4qvbudz4HLdNvN46wotdbnwiz5SjaL/JZc6o8jb4hYqKruN8A32FhNUEe2yBoBrAvHJREgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3EhA+FrKB3SRxeZvXiTfT8xtzHBdiGo15kLjPFO1C0=;
 b=qr654hxN45T1Dl6qwXy793kq+ZRmalTOmzD/UZbO+NYYjcBzpeUD4ZTvlKdxd12cVMoIsZdxz0HqBGKBOO6SMwNBT4sBAV/Fs85a3KbpJz9EVtOU4IY2efXpUQDnXF56Lb3jtGPu/6iuAE7NPUj1mpCjK6Q7I+Q+m/8yHXGRnuU=
Received: from SN7PR04CA0017.namprd04.prod.outlook.com (2603:10b6:806:f2::22)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Wed, 17 Jan
 2024 04:08:33 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:f2:cafe::ee) by SN7PR04CA0017.outlook.office365.com
 (2603:10b6:806:f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 04:08:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 04:08:32 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 22:08:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 16 Jan
 2024 20:08:30 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 22:08:29 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <dario.binacchi@amarulasolutions.com>, <michael@amarulasolutions.com>,
 <michal.simek@amd.com>, <git@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH] mtd: nand: Print warning for unsupported ecc modes
Date: Wed, 17 Jan 2024 09:38:22 +0530
Message-ID: <20240117040822.1031992-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4da1b1-a039-4ccc-ae19-08dc1711f879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4AoET3a39JZbGI3OAfxjbrjEMzlE/FTemK+1f1NzP8F+HTF5ckSGzOJx7xPPkXcwzpXmZcXY7i0H4X/a7MF81rqvys5xGkEcn9J3xh4zKTkcabege646APlRtddv62wRHlLAsJuacenwKO76U62/QYeltLx4YfIAnazT13h8D9dhAzYXHWvCuUIRFMJNec8UOqSjxHiuxhGfeGl/MGhiWFaxFXFoMd/ISylvBWU/Udr8MEMzxcYwzktN9f9dfmND4TdNlAiCofNyuS6FJh/UUzhfhDIqAuYFTst4bSFURvCrkXOhPmdgOY2u0cpN2aCyAPBZRQswOtwx4vayypQGJHULTHwWjh9b+7Dddajrpn6B6M0yK1r3G7bFSZK94UCGl27ic+hslCVvRIMIKvqCJ0HKqxUDHVV/8hlgXFAIGtcd405wBO3dHR/Sazv2im1bHJqlzCag8fYT1Z01VZlNyg7bKyxASZRo7RcvyPzj/CYhGmXXPDX/P7NfSe34Xo6Nby7w6GMRcyCn7KcYGpTF/9uU8KQMM8nyidcrUI30abFXLkEnNK7vi+hofhFWpW+z4lDOxLhIdm9EZpa26GRz1Qg0atZ8JVWKpbJnRWkqWQi9NUsBzccObHuOt+iiG7X2vNYC6Sn7I27f9n+vVFTSJFKV9hj0/gHq5S9BGEfNFtmTwNzVUvQzI6p9dTPWt7YXRLkpE+Dz4Ak7lA0M89vr8Ya+LXz7T0R1IISq1M8XglLYlJN9KkAvXusN3u/y7CM5emviuJZ/QIVHMBalmwfPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(82310400011)(1800799012)(64100799003)(451199024)(186009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(5660300002)(6916009)(8936002)(54906003)(316002)(2906002)(4744005)(70206006)(426003)(336012)(26005)(2616005)(1076003)(81166007)(356005)(36756003)(86362001)(70586007)(6666004)(478600001)(40460700003)(40480700001)(41300700001)(82740400003)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 04:08:32.9905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4da1b1-a039-4ccc-ae19-08dc1711f879
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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
 drivers/mtd/nand/raw/nand_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index c40a0f23d7..200f7f8ba0 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4463,6 +4463,9 @@ static int nand_dt_init(struct mtd_info *mtd, struct nand_chip *chip, ofnode nod
 
 	str = ofnode_read_string(node, "nand-ecc-mode");
 	if (str) {
+		if (strcmp(str, "hw"))
+			printf("%s ecc is not supported, switching to hw ecc\n", str);
+
 		if (!strcmp(str, "none"))
 			ecc_mode = NAND_ECC_NONE;
 		else if (!strcmp(str, "soft"))
-- 
2.25.1

