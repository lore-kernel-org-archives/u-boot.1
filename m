Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C3C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EED80762;
	Mon,  3 Feb 2025 10:19:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QbRNxSsv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9867580763; Mon,  3 Feb 2025 10:19:15 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 578588070F
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:19:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5sHOWvXHW/xOxSErF+Xx3nadfcKzkvc7tOH7U6pHAAKQZgpMYWxbgYhKqTbHu8G+4J1V4R3I9ZeLZEAdiSojyzTm1cC/yZUl9NB7ZyjK7o3jS4gk2or6iz1el7iae2pvLLkoaT6xXFf/ZjzPHCUICWi4nO1IZwNBn1dT6zMrgDiXhJK56CPNK2FTOnXe2IKqpxm+7JK04Xk9jywxYkGsRpWNVLuzf8M9WqeszGdy2Q7a83Dvn2YtNEIsw8Kv0RueWEzkqCTHsjnzQT3X3uF+LWmYQgKNOjHTWtzRzldgicHbIs291+wb3HoS3EFAAuORVC5nySZv3utW1MzUFSOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ui7t0+IDc9uTSS0xqgqog+he3XrHjtgRk0GmZ+J3l4U=;
 b=CCIEFtNm4rP/7pX8Bz2eqg+TyEOORt12ILnaZCTwmhzRBdxPcSj45gzFHyRjhowu+BDZ2HgKCrCD/9G/MDXgFqb3C5NxMB2/KOv91MuA0ubXiaf2i+q3BsY0OiLSJuSN9/OGyITECmkV64azOSDNqm0Nf4j34bysue7B4jnIOwJ7jxMhagIjda8QlAmq3ydePtxpPbJEYygLfpEz3HSbapD3gtYW25rVn6PVrS5wdbKCsyds1rlrbCPBFdhMhKJ85RNfhlTUCo8Zq2wjdIhnqEtIOaEEi+1bgSkeQf60bILE0+uSsiryXdZfpzl4SuWyQYcE7Tl6cVMcetUqD8sYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ui7t0+IDc9uTSS0xqgqog+he3XrHjtgRk0GmZ+J3l4U=;
 b=QbRNxSsvttU8SxedIoWQ9lqZVxtHaOJeXNEYqB9gFiLwHjnWJ59GfXcOlPiZuwdkIWP/Q7AM0KTe52D2YIQhELlvqE96xdNpp4neipNurXHqwQreK4Qt1MTsQlY4PS2x7hklcqxxsvvMr/ZLEnDAqg/RB2bookknxBwRm+fFosY=
Received: from MN0PR02CA0027.namprd02.prod.outlook.com (2603:10b6:208:530::30)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 09:19:09 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::63) by MN0PR02CA0027.outlook.office365.com
 (2603:10b6:208:530::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 09:19:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 09:19:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 03:19:05 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] rtc: emul_rtc: Make emul_rtc_probe() static
