Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E0CD68BDC
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56C14896FB;
	Fri, 15 Nov 2024 23:35:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="IrTKwJMX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3E758922D; Fri, 15 Nov 2024 20:51:30 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20718.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::718])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AC3689247
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us3Ios6qVk0XSVpXOpxP5KNS9zwFDtHR/PYStB5SeObxYv13iRvJuVHGPlbggjTQA326Sa1WHBJCndgGmTPaGD73ETLp0IlwkHTvpQijbqiiEGsJBidIfrjYXJMnfhNuEcNQiSV2KTULfwZZR0XHm7aqh9KGkNZYjIm8ZJrW3cIs30QjZoBSDuktBsNV8oj7wwiMrJ8zGjsDVyIgPjerF6eNA+paQNQ7/haFY0XuHOoKE/LnCn1Bzz8PD872zRBdsOzI97uTytSPjelSErNVDgodrFqA7lR9qijdSEdMhHrM4IgluCv2658f2ZfZkP/Wl8Ub0d3zutSvqOM20m6xgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWz/AfTCVxVv41+ToRpfYvErD8YQlEf4IAeLuqaXCBA=;
 b=IebOoPcMYZJ6f6pm/uSYiT15NzSpWGyKN91AR51LoI5cUPJ78MXZ70DyFSLIXcjuZFPgzE6jJH7I+PzXGyKM8s4Kr+3ctOll8gIy61P5dN3Qbm8GkqJGCDOBF8rgzy7RPU+WPABNSSqXmRULn/uMsOKY/GRORaWCtRcQS4YIp46xYZuUKHsD3S7aE/Q6GfFz6wvuLM5t54jyizoHxYQOqBUZNB34/TphAeOMFJo2xLRIP3iBP2vGVsxMUdBmziBN5dkNgeZlDZS0JQCt6V+MlnX8sym4KKjRrsQPokwrhUwbRR3qx6NtEmhxYyPW9d+kKBsc7soo3CjvtCUEg88llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWz/AfTCVxVv41+ToRpfYvErD8YQlEf4IAeLuqaXCBA=;
 b=IrTKwJMX+oLjIRIIv8hciifm2cjehEJz/J1DJt2KPKElQj0FIiEdENNUC1Nx6JBPsiQ0thB+weTUi28l/JMB55Ep1lZQeaQdmLo2qeX1MveGIGdTQVSC5RIZl595iAOM8m+T/BaXD+ex/o6ahmInJ8mmw0zbTo4s/uzzPJ3vnY8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH7PR22MB3118.namprd22.prod.outlook.com (2603:10b6:510:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 19:51:18 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:51:18 +0000
From: Garrett Giordano <ggiordano@phytec.com>
To: trini@konsulko.com, w.egorov@phytec.de, t.remmet@phytec.de,
 sumit.garg@linaro.org, kever.yang@rock-chips.com, marex@denx.de,
 festevam@denx.de, jonas@kwiboo.se, Oliver.Gaskell@analog.com,
 aford173@gmail.com, prasad.kummari@amd.com, neil.armstrong@linaro.org,
 mibodhi@gmail.com, n-francis@ti.com, d-gole@ti.com, afd@ti.com,
 sjg@chromium.org, bb@ti.com, nm@ti.com, d.schultz@phytec.de,
 nmorrisson@phytec.com, francesco.dolcini@toradex.com, vishalm@ti.com,
 vigneshr@ti.com, y.moog@phytec.de, othacehe@gnu.org, m-chawdhry@ti.com,
 j-humphreys@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
Date: Fri, 15 Nov 2024 11:50:54 -0800
Message-Id: <20241115195055.3023365-2-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241115195055.3023365-1-ggiordano@phytec.com>
References: <20241115195055.3023365-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:408:ec::20) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH7PR22MB3118:EE_
X-MS-Office365-Filtering-Correlation-Id: 691207f0-048d-4a81-2058-08dd05aede29
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j8YgekjwkVM7c4ERnU4lu4ulu+zUZ5ii1NGRCjjxsrdURY7jQbFeVTUJNDgp?=
 =?us-ascii?Q?G0PUZZB8+hKZKwSu6MyGEE+zYXrO2wjzn6A732uMIO7l9DI9Hxa3uoqLjJX3?=
 =?us-ascii?Q?df6Uc8d2sp0a1p8xa4tBHS3u86EQD1hJd3I/0zDKj1Y84lMs2WP1OUgq8kNX?=
 =?us-ascii?Q?yN4G962793ljGU0pCmsKlOVP/4zdJefio5EVKXjgnkgKG7cRtDU7LVrZUlFN?=
 =?us-ascii?Q?9aIPI9qkMMBbR1uTwTGmv97r2qNwHyUB/KnMdMB/aC6XPh3c6vYtqA/yr6sL?=
 =?us-ascii?Q?VV165737EV81RNAjyNG9ITy8iDprGhjiVUlCtGwtc6FuOjTAaERwmmDmjfF1?=
 =?us-ascii?Q?rCTCXgzXIo0xSqGS20C1bDhgtAafnZuFX43q8OmnWBuTwZRKeNCbwvaBIsI0?=
 =?us-ascii?Q?6cQb0vmZPAN2givHgKKJ++EVzx+aM94gCmGG/TxkEqfOB1TOoG5cWs9IM7/x?=
 =?us-ascii?Q?yHii+3+QZ99jnxNMfhjGdGkcqCRP6sSz07mGNz2RxYkq9fBya0U3RzEO/SsI?=
 =?us-ascii?Q?o2LjCt5Yp8ojW2EDLW5mzQSph64yxfSF1GFMDG8If8Jao9KEerKnDQKiJop4?=
 =?us-ascii?Q?T4fhyn/sJOjZkT3ICe7+qWR0KhBNb26LX4H8t6cNUV5dQ1nqi6Yyt8imTb2O?=
 =?us-ascii?Q?SiTVr/UBbqUvfrNyNYamrt2sIwH04rrlAW+im+gB4XRiFUSL8UTu+DxutvAZ?=
 =?us-ascii?Q?IDhL62e7Q1OdfAgq198bt2MjW34Y9dMYIjYwPKjEN50tNS9Gor3PT1jb9YN7?=
 =?us-ascii?Q?wzN9FnzT74wu/mWCp1L/V1yRnSHtrzgZdbRxOsMXZ2ibSsk1dCLHMSj0Rnx8?=
 =?us-ascii?Q?yP39c/RHRoZNCskPTY+2D2Z+vIyKKlWj0kDi4KatH9Q5Ma/rvskMVODw3oN4?=
 =?us-ascii?Q?fA7ZvuKIsHa6hJV29/9wjuM8ryI1X1Soq9mXpy5j1C8m2J1PgUOh/DqOYBx5?=
 =?us-ascii?Q?KIRrN0QYIhD9hQS+EZz+MxmsqAAj4T7mOqpz5uznl2v78WLOXfMb6LM+hazc?=
 =?us-ascii?Q?s93YYV0knFaDU8V3s4zZ1d2KmDR2IfYRzQZg+pKsnVMgkmC6Zr/NsjUqt6zU?=
 =?us-ascii?Q?SUFsi8u0POtYZq60SCwy1LJRav9KweOlGr9PU8wn4+2d5RZ4F8G5L29mWPvQ?=
 =?us-ascii?Q?unE+N8GEYiIz7qEIbXLWhEd6dwctWl7tuDDQ+xQ/Ryq250j76xN6WtfYbbZ4?=
 =?us-ascii?Q?F2hoqG8GIUmJnmbAr0HrvvCv9lwdkOFXFsI8JbrFWsYPmfnI2TFaUR0YV4it?=
 =?us-ascii?Q?L/KoxKMHniv+76bkHQQtYKH+cRlvruNzDls0Gkk8PxAKU9TLDyoRPJcjDRl+?=
 =?us-ascii?Q?cHpj7Urn7vyz8eRdkZVVRO4f8vCuUaJ7uKZGAKvoknSOJg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCj6AJ6akz/uqJQ7VtC+vb0mbrJ1UniC3JwtoyG7o+wT2F0+TuGuYWTgqxHX?=
 =?us-ascii?Q?BIbeSVkoGgVTpfAsrp2jUnCWe0VSpyeV/WYCv2YnbKzsxlM2pqDvk1FlTpQq?=
 =?us-ascii?Q?8eM+Swe0AOyDcv8xka6JU2cWkifn+zWNvoUrftKn9W2VXzUNVhUQN8a/5fl3?=
 =?us-ascii?Q?iqZLZN+pQBr8M2yjp3m+KFwB7iks2RKracDvFb9fyP6toy2Dhmwykv3ufEpS?=
 =?us-ascii?Q?SeXBrcF7GogrfevtEW0snQWwk0LKwukjkmQ6MNx4IliDeYAW3Y4/P7AovOZN?=
 =?us-ascii?Q?54pRN0cM+cwWhjur9bYQiu7PwZGzTnfULDT/RSRzCgfK1YMCONSlceh4nmeV?=
 =?us-ascii?Q?bvRlDZEamybH38ttV9LDsIggvWE7d2ZZvz5SHZLm41O1xEeh74/BziJC+i+s?=
 =?us-ascii?Q?E/2+tv1mr5rVpThSnSNr+VdjB9JwZLP3GguMgGFmqzmZY2BqEsTLQ+tAFT+S?=
 =?us-ascii?Q?tQgtF2aDzdNFunbzKpLcPDmHE4WSvNdghp/Db2pocAgJtxl1P9RcxAE1m+YU?=
 =?us-ascii?Q?7/dRwW7atUq9Q/mk47NvRRzNfL/snpgJKDZ5hfiuicoGxNAQFjq78t+RVVda?=
 =?us-ascii?Q?nJcITtN02ClpRIh8WXcmPrdaZnO40Rzuma5fX91oorGUd7CKenTwygzZ/+J6?=
 =?us-ascii?Q?f2xklkB+1W07hJeVcrcNEPMo/ntNpn6IJQKlz8qQnDXz59aA/4S0uBx1uTzA?=
 =?us-ascii?Q?D+gi2ocjohjROqfNpntG7lktty2V0IqL+UgRcZSPKNAJMp7Ax+TCHu2wKJ/O?=
 =?us-ascii?Q?ypoB4X76n11PmMiGNU0NGvuATW8Fci9lkjZnvPrZwAcH7sF2O/4Ek+qHZePF?=
 =?us-ascii?Q?AUHBffLaIBT/Ws81o1Ta0FZUTNzWAFEeIsrHfYOZfjhrdlr8hzSAT8oiW39W?=
 =?us-ascii?Q?VvWnhdGBfHDIrq/OIHXJsRfHvm5TMFY8CtU4RiEoesjaX55iDX/eV12lBmG3?=
 =?us-ascii?Q?VQpaaqBeqh6YxDMvO7Dr8m/GLgw1+5VKbfNFiC4QcCu3Vvu8aF8a7+WmEouT?=
 =?us-ascii?Q?woXwiee7LVVEv17MU8wzsVl08kKeCkWbUSK+wdxaTUO9PegR7LXWt0eAPbkN?=
 =?us-ascii?Q?4KK6i1HKQmuZFaDL7KbpySBXbzLF1ytrBuWusrynTK9UXORJHqdZl4GahGtm?=
 =?us-ascii?Q?Fj6RUkeOvJ8UEL1r+Uuw6y2s8X0k0b1QecdDc4LTJsuVnDS3c0jivhNt9spD?=
 =?us-ascii?Q?VRWbXg0MqLJWWjx9uan6897HfhW4IQ3IwSmj/vkDt6oVYlhqWMtjqPNpwj6S?=
 =?us-ascii?Q?FSir5nIwEfquVygWn3fSeo/NJfoFFM8WNdP618nDX6ERgYmyYyS/G9cpodRY?=
 =?us-ascii?Q?pLJJvMsMXktpUzVjJDh3H+gzmXC3x/okkR24sC9IGs9pm5U3x5vbF6FGS5SZ?=
 =?us-ascii?Q?0ifPNNPOzwOFbcGA2TfeJ6UyKA6XE6+W9wZc/ae/qttH0JPWo7wLHjrlnSeS?=
 =?us-ascii?Q?X6qRrUjIJnBBsGoFukB//myWNmJ9dTB06njbN1Vrfz7NKJlNFYYXES/9biBA?=
 =?us-ascii?Q?4+9c90VeBobnmkwRrm3afxOWrE6hwKTbIgnP7Jt1Q0SD7YzSRAL4ho0EpzHa?=
 =?us-ascii?Q?cUsnfwgPo0js69DnQIq/A+oKDuFMBniy7whs8L2b?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691207f0-048d-4a81-2058-08dd05aede29
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:51:18.4084 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4xIIS1PZPjClsu5LxUzMVbXUqkasE8zsXaWN5iKiXzkZRm0syRxt8TP2yiQWxHR3zaHfDYIdcHQnyoqUW13aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3118
X-Mailman-Approved-At: Fri, 15 Nov 2024 23:35:33 +0100
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

Add support for PHYTEC phyCORE-AM62A7 SoM.

Supported features:
  - 2GB LPDDR4 RAM
  - eMMC
  - External SD
  - Ethernet
  - debug UART

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 arch/arm/dts/Makefile                         |    4 +-
 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi |  454 +++
 .../dts/k3-am62a-phycore-som-ddr4-2gb.dtsi    | 2798 +++++++++++++++++
 .../k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi   |  252 ++
 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts |  137 +
 arch/arm/mach-k3/am62ax/Kconfig               |   21 +
 board/phytec/phycore_am62ax/Kconfig           |   37 +
 board/phytec/phycore_am62ax/MAINTAINERS       |   14 +
 board/phytec/phycore_am62ax/Makefile          |    6 +
 board/phytec/phycore_am62ax/board-cfg.yaml    |   36 +
 board/phytec/phycore_am62ax/phycore-am62ax.c  |   66 +
 .../phytec/phycore_am62ax/phycore_am62ax.env  |   14 +
 board/phytec/phycore_am62ax/pm-cfg.yaml       |   12 +
 board/phytec/phycore_am62ax/rm-cfg.yaml       | 1047 ++++++
 board/phytec/phycore_am62ax/sec-cfg.yaml      |  379 +++
 board/phytec/phycore_am62ax/tifs-rm-cfg.yaml  |  903 ++++++
 configs/phycore_am62ax_a53_defconfig          |  181 ++
 configs/phycore_am62ax_r5_defconfig           |  129 +
 include/configs/phycore_am62ax.h              |   15 +
 19 files changed, 6504 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
 create mode 100644 arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
 create mode 100644 arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
 create mode 100644 arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
 create mode 100644 board/phytec/phycore_am62ax/Kconfig
 create mode 100644 board/phytec/phycore_am62ax/MAINTAINERS
 create mode 100644 board/phytec/phycore_am62ax/Makefile
 create mode 100644 board/phytec/phycore_am62ax/board-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/phycore-am62ax.c
 create mode 100644 board/phytec/phycore_am62ax/phycore_am62ax.env
 create mode 100644 board/phytec/phycore_am62ax/pm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/rm-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/sec-cfg.yaml
 create mode 100644 board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
 create mode 100644 configs/phycore_am62ax_a53_defconfig
 create mode 100644 configs/phycore_am62ax_r5_defconfig
 create mode 100644 include/configs/phycore_am62ax.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 042282f3723..b92e5ce6d99 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1183,7 +1183,9 @@ dtb-$(CONFIG_SOC_K3_AM625) += k3-am625-r5-sk.dtb \
 			      k3-am625-verdin-r5.dtb \
 			      k3-am625-r5-phycore-som-2gb.dtb
 
-dtb-$(CONFIG_SOC_K3_AM62A7) += k3-am62a7-r5-sk.dtb
+dtb-$(CONFIG_SOC_K3_AM62A7) += \
+	k3-am62a7-r5-sk.dtb \
+	k3-am62a7-r5-phycore-som-2gb.dtb
 
 dtb-$(CONFIG_SOC_K3_AM62P5) += k3-am62p5-r5-sk.dtb
 
