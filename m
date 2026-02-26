Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2150F5544F
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 05:48:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D23E83E85;
	Thu, 26 Feb 2026 06:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="huZF7EpP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 075CA83E63; Thu, 26 Feb 2026 06:48:25 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF05A83C54
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 06:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4l0mRNsSSqxdtOuvEPS7f83N+I3Fwu2wPNaLEK/OuMa29BqXLLvOb7RV1aS0byZJuRNPNnDmVjyRLKIt9ic/u7jNfefpSnh1Vhnx1VU/krdrAuczSl31uMU3HR/PoorC0eMGK0CR54+3Xccv/xHtDfQOr7AFvjY+NUgiYY3JEaisNiY469SOPlvil41obdeu0Vi7kGKWlZm8tUfh9Ckdn+m/eoQIVmRQ2139LDzXoD1NTLc1GUzh2tTIiuoZ/7YQNFyJBFNJwZ2G5hKWOahwmyGF9VPei8NBoHwTBIHI1LOXadyOY/dRkNtXYdB8LZTzmYLdtUcGeCE1DwAkpMEUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nijym2+KKRA+SyF+X3yTJmzNFO8Isxfe6RJtMz8i+ck=;
 b=s71unv2iShQI2c9QKC34kcHlxYdsp8a3gFDyXsHpyJwSmL8dMrfraUDkZYJAbPGLqT0sojrbw15ZJQhgOjMO+W8q+CfwO/LcFdW4mB01RFYFzJBxuu7JdX3Ki86Mspf1G6wLuuOX3a+5aWF54qu0o1MsTC3JTHRfwa+WtXmmOTlTW/0c38SwgY3AHEhNGhL73jwEjJA/T8nCKkthJcfk0h7WrlKN/CdQUvT50hFzsdwG56/PB4UnDpNHA0JdZvSIlhsq0zwd6EFSJIXPdW1vusnK9OkHYgRPtZ5G0+bckMiIN3yckMUvFW3XrXsWd+LRsiXFFI2Lu9KcAdxxxtU7eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nijym2+KKRA+SyF+X3yTJmzNFO8Isxfe6RJtMz8i+ck=;
 b=huZF7EpPCT4hCfhk4vL/0vlzTENgImKgBqCzcBQYeqcOStUpsuqJVremhbw1k4IzXimVFsU2/tc2bTcvGtMh/s/yThsUVr/kLuQwygqshRuxirReqpkC8FvRc7AeiUcK9gMVO4dnHfN/7D3rW3lV9YPhyINaFksInYc2kL525BE=
