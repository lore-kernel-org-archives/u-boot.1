Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A7EC02180
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 11:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0DF8033D;
	Thu, 16 Jan 2025 12:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="gGefXWoO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E76380214; Thu, 16 Jan 2025 12:30:02 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20725.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::725])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCDC8033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 12:30:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKzJmvcdPeCYdfNmFAdPI/ICPpx5zddNrhNYnKHkKltjvmgj11YujvTdSNW9grHQow6yDjgJvEQUhzjdQN6AdJkaMls8Xxw66+34qiEiDLts2GRc9T5TOs5e5UCYou9D2nEd1ThHOtZBf3Zho8OtG9Wcy81YzeIPLXAYW/Ey6uLVMY3vhnM0zGAii42mTI+XPM+LfLwQ7rNdOar/ehpao22dB+mPV+MdAvJdwLy31xDv3I6LUVhEghCXxELwa0wFUNSSoa2t+nKuDMYfK7O+mpwv74HH3ngk3kAMcu38ZXDr+EQICJd14ZPReAd1XWfXrA/zxB5+c4NOkzN4kKR2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdQyF8u9mAA0a7w9Kbml/kORDfv/Qm+tyWcrppNpXk4=;
 b=glc9YxayR7Q2tud1nRcO2gEQxEOyoYsEauRVhD5VpJK0eE+ggD+IVzIEpj8qMAnI+cbUP3cTW/ajv5uGyq4gKv/7XX5sQ8hhAbLOmx/k1Xvar5EpYwPkkhqFD+8/J0CTPWFndxgHXevKqFjui51398Bd9BsSaEE65Pgikr55RaFMSb8+9xtCnT7ac+iWLn6UhLCEij6Gkg1DqUlOrd87DEQiNajvG9f2S/PcMX2bnGtBQBZEI12u1eckiGRvX/yiL8YIA0L86De4Xf5k9+c9aTegWKAPi9GmmUJeWASsSvTIgH4j9GXkkTJckAaYSgfY7niQXF/36hrcy1FSvpNR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdQyF8u9mAA0a7w9Kbml/kORDfv/Qm+tyWcrppNpXk4=;
 b=gGefXWoOqjEz6c8O0w5eyErYJzQjEqebwgysVxvE1T5x8LGYUSI5RNJugTqub1Blow6h7cjkeRD3iqOudkwkJ457lo3moEy2nRHShOMAQ1SVSCjTIL6FwgSgkkXXAG7yK1M5jIKXOGQre3NjFUSa5FYUU8Nd52INeK03n0LAbznTWrY3zUFRcNvwr4rdBnZ45FlKLxW/Cc2Oc9JczTA/TSwUutGauz3AzkQcMPUl5O8Dnz6ZVvW4MnsRMfOkPjp379YQse+b4y9gpFqe2LUKa5REItF655rRn2zEF2nkAcKu+Fdgw45jZURvinPnrZdu+Prj8d324zylLZKQYUFC/g==
Received: from DU2PR04CA0246.eurprd04.prod.outlook.com (2603:10a6:10:28e::11)
 by PA2P195MB2522.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:40a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 11:29:58 +0000
