Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAFDAE8FDB1
	for <u-boot@archiver.kernel.org>; Mon, 29 Dec 2025 12:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F4983E16;
	Mon, 29 Dec 2025 13:40:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="HIlcCdzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B099183DA9; Mon, 29 Dec 2025 11:49:00 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FBF583DA9
 for <u-boot@lists.denx.de>; Mon, 29 Dec 2025 11:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/Qnjrl6x1CpQRTNXruuZ212/owyxCsEn+cj0QCmPna+9/mP4MQnUKM+IDpcVhe62tgEyLn9jQBeY2vleoRukzlHcTEmyq6BAILgqk5c7azQW13oxOyzo/L90DLcq6PWgE/ID0L1ezy6Cbb5ugGj0YYmUVD64vjZuiiMP8sIiDxMAUqJUgko4OvaGneUe7+AIBY+XHMoxT+ZC9kcWgNXKJ7H7BuevAuedEQhvWwKNpOaDxM/G+cuikFIT5qHjziTlwIo7Y48prRQgtsN1q3yjI/U5XzTC0NWJxHYWhGLAWWsCMeUhYkRmzR1/jNc6YSiqtXdAGIr/tuf8cuYOGGdkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mcNU5+zAhkPfrTHcheJ2tOXoS8tLZyk86Ou0Ild3e4=;
 b=w3ooX36NBTWF8HS6IU27QsYF0OLlkK1nrvUFWUrQwdUrtkBv4BChkjxIu0iM3nqb0Z188/zYF+qOOkhBgakSuitgZQ5Hyj9xqonir4K79q+6ryTDtoreE/t3OLc3HaXAqiOJ2VvJASuluDJ2bq4Y54nOO3s+Bv3H0cywZDeLdD3SygxvGQd7tLWK79BPxIfaSFI4nVSUOqvNzy3Hzx70AaUM2ej3JTJXB//6CkTt4B2MTXCNch2hqJP0uZujTBUpIcpYGdHWXjuHzKCrDbRUPVO/F/sCbVWQ5kZNVccGhfMlw31cGzUMpu0eecd+ajm5izFDIx42HN6Lg3+DDCXbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mcNU5+zAhkPfrTHcheJ2tOXoS8tLZyk86Ou0Ild3e4=;
 b=HIlcCdzYQ6zAF++eDKrIwb1+3k+PYfXBNUJkB4e8ODRFDIDWv9yHgM7xSIV8yxoo5h7w8vOM8KbezNvNbpgusVicrDRtnu5yrv72+a5IYzP0CifnSyR+ipu8mYL/rfompbR0YFaxpUmDzMc3RM6R4d56QQgLc/Bnn2oMTFgMDiH98AY/yHxwowi1gi15mcAbkUYIXf4OddmSNU+9GOgaBNWSeojDOSEXFPBu+by5q/U3L0I8pmJjuSH0zN+udVWSiH9BtEBZVmUf1/2ZLSzDutzt1sy9O9AsHPKsg4oY2l1Xvf1uD1Nt72/wSmixAx5qdLZLVYeyqcoocZYJUAgAlQ==
Received: from PH7P220CA0159.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::28)
 by CH2PR22MB6020.namprd22.prod.outlook.com (2603:10b6:610:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.12; Mon, 29 Dec
 2025 10:48:52 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::d1) by PH7P220CA0159.outlook.office365.com
 (2603:10b6:510:33b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.14 via Frontend Transport; Mon,
 29 Dec 2025 10:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Mon, 29 Dec 2025 10:48:50 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id DD6A5DBCE0;
 Mon, 29 Dec 2025 12:48:46 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/7] Refactor i.MX IPU driver
