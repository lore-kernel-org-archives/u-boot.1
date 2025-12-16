Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960D8D5C0C2
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 08:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5DA833C6;
	Tue, 16 Dec 2025 09:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hoo5QE4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20148800D0; Tue, 16 Dec 2025 09:46:33 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBE0800D0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHkTtBwmSatGSkF70DnCc8Rv2CrdUYFYk592V/VuJYrd41sjAtJ6bxM8xG6/l5BoYR1J7wQ0q0Gb+Ve9ar14dD++pOEUSwJf/vLniukI5xw+sH7dv1SPcJn42BrNFME3puTsExQRstaXZ4xlPCgMYfPSaHXdvb+LFjGPFUacLVHEjw7/uz+GL/rdN1n1LGFPtca4CgjeqADvii5lVltrGg6aKmwkFcnm+21Td2+KQpeEkaIA3NUMGmCaJkUOSQBHsWF/gdRQyKv2+vMWPrq3A7JIz9bndLiRSAK5nshHGcE1eSYz5WDLvBhCGJSg3pp5J5bcl2L92y2omB1T2gnUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c11/Qx3n0WStU7MC3PFt4WdxozJxhEE9qiXIsblIUhA=;
 b=VPtjMtWanM1HWRhEkByBR8ipSN8oT67m6E8DkW+WYAUfeiZHxOKPKrNNEbZgC4qa4+Li/VZ0ax9OU/FsmjldKMHOtbO8gS5drlta8gYYLgqUXMh7MpnEF5YQPwvgnHZDOuZDhImlu405ck9ELRTJ5f/SCNgMI5UgvzLUPdjxEOYmlBd/d9h4VJlGyuhDGwA5ooag3NTczd9hMgz9oK4nmNXP9Ev9D9ORU+PHRlLMNaqhCaRCrFpPkKlkhthJde1vRUJ087ZHHibsn+J28bfb2pOaL3mtv8FjW5XrPSPqB7T6pP8lfowXHc7DTk9RvW52iX85+RhU08/DWKLq9P57Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c11/Qx3n0WStU7MC3PFt4WdxozJxhEE9qiXIsblIUhA=;
 b=hoo5QE4+MC9K5zpZKbJQaNN6j/5e9utGz6WNWdOJF4SQcj/pYJPqcagHVlQtNKHXkk0/SXxqTPkjTRHiMMMVXBenZTSFniWB6JZOiy7YcqMFrbfJUckaqk5baKIRAnd7kGfxN1s4p1LyZx9o5/TT6Y3/vrdhdCBXtFdb+OznN26dOY/aZgA/zx2Qr0AQrf6KAzQcw3E63MKl9Kdfm44teTXq71+tQ5+lAjcKfXIHCuu/0KRmEqu8yb5F+Ax2Vh31TGcOcrKCDsqdomjfGCNQLulenzi1hb85ef3ccJwev1JM1MkQ25fPwaz8vuPAe8DJuR8QhPIf3nDABEa4i+f+vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DM6PR03MB5081.namprd03.prod.outlook.com (2603:10b6:5:1f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 08:46:28 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%6]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 08:46:28 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Brian Sune <briansune@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 0/5] SoCFPGA: Update DDR Support for Gen5/Arria10 in U-Boot
