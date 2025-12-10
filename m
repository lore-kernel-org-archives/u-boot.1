Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20F9D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:49:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C32A83CB1;
	Wed, 10 Dec 2025 16:48:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sdyfDXQI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3F5C83BFE; Wed, 10 Dec 2025 16:48:57 +0100 (CET)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC27583C08
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROikCVnRfNTn+UG1vAcBbPb1f8RlSzOa7RNTxRG+6prpYGpVhBl+6gGfzwb8nrzATMykO9sUbqQ0RZJquD5IYo+QT741wN7CzDNDUPxlR/yWucWHDtj5j/+0mldzoCdIkQhH9vnEjJRrHX8PA2qiNX/aIiA9UuxnPRI50ME4jsoEb18r0ewRGVO6oie0+MmWgSziegnfV7lIwvZqVpcbHEyuJxhqBWp24FQJzoOV25mhY0eIE5viPfiyjnq0znQzJGNE1CMlHmoGKl1ZBLnEqDz9ULF/+8CBeKjABcqYyknKjgzIptuu0ZtWtNf3o19QyyXe8K5ZQO2pYIogiqyYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07BGbvpyFKZWC0AIX9zoAOs8WXMU9X62U5nnsw4txPw=;
 b=m7naimL5JrYdubwsuoX/NFXMtKu7PyjfAeAbJnTBjygGw5WKUAPLoa56a27nq8XB3Zo6SZ/WHwonj2ofO3lpk0WG4RAMbEY1f8pTZaTF+ufu27p5W4jQBhqEbmf3r8YI/50DR0QqPcZkiiyuithh/FFn7XbBGPH2XLe05eetR0mpMp+6MX5UNXzotUPsRtY9k5TnpdWYzQfOl+n3hGdIx9rM/C9BlWRO2KKAvCYQFajcMreeAewjB3mlTUrCMxh+70FgC3+rd9DD4uZga3byghwM/jJKmDGhhlAnz8hKBBL9Y9fpdFEOKKo32XzDmXIL/O9r7bYx4Hn3B7qFEwYS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07BGbvpyFKZWC0AIX9zoAOs8WXMU9X62U5nnsw4txPw=;
 b=sdyfDXQIoRsMN8kzA5UU7rgF3YGVl/myvYLcrsLujVzodiLXoEIWcNI/0l32I2gSRGwiIn9Zjc7RM89EHWCNDllb9NE4nG7dGMzcWb0W1qrYBeTyhjTg6Ol55z6a40zMgyDv2ZI/+LOMhKCAiJtNmxCWAzpLQ1IJO0ayMqhhqF4=
Received: from PH7PR17CA0024.namprd17.prod.outlook.com (2603:10b6:510:324::21)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.8; Wed, 10 Dec
 2025 15:48:52 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:324:cafe::5e) by PH7PR17CA0024.outlook.office365.com
 (2603:10b6:510:324::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Wed,
 10 Dec 2025 15:48:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.0 via Frontend Transport; Wed, 10 Dec 2025 15:48:51 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:46 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjrx3199756;
 Wed, 10 Dec 2025 09:48:46 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 5/6] configs: am62ax_evm_a53_defconfig: Enable SPL_BOARD_INIT
