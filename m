Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D22CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C7A284150;
	Mon, 18 May 2026 10:23:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dn7LzXle";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AB48460E; Mon, 18 May 2026 10:23:03 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71EFE83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:23:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mORVf+dkKczuv7umaMl75itBHiEiso3Big/UMiyA44JZ/p2+qd1vEUMIu7K+T8tT7YOVcjS6FNZccrZsIqWiKjS509S4ZfgNs6bM8o0JJAokeTHjonqayUUGA6S4aw2srTyM/6L9HpDpmyiOAIO/PNx/XAhDIwqf9pUEtF16a018pkVw9WhfWGfURBSF+z/7vXz0nU+QX3SXQ+BzbazQGNkpGWt3T8jL0THzCnUrZdGPZ/gNXERO9HaYxi05vu+tXdpLWWqKVq4coWCWwNZ98RwOZAuLeeQlJKiBIFglDMGuvGt4Gp1w7HrG6/a33JH0OE5dKilMvI07RfqcQlElzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvL3l+lpshHbb0jfMV6vOdE0b8S4weuRWvbfAD4uRas=;
 b=CtVjLVBjXnRUqyrnKWRR3wn8tW70V9c0LU5JN5m/nFmzmtfAnJDKGt7Tly6LB39wYPvOODzAFcoUB1yrWWZkHtppbCWIenCrW504UtYxs47kRWUwWXbvzSGgYnh3c1SBKLvY5hRJrEHUgCBM61+Z35csV0pJrkHfordpfBalF4K5hMHH3KTSms2ImQKjJuDN8S//Rof5nN5W/LelEtjgHvCHc2PYrYj3k27iovumf5jg+fbjcLo6zGwjIY7WHvN4QgDx6XTvftryEQLxul318581CGXDBvBEdNmQM9vS4HMZcyQhjv/vnQEg8t/hk+GCmQ1ovnbt8//4Dg+VaUtsjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvL3l+lpshHbb0jfMV6vOdE0b8S4weuRWvbfAD4uRas=;
 b=dn7LzXleb6042yV/tysVSRVVo65KWpqZaKQ2As5+iD/FuW6+ChINfAup3yS1lXT8KLPhHgi8MYq5u5sArUGvJ2IFktE4RUlKBa7YSyhXOn2cWd+varTrK7CXnGl9khYA2QKJyW8ztCoLejVOacZedPp8icc6CxyqS+HHYg2PrfQ=
Received: from BYAPR06CA0010.namprd06.prod.outlook.com (2603:10b6:a03:d4::23)
 by DS0PR10MB6200.namprd10.prod.outlook.com (2603:10b6:8:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.13; Mon, 18 May
 2026 08:22:57 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::fc) by BYAPR06CA0010.outlook.office365.com
 (2603:10b6:a03:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Mon, 18
 May 2026 08:22:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 18 May 2026 08:22:57 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:22:57 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 03:22:57 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 18 May 2026 03:22:57 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.72.233])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64I8Mtj31478865;
 Mon, 18 May 2026 03:22:56 -0500
From: Anshul Dalal <anshuld@ti.com>
Subject: [PATCH 0/2] Update envs to use Kconfig values
Date: Mon, 18 May 2026 13:52:51 +0530
Message-ID: <20260518-env_to_kconfig_migration-v1-0-24c8fba75ad3@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MSwqAIBRG4a3EHSeoRVRbiZAef3aJNDQiiPaeN
 DyD7zwUERiR2uyhgIsje5dC5RlN6+AsBM+pSUtdyUJLAXeZ05tt8m5ha3a2YTgTEgpqrEuFRgK
 U+BGw8P2vu/59Px93H4tqAAAA
