Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE4C1EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECA586440;
	Tue, 22 Aug 2023 17:03:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lM3E1JQN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA2384702; Tue, 22 Aug 2023 17:03:57 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe12::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96A8B86432
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:03:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFNT9PMwiHHoTzfL7in9S8vXZuEHtjvGPXRwDc/oSZ0tvdrgMOiF7T3VUA7duuvbMZDM3TZRmPaPTMwScXXbUKKRjaMmrE5R+A5cksiQYYS5L6EiWr0faovUm2/N0qVaXKt2SM4kvIg0mexa7kEd1QfGHOqAtr7pZch9GtsndkUP2R7n9yqgeMJzg3lbwPx1Ri3DsEjgBeaYPCDdBos4x54iV9jzWzdHZp0OqEvRCza56Cq/KKzTbrDxJRFwnGX82cI5haEBMpx1xr4UVstu+2LKeKGtLe35Pk+sS0gv8yOyNPfzWApDvBX2AXS+Kp92Y+JDAP2vr7WrIZ/gxOfrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MlPtyD4KvCt7CWBOl200jU07xdAqtxq+Z3/ogK/g7Us=;
 b=hJgmM2ym5hnA8GM5xTEJThg3xcqSa4O4MEiVhTqRdCqHPElamDEbECx2KhegkNjIaRDy485wTlK8nKZfKqKgecmMA9sLTh0nevOQbeVQgzTvUluaNaFaHzPDrkDsoUZORP1v3kbVboBy/uoGN6YjywYg8F8yK2G1KoIElnEPmvObUYg9LCAJfOMVa1MfyKUDAl+HwtgfIeY44DgI4IZYtjB48XNrQOSrl2lmyuxH36cHB3+Rvsg7AWYS5W2giyvzAf21XiqGKc2z0qPrzSga8YkYE57ANNdAe1RCXZYUj1p/smXPgKKCdp/a7t+LS0plQ6ySry/88lxN1yjkNfi2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MlPtyD4KvCt7CWBOl200jU07xdAqtxq+Z3/ogK/g7Us=;
 b=lM3E1JQNAGmCpuEf/zLS0QoACI1tcTCeTMRxw1E6pybZireHDjEEie0jFWOYu26L6S+yM3uExFOsQXGkBnCbydQpzaB8UUNW89+q3hPIB9lluUHBb1hsQ47tmbQKw+i7ggoQDeGGSF/snf938cA7k5eHLOxoDDobBRw+fZHywqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by AM9PR04MB8132.eurprd04.prod.outlook.com (2603:10a6:20b:3eb::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:03:52 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6678.029; Tue, 22 Aug 2023
 15:03:52 +0000
From: laurentiu.tudor@nxp.com
To: rajesh.bhagat@nxp.com, pramod.kumar_1@nxp.com, andy.tang@nxp.com,
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com,
 wasim.khan@nxp.com, matt@traverse.com.au, udit.agarwal@nxp.com,
 joe.hershberger@ni.com, peng.fan@nxp.com, sjg@chromium.org,
 u-boot@lists.denx.de
Cc: michael@walle.cc, camelia.groza@nxp.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 3/3] fsl-layerscape: drop obsolete PPA secure firmware
 support
