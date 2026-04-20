Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2722F5A8B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 19:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B128432A;
	Mon, 20 Apr 2026 21:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EVw6WJ2d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B94FF84390; Mon, 20 Apr 2026 21:25:32 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6397984347
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 21:25:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYGP5jYrnENpke810U5SrGtaHqbTaGZu4qCwXB77VAan6YCSH7+M8AwF3eIOH1usAuNlA+GnWZSbcMUx3b7PsnkcWzqsAkYOlSAiTZHUpYmwFHqAQm/CQN6uk/owojWID3keqwNtqAfB5htljxxUVwZDc7mlKRLej7KzRB5mtwqaEKbI7eEzUgp3N4F40tWKByPSxZ58V8Oedb0QIpfYdS9Scd7BapG0cIYaJDLw5XerFyiflzHlT183VoG8mVhdYVyfOvi6z6p7zSstw7KeqUh2j1E690RWEh8Q+h/r3LV81Ysh2rcb7crTlsbsf8mZhmZtUsTXaUP97wPOSG9swg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aKX+JcqiXRNQE3yaljj6bI/Wh0Qwx1U/hB18oJYDJS4=;
 b=rfGWb1H2JnIJdZzsMCcGsbpmIYsKVK+kEkqKFxUwDeG+jhLiiz3YO56bZW7rYoiOONI3J2kHzqA783IDIIlH69ZTOOW506VO23oaPWwUsHPChNaRpQufEqNqmk2w6clI228qH9+8R/FBOEqMQtvws32D53fwiClraL7zZGXV9xPw2vInXzlyNnYbgweoPt6HmsGhbWhNPtgeWbTljgTTdvkrbDSxZgeCUVzbSOZCD70Gyk9V/R5zvqEllQBnWUaiMZOzkRsliYP+51qSZUwlkZqWRwlPapeN/LoPztpjBnDuaohhtMqTSJmO7aT8z6K4FxKbh9UvRNF3ZXipRg6U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aKX+JcqiXRNQE3yaljj6bI/Wh0Qwx1U/hB18oJYDJS4=;
 b=EVw6WJ2dAijw4mr4ZN8BZxWsb5vMw5vrdvyOMECrkubDmbDMj653SASa74ZJfqrKT1YGy4h6gYRTyhK/U+uCO9ruJxSZSm9orkSjPDf+qteksHn1BsvA6gG8DJLfHmmTvq1RttEHhTLg65SCDWnJuycc3AMNq02Pid8H9OStMZQ=
Received: from SJ0PR03CA0065.namprd03.prod.outlook.com (2603:10b6:a03:331::10)
 by DM6PR10MB4348.namprd10.prod.outlook.com (2603:10b6:5:21e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Mon, 20 Apr
 2026 19:25:26 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::9c) by SJ0PR03CA0065.outlook.office365.com
 (2603:10b6:a03:331::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Mon,
 20 Apr 2026 19:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Mon, 20 Apr 2026 19:25:24 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 20 Apr
 2026 14:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 20 Apr 2026 14:25:23 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63KJPNh33399024;
 Mon, 20 Apr 2026 14:25:23 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv4 0/6] various memory related fixups
