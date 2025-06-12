Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7FCC61CE8
	for <u-boot@archiver.kernel.org>; Thu, 12 Jun 2025 08:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F61182A4B;
	Thu, 12 Jun 2025 10:08:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="qENIDWch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8486A82B70; Thu, 12 Jun 2025 10:08:19 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2CD1828A2
 for <u-boot@lists.denx.de>; Thu, 12 Jun 2025 10:08:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iMnraZLoPKstvg/INSAOFHqGmm11l0QJpc0i8BNtqCa6yCEz+vT9tJGOQP0QK3wRKG05w8PT3hcVdofoVPvqpz+6v/PnkpRtZHhSrdARzxh3IY/xYIEFc0kSdZ4fn0gKTMhuDXP16nAfpayucjYHxsY0miOGgp+c7F68PYshkvwqTl/Nvm3nXyrmyhyQMec6lJs4vRfwerYy4rvTmw9nKH24Nc8phrA8Dlzdcd7kiCaDLHTgWnExzTkLWacirPLDzWrpZjbNffJyUofrqIl3DPeVzPinJVE6q7sSjgKbw0D5RkuOEdf7IBcfrYZC6Rv1hU9xd/GE79CAdl3RgxEdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUE7xmjx7PtPUHjI+/DiSPifUtTyZapiMXqQodEBZ40=;
 b=pGIaD7WGYxWCNUIlpgvdku34GqBmxPSMyS2qX6VAZGc9+hDNxVY4Ee05HTtMX44iE8Ft6g8AYSB27sSILIf1QZWRqiolvUMON6Sako8mpLbffcmtWgIFIV9EU8RwJoIuocoOBtlYcxiECdinjqteAKDFZneHBi6MozYXMERFO6/1vX9TZGmEohrpMbOWTeUdW9vS3uYqU7Eu/QnQMrkwdX3zPR4mEgsrrb9hblVDd8IfZCzqUoP0Y5XVuBfmofWKrvW87Zbwr8UMaT/K69W48mibAccWPDZOBaoFKPKLpb821IQyhlonwlAJmOcvwVy5dnlKKWetVkl6jaAxfUC0Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUE7xmjx7PtPUHjI+/DiSPifUtTyZapiMXqQodEBZ40=;
 b=qENIDWchxpyddG6ojci6eqEcf81jLIdcLbK8xM/hD8ocEitg9PKJk7fNExoSZC/BMEnFDbsft31aNeWy0mH1uB16/8svdZCdPuYe8KQs1LIfzAAmt/zw0p+mlQSXyGXLGE4zR3+KJuf9OeJOvnE/PdrvOOSMdA/aAYUGJzmvaEW8y2SXlTf/R+RtfE+jpY6VnIc1AHCIDp/hVaR/y5gzr8cNwpSDodWZp6pBwWrvzRywytx7ngfmaL9hbLzGYZXj5WoPedds6/f/nBaA9ptiwtnvaWX+Bfj3AH/ueJvt51vHHfPXBCk+kEh83j8BPE5yt45iIcWepq7r5JxtuZmz6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA2PR03MB5802.namprd03.prod.outlook.com (2603:10b6:806:f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.19; Thu, 12 Jun
 2025 08:08:13 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:08:13 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] arch: arm: agilex5: Enable power manager for Agilex5
