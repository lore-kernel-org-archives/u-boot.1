Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC139CDD1B2
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 13:59:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26A08908D;
	Fri, 27 Sep 2024 15:59:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zCdfo1/5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4E28910A; Fri, 27 Sep 2024 15:59:48 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::61a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2ED988F32
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 15:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vULor5NJmo8njlL4KLivmJ8D9sOW3Yih4Rzcl8FW7cWCbDW7i+OhNTKgCzokAYm1SqHVnu+ciVu22ATws97fUhEiWq+3sQdCA8MkSWTC4Xfpb3hadTpKaEBo0mwZEYb1qfF6yYtZ9tEg1yaZmDMuHe1S/xmpdkZzsja1CMJZuyDDh1qSrtvGCI8gcHwpqwM/YQjV/Iqq4Yn6qFmKFCe73G02DgiN4uMxPoUz5KnFnBxw08324+2a66CGJq+k4zhDbtM+ISKwJ1E7kYJBM7OrQByxPvyuMfMyFn/OlTNAKZcB+GFIgi4gapX367UqcYGlVu1Zfaco8r/Nnesk9vFzAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO2/t9+06dpJiX75U/+zPoM5+kVfH/+8eQMTqBZBJq8=;
 b=Wng4tJVoGrJPYXgMTS2yIv842HYM6KacUGL376Ma1WNp4B29lzQCG+haljMOVJZHLE8QVSBoyDy/A3cWgx4DU+WDyThRvP8rc3cxt7vHmRl8V0/6iaieL0irn3g1xdQtgXicwwZt/o0xzKdHVh0YdjDghFQzkHK9drRKQRjzRbTTmxloEb/GrmJ12f+xE/iEVQipkanW7z8khU5eHpyd5PuPA/kltVeqy1ckos8GRYQQbbiiTUjGPjE+cbgBZHCs4CPGj5Zi3C9GS3oZT8FAIPDrm5EJJel/kVmE6+SDwQ3/FDLUd9PKG/rmMpCExMimERHODKGnyc9j2SVaOPVkIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO2/t9+06dpJiX75U/+zPoM5+kVfH/+8eQMTqBZBJq8=;
 b=zCdfo1/5NkwO0GrSoYEHY29Wh+8WUtD5J3+amgLA/+frIHuYTLyBcJ/4OqgsbtedxUW7RBrWTIMfaVDsnDObTtlUPXqp49b/RoOqfhCY2b6tcq6xAHZibqUkU2+vusAZDTCkCsqwizMKKu69vRKhQHjI7UokGLAU4i/CzgT3nNU=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 13:59:39 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e4) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.14 via Frontend
 Transport; Fri, 27 Sep 2024 13:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.0 via Frontend Transport; Fri, 27 Sep 2024 13:59:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 08:59:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 08:59:34 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 08:59:33 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>, <git-dev@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <Prasad.Kummari@amd.com>
