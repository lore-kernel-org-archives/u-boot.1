Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9878ACD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEDD984825;
	Mon,  8 Jun 2026 09:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tlQkEaxd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3120E8405A; Mon,  8 Jun 2026 03:28:17 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C533183314
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 03:28:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTkdUo9L2h0tQGGUa4zflwX7nXpQvY5TiOhePY2nPRTQD2VVP4EzMBiR+Vwe9mEuDyc1wO1hYoHO2xma7bGELjExiX2ijcspJhFvqc1l2bGWPbt7Z8+1nFEj9w0N/vmK2psLnEdXYzsDfteZ/j/a/H0QcPw8Zfeo6wgeQxEQiG1u/N1rXXPqc6/FTVffy/c1t59t3Ut/KlACVZsL1AtbSUNQD+7M0SyFl/If3EfkubqwEgvcgwYRRhWgl2uuQfd0dLg4hmU3NSYbTOpAPNehTvLCvG+cWVOZlf3e8FWAJBFIRxSig2Ah9qHYujfo9zU4ndtu228rWSJQvF7z1okozA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvEj91GVVwllq41+ijWnFC8s9o0/EHDStUePKcp+Fa0=;
 b=pDnQ0OQRegrShgeR0sf+JYJAATOXO8bN3s8pBYeIZw8Y+qrB1InEQPunLkbABVBl/zha3+bamF+FIyyYl7uhdTe22JJbswcYPyGv2i5aTE54MdvjmQQjiXFFCpvVUjlfTEczVwXTALC7Bc54rWydnUcNhBAoRFBnNWN7j0WSTVx6t6DBwbqnw1w2tFb7Xy5wwZiJk1CAvCi+RZcXgrb04aZmtCS2ohfaeTVxQj3JrLc1+HOc8BDYJKjq8QUVh1qx26GtoSuv5SwwlaGQPA7pFobDaQdXF7tSCL1/sBlsgJkx/db9OFNMjFgROBzqBdU4PAat3JrduxVXhfQtSpKaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvEj91GVVwllq41+ijWnFC8s9o0/EHDStUePKcp+Fa0=;
 b=tlQkEaxdwJm2YmHCRQQVeT4mI5UmqFoYqiw60r2MCmtiSsBjrhy4UBM4PwmBw76NkIa7uzs2jAn5NldqXfywU24R5bBuD//QBiE4hYJBzMwGxKDebvSy/585DpCVXYux9Md7hd64ZmPTbyAUh6+ez3cpwOVB2AV7rZfioxvFh0bTgkaw8S18Fqn2s0obuGbS52Fx1xO/9BoBcreUhYK9MS3AXW4HyMeXQjwRyt6xNq/NWAbTzR9so/Z7P2VE5oWM529R9gcM2uFp5QgYZz6mwoaLy4Mzkc9VizwL4NnXNrBWb9xhWEnmVtDSy05SePo9qq49slG/WKHIb7TA59cSSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by SJ0PR03MB5807.namprd03.prod.outlook.com (2603:10b6:a03:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 01:28:10 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 01:28:10 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v3 0/7] socfpga: n5x: Update Boot Support for N5X
