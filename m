Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC0E9D1CA19
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 03:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C85488F68;
	Tue,  5 Nov 2024 04:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8FD88ECC; Tue,  5 Nov 2024 04:45:00 +0100 (CET)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070b.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF3288ECC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 04:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0PY5bnl9boeQfbJUolwM3buYnbnwY6tYDGOvl+aThXEF3h3JKV6+GXsZl68B3g+FIKpYmgN+vduamTDDdlVGcgGZNOPefGB/zt6so5b10+XgZFQoaEUwTQ+D7ZM/ifjyaowEIZ+RLZSckkiPbuJcm3jDe3AGr65fCiUfO9O2WYqoJ/pUa2iExo8p5HGVtFxX0AmJ7M/lUhoVkuEzDcVnN7p65CohcK/Y9zCfD1l42nVvAFmMEOxMh4uLNx48/RF76QWn2HUId1pKWJ0Gr/OFnnLS1YwQIuzOYmSAGrdNaVHsZSo1nhbnjYUmBlycH8H/2Ol4ibPb/IPtApf5YHFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcVCPKAGUHHlbZYwNmi8bBMIqgD2Nh+w3ubGJ6bN/6s=;
 b=C2TyVNR98JH6/bqW29eiOYYbin603EP2TCLKagQZXACvRuTk90Ic5mtUBJPduZo1CwYB9MtjhD7AkmjBow01b2BH9uGNgBZXuLPlwQtPiLL1sM3j2SmG6X26vVaIGOYKzTw3RZx0KEuWqmHJVmVKiOQi7JO/V6b0W3IkhePRIgMOA+3J+hUWNRWDyQM1JbJZvVaMGnMl+Fmn0PFdWGCPLne6Q6V05kWR0+nOgVeCogP5Oh5t8ZpX93ycC22JiyLe9SxRTR+TnnzXhRpXL9vT7VtUmH7ZZBIii571BGWi0oKRF/A+FvvfW/9uMMdFvXVcjhKKyO6vI3CIl0EHmQaK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1145.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 03:45:03 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%7]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 03:45:03 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>,
 E Shattow <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>,
 Nam Cao <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, u-boot@lists.denx.de
