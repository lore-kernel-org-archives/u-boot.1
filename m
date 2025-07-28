Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7EBC83F17
	for <u-boot@archiver.kernel.org>; Mon, 28 Jul 2025 07:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F7DB830E4;
	Mon, 28 Jul 2025 09:08:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ueoyRUgP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B91B830EE; Mon, 28 Jul 2025 09:08:18 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::60c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C809782F00
 for <u-boot@lists.denx.de>; Mon, 28 Jul 2025 09:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qn5a4k9ipjxEhfst/4m++Hza++fjo/cH3IkoNzX9A7Fsdhz/JzsxTpJCbNfzX24MFtNJytyd2j1R5hpzxEkGjAETqCl6YPIzzug0nzcR9ndwiLm9ehFPjF0L40ANTNZN5XfmCVKOphQGaoK2aFDfv5rqhuZn5UjVwcNnqEFgOXjt3j+OR1Jegbs8QZsZVVouf1yRvOTmmZcMSMknnqWuMPfdQ5KMd3cOGznmDAYLFPnx/Gc0iMGHTyubO25MFcngjaOmjx7eyty0yD0Acm6D+x0UDU669J1K+Uyu2iGXvomkrBVqVG2Kx87oE6vNtq8HW62oEIrS0dpk1A59T8QLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5auhN/F4y+IyDJgtEayvzpujHXn8Lkocvlioe+O/L0Q=;
 b=dYhc77SZ9jwDGGfBQEcg5Qa8khM5IrIrCeVhfl4vqKY0nNOrgzFMOe1JLAVr1W86fE0zfgtoe5mqHQXkilsis1k+95QSP3XfljnhS+IRPFO4tqsc9myeMKULElJVYeY17UGW741Y1rmfitFBC+JlAXWnL6K6Icw6nhC1U7dgzwrrKGwvzeVvgO9FSGa5x29EAoW/6mFPRwOFj4wuEAabAO3bB6r6UZOnxEw0eiV2AxFwU+2/Jqs5YTQ6hycuc+gtGTtoXp1VBYLvghOvc26LJ+jMfWTgYWf3FMXwNZs5bPP4JgWGoN9/ZSVDkCQcuC1j99PJXzSojD7Pc1ceMNwUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5auhN/F4y+IyDJgtEayvzpujHXn8Lkocvlioe+O/L0Q=;
 b=ueoyRUgPiYhiUH9IjsYbzRvwhUO6O/Q/NTmIcwCwbC6/8mlgE6CK8b28CPls3sCHW31+mj1FQifW8CBgUwqsbjUcccZ6KbvrwRzErhmRY51f1TnXkXpN8XEr243tucw/P5ckxw9VGi109TVbNIpNg0xUA8IeOPRsCzvEVK92n7E=
Received: from SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Mon, 28 Jul
 2025 07:08:10 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::ef) by SJ0PR05CA0119.outlook.office365.com
 (2603:10b6:a03:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Mon,
 28 Jul 2025 07:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Mon, 28 Jul 2025 07:08:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 02:08:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Jul
 2025 02:08:03 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Jul 2025 02:08:03 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, <p.bruenn@beckhoff.com>
CC: Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 "Dmitry Rokosov" <ddrokosov@salutedevices.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Mattijs Korpershoek" <mkorpershoek@kernel.org>, Muhammad Hazim Izzat Zamri
 <muhammad.hazim.izzat.zamri@altera.com>, Pieter Van Trappen
 <pieter.van.trappen@cern.ch>, Simon Glass <sjg@chromium.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] fpga: Remove lattice and ACEX1 support