Date: Mon,  8 Jun 2026 09:27:34 +0800
Message-ID: <20260608012741.23760-1-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::13) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|SJ0PR03MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: 78832f04-8eac-4eaf-0fd6-08dec4fd334c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|55112099003|11063799006|3023799007|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: a3vkAy/j/Pyh4YKSPrkM2blTJkcRGKuyElLkkOGAvRT552xiCuRu8dAsFx/6UWG6KNpxOpdVHWcwJL9r0FpVwTGAZne+N1yf9g0TR1eUeC8ijKLF2aPDBstLxrfu/vzTGQuHuNkRWJleibb14wclQVH0YmXwmwtTIiHLHGU9tpP0JpHt66TRnvFXWmU24mz/TSz5kDlvkNaXEPCgszCbquoYamzBj0Jg1m4WsgP1Wfz/LlV6Snp80R/ZaLdwMH6WQmiUHWzfh8w84fvx5CM/a8f9bCZHbeOOA8O8pq8KSpXYIPNx4rd5DMXhenBbxgOgKRsEdfRPvhAhLgRp48SzyD+CSI+xEq6F0TfImKsU+QmajlgYRMvWMbeJ7q44+cZYE/gt0/ebgpXt3sL3r55vjiH3Saz3Jw6qZAUm+4FKhb1N/3Wo2e/onDkJ5amFieQVSRTdYvVBzFJosH8HN3nRXQ8zXeKm+b5Yrk5S/8f6Tmi5O8Jkjo2f+9RvgIl9sVeNe1wFLhWKaWwsVRBFxFq5GhNzJtM4tzTGPawzaoWMXYuuEgr7pCqBlx7KNP0m/Yo2FmuR8rKacd7SqQN1pt9P87jzpqepCGmcZHhbYOg3v+u9vWaAXw94R2vy+OsZbVhC1HK0xANmBGdMnMALbzoosnQ1e8DxO92PIXvnqQas2o5asJ3PTKHdnWZKQiNQwH2U
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(55112099003)(11063799006)(3023799007)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uQpBXa2l+gOKM3aBo88dby/E24dF5lRBQdI3kAHRNBYsvFRDAnuLclFTxAAX?=
 =?us-ascii?Q?ei12UB416vEpD0XtCzH9YWrmJ0kRu29ta46v321ninYhyhqvR7URYgYwJ89o?=
 =?us-ascii?Q?w4l38xAWY5vWZICVtkvJ0CjimlLC8Kf7mgvwlHjLO7vUXUC4YUdsXzEDcnkU?=
 =?us-ascii?Q?3DyWVOt7cTNYU8f26e3VX9fcCMYw2+WW8yQmZWSwvGrAqz8SjlcGViV3MgN+?=
 =?us-ascii?Q?Qv2Eisb7iob/vRUgjgWZzikDUZGv6H1wz1LQCWOZwgVvS8sc1dxpvLiic0zM?=
 =?us-ascii?Q?3y8A8wRIeT5iYt2Vk8C2vPj/CwewUG9K1R1x5hIkNCgoWx97lZ1JyKnrWDFm?=
 =?us-ascii?Q?gl9tZ1vFZsuHdb0GNjIKpIrj1hC77vKeCxg1pM3p7YcJk2JZ4gT4UOI45ks3?=
 =?us-ascii?Q?6p0Yo5zzO/+fDtbeMj4YR1WtN6DSxDwZOoq4vdB1ReLOteg5SypQOM9s/deL?=
 =?us-ascii?Q?9WeGHMY7sIFTGaTRss4XCH9oYMz8cP9nd3MJhHJQ88C3Hg60mfgwKYVbD7r/?=
 =?us-ascii?Q?H9FS1Nwzc9A+XOBB2+NSZvfqu+4Me5Bmcv5rSwgNNR7+pLfrZ+T8O78eOOjB?=
 =?us-ascii?Q?7sk04C3AoBvcstLzIv6DtWe9hSUa1pXqZs6G1SBx9Tgc3wYKovuSCYoXB/F+?=
 =?us-ascii?Q?tzZqmNqbhZ0wYxnvyBn3uXpujpYskoBfLY4luGtlN2Zj4xyyDjVUmC0D6Yiu?=
 =?us-ascii?Q?3J7UdX2pgSK3Ootflm4jkj3MYlBUhxkNaKMYeHEz4r0NIuUZuAyeorKUg+yo?=
 =?us-ascii?Q?4mEdl1JpjmAJOwKP2JlOreDr/RWh5Xk+nYRNFCpatjYOJxQUSp3p/Xw4xQiw?=
 =?us-ascii?Q?51brlrU0f6MgsoKQtPi2fViXKmnRtJI/dUj73mcpd5QhWQz3Jlpqi1fNZEmb?=
 =?us-ascii?Q?8lI1gjBPy+gWAVZOf/uB2q1X4S04vW674CXcMGGFVkIeaUr09PNu3rW0SBnN?=
 =?us-ascii?Q?ve3szfWpMJMAlYfZ7U7sO3fA0YAEJo2XtMpbgoaFlXfzVHnCCCf9ovssVy+6?=
 =?us-ascii?Q?q7W0MBCx/uSEriYln8+fQCtWnjVhmPAEHOIqXJ7HmSQdGGfxvc46Drx7n0RM?=
 =?us-ascii?Q?ve6MSrWzvIgEedcD1SsTqrqU1RV97hhhy4RA71+aDsHpkyATNoZ7XRksgF3O?=
 =?us-ascii?Q?urxcAA6UYu9kVbgEvjw1Q31gj5NLSHp7h5BR79x7OcgKU/08ZgPgUpKE1HFO?=
 =?us-ascii?Q?171dilFH0iVPTO4BTbkeYbI5DIp66Md1g0pqXelYEeffGq5lrkiMmUwkscjE?=
 =?us-ascii?Q?946kxcmJ0aRG2B4G5G2kIoU+EgcU8QCEN3d68+4bIMDwzKyyMWNN7d4fLHIe?=
 =?us-ascii?Q?LGB8xUHMW5+OFdowuxa63PrWMCGQvhfKcBCeB2592C1jf4fW9ldL9y/bjqZk?=
 =?us-ascii?Q?8CTG6nrAJAk1lZxX4wsPhzrRQfjVa9/bdyGjLov/89jWiD99I6H+xF8WZrQg?=
 =?us-ascii?Q?Z2e3fEbrqvkvIRaPDufZ5sj0p0C7OQm+RpYx9EgJtmSgSiSs+xSlUBPsU/tW?=
 =?us-ascii?Q?QNjTsnH54gCoKHQUgPbBAnGqh2owHMxU6m4fqQLiwpThHTIog3KcX6o/GFYG?=
 =?us-ascii?Q?+Owsf8MLEjj4b3fO8I+1siH5pTtDJGiSERLe7jKgn/pHhN477nOva1kW5SlB?=
 =?us-ascii?Q?YfaT++Sp3dNLDcdFzfLdkKxvNzE12fzkYGMKWsm7YpeKnexaAUKqZ3P7dkZI?=
 =?us-ascii?Q?46hPInQYMo92pKUWqBYF2ayQVS9a2Bzp5O6g7B5rBJHOMLcRHT7JXLxKzqTr?=
 =?us-ascii?Q?Vc2iBLjCgQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78832f04-8eac-4eaf-0fd6-08dec4fd334c
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 01:28:10.3195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4xSGBe1btQz2I9fDzGxzIdXNo85fQbQ6NlMG/nEysFataYHbVL4pV1Jj1q59hVaBsJaD3BVaPVuQaSYDOSv+OR9iksXoeItx6z5TnYJYyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5807
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:15 +0200
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

