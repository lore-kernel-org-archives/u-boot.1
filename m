Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B06C4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 12:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A613A8822C;
	Mon, 15 Apr 2024 14:14:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="edVzkCyV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0050388190; Mon, 15 Apr 2024 13:35:30 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::621])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4871987EDD
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 13:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPoRHN8k3TIcqPbIdLwd5SYmxwhu21QGAenPLOYVe9FfyECtF3JOh56PeiT0EMg2CaaS5Dso5ozRQQJToHXUWaoafRzAHw2lQGu+H2p568/VImLSEbfleMYQOL1nLvUuH8sCEGLY2tHHE3oPn0P8KMcZcv0S/+aJOCBswqit0eehUlGhmmPrusn0Sp9LI5YzhAp+InqaLkAwrPvloztrS/vd7uffAVDurnuW5iQ6L0Dsj32y0ZnJnUUaCYeKboa44MGoU5bD7zrafHOplY2jD+Ax92wRUteuoyBdIGpmhJrx1XFd/1WgJY/GxTKhzjSZqgDR4g4PLPN4/wf8VaK3Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ7QV6Xs89ngDI0WlAcxjkb3ByNWFKdq6GBNYgT1UO4=;
 b=UwSY5X7PztWxjlHM5Fz2nCv+kWLwE7RbNzq2FuoiG7e/KUHSBL8Ns1WMVHx2F/SewIJZHBJg2pSpuhAWjqBs/DwuYkOWSsPiWAH9C81EK5Q02XPmZmrdncIS39oN2UNn+QnNuPxiWjzvSXZmJ6VuSowaE9QFUpr80EfBEor5YNv+LbQYkvqKUuj7y9TDzjkByJi26YwIMFDxaAkD1/odvAgmdMy1Sq1Enj2IUaSVs/JaD2hczI2S3LV85H0oB+5DKUTzfoiVqtH7LGBuJrI+PvkrBI0c7YOxVFfetjVKBE0AUbk7T47jAa1JRYhpwahPsfKiLMvtPXjv18JB1YGlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ7QV6Xs89ngDI0WlAcxjkb3ByNWFKdq6GBNYgT1UO4=;
 b=edVzkCyVwuVIXizL9FdWOictt11GlSKoCsjSZwAmfOwwgDZkCsG6+lEMGKun7WU44Vt63iR/8rliKIjGlNX3c9uP2Bc2QZREHVlSEEPA6lepck+FzxFmzeIuA3u42wLs5Hg3J5aCJ46arxy53FlSy75Gxjdk23rGbgZe0fPr3UQ=
