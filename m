Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E4CCFA13
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 12:04:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1457842D7;
	Thu, 30 Apr 2026 14:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MWo7v5w6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54D36803C6; Thu, 30 Apr 2026 14:04:41 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB1683A91
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 14:04:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6ndNcAvZK+Dj0J/a1e+d7IEeE8B6MD7DHaWM9k57j3OWAA89e3uR83hykuq6QSxafgTscEOR9cygeKrDded0BGCWP6y3urm9Klh7CnPIpaV/FQgwf2k7ONKbtPXRFuBnuX+XxTQLx1q30EDpOR3FpVUQ5wSmyZKmCy8hC4fttWrqCw0riNtiKsMMJsN/K73+zKudE1fAdDmCJOv+/Zx9CPc0mfyiMpC0OqC6yFc796Oc8Kk+wjgIrOdVSp6gNfYOhHx7aTaEaRP9g/tOppG55v5LCJozygBkrWKD+xpL0q+qrqwsFhHrewb9CJgXoTyR+iHUCRCn5g1eIPezvG9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCuASxHvyUC8bLmPDd1FILlep6mbYJ+SkOTbxVENcFw=;
 b=yEz3wlE1Xk1ZAbg4TdNyUmDg0WH9UQZqCgBWhfKlplB3E0mhGbuQT0xZlqB71JOkGH26w/pNB3NJDL35QgF6ql7oN3XGeCdkhJu6C3Uo5zagsPrs9K4vTQ08ppC31WdOoS3bvkuVxmOw30Ms1ihlDtBenA0PiR/q6NHVJQUy/MPCsSsxphKHj3/TP5mEWQ7ycTMSoSJ1j3AF45jHvCRw4+ZfS+uKFShmv7v3sWSpJ36tMTKal38YGYS9x4SmGDDI5nzHsDXHjGxDdUVbc2Y01F7iJFtzL5gPfTPNK6/BF7tRmwY9FI2DsxCSUNEfrkM67UeS0pwmbQ/AodebaxprOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCuASxHvyUC8bLmPDd1FILlep6mbYJ+SkOTbxVENcFw=;
 b=MWo7v5w6+emckbB4uOBjsz1OyYSkCPsuU4P0yXnw7CPvQ1u5Wh0uEDae5D/skHmnxUYyP93odXmWV765ZoQT7PxyL2aMCffjNX6pqwF0em79Jme6qIRcqzCSpEjzYcQQd1KRbQfv+shtwdZRalQRiPunJiPCRMciOB9Ew98zPAg=
Received: from CH2PR15CA0004.namprd15.prod.outlook.com (2603:10b6:610:51::14)
 by SA1PR12MB9513.namprd12.prod.outlook.com (2603:10b6:806:45c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 12:04:34 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::b5) by CH2PR15CA0004.outlook.office365.com
 (2603:10b6:610:51::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 12:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 12:04:34 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 07:04:29 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 07:04:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Herren <sputnik@on-the-web.ch>, Padmarao Begari
 <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] xilinx: mbv: Disable CPU driver in SPL
