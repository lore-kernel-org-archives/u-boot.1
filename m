Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2BCD68BDA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 22:35:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1426896F8;
	Fri, 15 Nov 2024 23:35:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytec.com header.i=@phytec.com header.b="DoGTq2tV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E32118922D; Fri, 15 Nov 2024 20:51:23 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::72e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D20189247
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:51:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ggiordano@phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8WMm7mfg/IqqhgY1MAH+QYRjjhyekU2TEaDv4E0CxoEFxxYuPdY0XHcIfKhuqXmRcEH7w0bNWexzzfT/vFIa7C+jZdmiqzU2vFxVgp5MEtPyMHEbext8HUCmvviH4eGblBXM/AxNfGDgrLjVQiL6VXtd0xTgSxMyKtmCiCQigM99LtCGCYb1UhdIVPkrYJOQnT3FruA/4R2ZVmwduPqfQAXm+MYi+ysHcm0UBVMxXIlFnVutIsiY2I7reEr0yKVN6Vry74x4l71IEkrgFhPVTXl+wGYe1qYa6KCmWwm9KU0w9FeEG4pkhJGfIh7x/GqaF6h4uEe410nCgDPa+kiGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiPkystGnNJZyTP/QvZZ+xF8WKyf84nAt5jzyvpniLU=;
 b=H+KBxFKRhhypDl9+JVyq6gKK2e3Zg4MTVjo/49rpXfQAtAWrlC+B1ET8FLP01Azi5IQl1J7dZ3saV8ANuc4p7HWWdmjzolo+ZR4NkZf2k0uxP/0ehREsT/NGuJbKa++X7isGgep7SaBbDcea+jab0s0tcM3rNmGtGhIHM+YaLkw6Z8QAr1y8tsbNOi5zykxWnpYUKxXYJfJERYGC8EoVl6ATZCBIpBRBRnAni4jMwUsSNsM28Nmew3MUB7+m4NvXBMlJiL5NTSsR1p0/P93XbM6hKVVQzQnywp96Gngnp3+3A0c2ohKGrrzBZo2yxNkOBF+GjNGlZyIsMuT+CiUV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiPkystGnNJZyTP/QvZZ+xF8WKyf84nAt5jzyvpniLU=;
 b=DoGTq2tVewzGf5fsI/tx0rk1vJ+QDU2Q6T8Iam6bxDizP4aXmB5rLJgLu1Er3qBgUAOLdt4c6EDu+1G0Jzm6weiElGb4Qj6Oz2V8C4xZWOfUEcbvGVJ4ielf/e3MCVeh9iVG4LbbNRP4B04JBX0QFdWMQ5oniaTKiUpIbWKXA6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by PH7PR22MB3118.namprd22.prod.outlook.com (2603:10b6:510:13e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 19:51:11 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::789c:e41e:1367:383d%5]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 19:51:11 +0000
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
Subject: [PATCH 0/2] Add phyCORE AM62Ax
Date: Fri, 15 Nov 2024 11:50:53 -0800
Message-Id: <20241115195055.3023365-1-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:408:ec::20) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|PH7PR22MB3118:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bcdcb5-94eb-4781-c7af-08dd05aedae1
X-LD-Processed: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jeHCW38Bwsyhe7F26CvnyaoQass51GPA7BR4hmsctQrIEfAI4fZRLNd6L2ob?=
 =?us-ascii?Q?8Kg2F8IKIp0ARHmYTh7wIQt2QEcYzdqbf0UZw7huZngGwQfkNUoRel42j39R?=
 =?us-ascii?Q?vCpujQuPLs3MX7YgBPlZZom+4v114IjRwiT7dszI13uwvIILnKsI6s1IosHS?=
 =?us-ascii?Q?zcWlgzfK8N6tz2Z8lqDdS8PJ2QTJZf77GGETcL6U252DbfW7WBkl6CXYBywZ?=
 =?us-ascii?Q?HSwGsgdrfXcCqGgVLeyegfiYUrcxONZnGDyNzorb8mn+GGca0GOz2QuJq1qw?=
 =?us-ascii?Q?B39OKzp5qHCWMWHJdeVZBXLnE/DPuzRnuR+O1gP5ZTc2BjrDEwzGgLagE2PQ?=
 =?us-ascii?Q?9y2Z9NFYOXbgzShtxcgnlzRn5u4cOF31MfFL6gAsXOPxaW2dJoqTcd8rnzH+?=
 =?us-ascii?Q?IPuDwFzYvrp/DgUM+bv/FlO9OtBCscUxDP+Vm3lgSpWhZaGs/ZqwDBqkFj8A?=
 =?us-ascii?Q?bkewZ53pXNfJU69Yg3D0KnPLc0GsV46Hs/ds+UP7L0kaI0lb7jirUhqSEu7U?=
 =?us-ascii?Q?j4X2BLdtBDD8jurlfV1MEcuLQGDkvf7fZmxgfk++KN91Gr1rdvxoyp/yyOOa?=
 =?us-ascii?Q?sFfH+95B3suFA1oVCLmWTULe4iY2ffCoWf3L5NFMsFwovBtgtUuKGFdEv8tv?=
 =?us-ascii?Q?QFEWlVgKdvPEdtF+7jGQjcXEOmRkWHHFGUUftqsRZ+jzuxRmp/Zj2ISmEoNG?=
 =?us-ascii?Q?ek2jCNzwm2HnNuR5CNEICho7KHZu7n9XZRfqH0jaWUnjmkYAEObmTXuEm+A3?=
 =?us-ascii?Q?NL3zx/WWE6IRJ5JnwIomcoH3Dk7GAvWQUJ+kf2MhyNQuCrVgiYvY+Yb/6R1a?=
 =?us-ascii?Q?rIgWGL9qnZsa46I+AWig+kkW3Na6zxjNJYMfzbCz2PGS04pe0yH+Vrx2R8EP?=
 =?us-ascii?Q?oTlk9dIcH3kFDx/LGtgj7tTCVI9D03bQGAhe8y/i4Fmws3UFZhD1A66AUJ0z?=
 =?us-ascii?Q?1u1FyJKNCkOt4votKUb9TV+ph+9+ISU8WA1HeO68J74kBaeiyP0xLmyS9FLp?=
 =?us-ascii?Q?L5a5ZYw8d16I+aEDepuhuJ0o9gJtdGlwppSdIbcu35ocKLSTdJSPm0Rnp1Jj?=
 =?us-ascii?Q?L5ZRfEfzxdmsKE/uy9qU9d/sr6yqK1Vwnf9muKzMrT5kCawnpMFT+xU7RjOZ?=
 =?us-ascii?Q?da8rUDa4ReDsG1uW0T6+65JmfVkxvs87Z0bsCK+z9vtBNOz13WCD56BiKfJX?=
 =?us-ascii?Q?HxNEz5W1ogf7Ohm3KQOgK8tP0JOtExnJ5X2AHltRkyyNC3YJXKVv3wpMTj/a?=
 =?us-ascii?Q?J1D0ugLztU3LAxE224nWg5gw9plVrd1XYPvApNpoBaZoT6PxBUnL7RN3+8iy?=
 =?us-ascii?Q?9HaHDm1gFd7esPLvhLFnkdxvkEE8GfPQTjSDL6p46+AQgg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR22MB4354.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?28Xz0aT3WJieuXyC4li0+SgCcHpAhq4ty6AAiyQ7Tx11vQbMjUxh4vPrVuo6?=
 =?us-ascii?Q?uPCbGl7oznGjGBParp/KR9B/4QsjmmrXSJVLUISmJ6VZ0Lm2S7xJjHBLvkez?=
 =?us-ascii?Q?B2xXv+o8XUG01dUtYywfO446OKfkVs0WsKEvD4qPUMN82X+x3F4BQxyhYU0Z?=
 =?us-ascii?Q?nXxhHz2nuTkuMVCYRfLnYWcCK/D7degJzKpQbaH+kLu7BzJgnfsJQ38nim2i?=
 =?us-ascii?Q?kU7ZmWJbvZ/BieFRUfEooEPoru4pjkidWE1KJtBiv275FLmRKb3tbcovr4J/?=
 =?us-ascii?Q?aufj2MX4YVmO6ZBjK34PD//+8lhhPkaGfRot7l/gxFDrCMmv8iRWefWqmLWS?=
 =?us-ascii?Q?t/DKs8epDGbP15U18Rto6uJU4RCMphmCdcU6BaeXhMFt5ilPF1Lut94ljxBJ?=
 =?us-ascii?Q?5TRAfgwsO5T2Vep+pfefa3p95BxRyYj9mKVUh7f0UdsvmAhBsN3Tr9n921x0?=
 =?us-ascii?Q?vKlhK0MnnLyXcTDjiquWxpnPj1AJupupnz9zv47QiC9vLTYpcVEYZfqWFYWo?=
 =?us-ascii?Q?0acutyniremSdKX7vv+j4Ti10pn3bgxcZ6381Ovene2KsJbc0H8EBeckJ9sA?=
 =?us-ascii?Q?ds3Xnr/2QIdsMM/eGAwuDLzzuSO0IBASZYKnjw3K/0OMKKvpSNwU9y4YCcJX?=
 =?us-ascii?Q?F3aZ4y2GMr2IJNiiipZSqnjr/Iy4fNSEhOZKBCGO+3ZwiiRtYfU0pKnpVycF?=
 =?us-ascii?Q?I//H09gOpyOsEvPXGpDK1Ba58eyi4ew1J2HVe7xGibTaxFJXKtzmCEIrqaps?=
 =?us-ascii?Q?qUMNGRPn1OrgnOYE93cJwl9D5OLIs63GPY3N+RdLEMM4XSfmn4yc6lmIlkS5?=
 =?us-ascii?Q?cmparwReWJLRe643BXnkyMVApKnTkcNyM4djnJbqaE6KG6YzIf1lArdQ/5/Z?=
 =?us-ascii?Q?R5UJA2yYLIV+5FmE0WMeeUgsBXlwmXRQH4/vmWXtdfzmE7jIK3OZZyftlxHF?=
 =?us-ascii?Q?LyYZ8a9BRsDJRicT2RxWXHHXFQ62x7eAnoVupsHGAfoc2MqBARRmrEQ1H9yR?=
 =?us-ascii?Q?R13n2KilBIRiBvjXmvrkFFkpDDKY9uRcDUIeXiVbqBSPyrS+l7tYoxCZC47L?=
 =?us-ascii?Q?7RNiPm8XXaTf1Uq33B+TscixwGwm5fwfw8DUyaGyCOXiKbvr/Bo5pOLcuWLh?=
 =?us-ascii?Q?CYWARfSDZidpuWFLdCxztYyGktSABxzwlJ09anuKLKUIIHsAqw1cdrSCCIZw?=
 =?us-ascii?Q?odN453ZLxFlgJVDbNLRc7J9OtcP7dfuMkAnd18M7QBAvptUouzepCWfehX+o?=
 =?us-ascii?Q?rD4YpJbplc1oXS+o2tTo/8sOK3xr8eY1b2alhrAsyMwFkX3zWFq+kLcC1EwT?=
 =?us-ascii?Q?9VV2/1q9xRLvjtaQ6DR3MfrdJOn+gsYVDZfZSFw9YJMJ0aSltzgQRLDocoXX?=
 =?us-ascii?Q?0qEzRBNm2S6gvlRpUVZUwDbYNlgPDQs74I04t9v1g0zrz4sQB//24S03CHIb?=
 =?us-ascii?Q?W42D8qqYEr+F2RDXfATkPQRah8t4Og0UH8GIlV5SlEGTMohGmlGHYKCAH1zl?=
 =?us-ascii?Q?aEFkp0GekiltffXNvqJQttKhcHQj9VVhU/heHwgUf8oW/xRn7FLoah+FguKa?=
 =?us-ascii?Q?vh7UjLCR7UXYQnzW2hbPaNfJd8i1/NR3Yo5KI6Ev?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bcdcb5-94eb-4781-c7af-08dd05aedae1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 19:51:11.3977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q1YWmYk0GsSRjjH37/FxZFvtSb0bVhRc4Tx1/g51dHd/N4NjPkmtLUTDaMEGkWTPJSj+n3RFDrBRicNI3RM8IQ==
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

