Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E091D462D0
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 16:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE36F89586;
	Wed, 13 Nov 2024 17:15:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="BuxLeRfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14EF18916C; Wed, 13 Nov 2024 17:15:57 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007A488FD0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 17:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCo3YDGOPq6uJJ0hyYKLUKDQ9GqHct6PKF3tKEeUuU6eBA3VLvoaC+w/qx147VtnTuP2PY3RsHdhm9Asxeqd3tC95oMQ9w6NPXRhpmWAWkCfWRtMI3SnkA3WJKCyKgZSZlihunQ5k2VAcWUE4z3qTVYRlNoCZg4OBcPv5Q8wNCNkla+V8R5RJbJOvz+MFy6cgCggLlM47CWuYXEz3lkD66ervOjO08KkXAbxas23fABMlp+7mYNYCf2Xt/e690DMhMNfNZepTwxdE1amWM+Zj+HNhA4QmoWm/3zC1z9Wt4ZmrioBISNj282KebqsjE/pAReUNaOzPXp/EjZwOvE8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bY3MvRyP8Em+Kiyve3frHN0FFlU4Aq3fXz6XXVerZQ=;
 b=FU3MPOV7BGpaZ1dSLnH6O+E4JUVZJwn295g+SxFmDC8/jXOyrpS3VgToOLn8/bKQmvzPth2rcETyOnEX8v8kanIzrRlL3SRA7I/kDjvZYcVuUZAs5DE92u0ByilnH/h3Eayz5i8edDM8c4rWH2edKPXSeZLW8wKDsWaGHINvIoAETPuUz1SqYu+B8MpQ6dCVIqgfqN2QY79VQ03aaLMiCsSi0EA00iVR2hMqz6kyYMJ/6X+LXpBbxnfEOQ86r3UDKQwH2/ZyPOeA3JVhj3bXeAy/7elSsuhLRA+6H30Z9ac6LLajDOIagvnU742RDL5Xv30Fyl2ow2cYHZ2yV9tdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bY3MvRyP8Em+Kiyve3frHN0FFlU4Aq3fXz6XXVerZQ=;
 b=BuxLeRfufGmw0iNec+yNXPOlk1UYnWRCxqAmKFv4AwGL2qMHmS5CpooN+mPljpmYgK33dK5zfXUGNgF7BfjhhknaaiW3Wur8sNOLQgEDBgc829j/kH60kwHJvKTAuI2/YjGd1fnuzhArZvJjrFNjj5px2L96XqZDizkdDiJh/6I=
