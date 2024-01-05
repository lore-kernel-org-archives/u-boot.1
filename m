Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606BDC47079
	for <u-boot@archiver.kernel.org>; Fri,  5 Jan 2024 09:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B23287968;
	Fri,  5 Jan 2024 10:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KvZ7ILNB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DF0686813; Fri,  5 Jan 2024 10:56:16 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4834B8796E
 for <u-boot@lists.denx.de>; Fri,  5 Jan 2024 10:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MklfeZ31cj/8rnIRUyojvjpH6WfEHW++P7pAR81QOAb5JYMsvgsdJh+axkGTLuZ/Tzk9W5GAgOD275rLNy8RB7ZMFdQKaiVqedkiblToeqMbXpGByq//TbcD6VNZ9a3SF9PuzVgpQEIYSmBx22blvBf328WxizQTZWsV/NsGMCkhZqYN/WyelPgROasnUe8OYfbxfO2IYVruSjbW0SeOoqUGXHQnJv2a2HrSr988CA2bjhYJ4gh2aEpsMFgxm2jNw/3TNZAsf2KwFw+uAETJgyx4FBluw8gUqxQU+XIxyXxCEbRKaHA00VklePUNxwHMKL16Tn872w0qrGm+PPdAHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezpz/AUgT4+N9z7FS1vOtfHuIfykIjR5/2KKq6wtTQc=;
 b=gaZwPj9zfgeae29Xq9Nn4T3nUGTq755UVXqDTW62eXGycMT2oRU1kTbelVgYjZLsEJwEJVG92TJDI8fSRX1m57C/QIvbn6t1aQ/RHtItQGfAH+BFxm9PsMc7B63d99Vm+nyF6TqN1cG5pgVQvQrkPd09qCvwjERqPhAT7Hpg+pjExm3um/qyRHDuVOi0YnrSS+A7X5GYeGvv3NMyYk6vB7r66qb47FMW5eK95j5WMoJe/oYJ9bhdk9KmE3J/i2VY5XOSbQB1FPZcsbBTJkYB13LdmP6gO6qz4VIUWldTe0rFnZ94Mes/qaPPmjBltre+sTHFGLJoYqYsnN3RNJlVSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezpz/AUgT4+N9z7FS1vOtfHuIfykIjR5/2KKq6wtTQc=;
 b=KvZ7ILNB11pTrtLlALx03ZAjJASkflJ3ulQiqN5ak8o9jYKLVMNq5vXFzQxkxTVONX9SaN002jQ26v41okcZVCQIWopcb3I5senpqkgCGuN9AI74IFC1YI9wcA/ypQTB90JNTbdxjHtDlwUUqWkm8l/p8CxNZF6J9p6MX98yAFI=
Received: from CH0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:610:cc::28)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 09:56:10 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::71) by CH0PR03CA0083.outlook.office365.com
 (2603:10b6:610:cc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.17 via Frontend
 Transport; Fri, 5 Jan 2024 09:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 09:56:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 03:55:54 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Simon Glass <sjg@chromium.org>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Add support for new power-management node name
Date: Fri, 5 Jan 2024 10:55:51 +0100
Message-ID: <967aa76f9f72604c874b580476aa85f5260ccd65.1704448544.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=6qUyLxo4LhhCnjNYyXTgF21OaNJWgmHNd3+QgVhYhl4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhtTplxSMs2KUH24v4v1tdOXIheIbfGl7fnXdmfrg+GO7t
 fsNz1+Y0BHLwiDIxCArpsgibXPlzN7KGVOELx6Wg5nDygQyhIGLUwAmsmIWw4Keuw2tB6esVtrW
 ciLpzkz3KS6K7+YxzC8+enkGvwv3gaPt5/avWfqq2/GL2VIA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d56901d-7a1d-4b9a-8d51-08dc0dd48b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bStiJQpA8LgK2vOK0qRBvr2/C2xIVQFP6xSKxjfEzWrRznh/liE9GnISJmcf+/NgqDwY87HQpSFcdV6vsv9lhKlGqRAa3Xoft5ty4zWLPijIGDZJ/PI+y5gx2j9KzsfW8KphOdaOBK+Us3HkfFg/+MhyN5RFg9U7ftsZbn/3lu9C6zg8bkzGdy7oyR0rA1AQ2pT4Gh/M+I1iUP5+IPF9JTqLmtyqErW8iW0L/ZDfSb/Jbfrilno1CwyEJ84hs/3Ir8vYMlOr4kqSS45FwaPKhPyBQDuCGHe21qyF9ACl+pKP9NJ2fYYhF7DVTCFgx1dVIMXQ0YJeYdUZCiQ4BYlgwKchBhz6U6AU62DCFtunm61hNWOmstPYjLfzOneLAOms4odJv3wWL37q7kUfKBjqwcSY83FGO14930dxGFjO0AbburBVrnRfV0BJjHFxmB4ta0z/YPceXgBIP97rTCPOsMIanHwmonagWOmcoBW4Ijgl1DsrLbnhqxMbsl7cHVaHBAkiuszS1/BX520OPKzYC9FuICBn7xp7v39QtXjMzlcFA1XudFvx0/e4P7B+nu+YBXdlcZQLyc5L53ksaKt+RrZDny4AFL+3xv3NU62QFboR6LRID8EVvdMH4IhG69Bf6NIcgw/brQ48UqybrsGx583uRPs54ilzW3/p46aTWr7urDf3+wSGZjcbCFdHrZjH6MPStaOfYU9GvrGQza4Dg8+Jhwq9Ss9PBSLrccHZhQ4V6ysmkAM7XvungsFpjTgC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(82740400003)(70586007)(70206006)(47076005)(356005)(81166007)(86362001)(6666004)(2616005)(26005)(16526019)(336012)(426003)(44832011)(2906002)(5660300002)(36756003)(478600001)(966005)(83380400001)(110136005)(54906003)(316002)(8936002)(8676002)(4326008)(40480700001)(40460700003)(36860700001)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 09:56:09.8691 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d56901d-7a1d-4b9a-8d51-08dc0dd48b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

zynqmp-power node is going to be renamed to power-management which should
be generic enough. New name came from dt-binding review that's why there is
no way around. Add support new name but also at the same time check old
name just in case older dt binding is used.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

DT patch is available here:
https://lore.kernel.org/all/a2f7fe30e3630c262c2773a595b7a0c8918573a0.1704359569.git.michal.simek@amd.com/
---
 board/xilinx/zynqmp/zynqmp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
index e3700f076bc1..9f5009072025 100644
--- a/board/xilinx/zynqmp/zynqmp.c
+++ b/board/xilinx/zynqmp/zynqmp.c
@@ -156,9 +156,12 @@ int board_init(void)
 #if defined(CONFIG_ZYNQMP_FIRMWARE)
 	struct udevice *dev;
 
-	uclass_get_device_by_name(UCLASS_FIRMWARE, "zynqmp-power", &dev);
-	if (!dev)
-		panic("PMU Firmware device not found - Enable it");
+	uclass_get_device_by_name(UCLASS_FIRMWARE, "power-management", &dev);
+	if (!dev) {
+		uclass_get_device_by_name(UCLASS_FIRMWARE, "zynqmp-power", &dev);
+		if (!dev)
+			panic("PMU Firmware device not found - Enable it");
+	}
 #endif
 
 #if defined(CONFIG_SPL_BUILD)
-- 
2.36.1

