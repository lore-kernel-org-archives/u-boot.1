Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A98C25B7C
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 16:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3791388627;
	Wed, 29 May 2024 18:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="smN8cDKl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEC018860D; Wed, 29 May 2024 16:48:14 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AECF883F6
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iwHaahn5cSFq8YVrxGkLZC9dr5xe+IxXVJJLscffVRY3YsvzHT76QP2UySFMJcBM4B5jILAs+6JwjymYB+PiZ1X6rhYWMEvat0Tz+XsJyCEAAipMDRpjbflWKlLjzgYamnn454aeGrqCMLlaflIFJ5ha1K3kMK4m5D2a+K9+AmRVlThvNkcp4l47xlpAqQQgjxhhBlDKLdwoFD8vckYHWvPYN5c+/ys4LA2gvgrNGp2WqRWhktHB7z1EVFLLZ/OjMEKGq8ujEBodGZvWA8YyCZSQSpeT3uVo2jNxVoAkdLgvVg/7q9M5qqBaHHslsEeGok1iM8OgxGu5RALN8/v+yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sNdRXCTj45L3hYcYEAmGB4xuvIrWtRIuBQ/owhbd6QY=;
 b=Mkay/zVVUA5HNLJIkElKiCF5c28R8hWvz1Mti/vEKARLt0Jk6OV/mtKNbvXWcRttYuUlpy66JolJ88TevGirNGUfwWmbL4cQ1AoNqydr6v7tm0C7aICUoy8eOdzZig/o6Q2oWoh90AVYaxz/F8D7Ygrc7if1jZIxtvGHroRxs6yFFRSu4S0Dijq+/GMGiImaZKdu4zD4qg7/7BC3JejlocpE8FlMXSkNU++8i37FHenkXpW0sauSP6x+eNGaeotvL57txKEcCAUab5n4L/zR148A2rmBMq9XV3p/U+JyZ9Fo1KYZiF+k/zJSNcTM7OYvZZYk4x/2kr3og09V4LkwEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sNdRXCTj45L3hYcYEAmGB4xuvIrWtRIuBQ/owhbd6QY=;
 b=smN8cDKlLgmjXDUyLK0mAn0/WsDRdfjqbL7s/yRMBamvPIr/MxjfUxTl7HGsP3VfxQlUbb/3Z7qLGS4US+RTje/a52dmSNStkP28ieQDqiB159wYUITIfyWI8xcvh1y9dkRgXpuSXIVlZoMnJBMZCEVzQl23jxazl3/0jf0QPtQ=