Subject: [PATCH v3 00/13] Support OF_UPSTREAM for StarFive JH7110
Date: Tue,  5 Nov 2024 11:43:15 +0800
Message-ID: <20241105034328.56439-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0021.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1145:EE_
X-MS-Office365-Filtering-Correlation-Id: e2b60584-e687-408e-280e-08dcfd4c3b03
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|41320700013|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info: oBpIjKCDxXZbYigh0zPE5PGw9RTP0Vk3Cm6pJkeJ1nW7FLWxIHPWrufZJoKRsK+zQTOS1dhjiGbr4gWGDYCCR3g8LUmAtDMFd5ubzLuwhQnLn3NIxbrSwOHyt/htAhEf2pqkDSyb24L8Dg7W4RHG9TAoTYhy1B9a6EY+pk7YM0HDqnpRo+x5x3Faj7Bj6HEzkTuWcf1c4IEQ13A6+a9P6LE4LAljD1+H7VMZjOemwOiXqu8HxxSvwfPe/o8S9x3fTLfswisT034pbpBCjNuePFuzOaZSiXFsWIpIq3omVFFByUO6PLpAGs8mew1NZYSxoyaAX8Gyz9u8H1z4BzL5fC7ZZzOMAeShG7xGKDPxROJA4Ukz0fUW8110m3rArBjE/lhT9AObzgFjahXEmHor2zPBDHNOVvfOTv4eKB+N5l+Gj6KcmIu4dH52OAj11dV/GQP/m+vxmLp3x+hoBTKUr56BZmyXN2rlXMcdM6FAeINXmwzmX1dCuZhN2mK9DXi7z9s/oS2vakxD6rJLZPxNSazAY/f2Xz52Hm86GKItfcb/roHSM1dS/KjgduhaYyQHeOFn6ngOdVDKuOPuDP/hJVhxQjYSa9KdarGO6x6wOjo0YE4WjLyWqWDKbuOmvO4DCxyeZ1Vzwt+6qwwK6gZ+9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(41320700013)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enY85uMp6hAswSwj8uyATHaBgkwEgi6uX6584dh1Vf/xDvE7xPE5lzrQiVON?=
 =?us-ascii?Q?EaDqdasE3avzF8iC0sKIR9vARxgpr6SFqySFGUtOwuUUofNdgTGU05sap42y?=
 =?us-ascii?Q?k10dCN7Tr1kgLOCDA5FqEQ/kZbGbMOF67oWV/JGVQbEddpH1peTNu050l3vK?=
 =?us-ascii?Q?VJ/FKnGxHnC+iigiAzpoFGiANMYfH3vTKMcXb7amZmlIicD5574l+RWz0CJ6?=
 =?us-ascii?Q?VXrKhwaQkVSY2aC9++7CyvFXr8ym4EVcmN/iczyJnlFuMXd4XiurCXE/MNWv?=
 =?us-ascii?Q?HkX0qGc/3owkLA29M6e7O2OFQLXLwGJ+sqxE5fZIPffEP19SJ6Td2RLP8OzP?=
 =?us-ascii?Q?EEAnlZ71YyjV2Ri3tj4Yn3oMTWASvZ/HlwL+sq+swhofJexHGvKmmTnJQ+nu?=
 =?us-ascii?Q?1O5dvKisLWCGeDCKzQfrlDnYdkdSCY4+7SLdgn3WnqKVaPaxO08b7ZlB1wQa?=
 =?us-ascii?Q?KTPnErbCv8cksQe6eyhXJAYYKrWi6LJvMnahX7js7f8CQioLrgTLSYvXY9uW?=
 =?us-ascii?Q?VD4w3T9A/H4qU+L/qzhKpkoiSYeZqjFHEZvivmKNpMKUTOpY0YYwFhzHkNMy?=
 =?us-ascii?Q?wjnynwNDAfqVZ35r9Q33JUbGZf+csEWifpGvlZL+eF9Xpag5jHvmhErY8Qlv?=
 =?us-ascii?Q?SOrl58b+sVbydYIF+I+ue5qnAy3RZqjuet16WzaRpUsHAIYVFnyLZaF2qQhl?=
 =?us-ascii?Q?nwuqzjLThO4LOFfkLPOJHte1KPyqo8gjSaP2OfCe27dxXJENYA0ZiLHMo0ws?=
 =?us-ascii?Q?SkThKJv+QqhhzetXDac4+n7WPPQyscqSMIdnuQdsjMxaht9TpscQO7eXzkRW?=
 =?us-ascii?Q?46mT8gXADA901ar3fCZa6j8bNBbOcIS2nLbiguIZwIjjclXF6a062x9NN1bV?=
 =?us-ascii?Q?vWovbmvIoD3/7lzGlqQ7Pe42EZ6AiSVsZbc+Lm6L3T9EO9BOfO+d2xnjGaZP?=
 =?us-ascii?Q?y1j2pK4iXMHcQ+nmmUH7FBMe9XhlQuXjlb65rMGY/p5YM41C9e3qOPJ/8JxD?=
 =?us-ascii?Q?CMTanFW9LOhKqvcqhdHBQs5KALuUETqe0y2ArffP03zLG/o7bmli+xqXf5oC?=
 =?us-ascii?Q?pl12IGnL8fEEiZ55BYuSQxsrawu1yjcKeqNC48+SljSSrc0E6i2ketnleF+c?=
 =?us-ascii?Q?pJBSUyqIgwbZbe/qYh5snT1bSVBfTcbhllU+nFcAuk/kbYZWIzkjYw47aErF?=
 =?us-ascii?Q?Bk8dP1lKXcuP/vcYb5NvfcEjqXK8s5JwMC3VpzQxabumz/AECljCXqvDSS1V?=
 =?us-ascii?Q?5o+7rhV3A4DeRlYb4HwFMxzbe5tZAmdR073TU7Bm1w3QjT48IFfM9hE2r5kP?=
 =?us-ascii?Q?sONQCWjVbutJgOM9AIT+POSh++uDMb27ja5HG+pTDosG89N+WT+ENJX/NFD8?=
 =?us-ascii?Q?+QDN8JZZPwi8ZLzxabV69H5auvZP60PjxRudRU+nTmHGuhwSl7wHlv5xxhft?=
 =?us-ascii?Q?9lS0djP2H7IJC8KvYd55ZoNKBghahEYrWMkD3a1mT6A6GWO6y8qenx64ZG7A?=
 =?us-ascii?Q?83d88bMhMGy0y/KHtDpPtBYspeXMRcmtDtuIw0PRaJ8dn5hpAv7b1l15wjiz?=
 =?us-ascii?Q?ojRESfNxCyC9FLoUL9olTF9epRDE8SzrSUKbWJMxvsgXwB+azHuSAganQa7R?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b60584-e687-408e-280e-08dcfd4c3b03
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 03:45:03.1452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1uomYdoZcNcVllujzT4HAQ7T5asvjmrxLQTYX4S30xDseTc5VFZEbhBOjfEwZvTqW9kIkciSHKmLXrODKKgVtdNZPNvfzuXkiAdRMc1IJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1145
X-Mailman-Approved-At: Tue, 05 Nov 2024 04:45:33 +0100
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