Date: Tue, 16 Dec 2025 00:46:18 -0800
Message-ID: <20251216084623.19589-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|DM6PR03MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: e0828c99-0e4f-416d-7d9a-08de3c7f9a0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FMbr5HJGp9QUQzF7nJonR6FDTeiEhI7cAP6NfE/QdCG0J0wxNYlfU21TK1mN?=
 =?us-ascii?Q?FYPVSX6uUfpK4sDj3JNBX3HJno2RpkF87tssXk61+zREknfcIwhTTeqHRMwB?=
 =?us-ascii?Q?HxndXhfg/Q+1feHXCjhcY21yO33GKwokHTkVdqgCxal6FPN01MSKee4L/1Sw?=
 =?us-ascii?Q?jnLgVmavwKamUh9F2k3YxNIOqjh8KFqMN2ZjCgCTWTVFmmDFjIZ4q7O/u1cC?=
 =?us-ascii?Q?iNFLbf/5C4AweErMWRXHS86ZaSa2VrJ8zor6Wzvg3ggoqUkbrkkRyPhkzpGl?=
 =?us-ascii?Q?qODWpsr13Sg2fQI5SzVfBhuBkDnB03NEUsFGww3clbWCcdgsHGB3IQZMbWNf?=
 =?us-ascii?Q?tYdJ+SidIztRbI54fbBtFdUIoevSAdnjVfq5gpdTrYY5vesOPs7pa99XieUc?=
 =?us-ascii?Q?v1wBB+6QUkcnUNvRTzuVscL40Q4kJ0zC5jH3RCHga5vsrR7HDdIpf5p3cPDa?=
 =?us-ascii?Q?vPOHzbzuBEw9X0bcv6QWXH7hIhQnbrfIrPOABKXEagWLB33pu8ycdEc231e4?=
 =?us-ascii?Q?CXOnKyakeQJ18aXLjocRbYgAbzoLYzZtJhDMhobp1LYOae18r0hb946g/YSo?=
 =?us-ascii?Q?832yassjXZMFeDexGw7tpHP4gnjZgUoPsFg5/Eb5VpjhZJuHPASUteR+1nOg?=
 =?us-ascii?Q?fiFCq7eV/6cqKxTJ8WKmAZF6xH27S8MWdsSo0nC5WFWit65FCezv61Y1oa6a?=
 =?us-ascii?Q?lf3UppAkGgPCBqn9CxD1QDX1aENfD2SyJ6c0/VtZWl+HDpwaBeVs37wWRlGU?=
 =?us-ascii?Q?q5J158Du6TdASgHxIBVDg4+i2+p0FfMzuYJYM+6ElB2sTK93/Cd/6Vkjghvm?=
 =?us-ascii?Q?JbvOeUpunzUdC3qkMRII0GRm2H2wtKb6UQ08MAfJ5Xj67jIUn9HF0rDUA2hA?=
 =?us-ascii?Q?57ClssiBxYVKcYKdXc/wYsR5mi1ywBN5pgb7K6plI8vIGVU1A3AdCKRUjHO0?=
 =?us-ascii?Q?QfhT2Hk0kvUZ2srn++p+dsQB2cSRNIhHLScbBjoFd9iEl+jn9Q5KRy56lV2t?=
 =?us-ascii?Q?1TBVSUgCrzofLMw5aukmM1qiGpn17+xt6h6M+cTeIFTLPSjEBq58jgk7i3e2?=
 =?us-ascii?Q?5sS/M2DpfLyzj4j9PPYSIeMRq54c0P1GajbUIJaHY07PKwxuGy0SR3zbV6/6?=
 =?us-ascii?Q?jc8pb/Ww60/ojaWaJ3w+rnI6xTHrioxZjiKpdSp+lQqTNmWVtgCnV8+Pzubl?=
 =?us-ascii?Q?TBAoNtbJwYz3nDtst7hVaIV9c8bHYWMWFBo6oV3TMPuWDqsRxfkZRql2esSC?=
 =?us-ascii?Q?Ay72ZnIEbfG2xU84/aPsUMbNbwUUBxst7Ia0UkxB2iSLO5Owvl2bOxDYaweg?=
 =?us-ascii?Q?kQAPcx8j10c4xORZA7+lTcUnWfap0a8/T+itu90GY/ZMp90ASY8YeK9kaUOP?=
 =?us-ascii?Q?c61nQvwxEsdQpfE/SxwWbro966bPMojSq7mkdWLTqnQ00bXALq/pMvcHhlGQ?=
 =?us-ascii?Q?oh7K47b0HcmlnIqW4aL9RDLHPMLKFA8Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9+kOhrdukDUTKxEp/QhoFtKCprq7J/fTMDQMZHAXIzYBkJuhBWcLr8eRjBat?=
 =?us-ascii?Q?TUA36TQ67CSZei9O95eVjtyXKHpl7azDMWqgk2aHpbQmRAtvkn76aIktZ8le?=
 =?us-ascii?Q?9iTpG4Vxhf47GTy4WgWJGdLghMRNiCFYJFW6loRnYRac/qzrIGQwi3XxhV9v?=
 =?us-ascii?Q?jkUZiKYyxv6uMXQGOQ0xtV0JIY4SPNizzFWXXePXqtbh6xJ2SfkEH1X8c9Bk?=
 =?us-ascii?Q?uOuX3XN80eKCi27nk4zr1yK5DQzW70MSOMojRfFtKqBSKa6S3PckeMJEgVA8?=
 =?us-ascii?Q?HPwBAj6dF0ntADX+Kvpi5sz2E5UGF/fDUojN+v67WPQitpF6913/EL65l37A?=
 =?us-ascii?Q?H1y3OmqXwcDTshlya0JJK25b7tXE90PEGgQpcI1O+hbVvB/aLyt21KGeZGVE?=
 =?us-ascii?Q?THQyAuuTOMBI91WI0Bw+wwk8K3A2F4fZZoSHKhC0jX8W1MNbsh/aiUf4uO3z?=
 =?us-ascii?Q?CAzE9k0OrXKzFHOF43Yz5DVmQ+x/EAd1GUJ1oliPvcDpxoK9HomiyJ9milJE?=
 =?us-ascii?Q?LOsBh2RwVqEbAiHRH0j/DYT496WtJexl5I3rBiiCpoiiQG8SSPwhnbd83SbJ?=
 =?us-ascii?Q?NhKfvmK3Sdbm21728Klwdlnp9WAbK6oIVMAiEZTpFbCcngDpB8DYCWS8LJTN?=
 =?us-ascii?Q?GBfA/mrgAUFulFWZkmJkcmsvH1HgBcX1ZrMVCoa99FsxRf0U7ix3C9Qtk3hq?=
 =?us-ascii?Q?l8YEod35KlxU0YJp41KEf27UcDHl3BghH35AAc9RPdolQ2E0MVPboKzzy0vz?=
 =?us-ascii?Q?i7e3v0ESFd+ajfzoFj84HhqXeVeLn6NHCmX4CO5ir7O7GNhcUEY2sp/Pok9G?=
 =?us-ascii?Q?06NyzntSjIvqda4xKo7mdaciKD7LkhEOwC7GKAUAarsOOFURwGhkE6efHv7X?=
 =?us-ascii?Q?iyVTQT/H/rAX4+28Dzm3XxHr3fb3UJ0vHLGQOr/fQIWhVFdgfgJiwn3dPVwD?=
 =?us-ascii?Q?zATobrkSRgxGmpIKjYkgTkQQAO/VGnnBtC+vtPbgkwdwuaEIxRPZ30PAc/5A?=
 =?us-ascii?Q?IBUvvEVRWmrilPN86xqVBbuSGQbIW8fEimcylbNeg9mmeLtiUNTwGf0a8XCG?=
 =?us-ascii?Q?jlFoET+5F3DeVmBrWG8HdsoB1X3aEHaTBEkyyqrFUdPsBls2/a1Lj8QpLKlO?=
 =?us-ascii?Q?NobAkFx8Fd2oROp0CAWDloa6ZriJSH5I2v2Rkgve0wMT5YshYPwHVVhTaCae?=
 =?us-ascii?Q?ylp50hnlZNc0R6FvGdXI7lSp9Wo3pnM47l0C8hHtPhmdPPW2VVaz3zwV9xMe?=
 =?us-ascii?Q?MwmkYojY3/TsoFO7FYintIe4Oowh2Sm7kCVbaPw+W+dcnmzuW3AcSXRp7dZm?=
 =?us-ascii?Q?zyWwf5sfPOxzYs0aVSLTtq/hkhJPspiElopSzX+fRQJ5aCxsr4hlFf88XWlb?=
 =?us-ascii?Q?ylgC4z1BbUgOoQwTYfsC3Ir7Iv2QfMXjL1VIHabUZg/FVc0aV8Mj8+CS4KnG?=
 =?us-ascii?Q?MkeEXDhG1y4GxODkqPctpsK3vGYbUI78qt01VCY9vsnSoY9lYCzpUynMJDc2?=
 =?us-ascii?Q?xQAjAEsm5x4rqEI4UVinXOdYEnk6ADwj1J/AwkPNOpMzwOo+ADEfyk1vmbd4?=
 =?us-ascii?Q?CRX8TolCJYSXtU3f2Sdke0I9TnSzh5uwa5WHdzcUiMIUHF2CidoCuvzNLoK3?=
 =?us-ascii?Q?XOGp5RDciB41JJuEm3eUmJOHmkNKMmen8SrSasRn3ndU4DymoI8VAU4agaaC?=
 =?us-ascii?Q?mIx6D4VP7BLP4WXcxJQd5QyRldHG8Rck59AkIOTBJ7q++6l0AiHjYhsgAOep?=
 =?us-ascii?Q?IMHJUhxA2trLE2yUuFRyCC05zSlTeLo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0828c99-0e4f-416d-7d9a-08de3c7f9a0f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 08:46:27.7470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PWA/0hUHXdVEX5OVnpdoW9KpdYthiUVKwf+Jn2U3P/RFNJmKdjQ4vPUx3dejNEsCa4IWzgTJAlf3+EKFmB7fWHPaQvmTs3keot7v5075z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5081
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

