Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB97CC0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 08:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5609087A70;
	Wed, 25 Oct 2023 10:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="pt61Eti7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF80487A4F; Wed, 25 Oct 2023 10:23:13 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3186287A66
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 10:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNDGWr1qZTbfkPvorqp97T3m9WNBXYZl8NtVDbqYnAXS3Ao37rYrX5tko/ge5UvV/GENzWOrwOFKMC/wGp0CPuWulIOeihaoRf8HE34YlfRBPC2osDVaJa5qjEFXq8Pcqq6Qu4knWGLxR8939KkakbOvJAs5ei2p81jSRHh0BHeWJ6ohRrUlAna7m4LyNhA91aYFT+Y7ascXwXUewLV8EeEJ8fHUZF7grFhQ7XsMhvYCV7BFG2cHils57UfCpKZFAK40W/g4kbemJ2e7dm2PHxeFIReb88V+I26YoHJR5zWyBY5DF9eQ6bXCEuUkvTCjux80+VmP2I3AD45r0/iZ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfQXsgaHEQUQkRjBheOmj1d4WHS6smgZFMsjbjtnrmo=;
 b=oDYMQKJ7YdvGn8ivT49S4leRxIJ6ZkhwMGtYUPymMp2Lz3zob/UO3CNl7sUf+UALpMhwQWkoOYnwTWGtflE75DQXUXCP8NpY3oOK+XjJhWiQsSV3qv/H2JzZFE7FvZkuj2jt7bRIIkSJ5DqRrI5YVml+/3u21LPFeq1bJekLTct3JK8HH551He01pGoCA7h0nmEQCU15WMKQX+a6mp03y1SFW270MAzowXFnOIq9FAfIDO+8GH7WzekFqRYcbpBBHl5f6ci1Q2VLymKtSx/qi1lJhIO0/yAD/eJIjOGwcuh4gwQhSVOlS+BeO0a7f07l+YDFpLcImpcx8Kj14TQ1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfQXsgaHEQUQkRjBheOmj1d4WHS6smgZFMsjbjtnrmo=;
 b=pt61Eti79UDkZUgjRuXtdAHsLnEdR6eSuSHz7kBsH5Dx3c/Xs4vRGOJ2YS0rEnyGH9c6ShstKNuAFW+ieXDkboKT+lRnbScQ6vIIfWqZQ7WBTP8de/9481hzp+suZl3WtmJBWfY0VloIaKtaB2hy4IQ1x/E/qE4p6po3L3zGeRc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8410.eurprd04.prod.outlook.com (2603:10a6:10:24b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 08:23:09 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::8b13:3926:f19a:b07b%6]) with mapi id 15.20.6933.014; Wed, 25 Oct 2023
 08:23:09 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH v2 1/2] arm: mvebu: allow additional 4096 offset for bootable
 mmc image
