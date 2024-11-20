Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC94D711C0
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 16:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 198D189347;
	Wed, 20 Nov 2024 17:32:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="hLqoOQpp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385178933D; Wed, 20 Nov 2024 17:32:06 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::71d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1C6488F20
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 17:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNGAFZcZxC69B5q6NSZ2ijjpg+spPv1kKCfMgNLNatHs2gOAk+2+7vDKzxD4sW8Fay5r6Y97aYYfaQUo5dT3vJYZ2XlNCucajRpkghqDZGc8I2QV2WZEoJB01duFsnkCuZYenbvJoFfLLaBbiDRoB1qr8nIqHPTsOhMDXZNKbSm2syxv4p+iCvzc4lzsN7coE3LvP0LuZzf9kCWArDAdrmzhb2oJw9rNgYwkhvYO24g89kxRZvH8l4GQsllTDBHKcQGk8u7kkTi6u2VsQ6V72XuclCvyMFb0/bi94jcJp/mP73Bx/ATq/ioUIwHwFqJW6e6XuQpXqJSzzpInMMXHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VTZevbb4fMAVwVtUFaj+2oMEsZS4TQ5pjD3sVhppKk=;
 b=gdz4/CV2FuDOPU8klFbXnXIoRaDWPImOMv9jjfwrHaVnL7NNhXahQSIa1YH5lEtpNo95VapFSyj8q83FMh4lNNFxlTf3t/uZCp5eztHSicywEulCP+c1BHXZWv3od8bSK8QVy2tRLEtV54kSFPVcIIXMgVP6DlEVE27poAJc5d+djzJ3/UGV+XugllyEnQreuj0Xob5sazRtQBQX8ITUSYwv6b517esJAZp1KcwCk4nzyeWANP2fVgUSi/otPOgWkocAcKRPGk74Ag2XTQxUzlPQRETx5HhHqkfvJhGN+XAtxiHZ+wDFy62D4sCu1U/ly0u7maAVGlZdTw1Rmz3JTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VTZevbb4fMAVwVtUFaj+2oMEsZS4TQ5pjD3sVhppKk=;
 b=hLqoOQpp6da8s23ZKqbdxkKFZFhhftZ+QKuGUd8ezj9Wvjqy263nHZAj/vULvPz3pGTf1e+5dSKTn4QiNSUiu8qhOCU5ZFHRhqUx0rzEj1LR0UMAcSrOY9HSEhTw22TaPue6XcFZyR/TREcU0hqvm9fz2fJGgIBCQ1G3UzZwScw=
Received: from AS4P190CA0066.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::9)
 by GV2P195MB2281.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 16:31:59 +0000
