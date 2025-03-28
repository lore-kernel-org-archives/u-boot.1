Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2C8C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 05:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CA2C809A4;
	Fri, 28 Mar 2025 06:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="D0Nr25Hi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4BD7B8144A; Fri, 28 Mar 2025 06:58:49 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49198810EA
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wogu4jcqCGeB2wgCH8TCFG4kiqGoxrodyH5RrmX8m5g378m/NXZnemnXNwbRPKuFI8pz17hf8//B2WpCK6NDXZQYIL5F1RojO37fGRQwOtYyb9++1Fkr+mhUggGT03zK8WzuQGLPRGB193VaVi2qoCkWElweM+hbDrEFsjVe3ExUoiM5mczlCP+dQP+9r44xqcadzDofYaHk/F6YbBBLUTz+GFQ1dXtz0QtZ2zMsx967PeAZSzXfWRfYNlOzeQsnH1DnQHme1DYMdU85IqFSbhia8RLz4/Yhh+uZPUAiahVbXj1v6kAblHytbYuxYSDbbirxfIXDZB+U1U88fY8FSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9DWiyr9kOs7et7LIsObCu6aCvsN6v497CDGnoYiaX8=;
 b=u5yxui4d9JDzNxIT+TnNgDei4Y4P1lV0pL9gOJqh5Dtvcgb8Atf9+PJ6yQyG7xbtCNzy2XhjJg7jF5YuZMTiq3h5BnjWYDfz2nD7AgAKq4BlEY5iDnt+6pyvz8HCGqfvrSxQ+ETb0fbacOodlMvIBBwki6IM6uuF7oB7Cw+VdNHuyxS/u/klkmKZB/kvi7XkTEhjwypN2epQLurEMKSBZMBLxzzGTF6tSzKhTznpdLo8PwUcXiVlurHStu9r0vzBmIoghUsDnaL4MYM9wn16cWWWM80GUvWuLZ1EkBYig6BNksxWUIIHnvi6a94Rk25RIvDtx4DXy8nvYXmuMpvG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9DWiyr9kOs7et7LIsObCu6aCvsN6v497CDGnoYiaX8=;
 b=D0Nr25HifD1gK4qT0CN8bEw6fdIinjVbKHwgGA8K8TmS9G+N1x62xsM6m8Ivn1Oas+FimzUBYL3Dn/wOIIzd7EHeZ8vcfCf2sSjJcAC6xDEM1d+nOKUpHK54URouSfuS3omJeSW3HdJ72G83iu48fncGMn+22ZOSMlmeieL1A2a6vBo+8mzDLAE9L+E0vZp6vJOaGtwlL8dV76Bjcau5ghYmWTwsSV6YXYw8H2e3nkf6Rp3Lf+B1Mhrc2b4XYyflVhO8bmUz7GsxamSjeGY/TCrGA+iDzbaDDJq8ve+AVo9CbgcnOtYHdWm/Uj0WJzt6qStoRdWkRVBTE52uF605Ww==
Received: from AS4P250CA0013.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5df::15)
 by PAXP195MB1536.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:281::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 05:58:44 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:20b:5df:cafe::50) by AS4P250CA0013.outlook.office365.com
 (2603:10a6:20b:5df::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 05:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.2 via Frontend Transport; Fri, 28 Mar 2025 05:58:44 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Mar
 2025 06:58:43 +0100
Received: from ls-radium.phytec (172.25.39.17) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 28 Mar
 2025 06:58:42 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <mkorpershoek@baylibre.com>, <B.Hahn@phytec.de>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 2/3] configs: phycore_am62x_a53_defconfig: Enable remoteproc
 cmd
