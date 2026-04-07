Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730AEEDB7CC
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 08:07:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B85C983A41;
	Tue,  7 Apr 2026 10:07:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LEAPJbNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C77683F98; Tue,  7 Apr 2026 10:07:36 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACEFA8352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 10:07:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBnID9486lK5sovbuxJWWUqGVDXOmA8ltlW+LAmeAYsxTi7vQJgumIlMmUUaSmEFPXygwPDIWT51pRGFzS5GWm2yyn+5+Qar1yuJT/O9s1s4D6zMqKDF4g/K7y4FQn2Iv5NjNCXWhNfMMAPQqlsm7q0AXxSpGM0CJ5PlOhGyr3aTSXGuWXTc4yUJHdk5UdOVpq346cvg25kcF3qqvKF5cQcMmhlwUf/GNuQvwxa2NsccB6OXNcc1sau64ZBQk2LMdmBxf83ERbTytGd3rvTLdKDEQIjTHSVFY0TljhcxiO74fa+lHI4K8TlnGMyc5X6HAVGa+JOErwKYFODYvARGaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/PUnsASocTTrzqAKSrhmVcQeQVPLhTR77LbVFcKWHk=;
 b=RC4ubYQAwoJXqgdH/7atLs9Ghy3lYHfwt5dAicC4e+xqHOLdEQjcUdHpT6y6NpTZAQci53sr6oitP/606ZX+EYa2R+1SxMacsf7lbC3UkGDayRHifGDUkfyaxW17YnqzL27JlaOgVjNVAdhzewIboUSzeEk6dTTJwItTJ3Kc4c6bQW8J9Kr+cpIFynjisSvVFBz+tK7iHV1BKftY+yg0Bnmf6UjFHzwl2hA58WHv3qIBe2M2Ga4t7N+wVTBVN4Gc7m2uAKizVDvPOO5GUNSxdOfGygJDJX90emGtlevutKXo7j5tn/8MM2s4X2njcAbui+tCUtTU0jk2OaA8Bx9m3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/PUnsASocTTrzqAKSrhmVcQeQVPLhTR77LbVFcKWHk=;
 b=LEAPJbNTwRdT9Pe63lL8g8d8vqG4QLuujaELhq4qOskwCCWvdDpYrhH9rUG28x1+JCWhsSS91PxWQytqs5oh8mvM1C/2+g8PE/7jad2FfAARQCGj0qwmeowVXNrKoLSKWv8WYn4pT6sL37y7oqOinThPl5WuAyVu3U5kKlCXgFs=
Received: from SA9PR13CA0106.namprd13.prod.outlook.com (2603:10b6:806:24::21)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 08:07:30 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::5b) by SA9PR13CA0106.outlook.office365.com
 (2603:10b6:806:24::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 08:07:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 08:07:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 7 Apr
 2026 03:07:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Apr
 2026 03:07:25 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 03:07:24 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Pieter Van Trappen <pieter.van.trappen@cern.ch>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] cmd: fpga: Fix wrong preprocessor guard for loadb help text