Date: Thu, 12 Jun 2025 01:08:00 -0700
Message-Id: <20250612080800.19712-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::11) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA2PR03MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: baab7a60-777d-4f22-ad30-08dda9884631
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mk3jBDf6uzaomrNB1z3bnW2YzAZRc7OLFhXiRsiLSFSIdmwUfeHnfZru7aMT?=
 =?us-ascii?Q?+1lVpNwJJmcZXIqxRTWOliAQ0YVQ0/EUAfc9FPa7FztciEeFM/nJHunfExeT?=
 =?us-ascii?Q?jjRUQq4nlRSHvx/IMkLRTLUPHjuTi/ftmKjy3kyqMBWFQq4yXQqaZ2aQ5jWa?=
 =?us-ascii?Q?MpV70QUG6PKq8vy/qfLifNItWZFrPOtXoi8pHs8vhXFBoD6MuifkJgxTcTtM?=
 =?us-ascii?Q?C8wf/Ory//0vPd8sfJM60CbyHlDfsCDPQpvGoV9Q9UnBCJ4rZczsaj78KprA?=
 =?us-ascii?Q?SsRXzUx4IX+FRpT5LbFfjk3oVDrxQbMojSe4IagWVPrfZ8XF7bxPgC8l1/Xp?=
 =?us-ascii?Q?Ype2+X4l9rZTQ7XSRfYs6ppQDKcugUhVIN2jRfsuTP2NSeXEzzJQg6LVnghb?=
 =?us-ascii?Q?Cb6U/kd3i9OiqA+z/U+JbGvsJLr2CcX1IaBZXwGR5QWYV/iB3bOP/+If5e0g?=
 =?us-ascii?Q?hvNeTkedRVoKnVS+aHqKAK5SyhLBt06+7r37u+SXq1BkgVMGkXgfvciNc1KU?=
 =?us-ascii?Q?cIyEkE1lrFtxZS7iB4JxC2kxW0qJOB7SD2pOMHYh+Zt/MCMsYV6I1OSQZL4c?=
 =?us-ascii?Q?rv3zwfP1Iy8wHHXXu/HXiIBjnwqnMVHSlRamj7sgq8WAiGzqUeS0oWzWeb24?=
 =?us-ascii?Q?QpZiTYVDNb+4+Foeh4Fh8zquVvrXI8xiJffvYHYB90XUHaNN+S0TNN5EWc1H?=
 =?us-ascii?Q?KjqOuHwH5RPqLoyHO+Y6x2s5siyylM229P+dXwbddzn4DfSNm92XcpO/pyFa?=
 =?us-ascii?Q?gQR74Tvk2nfx4C65car0odg0FjRUeVYN1RubMUnate9l50MdjherFElmcx2G?=
 =?us-ascii?Q?vmbp73zQCW64K3jcQgIKCnCDhna887cNV286DfWbhuwpwGiHuztcNxB6dltg?=
 =?us-ascii?Q?BmxCOq3bYBRYGeIwuJyZc8xf0YkkTYK8M94asTnvLGS4HQVx7d3xApyXCWJ+?=
 =?us-ascii?Q?/Ktf6yl58WPVL/7pygKSqndEBdv2yRukIkp10LYB64Bi5XywSCoEruPGSHjS?=
 =?us-ascii?Q?Sb4lBWpBuHK/4mlhX18tgMAwJKSIdGw3qMo9QJrE26PRQPwqUZfAc8N5MlWZ?=
 =?us-ascii?Q?PCcBHIW3JB/A199RmOe/HiFHxtrLrn68arm+ODfq/CdpwYspN1IMF2KOnDxX?=
 =?us-ascii?Q?28eSKlSNRD3L1SajGWmzGg/shenaV+9zrt+16wHsO/QGGg9H2HsXQn4dv8r/?=
 =?us-ascii?Q?YYfDIBQk+cEPn0GTJxNIjC4RmzzoUKB6IPzcRusO4JjUA+yBL3VbcmldlVF9?=
 =?us-ascii?Q?ar0lZgZ5KR2GsR6tf5rkzIoa7Lnl+un4VCqxTgPcFxUnMYkAp+GLrIAtgMco?=
 =?us-ascii?Q?lUx2YSoXPh7XUr3QdZTZIqdIM8X64m9X8K+IlpCWEF8djRXo9EEVE/6JATPi?=
 =?us-ascii?Q?Itoc24U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o9GYdnlGvSQvNaREDIYAJCknJ4nSSC3f84q4O4mcjYIey6MAtiw1dHSW/upL?=
 =?us-ascii?Q?vW9ohRVsXmD59xEhFx8NsxJDk/ptuHE6waR9j7ZylAEZFgwyU3mHmtKJPw5Z?=
 =?us-ascii?Q?4m/+87K7vuUHalYbHZolZPkCrEfqjHKkTezchGe42sZs9xbEfBOYPlfBaB1v?=
 =?us-ascii?Q?wMA28fPGoSJSkXHcw7wxi+gqL6Gj9bz9CyguSdGzhLTpBMgjqaoX4OaUwns3?=
 =?us-ascii?Q?zqDnXk7uuZNk7RQruDYadn4PmCobkVsDDy3ZBCUCAbmOT1Klh5o0ElC/dx8g?=
 =?us-ascii?Q?BnrVOhV11NLtThWPO4lfvDPTi4E6mQpwtOlDbzW91eR3fD3CdI7O36rgqUg/?=
 =?us-ascii?Q?H3sqUD2Ul71XZ2EBGXqKq1VE1PweXRzKNg2DBhrvuausuLDvly8W6PjbjfUw?=
 =?us-ascii?Q?nSKEmKWZDSO0FgHi/u9KA1R/csPZvzAcW2mg22hlpVIUwqTNkNALN7Y/HZa6?=
 =?us-ascii?Q?edjA1zTtsOCHwcgitEa4kBwu0gVzBbtdiARAxkGP0IaEuBAo+q/QCZmAZKE4?=
 =?us-ascii?Q?2eJTOLg5E87dYlGq5ZyoRVVUeh/pUmWJi3u4uBfxxM7eQO7hU2B3deDjWxpY?=
 =?us-ascii?Q?fNUrxgh9+qu6ArsoyQB5zJP1YXdBs79FYmD0zsGwDKGKRfZw3dlwDcmnH3lM?=
 =?us-ascii?Q?0X9sH+CnBlhZLbA2wXMwJ5unlfXd4c9x/vHKxhTDuIcsZ6SyfzK9zZmV/MvP?=
 =?us-ascii?Q?0fz1paFWG1EVkxU7QO/6QEPiKqFE+yvHhmQJUxaSe/nrfcGah44E4Jy37iyg?=
 =?us-ascii?Q?OBMuaw5+UpbcO1dUiYjQbpnjNCA1VqQAR2i+yZ/Ypz0FDCdcvO2tzwWOxrIs?=
 =?us-ascii?Q?uGWcEY4JZgP34EB8KbtVyOeEpCcjcBjGKJogQbi+uqQn1hSv86VzRqVbd/HE?=
 =?us-ascii?Q?aCsBQ+E5t+d26vs3zF4CQ310Qg7+5YX06zF5rxipoE6NGIAXSV8Tj9wqbxPy?=
 =?us-ascii?Q?IRoNWu8kSq7dC3vmBuLx2IK2PJhwA6ErRaWM3D/LXfNfQqCLxb8/qJwLumKW?=
 =?us-ascii?Q?Swz5JIf6/FcVFG2IJD9bmu8AQ6m5wSFpzrqPLA23RWnu30w/QuSsygWPgWuG?=
 =?us-ascii?Q?FdmrbaJoAIiBqMFxerOoVgeIHdAtbbpgFOaW8M9auT9yim0nf4J9oqsB8BsK?=
 =?us-ascii?Q?+aQJd8uizAVt9KHhtoP1tyX/chACp9U98RWsPTZmqWOLRSCtMcSOov9CVn+g?=
 =?us-ascii?Q?ojWHHYoQY4Eo+O3XwqaMNp+3azNkls+Igi2yxnucHJkN9uTOlXSwOxn+ydJB?=
 =?us-ascii?Q?U+UTZ4xZ7cREzTNtH21NKAl8u94CA7bzwJoLBB0uW7iDAbW7RsIAY16vU1xR?=
 =?us-ascii?Q?i+UfhM9hvZaZlYTS84n4WrO0OY7ssDtWOJk9bwfPUP4/MdF538fVKcku7P7K?=
 =?us-ascii?Q?46vRxDtyysaA6XXewdAvkgE0sgzkm9HnDSly5dK6H6TJh+b8nsnI2/4QLgc+?=
 =?us-ascii?Q?9J0kDdEhB5zn3V2AxkWDYrsTMPUMgnw3g1YPeVBDPJPnLt3kcqtL2l7uW+5P?=
 =?us-ascii?Q?w+ZN4ueHuOxpvSP/oXBkLAhu8ytnqttu2PgSaV0Bmqr/lUUBRfrq+UREwCG9?=
 =?us-ascii?Q?xLsxLq5dzs1GN8IFJ3m+RjP6X3/APBm8QLEfGN8i8N1HHV1B2XBjkRcPTbBE?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baab7a60-777d-4f22-ad30-08dda9884631
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 08:08:11.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cjo7EWLrLuHqKyrep9Zh094T6Csps7tUyhKi68o6FOyeTv43hhvnVAIFil0RIA6sHxE853fRh1oSkimcMeCsmyXGRoHRJDFHONAlfTLwSAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5802
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Agilex5 FSBL is required to disable the power of unused peripheral SRAM
blocks to reduce power consumption.

