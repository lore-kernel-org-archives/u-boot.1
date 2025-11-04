Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A24CCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 15:25:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374278144A;
	Tue,  4 Nov 2025 16:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hhWM1lbH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5BF3808AF; Tue,  4 Nov 2025 16:25:21 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 431528003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 16:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVkoGnyTiZWsGJVXXm4P3t23j2G+XaNQHXNMxzH4agvPgOy1rxe3ztWcw9FoAG9llIC6G/cCC68xj5aM9Sug6fe1yaTv7JVpc0cFPEyaKs76Wqt71t3QETple7sXejXbTxrwqL1w4sOwVAD8f84MdoH5SooBbAJSYnkkiyqTgcZ6BKRRWwN/cklmJlzkUMJQl++41UBTUeuOBd0xl0PHmXjuY5MFtN0wN5DXxlR68saoqgCyTFNDaIti8MxqWOmDACaX7/2K3nq/t9Kf5T20JAMzRhjqEq+4DEHzt3yvRvZDQP6EwKwk19MqOmRgSElezs06gNF5FTIJIcPbvtjDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=leiPO3lwpnT8KxejnVsNNJyN7M0VaoSY5Ff6spE65bU=;
 b=YlKYBs1tbJy+YGuJVYqMXuxerVzh2cQi6RRkW4m/OO6mCVkEofYVL4EDYMfGLc2BQZjRcYL7Wb2YQ/xfOeFpIskQtUbJRl8Up/+lb8z7CYMhIH4T3yFQYUOHDL9LJFSBEe4EYc20VnFIOGnczDtnp5Yfpsb0/k4SUjPyMMOF9c08yTx3EGjSV6G47mdBPerGzaeBanQXDq+Zk+nP6dVuty42VxApDWdfBx0bp44vKgLNESehbbzn+O6wcyqjaUYNd0q521Ky0M9gVhPXvnHZhUkjXYQZSI/qcOo6DwfJxvJvOVpevZbYdhOqlL/4zveVUfSe6yDqaTLiDfoKgYOnYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leiPO3lwpnT8KxejnVsNNJyN7M0VaoSY5Ff6spE65bU=;
 b=hhWM1lbHFbh0F3qZqikQGYGrBu5w68AFtdGulDNI7W1HLG0uefmHjRbBc/hWZjWz1P7Kwzf0zrZJMwMALlQEvEbtBpk0seDB9pJJX2M5bttOAOQeMvCQzhmzoIoiUwaGpBXh70N/Lg9oTPkRvSZFPThWn0NIjUfIG6BFO2HC6VJJ40nNvIB6bj1wJ5B0b5MNq/oRkMkpdsLOQLPN+tWEjvzY+Q8Z64JkH5Cr3YJUMNa2RZbl2TEimPa2w2OL+Wsr7IimZ5Jhk7ZDEnRki2SaKS8SWM4b07wpJAR5NV+kmp5Sf94rKGRBTwmoMy/xKuzOS4AEYqZ6vSOF0JVkhWDQaA==
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by DB9P195MB1563.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:337::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 15:25:14 +0000
Received: from DB1PEPF000509EF.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::a5) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 15:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DB1PEPF000509EF.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 15:25:14 +0000
Received: from ls-radium.phytec (172.25.39.17) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 4 Nov
 2025 16:25:11 +0100
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <afd@ti.com>, <n-francis@ti.com>, <s-k6@ti.com>,
 <anshuld@ti.com>, <bb@ti.com>, <ggiordano@phytec.com>, <b-padhi@ti.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 0/3] mach-k3: Rework spl/get_boot_device()