Date: Tue, 7 Apr 2026 10:07:11 +0200
Message-ID: <366dfe78e2028f53a6274da75547fb68844764cc.1775549229.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ehkvuRMq2IyoiUPWObY+rSesygj3wKlsg0DbOQ7EVXQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRe2W0wqbK2VfyDX8uvW/Yr5qp9VT1Us5932onyr+Gzd
 m3O/fZ0ckcpC4MYB4OsmCLLdCYdhzXfri0VWx6ZDzOHlQlkCAMXpwBM5FICI8PJr8cuzuhYJHUw
 W01lG3/XvpvKGx5pG07/3B1v0xFq6/Kb4X89v9pObq1fxzy6P5en2Ce3FkkGZ9rZSMh/1q72b2b
 lZgcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: caeb75e1-b851-4020-a278-08de947cb6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6v+PGfU06p/88EnocOIy8seALBgDlD3cUyEkDvLIAwqkZPuav9Z7uicnQZYbUMP7BVQjimSDg5bKHWGDsg0MnP2efXrUDDdHyU1WlGpxTd6HWFf4b+MOYPMRGpYne0E4OgXpa6n38E423hWuxsbTkAAheQr2nAvzEkue/mVh5ilA0l4eU0mtT5k2XhRV6df0Ixyr0YZMrmqqT8aOWsiIZDDXtRJch3GDlh/QR3qwNdgrOr4/Vn4dFPFoNCZbH2w5fOil4Pj9hYgQuOol/+YUpViggxsSi4XGT8lOj8mXlGByq7SutWiVyiW9PSiDsS9c3NIZiQcvjfPe8bkfLljiuwE3fsXy36Y91yEFlYfALV74ojyx+Tzrw9qkpfeNWEJ17cv8GH0pS0LzV223tBecmj3kqUPPRH/3MNQsAL0SiBf44IRcTwwMHlR14Fx8yu6Aw+f9mWkLoGvx5JWw6LDzgecp1bJVXuFToUhVEXHvrZF8xf5cBc5opXEhLBnCQos7Xmg8PwWS9FYmzBUaAxsGpuuKZhnrGE4CqAX6zIYY6CHMUh0v/jJtAWeXXZ7jo0536eQrNHNrPOeBbWV0CkNv6Vzo2mCxBCwz2Xy+6pJ8gFqdzw5Gck2lLRfBU3BCRJqcW74KxLvAAseDCALAOJ4MqZuEKNk7rutJffTRzXNGT23kMTU1yYkUhFgOmhhDxl74VlZhJDoubKCO4cRg3nXwKVyPfYrLp5yhvEpetx46CvLMrPwJGj/nYWfbcJdJRmO7Vm+ODVELgOpvApEMg9GTuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QgDI6wxZbld31JOo3xluI7u5uIM4af/8u1ZUqO89Q0qqT03k8ZPi7ULJjWw1tUEuf9qnJHXLVeacz6iRIg6Wlxlt+cTeguvizsQO9QjlsgRACVz0zm5jrrji8jR8DI/D4/+vPtpwOx8rroVQhWmgYvifv7djxkpF2Jyem+WDa5Vbu1Ou75VCcuGc4Nr75k60JTbuCq1ZuD6YoTh509VCPqkwBdEUxsATqJUJ09f4U4Pfnnx9GzuA6HmfGDPJYYtZWMXEA4y74h5rHl60ZyS8iA4SmvUGahEhEWV2nKMGbf7JGUqd/MreuT8rF88K+24MBtk++TYsLjkaYT9RVEFltz0rZpdQcMil3oaDPa/xll6rKCp6u587UWhDwK5A9cbQWvO6rIl2pvxPMhn/m10pUavVq+mAhpgfrg3zYqDJvP/Bb2Po6OYS7MmObTIZVWxI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 08:07:29.5872 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb75e1-b851-4020-a278-08de947cb6c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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

The help text for the "fpga loadb" command was incorrectly guarded by
CONFIG_CMD_FPGA_LOADP instead of CONFIG_CMD_FPGA_LOADB. This meant the
loadb help text would only be shown when LOADP was enabled, rather than
when LOADB was enabled.

Fix the preprocessor condition to use the correct config option.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 cmd/fpga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/fpga.c b/cmd/fpga.c
index d51c380d7b3e..d347a7002906 100644
--- a/cmd/fpga.c
+++ b/cmd/fpga.c
@@ -417,7 +417,7 @@ U_BOOT_CMD(fpga, 6, 1, do_fpga_wrapper,
 	 "info   [dev]                  List known device information\n"
 	 "fpga dump   <dev> <address> <size> Load device to memory buffer\n"
 	 "fpga load   <dev> <address> <size> Load device from memory buffer\n"
-#if defined(CONFIG_CMD_FPGA_LOADP)
+#if defined(CONFIG_CMD_FPGA_LOADB)
 	 "fpga loadb  <dev> <address> <size> Load device from bitstream buffer\n"
 #endif
 #if defined(CONFIG_CMD_FPGA_LOADP)
-- 
2.43.0

base-commit: 950bf29f73f44e8edc6b22cb7ea2d9a56cfe2872
branch: debian-sent3
