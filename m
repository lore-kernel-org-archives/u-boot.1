Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640BDEDB7ED
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 10:34:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCB7E83A41;
	Tue,  7 Apr 2026 12:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Unsd7Y5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A13DF8406D; Tue,  7 Apr 2026 12:34:07 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79FDF8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 12:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MPljK4S4CHPu8yGs+ULLXxJSfYZiqoqBtZVJDPt25vHd51RVKZzNo9lsq9gkjPj6eY5Jgat3oNv7u2xCP8y6uPROuSa1Yzi1Kj2Os698CJnALxp8OheRs+POdQ+aEMSYF9RbFXH0qm+rb5TUGB2+mEwVzTkVSaHeV3c4g3DBOuICIaeGxIMR6cRVnONsmpAQZFWPlHqL7TrZ5QPeEKQ3n+Ar8V4RMoZOxlOjJrAsHAEIgQgdvhNnYIXnEobR2sXbHGYUlKjyud9VqQhxbjRQu2T4dwEYkREMjjEj0EW2ZwExaomZ6BTVhGMU0wvp50+9XvPYib/bDjhfzsa7Qr4gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZukwlCkYGi/+f7YJcJtW8mQHcsoWTXmQMCsQXlho/I=;
 b=WGRx8NXo9/YwKt8jADmjaNYiMynDpWiz90ayib4brRy5FPPaKmUpjCGhseeKNDqC/50b2a6JFKO9k9troPAmdZemmr23j7airfU3noCwd4lHyNYNO/hYbYrakAlltOZ89pWlxA9U4dbsbGpoR05z2RWP5cGzBoXxG+Ytr5GguXjnco1Mzkn8JcRcb5okMmjWBRefvShU6Mu2qmCW1gS8/Pole6uvxQCVtmzKewGEjjZDPAoOGggAI3w1wli7uMzshvWeLdxOSDQs+/EazJ7NuI0IeGDu56P2khxG5EZIqDRTmeh/LZ9XZk3fVxzhot0o56duwcXM4DK5qGy83CjW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZukwlCkYGi/+f7YJcJtW8mQHcsoWTXmQMCsQXlho/I=;
 b=Unsd7Y5Ll+bEhqFaFLD/B15WKucOeUjZxqZZhvsgTh9CKGmCBzT743oP76535wVrt+uozFTRg2+nbRAjpyOe7x9MepSmIYS/BmkvwtexajjpKQvzSfec4T9vWl90iWGWwWph1+VbtupEZSGIydwQyeT6biKgsj3tt3tmlIFJF4Q=
Received: from BL1PR13CA0324.namprd13.prod.outlook.com (2603:10b6:208:2c1::29)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 10:34:01 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::fd) by BL1PR13CA0324.outlook.office365.com
 (2603:10b6:208:2c1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.35 via Frontend Transport; Tue,
 7 Apr 2026 10:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 10:34:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 05:33:59 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 05:33:58 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pieter Van Trappen <pieter.van.trappen@cern.ch>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] fpga: xilinx: Add option to skip bitstream ID check