Date: Tue, 22 Aug 2023 18:03:34 +0300
Message-Id: <20230822150334.15703-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230822150334.15703-1-laurentiu.tudor@nxp.com>
References: <20230822150334.15703-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0027.eurprd07.prod.outlook.com
 (2603:10a6:205:1::40) To DB9PR04MB9380.eurprd04.prod.outlook.com
 (2603:10a6:10:368::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9380:EE_|AM9PR04MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 832b0952-6b9d-4083-4e3b-08dba320ff3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJyJVYytgJ9gEosFrAJ8JIvmk96e07RYsjQfdQi6/99oiwH6psC+79ap2mJMp+Yrzoa4be9N0YUPb7wmKSlpU5hnPUQ5o6lmheV4SFWfy9LDDJ1ZiXXCtthMTNpE5jDmJx6Ulm0GVdIeVXsHnGfbR3JfQVhLP2Q8Zxji9prb5z/oyjbpU0PFVM88JFBnmPCG2YkngB2vnCceZOgqkiJKURpGmy2nq0gtQ08A57TDI901QTDS4IMmqE4sBdEdW8UJTVbxPAOfRtgSdzl5mxgBOr18YuyNPq85iSe6cjJD7NeA1sYhauE/WJCudl8G5Hd0j3U2PyRl17BXCQfeOuZwO/0exWPNwfF0y+TUWfxSbVok9r253L8aYHnuOh4ZcP3TDsJkEQzJdM5npY9Bn3bDfYgfSvxlKdm24vc7ZUPflQggEZBoNdlmiZO4lZlcPYXFaXEWFFCEXLT4AT6V2znL5pIwlcey1jpUOTBz5Fvg4ly1egXYcvO7j0RL9MuL+BB5wgA+NHVrmivkrT/58NOFhwRqJWazzV8lEUcwlIy01qWwsdUtMeT9GkjnIj/aC4KGUerIgrxjrjpVFJNa+zPmIQm49WzTfmPYKdSZbgeH275DJf+rlhfFmEQvYGrYvx1wRQJzLvUMgn43VQjCNlJLFSdx4AcMI7PJxk9WnyffolE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(39860400002)(346002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(66946007)(9686003)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(1076003)(921005)(478600001)(6666004)(38100700002)(38350700002)(52116002)(6486002)(6506007)(83380400001)(30864003)(2906002)(86362001)(5660300002)(26005)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xzasd0FBQrsdj1eShs1stBkDPVPO0svcROTSrslnsWBId5Hr5F+4at4EVp+t?=
 =?us-ascii?Q?16gpIYA5h4EGVe0YVFxdzmQfApPLVlL3w7aLhnhCTrVR7uuc/DBLrqOStbTM?=
 =?us-ascii?Q?7m2LAwMG6teon6mhbVGnAyw9J2ZyIPeM/Z89kZwcAgX5Lvfo9oTz1GXmN5xs?=
 =?us-ascii?Q?7Dc8blst1oVlSnvcRAklTvpUX7d48ne/28cKpkZEpf/UPstXg8m5vtiSIm8m?=
 =?us-ascii?Q?T2sJixN5nJempkeWh0epFm54FQ7lTzic+qq952rrhZh56ZhcSxi9JMVu/YwB?=
 =?us-ascii?Q?MHxqbdzQZKBQ7zzgYSn5IIjLLvzSpHiFjZiYiRyki+PMnEDadtYdWw49Vprx?=
 =?us-ascii?Q?e4qZvnWyN7uZnbLOjE+Ep9ThZVz6mtAaYCGs5iTQ7V7IdTjX2jmJ8o7iGwxq?=
 =?us-ascii?Q?N+H/oDRyIBGDByp9VuRsL1DHJIX1+36F7qyI2lvNK15HC7aLpkQyWsgmeqzW?=
 =?us-ascii?Q?kgy7Se9ngTiJW+n9TodofiRXEcLnpPXRstSQ7Ag7jMjWMGdUcci1Z9qAhsR3?=
 =?us-ascii?Q?u8yPm/CMcKlw3V27s/bWrfoB1THIZbOub3V2g0DtAWhZA5VzqKPHUE5VT9hP?=
 =?us-ascii?Q?ZXlNBHEjrD91dMaKG/Ou3IODC6lroej0Snp4bmcLkd1K9b6eeqAjXNYpO9d5?=
 =?us-ascii?Q?hI5vZX0b98Grz+PcVGxchmfcHoDf3Wn9MywxOzsSs/yC+WfaIwakFLOlsXnl?=
 =?us-ascii?Q?6v9tvBnKh3ZIgHBoJ+SxGsK850F6jw0WHDk170QX6blMk+wsPZu+nE9pKqb2?=
 =?us-ascii?Q?m8tD4x1+/27BJxOfd3WBa/rmaIuQlsKJxkBFJ6XDjc4Dn7DbwyVT4araeXa0?=
 =?us-ascii?Q?WlvF6HdNRUW/Td+G6PuIUecPC7QG3A4RAIoJxkB6XvdVdHGuqhvmXdG25LKK?=
 =?us-ascii?Q?K2JvWN25uckLqpz3d9vj8k+5kANdj5rZyKPpjt/tL3xrUKVI+IuHrv3IPhsS?=
 =?us-ascii?Q?v1cdZSaEX3WRwkVd4VcOE+6zVARz+T7x8soAbDbX4YHM0yNQReaaie1t7e96?=
 =?us-ascii?Q?7/u152Z3PuIurL9vWUejkOzP+VyQFARyIPQWLEVxvYP22U0aUyJa9DL7Fo4p?=
 =?us-ascii?Q?SZbRw+CYUoGpckenbD7PDVvOCepGXz4NxDfInr/2xNQd9AoeJRlwmNphCXv0?=
 =?us-ascii?Q?q0AQlmgRGRpraDhad37Hqnw5W9eIXsm/u9jckqI1xmukav0IBzLVWo/3mEQi?=
 =?us-ascii?Q?RcWMeRaJ+EnSvZFrzcYxobEr35IL+9eOc7pJm3eXOr4vXE4PrgBMKZmQmOxY?=
 =?us-ascii?Q?vLe7cDy8BQijhz1UuaEWs3cLKFyCWYacRNUXlums+3x6i3DOLPnPjrzTiGVR?=
 =?us-ascii?Q?RB/2hWAyefBAJFu6nQiKvKE+SZZZM8AGJi//dBTVSDBm6xtQh3XAlW+jGlIP?=
 =?us-ascii?Q?8+Vfc1ZfUscrpS4ESg98LP/nGVsYl+TqTIBwZr8LUSKnO9l1Smb5urDB3xp9?=
 =?us-ascii?Q?nw/TJlnPC1WQ04A3Ks51tToznmrg8xXiY0uVd9fbK5sovQkjEsBtfZtLgLSR?=
 =?us-ascii?Q?OHlqpGok/o3BE/M5qmaEDhwEhnAC6gDhjlrlwWEpSVVQV8iydf+KwbFM3ev3?=
 =?us-ascii?Q?gmYcjN03K9Wdx/u+DUFIvBT9JUBvPNw4XVsmjV+y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832b0952-6b9d-4083-4e3b-08dba320ff3f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:03:52.1612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IKhJDfOIjflx2fqy/dHJE5oF4QIDPgWA9CzG1zkkH96+5UaRWDA+MnSH4ARXbI7IkdJGphGXkhqK3CwxycM6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8132
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

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

PPA was a secure firmware developed in-house which is no longer
supported and replaced by TF-A quite some years ago. Drop support
for it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig     |  60 ----
 arch/arm/cpu/armv8/fsl-layerscape/Makefile    |   1 -
 arch/arm/cpu/armv8/fsl-layerscape/ppa.c       | 284 ------------------
 arch/arm/cpu/armv8/fsl-layerscape/spl.c       |  34 ---
 .../arm/include/asm/arch-fsl-layerscape/ppa.h |  12 -
 arch/arm/include/asm/fsl_secure_boot.h        |   9 -
 board/freescale/ls1012afrdm/Kconfig           |  11 -
 board/freescale/ls1012afrdm/ls1012afrdm.c     |   6 -
 board/freescale/ls1012aqds/Kconfig            |   8 -
 board/freescale/ls1012aqds/ls1012aqds.c       |   6 -
 board/freescale/ls1012ardb/Kconfig            |  12 -
 board/freescale/ls1012ardb/ls1012ardb.c       |   6 -
 board/freescale/ls1028a/Kconfig               |  12 -
 board/freescale/ls1028a/ls1028a.c             |   7 -
 board/freescale/ls1043aqds/Kconfig            |  16 -
 board/freescale/ls1043aqds/ls1043aqds.c       |   5 -
 board/freescale/ls1043ardb/Kconfig            |  14 -
 board/freescale/ls1043ardb/ls1043ardb.c       |   5 -
 board/freescale/ls1046aqds/Kconfig            |  16 -
 board/freescale/ls1046aqds/ls1046aqds.c       |   5 -
 board/freescale/ls1046ardb/Kconfig            |  14 -
 board/freescale/ls1046ardb/ls1046ardb.c       |   5 -
 board/freescale/ls1088a/Kconfig               |  28 --
 board/freescale/ls1088a/ls1088a.c             |   5 -
 board/freescale/ls2080aqds/Kconfig            |  16 -
 board/freescale/ls2080aqds/ls2080aqds.c       |   5 -
 board/freescale/ls2080ardb/Kconfig            |  16 -
 board/freescale/ls2080ardb/ls2080ardb.c       |   5 -
 board/traverse/ten64/ten64.c                  |   1 -
 env/Kconfig                                   |   2 +-
 include/configs/ls1046a_common.h              |   3 +-
 31 files changed, 2 insertions(+), 627 deletions(-)
 delete mode 100644 arch/arm/cpu/armv8/fsl-layerscape/ppa.c
 delete mode 100644 arch/arm/include/asm/arch-fsl-layerscape/ppa.h

diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
index a8b493e2f875..c45e4e63b4bb 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
@@ -390,66 +390,6 @@ config HAS_FEATURE_ENHANCED_MSI
 	bool
 	default y if ARCH_LS1043A
 
-menu "Layerscape PPA"
-config FSL_LS_PPA
-	bool "FSL Layerscape PPA firmware support"
-	depends on !ARMV8_PSCI
-	select ARMV8_SEC_FIRMWARE_SUPPORT
-	select SEC_FIRMWARE_ARMV8_PSCI
-	select ARMV8_SEC_FIRMWARE_ERET_ADDR_REVERT if FSL_LSCH2
-	help
-	  The FSL Primary Protected Application (PPA) is a software component
-	  which is loaded during boot stage, and then remains resident in RAM
-	  and runs in the TrustZone after boot.
-	  Say y to enable it.
-
-config SPL_FSL_LS_PPA
-	bool "FSL Layerscape PPA firmware support for SPL build"
-	depends on !ARMV8_PSCI
-	select SPL_ARMV8_SEC_FIRMWARE_SUPPORT
-	select SEC_FIRMWARE_ARMV8_PSCI
-	select ARMV8_SEC_FIRMWARE_ERET_ADDR_REVERT if FSL_LSCH2
-	help
-	  The FSL Primary Protected Application (PPA) is a software component
-	  which is loaded during boot stage, and then remains resident in RAM
-	  and runs in the TrustZone after boot. This is to load PPA during SPL
-	  stage instead of the RAM version of U-Boot. Once PPA is initialized,
-	  the rest of U-Boot (including RAM version) runs at EL2.
-choice
-	prompt "FSL Layerscape PPA firmware loading-media select"
-	depends on FSL_LS_PPA
-	default SYS_LS_PPA_FW_IN_MMC if SD_BOOT
-	default SYS_LS_PPA_FW_IN_NAND if NAND_BOOT
-	default SYS_LS_PPA_FW_IN_XIP
-
-config SYS_LS_PPA_FW_IN_XIP
-	bool "XIP"
-	help
-	  Say Y here if the PPA firmware locate at XIP flash, such
-	  as NOR or QSPI flash.
-
-config SYS_LS_PPA_FW_IN_MMC
-	bool "eMMC or SD Card"
-	help
-	  Say Y here if the PPA firmware locate at eMMC/SD card.
-
-config SYS_LS_PPA_FW_IN_NAND
-	bool "NAND"
-	help
-	  Say Y here if the PPA firmware locate at NAND flash.
-
-endchoice
-
-config LS_PPA_ESBC_HDR_SIZE
-	hex "Length of PPA ESBC header"
-	depends on FSL_LS_PPA && CHAIN_OF_TRUST && !SYS_LS_PPA_FW_IN_XIP
-	default 0x2000
-	help
-	  Length (in bytes) of PPA ESBC header to be copied from MMC/SD or
-	  NAND to memory to validate PPA image.
-
-endmenu
-
 config SYS_FSL_ERRATUM_A008997
 	bool "Workaround for USB PHY erratum A008997"
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Makefile b/arch/arm/cpu/armv8/fsl-layerscape/Makefile
index 598c36ee660a..eefdf12369c3 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Makefile
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Makefile
@@ -10,7 +10,6 @@ obj-$(CONFIG_MP) += mp.o spintable.o
 obj-$(CONFIG_OF_LIBFDT) += fdt.o
 endif
 obj-$(CONFIG_SPL) += spl.o
-obj-$(CONFIG_$(SPL_)FSL_LS_PPA) += ppa.o
 
 ifneq ($(CONFIG_FSL_LSCH3),)
 obj-y += fsl_lsch3_speed.o
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ppa.c b/arch/arm/cpu/armv8/fsl-layerscape/ppa.c
deleted file mode 100644
index 117b7a053c51..000000000000
--- a/arch/arm/cpu/armv8/fsl-layerscape/ppa.c
+++ /dev/null
@@ -1,284 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2016 NXP Semiconductor, Inc.
- */
-#include <common.h>
-#include <log.h>
-#include <malloc.h>
-#include <config.h>
-#include <errno.h>
-#include <asm/cache.h>
-#include <asm/global_data.h>
-#include <asm/system.h>
-#include <asm/types.h>
-#include <asm/arch/soc.h>
-#ifdef CONFIG_FSL_LSCH3
-#include <asm/arch/immap_lsch3.h>
-#elif defined(CONFIG_FSL_LSCH2)
-#include <asm/arch/immap_lsch2.h>
-#endif
-#if CONFIG_IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)
-#include <asm/armv8/sec_firmware.h>
-#endif
-#ifdef CONFIG_CHAIN_OF_TRUST
-#include <fsl_validate.h>
-#endif
-
-#ifdef CONFIG_SYS_LS_PPA_FW_IN_NAND
-#include <nand.h>
-#elif defined(CONFIG_SYS_LS_PPA_FW_IN_MMC)
-#include <mmc.h>
-#endif
-
-DECLARE_GLOBAL_DATA_PTR;
-
-int ppa_init(void)
-{
-	unsigned int el = current_el();
-	void *ppa_fit_addr;
-	u32 *boot_loc_ptr_l, *boot_loc_ptr_h;
-	u32 *loadable_l, *loadable_h;
-	int ret;
-
-#ifdef CONFIG_CHAIN_OF_TRUST
-	uintptr_t ppa_esbc_hdr = 0;
-	uintptr_t ppa_img_addr = 0;
-#if defined(CONFIG_SYS_LS_PPA_FW_IN_MMC) || \
-	defined(CONFIG_SYS_LS_PPA_FW_IN_NAND)
-	void *ppa_hdr_ddr;
-#endif
-#endif
-
-	/* Skip if running at lower exception level */
-	if (el < 3) {
-		debug("Skipping PPA init, running at EL%d\n", el);
-		return 0;
-	}
-
-#ifdef CONFIG_SYS_LS_PPA_FW_IN_XIP
-	ppa_fit_addr = (void *)CONFIG_SYS_LS_PPA_FW_ADDR;
-	debug("%s: PPA image load from XIP\n", __func__);
-#ifdef CONFIG_CHAIN_OF_TRUST
-	ppa_esbc_hdr = CONFIG_SYS_LS_PPA_ESBC_ADDR;
-#endif
-#else /* !CONFIG_SYS_LS_PPA_FW_IN_XIP */
-	size_t fw_length, fdt_header_len = sizeof(struct fdt_header);
-
-	/* Copy PPA image from MMC/SD/NAND to allocated memory */
-#ifdef CONFIG_SYS_LS_PPA_FW_IN_MMC
-	struct mmc *mmc;
-	int dev = CONFIG_SYS_MMC_ENV_DEV;
-	struct fdt_header *fitp;
-	u32 cnt;
-	u32 blk;
-
-	debug("%s: PPA image load from eMMC/SD\n", __func__);
-
-	ret = mmc_initialize(gd->bd);
-	if (ret) {
-		printf("%s: mmc_initialize() failed\n", __func__);
-		return ret;
-	}
-	mmc = find_mmc_device(dev);
-	if (!mmc) {
-		printf("PPA: MMC cannot find device for PPA firmware\n");
-		return -ENODEV;
-	}
-
-	ret = mmc_init(mmc);
-	if (ret) {
-		printf("%s: mmc_init() failed\n", __func__);
-		return ret;
-	}
-
-	fitp = malloc(roundup(fdt_header_len, 512));
-	if (!fitp) {
-		printf("PPA: malloc failed for FIT header(size 0x%zx)\n",
-		       roundup(fdt_header_len, 512));
-		return -ENOMEM;
-	}
-
-	blk = CONFIG_SYS_LS_PPA_FW_ADDR / 512;
-	cnt = DIV_ROUND_UP(fdt_header_len, 512);
-	debug("%s: MMC read PPA FIT header: dev # %u, block # %u, count %u\n",
-	      __func__, dev, blk, cnt);
-	ret = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, fitp);
-	if (ret != cnt) {
-		free(fitp);
-		printf("MMC/SD read of PPA FIT header at offset 0x%x failed\n",
-		       CONFIG_SYS_LS_PPA_FW_ADDR);
-		return -EIO;
-	}
-
-	ret = fdt_check_header(fitp);
-	if (ret) {
-		free(fitp);
-		printf("%s: fdt_check_header() failed\n", __func__);
-		return ret;
-	}
-
-#ifdef CONFIG_CHAIN_OF_TRUST
-	ppa_hdr_ddr = malloc(CONFIG_LS_PPA_ESBC_HDR_SIZE);
-	if (!ppa_hdr_ddr) {
-		printf("PPA: malloc failed for PPA header\n");
-		return -ENOMEM;
-	}
-
-	blk = CONFIG_SYS_LS_PPA_ESBC_ADDR >> 9;
-	cnt = DIV_ROUND_UP(CONFIG_LS_PPA_ESBC_HDR_SIZE, 512);
-	ret = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, ppa_hdr_ddr);
-	if (ret != cnt) {
-		free(ppa_hdr_ddr);
-		printf("MMC/SD read of PPA header failed\n");
-		return -EIO;
-	}
-	debug("Read PPA header to 0x%p\n", ppa_hdr_ddr);
-
-	ppa_esbc_hdr = (uintptr_t)ppa_hdr_ddr;
-#endif
-
-	fw_length = fdt_totalsize(fitp);
-	free(fitp);
-
-	fw_length = roundup(fw_length, 512);
-	ppa_fit_addr = malloc(fw_length);
-	if (!ppa_fit_addr) {
-		printf("PPA: malloc failed for PPA image(size 0x%zx)\n",
-		       fw_length);
-		return -ENOMEM;
-	}
-
-	blk = CONFIG_SYS_LS_PPA_FW_ADDR / 512;
-	cnt = DIV_ROUND_UP(fw_length, 512);
-	debug("%s: MMC read PPA FIT image: dev # %u, block # %u, count %u\n",
-	      __func__, dev, blk, cnt);
-	ret = blk_dread(mmc_get_blk_desc(mmc), blk, cnt, ppa_fit_addr);
-	if (ret != cnt) {
-		free(ppa_fit_addr);
-		printf("MMC/SD read of PPA FIT header at offset 0x%x failed\n",
-		       CONFIG_SYS_LS_PPA_FW_ADDR);
-		return -EIO;
-	}
-
-#elif defined(CONFIG_SYS_LS_PPA_FW_IN_NAND)
-	struct fdt_header fit;
-
-	debug("%s: PPA image load from NAND\n", __func__);
-
-	nand_init();
-	ret = nand_read(get_nand_dev_by_index(0),
-			(loff_t)CONFIG_SYS_LS_PPA_FW_ADDR,
-			&fdt_header_len, (u_char *)&fit);
-	if (ret == -EUCLEAN) {
-		printf("NAND read of PPA FIT header at offset 0x%x failed\n",
-		       CONFIG_SYS_LS_PPA_FW_ADDR);
-		return -EIO;
-	}
-
-	ret = fdt_check_header(&fit);
-	if (ret) {
-		printf("%s: fdt_check_header() failed\n", __func__);
-		return ret;
-	}
-
-#ifdef CONFIG_CHAIN_OF_TRUST
-	ppa_hdr_ddr = malloc(CONFIG_LS_PPA_ESBC_HDR_SIZE);
-	if (!ppa_hdr_ddr) {
-		printf("PPA: malloc failed for PPA header\n");
-		return -ENOMEM;
-	}
-
-	fw_length = CONFIG_LS_PPA_ESBC_HDR_SIZE;
-
-	ret = nand_read(get_nand_dev_by_index(0),
-			(loff_t)CONFIG_SYS_LS_PPA_ESBC_ADDR,
-			&fw_length, (u_char *)ppa_hdr_ddr);
-	if (ret == -EUCLEAN) {
-		free(ppa_hdr_ddr);
-		printf("NAND read of PPA firmware at offset 0x%x failed\n",
-		       CONFIG_SYS_LS_PPA_FW_ADDR);
-		return -EIO;
-	}
-	debug("Read PPA header to 0x%p\n", ppa_hdr_ddr);
-
-	ppa_esbc_hdr = (uintptr_t)ppa_hdr_ddr;
-#endif
-
-	fw_length = fdt_totalsize(&fit);
-
-	ppa_fit_addr = malloc(fw_length);
-	if (!ppa_fit_addr) {
-		printf("PPA: malloc failed for PPA image(size 0x%zx)\n",
-		       fw_length);
-		return -ENOMEM;
-	}
-
-	ret = nand_read(get_nand_dev_by_index(0),
-			(loff_t)CONFIG_SYS_LS_PPA_FW_ADDR,
-			&fw_length, (u_char *)ppa_fit_addr);
-	if (ret == -EUCLEAN) {
-		free(ppa_fit_addr);
-		printf("NAND read of PPA firmware at offset 0x%x failed\n",
-		       CONFIG_SYS_LS_PPA_FW_ADDR);
-		return -EIO;
-	}
-#else
-#error "No CONFIG_SYS_LS_PPA_FW_IN_xxx defined"
-#endif
-
-#endif
-
-#ifdef CONFIG_CHAIN_OF_TRUST
-	ppa_img_addr = (uintptr_t)ppa_fit_addr;
-	if (fsl_check_boot_mode_secure() != 0) {
-		/*
-		 * In case of failure in validation, fsl_secboot_validate
-		 * would not return back in case of Production environment
-		 * with ITS=1. In Development environment (ITS=0 and
-		 * SB_EN=1), the function may return back in case of
-		 * non-fatal failures.
-		 */
-		ret = fsl_secboot_validate(ppa_esbc_hdr,
-					   PPA_KEY_HASH,
-					   &ppa_img_addr);
-		if (ret != 0)
-			printf("SEC firmware(s) validation failed\n");
-		else
-			printf("SEC firmware(s) validation Successful\n");
-	}
-#if defined(CONFIG_SYS_LS_PPA_FW_IN_MMC) || \
-	defined(CONFIG_SYS_LS_PPA_FW_IN_NAND)
-	free(ppa_hdr_ddr);
-#endif
-#endif
-
-#ifdef CONFIG_FSL_LSCH3
-	struct ccsr_gur __iomem *gur = (void *)(CFG_SYS_FSL_GUTS_ADDR);
-	boot_loc_ptr_l = &gur->bootlocptrl;
-	boot_loc_ptr_h = &gur->bootlocptrh;
-
-	/* Assign addresses to loadable ptrs */
-	loadable_l = &gur->scratchrw[4];
-	loadable_h = &gur->scratchrw[5];
-#elif defined(CONFIG_FSL_LSCH2)
-	struct ccsr_scfg __iomem *scfg = (void *)(CFG_SYS_FSL_SCFG_ADDR);
-	boot_loc_ptr_l = &scfg->scratchrw[1];
-	boot_loc_ptr_h = &scfg->scratchrw[0];
-
-	/* Assign addresses to loadable ptrs */
-	loadable_l = &scfg->scratchrw[2];
-	loadable_h = &scfg->scratchrw[3];
-#endif
-
-	debug("fsl-ppa: boot_loc_ptr_l = 0x%p, boot_loc_ptr_h =0x%p\n",
-	      boot_loc_ptr_l, boot_loc_ptr_h);
-	ret = sec_firmware_init(ppa_fit_addr, boot_loc_ptr_l, boot_loc_ptr_h,
-				loadable_l, loadable_h);
-
-#if defined(CONFIG_SYS_LS_PPA_FW_IN_MMC) || \
-	defined(CONFIG_SYS_LS_PPA_FW_IN_NAND)
-	free(ppa_fit_addr);
-#endif
-
-	return ret;
-}
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
index 61fced451eb5..94aa5eeeea44 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
@@ -21,7 +21,6 @@
 #include <i2c.h>
 #include <fsl_csu.h>
 #include <asm/arch/fdt.h>