Received: from DU7PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::27) by PRAP195MB1481.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:29a::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Wed, 13 Nov
 2024 16:15:52 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::d8) by DU7PR01CA0009.outlook.office365.com
 (2603:10a6:10:50f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29 via Frontend
 Transport; Wed, 13 Nov 2024 16:15:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 16:15:52 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 17:00:49 +0100
Received: from llp-stoidner.phytec.de (172.25.50.218) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 13 Nov
 2024 17:00:49 +0100
From: Christoph Stoidner <c.stoidner@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: Christoph Stoidner <c.stoidner@phytec.de>
Subject: [PATCH v2 0/3] Add support for all variants of the phyCORE-i.MX93 SOM
Date: Wed, 13 Nov 2024 17:00:34 +0100
Message-ID: <20241113160037.65679-1-c.stoidner@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.50.218]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|PRAP195MB1481:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be71c32-110b-45ee-3f3e-08dd03fe71c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YpOZDqLd6X6xdk6VvKX2iUg4a36jBjIHhuZfotSCvUJwlxoWlQ87kXTnHW1B?=
 =?us-ascii?Q?fQjvPPIJ2tuYDOEPoIeavhfI54aN3GM8PEWUlNgfbkHBZgGrbYhF0w9tYwAf?=
 =?us-ascii?Q?hectsBGiMOJRfvo0nQXKfwFXX/wM/PfJTdLE/AT5ia6+FHWbV7Icx4hJx4zq?=
 =?us-ascii?Q?RWOROWpwAhuTMxNINqvl8qRB4I8CTFmmYgTG45UKZGg+JdCaO4cx99S/925z?=
 =?us-ascii?Q?YgiH8Ig4zyMiabPNJgET3c/A6Ou+FIXqtfqELlISxleY6kgs2oCyjRnZ+dKS?=
 =?us-ascii?Q?JSuulpcYVj6ESeS2YvEEvLDkaS0rmRnqANW78ttsSZztVeKI2foZWOo5/ZhY?=
 =?us-ascii?Q?d9UGTNnBU+WBA6VccM3RQhchTIZRgAvnaxa5rjFygKXKaysHjIRxYHJhCbGp?=
 =?us-ascii?Q?I0TakDvd0hbkpawkbhiYuJKz8zoNsxqIn1cesfNfVQSbnd7Dpsf48NIZmoDy?=
 =?us-ascii?Q?WZtazR0ZJjdCNyTywGQFPJIWYora0JdEhIRLbg/kILeUe++O8rKVqwJrIrRs?=
 =?us-ascii?Q?IaZcswlNw8/5x75wo970ebLt1d55ZD++iyrfEIbyd5lNW+M0iTatg7Kiz7NC?=
 =?us-ascii?Q?HBAg3vMlXCPHM9NOs2L+j3n4c27esuGwz3Mi9PY+fp6dPl5s1bPsv/BT1lGO?=
 =?us-ascii?Q?ef0J3wZOnfk60vwql7SQbgqUmWnUE5LMxnYr4xFBpj8gDfNdbO7HSlyrljYC?=
 =?us-ascii?Q?HPKcpo4UeBBSYKxMLAbq362VMqRz/CtSgLlsP5dyINX2w/n9BrbCYuKcilCo?=
 =?us-ascii?Q?Wy2zBrdqOQX9Uqkxdml3qhMm1ZzI0dkVfutoiD51OE8ER+ple4EuOIao6J3Q?=
 =?us-ascii?Q?6JmNL6d4gUDlhH2PbPVz93ax9Ur/HjWE64mnrIETtZIazbvTQiulF/KXTDmK?=
 =?us-ascii?Q?CZlgCykJ4clW/Q8YPNhYVCRx6gjZiLcnaEb5TtwqffARZ9pgNQYZnvSh/cVV?=
 =?us-ascii?Q?/l8YKSkC+Qncv5spUeQvKxh0Z/+6AxosFq4vcr9DtKk+vSyOO7V69Uvs4YuY?=
 =?us-ascii?Q?AlHEintvhHtb/zlGrvjGIwEF2NkbiHlbEDymIC+ZGKD699i5/UL9LGdYyHFZ?=
 =?us-ascii?Q?rAGizNF+LBhZiP0waQ9vrGkynm5MqK4b7cGt8GVNtMoSet+A6X8PcXtrsLmy?=
 =?us-ascii?Q?29X7FPbvUf6gHhNyu2oGYWtDeeFRIzOIx6XjqEeqRK3fujjJShU/BRl9txgG?=
 =?us-ascii?Q?OvaZ91n4Ycd06l16JwjZpNTMK1o1ZguqJYaPSuw4/FArwCumtNigv6cbfVfM?=
 =?us-ascii?Q?6e4xfL9030R50npEELzGQHjjqHMFAG3HmW86MwcagRZn3BOL0mDqb8Vv+qzo?=
 =?us-ascii?Q?N7DnD1nXk2J/+yl0CepvQpdlfp9H7epQ4ma1Tbnhwh7EoRZ/gerFyfMTxOO/?=
 =?us-ascii?Q?jMn4wasoJWzJtZemuU826uoA2dRuwpa0Y1YZm3QpCYjraZeTVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 16:15:52.1116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be71c32-110b-45ee-3f3e-08dd03fe71c4
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1481
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

 arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi |  25 +-
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
 ...egin_defconfig => imx93-phycore_defconfig} |   4 +-
 13 files changed, 1064 insertions(+), 67 deletions(-)
 create mode 100644 board/phytec/common/imx93_som_detection.c
 create mode 100644 board/phytec/common/imx93_som_detection.h
 rename configs/{imx93-phyboard-segin_defconfig => imx93-phycore_defconfig} (98%)

-- 
2.34.1

