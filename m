Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E066C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041CC84AE9;
	Tue, 30 Jun 2026 14:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="cvNfTJ2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94A8C84A48; Tue, 30 Jun 2026 08:56:57 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1903484979
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 08:56:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AozjA6Jpo839B/84qhnVnzDHuo/UfQRsGl/ZSXDYYsrSIRvs+MJT8ajglk9YaJpqzBy2Kf/9xiigv9ZYboBl6LOuXRFAimSjJGyIZWtO6DMfb1jFZIwsZYFEHhOWYhLQAOw0sXIG+6BWerFzj7BCV5P+K0sFvgchzmTwhD9m+QCPRVNnfajm++h/weDLPkIe4c1lTcoEBuK/i4rN9fVKWOW+n7QM7TFt66WTtAgMckO/cpBkN4pA5Foxzwl6J9pP0h7KxAvvxp/wSuqXbWn9Dz1hIQ2hWjV0+lVlcrtLpKwckiV5dQp8/usYudr8tgfgxl3hF3YfafQ7lsekxABvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOqt/IOIWLPl6YyQg4rPy9QGSTMXbjOSpwu4i14VnQc=;
 b=f2YEgUubyzxohaUzDl07fehd/Ixb6VUN6RMtV3p6fXkqv+DrHOxW8wHmmelWZOahY3aAxt+PzM82kRtDhnjybXsgIEWw2XsWZnDbJXz+rlI4VCXz/3jtq5cxbPpAmHL0JET9T0d8fODO8n1r8CjfpQtGq5Lwkt+rjLOsk4hBDOwXTrLZqMcePvJxAA7tN+/QekjfLbWekJNVdDY4G3esVbI8oUXcpKZ1RYlfALpbxshmCeOtrcRqXkqKe0D/t0z/c+wutRp0gMxCmtRxDEcDFs5DlZCFJ+lG0HmZU6EFy8GcxjMzJAt0x/WWTRnYl0MmIsJvvyu7kReWqLFdoG7/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOqt/IOIWLPl6YyQg4rPy9QGSTMXbjOSpwu4i14VnQc=;
 b=cvNfTJ2ZhDFAJ4gjcWdAcdLhbBceD5KdlDPNzlMORAnSRPx/n6XDwOEyeDtYdgNPjcDuWVNqM6rqgj2RiaOXkrFNI6o20c3vCh9w9n9ed3/VrrWRM9EQoUYgJ5PpKt1rZ4uNGQighaYW2KnDjUVicvDgYPrcLDbX3utGwr4XczYAJRDhmo1/7ObUiNVLmZKb/pY12D6tGt7YG6C5Epwi1Z+v+Y5iSK7D8H+9uHQnnjilrhIqFABGWNTvegIVROIaL21DKWX8hEEi6YVdZyAblDxjd0ExtbRN5tuiue5nKHlkLSPFwok3nlaLupfhPWo1OZ5NUsiCt9QoTmKc/tp0Ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by MN2PR03MB5085.namprd03.prod.outlook.com (2603:10b6:208:1ab::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:56:49 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 06:56:49 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Dinesh Maniyam <dinesh.maniyam@intel.com>,
 Chee Hong Ang <chee.hong.ang@intel.com>,
 Chee Tien Fong <tien.fong.chee@intel.com>,
 Chin-Liang See <chin.liang.see@intel.com>,
 Dinh Nguyen <dinh.nguyen@intel.com>, Jit Loon Lim <jit.loon.lim@intel.com>,
 Ley Foon Tan <ley.foon.tan@intel.com>,
 Lim Siew Chin <elly.siew.chin.lim@intel.com>,
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Fabio Estevam <festevam@gmail.com>, E Shattow <e@freeshell.de>,
 briansune <briansune@gmail.com>
Subject: [PATCH 6/8] arm: socfpga: rsu: Add SPL multiboot SSBL selection
Date: Tue, 30 Jun 2026 14:55:22 +0800
Message-Id: <20260630065524.27680-7-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20260630065524.27680-1-dinesh.maniyam@altera.com>
References: <20260630065524.27680-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0002.namprd05.prod.outlook.com
 (2603:10b6:a03:254::7) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|MN2PR03MB5085:EE_
X-MS-Office365-Filtering-Correlation-Id: 180c10b7-556d-41e3-05ac-08ded674c1ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|376014|1800799024|13003099007|18002099003|11063799006|3023799007|6133799003|22082099003|56012099006|55112099003;
X-Microsoft-Antispam-Message-Info: 5CqcPaz+72zgYJ1tvVj2NRXc9e7fJj+krH+Fk6GXScNVrUw9ytLLwf3LUck1uh/8yzx/KNq+zkMtpFI5DKYGzSOB5PFl4kXDrFww+5khRCFYvPHwuMdFjYB5bVp0bkZ9Xh4kVFVDcwA39Cx+OlqDqAgAwvc2p73jy1p/pV2yAMhKXh3aTs03kF0mz6ZdQelE5kTg8WpsE7KC3rPjzc/9EJf8etd4NK3gL85i56X1Yy2drQog4cy7hJPIRm0eXPgq3ls1LPPKaDXsv4FicBV8+bITD3bfTogccNskaxRq8Zsqgwcc1pLCmgUf6Ot2p3kDD/PgL3FT7xQFsL2e7h3y6jPTpqC2Ej0OdjSY73v/Mcu4GhsY8sP1LRTL79VcSqjMQw00nuB1G6JYxSi+7m1qH+BItWC40aBPVk1pVlFsKqhNNPRmbH4eSV7N3iB2PvAiIinsVn1PdAdNDlLtgrxEgF/d4LH0MZO/SOOrREyLkctSK6z/umL1V9EXIQb/faCLTuyme+z8lmYX1RGDNJYlcZbuCdS9erNXc3wM2XJ7eK54qglZDSqiugEgTgka5aJE07zCPN9ezXLbHWN/Co5GnOM1KXIiOwFVIQi5PtmoPsw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(13003099007)(18002099003)(11063799006)(3023799007)(6133799003)(22082099003)(56012099006)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zFaxM8iUE1BRGMEeP0AbLbungVVV71zy+zRpDk7lM2kqpLTvSnYJuzbDyOqr?=
 =?us-ascii?Q?7OOOCKbFIytPYZuWaXu4DcLom/bPjmyVrjSNSK6IuvkWlIasbcfP8g0v1ESZ?=
 =?us-ascii?Q?u+VH77RLx0/vPainiHGHdnzkLFocYaB+G7k0vZoe40pvrECKlm5wGgstk5Ld?=
 =?us-ascii?Q?EP+SAPyfBn09T3ztd0XmEoAq+OUw0DZK8q6BlKO2asUTnzJ8PVT6wDgWOl5q?=
 =?us-ascii?Q?VXa/8Pi9IlMcH23YhSltVrwaMFYckaOl6aLl2sCQkDE4lr+qpubmmVyIPLYy?=
 =?us-ascii?Q?ie9ibj4d0r0VU5YGCQVbWEtyltyznFiFmH4Q5v5iwt1kl/ZX8ekRQCqeze0i?=
 =?us-ascii?Q?EnFic7k/g8hIUtDHSuK4KC6jQHwNXGc6TNIGJhZazdGCNjorSzIbKSY9t143?=
 =?us-ascii?Q?uq5srmfq/osGNROiR7RZwOd0xFL5F2QuaRyiutWHzXznbZez4HC9DNMn3OZU?=
 =?us-ascii?Q?+jo17a72iVItliKeTnkYx6Ff64aRHVj6jlYgnW4l4Hj8GEnOtA44FBCRsYG2?=
 =?us-ascii?Q?D2vGrapi6XcwVxhejLWG6F/lIWVODtq4vPNGnz1wYxoHN4QHXcDQl45JMCjS?=
 =?us-ascii?Q?PXiwxgIMPT5JKpikBVPb3cZupfnw93oURdHPliU+lDtM4MdKCymJ8qUF/oIp?=
 =?us-ascii?Q?Sb9+GoueBI0Hfu19n43SzzKmt6954hsb3zsSgTuASte90t+cG779/eW+1Gi/?=
 =?us-ascii?Q?Y0dcgd3OsXIukm0Pv9OEYT1foFpBjNORWIMJIzOZ+fH90IaIca20FzpialUm?=
 =?us-ascii?Q?rRfCYYqZ0BmGarjTiry/FxV9xRXWmXO0f0zY6aBAQlxLFayAoaQR8tk+Q9oT?=
 =?us-ascii?Q?iV3pdHCLvSC6om3sTIhYz/AS8lmYilHPj8cQYMUTjNM27OAzVOf6yPXwR2U5?=
 =?us-ascii?Q?DnunINE5NmTqXa5F87wHEtZeWYx0yRivIHXqLwPZO1dSFZ7Mdix0pFDTHrB9?=
 =?us-ascii?Q?feSS2R0EvpPou07/n1+CqW84jTLeHs3Cef4dKZtMcdfi7kd9xMrcKl2391Y7?=
 =?us-ascii?Q?5FEFgV75J/r2RynonT81gWOWoD0OakzYQ/iqJ/TgJ0NPxMI/DGeWV23/Kmmr?=
 =?us-ascii?Q?UaJ+fIiaxh61cFfRh5r3ZQCtMhigy66wpfCypJaNKfwz8KCnQvn2h7M/x6VI?=
 =?us-ascii?Q?mxfaa/x/aJ4SsmgbSJug+iRkU6Uqw4dO9kY9vFJmPB7o4Mzu7gqC1sVEDG30?=
 =?us-ascii?Q?4DZ9wQs03Q6kMY+9OxyuhEgx/egLp+onvUX8Frb1MKQoQbAgq6X1qH6l8oGs?=
 =?us-ascii?Q?T2PPlKmassS6XRJlTNymjTtCXIlCMA/8LD8Gqc+QeHA7P0lc3j/GNf86J84q?=
 =?us-ascii?Q?zfxUdAQHT5tT7Rj258/uWJsB4VWIiyS8Ci3uSqdFBvBMdFvXOlbn4eVFzcIv?=
 =?us-ascii?Q?nsz2cknd4RQzkRMLn2mL+nywr5VK7CcEgpK0oFrCccZ3vJ7eZM/DpYtzKIe6?=
 =?us-ascii?Q?WFDrlu4y9+qupCFILbCx/Czo/IGTF6/lmgjlkg1x7n5vaTI2Rw1qx4JfvOIC?=
 =?us-ascii?Q?paa1TkShBMAOzSnXMzT7zs34e4PcWygG5AEqfKtMMlxgHKCryed6YLhlmQix?=
 =?us-ascii?Q?Lx49v86U7gOQfv3JyVM8GSpq7jVqjp637D/RQH6kiN9jXBZ70L0CTPhd5ecG?=
 =?us-ascii?Q?/L/XRYApPSe4q52Tn6cWRtYBl0PIpZteq7s31mC8hspTLth+4qN/unce0eqi?=
 =?us-ascii?Q?wylR9enioUNElhGGCK1UnG0BuEyRzOP6VtB65+YWpRtVAdjWihOM6eVbCTV7?=
 =?us-ascii?Q?ndMxGzaxHg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180c10b7-556d-41e3-05ac-08ded674c1ca
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:56:49.2353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C7fQty4O/9Wj3a5rxElGANIhEZ1VZ1nYMzWGiVebR4wOnXNb+garOY15qikPkaJ1uioZVnK8/cuMQLnN9rNCsmsCDvMlXXsANxMmoWOHSt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5085
X-Mailman-Approved-At: Tue, 30 Jun 2026 14:50:28 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add the SOCFPGA_RSU_MULTIBOOT feature so the SPL selects the U-Boot
proper (SSBL) image, environment and FIT that pair with the RSU
sub-partition the SPL itself booted from. rsu_spl.c reads the RSU
sub-partition table (SPT), locates the SSBL.<slot> partition matching
the running SPL slot and exposes:

  - spl_spi_get_uboot_offs()  : SSBL offset for SPI boot,
  - rsu_spl_mmc_filename()    : u-boot_<slot>.itb/.img for FAT/MMC boot,
  - rsu_spl_mmc_env_name()    : matching environment file name,
  - env_sf_get_env_offset()   : environment offset within the SSBL slot.

The generic SPL/env code grows small, default-off hooks for this:
spl_mmc.c and env/fat.c call weak filename helpers (default -ENOENT,
overridden by rsu_spl.c), and env/sf.c gains a weak env_sf_get_env_offset()
helper (default CONFIG_ENV_OFFSET) so the SPI environment offset can be
computed at runtime instead of redefining the CONFIG symbol.

SPL_SOCFPGA_RSU_SSBL_FALLBACK bounds the SSBL slot size used when the
SPT lookup fails so the environment-offset math cannot underflow.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 arch/arm/mach-socfpga/Kconfig                |  21 +
 arch/arm/mach-socfpga/Makefile               |   5 +
 arch/arm/mach-socfpga/include/mach/rsu_spl.h |  14 +
 arch/arm/mach-socfpga/rsu_spl.c              | 388 +++++++++++++++++++
 common/spl/spl_mmc.c                         |  24 +-
 env/fat.c                                    |  64 ++-
 env/sf.c                                     |  33 +-
 include/env_internal.h                       |  11 +
 8 files changed, 541 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/include/mach/rsu_spl.h
 create mode 100644 arch/arm/mach-socfpga/rsu_spl.c

diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index e9d675344f7..889dcc825b0 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -28,6 +28,27 @@ config SOCFPGA_RSU_MULTIFLASH
 	  spans the RSU sub-partition layout across all of them. Leave
 	  disabled for the common single-flash layout.
 
+config SOCFPGA_RSU_MULTIBOOT
+	bool "Enable RSU SPL multiboot SSBL selection"
+	depends on ARCH_SOCFPGA_SOC64 && SPL && SPI_FLASH
+	help
+	  Select the second-stage boot loader (SSBL, i.e. U-Boot proper)
+	  image based on the RSU sub-partition the SPL was loaded from.
+	  SPL reads the RSU sub-partition table (SPT) to locate the SSBL
+	  partition that pairs with the currently running SPL image and
+	  loads U-Boot proper, its environment and FIT from there. This
+	  keeps a multi-image RSU layout self-consistent across updates.
+
+config SPL_SOCFPGA_RSU_SSBL_FALLBACK
+	int "RSU SPL fallback SSBL slot size (MiB)"
+	depends on SOCFPGA_RSU_MULTIBOOT
+	default 8
+	range 1 64
+	help
+	  Conservative upper bound (in MiB) for the SSBL slot used when the
+	  SPT lookup fails, so the environment-offset math in env/sf.c cannot
+	  underflow. Override only if the board's SSBL exceeds the default.
+
 config SOCFPGA_SECURE_VAB_AUTH
 	bool "Enable boot image authentication with Secure Device Manager"
 	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
diff --git a/arch/arm/mach-socfpga/Makefile b/arch/arm/mach-socfpga/Makefile
index 109af31ceb8..14410cee149 100644
--- a/arch/arm/mach-socfpga/Makefile
+++ b/arch/arm/mach-socfpga/Makefile
@@ -147,6 +147,11 @@ obj-$(CONFIG_ARMV8_PSCI)	+= smc_rsu_s10.o
 endif
 endif
 
+# RSU SPL multiboot selects the SSBL (U-Boot proper) image to load; the
+# helpers are consumed from both SPL (spl_mmc/spl_spi) and U-Boot proper
+# (env/fat, env/sf), so build for both.
+obj-$(CONFIG_SOCFPGA_RSU_MULTIBOOT)	+= rsu_spl.o
+
 ifdef CONFIG_ARCH_SOCFPGA_GEN5
 # QTS-generated config file wrappers
 CFLAGS_wrap_iocsr_config.o	+= -I$(srctree)/board/$(BOARDDIR)
diff --git a/arch/arm/mach-socfpga/include/mach/rsu_spl.h b/arch/arm/mach-socfpga/include/mach/rsu_spl.h
new file mode 100644
index 00000000000..c9507b4d934
--- /dev/null
+++ b/arch/arm/mach-socfpga/include/mach/rsu_spl.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022-2023 Intel Corporation <www.intel.com>
+ */
+
+#ifndef _RSU_S10_SPL_H_
+#define _RSU_S10_SPL_H_
+
+#include <asm/arch/rsu_s10.h>
+
+u32 rsu_spl_ssbl_address(bool is_qspi_imge_check);
+u32 rsu_spl_ssbl_size(bool is_qspi_imge_check);
+
+#endif /* _RSU_S10_SPL_H_ */
diff --git a/arch/arm/mach-socfpga/rsu_spl.c b/arch/arm/mach-socfpga/rsu_spl.c
new file mode 100644
index 00000000000..a3145cce9c3
--- /dev/null
+++ b/arch/arm/mach-socfpga/rsu_spl.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2023 Intel Corporation <www.intel.com>
+ * Copyright (C) 2026 Altera Corporation <www.altera.com>
+ */
+
+#include <env_internal.h>
+#include <log.h>
+#include <spi.h>
+#include <spi_flash.h>
+#include <stdio.h>
+#include <dm/device.h>
+#include <asm/arch/mailbox_s10.h>
+#include <asm/arch/rsu.h>
+#include <asm/arch/rsu_flash_if.h>
+#include <asm/arch/rsu_s10.h>
+#include <asm/arch/rsu_spl.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/sizes.h>
+#include <linux/string.h>
+
+#define SSBL_PART_PREFIX	"SSBL."
+#define RSU_ADDR_MASK		0xFFFFFFFF
+#define RSU_ADDR_SHIFT		32
+#define UBOOT_ENV_EXT		".env"
+#define UBOOT_IMG_EXT		".img"
+#define UBOOT_ITB_EXT		".itb"
+#define UBOOT_ENV_PREFIX	"u-boot_"
+#define UBOOT_ENV_REDUND_PREFIX	"u-boot-redund_"
+#define UBOOT_PREFIX		"u-boot_"
+#define FACTORY_IMG_NAME	"FACTORY_IM"
+
+#define RSU_SPL_SPT_SLOT_MAX	127
+
+/* Bytes; pairs with CONFIG_SYS_SPI_U_BOOT_OFFS so env-offset math cannot underflow. */
+#define RSU_SPL_SSBL_FALLBACK_BYTES \
+	(CONFIG_SPL_SOCFPGA_RSU_SSBL_FALLBACK * SZ_1M)
+
+static unsigned int rsu_spl_spt_nentries(const struct socfpga_rsu_s10_spt *spt)
+{
+	if (spt->magic_number != RSU_S10_SPT_MAGIC_NUMBER)
+		return 0;
+	if (spt->entries > RSU_SPL_SPT_SLOT_MAX)
+		return RSU_SPL_SPT_SLOT_MAX;
+	return spt->entries;
+}
+
+static int get_spl_slot(struct socfpga_rsu_s10_spt *rsu_spt,
+			size_t rsu_spt_size, int *crt_spt_index)
+{
+	u32 rsu_spt0_offset = 0, rsu_spt1_offset = 0;
+	u32 spt_offset[4] = {0};
+	struct rsu_status_info rsu_status = {0};
+#ifdef CONFIG_DM_SPI_FLASH
+	struct udevice *flash;
+#else
+	struct spi_flash *flash;
+#endif
+	unsigned int nentries;
+	int i;
+	int pret;
+	int ret = -EINVAL;
+
+	/* get rsu status */
+	if (mbox_rsu_status((u32 *)&rsu_status, sizeof(rsu_status) / 4)) {
+		puts("RSU: Error - mbox_rsu_status failed!\n");
+		return -EOPNOTSUPP;
+	}
+
+	/* get spt offsets */
+	if (mbox_rsu_get_spt_offset(spt_offset, 4)) {
+		puts("RSU: Error - mbox_rsu_get_spt_offset failed!\n");
+		return -EINVAL;
+	}
+
+	rsu_spt0_offset = spt_offset[SPT0_INDEX];
+	rsu_spt1_offset = spt_offset[SPT1_INDEX];
+
+	pret = rsu_mtd_probe(CONFIG_SF_DEFAULT_BUS, CONFIG_SOCFPGA_RSU_SF_CS, &flash);
+	if (pret) {
+		printf("RSU: Error - rsu_mtd_probe failed (%d)!\n", pret);
+		return pret;
+	}
+
+	/* read spt0 */
+	pret = rsu_mtd_read(flash, rsu_spt0_offset, rsu_spt_size, rsu_spt);
+	if (pret) {
+		printf("RSU: Error - rsu_mtd_read spt0 failed (%d)!\n", pret);
+		ret = pret;
+		goto out;
+	}
+
+	/* if spt0 does not have the correct magic number */
+	if (rsu_spt->magic_number != RSU_S10_SPT_MAGIC_NUMBER) {
+		/* read spt1 */
+		pret = rsu_mtd_read(flash, rsu_spt1_offset, rsu_spt_size, rsu_spt);
+		if (pret) {
+			printf("RSU: Error - rsu_mtd_read spt1 failed (%d)!\n",
+			       pret);
+			ret = pret;
+			goto out;
+		}
+
+		/* bail out if spt1 does not have the correct magic number */
+		if (rsu_spt->magic_number != RSU_S10_SPT_MAGIC_NUMBER) {
+			printf("RSU: Error: spt table magic number not match 0x%08x!\n",
+			       rsu_spt->magic_number);
+			goto out;
+		}
+	}
+
+	nentries = rsu_spl_spt_nentries(rsu_spt);
+	if (!nentries)
+		goto out;
+
+	/* Flash may omit NUL in 16-byte names; cap strings for strstr/printf safety */
+	for (i = 0; i < (int)nentries; i++)
+		rsu_spt->spt_slot[i].name[MAX_PART_NAME_LENGTH - 1] = '\0';
+
+	/* display status */
+	debug("RSU current image:  0x%08x\n", (u32)rsu_status.current_image);
+	debug("RSU state:          0x%08x\n", rsu_status.state);
+	debug("RSU error location: 0x%08x\n", rsu_status.error_location);
+	debug("RSU error details:  0x%08x\n", rsu_status.error_details);
+
+	/* display partitions */
+	for (i = 0; i < (int)nentries; i++) {
+		debug("RSU: Partition '%s' start=0x%08x length=0x%08x\n",
+		      rsu_spt->spt_slot[i].name, rsu_spt->spt_slot[i].offset[0],
+		      rsu_spt->spt_slot[i].length);
+	}
+
+	/* locate the SPT entry for currently loaded image */
+	for (i = 0; i < (int)nentries; i++) {
+		if (((rsu_status.current_image & RSU_ADDR_MASK) ==
+			rsu_spt->spt_slot[i].offset[0]) &&
+		   ((rsu_status.current_image >> RSU_ADDR_SHIFT) ==
+			rsu_spt->spt_slot[i].offset[1])) {
+			*crt_spt_index = i;
+			ret = 0;
+			goto out;
+		}
+	}
+
+	puts("RSU: Error - could not locate SPL partition in the SPT table!\n");
+out:
+	/* Release the probed SPI flash; no-op under DM_SPI_FLASH. */
+	rsu_mtd_unclaim(flash);
+	return ret;
+}
+
+static int get_ssbl_slot(struct socfpga_rsu_s10_spt_slot *rsu_ssbl_slot)
+{
+	struct socfpga_rsu_s10_spt rsu_spt = {0};
+	int crt_spt_index = -EINVAL;
+	char *result;
+	unsigned int nentries;
+	int i, ret;
+
+	rsu_ssbl_slot->offset[0] = -EINVAL;
+
+	ret = get_spl_slot(&rsu_spt, sizeof(rsu_spt), &crt_spt_index);
+	if (ret) {
+		puts("RSU: Error - could not locate partition in the SPT table!\n");
+		return ret;
+	}
+
+	nentries = rsu_spl_spt_nentries(&rsu_spt);
+
+	/* locate the u-boot proper(SSBL) partition and return its address */
+	for (i = 0; i < (int)nentries; i++) {
+		/* get the substring ptr to the first occurrence of SSBL. prefix */
+		result = strstr(rsu_spt.spt_slot[i].name, SSBL_PART_PREFIX);
+
+		/* skip if not found the SSBL prefix */
+		if (!result)
+			continue;
+
+		/* check if the prefix is located at the first */
+		if (result == rsu_spt.spt_slot[i].name) {
+			/* move to the substring after SSBL. prefix */
+			result += strlen(SSBL_PART_PREFIX);
+
+			/* compare SPL's spt name after the prefix */
+			if (!strncmp(result, rsu_spt.spt_slot[crt_spt_index].name,
+				     MAX_PART_NAME_LENGTH - strlen(SSBL_PART_PREFIX)) ||
+			    !strncmp(result, rsu_spt.spt_slot[crt_spt_index].name,
+				     strlen(FACTORY_IMG_NAME))) {
+				printf("RSU: found SSBL partition %s at address 0x%08x.\n",
+				       result, (int)rsu_spt.spt_slot[i].offset[0]);
+				memcpy(rsu_ssbl_slot, &rsu_spt.spt_slot[i],
+				       sizeof(struct socfpga_rsu_s10_spt_slot));
+
+				return 0;
+			}
+		}
+	}
+
+	/* fail to find u-boot proper(SSBL) */
+	if (crt_spt_index >= 0 && crt_spt_index < (int)nentries)
+		printf("RSU: Error - could not find u-boot proper partition SSBL.%s!\n",
+		       rsu_spt.spt_slot[crt_spt_index].name);
+	else
+		puts("RSU: Error - could not find u-boot proper (SSBL) partition!\n");
+
+	return -EINVAL;
+}
+
+int rsu_spl_mmc_filename(char *filename, int max_size)
+{
+	struct socfpga_rsu_s10_spt rsu_spt = {0};
+	int crt_spt_index = -EINVAL;
+	int ret;
+
+	if (!filename) {
+		printf("RSU: filename is NULL!\n");
+		return -ENOENT;
+	}
+
+	/*
+	 * max_size is `int` for ABI reasons but used as size_t below;
+	 * reject non-positive up front so it cannot sign-extend.
+	 */
+	if (max_size <= 0)
+		return -EINVAL;
+
+	if ((strlen(UBOOT_PREFIX) + MAX_PART_NAME_LENGTH + strlen(UBOOT_ITB_EXT))
+	     > (size_t)max_size)
+		return -ENAMETOOLONG;
+
+	ret = get_spl_slot(&rsu_spt, sizeof(rsu_spt), &crt_spt_index);
+	if (ret) {
+		if (ret == -EOPNOTSUPP) {
+			puts("RSU: Error - mbox_rsu_status failed! Check for RSU image.\n");
+			return -EOPNOTSUPP;
+		}
+
+		panic("ERROR: could not find u-boot proper (SSBL) for MMC load");
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT))
+		ret = snprintf(filename, (size_t)max_size, "%s%s%s", UBOOT_PREFIX,
+			       rsu_spt.spt_slot[crt_spt_index].name, UBOOT_ITB_EXT);
+	else
+		ret = snprintf(filename, (size_t)max_size, "%s%s%s", UBOOT_PREFIX,
+			       rsu_spt.spt_slot[crt_spt_index].name, UBOOT_IMG_EXT);
+
+	if (ret < 0 || ret >= max_size)
+		return -ENAMETOOLONG;
+
+	printf("%s, filename: %s\n", __func__, filename);
+	return 0;
+}
+
+int rsu_spl_mmc_env_name(char *filename, int max_size, bool redund)
+{
+	struct socfpga_rsu_s10_spt rsu_spt = {0};
+	int crt_spt_index = -EINVAL;
+	int ret;
+
+	if (!filename) {
+		printf("RSU: filename is NULL!\n");
+		return -ENOENT;
+	}
+
+	/* Same signed/unsigned guard as rsu_spl_mmc_filename(). */
+	if (max_size <= 0)
+		return -EINVAL;
+
+	/*
+	 * Only one of UBOOT_ENV_REDUND_PREFIX / UBOOT_ENV_PREFIX is used
+	 * per call; size against the chosen one so a buffer that actually
+	 * fits is not falsely rejected.
+	 */
+	if ((strlen(redund ? UBOOT_ENV_REDUND_PREFIX : UBOOT_ENV_PREFIX) +
+	     MAX_PART_NAME_LENGTH + strlen(UBOOT_ENV_EXT)) > (size_t)max_size)
+		return -ENAMETOOLONG;
+
+	ret = get_spl_slot(&rsu_spt, sizeof(rsu_spt), &crt_spt_index);
+	if (ret) {
+		if (ret == -EOPNOTSUPP) {
+			puts("RSU: Error - mbox_rsu_status failed! Check for RSU image.\n");
+			return -EOPNOTSUPP;
+		}
+
+		/* should throw error if cannot find u-boot proper(SSBL) in MMC */
+		printf("ERROR: could not find u-boot.env!");
+		return ret;
+	}
+
+	if (redund)
+		ret = snprintf(filename, (size_t)max_size, "%s%s%s",
+			       UBOOT_ENV_REDUND_PREFIX,
+			       rsu_spt.spt_slot[crt_spt_index].name,
+			       UBOOT_ENV_EXT);
+	else
+		ret = snprintf(filename, (size_t)max_size, "%s%s%s",
+			       UBOOT_ENV_PREFIX,
+			       rsu_spt.spt_slot[crt_spt_index].name,
+			       UBOOT_ENV_EXT);
+
+	if (ret < 0 || ret >= max_size)
+		return -ENAMETOOLONG;
+
+	printf("%s, filename: %s\n", __func__, filename);
+	return 0;
+}
+
+u32 rsu_spl_ssbl_address(bool is_qspi_imge_check)
+{
+	int ret;
+	struct socfpga_rsu_s10_spt_slot rsu_ssbl_slot = {0};
+
+	ret = get_ssbl_slot(&rsu_ssbl_slot);
+	if (ret) {
+		if (ret == -EOPNOTSUPP) {
+			puts("RSU: Error - mbox_rsu_status failed! Check for RSU image.\n");
+			return CONFIG_SYS_SPI_U_BOOT_OFFS;
+		}
+
+		/* should throw error if cannot find u-boot proper(SSBL) address */
+		if (is_qspi_imge_check) {
+			panic("ERROR: could not find u-boot proper(SSBL) address!");
+		} else {
+			printf("ERROR: could not find u-boot env address!");
+			return CONFIG_SYS_SPI_U_BOOT_OFFS;
+		}
+	}
+
+	if (!rsu_ssbl_slot.length) {
+		if (is_qspi_imge_check)
+			panic("ERROR: could not find u-boot proper(SSBL) size!");
+		/* No log here; the size() variant reports it. */
+		return CONFIG_SYS_SPI_U_BOOT_OFFS;
+	}
+
+	printf("RSU: Success found SSBL at offset: %08x.\n",
+	       rsu_ssbl_slot.offset[0]);
+	return rsu_ssbl_slot.offset[0];
+}
+
+u32 rsu_spl_ssbl_size(bool is_qspi_imge_check)
+{
+	int ret;
+	struct socfpga_rsu_s10_spt_slot rsu_ssbl_slot = {0};
+
+	/* check for valid u-boot proper(SSBL) address for the size */
+	ret = get_ssbl_slot(&rsu_ssbl_slot);
+	if (ret) {
+		if (ret == -EOPNOTSUPP) {
+			printf("ERROR: Invalid address, could not retrieve SSBL size!");
+			return RSU_SPL_SSBL_FALLBACK_BYTES;
+		}
+
+		/* should throw error if cannot find u-boot proper(SSBL) address */
+		if (is_qspi_imge_check) {
+			panic("ERROR: could not find u-boot proper(SSBL) address!");
+		} else {
+			printf("ERROR: could not find u-boot env address!");
+			return RSU_SPL_SSBL_FALLBACK_BYTES;
+		}
+	}
+
+	if (!rsu_ssbl_slot.length) {
+		/* throw error if cannot find u-boot proper(SSBL) size */
+		printf("ERROR: could not retrieve u-boot proper(SSBL) size!");
+		if (is_qspi_imge_check)
+			panic("ERROR: could not find u-boot proper(SSBL) size!");
+		return RSU_SPL_SSBL_FALLBACK_BYTES;
+	}
+
+	printf("RSU: Success found SSBL with length: %08x.\n",
+	       rsu_ssbl_slot.length);
+	return rsu_ssbl_slot.length;
+}
+
+unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
+{
+	return rsu_spl_ssbl_address(true);
+}
+
+u32 env_sf_get_env_offset(void)
+{
+	/* Place the environment at the tail of the selected SSBL slot. */
+	return rsu_spl_ssbl_address(false) + rsu_spl_ssbl_size(false) -
+	       CONFIG_ENV_SIZE;
+}
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index cc16709dc9b..e4002591605 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -11,6 +11,7 @@
 #include <spl.h>
 #include <spl_load.h>
 #include <linux/compiler.h>
