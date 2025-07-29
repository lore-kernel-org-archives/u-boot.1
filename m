Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A08C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 13:55:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E4482BA1;
	Tue, 29 Jul 2025 15:55:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wchDC0qv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1BB982BA7; Tue, 29 Jul 2025 15:55:39 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B65581E13
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 15:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hGoXv4HrWReJq6PJ04OvMA5EqtQsgPjeKJqKKF/fKVyv4Zs+T3x/UEWoeN5sX1TQaYGrW9YHOXq8vCk6OL3gF8z1hEE/SExdnYpqzJg69qJeFpHNabaqyheG7vhXnTtkT1oDWVE5a3+M/BhR1NCNNxe0siG7pDAkYu/NfNClum69DDx6Qzl0VPatU//EfnGNKiAbXWUbSDak9D87K96EBQyKQ37piofSe+wjThkVwqdxfSOrX7C/WoD904VN+VCcQMZ8wwqxhtpgabVI7eji25K18L2NSbrpwOELY3SB3kRAv5+42Nw+JMl1KNljxIfEu4acR+AxQzaHyZQrt8fSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RmF6hjYZuTzCv7q8nr4s7RsGIdNCYAhkvaJHR7kIr7w=;
 b=bVczKhvJiSKfwxZnsOO1pYwZde5Paa8D6ayzh13cTaTO6e5nj7IOpRmxveC903yjUuKlF4C/2FiwtuwQRGIQx8j6rLF9Q6IVxUuOz8s3qKWFeA13SsATuD/RPORmh/cn0CnG9YUBbSvehQkrNOPYO6bBSIMUu4BdvcHIvxMdKvqqoLJVe9CN8aVv9Y9sRMPw31bXBEemWaUnve2cdF4K903rSow2pjYm6HR6jnulIcoZu6pbZCxPpHdMgR6WdQjeeelvqofxSbuzxyznY2SkobeoU890XbCNCDPozJlzqMpsIOyUr9x79H39RhbKfp4FCnzEd4o+kvOvtOBbI6rLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RmF6hjYZuTzCv7q8nr4s7RsGIdNCYAhkvaJHR7kIr7w=;
 b=wchDC0qvjQPvnzTfqkZ1z9p+NkzvxQ5X0nSB/BNOmBH+c9iNM/nM/kdlI9LV0DJlDb+um8giOdGnTqL7QYvV8e79Pi9dTgQIqLhBZsS/6lORX1XCftrLUMkAmshzA+Nfd8+6Fr7LugULkvRLKMtIRr4ih6fFARVm4lDQAOAUNko=
