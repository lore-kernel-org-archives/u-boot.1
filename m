Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F431E77183
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 04:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7386580214;
	Wed, 18 Dec 2024 05:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FNFXftUr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 588B48021A; Wed, 18 Dec 2024 05:19:53 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C616380196
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 05:19:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upOHfSncTnBgzoKjQDb/YliWpvk+H2OoUcUJ0QiVor0HRGtmRTk7ftj0Qjqv9PQY13M5Zd8HIq5cJLD96I31vt94pFXgoHzAIKLBYc2dKKmJJq9pjRNj+DG86FAXLVY0i7A+1xeY33+WpAkblkPY6L+jPVx9uzGByD5tmrrYgnjbxUmOwCvCuGnKZj25e6BgKBaLEdPM3PzxQ+4vu536gPBzBTLa58PGeuTUTzs914rX/QjeDJpNM74YvYFjaAjPDeHaXbV1VkS/PtU3hXTnLLvYW3GyZ4FP9/oJMj6jlXobIt9I8lJNdWUhdQLt0FYeM1MV1/7b2higr39XHPDCWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z6wf5nLtorqwJ1FMK7HzH8ncUu9aG0Gykbfi/OxLhA=;
 b=XtFrTW9kF2YDrea8ygoxYSsup5n+O3VP3kBPCMbI4uJBMLS4gD6ooX82YnStMwuRDcBOCXAvEW+i0opkUCPCaJRnTg+t3/o6T44nx3uOGO28zKsQyulZriqn08NFd2QbMafrK8loUTVQI9zvyr56fd6m3KxNLz+/VdhbI8JLhC1YVNB6OSNgwAw+a76qA920J1GHS1d7A1BcSIbOS9Ng96mA/kauBW2ReNV76xPNPKZiIOJiMc/pJivSMZWA+IbPyQR35LM15LU0/iFB/to4Vh4R3m+z7lmDwnzNmaoYPYrSOxtqfcqU6ypHvmx4lvhzAbgzrG0/3qYCtztvViZ5yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z6wf5nLtorqwJ1FMK7HzH8ncUu9aG0Gykbfi/OxLhA=;
 b=FNFXftUroy7tGAAWUoIZ3hb6iok3TJeOq6m5SA5FvZS5ucjgeMk00A7djo+3gpy9XOXRArQOjJBucQocPahLdBFUJ888fafj7//dTzVQ5rlZHtipam/54VgprwDZOOcMH1261/8ACSt3MSWDdQ9pttKlD+71yunARWI/yMYwqAo=
