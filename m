Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ED6D26D94
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 19:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0268843B6;
	Fri,  9 Jan 2026 20:00:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FfBYotlo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B384E843AD; Fri,  9 Jan 2026 20:00:45 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazhn150120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AB884371
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 20:00:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY9Dbt7/Tx4v2YDEQKsSOxqwkAonwSi1anu3eG4pupthUpVKRkwZJ7j779XbJssmad6SK+K/2kwWiOtdnqgER9+ZDHX7Dy7Lzuo8XNckhY/UYnPwuzc1l8pJjuvk2YFg3vlz7Zxy44EBOf081eUDwjChMqNpONERHqrL6sOV9l8VIK4UuV/2I1uCf5HhyCxflpXMa6D2Hqj0KyB/jdZB1SJeU80prUfyIi4yMLQVA6xD1NJRPJHTOAk3X91ih3Q1SUHWwxCNTplv64FBKLmmUViWQcu4yozk+RUb27aH87mjxSyn9pLXgTd1s2GZVaB6/rqRCP0aeXRol9e4gSpYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOaJ20lBxFqMbnOf+/kih3XQ/5SXCiopotLVAYnzyko=;
 b=cnJxSjGtfhLQQO7qnH0rEqGvb4E1GaNF5wlcgiFhepSI7ZvgVhREJVqSkaUbzlGvtOUFDIFAUXd1IyAS9XiszvllD/dw8fyRsfnVbaDsecSWHSQ913R0lWfVrEchbitFgWYj1iwOgtF9b3D9jxHZNh820Zetg0AdDOhmHTLxUHfI/cC3KYZ52CGVMcHTYv2pruYwUkNcLAGCakRiXuBAYywV4/xW8e+na0/CwuWeBWJF84Rsybev4ghVkTNE6v6b1NX6WlayrPNdzSshZLw/WeNFOdZXkU47DL44FZKBTKieKtJGnTS2JyENNW/3EhSFsUNSNtTkyPbPv8SdwC2mSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOaJ20lBxFqMbnOf+/kih3XQ/5SXCiopotLVAYnzyko=;
 b=FfBYotlo5mVcPvCy31lIkqdm0EjcxScNvQhp59Ct0hOm5jmEZ9bfnPTew6IsgD7D+I7cRa+i45fEHm0w1Jx2NTzgifs+cpMUykTrgzLx7qZt5EPLMt+X6cTT3+rhuUBf+1zkLMPlhCfw6NwPUlgApxdoycg/+8aOMNGr4vBRru0=
Received: from SJ0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:a03:33b::6)
 by SJ5PPF2BB505D96.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::796) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 19:00:33 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::37) by SJ0PR05CA0001.outlook.office365.com
 (2603:10b6:a03:33b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Fri, 9
 Jan 2026 19:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 19:00:33 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:00:32 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 13:00:31 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 9 Jan 2026 13:00:31 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.234.212])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 609J0QpB518987;
 Fri, 9 Jan 2026 13:00:27 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <ilias.apalodimas@linaro.org>, <malysagreg@gmail.com>,
 <sughosh.ganu@linaro.org>, <philip.molloy@analog.com>,
 <marek.vasut+renesas@mailbox.org>, <james.hilliard1@gmail.com>,
 <anshuld@ti.com>, <afd@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <b-padhi@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/2] Fix TI DTB alignment issues with recent libfdt update
