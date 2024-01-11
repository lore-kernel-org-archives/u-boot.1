Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1032C47077
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 13:49:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CEEF871C7;
	Thu, 11 Jan 2024 14:49:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZKkFyA/M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B69F8750C; Thu, 11 Jan 2024 14:49:14 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25AA886D23
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 14:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njPp5khh3H8ALYPrxF5qfVQaaFdAlYwURmJrbhbJxKneiDoLjSWkyU/EOgWaJGI+YFp6mnELGSUXGbpVxAJZxWZJzDLNT5rsL3liE46oTs72EJFtrFNKVzqkMAiGVUl0n+XttNwiJZnfmzmnwy4njPF+yJrtKRmMVp6eUHTDdTs7KNfSe+tOLS8p3HmhJEIo8v3uTHYrXHXIZjfQaYey3PniSw7ds/Tc6Ed56lYP+Zt8J1tD2g6ZGxGNJ+Yqbc36YYPkeVsEICSbdua2mw0aJR0eNNhsKIM4z/5D/3dzqEAiokugdWg7pWExGeiZtjdR4VRylHKXavTXdCdrm3RGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJDKBYFWiIAgHqNZ3ipvytoyWmJyU/MtLi0EGjf71jQ=;
 b=ZBeX/syA3NUW+5HNOBcXmwxE5rqnso0aAiM3JF0uWj//c4/zKbcwdTuksrV9R3cv0w1YLutD9FRdaVJBQESp9g0TL+TkVxnQILB9QBZqw3/U0hPOXuekNMeFpohYEYr2+Da14hSYawOTckImO6h/T4lWiDZ7liWIcwDCELATgDDvdY3A7vQsEYAn3jR2pqeLLypIGTAZUwrDHgCDC6swLj3uBZsxwd+8TLfQwUNetqsKzeCLFFg5do40UrdBcqjA5ifW9kPB3107/uKwUIa5pbI5Qtj9dc8VgrHYr9T4pme705e2ZxXm19G8ZbCpGLJBFBPR+3FdO7DwACQ1nfneeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJDKBYFWiIAgHqNZ3ipvytoyWmJyU/MtLi0EGjf71jQ=;
 b=ZKkFyA/M/UbuRx3Z0KcGO3WasHmOPJQDRnydQ4sNR43eHE85YjOmYM7V/W3dvqqjo5euhkyMURQcN+mNIB3ZdJc3TLVbnhtCmAFiMZ3elxRyYRZNafCMnS+G0rHUH9vmlnE7Z4wqZcpNrQiOz+OcG332DUWl67ijz1LiIEVvhAA=
Received: from BLAPR03CA0161.namprd03.prod.outlook.com (2603:10b6:208:32f::8)
 by CH0PR12MB5073.namprd12.prod.outlook.com (2603:10b6:610:e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Thu, 11 Jan
 2024 13:49:07 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::42) by BLAPR03CA0161.outlook.office365.com
 (2603:10b6:208:32f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Thu, 11 Jan 2024 13:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Thu, 11 Jan 2024 13:49:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 07:49:05 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <ilias.apalodimas@linaro.org>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Start TPM automatically via preboot on Kria
Date: Thu, 11 Jan 2024 14:49:02 +0100
Message-ID: <dffd2ee4cf2844832ebbdabefca0099cd2629ccc.1704980933.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gpjQRyCHN8nL2/NG9praTfZFtFpGzoXNT+Jyv426dyU=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtT5H4/JnwiIf9MwW8pS4IlayDynBttpPBphGVd3slT9l
 48Lso3qiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABOJ38YwP8xk9kThokuX/MR3
 VFl8vv87SEzNg2GeEVfhB4kHn9sap8oEL3RZ8dyGr3wuAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH0PR12MB5073:EE_
X-MS-Office365-Filtering-Correlation-Id: d786e7d2-f7d9-4772-0ef1-08dc12ac1464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KvhvEXEYCIbDyi8aalEO/nUf2/DYNgvWlaofViIg9enGqn4/EG/enNnU2OovGRED3dpg9C6ChchdvSxTn8PGPqxjZ7Sy7YEZNT6eM/69sRK4B3Ktahhw0YETbQvKhgWejOTNY13SSxjv/MTgp1ZG8T4O4Zf/g3oyQWtWS1BsVMZOEUDxCApJ3V6f+eTjprENSu/M4C1vaXJQ5sf8WLaL+jK+NsU2NyZWruCYd9zdpzD9xzVWeILPEUrEU64A5n417cLQzWuiuQadh7o9zgC76RQxhDvekAGvg/3E9U7cPgvsQnMAXxCxWhK1iUYW4tNnhrQ+C6JqxOcRE3dAFvMWTLb/xkjLYExYT4MFrhcC0979n4w39W87dc9gZDm/O/+KSVZ0VPmE+G1GyExfwTy4afbruYGI137a2Lol6N6eapHjvL9RW5NrzZzja1sUPuQRkNGqR4geXe/1YsHmYThaMZEfLbHKXVOBzqxZfAcUZyjs3Mq5GXTAF9VFf1B/J9FFL1hhaETwJWGFMn17zEa3kGHfVvIM9N++nLZgavrFKKH6C2QO0AUCnaKN00bPqfdM3y2XJ/im2LVvmMvDg2i+FQ8xT8BUEYxJ70k37SVs1sdz+YHkfxfw797x05DCn1h+QsbGQxr/pUD+ivjNadloST8hymoBdUo0nf7BX1B1glq3o/X9nfdjzfjkY5awCSRpzbxu7qDoNlri4I1ERVLXquXd8CX27q3FusdlapaI8sZYHnP5rNGmnooIyXRKBR4otr6Az+JVxQCDfBoPLM6Ycw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(16526019)(26005)(336012)(426003)(83380400001)(86362001)(36756003)(81166007)(356005)(5660300002)(4326008)(47076005)(44832011)(36860700001)(6666004)(82740400003)(2616005)(110136005)(316002)(8676002)(8936002)(70586007)(70206006)(2906002)(41300700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:49:06.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d786e7d2-f7d9-4772-0ef1-08dc12ac1464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5073
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

SOMs have HW tpm but previous stages won't start it that's why start it at
U-Boot which will also provide access to random generator and it's usage
with KASLR.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index 36182f1b0d85..0f940bd68f89 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -60,7 +60,10 @@ kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
 # usb hub init with enabling PM nodes for ...
 kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
 
+tpm_setup=tpm autostart;
+
 board_setup=\
 if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
 if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
-if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;
+if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\
+run tpm_setup
-- 
2.36.1

