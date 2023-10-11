Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF066CD98EA
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 02:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BA7286B33;
	Wed, 11 Oct 2023 04:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MrdCQIn0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8F486B57; Wed, 11 Oct 2023 04:57:10 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D166986A24
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 04:57:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G93vzMC2dlua3bUXS3IN4UWicy9gRK6qvng1aNnW5hIMkySIJqZ/6VeDkwKSy9GtZWJzCZTVqD1ybUKDvxMCZSFovREeGGEMou+9NKNKwyE1gVpr0a6IaesU5Yrgb0HSgUoa3EsmRAge+Hepc1D4DA6A+Qo/oTaHg18S0hMa9yrWZ+XpAkKy4VZDcO3/wdRs2KWj0T8wi1SBYFffTrIV7gs5Js3Uuv8pLOEQ725cGrjc81PoXZjNDo4WGNgKLKqh0ycF/KuWO7j/JV9VD7HrJqPP1R+znNjzFh3dKRZbwTejPKxMLX8PyIM38SE3UdMLkDcYxzbGJtPAiSt9m9iMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8Ey8L/Z0vm87XvwdE3sUfovGY9fizR75wXZ7tsapMU=;
 b=B8WBmVMtDk+uX/AgWHITqlPimyDrXekZ7tvOAqMGLg4UrOdwaZB+3AUNYvIMdVr50bySevCevJx57bvsUdynXZhR0p23leh+tFBEeLnT/4Mqrm1DoycvX8nY9A8CKqrhcoDohRJZaIWdLhfzkuQ+1iAG4PsN4M8aHp14RugIVUAjpshquwAIccl1BBEJbo2T7+9r9w67bUeK0zKOyW1+JwCcdwak8shqfvoSkW5s1f7xY+0m7lFJnpci1CExuTbe3iLkmOet0XiJrtxaYNfoNIC66k23UKFEzoMSI5fcJaHAv8P3ltZZWqINbBdxIQG8AEVmk2SrsQ2awfhF6o8uMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8Ey8L/Z0vm87XvwdE3sUfovGY9fizR75wXZ7tsapMU=;
 b=MrdCQIn0ey5fK5Z7ozURtJJMyqkHrjmbmaBVNLWQD4eyCMl1SZrdnGnNdsZ5N6mynJxfTsbT+2P4p3uhrK7tvh9YyCNAfMsAAI+sxNy0zgTZgbBvAx8+G9SkPj57tbG0DS0c1eQjMYntqMPLn/cDVLydnWR0z6KHz+qTYJcs1bs=
Received: from BL0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:207:3c::27)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 02:57:04 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::d7) by BL0PR02CA0014.outlook.office365.com
 (2603:10b6:207:3c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38 via Frontend
 Transport; Wed, 11 Oct 2023 02:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 02:57:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 21:57:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 21:57:00 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 21:56:59 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v2] drivers: firmware: Handle error case in the
 zynqmp_pm_feature
Date: Wed, 11 Oct 2023 08:26:47 +0530
Message-ID: <20231011025647.17200-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e034858-405f-481f-0bc5-08dbca05bf07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTBiEWnvVRidagJUQlZsQ93khrsKubNuExvWehvS5WK8qyL7NAzBO5q0KLMURoN9quZdjQaVKbyn3z+TP27kj01Y5GEicYVEJWcezaYk8sHSt2g0iHNBBddXRCADEzGf+/2XEraIi6ud6N2Utt+6Xmg0Tpr5bLEoe5XiFs+R8nWerEekFdWtQCgzyEVRDNvkCy5zGThFu88JuvG/BCQf6gnqI60YAO9i1UIDoTw3znjzVQVxpl5O+a9RVhBArXaZXcv+C5hxc+7kJp9MDHf7uBU8NHXaKXSc3tAG+lovRcWJZP3Y9ajxbYOd8XJIH1WXKjLw3+B1XdXQC+G3whv3H7IYTF7kzzVjRx8uubSNmrsew1RAZPBLPCtJph2CqCjYr/oqUDlymeQtpZMrl+D2Jvmf5oh8AipyAULXJ5WunMaCUwR7mTS0HXCvw9J4Sei+JRUqEZniExnJvmK/k9pEzKoEwCT1c31YNMGacbkbVb1oINrfHYOos7havMzZpraDF9FjuvGpXi3ycoLcR9DcLcuqTIW4qdqVwGxe+fA2il/Z1ijDzdq50hWWMGyuGRZq9xshHz4h0lMC8X6724Y9MLQHktGUSOJYIH2Do2gV/vAxpHugKZGLB6kD5cFqHhEZJf6gihxwkS8Kx8DyOc3PKEPAqegF6wtixNSVtceOnk61tm5PITWkU0m3hd9lOACfJPRpQkEI5IjQzMJRXYTn2co/m1KZ8f3qcbsKk869q7LI8C4l0tB8+Pfzz1PDc3qzYCaDSUpmvKwUIdploLEURw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(356005)(36756003)(86362001)(81166007)(40480700001)(2906002)(4744005)(5660300002)(6666004)(478600001)(4326008)(8936002)(336012)(83380400001)(2616005)(6916009)(107886003)(40460700003)(426003)(1076003)(47076005)(41300700001)(316002)(54906003)(70586007)(8676002)(70206006)(82740400003)(36860700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 02:57:03.1147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e034858-405f-481f-0bc5-08dbca05bf07
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265
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

Unhandled error coming from xilinx_pm_request() but return
value is not read back that's why getting sparse warning
as below:
warning: variable 'ret' set but not used [-Wunused-but-set-variable].
In case of error return the "ret" value.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Fixed the commit description.
- Removed the newline.
---
 drivers/firmware/firmware-zynqmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 43fb7fa778..8ea15c7ed3 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -203,6 +203,8 @@ int zynqmp_pm_feature(const u32 api_id)
 	/* Check feature check API version */
 	ret = xilinx_pm_request(PM_FEATURE_CHECK, api_id, 0, 0, 0,
 				ret_payload);
+	if (ret)
+		return ret;
 
 	/* Return feature check version */
 	return ret_payload[1] & FIRMWARE_VERSION_MASK;
-- 
2.17.1

