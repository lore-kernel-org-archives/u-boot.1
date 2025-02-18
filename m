Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282DFC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951B280F84;
	Tue, 18 Feb 2025 13:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UsoF9Sfd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5106B80FA6; Tue, 18 Feb 2025 13:11:43 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB77280FB8
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Er04Wk39QHek6WerEFd+Tl4KBpd00jnWqLBqZoNmNDd5nzWlTjd/z6TFMCNmVWyoNGw0U4UO8jtLxxcrTdq9h+7faMZRdBKH/SKIcIaUbDyjLE/Dmw4SKyn1TdDDuCKxQxCwjDD9VOOz6FqMBBxhkeBnm6cDsti1JA4OBTjz+dOMkhS2r2xN9IvXE0ZVnatBCA4w95nS3cWZos4YV0K/DlwU7bxi47NaXFown37FHcLaVj2NaMHL1wu+xeHQ9Olumn8OBdPvEkNwdI9HS1aM5Fg2HheAe+y/srIivX3JpCZu3w1TU3WthLyc/DasxKqi11bYvIp0svWrWifxb+7IyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+nia5oiP5LCbPoC0s0rFxa99iZBzBjQV04MfNc2cas=;
 b=PpqmmavgMiedeu339Mj31LelBNn2gxi7YK7s6QD3AdNDZj+eTgXeTTTRCisdtw4ex40fGRbS9bCYbbFg1X12AasUJw8gDgTONs7zV4RNpDqk5paCgO+z7qCGhmIS6JyJ5U8ZpcsEMr5cqcmr+4Pq7u2u+Q7ZilfcBnlpj+gHMOk5rNsldr959CYD4W9G+OBHI3mcZ5EKbEySHcDxvYSvyFhGWtZe8/sWn3y6FJHvKNsgoa37urRRJyD+11cut0vrbRb94ZZ51uEqPJH1ikUVO3o08fE4xNkWJyJKVS67X77gETQVrhkz3CZLpYTV3OCocX0KcfOyC/2vyqJYIPTKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+nia5oiP5LCbPoC0s0rFxa99iZBzBjQV04MfNc2cas=;
 b=UsoF9SfdZUNiyTognRRi8rhNLPxfP8KRaRDAfctXYXuj/WcUJhJcinJVZEF5zmIQb0z/sdwQe4Z8NFNQbFDv999eJnyHa/C6PCQrHwVIQjRUNTZ7oyPEUZkBlIjbOLbZPjJEdPMNdUYi/UQxOT58fDDoasGtZfdcMmDNRrvIiyP5P4lejb7tVs8Da5oOiHJ3oPIjiMDO+hD7ATLfuooNRYS+wB3tPpp2xbAHyo0quZabRbymomZ8Mf+xZb6N5pxAEQcRC1ZNRG/V5bk0fpFVZIMjxrTSKODQd2cdtM7XhKL7YMFAQGDXQkda2oLfw4dd2Zr7U+iVvj224HDQSxWSqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10509.eurprd04.prod.outlook.com (2603:10a6:800:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Tue, 18 Feb
 2025 12:11:37 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:11:37 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: trini@konsulko.com, sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com,
 lukma@denx.de, seanga2@gmail.com, sjg@chromium.org,
 alpernebiyasak@gmail.com, marex@denx.de
Cc: u-boot@lists.denx.de,
	tharvey@gateworks.com
Subject: [PATCH v5 20/20] Makefile: add some files to CLEAN_FILES
Date: Tue, 18 Feb 2025 20:05:57 +0800
Message-ID: <20250218120559.451678-21-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218120559.451678-1-alice.guo@oss.nxp.com>
References: <20250218120559.451678-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10509:EE_
X-MS-Office365-Filtering-Correlation-Id: 11c835d1-8744-4b7f-ddcc-08dd501564e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gXwdXsMw/wJKm4+viOYzBHtSuBpZ8lEu4tj8HnKvUUVSF3qtc5VjX1Kz9XQD?=
 =?us-ascii?Q?+gu1dwF/JSu7jxv8sEbugiwWfZilVusJki6el3uhRl9Cpel1LL47cInoNBQC?=
 =?us-ascii?Q?p0dJyMHGOCWYr9Fo9q1M60YUCtMOb68O/0JNBa3eSR6eAv/pnWoqPX8vv0Ee?=
 =?us-ascii?Q?P1kUWYdYZdOp6fLnbfoDhkw5jw91K0Pt/njToheBVzcZD/L9jt7+Req1sNAX?=
 =?us-ascii?Q?0kdiqPOE5pwZwBBjQQbkMWLFq9wkXROPiGYlLCbpGR8xED+sZyB2VliQE4TO?=
 =?us-ascii?Q?kzXwRNe/7p+FM58TCgfG0d0ZX3FiLK+/dKdocMqTlABt5C8zIwg3ywUx6rXg?=
 =?us-ascii?Q?SxnxIIDHEMLIzT3LY+GG3NOgLJAsKg0Rqr7I699nWYs/uHkujQz3EnKjKlBH?=
 =?us-ascii?Q?nDXVu3EIARo4aiouym1QajXnsMzZDs1gfcGWKlnE/Qw3Vvb8TY5PLxBNjuVX?=
 =?us-ascii?Q?0LjyJEqaC/fkhs9jOLXHAM1ANB9vPyrgtVG6vhygExXPdTRH/gOiebo9y3tw?=
 =?us-ascii?Q?cSmAm5T3TcNFYDEKT5R8Wevd7wO0PLvh2JO9P9LoXrqCdmbQRIjIfSzOkAg3?=
 =?us-ascii?Q?IfT02/H5AIYxWBCGK+U1s6pV0jxXRgVsd8A7q47qYd50gBC/PhJLOGB8CaIX?=
 =?us-ascii?Q?/YAV+nTkkpo/071VT1jfPana3ImyHKDDNwl7XjlNm/2cSQbZlA7cHkg+VWgO?=
 =?us-ascii?Q?+GwSJUVvQ21d0l9VdQrIXcAwjRvtEDVdJiuEMg0hPENNudaSkL56aSlrKoeq?=
 =?us-ascii?Q?zg4/ItwXNLmfsEofT/IKwoPI4EaE+yBlwN8kVJbDhMeHfUGtVs3BS/NIL8eI?=
 =?us-ascii?Q?aJ6lWDohg03E8ByGX4Z5429I/s9dfKNncO6GKVwbLuOoHZdSuhNcIscs5/Le?=
 =?us-ascii?Q?DZkZYw4S7OsZwgNIdXdcJsxEBj6eKlU8bTW/ql03++kH6hbe2oRJY5cX0sH0?=
 =?us-ascii?Q?WaudqfW1T/018kOPtsxwuPbBxoT8J3tdBxI+HYCJeDGecqoZNG/ScmYFhmFe?=
 =?us-ascii?Q?+1Rg7Qb+Jg5k7Iuf8kiNk6lAw+ATIlXy7sqi+hgEYMFoWb4hrSRdhl6kELCI?=
 =?us-ascii?Q?Lq83xCDh0CI6fyG1nYhpSklPr1eld8EoYQorjSTA1L4s2zhc2FQPYfYbGLS3?=
 =?us-ascii?Q?OPSx6ZZAwMf8Vgop4BhnxTv6t5V9mXWXg1Hk4JT9k6swUBQBpUrbp2qUJ27q?=
 =?us-ascii?Q?lyq/HjpH3dBCjWCHRgTaZOJ7J8izCoIopExAm+9rP0RN9fkOpYHC/Ud8mwGX?=
 =?us-ascii?Q?UA4u8kBAZcNgKngxmeFl2AQk6DIHO/WO9qGZbYoeOVpko/VJuA+Uunofk2kh?=
 =?us-ascii?Q?vHux1F3emvYFg+JkNcnjvnmTYdGGGCmTFRLW/cmSI70HU86zE46K0+CPSnJs?=
 =?us-ascii?Q?boA2mPB3O/8xflEtCMXch0ccPqt0kmpjBB+aimOaHPyTAlseE4bWCAT+ADjV?=
 =?us-ascii?Q?3vof10NWuyxaFUSunBi2C9CDeEu1dVE7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9QBnodT/RNDi+dMgmXQLLokET4bZOq+8QeUEObt6Nxn7S3dtvLeepUqRpo4g?=
 =?us-ascii?Q?dZCe8P9DuUF8zacZKRC2M2u2nbcvW7O1igY6E9DUQLoaymb20Mxe0OZ3FlEP?=
 =?us-ascii?Q?Ju2+VwATP2DGhubvB7sphjbbr5jiZSnrehNTsOcbwRiEqxOtFoFRd08ujj0T?=
 =?us-ascii?Q?EXFSht71LVcuXZWskOI5NwWPccubBSZDFrJWJD9D5C0xJ/+nkjCYkV9itJ5H?=
 =?us-ascii?Q?7XHTSLwpRsd6V9iPH13rGMfxtAlgeVaEZKE/S5CRoOT9VyEylo4IUB2HySLT?=
 =?us-ascii?Q?iDqsHZCT0LttLwKStfvRCghIgfbMEnxDw3CR/l+DqFxKJoGNcrd6dEfkWwbu?=
 =?us-ascii?Q?TeHWii2w4PdtUQlpUjbJboDVUEjDJW/k0qoYmlKjIZtYpPU5Xm2qsijrehRw?=
 =?us-ascii?Q?rLMn+GLJZYwfmUzsvjHPVoPpZ9cahunPEMHky617iZSHBmwanwRIrqXNU0AK?=
 =?us-ascii?Q?qrPCYygPePPUG0oUi3DgMfi2fC8XNbycRyDCjjDE2vzFdRw10DWZZP6vD/gm?=
 =?us-ascii?Q?/ynh6juYQ+OTrB/dmMobwIw400aKZ9MsT/sDIj0rL6FIPJ1fCQ75BkYZRtqO?=
 =?us-ascii?Q?iG4mJis/gbgX9DXKjnfNVTmrAPwrsvkPudtUeYSNZhQsrvOfr0ZWD3qyG/zL?=
 =?us-ascii?Q?gneYg60UrUGnrozXnTczC+WqNHE7LJrJ3bWc355eL/GoBg3QaJOB0Pv8a8OY?=
 =?us-ascii?Q?yOJDfWwpYLd2Cz/67ynSsUOTvM1lZ/yRiS5xNOoWwiKuEyPQkH4RAodnVAj4?=
 =?us-ascii?Q?+37QYOR808qXRIHs3qHgZ3Lgn+HGOOQDk1Ozyc2fJjcamueaHLtyC+vfuhgq?=
 =?us-ascii?Q?7tign+ns2rgzJbfZwxCfBGK6WH53jB0V/MxKNz8UUI8sJOzLF0a0HHV/3B3a?=
 =?us-ascii?Q?VoDaLgrarLpjPlQCkd4Bw8dMdCpZBUVXEn+5lZN1mcjgHWy3cVcGFknSXyiM?=
 =?us-ascii?Q?IE/AB5CEw+Y7AbNuIAGVH0yTx2y2+CkvtiLWtt2LAmNnfizwyLK0uB7pf6Of?=
 =?us-ascii?Q?iZoXAdf9oNQiaCrUurENZXj6Imw5V5xQTzFw+umY6wUgXDx+3iP7p7Wxu0tR?=
 =?us-ascii?Q?WqKnqrdPUKDtgwgT6HnZUhkts56GeWHofgWFbXqmNWVa1+OKtoQ2REpwCN0V?=
 =?us-ascii?Q?iezUoB1Awo0ZSdUlNdUDD8uGAGUkuLagUH3Ng+fHX71Ar5YpnRpHEf2AZi/O?=
 =?us-ascii?Q?pMnqYShBHYnn+KDDjJNAYWE90+htOQ6FVZWuXqkh/yadEdjoJWQK1wZVCKam?=
 =?us-ascii?Q?7KYXgzBPzofO3yhHuRiAj2lBK1VgEq0VUll8xI67SjEFCqKlpH/KqcpQ6sPt?=
 =?us-ascii?Q?qsK0+JgIkBTge+IV2fdN2vOc/xvNW9n+GnVACE4coHAyZmqUOWmcWvvgoL6P?=
 =?us-ascii?Q?SuF1g5Zan01DtZLiJAFNjjolYwYvYwqqCescYvIfQEVtu1LwaExsbjzmV9TV?=
 =?us-ascii?Q?sWLdb+i/z2njjcKlO0JoH1+7c0GeyUwAix+f8S6iDkzpBkdZArjuPsWip9oJ?=
 =?us-ascii?Q?toXCeRiK5IDVB2882Ldxg0oSdWxy37jzxbTKvCY+lr0ROvXJRhYlsGVP1JMa?=
 =?us-ascii?Q?xlLakxvxg580U5UF1CWIFtRHJz9luxBMyldCIY3V?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c835d1-8744-4b7f-ddcc-08dd501564e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:11:37.8191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BMxhYJiwEUU2nX+LWoBmstaGubDxZeCUX06czQReRmFDYgy4RQYiwjDitbLQyv8Ni/X8QHCMDq/Oh2nh1GBSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10509
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

When building the flash.bin of i.MX95 with binman,
mkimage.imx-boot.spl, mkimage.imx-boot.u-boot,
mkimage-out.imx-boot.spl and mkimage-out.imx-boot.u-boot are created.
Add these files to CLEAN_FILES so that they can be removed when running
"make clean".

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d4fedd87fe6..dd9d85e8a0b 100644
--- a/Makefile
+++ b/Makefile
@@ -2227,7 +2227,8 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       itb.fit.fit itb.fit.itb itb.map spl.map mkimage-out.rom.mkimage \
 	       mkimage.rom.mkimage mkimage-in-simple-bin* rom.map simple-bin* \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
-	       Test* capsule*.*.efi-capsule capsule*.map
+	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
+		   mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include/generated spl tpl vpl \
-- 
2.43.0