Date: Mon, 3 Feb 2025 10:18:57 +0100
Message-ID: <8ebf5355bbd29a38dbe4ba83816f6b196e3891b0.1738574335.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=715; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=bKwlMtURneoveVbR9L6FRdLUrz0lendK57MRauZAvz8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQFXUx1R8ITwyykX99vmnS87MzUnTe+lTqHiU/Q+/z5i
 dg5X86pHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAikz4wzJWUkAmrCLON9oit
 WFBv89AmyyfVlWF+8gUOtw3bNDJXlfct32rptPrQBFUNAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6d4cdc-a25b-4e67-964c-08dd4433d03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GEPkFnkn64gTOlrqV4hFRXkOmQzMOlnbCQeA+Za7n9zE7Xjs3AXtuhWG+VDn?=
 =?us-ascii?Q?2ezvvQTnh0M3iGWSHa2JyUjYL3lGhy5Ui0GOiAYUuEeG4G7Itnfi7BZ/kqRR?=
 =?us-ascii?Q?ij9ef+dCdNUGS+6vYrBr0NdL7vpFrjIDKSL3wGzPLahRYwacy2fMYFFVDeTY?=
 =?us-ascii?Q?bYCY6d7zf8wEJp9W0Y2mX+jVMVVrGO7hiLkKZyeF948khklYqQwuu+1V/bGo?=
 =?us-ascii?Q?DfmaImX81YsMDPtC8S2jqEe3YsFfDpZjz4+Cbz/1enR1iSLfcvu3PJO5cpgH?=
 =?us-ascii?Q?chEJjPu6Jxy521HbgyEucaH43uNAUBB/FVTmANahemuUOoisc5l/jJiSjlsf?=
 =?us-ascii?Q?1TBsSw7qlg1EWuc1y/y29ndQ4hEoXrKwf4nrzEpqv/+QZRAn8l7krMX/xWD3?=
 =?us-ascii?Q?8k2PcZAz4N5a6qsttErtv391FsbPMecEsidYX9IEpI/lKTNzQyIX8W97QdEM?=
 =?us-ascii?Q?wrK0R9nDkl6eBhncGsH4lfOHKXmkuWjRlJPK2a4+1kmHscYYxkP6Ch8ZGuC9?=
 =?us-ascii?Q?+3W/i208RGwCrO0WKSQpH/5XBbYrf1UMgna9CyuD0Fmewm8IfatDAHIVduSe?=
 =?us-ascii?Q?4nZDbbFzbZcCdfb6RzEFWFGXdbdw0LR2iWd6l+dFSxncNyuZQP/VNcnF3vXn?=
 =?us-ascii?Q?LePGp4wYrOJYHGNKDQCLjp4Xksxv7+CoVIDtPneqDzoaEWuEg53Fbl1ldB4D?=
 =?us-ascii?Q?XuFWrzmnCk2c5ifh59mvpIK/9uVAOr75asqqi0yY8Qu742o5Zxr0ZhKAvN20?=
 =?us-ascii?Q?r/5DW5SxlPNd36eM4KQgfHCuk3ky8FjG5wfRCMGFh1ALtFc7C7MMhP6W16Me?=
 =?us-ascii?Q?XKISUaWEfnhiwtbyb4uj/su2z2xiLcbZWsBc7YqW1BEByO5r/tU6hQ0z1Nmu?=
 =?us-ascii?Q?JAf6JVNhvuTQ3026Entdz8nv44UlVFwgMHn9z83VpRa3AFj061BHjYWkvGeX?=
 =?us-ascii?Q?jNIVEN1GLl9PCIb6/zEDYI5XqjeNTCI9577XG6SHSUMdN+FC9dX+VuiymWki?=
 =?us-ascii?Q?YkUNPlTyRbnpomI8VCBkmAuy18K5EuZH/DLwY7VbW3RCXkjNopp3SePvdwKR?=
 =?us-ascii?Q?h5+AvizyOoOiQBymS7ZS9VeqwTOyqyufRqSFD++Ir/nuBiY5jS+xGSe9u6TI?=
 =?us-ascii?Q?HZ4B0uYs0zhsIQNaiHCWUZ9Bor5Ye+wWHqDWJGIjaLLKyE3fVIJpn7fcVvgc?=
 =?us-ascii?Q?2lzdlpA3aRW8bTMm/B+H91ar9eDSm4v5EIi4O5S5vgdyeRyX0XfDEo1ypxvJ?=
 =?us-ascii?Q?gk/+BUiL21YSTU0iq+PpUVd5BYQ5yQvAm+qGDpMfWLlRHhVSxNH/FIRjXHA7?=
 =?us-ascii?Q?TCMJiU7H5szljtivxIRIB5ylb57RHls8/QC6LhZpDZvygRopn20W/RKikJL/?=
 =?us-ascii?Q?MGYLKhN53PzWRNq+1KGzh6Xf00E+x6woc5ysqZFRSkB33shlS/bIMKs4apbn?=
 =?us-ascii?Q?TjuU9dvNPvd/rE46q1wsBtClNV+n5dsh+Mxll8h2CcDu+n9YnCkVls57q/+K?=
 =?us-ascii?Q?N23eUxcR+OpNauI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:19:08.3480 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6d4cdc-a25b-4e67-964c-08dd4433d03e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
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

emul_rtc_probe() is not called from anywhere else that's why make it
static. Issue is reported by build with W=1.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/rtc/emul_rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/emul_rtc.c b/drivers/rtc/emul_rtc.c
index 97a8d9bb7df5..6817daad18fe 100644
--- a/drivers/rtc/emul_rtc.c
+++ b/drivers/rtc/emul_rtc.c
@@ -58,7 +58,7 @@ static int emul_rtc_set(struct udevice *dev, const struct rtc_time *time)
 	return 0;
 }
 
-int emul_rtc_probe(struct udevice *dev)
+static int emul_rtc_probe(struct udevice *dev)
 {
 	struct emul_rtc *priv = dev_get_priv(dev);
 	const char *epoch_str;
-- 
2.43.0

