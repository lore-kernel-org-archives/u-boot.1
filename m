Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20843C27C52
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 08:39:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B40C88458;
	Tue,  4 Jun 2024 10:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O0AFMi+2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5817F88464; Tue,  4 Jun 2024 10:39:08 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B580B883DB
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 10:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=neal.frager@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kE32xBJqee0K3B/HUnmmQ2Nekyuhjc5TTuNehKY4duV8Ib8Jd3RALOrObSTSH85Jq2Us7Y3+/yRgsjRR59VB9detErILMDFQx7lH2oqanrTi32DYJGCkXK5KPA5yc/oHk6EjqWNPCHGWmD61niC6jnVGQjg39YzzPzuAMRgixrW4wySYpdWnV0doLa3qan1st7A3Wmn/Q6zISqji8+veO55wrDHR01MrSGzJTGl3z68cFJouL5PkoHE56Rcx/NrXsMa3Ch054rM+Uqrg9Hxjw5Clr7IGA2vw/gowaRyslpBRwGLkPAQsmEqm1D4jGJPLYlgsIT4XKQ4cisXvxJEenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtYbwv1tCnl/S0TX6IGCnmPwwynzWWzNAOwdyU9xXSM=;
 b=X64CKuJNaaeNOyP832I+CkL8xD1G99ab98BdfYulgapy1CIplCRbNzlchZhohsP+IFpBh7nNc/PS6YmUPeD/3qBP9si0giIrkCws2xd9bSKz1pMP/xOmP8lV5Mg/rdLRoCri20OjagXoYglY5P4HcxwGBoI62HGmLKlOJ0YZvJBvRp8DSB/1qOT8HaiVEBWM5mCs5BcwGoieBuWpHxfOECuIKIqrut9Pf/gH49VGLzkmE2l+90zlrUBIO0g9/SUGysxRnYy8npRknsB6yl052xawPbUu/kVMDgh4Bb+Q9JGGxgq78sj49OGpUeWB46HSrhEue36SRLcTMGsyK5zHUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtYbwv1tCnl/S0TX6IGCnmPwwynzWWzNAOwdyU9xXSM=;
 b=O0AFMi+29ouYlP3Tst0UD/c819LMlwNJY1PnR6L5VXiH9v2V9FieOmwV5cax3aEITHhsrLjgdqlglkegrpO52Cwywo+7MB/LU48XBfSOmPoRxbDNqhOxgHwwgFayqBQeFYlpEUeM2Yc2uvpeKLcxFZv74+hjOZcXoeTCJGnrSgw=
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 08:39:00 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::4) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.6 via Frontend
 Transport; Tue, 4 Jun 2024 08:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 08:38:59 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 4 Jun
 2024 03:38:58 -0500
Received: from xirengwts09.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Jun 2024 03:38:57 -0500
From: Neal Frager <neal.frager@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <luca.ceresoli@bootlin.com>, Neal Frager
 <neal.frager@amd.com>