Introducing a new power manager driver for Agilex5 which will be called
as part of Agilex5 SPL initialization process.

This driver will read the peripheral handoff data obtained from the
bitstream and will power off the specified peripheral's SRAM from the
handoff data values.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 MAINTAINERS                                   |   1 +
 arch/arm/dts/socfpga_agilex5-u-boot.dtsi      |   6 +
 .../mach-socfpga/include/mach/handoff_soc64.h |   1 +
 arch/arm/mach-socfpga/spl_agilex5.c           |   6 +
 configs/socfpga_agilex5_defconfig             |   2 +
 .../power/altr,pmgr-agilex5.yaml              |  39 ++++++
 drivers/power/domain/Kconfig                  |   8 ++
 drivers/power/domain/Makefile                 |   1 +
 drivers/power/domain/altr-pmgr-agilex5.c      | 112 ++++++++++++++++++
 9 files changed, 176 insertions(+)
 create mode 100644 doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
 create mode 100644 drivers/power/domain/altr-pmgr-agilex5.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d62dd35a385..100a1c7b3cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -156,6 +156,7 @@ M:	Tingting Meng <tingting.meng@altera.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-socfpga.git
 F:	drivers/ddr/altera/
+F:	drivers/power/domain/altr-pmgr-agilex5.c
 F:	arch/arm/mach-socfpga/
 F:	configs/socfpga_agilex5_vab_defconfig
 F:	drivers/sysreset/sysreset_socfpga*