Date: Thu, 30 Apr 2026 14:03:46 +0200
Message-ID: <96dcbd196206f48aa4552624b562124c11cafbce.1777550623.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
References: <511c3c05d29479a4d1410a902cc01963113c4e1a.1777550623.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=XoQkqLjF3wVreTdCVtgvhuuIf65RmHgT86Pl0vd1tTI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR+drWLPZI1eda5gjNiBfZzTzjOXCf6kzvto55xW88F8
 3/i+V7CHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjCRWa0M/7NX6CusclnMH3fl
 2YEFCVe82SdNcf5X97nK74A+j/+/YmeG/0WXlT8lH5JtsPqv2Pfk+AOXM0dFnh+Qq2CTmrP1pXB
 6CisA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA1PR12MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: df5c10ad-294f-4d33-89bb-08dea6b0a4d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WDfR6jV2oI12O1VxzNfQqWKXpphD+hy6CYRSmQurkLHEVWdKOIwN3ch7iPC0xkpx5/VimlUZ3gO+smkRTqg7vj2yr8kk21SS2O9zDx4dQSncrB+zkMdw8FuCm9eyodBgq1dbyUI79jer2VWcu/k6v+AgE+z0CR0TJTpUfxQ5vt+ELDyZQEyqGlOfWcJWyCmlPNI9/5DuRjRSoBghGHE917AFDEHaM69H/0iQyIZA/0qhoxP36Kn1ba/lFDNXTiU1+WE+PA2akT7FjKoFG79XVjU/G8pIbmqaomq9NZFMFbo4JbETMHeJEl4yV/HYy0LKUlA4JpBu5qBHDEhw00IhXBwD2DFCNO4vQVzTPuPdpOa0or/YpOQ69ENM517MmlMPUjA4shPCKB1M3c9ezO+MZi6VyJqrMtUU6n44bGLHD0pel3Gc9uJClr2Wv2+J+JDNPvmuAMTgO+JSbRky8wXKY4KDfZqs3UDJIKAqn+DVxk6YHeU2dGnxda/WbtUPC2HFssbsUUMDkc3ItHnr4S4pgB4G+OP6KpcBO2MrnWS3KmLtn3rm0w5bRd4LUI6fEdzOc6DTlL2yu5udKdyK6ImBzzg4EhP5g2bvzaPaGL/06qnimg8jBqaCGsax+ZZcb+69HL+DOlBSQq37oC30O5aRQDEuxmc8hnMy3VY8+99l0J9yxf3PZAQuvqewgkIsAnhv4Krgr+VhUmr5/y8/Z98Lcmknw4T2KvTo+K3EeCngTWU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +YWp6G4/WK36KKuxGR6pW4N8ru4bG3+qkrw3Sop45qPNcapZ1Sl2j+e90S3TS8+0NwLIHTizFqBIZWvJQE3kahWudu3jtOse2xF7w8vIdJ+bCIenXDuEcrMBiBL4eeceijUsfBZLFfWzJyu7a4GmGH5a6AWCkS5+EplAN+UPfcbF0afhTij77c6itWu9HX1JopZgptR/ibVPkFm366TyvFQM2+RNxnOqcv1Xw6rZxspy6cRcA1l/5VjfUMTPw+s6RETL2yn/cb1D8kwjvWY6qr1DvpgP6qWSylzHhzjTkXXw/xsjDfWhPkorJHas1Foi45Gds+34ns8Iy7fn6TQB57KUNygvhoFb5DXxmgQq9uX9G3YNyvxG/BJp27/MT6pUSOhmCj12SJ9gqAyXz9tC0rdMm7bl8hD27RfIs5aUZqwFHG83qGF/eKeCBBkxDxOI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 12:04:34.2602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df5c10ad-294f-4d33-89bb-08dea6b0a4d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9513
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

Disable CONFIG_SPL_CPU to remove the CPU driver from SPL. The CPU
driver provides runtime CPU information and enumeration which is not
needed during the early SPL boot phase, saving significant code space.

   spl/u-boot-spl: all -922 data -208 rodata -100 text -614

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/xilinx_mbv32_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/xilinx_mbv32_defconfig b/configs/xilinx_mbv32_defconfig
index 9d0111fe8e53..9538769f17f8 100644
--- a/configs/xilinx_mbv32_defconfig
+++ b/configs/xilinx_mbv32_defconfig
@@ -36,6 +36,7 @@ CONFIG_SPL_SYS_MALLOC=y
 CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
 CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x80000000
 CONFIG_SPL_SYS_MALLOC_SIZE=0x200000
+# CONFIG_SPL_CPU is not set
 # CONFIG_CMD_MII is not set
 CONFIG_CMD_SNTP=y
 CONFIG_CMD_TIMER=y
-- 
2.43.0

base-commit: 6ada697cef076eaed1971c4877c402a91ad5cb48
branch: debian-sent3
