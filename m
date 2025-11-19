Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A2CCF31AD
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 11:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21C0083DA6;
	Wed, 19 Nov 2025 12:33:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YWqm8Ajy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0189F83DEB; Wed, 19 Nov 2025 12:33:05 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A28558397A
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 12:33:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1XerqhFxbUex5Yjb5xNyWINqtRPz2DxBL9cgLhSYzi5erqfIzh842Wck2u1PfSr/stJWAAzYjIwShS6feyd8k97rPY6BocGz4VM9FvCeyfw0mBmlnsl60kmqefTWh4ypu9mcHyYaFgUWfsXmQPYGeVrDvntqP14wtcHs5hhsaZhT/2ugURzBJWAMX8bSqUL8q5YWHvEpsD9nfsoX1g9sHTaXmpgEqzmjfrnQj7sAGI03n6DdbJ3Legqk6Cqj005ryvOUCVvIT5LaQUi137idlvCRw92WB3eTdlD997IuWMG+QJDXwz50h05Yrbir/ynHHNY5he4HJBr3IV20sCOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBgq4EH0rtiZQqaxN5GNuuBiW+rFZo0ZW+G89NkCmtY=;
 b=cBks8Xmgsz8fn/TuP/whDtBKeZjDYXmRzQSIoOhjR8Fv/OexoRQB3xmgDszWNnzzCqoLcv3YFPeL3ZrZBeZhoExUXhNUELyRXxmxzuCIbM0pc+j74KUJiaWiNhUCQ1ZXU/5ma52RafxTm1xrcLCWuyAczu8nBtHWTxBtSOQRivJ59qskTh6NPVrJ8CR4tNxitHLnJgIYMjC9LsYUUjPOhgnUOyJr5OGBjwF+mnZJcWIb3Ufz4Hy7HcdCbZzrzkiulId/3CWsy7YtnnTEDCo4CXlAEhoBbqSfAGsy/7FEFVhZkqKrcuEiWAqA7kovv/X6twmKVwNmhUg1Ddip/pBZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBgq4EH0rtiZQqaxN5GNuuBiW+rFZo0ZW+G89NkCmtY=;
 b=YWqm8AjypMMbgPGJVLYM2Jhzm+AFYd6DC+S1t9ZP7pQ4TtiwRCXjqV8EvqmkvIdcK2p3lfetimoMNyXqJIFQk+m1Jv7I+4QltB8bwdFQBK6oTEv5Jpn/JdKYzoSVzjtaXgXCeAeBTviD8y13tjG0K+hVkAGfblDHC56ZUZOixis=
Received: from MN2PR15CA0016.namprd15.prod.outlook.com (2603:10b6:208:1b4::29)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 11:32:54 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::2b) by MN2PR15CA0016.outlook.office365.com
 (2603:10b6:208:1b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 11:32:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 11:32:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 03:32:53 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 03:32:52 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 19 Nov 2025 03:32:52 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] arm64: xilinx: Remove unnecessary #address/size-cells
