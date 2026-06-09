Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CABCD8CAC
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 07:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA788490B;
	Tue,  9 Jun 2026 09:49:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o8TwE1Su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0520A8486D; Tue,  9 Jun 2026 09:49:24 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A87C5848B0
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 09:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/6BBFVQMjK7wZti0mqhmOwUlSBeFdx6i2NT8K6PeEDFKhQClMzJUpqIYwh0vRwwJBaybrKoa8xznqhDhhmtApqiYCoVmSZPwBK6LQs2iXXkCrXNbkaVFax6UkAbOqz/h7l8CmN3wwYgEsOIxHK+0/xJxgVEQuu69s7I4LGpPUNBvh7ODMrvlPgiWW31UQJrmWla2jqT1VncrHDGWa19e5jFMLYQz0f5vYtOd/GN94e6jRGSwCyqOsSNA7Hrl9wBlgGz3vtkcBefZDqaiWMVl9mxqhFHb9Vw7a9ShgCrBll+Dy8sZS6MnezWxTWsrwaZxoRnH5pfbcuLos7DJ1fXjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKVtPEJ0gfvPT9CphB4xpujSjZwXVcQNK1wJjzyQBXs=;
 b=BFlg9glViDx6nn44PWf6gYwdlzIqJGNmBdzc/JCCFXay8Q485/s1jo1t1cqe6tpWaxN7fY6VdxrgV10GM3yjJ1p+9J86cU/n4YlFzXPO6eIKUpKENnBMzzPB7+b31hLPhLte7W74sbenShjwYAVcuUByUOhARVS7SO/C4zf5PyN3rtSWWmiG17LFPfNOGOO9JLiRElXY0VKaFtVj7i2pO/UiW0v0ExcHpyLWY5FagPIdRoocrjA+uwyXgfJmsDGXMeeTVpYyLpz0LdwLQXm+I+1AWGuMFUNkvSeGMLMtuIVBkONDInCT8N10jxQyzNVLDLdwlYLbMIl4vV194yRCvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKVtPEJ0gfvPT9CphB4xpujSjZwXVcQNK1wJjzyQBXs=;
 b=o8TwE1SuTFHrJX7FpNEHLAVl2uZlMs+tUx5FwuXwKDWMWxLdubLR4OgRbpzx62hVChUK3cugFG5Uu+dUhvb++8m/OAd3XSJ40POpwvXD4DZKrVXUB5gGI/nXWWoaULsMi/gx6SJh6y5O6GVv6e7DrOZXA8q3tzwmZYJOXi5jOOc=
