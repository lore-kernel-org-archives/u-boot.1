Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D120CD4922B
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 16:29:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 354F289590;
	Tue, 19 Nov 2024 17:29:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="joyy3vvT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E790089592; Tue, 19 Nov 2024 17:29:33 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::720])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97C7E8958E
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 17:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoskTMoCwvL9v3k4pfLNMQ0TUNpr6KJZzMzmJ9c9R5qb54kGEO0+49l1mYPvdEA5VqiIO4BQ17sRj/lKDg2NOKJDbsIry8AYBCOo/Lihlbz0cEt5qMod2LpJKphfUorl2ktS1R3b5/nkozoY7Ibg7gQCsF8fDfVObtIISwtIc5SH2FxYvpjA1GLM5rI29XoC5KJmg9mUXKuE3zMV1klTjHB7r8bYymcsa3OR4qfEiC5TCSGxYSCqKoURHAjgP+LBNKXnX7bawWqWfZEhtxH4CmVzZqzT51dQXpDQkZr5b8WmvxoOsx4K1Q1wNScU5QNAm730tvYZrb0feojRIBI+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PonVSHZU6KednN6Si2UE70VZuuLWh45E86sBA0MOR4M=;
 b=j3bUAqtfNEyMDVlXOZPLqxbsWFjf9RynJc7o5SRWSj+6h7pK4bF5yZCVnh4bKxvdJEZvpsK2a/5lcyt+cBubhzV9YEkaihyOUdQlMZXSuKUBVq18RK+fxuutWjZP3mdoNEDwDFy7tmCQro8xxQ8dT8yGwgKoSiHdXi8IwsPeUefl4jcXxMye8+XOy1Unp7rHGuTF70q3he9yA1PncC3Dizfa4sZXiCjyf4MnF8ODRAK62SImxWKmfLKqOvv40dxE7HMlzJmJk+4g0STaCvGW2HtAXAMZYL39Tcn1g6opdrHt3f6sLLJmTa/z8sz6pSGKOqqu5vZ8r5VB5MBAlljTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PonVSHZU6KednN6Si2UE70VZuuLWh45E86sBA0MOR4M=;
 b=joyy3vvTgUeCAEGf+26e2DNab1zeCta7jS+7ec7mOlvOi9cIt75mWe9se/dAhclaOLCPF6CGXFIbX04h3U3qZyNHLXwKCGVfejoQWGHXzUMZBWm+1CEQYEMTGo4k4OJHkYbbe+OsICAizx2NwgA2nBD84pW4tEsxbl0A67TjwDA=
