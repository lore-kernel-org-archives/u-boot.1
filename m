Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CC8C47BC5
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 07:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A08183A57;
	Tue,  6 Jan 2026 08:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6EvNSEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF4783D9F; Tue,  6 Jan 2026 08:46:01 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD4B839F1
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 08:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKYwo5BEDGD85K5jT6ufHG/0+srZg5SD7je0Ac5fRn6pO003bbcuyxdgPuHP+RvIHFruuymClNLZClniMBVliFjq7dEVkYr9ClnCp254oxI0f28uhugEYBrIbkZOPyF7old20LABb+Bg3NB+7dkFGEdyUcbOLR0fzSn7HtmOXN++Q3r+Odq0sQNAZeg+Cx6uaIJH7d+0RWtq8w0VYCwTfGXogjDwixr7+hfYaXpvf6wz+DWu/lK79hvkkyRHRYYCmrv+PkJHfVJjrzaN7e6v3qXrO5eJi+u4j1Ymzhf5d4RuTSKzOW5XyxzkaRN/jZNjHd0vKImQ8EdsNNqnVALURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4HGS2qZEulBdSafkXKqxCnWlofWOxs10p/NMHzr2ac=;
 b=mMItgoOnkWzghkdge5srXMZsR9zt2rSGmR2OLMDehLDxiYz/7rlA3r135HiwUmeUGd637Q2SXpRGoJ46/HQ831EM8icCuql5zJD/0kgMj37aNUu0PNBasctkvTnis7vlkKz0O1gWYpdelD2m60Y8P+tUyxXFgt26UqF4ShThEFnVwqHvpAol2+Mpr20hEE7XGqUOXawwjrIO5jKvjaO2Pocnan7Vab8p3+OHFYVPaITa6JOMIHeu90ptl7Yw91UHAQFHvwwlBOcMWzvkXoOqGkpqF2nPxVcFGDvJ26j0QUN9P883lnI9OeTaKxY0DSuAPP+DzduFSL5otYWstriXjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4HGS2qZEulBdSafkXKqxCnWlofWOxs10p/NMHzr2ac=;
 b=y6EvNSEHY7dEYHcPldJirPmXMfDCWwrel6Ry9kjPjjXZYMoFQJ0FIBPEUTvJYPkzCg9blqeWf/EABBN00yPG1t7kgD8+V2FcksV8cKrne3FnkV1iAr9SWcyZ8ky36S/G3RaXkyIMKXjlfOtGsxHXYS91fWmxJoVgjobAzRK1bDw=
Received: from CH3P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::28)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 07:45:54 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::db) by CH3P221CA0027.outlook.office365.com
 (2603:10b6:610:1e7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 07:45:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Tue, 6 Jan 2026 07:45:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 01:45:51 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 6 Jan 2026 01:45:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] amd: versal2: Align distro boot variables with default memory
 map
