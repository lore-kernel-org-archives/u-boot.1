Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68F4D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A3183AEF;
	Wed, 10 Dec 2025 16:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SmIxioOw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C41D483C94; Wed, 10 Dec 2025 16:48:55 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E18D83655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpYfLf6GCiuzDu5crxwHWp4FVS5NKBGGN7saDShjNtR3E91G6NCx6z73wg1U4Gf5ifEbp8XJ+GbY/xcF9XZ2PeRdOC5uWmFGedh6M1wopJ3zNZ5sFLQKvzvjj1ySPaGxxpj+eF2xySZAH/ffCXddiRn7JghoU+83I6BClNDDzSMNctmW/aGJ1VqdOOqk00761wSo+zDpSl8Ela4UVrNJtBEEe01DwfFphW6vTprbPhvpeIZFBYPFMn7dXfKkGOK+VJJA3N8eK2tod3uQl4tCkPYBAvUHhhSfwvOtiWqAmoqMJFB+qSgBSmn/6q0YTXD2dFY4GHHkuYrA862K2yUYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CF0p2tw70ZY8+/dsIxT/5+BZNOXhTxRB9Z/WvmkqtM=;
 b=eol71ROsYxnzGA+llxGZvReLoDgsdvUfi7S6wr8gZuJVVSUwW+cMXjEgUyQcDr3sPwuMvEkRSs4PkP/1bWlJr/2VU83W4LuC8j9b4ep0nsiCSV2Bh1tXcs9haxfJfyDv1UBS4euzocgqwZu/8LWtbMgjweQX2KjbTiVDUEiGtOc0uHm7IAxzgZ/V3XctDdrSMWv6MYu2vLX3uU6yuwkTH4V+sZHjfeqJ09kP6iRGR52vZ/Qh9cBgpK8C4WhcdvN4GL9d0Ius0+xT9cyPrI98BR9xV6XIhtjjq4w/DjDLZl8l49ILGPtqQ/mprS1zcgIhyXW5Uv2U2Tw1v9yhAmWfCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CF0p2tw70ZY8+/dsIxT/5+BZNOXhTxRB9Z/WvmkqtM=;
 b=SmIxioOwoGeDyUuYFDYz1LIWXCyaP+FpZ8mR5IqhSpb/GU6B/a06C48TWsJ5jlL3pUqn00Ogh291UnE4K9rswdYUwPE+meBTHv+ZhM+m9ZFmvkQh2eQfiFZArAMSeHk9eokbGdRC8VACQZV367f0VAylFLh4c4ek+oz4DroGnEg=
Received: from CH2PR18CA0009.namprd18.prod.outlook.com (2603:10b6:610:4f::19)
 by IA3PR10MB8492.namprd10.prod.outlook.com (2603:10b6:208:580::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 15:48:50 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::3b) by CH2PR18CA0009.outlook.office365.com
 (2603:10b6:610:4f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 15:48:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 15:48:49 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:46 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjs03199756;
 Wed, 10 Dec 2025 09:48:46 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 6/6] configs: am62px_evm_a53_defconfig: Enable SPL_BOARD_INIT
