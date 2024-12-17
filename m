Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A724AE7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 21:36:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C463680295;
	Tue, 17 Dec 2024 22:36:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="nwhXXtxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47AAD80250; Tue, 17 Dec 2024 22:36:20 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 286C080107
 for <u-boot+nodisclaimer@lists.denx.de>; Tue, 17 Dec 2024 22:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xscP9+kCRokfPSkyeqWahNzGn6JLEmFuc7bEIDfVW2eYXShnIF7kjfRzjE8VHtoS/bwLqTZOEZ4R+sXP4+CP4ACRrZplHnp4E4tCtHXmfYAFqXOpm7Fin3/RHd5/hvFRtkAwV+1bulRhr13cU1SqfEgb2V8x/oZ12b+RWQSKblgcUzujj/t1QO6nHck+QWXi1Wmygjh+A9COMvh5GNYveE+Zh/WWvRAikVEr123CVI9Q7A4H4zE42jH4TtKgWtKvzKpJ0MJZtukhPwwWI2bb5YnZ94nerQMmNz5AHVLYJFxAZcNTZbbCLk0CpJEtTlS7Wxrub3eVmJ6RRhBnG73FaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=ivbJ3hgrb5A8CGIg2eQZs1U2gyHacvngA1cTXUR/S4G3XnZ+y2zz0DVNR2GtxE13BWWGsnKbwzQ94s1IkS14GGgZdbrE7WgzbQ9RP1TlH5ru3mpqubKA823ari+M+5+BiSjCGYMsuexA5jpUcLOMahrojfoDZwZbmK+LTkyoLCD1L4vwS7w2R07uI+pUAHJ+WrRU/8/oxsSfrVqUoxoTe2Dokz+QkleaaGei0rAyrZX/zO+gj5hsOEWmPk5T1Frbe8OwYv+/R5TWmko6hq7ZV8lRSv31DTxmv1mv0vd51Fun4iRvnYU2A2OCHSTHyI6a+klhi/AWGMLprBsSNRFAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9zxPABgNtn8TEy3f7ndOaLMehngj+o79iSXDAkmbYA=;
 b=nwhXXtxByGHJgBbKsXwHna0qQ/CLEzlyXBsmSPwS/ZHyzmkVFzBKNBQ+cjCMYKx+1nMbN7ub2zb5Kwomjo8/FWabBAkq3DUv1MumRunD2+oiAyICpF4KoMpad7AOkctdK4/3VxBj0leLYQmda8BkLAsRokRp4QLZUVVuOuFRSAH3C9W+TomxKMHAvxKJ/M4sV4hxENj2oIxHFzyU+3VYSBHozXTo+EwVF17hh3Fp79/Fbdsw89mhqWtwzyo3Re5+bw+u0p15Yb/yyhQndYgVdKbf3Lm7DMq5dFiYjUnqED8LphQfFrU0qAKCg81q8VmwP5xoeKeHgr5TY3/VQiNIug==
Received: from PAZP264CA0074.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::9)
 by PATP264MB5348.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 21:36:16 +0000
Received: from PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fa:cafe::b6) by PAZP264CA0074.outlook.office365.com
 (2603:10a6:102:1fa::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Tue,
 17 Dec 2024 21:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FC.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Tue, 17 Dec 2024 21:36:16 +0000
Received: from sah1lpt571.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 258E9202D7;
 Tue, 17 Dec 2024 22:36:16 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: sjg+nodisclaimer@chromium.org,
	raymond.mao+nodisclaimer@linaro.org
Cc: u-boot+nodisclaimer@lists.denx.de,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v6 2/9] tools: renesas_spkgimage.h: use
 linux/compiler_attributes.h
