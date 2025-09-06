Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFD5CAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:43:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5448309A;
	Tue, 16 Sep 2025 11:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K6fUuMhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15DDF831C2; Tue, 16 Sep 2025 11:43:53 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E58E783071
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLBoq7tARPfp4JqTAhVd/xaz3bJFIrPCbc7JV5jWQJgYVIlFymv/UHwUEC/S/qshaUzOntQkFLBtZ4MrW+pM5Wg5QUTShC6dJ5c95zu607DlsGUJtxzq/ulW5h05BmJtLdwtQrTIemRAjSq3FOrqa82dM8MbpUxXT7FVNtTCS5FCWfwz93BUoj1bLlaR4GPTAzxEBZQIfHL8EcMROhmJhBsqfLrfNHsQJD5giqSjitoBZ9rSlH4mvcrAiANUfU6+KQtHVWBQ+DBR3I+W3zlsTlbXKP6/gbhltdtaoCQoGiprAg90o6YMLJ3qYPcc2N46w1vtoBHpkQneAl1Z8glskQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhB/h4pT2EdsCbJzpBmR8pSSuEXB3nCiFvdvfFEGq4I=;
 b=YiJI9P9iaePpROnbQblDT3FCjacM4InTO3UtFywqM3QyVDJMdkH2XBonrTlnFd6Qp9ppeML6CLHkoEuR7w1Y3qYoSUxrnl/qsCVjtdiQa8xA3icQH9Mfe9B3sT/xstUkmY/ILqFY4OoAH7OlgViuq/EvLsRpQhQgFVJiep6Mscv3MhhZNvskwIu92zJ5ZOVaBCRo0SB9tX3Vq/bT4PzPDnuqotSOjwDgYwduUhBk8WuS8/1k5E0nSTbJcOQFnrLJNeuoSRWjY12pPTHB6y/bm7cFhcwjo+WGGP5NhPZsEMJ/InLvU9lBkbvJ1DzhisQ0cEwLlQQYXlY+90oDuYmGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhB/h4pT2EdsCbJzpBmR8pSSuEXB3nCiFvdvfFEGq4I=;
 b=K6fUuMhbTH6VAZhVEXq29ECK5IsppSzTHO/zyf5cA3657FJJG/WT61XQfpdz7FRj3KhPW7R+mkzGPy03qLXbgCNMDZZZXNje0M9RV/2qfHFfz65CU92YUc85yxpF4pAOIaHviAWn65PAkagQ3mNntRWAmaXG3e2pEI4/iYEkjuk7CyfJ7jj/hd9JvfACfEjbyX8IoytbbSRvrWQnyGa5RPfckGVC+hBOPtW7kPWcCQIhqLzHnPo4ocMWZ2HvschLzX+XuVzT+TLISyIpmsJ655qFyPJNjy0qGgZhKniQD9u4rTtmbNlVURtCVm1gsgiELyuQ0fQ+/W0MXb/0TzJwag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:43:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:43:47 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 00/12] imx: add i.MX94 support
