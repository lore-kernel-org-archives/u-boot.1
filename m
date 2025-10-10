Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108AFCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 12:04:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1588422F;
	Fri, 10 Oct 2025 14:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="qJGMOpPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1DE884229; Fri, 10 Oct 2025 14:04:41 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2F8083E92
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 14:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS/2HyX0EFWv3D6YnOJ2BDNwCCIQlukIsgTqNgfcAM9mPOk2lBvi/Iu+tpmyDv3BvX22qDgyuPWj3mfGzLU84JDqjdHqq+HafEalL2uA7e+6/1XIhB0c0lxXtCUSmeimAvjlzVXCOkxe4iDpbAYsXNTAJWbB2zisfc8jvS5ze+ftWmd8/m4Gpawoh1GwdrgzuYWdNvJD6efHhKISTIQRXzDVsFTYlB9ChU3YYVel1HKugGdaMMG3Zo0vqbDE1UOenlXWaFLRlyPlAuDFLkKq9j1hNOzZ3yKg6N1PG+UphLl8/1kPG9llDjpCt1gkDFdfb0i0dDuQa0fMD+PKVPaLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6P7l+YWov0YWuNHukzycgSiYKMLsUpRIVXVOG2UUMqQ=;
 b=vvf7znBGK868tFQ0kx0BYsKvYB/uCW9MgMaw92F5Uygf1qkc8mRE96Z78WatENRXjK75EFAqKsnVw19EQ3L5hEOeRlJqeTev78Tvi1kBwXI64uiaoyQUuiiKrRi0liARDnE2ZVYMdpnswVmOETwFK1BB7MeBpAte2tZzPZ4Mb4Ue5ipErmiq0r5MwihMu0RlZLGsjujIfluAw7oPpV87PnzXAb4/aT648HKBES8r+rNjQ88Gz5uCOcEsGdInIHo7YdULs5GSEN1yYNcxiZa8tnL/cGsS8R97EZ7B/MU+aKeJeZvCgSfEhFGLgyuQiZ92by+cwKN0ObhU6KEwCXLuCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6P7l+YWov0YWuNHukzycgSiYKMLsUpRIVXVOG2UUMqQ=;
 b=qJGMOpPQMcmUKsFucei/7loxzkKdrdp1nDpzkI871jHoBgyHUVCsf8aes7X5ownCZMOqZ+XZyGQYBiUA7PUcFBCVOQyhhDBAIE2wlWmCJIZ4a13s7K5ipXt+Fq5YzQzoSPX/n6uHi1X+oN0OFwtBDPHN7auv4cDkA/4+3BuIeEhIgaOBkdCfB21B6uCg3L7WSYanGQiACwGFRaUJClaRLBioaiFTj1Gu6u9BEYmAiU4YWvLkKfQtA7at1O56do9nCeERyMIuWcxmdg4ws0gVPp57EjGXE3ulgBN42dK7qxwFJHhkOnZWR2fJ3hL6o+st1go200SMlNa0NvCY537lFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB6650.eurprd08.prod.outlook.com (2603:10a6:10:26d::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 12:04:37 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 12:04:36 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 0/5] cmd: mtd: improvements