Subject: [PATCH 0/2] arm64: zynqmp: Update zynqmp tcminit mode
Date: Fri, 27 Sep 2024 19:29:24 +0530
Message-ID: <20240927135926.438450-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e4304fd-b063-4dc1-b704-08dcdefca039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p/ZPsSg+I0AU5EHugSnCXdy1cPzOJCUyb1zThgM4dq0JZXJ1LhIg4H50gWMS?=
 =?us-ascii?Q?ocOTDIEw/lDlqtB02x8te3e9FmRToZlMRhIRLI1sqVRPZT/6q0/PnoRdTNtW?=
 =?us-ascii?Q?bnX1a5MFefLXd7qhEkxYi625KzXAzlTM88UVYc3XtVelawmwOzpxd0Y/KGt7?=
 =?us-ascii?Q?7J6V6KYey5/jYiC7kKDrOpe8dAP28RYt4z0yuPHkfbJUa6snfrHBHrY0gNcr?=
 =?us-ascii?Q?20Sm9MJi+JAhLTNNjvRqpkbJ4vD+LoNZ/KwKpvMtuqSk7mxPhuhMkqkDgRC/?=
 =?us-ascii?Q?nnuh9ZICbmhDu2qQB28bDVa3CKru1T0awmEno0aD34QFcWqj6FWS1cmizJkR?=
 =?us-ascii?Q?f88g3J1lDZLkE9xfYSIFJW9mMkJWzJRH+jCKOkZra2roOdq2RrhDy25K7nFg?=
 =?us-ascii?Q?8sMfw30U7zHMpBMKcO7v3UUUt8lBZjzGHrmwoNCKlGnGy+1pEL38edMmwCTO?=
 =?us-ascii?Q?2iCbyKBZ4YNSFLHCdlkJD/r5q+zwxlgNYQd/DdrH4drlQfDiXA8UYTB9BZkV?=
 =?us-ascii?Q?MYC7luuItgK6QFSR42tHQpURojjpEUbJ8sp4g2tOJVvn0R5lhuCO0Ch5vCMI?=
 =?us-ascii?Q?gA/d1VCnkAAJnLsUreK4f/lkVlao+NrWhw6rlaOMvVSj+OAaZm+4k9R1oWWC?=
 =?us-ascii?Q?OUc0v0M3DKmHziJTdi/KTVXEcFkQzJCIXknM5jw3wuF3Iab9hRcXYi6aQnr1?=
 =?us-ascii?Q?wSQvKmuKU6OUYCxOIke4om7UgW5nE1m5rQWnzfGe+qp5OLV+Lqu9qlBu0n62?=
 =?us-ascii?Q?LM+X7CdTu8O5Qt0jeRiQjMLc3b+c93TKKBUy1ecMaIYGj42+fkjymMEbuTma?=
 =?us-ascii?Q?RU/l/InUMkhRscc3TYZF84+OBDUSuV+A+oRdXiISDICj2vaKwYfi6K3LQqhw?=
 =?us-ascii?Q?EL673HGgYy4pUSKJX1bouR5X7C9sXYhk59dsL1M/xr6zqojnDrCyKQ4a8C+D?=
 =?us-ascii?Q?V+Fh1HaOcGEjdNqedUa7CsH++s0scdfML0WVb4PwEbpiHa8UJZ+Hv38iScc3?=
 =?us-ascii?Q?8/4oLDcclJlCuL8MEvf5NtGdsXcxTocq78CYl55nXrQGjdz+gR5z0XJh6GBz?=
 =?us-ascii?Q?JJxoH54GSfpDZswQZC+Iv5GrYuRV+HVFoPpKGDGCLckxKksDoUMP4As2t1Iz?=
 =?us-ascii?Q?SCZvnED9oRYH5E6GhxY3EoUSw9uyxuETPpsplM1daMUr5S8mtC6jgWZQr0fs?=
 =?us-ascii?Q?acGex5wfiW6vg7Z1o0tV2hwyMigasB0gywgg46zck1DO/nvn6IXOTf09Nsqc?=
 =?us-ascii?Q?b7/wicEujkI4KCogXtnGcMJu262//LXwFWr/rIFkv8mEXkmSZiqRlk0zcaI2?=
 =?us-ascii?Q?QkJesl1yQHnuZtV7szL+Ww6wQNzBtAxqPjScquLTlzx11i1TKYpQg8sZB3wW?=
 =?us-ascii?Q?5bLGZnJPHkTqeCNnDewl8MB82yWo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 13:59:38.0405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e4304fd-b063-4dc1-b704-08dcdefca039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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

When cpu is enabled, the zynqmp tcminit throws an error message
when switching from r5-mode "split" to "lockstep". When cpu is
disabled, the zynqmp tcminit switch from r5-mode "split" to
"lockstep". The mode value is assigned based on string compare
for "lockstep", "0" or "split", "1".

Padmarao Begari (2):
  arm64: zynqmp: Print an error for split to lock mode switch
  arm64: zynqmp: Fix tcminit mode value based on argv

 arch/arm/mach-zynqmp/cpu.c                    | 16 ++++++++++---
 arch/arm/mach-zynqmp/include/mach/sys_proto.h |  1 +
 arch/arm/mach-zynqmp/mp.c                     | 24 +++++++++++++++++++
 arch/arm/mach-zynqmp/zynqmp.c                 | 16 ++++++-------
 4 files changed, 45 insertions(+), 12 deletions(-)

-- 
2.25.1