Received: from MW4PR02CA0019.namprd02.prod.outlook.com (2603:10b6:303:16d::23)
 by DS0PR10MB6996.namprd10.prod.outlook.com (2603:10b6:8:152::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 05:48:18 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::bd) by MW4PR02CA0019.outlook.office365.com
 (2603:10b6:303:16d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 05:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 05:48:18 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:17 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 23:48:17 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Feb 2026 23:48:17 -0600
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61Q5mGhv1311006;
 Wed, 25 Feb 2026 23:48:16 -0600
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 26 Feb 2026 11:18:12 +0530
Subject: [PATCH 1/4] misc: k3_fuse: Fix printing of error codes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-k3_fuse_fixes-v1-1-86c81c298bc5@ti.com>
References: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
In-Reply-To: <20260226-k3_fuse_fixes-v1-0-86c81c298bc5@ti.com>
To: Harsha Vardhan V M <h-vm@ti.com>, Bryan Brattlof <bb@ti.com>,
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772084893; l=1269;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=5/wCwqpfFaMaJoekKddfhUwx3SeF5l3gf0yk/1+K1QA=;
 b=PV33acyRW9T3L7nKQ1dWFVMm81XNR64+uUWVZmbgVxED+Ovpf/cGwBIaFUjLcgyZXnHYyWjnL
 zHv62tda2BxAFc80RxjdUQqiGxDBr1w4ZqkKkf1WtgqchsMPEkrE03q
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS0PR10MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: baaf1d9b-4fe9-4351-c23a-08de74faa4aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|34020700016; 
X-Microsoft-Antispam-Message-Info: XG0TnoQsViTNh5KCKKqG0O3hYYc6cBjnuTi75Dfo3wZVP0h+IL0GuzF8zor3sbEgdgABQF081ErTlZNgyxH7PIt3cNdmrQ/ITIEvw20H5j9op1/DyXafZhaY8/hP39vVYOKjPHSDwXz1h5QXpsc0vLWL8QlGhtCQSxVkonnr2GSehq9T2Y+ehARMq8qH0+mkRr53RC7uIEmrCYoth89dq61btZKlbysPIGjdpUhLBUIo0FWx7IyjmgN+rSUrI3OoaFjCoJfjjzyzFNIsvgM7zPBWLhZkzcAujCw0khuh6PoGdJgA226Xr/YChkrcN6p8C0YCmTKS6AW2yyTRodKq2BtgoKC8LWRK5dpE3JfPqRSkwuo7mAdNp/THw7aZXnuBMJ29spXwIanFZpQO0YrgA/AscYJuOY/G7EbKLqYkRIcBPxbHM8jbXeEsde7y5FjZH64CbmT4mJKeelVWkYmOsiTHP/GQ+qJMqrICB+Apu61hRz4YLPHLrjrFZu7oM9ZKZSQ3u+Vkk8/eyUKIB/qd4bN58joMjENSQm8+UmyxdwG8kMDjAco6xXvdDaZ9i7EWDESYx5ve8YSt0fg9uc/0DQOZkQXN4LLU86BxMzV+RstlaAxNSCTk9vlYhaOHAYUHkbFTQ3fl7mshfsvEF07xh/xlPXeJ9P5qUm8A/vkhccRy19nMH/LDwao2G180m5ykUA8vh08RTr9NcEpko4SK51xMJ6KyKs0AnPo9+ydSXaAeiqyQwJQb4cWihTxPRS3rVG1Or77JzZ1V5ZYf4qSMvb3Knecb7t8/KLrKX4TChyJXHp7zCaDWdqk4vhVmrAoOFlvZ95ZDOmWL28EmEw0gPw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(34020700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AzQ/FuDrpOiNEPLBN66PWXpgtxZeKtB5ocV3hFU7eKGW3ThaO1KzIQmvdUqwnog4AiZxRULsW0MADY8/QMrt4YKWTca3Y+HFzigo19ha4ApGLPDbcgxwt8P96M+DZBkoMzcIFq9e6Rgl38YbMIyumO+UlJ+GdMWcJH2oEheWU6pUs6wSUla6jhtPEfdb1XuaFPAUmnD+2po2WecVOdjrZXii4rGbAcS7AuLWRAWq5f2Zfr0ARXy8lqVspwNQmpXDTYCjXFfIW3gQHlfR/UEntWEzfWHu5MCw9dGrr58cY+dmOV73nBCPiQtSo2uS/g8JW94nVCg2//yIT4sQLbJPec1mUGotd2CIeU4/7rypAigcIOSoI19oK6HCtdJKkPYpYm41tGCbyfixKfZyczxRcIFHs2elb2s5K0u62UhRo7bMeMdTRQVk8FXDltiaRTlj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 05:48:18.5105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baaf1d9b-4fe9-4351-c23a-08de74faa4aa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6996
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

From: Vignesh Raghavendra <vigneshr@ti.com>

Use signed int format to print error codes so that its more readable

Fixes: ed5f2e5bed91 ("drivers: k3_fuse: Add fuse sub-system func calls")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 drivers/misc/k3_fuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/k3_fuse.c b/drivers/misc/k3_fuse.c
index 4a8ff1f2523..cefdedaf411 100644
--- a/drivers/misc/k3_fuse.c
+++ b/drivers/misc/k3_fuse.c
@@ -28,7 +28,7 @@ int fuse_read(u32 bank, u32 word, u32 *val)
 
 	*val = res.a1;
 	if (res.a0 != 0)
-		printf("SMC call failed: Error code %lu\n", res.a0);
+		printf("SMC call failed: Error code %ld\n", res.a0);
 
 	return res.a0;
 }
@@ -53,7 +53,7 @@ int fuse_prog(u32 bank, u32 word, u32 val)
 		      val, mask, 0, 0, 0, 0, &res);
 
 	if (res.a0 != 0)
-		printf("SMC call failed: Error code %lu\n", res.a0);
+		printf("SMC call failed: Error code %ld\n", res.a0);
 
 	return res.a0;
 }
@@ -72,7 +72,7 @@ int fuse_writebuff(ulong addr)
 		      0, 0, 0, 0, 0, 0, &res);
 
 	if (res.a0 != 0)
-		printf("SMC call failed: Error code %lu\n", res.a0);
+		printf("SMC call failed: Error code %ld\n", res.a0);
 
 	return res.a0;
 }

-- 
2.52.0

