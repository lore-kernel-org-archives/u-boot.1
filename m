Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DA7CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 08:55:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE3D683AAC;
	Tue,  2 Sep 2025 10:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HI9f9rHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12E4383AA1; Tue,  2 Sep 2025 10:54:30 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F3882C7F
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 10:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf3fnu2hoG2InaRFEh/33VMAHWsJIy6jh5FaNGaIBxyQ5O2KL5dEHO+2tUY2VhqiV3x9HSvnDAS4R+P8LZ9z9sE7Rxe3aHtIV99SmGq4OK/tkV5YEWD42ZUKHJ7TGHhjv54EeWUaI3KAFn0ZjSyUUY9w4AI51qcht/zWNj2XAz3t6se/fk0pFFsajsZO+BxbhlEvH1Mtki29XvojF6P4EJziXf2UTXoqgOiA7hao0NLr8f9RbRS7BZdfZ5fifhqyRGpvsAgAwFfn9qoZzjhuD5wcrYKgqx4RoVFJa83EawOVvQZ6C6ofEwcBBf4B6vzHxlPy9+Tweaqt3HgosA1WCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pD1/EWdVLB8XcT3wJamADGD6KB5S4hgHQOio5Dj2+ow=;
 b=AhEOWsv9AE5jNWjOXs76jGuzQFUp/Gz9ioOADHHXBTchYcs2BZNp6+aJ4mSG+8QQ2HqNUJMOyBDrOQvmBa/0P5CFO0U+cfSwPlUhICqiMAHn/23cpMVb5p1ZuESb28ruF5hi2kxoGMSNdJFzWacitLKKTJl+4ghcVF0ytrVONqVHpQD2gtG6edRnZqYKkUxmx+J2bPWrMQlLvpp1mSWS3iO/d7kaYCleh5zqOXiK6VdlkBzHANskmWe+7tuPR5C8vSN8FDxlOoFj++r8ncNWloizf4UnKjyQUsa5RHQGPeJAeHx006D0GsTeLzHTaOMIS18QaBeRTa9KAioZNn4APw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pD1/EWdVLB8XcT3wJamADGD6KB5S4hgHQOio5Dj2+ow=;
 b=HI9f9rHs8MX0uG3rS2E7nFmmfT0ssfY/mN1iAkUzeKy2n7J7u6DsNBgrp5iUAAbZvFqpbvM7kcDJWKjQ9StXlDHi9mHQ6iXhYfV5geCB5rQiRv2+rpyvZuVlUY6h9JZp426E5SMv1c7w+xr0OrvmlF94el4P+EHyiSRz43wZPdE=
