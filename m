Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DFCC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 10:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2D7580756;
	Thu,  6 Mar 2025 11:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nrj2IaOX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90BFB80BAA; Thu,  6 Mar 2025 11:12:52 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 222BB8003E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 11:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSCd6c41ANNRSCNLU5nFB4ulBwZt27qPiq9etK/+OWJRYdzc6TfBhFGtzU5GUOgk1JFL4WrDjbr/uihuB/JbwjM145b64k8Gi/pceFzTnK8CoJeWGKLW+Bz1HxeEY77yWa7RlyJ3KN6Oe4ODnIx/juq6VXBjoEA/FDMhmWKimOE9pSmfAaj54ZFU+c9aPOd9G06cIJJJWJ0pc9No0KzVkFEGpxN0GPO/sDxRoIMXDyg23pTCCHkLyZIOOtJGzZ1kYSE7BhD5mL1XiDhHQF/ZJmoCVoQMi1vAQHbh1nY79fsE6Qwlp5BX8NZxOZ6VNYItj+j2j7/DD3mS9GOaiaD1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZRNxTlHRbrU6dvwmRUcx0YGu3stUqRkFQs2WMvPLY0=;
 b=DH1MJkmfkefecjo/WLvrgCaVU+TjjaGqFuCLqeattQYuuGThwuy2j6WHpP8m1HBkDYaLs7MAXZQog03DNuypm5kHOfZp/PmqjPIxFymSRXLg3vogPZlYh2rrxfyX62rdYp6WKdCvFULGyJTV52IX/Bn/g2a1BbfeFmVYzwbAGXVlLErdTRspi8rB6vlpR91bcgH951vMrohZI1Y29I+NT04moo8JquDLjkDuNZyHObTc6/lU/RxCtSwkAFjvErLi288MdlMDfBtABKQvaywlv6fC5c+Ar2VlzVzdvUBGHo67Pf8PhjhWXm8ciehXnj4ZkBJC2nIt6mCef+x6uxvTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZRNxTlHRbrU6dvwmRUcx0YGu3stUqRkFQs2WMvPLY0=;
 b=nrj2IaOXb02/toy2GojIzANX95YeKdR2SEqYNarYvP6qfSDrqCkF/hYVt6VVzsANLufgyWbp5NZuSvmjASp/okwWkbYweVaoenY02WnL3bs7lYhM+QqAaaxj96yyuOYVEksi6UDIFJCChX/K0dqb+RRthVdwKyXQQ9Gvl0hhCsI=