Date: Tue, 6 Jan 2026 08:45:39 +0100
Message-ID: <988a6f38ed9cfbb9757b76a16cb9cfec4601de85.1767685538.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1228; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=pex+ySn8a18ksNDy0GUpsqPw8k12chx4W8T0IQPORxM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTG7F2y7+znjHtL5oi6N+2q//Rc9cqkxGOp78o1yr44T
 p96+uqVrx2lLAxiHAyyYoos05l0HNZ8u7ZUbHlkPswcViaQIQxcnAJwk98wMlzadefVjMQdMptt
 PA/xZjOauXJuj/b4ksb2dPoy7vjLtv8Y/sqfWThfaraByKw0fdMfff1TepemJD9mfTJ9J3NtwvX
 1SawA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dbeab4f-f4e1-4888-0969-08de4cf79f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MO7vWFOVdKPK2TGEJuAXV83iT6Qfzih7PKLKKGNR+By3PQzm9F/xiwZrRaC7?=
 =?us-ascii?Q?0/b+BeKsdsJVOd0LBY8pnHZaM4uI5Kl9Nt+JbjX6FK7UA9/tRCEjyTThIN8r?=
 =?us-ascii?Q?38DisNdKz/Cl7qF0CpBvA8Y/IQDSMMcKK1yB2d0N/IEatX1NV15XASeINB2P?=
 =?us-ascii?Q?ISx2AUZpmalqM4Yk4RL4gZe2/jMKyh9l1F2ttsVtzzyZUXJzJqTMQ4FIS4Tj?=
 =?us-ascii?Q?MWelWZS6/nDoc2IY4J1urpytgnNnzFBvWtRVEIT4lMLDmO29pghm2O6Mi+Ev?=
 =?us-ascii?Q?q3Do2QhmpcpPKbQY3eym9AJ3m/X/UIKN85opZx9qS3EV+NXq0DHpy7GA6uMS?=
 =?us-ascii?Q?F9J2ZDo41u3wbG0pLh4v11RPY/r2/BaxD0y+yDiknNcfCbxfC81PybtNWh9v?=
 =?us-ascii?Q?rtRccp5eJ/wLzJBN2p6DVU33ssxnQR0B3/UkDN6+B6XfTNxC8nKtLB1WnuTo?=
 =?us-ascii?Q?hXBdIgGJ1THJZ5IpI9qoVntbJ3JRlOOjbvp/Bu0m3ol7JVUa0p53RRmXklrF?=
 =?us-ascii?Q?SUzOgPiMfl4a8je3ZGXbKbwYXrbt9B1yiirrXBA8TLQN59xLY+9NUUYi8LnA?=
 =?us-ascii?Q?909G3xSx97swfl0J9DlcdXCCYLuA9yLQYGOy8JNCL3VSyDFgltdorjxMz4tN?=
 =?us-ascii?Q?+OcVysq2845cQoow9u5iixV9R4iOZAjxEfjjSeut6RscjNt0/inipYppBSkp?=
 =?us-ascii?Q?Zxe/eUJ467Z8kj8YJrlqdzp0Jcw+GBcR2LRKLIAA1UYAKHc6tb8p98tbwwCX?=
 =?us-ascii?Q?HvApbUy6FehTOOlpa36jFlbcDiSSLBakCMDvnxDpPBbTXz0dxD/bNVPsiTTA?=
 =?us-ascii?Q?fRCVBvfJFNqc7BqCBPuGv+H8EEU2RXZugwH/vb0BqQ8mlXfrFLkJ73OTV1Y4?=
 =?us-ascii?Q?UeeTCePeAQMftb5pyeP8Bn5B3PKKtU9PNdL780FN1xMvB7x4rMtB9i0oHVtF?=
 =?us-ascii?Q?BTRxmi0uoWyx951A328ijUmPiwgjz8DS+uyvrSvdU4m8By5yL6R3CMdL2Pi5?=
 =?us-ascii?Q?iJZYi3FBomem0lG7XaHbtRRVNg/rnESjNd125nAi3bLhw0IErd2Hpwnq9pxC?=
 =?us-ascii?Q?LWMhgOVs4pJ/iVkRNANw5mOhCVdec+E4gVNM5XBQtaeIXKEIDhAotHPgZEZe?=
 =?us-ascii?Q?eHFVT91yCI2PFrN0Y5BC5rTrkUMcUVsUOA6/2BaLLW5uSWs426soSNE93lvo?=
 =?us-ascii?Q?gM/qRVJ6m9FBo0J5sS9TbXM7Qgv4mS7sX/pdTY/HSmeAjUq4HEjkBkBrAZsn?=
 =?us-ascii?Q?EW5o9nKJPKkfNmntKhWLXYxIk2dqJBXf7WI4ZWt5zD4s527/uaxDXIBN1mXX?=
 =?us-ascii?Q?9k59O5ta+20wQp07tyjjdeGiXqOu/qRZOXA/xZ7Nl6GbKTLqHHHqUB+nJI4W?=
 =?us-ascii?Q?hjqQdyrG3KlzuKeWu0hU68kTQPoN/XgaxJVYt9ezUaSmNJ1M7JYuWJqqcVtH?=
 =?us-ascii?Q?yH9S+1nHnlrCi4fxgoCr0weC+sJz/BP/jxUBZ7GHHE7zbRHRSt7XzdlZZAYU?=
 =?us-ascii?Q?91ybknIYFXe13fn92EbG35wT+ZRhvFiG2P/J9wuHrBzgUuwxA1qhpHaTvW2p?=
 =?us-ascii?Q?HGNM8so6sHbw0Ijlkqs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 07:45:54.1434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dbeab4f-f4e1-4888-0969-08de4cf79f09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
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

By default Versal Gen 2 is using memory map where TF-A is placed to DDR and
there is also some space allocated for OP-TEE that's why move default
variable setting out of this location to avoid using it when distro boot is
used for booting.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 include/configs/amd_versal2.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/configs/amd_versal2.h b/include/configs/amd_versal2.h
index f1c432aa391a..05ddd4eabe16 100644
--- a/include/configs/amd_versal2.h
+++ b/include/configs/amd_versal2.h
@@ -49,12 +49,12 @@
 #define ENV_MEM_LAYOUT_SETTINGS \
 	"fdt_addr_r=0x40000000\0" \
 	"fdt_size_r=0x400000\0" \
-	"pxefile_addr_r=0x10000000\0" \
-	"kernel_addr_r=0x18000000\0" \
+	"pxefile_addr_r=0x70000000\0" \
+	"kernel_addr_r=0x48000000\0" \
 	"kernel_size_r=0x10000000\0" \
-	"kernel_comp_addr_r=0x30000000\0" \
+	"kernel_comp_addr_r=0x50000000\0" \
 	"kernel_comp_size=0x3C00000\0" \
-	"ramdisk_addr_r=0x02100000\0" \
+	"ramdisk_addr_r=0x60000000\0" \
 	"script_size_f=0x80000\0"
 
 #if defined(CONFIG_DISTRO_DEFAULTS)
-- 
2.43.0

base-commit: e9c8a3d3b3dd1f34c0fab409c7d4d2119db81414
branch: debian-sent3