+#include <linux/sizes.h>
 #include <errno.h>
 #include <mmc.h>
 #include <image.h>
@@ -456,11 +457,32 @@ int spl_mmc_load(struct spl_image_info *spl_image,
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SOCFPGA_RSU_MULTIBOOT)
+__weak int rsu_spl_mmc_filename(char *filename, int max_size)
+{
+	return -ENOENT;
+}
+#endif
+
 int spl_mmc_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev)
 {
+#if IS_ENABLED(CONFIG_SOCFPGA_RSU_MULTIBOOT)
+	char filename[SZ_256] = {0};
+	int ret;
+
+	ret = rsu_spl_mmc_filename(filename, SZ_256);
+	if (ret) {
+		printf("RSU: multiboot filename not found\n");
+		return ret;
+	}
+
+	printf("%s: boot from filename: %s\n", __func__, filename);
+#endif
 	return spl_mmc_load(spl_image, bootdev,
-#ifdef CONFIG_SPL_FS_LOAD_PAYLOAD_NAME
+#if IS_ENABLED(CONFIG_SOCFPGA_RSU_MULTIBOOT)
+			    filename,
+#elif defined(CONFIG_SPL_FS_LOAD_PAYLOAD_NAME)
 			    CONFIG_SPL_FS_LOAD_PAYLOAD_NAME,
 #else
 			    NULL,
diff --git a/env/fat.c b/env/fat.c
index 7e164822383..9490be7d6f9 100644
--- a/env/fat.c
+++ b/env/fat.c
@@ -22,6 +22,7 @@
 #include <virtio.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <linux/sizes.h>
 #include <linux/stddef.h>
 
 #ifdef CONFIG_XPL_BUILD
@@ -35,6 +36,37 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+#if IS_ENABLED(CONFIG_SOCFPGA_RSU_MULTIBOOT)
+__weak int rsu_spl_mmc_env_name(char *filename, int max_size, bool redund)
+{
+	return -ENOENT;
+}
+#endif
+
+/*
+ * Resolve the FAT filename that holds the environment. With RSU multiboot
+ * the name is derived at runtime from the booted SSBL slot (written into
+ * @buf); otherwise it is the static CONFIG_ENV_FAT_FILE[_REDUND]. Returns
+ * NULL on failure.
+ */
+static const char *env_fat_filename(char *buf, int size, bool redund)
+{
+#if IS_ENABLED(CONFIG_SOCFPGA_RSU_MULTIBOOT)
+	if (rsu_spl_mmc_env_name(buf, size, redund)) {
+		printf("RSU: multiboot env filename not found\n");
+		return NULL;
+	}
+
+	return buf;
+#else
+#ifdef CONFIG_ENV_REDUNDANT
+	if (redund)
+		return CONFIG_ENV_FAT_FILE_REDUND;
+#endif
+	return CONFIG_ENV_FAT_FILE;
+#endif
+}
+
 __weak const char *env_fat_get_intf(void)
 {
 	return (const char *)CONFIG_ENV_FAT_INTERFACE;
@@ -62,13 +94,18 @@ static int env_fat_save(void)
 	env_t __aligned(ARCH_DMA_MINALIGN) env_new;
 	struct blk_desc *dev_desc = NULL;
 	struct disk_partition info;
-	const char *file = CONFIG_ENV_FAT_FILE;
+	char env_file[SZ_256] = {0};
+	const char *file;
 	int dev, part;
 	int err;
 	loff_t size;
 	const char *ifname = env_fat_get_intf();
 	const char *dev_and_part = env_fat_get_dev_part();
 
+	file = env_fat_filename(env_file, sizeof(env_file), false);
+	if (!file)
+		return 1;
+
 	err = env_export(&env_new);
 	if (err)
 		return err;
@@ -89,8 +126,11 @@ static int env_fat_save(void)
 	}
 
 #ifdef CONFIG_ENV_REDUNDANT
-	if (gd->env_valid == ENV_VALID)
-		file = CONFIG_ENV_FAT_FILE_REDUND;
+	if (gd->env_valid == ENV_VALID) {
+		file = env_fat_filename(env_file, sizeof(env_file), true);
+		if (!file)
+			return 1;
+	}
 #endif
 
 	err = file_fat_write(file, (void *)&env_new, 0, sizeof(env_t), &size);
@@ -120,6 +160,8 @@ static int env_fat_load(void)
 #endif
 	struct blk_desc *dev_desc = NULL;
 	struct disk_partition info;
+	char env_file[SZ_256] = {0};
+	const char *file;
 	int dev, part;
 	int err1;
 	const char *ifname = env_fat_get_intf();
@@ -162,9 +204,17 @@ static int env_fat_load(void)
 		goto err_env_relocate;
 	}
 
-	err1 = file_fat_read(CONFIG_ENV_FAT_FILE, buf1, CONFIG_ENV_SIZE);
+	file = env_fat_filename(env_file, sizeof(env_file), false);
+	if (!file)
+		goto err_env_relocate;
+
+	err1 = file_fat_read(file, buf1, CONFIG_ENV_SIZE);
 #ifdef CONFIG_ENV_REDUNDANT
-	err2 = file_fat_read(CONFIG_ENV_FAT_FILE_REDUND, buf2, CONFIG_ENV_SIZE);
+	file = env_fat_filename(env_file, sizeof(env_file), true);
+	if (!file)
+		goto err_env_relocate;
+
+	err2 = file_fat_read(file, buf2, CONFIG_ENV_SIZE);
 
 	err1 = (err1 >= 0) ? 0 : -1;
 	err2 = (err2 >= 0) ? 0 : -1;
@@ -175,8 +225,8 @@ static int env_fat_load(void)
 		 * This printf is embedded in the messages from env_save that
 		 * will calling it. The missing \n is intentional.
 		 */
-		printf("Unable to read \"%s\" from %s%d:%d... \n",
-			CONFIG_ENV_FAT_FILE, ifname, dev, part);
+		printf("Unable to read \"%s\" from %s%d:%d...\n",
+		       file, ifname, dev, part);
 		goto err_env_relocate;
 	}
 
