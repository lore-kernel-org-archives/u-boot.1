Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08767C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 12:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3348480756;
	Thu, 13 Mar 2025 13:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JPw6wmZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 581AD80F9C; Thu, 13 Mar 2025 13:24:01 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76B618007D
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 13:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8g6p0sz5ryFdTF2BvDCrcplZcxK2mjLZgrw0SF57IfZYfoiY02gShbG454DLUZ01ogBoqaONp3Ev+LtYXmcWoSakbwCm5FQgHsogPT0ioMZlxLWMU/JmxL0BuWkD1B9A5DAvUAWxL5u3sAaKZ3xZHb3lVV3QECjVlYXLSoYknIjsDiBBbkBZGntpFIR8mnSqKm8vCZJnS4zjOv9MB5ahaIDCV8jeOkPif65d/RLYxEL6Z79ZyguAMv2jq2JyJQKAIIxTCA+I/364Zl34XJ6qou47rmKEo2HYCzOTlSQ6pU1PbHWvnAs/Q6u+xlmPxIBdwMlv7v8jhJFQPFJIxhUyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVR1tfnPEEHWc9rXuM6zECofKvODttZNoLSNwWKsvMk=;
 b=IJcPfCl/J3RuAuRsfLd/MP1JHN7idXxXk5YnMBChldlmy8dn566QZhcMUuSS0TbBXyRerlxEryVcu2zQyJbUG+fYi/g91QYfuAW+oKIsIHxFXUCBu/DMLpnuITQcEq4KAE01v9mMv8qb2ZGes8uKq6Wu33K6maRhyfWFmPzGRggmCo4LyME0vFCx/xCOeiSxlHVTRIWSLE2nD2XpYtV5YBFQkwGK1We4zgPSTGVtA/w8eMK5NbQtrtczt1GtxZSE/zoaNVjzSr3W2Tt/Tkv1R/BbiowftA1RiBcOWhLos7EKYvyOTl68stqZkeVEhEfQuz9LKK9LyUmdvZ87z3Uq4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVR1tfnPEEHWc9rXuM6zECofKvODttZNoLSNwWKsvMk=;
 b=JPw6wmZOPsr/gE0Nt6Q0RHpFY+tuwBWT0jZNoH8CieGk5ofqJ3wD3jDtji/ws1y9063cAhP2FbZXG4uwIw1wK3a0aAjpk+N3Mt1qrgVHEe64hcC01vtTp4WPDwlykLBIdWL0eFcvcwbQlmAWqkX9MF+QHGlva2RjwFjbubgXa0M=