Date: Mon, 29 Dec 2025 12:48:00 +0200
Message-Id: <20251229104807.3104-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
References: <"CAOMZO5DOUE2PexcBcVcg3vYTo5eV=LT3=S9cSBosLCyir8Kw5g@mail.gmail.com">
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|CH2PR22MB6020:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 23ed4343-6d18-42fd-a20f-08de46c7da6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y34apoN9m9vEKCH4OOC/LQDqY0s1AE6xTtYMMLp7uCDqh04HvRhkx9No8+d7?=
 =?us-ascii?Q?OZeiutjAVzFey0uht8zSgjCgZjG/E9O/wT3x5fqmqd2ou2FZHtcFJikP70So?=
 =?us-ascii?Q?JW5EKtUWdoTbj39hrS50P7SKwfeh370nJmwooz67gtGSOE629KagTMZha4fI?=
 =?us-ascii?Q?W/JmEbepWgzxGm+BagXC8bUmUkoZwubi93ZizqqTVsGasFF8hn+KIPYDZbdB?=
 =?us-ascii?Q?fcDvGiLvLv6VjcqUmDVbU2soBbfqrzqW1gU4lBaWsJSoEyeZqgqdTSjlLUVM?=
 =?us-ascii?Q?B3sqUdCJfUSpfU/6kEcBmUOU/lDixSBISHkqamJvtBEZwaFGt17rxLhPMSA4?=
 =?us-ascii?Q?PcUrKkk9UzqBmuSx6FzDAKIfCeCDkR7bM6OOrdiV2Jzfy8FXLCah4o7mY4/x?=
 =?us-ascii?Q?XgzSQHTjQMC61APHf7vsehTJeEL2sp4trWjLW6gJAALMG9Y3kp80Lp7JKX6S?=
 =?us-ascii?Q?uhg0kw2ZXeBhedLMgIdEcPFfZmpD05XHT/EztfKlWy6dzdqXwKYpmEbMym1v?=
 =?us-ascii?Q?zYin2x+5HhC3c88/vkhWYMEm//+C/hJpRUTkURiFj5QgdLZMa1u2aFJXRITQ?=
 =?us-ascii?Q?obUlfGFAF/uXM6i4vVAxqp3QI8zpaZ67BBS1tT3kwoX83DEiR922RaNMVS9N?=
 =?us-ascii?Q?Pw3zas9VkrosxiahVHs6FYQsVaIhVL7SmZwDLCmSrweraEDX8joHATmVfSxA?=
 =?us-ascii?Q?PX/zKSW8t+hWXc/anVy/CVTwKzmxA6DgV4keI3VQeIBSoC/ueb6M59WVjjA/?=
 =?us-ascii?Q?G8a3EwN2xu93JEi3OjFTpyFRazidY81nOj8FmZVsByRI8XwgoqaJuX/IjJTg?=
 =?us-ascii?Q?XT54OB78qTrm9Qea78yqzLZbtzjbt3jHAhW1KC69ecTa9iP2fO/HTZ3CahEk?=
 =?us-ascii?Q?3DJv+c9pb+4VZB/T2Qo+uPGs64au61y9qgi1yrdo4AxRrs/wyLTuQUC2ppED?=
 =?us-ascii?Q?faO9MiLFDC2avUzBEKGavnwnk7H/WVqHhr1gyGMSdwhaAsxpXLRx41/hO8Op?=
 =?us-ascii?Q?RCq3UUEJHIruH2UQ6Aw6wcXEY27MoL13Pepw/y9iBEPgtS/timLVyOlL+cpS?=
 =?us-ascii?Q?RSMAqUveQmuhr8l7s7ahQI/I25upbIHGRLdGT1SEiXx29IBr1Mr1t+VN4zIU?=
 =?us-ascii?Q?qPsgcGlYjDrh/25OZiHK8KI2sbFgW7LS53a2HpDtD1WC+FpKvqwUvyS4qivd?=
 =?us-ascii?Q?Mcl+/Vk5d7aMpFiiOU6FW+eWqaFGJ/ezZ7C1yIh0+XN39iXCqAjLS4jmKl+m?=
 =?us-ascii?Q?rNRgkX00lG5y6t+FEDS7krAvWflM8InxzdeWZ7//XkbfMHC8xSLq+S/Jh+GX?=
 =?us-ascii?Q?/SmKNMVO4w+v0Wbqmg+OXSz0dEmuurlQoUh+Z5s108TaxZmJo8YTowJkrmM5?=
 =?us-ascii?Q?foARyHfIh5q947Nz8fcb3AReRSD6YXhJ+DcgU2HHiTOOA8D7uSCFg2NlH/BE?=
 =?us-ascii?Q?YPK+sWjFBwS/c1hwE7mxK5u7hF7kD/DTf5u9+IwuMRoaVmzIA3NvIV48LIUy?=
 =?us-ascii?Q?f6uLp0yOIqht7M3qyjA903ctNgBBQeCAPORhDrgLhADMYk6chUlpiWIesP1T?=
 =?us-ascii?Q?acXzgFTyyiFrklNBZRs=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mkerelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 10:48:50.8609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ed4343-6d18-42fd-a20f-08de46c7da6f
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB6020
X-Mailman-Approved-At: Mon, 29 Dec 2025 13:40:49 +0100
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


This patch series is designed facilitate the porting of the i.MX IPU
video driver to use the generic clock framework instead of relying on
its own clk definitions, which is known to cause problems as noted in
a prior patch series [1].

This brings some much needed clean-up and gets rid of nasty globals by
instead utilizing structs that are managed by the driver instance. This
approach resembles the architecture used in Linux.

The changes were tested on a bx50v3 device, which is powered by the
Advantech i.MX6 Q7 module.

Let me know what you think!

Best regards,
Brian Ruley, GE HealthCare

[1] https://lists.denx.de/pipermail/u-boot/2024-August/562204.html

Changes in v2:
- Fix unintended spelling error in comment
- Fix unused variable error

Brian Ruley (7):
  video: imx: ipuv3: remove undefined function declarations
  video: imx: ipuv3: apply clang-format
  video: imx: ipuv3: prefer kernel types
  video: imx: ipuv3: fix camel cases
  video: imx: ipuv3: add names to clk function identifiers
  video: imx: ipuv3: use CONFIG_IS_ENABLED
  video: imx: ipuv3: refactor to use dm-managed state

 arch/arm/mach-imx/cpu.c          |  10 +-
 drivers/video/imx/ipu.h          | 222 +++++---
 drivers/video/imx/ipu_common.c   | 841 ++++++++++++++++---------------
 drivers/video/imx/ipu_disp.c     | 752 +++++++++++++--------------
 drivers/video/imx/ipu_regs.h     | 270 +++++-----
 drivers/video/imx/mxc_ipuv3_fb.c | 277 +++++-----
 include/ipu_pixfmt.h             |   3 +-
 7 files changed, 1200 insertions(+), 1175 deletions(-)

-- 
2.39.5

base-commit: 56cac250b0839ddbad1311d3ca4231f532b5aadf
branch: video-imx-dm-clk-fix
