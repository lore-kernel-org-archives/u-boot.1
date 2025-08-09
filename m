Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22736C87FDA
	for <u-boot@archiver.kernel.org>; Sat,  9 Aug 2025 01:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A00F847A3;
	Sat,  9 Aug 2025 03:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="jvD2hz4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 015B6846A8; Sat,  9 Aug 2025 03:05:14 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DBA846D5
 for <u-boot@lists.denx.de>; Sat,  9 Aug 2025 03:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMxM1vM2dAvBEZggOkZF1w4tpSauZhra0EXDen/z/Xw1C6h3R17miw/rI95D9RPHBlUG9IbSi3ZvnL3PV+Pg+hESmSYsC1yIiS0keGXfFjffNE5Mh+dmVsLOTyWZSwPLM6pIpyd80gzddQ4YkZfoBYKj4EQWZhop+c+0y7eYZok/Pp6ppxzy9BudUiEoTB0+N3AH8gXKFjFPQXDyBCzAE+V9DeQmN4AJeeRlwYrP5RI8W7BbrR6gyPh5Lxa3mojhEMOdYsDH/JgGe62/GNf0Tmx0PCmyRIOh4qKpuylJ0tfpvUJfkyAonVsP66fkEEg6DXYHCKHwI37gW7VXy1AOig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=NfbJkRjnnicUCIZMzkXB0mjc0R4rzAFuQ7kdjKP0fOaida+38GruzhCc841v7SjD/LNI2uvMhy+HnrnTECFYBuYhyUERFgSjeugFpk16cVbNGAVo++9tJgAnc/ZzyajMbyvujn8QcGW7aJHfRw8E+NL1he+ymizLV2s5gUKS3ff3WJr1tLvuzVZwc55IZaWyU3ZAtPCL9DmH7zVJuMk+vzqYG6qUM9ET7LYbOxsDZHRUM4Zw7f2Sv/Dvl7iKffAM/HQlEyGh2dmjfShmQt58qD47Dm/IwAl9WdOTkJi6OexwV72f9JB0VDyO8CX+JmIoySJgbzE7wd7QGFgYegww0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yCVnnqecEyf0tV+hyWHeobdIFe1VF1Wq/nrZLk23tgc=;
 b=jvD2hz4WvYc0N/+eD0hhf9KpVTli03imGMAlZSCPCAxhnYy5IF5r/Rg0i3t+1wMLgiGpM8ICT9Lx1Tv+u1oy0Ar/CKDv1tg12Gkoceh3UV7Icl4kYrPSBdADBpvKYZ+5oxH000TCVmYBlMJIO99mXI6Of1VMI6oPfMSGMHDmtWuH8mJa1B+BsuET4Olwil9ATRpwOAoM3sonVS6j1yzXGeQBFWMjLfrjJwfRU1OdmZ5wHUWv6ZmmFy5xdhrMNynYASYQO06dJ5EbsHPGRA3TwnjgKeMCSTjJPn0fJ0N9S2gQJUtqf3+zi4Ih7WgLr4DpC9Wsoy9sPyaa71gJ+TACbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB4PR08MB9861.eurprd08.prod.outlook.com (2603:10a6:10:3f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Sat, 9 Aug
 2025 01:05:06 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Sat, 9 Aug 2025
 01:05:06 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 01/24] spi-mem: sync a bit with linux-6.16