Date: Thu, 27 Mar 2025 22:58:23 -0700
Message-ID: <20250328055824.3849523-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250328055824.3849523-1-d.schultz@phytec.de>
References: <20250328055824.3849523-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|PAXP195MB1536:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f8f3df-5237-46b3-c49e-08dd6dbd993d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b2jFZcvUhOKYogk9eq1CGzXGH9AQZ5BSn7PlOgQ8ToQHhDR+7me7RiDDak+u?=
 =?us-ascii?Q?cc+w1WKnQVnKJBsKCKLKDuFtAcFfe+hXoecjOnBzZn727uGmtC5CynHgJF1G?=
 =?us-ascii?Q?jOIcyYBCsDIUCI7BMg6nOKvs4kx4qFg0j8x/j3G+zJhuK36szIpc/kc2E3ju?=
 =?us-ascii?Q?5G5bHb35S85nuwZUTlmj5IHdDPrxl1WOkHL8K13k2Qj8JvBuwFcUTWDZUrTL?=
 =?us-ascii?Q?Fp5HphQRkcJRNHXkNgTph7hkt1PXLmWTiqf4Om+x5HE55es3emJtZ3p/rgj7?=
 =?us-ascii?Q?lvShM0XCxRqsZ8z/90Pb8349kvspgTls9tzO1dLlYVg4Wkjw2FPrqWgVaNhU?=
 =?us-ascii?Q?WLvzSgq6cZM8GMcQjrmQCVMDzY8YXR80xwxAg/A8zfFONCuWW9LX9u+5pIvP?=
 =?us-ascii?Q?Fe2J+zwwTZpiRif7vkqs5Axfz2AWLhOOBXGY4zpxG6RpOfetJ2TwkSXITtkw?=
 =?us-ascii?Q?9rQI29MlMdsq9ox7C8AxXAuTY1EUqlKQ+uQxCCUG/npd5SRvA1a6L4Av9bwx?=
 =?us-ascii?Q?GdahrXuooyFlMZc4xnFiuJ6YJZ9dRxxz/KFRQW0oi5YULkf7TBsWHsgD5XkD?=
 =?us-ascii?Q?vbleSi+YPOC8lOZpko682DPwF1klwNFdNHc1Qls7dlvIV9Mzj+kAh+CDRDuJ?=
 =?us-ascii?Q?pekDjAB32pmcNDghUbcr2rCkMNFmr4e62iM/OxHu8yWHUisC+4EgqC//VZgE?=
 =?us-ascii?Q?FOLeO8y5+LRTrbSeA8IDN9sEJ4l4RlZJO+gSgOS0V5dTqP1AWz53alOog+V4?=
 =?us-ascii?Q?n5l0Ikl5QFqfkU4+FKgGajHXKi7jQzIz7viGquhQSuugyPhGqFjch7qF6Zwl?=
 =?us-ascii?Q?MXImDOT0z2SRtSOXHGxk5ZaFIt77grQS3fN9btVcWzqW7igTivsCav4ByXps?=
 =?us-ascii?Q?gCxG4NeFeMlwpdx1Nn00rgamvs71S9hnKB17fccpDxdv8E2qARW08zKz+Bo8?=
 =?us-ascii?Q?86G93RuniHS4VpDDQV7rMOlEYL5Sf31ed/rYlgDcM/HBclMdpYHYK+mT6jv6?=
 =?us-ascii?Q?RuZEWC1FmIz4Utez2/IRC/6g+ysDE8X7ZtNEOTE3qCLnPo/cZP5o6cFHsxIl?=
 =?us-ascii?Q?cgfUQxinupjsBsqhk1XiOzmR5/RSNOr1CmJHgmOeg7AOMoG5XY1G0Hlg+rx3?=
 =?us-ascii?Q?iOdR2KvWm9TfyHO4RtZgZVf6l9OqyX/iQcfCCyMVjUDn+4iFzVaoEogARaah?=
 =?us-ascii?Q?qOCzeV62nbqblObGrtrCNq59eE8c235bxqCNvWeUiSKqWNCq5/sS2wi+ylyZ?=
 =?us-ascii?Q?ANThtMRYu8xw6VEnzg89tp1N2QzhAqOm/SM3+0GgCjqn/UWDZhNsQtWuy4lf?=
 =?us-ascii?Q?2CRjveI9YnUwH7nqiZtnd2g8HcpSU/lOlUoLqaGrsT8QBA7u6y4Cp8LktUYw?=
 =?us-ascii?Q?e65McqnBKXriys+Xp0xZONYtVBFrJKFTUDVGI4z18ygUq9+kfxlwIPUEHGtU?=
 =?us-ascii?Q?U8nN2cXDatV3NuubwWsbgpJ7PuRuZvEfN3I0QjJpO/C7XFvXvMcYBN29uRc3?=
 =?us-ascii?Q?jChS9A2z54J++mo=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 05:58:44.3259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f8f3df-5237-46b3-c49e-08dd6dbd993d
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1536
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

This enables the 'rproc' command, allowing users to
start, stop, and manage co-processors as well as load firmware
images.

Useful for systems with auxiliary cores, such as the M4 core
in the AM62x soc.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 03d4618df38..c1a46bc40a9 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
+CONFIG_CMD_REMOTEPROC=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
-- 
2.25.1

