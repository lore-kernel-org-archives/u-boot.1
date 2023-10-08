Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631FBE95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 12:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 990AE86A27;
	Sun,  8 Oct 2023 14:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AHcs7KHQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 433968692B; Sun,  8 Oct 2023 14:47:47 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::60d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF13186661
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 14:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPFo7xnY2r65lamrkp2LOyYOB1b46cxrdq7+LDUVy4g/unmv6y1ZHFsOeHHNajIIcqbd42i1JctduRNvGaFWasf97Jb+1uJc0IKme5b+Gkwa3pCNYag7+TGbJaFNbFl5cAaEh6qS8D+RsOrpua9/r09TciZyNg/daJ4QHx/lue5kQFRA+dSAqgOVwJgIH0MFPFFFu4c7yP3TwSrZs1ALghzZqezVDImwWSggnPPgkFRC+eQFCoxQJKq8wgMDND/vctNXpsW6rwCta4LequQn+cuKUONzg04hcSlHiGvjl+Ksi3I4KtPfODdhlTlRyyp+psG1n1hZpH9SZeGjD+rKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7QN/bI1zE+R0kNF3MxUD5wBQPul2gVVBy98bWY58B6k=;
 b=hRQ31Ij7bw4Dr6yuDnMJ/rNpUxv7Vt2fte2RV36qggOP+3Xqxaxsvn7DaEe2DgquaSS12VRUa8aMleDhyrjqSbe9jQm+HSgcYt8Kq/EZmfSTLxiHYiU1QuncXVqg37fBEWqzlRi/vaF+gS81CyeQ+v3llXW155jxUQhv7TcJc66SA0XFGUxhHBkpSwELLZ2wAGwKEnDylyWElOPIvvPiusrkTY0K9iCxcP17EupU5JmjPcE29tX88qTxjNKxBbaUsClQ4GEk11glEXkuGGyY08/of41Ifxkxx9/+wBUHg0fh0EgNRzcoVnNSGqUQ8+dujJJm9aAOSlOTGdS92JuB4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7QN/bI1zE+R0kNF3MxUD5wBQPul2gVVBy98bWY58B6k=;
 b=AHcs7KHQ3zREIcB2zrZqviV4JI3k/uHGnDTPFhhk5HOWLZXpYRCi3nFBX1Ia6md+2CL0cSOsB5UbIbSo8HO33NOI982fryWHVsizK7qXo2Wv5k5YDhoSP/xYs0IR7v8/XU34zNl6PngnPFpRiqBRRolKlNxBfWveNOSYiUxRbdY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB7651.eurprd04.prod.outlook.com (2603:10a6:20b:280::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 12:47:39 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 12:47:39 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH 1/3] arm: mvebu: allow additional 4096 offset for bootable mmc
 image