Date: Fri, 10 Oct 2025 15:04:23 +0300
Message-ID: <20251010120429.1532370-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d40ddca-9fd7-4cba-8fdb-08de07f52e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1E7h3o2O5jcIFqyb6nEtu5jCfef1YYi4j66YsYgdtizu50oap50zMAJJT1aY?=
 =?us-ascii?Q?scYYj9ARjFESEqnuVpuYvtncdOfOV0TD/zKh+LUh4DJTHp8Mq65nPlg7TzSA?=
 =?us-ascii?Q?ri2c7J+I2YFRrcsaJdZse4kClGrh/MruDT41nbT0Wr8DsIkkXghEbIQx/Kuc?=
 =?us-ascii?Q?CNdXPqkMs4t9ZZuRKqtMyF6WlCLZHf8GvKHPkVizBLDgp2rlAzE/7qMc8Jjf?=
 =?us-ascii?Q?vfLuuQIQeWSttSyb80YepUhUrlimNMQz8bU/nDzTzPGanyjGdXIg655C9+jX?=
 =?us-ascii?Q?Ns+82GZsUJtObUZr10UdzmQ/fkhHnQAikaV5Mg8IW6KswKsrNZeKsnRTm0ds?=
 =?us-ascii?Q?3KOVq5p28wVsqa+M2QZuQBgexlQYpcyzn5ANr+wCHyllCKsaojTmoFE78ZYL?=
 =?us-ascii?Q?Pv2ST7IcF8Cw8zhAQ/d3iyx0OvafRqSJIRODDLy3BvrQchCtDatZIax0E2zf?=
 =?us-ascii?Q?hTaZsjuJxPVDN6JLDMl4Xv5JENncb/IPjAEvbnhciXVi5MEDHRZl8JxcZodf?=
 =?us-ascii?Q?xTiHpfjmGLfVkoW80XAZm9xMfk2BpMoCE7+4n1BvVwguvt45BEc5Q1Y4YBxD?=
 =?us-ascii?Q?c/sbS4UVq382Pwey9FXsEkoNtXd7kZlllUyfieAMbHXUoH34qQWNCFs+sxvQ?=
 =?us-ascii?Q?+pQ+tvDRsaGcre/XdfykMgnK1hePHkbV2H9FMxeT63CqHBNbmDdLmyIftp0D?=
 =?us-ascii?Q?8iXlbbhTPKAS20ZFRH2Dyq/s7y1Fngaeh/CmKCWkzbhNsTvDXs1/qXDhDwX4?=
 =?us-ascii?Q?l87Pnerv7SSCVyGT0DZv1kQyeLZUcY/eiHvAA5lBtlnALls8cyezG1gh8+TG?=
 =?us-ascii?Q?sDjxqDIJqlFgNQpkpt5E1jSyD3PV0rH/sL3N+pI2HLLmik+kpcFT7aEY19j+?=
 =?us-ascii?Q?MyLBOOWfpjQd8cvPqczaYDdwKplJuChktaLBJ51Jd4pWSgNPq8LDGHSTAKPZ?=
 =?us-ascii?Q?nDPLP6wuyzVPmTxALfPOJ/CWWoZP27mux0m3ajELt13CCXwUoZWtd39ggAc3?=
 =?us-ascii?Q?rqUByVHmneA7xvXZc+YKFr46c8SsWpn+dKb+viGgVnZKjPpYIlHDskHKsfZw?=
 =?us-ascii?Q?FWWbJfxMPNsN+O3VdUx8TyvWkCjJJvrD7MX13C7TaAyEM3PQM/GkXCGA76Qx?=
 =?us-ascii?Q?bFy9cfxlzcnHh9FC/BvymEa9poquxXWIkut7KAAXHcSMrOTAMutGSQmPCxoL?=
 =?us-ascii?Q?E66qwH81al1oH2ws9lvrnbFE/NenzSS43xnOU32/rM8z3dGrpd6gjhW7a3cB?=
 =?us-ascii?Q?AxyFRphtPppg/k6QaFXLEmCqIOcvWToK9CFQS1wWYj6a2AOGwC6a9Zy4s9ar?=
 =?us-ascii?Q?zdO3bNazTBvvSn/v7bLuQhf1SVPqKknjqW9YWvJUg3xt9zyMNLVLYovaL46E?=
 =?us-ascii?Q?WjkeK6FDu9JBnS0cBzZCzR+FbeVHFNgK/psXOWfeyVFVMtR1fnsylwVRk3vS?=
 =?us-ascii?Q?KZhqH1pAUtF95PcBnMOWS81fajKztP/3tsF3dL0CRWYsO4CJoefhfYSXMYea?=
 =?us-ascii?Q?uWfDXWfb9tDYT7fmuG4OnlPcvbZlBO6ejZcgwc6epfrT5zJ39mLzzCH4KA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xSHaybNhQpiwjIt/budCy0wfVKDb6DW8MiuFt97YQ0pPO03QB2llWyg0EGI+?=
 =?us-ascii?Q?PHixiZnc4n+5rBccU5RKl7kHteofbH0JETrG/JkrPXPRjPRgufXS9gPfCCWl?=
 =?us-ascii?Q?NJSabzoZRwKK7EwQmdMWwicTlbkoU5YU5CYW33x+PgR5RUaSN906SoXy4kYw?=
 =?us-ascii?Q?48pXVtvuZ0+7trWIST02pukiM5SCttvZzM9GtMgldmFKiLd7Hgf2cNXBk0Vl?=
 =?us-ascii?Q?vpDypmHjhyjtV36WCWCO2+OoKTJZfLCr2prRsCtERyuhbjnf9STIYV1KIoFt?=
 =?us-ascii?Q?Agtmysmh/etENDzOW+bIASTcmfbtoJji7D+b0qTJzTdjh0O0A6MKozseF9Mr?=
 =?us-ascii?Q?iwnOCJAGT5QW+hF487FX1h96NXL3xLIxJF1xrncatRksQp/GV2c2gd8ZrGAW?=
 =?us-ascii?Q?N5z0oIgzG7Fwz/G5gtPUg/l75bjRTXoEUqZDaLU7eUEXINMXZ6E/01ua+q9/?=
 =?us-ascii?Q?/ZhDGUumUTKayIvf+PEmUqBLdhBt8vo7YHaqeZk7oMuiYqRO0k1MddVQ1g9Q?=
 =?us-ascii?Q?I7NsYyGS9NgXFMze5/rabE90KdMFxaP7KOD10RJb5tw1/lf0E4MNgY6QYaSo?=
 =?us-ascii?Q?eyXg6mBm5+J79ms/hfsvCwJ50wyZKtSZsyIPJtVTRk1rP1YZgISnVsMvBVcu?=
 =?us-ascii?Q?3kMR59b/I67VoMHKO6GEezKUvuhJxq2Cn+ZE1pnw0f3aj0PHgeJrpMzXOllp?=
 =?us-ascii?Q?Uj5e9mmlApCUsfRU2aAw0Z71lEuViXCnycytJzNpS5ibMZW4yG2wX+U37KnW?=
 =?us-ascii?Q?So2DL458sd5PRm3aNx3/Ka3Jdkwx44u53/8YDooBvF8pm+ayxfOnqAYmyT9a?=
 =?us-ascii?Q?+5hTId6lG+3M++H0pP0jWkWFoflNG+Cii9K+KaUmfqmAOtPwpWvwqQFqm2sU?=
 =?us-ascii?Q?YEN/6C+icG7ZhfJYTnVXqT+PwCDcEBE5peRk602+mzBv129wqchAhhsqU3pO?=
 =?us-ascii?Q?nazVpvhNeloxz6QLPPCWHaabd98WOxDc4MTJ6PG2v1SwWUXvgx2I+2ejuu74?=
 =?us-ascii?Q?cwmKstYFR/nxt3nnrWea8iqAKzFYLIhFZGPJB5eOCHoVzEPZcI1RhvTMvGJJ?=
 =?us-ascii?Q?ADf9sBf1NP5cEeBTrdeESAaVpnei2GV2hL/JuUDpkKI3hanJKJ08Zwt0e2Lq?=
 =?us-ascii?Q?n0my0yAYSqpNUjFqjBMoopx25iJe+hoZU9f0p+1GVCBcFnFbF5UCf8X5GANb?=
 =?us-ascii?Q?oNscmjgflxT3FQ24r/ZMMMhkklLCv0UVIKtDVR27adgASWxrOkvcC4Si24N8?=
 =?us-ascii?Q?vbK81vo//gElLiAHIWL4a7tnmL7EtKvM10czUwUfR5ai1CISceBFqyCuzM98?=
 =?us-ascii?Q?azTHJKLRR4XWZQz+89qldFiTxyhNXxEmkmkg2798/zUQMStOo7BpLGEW6JLF?=
 =?us-ascii?Q?bs94SqrwjFftJyaKK471RV8TNN+K2RAVElXi25eMr7xN9jkRKlhjlpUyy7HH?=
 =?us-ascii?Q?mZmy+i4tTDvDNQ917m58M+oTHoxNop3CBIquDTZV5S8lHuISVtPn7v9QEsn+?=
 =?us-ascii?Q?8rNo7WGK6LclhQE0fguN5MbdImbFcEIY/7vzOgEUXZaNTiCCqaAy1iTsplzc?=
 =?us-ascii?Q?NaNPo+7//pgraeyyn0lfrOInZ1c3cZwM51O1tWKnosjBU66VJhcunciv8fU2?=
 =?us-ascii?Q?XObq6ac7foOxm1JTqy4Dl8Q=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d40ddca-9fd7-4cba-8fdb-08de07f52e77
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 12:04:36.3380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/VGcw7kwGNb221ClTz+QHAk+zwWzDWUJ2y2dg5AhbheF6mFpB4CiXL5xaNO8nRhaUc6omthvTaGFgb1afQ9HMjICjRu0QaBwJu9CJnls2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6650
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

Some nand flashes (like spi-nand one) are registered with mtd
subsystem only, thus nand command can't be used to work with
such flashes. As result some functionality is missing.

This patch series introduce following features:
 * 'mtd markbad' command (clone of 'nand markbad')
 * 'mtd nand_write_test' command (clone of 'nand torture')

Also a new command 'mtd nand_read_test' introduced. It produce readonly
test of flash. It's mostly usefull to:
 * check general flash state,
 * check the correctness of returned number of corrected bits.

Also this patch series fixes speed benchmark.

Changes v2:
 * added detection of the blocks above ECC bitflip threshold
 * minor cleanups of 'nand_read_test'
 * comments of Michael Trimarchi was addressed

Changes v3:
 * speed benchmark fix was added

Mikhail Kshevetskiy (5):
  cmd: mtd: add markbad command support
  cmd: mtd: add nand_write_test command support
  cmd: mtd: add nand_read_test command support
  cmd: mtd: fix speed measurement in the speed benchmark
  cmd: mtd: add benchmark option to the help

 cmd/Kconfig |  38 +++++
 cmd/mtd.c   | 480 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 507 insertions(+), 11 deletions(-)

-- 
2.51.0

