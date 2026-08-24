Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B59BC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:28:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F80380DFF;
	Mon, 24 Aug 2026 12:28:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZiWbITGOefFf; Mon, 24 Aug 2026 12:28:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787574537;
	bh=+UifLr87Wfpi3s0QMOb8GxJzWKEWvfI0jI7aoEimuGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jgKNqL0QtE7gYjZFo5RgtCkoHIF0jPAw00z4FlnBnahxvTPNJPqwv3Mks/xRcePdG
	 COFzG1EYmps6w9x8F8tFVmVkL/qV4tWJJPOeRetFeifXHzFGLM93Gy2X1aK2/hvGK+
	 jT8fj0HInZ5JR2uYM/W9KiFdQoGkc/P7C5wJffhNO9ZgUidzJXTSQo2t/vrm7xuhjz
	 vJGqeWjJErDCXFa2XVVAC7XGUR6GXLxLJSTc+/29gTT0lUn0T0/dHNWRclqNmP4+SI
	 ApT2jmFzzV4FXGnILKoCimbBYuLBqOss5okIQgMCXZ8/9GB9CYFbFv0nP6I+qH7C0m
	 CqmFHQWvHFOSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E36D780DE4;
	Mon, 24 Aug 2026 12:28:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5BC4C386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 422C060659
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7q0G7pPG1cJD for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:28:51 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=midJQ6pp
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65AEB60672
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:28:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7schB6T011C8dzw5Z+I6JYqcJZT0W1PtZbjqUaePzjatdjppk6P/8wJbE10vgcXGRE/4snt5spIfNw23U71owF06hrQl8OSIig222rGOY+D5yjFUtpbqzAsTDnv1BPP53eFU19Opi/3WJF6MkLHhAjNnwjPlbey8nhFN45CRYFXeRSs1ZIyd5ZfMVsoN+orIKSiwcbZVfuupzDtgSCeOnKy2r8DI1wSxsSR0KzUUtzoKPOsWP6vF3r7tqzCDxhNhRM2bzf5sqZQRBVKGduw0JAC5jH2I5SnYKw/8oW/pttkR5SQFx69kkRte5ZNVDXAcbcmV5KKP8jwkfLFI95bHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UifLr87Wfpi3s0QMOb8GxJzWKEWvfI0jI7aoEimuGo=;
 b=Z/fvc89L2fX2236C9rlecQpthU/4FCLhdIEJLOSn/TKs0BWQPIQk9D+H70sp6BnPrr94XYGxFDqBAqeZzfHsyLUXZQd3MARCaenJKMwq7YFF1e77HG7OPfgg9wN2cVJ2v5ZP4oA6B49JI5svWSnC9kD0KfxDbEcuLQlg+MV4Sjz/SOaUJTZLZf0zK6t/tClX39SUGW5I+RU6ASvP/pSICrb+iKSw9XZBxd0divATpAa9z9ZALYGeY+fKdPUYiJJoYUj38CmfPZVN5ivnC2Gsj7PW/FQaj6YOe0iZEVpifBRHmlOfF7SNbpxJEtw4ArO1Skz3u4xtd4BjY8y1gOQjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UifLr87Wfpi3s0QMOb8GxJzWKEWvfI0jI7aoEimuGo=;
 b=midJQ6ppM4w+iSkLSnkxHTC9cSN1ndiua38v1gWqhA0eH8lWwiDkdhWex82MbQfEX1tYGFvgKfYsNYTIm9oFnxVDeLxS80Vd1cQlp/naQqV1ivuyS/JIrL0PTg02S81SNbDLj1tJV7Rqq5SDa1zG+OhtZrtPdSRRtY0pRlwC2Nao58Ws2WuSNiYFinFmIrnO8URmFesJwnKJqAmxEFtPanY8MdWbrVWd0DP6IXZFA9GS01YteVpFTI3Omm9MFyjujP3KyyLm5T1TMJjAEdfgGuCpzQ3SykUuq2anr3+7J+AvtNq2DrfL/pdEQ3E9kcplHVS+XTEGTTU0Ublpb/IaYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 12:28:49 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 12:28:47 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] common: kconfig: raise SYS_CBSIZE default to 1024 for
 FSL_LSCH2/LSCH3