diff --git a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
index 874e71b5ca4..402f0bec173 100644
--- a/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5-u-boot.dtsi
@@ -668,6 +668,12 @@
 				bootph-all;
 			};
 		};
+
+		pwrmgr: pwrmgr@10d14000 {
+			compatible = "altr,pmgr-agilex5";
+			reg = <0x10d14000 0x100>;
+			bootph-all;
+		};
 	};
 };
 
diff --git a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
index 763b077d8c1..04203cceb8a 100644
--- a/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/handoff_soc64.h
@@ -68,6 +68,7 @@
 #define SOC64_HANDOFF_CLOCK		(SOC64_HANDOFF_BASE + 0x580)
 #if IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX5)
 #define SOC64_HANDOFF_PERI		(SOC64_HANDOFF_BASE + 0x620)
+#define SOC64_HANDOFF_PERI_LEN		1
 #define SOC64_HANDOFF_SDRAM		(SOC64_HANDOFF_BASE + 0x634)
 #define SOC64_HANDOFF_SDRAM_LEN		5
 #endif
diff --git a/arch/arm/mach-socfpga/spl_agilex5.c b/arch/arm/mach-socfpga/spl_agilex5.c
index a9aad5350d2..2a13301802d 100644
--- a/arch/arm/mach-socfpga/spl_agilex5.c
+++ b/arch/arm/mach-socfpga/spl_agilex5.c
@@ -96,6 +96,12 @@ void board_init_f(ulong dummy)
 		hang();
 	}
 