Date: Mon, 28 Jul 2025 09:07:51 +0200
Message-ID: <cover.1753686468.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1404; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=9kwzlis+Fr0xQF5jg/gk369v9dVuFlZ8dbe/brUwyfY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWS0K548vnDTxQbdJjPFu+YeP64dPbS/vKO5+MSsG3/52
 66cvxwW2VHKwiDGwSArpsgynUnHYc23a0vFlkfmw8xhZQIZwsDFKQATOf6fkeHXsdLUzHLn7afl
 1jg+/vzAdr3kfkG1Kv53CwrqjPuLP3gxMjxV/iXLY+X3ZlbPopm6JrY7Th+3dBa7te+b6rsTB45
 ek+IHAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|MW4PR12MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dad9863-965d-46bb-fa15-08ddcda582a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BOdlPgtnFuqT3ZnGQucuArzkJ2bb4tvPa74DcnYV6YznVlUdGMyfEQZC7r/Q?=
 =?us-ascii?Q?rw/riIGdfokoKneuPl4agiwqKktan3bldcUsJDCrys0mLTI64AdwK/h5jYgb?=
 =?us-ascii?Q?1VqNilbyaumBcBNbV/I/OMS8DVAfKdmMYo0JnFXolWmpbxafxj0Wi0mq57K3?=
 =?us-ascii?Q?13eBjCMYXLG41cRNWrmpmS3qEL6jJsy4NO7o7aq1olCORBlpuBNfxNHjqeo5?=
 =?us-ascii?Q?ajf/SxOvrddfYdft7bchI3kEYX5+tXSeNnpEb2Y7VH/whdRYTsrI7LbQDeQ5?=
 =?us-ascii?Q?yvmUwxQyxputnmm9GBjPeFJifhPbIf2ddHpPpNgtOmcnp3JZAcGhbEyv0UqW?=
 =?us-ascii?Q?zMsKdNmU6T/1tHJtdkIrAFccLEhN8xNeJVJedbBk7QL4u8C3cj4fJtU1sHx8?=
 =?us-ascii?Q?gnwnaN+LyqOAiDU8moflbd7qCl6ErJhfwfWys5giwC4mtj69uvJODTLS/LqU?=
 =?us-ascii?Q?6EVFSNzfl5x5/2/W1mYzMjo9ZkdAPFA+QQ9NrcbGpUBgLDgo0QjzK+AQa5Ab?=
 =?us-ascii?Q?d5F6NGcUocy7WkgqXBZU8G7+eAu8d0gLa3+8dTKGCVa7Ylze5r+b0XqJAKDh?=
 =?us-ascii?Q?+muE7oT5fv8rpq5BWkQ7oHSD7VVhttmS56avZUzCS2k9D98+skNsOjRoU3d3?=
 =?us-ascii?Q?ZI10ZMB2FBjgoUeYxqZF5nRtXqreCA0pzkmet9CSU67kqv6dyWUpp5y3XUcE?=
 =?us-ascii?Q?JBi9+cYMv1c76Ne4EuLkQ3CyzHb7vCAAYG9Ah9bS2ZtHk0r+iA6Q/MUIokwP?=
 =?us-ascii?Q?TW+XItNL6mSBHEQCQJbDPZsVZMU0EhbwA+lfGlch+vZsTLDZipq+Z2JrvbWr?=
 =?us-ascii?Q?m7z9JQJBAaYJSlvY0D932jn9aDHubV+tL6Lvq8fWef8usvsnYhEidkOqLP4L?=
 =?us-ascii?Q?uqv4v4AaKyJh6wXRHVKp8M+81kGzcT0xVBXyYgMM193j23/+okbxrf5Ki9ru?=
 =?us-ascii?Q?RBCUrjgbCfwGMpglrOrQWTfSN5feVC00kVgTWKUsVS3k8YtCvkCyYSQJWKYq?=
 =?us-ascii?Q?nVBknolW4LG2MAUrk/xhApqsyQpOUu4/2g1A3MLxemOkS8oQjoBTjq5bdJwK?=
 =?us-ascii?Q?MSyi/AsVsbBJry/E9ZMQYdlG/649Lcp9B3IkjAQQTe6IX6nFo7lJlXnN3ZPq?=
 =?us-ascii?Q?WCOfymeGM6guoOxi2cRW1VbUzHUth+FNzDGsBvFMZJqNBOWcd1dWtU/meML7?=
 =?us-ascii?Q?B+ooZGu7M1Twfd7WdLX5Q3ujUmYoGAqYsxfd2T+jlVyl6s/Idw0SG+UG5OlP?=
 =?us-ascii?Q?1/EReCxlfGPRWgq/AbV3kzpOeUEQrPh6xgKUG9hZexyqsqsJHQt6q6j5SnKf?=
 =?us-ascii?Q?eVQ9fEZZeJJ1OMP/schUK+VcIp8Nlf6nEINOdSRB1wbCYaPVLsXbeClZy96t?=
 =?us-ascii?Q?py3npxlCSWgjeWjNGH5E4f3W05CD1+Nnf3lDy+voqTBtwmtUiaAMG3ElzJS6?=
 =?us-ascii?Q?iJHwm9jWafovGIBQkmWzjpyMJvPWyYcp0v8G4BHCwwSxY0ab0yfqT1hMalmC?=
 =?us-ascii?Q?3/2AyDxnyRwFmVKy5848ATLJs8xnb9v7WigT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 07:08:10.0550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dad9863-965d-46bb-fa15-08ddcda582a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

Hi,

when fpga drivers were enabled via sandbox some coverity issues came and
make no sense to fix them when there is no user of these drivers that's why
it is easier just remove them completely.

Another candidate for removal is FPGA_CYCLON2 which is enabled only by
mx53cx9020_defconfig.
Patrick: Is this board still maintained?

Thanks,
Michal

Changes in v2:
- Get EP2/EP3/EP4 sizes back even they are not used by any code today

Michal Simek (3):
  fpga: xilinx: Check valid desc structure
  fpga: Remove ancient ACEX1K support
  fpga: lattice: Remove unused support

 configs/sandbox_defconfig |    2 -
 drivers/fpga/ACEX1K.c     |  245 ---
 drivers/fpga/Kconfig      |   12 -
 drivers/fpga/Makefile     |    2 -
 drivers/fpga/altera.c     |    5 +-
 drivers/fpga/fpga.c       |   23 -
 drivers/fpga/ivm_core.c   | 3149 -------------------------------------
 drivers/fpga/lattice.c    |  379 -----
 drivers/fpga/xilinx.c     |    3 +
 include/ACEX1K.h          |   32 -
 include/fpga.h            |    1 -
 include/lattice.h         |  298 ----
 12 files changed, 4 insertions(+), 4147 deletions(-)
 delete mode 100644 drivers/fpga/ACEX1K.c
 delete mode 100644 drivers/fpga/ivm_core.c
 delete mode 100644 drivers/fpga/lattice.c
 delete mode 100644 include/lattice.h

-- 
2.43.0

base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
branch: debian-sent3