Date: Tue, 17 Dec 2024 22:36:06 +0100
Message-Id: <20241217213613.286813-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217213613.286813-1-philippe.reynes@softathome.com>
References: <20241217213613.286813-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FC:EE_|PATP264MB5348:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 80a5a89b-dbad-4ca1-32d6-08dd1ee2d654
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G0/QVHiEYJD8VW4VFdp5coiYN5MXQyeKBxLiaaf+GABrdeWCEFwxq+IlOAdm?=
 =?us-ascii?Q?ZXLsGiVvuhFolNdrB+4E7nAFtnxtffYq+3so9WSrVuZMsvsiJ+PwBo5+7GJf?=
 =?us-ascii?Q?xHnEm2RrqKlfKXrOYp0qKkLrNL0spxj+8N1GC1WvxbbkL9fnAt7W12jiBMsa?=
 =?us-ascii?Q?M2/lLEfbsP2R5yqv5iYzZfQXsZD8zpB/Fc5ZWDCCEoYfvxQFBT2yvFzCS20D?=
 =?us-ascii?Q?5Mjz3Y6ogzU7ETrGCIF+4zafYNT0j8Po1ZrLYV4pISrvIBg4ify9jhTeweb/?=
 =?us-ascii?Q?siBNeTUZVa2KYIM1eE6uDedgdHTKW8Oy8wTO6l+NlYJ7ZJSM9rmLPDO83b8v?=
 =?us-ascii?Q?2ra7CYkRem8Xw/3biomPtwLUpc01NDVVG0AU4J2X264hrqaxLCqyfbfIukt6?=
 =?us-ascii?Q?xZjBwMSR6S8eomH++zNMWB055G/ZgUSzO1HMZuxbFWSDIodoIDjkBZKPxDLc?=
 =?us-ascii?Q?gesWZyXW7mJWpYQIe0gwLpMEocJD6BiehKVITCPHz1lekTdeCjUljI2hAxgB?=
 =?us-ascii?Q?cBOAlLpnnjoiFZdA0/uWkH1XeskvwaJmx64hYKRxlDxi7vq0EByZUbAGwi9p?=
 =?us-ascii?Q?Q5z3v7Inow4ybjJ4k5D5sx9QPWMKiDxv0dsqd+C+8CEGH5oTWMkLViK5S39e?=
 =?us-ascii?Q?SYaMu3QHzlT/34aUj3pE/KCLM/yuJQH+CKwmdWyLkkKRLWtIt4O7wgUrDxMh?=
 =?us-ascii?Q?5b8klg8xYHWKl59L72528bytwWhE3P7HMajysDBNHwP6ba/SRUKqgNj7TdSt?=
 =?us-ascii?Q?9erDggva454gyiZxSK4HPxynBec5G7zd+pPNbbMiCVd2brLC1Z27vdR/HAqO?=
 =?us-ascii?Q?trxgRoYp4SiQGOC1fpfxeh4+4gNIU56HCEuCDS7yO+SyDIxJCoVPuL1LY7Hx?=
 =?us-ascii?Q?CFiGj3Ri5e8RGee3jkGYoZDZi6eKh5Rx2WE/bdNv1S9KV/5Pt0nYFZ/LG1dS?=
 =?us-ascii?Q?5IzqeMuLcDkfDU0CHDFvRSt6+ABbq+tqohwDN6w+nZ/O66Aui5yow7rMxPLX?=
 =?us-ascii?Q?BmKOQhSNmWNBcxV+1QdzuhjborBUh18KbWcJSMpS8NccHI/kUaZM2qfQT2uC?=
 =?us-ascii?Q?ntKtVkPqtDbLnA3lU4KDHjclr84rGS+qBJ16pnYshHh5/9faTKZ64Ty+BLP2?=
 =?us-ascii?Q?WvPkE8D2eq4l2qt9Z8J70f9bOChjNahp+HkffqeggMNOawl9j/2+pUl+fAOB?=
 =?us-ascii?Q?Vyc6lAURRGuSh66XWQpmMzahHbc2Zz0CAYQilPDxpLhypFZwprkCli1PYJuY?=
 =?us-ascii?Q?+ovX2pYviTAUGLo7X85JRPTMT97J0zEGfiI0o5KTeq84oVqpiZ/DsoyYhiGi?=
 =?us-ascii?Q?oadG5Gezz8+N6EyP1NvEb7n65FyY5+0nglwvbUu7zbu292uioMPaa1uuMafS?=
 =?us-ascii?Q?6U+6BaEITCOZ35S0nCSggQP3aSP/vpM9iDWUnCAobqBi9Op5owbCylk8cIeF?=
 =?us-ascii?Q?6qiPg9SFe3rr5gS+o/Iy8B0HHmG+WeB0hYqwTvsecv1h763AKOAEzfYgM+14?=
 =?us-ascii?Q?Ti93IQfHjYnZpB8=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 21:36:16.3294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a5a89b-dbad-4ca1-32d6-08dd1ee2d654
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FC.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5348
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

The attribute __packed was defined in the file
tools/renesas_spkgimage.h but this attribute is
already defined in linux/compiler_attributes.h.
So we include <linux/compiler_attributes.h.h>
and do not define __packed.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
 tools/renesas_spkgimage.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/renesas_spkgimage.h b/tools/renesas_spkgimage.h
index 367e113de9d..83ec567b0d4 100644
--- a/tools/renesas_spkgimage.h
+++ b/tools/renesas_spkgimage.h
@@ -11,11 +11,7 @@
 #ifndef _SPKGIMAGE_H_
 #define _SPKGIMAGE_H_
 
-#ifdef __GNUC__
-#define __packed __attribute((packed))
-#else
-#define __packed
-#endif
+#include <linux/compiler_attributes.h>
 
 #define SPKG_HEADER_MARKER	{'R', 'Z', 'N', '1'}
 #define SPKG_HEADER_SIZE	24
-- 
2.25.1

