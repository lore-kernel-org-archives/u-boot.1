Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE8EEE645C
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 13:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E1C286583;
	Fri, 15 Sep 2023 15:59:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FoeszvtQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A000C86571; Fri, 15 Sep 2023 15:59:11 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::628])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6262786583
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 15:59:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjXsEmuQa49W00ABcP67lQOeWSS4IXNUl7STq2jC+2/EDaKy+PtuQgESiiNZSHXjkGwWvYt2gcb6NLw1WpqOCuu7W/SFgH62i73we9bZjGzzm8gGMbCo4F2qpYkv5GHFfSvkCud8G1QQe8leq7q5VjhhrHclECsDJZhL8+qCKM3n0YUvszDL64Hsqixmj2WEB6u/GOl5UdwXxw+ocm+hlzTnzDtS8mfuzIGVwad00TGdkyAf0+VoIpV+KJm0L2QWgqRSEoWBcQNAFZepBsTC9PKTAUkw2IAelR1loIagoF7gQ/aNFPzdYTLeLr/W/NeXG9lmhC7v6b1KQq+UzmXY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmTi/PrsyFJJHonBo6k2SzeL12cCCuGoUdEddsewsH0=;
 b=XjkObWCvDmmgdHEncq2m+eZbsJVCJk/FZ0qcVidA8mmhfpmeyPQ2y3rRBLb+UP1TRsCKds+xDlFoVj4nvSZa/jl1JIBEjKRzTMgAJS40jJ399gQO/FsWESOLx5fB1egbqyNdJdZtXrCD/YT+ihXWzAnDBdC9pFIKgF70ZL3E/4F/tpNsIwt8DHFD+2laRt1xqkk01e/kZ3JOgGlPzm7tmL36aw66Tv3+FBPDumJjayqjGp8xJd7cTEMzpHQI/jQF3fpJ9hYLS+NRPklceJxtppyfa3gLzDMIz0G+4SYImIbD6mqXTlJkaiPTZ8x/vTwPJccAKjbr/lWKUQ8MZ/GatA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmTi/PrsyFJJHonBo6k2SzeL12cCCuGoUdEddsewsH0=;
 b=FoeszvtQYYjZNuauC0fJeWC6LntoEDjC+hJyBHeh5drMcScFOXz1MKvYnSouHVXPkvrVCzH/ezlkyAts9CWnL2f0PsTPIMJOQ5EeGQPRZTIJtxxjfvveB3w/6LZ9e7e81zqJ+SFzqLHyok9po0e+lTa3B4Fyt4eN8JtfZoGo+eA=
Received: from BL1PR13CA0087.namprd13.prod.outlook.com (2603:10b6:208:2b8::32)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 15 Sep
 2023 13:59:05 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e7) by BL1PR13CA0087.outlook.office365.com
 (2603:10b6:208:2b8::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 13:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 13:59:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 08:59:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>
Subject: [PATCH] net: eth-uclass: Setup ROM source only when ROM reading passes
Date: Fri, 15 Sep 2023 15:59:01 +0200
Message-ID: <a4f5d4780be93819a7d3dae5915af5b3503c4f28.1694786338.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=HPCz43CJU+pVBj1jGHvfTRLV6LYLS7E23bu3Z8nyW+E=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSWZOWrvfPKvtk3nanWaNgkycF70on90hXLv+wn98W7C
 /WkCN/oiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABN5oMUwh1d0/8ZV2ifYlT9W
 OWo0qm1l+aWbwzC/SP6zeXn51d5bu2cxXHfm+N35e0MBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 05194911-ef9d-4668-3c49-08dbb5f3ebe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qWS1xgcdWKQTosT0MRPaWlKkjbhe4lsL6qq3KySbDFxjNSpp5I/w0/uOEV+12Mn0vN7AbZO9FElVl8WVa8HX/hNdOjFEAPbRHMHbBqbCkr6qnjDFutVuTvxdxJWDZZKriu/AmVUt2/EFWW5aPeMe89yNUhMdYfCEijLpM6aD4D/IE5lgtQnIA2jxvvhSomKCKHlYeUqI/zin2jT6L1AYu0NS5LELthX2F1X4SEUOlHyIy7Q9HoLysdSpqxg58Bs8k1ATmKiGewvC7T7BYD8Lz8etoULA7otWiN2ubJ3atrdSMl1LU/6HyJJb8gXw7zb4YzXQfHRmg8QngaQyUpFfMNC5eo1Xt7pUO3jFkren9Uj/cs7YHeeH+Xgzm4GFm0u9jphExiHHrhWKuI2KCc9A+xBbBmRKJDC26blWvC/2ITC0LwheYIvXTrVIyfpRYa4lJ60zDLg7LzCCJGd64FiAQbC9eoLnNBUU1BDG1PetirMjwT5PZOqWJVKkZBWhtWdyet5RFkSuq6OL1mO17U3l9VDVXsEDpOX28Nezn3+boG381vVgVHA/ZQF8yGb9vgRk2+94//g08+tpSK/gRXRbkI7bW5tqewtBYqNiH9qoyVvpMFJQ8g1z8SUVoD+NIVEy4UAqDZCkRItpnGzSCxYoFWDsCjrtX/SIsdSs3BLeSO5o/qMzKFo47Uq0V8oR2wXeH/un06JOuUyemlX4s0LvPVOwrKs5FebCoCLaFMTZaosohZcq0/nTw5GkR0kJQhp/ogRE0KwDbi6wzUG1Xk7/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(8936002)(47076005)(8676002)(83380400001)(5660300002)(336012)(36860700001)(316002)(26005)(478600001)(70206006)(54906003)(70586007)(110136005)(16526019)(426003)(2616005)(40460700003)(81166007)(36756003)(356005)(4326008)(82740400003)(86362001)(2906002)(44832011)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 13:59:04.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05194911-ef9d-4668-3c49-08dbb5f3ebe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643
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

There is no reason to setup ROM source if read_rom_hwaddr hook doesn't
exist or reading mac address fails. It is ending up with confusion about
mac address source.

It is nicely visible if you put mac address to DT as
local-mac-address = [ff ff ff ff ff ff];
but also save ethaddr to variables
setenv -f ethaddr 02:18:31:7e:3e:01

Before this patch U-Boot prints that source is DT
Address in ROM is		ff:ff:ff:ff:ff:ff
Address in environment is	02:18:31:7e:3e:01

After that source is DT:
Address in DT is		ff:ff:ff:ff:ff:ff
Address in environment is	02:18:31:7e:3e:01

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 net/eth-uclass.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/eth-uclass.c b/net/eth-uclass.c
index c393600fabcd..e40b869e1c31 100644
--- a/net/eth-uclass.c
+++ b/net/eth-uclass.c
@@ -588,10 +588,14 @@ static int eth_post_probe(struct udevice *dev)
 	/* Check if the device has a valid MAC address in device tree */
 	if (!eth_dev_get_mac_address(dev, pdata->enetaddr) ||
 	    !is_valid_ethaddr(pdata->enetaddr)) {
-		source = "ROM";
 		/* Check if the device has a MAC address in ROM */
-		if (eth_get_ops(dev)->read_rom_hwaddr)
-			eth_get_ops(dev)->read_rom_hwaddr(dev);
+		if (eth_get_ops(dev)->read_rom_hwaddr) {
+			int ret;
+
+			ret = eth_get_ops(dev)->read_rom_hwaddr(dev);
+			if (!ret)
+				source = "ROM";
+		}
 	}
 
 	eth_env_get_enetaddr_by_index("eth", dev_seq(dev), env_enetaddr);
-- 
2.36.1

