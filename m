Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84E5CA0EC0
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4856581D5D;
	Mon, 18 Aug 2025 12:06:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="j/AW1XcG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE94A80107; Mon, 18 Aug 2025 12:06:29 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51573801BE
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:06:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3ah9evtb0lBsMQml7DkOf/QAoV/7oqbp2ppY6Y/VjvjbzlGohK5PbD37hQOZgWyb95M28HBIW+6LjXqSd8ZvobQEuY+aha/7z4Ghqo4p3ZA/g3ARvrFeeR1+klN4HlmO8+HVqoY8RPvTeas1xhnPW84haLWu67RKtT2/xV2Surd7tRcx6KB8rzTxFiLWtYQsbhk8WUTOwra/E4Y5crDPFHBgVqLntJCk2H+G/jcOoa2HKwGqQUIP+A4AZKT3CFg658fJiH7nWvwPBhY4FiQxA+OnKzA4F09TRSMUBIfEcom1xwe0deygQbCG8NbwLOAv+J1GaovX4t39HuVeeNe9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsyrMPGpe3uB4RVllS6FZKU1MhKScjRgFamqq3HR/6Y=;
 b=NCmj5GgufeRSUDFtipMxQkgPuO9zlK1gvV9TJHWw4OztHG6QXTtD9M1LNToxL8ss0esCBcaFtE/oACEolCYT0p3QblRWEaSy0/JZBH3zA0h/Jv1/u1ukxI1ZDTiMriYLfN3l6LXuUAoEzlV2zbhcyU7+w2TqVc9qhpl4eUkOKGITMhzQfb0OkUPABnC/x1cbgjOOk2U1NisHqoZ+aOP3Lp9JRyXlrqseWJtCTN1L2A66gG+kgoyztyI0biYoRbDmm46iSIPWb2J2PW5f3x+77DZ+0QLZvRfxjvLEB4lJUhNdu8tgo8ETEjHtue8dGsWS21sVTgH5MXhEtAAnYq+vkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsyrMPGpe3uB4RVllS6FZKU1MhKScjRgFamqq3HR/6Y=;
 b=j/AW1XcGQLVhBPZiZasm7nMU8E40vFZfDoSSel/M/fppP+HqebIBrqQrVq0FEIO0By+IGrTqrdGTF8gFkgVLUAChWpyXtb8qR1ZNIagwTA7UQtglYZ8yJ083Tud7z41ILhYTOh8GX+/dLmFBLvBNzJ0UTBj/HRAtM7eHmNLcfITX7dQYH55VCEA4fh1Dw2OncTplr6Ldm0iyoNRdvSo81gg9bmcBmQAEaiToH7MiQiJF4JlaVpm4QvFFdLsBGqW7khsis2NECvsl0lyPuJZA3iB4aHCxsVG3WE8diMxp80QAp9qfarYWeGrDd/qfUb2cuTql44hAODfbQygqCexQoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB9719.eurprd08.prod.outlook.com (2603:10a6:20b:615::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 10:06:25 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Mon, 18 Aug 2025
 10:06:25 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v6 01/21] spi: spi-mem: Extend SPI MEM ops to match Linux 6.16