diff --git a/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
new file mode 100644
index 00000000000..640361e0fd1
--- /dev/null
+++ b/arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Based on k3-am62a-sk-binman.dtsi
+ *
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ */
+
+#include "k3-binman.dtsi"
+
+#ifdef CONFIG_TARGET_PHYCORE_AM62AX_R5
+
+&rcfg_yaml_tifs {
+	config = "tifs-rm-cfg.yaml";
+};
+
+&binman {
+	tiboot3-am62ax-hs-phycore-som.bin {
+		filename = "tiboot3-am62ax-hs-phycore-som.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
+				<&combined_dm_cfg>, <&sysfw_inner_cert>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl>;
+			content-sysfw = <&ti_fs_enc>;
+			content-sysfw-data = <&combined_tifs_cfg>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert>;
+			content-dm-data = <&combined_dm_cfg>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_dm_cfg: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
+&binman {
+	tiboot3-am62ax-hs-fs-phycore-som.bin {
+		filename = "tiboot3-am62ax-hs-fs-phycore-som.bin";
+		symlink = "tiboot3.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
+				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_fs>;
+			content-sysfw = <&ti_fs_enc_fs>;
+			content-sysfw-data = <&combined_tifs_cfg_fs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
+			content-dm-data = <&combined_dm_cfg_fs>;
+			load = <0x43c00000>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl_fs: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc_fs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert_fs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62ax-hs-fs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_dm_cfg_fs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+
+&binman {
+	tiboot3-am62ax-gp-phycore-som.bin {
+		filename = "tiboot3-am62ax-gp-phycore-som.bin";
+		ti-secure-rom {
+			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
+				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
+			combined;
+			dm-data;
+			content-sbl = <&u_boot_spl_unsigned>;
+			load = <0x43c00000>;
+			content-sysfw = <&ti_fs_gp>;
+			load-sysfw = <0x40000>;
+			content-sysfw-data = <&combined_tifs_cfg_gp>;
+			load-sysfw-data = <0x67000>;
+			content-dm-data = <&combined_dm_cfg_gp>;
+			load-dm-data = <0x43c3a800>;
+			sw-rev = <1>;
+			keyfile = "ti-degenerate-key.pem";
+		};
+		u_boot_spl_unsigned: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_gp: ti-fs-gp.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62ax-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
+#endif
+
+#ifdef CONFIG_TARGET_PHYCORE_AM62AX_A53
+
+#define SPL_AM62A7_PHYBOARD_LYRA_DTB "spl/dts/ti/k3-am62a7-phyboard-lyra-rdk.dtb"
+#define AM62A7_PHYBOARD_LYRA_DTB "u-boot.dtb"
+
+&binman {
+	ti-dm {
+		filename = "ti-dm.bin";
+		blob-ext {
+			filename = "ti-dm/am62axx/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+			optional;
+		};
+	};
+
+	tifsstub-hs {
+		filename = "tifsstub.bin_hs";
+		ti-secure-rom {
+			content = <&tifsstub_hs_cert>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "custMpk.pem";
+			countersign;
+			tifsstub;
+		};
+		tifsstub_hs_cert: tifsstub-hs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_hs_enc: tifsstub-hs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	tifsstub-fs {
+		filename = "tifsstub.bin_fs";
+		tifsstub_fs_cert: tifsstub-fs-cert.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-cert.bin";
+			type = "blob-ext";
+			optional;
+		};
+		tifsstub_fs_enc: tifsstub-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-hs-enc.bin";
+			type = "blob-ext";
+			optional;
+		};
+
+	};
+
+	tifsstub-gp {
+		filename = "tifsstub.bin_gp";
+		ti-secure-rom {
+			content = <&tifsstub_gp>;
+			core = "secure";
+			load = <0x60000>;
+			sw-rev = <CONFIG_K3_X509_SWRV>;
+			keyfile = "ti-degenerate-key.pem";
+			tifsstub;
+		};
+		tifsstub_gp: tifsstub-gp.bin {
+			filename = "ti-sysfw/ti-fs-stub-firmware-am62ax-gp.bin";
+			type = "blob-ext";
+			optional;
+		};
+	};
+
+	ti-spl {
+		insert-template = <&ti_spl_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+
+				tifsstub-fs {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+
+				tifsstub-gp {
+					description = "TIFSSTUB";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-secure {
+						content = <&dm>;
+						keyfile = "custMpk.pem";
+					};
+					dm: ti-dm {
+						filename = "ti-dm.bin";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&spl_am62a7_phyboard_lyra_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					spl_am62a7_phyboard_lyra_dtb: blob-ext {
+						filename = SPL_AM62A7_PHYBOARD_LYRA_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl",
+					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	u-boot {
+		insert-template = <&u_boot_template>;
+
+		fit {
+			images {
+				uboot {
+					description = "U-Boot for AM62Ax board";
+				};
+
+				fdt-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					ti-secure {
+						content = <&am62a7_phyboard_lyra_dtb>;
+						keyfile = "custMpk.pem";
+					};
+					am62a7_phyboard_lyra_dtb: blob-ext {
+						filename = AM62A7_PHYBOARD_LYRA_DTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	ti-spl_unsigned {
+		insert-template = <&ti_spl_unsigned_template>;
+
+		fit {
+			images {
+				tifsstub-hs {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-hs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_hs";
+					};
+				};
+
+				tifsstub-fs {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-fs";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_fs";
+					};
+				};
+
+				tifsstub-gp {
+					description = "tifsstub";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "tifsstub-gp";
+					load = <0x9ca00000>;
+					entry = <0x9ca00000>;
+					blob-ext {
+						filename = "tifsstub.bin_gp";
+					};
+				};
+				dm {
+					ti-dm {
+						filename = "ti-dm.bin";
+					};
+				};
+
+				fdt-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					spl_am62a7_phyboard_lyra_dtb_unsigned: blob {
+						filename = SPL_AM62A7_PHYBOARD_LYRA_DTB;
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					firmware = "atf";
+					loadables = "tee", "dm", "spl",
+					"tifsstub-hs", "tifsstub-fs", "tifsstub-gp";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+
+&binman {
+	u-boot_unsigned {
+		insert-template = <&u_boot_unsigned_template>;
+
+		fit {
+			images {
+				uboot {
+					description = "U-Boot for AM62Ax board";
+				};
+
+				fdt-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+					blob {
+						filename = AM62A7_PHYBOARD_LYRA_DTB;
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = "k3-am62a7-phyboard-lyra-rdk";
+					firmware = "uboot";
+					loadables = "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
+#endif
diff --git a/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi b/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
new file mode 100644
index 00000000000..00330b43fed
--- /dev/null
+++ b/arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsi
@@ -0,0 +1,2798 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * This file was generated with the
+ * AM62Ax SysConfig DDR Subsystem Register Configuration Tool v0.09.08
+ * Fri Mar 24 2024 11:56:13 GMT-0700 (Pacific Daylight Time)
+ * DDR Type: LPDDR4
+ * F0 = 50MHz    F1 = NA     F2 = 1866MHz
+ * Density (per channel): 8Gb
+ * Number of Ranks: 1
+ */
+
+#define DDRSS_PLL_FHS_CNT 3
+#define DDRSS_PLL_FREQUENCY_1 933000000
+#define DDRSS_PLL_FREQUENCY_2 933000000
+
+#define DDRSS_CTL_0_DATA 0x00000B00
+#define DDRSS_CTL_1_DATA 0x00000000
+#define DDRSS_CTL_2_DATA 0x00000000
+#define DDRSS_CTL_3_DATA 0x00000000
+#define DDRSS_CTL_4_DATA 0x00000000
+#define DDRSS_CTL_5_DATA 0x00000000
+#define DDRSS_CTL_6_DATA 0x00000000
+#define DDRSS_CTL_7_DATA 0x00002710
+#define DDRSS_CTL_8_DATA 0x000186A0
+#define DDRSS_CTL_9_DATA 0x00000005
+#define DDRSS_CTL_10_DATA 0x00000064
+#define DDRSS_CTL_11_DATA 0x0005B18F
+#define DDRSS_CTL_12_DATA 0x0038EF90
+#define DDRSS_CTL_13_DATA 0x00000005
+#define DDRSS_CTL_14_DATA 0x00000E94
+#define DDRSS_CTL_15_DATA 0x0005B18F
+#define DDRSS_CTL_16_DATA 0x0038EF90
+#define DDRSS_CTL_17_DATA 0x00000005
+#define DDRSS_CTL_18_DATA 0x00000E94
+#define DDRSS_CTL_19_DATA 0x01010100
+#define DDRSS_CTL_20_DATA 0x01010100
+#define DDRSS_CTL_21_DATA 0x01000110
+#define DDRSS_CTL_22_DATA 0x02010002
+#define DDRSS_CTL_23_DATA 0x0000000A
+#define DDRSS_CTL_24_DATA 0x000186A0
+#define DDRSS_CTL_25_DATA 0x00000000
+#define DDRSS_CTL_26_DATA 0x00000000
+#define DDRSS_CTL_27_DATA 0x00000000
+#define DDRSS_CTL_28_DATA 0x00000000
+#define DDRSS_CTL_29_DATA 0x00020200
+#define DDRSS_CTL_30_DATA 0x00000000
+#define DDRSS_CTL_31_DATA 0x00000000
+#define DDRSS_CTL_32_DATA 0x00000000
+#define DDRSS_CTL_33_DATA 0x00000000
+#define DDRSS_CTL_34_DATA 0x08000010
+#define DDRSS_CTL_35_DATA 0x00004B4B
+#define DDRSS_CTL_36_DATA 0x00000000
+#define DDRSS_CTL_37_DATA 0x00000000
+#define DDRSS_CTL_38_DATA 0x00000000
+#define DDRSS_CTL_39_DATA 0x00000000
+#define DDRSS_CTL_40_DATA 0x0000040C
+#define DDRSS_CTL_41_DATA 0x00000000
+#define DDRSS_CTL_42_DATA 0x00001040
+#define DDRSS_CTL_43_DATA 0x00000000
+#define DDRSS_CTL_44_DATA 0x00001040
+#define DDRSS_CTL_45_DATA 0x00000000
+#define DDRSS_CTL_46_DATA 0x05000804
+#define DDRSS_CTL_47_DATA 0x00000700
+#define DDRSS_CTL_48_DATA 0x09090004
+#define DDRSS_CTL_49_DATA 0x00000303
+#define DDRSS_CTL_50_DATA 0x00720014
+#define DDRSS_CTL_51_DATA 0x09140050
+#define DDRSS_CTL_52_DATA 0x00004D22
+#define DDRSS_CTL_53_DATA 0x00720014
+#define DDRSS_CTL_54_DATA 0x09140050
+#define DDRSS_CTL_55_DATA 0x09004D22
+#define DDRSS_CTL_56_DATA 0x000A0A09
+#define DDRSS_CTL_57_DATA 0x040006DB
+#define DDRSS_CTL_58_DATA 0x090F2005
+#define DDRSS_CTL_59_DATA 0x00001B13
+#define DDRSS_CTL_60_DATA 0x0E00FFCD
+#define DDRSS_CTL_61_DATA 0x090F200F
+#define DDRSS_CTL_62_DATA 0x00001B13
+#define DDRSS_CTL_63_DATA 0x0E00FFCD
+#define DDRSS_CTL_64_DATA 0x0304200F
+#define DDRSS_CTL_65_DATA 0x04050002
+#define DDRSS_CTL_66_DATA 0x24232423
+#define DDRSS_CTL_67_DATA 0x01010008
+#define DDRSS_CTL_68_DATA 0x04464607
+#define DDRSS_CTL_69_DATA 0x03282803
+#define DDRSS_CTL_70_DATA 0x00002828
+#define DDRSS_CTL_71_DATA 0x00000101
+#define DDRSS_CTL_72_DATA 0x00000000
+#define DDRSS_CTL_73_DATA 0x01000000
+#define DDRSS_CTL_74_DATA 0x000E0803
+#define DDRSS_CTL_75_DATA 0x000000BB
+#define DDRSS_CTL_76_DATA 0x0000020B
+#define DDRSS_CTL_77_DATA 0x00001C64
+#define DDRSS_CTL_78_DATA 0x0000020B
+#define DDRSS_CTL_79_DATA 0x00001C64
+#define DDRSS_CTL_80_DATA 0x00000005
+#define DDRSS_CTL_81_DATA 0x00000007
+#define DDRSS_CTL_82_DATA 0x00000010
+#define DDRSS_CTL_83_DATA 0x00000106
+#define DDRSS_CTL_84_DATA 0x00000386
+#define DDRSS_CTL_85_DATA 0x00000106
+#define DDRSS_CTL_86_DATA 0x00000386
+#define DDRSS_CTL_87_DATA 0x03004000
+#define DDRSS_CTL_88_DATA 0x00001201
+#define DDRSS_CTL_89_DATA 0x000E0005
+#define DDRSS_CTL_90_DATA 0x2608000E
+#define DDRSS_CTL_91_DATA 0x0A050526
+#define DDRSS_CTL_92_DATA 0x1B0E0A03
+#define DDRSS_CTL_93_DATA 0x1B0E0A04
+#define DDRSS_CTL_94_DATA 0x04010104
+#define DDRSS_CTL_95_DATA 0x00010401
+#define DDRSS_CTL_96_DATA 0x000F000F
+#define DDRSS_CTL_97_DATA 0x02190219
+#define DDRSS_CTL_98_DATA 0x02190219
+#define DDRSS_CTL_99_DATA 0x00000000
+#define DDRSS_CTL_100_DATA 0x03030000
+#define DDRSS_CTL_101_DATA 0x05050501
+#define DDRSS_CTL_102_DATA 0x04041C04
+#define DDRSS_CTL_103_DATA 0x0E0A0E0A
+#define DDRSS_CTL_104_DATA 0x0A04041C
+#define DDRSS_CTL_105_DATA 0x030E0A0E
+#define DDRSS_CTL_106_DATA 0x00000404
+#define DDRSS_CTL_107_DATA 0x00000301
+#define DDRSS_CTL_108_DATA 0x00000001
+#define DDRSS_CTL_109_DATA 0x00000000
+#define DDRSS_CTL_110_DATA 0x40020100
+#define DDRSS_CTL_111_DATA 0x00038010
+#define DDRSS_CTL_112_DATA 0x00050004
+#define DDRSS_CTL_113_DATA 0x00000004
+#define DDRSS_CTL_114_DATA 0x00040003
+#define DDRSS_CTL_115_DATA 0x00040005
+#define DDRSS_CTL_116_DATA 0x00030000
+#define DDRSS_CTL_117_DATA 0x00050004
+#define DDRSS_CTL_118_DATA 0x00000004
+#define DDRSS_CTL_119_DATA 0x00002EC0
+#define DDRSS_CTL_120_DATA 0x00002EC0
+#define DDRSS_CTL_121_DATA 0x00002EC0
+#define DDRSS_CTL_122_DATA 0x00002EC0
+#define DDRSS_CTL_123_DATA 0x00002EC0
+#define DDRSS_CTL_124_DATA 0x00000000
+#define DDRSS_CTL_125_DATA 0x0000051D
+#define DDRSS_CTL_126_DATA 0x00071900
+#define DDRSS_CTL_127_DATA 0x00071900
+#define DDRSS_CTL_128_DATA 0x00071900
+#define DDRSS_CTL_129_DATA 0x00071900
+#define DDRSS_CTL_130_DATA 0x00071900
+#define DDRSS_CTL_131_DATA 0x00000000
+#define DDRSS_CTL_132_DATA 0x0000C6BC
+#define DDRSS_CTL_133_DATA 0x00071900
+#define DDRSS_CTL_134_DATA 0x00071900
+#define DDRSS_CTL_135_DATA 0x00071900
+#define DDRSS_CTL_136_DATA 0x00071900
+#define DDRSS_CTL_137_DATA 0x00071900
+#define DDRSS_CTL_138_DATA 0x00000000
+#define DDRSS_CTL_139_DATA 0x0000C6BC
+#define DDRSS_CTL_140_DATA 0x00000000
+#define DDRSS_CTL_141_DATA 0x00000000
+#define DDRSS_CTL_142_DATA 0x00000000
+#define DDRSS_CTL_143_DATA 0x00000000
+#define DDRSS_CTL_144_DATA 0x00000000
+#define DDRSS_CTL_145_DATA 0x00000000
+#define DDRSS_CTL_146_DATA 0x00000000
+#define DDRSS_CTL_147_DATA 0x00000000
+#define DDRSS_CTL_148_DATA 0x00000000
+#define DDRSS_CTL_149_DATA 0x00000000
+#define DDRSS_CTL_150_DATA 0x00000000
+#define DDRSS_CTL_151_DATA 0x00000000
+#define DDRSS_CTL_152_DATA 0x00000000
+#define DDRSS_CTL_153_DATA 0x00000000
+#define DDRSS_CTL_154_DATA 0x00000000
+#define DDRSS_CTL_155_DATA 0x00000000
+#define DDRSS_CTL_156_DATA 0x00000000
+#define DDRSS_CTL_157_DATA 0x00000000
+#define DDRSS_CTL_158_DATA 0x03050000
+#define DDRSS_CTL_159_DATA 0x040A040A
+#define DDRSS_CTL_160_DATA 0x00000000
+#define DDRSS_CTL_161_DATA 0x08010000
+#define DDRSS_CTL_162_DATA 0x000E0808
+#define DDRSS_CTL_163_DATA 0x01000000
+#define DDRSS_CTL_164_DATA 0x0E080808
+#define DDRSS_CTL_165_DATA 0x00000000
+#define DDRSS_CTL_166_DATA 0x08080801
+#define DDRSS_CTL_167_DATA 0x0000080E
+#define DDRSS_CTL_168_DATA 0x00040003
+#define DDRSS_CTL_169_DATA 0x00000007
+#define DDRSS_CTL_170_DATA 0x00000000
+#define DDRSS_CTL_171_DATA 0x00000000
+#define DDRSS_CTL_172_DATA 0x00000000
+#define DDRSS_CTL_173_DATA 0x00000000
+#define DDRSS_CTL_174_DATA 0x00000000
+#define DDRSS_CTL_175_DATA 0x00000000
+#define DDRSS_CTL_176_DATA 0x01000000
+#define DDRSS_CTL_177_DATA 0x00000000
+#define DDRSS_CTL_178_DATA 0x00001700
+#define DDRSS_CTL_179_DATA 0x0000100E
+#define DDRSS_CTL_180_DATA 0x00000002
+#define DDRSS_CTL_181_DATA 0x00000000
+#define DDRSS_CTL_182_DATA 0x00000001
+#define DDRSS_CTL_183_DATA 0x00000002
+#define DDRSS_CTL_184_DATA 0x00000C00
+#define DDRSS_CTL_185_DATA 0x00008000
+#define DDRSS_CTL_186_DATA 0x00000C00
+#define DDRSS_CTL_187_DATA 0x00008000
+#define DDRSS_CTL_188_DATA 0x00000C00
+#define DDRSS_CTL_189_DATA 0x00008000
+#define DDRSS_CTL_190_DATA 0x00000000
+#define DDRSS_CTL_191_DATA 0x00000000
+#define DDRSS_CTL_192_DATA 0x00000000
+#define DDRSS_CTL_193_DATA 0x00000000
+#define DDRSS_CTL_194_DATA 0x00000000
+#define DDRSS_CTL_195_DATA 0x0005000A
+#define DDRSS_CTL_196_DATA 0x0404000D
+#define DDRSS_CTL_197_DATA 0x0000000D
+#define DDRSS_CTL_198_DATA 0x00BB0176
+#define DDRSS_CTL_199_DATA 0x0E0E01D3
+#define DDRSS_CTL_200_DATA 0x000001D3
+#define DDRSS_CTL_201_DATA 0x00BB0176
+#define DDRSS_CTL_202_DATA 0x0E0E01D3
+#define DDRSS_CTL_203_DATA 0x000001D3
+#define DDRSS_CTL_204_DATA 0x00000000
+#define DDRSS_CTL_205_DATA 0x00000000
+#define DDRSS_CTL_206_DATA 0x00000000
+#define DDRSS_CTL_207_DATA 0x00000000
+#define DDRSS_CTL_208_DATA 0x00000004
+#define DDRSS_CTL_209_DATA 0x00000000
+#define DDRSS_CTL_210_DATA 0x00000000
+#define DDRSS_CTL_211_DATA 0x00000064
+#define DDRSS_CTL_212_DATA 0x00000036
+#define DDRSS_CTL_213_DATA 0x00000000
+#define DDRSS_CTL_214_DATA 0x00000064
+#define DDRSS_CTL_215_DATA 0x00000036
+#define DDRSS_CTL_216_DATA 0x00000000
+#define DDRSS_CTL_217_DATA 0x00000004
+#define DDRSS_CTL_218_DATA 0x00000000
+#define DDRSS_CTL_219_DATA 0x00000000
+#define DDRSS_CTL_220_DATA 0x00000064
+#define DDRSS_CTL_221_DATA 0x00000036
+#define DDRSS_CTL_222_DATA 0x00000000
+#define DDRSS_CTL_223_DATA 0x00000064
+#define DDRSS_CTL_224_DATA 0x00000036
+#define DDRSS_CTL_225_DATA 0x00000000
+#define DDRSS_CTL_226_DATA 0x00000000
+#define DDRSS_CTL_227_DATA 0x00000031
+#define DDRSS_CTL_228_DATA 0x000000B1
+#define DDRSS_CTL_229_DATA 0x000000B1
+#define DDRSS_CTL_230_DATA 0x00000031
+#define DDRSS_CTL_231_DATA 0x000000B1
+#define DDRSS_CTL_232_DATA 0x000000B1
+#define DDRSS_CTL_233_DATA 0x00000000
+#define DDRSS_CTL_234_DATA 0x00000000
+#define DDRSS_CTL_235_DATA 0x00000000
+#define DDRSS_CTL_236_DATA 0x00000000
+#define DDRSS_CTL_237_DATA 0x00000000
+#define DDRSS_CTL_238_DATA 0x00000000
+#define DDRSS_CTL_239_DATA 0x00000000
+#define DDRSS_CTL_240_DATA 0x00000000
+#define DDRSS_CTL_241_DATA 0x00000000
+#define DDRSS_CTL_242_DATA 0x00000000
+#define DDRSS_CTL_243_DATA 0x00000000
+#define DDRSS_CTL_244_DATA 0x00000000
+#define DDRSS_CTL_245_DATA 0x00000000
+#define DDRSS_CTL_246_DATA 0x00000000
+#define DDRSS_CTL_247_DATA 0x00000000
+#define DDRSS_CTL_248_DATA 0x00000000
+#define DDRSS_CTL_249_DATA 0x00000000
+#define DDRSS_CTL_250_DATA 0x00000000
+#define DDRSS_CTL_251_DATA 0x00000000
+#define DDRSS_CTL_252_DATA 0x00000000
+#define DDRSS_CTL_253_DATA 0x00000000
+#define DDRSS_CTL_254_DATA 0x00000000
+#define DDRSS_CTL_255_DATA 0x00000000
+#define DDRSS_CTL_256_DATA 0x00000000
+#define DDRSS_CTL_257_DATA 0x55005555
+#define DDRSS_CTL_258_DATA 0x00002755
+#define DDRSS_CTL_259_DATA 0x00000027
+#define DDRSS_CTL_260_DATA 0x00000027
+#define DDRSS_CTL_261_DATA 0x00000027
+#define DDRSS_CTL_262_DATA 0x00000027
+#define DDRSS_CTL_263_DATA 0x00000027
+#define DDRSS_CTL_264_DATA 0x00000000
+#define DDRSS_CTL_265_DATA 0x00000000
+#define DDRSS_CTL_266_DATA 0x0000002B
+#define DDRSS_CTL_267_DATA 0x0000002B
+#define DDRSS_CTL_268_DATA 0x0000002B
+#define DDRSS_CTL_269_DATA 0x0000002B
+#define DDRSS_CTL_270_DATA 0x0000002B
+#define DDRSS_CTL_271_DATA 0x0000002B
+#define DDRSS_CTL_272_DATA 0x00000000
+#define DDRSS_CTL_273_DATA 0x00000000
+#define DDRSS_CTL_274_DATA 0x00000016
+#define DDRSS_CTL_275_DATA 0x00000016
+#define DDRSS_CTL_276_DATA 0x00000000
+#define DDRSS_CTL_277_DATA 0x00000016
+#define DDRSS_CTL_278_DATA 0x00000016
+#define DDRSS_CTL_279_DATA 0x00000020
+#define DDRSS_CTL_280_DATA 0x00010000
+#define DDRSS_CTL_281_DATA 0x00000100
+#define DDRSS_CTL_282_DATA 0x00000000
+#define DDRSS_CTL_283_DATA 0x00000000
+#define DDRSS_CTL_284_DATA 0x00000101
+#define DDRSS_CTL_285_DATA 0x00000000
+#define DDRSS_CTL_286_DATA 0x00000000
+#define DDRSS_CTL_287_DATA 0x00000000
+#define DDRSS_CTL_288_DATA 0x00000000
+#define DDRSS_CTL_289_DATA 0x00000000
+#define DDRSS_CTL_290_DATA 0x00000000
+#define DDRSS_CTL_291_DATA 0x00000000
+#define DDRSS_CTL_292_DATA 0x00000000
+#define DDRSS_CTL_293_DATA 0x00000000
+#define DDRSS_CTL_294_DATA 0x00000000
+#define DDRSS_CTL_295_DATA 0x00000000
+#define DDRSS_CTL_296_DATA 0x0C181511
+#define DDRSS_CTL_297_DATA 0x00000304
+#define DDRSS_CTL_298_DATA 0x00000000
+#define DDRSS_CTL_299_DATA 0x00000000
+#define DDRSS_CTL_300_DATA 0x00000000
+#define DDRSS_CTL_301_DATA 0x00000000
+#define DDRSS_CTL_302_DATA 0x00000000
+#define DDRSS_CTL_303_DATA 0x00000000
+#define DDRSS_CTL_304_DATA 0x00000000
+#define DDRSS_CTL_305_DATA 0x00000000
+#define DDRSS_CTL_306_DATA 0x00000000
+#define DDRSS_CTL_307_DATA 0x00000000
+#define DDRSS_CTL_308_DATA 0x00000000
+#define DDRSS_CTL_309_DATA 0x00000000
+#define DDRSS_CTL_310_DATA 0x00000000
+#define DDRSS_CTL_311_DATA 0x00020000
+#define DDRSS_CTL_312_DATA 0x00400100
+#define DDRSS_CTL_313_DATA 0x00080032
+#define DDRSS_CTL_314_DATA 0x01000200
+#define DDRSS_CTL_315_DATA 0x074A0040
+#define DDRSS_CTL_316_DATA 0x00020038
+#define DDRSS_CTL_317_DATA 0x00400100
+#define DDRSS_CTL_318_DATA 0x0038074A
+#define DDRSS_CTL_319_DATA 0x00030000
+#define DDRSS_CTL_320_DATA 0x005E005E
+#define DDRSS_CTL_321_DATA 0x00000100
+#define DDRSS_CTL_322_DATA 0x01010000
+#define DDRSS_CTL_323_DATA 0x00000101
+#define DDRSS_CTL_324_DATA 0x1FFF0000
+#define DDRSS_CTL_325_DATA 0x000FFF00
+#define DDRSS_CTL_326_DATA 0xFFFFFFFF
+#define DDRSS_CTL_327_DATA 0x00FFFF00
+#define DDRSS_CTL_328_DATA 0x0B000000
+#define DDRSS_CTL_329_DATA 0x0001FFFF
+#define DDRSS_CTL_330_DATA 0x01010101
+#define DDRSS_CTL_331_DATA 0x01010101
+#define DDRSS_CTL_332_DATA 0x00000118
+#define DDRSS_CTL_333_DATA 0x00000C01
+#define DDRSS_CTL_334_DATA 0x00040100
+#define DDRSS_CTL_335_DATA 0x00040100
+#define DDRSS_CTL_336_DATA 0x00000000
+#define DDRSS_CTL_337_DATA 0x00000000
+#define DDRSS_CTL_338_DATA 0x01030303
+#define DDRSS_CTL_339_DATA 0x00000001
+#define DDRSS_CTL_340_DATA 0x00000000
+#define DDRSS_CTL_341_DATA 0x00000000
+#define DDRSS_CTL_342_DATA 0x00000000
+#define DDRSS_CTL_343_DATA 0x00000000
+#define DDRSS_CTL_344_DATA 0x00000000
+#define DDRSS_CTL_345_DATA 0x00000000
+#define DDRSS_CTL_346_DATA 0x00000000
+#define DDRSS_CTL_347_DATA 0x00000000
+#define DDRSS_CTL_348_DATA 0x00000000
+#define DDRSS_CTL_349_DATA 0x00000000
+#define DDRSS_CTL_350_DATA 0x00000000
+#define DDRSS_CTL_351_DATA 0x00000000
+#define DDRSS_CTL_352_DATA 0x00000000
+#define DDRSS_CTL_353_DATA 0x00000000
+#define DDRSS_CTL_354_DATA 0x00000000
+#define DDRSS_CTL_355_DATA 0x00000000
+#define DDRSS_CTL_356_DATA 0x00000000
+#define DDRSS_CTL_357_DATA 0x00000000
+#define DDRSS_CTL_358_DATA 0x00000000
+#define DDRSS_CTL_359_DATA 0x00000000
+#define DDRSS_CTL_360_DATA 0x00000000
+#define DDRSS_CTL_361_DATA 0x00000000
+#define DDRSS_CTL_362_DATA 0x00000000
+#define DDRSS_CTL_363_DATA 0x00000000
+#define DDRSS_CTL_364_DATA 0x00000000
+#define DDRSS_CTL_365_DATA 0x00000000
+#define DDRSS_CTL_366_DATA 0x00000000
+#define DDRSS_CTL_367_DATA 0x00000000
+#define DDRSS_CTL_368_DATA 0x00000000
+#define DDRSS_CTL_369_DATA 0x00000000
+#define DDRSS_CTL_370_DATA 0x00000000
+#define DDRSS_CTL_371_DATA 0x00000000
+#define DDRSS_CTL_372_DATA 0x00000000
+#define DDRSS_CTL_373_DATA 0x00000000
+#define DDRSS_CTL_374_DATA 0x00000000
+#define DDRSS_CTL_375_DATA 0x00000000
+#define DDRSS_CTL_376_DATA 0x00000000
+#define DDRSS_CTL_377_DATA 0x00000000
+#define DDRSS_CTL_378_DATA 0x00000000
+#define DDRSS_CTL_379_DATA 0x00000000
+#define DDRSS_CTL_380_DATA 0x00000000
+#define DDRSS_CTL_381_DATA 0x00000000
+#define DDRSS_CTL_382_DATA 0x00000000
+#define DDRSS_CTL_383_DATA 0x01000101
+#define DDRSS_CTL_384_DATA 0x01010001
+#define DDRSS_CTL_385_DATA 0x00010101
+#define DDRSS_CTL_386_DATA 0x01090903
+#define DDRSS_CTL_387_DATA 0x05020201
+#define DDRSS_CTL_388_DATA 0x0E081B1B
+#define DDRSS_CTL_389_DATA 0x0008030E
+#define DDRSS_CTL_390_DATA 0x0B12030E
+#define DDRSS_CTL_391_DATA 0x0B120314
+#define DDRSS_CTL_392_DATA 0x12120814
+#define DDRSS_CTL_393_DATA 0x01000000
+#define DDRSS_CTL_394_DATA 0x07030701
+#define DDRSS_CTL_395_DATA 0x04000103
+#define DDRSS_CTL_396_DATA 0x1B000004
+#define DDRSS_CTL_397_DATA 0x00000176
+#define DDRSS_CTL_398_DATA 0x00000200
+#define DDRSS_CTL_399_DATA 0x00000200
+#define DDRSS_CTL_400_DATA 0x00000200
+#define DDRSS_CTL_401_DATA 0x00000200
+#define DDRSS_CTL_402_DATA 0x00000693
+#define DDRSS_CTL_403_DATA 0x00000E9C
+#define DDRSS_CTL_404_DATA 0x03050202
+#define DDRSS_CTL_405_DATA 0x37200201
+#define DDRSS_CTL_406_DATA 0x000038C8
+#define DDRSS_CTL_407_DATA 0x00000200
+#define DDRSS_CTL_408_DATA 0x00000200
+#define DDRSS_CTL_409_DATA 0x00000200
+#define DDRSS_CTL_410_DATA 0x00000200
+#define DDRSS_CTL_411_DATA 0x0000FF84
+#define DDRSS_CTL_412_DATA 0x000237D0
+#define DDRSS_CTL_413_DATA 0x111F0402
+#define DDRSS_CTL_414_DATA 0x37200C0D
+#define DDRSS_CTL_415_DATA 0x000038C8
+#define DDRSS_CTL_416_DATA 0x00000200
+#define DDRSS_CTL_417_DATA 0x00000200
+#define DDRSS_CTL_418_DATA 0x00000200
+#define DDRSS_CTL_419_DATA 0x00000200
+#define DDRSS_CTL_420_DATA 0x0000FF84
+#define DDRSS_CTL_421_DATA 0x000237D0
+#define DDRSS_CTL_422_DATA 0x111F0402
+#define DDRSS_CTL_423_DATA 0x00200C0D
+#define DDRSS_CTL_424_DATA 0x00000000
+#define DDRSS_CTL_425_DATA 0x02000A00
+#define DDRSS_CTL_426_DATA 0x00050003
+#define DDRSS_CTL_427_DATA 0x00010101
+#define DDRSS_CTL_428_DATA 0x00010101
+#define DDRSS_CTL_429_DATA 0x00010001
+#define DDRSS_CTL_430_DATA 0x00000101
+#define DDRSS_CTL_431_DATA 0x02000201
+#define DDRSS_CTL_432_DATA 0x02010000
+#define DDRSS_CTL_433_DATA 0x06000200
+#define DDRSS_CTL_434_DATA 0x00002222
+#define DDRSS_PI_0_DATA 0x00000B00
+#define DDRSS_PI_1_DATA 0x00000000
+#define DDRSS_PI_2_DATA 0x00000000
+#define DDRSS_PI_3_DATA 0x01000000
+#define DDRSS_PI_4_DATA 0x00000001
+#define DDRSS_PI_5_DATA 0x00010064
+#define DDRSS_PI_6_DATA 0x00000000
+#define DDRSS_PI_7_DATA 0x00000000
+#define DDRSS_PI_8_DATA 0x00000000
+#define DDRSS_PI_9_DATA 0x00000000
+#define DDRSS_PI_10_DATA 0x00000000
+#define DDRSS_PI_11_DATA 0x00000002
+#define DDRSS_PI_12_DATA 0x00000005
+#define DDRSS_PI_13_DATA 0x00050001
+#define DDRSS_PI_14_DATA 0x08000000
+#define DDRSS_PI_15_DATA 0x00010300
+#define DDRSS_PI_16_DATA 0x00000005
+#define DDRSS_PI_17_DATA 0x00000000
+#define DDRSS_PI_18_DATA 0x00000000
+#define DDRSS_PI_19_DATA 0x00000000
+#define DDRSS_PI_20_DATA 0x00000000
+#define DDRSS_PI_21_DATA 0x00000000
+#define DDRSS_PI_22_DATA 0x00000000
+#define DDRSS_PI_23_DATA 0x00000000
+#define DDRSS_PI_24_DATA 0x00000000
+#define DDRSS_PI_25_DATA 0x00000000
+#define DDRSS_PI_26_DATA 0x01010000
+#define DDRSS_PI_27_DATA 0x0A000100
+#define DDRSS_PI_28_DATA 0x00000028
+#define DDRSS_PI_29_DATA 0x05000000
+#define DDRSS_PI_30_DATA 0x00320000
+#define DDRSS_PI_31_DATA 0x00000000
+#define DDRSS_PI_32_DATA 0x00000000
+#define DDRSS_PI_33_DATA 0x01010102
+#define DDRSS_PI_34_DATA 0x00000000
+#define DDRSS_PI_35_DATA 0x00000000
+#define DDRSS_PI_36_DATA 0x00000000
+#define DDRSS_PI_37_DATA 0x00000001
+#define DDRSS_PI_38_DATA 0x000000AA
+#define DDRSS_PI_39_DATA 0x00000055
+#define DDRSS_PI_40_DATA 0x000000B5
+#define DDRSS_PI_41_DATA 0x0000004A
+#define DDRSS_PI_42_DATA 0x00000056
+#define DDRSS_PI_43_DATA 0x000000A9
+#define DDRSS_PI_44_DATA 0x000000A9
+#define DDRSS_PI_45_DATA 0x000000B5
+#define DDRSS_PI_46_DATA 0x00000000
+#define DDRSS_PI_47_DATA 0x00000000
+#define DDRSS_PI_48_DATA 0x00050500
+#define DDRSS_PI_49_DATA 0x0000001A
+#define DDRSS_PI_50_DATA 0x000007D0
+#define DDRSS_PI_51_DATA 0x00000300
+#define DDRSS_PI_52_DATA 0x00000000
+#define DDRSS_PI_53_DATA 0x00000000
+#define DDRSS_PI_54_DATA 0x01000000
+#define DDRSS_PI_55_DATA 0x00010101
+#define DDRSS_PI_56_DATA 0x01000000
+#define DDRSS_PI_57_DATA 0x03000000
+#define DDRSS_PI_58_DATA 0x00000000
+#define DDRSS_PI_59_DATA 0x00001705
+#define DDRSS_PI_60_DATA 0x00000000
+#define DDRSS_PI_61_DATA 0x00000000
+#define DDRSS_PI_62_DATA 0x00000000
+#define DDRSS_PI_63_DATA 0x0A0A140A
+#define DDRSS_PI_64_DATA 0x10020101
+#define DDRSS_PI_65_DATA 0x01000210
+#define DDRSS_PI_66_DATA 0x05000404
+#define DDRSS_PI_67_DATA 0x00010001
+#define DDRSS_PI_68_DATA 0x0001000E
+#define DDRSS_PI_69_DATA 0x01010500
+#define DDRSS_PI_70_DATA 0x00010000
+#define DDRSS_PI_71_DATA 0x00000034
+#define DDRSS_PI_72_DATA 0x00000000
+#define DDRSS_PI_73_DATA 0x00000000
+#define DDRSS_PI_74_DATA 0x0000FFFF
+#define DDRSS_PI_75_DATA 0x00000000
+#define DDRSS_PI_76_DATA 0x00000000
+#define DDRSS_PI_77_DATA 0x00000000
+#define DDRSS_PI_78_DATA 0x00000000
+#define DDRSS_PI_79_DATA 0x01000000
+#define DDRSS_PI_80_DATA 0x01010001
+#define DDRSS_PI_81_DATA 0x02000008
+#define DDRSS_PI_82_DATA 0x01000200
+#define DDRSS_PI_83_DATA 0x00000100
+#define DDRSS_PI_84_DATA 0x02000100
+#define DDRSS_PI_85_DATA 0x02000200
+#define DDRSS_PI_86_DATA 0x00000000
+#define DDRSS_PI_87_DATA 0x00000000
+#define DDRSS_PI_88_DATA 0x00000000
+#define DDRSS_PI_89_DATA 0x00000000
+#define DDRSS_PI_90_DATA 0x00000000
+#define DDRSS_PI_91_DATA 0x00000000
+#define DDRSS_PI_92_DATA 0x00000000
+#define DDRSS_PI_93_DATA 0x00000000
+#define DDRSS_PI_94_DATA 0x00000000
+#define DDRSS_PI_95_DATA 0x00000000
+#define DDRSS_PI_96_DATA 0x00000000
+#define DDRSS_PI_97_DATA 0x00000000
+#define DDRSS_PI_98_DATA 0x00000000
+#define DDRSS_PI_99_DATA 0x01000400
+#define DDRSS_PI_100_DATA 0x0E0D0F10
+#define DDRSS_PI_101_DATA 0x080A1413
+#define DDRSS_PI_102_DATA 0x01000009
+#define DDRSS_PI_103_DATA 0x00000302
+#define DDRSS_PI_104_DATA 0x00000008
+#define DDRSS_PI_105_DATA 0x08000000
+#define DDRSS_PI_106_DATA 0x00000100
+#define DDRSS_PI_107_DATA 0x00000000
+#define DDRSS_PI_108_DATA 0x0000AA00
+#define DDRSS_PI_109_DATA 0x00000000
+#define DDRSS_PI_110_DATA 0x00000000
+#define DDRSS_PI_111_DATA 0x00010000
+#define DDRSS_PI_112_DATA 0x00000000
+#define DDRSS_PI_113_DATA 0x00000000
+#define DDRSS_PI_114_DATA 0x00000000
+#define DDRSS_PI_115_DATA 0x00000000
+#define DDRSS_PI_116_DATA 0x00000000
+#define DDRSS_PI_117_DATA 0x00000000
+#define DDRSS_PI_118_DATA 0x00000000
+#define DDRSS_PI_119_DATA 0x00000000
+#define DDRSS_PI_120_DATA 0x00000000
+#define DDRSS_PI_121_DATA 0x00000000
+#define DDRSS_PI_122_DATA 0x00000000
+#define DDRSS_PI_123_DATA 0x00000000
+#define DDRSS_PI_124_DATA 0x00000000
+#define DDRSS_PI_125_DATA 0x00000000
+#define DDRSS_PI_126_DATA 0x00000000
+#define DDRSS_PI_127_DATA 0x00000000
+#define DDRSS_PI_128_DATA 0x00000000
+#define DDRSS_PI_129_DATA 0x00000000
+#define DDRSS_PI_130_DATA 0x00000000
+#define DDRSS_PI_131_DATA 0x00000000
+#define DDRSS_PI_132_DATA 0x00000000
+#define DDRSS_PI_133_DATA 0x00000000
+#define DDRSS_PI_134_DATA 0x00000000
+#define DDRSS_PI_135_DATA 0x00000000
+#define DDRSS_PI_136_DATA 0x00000008
+#define DDRSS_PI_137_DATA 0x00000000
+#define DDRSS_PI_138_DATA 0x00000000
+#define DDRSS_PI_139_DATA 0x00000000
+#define DDRSS_PI_140_DATA 0x00000000
+#define DDRSS_PI_141_DATA 0x00000000
+#define DDRSS_PI_142_DATA 0x00000000
+#define DDRSS_PI_143_DATA 0x00000000
+#define DDRSS_PI_144_DATA 0x00000000
+#define DDRSS_PI_145_DATA 0x00010000
+#define DDRSS_PI_146_DATA 0x00000000
+#define DDRSS_PI_147_DATA 0x00000000
+#define DDRSS_PI_148_DATA 0x0000000A
+#define DDRSS_PI_149_DATA 0x000186A0
+#define DDRSS_PI_150_DATA 0x00000100
+#define DDRSS_PI_151_DATA 0x00000000
+#define DDRSS_PI_152_DATA 0x00000000
+#define DDRSS_PI_153_DATA 0x00000000
+#define DDRSS_PI_154_DATA 0x00000000
+#define DDRSS_PI_155_DATA 0x00000000
+#define DDRSS_PI_156_DATA 0x01000000
+#define DDRSS_PI_157_DATA 0x00010003
+#define DDRSS_PI_158_DATA 0x02000101
+#define DDRSS_PI_159_DATA 0x01030001
+#define DDRSS_PI_160_DATA 0x00010400
+#define DDRSS_PI_161_DATA 0x06000105
+#define DDRSS_PI_162_DATA 0x01070001
+#define DDRSS_PI_163_DATA 0x00000000
+#define DDRSS_PI_164_DATA 0x00000000
+#define DDRSS_PI_165_DATA 0x00000000
+#define DDRSS_PI_166_DATA 0x00010001
+#define DDRSS_PI_167_DATA 0x00000000
+#define DDRSS_PI_168_DATA 0x00000000
+#define DDRSS_PI_169_DATA 0x00000000
+#define DDRSS_PI_170_DATA 0x00000000
+#define DDRSS_PI_171_DATA 0x00010000
+#define DDRSS_PI_172_DATA 0x00000004
+#define DDRSS_PI_173_DATA 0x00000000
+#define DDRSS_PI_174_DATA 0x00010000
+#define DDRSS_PI_175_DATA 0x00000000
+#define DDRSS_PI_176_DATA 0x00080000
+#define DDRSS_PI_177_DATA 0x01180118
+#define DDRSS_PI_178_DATA 0x00262601
+#define DDRSS_PI_179_DATA 0x00000034
+#define DDRSS_PI_180_DATA 0x0000005E
+#define DDRSS_PI_181_DATA 0x0002005E
+#define DDRSS_PI_182_DATA 0x02000200
+#define DDRSS_PI_183_DATA 0x00000004
+#define DDRSS_PI_184_DATA 0x0000100C
+#define DDRSS_PI_185_DATA 0x00104000
+#define DDRSS_PI_186_DATA 0x00400000
+#define DDRSS_PI_187_DATA 0x0000000E
+#define DDRSS_PI_188_DATA 0x000000BB
+#define DDRSS_PI_189_DATA 0x0000020B
+#define DDRSS_PI_190_DATA 0x00001C64
+#define DDRSS_PI_191_DATA 0x0000020B
+#define DDRSS_PI_192_DATA 0x04001C64
+#define DDRSS_PI_193_DATA 0x01010404
+#define DDRSS_PI_194_DATA 0x00001501
+#define DDRSS_PI_195_DATA 0x00270027
+#define DDRSS_PI_196_DATA 0x01000100
+#define DDRSS_PI_197_DATA 0x00000100
+#define DDRSS_PI_198_DATA 0x00000000
+#define DDRSS_PI_199_DATA 0x05090903
+#define DDRSS_PI_200_DATA 0x01011B1B
+#define DDRSS_PI_201_DATA 0x01010101
+#define DDRSS_PI_202_DATA 0x000C0C0A
+#define DDRSS_PI_203_DATA 0x00000000
+#define DDRSS_PI_204_DATA 0x00000000
+#define DDRSS_PI_205_DATA 0x04000000
+#define DDRSS_PI_206_DATA 0x0C021212
+#define DDRSS_PI_207_DATA 0x0404020C
+#define DDRSS_PI_208_DATA 0x00090031
+#define DDRSS_PI_209_DATA 0x001B0043
+#define DDRSS_PI_210_DATA 0x001B0043
+#define DDRSS_PI_211_DATA 0x01010101
+#define DDRSS_PI_212_DATA 0x0003000D
+#define DDRSS_PI_213_DATA 0x000301D3
+#define DDRSS_PI_214_DATA 0x010001D3
+#define DDRSS_PI_215_DATA 0x000E000E
+#define DDRSS_PI_216_DATA 0x01D40100
+#define DDRSS_PI_217_DATA 0x010001D4
+#define DDRSS_PI_218_DATA 0x01D401D4
+#define DDRSS_PI_219_DATA 0x32103200
+#define DDRSS_PI_220_DATA 0x01013210
+#define DDRSS_PI_221_DATA 0x0A070601
+#define DDRSS_PI_222_DATA 0x1C11090D
+#define DDRSS_PI_223_DATA 0x1C110913
+#define DDRSS_PI_224_DATA 0x000C0013
+#define DDRSS_PI_225_DATA 0x00001000
+#define DDRSS_PI_226_DATA 0x00000C00
+#define DDRSS_PI_227_DATA 0x00001000
+#define DDRSS_PI_228_DATA 0x00000C00
+#define DDRSS_PI_229_DATA 0x02001000
+#define DDRSS_PI_230_DATA 0x0021000D
+#define DDRSS_PI_231_DATA 0x002101D3
+#define DDRSS_PI_232_DATA 0x000001D3
+#define DDRSS_PI_233_DATA 0x00001900
+#define DDRSS_PI_234_DATA 0x32000056
+#define DDRSS_PI_235_DATA 0x06000101
+#define DDRSS_PI_236_DATA 0x00250204
+#define DDRSS_PI_237_DATA 0x3212005A
+#define DDRSS_PI_238_DATA 0x17000101
+#define DDRSS_PI_239_DATA 0x00250C12
+#define DDRSS_PI_240_DATA 0x3212005A
+#define DDRSS_PI_241_DATA 0x17000101
+#define DDRSS_PI_242_DATA 0x00000C12
+#define DDRSS_PI_243_DATA 0x05030900
+#define DDRSS_PI_244_DATA 0x00040900
+#define DDRSS_PI_245_DATA 0x0000062B
+#define DDRSS_PI_246_DATA 0x20010004
+#define DDRSS_PI_247_DATA 0x0A0A0A03
+#define DDRSS_PI_248_DATA 0x280F0000
+#define DDRSS_PI_249_DATA 0x24090023
+#define DDRSS_PI_250_DATA 0x0000E638
+#define DDRSS_PI_251_DATA 0x20070050
+#define DDRSS_PI_252_DATA 0x1B131B1C
+#define DDRSS_PI_253_DATA 0x280F0000
+#define DDRSS_PI_254_DATA 0x24090023
+#define DDRSS_PI_255_DATA 0x0000E638
+#define DDRSS_PI_256_DATA 0x20070050
+#define DDRSS_PI_257_DATA 0x1B131B1C
+#define DDRSS_PI_258_DATA 0x00000000
+#define DDRSS_PI_259_DATA 0x00000176
+#define DDRSS_PI_260_DATA 0x00000E9C
+#define DDRSS_PI_261_DATA 0x000038C8
+#define DDRSS_PI_262_DATA 0x000237D0
+#define DDRSS_PI_263_DATA 0x000038C8
+#define DDRSS_PI_264_DATA 0x000237D0
+#define DDRSS_PI_265_DATA 0x0219000F
+#define DDRSS_PI_266_DATA 0x03030219
+#define DDRSS_PI_267_DATA 0x00000003
+#define DDRSS_PI_268_DATA 0x00000000
+#define DDRSS_PI_269_DATA 0x0A040503
+#define DDRSS_PI_270_DATA 0x00000A04
+#define DDRSS_PI_271_DATA 0x00002710
+#define DDRSS_PI_272_DATA 0x000186A0
+#define DDRSS_PI_273_DATA 0x00000005
+#define DDRSS_PI_274_DATA 0x00000064
+#define DDRSS_PI_275_DATA 0x0000000F
+#define DDRSS_PI_276_DATA 0x0005B18F
+#define DDRSS_PI_277_DATA 0x000186A0
+#define DDRSS_PI_278_DATA 0x00000005
+#define DDRSS_PI_279_DATA 0x00000E94
+#define DDRSS_PI_280_DATA 0x00000219
+#define DDRSS_PI_281_DATA 0x0005B18F
+#define DDRSS_PI_282_DATA 0x000186A0
+#define DDRSS_PI_283_DATA 0x00000005
+#define DDRSS_PI_284_DATA 0x00000E94
+#define DDRSS_PI_285_DATA 0x01000219
+#define DDRSS_PI_286_DATA 0x00320040
+#define DDRSS_PI_287_DATA 0x00010008
+#define DDRSS_PI_288_DATA 0x074A0040
+#define DDRSS_PI_289_DATA 0x00010038
+#define DDRSS_PI_290_DATA 0x074A0040
+#define DDRSS_PI_291_DATA 0x00000338
+#define DDRSS_PI_292_DATA 0x0028005D
+#define DDRSS_PI_293_DATA 0x03040404
+#define DDRSS_PI_294_DATA 0x00000303
+#define DDRSS_PI_295_DATA 0x01010000
+#define DDRSS_PI_296_DATA 0x04040202
+#define DDRSS_PI_297_DATA 0x67670808
+#define DDRSS_PI_298_DATA 0x67676767
+#define DDRSS_PI_299_DATA 0x67676767
+#define DDRSS_PI_300_DATA 0x67676767
+#define DDRSS_PI_301_DATA 0x00006767
+#define DDRSS_PI_302_DATA 0x00000000
+#define DDRSS_PI_303_DATA 0x00000000
+#define DDRSS_PI_304_DATA 0x00000000
+#define DDRSS_PI_305_DATA 0x00000000
+#define DDRSS_PI_306_DATA 0x55000000
+#define DDRSS_PI_307_DATA 0x00000000
+#define DDRSS_PI_308_DATA 0x3C00005A
+#define DDRSS_PI_309_DATA 0x00005500
+#define DDRSS_PI_310_DATA 0x00005A00
+#define DDRSS_PI_311_DATA 0x0055003C
+#define DDRSS_PI_312_DATA 0x00000000
+#define DDRSS_PI_313_DATA 0x3C00005A
+#define DDRSS_PI_314_DATA 0x00005500
+#define DDRSS_PI_315_DATA 0x00005A00
+#define DDRSS_PI_316_DATA 0x1716153C
+#define DDRSS_PI_317_DATA 0x13121118
+#define DDRSS_PI_318_DATA 0x06050414
+#define DDRSS_PI_319_DATA 0x02010007
+#define DDRSS_PI_320_DATA 0x00000003
+#define DDRSS_PI_321_DATA 0x00000000
+#define DDRSS_PI_322_DATA 0x00000000
+#define DDRSS_PI_323_DATA 0x01000000
+#define DDRSS_PI_324_DATA 0x04020201
+#define DDRSS_PI_325_DATA 0x00080804
+#define DDRSS_PI_326_DATA 0x00000000
+#define DDRSS_PI_327_DATA 0x00000000
+#define DDRSS_PI_328_DATA 0x00000000
+#define DDRSS_PI_329_DATA 0x00000004
+#define DDRSS_PI_330_DATA 0x00000000
+#define DDRSS_PI_331_DATA 0x00000031
+#define DDRSS_PI_332_DATA 0x00000000
+#define DDRSS_PI_333_DATA 0x00000000
+#define DDRSS_PI_334_DATA 0x00000000
+#define DDRSS_PI_335_DATA 0x20002B27
+#define DDRSS_PI_336_DATA 0x00000000
+#define DDRSS_PI_337_DATA 0x00000064
+#define DDRSS_PI_338_DATA 0x00000036
+#define DDRSS_PI_339_DATA 0x000000B1
+#define DDRSS_PI_340_DATA 0x00000000
+#define DDRSS_PI_341_DATA 0x00000000
+#define DDRSS_PI_342_DATA 0x55000000
+#define DDRSS_PI_343_DATA 0x20162B27
+#define DDRSS_PI_344_DATA 0x00000000
+#define DDRSS_PI_345_DATA 0x00000064
+#define DDRSS_PI_346_DATA 0x00000036
+#define DDRSS_PI_347_DATA 0x000000B1
+#define DDRSS_PI_348_DATA 0x00000000
+#define DDRSS_PI_349_DATA 0x00000000
+#define DDRSS_PI_350_DATA 0x55000000
+#define DDRSS_PI_351_DATA 0x20162B27
+#define DDRSS_PI_352_DATA 0x00000000
+#define DDRSS_PI_353_DATA 0x00000004
+#define DDRSS_PI_354_DATA 0x00000000
+#define DDRSS_PI_355_DATA 0x00000031
+#define DDRSS_PI_356_DATA 0x00000000
+#define DDRSS_PI_357_DATA 0x00000000
+#define DDRSS_PI_358_DATA 0x00000000
+#define DDRSS_PI_359_DATA 0x20002B27
+#define DDRSS_PI_360_DATA 0x00000000
+#define DDRSS_PI_361_DATA 0x00000064
+#define DDRSS_PI_362_DATA 0x00000036
+#define DDRSS_PI_363_DATA 0x000000B1
+#define DDRSS_PI_364_DATA 0x00000000
+#define DDRSS_PI_365_DATA 0x00000000
+#define DDRSS_PI_366_DATA 0x55000000
+#define DDRSS_PI_367_DATA 0x20162B27
+#define DDRSS_PI_368_DATA 0x00000000
+#define DDRSS_PI_369_DATA 0x00000064
+#define DDRSS_PI_370_DATA 0x00000036
+#define DDRSS_PI_371_DATA 0x000000B1
+#define DDRSS_PI_372_DATA 0x00000000
+#define DDRSS_PI_373_DATA 0x00000000
+#define DDRSS_PI_374_DATA 0x55000000
+#define DDRSS_PI_375_DATA 0x20162B27
+#define DDRSS_PI_376_DATA 0x00000000
+#define DDRSS_PI_377_DATA 0x00000004
+#define DDRSS_PI_378_DATA 0x00000000
+#define DDRSS_PI_379_DATA 0x00000031
+#define DDRSS_PI_380_DATA 0x00000000
+#define DDRSS_PI_381_DATA 0x00000000
+#define DDRSS_PI_382_DATA 0x00000000
+#define DDRSS_PI_383_DATA 0x20002B27
+#define DDRSS_PI_384_DATA 0x00000000
+#define DDRSS_PI_385_DATA 0x00000064
+#define DDRSS_PI_386_DATA 0x00000036
+#define DDRSS_PI_387_DATA 0x000000B1
+#define DDRSS_PI_388_DATA 0x00000000
+#define DDRSS_PI_389_DATA 0x00000000
+#define DDRSS_PI_390_DATA 0x55000000
+#define DDRSS_PI_391_DATA 0x20162B27
+#define DDRSS_PI_392_DATA 0x00000000
+#define DDRSS_PI_393_DATA 0x00000064
+#define DDRSS_PI_394_DATA 0x00000036
+#define DDRSS_PI_395_DATA 0x000000B1
+#define DDRSS_PI_396_DATA 0x00000000
+#define DDRSS_PI_397_DATA 0x00000000
+#define DDRSS_PI_398_DATA 0x55000000
+#define DDRSS_PI_399_DATA 0x20162B27
+#define DDRSS_PI_400_DATA 0x00000000
+#define DDRSS_PI_401_DATA 0x00000004
+#define DDRSS_PI_402_DATA 0x00000000
+#define DDRSS_PI_403_DATA 0x00000031
+#define DDRSS_PI_404_DATA 0x00000000
+#define DDRSS_PI_405_DATA 0x00000000
+#define DDRSS_PI_406_DATA 0x00000000
+#define DDRSS_PI_407_DATA 0x20002B27
+#define DDRSS_PI_408_DATA 0x00000000
+#define DDRSS_PI_409_DATA 0x00000064
+#define DDRSS_PI_410_DATA 0x00000036
+#define DDRSS_PI_411_DATA 0x000000B1
+#define DDRSS_PI_412_DATA 0x00000000
+#define DDRSS_PI_413_DATA 0x00000000
+#define DDRSS_PI_414_DATA 0x55000000
+#define DDRSS_PI_415_DATA 0x20162B27
+#define DDRSS_PI_416_DATA 0x00000000
+#define DDRSS_PI_417_DATA 0x00000064
+#define DDRSS_PI_418_DATA 0x00000036
+#define DDRSS_PI_419_DATA 0x000000B1
+#define DDRSS_PI_420_DATA 0x00000000
+#define DDRSS_PI_421_DATA 0x00000000
+#define DDRSS_PI_422_DATA 0x55000000
+#define DDRSS_PI_423_DATA 0x20162B27
+#define DDRSS_PHY_0_DATA 0x04F00000
+#define DDRSS_PHY_1_DATA 0x00000000
+#define DDRSS_PHY_2_DATA 0x00030200
+#define DDRSS_PHY_3_DATA 0x00000000
+#define DDRSS_PHY_4_DATA 0x00000000
+#define DDRSS_PHY_5_DATA 0x01030000
+#define DDRSS_PHY_6_DATA 0x00010000
+#define DDRSS_PHY_7_DATA 0x01030004
+#define DDRSS_PHY_8_DATA 0x01000000
+#define DDRSS_PHY_9_DATA 0x00000000
+#define DDRSS_PHY_10_DATA 0x00000000
+#define DDRSS_PHY_11_DATA 0x00000000
+#define DDRSS_PHY_12_DATA 0x01010000
+#define DDRSS_PHY_13_DATA 0x00010000
+#define DDRSS_PHY_14_DATA 0x00C00001
+#define DDRSS_PHY_15_DATA 0x00CC0008
+#define DDRSS_PHY_16_DATA 0x00660601
+#define DDRSS_PHY_17_DATA 0x00000003
+#define DDRSS_PHY_18_DATA 0x00000000
+#define DDRSS_PHY_19_DATA 0x00000001
+#define DDRSS_PHY_20_DATA 0x0000AAAA
+#define DDRSS_PHY_21_DATA 0x00005555
+#define DDRSS_PHY_22_DATA 0x0000B5B5
+#define DDRSS_PHY_23_DATA 0x00004A4A
+#define DDRSS_PHY_24_DATA 0x00005656
+#define DDRSS_PHY_25_DATA 0x0000A9A9
+#define DDRSS_PHY_26_DATA 0x0000B7B7
+#define DDRSS_PHY_27_DATA 0x00004848
+#define DDRSS_PHY_28_DATA 0x00000000
+#define DDRSS_PHY_29_DATA 0x00000000
+#define DDRSS_PHY_30_DATA 0x08000000
+#define DDRSS_PHY_31_DATA 0x0F000008
+#define DDRSS_PHY_32_DATA 0x00000F0F
+#define DDRSS_PHY_33_DATA 0x00E4E400
+#define DDRSS_PHY_34_DATA 0x00071020
+#define DDRSS_PHY_35_DATA 0x000C0020
+#define DDRSS_PHY_36_DATA 0x00062000
+#define DDRSS_PHY_37_DATA 0x00000000
+#define DDRSS_PHY_38_DATA 0x55555555
+#define DDRSS_PHY_39_DATA 0xAAAAAAAA
+#define DDRSS_PHY_40_DATA 0x55555555
+#define DDRSS_PHY_41_DATA 0xAAAAAAAA
+#define DDRSS_PHY_42_DATA 0x00005555
+#define DDRSS_PHY_43_DATA 0x01000100
+#define DDRSS_PHY_44_DATA 0x00800180
+#define DDRSS_PHY_45_DATA 0x00000001
+#define DDRSS_PHY_46_DATA 0x00000000
+#define DDRSS_PHY_47_DATA 0x00000000
+#define DDRSS_PHY_48_DATA 0x00000000
+#define DDRSS_PHY_49_DATA 0x00000000
+#define DDRSS_PHY_50_DATA 0x00000000
+#define DDRSS_PHY_51_DATA 0x00000000
+#define DDRSS_PHY_52_DATA 0x00000000
+#define DDRSS_PHY_53_DATA 0x00000000
+#define DDRSS_PHY_54_DATA 0x00000000
+#define DDRSS_PHY_55_DATA 0x00000000
+#define DDRSS_PHY_56_DATA 0x00000000
+#define DDRSS_PHY_57_DATA 0x00000000
+#define DDRSS_PHY_58_DATA 0x00000000
+#define DDRSS_PHY_59_DATA 0x00000000
+#define DDRSS_PHY_60_DATA 0x00000000
+#define DDRSS_PHY_61_DATA 0x00000000
+#define DDRSS_PHY_62_DATA 0x00000000
+#define DDRSS_PHY_63_DATA 0x00000000
+#define DDRSS_PHY_64_DATA 0x00000000
+#define DDRSS_PHY_65_DATA 0x00000000
+#define DDRSS_PHY_66_DATA 0x00000000
+#define DDRSS_PHY_67_DATA 0x00000004
+#define DDRSS_PHY_68_DATA 0x00000000
+#define DDRSS_PHY_69_DATA 0x00000000
+#define DDRSS_PHY_70_DATA 0x00000000
+#define DDRSS_PHY_71_DATA 0x00000000
+#define DDRSS_PHY_72_DATA 0x00000000
+#define DDRSS_PHY_73_DATA 0x00000000
+#define DDRSS_PHY_74_DATA 0x081F07FF
+#define DDRSS_PHY_75_DATA 0x10200080
+#define DDRSS_PHY_76_DATA 0x00000008
+#define DDRSS_PHY_77_DATA 0x00000401
+#define DDRSS_PHY_78_DATA 0x00000000
+#define DDRSS_PHY_79_DATA 0x01CC0C01
+#define DDRSS_PHY_80_DATA 0x1003CC0C
+#define DDRSS_PHY_81_DATA 0x20000140
+#define DDRSS_PHY_82_DATA 0x07FF0200
+#define DDRSS_PHY_83_DATA 0x0000DD01
+#define DDRSS_PHY_84_DATA 0x00100303
+#define DDRSS_PHY_85_DATA 0x00000000
+#define DDRSS_PHY_86_DATA 0x00000000
+#define DDRSS_PHY_87_DATA 0x00041000
+#define DDRSS_PHY_88_DATA 0x00100010
+#define DDRSS_PHY_89_DATA 0x00100010
+#define DDRSS_PHY_90_DATA 0x00100010
+#define DDRSS_PHY_91_DATA 0x00100010
+#define DDRSS_PHY_92_DATA 0x02040010
+#define DDRSS_PHY_93_DATA 0x00000005
+#define DDRSS_PHY_94_DATA 0x51516042
+#define DDRSS_PHY_95_DATA 0x31C06000
+#define DDRSS_PHY_96_DATA 0x07AB0340
+#define DDRSS_PHY_97_DATA 0x00C0C001
+#define DDRSS_PHY_98_DATA 0x0D000000
+#define DDRSS_PHY_99_DATA 0x000D0C0C
+#define DDRSS_PHY_100_DATA 0x42100010
+#define DDRSS_PHY_101_DATA 0x010C073E
+#define DDRSS_PHY_102_DATA 0x000F0C32
+#define DDRSS_PHY_103_DATA 0x01000140
+#define DDRSS_PHY_104_DATA 0x011E0120
+#define DDRSS_PHY_105_DATA 0x00000C00
+#define DDRSS_PHY_106_DATA 0x000002DD
+#define DDRSS_PHY_107_DATA 0x00030200
+#define DDRSS_PHY_108_DATA 0x02800000
+#define DDRSS_PHY_109_DATA 0x80800000
+#define DDRSS_PHY_110_DATA 0x000D2010
+#define DDRSS_PHY_111_DATA 0x76543210
+#define DDRSS_PHY_112_DATA 0x00000008
+#define DDRSS_PHY_113_DATA 0x045D045D
+#define DDRSS_PHY_114_DATA 0x045D045D
+#define DDRSS_PHY_115_DATA 0x045D045D
+#define DDRSS_PHY_116_DATA 0x045D045D
+#define DDRSS_PHY_117_DATA 0x0000045D
+#define DDRSS_PHY_118_DATA 0x0000A000
+#define DDRSS_PHY_119_DATA 0x00A000A0
+#define DDRSS_PHY_120_DATA 0x00A000A0
+#define DDRSS_PHY_121_DATA 0x00A000A0
+#define DDRSS_PHY_122_DATA 0x00A000A0
+#define DDRSS_PHY_123_DATA 0x00A000A0
+#define DDRSS_PHY_124_DATA 0x00A000A0
+#define DDRSS_PHY_125_DATA 0x00A000A0
+#define DDRSS_PHY_126_DATA 0x00A000A0
+#define DDRSS_PHY_127_DATA 0x00B200A0
+#define DDRSS_PHY_128_DATA 0x01000000
+#define DDRSS_PHY_129_DATA 0x00000000
+#define DDRSS_PHY_130_DATA 0x00000000
+#define DDRSS_PHY_131_DATA 0x00080200
+#define DDRSS_PHY_132_DATA 0x00000000
+#define DDRSS_PHY_133_DATA 0x20202020
+#define DDRSS_PHY_134_DATA 0x20202020
+#define DDRSS_PHY_135_DATA 0xF0F02020
+#define DDRSS_PHY_136_DATA 0x00000000
+#define DDRSS_PHY_137_DATA 0x00000000
+#define DDRSS_PHY_138_DATA 0x00000000
+#define DDRSS_PHY_139_DATA 0x00000000
+#define DDRSS_PHY_140_DATA 0x00000000
+#define DDRSS_PHY_141_DATA 0x00000000
+#define DDRSS_PHY_142_DATA 0x00000000
+#define DDRSS_PHY_143_DATA 0x00000000
+#define DDRSS_PHY_144_DATA 0x00000000
+#define DDRSS_PHY_145_DATA 0x00000000
+#define DDRSS_PHY_146_DATA 0x00000000
+#define DDRSS_PHY_147_DATA 0x00000000
+#define DDRSS_PHY_148_DATA 0x00000000
+#define DDRSS_PHY_149_DATA 0x00000000
+#define DDRSS_PHY_150_DATA 0x00000000
+#define DDRSS_PHY_151_DATA 0x00000000
+#define DDRSS_PHY_152_DATA 0x00000000
+#define DDRSS_PHY_153_DATA 0x00000000
+#define DDRSS_PHY_154_DATA 0x00000000
+#define DDRSS_PHY_155_DATA 0x00000000
+#define DDRSS_PHY_156_DATA 0x00000000
+#define DDRSS_PHY_157_DATA 0x00000000
+#define DDRSS_PHY_158_DATA 0x00000000
+#define DDRSS_PHY_159_DATA 0x00000000
+#define DDRSS_PHY_160_DATA 0x00000000
+#define DDRSS_PHY_161_DATA 0x00000000
+#define DDRSS_PHY_162_DATA 0x00000000
+#define DDRSS_PHY_163_DATA 0x00000000
+#define DDRSS_PHY_164_DATA 0x00000000
+#define DDRSS_PHY_165_DATA 0x00000000
+#define DDRSS_PHY_166_DATA 0x00000000
+#define DDRSS_PHY_167_DATA 0x00000000
+#define DDRSS_PHY_168_DATA 0x00000000
+#define DDRSS_PHY_169_DATA 0x00000000
+#define DDRSS_PHY_170_DATA 0x00000000
+#define DDRSS_PHY_171_DATA 0x00000000
+#define DDRSS_PHY_172_DATA 0x00000000
+#define DDRSS_PHY_173_DATA 0x00000000
+#define DDRSS_PHY_174_DATA 0x00000000
+#define DDRSS_PHY_175_DATA 0x00000000
+#define DDRSS_PHY_176_DATA 0x00000000
+#define DDRSS_PHY_177_DATA 0x00000000
+#define DDRSS_PHY_178_DATA 0x00000000
+#define DDRSS_PHY_179_DATA 0x00000000
+#define DDRSS_PHY_180_DATA 0x00000000
+#define DDRSS_PHY_181_DATA 0x00000000
+#define DDRSS_PHY_182_DATA 0x00000000
+#define DDRSS_PHY_183_DATA 0x00000000
+#define DDRSS_PHY_184_DATA 0x00000000
+#define DDRSS_PHY_185_DATA 0x00000000
+#define DDRSS_PHY_186_DATA 0x00000000
+#define DDRSS_PHY_187_DATA 0x00000000
+#define DDRSS_PHY_188_DATA 0x00000000
+#define DDRSS_PHY_189_DATA 0x00000000
+#define DDRSS_PHY_190_DATA 0x00000000
+#define DDRSS_PHY_191_DATA 0x00000000
+#define DDRSS_PHY_192_DATA 0x00000000
+#define DDRSS_PHY_193_DATA 0x00000000
+#define DDRSS_PHY_194_DATA 0x00000000
+#define DDRSS_PHY_195_DATA 0x00000000
+#define DDRSS_PHY_196_DATA 0x00000000
+#define DDRSS_PHY_197_DATA 0x00000000
+#define DDRSS_PHY_198_DATA 0x00000000
+#define DDRSS_PHY_199_DATA 0x00000000
+#define DDRSS_PHY_200_DATA 0x00000000
+#define DDRSS_PHY_201_DATA 0x00000000
+#define DDRSS_PHY_202_DATA 0x00000000
+#define DDRSS_PHY_203_DATA 0x00000000
+#define DDRSS_PHY_204_DATA 0x00000000
+#define DDRSS_PHY_205_DATA 0x00000000
+#define DDRSS_PHY_206_DATA 0x00000000
+#define DDRSS_PHY_207_DATA 0x00000000
+#define DDRSS_PHY_208_DATA 0x00000000
+#define DDRSS_PHY_209_DATA 0x00000000
+#define DDRSS_PHY_210_DATA 0x00000000
+#define DDRSS_PHY_211_DATA 0x00000000
+#define DDRSS_PHY_212_DATA 0x00000000
+#define DDRSS_PHY_213_DATA 0x00000000
+#define DDRSS_PHY_214_DATA 0x00000000
+#define DDRSS_PHY_215_DATA 0x00000000
+#define DDRSS_PHY_216_DATA 0x00000000
+#define DDRSS_PHY_217_DATA 0x00000000
+#define DDRSS_PHY_218_DATA 0x00000000
+#define DDRSS_PHY_219_DATA 0x00000000
+#define DDRSS_PHY_220_DATA 0x00000000
+#define DDRSS_PHY_221_DATA 0x00000000
+#define DDRSS_PHY_222_DATA 0x00000000
+#define DDRSS_PHY_223_DATA 0x00000000
+#define DDRSS_PHY_224_DATA 0x00000000
+#define DDRSS_PHY_225_DATA 0x00000000
+#define DDRSS_PHY_226_DATA 0x00000000
+#define DDRSS_PHY_227_DATA 0x00000000
+#define DDRSS_PHY_228_DATA 0x00000000
+#define DDRSS_PHY_229_DATA 0x00000000
+#define DDRSS_PHY_230_DATA 0x00000000
+#define DDRSS_PHY_231_DATA 0x00000000
+#define DDRSS_PHY_232_DATA 0x00000000
+#define DDRSS_PHY_233_DATA 0x00000000
+#define DDRSS_PHY_234_DATA 0x00000000
+#define DDRSS_PHY_235_DATA 0x00000000
+#define DDRSS_PHY_236_DATA 0x00000000
+#define DDRSS_PHY_237_DATA 0x00000000
+#define DDRSS_PHY_238_DATA 0x00000000
+#define DDRSS_PHY_239_DATA 0x00000000
+#define DDRSS_PHY_240_DATA 0x00000000
+#define DDRSS_PHY_241_DATA 0x00000000
+#define DDRSS_PHY_242_DATA 0x00000000
+#define DDRSS_PHY_243_DATA 0x00000000
+#define DDRSS_PHY_244_DATA 0x00000000
+#define DDRSS_PHY_245_DATA 0x00000000
+#define DDRSS_PHY_246_DATA 0x00000000
+#define DDRSS_PHY_247_DATA 0x00000000
+#define DDRSS_PHY_248_DATA 0x00000000
+#define DDRSS_PHY_249_DATA 0x00000000
+#define DDRSS_PHY_250_DATA 0x00000000
+#define DDRSS_PHY_251_DATA 0x00000000
+#define DDRSS_PHY_252_DATA 0x00000000
+#define DDRSS_PHY_253_DATA 0x00000000
+#define DDRSS_PHY_254_DATA 0x00000000
+#define DDRSS_PHY_255_DATA 0x00000000
+#define DDRSS_PHY_256_DATA 0x04F00000
+#define DDRSS_PHY_257_DATA 0x00000000
+#define DDRSS_PHY_258_DATA 0x00030200
+#define DDRSS_PHY_259_DATA 0x00000000
+#define DDRSS_PHY_260_DATA 0x00000000
+#define DDRSS_PHY_261_DATA 0x01030000
+#define DDRSS_PHY_262_DATA 0x00010000
+#define DDRSS_PHY_263_DATA 0x01030004
+#define DDRSS_PHY_264_DATA 0x01000000
+#define DDRSS_PHY_265_DATA 0x00000000
+#define DDRSS_PHY_266_DATA 0x00000000
+#define DDRSS_PHY_267_DATA 0x00000000
+#define DDRSS_PHY_268_DATA 0x01010000
+#define DDRSS_PHY_269_DATA 0x00010000
+#define DDRSS_PHY_270_DATA 0x00C00001
+#define DDRSS_PHY_271_DATA 0x00CC0008
+#define DDRSS_PHY_272_DATA 0x00660601
+#define DDRSS_PHY_273_DATA 0x00000003
+#define DDRSS_PHY_274_DATA 0x00000000
+#define DDRSS_PHY_275_DATA 0x00000001
+#define DDRSS_PHY_276_DATA 0x0000AAAA
+#define DDRSS_PHY_277_DATA 0x00005555
+#define DDRSS_PHY_278_DATA 0x0000B5B5
+#define DDRSS_PHY_279_DATA 0x00004A4A
+#define DDRSS_PHY_280_DATA 0x00005656
+#define DDRSS_PHY_281_DATA 0x0000A9A9
+#define DDRSS_PHY_282_DATA 0x0000B7B7
+#define DDRSS_PHY_283_DATA 0x00004848
+#define DDRSS_PHY_284_DATA 0x00000000
+#define DDRSS_PHY_285_DATA 0x00000000
+#define DDRSS_PHY_286_DATA 0x08000000
+#define DDRSS_PHY_287_DATA 0x0F000008
+#define DDRSS_PHY_288_DATA 0x00000F0F
+#define DDRSS_PHY_289_DATA 0x00E4E400
+#define DDRSS_PHY_290_DATA 0x00071020
+#define DDRSS_PHY_291_DATA 0x000C0020
+#define DDRSS_PHY_292_DATA 0x00062000
+#define DDRSS_PHY_293_DATA 0x00000000
+#define DDRSS_PHY_294_DATA 0x55555555
+#define DDRSS_PHY_295_DATA 0xAAAAAAAA
+#define DDRSS_PHY_296_DATA 0x55555555
+#define DDRSS_PHY_297_DATA 0xAAAAAAAA
+#define DDRSS_PHY_298_DATA 0x00005555
+#define DDRSS_PHY_299_DATA 0x01000100
+#define DDRSS_PHY_300_DATA 0x00800180
+#define DDRSS_PHY_301_DATA 0x00000000
+#define DDRSS_PHY_302_DATA 0x00000000
+#define DDRSS_PHY_303_DATA 0x00000000
+#define DDRSS_PHY_304_DATA 0x00000000
+#define DDRSS_PHY_305_DATA 0x00000000
+#define DDRSS_PHY_306_DATA 0x00000000
+#define DDRSS_PHY_307_DATA 0x00000000
+#define DDRSS_PHY_308_DATA 0x00000000
+#define DDRSS_PHY_309_DATA 0x00000000
+#define DDRSS_PHY_310_DATA 0x00000000
+#define DDRSS_PHY_311_DATA 0x00000000
+#define DDRSS_PHY_312_DATA 0x00000000
+#define DDRSS_PHY_313_DATA 0x00000000
+#define DDRSS_PHY_314_DATA 0x00000000
+#define DDRSS_PHY_315_DATA 0x00000000
+#define DDRSS_PHY_316_DATA 0x00000000
+#define DDRSS_PHY_317_DATA 0x00000000
+#define DDRSS_PHY_318_DATA 0x00000000
+#define DDRSS_PHY_319_DATA 0x00000000
+#define DDRSS_PHY_320_DATA 0x00000000
+#define DDRSS_PHY_321_DATA 0x00000000
+#define DDRSS_PHY_322_DATA 0x00000000
+#define DDRSS_PHY_323_DATA 0x00000004
+#define DDRSS_PHY_324_DATA 0x00000000
+#define DDRSS_PHY_325_DATA 0x00000000
+#define DDRSS_PHY_326_DATA 0x00000000
+#define DDRSS_PHY_327_DATA 0x00000000
+#define DDRSS_PHY_328_DATA 0x00000000
+#define DDRSS_PHY_329_DATA 0x00000000
+#define DDRSS_PHY_330_DATA 0x081F07FF
+#define DDRSS_PHY_331_DATA 0x10200080
+#define DDRSS_PHY_332_DATA 0x00000008
+#define DDRSS_PHY_333_DATA 0x00000401
+#define DDRSS_PHY_334_DATA 0x00000000
+#define DDRSS_PHY_335_DATA 0x01CC0C01
+#define DDRSS_PHY_336_DATA 0x1003CC0C
+#define DDRSS_PHY_337_DATA 0x20000140
+#define DDRSS_PHY_338_DATA 0x07FF0200
+#define DDRSS_PHY_339_DATA 0x0000DD01
+#define DDRSS_PHY_340_DATA 0x00100303
+#define DDRSS_PHY_341_DATA 0x00000000
+#define DDRSS_PHY_342_DATA 0x00000000
+#define DDRSS_PHY_343_DATA 0x00041000
+#define DDRSS_PHY_344_DATA 0x00100010
+#define DDRSS_PHY_345_DATA 0x00100010
+#define DDRSS_PHY_346_DATA 0x00100010
+#define DDRSS_PHY_347_DATA 0x00100010
+#define DDRSS_PHY_348_DATA 0x02040010
+#define DDRSS_PHY_349_DATA 0x00000005
+#define DDRSS_PHY_350_DATA 0x51516042
+#define DDRSS_PHY_351_DATA 0x31C06000
+#define DDRSS_PHY_352_DATA 0x07AB0340
+#define DDRSS_PHY_353_DATA 0x00C0C001
+#define DDRSS_PHY_354_DATA 0x0D000000
+#define DDRSS_PHY_355_DATA 0x000D0C0C
+#define DDRSS_PHY_356_DATA 0x42100010
+#define DDRSS_PHY_357_DATA 0x010C073E
+#define DDRSS_PHY_358_DATA 0x000F0C32
+#define DDRSS_PHY_359_DATA 0x01000140
+#define DDRSS_PHY_360_DATA 0x011E0120
+#define DDRSS_PHY_361_DATA 0x00000C00
+#define DDRSS_PHY_362_DATA 0x000002DD
+#define DDRSS_PHY_363_DATA 0x00030200
+#define DDRSS_PHY_364_DATA 0x02800000
+#define DDRSS_PHY_365_DATA 0x80800000
+#define DDRSS_PHY_366_DATA 0x000D2010
+#define DDRSS_PHY_367_DATA 0x76543210
+#define DDRSS_PHY_368_DATA 0x00000008
+#define DDRSS_PHY_369_DATA 0x045D045D
+#define DDRSS_PHY_370_DATA 0x045D045D
+#define DDRSS_PHY_371_DATA 0x045D045D
+#define DDRSS_PHY_372_DATA 0x045D045D
+#define DDRSS_PHY_373_DATA 0x0000045D
+#define DDRSS_PHY_374_DATA 0x0000A000
+#define DDRSS_PHY_375_DATA 0x00A000A0
+#define DDRSS_PHY_376_DATA 0x00A000A0
+#define DDRSS_PHY_377_DATA 0x00A000A0
+#define DDRSS_PHY_378_DATA 0x00A000A0
+#define DDRSS_PHY_379_DATA 0x00A000A0
+#define DDRSS_PHY_380_DATA 0x00A000A0
+#define DDRSS_PHY_381_DATA 0x00A000A0
+#define DDRSS_PHY_382_DATA 0x00A000A0
+#define DDRSS_PHY_383_DATA 0x00B200A0
+#define DDRSS_PHY_384_DATA 0x01000000
+#define DDRSS_PHY_385_DATA 0x00000000
+#define DDRSS_PHY_386_DATA 0x00000000
+#define DDRSS_PHY_387_DATA 0x00080200
+#define DDRSS_PHY_388_DATA 0x00000000
+#define DDRSS_PHY_389_DATA 0x20202020
+#define DDRSS_PHY_390_DATA 0x20202020
+#define DDRSS_PHY_391_DATA 0xF0F02020
+#define DDRSS_PHY_392_DATA 0x00000000
+#define DDRSS_PHY_393_DATA 0x00000000
+#define DDRSS_PHY_394_DATA 0x00000000
+#define DDRSS_PHY_395_DATA 0x00000000
+#define DDRSS_PHY_396_DATA 0x00000000
+#define DDRSS_PHY_397_DATA 0x00000000
+#define DDRSS_PHY_398_DATA 0x00000000
+#define DDRSS_PHY_399_DATA 0x00000000
+#define DDRSS_PHY_400_DATA 0x00000000
+#define DDRSS_PHY_401_DATA 0x00000000
+#define DDRSS_PHY_402_DATA 0x00000000
+#define DDRSS_PHY_403_DATA 0x00000000
+#define DDRSS_PHY_404_DATA 0x00000000
+#define DDRSS_PHY_405_DATA 0x00000000
+#define DDRSS_PHY_406_DATA 0x00000000
+#define DDRSS_PHY_407_DATA 0x00000000
+#define DDRSS_PHY_408_DATA 0x00000000
+#define DDRSS_PHY_409_DATA 0x00000000
+#define DDRSS_PHY_410_DATA 0x00000000
+#define DDRSS_PHY_411_DATA 0x00000000
+#define DDRSS_PHY_412_DATA 0x00000000
+#define DDRSS_PHY_413_DATA 0x00000000
+#define DDRSS_PHY_414_DATA 0x00000000
+#define DDRSS_PHY_415_DATA 0x00000000
+#define DDRSS_PHY_416_DATA 0x00000000
+#define DDRSS_PHY_417_DATA 0x00000000
+#define DDRSS_PHY_418_DATA 0x00000000
+#define DDRSS_PHY_419_DATA 0x00000000
+#define DDRSS_PHY_420_DATA 0x00000000
+#define DDRSS_PHY_421_DATA 0x00000000
+#define DDRSS_PHY_422_DATA 0x00000000
+#define DDRSS_PHY_423_DATA 0x00000000
+#define DDRSS_PHY_424_DATA 0x00000000
+#define DDRSS_PHY_425_DATA 0x00000000
+#define DDRSS_PHY_426_DATA 0x00000000
+#define DDRSS_PHY_427_DATA 0x00000000
+#define DDRSS_PHY_428_DATA 0x00000000
+#define DDRSS_PHY_429_DATA 0x00000000
+#define DDRSS_PHY_430_DATA 0x00000000
+#define DDRSS_PHY_431_DATA 0x00000000
+#define DDRSS_PHY_432_DATA 0x00000000
+#define DDRSS_PHY_433_DATA 0x00000000
+#define DDRSS_PHY_434_DATA 0x00000000
+#define DDRSS_PHY_435_DATA 0x00000000
+#define DDRSS_PHY_436_DATA 0x00000000
+#define DDRSS_PHY_437_DATA 0x00000000
+#define DDRSS_PHY_438_DATA 0x00000000
+#define DDRSS_PHY_439_DATA 0x00000000
+#define DDRSS_PHY_440_DATA 0x00000000
+#define DDRSS_PHY_441_DATA 0x00000000
+#define DDRSS_PHY_442_DATA 0x00000000
+#define DDRSS_PHY_443_DATA 0x00000000
+#define DDRSS_PHY_444_DATA 0x00000000
+#define DDRSS_PHY_445_DATA 0x00000000
+#define DDRSS_PHY_446_DATA 0x00000000
+#define DDRSS_PHY_447_DATA 0x00000000
+#define DDRSS_PHY_448_DATA 0x00000000
+#define DDRSS_PHY_449_DATA 0x00000000
+#define DDRSS_PHY_450_DATA 0x00000000
+#define DDRSS_PHY_451_DATA 0x00000000
+#define DDRSS_PHY_452_DATA 0x00000000
+#define DDRSS_PHY_453_DATA 0x00000000
+#define DDRSS_PHY_454_DATA 0x00000000
+#define DDRSS_PHY_455_DATA 0x00000000
+#define DDRSS_PHY_456_DATA 0x00000000
+#define DDRSS_PHY_457_DATA 0x00000000
+#define DDRSS_PHY_458_DATA 0x00000000
+#define DDRSS_PHY_459_DATA 0x00000000
+#define DDRSS_PHY_460_DATA 0x00000000
+#define DDRSS_PHY_461_DATA 0x00000000
+#define DDRSS_PHY_462_DATA 0x00000000
+#define DDRSS_PHY_463_DATA 0x00000000
+#define DDRSS_PHY_464_DATA 0x00000000
+#define DDRSS_PHY_465_DATA 0x00000000
+#define DDRSS_PHY_466_DATA 0x00000000
+#define DDRSS_PHY_467_DATA 0x00000000
+#define DDRSS_PHY_468_DATA 0x00000000
+#define DDRSS_PHY_469_DATA 0x00000000
+#define DDRSS_PHY_470_DATA 0x00000000
+#define DDRSS_PHY_471_DATA 0x00000000
+#define DDRSS_PHY_472_DATA 0x00000000
+#define DDRSS_PHY_473_DATA 0x00000000
+#define DDRSS_PHY_474_DATA 0x00000000
+#define DDRSS_PHY_475_DATA 0x00000000
+#define DDRSS_PHY_476_DATA 0x00000000
+#define DDRSS_PHY_477_DATA 0x00000000
+#define DDRSS_PHY_478_DATA 0x00000000
+#define DDRSS_PHY_479_DATA 0x00000000
+#define DDRSS_PHY_480_DATA 0x00000000
+#define DDRSS_PHY_481_DATA 0x00000000
+#define DDRSS_PHY_482_DATA 0x00000000
+#define DDRSS_PHY_483_DATA 0x00000000
+#define DDRSS_PHY_484_DATA 0x00000000
+#define DDRSS_PHY_485_DATA 0x00000000
+#define DDRSS_PHY_486_DATA 0x00000000
+#define DDRSS_PHY_487_DATA 0x00000000
+#define DDRSS_PHY_488_DATA 0x00000000
+#define DDRSS_PHY_489_DATA 0x00000000
+#define DDRSS_PHY_490_DATA 0x00000000
+#define DDRSS_PHY_491_DATA 0x00000000
+#define DDRSS_PHY_492_DATA 0x00000000
+#define DDRSS_PHY_493_DATA 0x00000000
+#define DDRSS_PHY_494_DATA 0x00000000
+#define DDRSS_PHY_495_DATA 0x00000000
+#define DDRSS_PHY_496_DATA 0x00000000
+#define DDRSS_PHY_497_DATA 0x00000000
+#define DDRSS_PHY_498_DATA 0x00000000
+#define DDRSS_PHY_499_DATA 0x00000000
+#define DDRSS_PHY_500_DATA 0x00000000
+#define DDRSS_PHY_501_DATA 0x00000000
+#define DDRSS_PHY_502_DATA 0x00000000
+#define DDRSS_PHY_503_DATA 0x00000000
+#define DDRSS_PHY_504_DATA 0x00000000
+#define DDRSS_PHY_505_DATA 0x00000000
+#define DDRSS_PHY_506_DATA 0x00000000
+#define DDRSS_PHY_507_DATA 0x00000000
+#define DDRSS_PHY_508_DATA 0x00000000
+#define DDRSS_PHY_509_DATA 0x00000000
+#define DDRSS_PHY_510_DATA 0x00000000
+#define DDRSS_PHY_511_DATA 0x00000000
+#define DDRSS_PHY_512_DATA 0x04F00000
+#define DDRSS_PHY_513_DATA 0x00000000
+#define DDRSS_PHY_514_DATA 0x00030200
+#define DDRSS_PHY_515_DATA 0x00000000
+#define DDRSS_PHY_516_DATA 0x00000000
+#define DDRSS_PHY_517_DATA 0x01030000
+#define DDRSS_PHY_518_DATA 0x00010000
+#define DDRSS_PHY_519_DATA 0x01030004
+#define DDRSS_PHY_520_DATA 0x01000000
+#define DDRSS_PHY_521_DATA 0x00000000
+#define DDRSS_PHY_522_DATA 0x00000000
+#define DDRSS_PHY_523_DATA 0x00000000
+#define DDRSS_PHY_524_DATA 0x01010000
+#define DDRSS_PHY_525_DATA 0x00010000
+#define DDRSS_PHY_526_DATA 0x00C00001
+#define DDRSS_PHY_527_DATA 0x00CC0008
+#define DDRSS_PHY_528_DATA 0x00660601
+#define DDRSS_PHY_529_DATA 0x00000003
+#define DDRSS_PHY_530_DATA 0x00000000
+#define DDRSS_PHY_531_DATA 0x00000001
+#define DDRSS_PHY_532_DATA 0x0000AAAA
+#define DDRSS_PHY_533_DATA 0x00005555
+#define DDRSS_PHY_534_DATA 0x0000B5B5
+#define DDRSS_PHY_535_DATA 0x00004A4A
+#define DDRSS_PHY_536_DATA 0x00005656
+#define DDRSS_PHY_537_DATA 0x0000A9A9
+#define DDRSS_PHY_538_DATA 0x0000B7B7
+#define DDRSS_PHY_539_DATA 0x00004848
+#define DDRSS_PHY_540_DATA 0x00000000
+#define DDRSS_PHY_541_DATA 0x00000000
+#define DDRSS_PHY_542_DATA 0x08000000
+#define DDRSS_PHY_543_DATA 0x0F000008
+#define DDRSS_PHY_544_DATA 0x00000F0F
+#define DDRSS_PHY_545_DATA 0x00E4E400
+#define DDRSS_PHY_546_DATA 0x00071020
+#define DDRSS_PHY_547_DATA 0x000C0020
+#define DDRSS_PHY_548_DATA 0x00062000
+#define DDRSS_PHY_549_DATA 0x00000000
+#define DDRSS_PHY_550_DATA 0x55555555
+#define DDRSS_PHY_551_DATA 0xAAAAAAAA
+#define DDRSS_PHY_552_DATA 0x55555555
+#define DDRSS_PHY_553_DATA 0xAAAAAAAA
+#define DDRSS_PHY_554_DATA 0x00005555
+#define DDRSS_PHY_555_DATA 0x01000100
+#define DDRSS_PHY_556_DATA 0x00800180
+#define DDRSS_PHY_557_DATA 0x00000001
+#define DDRSS_PHY_558_DATA 0x00000000
+#define DDRSS_PHY_559_DATA 0x00000000
+#define DDRSS_PHY_560_DATA 0x00000000
+#define DDRSS_PHY_561_DATA 0x00000000
+#define DDRSS_PHY_562_DATA 0x00000000
+#define DDRSS_PHY_563_DATA 0x00000000
+#define DDRSS_PHY_564_DATA 0x00000000
+#define DDRSS_PHY_565_DATA 0x00000000
+#define DDRSS_PHY_566_DATA 0x00000000
+#define DDRSS_PHY_567_DATA 0x00000000
+#define DDRSS_PHY_568_DATA 0x00000000
+#define DDRSS_PHY_569_DATA 0x00000000
+#define DDRSS_PHY_570_DATA 0x00000000
+#define DDRSS_PHY_571_DATA 0x00000000
+#define DDRSS_PHY_572_DATA 0x00000000
+#define DDRSS_PHY_573_DATA 0x00000000
+#define DDRSS_PHY_574_DATA 0x00000000
+#define DDRSS_PHY_575_DATA 0x00000000
+#define DDRSS_PHY_576_DATA 0x00000000
+#define DDRSS_PHY_577_DATA 0x00000000
+#define DDRSS_PHY_578_DATA 0x00000000
+#define DDRSS_PHY_579_DATA 0x00000004
+#define DDRSS_PHY_580_DATA 0x00000000
+#define DDRSS_PHY_581_DATA 0x00000000
+#define DDRSS_PHY_582_DATA 0x00000000
+#define DDRSS_PHY_583_DATA 0x00000000
+#define DDRSS_PHY_584_DATA 0x00000000
+#define DDRSS_PHY_585_DATA 0x00000000
+#define DDRSS_PHY_586_DATA 0x081F07FF
+#define DDRSS_PHY_587_DATA 0x10200080
+#define DDRSS_PHY_588_DATA 0x00000008
+#define DDRSS_PHY_589_DATA 0x00000401
+#define DDRSS_PHY_590_DATA 0x00000000
+#define DDRSS_PHY_591_DATA 0x01CC0C01
+#define DDRSS_PHY_592_DATA 0x1003CC0C
+#define DDRSS_PHY_593_DATA 0x20000140
+#define DDRSS_PHY_594_DATA 0x07FF0200
+#define DDRSS_PHY_595_DATA 0x0000DD01
+#define DDRSS_PHY_596_DATA 0x00100303
+#define DDRSS_PHY_597_DATA 0x00000000
+#define DDRSS_PHY_598_DATA 0x00000000
+#define DDRSS_PHY_599_DATA 0x00041000
+#define DDRSS_PHY_600_DATA 0x00100010
+#define DDRSS_PHY_601_DATA 0x00100010
+#define DDRSS_PHY_602_DATA 0x00100010
+#define DDRSS_PHY_603_DATA 0x00100010
+#define DDRSS_PHY_604_DATA 0x02040010
+#define DDRSS_PHY_605_DATA 0x00000005
+#define DDRSS_PHY_606_DATA 0x51516042
+#define DDRSS_PHY_607_DATA 0x31C06000
+#define DDRSS_PHY_608_DATA 0x07AB0340
+#define DDRSS_PHY_609_DATA 0x00C0C001
+#define DDRSS_PHY_610_DATA 0x0D000000
+#define DDRSS_PHY_611_DATA 0x000D0C0C
+#define DDRSS_PHY_612_DATA 0x42100010
+#define DDRSS_PHY_613_DATA 0x010C073E
+#define DDRSS_PHY_614_DATA 0x000F0C32
+#define DDRSS_PHY_615_DATA 0x01000140
+#define DDRSS_PHY_616_DATA 0x011E0120
+#define DDRSS_PHY_617_DATA 0x00000C00
+#define DDRSS_PHY_618_DATA 0x000002DD
+#define DDRSS_PHY_619_DATA 0x00030200
+#define DDRSS_PHY_620_DATA 0x02800000
+#define DDRSS_PHY_621_DATA 0x80800000
+#define DDRSS_PHY_622_DATA 0x000D2010
+#define DDRSS_PHY_623_DATA 0x76543210
+#define DDRSS_PHY_624_DATA 0x00000008
+#define DDRSS_PHY_625_DATA 0x045D045D
+#define DDRSS_PHY_626_DATA 0x045D045D
+#define DDRSS_PHY_627_DATA 0x045D045D
+#define DDRSS_PHY_628_DATA 0x045D045D
+#define DDRSS_PHY_629_DATA 0x0000045D
+#define DDRSS_PHY_630_DATA 0x0000A000
+#define DDRSS_PHY_631_DATA 0x00A000A0
+#define DDRSS_PHY_632_DATA 0x00A000A0
+#define DDRSS_PHY_633_DATA 0x00A000A0
+#define DDRSS_PHY_634_DATA 0x00A000A0
+#define DDRSS_PHY_635_DATA 0x00A000A0
+#define DDRSS_PHY_636_DATA 0x00A000A0
+#define DDRSS_PHY_637_DATA 0x00A000A0
+#define DDRSS_PHY_638_DATA 0x00A000A0
+#define DDRSS_PHY_639_DATA 0x00B200A0
+#define DDRSS_PHY_640_DATA 0x01000000
+#define DDRSS_PHY_641_DATA 0x00000000
+#define DDRSS_PHY_642_DATA 0x00000000
+#define DDRSS_PHY_643_DATA 0x00080200
+#define DDRSS_PHY_644_DATA 0x00000000
+#define DDRSS_PHY_645_DATA 0x20202020
+#define DDRSS_PHY_646_DATA 0x20202020
+#define DDRSS_PHY_647_DATA 0xF0F02020
+#define DDRSS_PHY_648_DATA 0x00000000
+#define DDRSS_PHY_649_DATA 0x00000000
+#define DDRSS_PHY_650_DATA 0x00000000
+#define DDRSS_PHY_651_DATA 0x00000000
+#define DDRSS_PHY_652_DATA 0x00000000
+#define DDRSS_PHY_653_DATA 0x00000000
+#define DDRSS_PHY_654_DATA 0x00000000
+#define DDRSS_PHY_655_DATA 0x00000000
+#define DDRSS_PHY_656_DATA 0x00000000
+#define DDRSS_PHY_657_DATA 0x00000000
+#define DDRSS_PHY_658_DATA 0x00000000
+#define DDRSS_PHY_659_DATA 0x00000000
+#define DDRSS_PHY_660_DATA 0x00000000
+#define DDRSS_PHY_661_DATA 0x00000000
+#define DDRSS_PHY_662_DATA 0x00000000
+#define DDRSS_PHY_663_DATA 0x00000000
+#define DDRSS_PHY_664_DATA 0x00000000
+#define DDRSS_PHY_665_DATA 0x00000000
+#define DDRSS_PHY_666_DATA 0x00000000
+#define DDRSS_PHY_667_DATA 0x00000000
+#define DDRSS_PHY_668_DATA 0x00000000
+#define DDRSS_PHY_669_DATA 0x00000000
+#define DDRSS_PHY_670_DATA 0x00000000
+#define DDRSS_PHY_671_DATA 0x00000000
+#define DDRSS_PHY_672_DATA 0x00000000
+#define DDRSS_PHY_673_DATA 0x00000000
+#define DDRSS_PHY_674_DATA 0x00000000
+#define DDRSS_PHY_675_DATA 0x00000000
+#define DDRSS_PHY_676_DATA 0x00000000
+#define DDRSS_PHY_677_DATA 0x00000000
+#define DDRSS_PHY_678_DATA 0x00000000
+#define DDRSS_PHY_679_DATA 0x00000000
+#define DDRSS_PHY_680_DATA 0x00000000
+#define DDRSS_PHY_681_DATA 0x00000000
+#define DDRSS_PHY_682_DATA 0x00000000
+#define DDRSS_PHY_683_DATA 0x00000000
+#define DDRSS_PHY_684_DATA 0x00000000
+#define DDRSS_PHY_685_DATA 0x00000000
+#define DDRSS_PHY_686_DATA 0x00000000
+#define DDRSS_PHY_687_DATA 0x00000000
+#define DDRSS_PHY_688_DATA 0x00000000
+#define DDRSS_PHY_689_DATA 0x00000000
+#define DDRSS_PHY_690_DATA 0x00000000
+#define DDRSS_PHY_691_DATA 0x00000000
+#define DDRSS_PHY_692_DATA 0x00000000
+#define DDRSS_PHY_693_DATA 0x00000000
+#define DDRSS_PHY_694_DATA 0x00000000
+#define DDRSS_PHY_695_DATA 0x00000000
+#define DDRSS_PHY_696_DATA 0x00000000
+#define DDRSS_PHY_697_DATA 0x00000000
+#define DDRSS_PHY_698_DATA 0x00000000
+#define DDRSS_PHY_699_DATA 0x00000000
+#define DDRSS_PHY_700_DATA 0x00000000
+#define DDRSS_PHY_701_DATA 0x00000000
+#define DDRSS_PHY_702_DATA 0x00000000
+#define DDRSS_PHY_703_DATA 0x00000000
+#define DDRSS_PHY_704_DATA 0x00000000
+#define DDRSS_PHY_705_DATA 0x00000000
+#define DDRSS_PHY_706_DATA 0x00000000
+#define DDRSS_PHY_707_DATA 0x00000000
+#define DDRSS_PHY_708_DATA 0x00000000
+#define DDRSS_PHY_709_DATA 0x00000000
+#define DDRSS_PHY_710_DATA 0x00000000
+#define DDRSS_PHY_711_DATA 0x00000000
+#define DDRSS_PHY_712_DATA 0x00000000
+#define DDRSS_PHY_713_DATA 0x00000000
+#define DDRSS_PHY_714_DATA 0x00000000
+#define DDRSS_PHY_715_DATA 0x00000000
+#define DDRSS_PHY_716_DATA 0x00000000
+#define DDRSS_PHY_717_DATA 0x00000000
+#define DDRSS_PHY_718_DATA 0x00000000
+#define DDRSS_PHY_719_DATA 0x00000000
+#define DDRSS_PHY_720_DATA 0x00000000
+#define DDRSS_PHY_721_DATA 0x00000000
+#define DDRSS_PHY_722_DATA 0x00000000
+#define DDRSS_PHY_723_DATA 0x00000000
+#define DDRSS_PHY_724_DATA 0x00000000
+#define DDRSS_PHY_725_DATA 0x00000000
+#define DDRSS_PHY_726_DATA 0x00000000
+#define DDRSS_PHY_727_DATA 0x00000000
+#define DDRSS_PHY_728_DATA 0x00000000
+#define DDRSS_PHY_729_DATA 0x00000000
+#define DDRSS_PHY_730_DATA 0x00000000
+#define DDRSS_PHY_731_DATA 0x00000000
+#define DDRSS_PHY_732_DATA 0x00000000
+#define DDRSS_PHY_733_DATA 0x00000000
+#define DDRSS_PHY_734_DATA 0x00000000
+#define DDRSS_PHY_735_DATA 0x00000000
+#define DDRSS_PHY_736_DATA 0x00000000
+#define DDRSS_PHY_737_DATA 0x00000000
+#define DDRSS_PHY_738_DATA 0x00000000
+#define DDRSS_PHY_739_DATA 0x00000000
+#define DDRSS_PHY_740_DATA 0x00000000
+#define DDRSS_PHY_741_DATA 0x00000000
+#define DDRSS_PHY_742_DATA 0x00000000
+#define DDRSS_PHY_743_DATA 0x00000000
+#define DDRSS_PHY_744_DATA 0x00000000
+#define DDRSS_PHY_745_DATA 0x00000000
+#define DDRSS_PHY_746_DATA 0x00000000
+#define DDRSS_PHY_747_DATA 0x00000000
+#define DDRSS_PHY_748_DATA 0x00000000
+#define DDRSS_PHY_749_DATA 0x00000000
+#define DDRSS_PHY_750_DATA 0x00000000
+#define DDRSS_PHY_751_DATA 0x00000000
+#define DDRSS_PHY_752_DATA 0x00000000
+#define DDRSS_PHY_753_DATA 0x00000000
+#define DDRSS_PHY_754_DATA 0x00000000
+#define DDRSS_PHY_755_DATA 0x00000000
+#define DDRSS_PHY_756_DATA 0x00000000
+#define DDRSS_PHY_757_DATA 0x00000000
+#define DDRSS_PHY_758_DATA 0x00000000
+#define DDRSS_PHY_759_DATA 0x00000000
+#define DDRSS_PHY_760_DATA 0x00000000
+#define DDRSS_PHY_761_DATA 0x00000000
+#define DDRSS_PHY_762_DATA 0x00000000
+#define DDRSS_PHY_763_DATA 0x00000000
+#define DDRSS_PHY_764_DATA 0x00000000
+#define DDRSS_PHY_765_DATA 0x00000000
+#define DDRSS_PHY_766_DATA 0x00000000
+#define DDRSS_PHY_767_DATA 0x00000000
+#define DDRSS_PHY_768_DATA 0x04F00000
+#define DDRSS_PHY_769_DATA 0x00000000
+#define DDRSS_PHY_770_DATA 0x00030200
+#define DDRSS_PHY_771_DATA 0x00000000
+#define DDRSS_PHY_772_DATA 0x00000000
+#define DDRSS_PHY_773_DATA 0x01030000
+#define DDRSS_PHY_774_DATA 0x00010000
+#define DDRSS_PHY_775_DATA 0x01030004
+#define DDRSS_PHY_776_DATA 0x01000000
+#define DDRSS_PHY_777_DATA 0x00000000
+#define DDRSS_PHY_778_DATA 0x00000000
+#define DDRSS_PHY_779_DATA 0x00000000
+#define DDRSS_PHY_780_DATA 0x01010000
+#define DDRSS_PHY_781_DATA 0x00010000
+#define DDRSS_PHY_782_DATA 0x00C00001
+#define DDRSS_PHY_783_DATA 0x00CC0008
+#define DDRSS_PHY_784_DATA 0x00660601
+#define DDRSS_PHY_785_DATA 0x00000003
+#define DDRSS_PHY_786_DATA 0x00000000
+#define DDRSS_PHY_787_DATA 0x00000001
+#define DDRSS_PHY_788_DATA 0x0000AAAA
+#define DDRSS_PHY_789_DATA 0x00005555
+#define DDRSS_PHY_790_DATA 0x0000B5B5
+#define DDRSS_PHY_791_DATA 0x00004A4A
+#define DDRSS_PHY_792_DATA 0x00005656
+#define DDRSS_PHY_793_DATA 0x0000A9A9
+#define DDRSS_PHY_794_DATA 0x0000B7B7
+#define DDRSS_PHY_795_DATA 0x00004848
+#define DDRSS_PHY_796_DATA 0x00000000
+#define DDRSS_PHY_797_DATA 0x00000000
+#define DDRSS_PHY_798_DATA 0x08000000
+#define DDRSS_PHY_799_DATA 0x0F000008
+#define DDRSS_PHY_800_DATA 0x00000F0F
+#define DDRSS_PHY_801_DATA 0x00E4E400
+#define DDRSS_PHY_802_DATA 0x00071020
+#define DDRSS_PHY_803_DATA 0x000C0020
+#define DDRSS_PHY_804_DATA 0x00062000
+#define DDRSS_PHY_805_DATA 0x00000000
+#define DDRSS_PHY_806_DATA 0x55555555
+#define DDRSS_PHY_807_DATA 0xAAAAAAAA
+#define DDRSS_PHY_808_DATA 0x55555555
+#define DDRSS_PHY_809_DATA 0xAAAAAAAA
+#define DDRSS_PHY_810_DATA 0x00005555
+#define DDRSS_PHY_811_DATA 0x01000100
+#define DDRSS_PHY_812_DATA 0x00800180
+#define DDRSS_PHY_813_DATA 0x00000000
+#define DDRSS_PHY_814_DATA 0x00000000
+#define DDRSS_PHY_815_DATA 0x00000000
+#define DDRSS_PHY_816_DATA 0x00000000
+#define DDRSS_PHY_817_DATA 0x00000000
+#define DDRSS_PHY_818_DATA 0x00000000
+#define DDRSS_PHY_819_DATA 0x00000000
+#define DDRSS_PHY_820_DATA 0x00000000
+#define DDRSS_PHY_821_DATA 0x00000000
+#define DDRSS_PHY_822_DATA 0x00000000
+#define DDRSS_PHY_823_DATA 0x00000000
+#define DDRSS_PHY_824_DATA 0x00000000
+#define DDRSS_PHY_825_DATA 0x00000000
+#define DDRSS_PHY_826_DATA 0x00000000
+#define DDRSS_PHY_827_DATA 0x00000000
+#define DDRSS_PHY_828_DATA 0x00000000
+#define DDRSS_PHY_829_DATA 0x00000000
+#define DDRSS_PHY_830_DATA 0x00000000
+#define DDRSS_PHY_831_DATA 0x00000000
+#define DDRSS_PHY_832_DATA 0x00000000
+#define DDRSS_PHY_833_DATA 0x00000000
+#define DDRSS_PHY_834_DATA 0x00000000
+#define DDRSS_PHY_835_DATA 0x00000004
+#define DDRSS_PHY_836_DATA 0x00000000
+#define DDRSS_PHY_837_DATA 0x00000000
+#define DDRSS_PHY_838_DATA 0x00000000
+#define DDRSS_PHY_839_DATA 0x00000000
+#define DDRSS_PHY_840_DATA 0x00000000
+#define DDRSS_PHY_841_DATA 0x00000000
+#define DDRSS_PHY_842_DATA 0x081F07FF
+#define DDRSS_PHY_843_DATA 0x10200080
+#define DDRSS_PHY_844_DATA 0x00000008
+#define DDRSS_PHY_845_DATA 0x00000401
+#define DDRSS_PHY_846_DATA 0x00000000
+#define DDRSS_PHY_847_DATA 0x01CC0C01
+#define DDRSS_PHY_848_DATA 0x1003CC0C
+#define DDRSS_PHY_849_DATA 0x20000140
+#define DDRSS_PHY_850_DATA 0x07FF0200
+#define DDRSS_PHY_851_DATA 0x0000DD01
+#define DDRSS_PHY_852_DATA 0x00100303
+#define DDRSS_PHY_853_DATA 0x00000000
+#define DDRSS_PHY_854_DATA 0x00000000
+#define DDRSS_PHY_855_DATA 0x00041000
+#define DDRSS_PHY_856_DATA 0x00100010
+#define DDRSS_PHY_857_DATA 0x00100010
+#define DDRSS_PHY_858_DATA 0x00100010
+#define DDRSS_PHY_859_DATA 0x00100010
+#define DDRSS_PHY_860_DATA 0x02040010
+#define DDRSS_PHY_861_DATA 0x00000005
+#define DDRSS_PHY_862_DATA 0x51516042
+#define DDRSS_PHY_863_DATA 0x31C06000
+#define DDRSS_PHY_864_DATA 0x07AB0340
+#define DDRSS_PHY_865_DATA 0x00C0C001
+#define DDRSS_PHY_866_DATA 0x0D000000
+#define DDRSS_PHY_867_DATA 0x000D0C0C
+#define DDRSS_PHY_868_DATA 0x42100010
+#define DDRSS_PHY_869_DATA 0x010C073E
+#define DDRSS_PHY_870_DATA 0x000F0C32
+#define DDRSS_PHY_871_DATA 0x01000140
+#define DDRSS_PHY_872_DATA 0x011E0120
+#define DDRSS_PHY_873_DATA 0x00000C00
+#define DDRSS_PHY_874_DATA 0x000002DD
+#define DDRSS_PHY_875_DATA 0x00030200
+#define DDRSS_PHY_876_DATA 0x02800000
+#define DDRSS_PHY_877_DATA 0x80800000
+#define DDRSS_PHY_878_DATA 0x000D2010
+#define DDRSS_PHY_879_DATA 0x76543210
+#define DDRSS_PHY_880_DATA 0x00000008
+#define DDRSS_PHY_881_DATA 0x045D045D
+#define DDRSS_PHY_882_DATA 0x045D045D
+#define DDRSS_PHY_883_DATA 0x045D045D
+#define DDRSS_PHY_884_DATA 0x045D045D
+#define DDRSS_PHY_885_DATA 0x0000045D
+#define DDRSS_PHY_886_DATA 0x0000A000
+#define DDRSS_PHY_887_DATA 0x00A000A0
+#define DDRSS_PHY_888_DATA 0x00A000A0
+#define DDRSS_PHY_889_DATA 0x00A000A0
+#define DDRSS_PHY_890_DATA 0x00A000A0
+#define DDRSS_PHY_891_DATA 0x00A000A0
+#define DDRSS_PHY_892_DATA 0x00A000A0
+#define DDRSS_PHY_893_DATA 0x00A000A0
+#define DDRSS_PHY_894_DATA 0x00A000A0
+#define DDRSS_PHY_895_DATA 0x00B200A0
+#define DDRSS_PHY_896_DATA 0x01000000
+#define DDRSS_PHY_897_DATA 0x00000000
+#define DDRSS_PHY_898_DATA 0x00000000
+#define DDRSS_PHY_899_DATA 0x00080200
+#define DDRSS_PHY_900_DATA 0x00000000
+#define DDRSS_PHY_901_DATA 0x20202020
+#define DDRSS_PHY_902_DATA 0x20202020
+#define DDRSS_PHY_903_DATA 0xF0F02020
+#define DDRSS_PHY_904_DATA 0x00000000
+#define DDRSS_PHY_905_DATA 0x00000000
+#define DDRSS_PHY_906_DATA 0x00000000
+#define DDRSS_PHY_907_DATA 0x00000000
+#define DDRSS_PHY_908_DATA 0x00000000
+#define DDRSS_PHY_909_DATA 0x00000000
+#define DDRSS_PHY_910_DATA 0x00000000
+#define DDRSS_PHY_911_DATA 0x00000000
+#define DDRSS_PHY_912_DATA 0x00000000
+#define DDRSS_PHY_913_DATA 0x00000000
+#define DDRSS_PHY_914_DATA 0x00000000
+#define DDRSS_PHY_915_DATA 0x00000000
+#define DDRSS_PHY_916_DATA 0x00000000
+#define DDRSS_PHY_917_DATA 0x00000000
+#define DDRSS_PHY_918_DATA 0x00000000
+#define DDRSS_PHY_919_DATA 0x00000000
+#define DDRSS_PHY_920_DATA 0x00000000
+#define DDRSS_PHY_921_DATA 0x00000000
+#define DDRSS_PHY_922_DATA 0x00000000
+#define DDRSS_PHY_923_DATA 0x00000000
+#define DDRSS_PHY_924_DATA 0x00000000
+#define DDRSS_PHY_925_DATA 0x00000000
+#define DDRSS_PHY_926_DATA 0x00000000
+#define DDRSS_PHY_927_DATA 0x00000000
+#define DDRSS_PHY_928_DATA 0x00000000
+#define DDRSS_PHY_929_DATA 0x00000000
+#define DDRSS_PHY_930_DATA 0x00000000
+#define DDRSS_PHY_931_DATA 0x00000000
+#define DDRSS_PHY_932_DATA 0x00000000
+#define DDRSS_PHY_933_DATA 0x00000000
+#define DDRSS_PHY_934_DATA 0x00000000
+#define DDRSS_PHY_935_DATA 0x00000000
+#define DDRSS_PHY_936_DATA 0x00000000
+#define DDRSS_PHY_937_DATA 0x00000000
+#define DDRSS_PHY_938_DATA 0x00000000
+#define DDRSS_PHY_939_DATA 0x00000000
+#define DDRSS_PHY_940_DATA 0x00000000
+#define DDRSS_PHY_941_DATA 0x00000000
+#define DDRSS_PHY_942_DATA 0x00000000
+#define DDRSS_PHY_943_DATA 0x00000000
+#define DDRSS_PHY_944_DATA 0x00000000
+#define DDRSS_PHY_945_DATA 0x00000000
+#define DDRSS_PHY_946_DATA 0x00000000
+#define DDRSS_PHY_947_DATA 0x00000000
+#define DDRSS_PHY_948_DATA 0x00000000
+#define DDRSS_PHY_949_DATA 0x00000000
+#define DDRSS_PHY_950_DATA 0x00000000
+#define DDRSS_PHY_951_DATA 0x00000000
+#define DDRSS_PHY_952_DATA 0x00000000
+#define DDRSS_PHY_953_DATA 0x00000000
+#define DDRSS_PHY_954_DATA 0x00000000
+#define DDRSS_PHY_955_DATA 0x00000000
+#define DDRSS_PHY_956_DATA 0x00000000
+#define DDRSS_PHY_957_DATA 0x00000000
+#define DDRSS_PHY_958_DATA 0x00000000
+#define DDRSS_PHY_959_DATA 0x00000000
+#define DDRSS_PHY_960_DATA 0x00000000
+#define DDRSS_PHY_961_DATA 0x00000000
+#define DDRSS_PHY_962_DATA 0x00000000
+#define DDRSS_PHY_963_DATA 0x00000000
+#define DDRSS_PHY_964_DATA 0x00000000
+#define DDRSS_PHY_965_DATA 0x00000000
+#define DDRSS_PHY_966_DATA 0x00000000
+#define DDRSS_PHY_967_DATA 0x00000000
+#define DDRSS_PHY_968_DATA 0x00000000
+#define DDRSS_PHY_969_DATA 0x00000000
+#define DDRSS_PHY_970_DATA 0x00000000
+#define DDRSS_PHY_971_DATA 0x00000000
+#define DDRSS_PHY_972_DATA 0x00000000
+#define DDRSS_PHY_973_DATA 0x00000000
+#define DDRSS_PHY_974_DATA 0x00000000
+#define DDRSS_PHY_975_DATA 0x00000000
+#define DDRSS_PHY_976_DATA 0x00000000
+#define DDRSS_PHY_977_DATA 0x00000000
+#define DDRSS_PHY_978_DATA 0x00000000
+#define DDRSS_PHY_979_DATA 0x00000000
+#define DDRSS_PHY_980_DATA 0x00000000
+#define DDRSS_PHY_981_DATA 0x00000000
+#define DDRSS_PHY_982_DATA 0x00000000
+#define DDRSS_PHY_983_DATA 0x00000000
+#define DDRSS_PHY_984_DATA 0x00000000
+#define DDRSS_PHY_985_DATA 0x00000000
+#define DDRSS_PHY_986_DATA 0x00000000
+#define DDRSS_PHY_987_DATA 0x00000000
+#define DDRSS_PHY_988_DATA 0x00000000
+#define DDRSS_PHY_989_DATA 0x00000000
+#define DDRSS_PHY_990_DATA 0x00000000
+#define DDRSS_PHY_991_DATA 0x00000000
+#define DDRSS_PHY_992_DATA 0x00000000
+#define DDRSS_PHY_993_DATA 0x00000000
+#define DDRSS_PHY_994_DATA 0x00000000
+#define DDRSS_PHY_995_DATA 0x00000000
+#define DDRSS_PHY_996_DATA 0x00000000
+#define DDRSS_PHY_997_DATA 0x00000000
+#define DDRSS_PHY_998_DATA 0x00000000
+#define DDRSS_PHY_999_DATA 0x00000000
+#define DDRSS_PHY_1000_DATA 0x00000000
+#define DDRSS_PHY_1001_DATA 0x00000000
+#define DDRSS_PHY_1002_DATA 0x00000000
+#define DDRSS_PHY_1003_DATA 0x00000000
+#define DDRSS_PHY_1004_DATA 0x00000000
+#define DDRSS_PHY_1005_DATA 0x00000000
+#define DDRSS_PHY_1006_DATA 0x00000000
+#define DDRSS_PHY_1007_DATA 0x00000000
+#define DDRSS_PHY_1008_DATA 0x00000000
+#define DDRSS_PHY_1009_DATA 0x00000000
+#define DDRSS_PHY_1010_DATA 0x00000000
+#define DDRSS_PHY_1011_DATA 0x00000000
+#define DDRSS_PHY_1012_DATA 0x00000000
+#define DDRSS_PHY_1013_DATA 0x00000000
+#define DDRSS_PHY_1014_DATA 0x00000000
+#define DDRSS_PHY_1015_DATA 0x00000000
+#define DDRSS_PHY_1016_DATA 0x00000000
+#define DDRSS_PHY_1017_DATA 0x00000000
+#define DDRSS_PHY_1018_DATA 0x00000000
+#define DDRSS_PHY_1019_DATA 0x00000000
+#define DDRSS_PHY_1020_DATA 0x00000000
+#define DDRSS_PHY_1021_DATA 0x00000000
+#define DDRSS_PHY_1022_DATA 0x00000000
+#define DDRSS_PHY_1023_DATA 0x00000000
+#define DDRSS_PHY_1024_DATA 0x00000000
+#define DDRSS_PHY_1025_DATA 0x00000000
+#define DDRSS_PHY_1026_DATA 0x00000000
+#define DDRSS_PHY_1027_DATA 0x00000000
+#define DDRSS_PHY_1028_DATA 0x00000000
+#define DDRSS_PHY_1029_DATA 0x00000100
+#define DDRSS_PHY_1030_DATA 0x00000200
+#define DDRSS_PHY_1031_DATA 0x00000000
+#define DDRSS_PHY_1032_DATA 0x00000000
+#define DDRSS_PHY_1033_DATA 0x00000000
+#define DDRSS_PHY_1034_DATA 0x00000000
+#define DDRSS_PHY_1035_DATA 0x00400000
+#define DDRSS_PHY_1036_DATA 0x00000080
+#define DDRSS_PHY_1037_DATA 0x00DCBA98
+#define DDRSS_PHY_1038_DATA 0x03000000
+#define DDRSS_PHY_1039_DATA 0x00200000
+#define DDRSS_PHY_1040_DATA 0x00000000
+#define DDRSS_PHY_1041_DATA 0x00000000
+#define DDRSS_PHY_1042_DATA 0x00000000
+#define DDRSS_PHY_1043_DATA 0x00000000
+#define DDRSS_PHY_1044_DATA 0x00000000
+#define DDRSS_PHY_1045_DATA 0x0000002A
+#define DDRSS_PHY_1046_DATA 0x00000015
+#define DDRSS_PHY_1047_DATA 0x00000015
+#define DDRSS_PHY_1048_DATA 0x0000002A
+#define DDRSS_PHY_1049_DATA 0x00000033
+#define DDRSS_PHY_1050_DATA 0x0000000C
+#define DDRSS_PHY_1051_DATA 0x0000000C
+#define DDRSS_PHY_1052_DATA 0x00000033
+#define DDRSS_PHY_1053_DATA 0x0A418820
+#define DDRSS_PHY_1054_DATA 0x003F0000
+#define DDRSS_PHY_1055_DATA 0x000F013F
+#define DDRSS_PHY_1056_DATA 0x20202003
+#define DDRSS_PHY_1057_DATA 0x00202020
+#define DDRSS_PHY_1058_DATA 0x20008008
+#define DDRSS_PHY_1059_DATA 0x00000810
+#define DDRSS_PHY_1060_DATA 0x00000F00
+#define DDRSS_PHY_1061_DATA 0x000405CC
+#define DDRSS_PHY_1062_DATA 0x03000004
+#define DDRSS_PHY_1063_DATA 0x00030000
+#define DDRSS_PHY_1064_DATA 0x00000300
+#define DDRSS_PHY_1065_DATA 0x00000300
+#define DDRSS_PHY_1066_DATA 0x00000300
+#define DDRSS_PHY_1067_DATA 0x00000300
+#define DDRSS_PHY_1068_DATA 0x42080010
+#define DDRSS_PHY_1069_DATA 0x0000803E
+#define DDRSS_PHY_1070_DATA 0x00000001
+#define DDRSS_PHY_1071_DATA 0x01000002
+#define DDRSS_PHY_1072_DATA 0x00008000
+#define DDRSS_PHY_1073_DATA 0x00000000
+#define DDRSS_PHY_1074_DATA 0x00000000
+#define DDRSS_PHY_1075_DATA 0x00000000
+#define DDRSS_PHY_1076_DATA 0x00000000
+#define DDRSS_PHY_1077_DATA 0x00000000
+#define DDRSS_PHY_1078_DATA 0x00000000
+#define DDRSS_PHY_1079_DATA 0x00000000
+#define DDRSS_PHY_1080_DATA 0x00000000
+#define DDRSS_PHY_1081_DATA 0x00000000
+#define DDRSS_PHY_1082_DATA 0x00000000
+#define DDRSS_PHY_1083_DATA 0x00000000
+#define DDRSS_PHY_1084_DATA 0x00000000
+#define DDRSS_PHY_1085_DATA 0x00000000
+#define DDRSS_PHY_1086_DATA 0x00000000
+#define DDRSS_PHY_1087_DATA 0x00000000
+#define DDRSS_PHY_1088_DATA 0x00000000
+#define DDRSS_PHY_1089_DATA 0x00000000
+#define DDRSS_PHY_1090_DATA 0x00000000
+#define DDRSS_PHY_1091_DATA 0x00000000
+#define DDRSS_PHY_1092_DATA 0x00000000
+#define DDRSS_PHY_1093_DATA 0x00000000
+#define DDRSS_PHY_1094_DATA 0x00000000
+#define DDRSS_PHY_1095_DATA 0x00000000
+#define DDRSS_PHY_1096_DATA 0x00000000
+#define DDRSS_PHY_1097_DATA 0x00000000
+#define DDRSS_PHY_1098_DATA 0x00000000
+#define DDRSS_PHY_1099_DATA 0x00000000
+#define DDRSS_PHY_1100_DATA 0x00000000
+#define DDRSS_PHY_1101_DATA 0x00000000
+#define DDRSS_PHY_1102_DATA 0x00000000
+#define DDRSS_PHY_1103_DATA 0x00000000
+#define DDRSS_PHY_1104_DATA 0x00000000
+#define DDRSS_PHY_1105_DATA 0x00000000
+#define DDRSS_PHY_1106_DATA 0x00000000
+#define DDRSS_PHY_1107_DATA 0x00000000
+#define DDRSS_PHY_1108_DATA 0x00000000
+#define DDRSS_PHY_1109_DATA 0x00000000
+#define DDRSS_PHY_1110_DATA 0x00000000
+#define DDRSS_PHY_1111_DATA 0x00000000
+#define DDRSS_PHY_1112_DATA 0x00000000
+#define DDRSS_PHY_1113_DATA 0x00000000
+#define DDRSS_PHY_1114_DATA 0x00000000
+#define DDRSS_PHY_1115_DATA 0x00000000
+#define DDRSS_PHY_1116_DATA 0x00000000
+#define DDRSS_PHY_1117_DATA 0x00000000
+#define DDRSS_PHY_1118_DATA 0x00000000
+#define DDRSS_PHY_1119_DATA 0x00000000
+#define DDRSS_PHY_1120_DATA 0x00000000
+#define DDRSS_PHY_1121_DATA 0x00000000
+#define DDRSS_PHY_1122_DATA 0x00000000
+#define DDRSS_PHY_1123_DATA 0x00000000
+#define DDRSS_PHY_1124_DATA 0x00000000
+#define DDRSS_PHY_1125_DATA 0x00000000
+#define DDRSS_PHY_1126_DATA 0x00000000
+#define DDRSS_PHY_1127_DATA 0x00000000
+#define DDRSS_PHY_1128_DATA 0x00000000
+#define DDRSS_PHY_1129_DATA 0x00000000
+#define DDRSS_PHY_1130_DATA 0x00000000
+#define DDRSS_PHY_1131_DATA 0x00000000
+#define DDRSS_PHY_1132_DATA 0x00000000
+#define DDRSS_PHY_1133_DATA 0x00000000
+#define DDRSS_PHY_1134_DATA 0x00000000
+#define DDRSS_PHY_1135_DATA 0x00000000
+#define DDRSS_PHY_1136_DATA 0x00000000
+#define DDRSS_PHY_1137_DATA 0x00000000
+#define DDRSS_PHY_1138_DATA 0x00000000
+#define DDRSS_PHY_1139_DATA 0x00000000
+#define DDRSS_PHY_1140_DATA 0x00000000
+#define DDRSS_PHY_1141_DATA 0x00000000
+#define DDRSS_PHY_1142_DATA 0x00000000
+#define DDRSS_PHY_1143_DATA 0x00000000
+#define DDRSS_PHY_1144_DATA 0x00000000
+#define DDRSS_PHY_1145_DATA 0x00000000
+#define DDRSS_PHY_1146_DATA 0x00000000
+#define DDRSS_PHY_1147_DATA 0x00000000
+#define DDRSS_PHY_1148_DATA 0x00000000
+#define DDRSS_PHY_1149_DATA 0x00000000
+#define DDRSS_PHY_1150_DATA 0x00000000
+#define DDRSS_PHY_1151_DATA 0x00000000
+#define DDRSS_PHY_1152_DATA 0x00000000
+#define DDRSS_PHY_1153_DATA 0x00000000
+#define DDRSS_PHY_1154_DATA 0x00000000
+#define DDRSS_PHY_1155_DATA 0x00000000
+#define DDRSS_PHY_1156_DATA 0x00000000
+#define DDRSS_PHY_1157_DATA 0x00000000
+#define DDRSS_PHY_1158_DATA 0x00000000
+#define DDRSS_PHY_1159_DATA 0x00000000
+#define DDRSS_PHY_1160_DATA 0x00000000
+#define DDRSS_PHY_1161_DATA 0x00000000
+#define DDRSS_PHY_1162_DATA 0x00000000
+#define DDRSS_PHY_1163_DATA 0x00000000
+#define DDRSS_PHY_1164_DATA 0x00000000
+#define DDRSS_PHY_1165_DATA 0x00000000
+#define DDRSS_PHY_1166_DATA 0x00000000
+#define DDRSS_PHY_1167_DATA 0x00000000
+#define DDRSS_PHY_1168_DATA 0x00000000
+#define DDRSS_PHY_1169_DATA 0x00000000
+#define DDRSS_PHY_1170_DATA 0x00000000
+#define DDRSS_PHY_1171_DATA 0x00000000
+#define DDRSS_PHY_1172_DATA 0x00000000
+#define DDRSS_PHY_1173_DATA 0x00000000
+#define DDRSS_PHY_1174_DATA 0x00000000
+#define DDRSS_PHY_1175_DATA 0x00000000
+#define DDRSS_PHY_1176_DATA 0x00000000
+#define DDRSS_PHY_1177_DATA 0x00000000
+#define DDRSS_PHY_1178_DATA 0x00000000
+#define DDRSS_PHY_1179_DATA 0x00000000
+#define DDRSS_PHY_1180_DATA 0x00000000
+#define DDRSS_PHY_1181_DATA 0x00000000
+#define DDRSS_PHY_1182_DATA 0x00000000
+#define DDRSS_PHY_1183_DATA 0x00000000
+#define DDRSS_PHY_1184_DATA 0x00000000
+#define DDRSS_PHY_1185_DATA 0x00000000
+#define DDRSS_PHY_1186_DATA 0x00000000
+#define DDRSS_PHY_1187_DATA 0x00000000
+#define DDRSS_PHY_1188_DATA 0x00000000
+#define DDRSS_PHY_1189_DATA 0x00000000
+#define DDRSS_PHY_1190_DATA 0x00000000
+#define DDRSS_PHY_1191_DATA 0x00000000
+#define DDRSS_PHY_1192_DATA 0x00000000
+#define DDRSS_PHY_1193_DATA 0x00000000
+#define DDRSS_PHY_1194_DATA 0x00000000
+#define DDRSS_PHY_1195_DATA 0x00000000
+#define DDRSS_PHY_1196_DATA 0x00000000
+#define DDRSS_PHY_1197_DATA 0x00000000
+#define DDRSS_PHY_1198_DATA 0x00000000
+#define DDRSS_PHY_1199_DATA 0x00000000
+#define DDRSS_PHY_1200_DATA 0x00000000
+#define DDRSS_PHY_1201_DATA 0x00000000
+#define DDRSS_PHY_1202_DATA 0x00000000
+#define DDRSS_PHY_1203_DATA 0x00000000
+#define DDRSS_PHY_1204_DATA 0x00000000
+#define DDRSS_PHY_1205_DATA 0x00000000
+#define DDRSS_PHY_1206_DATA 0x00000000
+#define DDRSS_PHY_1207_DATA 0x00000000
+#define DDRSS_PHY_1208_DATA 0x00000000
+#define DDRSS_PHY_1209_DATA 0x00000000
+#define DDRSS_PHY_1210_DATA 0x00000000
+#define DDRSS_PHY_1211_DATA 0x00000000
+#define DDRSS_PHY_1212_DATA 0x00000000
+#define DDRSS_PHY_1213_DATA 0x00000000
+#define DDRSS_PHY_1214_DATA 0x00000000
+#define DDRSS_PHY_1215_DATA 0x00000000
+#define DDRSS_PHY_1216_DATA 0x00000000
+#define DDRSS_PHY_1217_DATA 0x00000000
+#define DDRSS_PHY_1218_DATA 0x00000000
+#define DDRSS_PHY_1219_DATA 0x00000000
+#define DDRSS_PHY_1220_DATA 0x00000000
+#define DDRSS_PHY_1221_DATA 0x00000000
+#define DDRSS_PHY_1222_DATA 0x00000000
+#define DDRSS_PHY_1223_DATA 0x00000000
+#define DDRSS_PHY_1224_DATA 0x00000000
+#define DDRSS_PHY_1225_DATA 0x00000000
+#define DDRSS_PHY_1226_DATA 0x00000000
+#define DDRSS_PHY_1227_DATA 0x00000000
+#define DDRSS_PHY_1228_DATA 0x00000000
+#define DDRSS_PHY_1229_DATA 0x00000000
+#define DDRSS_PHY_1230_DATA 0x00000000
+#define DDRSS_PHY_1231_DATA 0x00000000
+#define DDRSS_PHY_1232_DATA 0x00000000
+#define DDRSS_PHY_1233_DATA 0x00000000
+#define DDRSS_PHY_1234_DATA 0x00000000
+#define DDRSS_PHY_1235_DATA 0x00000000
+#define DDRSS_PHY_1236_DATA 0x00000000
+#define DDRSS_PHY_1237_DATA 0x00000000
+#define DDRSS_PHY_1238_DATA 0x00000000
+#define DDRSS_PHY_1239_DATA 0x00000000
+#define DDRSS_PHY_1240_DATA 0x00000000
+#define DDRSS_PHY_1241_DATA 0x00000000
+#define DDRSS_PHY_1242_DATA 0x00000000
+#define DDRSS_PHY_1243_DATA 0x00000000
+#define DDRSS_PHY_1244_DATA 0x00000000
+#define DDRSS_PHY_1245_DATA 0x00000000
+#define DDRSS_PHY_1246_DATA 0x00000000
+#define DDRSS_PHY_1247_DATA 0x00000000
+#define DDRSS_PHY_1248_DATA 0x00000000
+#define DDRSS_PHY_1249_DATA 0x00000000
+#define DDRSS_PHY_1250_DATA 0x00000000
+#define DDRSS_PHY_1251_DATA 0x00000000
+#define DDRSS_PHY_1252_DATA 0x00000000
+#define DDRSS_PHY_1253_DATA 0x00000000
+#define DDRSS_PHY_1254_DATA 0x00000000
+#define DDRSS_PHY_1255_DATA 0x00000000
+#define DDRSS_PHY_1256_DATA 0x00000000
+#define DDRSS_PHY_1257_DATA 0x00000000
+#define DDRSS_PHY_1258_DATA 0x00000000
+#define DDRSS_PHY_1259_DATA 0x00000000
+#define DDRSS_PHY_1260_DATA 0x00000000
+#define DDRSS_PHY_1261_DATA 0x00000000
+#define DDRSS_PHY_1262_DATA 0x00000000
+#define DDRSS_PHY_1263_DATA 0x00000000
+#define DDRSS_PHY_1264_DATA 0x00000000
+#define DDRSS_PHY_1265_DATA 0x00000000
+#define DDRSS_PHY_1266_DATA 0x00000000
+#define DDRSS_PHY_1267_DATA 0x00000000
+#define DDRSS_PHY_1268_DATA 0x00000000
+#define DDRSS_PHY_1269_DATA 0x00000000
+#define DDRSS_PHY_1270_DATA 0x00000000
+#define DDRSS_PHY_1271_DATA 0x00000000
+#define DDRSS_PHY_1272_DATA 0x00000000
+#define DDRSS_PHY_1273_DATA 0x00000000
+#define DDRSS_PHY_1274_DATA 0x00000000
+#define DDRSS_PHY_1275_DATA 0x00000000
+#define DDRSS_PHY_1276_DATA 0x00000000
+#define DDRSS_PHY_1277_DATA 0x00000000
+#define DDRSS_PHY_1278_DATA 0x00000000
+#define DDRSS_PHY_1279_DATA 0x00000000
+#define DDRSS_PHY_1280_DATA 0x00000000
+#define DDRSS_PHY_1281_DATA 0x00000000
+#define DDRSS_PHY_1282_DATA 0x00000000
+#define DDRSS_PHY_1283_DATA 0x00000000
+#define DDRSS_PHY_1284_DATA 0x00000000
+#define DDRSS_PHY_1285_DATA 0x00000100
+#define DDRSS_PHY_1286_DATA 0x00000200
+#define DDRSS_PHY_1287_DATA 0x00000000
+#define DDRSS_PHY_1288_DATA 0x00000000
+#define DDRSS_PHY_1289_DATA 0x00000000
+#define DDRSS_PHY_1290_DATA 0x00000000
+#define DDRSS_PHY_1291_DATA 0x00400000
+#define DDRSS_PHY_1292_DATA 0x00000080
+#define DDRSS_PHY_1293_DATA 0x00DCBA98
+#define DDRSS_PHY_1294_DATA 0x03000000
+#define DDRSS_PHY_1295_DATA 0x00200000
+#define DDRSS_PHY_1296_DATA 0x00000000
+#define DDRSS_PHY_1297_DATA 0x00000000
+#define DDRSS_PHY_1298_DATA 0x00000000
+#define DDRSS_PHY_1299_DATA 0x00000000
+#define DDRSS_PHY_1300_DATA 0x00000000
+#define DDRSS_PHY_1301_DATA 0x0000002A
+#define DDRSS_PHY_1302_DATA 0x00000015
+#define DDRSS_PHY_1303_DATA 0x00000015
+#define DDRSS_PHY_1304_DATA 0x0000002A
+#define DDRSS_PHY_1305_DATA 0x00000033
+#define DDRSS_PHY_1306_DATA 0x0000000C
+#define DDRSS_PHY_1307_DATA 0x0000000C
+#define DDRSS_PHY_1308_DATA 0x00000033
+#define DDRSS_PHY_1309_DATA 0x0A418820
+#define DDRSS_PHY_1310_DATA 0x00000000
+#define DDRSS_PHY_1311_DATA 0x000F0000
+#define DDRSS_PHY_1312_DATA 0x20202003
+#define DDRSS_PHY_1313_DATA 0x00202020
+#define DDRSS_PHY_1314_DATA 0x20008008
+#define DDRSS_PHY_1315_DATA 0x00000810
+#define DDRSS_PHY_1316_DATA 0x00000F00
+#define DDRSS_PHY_1317_DATA 0x000405CC
+#define DDRSS_PHY_1318_DATA 0x03000004
+#define DDRSS_PHY_1319_DATA 0x00030000
+#define DDRSS_PHY_1320_DATA 0x00000300
+#define DDRSS_PHY_1321_DATA 0x00000300
+#define DDRSS_PHY_1322_DATA 0x00000300
+#define DDRSS_PHY_1323_DATA 0x00000300
+#define DDRSS_PHY_1324_DATA 0x42080010
+#define DDRSS_PHY_1325_DATA 0x0000803E
+#define DDRSS_PHY_1326_DATA 0x00000001
+#define DDRSS_PHY_1327_DATA 0x01000002
+#define DDRSS_PHY_1328_DATA 0x00008000
+#define DDRSS_PHY_1329_DATA 0x00000000
+#define DDRSS_PHY_1330_DATA 0x00000000
+#define DDRSS_PHY_1331_DATA 0x00000000
+#define DDRSS_PHY_1332_DATA 0x00000000
+#define DDRSS_PHY_1333_DATA 0x00000000
+#define DDRSS_PHY_1334_DATA 0x00000000
+#define DDRSS_PHY_1335_DATA 0x00000000
+#define DDRSS_PHY_1336_DATA 0x00000000
+#define DDRSS_PHY_1337_DATA 0x00000000
+#define DDRSS_PHY_1338_DATA 0x00000000
+#define DDRSS_PHY_1339_DATA 0x00000000
+#define DDRSS_PHY_1340_DATA 0x00000000
+#define DDRSS_PHY_1341_DATA 0x00000000
+#define DDRSS_PHY_1342_DATA 0x00000000
+#define DDRSS_PHY_1343_DATA 0x00000000
+#define DDRSS_PHY_1344_DATA 0x00000000
+#define DDRSS_PHY_1345_DATA 0x00000000
+#define DDRSS_PHY_1346_DATA 0x00000000
+#define DDRSS_PHY_1347_DATA 0x00000000
+#define DDRSS_PHY_1348_DATA 0x00000000
+#define DDRSS_PHY_1349_DATA 0x00000000
+#define DDRSS_PHY_1350_DATA 0x00000000
+#define DDRSS_PHY_1351_DATA 0x00000000
+#define DDRSS_PHY_1352_DATA 0x00000000
+#define DDRSS_PHY_1353_DATA 0x00000000
+#define DDRSS_PHY_1354_DATA 0x00000000
+#define DDRSS_PHY_1355_DATA 0x00000000
+#define DDRSS_PHY_1356_DATA 0x00000000
+#define DDRSS_PHY_1357_DATA 0x00000000
+#define DDRSS_PHY_1358_DATA 0x00000000
+#define DDRSS_PHY_1359_DATA 0x00000000
+#define DDRSS_PHY_1360_DATA 0x00000000
+#define DDRSS_PHY_1361_DATA 0x00000000
+#define DDRSS_PHY_1362_DATA 0x00000000
+#define DDRSS_PHY_1363_DATA 0x00000000
+#define DDRSS_PHY_1364_DATA 0x00000000
+#define DDRSS_PHY_1365_DATA 0x00000000
+#define DDRSS_PHY_1366_DATA 0x00000000
+#define DDRSS_PHY_1367_DATA 0x00000000
+#define DDRSS_PHY_1368_DATA 0x00000000
+#define DDRSS_PHY_1369_DATA 0x00000000
+#define DDRSS_PHY_1370_DATA 0x00000000
+#define DDRSS_PHY_1371_DATA 0x00000000
+#define DDRSS_PHY_1372_DATA 0x00000000
+#define DDRSS_PHY_1373_DATA 0x00000000
+#define DDRSS_PHY_1374_DATA 0x00000000
+#define DDRSS_PHY_1375_DATA 0x00000000
+#define DDRSS_PHY_1376_DATA 0x00000000
+#define DDRSS_PHY_1377_DATA 0x00000000
+#define DDRSS_PHY_1378_DATA 0x00000000
+#define DDRSS_PHY_1379_DATA 0x00000000
+#define DDRSS_PHY_1380_DATA 0x00000000
+#define DDRSS_PHY_1381_DATA 0x00000000
+#define DDRSS_PHY_1382_DATA 0x00000000
+#define DDRSS_PHY_1383_DATA 0x00000000
+#define DDRSS_PHY_1384_DATA 0x00000000
+#define DDRSS_PHY_1385_DATA 0x00000000
+#define DDRSS_PHY_1386_DATA 0x00000000
+#define DDRSS_PHY_1387_DATA 0x00000000
+#define DDRSS_PHY_1388_DATA 0x00000000
+#define DDRSS_PHY_1389_DATA 0x00000000
+#define DDRSS_PHY_1390_DATA 0x00000000
+#define DDRSS_PHY_1391_DATA 0x00000000
+#define DDRSS_PHY_1392_DATA 0x00000000
+#define DDRSS_PHY_1393_DATA 0x00000000
+#define DDRSS_PHY_1394_DATA 0x00000000
+#define DDRSS_PHY_1395_DATA 0x00000000
+#define DDRSS_PHY_1396_DATA 0x00000000
+#define DDRSS_PHY_1397_DATA 0x00000000
+#define DDRSS_PHY_1398_DATA 0x00000000
+#define DDRSS_PHY_1399_DATA 0x00000000
+#define DDRSS_PHY_1400_DATA 0x00000000
+#define DDRSS_PHY_1401_DATA 0x00000000
+#define DDRSS_PHY_1402_DATA 0x00000000
+#define DDRSS_PHY_1403_DATA 0x00000000
+#define DDRSS_PHY_1404_DATA 0x00000000
+#define DDRSS_PHY_1405_DATA 0x00000000
+#define DDRSS_PHY_1406_DATA 0x00000000
+#define DDRSS_PHY_1407_DATA 0x00000000
+#define DDRSS_PHY_1408_DATA 0x00000000
+#define DDRSS_PHY_1409_DATA 0x00000000
+#define DDRSS_PHY_1410_DATA 0x00000000
+#define DDRSS_PHY_1411_DATA 0x00000000
+#define DDRSS_PHY_1412_DATA 0x00000000
+#define DDRSS_PHY_1413_DATA 0x00000000
+#define DDRSS_PHY_1414_DATA 0x00000000
+#define DDRSS_PHY_1415_DATA 0x00000000
+#define DDRSS_PHY_1416_DATA 0x00000000
+#define DDRSS_PHY_1417_DATA 0x00000000
+#define DDRSS_PHY_1418_DATA 0x00000000
+#define DDRSS_PHY_1419_DATA 0x00000000
+#define DDRSS_PHY_1420_DATA 0x00000000
+#define DDRSS_PHY_1421_DATA 0x00000000
+#define DDRSS_PHY_1422_DATA 0x00000000
+#define DDRSS_PHY_1423_DATA 0x00000000
+#define DDRSS_PHY_1424_DATA 0x00000000
+#define DDRSS_PHY_1425_DATA 0x00000000
+#define DDRSS_PHY_1426_DATA 0x00000000
+#define DDRSS_PHY_1427_DATA 0x00000000
+#define DDRSS_PHY_1428_DATA 0x00000000
+#define DDRSS_PHY_1429_DATA 0x00000000
+#define DDRSS_PHY_1430_DATA 0x00000000
+#define DDRSS_PHY_1431_DATA 0x00000000
+#define DDRSS_PHY_1432_DATA 0x00000000
+#define DDRSS_PHY_1433_DATA 0x00000000
+#define DDRSS_PHY_1434_DATA 0x00000000
+#define DDRSS_PHY_1435_DATA 0x00000000
+#define DDRSS_PHY_1436_DATA 0x00000000
+#define DDRSS_PHY_1437_DATA 0x00000000
+#define DDRSS_PHY_1438_DATA 0x00000000
+#define DDRSS_PHY_1439_DATA 0x00000000
+#define DDRSS_PHY_1440_DATA 0x00000000
+#define DDRSS_PHY_1441_DATA 0x00000000
+#define DDRSS_PHY_1442_DATA 0x00000000
+#define DDRSS_PHY_1443_DATA 0x00000000
+#define DDRSS_PHY_1444_DATA 0x00000000
+#define DDRSS_PHY_1445_DATA 0x00000000
+#define DDRSS_PHY_1446_DATA 0x00000000
+#define DDRSS_PHY_1447_DATA 0x00000000
+#define DDRSS_PHY_1448_DATA 0x00000000
+#define DDRSS_PHY_1449_DATA 0x00000000
+#define DDRSS_PHY_1450_DATA 0x00000000
+#define DDRSS_PHY_1451_DATA 0x00000000
+#define DDRSS_PHY_1452_DATA 0x00000000
+#define DDRSS_PHY_1453_DATA 0x00000000
+#define DDRSS_PHY_1454_DATA 0x00000000
+#define DDRSS_PHY_1455_DATA 0x00000000
+#define DDRSS_PHY_1456_DATA 0x00000000
+#define DDRSS_PHY_1457_DATA 0x00000000
+#define DDRSS_PHY_1458_DATA 0x00000000
+#define DDRSS_PHY_1459_DATA 0x00000000
+#define DDRSS_PHY_1460_DATA 0x00000000
+#define DDRSS_PHY_1461_DATA 0x00000000
+#define DDRSS_PHY_1462_DATA 0x00000000
+#define DDRSS_PHY_1463_DATA 0x00000000
+#define DDRSS_PHY_1464_DATA 0x00000000
+#define DDRSS_PHY_1465_DATA 0x00000000
+#define DDRSS_PHY_1466_DATA 0x00000000
+#define DDRSS_PHY_1467_DATA 0x00000000
+#define DDRSS_PHY_1468_DATA 0x00000000
+#define DDRSS_PHY_1469_DATA 0x00000000
+#define DDRSS_PHY_1470_DATA 0x00000000
+#define DDRSS_PHY_1471_DATA 0x00000000
+#define DDRSS_PHY_1472_DATA 0x00000000
+#define DDRSS_PHY_1473_DATA 0x00000000
+#define DDRSS_PHY_1474_DATA 0x00000000
+#define DDRSS_PHY_1475_DATA 0x00000000
+#define DDRSS_PHY_1476_DATA 0x00000000
+#define DDRSS_PHY_1477_DATA 0x00000000
+#define DDRSS_PHY_1478_DATA 0x00000000
+#define DDRSS_PHY_1479_DATA 0x00000000
+#define DDRSS_PHY_1480_DATA 0x00000000
+#define DDRSS_PHY_1481_DATA 0x00000000
+#define DDRSS_PHY_1482_DATA 0x00000000
+#define DDRSS_PHY_1483_DATA 0x00000000
+#define DDRSS_PHY_1484_DATA 0x00000000
+#define DDRSS_PHY_1485_DATA 0x00000000
+#define DDRSS_PHY_1486_DATA 0x00000000
+#define DDRSS_PHY_1487_DATA 0x00000000
+#define DDRSS_PHY_1488_DATA 0x00000000
+#define DDRSS_PHY_1489_DATA 0x00000000
+#define DDRSS_PHY_1490_DATA 0x00000000
+#define DDRSS_PHY_1491_DATA 0x00000000
+#define DDRSS_PHY_1492_DATA 0x00000000
+#define DDRSS_PHY_1493_DATA 0x00000000
+#define DDRSS_PHY_1494_DATA 0x00000000
+#define DDRSS_PHY_1495_DATA 0x00000000
+#define DDRSS_PHY_1496_DATA 0x00000000
+#define DDRSS_PHY_1497_DATA 0x00000000
+#define DDRSS_PHY_1498_DATA 0x00000000
+#define DDRSS_PHY_1499_DATA 0x00000000
+#define DDRSS_PHY_1500_DATA 0x00000000
+#define DDRSS_PHY_1501_DATA 0x00000000
+#define DDRSS_PHY_1502_DATA 0x00000000
+#define DDRSS_PHY_1503_DATA 0x00000000
+#define DDRSS_PHY_1504_DATA 0x00000000
+#define DDRSS_PHY_1505_DATA 0x00000000
+#define DDRSS_PHY_1506_DATA 0x00000000
+#define DDRSS_PHY_1507_DATA 0x00000000
+#define DDRSS_PHY_1508_DATA 0x00000000
+#define DDRSS_PHY_1509_DATA 0x00000000
+#define DDRSS_PHY_1510_DATA 0x00000000
+#define DDRSS_PHY_1511_DATA 0x00000000
+#define DDRSS_PHY_1512_DATA 0x00000000
+#define DDRSS_PHY_1513_DATA 0x00000000
+#define DDRSS_PHY_1514_DATA 0x00000000
+#define DDRSS_PHY_1515_DATA 0x00000000
+#define DDRSS_PHY_1516_DATA 0x00000000
+#define DDRSS_PHY_1517_DATA 0x00000000
+#define DDRSS_PHY_1518_DATA 0x00000000
+#define DDRSS_PHY_1519_DATA 0x00000000
+#define DDRSS_PHY_1520_DATA 0x00000000
+#define DDRSS_PHY_1521_DATA 0x00000000
+#define DDRSS_PHY_1522_DATA 0x00000000
+#define DDRSS_PHY_1523_DATA 0x00000000
+#define DDRSS_PHY_1524_DATA 0x00000000
+#define DDRSS_PHY_1525_DATA 0x00000000
+#define DDRSS_PHY_1526_DATA 0x00000000
+#define DDRSS_PHY_1527_DATA 0x00000000
+#define DDRSS_PHY_1528_DATA 0x00000000
+#define DDRSS_PHY_1529_DATA 0x00000000
+#define DDRSS_PHY_1530_DATA 0x00000000
+#define DDRSS_PHY_1531_DATA 0x00000000
+#define DDRSS_PHY_1532_DATA 0x00000000
+#define DDRSS_PHY_1533_DATA 0x00000000
+#define DDRSS_PHY_1534_DATA 0x00000000
+#define DDRSS_PHY_1535_DATA 0x00000000
+#define DDRSS_PHY_1536_DATA 0x00000000
+#define DDRSS_PHY_1537_DATA 0x00000000
+#define DDRSS_PHY_1538_DATA 0x00000000
+#define DDRSS_PHY_1539_DATA 0x00000000
+#define DDRSS_PHY_1540_DATA 0x00000000
+#define DDRSS_PHY_1541_DATA 0x00000100
+#define DDRSS_PHY_1542_DATA 0x00000200
+#define DDRSS_PHY_1543_DATA 0x00000000
+#define DDRSS_PHY_1544_DATA 0x00000000
+#define DDRSS_PHY_1545_DATA 0x00000000
+#define DDRSS_PHY_1546_DATA 0x00000000
+#define DDRSS_PHY_1547_DATA 0x00400000
+#define DDRSS_PHY_1548_DATA 0x00000080
+#define DDRSS_PHY_1549_DATA 0x00DCBA98
+#define DDRSS_PHY_1550_DATA 0x03000000
+#define DDRSS_PHY_1551_DATA 0x00200000
+#define DDRSS_PHY_1552_DATA 0x00000000
+#define DDRSS_PHY_1553_DATA 0x00000000
+#define DDRSS_PHY_1554_DATA 0x00000000
+#define DDRSS_PHY_1555_DATA 0x00000000
+#define DDRSS_PHY_1556_DATA 0x00000000
+#define DDRSS_PHY_1557_DATA 0x0000002A
+#define DDRSS_PHY_1558_DATA 0x00000015
+#define DDRSS_PHY_1559_DATA 0x00000015
+#define DDRSS_PHY_1560_DATA 0x0000002A
+#define DDRSS_PHY_1561_DATA 0x00000033
+#define DDRSS_PHY_1562_DATA 0x0000000C
+#define DDRSS_PHY_1563_DATA 0x0000000C
+#define DDRSS_PHY_1564_DATA 0x00000033
+#define DDRSS_PHY_1565_DATA 0x0A418820
+#define DDRSS_PHY_1566_DATA 0x10000000
+#define DDRSS_PHY_1567_DATA 0x000F0000
+#define DDRSS_PHY_1568_DATA 0x20202003
+#define DDRSS_PHY_1569_DATA 0x00202020
+#define DDRSS_PHY_1570_DATA 0x20008008
+#define DDRSS_PHY_1571_DATA 0x00000810
+#define DDRSS_PHY_1572_DATA 0x00000F00
+#define DDRSS_PHY_1573_DATA 0x000405CC
+#define DDRSS_PHY_1574_DATA 0x03000004
+#define DDRSS_PHY_1575_DATA 0x00030000
+#define DDRSS_PHY_1576_DATA 0x00000300
+#define DDRSS_PHY_1577_DATA 0x00000300
+#define DDRSS_PHY_1578_DATA 0x00000300
+#define DDRSS_PHY_1579_DATA 0x00000300
+#define DDRSS_PHY_1580_DATA 0x42080010
+#define DDRSS_PHY_1581_DATA 0x0000803E
+#define DDRSS_PHY_1582_DATA 0x00000001
+#define DDRSS_PHY_1583_DATA 0x01000002
+#define DDRSS_PHY_1584_DATA 0x00008000
+#define DDRSS_PHY_1585_DATA 0x00000000
+#define DDRSS_PHY_1586_DATA 0x00000000
+#define DDRSS_PHY_1587_DATA 0x00000000
+#define DDRSS_PHY_1588_DATA 0x00000000
+#define DDRSS_PHY_1589_DATA 0x00000000
+#define DDRSS_PHY_1590_DATA 0x00000000
+#define DDRSS_PHY_1591_DATA 0x00000000
+#define DDRSS_PHY_1592_DATA 0x00000000
+#define DDRSS_PHY_1593_DATA 0x00000000
+#define DDRSS_PHY_1594_DATA 0x00000000
+#define DDRSS_PHY_1595_DATA 0x00000000
+#define DDRSS_PHY_1596_DATA 0x00000000
+#define DDRSS_PHY_1597_DATA 0x00000000
+#define DDRSS_PHY_1598_DATA 0x00000000
+#define DDRSS_PHY_1599_DATA 0x00000000
+#define DDRSS_PHY_1600_DATA 0x00000000
+#define DDRSS_PHY_1601_DATA 0x00000000
+#define DDRSS_PHY_1602_DATA 0x00000000
+#define DDRSS_PHY_1603_DATA 0x00000000
+#define DDRSS_PHY_1604_DATA 0x00000000
+#define DDRSS_PHY_1605_DATA 0x00000000
+#define DDRSS_PHY_1606_DATA 0x00000000
+#define DDRSS_PHY_1607_DATA 0x00000000
+#define DDRSS_PHY_1608_DATA 0x00000000
+#define DDRSS_PHY_1609_DATA 0x00000000
+#define DDRSS_PHY_1610_DATA 0x00000000
+#define DDRSS_PHY_1611_DATA 0x00000000
+#define DDRSS_PHY_1612_DATA 0x00000000
+#define DDRSS_PHY_1613_DATA 0x00000000
+#define DDRSS_PHY_1614_DATA 0x00000000
+#define DDRSS_PHY_1615_DATA 0x00000000
+#define DDRSS_PHY_1616_DATA 0x00000000
+#define DDRSS_PHY_1617_DATA 0x00000000
+#define DDRSS_PHY_1618_DATA 0x00000000
+#define DDRSS_PHY_1619_DATA 0x00000000
+#define DDRSS_PHY_1620_DATA 0x00000000
+#define DDRSS_PHY_1621_DATA 0x00000000
+#define DDRSS_PHY_1622_DATA 0x00000000
+#define DDRSS_PHY_1623_DATA 0x00000000
+#define DDRSS_PHY_1624_DATA 0x00000000
+#define DDRSS_PHY_1625_DATA 0x00000000
+#define DDRSS_PHY_1626_DATA 0x00000000
+#define DDRSS_PHY_1627_DATA 0x00000000
+#define DDRSS_PHY_1628_DATA 0x00000000
+#define DDRSS_PHY_1629_DATA 0x00000000
+#define DDRSS_PHY_1630_DATA 0x00000000
+#define DDRSS_PHY_1631_DATA 0x00000000
+#define DDRSS_PHY_1632_DATA 0x00000000
+#define DDRSS_PHY_1633_DATA 0x00000000
+#define DDRSS_PHY_1634_DATA 0x00000000
+#define DDRSS_PHY_1635_DATA 0x00000000
+#define DDRSS_PHY_1636_DATA 0x00000000
+#define DDRSS_PHY_1637_DATA 0x00000000
+#define DDRSS_PHY_1638_DATA 0x00000000
+#define DDRSS_PHY_1639_DATA 0x00000000
+#define DDRSS_PHY_1640_DATA 0x00000000
+#define DDRSS_PHY_1641_DATA 0x00000000
+#define DDRSS_PHY_1642_DATA 0x00000000
+#define DDRSS_PHY_1643_DATA 0x00000000
+#define DDRSS_PHY_1644_DATA 0x00000000
+#define DDRSS_PHY_1645_DATA 0x00000000
+#define DDRSS_PHY_1646_DATA 0x00000000
+#define DDRSS_PHY_1647_DATA 0x00000000
+#define DDRSS_PHY_1648_DATA 0x00000000
+#define DDRSS_PHY_1649_DATA 0x00000000
+#define DDRSS_PHY_1650_DATA 0x00000000
+#define DDRSS_PHY_1651_DATA 0x00000000
+#define DDRSS_PHY_1652_DATA 0x00000000
+#define DDRSS_PHY_1653_DATA 0x00000000
+#define DDRSS_PHY_1654_DATA 0x00000000
+#define DDRSS_PHY_1655_DATA 0x00000000
+#define DDRSS_PHY_1656_DATA 0x00000000
+#define DDRSS_PHY_1657_DATA 0x00000000
+#define DDRSS_PHY_1658_DATA 0x00000000
+#define DDRSS_PHY_1659_DATA 0x00000000
+#define DDRSS_PHY_1660_DATA 0x00000000
+#define DDRSS_PHY_1661_DATA 0x00000000
+#define DDRSS_PHY_1662_DATA 0x00000000
+#define DDRSS_PHY_1663_DATA 0x00000000
+#define DDRSS_PHY_1664_DATA 0x00000000
+#define DDRSS_PHY_1665_DATA 0x00000000
+#define DDRSS_PHY_1666_DATA 0x00000000
+#define DDRSS_PHY_1667_DATA 0x00000000
+#define DDRSS_PHY_1668_DATA 0x00000000
+#define DDRSS_PHY_1669_DATA 0x00000000
+#define DDRSS_PHY_1670_DATA 0x00000000
+#define DDRSS_PHY_1671_DATA 0x00000000
+#define DDRSS_PHY_1672_DATA 0x00000000
+#define DDRSS_PHY_1673_DATA 0x00000000
+#define DDRSS_PHY_1674_DATA 0x00000000
+#define DDRSS_PHY_1675_DATA 0x00000000
+#define DDRSS_PHY_1676_DATA 0x00000000
+#define DDRSS_PHY_1677_DATA 0x00000000
+#define DDRSS_PHY_1678_DATA 0x00000000
+#define DDRSS_PHY_1679_DATA 0x00000000
+#define DDRSS_PHY_1680_DATA 0x00000000
+#define DDRSS_PHY_1681_DATA 0x00000000
+#define DDRSS_PHY_1682_DATA 0x00000000
+#define DDRSS_PHY_1683_DATA 0x00000000
+#define DDRSS_PHY_1684_DATA 0x00000000
+#define DDRSS_PHY_1685_DATA 0x00000000
+#define DDRSS_PHY_1686_DATA 0x00000000
+#define DDRSS_PHY_1687_DATA 0x00000000
+#define DDRSS_PHY_1688_DATA 0x00000000
+#define DDRSS_PHY_1689_DATA 0x00000000
+#define DDRSS_PHY_1690_DATA 0x00000000
+#define DDRSS_PHY_1691_DATA 0x00000000
+#define DDRSS_PHY_1692_DATA 0x00000000
+#define DDRSS_PHY_1693_DATA 0x00000000
+#define DDRSS_PHY_1694_DATA 0x00000000
+#define DDRSS_PHY_1695_DATA 0x00000000
+#define DDRSS_PHY_1696_DATA 0x00000000
+#define DDRSS_PHY_1697_DATA 0x00000000
+#define DDRSS_PHY_1698_DATA 0x00000000
+#define DDRSS_PHY_1699_DATA 0x00000000
+#define DDRSS_PHY_1700_DATA 0x00000000
+#define DDRSS_PHY_1701_DATA 0x00000000
+#define DDRSS_PHY_1702_DATA 0x00000000
+#define DDRSS_PHY_1703_DATA 0x00000000
+#define DDRSS_PHY_1704_DATA 0x00000000
+#define DDRSS_PHY_1705_DATA 0x00000000
+#define DDRSS_PHY_1706_DATA 0x00000000
+#define DDRSS_PHY_1707_DATA 0x00000000
+#define DDRSS_PHY_1708_DATA 0x00000000
+#define DDRSS_PHY_1709_DATA 0x00000000
+#define DDRSS_PHY_1710_DATA 0x00000000
+#define DDRSS_PHY_1711_DATA 0x00000000
+#define DDRSS_PHY_1712_DATA 0x00000000
+#define DDRSS_PHY_1713_DATA 0x00000000
+#define DDRSS_PHY_1714_DATA 0x00000000
+#define DDRSS_PHY_1715_DATA 0x00000000
+#define DDRSS_PHY_1716_DATA 0x00000000
+#define DDRSS_PHY_1717_DATA 0x00000000
+#define DDRSS_PHY_1718_DATA 0x00000000
+#define DDRSS_PHY_1719_DATA 0x00000000
+#define DDRSS_PHY_1720_DATA 0x00000000
+#define DDRSS_PHY_1721_DATA 0x00000000
+#define DDRSS_PHY_1722_DATA 0x00000000
+#define DDRSS_PHY_1723_DATA 0x00000000
+#define DDRSS_PHY_1724_DATA 0x00000000
+#define DDRSS_PHY_1725_DATA 0x00000000
+#define DDRSS_PHY_1726_DATA 0x00000000
+#define DDRSS_PHY_1727_DATA 0x00000000
+#define DDRSS_PHY_1728_DATA 0x00000000
+#define DDRSS_PHY_1729_DATA 0x00000000
+#define DDRSS_PHY_1730_DATA 0x00000000
+#define DDRSS_PHY_1731_DATA 0x00000000
+#define DDRSS_PHY_1732_DATA 0x00000000
+#define DDRSS_PHY_1733_DATA 0x00000000
+#define DDRSS_PHY_1734_DATA 0x00000000
+#define DDRSS_PHY_1735_DATA 0x00000000
+#define DDRSS_PHY_1736_DATA 0x00000000
+#define DDRSS_PHY_1737_DATA 0x00000000
+#define DDRSS_PHY_1738_DATA 0x00000000
+#define DDRSS_PHY_1739_DATA 0x00000000
+#define DDRSS_PHY_1740_DATA 0x00000000
+#define DDRSS_PHY_1741_DATA 0x00000000
+#define DDRSS_PHY_1742_DATA 0x00000000
+#define DDRSS_PHY_1743_DATA 0x00000000
+#define DDRSS_PHY_1744_DATA 0x00000000
+#define DDRSS_PHY_1745_DATA 0x00000000
+#define DDRSS_PHY_1746_DATA 0x00000000
+#define DDRSS_PHY_1747_DATA 0x00000000
+#define DDRSS_PHY_1748_DATA 0x00000000
+#define DDRSS_PHY_1749_DATA 0x00000000
+#define DDRSS_PHY_1750_DATA 0x00000000
+#define DDRSS_PHY_1751_DATA 0x00000000
+#define DDRSS_PHY_1752_DATA 0x00000000
+#define DDRSS_PHY_1753_DATA 0x00000000
+#define DDRSS_PHY_1754_DATA 0x00000000
+#define DDRSS_PHY_1755_DATA 0x00000000
+#define DDRSS_PHY_1756_DATA 0x00000000
+#define DDRSS_PHY_1757_DATA 0x00000000
+#define DDRSS_PHY_1758_DATA 0x00000000
+#define DDRSS_PHY_1759_DATA 0x00000000
+#define DDRSS_PHY_1760_DATA 0x00000000
+#define DDRSS_PHY_1761_DATA 0x00000000
+#define DDRSS_PHY_1762_DATA 0x00000000
+#define DDRSS_PHY_1763_DATA 0x00000000
+#define DDRSS_PHY_1764_DATA 0x00000000
+#define DDRSS_PHY_1765_DATA 0x00000000
+#define DDRSS_PHY_1766_DATA 0x00000000
+#define DDRSS_PHY_1767_DATA 0x00000000
+#define DDRSS_PHY_1768_DATA 0x00000000
+#define DDRSS_PHY_1769_DATA 0x00000000
+#define DDRSS_PHY_1770_DATA 0x00000000
+#define DDRSS_PHY_1771_DATA 0x00000000
+#define DDRSS_PHY_1772_DATA 0x00000000
+#define DDRSS_PHY_1773_DATA 0x00000000
+#define DDRSS_PHY_1774_DATA 0x00000000
+#define DDRSS_PHY_1775_DATA 0x00000000
+#define DDRSS_PHY_1776_DATA 0x00000000
+#define DDRSS_PHY_1777_DATA 0x00000000
+#define DDRSS_PHY_1778_DATA 0x00000000
+#define DDRSS_PHY_1779_DATA 0x00000000
+#define DDRSS_PHY_1780_DATA 0x00000000
+#define DDRSS_PHY_1781_DATA 0x00000000
+#define DDRSS_PHY_1782_DATA 0x00000000
+#define DDRSS_PHY_1783_DATA 0x00000000
+#define DDRSS_PHY_1784_DATA 0x00000000
+#define DDRSS_PHY_1785_DATA 0x00000000
+#define DDRSS_PHY_1786_DATA 0x00000000
+#define DDRSS_PHY_1787_DATA 0x00000000
+#define DDRSS_PHY_1788_DATA 0x00000000
+#define DDRSS_PHY_1789_DATA 0x00000000
+#define DDRSS_PHY_1790_DATA 0x00000000
+#define DDRSS_PHY_1791_DATA 0x00000000
+#define DDRSS_PHY_1792_DATA 0x00000000
+#define DDRSS_PHY_1793_DATA 0x00010100
+#define DDRSS_PHY_1794_DATA 0x00000000
+#define DDRSS_PHY_1795_DATA 0x00000000
+#define DDRSS_PHY_1796_DATA 0x00000000
+#define DDRSS_PHY_1797_DATA 0x00000000
+#define DDRSS_PHY_1798_DATA 0x00050000
+#define DDRSS_PHY_1799_DATA 0x04000000
+#define DDRSS_PHY_1800_DATA 0x00000055
+#define DDRSS_PHY_1801_DATA 0x00000000
+#define DDRSS_PHY_1802_DATA 0x00000000
+#define DDRSS_PHY_1803_DATA 0x00000000
+#define DDRSS_PHY_1804_DATA 0x00000000
+#define DDRSS_PHY_1805_DATA 0x00002001
+#define DDRSS_PHY_1806_DATA 0x00004003
+#define DDRSS_PHY_1807_DATA 0x50020028
+#define DDRSS_PHY_1808_DATA 0x01010000
+#define DDRSS_PHY_1809_DATA 0x80080001
+#define DDRSS_PHY_1810_DATA 0x10200000
+#define DDRSS_PHY_1811_DATA 0x00000008
+#define DDRSS_PHY_1812_DATA 0x00000000
+#define DDRSS_PHY_1813_DATA 0x06000000
+#define DDRSS_PHY_1814_DATA 0x010F0F0E
+#define DDRSS_PHY_1815_DATA 0x00040101
+#define DDRSS_PHY_1816_DATA 0x0000010F
+#define DDRSS_PHY_1817_DATA 0x00000000
+#define DDRSS_PHY_1818_DATA 0x00000064
+#define DDRSS_PHY_1819_DATA 0x00000000
+#define DDRSS_PHY_1820_DATA 0x00000000
+#define DDRSS_PHY_1821_DATA 0x0F0F0F01
+#define DDRSS_PHY_1822_DATA 0x0F0F0F02
+#define DDRSS_PHY_1823_DATA 0x0F0F0F0F
+#define DDRSS_PHY_1824_DATA 0x0F0F0804
+#define DDRSS_PHY_1825_DATA 0x00800120
+#define DDRSS_PHY_1826_DATA 0x00041B42
+#define DDRSS_PHY_1827_DATA 0x00004201
+#define DDRSS_PHY_1828_DATA 0x00000000
+#define DDRSS_PHY_1829_DATA 0x00000000
+#define DDRSS_PHY_1830_DATA 0x00000000
+#define DDRSS_PHY_1831_DATA 0x00000000
+#define DDRSS_PHY_1832_DATA 0x00000000
+#define DDRSS_PHY_1833_DATA 0x00000000
+#define DDRSS_PHY_1834_DATA 0x03010100
+#define DDRSS_PHY_1835_DATA 0x00540007
+#define DDRSS_PHY_1836_DATA 0x000040A2
+#define DDRSS_PHY_1837_DATA 0x00024410
+#define DDRSS_PHY_1838_DATA 0x00004410
+#define DDRSS_PHY_1839_DATA 0x00004410
+#define DDRSS_PHY_1840_DATA 0x00004410
+#define DDRSS_PHY_1841_DATA 0x00004410
+#define DDRSS_PHY_1842_DATA 0x00004410
+#define DDRSS_PHY_1843_DATA 0x00004410
+#define DDRSS_PHY_1844_DATA 0x00004410
+#define DDRSS_PHY_1845_DATA 0x00004410
+#define DDRSS_PHY_1846_DATA 0x00004410
+#define DDRSS_PHY_1847_DATA 0x00000000
+#define DDRSS_PHY_1848_DATA 0x00000076
+#define DDRSS_PHY_1849_DATA 0x00000400
+#define DDRSS_PHY_1850_DATA 0x00000008
+#define DDRSS_PHY_1851_DATA 0x00000000
+#define DDRSS_PHY_1852_DATA 0x00000000
+#define DDRSS_PHY_1853_DATA 0x00000000
+#define DDRSS_PHY_1854_DATA 0x00000000
+#define DDRSS_PHY_1855_DATA 0x00000000
+#define DDRSS_PHY_1856_DATA 0x03000000
+#define DDRSS_PHY_1857_DATA 0x00000000
+#define DDRSS_PHY_1858_DATA 0x00000000
+#define DDRSS_PHY_1859_DATA 0x00000000
+#define DDRSS_PHY_1860_DATA 0x04102006
+#define DDRSS_PHY_1861_DATA 0x00041020
+#define DDRSS_PHY_1862_DATA 0x01C98C98
+#define DDRSS_PHY_1863_DATA 0x3F400000
+#define DDRSS_PHY_1864_DATA 0x3F3F1F3F
+#define DDRSS_PHY_1865_DATA 0x0000001F
+#define DDRSS_PHY_1866_DATA 0x00000000
+#define DDRSS_PHY_1867_DATA 0x00000000
+#define DDRSS_PHY_1868_DATA 0x00000000
+#define DDRSS_PHY_1869_DATA 0x00000001
+#define DDRSS_PHY_1870_DATA 0x00000000
+#define DDRSS_PHY_1871_DATA 0x00000000
+#define DDRSS_PHY_1872_DATA 0x00000000
+#define DDRSS_PHY_1873_DATA 0x00000000
+#define DDRSS_PHY_1874_DATA 0x76543210
+#define DDRSS_PHY_1875_DATA 0x06010198
+#define DDRSS_PHY_1876_DATA 0x00000000
+#define DDRSS_PHY_1877_DATA 0x00000000
+#define DDRSS_PHY_1878_DATA 0x00000000
+#define DDRSS_PHY_1879_DATA 0x00040700
+#define DDRSS_PHY_1880_DATA 0x00000000
+#define DDRSS_PHY_1881_DATA 0x00000000
+#define DDRSS_PHY_1882_DATA 0x00000000
+#define DDRSS_PHY_1883_DATA 0x00000000
+#define DDRSS_PHY_1884_DATA 0x00000000
+#define DDRSS_PHY_1885_DATA 0x00000002
+#define DDRSS_PHY_1886_DATA 0x00000000
+#define DDRSS_PHY_1887_DATA 0x00000000
+#define DDRSS_PHY_1888_DATA 0x0001F7C4
+#define DDRSS_PHY_1889_DATA 0x04000004
+#define DDRSS_PHY_1890_DATA 0x00000000
+#define DDRSS_PHY_1891_DATA 0x00001142
+#define DDRSS_PHY_1892_DATA 0x01020000
+#define DDRSS_PHY_1893_DATA 0x00000080
+#define DDRSS_PHY_1894_DATA 0x03900390
+#define DDRSS_PHY_1895_DATA 0x03900390
+#define DDRSS_PHY_1896_DATA 0x03900390
+#define DDRSS_PHY_1897_DATA 0x03900390
+#define DDRSS_PHY_1898_DATA 0x03000300
+#define DDRSS_PHY_1899_DATA 0x03000300
+#define DDRSS_PHY_1900_DATA 0x00000300
+#define DDRSS_PHY_1901_DATA 0x00000300
+#define DDRSS_PHY_1902_DATA 0x00000300
+#define DDRSS_PHY_1903_DATA 0x00000300
+#define DDRSS_PHY_1904_DATA 0x00000005
+#define DDRSS_PHY_1905_DATA 0x3183BF77
+#define DDRSS_PHY_1906_DATA 0x00000000
+#define DDRSS_PHY_1907_DATA 0x0C000DFF
+#define DDRSS_PHY_1908_DATA 0x30000DFF
+#define DDRSS_PHY_1909_DATA 0x3F0DFF11
+#define DDRSS_PHY_1910_DATA 0x00EF0000
+#define DDRSS_PHY_1911_DATA 0x780DFFCC
+#define DDRSS_PHY_1912_DATA 0x00000C11
+#define DDRSS_PHY_1913_DATA 0x00018011
+#define DDRSS_PHY_1914_DATA 0x0089FF00
+#define DDRSS_PHY_1915_DATA 0x000C3F11
+#define DDRSS_PHY_1916_DATA 0x01990000
+#define DDRSS_PHY_1917_DATA 0x000C3F11
+#define DDRSS_PHY_1918_DATA 0x01990000
+#define DDRSS_PHY_1919_DATA 0x3F0DFF11
+#define DDRSS_PHY_1920_DATA 0x00EF0000
+#define DDRSS_PHY_1921_DATA 0x00018011
+#define DDRSS_PHY_1922_DATA 0x0089FF00
+#define DDRSS_PHY_1923_DATA 0x20040006
diff --git a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
new file mode 100644
index 00000000000..41692c8f670
--- /dev/null
+++ b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * phyCORE-AM62Ax dts file for SPLs
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phycore-am62ax
+ */
+
+#include "k3-am62a-phycore-som-binman.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial2:115200n8";
+		tick-timer = &main_timer0;
+	};
+
+	aliases {
+		mmc0 = &sdhci0;
+		mmc1 = &sdhci1;
+	};
+
+	memory@80000000 {
+		bootph-all;
+	};
+};
+
+&cbass_main {
+	bootph-all;
+};
+
+&cbass_mcu {
+	bootph-all;
+};
+
+&cbass_wakeup {
+	bootph-all;
+};
+
+&chipid {
+	bootph-all;
+};
+
+&cpsw3g {
+	bootph-all;
+	ethernet-ports {
+		bootph-all;
+	};
+};
+
+&cpsw3g_mdio {
+	bootph-all;
+};
+
+&cpsw3g_phy1 {
+	bootph-all;
+};
+
+&cpsw3g_phy3 {
+	bootph-all;
+};
+
+&cpsw_port1 {
+	bootph-all;
+};
+
+&cpsw_port2 {
+	bootph-all;
+};
+
+&dmsc {
+	bootph-all;
+};
+
+&dmss {
+	bootph-all;
+};
+
+&fss {
+	bootph-all;
+};
+
+&k3_pds {
+	bootph-all;
+};
+
+&k3_clks {
+	bootph-all;
+};
+
+&k3_reset {
+	bootph-all;
+};
+
+&main_bcdma {
+	bootph-all;
+	reg = <0x00 0x485c0100 0x00 0x100>,
+	      <0x00 0x4c000000 0x00 0x20000>,
+	      <0x00 0x4a820000 0x00 0x20000>,
+	      <0x00 0x4aa40000 0x00 0x20000>,
+	      <0x00 0x4bc00000 0x00 0x100000>,
+	      <0x00 0x48600000 0x00 0x8000>,
+	      <0x00 0x484a4000 0x00 0x2000>,
+	      <0x00 0x484c2000 0x00 0x2000>;
+	reg-names = "gcfg", "bchanrt", "rchanrt", "tchanrt",
+		    "ringrt", "cfg", "tchan", "rchan";
+};
+
+&main_conf {
+	bootph-all;
+};
+
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_i2c0 {
+	bootph-all;
+};
+
+&main_i2c0_pins_default {
+	bootph-all;
+};
+
+&main_mdio1_pins_default {
+	bootph-all;
+};
+
+&main_mmc0_pins_default {
+	bootph-all;
+};
+
+&main_mmc1_pins_default {
+	bootph-all;
+};
+
+&main_pktdma {
+	bootph-all;
+	reg = <0x00 0x485c0000 0x00 0x100>,
+	      <0x00 0x4a800000 0x00 0x20000>,
+	      <0x00 0x4aa00000 0x00 0x40000>,
+	      <0x00 0x4b800000 0x00 0x400000>,
+	      <0x00 0x485e0000 0x00 0x20000>,
+	      <0x00 0x484a0000 0x00 0x4000>,
+	      <0x00 0x484c0000 0x00 0x2000>,
+	      <0x00 0x48430000 0x00 0x4000>;
+	reg-names = "gcfg", "rchanrt", "tchanrt", "ringrt",
+		    "cfg", "tchan", "rchan", "rflow";
+};
+
+&main_pmx0 {
+	bootph-all;
+};
+
+&main_rgmii1_pins_default {
+	bootph-all;
+};
+
+&main_timer0 {
+	bootph-all;
+};
+
+&main_uart0 {
+	bootph-all;
+};
+
+&main_uart0_pins_default {
+	bootph-all;
+};
+
+&main_uart1 {
+	bootph-all;
+};
+
+&mcu_pmx0 {
+	bootph-all;
+};
+
+&ospi0_pins_default {
+	bootph-all;
+};
+
+&ospi0 {
+	bootph-all;
+	flash@0 {
+		bootph-all;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ospi.tiboot3";
+				reg = <0x00000 0x80000>;
+			};
+			partition@80000 {
+				label = "ospi.tispl";
+				reg = <0x080000 0x200000>;
+			};
+			partition@280000 {
+				label = "ospi.u-boot";
+				reg = <0x280000 0x400000>;
+			};
+			partition@680000 {
+				label = "ospi.env";
+				reg = <0x680000 0x40000>;
+			};
+			partition@6c0000 {
+				label = "ospi.env.backup";
+				reg = <0x6c0000 0x40000>;
+			};
+		};
+	};
+};
+
+&phy_gmii_sel {
+	bootph-all;
+};
+
+&sdhci0 {
+	bootph-all;
+};
+
+&sdhci1 {
+	bootph-all;
+};
+
+&secure_proxy_main {
+	bootph-all;
+};
+
+&usbss0 {
+	bootph-all;
+};
+
+&usb0 {
+	dr_mode = "peripheral";
+	bootph-all;
+};
+
+&vcc_3v3_mmc {
+	bootph-all;
+};
+
+&wkup_conf {
+	bootph-all;
+};
+
+&wkup_uart0 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
new file mode 100644
index 00000000000..0060c7a6934
--- /dev/null
+++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * phyCORE-AM62Ax dts file for R5 SPL
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ *
+ * Product homepage:
+ * https://www.phytec.com/product/phycore-am62ax
+ */
+
+#include "k3-am62a7-phyboard-lyra-rdk.dts"
+#include "k3-am62a-phycore-som-ddr4-2gb.dtsi"
+#include "k3-am62a-ddr.dtsi"
+
+#include "k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi"
+
+/ {
+	aliases {
+		remoteproc0 = &sysctrler;
+		remoteproc1 = &a53_0;
+		serial0 = &wkup_uart0;
+		serial3 = &main_uart1;
+	};
+
+	a53_0: a53@0 {
+		compatible = "ti,am654-rproc";
+		reg = <0x00 0x00a90000 0x00 0x10>;
+		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
+				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
+		resets = <&k3_reset 135 0>;
+		clocks = <&k3_clks 61 0>;
+		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
+		assigned-clock-parents = <&k3_clks 61 2>;
+		assigned-clock-rates = <200000000>, <1200000000>;
+		ti,sci = <&dmsc>;
+		ti,sci-proc-id = <32>;
+		ti,sci-host-id = <10>;
+		bootph-pre-ram;
+	};
+
+	dm_tifs: dm-tifs {
+		compatible = "ti,j721e-dm-sci";
+		ti,host-id = <36>;
+		ti,secure-host;
+		mbox-names = "rx", "tx";
+		mboxes= <&secure_proxy_main 22>,
+			<&secure_proxy_main 23>;
+		bootph-pre-ram;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		/* 2G RAM */
+		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
+		bootph-pre-ram;
+	};
+};
+
+&cbass_main {
+	bootph-pre-ram;
+	sa3_secproxy: secproxy@44880000 {
+		compatible = "ti,am654-secure-proxy";
+		#mbox-cells = <1>;
+		reg = <0x00 0x44880000 0x00 0x20000>,
+		      <0x0 0x44860000 0x0 0x20000>,
+		      <0x0 0x43600000 0x0 0x10000>;
+		reg-names = "rt", "scfg", "target_data";
+		bootph-pre-ram;
+	};
+
+	sysctrler: sysctrler {
+		compatible = "ti,am654-system-controller";
+		mboxes= <&secure_proxy_main 1>,
+			<&secure_proxy_main 0>,
+			<&sa3_secproxy 0>;
+		mbox-names = "tx", "rx", "boot_notify";
+		bootph-pre-ram;
+	};
+};
+
+&dmsc {
+	mboxes= <&secure_proxy_main 0>,
+		<&secure_proxy_main 1>,
+		<&secure_proxy_main 0>;
+	mbox-names = "rx", "tx", "notify";
+	ti,host-id = <35>;
+	ti,secure-host;
+};
+
+&main_bcdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_pktdma {
+	ti,sci = <&dm_tifs>;
+};
+
+&main_pmx0 {
+	bootph-pre-ram;
+};
+
+/* Main UART1 is used for TIFS firmware logs */
+&main_uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_uart1_pins_default>;
+	status = "okay";
+	bootph-pre-ram;
+};
+
+&mcu_pmx0 {
+	status = "okay";
+	bootph-pre-ram;
+
+	wkup_uart0_pins_default: wkup-uart0-pins-default {
+		pinctrl-single,pins = <
+			AM62X_MCU_IOPAD(0x02c, PIN_INPUT, 0)	/* (C6) WKUP_UART0_CTSn */
+			AM62X_MCU_IOPAD(0x030, PIN_OUTPUT, 0)	/* (A4) WKUP_UART0_RTSn */
+			AM62X_MCU_IOPAD(0x024, PIN_INPUT, 0)	/* (B4) WKUP_UART0_RXD */
+			AM62X_MCU_IOPAD(0x028, PIN_OUTPUT, 0)	/* (C5) WKUP_UART0_TXD */
+		>;
+		bootph-pre-ram;
+	};
+};
+
+&ospi0 {
+	reg = <0x00 0x0fc40000 0x00 0x100>,
+	      <0x00 0x60000000 0x00 0x08000000>;
+};
+
+/* WKUP UART0 is used for DM firmware logs */
+&wkup_uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&wkup_uart0_pins_default>;
+	status = "okay";
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-k3/am62ax/Kconfig b/arch/arm/mach-k3/am62ax/Kconfig
index bbd5497f2ae..f8cdcdca57a 100644
--- a/arch/arm/mach-k3/am62ax/Kconfig
+++ b/arch/arm/mach-k3/am62ax/Kconfig
@@ -30,8 +30,29 @@ config TARGET_AM62A7_R5_EVM
 	imply SYS_K3_SPL_ATF
 	imply TI_I2C_BOARD_DETECT
 
+config TARGET_PHYCORE_AM62AX_A53
+	bool "PHYTEC phyCORE-AM62Ax running on A53"
+	select ARM64
+	select BINMAN
+	select OF_SYSTEM_SETUP
+	imply OF_UPSTREAM
+	imply BOARD
+	imply SPL_BOARD
+
+config TARGET_PHYCORE_AM62AX_R5
+	bool "PHYTEC phyCORE-AM62Ax running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
 endchoice
 
 source "board/ti/am62ax/Kconfig"
+source "board/phytec/phycore_am62ax/Kconfig"
 
 endif
diff --git a/board/phytec/phycore_am62ax/Kconfig b/board/phytec/phycore_am62ax/Kconfig
new file mode 100644
index 00000000000..516dc8e2020
--- /dev/null
+++ b/board/phytec/phycore_am62ax/Kconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+#
+# Copyright (C) 2024 PHYTEC America LLC
+# Author: Garrett Giordano <ggiordano@phytec.com>
+
+if TARGET_PHYCORE_AM62AX_A53
+
+config SYS_BOARD
+       default "phycore_am62ax"
+
+config SYS_VENDOR
+       default "phytec"
+
+config SYS_CONFIG_NAME
+       default "phycore_am62ax"
+
+source "board/phytec/common/Kconfig"
+
+endif
+
+if TARGET_PHYCORE_AM62AX_R5
+
+config SYS_BOARD
+       default "phycore_am62ax"
+
+config SYS_VENDOR
+       default "phytec"
+
+config SYS_CONFIG_NAME
+       default "phycore_am62ax"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/phytec/common/Kconfig"
+
+endif
diff --git a/board/phytec/phycore_am62ax/MAINTAINERS b/board/phytec/phycore_am62ax/MAINTAINERS
new file mode 100644
index 00000000000..3e4e2feff4e
--- /dev/null
+++ b/board/phytec/phycore_am62ax/MAINTAINERS
@@ -0,0 +1,14 @@
+phyCORE-AM62ax
+M:	Garrett Giordano <ggiordano@phytec.com>
+M:	Wadim Egorov <w.egorov@phytec.de>
+W:	https://www.phytec.com/product/phycore-am62a
+S:	Maintained
+F:	arch/arm/dts/k3-am62a-phycore-som-binman.dtsi
+F:	arch/arm/dts/k3-am62a-phycore-som-ddr4-2gb.dtsit.dtsi
+F:	arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
+F:	arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
+F:	board/phytec/phycore_am62ax/
+F:	configs/phycore_am62ax_a53_defconfig
+F:	configs/phycore_am62ax_r5_defconfig
+F:	include/configs/phycore_am62ax.h
+F:	doc/board/phytec/phycore-am62ax.rst
diff --git a/board/phytec/phycore_am62ax/Makefile b/board/phytec/phycore_am62ax/Makefile
new file mode 100644
index 00000000000..61e7c92c1c9
--- /dev/null
+++ b/board/phytec/phycore_am62ax/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+#
+# Copyright (C) 2024 PHYTEC America LLC
+# Author: Garrett Giordano <ggiordano@phytec.com>
+
+obj-y += phycore-am62ax.o
diff --git a/board/phytec/phycore_am62ax/board-cfg.yaml b/board/phytec/phycore_am62ax/board-cfg.yaml
new file mode 100644
index 00000000000..a0930d69b88
--- /dev/null
+++ b/board/phytec/phycore_am62ax/board-cfg.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for AM62ax
+#
+
+---
+
+board-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    control:
+        subhdr:
+            magic: 0xC1D3
+            size: 7
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
+    secproxy:
+        subhdr:
+            magic: 0x1207
+            size: 7
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
+    msmc:
+        subhdr:
+            magic: 0xA5C3
+            size: 5
+        msmc_cache_size: 0x10
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/phytec/phycore_am62ax/phycore-am62ax.c b/board/phytec/phycore_am62ax/phycore-am62ax.c
new file mode 100644
index 00000000000..60752f431d1
--- /dev/null
+++ b/board/phytec/phycore_am62ax/phycore-am62ax.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <spl.h>
+#include <fdt_support.h>
+
+#include "../common/am6_som_detection.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
+
+#define CTRLMMR_USB0_PHY_CTRL   0x43004008
+#define CTRLMMR_USB1_PHY_CTRL   0x43004018
+#define CORE_VOLTAGE            0x80000000
+
+#ifdef CONFIG_SPL_BOARD_INIT
+void spl_board_init(void)
+{
+	u32 val;
+
+	/* Set USB0 PHY core voltage to 0.85V */
+	val = readl(CTRLMMR_USB0_PHY_CTRL);
+	val &= ~(CORE_VOLTAGE);
+	writel(val, CTRLMMR_USB0_PHY_CTRL);
+
+	/* Set USB1 PHY core voltage to 0.85V */
+	val = readl(CTRLMMR_USB1_PHY_CTRL);
+	val &= ~(CORE_VOLTAGE);
+	writel(val, CTRLMMR_USB1_PHY_CTRL);
+
+	if (IS_ENABLED(CONFIG_SPL_ETH))
+		/* Init DRAM size for R5/A53 SPL */
+		dram_init_banksize();
+
+	/* We have 32k crystal, so lets enable it */
+	val = readl(MCU_CTRL_LFXOSC_CTRL);
+	val &= ~(MCU_CTRL_LFXOSC_32K_DISABLE_VAL);
+	writel(val, MCU_CTRL_LFXOSC_CTRL);
+	/* Add any TRIM needed for the crystal here.. */
+	/* Make sure to mux up to take the SoC 32k from the crystal */
+	writel(MCU_CTRL_DEVICE_CLKOUT_LFOSC_SELECT_VAL,
+	       MCU_CTRL_DEVICE_CLKOUT_32K_CTRL);
+
+	/* Init DRAM size for R5/A53 SPL */
+	dram_init_banksize();
+}
+#endif
diff --git a/board/phytec/phycore_am62ax/phycore_am62ax.env b/board/phytec/phycore_am62ax/phycore_am62ax.env
new file mode 100644
index 00000000000..77c5ea8d99a
--- /dev/null
+++ b/board/phytec/phycore_am62ax/phycore_am62ax.env
@@ -0,0 +1,14 @@
+fdtaddr=0x88000000
+loadaddr=0x82000000
+scriptaddr=0x80000000
+fdt_addr_r=0x88000000
+kernel_addr_r=0x82000000
+ramdisk_addr_r=0x88080000
+fdtoverlay_addr_r=0x89000000
+
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+mmcdev=1
+mmcroot=2
+mmcpart=1
+console=ttyS2,115200n8
+earlycon=ns16550a,mmio32,0x02800000
diff --git a/board/phytec/phycore_am62ax/pm-cfg.yaml b/board/phytec/phycore_am62ax/pm-cfg.yaml
new file mode 100644
index 00000000000..4031af2f4d3
--- /dev/null
+++ b/board/phytec/phycore_am62ax/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for AM62ax
+#
+
+---
+
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/phytec/phycore_am62ax/rm-cfg.yaml b/board/phytec/phycore_am62ax/rm-cfg.yaml
new file mode 100644
index 00000000000..cbd087de797
--- /dev/null
+++ b/board/phytec/phycore_am62ax/rm-cfg.yaml
@@ -0,0 +1,1047 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62A
+#
+
+---
+
+rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -   #  1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -   #  2
+                    host_id: 20
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 1064
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 64
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 4
+            type: 64
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 22
+            type: 64
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 26
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 164
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 26
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 8
+            type: 1802
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 35
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 526
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 526
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 782
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 910
+            num_resource: 128
+            type: 1805
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 1038
+            num_resource: 497
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51200
+            num_resource: 12
+            type: 12738
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 12739
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 128
+            type: 12813
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12829
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12830
+            host_id: 128
+            reserved: 0
diff --git a/board/phytec/phycore_am62ax/sec-cfg.yaml b/board/phytec/phycore_am62ax/sec-cfg.yaml
new file mode 100644
index 00000000000..ae6939eee9a
--- /dev/null
+++ b/board/phytec/phycore_am62ax/sec-cfg.yaml
@@ -0,0 +1,379 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security configuration for AM62ax
+#
+
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        write_host_id: 0
+        otp_entry:
+            -  # 1
+                host_id: 0
+                host_perms: 0
+            -  # 2
+                host_id: 0
+                host_perms: 0
+            -  # 3
+                host_id: 0
+                host_perms: 0
+            -  # 4
+                host_id: 0
+                host_perms: 0
+            -  # 5
+                host_id: 0
+                host_perms: 0
+            -  # 6
+                host_id: 0
+                host_perms: 0
+            -  # 7
+                host_id: 0
+                host_perms: 0
+            -  # 8
+                host_id: 0
+                host_perms: 0
+            -  # 9
+                host_id: 0
+                host_perms: 0
+            -  # 10
+                host_id: 0
+                host_perms: 0
+            -  # 11
+                host_id: 0
+                host_perms: 0
+            -  # 12
+                host_id: 0
+                host_perms: 0
+            -  # 13
+                host_id: 0
+                host_perms: 0
+            -  # 14
+                host_id: 0
+                host_perms: 0
+            -  # 15
+                host_id: 0
+                host_perms: 0
+            -  # 16
+                host_id: 0
+                host_perms: 0
+            -  # 17
+                host_id: 0
+                host_perms: 0
+            -  # 18
+                host_id: 0
+                host_perms: 0
+            -  # 19
+                host_id: 0
+                host_perms: 0
+            -  # 20
+                host_id: 0
+                host_perms: 0
+            -  # 21
+                host_id: 0
+                host_perms: 0
+            -  # 22
+                host_id: 0
+                host_perms: 0
+            -  # 23
+                host_id: 0
+                host_perms: 0
+            -  # 24
+                host_id: 0
+                host_perms: 0
+            -  # 25
+                host_id: 0
+                host_perms: 0
+            -  # 26
+                host_id: 0
+                host_perms: 0
+            -  # 27
+                host_id: 0
+                host_perms: 0
+            -  # 28
+                host_id: 0
+                host_perms: 0
+            -  # 29
+                host_id: 0
+                host_perms: 0
+            -  # 30
+                host_id: 0
+                host_perms: 0
+            -  # 31
+                host_id: 0
+                host_perms: 0
+            -  # 32
+                host_id: 0
+                host_perms: 0
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x23BE
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x5A
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x608F
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]
diff --git a/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml b/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
new file mode 100644
index 00000000000..151cd599b1b
--- /dev/null
+++ b/board/phytec/phycore_am62ax/tifs-rm-cfg.yaml
@@ -0,0 +1,903 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62AX
+#
+
+---
+
+tifs-rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -  # 1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 872
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 72
+            num_resource: 6
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 2
+            type: 1697
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6
+            num_resource: 34
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1024
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6656
+            num_resource: 51
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 22
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 22
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 22
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 28
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 28
+            type: 1821
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 28
+            type: 1822
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12829
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12830
+            host_id: 128
+            reserved: 0
diff --git a/configs/phycore_am62ax_a53_defconfig b/configs/phycore_am62ax_a53_defconfig
new file mode 100644
index 00000000000..8148fd4ea7a
--- /dev/null
+++ b/configs/phycore_am62ax_a53_defconfig
@@ -0,0 +1,181 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x8000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_PHYTEC_SOM_DETECTION=y
+CONFIG_PHYTEC_SOM_DETECTION_BLOCKS=y
+CONFIG_TARGET_PHYCORE_AM62AX_A53=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x680000
+CONFIG_ENV_SECT_SIZE=0x20000
+CONFIG_DM_GPIO=y
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62a7-phyboard-lyra-rdk"
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_TEXT_BASE=0x80080000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x80a00000
+CONFIG_SPL_BSS_MAX_SIZE=0x80000
+CONFIG_SPL_STACK_R=y
+CONFIG_ENV_OFFSET_REDUND=0x6c0000
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
+CONFIG_BOOTSTD_FULL=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_BOOTCOMMAND="run ${boot}boot; bootflow scan -lb"
+CONFIG_DEFAULT_FDT_FILE="oftree"
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x58000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_ENV_SUPPORT=y
+CONFIG_SPL_ETH=y
+CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="u-boot.img"
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_NET=y
+CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot A53 SPL"
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+# CONFIG_SPL_SPI_FLASH_TINY is not set
+CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_SMC=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT=y
+CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_IS_IN_SPI_FLASH=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_TI_SCI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x40000
+CONFIG_SYS_DFU_MAX_FILE_SIZE=0x800000
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xC0000000
+CONFIG_FASTBOOT_BUF_SIZE=0x2F000000
+CONFIG_TI_SCI_PROTOCOL=y
+CONFIG_DA8XX_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+# CONFIG_SPI_FLASH_SMART_HWCAPS is not set
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_PHY_TI_DP83867=y
+CONFIG_PHY_FIXED=y
+CONFIG_TI_AM65_CPSW_NUSS=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_SCI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_REMOTEPROC_TI_K3_DSP=y
+CONFIG_REMOTEPROC_TI_K3_R5F=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_DM_RTC=y
+CONFIG_RTC_RV3028=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_SYSRESET=y
+CONFIG_SPL_SYSRESET=y
+CONFIG_SYSRESET_TI_SCI=y
+CONFIG_DM_THERMAL=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_SPL_DM_USB_GADGET=y
+CONFIG_SPL_USB_HOST=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_DWC3=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_AM62=y
+CONFIG_USB_DWC3_AM62=y
+CONFIG_SPL_USB_STORAGE=y
+CONFIG_USB_GADGET=y
+CONFIG_SPL_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
+CONFIG_USB_GADGET_VENDOR_NUM=0x0451
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6165
+CONFIG_SPL_DFU=y
+CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
diff --git a/configs/phycore_am62ax_r5_defconfig b/configs/phycore_am62ax_r5_defconfig
new file mode 100644
index 00000000000..a71ebf0dc2c
--- /dev/null
+++ b/configs/phycore_am62ax_r5_defconfig
@@ -0,0 +1,129 @@
+CONFIG_ARM=y
+CONFIG_ARCH_K3=y
+CONFIG_SYS_MALLOC_F_LEN=0x9000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_SOC_K3_AM62A7=y
+CONFIG_TARGET_PHYCORE_AM62AX_R5=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
+CONFIG_ENV_SIZE=0x20000
+CONFIG_ENV_OFFSET=0x680000
+CONFIG_SPL_DM_SPI=y
+CONFIG_DEFAULT_DEVICE_TREE="k3-am62a7-r5-phycore-som-2gb"
+CONFIG_DM_RESET=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x7145
+CONFIG_SPL_TEXT_BASE=0x43c00000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x43c3b000
+CONFIG_SPL_BSS_MAX_SIZE=0x3000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_SIZE_LIMIT=0x3A7F0
+CONFIG_SPL_SIZE_LIMIT_PROVIDE_STACK=0x3500
+CONFIG_SPL_FS_FAT=y
+CONFIG_SPL_LIBDISK_SUPPORT=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x80080000
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_GD=y
+CONFIG_SPL_SIZE_LIMIT_SUBTRACT_MALLOC=y
+CONFIG_SPL_MAX_SIZE=0x3B000
+CONFIG_SPL_PAD_TO=0x0
+CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+CONFIG_SPL_SEPARATE_BSS=y
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x84000000
+CONFIG_SPL_EARLY_BSS=y
+CONFIG_SPL_DMA=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_MTD=y
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_RAM_DEVICE=y
+CONFIG_SPL_REMOTEPROC=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SPL_THERMAL=y
+CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_ASKENV=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_REMOTEPROC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_TIME=y
+CONFIG_CMD_FAT=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_PART=1
+CONFIG_SPL_DM=y
+CONFIG_SPL_DM_DEVICE_REMOVE=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_REGMAP=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_CLK_K3_PLL=y
+CONFIG_SPL_CLK_K3=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_TI_K3_NAVSS_UDMA=y
+CONFIG_TI_SCI_PROTOCOL=y
+# CONFIG_GPIO is not set
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_OMAP24XX=y
+CONFIG_DM_MAILBOX=y
+CONFIG_K3_SEC_PROXY=y
+CONFIG_ESM_K3=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_SPL_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_AM654=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+# CONFIG_SPI_FLASH_SMART_HWCAPS is not set
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PINCTRL=y
+# CONFIG_PINCTRL_GENERIC is not set
+CONFIG_SPL_PINCTRL=y
+# CONFIG_SPL_PINCTRL_GENERIC is not set
+CONFIG_PINCTRL_SINGLE=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_TI_POWER_DOMAIN=y
+CONFIG_K3_SYSTEM_CONTROLLER=y
+CONFIG_REMOTEPROC_TI_K3_ARM64=y
+CONFIG_RESET_TI_SCI=y
+CONFIG_SPECIFY_CONSOLE_INDEX=y
+CONFIG_DM_SERIAL=y
+CONFIG_SOC_DEVICE=y
+CONFIG_SOC_DEVICE_TI_K3=y
+CONFIG_SOC_TI=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_CADENCE_QSPI=y
+CONFIG_TIMER=y
+CONFIG_SPL_TIMER=y
+CONFIG_OMAP_TIMER=y
+CONFIG_LIB_RATIONAL=y
+CONFIG_SPL_LIB_RATIONAL=y
diff --git a/include/configs/phycore_am62ax.h b/include/configs/phycore_am62ax.h
new file mode 100644
index 00000000000..661ba8f73ca
--- /dev/null
+++ b/include/configs/phycore_am62ax.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
+/*
+ * Configuration header file for PHYTEC phyCORE-AM62Ax
+ *
+ * Copyright (C) 2024 PHYTEC America LLC
+ * Author: Garrett Giordano <ggiordano@phytec.com>
+ */
+
+#ifndef __PHYCORE_AM62AX_H
+#define __PHYCORE_AM62AX_H
+
+/* DDR Configuration */
+#define CFG_SYS_SDRAM_BASE		0x80000000
+
+#endif /* __PHYCORE_AM62AX_H */
-- 
2.25.1