Received: from BN1PR12CA0014.namprd12.prod.outlook.com (2603:10b6:408:e1::19)
 by PH0PR12MB8032.namprd12.prod.outlook.com (2603:10b6:510:26f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 11:35:23 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:e1:cafe::86) by BN1PR12CA0014.outlook.office365.com
 (2603:10b6:408:e1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 11:35:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 11:35:22 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 06:35:21 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: AKASHI Takahiro <takahiro.akashi@linaro.org>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Andre Przywara <andre.przywara@arm.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng@tinylab.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Elon Zhang
 <zhangzj@rock-chips.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Jagan
 Teki" <jagan@amarulasolutions.com>, Jagan Teki <jagan@edgeble.ai>, John Clark
 <inindev@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, Joshua Riek
 <jjriek@verizon.net>, Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski
 <lukma@denx.de>, Manorit Chawdhry <m-chawdhry@ti.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Masahisa Kojima
 <kojima.masahisa@socionext.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Oleksandr Suvorov
 <oleksandr.suvorov@foundries.io>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Quentin Schulz
 <quentin.schulz@theobroma-systems.com>, Sean Anderson
 <sean.anderson@seco.com>, Sean Anderson <seanga2@gmail.com>, Sean Edmond
 <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, "Svyatoslav
 Ryhel" <clamor95@gmail.com>, Tim Lunn <tim@feathertop.org>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>, Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: [PATCH 0/4] Kconfig: some cleanups
Date: Mon, 15 Apr 2024 13:35:06 +0200
Message-ID: <cover.1713180904.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7142; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=ZEXZGiz1Q2/IbxsMMrzMuIIwZmTn7uvskcuiQ6jO9gw=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjRZgTcn5+6e2bjknE3putmXIr7vvCriu1vpdpV3AtOjF
 /ai/UkFHbEsDIJMDLJiiizSNlfO7K2cMUX44mE5mDmsTCBDGLg4BWAitdsY5tmr79nUlb2yIORO
 hOXck5lePMfcmRjmexRJOW/ZqZt+SD4r6KLcVcGfDxbPAQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH0PR12MB8032:EE_
X-MS-Office365-Filtering-Correlation-Id: 57b750f9-e4bd-45c5-b7d5-08dc5d402311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8zDc/yZgvOR37BZeDCWe/MYOQ6dKb4LGVZ4fe3edlWTn5/0Yw2ImRLeN8RuOQgdmC4YCAoMCNdWajPY9oluG5d3z24dC+8/127M3ZtsjWuWFTeCF9picplT4QUrp7hNt4twR/ZDMUeEJ8Mr1tnPAMQEjQmmg6mratZTN/6IfvX9bhW4YJoet72LyXHZ0S+jkZJ5RUWsFvW8WQD14fLlYpy/7v65JkVwrt0iwSgCGfzLfKfbf0u3c+FtpP1o6uWPDEKsS8gC8ofqkxz2n0gxKwQcYkFbLHXdP2iFkBV4ichbl+iFadeUenMDj0HEIiRWLx1jdPZb8ARoRgkSmRVyDJmD7PCcKHnI8Mpgy8Qq+jHpWDK9C+0fYjSszyP0JpN5hkrxziu9E8uD8K8n0Ur5M56zIwBQyUIUBPzy1kkXdjcWhDoRDy7mtf6/g6gKrD7h3vjLULQD/blLD0uc4jMlOHbleJIupWYrIfMKwa2J+0iDEyEIsdvvfOwZEup39dKWDlInpyFe2iQZrVE/rLCGofgxbybbBiG1WoVRZToNtzUTGXQdBmRS8CSVixc65nJ+kVQRitZZVrt2DMsJPaNtaz5eM8c2UkHZC3ePcdxGqyHWdjYX6ou5L9cTh+dGwObIp7LHcVXcv9psA/feHvzQdyn1JljAA+4jm+Z9upH96jAmit6d0WCGGyzoQtkiDXtuV+rsJXgCjUwrsH21xRi0DtNqvWrL6/FhKMmpy6BgSvct4890CQVBNxMYTEHDTbQuX
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 11:35:22.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b750f9-e4bd-45c5-b7d5-08dc5d402311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8032
X-Mailman-Approved-At: Mon, 15 Apr 2024 14:14:08 +0200
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

I looked as cleaning up some dependencies and I found that qconfig is
reporting some issues. This series is fixing some of them. But there are
still some other pending. That's why please go and fix them if they are
related to your board.

Thanks,
Michal

drivers/pinctrl/intel/Kconfig:12: warning: style: quotes recommended around=
 'n' in 'bool n'
warning: the choice symbol CPU_ARCEM6 (defined at arch/arc/Kconfig:46) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - TARGET_EMSDP (defined at arch/arc/Kconfig:173)
 - TARGET_IOT_DEVKIT (defined at arch/arc/Kconfig:180)
warning: the choice symbol ARC_MMU_ABSENT (defined at arch/arc/Kconfig:77) =
is selected by the following symbols, but select/imply has no effect on cho=
ice symbols
 - CPU_ARCEM6 (defined at arch/arc/Kconfig:46)
 - CPU_ARCHS36 (defined at arch/arc/Kconfig:53)
warning: the choice symbol ARC_MMU_V2 (defined at arch/arc/Kconfig:82) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - CPU_ARC750D (defined at arch/arc/Kconfig:32)
warning: the choice symbol ARC_MMU_V3 (defined at arch/arc/Kconfig:89) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - CPU_ARC770D (defined at arch/arc/Kconfig:39)
warning: the choice symbol ARC_MMU_V4 (defined at arch/arc/Kconfig:97) is s=
elected by the following symbols, but select/imply has no effect on choice =
symbols
 - CPU_ARCHS38 (defined at arch/arc/Kconfig:60)
warning: the choice symbol FSP_VERSION2 (defined at arch/x86/Kconfig:396) i=
s selected by the following symbols, but select/imply has no effect on choi=
ce symbols
 - INTEL_APOLLOLAKE (defined at arch/x86/cpu/apollolake/Kconfig:6)
warning: the choice symbol SPL_RISCV_MMODE (defined at arch/riscv/Kconfig:1=
84) is implied by the following symbols, but select/imply has no effect on =
choice symbols
 - BOARD_SPECIFIC_OPTIONS (defined at board/bsh/imx8mn_smm_s2/Kconfig:21, b=
oard/bsh/imx8mn_smm_s2/Kconfig:41, board/engicam/px30_core/Kconfig:12, boar=
d/theobroma-systems/ringneck_px30/Kconfig:12, board/radxa/rockpi4-rk3399/Kc=
onfig:12, board/theobroma-systems/puma_rk3399/Kconfig:12, board/theobroma-s=
ystems/jaguar_rk3588/Kconfig:12, board/edgeble/neural-compute-module-2/Kcon=
fig:12, board/itead/sonoff-ihost/Kconfig:12, board/emulation/qemu-arm/Kconf=
ig:6, board/emulation/qemu-arm/Kconfig:22, board/freescale/ls1012aqds/Kconf=
ig:27, board/freescale/ls1012ardb/Kconfig:27, board/freescale/ls1012ardb/Kc=
onfig:76, board/freescale/ls1012afrdm/Kconfig:27, board/advantech/som-db580=
0-som-6867/Kconfig:18, board/congatec/conga-qeval20-qa3-e3845/Kconfig:17, b=
oard/coreboot/coreboot/Kconfig:15, board/dfi/dfi-bt700/Kconfig:17, board/ef=
i/efi-x86_app/Kconfig:12, board/efi/efi-x86_payload/Kconfig:15, board/emula=
tion/qemu-x86/Kconfig:16, board/google/chromebook_coral/Kconfig:18, board/g=
oogle/chromebook_link/Kconfig:19, board/google/chromebox_panther/Kconfig:19=
, board/google/chromebook_samus/Kconfig:19, board/intel/bayleybay/Kconfig:1=
5, board/intel/cherryhill/Kconfig:15, board/intel/cougarcanyon2/Kconfig:15,=
 board/intel/crownbay/Kconfig:15, board/intel/edison/Kconfig:24, board/inte=
l/galileo/Kconfig:15, board/intel/minnowmax/Kconfig:15, board/intel/slimboo=
tloader/Kconfig:19, board/AndesTech/ae350/Kconfig:34, board/emulation/qemu-=
riscv/Kconfig:32, board/microchip/mpfs_icicle/Kconfig:19, board/openpiton/r=
iscv64/Kconfig:26, board/sifive/unleashed/Kconfig:26, board/sifive/unmatche=
d/Kconfig:26, board/sipeed/maix/Kconfig:30, board/sophgo/milkv_duo/Kconfig:=
24, board/starfive/visionfive2/Kconfig:26, board/thead/th1520_lpi4a/Kconfig=
:30, board/xilinx/mbv/Kconfig:22, board/keymile/km83xx/Kconfig:34, board/ke=
ymile/km83xx/Kconfig:54, board/keymile/km83xx/Kconfig:74, board/keymile/km8=
3xx/Kconfig:93, board/keymile/km83xx/Kconfig:112, board/keymile/km83xx/Kcon=
fig:131, board/keymile/km83xx/Kconfig:150, board/keymile/kmcent2/Kconfig:12=
, board/keymile/pg-wcom-ls102xa/Kconfig:15, board/keymile/pg-wcom-ls102xa/K=
config:35)
warning: the choice symbol SYS_BIG_ENDIAN (defined at arch/Kconfig:528) is =
selected by the following symbols, but select/imply has no effect on choice=
 symbols
 - ARC (defined at arch/Kconfig:53)
warning: the choice symbol SYS_LITTLE_ENDIAN (defined at arch/Kconfig:532) =
is selected by the following symbols, but select/imply has no effect on cho=
ice symbols
 - ARC (defined at arch/Kconfig:53)
warning: the choice symbol OF_SEPARATE (defined at dts/Kconfig:108) is sele=
cted by the following symbols, but select/imply has no effect on choice sym=
bols
 - ARCH_MVEBU (defined at arch/arm/Kconfig:620)
 - ARCH_SNAPDRAGON (defined at arch/arm/Kconfig:1074)
 - ARCH_SUNXI (defined at arch/arm/Kconfig:1143)
 - ARCH_S5P4418 (defined at arch/arm/mach-nexell/Kconfig:3)
warning: the choice symbol MULTI_DTB_FIT_USER_DEFINED_AREA (defined at dts/=
Kconfig:242) is implied by the following symbols, but select/imply has no e=
ffect on choice symbols
 - RZG2L (defined at arch/arm/mach-renesas/Kconfig:70)
 - TARGET_BEACON_RZG2M (defined at arch/arm/mach-renesas/Kconfig.rcar3:82)
 - TARGET_HIHOPE_RZG2 (defined at arch/arm/mach-renesas/Kconfig.rcar3:130)
 - TARGET_SALVATOR_X (defined at arch/arm/mach-renesas/Kconfig.rcar3:149)
 - TARGET_ULCB (defined at arch/arm/mach-renesas/Kconfig.rcar3:160)
warning: the choice symbol SYS_NAND_SOFT_ECC (defined at drivers/mtd/nand/r=
aw/Kconfig:184) is selected by the following symbols, but select/imply has =
no effect on choice symbols
 - NAND_SANDBOX (defined at drivers/mtd/nand/raw/Kconfig:450)
warning: the choice symbol USB_ULPI_VIEWPORT (defined at drivers/usb/ulpi/K=
config:11) is selected by the following symbols, but select/imply has no ef=
fect on choice symbols
 - USB_EHCI_MSM (defined at drivers/usb/host/Kconfig:263)
warning: the choice symbol LIB_RAND (defined at lib/Kconfig:275) is selecte=
d by the following symbols, but select/imply has no effect on choice symbols
 - CMD_LINK_LOCAL (defined at cmd/Kconfig:1994)
warning: the choice symbol EFI_APP (defined at lib/efi/Kconfig:15) is selec=
ted by the following symbols, but select/imply has no effect on choice symb=
ols
 - TARGET_EFI_APP32 (defined at board/efi/Kconfig:7)
 - TARGET_EFI_APP64 (defined at board/efi/Kconfig:16)



Michal Simek (4):
  Kconfig: Remove trailing whitespace in its prompt
  Kconfig: Add missing quotes around source file
  Kconfig: Add missing quotes around default string value
  Kconfig: Make all Kconfig encoding ascii

 arch/arm/mach-rockchip/px30/Kconfig   |  4 ++--
 arch/arm/mach-rockchip/rk3588/Kconfig | 24 ++++++++++++------------
 arch/arm/mach-rockchip/rv1108/Kconfig |  4 ++--
 arch/arm/mach-rockchip/rv1126/Kconfig |  8 ++++----
 cmd/Kconfig                           |  2 +-
 drivers/clk/Kconfig                   | 10 +++++-----
 drivers/crypto/Kconfig                |  8 ++++----
 drivers/ddr/imx/imx8ulp/Kconfig       |  2 +-
 drivers/mtd/spi/Kconfig               |  2 +-
 lib/Kconfig                           | 18 +++++++++---------
 lib/efi_loader/Kconfig                |  2 +-
 11 files changed, 42 insertions(+), 42 deletions(-)

--=20
2.44.0