Date: Mon, 18 Aug 2025 13:05:53 +0300
Message-ID: <20250818100614.432931-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002E2E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB9719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8285e1e6-b17e-455c-e297-08ddde3ee44c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|7416014|376014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k2zTngA3Ka0snxQ60jOm1hzy60vLEc0M0A/IrwYlXwoiT00UZVJoRlUENNvg?=
 =?us-ascii?Q?dAldCgqptj89t2rVW9VpuveiailJDhKRe3ODz9ITUbp86pyxdXTVpObg+HLs?=
 =?us-ascii?Q?l8jT9fTJDXZ1UfKZLuJuZ6ND3cZYrg6Piozq1ByAiQrlp+OeWtmXSReQVLDP?=
 =?us-ascii?Q?mkFn6B66FQq0CbbTF+wxn71xmLmgnZizsSKm/xzsQTZOugk9KYgb1aIYcJKc?=
 =?us-ascii?Q?yWN+f7zTAHO44MqnNu9e2sElQi6O1L9CNRD+70f7O1Spco0Xrq91KcqrEpOG?=
 =?us-ascii?Q?9IJgyMRFsQsoHbYMDV51RhU71XubDcrXY6t73Tb4kCxUoNuL/U309mt+Oukg?=
 =?us-ascii?Q?4ccyGnUPr+uEQTo8ta+NvNCIk9nElzCfLstMb6GC6Fq28nDVHPqO3LrHNuoE?=
 =?us-ascii?Q?cBQA8sQ7IdpjT2wSXFcwUdeM010/OuZa9YI5jJrLxpJx7hi1xWkoLHKoYanl?=
 =?us-ascii?Q?AD3Pq0ZTAaIOvGXs41/m57Z3E9ulbwQ1TY4JHcI5HTPwrdfXxkGU/JmcEt5G?=
 =?us-ascii?Q?0vrS36RUuPWSpRkhp056zImwwkGLbN1T3JnsaEi91wrQiTRWcQLVG7ut6hXK?=
 =?us-ascii?Q?yIkyA99g9q0+Ug9Lcx0xioavJqmlL3LaAzm9w3uAOIp1UV5AHcltY0sOWtAt?=
 =?us-ascii?Q?x0SX+HSPbKN3juVHGm9RCc1lQgIPBv3KNXi8Eai8AYqVdHCrumx2piydM1Lk?=
 =?us-ascii?Q?FSWFs/JBqP1XY3KIOF0VL0lNFSAbSIlJiiCiVLtCFMkAt0BsSH2Vl2wlFiS6?=
 =?us-ascii?Q?HbSErX3B6jiI341I+6ec0tUqLJ2MwReU0l2qNXyhPLANzRLDKzcm2vkLohh1?=
 =?us-ascii?Q?i0sRpmJ4kDx9tSgN34p13//+SrLq/pXYAMGt+gUvcLiZlwZyhFtnQliWdAfb?=
 =?us-ascii?Q?Pzn8cKHEeQg1eWFtSyifRcTZGPF5pkBbiSQQBE3GjCGYVzcBhL/MFLzP1uXy?=
 =?us-ascii?Q?ofkeNkTcFb+d+IjhMwDe4FPVD5bFtRfrppSn41SypIMs1zFM/eQY5cQoZ7px?=
 =?us-ascii?Q?xK21XdlBTsaghQ+CHWJUkQvKXSPF53g2W75gwpVSUic39OGMDg80yDgUsqbN?=
 =?us-ascii?Q?lSV3EunFugm2awWX14k3suvPdysLRyXLpAboZmChlU11rHEfDaCGSatIZukY?=
 =?us-ascii?Q?2kRAmqUb5Ft/A/RtJ0/t8EiPAjZJWFJ0Tz/XJbTGVYjrHpk1LnoYzj7EF151?=
 =?us-ascii?Q?8kNtNYuHFnRFPY5HPwVK4EybXHAd8kpEZ9umLwFKX/kqKvcOAJWyL6unP2yq?=
 =?us-ascii?Q?kdo5NeW8aQ86+eF26fnj/4+1d3wM/Z3v9g9vN8bN6hcSTTdhXsY7WQ016TCW?=
 =?us-ascii?Q?LagptM02/5Nkn5xdUOOzNaankHU29P1XqaWfbUrowBg7dwqLsWGsV+AMthz7?=
 =?us-ascii?Q?TORBbbrqV3JAVuXnLV4gJd4VyEIi72BTP7BJMXU1Qm6maB97yO0baVAQ9OKY?=
 =?us-ascii?Q?S78Woe9gVcfrBn7hi1uGH/RbPHgGxaOpbB/6euiTpR6HHGQAprVR6NyDfmu9?=
 =?us-ascii?Q?x1iS+oYEJXwYwbM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4hMBgM1EQVrzuGJo7gzFNdlR6F0lo3ISJmDA7CTntpVI79L2ApU/0PIvfaWi?=
 =?us-ascii?Q?3db2/Xs3v+x5FgFzkEal5FZqJ1tEM8n42gDeWhiwfgNmDCPVLxneAuqKKIb/?=
 =?us-ascii?Q?PqLZNgsr4pncjEU6XYa3IEsyzVf83CIaNZkKjN9l4lmm4ldLVqoOKzemsiV1?=
 =?us-ascii?Q?M8m4hehLzi7p9myDN2qfIno/HG9FDCjptdIvOxlndyuWYJzfwgRHQ6s4CoZb?=
 =?us-ascii?Q?ea3FQF+w3aimztkpa2nezvAJFAUvzlr0VrQ7oNbhr0AVzWa/GBA1TZXQRA0t?=
 =?us-ascii?Q?4yDkBYZz5J9Nc975BlNysNghz2aK9W6zTdYEB8jhN00W7+wcLyEGf5VhR6P/?=
 =?us-ascii?Q?CDfgyWVXjLbiRb8ab2b0lKXeZfOIlcS0nF3TTRT8Tpm3YxLwimEAkiqWCJWG?=
 =?us-ascii?Q?HJWl6bUJQzqLXoysAlQa7OT1emeRjSpH36fkqPRikWz5JUgwfeF5U+51Ar6Y?=
 =?us-ascii?Q?BdPEYooDty6RFrtDGX59SbeTjbXlM4mzzNxKfNfaX+BoVmOk5LUqScP5pgA2?=
 =?us-ascii?Q?zXeu+yW/oawVyLtuHdMb9/JV5Z6dazd2IJUPSNACWt4VxXmuSiqABdONjqAy?=
 =?us-ascii?Q?bBCMNg84yfjAAcwH6cmRRSZVYpb0emSPUmM7b4HPSOkTnb8AjtBXyfwejS42?=
 =?us-ascii?Q?1Jg3JdIShvwJZCYTaX9G+UUUEE/ycgqJMtiracJ7yJyAO7Sjk/ElP/CdY9+N?=
 =?us-ascii?Q?vFL+nx786blQKrTU70C00+SykCO+BWnUYu8Ws81y24ocC6WR0mgS8heP5oVg?=
 =?us-ascii?Q?xXtqNbQm0ZPIpDWXfweTIVdSqOjAiQawPdQAyz2DNnIcrPOIdA7l6pW2JDNr?=
 =?us-ascii?Q?ypIkrHMpDJhbFOIJbimamRkpDHC73exyFNbVT7WTOc3X66del6muOJVUNcPi?=
 =?us-ascii?Q?w2mzhtrgRDmDBZSm7Yb4o7z24Mbe1EsKyDpfC3LsweTAzR3DZA+XEaMiK9/2?=
 =?us-ascii?Q?TuA6J2DKo5ciw3cHv3AZ655eYLywcIWjn2mQTbymielUkfCA4H7F0SeC8a0D?=
 =?us-ascii?Q?9/4anGFepwZmlzoB/YqvX8WALoh4s+XHlQGWUWATRt1vkOvCXud58vuMxI1r?=
 =?us-ascii?Q?Ukypd+OYqaJ+a8RUgLuwN/nBe0pRwfELY0n4BN8IKJes146+CpomVQEz71ja?=
 =?us-ascii?Q?GXX3rvMqm/UnjR91Px6fcIj5opxMpx7tb5yr+x4qxZXh5dCz8ntXWvTUMIt6?=
 =?us-ascii?Q?PSceWkbawZ/LLw3gqjqS9f0x3C5dD9AWnolWQlZkzerUeaHLJg27uNT33EJa?=
 =?us-ascii?Q?c2hUOgCFHtJe0mwHKfZc+jVqzhFoq4bElpEN5WecTYuvcbpbCu2bYhRgHAQX?=
 =?us-ascii?Q?DxrOh/BymEx20IJbKSrUzYncvy7I5ICfHKd8htG8Eay12YFqYrlTSu844Hst?=
 =?us-ascii?Q?/DpNV9tdeIerRBWfuieMKZAYvoHZrGoEm9U3dkqy9+E14XXqFJ6fmZCK/yH5?=
 =?us-ascii?Q?grJCv64477Fd4rGDFyQA9xnGrqVFy0v/lekR9lmTMXa+sA8W+/3kXe/wvNLG?=
 =?us-ascii?Q?HzDTYk2ITj/QC/Zl9rBGLiJEpStoyNIsxsDCYwAzN2+9eTRfaOfby41DquJJ?=
 =?us-ascii?Q?vnqBCoHPuYVB2TszQBQhALHkMnrB1jQqCrURXhbXBToY8/eq5tngRCzth83l?=
 =?us-ascii?Q?GuQknjfqgg7HhDcgwUaVF54=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8285e1e6-b17e-455c-e297-08ddde3ee44c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 10:06:25.8273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vd6Q2tnuYWX3NkfVe6uq+g8331ra2VVOjslAgfUNjv4HD22zZ3pScEiOWjPN9SBaFEkcGQ3xGLsWIm5xrvD7b2llHVJQr4T34sDGY7nNS6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9719
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