-#include <asm/arch/ppa.h>
 #include <asm/arch/soc.h>
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -62,9 +61,6 @@ void spl_board_init(void)
 #ifdef CONFIG_LAYERSCAPE_NS_ACCESS
 	enable_layerscape_ns_access();
 #endif
-#ifdef CONFIG_SPL_FSL_LS_PPA
-	ppa_init();
-#endif
 }
 
 void tzpc_init(void)
@@ -115,36 +111,6 @@ void board_init_f(ulong dummy)
 	init_func_vid();
 #endif
 	dram_init();
-#ifdef CONFIG_SPL_FSL_LS_PPA
-#ifndef CFG_SYS_MEM_RESERVE_SECURE
-#error Need secure RAM for PPA
-#endif
-	/*
-	 * Secure memory location is determined in dram_init_banksize().
-	 * gd->ram_size is deducted by the size of secure ram.
-	 */
-	dram_init_banksize();
-
-	/*
-	 * After dram_init_bank_size(), we know U-Boot only uses the first
-	 * memory bank regardless how big the memory is.
-	 */
-	gd->ram_top = gd->bd->bi_dram[0].start + gd->bd->bi_dram[0].size;
-
-	/*
-	 * If PPA is loaded, U-Boot will resume running at EL2.
-	 * Cache and MMU will be enabled. Need a place for TLB.
-	 * U-Boot will be relocated to the end of available memory
-	 * in first bank. At this point, we cannot know how much
-	 * memory U-Boot uses. Put TLB table lower by SPL_TLB_SETBACK
-	 * to avoid overlapping. As soon as the RAM version U-Boot sets
-	 * up new MMU, this space is no longer needed.
-	 */
-	gd->ram_top -= SPL_TLB_SETBACK;
-	gd->arch.tlb_size = PGTABLE_SIZE;
-	gd->arch.tlb_addr = (gd->ram_top - gd->arch.tlb_size) & ~(0x10000 - 1);
-	gd->arch.tlb_allocated = gd->arch.tlb_addr;
-#endif	/* CONFIG_SPL_FSL_LS_PPA */
 #if defined(CONFIG_QSPI_AHB_INIT) && defined(CONFIG_QSPI_BOOT)
 	qspi_ahb_init();
 #endif
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/ppa.h b/arch/arm/include/asm/arch-fsl-layerscape/ppa.h
deleted file mode 100644
index f0c4a84f7ca4..000000000000
--- a/arch/arm/include/asm/arch-fsl-layerscape/ppa.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright 2016 NXP Semiconductor, Inc.
- */
-
-#ifndef __FSL_PPA_H_
-#define __FSL_PPA_H_
-
-#ifdef CONFIG_FSL_LS_PPA
-int ppa_init(void);
-#endif
-#endif
diff --git a/arch/arm/include/asm/fsl_secure_boot.h b/arch/arm/include/asm/fsl_secure_boot.h
index 6a9d198cb811..15627c96e906 100644
--- a/arch/arm/include/asm/fsl_secure_boot.h
+++ b/arch/arm/include/asm/fsl_secure_boot.h
@@ -9,15 +9,6 @@
 
 #ifdef CONFIG_CHAIN_OF_TRUST
 #ifndef CONFIG_SPL_BUILD
