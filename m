Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E88D6ACDC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 12:14:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BA183E3A;
	Thu, 18 Dec 2025 13:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="L9VwoW3c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0188483BA1; Thu, 18 Dec 2025 09:33:46 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE1183D2E
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:33:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=gehealthcare.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Brian.Ruley@gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuImlZ4nXs2v2Dsd4Bo5cEoCrky2eZKiiebRt5hyz3KNvqiRlEkxcD+upphQpU2PijMBgiK7kszNKnE3Fxk19aZsHhb3rSbUL654nmt2M7te3M86coXv8hUEe5kjDjKqd3eTdKA9SRZ6b+aMxNi/kwOg6JDPQ+OTO/lVrvFnQTJm4KsFQiyWdUtM7LuaTMFa9JREZqgHmnmdKDOzoPfjEaxJKHiapFW/oA/WhZtyMVdlaQYc3KmzT6eKVsfH7pKOfALIpTAmE8BBc73ko9MZoQsyHsk9jkvFtYKusB5xAaCWZO4Uozj2uqDRS1zdc1b3cnjfgEdaG3PQQdmqO+fD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4P/9lRJBNPqHAAZsZJm/IAiKeiRPqvOexwoqWzTTSig=;
 b=wW7cuVJdZyyNJRyVTxIIK3kf1T2XfMlaa8WPlZejzPK4EZlj8DrB9a1Jo+TeBJGag4w4A9l8LH9YvHAxqKUU/VYNOXr/DLwVw80DlNlLMyurh8rmUf7XcfeQN5V+qrBj1ckQl34wVEJvz6q2Nxo36n46at82LUaA+5Ko6LdlbKOOxscZ1jG6QoVTKcajx3h2h2NZclUVC1TCRwqB/xMc80rPbvnlAKqhBCw0+JsFHG/exHuhEhp/Hix0yCLAsx89YW9ET6CicjI7OnnYUfDxFK/PQ23mzb98wt1umB6fu0yp7j2ZYGmzFGm40ceOyX4iol3TPGDFVl571De8h7IL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=lists.denx.de
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4P/9lRJBNPqHAAZsZJm/IAiKeiRPqvOexwoqWzTTSig=;
 b=L9VwoW3cYDXHR3vnTHfym5pUWGCeLdjK0dsoIzoGXZh0vtEvz9DKc7L0H+3P8U0aSUXSl2V3nsednpOGHsqyIydtQBhc2S6atFC06T+elReZKa7/zYOliT+YWCaMIUCcI6NMB7i6lOAC+y3zKla0fqueOxT3apM+wQqg8xK2Vu3lHZ+zsq6U5rgRJmYuNDnP3GN3edE/QWDMebktmGy7uVNvgoA4zQfDu4x+7x+xbZ5ajyEeoPTwEcaRm3EDrS17sCVgj1vuswkVqVsO0KUnoYljloUbXzA46ApQQrEakkco+RUcR1ug3ku+neGgNJuSAlp/ZNXWsHQM1yIvc1G8mw==