Subject: [PATCH v3 1/1] arm64: zynqmp: Enable usb3 for k24 som
Date: Tue, 4 Jun 2024 09:38:54 +0100
Message-ID: <20240604083854.2033917-1-neal.frager@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: neal.frager@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6efa2c-306a-4cd3-4819-08dc8471c7f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U5WR4MxbtKzGiM6WfWvPkM1kCDRkrLjlBH2fGMy5sNUSg9AlZWpZJlUUnvJQ?=
 =?us-ascii?Q?Y1z+3JBjZcTr19bu+4W7YeI/K2M8+MC3StIkStUpPPtvd7IVzLisAjBnrKNY?=
 =?us-ascii?Q?cbE+ZDU4qMA39BRbPwM5dFPH1fSQAtH4Q9A1g9dcV2KDmbPSFKiaoQrcr9JU?=
 =?us-ascii?Q?BgACGGiNeGuoF+7omxFN83KOuYnIbpA0PuT+ZcYSWRH1+6d+AdJe7ci4r/8V?=
 =?us-ascii?Q?aIzoGoLlb2nDWmQFAOGCtpONKESZNv/tsiWaJsGbKzc3Q0PPLxyB1iZ4TYwK?=
 =?us-ascii?Q?BOSBMGjdvY4FUgIEUigNwmMORdsyojIFm5LWyqXExJybgmqRtTvWJ+fHPKcm?=
 =?us-ascii?Q?pHpvikt+shYw6WyBT1F87tujCrlw2fP2U4yjKZhdxELVaGD/kI+nxN6U0Kb1?=
 =?us-ascii?Q?sSbqxJfSf09l84fpWfUrkzPf123K0jk4S5XrZvBgPGgHQorFrsjvcVkK5kWm?=
 =?us-ascii?Q?peTSP434O+MfErMS47MvTeZUz6fCI6HnYZUPjNIwKoGwh6orpj2OApGQ5gdG?=
 =?us-ascii?Q?spo0pqfW1RyVEubXtJRak0+Nl//3ZAiIcxnWyjTGocV2vWkBnsyiZBRUFCjU?=
 =?us-ascii?Q?5Qkxsbgb45YoytgSXB/tOCDMSzi6HINrG5qFUqwyzBMycwxnSG7OiCC4xlzs?=
 =?us-ascii?Q?RdBvLzSDf3hQf7Qwr/IMNWfmpbOeqZNZmpp0hrcDZvDPLwi1zhFXVeEHYOQc?=
 =?us-ascii?Q?tVt/EhBeJnwiVsS1Et/TcpkLA6Kl5wLYy4/Sh9MrlF0AP8ucJQT7QUvOwfuP?=
 =?us-ascii?Q?4AaPEtPFMJWkQOGqZPAFBC8vQNzqVCO4TN9M3C+GUT6nZYJIzlfiTsiWtHIY?=
 =?us-ascii?Q?GGhVM6zW0X2BOkksGZanQTNA7AVUvBZcav3hX4iONx0c1JyW8Ls/zSWum12M?=
 =?us-ascii?Q?rkd2zYjZRwMV5eowHlkRTfQ8jPTF/rO74kceG4/IF5AxpAk431f7PhH0GTl/?=
 =?us-ascii?Q?HcDNiwnnyEBvWk9UVS/bOVNYrdIybsnXyXgYObKdihWvfGn2VQ29ShB4pPSV?=
 =?us-ascii?Q?h2+DboxVw5/VBB7JEoIyLKATLaTQ06g/Mx9ZqWz8mAdJ0CP+j6BmMig8BPml?=
 =?us-ascii?Q?BdYy3161zbTqA6EmbhIgschoZVEbNSuYTB6I7KnRsYQ9hRr27x9JnnG5DoZo?=
 =?us-ascii?Q?t93aJps6nQHTiqjbHcpcPECwDvayVyoJJB1V9DXiqlAPrT+wGPQt2srPYNNo?=
 =?us-ascii?Q?l+6xH5zmjsv07ZdrJtHEvfPoQCUdeHpAichIKix0EJtp+AHWLgELTo5Ylx2e?=
 =?us-ascii?Q?uankwouRkClIvjIkvoI+Tq6eLOa41Szzu9B5GIBeAtdNjDfO5Cl52j6IoOsr?=
 =?us-ascii?Q?g3ha21sCc5XvZSwbFqWOwk8xHPqctYR9gea+P2sq/9Cq39+1ILv9NeFgv53p?=
 =?us-ascii?Q?l8l1syTboLoZOCu1upVYGlyV4J4J?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 08:38:59.9469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6efa2c-306a-4cd3-4819-08dc8471c7f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

This patch corrects the mio and pll configuration registers for using usb3
on the kd240 starter kit.  Without this patch, the usb3 to sd card bridge does
not initialize correctly and u-boot is unable to find the OS located on the
kd240 starter kit sd card.