Date: Tue, 4 Nov 2025 07:24:56 -0800
Message-ID: <20251104152459.3648004-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EF:EE_|DB9P195MB1563:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fca8df9-9784-4878-b089-08de1bb65a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y26SmwRmcRE4TP6L1MSMu9C67hIGQI/xIB6nY5uGiUEA24ibqcjjgQ2GlRYX?=
 =?us-ascii?Q?JhTllMWsWnphZ8rmgP5VrPiJR0X03dkWo43UJxc9BRD2iluUrjGMPAPSR5Mk?=
 =?us-ascii?Q?UG3s4mi91NlQsmON8btcejFEJGq5qe7EUbWJfnNNBTc3sAxdrOR+48OMDiNP?=
 =?us-ascii?Q?5ssrMcjqDiGO/13Sj2+5eqnTDaz9XcIH8RExENw7Sd48VBozpygGEWxxwKDB?=
 =?us-ascii?Q?ly9eT+OqG5RigXh64s+69/Be42dCuh+CzWRgRVujP9g6LTvBysB+7FOybwsc?=
 =?us-ascii?Q?seBhi7Lh8FpkD4xG9Gqb6ORyrYqF8SOrveBKVv4xtYwcnj1DyElAz2B1LiIM?=
 =?us-ascii?Q?tcFcVKtNeaKBDafeiC4oFQWZCh58SlgxIjUdSJU3DoX8bvOVBZjpMRIgPt49?=
 =?us-ascii?Q?MTA6OiKBVrBA2Haz8jWuaz978hRJfKhk+DN/HPGDOu73XA/xH1C5M2Qz+2la?=
 =?us-ascii?Q?d++eeJNa5zbLc3CsSvdsSsSnff16GU6k7caoM+mX6YLBg+XJnVj1hPd7nV4W?=
 =?us-ascii?Q?HwTQ63f3ct74XUGZr3P/Nc4+GMvWzQSwxSsTd2clvxCTvh+lk+LKOEmdFWrG?=
 =?us-ascii?Q?esOJRvitUSJt5ocj1EtBbA2JPPboHZUON4OAd1QT3h6ZCRxK3inSNovGRuiU?=
 =?us-ascii?Q?UkSDaJ/9SoYahJcieXJA/1nWkpeey0ENgfksP1njVVT6Po1bK2mGoLzgQXS4?=
 =?us-ascii?Q?RIb9okWeEsXyQ7RC9s+VQOpErnVVB8bcEGZPiwYCLRBqOzpDQHwzFgdtM7HV?=
 =?us-ascii?Q?TbPhfVHe4xRpXQ2nQXHAVrn+5m8nUjZ2sHPi9VnAMkJvI42YqPpijl/mvcDO?=
 =?us-ascii?Q?Njjkg6WssFsnomNMTocHJtO4E5YRF6/MQs+96I3D2+qzq9RYl3EthhdBoBxM?=
 =?us-ascii?Q?rjpc02KYrh+80t+hnGVASG6nd6uVI6qa2pwCLbXoZcrOZ4IYBZeYzYcANu3R?=
 =?us-ascii?Q?y40QTKNJKqSl9Cl8nd2QWq7px5XY5wuLuHtFcowUVQ6B2OqA5ZrN+ufza64u?=
 =?us-ascii?Q?ieoL09Rov8uOchTPPsn76ftBfnfedlqd+p1HXaFJMxJaqyZT30ejzzbsa7++?=
 =?us-ascii?Q?nC6CTrBaE7Zi5KCN7vekn6l8WWC5Cuppj0bW8vGDl0TenXYgIX/IRjYsUidc?=
 =?us-ascii?Q?16W9mLcw7LLdad7ZXU4be/mCgcx6c7daBSbzBtnjE4zjILZvRvutDxe/Ln5m?=
 =?us-ascii?Q?IUYyzG8SfB590zrRgDL6LZtYdDYycxSr4eTgqKBn8yP2KtTkvXZtrPBct/it?=
 =?us-ascii?Q?5CIaTMa7q8I860dtQLQJCVKZ22HpUdwxGVvWvNA62yjn4WkCqJrzKjWz2gJu?=
 =?us-ascii?Q?EKOlv/Uynzva3/mSbTcywbKo2kG9gEmxVopC7rgD7d6zhr+IZGmVPbtQrQSU?=
 =?us-ascii?Q?2ACt3K3ncvqcNGYZ4nwOjYefcMXKK8g695Tb0cBCqw1OD1LVcAma+vdnsEKK?=
 =?us-ascii?Q?4XgcT1wsiTiFcP6YubSjkb8ZKSEAL77xLAITXx6ODcKgdIdYU+5mKmz33S1w?=
 =?us-ascii?Q?zlnsPbHYyjBNONoAz7muxagDTzrP0VcaucRsxQiWjr0ljvXwp/oCeE3T7PRv?=
 =?us-ascii?Q?cB5QzAZADPpO+jfHpf4=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 15:25:14.4671 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fca8df9-9784-4878-b089-08de1bb65a40
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509EF.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1563
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

This may need an rebase after the MMC macros fixup patch from Judith [1].
Also, if we want to extend it to all K3 SoCs, some of the Jacinto devices
would need an update of their DEVSTAT masks to be relativ to the
bootmode config.

v2:
  - Fixed up includes in boot-device.c (use spl.h)
  - Add proper kernel-doc-style struct documentation for k3_boot_map
  - Do not include io.h in am62_hardware.h (not needed anymore)
  - Pick up Acked-by: Anshul Dalal <anshuld@ti.com>

v1:  https://lists.denx.de/pipermail/u-boot/2025-October/599583.html
RFC: https://lists.denx.de/pipermail/u-boot/2025-August/596543.html

[1] https://lists.denx.de/pipermail/u-boot/2025-September/598239.html

Wadim Egorov (3):
  arm: mach-k3: Rework spl/get_boot_device()
  arm: mach-k3: am62ax: Switch to boot-device helper
  arm: mach-k3: am64x: Switch to boot-device helper

 arch/arm/mach-k3/Makefile      |   2 +-
 arch/arm/mach-k3/am62ax/boot.c | 141 ++++++++++-----------------------
 arch/arm/mach-k3/am62x/boot.c  | 141 ++++++++++-----------------------
 arch/arm/mach-k3/am64x/boot.c  | 139 ++++++++++----------------------
 arch/arm/mach-k3/boot-device.c |  90 +++++++++++++++++++++
 arch/arm/mach-k3/boot-device.h |  41 ++++++++++
 6 files changed, 258 insertions(+), 296 deletions(-)
 create mode 100644 arch/arm/mach-k3/boot-device.c
 create mode 100644 arch/arm/mach-k3/boot-device.h

-- 
2.48.1

