Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF89C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 09:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66E8084AE7;
	Thu,  9 Jul 2026 11:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="39MOKKk/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF96D84A3E; Thu,  9 Jul 2026 11:17:43 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F40584A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 11:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HguhXxYcH8CVWdUzVd3VmK6ESKe6H8UFTEaKInLo6YQS/NI/ZXM8XaOOwomxbw6np1Rfvu2H/0u/th0IweADlBogBNydHtryXlJ1i44DnuCwnGkfWRvdGiZhZA1vFnnAAi/Pg0UJ5lsAs1n8RRCsiDXaY4QVJmoE19SGoJG+13rqFYEAvhC3HWeSpS1AHldn68dcYQOa7DEET0tp33jll77caRgLmNQbfBLmbmWjD/e+ujOcjC8MsckToSYu7Cxp2VKvE8/1Af6Gjp1F5LnONftjRfaE2Kj9iU8BdchHnbJRGhdOOA4SbaKCdZ9GmtEKYCDP8ZmFipHBHGnxO0Yb1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7LXWi+fc7Fb0CIOvFtf5zzrx+uTzaviZ4zaGrNQn2E=;
 b=OiXxgPzs7V7IDqeHTLw06hBiEo+EBPuEVaWeH9zRvOZ7JzqyVTdqSXqyTlHnRWsM80I5Tis/78wwpVS5Rv4oRVqMT4DX8KexyAIe1pZBzu4wEqxKJiEBJSvKOK43KySu83fVzJ9re59n4niOYZaan6tnI4H5mxsfAtNgYON0RV1uqkzSCWzfM02ve6q+1XifPRXCEo70Kd602NgxIYZgwJ1es4lZKCOfOtocXkj3Zbjh9tpRVwEfoyFY0P/EVEkQIKrRpWSltFQ7wzOSowYcG77JNxTi1lG5GkT4VuVJsTH/dNzmtMvpwA2zuHl/M2AZXub29VGAhlaSiw25SejiKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7LXWi+fc7Fb0CIOvFtf5zzrx+uTzaviZ4zaGrNQn2E=;
 b=39MOKKk/tfVp2neVuvxWToDFMcLkmwz3zdK73Qqn8MzGlq4ezNPPX4UJux/ETVFurSHIs2eDWkVXXHMMbwWKuk+73HjT291xekzyAJ6+9gXAh+hBShCuEZcsNlNQoE/ccq9/D+e7liHCc/2hCH70yHTmPmKUiPJCIeHjTpNMcDE=
Received: from CH2PR17CA0011.namprd17.prod.outlook.com (2603:10b6:610:53::21)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 09:17:35 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::69) by CH2PR17CA0011.outlook.office365.com
 (2603:10b6:610:53::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 09:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 09:17:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:17:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 04:17:33 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 04:17:31 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH v2 2/4] cmd: i3c: fix list and current needing pre-selected
 controller
Date: Thu, 9 Jul 2026 14:42:53 +0530
Message-ID: <20260709091357.1860417-3-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c44bb6b-b5c5-43ba-0db2-08dedd9ae9fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0bFyKLZ15fNrAwHR87Nf1tHuSn/PA9NmCo+hBvL1ads1218bHcr5AwItR2g3dTizHMqMZ2O+PxLspG9m2SG2wqArK76mQKrDaC6JHEUkteaX3xFZqAwkEn9u/gWNmy47pNmJJG3nDUHvJqe912kl1MvUA0eW5ymIIbem9MM3z/ceK6PSKLQjvQqQRjDk4dBTuR9Kyydp3B/kzk6t5JyC8evtkYnwAXYRKgtgOqwJIKp6BtJkQe1VStz9TZE+4a1iy83UnFT224XNX+okiNTM+GaZU+8RYNIuMuuvYGVRvwoIpKIgKz06w+kCI9yui9PMCw7Cjp1ftq3utIYZ5TZhNvNNS9QW2bfb/7Gizav+aZEt0eRX11AdqmawwdecsZE7knpqZxGaDNHQ3w8nD486iUHIw0zu9uIiviKuRPyEs3wqKeX49U2WCaZQQRR9Z5zZdXJteXSfp4E6qgV8GxqD9sxUHslXqzqziDYGKnZwu/DSyQXvAGVsSkAxLZMYD+5QWLFFGPcEBGwKrdGR6nOScYzKHeQUXXUpROt7KjKuFLfX8SCDHXoTd2S/R7XfTC0Jjb9zyV3iIVLOFmbL5ythoe5RWREyo7Hw2eYpIgCyLmpMjpC7dxHzyxzFEvS2346riKgufmMBJdKIRqznVFVj/yOebqFYIw7FP0QtUZLl1MWPcwknveowExkEFQT/YoVMQH4qDkv2RNZRfFpLfeCMrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z0laKP6iDiLri60QdjUjSoY1uIoR+a6oJOL2sRRL7tVL7DsjzHCDr8kA2naI1nW8SoiQrrhWOOnunmkWox6bpcKDErL7O4GLMfae7fYn/xFYNo78rSYbGkYCGW5P601+mmjrw7ecCqmIUPP6HaNm4mAEFcHZ1Siv8b34zcXR2Y4xptVZrSlZ8sOdRW14+dIlWLK/wY9ClJ+ZVWT8T1g8ZfQZUHZHeF+XqwTZrWY1IHXP/YLJ6HONSiowdywZFLZ9ZU/9It80hfpP2NpK3dbtU7K7Qvf0JNNmKsDbaZj0yd0rHgpgSvn2XsFbTzDxIKmB4gD8nAdz7Xj9gcpjElNTJwaiuS2OxtEOxt3JEu8lXxgNGLNkDKycUQFOEomt5eqKqEAk4/nt2aFIfCRdW/SY1HhUhJldItTw3sT5gtvz49N4wadNUwVj8coGRAy5Rsgz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 09:17:35.2953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c44bb6b-b5c5-43ba-0db2-08dedd9ae9fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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

The !currdev guard in do_i3c() was placed before the list and current
handlers, causing both to fail when no controller is pre-selected.
Move the guard to only protect device_list, write and read which
actually need a controller.

Fixes: b875409da737 ("cmd: Add i3c command support.")
Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
Reviewed-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 cmd/i3c.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/cmd/i3c.c b/cmd/i3c.c
index 08957f4d447..ba99a937990 100644
--- a/cmd/i3c.c
+++ b/cmd/i3c.c
@@ -240,16 +240,17 @@ static int do_i3c(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (!is_i3c_subcommand(subcmd))
 		return handle_i3c_select(subcmd);
 
+	if (!strcmp(subcmd, "list"))
+		return handle_i3c_list();
+	else if (!strcmp(subcmd, "current"))
+		return handle_i3c_current();
+
 	if (!currdev) {
 		printf("i3c: No I3C controller selected\n");
 		return CMD_RET_FAILURE;
 	}
 
-	if (!strcmp(subcmd, "list"))
-		return handle_i3c_list();
-	else if (!strcmp(subcmd, "current"))
-		return handle_i3c_current();
-	else if (!strcmp(subcmd, "device_list"))
+	if (!strcmp(subcmd, "device_list"))
 		return handle_i3c_device_list();
 	else if (!strcmp(subcmd, "write"))
 		return handle_i3c_write(argc, argv);
-- 
2.34.1