Date: Mon, 24 Aug 2026 15:28:24 +0300
Message-Id: <20260824122825.95712-6-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824122825.95712-1-vladimir.oltean@nxp.com>
References: <20260824122825.95712-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::14) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: afec23d2-b9a4-4fd9-8afc-08df01db3f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|23010399003|376014|1800799024|10067099003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Pym0mI2GIWmeTjpAsjPIOKPI6ULo7szHMsorB5QuMW6SImqRRQBWmvJsJ5uGrCfyLaj01mKkFl+n6bt3jf6WdY1sOT6GNk0oGAfWSGEatBySJ+EROAPHAtTiKbEvW3v56Q/u0Hj6yoiHEMwNkrulRO7ltIDyc6f0EFYzEekZLU6Rr+GQUEA2Ll7wund0YILR6fs4vvSqmkTvoVYbr+b4dQCfwRgUtSow7mg7N2umhmu+UcutQWwS0y9psskChjtulsNVmUW5Xzl9XqyGLizM/Mi1GOfiEWSX1uZoqefnAKCZjMIbx7QUD+sn+7Peq5P3vOXbEMkEniDSy8lsbgHAu7VHb9zRzQUVAUlOiaVMa8+VCnpNeqIYJ74zsi/elaoiR3BagwNLxAGVdeudlX7e+BXX8BpUy5CrPyPZ+jUWYoOrxu8tiz9Ck6XICzBeX0UKxzATzk6Tb0ptXpZNJz+uWZ7GGcJN8qj9zn9pl37V1E2S1x2WS+55B/UBzwp3Z/F0qRkHFK0TAuhZeVLlZ1qYtyVHvgfPcKtkY1WrawXFYaZnuinS86LXtCsJMWCbCf4MUXKXF/HaooWI9dR+cIs7FFWJQBrU/38tz9Po5BpZBeX8b0IRQGOHU6U8vapKQ4B8LWzrlKmyJcvxOdQNUj/RqnxxMJrX321esUwua5mku2U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(23010399003)(376014)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gyvLuKgeqR3sE33bnRkAGZ8YLn27JjpFwLVtAlaTsfJcMSJ0AdsPWFDhEX9/?=
 =?us-ascii?Q?MLS/PPtJFveyUPgDefQI9pF5V5ClSZr8iN9ctwJUhF94sPQVUs41ro1Jcxf7?=
 =?us-ascii?Q?33KkjFYy22C/E/RqJlBAUWBIxsXgZUo8v+jgWqXhB4dojFt3oQkW/xCoDs5g?=
 =?us-ascii?Q?fgFv4MW8abIlKPKx4z4+hlnxvmA2cUecIEhri1a6Qj2XqJBpAdxfJclYQ4cA?=
 =?us-ascii?Q?079bZQ+EK+rAgRPTE/uffBm5DI3OcyhtH4B008ZzFCJtRzuo5NmlKVcAJVYM?=
 =?us-ascii?Q?VvNgGNn05P0raVA0j3TCygeZbyiMbuca18ZXSPBtBcY4iDyXSMCiY60joODZ?=
 =?us-ascii?Q?JbyneZnSm6jx3+2T13fXJJpYr9aeSb6Db4Fai/a/Mdt43wCS/yvjhRI9l7fq?=
 =?us-ascii?Q?3iodyy6O/42xIqTYbtQ9CFpZWswBO0UxcCSAZ8dIOSjbcOXdH8i3m5MernD6?=
 =?us-ascii?Q?WyNb/EiJqD8Ca31Fmug+fsXCKFhild/FPgrPRJ6YLDA1GZ/0gz6YXMECgo+W?=
 =?us-ascii?Q?AtMRR/4QnmJorDXAE8ga2wequjfJ4WnLEBwEHPyEuj9DF4OX9DMlYd1gA39g?=
 =?us-ascii?Q?/RRrYEVWChZbvKJi57nMLLQf34F5zUvBtTWMNxCXUv5lDrgwuZIs6ufVnkar?=
 =?us-ascii?Q?SoQScK6j8y2stG/fCh/LJV8lMkrC9PZdRDeh+K85uIEglmNM5kmqHVcRW9Xt?=
 =?us-ascii?Q?JctlW15s228BhNK2BsFeecCuXBvUzYWsQgvaNqtFZGvMSELO8oMj/rVTy56V?=
 =?us-ascii?Q?sfZ48vkUE3gEITXff4MEs+B1ot251eVmG1NbpCK4hFevEqIfQuRONXroWUWK?=
 =?us-ascii?Q?1yCImtAuJEAWBgeIXVa3FCMLMlaAbop/yopPz35U6U6Gy/rCVJ6pGtfySzs5?=
 =?us-ascii?Q?ZcV3B7MwZe7MqpFoGJhfBd/PEVLrpW0680qj4mG5fwP8L64H6XjHsjKSkh+x?=
 =?us-ascii?Q?rldjxM4H425nETGyRZpYzHOC2U5ujss/uqDwW+AmAa8LnsmP5o2Nxo2+yLnI?=
 =?us-ascii?Q?qTFw44VwMa9JAYZPy8HctI5b8e0HvV39MGPcCMKqrqQyFAEb297hQ3M+nzeJ?=
 =?us-ascii?Q?A7PjieM8aPjN3RGTOV180peRptv+mDt8D0ke6ysYC6ESep539qUgEnHb0e11?=
 =?us-ascii?Q?h0OF2oqvlFWVzIPa7wogHlnnJQLXXWMKFQ+DZVPWReRz/44TtjI1Iu+gnp1o?=
 =?us-ascii?Q?cZNAXWVYVPhpn1BUtiANyHgo52OELIgbn/6hnY0p6nEBLbsPMxWHSrX4G7JJ?=
 =?us-ascii?Q?BsVkqc76Ujc9gteSfbbKPS8NccFHsyYHVru21qTnksnQhjDbAUE3cRbKkACG?=
 =?us-ascii?Q?NLYyJsd0E/ErKC1WlVkjqX/rlkh25ZZyp+rjAvydFvaiVRtJlUwQnR7jqDcR?=
 =?us-ascii?Q?ivzuWe/Dwqr1p8Lbf4PO5p/2dlFbFKEqmFmojKoCLTL0spJyXBYOzYJXMjOv?=
 =?us-ascii?Q?QUw6zigh10//cHk5feTzAwNOsgPoOcdN5OXPV0FnI2wfJ1abL/Kzbp7ADRzQ?=
 =?us-ascii?Q?I4DvY1VnhfuZpRVLGsSpp0yOth39llcBvDPRfv1r22uOqD7vvvzUJtSMrBa2?=
 =?us-ascii?Q?OrYSZZukHL1OyEYC3skuopJCPdsNyeS7sdx2X59CQDUuONZgRnLPj2v6jLl1?=
 =?us-ascii?Q?6HVvEDf/FjePp0pgKQx8j6FgQXN1kGnaU8RDaDriqlgrKDJWzJKSYQlR0Zjb?=
 =?us-ascii?Q?30DaQxirBkZ6zuFQGXjyt9swjQu7rE5ORZbzbKSzu0RAA4BVP8vsoJVykLEO?=
 =?us-ascii?Q?/txFmTXv4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afec23d2-b9a4-4fd9-8afc-08df01db3f08
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 12:28:47.7880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BvVX0oryYagx/Onwk1TThT7g8itG/FoduibrhwN6IULq9G09A+GQz5Dp0Xf3BTT8O/7xvDrk8oCbZLoAHHPtA==
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

