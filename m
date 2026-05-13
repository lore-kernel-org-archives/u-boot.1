Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBD4CD343F
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 01:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F47283EF9;
	Wed, 13 May 2026 03:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zug21dJl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D6E98460C; Wed, 13 May 2026 03:56:53 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EB8683EEF
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 03:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsT5WxRgcJGgToz0th9FN0fkxTfcXi+QCbIVKwbh1eyfDgfyWFFGkX77m3x5pky4zMFmDT1eioWnB35RYmV2MnR2Z8VoiQ2qo4aKKexjuVZ+PzeHbNEP/JrrGotQYxXGvjGY16zkf8DZFlrUi1MWVqTnrhCRYUKmBtR6o79Wc5YSYYTQUiCkL6KqOJEodhiUeljpXQL+6cBjXpKLjdKe6LsxPSwGfdaZlgAUxTJzhEvPUkwYRzBxWfCr6HTyrgLVk1hQ2iOuapyMpIWm8/oxpH9YDQG+8Q227gU1FqWPgH+Li49mmN92u7lxORcBtOK+ts/CGpJwO2a/LcQ5HvCGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyLjqg9WwMoMFV2eVgaziaNQrG1FY/GpqgQkIaihrOc=;
 b=PbIsvFSY+4f1VZmzbRD3roXhR/WSBMxphOMQ8OHYV9FjfjZ7rJRFV+meKXJv86OjVIwLL+HVfXSan4toIjFLpHvLtlm6qMc6a0p0GAn9/4OAgQe4oD5nhOI3sojjrWxnRtD53vi2yCgpsqzBQZusx6AZgCHo62mVm55QXHkbeuY7R1whzpMIM67O1bLUk+jpi0dscURlAEbxbnCtS6/3lawUea6hJRDz3XYJGw3CXbCpAZg4eQ9sXW3NOXE+mDJGn5xbhycAn6/5TMVB14v6YGli4NaDCmcSkouWfJe5QaUI82Ty5wVTqPYHPyFdnsSmSoxsTRGZoMVxkvY6CH7f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyLjqg9WwMoMFV2eVgaziaNQrG1FY/GpqgQkIaihrOc=;
 b=Zug21dJl4AfOzWHMhy8XbnMWI85Z2HPKCj0bAS1cKBxiTEqwZL7oeilH3thkvLrbr9dNo3C8/U349iy0sAJhKIngN2R6vQ8uM+6YXlwAnQMVsZFTgdBddwccq3n4H9oDUPaao0NYeoSs74KOhRkoPslnvGoVLfCgTVeuLNLzoHY=
Received: from SJ0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:a03:2ef::10)
 by DM4PR10MB6816.namprd10.prod.outlook.com (2603:10b6:8:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 01:56:48 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::d7) by SJ0PR03CA0185.outlook.office365.com
 (2603:10b6:a03:2ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.11 via Frontend Transport; Wed,
 13 May 2026 01:56:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 01:56:46 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 12 May
 2026 20:56:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 12 May 2026 20:56:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64D1u9M42719488;
 Tue, 12 May 2026 20:56:09 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv7 0/3] various memory related fixups
Date: Tue, 12 May 2026 20:56:03 -0500
Message-ID: <20260513015606.591384-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|DM4PR10MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 9047b194-9e33-4da1-d2cf-08deb092e38e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZACSkR+wr3uCFU/opiiYb1ltvejSUJeEF0pA0WFH+Vocdy8uIKTrspWfJxkqgk7/w4Cjq+BKRdEWs9O+iGVfo+WhvdB5BxZ2XBm033X62lQTWurl4Lnl/NLcVXE3LqDo3kAz3GsNn9Blkr+jmhFGGo4e1h4wBZqwaE9vM33CfApMnOuLlfCXD1ZUdWCyWK7yc4Q5uegeFAcy5zNfWTlALIZQjKB/EFVcQAY/SCPvrLybRAd3LE72jQeDTLDa2in3hhwYjW36sIcIpUHdHDQ3zOmHuCvroBj4A4+R+8561FVlOGc/zcczSwT6ieOaCxtVh5o6fXth1l9bTZ+QdNEkjuP+kWY/HLKVOe0UJUhVjNOi2VUtuUWGYlAwuDQQyVUNKOiqP1TrCSQdbJobdyn1Y3nCb6iv2vIawAijD6NVs57DLEJ2ymwHdOdB8qlWvO5ZGzPoDpE+Bzso1N1QQ+pR5UDrtWu/LEo0VkSG4vQCB6Pn33N9IPnLkQn4i6I/qWOexzLj8yMkPCoPu0UaPsznLT4c2kORrxNfcNcy3VnOuegcvRLQii8WS+QGCE5rmTzcJh4PHwZ9XVwbQ/W8jqbo22VM5oy3nnGU5jFLUXT9KaETB4uh2g4EnMV9W9CjANcEcPWIzp/hqlKEJEjXtOi8/2zGrsa2Z8izCD97XpOWGOZpHnOOEMMWsLb2JWpKILhkNrGMbdrAqy9slmjUM87Wo1Xi6yzvA0Gj7ChIzcFX5P4=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(921020)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hlHTQ5TlyZdythpU+mFqvjMHckN/iBEQYkG6Rx9kMEhkaChBbH8GnOc9msmDyLpX3dhGPgmN/CySmrpXgSuJDq8Z96qVa9HZKxpoiwQ19HREDmbQPgcubJWfFYo2+bbnysMhDH0C+iJ+QWrh7jlxgRKQOzvHkRrkqPzk08HG8w3nAC8NGIz3V+wNwFhkV+FRq2xmsI9+nFEQ75wz5Y5sAMOgLTfq1/Iel01MShhK8GpwN5yMSLNuutWpDPf/TIDIh8GqAaQQJ4mkXfYKn4Qai+QbhOoeIXArkLdnWJJWNSmUoSll/d++ZshlxLl5dqgCdT2fYuZ4C21ZprCPkFsBTuqe66wOlaDe467OV4HG5P7pzWA4cdQIeEjJUH9jjPpgnjnrHHeH2GhBp9fMFi/1XhoTntwO93ODMNeJUeNByW0npxwkolWmokpMIe7+rAr0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 01:56:46.1459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9047b194-9e33-4da1-d2cf-08deb092e38e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6816
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


Randolph Sapp (3):
  boot_fdt_add_mem_rsv_regions: free old dtb reservations
  test: boot: add a fdt reserved region check
  memory: reserve from start_addr_sp to initial_relocaddr

 boot/image-fdt.c                  | 77 +++++++++++++++++++++++--------
 common/board_f.c                  |  9 +++-
 include/asm-generic/global_data.h |  9 ++++
 include/image.h                   |  2 +-
 lib/efi_loader/efi_memory.c       |  2 +-
 lib/lmb.c                         |  7 +--
 test/boot/Makefile                |  1 +
 test/boot/image_fdt.c             | 53 +++++++++++++++++++++
 test/cmd_ut.c                     |  2 +
 test/py/tests/test_suite.py       |  2 +-
 10 files changed, 137 insertions(+), 27 deletions(-)
 create mode 100644 test/boot/image_fdt.c

-- 
2.54.0

