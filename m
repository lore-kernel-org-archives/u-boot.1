Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4397C55173
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAD0780C95;
	Fri, 31 Jul 2026 18:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AVuO0pvaCgxQ; Fri, 31 Jul 2026 18:13:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C71C580BCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785521629;
	bh=phmDJmfN75fTth1ohvItLBfi48L6SajNc1tmcwOdh3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PqPo2gcfMCZSEqNzxepiSTvlXlwmJ7uXGGRss92yVHm2fs7+tem0t5O9EZm16DIdg
	 eqPQ1Af6sYEbMJtgiEQfU3JliPqMtCNci87MvI0K4jxPvDXec1FDZ7Y7xoO2v6q9qj
	 cRct+L6P8JXWtqk3VHwNdHUXAWSkmLmIo6jM7aLAKT4kx9r9E21sjgo77jO/nh71Ft
	 ZGyg54i9n3iwZ1pxr24u/0CdT0cljaYolO4jgwD7KKOil5aBv5RWyexvX24OcTgWb1
	 LUAADlcuWYORj51OlruE9uVwTCFf2/xjAY6LgFkdr7n5pP4Tk9Xv2Lfl93zP4xw6vA
	 +zN4jueouGgiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C71C580BCF;
	Fri, 31 Jul 2026 18:13:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C12A24B0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A7A9840F89
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3tffKCwNjSw for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:11:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=smtong@axiado.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9768640E38
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9768640E38
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9768640E38
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D3C580117; Fri, 31 Jul 2026 20:11:04 +0200 (CEST)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A8E84A0F
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 20:11:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyXsUJXGJ0Px8Ta0OXPXB9QPNOFdy/ZwEObUbY8QDMpOlCnJ0F2SjQm5mMox9PmRYLCfa/qd5ix5K8XFi2/p8C1/W+B3QVnFLpsSXCyBr30gfa9I2dzhMy2awPv/dchMMk+4nG5aMbxYXHVsfZOuy1DcdTIUviKcTX5JUiXpcNAJjxyWW/Bs5b4fDhGvjwKUCkrcl1dfgRQXCl9muHV93H+gH/2T67vyTeJMIMMsgE8mbwsWFPjR7cbE2m+R1+JGhlSY9Kz5Yiyk881fwl/WswiPNdv12aNCEa02ou9S+UOrWqpRGXWewJ66hGPr0cGF6HVvZ6Qc9sA59c5yyvbQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phmDJmfN75fTth1ohvItLBfi48L6SajNc1tmcwOdh3I=;
 b=ai0Y6/8SlQLlYFWOLMkck6Zj9kHyHcDsw8pMxj5EulNP21IAuinJoHj0xqob8NoIm/3BNjDxvNYE8LqzdtgWnrjsU7aYkTbAuuUXkXtTHNrSr5Qe3QQtE1D/ZO3O0CNUTqi8/lquNOKAsMVPzQvg0mAiDbDnZXkBcVjMVIx3ncsm7R5LEh1Q9sjaNAYDUyjfs1AmVphLpLLtOqMv/U6qt6JUjX6VGffh8mRELCNSmurtBfxaVfvXOeu74M7fkAl8skwm6t31DEVD29pTWHMXm4eW37Wsofy+qpeHmc7rqfoKTYm2J3/Q6NkBjxhayzjVnTilqh4xq3eScuVkrpqehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