-#ifdef CONFIG_FSL_LS_PPA
-/* Define the key hash here if SRK used for signing PPA image is
- * different from SRK hash put in SFP used for U-Boot.
- * Example
- * #define PPA_KEY_HASH \
- *	"41066b564c6ffcef40ccbc1e0a5d0d519604000c785d97bbefd25e4d288d1c8b"
- */
-#define PPA_KEY_HASH		NULL
-#endif /* ifdef CONFIG_FSL_LS_PPA */
 
 #endif /* #ifndef CONFIG_SPL_BUILD */
 #endif /* #ifdef CONFIG_CHAIN_OF_TRUST */
diff --git a/board/freescale/ls1012afrdm/Kconfig b/board/freescale/ls1012afrdm/Kconfig
index 75de782afc9c..a7e59e626565 100644
--- a/board/freescale/ls1012afrdm/Kconfig
+++ b/board/freescale/ls1012afrdm/Kconfig
@@ -20,9 +20,6 @@ config SYS_LS_PFE_FW_LENGTH
 	hex "length of PFE firmware"
 	default 0x40000
 
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x40400000
 endif
 
 if FSL_PFE
@@ -73,14 +70,6 @@ config SYS_LS_PFE_FW_LENGTH
 	hex "length of PFE firmware"
 	default 0x40000
 
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x40060000
-
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x401f4000
-
 config SYS_LS_PFE_ESBC_ADDR
 	hex "PFE Firmware HDR Addr"
 	default 0x401f8000
