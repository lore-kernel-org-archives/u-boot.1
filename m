Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66487C3ABBE
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:17:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 145B7829E4;
	Thu,  8 May 2025 15:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="s+CpS4cG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044A28212F; Thu,  8 May 2025 15:16:54 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2070d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::70d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 046EC82905
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFE8rli+G5CXQ7IcjWUeCY7Bp4qb3y15x+LaQzp/yMYMaW255PsxduscrvH6ftRKdgQdWC6VckQarVnzOdwk/HYIe5Q/8FEusgQagiK6YLmaKiZElLNJfHd0WL5YNnQyFAwGI7ikBpBtd0sfpS6/G9Hb1q3GvrS4F6tbdDxDqdOsTwSRNeRWbM5cgcQNyvZQOtsGxpcg+aTa6C6yFuZ6ALt0X0rg/5uK2gzimEm1a8itiMBtQlBbhJMDcCOZiSf8gHDpi+Lv4H8j6Dh1dTSTQBN7dIVbg/1MMYSvcnDN56pGMyjlWwATwQR7xzud/ge+JEFKENe1oOFbLuw9itBIUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2oH1T5S/HylFU2Qlk12srS+xw3i9zNu5mqsNXfnMHE=;
 b=KUf+W8d/j+gTOHqubL9McsVlXNQFtGPtUkS15Wq8V0KS8IXXlWlNrrZBwLGk9ZKP5aDQRm7iCxHfaVhyn5+jZqZBszTO0146xKQ11AQhbC/opO9optoqLTR3swQdwOUK6jex/2qc453wSl9wlTQjhQLhqcOZ0tjTCPBNBx5Hcu84L6p2xa9Z0amQtE2te4obK4glViZf+NRji7tOF8RLiKla2OZ3uYiXsaVh3pvzc7YW9/Fm93BVpg3M0sSJ48gXoO5zG2XbGVuFu7fQCE/PmhOSWpaq8nn3UeF9qKVduahdghprWYzGjLWaFoOgRi+P0Rx8If7NvaQ3HhwhlL1d1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2oH1T5S/HylFU2Qlk12srS+xw3i9zNu5mqsNXfnMHE=;
 b=s+CpS4cG2Tl7jf9xCQNd8aLs88AxW/oGF51/uEpoZ9dVVsGsEuz49KG+7TAVIwJm0ZDQkucu/WUB7hxly8gd7VZuG0cf96cnKIdmL+zod4B1fBp5tDZifseoA7/4cPu+99UKyP5axS/fCPtZt1GrHmXHkF86Uwj0/oFBa5TgPbcUg+O7QVzkxBqoPcXgWib61mOhi1jcEEoRV7Rpp4MH+RZACBv0POzI1Ztlnw75x+FQmMMgTvo47Zc02Yr17k/LVwv7tbYMvyYw1prLtC0TnvOpOK0InVmDgI6pYUtLOOUge+X7FSw0Zq98XUpaShiBG7/b9UfOQ1S7r8kttEcqfQ==
Received: from AS4P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::10)
 by AS8P195MB2164.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5c3::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 13:16:49 +0000
