Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC96DCCF9EB
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C14883849;
	Fri, 31 Oct 2025 08:38:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tk8l7Qzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EDA1836F0; Fri, 31 Oct 2025 08:38:14 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D62098331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV94vYJy/GknyH+m8xt187iZiAoUvCjVwVoXM6Btpp/QxYB6PFmIaLf1IotvJRAD+io1uNLhNTORpNy4DAQyIFahuRW4o541I8u1uv6uEeA17V8+fKrixFrs0P0vwAgckXmu0NAtERrE3vaSnHuw8Cgc01lwDlC98R4SnbHxRJvx1bzOYWOKcJ9kT2pe2gfLihfzQCHhKVG54s6J7zZQbZso9+g2BQpM2liCTEn4yJWCKb7FqZ11JUl/L4eKRbhurzQSU54Kk+mJYy7pYW3bXfJn3RcsD80HjPB8B1+OxmfII37vIpr90fPdma/CYcQSpc4vy3wInrNKe4yA3REhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vix1z9NuL2zCcwMGaWAUmluS1NbrhZsEl7NCrISwSk=;
 b=nYb9vVkUJ6FVY7rSoVC7iHVbNaMqXcUFZki+BQk8ralPKR3c3gRBs1V9gfaTKZw2DRp/ArFZo9wzqoSIQZWa2BiUDrHX/wQcOqpLRYESGzYJMaPIynIzxG9712hvVOa8L17+P0mqRB+IKUCfOZzf7WoJLgOQ+oV4dtCDKRLWN3af6avZ/dMfcJrwpt6TYgKbAAwJ/WmX6fhZIp64GU6TKTNQTOLddK2Fq58wYdaPQCfr/EZtPgZvMB2uAJfwcmdDrXeIqSrgqEfkrihEebIQFEy86DR7pjBMZS4sevFWQeOgJ3ockPMaLvIv17CCroJE0TWIk4rvvRzZXhjzQpbV0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Vix1z9NuL2zCcwMGaWAUmluS1NbrhZsEl7NCrISwSk=;
 b=Tk8l7Qzot4Z6uphsVs1Q5kcKj331MlNmiChYPVgTNUQqy8fQ8xZsZYGj7VAMAQbFjpur5npROZKcoQRyd42iwaD2i0hXfIuL2NNgezoE9Bq6/NQjuFRlYzQuKnY1ck+0SMcMuC0ZBxIDPtWxN/5Ob9mJky8/MpVRIvfLXTh0sbE=
