Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461E2C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9289E839C7;
	Thu, 10 Apr 2025 09:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GmeNrv6H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4643E839CA; Thu, 10 Apr 2025 09:35:56 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFEEA830E4
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:35:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHjQ/2OUMZTf2kHyAN5h+QGxe9OZ/6eNt8r+xFYJMwc4X7jKAYB9CLHPD+mKRXzX+svO9jSuxpove8eIw+WF4Q4nlPqAhWyOB5LjnAxIoSm2FoFtR3815gLhOwKkeSIGCI4Eim47y4nmEXrzIeVtF+P5WDdnAfWwsBy8O1bGsUMoPTmFo2Vy2HOsnZlvB4cqqCSvprntvp5o/JQ5AVJdH2hDyrMsSbfoT+QLw/dTxrLewRmxKxLZ8WHocWsk9cjfSmt8mcHYCzLAg3s3CkmM+QUp4W351Zt3wxNuQlpeTE/N5bO+JHY5GohzkVdMjvtMTgXvcNzJ3RQul3hwJDo8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZLvgTAi0XCMW25z48jBB0nfsA8e14rQvE1NHZy7KBM=;
 b=IFRTEiklRpTc/JC9XrtYnXKLd3kEp9mWFVq2A8MBiicS/0yH/xnB0pyk6izp5WiGd4YJaRjHETa2HynYIoWKJ54kzKQo+aG6b/Oajs+DqnfJcvxAVbXR/BSgMiXQKS5pOYaDoWQ7e4UsmH1MfsCjBwIZ5VnbhCfgpSp9XD8MrUHgEyaHSmWcwHOFBf+L9tacYTbnfY+lY8PRH3v0xh68hT+yZl4qQC07gTLWc3Bu8iIzc8TeUELQkQ03wq1vAegmAcrJ+F7wb3OpZPhAeZbhhyv256CkwT7BWLZOofdydbBD6OUxLil5AyPmK5QomhmQ3nHFM8FLMgH9lPCIDq3hnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZLvgTAi0XCMW25z48jBB0nfsA8e14rQvE1NHZy7KBM=;
 b=GmeNrv6HrcHw60CNDl8oiSnrF6Cl+qjQvF/riKdVMHIqZQpfhSTFJqljxSItATdxnloi0skEdPI6MDED0cgVPeLA/OnIuNtS4tfL+zAp5NZLOc+1F+O3yXy98NPMzsERoZ4HHjylDcxUZTHzjqkWp6HM/0Pa2Dy7atIzK91LZiA=
Received: from DS7PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:3b8::7) by
 PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Thu, 10 Apr
 2025 07:35:49 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:3b8:cafe::26) by DS7PR03CA0002.outlook.office365.com
 (2603:10b6:5:3b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Thu,
 10 Apr 2025 07:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:35:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:35:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:35:46 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 02:35:46 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] amd: versal2: Enable SMBIOS command