Received: from AS9PR0301CA0024.eurprd03.prod.outlook.com
 (2603:10a6:20b:468::31) by AS8P195MB1879.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:53b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 16:29:28 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:468:cafe::1d) by AS9PR0301CA0024.outlook.office365.com
 (2603:10a6:20b:468::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Tue, 19 Nov 2024 16:29:24 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 19 Nov 2024 16:29:24 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 17:29:24 +0100
Received: from llp-stoidner.phytec.de (172.25.50.218) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 19 Nov
 2024 17:29:23 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>
Subject: [PATCH v3 0/3] Add support for all variants of the phyCORE-i.MX93 SOM
Date: Tue, 19 Nov 2024 17:29:04 +0100
Message-ID: <20241119162907.17934-1-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.50.218]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|AS8P195MB1879:EE_
X-MS-Office365-Filtering-Correlation-Id: e95489f2-84cf-4e77-df9c-08dd08b7545f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HPC9JNdEyhnOItIx1zomi705D8E4bVApiAXevhtxkJtQTEKw07seluqD8bSe?=
 =?us-ascii?Q?Yqqp98Kd6AiXycWAl6atqlp30MtRZ2wk+ImQrXe2HyKgDJnZJybQPnHTkhme?=
 =?us-ascii?Q?NGvFb6p7suOZ1tBI+ykFgwkpYN8PX8HXHOxD7vRucBD57A2nOSh352vaETyq?=
 =?us-ascii?Q?KoLrTpWOGQf03UmJB8fLt6s15du77TQSGb2e+XumNeDqNOV80KCgELNoj4DJ?=
 =?us-ascii?Q?WsiYXVIwFB8sIX5L8lAgXVmhjmjkgvxtdfvKRvFt6SHSgGxTx0a31dRauA+g?=
 =?us-ascii?Q?xGz8zCDz9cMR1juDakIpcu3o9iHFiy/LJfPtwrboRi7qj9TrLMC4cj3iYRDg?=
 =?us-ascii?Q?yUDZ47cdVISMrCSJKtD8JIE1s/EZ3/c5WJiiw9QFVRiK+PQ1SGdfra3N4d5E?=
 =?us-ascii?Q?KaN4gd3XfAjaadDSY2ll8E2aRz3h9sfj9dsXFC1tdTzb+wy3sl4VCVNt3mPg?=
 =?us-ascii?Q?TIFymqNJQJGOHbrOqcJw3xiNhAy9OQrSBtjygg7O3nu0a369IrghaxDsb2bC?=
 =?us-ascii?Q?AadokxCLdtNuQ7FkiemKwndjlGx6qSurfweOk41SFDtnv+nT2oHCiEYq6z28?=
 =?us-ascii?Q?1TM4Cr1N4Kr0cWrTymupnEsDGQGsc75RaF1Ufe1B48WeZS7kkFR6RbmhBAeX?=
 =?us-ascii?Q?H196hEP2zjlgRYGykZSobmaQpFSikQGMnKzc9sBrVyz6O3rtG4ZhHmZGu1Sc?=
 =?us-ascii?Q?7sX0KZAlxGw33413xLIZIQBZ5zRP0FIZId2Sv3b7cn8OER3Egep7yRZNHoit?=
 =?us-ascii?Q?rpxJbUHeWO79GWusklVUPpqFF/twXs/gXl6dm7r1YRCfXYiNB27m/LY1aKbR?=
 =?us-ascii?Q?F2aByAAeyhYfgxNO9OcLaq7sU8wNE5VIQwmBa8DzeMo1iinX45By9A+jVYgt?=
 =?us-ascii?Q?YJGSQj5jWwtJ3KEO6m1XEJcVFjKRr4oCEhImjGCMaU7h+5zSBQbSejpsxrN7?=
 =?us-ascii?Q?ta4XPVtdVwCcU/Mh5XkKrB0jzBpLMqV9PIfcMRzx6LbHh5LMPbhHqOPgRhX3?=
 =?us-ascii?Q?qPXsr39v3cnxLc4h+kpduOzlei7sMF5Y8drDEscW3e7wCf/LDCtJkL8uxb2a?=
 =?us-ascii?Q?Ue//3KSsUkIjgIyec5k1RLeQjOn4yINjcvT57Ds/zSivRurITCB8qnn3DR76?=
 =?us-ascii?Q?FKNcAUWjdnLe0vU6XLLHrHjjxtHc0GazE2nejUQGQUx8v39ltNNnCffy2HZh?=
 =?us-ascii?Q?D5M9g7aNcjMVj6y3hHmnth5qptn9y+EdbX/wHRKmfvDBU5nydK4X/KM2Vl4n?=
 =?us-ascii?Q?l71Ztgu2oqnfW/LggHkz5Zf828qjmzufnADAqapEhQvzjBHJiRmDzmcT1F1L?=
 =?us-ascii?Q?ZkPJiTLRw2YVzNV8jyiwFPd2TRz+rM8N93cVcEZt+taoxSq3szZ5lqWZnCto?=
 =?us-ascii?Q?GMSoKXOeTVPbBQcpRe9Xz0dA28irageDtMKQOKX8slAIUSS/3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:29:24.3616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e95489f2-84cf-4e77-df9c-08dd08b7545f
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB1879
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

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  20 +-
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
 15 files changed, 1063 insertions(+), 71 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)
 rename doc/board/phytec/{imx93-phyboard-segin.rst => imx93-phycore.rst} (91%)

-- 
2.34.1

