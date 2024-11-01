Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F06E6B256
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 12:56:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34725892E1;
	Fri,  1 Nov 2024 13:56:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DiuzQJTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FAFE8924F; Fri,  1 Nov 2024 10:18:16 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C968988DB2
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 10:18:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pd6CogaXvMfcdFOLGAOd5copkmonXQ8JDFLn5Ky29YPwAT5m5uNtMAGlXJacDh9IInIyiV9vWH+SUDGz8QSq01G9bkHFuk32dN017VoZllS4s/BVQLy6iJLTnbMwlyQ/iiTden46qrWcqG0Tz2gLqzFfflSHOuHR8R0dQ94uZGK8U2tLe++DasLEddiu/i0OY2yDndLatIS2pEGnMi0ZbIy1Dz/h1aCCcopSwhMWANk/Sd6gmhObToIWNf9kF0ljX3OGRgkVkulBXOhN/NFZrymWoI73WqncW5rVnFQsAO+CkQHoHJqhPHTNGkyKQLTcJi16uvf5jIjByLVo0i18Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLxbTta/pp3m0nvrT4SI705TSMhrNUJUtBIBAAEMEl0=;
 b=Y5ahRF16e5nBcAKSRviNp6N473ngu/ogzqXMaymjq9bVslHoBpoOo3GVZTZT5lqLvy30of09MjLpT5+8SZWImnl1SEwPAWrIb6VMspYsImGjH/tPmO248llcuj0ZqrwZGomtgGcmruEtRpInekBSD++IK39YzDMXcT0wvNG/REC4hWqk37D/H+i7qnzCGPViP111XTgMikSZ7tQPIz7HRu7xcxUEp5uHFHM35b3sdV9wtWAymhMFucNJnIYjqLEFHJ/bLAXtY3JZQl8UqA3byKZQonQMpo4GJfEnjxGCtZN5wdQLDD7MGq/G8T19khjXJYOJ0Em6q0iI47Ac7/bALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLxbTta/pp3m0nvrT4SI705TSMhrNUJUtBIBAAEMEl0=;
 b=DiuzQJTg0jRjtYYxqc31nUuqUfCbOGuxGSOHkaq7oxPGuBdpz1PXvtdVFHFW/9tCvBkincAOIVEWSOz5IKEFD1xOhKTzjBy/D2+5AQd6KDX5W5Dn5HaUG64CMbvHpsVd3ulYK6gkWaOm2vWBUTWDCYY6JG0R+GBGjbuRBO3bg0k=
Received: from BN9PR03CA0850.namprd03.prod.outlook.com (2603:10b6:408:13d::15)
 by LV8PR12MB9419.namprd12.prod.outlook.com (2603:10b6:408:206::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 09:18:10 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:13d:cafe::7e) by BN9PR03CA0850.outlook.office365.com
 (2603:10b6:408:13d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.22 via Frontend
 Transport; Fri, 1 Nov 2024 09:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 09:18:09 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 04:18:00 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 <neal.frager@amd.com>
CC: AKASHI Takahiro <akashi.tkhro@gmail.com>, Adam Ford <aford173@gmail.com>, 
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Charlie Johnston <charlie.johnston@loftorbital.com>, Christian Marangi
 <ansuelsmth@gmail.com>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=20Bence?=
 <csokas.bence@prolan.hu>, Fabio Estevam <festevam@denx.de>, "Heinrich
 Schuchardt" <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Quentin Schulz
 <quentin.schulz@cherry.de>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, Sean Anderson
 <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg
 <sumit.garg@linaro.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Tony Dinh <mibodhi@gmail.com>, "Venkatesh Yadav
 Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2 0/7] arm64: zynqmp: Convert platforms to use binman
