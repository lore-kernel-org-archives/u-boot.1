Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE8CC4828D
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 08:33:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2479B87CEC;
	Wed,  7 Feb 2024 09:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HLi+tATz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179C587CF6; Wed,  7 Feb 2024 09:33:47 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5B2A87CE8
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 09:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuJECgWDYZybxcU4AOrZgnrmqr5pXY0e4D4R7ElfYLuIrIk3fPhodxLNsWzHwaKQrKmX6New0cBXl/Gs2PPYHJW9fxAzGWa6GaMoSoUDdVCEtOZX2PuU8exp65V0kDNKybDy8IzBFEWmu3qvvYXtq9RAkFxUMhPxvmNUlnn3AR4vTSvaFaDJycPZIzT2xd+N1mUf86xE3BLFrQ9cSi2GTr0xziOtY0hNHaMX6PVRIHjFV04eaCcsXKShQd2QUXWqMA5czYTrAiBvf4l1jpy/+cSaCVjkn3mKubsj5Iit9Gl/I2kVDKTE8+wwJ1KhQjlHlIAvVvs7/3QLzhhUpknXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aepui/U5y8cI7eQ8dNYG+tbiK7sveUxmvzwC4iTm7j8=;
 b=RspbwqB3uPWkYqQbKQfnpX2lB66issv4cwUhzSRCOCcad2hhlBh61R7tuD8lPMB8eWqaEdWj/nSl/akLHcn1a/VaRuAu3wTAOyQUHnyu9/vl7+BIvcnvAz6WbsPu8/hFVzK6/SZEWS5AFNouBxAxTJr1JmNlHpDBgYGccJtWpVK1whLU4kSuGuw6s3cxqRJOWtK838fxeg7OyEpmtBRZQxkqRl0E97PixLb2sfeUgXc0Jpr+50kDPz8Va+m8bRbO3zND2rG0d0s6xE+Ti/FiFQqHvGyAPvo7v2AQBnL8/ogx0dvOXV6foJwd3QuP3qvDffP4FJnoQZ61HaIIUijsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aepui/U5y8cI7eQ8dNYG+tbiK7sveUxmvzwC4iTm7j8=;
 b=HLi+tATzECt60LUht56EAYVLYA+MwOiFvZS54ofVheHxFBRJypD2pgZqp1eeV9oE6pxCFLvaXk/vFhfPsT8XAO4qFoJe1NCWy37yB6P6KObwWoKG1pYUt8wyfn2c8gXL+fgxRazp+5mD4WEbq5BBCeVT0dN+qMLBfj/EXW2S1QI=
Received: from CYZPR19CA0020.namprd19.prod.outlook.com (2603:10b6:930:8e::12)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.12; Wed, 7 Feb
 2024 08:33:40 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::ea) by CYZPR19CA0020.outlook.office365.com
 (2603:10b6:930:8e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Wed, 7 Feb 2024 08:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 08:33:40 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 02:33:36 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 7 Feb
 2024 00:33:36 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 7 Feb 2024 02:33:35 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH] xilinx: zynqmp: Add the missing function prototype
Date: Wed, 7 Feb 2024 14:03:28 +0530
Message-ID: <20240207083328.1673752-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: f850c2d1-ecbc-4818-a07a-08dc27b77c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HIhcQUgpi1qnjLXw9CVkEw44JfKPPBrdK9A1HjZDRDfluVCDuTLtljVaAf1AzkURA4JWPCRwzJ1E7lBQ2cnyFQctaqXNMCrbE7M0mqYViyD8Ccv/jsqc9JOHkgu87MsV4BLoq/oUtU/ISkxECDB1SSLCwnprk3j4PsWUA3ZzVmC5M2xWfkYFtub/0gQVDRujkG8z9u3764nbfC2BTZ0okbFYcQlaLn7pAxtElSrr4/36YCayLgENmCHaS3Es0pdpj6DfgD/uzHEsOZ5SIPee8OIx6m5yI58MmnVHEz2QtfGCGXXVH3K5t/HNML6MWy+2gyfcdVAnkk0jNZcKsm0WquA1slWpIWF0BSaA2LVUHNzeBQrcYH8cRHXrn7tqVbzKBEzD4H80RWjhNEUvjTcKXggIj/b+7RevQMRX/HekDqS5MAgUddktIy/h31qTVGsi6kvzkYksM5Rt9ef4zHjTU5vVCY9LnuOu8q0ws6pcUXGTXezb0t+4cZPuVuCpyjrJg7WSCwO3rmKCZDNe1wg5JJV7JUP08WoQ3fjrM6ryxak2j2DoBcBj7oj9QVUabHGO7/2+XfrO8J6hMgXwHwnMwbl1Fh3dQGd/FWSD+rz+X+Hn+QgJEMmifYPT/9EnJE2pOdd5Aymhpi+0IQhRPl/BrSOUiwlYG17sw6IQ0d4A0xo6Q2gyUTIZHF8goCncmUZDmZgb/PY2piUHtEgj22D0yCpqc34eEMOe9Y2sdTd4y0cKWYykZaspigd1dP2Ugp/eOwv9pSVTtZ2R8IAcs2ULsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230273577357003)(230922051799003)(64100799003)(186009)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(41300700001)(83380400001)(86362001)(36756003)(1076003)(356005)(2616005)(81166007)(70586007)(36860700001)(26005)(47076005)(2906002)(4326008)(107886003)(4744005)(6916009)(8936002)(426003)(336012)(478600001)(82740400003)(70206006)(6666004)(316002)(54906003)(5660300002)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 08:33:40.0526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f850c2d1-ecbc-4818-a07a-08dc27b77c86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585
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

Add missing prototype to fix the below sparse warning
warning: no previous prototype for 'spl_spi_get_uboot_offs'
	 [-Wmissing-prototypes]

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 board/xilinx/zynqmp/zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index 9f50090720..ba49eb7be2 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -18,6 +18,7 @@
 #include <ahci.h>
 #include <scsi.h>
 #include <soc.h>
+#include <spl.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <wdt.h>
-- 
2.25.1