Date: Wed, 10 Dec 2025 09:48:43 -0600
Message-ID: <20251210154845.3852231-6-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MN2PR10MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: 5eafbe42-89e0-4154-1d3c-08de38039da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kmgDAhUsDcJMn9ZVVy0rTWQLxTkw1pyEQw7rHlrM6PMQhOq9oAaBfHr56QEM?=
 =?us-ascii?Q?oghymhSGqvNFV+HWWXhvDcUQzai2tIP/5U99UUlZBIBysQQsN4XTbsyqwKYO?=
 =?us-ascii?Q?LYIvoxfwPuVu6XPSph7Fsnn61WsMp3ljxaID3bIS3x6mPv791nhXTzcvXg/Z?=
 =?us-ascii?Q?boqrCB+2/06wEXMkZ1IgTqdRrRO2kL0AlkJBEeKdd4r80aRKnDHXGJhLhQXq?=
 =?us-ascii?Q?/D7GSam0RtY8++7HqQmqjKWQGHa0eTt1yOhyRzxkwIiFTj0j5u/Eg5vfbPkc?=
 =?us-ascii?Q?Mr4BMKsLrebfgG/dyCRd6DoV3KZWqdGlxJajdZFr7m9sT/dyqYg/hRZRvGGJ?=
 =?us-ascii?Q?kkHvmaIPU49pwfEKzaM/FDAEN8ywuUT7N7eyX9MqYbsJCF02G6xUGXR7J6yH?=
 =?us-ascii?Q?VeUozQTccw5INKVfuFCAhfL1wbMgG/ZpS8jFV/kph4RykWYxq7x/e1uAx9SC?=
 =?us-ascii?Q?xkrIdCBI7qm/w4VMloaZSrah+05z13Mtk7z8fvzFDqv/PigKu4fjCJBK7bHA?=
 =?us-ascii?Q?HnpPW5glqlQ1xgtzP0ZccuBa/Yh3TsYK60Ts2StXgEAZEsk/ffUU28zfTaTT?=
 =?us-ascii?Q?5CynWnz+g190CTbOyD9Fs9/95S1sfqGPbYlWa0uPegQJXvvgjLMkx7S2sYqE?=
 =?us-ascii?Q?DQVU2ws+PYysFFuCqLa37C1qPN+U9BiMOWfxm3NURO/RBtJyhG0yLOr8Mago?=
 =?us-ascii?Q?wT/p2FKAe+udK4RmpPhFJFAfzmb0Kbm9UI7N1if6Fx4TT/Il3pF46/odAjWJ?=
 =?us-ascii?Q?B8KyWPoGgudleuBbTcbIfrWEFa45azu2NT4jyOgI1iGCLRJpMK0/b5O4h2IQ?=
 =?us-ascii?Q?N1LpCvR9vNs1BiE79O8t30eHq7FTLQdSbC8XaCCEVVIo8FbECdq/gUM11pva?=
 =?us-ascii?Q?FHe4wT7jU7dzCPaoITVagybHuPcC1MZEToS71v0eg867Hzv/RelgsnpLCMrG?=
 =?us-ascii?Q?Vo/KC5pR05k/WvRJIe0eewzZk50N/gd9xbuhMUKejj3faCgh2vGuk7YBN2Xd?=
 =?us-ascii?Q?jbz8XEm00vJV6aa23tmM7WBpHQ7LxNAykTay2OGIYZvUM5y/eypUfaf8cfuI?=
 =?us-ascii?Q?tp64Cicad0KPgkM8hQJTQZKGBywIwAawMqWMhmNOe7mXEWV+ToPGD05bviX8?=
 =?us-ascii?Q?PTuVz2KC+dXcF753hFKrsKmIhM4vaCJ26tqMYYG6xcf+Wo3q1cHmNFsym3J0?=
 =?us-ascii?Q?E5ePbfEOIKl+Zd8qbY/M2Mu1IruZC5fJZwjy16xXEW9ov3GiE19pOcob4kcV?=
 =?us-ascii?Q?pEDeWiAOGbFo7lNEVWZy3CKKMIQEDPeNXo6cBo6oONrpQURvOqJxYcqf9ZU6?=
 =?us-ascii?Q?8h7pI+yHp9L/9ECypFHI84WJYR8K2yi8wJjR0H2aaU5RJBid0YbJRq3w/6WF?=
 =?us-ascii?Q?48qHOiJBywwsnIYOHyhL0jm7DEZvUt0M5geSf89VtbF0xNGlfh3CK95E84Ct?=
 =?us-ascii?Q?OeZsGt6hRMY6mKH5SsDNDCE3JCHqxWK/+LxoNzx2FAKnf8npjesqxayspsf5?=
 =?us-ascii?Q?PrIAQF1INQlgz3f8QA9I5U6rT0ofjp8g1ysmaFpPUKaMe2p/QZFu13ZzztF4?=
 =?us-ascii?Q?3mwAdo7eEAZqUb3Zryo=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:51.2694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eafbe42-89e0-4154-1d3c-08de38039da0
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
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
 configs/am62ax_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62ax_evm_a53_defconfig b/configs/am62ax_evm_a53_defconfig
index 3667a0656ed..9dfbc580df4 100644
--- a/configs/am62ax_evm_a53_defconfig
+++ b/configs/am62ax_evm_a53_defconfig
@@ -30,6 +30,7 @@ CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1400
-- 
2.34.1