Date: Sun,  7 Sep 2025 04:37:30 +0800
Message-ID: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: c57f35a0-ec84-4d3f-3862-08ddf50588bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IktdHnTTiz7YZidXT8xWC9NRC5LX/U5PHg77Hjs5slyDWljLJoW2mUnALlEf?=
 =?us-ascii?Q?6HgVgHQiLvAKUtd9GuTmSWOVEivfumjjIjFU8VTTp96YqUoL+56t/BPYM1L1?=
 =?us-ascii?Q?6NKbn1n/OPnPXzoCzPEdrcrpT/Mdne8Ib3Wc1aQXaMTDU4kjhdEatsW6ZMe9?=
 =?us-ascii?Q?4SBFSXbt0ZuXB/TMt9LyuOQTBxbw6DfZ35a5YkqlEzCmpnZCpUFlc/WRhm69?=
 =?us-ascii?Q?RZBi+1pi21Gm3Ttgh2hl8GJ0oZiyO19wp5jm0dAtyMYEXoel7fmbuxbvKIab?=
 =?us-ascii?Q?vd9SidcXXchJmhiTVIYT3WKrL9kkdS41aaTvKTY2OBFXUiQsdpDRlTKZ0h3Q?=
 =?us-ascii?Q?xZMd38uOw+/dEO2GN/hqHlKlLdjdLI2QYujfIPakRsyRee0swvR7Mw2NgOU7?=
 =?us-ascii?Q?ZSD3854rBYzcKeLsKMQwjZs33JU8aeEfi1cW4XrBUxpepsb3K0xEZ+9mnD5a?=
 =?us-ascii?Q?NDJ6JhB0TmsLjqRWj6E6DR6fbQz2z0MSvMahg5/fo7eqDhjThtEIikgWm2lx?=
 =?us-ascii?Q?GTwnP+4bav3O3ChwzCtwhC3ubVNNmDHe5s1fZgxGa2H1o6/rlHU4ORR83MjD?=
 =?us-ascii?Q?jJ1cHZKHqydNxRBaZhQSJFHRx/0R2tsT5WQ6cqK9l+/L128Odm+vMLFoOok/?=
 =?us-ascii?Q?km4phdQIJzFvw09Pbp7Ss230YbUmFez4K+6PZaLV9/iwbk2uAN5ECVN5e+24?=
 =?us-ascii?Q?3FHtZXBdqZE9U88RisFJqa74/JhCi7ZHzQtez76kzmtbs4AeNOrwT/xStHe9?=
 =?us-ascii?Q?EJJ4fMU44wojX+qIiawfV6BHOmYH7fmshvPSPZwzI1EabNTS2LnsXBiZck+S?=
 =?us-ascii?Q?MChJ67TCCK6PvKyxNw30Nu7F3L0dSOPOM+8K+j4kE5zbAFGi73IvsNzdc70i?=
 =?us-ascii?Q?IYTfqNRntPQbd7t2tZCBmgukYtAG8moX8lpagYMydmdgnRMiaw1tVuDiu9gX?=
 =?us-ascii?Q?UVzhdH9cJuimOhetjzD8mwWG4lNPj58+SFTcbmv+9v/2IQJLn8zHwq/JuYGi?=
 =?us-ascii?Q?G/R018Pu6fwHVIvs8jTOmPquhhvprXRYeN0jpGDo22uHHr7z1fKDNU1Y1njW?=
 =?us-ascii?Q?ZhZaB6z20ECaHR8R1mtp4qLbiknF9zmA3ss11ppOxeIMnDzdTbBCZGxYUMUp?=
 =?us-ascii?Q?35E+h/JQh+G2jmQVhiPRmVQQLx8obZcP9HZRwFr84FSwl3JRIu4v4XMlmTbG?=
 =?us-ascii?Q?SacKJEpBfqLwutSewipI5Tf0TKO9PVPGV4tBgFPNPSOJL8XSfjUXLBjhS8Q2?=
 =?us-ascii?Q?OrpEkIUu5MLiLyFXu6SoKdIH0pPNttgbw9V6NryCsxgb2N5fZ4nNKJb45zd/?=
 =?us-ascii?Q?dV5UVpiTnkmyxQmu/Z6IPqIV5BFLUuWBELqtF0OJ5E4lSjbUUqLdHCooXsIw?=
 =?us-ascii?Q?MECVR2Fb8hOTJiEelI3WIG5XSkEKg27lpmjZPkvcwlRTEWwqKDblXvAfWQSG?=
 =?us-ascii?Q?qwAR2D8rMEpIYwihth/26RGnYZmBWekUt2iVFhAmsOVgEbR2iSKvtA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SABnprVNF2/1PVFQFym6UDLV5akdyrNGYISCTu5lNVHb02vN0CQ+5bcniuCd?=
 =?us-ascii?Q?LRsRlCrYB3fAuBiH9PWJPp80PJ4q4VsVyWp27Cuui2zBidAcSAbnNMIIut8r?=
 =?us-ascii?Q?g3/Ysi3JEoYCNst0F9c/qYJnM6D1Zj+qI67VAFsy8WRHSH53QcY/W6lJp6OL?=
 =?us-ascii?Q?oFCscuQRdgJ2bl/86MHw5AUTO4angiEAVJncjLMuCr/wIJAcaVI2wvjbCdeC?=
 =?us-ascii?Q?LkOXbnEDFCatDrZE73KWqYUJ8TpPa6FGpkplyNrK7QR/UpEGhVevdrN6RqfA?=
 =?us-ascii?Q?fregUGyEBYW6OnvCZPO++/QnsRGwUWwYgk2BcTIf/Pxa87HOEzD++AyHpk6X?=
 =?us-ascii?Q?KjggY1FzMRABvmkV3qlZ+JieUbG/QOm+gxCxN6EoOaxk2yaAYgJ+Z+Kq4tvY?=
 =?us-ascii?Q?hliZjZ7nSTgGhonVBHL0RjyDyypBd9iQdJw4AwRAS3uqZbJAQAGJLkxkWw1P?=
 =?us-ascii?Q?z7g09yb1VVxMBLAVYxAZYAVrfe6yVMvjRJ5AE3CcL/WXeF3yLPeuO38CXZkG?=
 =?us-ascii?Q?IDLaVoiTB+M1ajrY0fBaKeu26Njb67jWsK6dHEWeoXfGovwyIue1mfqg+SAv?=
 =?us-ascii?Q?K5JLYHSw+ilf9zz9sWgmh7XzYWCGZRRmzhwrrXM87gJjpep1uVzeKjOjj/EH?=
 =?us-ascii?Q?Ko+5HU56MKzi+j+9fJ5cUlmZQ/C90f2zwcbEyUTOBKhnAN7+WfA7155OWnAl?=
 =?us-ascii?Q?c8HFF0HW+6DCHBHNtDQNpii93wzjCJ7czA+A42Ngp7UgMLIx6fjKhIhHe1gh?=
 =?us-ascii?Q?fACtk9PPTMyxM7FmigCjTukptlq/CZdf3G3cijEbG91aPL4GlrMGJNIWIrhN?=
 =?us-ascii?Q?ircSybfvRJFPphKpd/9yu9bD3ocLUF9MLF4/+E3JaanqQOjdbf8mWDhsJvvA?=
 =?us-ascii?Q?jsfPRn2CrPiSxAXlR7+0TmOUplJVs4QT+OHil99bcGioMar43lPqn1OYjKGU?=
 =?us-ascii?Q?Xe6QwDLcbkLwvmfDSehiYg1Pmoo4Y6o+zzXUfxyTmKIaxihCEGoOA/Lxs1z+?=
 =?us-ascii?Q?fSO8+XHQIA923HZMemD7DjdTBsc5T1iqjruLC8AvzCXZXP94zjQeSesRbptm?=
 =?us-ascii?Q?HdbboGoyaEQ+fwT8DdQmxnfg078T3BJo/wdCbeHnR8aO9UdDSKhJ2uJhj4G6?=
 =?us-ascii?Q?F23zfJ2pW1uHB3SzQc/DhYe5vlMseFM3oGq811ajRTR1DAMoHzROivX0l0Jx?=
 =?us-ascii?Q?Wfw7RI5XXS3yvubp5AYvDbiPcyQVQBNdVl6pIwY5hsw3jSW1lesy8XvNtt0T?=
 =?us-ascii?Q?0s9x78BmMBd76N+3ykIh6vKLomKNAHm7aOz8RRLXp9td0RbaEsY8SqMG28SJ?=
 =?us-ascii?Q?ahd8rBhndz6/DlBtF6I7Y84q4ssPdQg4tV8e4wP0rHOIL+e2zo8PLvDaENTr?=
 =?us-ascii?Q?YBg4FRu5HyLTCWlB9hvqd00WoEryykgr6WVo5tf40B5tYkiHz8IrwIbAvRok?=
 =?us-ascii?Q?ElT405qOfBlsNxvk7rqxRaIrJS7bHr64sDz1c0AoXDhpIcmK0OFLIoKHt5zh?=
 =?us-ascii?Q?kRri3GcNJoyR7CPFXwoMr7fBVIIta5fZGL4FmRduJDwIjwQPOmyZNDew52S5?=
 =?us-ascii?Q?Acqbvh2/2TIDi4c+B9m95HXkdSwuTEhtRztVD2X0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c57f35a0-ec84-4d3f-3862-08ddf50588bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:43:47.7770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfDqNMb6jE4Ij/3R6Vi1sAU/rSFa1PbP6Xx94sHNdf+qmSpzNI9NzGfMTAivhvWb20Nylb0Vwap/wVMD98YXLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957
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