This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
All the JH7110 based boards can use the DT from upstreaming linux kernel.
The v1.3b board device tree is set as the default device tree. Support
CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
EEPROM information.

Changes since v2:
- Drop patch 1, because the riscv of_upstream Makefile is created by Conor
  in commit 239e4705099c.
- Drop phy0 rx delay for milkv u-boot dtsi in patch 9.
- Add a Fixes tag for patch 13.
- In patch 14, the PCB version is only obtained when the product_id is
  VF7110. Improve the commit messages.

Changes since v1:
- Drop patch 12.
- Modify patch 11 and add three new patches to support
  CONFIG_MULTI_DTB_FIT. The SPL selects the correct U-Boot dtb using the
  EEPROM information.

History:
v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivetech.com/
v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfivetech.com/

Hal Feng (13):
  dts: starfive: Switch to using upstream DT
  riscv: dts: jh7110: Drop redundant devicetree files
  dt-bindings: Remove StarFive JH7110 clock and reset definitions
  riscv: dts: jh7110: Make u-boot device trees adapting to upstream DT
  clk: starfive: jh7110: Sync clock definitions with upstream
    dt-bindings
  pcie: starfive: Make the driver compatible with upstream DT
  riscv: dts: jh7110: Move common code to the new
    jh7110-common-u-boot.dtsi
  riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
  board: starfive: spl: Drop the unneeded DT modification code
  configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board DT
  riscv: dts: jh7110: Support multiple DTBs in a Fit image
  board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
  board: starfive: spl: Support multiple DTBs for JH7110 based boards

 arch/riscv/cpu/jh7110/Kconfig                 |   1 +
 arch/riscv/dts/Makefile                       |   1 -
 arch/riscv/dts/jh7110-common-u-boot.dtsi      | 204 +++++
 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi  |  10 +
 .../dts/jh7110-pine64-star64-u-boot.dtsi      |   6 +
 .../jh7110-starfive-visionfive-2-u-boot.dtsi  | 117 ---
 ...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |   6 +
 ...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |  14 +
 .../dts/jh7110-starfive-visionfive-2.dts      |  11 -
 .../dts/jh7110-starfive-visionfive-2.dtsi     | 380 ---------
 arch/riscv/dts/jh7110-u-boot.dtsi             |  36 +-
 arch/riscv/dts/jh7110.dtsi                    | 761 ------------------
 board/starfive/visionfive2/spl.c              | 383 +--------
 configs/starfive_visionfive2_defconfig        |   4 +-
 drivers/clk/starfive/clk-jh7110-pll.c         |   6 +-
 drivers/clk/starfive/clk-jh7110.c             |  44 +-
 drivers/pci/pcie_starfive_jh7110.c            |  59 +-
 .../dt-bindings/clock/starfive,jh7110-crg.h   | 258 ------
 .../dt-bindings/reset/starfive,jh7110-crg.h   | 183 -----
 19 files changed, 358 insertions(+), 2126 deletions(-)
 create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2a-u-boot.dtsi
 create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3b-u-boot.dtsi
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
 delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
 delete mode 100644 arch/riscv/dts/jh7110.dtsi
 delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
 delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h


base-commit: 56accc56b9aab87ef4809ccc588e1257969cd271
-- 
2.43.2