This pulls in multiple changes from the Linux kernel in order to keep
the code in sync. This also fixes octal mode support.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/spi/spi-mem.c | 13 +++---
 include/spi-mem.h     | 92 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3579b7d7db5..6f06650384c 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -120,18 +120,21 @@ static int spi_check_buswidth_req(struct spi_slave *slave, u8 buswidth, bool tx)
 		return 0;
 
 	case 2:
-		if ((tx && (mode & (SPI_TX_DUAL | SPI_TX_QUAD))) ||
-		    (!tx && (mode & (SPI_RX_DUAL | SPI_RX_QUAD))))
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
 
 	case 4:
-		if ((tx && (mode & SPI_TX_QUAD)) ||
-		    (!tx && (mode & SPI_RX_QUAD)))
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
 			return 0;
 
 		break;
+
 	case 8:
 		if ((tx && (mode & SPI_TX_OCTAL)) ||
 		    (!tx && (mode & SPI_RX_OCTAL)))
@@ -300,7 +303,7 @@ int spi_mem_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 		 * read path) and expect the core to use the regular SPI
 		 * interface in other cases.
 		 */
-		if (!ret || ret != -ENOTSUPP) {
+		if (!ret || (ret != -ENOTSUPP && ret != -EOPNOTSUPP)) {
 			spi_release_bus(slave);
 			return ret;
 		}
diff --git a/include/spi-mem.h b/include/spi-mem.h
index 2eb05a2e5bc..e68e2b50e85 100644
--- a/include/spi-mem.h
+++ b/include/spi-mem.h
@@ -17,16 +17,32 @@ struct udevice;
 
 #define SPI_MEM_OP_CMD(__opcode, __buswidth)			\
 	{							\
+		.nbytes = 1,					\
 		.buswidth = __buswidth,				\
 		.opcode = __opcode,				\
+	}
+
+#define SPI_MEM_DTR_OP_CMD(__opcode, __buswidth)		\
+	{							\
 		.nbytes = 1,					\
+		.opcode = __opcode,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.val = __val,					\
+	}
+
+#define SPI_MEM_DTR_OP_ADDR(__nbytes, __val, __buswidth)	\
 	{							\
 		.nbytes = __nbytes,				\
 		.val = __val,					\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_ADDR	{ }
@@ -37,22 +53,47 @@ struct udevice;
 		.buswidth = __buswidth,				\
 	}
 
+#define SPI_MEM_DTR_OP_DUMMY(__nbytes, __buswidth)		\
+	{							\
+		.nbytes = __nbytes,				\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_NO_DUMMY	{ }
 
 #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_IN,				\
+		.nbytes = __nbytes,				\
+		.buf.in = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_IN(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_IN,				\
 		.nbytes = __nbytes,				\
 		.buf.in = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
+	{							\
+		.buswidth = __buswidth,				\
+		.dir = SPI_MEM_DATA_OUT,			\
+		.nbytes = __nbytes,				\
+		.buf.out = __buf,				\
+	}
+
+#define SPI_MEM_DTR_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
 	{							\
 		.dir = SPI_MEM_DATA_OUT,			\
 		.nbytes = __nbytes,				\
 		.buf.out = __buf,				\
 		.buswidth = __buswidth,				\
+		.dtr = true,					\
 	}
 
 #define SPI_MEM_OP_NO_DATA	{ }
@@ -62,7 +103,7 @@ struct udevice;
  *			   transfer from the controller perspective
  * @SPI_MEM_NO_DATA: no data transferred
  * @SPI_MEM_DATA_IN: data coming from the SPI memory
- * @SPI_MEM_DATA_OUT: data sent the SPI memory
+ * @SPI_MEM_DATA_OUT: data sent to the SPI memory
  */
 enum spi_mem_data_dir {
 	SPI_MEM_NO_DATA,
@@ -70,6 +111,9 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+#define SPI_MEM_OP_MAX_FREQ(__freq)				\
+	.max_freq = __freq
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
@@ -80,26 +124,35 @@ enum spi_mem_data_dir {
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: whether the address should be sent in DTR mode or not
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
- * @addr.dtr: whether the address should be sent in DTR mode or not
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
+ * @data.ecc: whether error correction is required or not
+ * @data.swap16: whether the byte order of 16-bit words is swapped when read
+ *		 or written in Octal DTR mode compared to STR mode.
  * @data.dir: direction of the transfer
- * @data.buf.in: input buffer
- * @data.buf.out: output buffer
+ * @data.nbytes: number of data bytes to send/receive. Can be zero if the
+ *		 operation does not involve transferring data
+ * @data.buf.in: input buffer (must be DMA-able)
+ * @data.buf.out: output buffer (must be DMA-able)
+ * @max_freq: frequency limitation wrt this operation. 0 means there is no
+ *	      specific constraint and the highest achievable frequency can be
+ *	      attempted.
  */
 struct spi_mem_op {
 	struct {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u16 opcode;
 	} cmd;
 
@@ -107,6 +160,7 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 		u64 val;
 	} addr;
 
@@ -114,28 +168,35 @@ struct spi_mem_op {
 		u8 nbytes;
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 __pad : 7;
 	} dummy;
 
 	struct {
 		u8 buswidth;
 		u8 dtr : 1;
+		u8 ecc : 1;
+		u8 swap16 : 1;
+		u8 __pad : 5;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
-		/* buf.{in,out} must be DMA-able. */
 		union {
 			void *in;
 			const void *out;
 		} buf;
 	} data;
+
+	unsigned int max_freq;
 };
 
-#define SPI_MEM_OP(__cmd, __addr, __dummy, __data)		\
+#define SPI_MEM_OP(__cmd, __addr, __dummy, __data, ...)		\
 	{							\
 		.cmd = __cmd,					\
 		.addr = __addr,					\
 		.dummy = __dummy,				\
 		.data = __data,					\
+		__VA_ARGS__					\
 	}
+
 /**
  * struct spi_mem_dirmap_info - Direct mapping information
  * @op_tmpl: operation template that should be used by the direct mapping when
@@ -143,7 +204,7 @@ struct spi_mem_op {
  * @offset: absolute offset this direct mapping is pointing to
  * @length: length in byte of this direct mapping
  *
- * This information is used by the controller specific implementation to know
+ * These information are used by the controller specific implementation to know
  * the portion of memory that is directly mapped and the spi_mem_op that should
  * be used to access the device.
  * A direct mapping is only valid for one direction (read or write) and this
@@ -223,10 +284,12 @@ static inline void *spi_mem_get_drvdata(struct spi_mem *mem)
 /**
  * struct spi_controller_mem_ops - SPI memory operations
  * @adjust_op_size: shrink the data xfer of an operation to match controller's
- *		    limitations (can be alignment of max RX/TX size
+ *		    limitations (can be alignment or max RX/TX size
  *		    limitations)
  * @supports_op: check if an operation is supported by the controller
  * @exec_op: execute a SPI memory operation
+ *           not all driver provides supports_op(), so it can return -EOPNOTSUPP
+ *           if the op is not supported by the driver/controller
  * @dirmap_create: create a direct mapping descriptor that can later be used to
  *		   access the memory device. This method is optional
  * @dirmap_destroy: destroy a memory descriptor previous created by
@@ -300,13 +363,16 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 					  const struct spi_mem_op *op,
 					  struct sg_table *sg);
+
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op);
 #else
 static inline int
 spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
 				   const struct spi_mem_op *op,
 				   struct sg_table *sg)
 {
-	return -ENOSYS;
+	return -ENOTSUPP;
 }
 
 static inline void
@@ -315,6 +381,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 				     struct sg_table *sg)
 {
 }
+
+static inline
+bool spi_mem_default_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	return false;
+}
 #endif /* CONFIG_SPI_MEM */
 #endif /* __UBOOT__ */
 
@@ -337,7 +410,6 @@ ssize_t spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
 			    u64 offs, size_t len, void *buf);
 ssize_t spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
 			     u64 offs, size_t len, const void *buf);
-
 #ifndef __UBOOT__
 int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 				       struct module *owner);
-- 
2.50.1