Received: from BN9PR03CA0528.namprd03.prod.outlook.com (2603:10b6:408:131::23)
 by DM4PR18MB4174.namprd18.prod.outlook.com (2603:10b6:5:391::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:10:57 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:408:131:cafe::6b) by BN9PR03CA0528.outlook.office365.com
 (2603:10b6:408:131::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 18:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.0
 via Frontend Transport; Fri, 31 Jul 2026 18:10:56 +0000
Received: from [127.0.1.1] (unknown [10.4.1.117])
 by smtp.corp.axiado.com (Postfix) with ESMTP id D7E2940BFE0E;
 Fri, 31 Jul 2026 11:10:55 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Date: Fri, 31 Jul 2026 11:10:52 -0700
Subject: [PATCH 4/4] configs: ax3005_scm3005: Enable eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dev-scm3005-v1-4-30bea90ac5f7@axiado.com>
References: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
In-Reply-To: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Siu Ming Tong <smtong@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; i=smtong@axiado.com;
 h=from:subject:message-id; bh=qlDfCCvv62KAVcaV/kiGq+125AOSAETuIYL7cyC8uQU=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqbOUvVI2SOIAqetPKQ+Hg05NgPuV3JG4NjfoCG
 avD4L9wVDCJAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCamzlLwAKCRB8HKhyFELz
 jgL4DACGwd0eLfY6d+K0g0f26gDnCjKp68J1WsFuFx+d9BcH6C52Q99/zKGceLScCJ8YHezVCd6
 oiatgRL2s1YeGyWwjJlf0Js7x7D+CKE7GyligJUDmNxgcQTrkMkjbsIB9/HdRPwkgDZ64EnDYCl
 qkYPqqnC6Kqi7FRDqhsTiBoIccsu2Upz6D4M8E74dQbU0NiMZ9XYrdnGsUSo/Zsa7WRl0yanQ2C
 sL02fYeS80GJkDd7T7FgPLxYbHuER/KVIcX0Rrod9y61tfAoQyRw9WphOf5ax6ytN1kmd+IMsHf
 DTGZCT9mGbdMBQyB3jR7Dpdpdit/VUsUx4n8O9O851Nx243gaTTcg64TKEQOOy5Y2y08hg+/vcl
 7HptwbWJt2h7rTEBgR36P3gGzDoNDxoCrM7Et/eyCJzhwUukULUXS6aolAQQRKPBz4LEgt7J/IE
 p4SXIh/6F5RbqZBU4Lft2La6LuD/vYkPHh2W7IPJrj8eegZLJsW00RNStvdJjfTl4KKzk=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DM4PR18MB4174:EE_
X-MS-Office365-Filtering-Correlation-Id: 2732ca22-105b-4c25-e0a9-08deef2f116f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: i5b+1u9+Imgn5DlNCXROtoGZRZuPidZCOHMCbTVhHOTE7X/P6w5wIat3r9S1pqW+TpZrCw+XcPCAaCSja7LCYdaTEoVeiM9jtjevhA5dv2TpECqcdWkTmZI7UK0s1TX4cIw7TBP+LVrJWUNrxdpp76kCQrbqSLp438P47HnhuwapdbmvocKoOLb7hCkWH8joOMshuQ1CpXkBEVUKDuOY1uH4/hPjPN2CJ7kGYB2LwxauAK/4cT/XGeG6kicb22wXI8r4fnn41ecbj4YYCFwVFZ0agXUZHCnuNlHdOyeum52U8zUEvM9b7beyC5Qyq7LOyigIHvsvVLKUjT2zUfzV0FQ2k6hQtyrF1AEVhX2aIM5yveyPWZVR2RWryVonpbCupD4Hqv3huYC+/7cQczMxtbV2b4eKmz/Gv6kEolSK2PDslrZB4Iof709JIrt4YTpqLq3PO8Zo6TKufkbUP2r6uaXpv2e0BXr03th/5KTwLa+W9Ejms3ds4ygnXWy4oP2MIsv0cfGIGRT8VT7gSt7ayTOMP8Cq3BMmRT6RmEGQd+Wwx4gdSgRFhirUwql+L7/2i4G0ZLVgFbaXqozmBzJaYHhw/X1Ujs5vrOUv39Bm/UKSsCBKpM24FSiBZwK7xWHxmfnzw6BuXVPYn75SHFkiiz3DnxBR4B/PaHWGvtZuf9c=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rMjY0M4NO4lsvl97KleZcuftkEhfP6m3SiHnAXFd3EZXPeTctxsT5r3EPESZayNYyBMGSknVW3icJtAF0C1dFlytayMA+cF0Cq8zXFHrw9xcGqhdJF+wERSr9Q8bMUZR2Bk5QywNG4uuCZV26Sio2bbVHCsEoszTmk57upoNa/PbGU8j1bfOmfcdtsJ0U00GSQntqypRV/PAPKkS/ewOzQ/f2utnCmKdzdM6ssxYpYxb/rqNeFHe1RJ73NJ5o73akxcZTlH7ItxTLX9yAwQtKJ34tsLAlqnE/nqxCKSpr3HIhPcOR1MeOZvaicivKfnz/WzjHMAbpJ1Vj8l7n5Z+4PRyn+a8L6lcZL6em/SL3lJiKu8NAPJn2KQ89ArQzWK8FTglWVTm2Hp9gfcKyfbEs8BwV805uKFfbq6qSZw8EMBV3GB0vYsgk0RjEP00g1bC
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:10:56.6490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2732ca22-105b-4c25-e0a9-08deef2f116f
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4174
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:13:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axiado.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phmDJmfN75fTth1ohvItLBfi48L6SajNc1tmcwOdh3I=;
 b=IL0s0cGkXdEyBfCdlSzMGxCY6aGN9t/6X2I8rF4JZLmP30mYZt3r+jOTN2EK9Ut/4tBBwBXThmONCQ5dYEJzdUFOmQQ8QB0CuqTShb/XjMfPZbtTtV8LRgIbzrEa2eyS6qfWTBOjawfrf5BvaNsRw/uQ1MtJZkQ5OPaLABbg41yJzqOJjztXeRL6xQnYrv/3Fi0moWXYUXfUYZBj6izGS/jxgCVAb9+kmsjg6JeHmAx8zcuglp9FNz92YI+k5u3f/anJS7zSxje/0ghC26LHWd5as3FLiabA7MN56wxKDbkCgnoFjtOfjGLPm5jqLh10W9Fw4p/vwOImfRaeLhc1HA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256
 header.s=selector1 header.b=IL0s0cGk
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=smtong@axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=axiado.com header.i=@axiado.com header.b="IL0s0cGk"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable the Axiado SDHCI (MMC_SDHCI_AXIADO) and eMMC PHY
(PHY_AXIADO_EMMC) drivers on the SCM3005 board and store the
environment in MMC (CONFIG_ENV_IS_IN_MMC / CONFIG_ENV_OVERWRITE).
Increase CONFIG_SYS_MALLOC_LEN to 0x400000 to accommodate MMC
operations.

Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
 configs/ax3005_scm3005_defconfig | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/ax3005_scm3005_defconfig b/configs/ax3005_scm3005_defconfig
index 5dd72d87220..0aa1ec85c36 100644
--- a/configs/ax3005_scm3005_defconfig
+++ b/configs/ax3005_scm3005_defconfig
@@ -5,7 +5,7 @@ CONFIG_TEXT_BASE=0x80000000
 CONFIG_SYS_MONITOR_BASE=0x80000000
 CONFIG_SYS_LOAD_ADDR=0x80100000
 CONFIG_SYS_MALLOC_F_LEN=0x8000
-CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_SYS_MALLOC_LEN=0x400000
 CONFIG_SYS_BOOTM_LEN=0x20000000
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x5000
@@ -58,12 +58,18 @@ CONFIG_OF_CONTROL=y
 CONFIG_OF_SEPARATE=y
 CONFIG_DEFAULT_DEVICE_TREE="ax3005-scm3005"
 CONFIG_MULTI_DTB_FIT=y
-# CONFIG_ENV_IS_IN_MMC is not set
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_OVERWRITE=y
 CONFIG_DM_MMC=y
 # CONFIG_SUPPORT_EMMC_BOOT is not set
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AXIADO=y
+CONFIG_PHY=y
+CONFIG_PHY_AXIADO_EMMC=y
 CONFIG_TARGET_SCM3005=y
 CONFIG_CLK=y
 CONFIG_LZMA=y

-- 
2.34.1