diff --git a/env/sf.c b/env/sf.c
index 14c35324e64..6cdb0e4a632 100644
--- a/env/sf.c
+++ b/env/sf.c
@@ -38,6 +38,17 @@ static ulong env_new_offset	= CONFIG_ENV_OFFSET_REDUND;
 
 DECLARE_GLOBAL_DATA_PTR;
 
+/*
+ * Offset of the primary environment within the SPI flash. Defaults to the
+ * static CONFIG_ENV_OFFSET, but boards may override this weak helper to
+ * compute the offset at runtime (e.g. RSU multiboot derives it from the
+ * SSBL slot the SPL booted from).
+ */
+__weak u32 env_sf_get_env_offset(void)
+{
+	return CONFIG_ENV_OFFSET;
+}
+
 __weak int spi_get_env_dev(void)
 {
 #ifdef CONFIG_ENV_SPI_BUS
@@ -98,9 +109,9 @@ static int env_sf_save(void)
 
 	if (gd->env_valid == ENV_VALID) {
 		env_new_offset = CONFIG_ENV_OFFSET_REDUND;
-		env_offset = CONFIG_ENV_OFFSET;
+		env_offset = env_sf_get_env_offset();
 	} else {
-		env_new_offset = CONFIG_ENV_OFFSET;
+		env_new_offset = env_sf_get_env_offset();
 		env_offset = CONFIG_ENV_OFFSET_REDUND;
 	}
 
@@ -182,7 +193,7 @@ static int env_sf_load(void)
 	if (ret)
 		goto out;
 
-	read1_fail = spi_flash_read(env_flash, CONFIG_ENV_OFFSET,
+	read1_fail = spi_flash_read(env_flash, env_sf_get_env_offset(),
 				    CONFIG_ENV_SIZE, tmp_env1);
 	read2_fail = spi_flash_read(env_flash, CONFIG_ENV_OFFSET_REDUND,
 				    CONFIG_ENV_SIZE, tmp_env2);
@@ -217,7 +228,7 @@ static int env_sf_save(void)
 	/* Is the sector larger than the env (i.e. embedded) */
 	if (sect_size > CONFIG_ENV_SIZE) {
 		saved_size = sect_size - CONFIG_ENV_SIZE;
-		saved_offset = CONFIG_ENV_OFFSET + CONFIG_ENV_SIZE;
+		saved_offset = env_sf_get_env_offset() + CONFIG_ENV_SIZE;
 		saved_buffer = malloc(saved_size);
 		if (!saved_buffer) {
 			ret = -ENOMEM;
@@ -237,14 +248,14 @@ static int env_sf_save(void)
 	sector = DIV_ROUND_UP(CONFIG_ENV_SIZE, sect_size);
 
 	puts("Erasing SPI flash...");
-	ret = spi_flash_erase(env_flash, CONFIG_ENV_OFFSET,
-		sector * sect_size);
+	ret = spi_flash_erase(env_flash, env_sf_get_env_offset(),
+			      sector * sect_size);
 	if (ret)
 		goto done;
 
 	puts("Writing to SPI flash...");
-	ret = spi_flash_write(env_flash, CONFIG_ENV_OFFSET,
-		CONFIG_ENV_SIZE, &env_new);
+	ret = spi_flash_write(env_flash, env_sf_get_env_offset(),
+			      CONFIG_ENV_SIZE, &env_new);
 	if (ret)
 		goto done;
 
@@ -284,7 +295,7 @@ static int env_sf_load(void)
 		goto out;
 
 	ret = spi_flash_read(env_flash,
-		CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE, buf);
+		env_sf_get_env_offset(), CONFIG_ENV_SIZE, buf);
 	if (ret) {
 		env_set_default("spi_flash_read() failed", 0);
 		goto err_read;
@@ -314,7 +325,7 @@ static int env_sf_erase(void)
 		return ret;
 
 	memset(&env, 0, sizeof(env_t));
-	ret = spi_flash_write(env_flash, CONFIG_ENV_OFFSET, CONFIG_ENV_SIZE, &env);
+	ret = spi_flash_write(env_flash, env_sf_get_env_offset(), CONFIG_ENV_SIZE, &env);
 	if (ret)
 		goto done;
 
@@ -391,7 +402,7 @@ static int env_sf_init_early(void)
 	if (ret)
 		goto out;
 
-	read1_fail = spi_flash_read(env_flash, CONFIG_ENV_OFFSET,
+	read1_fail = spi_flash_read(env_flash, env_sf_get_env_offset(),
 				    CONFIG_ENV_SIZE, tmp_env1);
 
 	if (IS_ENABLED(CONFIG_ENV_REDUNDANT)) {
diff --git a/include/env_internal.h b/include/env_internal.h
index 0589c435e84..8ce200fd6f1 100644
--- a/include/env_internal.h
+++ b/include/env_internal.h
@@ -273,6 +273,17 @@ const char *env_fat_get_intf(void);
  * Return: string of device and partition
  */
 char *env_fat_get_dev_part(void);
+
+/**
+ * env_sf_get_env_offset() - Provide the offset of the env in SPI flash
+ *
+ * It is a weak function allowing boards to override the default offset of
+ * the U-Boot environment in SPI flash (CONFIG_ENV_OFFSET) with a value
+ * computed at runtime, e.g. derived from the RSU multiboot SSBL slot.
+ *
+ * Return: byte offset of the primary environment within the SPI flash
+ */
+u32 env_sf_get_env_offset(void);
 #endif /* DO_DEPS_ONLY */
 
 #endif /* _ENV_INTERNAL_H_ */
-- 
2.43.7

