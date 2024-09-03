Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D55CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 11:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7F488A3A;
	Tue,  3 Sep 2024 13:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5krzc3V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4439788B9F; Tue,  3 Sep 2024 13:52:43 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4EB388A0A
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 13:52:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQd8LcDkB6qIbIsHqPys/h0HaHagwrkgKum7WbSDbMJnzzmRDoGzP2JmoTdoVuEfc3GqxUC2bk4+fyXPnQgd3obKqMv0O0nVAzPl+V5waRqG/Gw96YJc0nBn2x4MPtAnutD5wahbeuveDysW6kheBEEufuRsb9z8Ep/xUY/6G4jjqxtV6ZyY5Gc7tLFA3tGiWaOU4AScashKNKMXbUyaG0WdNLrk78se3GV0d6uH0HXWKUEGh+cjmRO5NyNhOKiOe25hiIlnJE5w9gSqfdjAlhhmuRrvQR8HasY0uJ7LuUJ1hEMpQ57lyVr8QpvZOOD0mx0vd57TbdwWQJyNgSbIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgJTQjHV3ySGAkRAruiyGePkyhBXFlf44OHu7ZFXDUw=;
 b=BsuL5sIC3GYCzFExFhLpafL6OMZW79aqs1r5z3GTH7aFoj6WkbDGREMZWV8fJq/x++30Yp93AryDpoNHIan1NA6EC403HiB4jNrpeaHaIxYwtTCylyRWJU/Wgew3xm4L0o9d568IYtlpaYnXfBDA9zRdJWL8y6phSOOY1t+uo2ny//E1CYsoGqwJJkUxIbOuj5uRkB5yKQpvTph34a/zLKhD41vjUBACY8gEWpAs7jC/hztTzdivawK+3Stji05+BG5DEclkOa+Qd90BLpIG2oIFPhWbYW18EjY4Ky4169cWFs6+xbFTq8/zWFQ7iitDWyXDVldKrhjSzjl+tPHJZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgJTQjHV3ySGAkRAruiyGePkyhBXFlf44OHu7ZFXDUw=;
 b=n5krzc3VgFAp+qhovuyRC+Q+MLqKou1XaJ8cTMl34EmPk7D1T4O4vsEHApQ2wmBb2gA8POduKql/wE95Sm/gFaPGG/WllpGbcmaXW1uD2xkOz/Kra6Py8di9FMhUQfzOxx7niE283rDoqTkXJyDbypBJ1EPqj/UrCpxH82rYezg=
Received: from SJ0PR05CA0128.namprd05.prod.outlook.com (2603:10b6:a03:33d::13)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22; Tue, 3 Sep
 2024 11:52:36 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6) by SJ0PR05CA0128.outlook.office365.com
 (2603:10b6:a03:33d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Tue, 3 Sep 2024 11:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 3 Sep 2024 11:52:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Sep
 2024 06:52:34 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Sep 2024 06:52:31 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH 0/2] fdtoverlay related changes