Date: Sun,  8 Oct 2023 14:46:19 +0200
Message-Id: <20231008124621.18803-2-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231008124621.18803-1-josua@solid-run.com>
References: <20231008124621.18803-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM9PR04MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: 3674252d-4cdc-4fe1-3bd0-08dbc7fcc188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzBaNMqF4mKm5pKrZsbsSSO2bZGnoUIFr+oZRv/Mwf6Pt5h3jmCnzTF4AVClr8ev5liLVq4YK/3LYd3PtiqDAJt9hA/RYXrgf+a14ghN6mERy1crvuki6pbVTDdUg/f+YgaHNMRW3rqQf2hhVX7nuyDc3QvI4lX6W01xelDOFK2eJELLpxyKvpFlOjX2/UvPnIZwUDXs8MqudsgNYdJsfwF/n7hQJiewsc4cgEORDqwu66lFKa+buCArRa6MY1/NnSnFu+XZFe3If8i3ptUUk2RRDt3YAVwy6suBSQUFCGRIPbEKqrOZPXZRKaVxNJIojZzQzJ7P34JsFZISGKAkXdyCU5roF7fSWPlj0EeoyZzWf6MMuweDQ6LQ/fQwGTy58arFmpMhwBam8cQa/vutwvvLsHfm2snd8n239yhtVmR1l4zRzWgLemjriqx0STtd6X3LsS7SDfzGBaC1noFYWqg7d+pJ5cE2pD2yFQf4XuXJVAdUFVLoBkBXPJ1NqyE3zXiNqIO+uxgEo7T/WUxfeGbh5o2tP/AO7mWq8eW5Amt+e5KJACGmFyr40sJ2B8hiQl1LP34pdx9rr9mzTOP+IC14pSWbPXFXzEu+95rfLIn4wBvKh2Dnh7fOenKMJYvH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(1076003)(107886003)(2616005)(26005)(66946007)(66476007)(66556008)(316002)(6916009)(8936002)(5660300002)(8676002)(4326008)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XPgi5dJKJHH/2RR1k3AG1Vv/JqpkKGVHnmIu0XC9llaWoeyOvZTTHj7Z3PrF?=
 =?us-ascii?Q?9htub5nOGjKWpt4S9llEL4QoyCIH+yXEmlEwdyb+GDpkLokGlTeWj0qCMH6q?=
 =?us-ascii?Q?vmCXuhn6QGgauEMY24rPHN8//x8okPf8CUtIfTM3Ih/R+dLiKps8rLvsITun?=
 =?us-ascii?Q?ZVrWxk8iOSm0zmGBR3Qm8ANFi4ACaSpFsuAcbrJ9AB0McjxV6J4snZRephYb?=
 =?us-ascii?Q?GiRJDnHGiOBc7z2DcwK4RVLqY6YraKg4V3Dk1i3tl6t2mr1Hrg6jgohQ/WaZ?=
 =?us-ascii?Q?MISV5nslwEp4e3ySDQlOvPP0nQ+COVVfTWunbGZBOHX2O8KbBgDGh8nKFHE0?=
 =?us-ascii?Q?47MGeGHWgis8JLODgtzGJQCFehzJv9oeS6IRfHUBNFzrNn8uAuKOY6HW86fE?=
 =?us-ascii?Q?Oq8UTkCvWD4etvslnG29VwEqcDTjT01Nm9cL4kSbajR82OZxoM3FucMPNnUS?=
 =?us-ascii?Q?3qy9njQvA1a7tOxVjgK0h272HFofbqUNAEIqk+FJ53W8yg/tCg/ynDQmc7+N?=
 =?us-ascii?Q?jNFpx5VAQfMnrkD3iiUd7bKOhawkHPPRcDayEcUK6F7vpBkAEhxPpIG/Gtet?=
 =?us-ascii?Q?ivUy1lhVaMdPGg0cvPml3cV00+elR2/zscsO00K0GUS981weg6vpbpunP9G9?=
 =?us-ascii?Q?hnWHEO3eVw8V0bhltr3tinrSr3bQKR1vfeaffjbaEtkB1ALZiuYPsgmM5Ki3?=
 =?us-ascii?Q?wc/lsSOVmUCWvHKOreQXiVDKCB4iz6GgwlG+Q5ngmVTwgPHT7XPynyHwtGrW?=
 =?us-ascii?Q?8DKDEN0KSCIDdJaSAFbsNGu4pVNF6pVqJfMAF9u7PUaGK1T/d8czwxybV2Rl?=
 =?us-ascii?Q?9PIsygqAqmCK3W3c1yStfZj5J6Nlv2PBXA54nPfF/+D32M9MeqldnQ8jQtmi?=
 =?us-ascii?Q?sl5o+1AlcMTmhdDmcNYx2tj0V6wNTOkKHR1BpAR7mc6/jFZxXm5OdivqhtDT?=
 =?us-ascii?Q?qLca36cU6Ii9EGBwstBnoAv9IFjQwEQ5iDK4MQypIb2ZgCOz8HwyiZvBoEE6?=
 =?us-ascii?Q?revOlmFdKSkZZ0Uuhx5DU9dGDeoWu63MtP/tkTrhsnjT+CRwcvfdk9r9fLgb?=
 =?us-ascii?Q?ziz/UhcoTr6mGivUyXBtOrYt/BvEnn7DbV1jAgD/J6+lXsFZ78FHWyypa3i4?=
 =?us-ascii?Q?uHkVoYAogXM5NvZQh1AjpN2xUo4PM3mSlq+9NGX4H2WhHmJlPqEvx3jDUXqP?=
 =?us-ascii?Q?0tMa2Z4Mpy1i20lb7hELx/AcYhQ2aMMd7OJPT7Se8Euj+Eo3YKBwF5FnHKD8?=
 =?us-ascii?Q?LJQYoCwnxgl/XRXKTLSNuu5xmNPxbbuGxfFuDKCvFtt0ePC0DCgyVUeAyBEP?=
 =?us-ascii?Q?LcdpmA4dxDw0yp1TT0+cOlVu32GIfWoc7aToUQKRLJfO0IVJyfCFDaMkoQr4?=
 =?us-ascii?Q?Mey8vmqFcCaxsFwiHkLMDWaJ2mQrm4EvDOVuaUUFhxLSHjCD8L5o62CRrLfQ?=
 =?us-ascii?Q?s4pMAjN5VjE+66liUaVtv8UnISrBx+jY9u1RUaKBPmhpDzqIKLcBsS2TaM2D?=
 =?us-ascii?Q?+ptIiEaQE2MXSY01h7Qna4kOToC25e+6cnuyM+WPamCZlWRqvPRGGZwua87M?=
 =?us-ascii?Q?Rekq8FVNC+kBzSdVXe/5pZf13I7/PiKnp21GTXUm?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3674252d-4cdc-4fe1-3bd0-08dbc7fcc188
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 12:47:39.7347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1azz4qDepml5muCiRjXQMq7qXI2s+/8gLpQFIVryn7njpA0ftVim0JCrG6F4oAf3k0BL4vJ+XRqmhk40kG2JiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7651
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
index 379daa88a4d..0dbc12f66ea 100644
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