Date: Sat, 10 Jan 2026 00:30:24 +0530
Message-ID: <20260109190026.58464-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|SJ5PPF2BB505D96:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fbc5a51-8a88-4b44-3ef1-08de4fb15de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|34020700016|82310400026|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8E4UEniyset57p3cf+HaLNJgn/U2nh9BjmgvwbP9/5wb8X+WmA9AVPrULZ1n?=
 =?us-ascii?Q?6PbKT87RlM87Twy8NverLjI0h37hUswxDKcCe+y9Xg44qNzPj5WqJlSA+ERL?=
 =?us-ascii?Q?dQytClaF85lisYlQXxKIqGi6P47BYO8iHAi4mSHbuhzgWS9Z8Ri6wMkrA3qx?=
 =?us-ascii?Q?9sm280K8ltTA3dA1nIOJD9+4ByqDiDa+zkgxkFbRvMvMbtckRW/X/Lc1WBjs?=
 =?us-ascii?Q?JjyOcLV4bzgesL403x9HTflQUbBmV5VLDtB4urmnkCEM12A58O1/8f5ZQeuZ?=
 =?us-ascii?Q?V/cJWh4WKqsi5PnhD3ZhCh1j0h3ohtf3NLBCBBEG+k7iFVvYYoop0tTvFfyU?=
 =?us-ascii?Q?9I0o1SJvNgObyIwAgBoNnqFnMWbm/fHxSCCHjUbr+8h630BVBeFSSla7v7PN?=
 =?us-ascii?Q?ge67rNNHKx3hD9KFIWZRNateJgX+kxbiGw4wqNLZ5jGi5WQc0xI3tlwaIFko?=
 =?us-ascii?Q?yHtPPUopxo/B08A1YMgREJUU0Px8VxVcCM7fL7R4ENUG7MD32a3R2VZ4pglX?=
 =?us-ascii?Q?QAPB7jvpdqIy8WSst8x2NgVETANwy6DmoB2y7EUUOoScuY3Z9min8DLIEfX4?=
 =?us-ascii?Q?ZkgmsuOoUbm92OrEsTOGYyzSxFIkIJcHkkT0t2aBMGUC7y+4N4l2vXcfRfQE?=
 =?us-ascii?Q?hMzTleG/W5A4zIEXoVt2ECZM5oOrcGV+dZV2Wj4ycOLv6yqSkw1ZSLSTS81o?=
 =?us-ascii?Q?Kt+SiEXV3CmJ/cypajCQ0H65BCd0eEA4waJN8wY5uccoV3lGUGA4LMnzE6K+?=
 =?us-ascii?Q?a4/Jn+VJtKJWWUpmcb0Rway/GHVdkMN72Dj0jA8HazY3TZPncgqal8jgGlGT?=
 =?us-ascii?Q?O7z133zS//N1DFQaKvc4W8jGUIC2P4CR0iwebiPLHyBtKAn6KB+tJLv9LawN?=
 =?us-ascii?Q?u1iXes1QifPoWTUDGusMRgI0rfMejsPwK4kzp2oQTrWIhjHBI4pt3p46wJAi?=
 =?us-ascii?Q?Z4C38i+s/g811/7JKbl6rPCiVT890If7nbGVvqZ8YGuVG5Pbz9a5wHcOoRzi?=
 =?us-ascii?Q?lYqKhcE4+wGvwh8CwyWNrWIBaItN9OQYgjXlQZAv+Ccx9n/uxHd1Idk/46PS?=
 =?us-ascii?Q?kJk0r0FZxpEg1Pf0T5D0jbq4JuOdDF5An0X60lPMKGJN/VVvl/7eN8AM9RKh?=
 =?us-ascii?Q?aV+D6oBXQXICQ4NL31tKAJ8aPhhDy/P8AT+WrH9sLbf/M1xcyQVxIMtv7jUj?=
 =?us-ascii?Q?0+ha7j+s8DbyxAfqkaidV8BQutBRH40Zm6nCIJ42vSrAUgsYSsQsEX3SbNMy?=
 =?us-ascii?Q?ECiqC6kt4ZbIp9eayU4L3ke/Q1rMlVf9U2lSJ5fJjlJ1Q7RLSKrYGUWYy++v?=
 =?us-ascii?Q?DulPTx2essFeFzu6dDCWEz7jrMgVw/40YdQ6GuBpXZtTChPZ83PfJGgZY24/?=
 =?us-ascii?Q?SiwA3uHJrHgMJ6BJzs8nz0v6UZN5bjPLsUbePFgoohxGBtssnyPGFhyXnbwK?=
 =?us-ascii?Q?H1GHnM2rV1Be6MspMQ9KFlc/t4KbxmYb6tnKLoD/fuWtiO/GAP54gfPKwP8v?=
 =?us-ascii?Q?F6DlQV8X3YBTtAmvkU3JNmzObo6pMO9pAq7nn+XYrCbCfSAgsXmAsQDCFi4j?=
 =?us-ascii?Q?OQ/WwdxbeTU+Y1sOgyc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(34020700016)(82310400026)(1800799024)(12100799066);
 DIR:OUT; SFP:1501; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:00:33.4812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fbc5a51-8a88-4b44-3ef1-08de4fb15de3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2BB505D96
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

Recent libfdt updates (commit 0535e46d55d7 "scripts/dtc: Update to
upstream version v1.7.2-35-g52f07dcca47c") enforce strict 8-byte
alignment for device tree blobs, as required by the device tree
specification. This causes failures on platforms using
CONFIG_SPL_MULTI_DTB_FIT, where DTBs were not properly aligned.

The alignment issue occurs at two levels:

1. DTBs embedded within the multidtb.fit FIT image may not be 8-byte
   aligned, even though the FIT image itself starts at an aligned
   address. This causes -FDT_ERR_ALIGNMENT failures when
   setup_multi_dtb_fit() tries to locate and use these DTBs.

2. The FIT image is concatenated to u-boot-spl-nodtb.bin at a boundary
   determined by the OMAP2 linker script. Currently, the linker only
   advances the location counter for alignment without padding the
   binary, causing the FIT image to be appended an unaligned offset.

This series addresses both issues:

Patch 1 adds the -B 0x8 flag to mkimage, ensuring all DTB entries
within the FIT image are 8-byte aligned.

Patch 2 fixes the linker script to include padding in the binary
by placing an alignment directive inside the __u_boot_list section,
ensuring the FIT image is appended at an 8-byte aligned boundary.

Testing done:
1. Boot tested on all TI K3 platforms.

Beleswar Padhi (2):
  scripts/Makefile.xpl: Align filtered DTB to 8-byte within multidtb.fit
  ARM: OMAP2+: Pad SPL binary to 8-byte alignment before DTB

 arch/arm/mach-omap2/u-boot-spl.lds | 3 ++-
 scripts/Makefile.xpl               | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

