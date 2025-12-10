Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E55FD3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E06C83CEA;
	Wed, 10 Dec 2025 16:49:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="w1PTJM9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC08C83C94; Wed, 10 Dec 2025 16:48:58 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F58683A71
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vishalm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZBIuhLhGxUwQJReajV2K0nWARp1y5VjhbFRT03mtBJNT4PzM86vtLQaUkj0b5xakJu2gzWnBDbp8m4upifGXpOU4OFXOlOlqZXfgwFF11SrUWU9ykPt19yqsP1YgIzCsreOhCaK1d87JuIO45XDE5bivQ2Bdi1FnSxJdduMWwMAj4K6HM+hEZofe6YrULbF6jrzkFlp/ylLybGWC5rWy89rj0hHCQpdcOHZ/35I8OCCRt96mwp0xYYNE6VPfzGdgP4XeuLbKVRLXAF3o57v9AZPx2P8zD7FYn4ILfWzwIb4RqU7vvqyShGCzfnlfzXWRM3dItS5K4OxlyZ2bla6Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bAk3wXt5VFrzJPOV96B50p6E3+Ai1NHKhe3nL8xUls=;
 b=mlO097/2+WtevTX8FxjgxQppeF1xkkjGZfpAmTmIkK/OXZ9zIa6QMVxShIElqxV3CGFeUW17vvQVVAFFcTn6S0/0kRo75MZqEXXpnRIUwnkk8C2vheSFCBq7BmN4+KDJ768+0GiLxYFWimfAhMBLLiw+k/Hv+I+Nv0i+oNT2oeKovzCC23xoYvOGms2+uzA3TFn0jiwJMiitBu7J6eDTgNi2fcMjF6/AJflWB+hqBhtkq8BibpRG/Cl4yWA0x2Ik7bbng7rwa31rD9ha6OiiEewAdcdEDuLc5rtIhKtBB0t9TTDjyEFQaWp+2uIlTmCdqjD0hvgCj+rQ0ccaFWiUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8bAk3wXt5VFrzJPOV96B50p6E3+Ai1NHKhe3nL8xUls=;
 b=w1PTJM9OYjAnQPiL1OlmiTSQJui8UISrkwdjrFHeKlzUCLCOlXsQigM6Ts8XgTMaY/pHF5DPxT6R96ai/KsfCx1EFCxnKdNv8oWsxKMLWAZGoFUTDbvAPjZKbDB4z5fW8HPdYbIeGOT9jZI/2/tOq6cYauB2t5bHRwxiPnsL75E=