Date: Fri, 1 Nov 2024 10:17:53 +0100
Message-ID: <cover.1730452668.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=RntHHM7l0vWNwZABMdhnTfVJIC92BhlBKpEupmaUfWs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhnSVOYcky6Y0mu6Rm2M3IXt2xcf68zYGJa2J8zN7rnBxm
 Kjxr3naEcvCIMjEICumyCJtc+XM3soZU4QvHpaDmcPKBDKEgYtTACYy14JhfuD+Z/u61PhyX9il
 +a64VnNB4ljrbIYFU/Yn1f3u2zTrJc+sXSzfNn+aYBRmDwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|LV8PR12MB9419:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ea87e6-c24c-425a-6251-08dcfa561a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VFRTfJPSLbE4S+pNDU0pT/YFJsgf3Ei18aynUFcQxwMleZR82Y+h5h25NWgN?=
 =?us-ascii?Q?mgFFyln1k7eH4fGUapTJd4foi3WEEE9TGw4yVK6JEj6NYWw8B0j6CZP8XTx0?=
 =?us-ascii?Q?QcUTLb2Qp0wOsFB7VsEQfCIo2IgeIQMoOesLteHXeAwVwrWOAxzgy3jD2ABo?=
 =?us-ascii?Q?MxVxFbVR1izpLgFxCE2zXXYphXiGJYSy+jrrjiHICNc3S97+WI3xEhaDr7xv?=
 =?us-ascii?Q?5T1B4ng93ALpi81UgLBaslmmjvLlu46nBiR6xqfIPRG+XbxLFT4uMxSFMj7P?=
 =?us-ascii?Q?wFKzDCICUM4ofcid7zx/Os99imQcIZwcEqvs98ZDnzUQUev4piGmB6pD33Sd?=
 =?us-ascii?Q?R9n1NBtXp93hI6itByrWbJ373/sjjDZIH8kSgczFUn+kMfWF3A4uu6Eg3Ek7?=
 =?us-ascii?Q?WGoihQvYSWsnmILXRkO1KG/hXuz753Y0D2u0lol1nAqwxkRM8VnAXwv/ZJGm?=
 =?us-ascii?Q?nihA7zB2SF/2kiD/x9lvb9236wf4amTr9bGdmR9TdlOzjR2y1YbLQ5OcXsgs?=
 =?us-ascii?Q?wkXWkQ5txh65uRQ9saa8M0efHbYSXQJH43CUpiqOsmHXVNRJXdeGs1tw7IFN?=
 =?us-ascii?Q?FVDHazIkViMh1cyiPGjTmRiPTAN9sj88oBYaUNA+sMMz+PqVJ5hHg1gL5Qg3?=
 =?us-ascii?Q?WALBBQnQ3+wGzep400DlEAjn0KM4Dixh6Le6MH7fgQTRSOUNJD+787GXE3C0?=
 =?us-ascii?Q?8/wm3uu/EavAUULBE8AdTx5HgWBDrqRAiRVsIg/SQwssJ5VG6QrYE4W7cZRW?=
 =?us-ascii?Q?075TmUCQeFB9W1lJk1vTnrUtwSbr+7TYlYPnC4sYduNql90VqDm2+6GG0Glw?=
 =?us-ascii?Q?hSG1AjA8BVj1d1LjUS7xAZ5m3JZN1Cyz031dEPR87DV7aNHys1goc+OQbKEy?=
 =?us-ascii?Q?uRq7N2qgJcPoYvQ8SSgchnA6+xQsmLYNTf3oFUPROydiqpFL9PZQhq/bSxtm?=
 =?us-ascii?Q?0lOgJVi/qmOAfvHEyRaoA0C6CMs9XbxXCwLnH7l6S9HROcZRHinYxQZPDmwk?=
 =?us-ascii?Q?tJ4z86XWdNLwx/lkUEURIQj3Ho29xi4lfar1kuGIrsia9PeSuZBhPt35yUh6?=
 =?us-ascii?Q?97RIrceW9ihJgOpxLvc+Z3V885XL/ek3fy2+2OOKswEKuWa3zlh1I+cSmcBt?=
 =?us-ascii?Q?8gbQrfS0WQNbtkGHxNfbuxaQ0TPysKku0n5xP9brfUZ7+eXDCZuW6kwXCV0H?=
 =?us-ascii?Q?zFMA6XSytRLZrcC4r/D4mumVyx6rUwKV2RTO092eEYfTe3Ag82ASEB0i16+F?=
 =?us-ascii?Q?Qzd9EnFJJgSt0neev3ffMRs78yXPjfMaDgUSMjkl7TOfqBPbj08HPC4efwmM?=
 =?us-ascii?Q?tDQMdFLhdSRGxOdtctOh30H3dYXB9LAeNmwkpjMTaIjlloAOowOy+4oclTNL?=
 =?us-ascii?Q?TiN6BS9UebzdexlxG/iCNpPss+azMGmA4bRFqOobr8pi2G1KvVLNm3OV6Zwe?=
 =?us-ascii?Q?u3MMTPE24wg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:18:09.8747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ea87e6-c24c-425a-6251-08dcfa561a8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9419