This patch set updates the boot support for the Altera SoCFPGA Gen5/Arria10 platform in U-Boot. The changes include:
	1. Update MMU/dcache setup across Gen5/Arria10 using common driver
	2. Add ECC scrubbing support for Gen5/Arria10
	3. Add DRAM size checking for Gen5/Arria10
	4. Assign unit address to memory node in common SoCFPGA device tree file

This patch set has been tested on CycloneV devkit with SDMMC boot and RAM boot (TFTP & ARM DS debugger).
Tested on Arria10 devkit with RAM boot as well

Alif Zakuan Yuslaimi (5):
  arm: socfpga: Consolidate dram_bank_mmu_setup()
  ddr: socfpga: Add ECC DRAM scrubbing support for Gen5/Arria10
  ddr: altera: gen5: Add DRAM size checking
  ddr: altera: arria10: Add DRAM size checking
  arch: arm: socfpga: Assign unit address to memory node

 arch/arm/dts/socfpga-common-u-boot.dtsi       |  2 +-
 arch/arm/dts/socfpga_arria5_secu1.dts         |  2 +-
 arch/arm/dts/socfpga_cyclone5_dbm_soc1.dts    |  2 +-
 arch/arm/dts/socfpga_cyclone5_de10_nano.dts   |  2 +-
 .../dts/socfpga_cyclone5_de10_standard.dts    |  2 +-
 arch/arm/dts/socfpga_cyclone5_de1_soc.dts     |  2 +-
 arch/arm/dts/socfpga_cyclone5_is1.dts         |  2 +-
 arch/arm/mach-socfpga/Kconfig                 |  1 +
 arch/arm/mach-socfpga/misc.c                  | 31 ++++++++
 arch/arm/mach-socfpga/misc_arria10.c          | 26 -------
 arch/arm/mach-socfpga/spl_gen5.c              |  4 +
 drivers/ddr/altera/Makefile                   |  4 +-
 drivers/ddr/altera/sdram_arria10.c            | 57 +++++++++-----
 drivers/ddr/altera/sdram_gen5.c               | 38 +++++++++-
 drivers/ddr/altera/sdram_soc32.c              | 74 +++++++++++++++++++
 drivers/ddr/altera/sdram_soc32.h              | 11 +++
 16 files changed, 205 insertions(+), 55 deletions(-)
 create mode 100644 drivers/ddr/altera/sdram_soc32.c
 create mode 100644 drivers/ddr/altera/sdram_soc32.h

-- 
2.43.7