Received: from SA1PR04CA0002.namprd04.prod.outlook.com (2603:10b6:806:2ce::10)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 12:23:54 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::59) by SA1PR04CA0002.outlook.office365.com
 (2603:10b6:806:2ce::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 12:23:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 12:23:53 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 07:23:50 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Caleb Connolly <caleb.connolly@linaro.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>, Tom
 Rini <trini@konsulko.com>
Subject: [PATCH] serial: Setup default base and frequency for Versal platforms
Date: Thu, 13 Mar 2025 13:23:46 +0100
Message-ID: <86edf3dbb6de16337aac36f5121f306f83149fc0.1741868624.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9hznXn8MdslE3lbMUSEBkwOpekiZD2OpPi56lWCpu8w=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvRL54KyThU+1ObXX7Su0OWKpua181brBTpiJyX3fMtRO
 VS44PusjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjCR/68Z5pmJSeW4qi6Q/i3V
 e1l498Nvk5h2VjDMFRCZFTMtiWnC87kNJrvWZf0r1+NfBAA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: c0572a7c-9c1d-4083-f8d6-08dd6229eb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HDCPmPSDo4LsC6/SLeQluB2wIhBhleWpRzV5mFvEsC2Z6pu19z9K5d1t46H+?=
 =?us-ascii?Q?JSDdKJp6XGnUQ/Y43RDBkxs1WpiPT8Jws/8+6lUmtwJA57kWXB3aCAi75BgY?=
 =?us-ascii?Q?ynrQm+jgKlslCNsl2x1GGwFHBq6baAnAAWnq5DLAa5G53B9PRIMB+XFu2f+Y?=
 =?us-ascii?Q?oZGU5aLkubI5bM3LBaldGsnWnstTPiS4DY03y/oYM8S25hPkb9WgNqcCoDwJ?=
 =?us-ascii?Q?bJTtLho09zjj6UTR7i71yzquswHYsm4qayCLrrTbbJDz/6/QTHJNy402tvjI?=
 =?us-ascii?Q?CTGI1Ta3YISaqBp1bEGM3LIBMkuH7licmcgj1EMkEjKoqfHthWT1QV0yA47q?=
 =?us-ascii?Q?NDpcCGcZ878oK2UT+e36+werg6/Z8df1w1HMpTu05lzgFDToXVOQ71RDIqgM?=
 =?us-ascii?Q?YNHHJp11Uz5AAkH+7bG7j9Y3/ZXPkkVM2z4Mqe7E0Kcu/ds2eFmWom2lSw8Q?=
 =?us-ascii?Q?R5pyaP9OJ93gu/CcP1si4QjpckiWHYe4xrdsiyskxIzdZP/KWYlCtQkjnJlu?=
 =?us-ascii?Q?ECk/Bz+nADglXgHObKRemD/AUnZYC3R0Lgy/wvzXQ2uEXAiHkX2tUTTXDclF?=
 =?us-ascii?Q?oIlk2gu9lcp2SkfbU1F2s3WM8z+EBZh4I9BTtBcTqbGaMPaSYAujyb5v8m5M?=
 =?us-ascii?Q?H1yx2B8kyZHKcGNPMK4fIbHd0v8TQCVsXvICnL3rYPj2N4pfJiy+2dVV9Q5C?=
 =?us-ascii?Q?SVpZHaZ62RnbeatLu4r6KF4UZ/yUjrlmhr44si4nOjTFHv9/t76DcF5ynKDa?=
 =?us-ascii?Q?Yc4XNSDe5WUYbCKmVtv2W8hw1vOPwxt8rz9lftPuxbKcmh3QAdDf42Y9JY/6?=
 =?us-ascii?Q?nGmfXlFuo1AYmyrDRpDYb2/yXJK0T4RLWxrzKKtwdN0rYxysLV1YK+ZBIHDD?=
 =?us-ascii?Q?4/bGnQXeRrlOJBz2TiTwMcVyHL4dJWH6FJUQxLZZxhzwgZRhe/VteRJ798yF?=
 =?us-ascii?Q?4LtsJpLdrV5CdmndzyArRfZCmleFa7CADF0psjEj/vARJsUJGA4Msz0xwG0A?=
 =?us-ascii?Q?Gx9Wt/AXcdeecLtwe9812izviEDYPT4jAsNb1tIn+mpMR4uYwNkvT3+xtT13?=
 =?us-ascii?Q?2QMWtTL2B0/dkAn6QczG0m+CanUAVy432sHiGOo8e7eCWWdzrHjpcJHu0U+3?=
 =?us-ascii?Q?UeUHRpoGigm4lpBU5V5RKZ9qq0CBjt25stywXBvdUfXZj+uldJ+P1nIYvmcF?=
 =?us-ascii?Q?/U8KNSPAnyLabAlzCeNoxUmN8UccyidbMk6616whQlgQjehO4EGO5ToJlRiE?=
 =?us-ascii?Q?48DU8eZfFt4aQVq/7H30I3m8KxskdAzEBhPkUy/hpUh5sSf4oPPyr5rUeZ0p?=
 =?us-ascii?Q?Q6clpBDdX8JS91OGsx8/X4iSohBRwnLmaqjW5DAk4PJvY3bSWmq6Vsp9Hb9T?=
 =?us-ascii?Q?vpA8PUab526ihc8UH6NaebHV0wC0Xm/bymWLoPkNCQa7Sx6A5EyPdfVCoFhC?=
 =?us-ascii?Q?w/b21fshA8l2dp3qOSdeYKS4eFGegB3MYF5atckWE9t0iS7/sKkxow=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:23:53.3816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0572a7c-9c1d-4083-f8d6-08dd6229eb22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114
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

Add useful default debug uart values for all Versal platforms to simplify
and speed up debug uart enabling.
The similar change has been done for Zynq/ZynqMP by commit ad55d99e3cc3
("serial: Setup serial base and freq for zynq/zynqmp").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/serial/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index c4f4a8d78df1..cb5fdc8711d0 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -519,6 +519,8 @@ config DEBUG_UART_BASE
 	default 0x0 if DEBUG_UART_SANDBOX
 	default 0xff000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
 	default 0xe0000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
+	default 0xff000000 if DEBUG_UART_PL011 && ARCH_VERSAL
+	default 0xf1920000 if DEBUG_UART_PL011 && (ARCH_VERSAL_NET || ARCH_VERSAL2)
 	help
 	  This is the base address of your UART for memory-mapped UARTs.
 
@@ -554,6 +556,7 @@ config DEBUG_UART_CLOCK
 	default 0 if DEBUG_MVEBU_A3700_UART
 	default 100000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
 	default 50000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
+	default 100000000 if DEBUG_UART_PL011 && (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
 	help
 	  The UART input clock determines the speed of the internal UART
 	  circuitry. The baud rate is derived from this by dividing the input
-- 
2.43.0

