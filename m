Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D12E68165
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 11:22:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 453FC83C32;
	Tue, 17 Feb 2026 12:22:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TXOlvb1d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFCE883D17; Tue, 17 Feb 2026 12:22:11 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71B52802C1
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 12:22:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY1V8A6I3GvSpzkH9wtK1kHurj3im7gwWQCiheNaz9qkITMRPjxOMX6tq6dLmq7RbLfjceag/XqheSp+Vt53xy7ngdnA5tNN/acqP9pjH8JJr4LtNrbwXTO+AwyHPDuMOPxRB7VUkz6heHfwbKxpxLRzOk+UweLTFdSai2G15Ss8UPkwRUrUgirNVK/F2KcEI1H/R3cvek9M6Jebhdkddo+HcTpfhiTD3Vg2qbJ4fINgFaUXz87w8/k0hf/2ky+dOTxlYxY+YW9ZmCCIOBh1+UqL9S/9DAEQspv+uVYpIexUjquJqxDhmRHoJdg0yOiHaafQlstkfCmdgbLUMU6nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIoOQ/ST8b+r0s6VQw4REJohH3/0qSaapmVMmCxb4Lg=;
 b=VrpmjVGlxwCQ/JqPK3nT3KaaW6QEquF0IiJUOH9AlIU8zAV2oVqN8YBybkY2oDA54+zig65Ud7qJratPj7d+1w7izEoE5Ruo5JoTWOjIZDIpdRVEF4kucns94SQP00XaUjD20TLuVegtuRagC5iCTwkMKArRNZMLwtlHQtMN0KabLO1i0OF+8Hki2vjK8btSHI8yAwNcGGo8hZluSkUD5jQ9SFV6dBAc/z/21OZSQEb66Lku5pd2ozMkJbnh3yV/HjjefkGwLe0UtSUQRSrG96qwkophYKYH0F/d+KBvxupess9Vmv+iP+gBXqWbLFhaNxprBw+6x+WXw6I3c70amg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIoOQ/ST8b+r0s6VQw4REJohH3/0qSaapmVMmCxb4Lg=;
 b=TXOlvb1dw+ii/LYBzwSu0tFTqcDetHqCnNbiL9Qvy5H1pt4pDZGI8BpC5S6l9NSxCQJHq7koCSk4DDi+0Bhym6/mSe8NiSW/lPAJXl0XTW6V9DZ0QEpx5+xPxPPIMtCI5KXamZ5ygQrSW2SByODqcuzJnK8bHdRFO/SRWWouQbc=
Received: from DS7PR05CA0019.namprd05.prod.outlook.com (2603:10b6:5:3b9::24)
 by DS4PPF715E13019.namprd10.prod.outlook.com (2603:10b6:f:fc00::d28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Tue, 17 Feb
 2026 11:22:03 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::76) by DS7PR05CA0019.outlook.office365.com
 (2603:10b6:5:3b9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 11:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 11:22:01 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:00 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 05:22:00 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 05:22:00 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HBLutM3263329;
 Tue, 17 Feb 2026 05:21:57 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH 0/7] OSPI NAND MTD load and boot support