Received: from MW4P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::12)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 13:55:34 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::4a) by MW4P223CA0007.outlook.office365.com
 (2603:10b6:303:80::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Tue,
 29 Jul 2025 13:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Tue, 29 Jul 2025 13:55:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 29 Jul
 2025 08:55:32 -0500
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 29 Jul 2025 08:55:32 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] arm64: zynqmp: Add missing ethernet alias for kr260-revB
Date: Tue, 29 Jul 2025 15:55:20 +0200
Message-ID: <87d88dba98f7ed96463964684ee45a506d557226.1753797318.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=JnKW7+RquGWN42KU/qkyklbZv8++Mw0YmbP+m/mA9ig=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR0XDpZ2MJ8IiRo89n3tzeo7RRfMWnaLCH1/QlSTgHVe
 5JnOH353VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATmTCV4Z9G5Ib6G7OLpWVu
 y6lurk6QdXiexrfXIvHW8UdveY0nq/9jZHjdnfeVaeW2qmfHN05/eKEkTvPS37Cvb0oaLv65VM6
 3MZAJAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c56cff-4f32-4aea-7c61-08ddcea796cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Oj8/JPqTmkBR58dCPivkuTTyqe2r9SXAc3H85U2XcyXnRL1ZDQP5AZqoymJ?=
 =?us-ascii?Q?qcVDiDXjELx8XK1wIR1wUMgsXYH0hurgtF4lu68B/ouZCL3+xRgmKC9I9aT9?=
 =?us-ascii?Q?okEumni2L1/DzksRTHsk2SLZBxX2IbvXHSIe/Y8BmEmqKMw7Eyn2f9QOLZXu?=
 =?us-ascii?Q?EnomjR0lqa90FGLPGBSTkL9KG5YrtThVDxgcIPx9B2aYYK5b9sDQj+VVsPjY?=
 =?us-ascii?Q?Xborj2JMM0VlMI52uKGk0D5XEnYCquMQPcAeUH3TBU6cA18DnZUGAw7sxQBv?=
 =?us-ascii?Q?b/nYb+o6WDZcO1g/rcPp3zAMFHfU9acgmNKkyvC9Ls/e6t3tH/idmFgzSx4a?=
 =?us-ascii?Q?cipO+o5HFO2BP0UcYeQrGYGkxHEWX5nKIFcrauK0QK9KKeb+HBZhWaYiO6SA?=
 =?us-ascii?Q?6EvLbPpUqsirmSY2U5rhotD6qCVF3MAzgt/2Mi65EdfL3j7yyzIetzgmzKZW?=
 =?us-ascii?Q?FtgcpKLpWz1whzbXXe8sjj7Iw903STPqgahgBhphuhoPaYqCcAZzd1RFh1IU?=
 =?us-ascii?Q?VoJ30rZMHIOhZKIbuCJoBcFthnKu+PDM9wuKzuIXvuUSoRKgZlkkDcGsUmPU?=
 =?us-ascii?Q?56vo7wujhCIyTztAU4KwIVbwbY6KG8P1mdV7cbrGgzywq8z0vpehhwqSOhYW?=
 =?us-ascii?Q?eK2OrDJ9TCaIHrqF9PpvrdYzVAj5/2Z7xDd0XJZNiwxyReYKsKAkNXxKqDrL?=
 =?us-ascii?Q?SE7E9DDVxr/WLILGv5XuCsH4o3NQJIqCwLVKJsfojEmKLlT0LwpqbT/14Vdd?=
 =?us-ascii?Q?sCUvRvn+4nHWjqVt3EcxeBDrdq2kj7bcF/SZR0pT5IWLYL9IHW4cZKpummnC?=
 =?us-ascii?Q?WRKSlTSVdaYQbb2E8R6VikUirxxvZCyB2os89REZiiBVhQMwop6yZWu46FEs?=
 =?us-ascii?Q?e/1vG+yLKiDk78vK9HDL/nqmj7PJFE3n2pXPxkyLaV6gOwTjaxoD7+oeXwht?=
 =?us-ascii?Q?SbYm0R8ADQFRxBUvil5LRgBsJImOOsCzhYWE+t4Cyun/24KW4RNumQRgBm9i?=
 =?us-ascii?Q?drbq7reUNsK9iKrNvMhtW3UCyDEqqBgQLYQ8PeuBJlY+kBPSZODvzYS6+aHn?=
 =?us-ascii?Q?PGzED9H9j8hT7TpoxW56yCndsJrDzC7eUmdfHiNlRdcqo24/Q9+l85L8w32w?=
 =?us-ascii?Q?pjjGGkHKTc6ILS5SlSAiGHMAAZHLKyZb5nFazPx2LuyOL5lMNGs58bNeqRI8?=
 =?us-ascii?Q?f+NwQVm1iI0BkR7x9PzX9ab4YxcXhG83oJZhyTEhDC2eNCFWC/4uixHvoaXh?=
 =?us-ascii?Q?/GC9PL2bFDrNttuOFat60Bk2ZmBTy4a8/uAXQwQg4de+wxINAY3vNiKXSWs5?=
 =?us-ascii?Q?H1EIzaJwZjooU+Cq7bTgnJVDS2yxQmv7SxcKKWtRpAyT4J964o60H6R9XzbM?=
 =?us-ascii?Q?eyQTuoOnJ/+KQbBwSpwaOisA5Ak0CofMJDwmFx7v9dUyJtccxDXl+SwugQXi?=
 =?us-ascii?Q?OMHJGaIq1anGc2oEYR7gD7qkPsR2P4S42oAzyQn+p6UxNFmktJn+WpWQah38?=
 =?us-ascii?Q?aQadtsqokuSJ9bysZgopaDYUlcuVBz0oISkC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 13:55:34.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c56cff-4f32-4aea-7c61-08ddcea796cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337
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

Ethernet aliases are used in fdt_fixup_ethernet() to inject
local-mac-address in every boot for OS. Similar change has been done for
other carrier cards by commit c4a711253613 ("arm64: zynqmp: Describe
ethernet controllers via aliases on SOM").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
index 0d915d496cae..60ac5085f738 100644
--- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
+++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
@@ -20,6 +20,11 @@
 		     "xlnx,zynqmp-sk-kr260", "xlnx,zynqmp";
 	model = "ZynqMP KR260 revB";
 
+	aliases {
+		ethernet0 = "/axi/ethernet@ff0b0000"; /* &gem0 */
+		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
+	};
+
 	ina260-u14 {
 		compatible = "iio-hwmon";
 		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
-- 
2.43.0

base-commit: 118d06f41c4187abae38a45358f4c5cf2e9929a8
branch: debian-sent3