Received: from MN2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:208:23e::34)
 by BL3PR12MB6449.namprd12.prod.outlook.com (2603:10b6:208:3b8::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Wed, 29 May
 2024 14:48:08 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::15) by MN2PR14CA0029.outlook.office365.com
 (2603:10b6:208:23e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Wed, 29 May 2024 14:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 14:48:07 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 09:48:04 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 "Andrew
 Davis" <afd@ti.com>, Angelo Dureghello <angelo@kernel-space.org>, "Arturs
 Artamonovs" <arturs.artamonovs@analog.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Biju Das <biju.das.jz@bp.renesas.com>, "Caleb
 Connolly" <caleb.connolly@linaro.org>, Chanho Park
 <chanho61.park@samsung.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?= <csokas.bence@prolan.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Emmanuel Di Fede
 <emmanuel.difede@cysec.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Fabio Estevam <festevam@denx.de>, Hai Pham <hai.pham.ud@renesas.com>, "Ibai
 Erkiaga" <ibai.erkiaga-elorza@amd.com>, Igor Prusov
 <IVPrusov@sberdevices.ru>, Jaehoon Chung <jh80.chung@samsung.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Joe Hershberger <joe.hershberger@ni.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 "Kongyang Liu" <seashell11234455@gmail.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "Minkyu Kang" <mk7.kang@samsung.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Padmarao Begari <padmarao.begari@microchip.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Paul Barker
 <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, Peter Robinson
 <pbrobinson@gmail.com>, "Piotr Wojtaszczyk" <piotr.wojtaszczyk@timesys.com>,
 "Polak, Leszek" <LPolak@arri.de>, Rayagonda Kokatanur
 <rayagonda.kokatanur@broadcom.com>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>, Sumit Garg
 <sumit.garg@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Tim Harvey <tharvey@gateworks.com>, Tom Rini
 <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, Udit Kumar
 <u-kumar1@ti.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 William Zhang <william.zhang@broadcom.com>
Subject: [PATCH 0/4] arm64: versal2: Add support for new AMD Versal Gen 2 SoC
Date: Wed, 29 May 2024 16:47:57 +0200
Message-ID: <cover.1716994063.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3081; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZZyd0RH7qFr0A0hLvPwgpLlLuwee4duc+CodSB8I1rs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRwB8mPR9mVeHgOSnTu3ZUetcr61vQDN7kMj+01F+6Ir
 udbdNq7I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEzk0C2G+S7/rXW+W1m817Z4
 PpVrSwjvPm5mcYb5Ac/lgw6e00wo91gSeEblYjb3/BwNAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|BL3PR12MB6449:EE_
X-MS-Office365-Filtering-Correlation-Id: 27312129-6270-42a1-7892-08dc7fee5a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017|7416005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ic9qXI+FLYfvPWYluHPN82RkHN1IEJsP6Nol9GIQ3Js2/XzipShoV5c2bXsY?=
 =?us-ascii?Q?WoCt91x9Jysy6ryNFTnhOBo2W+3iCNiUNHyT5tQBFwahUM4QyVHZzjyvaAGR?=
 =?us-ascii?Q?ovoGKYDi98D/VLDmgDwFpyUghj/d6oDltvmtcH47awqRlO99uY54NujuPzwV?=
 =?us-ascii?Q?ecXHm03oBGRao8CKqIUqeZiFNFIwQwLDRSIgSahXfuw3RDLvXI/T+khCt951?=
 =?us-ascii?Q?RG6wgi1ixrSr252UWLn/5Fc/2bCoD/S3mB12mczRHZMSAEO5xQB8YG7N3gDB?=
 =?us-ascii?Q?xmqU6K7cJl6o5fzbMR+WRhPcUX/PxAexmMws3w+OfBkQ1Gt6xpxiWdifi1f0?=
 =?us-ascii?Q?+cK3asBPqaGoLARhzKX1otmSE2Nli1lv2gfPeelUh+brmK07M74t2HkiX/Yr?=
 =?us-ascii?Q?0EU3tc6tctdP1ji/1n6wI+h68GtNMy9DU27dUuEqcHt2hZr/C7BAJjebgnMu?=
 =?us-ascii?Q?UqL+EAh5ER8utBZzJNn6HGr9uOXil0aJ6oOekocJ5G66GJxBqzuluM6Orv7q?=
 =?us-ascii?Q?2Aa7OfZJdwOabUVTtNNbRi3WvNlq23J0XjrEHrLVwnvQR57XRPyYwd00oZoy?=
 =?us-ascii?Q?R/OoD/X/f1KibwjWuYTxahdPc5INZsLG8TlAn5foiMx/FqInC82UZPJSp17d?=
 =?us-ascii?Q?It0Hrg1e5nENbuaOcQRyugKovm9Zzc9TuLgZZ9kMQQDrZ4PZ8jVM54h+BOqc?=
 =?us-ascii?Q?uQTpLEeBmSdS3IFi7EAxzQYN5h0D/Pc8c949AHXdSSK+ZiIDVaLX6Sfg8Ug0?=
 =?us-ascii?Q?XebjYGdvs8B5ftI6ckIdKvoMHbZgC/mmwOZfXyxH/sm2Hl12nKpYioNlRhG9?=
 =?us-ascii?Q?Quj33bBBmZcRjdqqqvvx47hcC0WYjSOI6Gbj5CqgTYLr1sjaOth9ROyo91SD?=
 =?us-ascii?Q?4QAdpNzWhuOu/n82Iz54Hk9LAMtAsi5mWV/z7ue2GVO9XiREd/BjEn8Pr2cH?=
 =?us-ascii?Q?jKIe/SN0tvQ1m8oqaeOz/ZRJOWSp6ZbuqG5LaohTKoMMFxpcZvYA11pjUVX7?=
 =?us-ascii?Q?GB551QRzM+ANEtR3PI0iRsZV7KKYZShvDV7KYThF3//jgLR/5G7BMDmRO0sJ?=
 =?us-ascii?Q?kO0kQK5kzf+YCNkImjdZr52ZBgdzn7u9GG01U8126joJiLWV5qT6Asq+EaB5?=
 =?us-ascii?Q?IKWn+72QEixfx91n4t4zstFJvez3JaOxUnUc29Tvkreu8tsnK1e0QoPCX5yy?=
 =?us-ascii?Q?fN6s8V7wykMfXr7F2WS3XeHUu5prmUHIxehNfP2EznYbGMORI/svCmBUJHEa?=
 =?us-ascii?Q?Ch/g1URPUwZRQWYTUM3HCqA5T21Llwymc9L53zmEe1yL9ggtEW2COx4ixFKA?=
 =?us-ascii?Q?Z+B3dU2zJXk7ZsywrM3rbVu3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017)(7416005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:48:07.7887 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27312129-6270-42a1-7892-08dc7fee5a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
X-Mailman-Approved-At: Wed, 29 May 2024 18:32:00 +0200
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

I am sending patches for adding initial support for new AMD Versal Gen 2
SoC. If you want to find out more information please take a look at this
page:
https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal.html

Thanks,
Michal


Michal Simek (4):
  arm64: versal2: Add support for AMD Versal Gen 2
  soc: versal2: Add SoC driver for AMD Versal Gen 2
  mmc: versal2: Update zynq_sdhci driver to support AMD Versal Gen 2
  spi: versal2: Enable spi drivers for Versal Gen 2

 arch/arm/Kconfig                              |  14 +
 arch/arm/Makefile                             |   1 +
 arch/arm/dts/Makefile                         |   2 +
 arch/arm/dts/amd-versal2-virt.dts             |  11 +
 arch/arm/mach-versal2/Kconfig                 |  55 +++
 arch/arm/mach-versal2/Makefile                |  10 +
 arch/arm/mach-versal2/clk.c                   |  34 ++
 arch/arm/mach-versal2/cpu.c                   |  93 +++++
 arch/arm/mach-versal2/include/mach/hardware.h |  97 +++++
 .../arm/mach-versal2/include/mach/sys_proto.h |   9 +
 board/amd/common                              |   1 +
 board/amd/versal2/Kconfig                     |  16 +
 board/amd/versal2/MAINTAINERS                 |   7 +
 board/amd/versal2/Makefile                    |  11 +
 board/amd/versal2/board.c                     | 343 ++++++++++++++++++
 board/amd/versal2/cmds.c                      |  81 +++++
 board/xilinx/Kconfig                          |   6 +-
 configs/amd_versal2_virt_defconfig            | 150 ++++++++
 drivers/gpio/Kconfig                          |   2 +-
 drivers/mailbox/Kconfig                       |   2 +-
 drivers/mmc/zynq_sdhci.c                      |  22 +-
 drivers/soc/Kconfig                           |   8 +
 drivers/soc/Makefile                          |   1 +
 drivers/soc/soc_amd_versal2.c                 |  77 ++++
 drivers/spi/Kconfig                           |   2 +-
 drivers/spi/cadence_qspi.c                    |   3 +-
 drivers/spi/zynqmp_gqspi.c                    |   6 +-
 env/Kconfig                                   |   6 +-
 include/configs/amd_versal2.h                 | 143 ++++++++
 29 files changed, 1193 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/dts/amd-versal2-virt.dts
 create mode 100644 arch/arm/mach-versal2/Kconfig
 create mode 100644 arch/arm/mach-versal2/Makefile
 create mode 100644 arch/arm/mach-versal2/clk.c
 create mode 100644 arch/arm/mach-versal2/cpu.c
 create mode 100644 arch/arm/mach-versal2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-versal2/include/mach/sys_proto.h
 create mode 120000 board/amd/common
 create mode 100644 board/amd/versal2/Kconfig
 create mode 100644 board/amd/versal2/MAINTAINERS
 create mode 100644 board/amd/versal2/Makefile
 create mode 100644 board/amd/versal2/board.c
 create mode 100644 board/amd/versal2/cmds.c
 create mode 100644 configs/amd_versal2_virt_defconfig
 create mode 100644 drivers/soc/soc_amd_versal2.c
 create mode 100644 include/configs/amd_versal2.h

-- 
2.40.1