This patch set adds the phyCORE AM62Ax board support and documenation to
u-boot.

The phyCORE-AM62Ax is a SoM (System on Module) featuring TI's AM62Ax SoC. It can
be used in combination with different carrier boards. This module can come
with different sizes and models for DDR, eMMC, SPI NOR Flash and various SoCs
from the AM62x family.

A development Kit, called phyBOARD-Lyra is used as a carrier board reference
design around the AM62x SoM.

This series depends on the following two patches:
- [PATCH v2] arm: mach-k3: am62a7: Provide a way to obtain boot device for non SPL
  https://lists.denx.de/pipermail/u-boot/2024-October/570156.html
- [PATCH] board: phytec: common: Introduce CONFIG_PHYTEC_K3_DDR_PATCH
  https://lists.denx.de/pipermail/u-boot/2024-November/571543.html


Garrett Giordano (2):
  board: phytec: am62a7: Add PHYTEC phyCORE-AM62A7 SoM
  doc: board: phytec: Add phyCORE-AM62ax

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
 doc/board/phytec/index.rst                    |    1 +
 doc/board/phytec/phycore-am62ax.rst           |  161 +
 doc/board/ti/k3.rst                           |    1 +
 include/configs/phycore_am62ax.h              |   15 +
 22 files changed, 6667 insertions(+), 1 deletion(-)
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
 create mode 100644 doc/board/phytec/phycore-am62ax.rst
 create mode 100644 include/configs/phycore_am62ax.h

--
2.25.1

