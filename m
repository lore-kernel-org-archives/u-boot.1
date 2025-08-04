Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F50C87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 22:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 219DD8403E;
	Tue,  5 Aug 2025 00:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="n5iCKoyp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007718403F; Tue,  5 Aug 2025 00:11:46 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 526BC84033
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 00:11:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otW4YJPaunKoORMLt8d3o5AYmnl4fkLzOPOMHoxa6jG0js+TKIpItvLQdVqrs/4QP3K7T/k9lEHNzt24/MTf3Sjfue3S4f9TcwwxCGTm5apm8uQz5e6mGVTyf9BKT0I3tt/hoaUBcTAMVCIbTf954wjxh2hsO+wrihHBddy72wT7Uemj9FstAX+b+6bHR3Ni2ZT8Epi9mxN2/saPJ5mgdACZn4TrVeQaTCPOKQmztRK5//d2ZTgSwrHJGTyxsea90mfO02s2EVLIZBHf3mQw5Ln3V9Fioy6TtEliG3q7pZVuYxDjgEerKPy54MOl9AWwEjiia1XV2zlXqZuX6O+Ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=ACLlgMa1V/2RYbb4k6dvJdT8AqwuYHCSND3sCKXsd8pOB3TpED7q6safhxHbbKX0aNz4verikPo6UJG/hRJemR4T/hbw2pBqqiaiTfdUQ2BqOornurkhfV9RUx4KvXsVYYSFbw3ouMcDpHzkVYaatyZTJnPXj26ytRdtb40jjNLK2hhF8mlJJhWtL8MW50GJjFlbIMCsDlNi54B/DFrQSpb/Y8KN9f/BllJzsfNCa7Onxu4QhLac+9XjQZLtsgXXMZY+3FibpeLl9yPtc6hZ6Nce/Qz8s0pj+eiuXCWR5Z7G+KIlfS58DDn/WgVKyg41tdi9x/NJuisRHPuYD2YDRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOAGeAbfzrc0hWT1l0NCFo084eRstuMdeXG85XY3aqk=;
 b=n5iCKoypVfQjrtDJ06965bpkgX5/rJoyM5ySHFqSbhuTDoOa3wiOAp59wj8Z+pRJYKKV8FHGVdBCu6Vd++Hxsn5J/fmjgNBawdLFvC/FpT/B4S/xFE6sae11PEcgmBsJEOBN1qZlrbIkZqZFftPR9zjhc2iI+M1uC+8YMryRtVqeEfxw6OsdKqB34oqNcebne8TtBXAuCF8cBGe7kjnGEhw3wrklfWRFiXExpAyi2ebw23TBn/qqsjdFGs3swRe2y6QSr7ADm8rEmDlT82NKG7rlgidsx53tQ1wT9ppT1eve4xOOJVGpnrzScFzMcbWfctJXLd+s461U99M1gOpjZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB7771.eurprd08.prod.outlook.com (2603:10a6:10:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 22:11:40 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 22:11:40 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 07/22] drivers: mtd: spi-nand: replace enable_ecc variable
 with disable_ecc and update corresponding logic
