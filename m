Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64347C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CF0380CD8;
	Mon, 24 Aug 2026 12:28:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5IqcFp7YgYHP; Mon, 24 Aug 2026 12:28:47 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574527;
	bh=XALH8kSY0kPEVtA0YRgY3kZmN0NmX/ZXUwqJ/9po9FI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c45i8X8zBS+frKSNdsqDFtyJHlzigpKoKEuVzge3xBrDYaoM4v5aCK4fPfMS4IB9C
	 kkfIU9tMEDD41kGF+MMWi69b/S7AS0aVgPe3LX4ziDU3hemVypLkTndwUF0MtV9TsH
	 OB0nRhJ5t20muNavMB+hbBjXiTBr76WSxmLIUTna8YabPfu1dSRtH+Qzjj9eDaALmm
	 90RSkicWOPzPPtpa1hMhgzQJ7XfqcHuuOrigQG0/NuFofXRb+nTGgPRrlZ1dHr3w5i
	 4cARjLPlIh51Wtp+lNu1FWC+EDNcedkGjazUbJHuHVbVBhMkJUTGodzNHkJNqxqBtE
	 YeR2VAJYXDCvg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B08CB80B6B;
	Mon, 24 Aug 2026 12:28:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5241441A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FD2640097
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ALndgz8DuOgr for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:44 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=QElcqAu4
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 55C454007B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hW/ruI8cyh9qWRVF9C8m+cEmMhfoJELlYcyBg3Q9nQ0bRU1eRmIabqibhabJVPr0k64QB62QxO3eAdG1ImAcJVF5a13pYHAosWg+WhT+P5XbcQZ/rLFXi2pQe18dRDGuRDS4oPKaI2Fhree9ZrpdHsvbfhsKT0XFjVAscGmCkqYSpEnEqZn2irI+D1JtHRCQeLL5i0bn95uQJApb5zz4SXE24ZeOHbrnKkQ8TxVjo3rpAMsCAgwYB6VyYlXu4VA/zg3CLUqGlN2I38oKLSYnXaZZMmkyMSF7RCHMxfLn4Ev8Gfw6/OGY7tdXobRG+1X0fmaiE/PQJZ5cxw20i8x8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XALH8kSY0kPEVtA0YRgY3kZmN0NmX/ZXUwqJ/9po9FI=;
 b=h8fvxhrWXqD8CkNo7ynaGwWUNZbR7ySD8s8PtChEDjq3feRcEUtaZyUnlG2envSEYXBPH/7qGyeB5yPlumbjpaT+iXlqJaf1tLAB36QXU60YJQ7HN3de0k1lF3oU5pLwwW1fzaIFTCAuH7kMLSIMT/EW69E5CQNGUhlImEdHuXyZGWFYc9SZu30WNebxJGNArZuWhcWl1D2036FWUlhaL0ZCSwXiV3wwQQMfzl5cwF/l3G9uBCKESAxE2vm8MVu5a2ukM0sTEFHfsexNli15q6YL43mANy83KqABpqGHegOaUf4tpvzjwRw8Da8j1zmBzf4CVGMqEe54XQOh2o3UZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XALH8kSY0kPEVtA0YRgY3kZmN0NmX/ZXUwqJ/9po9FI=;
 b=QElcqAu4ncwbizL0b7yGDQqjRykVlJNInTncUHoIhlotd8qeKQ62GyMg9hreFd/bQS/HPaorvBB1wL/t+FT1E9otF2+c2nlnKbQcIN8vQecj2XHoZPX3fpISIp/HH7NyaZ+/RD42CexBKn0aKta6BQqZa8FKOhsv9FKa91ibVJWpav0/Lqtz6H87PQacrT575i4SbwnNKGDshDcve/DCgVxeBehzvr3lDkbuqxZ3xX2F3/BpvDo3aY435QEd3UtKLHL6Rd8DQDI/GyPiKOl2IRkjuYPB9XJfXje9YQ3+eHoTM3NNlG23a01ikHBBlZrTV/dV3OGtqbxIJoAElre2nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:40 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:40 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 1/6] configs: layerscape qds: disable ENV_RELOC_GD_ENV_ADDR
 for NOR boot
