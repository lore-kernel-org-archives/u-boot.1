Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB08ED767F5
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 09:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524C8889A2;
	Fri,  1 Nov 2024 10:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PaNVryGd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7348988B8F; Fri,  1 Nov 2024 10:50:07 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 145E28887A
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:50:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vt5bVDJ5e0Lc/TOdE8HVlx0s0KT4cbgWktIXKrViUJ4NAxhCSHnb7qpTkznrVofxFwTwhtOa5M/UTbFUzfA5uFRZQvNmB1Un2FSCT6XldyYkKAd3ltEg+4F/APAJYUqZf1R4QDIaavQj6yQdeItQ0O7rkFxhrnbLukQjyBosh1SPpumMQOqIkA1mboNKZkGLgkJVaG/JvHkXVckMd3rjYDtEZWv3LJxymj8TNb/IP9KRN82oDeby8TxgsN32TUsMGZZ/KzlVwHYNrQjdFumK96m2RNDJzUP8bpK3NeVuBaQTxT+UVtmTntQ3UoGTjanRASg/yUhhJnSi94C3QMcR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9eXmKlXUFSPo17y76WP5WcD8tjrm7lI3d7TxC6K/jP4=;
 b=XAxgjPeIIr2KZNDaxzRnIWXMlv0vwrsdiws8vuUS2Q7co1R25D3m5JhIs4iI7clzSp5ifyuLz7bsxGoATlqUjm8oL8NC97IoVyumJGZTi1td7AcgFBi2F27TFiDqj04JZ+6dPKuddy9+LK/qyjhGXfYWkb0+2910CpU5f9O8lQjJIXIgA4KgAwtnpRUscoQOawgJwma4Q04pBOINL9qszUn0YdkIQY1bcTOsU0yD8bVa2ZmfoqiXuER3ecjFzIhwiKvtBI7AKvbVcW98TFYhqKHA8PlNDfddXKE8a3Z86wgGhHao2Z+Hv2ArdXLmKwzLk+qBavmN3CDT4f3WaZ7gjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9eXmKlXUFSPo17y76WP5WcD8tjrm7lI3d7TxC6K/jP4=;
 b=PaNVryGd0+mdK1B6iOD/rBBspsPXYE51FR9rHcZlyaz2mvJIs1tvjdFOLvWrfxj+w+HgP+/OCWAPeu++r2e4jTUbELDOgKCNdCnElzrujb0tB5O1m7040IKzv4hz802389X9ol58RRYI+2cx+bjKA3j0B6UNJbHkH9f4JP7zXcg=
Received: from PH7PR10CA0014.namprd10.prod.outlook.com (2603:10b6:510:23d::16)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Fri, 1 Nov
 2024 09:50:01 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::f1) by PH7PR10CA0014.outlook.office365.com
 (2603:10b6:510:23d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 09:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:50:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:49:57 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Leo Yu-Chi Liang <ycliang@andestech.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/2] xilinx: mbv: Place DTB by default to DDR location