Date: Thu, 10 Apr 2025 09:35:36 +0200
Message-ID: <c1e236003c6ec250dbcc5178c873c171fffccd29.1744270535.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 311b58a1-dbb8-40c5-2205-08dd7802502a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dyWMOzdu94DrLJMWH9GN5+adOjfREFzBkQ5a/YuPWPabrGvMwZwYNkizIayq?=
 =?us-ascii?Q?avRN8fV1PalDnwNgEXSD103jOh1s3TuO1IHGAewLtqqbBZ9IkDp5fXFMzGuO?=
 =?us-ascii?Q?FREwgjKZA7wEG7AGpzwx0Rq+5GfhAIyRw/pEg5KPC1qy4Fds3SqQnZlSkPY+?=
 =?us-ascii?Q?BYhAZeoHV0cWci51rHDavScsH+14UtRdJn8fMu456fX1umi8zDguSHV9XlSl?=
 =?us-ascii?Q?lSL2N4uIT6bfh3buAIDF2YCwHtHcjw/mRBa9dIK3Jja2IrxUa7mi8RPIoRsY?=
 =?us-ascii?Q?fgUDUk7lxn1LeN+ScOlr3WLzQDVTLuAtVMKK24XcWhBQSUm8ToizgoE9IKVT?=
 =?us-ascii?Q?Voowq+kPM+Q9ofeijzP2HqmtOLfTXjR9xTetolS9q02v8hO9Fi+SCmlIFjMS?=
 =?us-ascii?Q?fhV2QIc2WmbNS1tSPE88TOlJyx0Gj72hMwZwM/t3xQTQL5IA6Cy19CyeeRYR?=
 =?us-ascii?Q?qgNxJKxxHhWb/JHra7QWwVAejvXAWEDbLo0xGIKZznN0yiwjpDborKvG2Sfk?=
 =?us-ascii?Q?OrdKEfNxn5/xt0MxbF8inqQLy4Ru08Lf4cdlG+T7Tn2h8uNUtEVS6I1Q36CZ?=
 =?us-ascii?Q?kIczKrwZpeqlreX4rgJhjUYC8bEDole+Pf2kpHez23lijhi2G4DHcEqJ3g/t?=
 =?us-ascii?Q?Fm0k2dyjPCMhg5ry35yfLgrUJmhPV4YD9JCIAk0TuGgVl09fyXSyXl9ulx1z?=
 =?us-ascii?Q?W5TwNejauVM3GwUuRtasc6yJzj9/NE2G8Lb6MBg1A9CNqQ3ANg9E8yyCI5kz?=
 =?us-ascii?Q?LHJS8ml63cuPfNHNpnzpBYPmKlWciuX5X4UA5tq8vcM0g0Rc1aTr1zeUu39b?=
 =?us-ascii?Q?dE6eRZCHLSvl73I+S4BRlHSMsTVX+Qej019d+Z4/tD05Q5EEETokbSzvs/kG?=
 =?us-ascii?Q?MpjtgRY//eclXCUIfrO7hA/ElnfrIjMos1Ty4gMAW3OfR/2NtjmPGvNo/OfQ?=
 =?us-ascii?Q?KM74CCjxDbJdIUqoCeoMv29z7xSsrCpl/RSA1Enjk1/R3F0BryB8IlccnhCh?=
 =?us-ascii?Q?mRsmyowfGo4LHj8VMlIe89ogczpFkH/PdfYRhaVc6YLPgpH1Y5TvZtVQrSFp?=
 =?us-ascii?Q?omSVgYN2I7KppMU9w8LntxV+YVMs/cEE0bdjusLdcTu57zcTSxJ/qezmYQgs?=
 =?us-ascii?Q?r9m+ZO9J3a7J3r7Q9ASb7kg/WN8+3htafIGKPBkwUCVgZr47jxg2PZlMhtUc?=
 =?us-ascii?Q?YGTpzTgfGHpLIHm1S7A9GrqBle53ARtUNh8MqstwdJ/TU89r5om7sA3auP0S?=
 =?us-ascii?Q?XEL2oeUMl2XM3aEoVjyLZqlI995ErCTOL/QdpVuiOTGanjpiS+8USC9n7u5c?=
 =?us-ascii?Q?wQcK0ouKbkzIKEWaYlyG2Z6NKev8I//Sq5GHwCIcHJb4k5KTDpsMjckUUcO7?=
 =?us-ascii?Q?vxVeLFL6OWts3e1/HTfnbN2XUzlbRNTz/NUpSZcii73jLuOoBnqbXXJqPRLu?=
 =?us-ascii?Q?RsvjLnvUnYYaNaLlpujezfInSBdiVZTNcTwEQIBFU7Vz+4rlJqcnIVX20pHF?=
 =?us-ascii?Q?tLgyjlFQJO2KO5Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:35:48.5747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 311b58a1-dbb8-40c5-2205-08dd7802502a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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

Enabel SMBIOS command as was done by commit aa815e6c7603 ("xilinx: Enable
SMBIOS command") for our other platforms.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index e19d0b5596ab..d722f3c811b4 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -25,6 +25,7 @@ CONFIG_SYS_PBSIZE=2073
 CONFIG_BOARD_EARLY_INIT_R=y
 CONFIG_CLOCKS=y
 CONFIG_SYS_PROMPT="versal2> "
+CONFIG_CMD_SMBIOS=y
 CONFIG_CMD_BOOTMENU=y
 CONFIG_CMD_GREPENV=y
 CONFIG_CMD_NVEDIT_EFI=y
-- 
2.43.0