Date: Wed, 25 Oct 2023 10:22:53 +0200
Message-Id: <20231025082254.31630-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231025082254.31630-1-josua@solid-run.com>
References: <20231025082254.31630-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b817c22-1285-4444-0622-08dbd5339efb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVr4wZnK5NQEyFfssxGWxxj4xlpVHKDa2nH5tzSHMf4wAdG+jrMRbX3Cd6Ozxfq62y3ypDU9ub68sKE9bkwZ9sWbZT6M32WFOpwAdRMMwAgaA/STaqt+2+IEn5MgN1hIvKvHfm+jIiRIdw4nH4xBe/aaFHWuUvp/aW4iJ6XzmrqoOBxjh/sCtzSHwzWTHOU+n3nu1KwvckJFS+zcQe6z4xzgOUxyeXSsuOrkiTgMDV+exqqmQi9ZTMT07TwGs0+c14JthgMnD1DeqiuHWYV0NeHLZSuFbu7GUcUZhk9SZ98AQPQF+mWWvErvr/+kzKPTx0t6qJRJ2SIkFVwbFa7jYLy0tq2InC7RQPcPhUb5Y457GbBQZ1FBbz1ZuzNeq8dVmNAdIfZ6IeaPEYw2ajaBCOULYwwWQkuC4fvP7CQLWhtpO+TJNenQtPhhBbRt/vl6XRu4oNgMmb6noLYWs1kaEF8KBSRvP+k19CgBcVD2s55BZ5DFok06HGqraKS0GH1aCPqWo7SciGc11cnR04IzA5Fp8YMOigcIi2tG0W3M2qqxmCWk7nCdsgi+6kfqk6LJt+Obp1E3Bm/64pDRPCGOI4MR/AJkygAcCHC79NUI4jAboHkMHrMXrllFjlnmJWDp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(346002)(376002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(36756003)(38350700005)(6512007)(316002)(66946007)(66476007)(66556008)(38100700002)(6916009)(86362001)(52116002)(83380400001)(2616005)(107886003)(26005)(6506007)(6666004)(1076003)(41300700001)(6486002)(2906002)(8936002)(5660300002)(478600001)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c41aTJjlCnMGocCgMYrBbIa0D9KSJ2rTycKPHHjkg3VBy0EHkaHfNlD7qakD?=
 =?us-ascii?Q?BE3T3clZttPAng0CGQbCcAWDOCBupLXRaaov6edkccjgHefUXCMsBgjVXOOy?=
 =?us-ascii?Q?MHrVb8CATQ3/aeCmHxmOl+Dk8xJW1PBNtTeWomOycXZk/VelDT5P22ZXvM+c?=
 =?us-ascii?Q?85tU/+lLRHLyObtedEKdQ3KqOSkFa5M76HB3CAAiSoMCHBvLzZzYP0n37jpn?=
 =?us-ascii?Q?029SU3zkI9/AxwVK0eOYj8elOF1vEGkXcsI4bs3+rzwh9J2s9seeRHL+2eKh?=
 =?us-ascii?Q?B0jqRUe/6OTEhHqhp1plKrrZ1AqdQTkADUzXBRjAyoLUP4b1vPW7cR2GcYqw?=
 =?us-ascii?Q?HXc3N8i+dlyQeptcLE6DhQ2ucuu6EdVVvs0xvp4lyk5Ol7HDEjuk+x7Ti+Zd?=
 =?us-ascii?Q?GoxSyA6earjCGO/aVMIgoCpqUFN73O5RETliYNcfFG/h348PYuq1PdRqKtsH?=
 =?us-ascii?Q?cO2f8q4rP/gMRX0Ywy5q3vDK/I+J5IuMRlhng10HQlRZDnFmGu2z6Heuyh86?=
 =?us-ascii?Q?Cbu5G5wl9RyEe7XAQI/LYqrC1mREfld5frXppnCeZLJowzmUa0AzbSICJ5ra?=
 =?us-ascii?Q?IFq1xEHd+HiUfU+oQmYMs1pRbLr2pHHSufwGOmCuKs3qEioI5F6Z8EFW4hQz?=
 =?us-ascii?Q?j7OX09F/kxH2fnnJHde9xsZjP4VMV8eZysAHUbFykx7RnfV6F2NkhSwiJIul?=
 =?us-ascii?Q?asAxp+e50Q5EwrwZIMilCIuH1IyOGW++px24AetYh83kFD2Rw3GGTZ5FYF7w?=
 =?us-ascii?Q?x4mH+lHnRYZjH6B4WpeLrUuVHpxKNDieAQkGND+SBZN/ycHjAYzgW/Bevw4M?=
 =?us-ascii?Q?6ZKQ+bZbdi1VaG+4+9C5THwLaShL2otZg2FedxfEL+E8N4TokWiB++q0phh+?=
 =?us-ascii?Q?YjO07PGk7ILXtLqIkkGcKKhqse/1WSYKY6RQeZTwC+XttZBpy5UbW+qapcku?=
 =?us-ascii?Q?vMRj4AbvbtrQgeAOd1UlLc1qI2ENb9A8QxZYN3N41gVOR4lsIfTZ9oJ8uLGg?=
 =?us-ascii?Q?n4eY617T9qPLhJ65iEvKdi3qL8Za30Dn3I2jMKG7UpDt/eWtXwGBdv4+9PwN?=
 =?us-ascii?Q?KZPqSDKOdNZZV3+3AfDGBtUFLFPchHV41TZ3817KpOMSPJfmgXm1jmCSlmeL?=
 =?us-ascii?Q?xDq0dBhuUgAOoLlijhbsvFvTnA/0uk0XdwQyv81aYFq7Gx4scNR+dXDnYQcu?=
 =?us-ascii?Q?BeTmZ9UsFXFpgeg5SZ4GGPnT1IwIPbPPPCaZ36sWllrO8p3vZApKtNb5sVTC?=
 =?us-ascii?Q?CNPhqy3C7oE2DHsxndiDZlYjTtNomqUb5qP4QxeKQU3fxqEoXhAjjr4Lf0wq?=
 =?us-ascii?Q?KUO0lgZJut1shh4HGwswNhOAXAkT4w5G/Vq1OBd152lJi5EZJbAfHXJDuhrv?=
 =?us-ascii?Q?YlOB2HCfoKrg5Snb11GEw5RW3kA2G9caqyBoERg0RMDu91FKG8vXwrFOME2v?=
 =?us-ascii?Q?2oaYvd9Sy8+OPm5ehipfoQrYWi4hCdBOIZGAnAFtvj2tLmUC9uJgRiYtZGJb?=
 =?us-ascii?Q?8Z5XCg/h1Lv++x1sRF5+w29h3zBRAp3jIzlw+0GM9mIy0+Q8wdd7sw+r4iAk?=
 =?us-ascii?Q?3Z/Xdm3C3U6YvvxYk1ofmR/s1A9+eM3vR2kWw1UM?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b817c22-1285-4444-0622-08dbd5339efb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:23:09.1597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIeF/VWjn9ISstp7kYymoYrfDp84AAqTA+9voIX00Yj0AFFNtPIl1GywDmWxhgofYWFIH7EdUn+qRe+ZDEEH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8410
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

Disarm the error message forcing u-boot/spl image to be located at
sector 0 on eMMC data-partition and microSD.
Offset 0 makes sense on eMMC boot partitions only, data partition must
use 4096 to avoid conflicting with MBR.

Valid offsets when booting from microSD, reported by boot-rom v1.73:

BootROM: Bad header at offset 00000200
BootROM: Bad header at offset 00004400
BootROM: Bad header at offset 00200000
BootROM: Bad header at offset 00400000
BootROM: Bad header at offset 00600000
BootROM: Bad header at offset 00800000
BootROM: Bad header at offset 00A00000
BootROM: Bad header at offset 00C00000
BootROM: Bad header at offset 00E00000
BootROM: Bad header at offset 01000000
BootROM: Bad header at offset 01200000
BootROM: Bad header at offset 01400000
BootROM: Bad header at offset 01600000
BootROM: Bad header at offset 01800000
BootROM: Bad header at offset 01A00000
BootROM: Bad header at offset 01C00000
BootROM: Bad header at offset 01E00000
BootROM: Bad header at offset 02000000
BootROM: Bad header at offset 02200000
BootROM: Bad header at offset 02400000
BootROM: Bad header at offset 02600000
BootROM: Bad header at offset 02800000
BootROM: Bad header at offset 02A00000
BootROM: Bad header at offset 02C00000
BootROM: Bad header at offset 02E00000

Valid offsets when booting from eMMC:

BootROM: Bad header at offset 00000000
BootROM: Bad header at offset 00200000
Switching BootPartitions.
BootROM: Bad header at offset 00000000
BootROM: Bad header at offset 00200000

Fixes: 2226ca17348 ("arm: mvebu: Load U-Boot proper binary in SPL code based on kwbimage header")

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm/mach-mvebu/spl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/spl.c b/arch/arm/mach-mvebu/spl.c
index eaaa68a8564..79f8877745b 100644
--- a/arch/arm/mach-mvebu/spl.c
+++ b/arch/arm/mach-mvebu/spl.c
@@ -71,8 +71,9 @@
 #error CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR must be set to 0
 #endif
 #if !defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET) || \
-    CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET != 0
-#error CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET must be set to 0
+    (CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET != 0 && \
+     CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET != 4096)
+#error CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_DATA_PART_OFFSET must be set to either 0 or 4096
 #endif
 #endif
 
-- 
2.35.3