+	ret = uclass_get_device(UCLASS_POWER_DOMAIN, 0, &dev);
+	if (ret) {
+		debug("PSS SRAM power-off failed: %d\n", ret);
+		hang();
+	}
+
 	if (IS_ENABLED(CONFIG_SPL_ALTERA_SDRAM)) {
 		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
 		if (ret) {
diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 4ac0a5d9b99..5e8f2b85fc1 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -103,3 +103,5 @@ CONFIG_DESIGNWARE_WATCHDOG=y
 CONFIG_WDT=y
 # CONFIG_SPL_USE_TINY_PRINTF is not set
 CONFIG_PANIC_HANG=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_AGILEX5_PMGR_POWER_DOMAIN=y
diff --git a/doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml b/doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
new file mode 100644
index 00000000000..af7aeaa922c
--- /dev/null
+++ b/doc/device-tree-bindings/power/altr,pmgr-agilex5.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/power/altr,pmgr-agilex5.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Altera Agilex5 Power Manager
+
+maintainers:
+  - name: Alif Zakuan Yuslaimi
+    email: alif.zakuan.yuslaimi@altera.com
+
+description: |
+  This controller will read the peripheral handoff data obtained from the
+  bitstream and will power gate the specified peripheral's SRAM from the
+  handoff data values to reduce power consumption.
+
+properties:
+  compatible:
+    const: "altr,pmgr-agilex5"
+
+  reg:
+    maxItems: 1
+
+  bootph-all: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pwrmgr: pwrmgr@10d14000 {
+      compatible = "altr,pmgr-agilex5";
+      reg = <0x10d14000 0x100>;
+      bootph-all;
+    };
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 5f5218bd8b5..ebf5d828cb0 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -18,6 +18,14 @@ config APPLE_PMGR_POWER_DOMAIN
 	  This driver is needed to power on parts of the SoC that have
 	  not been powered on by previous boot stages.
 
+config AGILEX5_PMGR_POWER_DOMAIN
+	bool "Enable the Agilex5 PMGR power domain driver"
+	depends on SPL_POWER_DOMAIN
+	help
+	  Enable support for power gating peripherals' SRAM specified in
+	  the handoff data values obtained from the bitstream to reduce
+	  power consumption.
+
 config BCM6328_POWER_DOMAIN
 	bool "Enable the BCM6328 power domain driver"
 	depends on POWER_DOMAIN && ARCH_BMIPS
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 4d20c97d26c..8e03f620437 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += power-domain-uclass.o
 obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
+obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) += altr-pmgr-agilex5.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
 obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
diff --git a/drivers/power/domain/altr-pmgr-agilex5.c b/drivers/power/domain/altr-pmgr-agilex5.c
new file mode 100644
index 00000000000..257e8b234fd
--- /dev/null
+++ b/drivers/power/domain/altr-pmgr-agilex5.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ */
+
+#include <dm.h>
+#include <power-domain-uclass.h>
+#include <asm/io.h>
+#include <asm/arch/handoff_soc64.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <time.h>
+
+#define PSS_FWENCTL					0x44
+#define PSS_PGENCTL					0x48
+#define PSS_PGSTAT					0x4c
+
+#define DATA_MASK					GENMASK(7, 0)
+#define TIMEOUT_MS					1000
+
+static int wait_verify_fsm(u16 timeout_ms, uintptr_t base_addr, u32 peripheral_handoff)
+{
+	u32 data = 0;
+	u32 pgstat = 0;
+	ulong start = get_timer(0);
+
+	/* Wait FSM ready */
+	do {
+		data = FIELD_GET(DATA_MASK, readl(base_addr + PSS_PGSTAT));
+		if (data != 0)
+			break;
+	} while (get_timer(start) < timeout_ms);
+
+	if (get_timer(start) >= timeout_ms)
+		return -ETIMEDOUT;
+
+	/* Verify PSS SRAM power gated */
+	pgstat = FIELD_GET(DATA_MASK, readl(base_addr + PSS_PGSTAT));
+	if (pgstat != FIELD_GET(DATA_MASK, peripheral_handoff))
+		return -EPERM;
+
+	return 0;
+}
+
+static int pss_sram_power_off(uintptr_t base_addr, u32 *handoff_table)
+{
+	u32 peripheral_handoff;
+
+	/* Get PSS SRAM handoff data */
+	peripheral_handoff = handoff_table[0];
+
+	/* Enable firewall for PSS SRAM */
+	setbits_le32(base_addr + PSS_FWENCTL, peripheral_handoff);
+
+	/* Wait */
+	udelay(1);
+
+	/* Power gating PSS SRAM */
+	setbits_le32(base_addr + PSS_PGENCTL, peripheral_handoff);
+
+	return wait_verify_fsm(TIMEOUT_MS, base_addr, peripheral_handoff);
+}
+
+static int altera_pmgr_off(struct power_domain *power_domain)
+{
+	fdt_addr_t base_addr = dev_read_addr(power_domain->dev);
+	u32 handoff_table[SOC64_HANDOFF_PERI_LEN];
+	int ret;
+
+	/* Read handoff data for peripherals configuration */
+	ret = socfpga_handoff_read((void *)SOC64_HANDOFF_PERI, handoff_table,
+				   SOC64_HANDOFF_PERI_LEN);
+	if (ret) {
+		debug("%s: handoff data read failed. ret: %d\n", __func__, ret);
+		return ret;
+	}
+
+	pss_sram_power_off(base_addr, handoff_table);
+
+	return 0;
+}
+
+static int altera_pmgr_probe(struct udevice *dev)
+{
+	struct power_domain *power_domain = dev_get_priv(dev);
+
+	if (!power_domain)
+		return -EINVAL;
+
+	power_domain->dev = dev;
+
+	return altera_pmgr_off(power_domain);
+}
+
+static const struct udevice_id altera_pmgr_ids[] = {
+	{ .compatible = "altr,pmgr-agilex5" },
+	{ /* sentinel */ }
+};
+
+static struct power_domain_ops altera_pmgr_ops = {
+	.off = altera_pmgr_off,
+};
+
+U_BOOT_DRIVER(altr_pmgr) = {
+	.name = "altr_pmgr",
+	.id = UCLASS_POWER_DOMAIN,
+	.of_match = altera_pmgr_ids,
+	.ops = &altera_pmgr_ops,
+	.probe = altera_pmgr_probe,
+	.priv_auto = sizeof(struct power_domain),
+};
-- 
2.25.1