From: Alice Guo <alice.guo@oss.nxp.com>

Changes in v1:
 - Addition of i.MX94 CPU type and SoC-level Kconfig entry.
 - Printing of the LM/system last booted/shutdown reasons.
 - Definition of base addresses for WDG3, WDG4, GPIO6 and GPIO7.
 - Support for lifecycle state display.
 - Introduction of daisy register offset specific to i.MX94. 

Changes in v2:
 - Add support for i.MX94 in get_imx_type_str() to ensure correct CPU type reporting.
 - Adjust container header buffer address.
 - Introduce base DTS files for i.MX943 EVK.
 - Add board-level code and defconfig for i.MX943 EVK.

This series depends on the fifth revision of "Restore support for i.MX95 A0 silicon".

Alice Guo (2):
  cpu: imx94: Add support for i.MX94 in get_imx_type_str()
  pinctrl: nxp: Add i.MX94 daisy register offset

Peng Fan (1):
  imx95: Add get_reset_reason() to retrieve the LM/system last
    booted/shutdown reasons

Ye Li (9):
  imx9: Add i.MX94 CPU type and SoC-level Kconfig
  imx9: scmi: Add i.MX94 support to get_reset_reason()
  imx9: scmi: Update the files under arch/arm/mach-imx/imx9/scmi/ to
    support i.MX94
  imx: container: Add i.MX94 support to get_imageset_end()
  imx9: Change container header temp buffer address
  imx: ele_ahab: Implement display_life_cycle() for i.MX95
  imx: ele_ahab: Add i.MX94 support to display_life_cycle()
  arm: dts: Add i.MX943 EVK board dtsi files
  imx94_evk: Add i.MX943 EVK board support

 arch/arm/dts/imx943-evk-u-boot.dtsi        |  62 ++++++
 arch/arm/dts/imx943-u-boot.dtsi            | 212 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx/cpu.h        |   2 +
 arch/arm/include/asm/arch-imx9/imx-regs.h  |  11 +-
 arch/arm/include/asm/arch-imx9/sys_proto.h |   1 +
 arch/arm/include/asm/mach-imx/sys_proto.h  |   1 +
 arch/arm/mach-imx/Makefile                 |   2 +-
 arch/arm/mach-imx/ele_ahab.c               |  55 +++++-
 arch/arm/mach-imx/image-container.c        |   4 +-
 arch/arm/mach-imx/imx9/Kconfig             |  17 ++
 arch/arm/mach-imx/imx9/scmi/clock.c        |  29 +--
 arch/arm/mach-imx/imx9/scmi/common.h       |  41 ++++
 arch/arm/mach-imx/imx9/scmi/soc.c          | 189 +++++++++++++++++-
 board/freescale/imx94_evk/Kconfig          |  12 ++
 board/freescale/imx94_evk/MAINTAINERS      |   6 +
 board/freescale/imx94_evk/Makefile         |  11 ++
 board/freescale/imx94_evk/imx94_evk.c      |  41 ++++
 board/freescale/imx94_evk/imx94_evk.env    | 101 ++++++++++
 board/freescale/imx94_evk/spl.c            |  81 ++++++++
 board/freescale/imx95_evk/spl.c            |   3 +
 configs/imx943_evk_defconfig               | 115 +++++++++++
 doc/board/nxp/imx943_evk.rst               | 112 +++++++++++
 doc/board/nxp/index.rst                    |   1 +
 drivers/cpu/imx8_cpu.c                     |   2 +
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c     |   5 +-
 include/configs/imx94_evk.h                |  24 +++
 include/scmi_nxp_protocols.h               |  55 ++++++
 27 files changed, 1164 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/dts/imx943-evk-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx943-u-boot.dtsi
 create mode 100644 arch/arm/mach-imx/imx9/scmi/common.h
 create mode 100644 board/freescale/imx94_evk/Kconfig
 create mode 100644 board/freescale/imx94_evk/MAINTAINERS
 create mode 100644 board/freescale/imx94_evk/Makefile
 create mode 100644 board/freescale/imx94_evk/imx94_evk.c
 create mode 100644 board/freescale/imx94_evk/imx94_evk.env
 create mode 100644 board/freescale/imx94_evk/spl.c
 create mode 100644 configs/imx943_evk_defconfig
 create mode 100644 doc/board/nxp/imx943_evk.rst
 create mode 100644 include/configs/imx94_evk.h
 create mode 100644 include/scmi_nxp_protocols.h

-- 
2.43.0

