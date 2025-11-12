Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71322CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 10:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE6E183C46;
	Wed, 12 Nov 2025 11:44:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NARQv0en";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DE1483C4B; Wed, 12 Nov 2025 11:44:12 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CC8E83B91
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 11:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJtlTioPd7BO0z/BIZHQAK8p3IGZVKP1uMzRIyJTU8nD9y9fXEr1BqwWCxbUmyE7dJ2rR0cOWw6ZLFD7n8J3dVZ+bGCre1iNeBIKWDLxK+sRoovQ6WvPwxVNaofXRdD7fuSXzRUJhDT5AanBT+F4bq/Kq7zJCwQEG2bxu/lPX3gwZveTVex1PrhyHZL2HS6RyiPwBO3KVQ/+/YxlnPWd1rBqM3QgepQwbG1U59KD3u/3NlUqagNtAwTGDgx+Gu0DklPSvr8K8+dM3QQjIk1vMWRMtlp/RG99H4l4w20QsRUeznmWSTwtmV9Dj/2mpQBzGogy171KWI5uzPcx++ngyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Zpp/mAfMq+/ofUvZbapQijtYwlB0sCYGkhL0RWDsm8=;
 b=d/DRJcrA2mKHQhTQ/3EtuGFaXgvs/ZkSvh+zdsdQSo87F+pl7JtwhZ9zd+z665dSMLnfPqZWmJLUFynsJo5YxuGzPxvQBf3UU42/Yr7shzjbNrwnFF0YriyVeIS9HvwOTHTwBCgjhrIWctdgneoF3W6Dzf6PNr4M/bVN9vrvkpgpP0ers1WpqJB/sdcB6bE6Akz+oA8Gmg/jFYhBSBm0vgZ/ZvT9aQwT1zXZn4U4Q76T0aTzsRT/uptUknjOLik1Ug/fPsg6PjQ9pkdqXeVB/jDSTZaYinG3bVA6QSdefybjlZsDVOJnoXiVct87HJiGVipM1eWd5EKhajTP8TSjZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Zpp/mAfMq+/ofUvZbapQijtYwlB0sCYGkhL0RWDsm8=;
 b=NARQv0en8IwFA+g6FD/CrTV2GeaZxHmWbbuklHIX6B8chViHK6cc+yUPm1sLe2SEMQjrtyzviXoUWz+3D7IzPAkqlFLSGXgfgZQKeE5ITUsDlScJ2C0dhnmpefWYGBl3maqn41AhGrRKI7LTKu1XbVL6/ui2saHv/81kCIHpoeg=