Received: from MW3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:303:2b::25)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 07:49:17 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::94) by MW3PR05CA0020.outlook.office365.com
 (2603:10b6:303:2b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 07:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 07:49:16 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 02:49:11 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Tue, 9 Jun 2026 02:49:10 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, Shaikh Mohammed Suhan <suhan.sm@amd.com>, "Tom
 Rini" <trini@konsulko.com>
Subject: [PATCH 7/9] arm64: zynqmp: dts: Fix file descriptions to match actual
 filenames
Date: Tue, 9 Jun 2026 09:48:21 +0200
Message-ID: <456e4ff541c60355aa3d35627ec481263113349e.1780991287.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780991287.git.michal.simek@amd.com>
References: <cover.1780991287.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=xeSk9OevqL+pD7IgroMquzQWJ56+Pm57t8TdMZfhkEw=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWSpH/VIaS9fx8XAeOuG8xyd4+4Od1rbti1hrPi8rtWGM
 5Grc//xjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZhImTEjw/9HP/ndvomc4ubR
 CAjc0PLGT3aG8PEVW67vuDU1puWPQzIjw6X/U0q2GGte7dILUM02OSatvTE7L2L7aesXM/V27F3
 0jhUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: ff4aeb1b-0d6a-4084-427b-08dec5fb9b1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: aEYcUfazr9yXWAqN5KktbmeWaMm8qAc0K4XxMxNokhKORYtixAbYhJWE2kNCKzpiiHSPSYOhAm8ee57OHh6+ymuQDULZ2s7hC8143Bp5YpfvpAsDhptqW4dN+soTA8r6+pVF9L3uTq7kLGiwU2z+lGOy6d7hxxK3kr4Nj8/iy7gO2wIc9/2Mqdpo/QXS6KtzIqEaSOF2bAun2vd/L4lUVeBjIPrqUBYc+s7Wvbck7bSbtaAfCsXAzoT/MBjJcVxyXrcEJAqCwewAKT7fyg0pbCUT1XOeFn1cdYyq2UF4v7xsiCya0S97LgqUYTvdYeRck0AtK/4oLliWHGcmoH2N/Tqe/NWiQzqnsnOPX/5HDH4vBGgZVeJDViWF/nVZachKOwRgbeio8MMvA6rHtAa2AceZwo4BysbXLgaBxOctBqti4Z+Khm5hbHP/VhUxfMLPqAREBibPglVKgMLxp6dExd6Pgff8QaQ940VQ1V9juzibG/Sac3CEScqWgvywGBM04Dm0EEtvoljUF0bVxFdK23lVR5P+aGvFueCh0pHLZCcSOH5GRaJ7xXEys4vPfFBP4tbrrauNNmNBoUhcCoJA7DBiCjhrwnSBciCO9o3QZOAuDqyqo2Sh40JA3iUJC8Ih9l2WAi4ECpBAnemVUj3J7yVaBD8AZwoZJx6+dww3CfWmFt8fSDmgoqA7WMUAzHVR0yfN9a4ckR4SgSAyPlXK9edshbNKZNSe4gSWR4Gz1AU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKancySV96UUo13QuQU1wpltmi0tKXqKhrl6DmCc8uKexrY9uxWRpN/sBN5cX/IG2s5Qy8RDC/m0BIIS0EPIakekQbMgivcE1LoxxlE0OBjUd5NdTMfB8GerXUFJsyaPsjoewu/mEozCJ1oK7TDdTabck7mERQS5Cc/4zmYpQN34UX/2X5i8ENXrdjGH4Ip5q2EipAZHVCBDjM4Ro/1F6o8hbxmyHGydLBXX6sfPi6OuloBFTjBkn+f0eo9juVxNeJcqpjm2MGxmlNrgSAYEN1sU7+ebQx8CWHuZOdylmWpP8BvJVSt7MQjKOolQB8SvaZAFcHLQeRE6e85CpC4hNow6uu9foATYYeexCcT+zG+PpIa7lbys3bn6C5AA1zN+S3jY6PuBuuZg0zTI9oE9gYqH44aLTMCv0ZgWsEsAQ+h/p1rQCcKLw39BU3/O5otY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 07:49:16.1956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4aeb1b-0d6a-4084-427b-08dec5fb9b1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
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

Fix descriptions that don't match their filenames:
- zynqmp-sc-vpk180-revB.dtso: described as revA instead of revB
- zynqmp-sck-kv-g-revB.dtso: described as revA instead of revB

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-vpk180-revB.dtso | 2 +-
 arch/arm/dts/zynqmp-sck-kv-g-revB.dtso  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
index 74e1c5c6dc94..6a5ada34ed71 100644
--- a/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
+++ b/arch/arm/dts/zynqmp-sc-vpk180-revB.dtso
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dts file for Xilinx ZynqMP VPK180 revA
+ * dts file for Xilinx ZynqMP VPK180 revB
  *
  * (C) Copyright 2021 - 2022, Xilinx, Inc.
  * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.
diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
index a60bd7b7bdb2..0fa5a990adc8 100644
--- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * dts file for KV260 revA Carrier Card
+ * dts file for KV260 revB Carrier Card
  *
  * (C) Copyright 2020 - 2022, Xilinx, Inc.
  * (C) Copyright 2022 - 2025, Advanced Micro Devices, Inc.
-- 
2.43.0