The 512-byte console input buffer limit for Layerscape SoCs originates
from copy-pasted boilerplate in the original LS2085A board support added
in commit f749db3a75ec ("ARMv8/ls2085a_emu: Add LS2085A emulator and
simulator board support"). No rationale was given for the 512-byte
choice; every subsequent FSL_LSCH2 and FSL_LSCH3 common header
(ls1043a, ls1046a, ls1088a, lx2160a, ...) inherited it by convention.

When CONFIG_SYS_CBSIZE was moved to Kconfig in commit d31466b382dd
("Convert CONFIG_SYS_CBSIZE to Kconfig"), the existing 512-byte values
were transcribed mechanically into Kconfig defaults, cementing the
limit without re-examining its validity.

The practical consequence is that environment variables holding
multi-step boot scripts are silently truncated at 510 usable characters
on all Layerscape boards, making it impossible to store commands such
as combined TFTP+flash sequences in a single variable.

The same problem was already identified and fixed for i.MX6 and i.MX7
in commit f7b237b81e5a ("MLK-24380 imx6: Enlarge the console I/O buffer
to 1024"), whose commit message states: "we have some env variables with
long script string and exceed the 512".  FSL_LSCH2 and FSL_LSCH3 were
not included in that fix.

Remove FSL_LSCH2 and FSL_LSCH3 from the 512-byte special case, letting
them fall through to the generic default of 1024.  This is consistent
with the i.MX6/MX7 precedent and with the majority of other
architectures.  Boards that need a larger buffer can still override
CONFIG_SYS_CBSIZE in their defconfig.

The Layerscape defconfigs carrying the now-stale CONFIG_SYS_PBSIZE=532
override were already cleaned up in commit 82d725c31cbd ("configs:
layerscape: drop CONFIG_SYS_PBSIZE=532 override").

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 common/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/Kconfig b/common/Kconfig
index 345be4b8ca14..9409a0f4b540 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -56,8 +56,7 @@ config SYS_CBSIZE
 	int "Console input buffer size"
 	default 2048 if ARCH_TEGRA || ARCH_VERSAL || ARCH_ZYNQ || ARCH_ZYNQMP || \
 		RCAR_GEN3 || ARCH_SOCFPGA_SOC64
-	default 512 if ARCH_MX5 || ARCH_MX6 || ARCH_MX7 || FSL_LSCH2 || \
-		FSL_LSCH3 || X86
+	default 512 if ARCH_MX5 || ARCH_MX6 || ARCH_MX7 || X86
 	default 256 if M68K || PPC
 	default 1024
 	help
-- 
2.34.1