X-Mailman-Approved-At: Fri, 01 Nov 2024 13:56:15 +0100
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

I have put togethere couple of patches to convert platforms to use binman.
The first patch has been sent separately. The third (SOM description) has
been also sent out for ilustration as RFC.
The last one is just cherry-pick the patch which has been reverted because
our platform wasn't converted to binman yet.

v1 of external description
https://lore.kernel.org/r/fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com

RFC for SOM:
https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com

Thanks,
Michal

Changes in v2:
- Change subject, align commit message
- binman - rename variable
- Use relative path
- Use separate variable in makefile to also handle empty string and default
  to u-boot.dtb
- new patch
- new patch
- Align fit,fdt-list-val to have shorter lines
- Add reference to defconfig
- Rename zynqmp-som-binman.dts to zynqmp-binman-som.dts
- Use conf instead of config
- Change image name from image.bin to qspi.bin
- Remove RFC
- Change default addresses for BL31/BL32
- new patch
- new patch
- Rebase on the top of my series which do conversion to binman
- Taken from git with all tags

Marek Vasut (1):
  Makefile: Drop SPL_FIT_GENERATOR support

Michal Simek (6):
  binman: Add option for pointing to separate description
  common: binman: Calling initr_binman() when BINMAN_FDT
  arm64: zynqmp: Describe empty binman node
  arm64: zynqmp: Add binman description for SOM
  arm64: zynqmp: Generate u-boot.itb and QSPI image via binman
  arm64: zynqmp: Remove mkimage fit script

 Makefile                                      |  29 +--
 arch/arm/Kconfig                              |   1 +
 arch/arm/dts/Makefile                         |   3 +
 arch/arm/dts/zynqmp-binman-mini.dts           |  10 +
 arch/arm/dts/zynqmp-binman-som.dts            | 225 ++++++++++++++++
 arch/arm/dts/zynqmp-binman.dts                | 111 ++++++++
 arch/arm/dts/zynqmp-u-boot.dtsi               |  11 +
 arch/arm/mach-zynqmp/Kconfig                  |  14 +
 arch/arm/mach-zynqmp/mkimage_fit_atf.sh       | 240 ------------------
 boot/Kconfig                                  |  15 --
 common/board_r.c                              |   7 +-
 configs/xilinx_zynqmp_kria_defconfig          |   3 +
 configs/xilinx_zynqmp_mini_defconfig          |   2 +
 configs/xilinx_zynqmp_mini_emmc0_defconfig    |   3 +
 configs/xilinx_zynqmp_mini_emmc1_defconfig    |   3 +
 configs/xilinx_zynqmp_mini_nand_defconfig     |   2 +
 .../xilinx_zynqmp_mini_nand_single_defconfig  |   2 +
 configs/xilinx_zynqmp_mini_qspi_defconfig     |   3 +
 configs/xilinx_zynqmp_virt_defconfig          |   3 +
 doc/usage/fit/howto.rst                       |   4 -
 lib/Kconfig                                   |   9 +
 21 files changed, 418 insertions(+), 282 deletions(-)
 create mode 100644 arch/arm/dts/zynqmp-binman-mini.dts
 create mode 100644 arch/arm/dts/zynqmp-binman-som.dts
 create mode 100644 arch/arm/dts/zynqmp-binman.dts
 create mode 100644 arch/arm/dts/zynqmp-u-boot.dtsi
 delete mode 100755 arch/arm/mach-zynqmp/mkimage_fit_atf.sh

-- 
2.43.0

