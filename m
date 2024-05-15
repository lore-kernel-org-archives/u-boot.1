Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A282BC25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 04:06:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86889881C8;
	Wed, 15 May 2024 06:05:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=wiwynn.com header.i=@wiwynn.com header.b="cCBiv6Y3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56C4C880B5; Wed, 15 May 2024 06:05:51 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F93881C8
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 06:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=wiwynn.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Delphine_CC_Chiu@wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvblGECAqX126tgQvL17iOb5grl0ZgOv+ifnXEcZ6gulkmiRU/I2Ol6yfhoXA7Tv0DG0gaRVXiNspVgkRYHNYBb/9RSa5OeyRKmmRAzP5rpj8N4kS/Mf8v3It5RCDlJryyxF6wShUS53fg0cB1S3MiA+GTG6Vju7YFAYG2kYlylGjU23Hb31hcD1I9S/bmkomi5SL3QlVxwhIDCvBoFFpSyH7yri/vvbZMKfiW78JUPSJQPk+GeFwRcJTyswJLmVidRNuSWA7wYtWI4nJJJtyWZ29oyvVm6yuAdCbgxIBwwXcHC3udbOEnMR1hPZYfW2xa7neDRPMgkuEecFL38e9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2arkXLtge3fsF5W64Hes99byxWubcJD/rU/CrWlJ3hs=;
 b=IRtgeG3gdha1YhqUbw2g7sPhmDgcddPLVxiKEHpDoq7cZMTIaQGdOTIbbyT1iajbbf5kAk7Sp23eZSZfHc1Rk7O6G0Z92Stnq3p8BycBQ8mOl5WVOzwTIs8bZtW9aB6EVRzP6FMgGo5/VMutrIkPQlN8A/qFe5mTxUrA6Sl3QwS7CGf1wTwonmkLbaFLcZJytbWUrG9pNdMvhFF9WZjX3gvj5df+7aCqZp2K3mRsr5b8OJF9Ve+3vdsk1JK3EBKoSfq0bDqP2BU881/Bg4Bt7A59aJkNPIfLN+i0sYI649O3CtiKz2trV5n1nf06IEi26B999XFkcFda+TnRw7QtnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2arkXLtge3fsF5W64Hes99byxWubcJD/rU/CrWlJ3hs=;
 b=cCBiv6Y3kCEsMpOQdon5OPw3dWC2ewNXf4jkTVW8RrBimVfw1mdGPXOl5T2AoBnSkc3AsHc7pvhrA606IcVBTJ4ECZzNXTwBTzCZTkipzK4RzLOq/+MBLMjQOX6XVEni3xCrLY3s/TocuqA666R3l2P5SMfLP8stgZioyLzjhhmsyJFX76E4mJICHga3/NlQ1kAQ8YbP1Wkmrh0JuC8p4vDspJ0gWYLKHOXtbxJMKNRfa8Me3VCu1J8tSEXLyQHDDCFatCis9mIcTfEPMDiZ5M7+MbMCgjTLR+iiN8BLqKzd0kDcHOkDnWuG2awGw2e1sNcZNhsdXpF0GX7xwlaVHQ==