diff --git a/board/freescale/ls1012afrdm/ls1012afrdm.c b/board/freescale/ls1012afrdm/ls1012afrdm.c
index f2b8750a3f38..271072bf7a1c 100644
--- a/board/freescale/ls1012afrdm/ls1012afrdm.c
+++ b/board/freescale/ls1012afrdm/ls1012afrdm.c
@@ -12,9 +12,6 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/fsl_serdes.h>
-#ifdef CONFIG_FSL_LS_PPA
-#include <asm/arch/ppa.h>
-#endif
 #include <asm/arch/mmu.h>
 #include <asm/arch/soc.h>
 #include <fsl_esdhc.h>
@@ -171,9 +168,6 @@ int board_init(void)
 	if (current_el() == 3)
 		out_le32(&cci->ctrl_ord, CCI400_CTRLORD_EN_BARRIER);
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
 	return 0;
 }
 
diff --git a/board/freescale/ls1012aqds/Kconfig b/board/freescale/ls1012aqds/Kconfig
index 991ba6044db8..d333069898fb 100644
--- a/board/freescale/ls1012aqds/Kconfig
+++ b/board/freescale/ls1012aqds/Kconfig
@@ -12,15 +12,7 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1012aqds"
 
-config SYS_LS_PPA_FW_ADDR
-        hex "PPA Firmware Addr"
-        default 0x40400000
-
 if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x40680000
