Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3173AEFCBD4
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 08:05:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1FB7839DF;
	Mon, 16 Mar 2026 09:04:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bf9pzQSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7581083A1B; Mon, 16 Mar 2026 09:04:58 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D26B836D3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 09:04:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6TCybZIalcGOuaJcDuqhnjAtkVEKSt0Cy7sFmJHxOs6nGRr6ohsyPmsbCBmzCgbTEtcPttbGlwfiOvfhwYWnZb8Qav7cQxy9hW8NnxiNC3GQA26l0ZlSE7ljBkt3jqj/VJBQz35ZfpbRC+CNmedoXwF4u4qn047V9w6n+Ug9WGWKWx+k3GRUtKtybXI/CfCegO1W0aXfsaRbJZd5VDhlzqe5zBoFnppnDjdU9v5nLGEwJYzZOzOWHE4Dguo7J3CInsohuvxFdOlE/rWk9Bmgz7trRz5sPH5wK+sINPZCNvS7zOUoWcM6M2+UUYOJn8t2DslYxkhd9QYjHcqCNNRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnoCWeDXw+JtJJhW/UZ30Px4wGw6t5LSe5cOU0QkqYA=;
 b=zRaRTd4gFISApUMDUOC+CoiknSWH85/WIe9i1tmiqzD3vRmpmxqeZE/dypcjxtlQBZOkDVBM/WtLu6SWvoMGB49IWBQv4tiSzMUjbHVH8QiW0rT2iGv7t5KGXOmiBws7QVJYjhJut51y5LNICmK5h1grhWTiwheM21ykWBdSdB8sYzeWmwGpSL9w0eHapE4aDA8HfAl/jBh6EAUFXpV/7N09xKbNIcq5Jtv9LtIUu0aSxHEpk8vMMx/VsJsoEw8INcHwVvgU9JUN4iNF3fGnoBZzl/tfgAqIuL+3sV57lGqbX92GJyH1tRcHz+eJtKvR5wvJM/PJsCS+rNPHiQ8Tew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnoCWeDXw+JtJJhW/UZ30Px4wGw6t5LSe5cOU0QkqYA=;
 b=bf9pzQSMglMnuZGwN6KbrRNgdBfOdm1AnVWPOpSnWUQ0tpZGgwJ3FO7+46ixEfc53OsUpnAKWf9b1gZU06J4zrNGiec6xwLIVrt3auQJa3+QAZ7vCaq6Ku1HclJlXA4eZdlJ+rmMhyVI+hFiFB37r6JTun8n+Xxjxmfm3l36cYZhQ247mc2Fx8ay5w7BmzEIAfkcy08eXlFB/nAofLkrxV3v+GPC//toRL4I/C0bUBXYqdZqDZzm1tW1T6sZR5pliT8abafShYrzV9glP9HdFp6g5of+8EABSWc9vVFv8XXQ1wSQ2UOeERDZD5h5TPaOL/yc0oysruUIDVXFaeI3Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21) by GV1PR04MB10128.eurprd04.prod.outlook.com
 (2603:10a6:150:1af::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 08:04:21 +0000
Received: from GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12]) by GV4PR04MB11901.eurprd04.prod.outlook.com
 ([fe80::601d:ca21:9592:9a12%4]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 08:04:50 +0000
From: "Simona Toaca (OSS)" <simona.toaca@oss.nxp.com>
To: uboot-imx@nxp.com,
	u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, simona.toaca@nxp.com, ye.li@nxp.com,
 viorel.suman@nxp.com, ping.bai@nxp.com, marex@nabladev.com,
 sebastien.szymanski@armadeus.com, ravi@prevas.dk,
 joao.goncalves@toradex.com, ji.luo@nxp.com, tharvey@gateworks.com,
 qijian.guo@nxp.com
Subject: [PATCH v2 0/5] imx9{4,5}: Add Quickboot support
Date: Mon, 16 Mar 2026 10:15:51 +0200
Message-ID: <cover.1773648510.git.simona.toaca@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::17) To GV4PR04MB11901.eurprd04.prod.outlook.com
 (2603:10a6:150:2eb::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV4PR04MB11901:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: b30f262e-3910-4bbd-982f-08de8332b264
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: IS7vrKCPQR87xXs/gK4XkLQlT+0QZ7b1wFBMwgtM5r7qxFbwqIClHNCJWIy2HtyMKVVT3TPObeQ4+k2KrOwhq4CK3g1nhzgfsCaEw/kCzH+6VkowJp8aJkoExlMnbNplfRO2tRNTDGwYduE+F9Dt0aYSaduU9popNgJEE/av64+Qaly3JxYpo+pGTkyXhD3+8MftlEJLxlt8LFaGBiNzyn/6nDeYDBqe7ekkOuPPCpeqRaIQ+6tbpgw6z39wHeNJShpAXGUAZh6kzb/qpCrEZkMg+WrI2uOUTnxpkFLALQpti45mhneUWAygjKIlCoUnU7O7NLqwB45mNUrDmU76e6OJy8976gKAB8i+naEDSWeOtIRN2xULZyPvneLEK9UFZ3jHSb59M6DtAA/zziczu1QZNHTSi9HjKItfyJTF139dELXoqelMUfQJh36z8cVwhGfKMDkncTFhnMtsGkbTZj2Lk81Mu3TnUe5RKkgMEi1TITzLZloAtzRkYIR5aUHjGQdTMBp+3M6Us5esWh3MWp4UCqusn1v2X4oPuSbRX2oFCdgtxb0v+C+oynbbdjRt3BtFfN1GqNrkTTdkcTuI6UPlf8vrLSJ4TSOsxHk0sTOZKOnJ8taokQRt7mlwoDn9P/blIaJ5WPY9yUkmTXUyCA0eMd3I7/SzFAYhpBEyUzhnwDN95FiXCirFZaOtLqsAs/KCY0413ZP2sWMcub2hViYk0h68tPXsNd1e3aWZhDY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV4PR04MB11901.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?poGQZe3Waa9CqPUnT9exz5PHnUiKFPoAdLuGF5sMfgUQJmHdB3yCtMJkV9tN?=
 =?us-ascii?Q?mvIeqIOl2mRnWp//jOtxa6r9HMlPtHgxqW6BRAPtUvoDdgJ/RF2B3A60ep8W?=
 =?us-ascii?Q?c4JDwiHDWO1OgwtO3pMuzIEMCwnR59jj379AKU1/nRfmqot55XWzmx7XXWxT?=
 =?us-ascii?Q?brVxsi162Y6R4pw/ikoDkefDj4WM/6Tv+YhgH29NzW/eEwDEs0JfKrfdcrX5?=
 =?us-ascii?Q?gk9wZiLMPEW1JfXdU3kH+b0us2oTbqOPHz/tSZXd5F8B/bgjPWbPTE6HFLak?=
 =?us-ascii?Q?K7ec+Hz1ZmdtqIhCe2zgNJhwLv/7HhMIw+fqFII8t1iWs4uSKN1jgn8M93eE?=
 =?us-ascii?Q?CtolT9bVGzsRKDZ+sybaJUQ2Qm4vg9/3HKVXpCwAbArb+6UuC7pMH82pBJ9t?=
 =?us-ascii?Q?jG1Bg6NdCyQnszcSPrlcDKKsPEYTY7CO9pKLKW6pfppniuW+54RESLqtAYg8?=
 =?us-ascii?Q?qkL0+X4qFxOsi6Ef6x8CsV1u/ZI07I0qnIyAT22TA06xH8YC0QITsCThbnhb?=
 =?us-ascii?Q?merTLap2DDDRT9DChflf+PR6gItL0lRTojCDECFNsAazhOuztQWHLe+FGH3K?=
 =?us-ascii?Q?+ZNDVWawz4ZJFgjsr6Wf1M2Wl1Nv875+1PkEgn5Pn/ljEcJ/g34DrcJskcXx?=
 =?us-ascii?Q?1y6v6vS2qjUucmKuQI5Uq4QBN07Y5+AQhw91Yeje6VDGcWBF1SBXZ4cOU6Dj?=
 =?us-ascii?Q?TJpgZWP2Q3zItiEvucCR8rpkAK4BIRad2BgoJxJ2uGWow4GrjPyC0QiEPHbb?=
 =?us-ascii?Q?Sa6KzaaYskQMytVLegEEa8FGWf5+jYRpz73WPp4X7VHY/dr1Fit31jrLKCDO?=
 =?us-ascii?Q?tAvlYBDUqh1ZtDUNFGNI4VMyjUclnzrZMG4qyuUqzfI2AxTxaBnzXWhae2pB?=
 =?us-ascii?Q?1KSF+jYliUsQocu6nW53PowyClaCOW1/OxToHiyofFYYGQjZN3wZt7uZpFr3?=
 =?us-ascii?Q?dNkdh7k6C/oe88TiEakyncazp4OEunS13OKvC0n1KNMU22Hdw4PAVauklI3F?=
 =?us-ascii?Q?u3BJR1nPaVPOk2kM+u9LNuSmZnJb1StmzMCdVAwSAo5Sn13d+8Wb3u4GMjSp?=
 =?us-ascii?Q?0z014Vh81e3Ks/CPEFUA2UPTidBLf13nNUKZ3D2GQaQLfBh9JvMbXdw//txl?=
 =?us-ascii?Q?ZxiL8oTatNDR52xNPpcUX5yMIeqlhJodcsJfiGcalhAcPB0nit0qljbrSP3D?=
 =?us-ascii?Q?u9gjVMN4ktpiFvqd5/zC6Wo5cwbyFBdZdM1LSZpZoHLtu4iMpDuA1x5CrgPE?=
 =?us-ascii?Q?z6/OEU/jAY/h1PThcXmHOulfb1IwOr3Z8biAyvMz0KYjSSJYV1OLzyJ4ZP5r?=
 =?us-ascii?Q?GwR5/un66siq/P2aEW4FNEl81QwQtAJI8Ke65NMY+jVnb5vRIZ0f2ejhgR7V?=
 =?us-ascii?Q?gn9XjvpHgzTzuA7ktnfyaVty4Jv6xYfkil+vQzf8Z8B67YnfQBGNXuhQxh09?=
 =?us-ascii?Q?1QpvfeIipJLsBC1t3Em4QZMwOGKNr1xCh6jbu1+82qh9rjRCWUml1RYPwrm5?=
 =?us-ascii?Q?Vk3xdSR70EZoDdLyE2HduTzSnWchPbf5DkY3s5OSQ6BvdRzTHvakNa31Op4E?=
 =?us-ascii?Q?Jn+npxKAEVKfWVcYwBWX6/Un16h4Fo2YtBi08ofl+h7Juj3NHS+HhBn61ulr?=
 =?us-ascii?Q?JZHcIElJgH5qjoMHHuVPKO3epbEcJOB6sUfj4zLR8tdWG5fR6sM+gqWQt4AJ?=
 =?us-ascii?Q?4KzZP/ry3ai4FNG8U2JXbwMNCZvJMJnOwYH0ee+8hLBdP2hYnhmVUGC9dHPU?=
 =?us-ascii?Q?gmFFBRr6oQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b30f262e-3910-4bbd-982f-08de8332b264
X-MS-Exchange-CrossTenant-AuthSource: GV4PR04MB11901.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 08:04:50.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TB5TJb9P3W6TO4+lkMnyPCA6dcnJkk44zH1/010BpwsvY0eD880ySiIYqir5PHWprPLDJbjTqgHdRsTblCegxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
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

From: Simona Toaca <simona.toaca@nxp.com>

This patch series adds support for saving DDR training
data to non-volatile memory on iMX94 and iMX95 platforms.
The purpose is running DDR Quickboot flow on next reboot.

The process is as follows:
- OEI runs Training flow for the DDRPHY
- OEI saves the data from training to volatile memory
- U-Boot can then save it to non-volatile memory (e.g. SD)
- OEI loads the data from NVM at cold reboot and runs Quickboot flow

By skipping training, a much lower boot time is achieved.

Changes for v2:
- Improved documentation to clarify the questions asked
- Detailed log messages for all commits
- Detailed Kconfig options for SPL_IMX_QB and CMD_IMX_QB
- Fixed the mentioned coding style issues

Simona Toaca (5):
  imx9: Add support for saving DDR training data to NVM
  arm: mach-imx: Add command to expose QB functionality
  imx9: Enable QB data saving for iMX9{4,5} EVK
  board: nxp: imx9{4,5}_evk: Add qb save option in SPL
  doc: board: nxp: Add Quickboot documentation

 arch/arm/include/asm/arch-imx9/ddr.h |  52 +++-
 arch/arm/include/asm/mach-imx/qb.h   |  15 +
 arch/arm/mach-imx/Kconfig            |  19 ++
 arch/arm/mach-imx/Makefile           |   1 +
 arch/arm/mach-imx/cmd_qb.c           | 132 ++++++++
 arch/arm/mach-imx/imx9/Makefile      |  12 +-
 arch/arm/mach-imx/imx9/qb.c          | 439 +++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/scmi/soc.c    |   9 +
 board/nxp/imx94_evk/spl.c            |   6 +-
 board/nxp/imx95_evk/spl.c            |   6 +-
 configs/imx943_evk_defconfig         |   1 +
 configs/imx95_15x15_evk_defconfig    |   1 +
 configs/imx95_evk.config             |   1 +
 doc/board/nxp/index.rst              |   1 +
 doc/board/nxp/qb.rst                 |  49 +++
 drivers/ddr/imx/imx9/Kconfig         |   8 +
 drivers/ddr/imx/phy/Kconfig          |   7 +
 17 files changed, 754 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/include/asm/mach-imx/qb.h
 create mode 100644 arch/arm/mach-imx/cmd_qb.c
 create mode 100644 arch/arm/mach-imx/imx9/qb.c
 create mode 100644 doc/board/nxp/qb.rst

-- 
2.43.0