Date: Tue,  5 Aug 2025 01:11:07 +0300
Message-ID: <20250804221122.1420516-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804221122.1420516-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0144.eurprd05.prod.outlook.com
 (2603:10a6:7:28::31) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d96548-6c56-4958-ec8b-08ddd3a3e31a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tsGuHILoVKqwn8Dyek6zKz2sNWk93gMoP/lPK9hvw58Ktrdoyz8GmYRRGSsK?=
 =?us-ascii?Q?ryQc+cVZUkrG3krtJ/j0xrL+idsGg7g6sWafUkCl5Aw2NjWbJFvzX2xLV0Jk?=
 =?us-ascii?Q?ljnQtBfE2oHxPa8W/8cSVDv6caDUDIkR6o93FvwjwRMxBi8YEk0c+Yp9TOU6?=
 =?us-ascii?Q?IBN6+D+V3mAfxpBg0OIVlfKxLdnl0KHuthNvi9a6nDS/nmfWLOblzUNqamEe?=
 =?us-ascii?Q?dGHlPNBGkLkVQ+xr1AdfiYqNACP4TQnTVZQi7nZLsbchm0DZneh9vAdkxUre?=
 =?us-ascii?Q?/e1wBb6hev1zaANNTHefpfuyjnMB+3znt/3R+nFQ+OQrMu8fVPXfeSPWdIXE?=
 =?us-ascii?Q?jXfAZrvMvuQTojSRjAo8HVUfDqnpSG+65mcO+cfxVyQrMFwvLjSD+mDV65nt?=
 =?us-ascii?Q?+y/cdKrBoR1NDpagTB0YtZ3u6JqlJWP4AA8KtCUJzR51nK1qPwjWz+LPJQnJ?=
 =?us-ascii?Q?HbvKw8QQIHm5rZaI0iiudNOHtoGZa/Su22eWy46YAnQSaGfZm4hH/baw86EF?=
 =?us-ascii?Q?gH3OxpLEY+vqI6xdEL25JpYg2dkV0iXJPIKAxX4BGASYlY5vkSjmtPtz0iHW?=
 =?us-ascii?Q?uWanb/xJAgzMpQgfFb1vLT9RdhLX3yorMb0eKiVhMHj1V1xlvUw6BUWf0M3l?=
 =?us-ascii?Q?aAVKoKZ1wZWlJGD7Mj6QcU/TKBseb78mTNfhLMB4irUxk6VJBTDWDNuCyG5i?=
 =?us-ascii?Q?NalqwZoEfVZYahxUNAL52V2/c99TkIvhbJ0cWf/d3pBYDhXJXalSJoqCsCjZ?=
 =?us-ascii?Q?phJ37kv1ZAyrbNeFNQWy+jY1vPnI0h+t/5tJq31EJfAW45l4RRvbmfN7HqD9?=
 =?us-ascii?Q?qQr1z/+EkBQz6D2uDxUsoUb4N15J/PBbm9fYO9XcbmjP4R5R3zPkWmx1FQLY?=
 =?us-ascii?Q?JoYLQyJkqvcBTwkzZ5SpLBIkZCB0ubxVwMkicS6QjVT744oG4x31pCEOx0RL?=
 =?us-ascii?Q?cKhWn3cZClaEN60s9MQUqaFwtRZtJV1Xovx4RZbtCnys+wiv+y7S28jiK7OY?=
 =?us-ascii?Q?/I5p+lW+Cgiav/qKfwepfyKDNK1kClOLGzKY34bil4kSm3aG5zpQ79nEeI7f?=
 =?us-ascii?Q?TiDzSpBJ5+egjqN4GwGa5qBQN1hrjnmK4WxOa1XHv6XgvSniLo5dHx9NKoc+?=
 =?us-ascii?Q?cSu9ZhrKzhF/OU6RVQr/g3KFzmVrhBT4zhp6iwpmIJR169mcdbvW9mvLLgKS?=
 =?us-ascii?Q?u1nAGUgDkDnOKwReVetup3AvldMYARkHzT/u1LQ1JIbL0cvVeDZZd80qHGJU?=
 =?us-ascii?Q?buSOFcGYogvXjr7+256DhBJiQ1soHSUeg1QFie5I8jNeQ6PHlQlZpbgNiBjx?=
 =?us-ascii?Q?iH2ZqOUszPNqZbzF87yMa5DkiyrVpGacmsN4gTXKrsSMVaJvAUeapGa5EQTb?=
 =?us-ascii?Q?Yh209uq8lhGM0RVtcmgszfQFdE6iWSEWNxlHAVJoA86s2FcJlrkVyPf746Zb?=
 =?us-ascii?Q?3uydRislhRvC9tFHYnIKANVsUcxsmhWY57sB19fpKKPnr+lArI4bClUiXvfv?=
 =?us-ascii?Q?HojFjnjInLA2lyA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WR7Yc0lh9IN3QWtM4Sw+l8HvfLYnmt2v1aChXTklveIIyrdujY3E/HMObqBY?=
 =?us-ascii?Q?ULl5nL1PA4uyszkyQGDfTlav5DVMFSyEaqVa8fYZVodjUhmX/oDQMGCMB6pj?=
 =?us-ascii?Q?biXJjGuLMu47qqSt0nghUJmtfU8FahRJhsCf1azNuNOBFVi/OYKM1qrlWffc?=
 =?us-ascii?Q?a7hsT8ZW25df0GGppFNTKTeyb7YiymJfdm7Q1fmcGYDFurxRV/BxHrj8qCG0?=
 =?us-ascii?Q?onx0pWy89hA4pBxZfLBd8xKncW/HL9lu6b27rvG8oerH/2CWwTT7t3JLKAdI?=
 =?us-ascii?Q?EVJ8g0A1zKpjZancY6ckYr+T8JE5q+Oo+BUiJ5f4+9MNDDaGgCGMzHWjJKBA?=
 =?us-ascii?Q?YbSssIhJr/9WFFgx74ReX+WJEWxmw7gXlN2XBfuFGXaUWhiz3gB7NphcHjxJ?=
 =?us-ascii?Q?Ws0HTqQEyEjqCNLnBa3oNfriik6FATwHEBlG1luaqxPALA9lDEQQNfpDnOJr?=
 =?us-ascii?Q?GNjOxzRvnTRzicq5Yw7uH8UioxCalg1R/CNIR+3K61dcZdWcCiZ1Bcck1C/I?=
 =?us-ascii?Q?Yr4/Ich9hKJAd1DgtsxK0ahNeMtHp5LC6us7v6dWiphBCOhfvgLTyhWWwhj4?=
 =?us-ascii?Q?pueTdkYYgh+kwhUYZ0/b+LKOfXw3N/kiqdtz7+To2pRaYxPK5NejLkKiTq0Y?=
 =?us-ascii?Q?YuQ0MsQaw5+IxMbDthYLXnwScdRfIhiDUnqx5NFev3RLuBjoQjjcZ8aEDT1E?=
 =?us-ascii?Q?ZUIwavzowdUnUZMLL8i0GS3rQ7hGinxJfLe96BNB/swRlJjHEj+okHOeDmKZ?=
 =?us-ascii?Q?sdbVpawDi6zDqaPE44G8A1UXtwNjHYgsgwz0CKDk8BpupsAMIEpCTuCg/5pn?=
 =?us-ascii?Q?MPiKQVefe0r9ctP3cD1wFaoMY0bnBwK1cFgcD+CskiKp/WXud34RN+6IW8c0?=
 =?us-ascii?Q?lv13N8x1tLxCDavFexWWE9sHJ+epAdTN7GensDXEzQAxEjTNBR7ml13aJLva?=
 =?us-ascii?Q?2wS/nyy+46cLmIfyY2FtR4SDoaqZti1bBCnTglKLG2PZoAofN+5oiFYi4/ce?=
 =?us-ascii?Q?VK5KlkMNfeJPp5gRHHQh4XExdUKL4x/27Ds3H4va6bH12RXiJREUJkAHPyQX?=
 =?us-ascii?Q?7mBKtD9Qubk2HBATM7J6Wnla2Gx3RiIUavYb6HvY6S7TMJlOCHej2dARXIl4?=
 =?us-ascii?Q?83CQpdJYb13kT3G3nKjBlcyfM0F6FHknHdrzJZsEKiRv/Ac/VMrVSo1exH1Q?=
 =?us-ascii?Q?HLsHvnIo3/U4vgZhaTTtk23P3Qm0HrmOg0cPv/LykiwxkJ6SnnU7ygtbqTq3?=
 =?us-ascii?Q?VootOxE/hyY9257m96jLBpW13cS5Gzz9bTf84PgAtt9Mbp/MH7R5ctA05ikQ?=
 =?us-ascii?Q?eEP4LPuOnzokJ1CXUTcYdKRpx8BtNAsZK5q9iQSuHhLQ5E80yRaXCZxC2xuZ?=
 =?us-ascii?Q?KxKGoaolqSD+JK6jYSvbjzkImNZBWblB1UuzblMoVsrTvzxqselKb2vm42gR?=
 =?us-ascii?Q?9ozBMiMplLQo0PUla7Q6DDalAsu4R/2ftk4HH8qkchMl17QvATJj6Ca3OQ2T?=
 =?us-ascii?Q?3+icxDkcw7kEGmD7wU77ynwGMKjz3KxafGw5wndCmd2FcHZUQv/R9+4VnHwG?=
 =?us-ascii?Q?x1zEXcZH4+kmHRXZyWjLSl+eWkYBPfmF+yZ8QBuc7w2vroE1IWEFNETqzCRC?=
 =?us-ascii?Q?/A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d96548-6c56-4958-ec8b-08ddd3a3e31a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 22:11:40.1626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: veii+rhw+BX+DGf07eCbV4tlzVJN63U2jNKKKFMlgW7nrM0pMxjEip2eXYUnISAhY4yJtmaZbXFTE6M8HFLpJLJZzWJ5zF04vh7NptXw+JM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7771
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

This makes code closer to linux driver.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index c16d3954245..098ed0c4cd2 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	bool ecc_failed = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
+		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
 		if (ret < 0 && ret != -EBADMSG)
 			break;
 
@@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
 	struct nand_io_iter iter;
-	bool enable_ecc = false;
+	bool disable_ecc = false;
 	int ret = 0;
 
-	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
-		enable_ecc = true;
+	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
+		disable_ecc = true;
 
 #ifndef __UBOOT__
 	mutex_lock(&spinand->lock);
@@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
 
 	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
 		schedule();
+		if (disable_ecc)
+			iter.req.mode = MTD_OPS_RAW;
+
 		ret = spinand_select_target(spinand, iter.req.pos.target);
 		if (ret)
 			break;
 
-		ret = spinand_ecc_enable(spinand, enable_ecc);
+		ret = spinand_ecc_enable(spinand, !disable_ecc);
 		if (ret)
 			break;
 
-- 
2.47.2