Date: Sat,  9 Aug 2025 04:04:33 +0300
Message-ID: <20250809010457.3125925-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::29) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB4PR08MB9861:EE_
X-MS-Office365-Filtering-Correlation-Id: 793f63d6-285e-48e6-a901-08ddd6e0c732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zGSpG8usVM9NHwpeGUZBqw8unoVakNGy4TaMfFu3G7F8b3YDiEMotGzomCH9?=
 =?us-ascii?Q?Nwhyz9DiQ/EdmKU6GT+k2uCozLu9hZRjPOMeIAG/s637AzpOR5I4MQ92+Mgg?=
 =?us-ascii?Q?jYnI/2dTZESHjlzUPI4Ow62auU180N9ObgNfYNl4lB5ZOyP43/wrLeCXZpUF?=
 =?us-ascii?Q?+rsbFovXGuHMCuLC6TG/MffdsgNg45urbAxhvkpeCzvAipcEEJIb8vq9Kla0?=
 =?us-ascii?Q?ch7WmAWrX8gfFPWo5Vwe9FWoj69K9LI1hTYpBSfM5sETLOGOlcYCXLwKLwDF?=
 =?us-ascii?Q?Wd9bR1dwvTkYhbg/9mHN1WizyQBiV5EkPlEn9uDF7KS2aElJkDuXJsNyRIrb?=
 =?us-ascii?Q?03lKasbtqALRCfwrPapnmkTZekzmo4eOcggC5eoYZSuYjf4ckGmFdFPZeXHK?=
 =?us-ascii?Q?pcqED9k1tivP7MTJngUU6Jis4naqeFytqeM/aeIZ0tbiQkmTdQDii1TQb9CU?=
 =?us-ascii?Q?eqHJ2l7lkvBbELxJbT85DcCZjaaCiFtj152m1c+0rPEWWrxFbiHo+AGqnJXG?=
 =?us-ascii?Q?jezJUg2/t4BS/r2gtMzSdmVa/ycjSUN9RKDflONMtFMkOzs1nsuQ9LJn0Ymt?=
 =?us-ascii?Q?TOmhHlH1wqyompUgN6ZO98d6jUPq/pYa0z5YC6yAlxZyqxIX0NDoL+/lw6RQ?=
 =?us-ascii?Q?5chsWM5Oo16M/3nqbTqIstXytz6j8duXoQZ2szxLWnY8EJw0vTTFRDA+khko?=
 =?us-ascii?Q?WVlUd0PlwE3Aza+/mANUeXKgxMc4o0of8Vzq2Xr2DzSYm7+L2nZf00sDaJyE?=
 =?us-ascii?Q?qH9K91EQIzA/4ogEm5jOsV+BvQUSWTzOHOeBpNZXostArMMUWAMjCVOqh/AP?=
 =?us-ascii?Q?Nl/2fitDqrhYIfVZScrSfMsYfTQPolLrWQZxt2hm8g3IeUnTzExOrG1CY48H?=
 =?us-ascii?Q?hQok/qwzOhcgQfC2k338yU0683GTdC9W4izA9izyuGwBEAIsWwTLoFtETEjL?=
 =?us-ascii?Q?VEQviXaeGCbijSRcgTqUKIyvExf7ZeBLJgV5Tn8HouSx8xfnZMN1TaHb0o2n?=
 =?us-ascii?Q?o6wynby/J2oZiXCM0eig+Kw0rRzxeyYBjNuXhwZ5s105uEXQ/Tp3JEANwxTB?=
 =?us-ascii?Q?3UJC1g8OA3FHHmoV7XdgJ76nQha7cpG1GNx0WGTi6G6md8EO3fe6ZK2tcwi9?=
 =?us-ascii?Q?ahwWPVFtfXqXkBq4hr3tKj2hrEJmluCpPSCOjRq64uNqSZXaWi0eM1mEvqrW?=
 =?us-ascii?Q?uBlwhxPqXKrdID1LhoQWeakTGgqh4iPU+Qr8yQzJZ3YeMFxeuwtCNN0b71+o?=
 =?us-ascii?Q?e0wsaOhvonK+JjqpT3Xo6h4zwcq+MCuqTB1t1254QuwANU1kCc5zLNxNk5+y?=
 =?us-ascii?Q?bPeMtIQFIkX5jXytChZ9lu+aqPJVBIAot9Jc9ZfDCBkNSKdlByjMtvGxM8AJ?=
 =?us-ascii?Q?Jej8nYxYYJDtIni4LE5i0e30j2pFAYtyJFv0OoeNuC1RIGa7ZbKtnscdzff7?=
 =?us-ascii?Q?Of5ZnfTV9jaXKmibUc6Pye6QLGnEcPm5uJWYk65o0EoeWQDQDSVzsudv97mf?=
 =?us-ascii?Q?27rJkQLXcqzmi88=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AVCUBDKbPKTpTOy7Pnez6Hnf/WF9U1U0hBKFfOhrrYln4UUuLTPt5R7cnphd?=
 =?us-ascii?Q?pd+FxxmqyB3t9l26EwutcK2JgS2CffSwyq/q36XlccyCSsNh80hNoLEzji5J?=
 =?us-ascii?Q?4BrkVd7vaoX2eXvkDZBxNORapYKC59T8wO68cW0cdKHuMyMzyb9htW5E1s3I?=
 =?us-ascii?Q?9RlA1AfrhwjjtgFN6+/5JJ4yxT8rLqve9KneK/JP6D98RlhBke38/v6HMtPT?=
 =?us-ascii?Q?nJybpyTTMIZEb/WtJUaQUnaWrFCD1Zh0frDuYDIQr/SwSLP6qg0ULETKOGKh?=
 =?us-ascii?Q?FFXRuQZV4o2j0OHT2hOnO8qWp37ZiBiEYS8WTwwptZT6TJkZ41lVJoV6Q2uL?=
 =?us-ascii?Q?O3CY0dNNZnK9yO4F74KBCaeXKsKMW/1uN1KjnBGlzNXpncBCNhROLuaUWQ/O?=
 =?us-ascii?Q?edGqQ3zMoAIjBNwek6x2d2QV9QOInGAx5pO8dFnJiLo08hxGGai9PKasXfci?=
 =?us-ascii?Q?WhyDeYZnjrqYx6RAtt5DN1iVagMRT9VYhavjRghOlsjF67Pvwnr9AH/f7kir?=
 =?us-ascii?Q?ehzj+WGFV+ZolJDgO0SHC1uszImhkekA0hL5LiAxourWOldm1MLukIJwrwV+?=
 =?us-ascii?Q?WxLU7JX6Sc1EOQUSCUyQE4rhx0dKpHHr9DXq7hXpK3dsC5stBD/sqFyYlP7p?=
 =?us-ascii?Q?KMLohm3qBnN3QthcSZp4bpm67YCOSt20D/SkjoUei1RnFm9CmDbi7fO2ONhI?=
 =?us-ascii?Q?eH7BGP/FhXfWJesKExGFB/WmZoGhAjCx74UoC1Ywe6MZUoBPWDorEJxiT3B6?=
 =?us-ascii?Q?NAId5ArqijUTCeTx1D5Ym4pm0BGvAOuxjQl28Malbqd1VIVZmbAAZFVcGGNz?=
 =?us-ascii?Q?C1GgoWzzhKIe5E3Yt+C9qZuBIF+KfEZthxHEewx5jpWXvkV/OVoZ7hxCB8vb?=
 =?us-ascii?Q?U+bqEUkzUGdDFaE5VKeBZSaIh5ssnKqdp7VFRRXcD3MKXaRPXhTv6g3pWqE4?=
 =?us-ascii?Q?eXohMbT4L/O5nWI6fBnKF7+woBDvKtTSCK+yANRFwvjoJPS3rZEOx8A9WmIz?=
 =?us-ascii?Q?frxyOvm5KcneDLqNX8IirIt45Q+7zPY5IZHXcKePJjKqn1gLaVwUyVVQX2ho?=
 =?us-ascii?Q?Y14+0SOTTp3k68sWI+NHDS0XjC7I8u3FNAYiARHYbtEWCMm9hcBlCpTLjZKw?=
 =?us-ascii?Q?5hKfQ2bCiFX5DxdYqdHbc0uNHf6Vt7WtUip5xsWkjtwErknFH7RQRpY8kU1M?=
 =?us-ascii?Q?Hp6+XoL3o1PW3fWCsGy4K9arfOsZrNnL7coWpwV3Xbw8na9s9+pBawfZBVIa?=
 =?us-ascii?Q?pcFQxtciPMXQmin+K3mQwUBMcFiy97B8Liy+DTUuafBkryDxa1WqsDWJf7OB?=
 =?us-ascii?Q?Lr73pkcE0zkWy0x5cpJOfzjPgIVKMlYVtNI+Gac8MIhv1YY1TuLbYrcI2uae?=
 =?us-ascii?Q?9U6Nb3nuahACr18psFftFwyPvAPJ3ZXCHUn5YG8bANgUAB6ilA+k4k14gSbw?=
 =?us-ascii?Q?7VD/2ME2XpMJgdEMAPPnfAmINwcdt9oUL7KTefaIR2a26wD3vfjvtJcLV1iO?=
 =?us-ascii?Q?MjgZWLq8Sx0dJ91odhC+6L0Bfji93uIrFaMmV18r32NmLb50BdRXtzRZMGXX?=
 =?us-ascii?Q?gL/0tfpZucDgS+PedaxDiIrUVqGHjDhYQiM9uu0PVbgaj0njJS7G7DF8TuE6?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 793f63d6-285e-48e6-a901-08ddd6e0c732
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 01:05:06.1126 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGF57Km844+zSgW9xSMBfEyBGz9398OaSAPVZbVZ+fpuQvusevKHotjLStQmxMmg/eK+GuJmqcQLFgrs+mXZ3sg3IfnRGsXedA/k9tlTUJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9861
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

This also fix 8-wire support a bit.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
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
2.47.2