Date: Mon, 24 Aug 2026 15:28:20 +0300
Message-Id: <20260824122825.95712-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0423.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::13) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 2437be31-a482-4492-c161-08df01db3a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Bryn8Egq9wFqCoqf3aYTwoPwW0CvyzD8tZB6vIXewVP9g3gRYfmC1ZpIINaXbWRGPhP3lmekO9AZ+h0nunk/LBVjo0bBZ6sOXgWiTfISn6UMYSqxgAKr/+/cxt1t8nkkdPR68/2MkN0NmGyd7Pg2iLEI1YtAOs+xlhwA48DTxAuc87AnwYirldvxN7ripqqi2di7CXTFC/lOBlO375q1K+H2zWSDibU/UmcncfJ8x7519vsM7Tkztcjix4KyvQ/t+Woszl3IBV9K4iCVow7mm5hShQd+58Zs0rgI4bas2yFcyIizchIvxfki0c0KbHeYFNQ7/kD8vvBgkxV8GCal2lwYpryvWSmfiOdJ/V4pvMNsYqPoKIuAbtwBC2zoBjQF58lcwz5yIZWjKSXSmP+lUZQszZ2cLMhGBZ3NTP8KVF55ssjBhYte+Ec33B3z4ltNrPU2K7oUySSELfi2QbdvxLvEDJ0aTQuqdIN3gQ7SJiXkSZfwQSSygge3fviKKp8EsOYGkoVavQpsSJC8bGykZUiJuYCcR8bH86A9MZhYBa9J/XJ2lo1klySdtdL3VqMsFspf9QRMFlpFG4cpCncuOMsFjyhCEQgwGxQo+ZK20syW+ohOrXmsz/vRyfK0BpeO6VATKhvV4e3ypXd0bfQutSbXCOsnjtWQuzP0tvhOsKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NiWXxNVxyGoQpBZAs6Ue/j1MnpQGUzm3lp7KaU4pH+TeSIqr/SrCYxKpEuNg?=
 =?us-ascii?Q?6MMpx2JyJrHHwMUhVFEZaHtUb+FPtJ7s64UwS1SyRWgYGQ5H9c0Aqjey6F8M?=
 =?us-ascii?Q?0FIxxXEUolc5cndE4hXgpai62LKxQQSklkSc2YSCTQpSu44DG+sCm1wuzK9j?=
 =?us-ascii?Q?7yAfeQZIQKavO5GANhOYag6HzhEEA3csEypj5LvF4vBHmtVVybKmmDZPvV7Z?=
 =?us-ascii?Q?OOpqoe9YrCXrUPLR5yXZjiDPRlt+ncRqvcU0RMXSKHJQyOlza63z2ptOOQjy?=
 =?us-ascii?Q?4nD3gOp+Wpj23FOKYnnqYs0RZO09KW0NUy2VsWipfIJy7/GG8vcXs1fxT2tM?=
 =?us-ascii?Q?H87TpnDOZZ60Lfaou2VwhkiosRHWAK8u47VHbJ5xM1yy1x/db2BmMiDzQUKS?=
 =?us-ascii?Q?3jfZErl0yqty5yoAjDgTi/cH24bRSi+cOqXaZw3H3zK5WYGBHxot9wlf5dn4?=
 =?us-ascii?Q?imqj6yXjD9x7akn9ndWMMG85q6a8Xl1CulpSDUQLg0AeT82ENegn5AzmpVec?=
 =?us-ascii?Q?upnCZ2GP9L1+lSfO8uGQzhaN2S/KKAuNgziW8+2yuWdZ/ddFd6JpJmS8LF6H?=
 =?us-ascii?Q?rQARQeUa/KT+3EfnwRK7lcqRHSDwjMk7PRGEc9qufg0XulV9p40B5W2tccLf?=
 =?us-ascii?Q?L0ZxNwycOn+3Kc6OUgYF9U4woUYjsgEb7NFsYChU1djv2gG0+tr9ZW8dheWz?=
 =?us-ascii?Q?wiN7H7+jHo9+/emXJTl6wtIJ6YEDC77ZRCK/tjUVbpzF9k6gwZeEVMUXPdiX?=
 =?us-ascii?Q?pc5NBCKKehkwV5/zS/dmEmW5Mp/CNQRMtI7OnP3VfSRlPXZWandVKpwG4Xh7?=
 =?us-ascii?Q?YO4O420J1UQMJ5NmbPaQxWPR0dl83XOvPmnVvvGD4qT8JRIAuOVaXRxWNg2Y?=
 =?us-ascii?Q?MbmNc4KQZoqW5+dCZRwuxY7EJJ7DIbOi27gw9wzsfLNRVbrxv5uAxFV/wbFf?=
 =?us-ascii?Q?B+aHilYW/3HB0s+kvRlaW/aNb4wuPNBni63anTcfR2OEPCLHHi2IGql57CK5?=
 =?us-ascii?Q?1fR85YJWevD33YVp+QYALXaKXNZOKNUykTnsNt+mF417IzCYJktdjxPzSv4j?=
 =?us-ascii?Q?RvS0sB6AW+LW+Nfw8MudGfUnkRy2E1eR5SBxBSMJU8mRIJFKmN76QmRWqrs7?=
 =?us-ascii?Q?RwbUcpXL4wor1ePdFaaRLBLqeP+tykyAfw8sPVDAysWw47ysb3tfU1/usw5P?=
 =?us-ascii?Q?UAdNLz5Y/W/0AyawmDWGxBkJerd+MhRY7ivePNJMbGLxAbbN3WoAMfnL0XPb?=
 =?us-ascii?Q?DvN+aZJpB4ChNqqkYGa+PE7xmk/AGnUvOz8xtFnjDOrP/841vq7ZF78dOYe5?=
 =?us-ascii?Q?kLAAMpMZo9AV24k8GDWglKvvjrnmZShS1vfxZCYGpUu68Z7S1WHSz3VXsvrn?=
 =?us-ascii?Q?fe26iPDpscRx6lBK6WcsMd0oSNkaeWgm2SCMvi5wgCrZsLxbPJdEwlCk1tNy?=
 =?us-ascii?Q?ZwVWox6aUiRxb7SPQmGpZMslso6yRuFpavY70981uuS/YQZRRN5mO//SbI/Q?=
 =?us-ascii?Q?sczuJzDYn80EF92o0KP0IZ+0ar8PizdomTV/Jh4imLVHCYMAF/Jkn2s3FvfW?=
 =?us-ascii?Q?KLHzx17X4bmxdW7FuefdFTI4sqohC6QeYLH7Q3C9QeYUhqkO7t4hdyEx5sYF?=
 =?us-ascii?Q?9yh51xYR/HwXSHo8RL5QJg0659gFR8xTx2DVPGZq2aDnEToaL/hR/pFiMe0A?=
 =?us-ascii?Q?uqsVDe5qdWdcvWgNeKNtqPM2/FeVFybsLD+6Faywe5rVU4MsQM1SVb7zLBBj?=
 =?us-ascii?Q?CntFMK7jxg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2437be31-a482-4492-c161-08df01db3a48
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:40.0706 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq8F8niZpwKLgDnZFs1ul7lbzAuqi1GFOUXmILdUNQq2xNuwb1SqiU+upicAUMgRWBolrKh5ENkwc+kd2ggeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