Received: from PH8PR21CA0020.namprd21.prod.outlook.com (2603:10b6:510:2ce::27)
 by MW6PR22MB4322.namprd22.prod.outlook.com (2603:10b6:303:24b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:33:33 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:2ce:cafe::72) by PH8PR21CA0020.outlook.office365.com
 (2603:10b6:510:2ce::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.6 via Frontend Transport; Thu,
 18 Dec 2025 08:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 08:33:31 +0000
Received: from zoo11.fihel.lab.ge-healthcare.net
 (zoo11.fihel.lab.ge-healthcare.net [10.168.174.93])
 by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id AB725D9C01;
 Thu, 18 Dec 2025 10:33:28 +0200 (EET)
From: Brian Ruley <brian.ruley@gehealthcare.com>
To: u-boot@lists.denx.de
Cc: Brian Ruley <brian.ruley@gehealthcare.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 David Zang <davidzangcs@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 0/7] Refactor i.MX IPU driver
Date: Thu, 18 Dec 2025 10:33:19 +0200
Message-Id: <20251218083326.644326-1-brian.ruley@gehealthcare.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|MW6PR22MB4322:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: be8fbe6a-d554-4246-0573-08de3e102040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2fLWvctgoGoJQ+Ao66z/wR1pGAXwodVW4yX255uIJWiqULyI3hgoTr+8Jm4R?=
 =?us-ascii?Q?wpYwL8MuKYMYgpSTXMgw8O0Wl7TqnTpcPT2P4sqh0ov36gdtfAZ+h0BOCof/?=
 =?us-ascii?Q?MOnnnRbSZn5d3LCg/O3TUFzFkeHKuOLywHWazX1xCNfBZgPGVFHMXBA/Wg8S?=
 =?us-ascii?Q?cD3M9fNdFOf2zqaQ4DL8g/g1d0Ve6dCriddTmViOeaM2R7Om8ydNlfz8Ci44?=
 =?us-ascii?Q?fiZTKrPfPSVACFHl2VY2xo9eof4oPV6tBVThUml7t/ljY4Y6wytumfXdf0cD?=
 =?us-ascii?Q?tmwwF0PiO+1kEn1Jj7ysv0nD2WpOFwsyTQJLF9GZ2kQBejP0mrTGOXTcyTgi?=
 =?us-ascii?Q?ysROR7miVO1WHl6Ju8YfoPb33pYDkSqOFdI5nbODqxMWUYpyUJ20amPSrExU?=
 =?us-ascii?Q?hmMZkIR/V7uhLfQxTSIRMudzwgVNuyqmyOzt4drK5czojmoYa9yYfzHULH+E?=
 =?us-ascii?Q?c3N8avGO8zph+1+RK3Ftw0rnvm2VNsJQBhTgD4Nd6H5fMBn1NYao1d13Q/Aj?=
 =?us-ascii?Q?jkTFkvL9ltkVbdpGkUfNYCL/2Nt6pfkXSAdMa49oJG70nYL+iCypsPZIdMTD?=
 =?us-ascii?Q?whO9brC7YQQcU6qPPJGCdaoPPpjp4+oX+HFdDFkBIPjsNjst8b9mYU/CbjbV?=
 =?us-ascii?Q?ha8JnHXFIHaZYKW9eMQ8p9zO66/+3WRfAcCsKzrZodVG2WYkUO11IhwBILue?=
 =?us-ascii?Q?O8T1bwnrueSZaL7WuGylPyczxIElcpjX2S5i+or6tsyU6YpWXQnQ3DaE8v3o?=
 =?us-ascii?Q?JKlxpHy2Qga4UjD9jiAMZbYlbgRzNNRgLu58zp6hVNlbEiKaLqWZiestcf86?=
 =?us-ascii?Q?8H2j8Yz5M+lYW00yP4XvY3Mxek8d6ok86303z34KoFu6xSM/tNQHJM7ISC9/?=
 =?us-ascii?Q?inNFO+PGJ0mS/LIaCgTuLbfZxbNbV37bKcJw1dfmVBHN7HBhTE/MYqw6h78i?=
 =?us-ascii?Q?6EtgaVCRocEkSJ5rRXMIvtEN0X6UM7kCfeM4/60OJzucVSYSdKF4GSopPf9N?=
 =?us-ascii?Q?18VyZB/IJSA+M0sqnORRPM4ddOiYpo8TTxV0OApGFUMKzZWUwOpIeBMPgD0i?=
 =?us-ascii?Q?D7Q4PSuyHj3QqFksCC3qt1gvUhUkuUAqXYW11FqEvpOzivzidSu/YIWiPh4n?=
 =?us-ascii?Q?8IKcqyWGc1o/H8n2uahc5KdhfV0K703L8n4FeqwdpqUkLjbszSPwUEYyk8Sy?=
 =?us-ascii?Q?Ma3jlknU8NDAw0VBiE+plB2a/3k+4kA870MvNwtbDZSExnJdpxH+xLAMnkcY?=
 =?us-ascii?Q?g4IKHHk4vaD8Biu+bR1cpcsLRHMtBXGdideBQaSWI33t8uzmYDd8euHcW68N?=
 =?us-ascii?Q?S45Js3qi4nmXS1D5s654Feh4cINGXStreOsfi3+eXjnJR2wd9YmpVKV7NfCL?=
 =?us-ascii?Q?5WqteLTe5Z/o7lXhLDcxxiN0bEJa8DVpehUjN5Fqulq/OndD3bibTEI2ec9f?=
 =?us-ascii?Q?OPd2wsXtAPryG6+bfoW1AdQKsz4zAt/I34yClaD+yyAUlu+2GCWYYDd+QnvX?=
 =?us-ascii?Q?eKu63vFBxL6056/iBSyRm6nYkCOIBKQklFWnK58nIebEy+I5lwbEgPVfe93R?=
 =?us-ascii?Q?4K5mTxMmUoxAw18Pzfo=3D?=
X-Forefront-Antispam-Report: CIP:165.85.157.49; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:atlrelay1.compute.ge-healthcare.net;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:33:31.2859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8fbe6a-d554-4246-0573-08de3e102040
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf; Ip=[165.85.157.49];
 Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR22MB4322
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:13:44 +0100
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


Brian Ruley (7):
  video: imx: ipuv3: remove undefined function declarations
  video: imx: ipuv3: apply clang-format
  video: imx: ipuv3: prefer kernel types
  video: imx: ipuv3: fix camel cases
  video: imx: ipuv3: add names to clk function identifiers
  video: imx: ipuv3: use CONFIG_IS_ENABLED
  video: imx: ipuv3: refactor to use dm-managed state

 arch/arm/mach-imx/cpu.c          |   8 +-
 drivers/video/imx/ipu.h          | 222 +++++---
 drivers/video/imx/ipu_common.c   | 843 ++++++++++++++++---------------
 drivers/video/imx/ipu_disp.c     | 752 +++++++++++++--------------
 drivers/video/imx/ipu_regs.h     | 270 +++++-----
 drivers/video/imx/mxc_ipuv3_fb.c | 277 +++++-----
 include/ipu_pixfmt.h             |   3 +-
 7 files changed, 1199 insertions(+), 1176 deletions(-)

-- 
2.39.5

base-commit: 47b50fb1125c539d80ed3e7f739c02c6486e1b52
branch: video-imx-dm-clk-fix
