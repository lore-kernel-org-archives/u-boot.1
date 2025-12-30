Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32CCE92722
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 05:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3B0583DEE;
	Tue, 30 Dec 2025 06:30:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=metanoiacomm.onmicrosoft.com header.i=@metanoiacomm.onmicrosoft.com header.b="Kn/EpdGD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 052B883F39; Tue, 30 Dec 2025 04:03:43 +0100 (CET)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EFC183F15
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 04:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jun.chang@metanoia-comm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kclBcZjw3C2qtfOua5r5ihvoL1YWwUke8QBSz8/IQ19c4yUeCGPkdhYawJSlHKevp7VugCTRiYmBK2qPy1ITMD4V0fPsjJqTyoZHuHZkRdRnMQqxhUvpsr3JMidONXtVSjM/6O8pD4Jc18rNiD5bkkERlEaiSXPtBPaTzUq9xLJyWFsVRj33siawDL0AosUIVypaaXxOU83ER2wpGEM3h++csaKzl1MEnxGrDKQ7XiLovr0evJG8hp/s1wpkxdoJxJlu3/iQXxWBdsXKBZzo/uhbjPfDdABkswFg7ZQc3iMZ3AHh2OjQDHo/Hy8DwRj+lT7aHitYej/i4wzSX0Pwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HUGWkbmTl0/60nhmmCfkN4Q0WaYq5mlRSwz2glHU+U=;
 b=haTz9nGXpFS9wIiWTHV+zBSWlrI3fOamkCTytmiGsIPc2CkmUYegFRsIusH1G3Xf6oahi/HtKatllkbHDLBKBH2Z95VTDVx9A9uLZytwMy4EzR9Fy4qf6cJxgiXMnHDuopushBgnj6QddywND3WENK4oQonWIZzKbeTvjFOZnezwyrGrqvxUVE9DTPJyYAKsJsR7d7wVbHY4mqgiCqcb5Xbwv9XirUZsYC44/x5OejKpgZsrqoTuB6DzFn0S661wVmNJTFWEkVtPvZCXap6nhLCgc+iShrbi2qaP7fvusKx30J2dDHyoRWg4GmdY5LblUixXqrl6ug+RZxzPJehNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metanoia-comm.com; dmarc=pass action=none
 header.from=metanoia-comm.com; dkim=pass header.d=metanoia-comm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metanoiacomm.onmicrosoft.com; s=selector1-metanoiacomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HUGWkbmTl0/60nhmmCfkN4Q0WaYq5mlRSwz2glHU+U=;
 b=Kn/EpdGDrVPFD0nrNX0h3lS2B9JsnuNDW0Vy2wBjp6H4h2IPMmMDw+QEXQu6KehAHtnDgQu4DYpZYE/5ts2CS506LNywr2fceRRRp8YMI1aVCQyKcIFr73mE9+KRWyq8YE5QbfSkdl4EHzHIuuTJ+6VRnrD01axqoskMPXNmZVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=metanoia-comm.com;
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com (2603:1096:405:8f::6)
 by TY0PR06MB5459.apcprd06.prod.outlook.com (2603:1096:400:31f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 03:03:36 +0000
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639]) by TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 03:03:36 +0000
From: Jun Chang <jun.chang@metanoia-comm.com>
To: u-boot@lists.denx.de
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Jun Chang <jun.chang@metanoia-comm.com>
Subject: [PATCH 1/1] board: mt5824: Add initial support for Metanoia MT5824 EVB
Date: Tue, 30 Dec 2025 11:03:28 +0800
Message-ID: <20251230030328.215240-2-jun.chang@metanoia-comm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0014.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::11) To TYSPR06MB7207.apcprd06.prod.outlook.com
 (2603:1096:405:8f::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7207:EE_|TY0PR06MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 680f4a0c-4d50-4e95-b3d2-08de47500630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gSWYg7DRajnkXxJj6cnnjyMhonAjYXx0Y/giKAs7FirMQ8bp0dKIUGUvUmii?=
 =?us-ascii?Q?6LgmcSaN8A7M1zupeTH/WVYEY+AdXv07++hEkz7lUEDt2Hzi7ntBonHQigr3?=
 =?us-ascii?Q?sWGHuD+8fEkDlbZcHvoKf7CAGUfAXKINf196Pms/R1B5jFf1sp6rCI/1I09Y?=
 =?us-ascii?Q?6MjdmWAHcGlY7XBnB2qVQP4UhJ2uxWTxPyqgstb2wxMCmdp/OopRoHcB5NAD?=
 =?us-ascii?Q?voMadiTlxML1PuznwGrbftLRoAmIEPuzIgbDv3JxFgb0yHgpJXigBL9bV3Ot?=
 =?us-ascii?Q?A0YuYj+NrarKQhzUGcq/PgeFNA4wfYOrIeu8mcYFJALHXUXjiITvKC1/6NYQ?=
 =?us-ascii?Q?PPK+a+rgzOkqCbnaoPKpjfdWALq+2F6u+H1C0MDL1m8cwWXOc9KJnFf19EzP?=
 =?us-ascii?Q?Di78Oh0T1v/4042gnpZfgkXPulwmUbh7nORkzUX6J4cxhVTLW3mypp8GSz7W?=
 =?us-ascii?Q?3v/Jxm0JpxtsaIFSXSSNMG8u3LqU3Dt7cpXIWj6F8gK5HuK37HT5qnUgsxoE?=
 =?us-ascii?Q?cd5sumxCuBkLciTr7yU95mpp/y43rMxkdBmUn3ejlvG/uYxEaU2C1EqBiShT?=
 =?us-ascii?Q?GKkOG7QAHm/Npp5E4hoKy4aQHxHXLr4j8ycqBWHWacyoDHwvP01YKdUM9xdf?=
 =?us-ascii?Q?7CyPE5E02I3mjs0IueXpXF90Hhn8FvD+IRTQGaWYGXl4AvUubdh25kXd0kF5?=
 =?us-ascii?Q?WwgMmXy/BEOlCHJP+mc0QxxMoShbTHL894NE72dsiw8R5mXfaATL3Zb6XpYj?=
 =?us-ascii?Q?ItzOgFMosUNV9dhmQF0tduTkG/J3L72EiK05sib/UCELqSeLEWOJVeBIwR8R?=
 =?us-ascii?Q?TWtLfRq/xSuMc/vnQi2vFVsMIQlgq23OGy9kbinQ2toiPMDyjTmMZZ8hLjtb?=
 =?us-ascii?Q?SGUZk+0b3EwfiL82fcDrgtUatsbZeGWXXC9e9fYJsAZTZ4ic+3HH05k18FRN?=
 =?us-ascii?Q?CrNCFrv5jYtbvE5nlLP+28C/t5gDSbvLzZ1d9HhVF8xKv0dyoLBCS9h2AFcH?=
 =?us-ascii?Q?RQ+3FyF0Y3F7FUXHAmj0e9zAvtnY0hLIo9104XxpBjhp6JsCmMjHQoJchB1n?=
 =?us-ascii?Q?b6yyr00js7GnSpq+3IuOZ/zqT8Agk6WqnS2zzJVJ5V+EPSh6LkUnfIf5nokq?=
 =?us-ascii?Q?cm/46/E1ZX1GVDL+GTw8u2shVWUqEJMR2c3ZQI7/q6WAXwKswtygt8pb4gY1?=
 =?us-ascii?Q?EClR5bwSLd07jvrqjZ+4Md6MVZBU7M4UHu++xPciGaiXE1NCYPBCSKFlnsk+?=
 =?us-ascii?Q?KdpJYJdnlNEkiT7KAu6xSnU7eve/3O6ylCDzX8YIlYc+TUnHKcQHKkr9nFTs?=
 =?us-ascii?Q?kAqkf76YWdMGGjmcb6jI5rUPlBNcnkNGXfGFQHIGastp2v9C1JekDUztrYQ5?=
 =?us-ascii?Q?GJwjs54/BJ56zf8hf/aIsi/iQ8NWiBIIj7fCorZFEyIapoRngEuBslcV+mo6?=
 =?us-ascii?Q?WBBqZZ9b4qjLkIIuVL2bW3cHXQWEv6WyTfzOTTYDV+rcAujsNZvTXaX/8Tvu?=
 =?us-ascii?Q?Satw8kL5kPiUcpl8PrnTUMoPYiVjMGNDMrQp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYSPR06MB7207.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fEF7drmI446kOrauuqMxdQbT4x0QKRWPmoClav0c1jnEB+EtKCuk7WTfcRdw?=
 =?us-ascii?Q?iloa0c8x/UulbYKPKmWvk6i9B9fudO7R11aDGyZTdojtk07Q984JZE7rbMGE?=
 =?us-ascii?Q?y8NXlTbQcKTwVMEZiFe827XlULysHfVC7CyJVWGwc/jVno/8EmaN4IUCCnxF?=
 =?us-ascii?Q?WfUKLnlOADYwWu/7bOxRXFuC8e0r5B27g6XxXyPXmxe6zbFdr6p6FaS2K9FQ?=
 =?us-ascii?Q?U23wAuq+8N/YhI1wcU6ZhY8rot3N0PvaLgbkc8/BHPRS5Gg+hsYvqd1R3VPv?=
 =?us-ascii?Q?6kMX3WHNUig8F9+Qx+6lbym1BatGC15q0Kwsp+DiI6qtey/GDZNAw6z9vGkr?=
 =?us-ascii?Q?7V78md/5MdKVYthU6ZqKGtUUVNbFUZRODHTgogeIIip4Kr4T5r3MqRNx1/o0?=
 =?us-ascii?Q?7Tl5vUpfaq9xJLbjGD+TMvbA57PeHF587aUUqycRrJcc4nXXR2/LaX1pGnSY?=
 =?us-ascii?Q?Vj4QcLoM9khdzXqoxI37ed+o9xWdR3ZjsvlaRv1KdZ3ZmgfId+zfsr0jacn6?=
 =?us-ascii?Q?6r9IkJC93zcLBQIS+3FipS6O4PzxRmkp3ZNFlNeJJ6vZ/GjdibC4kZiJmMpu?=
 =?us-ascii?Q?Us9vxbcWkBhqWXFdpi4Gb6HYDbxidODYULE0XNhSxYUh2l/o2DxwqIucVdiS?=
 =?us-ascii?Q?ZZPECCYf2IlFIBYTV+lkqXVn/mQRVgJ6sMDMQ7LoJoyuAvwNQyQ2tG2XsvW2?=
 =?us-ascii?Q?fqW6MHhzGGNgux36EEHk/Y+7OiY9cDXmXiIlNJPA9EhIbkhtx122xb7214tK?=
 =?us-ascii?Q?3g9iKPLFdT88Owd7hLpLrvTQydSFq0Mv8QRbVtNFnj+XtgUNcHgeLzyOI80m?=
 =?us-ascii?Q?ccH90tbR/v23Q9X0bD5DnKVKOqaDGOGt+MmZiw1p7YNiLxUias1vhzucfnJ2?=
 =?us-ascii?Q?fWqvZDfUyJ+fXgq4kopU2yY6uGuA0yfP1M4W2WUmxMsYM65IUMcnNqt9PpN0?=
 =?us-ascii?Q?XlG0BU7hkt/EoybfwBHP8jxBhfegei95FPinsFFcGVwlGAQsQrKq3S02L49E?=
 =?us-ascii?Q?vhoE7GjjR/nQgq081+d3bO2NHP+AGdAiyHFm9nm5KFCXNdOLu/OefawcsuIF?=
 =?us-ascii?Q?3XOtpiiK2Q8AicSqtYJvdzT1S99A69dSuKdNvSYp9k/8G+LsvgCY844PuzQZ?=
 =?us-ascii?Q?WDp55A/oFVx7pE0xgliIRknWrbeQN5me8LFJWEkw/Yu4hE8d3Om/qrA+DrH/?=
 =?us-ascii?Q?/GtsmgotjiaIJWqhffAGsKij30+vmIEnlFRU4lfU9AogepAG19cN0yefg5Pt?=
 =?us-ascii?Q?FoeTpH3KFIbCrIpZ61GhtPp2t8feqBeji4GDUsPAsq4wdEH/cqln5AtiqFAI?=
 =?us-ascii?Q?93kC9avDRhAx0crQy74ZIkb1OS67rKKdMuTiHiBmER4VBapbIrXnMAV/GY9i?=
 =?us-ascii?Q?jG+MeOtVqURpExBgvi5+vmt2e4Yhl7M2ZGWIK5yj4TZAlwsljeTNEiS5VBps?=
 =?us-ascii?Q?6u93/NMz1H+oj4HA+OUSWeSG4Q2qpqFywk+qk8FlaOO0YtKuquGNEBMovReL?=
 =?us-ascii?Q?e3HjU1tdSkokgvmzNEabygELl/l+MEuSsd0afmRaVTnJMmCagCgto3EUzwkF?=
 =?us-ascii?Q?Dk/uZTkgF6ko/rM4ERKLYQrjglepAB1dSeYMjILWeh/499w7v4PNc/kFDvcR?=
 =?us-ascii?Q?AOaLkIDiM+3sz598oLpZvvH9MQRxohMuzC9Mk3iZfUgZxe+qurz40E7eXxH4?=
 =?us-ascii?Q?wGfJlICUlxPMEZl2KS8MMmkj8jO9LcWmU6Gn51/QzCqRD+CsiAgkihP/GJMq?=
 =?us-ascii?Q?I9Hc1+IQdnQq6Q2ADc/QpUh1fAD8BOA=3D?=
X-OriginatorOrg: metanoia-comm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680f4a0c-4d50-4e95-b3d2-08de47500630
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7207.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 03:03:36.2648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31a25295-9a4d-4cf7-b9ce-e250507bb0c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90NOTr7kqVCSOnSmDyIVgdQKdbjuZ6+JZkMQGFngmNqw0sbsX8pNVKmfICY5tZnefAWDOpGB6UM20dDgIgFv63Hi46hRxIHGZNvQK8QYXvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5459
X-Mailman-Approved-At: Tue, 30 Dec 2025 06:30:25 +0100
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

- Add RISC-V target for MT5824
- Add board defconfig and DTS for MT5824 EVB
- Add SPL and U-Boot board support for MT5824 EVB
- Add DDR init for MT5824 EVB

Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
---
 arch/riscv/Kconfig                    |   4 +
 arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
 board/metanoia/mt5824/Kconfig         |  49 ++++
 board/metanoia/mt5824/MAINTAINERS     |   7 +
 board/metanoia/mt5824/Makefile        |   7 +
 board/metanoia/mt5824/lpddr4.h        |  91 +++++++
 board/metanoia/mt5824/lpddr4_helper.c | 352 ++++++++++++++++++++++++++
 board/metanoia/mt5824/lpddr4_init.c   | 115 +++++++++
 board/metanoia/mt5824/mt5824.c        | 188 ++++++++++++++
 board/metanoia/mt5824/mt5824.h        |  21 ++
 board/metanoia/mt5824/mt5824_ddr.c    |  54 ++++
 board/metanoia/mt5824/mt5824_ddr.h    |  12 +
 board/metanoia/mt5824/mt5824_spl.c    | 141 +++++++++++
 configs/mt5824_evb_defconfig          |  61 +++++
 include/configs/mt5824.h              | 130 ++++++++++
 15 files changed, 1464 insertions(+)
 create mode 100644 arch/riscv/dts/mt5824-evb.dts
 create mode 100644 board/metanoia/mt5824/Kconfig
 create mode 100644 board/metanoia/mt5824/MAINTAINERS
 create mode 100644 board/metanoia/mt5824/Makefile
 create mode 100644 board/metanoia/mt5824/lpddr4.h
 create mode 100644 board/metanoia/mt5824/lpddr4_helper.c
 create mode 100644 board/metanoia/mt5824/lpddr4_init.c
 create mode 100644 board/metanoia/mt5824/mt5824.c
 create mode 100644 board/metanoia/mt5824/mt5824.h
 create mode 100644 board/metanoia/mt5824/mt5824_ddr.c
 create mode 100644 board/metanoia/mt5824/mt5824_ddr.h
 create mode 100644 board/metanoia/mt5824/mt5824_spl.c
 create mode 100644 configs/mt5824_evb_defconfig
 create mode 100644 include/configs/mt5824.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 265b5320777..8ff60179f4f 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,9 @@ config TARGET_K230_CANMV
 config TARGET_LICHEERV_NANO
 	bool "Support LicheeRV Nano Board"
 
+config TARGET_METANOIA_MT5824
+	bool "Support Metanoia MT5824 Chipset"
+
 config TARGET_MICROCHIP_GENERIC
 	bool "Support Microchip PolarFire-SoC Boards"
 
@@ -108,6 +111,7 @@ source "board/andestech/voyager/Kconfig"
 source "board/aspeed/ibex_ast2700/Kconfig"
 source "board/canaan/k230_canmv/Kconfig"
 source "board/emulation/qemu-riscv/Kconfig"
+source "board/metanoia/mt5824/Kconfig"
 source "board/microchip/mpfs_generic/Kconfig"
 source "board/openpiton/riscv64/Kconfig"
 source "board/sifive/unleashed/Kconfig"
diff --git a/arch/riscv/dts/mt5824-evb.dts b/arch/riscv/dts/mt5824-evb.dts
new file mode 100644
index 00000000000..fd58055c6e8
--- /dev/null
+++ b/arch/riscv/dts/mt5824-evb.dts
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include "binman.dtsi"
+
+/ {
+	#address-cells = <0x02>;
+	#size-cells = <0x02>;
+	compatible = "metanoia,mt5824";
+	model = "metanoia,mt5824-cobra-evb";
+
+	aliases {
+		uart0 = "/soc/serial@100e0000";
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 debug loglevel=7 earlycon=sbi";
+		stdout-path = "uart0:115200n8";
+	};
+
+	cpus: cpus {
+		#address-cells = <0x01>;
+		#size-cells = <0x00>;
+		timebase-frequency = <20000000>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			reg = <0x00>;
+			status = "okay";
+			compatible = "riscv", "andestech,ax45mp";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm", "xandespmu";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <900000000>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <0x100>;
+			i-cache-line-size = <0x40>;
+			i-cache-block-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <0x80>;
+			d-cache-line-size = <0x40>;
+			d-cache-block-size = <0x40>;
+			next-level-cache = <&l2c>;
+
+			cpu0intc: interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "andestech,cpu-intc";
+			};
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			reg = <0x01>;
+			status = "okay";
+			compatible = "riscv", "andestech,ax45mp";
+			riscv,isa-base = "rv64i";
+			riscv,isa-extensions = "i", "m", "a", "f", "d", "c",
+					       "zicntr", "zicsr", "zifencei",
+					       "zihpm", "xandespmu";
+			mmu-type = "riscv,sv39";
+			clock-frequency = <900000000>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <0x100>;
+			i-cache-line-size = <0x40>;
+			i-cache-block-size = <0x40>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <0x80>;
+			d-cache-line-size = <0x40>;
+			d-cache-block-size = <0x40>;
+			next-level-cache = <&l2c>;
+
+			cpu1intc: interrupt-controller {
+				#interrupt-cells = <0x01>;
+				interrupt-controller;
+				compatible = "andestech,cpu-intc";
+			};
+		};
+	};
+
+	l2c: l2-cache@0a000000 {
+		compatible = "cache", "andestech,ax45mp-cache";
+		cache-level = <0x02>;
+		cache-size = <0x80000>;
+		reg = <0x00 0x0a000000 0x00 0x40000>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&plic>;
+		andes,inst-prefetch = <0x03>;
+		andes,data-prefetch = <0x03>;
+		andes,tag-ram-ctl = <0x00 0x00>;
+		andes,data-ram-ctl = <0x00 0x00>;
+	};
+
+	LPDDR4: memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0000000080000000 0x00000000 0x80000000>, /* 2GB */
+			<0x1 0x0000000000000000 0x00000000 0x80000000>; /* 2GB */
+	};
+
+	sb_3v3: regulator-sb3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_vbus";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	soc: soc {
+		#address-cells = <0x02>;
+		#size-cells = <0x02>;
+		compatible = "simple-bus";
+		ranges;
+
+		/* ArchDef Figure 53 - Clock Frequency inside SOC */
+		ext_clk: ext-clk {
+			compatible = "metanoia,mt28xx-ext-clk", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <20000000>;
+			clock-output-names = "ext-clk";
+			/* mainly optional clock for wdt, plmt */
+		};
+
+		pclk: platform-clock {
+			compatible = "metanoia,mt28xx-pclk", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <900000000>;
+			clock-output-names = "platform-clock";
+		};
+
+		pclk_div2: platform-clock-div2 {
+			compatible = "metanoia,mt28xx-pclk-div2", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <450000000>;
+			clock-output-names = "platform-clock-div2";
+		};
+
+		pclk_div4: platform-clock-div4 {
+			compatible = "metanoia,mt28xx-pclk-div4", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <225000000>;
+			clock-output-names = "platform-clock-div4";
+		};
+
+		pll_soc_out3: pll-soc-out3 {
+			compatible = "metanoia,mt28xx-out3-clk", "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <180000000>;
+			clock-output-names = "pll-soc-out3";
+		};
+
+		plic: interrupt-controller@c000000 {
+			compatible = "riscv,plic0", "andestech,nceplic100";
+			reg = <0x0 0x0c000000 0x0 0x400000>;
+			interrupts-extended =
+				<&cpu0intc 0x0b>,
+				<&cpu0intc 0x09>,
+				<&cpu1intc 0x0b>,
+				<&cpu1intc 0x09>;
+			interrupt-controller;
+			#address-cells = <0x02>;
+			#interrupt-cells = <0x02>;
+			riscv,ndev = <0x47>;
+		};
+
+		plicsw: interrupt-controller@c800000 {
+			compatible = "andestech,plicsw";
+			reg = <0x00 0x0c800000 0x00 0x400000>;
+			interrupts-extended =
+				<&cpu0intc IRQ_TYPE_EDGE_BOTH>,
+				<&cpu1intc IRQ_TYPE_EDGE_BOTH>;
+			interrupt-controller;
+			#address-cells = <0x02>;
+			#interrupt-cells = <0x02>;
+			riscv,ndev = <0x04>;
+		};
+
+		plmt0@c400000 {
+			compatible = "andestech,plmt0";
+			reg = <0x0 0x0c400000 0x0 0x00400000>;
+			interrupts-extended =
+				<&cpu0intc 0x07>,
+				<&cpu1intc 0x07>;
+		};
+
+		sw_reset: hrst@10000004 {
+			/* match swrstreq ctrl,
+			 * drived by opensbi's fdt_reset_metanoia.c.
+			 */
+			#reset-cells = <1>;
+			compatible = "metanoia,cobra-hrst";
+			reg = <0x0 0x10000004 0x0 0x08>;
+		};
+
+		riscv_console: serial@100e0000 {
+			compatible = "metanoia,uart16550", "ns16550a";
+			reg = <0x00 0x100e0000 0x00 0x1000>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&plic>;
+			clocks = <&pclk_div4>;
+			current-speed = <115200>;
+			reg-shift = <0x02>;
+			reg-offset = <0x20>;
+			reg-io-width = <0x04>;
+			no-loopback-test = <0x01>;
+		};
+
+		mmcsd: mmc@4100000 {
+			compatible = "metanoia,dwc-mmc";
+			max-frequency = <200000000>; /* why not pll_soc_out3? */
+			clocks = <&pll_soc_out3>;
+			reg = <0x0 0x04100000 0x0 0x00100000>, /* SDHCI */
+			      <0x0 0x10010300 0x0 0x00000004>; /* DEV_DB_CFG_0 */
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&plic>;
+			sdhci-caps-mask = <0x80000006 0x00000000>;
+			bus-width = <4>;
+		};
+
+		pmu {
+			compatible = "riscv,andes-pmu";
+			device_type = "pmu";
+		};
+
+	};
+
+};
diff --git a/board/metanoia/mt5824/Kconfig b/board/metanoia/mt5824/Kconfig
new file mode 100644
index 00000000000..3bd2f97beea
--- /dev/null
+++ b/board/metanoia/mt5824/Kconfig
@@ -0,0 +1,49 @@
+if TARGET_METANOIA_MT5824
+
+config SYS_CPU
+	default "andes"
+
+config SYS_BOARD
+	default "mt5824"
+
+config SYS_VENDOR
+	default "metanoia"
+
+config SYS_SOC
+	default "mt5824"
+
+config SYS_CONFIG_NAME
+	default "mt5824"
+
+config ENV_SIZE
+	default 0x2000 if ENV_IS_IN_SPI_FLASH
+
+config ENV_OFFSET
+	default 0x140000 if ENV_IS_IN_SPI_FLASH
+
+config SPL_TEXT_BASE
+	default 0x68000000
+
+config SPL_OPENSBI_LOAD_ADDR
+	default 0x80000000
+
+config SYS_FDT_BASE
+	hex
+	default 0x68010000 if OF_SEPARATE
+
+config NR_CPUS
+	default 2
+
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select RISCV_ANDES
+	select SUPPORT_SPL
+	select BINMAN if SPL
+	imply SMP
+	imply SPL_RAM_SUPPORT
+	imply SPL_RAM_DEVICE
+	imply BOARD_EARLY_INIT_F
+	imply OF_HAS_PRIOR_STAGE
+	imply SPL_BOARD_INIT
+
+endif
diff --git a/board/metanoia/mt5824/MAINTAINERS b/board/metanoia/mt5824/MAINTAINERS
new file mode 100644
index 00000000000..a507da2d0af
--- /dev/null
+++ b/board/metanoia/mt5824/MAINTAINERS
@@ -0,0 +1,7 @@
+Metanoia MT5824 EVB
+M:	Jun Chang <jun.chang@metanoia-comm.com>
+S:	Maintained
+F:	board/metanoia/mt5824/
+F:	include/configs/mt5824.h
+F:	configs/mt5824_evb_defconfig
+F:	arch/riscv/dts/mt5824-evb.dts
diff --git a/board/metanoia/mt5824/Makefile b/board/metanoia/mt5824/Makefile
new file mode 100644
index 00000000000..e9bbc6157be
--- /dev/null
+++ b/board/metanoia/mt5824/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Metanoia Communications Inc.,
+# Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+
+obj-y	:= mt5824.o
+obj-$(CONFIG_SPL_BUILD)	+= mt5824_spl.o mt5824_ddr.o lpddr4_init.o lpddr4_helper.o
diff --git a/board/metanoia/mt5824/lpddr4.h b/board/metanoia/mt5824/lpddr4.h
new file mode 100644
index 00000000000..5de70c536ca
--- /dev/null
+++ b/board/metanoia/mt5824/lpddr4.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#ifndef __COBRA_DDR_H
+#define __COBRA_DDR_H
+
+#include <asm/io.h>
+
+#define UMCTL2_REGS_BASE_ADDR 0x10060000
+
+#define reg8_write(addr, data) \
+	writeb((uint8_t)(data), (volatile void __iomem *)(addr))
+#define reg16_write(addr, data) \
+	writew((uint16_t)(data), (volatile void __iomem *)(addr))
+#define reg32_write(addr, data) \
+	writel((uint32_t)(data), (volatile void __iomem *)(addr))
+
+#define reg8_read(addr) readb((volatile void __iomem *)(addr))
+#define reg16_read(addr) readw((volatile void __iomem *)(addr))
+#define reg32_read(addr) readl((volatile void __iomem *)(addr))
+
+#define ddrphy_apb_wr(addr, data) reg16_write((2 * addr + 0x14000000), data)
+#define ddrphy_apb_rd(addr) reg16_read((2 * addr + 0x14000000))
+
+#define UctShadowRegs (0xd0000 + 0x4)
+#define DctWriteOnly (0xd0000 + 0x30)
+#define DctWriteProt (0xd0000 + 0x31)
+#define UctWriteOnlyShadow (0xd0000 + 0x32)
+#define UctDatWriteOnlyShadow (0xd0000 + 0x34)
+
+#define DDRC_STAT (UMCTL2_REGS_BASE_ADDR + 0x04)
+#define DDRC_PWRCTL (UMCTL2_REGS_BASE_ADDR + 0x30)
+#define DDRC_RFSHCTL3 (UMCTL2_REGS_BASE_ADDR + 0x60)
+#define DDRC_DFIMISC (UMCTL2_REGS_BASE_ADDR + 0x1b0)
+#define DDRC_DFISTAT (UMCTL2_REGS_BASE_ADDR + 0x1bc)
+#define DDRC_SWCTL (UMCTL2_REGS_BASE_ADDR + 0x320)
+#define DDRC_SWSTAT (UMCTL2_REGS_BASE_ADDR + 0x324)
+
+#define DDRFW_MAGIC 0x44445246 /* "DDRF" */
+
+struct ddrfw_comp{
+	u32 offset;
+	u32 size;
+	u32 crc32;
+	u32 reserved;
+};
+
+struct ddrfw_header{
+	u32 magic;
+	u32 version;
+	u32 header_size;
+	u32 total_size;
+	u32 flags;
+	u32 timestamp;
+	u32 reserved1;
+	u32 reserved2;
+	struct ddrfw_comp comps[7];
+	u32 header_crc32;
+	u32 reserved[27]; /* Padding to 256 bytes */
+};
+
+enum {
+	DDR_CTRL_CFG = 0,
+	DDR_PHY_CFG = 1,
+	DDR_PMU_1D_IMEM = 2,
+	DDR_PMU_1D_DMEM = 3,
+	DDR_PMU_2D_IMEM = 4,
+	DDR_PMU_2D_DMEM = 5,
+	DDR_PIE_IMAGE = 6,
+	DDR_COMP_MAX
+};
+
+int ddrphy_init(uintptr_t fw_base);
+
+/* DDR Firmware helper functions */
+int ddrfw_parse_fw_header(uintptr_t fw_base, struct ddrfw_header *header);
+void ddrfw_load_controller_config(uintptr_t fw_base, struct ddrfw_header *fw_header);
+void ddrfw_load_phy_cfg(uintptr_t fw_base, struct ddrfw_header *fw_header);
+int ddrfw_load_train_firmware(uintptr_t fw_base, struct ddrfw_header *fw_header);
+void ddrfw_load_pie_image(uintptr_t fw_base, struct ddrfw_header *fw_header);
+static inline int waitlp(unsigned int cnt)
+{
+	while (cnt--)
+		;
+	return cnt;
+}
+
+#endif /* __COBRA_DDR_H */
\ No newline at end of file
diff --git a/board/metanoia/mt5824/lpddr4_helper.c b/board/metanoia/mt5824/lpddr4_helper.c
new file mode 100644
index 00000000000..3bc447038dc
--- /dev/null
+++ b/board/metanoia/mt5824/lpddr4_helper.c
@@ -0,0 +1,352 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <config.h>
+#include <log.h>
+#include <asm/io.h>
+#include <u-boot/crc.h>
+
+#include "lpddr4.h"
+
+#define IMEM_OFFSET_ADDR 0x00050000
+#define DMEM_OFFSET_ADDR 0x00054000
+
+static u32 get_mail(int mode)
+{
+	u32 mail;
+
+	while ((ddrphy_apb_rd(UctShadowRegs) & 1)) {
+		if (mode == 0)
+			waitlp(100);
+	}
+
+	mail = ddrphy_apb_rd(UctWriteOnlyShadow);
+	if (mode == 1)
+		mail |= (ddrphy_apb_rd(UctDatWriteOnlyShadow) << 16);
+
+	ddrphy_apb_wr(DctWriteProt, 0);
+	while (ddrphy_apb_rd(UctShadowRegs) == 0) {
+		;
+	}
+	ddrphy_apb_wr(DctWriteProt, 1);
+
+	return mail;
+}
+
+static void decode_streaming_message(void)
+{
+	u32 string_index;
+	u32 i = 0;
+	u32 args[32];
+
+	string_index = get_mail(1);
+	while (i < (string_index & 0xffff)) {
+		args[i] = get_mail(1);
+		i++;
+	}
+
+	return;
+}
+
+static void decode_major_message(u32 mail)
+{
+	switch (mail) {
+	case 0x07:
+		printf("DDRPHY: Training has run successfully\n");
+		break;
+	case 0xff:
+		printf("DDRPHY: Training has failed\n");
+		break;
+	case 0x00:
+		debug("DDRPHY: End of initialization\n");
+		break;
+	case 0x01:
+		debug("DDRPHY: End of fine write leveling\n");
+		break;
+	case 0x02:
+		debug("DDRPHY: End of read enable training\n");
+		break;
+	case 0x03:
+		debug("DDRPHY: End of read delay center optimization\n");
+		break;
+	case 0x04:
+		debug("DDRPHY: End of write delay center optimization\n");
+		break;
+	case 0x05:
+		debug("DDRPHY: End of 2D read delay/voltage center optimization\n");
+		break;
+	case 0x06:
+		debug("DDRPHY: End of 2D write delay/voltage center optimization\n");
+		break;
+	case 0x09:
+		debug("DDRPHY: End of max read latency training\n");
+		break;
+	case 0x0a:
+		debug("DDRPHY: End of read dq deskew training\n");
+		break;
+	case 0x0b:
+		debug("DDRPHY: Reserved\n");
+		break;
+	case 0x0c:
+		debug("DDRPHY: End of all DB training (MREP/DWL/MRD/MWD complete)\n");
+		break;
+	case 0x0d:
+		debug("DDRPHY: End of CA training\n");
+		break;
+	case 0xfd:
+		debug("DDRPHY: End of MPR read delay center optimization\n");
+		break;
+	case 0xfe:
+		debug("DDRPHY: End of Write leveling coarse delay\n");
+		break;
+	case 0x08: /*printf("DDRPHY: Start streaming message mode\n");*/
+		decode_streaming_message();
+		break;
+	default:
+		printf("DDRPHY: Error, unknown major_message %x\n", mail);
+	}
+}
+
+static int ddrphy_phyinit_wait_done(void)
+{
+	u32 train_st = 0;
+
+	do {
+		train_st = get_mail(0);
+		decode_major_message(train_st);
+	} while (train_st != 0x7 && train_st != 0xff);
+
+	return (train_st == 0x7) ? 0 : -1;
+}
+
+static int verify_comp_crc(uintptr_t fw_base, u32 offset, u32 size,
+			   u32 expected_crc)
+{
+	u32 calculated_crc;
+	const void *data;
+
+	if (size == 0)
+		return 0; /* Empty component is valid */
+
+	data = (const void *)(fw_base + offset);
+	calculated_crc = crc32(0, data, size);
+
+	if (calculated_crc != expected_crc) {
+		printf("ERROR: CRC mismatch at offset 0x%x: calculated=0x%08x, expected=0x%08x\n",
+		       offset, calculated_crc, expected_crc);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int verify_comps(uintptr_t fw_base, struct ddrfw_header *header)
+{
+	int i;
+	int result = 0;
+
+	for (i = 0; i < DDR_COMP_MAX; i++) {
+		u32 offset = header->comps[i].offset;
+		u32 size = header->comps[i].size;
+		u32 expected_crc = header->comps[i].crc32;
+
+		if (size == 0) {
+			printf("Component #%d is empty\n", i);
+			result = -1;
+			continue;
+		}
+
+		if (verify_comp_crc(fw_base, offset, size, expected_crc) != 0) {
+			printf("ERROR: Component #%d CRC verification failed\n",
+			       i);
+			result = -1;
+		} else {
+			debug("Component #%d CRC verified successfully\n", i);
+		}
+	}
+
+	return result;
+}
+
+int ddrfw_parse_fw_header(uintptr_t fw_base, struct ddrfw_header *header)
+{
+	u32 calculated_crc;
+	const void *header_data = (const void *)fw_base;
+
+	memcpy(header, header_data, sizeof(struct ddrfw_header));
+
+	if (header->magic != DDRFW_MAGIC) {
+		printf("ERROR: Invalid firmware magic: 0x%08x (expected 0x%08x)\n",
+		       header->magic, DDRFW_MAGIC);
+		return -1;
+	}
+
+	calculated_crc = crc32(0, header_data, 144);
+	if (calculated_crc != header->header_crc32) {
+		printf("ERROR: Header CRC mismatch: calculated=0x%08x, expected=0x%08x\n",
+		       calculated_crc, header->header_crc32);
+		return -1;
+	}
+
+	if (verify_comps(fw_base, header) != 0) {
+		printf("ERROR: Component verification failed\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+void ddrfw_load_controller_config(uintptr_t fw_base, struct ddrfw_header *fw_header)
+{
+	u32 offset = fw_header->comps[DDR_CTRL_CFG].offset;
+	u32 size = fw_header->comps[DDR_CTRL_CFG].size;
+	u32 num_registers;
+	const u32 *cfg_data;
+	int i;
+
+	num_registers = size / 8; /* Each register is 8 bytes (addr + value) */
+	cfg_data = (const u32 *)(fw_base + offset);
+
+	/* Apply each register configuration */
+	for (i = 0; i < num_registers; i++) {
+		u64 reg_addr = (u64)cfg_data[i * 2];
+		u32 reg_value = cfg_data[i * 2 + 1];
+
+		reg32_write(reg_addr, reg_value);
+
+#if 0 /* Enable for debugging */
+		if (i < 10) {
+			printf("  [%02d] 0x%08x = 0x%08x\n", i, reg_addr, reg_value);
+		}
+#endif
+	}
+}
+
+static inline void load_img_to_apb(u64 file_addr, unsigned long len_bytes,
+				   u64 apb_base)
+{
+	u64 pr_from32 = file_addr;
+	u64 pr_to32 = apb_base;
+	u32 tmp32;
+	unsigned long i;
+
+	for (i = 0; i < len_bytes; i += 4) {
+		tmp32 = reg32_read(pr_from32);
+		ddrphy_apb_wr(pr_to32, (u16)(tmp32 & 0xFFFF));
+		pr_to32 += 1;
+		ddrphy_apb_wr(pr_to32, (u16)((tmp32 >> 16) & 0xFFFF));
+		pr_to32 += 1;
+		pr_from32 += 4;
+	}
+}
+
+void ddrfw_load_phy_cfg(uintptr_t fw_base, struct ddrfw_header *fw_header)
+{
+	int i = 0;
+	u32 comp_offset, comp_size;
+
+	u16 tmp16;
+	u32 from32;
+	u64 to32;
+	u32 to32_le, tmp32_le;
+
+	comp_offset = fw_header->comps[DDR_PHY_CFG].offset;
+	comp_size = fw_header->comps[DDR_PHY_CFG].size;
+
+	debug("Loading DDR PHY configuration (%u bytes)\n", comp_size);
+	from32 = fw_base + comp_offset;
+
+	for (i = 0; i < comp_size;) {
+		memcpy(&to32_le, (void *)(uintptr_t)from32, 4);
+		memcpy(&tmp32_le, (void *)(uintptr_t)(from32 + 4), 4);
+
+		to32 = to32_le;
+		tmp16 = (u16)(tmp32_le & 0xFFFF);
+
+		from32 += 8;
+		i += 8;
+		ddrphy_apb_wr(to32, tmp16);
+	}
+}
+
+int ddrfw_load_train_firmware(uintptr_t fw_base, struct ddrfw_header *fw_header)
+{
+	struct {
+		u64 imem_addr;
+		u64 dmem_addr;
+		u64 imem_len;
+		u64 dmem_len;
+	} fw_info[2] = {
+		{
+			fw_base + fw_header->comps[DDR_PMU_1D_IMEM].offset,
+			fw_base + fw_header->comps[DDR_PMU_1D_DMEM].offset,
+			fw_header->comps[DDR_PMU_1D_IMEM].size,
+			fw_header->comps[DDR_PMU_1D_DMEM].size,
+		},
+		{
+			fw_base + fw_header->comps[DDR_PMU_2D_IMEM].offset,
+			fw_base + fw_header->comps[DDR_PMU_2D_DMEM].offset,
+			fw_header->comps[DDR_PMU_2D_IMEM].size,
+			fw_header->comps[DDR_PMU_2D_DMEM].size,
+		}
+	};
+
+	for (unsigned stage = 0; stage < 2; ++stage) {
+		load_img_to_apb(fw_info[stage].imem_addr,
+				fw_info[stage].imem_len, IMEM_OFFSET_ADDR);
+
+		ddrphy_apb_wr(0xd0000, 0x1);
+		ddrphy_apb_wr(0xd0000, 0x0);
+
+		load_img_to_apb(fw_info[stage].dmem_addr,
+				fw_info[stage].dmem_len, DMEM_OFFSET_ADDR);
+
+		ddrphy_apb_wr(0xd0000, 0x1);
+		ddrphy_apb_wr(0xd0000, 0x1);
+		ddrphy_apb_wr(0xd0099, 0x9);
+		ddrphy_apb_wr(0xd0099, 0x1);
+		ddrphy_apb_wr(0xd0099, 0x0);
+
+		if (ddrphy_phyinit_wait_done() != 0)
+			return -1;
+
+		ddrphy_apb_wr(0xd0099, 0x1);
+		ddrphy_apb_wr(0xd0000, 0x0);
+		ddrphy_apb_wr(0xd0000, 0x1);
+		ddrphy_apb_wr(0xd0000, 0x0);
+	}
+
+	return 0;
+}
+
+void ddrfw_load_pie_image(uintptr_t fw_base, struct ddrfw_header *fw_header)
+{
+	int i = 0;
+	u32 comp_offset, comp_size;
+
+	u16 tmp16;
+	u32 from32;
+	u64 to32;
+	u32 to32_le, tmp32_le;
+
+	comp_offset = fw_header->comps[DDR_PIE_IMAGE].offset;
+	comp_size = fw_header->comps[DDR_PIE_IMAGE].size;
+
+	debug("Loading PIE image (%u bytes)\n", comp_size);
+	from32 = fw_base + comp_offset;
+
+	for (i = 0; i < comp_size;) {
+		memcpy(&to32_le, (void *)(uintptr_t)from32, 4);
+		memcpy(&tmp32_le, (void *)(uintptr_t)(from32 + 4), 4);
+
+		to32 = to32_le;
+		tmp16 = tmp32_le & 0xffff;
+
+		from32 += 8;
+		i += 8;
+		ddrphy_apb_wr(to32, tmp16);
+	}
+}
\ No newline at end of file
diff --git a/board/metanoia/mt5824/lpddr4_init.c b/board/metanoia/mt5824/lpddr4_init.c
new file mode 100644
index 00000000000..a65517793f2
--- /dev/null
+++ b/board/metanoia/mt5824/lpddr4_init.c
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <config.h>
+#include <string.h>
+#include <asm/io.h>
+#include <log.h>
+
+#include "lpddr4.h"
+
+#define RST_DEVRSTREQ 0x1000000c
+#define RST_DEVRSTREQ_DDR_CNTR BIT(17)
+#define RST_DEVRSTREQ_DDR_PCLK BIT(16)
+
+static void ddrctrl_reset(int en)
+{
+	void __iomem *reg = phys_to_virt(RST_DEVRSTREQ);
+	u32 value;
+
+	value = readl(reg);
+
+	if (en)
+		value &= ~(RST_DEVRSTREQ_DDR_CNTR);
+	else
+		value |= (RST_DEVRSTREQ_DDR_CNTR);
+
+	writel(value, reg);
+	return;
+}
+
+static void ddrctrl_step1_s2(uintptr_t fw_base, struct ddrfw_header *fw_header)
+{
+	ddrfw_load_controller_config(fw_base, fw_header);
+}
+
+static int ddrctrl_step4_s7(void)
+{
+	reg32_write(DDRC_RFSHCTL3, reg32_read(DDRC_RFSHCTL3) | 1);
+	reg32_write(DDRC_PWRCTL, reg32_read(DDRC_PWRCTL) & (~(2 | 8)));
+	reg32_write(DDRC_SWCTL, 0);
+	reg32_write(DDRC_DFIMISC, (reg32_read(DDRC_DFIMISC) & 0xfffffffe));
+	reg32_write(DDRC_SWCTL, reg32_read(DDRC_SWCTL) | 0x1);
+	while (reg32_read(DDRC_SWSTAT) != 0x1)
+		;
+	return 0;
+}
+
+static int ddrctrl_step15_s25(void)
+{
+	reg32_write(DDRC_SWCTL, reg32_read(DDRC_SWCTL) & 0xfffffffe);
+	reg32_write(DDRC_DFIMISC, reg32_read(DDRC_DFIMISC) | 0x20);
+	reg32_write(DDRC_SWCTL, reg32_read(DDRC_SWCTL) | 0x1);
+	while (reg32_read(DDRC_SWSTAT) != 0x1)
+		; // poll swstat.sw_done_ack
+	while ((reg32_read(DDRC_DFISTAT) & 1) == 0x0)
+		; // 18. poll dfi_init_complete
+	reg32_write(DDRC_SWCTL, reg32_read(DDRC_SWCTL) & 0xfffffffe);
+	reg32_write(DDRC_DFIMISC, reg32_read(DDRC_DFIMISC) & (~(1 << 5)));
+	reg32_write(DDRC_DFIMISC, reg32_read(DDRC_DFIMISC) | ((1 << 0)));
+	reg32_write(DDRC_PWRCTL, reg32_read(DDRC_PWRCTL) & (~(1 << 5)));
+	reg32_write(DDRC_SWCTL, reg32_read(DDRC_SWCTL) | 0x1);
+	while (reg32_read(DDRC_SWSTAT) != 0x1)
+		;
+	while ((reg32_read(DDRC_STAT) & 0x7) != 1)
+		; // 25. wait operation mode to normal
+	reg32_write(DDRC_RFSHCTL3, reg32_read(DDRC_RFSHCTL3) & 0xffffffffe);
+
+	return 0;
+}
+
+static int ddrphy_training(uintptr_t fw_base, struct ddrfw_header *fw_header)
+{
+	ddrfw_load_phy_cfg(fw_base, fw_header);
+	debug("[PHY-TRAIN] DDR PHY configuration loaded successfully\n");
+
+	/* load the dram training firmware image */
+	if (ddrfw_load_train_firmware(fw_base, fw_header) != 0)
+		return -1;
+	debug("[PHY-TRAIN] PMU training firmware loaded successfully\n");
+
+	ddrfw_load_pie_image(fw_base, fw_header);
+	debug("[PHY-TRAIN] PIE image loaded successfully\n");
+
+	return 0;
+}
+
+int ddrphy_init(uintptr_t fw_base)
+{
+	struct ddrfw_header fw_header;
+
+	if (ddrfw_parse_fw_header(fw_base, &fw_header) != 0) {
+		printf("ERROR: Parsing DDRFW header failed\n");
+		return -1;
+	}
+
+	ddrctrl_reset(0);
+	/* 0. ~ 2. steps for control registers initiali*/
+	ddrctrl_step1_s2(fw_base, &fw_header);
+	/* 3. release soc_rst ddr reset */
+	ddrctrl_reset(1);
+	/* 4.~ 7. steps */
+	ddrctrl_step4_s7();
+	/* 8. ~ 14. steps for PHY training */
+	if (ddrphy_training(fw_base, &fw_header) != 0) {
+		printf("ERROR: DDR PHY training failed\n");
+		return -1;
+	}
+	/* 15. ~ 25. */
+	ddrctrl_step15_s25();
+
+	return 0;
+}
diff --git a/board/metanoia/mt5824/mt5824.c b/board/metanoia/mt5824/mt5824.c
new file mode 100644
index 00000000000..f385de1d897
--- /dev/null
+++ b/board/metanoia/mt5824/mt5824.c
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <log.h>
+#include <asm/csr.h>
+#include <asm/sbi.h>
+#include <config.h>
+#include <cpu_func.h>
+#include <image.h>
+#include <init.h>
+#include <net.h>
+#include <asm/global_data.h>
+#include <linux/io.h>
+#include <fdtdec.h>
+#include <dm.h>
+#include <hang.h>
+#include <misc.h>
+#include <hexdump.h>
+#include <env_internal.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+
+#include "mt5824.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/*
+ * Miscellaneous platform dependent initializations
+ */
+
+enum boot_source get_boot_src(void)
+{
+	void __iomem *reg = phys_to_virt(0x10000018);
+	u8 boot_src = (readl(reg) >> 6) & 0x3;
+
+	return boot_src;
+}
+
+static int bootsrc_env_set(void)
+{
+	char buff[8] = {};
+	int len;
+
+	len = snprintf(buff, sizeof(buff) - 1, "%d", get_boot_src());
+	if (len > 0) {
+		buff[len] = '\0';
+		debug("%s: bootsrc env %s from get_boot_src()\n", __func__,
+		      buff);
+		return env_set("bootsrc", buff);
+	} else {
+		pr_err(" bootsrc env len wrong\n");
+		return -1;
+	}
+}
+
+static int cpu_env_set(void)
+{
+	long csr_marchid = 0;
+	const long mask_64 = 0x8000;
+	const long mask_cpu = 0xff;
+	char cpu_name[10] = {};
+	int len;
+
+	if (IS_ENABLED(CONFIG_RISCV_SMODE))
+		sbi_get_marchid(&csr_marchid);
+	else if (IS_ENABLED(CONFIG_RISCV_MMODE))
+		csr_marchid = csr_read(CSR_MARCHID);
+
+	if (mask_64 & csr_marchid)
+		len = snprintf(cpu_name, sizeof(cpu_name), "ax%lx",
+			       (mask_cpu & csr_marchid));
+	else
+		len = snprintf(cpu_name, sizeof(cpu_name), "a%lx",
+			       (mask_cpu & csr_marchid));
+	if (len <= 0) {
+		pr_err(" cpu env len wrong\n");
+		return -1;
+	}
+	cpu_name[len] = '\0';
+
+	return env_set("cpu", cpu_name);
+}
+
+int misc_init_r(void)
+{
+	bootsrc_env_set();
+
+	return cpu_env_set();
+}
+
+int board_init(void)
+{
+	gd->bd->bi_boot_params = PHYS_SDRAM_0 + 0x400;
+
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
+/*
+ * The first priority of DTB is used build-in (u-boot-spl)
+ * The second priority of DTB is used individual partition (CONFIG_SYS_FDT_BASE) (default)
+ */
+#define MT5824_HW_DTB_ADDRESS 0x68010000
+int board_fdt_blob_setup(void **fdtp)
+{
+	if (IS_ENABLED(CONFIG_OF_SEPARATE) || IS_ENABLED(CONFIG_OF_BOARD)) {
+		if (fdt_magic((uintptr_t)gd->arch.firmware_fdt_addr) ==
+		    FDT_MAGIC) {
+			*fdtp = (void *)(ulong)gd->arch.firmware_fdt_addr;
+
+			return 0;
+		}
+	}
+
+	if (fdt_magic((uintptr_t)gd->fdt_blob) == FDT_MAGIC) {
+		printf("Using DTB from gd->fdt_blob: 0x%lX\n",
+		       (ulong)gd->fdt_blob);
+		*fdtp = (void *)(ulong)gd->fdt_blob;
+		return 0;
+	}
+
+	if (fdt_magic(CONFIG_SYS_FDT_BASE) == FDT_MAGIC) {
+		printf("Using DTB from CONFIG_SYS_FDT_BASE, 0x%X\n",
+		       CONFIG_SYS_FDT_BASE);
+		*fdtp = (void *)CONFIG_SYS_FDT_BASE;
+		return 0;
+	}
+
+	if (fdt_magic(MT5824_HW_DTB_ADDRESS) == FDT_MAGIC) {
+		printf("Using DTB from MT5824_HW_DTB_ADDRESS, 0x%X\n",
+		       MT5824_HW_DTB_ADDRESS);
+		*fdtp = (void *)MT5824_HW_DTB_ADDRESS;
+		return 0;
+	}
+
+	printf("No valid DTB found\n");
+
+	return -EINVAL;
+}
+
+#ifdef CONFIG_BOARD_EARLY_INIT_F
+int board_early_init_f(void)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_BOARD_EARLY_INIT_R
+int board_early_init_r(void)
+{
+	if (!IS_ENABLED(CONFIG_SYS_DCACHE_OFF))
+		enable_caches();
+
+	return 0;
+}
+#endif
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	enum boot_source boot_src = get_boot_src();
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	if ((boot_src == BOOT_SOURCE_SD || boot_src == BOOT_SOURCE_EMMC) &&
+	    IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		return ENVL_MMC;
+	if (boot_src == BOOT_SOURCE_QSPI_NOR &&
+	    IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+		return ENVL_SPI_FLASH;
+	if (boot_src == BOOT_SOURCE_RESERVED &&
+	    IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+		return ENVL_NOWHERE;
+
+	return ENVL_NOWHERE;
+}
diff --git a/board/metanoia/mt5824/mt5824.h b/board/metanoia/mt5824/mt5824.h
new file mode 100644
index 00000000000..67784c71c4a
--- /dev/null
+++ b/board/metanoia/mt5824/mt5824.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#ifndef __METANOIA_MT5824_H__
+#define __METANOIA_MT5824_H__
+
+#include <linux/types.h>
+
+enum boot_source {
+	BOOT_SOURCE_RESERVED = 0,
+	BOOT_SOURCE_QSPI_NOR,
+	BOOT_SOURCE_SD,
+	BOOT_SOURCE_EMMC,
+};
+
+enum boot_source get_boot_src(void);
+
+#endif /* __METANOIA_MT5824_H__ */
diff --git a/board/metanoia/mt5824/mt5824_ddr.c b/board/metanoia/mt5824/mt5824_ddr.c
new file mode 100644
index 00000000000..d2699f61cab
--- /dev/null
+++ b/board/metanoia/mt5824/mt5824_ddr.c
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <config.h>
+#include <mmc.h>
+#include <linux/delay.h>
+#include <asm/io.h>
+
+#include "lpddr4.h"
+#include "mt5824.h"
+#include "mt5824_ddr.h"
+
+static int ddrfw_load(enum boot_source boot_src)
+{
+	int cnt = 0;
+
+	if (boot_src == BOOT_SOURCE_RESERVED)
+		cnt = CFG_DDRFW_LOAD_BUF_SIZE;
+
+	if (cnt <= 0) {
+		printf("DDR/PHY training data not ready\n");
+		return -1;
+	}
+
+	return cnt;
+}
+
+int mt5824_ddr_init(void)
+{
+	enum boot_source boot_src = get_boot_src();
+	u32 tzseccfg0;
+	int ret;
+
+	tzseccfg0 = (readl((void __iomem *)0x10010280) & ~GENMASK(31, 29)) |
+		    (0x1 << 29);
+	writel(tzseccfg0, (void __iomem *)0x10010280);
+
+	ret = ddrfw_load(boot_src);
+	if (ret < 0) {
+		printf("DDRFW load failed\n");
+		return -1;
+	}
+
+	ret = ddrphy_init(CFG_DDRFW_LOAD_BUF_ADDR);
+	if (ret == 0)
+		printf("DDR/PHY initialized successfully\n");
+	else
+		printf("DDR/PHY initialization failed\n");
+
+	return ret;
+}
diff --git a/board/metanoia/mt5824/mt5824_ddr.h b/board/metanoia/mt5824/mt5824_ddr.h
new file mode 100644
index 00000000000..385d62ddd28
--- /dev/null
+++ b/board/metanoia/mt5824/mt5824_ddr.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#ifndef __METANOIA_MT5824_DDR_H__
+#define __METANOIA_MT5824_DDR_H__
+
+int mt5824_ddr_init(void);
+
+#endif /* __METANOIA_MT5824_DDR_H__ */
\ No newline at end of file
diff --git a/board/metanoia/mt5824/mt5824_spl.c b/board/metanoia/mt5824/mt5824_spl.c
new file mode 100644
index 00000000000..f816fee20dd
--- /dev/null
+++ b/board/metanoia/mt5824/mt5824_spl.c
@@ -0,0 +1,141 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Metanoia Communications Inc.,
+ * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#include <config.h>
+#include <hang.h>
+#include <spl.h>
+#include <cpu_func.h>
+#include <mapmem.h>
+#include <hexdump.h>
+#include <asm/cache.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+
+#include "mt5824.h"
+#include "mt5824_ddr.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	enum boot_source boot_src = get_boot_src();
+
+	if ((boot_src == BOOT_SOURCE_SD || boot_src == BOOT_SOURCE_EMMC) &&
+	    IS_ENABLED(CONFIG_SPL_MMC)) {
+		spl_boot_list[0] = BOOT_DEVICE_MMC1;
+	} else if (boot_src == BOOT_SOURCE_QSPI_NOR &&
+		   IS_ENABLED(CONFIG_SPL_NOR_SUPPORT)) {
+		spl_boot_list[0] = BOOT_DEVICE_NOR;
+	} else {
+		spl_boot_list[0] = BOOT_DEVICE_RAM;
+	}
+}
+
+#ifdef CONFIG_SPL_LOAD_FIT
+int board_fit_config_name_match(const char *name)
+{
+	/* boot using first FIT config */
+	return 0;
+}
+#endif
+
+static void set_plic_mode(void)
+{
+	u32 reg_val = 0;
+
+	void __iomem *reg_address = phys_to_virt(0x0c000000);
+
+	reg_val = readl(reg_address + 0x0);
+
+#if BORAD_PLIC_NON_VECTOR
+	reg_val &= ~(0x2);
+#else
+	reg_val |= 0x2;
+#endif
+
+	writel(reg_val, reg_address + 0x0);
+}
+
+void spl_board_init(void)
+{
+	if (!IS_ENABLED(CONFIG_SYS_DCACHE_OFF))
+		enable_caches();
+
+	set_plic_mode();
+}
+
+int spl_board_init_f(void)
+{
+	int ret = 0;
+
+	ret = mt5824_ddr_init();
+
+	return ret;
+}
+
+/* rough 10us delay workaround before mtimer ready */
+static void delay_10us(void)
+{
+	volatile unsigned int i;
+
+	for (i = 0; i < 50; i++)
+		;
+}
+
+void shuttle_pll_fix(void)
+{
+	void __iomem *reg_pll_st1 = phys_to_virt(0x10040008);
+	void __iomem *reg_pll_cr0 = phys_to_virt(0x1004000c);
+	u8 step;
+
+	readl(reg_pll_st1);
+	delay_10us();
+	writel(0x040000C8, reg_pll_cr0);
+	delay_10us();
+	writel(0x440000C8, reg_pll_cr0);
+	delay_10us();
+	writel(0x040000C8, reg_pll_cr0);
+	delay_10us();
+	writel(0x840000C8, reg_pll_cr0);
+	delay_10us();
+	writel(0x840000C8, reg_pll_cr0);
+	delay_10us();
+
+	for (step = 0xc8; step >= 0xb4; step--) {
+		writel(0x84000000 | step, reg_pll_cr0);
+		delay_10us();
+		writel(0xc4000000 | step, reg_pll_cr0);
+		delay_10us();
+		writel(0x84000000 | step, reg_pll_cr0);
+		delay_10us();
+	}
+
+	readl(reg_pll_st1);
+	debug("[PLL/PCLK] change to 900MHz\n");
+
+	return;
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+	void __iomem *reg_deviceid = phys_to_virt(0x10010008);
+
+	ret = spl_early_init();
+	if (ret)
+		panic("spl_early_init() failed: %d\n", ret);
+
+	if (0x28240000 == readl(reg_deviceid))
+		shuttle_pll_fix();
+
+	riscv_cpu_setup();
+
+	preloader_console_init();
+
+	ret = spl_board_init_f();
+	if (ret)
+		panic("spl_board_init_f() failed: %d\n", ret);
+}
diff --git a/configs/mt5824_evb_defconfig b/configs/mt5824_evb_defconfig
new file mode 100644
index 00000000000..74f6ceb2284
--- /dev/null
+++ b/configs/mt5824_evb_defconfig
@@ -0,0 +1,61 @@
+CONFIG_RISCV=y
+CONFIG_RISCV_ANDES=y
+CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_SMODE=y
+
+CONFIG_SPL_SIZE_LIMIT=0x200000
+CONFIG_SPL_PAD_TO=0x0010000
+CONFIG_SPL_MAX_SIZE=0x00010000
+
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_STACK_R_ADDR=0x68100000
+CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0xC0000
+
+CONFIG_SYS_HAS_NONCACHED_MEMORY=y
+CONFIG_TEXT_BASE=0x84000000
+CONFIG_SYS_MALLOC_LEN=0x80000
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_DEFAULT_DEVICE_TREE="mt5824-evb"
+CONFIG_SYS_PROMPT="RISC-V # "
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x40000
+CONFIG_SYS_MALLOC_F_LEN=0x40000
+CONFIG_SPL=y
+CONFIG_SYS_LOAD_ADDR=0x100000
+CONFIG_TARGET_METANOIA_MT5824=y
+# CONFIG_BINMAN_FDT is not set
+CONFIG_DISTRO_DEFAULTS=y
+# CONFIG_AVAILABLE_HARTS is not set
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x68140000
+CONFIG_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x90000000
+CONFIG_SYS_MONITOR_BASE=0x88000000
+CONFIG_BOOTDELAY=3
+CONFIG_MISC_INIT_R=y
+CONFIG_SPL_SYS_MALLOC_SIMPLE=y
+
+CONFIG_SPL_BSS_START_ADDR=0x68018000
+CONFIG_SPL_BSS_MAX_SIZE=0x01000
+CONFIG_SPL_CACHE=y
+CONFIG_SPL_OPENSBI_SCRATCH_OPTIONS=0x0
+CONFIG_SYS_PBSIZE=1050
+CONFIG_SYS_BOOTM_LEN=0x4000000
+
+# CONFIG_WATCHDOG_AUTOSTART is not set
+
+CONFIG_BAUDRATE=115200
+CONFIG_SYS_NS16550=y
+CONFIG_SPL_SYS_NS16550_SERIAL=y
+CONFIG_ENV_IS_NOWHERE=y
+
+CONFIG_SYS_FDT_BASE=0x68010000
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_SBI=y
+CONFIG_LMB_MAX_REGIONS=64
+
+CONFIG_MBEDTLS_LIB=y
+CONFIG_SPL_MBEDTLS_LIB=y
+
+CONFIG_DYNAMIC_CRC_TABLE=y
+CONFIG_SPL_CRC32=y
+
diff --git a/include/configs/mt5824.h b/include/configs/mt5824.h
new file mode 100644
index 00000000000..9809080b805
--- /dev/null
+++ b/include/configs/mt5824.h
@@ -0,0 +1,130 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2026 Metanoia Communication Inc.,
+ * Jun Chang, Metanoia Communication Inc. <jun.chang@metanoia-comm.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+// #include <config.h>
+
+#define RISCV_MMODE_TIMERBASE	0x0c400000
+
+#define RISCV_MMODE_TIMER_FREQ	20000000
+#define RISCV_SMODE_TIMER_FREQ	20000000
+
+/*
+ * CPU and Board Configuration Options
+ */
+
+/*
+ * Miscellaneous configurable options
+ */
+/*
+ * PLIC configurable options
+ */
+#define BORAD_PLIC_NON_VECTOR    1    /* depends on CPU and kernel support */
+/*
+ * Physical Memory Map
+ */
+#define PHYS_SDRAM_0	0x80000000		/* SDRAM Bank #1 */
+#define PHYS_SDRAM_1	\
+	(PHYS_SDRAM_0 + PHYS_SDRAM_0_SIZE)	/* SDRAM Bank #2 */
+#define PHYS_SDRAM_0_SIZE	0x20000000	/* 512 MB */
+#define PHYS_SDRAM_1_SIZE	0x20000000	/* 512 MB */
+#define CFG_SYS_SDRAM_BASE	PHYS_SDRAM_0
+
+/* Init Heap Pointer */
+#define CFG_MALLOC_F_ADDR 0x68180000
+
+/*
+ * Serial console configuration
+ */
+#define CFG_SYS_NS16550_CLK	225000000
+
+
+/* Init Stack Pointer */
+
+/* support JEDEC */
+#define PHYS_FLASH_1			0x10120000	/* BANK 0 */
+#define CFG_SYS_FLASH_BASE		PHYS_FLASH_1
+#define CFG_SYS_FLASH_BANKS_LIST	{ PHYS_FLASH_1, }
+
+/* max number of memory banks */
+/*
+ * There are 4 banks supported for this Controller,
+ * but we have only 1 bank connected to flash on board
+*/
+#define CFG_SYS_FLASH_BANKS_SIZES {0x4000000}
+
+/* max number of sectors on one chip */
+#define CFG_FLASH_SECTOR_SIZE	(0x10000*2)
+
+/* environments */
+
+/* SPI FLASH */
+
+/*
+ * For booting Linux, the board info and command line data
+ * have to be in the first 16 MB of memory, since this is
+ * the maximum mapped by the Linux kernel during initialization.
+ */
+
+/* Initial Memory map for Linux*/
+#define CFG_SYS_BOOTMAPSZ	(64 << 20)
+/* Increase max gunzip size */
+
+/* Support autoboot from RAM (kernel image is loaded via debug port) */
+#define BOOTENV_DEV_NAME_RAM(devtypeu, devtypel, instance) \
+	"ram "
+
+#define BOOTENV_DEV_RAM(devtypeu, devtypel, instance) \
+	"bootcmd_ram=" \
+	"bootm ${fit_addr}\0"
+
+#define BOOTENV_DEV_LEGACY_MMC(devtypeu, devtypel, instance) \
+	"bootcmd_" #devtypel #instance "=" \
+	"setenv mmcdev " #instance"; "\
+	"setenv bootpart " #instance":2 ; "\
+	"run mmcboot\0"
+
+#define BOOTENV_DEV_NAME_LEGACY_MMC(devtypeu, devtypel, instance) \
+	#devtypel #instance " "
+
+#define BOOTENV_DEV_NAME_TFTP(devtypeu, devtypel, instance) \
+	#devtypel " "
+
+#define BOOTENV_DEV_TFTP(devtypeu, devtypel, instance) \
+	"bootcmd_" #devtypel "=" \
+	"tftpboot ${fit_addr} $serverip:fitImage-dev-image-initramfs; " \
+	"bootm ${fit_addr}\0"
+
+/* Enable distro boot */
+#define BOOT_TARGET_DEVICES(func) \
+	func(TFTP, tftp, na) \
+	func(RAM, ram, na)
+
+#include <config_distro_bootcmd.h>
+
+#define CFG_EXTRA_ENV_SETTINGS	\
+	"bootcmd=bootm 90000000\0" \
+	"kernel_addr_r=82000000\0" \
+	"pxefile_addr_r=0x83f00000\0" \
+	"scriptaddr=0x83f00000\0" \
+	"fdt_addr_r=0x68010000\0" \
+	"ramdisk_addr_r=0x83000000\0" \
+	"fit_addr=0x83000000\0" \
+	"initrd_high=0x100000000\0" \
+	BOOTENV
+
+#define COBRA_NOR_FLASH_BASE                         0x20000000
+#define CFG_SYS_UBOOT_BASE	\
+	(COBRA_NOR_FLASH_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#define CFG_DDRFW_MMC_OFFSET			0x300000
+#define CFG_DDRFW_NOR_OFFSET			0x300000
+#define CFG_DDRFW_LOAD_BUF_ADDR			0x70080000
+#define CFG_DDRFW_LOAD_BUF_SIZE			0x80000
+
+#endif /* __CONFIG_H */
-- 
2.43.0

