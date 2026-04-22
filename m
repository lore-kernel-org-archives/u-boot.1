Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC36FA1FD7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 17:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9346843D1;
	Wed, 22 Apr 2026 19:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U3RUgnb6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8252984370; Wed, 22 Apr 2026 19:10:15 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A109A84370
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 19:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3OSRSFTR3OkKeR1oIbYI8/26M/PoU4j589prv8RAB2KBcKXDBfRuxbS5YkO7L9/xpGnoswrFRSbJ8OsNyFTZn/TjcN/q8u6jqm8fMjrMdN6+VpOadLHImvGcaZV5wnSu2Dcl/MQVjl21E4hDjsNAIKF+zH4UM4hz6mzDcq+URW/JUGHMmOYkQYPx0N+jyT96uTDiGxaIYibGPGbFNDjfEkl/a+X+TAveMW2wQDNeosZTkRgXO+dWlZHFUriK2gLvu0gMBisRX79SbKtTcUY1+OnOhIrFgf2Sj36XZUFPp8X0C1qPwXA5VJ2crx0NcsSZnmXVo2FQQu+8ofEAZxQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQ7D/IqiXbP5zfjD/wnl73Rkq3Dx3yvu1qsK+ilOmg8=;
 b=bpvOWhDoLCa388DhTIHBVFu99y+skEGTVGAuIL22qVPzga1Wvk+XNgvFShJGwGN3N5kXjd1dC4CKyx9FYHP9eRbeGEaPIQ6LlUOvu98m7jc05H5Cqg+6Kq7yiEXIaeVv8mK52wv3HAbmdn0imeYvBacB9xbt1t9mgtJdIahiHr4K+g/3svMV8qu9mMtH+zf9uss1d4GXClkTgZwCEccf8UwkgEiAgfugUoVplQIDOINpnkeZ1FljjPYA3KqWKUD0u7Umh1ggU55mxeESmILTHfDdHFN+5vdHC+gX7bPlwqc8D4xhKoo7r6B1rBwvm1ryj4cTCjIuDSypCwhWumAH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQ7D/IqiXbP5zfjD/wnl73Rkq3Dx3yvu1qsK+ilOmg8=;
 b=U3RUgnb6mfHiv894omIjO/XI9P5RVkObMGPxk7/D2YpnbzDpTtVl1Is7W0/Y9XN1R0236IoP87ixp5/10fAGD1DzxsuOslBO8J5at1ZLXoquiq3nTx8mFmqhQ9yXdSH4d3jfA4lyFVwh1vvoqycck+otXj0stCoD2woqOFc5a2g=
Received: from CH2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:610:5b::33)
 by EAYPR10MB997831.namprd10.prod.outlook.com (2603:10b6:303:2c0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 17:10:08 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::5f) by CH2PR07CA0059.outlook.office365.com
 (2603:10b6:610:5b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 17:10:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 17:10:06 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Apr
 2026 12:09:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Apr 2026 12:09:57 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63MH9uPK2769561;
 Wed, 22 Apr 2026 12:09:56 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv5 0/6] various memory related fixups
Date: Wed, 22 Apr 2026 12:09:40 -0500
Message-ID: <20260422170946.3394481-1-rs@ti.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|EAYPR10MB997831:EE_
X-MS-Office365-Filtering-Correlation-Id: 35eeaaa7-76ee-4d0b-7218-08dea0920093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: g4YNALJCCdLky0wY9bRevFhV2UDtooB3yQCQTQ2v1W4zC7ewJpvzGNdlj/0NARCFGRiegSKo8mEjWQxQIMPRARgrhy6kHRoecRdJjxSSXxO3NoUW4ITRvOiqTC3eQZws6MC1LvyYNruiIRYoVuCSvX1yEZ+qOLX8a/ZdSnw+BPkoSIs5kThKqFOHGj3cQI0o3OderDBEN8s3ao3Qf2WHgmFPyzVfDMGlUk9CZmX3ChYwV46QDnakFFo3E0dOuMUE+0GfqCyeCxTM/IJmg9F17i/Ha8wvPWkQNej/99RLJ+2+HjQ6CkVQpUS2amrlaYQqV9/bI1o3k4lbZkKmRG5WgE3MacZpfFIhuTpNvVW+3U9oEo/UpfvH8di2gkCpzHAzIBtaw3WRcqo3Wptn1taF3Wfjyh4ZfPs7gIKLx02iVf/xXXtqy1JWzdo5tW+hBflTWNzP4/r9gnNUA7GQAKWgOc/RqiG+MsiP+GZbzDLvxMAmmFsZl2IAmTIAFtEtnvglUq9aiql4YVy8iamPpLC2V5kAaD+vnhaeb1qBAuqh0y9hzr0WxUq3xmtCU9BwGMLFe6052Ip43C5L5mhjrNqQPRHKHsnYPyEWaYGAemdzCnMv/G7SvbTp/YpseWPCQlrOKNS4MyAtRd7s5dF+gtMVXq56OJckj/eflC9LTkUTexyxuo9slK4JLfpT3njesQjWUm0C8BSxR+SiSaVrIc9bVU2zBt/chsnft/Pga0iy171VhtxPawoeGNfINGfy/C9ktOFRdgw/q+0fFvDCpY91zSTPMu7RH1WPjHT/XkxOZng=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hRKrg6eP3PRZ24BxfazPNK5LEHYQ5cjAg2owtLEZ3rWL8VZU+CTQ9uhLJK8n3bMHyAUsKgtzHZxfcF1ZWkpI8NzxrBNsFEEkmZnMLTKjpkrsZsTl60ij7me7yjd2pExkfuMSimbw9Q8cz9Mt99AetAO0lF36ZQZ0g2exBYnHiFM3WwNGVoQkYIFR1h1S0Lop/ViGIGP/NoEVIkU9Hzguj3+LHIS41Lq7tHokNng5/SXS4A/T/w7LKRvKX/j2wt8i/vndb0WgDgrWYN2TuW5NaKuyN1TTkXYD/rk+oD9UDwTu5Wk3EM+rnmGTouwveGIQzEZYogvUCrWgHqPeBl/M3UfIpYmJTw//M0u0dbWa7QAUfXmcRSgc13pP4jzpK68FnVUcv4eL+tQUaPrNLpaK4slyJk/isypb13ghpUDCHLAa4Ki4GGaCZmfplDtgmtj6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 17:10:06.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35eeaaa7-76ee-4d0b-7218-08dea0920093
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997831
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
 boot/image-fdt.c                       | 55 ++++++++++++++++++--------
 common/board_f.c                       |  9 ++++-
 include/asm-generic/global_data.h      |  7 ++++
 include/image.h                        |  2 +-
 include/lmb.h                          | 30 +++++++++++---
 lib/efi_loader/efi_dt_fixup.c          |  3 +-
 lib/efi_loader/efi_memory.c            | 49 ++++++++---------------
 lib/efi_selftest/efi_selftest_memory.c | 21 +++++-----
 lib/lmb.c                              | 41 ++++---------------
 13 files changed, 118 insertions(+), 107 deletions(-)

-- 
2.53.0