Date: Fri, 1 Nov 2024 10:49:53 +0100
Message-ID: <e0109cec6a81163f213684758a5b2d67d927ea26.1730454591.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=828; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=/AnbRVpCBLu0qKt+P9hJN2l1cVSclZ0AGKdKm7FFzB4=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVJY4zZl9zr1W6wVrQdZ6v4E++obcKo4yo7HZb6Z0Zy
 38xhf/tiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABO5v4ZhniZD3/3fLH8m6kde
 y3wVmsij15gvyzBPkfmreyDbdrYn0+zniL9i0uVkVN4LAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b2b969-d5cb-452c-5109-08dcfa5a8dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rgp9zf8NWEWzSFTUg874JjMY2UWvrT5VbxvAMR/iOStu4IN5jHN1GSa05B95?=
 =?us-ascii?Q?7bD9h66W17ogUs02+6YlgrIGPNQsVsgDT7PLFdfLIEjf5x96Gyv321MfMt+D?=
 =?us-ascii?Q?atyk8v2SLy17ynruz16hXlQZUGmzCVxAiFIsOpCU/B6uOU8+wPuLjuCrDMEc?=
 =?us-ascii?Q?DKMdZfKBUy8w1vbRQJFWSp+nkn30h1v/cKzrd0N+anBm8AYzDj0pWt/vRvLt?=
 =?us-ascii?Q?NIIg3ckXws+K7c/u8Vp6JNkVK+VNpmX64OzpvIQ2/SPYvQ7XPdglPrxhWMXF?=
 =?us-ascii?Q?uPfcxziSrt7z21ZAsvRjqciLl1g/GplmTgs8MH5rlU4EBPXQQYlQdl5kF/By?=
 =?us-ascii?Q?+zC+hmyqNdQ6BRIivoK1x41HdtY+Q7Js0RsqVzyWKJ7r6+sgzDBZI8U+YYFR?=
 =?us-ascii?Q?ZZtGw6IvnWry0InhTY98TzFwKGChhGshk+4fICtSwhH8NC8OWBFEO8XB9lIE?=
 =?us-ascii?Q?1a0umEibkeYyny45Z5LgB7EGvHEXc6NP7moM9NcfUakZVJayKvDXxsrqQCEd?=
 =?us-ascii?Q?FrIbMMQalpkZllVi1oYqXEmpcmDzTkwMvBSLfcA4XFcQL8ndB5KG+jqhQujs?=
 =?us-ascii?Q?zm2rSR5rT5f7TIqqYH6EvE6HTS2KF2GoGjAUaqs0gM+ZzNqSnxOcPsntY3rn?=
 =?us-ascii?Q?bdc6exMEbXrsOEEyATq80y/gxKsXrE9K7+e1EHGspzykg9akjJmYwIoo3i2+?=
 =?us-ascii?Q?gYdnz09D8fQI8bqMO4S3g8cFmTuUCxP3GZXHEdloEZ+DCBrQbJxc1O/dYz3a?=
 =?us-ascii?Q?R89Ler1qNswicdNpSihp1ddYOC62klnomY0VGEfVeEQDj7uXHqZwx1PLT+Qg?=
 =?us-ascii?Q?huH0POaA5USEVMi7EmxulArioTHxnYQ46M1o7XUb/H8H41unOEpT/zkt9arN?=
 =?us-ascii?Q?Zq+Sov5aQTvTUEllBAPvL0/GiECgMlX23av+BmuFOpr+vnN13dZ8atKa6A5a?=
 =?us-ascii?Q?XnhLw/NPXPiDa3xIb6bx+tRQQP9bmUgZIPxaINIvICb82/3Fmt4diKt29XBp?=
 =?us-ascii?Q?ukQ7bOpMOv/zT91OwneIjXBpyq1t6JAULDGauE4jCpSKMzH+Eex8zogJUtAh?=
 =?us-ascii?Q?tZiZ4ox14jIpVqrGqO9+xaRE8WG2dKCqFRTd3RaLEdn2LecCUFWgXt1I/CI5?=
 =?us-ascii?Q?pTSpvtmUUv/HV52CpScNaolU4w1uXuv71PgA87UrHL15LQzUBJRc2NZ0Ibna?=
 =?us-ascii?Q?iMesKZrZ43Tz78sKYo1OymL75PlPo5FKytV4KPwAFit3+znPXeOvw/an3fCv?=
 =?us-ascii?Q?Jxb2vpKgkXGLWtJjrMpFkd9pZrT3KAV55KmBCSHq4M+rKXX4XAGjl+nQi1W1?=
 =?us-ascii?Q?HrLVCeUgmwzMQUI6l/8w0gAUVM9uxrL0rpv5oUjJzKjTQ+tG614E0e4cjWT4?=
 =?us-ascii?Q?QvdZInRiLsmetn2FHl8jNkQl3O4C6KZM68aR6Pra6eEo+zbChQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:50:01.0854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b2b969-d5cb-452c-5109-08dcfa5a8dc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
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

DTB should be also placed to DDR. It should be the part of commit
9d688e6da5c9 ("riscv: mbv: Align DT with QEMU").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/xilinx/Kconfig b/board/xilinx/Kconfig
index c7df4ab5781a..0ff8440e6e06 100644
--- a/board/xilinx/Kconfig
+++ b/board/xilinx/Kconfig
@@ -45,7 +45,7 @@ config XILINX_OF_BOARD_DTB_ADDR
 	default 0x1000 if ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2
 	default 0x8000 if MICROBLAZE
 	default 0x100000 if ARCH_ZYNQ || ARCH_ZYNQMP
-	default 0x23000000 if TARGET_XILINX_MBV
+	default 0x83000000 if TARGET_XILINX_MBV
 	depends on OF_BOARD || OF_SEPARATE
 	help
 	  Offset in the memory where the board configuration DTB is placed.
-- 
2.43.0

