Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7715DCD342F
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 22:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09A2F84DC4;
	Sat,  9 May 2026 00:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nowG1Swb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40DD384CF2; Sat,  9 May 2026 00:29:29 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8637E84CFD
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 00:29:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuZTEEwEXTSbSK5L7EzaD6uDn/qDUNm4ATSomDxfOl65Sj9mqXP1lxLoZ6LE29VGbWAIbwf/TnofNmGwrU4RlCJHUOb6KCWaPKGY4lzrYnN67gz+BKyfdtE2OSee2JVKVgd/WnnitDH6lFx3TBnQ8kSAaWImMXpTuepCFD4FHOLlEHWFjy9W5hwaXY0LZVx6knJpkICZU35pE5fwULm2WiCtJ5LtO6gx3bMIh3Ml8twP/9XHZtgnVl6zE10Gs6CZmq0v8Iq0JgXnmQojAYKBjRTrBb9/JhFisewP3aNQrUGmp9DVzCBE36RdVajlHz0aC3QK//2Mp15G3xfh+0M82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwVgv3HFygelBE5NKOmnfWy3SqEZZXTA7nh2XhLnrcc=;
 b=RrhHeYgHIrSrzaSpoorsYTFpKl21pvh9WNHJ7wAt0E85n3AxKGKdiswRRbkB2drwCeh5FuGOgZ4YKhQgYk8Nlcd99g5JkysA8D2PbvyJWXkZ+vCq32d4lXpCeKvBwCZe24n4b6gjcyQqA/J61DeuuV/vwh/zPRA/SGoTdsFiLVHYlwu9bufyFq8Rjv0Mh9SVt0SQccEL6GfhnmFClwDqQFwudQv90OvSBorWq4PVRs7oIWKVIw/rtfsZ6vKYDYEz6oiOFcF0Kr8yFJPK7TRia0mNzsfPlvFkf2VKjj7WWcoDKttfj8diAXhkvIpJBjUOZqrm6UFk5kvgUiiw18i9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwVgv3HFygelBE5NKOmnfWy3SqEZZXTA7nh2XhLnrcc=;
 b=nowG1SwbQH8gfELtVgX3R/iC9i1GDndpzZLvVeAasb9o7aGg/TuDud6ghn24I9BwwRWjHPUp+L8vwTU1PhkCxxKAW5/DQsYC6NnE2HrlEm3Okg8CO7pn0ztLi+49rSdRAqRfvrFDCIqMdtD/vM1cVq7yUprfBCVFKWGqdjOQom4=
Received: from CH5PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:1ed::10)
 by DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Fri, 8 May
 2026 22:29:21 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::4f) by CH5PR02CA0009.outlook.office365.com
 (2603:10b6:610:1ed::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 8 May 2026 22:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 22:29:21 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 8 May
 2026 17:29:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 8 May 2026 17:29:20 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 648MTKZ12507774;
 Fri, 8 May 2026 17:29:20 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv6 0/3] various memory related fixups
Date: Fri, 8 May 2026 17:29:08 -0500
Message-ID: <20260508222911.450165-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cf4cbda-dbc3-4a90-c587-08dead51401e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|56012099003|921020|18002099003;
X-Microsoft-Antispam-Message-Info: rE/tnjmKflnS7LmJ9oYMV1YexN8rp4SgEOD13nxaNMgCx+hB+PwrwSckKsj5q1m2anWNjQiKog9hQ/IZSe+6lpPSNvv5bG1xfczdvkbaImaEPC/wCy2ELRYdK3OSu/Xc2serC6c2NpFH/QgssUyLAmklruYW713VVjIYDTYsWMyvQWlbG7jO6EjwWyrHk4ggO/k1HLc6hlwzE2nFJpg7JItrJEEzD2Ifb6Kf/CDJ6WJSVoRqJwah5c6oOkM3+Thk2dkhf1G2IlFh6YADOEAs80m9Gq/VTskeEMsaUe4RejbCbDeqYqCTHy4V4mf2GAxPjNkzr9aoZ81JFyfZDbIysaVc1qOoJqb+5d+7e5DouFobUjSvuhXcyTyHzwdyjEKj1qFRaJ4NjJf4shIgbwuM8uSc1ZQ8sxVzvFyY9BDlYQGk90i4SklFadgvBgMW1Tg4R4pZQhDcVl/us1u3ZtWWhMoBR5zkFEUak18raRAoyw7HAxBmfj7iJKv8w4SQFtHG6s1vywcQBS+TW/qQtFPssJL2ftYqt8mMeYXQy1FYSatUQ1C9YVUHv5XfD6O8D1tYOVg0pixg/jYhjGh+q++9JvyKinXgGf/iX70U0B8I3LdAPjRQic0vU3oHH2ln/uor+T389kG7d28X7QeYw8phBdJCsepy9CQMiH9w5fsKXmGLFNcItXdtCKUa/ImqgVoG/Kabydtp5huCR2nvxzpVkqFeiRc/8XPDHhR9qJ1JPD3HoHzg2srS5ky6eOUyQMlAWRCt3GM17OpM7kQVthte+kgbZBe0+3zsUdlax0tXWYQ=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(56012099003)(921020)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /y223SnPxCbpFuGsU+fYmtCJ0quK1KgtCG1VgcOBnZbaWy0KbRdjmtfeseI+V3oXrKJ4v6KI+eRjG1rLyy933LGRRuT7vsjgo/InzLtaAuazMZxixElaGcKBYOzzhLXlQdQXylui0mTdEhXZIaYLoAzvkuhlyZecMzdsHgwpWISaJ+aQqVWkvOwM04dN63qHhQ9ckcVH9pB2dzG4myejDIgJWrCOzXLi7sK4QOZ6YEKvR3YZPjDsfuuBfCaR7WcFS+2q+FGR0Jh8BOt6TtroFq2sU0lESoCnZ0WKBh24AeAXRr39G8JG/JcjBdsZj5k3yDdCDYLuRGO7Vb/Gtph4axv8S8Magd2OTr/Dzb9hpBStE8boGhO6qmgOYgh//fjR4G1v2Zx5kCwFeoGj32jsj0FdMJU13dKWhebnTE5FsSzT9n7erJ7FDNViRHfrRKsT
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 22:29:21.1947 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf4cbda-dbc3-4a90-c587-08dead51401e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
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

That second patch may provoke some opinions, but honestly if that warning was
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

Randolph Sapp (3):
  sandbox: add board_get_usable_ram_top
  boot_fdt_add_mem_rsv_regions: free old dtb reservations
  memory: reserve from start_addr_sp to initial_relocaddr

 arch/mips/lib/bootm.c             |  2 +-
 board/sandbox/sandbox.c           |  5 +++
 boot/bootm.c                      |  2 +-
 boot/bootm_os.c                   |  2 +-
 boot/image-board.c                |  2 +-
 boot/image-fdt.c                  | 55 +++++++++++++++++++++----------
 common/board_f.c                  |  9 ++++-
 include/asm-generic/global_data.h |  7 ++++
 include/image.h                   |  2 +-
 lib/efi_loader/efi_memory.c       |  2 +-
 lib/lmb.c                         | 41 ++++-------------------
 11 files changed, 71 insertions(+), 58 deletions(-)

-- 
2.54.0