CONFIG_ENV_RELOC_GD_ENV_ADDR causes gd->env_addr to be adjusted by
the relocation offset at the start of board_r init:

  gd->env_addr += gd->reloc_off;

On QDS boards with CONFIG_ENV_IS_IN_FLASH=y the environment driver
(env/flash.c) sets env_addr to CONFIG_ENV_ADDR, a fixed memory-mapped
NOR flash address (0x580500000 on LS2088A-QDS). That address is a
hardware constant and must not be adjusted. Applying the relocation
offset corrupts it to an unmapped address (e.g. 0x5fa1fb004).

The first call to env_get() after relocation passes this corrupted
address to env_get_from_linear(), which then issues an AXI read from
the bogus address. The bus returns a SLVERR, which the CPU core buffers
as an asynchronous SError and delivers on the next function epilogue,
producing:

  "Error" handler, esr 0xbf000000
  elr: 00000000fbd68068 lr : 00000000fbd68040
  ...
  Resetting CPU ...
ESR 0xbf000000 decodes as EC=0x2F (SError), IDS=1 (implementation-
defined syndrome), consistent with a Cortex-A72 external abort.

Disable the option for the four QDS TFA defconfigs that combine
CONFIG_ENV_RELOC_GD_ENV_ADDR=y with CONFIG_ENV_IS_IN_FLASH=y:
ls1043aqds_tfa, ls1046aqds_tfa, ls1088aqds_tfa, and ls2088aqds_tfa.
The remaining Layerscape defconfigs that carry RELOC_GD_ENV_ADDR use
SPI_FLASH, MMC, or NAND storage, none of which use a memory-mapped
CONFIG_ENV_ADDR, so they are unaffected.

Since commit 123682c7651d ("env: Rename SYS_RELOC_GD_ENV_ADDR to
ENV_RELOC_GD_ENV_ADDR"), the Kconfig option has been renamed, so
splitting the change for each board is slightly pointless (it can't be
backported as one to individual configs).

Fixes: c43a4f827691 ("configs: nxp: Enable CONFIG_SYS_RELOC_GD_ENV_ADDR")
Fixes: effcb1ebe44a ("configs: ls1088a: Enable CONFIG_SYS_RELOC_ENV_ADDR")
Fixes: 5e736c9397e5 ("configs: ls1046aqds: Configure environment related configs")
Fixes: b10adfac64da ("configs: ls1043aqds: Configure environment related configs")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 configs/ls1043aqds_tfa_defconfig | 2 +-
 configs/ls1046aqds_tfa_defconfig | 2 +-
 configs/ls1088aqds_tfa_defconfig | 2 +-
 configs/ls2088aqds_tfa_defconfig | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index 6021d9a5e512..9e88f912a930 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -65,7 +65,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=0
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+# CONFIG_ENV_RELOC_GD_ENV_ADDR is not set
 CONFIG_AHCI=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index 05f9808105a0..c5eafe1064d9 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -66,7 +66,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_ENV_SPI_BUS=0
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+# CONFIG_ENV_RELOC_GD_ENV_ADDR is not set
 CONFIG_AHCI=y
 CONFIG_SATA=y
 CONFIG_SATA_CEVA=y
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index 4e6330206d17..a6ca891c7a22 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -61,7 +61,7 @@ CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_NAND=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+# CONFIG_ENV_RELOC_GD_ENV_ADDR is not set
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index 566c0affc4a7..79e1c0c70187 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -55,7 +55,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_ENV_IS_IN_MMC=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
-CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+# CONFIG_ENV_RELOC_GD_ENV_ADDR is not set
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="DPMAC1@xgmii"
 CONFIG_NET_RANDOM_ETHADDR=y
-- 
2.34.1