Date: Tue, 7 Apr 2026 12:33:50 +0200
Message-ID: <4951c9780b251212ee38ae0f368fd79e6a571c11.1775558028.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=CbvfsM79Ed2MMZObow6IaG4+WmWZBnjvxbLc/bi3fBM=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGnU3Y+haHdOHTiNi5evzTLDDPMzxQ5ULu9SD4yudnuOgs4VR
 4h1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmnU3Y8ACgkQqwf+8E71EfXevwEA+cF7
 JTQunZHc+7vgfiMLL+psyOHPztYuSa/oNDYUd8YA/R3f/I1y7/IuZjxQGa0B1GMWta6BSYHtpWo
 BBXQlgSEN
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e290eb-e6f9-4aba-7715-08de94912f22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: drqYobKYxjCl6Q8QefJjUbhvkPRCO+P60WGpcuabvliYkGK5EyQXz1l9I520fW4iKT/qRHaEXRCiv6O9ANo7Q2mpcXvAVb4IMXB3RMQWps3qR7xO4/Rh91tJTwdtoDqh8rqmj2KDlrJQVB7mbj0wRFVdF/YX6goPf7ahZbfZtcGliKk6BNTMnX/qIFSKpv4a43iOcbdPozn43iHvTfHJph3zIslfrno6sfxCTOG5NCWLC9orLJEDgDDEN7Z2reWB2USODqJP4bnJOXSRknQRtN/IDx3NDO5j0gehtug1WhErdDmL7ozlyChw4LSpMKI1twf377GhTC3v4PLMrJ2K6B4DPks0MiYJoAlbc1objAjH7+J/4CNo7eac5rxnyxtsb/XaTLM42FUQLbQmmyT3QSV/iYkqqjPH/kmHjjsQsZjrqYStbKfaTj+LR/8xvY2u+IkzUCli3iKqL334f4Tb2gGj9AzD7EJkU0Y+6whshFYUAxqwklF8JKwZYYWSIZ/iU/e/RVejpVhXgDUuJ3axv3MF1CE/plSFyGoFgK14KtG/wjG7s0ObJ9dg8P/m+1pml1dRV8Lv5JYLP6HMgW7tiDuMf2jNBKAEXYgiGkwoJasDQQTc/kXUv8Ck0+0NpXOdJdhhCxD25+taetUqL0GAD3KdgszL4jHlhuqaYByy0bZhicU9UMI+cO4a89diGJonkP6zfwXiyq9IHbscP+xE2o4FzX48ITrrQxLgqGe8N0VgsHQaUE8Il88V5HlWOnm4vi6b0JeHd04tj2BoKXCNaA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DqPmtZcXgCQAhOrRrAvbKHXQdZRz5IBBAFdYXp4quXzHvhD0wM6jL+3PVd+Jb4FybRaBEwOWLKTg60RWxvvz/Z0pkUVVcJ5NYRuZBAqevEcjU8lhpITryRibVYg20ouCFb2i/OK2qvx3ijxLopRkaOYWvVe7G5mgZMQE0/T2QvagV4m902Fq2H0wzv1dAYILE/FI6dz6CbvRx3RzzTyGyJwLgh3nhVL2gM1ZkHfbnK+skzjlKNLiELDDxNPE+M0y5AIoI07GD3ZrECkx9ijeHYPw64oHj3E4tUGhz/0A9dNdx9bBQIhSCBfj4MkT3NCHQMmCNXUKLcSHkhmaRZjnXhXhiODB/Pyqvzag9RHk1YxMFtFrngdSdIvihBLbLmdabHj5+JQOM1oT+Fe39m2m5/d4DnkgYSsRyMxXrTsb5V4zgNMnnwp7L7tEtSv/Vwy+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:34:01.4714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e290eb-e6f9-4aba-7715-08de94912f22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
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

Add environment variable 'fpga_skip_idcheck' that when set to '1' or
'y' allows bypassing the device ID validation during bitstream loading.
This is useful for loading bitstreams on devices whose ID codes are not
yet recorded in the SOC driver.

Usage: setenv fpga_skip_idcheck 1
  fpga loadb 0 ${loadaddr} ${filesize}

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/fpga/xilinx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 25b348648eff..dd8888b908a7 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -11,6 +11,7 @@
  *  Xilinx FPGA support
  */
 
+#include <env.h>
 #include <fpga.h>
 #include <log.h>
 #include <virtex2.h>
@@ -92,7 +93,10 @@ int fpga_loadbitstream(int devnum, char *fpgadata, size_t size,
 			       __func__);
 			printf("%s: Bitstream ID %s, current device ID %d/%s\n",
 			       __func__, dataptr, devnum, xdesc->name);
-			return FPGA_FAIL;
+			if (env_get_yesno("fpga_skip_idcheck") != 1)
+				return FPGA_FAIL;
+
+			printf("%s: Skipping ID check\n", __func__);
 		}
 	} else {
 		printf("%s: Please fill correct device ID to xilinx_desc\n",
-- 
2.43.0

base-commit: 330098196cc84115899ea7a14665a8df7e279fae