-
 config SYS_LS_PFE_ESBC_ADDR
 	hex "PFE Firmware HDR Addr"
 	default 0x40700000
diff --git a/board/freescale/ls1012aqds/ls1012aqds.c b/board/freescale/ls1012aqds/ls1012aqds.c
index 194b5d27295b..a5ea8d634edc 100644
--- a/board/freescale/ls1012aqds/ls1012aqds.c
+++ b/board/freescale/ls1012aqds/ls1012aqds.c
@@ -13,9 +13,6 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/fsl_serdes.h>
-#ifdef CONFIG_FSL_LS_PPA
-#include <asm/arch/ppa.h>
-#endif
 #include <asm/arch/fdt.h>
 #include <asm/arch/mmu.h>
 #include <asm/arch/soc.h>
@@ -150,9 +147,6 @@ int board_init(void)
 	erratum_a010315();
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
 	return 0;
 }
 
diff --git a/board/freescale/ls1012ardb/Kconfig b/board/freescale/ls1012ardb/Kconfig
index aa15f5a027e8..b55660d485fa 100644
--- a/board/freescale/ls1012ardb/Kconfig
+++ b/board/freescale/ls1012ardb/Kconfig
@@ -12,15 +12,7 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1012ardb"
 
-config SYS_LS_PPA_FW_ADDR
-        hex "PPA Firmware Addr"
-        default 0x40400000
-
 if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x40680000
-
 config SYS_LS_PFE_ESBC_ADDR
 	hex "PFE Firmware HDR Addr"
 	default 0x40640000
@@ -79,10 +71,6 @@ config SYS_SOC
 config SYS_CONFIG_NAME
         default "ls1012a2g5rdb"
 
-config SYS_LS_PPA_FW_ADDR
-        hex "PPA Firmware Addr"
-        default 0x40400000
-
 if FSL_PFE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
diff --git a/board/freescale/ls1012ardb/ls1012ardb.c b/board/freescale/ls1012ardb/ls1012ardb.c
index 62c935e4d3ec..18f92089caef 100644
--- a/board/freescale/ls1012ardb/ls1012ardb.c
+++ b/board/freescale/ls1012ardb/ls1012ardb.c
@@ -15,9 +15,6 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/fsl_serdes.h>
-#ifdef CONFIG_FSL_LS_PPA
-#include <asm/arch/ppa.h>
-#endif
 #include <asm/arch/mmu.h>
 #include <asm/arch/soc.h>
 #include <hwconfig.h>