Received: from SA9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::20)
 by MW6PR10MB7658.namprd10.prod.outlook.com (2603:10b6:303:244::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 10:44:06 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::2e) by SA9P221CA0015.outlook.office365.com
 (2603:10b6:806:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 10:44:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:44:06 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 04:44:02 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 04:44:02 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 04:44:02 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ACAhx4Z2518388;
 Wed, 12 Nov 2025 04:44:00 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>
Subject: [PATCH] doc: board: ti: k3: Update TI firmware repository URL to
 GitHub
Date: Wed, 12 Nov 2025 16:12:17 +0530
Message-ID: <20251112104218.487754-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|MW6PR10MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 352ff512-e397-473b-2520-08de21d8674b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GnBQFzM+d2354ktIEVhPcA1OBIoTonOn/uYEC1AbCFucHPQ2rlQGmbd4w78B?=
 =?us-ascii?Q?MYGqedncnBVRPb3iKosglnv2PC8zXTFwtUNk/WTU3VakRViSz06fLZ3BzaAK?=
 =?us-ascii?Q?MI0Bjsp3BwJsDyELVIplvwx/P8OFJDz8d7NklY/EORN8zeCkAcBTPnajCIjS?=
 =?us-ascii?Q?vmqRaDdN9+LaMnIbEsGciVpLHnVTkdnKpN3tCqrqgushPoQCHB0hAVE+TwgM?=
 =?us-ascii?Q?B0INijAZRS8I5Uq4Bd+JOnVzSmATQfouKHBGDjVL2xrHQH79oceE+/rjY7sj?=
 =?us-ascii?Q?1POdydUKPk8WjkskFQNDQ71bZL7Yw5MyAnsoKfE15EhszHufZYeu+sC8BYij?=
 =?us-ascii?Q?O6xvVWFg5D5Yn0e9mbO++KIFE1unVcr3N7yYU320oyQr5IBizgcTKiJ1Bt6L?=
 =?us-ascii?Q?XwSJ+lj5/K3s3gwrIj5imWEMjVLjgwX0I/NU1B3RYpSGPDOJ8u8OfpjjrWQl?=
 =?us-ascii?Q?4jiENMqWJdzAePGNZZh0+VU7BeOVv+L/5beRrlqhKyX4VuclzbXgChHGjdeH?=
 =?us-ascii?Q?0QdHV0AptE4XwKHI/u6NUHkENtbfJqH6BCIaGkOGF7tOvChAiRBALBggONjA?=
 =?us-ascii?Q?1Hyp3ov0irF6Uquy+cCapw+H/+4Nkff51n3jAHguOBiN/HSCseeOHfTn8B9p?=
 =?us-ascii?Q?WmHvpUICKDJEtLmfgZvge1FfclyDN/GT1AGFVtPwp2XbIKkeJB/e+GX+NRGb?=
 =?us-ascii?Q?CsNueL/wzOzhVPGeekhT60LNeCuHI21k3fwDnfebZCnNmB35Pm7J9oJwgGy7?=
 =?us-ascii?Q?bR3n92myQr5HYAsChbEfTdnHpXNO20DIATuvRN6HLl9ms1OkfodbSqe3IZHT?=
 =?us-ascii?Q?ZD8m9x/pk6lgRFzIbpsVYIxx1+RnetKaV0OIpus6uV5TPnLrH+X7tNd7E9jb?=
 =?us-ascii?Q?SHnEVaPjrCPymVlh4eFcGB9Ml7Nv36biH3oOnQdVX+fgHVExdMxhac6EbSpA?=
 =?us-ascii?Q?XRj9D7n1lrCGDow06GVrdSljqdX2OKDD1igIchbSFBAWDFOcJz0VR8AAn/gb?=
 =?us-ascii?Q?8LfmyczL5M9sWpM4VWZQDu0WGP0uDelQqA+6mRJYC09AlN4QX+ul1kCx5eJb?=
 =?us-ascii?Q?cOUgex5d+xZGkFEE93GmAywwFq6y49PYyHkNKnUBQ33p8RuTtTx14qRTjSHG?=
 =?us-ascii?Q?dOgB1tj41d6hHYloUff1aZu9SJ6lHCCOtgnZobowQBtCZvzpBF/yzruKNYgQ?=
 =?us-ascii?Q?hsxAYSaIFgQqn/JnrgS9apiKf/DHJTL4JM+J0qL/UXlYD6IfMfVYsy9CkRF+?=
 =?us-ascii?Q?KGAzNGf281XtlO96jPZ0b7PWP3Fs1uSafXYTj8ilddmh61yD4ZAvP+KFNSwY?=
 =?us-ascii?Q?FYRLw+znl17DO4//MMdLReZhDN9XVe1hhNTanVNIF2IzPNEo8nTLOnOXyUp0?=
 =?us-ascii?Q?puuN9d05WzydFrwP01vHNSAm0RBPvP7vsX7+S1pplDtshexaxyTrUxhXw7ZI?=
 =?us-ascii?Q?sGJux+BQ9VHsCrg+CcS+CcU6Yu79Moka2Lq3hEXcu2FZI6Ih68exSCEsJQAG?=
 =?us-ascii?Q?O9HOFT3OuRkC/i1IgQjPC+e0P5sjK+fyZGCN?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:44:06.2368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352ff512-e397-473b-2520-08de21d8674b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7658
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

Update the TI firmware repository URL from git.ti.com to the
GitHub mirror at github.com/TexasInstruments/ti-linux-firmware
which is much more reliable.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 doc/board/ti/k3.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index 01fb94116887..d9d802393923 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -183,7 +183,7 @@ online
 
 * **TI Firmware (TIFS, DM, SYSFW)**
 
-  | **source:** https://git.ti.com/git/processor-firmware/ti-linux-firmware.git
+  | **source:** https://github.com/TexasInstruments/ti-linux-firmware
   | **branch:** ti-linux-firmware
 
 .. note::
-- 
2.49.0

