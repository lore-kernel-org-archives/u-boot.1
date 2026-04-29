Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5460CFF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 06:22:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA16C846C1;
	Wed, 29 Apr 2026 08:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eS8PEK2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EB9846C3; Wed, 29 Apr 2026 08:22:38 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2098460C
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 08:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+HollY1/oRazx7ayhKWH3DRq4pkdQQD6uWu1jKQqnQ9QOFG8eqX8I7H+ka/yAIAWUagfHn+Q4FkQk/l7Qw3L3RTQHCi6FtXPpHUfe+eVKFUPXg8g2fjvPJVfN/UetaE4nzsf8SgfhndoT0VWghLVKRIaJGZCTRiYgZyo6cyPOZLekfQ7vqVO1HtlC+fgclDGxtE4hmhBJk82Tmt2Yiw4XsOnF0lYwIPdrsyhygpNjKEdpMUce4huCe2SZVL0Z6EKvtfrr95pkAiVhe3wItH2axIIAvQ01T4I+dKt7ytkfL5SFVjqrxvvvF6ftmrDvPBTYthhw3h5KZnVR13+OyGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN1onI1EsUiE7aOoVqWKB0r4bIsRKNUk6+dFxjOqVLc=;
 b=r1yIO0NaFmORLb/E48Dfhif7uW/uCCcJYVpss3B3q6CBI0+okpC2dkDWVdJiGLZxRegS9wxDKHduVt38n29UnC9mIXCtQUb1wxq7XOZnSnEcwgIpHg8F0FjVgDm/UnWwIc6CFtDUd9ac5OeJVWTRDOunAkwtEILyaR5QfpP3ZRdBz+6zVn2WPOl+ueYav7krXImgS/u+9rr70T7VLXBuzWYp2PHE38gs5x8mOZWHjfOp3kPEFWC6qMtHxCis2/8MduOBOKT2bZpMUkdkOUmH3XNdx1uoX/sEsKPxO9uzDYoZdQdFT/608azNfSpltKWg8GD6AbJ5gIke3Qiji7Nh1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN1onI1EsUiE7aOoVqWKB0r4bIsRKNUk6+dFxjOqVLc=;
 b=eS8PEK2ewViGy2vPWFlsdvrvfAky5Ai4bVEJjDZ2vY/kTjnZymscNPyJjeVGJxUTtYqi9WPiQxsB0lLX2cpklD32Z8/Bk6H4sMjIWhRJXXeY3wGHu6Wf8UjaHmTsQZpQRJPD53xKVQtBBmM2whcjM8s5B92zKBvacjhmBiJE8iw=
