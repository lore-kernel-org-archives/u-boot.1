Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 244E7CD6E4A
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A12B084999;
	Thu,  4 Jun 2026 17:51:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="psSZ5+1L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE3078497F; Thu,  4 Jun 2026 17:51:14 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 961BF84874
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDXrvpYOh1JG/VBIgXIGzWD4jan45dfnJjAIBs23InpkkSgU2XejFH2z3nDXpuEip1bgwZGlmsKykn1jafwWoR0OPhgkKszfUBwWCXOj3niIqQtCdCJWPtgsQjArC1OdbHRgipvlu+1ZkL/cBOQnD2UsWEJomT6te2UgAIa8cSjG1ANLio+wNcAIGaTJuV6tshecv9+qe7cQv00I9HfgsCuMhXHJgLsU+lDcCueI1DW1sj6MFpoPTkARQeYVE+p0qv4sVcSnWCC2AkEYfEKQAEsAQD1PV5/SqsTv7eX5bQzYcGaAFGmFPaX6FlM2cTPbZBnP0jMD1DoGmbHz3rwlsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsS6dQ1yG9sqosON1yXUppV8T0Egd1xcUSlK3SY7zi8=;
 b=i2LFTeVIoKcnBiChN0Hl8IPohGTtuLngd+9AuMedYuPfxx9OxALIDc+YS+Q1tbv7eKokUHfwoq1mRAr3HW9sRG5gPtlw6ufQD/k3u/jhw0CV1FqAhqqtpZmG0Tgn9l9ww3/chdTilRAhaypUShpIRnJOyQwBCVD9oWS8qT+U+aGIFzVvZqbPvf8hYcj37UKpM5vxM1uXENZIUgC/Nn4I3IKBK4dpHmK9+VpTCUTm8/CDZkIrM8Ui1eqN2/gBrPjn1Pxm+V4585YJIDTLd7Ab4lKiMtU3ITbFxyQvUNRDhzRH1uhbiqPEh44AoUehLNGJs8vZuPUZj9CZCV1kqkgAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsS6dQ1yG9sqosON1yXUppV8T0Egd1xcUSlK3SY7zi8=;
 b=psSZ5+1LiWSNJ7hzNZ6SNtnEjg0/TJLoV288tkuMLy/wKz27Xv66hPtbMg6yPG5LSefqrfv/4pjpMiCZBt/0tMAFV8WcrdvsbVEUiTLZDaXWH8O9VizfLyHG5GT0wp6ZaS1aaIOEhtyX3mtBzL5O4/Tvy1k4FEUIpqcpyz5uWLc=
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by DS0PR10MB6845.namprd10.prod.outlook.com (2603:10b6:8:13e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 15:51:07 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::a) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 15:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 15:51:06 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:43 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 4 Jun
 2026 10:50:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 4 Jun 2026 10:50:42 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 654FogOr017019;
 Thu, 4 Jun 2026 10:50:42 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv10 0/4] various memory related fixups
Date: Thu, 4 Jun 2026 10:50:34 -0500
Message-ID: <20260604155038.3182-1-rs@ti.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS0PR10MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c4d55f-7f9e-4dfb-acc9-08dec25116e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|921020|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: cRNDfN2cXmJzgZmjTk0XadkimwGL5ZC61DWXoOD/oYcojfxPWUvpd3dEJZzLBiQbY0FkOYM89OpR+giF99v8jhAvEtmBwT1d+B1tTX4ntxNKBhpPceBbhdWgafrXasHVaTblfPoMCtDyj9GlfAgW9wAT0R1r1kLUNsh7FVw1U3UH7M61hGn/CyZaGUlLVD5dSZGbz+HyHbzQFJ0oeqkHDZStsZEFjytg2iy+vDNKkf5/efmUGJit++zlW6N0Sm1Hy3CM7HdneX/ZYki8/XlEpqWZobdz59DK9b9yp2juESZpaQSzssNZR0vix3G2/dNwTUgK9D/vBST+lhNRbycbzHo29jt3ybk3OvhIKUZarTCREn/lhNNk556A4jjc7BZpElyMpexsM/D6/CFn+TAq0qcYXJGY6xqchGVd0OK3Tz6aHNx0/0RYs+5JAZ3+D11JVhGDjjmrmmSLWawvM1Z+zf7CEMoAikbug0gJUV2AZ4oW3SS3tFUN89H2kdNtev7lyODdIkGni4j/koAjvjBit88jHlc2WhX1u/kGfhcnduZeGcf5f74Qsd0UrVcHec3cj4lx+dQCIXOz17kTQ3SACKlhUUBQFBgU/qum+C6JyoGMbsEVpPersR27KxpBnR0KBF22jXsYNZSSh948F7x8Q8LqB5r1x8w4gCLzSYffSfSLhH2xOmzFRstew6Gh+mybrDwZkgm6XQgdF7Qn6Xw8MMOqasnVDSTaKwFnxaENNYM=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(921020)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f7/UmKQyqVehDz+w0/SWd+VE5sMIl5YnS1gInxmdd1iYhE+TMQASu57ceXjLpH6bdX0L0dQZRtodn5jftr0+fNIFhBCebbfeKQdoCGOPwXgkyhc4E/+0kibuwWy3yFRMo3QKXcgbvvunJKT3SDpw/3+UHXZ+CBfhm4MUwuvrd9j3RjgG9B3ys9VHGVDMXTN0T8QeNrRnN8Ba1kMKJ6kN3u/zSAF3b9gPFPjOF/vI392nmOceeo7qilyB1ekU/CnQE7AjxW44V3vQxplkt4aLPyvgVTyGwDIIQZ4H0UT/EDjq74+aUBEQTOFDP3mvC5uNeJ8dhONi75/aOBHWyWs7Eyw+y8eYPHtUX8P0SyYlnB6hz3wBYiZ2b+mBeahBL/iJVJaYPGgatfhkQ6MoW7J/nVVRHF/yd3jVOrVDwauTmhWPXxWWelWvaT+vBKXbfKWW
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 15:51:06.5173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c4d55f-7f9e-4dfb-acc9-08dec25116e7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6845
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
v10:
	- Fix CI issues


Randolph Sapp (4):
  boot: image-fdt: free old dtb reservations
  test_ut: add a ut_ubman fixture to clean up tests
  test: boot: add a fdt reserved region check
  memory: reserve from start_addr_sp to initial_relocaddr

 boot/image-fdt.c                  | 77 ++++++++++++++++++++--------
 common/board_f.c                  |  9 +++-
 include/asm-generic/global_data.h |  9 ++++
 include/image.h                   |  2 +-
 lib/efi_loader/efi_memory.c       |  2 +-
 lib/lmb.c                         |  7 +--
 test/boot/Makefile                |  3 ++
 test/boot/image_fdt.c             | 83 +++++++++++++++++++++++++++++++
 test/cmd_ut.c                     |  2 +
 test/py/tests/test_suite.py       |  2 +-
 test/py/tests/test_ut.py          | 26 ++++++++--
 11 files changed, 190 insertions(+), 32 deletions(-)
 create mode 100644 test/boot/image_fdt.c

-- 
2.54.0