Received: from SN6PR04CA0087.namprd04.prod.outlook.com (2603:10b6:805:f2::28)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Thu, 6 Mar
 2025 10:12:46 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:805:f2:cafe::7f) by SN6PR04CA0087.outlook.office365.com
 (2603:10b6:805:f2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Thu,
 6 Mar 2025 10:12:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 10:12:45 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 04:12:41 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>
Subject: [PATCH] cmd: version: Get information about GCC and LD back
Date: Thu, 6 Mar 2025 11:12:30 +0100
Message-ID: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=928; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=8AqHrB0xKkEcsq3BmJwHxacUcKt6NOSpoAY0+fEKBh0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSTpcLvpO1PNqXUfZ7VGyB65pj+mj0vdu9sCQttLNs7I
 3/ClKccHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAip6YxzBVL2GBodqVNYLqk
 Smnbvcn2Mncm/mCYZ6c93Xt6u4vG/+XHF64Pimm6YerzGgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a1bf947-9e9f-400e-13f6-08dd5c97706c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gCn/lsmBJSWkGbXemHHz4qwrSFVSR925ISDvbK4QJo/0dZGCTtWExpOnxVAO?=
 =?us-ascii?Q?D1k4GjcDdf6nbXWk25zGOyqgxVpPdR3RcQcg+kUbsOrEGCxH2HnlKzfU7N7A?=
 =?us-ascii?Q?TMP4zFMoWpH1skeW3tco6BEGMwA1m/5XxB05myce2wwEWDhStdYRhXoJOt+l?=
 =?us-ascii?Q?VxuvTqQGJWhxlSJLFPH7atst9I5ISitU02/3Cxz94l0m5uc/EpOEwbFk1jcL?=
 =?us-ascii?Q?RAF2vowNPD2U/3c6XHXR7hnsk0pHgjiFO2ZusWBr+xGL+I+E3rq/F0EYdNz6?=
 =?us-ascii?Q?fWmItOh7ZLyk3QFgu1H99fCl33vcLcbzzQMN0zNO4CL0WWqw4XYUIbSApByy?=
 =?us-ascii?Q?MGnOzPgwHb5+1IHqIh7Go4j+YHjdhTmdKvTVktXx2B/4xkpqumar2/xfmoX1?=
 =?us-ascii?Q?9X7VLVPmQTe9cgqM4a767rgLuCLr1TY434zxgVNdSG+RunDVRByftLUVENI0?=
 =?us-ascii?Q?s+M3H4rHHuVlEl8hjfXm790Vhlh6EAIPTeFRV6JfcxDT+0zcDg79/EsCZPL3?=
 =?us-ascii?Q?xlpHndO4ooxmg2yizBlkerzrvYnNrksOrskLChDOfi0SN/NDX2+JBteoCB/K?=
 =?us-ascii?Q?CwwBIiJyXDhpu1MJSfK6dR6pRsfftVGmaevmKUMRrELWovqy4A7ptGWSCRNT?=
 =?us-ascii?Q?+0LA/D0rdJ1vR5BkafAyF8muPMMcdN5TEdQ7CfcDqxCw6fgSyHE2vS/TTlah?=
 =?us-ascii?Q?gSizIVrA7FF5baKARAADehQEFgzStkoHARhdnBIgL2D1d40Y7wpxdfnmx6UM?=
 =?us-ascii?Q?On/XJyDfID7ccBU8cOIAQAyeseKi48oOBG8ROz2yyE1xRjDmEPFaW7XCl7LZ?=
 =?us-ascii?Q?GroLbfMNkfOGXbsZ8tZAM4TYpOlF7eVhk159+h+TET+/ozen+Aa2KWgl0+cc?=
 =?us-ascii?Q?Lv6JpSUgMhs9oGp2y1nacRePuy9Bm4aO6VTpqab4AOCYqSTI4t5aWc8c4MXC?=
 =?us-ascii?Q?mX/VFh0s1b9ULt8HBXFFUu8j5P4H/XSyQ34fKYPXPfdSTbP3doCmTfcfw0+m?=
 =?us-ascii?Q?2SNS/dFldijdHEYRWAw1CWQ7jqZB4f259vXSTICeN8481zmQ0FhT/WYfgTm2?=
 =?us-ascii?Q?H/j9ZnrpEVvGpdcuB+kD9lFbK+rzttxrclK25w8wPLrkmEoplVpE+Rk3U6Ml?=
 =?us-ascii?Q?F6YF8XMq2u+SZCSfidxIC6CW6+dt8fs7O8mJvVZ4axHx9+IbeIQhseKgTqNe?=
 =?us-ascii?Q?Pp4jLpx60HhHrIq5zQe8PDVvK7YWYaFgfZb4XGXcRcgGAVNTgYO9MJhj95Zy?=
 =?us-ascii?Q?UQL+v+cvI3bB20k5Q86B6Y4vCxKV1biAjercoNDTG0ISorvteiGZYMDjRjbK?=
 =?us-ascii?Q?boD+bLcAuGEeL2iNEggwa8Tk92BJ4JpuZtj4yilyf8SnRGNHrfqXCUJSiNjI?=
 =?us-ascii?Q?9lg+m2baNW3X8rCUh6Ic37BENMNccZHDFmVnVL+wtMfJZ+9Bx8rDOP3HP9OC?=
 =?us-ascii?Q?jeBF/yTk0I4v5xjU+o5wdqQFcwBMypHLKJZmWV8j2ac/I1Q7G7hbS0MVqom7?=
 =?us-ascii?Q?20RYoJ/PizLJfcA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:12:45.1645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1bf947-9e9f-400e-13f6-08dd5c97706c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

U-Boot version command is no longer showing information about GCC and LD.
The reason is that version.h has been removed that's why CC_VERSION_STRING
and LD_VERSION_STRING are not pass.
Values are generated to generated/version_autogenerated.h which is sourced
in version.h.

Fixes: 54ecce2cbf90 ("version: Separate our version string from the version command")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Tom: Not sure if this has been done on purpose or not but this issue has
been reported by our regression team.
---
 cmd/version.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/cmd/version.c b/cmd/version.c
index 53db1a0b6bd1..62406608eb0b 100644
--- a/cmd/version.c
+++ b/cmd/version.c
@@ -6,6 +6,7 @@
 
 #include <command.h>
 #include <display_options.h>
+#include <version.h>
 #include <version_string.h>
 #include <linux/compiler.h>
 #ifdef CONFIG_SYS_COREBOOT
-- 
2.43.0