@@ -173,9 +170,6 @@ int board_init(void)
 	erratum_a010315();
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
 	return 0;
 }
 
diff --git a/board/freescale/ls1028a/Kconfig b/board/freescale/ls1028a/Kconfig
index 7d73d20c8f0e..fb6ee17ce897 100644
--- a/board/freescale/ls1028a/Kconfig
+++ b/board/freescale/ls1028a/Kconfig
@@ -20,18 +20,6 @@ config TEXT_BASE
 	default 0x82000000 if TFABOOT
 	default 0x20100000
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x20400000 if SYS_LS_PPA_FW_IN_XIP && ARCH_LS1028A
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC && ARCH_LS1028A
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA header Addr"
-	default 0x20600000 if SYS_LS_PPA_FW_IN_XIP && ARCH_LS1028A
-endif
-endif
-
 endif
 
 if TARGET_LS1028ARDB
diff --git a/board/freescale/ls1028a/ls1028a.c b/board/freescale/ls1028a/ls1028a.c
index faecb6099240..7f181ab3dfb7 100644
--- a/board/freescale/ls1028a/ls1028a.c
+++ b/board/freescale/ls1028a/ls1028a.c
@@ -20,9 +20,6 @@
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <i2c.h>
 #include <asm/arch/soc.h>
-#ifdef CONFIG_FSL_LS_PPA
-#include <asm/arch/ppa.h>
-#endif
 #include <fsl_immap.h>
 #include <netdev.h>
 
@@ -74,10 +71,6 @@ u32 get_lpuart_clk(void)
 
 int board_init(void)
 {
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #ifndef CONFIG_SYS_EARLY_PCI_INIT
 	pci_init();
 #endif
diff --git a/board/freescale/ls1043aqds/Kconfig b/board/freescale/ls1043aqds/Kconfig
index 4be445e8c8f8..7e27f8f5b139 100644
--- a/board/freescale/ls1043aqds/Kconfig
+++ b/board/freescale/ls1043aqds/Kconfig
@@ -12,20 +12,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1043aqds"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x40400000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x60400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x40680000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x60680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls1043aqds/ls1043aqds.c b/board/freescale/ls1043aqds/ls1043aqds.c
index 841d8b59bb4c..b87da41e4083 100644
--- a/board/freescale/ls1043aqds/ls1043aqds.c
+++ b/board/freescale/ls1043aqds/ls1043aqds.c
@@ -15,7 +15,6 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/fsl_serdes.h>
-#include <asm/arch/ppa.h>
 #include <asm/arch/fdt.h>
 #include <asm/arch/mmu.h>
 #include <asm/arch/cpu.h>
@@ -533,10 +532,6 @@ int board_init(void)
 	config_serdes_mux();
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 	return 0;
 }
 
diff --git a/board/freescale/ls1043ardb/Kconfig b/board/freescale/ls1043ardb/Kconfig
index 56502f9f9c63..51818ec58016 100644
--- a/board/freescale/ls1043ardb/Kconfig
+++ b/board/freescale/ls1043ardb/Kconfig
@@ -13,18 +13,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1043ardb"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x60400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x60680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls1043ardb/ls1043ardb.c b/board/freescale/ls1043ardb/ls1043ardb.c
index 741a4d64ea9e..18869d8c1df5 100644
--- a/board/freescale/ls1043ardb/ls1043ardb.c
+++ b/board/freescale/ls1043ardb/ls1043ardb.c
@@ -25,7 +25,6 @@
 #ifdef CONFIG_U_QE
 #include <fsl_qe.h>
 #endif
-#include <asm/arch/ppa.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -211,10 +210,6 @@ int board_init(void)
 	out_le32(SMMU_NSCR0, val);
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #if !defined(CONFIG_SYS_EARLY_PCI_INIT) && defined(CONFIG_DM_ETH)
 	pci_init();
 #endif
diff --git a/board/freescale/ls1046aqds/Kconfig b/board/freescale/ls1046aqds/Kconfig
index adf325f4efd0..723f4ba90a07 100644
--- a/board/freescale/ls1046aqds/Kconfig
+++ b/board/freescale/ls1046aqds/Kconfig
@@ -12,20 +12,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1046aqds"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x40400000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x60400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x40680000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x60680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls1046aqds/ls1046aqds.c b/board/freescale/ls1046aqds/ls1046aqds.c
index 3d0881643cd9..2faac54a0e23 100644
--- a/board/freescale/ls1046aqds/ls1046aqds.c
+++ b/board/freescale/ls1046aqds/ls1046aqds.c
@@ -14,7 +14,6 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/fsl_serdes.h>
-#include <asm/arch/ppa.h>
 #include <asm/arch/fdt.h>
 #include <asm/arch/mmu.h>
 #include <asm/arch/cpu.h>
