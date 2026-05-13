Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB8ACD4F21
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 20:50:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1D05845E3;
	Wed, 13 May 2026 22:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="glO6av/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7BE6846A4; Wed, 13 May 2026 22:49:56 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF03845E3
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 22:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpTsPfp8i0y9cTTMkxMm96sFUI2NQgYUJr3aL4uJFfNJYt3++wC0QO2HpezWCpwgmknfUYmiwQW3Y24qeqAqfNQj4b8xLH/tEa5EqYw7EWX6rj4E6W7x8+3PwYfsdhH2Fl0Ph8K9uVTdmlOAcsNnZ8xCzpwFsuRXwg15JJiLwtZnMAOo63SjeTzZehH+MZPiD65GmNrSPtyoKlS3PpjFr+qKj2DgNodjLjRIaf8a32pjmmIYg/TNn0+OgkKUbYEntQVQvAz9JZlodZNMFgGOdz8fwn8Vn0lBbFynl1w3twV5VInUI66HK+9c3JI8eobhxsWLF1WmENeKN5ISIMxCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgdZDt/K+WHkB28flyDiijLkXy+Lo6s8OIAmrBbn5RQ=;
 b=NA5EgLy4tm8nAYXOvD7908G5swVSvMKeNV2q8yAnX8qGdEoLqmhNUudHnyz/uqD1bpKoJbDsKgt5kDlkq1ad/Ijz+PDNIsw861sgcyv1+rWem8LUaWTdSJ55KBxo/hRWI0cuE3mN6mQf5Zwf3qIUjEToBw6sj4+s25zNbt17KlYV5yCzf9y99IwYlUdQWnmyqMHQW7Z95D2VhCY1uoEVaFxVhG8YaHxlna1RcYgEDINdcuQWI44BvtuLhcdnAWPiB4cK0nHDqjVbtknziu3qU42gsZT+AKdJB8LOfxqPx0Uz6nIoavHGAfeGzkEMzcj+F3G9LsC+brZRfYPcdMyeYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgdZDt/K+WHkB28flyDiijLkXy+Lo6s8OIAmrBbn5RQ=;
 b=glO6av/zUeYQAi4QIsrg0M7uvgsvr/GAWzZyXq0Et/GxyiRP4MRjP68zyvQhIHVxolSmamFwQU4Y4QJtOZ9+w9owbIRe63C8dXjPg7XXGHnx2wk4TwoB9UFwWrPsKkJ9yjWj0v+V4U6zNASy0n6g+YJXUnWb6cWT30ziA8O6GFw=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by CH2PR10MB4261.namprd10.prod.outlook.com (2603:10b6:610:7d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 20:49:46 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::8f) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 20:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Wed, 13 May 2026 20:49:45 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:45 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 15:49:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 13 May 2026 15:49:44 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64DKnipC269440;
 Wed, 13 May 2026 15:49:44 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv8 0/3] various memory related fixups
Date: Wed, 13 May 2026 15:49:40 -0500
Message-ID: <20260513204943.736142-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|CH2PR10MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 1179a8e2-ff85-4b41-acdb-08deb1312a8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: DOj2HkrC9997CFnLsErvCxtQt/55y9zocr/2/7CvZjmKdKiR+le2T+S57z3PChMcThw5XxqJQI/4iCwLXgA/Ahntj4qbSjg5DZ2VJxRQu+pG4k+HD3oeyg7NhQSGEHRoOpfUjs+06S9o957Hf0zeFQm25o5BnOROV8yUTY+LHoHG27aa24Rk28Mf3uPBPSpo/T4ElFLQgG9epYbeyLYpynKingcjK/iwSUxYnTIfLx5GXe3SCyLfn3/vWNwIM0onu/3WTFyvLm5ZN/0XSqGe5KgojHzOX6ERKVpxg4ClMOJlAPXOXmewf+rhlsRqEHTq5dbn4ySLl3FAB8agPBu4ji35f1+OV4WNRJEeJxIDM+JKC1dDkCpYg70o3pZOMSaxMB5wDQwnO3oDbsxmz8etK4Q8BToEpFZ6i8BN2f1Zg/WlpK7W3OzJ45VK9blTJ5DL5KbPQ0IW55HN5eYlPxZ2ajuA+7fvC/JN/PwWTrsZfjbW7p9tEd9K890oG+0zUFJwtUVvF2Qh9o/e5KI174VhLPxSCrb/VzZocIZtllShG+f8PuXFXU7eIIrZRejGBgPbs9zbRNtFmntISjkIdS49m9QhmJsU+7IUoYDMqpk3thXIPWvfV3LabPFVi1/w0xLNK8IlokebqsoGhm0x/tZJeTQGbXsOsHDl14Q8Mm1TIcQ+cBw6gnQTINzcYNV0cLQXvK2XzBriVoXnyFXehRveEX7m0COXZt4MsoTZMGnthME=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BPB1O3rO3/h79id/quFiEa1mUJZvBS24Ky9tkxqWpC2aNRzxPzRjrimXixDDELOgIXE8NhbPWYj4l8Ub9XTuhK4etUNjnGXdOYdjFGgH/+sE/cXTz2eia6fXd+NLh+dkqq3J0wU9VhFycifRaNti3horipWhv1BKFI83FtXCKiuL5zRYpQuMNOqmkBKBjsCxoqrhScUXLdO7Z6T4u95BofUECH5FqTu9CaWRDEzxPuvyk/kdlnUUbW8Mm9YdfjRAvMkee/EGb4W8eg0EezE94BY6F0O84jGMRRBVizv1fjeWlPE6bZ55y8zFaUrmeCPaQwxyypTKrM6Nxfs0RcXB1QH+fIwl5rS5G7A1C112WrtphsLw1dZrDo/qmz2Ayo2DyyQdyQ/ZDkmgGlsDmBgXytBxCzYM3ktioh1QrKtsGL3ZzhdjAhSWh71+rDsTyxAF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 20:49:45.7102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1179a8e2-ff85-4b41-acdb-08deb1312a8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4261
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
 test/boot/image_fdt.c             | 70 ++++++++++++++++++++++++++++
 test/cmd_ut.c                     |  2 +
 test/py/tests/test_suite.py       |  2 +-
 10 files changed, 154 insertions(+), 27 deletions(-)
 create mode 100644 test/boot/image_fdt.c

-- 
2.54.0