Received: from DU6PEPF00009526.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::3f) by DU2PR04CA0246.outlook.office365.com
 (2603:10a6:10:28e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.19 via Frontend Transport; Thu,
 16 Jan 2025 11:29:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU6PEPF00009526.mail.protection.outlook.com (10.167.8.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Thu, 16 Jan 2025 11:29:58 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:56 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 16 Jan
 2025 12:29:54 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <d-gole@ti.com>, <n-francis@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 3/4] configs: phycore_am64x_a53_defconfig: Enable GPIO command
Date: Thu, 16 Jan 2025 03:29:31 -0800
Message-ID: <20250116112932.1983801-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250116112932.1983801-1-d.schultz@phytec.de>
References: <20250116112932.1983801-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009526:EE_|PA2P195MB2522:EE_
X-MS-Office365-Filtering-Correlation-Id: 00095e0f-8a27-4978-a66d-08dd36211bae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w+HX2YsTGTZLbJPV8jF/Q0CRkLTthxZLIKXGn5dsetFIvsZbCArdR3vEn/hK?=
 =?us-ascii?Q?1IxesgvkRNfqKnZF3fQ/hYs3azZRzd/eGv5+rbeRb1GNCrv0g97nZEvqLp4s?=
 =?us-ascii?Q?UDce4T34hrreP2PIKsQp/u/ChPxltw9ewy4v0LrOyLcC/8q4D/aTBLmPNNaJ?=
 =?us-ascii?Q?uvRAKvereWAA14f8u4BaxFgkgdMmTTsoFvSdGyMY4U1FUsroqACWDXWXhLIZ?=
 =?us-ascii?Q?rEoHDDCDJzTBMLA7xiH0OhXGNArdwvSYqnenJjxvKmlOPxObQlQLeNOkIzgV?=
 =?us-ascii?Q?X3vor6j0Tj5x0hCb0YQZUQNd5h7N8LZJS6h82Bk4IwWUHS5EYKJ8aK3f/CwF?=
 =?us-ascii?Q?2AGzySohVWxvDqljytXfJ/XZXmK18/0kmLCzWkA3PJT2BJ5KBfc3aQ7qfq5t?=
 =?us-ascii?Q?gSpf5GtmCLLuVd6UcoLY30m3Pei6tdCdI3ngEMd8I/CGU5459Rbkh9f5d2t1?=
 =?us-ascii?Q?ZrGAD9HuplgbPk4F30zbt1HAJ0s0eZq+/Eh7cYCgknZtQ+uKhZt7QiLq4MUc?=
 =?us-ascii?Q?CXwBW9iYuoRho9qViUnokVZmYqr3iIdz4RatiViUWlXTz8vYZgnZsTyC8dnK?=
 =?us-ascii?Q?WnI+UytGIi0uBugPw9q5yasRFBAdLhui9ivZeaaYjt5gzAtEWuZW/EzG3tB0?=
 =?us-ascii?Q?eHgRYZ18BOjYa2Ho+p76mkYdcj6Ggu5mk5d5KeOV2CFILENQWNBM71Y2m0pK?=
 =?us-ascii?Q?uFsMQMHM7oMhwWi2tiVX/+q20iVUSQa3ksAK66zRaRWXHzaDgwnyCCnAVW9D?=
 =?us-ascii?Q?pb75QKY9uF+R8IjtRdZXpqPVqzOMo5n814PHSseKC4OIaAL5i9Yzf1Ye02St?=
 =?us-ascii?Q?9PxX+lvpXsvvtqS8Bdgi4LC1pUBjBa6gvFRKd4bJ3rxQmId14g417sMvN7Ic?=
 =?us-ascii?Q?Lv3oPlbvnOtJOhVGLbQc72+hdNYwKDYeSxww5V57jIrR9INa4g+VfxpBod82?=
 =?us-ascii?Q?8j2i2h7FvBBfuKZ0e2BQsXbiP91Ws8OyIb9t2lOcdr+uCvcqTZ1N8zWantMl?=
 =?us-ascii?Q?/jp1dmN9/4qISMs+/gHMZpvF/1qxG65P70BqJ3JJGRXgJDx3b6P/LDDBVadH?=
 =?us-ascii?Q?Y0a8kO5vOw7MeCWRY/OiYusQzWf9e8diBxin56JaCbL/pUHKcby7b0zAv+sH?=
 =?us-ascii?Q?3ABndmxczG9zjNxFniaPsSKH+8o631MqyDeImU4e05JFcoRr2oLGdGR6UsNl?=
 =?us-ascii?Q?KB2tPI6BXzkf+g2N6NiqGU0Xan2srIlQOkw1gZqOU+ppW2dTzLL7PKwWhPlN?=
 =?us-ascii?Q?atdfzQ/JiFVVsvbdIDlci0R5YSyXFw/13TzUuEKA3CaAC+KVIEjYGIhktNRI?=
 =?us-ascii?Q?xHBzbui857OQfIIasRkXi8s15G2ET/ihhHJJh/pktHx8EJOJh6T8NfVh19lc?=
 =?us-ascii?Q?uMFoHcdcn9RPB03RLdqwb98mO1yGcjaxF62zd6hTwrSA9rPvyG6QzTp3WNVY?=
 =?us-ascii?Q?ipb8xTe54Tl9R7tDKnuwQkOWDUadAQ6z9V2pHpiNSpovtSIAEtS7iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 11:29:58.2104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00095e0f-8a27-4978-a66d-08dd36211bae
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009526.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P195MB2522
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

Enable the GPIO command to allow access to the GPIO pins.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index 4b9dcceda45..4a91b72e700 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -72,6 +72,7 @@ CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-- 
2.25.1