Date: Mon, 20 Apr 2026 14:25:14 -0500
Message-ID: <20260420192520.1444749-1-rs@ti.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|DM6PR10MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3af94b-1bc7-4dde-a2dc-08de9f12924b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: plnMjLt8IbRVguccaET8Gt6hWjPJL7KXYV2frR9a+wmZzuJoJjd+Wl6bbSVhvQGuaUPlyugYAQ3j6nxKWR8h2DmO/Z0T+5FXEc2tBDiLv0GptPA+MKUF+Ys2BSZhRnZ5iOYZwlZTcoq7tOTDaLhpznXIqoAuxOGtmMkjSPBoz72Jr5CwTIugRnLhEgOurQ+r4Y74l3En2lQUPyuUhDyGQmvSrq0m9yet6PrabZSIpzn1u12KY9J/gV6RsBoOScuCs0gJVfsUab6+BVE7iMaMKE6Qmoi+Ms64kFEE7kCeVH9VlL1+B8t5653tREe8I/ujci4ab6SvaAaD1Z6hTuWuwbydpaON36MbOg6cPpStihF3sNA+fUbPGUuBmB5jwMd2sOPUzW1HQRWEazgXV+oaEMXucHXxlIEJGGBRS0w29ds+a3CZKJnNQ6mKTAki3jqlDS2HKTI0Vw7COA3+mlBXqOYjIHKszdKkXzOXiZS+AsS8Zsq/skeJFNypYCPpqPhiMGL1PQMuYtKGER8iCNsA7Ay4mGFzvT1dl/pSIsljgj6N1Da8RrT4e82+C2IEUC2cHevyyA/Y9S0EUDUIGPzMSffA4xiZ1Vtc6qKj4LZG8M/cGAfZfSjmbv+LdXEVPMTNbpOPjOcJsmEZba36mWV3fNiu5nG7jBXJ9b9764f44dnFUtpJ9wbUW53r8PU675vhfF6fCBJZ+X8U8MKxtbV3iJijiFi6V7LS3GIWFT9RqJV+UQFYXWBGuQlPFsOFvao6ysqx4aXoeNaqt3M737klF09dufrf734/knRWqmBH/l8=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lByziaAhuRjR0sm4Xm0gWebO9bqkceCB9sTXmirx1yRSAvGWJ6BZBzW/ukgLJGbTPf4QgRkStN9IU5ZIMbxi63zBPuK2XQ4n3Hlt6OTHfXKr0JUcm1dxUdPxhF/JxoD97wRsuq/6tOzenE+2vM/Hqdd2uLgNzi4o52JdcP343OQHxSkk2nJ3tWkqODERqGy9RFHXu+euNi9A2d+A51wdnxUAxaKYk7dcmIOOqviL6PkOZqXSpydKBozoEx+qURHRSorqM1xCdYliizedUaxeIeIYQIQEDiu22+b+l92rlJi8wkZNE6AwGfo7eGRY9eHurd2tfKzVOqiOvvrspBc9xfHT6QSaoZLDQuBKN6p73T+cEnXWzZ2MciYIxtACzlxlpQCB92hwAV+7VukuJ7IMGXcJQGQTb4HbNDmIuO/EhsPnLhcZB2ll57FxTHdYzigk
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 19:25:24.4543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3af94b-1bc7-4dde-a2dc-08de9f12924b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4348
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


Randolph Sapp (6):
  lmb: allocation flags macro documentation
  boot_fdt_add_mem_rsv_regions: free old dtb reservations
  efi_dt_fixup: use fdtdec_get_bool
  efi_selftest_memory: check for duplicates first
  efi_mem_sort: use list_for_each_entry_safe instead
  memory: reserve from start_addr_sp to initial_relocaddr

 arch/mips/lib/bootm.c                  |  2 +-
 boot/bootm.c                           |  2 +-
 boot/bootm_os.c                        |  2 +-
 boot/image-board.c                     |  2 +-
 boot/image-fdt.c                       | 57 ++++++++++++++++++--------
 common/board_f.c                       |  9 +++-
 include/asm-generic/global_data.h      |  7 ++++
 include/image.h                        |  2 +-
 include/lmb.h                          | 30 +++++++++++---
 lib/efi_loader/efi_dt_fixup.c          |  3 +-
 lib/efi_loader/efi_memory.c            | 56 ++++++++++---------------
 lib/efi_selftest/efi_selftest_memory.c | 21 +++++-----
 lib/lmb.c                              | 41 ++++--------------
 13 files changed, 124 insertions(+), 110 deletions(-)

-- 
2.53.0

