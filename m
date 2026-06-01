Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D41CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 20:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3F6848B4;
	Mon,  1 Jun 2026 22:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HBEPAh2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 757D5848DF; Mon,  1 Jun 2026 22:26:50 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 414AA8489F
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 22:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqN6xTukcuzZwrjf7r2CeEJ5JfK4XVOsOBnMIxSBYttdFG37iX7hyg08KY7ZNMdPNX9a1oOZgx66ov5GtQLAsLHUi/YR9hnGjLnOy4+xjwVUyzUG9OiL5S6/0Otiif+GsVNWpAzGmFufBNcb8PI5fT8+DQsmQe3+5Gp0gbFtL8Y7mdqfvLO8tm5H6OOpN47O94tAstR7VZq2kMWetrc4e+Eq53U1j9NxyM2dRq3BhYwfV8fJx1Hh6D+oogpbJV/NhPd739F6eU/6zoGyPxBGT3P9An+SXbwx9irmtT7s6lZvZqWT3dRga0L5MY6YNG3+PwAsss3Xlmy4GLTdG/QKmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luyTVob9uctTgcwu72SoUryLFKoy7X6gFUlUzPWBSmU=;
 b=y8pqG7DXEYvp4PX8GLMWcIe/oaDcz1g+V9D2lOWlckdFhgMn9l1SPmwDIcE3BR9AH0Va9yr9VAAeKDlkIWYmU061VjsTwarQix4/vc8zvPYtMccnX7prEI4lEjOot6Vw3qFP2flywa47ZUXI/KJYV1HpA84d3NM+gHqb0gZlZo1KukQPNhC+mhDurMZPNIa6i0/eaTJ6KfHajfLYqVPjuU7aHBwxZfiryM0Q5tI6MgmIXV72+3rFeqg/UuMms7gtmyj2yo4XMiz625EMJHVc5kFNy9fgeCmUEhoFUK3JTsSRPpqePRb0wDkteoyvHcscMncLu0HsLXLHoAtxECA0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luyTVob9uctTgcwu72SoUryLFKoy7X6gFUlUzPWBSmU=;
 b=HBEPAh2FTZt4kha4Jx1NfQm4fqca5F8kKM1uxfU9Ss+Qi4ammh5EcNIU6oncBqsDUzbR3EWFfziiYBwzoDDZT8zxSeScTQpy799HglmbBnt0vsxwqtMfcWxIwMHiuNysn2nqj1izVoGI1zrVsR3asYYlLgiexYFoMqzg6HE75YY=
Received: from PH8PR15CA0014.namprd15.prod.outlook.com (2603:10b6:510:2d2::17)
 by LV3PR10MB7915.namprd10.prod.outlook.com (2603:10b6:408:21a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 20:26:43 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::75) by PH8PR15CA0014.outlook.office365.com
 (2603:10b6:510:2d2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 20:26:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 20:26:42 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:42 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 15:26:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 1 Jun 2026 15:26:41 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 651KQfw11790860;
 Mon, 1 Jun 2026 15:26:41 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv9 0/3] various memory related fixups
Date: Mon, 1 Jun 2026 15:25:48 -0500
Message-ID: <20260601202551.265154-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|LV3PR10MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: b61fe700-d009-4c33-dd3d-08dec01c17eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|921020|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: +o1QZXeMYaFLZ6RBnojfaUyYexJKl89Lu7kEoHdh/88T5YqZ8Y7apQl7TuPI1vdDhIeHJ2mrWLYvtC7w0Nkow+hvm4linzhpeBGF0ol/uuRbqAu5Gt6eQ6EmSljSrVAyCgPYGMcbtht9D3Wi6+pgCE37ztx6udZDp/DyGPvBi0XeNOr+1JTixmNMrGjSTTgfjz8NIms2fn04UBLEiFxaj8+svIP1X9z9sbI4w6tDgJ3rigNzLqpGKFHDgmiBepiJ1I7vfto6ds976tvPQ3o0RTGSzrj2keWse0TmzRTGq+6s5NE3KU1hSVcIXR32c+Aov+WbU5jDujgt+i/W0RNv/l1VvC9FcpBv3nEBIjTBXIcosFGfKZKtZWAYSurA0d6gw5Nu3pddKdUyg6emoo0Rhv7tMV3qs8tXMTIr9ZSFcBhzKo8JGTv6o8iP7hMEgBaECQ0fTMwm/MRykAsgQkcSij8gX5+zaMnt0R5/eVJ4M7Lm7enTjmpZmtN5+TBK6cfftLAd9aJNpYq//VGJap/iYmatLMfCe1HCGUEP8rzcI+jJASucdQZP03eb1QF00amMwGLYxhKmyWSlfL0De7QmO9Il1dhHpoLVJP9aGZ8Jfz19BT2EzsYvkG1EeV3H2awut5mbf/EFiEX6+4Cpqkrq8YrvBD0vf+b7k9LTUVG/I7VedaMPHkCTPOkv3Orjx2+SDM1f6laXvOWFHCNSGyGXtd+Q8iqZbtADTTXpKMTF3qHfg2oegEbyJxPQgfyhEmlAY+u7agjY5qX9sLA+xgCoGjF2VYbVHyzgwOjtj2BC9pY=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kSMH5G3/hMfmPSTN98d4QF7U6kpHBgzCGPX4tYx3wF362QMVnvtPpQiCi/l3rs6kxQHLjtBJPe+qN+1ROB7XXzQcSeiupe3DZSIwm9Qx7xhPoidIrxAS6a82ZGiZo/fVZmpuwJoHPUCdr2gYa4QbkFHcdIVvKU6pa5z1RLbY1t3+g+nGmMwv64g3e5GoCCd6hVvr49zAzCgvxUNS1x9W9FQtp9Ze4kGmTXdreWDm8h2XjPaXSN1qpQyLjKqvkYkjSIUq1WFP7HCFohp+wm8zxf+fXmQYgUCIrG86laeJ/aDIlVdyd046rRk2wyvZBVBQc49ErxdGNqtaisVZZtQ0MmfXqIw3W9hgBvLbMJXrUX3VXtXzniFIwL1qLwU0C/GyyKg81b6+MFoL9PcSX9l5g8weK1oAjIc+brnxlcWeaqF3ipGxY9OWe1x1c2ReJynY
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 20:26:42.5445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b61fe700-d009-4c33-dd3d-08dec01c17eb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7915
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