Received: from MW4PR03CA0251.namprd03.prod.outlook.com (2603:10b6:303:b4::16)
 by LV0PR12MB999093.namprd12.prod.outlook.com (2603:10b6:408:32e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 06:22:25 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::90) by MW4PR03CA0251.outlook.office365.com
 (2603:10b6:303:b4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 06:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 06:22:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 01:22:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 28 Apr
 2026 23:22:21 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Apr 2026 01:22:20 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Alexander Sverdlin <alexander.sverdlin@siemens.com>, Casey Connolly
 <casey.connolly@linaro.org>, Pranav Sanwal <pranav.sanwal@amd.com>, "Raymond
 Mao" <raymondmaoca@gmail.com>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH] fdt: check fdt_pack() return value in
 fdtdec_apply_bloblist_dtos()
Date: Wed, 29 Apr 2026 08:22:08 +0200
Message-ID: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BAy+ad3Uoop7iayyHMgl6hkB21u1bo18ix3ZTXF3ixA=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+XDzN3cdS9+UWySmdxycv2i4ZZR0gbXskPWnl/Gv/H
 uizbjsh1lHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATWXWHkeGo54dCLlWvr38r
 RCY7v1130u1LtGLZUYuHy0MndUekf5vGyLBQ5EDRv/xPdrJW/Q3LAmeX872+uDdgI3vxZw+pC9I
 n0jkA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|LV0PR12MB999093:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af22ad6-8664-4f4c-0090-08dea5b7ae25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: YzdWrb7u/rkwp3Da4sMk032PTkLEKixieeVuvfAZJ2zHD0A1CE2D2SI8zmYPrwfx9TLYEgsZSfwM7YiToQoP/Y/ykG9np6r0jPwosPXOEVigcfEV4t3n8Xe7UYlkGIFToBHZuJZQPpMc4AZXk9lOwER8iDjIExj+fbsty9p2Ht70HLPabNNdpgSRt81bGi7eo++77Z0CBufdTV7/SLavBs76yGvrsimIvu+63mUWfoVwfMFCSU7TLk6oSz2EoiSRin+e5U/b4fnLC4BrllSxslM7QBjYs6/RCys1p5kbU59W5vTvz6QrRaA1OS9xxJSI69Kpcy5IgRZAzCMbVd5pmLxWNhtewpYLwnhGPI4Rjce8pWP2ScbSlZEnczRRq/aKvGSTQGD49D4FDvrnvpDfvFuvuDSRqMmyKgTURFhzFRG4mm8uOMxOzSYzlcrF5oLpSrXL/FWxzHPrDSnW1iESmOrzYDmS4CkG1JXz6U8TNQqMnpz0bHjzm6s9G+HU/u9zVGs9s2N6WFdbxyRh6SKkqUrGOhTKk4cY8Z/6p3zAaf6tVFg9XPDqbZKnkAxT5turmYNMma7Z9/LPqW8tPnTyDHhnE+GLG311t3IGssZHDNpHNLzx0nVsm85KiL7PtmlSZgvHzIeIsItj2/o9QWbjApNxUJubqMUToU52wn5lSEO/FDMhDXjY06edumBZx6af29ZGQBssHT6g7eAZH7X/NirtvCe+mfvJ1FeD9bGN3HCSTPlTP+V5zVO2GKCUVjDFpHL+zcetpACjgrhBmCjq5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hKVDujm8t94sehy1Z87XcFPvbWrFDMj/INsBsl0eQIsUCLRbP/N4X6gfqmW0E4dj2JaT64doZlP6kEQdWW0RJL6FGMWpt3G2z6xVSTCKoauDkv1grlGV6f/G2qTteCDmxDGj0D5qgqYOmNS7Q/aGBFRofr8s6K0Ebex8BAb6sdQPULjMUDJM4Ag7QwEp0o6bSVRg25zSiUQHNycAyeG9U3psZTdOyJ3G/GepfiPYKSnAQprPWVTFA1rBuTHXc6K+4iGfAHhXGi8GI/cqKSRAuFe8cG56VSrMoiSg3MQ7fQgj7oowME8VPMCu11BwNzIOUaB/yuJBZVsvhj9THkWAZ1R6/2pKLyBa21FYbFnJUx8p2AenrDlpl2sA/a6FAWZfT05DkSwcoa66nFdX/pqfUBADtasvCcKG/aZ1JuWYC51UgEwv1iZ8VU5YzZDCSN/v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 06:22:25.1046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af22ad6-8664-4f4c-0090-08dea5b7ae25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB999093
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

The fdt_pack() function can return an error code, but its return value
was not being checked. Add proper error handling to propagate any
failure.

Also fix typo in comment: "Shink" -> "Shrink".

Addresses-Coverity-ID: CID 645839: Error handling issues (CHECKED_RETURN)
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/fdtdec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index c6e13b6abefd..2d66860f6ed0 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1781,8 +1781,11 @@ static int fdtdec_apply_bloblist_dtos(void)
 	if (ret)
 		return ret;
 
-	/* Shink the blob to the actual FDT size */
-	fdt_pack(live_fdt);
+	/* Shrink the blob to the actual FDT size */
+	ret = fdt_pack(live_fdt);
+	if (ret)
+		return ret;
+
 	return bloblist_resize(BLOBLISTT_CONTROL_FDT, fdt_totalsize(live_fdt));
 }
 
-- 
2.43.0

base-commit: cffa552d648f84769f4d5d540f419173f10cb86e
branch: debian-sent3