Received: from AM4PEPF00027A62.eurprd04.prod.outlook.com
 (2603:10a6:20b:656:cafe::75) by AS4P190CA0066.outlook.office365.com
 (2603:10a6:20b:656::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Wed, 20 Nov 2024 16:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM4PEPF00027A62.mail.protection.outlook.com (10.167.16.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 16:31:59 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 17:31:59 +0100
Received: from llp-stoidner.fritz.box (172.25.39.157) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 20 Nov
 2024 17:31:58 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>
Subject: [PATCH v4 0/3] Add support for all variants of the phyCORE-i.MX93 SOM
Date: Wed, 20 Nov 2024 17:31:40 +0100
Message-ID: <20241120163143.127862-1-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.157]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A62:EE_|GV2P195MB2281:EE_
X-MS-Office365-Filtering-Correlation-Id: acda2574-a259-468f-4f39-08dd0980db45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zzrJPPNcdrUq6vMS3ncr7AftU1ltSxssC2nCbHLHnM92JPrwh8QQJmH6mO5x?=
 =?us-ascii?Q?c0xmQcyO9hGe6wG9QD+3tkVI85V4VItJLZJofsY3ZItKHP/FH/gwRiGuB30Z?=
 =?us-ascii?Q?w0R+T2HgZBM/CPV5NsjOXZWRifrBcUTSEEzwQUftXiVDtcRXRWHlpn6y7RSR?=
 =?us-ascii?Q?Oz31JD5Qa7PqI9z3WxR2whJsUkcz2kuwGLAPcuxHzYRIsaJKIvnrRS41sxwJ?=
 =?us-ascii?Q?+SIKgF77i9ln7VUC1/A823sf4Vpa5mANCVHHrqA52sKPJTgf/aMQezeJHyrb?=
 =?us-ascii?Q?6Q3KR4bQMmNT6zWDblS6Cx0ybL7GAYa7mS5jFcGBXUWo6MmrQGZZylGRXDcY?=
 =?us-ascii?Q?+LdNztEgBVcRZOkVGtuhKdk+zk7XuUgnVKkISt+yqAbxwviywSVATQXE0E0A?=
 =?us-ascii?Q?Nz/7yeI+Rta3mXcH7BBeFc6162TpbkRmRc5aDs5Ostn2XLY1buU7nsDs8JxP?=
 =?us-ascii?Q?ih2ydFxLDaZJ3u494YkM6X/9udNy0TS49rAVVua/HwAMPX+EpkoPWbogSE5v?=
 =?us-ascii?Q?BCv3VVspFqLvaCbTX6SEneQKlUc6Y0GDV5fTdGIfQjc3iA6MoNF1RmdUBMKp?=
 =?us-ascii?Q?yOjHjrlhgpS6b6G6jTcUj3aWosZKIGOpXpGa9/AFyzmxk9FXiekV3LZzE/Wj?=
 =?us-ascii?Q?6KFsVahxrmlta+yaNhHxCQOSpi/9EcvIvu3d5SKZWPHGGHjdokhJVZZN2tqv?=
 =?us-ascii?Q?QArzzdyT450zUwAJXljdORUT8iJnxClOkvl7w4jhjMSZjnPe533SM/Jcj9NQ?=
 =?us-ascii?Q?ZrEaCrhi/jYlDEDRPx827pptpJkFXHB29lOWncnfhpmbICuU9dchz3X7d1zH?=
 =?us-ascii?Q?sioJ8r3RKaCF+RS4sLt+rybhub+0gtau2gGHKtKP6YJtkBlWuLlb5g9tCvj1?=
 =?us-ascii?Q?vmUxoTDsIXzF008L6rUE99/QqXvTuDvjFKlxosvGNV/rjYv0asWsZGvajWtN?=
 =?us-ascii?Q?wR+oa/h7kPZtPA3xKMHmz5iWGvmdWYudzG5Ce81ZUpawRJwzXx4CkKttYrku?=
 =?us-ascii?Q?8PV+Ra7MVPzKwCrQEMudgu6QFfqVxQLLL3sTogIsOsAoYrbgUIugaemmlusB?=
 =?us-ascii?Q?hj1IiW8APGbtyJdwJMZlXvPNwu+kg/am7x7SMvgnIV8CA8RY2ufDLrADg5sb?=
 =?us-ascii?Q?xY+Zyy7xrFIezPdCZVITeDWiJWxHX2WGs+arv1JXJO+nSOlhmYADE2pJtK1b?=
 =?us-ascii?Q?HfC4YLMApUBP1SFO7MNGaHwLA3Xg1qp6DNU9Xu9lRTtz/7yXNk8d/E/jWZlP?=
 =?us-ascii?Q?3nd+n6fq9f1S7UUk85ZXn8ETR7yBFwgT19cwK1KiO8cJLBAnBjIeXMhRIvi2?=
 =?us-ascii?Q?o8asySK5JV/uexDX4VeJUQSuc7ihsH5eYllcbVxejIoR01E/xFlwREkNRPph?=
 =?us-ascii?Q?dGu6w8Vo8uK6XjF7hjJtVp89ujkJ6BU5PYP160YRNyol3UwMoA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 16:31:59.5226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acda2574-a259-468f-4f39-08dd0980db45
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A62.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2281
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

The phyCORE-i.MX 93 is available in various variants (e.g. different ram
sizes, eMMC HS400 yes/no). It's eeprom contains information which features
the existing module supports.

Extend the existing board-code to support all the SOM variants. The spl/u-boot
evaluates the eeprom information and enables supported features accordingly.
The resulting spl and u-boot binary is able to boot each phyCORE-i.MX 93 SOM
variant on each carrier board.

Changes in v4:

patch #1:
- none changes

patch #2:
- add missing pinctrls for eMMC 100mhz and 200mhz

patch #3:
- none changes

Changes in v3:

patch #1:
- none changes

patch #2:
- remove unwanted dts node eepromid
- correct typo in doc (PHYTEC_IMX93_VOLTAGE_3V3)
- improve enum code-style (phytec_imx93_option_index)

patch #3:
- add comment about SoM-scope to imx93-phyboard-segin-u-boot.dtsi
- rebase to the latest master
- adapt doc according to new defconfig

Changes in v2:

patch #1:
- remove multiple blank lines
- add update of 1GB ram timings to commit message

patch #2:
- encapsulate handling of feature flag VOLTAGE into own function
- move definition of enum phytec_imx93_ddr_eeprom_code into header file

patch #3:
- just rename imx93-phyboard-segin_defconfig and add needed CONFIGs,
  instead of creating an entirely new second defconfig
- remove wrong comment from imx93-phyboard-segin-u-boot.dtsi
- improve commit message

Christoph Stoidner (3):
  board: phytec: phycore-imx93: Add 2GB LPDDR4X RAM timings
  board: phytec: imx93: Add eeprom-based hardware introspection
  board: phytec: imx93: Add phyCORE-i.MX 93 support for all SOM variants

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  69 +-
 arch/arm/mach-imx/imx9/Kconfig                |   2 +
 arch/arm/mach-imx/imx9/soc.c                  |   2 +-
 board/phytec/common/Kconfig                   |   8 +
 board/phytec/common/Makefile                  |   1 +
 board/phytec/common/imx93_som_detection.c     | 111 +++
 board/phytec/common/imx93_som_detection.h     |  51 ++
 board/phytec/phycore_imx93/Kconfig            |  28 +
 board/phytec/phycore_imx93/MAINTAINERS        |   7 +-
 board/phytec/phycore_imx93/lpddr4_timing.c    | 793 ++++++++++++++++--
 board/phytec/phycore_imx93/phycore-imx93.c    |  51 ++
 board/phytec/phycore_imx93/spl.c              |  48 ++
 ...egin_defconfig => imx93-phycore_defconfig} |   2 +
 ...3-phyboard-segin.rst => imx93-phycore.rst} |   8 +-
 doc/board/phytec/index.rst                    |   2 +-
 15 files changed, 1112 insertions(+), 71 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
 rename doc/board/phytec/{imx93-phyboard-segin.rst => imx93-phycore.rst} (91%)

-- 
2.34.1