Received: from SG2PR02CA0117.apcprd02.prod.outlook.com (2603:1096:4:92::33) by
 OS8PR04MB8163.apcprd04.prod.outlook.com (2603:1096:604:28c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 04:05:43 +0000
Received: from HK3PEPF0000021B.apcprd03.prod.outlook.com
 (2603:1096:4:92:cafe::3d) by SG2PR02CA0117.outlook.office365.com
 (2603:1096:4:92::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Wed, 15 May 2024 04:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 HK3PEPF0000021B.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server id 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 04:05:43
 +0000
From: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 u-boot@lists.denx.de
Subject: [PATCH v1 2/2] configs: openbmc: Revise size of environment and use
 preboot
Date: Wed, 15 May 2024 12:05:25 +0800
Message-Id: <20240515040526.178161-3-delphine_cc_chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240515040526.178161-1-delphine_cc_chiu@wiwynn.com>
References: <20240515040526.178161-1-delphine_cc_chiu@wiwynn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021B:EE_|OS8PR04MB8163:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aba93515-cdc2-4554-39cb-08dc74944a7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P1jn0/fPGq5L53l/a2olHIwuCavGmnUQ1exUkU3YGy8j9l+PDuAX6bhZmryr?=
 =?us-ascii?Q?C61YrI5SU0/uvjaVJlK4HOsHk17BNX6ieHL/rxt52itcGkJ3lANaCkjBgRHy?=
 =?us-ascii?Q?bXoCjdicQTlYDSTlr+1s14Ow6ubs5KtwmLLrr0suvVSjRR7/gvuQQHvTa5Ot?=
 =?us-ascii?Q?0Jx2QBoQqXgXVeR0DUFGk9ejfO2XttL0bLa1UK7HY6oE58qIZ9r5kJ5+3Zzx?=
 =?us-ascii?Q?KzkCW5q2BKL2OIWf/XmVWkI3SF1EPpLbpckdPMr3yc8qPBTyayEEOlcltSSw?=
 =?us-ascii?Q?+pa8ffvQBDzFRldq8iOPRC1ls0eyss36wMoL3CrrMwU7mDqQ+7fRhbmyBSc+?=
 =?us-ascii?Q?vjY5oXBJACQylgJeL+X3GSiskya367WzqbyaeshqQvUn6ODFSIZKDpuynzbP?=
 =?us-ascii?Q?12+T9KjLlfd/aEW0yRTFgolacVLSZq7NkhHa5SxOAWcSF1e/lShipqcmWiZB?=
 =?us-ascii?Q?07+9l72ZFh0EGwoA2m6ceLIwqizxtTwc1BOkiZqv6s3J8bdI8OonNLKq5Lz3?=
 =?us-ascii?Q?4/QPBlI/9NnYocW7wKw7LWp10J6qudACPxoxbPgKQ5YrlZfffjnyTg2pFAds?=
 =?us-ascii?Q?jesggvM5uLYG5Zo8CwpqfoNyL/TA3Mh720K/rSVHIQDD/4X/wAqJqwCbieiz?=
 =?us-ascii?Q?PWVySYoJsSHhwyJqMHUe59F7Utr5/CGBtV37sFlhsGq1HgJEy4u0CyD2Ah5n?=
 =?us-ascii?Q?BB2NoqAqfcragP5dT30NRD0hM7klVRKmjXH/eSVnIEZcf+3rA84AK11Vn2G5?=
 =?us-ascii?Q?q/oLhzLRGuc+l9i2FFvlkv7BNpaiJHUoJGhD3XcWmRTfzfh3Fps/jlcMBt+O?=
 =?us-ascii?Q?V0j33PVJx8N//shzhLGXMncfAeTcx79gVkGfObWAi8w1l1lygVSzQzABJNwf?=
 =?us-ascii?Q?JvXBMTXDOGstdr9BjEy8achHe+jYMPOHNE/4PEcnYKXyXJIO4HWJHmBUVeto?=
 =?us-ascii?Q?kGNVwVdXXEbHIsjez8YbnxPVgg4N88r8EM/Cyc1tHSAbFlSdihthG4h9+7bH?=
 =?us-ascii?Q?EtL8tmGW/V7EecPnDqwtXeNo3ReNsREvGd/Av7yeRCpwpGVuiZZ9yb/GmpXT?=
 =?us-ascii?Q?N7Mq+NjkMr1qi9fxzMhfgpFKse7Ov1O4uXPx29iZjKqcfORZlFxsnh5PjNYG?=
 =?us-ascii?Q?yxVD8tBZ26lnKam/agIa+5bvAnMQm536yjWK9f+EMmpoeaDpCOtm3iVQ+ojZ?=
 =?us-ascii?Q?hoVsz3dswCps6534zVv4VB+n9fQyuKzc/jP2wM751+YahpQl7ZJFnE21rrG7?=
 =?us-ascii?Q?NrjL/ORux+/vUivDcYa32mfcb7ejt/3UOChqT58wUoL/8AxDNwQtUtXUEWyP?=
 =?us-ascii?Q?AZJNHpbF9UddZKvYOjlor01OsofP0f/oVwkcLvmkKyfXnDdv48eMJD7ugiYq?=
 =?us-ascii?Q?Yw1ayEs3W1ViGn2xwMPHqUED6jpL?=
X-Forefront-Antispam-Report: CIP:211.20.1.79; CTRY:TW; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:211-20-1-79.hinet-ip.hinet.net;
 CAT:NONE; SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 04:05:43.2220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aba93515-cdc2-4554-39cb-08dc74944a7d
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167; Ip=[211.20.1.79];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF0000021B.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR04MB8163
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

Revise CONFIG_ENV_SIZE and Add CONFIG_USE_PREBOOT

Signed-off-by: DelphineCCChiu <delphine_cc_chiu@wiwynn.com>
---
 configs/ast2600_openbmc_spl_defconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/configs/ast2600_openbmc_spl_defconfig b/configs/ast2600_openbmc_spl_defconfig
index efd683570f..f930108e1c 100644
--- a/configs/ast2600_openbmc_spl_defconfig
+++ b/configs/ast2600_openbmc_spl_defconfig
@@ -14,7 +14,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_SPL_MMC_SUPPORT=y
 CONFIG_SPL_SERIAL_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC_SUPPORT=y
-CONFIG_ENV_SIZE=0x10000
+CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xE0000
 CONFIG_SPL=y
 CONFIG_SPL_STACK_R_ADDR=0x90300000
@@ -58,7 +58,6 @@ CONFIG_CMD_BOOTZ=y
 # CONFIG_CMD_IMI is not set
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_MEMTEST=y
-CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
@@ -140,3 +139,5 @@ CONFIG_SPL_TINY_MEMSET=y
 CONFIG_TPM=y
 CONFIG_SPL_TPM=y
 # CONFIG_EFI_LOADER is not set
+CONFIG_USE_PREBOOT=y
+CONFIG_PREBOOT=""
-- 
2.25.1