In addition, this patch correctly configures mio76 and mio77 as gpio pins
which are used as reset gpio pins on the kd240 starter kit.

Signed-off-by: Neal Frager <neal.frager@amd.com>
---
V1->V2:
 - rebased patch to latest u-boot master branch
 - improved git commit message
V2->V3:
 - removed unnecessary serdes initialization from patch
---
 .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
index 166e61431b..274203ffaa 100644
--- a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
+++ b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
@@ -528,8 +528,8 @@ static unsigned long psu_mio_init_data(void)
 	psu_mask_write(0xFF180124, 0x000000FEU, 0x00000002U);
 	psu_mask_write(0xFF180128, 0x000000FEU, 0x00000002U);
 	psu_mask_write(0xFF18012C, 0x000000FEU, 0x00000002U);
-	psu_mask_write(0xFF180130, 0x000000FEU, 0x000000C0U);
-	psu_mask_write(0xFF180134, 0x000000FEU, 0x000000C0U);
+	psu_mask_write(0xFF180130, 0x000000FEU, 0x00000000U);
+	psu_mask_write(0xFF180134, 0x000000FEU, 0x00000000U);
 	psu_mask_write(0xFF180204, 0xFFFFFFFFU, 0x50000000U);
 	psu_mask_write(0xFF180208, 0xFFFFFFFFU, 0x00B02020U);
 	psu_mask_write(0xFF18020C, 0x00003FFFU, 0x00000FC0U);
@@ -569,21 +569,16 @@ static unsigned long psu_peripherals_init_data(void)
 	psu_mask_write(0xFD1A0100, 0x0001807CU, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x001A0000U, 0x00000000U);
 	psu_mask_write(0xFF5E023C, 0x0093C018U, 0x00000000U);
-	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000000U);
+	psu_mask_write(0xFF5E0230, 0x00000002U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000001U, 0x00000000U);
 	psu_mask_write(0xFF180390, 0x00000004U, 0x00000004U);
 	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
-	psu_mask_write(0xFF5E0238, 0x00000040U, 0x00000000U);
-	psu_mask_write(0xFF180310, 0x00008000U, 0x00000000U);
-	psu_mask_write(0xFF180320, 0x33840000U, 0x02840000U);
-	psu_mask_write(0xFF18031C, 0x7FFE0000U, 0x64500000U);
-	psu_mask_write(0xFF180358, 0x00000008U, 0x00000008U);
-	psu_mask_write(0xFF180324, 0x03C00000U, 0x00000000U);
+	psu_mask_write(0xFF5E0238, 0x00000080U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000400U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00008000U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00000010U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00007800U, 0x00000000U);
-	psu_mask_write(0xFF5E0238, 0x00000004U, 0x00000000U);
+	psu_mask_write(0xFF5E0238, 0x00000006U, 0x00000000U);
 	psu_mask_write(0xFF5E0238, 0x00040000U, 0x00000000U);
 	psu_mask_write(0xFF4B0024, 0x000000FFU, 0x000000FFU);
 	psu_mask_write(0xFFCA5000, 0x00001FFFU, 0x00000000U);
@@ -591,13 +586,15 @@ static unsigned long psu_peripherals_init_data(void)
 	psu_mask_write(0xFFA60040, 0x80000000U, 0x80000000U);
 	psu_mask_write(0xFF260020, 0xFFFFFFFFU, 0x05F5DD18U);
 	psu_mask_write(0xFF260000, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
+	psu_mask_write(0xFF0A0284, 0x03FFFFFFU, 0x01000000U);
+	psu_mask_write(0xFF0A0288, 0x03FFFFFFU, 0x01000000U);
+	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
 
 	mask_delay(1);
-	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000002U);
+	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0000U);
 
 	mask_delay(5);
-	psu_mask_write(0xFF5E0250, 0x00000F0FU, 0x00000202U);
+	psu_mask_write(0xFF0A0014, 0x03FF03FFU, 0x02FF0100U);
 
 	return 1;
 }
-- 
2.25.1