X-Change-ID: 20260320-env_to_kconfig_migration-1e1b841e90ee
To: <u-boot@lists.denx.de>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Anshul Dalal
 <anshuld@ti.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779092575; l=598;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ruu4GIGmqnCBE4pQrdL94AqU0TQjz4MN9+MYfGQM18U=;
 b=f+rOEP60LapI+Tkc+X0nhsIrrInKBK1daYQgFVQHJDf8N8vEFf1cDfDdWhiPtht5KqQRk6SDz
 JwkJMent14IAeJVNyHzr3EVIHeldsP5hmPtuDa0lR7YuXl+PaveGB6l
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|DS0PR10MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a0eb61-cae8-410f-cfe5-08deb4b6aae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: BLSCZy0qq1YgYpFIjGVSlO5gE9lUy2ePsutnRJ3nJMNJTT7zFTGpE2h6DYciaI7LJCKRAhg44bDAcFTl+N8vOLPRL9boKtxnXIFJeVje2YgymMVWdECXKHkg8ndwq4oOql5ykOcTzL4LbfhEZOgFW+RIlB81MPACE9A3M6T7Ivx0EUNo3za1vt9Wh28TokQb91EtLA8h6vMRqqiBzkWGanKxkwynfhdIzNNzcof9tW7g+Lsv4+KL+RIgEOdd3nk0Ky/1OuabklWQlwCwPwUR6GHFQYygVyTjmHi3oiyJ0jg89dqBLiOuOV4wgGi3dcPm+eHhfB5XcLXPTNSwuNj9LbXPJVg35lqPOy3qkXdvg5TT+HXrKuYikmrjXhp1H3RzCX/fKXcVW4sZcKciEp8M4S3o6pqqtb3MNCJzXJucyMqfP/nP18ybsz3pzGtWdc8xfTGLVWPqkUpnhW8yK0VXex264wwfMUI77T8HfqlnV8vJsa93Y8PFiSlcNNiaLpNjW+Rdwc2ZU1BF/DIL2c4CnGFxGkCviWRgHtHjmCff1BOgVZkTq+p3Wic2w9n+50D8XFTKDUTGIAExqxwxp67ESOw2DmpX3TCSrccXE+mhY/8xh/JFEEBRKLQAFNi5TEwBiAQeuBhdiEW9kvscDrMXNt5wSHJ6UQLwCA7O5FfToo60dHMz/MJrLcYP4iGNPbWMUi+VuAneQFyzf0cDAyBQVgqDdNOKB629qBxnsmPHGN4=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wPqZgVDF8wXv5VrD73eoUdSqREpwE+lSSztjWZI7HNZYG9iVXzC6wKSG+xpolAfZBojRYxOdE896xY3jswxj9OHCbgjENTx5pGtYSZn2ciyEL6IU1eCL24CQw/zVS0MaSHz7nfgdBATCFcTSTn10W/JVWaB59bp3eo2K696KjIMY3h8jW8g9yjKiT8ZcJ6z/K264A+jF5XOEeiE0DVmj1R5+Yn9mtzyBQomJVjDqz6fTEI5+Ww/sCubDP+37rcZhP/92E9HuxJ1uE7v6JRmmOsIwnITmQYxCpA+XIJXjQ8IWJy/E5OAfqihAFBy2MiRyagvml7VceV3njOO4XLTkV1L7G/sqk/bCJH0zyWRmiPvtZmSpipF1KfBhwiRAfmfruypnab9RI2q798VgDRDltw+G6e0Jzf+Peg44Ct1wgUIdaRTgTdlGi2q5iosNdjsj
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:22:57.6391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a0eb61-cae8-410f-cfe5-08deb4b6aae9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6200
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

Some minor fixes to K3's env to avoid using hardcoded addresses but
instead move to Kconfig symbols.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Anshul Dalal (2):
      env: ti: k3_dfu: load only the next stage binary
      env: ti: k3_dfu: use Kconfig options for addresses

 board/ti/am62x/am6254atl.env | 4 ----
 include/env/ti/k3_dfu.env    | 7 +++++--
 2 files changed, 5 insertions(+), 6 deletions(-)
---
base-commit: a6f6947e43fba91de3ec5d0390eee7eb1a6a80f7
change-id: 20260320-env_to_kconfig_migration-1e1b841e90ee

Best regards,
--  
Anshul Dalal <anshuld@ti.com>

