Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FE7C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 10:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA9CC84B9B;
	Wed,  1 Jul 2026 12:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DAYP5qvi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC8684BA0; Wed,  1 Jul 2026 12:29:04 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3BC384B86
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 12:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.VinayTilak@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVH87x4W9hj9kqQ0Pt9Qc+ulrssL3zLOqyvuT6Je4cVm7sdg6Xva9Wmg4ErQopBEOQEabx5qFiohNKwu0+aF6AKAfBsiNKW7JBfV12rPeCpr9Rbr0C3RWkhiRHNEvAMYexzZto5GSROp20ep3RTs3dnS/YtxYoktrZrSsDVtFLNMOUNKNwUjo7VqjhUCFKrg7/sZc/C+FnbyApankvSWV7JCzgK7lxtvQf3JtJkl05nz/70VWqbTZzywRm8Ze4XqdWtyAGv85vlGTx90JGCATVGCBggz76BZKmXm7BTMI9GGqVHRNTH/XoRdlm6wJoT1ph3vhGsS29V6yA4iD3KCPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgkSWmNBI0k+Z72hsJuY8e+5x5oeExwu9QlLYnPt8x4=;
 b=fkjb2w/ohOqcz5VAyZYXz11Nd77nn2pX1pNN87XWhYrp9+gD2MvlvfGfIEuLTzaPFb1G+BgvgUOeosEnhMy3QuCvdwZ5jgaElgdz/77xPjm4W9V7NsZKEAHnXrZWjBEzww8RgTjv3peva/FuTXSeyzTIoySC4Plu5z6n95F/0P06EqQ2sUiIrQjOSYRPlYzM6BsZi/yCs45Qpxe7/IA2KyIdt1vyFb23BcKE82m5aqDGclNBE55GGf4wbyH5f0psCmfBIta3CwJleZDsA4QDdZsFpnIW4RNQGnoAiEUKkB/pIF7suHljeOHt3mrbRmdYOi7okcLYXLRSklU07Y1GNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgkSWmNBI0k+Z72hsJuY8e+5x5oeExwu9QlLYnPt8x4=;
 b=DAYP5qviiqVCN/u9XC+7iYNOeRdPMqWeNcCd0yyUzAi4tiNDIZULWqvD/wDFecleDWUQE44+B2+6p3WoYqFRFAgb2XDBt/Ye2WjTKJHVRdRbv/bLEbJ/2ze5kUIg9/noo6r2m4JCWFRDqOQe1WpRGH3u8FVCEWzRRszz5VGqRjw=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by DM4PR12MB5986.namprd12.prod.outlook.com (2603:10b6:8:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 10:28:58 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:59d:cafe::69) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 10:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 10:28:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 05:28:56 -0500
Received: from xhdpvinayti50x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Wed, 1 Jul 2026 05:28:54 -0500
From: Pranav Tilak <pranav.vinaytilak@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Pranav Tilak
 <pranav.vinaytilak@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] configs: versal2: enable I3C support
Date: Wed, 1 Jul 2026 15:57:19 +0530
Message-ID: <20260701102754.345049-4-pranav.vinaytilak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
References: <20260701102754.345049-1-pranav.vinaytilak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DM4PR12MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb50622-8eff-4c1a-6391-08ded75b8f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VwnJY2r91zWyw5Sl3P/cCNEDOiS5n8Q5PD5oofK/bvqscL3z/BvnbcRCjDZy2N46Sv4kkv8YS7kPKFnRkEPN7ph4LpMTt+ELDZvFuM6W1BJuCuIcLjUSWRRMUB2EE6ygpyp6t0dGNqCK3Av6xgfiYu6e/hDwX+M+EoyqzTxPIDnMVqRLiRgeKWfzG0pn2pmorfI67iAKy7zerknWRdb4x3FBJoS+D1+Y+vOYnMH+xsFA/46G7NaK7BcasrBMnpUbkrbhZpwzxSEgYkG8ZbnJ6YCfwHHKzVCZ1U9/RQXSR9WnSKZzqd2S7RIXpRhiBO16B991zSbqHEnKImJmiob5abFv21gibQTwtmgkWFnlms1/m9Avs/1Lf0wq6RCKGSuCYEsfVRiSp0oy1rfGRTKp6Rlgs7onE7eR3Nd9LoelcGK/SdGtIcFzqFXNPQUHIvNeIXAKIde/CgbWvhTgpRk3C/BJgXthXMs8OLxny6/7o0aEatJ9vAD0ehxZxAGDrAzz92DkRlR6AVrXXiZA2VKQybArT5xNSVnwQNmfZZEhYs5CebH1fPJ66iI/5puxHz8d+MVtMfMkaWuI9UThlHt6FZxknmdSz4JhkgWCXXn+yMurk0VihvLD8i2fqKvILoSprObtMxD6vmh8jrjCIOmOZqhFABCsIQoUaFUzLte/pZBW5LNaYDgZ6aehxioro2kXzfwngGb8nylMRV0dRlYUbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: H7qGYu8mCcTA2WnhPp5pyKcjSPnC+iP8IHM0t4LXy3viT1DX1uCB4RcXHolAt2S/HcCYqp3AHB30dP5PEsBSFdmx9ZZZSFHu6eFXHXJa2NsJNvOP7CdMaf+h+hj2CUY0cPf6oVMRQgIiu3BN5q9ca+40tow3R2pRvZ6j/sCDBwXVAAQjK6YXQ0k4clMr/VL1452/bJM2O/B1s0//AQo4PrZ0vEygsIkI9LeMa4WwQm8NmREQ43N9yvWblBhESny2j4lPYJ/ZcREwRLIMF9zQaQy/w50J0w1Y/Oac1cmt0T4xhE54vgcZfe3idtDFzx29Jo4oLW2wYEw76kV3nYLKCgZwjT19dqAZzs5mGduTrWOPgyJQw8g95f8pc46x8xDcADVlj/Xhmu/dDxVhfqQf68sBqlhAZqxlX8zg2MK4rW8N0mfPhr8oUG/xz0Km8Caq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 10:28:57.8366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb50622-8eff-4c1a-6391-08ded75b8f4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5986
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

Enable I3C controller driver and command support for Versal Gen 2 by
adding CONFIG_CMD_I3C, CONFIG_I3C and CONFIG_DW_I3C_MASTER.

Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
---
 configs/amd_versal2_virt_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 61e3671ea4f..e14981695d5 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -41,6 +41,7 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MMC=y
 CONFIG_MMC_SPEED_MODE_SET=y
@@ -93,6 +94,8 @@ CONFIG_SYS_I2C_CADENCE=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA9541=y
 CONFIG_I2C_MUX_PCA954x=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_DM_MAILBOX=y
 CONFIG_ZYNQMP_IPI=y
 CONFIG_MISC=y
-- 
2.43.0