Date: Wed, 19 Nov 2025 12:32:38 +0100
Message-ID: <7612a3817480f4089aea3e14cca07d585f8fddb5.1763551956.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FJanHaoW4wQFWM/h1X/1RVb5ML5Y6S010fMpkf7h3cI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTKrrqxZqJiWftlhgphp/PttXt28LotXbvuxrtZzUk2K
 Qfj2Wu6O0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAikjMYGRY2nP3er3GiLCbv
 Q5jipRzB8OszXd4ltPely/ixmfLL6jL891c/citE+G78Z7bDe+6+sTZ4z3Txl9IqJoWcGk1DZvF
 7XAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: d8b6e29b-66e5-4671-3b85-08de275f6119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zv4EuzQ5aJ778guI5tTA3iaSNR2y1ggr7Iv0gPkNdXXJiCw++Zj0GLpsaTOF?=
 =?us-ascii?Q?2UO+0xNtoCDOIM7mOU/PGLNS+uiNuDnlmgy64zi9WfkR2ErtPnEhIKqYXz1Y?=
 =?us-ascii?Q?LCgnAHLLLNjLBnLnSdEZqthE2EKnhu+Dwsi5outdy+fq9IEov67MPxMiqw79?=
 =?us-ascii?Q?l6DUz6E8kZFRD8qaNR+DasgV9LmCpWjJz6XHVDhd9HWR4B3w/MwA1uL6HaLc?=
 =?us-ascii?Q?J2jhOX7lGhOE5q3v12CyMigfnBA0JmYxJT/EU/PyT0G0F1hKXqAbn7avTW5w?=
 =?us-ascii?Q?t5eT2RA0ReiZxcfk2C59C9G1hRSXvdr1NVE8f/lbmvFk1layFgbOaguvmuCk?=
 =?us-ascii?Q?xjc+PuAmOSrgSge6g97un5xmH5Nv3p6YEflQ/jec81fowNE+BMzx4wvFfA6j?=
 =?us-ascii?Q?iBUd2eo8T88qwAkef9SxrO6VQGwlwb4mFzG2Ilfflo0CtXi4lLjkd6AU2FiC?=
 =?us-ascii?Q?JgWVrkgkzr2GurwYJYJpvRZ9sZj3NYK21nbvie252ija5n7FMR+ILX2vDFdX?=
 =?us-ascii?Q?y3H3GHGONvt9jfgZV9rBZytqYmNJRw81XsChjpr6GBzCmur3tbfYQAe/Bjc4?=
 =?us-ascii?Q?C4vZBbm86W0k53l9YUmh0dhjaqa2fBUUa/voa6pGxEHKcFDglcKEdBLVFhdO?=
 =?us-ascii?Q?/mMKA5SCx65a5IU5uFOAM8w5FZu37c/f+5leiAgHM3byewA2vbtYspeanoOu?=
 =?us-ascii?Q?vKDAgS96aYkUs4geP9NkQ7pLzTNie/ths/puL/wfcEr43DzjCr084cVp/kZs?=
 =?us-ascii?Q?TgCkC1Vqhf+G+vS2Kz6dsboHuZg1OxKc93ehqP53WjyHZ6LpIRLQ4kglRYGy?=
 =?us-ascii?Q?Mz0fBgaKJdwUdVdVU8jtyNMqNXuZUtaPPzBYT57XOhvttfK36W9AVn9K3FVs?=
 =?us-ascii?Q?5fZnBETQSTEZ5zhnWv7FKUW9HlO8XR9h869hz2U4FegBGNLJ0FC1jWoxuGE9?=
 =?us-ascii?Q?hVRkANEJHsCrwovPQV/0p0TpBQiKwSl7fPKEtSgIgZK3zWDXLssKdPbUfKmy?=
 =?us-ascii?Q?r2jt3AQflvoql3lYl+FzfR3eWCwGo7Mc4Q7uekm47rpofd9QIlEfOYSadURV?=
 =?us-ascii?Q?/g4iSD8A/M6ZLCvF8UxSecf5zdU5sNG9bQ2dxgTFoEZNkrhAoW8tL8mM6Y22?=
 =?us-ascii?Q?bBzUw3Q+FUDnRPizegFnzROqsmsdNjV0Z7GTuiS9aiLYf4sIsMyAQTVB0pPx?=
 =?us-ascii?Q?qQTcUT6lpVuCZppIuKrGZs/ZsUxfNT6LfIuZ8DAW+pmc0jNTBliPG2elcCSx?=
 =?us-ascii?Q?+L6T1y1hJD/LxpysasFTT24FqxE208p3hGLlATP+fBfHWO0d11hqwyuQ3IFq?=
 =?us-ascii?Q?JHD2G2VD2r4KTiBdZ54jARmo/DjyB4f68/zYjSXGRxqLSkfWkRmXtnA7938M?=
 =?us-ascii?Q?1KrcD5aNTHwLHT8QY0SUg23v97v74erIdV9MRG4PVoBBCEQVxKjIy+sR98F5?=
 =?us-ascii?Q?9K713BAZWydw95cCIv8rzby3E5jOnimm/xs1nQTcijiRtOjAi7aJf0GMKCuM?=
 =?us-ascii?Q?PXxhxd1gtneiT9xmTpdAlWh9gD/+63X152D5awiUJXjTSSHqW3EZC3jCP+dV?=
 =?us-ascii?Q?4/gp7osSv2qwUGIjmIc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 11:32:53.7174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8b6e29b-66e5-4671-3b85-08de275f6119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

GEMs are using mdio node that's why don't need cells description in the
node.
SPIs should be using partitions subnode that's why don't need to have
cells description in the node
Also no need to specify cells in DT overlay root node when there is no
child which needs it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
index c1945ea6f8d1..5a4e5f092506 100644
--- a/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
+++ b/arch/arm/dts/zynqmp-sc-vn-p-b2197-00-revA.dtso
@@ -13,9 +13,6 @@
 /plugin/;
 
 &{/} {
-	#address-cells = <2>;
-	#size-cells = <2>;
-
 	compatible = "xlnx,zynqmp-sc-vn-p-b2197-revA",
 		     "xlnx,zynqmp-sc-vn-p-b2197", "xlnx,zynqmp";
 
-- 
2.43.0

base-commit: 9556d204c351d2dc40176a31dab11f789fd1cc7f
branch: debian-sent3