Received: from AM2PEPF0001C70E.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::4a) by AS4P189CA0006.outlook.office365.com
 (2603:10a6:20b:5d7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Thu,
 8 May 2025 13:16:49 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70E.mail.protection.outlook.com (10.167.16.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 13:16:48 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:16:48 +0200
Received: from phytec.de (172.25.0.51) by Florix.phytec.de (172.25.0.13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 8 May
 2025 15:16:48 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <trini@konsulko.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <tudor.ambarus@linaro.org>, <joe.hershberger@ni.com>, <sjg@chromium.org>,
 <d.schultz@phytec.de>
Subject: [PATCH 0/2] *** boot: Add Kconfig options for script-based boot
 parameters ***
Date: Thu, 8 May 2025 15:16:39 +0200
Message-ID: <20250508131641.2561876-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70E:EE_|AS8P195MB2164:EE_
X-MS-Office365-Filtering-Correlation-Id: e747892b-9484-4bb2-7a5e-08dd8e329700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZpffaZpUNJP1BqpkTqENAsnn9EZcVxZ5nQAXGxs04qMhiorv0Y1shjxRNgsy?=
 =?us-ascii?Q?fwbWxyWaaLr/2pU4bmwbobmyxp252EN8U+yPY0Bq1pzOfZAdBUOhIqN7rvfM?=
 =?us-ascii?Q?PYrBGJkz7WIg7p/Cp7yRxJebadOj745ia6Drceaemzh59nFLbeAVtnutbTCC?=
 =?us-ascii?Q?NayfDj1jS5i7+kPDzzJeznzuB0rRMaOPN7a7OouW2Ie5yavbRWhdiZkJT0Pd?=
 =?us-ascii?Q?SxvdtuAyFb9xO7JCEi4vllx0494FcCc7qm6y8LsJbRmqCA0gj5YXSeSG09LO?=
 =?us-ascii?Q?7oR/2nSbEx2JObfRbFOBSdODl1+DvCPSulTg/GimoL2EUvdPIKhfFO5N/rqI?=
 =?us-ascii?Q?YIk3ZIv0qqYhJoM2mxc5potwihkNQJSaVD6gMdyPmeMc5K1E0vBI87AMEkf7?=
 =?us-ascii?Q?QO4GViYQLVqF+WaJQRAcI+qJ7AwAoUkCyxznPAXy/vv1AduKyor/izklmrFf?=
 =?us-ascii?Q?vvPNpXH9SnlVuGYmqRIIPLRWQjabb32noBqQq+S8DwO07yz/qG8hQmLrl0tT?=
 =?us-ascii?Q?LUqrjKWWeGWDdl7lqJb03/kl7gMcvAaGDZDApcu6DeOYU+yXS/WeUlPhNBw3?=
 =?us-ascii?Q?IGjblj200axUrUINsidyfiEwpMC8NjCePuyTLSDbtVYg2/ThEvDNOYJQttTZ?=
 =?us-ascii?Q?Ocyk0JHXgvS8iayjIz38ISByhmOzUqoe6YZDHfOzDlBuXML7hYXjs9zwNNCH?=
 =?us-ascii?Q?ch/vzc8Q36LmeBVbU5i99Wfv9fOlVWIIIT0uOKhgBXWFPWDgTvTefwC3rTMO?=
 =?us-ascii?Q?DIdr95ga3JfTACx0v+FBSsATrq8MsySFC9qfOpLvE4Gm4Mso7F4NvMiQE9eH?=
 =?us-ascii?Q?WshyRzBS+KZvuLg7c0N7ZcOhfVt32Bb2bDxS6RfX/r5ILhgCdAcJINE6aD/r?=
 =?us-ascii?Q?UWLPcYVWFlj7xz3FQC8TxfhqkNKgj45yrkFZXGZi4fG9HYJEzyZeGvwWf5pj?=
 =?us-ascii?Q?D64o+CADIZY6G7Wv9t8FA8oEPxRTgp97yDE14gpphEvVO1S+js8sMP6vT19A?=
 =?us-ascii?Q?010rYzr6FArA9OgEkXzWR6mVBLpgODB+zaiSArAj/uDyuAIoqLV6Ls9hSCuc?=
 =?us-ascii?Q?jPDEcZSDWrDkaegtiZ8zukQRB0GNCRIO9amqBovnJxPR5bgOGPBvtwW4f2lA?=
 =?us-ascii?Q?urMFlI1/RDOqaIvx4S876LRaPbRD/46mbCwdPxxjNKsJBNeWaiRH66aWsRc+?=
 =?us-ascii?Q?bl5AL48x2zEowMLIiKL39CUGhgltR8Hy3b5u9u21PMRq1Om/KblVLMqSiFxq?=
 =?us-ascii?Q?Ja7PEXnpSc/TvNN1TDdMkpZWoY6wCd5j6VDKhA/thqSuRB1SjbkpvkpqJCaQ?=
 =?us-ascii?Q?0PclK2JHt00kznCjJq3BofVj4xJXmPsdgjKBSW3zRehknLbZnQLnwh5SyChg?=
 =?us-ascii?Q?1dxqN64qeB11fy9MIWpleac0DvpUji5s0UuLCV3IF/u+wH0LCJam0PDJt+fZ?=
 =?us-ascii?Q?a/8YFHVOgVDLVDm7k52Y+lWgshQuYMIGmxPq1JKUF7GSItslX0oLmxa4xEb8?=
 =?us-ascii?Q?DtBi0mLnt59g7RnIeH/IAGajR6EZ8nJaU0AR?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:16:48.8878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e747892b-9484-4bb2-7a5e-08dd8e329700
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70E.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2164
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

This series introduces new Kconfig options to configure default environment
variables used in script-based boot scenarios. Specifically, it allows
setting the following standard boot environment variables:

- boot_script_dhcp via BOOTSCRIPT_DHCP
- script_offset_f and script_size_f via USE_SPI_FLASH_SCRIPT and
  related options

These changes make it possible to define standard boot environment variables
directly via Kconfig, allowing higher-level build systems like Yocto to set
them at build time. This avoids the need for post-build environment patches
or runtime overrides, improving reproducibility and simplifying integration
in automated firmware build workflows.

Wadim Egorov (2):
  boot: Add BOOTSCRIPT_DHCP Kconfig option for boot_script_dhcp env
  mtd: bootdev: Add Kconfig option for defining script parameters

 boot/Kconfig            | 18 ++++++++++++++++++
 drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
 include/env_default.h   |  7 +++++++
 3 files changed, 51 insertions(+)

-- 
2.34.1