Received: from BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32) by
 CY5PR10MB6190.namprd10.prod.outlook.com (2603:10b6:930:32::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 07:38:08 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:94:cafe::84) by BYAPR01CA0055.outlook.office365.com
 (2603:10b6:a03:94::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:38:07 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:06 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 02:38:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 02:38:06 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59V7c55p3539845;
 Fri, 31 Oct 2025 02:38:06 -0500
From: Anshul Dalal <anshuld@ti.com>
To: 
CC: Anshul Dalal <anshuld@ti.com>, <afd@ti.com>, <b-liu@ti.com>, <bb@ti.com>, 
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <nm@ti.com>, <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>
Subject: [PATCH v10 0/7] Allow falcon boot from R5 SPL on TI's AM62 devices
Date: Fri, 31 Oct 2025 13:07:50 +0530
Message-ID: <20251031073800.344500-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CY5PR10MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cec2c1d-342e-4ed2-655e-08de18506f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iCLNCBvm3+cWx85McYgPRlktNdpAJES/P1UNNqvGu2gOj6YoR6qLfRUxebEC?=
 =?us-ascii?Q?1j7be9+ft7YNK1PX+J/zKFNm9rR3lKaKDDo/zdg0VUgPERmOpLRKcS9wqIuF?=
 =?us-ascii?Q?IrI7g5M73aVJK4+HIgLMRwhJDzWKcZIkdXOJg4RGJ4ZR2KH8dmBq0fqlXReq?=
 =?us-ascii?Q?JXLQ3YqQdppWeTJl91iE68V1wDRfoxzj2Cc9L5VE0viWtBPv5+UN5JI1Q5Ml?=
 =?us-ascii?Q?FSXeYvPVUtCkYxkR768aW7yWXuDOaEMdgBk99OTJwegRH3HN35msENgkrYFt?=
 =?us-ascii?Q?WWJjRI3AK85Auw+xykcHHAj3QwNNQWv1Ti+n3S9ln5FbyhwjfL+9TcnWjfJu?=
 =?us-ascii?Q?6CgJuM/4sbfrjTiW8j7gIM9RN9GFiyeDD8ob1ZnM+S6PmUCOpqn73YeaWF43?=
 =?us-ascii?Q?AZOu1Jl2aEV+Z4c66s9wLKM9QM2OBSobzO7RRHEuq7qjyn/qYSovs+Msz1qB?=
 =?us-ascii?Q?X7XxG6pD6gVcr0YBiIaIe7OhEdr2TmT4/h5sa0VbYXGPT8MccgTHDYxUWsGa?=
 =?us-ascii?Q?qSOLkZPt5KWwmhFHUiUWNKznUWpifP58tu17BALCpfMEMdWTp3FphYhIL6VJ?=
 =?us-ascii?Q?uXO4PjcZRIiFWyIuFv6CyoXPqYS/XY1k5NTUQMFo0Fu912SbUL8OWS3K26nL?=
 =?us-ascii?Q?pVut5dJ+5995+gTPlSMsYi1WDqdavihHRohog3cXuGvtU1pmXjAfYFZlMThm?=
 =?us-ascii?Q?oThrtUdLEfbb76m3twqWakmjrY4wtM5Vf/11bf6Uo3D3YJ1kEhp4cbJgZQiq?=
 =?us-ascii?Q?QiJ13eU3Kmg6Jrj92Pm/dBjk7iU/uO0FK9KX1tvClsWw46amvxE03I7y7l06?=
 =?us-ascii?Q?32kDI2THxqP5hNM2E4QN0mVtKjrPfWX7zONtFmDTSXtfPF/BerjmtLoqylk+?=
 =?us-ascii?Q?xC5ftBSUKGytq+XS7TvquLmgBaEQx2r7jInC2goXVbRT9nAgubaiBYC6qOTS?=
 =?us-ascii?Q?sxywSKL9+fVnwa9/pKVgeFgZs1Ll3kuInpJmwRWCt9SJCPDoZoOtgyqh+OyP?=
 =?us-ascii?Q?ieUZoDY8XyuozSpTcBSnmbQzQ6HD9a+thfM+3Mv2F8t1SXKYcTelJ+A4uLY6?=
 =?us-ascii?Q?FtJhL/8soLydALIFhtpwsB25V9LYJPn9aAewRa3WRkgfnAAz6VX5Xi6W3QV8?=
 =?us-ascii?Q?LUbDqvyWhQmAgxzZMKh6E1XtAK82AEnOI1qYhhzzRGrLIPzHRsoppKvLcUeA?=
 =?us-ascii?Q?YB387STUZesxVHVB0UiqM8z5CIM08rePnKxB8jCEBNcUj8U30ZRgnF+PgwH8?=
 =?us-ascii?Q?W3hSexYEitE7rWfOypc1Kwoc+hIIj5/27Xm3DoI9U08F1+1AU6hZJU3zOHcH?=
 =?us-ascii?Q?wauwspF35ipUbnXPLN3721PxqAafBe4SXTQNLJ4y9LMxY5VpgUrlEIA6etpZ?=
 =?us-ascii?Q?CxwcqDwkWWHGjUa0LWFeHNUkSc71torQ1TaFOtU+w7gpnIkpUDOr/nvQEBk3?=
 =?us-ascii?Q?tkNv14aa5lVmzVdFHcPOZS4yWWxVkwrzRws4r0BY9raBM/qeIsmdOvmLlHnR?=
 =?us-ascii?Q?1b6VGytlINLaulhs1p+8XUyDDp/LO3081xyv3IreYTreh/kBLJTWreR8NQ9i?=
 =?us-ascii?Q?oClDu7xHy+T88OpCpS4=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:38:07.7165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cec2c1d-342e-4ed2-655e-08de18506f5f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6190
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

Hi all,

This patch set adds support for falcon boot on AM62a, 62p and 62x by bypassing
A53 SPL and U-boot.

Existing Boot flow:
R5 SPL -> ATF -> A53 SPL -> U-Boot -> Linux Kernel

Updated flow:
R5 SPL -> ATF -> Linux Kernel

U-Boot's falcon mode expects the jump from SPL to kernel to happen on the same
core which is not directly applicable for our heterogeneous platforms since
ATF, OPTEE and other non SPL binaries from tispl.bin should be loaded before the
kernel by the R5 SPL.

So we have to use a different flow to bypass A53 SPL and U-Boot, we first load
the newly added tispl_falcon.bin instead of tispl.bin which lacks u-boot-spl.bin
(A53's SPL) and the corresponding fdt. This sets up dm, tifs, optee and
atf. Once loaded, we load the kernel and the dtb (with fixups) at ATF's
PRELOADED_BL33_BASE and K3_HW_CONFIG_BASE.

NOTE:

Since we're now using the SPL to load the kernel and kernel expects a 2MiB
aligned load address, the existing PRELOADED_BL33_BASE has to be changed for ATF
to 0x82000000 with K3_HW_CONFIG_BASE set to 0x88000000 for the DTB.

Depends on:
  [PATCH v3 0/4] Allow falcon boot from A-core SPL on K3 devices
  https://lore.kernel.org/u-boot/20251024081408.1610102-1-anshuld@ti.com/

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v10:
 * Fixed null check for loader
 * Expanded commit messages
 * Merge [8/8] of last series to [1/8]
 * Restructure falcon mode fragment for clarity
v9: https://lore.kernel.org/u-boot/20251030051937.3659010-1-anshuld@ti.com/
Changes in v9:
 * Update the boot flow diagram in documentation
 * Refactor the documentation diagram into am62x_sk.rst
v8: https://lore.kernel.org/u-boot/20251027130004.2156121-1-anshuld@ti.com/
Changes in v8:
 * Base the series on the recently added support for secure falcon mode
 * Split the [8/10] patch of previous series to multiple commits
 * Move R5 falcon mode logic from k3/common.c to k3/r5/common.c
 * Load `tifalcon.bin` from rootfs even in raw eMMC boot to simplify usage
 * Drop the section on 'SPI usage' in the documentation
v7: https://lore.kernel.org/u-boot/20250603142452.2707171-1-anshuld@ti.com/
Changes in v7:
 * Replaced AM62a/p documentation with a hyperlink to AM62x's docs
 * Made CMD_BOOTZ disabled for TI_SECURE_DEVICE
v6: https://lore.kernel.org/u-boot/20250428141235.1734014-1-anshuld@ti.com/
Changes in v6:
 * Added A53 build steps in docs
 * Had git add SVGs as text instead of blob
 * Added memory map for standard boot flow
v5: https://lore.kernel.org/u-boot/20250425145644.2228186-1-anshuld@ti.com/
Changes in v5:
 * Added documentation
 * Moved address for kernel and dtb to 0x82000000 and 0x88000000 respectively
v4: https://lore.kernel.org/u-boot/20250416074515.1452854-1-anshuld@ti.com/
Changes in v4:
 * Move emmc boot fixes to saperate patch
 * Update load address for kernel to 0x82200000
 * Add jump_stub config
v3: https://lore.kernel.org/u-boot/20250403215910.1292922-1-anshuld@ti.com/
Changes in v3:
 * Make tifs load and entry address consistent with tispl for am62a and 62p
 * Update loadables order to be same as tispl.bin
 * Use rootfs for boot instead of boot partition
 * Disable SPL_HAS_BOOTZ to save space
 * Add default dtbs for each board in Kconfig
 * Fix fdt totalsize in the header before applying fixups
 * Update Makefile to clean tispl_falcon.bin on `make clean`
v2: https://lore.kernel.org/u-boot/20250311095758.3383047-1-anshuld@ti.com/
Changes in v2:
 * Move to CONFIG_SYS_SPI_*
 * Remove the need for CMD_BOOTI
v1: https://lore.kernel.org/u-boot/20250307075541.2571104-1-anshuld@ti.com/
---
Anshul Dalal (7):
  arm: k3-binman: add tifalcon.bin for falcon mode
  configs: add falcon mode fragment for k3 devices
  mach-k3: common: enable falcon mode from R5 SPL
  mach-k3: common: support only MMC in R5 falcon mode
  mach-k3: r5: common: add fdt fixups for falcon mode
  mach-k3: r5: common: add bootargs to kernel's dtb
  doc: ti: document R5 falcon mode for AM62 platforms

 Makefile                                      |   2 +-
 arch/arm/dts/k3-am625-sk-binman.dtsi          |  64 ++++
 arch/arm/dts/k3-am62a-sk-binman.dtsi          |  51 +++
 arch/arm/dts/k3-am62p-sk-binman.dtsi          |  51 +++
 arch/arm/dts/k3-binman.dtsi                   |  54 +++
 arch/arm/mach-k3/am62ax/am62a7_init.c         |   4 +
 arch/arm/mach-k3/am62px/am62p5_init.c         |   4 +
 arch/arm/mach-k3/am62x/am625_init.c           |   4 +
 arch/arm/mach-k3/common.c                     |   8 +
 arch/arm/mach-k3/common.h                     |   5 +
 arch/arm/mach-k3/r5/common.c                  | 146 ++++++++
 configs/k3_r5_falcon.config                   |  39 +++
 doc/board/ti/am62ax_sk.rst                    |  31 ++
 doc/board/ti/am62px_sk.rst                    |  31 ++
 doc/board/ti/am62x_sk.rst                     | 319 ++++++++++++++++++
 doc/board/ti/img/fitImage_falcon.svg          | 180 ++++++++++
 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg | 285 ++++++++++++++++
 17 files changed, 1277 insertions(+), 1 deletion(-)
 create mode 100644 configs/k3_r5_falcon.config
 create mode 100644 doc/board/ti/img/fitImage_falcon.svg
 create mode 100644 doc/board/ti/img/tifsstub_dm_tifalcon.bin.svg

-- 
2.51.0