Received: from SA1P222CA0042.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::16)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 15:48:51 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ff) by SA1P222CA0042.outlook.office365.com
 (2603:10b6:806:2d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Wed,
 10 Dec 2025 15:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 15:48:50 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 10 Dec
 2025 09:48:46 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 10 Dec 2025 09:48:46 -0600
Received: from uda0271468c.dhcp.ti.com (uda0271468c.dhcp.ti.com
 [128.247.75.68])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BAFmjrw3199756;
 Wed, 10 Dec 2025 09:48:45 -0600
From: Vishal Mahaveer <vishalm@ti.com>
To: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 4/6] configs: am62x_evm_a53_defconfig: Enable SPL_BOARD_INIT
Date: Wed, 10 Dec 2025 09:48:42 -0600
Message-ID: <20251210154845.3852231-5-vishalm@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9c2fce-de0c-4c69-3b10-08de38039ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c2J/rixa/klu64vJiQ/FNqnmRTPqQHQ4PZGUXVbvFXfWDjP1RXfafWozovxP?=
 =?us-ascii?Q?PEYeDHY+H85NqfkGlV60CVdJqZr6n+JjmxZUqTqUaCAOOrBpS0LmrQ8fRixm?=
 =?us-ascii?Q?CpNmtRzPwnDAE6WGIH6hkG4M/c8AyYEPFhXUIZzrdKRgL04z7m2hFYmtiNEn?=
 =?us-ascii?Q?Z8USMxzjaSegoJoPjWM09HYBk/jmkG6+7c1Jy4gdN5Eb4io+5GRjlo7eMenz?=
 =?us-ascii?Q?hPFMpqaQsdBMJxpBFJzrN5rh3LLGg4j5B9vsrZXM0uwU4JCdXtbykJuizIA6?=
 =?us-ascii?Q?rMN/XO4Utk20ZSmHm4d4orA/sSIGXRYYtbNIWVjQp3Yam0WPsH1e65pItLSr?=
 =?us-ascii?Q?wTxpvNDMThvovyerUfYbjFvivx1twp9NaN6VcCWBPewIZyHacc7EKVk/+OEt?=
 =?us-ascii?Q?fpf/jgSczbjmMVe7rnJeBaMdX/V8z2uE9pRQ9BAuxB+ag6Gyb2tMA+aypWe3?=
 =?us-ascii?Q?WWP/J3oOrG6PQu/Cs/OTBeVUDu7bvP1tzYeDuXa4XlSUnzk53tRqMNkTD5eT?=
 =?us-ascii?Q?alM9lHari82xsckGVN77fZHWM3jMhI/ZB4EPPvwqSzlQZ+6k7m7TQwCXi2Yg?=
 =?us-ascii?Q?Oduxc4kdi94lR/CX57AH7VC0jd4cklOyEhVNtsovpq+xjWE4gim6YZ/1SaB4?=
 =?us-ascii?Q?1fqL6vy7oRamQCClqpJ9eGukZBt4o3J6E4Fl3ZSjW8KJA5xGz1gV/z6F596o?=
 =?us-ascii?Q?LGqqq/TUEoLkaEGM6Olvpy201Xj9L2g86vYkItpq5EA+J2rozSgcn7aW9Tpv?=
 =?us-ascii?Q?rCscpdtOBAYtnUF4B/KTqe1hy6DN7nP4EWnUScsAM+FxvuYACqXIu0uI2gaP?=
 =?us-ascii?Q?bl30FQU7lMdTS7fYyQ2Cg/bJgv0cxLJ9x0b3/uBARfAdKzWv8mSvcnwMR+2S?=
 =?us-ascii?Q?bEhHCq1RYz5Fhiidpal9LAZ4Azam+ZYz5FimI8bvjroVlMt9FzU3aFYLhk/X?=
 =?us-ascii?Q?nCmCLWfik1jznWVRAFash/msxZBtYf4V+9U2XFTbOWx6x9Ps9ZAy+SlMq7dP?=
 =?us-ascii?Q?szgRDAw5cXCV1HzCP0ahcLiClGSYK6Ww2wSGUed6w3VMNfB9V5S6wxSYpGsf?=
 =?us-ascii?Q?bad+JKZ5d/WHl9K5tKxyi147dyWQIRS6+hVQh9Fdlih1Ibq7rN8jQwohCWFf?=
 =?us-ascii?Q?+ekUptrx6i6fC7Zhn4Vy2Dx1M+WeXoAStbmQkNsGHuRDapGJrJdmSlBdbJQm?=
 =?us-ascii?Q?43WPLzfgBpKAuB/OKglTQbN5RWlxj/RhsyoQMyZ5WjDhXjZ7cuHD9ALO8txf?=
 =?us-ascii?Q?b5yFRnJ9m9I3wxeNsU8RzaHil4WpwjUXHbxg5alDaSnFoqSYnM0xMkt/pSDS?=
 =?us-ascii?Q?Kdyhn9U/hIqSmP94Fa1lwihy06yVsJtZ3q4B6SCCM+tekvcZs8eKPJV0morE?=
 =?us-ascii?Q?f07P3rDC0MpqMaXuOAOCWLsJwLK2AlGZ9HeU6ej2edsL5FhUzOz/HnO/0Zaj?=
 =?us-ascii?Q?+mLQIb5EkjEVbN6ZlDDIKe1PmYBjbVd/Fu+lIIyoHhTfEymrI+/pgXLZ8m69?=
 =?us-ascii?Q?QIwo4LDVZPTnieeALcRxpMlgtaoQ9sRpr31C554/vJaVFH74dM7PMoAdQK1/?=
 =?us-ascii?Q?6SRm0K0KYJ27H3Y6Ue4=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:48:50.0861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9c2fce-de0c-4c69-3b10-08de38039ce5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
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
 configs/am62x_evm_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index 4da668396d0..58e2daab687 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -39,6 +39,7 @@ CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x58000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
 CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
-- 
2.34.1