Received: from MW4PR04CA0063.namprd04.prod.outlook.com (2603:10b6:303:6b::8)
 by DM6PR12MB4465.namprd12.prod.outlook.com (2603:10b6:5:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 08:54:24 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:303:6b:cafe::af) by MW4PR04CA0063.outlook.office365.com
 (2603:10b6:303:6b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 08:54:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 08:54:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 03:54:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 2 Sep
 2025 01:54:23 -0700
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 2 Sep 2025 03:54:22 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Quanyang Wang <quanyang.wang@windriver.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/12] arm64: zynqmp: Enable PSCI 1.0
Date: Tue, 2 Sep 2025 10:53:30 +0200
Message-ID: <a3372ee9cce7fade7c9f707727e33d1cf569b607.1756803198.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1756803198.git.michal.simek@amd.com>
References: <cover.1756803198.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=569; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=BFOEyze0CXXH5bKU4JliR4z/YsrW9d7r7aXve04wbHY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRs29DT+SF5YtZGYfWD618UnJ6eKy94fre50sM57fYLp
 rMb/WWv7yhlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJZMowMvQnrzvKtWf7dsPc
 W1E2OS99u+cand+l7J/y9/PM2J8H5+Yy/Hf5u/nahWnT/7nft9BIf73m61sjw2cLFut01yv5vQz
 lnM0FAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|DM6PR12MB4465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9735589a-ee2d-4505-b975-08dde9fe5103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w8bocPVdXYBhVk4tXyjmd/jRj0vworMixHRgwJv2cu9V0fEz2a/XAwRPfg8s?=
 =?us-ascii?Q?ER5lzGe9aNJL1U31ws1Vzvnu3AW1tA3bwYS9+Gqo3DtWC6qFJQXViq4+RoW/?=
 =?us-ascii?Q?Hn/kEXqFalQKV4EVexHxy6qooSPIUFuPAnF2XjodrA8yUdAsoD8zXYqn+wyr?=
 =?us-ascii?Q?TwW3usS1REf1oTd2B/rNakz3zGbkNzi87zNBnj1HzCQIofMsGvT9xZA/2dwY?=
 =?us-ascii?Q?t3/s2phZyub2E+n3ohVLxnK60aaYikXLmGrWROXehz5CXM2ZRRVsKjfZaxWm?=
 =?us-ascii?Q?Qsg7VubZADplHs95X/NHd4Vo4wwDGMrS9K1rQUzQX5aewFqHYBgyVfZ6AVn+?=
 =?us-ascii?Q?el7H1+MW81LLfomcGmPB/K77DtJXilj6L2j2ocS1ErMSqKR6J+Q4QLQcXsIk?=
 =?us-ascii?Q?+7V7+sSLkAS+Nm9MN1zjb+o0d3N6ME3S7i+qb3s3FihQLEDsGM5YUmvFv+lF?=
 =?us-ascii?Q?0t4bfZjVu+MD0zRAI7jWzUXeEmH9yDghQGWU7J3/0O/2UAS3/eylDvqLPz25?=
 =?us-ascii?Q?sZh1j7jNosLI7E+Km8NY7glZCu522/iSFtcX1DUnl8grMVgztSPDYI4SjjfQ?=
 =?us-ascii?Q?gGBCBHql0jPZVMi3ZU+d7x8yX6z5W53lMYRhyHMTohlEOdif7kZ0+wPR2kBf?=
 =?us-ascii?Q?anlNzTTY7bkNG65C7XgUC6nh7XfsDtFSWRvPhWRojOE55Ps2v05JuIjJtUib?=
 =?us-ascii?Q?fiMmJ8/VujOyyOsmGCJ0qibda8vLh4MRY07I1qI7i9bkV6boXvVIq9E2h9/T?=
 =?us-ascii?Q?6EcNe8vpQBmhHFEZBvojUx9KaqgdUs8iEbzqvHEr0omyDN9sIa3pF6fZZy7E?=
 =?us-ascii?Q?1sIZqJGl+FQI3/VZb2WreHqwovUwP6CGzf0Itzw1bFDOIJ3zeqRDGrifFazD?=
 =?us-ascii?Q?bZKUhrWs6/5AeDo/tFfzzY3oRvUMSNJ39Tg1mZa7iK0rWz92IdHm4HPcDCqk?=
 =?us-ascii?Q?C8uv1Cu75yhhJkIG6dql/16wfWEvWE8uKp5YhT82NtWjDVsht4XXgGMPUv3P?=
 =?us-ascii?Q?1t259nTy/nv+HcxXifpj/L0b2oaJN1yyztrislsSS3t8HarfS4mtQ0mb2deO?=
 =?us-ascii?Q?IoGPEdeBM/0ZQanglmBcBkndtKvSC29kSliQOz9M34VlmFfWoQ2lmdCI1E14?=
 =?us-ascii?Q?qnReY4zWGHxFxshUjBl8MH1dZ1Z7hSak3S1zGhpNhUdSApx6rlgLY8VuwRoO?=
 =?us-ascii?Q?inZ87dxQRFb+d/LiYQWHvLxxCHprlBGQH2XMyPj4xGqZv2K7/wXhJDIMBP9X?=
 =?us-ascii?Q?nWK/72UwyrJiUZPFyjT7BH/zrxuG6yoOljKLbn1mLB26Tel9coLHLT0TJAsv?=
 =?us-ascii?Q?i0kCCeJ43iJZCtPpVnBLQ3/KSxpnbNdb/PmoTzNzePpH4yJQooIFLwxUGcbP?=
 =?us-ascii?Q?8QzlNqIIBHbnWEoBBxKZfX5aQDniOm5FK7AzE0NzzRgY7ieEVQIf95UA3I7N?=
 =?us-ascii?Q?rNwTBzH4cozrayAexNC23I3/Gb4SGHhg1Rrm0P9QZYoUumXJEaES6vMV8oxZ?=
 =?us-ascii?Q?8HVxGLvdiTPoF1ezt9pjt9i+lC4Fs+kesxck?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:54:24.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9735589a-ee2d-4505-b975-08dde9fe5103
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4465
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

TF-A is using PSCI 1.0 version for quite a long time but it was never
reflected in DT.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/dts/zynqmp.dtsi b/arch/arm/dts/zynqmp.dtsi
index 9f3404ee8b42..27bbb9230fe7 100644
--- a/arch/arm/dts/zynqmp.dtsi
+++ b/arch/arm/dts/zynqmp.dtsi
@@ -187,7 +187,7 @@
 	};
 
 	psci {
-		compatible = "arm,psci-0.2";
+		compatible = "arm,psci-1.0", "arm,psci-0.2";
 		method = "smc";
 	};
 
-- 
2.43.0