Received: from CH0PR03CA0394.namprd03.prod.outlook.com (2603:10b6:610:11b::28)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 04:19:47 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::b0) by CH0PR03CA0394.outlook.office365.com
 (2603:10b6:610:11b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Wed,
 18 Dec 2024 04:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 04:19:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 17 Dec
 2024 22:19:24 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 17 Dec 2024 22:19:21 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <trini@konsulko.com>, <sjg@chromium.org>,
 <jens.wiklander@linaro.org>, <ilias.apalodimas@linaro.org>,
 <xypron.glpk@gmx.de>, <jerome.forissier@linaro.org>,
 <mkorpershoek@baylibre.com>, <akashi.tkhro@gmail.com>,
 <francis.laniel@amarulasolutions.com>, <ddrokosov@salutedevices.com>,
 <git@amd.com>
Subject: [PATCH v5 0/2] cmd: Add support for optee commands.
Date: Wed, 18 Dec 2024 09:49:12 +0530
Message-ID: <20241218041914.1463666-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: f80d2a7e-1d30-4295-65f8-08dd1f1b351e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?df0G5BIv5xfxAyL+LVXdzBY8/BgTkDjf7q1/w56ml8TvOwRH6diLLG9lsSma?=
 =?us-ascii?Q?M3B+oNivOmBgRGZqcNLkYhMBEnxMAS8OK9nIUPLr1VzopykkadJSh9fmLduF?=
 =?us-ascii?Q?lMTzN8Wnpq0cyMgU6lx/NPuAaegFRn9jV2BQ39Tqgyx3UdzNv1VZWMjlC1JB?=
 =?us-ascii?Q?z8olTtU/xkLlJAKJCVkcvQhc3FWY/KdHXR0EdQQ15OuEU4wRVtzxhdF5lAqx?=
 =?us-ascii?Q?2+RWCVwSnEoOgieiCeB66Q35s06bVLqObi+VmrbSuVI1cwMrfTArQNPdV+6n?=
 =?us-ascii?Q?YFp/0ehlzLcOJHBrNMtio+3kYLZaesiAlbd0ezkiAqHkPAFPUtSQ3qXx4BWF?=
 =?us-ascii?Q?ltzmaXSQGV0EMb5E/z0JZ+RmGMXW1sY4cFZ4laBH8Qu6yBd7IhSRsro45qmH?=
 =?us-ascii?Q?+XaJnd2AF8iH3T6HoAj/ijm2sPHJ9Wag/SGgoJ84lOSnGWwEsZ3GyuntL5oB?=
 =?us-ascii?Q?hg5MeaPjm31vai+tCWk9KSIaO41Lv8Pt7zPMmxACSnUfHXWvkcf9bX71wRBc?=
 =?us-ascii?Q?oZZaqpQsRK1NTPFFDMD0E1QMgAMo7tF/PxTA32ts5xKoTZVVX86HvWZspS3t?=
 =?us-ascii?Q?RmgLiI0X+sSZivdvoF1zaXfE734G3PrlTEvqk5x06Qqy6YgPUZPv0g22qN9t?=
 =?us-ascii?Q?55bgZRf4Klp4F2X4OG1AE/00FJlxkE+rnpLO45wa1/bSXQACUop5vwsPhr8F?=
 =?us-ascii?Q?lPSNsa8rj/TeM3JVnASOcedh30WmKTT2pSHAEp0C6LB6fb9uBDa7KqOrqKnw?=
 =?us-ascii?Q?WB5SfRACMqumg7MhLNFUs8TUbXyLGAdWzo2cjasq/9/KJQm5AIzQpujgEl0l?=
 =?us-ascii?Q?weQramrgg1ktnk8q26dkvROM4Z/QGZr/GEKmNkw2wmoOHm3V4IpG/hHhfcwJ?=
 =?us-ascii?Q?n//oA+L/eRr2vD3g3/1OLBbSfMtinrIks7esQe2HwJ417pQ+Dcm4Cfjk+HNo?=
 =?us-ascii?Q?cr+q4aaOqyXnbtwGXrp8dWGX8kWB1pxUcxp8u9A3MyPuapIKFRnZKkLHfhTW?=
 =?us-ascii?Q?o3dHDNuE88DeSZKANiOwi2BliZo7jF/qMqb6NsJQQB2RNFVh7zBYn+ycM7oS?=
 =?us-ascii?Q?rfPpuwrnn83m3H79d5u8DUCa4LHMLabvNHkC8tCJY/hKD46+5wURN7r5cj6F?=
 =?us-ascii?Q?vqxiR8UDDXXaki59ySfc7VQMX73hgsu2ShNgfXQ/OqmjaDP8mgZ2nRDjTN6/?=
 =?us-ascii?Q?n7XTrZEq1R0sNJPefTIu4uTiczUrRUiNUshu8SSACYjooQrU+biqoC0EVEAG?=
 =?us-ascii?Q?NOXrKwHXNH6HpWLsGVZSHIUoD7KUQJz+aj3mz/6+dPmIa+teegjz9Of8jW2X?=
 =?us-ascii?Q?PZhvKwVinioI1hz++WR/cpH/4m0X3ETXZuMocBa/jTAL8Ix2pU+Ygx0OgpAo?=
 =?us-ascii?Q?pZC1yNO542s8C5OHN8erOVVR033Fg8WV1Aa++RFLqFInt/Z8Gxw1uvtNIvK3?=
 =?us-ascii?Q?Gkv7lwB9Jse7y8ajKu10S+vFmX9NHuq2lbBclNSny1iIVx/GC/glUZBacd5e?=
 =?us-ascii?Q?SNVkMJLYZsR95mM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 04:19:47.1303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80d2a7e-1d30-4295-65f8-08dd1f1b351e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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

Add the basic 'hello world ta' command which increments the value passed.
This provides easy test for establishing a session with OP-TEE TA and verify.

It includes following subcommands:
optee hello
optee hello <value>; value to increment via OP-TEE HELLO WORLD TA.

Changes in v2:
- Added command "optee" and subdommand "hello".
- Update the man-page in doc/usage/cmd/optee.rst
Changes in v3:
- Rename the config from OPTEE_HELLO_WORLD_TA to CMD_OPTEE.
- Rename the file from optee_hello_world_ta.c to optee.c
- Add the hextoul from dectoul.
Changes in v4:
- Removed the hello_world_ta_open_session() and included in
the hello_world_ta() itself.
Changes in v5:
- Updated the printf statements.
- Fixed the description for doc usage.

Venkatesh Yadav Abbarapu (2):
  cmd: Add support for optee commands
  doc: man-page for optee commands

 cmd/Kconfig             |  6 ++++
 cmd/Makefile            |  1 +
 cmd/optee.c             | 76 +++++++++++++++++++++++++++++++++++++++++
 doc/usage/cmd/optee.rst | 70 +++++++++++++++++++++++++++++++++++++
 doc/usage/index.rst     |  1 +
 5 files changed, 154 insertions(+)
 create mode 100644 cmd/optee.c
 create mode 100644 doc/usage/cmd/optee.rst

-- 
2.34.1