Date: Tue, 3 Sep 2024 17:21:50 +0530
Message-ID: <20240903115152.430335-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e78105-1078-446f-d5f2-08dccc0ee730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qly4ndLKV9Vs2rCSG60LsGIhSXnHctEVzy9g0s7jB8f+y8l89b3mfITEcNJw?=
 =?us-ascii?Q?CUHfWMPJtgYB+1ZYOXxZTVb3ajo4TktYGUS/qcnkTr4ykDdAtFFy3fv9Wg5V?=
 =?us-ascii?Q?8WV66TbLCKbrj+SKu6MYYe/WadbDT534I5gpnLcELY88aWbnL98DZWkMRWeT?=
 =?us-ascii?Q?hAHBLJxIlH1YA8ruin4oI7DFDhOOgFzPBKVt0DHB+FdmBfrsjcNUx4n10aqM?=
 =?us-ascii?Q?YBYRYTCcBoRYpkUs53MDBYCF2T9U5ZOAgOdvBAdXmZ+yrRaf41VqPqyowUOA?=
 =?us-ascii?Q?k64YUY1PbLe9Srd/gc+7vcat1OaIdbJgtOF2qiCcI7QRzyooughk30fpb5wC?=
 =?us-ascii?Q?3BsJNPRi6o7bNivgMDAFrLag9QAob9g0HdlI2hzeuH+FLnkmdcMEHV2XXGe4?=
 =?us-ascii?Q?zPCx2dur0mUY01KKqY2i0FgHvJedfvXLP4QbpO58MNlED6Q5mWjbOFowCdVI?=
 =?us-ascii?Q?RJhdDRoCVGPuRaEalvjbjmeb2QLkST+MfLaw17WNz01NtDIN4xq8aspSqmlz?=
 =?us-ascii?Q?T21vjealGVXiDtOfzB1q18XdbYuK38P2ONadt9UIlSna231ZCTeyP4NlDYEh?=
 =?us-ascii?Q?vnKVYTo1QH3oNipsavC/Qp2Ze/jqR0Gy4+7ezu+16PpcYiUi5PNCuGa9zoYR?=
 =?us-ascii?Q?ZT2fFrqAuxkNG46Zii81V0WnmHujFET/De5lmlhMYWn6wlh4+6yk01um3BB+?=
 =?us-ascii?Q?9yZq5hbz2RBy2amiqtdK6s+tLhcLOMWGSSpabEAsn9N4plqnjlUhhIAAWZsn?=
 =?us-ascii?Q?6AfuP3HpNn6iMj2Hz0FG+GwBhtvoniwNLgqQ1DAsF9J1F5+WcD7TlwR4lVQV?=
 =?us-ascii?Q?jZ1Dbxn2kMoSlBOnpKDMQDf2qPRQYEal05wWWqudl666bIkodz0QCzv/m9N9?=
 =?us-ascii?Q?lFjkD8px+R5yjMism7lpzzBZYAU9CKxJHwVfPN5Qj0omQLXkBcYPIrzm3lWP?=
 =?us-ascii?Q?XzLdlkDjMPHk9GhhtTn2CFs8yg/HHSfwGp/HsMQCUBkHFjvWHctlApFPC1ME?=
 =?us-ascii?Q?CB8hP9ptTghRe9s6FUJOdRBo0e/RIP22Us8nszCSN6FfsQ7NTjfPr72FoVKd?=
 =?us-ascii?Q?hLJGBHQium8Jz4Al5Kgx1KNs/I2iL3O9Ruwa2ziyWq4Pq/E3N+Wm4gqBNW/u?=
 =?us-ascii?Q?zxuW0G+fRH9lFDKoepVWiaJDAN3Z2tt0a0uw26x7CZum40WXIk0mab+0ZJCx?=
 =?us-ascii?Q?CMdTUkSP/CeE8gXuZT2brXqTM4kdowOIZv54olKWkxk5MYdHnUsZf4BL4OSl?=
 =?us-ascii?Q?lw04j1aEtEWajfeELdlTU7zby5NYFYvw9VrhCYkwU/X9D+P8U8S91m3jASUd?=
 =?us-ascii?Q?FdUBWq7HSPVoUyZj7Sw2gLqZwWUVuwjeV/JuqFcA3KH/l19+xJ99oaYTZfZG?=
 =?us-ascii?Q?m5iq5CjdUiMk8RrWMKLb1ZZ5fNbLtk4VucJ6Gga7Il21gaVcp8nlflupiskt?=
 =?us-ascii?Q?ViErxoiw09qK+ZG4As851/1slQ+sbruQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 11:52:35.8551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e78105-1078-446f-d5f2-08dccc0ee730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113
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

Prasad Kummari (2):
  kbuild: Add generic rule to apply fdtoverlay
  arm64: zynqmp: Remove overlays and add new dtb entries for ZynqMP

 arch/arm/dts/Makefile  | 78 +++++++++++++++++++++++++++++++++---------
 scripts/Kbuild.include |  4 +++
 scripts/Makefile.build |  1 +
 scripts/Makefile.lib   | 27 +++++++++++++++
 4 files changed, 93 insertions(+), 17 deletions(-)

-- 
2.25.1