This patch series updates the N5X platform support:
- Consolidate ATF defconfig and simplify VAB defconfig
- Update GMAC nodes and DT register settings
- Enable CMD_MTD for MTD operations from the U-Boot shell
- Enable ISSI SPI flash support
- Migrate firewall setup to driver model and remove legacy code
- Switch to upstream Linux DT configuration
- Update SPL data save and restore implementation

Tested-on: Intel SoCFPGA N5X SoCDK hardware.

Note: This series depends on a concurrent patch series by Alif Zakuan
Yuslaimi that removes the final firewall_setup() call in spl_s10.c.
Please apply that series before this one. See the latest version at:
https://patchwork.ozlabs.org/project/uboot/cover/20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com/

v2->v3:
--------
- Drop patch 4/8 (enable required configs for DDR retention): moved
  to a separate series for DDR retention support
- Patch 3: Fix CONFIG_CMD_MTD position in defconfig (between CMD_MMC
  and CMD_SPI per canonical savedefconfig ordering); drop
  CONFIG_SPL_ALTERA_SDRAM (auto-selected by Kconfig for N5X)
- Patch 4 (was 5/8): Fix CONFIG_SPI_FLASH_ISSI position in defconfig
  (before CONFIG_SPI_FLASH_SPANSION per canonical savedefconfig order)
- Patch 5 (was 6/8): Extend to fully remove firewall_setup(): delete
  firewall.c, remove firewall.o from Makefile, remove declaration and
  unused struct/macro definitions from firewall.h, drop stale include
  from spl_n5x.c
- Patch 6 (was 7/8): Fix CONFIG_OF_UPSTREAM position in defconfig
  (after CONFIG_CMD_FS_GENERIC per canonical savedefconfig ordering)

v1->v2:
--------
- Fix patch series submission
- Clean up redundant DTS override

History:
--------
[v1] https://patchwork.ozlabs.org/project/uboot/cover/20260318030034.25889-1-chen.huei.lok@altera.com/
[v2] https://patchwork.ozlabs.org/project/uboot/cover/20260428070017.16807-1-chen.huei.lok@altera.com/

Chen Huei Lok (7):
  configs: socfpga: n5x: consolidate ATF defconfig and simplify VAB
  arm: dts: socfpga: n5x: update GMAC nodes and DT register settings
  configs: socfpga: n5x: enable CMD_MTD
  configs: socfpga: n5x: enable ISSI QSPI
  arm: socfpga: n5x: switch firewall setup to driver model
  arch: arm: dts: n5x: switch to using upstream Linux DT config
  arm: socfpga: n5x: update SPL data save and restore implementation

 arch/arm/dts/Makefile                         |   3 +-
 arch/arm/dts/socfpga_n5x-u-boot.dtsi          |  55 ++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi    |  18 +--
 arch/arm/mach-socfpga/Makefile                |   1 -
 arch/arm/mach-socfpga/firewall.c              | 107 ------------------
 arch/arm/mach-socfpga/include/mach/firewall.h |  69 -----------
 arch/arm/mach-socfpga/spl_n5x.c               |  31 ++++-
 configs/socfpga_n5x_atf_defconfig             |  89 ---------------
 configs/socfpga_n5x_defconfig                 |  26 +++--
 configs/socfpga_n5x_vab_defconfig             |  90 +--------------
 10 files changed, 112 insertions(+), 377 deletions(-)
 delete mode 100644 arch/arm/mach-socfpga/firewall.c
 delete mode 100644 configs/socfpga_n5x_atf_defconfig

--
2.43.7