@@ -402,10 +401,6 @@ int board_init(void)
 	if (adjust_vdd(0))
 		printf("Warning: Adjusting core voltage failed.\n");
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #ifdef CONFIG_NXP_ESBC
 	/*
 	 * In case of Secure Boot, the IBR configures the SMMU
diff --git a/board/freescale/ls1046ardb/Kconfig b/board/freescale/ls1046ardb/Kconfig
index 1fb391c991c6..a62255c78dbb 100644
--- a/board/freescale/ls1046ardb/Kconfig
+++ b/board/freescale/ls1046ardb/Kconfig
@@ -13,18 +13,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1046ardb"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x40400000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x40680000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls1046ardb/ls1046ardb.c b/board/freescale/ls1046ardb/ls1046ardb.c
index 1d12d9189b78..26e69db55f74 100644
--- a/board/freescale/ls1046ardb/ls1046ardb.c
+++ b/board/freescale/ls1046ardb/ls1046ardb.c
@@ -14,7 +14,6 @@
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/fsl_serdes.h>
-#include <asm/arch/ppa.h>
 #include <asm/arch/soc.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <hwconfig.h>
@@ -96,10 +95,6 @@ int board_init(void)
 	out_le32(SMMU_NSCR0, val);
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #if !defined(CONFIG_SYS_EARLY_PCI_INIT) && defined(CONFIG_DM_ETH)
 	pci_init();
 #endif
diff --git a/board/freescale/ls1088a/Kconfig b/board/freescale/ls1088a/Kconfig
index f1a45236061b..1ada661743ed 100644
--- a/board/freescale/ls1088a/Kconfig
+++ b/board/freescale/ls1088a/Kconfig
@@ -12,20 +12,6 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1088aqds"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-        hex "PPA Firmware Addr"
-	default 0x20400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x20680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
 
 if TARGET_LS1088ARDB
@@ -42,18 +28,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls1088ardb"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-        hex "PPA Firmware Addr"
-	default 0x20400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x20680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls1088a/ls1088a.c b/board/freescale/ls1088a/ls1088a.c
index 238163da3aad..7674e31a268a 100644
--- a/board/freescale/ls1088a/ls1088a.c
+++ b/board/freescale/ls1088a/ls1088a.c
@@ -22,7 +22,6 @@
 #include <fsl-mc/fsl_mc.h>
 #include <env_internal.h>
 #include <asm/arch-fsl-layerscape/soc.h>
-#include <asm/arch/ppa.h>
 #include <hwconfig.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
@@ -820,10 +819,6 @@ int board_init(void)
 	out_le32(irq_ccsr + IRQCR_OFFSET / 4, AQR105_IRQ_MASK);
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #if !defined(CONFIG_SYS_EARLY_PCI_INIT)
 	pci_init();
 #endif
diff --git a/board/freescale/ls2080aqds/Kconfig b/board/freescale/ls2080aqds/Kconfig
index 1036f33c61fa..2f997e9de1ac 100644
--- a/board/freescale/ls2080aqds/Kconfig
+++ b/board/freescale/ls2080aqds/Kconfig
@@ -13,20 +13,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls2080aqds"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x20400000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x580400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x20680000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x580680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls2080aqds/ls2080aqds.c b/board/freescale/ls2080aqds/ls2080aqds.c
index 243c2caabfa5..5c94c83121b5 100644
--- a/board/freescale/ls2080aqds/ls2080aqds.c
+++ b/board/freescale/ls2080aqds/ls2080aqds.c
@@ -23,7 +23,6 @@
 #include <rtc.h>
 #include <asm/arch/soc.h>
 #include <hwconfig.h>
-#include <asm/arch/ppa.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include "../common/i2c_mux.h"
 
@@ -223,10 +222,6 @@ int board_init(void)
 #endif
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #if !defined(CONFIG_SYS_EARLY_PCI_INIT)
 	pci_init();
 #endif
diff --git a/board/freescale/ls2080ardb/Kconfig b/board/freescale/ls2080ardb/Kconfig
index c8b0b94596b5..671eead5f7f0 100644
--- a/board/freescale/ls2080ardb/Kconfig
+++ b/board/freescale/ls2080ardb/Kconfig
@@ -12,20 +12,4 @@ config SYS_SOC
 config SYS_CONFIG_NAME
 	default "ls2080ardb"
 
-if FSL_LS_PPA
-config SYS_LS_PPA_FW_ADDR
-	hex "PPA Firmware Addr"
-	default 0x20400000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x580400000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x400000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-
-if CHAIN_OF_TRUST
-config SYS_LS_PPA_ESBC_ADDR
-	hex "PPA Firmware HDR Addr"
-	default 0x20680000 if SYS_LS_PPA_FW_IN_XIP && QSPI_BOOT
-	default 0x580680000 if SYS_LS_PPA_FW_IN_XIP
-	default 0x680000 if SYS_LS_PPA_FW_IN_MMC || SYS_LS_PPA_FW_IN_NAND
-endif
-endif
-
 endif
diff --git a/board/freescale/ls2080ardb/ls2080ardb.c b/board/freescale/ls2080ardb/ls2080ardb.c
index f4ee309ae414..5c30de83d841 100644
--- a/board/freescale/ls2080ardb/ls2080ardb.c
+++ b/board/freescale/ls2080ardb/ls2080ardb.c
@@ -24,7 +24,6 @@
 #include <i2c.h>
 #include <asm/arch/mmu.h>
 #include <asm/arch/soc.h>
-#include <asm/arch/ppa.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include "../common/i2c_mux.h"
 
@@ -288,10 +287,6 @@ int board_init(void)
 	QIXIS_WRITE(rst_ctl, QIXIS_RST_CTL_RESET_EN);
 #endif
 
-#ifdef CONFIG_FSL_LS_PPA
-	ppa_init();
-#endif
-
 #ifdef CONFIG_FSL_MC_ENET
 	/* invert AQR405 IRQ pins polarity */
 	out_le32(irq_ccsr + IRQCR_OFFSET / 4, AQR405_IRQ_MASK);
diff --git a/board/traverse/ten64/ten64.c b/board/traverse/ten64/ten64.c
index df9f0afe1a4f..6ff5312d6d79 100644
--- a/board/traverse/ten64/ten64.c
+++ b/board/traverse/ten64/ten64.c
@@ -26,7 +26,6 @@
 #include <fsl-mc/fsl_mc.h>
 #include <env_internal.h>
 #include <asm/arch-fsl-layerscape/soc.h>
-#include <asm/arch/ppa.h>
 #include <hwconfig.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
diff --git a/env/Kconfig b/env/Kconfig
index 13e32104b4c1..b8bbe246c541 100644
--- a/env/Kconfig
+++ b/env/Kconfig
@@ -645,7 +645,7 @@ config SYS_RELOC_GD_ENV_ADDR
 
 config SYS_MMC_ENV_DEV
 	int "mmc device number"
-	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || SYS_LS_PPA_FW_IN_MMC || \
+	depends on ENV_IS_IN_MMC || ENV_IS_IN_FAT || \
 		CMD_MVEBU_BUBT || FMAN_ENET || QE || PHY_CORTINA
 	default 0
 	help
diff --git a/include/configs/ls1046a_common.h b/include/configs/ls1046a_common.h
index 38fb1d45bcb3..867b098a0732 100644
--- a/include/configs/ls1046a_common.h
+++ b/include/configs/ls1046a_common.h
@@ -21,8 +21,7 @@
 	(defined(CONFIG_NAND_BOOT) || defined(CONFIG_QSPI_BOOT))
 #define SPL_NO_MMC
 #endif
-#if defined(CONFIG_SPL_BUILD)		&& \
-	!defined(CONFIG_SPL_FSL_LS_PPA)
+#if defined(CONFIG_SPL_BUILD)
 #define SPL_NO_IFC
 #endif
 
-- 
2.17.1