Date: Tue, 17 Feb 2026 16:51:49 +0530
Message-ID: <20260217112156.272154-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|DS4PPF715E13019:EE_
X-MS-Office365-Filtering-Correlation-Id: d52d494a-d146-45a5-2515-08de6e16c5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VJGeXlc+DE60LpeM+o1pzI1vFvP4gc5K3HSkCV9m6hIyXjQ1XAP+Uo8JRZoC?=
 =?us-ascii?Q?hJSb7Imb1wlIUbsJfN7O5pASkIfieXDDh2oBHOboPg3S1sbDjaxBKuC9oybY?=
 =?us-ascii?Q?kzdcNokV+xxobrDVZ89R0k1spcnmM0t3BWuJNpXIk6FSL71YNYznJJ6XkMgP?=
 =?us-ascii?Q?arPPFKRI6iSp+WoBjdmzwZm33HAOi/LbRZRqCrnReaEtu6WaurhmoXkL3EMx?=
 =?us-ascii?Q?ZO4UylAHFaf7H26aV0MVHCF9OCXsEyWngwkn2lZ5oE4YnmmYP71LPOcTVSdb?=
 =?us-ascii?Q?WdPuf4CJ0KUiGQ+664hsnMtr8fNe8ATGLmW1KqYvHgCz5uHQ4n6AMN2mByC0?=
 =?us-ascii?Q?3FkdVyH+OxiY2vIUSvFHvQyt0JiKQCJvgbySsUfkmroCUZ8adRr0TiNhObXx?=
 =?us-ascii?Q?XmrqnZnyjXbIWzKG6UGPIDvfBoB1Hsim4fB80Qh4O7bmcvKf0lc6FmzJC/f0?=
 =?us-ascii?Q?dyBhHPdCRAnIo6EfDOEHuhjTUJbLIvEn21z/BFagA+GG9ClRzJnAFgndlx34?=
 =?us-ascii?Q?SFHaC9tf7s855OdM/MjXSUWiN/vdfbvNjK7H0fSNN2N+J+DMhE1+pLUTngHg?=
 =?us-ascii?Q?LUUeKaZBP3yhyCBljz3G4o/8wgF49MhDQV98NAVPZcoM6PPn9gqaBGbeiC3L?=
 =?us-ascii?Q?Fl6pdUs470UJMJRIZmtjOYprK7DfVqKZ1q6tru3pPNANI2PGRufeXs9mBSHy?=
 =?us-ascii?Q?JcKraz61kxVA/q2clpiLsaO4eAS2vLyzsIdTsVvmNeFVP1ylX4ISS2mUFVZ9?=
 =?us-ascii?Q?UbZJranDw4pavg7pCoExpj2LQPVyF9FVKYbAtNZk7Q7/FPF34OL14gSe5YVE?=
 =?us-ascii?Q?cpbiY/iZ9NQcmyDeAqL94SfEgTnp0AFSik1LXXTRMLfYTTtFPblDAYYbRamr?=
 =?us-ascii?Q?54IcjTNZAicULt46jPBQxLXkrQvkKrdM6i2+zjv0ITvYARvgTbpkZ6PSsBkq?=
 =?us-ascii?Q?RU5GGYdYgq6nxebAk8yDOqQAewuS1hGZHDvgpUznIicncn6pDj73ELpUOoBb?=
 =?us-ascii?Q?XMBEDPKPdjd/A19HLdNXHI9vuQ8+fTq/Ca/MvKXVszCDfRUlGXyERCwnrBqj?=
 =?us-ascii?Q?NoaxRU3orlMaujOjryo8mZcV/zXmKhZJc8n3gMPgZLPhiS1h4tk4XjM3Xc1y?=
 =?us-ascii?Q?gEkd9CXyBMJETci7/47M1oWc7TIw8vODf7G6v5D+v12oSzEM32AWrQVgGKiD?=
 =?us-ascii?Q?J6aD6fBI9FEGfxCNZbXRTbX6TvWUW0Z3RfXhuA+zNsz3Ql1jaILRJ+4TfHIa?=
 =?us-ascii?Q?P3qUTFubCU7GqeK8t3GE1oW5ZDWVBSoDH6Kfol0oZrir920qzsLq5URZQ2oc?=
 =?us-ascii?Q?kHGvrPbyJOjRwgKEzwERuZkc/cSMkasCDsJMXrQb4xLTfnzsqyDiRWOPPzs/?=
 =?us-ascii?Q?UIW8Kt2lXFs8t7FVY/ySzJxGu60husakaHTHeITSSWErmjsVl5BR/zJdQPhj?=
 =?us-ascii?Q?vD7JKgC1ZYLHwC+S/k1ihJd9tqCiZdg2LDoCytxW1fxmlehZTHDN0EZ0lIYt?=
 =?us-ascii?Q?9QOX5jG3KKShunfuD7SKwnqQOEILW0rPU2QD2nrQ6NSjyaSoRe4Iq+8DuqsO?=
 =?us-ascii?Q?kh91+YvETwiEgMMLbtPX5xzSOSdG7UVY6Fo94dDBfmO1xwnrbL2wPqONNTnV?=
 =?us-ascii?Q?hQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZZWQYgA27pCmyvhjgMWnhHhVyQRmLglQqzgGkZXtdIeXJiVTZG2cwaENzwouhW/buvPynORvd5E2F5l6pKh8i0Yh8l9vQUtSOMOl+zkcGGIBh7Oxf9zmwhriiZZyfIo5QYcm7SjTKuYbIyJo1p0pfHyqhAgR1wYlmlMrbsb8ulYYxzSKqFeWNlZcivHJGBQvwZRMvZgDj2IfANe18xae5Zw5CGYsMAKJeUkeWYac1FFJX9URG73uzzMUcwahbEXDPsu5IhcNlX7ADcDAGH5wVwMGrU5tGXy7PQiMs71Nf6Z+jT1vckggHkZ4i/aB1GIEXB/EIgcE9gjHhyli20hOJyTqy69GINbhmDnOXQTvILkEyMQ/ejmTJNP6jA3v0XfEfB1MTI6s4UM1OQSXm/lGUmK472UEZ3D09ChoKqwdQpExcqn1a4l6C4yxNqq5yh7D
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 11:22:01.7181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52d494a-d146-45a5-2515-08de6e16c5b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF715E13019
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

Hi all
The series adds SPL support for loading images via the MTD subsystem,
including handling of bad blocks during read operations and removal of
the MTD device after image loading to allow reuse by later boot stages.
These changes enable SPL to load U-Boot proper from SPI NAND in a generic
and reusable manner. 

Tested on j784s4: https://gist.github.com/anuragdutta731/e873fb91098e71c1613fb9a3472d94e7

Apurva Nandan (6):
  common: spl: mtd: Add support for loading images from MTD
  spl: mtd: Remove MTD device after loading images
  spl: Add MTD loading support configuration
  mtd: nand: spi: Enable spinand build Kconfig option for spl
  arm: spl: Enumerate SPINAND as a boot device
  include: environment: ti: Add ospi_nand environment variables

Santhosh Kumar K (1):
  spl: mtd: Add bad block handling for SPL image loading

 arch/arm/include/asm/spl.h   |   1 +
 common/spl/Kconfig           |  30 +++++++
 common/spl/Makefile          |   2 +
 common/spl/spl_mtd.c         | 149 +++++++++++++++++++++++++++++++++++
 common/spl/spl_mtd_nand.c    |  35 ++++++++
 drivers/mtd/Makefile         |   1 +
 drivers/mtd/mtd-uclass.c     |  12 +++
 drivers/mtd/nand/Makefile    |   3 +-
 drivers/mtd/nand/spi/core.c  |  12 ++-
 include/env/ti/ospi_nand.env |  22 ++++++
 include/mtd.h                |   2 +-
 include/spl.h                |  18 +++++
 12 files changed, 281 insertions(+), 6 deletions(-)
 create mode 100644 common/spl/spl_mtd.c
 create mode 100644 common/spl/spl_mtd_nand.c
 create mode 100644 include/env/ti/ospi_nand.env

-- 
2.34.1