From: Randolph Sapp <rs@ti.com>

Nitpicks and fixes from the discovery thread on adding PocketBeagle2 support
[1]. This does a lot of general setup required for the device, but these
modifications themselves aren't device specific. For those specifically
interested in PocketBeagle2 support and don't care about these details, my
development branch is public [2].

That first patch may provoke some opinions, but honestly if that warning was
still present I wouldn't have spent a week poking holes in both the EFI and LMB
allocations systems. Please let me know if there is a specific usecase that it
breaks though.

[1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
[2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2

v2:
	- Remove additional increment and decrement in lmb_free_fdt_regions
	- Drop the patch to backfill EFI_CONVENTIONAL_MEMORY
	- Adjust the removal loop nitpick patch description
	- Change the reserve memory patch to use new end_addr_sp
v3:
	- Update lmb flags to use the macro documentation for constants
	- Change efi_mem_sort to use list_for_each_entry_safe
v4:
	- Fix typos in LMB allocation flags macro documentation
	- Rename end_addr_sp to initial_relocaddr
	- Keep the map_sysmem dance in the efi u-boot reservation
	- Use the active device tree pointed to by gd->fdt_blob to clean up old
	  reservations
v5:
	- Keep return value as long in boot_fdt_reserve_region
	- Fix formatting in initial_relocaddr patch
v6:
	- Drop patches that have been picked up already
	- Add board_get_usable_ram_top for the sandbox
	- s/boot_fdt_reserve_region/boot_fdt_handle_region/
v7:
	- Remove board_get_usable_ram_top for the sandbox
	- Reinstate bank hopping logic for U-Boot reserved region
	- Update description for gd->initial_relocaddr, make it clear this is
	  also an exclusive value
	- Add disclaimer to boot_fdt_add_mem_rsv_regions
	- Add static boot_fdt_handle_mem_rsv_regions as a generic walker for the
	  two calls into boot_fdt_add_mem_rsv_regions
	- Make boot_fdt_add_mem_rsv_regions fdt pointer const
	- Leave the PRAM region out of the reservation. Previous commit messages
	  indicate that this is intended.
	- Add a test for boot_fdt_add_mem_rsv_regions
v8:
	- Adjust initial_relocaddr doc string
	- Convert ref to fixes tag as requested
	- Rework test_boot_fdt_add_mem_rsv_regions to mitigate lingering state 
v9:
	- See patch specific changelogs

Randolph Sapp (3):
  boot: image-fdt: free old dtb reservations
  test: boot: add a fdt reserved region check
  memory: reserve from start_addr_sp to initial_relocaddr

 boot/image-fdt.c                  | 77 +++++++++++++++++++++++--------
 common/board_f.c                  |  9 +++-
 include/asm-generic/global_data.h |  9 ++++
 include/image.h                   |  2 +-
 lib/efi_loader/efi_memory.c       |  2 +-
 lib/lmb.c                         |  7 +--
 test/boot/Makefile                |  1 +
 test/boot/image_fdt.c             | 73 +++++++++++++++++++++++++++++
 test/cmd_ut.c                     |  2 +
 test/py/tests/test_suite.py       |  2 +-
 10 files changed, 157 insertions(+), 27 deletions(-)
 create mode 100644 test/boot/image_fdt.c

-- 
2.54.0