Date: Wed, 10 Dec 2025 09:48:44 -0600
Message-ID: <20251210154845.3852231-7-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA3PR10MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: e44f1bbb-e496-48df-3c50-08de38039cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m9ipWdmCJDQ0xj3vRGAWCzafuLKNTCup9fEznpWsxjb2+3BVi3xVTas0VGWX?=
 =?us-ascii?Q?AJf3gScvDdFmM0WgX1vYtjKMv7HN8lWT/ZxW1XyUyytn4dcw3A+5RdEJucMf?=
 =?us-ascii?Q?B8Bw8G9Gww6wJmaPVboRKgo5ay9nYTW9KDAL2nF2KgvSuegMTgvlVAtuQO6u?=
 =?us-ascii?Q?WceUhu5zhkvaCrZfOAmgBW/DkWQbxPBdzDLdMZGpSzWukk3w84mUDybv9MRu?=
 =?us-ascii?Q?H3kuZ2RjszbGDRi60vftH7fGyI6P2WfAuUL/FonQ4UWvuuB5lxq/3l2R5xYt?=
 =?us-ascii?Q?5QsGcHHANDN7RS6+nkoBJ5g3z/IpxcMw9WDQLFMzSqGtBPuNkVsgR6ADCu/r?=
 =?us-ascii?Q?45AxwBbTGIly5Co4UwgdkSVf+i3D1eaJCYLCPyt14yWvKRhzb1hPfpUyKQnG?=
 =?us-ascii?Q?TFFt8IG6JV26rXceToLZ66e8NC98ksucQqWULEyWHQGAmGgGMwKCGHnZvaZR?=
 =?us-ascii?Q?p5Yccm0AD6t76uc0qMCHfx//n8LihRQzTFH8NbbzKOiTZl0K9qLkEVze6XO3?=
 =?us-ascii?Q?u19HyJav4I3fEAxoYClPfibF8VyTWrYdRpKqILq/FFIYbEhU26j/LnflQ6RJ?=
 =?us-ascii?Q?vkjiEUkHuX6PxiKt7eUwr6aMUjwoJfu/8fizUyftZJ8l460hVNUErSjg6m5U?=
 =?us-ascii?Q?waobmzOCR+FalFRDRnClP/e3P12dKc4yn5M2M7q/MmKQGoUjE20wGAHaiLEe?=
 =?us-ascii?Q?43xDLwt7/Gne2XhOwIshYP3TxYT3WVKf4/shIv8KhjOyo25eSTsgl+kungo9?=
 =?us-ascii?Q?selq9aDtVnn2xnrmtWNU6kDtGDerNcEo3AjZqufiQKJp4VaIrPnhvrGK+Ewh?=
 =?us-ascii?Q?siFYPh+Wn81WaMMzCtBCRoLDXsQNytppYp7pIeyR15/FLiVJmYu711NE5v4k?=
 =?us-ascii?Q?bODiU9Lc1s2z6DrgckN3MyJK/hghXl0XhSZ5PFmmk50h/lgTbaih27GX9iYM?=
 =?us-ascii?Q?4TzcqH9sNuVY0drmfge5FdQatUx8xBdOnZPfjCmPGjVJ6rzA3hO7VlgLBPSR?=
 =?us-ascii?Q?v9Q6WHxFMj+pUBamPiX1tY3dLIvTdWfDwCxHwO2T7e+PrSYs/JqqKu/nYNOW?=
 =?us-ascii?Q?zkEBNzbjt3DAmEr5hzFk/UwNJhumysiMmtBnORm5z1B49fNFddTOjo5irK/l?=
 =?us-ascii?Q?I0bIXGPwtMlA9G9KFClyV0X2NrvS2hIPWa60XOm1gUGYEPnThrpUpwuZ0uvt?=
 =?us-ascii?Q?J6Hzl334Iz2UK1B2noS8hlPWpAUgZ2NkM7ZwrsDgZ1FQ5eTNHjWk8Qqv0QTP?=
 =?us-ascii?Q?Oc/ZhK+EsQEpo6n2ce5QYh6CWLNrpbbVBw1sBorVQxJlTBpdNdDx7JQX83a8?=
 =?us-ascii?Q?8QLnWQ3oFfjqIWj9Oegvlr6egvItcbE84M6b2whHVdLX7zlXwIm9172xFJRW?=
 =?us-ascii?Q?Yk+dPPlxT6D8auz3RUWkUqzcz2Fb/yY9jwzNsvByYiypA/o080bXIF91C/AZ?=
 =?us-ascii?Q?r+h1969OCKe+iHC/Xfe6TkzFGS07sb/jzDlckZ9M73RderERA70ZxPuGYyBY?=
 =?us-ascii?Q?kx7R/oSEV1mQz2NUMLaexFsAkoYj5ZgYbn+EDUXqtGq+bsE9IUCFbUHe/o+d?=
 =?us-ascii?Q?l03ijs7B4tNfhEYcdDY=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:49.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e44f1bbb-e496-48df-3c50-08de38039cb2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8492
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

Enable the SPL_BOARD_INIT config option to make use of the
spl_board_init function.

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 configs/am62px_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62px_evm_a53_defconfig b/configs/am62px_evm_a53_defconfig
index fa857e51137..fbf73633418 100644
--- a/configs/am62px_evm_a53_defconfig
+++ b/configs/am62px_evm_a53_defconfig
@@ -36,6 +36,7 @@ CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
-- 
2.34.1

